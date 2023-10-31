Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420157DCD72
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbjJaNAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbjJaNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:00:04 -0400
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [IPv6:2001:41d0:1004:224b::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E28DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:00:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698757199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16cXTdi5/ep7w7uZRWQYSJHZkPZmLLf1mG23Gp6fSwY=;
        b=vNeWMJBD0MKX8+m7eW+z7P4Ht1LQVJelagkCOeXvHrpq3TSwhMAT43SrGdGqKfT6lIAA8P
        qBtjNlpvgSsu716T8XasjmEh1v5U4v0pycNKQtaqpEsQ/1Yx8UhTkHfrEo6y+LT0aR8B4N
        1V0pm6k2LDub39CdqsQZFJj5kVn1I6c=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v3 1/3] sched: Don't account execution time for task group
Date:   Tue, 31 Oct 2023 20:59:26 +0800
Message-Id: <20231031125928.235685-2-yajun.deng@linux.dev>
In-Reply-To: <20231031125928.235685-1-yajun.deng@linux.dev>
References: <20231031125928.235685-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt entity can be a task group. We will account execution time for
each task. For consistency, we don't need to account execution time for
task group.

Pass a parameter to update_current_exec_runtime, let the caller decide
whether account execution time.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
v3: Pass a parameter to update_current_exec_runtime.
v2: Add the missing '#endif'.
v1: https://lore.kernel.org/all/20231023065418.1548239-1-yajun.deng@linux.dev/
---
 kernel/sched/deadline.c  |  2 +-
 kernel/sched/rt.c        |  3 ++-
 kernel/sched/sched.h     | 10 ++++++----
 kernel/sched/stop_task.c |  2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b28114478b82..a9f84428c4b5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1303,7 +1303,7 @@ static void update_curr_dl(struct rq *rq)
 
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec, true);
 
 	if (dl_entity_is_special(dl_se))
 		return;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..79cf80d73822 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1018,7 +1018,8 @@ static void update_curr_rt(struct rq *rq)
 
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec,
+				    rt_entity_is_task(rt_se));
 
 	if (!rt_bandwidth_enabled())
 		return;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..6f0169d9b306 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3262,13 +3262,15 @@ extern void sched_dynamic_update(int mode);
 #endif
 
 static inline void update_current_exec_runtime(struct task_struct *curr,
-						u64 now, u64 delta_exec)
+					       u64 now, u64 delta_exec, bool task)
 {
 	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
 	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
+
+	if (task) {
+		account_group_exec_runtime(curr, delta_exec);
+		cgroup_account_cputime(curr, delta_exec);
+	}
 }
 
 #ifdef CONFIG_SCHED_MM_CID
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 6cf7304e6449..1bec2af7ce8d 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -81,7 +81,7 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
-	update_current_exec_runtime(curr, now, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec, true);
 }
 
 /*
-- 
2.25.1

