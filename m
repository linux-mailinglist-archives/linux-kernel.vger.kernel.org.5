Return-Path: <linux-kernel+bounces-79348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9904586210F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5AD1C21596
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611947475;
	Sat, 24 Feb 2024 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUqSu8X1"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC64C85
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733534; cv=none; b=TF1ZLMqLiR9IcfErflCqKF75Pa8cIcQMFw5UuQfVQA7nEMc6hYPuNrwvHQALeoGBR/BXWo9MJF9HLgeNfXjLFB6EPig7V8JB1g75PuMzvPTUGhv15Ho7D9nOUuaFmK07tOlFl85uLpFzXMDJQsI76lISZF3dfDKJ+AfFFVkDVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733534; c=relaxed/simple;
	bh=1hM1AvrYZkVVQz6jWkOukGk7b+ida3TUYaFajDoq9/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gNsIZGAvxaq39W0S0Lvs1hfRL1hk6oSSFhjitsf7wruPezLB/lcNEBPriAqkSSc7syXnXFr0aPsHp7fTw89wWQMYR2AKe9UvSRiZi4o/nRgvbnjPqXaSRXwZ5v5shmjbdC5glZ4XIdEdcJwSqvD6AKDUfBlY4Ul2ip2gyoUayR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUqSu8X1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e10d9dee93so935641b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708733532; x=1709338332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HisRLPDUotN/MLFzIic3Nyb03cfZKjp8nhvpXhlORJs=;
        b=AUqSu8X1JmEa36EdAa9lo9ib1+k74HjFibs6cU703bPXSXU6hMXhHn4eK7+fUax28r
         gdRF/isqmnnEIWwaY11X3k7fCf4BdyhsBk4mLL+1PIJwATUgbawI5qd2b4VQsfARc7Zr
         Z72BeTquOiym5l6cdgYdo6pmJ7uf9DGGMZKEkWKqpU2uTQ2dX0ur7cMm8c4PtwzN7np7
         5Xc0c5hiTevmIBfxFxEteFBFhTywpntwy45HFk1nUdEWfR4Yj2c9Uu3sxRSOPr3FDttE
         g7pnN8hCEQOmo6hQ6+YuG+j1e63VllntwZtH1Cix+oxcx/4XIRm4cmz00v1SCQbIOQUG
         X2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733532; x=1709338332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HisRLPDUotN/MLFzIic3Nyb03cfZKjp8nhvpXhlORJs=;
        b=IFOEyggLTUCqPSR7QYODIN9upHFbkx7N5vYKQgSxClTAQjUP4kKwUPyZixUDZT0Bew
         kVWwAkY9uI8c8X1lPJE4HWFUKeDgN9jFiHmuYswZIsnUThW+jOavyYB1AzlTimt6TY2V
         dcRomnVrBbZnQ08+vuPqHe0CW8bbSxZUdl5pcDw8pqVJQJ3cjujgkrmK7Ji21Zju9iyq
         vW1MPPdxW6JIfvmCpB+tAvjJqHdtAPCT0F3rZvjNb/2W68lVA6vTSmv0BCLySS1GL3ys
         D/70dWmKfEk2P6SASg+mxuzu8QuzMa5BkHnt/FO9r0VoA/PxnCn99dNgw0QBFXNld3fe
         Jx8g==
X-Gm-Message-State: AOJu0Yy8/YGzLn947ceAAKzwrSWl2Vd4G10ZNm8K6xe4awKYpysOXJi5
	NeNChDd8wJluN6z/O/4g0bpqnUHPtam7B1jNuMH45G09GkBcYWAm9NXExwznt+siMrzNpS90gxE
	zInqw41tFdFikk+zlElhfCjdh8Mi/UH2b2o9rNCXQgSkFuC12QpVLXtB4Ak0GdQHZN2UtgnGVnN
	KYjwvVDWKaXOIWa2hQDcTELKhGiAR4xbVMoBvITKcQk2+H
X-Google-Smtp-Source: AGHT+IEtdw6apYdSs2JIDOXgrv9IZXhVhiXafB1WG5uakfRsCWUZqFcgNdkbWJt137ySGclWwwvXPmrk7tPL
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:80f:b0:6e3:de2b:64e0 with SMTP id
 m15-20020a056a00080f00b006e3de2b64e0mr70503pfk.2.1708733531235; Fri, 23 Feb
 2024 16:12:11 -0800 (PST)
Date: Fri, 23 Feb 2024 16:11:45 -0800
In-Reply-To: <20240224001153.2584030-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240224001153.2584030-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240224001153.2584030-6-jstultz@google.com>
Subject: [RESEND][PATCH v8 5/7] sched: Consolidate pick_*_task to
 task_is_pushable helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Connor O'Brien" <connoro@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Connor O'Brien <connoro@google.com>

This patch consolidates rt and deadline pick_*_task functions to
a task_is_pushable() helper

This patch was broken out from a larger chain migration
patch originally by Connor O'Brien.

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
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: split out from larger chain migration patch,
 renamed helper function]
Signed-off-by: John Stultz <jstultz@google.com>
---
v7:
* Split from chain migration patch
* Renamed function
---
 kernel/sched/deadline.c | 10 +---------
 kernel/sched/rt.c       | 11 +----------
 kernel/sched/sched.h    | 10 ++++++++++
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e68d88963e89..1b9cdb507498 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2179,14 +2179,6 @@ static void task_fork_dl(struct task_struct *p)
 /* Only try algorithms three times */
 #define DL_MAX_TRIES 3
 
-static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-	return 0;
-}
-
 /*
  * Return the earliest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise:
@@ -2205,7 +2197,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu) == 1)
 			return p;
 
 		next_node = rb_next(next_node);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index dd072d11cc02..638e7c158ae4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1791,15 +1791,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 /* Only try algorithms three times */
 #define RT_MAX_TRIES 3
 
-static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-
-	return 0;
-}
-
 /*
  * Return the highest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise
@@ -1813,7 +1804,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu) == 1)
 			return p;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6ca83837e0f4..c83e5e0672dc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3480,6 +3480,16 @@ void do_push_task(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
 	set_task_cpu(task, dst_rq->cpu);
 	activate_task(dst_rq, task, 0);
 }
+
+static inline
+int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
+{
+	if (!task_on_cpu(rq, p) &&
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
+		return 1;
+
+	return 0;
+}
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.44.0.rc0.258.g7320e95886-goog


