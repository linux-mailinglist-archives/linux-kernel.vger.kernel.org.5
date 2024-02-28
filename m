Return-Path: <linux-kernel+bounces-85592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C486B815
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F528A1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2674439;
	Wed, 28 Feb 2024 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CT2XLcWK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E671EB3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148245; cv=none; b=YEfldZoUo6XkezK9+rq9UwWzxMYMrcAufnIxz3TiJVLPZtMPhHzm82rQMdKsfOBkgh03oQTuqrWw+FnF3QWwBe6O96ZcSd63OHXAm4K/kcWfAPgPzWgF9IObIDpnUih/OsTOCE8A2xOS7DMvezzwp4m4OWljbmrSJxOxhgbY8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148245; c=relaxed/simple;
	bh=b6UIF1ZLdEXM8cy9LIjNnogO7ZLMmBZKzULoHDdfKqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbaS/U2FXWvVAfG1lSP3DvvwsKXV3x/gak+viwq3ZPWrlKMdCaIaA0lZSlgznf2U5USOD0LsvLpBm6ZytNNmUkyh4zaa/dIvK4UIgI6AGQtTDtX4ag6VwVm5ryU1pCFmqe2fxnXuKYdJF0fIkGRtjMbMvYICAUuJ3gj3C2REdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CT2XLcWK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cfb8126375so13222a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709148242; x=1709753042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8UxLx5bov8q9DvrLxnPNYwpFvC9klIZbCUnSVx2g6U=;
        b=CT2XLcWKJqxebLpG6w3ZCLvMPVNWOW2KmWM+AzHpUufgPoNoM5HggS+2u7sin53Iz+
         PospHEy0P7wZrB0ugRT6HIqqtQf65ZIG75g6rdBZosj/efmWwGwaMnLzNcAtGAxA9j4q
         vddNFBLGKjXf2si3va6aTswJUcgEqZu/Hcb2uAlzoU9ZVVblFMljxfEiVqOoW6tXEAHk
         FFOQWzvTTUCyGg72Ys3EGLfOAvhr7u3y8eoc6MncyfjHAjgYailoj3Qp/INhYZlCGnTq
         ng9d4DG43Y2e8Gt4mCYMl3cQOHruZfG86KNW8UzpsPAmLPVKjg6z2mVX8TFW7gJ7NDK8
         u7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148242; x=1709753042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8UxLx5bov8q9DvrLxnPNYwpFvC9klIZbCUnSVx2g6U=;
        b=DTVN5GcIwUfU29kv8+Nm3h4qyvLCdT+qL4TtBUOUbRgVSzgFkRtDzT9PfJ9CAGuNcw
         bi8IQzoR0Z6fIk55AHNYkxywG9WubsQ7y27D6BOaDQrKtSKUEQedkzCvNs7khcfkx11S
         X8QbewLdWHPVkyv9p5PKI7vPXY+7NjqALIMVkWLzrOWvxbXzo6tZOW990x/EEntp1SoD
         x6sj/r3pZMWrIIXagtJ2r1Fa4uq54kaOkCDrw1hrABTmHGrKoPfm/0Qg9nnLJd8kTZWv
         0QHWdKYB46AginmvVPAvNDbH8fh4OLjaCC7V3jVJtFhLAAtZifZXdGM23509Ip/igILv
         2H8g==
X-Gm-Message-State: AOJu0YzuQEaTnfLRcn3uSDuo4WF7H9A5oWIWoEufUpmpB4A/xdYf1SYF
	owjpG6LYRC1Km3InpAJM8OxoRgTMPdp3J4tbk9y2EeDB8LeTYuI2/KL7OYttmkkeX9nWSRijKhX
	8
X-Google-Smtp-Source: AGHT+IEBbo7mA1Ac6EDt35VeDeOTFB/+Lp2WiVlHoYLFb9/bYX8WdCcD0HPPIZZTyBYgcU/REfqBWg==
X-Received: by 2002:a17:90a:7565:b0:299:3748:4ada with SMTP id q92-20020a17090a756500b0029937484adamr131097pjk.1.1709148241854;
        Wed, 28 Feb 2024 11:24:01 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a550a00b00298f2ad430csm4230pji.0.2024.02.28.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 11:24:00 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to a normal int
Date: Wed, 28 Feb 2024 12:16:56 -0700
Message-ID: <20240228192355.290114-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228192355.290114-1-axboe@kernel.dk>
References: <20240228192355.290114-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 3 of the 4 spots where we modify rq->nr_iowait we already hold the
rq lock, and hence don't need atomics to modify the current per-rq
iowait count. In the 4th case, where we are scheduling in on a different
CPU than the task was previously on, we do not hold the previous rq lock,
and hence still need to use an atomic to increment the iowait count.

Rename the existing nr_iowait to nr_iowait_remote, and use that for the
4th case. The other three cases can simply inc/dec in a non-atomic
fashion under the held rq lock.

The per-rq iowait now becomes the difference between the two, the local
count minus the remote count.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/sched/core.c    | 15 ++++++++++-----
 kernel/sched/cputime.c |  3 +--
 kernel/sched/sched.h   |  8 +++++++-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..48d15529a777 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3789,7 +3789,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 #endif
 	if (p->in_iowait) {
 		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
+		task_rq(p)->nr_iowait--;
 	}
 
 	activate_task(rq, p, en_flags);
@@ -4354,8 +4354,10 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
 		if (task_cpu(p) != cpu) {
 			if (p->in_iowait) {
+				struct rq *__rq = task_rq(p);
+
 				delayacct_blkio_end(p);
-				atomic_dec(&task_rq(p)->nr_iowait);
+				atomic_inc(&__rq->nr_iowait_remote);
 			}
 
 			wake_flags |= WF_MIGRATED;
@@ -5463,7 +5465,9 @@ unsigned long long nr_context_switches(void)
 
 unsigned int nr_iowait_cpu(int cpu)
 {
-	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+	struct rq *rq = cpu_rq(cpu);
+
+	return rq->nr_iowait - atomic_read(&rq->nr_iowait_remote);
 }
 
 /*
@@ -6681,7 +6685,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
 
 			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
+				rq->nr_iowait++;
 				delayacct_blkio_start();
 			}
 		}
@@ -10029,7 +10033,8 @@ void __init sched_init(void)
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
-		atomic_set(&rq->nr_iowait, 0);
+		rq->nr_iowait = 0;
+		atomic_set(&rq->nr_iowait_remote, 0);
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..0ed81c2d3c3b 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -222,9 +222,8 @@ void account_steal_time(u64 cputime)
 void account_idle_time(u64 cputime)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
-	struct rq *rq = this_rq();
 
-	if (atomic_read(&rq->nr_iowait) > 0)
+	if (nr_iowait_cpu(smp_processor_id()) > 0)
 		cpustat[CPUTIME_IOWAIT] += cputime;
 	else
 		cpustat[CPUTIME_IDLE] += cputime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..91fa5b4d45ed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1049,7 +1049,13 @@ struct rq {
 	u64			clock_idle_copy;
 #endif
 
-	atomic_t		nr_iowait;
+	/*
+	 * Total per-cpu iowait is the difference of the two below. One is
+	 * modified under the rq lock (nr_iowait), and if we don't have the rq
+	 * lock, then nr_iowait_remote is used.
+	 */
+	unsigned int		nr_iowait;
+	atomic_t		nr_iowait_remote;
 
 #ifdef CONFIG_SCHED_DEBUG
 	u64 last_seen_need_resched_ns;
-- 
2.43.0


