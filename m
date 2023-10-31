Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5C7DC8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbjJaIxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjJaIxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:53:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D41BD8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RcdRjVqv5DspDxModBMo3HApmg3AP0AmSCJ9Zw4NNk4=; b=n/ONjoTYrDrHphxik9ajRD/Xvb
        /4Yw4YR60GgO6CrqIfGqu5y8v3EVgpG3GEkCnYGfB4lchaCK4ccfk4Jkw4e79uQQvnFScqYsM7uci
        adr5RkF/+8pjpPeGWsZHgwXZG6AWjgnYKCXiyHJg8SREyJzbXWwUqdoASqcCK7Rsz9yhz7urabvtk
        nXWkIWnNI1hlEnxEEZJagfGqSagC3kS8NynODA5/wKAck0IPt+N/3eMKkMdL+5Wy2wUIKCNGz8sUt
        LwNDCe7SoXMNEcBRr879/LCegN1rsPfbCsbBS3+GcX7uv7awj1hrNUvMEPXqNfY6xi91fmg/Tgb6A
        g7/AKfFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxkUm-004hI1-2G;
        Tue, 31 Oct 2023 08:53:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 570F4300478; Tue, 31 Oct 2023 09:53:08 +0100 (CET)
Date:   Tue, 31 Oct 2023 09:53:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com
Subject: Re: [PATCH] sched: Don't call any kfree*() API in
 do_set_cpus_allowed()
Message-ID: <20231031085308.GB35651@noisy.programming.kicks-ass.net>
References: <20231031001418.274187-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031001418.274187-1-longman@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 08:14:18PM -0400, Waiman Long wrote:
> Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> do_set_cpus_allowed()") added a kfree() call to free any user
> provided affinity mask, if present. It was changed later to use
> kfree_rcu() in commit 9a5418bc48ba ("sched/core: Use kfree_rcu()
> in do_set_cpus_allowed()") to avoid a circular locking dependency
> problem.
> 
> It turns out that even kfree_rcu() isn't safe for avoiding
> circular locking problem. As reported by kernel test robot,
> the following circular locking dependency still exists:
> 
>   &rdp->nocb_lock --> rcu_node_0 --> &rq->__lock
> 
> So no kfree*() API can be used in do_set_cpus_allowed(). To prevent
> memory leakage, the unused user provided affinity mask is now saved in a
> lockless list to be reused later by subsequent sched_setaffinity() calls.
> 
> Without kfree_rcu(), the internal cpumask_rcuhead union can be removed
> too as a lockless list entry only holds a single pointer.
> 
> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")

Bah, or we fix RCU...  Paul, how insane is the below?

---
 kernel/rcu/tree.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..4b8e26a028ee 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -754,15 +754,20 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 }
 
 /*
- * Return true if the specified CPU has passed through a quiescent
- * state by virtue of being in or having passed through an dynticks
- * idle state since the last call to dyntick_save_progress_counter()
- * for this same CPU, or by virtue of having been offline.
+ * Returns positive if the specified CPU has passed through a quiescent state
+ * by virtue of being in or having passed through an dynticks idle state since
+ * the last call to dyntick_save_progress_counter() for this same CPU, or by
+ * virtue of having been offline.
+ *
+ * Returns negative if the specified CPU needs a force resched.
+ *
+ * Returns zero otherwise.
  */
 static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 {
-	unsigned long jtsq;
 	struct rcu_node *rnp = rdp->mynode;
+	unsigned long jtsq;
+	int ret = 0;
 
 	/*
 	 * If the CPU passed through or entered a dynticks idle phase with
@@ -847,8 +852,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	    (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
 	     rcu_state.cbovld)) {
 		WRITE_ONCE(rdp->rcu_urgent_qs, true);
-		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
+		ret = -1;
 	}
 
 	/*
@@ -891,7 +896,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
@@ -2255,11 +2260,11 @@ void rcu_sched_clock_irq(int user)
  */
 static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 {
-	int cpu;
+	unsigned long mask, rsmask = 0;
 	unsigned long flags;
-	unsigned long mask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	int cpu, ret;
 
 	rcu_state.cbovld = rcu_state.cbovldnext;
 	rcu_state.cbovldnext = false;
@@ -2284,10 +2289,13 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		}
 		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
 			rdp = per_cpu_ptr(&rcu_data, cpu);
-			if (f(rdp)) {
+			ret = f(rdp);
+			if (ret > 0) {
 				mask |= rdp->grpmask;
 				rcu_disable_urgency_upon_qs(rdp);
 			}
+			if (ret < 0)
+				rsmask |= 1UL << (cpu - rnp->grplo);
 		}
 		if (mask != 0) {
 			/* Idle/offline CPUs, report (releases rnp->lock). */
@@ -2296,6 +2304,9 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			/* Nothing to do here, so just drop the lock. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
+
+		for_each_leaf_node_cpu_mask(rnp, cpu, rsmask)
+			resched_cpu(cpu);
 	}
 }
 
