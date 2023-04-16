#!/bin/bash

api="https://api.hotali.shop"
sign=null
vk_user_id=null
vk_ts=null
vk_ref=null
user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36"

function authenticate() {
	# 1 - sign: (string): <sign>
	# 2 - vk_user_id: (integer): <vk_user_id>
	# 3 - vk_ts: (integer): <vk_ts>
	# 4 - vk_ref: (string): <vk_ref>
	# 5 - access_token_settings: (string): <access_token_settings - default: >
	# 6 - are_notifications_enabled: (integer): <are_notifications_enabled: default: 0>
	# 7 - is_app_user: (integer): <is_app_user - default: 0>
	# 8 - is_favorite: (integer): <is_favorite - default: 0>
	# 9 - language: (string): <language - default: ru>
	# 10 - platform: (string): <platform - default: desktop_web>
	sign=$1
	vk_user_id=$2
	vk_ts=$3
	vk_ref=$4
	params="vk_access_token_settings=${5:-}&vk_app_id=8154948&vk_are_notifications_enabled=${6:-0}&vk_is_app_user=${7:-0}&vk_is_favorite=${8:-0}&vk_language=${9:-ru}&vk_platform=${10:-desktop_web}&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$vk_user_id&sign=$sign"
}

function get_profile() {
	curl --request GET \
		--url "$api/profile" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}

function get_products() {
	# 1 - query: (string): <query>
	# 2 - limit: (integer): <limit - default: 10>
	# 3 - offset: (integer): <offset - default: 0>
	# 4 - sort_method: (string): <sort_method - default: id>
	# 5 - sort_type: (string): <sort_type - default: desc>
	curl --request GET \
		--url "$api/products?query=$1&limit=${2:-10}&offset=${3:-0}&sort_method=${4:-id}&sort_type=${5:-desc}" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}

function get_wall() {
	curl --request GET \
		--url "$api/wall" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}

function get_favorites() {
	# 1 - limit: (integer): <limit - default: 25>
	# 2 - offset: (integer): <offset - default: 0>
	curl --request GET \
		--url "$api/favorites?&limit=${1:-25}&offset=${2:-0}" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}

function get_withdraw() {
	curl --request GET \
		--url "$api/withdraw" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}

function review_product() {
	# 1 - product_id: (integer): <product_id>
	curl --request GET \
		--url "$api/reviews/$1" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}

function get_product_info() {
	# 1 - product_id: (integer): <product_id>
	curl --request GET \
		--url "$api/products/$1" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}

function add_favorite() {
	# 1 - product_id: (integer): <product_id>
	curl --request POST \
		--url "$api/favorites/$1" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}

function delete_favorite() {
	# 1 - product_id: (integer): <product_id>
	curl --request DELETE \
		--url "$api/favorites/$1" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}

function get_category_products() {
	# 1 - category_id: (integer): <category_id>
	# 2 - limit: (integer): <limit - default: 25>
	# 3 - offset: (integer): <offset - default: 0>
	curl --request GET \
		--url "$api/categories/$1?&limit=${2:-25}&offset=${3:-0}" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $params"
}
