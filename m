Return-Path: <linux-kernel+bounces-56401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2662884C9BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575A41C21D69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5231C1B803;
	Wed,  7 Feb 2024 11:40:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67F719BBA;
	Wed,  7 Feb 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306015; cv=none; b=CKV/gds3KbB1VeZAnd5goStomhwAs4jdqdiJcMMffMNlK9Ih7HJYxwwv8+meRFaowyG57Jy9a1FvEVJJupG7yDP4FY7tq+L6v0r24Xdm0xhWDbwJLym3lDXmjTLokq2Z7Aiq0MNiicFnDCL69tokAI0M+e1gkhOc26khoiwQie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306015; c=relaxed/simple;
	bh=3RxULCQqTCej+mKyEk8otgcgo4i+w98owSqN13Hn9aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwfvRJqkzbWwuy6WLxLxIP/6t75Rj0kdrRbx4lLumYeV4DjDcs3di2Hww3fD+QIJIO3KV6K1BQJmnfEA12phl/Qu2agRf9nPuHQyROOooolMpE3t4jTn7sDPUwAleY2fxuxnt/9L6Xp+aAziOQFt4JWjrtaTAd+69QHMOlo102Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8802A1FB;
	Wed,  7 Feb 2024 03:40:48 -0800 (PST)
Received: from [10.1.30.29] (e133649.arm.com [10.1.30.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5803F762;
	Wed,  7 Feb 2024 03:40:04 -0800 (PST)
Message-ID: <8e969ccb-888d-43c8-a9a2-d46bad4bf5e8@arm.com>
Date: Wed, 7 Feb 2024 11:40:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/23] PM: EM: Optimize em_cpu_energy() and remove
 division
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-16-lukasz.luba@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240117095714.1524808-16-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2024 09:57, Lukasz Luba wrote:
> The Energy Model (EM) can be modified at runtime which brings new
> possibilities. The em_cpu_energy() is called by the Energy Aware Scheduler
> (EAS) in its hot path. The energy calculation uses power value for
> a given performance state (ps) and the CPU busy time as percentage for that
> given frequency.
> 
> It is possible to avoid the division by 'scale_cpu' at runtime, because
> EM is updated whenever new max capacity CPU is set in the system.
> 
> Use that feature and do the needed division during the calculation of the
> coefficient 'ps->cost'. That enhanced 'ps->cost' value can be then just
> multiplied simply by utilization:
> 
> pd_nrg = ps->cost * \Sum cpu_util
> 
> to get the needed energy for whole Performance Domain (PD).
> 
> With this optimization and earlier removal of map_util_freq(), the
> em_cpu_energy() should run faster on the Big CPU by 1.43x and on the Little
> CPU by 1.69x (RockPi 4B board).
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   include/linux/energy_model.h | 54 ++++++++++--------------------------
>   kernel/power/energy_model.c  |  7 ++---
>   2 files changed, 17 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 689d71f6b56f..aabfc26fcd31 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> [...]
> @@ -208,8 +206,9 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>   				return -EINVAL;
>   			}
>   		} else {
> -			power_res = table[i].power;
> -			cost = div64_u64(fmax * power_res, table[i].frequency);
> +			/* increase resolution of 'cost' precision */
> +			power_res = table[i].power * 10;

NIT: Does this have to be 10, or something simple like << 3 (* 8) also 
does the job?

Although compiler these days often are clever enough to convert x * 10 
into (x << 3) + (x << 1), and this is not on the hot path anyway, so 
just a NIT.

> +			cost = power_res / table[i].performance;
>   		}
>   
>   		table[i].cost = cost;

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>

