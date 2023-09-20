Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910C87A85FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjITOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjITOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:01:55 -0400
Received: from out-226.mta0.migadu.com (out-226.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2A5AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:01:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695218505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q5FMu0D+lg+hJ0WRrS1fbyuLn69QOn+cvkKyyXnvWFQ=;
        b=ZonHdx0zZ+TxdSp20seUHtqn7aIDhF9v3k1JUwdciOcnxZjL66NQrZa1qYfgoSXMsqCQdb
        zmlHaJGF1jW+vFBNB7B0oXCx3KsaG8HwpMrQgb9HsJ+RGi8di4j/NR2OMMf02tFrHc7eIX
        UkR22KywqfnEdenLjjNU0kvD8JDplu8=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] sched/rt: move back to RT_GROUP_SCHED and rename it child
Date:   Wed, 20 Sep 2023 22:01:27 +0800
Message-Id: <20230920140127.1671945-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
it should not place out of RT_GROUP_SCHED, move back to RT_GROUP_SCHED
and rename it child. This would save a few bytes.

Init child when parent isn't NULL in init_tg_rt_entry() and introduce
for_each_sched_rt_entity_reverse() to iterate rt_se from top to down.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: fix the "uninitialized symbol 'root'" warning
v1: https://lore.kernel.org/all/20230919035114.2364567-1-yajun.deng@linux.dev/
---
 include/linux/sched.h |  2 +-
 kernel/sched/rt.c     | 25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7fcf1b82cfa6..cd05f4bb6a26 100644
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
index 0597ba0f85ff..473a21b76c62 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -230,8 +230,10 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 
 	if (!parent)
 		rt_se->rt_rq = &rq->rt;
-	else
+	else {
 		rt_se->rt_rq = parent->my_q;
+		parent->child = rt_se;
+	}
 
 	rt_se->my_q = rt_rq;
 	rt_se->parent = parent;
@@ -564,6 +566,9 @@ static inline struct task_group *next_task_group(struct task_group *tg)
 #define for_each_sched_rt_entity(rt_se) \
 	for (; rt_se; rt_se = rt_se->parent)
 
+#define for_each_sched_rt_entity_reverse(rt_se) \
+	for (; rt_se; rt_se = rt_se->child)
+
 static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
 {
 	return rt_se->my_q;
@@ -669,6 +674,9 @@ typedef struct rt_rq *rt_rq_iter_t;
 #define for_each_sched_rt_entity(rt_se) \
 	for (; rt_se; rt_se = NULL)
 
+#define for_each_sched_rt_entity_reverse(rt_se) \
+	for_each_sched_rt_entity(rt_se)
+
 static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
 {
 	return NULL;
@@ -1481,22 +1489,21 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
  */
 static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
 {
-	struct sched_rt_entity *back = NULL;
+	struct sched_rt_entity *root = NULL;
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

