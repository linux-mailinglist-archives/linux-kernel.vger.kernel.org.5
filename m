Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FD27EC152
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjKOLeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjKOLd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:33:59 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED369CC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:33:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VwSxxO8_1700048033;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VwSxxO8_1700048033)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 19:33:53 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sched/core: fix cfs_prio_less
Date:   Wed, 15 Nov 2023 19:33:41 +0800
Message-Id: <20231115113341.13261-5-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231115113341.13261-1-CruzZhao@linux.alibaba.com>
References: <20231115113341.13261-1-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The update of vruntime snapshot will cause unfair sched, especially when
tasks enqueue/dequeue frequently.

Consider the following case:
 - Task A1 and A2 share a cookie, and task B has another cookie.
 - A1 is a short task, waking up frequently but running short everytime.
 - A2 and B are long tasks.
 - A1 and B runs on ht0 and A2 runs on ht1.

ht0			ht1		fi_before	fi	update
switch to A1		switch to A2	0		0	1
A1 sleeps
switch to B		A2 force idle	0		1	1
A1 wakes up
switch to A1		switch to A1	1		0	1
A1 sleeps
switch to B		A2 force idle	0		1	1

In this case, cfs_rq->min_vruntime_fi will update every schedule, and
prio of B and A2 will be pulled to the same level, no matter how long A2
and B have run before, which is not fair enough. Extramely, we observed
that the latency of a task became several minutes due to this reason,
which should be 100ms.

To fix this problem, we compare the priority of ses using core_vruntime
directly, instead of vruntime snapshot.

Fixes: c6047c2e3af6 ("sched/fair: Snapshot the min_vruntime of CPUs on force idle")
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core.c  | 17 -----------------
 kernel/sched/fair.c  | 35 +----------------------------------
 kernel/sched/sched.h |  2 --
 3 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 647a12af9172..22edf4bcc7e8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6052,8 +6052,6 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	BUG(); /* The idle class should always have a runnable task. */
 }
 
-extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
-
 static void queue_core_balance(struct rq *rq);
 
 static struct task_struct *
@@ -6154,7 +6152,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 * unconstrained picks as well.
 			 */
 			WARN_ON_ONCE(fi_before);
-			task_vruntime_update(rq, next, false);
 			goto out_set_next;
 		}
 	}
@@ -6204,8 +6201,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (p == rq_i->idle) {
 			if (rq_i->nr_running) {
 				rq->core->core_forceidle_count++;
-				if (!fi_before)
-					rq->core->core_forceidle_seq++;
 			}
 		} else {
 			occ++;
@@ -6245,17 +6240,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (!rq_i->core_pick)
 			continue;
 
-		/*
-		 * Update for new !FI->FI transitions, or if continuing to be in !FI:
-		 * fi_before     fi      update?
-		 *  0            0       1
-		 *  0            1       1
-		 *  1            0       1
-		 *  1            1       0
-		 */
-		if (!(fi_before && rq->core->core_forceidle_count))
-			task_vruntime_update(rq_i, rq_i->core_pick, !!rq->core->core_forceidle_count);
-
 		rq_i->core_pick->core_occupation = occ;
 
 		if (i == cpu) {
@@ -6474,7 +6458,6 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	core_rq->core_pick_seq             = rq->core_pick_seq;
 	core_rq->core_cookie               = rq->core_cookie;
 	core_rq->core_forceidle_count      = rq->core_forceidle_count;
-	core_rq->core_forceidle_seq        = rq->core_forceidle_seq;
 	core_rq->core_forceidle_occupation = rq->core_forceidle_occupation;
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 60b2fd437474..15c350b7c34a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12382,35 +12382,6 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 		resched_curr(rq);
 }
 
-/*
- * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
- */
-static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,
-			 bool forceidle)
-{
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-		if (forceidle) {
-			if (cfs_rq->forceidle_seq == fi_seq)
-				break;
-			cfs_rq->forceidle_seq = fi_seq;
-		}
-
-		cfs_rq->min_vruntime_fi = cfs_rq->min_vruntime;
-	}
-}
-
-void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
-{
-	struct sched_entity *se = &p->se;
-
-	if (p->sched_class != &fair_sched_class)
-		return;
-
-	se_fi_update(se, rq->core->core_forceidle_seq, in_fi);
-}
-
 bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 			bool in_fi)
 {
@@ -12438,9 +12409,6 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 			seb = parent_entity(seb);
 	}
 
-	se_fi_update(sea, rq->core->core_forceidle_seq, in_fi);
-	se_fi_update(seb, rq->core->core_forceidle_seq, in_fi);
-
 	cfs_rqa = sea->cfs_rq;
 	cfs_rqb = seb->cfs_rq;
 #else
@@ -12453,8 +12421,7 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 	 * min_vruntime_fi, which would have been updated in prior calls
 	 * to se_fi_update().
 	 */
-	delta = (s64)(sea->vruntime - seb->vruntime) +
-		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
+	delta = (s64)(sea->core_vruntime - seb->core_vruntime);
 
 	return delta > 0;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f9d3701481f1..2ac89eb20973 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -546,7 +546,6 @@ struct cfs_rq {
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
 	u64			core_min_vruntime;
-	unsigned int		forceidle_seq;
 	u64			min_vruntime_fi;
 	struct cfs_rq		*core;
 #endif
@@ -1134,7 +1133,6 @@ struct rq {
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
 	unsigned int		core_forceidle_count;
-	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
 #endif
-- 
2.39.3

