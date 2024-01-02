Return-Path: <linux-kernel+bounces-14563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF0821EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D721C22473
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B214F73;
	Tue,  2 Jan 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZH/Gui+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321214F61
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704209646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvMCPCl96wpCgTTinZrQ9Iqd/7nUVVvlZXAnpcjnN8I=;
	b=IZH/Gui+f8i7hxtAwGzo71Cp415dk5o+8zzBTLMDYNQr/VpTCUsJdxmpwSG3DjZgPetO7d
	C3uWe9Xi3Ue0AZ/Rb66Ks3g4loOYkMrnXRYl5NQDhIltCKuH/RgqmCOhQovO2iHhRK/MWq
	+odC4GkT2eS71W59Jl6LxbA7kxl6cfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-UUjKVEEDMQ65U8IqTUEX8g-1; Tue, 02 Jan 2024 10:34:03 -0500
X-MC-Unique: UUjKVEEDMQ65U8IqTUEX8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25E618A7A03;
	Tue,  2 Jan 2024 15:34:02 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.194.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E6BC73C2E;
	Tue,  2 Jan 2024 15:33:53 +0000 (UTC)
Date: Tue, 2 Jan 2024 10:33:49 -0500
From: Phil Auld <pauld@redhat.com>
To: Metin Kaya <metin.kaya@arm.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: Re: [PATCH v7 14/23] sched: Handle blocked-waiter migration (and
 return migration)
Message-ID: <20240102153349.GA66858@lorien.usersys.redhat.com>
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-15-jstultz@google.com>
 <534c73b2-c28c-4e2a-9e6b-a5002c72afe8@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534c73b2-c28c-4e2a-9e6b-a5002c72afe8@arm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Dec 21, 2023 at 04:12:57PM +0000 Metin Kaya wrote:
> On 20/12/2023 12:18 am, John Stultz wrote:
> > Add logic to handle migrating a blocked waiter to a remote
> > cpu where the lock owner is runnable.
> > 
> > Additionally, as the blocked task may not be able to run
> > on the remote cpu, add logic to handle return migration once
> > the waiting task is given the mutex.
> > 
> > Because tasks may get migrated to where they cannot run,
> > this patch also modifies the scheduling classes to avoid
> > sched class migrations on mutex blocked tasks, leaving
> > proxy() to do the migrations and return migrations.
> 
> s/proxy/find_proxy_task/
>

While fixing that paragraph, probably:

s/this patch also modifies/also modify/


Cheers,
Phil

> > 
> > This was split out from the larger proxy patch, and
> > significantly reworked.
> > 
> > Credits for the original patch go to:
> >    Peter Zijlstra (Intel) <peterz@infradead.org>
> >    Juri Lelli <juri.lelli@redhat.com>
> >    Valentin Schneider <valentin.schneider@arm.com>
> >    Connor O'Brien <connoro@google.com>
> > 
> > Cc: Joel Fernandes <joelaf@google.com>
> > Cc: Qais Yousef <qyousef@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Zimuzo Ezeozue <zezeozue@google.com>
> > Cc: Youssef Esmat <youssefesmat@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Metin Kaya <Metin.Kaya@arm.com>
> > Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> > Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: kernel-team@android.com
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> > v6:
> > * Integrated sched_proxy_exec() check in proxy_return_migration()
> > * Minor cleanups to diff
> > * Unpin the rq before calling __balance_callbacks()
> > * Tweak proxy migrate to migrate deeper task in chain, to avoid
> >    tasks pingponging between rqs
> > v7:
> > * Fixup for unused function arguments
> > * Switch from that_rq -> target_rq, other minor tweaks, and typo
> >    fixes suggested by Metin Kaya
> > * Switch back to doing return migration in the ttwu path, which
> >    avoids nasty lock juggling and performance issues
> > * Fixes for UP builds
> > ---
> >   kernel/sched/core.c     | 161 ++++++++++++++++++++++++++++++++++++++--
> >   kernel/sched/deadline.c |   2 +-
> >   kernel/sched/fair.c     |   4 +-
> >   kernel/sched/rt.c       |   9 ++-
> >   4 files changed, 164 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 42e25bbdfe6b..55dc2a3b7e46 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2981,8 +2981,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
> >   	struct set_affinity_pending my_pending = { }, *pending = NULL;
> >   	bool stop_pending, complete = false;
> > -	/* Can the task run on the task's current CPU? If so, we're done */
> > -	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
> > +	/*
> > +	 * Can the task run on the task's current CPU? If so, we're done
> > +	 *
> > +	 * We are also done if the task is selected, boosting a lock-
> > +	 * holding proxy, (and potentially has been migrated outside its
> > +	 * current or previous affinity mask)
> > +	 */
> > +	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
> > +	    (task_current_selected(rq, p) && !task_current(rq, p))) {
> >   		struct task_struct *push_task = NULL;
> >   		if ((flags & SCA_MIGRATE_ENABLE) &&
> > @@ -3778,6 +3785,39 @@ static inline void ttwu_do_wakeup(struct task_struct *p)
> >   	trace_sched_wakeup(p);
> >   }
> > +#ifdef CONFIG_SMP
> > +static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
> > +{
> > +	if (!sched_proxy_exec())
> > +		return false;
> > +
> > +	if (task_current(rq, p))
> > +		return false;
> > +
> > +	if (p->blocked_on && p->blocked_on_state == BO_WAKING) {
> > +		raw_spin_lock(&p->blocked_lock);
> > +		if (!is_cpu_allowed(p, cpu_of(rq))) {
> > +			if (task_current_selected(rq, p)) {
> > +				put_prev_task(rq, p);
> > +				rq_set_selected(rq, rq->idle);
> > +			}
> > +			deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
> > +			resched_curr(rq);
> > +			raw_spin_unlock(&p->blocked_lock);
> > +			return true;
> > +		}
> > +		resched_curr(rq);
> > +		raw_spin_unlock(&p->blocked_lock);
> 
> Do we need to hold blocked_lock while checking allowed CPUs? Would moving
> raw_spin_lock(&p->blocked_lock); inside if (!is_cpu_allowed()) block be
> silly? i.e.,:
> 
> 		if (!is_cpu_allowed(p, cpu_of(rq))) {
> 			raw_spin_lock(&p->blocked_lock);
> 			if (task_current_selected(rq, p)) {
> 				put_prev_task(rq, p);
> 				rq_set_selected(rq, rq->idle);
> 			}
> 			deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
> 			resched_curr(rq);
> 			raw_spin_unlock(&p->blocked_lock);
> 			return true;
> 		}
> 		resched_curr(rq);
> 
> > +	}
> > +	return false;
> > +}
> > +#else /* !CONFIG_SMP */
> > +static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
> > +{
> > +	return false;
> > +}
> > +#endif /*CONFIG_SMP */
> 
> Nit: what about this?
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 30dfb6f14f2b..60b542a6faa5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4027,9 +4027,11 @@ static inline void activate_blocked_entities(struct
> rq *target_rq,
>  }
>  #endif /* CONFIG_SCHED_PROXY_EXEC */
> 
> -#ifdef CONFIG_SMP
>  static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
>  {
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		return false;
> +
>  	if (!sched_proxy_exec())
>  		return false;
> 
> @@ -4053,12 +4055,6 @@ static inline bool proxy_needs_return(struct rq *rq,
> struct task_struct *p)
>  	}
>  	return false;
>  }
> -#else /* !CONFIG_SMP */
> -static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
> -{
> -	return false;
> -}
> -#endif /*CONFIG_SMP */
> 
>  static void
>  ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
> 
> > +
> >   static void
> >   ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
> >   		 struct rq_flags *rf)
> > @@ -3870,9 +3910,12 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
> >   			update_rq_clock(rq);
> >   			wakeup_preempt(rq, p, wake_flags);
> >   		}
> > +		if (proxy_needs_return(rq, p))
> > +			goto out;
> >   		ttwu_do_wakeup(p);
> >   		ret = 1;
> >   	}
> > +out:
> >   	__task_rq_unlock(rq, &rf);
> >   	return ret;
> > @@ -4231,6 +4274,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >   	int cpu, success = 0;
> >   	if (p == current) {
> > +		WARN_ON(task_is_blocked(p));
> >   		/*
> >   		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
> >   		 * == smp_processor_id()'. Together this means we can special
> > @@ -6632,6 +6676,91 @@ static bool proxy_deactivate(struct rq *rq, struct task_struct *next)
> >   	return true;
> >   }
> > +#ifdef CONFIG_SMP
> > +/*
> > + * If the blocked-on relationship crosses CPUs, migrate @p to the
> > + * owner's CPU.
> > + *
> > + * This is because we must respect the CPU affinity of execution
> > + * contexts (owner) but we can ignore affinity for scheduling
> > + * contexts (@p). So we have to move scheduling contexts towards
> > + * potential execution contexts.
> > + *
> > + * Note: The owner can disappear, but simply migrate to @target_cpu
> > + * and leave that CPU to sort things out.
> > + */
> > +static struct task_struct *
> 
> proxy_migrate_task() always returns NULL. Is return type really needed?
> 
> > +proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
> > +		   struct task_struct *p, int target_cpu)
> > +{
> > +	struct rq *target_rq;
> > +	int wake_cpu;
> > +
> 
> Having a "if (!IS_ENABLED(CONFIG_SMP))" check here would help in dropping
> #else part. i.e.,
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 30dfb6f14f2b..685ba6f2d4cd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6912,7 +6912,6 @@ proxy_resched_idle(struct rq *rq, struct task_struct
> *next)
>  	return rq->idle;
>  }
> 
> -#ifdef CONFIG_SMP
>  /*
>   * If the blocked-on relationship crosses CPUs, migrate @p to the
>   * owner's CPU.
> @@ -6932,6 +6931,9 @@ proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
>  	struct rq *target_rq;
>  	int wake_cpu;
> 
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		return NULL;
> +
>  	lockdep_assert_rq_held(rq);
>  	target_rq = cpu_rq(target_cpu);
> 
> @@ -6988,14 +6990,6 @@ proxy_migrate_task(struct rq *rq, struct rq_flags
> *rf,
> 
>  	return NULL; /* Retry task selection on _this_ CPU. */
>  }
> -#else /* !CONFIG_SMP */
> -static struct task_struct *
> -proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
> -		   struct task_struct *p, int target_cpu)
> -{
> -	return NULL;
> -}
> -#endif /* CONFIG_SMP */
> 
>  static void proxy_enqueue_on_owner(struct rq *rq, struct task_struct
> *owner,
>  				   struct task_struct *next)
> 
> > +	lockdep_assert_rq_held(rq);
> > +	target_rq = cpu_rq(target_cpu);
> > +
> > +	/*
> > +	 * Since we're going to drop @rq, we have to put(@rq_selected) first,
> > +	 * otherwise we have a reference that no longer belongs to us. Use
> > +	 * @rq->idle to fill the void and make the next pick_next_task()
> > +	 * invocation happy.
> > +	 *
> > +	 * CPU0				CPU1
> > +	 *
> > +	 *				B mutex_lock(X)
> > +	 *
> > +	 * A mutex_lock(X) <- B
> > +	 * A __schedule()
> > +	 * A pick->A
> > +	 * A proxy->B
> > +	 * A migrate A to CPU1
> > +	 *				B mutex_unlock(X) -> A
> > +	 *				B __schedule()
> > +	 *				B pick->A
> > +	 *				B switch_to (A)
> > +	 *				A ... does stuff
> > +	 * A ... is still running here
> > +	 *
> > +	 *		* BOOM *
> > +	 */
> > +	put_prev_task(rq, rq_selected(rq));
> > +	rq_set_selected(rq, rq->idle);
> > +	set_next_task(rq, rq_selected(rq));
> > +	WARN_ON(p == rq->curr);
> > +
> > +	wake_cpu = p->wake_cpu;
> > +	deactivate_task(rq, p, 0);
> > +	set_task_cpu(p, target_cpu);
> > +	/*
> > +	 * Preserve p->wake_cpu, such that we can tell where it
> > +	 * used to run later.
> > +	 */
> > +	p->wake_cpu = wake_cpu;
> > +
> > +	rq_unpin_lock(rq, rf);
> > +	__balance_callbacks(rq);
> > +
> > +	raw_spin_rq_unlock(rq);
> > +	raw_spin_rq_lock(target_rq);
> > +
> > +	activate_task(target_rq, p, 0);
> > +	wakeup_preempt(target_rq, p, 0);
> > +
> > +	raw_spin_rq_unlock(target_rq);
> > +	raw_spin_rq_lock(rq);
> > +	rq_repin_lock(rq, rf);
> > +
> > +	return NULL; /* Retry task selection on _this_ CPU. */
> > +}
> > +#else /* !CONFIG_SMP */
> > +static struct task_struct *
> > +proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
> > +		   struct task_struct *p, int target_cpu)
> > +{
> > +	return NULL;
> > +}
> > +#endif /* CONFIG_SMP */ > +
> >   /*
> >    * Find who @next (currently blocked on a mutex) can proxy for.
> >    *
> > @@ -6654,8 +6783,11 @@ find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> >   	struct task_struct *owner = NULL;
> >   	struct task_struct *ret = NULL;
> >   	struct task_struct *p;
> > +	int cur_cpu, target_cpu;
> >   	struct mutex *mutex;
> > -	int this_cpu = cpu_of(rq);
> > +	bool curr_in_chain = false;
> > +
> > +	cur_cpu = cpu_of(rq);
> >   	/*
> >   	 * Follow blocked_on chain.
> > @@ -6686,17 +6818,27 @@ find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> >   			goto out;
> >   		}
> > +		if (task_current(rq, p))
> > +			curr_in_chain = true;
> > +
> >   		owner = __mutex_owner(mutex);
> >   		if (!owner) {
> >   			ret = p;
> >   			goto out;
> >   		}
> > -		if (task_cpu(owner) != this_cpu) {
> > -			/* XXX Don't handle migrations yet */
> > -			if (!proxy_deactivate(rq, next))
> > -				ret = next;
> > -			goto out;
> > +		if (task_cpu(owner) != cur_cpu) {
> > +			target_cpu = task_cpu(owner);
> > +			/*
> > +			 * @owner can disappear, simply migrate to @target_cpu and leave that CPU
> > +			 * to sort things out.
> > +			 */
> > +			raw_spin_unlock(&p->blocked_lock);
> > +			raw_spin_unlock(&mutex->wait_lock);
> > +			if (curr_in_chain)
> > +				return proxy_resched_idle(rq, next);
> > +
> > +			return proxy_migrate_task(rq, rf, p, target_cpu);
> >   		}
> >   		if (task_on_rq_migrating(owner)) {
> > @@ -6999,6 +7141,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
> >   	 */
> >   	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
> > +	if (task_is_blocked(tsk))
> > +		return;
> > +
> >   	/*
> >   	 * If we are going to sleep and we have plugged IO queued,
> >   	 * make sure to submit it to avoid deadlocks.
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 9cf20f4ac5f9..4f998549ea74 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1705,7 +1705,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
> >   	enqueue_dl_entity(&p->dl, flags);
> > -	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> > +	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 && !task_is_blocked(p))
> >   		enqueue_pushable_dl_task(rq, p);
> >   }
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 954b41e5b7df..8e3f118f6d6e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8372,7 +8372,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
> >   		goto idle;
> >   #ifdef CONFIG_FAIR_GROUP_SCHED
> > -	if (!prev || prev->sched_class != &fair_sched_class)
> > +	if (!prev ||
> > +	    prev->sched_class != &fair_sched_class ||
> > +	    rq->curr != rq_selected(rq))
> >   		goto simple;
> >   	/*
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 81cd22eaa6dc..a7b51a021111 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1503,6 +1503,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
> >   	if (p->nr_cpus_allowed == 1)
> >   		return;
> > +	if (task_is_blocked(p))
> > +		return;
> > +
> >   	enqueue_pushable_task(rq, p);
> >   }
> > @@ -1790,10 +1793,12 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
> >   	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
> > -	/* Avoid marking selected as pushable */
> > -	if (task_current_selected(rq, p))
> > +	/* Avoid marking current or selected as pushable */
> > +	if (task_current(rq, p) || task_current_selected(rq, p))
> >   		return;
> > +	if (task_is_blocked(p))
> > +		return;
> >   	/*
> >   	 * The previous task needs to be made eligible for pushing
> >   	 * if it is still active
> 
> 

-- 


