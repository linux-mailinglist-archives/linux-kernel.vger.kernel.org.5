Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03208777116
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjHJHLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHJHLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:11:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5445E64;
        Thu, 10 Aug 2023 00:10:59 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:10:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691651458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1tZypen7ca+yZeh4hkBufKdnJLwlegNhzYZM0avIvw=;
        b=f/gpMIdVBBeteaQ1muuhEndbD7q0cOO0W5BfHdWq4H6UZxo5Bqu3RrnWAzDoeY0+kEgSYt
        m+wcgzOTPM1KYZ5dAovsioxES/ZRcycigXh8546UqFt5JrfQZjPwjmH4gIPd6L3RfY7dGa
        Pyxi1/ubGXVVjJhbyaVqSrZY0EqTdZ6Sc1nPWhwQgR+ybxw2MF8ra6ziX9ixfSb+IgWZu8
        jg4mcIF//HWKtgriri9Dm7yxDNCe7x9SOLjqEPZIFhbNTDLMBdVbAMuR0CeaSMGhq6XMHh
        zzi8H/wBV4FXqdq3keP0cgZlKfY5k3R1eww1KMH46LJOG08qb8H0jMRVzB0xgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691651458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1tZypen7ca+yZeh4hkBufKdnJLwlegNhzYZM0avIvw=;
        b=MQioYNehOoTyjmpcmVZYrWvmKUaqCjTJt6MqwVoaCkAI+537ychZShhTVBmYH9tjC1uiPe
        n/teaHeYmUcejFDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add lag based placement
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531124603.794929315@infradead.org>
References: <20230531124603.794929315@infradead.org>
MIME-Version: 1.0
Message-ID: <169165145788.27769.5271183004663340258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     86bfbb7ce4f67a88df2639198169b685668e7349
Gitweb:        https://git.kernel.org/tip/86bfbb7ce4f67a88df2639198169b685668e7349
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 13:58:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Jul 2023 09:43:58 +02:00

sched/fair: Add lag based placement

With the introduction of avg_vruntime, it is possible to approximate
lag (the entire purpose of introducing it in fact). Use this to do lag
based placement over sleep+wake.

Specifically, the FAIR_SLEEPERS thing places things too far to the
left and messes up the deadline aspect of EEVDF.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230531124603.794929315@infradead.org
---
 include/linux/sched.h   |   3 +-
 kernel/sched/core.c     |   1 +-
 kernel/sched/fair.c     | 168 ++++++++++++++++++++++++++++++---------
 kernel/sched/features.h |   8 ++-
 4 files changed, 141 insertions(+), 39 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2aab7be..ba1828b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -554,8 +554,9 @@ struct sched_entity {
 
 	u64				exec_start;
 	u64				sum_exec_runtime;
-	u64				vruntime;
 	u64				prev_sum_exec_runtime;
+	u64				vruntime;
+	s64				vlag;
 
 	u64				nr_migrations;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83e3654..84b0d47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4501,6 +4501,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.prev_sum_exec_runtime	= 0;
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
+	p->se.vlag			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc43482..dd12ada 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -715,6 +715,15 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 	return cfs_rq->min_vruntime + avg;
 }
 
+/*
+ * lag_i = S - s_i = w_i * (V - v_i)
+ */
+void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	SCHED_WARN_ON(!se->on_rq);
+	se->vlag = avg_vruntime(cfs_rq) - se->vruntime;
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	u64 min_vruntime = cfs_rq->min_vruntime;
@@ -3492,6 +3501,8 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
+	unsigned long old_weight = se->load.weight;
+
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
@@ -3504,6 +3515,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	update_load_set(&se->load, weight);
 
+	if (!se->on_rq) {
+		/*
+		 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
+		 * we need to scale se->vlag when w_i changes.
+		 */
+		se->vlag = div_s64(se->vlag * old_weight, weight);
+	}
+
 #ifdef CONFIG_SMP
 	do {
 		u32 divider = get_pelt_divider(&se->avg);
@@ -4853,49 +4872,119 @@ static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = avg_vruntime(cfs_rq);
+	s64 lag = 0;
 
-	/* sleeps up to a single latency don't count. */
-	if (!initial) {
-		unsigned long thresh;
+	/*
+	 * Due to how V is constructed as the weighted average of entities,
+	 * adding tasks with positive lag, or removing tasks with negative lag
+	 * will move 'time' backwards, this can screw around with the lag of
+	 * other tasks.
+	 *
+	 * EEVDF: placement strategy #1 / #2
+	 */
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
+		struct sched_entity *curr = cfs_rq->curr;
+		unsigned long load;
 
-		if (se_is_idle(se))
-			thresh = sysctl_sched_min_granularity;
-		else
-			thresh = sysctl_sched_latency;
+		lag = se->vlag;
 
 		/*
-		 * Halve their sleep time's effect, to allow
-		 * for a gentler effect of sleepers:
+		 * If we want to place a task and preserve lag, we have to
+		 * consider the effect of the new entity on the weighted
+		 * average and compensate for this, otherwise lag can quickly
+		 * evaporate.
+		 *
+		 * Lag is defined as:
+		 *
+		 *   lag_i = S - s_i = w_i * (V - v_i)
+		 *
+		 * To avoid the 'w_i' term all over the place, we only track
+		 * the virtual lag:
+		 *
+		 *   vl_i = V - v_i <=> v_i = V - vl_i
+		 *
+		 * And we take V to be the weighted average of all v:
+		 *
+		 *   V = (\Sum w_j*v_j) / W
+		 *
+		 * Where W is: \Sum w_j
+		 *
+		 * Then, the weighted average after adding an entity with lag
+		 * vl_i is given by:
+		 *
+		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
+		 *      = (W*V + w_i*(V - vl_i)) / (W + w_i)
+		 *      = (W*V + w_i*V - w_i*vl_i) / (W + w_i)
+		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
+		 *      = V - w_i*vl_i / (W + w_i)
+		 *
+		 * And the actual lag after adding an entity with vl_i is:
+		 *
+		 *   vl'_i = V' - v_i
+		 *         = V - w_i*vl_i / (W + w_i) - (V - vl_i)
+		 *         = vl_i - w_i*vl_i / (W + w_i)
+		 *
+		 * Which is strictly less than vl_i. So in order to preserve lag
+		 * we should inflate the lag before placement such that the
+		 * effective lag after placement comes out right.
+		 *
+		 * As such, invert the above relation for vl'_i to get the vl_i
+		 * we need to use such that the lag after placement is the lag
+		 * we computed before dequeue.
+		 *
+		 *   vl'_i = vl_i - w_i*vl_i / (W + w_i)
+		 *         = ((W + w_i)*vl_i - w_i*vl_i) / (W + w_i)
+		 *
+		 *   (W + w_i)*vl'_i = (W + w_i)*vl_i - w_i*vl_i
+		 *                   = W*vl_i
+		 *
+		 *   vl_i = (W + w_i)*vl'_i / W
 		 */
-		if (sched_feat(GENTLE_FAIR_SLEEPERS))
-			thresh >>= 1;
-
-		vruntime -= thresh;
-	}
-
-	/*
-	 * Pull vruntime of the entity being placed to the base level of
-	 * cfs_rq, to prevent boosting it if placed backwards.
-	 * However, min_vruntime can advance much faster than real time, with
-	 * the extreme being when an entity with the minimal weight always runs
-	 * on the cfs_rq. If the waking entity slept for a long time, its
-	 * vruntime difference from min_vruntime may overflow s64 and their
-	 * comparison may get inversed, so ignore the entity's original
-	 * vruntime in that case.
-	 * The maximal vruntime speedup is given by the ratio of normal to
-	 * minimal weight: scale_load_down(NICE_0_LOAD) / MIN_SHARES.
-	 * When placing a migrated waking entity, its exec_start has been set
-	 * from a different rq. In order to take into account a possible
-	 * divergence between new and prev rq's clocks task because of irq and
-	 * stolen time, we take an additional margin.
-	 * So, cutting off on the sleep time of
-	 *     2^63 / scale_load_down(NICE_0_LOAD) ~ 104 days
-	 * should be safe.
-	 */
-	if (entity_is_long_sleeper(se))
-		se->vruntime = vruntime;
-	else
-		se->vruntime = max_vruntime(se->vruntime, vruntime);
+		load = cfs_rq->avg_load;
+		if (curr && curr->on_rq)
+			load += curr->load.weight;
+
+		lag *= load + se->load.weight;
+		if (WARN_ON_ONCE(!load))
+			load = 1;
+		lag = div_s64(lag, load);
+
+		vruntime -= lag;
+	}
+
+	if (sched_feat(FAIR_SLEEPERS)) {
+
+		/* sleeps up to a single latency don't count. */
+		if (!initial) {
+			unsigned long thresh;
+
+			if (se_is_idle(se))
+				thresh = sysctl_sched_min_granularity;
+			else
+				thresh = sysctl_sched_latency;
+
+			/*
+			 * Halve their sleep time's effect, to allow
+			 * for a gentler effect of sleepers:
+			 */
+			if (sched_feat(GENTLE_FAIR_SLEEPERS))
+				thresh >>= 1;
+
+			vruntime -= thresh;
+		}
+
+		/*
+		 * Pull vruntime of the entity being placed to the base level of
+		 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
+		 * slept for a long time, don't even try to compare its vruntime with
+		 * the base as it may be too far off and the comparison may get
+		 * inversed due to s64 overflow.
+		 */
+		if (!entity_is_long_sleeper(se))
+			vruntime = max_vruntime(se->vruntime, vruntime);
+	}
+
+	se->vruntime = vruntime;
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
@@ -5077,6 +5166,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	clear_buddies(cfs_rq, se);
 
+	if (flags & DEQUEUE_SLEEP)
+		update_entity_lag(cfs_rq, se);
+
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 	se->on_rq = 0;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index fa828b3..7958a10 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -1,12 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Only give sleepers 50% of their service deficit. This allows
  * them to run sooner, but does not allow tons of sleepers to
  * rip the spread apart.
  */
+SCHED_FEAT(FAIR_SLEEPERS, false)
 SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
 
 /*
+ * Using the avg_vruntime, do the right thing and preserve lag across
+ * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
+ */
+SCHED_FEAT(PLACE_LAG, true)
+
+/*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we
  * touched, increases cache locality.
