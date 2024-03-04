Return-Path: <linux-kernel+bounces-91373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B81D871043
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A324828265C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924C7BB02;
	Mon,  4 Mar 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="cn+QkZD/"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28711E542
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592316; cv=none; b=LxOYV2yMspMNDtlbvH6q1EKcgBa+29+uFRPEdOmZRVdA6dblLRFEdCYv1KOUaLKDrq+anFBzNs5wRPliESgJvdYa+J7QR4A8Ly9UsCl8JpkPeBuEPgrRsjp/bPTaW0g4nRqj6BAxbL0sdUBAVWcz72G1j8L11Cd/ANlH9u4Ysn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592316; c=relaxed/simple;
	bh=aC9J5h9TG1g5IlvTC2gEyvKkILLxaS4dqt9nGLZmBdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBAL2F8/DPVqf/Q/liqZo5rQMYeQ/go3ahM2wjWDkS/SDdKuLIUU4415wRyXO7t5pr9ivuIEe/exGtU2WBxXI5SaCrb+mfFsS1RR1gTBpHA89Tl5Rt3nA+b+AT2dqnV6u+CjWzBRqbz4zLrA55zmuogfay1AZMPgkx7zYi5WRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=cn+QkZD/; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e4e673d9abso42368a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1709592313; x=1710197113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+Fxv005Bljtv9CpGZILYWj6yRL9ebRsbwfnTT4ObqE=;
        b=cn+QkZD/1OeIqzGuV6XN10fTGS7EtCqzxePZa+JP0YDuKfLSpEmd1mD6znZv0Il8cm
         Gfoh6NsYgFrKbj/0Lu0VF43ZW6R/5nlJo+BLy+muKboKqsmdzLnS0E1wfzR3baET2oUJ
         4Np/q/c5MIN+UfgGQIZx1FcZ6GH/jD9Wq/pls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592313; x=1710197113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+Fxv005Bljtv9CpGZILYWj6yRL9ebRsbwfnTT4ObqE=;
        b=ij1/h0NkO+9zOcYuCxEj6aAhyQwqSjpwAFnhBpI+VpJ1NR84PQgqW1xZhWA6jslRfB
         UC6ggvhTIuD4DtUg4lAMvdVf8PgHusiRDUDhacY3ose1+wfe1crYHCRxuzWmZP94fOGr
         o04V0UdfPk0Inyl8QZJT4qjSvkuhaUD8UuESq6ZbI++XXUURbqClyPFwZ3AsUAvjt6wr
         lpmTZzTH2Paj8Q4Yg7R+9zuDm3UWc+QYFgaOj5I4hzxFadJYtdqG2ljqoJpFTqlneYmA
         zeQ8oHg23T4ULKTS6GPYJ+Cu9Ld0WIV6ymvNWSz9P0KcJe2yGnxT4rEi1sFkTI/mPy/Z
         I9uw==
X-Forwarded-Encrypted: i=1; AJvYcCX/RIaLnXDFPx639rJa09NBvQXvnNtJq/jHVE172g6YpSVwcw4GRW+KGvM38eyiXMk5PmXQpnatbRZPTNfClDG7EQeu8IFN+CLwwWpZ
X-Gm-Message-State: AOJu0YwTO6qN3V4s40EkR5O9vIvq0boUpmX7ETLSkLYZ658Ls/rZZTDq
	3WGtMrnJK/vKgxMIyYj8X4V1xyUBZUWDeUEewn/DzebrMpv8UMmJxE9Pj7WQAw==
X-Google-Smtp-Source: AGHT+IHwFpkN8MnzJO8v6QzGjMV+EtaCgHqeSkH/AD/dlWy+PnCER9M9nGsXrm63fRhTRQTlFnF8dw==
X-Received: by 2002:a05:6870:64a6:b0:21f:dc71:c3f4 with SMTP id cz38-20020a05687064a600b0021fdc71c3f4mr64125oab.43.1709592313243;
        Mon, 04 Mar 2024 14:45:13 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id pi36-20020a05620a37a400b00787c0e4ac78sm4808087qkn.106.2024.03.04.14.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 14:45:12 -0800 (PST)
Message-ID: <1c5ab1e7-ac66-438c-bc49-0785810e9355@ieee.org>
Date: Mon, 4 Mar 2024 16:45:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] greybus: Avoid fake flexible array for response data
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Alex Elder <elder@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240304211940.it.083-kees@kernel.org>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240304211940.it.083-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 3:19 PM, Kees Cook wrote:
> FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
> code base has been converted to flexible arrays. In order to enforce
> the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
> destinations need to be handled. Instead of converting an empty struct
> into using a flexible array, just directly use a pointer without any
> additional indirection. Remove struct gb_bootrom_get_firmware_response
> and struct gb_fw_download_fetch_firmware_response.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for adding the comments!  This looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>



I want to call attention to a few other spots that should
get a little more attention--related directly to what you're
doing here.

I noticed that the GB_CONTROL_TYPE_GET_MANIFEST response
structure also contains only a flexible array.  It might
be good to add a similar comment in gb_interface_enable(),
above this line:
         manifest = kmalloc(size, GFP_KERNEL);
The definition of the gb_control_get_manifest_response structure
could probably be replaced with a comment.


The response buffer for an I2C transfer consists only of incoming
data.  There is already a comment in gb_i2c_operation_create()
that says this:
         /* Response consists only of incoming data */
The definition of the gb_i2c_transfer_response structure should
then go away, in favor of a comment saying this.

The response buffer for a SPI transfer consists only of incoming
data.  It is used three times in "driver/staging/greybus/spilib.c":
- calc_rx_xfer_size() subtracts the size of the response structure,
   and that should be replaced by a comment (and the structure
   definition should go away)
- gb_spi_decode_response() takes the response structure as an
   argument.  That could be replaced with a void pointer instead,
   with a comment.
- gb_spi_transfer_one_message() is what passes the response buffer
   to gb_spi_decode_response(), and could be adjusted to reflect
   that the response consists only of data--rather than a struct
   containing only a flexible array.


Kees:  I'm *not* asking you to deal with these, I'm just mentioning
them to you.  My comments above (without someone else confirming)
are not sufficient to dictate how to address these.

					-Alex


> ---
> Cc: Alex Elder <elder@kernel.org>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: greybus-dev@lists.linaro.org
> Cc: linux-staging@lists.linux.dev
>   v2: add comments about removed structs
>   v1: https://patchwork.kernel.org/project/linux-hardening/patch/20240216232824.work.862-kees@kernel.org/
> ---
>   drivers/staging/greybus/bootrom.c         | 8 ++++----
>   drivers/staging/greybus/fw-download.c     | 8 ++++----
>   include/linux/greybus/greybus_protocols.h | 8 ++------
>   3 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
> index 79581457c4af..c0d338db6b52 100644
> --- a/drivers/staging/greybus/bootrom.c
> +++ b/drivers/staging/greybus/bootrom.c
> @@ -243,10 +243,10 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>   	struct gb_bootrom *bootrom = gb_connection_get_data(op->connection);
>   	const struct firmware *fw;
>   	struct gb_bootrom_get_firmware_request *firmware_request;
> -	struct gb_bootrom_get_firmware_response *firmware_response;
>   	struct device *dev = &op->connection->bundle->dev;
>   	unsigned int offset, size;
>   	enum next_request_type next_request;
> +	u8 *firmware_response;
>   	int ret = 0;
>   
>   	/* Disable timeouts */
> @@ -280,15 +280,15 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>   		goto unlock;
>   	}
>   
> -	if (!gb_operation_response_alloc(op, sizeof(*firmware_response) + size,
> -					 GFP_KERNEL)) {
> +	/* gb_bootrom_get_firmware_response contains only a byte array */
> +	if (!gb_operation_response_alloc(op, size, GFP_KERNEL)) {
>   		dev_err(dev, "%s: error allocating response\n", __func__);
>   		ret = -ENOMEM;
>   		goto unlock;
>   	}
>   
>   	firmware_response = op->response->payload;
> -	memcpy(firmware_response->data, fw->data + offset, size);
> +	memcpy(firmware_response, fw->data + offset, size);
>   
>   	dev_dbg(dev, "responding with firmware (offs = %u, size = %u)\n",
>   		offset, size);
> diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
> index 543692c567f9..a06065fb0c5e 100644
> --- a/drivers/staging/greybus/fw-download.c
> +++ b/drivers/staging/greybus/fw-download.c
> @@ -271,11 +271,11 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
>   	struct gb_connection *connection = op->connection;
>   	struct fw_download *fw_download = gb_connection_get_data(connection);
>   	struct gb_fw_download_fetch_firmware_request *request;
> -	struct gb_fw_download_fetch_firmware_response *response;
>   	struct fw_request *fw_req;
>   	const struct firmware *fw;
>   	unsigned int offset, size;
>   	u8 firmware_id;
> +	u8 *response;
>   	int ret = 0;
>   
>   	if (op->request->payload_size != sizeof(*request)) {
> @@ -325,8 +325,8 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
>   		goto put_fw;
>   	}
>   
> -	if (!gb_operation_response_alloc(op, sizeof(*response) + size,
> -					 GFP_KERNEL)) {
> +	/* gb_fw_download_fetch_firmware_response contains only a byte array */
> +	if (!gb_operation_response_alloc(op, size, GFP_KERNEL)) {
>   		dev_err(fw_download->parent,
>   			"error allocating fetch firmware response\n");
>   		ret = -ENOMEM;
> @@ -334,7 +334,7 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
>   	}
>   
>   	response = op->response->payload;
> -	memcpy(response->data, fw->data + offset, size);
> +	memcpy(response, fw->data + offset, size);
>   
>   	dev_dbg(fw_download->parent,
>   		"responding with firmware (offs = %u, size = %u)\n", offset,
> diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
> index aeb8f9243545..820134b0105c 100644
> --- a/include/linux/greybus/greybus_protocols.h
> +++ b/include/linux/greybus/greybus_protocols.h
> @@ -232,9 +232,7 @@ struct gb_fw_download_fetch_firmware_request {
>   	__le32			size;
>   } __packed;
>   
> -struct gb_fw_download_fetch_firmware_response {
> -	__u8			data[0];
> -} __packed;
> +/* gb_fw_download_fetch_firmware_response contains no other data */
>   
>   /* firmware download release firmware request */
>   struct gb_fw_download_release_firmware_request {
> @@ -414,9 +412,7 @@ struct gb_bootrom_get_firmware_request {
>   	__le32			size;
>   } __packed;
>   
> -struct gb_bootrom_get_firmware_response {
> -	__u8			data[0];
> -} __packed;
> +/* gb_bootrom_get_firmware_response contains no other data */
>   
>   /* Bootrom protocol Ready to boot request */
>   struct gb_bootrom_ready_to_boot_request {


