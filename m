Return-Path: <linux-kernel+bounces-96687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FBA876000
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8F51C22659
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0152F90;
	Fri,  8 Mar 2024 08:44:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39452F6B;
	Fri,  8 Mar 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887481; cv=none; b=ltgqxfdBVxHy5xkPk3a5kJRp7BHMh5erof3NxpIptz5FAfkghb1uTGRZY5aeAqM9dQRm2JTFUBNiR6r00IlYucUfXGs3sCLAI6kIpU3p0un8IScFNg52Ps7dYAecIMgqlf8+d6u5nucmhnpTnXoR1DwkQl+YWnfoWKecFv9HN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887481; c=relaxed/simple;
	bh=14VPe0pUD24RgR8UUeJpMDtadw2Rx3IIZ/obF0bI/aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejnkSnFfjBc13XHcdJAm/tOjRRmoR0ydlxCJjBXD/khwFAe/KiJ/I3lMjTgxxJmuBjm7er8M7MBiPHDhUPs7gaJ99AqUm0fOXOdfTlA6QxcBlw6bZmmBAr1CAInFR9cOWx0EyDaZVeIZRFn677LNuD8fXqDIY7a6JnF7niuVd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D274C15;
	Fri,  8 Mar 2024 00:45:10 -0800 (PST)
Received: from [10.57.10.181] (unknown [10.57.10.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79A893F762;
	Fri,  8 Mar 2024 00:44:30 -0800 (PST)
Message-ID: <3a11f361-4bb5-4a17-b07d-aac549264cc8@arm.com>
Date: Fri, 8 Mar 2024 08:44:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: cooling: Fix unneeded conversions in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To: PoShao Chen <poshao.chen@mediatek.com>
Cc: dietmar.eggemann@arm.com, rafael@kernel.org, mingo@kernel.org,
 rafael.j.wysocki@intel.com, rui.zhang@intel.com, vincent.guittot@linaro.org,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com,
 clive.lin@mediatek.com, ccj.yeh@mediatek.com, ching-hao.hsu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240308065922.10329-1-poshao.chen@mediatek.com>
 <20240308065922.10329-2-poshao.chen@mediatek.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240308065922.10329-2-poshao.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi PoShao,

On 3/8/24 06:59, PoShao Chen wrote:
> Fix the incorrect division of power values by MICROWATT_PER_MILLIWATT for
> non-microwatt units in the Energy Model (EM) by adding an
> em_is_microwatts() check. This ensures that power values are only converted
> when the EM specifies microwatts, allowing for accurate interpretation of
> power according to the unit defined by the EM.
> 
> Signed-off-by: PoShao Chen <poshao.chen@mediatek.com>
> ---
>   drivers/thermal/cpufreq_cooling.c |  6 ++++--
>   drivers/thermal/devfreq_cooling.c | 12 ++++++++----
>   2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 9d1b1459700d..5324b9766843 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -120,7 +120,8 @@ static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
>   	}
>   
>   	power_mw = table[i + 1].power;
> -	power_mw /= MICROWATT_PER_MILLIWATT;
> +	if (em_is_microwatts(cpufreq_cdev->em))
> +		power_mw /= MICROWATT_PER_MILLIWATT;
>   	rcu_read_unlock();
>   
>   	return power_mw;
> @@ -139,7 +140,8 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>   	for (i = cpufreq_cdev->max_level; i > 0; i--) {
>   		/* Convert EM power to milli-Watts to make safe comparison */
>   		em_power_mw = table[i].power;
> -		em_power_mw /= MICROWATT_PER_MILLIWATT;
> +		if (em_is_microwatts(cpufreq_cdev->em))
> +			em_power_mw /= MICROWATT_PER_MILLIWATT;
>   		if (power >= em_power_mw)
>   			break;
>   	}
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 50dec24e967a..c28e0c4a63d6 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -222,7 +222,8 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>   			dfc->res_util = table[state].power;
>   			rcu_read_unlock();
>   
> -			dfc->res_util /= MICROWATT_PER_MILLIWATT;
> +			if (em_is_microwatts(dfc->em_pd))
> +				dfc->res_util /= MICROWATT_PER_MILLIWATT;
>   
>   			dfc->res_util *= SCALE_ERROR_MITIGATION;
>   
> @@ -247,7 +248,8 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>   		*power = table[perf_idx].power;
>   		rcu_read_unlock();
>   
> -		*power /= MICROWATT_PER_MILLIWATT;
> +		if (em_is_microwatts(dfc->em_pd))
> +			*power /= MICROWATT_PER_MILLIWATT;
>   		/* Scale power for utilization */
>   		*power *= status.busy_time;
>   		*power >>= 10;
> @@ -279,7 +281,8 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
>   	*power = table[perf_idx].power;
>   	rcu_read_unlock();
>   
> -	*power /= MICROWATT_PER_MILLIWATT;
> +	if (em_is_microwatts(dfc->em_pd))
> +		*power /= MICROWATT_PER_MILLIWATT;
>   
>   	return 0;
>   }
> @@ -321,7 +324,8 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>   	for (i = dfc->max_state; i > 0; i--) {
>   		/* Convert EM power to milli-Watts to make safe comparison */
>   		em_power_mw = table[i].power;
> -		em_power_mw /= MICROWATT_PER_MILLIWATT;
> +		if (em_is_microwatts(dfc->em_pd))
> +			em_power_mw /= MICROWATT_PER_MILLIWATT;
>   		if (est_power >= em_power_mw)
>   			break;
>   	}

Thanks for the patches and reporting this!

I have checked the commit which introduced the micro-Watts.
All the drivers where aligned to register the new uW values, also
your mediatek-cpufreq-hw.c
ae6ccaa650380d243

I have also check current upstream and all drivers there provide
the uW to the em_dev_register_perf_domain().

Is it some out-of-tree kernel driver, which shows this issue?

I would need to check all places and force actually to provide the
uW to the EM registration function. It's pointless to try to support
mW just because the flag in the registration wasn't set by some
downstream driver.

Let me re-write that bit in the EM...

Regards,
Lukasz

