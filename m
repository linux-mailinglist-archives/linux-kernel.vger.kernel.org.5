Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65D87EC14E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjKOLeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKOLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:33:57 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8ACC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:33:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VwSxxN2_1700048031;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VwSxxN2_1700048031)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 19:33:51 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sched/core: introduce core_id to struct rq
Date:   Wed, 15 Nov 2023 19:33:38 +0800
Message-Id: <20231115113341.13261-2-CruzZhao@linux.alibaba.com>
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

Introduce core_id to struct rq, indates the cpu id of the core, which
is used for getting cpu id of rq->core quickly.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core.c  | 16 ++++++++++++----
 kernel/sched/sched.h |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e..7a685fae73c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6400,7 +6400,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
-	int t;
+	int t, core_id;
 
 	guard(core_lock)(&cpu);
 
@@ -6417,6 +6417,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
 		rq = cpu_rq(t);
 		if (rq->core == rq) {
 			core_rq = rq;
+			core_id = t;
 			break;
 		}
 	}
@@ -6428,8 +6429,10 @@ static void sched_core_cpu_starting(unsigned int cpu)
 	for_each_cpu(t, smt_mask) {
 		rq = cpu_rq(t);
 
-		if (t == cpu)
+		if (t == cpu) {
 			rq->core = core_rq;
+			rq->core_id = core_id;
+		}
 
 		WARN_ON_ONCE(rq->core != core_rq);
 	}
@@ -6439,7 +6442,7 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
-	int t;
+	int t, core_id;
 
 	guard(core_lock)(&cpu);
 
@@ -6458,6 +6461,7 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 		if (t == cpu)
 			continue;
 		core_rq = cpu_rq(t);
+		core_id = t;
 		break;
 	}
 
@@ -6483,6 +6487,7 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	for_each_cpu(t, smt_mask) {
 		rq = cpu_rq(t);
 		rq->core = core_rq;
+		rq->core_id = core_id;
 	}
 }
 
@@ -6490,8 +6495,10 @@ static inline void sched_core_cpu_dying(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	if (rq->core != rq)
+	if (rq->core != rq) {
 		rq->core = rq;
+		rq->core_id = cpu;
+	}
 }
 
 #else /* !CONFIG_SCHED_CORE */
@@ -10008,6 +10015,7 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
+		rq->core_id = i;
 		rq->core_pick = NULL;
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..1b62165fc840 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1121,6 +1121,7 @@ struct rq {
 #ifdef CONFIG_SCHED_CORE
 	/* per rq */
 	struct rq		*core;
+	unsigned int		core_id;
 	struct task_struct	*core_pick;
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
-- 
2.39.3

