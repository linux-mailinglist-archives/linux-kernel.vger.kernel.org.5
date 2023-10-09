Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541837BDBA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376351AbjJIMXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376343AbjJIMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:23:14 -0400
Received: from out-193.mta0.migadu.com (out-193.mta0.migadu.com [91.218.175.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB83EDF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:23:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696854190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KeMaN6CEe65Ia/B/zeGHWtr7cEhMkoaCHnrN7qH3bE=;
        b=KyNPi4ZPdRkBQpIl20IRIwS+EB8A7MQgNse6+LNWkkktoKu4w46pHWKcQ5ksWzBkcfWRGN
        Mc6feowEsmRGQNnq4HKLyttGGKy6umm6s0y55370vDHFSdeyswl30IM76j6vxKY0gA42ih
        Y7oXmTMWQpQLh4MdUJhf7i/cX0KGu0I=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v7 1/3] sched/rt: Introduce for_each_sched_rt_entity_back() & use it
Date:   Mon,  9 Oct 2023 20:22:42 +0800
Message-Id: <20231009122244.2394336-2-yajun.deng@linux.dev>
In-Reply-To: <20231009122244.2394336-1-yajun.deng@linux.dev>
References: <20231009122244.2394336-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce for_each_sched_rt_entity_back() & use it, because it's safe to
call it whether CONFIG_RT_GROUP_SCHED is enabled or disabled.

No functional changes.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v7: Same with v6.
v6: Independent patch.
v5: Resend it.
v4: Missed rt_se = root in dequeue_rt_stack().
v3: Keep parent is NULL in init_tg_rt_entry().
v2: Add WARN_ON_ONCE in init_tg_rt_entry().
v1: https://lore.kernel.org/all/20230801062714.3424299-1-yajun.deng@linux.dev/
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

