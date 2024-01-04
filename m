Return-Path: <linux-kernel+bounces-16789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A7D8243CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DD61C21D6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C0224F0;
	Thu,  4 Jan 2024 14:28:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF8522EE0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9F5C15;
	Thu,  4 Jan 2024 06:29:26 -0800 (PST)
Received: from [192.168.1.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 904C33F5A1;
	Thu,  4 Jan 2024 06:28:38 -0800 (PST)
Message-ID: <d3411602-9798-4261-8b7c-5c95d15ce455@arm.com>
Date: Thu, 4 Jan 2024 15:28:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH RFC 3/3] sched/fair: Implement new type of misfit
 MISFIT_POWER
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
 Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
 Chung-Kai Mei <chungkai@google.com>
References: <20231209011759.398021-1-qyousef@layalina.io>
 <20231209011759.398021-4-qyousef@layalina.io>
Content-Language: en-US
In-Reply-To: <20231209011759.398021-4-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Qais,

I tried to do as you indicated at:
    https://lore.kernel.org/all/20231228233848.piyodw2s2ytli37a@airbuntu/
without success. I can see that the task is migrated from a big CPU to
smaller CPUs, but it doesn't seem to be related to the new MISFIT_POWER
feature.

Indeed, if the uclamp_max value of a CPU-bound task is set to 0, isn't it
normal have EAS/feec() migrating the task to smaller CPUs ? I added tracing
inside is_misfit_task() and load_balance()'s misfit path and could not see
this path being used.

On 12/9/23 02:17, Qais Yousef wrote:
> MISFIT_POWER requires moving the task to a more efficient CPU.
> 
> This can happen when a big task is capped by uclamp_max, but another
> task wakes up on this CPU that can lift the capping, in this case we
> need to migrate it to another, likely smaller, CPU to save power.

Just to be sure, are we talking about the following path, where sugov
decides which OPP to select ?
sugov_get_util()
\-effective_cpu_util()
   \-uclamp_rq_util_with()

To try to describe the issue in my own words, IIUC, the issue comes from
the fact that during energy estimations in feec(), we don't estimate the
impact of enqueuing a task on the rq's UCLAMP_MAX value. So a rq with a
little UCLAMP_MAX value might see the value grows if an uncapped task
is enqueued, leading to raising the frequency and consuming more
power.
Thus, this patch tries to detect such scenario and migrate the clamped
tasks.
Maybe another approach would be to estimate the impact of enqueuing a
task on the rq's UCLAMP_MAX value ?

Regards,
Pierre

> 
> To enable that we need to be smarter about which CPU should do the pull.
> But this requires enabling load balance on all CPUs so that the correct
> CPU does the pull. Instead of the current behavior of nominating the CPU
> with the largest capacity in the group to do the pull.
> 
> This is important to ensure the MISFIT_POWER tasks don't end up on most
> performant CPUs, which is the default behavior of the load balance.  We
> could end up wasting energy unnecessarily or interfere with more
> important tasks on these big CPUs - leading to worse user experience.
> 
> To ensure optimal decision is made, we need to enable calling feec() to
> pick the most efficient CPU for us. Which means we need to force feec()
> to ignore overutilized flag. If feec() returns the same value as the CPU
> that is doing the balance, we perform the pull. Otherwise we'd have to
> defer for another CPU to do the pull.
> 
> To minimize the overhead, this is only done for MISFIT_POWER.
> 
> For capacity aware scheduling or none HMP systems, we will pick a CPU
> that we won't cause its uclamp_max to be uncapped.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>   kernel/sched/fair.c  | 77 ++++++++++++++++++++++++++++++++++++++++----
>   kernel/sched/sched.h |  1 +
>   2 files changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index dd49b89a6e3e..328467dbe88b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5066,10 +5066,33 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>   static inline int is_misfit_task(struct task_struct *p, struct rq *rq,
>   				 misfit_reason_t *reason)
>   {
> +	unsigned long rq_util_max;
> +	unsigned long p_util_min;
> +	unsigned long p_util_max;
> +	unsigned long util;
> +
>   	if (!p || p->nr_cpus_allowed == 1)
>   		return 0;
>   
> -	if (task_fits_cpu(p, cpu_of(rq)))
> +	rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
> +	p_util_min = uclamp_eff_value(p, UCLAMP_MIN);
> +	p_util_max = uclamp_eff_value(p, UCLAMP_MAX);
> +	util = task_util_est(p);
> +
> +	if (uclamp_is_used()) {
> +		/*
> +		* Check if a big task is capped by uclamp max is now sharing
> +		* the cpu with something else uncapped and must be moved away
> +		*/
> +		if (rq_util_max > p_util_max && util > p_util_max) {
> +			if (reason)
> +				*reason = MISFIT_POWER;
> +
> +			return 1;
> +		}
> +	}
> +
> +	if (util_fits_cpu(util, p_util_min, p_util_max, cpu_of(rq)))
>   		return 0;
>   
>   	if (reason)
> @@ -7923,7 +7946,8 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
>    * other use-cases too. So, until someone finds a better way to solve this,
>    * let's keep things simple by re-using the existing slow path.
>    */
> -static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> +static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu,
> +				     bool ignore_ou)
>   {
>   	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
>   	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
> @@ -7940,7 +7964,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   
>   	rcu_read_lock();
>   	pd = rcu_dereference(rd->pd);
> -	if (!pd || READ_ONCE(rd->overutilized))
> +	if (!pd || (READ_ONCE(rd->overutilized) && !ignore_ou))
>   		goto unlock;
>   
>   	/*
> @@ -8144,7 +8168,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>   			return cpu;
>   
>   		if (sched_energy_enabled()) {
> -			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
> +			new_cpu = find_energy_efficient_cpu(p, prev_cpu, false);
>   			if (new_cpu >= 0)
>   				return new_cpu;
>   			new_cpu = prev_cpu;
> @@ -9030,6 +9054,7 @@ static int detach_tasks(struct lb_env *env)
>   {
>   	struct list_head *tasks = &env->src_rq->cfs_tasks;
>   	unsigned long util, load;
> +	misfit_reason_t reason;
>   	struct task_struct *p;
>   	int detached = 0;
>   
> @@ -9118,9 +9143,28 @@ static int detach_tasks(struct lb_env *env)
>   
>   		case migrate_misfit:
>   			/* This is not a misfit task */
> -			if (!is_misfit_task(p, cpu_rq(env->src_cpu), NULL))
> +			if (!is_misfit_task(p, cpu_rq(env->src_cpu), &reason))
>   				goto next;
>   
> +			if (reason == MISFIT_POWER) {
> +				if (sched_energy_enabled()) {
> +					int new_cpu = find_energy_efficient_cpu(p, env->src_cpu, true);
> +					if (new_cpu != env->dst_cpu)
> +						goto next;
> +				} else {
> +					unsigned long dst_uclamp_max = uclamp_rq_get(env->dst_rq, UCLAMP_MAX);
> +					unsigned long p_uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> +
> +					/*
> +					 * Pick a task that will not cause us
> +					 * to uncap dst_cpu. Or give up until
> +					 * another CPU tries to do the pull.
> +					 */
> +					if (p_uclamp_max > dst_uclamp_max)
> +						goto next;
> +				}
> +			}
> +
>   			env->imbalance = 0;
>   			break;
>   		}
> @@ -11203,6 +11247,18 @@ static int should_we_balance(struct lb_env *env)
>   	if (!cpumask_test_cpu(env->dst_cpu, env->cpus))
>   		return 0;
>   
> +	/*
> +	 * For MISFIT_POWER, we need every CPU to do the lb so that we can pick
> +	 * the most energy efficient one via EAS if available or by making sure
> +	 * the dst_rq uclamp_max higher than the misfit task's uclamp_max.
> +	 *
> +	 * We don't want to do a pull if both src and dst cpus are in
> +	 * MISFIT_POWER state.
> +	 */
> +	if (env->src_rq->misfit_reason == MISFIT_POWER &&
> +	    env->dst_rq->misfit_reason != MISFIT_POWER)
> +			return 1;
> +
>   	/*
>   	 * In the newly idle case, we will allow all the CPUs
>   	 * to do the newly idle load balance.
> @@ -11431,8 +11487,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>   		 * We do not want newidle balance, which can be very
>   		 * frequent, pollute the failure counter causing
>   		 * excessive cache_hot migrations and active balances.
> +		 *
> +		 * MISFIT_POWER can also trigger a lot of failed misfit
> +		 * migrations as we need to ask every CPU to do the pull and
> +		 * expectedly lots of failures will incur.
>   		 */
> -		if (idle != CPU_NEWLY_IDLE)
> +		if (idle != CPU_NEWLY_IDLE && env.src_rq->misfit_reason != MISFIT_POWER)
>   			sd->nr_balance_failed++;
>   
>   		if (need_active_balance(&env)) {
> @@ -11515,8 +11575,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>   	 * repeatedly reach this code, which would lead to balance_interval
>   	 * skyrocketing in a short amount of time. Skip the balance_interval
>   	 * increase logic to avoid that.
> +	 *
> +	 * So does MISFIT_POWER which asks every CPU to do the pull as we can't
> +	 * tell which one would be the best one to move to before hand.
>   	 */
> -	if (env.idle == CPU_NEWLY_IDLE)
> +	if (env.idle == CPU_NEWLY_IDLE || env.src_rq->misfit_reason == MISFIT_POWER)
>   		goto out;
>   
>   	/* tune up the balancing interval */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 399b6526afab..3852109ffe62 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -964,6 +964,7 @@ struct balance_callback {
>   
>   typedef enum misfit_reason {
>   	MISFIT_PERF,		/* Requires moving to a more performant CPU */
> +	MISFIT_POWER,		/* Requires moving to a more efficient CPU */
>   } misfit_reason_t;
>   
>   /*

