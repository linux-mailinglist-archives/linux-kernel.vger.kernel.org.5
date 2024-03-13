Return-Path: <linux-kernel+bounces-101722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D288F87AB03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB401C21C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AFF482D0;
	Wed, 13 Mar 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T8o0MjmK"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518247F73
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347021; cv=none; b=JxiWvvHwdIvqrl6Z0lzKKyTSmEiomQqLoY3crRNSPYkq+yBDQ2K9T+Kv1wxbpYU7g4CXMxsQiKP3Jq0elAUGwVjX8ZxYrouE9Gp/ur1vuGJpb+jhLCt3G5PeTUNme2sqlExLNVcS7K4qqQdiwFpDZJSuGleLjYJVshKURPt6Ugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347021; c=relaxed/simple;
	bh=Boowo1J6tdnxaf6TrdGpUu6xqdfk+Nnc/rN7p9MrCWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmgOQf3ZMY6+GOoz9G1ugbTjki0TOoVvyruBlohxDsAXx1YOZmQWf8TLkaPKmH79T9M+DDJw+pWd7P3xOxE1Obs5jKHZr7+yBMc48FimbBZ8gukEpM/CSP9kbwC2Mb/9gyB2hl9f+pnoLlzdpaZUohFQ+paYeYCbsjKQJLHSVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=T8o0MjmK; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68ee2c0a237so505526d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710347018; x=1710951818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azgghDatY9Rxnoyec+Q+8O2UeCiS6yMjUBITF9dU9ZQ=;
        b=T8o0MjmK6VElfuH4AiZrfrAUPV/yrMguEvZESqBdpoQpfQrX7tdBT8sfdoa5kS41sn
         N3SnfrlywcEmorhYe677wtSBkK/212ropZuK5b2pdQ61ysR2A5OzK79mMzmjtAPX0jKI
         vX33Dx3fmtNf2+q2YPNu3UVdKJndMeELvgOvKKWsJcdQPhvsfqoi0qnjqjLmUdm46Q12
         LyGaMRNiZnDEIuSPwi28qhBbw0pM0FRebPZH7vG7/4w2UF6/FCCWWUokUN2AQBG8DRYb
         5szfRaBeK/FgdUYjhEpYZQa3ys17i2Ll8wOGg8jh4WQA/E+NHGqDus1NDzrib7XM3Plr
         7WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347018; x=1710951818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azgghDatY9Rxnoyec+Q+8O2UeCiS6yMjUBITF9dU9ZQ=;
        b=kDGHzYZQb2mKIl05ro0Zm9dMcKJwPNduUeYML0QNBtnhdSZoxZhQmvGOp+I8TxU+r7
         NdaDE0aCnww8mj5zPYXuuXkv4d2wm6WLI48b0rfdY3OsKNDKVwelNaHvSlXfHmfIclHr
         3RlqiyGg7Z38nuk4O57BYUJ5nYDrfHT/5uM+xViSVQhMnecgsbKpNDZTAuycukJgoRvv
         fNVSHDWhWwp/nHoYogkxYe4QhWPBNLfaX97j0k8zWIMU8QEqufZwbMLhfx5GBqWRBlOk
         C8N7GIpf4o/SPsuSBQX+pjTrFfNZXnrBgh2MM3KHtC+sI3w0KKF40KhBN0FGvhVlkWTu
         20nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTTd2KygzvDpJ8gOZqX7ofLM7km6PcCK3f4oArzixvuRboxSuw7NPG53YN58ioWggn2SNfkKt6luyiKrI6YmKT3cvbYr7hC+WujPrN
X-Gm-Message-State: AOJu0YyrECF/sx78Szs1iuSCabTqOSTto01LNn9HCkCGrkgxJm5MDLWK
	xNZ1ofJdZMiBZ/OAqQGti9gjZNr/3On37pSKn08ePtewcESqppoSQqzmIeA3gL4=
X-Google-Smtp-Source: AGHT+IGYIV8uYoqL4auSgQDqWaM2t72bdF5Dhxc8OhmTtRKW7l5mFr43UTUD1LQJuVrbO1IN0YIrrQ==
X-Received: by 2002:a05:6214:1650:b0:690:9e6d:efe9 with SMTP id f16-20020a056214165000b006909e6defe9mr553361qvw.27.1710347018666;
        Wed, 13 Mar 2024 09:23:38 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id jh18-20020a0562141fd200b0068ff8d75a90sm4900672qvb.19.2024.03.13.09.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:23:38 -0700 (PDT)
Message-ID: <3e0a75a8-2c3d-478a-9e16-f6252cae3367@sifive.com>
Date: Wed, 13 Mar 2024 11:23:37 -0500
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
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <apatel@ventanamicro.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240312192519.1602493-1-samuel.holland@sifive.com>
 <d68fd8a7-8889-472e-86db-b62855eebfba@linaro.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <d68fd8a7-8889-472e-86db-b62855eebfba@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-03-13 10:29 AM, Daniel Lezcano wrote:
> On 12/03/2024 20:25, Samuel Holland wrote:
>> Commit 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a
>> platform driver") broke the MMIO timer on the Allwinner D1 SoC because
>> the IRQ domain is no longer available when timer_probe() is called:
>>
>>    [    0.000000] irq: no irq domain found for interrupt-controller@10000000 !
>>    [    0.000000] Failed to map interrupt for /soc/timer@2050000
>>    [    0.000000] Failed to initialize '/soc/timer@2050000': -22
>>
>> Fix this by wrapping the timer initialization in a platform driver.
>> builtin_platform_driver_probe() must be used because the driver uses
>> timer_of_init(), which is marked as __init. Only convert the sun8i
>> variants of the hardware, because some older SoCs still need the timer
>> probed early for sched_clock().
>>
>> Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform
>> driver")
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> Why EPROBE_DEFER in thermal-of can not fix the issue?
> 
> I mean can't we check if of_irq_get_byname() returns EPROBE_DEFER and then
> return this value?

EPROBE_DEFER would not help either before or after this patch.

Before this patch, the driver uses TIMER_OF_DECLARE, which means the timer gets
initialized from the loop in timer_probe(). That function does not retry if the
initialization function returns EPROBE_DEFER. And timer_probe() is only meant to
be called once, before any platform drivers are registered.

It does not help after this patch either, because __platform_driver_probe() also
requires the probe to succeed the first time. This is needed to ensure the probe
function runs before __init memory is discarded. (To support deferred probing in
timer-of, none of the functions could be marked as __init.)

But that is okay, because if both the irqchip and the timer use platform
drivers, fw_devlink ensures they are probed in the right order. So this patch
reliably allows the timer to probe successfully.

Regards,
Samuel


