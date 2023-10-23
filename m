Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D77D2C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjJWIKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:10:16 -0400
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0385CA1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:10:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698048613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OZo8VSwhkKBAcb8XFz5ejDDhW5571Hea2aGRDnsLDFA=;
        b=Y1fsLn4TadGxgdC5oUPAcBq39c+IUbfLzv53epHivnG2+eTgD7gGkPL9nwreL6tzas3s4b
        b51YfMfCAsjY2m5T6wiSzsA6S+FoGG9GSXAN91u/96IAfJxjqIw0eoUI9UboCQLtDcfvbW
        QeW6Zvglty70EMuxB3GkQGluNkYwHHQ=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] sched/rt: Account execution time for cgroup and thread group if rt entity is task
Date:   Mon, 23 Oct 2023 16:09:54 +0800
Message-Id: <20231023080954.1628449-1-yajun.deng@linux.dev>
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

The rt entity can be a task group. Like the fair scheduler class, we don't
need to account execution time for cgroup and thread group if the rt
entity isn't a task.

Check the scheduler class of the task and make sure that the rt entity is a
task.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: Add the missing '#endif'.
v1: https://lore.kernel.org/all/20231023065418.1548239-1-yajun.deng@linux.dev/
---
 kernel/sched/rt.c    |  4 ----
 kernel/sched/sched.h | 13 +++++++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..ccded5670b61 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -165,8 +165,6 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 	hrtimer_cancel(&rt_b->rt_period_timer);
 }
 
-#define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
-
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
 #ifdef CONFIG_SCHED_DEBUG
@@ -283,8 +281,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 
 #else /* CONFIG_RT_GROUP_SCHED */
 
-#define rt_entity_is_task(rt_se) (1)
-
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
 	return container_of(rt_se, struct task_struct, rt);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 65cad0e5729e..95d696e23a89 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -779,6 +779,12 @@ static inline long se_runnable(struct sched_entity *se)
 }
 #endif
 
+#ifdef CONFIG_RT_GROUP_SCHED
+#define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
+#else
+#define rt_entity_is_task(rt_se) (1)
+#endif
+
 #ifdef CONFIG_SMP
 /*
  * XXX we want to get rid of these helpers and use the full load resolution.
@@ -3266,9 +3272,12 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 						u64 now, u64 delta_exec)
 {
 	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
 	curr->se.exec_start = now;
+
+	if (curr->sched_class == &rt_sched_class && !rt_entity_is_task(&curr->rt))
+		return;
+
+	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
 }
 
-- 
2.25.1

