Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4903E7EC14F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjKOLeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjKOLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:33:58 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB9AE9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:33:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VwSxxNQ_1700048031;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VwSxxNQ_1700048031)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 19:33:52 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sched/core: introduce core to struct cfs_rq
Date:   Wed, 15 Nov 2023 19:33:39 +0800
Message-Id: <20231115113341.13261-3-CruzZhao@linux.alibaba.com>
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

Introduce core to struct cfs_rq, indicates the corresponding cfs_rq of
rq->core.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core.c  |  4 ++++
 kernel/sched/fair.c  | 11 +++++++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7a685fae73c4..647a12af9172 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6432,6 +6432,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
 		if (t == cpu) {
 			rq->core = core_rq;
 			rq->core_id = core_id;
+			rq->cfs.core = &core_rq->cfs;
 		}
 
 		WARN_ON_ONCE(rq->core != core_rq);
@@ -6488,6 +6489,7 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 		rq = cpu_rq(t);
 		rq->core = core_rq;
 		rq->core_id = core_id;
+		rq->cfs.core = &core_rq->cfs;
 	}
 }
 
@@ -6498,6 +6500,7 @@ static inline void sched_core_cpu_dying(unsigned int cpu)
 	if (rq->core != rq) {
 		rq->core = rq;
 		rq->core_id = cpu;
+		rq->cfs.core = &rq->cfs;
 	}
 }
 
@@ -10016,6 +10019,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
 		rq->core_id = i;
+		rq->cfs.core = &rq->cfs;
 		rq->core_pick = NULL;
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2048138ce54b..61cbaa3cc385 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12420,6 +12420,16 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 	return delta > 0;
 }
 
+void sched_core_init_cfs_rq(struct task_group *tg, struct cfs_rq *cfs_rq)
+{
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	struct rq *rq = rq_of(cfs_rq);
+	int core_id = rq->core_id;
+
+	cfs_rq->core = tg->cfs_rq[core_id];
+#endif
+}
+
 static int task_is_throttled_fair(struct task_struct *p, int cpu)
 {
 	struct cfs_rq *cfs_rq;
@@ -12715,6 +12725,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
+		sched_core_init_cfs_rq(tg, cfs_rq);
 		init_entity_runnable_average(se);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1b62165fc840..62fca54223a1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -547,6 +547,7 @@ struct cfs_rq {
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
 	u64			min_vruntime_fi;
+	struct cfs_rq		*core;
 #endif
 
 #ifndef CONFIG_64BIT
-- 
2.39.3

