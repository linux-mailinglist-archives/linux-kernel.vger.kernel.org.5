Return-Path: <linux-kernel+bounces-8185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC1D81B349
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8E01C24EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5AE4EB5C;
	Thu, 21 Dec 2023 10:13:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDE4E1B5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37F9F2F4;
	Thu, 21 Dec 2023 02:14:31 -0800 (PST)
Received: from [10.57.87.54] (unknown [10.57.87.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2727A3F5A1;
	Thu, 21 Dec 2023 02:13:43 -0800 (PST)
Message-ID: <35af7d68-7a98-4b72-8186-814482f9f98f@arm.com>
Date: Thu, 21 Dec 2023 10:13:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/23] locking/mutex: Rework task_struct::blocked_on
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
 kernel-team@android.com, Connor O'Brien <connoro@google.com>
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-6-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-6-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Track the blocked-on relation for mutexes, to allow following this
> relation at schedule time.
> 
>     task
>       | blocked-on
>       v
>     mutex
>       | owner
>       v
>     task
> 
> Also adds a blocked_on_state value so we can distinguqish when a

What about "Also add a blocked_on_state enum to task_struct to 
distinguish ..." to use an imperative language?
The same for "Also adds" and "Finally adds" below.

> task is blocked_on a mutex, but is either blocked, waking up, or
> runnable (such that it can try to aquire the lock its blocked

                                     acquire

> on).
> 
> This avoids some of the subtle & racy games where the blocked_on
> state gets cleared, only to have it re-added by the
> mutex_lock_slowpath call when it tries to aquire the lock on

                                             ditto

> wakeup

   wakeup.

> 
> Also adds blocked_lock to the task_struct so we can safely
> serialize the blocked-on state.
> 
> Finally adds wrappers that are useful to provide correctness
> checks. Folded in from a patch by:
>     Valentin Schneider <valentin.schneider@arm.com>
> 
> This all will be used for tracking blocked-task/mutex chains
> with the prox-execution patch in a similar fashion to how
            proxy

> priority inheritence is done with rt_mutexes.
            inheritance

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
> [minor changes while rebasing]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: Fix blocked_on tracking in __mutex_lock_common in error paths]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v2:
> * Fixed blocked_on tracking in error paths that was causing crashes
> v4:
> * Ensure we clear blocked_on when waking ww_mutexes to die or wound.
>    This is critical so we don't get ciruclar blocked_on relationships

                                       circular

>    that can't be resolved.
> v5:
> * Fix potential bug where the skip_wait path might clear blocked_on
>    when that path never set it
> * Slight tweaks to where we set blocked_on to make it consistent,
>    along with extra WARN_ON correctness checking
> * Minor comment changes
> v7:
> * Minor commit message change suggested by Metin Kaya
> * Fix WARN_ON conditionals in unlock path (as blocked_on might
>    already be cleared), found while looking at issue Metin Kaya
>    raised.
> * Minor tweaks to be consistent in what we do under the
>    blocked_on lock, also tweaked variable name to avoid confusion
>    with label, and comment typos, as suggested by Metin Kaya
> * Minor tweak for CONFIG_SCHED_PROXY_EXEC name change
> * Moved unused block of code to later in the series, as suggested
>    by Metin Kaya
> * Switch to a tri-state to be able to distinguish from waking and
>    runnable so we can later safely do return migration from ttwu
> * Folded together with related blocked_on changes
> ---
>   include/linux/sched.h        | 40 ++++++++++++++++++++++++++++++++----
>   init/init_task.c             |  1 +
>   kernel/fork.c                |  4 ++--
>   kernel/locking/mutex-debug.c |  9 ++++----
>   kernel/locking/mutex.c       | 35 +++++++++++++++++++++++++++----
>   kernel/locking/ww_mutex.h    | 24 ++++++++++++++++++++--
>   kernel/sched/core.c          |  6 ++++++
>   7 files changed, 103 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1e80c330f755..bfe8670f99a1 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -743,6 +743,12 @@ struct kmap_ctrl {
>   #endif
>   };
>   
> +enum blocked_on_state {
> +	BO_RUNNABLE,
> +	BO_BLOCKED,
> +	BO_WAKING,
> +};
> +
>   struct task_struct {
>   #ifdef CONFIG_THREAD_INFO_IN_TASK
>   	/*
> @@ -1149,10 +1155,9 @@ struct task_struct {
>   	struct rt_mutex_waiter		*pi_blocked_on;
>   #endif
>   
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	/* Mutex deadlock detection: */
> -	struct mutex_waiter		*blocked_on;
> -#endif
> +	enum blocked_on_state		blocked_on_state;
> +	struct mutex			*blocked_on;	/* lock we're blocked on */
> +	raw_spinlock_t			blocked_lock;
>   
>   #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>   	int				non_block_count;
> @@ -2258,6 +2263,33 @@ static inline int rwlock_needbreak(rwlock_t *lock)
>   #endif
>   }
>   
> +static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
> +{
> +	lockdep_assert_held(&p->blocked_lock);
> +
> +	/*
> +	 * Check we are clearing values to NULL or setting NULL
> +	 * to values to ensure we don't overwrite exisiting mutex

                                                   existing

> +	 * values or clear already cleared values
> +	 */
> +	WARN_ON((!m && !p->blocked_on) || (m && p->blocked_on));
> +
> +	p->blocked_on = m;
> +	p->blocked_on_state = m ? BO_BLOCKED : BO_RUNNABLE;
> +}
> +
> +static inline struct mutex *get_task_blocked_on(struct task_struct *p)
> +{
> +	lockdep_assert_held(&p->blocked_lock);
> +
> +	return p->blocked_on;
> +}
> +
> +static inline struct mutex *get_task_blocked_on_once(struct task_struct *p)
> +{
> +	return READ_ONCE(p->blocked_on);
> +}

These functions make me think we should use [get, set]_task_blocked_on() 
for accessing blocked_on & blocked_on_state fields, but there are some 
references in this patch which we directly access aforementioned fields.
Is this OK?

> +
>   static __always_inline bool need_resched(void)
>   {
>   	return unlikely(tif_need_resched());
> diff --git a/init/init_task.c b/init/init_task.c
> index 5727d42149c3..0c31d7d7c7a9 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -131,6 +131,7 @@ struct task_struct init_task
>   	.journal_info	= NULL,
>   	INIT_CPU_TIMERS(init_task)
>   	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
> +	.blocked_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.blocked_lock),
>   	.timer_slack_ns = 50000, /* 50 usec default slack */
>   	.thread_pid	= &init_struct_pid,
>   	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..b3ba3d22d8b2 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2358,6 +2358,7 @@ __latent_entropy struct task_struct *copy_process(
>   	ftrace_graph_init_task(p);
>   
>   	rt_mutex_init_task(p);
> +	raw_spin_lock_init(&p->blocked_lock);
>   
>   	lockdep_assert_irqs_enabled();
>   #ifdef CONFIG_PROVE_LOCKING
> @@ -2456,9 +2457,8 @@ __latent_entropy struct task_struct *copy_process(
>   	lockdep_init_task(p);
>   #endif
>   
> -#ifdef CONFIG_DEBUG_MUTEXES
> +	p->blocked_on_state = BO_RUNNABLE;
>   	p->blocked_on = NULL; /* not blocked yet */
> -#endif
>   #ifdef CONFIG_BCACHE
>   	p->sequential_io	= 0;
>   	p->sequential_io_avg	= 0;
> diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
> index bc8abb8549d2..1eedf7c60c00 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -52,17 +52,18 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   {
>   	lockdep_assert_held(&lock->wait_lock);
>   
> -	/* Mark the current thread as blocked on the lock: */
> -	task->blocked_on = waiter;
> +	/* Current thread can't be already blocked (since it's executing!) */
> +	DEBUG_LOCKS_WARN_ON(get_task_blocked_on(task));
>   }
>   
>   void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   			 struct task_struct *task)
>   {
> +	struct mutex *blocked_on = get_task_blocked_on_once(task);
> +
>   	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
>   	DEBUG_LOCKS_WARN_ON(waiter->task != task);
> -	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
> -	task->blocked_on = NULL;
> +	DEBUG_LOCKS_WARN_ON(blocked_on && blocked_on != lock);
>   
>   	INIT_LIST_HEAD(&waiter->list);
>   	waiter->task = NULL;
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 543774506fdb..6084470773f6 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -592,6 +592,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   	}
>   
>   	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +	raw_spin_lock(&current->blocked_lock);
>   	/*
>   	 * After waiting to acquire the wait_lock, try again.
>   	 */
> @@ -622,6 +623,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   			goto err_early_kill;
>   	}
>   
> +	set_task_blocked_on(current, lock);
>   	set_current_state(state);
>   	trace_contention_begin(lock, LCB_F_MUTEX);
>   	for (;;) {
> @@ -652,6 +654,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   				goto err;
>   		}
>   
> +		raw_spin_unlock(&current->blocked_lock);
>   		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>   		/* Make sure we do wakeups before calling schedule */
>   		if (!wake_q_empty(&wake_q)) {
> @@ -662,6 +665,13 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   
>   		first = __mutex_waiter_is_first(lock, &waiter);
>   
> +		raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +		raw_spin_lock(&current->blocked_lock);
> +
> +		/*
> +		 * Re-set blocked_on_state as unlock path set it to WAKING/RUNNABLE
> +		 */
> +		current->blocked_on_state = BO_BLOCKED;
>   		set_current_state(state);
>   		/*
>   		 * Here we order against unlock; we must either see it change
> @@ -672,16 +682,25 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   			break;
>   
>   		if (first) {
> +			bool opt_acquired;
> +
> +			/*
> +			 * mutex_optimistic_spin() can schedule, so  we need to
> +			 * release these locks before calling it.
> +			 */
> +			raw_spin_unlock(&current->blocked_lock);
> +			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>   			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
> -			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
> +			opt_acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
> +			raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +			raw_spin_lock(&current->blocked_lock);
> +			if (opt_acquired)
>   				break;
>   			trace_contention_begin(lock, LCB_F_MUTEX);
>   		}
> -
> -		raw_spin_lock_irqsave(&lock->wait_lock, flags);
>   	}
> -	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>   acquired:
> +	set_task_blocked_on(current, NULL);
>   	__set_current_state(TASK_RUNNING);
>   
>   	if (ww_ctx) {
> @@ -706,16 +725,20 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   	if (ww_ctx)
>   		ww_mutex_lock_acquired(ww, ww_ctx);
>   
> +	raw_spin_unlock(&current->blocked_lock);
>   	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>   	wake_up_q(&wake_q);
>   	preempt_enable();
>   	return 0;
>   
>   err:
> +	set_task_blocked_on(current, NULL);
>   	__set_current_state(TASK_RUNNING);
>   	__mutex_remove_waiter(lock, &waiter);
>   err_early_kill:
> +	WARN_ON(current->blocked_on);
>   	trace_contention_end(lock, ret);
> +	raw_spin_unlock(&current->blocked_lock);
>   	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>   	debug_mutex_free_waiter(&waiter);
>   	mutex_release(&lock->dep_map, ip);
> @@ -925,8 +948,12 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>   
>   		next = waiter->task;
>   
> +		raw_spin_lock(&next->blocked_lock);
>   		debug_mutex_wake_waiter(lock, waiter);
> +		WARN_ON(next->blocked_on != lock);
> +		next->blocked_on_state = BO_WAKING;
>   		wake_q_add(&wake_q, next);
> +		raw_spin_unlock(&next->blocked_lock);
>   	}
>   
>   	if (owner & MUTEX_FLAG_HANDOFF)
> diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> index 9facc0ddfdd3..8dd21ff5eee0 100644
> --- a/kernel/locking/ww_mutex.h
> +++ b/kernel/locking/ww_mutex.h
> @@ -281,10 +281,21 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
>   		return false;
>   
>   	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
> +		/* nested as we should hold current->blocked_lock already */
> +		raw_spin_lock_nested(&waiter->task->blocked_lock, SINGLE_DEPTH_NESTING);
>   #ifndef WW_RT
>   		debug_mutex_wake_waiter(lock, waiter);
>   #endif
> +		/*
> +		 * When waking up the task to die, be sure to set the
> +		 * blocked_on_state to WAKING. Otherwise we can see
> +		 * circular  blocked_on relationships that can't
> +		 * resolve.
> +		 */
> +		WARN_ON(waiter->task->blocked_on != lock);
> +		waiter->task->blocked_on_state = BO_WAKING;
>   		wake_q_add(wake_q, waiter->task);
> +		raw_spin_unlock(&waiter->task->blocked_lock);
>   	}
>   
>   	return true;
> @@ -331,9 +342,18 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
>   		 * it's wounded in __ww_mutex_check_kill() or has a
>   		 * wakeup pending to re-read the wounded state.
>   		 */
> -		if (owner != current)
> +		if (owner != current) {
> +			/* nested as we should hold current->blocked_lock already */
> +			raw_spin_lock_nested(&owner->blocked_lock, SINGLE_DEPTH_NESTING);
> +			/*
> +			 * When waking up the task to wound, be sure to set the
> +			 * blocked_on_state flag. Otherwise we can see circular
> +			 * blocked_on relationships that can't resolve.
> +			 */
> +			owner->blocked_on_state = BO_WAKING;
>   			wake_q_add(wake_q, owner);
> -
> +			raw_spin_unlock(&owner->blocked_lock);
> +		}
>   		return true;
>   	}
>   
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a708d225c28e..4e46189d545d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4195,6 +4195,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
>   int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   {
>   	guard(preempt)();
> +	unsigned long flags;
>   	int cpu, success = 0;
>   
>   	if (p == current) {
> @@ -4341,6 +4342,11 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   
>   		ttwu_queue(p, cpu, wake_flags);
>   	}
> +	/* XXX can we do something better here for !CONFIG_SCHED_PROXY_EXEC case */

blocked_on* fields are now used even in !CONFIG_SCHED_PROXY_EXEC case.
I'm unsure if we can get rid of lock & unlock lines or entire hunk, but 
would this be too ugly? I wish we could convert blocked_on_state to an 
atomic variable.

if (p->blocked_on_state == BO_WAKING) {
	raw_spin_lock_irqsave(&p->blocked_lock, flags);
	p->blocked_on_state = BO_RUNNABLE;
	raw_spin_unlock_irqrestore(&p->blocked_lock, flags);
}

> +	raw_spin_lock_irqsave(&p->blocked_lock, flags);
> +	if (p->blocked_on_state == BO_WAKING)
> +		p->blocked_on_state = BO_RUNNABLE;
> +	raw_spin_unlock_irqrestore(&p->blocked_lock, flags);
>   out:
>   	if (success)
>   		ttwu_stat(p, task_cpu(p), wake_flags);


