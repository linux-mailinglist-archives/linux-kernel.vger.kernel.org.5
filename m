Return-Path: <linux-kernel+bounces-133924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D749F89AAF6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB382826D4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DFC34545;
	Sat,  6 Apr 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlpD9Lv7"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B022323;
	Sat,  6 Apr 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712408192; cv=none; b=pANywh1+Xwcn8FgBc9nf9ygHtFSbOTXoj+Po+5m8RzzI2j/g4kqS3SmshCwZEwER/J4l2L2ZrS/Zj0ePyS0mnzcyq+CVBIKFwJBFQuUCeC2MuI84dNIeSTAjn+pbuz5ypqrT2PoTeQy379M4KObWUeTy2Cx/UMzSrN9xJQCD1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712408192; c=relaxed/simple;
	bh=hKd0G2NmbXX8fzdJjXa8jfFvlsc6MojP9+M2XGdWWbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru/YrFxQbjjT++/KrBKxwmtbGDBCp5+M7AYYKLYWYCTz5xualGcb///cyTxmfMhFKzJlkn2LbSOndET6AU+Ryoy1dJARwP024Tizjv8n6cehWSPPl4vMGcSyyDTJ021Wz/iShOz/V6UX1u5I43YlpiGzxsQzmJfQzqIPHeG9Lak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlpD9Lv7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2132375a12.3;
        Sat, 06 Apr 2024 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712408190; x=1713012990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q16J1uts2hdcpjdxl84Ns1YtdGgR8wvA4Zc3e7VQfBg=;
        b=FlpD9Lv7n3d9Ey7hbV7+uO4WrLpzVk0fhuTjDXNFYlI3xaiNn1q0waq3iENSmg2muX
         cNA/JgrzUiRPYlHmqvO7gQlSWfBjAN/CVUO5zreUxXW8my++Fl00mqv/2/nuSL7cx8Nm
         yHDbknrhlmyLu+qR4o93ReDSi7o0ViTzyAcvPv26wtt2972ayhQW05b7J0Zd6+EMT1Ge
         smEPv+TffP/xHHNXTnb0RGbVyQNdcprRU2ULnRoCMZCvcZfSGIxN9qt1TSwz+PCM2u1F
         0RmFemfwrD3ICuV13GGZ7vZ3oSQNu+RvKrZnmPuTLcRuIGsUpjZSx+5fYfEXp7ZtCRPV
         Nf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712408190; x=1713012990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q16J1uts2hdcpjdxl84Ns1YtdGgR8wvA4Zc3e7VQfBg=;
        b=iFM6mc2jY3r2S96DV2gPMDYoMsFQcv+SvUFV/+JlHgCx/Vah+JH1MRNXFBEMKlRLMX
         840tsL2iPtwScPMsL2AUjr6n29p97KnTOd85bQ5xRatHfi4WBZylaPqBCCj9Y1Es/v5k
         4E5JpE/4wjBy6ofbjOBsnt7lcf2Bb9ylsqvvn74poORC5PymMio6O3QtNkFeRQ8h+3u7
         b2qEiWgWvY+Lwi9ujTMv5Bg44tg5+saOErFnw3SzQ48K1rCw/fAJ0e9kocIUW6cSOA7Z
         xhBw2R14KyCqYO9JTP/F1npwQq8ujOZVp1Y4fD3kzIjhMAxiNnNsI+F/S6IFPj8heK3k
         uJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCUC0lc7DGT6/NXu2S3VE2J7MYU/h+IZGfZsz/jcjSQXH/hX0hK7b7vpDxsR9T2uRwymeqBjW3M0qg3d8pph3jUiSl5kIUr5KM4OG/aqCC88YbMr/lpwd44Q/EuZ+5t9hGIvnfUhbDaPAS9N5NA=
X-Gm-Message-State: AOJu0YxuqCmCdiCbpKYawjKuTD7AjmwZrA8XNHwMxNLW4FMGgUJf1RCF
	5c0CwTyq12TrOzFizmFMjW++rk93WvzXh/Qwl69wLAAtbG9/OVc1
X-Google-Smtp-Source: AGHT+IFUnMz2IXRq+TbbkI7ltFpGCLrnKSwdUbjSnwT8VPvqhZAl5L1ZOF3/NoMyrDyj4rZfY3cbRA==
X-Received: by 2002:a17:90b:400a:b0:29b:c2b3:2712 with SMTP id ie10-20020a17090b400a00b0029bc2b32712mr3959351pjb.26.1712408189882;
        Sat, 06 Apr 2024 05:56:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b0029b59bf77b4sm5363282pjz.42.2024.04.06.05.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 05:56:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 6 Apr 2024 05:56:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Judith Mendez <jm@ti.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: rti_wdt: Set min_hw_heartbeat_ms to
 accommodate 5% safety margin
Message-ID: <717195a8-84f7-4bdc-a108-efafd3ef2a46@roeck-us.net>
References: <20240403212426.582727-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403212426.582727-1-jm@ti.com>

On Wed, Apr 03, 2024 at 04:24:26PM -0500, Judith Mendez wrote:
> On AM62x, the watchdog is pet before the valid window
> is open. Fix min_hw_heartbeat and accommodate a 5% safety
> margin with the exception of open window size < 10%,
> which shall use <5% due to the smaller open window size.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rti_wdt.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 8e1be7ba0103..0b16ada659cc 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -92,7 +92,7 @@ static int rti_wdt_start(struct watchdog_device *wdd)
>  	 * to be 50% or less than that; we obviouly want to configure the open
>  	 * window as large as possible so we select the 50% option.
>  	 */
> -	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
> +	wdd->min_hw_heartbeat_ms = 550 * wdd->timeout;
>  
>  	/* Generate NMI when wdt expires */
>  	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
> @@ -126,31 +126,33 @@ static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
>  	 * be petted during the open window; not too early or not too late.
>  	 * The HW configuration options only allow for the open window size
>  	 * to be 50% or less than that.
> +	 * To avoid any glitches, we accommodate 5% safety margin, with the
> +	 * exception of open window size < 10%.
>  	 */
>  	switch (wsize) {
>  	case RTIWWDSIZE_50P:
> -		/* 50% open window => 50% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
> +		/* 50% open window => 55% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 550 * heartbeat;
>  		break;
>  
>  	case RTIWWDSIZE_25P:
> -		/* 25% open window => 75% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
> +		/* 25% open window => 80% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 800 * heartbeat;
>  		break;
>  
>  	case RTIWWDSIZE_12P5:
> -		/* 12.5% open window => 87.5% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
> +		/* 12.5% open window => 92.5% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 925 * heartbeat;
>  		break;
>  
>  	case RTIWWDSIZE_6P25:
> -		/* 6.5% open window => 93.5% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
> +		/* 6.5% open window => 96.5% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 965 * heartbeat;
>  		break;
>  
>  	case RTIWWDSIZE_3P125:
> -		/* 3.125% open window => 96.9% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
> +		/* 3.125% open window => 97.9% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 979 * heartbeat;
>  		break;
>  
>  	default:
> -- 
> 2.43.2
> 
> 

