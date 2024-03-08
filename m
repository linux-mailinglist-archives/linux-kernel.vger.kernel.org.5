Return-Path: <linux-kernel+bounces-96913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC9587630D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504A5282BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57635A787;
	Fri,  8 Mar 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNCZHDj0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC256761
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896721; cv=none; b=f+iQCrczfQNT/5QvN6oLY+jYvNG2X73MH8P0dZi5zwoBX2z/I4ZYnhIKJDbwt68QAANYAcewqUU6IAcCFl2NtMiZ/Kae8ZxK4NnIKnOcSEm6ZRSSfG+2SkldUYbxWBqP4giBJ26M/zNIdbGH3273XISP7BtkBu2fBWfMQTgeZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896721; c=relaxed/simple;
	bh=+vVG2QYkF0mp4T5ALGhtl7UkYSxy7vS8aoVqlykA/50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xuq3vjLm4T2R4BiqV+JFF/5m23L+uLr776fi1m5E7zXCmi66ptjV0v9IMUf6gC6syq17LCmmUh3VDhAmSqGJpHG4NvC0ZhIoii8Y6sM9XAmP91sboI/Lu1TBi7V+yCtR7aUfFEYUxhj1b2DevgA5tLWzFP0bAbN6SSF+AJlpGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNCZHDj0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e1878e357so1288499f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896717; x=1710501517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=estP9Tu8p0RmYA73Y3Xz5YQtwlvzKHk4Qvv5GZzWF7s=;
        b=SNCZHDj05/cfAxHM3DXmxs4C4qNRP572GU4BHIXTPCsBjgC6KxUS3ZLi+8N+1KZ/qh
         S7B7Dzr1mz9+FtnOjnw6vstK3sRPHrBbzXej5NvvEOFjg3gLdClo/mIfjQ941ovcoHHU
         iLYV0dzkRAFudn2XIC+GbMeBmepo4X3b4psohFvDHtN0zH2lNv5UwfMR5oNY3hOFgSj+
         oElaej9ty2x37jCpH2qmSjKcsEGlG1vpG1QrHxiB53Zv2jQPmKukJFjvDCudRmF+J9Ex
         GMHMmxlxrzbRSBU439iV0bP+u1vEEK+E9/Q6XD8lZIkbV0MRkzZ4u8sxYNhR5NtG/ZCn
         nFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896717; x=1710501517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=estP9Tu8p0RmYA73Y3Xz5YQtwlvzKHk4Qvv5GZzWF7s=;
        b=tkqi+s/eAATzlSLf0PtYN2dxi0xqrlRJKA7Vcfo+E+YgaDCVHFPwRdhsGpdHwZzJ8T
         0Vu+8eEbR7IbD6HkayBwTGRvMI485cfacbxmAcrcJFzl2N6zlttDfTtBQsWpPm/Bnltm
         U9nirOF4TTzcKK7BzLyPx8+U2ZYur1MEvD4rfPVJkXodJ35YpfnSqPS9A/gkLXucNDu1
         PkFHq0WWIiikhwgXx1RLbGBOSj5CX2m6IFtXikIPzrk3I3GdRJMExL98cr9SOeTCjD1+
         huwv2JQOBWB6cps6uJ/89oysE6+mIVBnduhvRlQB82K0EckeswU6yWwTtnLf0JKfcX2W
         dO1Q==
X-Gm-Message-State: AOJu0YybBWSpByUuq3AgGPtbJB05MEMO1riiyy7S6WnnP+MiHHsAPrUl
	GSIWDWAu5pXwiXHqN4fznHihVflf6OwwlXC12NjEdRy9+1YyDz9P13ppBmUlOgo=
X-Google-Smtp-Source: AGHT+IHDH8xDoNw2OwWwMve0rNWfpnp3DzzP5dVPbV06WxpJPSIdlcShVf1OSxsgKkAlGAYq356RIQ==
X-Received: by 2002:adf:f350:0:b0:33e:592c:d7e5 with SMTP id e16-20020adff350000000b0033e592cd7e5mr5477886wrp.31.1709896716949;
        Fri, 08 Mar 2024 03:18:36 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:36 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 05/13] sched/balancing: Rename load_balance() => sched_balance_rq()
Date: Fri,  8 Mar 2024 12:18:11 +0100
Message-Id: <20240308111819.1101550-6-mingo@kernel.org>
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

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Also load_balance() has become somewhat of a misnomer: historically
it was the first and primary load-balancing function that was called,
but with the introduction of sched domains, it's become a lower
layer function that balances runqueues.

Rename it to sched_balance_rq() accordingly.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/scheduler/sched-domains.rst                    |  4 ++--
 Documentation/scheduler/sched-stats.rst                      | 32 ++++++++++++++++----------------
 Documentation/translations/zh_CN/scheduler/sched-domains.rst |  4 ++--
 Documentation/translations/zh_CN/scheduler/sched-stats.rst   | 30 +++++++++++++++---------------
 include/linux/sched/topology.h                               |  2 +-
 kernel/sched/fair.c                                          | 10 +++++-----
 6 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 5d8e8b8b269e..5e996fe973b1 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -41,11 +41,11 @@ The latter function takes two arguments: the runqueue of current CPU and whether
 the CPU was idle at the time the sched_tick() happened and iterates over all
 sched domains our CPU is on, starting from its base domain and going up the ->parent
 chain. While doing that, it checks to see if the current domain has exhausted its
-rebalance interval. If so, it runs load_balance() on that domain. It then checks
+rebalance interval. If so, it runs sched_balance_rq() on that domain. It then checks
 the parent sched_domain (if it exists), and the parent of the parent and so
 forth.
 
-Initially, load_balance() finds the busiest group in the current sched domain.
+Initially, sched_balance_rq() finds the busiest group in the current sched domain.
 If it succeeds, it looks for the busiest runqueue of all the CPUs' runqueues in
 that group. If it manages to find such a runqueue, it locks both our initial
 CPU's runqueue and the newly found busiest one and starts moving tasks from it
diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 03c062915998..afb39be7d6d2 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -72,53 +72,53 @@ domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
 
 The first field is a bit mask indicating what cpus this domain operates over.
 
-The next 24 are a variety of load_balance() statistics in grouped into types
+The next 24 are a variety of sched_balance_rq() statistics in grouped into types
 of idleness (idle, busy, and newly idle):
 
-    1)  # of times in this domain load_balance() was called when the
+    1)  # of times in this domain sched_balance_rq() was called when the
         cpu was idle
-    2)  # of times in this domain load_balance() checked but found
+    2)  # of times in this domain sched_balance_rq() checked but found
         the load did not require balancing when the cpu was idle
-    3)  # of times in this domain load_balance() tried to move one or
+    3)  # of times in this domain sched_balance_rq() tried to move one or
         more tasks and failed, when the cpu was idle
     4)  sum of imbalances discovered (if any) with each call to
-        load_balance() in this domain when the cpu was idle
+        sched_balance_rq() in this domain when the cpu was idle
     5)  # of times in this domain pull_task() was called when the cpu
         was idle
     6)  # of times in this domain pull_task() was called even though
         the target task was cache-hot when idle
-    7)  # of times in this domain load_balance() was called but did
+    7)  # of times in this domain sched_balance_rq() was called but did
         not find a busier queue while the cpu was idle
     8)  # of times in this domain a busier queue was found while the
         cpu was idle but no busier group was found
-    9)  # of times in this domain load_balance() was called when the
+    9)  # of times in this domain sched_balance_rq() was called when the
         cpu was busy
-    10) # of times in this domain load_balance() checked but found the
+    10) # of times in this domain sched_balance_rq() checked but found the
         load did not require balancing when busy
-    11) # of times in this domain load_balance() tried to move one or
+    11) # of times in this domain sched_balance_rq() tried to move one or
         more tasks and failed, when the cpu was busy
     12) sum of imbalances discovered (if any) with each call to
-        load_balance() in this domain when the cpu was busy
+        sched_balance_rq() in this domain when the cpu was busy
     13) # of times in this domain pull_task() was called when busy
     14) # of times in this domain pull_task() was called even though the
         target task was cache-hot when busy
-    15) # of times in this domain load_balance() was called but did not
+    15) # of times in this domain sched_balance_rq() was called but did not
         find a busier queue while the cpu was busy
     16) # of times in this domain a busier queue was found while the cpu
         was busy but no busier group was found
 
-    17) # of times in this domain load_balance() was called when the
+    17) # of times in this domain sched_balance_rq() was called when the
         cpu was just becoming idle
-    18) # of times in this domain load_balance() checked but found the
+    18) # of times in this domain sched_balance_rq() checked but found the
         load did not require balancing when the cpu was just becoming idle
-    19) # of times in this domain load_balance() tried to move one or more
+    19) # of times in this domain sched_balance_rq() tried to move one or more
         tasks and failed, when the cpu was just becoming idle
     20) sum of imbalances discovered (if any) with each call to
-        load_balance() in this domain when the cpu was just becoming idle
+        sched_balance_rq() in this domain when the cpu was just becoming idle
     21) # of times in this domain pull_task() was called when newly idle
     22) # of times in this domain pull_task() was called even though the
         target task was cache-hot when just becoming idle
-    23) # of times in this domain load_balance() was called but did not
+    23) # of times in this domain sched_balance_rq() was called but did not
         find a busier queue while the cpu was just becoming idle
     24) # of times in this domain a busier queue was found while the cpu
         was just becoming idle but no busier group was found
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
index e6590fd80640..06363169c56b 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -42,9 +42,9 @@ CPU共享。任意两个组的CPU掩码的交集不一定为空，如果是这
 后一个函数有两个入参：当前CPU的运行队列、它在sched_tick()调用时是否空闲。函数会从
 当前CPU所在的基调度域开始迭代执行，并沿着parent指针链向上进入更高层级的调度域。在迭代
 过程中，函数会检查当前调度域是否已经耗尽了再平衡的时间间隔，如果是，它在该调度域运行
-load_balance()。接下来它检查父调度域（如果存在），再后来父调度域的父调度域，以此类推。
+sched_balance_rq()。接下来它检查父调度域（如果存在），再后来父调度域的父调度域，以此类推。
 
-起初，load_balance()查找当前调度域中最繁忙的调度组。如果成功，在该调度组管辖的全部CPU
+起初，sched_balance_rq()查找当前调度域中最繁忙的调度组。如果成功，在该调度组管辖的全部CPU
 的运行队列中找出最繁忙的运行队列。如能找到，对当前的CPU运行队列和新找到的最繁忙运行
 队列均加锁，并把任务从最繁忙队列中迁移到当前CPU上。被迁移的任务数量等于在先前迭代执行
 中计算出的该调度域的调度组的不均衡值。
diff --git a/Documentation/translations/zh_CN/scheduler/sched-stats.rst b/Documentation/translations/zh_CN/scheduler/sched-stats.rst
index c5e0be663837..09eee2517610 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-stats.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-stats.rst
@@ -75,42 +75,42 @@ domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
 繁忙，新空闲）：
 
 
-    1)  当CPU空闲时，load_balance()在这个调度域中被调用了#次
-    2)  当CPU空闲时，load_balance()在这个调度域中被调用，但是发现负载无需
+    1)  当CPU空闲时，sched_balance_rq()在这个调度域中被调用了#次
+    2)  当CPU空闲时，sched_balance_rq()在这个调度域中被调用，但是发现负载无需
         均衡#次
-    3)  当CPU空闲时，load_balance()在这个调度域中被调用，试图迁移1个或更多
+    3)  当CPU空闲时，sched_balance_rq()在这个调度域中被调用，试图迁移1个或更多
         任务且失败了#次
-    4)  当CPU空闲时，load_balance()在这个调度域中被调用，发现不均衡（如果有）
+    4)  当CPU空闲时，sched_balance_rq()在这个调度域中被调用，发现不均衡（如果有）
         #次
     5)  当CPU空闲时，pull_task()在这个调度域中被调用#次
     6)  当CPU空闲时，尽管目标任务是热缓存状态，pull_task()依然被调用#次
-    7)  当CPU空闲时，load_balance()在这个调度域中被调用，未能找到更繁忙的
+    7)  当CPU空闲时，sched_balance_rq()在这个调度域中被调用，未能找到更繁忙的
         队列#次
     8)  当CPU空闲时，在调度域中找到了更繁忙的队列，但未找到更繁忙的调度组
         #次
-    9)  当CPU繁忙时，load_balance()在这个调度域中被调用了#次
-    10) 当CPU繁忙时，load_balance()在这个调度域中被调用，但是发现负载无需
+    9)  当CPU繁忙时，sched_balance_rq()在这个调度域中被调用了#次
+    10) 当CPU繁忙时，sched_balance_rq()在这个调度域中被调用，但是发现负载无需
         均衡#次
-    11) 当CPU繁忙时，load_balance()在这个调度域中被调用，试图迁移1个或更多
+    11) 当CPU繁忙时，sched_balance_rq()在这个调度域中被调用，试图迁移1个或更多
         任务且失败了#次
-    12) 当CPU繁忙时，load_balance()在这个调度域中被调用，发现不均衡（如果有）
+    12) 当CPU繁忙时，sched_balance_rq()在这个调度域中被调用，发现不均衡（如果有）
         #次
     13) 当CPU繁忙时，pull_task()在这个调度域中被调用#次
     14) 当CPU繁忙时，尽管目标任务是热缓存状态，pull_task()依然被调用#次
-    15) 当CPU繁忙时，load_balance()在这个调度域中被调用，未能找到更繁忙的
+    15) 当CPU繁忙时，sched_balance_rq()在这个调度域中被调用，未能找到更繁忙的
         队列#次
     16) 当CPU繁忙时，在调度域中找到了更繁忙的队列，但未找到更繁忙的调度组
         #次
-    17) 当CPU新空闲时，load_balance()在这个调度域中被调用了#次
-    18) 当CPU新空闲时，load_balance()在这个调度域中被调用，但是发现负载无需
+    17) 当CPU新空闲时，sched_balance_rq()在这个调度域中被调用了#次
+    18) 当CPU新空闲时，sched_balance_rq()在这个调度域中被调用，但是发现负载无需
         均衡#次
-    19) 当CPU新空闲时，load_balance()在这个调度域中被调用，试图迁移1个或更多
+    19) 当CPU新空闲时，sched_balance_rq()在这个调度域中被调用，试图迁移1个或更多
         任务且失败了#次
-    20) 当CPU新空闲时，load_balance()在这个调度域中被调用，发现不均衡（如果有）
+    20) 当CPU新空闲时，sched_balance_rq()在这个调度域中被调用，发现不均衡（如果有）
         #次
     21) 当CPU新空闲时，pull_task()在这个调度域中被调用#次
     22) 当CPU新空闲时，尽管目标任务是热缓存状态，pull_task()依然被调用#次
-    23) 当CPU新空闲时，load_balance()在这个调度域中被调用，未能找到更繁忙的
+    23) 当CPU新空闲时，sched_balance_rq()在这个调度域中被调用，未能找到更繁忙的
         队列#次
     24) 当CPU新空闲时，在调度域中找到了更繁忙的队列，但未找到更繁忙的调度组
         #次
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 191b122158fb..f0b721b5d42d 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -110,7 +110,7 @@ struct sched_domain {
 	unsigned long last_decay_max_lb_cost;
 
 #ifdef CONFIG_SCHEDSTATS
-	/* load_balance() stats */
+	/* sched_balance_rq() stats */
 	unsigned int lb_count[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_failed[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_balanced[CPU_MAX_IDLE_TYPES];
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 330788b0c617..0d2753c50be9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6866,7 +6866,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
-/* Working cpumask for: load_balance, load_balance_newidle. */
+/* Working cpumask for: sched_balance_rq, load_balance_newidle. */
 static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
@@ -11242,7 +11242,7 @@ static int should_we_balance(struct lb_env *env)
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
  */
-static int load_balance(int this_cpu, struct rq *this_rq,
+static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 			struct sched_domain *sd, enum cpu_idle_type idle,
 			int *continue_balancing)
 {
@@ -11647,7 +11647,7 @@ static int active_load_balance_cpu_stop(void *data)
 static atomic_t sched_balance_running = ATOMIC_INIT(0);
 
 /*
- * Scale the max load_balance interval with the number of CPUs in the system.
+ * Scale the max sched_balance_rq interval with the number of CPUs in the system.
  * This trades load-balance latency on larger machines for less cross talk.
  */
 void update_max_interval(void)
@@ -11727,7 +11727,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
-			if (load_balance(cpu, rq, sd, idle, &continue_balancing)) {
+			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
 				/*
 				 * The LBF_DST_PINNED logic could have changed
 				 * env->dst_cpu, so we can't know our idle
@@ -12353,7 +12353,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 
-			pulled_task = load_balance(this_cpu, this_rq,
+			pulled_task = sched_balance_rq(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
 						   &continue_balancing);
 
-- 
2.40.1


