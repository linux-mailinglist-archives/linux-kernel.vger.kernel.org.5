Return-Path: <linux-kernel+bounces-127192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ACF8947DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4921F2248A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A358ABD;
	Mon,  1 Apr 2024 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpuyJBrQ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2658133
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015097; cv=none; b=cSH/srKsHCHxjlWpx7tcaEDUGVrjI506bRd0ov7m1eUZlk/Ze2/YQvjirHGW9bvgW/KJWPd0a1KIoH9J1THFYGrWiCVMxrnFpazhjbvIuLynuCkP1xgN0UDli0QfQcjZv0AaVgAyRWK82Ow87HaRBN3BdAOqb6n4VBNd0ZTjATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015097; c=relaxed/simple;
	bh=EJ34wqd6b/ux/q+BX6JNRu0xPaf1PNbXxTmJ4orQ594=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s6+Me0dCQy3Dojtbw7MTE+pfn+D2xfNoPDehA/M5i7yDI87CADWPv2/eXvHPeifCvH/TQONnxY2VL6oj0+sEuM9wGmVEiOf6TOxSbISFVK7EdfgcqgV+1HszG0ZVXeqsFJA/NtLoEUmE8WD35N7l29EhgTy52o6YqLJOVbeH1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpuyJBrQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so6920091276.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015095; x=1712619895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Se153erLk5xq/r1GOlypzsiGXhlpYY7z2C8apfnTM7c=;
        b=DpuyJBrQVpAwhAODbBYO48ewaI6x4nPezI0TJ4/OtaKMzQMEDYz+WlrFZzvZ+74Fxr
         bBfcfHFHUICawwuBbxd9RZQpFfc1xgGC0XhWMvrKqATnpNMIEERaDEtlUTtKN9UeYMM1
         3v7YWStQr5dbtfxa+uPwun/opBXxsaWTATEf9uVRVdO7Q+rqnONhYGop5kf9uUWwqFDy
         /IZK7h1KE9nkR19gd39NHEz0CXRBKE54T2uLrUtH/bsAV1l5BPDm4727KCjxMGrhH+42
         Onhv8wup/2GZbA1NL7WvSctNHGIyKm0OT5FFqErDw4Ibffrmv40i5QcFrBHNJEjZxK70
         nKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015095; x=1712619895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se153erLk5xq/r1GOlypzsiGXhlpYY7z2C8apfnTM7c=;
        b=NBjGblVFdbps/b8hkfB87MU/x5sjBHfYr7ybLnQDOmcNIZCvr8XV8hUUAToW4De0Ph
         ejRAtcnSb2eSzMmTcY8VQ+6laFUWyX0yj9R8rafBEn8tdkUJokcCDaGlp/sirYP4/EBD
         Gb8NYHHCxLdk+zuqBwByZRbP08fRqFCGv7NICOoeqn/28TXvucxYlkE+cRlwr0/pHRyl
         iEPH8nRyN89TCEJbZZVJalhXzXkcJFCzZdIU6oiVln6x89ywNNrDerifgx7rRTFEjAG+
         VSAMJ+c3jgrvLlPJ9WkHjtpVGIsvO1poytaJXBAYkSsZUJMCU4IWDZSFH/deRdHKB3SP
         GWTQ==
X-Gm-Message-State: AOJu0Yzv3TAQYNV4d2PLGSKChBusQvM9dWUftSEmJEGBAmYoP7Jo7rGl
	xrIBtnUx1pjoFdYocmRqEApjZnb0uNnqwD+64YiT+QKfp2GkSteOPW649aRDeIFpBxqUiki8SlF
	xClzPZnC99hGVPKiNxE64o3YR4Oia02cue9eSjDo6/WWxJjXxFT2r93jAPYTUd5EpT74PCLSaaM
	p6t4GhRrTD2JKnOZrbffCJvjzwRb9srkVuH4dD5ybgvkm2
X-Google-Smtp-Source: AGHT+IF0RhHf8+AI3UDQGWpPn6ccU8GMZRG67P37CakQ2sxG9XWGJC3KcmZS6ipbhQWec1WHRG87AUZBALdn
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:102f:b0:dc2:2ace:860 with SMTP id
 x15-20020a056902102f00b00dc22ace0860mr934958ybt.2.1712015094611; Mon, 01 Apr
 2024 16:44:54 -0700 (PDT)
Date: Mon,  1 Apr 2024 16:44:26 -0700
In-Reply-To: <20240401234439.834544-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234439.834544-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234439.834544-5-jstultz@google.com>
Subject: [RESEND][PATCH v9 4/7] sched: Add do_push_task helper
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

Switch logic that deactivates, sets the task cpu,
and reactivates a task on a different rq to use a
helper that will be later extended to push entire
blocked task chains.

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
[jstultz: split out from larger chain migration patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v8:
* Renamed from push_task_chain to do_push_task so it makes
  more sense without proxy-execution
---
 kernel/sched/core.c     | 4 +---
 kernel/sched/deadline.c | 8 ++------
 kernel/sched/rt.c       | 8 ++------
 kernel/sched/sched.h    | 9 +++++++++
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..586a3f8186bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2712,9 +2712,7 @@ int push_cpu_stop(void *arg)
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
+		do_push_task(rq, lowest_rq, p);
 		resched_curr(lowest_rq);
 	}
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..e68d88963e89 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2443,9 +2443,7 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	do_push_task(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2531,9 +2529,7 @@ static void pull_dl_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				do_push_task(src_rq, this_rq, p);
 				dmin = p->dl.deadline;
 				resched = true;
 			}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..dd072d11cc02 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2106,9 +2106,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, lowest_rq->cpu);
-	activate_task(lowest_rq, next_task, 0);
+	do_push_task(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2379,9 +2377,7 @@ static void pull_rt_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				do_push_task(src_rq, this_rq, p);
 				resched = true;
 			}
 			/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..16057de24ecd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3472,5 +3472,14 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
+#ifdef CONFIG_SMP
+static inline
+void do_push_task(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
+{
+	deactivate_task(rq, task, 0);
+	set_task_cpu(task, dst_rq->cpu);
+	activate_task(dst_rq, task, 0);
+}
+#endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.44.0.478.gd926399ef9-goog


