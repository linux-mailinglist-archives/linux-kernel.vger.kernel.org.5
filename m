Return-Path: <linux-kernel+bounces-69165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38144858545
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95EC1F2175B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947281369AA;
	Fri, 16 Feb 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CeyE2qJQ"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8A135A55
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108310; cv=none; b=b3nVVwMX2+GYVPkF5FFqXLJAlwRrLK3YUvgBTmTL9TdNe+zEIVXduqLRj8rs1iLxOw556KpXSiOldkfXNJOtOgq4U3+BPEw0aepbs9xGaRXkMzcQBBvJSeMb1x4wqTJU336EHwL8UYXCH4IdbTiVnIaW+2h+bdjMETRyQJHkgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108310; c=relaxed/simple;
	bh=hNtzJxrNKpS3WmLYndaWMBO3so/VD/gQO0uqcJZ9FDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yteq4Rl/ecr1SEt0ocOq1Gmo3iNK79YkkxxjIpHnlPSj/RmxMNkHRBrFME/p8evDCGNg1TsIwpUMvLw+TPQCS8+NLzLOIMiVTUfT3th/hn59BLH1qVHkE2WrYVJFFC6leRS1h5zmpLeiARwNVrr57EjKlSRCl9qtY+meqPWsR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=CeyE2qJQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42c758f075dso28644121cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108305; x=1708713105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWiejWekyqz80XlkFsn0hVk2ugnWY0u297YrWVho63A=;
        b=CeyE2qJQQJZ35mXekLyB86cXhkXFSbDxRT9lZ9DQpr45yQ9v082goouHNxfg1foozC
         6PB0fJ680jVN+s+lLFaJCZ/bRWFow2Ny9QFEHFdwyt61xfpDQ3DCoIvnqdRLe2EUQvr5
         xVb1yt0CWobqdlWkhE/97mu1Dwj9co2TipWQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108305; x=1708713105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWiejWekyqz80XlkFsn0hVk2ugnWY0u297YrWVho63A=;
        b=b6l1gQsoQCB01lIoD4RwT41s611YxKpidN0rpk3BVIbKkjztVo1vB9VK7DQbt+CFvS
         pQF2yNpmD41AAa4c/K6mFs8h4aoHw3XJJm80jCmZsjDGcjExOstqbYIfgfyHYbBM4hWb
         qgMOzGmlmNT0ovV4w6VWW0CHKXDqVBSXe1GZY+JkTRrlKIXG8Xgv4p1DZHTojh2L4E9T
         nLQeF1p6Aq53YD6Fu05qZlkd6lS10DMzBDk6lrNxYtHJm17IjY+HRGCTrexIR3LZBW7e
         V0UphFHDlZ54aKTb9av74TSO5QORpDLhx+3OUmWUNV8EB59arLKiOPUOhek7IBJfs5V8
         ffGQ==
X-Gm-Message-State: AOJu0YxcI5fe0yGOWfrzpb40QEo/TU0iQhUyDWBRTKFzlrsvpulNE9Y9
	dhemF/OoXVN1uaVVTIFgTESJsbyugTU3IZhzAxHg1JI0YYL1p4gCtTDuZLOo4EIO3KOLptLEv3t
	6
X-Google-Smtp-Source: AGHT+IGtapIZSGJEWHqUvJNtGggfyhY0BnHoicBTpBbCh4J5VImko1k26gN2OiIiEvBLe0zTdUeaxA==
X-Received: by 2002:a05:6214:3a8a:b0:68f:1102:680c with SMTP id nz10-20020a0562143a8a00b0068f1102680cmr11071161qvb.5.1708108305165;
        Fri, 16 Feb 2024 10:31:45 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:44 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	David Vernet <void@manifault.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	joseph.salisbury@canonical.com,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 04/10] sched/core: Fix picking of tasks for core scheduling with DL server
Date: Fri, 16 Feb 2024 13:31:02 -0500
Message-Id: <20240216183108.1564958-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216183108.1564958-1-joel@joelfernandes.org>
References: <20240216183108.1564958-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Use simple CFS pick_task for DL pick_task

  DL server's pick_task calls CFS's pick_next_task_fair(), this is wrong
  because core scheduling's pick_task only calls CFS's pick_task() for
  evaluation / checking of the CFS task (comparing across CPUs), not for
  actually affirmatively picking the next task. This causes RB tree corruption
  issues in CFS that were found by syzbot.

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
---
 include/linux/sched.h   |  3 ++-
 kernel/sched/deadline.c | 27 ++++++++++++++++++++++-----
 kernel/sched/fair.c     | 22 ++++++++++++++++++++--
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a1f918674383..e5ad1f232b35 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -672,7 +672,8 @@ struct sched_dl_entity {
 	 */
 	struct rq			*rq;
 	dl_server_has_tasks_f		server_has_tasks;
-	dl_server_pick_f		server_pick;
+	dl_server_pick_f		server_pick_next;
+	dl_server_pick_f		server_pick_task;
 
 #ifdef CONFIG_RT_MUTEXES
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f5aaa3adac94..8fafe3f8b59c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1567,11 +1567,13 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 
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
 
 int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
@@ -2271,7 +2273,12 @@ static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
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
@@ -2285,7 +2292,10 @@ static struct task_struct *pick_task_dl(struct rq *rq)
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
@@ -2300,11 +2310,18 @@ static struct task_struct *pick_task_dl(struct rq *rq)
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
index b48287629610..9cc528a14001 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8392,6 +8392,14 @@ static struct task_struct *pick_task_fair(struct rq *rq)
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
@@ -8551,7 +8559,16 @@ static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
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
@@ -8561,7 +8578,8 @@ void fair_server_init(struct rq *rq)
 	struct sched_dl_entity *dl_se = &rq->fair_server;
 
 	init_dl_entity(dl_se);
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_next,
+		       fair_server_pick_task);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4d2c216049cb..bfb15037489c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -338,7 +338,8 @@ extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick);
+		    dl_server_pick_f pick_next,
+		    dl_server_pick_f pick_task);
 
 extern void fair_server_init(struct rq *);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
-- 
2.34.1


