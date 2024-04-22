Return-Path: <linux-kernel+bounces-152898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16868AC5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5633A1F21466
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BA550276;
	Mon, 22 Apr 2024 07:46:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133D4D135;
	Mon, 22 Apr 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771977; cv=none; b=SwxmYGCM+MuBh2cD21agg8cArgqBm8I0X4WgIGa5TeP2MAG2S2LQu3YYTgBNEaGyBL3Y9ppC5sMueSlkMHHu86Xg0woN1t3htXZbiO7t37CJ1AVaYmGva4mDq6RHsVqpGJb8N0w1q/oX751YmZFscJ11aR6uuQATjCoMheyXL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771977; c=relaxed/simple;
	bh=JcnupMm7bC25hniPo7VWk3eKDRk/vCds8Dg/D7e7xUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5S5a8kRtdht9XpJXz9DW/EOZDtWlEW35ORP2B/DrwsTkxadTM0i+lattLlcS6/lKz8MTfMW/NwebmiBdiYzLgpx5+tYKi3hmbeAmhnao0NCmOTzLwV8OatRFYIvgjHCudlbQQhkga0G7DPukJG972pFIcz3RQM43wxdrNMH334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BC79339;
	Mon, 22 Apr 2024 00:46:43 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32D433F7BD;
	Mon, 22 Apr 2024 00:46:13 -0700 (PDT)
Message-ID: <823cbe86-1615-4c68-9995-ef3565c9e42b@arm.com>
Date: Mon, 22 Apr 2024 09:46:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: EM: Add min/max available performance state
 limits
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
 cristian.marussi@arm.com, linux-samsung-soc@vger.kernel.org,
 rafael@kernel.org, viresh.kumar@linaro.org, quic_sibis@quicinc.com
References: <20240403162315.1458337-1-lukasz.luba@arm.com>
 <20240403162315.1458337-2-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240403162315.1458337-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 18:23, Lukasz Luba wrote:
> On some devices there are HW dependencies for shared frequency and voltage
> between devices: CPUs and L3 cache. When the L3 cache frequency is
> increased, the affected CPUs might run at higher voltage and frequency.

IMHO, this is an example where the min Performance State (PS) makes
sense. But what's a use case for the max PS?

> That higher voltage causes higher CPU power and thus more energy is used
> for running the tasks.
> 
> Add performance state limits which are applied for the device. This allows

Regarding device, I thought that this is only applicable for device type
CPU?

> the Energy Model (EM) to better reflect the CPU's currently available
> performance states. This information is used by Energy Aware Scheduler
> (EAS) during task placement to avoid situation when a simulated energy
> cost has error due to using wrong Power Domain (PD) frequency.

Maybe better?

This is important on SoCs with HW dependencies mentioned above so that
the  Energy Aware Scheduler (EAS) does not use performance states
outside the valid min-max range for energy calculation.

> The function performs only bare minimum checks (and requires EM as

s/The function/em_update_performance_limits()

s/EM/PD ... I guess we always pass a PD pointer to all the EM functions.
I guess we can say that an EM consists of at least 2 PDs.
I guess it's valid to say that we limit per PD, e.g. per little CPUs?

[...]

>  /**
>   * em_pd_get_efficient_state() - Get an efficient performance state from the EM
> @@ -189,12 +195,13 @@ int em_dev_update_chip_binning(struct device *dev);
>   */

Missing  min_ps, max_ps description in function header of
em_pd_get_efficient_state().

[...]

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

So the caller has to know the exact frequency value of the performance
states (PSs)? It's not 'f(PS_n-1) + 1 <= x <= f(PS_n)'.

[...]


