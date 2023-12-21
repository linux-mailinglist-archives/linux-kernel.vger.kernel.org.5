Return-Path: <linux-kernel+bounces-8665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFA681BACE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16211F2279E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF4539EF;
	Thu, 21 Dec 2023 15:30:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED7539E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DB602F4;
	Thu, 21 Dec 2023 07:31:20 -0800 (PST)
Received: from [10.1.25.50] (e132833.arm.com [10.1.25.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63C2F3F64C;
	Thu, 21 Dec 2023 07:30:30 -0800 (PST)
Message-ID: <49fb9cc3-c91d-4e9d-b75f-b31a8b5b2a91@arm.com>
Date: Thu, 21 Dec 2023 15:30:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/23] sched: Start blocked_on chain processing in
 find_proxy_task()
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes
 <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
 kernel-team@android.com, Valentin Schneider <valentin.schneider@arm.com>
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-14-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-14-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Start to flesh out the real find_proxy_task() implementation,
> but avoid the migration cases for now, in those cases just
> deactivate the selected task and pick again.
> 
> To ensure the selected task or other blocked tasks in the chain
> aren't migrated away while we're running the proxy, this patch
> also tweaks CFS logic to avoid migrating selected or mutex
> blocked tasks.
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
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: This change was split out from the larger proxy patch]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v5:
> * Split this out from larger proxy patch
> v7:
> * Minor refactoring of core find_proxy_task() function
> * Minor spelling and corrections suggested by Metin Kaya
> * Dropped an added BUG_ON that was frequently tripped
> * Minor commit message tweaks from Metin Kaya
> ---
>   kernel/sched/core.c | 154 +++++++++++++++++++++++++++++++++++++-------
>   kernel/sched/fair.c |   9 ++-
>   2 files changed, 137 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f6bf3b62194c..42e25bbdfe6b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -94,6 +94,7 @@
>   #include "../workqueue_internal.h"
>   #include "../../io_uring/io-wq.h"
>   #include "../smpboot.h"
> +#include "../locking/mutex.h"
>   
>   EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpu);
>   EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
> @@ -6609,6 +6610,15 @@ static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
>   
>   #ifdef CONFIG_SCHED_PROXY_EXEC
>   
> +static inline struct task_struct *
> +proxy_resched_idle(struct rq *rq, struct task_struct *next)
> +{
> +	put_prev_task(rq, next);
> +	rq_set_selected(rq, rq->idle);
> +	set_tsk_need_resched(rq->idle);
> +	return rq->idle;
> +}
> +
>   static bool proxy_deactivate(struct rq *rq, struct task_struct *next)
>   {
>   	unsigned long state = READ_ONCE(next->__state);
> @@ -6618,48 +6628,138 @@ static bool proxy_deactivate(struct rq *rq, struct task_struct *next)
>   		return false;
>   	if (!try_to_deactivate_task(rq, next, state, true))
>   		return false;
> -	put_prev_task(rq, next);
> -	rq_set_selected(rq, rq->idle);
> -	resched_curr(rq);
> +	proxy_resched_idle(rq, next);
>   	return true;
>   }
>   
>   /*
> - * Initial simple proxy that just returns the task if it's waking
> - * or deactivates the blocked task so we can pick something that
> - * isn't blocked.
> + * Find who @next (currently blocked on a mutex) can proxy for.
> + *
> + * Follow the blocked-on relation:
> + *   task->blocked_on -> mutex->owner -> task...
> + *
> + * Lock order:
> + *
> + *   p->pi_lock
> + *     rq->lock
> + *       mutex->wait_lock
> + *         p->blocked_lock
> + *
> + * Returns the task that is going to be used as execution context (the one
> + * that is actually going to be put to run on cpu_of(rq)).
>    */
>   static struct task_struct *
>   find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
>   {
> +	struct task_struct *owner = NULL;
>   	struct task_struct *ret = NULL;
> -	struct task_struct *p = next;
> +	struct task_struct *p;
>   	struct mutex *mutex;
> +	int this_cpu = cpu_of(rq);
>   
> -	mutex = p->blocked_on;
> -	/* Something changed in the chain, so pick again */
> -	if (!mutex)
> -		return NULL;
>   	/*
> -	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> -	 * and ensure @owner sticks around.
> +	 * Follow blocked_on chain.
> +	 *
> +	 * TODO: deadlock detection
>   	 */
> -	raw_spin_lock(&mutex->wait_lock);
> -	raw_spin_lock(&p->blocked_lock);
> +	for (p = next; task_is_blocked(p); p = owner) {
> +		mutex = p->blocked_on;
> +		/* Something changed in the chain, so pick again */
> +		if (!mutex)
> +			return NULL;
>   
> -	/* Check again that p is blocked with blocked_lock held */
> -	if (!task_is_blocked(p) || mutex != p->blocked_on) {
>   		/*
> -		 * Something changed in the blocked_on chain and
> -		 * we don't know if only at this level. So, let's
> -		 * just bail out completely and let __schedule
> -		 * figure things out (pick_again loop).
> +		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> +		 * and ensure @owner sticks around.
>   		 */
> -		goto out;
> +		raw_spin_lock(&mutex->wait_lock);
> +		raw_spin_lock(&p->blocked_lock);
> +
> +		/* Check again that p is blocked with blocked_lock held */

Is this comment still valid?

> +		if (mutex != p->blocked_on) {
> +			/*
> +			 * Something changed in the blocked_on chain and
> +			 * we don't know if only at this level. So, let's
> +			 * just bail out completely and let __schedule
> +			 * figure things out (pick_again loop).
> +			 */
> +			goto out;
> +		}
> +
> +		owner = __mutex_owner(mutex);
> +		if (!owner) {
> +			ret = p;
> +			goto out;
> +		}
> +
> +		if (task_cpu(owner) != this_cpu) {
> +			/* XXX Don't handle migrations yet */
> +			if (!proxy_deactivate(rq, next))
> +				ret = next;
> +			goto out;
> +		}
> +
> +		if (task_on_rq_migrating(owner)) {
> +			/*
> +			 * One of the chain of mutex owners is currently migrating to this
> +			 * CPU, but has not yet been enqueued because we are holding the
> +			 * rq lock. As a simple solution, just schedule rq->idle to give
> +			 * the migration a chance to complete. Much like the migrate_task
> +			 * case we should end up back in proxy(), this time hopefully with

s/proxy/find_proxy_task/

> +			 * all relevant tasks already enqueued.
> +			 */
> +			raw_spin_unlock(&p->blocked_lock);
> +			raw_spin_unlock(&mutex->wait_lock);
> +			return proxy_resched_idle(rq, next);
> +		}
> +
> +		if (!owner->on_rq) {
> +			/* XXX Don't handle blocked owners yet */
> +			if (!proxy_deactivate(rq, next))
> +				ret = next;
> +			goto out;
> +		}
> +
> +		if (owner == p) {
> +			/*
> +			 * It's possible we interleave with mutex_unlock like:
> +			 *
> +			 *				lock(&rq->lock);
> +			 *				  find_proxy_task()
> +			 * mutex_unlock()
> +			 *   lock(&wait_lock);
> +			 *   next(owner) = current->blocked_donor;
> +			 *   unlock(&wait_lock);
> +			 *
> +			 *   wake_up_q();
> +			 *     ...
> +			 *       ttwu_runnable()
> +			 *         __task_rq_lock()
> +			 *				  lock(&wait_lock);
> +			 *				  owner == p
> +			 *
> +			 * Which leaves us to finish the ttwu_runnable() and make it go.
> +			 *
> +			 * So schedule rq->idle so that ttwu_runnable can get the rq lock
> +			 * and mark owner as running.
> +			 */
> +			raw_spin_unlock(&p->blocked_lock);
> +			raw_spin_unlock(&mutex->wait_lock);
> +			return proxy_resched_idle(rq, next);
> +		}
> +
> +		/*
> +		 * OK, now we're absolutely sure @owner is not blocked _and_
> +		 * on this rq, therefore holding @rq->lock is sufficient to
> +		 * guarantee its existence, as per ttwu_remote().
> +		 */
> +		raw_spin_unlock(&p->blocked_lock);
> +		raw_spin_unlock(&mutex->wait_lock);
>   	}
>   
> -	if (!proxy_deactivate(rq, next))
> -		ret = p;
> +	WARN_ON_ONCE(owner && !owner->on_rq);
> +	return owner;
> +
>   out:
>   	raw_spin_unlock(&p->blocked_lock);
>   	raw_spin_unlock(&mutex->wait_lock);
> @@ -6738,6 +6838,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   	struct rq_flags rf;
>   	struct rq *rq;
>   	int cpu;
> +	bool preserve_need_resched = false;
>   
>   	cpu = smp_processor_id();
>   	rq = cpu_rq(cpu);
> @@ -6798,9 +6899,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   			rq_repin_lock(rq, &rf);
>   			goto pick_again;
>   		}
> +		if (next == rq->idle && prev == rq->idle)
> +			preserve_need_resched = true;
>   	}
>   
> -	clear_tsk_need_resched(prev);
> +	if (!preserve_need_resched)
> +		clear_tsk_need_resched(prev);
>   	clear_preempt_need_resched();
>   #ifdef CONFIG_SCHED_DEBUG
>   	rq->last_seen_need_resched_ns = 0;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 085941db5bf1..954b41e5b7df 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8905,6 +8905,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>   	if (kthread_is_per_cpu(p))
>   		return 0;
>   
> +	if (task_is_blocked(p))
> +		return 0;

I think "We do not migrate tasks that are: ..." 
(kernel/sched/fair.c:8897) comment needs to be updated for this change.

> +
>   	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>   		int cpu;
>   
> @@ -8941,7 +8944,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>   	/* Record that we found at least one task that could run on dst_cpu */
>   	env->flags &= ~LBF_ALL_PINNED;
>   
> -	if (task_on_cpu(env->src_rq, p)) {
> +	if (task_on_cpu(env->src_rq, p) ||
> +	    task_current_selected(env->src_rq, p)) {
>   		schedstat_inc(p->stats.nr_failed_migrations_running);
>   		return 0;
>   	}
> @@ -8980,6 +8984,9 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
>   {
>   	lockdep_assert_rq_held(env->src_rq);
>   
> +	BUG_ON(task_current(env->src_rq, p));
> +	BUG_ON(task_current_selected(env->src_rq, p));
> +
>   	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
>   	set_task_cpu(p, env->dst_cpu);
>   }


