Return-Path: <linux-kernel+bounces-9793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C781CB8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320C21C22383
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48324215;
	Fri, 22 Dec 2023 14:51:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66DF24209
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5839F2F4;
	Fri, 22 Dec 2023 06:52:07 -0800 (PST)
Received: from [10.57.87.46] (unknown [10.57.87.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A076D3F5A1;
	Fri, 22 Dec 2023 06:51:18 -0800 (PST)
Message-ID: <8001a9bc-3f87-403c-a091-215c56c9ebf0@arm.com>
Date: Fri, 22 Dec 2023 14:51:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/23] sched: Fix rt/dl load balancing via chain level
 balance
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
 <20231220001856.3710363-24-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-24-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> RT/DL balancing is supposed to guarantee that with N cpus available &
> CPU affinity permitting, the top N RT/DL tasks will get spread across
> the CPUs and all get to run. Proxy exec greatly complicates this as
> blocked tasks remain on the rq but cannot be usefully migrated away
> from their lock owning tasks. This has two major consequences:
> 1. In order to get the desired properties we need to migrate a blocked
> task, its would-be proxy, and everything in between, all together -
> i.e., we need to push/pull "blocked chains" rather than individual
> tasks.
> 2. Tasks that are part of rq->curr's "blocked tree" therefore should
> not be pushed or pulled. Options for enforcing this seem to include
> a) create some sort of complex data structure for tracking
> pushability, updating it whenever the blocked tree for rq->curr
> changes (e.g. on mutex handoffs, migrations, etc.) as well as on
> context switches.
> b) give up on O(1) pushability checks, and search through the pushable
> list every push/pull until we find a pushable "chain"
> c) Extend option "b" with some sort of caching to avoid repeated work.
> 
> For the sake of simplicity & separating the "chain level balancing"
> concerns from complicated optimizations, this patch focuses on trying
> to implement option "b" correctly. This can then hopefully provide a
> baseline for "correct load balancing behavior" that optimizations can
> try to implement more efficiently.
> 
> Note:
> The inability to atomically check "is task enqueued on a specific rq"
> creates 2 possible races when following a blocked chain:
> - If we check task_rq() first on a task that is dequeued from its rq,
>    it can be woken and enqueued on another rq before the call to
>    task_on_rq_queued()
> - If we call task_on_rq_queued() first on a task that is on another
>    rq, it can be dequeued (since we don't hold its rq's lock) and then
>    be set to the current rq before we check task_rq().
> 
> Maybe there's a more elegant solution that would work, but for now,
> just sandwich the task_rq() check between two task_on_rq_queued()
> checks, all separated by smp_rmb() calls. Since we hold rq's lock,
> task can't be enqueued or dequeued from rq, so neither race should be
> possible.
> 
> extensive comments on various pitfalls, races, etc. included inline.
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
> [jstultz: split out from larger chain migration patch,
>   majorly refactored for runtime conditionalization]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v7:
> * Split out from larger chain-migration patch in earlier
>    versions of this series
> * Larger rework to allow proper conditionalization of the
>    logic when running with CONFIG_SCHED_PROXY_EXEC
> ---
>   kernel/sched/core.c     |  77 +++++++++++++++++++++++-
>   kernel/sched/deadline.c |  98 +++++++++++++++++++++++-------
>   kernel/sched/rt.c       | 130 ++++++++++++++++++++++++++++++++--------
>   kernel/sched/sched.h    |  18 +++++-
>   4 files changed, 273 insertions(+), 50 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 77a79d5f829a..30dfb6f14f2b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3923,7 +3923,6 @@ struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
>   		return p;
>   
>   	lockdep_assert_rq_held(rq);
> -
>   	for (exec_ctx = p; task_is_blocked(exec_ctx) && !task_on_cpu(rq, exec_ctx);
>   							exec_ctx = owner) {
>   		mutex = exec_ctx->blocked_on;
> @@ -3938,6 +3937,82 @@ struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
>   	}
>   	return exec_ctx;
>   }
> +
> +#ifdef CONFIG_SMP
> +void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
> +{
> +	struct task_struct *owner;
> +
> +	if (!sched_proxy_exec()) {
> +		__push_task_chain(rq, dst_rq, task);
> +		return;
> +	}
> +
> +	lockdep_assert_rq_held(rq);
> +	lockdep_assert_rq_held(dst_rq);
> +
> +	BUG_ON(!task_queued_on_rq(rq, task));
> +	BUG_ON(task_current_selected(rq, task));
> +
> +	while (task) {
> +		if (!task_queued_on_rq(rq, task) || task_current_selected(rq, task))
> +			break;
> +
> +		if (task_is_blocked(task))
> +			owner = __mutex_owner(task->blocked_on);
> +		else
> +			owner = NULL;
> +		__push_task_chain(rq, dst_rq, task);
> +		if (task == owner)
> +			break;
> +		task = owner;
> +	}
> +}
> +
> +/*
> + * Returns:
> + * 1 if chain is pushable and affinity does not prevent pushing to cpu
> + * 0 if chain is unpushable
> + * -1 if chain is pushable but affinity blocks running on cpu.
> + */
> +int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
> +{
> +	struct task_struct *exec_ctx;
> +
> +	if (!sched_proxy_exec())
> +		return __task_is_pushable(rq, p, cpu);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (task_rq(p) != rq || !task_on_rq_queued(p))
> +		return 0;
> +
> +	exec_ctx = find_exec_ctx(rq, p);
> +	/*
> +	 * Chain leads off the rq, we're free to push it anywhere.
> +	 *
> +	 * One wrinkle with relying on find_exec_ctx is that when the chain
> +	 * leads to a task currently migrating to rq, we see the chain as
> +	 * pushable & push everything prior to the migrating task. Even if
> +	 * we checked explicitly for this case, we could still race with a
> +	 * migration after the check.
> +	 * This shouldn't permanently produce a bad state though, as proxy()

                                                        find_proxy_task()

> +	 * will send the chain back to rq and by that point the migration
> +	 * should be complete & a proper push can occur.
> +	 */
> +	if (!exec_ctx)
> +		return 1;
> +
> +	if (task_on_cpu(rq, exec_ctx) || exec_ctx->nr_cpus_allowed <= 1)
> +		return 0;
> +
> +	return cpumask_test_cpu(cpu, &exec_ctx->cpus_mask) ? 1 : -1;
> +}
> +#else /* !CONFIG_SMP */
> +void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
> +{
> +}
> +#endif /* CONFIG_SMP */
>   #else /* !CONFIG_SCHED_PROXY_EXEC */
>   static inline void do_activate_task(struct rq *rq, struct task_struct *p,
>   				    int en_flags)
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8b5701727342..b7be888c1635 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2172,8 +2172,77 @@ static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec
>   	return -1;
>   }
>   
> +static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
> +{
> +	struct task_struct *p = NULL;
> +	struct rb_node *next_node;
> +
> +	if (!has_pushable_dl_tasks(rq))
> +		return NULL;
> +
> +	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
> +
> +next_node:
> +	if (next_node) {
> +		p = __node_2_pdl(next_node);
> +
> +		/*
> +		 * cpu argument doesn't matter because we treat a -1 result
> +		 * (pushable but can't go to cpu0) the same as a 1 result
> +		 * (pushable to cpu0). All we care about here is general
> +		 * pushability.
> +		 */
> +		if (task_is_pushable(rq, p, 0))
> +			return p;
> +
> +		next_node = rb_next(next_node);
> +		goto next_node;
> +	}
> +
> +	if (!p)
> +		return NULL;
> +
> +	WARN_ON_ONCE(rq->cpu != task_cpu(p));
> +	WARN_ON_ONCE(task_current(rq, p));
> +	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> +
> +	WARN_ON_ONCE(!task_on_rq_queued(p));
> +	WARN_ON_ONCE(!dl_task(p));
> +
> +	return p;
> +}
> +
> +#ifdef CONFIG_SCHED_PROXY_EXEC
>   static inline bool dl_revalidate_rq_state(struct task_struct *task, struct rq *rq,
> -					  struct rq *later)
> +					  struct rq *later, bool *retry)
> +{
> +	if (!dl_task(task) || is_migration_disabled(task))
> +		return false;
> +
> +	if (rq != this_rq()) {
> +		struct task_struct *next_task = pick_next_pushable_dl_task(rq);
> +
> +		if (next_task == task) {

Nit: We can `return false;` if next_task != task and save one level of 
indentation.

> +			struct task_struct *exec_ctx;
> +
> +			exec_ctx = find_exec_ctx(rq, next_task);
> +			*retry = (exec_ctx && !cpumask_test_cpu(later->cpu,
> +							       &exec_ctx->cpus_mask));
> +		} else {
> +			return false;
> +		}
> +	} else {
> +		int pushable = task_is_pushable(rq, task, later->cpu);
> +
> +		*retry = pushable == -1;
> +		if (!pushable)
> +			return false;

`return pushable;` can replace above 2 lines.
The same for rt_revalidate_rq_state().

> +	}
> +	return true;
> +}
> +#else
> +static inline bool dl_revalidate_rq_state(struct task_struct *task, struct rq *rq,
> +					  struct rq *later, bool *retry)
>   {
>   	if (task_rq(task) != rq)
>   		return false;
> @@ -2195,16 +2264,18 @@ static inline bool dl_revalidate_rq_state(struct task_struct *task, struct rq *r
>   
>   	return true;
>   }
> -
> +#endif
>   /* Locks the rq it finds */
>   static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>   {
>   	struct task_struct *exec_ctx;
>   	struct rq *later_rq = NULL;
> +	bool retry;
>   	int tries;
>   	int cpu;
>   
>   	for (tries = 0; tries < DL_MAX_TRIES; tries++) {
> +		retry = false;
>   		exec_ctx = find_exec_ctx(rq, task);
>   		if (!exec_ctx)
>   			break;
> @@ -2228,7 +2299,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>   
>   		/* Retry if something changed. */
>   		if (double_lock_balance(rq, later_rq)) {
> -			if (unlikely(!dl_revalidate_rq_state(task, rq, later_rq))) {
> +			if (unlikely(!dl_revalidate_rq_state(task, rq, later_rq, &retry))) {
>   				double_unlock_balance(rq, later_rq);
>   				later_rq = NULL;
>   				break;
> @@ -2240,7 +2311,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>   		 * its earliest one has a later deadline than our
>   		 * task, the rq is a good one.
>   		 */
> -		if (dl_task_is_earliest_deadline(task, later_rq))
> +		if (!retry && dl_task_is_earliest_deadline(task, later_rq))
>   			break;
>   
>   		/* Otherwise we try again. */
> @@ -2251,25 +2322,6 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>   	return later_rq;
>   }
>   
> -static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
> -{
> -	struct task_struct *p;
> -
> -	if (!has_pushable_dl_tasks(rq))
> -		return NULL;
> -
> -	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
> -
> -	WARN_ON_ONCE(rq->cpu != task_cpu(p));
> -	WARN_ON_ONCE(task_current(rq, p));
> -	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> -
> -	WARN_ON_ONCE(!task_on_rq_queued(p));
> -	WARN_ON_ONCE(!dl_task(p));
> -
> -	return p;
> -}
> -
>   /*
>    * See if the non running -deadline tasks on this rq
>    * can be sent to some other CPU where they can preempt
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index fabb19891e95..d5ce95dc5c09 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1935,8 +1935,108 @@ static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exe
>   	return -1;
>   }
>   
> +static struct task_struct *pick_next_pushable_task(struct rq *rq)
> +{
> +	struct plist_head *head = &rq->rt.pushable_tasks;
> +	struct task_struct *p, *push_task = NULL;
> +
> +	if (!has_pushable_tasks(rq))
> +		return NULL;
> +
> +	plist_for_each_entry(p, head, pushable_tasks) {
> +		if (task_is_pushable(rq, p, 0)) {
> +			push_task = p;
> +			break;
> +		}
> +	}
> +
> +	if (!push_task)
> +		return NULL;
> +
> +	BUG_ON(rq->cpu != task_cpu(push_task));
> +	BUG_ON(task_current(rq, push_task) || task_current_selected(rq, push_task));
> +	BUG_ON(!task_on_rq_queued(push_task));
> +	BUG_ON(!rt_task(push_task));
> +
> +	return p;
> +}
> +
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +static inline bool rt_revalidate_rq_state(struct task_struct *task, struct rq *rq,
> +					  struct rq *lowest, bool *retry)

This function can be consolidated with dl_revalidate_rq_state() as you 
noted in the previous patch, although rt_revalidate_rq_state() has few 
comments.

> +{
> +	/*
> +	 * Releasing the rq lock means we need to re-check pushability.
> +	 * Some scenarios:
> +	 * 1) If a migration from another CPU sent a task/chain to rq
> +	 *    that made task newly unpushable by completing a chain
> +	 *    from task to rq->curr, then we need to bail out and push something
> +	 *    else.
> +	 * 2) If our chain led off this CPU or to a dequeued task, the last waiter
> +	 *    on this CPU might have acquired the lock and woken (or even migrated
> +	 *    & run, handed off the lock it held, etc...). This can invalidate the
> +	 *    result of find_lowest_rq() if our chain previously ended in a blocked
> +	 *    task whose affinity we could ignore, but now ends in an unblocked
> +	 *    task that can't run on lowest_rq.
> +	 * 3) Race described at https://lore.kernel.org/all/1523536384-26781-2-git-send-email-huawei.libin@huawei.com/
> +	 *
> +	 * Notes on these:
> +	 * - Scenario #2 is properly handled by rerunning find_lowest_rq
> +	 * - Scenario #1 requires that we fail
> +	 * - Scenario #3 can AFAICT only occur when rq is not this_rq(). And the
> +	 *   suggested fix is not universally correct now that push_cpu_stop() can
> +	 *   call this function.
> +	 */
> +	if (!rt_task(task) || is_migration_disabled(task)) {
> +		return false;
> +	} else if (rq != this_rq()) {

Nit: `else` can be dropped as in dl_revalidate_rq_state().

> +		/*
> +		 * If we are dealing with a remote rq, then all bets are off
> +		 * because task might have run & then been dequeued since we
> +		 * released the lock, at which point our normal checks can race
> +		 * with migration, as described in
> +		 * https://lore.kernel.org/all/1523536384-26781-2-git-send-email-huawei.libin@huawei.com/
> +		 * Need to repick to ensure we avoid a race.
> +		 * But re-picking would be unnecessary & incorrect in the
> +		 * push_cpu_stop() path.
> +		 */
> +		struct task_struct *next_task = pick_next_pushable_task(rq);
> +
> +		if (next_task == task) {
> +			struct task_struct *exec_ctx;
> +
> +			exec_ctx = find_exec_ctx(rq, next_task);
> +			*retry = (exec_ctx &&
> +				!cpumask_test_cpu(lowest->cpu,
> +						&exec_ctx->cpus_mask));
> +		} else {
> +			return false;
> +		}
> +	} else {
> +		/*
> +		 * Chain level balancing introduces new ways for our choice of
> +		 * task & rq to become invalid when we release the rq lock, e.g.:
> +		 * 1) Migration to rq from another CPU makes task newly unpushable
> +		 *    by completing a "blocked chain" from task to rq->curr.
> +		 *    Fail so a different task can be chosen for push.
> +		 * 2) In cases where task's blocked chain led to a dequeued task
> +		 *    or one on another rq, the last waiter in the chain on this
> +		 *    rq might have acquired the lock and woken, meaning we must
> +		 *    pick a different rq if its affinity prevents running on
> +		 *    lowest rq.
> +		 */
> +		int pushable = task_is_pushable(rq, task, lowest->cpu);
> +
> +		*retry = pushable == -1;
> +		if (!pushable)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +#else /* !CONFIG_SCHED_PROXY_EXEC */
>   static inline bool rt_revalidate_rq_state(struct task_struct *task, struct rq *rq,
> -					  struct rq *lowest)
> +					  struct rq *lowest, bool *retry)
>   {
>   	/*
>   	 * We had to unlock the run queue. In
> @@ -1967,16 +2067,19 @@ static inline bool rt_revalidate_rq_state(struct task_struct *task, struct rq *r
>   
>   	return true;
>   }
> +#endif
>   
>   /* Will lock the rq it finds */
>   static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>   {
>   	struct task_struct *exec_ctx;
>   	struct rq *lowest_rq = NULL;
> +	bool retry;
>   	int tries;
>   	int cpu;
>   
>   	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
> +		retry = false;
>   		exec_ctx = find_exec_ctx(rq, task);
>   		cpu = find_lowest_rq(task, exec_ctx);
>   
> @@ -1997,7 +2100,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>   
>   		/* if the prio of this runqueue changed, try again */
>   		if (double_lock_balance(rq, lowest_rq)) {
> -			if (unlikely(!rt_revalidate_rq_state(task, rq, lowest_rq))) {
> +			if (unlikely(!rt_revalidate_rq_state(task, rq, lowest_rq, &retry))) {
>   				double_unlock_balance(rq, lowest_rq);
>   				lowest_rq = NULL;
>   				break;
> @@ -2005,7 +2108,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>   		}
>   
>   		/* If this rq is still suitable use it. */
> -		if (lowest_rq->rt.highest_prio.curr > task->prio)
> +		if (lowest_rq->rt.highest_prio.curr > task->prio && !retry)
>   			break;
>   
>   		/* try again */
> @@ -2016,27 +2119,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>   	return lowest_rq;
>   }
>   
> -static struct task_struct *pick_next_pushable_task(struct rq *rq)
> -{
> -	struct task_struct *p;
> -
> -	if (!has_pushable_tasks(rq))
> -		return NULL;
> -
> -	p = plist_first_entry(&rq->rt.pushable_tasks,
> -			      struct task_struct, pushable_tasks);
> -
> -	BUG_ON(rq->cpu != task_cpu(p));
> -	BUG_ON(task_current(rq, p));
> -	BUG_ON(task_current_selected(rq, p));
> -	BUG_ON(p->nr_cpus_allowed <= 1);
> -
> -	BUG_ON(!task_on_rq_queued(p));
> -	BUG_ON(!rt_task(p));
> -
> -	return p;
> -}
> -
>   /*
>    * If the current CPU has more than one RT task, see if the non
>    * running task can migrate over to a CPU that is running a task
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6cd473224cfe..4b97b36be691 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3548,7 +3548,7 @@ extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
>   extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
>   #ifdef CONFIG_SMP
>   static inline
> -void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
> +void __push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
>   {
>   	deactivate_task(rq, task, 0);
>   	set_task_cpu(task, dst_rq->cpu);
> @@ -3556,7 +3556,7 @@ void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
>   }
>   
>   static inline
> -int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
> +int __task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
>   {
>   	if (!task_on_cpu(rq, p) &&
>   	    cpumask_test_cpu(cpu, &p->cpus_mask))
> @@ -3566,8 +3566,22 @@ int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
>   }
>   
>   #ifdef CONFIG_SCHED_PROXY_EXEC
> +void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task);
> +int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu);
>   struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p);
>   #else /* !CONFIG_SCHED_PROXY_EXEC */
> +static inline
> +void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
> +{
> +	__push_task_chain(rq, dst_rq, task);
> +}
> +
> +static inline
> +int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
> +{
> +	return __task_is_pushable(rq, p, cpu);
> +}
> +
>   static inline
>   struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
>   {


