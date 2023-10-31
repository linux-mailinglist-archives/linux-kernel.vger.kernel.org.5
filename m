Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0080B7DCD74
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbjJaNAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344430AbjJaNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:00:26 -0400
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B6EFD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:00:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698757221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7mRzGepikGwf8IInKfZWrq3Ja/myVvXm98PYematwc=;
        b=TQvO/62h1NO17SquF88fUpY2eQXVXl/k9nBKSzhcRfe9yYNpYkurG3z+udinUJBmAvUZRp
        uZJ+4XY8KE2msF1PjSG2XL2hNBmSbuOY5xjrrs8VMtEedUg20kxqTq3AZPcTAdS+hSch+T
        xrMx9qEi3OLK0Bhv5kbLlZWi1nbKK8A=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v3 3/3] sched/fair: Simplify update_curr()
Date:   Tue, 31 Oct 2023 20:59:28 +0800
Message-Id: <20231031125928.235685-4-yajun.deng@linux.dev>
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

Use update_current_exec_runtime() simplify update_curr().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v3: New patch.
---
 kernel/sched/fair.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2048138ce54b..ffc000e49db5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1135,6 +1135,7 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
+	struct task_struct *curtask = rq_of(cfs_rq)->curr;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
 	u64 delta_exec;
 
@@ -1145,8 +1146,6 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	curr->exec_start = now;
-
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
@@ -1155,20 +1154,14 @@ static void update_curr(struct cfs_rq *cfs_rq)
 				max(delta_exec, stats->exec_max));
 	}
 
-	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
-	if (entity_is_task(curr)) {
-		struct task_struct *curtask = task_of(curr);
-
-		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
-		cgroup_account_cputime(curtask, delta_exec);
-		account_group_exec_runtime(curtask, delta_exec);
-	}
+	update_current_exec_runtime(curtask, now, delta_exec,
+				    entity_is_task(curr));
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
-- 
2.25.1

