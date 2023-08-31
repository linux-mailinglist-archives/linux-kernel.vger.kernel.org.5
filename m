Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6278F403
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344765AbjHaUaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347386AbjHaU35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AEAE5F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E5862BA6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDBFC433C8;
        Thu, 31 Aug 2023 20:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693513791;
        bh=QXStic4MSsKYlc1Pov7Gq0PWROsNHrJdpMwrKetBrjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9HHDcjrWGDeKiC0BHj3oWVPP45TULmHuPIoTwlhl1QUbrOyTgWn/aZlJRXN7UuKv
         uTjzlcPNOY8cz5uM3bkdCaVtwMTRl7iGJkPXTGdr3/kr40uxO2Tms/wZaxWVmlVuYG
         k6guUGRJmHIuh6Y5KpCdKo/zDthW4q7h0S85oXZz32bu6nDZt2P5vJFxcSVPaqlnIg
         dTeATwyF5l4ABooFq/9SR5nyLo7H1LEbfGxpc3dHwWmDpFBk7b+xlJhZlpRWbj3urN
         o9O9UT/aQUCRfP5yGh7qgrnng+RyKm9H3cH2eXz6s6MFv0xBfRl6g4S3NUZGYn31o7
         CLS0mhrn9WJGw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, bristot@kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v4 3/7] sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity
Date:   Thu, 31 Aug 2023 22:28:54 +0200
Message-Id: <25f974670a672d1c4ee98eb13ad6a4ab289ed33a.1693510979.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1693510979.git.bristot@kernel.org>
References: <cover.1693510979.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation of introducing !task sched_dl_entity; move the
bandwidth accounting into {en.de}queue_dl_entity().

Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/deadline.c | 130 ++++++++++++++++++++++------------------
 kernel/sched/sched.h    |   6 ++
 2 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f8c402079404..957baaf6dc92 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -391,12 +391,12 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se);
  * up, and checks if the task is still in the "ACTIVE non contending"
  * state or not (in the second case, it updates running_bw).
  */
-static void task_non_contending(struct task_struct *p)
+static void task_non_contending(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
 	struct hrtimer *timer = &dl_se->inactive_timer;
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct task_struct *p = dl_task_of(dl_se);
 	s64 zerolag_time;
 
 	/*
@@ -428,13 +428,14 @@ static void task_non_contending(struct task_struct *p)
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
+
 		if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
 			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
 			if (READ_ONCE(p->__state) == TASK_DEAD)
-				sub_rq_bw(&p->dl, &rq->dl);
+				sub_rq_bw(dl_se, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
-			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
+			__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
 			raw_spin_unlock(&dl_b->lock);
 			__dl_clear_params(dl_se);
 		}
@@ -1627,6 +1628,41 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 
 	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
 
+	/*
+	 * Check if a constrained deadline task was activated
+	 * after the deadline but before the next period.
+	 * If that is the case, the task will be throttled and
+	 * the replenishment timer will be set to the next period.
+	 */
+	if (!dl_se->dl_throttled && !dl_is_implicit(dl_se))
+		dl_check_constrained_dl(dl_se);
+
+	if (flags & (ENQUEUE_RESTORE|ENQUEUE_MIGRATING)) {
+		struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+
+		add_rq_bw(dl_se, dl_rq);
+		add_running_bw(dl_se, dl_rq);
+	}
+
+	/*
+	 * If p is throttled, we do not enqueue it. In fact, if it exhausted
+	 * its budget it needs a replenishment and, since it now is on
+	 * its rq, the bandwidth timer callback (which clearly has not
+	 * run yet) will take care of this.
+	 * However, the active utilization does not depend on the fact
+	 * that the task is on the runqueue or not (but depends on the
+	 * task's state - in GRUB parlance, "inactive" vs "active contending").
+	 * In other words, even if a task is throttled its utilization must
+	 * be counted in the active utilization; hence, we need to call
+	 * add_running_bw().
+	 */
+	if (dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
+		if (flags & ENQUEUE_WAKEUP)
+			task_contending(dl_se, flags);
+
+		return;
+	}
+
 	/*
 	 * If this is a wakeup or a new instance, the scheduling
 	 * parameters of the task might need updating. Otherwise,
@@ -1646,9 +1682,28 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	__enqueue_dl_entity(dl_se);
 }
 
-static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
+static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
 	__dequeue_dl_entity(dl_se);
+
+	if (flags & (DEQUEUE_SAVE|DEQUEUE_MIGRATING)) {
+		struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+
+		sub_running_bw(dl_se, dl_rq);
+		sub_rq_bw(dl_se, dl_rq);
+	}
+
+	/*
+	 * This check allows to start the inactive timer (or to immediately
+	 * decrease the active utilization, if needed) in two cases:
+	 * when the task blocks and when it is terminating
+	 * (p->state == TASK_DEAD). We can handle the two cases in the same
+	 * way, because from GRUB's point of view the same thing is happening
+	 * (the task moves from "active contending" to "active non contending"
+	 * or "inactive")
+	 */
+	if (flags & DEQUEUE_SLEEP)
+		task_non_contending(dl_se);
 }
 
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
@@ -1693,76 +1748,35 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		return;
 	}
 
-	/*
-	 * Check if a constrained deadline task was activated
-	 * after the deadline but before the next period.
-	 * If that is the case, the task will be throttled and
-	 * the replenishment timer will be set to the next period.
-	 */
-	if (!p->dl.dl_throttled && !dl_is_implicit(&p->dl))
-		dl_check_constrained_dl(&p->dl);
-
-	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & ENQUEUE_RESTORE) {
-		add_rq_bw(&p->dl, &rq->dl);
-		add_running_bw(&p->dl, &rq->dl);
-	}
-
-	/*
-	 * If p is throttled, we do not enqueue it. In fact, if it exhausted
-	 * its budget it needs a replenishment and, since it now is on
-	 * its rq, the bandwidth timer callback (which clearly has not
-	 * run yet) will take care of this.
-	 * However, the active utilization does not depend on the fact
-	 * that the task is on the runqueue or not (but depends on the
-	 * task's state - in GRUB parlance, "inactive" vs "active contending").
-	 * In other words, even if a task is throttled its utilization must
-	 * be counted in the active utilization; hence, we need to call
-	 * add_running_bw().
-	 */
-	if (p->dl.dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
-		if (flags & ENQUEUE_WAKEUP)
-			task_contending(&p->dl, flags);
-
-		return;
-	}
-
 	check_schedstat_required();
 	update_stats_wait_start_dl(dl_rq_of_se(&p->dl), &p->dl);
 
+	if (p->on_rq == TASK_ON_RQ_MIGRATING)
+		flags |= ENQUEUE_MIGRATING;
+
 	enqueue_dl_entity(&p->dl, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && !p->dl.dl_throttled && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
 
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_stats_dequeue_dl(&rq->dl, &p->dl, flags);
-	dequeue_dl_entity(&p->dl);
-	dequeue_pushable_dl_task(rq, p);
+	dequeue_dl_entity(&p->dl, flags);
+
+	if (!p->dl.dl_throttled)
+		dequeue_pushable_dl_task(rq, p);
 }
 
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
-	__dequeue_task_dl(rq, p, flags);
 
-	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & DEQUEUE_SAVE) {
-		sub_running_bw(&p->dl, &rq->dl);
-		sub_rq_bw(&p->dl, &rq->dl);
-	}
+	if (p->on_rq == TASK_ON_RQ_MIGRATING)
+		flags |= DEQUEUE_MIGRATING;
 
-	/*
-	 * This check allows to start the inactive timer (or to immediately
-	 * decrease the active utilization, if needed) in two cases:
-	 * when the task blocks and when it is terminating
-	 * (p->state == TASK_DEAD). We can handle the two cases in the same
-	 * way, because from GRUB's point of view the same thing is happening
-	 * (the task moves from "active contending" to "active non contending"
-	 * or "inactive")
-	 */
-	if (flags & DEQUEUE_SLEEP)
-		task_non_contending(p);
+	__dequeue_task_dl(rq, p, flags);
 }
 
 /*
@@ -2578,7 +2592,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	 * will reset the task parameters.
 	 */
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
-		task_non_contending(p);
+		task_non_contending(&p->dl);
 
 	/*
 	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5e0df4bba476..9f48ed3e9028 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2193,6 +2193,10 @@ extern const u32		sched_prio_to_wmult[40];
  * MOVE - paired with SAVE/RESTORE, explicitly does not preserve the location
  *        in the runqueue.
  *
+ * NOCLOCK - skip the update_rq_clock() (avoids double updates)
+ *
+ * MIGRATION - p->on_rq == TASK_ON_RQ_MIGRATING (used for DEADLINE)
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
@@ -2203,6 +2207,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
+#define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
@@ -2217,6 +2222,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define ENQUEUE_MIGRATED	0x00
 #endif
 #define ENQUEUE_INITIAL		0x80
+#define ENQUEUE_MIGRATING	0x100
 
 #define RETRY_TASK		((void *)-1UL)
 
-- 
2.40.1

