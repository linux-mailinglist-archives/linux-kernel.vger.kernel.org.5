Return-Path: <linux-kernel+bounces-157574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC58B1312
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD261F2740B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C959E1DA5F;
	Wed, 24 Apr 2024 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYB1BOAu"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985832BAE9;
	Wed, 24 Apr 2024 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985283; cv=none; b=CNxvGcknYoGjnWXJ+iLU8AOWxSLDIG3Elcev6iIi7362oNJj6SriVGuP0J8qoqviwX8itqIVd8RaCMSGwqOdu8VXTkT8rfsqjIJo80HUu5QAULH7OO9T1isrDV7x0IEd2xCO5R2zwjx0TqUxSgCxRhyuCJBkxeE/VtP3eBk7llY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985283; c=relaxed/simple;
	bh=wEniXoUp5G9HRaTQlppl6YOqzKstdjiCVhjp8WFbrik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/zfHpAB13hIHWNuQb6I3ENETY2xh6ZjFFAu9aDqnNZxnulsJ2JDQ8+m+Z8tNch+y/5MBTrthigYGjTDdGtKgLXQ5d2fIctaHpg9u7EhCTYxsnSkOwa4l/FmpmCaD6cKTx6OMv4saAlfmCuEaWxyGSBWX5ajV988J+13dvC7uk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYB1BOAu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a55ab922260so27810466b.3;
        Wed, 24 Apr 2024 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713985279; x=1714590079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYb6lahma9ESsvjNNop/lnhNH+5GGNP092pV3MTMbcg=;
        b=ZYB1BOAu+a4sZghXiYC2eCwuV3UTKza5sCLf/4sxZexeI5jQFFmn9szf/dtgoTL6OW
         7cPOTP4ChaJGMY1Jy0yM1NMYBFkojp9kaZJC03plT7dtQ4zqFB4+a4UQ3WsV5fxVHZg+
         n91fKgnYqE4kQWRLLP5naWjwrumMIH9JlxfWjvslzBwHSA/qxfKLl9WkwslBYafg98TD
         OkjPZzD7k2IO2KO2ND2B4K59wpCgzUtxNmuK9wtzPSwMODTFzo7GofzHZl3bV4jkC1Gp
         GaFeWPRDO9VKVCcxq+pTUs+w1gp+veRsQX1DRRZwF3QKCKsiDloKJpZ+2TMELrV0Qpqw
         PKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713985279; x=1714590079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYb6lahma9ESsvjNNop/lnhNH+5GGNP092pV3MTMbcg=;
        b=Wp3porqkTeHtSCXFzF/dwtN19xer/C9SIrJ6tRqALcYZynyZthYIemhjT4IT66NJM9
         8d0F2nrzrX8px7HJPIHJ509Mo8qmbib1rJ/QSX9jHTtD+4sueDx5qR+QeLnYdI2j4IcX
         RNHgrsKLjvM5xdUrh5l6md8J+29CARy/4JWMKsY8gfsPwOdzLt4p03d/Ksa4nX7tdDvF
         0PiB9ldxsejVbhJap5YpBuSHdUIHaNi3GhR/KntEvbE3sYT1fdZiyi4iJm9kt9q4Ndj4
         GKlIQ2og/QurdWqWdLVgFrxX6+3SINZWFsTVzPqN+VpsPAEUjryyNodRETFsYXwZLL7i
         J8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgxCrtzEkoAgFwhFvFmW4beY7rV84VqcVBRBgYTgnW/dapbQVzCocoFC20IuIZXhDGeNppxWLuYjNTEUezKR1cdSclb2en14SzZUSt/zNYP0I7W/OvXqkwfVqtQ+FPB8XE/0LOEip9+b1wI6DE8PcwBoVbQ1AZbUfSbzeTTlZphRZtwyomjJQ=
X-Gm-Message-State: AOJu0YyfqFfWpcrW+PWrkOfPSgOIXqxhTaKPoywIrPsdw8ZOWR91cCiE
	usY9BIoqXmHfMeft8yoQ2d/tmDzAaD4CJ8VnnJqTr8UKvvblVjLt
X-Google-Smtp-Source: AGHT+IGU+Yholg1eeeqBHS1/XbClARTXKkmiXuj6aUAvmgHd37s0Jp93MObOLF9sK0NFXS2Ld+XqaA==
X-Received: by 2002:a17:907:7241:b0:a58:a2f7:85e9 with SMTP id ds1-20020a170907724100b00a58a2f785e9mr1130309ejc.34.1713985278550;
        Wed, 24 Apr 2024 12:01:18 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id hg7-20020a170906f34700b00a4e5a6b57a2sm8624325ejb.163.2024.04.24.12.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 12:01:17 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yangtao Li <tiny.windzz@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject:
 Re: [PATCH] cpufreq: sun50i: fix error returns in dt_has_supported_hw()
Date: Wed, 24 Apr 2024 21:01:16 +0200
Message-ID: <1882679.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <9bfe5703-b39b-4d98-9995-f6a7d0ea558d@moroto.mountain>
References: <9bfe5703-b39b-4d98-9995-f6a7d0ea558d@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 24. april 2024 ob 13:40:11 GMT +2 je Dan Carpenter napisal(a):
> The dt_has_supported_hw() function returns type bool.  That means these
> negative error codes are cast to true but the function should return
> false instead.
> 
> Fixes: fa5aec9561cf ("cpufreq: sun50i: Add support for opp_supported_hw")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index cd50cea16a87..0b882765cd66 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -136,11 +136,11 @@ static bool dt_has_supported_hw(void)
>  
>  	cpu_dev = get_cpu_device(0);
>  	if (!cpu_dev)
> -		return -ENODEV;
> +		return false;
>  
>  	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>  	if (!np)
> -		return -ENOENT;
> +		return false;
>  
>  	for_each_child_of_node(np, opp) {
>  		if (of_find_property(opp, "opp-supported-hw", NULL)) {
> 





