Return-Path: <linux-kernel+bounces-101714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5770287AAE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96E91F22A53
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91204481BA;
	Wed, 13 Mar 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cwsBynug"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2147A6A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346017; cv=none; b=gKL6Er4oqjJMjeVXeiRI4ImGQXnjP2vq/zPt8W/e4ASlbE40faHOLA4i2jo7Ri4gcq9XM0CPfZtA7n7bHg1Wyyk8/VawJFRqc942QImAPkUbp8qC4ad+wCJfePllsBJo6SNnJlXU3tQxr7M2l75wxxPssdUmVvXVTYd7EFsmbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346017; c=relaxed/simple;
	bh=IXfTIdGk9Ela9nCx1kCr/XPl5dOMqlKILE6AIYXcKL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFVKRVGkBXAAg1JQGumd9/q3ifrr321p/kV36gKXq8In9+e12vfMnR9/lAK4MkKe8v/5TkqHvT+9q7ipH9mg0ZKalDOiayaKez5rru/LQabLUnG6tIYVRuH+zytDPmjXG3pzfxe9Af08YKdaC8DIJNX0p3UlH/B565k35of35HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cwsBynug; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-781753f52afso477585985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710346015; x=1710950815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRzWQkcGI4VUKzs6gwS4GB6+OKCj9YOx8VUKrvxZkDE=;
        b=cwsBynug/pds+AIJYd/588LaU6JiCRVfloKqN0r1QcVoOjyvdgxTn0Hhn8zFq/GTGW
         QSTPt5zqV/PUOvjOKDw7bIA4vLBZpsjyA2x8PxgG0k4LKXk59Ev5faLmfB8IkTfATnPH
         S+Ys0/Q6FQEnbDTd1KcuJAg3bZaGZMVCuiH8kuMv3+gwpm6fAx4VluYS8dman87Ww0OY
         8Fc4e9SMS9gWFtjwmzJRmgl+1ErUaUuiWw4+AHSbyBo8ICs3tFDMbB5UY7idzcPFl9P2
         41mJI0kRGAj1SlIZx+fnUIs6s6lot7FaswEXTUH66jI1Hp3KSXcITX8csvZrEDQgOmbz
         SQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710346015; x=1710950815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRzWQkcGI4VUKzs6gwS4GB6+OKCj9YOx8VUKrvxZkDE=;
        b=LxT5o7c0V46toBQIOru3X0fT5Ag/KKvMTKAwiYUOlww/vem3aoIK0Kr8yVXaLaII0A
         c7OLllPvwxASk9mdLvr5dWR33/exPdnjJtDzP/ITtT8jEBLlq1/1vqD8iBjn4QCopUKZ
         7Jbeznrs4aZ7Jj+hAZdjUaoSRT3BOp00uL7w3/19wcB0hjV5m3L1Vnctr8BrGuIv4RLL
         9w5dXjEnhRWfxamA2eqZFtYYOBpmcXWyf2wsqlborFNnWMQ54Ti7uShOsPW6hprKD5w5
         HroHoZySAx2gfVwSVzezj7y18V7416/N5B0KDvXLJnJ3iH+jiV/kB1jB9GocQrUT8RQO
         dx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVh+3DKVThjhx2zsdma62PcOA3poMnsWEgFT1+aqBlJ0f3KMR+Twtiz+4CrxwaLaTrgyavwOiZwnw5Kn7DTvXCIpNg+7qOa+Q33gzzI
X-Gm-Message-State: AOJu0YxZaGop/tnsKr+em++ZbCg7kDDJzyCp0kVi4/sd7gza3/O0L92y
	ICpRd8VSPnIl8JRu8KwILsMcYlv4LghoKBG3m5002YNCz3vUXWDVRdAQ05toF612+Kx79uOuGWp
	U
X-Google-Smtp-Source: AGHT+IF66winHwsZTzBvf8Uey5RMKI0SX4CQ5488zJ8YeRxzDzvy84lnyO0cdv/SDDbyPhlyPr9KWw==
X-Received: by 2002:a05:620a:5634:b0:788:731d:7120 with SMTP id vv20-20020a05620a563400b00788731d7120mr284640qkn.19.1710346015070;
        Wed, 13 Mar 2024 09:06:55 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id k25-20020a05620a07f900b007884003f9a0sm4895880qkk.122.2024.03.13.09.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:06:54 -0700 (PDT)
Message-ID: <aac2aeca-0447-4f2f-ab3b-b4412e8a09f1@sifive.com>
Date: Wed, 13 Mar 2024 11:06:53 -0500
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
 <42665ccc-d020-48c4-a5bb-2713f7cbb75c@linaro.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <42665ccc-d020-48c4-a5bb-2713f7cbb75c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-03-13 9:43 AM, Daniel Lezcano wrote:
> On 12/03/2024 20:25, Samuel Holland wrote:
>> Commit 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a
>> platform driver") broke the MMIO timer on the Allwinner D1 SoC because
>> the IRQ domain is no longer available when timer_probe() is called:
> 
> Did you mean: s/no longer available/not yet available/ ?

I mean that, before this commit, the IRQ domain was available during
timer_probe(); but after this commit, the IRQ domain is not available during
timer_probe().

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
>> ---
>>
>>   drivers/clocksource/timer-sun4i.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-sun4i.c
>> b/drivers/clocksource/timer-sun4i.c
>> index 7bdcc60ad43c..728dac2baa84 100644
>> --- a/drivers/clocksource/timer-sun4i.c
>> +++ b/drivers/clocksource/timer-sun4i.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>>     #include "timer-of.h"
>>   @@ -218,9 +219,24 @@ static int __init sun4i_timer_init(struct device_node
>> *node)
>>   }
>>   TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
>>                  sun4i_timer_init);
>> -TIMER_OF_DECLARE(sun8i_a23, "allwinner,sun8i-a23-timer",
>> -         sun4i_timer_init);
>> -TIMER_OF_DECLARE(sun8i_v3s, "allwinner,sun8i-v3s-timer",
>> -         sun4i_timer_init);
>>   TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
>>                  sun4i_timer_init);
>> +
>> +static int __init sun4i_timer_probe(struct platform_device *pdev)
>> +{
>> +    return sun4i_timer_init(dev_of_node(&pdev->dev));
>> +}
>> +
>> +static const struct of_device_id sun4i_timer_of_match[] = {
>> +    { .compatible = "allwinner,sun8i-a23-timer" },
>> +    { .compatible = "allwinner,sun8i-v3s-timer" },
>> +    { /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver sun4i_timer_driver = {
>> +    .driver    = {
>> +        .name        = "sun4i-timer",
>> +        .of_match_table    = sun4i_timer_of_match,
>> +    },
>> +};
>> +builtin_platform_driver_probe(sun4i_timer_driver, sun4i_timer_probe);
> 


