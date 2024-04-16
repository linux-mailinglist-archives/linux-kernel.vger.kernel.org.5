Return-Path: <linux-kernel+bounces-146765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C588A6A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40971F21925
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB99112C47C;
	Tue, 16 Apr 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZGlE3qE8"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E512C477
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269744; cv=none; b=pi7JfqVIgAjF5Ds9biI5jKqsI1yTBFKFYMHcfN/Qv3zJE2pIPNzlzJrfWsaQOeWQgxkxtSSCNF1kBKWuuSiDM6gHCu+7wXNz0E4ae88QeO4jLmlyqw9zxcAtsWprhkxoN0sS1B6TajYpmfvclMrYARreuMSmKlP5JZH1zog8bpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269744; c=relaxed/simple;
	bh=VSoxAqTuDxa+6uoGvfJFwbhJiCuybB38cw3O7vNfl1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKI9IRdB2s5ZhtXtGu7Lp/Bqh90bX+tzZymaeT8NMnjSulE+n8ap2ZRIyagZ5bq0UhdtcRpslydj2RnW9C9DKDAuWbd0/vsDUcitj0woNko3C5Ius+BHMdktSUD5RBeGRBYnDx8fuIXDGj2mvAQ1Ogypn+MJYTKzfyy1psHsKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZGlE3qE8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-58962bf3f89so933204a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713269740; x=1713874540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PW6BtyfwXVpH9eVQnlmZoioSuL4oqjoVMV11U1Fnm0=;
        b=ZGlE3qE8OkajM7B2cUZS8s8xPjAcdl521EjEuGYemCcEBzh9nDATLG1AGzzvn/lIX6
         7SyktK/nT6ET6xh3dz9lQpjvcDHK4Wn1tWodaYt4tvDrCpkfS29GJ1MlNgC6Fma/UP15
         FbKr9EZmfbiYEQy/1+Kf9hwML0/mvEItKbII3B9XQIilDhxH047pqFNgPkHD1WIc0qPP
         wt4tAxH3QmijbYsxrhi2czlEtUq4ARsVHZY/PSmz0atfpQ8pJzvuuwTKpweKP94sEdO6
         m3IVRUevPBydC3ACNcJ3Jnzi7Yf0p7209EIj3rZBSzGB195TnfGa1/6WW1u4H5TxuHLS
         ji6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269740; x=1713874540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PW6BtyfwXVpH9eVQnlmZoioSuL4oqjoVMV11U1Fnm0=;
        b=v8eQaxQFcHv8PIYGSMdNpuVZZH5tTIii1DFQSc5pKTwYR2LgfJhxueKXKU5sume79d
         DPXsabrhBTjsfZ722MS5yG5vb4Af8ZRBpOh45E0mZNjw9pKQ9xkenF6dlC9LJz4t4rLh
         zioPpqSSsgm/xmBIJRe3UwDaYyuRFtONbbfoV9Csu71IRFTRfQE6R9GPDwkCTt1rrjq4
         eCsJb3OkGvEsplCg3c0h1OxNMymu1hGD18FbCTAGDjmrKC8w0fWjQm6QKOMiHodTkhHY
         OnRBK+IQZtFvpHdgjZlIF3uybnTanM+B14H0xL/9W3Z/xVwrxDTwili/vHpeXRuw2dm3
         XLtQ==
X-Gm-Message-State: AOJu0YzM9jePXjE1Zy48UD/TGj+wqZnGI8lldKiOo9NPxyb2appNP7Bl
	egtzmkCbmOlqT8zXdb46s654+StEO4uN9gDnbH5gqq+xuKMaEem3GVq2kfy13tpfYwBJdLmsJTz
	6
X-Google-Smtp-Source: AGHT+IFiEimvabQ9W1pWfZxF5RlCzxrarUbVzqrMzUi9GJmZzunHkqQZ/2qPhileRkKKn5R8kcmXpw==
X-Received: by 2002:a05:6a20:3cac:b0:1a7:9b9a:757b with SMTP id b44-20020a056a203cac00b001a79b9a757bmr17077897pzj.1.1713269739851;
        Tue, 16 Apr 2024 05:15:39 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b001e43576a7a1sm9584693plh.222.2024.04.16.05.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:15:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] sched/core: split iowait state into two states
Date: Tue, 16 Apr 2024 06:11:21 -0600
Message-ID: <20240416121526.67022-5-axboe@kernel.dk>
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

iowait is a bogus metric, but it's helpful in the sense that it allows
short waits to not enter sleep states that have a higher exit latency
than would've otherwise have been picked for iowait'ing tasks. However,
it's harmless in that lots of applications and monitoring assumes that
iowait is busy time, or otherwise use it as a health metric.
Particularly for async IO it's entirely nonsensical.

Split the iowait part into two parts - one that tracks whether the task
needs boosting for short waits, and one that marks whether the task
needs to be accounted as such. ->in_iowait_acct nests inside of
->in_iowait, both for efficiency reasons, but also so that the
relationship between the two is clear. A waiter may set ->in_wait alone
and not care about the accounting.

Existing users of nr_iowait() for accounting purposes are switched to
use nr_iowait_acct(), which leaves the governor using nr_iowait() as it
only cares about iowaiters, not the accounting side.

Utilize that there's enough space in rq->nr_iowait to store both values
in there, shifting the accounting side by half the size of the type.
Thank you to Thomas Gleixner for that [1] suggestion.

[1] https://lore.kernel.org/lkml/87sf1b6o9w.ffs@tglx/

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/s390/appldata/appldata_base.c |  2 +-
 arch/s390/appldata/appldata_os.c   |  2 +-
 fs/proc/stat.c                     |  2 +-
 include/linux/sched.h              |  6 +++
 include/linux/sched/stat.h         |  5 ++-
 kernel/sched/core.c                | 62 +++++++++++++++++++++++-------
 kernel/sched/sched.h               |  1 +
 kernel/time/tick-sched.c           |  6 +--
 8 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index c2978cb03b36..6844b5294a8b 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -423,4 +423,4 @@ EXPORT_SYMBOL_GPL(si_swapinfo);
 #endif
 EXPORT_SYMBOL_GPL(nr_threads);
 EXPORT_SYMBOL_GPL(nr_running);
-EXPORT_SYMBOL_GPL(nr_iowait);
+EXPORT_SYMBOL_GPL(nr_iowait_acct);
diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
index a363d30ce739..fa4b278aca6c 100644
--- a/arch/s390/appldata/appldata_os.c
+++ b/arch/s390/appldata/appldata_os.c
@@ -100,7 +100,7 @@ static void appldata_get_os_data(void *data)
 
 	os_data->nr_threads = nr_threads;
 	os_data->nr_running = nr_running();
-	os_data->nr_iowait  = nr_iowait();
+	os_data->nr_iowait  = nr_iowait_acct();
 	os_data->avenrun[0] = avenrun[0] + (FIXED_1/200);
 	os_data->avenrun[1] = avenrun[1] + (FIXED_1/200);
 	os_data->avenrun[2] = avenrun[2] + (FIXED_1/200);
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index da60956b2915..149be7a884fb 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -180,7 +180,7 @@ static int show_stat(struct seq_file *p, void *v)
 		(unsigned long long)boottime.tv_sec,
 		total_forks,
 		nr_running(),
-		nr_iowait());
+		nr_iowait_acct());
 
 	seq_put_decimal_ull(p, "softirq ", (unsigned long long)sum_softirq);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index dcfc2830ed8e..26c69db5484b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -924,7 +924,13 @@ struct task_struct {
 
 	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
+	/* task is in iowait */
 	unsigned			in_iowait:1;
+	/*
+	 * task is in iowait and should be accounted as such. can only be set
+	 * if ->in_iowait is also set.
+	 */
+	unsigned			in_iowait_acct:1;
 #ifndef TIF_RESTORE_SIGMASK
 	unsigned			restore_sigmask:1;
 #endif
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 0108a38bb64d..31e8a44b3d71 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -19,8 +19,9 @@ DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 extern unsigned int nr_running(void);
 extern bool single_task_running(void);
-extern unsigned int nr_iowait(void);
-extern unsigned int nr_iowait_cpu(int cpu);
+unsigned int nr_iowait_acct(void);
+unsigned int nr_iowait_acct_cpu(int cpu);
+unsigned int nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 63f6d44f460c..d52d3118dd73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3721,30 +3721,47 @@ static inline cpumask_t *alloc_user_cpus_ptr(int node)
 
 #endif /* !CONFIG_SMP */
 
+/*
+ * Store iowait and iowait_acct state in the same variable. The lower bits
+ * hold the iowait state, and the upper bits hold the iowait_acct state.
+ */
 static void task_iowait_inc(struct task_struct *p)
 {
 #ifdef CONFIG_64BIT
-	atomic_long_inc(&task_rq(p)->nr_iowait);
+	long val = 1 + ((long) p->in_iowait_acct << 32);
+	atomic_long_add(val, &task_rq(p)->nr_iowait);
 #else
-	atomic_inc(&task_rq(p)->nr_iowait);
+	int val = 1 + ((int) p->in_iowait_acct << 16);
+	atomic_add(val, &task_rq(p)->nr_iowait);
 #endif
 }
 
 static void task_iowait_dec(struct task_struct *p)
 {
 #ifdef CONFIG_64BIT
-	atomic_long_dec(&task_rq(p)->nr_iowait);
+	long val = 1 + ((long) p->in_iowait_acct << 32);
+	atomic_long_sub(val, &task_rq(p)->nr_iowait);
 #else
-	atomic_dec(&task_rq(p)->nr_iowait);
+	int val = 1 + ((int) p->in_iowait_acct << 16);
+	atomic_sub(val, &task_rq(p)->nr_iowait);
 #endif
 }
 
 int rq_iowait(struct rq *rq)
 {
 #ifdef CONFIG_64BIT
-	return atomic_long_read(&rq->nr_iowait);
+	return atomic_long_read(&rq->nr_iowait) & ((1UL << 32) - 1);
+#else
+	return atomic_read(&rq->nr_iowait) & ((1U << 16) - 1);
+#endif
+}
+
+int rq_iowait_acct(struct rq *rq)
+{
+#ifdef CONFIG_64BIT
+	return atomic_long_read(&rq->nr_iowait) >> 32;
 #else
-	return atomic_read(&rq->nr_iowait);
+	return atomic_read(&rq->nr_iowait) >> 16;
 #endif
 }
 
@@ -5497,7 +5514,12 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned int nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_acct_cpu(int cpu)
+{
+	return rq_iowait_acct(cpu_rq(cpu));
+}
+
+unsigned nr_iowait_cpu(int cpu)
 {
 	return rq_iowait(cpu_rq(cpu));
 }
@@ -5532,12 +5554,12 @@ unsigned int nr_iowait_cpu(int cpu)
  * Task CPU affinities can make all that even more 'interesting'.
  */
 
-unsigned int nr_iowait(void)
+unsigned int nr_iowait_acct(void)
 {
 	unsigned int i, sum = 0;
 
 	for_each_possible_cpu(i)
-		sum += nr_iowait_cpu(i);
+		sum += nr_iowait_acct_cpu(i);
 
 	return sum;
 }
@@ -9032,18 +9054,32 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 }
 EXPORT_SYMBOL_GPL(yield_to);
 
+/*
+ * Returns a token which is comprised of the two bits of iowait wait state -
+ * one is whether we're making ourselves as in iowait for cpufreq reasons,
+ * and the other is if the task should be accounted as such.
+ */
 long io_schedule_prepare(void)
 {
-	long old_iowait = current->in_iowait;
-
+#ifdef CONFIG_64BIT
+	long token = current->in_iowait + ((long) current->in_iowait_acct << 32);
+#else
+	int token = current->in_iowait + (current->in_iowait_acct << 16);
+#endif
 	current->in_iowait = 1;
+	current->in_iowait_acct = 1;
 	blk_flush_plug(current->plug, true);
-	return old_iowait;
+	return token;
 }
 
 void io_schedule_finish(long token)
 {
-	current->in_iowait = token;
+	current->in_iowait = token & 0x01;
+#ifdef CONFIG_64BIT
+	current->in_iowait_acct = token >> 32;
+#else
+	current->in_iowait_acct = token >> 16;
+#endif
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c2802d066615..85fdd6028682 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3478,5 +3478,6 @@ extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 int rq_iowait(struct rq *rq);
+int rq_iowait_acct(struct rq *rq);
 
 #endif /* _KERNEL_SCHED_SCHED_H */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 269e21590df5..52f377c5871d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -728,7 +728,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 	delta = ktime_sub(now, ts->idle_entrytime);
 
 	write_seqcount_begin(&ts->idle_sleeptime_seq);
-	if (nr_iowait_cpu(smp_processor_id()) > 0)
+	if (nr_iowait_acct_cpu(smp_processor_id()) > 0)
 		ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
 	else
 		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
@@ -801,7 +801,7 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
 	return get_cpu_sleep_time_us(ts, &ts->idle_sleeptime,
-				     !nr_iowait_cpu(cpu), last_update_time);
+				     !nr_iowait_acct_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 
@@ -827,7 +827,7 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
 	return get_cpu_sleep_time_us(ts, &ts->iowait_sleeptime,
-				     nr_iowait_cpu(cpu), last_update_time);
+				     nr_iowait_acct_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
-- 
2.43.0


