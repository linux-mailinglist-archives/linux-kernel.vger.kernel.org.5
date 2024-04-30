Return-Path: <linux-kernel+bounces-164799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4259A8B8311
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32DF284D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA761C0DD7;
	Tue, 30 Apr 2024 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="WZsntZ1G"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4317BB03
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520509; cv=none; b=J04acgcgHW3z/o0p8qbH0yMMVUhy1esCeNE7L42vy2+tazn6569bttTPi3HEB+GtvaOEWTmisoyW3pG3lohucts+JggnJl0FYsXUm3d5KUNvZy12YilvuKimlJHt71CNxJz3mHaVQSMTJdMoz738LwYfMuFsjO7fCBgWcLNcylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520509; c=relaxed/simple;
	bh=SW9HPTMDTmj/1tOuNUYUrm9F8jqe6Po6ChUZCYKP1K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kmb4M7IJRxqXtqNzTYVPuFJ8/mdEIlqwIfmMdP4nGvi+ezg92neQxNmNr7NB9dnUqiJBQ/wwlD1bprzQVKZMFiL25vTo3qcld1AYvCBkrWlmqbIZO1WYW4FLFu1tBrqRuFFtQUF0fAoyU5Q/0JVMH3DM0hRM21Di1VP/uRqyIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=WZsntZ1G; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso346729276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1714520505; x=1715125305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyNJHGFWuCMTbeFg405HlnRxBUxH//W5wiUSNddP8XU=;
        b=WZsntZ1G2z8I2t81GvMpZy8VlIWAUmnWpt2OHT16b9tHfgkfUgCAIUHY9/PUjRfuBX
         9WnNEYqb+lvhE/gIk34+giHhd6whqtNeVdG87W4RQAqOSi0+FfzU/0MZguH8xNWivsEp
         KRvujhbdEQhdN34O3T4ki9HLCZnJUW08AN9rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714520505; x=1715125305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyNJHGFWuCMTbeFg405HlnRxBUxH//W5wiUSNddP8XU=;
        b=MqAnEhh6O2CG/w1n46pKesPBoOTMnlRKc9XR+MsPFo3S4ZSin5Go+qTAqp3+W5LSTG
         iNmKI01x0p3qSyxzYLOVWDqRWE2LgSDuWClUuN9TNA7Sp3JUFz7dcDd4E7ZZwehf8VfR
         RT11bAV1DUtC6nvy3F4peeJFV4c4z+JDmcqKJalwhKHWXg2QFxSCBdMvWyUpGMKzqdIX
         qXae+3maGqitxT0QEQ6of8ZL1WPAVfCBYUUyZZFtKsRHkBP47y9sPOVfrZ6uj7yQIX2H
         +cYoFzhVfpfMuAkY9eOPi3pIFhRm11QxYU/ohN1pQksboqDZN64Vbgo7p2Jke2dvLQsH
         PK1w==
X-Forwarded-Encrypted: i=1; AJvYcCUIIYi/oAz1xnrLrVkYwU+iosJ0bBWsnxlWfMe8aZI7LY+RELU9VH7KaPC4VAy4LplNYukfywpntR4NDwd/01Huj3QgChi02cEi9jrU
X-Gm-Message-State: AOJu0Yz6hpNHT7uuFI5XzTYBEINC8bTn/hVL+RSxn/74RzJpC7zrZGnU
	2I8/NPOiC8kjRtBi6B9unxNMVQsQmqGz4wegs6MAcudYZEnTAGQvi4FGfkl5cg==
X-Google-Smtp-Source: AGHT+IG9ARc9BS7K77ZQwk0ByPLtLEEQsTsSNZsRxRh92VKyfaBL924BS3RaIxHei9zkfWFIw/3oyg==
X-Received: by 2002:a5b:b02:0:b0:dd1:6cad:8fd3 with SMTP id z2-20020a5b0b02000000b00dd16cad8fd3mr803465ybp.27.1714520505457;
        Tue, 30 Apr 2024 16:41:45 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id p81-20020a25d854000000b00de617955013sm493242ybg.45.2024.04.30.16.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 16:41:44 -0700 (PDT)
Message-ID: <506f15e3-b40e-481a-9eac-772faf4feb6b@ieee.org>
Date: Tue, 30 Apr 2024 18:41:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/34] greybus: arche-ctrl: move device table to its right
 location
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 Vaibhav Hiremath <hvaibhav.linux@gmail.com>, Johan Hovold
 <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-18-arnd@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240403080702.3509288-18-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 3:06 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The arche-ctrl has two platform drivers and three of_device_id tables,
> but one table is only used for the the module loader, while the other
> two seem to be associated with their drivers.
> 
> This leads to a W=1 warning when the driver is built-in:
> 
> drivers/staging/greybus/arche-platform.c:623:34: error: 'arche_combined_id' defined but not used [-Werror=unused-const-variable=]
>    623 | static const struct of_device_id arche_combined_id[] = {
> 
> Drop the extra table and register both tables that are actually
> used as the ones for the module loader instead.

So what I see is that this commit added arche_combined_id[]:
   1e5dd1f8279a8 greybus: arche-platform: merge arche-apb-ctrl and 
arche-platform

That moved the arche_apb_ctrl_device_driver struct and some other
associated bits out of arche-apb-ctrl.c and into arche-platform.c.
It *kept* arche_platform_of_match[] as the of_match_table for
arche_platform_device_driver, but defined arche_combined_id[] and
declared it for modalias to indicate both drivers were implemented
in the single kernel module.

The later commit (the one you references in "Fixes") then moved
the arche_apb_ctrl_device_driver etc. back to arche-apb-ctrl.c.
That commit did *not* use MODULE_DEVICE_TABLE() to declare
arche_apb_ctrl_of_match[] for modalias.  And it simply kept the
(no longer correct) arche_combined_id[] table to be used by the
arche_platform_device_driver.

So your fix:
- Declares for modalias that arche_apb_ctrl_of_match[] is the
   of_match_table for arche_apb_ctrl_device_driver.
- Declares for modalias that arche_platform_of_match[] is the
   of_match_table for arche_platform_device_driver.
- Gets rid of arche_combined_id[], which is no longer used.

In short:  looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Fixes: 7b62b61c752a ("greybus: arche-ctrl: Don't expose driver internals to arche-platform driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/staging/greybus/arche-apb-ctrl.c | 1 +
>   drivers/staging/greybus/arche-platform.c | 9 +--------
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
> index 8541995008da..aa6f266b62a1 100644
> --- a/drivers/staging/greybus/arche-apb-ctrl.c
> +++ b/drivers/staging/greybus/arche-apb-ctrl.c
> @@ -466,6 +466,7 @@ static const struct of_device_id arche_apb_ctrl_of_match[] = {
>   	{ .compatible = "usbffff,2", },
>   	{ },
>   };
> +MODULE_DEVICE_TABLE(of, arche_apb_ctrl_of_match);
>   
>   static struct platform_driver arche_apb_ctrl_device_driver = {
>   	.probe		= arche_apb_ctrl_probe,
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index 891b75327d7f..b33977ccd527 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -619,14 +619,7 @@ static const struct of_device_id arche_platform_of_match[] = {
>   	{ .compatible = "google,arche-platform", },
>   	{ },
>   };
> -
> -static const struct of_device_id arche_combined_id[] = {
> -	/* Use PID/VID of SVC device */
> -	{ .compatible = "google,arche-platform", },
> -	{ .compatible = "usbffff,2", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, arche_combined_id);
> +MODULE_DEVICE_TABLE(of, arche_platform_of_match);
>   
>   static struct platform_driver arche_platform_device_driver = {
>   	.probe		= arche_platform_probe,


