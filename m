Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC17C980E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjJOFdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjJOFdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:33:44 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD15D8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:19 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57bca5b9b0aso1849386eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697347999; x=1697952799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXBWZvqTDZ2iX3B2LeXF5RCR0BFpOh2X4c6fSPhJDGw=;
        b=kUDH3INm1CbCRJgXCEOPGmBSP+UYdvozwsoJ3tZcLqwiSPCdfLwCfaRDcHSe8YnDTN
         vvCBiv/IBSC99piUrn+Df5EFw6XZNAzGoZ1NXSQIAixnHA6tT+gDM4wIqnRg22WoJIg2
         SpX5D1fvxPNZEX8BY+TSUQKfoZqv5YfI5neQ6qPwu2YedDl97lRC6diGu7kq0+2xpLqn
         9YsG8ZM7Ozi6MJv2SW0CGUvpm1XPPq9OT/vuF6M9Oj9CwOtjU2MKob8XkhmeT4PQ0Xbt
         69IAJJRYMtnmMtjCy946WpLNvau6iH8xBzNTer8KhuYVQn77HqP1TBVYrrKs2UVR/6U+
         UYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697347999; x=1697952799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXBWZvqTDZ2iX3B2LeXF5RCR0BFpOh2X4c6fSPhJDGw=;
        b=rBs0EHiTxo5BN17QYRckqZe7xubbr5LrDEPoS8DaUWzjJsUtnfo6xOj2WW0rekgBLA
         SNokCoVb3Ak+VrcZ5Mn8PGtw2h1Ymm868i0nu8tYrP+9QnVnxIK09b5KwWsZE2bweW7v
         86/u/ysVkMlqyisZWzGIrj9oONMqtXRQ2Fxcmwu7ftjwhQbtlMZXWuQK3nS0voCuH2Ym
         qe1IczWU95BQHJ9kPeDtn/8HY1gXuC4gW+ZXAZbV1dUHJYodVgoh0p6AXeZ5AKHGZzMr
         Sh/m0+As2DigaSsZTdl9lPfk7vveJB3rz+u1K22fOfWhnrEQllUPBAXxCwJAzHsQ2wkU
         UaGw==
X-Gm-Message-State: AOJu0Ywmrw6eTCaGfREXJB1ihO6ifZNHpghqEG0BeuZvPjU2JAFsMH9e
        /IfKIJCbkQuQAtelrTqVuHDljA==
X-Google-Smtp-Source: AGHT+IG9ktjBjPi/oRmtd/S7FG4W0ZTKCXXhLMx6eDjO1crq4fv/HsZiiT9V2+g6vonZZC3Nf84M/Q==
X-Received: by 2002:a05:6358:6f97:b0:166:a6e3:dfc2 with SMTP id s23-20020a0563586f9700b00166a6e3dfc2mr5440101rwn.9.1697347998957;
        Sat, 14 Oct 2023 22:33:18 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id u22-20020a62ed16000000b00690fe1c928csm16187368pfh.147.2023.10.14.22.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 22:33:18 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v10 2/5] lib: objpool test module added
Date:   Sun, 15 Oct 2023 13:32:48 +0800
Message-Id: <20231015053251.707442-3-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
References: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_objpool module (test_objpool) will run several testcases
for objpool stress and performance evaluation. Each testcase will
have all available cpu cores involved to create a situation of high
parallel and high contention.

As of now there are 5 groups and 5 * 2 testcases in total:

1) group 1: synchronous mode
   objpool is managed synchronously, that is, all objects are to be
   reclaimed before objpool finalization and the objpool owner makes
   sure of it. All threads on different cores run in the same pace
2) group 2: synchronous mode + hrtimer
   this case have 2 customers: normal threads and hrtimer softirqs
3) group 3: synchronous + overrun mode
   This test group is mainly for performance evaluation of missing
   cases when pre-allocated objects are less than the requested
4) group 4: asynchronous mode
   This case is just an emulation of kretprobe, with refcount used
   to control the objpool lifecycle
5) group 5: asynchronous mode with hrtimer
   hrtimer softirq is introduced to stress async objpool operations

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 lib/Kconfig.debug  |  11 +
 lib/Makefile       |   2 +
 lib/test_objpool.c | 689 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 702 insertions(+)
 create mode 100644 lib/test_objpool.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d6798513a8c2..6598604cf6c8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2931,6 +2931,17 @@ config TEST_CLOCKSOURCE_WATCHDOG
 
 	  If unsure, say N.
 
+config TEST_OBJPOOL
+	tristate "Test module for correctness and stress of objpool"
+	default n
+	depends on m && DEBUG_KERNEL
+	help
+	  This builds the "test_objpool" module that should be used for
+	  correctness verification and concurrent testings of objects
+	  allocation and reclamation.
+
+	  If unsure, say N.
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/Makefile b/lib/Makefile
index 7a84c922d9ff..19b936f2af1c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -106,6 +106,8 @@ obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
+
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/test_objpool.c b/lib/test_objpool.c
new file mode 100644
index 000000000000..d329472f8ab6
--- /dev/null
+++ b/lib/test_objpool.c
@@ -0,0 +1,689 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test module for lockless object pool
+ *
+ * Copyright: wuqiang.matt@bytedance.com
+ */
+
+#include <linux/version.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/sched.h>
+#include <linux/cpumask.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+#include <linux/cpu.h>
+#include <linux/cpuset.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
+#include <linux/objpool.h>
+
+#define OT_NR_MAX_BULK (16)
+
+/* memory usage */
+struct ot_mem_stat {
+	atomic_long_t alloc;
+	atomic_long_t free;
+};
+
+/* object allocation results */
+struct ot_obj_stat {
+	unsigned long nhits;
+	unsigned long nmiss;
+};
+
+/* control & results per testcase */
+struct ot_data {
+	struct rw_semaphore start;
+	struct completion wait;
+	struct completion rcu;
+	atomic_t nthreads ____cacheline_aligned_in_smp;
+	atomic_t stop ____cacheline_aligned_in_smp;
+	struct ot_mem_stat kmalloc;
+	struct ot_mem_stat vmalloc;
+	struct ot_obj_stat objects;
+	u64    duration;
+};
+
+/* testcase */
+struct ot_test {
+	int async; /* synchronous or asynchronous */
+	int mode; /* only mode 0 supported */
+	int objsz; /* object size */
+	int duration; /* ms */
+	int delay; /* ms */
+	int bulk_normal;
+	int bulk_irq;
+	unsigned long hrtimer; /* ms */
+	const char *name;
+	struct ot_data data;
+};
+
+/* per-cpu worker */
+struct ot_item {
+	struct objpool_head *pool; /* pool head */
+	struct ot_test *test; /* test parameters */
+
+	void (*worker)(struct ot_item *item, int irq);
+
+	/* hrtimer control */
+	ktime_t hrtcycle;
+	struct hrtimer hrtimer;
+
+	int bulk[2]; /* for thread and irq */
+	int delay;
+	u32 niters;
+
+	/* summary per thread */
+	struct ot_obj_stat stat[2]; /* thread and irq */
+	u64 duration;
+};
+
+/*
+ * memory leakage checking
+ */
+
+static void *ot_kzalloc(struct ot_test *test, long size)
+{
+	void *ptr = kzalloc(size, GFP_KERNEL);
+
+	if (ptr)
+		atomic_long_add(size, &test->data.kmalloc.alloc);
+	return ptr;
+}
+
+static void ot_kfree(struct ot_test *test, void *ptr, long size)
+{
+	if (!ptr)
+		return;
+	atomic_long_add(size, &test->data.kmalloc.free);
+	kfree(ptr);
+}
+
+static void ot_mem_report(struct ot_test *test)
+{
+	long alloc, free;
+
+	pr_info("memory allocation summary for %s\n", test->name);
+
+	alloc = atomic_long_read(&test->data.kmalloc.alloc);
+	free = atomic_long_read(&test->data.kmalloc.free);
+	pr_info("  kmalloc: %lu - %lu = %lu\n", alloc, free, alloc - free);
+
+	alloc = atomic_long_read(&test->data.vmalloc.alloc);
+	free = atomic_long_read(&test->data.vmalloc.free);
+	pr_info("  vmalloc: %lu - %lu = %lu\n", alloc, free, alloc - free);
+}
+
+/* user object instance */
+struct ot_node {
+	void *owner;
+	unsigned long data;
+	unsigned long refs;
+	unsigned long payload[32];
+};
+
+/* user objpool manager */
+struct ot_context {
+	struct objpool_head pool; /* objpool head */
+	struct ot_test *test; /* test parameters */
+	void *ptr; /* user pool buffer */
+	unsigned long size; /* buffer size */
+	struct rcu_head rcu;
+};
+
+static DEFINE_PER_CPU(struct ot_item, ot_pcup_items);
+
+static int ot_init_data(struct ot_data *data)
+{
+	memset(data, 0, sizeof(*data));
+	init_rwsem(&data->start);
+	init_completion(&data->wait);
+	init_completion(&data->rcu);
+	atomic_set(&data->nthreads, 1);
+
+	return 0;
+}
+
+static int ot_init_node(void *nod, void *context)
+{
+	struct ot_context *sop = context;
+	struct ot_node *on = nod;
+
+	on->owner = &sop->pool;
+	return 0;
+}
+
+static enum hrtimer_restart ot_hrtimer_handler(struct hrtimer *hrt)
+{
+	struct ot_item *item = container_of(hrt, struct ot_item, hrtimer);
+	struct ot_test *test = item->test;
+
+	if (atomic_read_acquire(&test->data.stop))
+		return HRTIMER_NORESTART;
+
+	/* do bulk-testings for objects pop/push */
+	item->worker(item, 1);
+
+	hrtimer_forward(hrt, hrt->base->get_time(), item->hrtcycle);
+	return HRTIMER_RESTART;
+}
+
+static void ot_start_hrtimer(struct ot_item *item)
+{
+	if (!item->test->hrtimer)
+		return;
+	hrtimer_start(&item->hrtimer, item->hrtcycle, HRTIMER_MODE_REL);
+}
+
+static void ot_stop_hrtimer(struct ot_item *item)
+{
+	if (!item->test->hrtimer)
+		return;
+	hrtimer_cancel(&item->hrtimer);
+}
+
+static int ot_init_hrtimer(struct ot_item *item, unsigned long hrtimer)
+{
+	struct hrtimer *hrt = &item->hrtimer;
+
+	if (!hrtimer)
+		return -ENOENT;
+
+	item->hrtcycle = ktime_set(0, hrtimer * 1000000UL);
+	hrtimer_init(hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrt->function = ot_hrtimer_handler;
+	return 0;
+}
+
+static int ot_init_cpu_item(struct ot_item *item,
+			struct ot_test *test,
+			struct objpool_head *pool,
+			void (*worker)(struct ot_item *, int))
+{
+	memset(item, 0, sizeof(*item));
+	item->pool = pool;
+	item->test = test;
+	item->worker = worker;
+
+	item->bulk[0] = test->bulk_normal;
+	item->bulk[1] = test->bulk_irq;
+	item->delay = test->delay;
+
+	/* initialize hrtimer */
+	ot_init_hrtimer(item, item->test->hrtimer);
+	return 0;
+}
+
+static int ot_thread_worker(void *arg)
+{
+	struct ot_item *item = arg;
+	struct ot_test *test = item->test;
+	ktime_t start;
+
+	atomic_inc(&test->data.nthreads);
+	down_read(&test->data.start);
+	up_read(&test->data.start);
+	start = ktime_get();
+	ot_start_hrtimer(item);
+	do {
+		if (atomic_read_acquire(&test->data.stop))
+			break;
+		/* do bulk-testings for objects pop/push */
+		item->worker(item, 0);
+	} while (!kthread_should_stop());
+	ot_stop_hrtimer(item);
+	item->duration = (u64) ktime_us_delta(ktime_get(), start);
+	if (atomic_dec_and_test(&test->data.nthreads))
+		complete(&test->data.wait);
+
+	return 0;
+}
+
+static void ot_perf_report(struct ot_test *test, u64 duration)
+{
+	struct ot_obj_stat total, normal = {0}, irq = {0};
+	int cpu, nthreads = 0;
+
+	pr_info("\n");
+	pr_info("Testing summary for %s\n", test->name);
+
+	for_each_possible_cpu(cpu) {
+		struct ot_item *item = per_cpu_ptr(&ot_pcup_items, cpu);
+		if (!item->duration)
+			continue;
+		normal.nhits += item->stat[0].nhits;
+		normal.nmiss += item->stat[0].nmiss;
+		irq.nhits += item->stat[1].nhits;
+		irq.nmiss += item->stat[1].nmiss;
+		pr_info("CPU: %d  duration: %lluus\n", cpu, item->duration);
+		pr_info("\tthread:\t%16lu hits \t%16lu miss\n",
+			item->stat[0].nhits, item->stat[0].nmiss);
+		pr_info("\tirq:   \t%16lu hits \t%16lu miss\n",
+			item->stat[1].nhits, item->stat[1].nmiss);
+		pr_info("\ttotal: \t%16lu hits \t%16lu miss\n",
+			item->stat[0].nhits + item->stat[1].nhits,
+			item->stat[0].nmiss + item->stat[1].nmiss);
+		nthreads++;
+	}
+
+	total.nhits = normal.nhits + irq.nhits;
+	total.nmiss = normal.nmiss + irq.nmiss;
+
+	pr_info("ALL: \tnthreads: %d  duration: %lluus\n", nthreads, duration);
+	pr_info("SUM: \t%16lu hits \t%16lu miss\n",
+		total.nhits, total.nmiss);
+
+	test->data.objects = total;
+	test->data.duration = duration;
+}
+
+/*
+ * synchronous test cases for objpool manipulation
+ */
+
+/* objpool manipulation for synchronous mode (percpu objpool) */
+static struct ot_context *ot_init_sync_m0(struct ot_test *test)
+{
+	struct ot_context *sop = NULL;
+	int max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(test, sizeof(*sop));
+	if (!sop)
+		return NULL;
+	sop->test = test;
+
+	if (objpool_init(&sop->pool, max, test->objsz,
+			GFP_KERNEL, sop, ot_init_node, NULL)) {
+		ot_kfree(test, sop, sizeof(*sop));
+		return NULL;
+	}
+	WARN_ON(max != sop->pool.nr_objs);
+
+	return sop;
+}
+
+static void ot_fini_sync(struct ot_context *sop)
+{
+	objpool_fini(&sop->pool);
+	ot_kfree(sop->test, sop, sizeof(*sop));
+}
+
+struct {
+	struct ot_context * (*init)(struct ot_test *oc);
+	void (*fini)(struct ot_context *sop);
+} g_ot_sync_ops[] = {
+	{.init = ot_init_sync_m0, .fini = ot_fini_sync},
+};
+
+/*
+ * synchronous test cases: performance mode
+ */
+
+static void ot_bulk_sync(struct ot_item *item, int irq)
+{
+	struct ot_node *nods[OT_NR_MAX_BULK];
+	int i;
+
+	for (i = 0; i < item->bulk[irq]; i++)
+		nods[i] = objpool_pop(item->pool);
+
+	if (!irq && (item->delay || !(++(item->niters) & 0x7FFF)))
+		msleep(item->delay);
+
+	while (i-- > 0) {
+		struct ot_node *on = nods[i];
+		if (on) {
+			on->refs++;
+			objpool_push(on, item->pool);
+			item->stat[irq].nhits++;
+		} else {
+			item->stat[irq].nmiss++;
+		}
+	}
+}
+
+static int ot_start_sync(struct ot_test *test)
+{
+	struct ot_context *sop;
+	ktime_t start;
+	u64 duration;
+	unsigned long timeout;
+	int cpu;
+
+	/* initialize objpool for syncrhonous testcase */
+	sop = g_ot_sync_ops[test->mode].init(test);
+	if (!sop)
+		return -ENOMEM;
+
+	/* grab rwsem to block testing threads */
+	down_write(&test->data.start);
+
+	for_each_possible_cpu(cpu) {
+		struct ot_item *item = per_cpu_ptr(&ot_pcup_items, cpu);
+		struct task_struct *work;
+
+		ot_init_cpu_item(item, test, &sop->pool, ot_bulk_sync);
+
+		/* skip offline cpus */
+		if (!cpu_online(cpu))
+			continue;
+
+		work = kthread_create_on_node(ot_thread_worker, item,
+				cpu_to_node(cpu), "ot_worker_%d", cpu);
+		if (IS_ERR(work)) {
+			pr_err("failed to create thread for cpu %d\n", cpu);
+		} else {
+			kthread_bind(work, cpu);
+			wake_up_process(work);
+		}
+	}
+
+	/* wait a while to make sure all threads waiting at start line */
+	msleep(20);
+
+	/* in case no threads were created: memory insufficient ? */
+	if (atomic_dec_and_test(&test->data.nthreads))
+		complete(&test->data.wait);
+
+	// sched_set_fifo_low(current);
+
+	/* start objpool testing threads */
+	start = ktime_get();
+	up_write(&test->data.start);
+
+	/* yeild cpu to worker threads for duration ms */
+	timeout = msecs_to_jiffies(test->duration);
+	schedule_timeout_interruptible(timeout);
+
+	/* tell workers threads to quit */
+	atomic_set_release(&test->data.stop, 1);
+
+	/* wait all workers threads finish and quit */
+	wait_for_completion(&test->data.wait);
+	duration = (u64) ktime_us_delta(ktime_get(), start);
+
+	/* cleanup objpool */
+	g_ot_sync_ops[test->mode].fini(sop);
+
+	/* report testing summary and performance results */
+	ot_perf_report(test, duration);
+
+	/* report memory allocation summary */
+	ot_mem_report(test);
+
+	return 0;
+}
+
+/*
+ * asynchronous test cases: pool lifecycle controlled by refcount
+ */
+
+static void ot_fini_async_rcu(struct rcu_head *rcu)
+{
+	struct ot_context *sop = container_of(rcu, struct ot_context, rcu);
+	struct ot_test *test = sop->test;
+
+	/* here all cpus are aware of the stop event: test->data.stop = 1 */
+	WARN_ON(!atomic_read_acquire(&test->data.stop));
+
+	objpool_fini(&sop->pool);
+	complete(&test->data.rcu);
+}
+
+static void ot_fini_async(struct ot_context *sop)
+{
+	/* make sure the stop event is acknowledged by all cores */
+	call_rcu(&sop->rcu, ot_fini_async_rcu);
+}
+
+static int ot_objpool_release(struct objpool_head *head, void *context)
+{
+	struct ot_context *sop = context;
+
+	WARN_ON(!head || !sop || head != &sop->pool);
+
+	/* do context cleaning if needed */
+	if (sop)
+		ot_kfree(sop->test, sop, sizeof(*sop));
+
+	return 0;
+}
+
+static struct ot_context *ot_init_async_m0(struct ot_test *test)
+{
+	struct ot_context *sop = NULL;
+	int max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(test, sizeof(*sop));
+	if (!sop)
+		return NULL;
+	sop->test = test;
+
+	if (objpool_init(&sop->pool, max, test->objsz, GFP_KERNEL,
+			sop, ot_init_node, ot_objpool_release)) {
+		ot_kfree(test, sop, sizeof(*sop));
+		return NULL;
+	}
+	WARN_ON(max != sop->pool.nr_objs);
+
+	return sop;
+}
+
+struct {
+	struct ot_context * (*init)(struct ot_test *oc);
+	void (*fini)(struct ot_context *sop);
+} g_ot_async_ops[] = {
+	{.init = ot_init_async_m0, .fini = ot_fini_async},
+};
+
+static void ot_nod_recycle(struct ot_node *on, struct objpool_head *pool,
+			int release)
+{
+	struct ot_context *sop;
+
+	on->refs++;
+
+	if (!release) {
+		/* push object back to opjpool for reuse */
+		objpool_push(on, pool);
+		return;
+	}
+
+	sop = container_of(pool, struct ot_context, pool);
+	WARN_ON(sop != pool->context);
+
+	/* unref objpool with nod removed forever */
+	objpool_drop(on, pool);
+}
+
+static void ot_bulk_async(struct ot_item *item, int irq)
+{
+	struct ot_test *test = item->test;
+	struct ot_node *nods[OT_NR_MAX_BULK];
+	int i, stop;
+
+	for (i = 0; i < item->bulk[irq]; i++)
+		nods[i] = objpool_pop(item->pool);
+
+	if (!irq) {
+		if (item->delay || !(++(item->niters) & 0x7FFF))
+			msleep(item->delay);
+		get_cpu();
+	}
+
+	stop = atomic_read_acquire(&test->data.stop);
+
+	/* drop all objects and deref objpool */
+	while (i-- > 0) {
+		struct ot_node *on = nods[i];
+
+		if (on) {
+			on->refs++;
+			ot_nod_recycle(on, item->pool, stop);
+			item->stat[irq].nhits++;
+		} else {
+			item->stat[irq].nmiss++;
+		}
+	}
+
+	if (!irq)
+		put_cpu();
+}
+
+static int ot_start_async(struct ot_test *test)
+{
+	struct ot_context *sop;
+	ktime_t start;
+	u64 duration;
+	unsigned long timeout;
+	int cpu;
+
+	/* initialize objpool for syncrhonous testcase */
+	sop = g_ot_async_ops[test->mode].init(test);
+	if (!sop)
+		return -ENOMEM;
+
+	/* grab rwsem to block testing threads */
+	down_write(&test->data.start);
+
+	for_each_possible_cpu(cpu) {
+		struct ot_item *item = per_cpu_ptr(&ot_pcup_items, cpu);
+		struct task_struct *work;
+
+		ot_init_cpu_item(item, test, &sop->pool, ot_bulk_async);
+
+		/* skip offline cpus */
+		if (!cpu_online(cpu))
+			continue;
+
+		work = kthread_create_on_node(ot_thread_worker, item,
+				cpu_to_node(cpu), "ot_worker_%d", cpu);
+		if (IS_ERR(work)) {
+			pr_err("failed to create thread for cpu %d\n", cpu);
+		} else {
+			kthread_bind(work, cpu);
+			wake_up_process(work);
+		}
+	}
+
+	/* wait a while to make sure all threads waiting at start line */
+	msleep(20);
+
+	/* in case no threads were created: memory insufficient ? */
+	if (atomic_dec_and_test(&test->data.nthreads))
+		complete(&test->data.wait);
+
+	/* start objpool testing threads */
+	start = ktime_get();
+	up_write(&test->data.start);
+
+	/* yeild cpu to worker threads for duration ms */
+	timeout = msecs_to_jiffies(test->duration);
+	schedule_timeout_interruptible(timeout);
+
+	/* tell workers threads to quit */
+	atomic_set_release(&test->data.stop, 1);
+
+	/* do async-finalization */
+	g_ot_async_ops[test->mode].fini(sop);
+
+	/* wait all workers threads finish and quit */
+	wait_for_completion(&test->data.wait);
+	duration = (u64) ktime_us_delta(ktime_get(), start);
+
+	/* assure rcu callback is triggered */
+	wait_for_completion(&test->data.rcu);
+
+	/*
+	 * now we are sure that objpool is finalized either
+	 * by rcu callback or by worker threads
+	 */
+
+	/* report testing summary and performance results */
+	ot_perf_report(test, duration);
+
+	/* report memory allocation summary */
+	ot_mem_report(test);
+
+	return 0;
+}
+
+/*
+ * predefined testing cases:
+ *   synchronous case / overrun case / async case
+ *
+ * async: synchronous or asynchronous testing
+ * mode: only mode 0 supported
+ * duration: int, total test time in ms
+ * delay: int, delay (in ms) between each iteration
+ * bulk_normal: int, repeat times for thread worker
+ * bulk_irq: int, repeat times for irq consumer
+ * hrtimer: unsigned long, hrtimer intervnal in ms
+ * name: char *, tag for current test ot_item
+ */
+
+#define NODE_COMPACT sizeof(struct ot_node)
+#define NODE_VMALLOC (512)
+
+struct ot_test g_testcases[] = {
+
+	/* sync & normal */
+	{0, 0, NODE_COMPACT, 1000, 0,  1,  0,  0, "sync: percpu objpool"},
+	{0, 0, NODE_VMALLOC, 1000, 0,  1,  0,  0, "sync: percpu objpool from vmalloc"},
+
+	/* sync & hrtimer */
+	{0, 0, NODE_COMPACT, 1000, 0,  1,  1,  4, "sync & hrtimer: percpu objpool"},
+	{0, 0, NODE_VMALLOC, 1000, 0,  1,  1,  4, "sync & hrtimer: percpu objpool from vmalloc"},
+
+	/* sync & overrun */
+	{0, 0, NODE_COMPACT, 1000, 0, 16,  0,  0, "sync overrun: percpu objpool"},
+	{0, 0, NODE_VMALLOC, 1000, 0, 16,  0,  0, "sync overrun: percpu objpool from vmalloc"},
+
+	/* async mode */
+	{1, 0, NODE_COMPACT, 1000, 0,  1,  0,  0, "async: percpu objpool"},
+	{1, 0, NODE_VMALLOC, 1000, 0,  1,  0,  0, "async: percpu objpool from vmalloc"},
+
+	/* async + hrtimer mode */
+	{1, 0, NODE_COMPACT, 1000, 0,  4,  4,  4, "async & hrtimer: percpu objpool"},
+	{1, 0, NODE_VMALLOC, 1000, 0,  4,  4,  4, "async & hrtimer: percpu objpool from vmalloc"},
+};
+
+static int __init ot_mod_init(void)
+{
+	int i;
+
+	/* perform testings */
+	for (i = 0; i < ARRAY_SIZE(g_testcases); i++) {
+		ot_init_data(&g_testcases[i].data);
+		if (g_testcases[i].async)
+			ot_start_async(&g_testcases[i]);
+		else
+			ot_start_sync(&g_testcases[i]);
+	}
+
+	/* show tests summary */
+	pr_info("\n");
+	pr_info("Summary of testcases:\n");
+	for (i = 0; i < ARRAY_SIZE(g_testcases); i++) {
+		pr_info("    duration: %lluus \thits: %10lu \tmiss: %10lu \t%s\n",
+			g_testcases[i].data.duration, g_testcases[i].data.objects.nhits,
+			g_testcases[i].data.objects.nmiss, g_testcases[i].name);
+	}
+
+	return -EAGAIN;
+}
+
+static void __exit ot_mod_exit(void)
+{
+}
+
+module_init(ot_mod_init);
+module_exit(ot_mod_exit);
+
+MODULE_LICENSE("GPL");
\ No newline at end of file
-- 
2.40.1

