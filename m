Return-Path: <linux-kernel+bounces-137129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C789DD4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC7A2886E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE657873;
	Tue,  9 Apr 2024 14:48:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756050A62;
	Tue,  9 Apr 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674099; cv=none; b=ljS02200U3/2JsGoDqjmrjlOowSWzbFtTkdJJIsPb+Ujsjo3RGs1o6Q8fzvv7bYcmKAoWvjzmBjTZYzzOyAkAsS//2BzLvreKPPcJZm9cpxSlN7Yhmqv+AdNkieJUzE2frv7VCiyaAdLVmTA1y44EkD300LbKDppplQe3Nw3sdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674099; c=relaxed/simple;
	bh=sn5l4qk+TszXiL1PZ/62r7T17X8+sQejtuKb+d32hN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGSqHdlH+ckrEyCGzxLxihX0WYNtRupzvYoO7oKZvDFG8Yjy8Epp9//CNRefFkLpiUAmmDtwOKLL+BM7IzNmbRsGRcZx32wsrw6tD95XepEB7cDAYyiu3LiUOkf4cQSt/yI7eDdGRWrMYNOklpomQUU4e2ZcCkhX14fvwQ1RUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E354139F;
	Tue,  9 Apr 2024 07:48:47 -0700 (PDT)
Received: from [10.57.19.31] (unknown [10.57.19.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48B533F766;
	Tue,  9 Apr 2024 07:48:15 -0700 (PDT)
Message-ID: <08bff6ab-dcdc-42b6-b8ad-5938f0119385@arm.com>
Date: Tue, 9 Apr 2024 15:47:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: EM: Add min/max available performance state
 limits
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 sudeep.holla@arm.com, cristian.marussi@arm.com,
 linux-samsung-soc@vger.kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org, quic_sibis@quicinc.com
References: <20240403162315.1458337-1-lukasz.luba@arm.com>
 <20240403162315.1458337-2-lukasz.luba@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240403162315.1458337-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/2024 17:23, Lukasz Luba wrote:
> [...]
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 927cc55ba0b3d..1a8b394251cb2 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -628,6 +628,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>   		goto unlock;
>   
>   	dev->em_pd->flags |= flags;
> +	dev->em_pd->min_ps = 0;
> +	dev->em_pd->max_ps = nr_states - 1;
>   
>   	em_cpufreq_update_efficiencies(dev, dev->em_pd->em_table->state);
>   
> @@ -856,3 +858,49 @@ int em_dev_update_chip_binning(struct device *dev)
>   	return em_recalc_and_update(dev, pd, em_table);
>   }
>   EXPORT_SYMBOL_GPL(em_dev_update_chip_binning);
> +
> +
> +/**
> + * em_update_performance_limits() - Update Energy Model with performance
> + *				limits information.
> + * @pd			: Performance Domain with EM that has to be updated.
> + * @freq_min_khz	: New minimum allowed frequency for this device.
> + * @freq_max_khz	: New maximum allowed frequency for this device.
> + *
> + * This function allows to update the EM with information about available
> + * performance levels. It takes the minimum and maximum frequency in kHz
> + * and does internal translation to performance levels.
> + * Returns 0 on success or -EINVAL when failed.
> + */
> +int em_update_performance_limits(struct em_perf_domain *pd,
> +		unsigned long freq_min_khz, unsigned long freq_max_khz)
> +{
> +	struct em_perf_state *table;
> +	int min_ps = -1;
> +	int max_ps = -1;
> +	int i;
> +
> +	if (!pd)
> +		return -EINVAL;
> +
> +	rcu_read_lock();
> +	table = em_perf_state_from_pd(pd);
> +
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +		if (freq_min_khz == table[i].frequency)
> +			min_ps = i;
> +		if (freq_max_khz == table[i].frequency)
> +			max_ps = i;
> +	}
> +	rcu_read_unlock();
> +
> +	/* Only update when both are found and sane */
> +	if (min_ps < 0 || max_ps < 0 || max_ps < min_ps)
> +		return -EINVAL;
> +
> +	pd->min_ps = min_ps;
> +	pd->max_ps = max_ps;

Are we sure we are protected against multiple simultaneous updates? Or 
is this a concern for the caller?

The rest of the patch LGTM.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(em_update_performance_limits);

