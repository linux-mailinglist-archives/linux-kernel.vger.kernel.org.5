Return-Path: <linux-kernel+bounces-93618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C290D873269
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582ED1F22EBB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1126514F7F;
	Wed,  6 Mar 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLhEwIF3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019845D91F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716905; cv=none; b=WUfkjYGYMd6VcH1zYbeU044NZTl1fTR4WSkgP/7XzCjXwTI7TiQAPp8uoiOmS6rJ+KwnXJNjxRU6sdhUaQdvtb9UvmTSTyfxRTTcKEVhhpezwMng2klfmd2EoLYUTg7ZXy8JZM/SeChKzzcrFWS6gk8+69up7q2FBTGRDtSgchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716905; c=relaxed/simple;
	bh=zPmVvzS5dPNxox3FTlthI+VtPBf1PINX+vtjBXnCwDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LyO1kX2KHzK5opyzVMukRx61OA1k81DwnQiKw2cAakO+qVV7ez6uuelemnnyvdXHMOQGTQabDU1FZJnkaovMdzhAv3teBY3rvxI4xtKeKxQVc5l2lnmkaOf++vtOOK/ROCDBgEGx3wVpj3ox/ppLS36k/cerpT1Hlxm1/Wg//18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLhEwIF3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412ea23a750so3706255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709716901; x=1710321701; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DEbhInZlM3kJtT7xjjkbZehB8ROzUjJZQUZRHEJT3Fw=;
        b=TLhEwIF3y4ti6Mex/X7UtqrUyu66EsMQFc9EXA0nU3wKptZYlifkjQWpIBtX8Se4ED
         zDBiXkIquaCUKI6zvo8cII6Zih2QMNotfMIllxUjX+07ChrdkAQq05oRwhj6xm4UVk/k
         iron+oy/h2uifidpBop1BvUc7QR8PK9xCktntH/2Cy/RHtBx45/GjEhB1jZIoy0Cc3O+
         cdIfhIuW75aZDbfZWvGDE6wQ7yJ2yJkca/1nV/WGCdvUvERyQkZEFBDkweQMMlBRSTx9
         Sx5frV5SsHzXlwXNIaIu8clKjqGgWOi43ujzMEbXih2Jh5QRbXoCR9dkB0kZ972CO7iT
         1YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716901; x=1710321701;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEbhInZlM3kJtT7xjjkbZehB8ROzUjJZQUZRHEJT3Fw=;
        b=daaFjp55Q+I7H0OKRh6rczfDeKia+ID3GdupB+2Kx95khtZAImxWG3ZHKbyP3v5REc
         kiLjKToZ1HwvG6acdcPBjO+0vLOlWJV0gNPKfZwSmFTIZrcDK/bukA7SJ9OQ9DrRW2lZ
         xoU8kOd7MOY4F8J98NSxGmlGpdCFhEUFylyX8JBoy7rVGStWNWeg8dV6HtgiSTfmKBze
         g1xyEEcBMTP/6HgltjgVP0qW4979s2JhiaNLGmfYh8TlNoSNanQnDN1C/jDc3ZUP+1IV
         NCJ+upwm7MmHtKWvJy35dWeEIAgcjCyb4zy0AVrhLoWguT31N2XirKepYQe/VdWYFkuD
         QiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWjcu3phpDfvtIcK+Kb4p5O/hey+grHuB8kLneSDUSn36EUne4M324X7dwfRcw0zlyhPthHhX59CRq1/1qG8lwQZsEYeg5Xaqlc6q1
X-Gm-Message-State: AOJu0YzGHXgKJX8/AH500skaufWfWMQpXJ3OlqWxLisgS7qUlrZa3Hwi
	EwdJ17dozTxC4rVN/1fIq60E9y32/Q/NGZ9zYqscpdVNR9oAMwot
X-Google-Smtp-Source: AGHT+IEFn3clUVe3HbSihlyMh7NH6uC2n7uWdal4zB80Ths400Ms6K94kq6wQTFqZ5PbecFVK2jH1g==
X-Received: by 2002:a05:600c:4448:b0:412:ee6a:8826 with SMTP id v8-20020a05600c444800b00412ee6a8826mr3596962wmn.12.1709716900620;
        Wed, 06 Mar 2024 01:21:40 -0800 (PST)
Received: from localhost (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
        by smtp.gmail.com with ESMTPSA id v13-20020adfd04d000000b0033d202abf01sm16944420wrh.28.2024.03.06.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:21:40 -0800 (PST)
From: Rui Miguel Silva <rmfrfs@gmail.com>
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
In-Reply-To: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
Date: Wed, 06 Mar 2024 09:21:39 +0000
Message-ID: <m38r2v67h8.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mikhail,
Mikhail Lobanov <m.lobanov@rosalinux.ru> writes:

> Dereference of null pointer in the __gb_lights_flash_brightness_set function.
> Assigning the channel the result of executing the get_channel_from_mode function
> without checking for NULL may result in an error.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>

Are you sending a new version with the changes suggested in this thread?
or do you want me to prepare something with your reported-by tag?

Cheers,
    Rui

> ---
>  drivers/staging/greybus/light.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index 87d36948c610..929514350947 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -148,10 +148,15 @@ static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
>  						GB_CHANNEL_MODE_TORCH);
>  
>  	/* For not flash we need to convert brightness to intensity */
> -	intensity = channel->intensity_uA.min +
> +
> +	if (channel) {
> +		intensity = channel->intensity_uA.min +
>  			(channel->intensity_uA.step * channel->led->brightness);
>  
> -	return __gb_lights_flash_intensity_set(channel, intensity);
> +		return __gb_lights_flash_intensity_set(channel, intensity);
> +	}
> +
> +	return 0;
>  }
>  #else
>  static struct gb_channel *get_channel_from_cdev(struct led_classdev *cdev)
> -- 
> 2.43.0

