Return-Path: <linux-kernel+bounces-133427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4806989A383
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19F02826D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176717166F;
	Fri,  5 Apr 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1Hy0+Hr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953F1CFBC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338430; cv=none; b=X4O0S5oTMfxLDU2IuoHRfZF+UfTZoMbajTOa8Ex9MLDqh3A0w9iidY5ZvZiEl5AhDiJ0U0ctr8N/zxICMMlt4G+0Ne8q9oilV+dlglclLvPF2xavY3vE+ALvhldSbXeK10UZqk4BCWDJktq5f5FZ4LQqW67Jdaprfpfr5788OPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338430; c=relaxed/simple;
	bh=1BpkzgEXIu2Ef0PumiErjzWEX1nn+L3uV3QP5SZbExI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWp3uXSfH+NA5/8XE6IBv9KJdSZMCjfFllkJy6thiIti1WIl/2rf1finefhDgdkDuj+B6IfBHegllGYfevk+MvsF8vp666OeglZ2u/X2DOIuYbtjyeLvKmxKm6C0UtJ+hb3yraNxs4g8woXzW3Eg5MVqLfMwcNGE9Zk36qMSVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1Hy0+Hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45423C433F1;
	Fri,  5 Apr 2024 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338430;
	bh=1BpkzgEXIu2Ef0PumiErjzWEX1nn+L3uV3QP5SZbExI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1Hy0+Hr5YzJGuPpDrwJQO3y3Kj/6hfUCuAjrYQro2f/8g4g29XIlGUqGP3RUtRX2
	 5gdAOtxBOQ6qf1rD0VvMbT+glG4AAlJzuMx76y+50DqbikknMefTKrPRgJTkvGUzWq
	 cF5HUoqDr0SIJJjmunlFIUrg7TkTtDs8PGJRzqduhnvLh2S8JWg9yY8SbkNc70md6m
	 xIqm2kIfviYOVdBtOfcUV5z1swJdDzpsHB3HMeDX7PimbSDh4RqtPkLGIirhPM5AUa
	 AHsZ4aaKiFhWCFDflnc2DZLfWYq56cXJr6FUOTHnYtooKsi9Vri/JRX862Cnd7tyRT
	 LXWueo0sM+uZQ==
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
Subject: [PATCH V6 5/6] sched/core: Fix picking of tasks for core scheduling with DL server
Date: Fri,  5 Apr 2024 19:33:39 +0200
Message-ID: <527a56dd5190a88da9135992d37285caa15024b3.1712337227.git.bristot@kernel.org>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

* Use simple CFS pick_task for DL pick_task

  DL server's pick_task calls CFS's pick_next_task_fair(), this is wrong
  because core scheduling's pick_task only calls CFS's pick_task() for
  evaluation / checking of the CFS task (comparing across CPUs), not for
  actually affirmatively picking the next task. This causes RB tree
  corruption issues in CFS that were found by syzbot.

* Make pick_task_fair clear DL server

  A DL task pick might set ->dl_server, but it is possible the task will
  never run (say the other HT has a stop task). If the CFS task is picked
  in the future directly (say without DL server), ->dl_server will be
  set. So clear it in pick_task_fair().

This fixes the KASAN issue reported by syzbot in set_next_entity().

(DL refactoring suggestions by Vineeth Pillai).

Reviewed-by: Vineeth Pillai <vineeth@bitbyteword.org>
Reported-by: Suleiman Souhlal <suleiman@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/sched.h   |  3 ++-
 kernel/sched/deadline.c | 27 ++++++++++++++++++++++-----
 kernel/sched/fair.c     | 23 +++++++++++++++++++++--
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4a405f0e64f8..b0a5983cf3d1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -673,7 +673,8 @@ struct sched_dl_entity {
 	 */
 	struct rq			*rq;
 	dl_server_has_tasks_f		server_has_tasks;
-	dl_server_pick_f		server_pick;
+	dl_server_pick_f		server_pick_next;
+	dl_server_pick_f		server_pick_task;
 
 #ifdef CONFIG_RT_MUTEXES
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index dd38370aa276..45fde2fd3a1b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1665,11 +1665,13 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick)
+		    dl_server_pick_f pick_next,
+		    dl_server_pick_f pick_task)
 {
 	dl_se->rq = rq;
 	dl_se->server_has_tasks = has_tasks;
-	dl_se->server_pick = pick;
+	dl_se->server_pick_next = pick_next;
+	dl_se->server_pick_task = pick_task;
 }
 
 void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
@@ -2398,7 +2400,12 @@ static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
 	return __node_2_dle(left);
 }
 
-static struct task_struct *pick_task_dl(struct rq *rq)
+/*
+ * __pick_next_task_dl - Helper to pick the next -deadline task to run.
+ * @rq: The runqueue to pick the next task from.
+ * @peek: If true, just peek at the next task. Only relevant for dlserver.
+ */
+static struct task_struct *__pick_next_task_dl(struct rq *rq, bool peek)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2412,7 +2419,10 @@ static struct task_struct *pick_task_dl(struct rq *rq)
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		p = dl_se->server_pick(dl_se);
+		if (IS_ENABLED(CONFIG_SMP) && peek)
+			p = dl_se->server_pick_task(dl_se);
+		else
+			p = dl_se->server_pick_next(dl_se);
 		if (!p) {
 			WARN_ON_ONCE(1);
 			dl_se->dl_yielded = 1;
@@ -2427,11 +2437,18 @@ static struct task_struct *pick_task_dl(struct rq *rq)
 	return p;
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_dl(struct rq *rq)
+{
+	return __pick_next_task_dl(rq, true);
+}
+#endif
+
 static struct task_struct *pick_next_task_dl(struct rq *rq)
 {
 	struct task_struct *p;
 
-	p = pick_task_dl(rq);
+	p = __pick_next_task_dl(rq, false);
 	if (!p)
 		return p;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdeb4a61575c..b86bb3f23fb2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8406,6 +8406,14 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
+	/*
+	 * This can be called from directly from CFS's ->pick_task() or indirectly
+	 * from DL's ->pick_task when fair server is enabled. In the indirect case,
+	 * DL will set ->dl_server just after this function is called, so its Ok to
+	 * clear. In the direct case, we are picking directly so we must clear it.
+	 */
+	task_of(se)->dl_server = NULL;
+
 	return task_of(se);
 }
 #endif
@@ -8565,7 +8573,16 @@ static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 	return !!dl_se->rq->cfs.nr_running;
 }
 
-static struct task_struct *fair_server_pick(struct sched_dl_entity *dl_se)
+static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
+{
+#ifdef CONFIG_SMP
+	return pick_task_fair(dl_se->rq);
+#else
+	return NULL;
+#endif
+}
+
+static struct task_struct *fair_server_pick_next(struct sched_dl_entity *dl_se)
 {
 	return pick_next_task_fair(dl_se->rq, NULL, NULL);
 }
@@ -8576,7 +8593,9 @@ void fair_server_init(struct rq *rq)
 
 	init_dl_entity(dl_se);
 
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_next,
+		       fair_server_pick_task);
+
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a80a236da57c..b200f09038db 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -338,7 +338,8 @@ extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick);
+		    dl_server_pick_f pick_next,
+		    dl_server_pick_f pick_task);
 
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
-- 
2.44.0


