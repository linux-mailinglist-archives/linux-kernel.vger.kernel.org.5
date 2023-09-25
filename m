Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8829C7AD58E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjIYKMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjIYKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:11:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBADE1719;
        Mon, 25 Sep 2023 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ea4HtJ5aKLbBQfzI8DSRMzTkrWboV+0wvCLo5Ac7A3A=; b=teHJXWkhqXRNWI2ShWLJQWPjnQ
        UpE1ZYJs59OGfH9p6dgSO0hQ7MQo9pf5YNaO98ZZMJjTHGR0SlNFCP3mseC82/LnlnHqBDTGPP/oQ
        PB+alGXaWkwYLiWIZ1oiAtjYMmUJvnVi2rhrs+sMfij2vM2SLyK0UDTNIHj6wq2iNguvVj7kMxt24
        mk6/y6SsqbnKUoQFwd5qhdo3jk3jZZj5M/ZQG4fSSuvy1oE3xEsqWfM6tURvJnO9fpWsOvhefDMDV
        gNR+M7LVXsQpTmgrpCt14GFyiTlmy5rQWz2vbDVFVTDjpqG3e8EdAj1BKwk8CdvMxtds0E/QyaFP1
        Dh7I5/Rg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkiYp-000rMm-I5; Mon, 25 Sep 2023 10:11:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CC9430031B; Mon, 25 Sep 2023 12:11:27 +0200 (CEST)
Date:   Mon, 25 Sep 2023 12:11:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/rt: Make rt_rq->pushable_tasks updates
 drive rto_mask
Message-ID: <20230925101127.GB31921@noisy.programming.kicks-ass.net>
References: <20230811112044.3302588-1-vschneid@redhat.com>
 <169563211069.27769.17070510461354463740.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169563211069.27769.17070510461354463740.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 08:55:10AM -0000, tip-bot2 for Valentin Schneider wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     612f769edd06a6e42f7cd72425488e68ddaeef0a
> Gitweb:        https://git.kernel.org/tip/612f769edd06a6e42f7cd72425488e68ddaeef0a
> Author:        Valentin Schneider <vschneid@redhat.com>
> AuthorDate:    Fri, 11 Aug 2023 12:20:44 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Mon, 25 Sep 2023 10:25:29 +02:00
> 
> sched/rt: Make rt_rq->pushable_tasks updates drive rto_mask
> 
> Sebastian noted that the rto_push_work IRQ work can be queued for a CPU
> that has an empty pushable_tasks list, which means nothing useful will be
> done in the IPI other than queue the work for the next CPU on the rto_mask.
> 
> rto_push_irq_work_func() only operates on tasks in the pushable_tasks list,
> but the conditions for that irq_work to be queued (and for a CPU to be
> added to the rto_mask) rely on rq_rt->nr_migratory instead.
> 
> nr_migratory is increased whenever an RT task entity is enqueued and it has
> nr_cpus_allowed > 1. Unlike the pushable_tasks list, nr_migratory includes a
> rt_rq's current task. This means a rt_rq can have a migratible current, N
> non-migratible queued tasks, and be flagged as overloaded / have its CPU
> set in the rto_mask, despite having an empty pushable_tasks list.
> 
> Make an rt_rq's overload logic be driven by {enqueue,dequeue}_pushable_task().
> Since rt_rq->{rt_nr_migratory,rt_nr_total} become unused, remove them.
> 
> Note that the case where the current task is pushed away to make way for a
> migration-disabled task remains unchanged: the migration-disabled task has
> to be in the pushable_tasks list in the first place, which means it has
> nr_cpus_allowed > 1.
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lore.kernel.org/r/20230811112044.3302588-1-vschneid@redhat.com
> ---
>  kernel/sched/debug.c |  3 +--
>  kernel/sched/rt.c    | 70 ++++++-------------------------------------
>  kernel/sched/sched.h |  2 +-
>  3 files changed, 10 insertions(+), 65 deletions(-)
> 

> @@ -358,53 +357,6 @@ static inline void rt_clear_overload(struct rq *rq)
>  	cpumask_clear_cpu(rq->cpu, rq->rd->rto_mask);
>  }
>  
> -static void update_rt_migration(struct rt_rq *rt_rq)
> -{
> -	if (rt_rq->rt_nr_migratory && rt_rq->rt_nr_total > 1) {
> -		if (!rt_rq->overloaded) {
> -			rt_set_overload(rq_of_rt_rq(rt_rq));
> -			rt_rq->overloaded = 1;
> -		}
> -	} else if (rt_rq->overloaded) {
> -		rt_clear_overload(rq_of_rt_rq(rt_rq));
> -		rt_rq->overloaded = 0;
> -	}
> -}
> -
> -static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
> -{
> -	struct task_struct *p;
> -
> -	if (!rt_entity_is_task(rt_se))
> -		return;
> -
> -	p = rt_task_of(rt_se);
> -	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
> -
> -	rt_rq->rt_nr_total++;
> -	if (p->nr_cpus_allowed > 1)
> -		rt_rq->rt_nr_migratory++;
> -
> -	update_rt_migration(rt_rq);
> -}
> -
> -static void dec_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
> -{
> -	struct task_struct *p;
> -
> -	if (!rt_entity_is_task(rt_se))
> -		return;
> -
> -	p = rt_task_of(rt_se);
> -	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
> -
> -	rt_rq->rt_nr_total--;
> -	if (p->nr_cpus_allowed > 1)
> -		rt_rq->rt_nr_migratory--;
> -
> -	update_rt_migration(rt_rq);
> -}

sched/deadline.c has something very similar, does that need updating
too?
