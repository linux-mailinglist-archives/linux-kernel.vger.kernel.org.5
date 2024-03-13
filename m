Return-Path: <linux-kernel+bounces-101633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9787A9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6DC1F2268A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091A4696;
	Wed, 13 Mar 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jksYYxOr"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C29224FA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341004; cv=none; b=AxVSBAoB5GQ15DzFE2XQcTv7kaDcl7iydKEOyUvhWBa8GFeUdq3bVNPyhj1eMBUh9kvTg3df9d8TBDaXfEA9h8KO4hfkLkNyXhKoUAsxKuKRx+u99wlCsri9hO0zgErrFj8Mh37io10XAV/j3Jxcmh+DPAtro5pfsvk5hbJY98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341004; c=relaxed/simple;
	bh=lCaNQB2loTvOG12Rj6ZuqIpIL166wy5YgOYvmqL9w2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTcem6dHuLNhyFtRNG6cKmMjzOgMYI3pT7hoRWYCe/j+YjrBodrUkHvEukbVnJHO4jfuA9Aymo3UW6P0e1nuBGimbXZjJ0F/DxG1XzhjMCzOXEn7ayPAYijbLvdX1JbcigC5SvpCAvbxRWlwxU4zQ3piey0wz3GkNlUIlVlCCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jksYYxOr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e76d653b5so1070311f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710341001; x=1710945801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOyyWxqr4Zt5l8qx0EOpnngPAjzS6Yb2YM91AanmvQ0=;
        b=jksYYxOrE9KIy2IQfKN4l41yAhmIp9ompOI+JogCs58sGFdPGYy62FA4h4BCXGDonc
         yrs8gTG+HANaeWGJoc7V9DsObtXAhN9YOP8x7CRl2lRopiVgvVKIYsLAGRIvS/xu8HIK
         t6iV2mBTT1VG51si7hgxbN9DzduZciljBxJKtZz6/5Nbw41974hn3Qzh2jN7DIE0p1Bj
         9Kd8mj/0056+s77wU1bMoFQbuha4T/AjvFQuzc/PIrEDO5b6MObd7GXbx99b6Af3uOsH
         h3zDKDX4NqqHwke+pu3H7KAutWufbYwoHV5JiyQ0/uVYGAYbYxOfqMTPwkC1C2hnjxJ2
         QVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710341001; x=1710945801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOyyWxqr4Zt5l8qx0EOpnngPAjzS6Yb2YM91AanmvQ0=;
        b=nxAP8PWOzCyb2dkUwH8bWF7xtvLbYmJeq/vxgcROdig2RC1B8qKuRFo0t+g6c9TRph
         QAb5SsLgnZpl+sBGVWEfOwbFWSEFbMqQAXEIDNqfIdbYIpxpwhw2/BJZKUJM1MHdy0ZE
         4xbtUp8SsQigBneMmOgf4k1Tjx9Cv7Ta5iLlIkaOYZQL61H1ha5M/i6FAcx/e+gceHw9
         CmpsRn5dS65bLBfbkB7oKe65xolwQNz/7Rh3Rum0PfRMrqxVc2EHiGf2t9IBoSUADfN6
         ckifywLOmD5C1hLRd/Z0Gua/Y+OyRGF/Z/vPQMpU/op2wmqprrf5XjE/rbj3icff+BT0
         d35w==
X-Forwarded-Encrypted: i=1; AJvYcCXbCMTB9vrNHv3EWAu50udr7EB8VM6IaIhKjlm88JLWQgLYevnAho/l4ueO+Rdp6Lfqcfmf7oCEo8MKBx/eUUs9R3NYu+RK9EEY79RR
X-Gm-Message-State: AOJu0YyyVwn5cMvCU8n8S/SI6y+ZMDyKrCuvPsz9QRL/nWZ00nQtn89M
	DdAnLdUlAn9Rq5FPnqId9VpFT/tyZOxjALQG0msD8hfXUtntOKGFiTTFKsUkUEc=
X-Google-Smtp-Source: AGHT+IHnYo+Mfw14XHLEGD+XsgTuPyQnaH13Xt3Jsj4nuhLeGe0VgxyoZDpIhuF+vbZ90D3cZE0hww==
X-Received: by 2002:a5d:40d1:0:b0:33e:be35:d449 with SMTP id b17-20020a5d40d1000000b0033ebe35d449mr676795wrq.44.1710341001070;
        Wed, 13 Mar 2024 07:43:21 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bj28-20020a0560001e1c00b0033e7de97214sm12107696wrb.40.2024.03.13.07.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 07:43:20 -0700 (PDT)
Message-ID: <42665ccc-d020-48c4-a5bb-2713f7cbb75c@linaro.org>
Date: Wed, 13 Mar 2024 15:43:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-sun4i: Partially convert to a
 platform driver
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <apatel@ventanamicro.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240312192519.1602493-1-samuel.holland@sifive.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240312192519.1602493-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/03/2024 20:25, Samuel Holland wrote:
> Commit 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a
> platform driver") broke the MMIO timer on the Allwinner D1 SoC because
> the IRQ domain is no longer available when timer_probe() is called:

Did you mean: s/no longer available/not yet available/ ?


>    [    0.000000] irq: no irq domain found for interrupt-controller@10000000 !
>    [    0.000000] Failed to map interrupt for /soc/timer@2050000
>    [    0.000000] Failed to initialize '/soc/timer@2050000': -22
> 
> Fix this by wrapping the timer initialization in a platform driver.
> builtin_platform_driver_probe() must be used because the driver uses
> timer_of_init(), which is marked as __init. Only convert the sun8i
> variants of the hardware, because some older SoCs still need the timer
> probed early for sched_clock().
> 
> Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>   drivers/clocksource/timer-sun4i.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
> index 7bdcc60ad43c..728dac2baa84 100644
> --- a/drivers/clocksource/timer-sun4i.c
> +++ b/drivers/clocksource/timer-sun4i.c
> @@ -20,6 +20,7 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_irq.h>
> +#include <linux/platform_device.h>
>   
>   #include "timer-of.h"
>   
> @@ -218,9 +219,24 @@ static int __init sun4i_timer_init(struct device_node *node)
>   }
>   TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
>   		       sun4i_timer_init);
> -TIMER_OF_DECLARE(sun8i_a23, "allwinner,sun8i-a23-timer",
> -		 sun4i_timer_init);
> -TIMER_OF_DECLARE(sun8i_v3s, "allwinner,sun8i-v3s-timer",
> -		 sun4i_timer_init);
>   TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
>   		       sun4i_timer_init);
> +
> +static int __init sun4i_timer_probe(struct platform_device *pdev)
> +{
> +	return sun4i_timer_init(dev_of_node(&pdev->dev));
> +}
> +
> +static const struct of_device_id sun4i_timer_of_match[] = {
> +	{ .compatible = "allwinner,sun8i-a23-timer" },
> +	{ .compatible = "allwinner,sun8i-v3s-timer" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver sun4i_timer_driver = {
> +	.driver	= {
> +		.name		= "sun4i-timer",
> +		.of_match_table	= sun4i_timer_of_match,
> +	},
> +};
> +builtin_platform_driver_probe(sun4i_timer_driver, sun4i_timer_probe);

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


