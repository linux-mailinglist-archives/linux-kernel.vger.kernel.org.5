Return-Path: <linux-kernel+bounces-84018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC57086A163
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13382858D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5BE14F9FB;
	Tue, 27 Feb 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mxdj6o+x"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2314EFEF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068323; cv=none; b=MWqzb/NO+xKuZ8XpcYm5WZVjD0kF4cekeSZcU3YW8/GJg1Z6Y37hFFKoWbRqsKbqqsjfw/e28vaoH+WdlFji+S61zKLYIL5OIk1ElTRE6S0JCT9Ns/PmAfY+t46GQ6mta7GwiLIWL6KySGrqFS4fj+DDHEX/VW8TA+FuBtykbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068323; c=relaxed/simple;
	bh=w06Umm5252R60SRGZKwUa14KZUW8tHC57/MIuteNbTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4uq1o4Uuyh6AJPVv6ssk/Gb7MDjfhE1GRWYcw7DkdQ8NoVzZcpxhpnohxJ8OpwerEMzqEZN6xVS9G+XHTfZM/JGzcvYc2HY7sQwWEOGxw4YI61eW+R6uxTX5SLGUyK76bRjkIZs73wgqXhqFesgxkRyGLY2nQfqkHDpi4ROd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mxdj6o+x; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso95918439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709068319; x=1709673119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HrxEe82LZ+FovBHXatuNZPDL4jKqfHjqLWXlSVO5dw=;
        b=mxdj6o+xWfFCiri+MhAL/CodXqFy4LT0zLlA+XOCdQvY5/b1tp+SmZRydz3xu/CV7Y
         /SUewtEUmBCj1Kx5MWQjob2It2FrixCTBeyOEk5JPSCQ5G7Ugmr4FJ76n03Po+/mj2Rt
         bidaRgzm52H0BO9YAT1A3USc9b1qynYMXMEPFAAkDeBn+tdDyCG9vqlAqkAUNoMAFPLW
         oc5kXNcj4l4eoZW1Vf7KT2xYnRNow9VvSX3jA4W9OCq6478cD/QrvKXhoDouQndKD76M
         XPtiKWNF7UfoW/ZWVkKGkxF5fvQM+jY0O1yaYMLYSzaZwBpj5oDT1LeYiN3OowN/fNx7
         Vgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068319; x=1709673119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HrxEe82LZ+FovBHXatuNZPDL4jKqfHjqLWXlSVO5dw=;
        b=rOQ3juQshi9n0ocPVO1nvfhTSEprgE9O48Wmoppd8IxzKbQWVuktwejR5hF9pZwFLP
         Xo4P5VZOIqbnn2B8oUV4d90yDOpW5SylMYZjXZppvVNlqh6BkTUQYWboqDHNe+cdgsxS
         CpoGGB9QXGgaTFOGJ24e/DoGgP5MykIyTgSJ61nRolI6JxeSyKKL8tjUk0fUbLkEaAg9
         I/R4Opb/dmrQiYUPc+Xi1hA0Lv4+0wHaPBwFmyfNEaM7QaU70b765Aht1qpPboMBuFKZ
         6mv4RfdGgnl+IVU8qKKfPvlnIRO0XrMsLSbQ1SWh2TmTEYgzltv70IJWfqsm+vvarOPo
         McQQ==
X-Gm-Message-State: AOJu0YyhlAyPYtzDh1QQnHiNR0QYbwn1gRWxn/CYTMy+e2GOivlSwkbn
	sSWqU4NDJ8ekPE/DPx6j50GgmR8gxMvdLG+WqgxuUEqt5LDNc+mZKa88JeGWif00cQGaJmavnH+
	4
X-Google-Smtp-Source: AGHT+IF+HJARzL2Ze/kTkxF9ggwf4LgCOV/CmODaicGQ0CSK1HlWo3rBSXjvK74ZyjAfdQ66led33A==
X-Received: by 2002:a05:6e02:214d:b0:365:3fb7:f77 with SMTP id d13-20020a056e02214d00b003653fb70f77mr11185914ilv.3.1709068319561;
        Tue, 27 Feb 2024 13:11:59 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u8-20020a056a00098800b006e5557128efsm735390pfg.133.2024.02.27.13.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:11:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] sched/core: split iowait state into two states
Date: Tue, 27 Feb 2024 14:06:03 -0700
Message-ID: <20240227211152.1099534-3-axboe@kernel.dk>
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

iowait is a bogus metric, but it's helpful in the sense that it allows
short waits to not enter sleep states that have a higher exit latency
than we would've picked for iowait'ing tasks. However, it's harmless in
that lots of applications and monitoring assumes that iowait is busy
time, or otherwise use it as a health metric. Particularly for async
IO it's entirely nonsensical.

Split the iowait part into two parts - one that tracks whether we need
boosting for short waits, and one that says we need to account the task
as such. ->in_iowait_acct nests inside of ->in_iowait, both for
efficiency reasons, but also so that the relationship between the two
is clear. A waiter may set ->in_wait alone and not care about the
accounting.

Existing users of nr_iowait() for accounting purposes are switched to
use nr_iowait_acct(), which leaves the governor using nr_iowait() as it
only cares about iowaiters, not the accounting side.

io_schedule_prepare() and io_schedule_finish() are changed to return
a simple mask of two state bits, as we now have more than one state to
manage. Outside of that, no further changes are needed to suppor this
generically.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/s390/appldata/appldata_base.c |  2 +-
 arch/s390/appldata/appldata_os.c   |  2 +-
 fs/proc/stat.c                     |  2 +-
 include/linux/sched.h              |  6 +++++
 include/linux/sched/stat.h         | 10 +++++--
 kernel/sched/core.c                | 42 ++++++++++++++++++++++++------
 kernel/sched/sched.h               |  1 +
 kernel/time/tick-sched.c           |  6 ++---
 8 files changed, 55 insertions(+), 16 deletions(-)

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
index ffe8f618ab86..1e198e268df1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -922,7 +922,13 @@ struct task_struct {
 
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
index 0108a38bb64d..7c48a35f98ee 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -19,8 +19,14 @@ DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 extern unsigned int nr_running(void);
 extern bool single_task_running(void);
-extern unsigned int nr_iowait(void);
-extern unsigned int nr_iowait_cpu(int cpu);
+extern unsigned int nr_iowait_acct(void);
+extern unsigned int nr_iowait_acct_cpu(int cpu);
+unsigned int nr_iowait_cpu(int cpu);
+
+enum {
+	TASK_IOWAIT		= 1,
+	TASK_IOWAIT_ACCT	= 2,
+};
 
 static inline int sched_info_on(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ecc6c26096e5..003208c758e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3790,6 +3790,8 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 	if (p->in_iowait) {
 		delayacct_blkio_end(p);
 		task_rq(p)->nr_iowait--;
+		if (p->in_iowait_acct)
+			task_rq(p)->nr_iowait_acct--;
 	}
 
 	activate_task(rq, p, en_flags);
@@ -4359,6 +4361,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 				rq_lock(rq, &rf);
 				task_rq(p)->nr_iowait--;
+				if (p->in_iowait_acct)
+					task_rq(p)->nr_iowait_acct--;
 				rq_unlock(rq, &rf);
 				delayacct_blkio_end(p);
 			}
@@ -5466,9 +5470,9 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned int nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_acct_cpu(int cpu)
 {
-	return cpu_rq(cpu)->nr_iowait;
+	return cpu_rq(cpu)->nr_iowait_acct;
 }
 
 /*
@@ -5501,16 +5505,21 @@ unsigned int nr_iowait_cpu(int cpu)
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
 
+unsigned int nr_iowait_cpu(int cpu)
+{
+	return cpu_rq(cpu)->nr_iowait;
+}
+
 #ifdef CONFIG_SMP
 
 /*
@@ -6687,6 +6696,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 			if (prev->in_iowait) {
 				rq->nr_iowait++;
+				if (prev->in_iowait_acct)
+					rq->nr_iowait_acct++;
 				delayacct_blkio_start();
 			}
 		}
@@ -8989,18 +9000,32 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 }
 EXPORT_SYMBOL_GPL(yield_to);
 
+/*
+ * Returns a token which is comprised if the two bits of iowait wait state -
+ * one is whether we're making ourselves as in iowait for cpufreq reasons,
+ * and the other is if the task should be accounted as such.
+ */
 int io_schedule_prepare(void)
 {
-	int old_iowait = current->in_iowait;
+	int old_wait_flags = 0;
+
+	if (current->in_iowait)
+		old_wait_flags |= TASK_IOWAIT;
+	if (current->in_iowait_acct)
+		old_wait_flags |= TASK_IOWAIT_ACCT;
 
 	current->in_iowait = 1;
+	current->in_iowait_acct = 1;
 	blk_flush_plug(current->plug, true);
-	return old_iowait;
+	return old_wait_flags;
 }
 
-void io_schedule_finish(int token)
+void io_schedule_finish(int old_wait_flags)
 {
-	current->in_iowait = token;
+	if (!(old_wait_flags & TASK_IOWAIT))
+		current->in_iowait = 0;
+	if (!(old_wait_flags & TASK_IOWAIT_ACCT))
+		current->in_iowait_acct = 0;
 }
 
 /*
@@ -10034,6 +10059,7 @@ void __init sched_init(void)
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
+		rq->nr_iowait_acct = 0;
 		rq->nr_iowait = 0;
 
 #ifdef CONFIG_SCHED_CORE
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a1222a4bdc7b..ee390fc664ae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1049,6 +1049,7 @@ struct rq {
 	u64			clock_idle_copy;
 #endif
 
+	unsigned int		nr_iowait_acct;
 	unsigned int		nr_iowait;
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 01fb50c1b17e..f6709d543dac 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -669,7 +669,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 	delta = ktime_sub(now, ts->idle_entrytime);
 
 	write_seqcount_begin(&ts->idle_sleeptime_seq);
-	if (nr_iowait_cpu(smp_processor_id()) > 0)
+	if (nr_iowait_acct_cpu(smp_processor_id()) > 0)
 		ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
 	else
 		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
@@ -742,7 +742,7 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
 	return get_cpu_sleep_time_us(ts, &ts->idle_sleeptime,
-				     !nr_iowait_cpu(cpu), last_update_time);
+				     !nr_iowait_acct_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 
@@ -768,7 +768,7 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
 	return get_cpu_sleep_time_us(ts, &ts->iowait_sleeptime,
-				     nr_iowait_cpu(cpu), last_update_time);
+				     nr_iowait_acct_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
-- 
2.43.0


