Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB6E7B7B03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbjJDJFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbjJDJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:05:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8342898
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:05:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB4D1480;
        Wed,  4 Oct 2023 02:06:02 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB7803F59C;
        Wed,  4 Oct 2023 02:05:22 -0700 (PDT)
From:   Hongyan Xia <Hongyan.Xia2@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org, Hongyan Xia <hongyan.xia2@arm.com>
Subject: [RFC PATCH 1/6] sched/uclamp: Track uclamped util_avg in sched_avg
Date:   Wed,  4 Oct 2023 10:04:49 +0100
Message-Id: <5564fc23d5e6425d069c36b4cef48edbe77fe64d.1696345700.git.Hongyan.Xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696345700.git.Hongyan.Xia2@arm.com>
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyan Xia <hongyan.xia2@arm.com>

Track a uclamped version of util_avg in sched_avg, which clamps util_avg
within [uclamp[UCLAMP_MIN], uclamp[UCLAMP_MAX]] every time util_avg is
updated. At the CFS rq level, cfs_rq->avg.util_avg_uclamp must always be
the sum of all util_avg_uclamp of entities on this cfs_rq. So, each
time the util_avg_uclamp of an entity gets updated, we also track the
delta and update the cfs_rq.

We can't put the update of cfs_rq util_avg_uclamp separately in
propagate_entity_load_avg(), because util_avg_uclamp of se and cfs_rq
are not tracked separately, unlike util_avg. As a result,
util_avg_uclamp of the se and the cfs_rq the se is on must be updated
at the same time.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 include/linux/sched.h |  9 ++++++++-
 kernel/sched/fair.c   | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 177b3f3676ef..825d7b86b006 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -499,7 +499,14 @@ struct sched_avg {
 	u32				period_contrib;
 	unsigned long			load_avg;
 	unsigned long			runnable_avg;
-	unsigned long			util_avg;
+	unsigned int			util_avg;
+#ifdef CONFIG_UCLAMP_TASK
+	/*
+	 * XXX: util_avg shrunk to accommodate util_avg_uclamp.
+	 * What are the consequences?
+	 */
+	unsigned int			util_avg_uclamp;
+#endif
 	struct util_est			util_est;
 } ____cacheline_aligned;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b7445cd5af9..33e5a6e751c0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1077,6 +1077,9 @@ void post_init_entity_util_avg(struct task_struct *p)
 	}
 
 	sa->runnable_avg = sa->util_avg;
+#ifdef CONFIG_UCLAMP_TASK
+	sa->util_avg_uclamp = sa->util_avg;
+#endif
 }
 
 #else /* !CONFIG_SMP */
@@ -5068,6 +5071,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_stats_enqueue_fair(cfs_rq, se, flags);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
+	enqueue_util_avg_uclamp(cfs_rq, se);
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -5138,6 +5142,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_entity_lag(cfs_rq, se);
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
+	dequeue_util_avg_uclamp(cfs_rq, se);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -6445,6 +6450,21 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
+void ___update_util_avg_uclamp(struct sched_avg *avg, struct sched_entity *se);
+
+static void update_se_chain(struct task_struct *p)
+{
+#ifdef CONFIG_UCLAMP_TASK
+	struct sched_entity *se = &p->se;
+	struct rq *rq = task_rq(p);
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		___update_util_avg_uclamp(&cfs_rq->avg, se);
+	}
+#endif
+}
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -6511,6 +6531,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 	}
 
+	/*
+	 * Re-evaluate the se hierarchy now that on_rq is true. This is
+	 * important to enforce uclamp the moment a task with uclamp is
+	 * enqueued, rather than waiting a timer tick for uclamp to kick in.
+	 *
+	 * XXX: This duplicates some of the work already done in the above for
+	 * loops.
+	 */
+	update_se_chain(p);
+
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
 
@@ -6612,6 +6642,15 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
+
+#ifdef CONFIG_UCLAMP_TASK
+	if (rq->cfs.h_nr_running == 0) {
+		WARN_ONCE(rq->cfs.avg.util_avg_uclamp,
+			"0 tasks on CFS of CPU %d, but util_avg_uclamp is %u\n",
+			rq->cpu, rq->cfs.avg.util_avg_uclamp);
+		WRITE_ONCE(rq->cfs.avg.util_avg_uclamp, 0);
+	}
+#endif
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 0f310768260c..c656e4dcb1d1 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -266,6 +266,48 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+/* avg must belong to the queue this se is on. */
+void ___update_util_avg_uclamp(struct sched_avg *avg, struct sched_entity *se)
+{
+	unsigned int util;
+	int delta;
+
+	if (entity_is_task(se)) {
+		unsigned int uclamp_min, uclamp_max;
+
+		if (!se->on_rq)
+			return;
+
+		util = READ_ONCE(se->avg.util_avg);
+		uclamp_min = uclamp_eff_value(task_of(se), UCLAMP_MIN);
+		uclamp_max = uclamp_eff_value(task_of(se), UCLAMP_MAX);
+		util = clamp(util, uclamp_min, uclamp_max);
+	} else {
+		util = READ_ONCE(group_cfs_rq(se)->avg.util_avg_uclamp);
+
+		if (!se->on_rq) {
+			WRITE_ONCE(se->avg.util_avg_uclamp, util);
+			return;
+		}
+	}
+
+	delta = util - READ_ONCE(se->avg.util_avg_uclamp);
+	if (delta == 0)
+		return;
+
+	WRITE_ONCE(se->avg.util_avg_uclamp, util);
+	util = READ_ONCE(avg->util_avg_uclamp);
+	util += delta;
+	WRITE_ONCE(avg->util_avg_uclamp, util);
+}
+#else /* !CONFIG_UCLAMP_TASK */
+static void
+___update_util_avg_uclamp(struct sched_avg *avg, struct sched_entity *se)
+{
+}
+#endif
+
 /*
  * sched_entity:
  *
@@ -309,6 +351,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 				cfs_rq->curr == se)) {
 
 		___update_load_avg(&se->avg, se_weight(se));
+		___update_util_avg_uclamp(&cfs_rq->avg, se);
 		cfs_se_util_change(&se->avg);
 		trace_pelt_se_tp(se);
 		return 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3a01b7a2bf66..2eefcdb0c3b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3133,6 +3133,33 @@ static inline bool uclamp_is_used(void)
 {
 	return static_branch_likely(&sched_uclamp_used);
 }
+
+static inline void enqueue_util_avg_uclamp(struct cfs_rq *cfs_rq,
+					   struct sched_entity *se)
+{
+	unsigned int cfs_val = READ_ONCE(cfs_rq->avg.util_avg_uclamp);
+	unsigned int se_val = READ_ONCE(se->avg.util_avg_uclamp);
+
+	WRITE_ONCE(cfs_rq->avg.util_avg_uclamp, cfs_val + se_val);
+}
+
+static inline void dequeue_util_avg_uclamp(struct cfs_rq *cfs_rq,
+					   struct sched_entity *se)
+{
+	unsigned int cfs_val = READ_ONCE(cfs_rq->avg.util_avg_uclamp);
+	unsigned int se_val = READ_ONCE(se->avg.util_avg_uclamp), new_val;
+
+	if (cfs_val > se_val)
+		new_val = cfs_val - se_val;
+	else {
+		WARN_ONCE(cfs_val < se_val,
+			"CPU %d. cfs_rq %p, cfs_val %u is even less than se_val %u before subtraction\n",
+			rq_of(cfs_rq)->cpu, cfs_rq, cfs_val, se_val);
+		new_val = 0;
+	}
+
+	WRITE_ONCE(cfs_rq->avg.util_avg_uclamp, new_val);
+}
 #else /* CONFIG_UCLAMP_TASK */
 static inline unsigned long uclamp_eff_value(struct task_struct *p,
 					     enum uclamp_id clamp_id)
@@ -3175,6 +3202,16 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 {
 	return false;
 }
+
+static inline void enqueue_util_avg_uclamp(struct cfs_rq *cfs_rq,
+					   struct sched_entity *se)
+{
+}
+
+static inline void dequeue_util_avg_uclamp(struct cfs_rq *cfs_rq,
+					   struct sched_entity *se)
+{
+}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-- 
2.34.1

