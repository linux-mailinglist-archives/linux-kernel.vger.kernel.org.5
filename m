Return-Path: <linux-kernel+bounces-79347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D29686210E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FDE2886E6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D25CB8;
	Sat, 24 Feb 2024 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e12NFPTZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E702F30
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733532; cv=none; b=m3W/FLrm0+/wCUM5c3Psta/IhQm78wqPhMvkiLjK/lCun9XBmqzwlXOLeGduzCIe6JWCvKaC/4X1AyheHTgXG+eGB04+mEuRk6WkESN9auMig/QFe8O2OTGnH5LFrVeDYxf4TqcFgTmiDRsGK1zCWdT4Lq/FjmvdxvjgyJpusQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733532; c=relaxed/simple;
	bh=j21O/bff5NFZS6pprTcMOjKvrJL6woNmikyTOJZD1do=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gAnOVVIv+4CSgxZz8Ucwl0jVwMOWMadIzog9q2l4krviotKr7OrV8VHLjlaZxspG601KSywivhTG3pNaf8s+sp8T6Xbc3WCDCGyj+G4M76uRmwq/TsbtWWPyPPoXa/p3ubDXi2lvcGnfOOED+C5p6ZsqVaXIhyvvhV5UpXJdxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e12NFPTZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so2065556276.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708733530; x=1709338330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=esOVP+N/ZUoa4ygSfd761G7owoCk2ZEM+BYq0871ztg=;
        b=e12NFPTZs7P5alpsY7e+bwP5K1EuXFwtN5a2mrVYIvo8V24saknyERmmIdXUJ6jr69
         O+K/MwMblP+obX8E4GERyqLjXTv2sMKTu4dRCO7c2/owKDs/CuWBdVBcrO1asKge1bn9
         MGwD7/l2I6bRYbGVaTbQCrVgkxg3ppWRIpnPnpXP0FQ0UD0wgQr9f17pDy0rcqfeXDhF
         C3Oe3IvYCounJ9/WJk0a9HJ4whyxnJLAXIwH6UBahQrEP3SVPXbJxTHLswI1ZyFb1GJN
         cD8Leel/IW0AQp4wfmD0PN7IJCQuGifAlH7qJzh2TpQzAlOPpVS/QswRNp5VDA+NdQt3
         1eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733530; x=1709338330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esOVP+N/ZUoa4ygSfd761G7owoCk2ZEM+BYq0871ztg=;
        b=LK9FYsZLyI5kULP99lA2QQZjlzqKcHlwAST4EzA/LYzyxlBUWJPm6dxKEyHUdNBaZJ
         ZCZ/192hAjnTdxARjkscp/TKQLn1kI1jCspt+5W2MwoWHAFcNrk45Gaok7OWIeb3uqBG
         VOB5DAtiIslUfQeGhME6pBn6vyzsDnnAuzQ3qOeksy9GKaQBt8gIoZmVqBnfTJ0YhbB2
         EJllCg9VZskIo65C2ExBesdzZJ4PhLqa20z91Ug3qMpb5hpNy80/i6V8kU56a3D/tplN
         nLt2P7Ap2EZSTfrjZM2ZFqliXW4QvNikgTuYpl7iaySLXIQCFQT5aunPkti2GXvZEEzb
         zzPA==
X-Gm-Message-State: AOJu0Yw+9UugLvoFeAoUVyAeu9twj4cwdQKCsVzgl8Z63g/aXM2wtI/m
	U5V2ncxWLh6I/BK1E7YvBTdmKgaMl/y2Re7XJRVkUbtpSeWrnKRSHF7IJ5Ma8Vfj/BFg938Jv6i
	2uLrAD1PilU+N4NBtMIF+1tPXkTDKZ/RKMZCSSfJt7clAQYHeZJHXBTzY9Xd6Ubbtv0h0wOXGvx
	5UUsbxsUygNM7a9HXZYWnVh6WgF8xcAjvDIm+LsBPJswyg
X-Google-Smtp-Source: AGHT+IHp9D0Kv04uXsDlqeHW4Hxa9VVLQFzeAsyoZI174CIC8TF6XBq7tAQN80GFm6P59BnpzdOLQRyuMQXf
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:c7cd:0:b0:dc7:865b:22c6 with SMTP id
 w196-20020a25c7cd000000b00dc7865b22c6mr63367ybe.8.1708733529517; Fri, 23 Feb
 2024 16:12:09 -0800 (PST)
Date: Fri, 23 Feb 2024 16:11:44 -0800
In-Reply-To: <20240224001153.2584030-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240224001153.2584030-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240224001153.2584030-5-jstultz@google.com>
Subject: [RESEND][PATCH v8 4/7] sched: Add do_push_task helper
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
index 9116bcc90346..ad4748327651 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2714,9 +2714,7 @@ int push_cpu_stop(void *arg)
 
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
index 001fe047bd5d..6ca83837e0f4 100644
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
2.44.0.rc0.258.g7320e95886-goog


