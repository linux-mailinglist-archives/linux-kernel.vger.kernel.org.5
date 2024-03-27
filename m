Return-Path: <linux-kernel+bounces-121632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF28888EB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B05F29EA12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330FD13173E;
	Wed, 27 Mar 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X1YrToIE"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0A12F394
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557020; cv=none; b=XqmBmUuaEQ3I5HCn8a/S+eonxElR35swlAsuKPUGYtmhT8WRDg+quPxbiqWM7lMA57oVVdWQpJONtYGIkCsg0OmStLNOhMBL6dY04AM3fSFECyDqxNCwW2vae+O1/X65HzlXw+JCQgH7M8mi8Tz4SrEvyZwQnOp/Cp8QE3LI8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557020; c=relaxed/simple;
	bh=7lYhr5rYnI3FxdZmdKOYuJuz5A6ebiYutbR0u/5ejF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEUD+7JKJPV9+4b94b4EL2iOuuHXIe+eETq1YdlChcBvtQAlsCdB+fsyA6JZ5h7t+ZjVtXwX9oSWJJFrYFGacMMuvWogNlr5rBTKxUmLjE/b/kUUFtxEzGyQLk6SJriPDX2mR1CVPbH2B1pkotfc8vmStPwWfRhOWYTNg7nuAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=X1YrToIE; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cc864215caso243628639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711557017; x=1712161817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3/CPQu0kt0AK01jL1gmP6nDgmIk8fvdY19xmLzWhxc=;
        b=X1YrToIEWbucSZinabH7a/qI2G/G/z8chDkmVa01DXHqvnjsDb4uBs/U+GiC3IiaLg
         kgQTiDNqd/bUDOKnIs0gJ5xcQZk9QeHetNYQ1p7YgMdjGu3Jvg/VFXuTzCmVbcgiqgmz
         BRyHsJZD/D2XxeYG+xBXJbW8isx7kuLAHlGCl36bizmOudYHCQEKB130C0Ym3wP4EbXq
         QjMBbqI60TcDWsVUeoUllxzK5Lu9magd0I5io5ZvV1FDc7IHgU+zva/17RfE51Z1EJAU
         Okxc2IWmZ6Wu4nofn+GebEaGM96msvo9ZkaDHjUcwfpG/oxk6tBxbKt8k73NXFPn1I51
         T5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557017; x=1712161817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3/CPQu0kt0AK01jL1gmP6nDgmIk8fvdY19xmLzWhxc=;
        b=bfIRem8Wl2toVcz7wQeYgsUgYFE7hRz+gmb7TlUtR1LQfX01NFd68X/5gxmc+6Np0c
         8e49f1QFasach7YhxvsS7Jw8urbiyM54B/fN3XL98PRodi+ipMOYmleXurseBYk4C9EB
         PKnbNgdHRO12QouUMJNeaJAU+Gh2XYrxyKqL7sEvK5p/ZW9HpWSPcsTGPeGx3+4diBZz
         MWhYujaM45jVlDGVYsrMxlihcfsaoS7jmz71AhvIaZK1p9ABlzlBB5AmD6SI+CW7NPfI
         1CHj7N1rRYHRmoCAnpbxSAD8OeqNKokynkk9VIhTVTd9rEkAQ/t/ss/xzW1p6kDmiMUX
         3MRA==
X-Forwarded-Encrypted: i=1; AJvYcCWz8PMzz2iHPSxlG5//JeUL2pBIik1GuwsaTG1LG1Wv+FaSmiCzaGwV1bIAKjKgHyQrUUnTPxgkJn6QqeEttVvx05AKm+YVC4mxTQ57
X-Gm-Message-State: AOJu0YyAL4NSCq4IaZDkHiheXDpCjUNPML26I2hhK975zgCyhD6lAJfn
	FyJzuYpzlU3MpNcY9BCY3ugtbmia6VMHyoD7e6J0ob9V6QitogK2gkYXS3R1TOo=
X-Google-Smtp-Source: AGHT+IEy3lKCG/WWVtYoOT4PxqKJ027BC01H+gdizwaqfKFmuLxv8JHVT57g0CZAesVwbRKs+7j44w==
X-Received: by 2002:a6b:da06:0:b0:7d0:2b22:7221 with SMTP id x6-20020a6bda06000000b007d02b227221mr502270iob.20.1711557017625;
        Wed, 27 Mar 2024 09:30:17 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id h8-20020a056602130800b007cc840d1d0bsm3647584iov.25.2024.03.27.09.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:30:17 -0700 (PDT)
Message-ID: <4f89f7e4-cd89-42a7-a13e-5eb25f7b2f4e@sifive.com>
Date: Wed, 27 Mar 2024 11:30:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clocksource/drivers/timer-clint: Add
 set_state_shutdown
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240327153502.2133-1-jszhang@kernel.org>
 <20240327153502.2133-3-jszhang@kernel.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240327153502.2133-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jisheng,

On 2024-03-27 10:35 AM, Jisheng Zhang wrote:
> Add clocksource detach/shutdown callback to disable RISC-V timer interrupt when
> switching out clockevent from clint timer to another timer.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/clocksource/timer-clint.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index 09fd292eb83d..56cf6c672e6d 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -119,11 +119,21 @@ static int clint_clock_next_event(unsigned long delta,
>  	return 0;
>  }
>  
> +static int clint_clock_shutdown(struct clock_event_device *evt)
> +{
> +	void __iomem *r = clint_timer_cmp +
> +			  cpuid_to_hartid_map(smp_processor_id());
> +
> +	writeq_relaxed(ULONG_MAX, r);

This needs to be ULLONG_MAX to produce a 64-bit value on riscv32.

Regards,
Samuel

> +	return 0;
> +}
> +
>  static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
> -	.name		= "clint_clockevent",
> -	.features	= CLOCK_EVT_FEAT_ONESHOT,
> -	.rating		= 100,
> -	.set_next_event	= clint_clock_next_event,
> +	.name				= "clint_clockevent",
> +	.features			= CLOCK_EVT_FEAT_ONESHOT,
> +	.rating				= 100,
> +	.set_next_event			= clint_clock_next_event,
> +	.set_state_shutdown		= clint_clock_shutdown,
>  };
>  
>  static int clint_timer_starting_cpu(unsigned int cpu)


