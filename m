Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC37924EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjIEQAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245183AbjIEBxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:53:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811FDCC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:53:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68c3b9f8333so1234303b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 18:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693878792; x=1694483592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YvzxtbZYYtrobQEwlRq7CmmbQu5a+B1kL+sfGeS7P4=;
        b=gmWa3UEOhyOMaI90Spfon8qGOqskIJUkpomG5wauVpZNF6xDCFjIpmrYMcMD/W5CaE
         H8dkN0/3lK0sEBDMKXFrrhFoz99wfduj34djp5Z42KIjggcRbPBJ4jvK3RDV5i1ZQqD0
         JzihssBz2D0J4vWbZ68wr82RejOUOMZ6kIVm34ktV0xdfdTgN8R5BxJMMc+NQVjdT2cK
         FTtzO8Z+elAOvTtBSvLIORdBEaxTGiHsjIISfpOC/OhtQwPkdJOHwaqEeFZkoyPFEq6Z
         fP6M/dl48Ux3x1QUu5bm/6jklyn/W74ZfnprFFd56qGE5pgmaBBC2EeLm3IkjHdgUCwF
         sFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693878792; x=1694483592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YvzxtbZYYtrobQEwlRq7CmmbQu5a+B1kL+sfGeS7P4=;
        b=Peph15h4oCEvE9KuUDqxzdlIkeo+B4/uitmKBa0/QCsrKHNKvmFEBD19tew8m885RS
         nE56rsAh903wGUFQVTIbcFJM1fLUyjdUaC9ca1IVeOAzU/ajawmBe0HPXTIlONYmbpWa
         98I2ROCkIPYLEIdczOUGMz5D1NgeaIiRzWdJ9TJUOUHd+mT/ORgTk3zOke+UkN5xoYe4
         OWYNKMvRppPYVTvKc2vslqT/zanzNJZneC2phLkd8+9FpJ4K8UkYXqMapnH4vNOymZTv
         fwgU7s2XPOepxWeRJ8BmyDEZZT097H6ztOGc+Sqgjdd39nX2FyLIORBHrdo1/w93saNP
         lXlw==
X-Gm-Message-State: AOJu0YzV8jTouVbZ0ydASrFUvL91hfevqbcknS/2Nnk3Mdq9FdK97UXP
        pVB0k3qAfEGqoDc3Qh3TUu7XeQ==
X-Google-Smtp-Source: AGHT+IFO/SI8L+EmSrs6NhBEnXhh4vr64h+J4COJQseZvdLdxHmiw4YLFhRvId/z0kGEP9DWO5t2Iw==
X-Received: by 2002:a05:6a00:1c83:b0:68a:6e26:a918 with SMTP id y3-20020a056a001c8300b0068a6e26a918mr15257585pfw.8.1693878791880;
        Mon, 04 Sep 2023 18:53:11 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0064d74808738sm7910483pfm.214.2023.09.04.18.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 18:53:11 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v9 1/5] lib: objpool added: ring-array based lockless MPMC
Date:   Tue,  5 Sep 2023 09:52:51 +0800
Message-Id: <20230905015255.81545-2-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The object pool is a scalable implementaion of high performance queue
for object allocation and reclamation, such as kretprobe instances.

With leveraging percpu ring-array to mitigate the hot spot of memory
contention, it could deliver near-linear scalability for high parallel
scenarios. The objpool is best suited for following cases:
1) Memory allocation or reclamation are prohibited or too expensive
2) Consumers are of different priorities, such as irqs and threads

Limitations:
1) Maximum objects (capacity) is determined during pool initializing
   and can't be modified (extended) after objpool creation
2) The memory of objects won't be freed until objpool is finalized
3) Object allocation (pop) may fail after trying all cpu slots

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 include/linux/objpool.h | 174 +++++++++++++++++++++
 lib/Makefile            |   2 +-
 lib/objpool.c           | 338 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 513 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c

diff --git a/include/linux/objpool.h b/include/linux/objpool.h
new file mode 100644
index 000000000000..33c832216b98
--- /dev/null
+++ b/include/linux/objpool.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_OBJPOOL_H
+#define _LINUX_OBJPOOL_H
+
+#include <linux/types.h>
+#include <linux/refcount.h>
+
+/*
+ * objpool: ring-array based lockless MPMC queue
+ *
+ * Copyright: wuqiang.matt@bytedance.com
+ *
+ * The object pool is a scalable implementaion of high performance queue
+ * for objects allocation and reclamation, such as kretprobe instances.
+ *
+ * With leveraging per-cpu ring-array to mitigate the hot spots of memory
+ * contention, it could deliver near-linear scalability for high parallel
+ * scenarios. The ring-array is compactly managed in a single cache-line
+ * to benefit from warmed L1 cache for most cases (<= 4 objects per-core).
+ * The body of pre-allocated objects is stored in continuous cache-lines
+ * just after the ring-array.
+ *
+ * The object pool is interrupt safe. Both allocation and reclamation
+ * (object pop and push operations) can be preemptible or interruptable.
+ *
+ * It's best suited for following cases:
+ * 1) Memory allocation or reclamation are prohibited or too expensive
+ * 2) Consumers are of different priorities, such as irqs and threads
+ *
+ * Limitations:
+ * 1) Maximum objects (capacity) is determined during pool initializing
+ * 2) The memory of objects won't be freed until the pool is finalized
+ * 3) Object allocation (pop) may fail after trying all cpu slots
+ */
+
+/**
+ * struct objpool_slot - percpu ring array of objpool
+ * @head: head of the local ring array (to retrieve at)
+ * @tail: tail of the local ring array (to append at)
+ * @bits: log2 of capacity (for bitwise operations)
+ * @mask: capacity - 1
+ *
+ * Represents a cpu-local array-based ring buffer, its size is specialized
+ * during initialization of object pool. The percpu objpool slot is to be
+ * allocated from local memory for NUMA system, and to be kept compact in
+ * continuous memory: ages[] is stored just after the body of objpool_slot,
+ * and then entries[]. ages[] describes revision of each item, solely used
+ * to avoid ABA; entries[] contains pointers of the actual objects
+ *
+ * Layout of objpool_slot in memory:
+ *
+ * 64bit:
+ *        4      8      12     16        32                 64
+ * | head | tail | bits | mask | ages[4] | ents[4]: (8 * 4) | objects
+ *
+ * 32bit:
+ *        4      8      12     16        32        48       64
+ * | head | tail | bits | mask | ages[4] | ents[4] | unused | objects
+ *
+ */
+struct objpool_slot {
+	uint32_t                head;
+	uint32_t                tail;
+	uint32_t                bits;
+	uint32_t                mask;
+} __packed;
+
+struct objpool_head;
+
+/*
+ * caller-specified callback for object initial setup, it's only called
+ * once for each object (just after the memory allocation of the object)
+ */
+typedef int (*objpool_init_obj_cb)(void *obj, void *context);
+
+/* caller-specified cleanup callback for objpool destruction */
+typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
+
+/**
+ * struct objpool_head - object pooling metadata
+ * @obj_size:   object & element size
+ * @nr_objs:    total objs (to be pre-allocated)
+ * @nr_cpus:    nr_cpu_ids
+ * @capacity:   max objects per cpuslot
+ * @gfp:        gfp flags for kmalloc & vmalloc
+ * @ref:        refcount for objpool
+ * @flags:      flags for objpool management
+ * @cpu_slots:  array of percpu slots
+ * @slot_sizes:	size in bytes of slots
+ * @release:    resource cleanup callback
+ * @context:    caller-provided context
+ */
+struct objpool_head {
+	int                     obj_size;
+	int                     nr_objs;
+	int                     nr_cpus;
+	int                     capacity;
+	gfp_t                   gfp;
+	refcount_t              ref;
+	unsigned long           flags;
+	struct objpool_slot   **cpu_slots;
+	int                    *slot_sizes;
+	objpool_fini_cb         release;
+	void                   *context;
+};
+
+#define OBJPOOL_FROM_VMALLOC	(0x800000000)	/* objpool allocated from vmalloc area */
+#define OBJPOOL_HAVE_OBJECTS	(0x400000000)	/* objects allocated along with objpool */
+
+/**
+ * objpool_init() - initialize objpool and pre-allocated objects
+ * @head:    the object pool to be initialized, declared by caller
+ * @nr_objs: total objects to be pre-allocated by this object pool
+ * @object_size: size of an object (should be > 0)
+ * @gfp:     flags for memory allocation (via kmalloc or vmalloc)
+ * @context: user context for object initialization callback
+ * @objinit: object initialization callback for extra setup
+ * @release: cleanup callback for extra cleanup task
+ *
+ * return value: 0 for success, otherwise error code
+ *
+ * All pre-allocated objects are to be zeroed after memory allocation.
+ * Caller could do extra initialization in objinit callback. objinit()
+ * will be called just after slot allocation and will be only once for
+ * each object. Since then the objpool won't touch any content of the
+ * objects. It's caller's duty to perform reinitialization after each
+ * pop (object allocation) or do clearance before each push (object
+ * reclamation).
+ */
+int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
+		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
+		 objpool_fini_cb release);
+
+/**
+ * objpool_pop() - allocate an object from objpool
+ * @head: object pool
+ *
+ * return value: object ptr or NULL if failed
+ */
+void *objpool_pop(struct objpool_head *head);
+
+/**
+ * objpool_push() - reclaim the object and return back to objpool
+ * @obj:  object ptr to be pushed to objpool
+ * @head: object pool
+ *
+ * return: 0 or error code (it fails only when user tries to push
+ * the same object multiple times or wrong "objects" into objpool)
+ */
+int objpool_push(void *obj, struct objpool_head *head);
+
+/**
+ * objpool_drop() - discard the object and deref objpool
+ * @obj:  object ptr to be discarded
+ * @head: object pool
+ *
+ * return: 0 if objpool was released or error code
+ */
+int objpool_drop(void *obj, struct objpool_head *head);
+
+/**
+ * objpool_free() - release objpool forcely (all objects to be freed)
+ * @head: object pool to be released
+ */
+void objpool_free(struct objpool_head *head);
+
+/**
+ * objpool_fini() - deref object pool (also releasing unused objects)
+ * @head: object pool to be dereferenced
+ */
+void objpool_fini(struct objpool_head *head);
+
+#endif /* _LINUX_OBJPOOL_H */
diff --git a/lib/Makefile b/lib/Makefile
index 1ffae65bb7ee..7a84c922d9ff 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o
+	 buildid.o objpool.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/objpool.c b/lib/objpool.c
new file mode 100644
index 000000000000..22e752371820
--- /dev/null
+++ b/lib/objpool.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/objpool.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+#include <linux/prefetch.h>
+#include <linux/irqflags.h>
+#include <linux/cpumask.h>
+#include <linux/log2.h>
+
+/*
+ * objpool: ring-array based lockless MPMC/FIFO queues
+ *
+ * Copyright: wuqiang.matt@bytedance.com
+ */
+
+#define SLOT_AGES(s) ((uint32_t *)((char *)(s) + sizeof(struct objpool_slot)))
+#define SLOT_ENTS(s) ((void **)((char *)(s) + sizeof(struct objpool_slot) + \
+			(sizeof(uint32_t) << (s)->bits)))
+#define SLOT_OBJS(s) ((void *)((char *)(s) + sizeof(struct objpool_slot) + \
+			((sizeof(uint32_t) + sizeof(void *)) << (s)->bits)))
+#define SLOT_CORE(n) cpumask_nth((n) % num_possible_cpus(), cpu_possible_mask)
+
+/* compute the suitable num of objects to be managed per slot */
+static int objpool_nobjs(int size)
+{
+	return rounddown_pow_of_two((size - sizeof(struct objpool_slot)) /
+			(sizeof(uint32_t) + sizeof(void *)));
+}
+
+/* allocate and initialize percpu slots */
+static int
+objpool_init_percpu_slots(struct objpool_head *head, int nobjs,
+			void *context, objpool_init_obj_cb objinit)
+{
+	int i, j, n, size, objsz, cpu = 0, nents = head->capacity;
+
+	/* aligned object size by sizeof(void *) */
+	objsz = ALIGN(head->obj_size, sizeof(void *));
+	/* shall we allocate objects along with percpu-slot */
+	if (objsz)
+		head->flags |= OBJPOOL_HAVE_OBJECTS;
+
+	/* vmalloc is used in default to allocate percpu-slots */
+	if (!(head->gfp & GFP_ATOMIC))
+		head->flags |= OBJPOOL_FROM_VMALLOC;
+
+	for (i = 0; i < head->nr_cpus; i++) {
+		struct objpool_slot *os;
+
+		/* skip the cpus which could never be present */
+		if (!cpu_possible(i))
+			continue;
+
+		/* compute how many objects to be managed by this slot */
+		n = nobjs / num_possible_cpus();
+		if (cpu < (nobjs % num_possible_cpus()))
+			n++;
+		size = sizeof(struct objpool_slot) + sizeof(void *) * nents +
+		       sizeof(uint32_t) * nents + objsz * n;
+
+		/*
+		 * here we allocate percpu-slot & objects together in a single
+		 * allocation, taking advantage of warm caches and TLB hits as
+		 * vmalloc always aligns the request size to pages
+		 */
+		if (head->flags & OBJPOOL_FROM_VMALLOC)
+			os = __vmalloc_node(size, sizeof(void *), head->gfp,
+				cpu_to_node(i), __builtin_return_address(0));
+		else
+			os = kmalloc_node(size, head->gfp, cpu_to_node(i));
+		if (!os)
+			return -ENOMEM;
+
+		/* initialize percpu slot for the i-th slot */
+		memset(os, 0, size);
+		os->bits = ilog2(head->capacity);
+		os->mask = head->capacity - 1;
+		head->cpu_slots[i] = os;
+		head->slot_sizes[i] = size;
+		cpu = cpu + 1;
+
+		/*
+		 * manually set head & tail to avoid possible conflict:
+		 * We assume that the head item is ready for retrieval
+		 * iff head is equal to ages[head & mask]. but ages is
+		 * initialized as 0, so in view of the caller of pop(),
+		 * the 1st item (0th) is always ready, but the reality
+		 * could be: push() is stalled before the final update,
+		 * thus the item being inserted will be lost forever
+		 */
+		os->head = os->tail = head->capacity;
+
+		if (!objsz)
+			continue;
+
+		for (j = 0; j < n; j++) {
+			uint32_t *ages = SLOT_AGES(os);
+			void **ents = SLOT_ENTS(os);
+			void *obj = SLOT_OBJS(os) + j * objsz;
+			uint32_t ie = os->tail & os->mask;
+
+			/* perform object initialization */
+			if (objinit) {
+				int rc = objinit(obj, context);
+				if (rc)
+					return rc;
+			}
+
+			/* add obj into the ring array */
+			ents[ie] = obj;
+			ages[ie] = os->tail;
+			os->tail++;
+			head->nr_objs++;
+		}
+	}
+
+	return 0;
+}
+
+/* cleanup all percpu slots of the object pool */
+static void objpool_fini_percpu_slots(struct objpool_head *head)
+{
+	int i;
+
+	if (!head->cpu_slots)
+		return;
+
+	for (i = 0; i < head->nr_cpus; i++) {
+		if (!head->cpu_slots[i])
+			continue;
+		if (head->flags & OBJPOOL_FROM_VMALLOC)
+			vfree(head->cpu_slots[i]);
+		else
+			kfree(head->cpu_slots[i]);
+	}
+	kfree(head->cpu_slots);
+	head->cpu_slots = NULL;
+	head->slot_sizes = NULL;
+}
+
+/* initialize object pool and pre-allocate objects */
+int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
+		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
+		objpool_fini_cb release)
+{
+	int nents, rc;
+
+	/* check input parameters */
+	if (nr_objs <= 0 || object_size <= 0)
+		return -EINVAL;
+
+	/* calculate percpu slot size (rounded to pow of 2) */
+	nents = max_t(int, roundup_pow_of_two(nr_objs),
+			objpool_nobjs(L1_CACHE_BYTES));
+
+	/* initialize objpool head */
+	memset(head, 0, sizeof(struct objpool_head));
+	head->nr_cpus = nr_cpu_ids;
+	head->obj_size = object_size;
+	head->capacity = nents;
+	head->gfp = gfp & ~__GFP_ZERO;
+	head->context = context;
+	head->release = release;
+
+	/* allocate array for percpu slots */
+	head->cpu_slots = kzalloc(head->nr_cpus * sizeof(void *) +
+			       head->nr_cpus * sizeof(int), head->gfp);
+	if (!head->cpu_slots)
+		return -ENOMEM;
+	head->slot_sizes = (int *)&head->cpu_slots[head->nr_cpus];
+
+	/* initialize per-cpu slots */
+	rc = objpool_init_percpu_slots(head, nr_objs, context, objinit);
+	if (rc)
+		objpool_fini_percpu_slots(head);
+	else
+		refcount_set(&head->ref, nr_objs + 1);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(objpool_init);
+
+/* adding object to slot, abort if the slot was already full */
+static inline int objpool_try_add_slot(void *obj, struct objpool_slot *os)
+{
+	uint32_t *ages = SLOT_AGES(os);
+	void **ents = SLOT_ENTS(os);
+	uint32_t head, tail;
+
+	do {
+		/* perform memory loading for both head and tail */
+		head = READ_ONCE(os->head);
+		tail = READ_ONCE(os->tail);
+		/* just abort if slot is full */
+		if (tail - head > os->mask)
+			return -ENOENT;
+		/* try to extend tail by 1 using CAS to avoid races */
+		if (try_cmpxchg_acquire(&os->tail, &tail, tail + 1))
+			break;
+	} while (1);
+
+	/* the tail-th of slot is reserved for the given obj */
+	WRITE_ONCE(ents[tail & os->mask], obj);
+	/* update epoch id to make this object available for pop() */
+	smp_store_release(&ages[tail & os->mask], tail);
+	return 0;
+}
+
+/* reclaim an object to object pool */
+int objpool_push(void *obj, struct objpool_head *oh)
+{
+	unsigned long flags;
+	int cpu, rc;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
+	cpu = raw_smp_processor_id();
+	do {
+		rc = objpool_try_add_slot(obj, oh->cpu_slots[cpu]);
+		if (!rc)
+			break;
+		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
+	} while (1);
+	raw_local_irq_restore(flags);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(objpool_push);
+
+/* drop the allocated object, rather reclaim it to objpool */
+int objpool_drop(void *obj, struct objpool_head *head)
+{
+	if (!obj || !head)
+		return -EINVAL;
+
+	if (refcount_dec_and_test(&head->ref)) {
+		objpool_free(head);
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+EXPORT_SYMBOL_GPL(objpool_drop);
+
+/* try to retrieve object from slot */
+static inline void *objpool_try_get_slot(struct objpool_slot *os)
+{
+	uint32_t *ages = SLOT_AGES(os);
+	void **ents = SLOT_ENTS(os);
+	/* do memory load of head to local head */
+	uint32_t head = smp_load_acquire(&os->head);
+
+	/* loop if slot isn't empty */
+	while (head != READ_ONCE(os->tail)) {
+		uint32_t id = head & os->mask, prev = head;
+
+		/* do prefetching of object ents */
+		prefetch(&ents[id]);
+
+		/* check whether this item was ready for retrieval */
+		if (smp_load_acquire(&ages[id]) == head) {
+			/* node must have been udpated by push() */
+			void *node = READ_ONCE(ents[id]);
+			/* commit and move forward head of the slot */
+			if (try_cmpxchg_release(&os->head, &head, head + 1))
+				return node;
+			/* head was already updated by others */
+		}
+
+		/* re-load head from memory and continue trying */
+		head = READ_ONCE(os->head);
+		/*
+		 * head stays unchanged, so it's very likely there's an
+		 * ongoing push() on other cpu nodes but yet not update
+		 * ages[] to mark it's completion
+		 */
+		if (head == prev)
+			break;
+	}
+
+	return NULL;
+}
+
+/* allocate an object from object pool */
+void *objpool_pop(struct objpool_head *head)
+{
+	unsigned long flags;
+	int i, cpu;
+	void *obj = NULL;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
+
+	cpu = raw_smp_processor_id();
+	for (i = 0; i < num_possible_cpus(); i++) {
+		obj = objpool_try_get_slot(head->cpu_slots[cpu]);
+		if (obj)
+			break;
+		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
+	}
+	raw_local_irq_restore(flags);
+
+	return obj;
+}
+EXPORT_SYMBOL_GPL(objpool_pop);
+
+/* release whole objpool forcely */
+void objpool_free(struct objpool_head *head)
+{
+	if (!head->cpu_slots)
+		return;
+
+	/* release percpu slots */
+	objpool_fini_percpu_slots(head);
+
+	/* call user's cleanup callback if provided */
+	if (head->release)
+		head->release(head, head->context);
+}
+EXPORT_SYMBOL_GPL(objpool_free);
+
+/* drop unused objects and defref objpool for releasing */
+void objpool_fini(struct objpool_head *head)
+{
+	void *nod;
+
+	do {
+		/* grab object from objpool and drop it */
+		nod = objpool_pop(head);
+
+		/* drop the extra ref of objpool */
+		if (refcount_dec_and_test(&head->ref))
+			objpool_free(head);
+	} while (nod);
+}
+EXPORT_SYMBOL_GPL(objpool_fini);
-- 
2.40.1

