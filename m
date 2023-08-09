Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5307768D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjHITfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjHITfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:35:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B3E10DC;
        Wed,  9 Aug 2023 12:34:58 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:34:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691609697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHb1+I7dEUKHkoGnfCzy6ZAjqopVxANpj2PLezgS+ZE=;
        b=cyRj2nlu7o6KSw45lUf4H8Xr9qj5FHhxk+Rj3clxFJnrq9pFO7rFmsMEZAAbw8ErO9ST48
        uiA1qyhU1kvq4mI/Tl2USrEeb7vcu1zrVs1qv2j7T8bEsXMOXQ7PREZQRM95OkwpEKUT2J
        dd+CoL1yzUxEYwmTR55CRXnVurHg4+jDS1yPkkdX4uuCw+bBqOEwx43if7cX+50uH8HRio
        BqFFk1fjrMoXIjqnU9oPelJQGodEAPeMh9py/1hJ797VEepkmP8vxtB7j0nF2hCZIA09uo
        kYyk1JMiFvKher4HbQsiV13YDmWh4aaOpUHRvM0nQQhvBajKHf4XkC6CsUlM5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691609697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHb1+I7dEUKHkoGnfCzy6ZAjqopVxANpj2PLezgS+ZE=;
        b=za0k7vLuKD3jSNcHSM4tRrah0q5QVmhtjIVGBe32YMPkW7V+IxmzdArpJ8pnZZ9V7HcFYu
        CjuDFqDviqPRZKAg==
From:   "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched, cgroup: Restore meaning to hierarchical_quota
Cc:     Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>, Tejun Heo <tj@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230714125746.812891-1-pauld@redhat.com>
References: <20230714125746.812891-1-pauld@redhat.com>
MIME-Version: 1.0
Message-ID: <169160969702.27769.6254794761914899507.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c98c18270be115678f4295b10a5af5dcc9c4efa0
Gitweb:        https://git.kernel.org/tip/c98c18270be115678f4295b10a5af5dcc9c4efa0
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Fri, 14 Jul 2023 08:57:46 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Aug 2023 16:19:26 +02:00

sched, cgroup: Restore meaning to hierarchical_quota

In cgroupv2 cfs_b->hierarchical_quota is set to -1 for all task
groups due to the previous fix simply taking the min.  It should
reflect a limit imposed at that level or by an ancestor. Even
though cgroupv2 does not require child quota to be less than or
equal to that of its ancestors the task group will still be
constrained by such a quota so this should be shown here. Cgroupv1
continues to set this correctly.

In both cases, add initialization when a new task group is created
based on the current parent's value (or RUNTIME_INF in the case of
root_task_group). Otherwise, the field is wrong until a quota is
changed after creation and __cfs_schedulable() is called.

Fixes: c53593e5cb69 ("sched, cgroup: Don't reject lower cpu.max on ancestors")
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230714125746.812891-1-pauld@redhat.com
---
 kernel/sched/core.c  | 13 +++++++++----
 kernel/sched/fair.c  |  7 ++++---
 kernel/sched/sched.h |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83e3654..3af25ca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9953,7 +9953,7 @@ void __init sched_init(void)
 		ptr += nr_cpu_ids * sizeof(void **);
 
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
-		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
+		init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
@@ -11087,11 +11087,16 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
 
 		/*
 		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
-		 * always take the min.  On cgroup1, only inherit when no
-		 * limit is set:
+		 * always take the non-RUNTIME_INF min.  On cgroup1, only
+		 * inherit when no limit is set. In both cases this is used
+		 * by the scheduler to determine if a given CFS task has a
+		 * bandwidth constraint at some higher level.
 		 */
 		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
-			quota = min(quota, parent_quota);
+			if (quota == RUNTIME_INF)
+				quota = parent_quota;
+			else if (parent_quota != RUNTIME_INF)
+				quota = min(quota, parent_quota);
 		} else {
 			if (quota == RUNTIME_INF)
 				quota = parent_quota;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f55b0a7..26bfbb6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6045,13 +6045,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
 }
 
-void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
+void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent)
 {
 	raw_spin_lock_init(&cfs_b->lock);
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 	cfs_b->burst = 0;
+	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
@@ -6217,7 +6218,7 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	return 0;
 }
 
-void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
+void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent) {}
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
@@ -12599,7 +12600,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	tg->shares = NICE_0_LOAD;
 
-	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
+	init_cfs_bandwidth(tg_cfs_bandwidth(tg), tg_cfs_bandwidth(parent));
 
 	for_each_possible_cpu(i) {
 		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9baeb1a..602de71 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -454,7 +454,7 @@ extern void unregister_fair_sched_group(struct task_group *tg);
 extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *se, int cpu,
 			struct sched_entity *parent);
-extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
+extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent);
 
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
