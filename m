Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7B78E46E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHaBex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjHaBev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:34:51 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C892CDD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:34:39 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-41205469f4eso1278131cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693445678; x=1694050478;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ycVucuHicSZGEnZTAPWyL52dXoSy//AnKkfpuHUU/k=;
        b=i/mtlhpZYpVWsb4byTCUob/V6udPZcnKoBVfRgIhsJa38Nyam9K5i4Bhgb3WO3TYzu
         AhG29MZUvPSWbX6bTXyIy8c1vnr33qqhCBrb787Opf4e4g7cXxNNswLm6VVZcuvTqxuM
         lsUNMlx7ERJFuFtNEbY5ggR9IgviAg9CmAVn4587r4doR4Wx7jsUg8YeQcILR99us9bP
         ezCP9SCaJBK+4oT8MNW5fgqrw8LyrZduC0YPT4XwFj/kwDGZHC6XpXRHePTk8VxuYj2L
         iNEPl2F8MZiQB7a2nfM30gW82L0/DYMsiytzFjxv/cHWRBJNlz2bwQATQvQ4i2sjTlJ+
         ziTA==
X-Gm-Message-State: AOJu0YzIb16QCmk018vY9uRvST7ypGKYGFJIkt5iExoXPzb0hwEEQHv/
        piRcYj3d2ruNzCe9C1GS09Q=
X-Google-Smtp-Source: AGHT+IFL7AER4os0VrqnlZaujpKVLD++B7iHzTSqCfsu1pTwN2fXSfPJTawatpTRawfVb0Dfwc5eqA==
X-Received: by 2002:ac8:7ef2:0:b0:3fd:ed14:6eb9 with SMTP id r18-20020ac87ef2000000b003fded146eb9mr1458975qtc.11.1693445678456;
        Wed, 30 Aug 2023 18:34:38 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1c30])
        by smtp.gmail.com with ESMTPSA id fp17-20020a05622a509100b0041087c90049sm140950qtb.52.2023.08.30.18.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 18:34:37 -0700 (PDT)
Date:   Wed, 30 Aug 2023 20:34:35 -0500
From:   David Vernet <void@manifault.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [PATCH v3 6/7] sched: Implement shared runqueue in CFS
Message-ID: <20230831013435.GB506447@maniforge>
References: <20230809221218.163894-1-void@manifault.com>
 <20230809221218.163894-7-void@manifault.com>
 <3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        LOTS_OF_MONEY,MONEY_NOHTML,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:16:17PM +0530, K Prateek Nayak wrote:
> Hello David,

Hello Prateek,

> 
> On 8/10/2023 3:42 AM, David Vernet wrote:
> > [..snip..]
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 2aab7be46f7e..8238069fd852 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -769,6 +769,8 @@ struct task_struct {
> >  	unsigned long			wakee_flip_decay_ts;
> >  	struct task_struct		*last_wakee;
> >  
> > +	struct list_head		shared_runq_node;
> > +
> >  	/*
> >  	 * recent_used_cpu is initially set as the last CPU used by a task
> >  	 * that wakes affine another task. Waker/wakee relationships can
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 385c565da87f..fb7e71d3dc0a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4529,6 +4529,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >  #ifdef CONFIG_SMP
> >  	p->wake_entry.u_flags = CSD_TYPE_TTWU;
> >  	p->migration_pending = NULL;
> > +	INIT_LIST_HEAD(&p->shared_runq_node);
> >  #endif
> >  	init_sched_mm_cid(p);
> >  }
> > @@ -9764,6 +9765,18 @@ int sched_cpu_deactivate(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > +void sched_update_domains(void)
> > +{
> > +	const struct sched_class *class;
> > +
> > +	update_sched_domain_debugfs();
> > +
> > +	for_each_class(class) {
> > +		if (class->update_domains)
> > +			class->update_domains();
> > +	}
> > +}
> > +
> >  static void sched_rq_cpu_starting(unsigned int cpu)
> >  {
> >  	struct rq *rq = cpu_rq(cpu);
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9c23e3b948fc..6e740f8da578 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -139,20 +139,235 @@ static int __init setup_sched_thermal_decay_shift(char *str)
> >  }
> >  __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
> >  
> > +/**
> > + * struct shared_runq - Per-LLC queue structure for enqueuing and migrating
> > + * runnable tasks within an LLC.
> > + *
> > + * WHAT
> > + * ====
> > + *
> > + * This structure enables the scheduler to be more aggressively work
> > + * conserving, by placing waking tasks on a per-LLC FIFO queue that can then be
> > + * pulled from when another core in the LLC is going to go idle.
> > + *
> > + * struct rq stores a pointer to its LLC's shared_runq via struct cfs_rq.
> > + * Waking tasks are enqueued in the calling CPU's struct shared_runq in
> > + * __enqueue_entity(), and are opportunistically pulled from the shared_runq
> > + * in newidle_balance(). Tasks enqueued in a shared_runq may be scheduled prior
> > + * to being pulled from the shared_runq, in which case they're simply dequeued
> > + * from the shared_runq in __dequeue_entity().
> > + *
> > + * There is currently no task-stealing between shared_runqs in different LLCs,
> > + * which means that shared_runq is not fully work conserving. This could be
> > + * added at a later time, with tasks likely only being stolen across
> > + * shared_runqs on the same NUMA node to avoid violating NUMA affinities.
> > + *
> > + * HOW
> > + * ===
> > + *
> > + * A shared_runq is comprised of a list, and a spinlock for synchronization.
> > + * Given that the critical section for a shared_runq is typically a fast list
> > + * operation, and that the shared_runq is localized to a single LLC, the
> > + * spinlock will typically only be contended on workloads that do little else
> > + * other than hammer the runqueue.
> > + *
> > + * WHY
> > + * ===
> > + *
> > + * As mentioned above, the main benefit of shared_runq is that it enables more
> > + * aggressive work conservation in the scheduler. This can benefit workloads
> > + * that benefit more from CPU utilization than from L1/L2 cache locality.
> > + *
> > + * shared_runqs are segmented across LLCs both to avoid contention on the
> > + * shared_runq spinlock by minimizing the number of CPUs that could contend on
> > + * it, as well as to strike a balance between work conservation, and L3 cache
> > + * locality.
> > + */
> > +struct shared_runq {
> > +	struct list_head list;
> > +	raw_spinlock_t lock;
> > +} ____cacheline_aligned;
> > +
> >  #ifdef CONFIG_SMP
> > +
> > +static DEFINE_PER_CPU(struct shared_runq, shared_runqs);
> > +
> > +static struct shared_runq *rq_shared_runq(struct rq *rq)
> > +{
> > +	return rq->cfs.shared_runq;
> > +}
> > +
> > +static void shared_runq_reassign_domains(void)
> > +{
> > +	int i;
> > +	struct shared_runq *shared_runq;
> > +	struct rq *rq;
> > +	struct rq_flags rf;
> > +
> > +	for_each_possible_cpu(i) {
> > +		rq = cpu_rq(i);
> > +		shared_runq = &per_cpu(shared_runqs, per_cpu(sd_llc_id, i));
> > +
> > +		rq_lock(rq, &rf);
> > +		rq->cfs.shared_runq = shared_runq;
> > +		rq_unlock(rq, &rf);
> > +	}
> > +}
> > +
> > +static void __shared_runq_drain(struct shared_runq *shared_runq)
> > +{
> > +	struct task_struct *p, *tmp;
> > +
> > +	raw_spin_lock(&shared_runq->lock);
> > +	list_for_each_entry_safe(p, tmp, &shared_runq->list, shared_runq_node)
> > +		list_del_init(&p->shared_runq_node);
> > +	raw_spin_unlock(&shared_runq->lock);
> > +}
> > +
> > +static void update_domains_fair(void)
> > +{
> > +	int i;
> > +	struct shared_runq *shared_runq;
> > +
> > +	/* Avoid racing with SHARED_RUNQ enable / disable. */
> > +	lockdep_assert_cpus_held();
> > +
> > +	shared_runq_reassign_domains();
> > +
> > +	/* Ensure every core sees its updated shared_runq pointers. */
> > +	synchronize_rcu();
> > +
> > +	/*
> > +	 * Drain all tasks from all shared_runq's to ensure there are no stale
> > +	 * tasks in any prior domain runq. This can cause us to drain live
> > +	 * tasks that would otherwise have been safe to schedule, but this
> > +	 * isn't a practical problem given how infrequently domains are
> > +	 * rebuilt.
> > +	 */
> > +	for_each_possible_cpu(i) {
> > +		shared_runq = &per_cpu(shared_runqs, i);
> > +		__shared_runq_drain(shared_runq);
> > +	}
> > +}
> > +
> >  void shared_runq_toggle(bool enabling)
> > -{}
> > +{
> > +	int cpu;
> > +
> > +	if (enabling)
> > +		return;
> > +
> > +	/* Avoid racing with hotplug. */
> > +	lockdep_assert_cpus_held();
> > +
> > +	/* Ensure all cores have stopped enqueueing / dequeuing tasks. */
> > +	synchronize_rcu();
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		int sd_id;
> > +
> > +		sd_id = per_cpu(sd_llc_id, cpu);
> > +		if (cpu == sd_id)
> > +			__shared_runq_drain(rq_shared_runq(cpu_rq(cpu)));
> > +	}
> > +}
> > +
> > +static struct task_struct *shared_runq_pop_task(struct rq *rq)
> > +{
> > +	struct task_struct *p;
> > +	struct shared_runq *shared_runq;
> > +
> > +	shared_runq = rq_shared_runq(rq);
> > +	if (list_empty(&shared_runq->list))
> > +		return NULL;
> > +
> > +	raw_spin_lock(&shared_runq->lock);
> > +	p = list_first_entry_or_null(&shared_runq->list, struct task_struct,
> > +				     shared_runq_node);
> > +	if (p && is_cpu_allowed(p, cpu_of(rq)))
> > +		list_del_init(&p->shared_runq_node);
> 
> I wonder if we should remove the task from the list if
> "is_cpu_allowed()" return false.
> 
> Consider the following scenario: A task that does not sleep, is pinned
> to single CPU. Since this is now at the head of the list, and cannot be
> moved, we leave it there, but since the task also never sleeps, it'll
> stay there, thus preventing the queue from doing its job.

Hmm, sorry, I may not be understanding your suggestion. If a task was
pinned to a single CPU, it would be dequeued from the shared_runq before
being pinned (see __set_cpus_allowed_ptr_locked()), and then would not
be added back to the shard in shared_runq_enqueue_task() because of
p->nr_cpus_allowed == 1. The task would also be dequeued from the shard
before it started running (unless I'm misunderstanding what you mean by
"a task that does not sleep"). Please let me know if I'm missing
something.

> Further implication ...  
> 
> > +	else
> > +		p = NULL;
> > +	raw_spin_unlock(&shared_runq->lock);
> > +
> > +	return p;
> > +}
> > +
> > +static void shared_runq_push_task(struct rq *rq, struct task_struct *p)
> > +{
> > +	struct shared_runq *shared_runq;
> > +
> > +	shared_runq = rq_shared_runq(rq);
> > +	raw_spin_lock(&shared_runq->lock);
> > +	list_add_tail(&p->shared_runq_node, &shared_runq->list);
> > +	raw_spin_unlock(&shared_runq->lock);
> > +}
> >  
> >  static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
> > -{}
> > +{
> > +	/*
> > +	 * Only enqueue the task in the shared runqueue if:
> > +	 *
> > +	 * - SHARED_RUNQ is enabled
> > +	 * - The task isn't pinned to a specific CPU
> > +	 */
> > +	if (p->nr_cpus_allowed == 1)
> > +		return;
> > +
> > +	shared_runq_push_task(rq, p);
> > +}
> >  
> >  static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
> >  {
> > -	return 0;
> > +	struct task_struct *p = NULL;
> > +	struct rq *src_rq;
> > +	struct rq_flags src_rf;
> > +	int ret = -1;
> > +
> > +	p = shared_runq_pop_task(rq);
> > +	if (!p)
> > +		return 0;
> 
> ...
> 
> Since we return 0 here in such a scenario, we'll take the old
> newidle_balance() path but ...
> 
> > +
> > +	rq_unpin_lock(rq, rf);
> > +	raw_spin_rq_unlock(rq);
> > +
> > +	src_rq = task_rq_lock(p, &src_rf);
> > +
> > +	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {
> > +		update_rq_clock(src_rq);
> > +		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
> > +		ret = 1;
> > +	}
> > +
> > +	if (src_rq != rq) {
> > +		task_rq_unlock(src_rq, p, &src_rf);
> > +		raw_spin_rq_lock(rq);
> > +	} else {
> > +		rq_unpin_lock(rq, &src_rf);
> > +		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
> > +	}
> > +	rq_repin_lock(rq, rf);
> > +
> > +	return ret;
> >  }
> >  
> >  static void shared_runq_dequeue_task(struct task_struct *p)
> > -{}
> > +{
> > +	struct shared_runq *shared_runq;
> > +
> > +	if (!list_empty(&p->shared_runq_node)) {
> > +		shared_runq = rq_shared_runq(task_rq(p));
> > +		raw_spin_lock(&shared_runq->lock);
> > +		/*
> > +		 * Need to double-check for the list being empty to avoid
> > +		 * racing with the list being drained on the domain recreation
> > +		 * or SHARED_RUNQ feature enable / disable path.
> > +		 */
> > +		if (likely(!list_empty(&p->shared_runq_node)))
> > +			list_del_init(&p->shared_runq_node);
> > +		raw_spin_unlock(&shared_runq->lock);
> > +	}
> > +}
> >  
> >  /*
> >   * For asym packing, by default the lower numbered CPU has higher priority.
> > @@ -12093,6 +12308,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >  	rcu_read_lock();
> >  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> >  
> > +	/*
> > +	 * Skip <= LLC domains as they likely won't have any tasks if the
> > +	 * shared runq is empty.
> > +	 */
> 
> ... now we skip all the way ahead of MC domain, overlooking any
> imbalance that might still exist within the SMT and MC groups
> since shared runq is not exactly empty.
> 
> Let me know if I've got something wrong!

Yep, I mentioned this to Gautham as well in [0].

[0]: https://lore.kernel.org/all/20230818050355.GA5718@maniforge/

I agree that I think we should remove this heuristic from v4. Either
that, or add logic to iterate over the shared_runq until a viable task
is found.

> 
> > +	if (sched_feat(SHARED_RUNQ)) {
> > +		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> > +		if (likely(sd))
> > +			sd = sd->parent;
> > +	}
> 
> Speaking of skipping ahead of MC domain, I don't think this actually
> works since the domain traversal uses the "for_each_domain" macro
> which is defined as:

*blinks*

Uhhh, yeah, wow. Good catch!

> #define for_each_domain(cpu, __sd) \
> 	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
> 			__sd; __sd = __sd->parent)
> 
> The traversal starts from rq->sd overwriting your initialized value
> here. This is why we see "load_balance count on cpu newly idle" in
> Gautham's first report
> (https://lore.kernel.org/lkml/ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com/)
> to be non-zero.
>
> One way to do this would be as follows:
> 
> static int newidle_balance() {
> 
> 	...
> 	for_each_domain(this_cpu, sd) {
> 
> 		...
> 		/* Skip balancing until LLc domain */
> 		if (sched_feat(SHARED_RUNQ) &&
> 		    (sd->flags & SD_SHARE_PKG_RESOURCES))
> 			continue;
> 
> 		...
> 	}
> 	...
> }

Yep, I think this makes sense to do.

> With this I see the newidle balance count for SMT and MC domain
> to be zero:

And indeed, I think this was the intention. Thanks again for catching
this. I'm excited to try this out when running benchmarks for v4.

> < ----------------------------------------  Category:  newidle (SMT)  ---------------------------------------- >
> load_balance cnt on cpu newly idle                         :          0    $      0.000 $    [    0.00000 ]
> --
> < ----------------------------------------  Category:  newidle (MC)   ---------------------------------------- >
> load_balance cnt on cpu newly idle                         :          0    $      0.000 $    [    0.00000 ]
> --
> < ----------------------------------------  Category:  newidle (DIE)  ---------------------------------------- >
> load_balance cnt on cpu newly idle                         :       2170    $      9.319 $    [   17.42832 ]
> --
> < ----------------------------------------  Category:  newidle (NUMA) ---------------------------------------- >
> load_balance cnt on cpu newly idle                         :         30    $    674.067 $    [    0.24094 ]
> --
> 
> Let me know if I'm missing something here :)

No, I think you're correct, we should be doing this. Assuming we want to
keep this heuristic, I think the block above is also correct so that we
properly account sd->max_newidle_lb_cost and rq->next_balance. Does that
make sense to you too?

> 
> Note: The lb counts for DIE and NUMA are down since I'm experimenting
> with the implementation currently. I'll update of any new findings on
> the thread.

Ack, thank you for doing that.

Just FYI, I'll be on vacation for about 1.5 weeks starting tomorrow
afternoon. If I'm slow to respond, that's why.

Thanks,
David
