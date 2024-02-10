Return-Path: <linux-kernel+bounces-60184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5545D850118
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E71C2546D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F87810A16;
	Sat, 10 Feb 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSggqmaJ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29B8F4A
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524629; cv=none; b=WIXi/I7d2ca0oqlyJjSkqKetml0u2ijqsCe31oT+j52BmPN6ubFwOudlUhs6MAonClFhiBwAo4grRU6xzgMdUA2eMdkR5vpOVXzm8sOIr6yd9hd5t6r0yopMoPoyNb7/pWwWVYRLbyFt48aojdF57JTrbBbArWu585Mu+RO/bQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524629; c=relaxed/simple;
	bh=kmDH6T7WV6qaFmXYpUOVLT7kQ2NUoOiS1/tXVBLKpdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofGFdKPddh7THS9/63YxksSLOf+lPpDINwJX8scHjtcRpeuzRZ7tlb9FA6vB9knDsS3LGF3r7kVRT24wTfcOlqD4UNzE/qNiK+NgP+idG5dUNUR93oRnHztKLAtRV+hxpKCrwJ3kKUDUZE30Yw69GZamHVVvBiFwDTr7s2YayhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSggqmaJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604a52664d9so30414867b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707524627; x=1708129427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVQs41j45YpWDUG3rQkDZ0HYMJ4B7s1Xw+YLIcCiuX4=;
        b=CSggqmaJPga+u/QpYrYbWxufvr+thfGw9IiqVrp7+pncZr+GAS4pp6vvaHCPw+urxn
         Yiu6bKQn576VjBH0N/HiOWNmZFCC4Dg00QdoUNzAG+o4soaZaW1ewt0c004kGg1eQ4wR
         AsGLYxxR9sRAJkmajqgfVcakL4zmTWEawhCPEz07Gvn/eA7+i+e27SHB9xjVig5oJxx3
         UyQIrh0wTlsm8qSLuen4bs1lkg3Q+/H9fMFWx8MxaGhGqpl9OuiVn9Q9j9eWDJReOLvy
         1peW+rwMPhn8t4ysdxFDMKkvHYKK/7X4OOxWaWbGl3smCl3sElemumH6dTAlFJqKZmhJ
         4SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524627; x=1708129427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVQs41j45YpWDUG3rQkDZ0HYMJ4B7s1Xw+YLIcCiuX4=;
        b=iJXujQlDWhuRuMYz13R+rG/yvSbloRC7zjczJcbz95YnZQQQogrisS4vJ0aIPH9S81
         DEbLY5NJcjJirpPp62ItcwusagcIhWZr4ln3MM3g1GdHXC9rn2dl74p1I6NRS4o25nnn
         kb1fJ9L8WyYE51r66NTqaeVpqchMxiabnD8XYLLE8eYAAcDEbnH8PwHiwTbmK8UEpzu2
         dj5hMu8AHgrLgsFVuLjNpmq9E/FokLObLwBLHxpwjsVGjnfzcChi9e9CW97JENFZiaQT
         O6Mh4g8hU4LO0qoq8IkLKH9Be+oLsCIh07jeOkkucd/ZpkljX957U4iuzBoIKDjQtXru
         Dv4g==
X-Gm-Message-State: AOJu0YzkjSU2BIvWUb8Jux4IyEVG1xFrh5H1WClB9wM0K0JDyAdKoye4
	SRmNwRAY1JsP52N/rDk/evC3yOWA5QiEvWWx7cXuJxQoFWVen3NevBZRfe7yAT/Xw82iThr50I/
	9wD0LCPv3auzWpcjvEh+KFzDt5bg4/KHEuvlKre5AEuQpE5Mub8gUcdlnfNdEIAggkWzIn+E7KE
	5sXVe5q1hgw2azk0MA32PawhpZ6SSW2XITzPDb1yYHPNqd
X-Google-Smtp-Source: AGHT+IGBerHcLyc19vvxAMI8SxtcyAiKkz9gpwLT9Old6YDDjO/d7YkB8jtKpC24nYciEpTnB0U6yRQfJIA8
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:c07:b0:604:42a3:3adc with SMTP id
 cl7-20020a05690c0c0700b0060442a33adcmr199082ywb.10.1707524626873; Fri, 09 Feb
 2024 16:23:46 -0800 (PST)
Date: Fri,  9 Feb 2024 16:23:15 -0800
In-Reply-To: <20240210002328.4126422-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210002328.4126422-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240210002328.4126422-7-jstultz@google.com>
Subject: [PATCH v8 6/7] sched: Split out __schedule() deactivate task logic
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
2.43.0.687.g38aa6559b0-goog


