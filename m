Return-Path: <linux-kernel+bounces-9663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5EE81C932
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F171C22046
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E5C17748;
	Fri, 22 Dec 2023 11:33:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BA171B6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A545D2F4;
	Fri, 22 Dec 2023 03:33:53 -0800 (PST)
Received: from [10.57.87.46] (unknown [10.57.87.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AAB63F738;
	Fri, 22 Dec 2023 03:33:05 -0800 (PST)
Message-ID: <5e57c957-724a-410b-8137-88fd9bbd10d9@arm.com>
Date: Fri, 22 Dec 2023 11:33:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/23] sched: Push execution and scheduler context
 split into deadline and rt paths
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-21-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-21-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> In preparation for chain migration, push the awareness
> of the split between execution and scheduler context
> down into some of the rt/deadline code paths that deal
> with load balancing.
> 
> This patch was broken out from a larger chain migration
> patch originally by Connor O'Brien.
> 

Nit: Commit header is too long. ` paths` can be dropped.

> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: split out from larger chain migration patch]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>   kernel/sched/cpudeadline.c | 12 ++++++------
>   kernel/sched/cpudeadline.h |  3 ++-
>   kernel/sched/cpupri.c      | 20 +++++++++++---------
>   kernel/sched/cpupri.h      |  6 ++++--
>   kernel/sched/deadline.c    | 18 +++++++++---------
>   kernel/sched/rt.c          | 31 ++++++++++++++++++-------------
>   6 files changed, 50 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 95baa12a1029..6ac59dcdf068 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -113,13 +113,13 @@ static inline int cpudl_maximum(struct cpudl *cp)
>    *
>    * Returns: int - CPUs were found
>    */
> -int cpudl_find(struct cpudl *cp, struct task_struct *p,
> +int cpudl_find(struct cpudl *cp, struct task_struct *sched_ctx, struct task_struct *exec_ctx,
>   	       struct cpumask *later_mask)
>   {
> -	const struct sched_dl_entity *dl_se = &p->dl;
> +	const struct sched_dl_entity *dl_se = &sched_ctx->dl;
>   
>   	if (later_mask &&
> -	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_mask)) {
> +	    cpumask_and(later_mask, cp->free_cpus, &exec_ctx->cpus_mask)) {
>   		unsigned long cap, max_cap = 0;
>   		int cpu, max_cpu = -1;
>   
> @@ -128,13 +128,13 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>   
>   		/* Ensure the capacity of the CPUs fits the task. */
>   		for_each_cpu(cpu, later_mask) {
> -			if (!dl_task_fits_capacity(p, cpu)) {
> +			if (!dl_task_fits_capacity(sched_ctx, cpu)) {
>   				cpumask_clear_cpu(cpu, later_mask);
>   
>   				cap = arch_scale_cpu_capacity(cpu);
>   
>   				if (cap > max_cap ||
> -				    (cpu == task_cpu(p) && cap == max_cap)) {
> +				    (cpu == task_cpu(exec_ctx) && cap == max_cap)) {
>   					max_cap = cap;
>   					max_cpu = cpu;
>   				}
> @@ -150,7 +150,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>   
>   		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
>   
> -		if (cpumask_test_cpu(best_cpu, &p->cpus_mask) &&
> +		if (cpumask_test_cpu(best_cpu, &exec_ctx->cpus_mask) &&
>   		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
>   			if (later_mask)
>   				cpumask_set_cpu(best_cpu, later_mask);
> diff --git a/kernel/sched/cpudeadline.h b/kernel/sched/cpudeadline.h
> index 0adeda93b5fb..6bb27f70e9d2 100644
> --- a/kernel/sched/cpudeadline.h
> +++ b/kernel/sched/cpudeadline.h
> @@ -16,7 +16,8 @@ struct cpudl {
>   };
>   
>   #ifdef CONFIG_SMP
> -int  cpudl_find(struct cpudl *cp, struct task_struct *p, struct cpumask *later_mask);
> +int  cpudl_find(struct cpudl *cp, struct task_struct *sched_ctx,
> +		struct task_struct *exec_ctx, struct cpumask *later_mask);
>   void cpudl_set(struct cpudl *cp, int cpu, u64 dl);
>   void cpudl_clear(struct cpudl *cp, int cpu);
>   int  cpudl_init(struct cpudl *cp);
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index 42c40cfdf836..15e947a3ded7 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -118,10 +118,11 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
>   	return 1;
>   }
>   
> -int cpupri_find(struct cpupri *cp, struct task_struct *p,
> +int cpupri_find(struct cpupri *cp, struct task_struct *sched_ctx,
> +		struct task_struct *exec_ctx,
>   		struct cpumask *lowest_mask)
>   {
> -	return cpupri_find_fitness(cp, p, lowest_mask, NULL);
> +	return cpupri_find_fitness(cp, sched_ctx, exec_ctx, lowest_mask, NULL);
>   }
>   
>   /**
> @@ -141,18 +142,19 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
>    *
>    * Return: (int)bool - CPUs were found
>    */
> -int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
> -		struct cpumask *lowest_mask,
> -		bool (*fitness_fn)(struct task_struct *p, int cpu))
> +int cpupri_find_fitness(struct cpupri *cp, struct task_struct *sched_ctx,
> +			struct task_struct *exec_ctx,
> +			struct cpumask *lowest_mask,
> +			bool (*fitness_fn)(struct task_struct *p, int cpu))
>   {
> -	int task_pri = convert_prio(p->prio);
> +	int task_pri = convert_prio(sched_ctx->prio);
>   	int idx, cpu;
>   
>   	WARN_ON_ONCE(task_pri >= CPUPRI_NR_PRIORITIES);
>   
>   	for (idx = 0; idx < task_pri; idx++) {
>   
> -		if (!__cpupri_find(cp, p, lowest_mask, idx))
> +		if (!__cpupri_find(cp, exec_ctx, lowest_mask, idx))
>   			continue;
>   
>   		if (!lowest_mask || !fitness_fn)
> @@ -160,7 +162,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
>   
>   		/* Ensure the capacity of the CPUs fit the task */
>   		for_each_cpu(cpu, lowest_mask) {
> -			if (!fitness_fn(p, cpu))
> +			if (!fitness_fn(sched_ctx, cpu))
>   				cpumask_clear_cpu(cpu, lowest_mask);
>   		}
>   
> @@ -192,7 +194,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
>   	 * really care.
>   	 */
>   	if (fitness_fn)
> -		return cpupri_find(cp, p, lowest_mask);
> +		return cpupri_find(cp, sched_ctx, exec_ctx, lowest_mask);
>   
>   	return 0;
>   }
> diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
> index d6cba0020064..bde7243cec2e 100644
> --- a/kernel/sched/cpupri.h
> +++ b/kernel/sched/cpupri.h
> @@ -18,9 +18,11 @@ struct cpupri {
>   };
>   
>   #ifdef CONFIG_SMP
> -int  cpupri_find(struct cpupri *cp, struct task_struct *p,
> +int  cpupri_find(struct cpupri *cp, struct task_struct *sched_ctx,
> +		 struct task_struct *exec_ctx,
>   		 struct cpumask *lowest_mask);
> -int  cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
> +int  cpupri_find_fitness(struct cpupri *cp, struct task_struct *sched_ctx,
> +			 struct task_struct *exec_ctx,
>   			 struct cpumask *lowest_mask,
>   			 bool (*fitness_fn)(struct task_struct *p, int cpu));
>   void cpupri_set(struct cpupri *cp, int cpu, int pri);
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1f3bc50de678..999bd17f11c4 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1779,7 +1779,7 @@ static inline bool dl_task_is_earliest_deadline(struct task_struct *p,
>   			       rq->dl.earliest_dl.curr));
>   }
>   
> -static int find_later_rq(struct task_struct *task);
> +static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx);
>   
>   static int
>   select_task_rq_dl(struct task_struct *p, int cpu, int flags)
> @@ -1819,7 +1819,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
>   		select_rq |= !dl_task_fits_capacity(p, cpu);
>   
>   	if (select_rq) {
> -		int target = find_later_rq(p);
> +		int target = find_later_rq(p, p);
>   
>   		if (target != -1 &&
>   		    dl_task_is_earliest_deadline(p, cpu_rq(target)))
> @@ -1871,7 +1871,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
>   	 * let's hope p can move out.
>   	 */
>   	if (rq->curr->nr_cpus_allowed == 1 ||
> -	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), NULL))
> +	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), rq->curr, NULL))
>   		return;
>   
>   	/*
> @@ -1879,7 +1879,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
>   	 * see if it is pushed or pulled somewhere else.
>   	 */
>   	if (p->nr_cpus_allowed != 1 &&
> -	    cpudl_find(&rq->rd->cpudl, p, NULL))
> +	    cpudl_find(&rq->rd->cpudl, p, p, NULL))
>   		return;
>   
>   	resched_curr(rq);
> @@ -2079,25 +2079,25 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>   
>   static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask_dl);
>   
> -static int find_later_rq(struct task_struct *task)
> +static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx)

Nit: line becomes too long. Same for find_later_rq()'s signature above 
as well as find_lowest_rq() in rt.c.

>   {
>   	struct sched_domain *sd;
>   	struct cpumask *later_mask = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
>   	int this_cpu = smp_processor_id();
> -	int cpu = task_cpu(task);
> +	int cpu = task_cpu(sched_ctx);
>   
>   	/* Make sure the mask is initialized first */
>   	if (unlikely(!later_mask))
>   		return -1;
>   
> -	if (task->nr_cpus_allowed == 1)
> +	if (exec_ctx && exec_ctx->nr_cpus_allowed == 1)

Can exec_ctx be NULL? If so, we may hit a seg. fault at 
task_rq(exec_ctx) below.

>   		return -1;
>   
>   	/*
>   	 * We have to consider system topology and task affinity
>   	 * first, then we can look for a suitable CPU.
>   	 */
> -	if (!cpudl_find(&task_rq(task)->rd->cpudl, task, later_mask))
> +	if (!cpudl_find(&task_rq(exec_ctx)->rd->cpudl, sched_ctx, exec_ctx, later_mask))
>   		return -1;
>   
>   	/*
> @@ -2174,7 +2174,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>   	int cpu;
>   
>   	for (tries = 0; tries < DL_MAX_TRIES; tries++) {
> -		cpu = find_later_rq(task);
> +		cpu = find_later_rq(task, task);
>   
>   		if ((cpu == -1) || (cpu == rq->cpu))
>   			break;
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 15161de88753..6371b0fca4ad 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1554,7 +1554,7 @@ static void yield_task_rt(struct rq *rq)
>   }
>   
>   #ifdef CONFIG_SMP
> -static int find_lowest_rq(struct task_struct *task);
> +static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx);
>   
>   static int
>   select_task_rq_rt(struct task_struct *p, int cpu, int flags)
> @@ -1604,7 +1604,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
>   	       (curr->nr_cpus_allowed < 2 || selected->prio <= p->prio);
>   
>   	if (test || !rt_task_fits_capacity(p, cpu)) {
> -		int target = find_lowest_rq(p);
> +		int target = find_lowest_rq(p, p);
>   
>   		/*
>   		 * Bail out if we were forcing a migration to find a better
> @@ -1631,8 +1631,13 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
>   
>   static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
>   {
> +	struct task_struct *exec_ctx = p;
> +	/*
> +	 * Current can't be migrated, useless to reschedule,
> +	 * let's hope p can move out.
> +	 */
>   	if (rq->curr->nr_cpus_allowed == 1 ||
> -	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), NULL))
> +	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), rq->curr, NULL))
>   		return;
>   
>   	/*
> @@ -1640,7 +1645,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
>   	 * see if it is pushed or pulled somewhere else.
>   	 */
>   	if (p->nr_cpus_allowed != 1 &&
> -	    cpupri_find(&rq->rd->cpupri, p, NULL))
> +	    cpupri_find(&rq->rd->cpupri, p, exec_ctx, NULL))
>   		return;
>   
>   	/*
> @@ -1834,19 +1839,19 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
>   
>   static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask);
>   
> -static int find_lowest_rq(struct task_struct *task)
> +static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exec_ctx)
>   {
>   	struct sched_domain *sd;
>   	struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
>   	int this_cpu = smp_processor_id();
> -	int cpu      = task_cpu(task);
> +	int cpu      = task_cpu(sched_ctx);
>   	int ret;
>   
>   	/* Make sure the mask is initialized first */
>   	if (unlikely(!lowest_mask))
>   		return -1;
>   
> -	if (task->nr_cpus_allowed == 1)
> +	if (exec_ctx && exec_ctx->nr_cpus_allowed == 1)
>   		return -1; /* No other targets possible */
>   
>   	/*
> @@ -1855,13 +1860,13 @@ static int find_lowest_rq(struct task_struct *task)
>   	 */
>   	if (sched_asym_cpucap_active()) {
>   
> -		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
> -					  task, lowest_mask,
> +		ret = cpupri_find_fitness(&task_rq(sched_ctx)->rd->cpupri,
> +					  sched_ctx, exec_ctx, lowest_mask,
>   					  rt_task_fits_capacity);
>   	} else {
>   
> -		ret = cpupri_find(&task_rq(task)->rd->cpupri,
> -				  task, lowest_mask);
> +		ret = cpupri_find(&task_rq(sched_ctx)->rd->cpupri,
> +				  sched_ctx, exec_ctx, lowest_mask);
>   	}
>   
>   	if (!ret)
> @@ -1933,7 +1938,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>   	int cpu;
>   
>   	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
> -		cpu = find_lowest_rq(task);
> +		cpu = find_lowest_rq(task, task);
>   
>   		if ((cpu == -1) || (cpu == rq->cpu))
>   			break;
> @@ -2055,7 +2060,7 @@ static int push_rt_task(struct rq *rq, bool pull)
>   		if (rq->curr->sched_class != &rt_sched_class)
>   			return 0;
>   
> -		cpu = find_lowest_rq(rq->curr);
> +		cpu = find_lowest_rq(rq_selected(rq), rq->curr);
>   		if (cpu == -1 || cpu == rq->cpu)
>   			return 0;
>   


