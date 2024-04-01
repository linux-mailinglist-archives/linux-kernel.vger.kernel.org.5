Return-Path: <linux-kernel+bounces-127194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8B98947E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9101B22180
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D7B57319;
	Mon,  1 Apr 2024 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piGDLXIV"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF758AB8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015101; cv=none; b=T/QOgvtMuBq8JNqvPezvFCpGL5S0quk5yMaIn7xusAmodhAyGRMVtBVFBqZFOkA39Pp26OG0qDMpvYvhgOz4brQcSSn14wM8e9An3dKgEzSWzqlBqV0q6C/Vq+nhHW6MskxNVovE5WTs0Z8Ndz9M7vuiP4fyAJjUN1xFbwuoWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015101; c=relaxed/simple;
	bh=ddCiRQJoZ9qYztkVTnJ7p3TgD7QCkc8YbKeYaUReoH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qsyapnKg97LME/blDS0xhozlrqlcWAwYVmYnqn6h+OJEApyFl9O/oljkX7TkDHRustdci4U4MoVdcW2mG3bUQo4nTiVNRfiyCV4Fz850650lhzsKgBbf7KmsjmKdwPT4i80MVu7Xpbf7edTNyCGA9lhWAfnPnvfkUqmk2JkL3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piGDLXIV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e0984b137aso29784835ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015097; x=1712619897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vnfj4RJNtnkZlKor/hHQJKKoGPPgj0ewMfJ+EWEyxKM=;
        b=piGDLXIV10J8cGqvSMsSgO0OkxBScEt+5FfvK+itqjAOzRahjR8YVJ/mDUIccEL64x
         OT72Od+4A3QanhbJIa0a2hAlxMILx+5Wc6PUvTI8PZ6Z6Atwd6tmZ0d4Pg8w5EXgqtZ9
         wGXm5ujf2ciP9ZX9Zd2FVfzsSfYYPYOEv3LfQhKCi8tpwBiOPIYESvM6qxy0d4ocYMS/
         9oW1r8hLgmRvaKSbg67fViKIo1nekqep4OG9H5/9b0b+J6pOI3KsxOmtUMNVTcdIjNh1
         RAkv7mO6fL65foeTO9birSG87LxBY8siM4kfqd3/pmwpzae4LCMqA9X6WH8IdmiMlM1C
         6Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015097; x=1712619897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vnfj4RJNtnkZlKor/hHQJKKoGPPgj0ewMfJ+EWEyxKM=;
        b=ajBHrpfKbNb5KMq3ZUNtdyMDOnsX5dRFfkhC18NeUIF6Brv/a7zEY54r14FuDDwCBD
         A0A57UNsN+pjAekrFtJ78KSNaV94ISqjKf0fbDqhLPpreRJVV8+3GOJdhO+DvCNcrcdQ
         mPazsvrvp6SBYhquXQrGasl3d26sCk/NVOGWGb0Ws+yTKFBCE2w55p3/e7409geUqA+5
         cvNZmdbeBhOg4T7PU0EP6dIOd68dw3rg1GfrZ7vZaOQrjYx/GPk0poTmS0KcOLwNgODq
         lB5byzpngMD+c4R5V+pppps/uiMd3fXsy4KbSWy0zu6bQAcc1grUj1zxAGp0myapu7ns
         +Shg==
X-Gm-Message-State: AOJu0YzorQDkl7Jk9El+BpJ0/x0Hl0Qsg33GmBQxPh/sD6F/qpa3BuTr
	VeQoXlE1p3w3KT7U0/yTkABay3dPchYBs2O1GhhLs/1yBACM4djTq9Xw4mL/mz+Lk7cd1yHaGSv
	RM7rNJsIXYdoQ/bp/7vCLzGy0TXF7EiMH/x4VRXco2IZp3q+Bzw+ljtEuR800qL9Wym00Fzv3vD
	XRCB62gio41JIHjY5GeHKUY0qZ/Ik4lj2sYmNe5II+9x8W
X-Google-Smtp-Source: AGHT+IGoIAwD9CrnQBK9W50FUdTR9DUi4m1EZxTtxqQV8EenJ7SwU8b7Lw+ALwrrmS4z5Rdndmp8mGdviqny
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:d4ce:b0:1e0:2cd7:5dfb with SMTP id
 o14-20020a170902d4ce00b001e02cd75dfbmr1056987plg.2.1712015096211; Mon, 01 Apr
 2024 16:44:56 -0700 (PDT)
Date: Mon,  1 Apr 2024 16:44:27 -0700
In-Reply-To: <20240401234439.834544-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234439.834544-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234439.834544-6-jstultz@google.com>
Subject: [RESEND][PATCH v9 5/7] sched: Consolidate pick_*_task to
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
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
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
index 16057de24ecd..f25eec405df9 100644
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
2.44.0.478.gd926399ef9-goog


