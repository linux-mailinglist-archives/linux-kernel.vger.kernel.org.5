Return-Path: <linux-kernel+bounces-7316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7BA81A58E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76242288103
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6A46439;
	Wed, 20 Dec 2023 16:45:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471F41763
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 410821FB;
	Wed, 20 Dec 2023 08:45:45 -0800 (PST)
Received: from [10.57.46.221] (unknown [10.57.46.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E697D3F64C;
	Wed, 20 Dec 2023 08:44:58 -0800 (PST)
Message-ID: <bae88015-4205-4449-991f-8104436ab3ba@arm.com>
Date: Wed, 20 Dec 2023 17:44:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org
References: <20231212154056.626978-1-qyousef@layalina.io>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231212154056.626978-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Qais,

On 12/12/23 16:40, Qais Yousef wrote:
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
> capacity level based on its p->cpus_ptr.
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

Just in case, to avoid taking into account the 'cpu_busy' factor in
get_sd_balance_interval(), it might be better to track
'sd->balance_interval' directly.

Also (and as you said in the commit message), the interest of this patch
is more to avoid needlessly trying to balance tasks when tasks are pinned
rather than having a low balance interval. So it might be better to observe
either 'sd->nr_balance_failed' or the number of occurrence where
check_misfit_status() returns 1 and no task is moved.

When testing the patch, with a CPU-bound task pinned to little CPUs, running
during 1s (and on one iteration):
- (top sd)->nr_balance_failed was increased:
   without patch:
     150 times
   with patch:
     6 times
- check_misfit_status() returned:
   without patch:
   - ret=0: 591
   - ret=1: 1414
   with patch
   - ret=0: 1755
   - ret=1: 5
So there should also be improvements in that regard. I could observe
improvements similar to what you saw regarding the balance_interval.

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
> 	* 1: busy task is pinned to 1 cpu; handled today to not cause
> 	  misfit
> 	* f: busy task pinned to little cores, simulates busy background
> 	  task, demonstrates the problem to be fixed
> 
> Results:
> ========
> 
> Note how occurrence of balance_interval = 128 overshoots for MASK = f.
> 
> BEFORE
> ------
> 
> 	MASK=0
> 
> 		   1 balance_interval = 175
> 		 120 balance_interval = 128
> 		 846 balance_interval = 64
> 		  55 balance_interval = 63
> 		 215 balance_interval = 32
> 		   2 balance_interval = 31
> 		   2 balance_interval = 16
> 		   4 balance_interval = 8
> 		1870 balance_interval = 4
> 		  65 balance_interval = 2
> 
> 	MASK=1
> 
> 		  27 balance_interval = 175
> 		  37 balance_interval = 127
> 		 840 balance_interval = 64
> 		 167 balance_interval = 63
> 		 449 balance_interval = 32
> 		  84 balance_interval = 31
> 		 304 balance_interval = 16
> 		1156 balance_interval = 8
> 		2781 balance_interval = 4
> 		 428 balance_interval = 2
> 
> 	MASK=f
> 
> 		   1 balance_interval = 175
> 		1328 balance_interval = 128
> 		  44 balance_interval = 64
> 		 101 balance_interval = 63
> 		  25 balance_interval = 32
> 		   5 balance_interval = 31
> 		  23 balance_interval = 16
> 		  23 balance_interval = 8
> 		4306 balance_interval = 4
> 		 177 balance_interval = 2
> 
> AFTER
> -----
> 
> Note how the high values almost disappear for all MASK values. The
> system has background tasks that could trigger the problem without
> simulate it even with MASK=0.
> 
> 	MASK=0
> 
> 		 103 balance_interval = 63
> 		  19 balance_interval = 31
> 		 194 balance_interval = 8
> 		4827 balance_interval = 4
> 		 179 balance_interval = 2
> 
> 	MASK=1
> 
> 		 131 balance_interval = 63
> 		   1 balance_interval = 31
> 		  87 balance_interval = 8
> 		3600 balance_interval = 4
> 		   7 balance_interval = 2
> 
> 	MASK=f
> 
> 		   8 balance_interval = 127
> 		 182 balance_interval = 63
> 		   3 balance_interval = 31
> 		   9 balance_interval = 16
> 		 415 balance_interval = 8
> 		3415 balance_interval = 4
> 		  21 balance_interval = 2
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
> 
> Changes since v1:
> 
> 	* Use asym_cap_list (thanks Dietmar) to iterate instead of iterating
> 	  through every cpu which Vincent was concerned about.
> 	* Use uclamped util to compare with capacity instead of util_fits_cpu()
> 	  when iterating through capcities (Dietmar).
> 	* Update commit log with test results to better demonstrate the problem
> 
> v1 discussion: https://lore.kernel.org/lkml/20230820203429.568884-1-qyousef@layalina.io/#t
> 
> Food for thoughts: should misfit cause balance_interval to double? This patch
> will still be needed if the answer is yes to avoid unnecessary misfit-lb to
> trigger repeatedly anyway.
> 
>   kernel/sched/fair.c     | 59 ++++++++++++++++++++++++++++++++++++-----
>   kernel/sched/sched.h    | 13 +++++++++
>   kernel/sched/topology.c | 13 +--------
>   3 files changed, 66 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcea3d55d95d..94e2f659fef9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5065,17 +5065,59 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>   
>   static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>   {
> +	unsigned long uclamp_min, uclamp_max;
> +	struct asym_cap_data *entry, *next;

These variables could be moved aside the 'clamped_util' declaration
as their scope is limited (same remark for 'has_fitting_cpu').

> +	bool has_fitting_cpu = false;
> +	unsigned long util, cpu_cap;
> +	int cpu = cpu_of(rq);
> +
>   	if (!sched_asym_cpucap_active())
>   		return;
>   
> -	if (!p || p->nr_cpus_allowed == 1) {
> -		rq->misfit_task_load = 0;
> -		return;
> -	}
> +	if (!p || p->nr_cpus_allowed == 1)
> +		goto out;
>   
> -	if (task_fits_cpu(p, cpu_of(rq))) {
> -		rq->misfit_task_load = 0;
> -		return;
> +	cpu_cap = arch_scale_cpu_capacity(cpu);
> +
> +	/* If we can't fit the biggest CPU, that's the best we can ever get. */
> +	if (cpu_cap == SCHED_CAPACITY_SCALE)
> +		goto out;
> +
> +	uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> +	uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> +	util = task_util_est(p);
> +
> +	if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> +		goto out;
> +
> +	/*
> +	 * If the task affinity is not set to default, make sure it is not
> +	 * restricted to a subset where no CPU can ever fit it. Triggering
> +	 * misfit in this case is pointless as it has no where better to move
> +	 * to. And it can lead to balance_interval to grow too high as we'll
> +	 * continuously fail to move it anywhere.
> +	 */
> +	if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {

Just to avoid one level of indentation, it might be better to invert the condition.

> +		unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> +
> +		list_for_each_entry_safe(entry, next, &asym_cap_list, link) {

I think list_for_each_entry_safe() allows to safely remove an element
from a list, but I'm not sure it protects against a concurrent
element removal + free.

I think an rcu would be the right way to protect against that
in order to safely access asym_cap_list's elements. Otherwise
asym_cpu_capacity_scan()
\-list_del(&entry->link);
\-kfree(entry);
might free the element.

Also, if the list is accessed so many times to look for a CPU with the
highest capacity, maybe it would be good to order the list and
access its element from the highest capacity to the lowest.

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
> +
> +		if (!has_fitting_cpu)
> +			goto out;
>   	}
>   
>   	/*
> @@ -5083,6 +5125,9 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>   	 * task_h_load() returns 0.
>   	 */
>   	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> +	return;
> +out:
> +	rq->misfit_task_load = 0;
>   }

Along with this function, check_misfit_status() is checking that:
   rq->cpu_capacity_orig < rq->rd->max_cpu_capacity
With this patch, maybe this condition is not required anymore.

Regards,
Pierre

>   
>   #else /* CONFIG_SMP */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e58a54bda77d..1b4c1ca3fb4c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -109,6 +109,19 @@ extern int sysctl_sched_rt_period;
>   extern int sysctl_sched_rt_runtime;
>   extern int sched_rr_timeslice;
>   
> +/*
> + * Asymmetric CPU capacity bits
> + */
> +struct asym_cap_data {
> +	struct list_head link;
> +	unsigned long capacity;
> +	unsigned long cpus[];
> +};
> +
> +extern struct list_head asym_cap_list;
> +
> +#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
> +
>   /*
>    * Helpers for converting nanosecond timing to jiffy resolution
>    */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..e95a4c6e651f 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1329,24 +1329,13 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>   	update_group_capacity(sd, cpu);
>   }
>   
> -/*
> - * Asymmetric CPU capacity bits
> - */
> -struct asym_cap_data {
> -	struct list_head link;
> -	unsigned long capacity;
> -	unsigned long cpus[];
> -};
> -
>   /*
>    * Set of available CPUs grouped by their corresponding capacities
>    * Each list entry contains a CPU mask reflecting CPUs that share the same
>    * capacity.
>    * The lifespan of data is unlimited.
>    */
> -static LIST_HEAD(asym_cap_list);
> -
> -#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
> +LIST_HEAD(asym_cap_list);
>   
>   /*
>    * Verify whether there is any CPU capacity asymmetry in a given sched domain.

