Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E145F75137A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjGLWRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjGLWRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:17:21 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB511FE4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:17:02 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-40292285362so858211cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689200221; x=1691792221;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/Xv2apMfa6m8F+1/kXfhmuiQkDcgshUcqNdJeVSfv8=;
        b=ctoNxSlnuMeAlmW0du/Oboz9TQ2C4vEHXwqU8cMR6Jnu4lMkWQXZs873YK12MAGps2
         gE9ufMfhSDxECroz3QTKpitQ8svWbRSA3SK2vp6URW/D5jniTlMfRBGzf17XDL57WG2F
         oFXoSw294rdyQkiddhohBuU8YQ15UeOT2xodDGztK74hzJnN/6cjRmZMauUCEFG24pXs
         k/PF3SGWbNTM1h8Fm4tk5MB2t9vJ19deobUPrFLIZwM5MUYbZSYbLSiSL9/vHMECu+A3
         Fa5ifm0Z2pCAaLBoL+CbviAhmC5Ue7Zn7n8iSavQrz61o8dFootXrx6OwlriDlx3pRSV
         Qc+g==
X-Gm-Message-State: ABy/qLa5q6NjT818jDIgufa6sL6hsRHq3OQAHtSUb6CYJlLl/JmoUEgr
        eETUcx7oHfa9JqWIzNbZDgc=
X-Google-Smtp-Source: APBJJlETXtC9x+ZkMcT926GyJA66qoQEbqq8RVD8Z9jYh/Xj8lDa8zeJmPtvHJyyjDjPEq6NE9Nz7w==
X-Received: by 2002:ac8:5ccf:0:b0:403:b02b:d4ed with SMTP id s15-20020ac85ccf000000b00403b02bd4edmr10064455qta.66.1689200220694;
        Wed, 12 Jul 2023 15:17:00 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f10-20020ac8068a000000b004036ec58b11sm2567949qth.84.2023.07.12.15.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:17:00 -0700 (PDT)
Date:   Wed, 12 Jul 2023 17:16:57 -0500
From:   David Vernet <void@manifault.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Message-ID: <20230712221657.GF12207@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
 <93260dd9-818a-7f98-e030-635e0dc8cad8@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93260dd9-818a-7f98-e030-635e0dc8cad8@bytedance.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 06:47:26PM +0800, Abel Wu wrote:
> Hi David, interesting patch!

Hi Abel,

Thanks for the helpful review!

> On 7/11/23 4:03 AM, David Vernet wrote:
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 1292d38d66cc..5c05a3da3d50 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -770,6 +770,8 @@ struct task_struct {
> >   	unsigned long			wakee_flip_decay_ts;
> >   	struct task_struct		*last_wakee;
> > +	struct list_head		shared_runq_node;
> > +
> >   	/*
> >   	 * recent_used_cpu is initially set as the last CPU used by a task
> >   	 * that wakes affine another task. Waker/wakee relationships can
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1451f5aa82ac..3ad437d4ea3d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4503,6 +4503,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >   #ifdef CONFIG_SMP
> >   	p->wake_entry.u_flags = CSD_TYPE_TTWU;
> >   	p->migration_pending = NULL;
> > +	INIT_LIST_HEAD(&p->shared_runq_node);
> >   #endif
> >   	init_sched_mm_cid(p);
> >   }
> > @@ -9842,6 +9843,7 @@ void __init sched_init_smp(void)
> >   	init_sched_rt_class();
> >   	init_sched_dl_class();
> > +	init_sched_fair_class_late();
> >   	sched_smp_initialized = true;
> >   }
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f7967be7646c..ff2491387201 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -139,18 +139,163 @@ static int __init setup_sched_thermal_decay_shift(char *str)
> >   }
> >   __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
> > +/**
> > + * struct shared_runq - Per-LLC queue structure for enqueuing and pulling
> > + * waking tasks.
> > + *
> > + * WHAT
> > + * ====
> > + *
> > + * This structure enables the scheduler to be more aggressively work
> > + * conserving, by placing waking tasks on a per-LLC FIFO queue that can then be
> > + * pulled from when another core in the LLC is going to go idle.
> > + *
> > + * struct rq stores a pointer to its LLC's shared_runq via struct cfs_rq.
> > + * Waking tasks are enqueued in a shared_runq at the end of
> > + * enqueue_task_fair(), and are opportunistically pulled from the shared_runq
> > + * in newidle_balance(). Tasks enqueued in a shared_runq may be scheduled prior
> > + * to being pulled from the shared_runq, in which case they're simply dequeued
> > + * from the shared_runq. A waking task is only enqueued to a shared_runq when
> > + * it was _not_ manually migrated to the current runqueue by
> > + * select_task_rq_fair().
> > + *
> > + * There is currently no task-stealing between shared_runqs in different LLCs,
> > + * which means that shared_runq is not fully work conserving. This could be
> > + * added at a later time, with tasks likely only being stolen across
> > + * shared_runqs on the same NUMA node to avoid violating NUMA affinities.
> > + *
> > + * HOW
> > + * ===
> > + *
> > + * An shared_runq is comprised of a list, and a spinlock for synchronization.
> > + * Given that the critical section for a shared_runq is typically a fast list
> > + * operation, and that the shared_runq is localized to a single LLC, the
> > + * spinlock will typically only be contended on workloads that do little else
> > + * other than hammer the runqueue.
> 
> Would there be scalability issues on large LLCs?

See the next patch in the series [0] where we shard the per-LLC shared
runqueues to avoid contention.

[0]: https://lore.kernel.org/lkml/20230710200342.358255-7-void@manifault.com/

> 
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
> > +	spinlock_t lock;
> > +} ____cacheline_aligned;
> > +
> >   #ifdef CONFIG_SMP
> > +static struct shared_runq *rq_shared_runq(struct rq *rq)
> > +{
> > +	return rq->cfs.shared_runq;
> > +}
> > +
> > +static struct task_struct *shared_runq_pop_task(struct rq *rq)
> > +{
> > +	unsigned long flags;
> > +	struct task_struct *p;
> > +	struct shared_runq *shared_runq;
> > +
> > +	shared_runq = rq_shared_runq(rq);
> > +	if (list_empty(&shared_runq->list))
> > +		return NULL;
> > +
> > +	spin_lock_irqsave(&shared_runq->lock, flags);
> > +	p = list_first_entry_or_null(&shared_runq->list, struct task_struct,
> > +				     shared_runq_node);
> > +	if (p && is_cpu_allowed(p, cpu_of(rq)))
> > +		list_del_init(&p->shared_runq_node);
> > +	else
> > +		p = NULL;
> > +	spin_unlock_irqrestore(&shared_runq->lock, flags);
> > +
> > +	return p;
> > +}
> > +
> > +static void shared_runq_push_task(struct rq *rq, struct task_struct *p)
> > +{
> > +	unsigned long flags;
> > +	struct shared_runq *shared_runq;
> > +
> > +	shared_runq = rq_shared_runq(rq);
> > +	spin_lock_irqsave(&shared_runq->lock, flags);
> > +	list_add_tail(&p->shared_runq_node, &shared_runq->list);
> > +	spin_unlock_irqrestore(&shared_runq->lock, flags);
> > +}
> > +
> >   static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
> >   				     int enq_flags)
> > -{}
> > +{
> > +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> > +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> > +
> > +	/*
> > +	 * Only enqueue the task in the shared runqueue if:
> > +	 *
> > +	 * - SWQUEUE is enabled
> > +	 * - The task is on the wakeup path
> > +	 * - The task wasn't purposefully migrated to the current rq by
> > +	 *   select_task_rq()
> > +	 * - The task isn't pinned to a specific CPU
> > +	 */
> > +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> > +		return;
> > +
> > +	shared_runq_push_task(rq, p);
> > +}
> >   static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
> >   {
> > -	return 0;
> > +	struct task_struct *p = NULL;
> > +	struct rq *src_rq;
> > +	struct rq_flags src_rf;
> > +	int ret;
> > +
> > +	p = shared_runq_pop_task(rq);
> > +	if (!p)
> > +		return 0;
> > +
> > +	rq_unpin_lock(rq, rf);
> > +	raw_spin_rq_unlock(rq);
> 
> It would be better use the rq_unlock(rq, rf) for simplicity.
> But it's absolutely OK if you want to keep as it is to be
> correspond with the below lock&repin part :)

Yeah, personally I'd prefer to keep the style the consistent between
here and below.

> > +
> > +	src_rq = task_rq_lock(p, &src_rf);
> > +
> > +	if (task_on_rq_queued(p) && !task_on_cpu(rq, p)) {
> 
> IMHO it should be:
> 
> 	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {

Agreed, will change in v3.

> > +		update_rq_clock(src_rq);
> > +		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
> > +	}
> > +
> > +	if (src_rq->cpu != rq->cpu)
> 
> Why not just 'if (src_rq != rq)'?

Ack, will change.

> 
> > +		ret = 1;
> > +	else
> > +		ret = -1;
> 
> What about making @ret default to -1 and changing to 1 right
> after move_queued_task()? Both for better readability and align
> with the behavior of newidle_balance().

Yep. This aligns with Gautham's suggestion in [1] as well. Will combine
your input for v3.

[1]: https://lore.kernel.org/lkml/ZK5BdysC0lxKQ%2FgE@BLR-5CG11610CF.amd.com/

> 
> > +
> > +	task_rq_unlock(src_rq, p, &src_rf);
> > +
> > +	raw_spin_rq_lock(rq);
> > +	rq_repin_lock(rq, rf);
> 
> By making it looks more ugly, we can save some cycles..
> 
> 	if (src_rq != rq) {
> 		task_rq_unlock(src_rq, p, &src_rf);
> 	} else {
> 		rq_unpin_lock(src_rq, src_rf);
> 		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
> 		rq_repin_lock(rq, rf);
> 	}

I like it. Thanks for the suggestion. I'll apply for v3.

> > +
> > +	return ret;
> >   }
> >   static void shared_runq_dequeue_task(struct task_struct *p)
> > -{}
> > +{
> > +	unsigned long flags;
> > +	struct shared_runq *shared_runq;
> > +
> > +	if (!list_empty(&p->shared_runq_node)) {
> > +		shared_runq = rq_shared_runq(task_rq(p));
> > +		spin_lock_irqsave(&shared_runq->lock, flags);
> > +		list_del_init(&p->shared_runq_node);
> > +		spin_unlock_irqrestore(&shared_runq->lock, flags);
> > +	}
> > +}
> >   /*
> >    * For asym packing, by default the lower numbered CPU has higher priority.
> > @@ -12854,3 +12999,34 @@ __init void init_sched_fair_class(void)
> >   #endif /* SMP */
> >   }
> > +
> > +__init void init_sched_fair_class_late(void)
> > +{
> > +#ifdef CONFIG_SMP
> > +	int i;
> > +	struct shared_runq *shared_runq;
> > +	struct rq *rq;
> > +	struct rq *llc_rq;
> > +
> > +	for_each_possible_cpu(i) {
> > +		if (per_cpu(sd_llc_id, i) == i) {
> > +			llc_rq = cpu_rq(i);
> > +
> > +			shared_runq = kzalloc_node(sizeof(struct shared_runq),
> > +					       GFP_KERNEL, cpu_to_node(i));
> > +			INIT_LIST_HEAD(&shared_runq->list);
> > +			spin_lock_init(&shared_runq->lock);
> > +			llc_rq->cfs.shared_runq = shared_runq;
> > +		}
> > +	}
> > +
> > +	for_each_possible_cpu(i) {
> > +		rq = cpu_rq(i);
> > +		llc_rq = cpu_rq(per_cpu(sd_llc_id, i));
> > +
> > +		if (rq == llc_rq)
> > +			continue;
> > +		rq->cfs.shared_runq = llc_rq->cfs.shared_runq;
> > +	}
> > +#endif /* SMP */
> > +}
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 187ad5da5ef6..8b573dfaba33 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -576,6 +576,7 @@ struct cfs_rq {
> >   #endif
> >   #ifdef CONFIG_SMP
> > +	struct shared_runq	*shared_runq;
> 
> I would suggest moving shared_runq into shared LLC sched domain,
> which is pointed by sd_llc_shared, as you might finally put the
> retrieval of shared_runq under RCU critical sections to handle
> domain re-building cases.

Yep, I have plans to take add support for domain re-building in v3.
I'll see whether it makes sense to put them into the shared LLC sched
domain, but at first glance it seems like a sane choice.

> 
> Best Regards,
> 	Abel

Thanks for the review.

- David

> 
> >   	/*
> >   	 * CFS load tracking
> >   	 */
> > @@ -2440,6 +2441,7 @@ extern void update_max_interval(void);
> >   extern void init_sched_dl_class(void);
> >   extern void init_sched_rt_class(void);
> >   extern void init_sched_fair_class(void);
> > +extern void init_sched_fair_class_late(void);
> >   extern void reweight_task(struct task_struct *p, int prio);
