Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86E7BA6BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjJEQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjJEQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:39:28 -0400
Received: from out-200.mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102B5423E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:23:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696523034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmy3zotbQnnCKFfAnZbO+ZCxlJAV6ZCKqlKvYGPQcy8=;
        b=uWRFSMTpGCh/IZ4iyBdzbqhocEbshB6NFx99HW+hW/gm+4qaBNsz0rz6z/VRftvSFDBJN4
        GbADw37GROFpcUjH7WRyft3BbeYpDlxBNKllHNvbErj4W5XEh1QXiZ2TGj4eFy3cuz/vJ7
        Ins8jYuTOTrhvR+yn1fQ09yCB2JDHMM=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 2/2] sched/rt: Move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block
Date:   Fri,  6 Oct 2023 00:23:17 +0800
Message-Id: <20231005162317.3343678-3-yajun.deng@linux.dev>
In-Reply-To: <20231005162317.3343678-1-yajun.deng@linux.dev>
References: <20231005162317.3343678-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
So move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block. It
will save a few bytes.

Also, init child when parent isn't NULL in init_tg_rt_entry().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/sched.h |  2 +-
 kernel/sched/rt.c     | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..d0fe56603e60 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -597,8 +597,8 @@ struct sched_rt_entity {
 	unsigned short			on_rq;
 	unsigned short			on_list;
 
-	struct sched_rt_entity		*back;
 #ifdef CONFIG_RT_GROUP_SCHED
+	struct sched_rt_entity		*back;
 	struct sched_rt_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct rt_rq			*rt_rq;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 642edbd24ffb..7b3105b875f1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -233,8 +233,10 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 
 	if (!parent)
 		rt_se->rt_rq = &rq->rt;
-	else
+	else {
 		rt_se->rt_rq = parent->my_q;
+		parent->back = rt_se;
+	}
 
 	rt_se->my_q = rt_rq;
 	rt_se->parent = parent;
@@ -1441,23 +1443,21 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
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
 
-	rt_se = back;
+	rt_se = root;
 	for_each_sched_rt_entity_back(rt_se) {
 		if (on_rt_rq(rt_se))
 			__dequeue_rt_entity(rt_se, flags);
 	}
 
-	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
+	dequeue_top_rt_rq(rt_rq_of_se(root), rt_nr_running);
 }
 
 static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
-- 
2.25.1

