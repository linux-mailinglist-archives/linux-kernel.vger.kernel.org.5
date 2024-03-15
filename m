Return-Path: <linux-kernel+bounces-104052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FA87C84F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1E3B22228
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C7DDAB;
	Fri, 15 Mar 2024 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mk6yaSuE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57DE134A6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710477631; cv=none; b=Xbf5m9kB2zNPw5kwwRV9+0CuYnvkExERjLDGqOWre7ioVO75bn0TUJXQ7aXzKSa4oKSapinvRQBm46fT6moP6AAfsWM/SCkCTGswlqgKuROwXQSrpJPLNwxWiNKpUuyvG8PStzLH5hAqC54VN26F6UoM4XOd27tvFBKg7urVIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710477631; c=relaxed/simple;
	bh=Grd0qwTsRfhLF5lqUVRBIRt9w7nSWKZcCX7ikkMuX/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HxGJkwClHwA9gSzbv+iqph8FSQ994RXLKJ6z032qOnfN5+TDIvhbrQBJDH7+9yRIBdRr5PkVWoyGRr1p+FA9TDY1KK3WSHLR7YlZvYIl/iB0ga4at1z1TkL1IHhwFU4VraRCbpg1/wAybAx6R4Kpvkeprf+Ce8VnVPw3D9q8kzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mk6yaSuE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a20c33f0bso30021237b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710477628; x=1711082428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QyAOgwNdCvCdtkb02Cz+1RqE/hO9U+hZcKT3Z9MgUA0=;
        b=Mk6yaSuEepPc4CjgCPp2EekIk3fqeCTrUvo6Zd2UKw9O/2yqQz02DDeKvUQofUnZl5
         V+dVuNGUdIicq5B745+5v4iscvTNP/KFcnczaqNBh2j4tksfNio3HFpZfomtOrUctNlt
         UCwD5GclAo1lyPVoc9trgLruh9nD63PJgLijSYZ5lmptSFG+T+/H8Mw/Q+qcC/DEEIaU
         +lZQdniMqmxWxE7pTI5Md9dm1kbFCxiDE1wVIhs9PSjLwfOl/4k048kkqw5kv0WybqGw
         WdgiwPXNDlxG2dVS2cFhaG22GxZPRhkb0X6UC0cwft6ZjHZJ6OoLpjpl5qhbsdkaRHQl
         rQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710477628; x=1711082428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyAOgwNdCvCdtkb02Cz+1RqE/hO9U+hZcKT3Z9MgUA0=;
        b=DSpee3l/bjbt99LiUT9CA1+ekJgHUrxf3zRlIej/cKTexSR9oW/r2E4dbsdhYry4Pq
         W+QhufcnezIAD4UeirBw+xV42fnzbS9UA6MHS+MOdaMo3AJibINajieXZXLdY6/4pom6
         rdCNZp4u1qAw/NBRA5BBFq1OQ59l8xvkjSqo68o7Ix3tf/yJ1L1zOh0c+1Qc6DpKB1tD
         hL1p1OrikjyqiMSVUs55FXcvz2LzoJ54RbmxxtCrRIMyAIhf9WR/s0p3Ka1XEsi/Jl+S
         HNvhzgd75NHnqZX+h1YEoMKlVNHvnvkyft0Ra3l/RIa5ZCVyikrz8L2w5YzKesXIRTnN
         A+nQ==
X-Gm-Message-State: AOJu0YzAc0E6f4cnhK+MRim1FTiJddhPAyDDV93nDQbskJX4w5vP4jf5
	FgAeFbKL8yqJ3qHl4Yj9+coVy4SerU9mSrvYY+Vz0gTpRyZp+UDemQhjhXvp9YFWaiNbXM65/gG
	3MpRmcYFU1fLA2pKT0xvuxrCZBMYr8DEzK9wf4ebV5vWaknezF2dMTYRaQjcRKfoolRn9x6wwna
	ELPIwVV1OSrNoigLFfGvw7CM2O+J16MCBaOVi8ODZHXOvx
X-Google-Smtp-Source: AGHT+IFZisossGkZBSmeVynVE9zc5wzqj3kRkRJSTVMXyWdE/EZey4ntB1uteGlD/hhtTs33ndI3lR1K81t7
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:996:b0:60a:512a:1b22 with SMTP id
 ce22-20020a05690c099600b0060a512a1b22mr593648ywb.2.1710477628555; Thu, 14 Mar
 2024 21:40:28 -0700 (PDT)
Date: Thu, 14 Mar 2024 21:39:50 -0700
In-Reply-To: <20240315044007.2778856-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315044007.2778856-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315044007.2778856-6-jstultz@google.com>
Subject: [PATCH v9 5/7] sched: Consolidate pick_*_task to task_is_pushable helper
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
2.44.0.291.gc1ea87d7ee-goog


