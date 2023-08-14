Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6877BA10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjHNNad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjHNN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:29:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11461E77
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Taagr/PgWuW5Zl+sgeC8v4hWn3GEM6MsenHQCvQR1vY=; b=Z7Bz7uVR9dwfiM63NckpKdiJgA
        g5adrqZrRPgS2a5xt0PkshKbVx1yKEDr992QpMslWpoXyNncLy9skomxnodxzTfEHlfNhKfNPxxPG
        Nok0JZO1SeHVq7pND/26yMWpfM79A8L5vWN3YvLQBZBD7fhHvENtiJmN/r9JZZFktPqQ/QCfWQ1PC
        33gRDk6Fb3SpU1BEitgSz5h2eS4uKBsHxyWpbl3953bRCDib0OhwMn8KItxNdwH4R+DBTZ4tWynsL
        qn72MK62ck0v7tC7ywhYbvCQAFTpcR+bKl89fUuBHpn6FcVFzB2BNEqKPmkRL7AldNRRrG1sGZu4I
        55q0YQ3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVXdY-002C6j-0i; Mon, 14 Aug 2023 13:29:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 731E2300137;
        Mon, 14 Aug 2023 15:29:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54DDB202BDC7A; Mon, 14 Aug 2023 15:29:35 +0200 (CEST)
Date:   Mon, 14 Aug 2023 15:29:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <20230814132935.GK776869@hirez.programming.kicks-ass.net>
References: <202308101628.7af4631a-oliver.sang@intel.com>
 <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
 <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:42:09AM +0800, Chen Yu wrote:

> Since previously lkp has reported that with eevdf policy enabled, there was
> a regression in hackbench, I did some experiments and found that, with eevdf
> enabled there are more preemptions, and this preemption could slow down
> the waker(each waker could wakes up 20 wakee in hackbench). The reason might
> be that, check_preempt_wakeup() is easier to preempt the current task in eevdf:

This is true.

> Without eevdf enabled, the /proc/schedstat delta within 5 seconds on CPU8 is:
> Thu Aug 10 11:02:02 2023              cpu8
> .stats.check_preempt_count            51973       <-----
> .stats.need_preempt_count             10514       <-----
> .stats.rq_cpu_time                   5004068598
> .stats.rq_sched_info.pcount           60374
> .stats.rq_sched_info.run_delay       80405664582
> .stats.sched_count                    60609
> .stats.sched_goidle                    227
> .stats.ttwu_count                     56250
> .stats.ttwu_local                     14619
> 
> The preemption success ration is 10514 / 51973 = 20.23%
> -----------------------------------------------------------------------------
> 
> With eevdf enabled, the /proc/schedstat delta within 5 seconds on CPU8 is:
> Thu Aug 10 10:22:55 2023              cpu8
> .stats.check_preempt_count            71673      <----
> .stats.low_gran_preempt_count         57410
> .stats.need_preempt_count             57413      <----
> .stats.rq_cpu_time                   5007778990
> .stats.rq_sched_info.pcount          129233
> .stats.rq_sched_info.run_delay       164830921362
> .stats.sched_count                   129233
> .stats.ttwu_count                     70222
> .stats.ttwu_local                     66847
> 
> The preemption success ration is 57413 / 71673 = 80.10%

note: wakeup-preemption

> According to the low_gran_preempt_count, most successfully preemption happens
> when the current->vruntime is smaller than wakee->vruntime + sysctl_sched_wakeup_granularity,
> which will not happen in current cfs's wakeup_preempt_entity().
> 
> It seems that, eevdf does not inhit the wakeup preemption as much as cfs, and
> maybe it is because eevdf needs to consider fairness more?

Not fairness, latency. Because it wants to honour the virtual deadline.


Are these wakeup preemptions typically on runqueues that have only a
single other task?

That is, consider a single task running, then avg_vruntime will be it's
vruntime, because the average of one variable must be the value of that
one variable.

Then the moment a second task joins, we get two options:

 - positive lag
 - negative lag

When the new task has negative lag, it gets placed to the right of the
currently running task (and avg_vruntime has a forward discontinuity).
At this point the new task is not eligible and does not get to run.

When the new task has positive lag, it gets placed to the left of the
currently running task (and avg_vruntime has a backward discontinuity).
At this point the currently running task is no longer eligible, and the
new task must be selected -- irrespective of it's deadline.

The paper doesn't (AFAIR) consider the case of wake-up-preemption
explicitly. It only considers task selection and vruntime placement.

One option I suppose would be to gate the wakeup preemption by virtual
deadline, only allow when the new task has an earlier deadline than the
currently running one, and otherwise rely on tick preemption.

NOTE: poking at wakeup preemption is a double edged sword, some
workloads love it, some hate it. Touching it is bound to upset the
balance -- again.

(also, did I get that the right way around? -- I've got a Monday brain
that isn't willing to boot properly)

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe5be91c71c7..16d24e5dda8f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8047,6 +8047,15 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 
+	if (sched_feat(WAKEUP_DEADLINE)) {
+		/*
+		 * Only allow preemption if the virtual deadline of the new
+		 * task is before the virtual deadline of the existing task.
+		 */
+		if (deadline_gt(deadline, pse, se))
+			return;
+	}
+
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 61bcbf5e46a4..e733981b32aa 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -24,6 +24,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  * Allow wakeup-time preemption of the current task:
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
+SCHED_FEAT(WAKEUP_DEADLINE, true)
 
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
