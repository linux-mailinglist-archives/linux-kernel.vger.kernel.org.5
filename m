Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E87DCD73
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbjJaNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbjJaNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:00:14 -0400
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896DCEA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:00:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698757209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sO/0GN20MYb/vNaKkzhBBtk0+YYiOECkhCnCZjqjhI=;
        b=lisl5PHvh0WYFyUnrtBihMVHL0yL31Xhwkl7H6OVMudPPWdfH9gKGOwiTbyIH2ntZzlO+b
        y9sMXRR4kUMcpL9A0QiyDSbAdKayPDWEcebo59oOOrWdaPvyq7czi5+J0/7JlorkMXsD/B
        J+4wQke+ZlRprsuD4m4Ao2MjrPgU49M=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v3 2/3] sched: Don't trace stat runtime for task group
Date:   Tue, 31 Oct 2023 20:59:27 +0800
Message-Id: <20231031125928.235685-3-yajun.deng@linux.dev>
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

The rt entity can be a task group. We will trace stat runtime for each
task, so we don't need to trace stat runtime for task group.

Move trace_sched_stat_runtime in update_current_exec_runtime.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v3: New patch.
---
 kernel/sched/deadline.c | 2 --
 kernel/sched/rt.c       | 2 --
 kernel/sched/sched.h    | 1 +
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a9f84428c4b5..70b5c5b47106 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1301,8 +1301,6 @@ static void update_curr_dl(struct rq *rq)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
-	trace_sched_stat_runtime(curr, delta_exec, 0);
-
 	update_current_exec_runtime(curr, now, delta_exec, true);
 
 	if (dl_entity_is_special(dl_se))
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 79cf80d73822..1e155c7658ae 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1016,8 +1016,6 @@ static void update_curr_rt(struct rq *rq)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
-	trace_sched_stat_runtime(curr, delta_exec, 0);
-
 	update_current_exec_runtime(curr, now, delta_exec,
 				    rt_entity_is_task(rt_se));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6f0169d9b306..f7014e19bc0a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3268,6 +3268,7 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 	curr->se.exec_start = now;
 
 	if (task) {
+		trace_sched_stat_runtime(curr, delta_exec, curr->se.vruntime);
 		account_group_exec_runtime(curr, delta_exec);
 		cgroup_account_cputime(curr, delta_exec);
 	}
-- 
2.25.1

