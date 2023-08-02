Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A9676C2D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjHBCYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjHBCYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:24:32 -0400
Received: from out-120.mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC77E213F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:24:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690943067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fwE+Rq9mSoCZ0Nln+HHt8N0bG1PTqQvHzIw9QHmw6bs=;
        b=dLfBcyCus8YC/ybHlmyFMKLW7KJXaxqnWgSK17lfGcbv8Qqhh3EDBOb2nA/Ly8fxSwm/wh
        7KemxI6RQAVD4qd87aWAj4xT9KxxshCvpG1jy6BhBlNaUSnx8wxz2yk1/yw1X8wka+Li1h
        OqAts/cjjBpXHDHXQYnSoPOWxSaGB5Q=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] sched/rt: move back to RT_GROUP_SCHED and rename it child
Date:   Wed,  2 Aug 2023 10:24:08 +0800
Message-Id: <20230802022408.529208-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
it should not place out of RT_GROUP_SCHED, move back to RT_GROUP_SCHED
and rename it child.

Init child in init_tg_rt_entry(). Also, add WARN_ON_ONCE if parent is
NULL, because parent is only NULL when rt_se is NULL.

Introduce for_each_sched_rt_entity_reverse() to iterate rt_entity from
top to down.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 V1 -> V2: Add WARN_ON_ONCE in init_tg_rt_entry().
---
 include/linux/sched.h |  2 +-
 kernel/sched/rt.c     | 29 +++++++++++++++++------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 177b3f3676ef..5635655d6c35 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -594,8 +594,8 @@ struct sched_rt_entity {
 	unsigned short			on_rq;
 	unsigned short			on_list;
 
-	struct sched_rt_entity		*back;
 #ifdef CONFIG_RT_GROUP_SCHED
+	struct sched_rt_entity		*child;
 	struct sched_rt_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct rt_rq			*rt_rq;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e5074115..8e577c7b9257 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -228,13 +228,13 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 	if (!rt_se)
 		return;
 
-	if (!parent)
-		rt_se->rt_rq = &rq->rt;
-	else
-		rt_se->rt_rq = parent->my_q;
+	if (WARN_ON_ONCE(!parent))
+		return;
 
+	rt_se->rt_rq = parent->my_q;
 	rt_se->my_q = rt_rq;
 	rt_se->parent = parent;
+	parent->child = rt_se;
 	INIT_LIST_HEAD(&rt_se->run_list);
 }
 
@@ -564,6 +564,9 @@ static inline struct task_group *next_task_group(struct task_group *tg)
 #define for_each_sched_rt_entity(rt_se) \
 	for (; rt_se; rt_se = rt_se->parent)
 
+#define for_each_sched_rt_entity_reverse(rt_se) \
+	for (; rt_se; rt_se = rt_se->child)
+
 static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
 {
 	return rt_se->my_q;
@@ -669,6 +672,9 @@ typedef struct rt_rq *rt_rq_iter_t;
 #define for_each_sched_rt_entity(rt_se) \
 	for (; rt_se; rt_se = NULL)
 
+#define for_each_sched_rt_entity_reverse(rt_se) \
+	for_each_sched_rt_entity(rt_se)
+
 static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
 {
 	return NULL;
@@ -1481,22 +1487,21 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
  */
 static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
 {
-	struct sched_rt_entity *back = NULL;
+	struct sched_rt_entity *root;
 	unsigned int rt_nr_running;
 
-	for_each_sched_rt_entity(rt_se) {
-		rt_se->back = back;
-		back = rt_se;
-	}
+	for_each_sched_rt_entity(rt_se)
+		root = rt_se;
 
-	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
+	rt_nr_running = rt_rq_of_se(root)->rt_nr_running;
 
-	for (rt_se = back; rt_se; rt_se = rt_se->back) {
+	rt_se = root;
+	for_each_sched_rt_entity_reverse(rt_se) {
 		if (on_rt_rq(rt_se))
 			__dequeue_rt_entity(rt_se, flags);
 	}
 
-	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
+	dequeue_top_rt_rq(rt_rq_of_se(root), rt_nr_running);
 }
 
 static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
-- 
2.25.1

