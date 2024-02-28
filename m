Return-Path: <linux-kernel+bounces-85311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E186B3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3771C1C251CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08B015D5AD;
	Wed, 28 Feb 2024 15:59:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C82146015
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135940; cv=none; b=pbRX2JZJqk+xzi+iTyCdHi/0VxE0VbIEBqg4NmpeDcP0Hc86WP7jl2TGjI6mRmRrH+AZvxFjBZmKWCNWhvWt09DBLscE0hngh9NrLbwathMwLNqEoobtzyvtcw1xMSzowbkiUgh+jebvfndtbPuNraKOzsMZuBPAs1+KOiCBlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135940; c=relaxed/simple;
	bh=ivpa0hNo/1moQ95kEMVnqiTcvXhzuU3S1DNG+wTnh20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvmVvVGGovmM0AAEQZ//zYrrZ6TMH50Xv3UpERrrO3er9rgcysmB1cI3KNmX7shDhXOzkURRwNhPLVdKoDwKomEmavqc2mz5kxv76z318tVftcrI3m+/6ntrQeq0dezVcfgAIr0gHyoMHatha+8FyrLcTVDiR8lcnNwq8pY2CSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9381FB;
	Wed, 28 Feb 2024 07:59:36 -0800 (PST)
Received: from [10.57.49.87] (unknown [10.57.49.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA5ED3F762;
	Wed, 28 Feb 2024 07:58:54 -0800 (PST)
Message-ID: <86f000a3-3068-4c57-858d-c00e3eb6e974@arm.com>
Date: Wed, 28 Feb 2024 16:58:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/fair: Add EAS checks before updating
 overutilized
To: Shrikanth Hegde <sshegde@linux.ibm.com>, mingo@kernel.org,
 peterz@infradead.org, vincent.guittot@linaro.org
Cc: yu.c.chen@intel.com, dietmar.eggemann@arm.com,
 linux-kernel@vger.kernel.org, nysal@linux.ibm.com, aboorvad@linux.ibm.com,
 srikar@linux.vnet.ibm.com, vschneid@redhat.com, morten.rasmussen@arm.com,
 qyousef@layalina.io
References: <20240228071621.602596-1-sshegde@linux.ibm.com>
 <20240228071621.602596-2-sshegde@linux.ibm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240228071621.602596-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It is nice to avoid calling effective_cpu_util() through the following
when EAS is not enabled:

cpu_overutilized()
\-util_fits_cpu()
   \- ...
     \-effective_cpu_util()

On 2/28/24 08:16, Shrikanth Hegde wrote:
> Overutilized field of root domain is only used for EAS(energy aware scheduler)
> to decide whether to do regular load balance or EAS aware load balance. It
> is not used if EAS not possible.
> 
> Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
> this field. In update_sd_lb_stats it is updated often.
> Which causes cache contention due to load/store tearing and burns
> a lot of cycles. Hence add EAS check before updating this field.
> EAS check is optimized at compile time or it is static branch.
> Hence it shouldn't cost much.
> 
> With the patch, both enqueue_task_fair and newidle_balance don't show
> up as hot routines in perf profile.
> 
> 6.8-rc4:
> 7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 6.78%  s                [kernel.vmlinux]              [k] newidle_balance
> +patch:
> 0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance
> 
> Minor change; trace_sched_overutilized_tp expect that second argument to
> be bool. So do a int to bool conversion for that.
> 
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   kernel/sched/fair.c | 35 ++++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8e30e2bb77a0..3105fb08b87e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6670,15 +6670,30 @@ static inline bool cpu_overutilized(int cpu)
>   	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>   }
> 
> -static inline void update_overutilized_status(struct rq *rq)
> +static inline void update_rd_overutilized_status(struct root_domain *rd,
> +						 int status)
>   {
> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> +	if (sched_energy_enabled()) {
> +		WRITE_ONCE(rd->overutilized, status);
> +		trace_sched_overutilized_tp(rd, !!status);
> +	}
> +}

NIT:
When called from check_update_overutilized_status(),
sched_energy_enabled() will be checked twice.

> +
> +static inline void check_update_overutilized_status(struct rq *rq)
> +{
> +	/*
> +	 * overutilized field is used for load balancing decisions only
> +	 * if energy aware scheduler is being used
> +	 */
> +	if (sched_energy_enabled()) {
> +		if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +			update_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>   	}
>   }
>   #else
> -static inline void update_overutilized_status(struct rq *rq) { }
> +static inline void check_update_overutilized_status(struct rq *rq) { }
> +static inline void update_rd_overutilized_status(struct root_domain *rd,
> +						 bool status) { }
>   #endif
> 
>   /* Runqueue only has SCHED_IDLE tasks enqueued */
> @@ -6779,7 +6794,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   	 * and the following generally works well enough in practice.
>   	 */
>   	if (!task_new)
> -		update_overutilized_status(rq);
> +		check_update_overutilized_status(rq);
> 
>   enqueue_throttle:
>   	assert_list_leaf_cfs_rq(rq);
> @@ -10613,13 +10628,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>   		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
> 
>   		/* Update over-utilization (tipping point, U >= 0) indicator */
> -		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
> +		update_rd_overutilized_status(rd, sg_status & SG_OVERUTILIZED);
>   	} else if (sg_status & SG_OVERUTILIZED) {
>   		struct root_domain *rd = env->dst_rq->rd;
> 
> -		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> +		update_rd_overutilized_status(rd, SG_OVERUTILIZED);
>   	}
> 
>   	update_idle_cpu_scan(env, sum_util);
> @@ -12625,7 +12638,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>   		task_tick_numa(rq, curr);
> 
>   	update_misfit_status(curr, rq);
> -	update_overutilized_status(task_rq(curr));
> +	check_update_overutilized_status(task_rq(curr));
> 
>   	task_tick_core(rq, curr);
>   }
> --
> 2.39.3
> 

