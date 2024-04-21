Return-Path: <linux-kernel+bounces-152514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D988ABF9A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D423281979
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46D517BCE;
	Sun, 21 Apr 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="GaCq3jxH"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE335B64E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713709792; cv=none; b=FVhtmzveeyjlz2BnIBEwflyreUV5rsiHcrQQUVJT3WO2xaIelPeKEI0B6cLy4quDJ7N4NTiAYebg2i/lkHEXCkFqL+vRtzazut26XqhJEDhiE9LNFReIjQZJOFYcQ+8Q6ko+lVvxQcKUC+o7j/WSe8SeBgQJG7KMamW+pMbNfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713709792; c=relaxed/simple;
	bh=ZDF8wsNcQcH6GLOM6oSwZWK482FY0Az6eL6XDeob49I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHoaOsV79h1kBaOqOVas8Bmr0dXByN/2Y+w8f9sWSwkw8TSfT3BxNqNZTJYSPdkul/DqICtYLC3GfuWJOFr6F0VLo5RK3IfUpRIkrTV7jwSnr7KNTnjrLShsXz/cMdful2KeJlzhM4Bxl4ErllMWe3H0BJJ+Fj54EExbWkVSnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=GaCq3jxH; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b514d3cf4so30537986d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1713709789; x=1714314589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7LpaFZkm9Br//XCfOKkL+azQyEv5N/3dSKe15VqxQA=;
        b=GaCq3jxHDflVe5Bpai4h+sVPUa89SCvkvG6QaoDveOYdBAoVJbY9j8Q5lXZgoCNMWt
         FSgLjvzmtNrvkcRaLnXSSrdHexB3q5nqHKRvL/iPEM6HOFtTSPfcNIJPzOzAJe9hKSwP
         1XVPZ+tIQtbjQ5B9poPjgp8ITZSDTNNGOHlqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713709789; x=1714314589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7LpaFZkm9Br//XCfOKkL+azQyEv5N/3dSKe15VqxQA=;
        b=nIbNjeo+ZiB5UeEC98Fn0ADF6WrFtqT1DoXrVoQCgV3y2odmc3J7QN31jmIdU13rZH
         Vfci2S6UtW1dfDCa4n+aRSEjTtWyjHAERiWSiz84+CH4VVhUkC9wt5GazVOJ/3e3yIvA
         OXT0hrPu/DfWUxYPBT2WlLG4Je0s/fSylIGbr1Nvg81M9DBFRzIZCRArUKh0gRvTJSwU
         cfTOju9TZaVpjkmvq+gEUaNwVsHySat2O2Fta3Jfqky0KIYU3yN3ES3xajVstH9VxlCQ
         it1F1xPuSbFhxiNQ4M+BuwEo7EbVnKESN189LfF0ZmZGc6tsXjWGOV1kaCxeB7YNMPJd
         4meg==
X-Forwarded-Encrypted: i=1; AJvYcCWIAhlQj/IskpS5iL6iMzoCRHy0LiUTeboePEN+1WEFxM3ujj7AE0Xi7OcT8miWEJtbgzEApSCI9cv7unqADo6RJ1Al+eyMiwR2U+0i
X-Gm-Message-State: AOJu0Yyc5J3Cmt7CPDC5Rb0Cp1ORn0mlS+eRVjpRzbf+a4AtYTZn+SJ4
	H3XUXI98VxxENloqTTvYifGVY5pPgc4bf4vUl69HdUhkEfg46GJ18+4ZvggEqw==
X-Google-Smtp-Source: AGHT+IEmilFtFEm9HQytae3OkzVU9OlPlZM5Mw8kW3/pYBmDDShIjriimzBmd8hgLnud40PUVLIaZg==
X-Received: by 2002:ad4:4bb3:0:b0:6a0:6545:2306 with SMTP id i19-20020ad44bb3000000b006a065452306mr7041605qvw.28.1713709789526;
        Sun, 21 Apr 2024 07:29:49 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id u5-20020a0c8dc5000000b0069b412e3716sm2330418qvb.80.2024.04.21.07.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 07:29:48 -0700 (PDT)
Message-ID: <9ba1665e-70b0-4aea-9cab-b62660953f6b@ieee.org>
Date: Sun, 21 Apr 2024 09:29:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] staging: greybus: Replace gcam macros with direct dev
 log calls
Content-Language: en-US
To: Jackson Chui <jacksonchui.qwerty@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZhRzWNiak1qOdJLL@jc-ubuntu-dev-korn-1>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <ZhRzWNiak1qOdJLL@jc-ubuntu-dev-korn-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 5:44 PM, Jackson Chui wrote:
> Reported by checkpatch:
> 
> CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid
> precedence issues
> 
> Inline standard calls to 'dev_*' kernel logging functions, in favor
> of 'gcam_*' macros, to clear up gcam-related logging.
> 
> Signed-off-by: Jackson Chui <jacksonchui.qwerty@gmail.com>

This looks good, thanks for doing this.

Nit: for the future, on a few of the dev_err() calls, the new first
argument makes the line even wider than before.  Lines wider than
80 columns are acceptable--especially when they contain formatted
output--but you could have put the format string on a new line in
a few of the cases.  I'm old-skool and prefer making things fit
in 80 columns unless it gets too ugly.

Reviewed-by: Alex Elder <elder@linaro.org>


> 
> ---
> Changes in v2:
>    - Inline 'dev_*' logging functions, over wrappers and macros
>      to just use the standard call.
>    - Remove 'gcam_*' macros, since they are no longer used.
> ---
>   drivers/staging/greybus/camera.c | 58 +++++++++++++++-----------------
>   1 file changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index a8173aa3a995..b8b2bdfa59e5 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -180,10 +180,6 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
>   
>   #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
>   
> -#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
> -#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
> -#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
> -
>   static int gb_camera_operation_sync_flags(struct gb_connection *connection,
>   					  int type, unsigned int flags,
>   					  void *request, size_t request_size,
> @@ -232,8 +228,8 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
>   
>   		fmt_info = gb_camera_get_format_info(cfg->format);
>   		if (!fmt_info) {
> -			gcam_err(gcam, "unsupported greybus image format: %d\n",
> -				 cfg->format);
> +			dev_err(&gcam->bundle->dev, "unsupported greybus image format: %d\n",
> +				cfg->format);
>   			return -EIO;
>   		}
>   
> @@ -241,18 +237,18 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
>   			pkt_size = le32_to_cpu(cfg->max_pkt_size);
>   
>   			if (pkt_size == 0) {
> -				gcam_err(gcam,
> -					 "Stream %u: invalid zero maximum packet size\n",
> -					 i);
> +				dev_err(&gcam->bundle->dev,
> +					"Stream %u: invalid zero maximum packet size\n",
> +					i);
>   				return -EIO;
>   			}
>   		} else {
>   			pkt_size = le16_to_cpu(cfg->width) * fmt_info->bpp / 8;
>   
>   			if (pkt_size != le32_to_cpu(cfg->max_pkt_size)) {
> -				gcam_err(gcam,
> -					 "Stream %u: maximum packet size mismatch (%u/%u)\n",
> -					 i, pkt_size, cfg->max_pkt_size);
> +				dev_err(&gcam->bundle->dev,
> +					"Stream %u: maximum packet size mismatch (%u/%u)\n",
> +					i, pkt_size, cfg->max_pkt_size);
>   				return -EIO;
>   			}
>   		}
> @@ -275,13 +271,13 @@ static const int gb_camera_configure_streams_validate_response(struct gb_camera
>   
>   	/* Validate the returned response structure */
>   	if (resp->padding[0] || resp->padding[1]) {
> -		gcam_err(gcam, "response padding != 0\n");
> +		dev_err(&gcam->bundle->dev, "response padding != 0\n");
>   		return -EIO;
>   	}
>   
>   	if (resp->num_streams > nstreams) {
> -		gcam_err(gcam, "got #streams %u > request %u\n",
> -			 resp->num_streams, nstreams);
> +		dev_err(&gcam->bundle->dev, "got #streams %u > request %u\n",
> +			resp->num_streams, nstreams);
>   		return -EIO;
>   	}
>   
> @@ -289,7 +285,7 @@ static const int gb_camera_configure_streams_validate_response(struct gb_camera
>   		struct gb_camera_stream_config_response *cfg = &resp->config[i];
>   
>   		if (cfg->padding) {
> -			gcam_err(gcam, "stream #%u padding != 0\n", i);
> +			dev_err(&gcam->bundle->dev, "stream #%u padding != 0\n", i);
>   			return -EIO;
>   		}
>   	}
> @@ -340,16 +336,16 @@ static int gb_camera_set_power_mode(struct gb_camera *gcam, bool hs)
>   
>   	ret = gb_camera_set_intf_power_mode(gcam, intf->interface_id, hs);
>   	if (ret < 0) {
> -		gcam_err(gcam, "failed to set module interface to %s (%d)\n",
> -			 hs ? "HS" : "PWM", ret);
> +		dev_err(&gcam->bundle->dev, "failed to set module interface to %s (%d)\n",
> +			hs ? "HS" : "PWM", ret);
>   		return ret;
>   	}
>   
>   	ret = gb_camera_set_intf_power_mode(gcam, svc->ap_intf_id, hs);
>   	if (ret < 0) {
>   		gb_camera_set_intf_power_mode(gcam, intf->interface_id, !hs);
> -		gcam_err(gcam, "failed to set AP interface to %s (%d)\n",
> -			 hs ? "HS" : "PWM", ret);
> +		dev_err(&gcam->bundle->dev, "failed to set AP interface to %s (%d)\n",
> +			hs ? "HS" : "PWM", ret);
>   		return ret;
>   	}
>   
> @@ -435,7 +431,7 @@ static int gb_camera_setup_data_connection(struct gb_camera *gcam,
>   			   sizeof(csi_cfg),
>   			   GB_APB_REQUEST_CSI_TX_CONTROL, false);
>   	if (ret < 0) {
> -		gcam_err(gcam, "failed to start the CSI transmitter\n");
> +		dev_err(&gcam->bundle->dev, "failed to start the CSI transmitter\n");
>   		goto error_power;
>   	}
>   
> @@ -470,7 +466,7 @@ static void gb_camera_teardown_data_connection(struct gb_camera *gcam)
>   			   GB_APB_REQUEST_CSI_TX_CONTROL, false);
>   
>   	if (ret < 0)
> -		gcam_err(gcam, "failed to stop the CSI transmitter\n");
> +		dev_err(&gcam->bundle->dev, "failed to stop the CSI transmitter\n");
>   
>   	/* Set the UniPro link to low speed mode. */
>   	gb_camera_set_power_mode(gcam, false);
> @@ -507,7 +503,7 @@ static int gb_camera_capabilities(struct gb_camera *gcam,
>   					     NULL, 0,
>   					     (void *)capabilities, size);
>   	if (ret)
> -		gcam_err(gcam, "failed to retrieve capabilities: %d\n", ret);
> +		dev_err(&gcam->bundle->dev, "failed to retrieve capabilities: %d\n", ret);
>   
>   done:
>   	mutex_unlock(&gcam->mutex);
> @@ -723,22 +719,22 @@ static int gb_camera_request_handler(struct gb_operation *op)
>   	struct gb_message *request;
>   
>   	if (op->type != GB_CAMERA_TYPE_METADATA) {
> -		gcam_err(gcam, "Unsupported unsolicited event: %u\n", op->type);
> +		dev_err(&gcam->bundle->dev, "Unsupported unsolicited event: %u\n", op->type);
>   		return -EINVAL;
>   	}
>   
>   	request = op->request;
>   
>   	if (request->payload_size < sizeof(*payload)) {
> -		gcam_err(gcam, "Wrong event size received (%zu < %zu)\n",
> -			 request->payload_size, sizeof(*payload));
> +		dev_err(&gcam->bundle->dev, "Wrong event size received (%zu < %zu)\n",
> +			request->payload_size, sizeof(*payload));
>   		return -EINVAL;
>   	}
>   
>   	payload = request->payload;
>   
> -	gcam_dbg(gcam, "received metadata for request %u, frame %u, stream %u\n",
> -		 payload->request_id, payload->frame_number, payload->stream);
> +	dev_dbg(&gcam->bundle->dev, "received metadata for request %u, frame %u, stream %u\n",
> +		payload->request_id, payload->frame_number, payload->stream);
>   
>   	return 0;
>   }
> @@ -1347,15 +1343,15 @@ static int gb_camera_resume(struct device *dev)
>   
>   	ret = gb_connection_enable(gcam->connection);
>   	if (ret) {
> -		gcam_err(gcam, "failed to enable connection: %d\n", ret);
> +		dev_err(&gcam->bundle->dev, "failed to enable connection: %d\n", ret);
>   		return ret;
>   	}
>   
>   	if (gcam->data_connection) {
>   		ret = gb_connection_enable(gcam->data_connection);
>   		if (ret) {
> -			gcam_err(gcam,
> -				 "failed to enable data connection: %d\n", ret);
> +			dev_err(&gcam->bundle->dev,
> +				"failed to enable data connection: %d\n", ret);
>   			return ret;
>   		}
>   	}


