Return-Path: <linux-kernel+bounces-85593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33CC86B816
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6FB22035
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43215DBAE;
	Wed, 28 Feb 2024 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f3hd7WoW"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74E74421
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148247; cv=none; b=R7neLyhFqQn6KzmnTKlTooeoKXfMZd3c8xh3kX/Hr/Ibe9rCEGv1wKkcvyfZPwCtJv7SSaT+rLd8fLoaCBXD9P5fhRLXDufJsFnHwNz8PVZ0RIHlXt+rUtxf3JCtgQ5n6fFeLF/PkBMvWifg/ZcoAcylBxZJM8YFmvmkr40NtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148247; c=relaxed/simple;
	bh=QA0fPWib+YPPc1PODUfkCz0IwFdmlpf0p6N1HD6qY8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp6tO+bynn6dITWS30cF21T9v1lRTRkjKfvXWh1/C9dOzwI+2NBY2HtI3z21qyeBK69CCotgMe8eEfTt9iaJucM9aXEHL77s9IufJgYm7JHCzvKhlKo1sXlvjIEwzw+zf5o3hoKRvUz0vZ+V5dwPCRAFfmIDXyiOR4vnahvO0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f3hd7WoW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dbd81000b6so481555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709148244; x=1709753044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiHI6t1uZT8CoFgwCByenNek8ZKdV2Mgf3I6FVHUuUE=;
        b=f3hd7WoW1u1YQ69QQ9i5kV3lyEMerHock0xkHkKYrpmvn2996wcdVby+eZI21KrHWa
         nVdJHMGdX82mMHwZ/8xgZJQD4KqQK38fFHF2vT2YiOPp5LKohxSmq2FLMKnA0T1FKVA2
         HXoG86TxE5EQOL4fTwx2Tkx5wXhxYbcMX/2HpsweeuWI9mHSjK8gcdt+Yf8UZluMCIkh
         NFRdF9DBWlluNCmbKg6x1AMfU5vDCFFYe40rUEpWoZd07ZwULqWmVRqZxNQ9WJDPypf5
         lDxFRxzKShnVuzQLl7gxoHATaXfEmkVnJQO5Z0TWR+QBRzdZaxtkma/kU67fGUF1jR+l
         CZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148244; x=1709753044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiHI6t1uZT8CoFgwCByenNek8ZKdV2Mgf3I6FVHUuUE=;
        b=Lx2tBi7ka3yTNqLTEt/43x3tHvK/ILZcXKgld1fpvYSzstPCrrdXj6Qxz3Af2501IP
         6yE4QCfwXfweKEnWx9rD/szDusCka8xYsnjrBjD5nlts60aP4h2KLHrdb2hmEXDmLTYG
         f1OzfVwTgUI23rFyeNxmZgE4PekbFL4ySvJvOZago+WVJK7rg2E+S5Gp41xewue/88Fi
         wXk8iw5NJ+9zYKAjt7NoWjwHTKZO0wubyICd4VcRejUZI6GG60fxqFcug19KXgV8V7Bc
         a+chX8KdlcOdHmVnCBOW+8UbB4+RI3z8eOF9bUO4F/tNUAL9UpVNzXZh9oCDYOd6WXKl
         VnzQ==
X-Gm-Message-State: AOJu0YxU1IOJ0h5IDiHWpgtMM61+ftYTH7+3ov0arxuHV6YZh0bJ8MFO
	n8D/olAAGXoLJvmgTP54NO0yhZWLZxeW3DpEww2oEXDWSagewnIJH2KOwOF+hGSvjbhmgkd7B0i
	E
X-Google-Smtp-Source: AGHT+IHgCSvhHaxFJvfR6VuVxe3Z96J8yxLqPFmu2U8BvMIEDrec+L1AotK1ZjwJa76MBrj22IvnSA==
X-Received: by 2002:a17:90a:3d45:b0:298:b736:ecf7 with SMTP id o5-20020a17090a3d4500b00298b736ecf7mr156126pjf.0.1709148244086;
        Wed, 28 Feb 2024 11:24:04 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a550a00b00298f2ad430csm4230pji.0.2024.02.28.11.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 11:24:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] sched/core: split iowait state into two states
Date: Wed, 28 Feb 2024 12:16:57 -0700
Message-ID: <20240228192355.290114-3-axboe@kernel.dk>
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
 include/linux/sched.h              |  6 ++++
 include/linux/sched/stat.h         | 10 +++++--
 kernel/sched/core.c                | 45 ++++++++++++++++++++++++------
 kernel/sched/sched.h               |  2 ++
 kernel/time/tick-sched.c           |  6 ++--
 8 files changed, 59 insertions(+), 16 deletions(-)

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
index 48d15529a777..66a3654aab5d 100644
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
@@ -4358,6 +4360,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 				delayacct_blkio_end(p);
 				atomic_inc(&__rq->nr_iowait_remote);
+				if (p->in_iowait_acct)
+					atomic_inc(&__rq->nr_iowait_acct_remote);
 			}
 
 			wake_flags |= WF_MIGRATED;
@@ -5463,11 +5467,11 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned int nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_acct_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	return rq->nr_iowait - atomic_read(&rq->nr_iowait_remote);
+	return rq->nr_iowait_acct - atomic_read(&rq->nr_iowait_acct_remote);
 }
 
 /*
@@ -5500,16 +5504,23 @@ unsigned int nr_iowait_cpu(int cpu)
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
+	struct rq *rq = cpu_rq(cpu);
+
+	return rq->nr_iowait - atomic_read(&rq->nr_iowait_remote);
+}
+
 #ifdef CONFIG_SMP
 
 /*
@@ -6686,6 +6697,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 			if (prev->in_iowait) {
 				rq->nr_iowait++;
+				if (prev->in_iowait_acct)
+					rq->nr_iowait_acct++;
 				delayacct_blkio_start();
 			}
 		}
@@ -8988,18 +9001,32 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 }
 EXPORT_SYMBOL_GPL(yield_to);
 
+/*
+ * Returns a token which is comprised of the two bits of iowait wait state -
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
@@ -10033,6 +10060,8 @@ void __init sched_init(void)
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
+		rq->nr_iowait_acct = 0;
+		atomic_set(&rq->nr_iowait_acct_remote, 0);
 		rq->nr_iowait = 0;
 		atomic_set(&rq->nr_iowait_remote, 0);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 91fa5b4d45ed..abd7a938bc99 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1054,6 +1054,8 @@ struct rq {
 	 * modified under the rq lock (nr_iowait), and if we don't have the rq
 	 * lock, then nr_iowait_remote is used.
 	 */
+	unsigned int		nr_iowait_acct;
+	atomic_t		nr_iowait_acct_remote;
 	unsigned int		nr_iowait;
 	atomic_t		nr_iowait_remote;
 
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


