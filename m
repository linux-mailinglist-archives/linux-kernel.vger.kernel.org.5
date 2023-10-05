Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C57BA6BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjJEQl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjJEQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:39:55 -0400
Received: from out-199.mta1.migadu.com (out-199.mta1.migadu.com [IPv6:2001:41d0:203:375::c7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795683C12
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:23:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696523026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZoYSvv9GvN5UHY+p4M//aUHzUNjo8VNCPzwQbM0o+g=;
        b=df+BZIZp5gHbC2gFVu1urFRrQbixm+oQ8XGJpBLy22KE76hM96wBIBF65ACJdGioBWNUHH
        KJs0hEEvqnGkODXvq32oy4IFH+E1KU6Rx3MlmM/b7GyScsGRjbUqiK5vbvX//8l24v8E2e
        8UTHaunkIzBGFncdDYoP7vyLkUJy0yU=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 1/2] sched/rt: Introduce for_each_sched_rt_entity_back() & use it
Date:   Fri,  6 Oct 2023 00:23:16 +0800
Message-Id: <20231005162317.3343678-2-yajun.deng@linux.dev>
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
it should not place out of RT_GROUP_SCHED.

Introduce for_each_sched_rt_entity_back() & use it, it safe move back to
under the CONFIG_RT_GROUP_SCHED in next patch.

No functional changes.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/rt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 88fc98601413..642edbd24ffb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -520,6 +520,9 @@ static inline struct task_group *next_task_group(struct task_group *tg)
 #define for_each_sched_rt_entity(rt_se) \
 	for (; rt_se; rt_se = rt_se->parent)
 
+#define for_each_sched_rt_entity_back(rt_se) \
+	for (; rt_se; rt_se = rt_se->back)
+
 static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
 {
 	return rt_se->my_q;
@@ -625,6 +628,9 @@ typedef struct rt_rq *rt_rq_iter_t;
 #define for_each_sched_rt_entity(rt_se) \
 	for (; rt_se; rt_se = NULL)
 
+#define for_each_sched_rt_entity_back(rt_se) \
+	for_each_sched_rt_entity(rt_se)
+
 static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
 {
 	return NULL;
@@ -1445,7 +1451,8 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
 
 	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
 
-	for (rt_se = back; rt_se; rt_se = rt_se->back) {
+	rt_se = back;
+	for_each_sched_rt_entity_back(rt_se) {
 		if (on_rt_rq(rt_se))
 			__dequeue_rt_entity(rt_se, flags);
 	}
-- 
2.25.1

