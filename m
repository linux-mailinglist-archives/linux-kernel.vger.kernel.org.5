Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9DE7C8BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjJMQg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:36:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914595
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B1P0yX9ZRw/0jlq+UInNZzLy1boOv3Oh/srnPATCt64=; b=XyVAsZ/grO42MUR3cldVSX8ODx
        c123eBvWl54P00NcKUzszxpSvkqW7etX4mtUpnXLXwx4UfhJQzLTtrIxjQjcXXTaW8GcRTmHsdB/x
        3woboiKhyguCx4FbmuKgWwrvqwQ6MpATbiujkDvixzDzX5sbDH95eE2s2h5S1MPBImJJRmTHpWfLm
        7C2ltLYAfm0y2MX2eK5ZF1TxJeJDKLAEMHoPw9olCIRQHXG8/nejVaK7X9KFtyOspKqMPQmtzmBIH
        Lw21djRxtiiJJO36nLa9ep+o5QfEjATJXKsJloDfa9ZE2VLzmoEdQLX+J/LZUEV4cEsHb2CL5hN6o
        ecobPn2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qrL8F-002t7N-0m;
        Fri, 13 Oct 2023 16:35:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A9C2300365; Fri, 13 Oct 2023 18:35:24 +0200 (CEST)
Date:   Fri, 13 Oct 2023 18:35:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Segall <bsegall@google.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 03/15] sched/fair: Add lag based placement
Message-ID: <20231013163524.GA5294@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.794929315@infradead.org>
 <xm26fs2fhcu7.fsf@bsegall-linux.svl.corp.google.com>
 <20231012223428.GP6307@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012223428.GP6307@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:34:28AM +0200, Peter Zijlstra wrote:

> Right, so I do have this:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=344944e06f11da25b49328825ed15fedd63036d3
> 
> That allows tasks to sleep away the lag -- with all the gnarly bits that
> sleep time has. And it reliably fixes the above. However, it also
> depresses a bunch of other stuff. Never a free lunch etc.
> 
> It is so far the least horrible of the things I've tried. 

So the below is one I conceptually like more -- except I hate the code,
nor does it work as well as the one linked above.

(Mike, this isn't the same one you saw before -- it's been 'improved')

---

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 29daece54a74..7f17295931de 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -895,6 +895,7 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
+	unsigned			sched_delayed:1;
 
 	/* Force alignment to the next boundary: */
 	unsigned			:0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7771a4d68280..38b2e0488a38 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3833,12 +3833,21 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
+		update_rq_clock(rq);
+		if (unlikely(p->sched_delayed)) {
+			p->sched_delayed = 0;
+			/* mustn't run a delayed task */
+			WARN_ON_ONCE(task_on_cpu(rq, p));
+			dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
+			if (p->se.vlag > 0)
+				p->se.vlag = 0;
+			enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
+		}
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
 			 * it should preempt the task that is current now.
 			 */
-			update_rq_clock(rq);
 			wakeup_preempt(rq, p, wake_flags);
 		}
 		ttwu_do_wakeup(p);
@@ -6520,6 +6529,16 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
+static void __deschedule_task(struct rq *rq, struct task_struct *p)
+{
+	deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
+
+	if (p->in_iowait) {
+		atomic_inc(&rq->nr_iowait);
+		delayacct_blkio_start();
+	}
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6604,6 +6623,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 	switch_count = &prev->nivcsw;
 
+	WARN_ON_ONCE(prev->sched_delayed);
+
 	/*
 	 * We must load prev->state once (task_struct::state is volatile), such
 	 * that we form a control dependency vs deactivate_task() below.
@@ -6632,17 +6653,39 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			 *
 			 * After this, schedule() must not care about p->state any more.
 			 */
-			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
-
-			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
-				delayacct_blkio_start();
-			}
+			if (sched_feat(DELAY_DEQUEUE) &&
+			    prev->sched_class->eligible_task &&
+			    !prev->sched_class->eligible_task(rq, prev))
+				prev->sched_delayed = 1;
+			else
+				__deschedule_task(rq, prev);
 		}
 		switch_count = &prev->nvcsw;
 	}
 
-	next = pick_next_task(rq, prev, &rf);
+	for (struct task_struct *tmp = prev;;) {
+
+		next = pick_next_task(rq, tmp, &rf);
+		if (unlikely(tmp != prev))
+			finish_task(tmp);
+
+		if (likely(!next->sched_delayed))
+			break;
+
+		next->sched_delayed = 0;
+
+		/* ttwu_runnable() */
+		if (WARN_ON_ONCE(!next->__state))
+			break;
+
+		prepare_task(next);
+		smp_wmb();
+		__deschedule_task(rq, next);
+		if (next->se.vlag > 0)
+			next->se.vlag = 0;
+		tmp = next;
+	}
+
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b2210e7cc057..3084e21abfe7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8410,6 +8410,16 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq)
 	return pick_next_task_fair(rq, NULL, NULL);
 }
 
+static bool eligible_task_fair(struct rq *rq, struct task_struct *p)
+{
+	struct sched_entity *se = &p->se;
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	update_curr(cfs_rq);
+
+	return entity_eligible(cfs_rq, se);
+}
+
 /*
  * Account for a descheduled task:
  */
@@ -13006,6 +13016,7 @@ DEFINE_SCHED_CLASS(fair) = {
 
 	.wakeup_preempt		= check_preempt_wakeup_fair,
 
+	.eligible_task		= eligible_task_fair,
 	.pick_next_task		= __pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a133b46efedd..0546905f1f8f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -11,6 +11,7 @@ SCHED_FEAT(PREEMPT_SHORT, true)
 SCHED_FEAT(PLACE_SLEEPER, false)
 SCHED_FEAT(GENTLE_SLEEPER, true)
 SCHED_FEAT(EVDF, false)
+SCHED_FEAT(DELAY_DEQUEUE, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 245df0c6d344..35d297e1d91b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2222,6 +2222,7 @@ struct sched_class {
 
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
+	bool (*eligible_task)(struct rq *rq, struct task_struct *p);
 	struct task_struct *(*pick_next_task)(struct rq *rq);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
@@ -2275,7 +2276,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+//	WARN_ON_ONCE(rq->curr != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
