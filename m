Return-Path: <linux-kernel+bounces-48205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D8845894
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DA21F27B14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215885336E;
	Thu,  1 Feb 2024 13:12:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CB5B68D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793145; cv=none; b=GaIrfsPsfil384E+jKhrhlocEgLhcm7WQTjYyATEvzTwPHaWTi96vT326KaYi/Cf21ntNvnfMVD6HjYPTq0R1K+C0YX4wyUdF64Wxw7P5g7q7o4ArrhSla/8vwwXe/lBm4WBXW3J4slGnGL+GPDknJMkwq6/FX13a4eyz5e3MSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793145; c=relaxed/simple;
	bh=MF8KG6hTtTJAn69SRdLKWSXk+01l8dQMQa0VhYm+Aq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtV9RW0yZDshgoKzx8QT8brFjmjFZV3HvriB39KrBABdYSbGf5LHiZYN0/Q/ngKYKAVu0sbHCdSQ0STFca2z8EAYP3TVQQMgoN3TJKs/hU2fVQA53uB8Hvhwyl+n5p8k7iT+aVwkKRBFBObyXfe4F6bcdHVvtpwvOY71MNeadqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B7E01762;
	Thu,  1 Feb 2024 05:13:04 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FDE43F762;
	Thu,  1 Feb 2024 05:12:19 -0800 (PST)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org,
	David Dai <davidai@google.com>,
	Saravana Kannan <saravanak@google.com>
Subject: [RFC PATCH v2 3/7] sched/uclamp: Introduce root_cfs_util_uclamp for rq
Date: Thu,  1 Feb 2024 13:11:59 +0000
Message-Id: <68fbd0c0bb7e2ef7a80e7359512672a235a963b1.1706792708.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706792708.git.hongyan.xia2@arm.com>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The problem with rq->cfs.avg.util_avg_uclamp is that it only tracks the
sum of contributions of CFS tasks that are on the rq. However, CFS tasks
that belong to a CPU which were just dequeued from the rq->cfs still
have decaying contributions to the rq utilization due to PELT. Introduce
root_cfs_util_uclamp to capture the total utilization of CFS tasks both
on and off this rq.

Theoretically, keeping track of the sum of all tasks on a CPU (either on
or off the rq) requires us to periodically sample the decaying PELT
utilization of all off-rq tasks and then sum them up, which introduces
substantial extra code and overhead. However, we can avoid the overhead,
shown in this example:

Let's assume 3 tasks, A, B and C. A is still on rq->cfs but B and C have
just been dequeued. The cfs.avg.util_avg_uclamp has dropped from A + B +
C to just A but the instantaneous utilization only just starts to decay
and is now still A + B + C. Let's denote root_cfs_util_uclamp_old as the
instantaneous total utilization right before B and C are dequeued.

After p periods, with y being the decay factor, the new
root_cfs_util_uclamp becomes:

root_cfs_util_uclamp
    = A + B * y^p + C * y^p
    = A + (A + B + C - A) * y^p
    = cfs.avg.util_avg_uclamp +
        (root_cfs_util_uclamp_old - cfs.avg.util_avg_uclamp) * y^p
    = cfs.avg.util_avg_uclamp + diff * y^p

So, whenever we want to calculate the new root_cfs_util_uclamp
(including both on- and off-rq CFS tasks of a CPU), we could just decay
the diff between root_cfs_util_uclamp and cfs.avg.util_avg_uclamp, and
add the decayed diff to cfs.avg.util_avg_uclamp to obtain the new
root_cfs_util_uclamp, without bothering to periodically sample off-rq
CFS tasks and sum them up. This significantly reduces the overhead
needed to maintain this signal, and makes sure we now also include the
decaying contributions of CFS tasks that are dequeued.

NOTE: In no way do we change how PELT and util_avg work. The original
PELT signal is kept as-is and is used when needed. The new signals,
util_avg_uclamp and root_cfs_util_uclamp are additional hints to the
scheduler and are not meant to replace the original PELT signals.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c  |   7 +++
 kernel/sched/pelt.c  | 106 +++++++++++++++++++++++++++++++++++++++----
 kernel/sched/pelt.h  |   3 +-
 kernel/sched/sched.h |  16 +++++++
 4 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4f535c96463b..36357cfaf48d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6710,6 +6710,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
+	bool __maybe_unused migrated = p->se.avg.last_update_time == 0;
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -6769,6 +6770,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 #ifdef CONFIG_UCLAMP_TASK
 	util_uclamp_enqueue(&rq->cfs.avg, p);
 	update_util_uclamp(0, 0, 0, &rq->cfs.avg, p);
+	if (migrated)
+		rq->root_cfs_util_uclamp += p->se.avg.util_avg_uclamp;
+	rq->root_cfs_util_uclamp = max(rq->root_cfs_util_uclamp,
+				       rq->cfs.avg.util_avg_uclamp);
 	/* TODO: Better skip the frequency update in the for loop above. */
 	cpufreq_update_util(rq, 0);
 #endif
@@ -8252,6 +8257,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		migrate_se_pelt_lag(se);
 	}
 
+	remove_root_cfs_util_uclamp(p);
 	/* Tell new CPU we are migrated */
 	se->avg.last_update_time = 0;
 
@@ -8261,6 +8267,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 static void task_dead_fair(struct task_struct *p)
 {
 	remove_entity_load_avg(&p->se);
+	remove_root_cfs_util_uclamp(p);
 }
 
 static int
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index eca45a863f9f..9ba208ac26db 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -267,14 +267,78 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
+static int ___update_util_uclamp_towards(u64 now,
+					 u64 last_update_time,
+					 u32 period_contrib,
+					 unsigned int *old,
+					 unsigned int new_val)
+{
+	unsigned int old_val = READ_ONCE(*old);
+	u64 delta, periods;
+
+	if (old_val <= new_val) {
+		WRITE_ONCE(*old, new_val);
+		return old_val < new_val;
+	}
+
+	if (!last_update_time)
+		return 0;
+	delta = now - last_update_time;
+	if ((s64)delta < 0)
+		return 0;
+	delta >>= 10;
+	if (!delta)
+		return 0;
+
+	delta += period_contrib;
+	periods = delta / 1024;
+	if (periods) {
+		u64 diff = old_val - new_val;
+
+		/*
+		 * Let's assume 3 tasks, A, B and C. A is still on rq but B and
+		 * C have just been dequeued. The cfs.avg.util_avg_uclamp has
+		 * become A but root_cfs_util_uclamp just starts to decay and is
+		 * now still A + B + C.
+		 *
+		 * After p periods with y being the decay factor, the new
+		 * root_cfs_util_uclamp should become
+		 *
+		 * A + B * y^p + C * y^p == A + (A + B + C - A) * y^p
+		 *     == cfs.avg.util_avg_uclamp +
+		 *        (root_cfs_util_uclamp_at_the_start - cfs.avg.util_avg_uclamp) * y^p
+		 *     == cfs.avg.util_avg_uclamp + diff * y^p
+		 *
+		 * So, instead of summing up each individual decayed values, we
+		 * could just decay the diff and not bother with the summation
+		 * at all. This is why we decay the diff here.
+		 */
+		diff = decay_load(diff, periods);
+		WRITE_ONCE(*old, new_val + diff);
+		return old_val != *old;
+	}
+
+	return 0;
+}
+
 /* avg must belong to the queue this se is on. */
-void update_util_uclamp(struct sched_avg *avg, struct task_struct *p)
+void update_util_uclamp(u64 now,
+			u64 last_update_time,
+			u32 period_contrib,
+			struct sched_avg *avg,
+			struct task_struct *p)
 {
 	unsigned int util, uclamp_min, uclamp_max;
 	int delta;
 
-	if (!p->se.on_rq)
+	if (!p->se.on_rq) {
+		___update_util_uclamp_towards(now,
+					      last_update_time,
+					      period_contrib,
+					      &p->se.avg.util_avg_uclamp,
+					      0);
 		return;
+	}
 
 	if (!avg)
 		return;
@@ -294,7 +358,11 @@ void update_util_uclamp(struct sched_avg *avg, struct task_struct *p)
 	WRITE_ONCE(avg->util_avg_uclamp, util);
 }
 #else /* !CONFIG_UCLAMP_TASK */
-void update_util_uclamp(struct sched_avg *avg, struct task_struct *p)
+void update_util_uclamp(u64 now,
+			u64 last_update_time,
+			u32 period_contrib,
+			struct sched_avg *avg,
+			struct task_struct *p)
 {
 }
 #endif
@@ -327,23 +395,32 @@ void update_util_uclamp(struct sched_avg *avg, struct task_struct *p)
 
 void __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
+	u64 last_update_time = se->avg.last_update_time;
+	u32 period_contrib = se->avg.period_contrib;
+
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se));
 		if (entity_is_task(se))
-			update_util_uclamp(NULL, task_of(se));
+			update_util_uclamp(now, last_update_time,
+					   period_contrib, NULL, task_of(se));
 		trace_pelt_se_tp(se);
 	}
 }
 
 void __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	u64 last_update_time = se->avg.last_update_time;
+	u32 period_contrib = se->avg.period_contrib;
+
 	if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
 				cfs_rq->curr == se)) {
 
 		___update_load_avg(&se->avg, se_weight(se));
 		cfs_se_util_change(&se->avg);
 		if (entity_is_task(se))
-			update_util_uclamp(&rq_of(cfs_rq)->cfs.avg,
+			update_util_uclamp(now, last_update_time,
+					   period_contrib,
+					   &rq_of(cfs_rq)->cfs.avg,
 					   task_of(se));
 		trace_pelt_se_tp(se);
 	}
@@ -351,17 +428,30 @@ void __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *s
 
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
+	u64 __maybe_unused last_update_time = cfs_rq->avg.last_update_time;
+	u32 __maybe_unused period_contrib = cfs_rq->avg.period_contrib;
+	int ret = 0;
+
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
 				cfs_rq->h_nr_running,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
-		trace_pelt_cfs_tp(cfs_rq);
-		return 1;
+		ret = 1;
 	}
 
-	return 0;
+#ifdef CONFIG_UCLAMP_TASK
+	if (&rq_of(cfs_rq)->cfs == cfs_rq)
+		ret = ___update_util_uclamp_towards(now,
+				last_update_time, period_contrib,
+				&rq_of(cfs_rq)->root_cfs_util_uclamp,
+				READ_ONCE(cfs_rq->avg.util_avg_uclamp));
+#endif
+	if (ret)
+		trace_pelt_cfs_tp(cfs_rq);
+
+	return ret;
 }
 
 /*
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 6862f79e0fcd..a2852d5e862d 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -1,7 +1,8 @@
 #ifdef CONFIG_SMP
 #include "sched-pelt.h"
 
-void update_util_uclamp(struct sched_avg *avg, struct task_struct *p);
+void update_util_uclamp(u64 now, u64 last_update_time, u32 period_contrib,
+			struct sched_avg *avg, struct task_struct *p);
 void __update_load_avg_blocked_se(u64 now, struct sched_entity *se);
 void __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se);
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 35036246824b..ce80b87b549b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -998,6 +998,7 @@ struct rq {
 	/* Utilization clamp values based on CPU's RUNNABLE tasks */
 	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
 	unsigned int		uclamp_flags;
+	unsigned int		root_cfs_util_uclamp;
 #define UCLAMP_FLAG_IDLE 0x01
 #endif
 
@@ -3112,6 +3113,17 @@ static inline void util_uclamp_dequeue(struct sched_avg *avg,
 
 	WRITE_ONCE(avg->util_avg_uclamp, new_val);
 }
+
+static inline void remove_root_cfs_util_uclamp(struct task_struct *p)
+{
+	struct rq *rq = task_rq(p);
+	unsigned int root_util = READ_ONCE(rq->root_cfs_util_uclamp);
+	unsigned int p_util = READ_ONCE(p->se.avg.util_avg_uclamp), new_util;
+
+	new_util = (root_util > p_util) ? root_util - p_util : 0;
+	new_util = max(new_util, READ_ONCE(rq->cfs.avg.util_avg_uclamp));
+	WRITE_ONCE(rq->root_cfs_util_uclamp, new_util);
+}
 #else /* CONFIG_UCLAMP_TASK */
 static inline unsigned long uclamp_eff_value(struct task_struct *p,
 					     enum uclamp_id clamp_id)
@@ -3147,6 +3159,10 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 {
 	return false;
 }
+
+static inline void remove_root_cfs_util_uclamp(struct task_struct *p)
+{
+}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-- 
2.34.1


