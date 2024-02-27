Return-Path: <linux-kernel+bounces-84017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185686A162
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD0728C94D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7514F968;
	Tue, 27 Feb 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rvqQUTMi"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5801F14EFE6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068322; cv=none; b=UEGsqxh5iEAryo6517qujxo03njjQw3oDVDWpI5LMbgZjzkuy46xv5ghEE6zQX3HvYeYTUL5C06YEFnq6x8ywfdKiqX+eHD49lYYuqqExRA41B2ia6B75IF6z+DT/NxlWlC4OhhwZFJIc8TCBNgZ9sdFGgK2Fvg8Bhm5wiADaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068322; c=relaxed/simple;
	bh=JKIl3QSWViM2CannFhQlXB4MJVpGyv7AV+fHXS552Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3WxZ5e0hM7E2C99jPx71QGfIBt6y+VDKM5ktFRqCfNRxMBeZRFh8aKyJ4Dsmz2RmVXgrYghG3Si9LZMHMxPAf1Db3aXLqytgYmqHZ/w2ZLIQNKU05qiyrA7u53vOVe7nanu2RLNT7+jNjm/993fGGH8Y6e9iGnXpMPdpO/TZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rvqQUTMi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so1830146a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709068318; x=1709673118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RAeKNhAgZmKkiugFg+etSPi3yLpie0L6GcI/HOOxDk=;
        b=rvqQUTMiw48RQbW03QNOppu9UIG/0lvLX56qorKc8JiCKnYThga7ToxPjcgfwjtUQq
         xXYoQ4jiFWULU+sozAKGjBc9ta1IVj3l9EEZe4Y7godGuDeQfnc0/J2RnaMIL0Jpfnzg
         61pIF7feXGppHS0WFpTu0zx3OrZNFDjL7Tj7ie/EoMlXYZkcg7HUp0JPBV6KRL95BW5t
         qxDfIBAmnWeYzOKo6MKAiJkUrNUDnMKCve6BQMhZgDQuUrzpcS1W7gZRT3S8u6jrFQKC
         E1zFW7PBSPJJsvQ9VedEp6ReB6tCp0fToHDdWfAHzD7Of7/neuiRLVB+vCCv+UbmfR0Q
         ViIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068318; x=1709673118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RAeKNhAgZmKkiugFg+etSPi3yLpie0L6GcI/HOOxDk=;
        b=h8O62VTLzuycL3iHrYi5d7B2i2cwU0J6ylRsDnm9ofIjeJuyrLsUhunsSSguqahj/q
         OmJ9bxxbHUXM3sWaXxOhcuO+f+yr1fTlyu4tRlE0hn8VE0WRSb1MIPQGHj5HwQqr6WrM
         Ze1rv+e2MUZwFNqgBvjsGDl3xxL5LP6zuhxR1pCfh4GTG0tE3JRHTxfAfK+dnjOdfqgb
         /Pe8yB3R2rySjgzwS3x85tQCa42LCSdJDA3CRQTngrCfKCNxkP87cpPecPsZ7KA48Dyr
         XyYrM6Z+Ex474aqBcehvAe3gTtOSQQeVTFsyAzQ1R3UfaVwr15Mpa33FHiIdqBc7BjMF
         5jbA==
X-Gm-Message-State: AOJu0Yz9Pm56VmU4fBavKHd9YAygnXnv6/PXtmunkw8RPpBZW9HxYcpx
	Iejz85OzBBe0/EkbQmRFtAzWnxcQBmdyLSi/QABDSS7uxf/R2cSZXNoJGhOBE8ivGEZfDdpF4JP
	U
X-Google-Smtp-Source: AGHT+IGA9kXPJXZ5rP0j2GkdP8BJUgtduusBD3YeYxF+wplMBcI/j+Q03fSGdCN+YTFQF8mBnRQ2Rw==
X-Received: by 2002:a05:6a00:1384:b0:6e5:4abe:fd4c with SMTP id t4-20020a056a00138400b006e54abefd4cmr2833506pfg.3.1709068318162;
        Tue, 27 Feb 2024 13:11:58 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u8-20020a056a00098800b006e5557128efsm735390pfg.133.2024.02.27.13.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:11:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to an unsigned int
Date: Tue, 27 Feb 2024 14:06:02 -0700
Message-ID: <20240227211152.1099534-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227211152.1099534-1-axboe@kernel.dk>
References: <20240227211152.1099534-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 3 of the 4 spots where we modify rq->nr_iowait we already hold the
rq lock, and in the 4th one we can just grab it. This avoids an atomic
in the scheduler fast path if we're in iowait, with the tradeoff being
that we'll grab the rq lock for the case where a task is scheduled out
in iowait mode on one CPU, and scheduled in on another CPU.

This obviously leaves the reading side as potentially racy, but that
should be OK. iowait states change all of the time, and can change while
it's being read as well, or summed up.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/sched/core.c    | 15 ++++++++++-----
 kernel/sched/cputime.c |  2 +-
 kernel/sched/sched.h   |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..ecc6c26096e5 100644
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
@@ -4354,8 +4354,13 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
 		if (task_cpu(p) != cpu) {
 			if (p->in_iowait) {
+				struct rq *rq = task_rq(p);
+				struct rq_flags rf;
+
+				rq_lock(rq, &rf);
+				task_rq(p)->nr_iowait--;
+				rq_unlock(rq, &rf);
 				delayacct_blkio_end(p);
-				atomic_dec(&task_rq(p)->nr_iowait);
 			}
 
 			wake_flags |= WF_MIGRATED;
@@ -5463,7 +5468,7 @@ unsigned long long nr_context_switches(void)
 
 unsigned int nr_iowait_cpu(int cpu)
 {
-	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+	return cpu_rq(cpu)->nr_iowait;
 }
 
 /*
@@ -6681,7 +6686,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
 
 			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
+				rq->nr_iowait++;
 				delayacct_blkio_start();
 			}
 		}
@@ -10029,7 +10034,7 @@ void __init sched_init(void)
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
-		atomic_set(&rq->nr_iowait, 0);
+		rq->nr_iowait = 0;
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..b970b6c6151e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -224,7 +224,7 @@ void account_idle_time(u64 cputime)
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
 	struct rq *rq = this_rq();
 
-	if (atomic_read(&rq->nr_iowait) > 0)
+	if (rq->nr_iowait)
 		cpustat[CPUTIME_IOWAIT] += cputime;
 	else
 		cpustat[CPUTIME_IDLE] += cputime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..a1222a4bdc7b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1049,7 +1049,7 @@ struct rq {
 	u64			clock_idle_copy;
 #endif
 
-	atomic_t		nr_iowait;
+	unsigned int		nr_iowait;
 
 #ifdef CONFIG_SCHED_DEBUG
 	u64 last_seen_need_resched_ns;
-- 
2.43.0


