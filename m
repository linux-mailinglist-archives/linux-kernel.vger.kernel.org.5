Return-Path: <linux-kernel+bounces-79349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668C862110
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A42C1C2165D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602879473;
	Sat, 24 Feb 2024 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vq3YGeR9"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3F4A06
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733536; cv=none; b=pTEym9mDIgkjDZ81poR3/RyzEbwZiTpATGHEtVW5DZHgaqrRijbIR7ywvpQjqK19eJRaztrdglP0sK9Bb7a+6sm4LWTBF4I3+OLneqrO1ddPUXWOwaGZC/jW86BwwvAzNE8QoTeYgExi+dyM2fJi+3ksPomdFkoFsM1DPbMNDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733536; c=relaxed/simple;
	bh=nKZAtl5osJTvY39LprO7HB4iiScYjpHjj/s/9JAi5Qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VnC3GTHEmBSuNwKyCPyGnmz+/7v9LeT1GE4SoDq7+M0NDNLo4lURRbUumkZYz1wcSWbKOsjn+P/S57hjOHU0z80NOiRDEIKY3nrtkYs5hTjoVNmLItOkzxTxGRjYRs7aPeTWU4wPaHoU8dFa0UvrUijYW9QjmfryaOo6oht9l4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vq3YGeR9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6da57e2d2b9so1236343b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708733534; x=1709338334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHlNRQX7p0VNcoeOcU22X7qC0ty7JjpX7n4N9uoKw40=;
        b=vq3YGeR921/1Q7pRxX9PJqIbsj9Zph/bNDaB2CwYZBGsz4DBoEHa46iA8K+vHCgzwb
         R6z/XP/p2ds08gGmvWYaCA2GikdJYDISJ+c59uQmVd/8gNcA7fS6iH78c8zAIoHIZCoi
         hgTYdKpDMq2T9CfvXTAQRjm6PqwnAWdOJ3V683w6Zg40Crvtyvu45plxtHRFiWjQhI0p
         UYPfWu21ViFvdDr1DIzIylCkbmockq5GeDMfNOzP9uxm6L2Y2gMbSOFwNrSsJTfIwbBb
         3bxGTNdvNHKvDVDC7BA2FxKKQn2exy3BJ/jO1/FuSKT2eUB/BSibHf3WsmajrfvFoUv0
         0/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733534; x=1709338334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHlNRQX7p0VNcoeOcU22X7qC0ty7JjpX7n4N9uoKw40=;
        b=sEu7CZLFbUNouXF/xOjNF1/2mefkW48YhKkHhR3u6JOCvcpgZ+dwxbFU636GPxmXBW
         UqeFBOtX9eQRcT7WNYzWS51k94M6kovrbsnOqqS56kYxxmDd1b4v93TC8sfNXbIf2F1k
         f1wff7rjWusrk5+QIIQ4N/kiLbE61BRWsjQnEDE3zZ99m1W/jEZ3fFIpdcoxvQ9ayB1B
         gS/3mMOx7sPncBN7RRba0oArYMhVvRg+WI+mgr0y9L+e5YCWc0xHKPjET+uSeEGOIEuW
         xBKFXkTWZaACwpwtw5BIbZT5qFhBdPza1ebytKuebW5F00sSKbgDDPYTDJySqdstWkhZ
         pz2g==
X-Gm-Message-State: AOJu0Yy+aZzsbtFi0h7Ca7noXI4x4j7/i2w7SE8rqFLhBjFMw4Gg7Miw
	hXzTWPK4vcUvfln7IlIqB/v7BRUjby/i1FQxqJCSAwgRs6JO1pPREsyUpF0+9mWZuceVbjkQV/N
	la8C8aOg2/AJs23IB6d64dpnKmBm+280y0JPy+b4BlC8Gg7mXOG6P1lJHeIEW42sO8jfVOvJjFK
	m1voCi8+go0wziJP4NktyfABT6KKF9lHQpAsW5rCW2Ejpw
X-Google-Smtp-Source: AGHT+IHSvl2wDLJKrEwcaawW28m7W5apdGFlEJinAxmIDG3iSuEqLpXlYxlaGWLQmo6oX/qglkP/C0Zi4NJA
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:1951:b0:6e4:7af7:910a with SMTP
 id s17-20020a056a00195100b006e47af7910amr77025pfk.3.1708733532991; Fri, 23
 Feb 2024 16:12:12 -0800 (PST)
Date: Fri, 23 Feb 2024 16:11:46 -0800
In-Reply-To: <20240224001153.2584030-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240224001153.2584030-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240224001153.2584030-7-jstultz@google.com>
Subject: [RESEND][PATCH v8 6/7] sched: Split out __schedule() deactivate task
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
2.44.0.rc0.258.g7320e95886-goog


