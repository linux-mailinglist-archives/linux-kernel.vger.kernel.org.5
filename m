Return-Path: <linux-kernel+bounces-81884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F1867B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E6B1C289D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17EE12C800;
	Mon, 26 Feb 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iJRhgGHV"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F0F12C819
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964136; cv=none; b=lSd/z9Yfi0LVVlOmcRkxwSEuIfcMesb0L5rzyxj4+sk3v62hDYYluET5S0rcdV1wz1BHfuN7X3LjUvPwwDQZw6cTA2EvSyZqWd4mLFeFXu/kT/e9+KSRc3lHtk6fFStsXCWxJk1p6D4f8kj3JMjZampKcu3wWWE6wXVnOig/CIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964136; c=relaxed/simple;
	bh=cRuyM/cz7UJ5tY0vRJ2S/aG3c5hODfkkeEollDAYOlc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=tLusKbzdBVzSXBBFMc6a93XZAwJf+uvOwOmRZQPpHTfKkNhlqN3OajKjUQmr+aE/LD4cRbX99WJfBfSmIXI4SQ1MZRAV9jTVpgzv+G26sueiLFt8fJ1L8QuqDpYyxZb1qKyD6qahLqvQdTeJ+JTMXet9owt0LWYf58CWLFwxvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iJRhgGHV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c787eee137so35716639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708964131; x=1709568931; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I54WSlbdMoyir97qensX4jHmZa71QCXBDskyk04TZEo=;
        b=iJRhgGHVRvrTqA9r0NK1eocubzhc3DN0WArOTLWXicU32i7v2b2+COeYtEK1ugF0mu
         ChPP2tH1ogp8DQ9CW+cJnjdm++bOFx4FhokPP8evOR8pvmz1SLdLi9NBHEyP/afXfB7+
         0+NTWQGkz+n+04hhun67vv12U9+2njug0MaOFVmcnASPIVubhQm9EmfFqr/Qu+Q5Hxvu
         +dFjNQENVfRknEel/ZQiFV9r96NNjIQdSKWMBvA6aOadiMLmL7sFtWPnQrhi2MJ6Q2od
         1kqJaYVC1ZYDsX/xLJmSPT9YolWnJ1duvx8q6rdJg7UB/EbMS3AkVGQoT+uXiJUcG8Mm
         YfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964131; x=1709568931;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I54WSlbdMoyir97qensX4jHmZa71QCXBDskyk04TZEo=;
        b=jN0+KH00EfmzSQy6SAmq2pK6VlsJUzZdTiemN8YsJbnBEewkYKH7zYxV0za4u21Yh7
         He4YEsOHfQo6I2+jtxvvMQdoC+FhUp6UUqDiaOj5hWq07p8qDR4KDWrdAHZ++a9V2l+9
         FJYBccxzTnu+D9m9z82xnjcZJd9BiPPX+4NzdxjZ+xTXAUGUVtXpPLgwO33B9wXs5Hz5
         vpUyL2Kcui5KDClrl7taa4He/5noVmDuM2UyS67AKtQL+IYSbNlyYdyGHYraGaFnJ0T4
         WXsgIzKtG9TxaVIoE/mve3IMGrcdKI6VPBBfwDhlTVkKpbIKyCv2VgaEP4Q2JeUMwlTU
         ndpQ==
X-Gm-Message-State: AOJu0YwWPbXd+iDyKyMOKMp/sCcRS1yiE2Huew807kn3KyQtrxyoholT
	/njc4o2O9F0KvGDF0q3BGr4zPb4KYQ4CCD9TR24OxNpPQMZuqIWr90i2MhsncaqXcXovtkgKe+B
	u
X-Google-Smtp-Source: AGHT+IEsAzVS8gynMDSXixoRV2040OgYiGHxgVkH2NG/5jTMZ+91y01CcsNJWAcRbHykwH7/b0dIiQ==
X-Received: by 2002:a6b:da17:0:b0:7c7:a02d:f102 with SMTP id x23-20020a6bda17000000b007c7a02df102mr6966737iob.0.1708964131195;
        Mon, 26 Feb 2024 08:15:31 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o19-20020a056638125300b004749076ce07sm276531jas.127.2024.02.26.08.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:15:30 -0800 (PST)
Message-ID: <9610e52e-1d9a-466d-be2b-29482f0d0490@kernel.dk>
Date: Mon, 26 Feb 2024 09:15:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] sched/core: split iowait state into two states
To: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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

 arch/s390/appldata/appldata_os.c |  2 +-
 fs/proc/stat.c                   |  2 +-
 include/linux/sched.h            |  6 ++++++
 include/linux/sched/stat.h       | 10 +++++++--
 kernel/sched/core.c              | 37 +++++++++++++++++++++++++-------
 kernel/sched/sched.h             |  1 +
 kernel/time/tick-sched.c         |  6 +++---
 7 files changed, 49 insertions(+), 15 deletions(-)

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
index 9116bcc90346..c643d44e38e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3790,6 +3790,8 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 	if (p->in_iowait) {
 		delayacct_blkio_end(p);
 		atomic_dec(&task_rq(p)->nr_iowait);
+		if (p->in_iowait_acct)
+			atomic_dec(&task_rq(p)->nr_iowait_acct);
 	}
 
 	activate_task(rq, p, en_flags);
@@ -4356,6 +4358,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			if (p->in_iowait) {
 				delayacct_blkio_end(p);
 				atomic_dec(&task_rq(p)->nr_iowait);
+				if (p->in_iowait_acct)
+					atomic_dec(&task_rq(p)->nr_iowait_acct);
 			}
 
 			wake_flags |= WF_MIGRATED;
@@ -5461,9 +5465,9 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned int nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_acct_cpu(int cpu)
 {
-	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+	return atomic_read(&cpu_rq(cpu)->nr_iowait_acct);
 }
 
 /*
@@ -5496,16 +5500,21 @@ unsigned int nr_iowait_cpu(int cpu)
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
+	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+}
+
 #ifdef CONFIG_SMP
 
 /*
@@ -6682,6 +6691,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 			if (prev->in_iowait) {
 				atomic_inc(&rq->nr_iowait);
+				if (prev->in_iowait_acct)
+					atomic_inc(&rq->nr_iowait_acct);
 				delayacct_blkio_start();
 			}
 		}
@@ -8986,16 +8997,25 @@ EXPORT_SYMBOL_GPL(yield_to);
 
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
@@ -10029,6 +10049,7 @@ void __init sched_init(void)
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
+		atomic_set(&rq->nr_iowait_acct, 0);
 		atomic_set(&rq->nr_iowait, 0);
 
 #ifdef CONFIG_SCHED_CORE
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..9006335b01c8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1049,6 +1049,7 @@ struct rq {
 	u64			clock_idle_copy;
 #endif
 
+	atomic_t		nr_iowait_acct;
 	atomic_t		nr_iowait;
 
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
Jens Axboe


