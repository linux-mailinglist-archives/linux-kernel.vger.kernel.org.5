Return-Path: <linux-kernel+bounces-146762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF5B8A6A82
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469801F2179F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A312BF20;
	Tue, 16 Apr 2024 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kjqs/xoo"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09EA83CCD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269737; cv=none; b=hlW3xng+OuBUeGScrGiXh7gjzkMpuIBJVGki/6kaEL6oH2kiGWqO+sRgmEow8pYsOv7mVkMxDoFnAwbpSV94w5gH7N/ySyxXuFfcpSX7mM3YWhI5XnM5tiEm4x0BM0rNqDTrC7ZVNvtNEmurlhVXEABi/aLK00g2Nx+4kypJeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269737; c=relaxed/simple;
	bh=wwXZY5GdG4n0jEoi2bs4ssdvrV+7cuMAHqMUWo3Msys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBbBPQrbg/NmnHTt0g22DovILHSVluhNaWYw8Sq6faSqle+pCWzRu8uzTuFdgoDKHuv+L3KTWFNDuTli8UEWxc/TZ2TE68tUlLVnN+SdWnImDmXTkZuKepEDJR6chour55KRxvWO4/+hPFsO7HQ6Kc6MUutapEt0A4Nea5wGJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kjqs/xoo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2be2361efso7338335ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713269734; x=1713874534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zQPNoqoD7IacLS4osEkWLaaMBgy95aK11WInzHtzqI=;
        b=Kjqs/xooJStd001TbSMcIn8qYkZAsjXAC34YTO34iyiWicYWcWYFALZdQC5ED5gfsD
         iZ3cCk/XCpr6dYJ6cSsHPBf2prhhnywKU+e+RR37nWiLIABLCts6+/KpGqZeu9V8F+yE
         yQtsIiJwbogOnL8VE/IgklbE5NTpzbJ05G0HZ0u99h0vIPZO5acJpMhYNF9bjytqCctn
         ZUKD7KuqMbGwUxbzQo+thont3frc3LAGTUIWV4/XBVNyJ9m9sBCw0Ht107rfmqynAr+O
         0barLJhXyPHVAgUGQZ0b8qqWtKnepe4jhGa6c7I777iMdldGlNAIJSiX/2Jqt0Cxj9OR
         LgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269734; x=1713874534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zQPNoqoD7IacLS4osEkWLaaMBgy95aK11WInzHtzqI=;
        b=Jtj84IfwKq70nA9cgycqGWLDxXR+ASYGV3x4uf+mAx5kzwmnGi8cHYXpoWZV7VBhVu
         epz04H222U6b+9VY6QDSITYifo16MEoDLGgpzpFEEU65L4+uk+aNbwO6khs6oNwiL311
         kGpq+b9dPl597VY3XB8gw9ldKs92Cjo5P5rTBVsyQj0jnZHkCdGpsOL/SprgKBMeC/dG
         4/o4WIW8s5GmkgRfjrbE4xImAzkmha8p4BsrpYPwa/+5yBhzrSM4qHQK8Ng2GsWRgUon
         wQjQS8nnxIbqBXPTApmbqanHX3s6KCt2CphXB9OEEhsikHkBKfTCSrxCuytNu+3K7Q8x
         oqEw==
X-Gm-Message-State: AOJu0Yy+fV/17jRWGMtJ4O6eRyI6MMkx4m/nJnze8tHJn0sLtlfrtuiV
	BK1Gfv2o9D0xgwx0ak+zdQ8L29t8H8e23nAwmJgGFM7hvPoEFZOHQLmgY7XLogPDYfGWNf5YJ0J
	F
X-Google-Smtp-Source: AGHT+IFIO+91FCVJHbHnNWsAVEM+LOCE4SnQPDZzAR6MaodLTB0LVa0OognIPTOyoRIvkicclF38QA==
X-Received: by 2002:a17:902:f542:b0:1e2:b3d:8c67 with SMTP id h2-20020a170902f54200b001e20b3d8c67mr14774923plf.6.1713269734176;
        Tue, 16 Apr 2024 05:15:34 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b001e43576a7a1sm9584693plh.222.2024.04.16.05.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:15:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] sched/core: add helpers for iowait handling
Date: Tue, 16 Apr 2024 06:11:18 -0600
Message-ID: <20240416121526.67022-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416121526.67022-1-axboe@kernel.dk>
References: <20240416121526.67022-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds helpers to inc/dec the runqueue iowait count, based on the task, and
use those in the spots where the count is manipulated.

Adds an rq_iowait() helper, to abstract out how the per-rq stats are read.

No functional changes in this patch, just in preparation for switching
the type of 'nr_iowait'.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/sched/core.c    | 23 +++++++++++++++++++----
 kernel/sched/cputime.c |  3 +--
 kernel/sched/sched.h   |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..977bb08a33d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3721,6 +3721,21 @@ static inline cpumask_t *alloc_user_cpus_ptr(int node)
 
 #endif /* !CONFIG_SMP */
 
+static void task_iowait_inc(struct task_struct *p)
+{
+	atomic_inc(&task_rq(p)->nr_iowait);
+}
+
+static void task_iowait_dec(struct task_struct *p)
+{
+	atomic_dec(&task_rq(p)->nr_iowait);
+}
+
+int rq_iowait(struct rq *rq)
+{
+	return atomic_read(&rq->nr_iowait);
+}
+
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 {
@@ -3787,7 +3802,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 #endif
 	if (p->in_iowait) {
 		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
+		task_iowait_dec(p);
 	}
 
 	activate_task(rq, p, en_flags);
@@ -4364,7 +4379,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		if (task_cpu(p) != cpu) {
 			if (p->in_iowait) {
 				delayacct_blkio_end(p);
-				atomic_dec(&task_rq(p)->nr_iowait);
+				task_iowait_dec(p);
 			}
 
 			wake_flags |= WF_MIGRATED;
@@ -5472,7 +5487,7 @@ unsigned long long nr_context_switches(void)
 
 unsigned int nr_iowait_cpu(int cpu)
 {
-	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+	return rq_iowait(cpu_rq(cpu));
 }
 
 /*
@@ -6692,7 +6707,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
 
 			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
+				task_iowait_inc(prev);
 				delayacct_blkio_start();
 			}
 		}
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..7d9423df7779 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -222,9 +222,8 @@ void account_steal_time(u64 cputime)
 void account_idle_time(u64 cputime)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
-	struct rq *rq = this_rq();
 
-	if (atomic_read(&rq->nr_iowait) > 0)
+	if (rq_iowait(this_rq()) > 0)
 		cpustat[CPUTIME_IOWAIT] += cputime;
 	else
 		cpustat[CPUTIME_IDLE] += cputime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..387f67ddf18a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3473,4 +3473,6 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
+int rq_iowait(struct rq *rq);
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.43.0


