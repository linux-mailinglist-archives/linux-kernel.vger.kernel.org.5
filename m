Return-Path: <linux-kernel+bounces-101004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107FF87A0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3325A1C2180A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858EB134AD;
	Wed, 13 Mar 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="swMwzoG2"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA41118C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293115; cv=none; b=eB5dv8WmiPZ/H4X675J64dRS0elCtcUNLd75hKO29N72wNMWxJoInlWEQg6o8YgmRZMSb71XK17o5NKDNtpAg4jACWuDoBCxpDWmxjUXNScpl0v4oxuX9lZSlm23PXnOlrVUuTejHiRYbV8b681ghA6oZwFG3S8zMm8/lkVTg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293115; c=relaxed/simple;
	bh=hNtzJxrNKpS3WmLYndaWMBO3so/VD/gQO0uqcJZ9FDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGRHI66L1RYKOILKHQIXZWwDgi1/prnhQdOH6/JB9+ZWM+4cqFVPhRaajbvGWdBntY5WTOvG0LdHcZwqphwZAgnVsNIh2dmkSBSLgKEYmLXgjpC1R9GRFXN8w0/YvDhLzcrZSkTgDEgnMmbK2GM4uNT26KQPSY/RNJR9Z13UnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=swMwzoG2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690d75c73f4so3174536d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293112; x=1710897912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWiejWekyqz80XlkFsn0hVk2ugnWY0u297YrWVho63A=;
        b=swMwzoG2VIbORp8/S6NBBQYCyEVgeGngsMs57wited+u03NlC5ufxN/6TTZuPKqIuQ
         zXlbRn5m9VrgmkIbubaHW+d2J+zLTCIrhvcpEGGHvuxmBMVcJSiQiYRE1FNAPXy9Tmfd
         bZa2+jBoZF1lA0zBHhrxwVB22eJcDbrrZggKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293112; x=1710897912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWiejWekyqz80XlkFsn0hVk2ugnWY0u297YrWVho63A=;
        b=E8YaOKwbPKTGIfZjh4Z/uY7m7vrtdBAVTx9TEym9047HLquK7+o/XC+4igkS5bAlWq
         0PIjSZulol7o7ne6ec2HiYwaDVq5vFIG4AsssHmqoWWQZhtesY80zQfrqGDy15yxj3nn
         FrGupOyWaYVCPqe785B86Y0VvNcizfIOk8AMix8E0AOfkXjVD/6XkeA2qKM3lRi3B52b
         vgkzB308jM4f0kdPPz1ia2M+PS1q6xscmtDysx1J05uoXSrjiBKRrVPo81e/5gaXd1Zh
         MpbCtIKPaq/bBwv2AphNLltJ/6XzVLUEKrmdi6U0Qses+BWJHx5T5yVcchaoKjpW7Fce
         YiQg==
X-Gm-Message-State: AOJu0YyRg9sRjslakdaJPC2X0/czPVtw5/s598IdHUOt246QIl5Mcae9
	EI3uR5YVkZxg16/ccQuK6icVaQEyYapI/c4JUgm1dAzma85b7sj0tRm+ccQl8qleeN0v5A4XBk3
	+
X-Google-Smtp-Source: AGHT+IFSu/SsNjZq+nLX5Zr5I4foqpNC570CwqJS/49KTVhFC/Y2PX7gbXw0Yf5FwpGv30qTpLiBHg==
X-Received: by 2002:a0c:f687:0:b0:690:cc96:ba2d with SMTP id p7-20020a0cf687000000b00690cc96ba2dmr1899593qvn.60.1710293111644;
        Tue, 12 Mar 2024 18:25:11 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:10 -0700 (PDT)
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
Subject: [PATCH v2 04/15] sched/core: Fix picking of tasks for core scheduling with DL server
Date: Tue, 12 Mar 2024 21:24:40 -0400
Message-Id: <20240313012451.1693807-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313012451.1693807-1-joel@joelfernandes.org>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
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


