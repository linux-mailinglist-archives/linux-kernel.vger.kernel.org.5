Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68681800192
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376827AbjLAC1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLAC1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:27:45 -0500
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249CD1729
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:27:48 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701397666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fH2a7qGhcZXIGgkMnI78AIz2EcPccxN2AHWONEyfKRs=;
        b=T6evYVBwsNGTj0sOvAKv/gA4H1/48MNtmuovLzHY9YTRHZcsdOx4aGQetuphmYvEg2dvZV
        5t44FPvtWgQIYe+0N3X+yPJ9W08gwDmptvmT0NDQL+AbPE1llnDScD+VZE8Eg2op5WzpyO
        ZORbL1+/QGvlvP6O+XuJZ/Dvg7K5mMM=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 2/2] sched/rt: Return NULL when rt entity isn't a task in rt_task_of()
Date:   Fri,  1 Dec 2023 10:27:04 +0800
Message-Id: <20231201022704.3526377-3-yajun.deng@linux.dev>
In-Reply-To: <20231201022704.3526377-1-yajun.deng@linux.dev>
References: <20231201022704.3526377-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before calling rt_task_of(), we need to make sure that the rt entity is
a task. There is also a warning in rt_task_of() if the rt entity isn't a
task. That means we need to check the rt entity twice. If the rt entity
isn't a task, return the task struct is meaningless.

Return NULL when rt entity isn't a task in rt_task_of(), and call
rt_task_of() instead of rt_entity_is_task() when we need a task_struct.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/rt.c | 62 +++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..be4d65e05af1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -169,9 +169,9 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_SCHED_DEBUG
-	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
-#endif
+	if (!rt_entity_is_task(rt_se))
+		return NULL;
+
 	return container_of(rt_se, struct task_struct, rt);
 }
 
@@ -941,12 +941,10 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 
 static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_RT_GROUP_SCHED
 	struct rt_rq *rt_rq = group_rt_rq(rt_se);
 
 	if (rt_rq)
 		return rt_rq->highest_prio.curr;
-#endif
 
 	return rt_task_of(rt_se)->prio;
 }
@@ -1266,54 +1264,34 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 	rt_se->on_list = 0;
 }
 
-static inline struct sched_statistics *
-__schedstats_from_rt_se(struct sched_rt_entity *rt_se)
-{
-#ifdef CONFIG_RT_GROUP_SCHED
-	/* schedstats is not supported for rt group. */
-	if (!rt_entity_is_task(rt_se))
-		return NULL;
-#endif
-
-	return &rt_task_of(rt_se)->stats;
-}
-
 static inline void
 update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 {
-	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
+	struct task_struct *p;
 
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
-	stats = __schedstats_from_rt_se(rt_se);
-	if (!stats)
+	p = rt_task_of(rt_se);
+	if (!p)
 		return;
 
-	__update_stats_wait_start(rq_of_rt_rq(rt_rq), p, stats);
+	__update_stats_wait_start(rq_of_rt_rq(rt_rq), p, &p->stats);
 }
 
 static inline void
 update_stats_enqueue_sleeper_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 {
-	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
+	struct task_struct *p;
 
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
-	stats = __schedstats_from_rt_se(rt_se);
-	if (!stats)
+	p = rt_task_of(rt_se);
+	if (!p)
 		return;
 
-	__update_stats_enqueue_sleeper(rq_of_rt_rq(rt_rq), p, stats);
+	__update_stats_enqueue_sleeper(rq_of_rt_rq(rt_rq), p, &p->stats);
 }
 
 static inline void
@@ -1330,34 +1308,28 @@ update_stats_enqueue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 static inline void
 update_stats_wait_end_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 {
-	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
+	struct task_struct *p;
 
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
-	stats = __schedstats_from_rt_se(rt_se);
-	if (!stats)
+	p = rt_task_of(rt_se);
+	if (!p)
 		return;
 
-	__update_stats_wait_end(rq_of_rt_rq(rt_rq), p, stats);
+	__update_stats_wait_end(rq_of_rt_rq(rt_rq), p, &p->stats);
 }
 
 static inline void
 update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 			int flags)
 {
-	struct task_struct *p = NULL;
+	struct task_struct *p;
 
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
+	p = rt_task_of(rt_se);
 	if ((flags & DEQUEUE_SLEEP) && p) {
 		unsigned int state;
 
-- 
2.25.1

