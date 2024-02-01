Return-Path: <linux-kernel+bounces-48204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A591845893
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8031C25697
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB95B69C;
	Thu,  1 Feb 2024 13:12:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDD75338E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793141; cv=none; b=dVyAFyDM0Vvwa9pxfpoNBehs3sF9Hs1W/bLlxDbGcCBjJGA/JFU5rcxPIMSb/KVwijlomIzZwJL5YEGqkdc1KO0kQKqLGW2rAXzo4pxYl6bv1kEARP75Ux5YLmlS+ESeXY3AwUujg9f/tnZ6DOtN8qUNrqfEI5nwF61h5/7X8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793141; c=relaxed/simple;
	bh=8GQcDzINuKnM88L0X3+SWU8VavTC8VBBqvmgixz9hgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+6adyVFjTFjPDJrbUd/eUf6I6ASsUO3enuvgnWJKtfGWPn737JomBZB30EBDanI2BMnoj38ZsZNjcJs0vPzu4p3u9lY6r1+9NTbHQBqf0LeP0Sp2axFre3gqlMuFHrlX+em9ondIidq435YVR9d/EWzKhOkCF9UFfj6qAHKvlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D99C7175D;
	Thu,  1 Feb 2024 05:13:00 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19CCD3F762;
	Thu,  1 Feb 2024 05:12:15 -0800 (PST)
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
Subject: [RFC PATCH v2 2/7] sched/uclamp: Track uclamped util_avg in sched_avg
Date: Thu,  1 Feb 2024 13:11:58 +0000
Message-Id: <92b6ffbffa4dd9ac5d27809bb14528183a54c3a3.1706792708.git.hongyan.xia2@arm.com>
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

Track a uclamped version of util_avg in sched_avg, which clamps util_avg
within [uclamp[UCLAMP_MIN], uclamp[UCLAMP_MAX]] every time util_avg is
updated. At the root CFS rq level, just like util_est,
rq->cfs.avg.util_avg_uclamp must always be the sum of all
util_avg_uclamp of CFS tasks on this rq. So, each time the
util_avg_uclamp of a task gets updated, we also track the delta and
update the root cfs_rq. When a CFS task gets enqueued or dequeued, the
rq->cfs.avg.util_avg_uclamp also needs to add or subtract the
util_avg_uclamp of this task.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/fair.c   | 21 +++++++++++++++++++
 kernel/sched/pelt.c   | 48 +++++++++++++++++++++++++++++++++++--------
 kernel/sched/pelt.h   |  5 +++--
 kernel/sched/sched.h  | 27 ++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 03bfe9ab2951..f28eeff169ff 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -470,6 +470,9 @@ struct sched_avg {
 	unsigned long			runnable_avg;
 	unsigned long			util_avg;
 	unsigned int			util_est;
+#ifdef CONFIG_UCLAMP_TASK
+	unsigned int			util_avg_uclamp;
+#endif
 } ____cacheline_aligned;
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d5cc87db4845..4f535c96463b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1089,6 +1089,9 @@ void post_init_entity_util_avg(struct task_struct *p)
 	}
 
 	sa->runnable_avg = sa->util_avg;
+#ifdef CONFIG_UCLAMP_TASK
+	sa->util_avg_uclamp = sa->util_avg;
+#endif
 }
 
 #else /* !CONFIG_SMP */
@@ -6763,6 +6766,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
+#ifdef CONFIG_UCLAMP_TASK
+	util_uclamp_enqueue(&rq->cfs.avg, p);
+	update_util_uclamp(0, 0, 0, &rq->cfs.avg, p);
+	/* TODO: Better skip the frequency update in the for loop above. */
+	cpufreq_update_util(rq, 0);
+#endif
 
 	/*
 	 * Since new tasks are assigned an initial util_avg equal to
@@ -6854,6 +6863,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, 1);
+#ifdef CONFIG_UCLAMP_TASK
+	util_uclamp_dequeue(&rq->cfs.avg, p);
+#endif
 
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
@@ -6862,6 +6874,15 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
index 63b6cf898220..eca45a863f9f 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -266,6 +266,39 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+/* avg must belong to the queue this se is on. */
+void update_util_uclamp(struct sched_avg *avg, struct task_struct *p)
+{
+	unsigned int util, uclamp_min, uclamp_max;
+	int delta;
+
+	if (!p->se.on_rq)
+		return;
+
+	if (!avg)
+		return;
+
+	util = READ_ONCE(p->se.avg.util_avg);
+	uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
+	uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
+	util = clamp(util, uclamp_min, uclamp_max);
+
+	delta = util - READ_ONCE(p->se.avg.util_avg_uclamp);
+	if (delta == 0)
+		return;
+
+	WRITE_ONCE(p->se.avg.util_avg_uclamp, util);
+	util = READ_ONCE(avg->util_avg_uclamp);
+	util += delta;
+	WRITE_ONCE(avg->util_avg_uclamp, util);
+}
+#else /* !CONFIG_UCLAMP_TASK */
+void update_util_uclamp(struct sched_avg *avg, struct task_struct *p)
+{
+}
+#endif
+
 /*
  * sched_entity:
  *
@@ -292,29 +325,28 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *   load_avg = \Sum se->avg.load_avg
  */
 
-int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
+void __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se));
+		if (entity_is_task(se))
+			update_util_uclamp(NULL, task_of(se));
 		trace_pelt_se_tp(se);
-		return 1;
 	}
-
-	return 0;
 }
 
-int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
+void __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
 				cfs_rq->curr == se)) {
 
 		___update_load_avg(&se->avg, se_weight(se));
 		cfs_se_util_change(&se->avg);
+		if (entity_is_task(se))
+			update_util_uclamp(&rq_of(cfs_rq)->cfs.avg,
+					   task_of(se));
 		trace_pelt_se_tp(se);
-		return 1;
 	}
-
-	return 0;
 }
 
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 9e1083465fbc..6862f79e0fcd 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -1,8 +1,9 @@
 #ifdef CONFIG_SMP
 #include "sched-pelt.h"
 
-int __update_load_avg_blocked_se(u64 now, struct sched_entity *se);
-int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se);
+void update_util_uclamp(struct sched_avg *avg, struct task_struct *p);
+void __update_load_avg_blocked_se(u64 now, struct sched_entity *se);
+void __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se);
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..35036246824b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3085,6 +3085,33 @@ static inline bool uclamp_is_used(void)
 {
 	return static_branch_likely(&sched_uclamp_used);
 }
+
+static inline void util_uclamp_enqueue(struct sched_avg *avg,
+				       struct task_struct *p)
+{
+	unsigned int avg_val = READ_ONCE(avg->util_avg_uclamp);
+	unsigned int p_val = READ_ONCE(p->se.avg.util_avg_uclamp);
+
+	WRITE_ONCE(avg->util_avg_uclamp, avg_val + p_val);
+}
+
+static inline void util_uclamp_dequeue(struct sched_avg *avg,
+				       struct task_struct *p)
+{
+	unsigned int avg_val = READ_ONCE(avg->util_avg_uclamp);
+	unsigned int p_val = READ_ONCE(p->se.avg.util_avg_uclamp), new_val;
+
+	if (avg_val > p_val)
+		new_val = avg_val - p_val;
+	else {
+		WARN_ONCE(avg_val < p_val,
+			"avg_val underflow. avg_val %u is even less than p_val %u before subtraction\n",
+			avg_val, p_val);
+		new_val = 0;
+	}
+
+	WRITE_ONCE(avg->util_avg_uclamp, new_val);
+}
 #else /* CONFIG_UCLAMP_TASK */
 static inline unsigned long uclamp_eff_value(struct task_struct *p,
 					     enum uclamp_id clamp_id)
-- 
2.34.1


