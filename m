Return-Path: <linux-kernel+bounces-79725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABB78625D7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DF6283397
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2D46548;
	Sat, 24 Feb 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="WwD5UUvr"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1EE4502E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708789416; cv=none; b=M7NrI4LhEuBtjonRoymmoy45RQuXAiQ+lg6gxJY+rVryhW9YN+TqWfHob12jJfP2aGTJ8rlKaNoZo3Lj4F06s7eOEyN59dcCMljDJLy/4GECBuhFosJ1j39rf9rpNZUs3BydHVFDcgdXYmCxKeVjXZZI+jEiNiF8xID2xUtGVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708789416; c=relaxed/simple;
	bh=6AcJBEaDq23XynjPrh9BHYg7HDWGXQMfh9JxB3yRIBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgFURQdu7GN34MSRnRU6N8UueUUvxBUk/GdxtGRO3Ef/797rsLEMKCBxLvZTW5fsy2pWtx/HsDbquqU3as2Rv7k7dMxdkduBSTWLKY6UTfQsYGOHE7i4SHFSPrnoAxZCqvKqgbpYGW8cAz2TMdW/c6LQrHQzYhnik3ez4QzaZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=WwD5UUvr; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso71310639f.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 07:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1708789413; x=1709394213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0qYyqY2wAqQ9qpXtppc+dFQhwKCUOdHpHjo4UMt1ME=;
        b=WwD5UUvrG4R6ROgXr+ijscAsKcN54T5V0Ul3oskEM1YF3XKBGKeSEtJBWXPD5QItPJ
         EEu4G4eCOYFCd+FYK1N6+JoqkE/OVySfx5ljDmCjdlIhjEF054oHJNY+/az+b+zcnezq
         kgWqIleX8daMXoMwHSNGskVIdbPgjgLNvRgLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708789413; x=1709394213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0qYyqY2wAqQ9qpXtppc+dFQhwKCUOdHpHjo4UMt1ME=;
        b=O1+GCY+T+CvlbWUpaGDkpRSHdk7OpYUCMDSRk6gVzOIiE8s0WyqHlDrhqIZuyt+PDn
         tMGnbj9LLwcgEhYg4rgUFmQ8qEwSYyyefa0s1P4I/Y3AJca0aNX/ddiypNyRdmVsKd1Q
         1ooZ9MbodkZSaZ2b/+cSEZJldrzLkRUcMmqVSdVD7DPpVYa/2TCwohh9YWlwnqj4PXHA
         uk41oFFzYr1T1qJgH94a2BiMRb/X+rUv2lz9+aybJaseqH/rIhyt6eOz/hhaca5vkVf9
         6AvSBg5+ReXS3VHo8vJioLj3w9Gn34nusLIh5fIoJkr3R9wAO/4BrOn0yIkl20yxg8gP
         +CAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM1ZcHtPKQX8FD00MaAkSxUiXM5Bq3pr04NU0t9hAcfmodul5+levwCeY/YXJp8pyY0IlU8aoaE4WUOIqmoA5rqm/DoFNQFwWTODwY
X-Gm-Message-State: AOJu0YxD1oPcLY3vyY25w64s3m0ypXqhRNA4EGqzeHEhN6hv4Ws1s4vs
	E0YeGrJzJhKla5INWXkVY5jGUAoaPujPsq8iMWjwxWCCHBUD3E2kYq276aAcUg==
X-Google-Smtp-Source: AGHT+IGYIeQXlsMNeG/G/L6Vb6ceeWKlccDbA9iL8PUQMucFElhxUyLuQwRTAUUoILbcdfLswdfGWw==
X-Received: by 2002:a6b:dc16:0:b0:7c7:a437:74bd with SMTP id s22-20020a6bdc16000000b007c7a43774bdmr3105766ioc.2.1708789412733;
        Sat, 24 Feb 2024 07:43:32 -0800 (PST)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id j3-20020a02cc63000000b0047434d0be66sm304570jaq.27.2024.02.24.07.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 07:43:32 -0800 (PST)
Message-ID: <cf5b2696-d7ca-40fc-856a-52f352cd270c@ieee.org>
Date: Sat, 24 Feb 2024 09:43:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: constify the struct device_type usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20240219-device_cleanup-greybus-v1-1-babb3f65e8cc@marliere.net>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240219-device_cleanup-greybus-v1-1-babb3f65e8cc@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 6:40 AM, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> greybus_hd_type, greybus_module_type, greybus_interface_type,
> greybus_control_type, greybus_bundle_type and greybus_svc_type variables to
> be constant structures as well, placing it into read-only memory which can
> not be modified at runtime.
> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

This looks good to me.  Assuming it compiles cleanly:

Reviewed-by: Alex Elder <elder@linaro.org>

On another subject:

Johan might disagree, but I think it would be nice to make
the definitions of the Greybus device types as static (private)
and make the is_gb_host_device() etc. functions real functions
rather than static inlines in <linux/greybus.h>.

It turns out that all of the is_gb_*() functions are called only
from drivers/greybus/core.c; they could all be moved there rather
than advertising them in <linux/greybus.h>.

					-Alex


> ---
>   drivers/greybus/bundle.c    |  2 +-
>   drivers/greybus/control.c   |  2 +-
>   drivers/greybus/hd.c        |  2 +-
>   drivers/greybus/interface.c |  2 +-
>   drivers/greybus/module.c    |  2 +-
>   drivers/greybus/svc.c       |  2 +-
>   include/linux/greybus.h     | 12 ++++++------
>   7 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/greybus/bundle.c b/drivers/greybus/bundle.c
> index 84660729538b..a6e1cca06172 100644
> --- a/drivers/greybus/bundle.c
> +++ b/drivers/greybus/bundle.c
> @@ -166,7 +166,7 @@ static const struct dev_pm_ops gb_bundle_pm_ops = {
>   	SET_RUNTIME_PM_OPS(gb_bundle_suspend, gb_bundle_resume, gb_bundle_idle)
>   };
>   
> -struct device_type greybus_bundle_type = {
> +const struct device_type greybus_bundle_type = {
>   	.name =		"greybus_bundle",
>   	.release =	gb_bundle_release,
>   	.pm =		&gb_bundle_pm_ops,
> diff --git a/drivers/greybus/control.c b/drivers/greybus/control.c
> index 359a25841973..b5cf49d09df2 100644
> --- a/drivers/greybus/control.c
> +++ b/drivers/greybus/control.c
> @@ -436,7 +436,7 @@ static void gb_control_release(struct device *dev)
>   	kfree(control);
>   }
>   
> -struct device_type greybus_control_type = {
> +const struct device_type greybus_control_type = {
>   	.name =		"greybus_control",
>   	.release =	gb_control_release,
>   };
> diff --git a/drivers/greybus/hd.c b/drivers/greybus/hd.c
> index 72b21bf2d7d3..e2f3496bddc3 100644
> --- a/drivers/greybus/hd.c
> +++ b/drivers/greybus/hd.c
> @@ -116,7 +116,7 @@ static void gb_hd_release(struct device *dev)
>   	kfree(hd);
>   }
>   
> -struct device_type greybus_hd_type = {
> +const struct device_type greybus_hd_type = {
>   	.name		= "greybus_host_device",
>   	.release	= gb_hd_release,
>   };
> diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
> index 9ec949a438ef..a88dc701289c 100644
> --- a/drivers/greybus/interface.c
> +++ b/drivers/greybus/interface.c
> @@ -765,7 +765,7 @@ static const struct dev_pm_ops gb_interface_pm_ops = {
>   			   gb_interface_runtime_idle)
>   };
>   
> -struct device_type greybus_interface_type = {
> +const struct device_type greybus_interface_type = {
>   	.name =		"greybus_interface",
>   	.release =	gb_interface_release,
>   	.pm =		&gb_interface_pm_ops,
> diff --git a/drivers/greybus/module.c b/drivers/greybus/module.c
> index 36f77f9e1d74..7f7153a1dd60 100644
> --- a/drivers/greybus/module.c
> +++ b/drivers/greybus/module.c
> @@ -81,7 +81,7 @@ static void gb_module_release(struct device *dev)
>   	kfree(module);
>   }
>   
> -struct device_type greybus_module_type = {
> +const struct device_type greybus_module_type = {
>   	.name		= "greybus_module",
>   	.release	= gb_module_release,
>   };
> diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
> index 0d7e749174a4..4256467fcd35 100644
> --- a/drivers/greybus/svc.c
> +++ b/drivers/greybus/svc.c
> @@ -1305,7 +1305,7 @@ static void gb_svc_release(struct device *dev)
>   	kfree(svc);
>   }
>   
> -struct device_type greybus_svc_type = {
> +const struct device_type greybus_svc_type = {
>   	.name		= "greybus_svc",
>   	.release	= gb_svc_release,
>   };
> diff --git a/include/linux/greybus.h b/include/linux/greybus.h
> index 18c0fb958b74..5f9791fae3c0 100644
> --- a/include/linux/greybus.h
> +++ b/include/linux/greybus.h
> @@ -106,12 +106,12 @@ struct dentry *gb_debugfs_get(void);
>   
>   extern struct bus_type greybus_bus_type;
>   
> -extern struct device_type greybus_hd_type;
> -extern struct device_type greybus_module_type;
> -extern struct device_type greybus_interface_type;
> -extern struct device_type greybus_control_type;
> -extern struct device_type greybus_bundle_type;
> -extern struct device_type greybus_svc_type;
> +extern const struct device_type greybus_hd_type;
> +extern const struct device_type greybus_module_type;
> +extern const struct device_type greybus_interface_type;
> +extern const struct device_type greybus_control_type;
> +extern const struct device_type greybus_bundle_type;
> +extern const struct device_type greybus_svc_type;
>   
>   static inline int is_gb_host_device(const struct device *dev)
>   {
> 
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240219-device_cleanup-greybus-c97c1ef52458
> 
> Best regards,


