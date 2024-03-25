Return-Path: <linux-kernel+bounces-118092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D506D88B3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6752E23C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC474C1B;
	Mon, 25 Mar 2024 22:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSLHW7Cy"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A26CDD6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405346; cv=none; b=Sd8PAs85IzPCTrarETGtBc4R1jF+4fIgxMfuJseATA2Dhx4KWzaQwUG5DgsIm1+IV764SatQm2UOjK1krONFklFp9PfidwLikKCOqkxawFmBMvfqUFgkVztdiSUYe3W0Xd+EpJpRfxje+0Ke8xuV51xv58jXZgWeDR8EcUm5XQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405346; c=relaxed/simple;
	bh=vKW+xoILl2neQcke3VqWqq0fiJGp/n972RtgGuEHtnQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e8Y+t2sfAZLVk21NyHFExxU0QblN5aG6bUfvZR+a2IUxByBwvjOsV3zcFY5ySg49/d9E323Fq+iqZDsVzd6pnnOAeChdd5wS5d28UI2tUpzzzWLIH6SfxjspyHqCgCWlzrqTPhC6lGe/jj6go4jp0Lcf6MwhghpmC2xSsmGnsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSLHW7Cy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1def3340682so39882315ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711405344; x=1712010144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txLs5NtImA2VWZlBubPwip9xSO6gMvbeKarQ47jfmgc=;
        b=CSLHW7CyyT6U7UQKHXBoMso6EG/UdMwqHhLX3dvQMqVvUoBb8N9y/a7WZYlXYS0w8J
         lZZxcbgONlYWDY+FpYD95u06UWXol+sD9B+Txemckhg65cQr4RNM8REAkNnSZfatyMwg
         ZSL1X79HtsEihrrWkHGysemYVR/JEmAQ+1Un/GQbMLFqB92Z2iivH7eVDaUQBgO9uwYb
         H5JfqbQkTWot1Xrfto5/ZcsRiTkW3y8vJESYovBd7Z9sLz0BydwA6XxG2h4qQtLxspY+
         kniRpYw8mxM1xTaGFeeY7Z7CGA8VFLlAM21FZLI/3lnjTrlZli3Be3Ai9+abdsDkVaYS
         wXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405344; x=1712010144;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txLs5NtImA2VWZlBubPwip9xSO6gMvbeKarQ47jfmgc=;
        b=ue0/VoqTlATj6P7BdJM2Os7rAIxzgK18toHVFivVV80/ERqz6hpIA7qdF8+3xMYGGX
         ub2Q7fpDuTaWsugrGYqTF5UTNw0gvEyy0GKt7bnpz1yN882z4eNHRbstiTjZQzOe8zfL
         d7tffXa5Knb7csaSrFxFKLdqw7XPBOK69rd2xS2yZKf/0MZ0fUyb81H2PXyA7/3z3iJB
         Hq3r1p+e2Nb7+BETDhgG9Yr/dj00xF69e5zE08XK01w6Fh/izDppiINV+LIvaD1qQPd3
         aQkYMCMKlN9ozC2QDO+JRKveKIndyN8IbaXdHyb6Q9+jafIb+VV7OoOClA7k3plKbg1t
         bLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvEfFsgbtF5BMZVoyxPSHCBC4qGMTkSX+SzXrdvF2aFvJXuPbCNXVFhVd4NfMuQByYSviLONzwirdxednfDtzsKSt2aUI4/UngC3qc
X-Gm-Message-State: AOJu0Yw6+P7bxJUvNFwVjmw6RANLoakSxLuEBBzrR2F/Qy1EQE7mbPYj
	3dW1kYKTSjuLAbU2TgD7q7upJ9xwFW1hj+Z4RqlNcmxXAmHJG9Nk51t1WE80GhQ=
X-Google-Smtp-Source: AGHT+IGXh5MDhzVnvBPuf+JgibFces6iZpq1uyXY9Jf9I5RUf7oMVvK7FiCeSP1XrC9SZEzJ5qR4rw==
X-Received: by 2002:a17:902:d344:b0:1e0:d0b:25a2 with SMTP id l4-20020a170902d34400b001e00d0b25a2mr9752931plk.41.1711405343855;
        Mon, 25 Mar 2024 15:22:23 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b001dddaa7d046sm5247951ple.29.2024.03.25.15.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:22:23 -0700 (PDT)
Subject: Re: [PATCH 5/5] clocksource/drivers/timer-clint: Add T-Head C9xx
 clint support
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-6-jszhang@kernel.org>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <72eac56e-61d4-e42f-cfbd-8bcc35ed7bb6@gmail.com>
Date: Mon, 25 Mar 2024 15:22:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325164021.3229-6-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 3/25/24 9:40 AM, Jisheng Zhang wrote:
> The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> implement such support.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/clocksource/timer-clint.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index 4537c77e623c..71188732e8a3 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -34,6 +34,7 @@ static unsigned int clint_ipi_irq;
>   static u64 __iomem *clint_timer_cmp;
>   static unsigned long clint_timer_freq;
>   static unsigned int clint_timer_irq;
> +static bool is_c900_clint;
>   
>   #ifdef CONFIG_SMP
>   static void clint_send_ipi(unsigned int cpu)
> @@ -88,6 +89,19 @@ static int clint_clock_next_event(unsigned long delta,
>   	return 0;
>   }
>   
> +static int c900_clint_clock_next_event(unsigned long delta,
> +				       struct clock_event_device *ce)
> +{
> +	void __iomem *r = clint_timer_cmp +
> +			  cpuid_to_hartid_map(smp_processor_id());
> +	u64 val = clint_get_cycles64() + delta;
> +
> +	csr_set(CSR_IE, IE_TIE);
Perhaps you should do a writel_relaxed(-1, r) here. just like openSBI, because the update
to mtimecmp is now split into 2 parts.
https://github.com/riscv-software-src/opensbi/blob/v1.4/lib/utils/timer/aclint_mtimer.c#L54

> +	writel_relaxed(val, r);
> +	writel_relaxed(val >> 32, r + 4);
> +	return 0;
> +}
> +>   static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
>   	.name		= "clint_clockevent",
>   	.features	= CLOCK_EVT_FEAT_ONESHOT,
> @@ -99,6 +113,9 @@ static int clint_timer_starting_cpu(unsigned int cpu)
>   {
>   	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
>   
> +	if (is_c900_clint)
> +		ce->set_next_event = c900_clint_clock_next_event;
> +
>   	ce->cpumask = cpumask_of(cpu);
>   	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
>   
> @@ -233,5 +250,12 @@ static int __init clint_timer_init_dt(struct device_node *np)
>   	return rc;
>   }
>   
> +static int __init c900_clint_timer_init_dt(struct device_node *np)
> +{
> +	is_c900_clint = true;
> +	return clint_timer_init_dt(np);
> +}
> +
>   TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
>   TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> +TIMER_OF_DECLARE(clint_timer2, "thead,c900-clint", clint_timer_init_dt);
> 
Better use a more generic term to describe the fact that mtimecmp doesn't support
64-bit mmio, just like what openSBI is currently doing, instead of making it c900 specific:

https://github.com/riscv-software-src/opensbi/blob/v1.4/lib/utils/timer/fdt_timer_mtimer.c#L152

Then your `is_c900_clint` becomes something like `timecmp_64bit_mmio`.

Bo

