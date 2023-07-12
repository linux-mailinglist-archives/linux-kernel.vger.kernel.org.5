Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE4751108
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjGLTNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGLTNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:13:23 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0012F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:13:22 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-63588812c7aso5513786d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689189201; x=1691781201;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A693YwQHKAudPYIHxBFeOCKIJbNKDFtDtRrMBaZ9+TE=;
        b=MtXvfKv4Q7Yla8VZ+A4/FaZcyYIWcH86NmHKR0sycyjIi7doFnz4QeVlvCASLm5cn8
         Yuf4C4EvwvH9Yq/GGK6GOBr88pTAockcjbV0EiKBEyYvckUYVf4rnlXr5UGfJFAqXC9t
         bi8aAIpNh74jAQpnLaFMNm74qZbg97FGM/GjmNcwqYx8RWOUaA6dRtgMkYbT1GnuMcH4
         BtuY/Xu/F+MtkaFAZLSGJUGC4YWWhl7gLD7CRhCvo7qEHdxiW4ARRx2senVDXNy/G1vj
         r+rQA5BL8tluzFXrWj+vBGdtmXCKCm6rB6i0NPR+WNUe4dmTqAikKiPanOVFTv06wUJw
         UXUQ==
X-Gm-Message-State: ABy/qLZ3xBvvZIVgBx02hnfY6n/vSoCWxvqMFEhAA+lWk20RQEcVpQa2
        Ivgf4v1+N/UkIyuvLJhmATg=
X-Google-Smtp-Source: APBJJlFIpV/N98o3QrTjIK/VqkmQyrRIA4v/B5H8Ud7DKNE/TGpprJCASfbSuxveQAaOAJ7TqQU2SQ==
X-Received: by 2002:a0c:c545:0:b0:636:1275:8419 with SMTP id y5-20020a0cc545000000b0063612758419mr3226886qvi.13.1689189201314;
        Wed, 12 Jul 2023 12:13:21 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:3a6e])
        by smtp.gmail.com with ESMTPSA id y3-20020a0cd983000000b0062df126ca11sm2412923qvj.21.2023.07.12.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:13:20 -0700 (PDT)
Date:   Wed, 12 Jul 2023 14:13:18 -0500
From:   David Vernet <void@manifault.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kprateek.nayak@amd.com,
        aaron.lu@intel.com, clm@meta.com, tj@kernel.org,
        roman.gushchin@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Message-ID: <20230712191318.GA12207@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
 <ZK5BdysC0lxKQ/gE@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK5BdysC0lxKQ/gE@BLR-5CG11610CF.amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:30:23AM +0530, Gautham R. Shenoy wrote:
> Hello David,
> 
> On Mon, Jul 10, 2023 at 03:03:40PM -0500, David Vernet wrote:
> 
> [..snip..]
> 
> > ---
> 
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
> 
> 
> Apologies for the bikeshedding comment : Here you are attempting to
> remove the task from the "head", while in shared_runq_push_task below,
> you are adding a task to the tail. Which is the usual queue
> semantics. Then why call them shared_runq_pop_task() and
> shared_runq_push_task() ?
> 
> Can we name them __shared_runq_enqueue_task() and
> __shared_runq_pick_next_task() instead ?

Hello Gautham,

So this was previously discussed in [0]. I'm fine with changing the
names if that's others' preferences as well. I think what we have now is
nice in that push and pop are list operations whereas enqueue / dequeue
are scheduler operations, but yeah, push / pop are more-so stack than
queue ops. Using __ to make the list ops "private" is fine with me.

[0]: https://lore.kernel.org/lkml/20230622105841.GH4253@hirez.programming.kicks-ass.net/

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
> >  static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
> >  				     int enq_flags)
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
> >  
> >  static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
> >  {
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
> > +
> > +	src_rq = task_rq_lock(p, &src_rf);
> > +
> > +	if (task_on_rq_queued(p) && !task_on_cpu(rq, p)) {
> > +		update_rq_clock(src_rq);
> > +		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
> > +	}
> > +
> > +	if (src_rq->cpu != rq->cpu)
> > +		ret = 1;
> > +	else
> > +		ret = -1;
> 
> 
> So if src_rq->cpu != rq->cpu, then the task has _not_ been moved to
> rq. But you return 1.
> 
> While in the else case, since src_rq->cpu == rq->cpu, the task has
> been successfully moved to rq. But you are returning -1,
> 
> If newidle_balance() were to interpret this return value as the number
> of tasks pulled, then, shouldn't it be the other way around ?

Yeah, good call. Will incorporate this into v3.

> > +
> > +	task_rq_unlock(src_rq, p, &src_rf);
> > +
> > +	raw_spin_rq_lock(rq);
> > +	rq_repin_lock(rq, rf);
> > +
> > +	return ret;
> >  }
> >  
> 
> --
> Thanks and Regards
> gautham.
