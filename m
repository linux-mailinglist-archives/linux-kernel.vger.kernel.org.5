Return-Path: <linux-kernel+bounces-132883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7371D899B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289F32856E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198ED16C851;
	Fri,  5 Apr 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5UkV30L"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D916C451
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315047; cv=none; b=nZQw4IFcoKmNK/fWdfvWBoPtkakVXNSFVJBsmUFwkd/LhbgjD75dZ2OJ3abc1gCjIj2PdAo5Kb8X0XQ3dOKpL+l8+KXw6ItviS9RqV1aT3yYmtbbgAnB2MYyOvpBPMkiUPstZgaOqxoF2ch5faWSM1wOKPzo0J0l5nCEemVqyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315047; c=relaxed/simple;
	bh=nKS2WmuYGE6Nye140v5b3g89kHuVxIHGUJk53tUK2Yg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=K+76N6Z3alP3E/ZtW2PN8I2f9Ht+l7SkyXdsCXWbJsp2tC0o9L/81Sawo6NQzloGPN68kCmG/+fSgB7XhO3jJ6YjkrQLKALrVi2xJmFkDHXyg3W4D8ecrkKSBgsWUJKsuKTDJ33oPsfu/VB3c5gwBL/iOp93/8OhPfIbjkue+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O5UkV30L; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=XqRGGtihCZYBUet+PwKwmohLFDruabUWfUMdx2OINkA=; b=O5UkV30LEO972j+CaiXeaYeWi2
	etntYrEu5EVyDaxA4QaqECsLRCCRxXyKPkOzQ/ygkrtSu6kanWoirUtsdHzLvr8B/Otl3PM6bYSEi
	hsHjEchmuXi122lSdAsqb6iYzoimQWfRevgvadTgoCXualBOHLEA12p4JyQsVYcX84trGiyMWx2Zc
	YzqdaZZ1KzW4MoSCJLBA/e+xQvlktgfjX82BbijPJrEXxJp5AG9QOB53YnWfVNcmSGcV11q3zoX8t
	CjRmROtGtrOw/Z1LMjIL1rXT9fNuWdgITxg0lyeoQemDyyrsfkDEWL1rocRMQBCbnayKGfyg9JYZg
	/C42QNLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMH-00000005Z8j-27sk;
	Fri, 05 Apr 2024 11:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9354F302DA2; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110010.381534287@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:28:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [RFC][PATCH 06/10] sched: Allow sched_class::dequeue_task() to fail
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Change the function signature of sched_class::dequeue_task() to return
a boolean, allowing future patches to 'fail' dequeue.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |    7 +++++--
 kernel/sched/deadline.c  |    4 +++-
 kernel/sched/fair.c      |    4 +++-
 kernel/sched/idle.c      |    3 ++-
 kernel/sched/rt.c        |    4 +++-
 kernel/sched/sched.h     |    2 +-
 kernel/sched/stop_task.c |    3 ++-
 7 files changed, 19 insertions(+), 8 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2119,7 +2119,10 @@ static inline void enqueue_task(struct r
 		sched_core_enqueue(rq, p);
 }
 
-static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
+/*
+ * Must only return false when DEQUEUE_SLEEP.
+ */
+static inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (sched_core_enabled(rq))
 		sched_core_dequeue(rq, p, flags);
@@ -2133,7 +2136,7 @@ static inline void dequeue_task(struct r
 	}
 
 	uclamp_rq_dec(rq, p);
-	p->sched_class->dequeue_task(rq, p, flags);
+	return p->sched_class->dequeue_task(rq, p, flags);
 }
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1842,7 +1842,7 @@ static void enqueue_task_dl(struct rq *r
 		enqueue_pushable_dl_task(rq, p);
 }
 
-static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
+static bool dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
 
@@ -1852,6 +1852,8 @@ static void dequeue_task_dl(struct rq *r
 	dequeue_dl_entity(&p->dl, flags);
 	if (!p->dl.dl_throttled && !dl_server(&p->dl))
 		dequeue_pushable_dl_task(rq, p);
+
+	return true;
 }
 
 /*
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6828,7 +6828,7 @@ static void set_next_buddy(struct sched_
  * decreased. We remove the task from the rbtree and
  * update the fair scheduling stats:
  */
-static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
@@ -6896,6 +6896,8 @@ static void dequeue_task_fair(struct rq
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
+
+	return true;
 }
 
 #ifdef CONFIG_SMP
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -486,13 +486,14 @@ struct task_struct *pick_next_task_idle(
  * It is not legal to sleep in the idle task - print a warning
  * message if some code attempts to do it:
  */
-static void
+static bool
 dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 {
 	raw_spin_rq_unlock_irq(rq);
 	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
 	dump_stack();
 	raw_spin_rq_lock_irq(rq);
+	return true;
 }
 
 /*
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1493,7 +1493,7 @@ enqueue_task_rt(struct rq *rq, struct ta
 		enqueue_pushable_task(rq, p);
 }
 
-static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
+static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
@@ -1501,6 +1501,8 @@ static void dequeue_task_rt(struct rq *r
 	dequeue_rt_entity(rt_se, flags);
 
 	dequeue_pushable_task(rq, p);
+
+	return true;
 }
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2278,7 +2278,7 @@ struct sched_class {
 #endif
 
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
-	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
+	bool (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
 	bool (*yield_to_task)(struct rq *rq, struct task_struct *p);
 
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -57,10 +57,11 @@ enqueue_task_stop(struct rq *rq, struct
 	add_nr_running(rq, 1);
 }
 
-static void
+static bool
 dequeue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
 	sub_nr_running(rq, 1);
+	return true;
 }
 
 static void yield_task_stop(struct rq *rq)



