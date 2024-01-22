Return-Path: <linux-kernel+bounces-32683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD1835ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BD81F25845
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C4739FD9;
	Mon, 22 Jan 2024 09:59:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C6139FCF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917597; cv=none; b=c6+0NhKf79mfUxDWz3cw7XTsBIRLuD2TOzxaPgbppxk7mAMrMdTGFWHia0phfwyzPEtzdiPyylLo3ah3EOQUaW8LHOMThW2qCvDQQAv2/sG7iLkbBO3EvFo3KZDBx4xsPLHw6scVSIO0gxM+2eIOK3vI1Q2sFX84i1OGS0Z7cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917597; c=relaxed/simple;
	bh=pTLOgbw6TGq7gigvVyILdDYjtSciLE6lb2RwHnJzWtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExXZ2P/pPuvA1Z5jicz50kDcP/ShhFN+cll3UKxT2qT+LO55uccy10GfbWVNPc7mHpw4RHIlPyWhe87yhuGAZRhLMUH9UY8DXBxEE9G+zbTVta4VznIrYm+jzpcFvID4cZBl/xmQvpMi+opBwEQ67PGVkALFnmvL8maQUA7fXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DA8B2F4;
	Mon, 22 Jan 2024 02:00:40 -0800 (PST)
Received: from [10.12.38.192] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A163F5A1;
	Mon, 22 Jan 2024 01:59:52 -0800 (PST)
Message-ID: <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
Date: Mon, 22 Jan 2024 09:59:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Pierre Gondois <Pierre.Gondois@arm.com>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240105222014.1025040-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/01/2024 23:20, Qais Yousef wrote:
> From: Qais Yousef <qais.yousef@arm.com>
> 
> If a misfit task is affined to a subset of the possible cpus, we need to
> verify that one of these cpus can fit it. Otherwise the load balancer
> code will continuously trigger needlessly leading the balance_interval
> to increase in return and eventually end up with a situation where real
> imbalances take a long time to address because of this impossible
> imbalance situation.
> 
> This can happen in Android world where it's common for background tasks
> to be restricted to little cores.
> 
> Similarly if we can't fit the biggest core, triggering misfit is
> pointless as it is the best we can ever get on this system.
> 
> To be able to detect that; we use asym_cap_list to iterate through
> capacities in the system to see if the task is able to run at a higher
> capacity level based on its p->cpus_ptr. To do so safely, we convert the
> list to be RCU protected.
> 
> To be able to iterate through capacity levels, export asym_cap_list to
> allow for fast traversal of all available capacity levels in the system.
> 
> Test:
> =====
> 
> Add
> 
> 	trace_printk("balance_interval = %lu\n", interval)
> 
> in get_sd_balance_interval().
> 
> run
> 	if [ "$MASK" != "0" ]; then
> 		adb shell "taskset -a $MASK cat /dev/zero > /dev/null"
> 	fi
> 	sleep 10
> 	// parse ftrace buffer counting the occurrence of each valaue
> 
> Where MASK is either:
> 
> 	* 0: no busy task running

.. no busy task stands for no misfit scenario?

> 	* 1: busy task is pinned to 1 cpu; handled today to not cause
> 	  misfit
> 	* f: busy task pinned to little cores, simulates busy background
> 	  task, demonstrates the problem to be fixed
> 

[...]

> +	/*
> +	 * If the task affinity is not set to default, make sure it is not
> +	 * restricted to a subset where no CPU can ever fit it. Triggering
> +	 * misfit in this case is pointless as it has no where better to move
> +	 * to. And it can lead to balance_interval to grow too high as we'll
> +	 * continuously fail to move it anywhere.
> +	 */
> +	if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {

Shouldn't this be cpu_active_mask ?

include/linux/cpumask.h

 * cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
 * cpu_present_mask - has bit 'cpu' set iff cpu is populated
 * cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
 * cpu_active_mask  - has bit 'cpu' set iff cpu available to migration


> +		unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> +		bool has_fitting_cpu = false;
> +		struct asym_cap_data *entry;
> +
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> +			if (entry->capacity > cpu_cap) {
> +				cpumask_t *cpumask;
> +
> +				if (clamped_util > entry->capacity)
> +					continue;
> +
> +				cpumask = cpu_capacity_span(entry);
> +				if (!cpumask_intersects(p->cpus_ptr, cpumask))
> +					continue;
> +
> +				has_fitting_cpu = true;
> +				break;
> +			}
> +		}

What happen when we hotplug out all CPUs of one CPU capacity value?
IMHO, we don't call asym_cpu_capacity_scan() with !new_topology
(partition_sched_domains_locked()).

> +		rcu_read_unlock();
> +
> +		if (!has_fitting_cpu)
> +			goto out;
>  	}
>  
>  	/*
> @@ -5083,6 +5127,9 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  	 * task_h_load() returns 0.
>  	 */
>  	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> +	return;
> +out:
> +	rq->misfit_task_load = 0;
>  }
>  
>  #else /* CONFIG_SMP */
> @@ -9583,9 +9630,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>   */
>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
>  {
> -	return rq->misfit_task_load &&
> -		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> -		 check_cpu_capacity(rq, sd));
> +	return rq->misfit_task_load && check_cpu_capacity(rq, sd);

You removed 'arch_scale_cpu_capacity(rq->cpu) <
rq->rd->max_cpu_capacity' here. Why? I can see that with the standard
setup (max CPU capacity equal 1024) which is what we probably use 100%
of the time now. It might get useful again when Vincent will introduce
his 'user space system pressure' implementation?

>  }

[...]

> @@ -1423,8 +1418,8 @@ static void asym_cpu_capacity_scan(void)
>  
>  	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
>  		if (cpumask_empty(cpu_capacity_span(entry))) {
> -			list_del(&entry->link);
> -			kfree(entry);
> +			list_del_rcu(&entry->link);
> +			call_rcu(&entry->rcu, free_asym_cap_entry);

Looks like there could be brief moments in which one CPU capacity group
of CPUs could be twice in asym_cap_list. I'm thinking about initial
startup + max CPU frequency related adjustment of CPU capacity
(init_cpu_capacity_callback()) for instance. Not sure if this is really
an issue?

[...]


