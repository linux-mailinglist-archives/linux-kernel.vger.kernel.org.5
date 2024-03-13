Return-Path: <linux-kernel+bounces-101678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7DF87AA60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDF61F22B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B1C4654F;
	Wed, 13 Mar 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y12zsuiK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF246436
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343780; cv=none; b=KA2RIl2qE2dcW1ZcvxpJ821nlYveaAM/a8+l1Cd77MKGJCx4zvhyCmCyW1ozv6RfgFkzadyEN/X6oyertVwmAHpfaOy665r78BV7IR3D3QfZwNlaMIYzd4QC15TpQebZdFKBV2Wm/vECrtzWfXm8W13nDrcAUDkOjousrxt+bV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343780; c=relaxed/simple;
	bh=xDnkHtgwr9H5DPFYdG9cIZiaD3ZNEtYgxwS8tw1QMLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkU1hG+6uAdZKJQ9Zih9mvcNY7kA52gXRgbFnf6795Alpdn4Sj/n2FH5TbyAGGAWZuyjDZm5I3ZO3KGf7QZ5RUTkDXJGv71Ny1URooe6wlhQ20izSoBNIZsEdkOHeqKvUSbe6NYyIc5h6wqjcL8ufvVYE6jcBqRsUpTZffTHC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y12zsuiK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e1d327595so3134317f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710343777; x=1710948577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvt8Qtm+W+Qck4IJaiB7iim8R4TtzqabulZr702KWPU=;
        b=y12zsuiKXNf2nmTZySJ2sGUq8gpHTHVPEaDANqOLYkeUrsXTy7BPwn/6ymbuy9jdnc
         ll7MAy4UgdmorI+OKODVNcWpQyoOv0mxX+4WM6OAB1t1wqUSP+jop8EVAVTfbD8RmXGA
         7pKSvC+3p6PcrLCFedViB8lTMx9aMLQ4NIdnuOgBAd4n10hvrODbobW8DHycoux3lQEb
         9e1B23u3Iz+W7ocXQoPGl+IhLrWI7ZKvsC2U5sOTE1oDnS3Xn+PsIIBdOKkXIxgGE1VZ
         SEOZbY0YtVqROM/KlbNF0YeDGVejr1v0NbtP1BoeiXmvpY/VlQxsAMTMTdkoVoy/66n1
         OaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710343777; x=1710948577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvt8Qtm+W+Qck4IJaiB7iim8R4TtzqabulZr702KWPU=;
        b=UytI0kaVULPrbZzpikLMKyq0MbFEOQ7i1r554EzgJYedpB468FTQv5UJZxfn2b7aUs
         9KDRkEdI5fLgFqpAw4cnFwyLv7rnkFkNgXndam6SPp4d7hDbX/kbU8vQ5xbWjwD3oHPS
         uqbXSqFTbqAYVTQEQU8H981SfE88N5AE1OS8pQuEoCi/MWxYpwuLpLmcrqms4gGRBbX7
         o0a7iDVJy3iq1aKY2685QrPMzNXfWwoS58nhZLx9yESw7CiLP6lAL9d6xmrkua4kp8cl
         ukKYSNIS/eL/xsxb6dhQH3daOFh00Q6eUvvkhEuW1J/8p7iAdWeEa0G4Zvl7Pn1b3ITD
         9TSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf7Ac3wtf293lrNzyLxPoq1yhw9mh8zss6Oeq0/xPC4Rr92skB0DUHTPgCayoVY1+64YkBxag3eXjmx+yIEYxJemhJWQhm8pzUedKe
X-Gm-Message-State: AOJu0YxlP6MoSUOO3ZgALI+1rJkrN0/z9kUByXuJTc8V3wao6/nojiDZ
	RoXbgXywoW+hzEfBNuhdpLazNLhORvWMOP6iv0fdjNreT6pjPmjkd6LJ8L3QCpI=
X-Google-Smtp-Source: AGHT+IEEiVfKvNxscpnVHMHh0ahECnASeCS3XrSK48Rwfx2u07RKlZ51HTb0HbzQXu+wFEvnKf6Q5Q==
X-Received: by 2002:adf:f242:0:b0:33e:7564:ceb with SMTP id b2-20020adff242000000b0033e75640cebmr2133308wrp.52.1710343777378;
        Wed, 13 Mar 2024 08:29:37 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z2-20020a5d6402000000b0033dedd63382sm11866029wru.101.2024.03.13.08.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 08:29:37 -0700 (PDT)
Message-ID: <d68fd8a7-8889-472e-86db-b62855eebfba@linaro.org>
Date: Wed, 13 Mar 2024 16:29:36 +0100
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
> 
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

Why EPROBE_DEFER in thermal-of can not fix the issue?

I mean can't we check if of_irq_get_byname() returns EPROBE_DEFER and 
then return this value?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


