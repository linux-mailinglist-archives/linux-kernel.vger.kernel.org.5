Return-Path: <linux-kernel+bounces-133422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A7189A37A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96FC1C2167B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE817165B;
	Fri,  5 Apr 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxV+qsna"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B995171E47
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338109; cv=none; b=JOJJ3LwX8YAZ09Ru5zohRkHxF617pplI4ENK6r4Hy+hwhtohi9PsgI8OsQEC57Zr7a9VsOd0sIXjfXx1Zj9rZOSKsYBvjREt4ao1A/lI1ka5wv9ngcmohrQ4VUuR1zPx6HH7apsz0dERQfimIqQY/LUjrF8qdegBihyKgXfgCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338109; c=relaxed/simple;
	bh=duyVCafABsJQnwShlexpY7ydtdqahkofOOyxVGW5Et8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiyHbcB87d4fncIt4+7KH6T6jfuwAfSFTTgTy+V1fKfem4Xs5QYt5cV/lL1A4qVXQ4Kv9VbMdNf+Jx3+6hp1k+8VEP15h434Mi/FOyydmaFl5csi/7oHU5mbG67kGLgmChCB1BwKMdOpEz+ZGIMUCB7j5XfN4ftWKXYRo6u1kkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxV+qsna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8B5C43394;
	Fri,  5 Apr 2024 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338108;
	bh=duyVCafABsJQnwShlexpY7ydtdqahkofOOyxVGW5Et8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxV+qsnaG+yg/iHqGNaB1rO9GuLVIaoyN2cd0jkb3kr74sLkVgCo1E+vV44toUka8
	 WbRVmW5oNzlg4ZuMcebVkd3dHVkj0ZH5KYtFjgQsE8NvqTEI3jr3AHaHqcRjl5XOtx
	 yjGjNiLuNfINPuHaiddo0+N05/KYFE3sH1J3dqRfrbPq/fY+bKm7lf95OijqTxpIZA
	 JRq3azKC+yxUcDR9sAOkXJOrBWSywCCvAUiOy1CoOjuHTL022wNr1c7bnKFQCmDC85
	 hZm0qVgmZ4ayO0iRUs6bMcw94entA0HulYOfNJunzzBjGV3N/Ny3T+CvZFU2+gc2wc
	 gOWOFJyTyOAMw==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V6 1/6] sched/fair: Add trivial fair server
Date: Fri,  5 Apr 2024 19:28:00 +0200
Message-ID: <d1e02419599172f4045a4711b9ff78081f568bb8.1712337227.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712337227.git.bristot@kernel.org>
References: <cover.1712337227.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

Use deadline servers to service fair tasks.

This patch adds a fair_server deadline entity which acts as a container
for fair entities and can be used to fix starvation when higher priority
(wrt fair) tasks are monopolizing CPU(s).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c     | 24 ++++++++++++++++--------
 kernel/sched/deadline.c | 23 +++++++++++++++++++++++
 kernel/sched/fair.c     | 25 +++++++++++++++++++++++++
 kernel/sched/sched.h    |  4 ++++
 4 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..04e2270487b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6007,6 +6007,14 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 #endif
 
 	put_prev_task(rq, prev);
+
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->dl_server.
+	 */
+	if (prev->dl_server)
+		prev->dl_server = NULL;
 }
 
 /*
@@ -6037,6 +6045,13 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_next_task_idle(rq);
 		}
 
+		/*
+		 * This is a normal CFS pick, but the previous could be a DL pick.
+		 * Clear it as previous is no longer picked.
+		 */
+		if (prev->dl_server)
+			prev->dl_server = NULL;
+
 		/*
 		 * This is the fast path; it cannot be a DL server pick;
 		 * therefore even if @p == @prev, ->dl_server must be NULL.
@@ -6050,14 +6065,6 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
-	/*
-	 * We've updated @prev and no longer need the server link, clear it.
-	 * Must be done before ->pick_next_task() because that can (re)set
-	 * ->dl_server.
-	 */
-	if (prev->dl_server)
-		prev->dl_server = NULL;
-
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
@@ -10051,6 +10058,7 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+		fair_server_init(rq);
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..db5dc5c09106 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1382,6 +1382,13 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 			resched_curr(rq);
 	}
 
+	/*
+	 * The fair server (sole dl_server) does not account for real-time
+	 * workload because it is running fair work.
+	 */
+	if (dl_se == &rq->fair_server)
+		return;
+
 	/*
 	 * Because -- for now -- we share the rt bandwidth, we need to
 	 * account our runtime there too, otherwise actual rt tasks
@@ -1415,15 +1422,31 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
+	struct rq *rq = dl_se->rq;
+
 	if (!dl_server(dl_se)) {
+		/* Disabled */
+		dl_se->dl_runtime = 0;
+		dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
+		dl_se->dl_period = 1000 * NSEC_PER_MSEC;
+
 		dl_se->dl_server = 1;
 		setup_new_dl_entity(dl_se);
 	}
+
+	if (!dl_se->dl_runtime)
+		return;
+
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
+	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
+		resched_curr(dl_se->rq);
 }
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
+	if (!dl_se->dl_runtime)
+		return;
+
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..304697a80e9e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6722,6 +6722,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
+	if (!rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -6866,6 +6869,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
+	if (!rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -8538,6 +8544,25 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq)
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
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+}
+
 /*
  * Account for a descheduled task:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..205e56929e15 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -340,6 +340,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void fair_server_init(struct rq *rq);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 struct cfs_rq;
@@ -1016,6 +1018,8 @@ struct rq {
 	struct rt_rq		rt;
 	struct dl_rq		dl;
 
+	struct sched_dl_entity	fair_server;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
 	struct list_head	leaf_cfs_rq_list;
-- 
2.44.0


