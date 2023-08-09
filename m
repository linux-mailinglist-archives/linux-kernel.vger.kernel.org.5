Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42047768CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjHITfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHITe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:34:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F0C6;
        Wed,  9 Aug 2023 12:34:58 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:34:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691609697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avhK83ETWP+EY52vf4zLFeVecnpAb5UyL56sNJqk+tY=;
        b=Z6bdaSlIVL4+kIU5D0u3PWYlBYwO5u8fxgVBop70bqezX44gZ7Pe8UEZXUdeIQGi64pY8C
        6EnHEQ4fcOZqkV42zMtqSdpyDZX2dIWhILTUIg8b7fqf5+WcXcESdQ2iYjglTRonoP4wE5
        rWUBstjMgntBUGGkR/acK4kPSOIq9uCBn16ESkDD/z4xQIHoS/nI35giivwCNNAndFcC0b
        Aee7QxbwWgzVk5pY3x4ERUXyP+X8kGrCBxIZ6fSlndLs1djc3mguTlDGxLcoxkOIRzk8NB
        MjAbzwuVMkF1XfG0tBfhd7QN61QKIGRhKD0wSdZmS/zSihvytzyIhfyJuj6wqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691609697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avhK83ETWP+EY52vf4zLFeVecnpAb5UyL56sNJqk+tY=;
        b=Il+nCp4+NtR6dOvEggwyxPP6e6HYPFGGbnNa6RmjKl7zO0fRxPCMra1jKAuyUHHNNT/qWI
        49nSanUZ+8fcmzBQ==
From:   "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Block nohz tick_stop when cfs bandwidth in use
Cc:     Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230712133357.381137-3-pauld@redhat.com>
References: <20230712133357.381137-3-pauld@redhat.com>
MIME-Version: 1.0
Message-ID: <169160969649.27769.9219750044644784611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     88c56cfeaec4642aee8aac58b38d5708c6aae0d3
Gitweb:        https://git.kernel.org/tip/88c56cfeaec4642aee8aac58b38d5708c6aae0d3
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Wed, 12 Jul 2023 09:33:57 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Aug 2023 16:19:26 +02:00

sched/fair: Block nohz tick_stop when cfs bandwidth in use

CFS bandwidth limits and NOHZ full don't play well together.  Tasks
can easily run well past their quotas before a remote tick does
accounting.  This leads to long, multi-period stalls before such
tasks can run again. Currently, when presented with these conflicting
requirements the scheduler is favoring nohz_full and letting the tick
be stopped. However, nohz tick stopping is already best-effort, there
are a number of conditions that can prevent it, whereas cfs runtime
bandwidth is expected to be enforced.

Make the scheduler favor bandwidth over stopping the tick by setting
TICK_DEP_BIT_SCHED when the only running task is a cfs task with
runtime limit enabled. We use cfs_b->hierarchical_quota to
determine if the task requires the tick.

Add check in pick_next_task_fair() as well since that is where
we have a handle on the task that is actually going to be running.

Add check in sched_can_stop_tick() to cover some edge cases such
as nr_running going from 2->1 and the 1 remains the running task.

Reviewed-By: Ben Segall <bsegall@google.com>
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230712133357.381137-3-pauld@redhat.com
---
 kernel/sched/core.c     | 26 ++++++++++++++++++++-
 kernel/sched/fair.c     | 52 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/features.h |  2 ++-
 kernel/sched/sched.h    |  2 ++-
 4 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3af25ca..614271a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1194,6 +1194,20 @@ static void nohz_csd_func(void *info)
 #endif /* CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
+static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
+{
+	if (rq->nr_running != 1)
+		return false;
+
+	if (p->sched_class != &fair_sched_class)
+		return false;
+
+	if (!task_on_rq_queued(p))
+		return false;
+
+	return true;
+}
+
 bool sched_can_stop_tick(struct rq *rq)
 {
 	int fifo_nr_running;
@@ -1229,6 +1243,18 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (rq->nr_running > 1)
 		return false;
 
+	/*
+	 * If there is one task and it has CFS runtime bandwidth constraints
+	 * and it's on the cpu now we don't want to stop the tick.
+	 * This check prevents clearing the bit if a newly enqueued task here is
+	 * dequeued by migrating while the constrained task continues to run.
+	 * E.g. going from 2->1 without going through pick_next_task().
+	 */
+	if (sched_feat(HZ_BW) && __need_bw_check(rq, rq->curr)) {
+		if (cfs_task_bw_constrained(rq->curr))
+			return false;
+	}
+
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 26bfbb6..c282064 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6189,6 +6189,46 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	rq_clock_stop_loop_update(rq);
 }
 
+bool cfs_task_bw_constrained(struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq = task_cfs_rq(p);
+
+	if (!cfs_bandwidth_used())
+		return false;
+
+	if (cfs_rq->runtime_enabled ||
+	    tg_cfs_bandwidth(cfs_rq->tg)->hierarchical_quota != RUNTIME_INF)
+		return true;
+
+	return false;
+}
+
+#ifdef CONFIG_NO_HZ_FULL
+/* called from pick_next_task_fair() */
+static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
+{
+	int cpu = cpu_of(rq);
+
+	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
+		return;
+
+	if (!tick_nohz_full_cpu(cpu))
+		return;
+
+	if (rq->nr_running != 1)
+		return;
+
+	/*
+	 *  We know there is only one task runnable and we've just picked it. The
+	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
+	 *  be otherwise able to stop the tick. Just need to check if we are using
+	 *  bandwidth control.
+	 */
+	if (cfs_task_bw_constrained(p))
+		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
+}
+#endif
+
 #else /* CONFIG_CFS_BANDWIDTH */
 
 static inline bool cfs_bandwidth_used(void)
@@ -6231,9 +6271,18 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static inline void update_runtime_enabled(struct rq *rq) {}
 static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
-
+#ifdef CONFIG_CGROUP_SCHED
+bool cfs_task_bw_constrained(struct task_struct *p)
+{
+	return false;
+}
+#endif
 #endif /* CONFIG_CFS_BANDWIDTH */
 
+#if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
+static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p) {}
+#endif
+
 /**************************************************
  * CFS operations on tasks:
  */
@@ -8201,6 +8250,7 @@ done: __maybe_unused;
 		hrtick_start_fair(rq, p);
 
 	update_misfit_status(p, rq);
+	sched_fair_update_stop_tick(rq, p);
 
 	return p;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c..e10074c 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -101,3 +101,5 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(HZ_BW, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 602de71..19af176 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -459,6 +459,7 @@ extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
+extern bool cfs_task_bw_constrained(struct task_struct *p);
 
 extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 		struct sched_rt_entity *rt_se, int cpu,
@@ -494,6 +495,7 @@ static inline void set_task_rq_fair(struct sched_entity *se,
 #else /* CONFIG_CGROUP_SCHED */
 
 struct cfs_bandwidth { };
+static inline bool cfs_task_bw_constrained(struct task_struct *p) { return false; }
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
