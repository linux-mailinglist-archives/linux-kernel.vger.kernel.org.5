Return-Path: <linux-kernel+bounces-44223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4B841F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2654C1C23B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E966B32;
	Tue, 30 Jan 2024 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJqBIx44"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAE59147;
	Tue, 30 Jan 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605993; cv=none; b=uu6niza3lG4b+rNgYajotqwSSNzLTMrIYiDGmjOrnVVyjpRUYPlvv8ZhTVtQH1LXlB3HUMMiiEDaamKXeTA55VLViIumN0pakK6rF1Iplmsqh5LZMcKNflzI/2QsPjGny5z7aSb/JO/iR83iJSxZb12U3vEhhKTnG17cFziF6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605993; c=relaxed/simple;
	bh=n5ovxjgKXxz3xrGD0VSunNYrkA1jLIExmuTHCY+ShpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prZDfVwxrOWyAT2IuVtNy3fTAbe2NdhDxx3eoE+ufoGpw0MXIfNyWrSKJT7T8Tgg9n22oPfIDP43PorKm5kIRs5zxz1yuu+QeKgUZGCQ3uIwqK2E4ZEBjv85ZGQ//7fngqCd3w9IRTubQiNGUFMhr9igOCL/IOiA6Q8hXoANOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJqBIx44; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e13cfc0b2fso287161a34.2;
        Tue, 30 Jan 2024 01:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605990; x=1707210790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkEp/4gcqAupvjqcPMOLAPsX77v4dZL1s/KZMiGw7gs=;
        b=eJqBIx44N74m/+cbTfV00875nB+FF+3wm6fDsEMknobfHma+DiiNO5BxV5ORzk9P37
         hglxjx457y/YHoaWmmaFtFQdF8BX0GVs/TVffwtaoDbETOnDNRXLFZPND8TEcSE7b5I7
         ClvXLccSLV7ZFarj7WDkYmUhR4oRl52juUU0bxKKife3sddK+1RM8NQy8FNag/XmZyxe
         GYx03gG4dQcM7pZPIUOCird08fre051U5NUEFjSAf/d5ifBFA/UZzvvcsZGdqdXE/y7m
         S4lG5Y0wxcCnCtMvHtLgMr++6qC3rUM59H2gJDOgJz+g8Qyn4twyT2hisRnkNZ433Lk4
         SVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605990; x=1707210790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkEp/4gcqAupvjqcPMOLAPsX77v4dZL1s/KZMiGw7gs=;
        b=g8As+CNJX4ncrbslYluYMpraT4zTpsrtVxD6N6qFbPv1wI3mAzg9gHw3e2W0GiV60s
         uEazedTdBaiIpSrlhT9ziuwT5X7UhHm8di6S4cRBCQmpzArmE9OC6J61Dbw3pIBlsHaX
         v6RdzQJqoZIhs5uyabtrxHlyCazpSacar2x2v7M/wrG+wEKWf6qn4Yab4JpBPkbQTxHZ
         ZPMcD0KB8Epwiz8F1XgKXJhVxcD7uDi54QdJnhrwfQUsApp1HWcvLr1d24knAiWu0uT5
         pNddKr15FignTd7ESwWGolE7dq4py7etPJpqlkY8reQUp+9Yljw0Ld/74idKbwlzTxx/
         010w==
X-Gm-Message-State: AOJu0YzPqD3/kArBM4anNfchNUXIxce+MpsIkv9R8nWlWJjHxt3wsXwJ
	vJQOOq29LyJhSzRc5gSDc+W+wxYScgVIWx/VOObeFTcvYqdnQHaT
X-Google-Smtp-Source: AGHT+IHrWgetrGsf9lbp2jXzTeUILDD07wl2dPrXV2uTy/ZOHdR8WtR8Wyo2W+jvuqcLIWjIxMLe2A==
X-Received: by 2002:a05:6359:1008:b0:178:7689:51a2 with SMTP id ib8-20020a056359100800b00178768951a2mr3163171rwb.59.1706605989368;
        Tue, 30 Jan 2024 01:13:09 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id n34-20020a056a000d6200b006dae568baedsm7278213pfv.24.2024.01.30.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:13:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	msnitzer@redhat.com,
	ignat@cloudflare.com,
	damien.lemoal@wdc.com,
	bob.liu@oracle.com,
	houtao1@huawei.com,
	peterz@infradead.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/8] workqueue: Implement BH workqueues to eventually replace tasklets
Date: Mon, 29 Jan 2024 23:11:50 -1000
Message-ID: <20240130091300.2968534-4-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130091300.2968534-1-tj@kernel.org>
References: <20240130091300.2968534-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws such as
the execution code accessing the tasklet item after the execution is
complete which can lead to subtle use-after-free in certain usage scenarios
and less-developed flush and cancel mechanisms.

This patch implements BH workqueues which share the same semantics and
features of regular workqueues but execute their work items in the softirq
context. As there is always only one BH execution context per CPU, none of
the concurrency management mechanisms applies and a BH workqueue can be
thought of as a convenience wrapper around softirq.

Except for the inability to sleep while executing and lack of max_active
adjustments, BH workqueues and work items should behave the same as regular
workqueues and work items.

Currently, the execution is hooked to tasklet[_hi]. However, the goal is to
convert all tasklet users over to BH workqueues. Once the conversion is
complete, tasklet can be removed and BH workqueues can directly take over
the tasklet softirqs.

system_bh[_highpri]_wq are added. As queue-wide flushing doesn't exist in
tasklet, all existing tasklet users should be able to use the system BH
workqueues without creating their own.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: http://lkml.kernel.org/r/CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com
---
 Documentation/core-api/workqueue.rst |  29 +++-
 include/linux/workqueue.h            |   9 ++
 kernel/workqueue.c                   | 231 ++++++++++++++++++++++-----
 kernel/workqueue_internal.h          |   3 +
 tools/workqueue/wq_dump.py           |  11 +-
 5 files changed, 237 insertions(+), 46 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 33c4539155d9..2d6af6c4665c 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -77,10 +77,12 @@ wants a function to be executed asynchronously it has to set up a work
 item pointing to that function and queue that work item on a
 workqueue.
 
-Special purpose threads, called worker threads, execute the functions
-off of the queue, one after the other.  If no work is queued, the
-worker threads become idle.  These worker threads are managed in so
-called worker-pools.
+A work item can be executed in either a thread or the BH (softirq) context.
+
+For threaded workqueues, special purpose threads, called [k]workers, execute
+the functions off of the queue, one after the other. If no work is queued,
+the worker threads become idle. These worker threads are managed in
+worker-pools.
 
 The cmwq design differentiates between the user-facing workqueues that
 subsystems and drivers queue work items on and the backend mechanism
@@ -91,6 +93,12 @@ for high priority ones, for each possible CPU and some extra
 worker-pools to serve work items queued on unbound workqueues - the
 number of these backing pools is dynamic.
 
+BH workqueues use the same framework. However, as there can only be one
+concurrent execution context, there's no need to worry about concurrency.
+Each per-CPU BH worker pool contains only one pseudo worker which represents
+the BH execution context. A BH workqueue can be considered a convenience
+interface to softirq.
+
 Subsystems and drivers can create and queue work items through special
 workqueue API functions as they see fit. They can influence some
 aspects of the way the work items are executed by setting flags on the
@@ -106,7 +114,7 @@ unless specifically overridden, a work item of a bound workqueue will
 be queued on the worklist of either normal or highpri worker-pool that
 is associated to the CPU the issuer is running on.
 
-For any worker pool implementation, managing the concurrency level
+For any thread pool implementation, managing the concurrency level
 (how many execution contexts are active) is an important issue.  cmwq
 tries to keep the concurrency at a minimal but sufficient level.
 Minimal to save resources and sufficient in that the system is used at
@@ -164,6 +172,17 @@ resources, scheduled and executed.
 ``flags``
 ---------
 
+``WQ_BH``
+  BH workqueues can be considered a convenience interface to softirq. BH
+  workqueues are always per-CPU and all BH work items are executed in the
+  queueing CPU's softirq context in the queueing order.
+
+  All BH workqueues must have 0 ``max_active`` and ``WQ_HIGHPRI`` is the
+  only allowed additional flag.
+
+  BH work items cannot sleep. All other features such as delayed queueing,
+  flushing and canceling are supported.
+
 ``WQ_UNBOUND``
   Work items queued to an unbound wq are served by the special
   worker-pools which host workers which are not bound to any
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 232baea90a1d..3ac044691246 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -353,6 +353,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
  * Documentation/core-api/workqueue.rst.
  */
 enum wq_flags {
+	WQ_BH			= 1 << 0, /* execute in bottom half (softirq) context */
 	WQ_UNBOUND		= 1 << 1, /* not bound to any cpu */
 	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
 	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
@@ -392,6 +393,9 @@ enum wq_flags {
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
 	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
+
+	/* BH wq only allows the following flags */
+	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI,
 };
 
 enum wq_consts {
@@ -434,6 +438,9 @@ enum wq_consts {
  * they are same as their non-power-efficient counterparts - e.g.
  * system_power_efficient_wq is identical to system_wq if
  * 'wq_power_efficient' is disabled.  See WQ_POWER_EFFICIENT for more info.
+ *
+ * system_bh[_highpri]_wq are convenience interface to softirq. BH work items
+ * are executed in the queueing CPU's BH context in the queueing order.
  */
 extern struct workqueue_struct *system_wq;
 extern struct workqueue_struct *system_highpri_wq;
@@ -442,6 +449,8 @@ extern struct workqueue_struct *system_unbound_wq;
 extern struct workqueue_struct *system_freezable_wq;
 extern struct workqueue_struct *system_power_efficient_wq;
 extern struct workqueue_struct *system_freezable_power_efficient_wq;
+extern struct workqueue_struct *system_bh_wq;
+extern struct workqueue_struct *system_bh_highpri_wq;
 
 /**
  * alloc_workqueue - allocate a workqueue
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f93554e479c4..9c972db910f6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -72,8 +72,12 @@ enum worker_pool_flags {
 	 * Note that DISASSOCIATED should be flipped only while holding
 	 * wq_pool_attach_mutex to avoid changing binding state while
 	 * worker_attach_to_pool() is in progress.
+	 *
+	 * As there can only be one concurrent BH execution context per CPU, a
+	 * BH pool is per-CPU and always DISASSOCIATED.
 	 */
-	POOL_MANAGER_ACTIVE	= 1 << 0,	/* being managed */
+	POOL_BH			= 1 << 0,	/* is a BH pool */
+	POOL_MANAGER_ACTIVE	= 1 << 1,	/* being managed */
 	POOL_DISASSOCIATED	= 1 << 2,	/* cpu can't serve workers */
 };
 
@@ -115,6 +119,14 @@ enum wq_internal_consts {
 	WQ_NAME_LEN		= 32,
 };
 
+/*
+ * We don't want to trap softirq for too long. See MAX_SOFTIRQ_TIME and
+ * MAX_SOFTIRQ_RESTART in kernel/softirq.c. These are macros because
+ * msecs_to_jiffies() can't be an initializer.
+ */
+#define BH_WORKER_JIFFIES	msecs_to_jiffies(2)
+#define BH_WORKER_RESTARTS	10
+
 /*
  * Structure fields follow one of the following exclusion rules.
  *
@@ -441,8 +453,13 @@ static bool wq_debug_force_rr_cpu = false;
 #endif
 module_param_named(debug_force_rr_cpu, wq_debug_force_rr_cpu, bool, 0644);
 
+/* the BH worker pools */
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
+				     bh_worker_pools);
+
 /* the per-cpu worker pools */
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS], cpu_worker_pools);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
+				     cpu_worker_pools);
 
 static DEFINE_IDR(worker_pool_idr);	/* PR: idr of all pools */
 
@@ -476,8 +493,13 @@ struct workqueue_struct *system_power_efficient_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_power_efficient_wq);
 struct workqueue_struct *system_freezable_power_efficient_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
+struct workqueue_struct *system_bh_wq;
+EXPORT_SYMBOL_GPL(system_bh_wq);
+struct workqueue_struct *system_bh_highpri_wq;
+EXPORT_SYMBOL_GPL(system_bh_highpri_wq);
 
 static int worker_thread(void *__worker);
+static void bh_worker_taskletfn(struct tasklet_struct *tasklet);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 static void show_pwq(struct pool_workqueue *pwq);
 static void show_one_worker_pool(struct worker_pool *pool);
@@ -496,6 +518,11 @@ static void show_one_worker_pool(struct worker_pool *pool);
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU, wq->mutex or wq_pool_mutex should be held")
 
+#define for_each_bh_worker_pool(pool, cpu)				\
+	for ((pool) = &per_cpu(bh_worker_pools, cpu)[0];		\
+	     (pool) < &per_cpu(bh_worker_pools, cpu)[NR_STD_WORKER_POOLS]; \
+	     (pool)++)
+
 #define for_each_cpu_worker_pool(pool, cpu)				\
 	for ((pool) = &per_cpu(cpu_worker_pools, cpu)[0];		\
 	     (pool) < &per_cpu(cpu_worker_pools, cpu)[NR_STD_WORKER_POOLS]; \
@@ -1184,6 +1211,14 @@ static bool kick_pool(struct worker_pool *pool)
 	if (!need_more_worker(pool) || !worker)
 		return false;
 
+	if (pool->flags & POOL_BH) {
+		if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+			tasklet_hi_schedule(&worker->bh_tasklet);
+		else
+			tasklet_schedule(&worker->bh_tasklet);
+		return true;
+	}
+
 	p = worker->task;
 
 #ifdef CONFIG_SMP
@@ -1663,8 +1698,16 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
 	lockdep_assert_held(&pool->lock);
 
 	if (!nna) {
-		/* per-cpu workqueue, pwq->nr_active is sufficient */
-		obtained = pwq->nr_active < READ_ONCE(wq->max_active);
+		/*
+		 * BH workqueues always share a single execution context per CPU
+		 * and don't impose any max_active limit, so tryinc always
+		 * succeeds. For a per-cpu workqueue, checking pwq->nr_active is
+		 * sufficient.
+		 */
+		if (wq->flags & WQ_BH)
+			obtained = true;
+		else
+			obtained = pwq->nr_active < READ_ONCE(wq->max_active);
 		goto out;
 	}
 
@@ -2599,27 +2642,31 @@ static struct worker *create_worker(struct worker_pool *pool)
 
 	worker->id = id;
 
-	if (pool->cpu >= 0)
-		snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
-			 pool->attrs->nice < 0  ? "H" : "");
-	else
-		snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
-
-	worker->task = kthread_create_on_node(worker_thread, worker, pool->node,
-					      "kworker/%s", id_buf);
-	if (IS_ERR(worker->task)) {
-		if (PTR_ERR(worker->task) == -EINTR) {
-			pr_err("workqueue: Interrupted when creating a worker thread \"kworker/%s\"\n",
-			       id_buf);
-		} else {
-			pr_err_once("workqueue: Failed to create a worker thread: %pe",
-				    worker->task);
+	if (pool->flags & POOL_BH) {
+		tasklet_setup(&worker->bh_tasklet, bh_worker_taskletfn);
+	} else {
+		if (pool->cpu >= 0)
+			snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
+				 pool->attrs->nice < 0  ? "H" : "");
+		else
+			snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
+
+		worker->task = kthread_create_on_node(worker_thread, worker,
+					pool->node, "kworker/%s", id_buf);
+		if (IS_ERR(worker->task)) {
+			if (PTR_ERR(worker->task) == -EINTR) {
+				pr_err("workqueue: Interrupted when creating a worker thread \"kworker/%s\"\n",
+				       id_buf);
+			} else {
+				pr_err_once("workqueue: Failed to create a worker thread: %pe",
+					    worker->task);
+			}
+			goto fail;
 		}
-		goto fail;
-	}
 
-	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
+		set_user_nice(worker->task, pool->attrs->nice);
+		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
+	}
 
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
@@ -2635,7 +2682,8 @@ static struct worker *create_worker(struct worker_pool *pool)
 	 * check if not woken up soon. As kick_pool() is noop if @pool is empty,
 	 * wake it up explicitly.
 	 */
-	wake_up_process(worker->task);
+	if (worker->task)
+		wake_up_process(worker->task);
 
 	raw_spin_unlock_irq(&pool->lock);
 
@@ -2977,7 +3025,8 @@ __acquires(&pool->lock)
 	worker->current_work = work;
 	worker->current_func = work->func;
 	worker->current_pwq = pwq;
-	worker->current_at = worker->task->se.sum_exec_runtime;
+	if (worker->task)
+		worker->current_at = worker->task->se.sum_exec_runtime;
 	work_data = *work_data_bits(work);
 	worker->current_color = get_work_color(work_data);
 
@@ -3075,7 +3124,8 @@ __acquires(&pool->lock)
 	 * stop_machine. At the same time, report a quiescent RCU state so
 	 * the same condition doesn't freeze RCU.
 	 */
-	cond_resched();
+	if (worker->task)
+		cond_resched();
 
 	raw_spin_lock_irq(&pool->lock);
 
@@ -3358,6 +3408,43 @@ static int rescuer_thread(void *__rescuer)
 	goto repeat;
 }
 
+void bh_worker_taskletfn(struct tasklet_struct *tasklet)
+{
+	struct worker *worker = container_of(tasklet, struct worker, bh_tasklet);
+	struct worker_pool *pool = worker->pool;
+	int nr_restarts = BH_WORKER_RESTARTS;
+	unsigned long end = jiffies + BH_WORKER_JIFFIES;
+
+	raw_spin_lock_irq(&pool->lock);
+	worker_leave_idle(worker);
+
+	/*
+	 * This function follows the structure of worker_thread(). See there for
+	 * explanations on each step.
+	 */
+	if (!need_more_worker(pool))
+		goto done;
+
+	WARN_ON_ONCE(!list_empty(&worker->scheduled));
+	worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND);
+
+	do {
+		struct work_struct *work =
+			list_first_entry(&pool->worklist,
+					 struct work_struct, entry);
+
+		if (assign_work(work, worker, NULL))
+			process_scheduled_works(worker);
+	} while (keep_working(pool) &&
+		 --nr_restarts && time_before(jiffies, end));
+
+	worker_set_flags(worker, WORKER_PREP);
+done:
+	worker_enter_idle(worker);
+	kick_pool(pool);
+	raw_spin_unlock_irq(&pool->lock);
+}
+
 /**
  * check_flush_dependency - check for flush dependency sanity
  * @target_wq: workqueue being flushed
@@ -3430,6 +3517,7 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 			      struct wq_barrier *barr,
 			      struct work_struct *target, struct worker *worker)
 {
+	static __maybe_unused struct lock_class_key bh_key, thr_key;
 	unsigned int work_flags = 0;
 	unsigned int work_color;
 	struct list_head *head;
@@ -3439,8 +3527,13 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 	 * as we know for sure that this will not trigger any of the
 	 * checks and call back into the fixup functions where we
 	 * might deadlock.
+	 *
+	 * BH and threaded workqueues need separate lockdep keys to avoid
+	 * spuriously triggering "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W}
+	 * usage".
 	 */
-	INIT_WORK_ONSTACK(&barr->work, wq_barrier_func);
+	INIT_WORK_ONSTACK_KEY(&barr->work, wq_barrier_func,
+			      (pwq->wq->flags & WQ_BH) ? &bh_key : &thr_key);
 	__set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&barr->work));
 
 	init_completion_map(&barr->done, &target->lockdep_map);
@@ -3546,15 +3639,31 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 
 static void touch_wq_lockdep_map(struct workqueue_struct *wq)
 {
+#ifdef CONFIG_LOCKDEP
+	if (wq->flags & WQ_BH)
+		local_bh_disable();
+
 	lock_map_acquire(&wq->lockdep_map);
 	lock_map_release(&wq->lockdep_map);
+
+	if (wq->flags & WQ_BH)
+		local_bh_enable();
+#endif
 }
 
 static void touch_work_lockdep_map(struct work_struct *work,
 				   struct workqueue_struct *wq)
 {
+#ifdef CONFIG_LOCKDEP
+	if (wq->flags & WQ_BH)
+		local_bh_disable();
+
 	lock_map_acquire(&work->lockdep_map);
 	lock_map_release(&work->lockdep_map);
+
+	if (wq->flags & WQ_BH)
+		local_bh_enable();
+#endif
 }
 
 /**
@@ -5007,10 +5116,17 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 
 	if (!(wq->flags & WQ_UNBOUND)) {
 		for_each_possible_cpu(cpu) {
-			struct pool_workqueue **pwq_p =
-				per_cpu_ptr(wq->cpu_pwq, cpu);
-			struct worker_pool *pool =
-				&(per_cpu_ptr(cpu_worker_pools, cpu)[highpri]);
+			struct pool_workqueue **pwq_p;
+			struct worker_pool __percpu *pools;
+			struct worker_pool *pool;
+
+			if (wq->flags & WQ_BH)
+				pools = bh_worker_pools;
+			else
+				pools = cpu_worker_pools;
+
+			pool = &(per_cpu_ptr(pools, cpu)[highpri]);
+			pwq_p = per_cpu_ptr(wq->cpu_pwq, cpu);
 
 			*pwq_p = kmem_cache_alloc_node(pwq_cache, GFP_KERNEL,
 						       pool->node);
@@ -5185,6 +5301,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	size_t wq_size;
 	int name_len;
 
+	if (flags & WQ_BH) {
+		if (WARN_ON_ONCE(flags & ~__WQ_BH_ALLOWS))
+			return NULL;
+		if (WARN_ON_ONCE(max_active))
+			return NULL;
+	}
+
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
 	 * the case on many machines due to per-pod pools. While
@@ -5404,6 +5527,9 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
  */
 void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 {
+	/* max_active doesn't mean anything for BH workqueues */
+	if (WARN_ON(wq->flags & WQ_BH))
+		return;
 	/* disallow meddling with max_active for ordered workqueues */
 	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
 		return;
@@ -5605,7 +5731,12 @@ static void pr_cont_pool_info(struct worker_pool *pool)
 	pr_cont(" cpus=%*pbl", nr_cpumask_bits, pool->attrs->cpumask);
 	if (pool->node != NUMA_NO_NODE)
 		pr_cont(" node=%d", pool->node);
-	pr_cont(" flags=0x%x nice=%d", pool->flags, pool->attrs->nice);
+	pr_cont(" flags=0x%x", pool->flags);
+	if (pool->flags & POOL_BH)
+		pr_cont(" bh%s",
+			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+	else
+		pr_cont(" nice=%d", pool->attrs->nice);
 }
 
 struct pr_cont_work_struct {
@@ -6078,13 +6209,15 @@ int workqueue_online_cpu(unsigned int cpu)
 	mutex_lock(&wq_pool_mutex);
 
 	for_each_pool(pool, pi) {
-		mutex_lock(&wq_pool_attach_mutex);
+		/* BH pools aren't affected by hotplug */
+		if (pool->flags & POOL_BH)
+			continue;
 
+		mutex_lock(&wq_pool_attach_mutex);
 		if (pool->cpu == cpu)
 			rebind_workers(pool);
 		else if (pool->cpu < 0)
 			restore_unbound_workers_cpumask(pool, cpu);
-
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
 
@@ -7206,10 +7339,16 @@ void __init workqueue_init_early(void)
 	pt->pod_node[0] = NUMA_NO_NODE;
 	pt->cpu_pod[0] = 0;
 
-	/* initialize CPU pools */
+	/* initialize BH and CPU pools */
 	for_each_possible_cpu(cpu) {
 		struct worker_pool *pool;
 
+		i = 0;
+		for_each_bh_worker_pool(pool, cpu) {
+			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
+			pool->flags |= POOL_BH;
+		}
+
 		i = 0;
 		for_each_cpu_worker_pool(pool, cpu)
 			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
@@ -7245,10 +7384,14 @@ void __init workqueue_init_early(void)
 	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
 					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
 					      0);
+	system_bh_wq = alloc_workqueue("events_bh", WQ_BH, 0);
+	system_bh_highpri_wq = alloc_workqueue("events_bh_highpri",
+					       WQ_BH | WQ_HIGHPRI, 0);
 	BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
 	       !system_unbound_wq || !system_freezable_wq ||
 	       !system_power_efficient_wq ||
-	       !system_freezable_power_efficient_wq);
+	       !system_freezable_power_efficient_wq ||
+	       !system_bh_wq || !system_bh_highpri_wq);
 }
 
 static void __init wq_cpu_intensive_thresh_init(void)
@@ -7314,9 +7457,10 @@ void __init workqueue_init(void)
 	 * up. Also, create a rescuer for workqueues that requested it.
 	 */
 	for_each_possible_cpu(cpu) {
-		for_each_cpu_worker_pool(pool, cpu) {
+		for_each_bh_worker_pool(pool, cpu)
+			pool->node = cpu_to_node(cpu);
+		for_each_cpu_worker_pool(pool, cpu)
 			pool->node = cpu_to_node(cpu);
-		}
 	}
 
 	list_for_each_entry(wq, &workqueues, list) {
@@ -7327,7 +7471,16 @@ void __init workqueue_init(void)
 
 	mutex_unlock(&wq_pool_mutex);
 
-	/* create the initial workers */
+	/*
+	 * Create the initial workers. A BH pool has one pseudo worker that
+	 * represents the shared BH execution context and thus doesn't get
+	 * affected by hotplug events. Create the BH pseudo workers for all
+	 * possible CPUs here.
+	 */
+	for_each_possible_cpu(cpu)
+		for_each_bh_worker_pool(pool, cpu)
+			BUG_ON(!create_worker(pool));
+
 	for_each_online_cpu(cpu) {
 		for_each_cpu_worker_pool(pool, cpu) {
 			pool->flags &= ~POOL_DISASSOCIATED;
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index f6275944ada7..8da306b76ec9 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -10,6 +10,7 @@
 
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
+#include <linux/interrupt.h>
 #include <linux/preempt.h>
 
 struct worker_pool;
@@ -42,6 +43,8 @@ struct worker {
 	struct list_head	scheduled;	/* L: scheduled works */
 
 	struct task_struct	*task;		/* I: worker task */
+	struct tasklet_struct	bh_tasklet;	/* I: tasklet for bh pool */
+
 	struct worker_pool	*pool;		/* A: the associated pool */
 						/* L: for rescuers */
 	struct list_head	node;		/* A: anchored at pool->workers */
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index bd381511bd9a..d29b918306b4 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -79,7 +79,9 @@ args = parser.parse_args()
 wq_type_len = 9
 
 def wq_type_str(wq):
-    if wq.flags & WQ_UNBOUND:
+    if wq.flags & WQ_BH:
+        return f'{"bh":{wq_type_len}}'
+    elif wq.flags & WQ_UNBOUND:
         if wq.flags & WQ_ORDERED:
             return f'{"ordered":{wq_type_len}}'
         else:
@@ -97,6 +99,7 @@ wq_pod_types            = prog['wq_pod_types']
 wq_affn_dfl             = prog['wq_affn_dfl']
 wq_affn_names           = prog['wq_affn_names']
 
+WQ_BH                   = prog['WQ_BH']
 WQ_UNBOUND              = prog['WQ_UNBOUND']
 WQ_ORDERED              = prog['__WQ_ORDERED']
 WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
@@ -107,6 +110,8 @@ WQ_AFFN_CACHE           = prog['WQ_AFFN_CACHE']
 WQ_AFFN_NUMA            = prog['WQ_AFFN_NUMA']
 WQ_AFFN_SYSTEM          = prog['WQ_AFFN_SYSTEM']
 
+POOL_BH                 = prog['POOL_BH']
+
 WQ_NAME_LEN             = prog['WQ_NAME_LEN'].value_()
 cpumask_str_len         = len(cpumask_str(wq_unbound_cpumask))
 
@@ -151,10 +156,12 @@ max_ref_len = 0
 
 for pi, pool in idr_for_each(worker_pool_idr):
     pool = drgn.Object(prog, 'struct worker_pool', address=pool)
-    print(f'pool[{pi:0{max_pool_id_len}}] ref={pool.refcnt.value_():{max_ref_len}} nice={pool.attrs.nice.value_():3} ', end='')
+    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} nice={pool.attrs.nice.value_():3} ', end='')
     print(f'idle/workers={pool.nr_idle.value_():3}/{pool.nr_workers.value_():3} ', end='')
     if pool.cpu >= 0:
         print(f'cpu={pool.cpu.value_():3}', end='')
+        if pool.flags & POOL_BH:
+            print(' bh', end='')
     else:
         print(f'cpus={cpumask_str(pool.attrs.cpumask)}', end='')
         print(f' pod_cpus={cpumask_str(pool.attrs.__pod_cpumask)}', end='')
-- 
2.43.0


