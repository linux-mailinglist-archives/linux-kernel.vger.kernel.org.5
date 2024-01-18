Return-Path: <linux-kernel+bounces-30066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0028318AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B15B22883
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433F424200;
	Thu, 18 Jan 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDHwppeY"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72492241EC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578618; cv=none; b=Dtmxqvw8L77ya3RA6Vz4G0odQEzr4lAvUnEvPQtCjQeyJd8FP1JiBoPfjy8rN+ew/1D2nv34gNYgJASPzk3x4cBkmqYu6nYxDUPbdGGYfOLh60Q5dgp1cdqFZWMIrmXSge/OcZRXGLHFbiDx+JwGd4Iv9Xe5LrUCv3Dw+zWKs2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578618; c=relaxed/simple;
	bh=JfxPQ9ZGoUCLZLX2pJcftrwbnXNrXF5TdzRGFvSVOQc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=iJgPzi2mHP+yjKmhEvjvfW7RwRb86KEg7xdM1N2D+Cq14SKxUq5vVVR0AVw7xiik2XtHQN2TCqgZ0+zxEjMxSd0N7JfKWqJrPXsy6OGffSRRSg3V8q59E+naD4KdRkmtzny2L+yrfxb665y+nLTHk44bCd26YR6f/nnN6849NBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lDHwppeY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so7092355e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705578611; x=1706183411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdwYfun3vH8Oq8L5awMS7sARdj8og2hapLE1LocJxsY=;
        b=lDHwppeYbpc/dcTk6IWP7wZm3WqcPkIab2dvQt/QgEjzMb0/BCHdFS3Tue2UaU8VyK
         bZRmL9xrKZWEqElIHdw19p8NHJd7XkkAGj1rwG50V1qre8gRnFZUOI7aTxz3C8yy5Erg
         3QCfANBd5aTHO+KjtmNTD+8jBQI/5AtMiID5lrvClCSMgfdjBXUh9QIcTt2Onzv4VWR+
         MNBvbjhvu7iU/dW4Gx+9EkszDOR1CBdIh1f126/NsUK+QTKZFQorl1Kqa9t8nnGzCxz3
         yHC4jjaSVuDjZsppPvNrLsLRSymt0TKzcltgHPE72Y+vnYxxp6VnxQgqNek/l7irIKQb
         ni6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705578611; x=1706183411;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdwYfun3vH8Oq8L5awMS7sARdj8og2hapLE1LocJxsY=;
        b=FP6BZNhFADpS/gORu5Addw7byC/4Gysw0r9cpFJPM0AoLz6oOQIMy9te3rowm51/VY
         WbZruY8oNAxg8hQ44XNqwvDOrKFJ6aaqdz7V/P3OVhmnplEdwTTtnYAGZwFAfLrvocjj
         ZWIclr28gG0UjcScSMSfvLCpmsJFed2g7iI1HUvlgYcdxRRJou3a9cf6fIKAa+dPPdQN
         Ov8Y/2Qjbxd5aUeeyXeknMs/yrmpUSDW0ptT79toyzwk2SsuXDl9knd7gDRoqxxGQyiN
         +/vTkQ0J+00UdJbw2GCnOavPDiQlTJQNCM32rfdxyHEkStURb4nmHMsfOAg2NE4HuLsO
         l0GQ==
X-Gm-Message-State: AOJu0YxQ5TznJ4Ws5Em3naqv85ZAqqX3QW4r77cyCGmER4d731HfH5dM
	LQqH51CFMmsdX+GkqMLv4ARfowXTF/VwIZs2ongXkNE6cs8mPkI0asjtc9uXSbw=
X-Google-Smtp-Source: AGHT+IEISqP8npBGteYX7EQNFTuMgnJszgeo5Lf+LmbI8tLStSfbMDPPh2Q6n93xXnPh8xlwYR3UeA==
X-Received: by 2002:a05:600c:6a9a:b0:40e:6b94:db5f with SMTP id jl26-20020a05600c6a9a00b0040e6b94db5fmr446884wmb.171.1705578611664;
        Thu, 18 Jan 2024 03:50:11 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id t5-20020a05600c450500b0040d6d755c90sm25589187wmo.42.2024.01.18.03.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 03:50:11 -0800 (PST)
Message-ID: <3eace156-b097-4076-a585-e7a61d798fc8@linaro.org>
Date: Thu, 18 Jan 2024 12:50:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] timer drivers for v6.8-rc1
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Tony Lindgren <tony@atomide.com>,
 Joshua Yeong <joshua.yeong@starfivetech.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Inochi Amaoto <inochiama@outlook.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <0f07af92-e4b2-48de-88a6-dd9aa9e49743@linaro.org>
In-Reply-To: <0f07af92-e4b2-48de-88a6-dd9aa9e49743@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

it seems this PR was not taken into account.


On 01/01/2024 19:21, Daniel Lezcano wrote:
> 
> Hi Thomas,
> 
> happy new year 2024!
> 
> Please consider pulling these changes.
> 
> AFAICT, we had a few submissions recently with a finalized consensus, so 
> this is a small set of changes, most of them being fixes.
> 
>    -- Daniel
> 
> The following changes since commit 
> da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5:
> 
>    timers: Fix nextevt calculation when no timers are pending 
> (2023-12-20 16:49:39 +0100)
> 
> are available in the Git repository at:
> 
>    http://git.linaro.org/people/daniel.lezcano/linux.git 
> tags/timers-v6.8-rc1
> 
> for you to fetch changes up to c0c4579d79d0df841e825c68df450909a0032faf:
> 
>    clocksource/drivers/ep93xx: Fix error handling during probe 
> (2023-12-27 15:37:11 +0100)
> 
> ----------------------------------------------------------------
> - Fixed error handling at probe time and uninitialized return code on
>    ep93xx (Arnd Bergman)
> 
> - Fixed some kerneldoc warning on Cadence TTC (Randy Dunlap)
> 
> - Fixed kerneldoc warning on Timer TI DM (Tony Lindgren)
> 
> - Handle interrupt disabling when shutting down the timer on RISC-V
>    timer (Joshua Yeong)
> 
> - Add compatible string for the StarFive JH8100 clint (Sia Jee Heng)
> 
> - Separate mtime and mtimecmp registers in DT bindings (Inochi Amaoto)
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>        clocksource/drivers/ep93xx: Fix error handling during probe
> 
> Inochi Amaoto (1):
>        dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and 
> mtimecmp regs
> 
> Joshua Yeong (1):
>        clocksource/timer-riscv: Add riscv_clock_shutdown callback
> 
> Randy Dunlap (1):
>        clocksource/drivers/cadence-ttc: Fix some kernel-doc warnings
> 
> Sia Jee Heng (1):
>        dt-bindings: timer: Add StarFive JH8100 clint
> 
> Tony Lindgren (1):
>        clocksource/drivers/timer-ti-dm: Fix make W=n kerneldoc warnings
> 
>   .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
>   .../bindings/timer/thead,c900-aclint-mtimer.yaml   |  9 ++++++++-
>   drivers/clocksource/timer-cadence-ttc.c            | 22 
> ++++++++++++++++------
>   drivers/clocksource/timer-ep93xx.c                 |  5 ++---
>   drivers/clocksource/timer-riscv.c                  |  7 +++++++
>   drivers/clocksource/timer-ti-dm.c                  |  4 ++--
>   6 files changed, 36 insertions(+), 12 deletions(-)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


