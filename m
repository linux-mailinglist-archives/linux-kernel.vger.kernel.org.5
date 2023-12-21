Return-Path: <linux-kernel+bounces-8412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17181B6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537DB1C219A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B427A22D;
	Thu, 21 Dec 2023 12:55:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6096B745C5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 833A31FB;
	Thu, 21 Dec 2023 04:56:31 -0800 (PST)
Received: from [10.1.25.50] (e132833.arm.com [10.1.25.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F0E63F738;
	Thu, 21 Dec 2023 04:55:42 -0800 (PST)
Message-ID: <eee0c11e-a690-4a73-be74-3c7e7ebba8f9@arm.com>
Date: Thu, 21 Dec 2023 12:55:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/23] sched: Add a initial sketch of the
 find_proxy_task() function
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
 <20231220001856.3710363-12-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-12-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> Add a find_proxy_task() function which doesn't do much.
> 
> When we select a blocked task to run, we will just deactivate it
> and pick again. The exception being if it has become unblocked
> after find_proxy_task() was called.
> 
> Greatly simplified from patch by:
>    Peter Zijlstra (Intel) <peterz@infradead.org>
>    Juri Lelli <juri.lelli@redhat.com>
>    Valentin Schneider <valentin.schneider@arm.com>
>    Connor O'Brien <connoro@google.com>
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
> [jstultz: Split out from larger proxy patch and simplified
>   for review and testing.]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v5:
> * Split out from larger proxy patch
> v7:
> * Fixed unused function arguments, spelling nits, and tweaks for
>    clarity, pointed out by Metin Kaya
> * Moved task_is_blocked() implementation to this patch where it is
>    first used. Also drop unused arguments. Suggested by Metin Kaya.
> * Tweaks to make things easier to read, as suggested by Metin Kaya.
> * Rename proxy() to find_proxy_task() for clarity, and typo
>    fixes suggested by Metin Kaya
> * Fix build warning Reported-by: kernel test robot <lkp@intel.com>
>    Closes: https://lore.kernel.org/oe-kbuild-all/202311081028.yDLmCWgr-lkp@intel.com/

Super-nit: s/Add a/Add an/ in commit header.

> ---
>   kernel/sched/core.c  | 87 ++++++++++++++++++++++++++++++++++++++++++--
>   kernel/sched/rt.c    | 19 +++++++++-
>   kernel/sched/sched.h | 15 ++++++++
>   3 files changed, 115 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 34acd80b6bd0..12f5a0618328 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6572,11 +6572,11 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   #endif
>   
>   static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
> -				   unsigned long task_state)
> +				   unsigned long task_state, bool deactivate_cond)
>   {
>   	if (signal_pending_state(task_state, p)) {
>   		WRITE_ONCE(p->__state, TASK_RUNNING);
> -	} else {
> +	} else if (deactivate_cond) {
>   		p->sched_contributes_to_load =
>   			(task_state & TASK_UNINTERRUPTIBLE) &&
>   			!(task_state & TASK_NOLOAD) &&
> @@ -6607,6 +6607,73 @@ static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
>   	return false;
>   }
>   
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +
> +static bool proxy_deactivate(struct rq *rq, struct task_struct *next)
> +{
> +	unsigned long state = READ_ONCE(next->__state);
> +
> +	/* Don't deactivate if the state has been changed to TASK_RUNNING */
> +	if (state == TASK_RUNNING)
> +		return false;
> +	if (!try_to_deactivate_task(rq, next, state, true))
> +		return false;
> +	put_prev_task(rq, next);
> +	rq_set_selected(rq, rq->idle);
> +	resched_curr(rq);
> +	return true;
> +}
> +
> +/*
> + * Initial simple proxy that just returns the task if it's waking
> + * or deactivates the blocked task so we can pick something that
> + * isn't blocked.
> + */
> +static struct task_struct *
> +find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> +{
> +	struct task_struct *ret = NULL;
> +	struct task_struct *p = next;
> +	struct mutex *mutex;
> +
> +	mutex = p->blocked_on;
> +	/* Something changed in the chain, so pick again */
> +	if (!mutex)
> +		return NULL;
> +	/*
> +	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> +	 * and ensure @owner sticks around.
> +	 */
> +	raw_spin_lock(&mutex->wait_lock);
> +	raw_spin_lock(&p->blocked_lock);
> +
> +	/* Check again that p is blocked with blocked_lock held */
> +	if (!task_is_blocked(p) || mutex != p->blocked_on) {
> +		/*
> +		 * Something changed in the blocked_on chain and
> +		 * we don't know if only at this level. So, let's
> +		 * just bail out completely and let __schedule
> +		 * figure things out (pick_again loop).
> +		 */
> +		goto out;
> +	}
> +
> +	if (!proxy_deactivate(rq, next))
> +		ret = p;
> +out:
> +	raw_spin_unlock(&p->blocked_lock);
> +	raw_spin_unlock(&mutex->wait_lock);
> +	return ret;
> +}
> +#else /* SCHED_PROXY_EXEC */
> +static struct task_struct *
> +find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> +{
> +	BUG(); // This should never be called in the !PROXY case
> +	return next;
> +}
> +#endif /* SCHED_PROXY_EXEC */
> +
>   /*
>    * __schedule() is the main scheduler function.
>    *
> @@ -6698,12 +6765,24 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   	 */
>   	prev_state = READ_ONCE(prev->__state);
>   	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
> -		try_to_deactivate_task(rq, prev, prev_state);
> +		try_to_deactivate_task(rq, prev, prev_state,
> +				       !task_is_blocked(prev));
>   		switch_count = &prev->nvcsw;
>   	}
>   
> -	next = pick_next_task(rq, prev, &rf);
> +pick_again:
> +	next = pick_next_task(rq, rq_selected(rq), &rf);
>   	rq_set_selected(rq, next);
> +	if (unlikely(task_is_blocked(next))) {
> +		next = find_proxy_task(rq, next, &rf);
> +		if (!next) {
> +			rq_unpin_lock(rq, &rf);
> +			__balance_callbacks(rq);
> +			rq_repin_lock(rq, &rf);
> +			goto pick_again;
> +		}
> +	}
> +
>   	clear_tsk_need_resched(prev);
>   	clear_preempt_need_resched();
>   #ifdef CONFIG_SCHED_DEBUG
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2682cec45aaa..81cd22eaa6dc 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1491,8 +1491,19 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>   
>   	enqueue_rt_entity(rt_se, flags);
>   
> -	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> -		enqueue_pushable_task(rq, p);
> +	/*
> +	 * Current can't be pushed away. Selected is tied to current,
> +	 * so don't push it either.
> +	 */
> +	if (task_current(rq, p) || task_current_selected(rq, p))
> +		return;
> +	/*
> +	 * Pinned tasks can't be pushed.
> +	 */
> +	if (p->nr_cpus_allowed == 1)
> +		return;
> +
> +	enqueue_pushable_task(rq, p);
>   }
>   
>   static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
> @@ -1779,6 +1790,10 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>   
>   	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
>   
> +	/* Avoid marking selected as pushable */
> +	if (task_current_selected(rq, p))
> +		return;
> +
>   	/*
>   	 * The previous task needs to be made eligible for pushing
>   	 * if it is still active
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6ea1dfbe502a..765ba10661de 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2148,6 +2148,21 @@ static inline int task_current_selected(struct rq *rq, struct task_struct *p)
>   	return rq_selected(rq) == p;
>   }
>   
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +static inline bool task_is_blocked(struct task_struct *p)
> +{
> +	if (!sched_proxy_exec())
> +		return false;
> +
> +	return !!p->blocked_on && p->blocked_on_state != BO_RUNNABLE;
> +}
> +#else /* !SCHED_PROXY_EXEC */
> +static inline bool task_is_blocked(struct task_struct *p)
> +{
> +	return false;
> +}
> +#endif /* SCHED_PROXY_EXEC */
> +

We can drop #else part, IMHO. Because sched_proxy_exec() already returns 
false in !CONFIG_SCHED_PROXY_EXEC case.

>   static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
>   {
>   #ifdef CONFIG_SMP


