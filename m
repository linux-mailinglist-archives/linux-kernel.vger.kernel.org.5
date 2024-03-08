Return-Path: <linux-kernel+bounces-96910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D9876307
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92E22823BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649D656746;
	Fri,  8 Mar 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT5QjhRs"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94E5576D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896717; cv=none; b=LpYKotAFk+JhOgiFHS2GdeJ8ExhDreXj52pQinyHQIwWrcotRk8kg8xN4i+maufcZTgEFez3K20zT4JP+cVnzaEplH8YZwjKySaNlZwloKVSIzqBjhNUzEjfRQDBQQtL3xm5qvEuFlpQpH/SWoT0kppLLYM+fdxUeVYDp48+vmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896717; c=relaxed/simple;
	bh=j4tkfHZPzR5kYz6YVI0BTP7qRQhgw5O0GU29Ku4YX+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbC+AhBWUjukKvm3SdfyqBKS4CbeUy4F4T58msi4iSkYKam0GOctnOEfgqCA6W2n6hmSqYOstnM5ZRrp9boFwx9RzeGpeI0apDsInplSrk7Eu3sUG3HoWcTPpdUhsRCjkA3CZThDmkgnoJDhDHwPtctXoqsXFNsZzWe+KqsRD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT5QjhRs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e796cc90dso157136f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896714; x=1710501514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvyMn6IbB+KgK6NP2mWjU8ehV/x2G+Dw3KFHSdNlX1g=;
        b=UT5QjhRsf1XcHocriWIyrXCVUsaQFnNkLWrTgz+lqMq/lez7LwE1KVajXkUwNPnF9q
         ptN731h/LYisog++uSXPy1/+8NW1lnGC+0VRSfmVP9COlAHPZf5SbVuYIXehck5+uI45
         egysOOi0KyTMURAzoBMtMlZVHa2o/3j4m6DiAKWgviuySdhPri5Nup3EK4oyvgoqIuIZ
         BDupjCmJiDytgr0ePIlqUnHjNW0xpjPYdJV0CVLTyTo6bdHD+ice8PfVO95/oXJuT4WY
         g5Baq+lPed3Bw43hd1Fa+KAoFpD6/Iyfu2UFkjjNuyh3FTrL8kTgfqtgMCAcPUGh9DEC
         TadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896714; x=1710501514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JvyMn6IbB+KgK6NP2mWjU8ehV/x2G+Dw3KFHSdNlX1g=;
        b=D9btWZsP/19X2ieNUwpoIot8Xz+LvatVVIPO3m5ligS8zvtFSjx0Hj91mOKzvgcKEW
         LSj/ROrCC9NxrYsSWujpGng3weqlOQ7emOhhul+gpUaRZcCKi0YN+BkwGoywRoIOtmDu
         J8tZdcXK4e6YN2tAccFZi32CNGQMFpbM0ljHTE5YtU7KZia55s+gWTv4nMXD/BbHeLU5
         egkmWXZl66PpAZ8ovpO16EiqbJn0fz6uyYoQtaifRNNXpQQ2+S2Nd1FwXYO5rkBqBJSP
         gheOfrGLv0UY+r/GHdIZZJCpk4p1mSSy+4q7wEsfkWo0FYMYlPuOi8njELAP9pvAXEeJ
         bRxw==
X-Gm-Message-State: AOJu0YzPIk4IfH3EZN2xl0vUnU5iKDTNdV4jepo2sX9zeHueL/hKhiVp
	KnRklSSIoc4E9RK4A20StaIpKG0Q94VLLGeF+SUkutsU1ywdGuwA7m9GWup7TTg=
X-Google-Smtp-Source: AGHT+IG7+5UMPEvH5Oacvt/WcYRlEnGbJxeTsUdHC9mR1cYCMJ5Eq0Ty7lh0yo62vdbFk3vHghxQrA==
X-Received: by 2002:adf:ef0f:0:b0:33e:7637:51fd with SMTP id e15-20020adfef0f000000b0033e763751fdmr992319wro.48.1709896713607;
        Fri, 08 Mar 2024 03:18:33 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:33 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 02/13] sched/balancing: Rename scheduler_tick() => sched_tick()
Date: Fri,  8 Mar 2024 12:18:08 +0100
Message-Id: <20240308111819.1101550-3-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308111819.1101550-1-mingo@kernel.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- Standardize on prefixing scheduler-internal functions defined
  in <linux/sched.h> with sched_*() prefix. scheduler_tick() was
  the only function using the scheduler_ prefix. Harmonize it.

- The other reason to rename it is the NOHZ scheduler tick
  handling functions are already named sched_tick_*().
  Make the 'git grep sched_tick' more meaningful.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/scheduler/sched-domains.rst                            | 4 ++--
 Documentation/translations/zh_CN/scheduler/sched-domains.rst         | 4 ++--
 include/linux/sched.h                                                | 2 +-
 kernel/sched/core.c                                                  | 4 ++--
 kernel/sched/loadavg.c                                               | 2 +-
 kernel/time/timer.c                                                  | 2 +-
 kernel/workqueue.c                                                   | 2 +-
 tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 6577b068f921..541d6c617971 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -32,13 +32,13 @@ load of each of its member CPUs, and only when the load of a group becomes
 out of balance are tasks moved between groups.
 
 In kernel/sched/core.c, trigger_load_balance() is run periodically on each CPU
-through scheduler_tick(). It raises a softirq after the next regularly scheduled
+through sched_tick(). It raises a softirq after the next regularly scheduled
 rebalancing event for the current runqueue has arrived. The actual load
 balancing workhorse, sched_balance_softirq()->rebalance_domains(), is then run
 in softirq context (SCHED_SOFTIRQ).
 
 The latter function takes two arguments: the runqueue of current CPU and whether
-the CPU was idle at the time the scheduler_tick() happened and iterates over all
+the CPU was idle at the time the sched_tick() happened and iterates over all
 sched domains our CPU is on, starting from its base domain and going up the ->parent
 chain. While doing that, it checks to see if the current domain has exhausted its
 rebalance interval. If so, it runs load_balance() on that domain. It then checks
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
index fbc326668e37..fa0c0bcc6ba5 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -34,12 +34,12 @@ CPU共享。任意两个组的CPU掩码的交集不一定为空，如果是这
 调度域中的负载均衡发生在调度组中。也就是说，每个组被视为一个实体。组的负载被定义为它
 管辖的每个CPU的负载之和。仅当组的负载不均衡后，任务才在组之间发生迁移。
 
-在kernel/sched/core.c中，trigger_load_balance()在每个CPU上通过scheduler_tick()
+在kernel/sched/core.c中，trigger_load_balance()在每个CPU上通过sched_tick()
 周期执行。在当前运行队列下一个定期调度再平衡事件到达后，它引发一个软中断。负载均衡真正
 的工作由sched_balance_softirq()->rebalance_domains()完成，在软中断上下文中执行
 （SCHED_SOFTIRQ）。
 
-后一个函数有两个入参：当前CPU的运行队列、它在scheduler_tick()调用时是否空闲。函数会从
+后一个函数有两个入参：当前CPU的运行队列、它在sched_tick()调用时是否空闲。函数会从
 当前CPU所在的基调度域开始迭代执行，并沿着parent指针链向上进入更高层级的调度域。在迭代
 过程中，函数会检查当前调度域是否已经耗尽了再平衡的时间间隔，如果是，它在该调度域运行
 load_balance()。接下来它检查父调度域（如果存在），再后来父调度域的父调度域，以此类推。
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..739e32ead24b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -301,7 +301,7 @@ enum {
 	TASK_COMM_LEN = 16,
 };
 
-extern void scheduler_tick(void);
+extern void sched_tick(void);
 
 #define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a76c7095f736..3affa9a6b249 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5651,7 +5651,7 @@ static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
-void scheduler_tick(void)
+void sched_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
@@ -6574,7 +6574,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *      paths. For example, see arch/x86/entry_64.S.
  *
  *      To drive preemption between tasks, the scheduler sets the flag in timer
- *      interrupt handler scheduler_tick().
+ *      interrupt handler sched_tick().
  *
  *   3. Wakeups don't really cause entry into schedule(). They add a
  *      task to the run-queue and that's it.
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 52c8f8226b0d..ca9da66cc894 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -379,7 +379,7 @@ void calc_global_load(void)
 }
 
 /*
- * Called from scheduler_tick() to periodically update this CPU's
+ * Called from sched_tick() to periodically update this CPU's
  * active count.
  */
 void calc_global_load_tick(struct rq *this_rq)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 352b161113cd..ec003ad18b2d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2089,7 +2089,7 @@ void update_process_times(int user_tick)
 	if (in_irq())
 		irq_work_tick();
 #endif
-	scheduler_tick();
+	sched_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
 		run_posix_cpu_timers();
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7b482a26d741..8aa3a0829dd4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1324,7 +1324,7 @@ void wq_worker_sleeping(struct task_struct *task)
  * wq_worker_tick - a scheduler tick occurred while a kworker is running
  * @task: task currently running
  *
- * Called from scheduler_tick(). We're in the IRQ context and the current
+ * Called from sched_tick(). We're in the IRQ context and the current
  * worker's fields which follow the 'K' locking rule can be accessed safely.
  */
 void wq_worker_tick(struct task_struct *task)
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index 25432b8cd5bd..073a748b9380 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -19,7 +19,7 @@ fail() { # mesg
 
 FILTER=set_ftrace_filter
 FUNC1="schedule"
-FUNC2="scheduler_tick"
+FUNC2="sched_tick"
 
 ALL_FUNCS="#### all functions enabled ####"
 
-- 
2.40.1


