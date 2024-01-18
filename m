Return-Path: <linux-kernel+bounces-30428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F780831E83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525311C2314F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29A2D61F;
	Thu, 18 Jan 2024 17:36:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C212D616
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599388; cv=none; b=Wa9h8wXna73cUAZbsi5uRPUDncalTsnuoZ/InVCniPpQQjaoz1ZahkekUouyixvY256pAfWuzfre95B2KJBLlED+owAqXlko7hbrAJJyC8vxsDqLaSvyi7M69oRPDJldx8pB1XiaKdnxfqiMXQpKLhVZ8e1W2hX64ju56ysIWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599388; c=relaxed/simple;
	bh=lm3pt7KdFYd/SORPvxfLYNRuDhB8ojSgjUEPfZzkQK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type; b=sgoKsj/3NXxR3MCWzl33VjAhZyxtg/xaOmt63FgU1R0uZKFAKWfYzWbmfmoCiVu0NI83Wi6QTNxPxsBwwjNw6vKJcs9h+XYEyOHmt/P0kmeAyvj8S2jJCiLU8ijBxEdT+5CYKdWSZpf8/bKes+5kc4Ksdaf7BV64gjWcAFTPpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA9681042;
	Thu, 18 Jan 2024 09:37:10 -0800 (PST)
Received: from [192.168.1.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 234A23F5A1;
	Thu, 18 Jan 2024 09:36:19 -0800 (PST)
Message-ID: <82d272fb-ffc3-4d55-b92a-497cbc13fc03@arm.com>
Date: Thu, 18 Jan 2024 18:36:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Resend PATCH] topology: Set capacity_freq_ref in all cases
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, sudeep.holla@arm.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc: lukasz.luba@arm.com, ionela.voinescu@arm.com
References: <20240117190545.596057-1-vincent.guittot@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240117190545.596057-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested-by: Pierre Gondois <pierre.gondois@arm.com>

On 1/17/24 20:05, Vincent Guittot wrote:
> If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip the
> normalization step which includes setting per_cpu capacity_freq_ref.
> Always register the notifier but skip the capacity normalization if
> raw_capacity is null.
> 
> Fixes: 9942cb22ea45 ("sched/topology: Add a new arch_scale_freq_ref() method")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> Resend with correct email address for Sudeep
> 
>   drivers/base/arch_topology.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 5aaa0865625d..2aa0c6425290 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -417,9 +417,6 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>   	struct cpufreq_policy *policy = data;
>   	int cpu;
>   
> -	if (!raw_capacity)
> -		return 0;
> -
>   	if (val != CPUFREQ_CREATE_POLICY)
>   		return 0;
>   
> @@ -436,9 +433,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>   	}
>   
>   	if (cpumask_empty(cpus_to_visit)) {
> -		topology_normalize_cpu_scale();
> -		schedule_work(&update_topology_flags_work);
> -		free_raw_capacity();
> +		if (raw_capacity) {
> +			topology_normalize_cpu_scale();
> +			schedule_work(&update_topology_flags_work);
> +			free_raw_capacity();
> +		}
>   		pr_debug("cpu_capacity: parsing done\n");
>   		schedule_work(&parsing_done_work);
>   	}
> @@ -458,7 +457,7 @@ static int __init register_cpufreq_notifier(void)
>   	 * On ACPI-based systems skip registering cpufreq notifier as cpufreq
>   	 * information is not needed for cpu capacity initialization.
>   	 */
> -	if (!acpi_disabled || !raw_capacity)
> +	if (!acpi_disabled)
>   		return -EINVAL;
>   
>   	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))

