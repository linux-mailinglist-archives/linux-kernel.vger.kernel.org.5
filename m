Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA1178F408
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347411AbjHaUa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241718AbjHaUaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:30:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D62E76
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35E85CE2215
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF8AC433C7;
        Thu, 31 Aug 2023 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693513813;
        bh=/wbKPnJAFoq6XFYpNk+kSPyAAz6H3Sq24WXX8IZyA1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K57txnU0Xv8M63sXZJqUJImryhs/4/VdLCThhEb8gRY072SgzEZOA2kXcf1OOf4Jz
         i5/Rq9EbOxW42D+9mRKxoUukTY/yn/bQ+IqKB/KQiwSbOkmAdf5hkUDXr81+O3JBPY
         9acgopbleYa3N6D1owf7L6tyIya9RBWJV6SPrh+i04R20v7ohhiMitqitsmnZ93U4y
         ncjCWX5l1h8jKDNYIhMXNLV7dxw51gR7/yQejaaVy2RePjmtJNXW5HgPwSKdzzXfFZ
         YU+TA507m2YEQVaBAXC4WTzMBz0uAxamo+DvuHYa9ev2U/FFnwAMDSDkKyQe53TXU2
         Wbs1hojcz9z3A==
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
Subject: [PATCH v4 5/7] sched/fair: Add trivial fair server
Date:   Thu, 31 Aug 2023 22:28:56 +0200
Message-Id: <a56fcebb4cb00a3d96ef148c46fd4a849751e7e7.1693510979.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1693510979.git.bristot@kernel.org>
References: <cover.1693510979.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index c780707e1761..4ba4f1e09a80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10055,6 +10055,7 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+		fair_server_init(rq);
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4dac16ed1317..7844cfb73029 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1403,6 +1403,13 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
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
index 5ded18e28609..580e6764a68b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6499,6 +6499,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
+	if (!rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -6643,6 +6646,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
+	if (!rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -8291,6 +8297,29 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq)
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
index f30be4ae4c22..ac94c386741c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -351,6 +351,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void fair_server_init(struct rq *);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 struct cfs_rq;
@@ -1024,6 +1026,8 @@ struct rq {
 	struct rt_rq		rt;
 	struct dl_rq		dl;
 
+	struct sched_dl_entity	fair_server;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
 	struct list_head	leaf_cfs_rq_list;
-- 
2.40.1

