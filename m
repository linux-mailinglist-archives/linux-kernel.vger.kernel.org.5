Return-Path: <linux-kernel+bounces-9683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3835981C98B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA111C240DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D4D17995;
	Fri, 22 Dec 2023 11:57:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83821A1E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B98A2F4;
	Fri, 22 Dec 2023 03:58:19 -0800 (PST)
Received: from [10.57.87.46] (unknown [10.57.87.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9D583F64C;
	Fri, 22 Dec 2023 03:57:30 -0800 (PST)
Message-ID: <4a137164-0a4a-4f7e-806e-ef532fa86ece@arm.com>
Date: Fri, 22 Dec 2023 11:57:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/23] sched: Add find_exec_ctx helper
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
 <20231220001856.3710363-22-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-22-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> Add a helper to find the runnable owner down a chain of blocked waiters
> 
> This patch was broken out from a larger chain migration
> patch originally by Connor O'Brien.
> 
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
>   kernel/sched/core.c     | 42 +++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/cpupri.c   | 11 ++++++++---
>   kernel/sched/deadline.c | 15 +++++++++++++--
>   kernel/sched/rt.c       |  9 ++++++++-
>   kernel/sched/sched.h    | 10 ++++++++++
>   5 files changed, 81 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0c212dcd4b7a..77a79d5f829a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3896,6 +3896,48 @@ static void activate_blocked_entities(struct rq *target_rq,
>   	}
>   	raw_spin_unlock_irqrestore(&owner->blocked_lock, flags);
>   }
> +
> +static inline bool task_queued_on_rq(struct rq *rq, struct task_struct *task)
> +{
> +	if (!task_on_rq_queued(task))
> +		return false;
> +	smp_rmb();
> +	if (task_rq(task) != rq)
> +		return false;
> +	smp_rmb();
> +	if (!task_on_rq_queued(task))
> +		return false;

* Super-nit: we may want to have empty lines between `if` blocks and 
before/after `smp_rmb()` calls.

* I did not understand why we call `task_on_rq_queued(task)` twice. 
Should we have an explanatory comment before the function definition?

> +	return true;
> +}
> +
> +/*
> + * Returns the unblocked task at the end of the blocked chain starting with p
> + * if that chain is composed entirely of tasks enqueued on rq, or NULL otherwise.
> + */
> +struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
> +{
> +	struct task_struct *exec_ctx, *owner;
> +	struct mutex *mutex;
> +
> +	if (!sched_proxy_exec())
> +		return p;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	for (exec_ctx = p; task_is_blocked(exec_ctx) && !task_on_cpu(rq, exec_ctx);
> +							exec_ctx = owner) {
> +		mutex = exec_ctx->blocked_on;
> +		owner = __mutex_owner(mutex);
> +		if (owner == exec_ctx)
> +			break;
> +
> +		if (!task_queued_on_rq(rq, owner) || task_current_selected(rq, owner)) {
> +			exec_ctx = NULL;
> +			break;
> +		}
> +	}
> +	return exec_ctx;
> +}
>   #else /* !CONFIG_SCHED_PROXY_EXEC */
>   static inline void do_activate_task(struct rq *rq, struct task_struct *p,
>   				    int en_flags)
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index 15e947a3ded7..53be78afdd07 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -96,12 +96,17 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
>   	if (skip)
>   		return 0;
>   
> -	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
> +	if ((p && cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids) ||
> +	    (!p && cpumask_any(vec->mask) >= nr_cpu_ids))
>   		return 0;
>   
>   	if (lowest_mask) {
> -		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
> -		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
> +		if (p) {
> +			cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
> +			cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
> +		} else {
> +			cpumask_copy(lowest_mask, vec->mask);
> +		}

I think changes in `cpupri.c` should be part of previous (`sched: Push 
execution and scheduler context split into deadline and rt paths`) 
patch. Because they don't seem to be related with find_exec_ctx()?

>   
>   		/*
>   		 * We have to ensure that we have at least one bit
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 999bd17f11c4..21e56ac58e32 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1866,6 +1866,8 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
>   
>   static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
>   {
> +	struct task_struct *exec_ctx;
> +
>   	/*
>   	 * Current can't be migrated, useless to reschedule,
>   	 * let's hope p can move out.
> @@ -1874,12 +1876,16 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
>   	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), rq->curr, NULL))
>   		return;
>   
> +	exec_ctx = find_exec_ctx(rq, p);
> +	if (task_current(rq, exec_ctx))
> +		return;
> +
>   	/*
>   	 * p is migratable, so let's not schedule it and
>   	 * see if it is pushed or pulled somewhere else.
>   	 */
>   	if (p->nr_cpus_allowed != 1 &&
> -	    cpudl_find(&rq->rd->cpudl, p, p, NULL))
> +	    cpudl_find(&rq->rd->cpudl, p, exec_ctx, NULL))
>   		return;
>   
>   	resched_curr(rq);
> @@ -2169,12 +2175,17 @@ static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec
>   /* Locks the rq it finds */
>   static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>   {
> +	struct task_struct *exec_ctx;
>   	struct rq *later_rq = NULL;
>   	int tries;
>   	int cpu;
>   
>   	for (tries = 0; tries < DL_MAX_TRIES; tries++) {
> -		cpu = find_later_rq(task, task);
> +		exec_ctx = find_exec_ctx(rq, task);
> +		if (!exec_ctx)
> +			break;
> +
> +		cpu = find_later_rq(task, exec_ctx);
>   

Super-nit: this empty line should be removed to keep logically connected 
lines closer.
The same for find_lock_lowest_rq().

>   		if ((cpu == -1) || (cpu == rq->cpu))
>   			break;
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6371b0fca4ad..f8134d062fa3 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1640,6 +1640,11 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
>   	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), rq->curr, NULL))
>   		return;
>   
> +	/* No reason to preempt since rq->curr wouldn't change anyway */
> +	exec_ctx = find_exec_ctx(rq, p);
> +	if (task_current(rq, exec_ctx))
> +		return;
> +
>   	/*
>   	 * p is migratable, so let's not schedule it and
>   	 * see if it is pushed or pulled somewhere else.
> @@ -1933,12 +1938,14 @@ static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exe
>   /* Will lock the rq it finds */
>   static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>   {
> +	struct task_struct *exec_ctx;
>   	struct rq *lowest_rq = NULL;
>   	int tries;
>   	int cpu;
>   
>   	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
> -		cpu = find_lowest_rq(task, task);
> +		exec_ctx = find_exec_ctx(rq, task);
> +		cpu = find_lowest_rq(task, exec_ctx);
>   
>   		if ((cpu == -1) || (cpu == rq->cpu))
>   			break;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ef3d327e267c..6cd473224cfe 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3564,6 +3564,16 @@ int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
>   
>   	return 0;
>   }
> +
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p);
> +#else /* !CONFIG_SCHED_PROXY_EXEC */
> +static inline
> +struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
> +{
> +	return p;
> +}
> +#endif /* CONFIG_SCHED_PROXY_EXEC */
>   #endif

Nit: `#ifdef CONFIG_SMP` block becomes bigger after this hunk. We should 
append `/* CONFIG_SMP */` to this line, IMHO.

>   
>   #endif /* _KERNEL_SCHED_SCHED_H */


