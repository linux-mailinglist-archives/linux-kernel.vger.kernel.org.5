Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC907EC150
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjKOLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKOLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:33:58 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7CD11C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:33:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VwSxxNu_1700048032;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VwSxxNu_1700048032)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 19:33:52 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sched/fair: introduce core_vruntime and core_min_vruntime
Date:   Wed, 15 Nov 2023 19:33:40 +0800
Message-Id: <20231115113341.13261-4-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231115113341.13261-1-CruzZhao@linux.alibaba.com>
References: <20231115113341.13261-1-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To compare the priority of sched_entity from different cpus of a core,
we introduce core_vruntime to struct sched_entity and core_min_vruntime
to struct cfs_rq.

cfs_rq->core->core_min_vruntime records the min vruntime of the cfs_rqs
of the same task_group among the core, and se->core_vruntime is the
vruntime relative to se->cfs_rq->core->core_min_vruntime.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/fair.c   | 52 ++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h  |  1 +
 3 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..df481a8ebc07 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -562,6 +562,9 @@ struct sched_entity {
 	u64				sum_exec_runtime;
 	u64				prev_sum_exec_runtime;
 	u64				vruntime;
+#ifdef CONFIG_SCHED_CORE
+	u64				core_vruntime;
+#endif
 	s64				vlag;
 	u64				slice;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 61cbaa3cc385..60b2fd437474 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -750,30 +750,58 @@ static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 	return min_vruntime;
 }
 
+#ifdef CONFIG_SCHED_CORE
+static u64 __update_core_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
+{
+	u64 min_vruntime = cfs_rq->core_min_vruntime;
+	s64 delta = (s64)(vruntime - min_vruntime);
+
+	return delta > 0 ? vruntime : min_vruntime;
+}
+#endif
+
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
 
 	u64 vruntime = cfs_rq->min_vruntime;
+#ifdef CONFIG_SCHED_CORE
+	u64 core_vruntime = cfs_rq->core->min_vruntime;
+#endif
 
 	if (curr) {
-		if (curr->on_rq)
+		if (curr->on_rq) {
 			vruntime = curr->vruntime;
-		else
+#ifdef CONFIG_SCHED_CORE
+			core_vruntime = curr->core_vruntime;
+#endif
+		} else {
 			curr = NULL;
+		}
 	}
 
 	if (se) {
-		if (!curr)
+		if (!curr) {
 			vruntime = se->vruntime;
-		else
+#ifdef CONFIG_SCHED_CORE
+			core_vruntime = se->core_vruntime;
+#endif
+		} else {
 			vruntime = min_vruntime(vruntime, se->vruntime);
+#ifdef CONFIG_SCHED_CORE
+			core_vruntime = min_vruntime(core_vruntime, se->core_vruntime);
+#endif
+		}
 	}
 
 	/* ensure we never gain time by being placed backwards. */
 	u64_u32_store(cfs_rq->min_vruntime,
 		      __update_min_vruntime(cfs_rq, vruntime));
+#ifdef CONFIG_SCHED_CORE
+	u64_u32_store(cfs_rq->core->core_min_vruntime,
+		     __update_core_min_vruntime(cfs_rq->core, vruntime));
+#endif
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -1137,6 +1165,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	struct sched_entity *curr = cfs_rq->curr;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
 	u64 delta_exec;
+	u64 delta_exec_fair;
 
 	if (unlikely(!curr))
 		return;
@@ -1158,7 +1187,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
-	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	delta_exec_fair = calc_delta_fair(delta_exec, curr);
+	curr->vruntime += delta_exec_fair;
+#ifdef CONFIG_SCHED_CORE
+	curr->core_vruntime += delta_exec_fair;
+#endif
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
@@ -5009,6 +5042,9 @@ static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 vslice, vruntime = avg_vruntime(cfs_rq);
+#ifdef CONFIG_SCHED_CORE
+	u64 core_vruntime = cfs_rq->core->core_min_vruntime + vruntime - cfs_rq->min_vruntime;
+#endif
 	s64 lag = 0;
 
 	se->slice = sysctl_sched_base_slice;
@@ -5091,6 +5127,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	}
 
 	se->vruntime = vruntime - lag;
+#ifdef CONFIG_SCHED_CORE
+	se->core_vruntime = core_vruntime - lag;
+#endif
 
 	/*
 	 * When joining the competition; the exisiting tasks will be,
@@ -12655,6 +12694,9 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
+#ifdef CONFIG_SCHED_CORE
+	u64_u32_store(cfs_rq->core_min_vruntime, (u64)(-(1LL << 20)));
+#endif
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62fca54223a1..f9d3701481f1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -545,6 +545,7 @@ struct cfs_rq {
 	u64			exec_clock;
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
+	u64			core_min_vruntime;
 	unsigned int		forceidle_seq;
 	u64			min_vruntime_fi;
 	struct cfs_rq		*core;
-- 
2.39.3

