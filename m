Return-Path: <linux-kernel+bounces-60183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB36850117
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D3F2898CE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB68BE71;
	Sat, 10 Feb 2024 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCgHthWA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80E522F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524627; cv=none; b=nbGpDOxMUHRTwl6vVKb6LFMQsVmejmpGp3GORMYyrUPJjcsCQ+O33lVAFwlHbOa8jFJ3qx713NyLn9/DUBFEUENwNqH3XmnuZFD8Fw3F/FJbZpxH80PEonrpyrIDSC//xZ/vbry8GNI1RQ71lxJqrDqwq2LEhU6rOZxEdVgaMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524627; c=relaxed/simple;
	bh=YfiBEJV6vLoHT6zkXGYNge7GpslC9si2ifJmBAVNUII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=giD4O4jGoOC910ehSv55hEIC+iyzOY6TJN8DNWPkV4UG5KX+iQAzQPDxHLbvzsIjRU7woIdnk5m9orExFUk32vR0uynZDr6GarKFlc/aIYH2HyYFIT9WVEORQ6Lh8y8evBmw40WOqmC/7TxM+VfyK7d6ZDrRwrQDkf0XC1C+qxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCgHthWA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60492362802so28520547b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707524625; x=1708129425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj3M7y9TTYy2rrgwO5I38+m9nXw8PxLjyjvAZlLM9sM=;
        b=lCgHthWAW+CfyBvePuCnYlNqS5v3DJANIwE2ZciE7Wco2c1N86EpZ5BS/tNUj5a257
         KLqAM56Vlj5yQHLKyAKr+hHRpgMuygm8XNCGcG2ZTgdM3UOdRE1qT5E1Yx2/5RmVtR0W
         QUkvNTBVpKf7FCWM+c7Kmo4Qsk/COeGV6KZdhWowpmUu7PxBAauV69FtW+zEanaaWLeu
         cxCz6iOaK5w9SCssj0aAf+GGXqCSy4XNYe99vfTsOjEiwjqK72mylF0por/VZEZUFdtw
         ENIMsZCY3jul1cR0htosuP/kyZIOFmvik7qsny8x41frhzbwIHEukh8s4Jp2LIb1AfPW
         WF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524625; x=1708129425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj3M7y9TTYy2rrgwO5I38+m9nXw8PxLjyjvAZlLM9sM=;
        b=rm3cVsex/G6lgNYpSO0y2A08dfyyBN20MMTKCHL3mJgkTaAapsPdbmlhQZU+W3tR+I
         a9HT++gEoH5DdqYYeSpkv3EAdQGuQfUOueHmRO/WfNriLGPOWfSp6hS95EiTZJuRq9V0
         16Qkj8c1bJRJCS7QA0MlzGG1xkVOlWLFua3xqNGLEU8LiuzxGG+nhAV6j2RCzPK7yFKm
         gGQCkw/ITgb1lkbijICgWqt/SmL19KDroG/Fil0JhaTjii1aamtl6BlEBez9wkGpFy7n
         +KxMSt66hSU1oI1ZDelH1VvcAeH626nPiyT0PSYR0fRc9cRhbIe02QsCH/Vlv8AApY1E
         O0iQ==
X-Gm-Message-State: AOJu0YyF1lI1mcf1xFN6DGJLbRxP+2gR9NCEIA15tKjXETpg8/dYIV+Q
	bocL6TGjpoPIFlGmTKRunnMuX7SYkMav+1fg3DD4EIMTxATupicKWMQH4y5tzjHaeeIB4Eeq3qF
	kxEZ4vzj5Lz6511k6Be90q+xTtyeS9RkIoKWCRM1Jrl/KOb7Ki6okiCpUwUfZf3Q231TBuUfSxp
	9B7eVEG5rAdUdir18Hs2jgI1r28e0gTUcQEFPJhlAvKU4O
X-Google-Smtp-Source: AGHT+IFXFPqhLW6HXCEsshD8XVJ9E/ArxhWL0vJJzJevOAo/WCWfCzifqGlFo8P+KK/FN9tmHQJhCyCOuWoT
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a0d:ddd4:0:b0:5fb:455a:df08 with SMTP id
 g203-20020a0dddd4000000b005fb455adf08mr230563ywe.7.1707524624907; Fri, 09 Feb
 2024 16:23:44 -0800 (PST)
Date: Fri,  9 Feb 2024 16:23:14 -0800
In-Reply-To: <20240210002328.4126422-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210002328.4126422-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240210002328.4126422-6-jstultz@google.com>
Subject: [PATCH v8 5/7] sched: Consolidate pick_*_task to task_is_pushable helper
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
2.43.0.687.g38aa6559b0-goog


