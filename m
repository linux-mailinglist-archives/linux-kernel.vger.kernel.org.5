Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0F80D0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjLKQOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbjLKQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:14:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EC16FF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:14:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03CD9169E;
        Mon, 11 Dec 2023 08:15:08 -0800 (PST)
Received: from [10.34.100.114] (e126645.nice.arm.com [10.34.100.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C34B3F738;
        Mon, 11 Dec 2023 08:14:19 -0800 (PST)
Message-ID: <beb70676-7d9a-4f4b-9085-3964079a50a9@arm.com>
Date:   Mon, 11 Dec 2023 17:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] sched/fair: Implement new type of misfit
 MISFIT_POWER
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>
References: <20231209011759.398021-1-qyousef@layalina.io>
 <20231209011759.398021-4-qyousef@layalina.io>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231209011759.398021-4-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/23 02:17, Qais Yousef wrote:
> MISFIT_POWER requires moving the task to a more efficient CPU.
> 
> This can happen when a big task is capped by uclamp_max, but another
> task wakes up on this CPU that can lift the capping, in this case we
> need to migrate it to another, likely smaller, CPU to save power.
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

In case someone tries the patch, it seems the src_rq field of the
struct lb_env env in load_balance() is not initialized, so I think accesses
to env->src_rq->misfit_reason should be replaced by:
   (env->src_rq && env->src_rq->misfit_reason)

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
