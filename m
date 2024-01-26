Return-Path: <linux-kernel+bounces-40278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A283DD76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D1728119E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1641CFB5;
	Fri, 26 Jan 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="FN0NEQJS"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C931CF8C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282840; cv=none; b=NIXhZyzjzgFCp4LIzdDwGbUlYGTp7QomVyOQ2olKOmMGkanY5yq6U/+dIQvVpc0PwTlHzmUGtmzDCd1bZIAkq5lKFO5Sey19DWkizneT3fEWqgOmq4c9lviganM9DJlq1pG6Ur3iMxEh0+4BTSZzKPbHIyc7ztAGRVBKdL+ACqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282840; c=relaxed/simple;
	bh=mekhHBtJIsT7gwyVqNfMQ8skPdO2FKhi+bUV1qEm2Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChJTXmywB/C7J/LOC9ysbzj+pxZ88qYOCI+7ti/B0PDEZ6lI1M/eYDhdzV9dTHtuzBRdZYE3SZ3ZzV719VGv4M1CeaNc4adJM+4JbjI+PwOo1oqvsFYwYuh/I+zQL3xyl2/Ws8MIpwRWtglD7IfKVISSn9b4/KtXexs7q1ktmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=FN0NEQJS; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bc32b0fdadso19335939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1706282838; x=1706887638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4YLTamt/dfCfCUlCRgJ4PI4VKPOTvevkMpm6aJpxeo=;
        b=FN0NEQJS04uUJ8zMFV1EgTIgs2rEfu0/NUUwmld8RXiT23H6xUvSpkf5e4BWyqJUuO
         dmEhUy1OOoztTGKqicPf+fAumb+4/DZBzOB/WxaFSbR9C3yUHCzot+Zj21qlAXAIJWb2
         EpyhWvUa864IebnTfUFAf8ITKaiJ1OVhuauJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282838; x=1706887638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4YLTamt/dfCfCUlCRgJ4PI4VKPOTvevkMpm6aJpxeo=;
        b=g4clKBrbmMNANNo4at096XMueJlSO/FLdLw+lr+pG5+KIpNznC4XEK6N+8fR3VyC9u
         K5eMZslK9wv7BI9ggb5p65njo+EXcoHPZ+N8KEz0TNbNoOcugHk9p1AtfPZwNgL+XXbE
         1tk7Z36wf6UEcwrFd0qoXshoLHHVXt79kZQPQGfno5QpjEM173XiWqzz4BMZEKJVocxn
         Ui6FqnoIjBMi0ggc0elNBuq2VvBfcnG5HezHM1N6fZjlYEONytgAG9aug+iFrN9lZib9
         0XT4ELPV+fHqtFxX+dGgsp8QVIvCMaizgfne7M8oZE5HaruG+nT/Sx8xwQYi/I7q4Y60
         84ag==
X-Gm-Message-State: AOJu0YxT1lD45IbukZjRh7j7mhpCZHaRbvUSVYaYrWG6PyXh+sViXpyR
	hcDZtbKEbWlUlsnXcbPPN/IlASAeWnR0N2vu6yVukqZvLyIyiiTyfUx0Lnqf5lCZDzo0PqWOJcT
	Ubg==
X-Google-Smtp-Source: AGHT+IH2+E2ZGiBvOqV5jJVhXW/UdB37L5HITTy5G70/vnCA1pyoTK6U/M9SXKioRh4tqGEiNYUhgw==
X-Received: by 2002:a5e:dd01:0:b0:7bf:d258:6344 with SMTP id t1-20020a5edd01000000b007bfd2586344mr109800iop.0.1706282837817;
        Fri, 26 Jan 2024 07:27:17 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id d8-20020a056602184800b007bc102fb67asm412821ioi.10.2024.01.26.07.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 07:27:17 -0800 (PST)
Message-ID: <53dfea0f-6840-4a02-af9d-65a99a53f28a@ieee.org>
Date: Fri, 26 Jan 2024 09:27:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: Remove usage of the deprecated ida_simple_xx()
 API
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 greybus-dev@lists.linaro.org
References: <26425379d3eb9ba1b9af44468576ee20c77eb248.1705226208.git.christophe.jaillet@wanadoo.fr>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <26425379d3eb9ba1b9af44468576ee20c77eb248.1705226208.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/24 3:57 AM, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added when
> needed.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/greybus/es2.c       |  8 ++++----
>   drivers/greybus/hd.c        | 16 ++++++++--------
>   drivers/greybus/interface.c |  9 ++++-----
>   3 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
> index e89cca015095..1ee78d0d90b4 100644
> --- a/drivers/greybus/es2.c
> +++ b/drivers/greybus/es2.c
> @@ -513,16 +513,16 @@ static int es2_cport_allocate(struct gb_host_device *hd, int cport_id,
>   
>   	if (cport_id < 0) {
>   		ida_start = 0;
> -		ida_end = hd->num_cports;
> +		ida_end = hd->num_cports - 1;
>   	} else if (cport_id < hd->num_cports) {
>   		ida_start = cport_id;
> -		ida_end = cport_id + 1;
> +		ida_end = cport_id;
>   	} else {
>   		dev_err(&hd->dev, "cport %d not available\n", cport_id);
>   		return -EINVAL;
>   	}
>   
> -	return ida_simple_get(id_map, ida_start, ida_end, GFP_KERNEL);
> +	return ida_alloc_range(id_map, ida_start, ida_end, GFP_KERNEL);
>   }
>   
>   static void es2_cport_release(struct gb_host_device *hd, u16 cport_id)
> @@ -535,7 +535,7 @@ static void es2_cport_release(struct gb_host_device *hd, u16 cport_id)
>   		return;
>   	}
>   
> -	ida_simple_remove(&hd->cport_id_map, cport_id);
> +	ida_free(&hd->cport_id_map, cport_id);
>   }
>   
>   static int cport_enable(struct gb_host_device *hd, u16 cport_id,
> diff --git a/drivers/greybus/hd.c b/drivers/greybus/hd.c
> index 72b21bf2d7d3..bc5fd2f53d8b 100644
> --- a/drivers/greybus/hd.c
> +++ b/drivers/greybus/hd.c
> @@ -50,7 +50,7 @@ int gb_hd_cport_reserve(struct gb_host_device *hd, u16 cport_id)
>   	struct ida *id_map = &hd->cport_id_map;
>   	int ret;
>   
> -	ret = ida_simple_get(id_map, cport_id, cport_id + 1, GFP_KERNEL);
> +	ret = ida_alloc_range(id_map, cport_id, cport_id, GFP_KERNEL);
>   	if (ret < 0) {
>   		dev_err(&hd->dev, "failed to reserve cport %u\n", cport_id);
>   		return ret;
> @@ -64,7 +64,7 @@ void gb_hd_cport_release_reserved(struct gb_host_device *hd, u16 cport_id)
>   {
>   	struct ida *id_map = &hd->cport_id_map;
>   
> -	ida_simple_remove(id_map, cport_id);
> +	ida_free(id_map, cport_id);
>   }
>   EXPORT_SYMBOL_GPL(gb_hd_cport_release_reserved);
>   
> @@ -80,16 +80,16 @@ int gb_hd_cport_allocate(struct gb_host_device *hd, int cport_id,
>   
>   	if (cport_id < 0) {
>   		ida_start = 0;
> -		ida_end = hd->num_cports;
> +		ida_end = hd->num_cports - 1;
>   	} else if (cport_id < hd->num_cports) {
>   		ida_start = cport_id;
> -		ida_end = cport_id + 1;
> +		ida_end = cport_id;
>   	} else {
>   		dev_err(&hd->dev, "cport %d not available\n", cport_id);
>   		return -EINVAL;
>   	}
>   
> -	return ida_simple_get(id_map, ida_start, ida_end, GFP_KERNEL);
> +	return ida_alloc_range(id_map, ida_start, ida_end, GFP_KERNEL);
>   }
>   
>   /* Locking: Caller guarantees serialisation */
> @@ -100,7 +100,7 @@ void gb_hd_cport_release(struct gb_host_device *hd, u16 cport_id)
>   		return;
>   	}
>   
> -	ida_simple_remove(&hd->cport_id_map, cport_id);
> +	ida_free(&hd->cport_id_map, cport_id);
>   }
>   
>   static void gb_hd_release(struct device *dev)
> @@ -111,7 +111,7 @@ static void gb_hd_release(struct device *dev)
>   
>   	if (hd->svc)
>   		gb_svc_put(hd->svc);
> -	ida_simple_remove(&gb_hd_bus_id_map, hd->bus_id);
> +	ida_free(&gb_hd_bus_id_map, hd->bus_id);
>   	ida_destroy(&hd->cport_id_map);
>   	kfree(hd);
>   }
> @@ -162,7 +162,7 @@ struct gb_host_device *gb_hd_create(struct gb_hd_driver *driver,
>   	if (!hd)
>   		return ERR_PTR(-ENOMEM);
>   
> -	ret = ida_simple_get(&gb_hd_bus_id_map, 1, 0, GFP_KERNEL);
> +	ret = ida_alloc_min(&gb_hd_bus_id_map, 1, GFP_KERNEL);
>   	if (ret < 0) {
>   		kfree(hd);
>   		return ERR_PTR(ret);
> diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
> index 9ec949a438ef..c3cfd62831ff 100644
> --- a/drivers/greybus/interface.c
> +++ b/drivers/greybus/interface.c
> @@ -131,9 +131,8 @@ static int gb_interface_route_create(struct gb_interface *intf)
>   	int ret;
>   
>   	/* Allocate an interface device id. */
> -	ret = ida_simple_get(&svc->device_id_map,
> -			     GB_SVC_DEVICE_ID_MIN, GB_SVC_DEVICE_ID_MAX + 1,
> -			     GFP_KERNEL);
> +	ret = ida_alloc_range(&svc->device_id_map, GB_SVC_DEVICE_ID_MIN,
> +			      GB_SVC_DEVICE_ID_MAX, GFP_KERNEL);
>   	if (ret < 0) {
>   		dev_err(&intf->dev, "failed to allocate device id: %d\n", ret);
>   		return ret;
> @@ -165,7 +164,7 @@ static int gb_interface_route_create(struct gb_interface *intf)
>   	 * XXX anymore.
>   	 */
>   err_ida_remove:
> -	ida_simple_remove(&svc->device_id_map, device_id);
> +	ida_free(&svc->device_id_map, device_id);
>   
>   	return ret;
>   }
> @@ -178,7 +177,7 @@ static void gb_interface_route_destroy(struct gb_interface *intf)
>   		return;
>   
>   	gb_svc_route_destroy(svc, svc->ap_intf_id, intf->interface_id);
> -	ida_simple_remove(&svc->device_id_map, intf->device_id);
> +	ida_free(&svc->device_id_map, intf->device_id);
>   	intf->device_id = GB_INTERFACE_DEVICE_ID_BAD;
>   }
>   


