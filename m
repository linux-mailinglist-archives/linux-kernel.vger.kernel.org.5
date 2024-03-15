Return-Path: <linux-kernel+bounces-104053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122E187C850
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ADB5B22184
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE2015AC4;
	Fri, 15 Mar 2024 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNOt+Gzz"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46481DDA9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710477633; cv=none; b=lxO/RUyfPre42dJ4/nUzKGgrQLGazTAIoJVdJ5rdJL8iglWeBV8r+4mUfA/sD8d34L2/C4CIoQwbtC/cuvyHmcyO5ZDxn+CZj3Qx/zfcerC3hBRcOeLhTtcvcYTkgbEXdvZ1AWif5cRXdIsZ7nOvpRUhXjCU8xpYWcZPyWmyrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710477633; c=relaxed/simple;
	bh=oAooOCHqvipNleN1AM7UMHZk9HQovQoUz6g88NsOR8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdyqwWY9xZYCwHY1rtQR1HVThpzoPV/IU69dI00wQskujOKEVa43gEolajcFvMOx2vQim0tSteuOMOEvrO35KPYFmk43eM/UKf5eRmJ+iIeK9fQ8Pa3avDqCLmL7f+GvY45ffLHX2O0sZAmmP5VUzAb3SBaDYXnl1mfDmeCaF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNOt+Gzz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dd6198c570so21402835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710477631; x=1711082431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBZo6XA+wJmJL8a6sUAHL6sA97t7m/9VOLS633itAWU=;
        b=gNOt+GzzeVV6a5XssOtgwBLliZ28swzqCZKZra8D44e8MEv+HQhOs9Oq0OTt3N8VRA
         S4A34B9SUrETeWUSvEMU3TGuhszfpvz6NtTB52yPjauQ6LStvQdyl2UG1qDeEn1qF64G
         Vr7MUlRDbvn4cL/+yvJ+8aaaCyrPTkLNQgEQTzjuZxqajQjnL7xoW5NUwl7EyabTThj9
         v8FF+7kMjr1c4KrdVLP5qkGweKixoyRDQiJ1QvADVnIWP6l8uxkhZrX7/tTiOb+8ACXE
         mcgQ2uke1059D/ps9ssNjY4U+RFRdqlavUOl/m/tJ4R7fl8zC0iwYy/jf0nDF13bdDSl
         hLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710477631; x=1711082431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBZo6XA+wJmJL8a6sUAHL6sA97t7m/9VOLS633itAWU=;
        b=nkvfckrizy74aRFDJJeT8od6FYrRYIQhse18h7xw5t84IjE8Qq2GiNxh5WeL8IVZGj
         1XI7kXLQ+I5RC9qrjUDJ+NGd2mOMT7/bsW4n2ZJGwcZuWagLpNFQbYDJWSO+ndhIFDvo
         2NWJrhtbKckaFWHEcSBr222W96arep60IKjt09T/eGR2pEQ4pkLp/hjvMUxcA7xhAubb
         jjpxC1KOFB4kiqC/+lGMUKz3byyMqvxKfL1kNpnvn03U47SENdh4gsEaGF7jcSfM1huE
         ivvAZjodi+hzMHwumEYKC3lztdAfoW55zolS3IltbIS4NzTns/kTWFZUv1eINGJb+jfg
         oQOA==
X-Gm-Message-State: AOJu0YzAPuK6pPFNT+VJFd2SukAL+scdYlJ4x4ryljvCWSsdHOPt3nZV
	/vJ6dHpZwRUBGOexIDi8JALA/kbhSqRjvnULYVDJuPWdAnUTOwwMCUlZ77uUIY0zsD+4qF6SHtm
	LbFoXPpBsZ5bG8kn4qSbDgkTeAC1Q5d8wP0yP83MedfRmAily7MiEfw8b5c7yv36oDU3JfGb00p
	7wQP/oRyKLrv9YuaOB8GtXSKERQ6b2tR8MjSDjE9IZxOW7
X-Google-Smtp-Source: AGHT+IHss5N8ZAqEr3rl9cdGbf6FPS2z7cRMtDnwdBGjV7YvnymLRS0N8c1kHOh1jEjUBrNgEX8hJqbV+G42
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:e80c:b0:1db:a861:f0ff with SMTP id
 u12-20020a170902e80c00b001dba861f0ffmr23433plg.3.1710477630362; Thu, 14 Mar
 2024 21:40:30 -0700 (PDT)
Date: Thu, 14 Mar 2024 21:39:51 -0700
In-Reply-To: <20240315044007.2778856-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315044007.2778856-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315044007.2778856-7-jstultz@google.com>
Subject: [PATCH v9 6/7] sched: Split out __schedule() deactivate task logic
 into a helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

As we're going to re-use the deactivation logic,
split it into a helper.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
v6:
* Define function as static to avoid "no previous prototype"
  warnings as Reported-by: kernel test robot <lkp@intel.com>
v7:
* Rename state task_state to be more clear, as suggested by
  Metin Kaya
---
 kernel/sched/core.c | 72 +++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad4748327651..b537e5f501ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6563,6 +6563,48 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
+/*
+ * Helper function for __schedule()
+ *
+ * If a task does not have signals pending, deactivate it and return true
+ * Otherwise marks the task's __state as RUNNING and returns false
+ */
+static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
+				   unsigned long task_state)
+{
+	if (signal_pending_state(task_state, p)) {
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+	} else {
+		p->sched_contributes_to_load =
+			(task_state & TASK_UNINTERRUPTIBLE) &&
+			!(task_state & TASK_NOLOAD) &&
+			!(task_state & TASK_FROZEN);
+
+		if (p->sched_contributes_to_load)
+			rq->nr_uninterruptible++;
+
+		/*
+		 * __schedule()			ttwu()
+		 *   prev_state = prev->state;    if (p->on_rq && ...)
+		 *   if (prev_state)		    goto out;
+		 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
+		 *				  p->state = TASK_WAKING
+		 *
+		 * Where __schedule() and ttwu() have matching control dependencies.
+		 *
+		 * After this, schedule() must not care about p->state any more.
+		 */
+		deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
+
+		if (p->in_iowait) {
+			atomic_inc(&rq->nr_iowait);
+			delayacct_blkio_start();
+		}
+		return true;
+	}
+	return false;
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6654,35 +6696,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
-		if (signal_pending_state(prev_state, prev)) {
-			WRITE_ONCE(prev->__state, TASK_RUNNING);
-		} else {
-			prev->sched_contributes_to_load =
-				(prev_state & TASK_UNINTERRUPTIBLE) &&
-				!(prev_state & TASK_NOLOAD) &&
-				!(prev_state & TASK_FROZEN);
-
-			if (prev->sched_contributes_to_load)
-				rq->nr_uninterruptible++;
-
-			/*
-			 * __schedule()			ttwu()
-			 *   prev_state = prev->state;    if (p->on_rq && ...)
-			 *   if (prev_state)		    goto out;
-			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
-			 *				  p->state = TASK_WAKING
-			 *
-			 * Where __schedule() and ttwu() have matching control dependencies.
-			 *
-			 * After this, schedule() must not care about p->state any more.
-			 */
-			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
-
-			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
-				delayacct_blkio_start();
-			}
-		}
+		try_to_deactivate_task(rq, prev, prev_state);
 		switch_count = &prev->nvcsw;
 	}
 
-- 
2.44.0.291.gc1ea87d7ee-goog


