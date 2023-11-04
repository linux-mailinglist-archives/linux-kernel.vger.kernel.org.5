Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9214F7E0EDB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjKDLAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjKDLAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:00:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1A10D0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 03:59:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6D0C433CB;
        Sat,  4 Nov 2023 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699095594;
        bh=1Wn77Swl4Ek25DMos+AE5sSW8ut9WCzWOgUJJ0gtsq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVL4/tyFOIi4wjwakWUVUHTK1SgC3EDGT0aPFBbepSWJYrqLg/hCyg3TJSxgGJAFH
         4Y5ql8Nt79JIvjdyx4Nk/qPbnC+Ce8docMPTFKHw7y3TwGlw5tC6pNsue0MC59fnlf
         jHXdHsPku61YscKt32ZrRq33ApU1h8W+DHxUs1qibKfUYmE9mWjoJgGdaBaonU0bm9
         pK0QwHtiMcPO9PlG7vX8yP3Uk6T5QwfdeHkB0OvT351RjFqXzSJTNd5lMV3//aF0EA
         OveavfSOEmA1f7bysOFhnV0D3dTZTK472qdrNjbvge+p9HsWZJUVoh0Bk0b1UsALG2
         2taGT7V0EqyAw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, bristot@kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v5 5/7] sched/fair: Add trivial fair server
Date:   Sat,  4 Nov 2023 11:59:22 +0100
Message-Id: <4e0d14eb6e0ec33055197ac7ddb57ef7ab3894a5.1699095159.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1699095159.git.bristot@kernel.org>
References: <cover.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Use deadline servers to service fair tasks.

This patch adds a fair_server deadline entity which acts as a container
for fair entities and can be used to fix starvation when higher priority
(wrt fair) tasks are monopolizing CPU(s).

[ dl_server do not account for rt ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c     |  1 +
 kernel/sched/deadline.c |  7 +++++++
 kernel/sched/fair.c     | 29 +++++++++++++++++++++++++++++
 kernel/sched/sched.h    |  4 ++++
 4 files changed, 41 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a721f6776b12..939266d29681 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10019,6 +10019,7 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+		fair_server_init(rq);
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 541d547e1019..1d7b96ca9011 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1382,6 +1382,13 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 			resched_curr(rq);
 	}
 
+	/*
+	 * The fair server (sole dl_server) does not account for real-time
+	 * workload because it is running fair work.
+	 */
+	if (dl_server(dl_se))
+		return;
+
 	/*
 	 * Because -- for now -- we share the rt bandwidth, we need to
 	 * account our runtime there too, otherwise actual rt tasks
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc3a4bc6c438..b15f7f376a67 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6600,6 +6600,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
+	if (!rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -6744,6 +6747,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
+	if (!rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -8396,6 +8402,29 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq)
 	return pick_next_task_fair(rq, NULL, NULL);
 }
 
+static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->cfs.nr_running;
+}
+
+static struct task_struct *fair_server_pick(struct sched_dl_entity *dl_se)
+{
+	return pick_next_task_fair(dl_se->rq, NULL, NULL);
+}
+
+void fair_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->fair_server;
+
+	init_dl_entity(dl_se);
+
+	dl_se->dl_runtime = 50 * NSEC_PER_MSEC;
+	dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
+	dl_se->dl_period = 1000 * NSEC_PER_MSEC;
+
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+}
+
 /*
  * Account for a descheduled task:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24a2bc7c453b..ec0e288c8e06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -340,6 +340,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void fair_server_init(struct rq *);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 struct cfs_rq;
@@ -1005,6 +1007,8 @@ struct rq {
 	struct rt_rq		rt;
 	struct dl_rq		dl;
 
+	struct sched_dl_entity	fair_server;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
 	struct list_head	leaf_cfs_rq_list;
-- 
2.40.1

