Return-Path: <linux-kernel+bounces-127193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B378947E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234811F22C5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768559162;
	Mon,  1 Apr 2024 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhtwqDpo"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F358ACC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015100; cv=none; b=LdSf47+yGGZY37mwhRnWgiHuzqq2zr+9uRZsFOzNNa4DTy8/ZUOzkCZwxeykgB105eHn8EtL0rDdfnOA6stpCfZzwhP26mKRx/f0qc1Hst1aAEK6c4+SIX08+Qxna1bjJIqnxgAZ8H74RhzMn/gN3wBomeI0Ir4D3eGiIGULVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015100; c=relaxed/simple;
	bh=xOMUb+GmiXukMH9HQceN3GVQdj0ZjM9Tp+Q+1CsUWig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b5hVLrEOkgZ18u6HNTQwHJGRrgvaKllJhW6lLduJufWxvuX5y+GVFMKGNYGnnm53dTGmOiAClH46U4pyxX0yFBtMwdx17jDP4vDNE8alO1Ka4R23Rcqsx3+FxfgMIi0fq6uH4V4D4NxAjszS7Lzvm77pv5P/T4yOM6ZxQp3HDFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhtwqDpo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so7104800276.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015098; x=1712619898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgqtM/d+7PpQv4HE31iqvyKrSmgqLa7oQqkgUO0r7vE=;
        b=fhtwqDpoEWrXo0lB5QIDUAOhYIl61Qn9zQXIuF4HEr/OSFJ7YykZG9dmmiYDRvZbCH
         W4MJjv6oYU5204fN1F29HeVnXV02CIYyV+y97ydv0GIKjag3PSvTEq31RI94pC1G2J+g
         UOvaepNyyK89AiEdhIAFZcE6O1a9yncTEwl/5tE84jMenm/v4fCVgY7RF0A+FLv21G59
         7uUgl+/ch/mhaTk7rKmQFkkY9YYR8AsR5odVt+nuEYk560LUpr4D6Z7rua+PfjlYAQdX
         o9XAsEp1O+qxGdZqTlxkoxYpw+5KoIwQ0fZqwhzjR1K3pASNBw+Lbk+h660DhyowS08q
         BJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015098; x=1712619898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgqtM/d+7PpQv4HE31iqvyKrSmgqLa7oQqkgUO0r7vE=;
        b=FWr7Q+6gw4AJj1yrpwlfeT5+9Rqno8D5pZmxlQXpaZ8oAZR7EDQsUu7u6nHYzDsLAs
         aWGwixNEZv3Q8EuNFAOnv6gKCsWsvxfTFLDwNBNM1wJ+BfD8tPINdbecIhwmkvw9v3H8
         p+ms2bGZGPMfTN/xHsH0OKs1A1CL4GZaaVK1u7RoHx+rLCwVqBYu/HhpNd7CZJLZZbgm
         TqIMhLysYDTymmLiA6dboDHdGb2juH3qrNi6KXxVQ/GY5mULBk1RcWTArE8pyM4hUk77
         VohALRGQMqxqZahMArJFjIGZn5idN1u+iIuJ5Q3RWSAU7tQNGV6R9f31DC1tS9cTAaLS
         nRig==
X-Gm-Message-State: AOJu0YzKgq5aKq3J9YKg/EPMHkAd5/jnEBtH0qwL6t+mMkJt+OwU3CRS
	nrr7TzIMCRWVdyFNn7a4Nu06MROqp47dah4hqvx/BN0+EYlMbYTCphkpUTaLdJ7Pk3Th7dxM3n1
	O2LGNpUCaxfeXfS5IDvN7VVEo6FzA6VVsxz64XCs9+qgh6voIbICsOda7GxRvyTCF/zOlRL/PIB
	Q1uy38aPkKxkvU4ZNP785x2eAqT/Otc65Xut+jvrPiBAKF
X-Google-Smtp-Source: AGHT+IG81utI2kl1Gn1sM2N8PqFdBdAaI2i00f63wU9a+w5ADuC0vVidLWOXzMl+jp7aeSU/i4t9+9F8b9w5
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1006:b0:dd9:4ad1:a1f7 with SMTP
 id w6-20020a056902100600b00dd94ad1a1f7mr3543161ybt.9.1712015097848; Mon, 01
 Apr 2024 16:44:57 -0700 (PDT)
Date: Mon,  1 Apr 2024 16:44:28 -0700
In-Reply-To: <20240401234439.834544-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234439.834544-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234439.834544-7-jstultz@google.com>
Subject: [RESEND][PATCH v9 6/7] sched: Split out __schedule() deactivate task
 logic into a helper
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
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
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
index 586a3f8186bd..0eaa0855ef86 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6572,6 +6572,48 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
@@ -6665,35 +6707,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
2.44.0.478.gd926399ef9-goog


