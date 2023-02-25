# build environment
FROM node:alpine as builder
WORKDIR /app
COPY . .
RUN yarn --ignore-platform
RUN yarn build

# running environment
FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]