Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C87523B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjGMN1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjGMN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E38B4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689254751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nw20ycbPPxi/SRkqYxH6undVF0+uhwnpTJXu5xv9bTY=;
        b=TARLDh6qqc6uuTqDGgzZBfEnNz1nvIHVoUKEyjhAEuDoVRyBKOq2hUx3Do/x2vQPrASrns
        lA+EGT4PLE/Sx6LODBoe7KeckHjsA9JfhydIDWAn+/DarrhyZC/VSuLNoDG5pYjjOdt5MT
        dTJKiZkmkg3XDbDSy3drYkbRXC65v+g=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-qkq5pNpGPQquBkT8x9rKNw-1; Thu, 13 Jul 2023 09:25:40 -0400
X-MC-Unique: qkq5pNpGPQquBkT8x9rKNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 232623C160E3;
        Thu, 13 Jul 2023 13:25:36 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.192.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 450052166B27;
        Thu, 13 Jul 2023 13:25:32 +0000 (UTC)
Date:   Thu, 13 Jul 2023 09:25:28 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Benjamin Segall <bsegall@google.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6 2/2] Sched/fair: Block nohz tick_stop when cfs
 bandwidth in use
Message-ID: <20230713132528.GB13342@lorien.usersys.redhat.com>
References: <20230712133357.381137-1-pauld@redhat.com>
 <20230712133357.381137-3-pauld@redhat.com>
 <xm264jm8g4q3.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm264jm8g4q3.fsf@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:11:32PM -0700 Benjamin Segall wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> > can easily run well past their quotas before a remote tick does
> > accounting.  This leads to long, multi-period stalls before such
> > tasks can run again. Currently, when presented with these conflicting
> > requirements the scheduler is favoring nohz_full and letting the tick
> > be stopped. However, nohz tick stopping is already best-effort, there
> > are a number of conditions that can prevent it, whereas cfs runtime
> > bandwidth is expected to be enforced.
> >
> > Make the scheduler favor bandwidth over stopping the tick by setting
> > TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> > runtime limit enabled. We use cfs_b->hierarchical_quota to
> > determine if the task requires the tick.
> >
> > Add check in pick_next_task_fair() as well since that is where
> > we have a handle on the task that is actually going to be running.
> >
> > Add check in sched_can_stop_tick() to cover some edge cases such
> > as nr_running going from 2->1 and the 1 remains the running task.
> >
> > Add sched_feat HZ_BW (off by default) to control the tick_stop
> > behavior.
> 
> I think this looks good now.
> Reviewed-By: Ben Segall <bsegall@google.com>
>

Thanks for your help and patience!


Cheers,
Phil


> >
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > ---
> > v6: restore check for fair_sched_class
> >
> > v5: Reworked checks to use newly-fixed cfs_b->hierarchical_quota to
> > check for bw
> > constraints. 
> >
> > v4: Made checks for runtime_enabled hierarchical. 
> >
> > v3: Moved sched_cfs_bandwidth_active() prototype to sched.h outside of
> > guards to
> > silence -Wmissing-prototypes.
> >
> > v2:  Ben pointed out that the bit could get cleared in the dequeue path
> > if we migrate a newly enqueued task without preempting curr. Added a
> > check for that edge case to sched_can_stop_tick. Removed the call to
> > sched_can_stop_tick from sched_fair_update_stop_tick since it was
> > redundant.
> >
> >  kernel/sched/core.c     | 26 ++++++++++++++++++++++
> >  kernel/sched/fair.c     | 49 +++++++++++++++++++++++++++++++++++++++++
> >  kernel/sched/features.h |  2 ++
> >  kernel/sched/sched.h    |  1 +
> >  4 files changed, 78 insertions(+)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f80697a79baf..8a2ed4c0b709 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1194,6 +1194,20 @@ static void nohz_csd_func(void *info)
> >  #endif /* CONFIG_NO_HZ_COMMON */
> >  
> >  #ifdef CONFIG_NO_HZ_FULL
> > +static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
> > +{
> > +	if (rq->nr_running != 1)
> > +		return false;
> > +
> > +	if (p->sched_class != &fair_sched_class)
> > +		return false;
> > +
> > +	if (!task_on_rq_queued(p))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  bool sched_can_stop_tick(struct rq *rq)
> >  {
> >  	int fifo_nr_running;
> > @@ -1229,6 +1243,18 @@ bool sched_can_stop_tick(struct rq *rq)
> >  	if (rq->nr_running > 1)
> >  		return false;
> >  
> > +	/*
> > +	 * If there is one task and it has CFS runtime bandwidth constraints
> > +	 * and it's on the cpu now we don't want to stop the tick.
> > +	 * This check prevents clearing the bit if a newly enqueued task here is
> > +	 * dequeued by migrating while the constrained task continues to run.
> > +	 * E.g. going from 2->1 without going through pick_next_task().
> > +	 */
> > +	if (sched_feat(HZ_BW) && __need_bw_check(rq, rq->curr)) {
> > +		if (cfs_task_bw_constrained(rq->curr))
> > +			return false;
> > +	}
> > +
> >  	return true;
> >  }
> >  #endif /* CONFIG_NO_HZ_FULL */
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d9b3d4617e16..acd9f317aad1 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6140,6 +6140,46 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
> >  	rcu_read_unlock();
> >  }
> >  
> > +bool cfs_task_bw_constrained(struct task_struct *p)
> > +{
> > +	struct cfs_rq *cfs_rq = task_cfs_rq(p);
> > +
> > +	if (!cfs_bandwidth_used())
> > +		return false;
> > +
> > +	if (cfs_rq->runtime_enabled ||
> > +	    tg_cfs_bandwidth(cfs_rq->tg)->hierarchical_quota != RUNTIME_INF)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +#ifdef CONFIG_NO_HZ_FULL
> > +/* called from pick_next_task_fair() */
> > +static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
> > +{
> > +	int cpu = cpu_of(rq);
> > +
> > +	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
> > +		return;
> > +
> > +	if (!tick_nohz_full_cpu(cpu))
> > +		return;
> > +
> > +	if (rq->nr_running != 1)
> > +		return;
> > +
> > +	/*
> > +	 *  We know there is only one task runnable and we've just picked it. The
> > +	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
> > +	 *  be otherwise able to stop the tick. Just need to check if we are using
> > +	 *  bandwidth control.
> > +	 */
> > +	if (cfs_task_bw_constrained(p))
> > +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
> > +}
> > +#endif
> > +
> >  #else /* CONFIG_CFS_BANDWIDTH */
> >  
> >  static inline bool cfs_bandwidth_used(void)
> > @@ -6182,9 +6222,17 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> >  static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
> >  static inline void update_runtime_enabled(struct rq *rq) {}
> >  static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
> > +bool cfs_task_bw_constrained(struct task_struct *p)
> > +{
> > +	return false;
> > +}
> >  
> >  #endif /* CONFIG_CFS_BANDWIDTH */
> >  
> > +#if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
> > +static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p) {}
> > +#endif
> > +
> >  /**************************************************
> >   * CFS operations on tasks:
> >   */
> > @@ -8098,6 +8146,7 @@ done: __maybe_unused;
> >  		hrtick_start_fair(rq, p);
> >  
> >  	update_misfit_status(p, rq);
> > +	sched_fair_update_stop_tick(rq, p);
> >  
> >  	return p;
> >  
> > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > index ee7f23c76bd3..6fdf1fdf6b17 100644
> > --- a/kernel/sched/features.h
> > +++ b/kernel/sched/features.h
> > @@ -101,3 +101,5 @@ SCHED_FEAT(LATENCY_WARN, false)
> >  
> >  SCHED_FEAT(ALT_PERIOD, true)
> >  SCHED_FEAT(BASE_SLICE, true)
> > +
> > +SCHED_FEAT(HZ_BW, false)
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 63822c9238cc..d6d346bc78aa 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -465,6 +465,7 @@ extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth
> >  extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
> >  extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
> >  extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
> > +extern bool cfs_task_bw_constrained(struct task_struct *p);
> >  
> >  extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
> >  		struct sched_rt_entity *rt_se, int cpu,
> 

-- 

