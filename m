Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7F77E30ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjKFXPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjKFXPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:15:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D37D7E;
        Mon,  6 Nov 2023 15:15:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B801C433CA;
        Mon,  6 Nov 2023 23:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312501;
        bh=VAU7Ot5vghMx/oD4WBS3zx2erFZ1ueGtnBPWK5U85mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/hc2IFKG37Ivv7+NiOLCuZAlmR84vbPHv+yoXziJfnUHKsJlpXK1bmnKhf4Ttrrm
         yDSauJ+5+2fJyeJMjKE5IloThN6xTVYywj6Rxg7t20HXZnJ93Sj9aSkW20cz/JaUjP
         oNaYdwBx9fjQjDD5MmUv/DWffDNUR7Scdhfeo/FEFN4JOPV23ET07kuOYwlc/+GDBu
         xlQ5mK3HE2z3Pvav/2F4FVeIAHcog75yWqrzWmwc5c31vQESxHa2IcThVXD0tYvLcP
         elj3a5nKObR07aitbvkpeBOGySE6wKL+24bhN6Jk8CNi48UQEPyYOvJmQpi9pUNv5w
         I2Z9HmskXxEcw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 12/13] workqueue: Provide one lock class key per work_on_cpu() callsite
Date:   Mon,  6 Nov 2023 18:14:25 -0500
Message-ID: <20231106231435.3734790-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106231435.3734790-1-sashal@kernel.org>
References: <20231106231435.3734790-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 265f3ed077036f053981f5eea0b5b43e7c5b39ff ]

All callers of work_on_cpu() share the same lock class key for all the
functions queued. As a result the workqueue related locking scenario for
a function A may be spuriously accounted as an inversion against the
locking scenario of function B such as in the following model:

	long A(void *arg)
	{
		mutex_lock(&mutex);
		mutex_unlock(&mutex);
	}

	long B(void *arg)
	{
	}

	void launchA(void)
	{
		work_on_cpu(0, A, NULL);
	}

	void launchB(void)
	{
		mutex_lock(&mutex);
		work_on_cpu(1, B, NULL);
		mutex_unlock(&mutex);
	}

launchA and launchB running concurrently have no chance to deadlock.
However the above can be reported by lockdep as a possible locking
inversion because the works containing A() and B() are treated as
belonging to the same locking class.

The following shows an existing example of such a spurious lockdep splat:

	 ======================================================
	 WARNING: possible circular locking dependency detected
	 6.6.0-rc1-00065-g934ebd6e5359 #35409 Not tainted
	 ------------------------------------------------------
	 kworker/0:1/9 is trying to acquire lock:
	 ffffffff9bc72f30 (cpu_hotplug_lock){++++}-{0:0}, at: _cpu_down+0x57/0x2b0

	 but task is already holding lock:
	 ffff9e3bc0057e60 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_scheduled_works+0x216/0x500

	 which lock already depends on the new lock.

	 the existing dependency chain (in reverse order) is:

	 -> #2 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
			__flush_work+0x83/0x4e0
			work_on_cpu+0x97/0xc0
			rcu_nocb_cpu_offload+0x62/0xb0
			rcu_nocb_toggle+0xd0/0x1d0
			kthread+0xe6/0x120
			ret_from_fork+0x2f/0x40
			ret_from_fork_asm+0x1b/0x30

	 -> #1 (rcu_state.barrier_mutex){+.+.}-{3:3}:
			__mutex_lock+0x81/0xc80
			rcu_nocb_cpu_deoffload+0x38/0xb0
			rcu_nocb_toggle+0x144/0x1d0
			kthread+0xe6/0x120
			ret_from_fork+0x2f/0x40
			ret_from_fork_asm+0x1b/0x30

	 -> #0 (cpu_hotplug_lock){++++}-{0:0}:
			__lock_acquire+0x1538/0x2500
			lock_acquire+0xbf/0x2a0
			percpu_down_write+0x31/0x200
			_cpu_down+0x57/0x2b0
			__cpu_down_maps_locked+0x10/0x20
			work_for_cpu_fn+0x15/0x20
			process_scheduled_works+0x2a7/0x500
			worker_thread+0x173/0x330
			kthread+0xe6/0x120
			ret_from_fork+0x2f/0x40
			ret_from_fork_asm+0x1b/0x30

	 other info that might help us debug this:

	 Chain exists of:
	   cpu_hotplug_lock --> rcu_state.barrier_mutex --> (work_completion)(&wfc.work)

	  Possible unsafe locking scenario:

			CPU0                    CPU1
			----                    ----
	   lock((work_completion)(&wfc.work));
									lock(rcu_state.barrier_mutex);
									lock((work_completion)(&wfc.work));
	   lock(cpu_hotplug_lock);

	  *** DEADLOCK ***

	 2 locks held by kworker/0:1/9:
	  #0: ffff900481068b38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x212/0x500
	  #1: ffff9e3bc0057e60 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_scheduled_works+0x216/0x500

	 stack backtrace:
	 CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.6.0-rc1-00065-g934ebd6e5359 #35409
	 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
	 Workqueue: events work_for_cpu_fn
	 Call Trace:
	 rcu-torture: rcu_torture_read_exit: Start of episode
	  <TASK>
	  dump_stack_lvl+0x4a/0x80
	  check_noncircular+0x132/0x150
	  __lock_acquire+0x1538/0x2500
	  lock_acquire+0xbf/0x2a0
	  ? _cpu_down+0x57/0x2b0
	  percpu_down_write+0x31/0x200
	  ? _cpu_down+0x57/0x2b0
	  _cpu_down+0x57/0x2b0
	  __cpu_down_maps_locked+0x10/0x20
	  work_for_cpu_fn+0x15/0x20
	  process_scheduled_works+0x2a7/0x500
	  worker_thread+0x173/0x330
	  ? __pfx_worker_thread+0x10/0x10
	  kthread+0xe6/0x120
	  ? __pfx_kthread+0x10/0x10
	  ret_from_fork+0x2f/0x40
	  ? __pfx_kthread+0x10/0x10
	  ret_from_fork_asm+0x1b/0x30
	  </TASK

Fix this with providing one lock class key per work_on_cpu() caller.

Reported-and-tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/workqueue.h | 46 +++++++++++++++++++++++++++++++++------
 kernel/workqueue.c        | 20 ++++++++++-------
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 1c1d06804d450..24b1e5070f4d4 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -274,18 +274,16 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
  * to generate better code.
  */
 #ifdef CONFIG_LOCKDEP
-#define __INIT_WORK(_work, _func, _onstack)				\
+#define __INIT_WORK_KEY(_work, _func, _onstack, _key)			\
 	do {								\
-		static struct lock_class_key __key;			\
-									\
 		__init_work((_work), _onstack);				\
 		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
-		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, &__key, 0); \
+		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, (_key), 0); \
 		INIT_LIST_HEAD(&(_work)->entry);			\
 		(_work)->func = (_func);				\
 	} while (0)
 #else
-#define __INIT_WORK(_work, _func, _onstack)				\
+#define __INIT_WORK_KEY(_work, _func, _onstack, _key)			\
 	do {								\
 		__init_work((_work), _onstack);				\
 		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
@@ -294,12 +292,22 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 	} while (0)
 #endif
 
+#define __INIT_WORK(_work, _func, _onstack)				\
+	do {								\
+		static __maybe_unused struct lock_class_key __key;	\
+									\
+		__INIT_WORK_KEY(_work, _func, _onstack, &__key);	\
+	} while (0)
+
 #define INIT_WORK(_work, _func)						\
 	__INIT_WORK((_work), (_func), 0)
 
 #define INIT_WORK_ONSTACK(_work, _func)					\
 	__INIT_WORK((_work), (_func), 1)
 
+#define INIT_WORK_ONSTACK_KEY(_work, _func, _key)			\
+	__INIT_WORK_KEY((_work), (_func), 1, _key)
+
 #define __INIT_DELAYED_WORK(_work, _func, _tflags)			\
 	do {								\
 		INIT_WORK(&(_work)->work, (_func));			\
@@ -693,8 +701,32 @@ static inline long work_on_cpu_safe(int cpu, long (*fn)(void *), void *arg)
 	return fn(arg);
 }
 #else
-long work_on_cpu(int cpu, long (*fn)(void *), void *arg);
-long work_on_cpu_safe(int cpu, long (*fn)(void *), void *arg);
+long work_on_cpu_key(int cpu, long (*fn)(void *),
+		     void *arg, struct lock_class_key *key);
+/*
+ * A new key is defined for each caller to make sure the work
+ * associated with the function doesn't share its locking class.
+ */
+#define work_on_cpu(_cpu, _fn, _arg)			\
+({							\
+	static struct lock_class_key __key;		\
+							\
+	work_on_cpu_key(_cpu, _fn, _arg, &__key);	\
+})
+
+long work_on_cpu_safe_key(int cpu, long (*fn)(void *),
+			  void *arg, struct lock_class_key *key);
+
+/*
+ * A new key is defined for each caller to make sure the work
+ * associated with the function doesn't share its locking class.
+ */
+#define work_on_cpu_safe(_cpu, _fn, _arg)		\
+({							\
+	static struct lock_class_key __key;		\
+							\
+	work_on_cpu_safe_key(_cpu, _fn, _arg, &__key);	\
+})
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_FREEZER
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a3522b70218d3..0f682da96e1c5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5622,50 +5622,54 @@ static void work_for_cpu_fn(struct work_struct *work)
 }
 
 /**
- * work_on_cpu - run a function in thread context on a particular cpu
+ * work_on_cpu_key - run a function in thread context on a particular cpu
  * @cpu: the cpu to run on
  * @fn: the function to run
  * @arg: the function arg
+ * @key: The lock class key for lock debugging purposes
  *
  * It is up to the caller to ensure that the cpu doesn't go offline.
  * The caller must not hold any locks which would prevent @fn from completing.
  *
  * Return: The value @fn returns.
  */
-long work_on_cpu(int cpu, long (*fn)(void *), void *arg)
+long work_on_cpu_key(int cpu, long (*fn)(void *),
+		     void *arg, struct lock_class_key *key)
 {
 	struct work_for_cpu wfc = { .fn = fn, .arg = arg };
 
-	INIT_WORK_ONSTACK(&wfc.work, work_for_cpu_fn);
+	INIT_WORK_ONSTACK_KEY(&wfc.work, work_for_cpu_fn, key);
 	schedule_work_on(cpu, &wfc.work);
 	flush_work(&wfc.work);
 	destroy_work_on_stack(&wfc.work);
 	return wfc.ret;
 }
-EXPORT_SYMBOL_GPL(work_on_cpu);
+EXPORT_SYMBOL_GPL(work_on_cpu_key);
 
 /**
- * work_on_cpu_safe - run a function in thread context on a particular cpu
+ * work_on_cpu_safe_key - run a function in thread context on a particular cpu
  * @cpu: the cpu to run on
  * @fn:  the function to run
  * @arg: the function argument
+ * @key: The lock class key for lock debugging purposes
  *
  * Disables CPU hotplug and calls work_on_cpu(). The caller must not hold
  * any locks which would prevent @fn from completing.
  *
  * Return: The value @fn returns.
  */
-long work_on_cpu_safe(int cpu, long (*fn)(void *), void *arg)
+long work_on_cpu_safe_key(int cpu, long (*fn)(void *),
+			  void *arg, struct lock_class_key *key)
 {
 	long ret = -ENODEV;
 
 	cpus_read_lock();
 	if (cpu_online(cpu))
-		ret = work_on_cpu(cpu, fn, arg);
+		ret = work_on_cpu_key(cpu, fn, arg, key);
 	cpus_read_unlock();
 	return ret;
 }
-EXPORT_SYMBOL_GPL(work_on_cpu_safe);
+EXPORT_SYMBOL_GPL(work_on_cpu_safe_key);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_FREEZER
-- 
2.42.0

