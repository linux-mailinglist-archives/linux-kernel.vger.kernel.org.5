Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851907CB7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjJQB11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQB1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:27:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB47A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:27:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7929AC433C7;
        Tue, 17 Oct 2023 01:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697506042;
        bh=W6p5Qp32hISdU7VFtYFWnANt8NR84dBovD2mjp8Ff/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HHhEQf7H/nb2vCuXFtypc+hhEHmdTyorrLVw00iZFkCbNZZSim7sniAZkgUhoXIM5
         Iy5QuQ8XPaKR0aeMoky9j+y9pU0rJJfpS42E/zPK3AD8rqBzIgLJOYaxPWK/vgZXqr
         PorGG6swN/R4wjGVOy81qjkOAJM5LURAKCDEYWgQixDItzEu4c8gsxqKvaMj31SG99
         wSyXDb56KUdw1xbpJnoKdWxy4UnVMUZqJiYPeZvE/g37IvVQEfv9EIPOneUy/1XEEi
         Q/qhhOKk/2jMazNE0M4a4t7XqpUxDpH21xkG8Lb2HNXll+C3KGNyzw1o26gtNQ7wD3
         70po6gOq3e0WA==
Date:   Tue, 17 Oct 2023 10:27:16 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v10 1/5] lib: objpool added: ring-array based lockless
 MPMC
Message-Id: <20231017102716.9fb024e64f0bba948a23afca@kernel.org>
In-Reply-To: <3d0136b8-5d7d-d017-9f59-546d8464d82a@bytedance.com>
References: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
        <20231015053251.707442-2-wuqiang.matt@bytedance.com>
        <20231016004356.b5f3f815cb8d7c0994934332@kernel.org>
        <1516f7d1-e11b-3244-76b9-e6ddafc29a32@bytedance.com>
        <20231016082659.6ca94a5dff368783698753f9@kernel.org>
        <7758687f-06c1-d9b2-077a-34e79925a339@bytedance.com>
        <20231016211837.b6d425d8ed760bb3306910ae@kernel.org>
        <3d0136b8-5d7d-d017-9f59-546d8464d82a@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wuqiang,

This looks good to me. Can you update the series on top of probe/core branch?

https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/log/?h=probes/core

Thank you,

On Tue, 17 Oct 2023 01:05:21 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> Hello Masami,
> 
> Here's the updated version for your review.
> 
> ---
>   include/linux/objpool.h | 176 +++++++++++++++++++++++++
>   lib/Makefile            |   2 +-
>   lib/objpool.c           | 286 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 463 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/objpool.h
>   create mode 100644 lib/objpool.c
> 
> diff --git a/include/linux/objpool.h b/include/linux/objpool.h
> new file mode 100644
> index 000000000000..4df18405420a
> --- /dev/null
> +++ b/include/linux/objpool.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_OBJPOOL_H
> +#define _LINUX_OBJPOOL_H
> +
> +#include <linux/types.h>
> +#include <linux/refcount.h>
> +
> +/*
> + * objpool: ring-array based lockless MPMC queue
> + *
> + * Copyright: wuqiang.matt@bytedance.com,mhiramat@kernel.org
> + *
> + * objpool is a scalable implementation of high performance queue for
> + * object allocation and reclamation, such as kretprobe instances.
> + *
> + * With leveraging percpu ring-array to mitigate hot spots of memory
> + * contention, it delivers near-linear scalability for high parallel
> + * scenarios. The objpool is best suited for the following cases:
> + * 1) Memory allocation or reclamation are prohibited or too expensive
> + * 2) Consumers are of different priorities, such as irqs and threads
> + *
> + * Limitations:
> + * 1) Maximum objects (capacity) is fixed after objpool creation
> + * 2) All pre-allocated objects are managed in percpu ring array,
> + *    which consumes more memory than linked lists
> + */
> +
> +/**
> + * struct objpool_slot - percpu ring array of objpool
> + * @head: head sequence of the local ring array (to retrieve at)
> + * @tail: tail sequence of the local ring array (to append at)
> + * @last: the last sequence number marked as ready for retrieve
> + * @mask: bits mask for modulo capacity to compute array indexes
> + * @entries: object entries on this slot
> + *
> + * Represents a cpu-local array-based ring buffer, its size is specialized
> + * during initialization of object pool. The percpu objpool node is to be
> + * allocated from local memory for NUMA system, and to be kept compact in
> + * continuous memory: CPU assigned number of objects are stored just after
> + * the body of objpool_node.
> + *
> + * Real size of the ring array is far too smaller than the value range of
> + * head and tail, typed as uint32_t: [0, 2^32), so only lower bits (mask)
> + * of head and tail are used as the actual position in the ring array. In
> + * general the ring array is acting like a small sliding window, which is
> + * always moving forward in the loop of [0, 2^32).
> + */
> +struct objpool_slot {
> +	uint32_t            head;
> +	uint32_t            tail;
> +	uint32_t            last;
> +	uint32_t            mask;
> +	void               *entries[];
> +} __packed;
> +
> +struct objpool_head;
> +
> +/*
> + * caller-specified callback for object initial setup, it's only called
> + * once for each object (just after the memory allocation of the object)
> + */
> +typedef int (*objpool_init_obj_cb)(void *obj, void *context);
> +
> +/* caller-specified cleanup callback for objpool destruction */
> +typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
> +
> +/**
> + * struct objpool_head - object pooling metadata
> + * @obj_size:   object size, aligned to sizeof(void *)
> + * @nr_objs:    total objs (to be pre-allocated with objpool)
> + * @nr_cpus:    local copy of nr_cpu_ids
> + * @capacity:   max objs can be managed by one objpool_slot
> + * @gfp:        gfp flags for kmalloc & vmalloc
> + * @ref:        refcount of objpool
> + * @flags:      flags for objpool management
> + * @cpu_slots:  pointer to the array of objpool_slot
> + * @release:    resource cleanup callback
> + * @context:    caller-provided context
> + */
> +struct objpool_head {
> +	int                     obj_size;
> +	int                     nr_objs;
> +	int                     nr_cpus;
> +	int                     capacity;
> +	gfp_t                   gfp;
> +	refcount_t              ref;
> +	unsigned long           flags;
> +	struct objpool_slot   **cpu_slots;
> +	objpool_fini_cb         release;
> +	void                   *context;
> +};
> +
> +#define OBJPOOL_NR_OBJECT_MAX	(1UL << 24) /* maximum numbers of total objects */
> +#define OBJPOOL_OBJECT_SIZE_MAX	(1UL << 16) /* maximum size of an object */
> +
> +/**
> + * objpool_init() - initialize objpool and pre-allocated objects
> + * @pool:    the object pool to be initialized, declared by caller
> + * @nr_objs: total objects to be pre-allocated by this object pool
> + * @object_size: size of an object (should be > 0)
> + * @gfp:     flags for memory allocation (via kmalloc or vmalloc)
> + * @context: user context for object initialization callback
> + * @objinit: object initialization callback for extra setup
> + * @release: cleanup callback for extra cleanup task
> + *
> + * return value: 0 for success, otherwise error code
> + *
> + * All pre-allocated objects are to be zeroed after memory allocation.
> + * Caller could do extra initialization in objinit callback. objinit()
> + * will be called just after slot allocation and called only once for
> + * each object. After that the objpool won't touch any content of the
> + * objects. It's caller's duty to perform reinitialization after each
> + * pop (object allocation) or do clearance before each push (object
> + * reclamation).
> + */
> +int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
> +		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
> +		 objpool_fini_cb release);
> +
> +/**
> + * objpool_pop() - allocate an object from objpool
> + * @pool: object pool
> + *
> + * return value: object ptr or NULL if failed
> + */
> +void *objpool_pop(struct objpool_head *pool);
> +
> +/**
> + * objpool_push() - reclaim the object and return back to objpool
> + * @obj:  object ptr to be pushed to objpool
> + * @pool: object pool
> + *
> + * return: 0 or error code (it fails only when user tries to push
> + * the same object multiple times or wrong "objects" into objpool)
> + */
> +int objpool_push(void *obj, struct objpool_head *pool);
> +
> +/**
> + * objpool_drop() - discard the object and deref objpool
> + * @obj:  object ptr to be discarded
> + * @pool: object pool
> + *
> + * return: 0 if objpool was released; -EAGAIN if there are still
> + *         outstanding objects
> + *
> + * objpool_drop is normally for the release of outstanding objects
> + * after objpool cleanup (objpool_fini). Thinking of this example:
> + * kretprobe is unregistered and objpool_fini() is called to release
> + * all remained objects, but there are still objects being used by
> + * unfinished kretprobes (like blockable function: sys_accept). So
> + * only when the last outstanding object is dropped could the whole
> + * objpool be released along with the call of objpool_drop()
> + */
> +int objpool_drop(void *obj, struct objpool_head *pool);
> +
> +/**
> + * objpool_free() - release objpool forcely (all objects to be freed)
> + * @pool: object pool to be released
> + */
> +void objpool_free(struct objpool_head *pool);
> +
> +/**
> + * objpool_fini() - deref object pool (also releasing unused objects)
> + * @pool: object pool to be dereferenced
> + *
> + * objpool_fini() will try to release all remained free objects and
> + * then drop an extra reference of the objpool. If all objects are
> + * already returned to objpool (so called synchronous use cases),
> + * the objpool itself will be freed together. But if there are still
> + * outstanding objects (so called asynchronous use cases, such like
> + * blockable kretprobe), the objpool won't be released until all
> + * the outstanding objects are dropped, but the caller must assure
> + * there are no concurrent objpool_push() on the fly. Normally RCU
> + * is being required to make sure all ongoing objpool_push() must
> + * be finished before calling objpool_fini(), so does kretprobes,
> + * rethook or test_objpool
> + */
> +void objpool_fini(struct objpool_head *pool);
> +
> +#endif /* _LINUX_OBJPOOL_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index 1ffae65bb7ee..7a84c922d9ff 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>   	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>   	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>   	 nmi_backtrace.o win_minmax.o memcat_p.o \
> -	 buildid.o
> +	 buildid.o objpool.o
> 
>   lib-$(CONFIG_PRINTK) += dump_stack.o
>   lib-$(CONFIG_SMP) += cpumask.o
> diff --git a/lib/objpool.c b/lib/objpool.c
> new file mode 100644
> index 000000000000..37a71e063f18
> --- /dev/null
> +++ b/lib/objpool.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/objpool.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/atomic.h>
> +#include <linux/irqflags.h>
> +#include <linux/cpumask.h>
> +#include <linux/log2.h>
> +
> +/*
> + * objpool: ring-array based lockless MPMC/FIFO queues
> + *
> + * Copyright: wuqiang.matt@bytedance.com,mhiramat@kernel.org
> + */
> +
> +/* initialize percpu objpool_slot */
> +static int
> +objpool_init_percpu_slot(struct objpool_head *pool,
> +			 struct objpool_slot *slot,
> +			 int nodes, void *context,
> +			 objpool_init_obj_cb objinit)
> +{
> +	void *obj = (void *)&slot->entries[pool->capacity];
> +	int i;
> +
> +	/* initialize elements of percpu objpool_slot */
> +	slot->mask = pool->capacity - 1;
> +
> +	for (i = 0; i < nodes; i++) {
> +		if (objinit) {
> +			int rc = objinit(obj, context);
> +			if (rc)
> +				return rc;
> +		}
> +		slot->entries[slot->tail & slot->mask] = obj;
> +		obj = obj + pool->obj_size;
> +		slot->tail++;
> +		slot->last = slot->tail;
> +		pool->nr_objs++;
> +	}
> +
> +	return 0;
> +}
> +
> +/* allocate and initialize percpu slots */
> +static int
> +objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
> +			  void *context, objpool_init_obj_cb objinit)
> +{
> +	int i, cpu_count = 0;
> +
> +	for (i = 0; i < pool->nr_cpus; i++) {
> +
> +		struct objpool_slot *slot;
> +		int nodes, size, rc;
> +
> +		/* skip the cpu node which could never be present */
> +		if (!cpu_possible(i))
> +			continue;
> +
> +		/* compute how many objects to be allocated with this slot */
> +		nodes = nr_objs / num_possible_cpus();
> +		if (cpu_count < (nr_objs % num_possible_cpus()))
> +			nodes++;
> +		cpu_count++;
> +
> +		size = struct_size(slot, entries, pool->capacity) +
> +			pool->obj_size * nodes;
> +
> +		/*
> +		 * here we allocate percpu-slot & objs together in a single
> +		 * allocation to make it more compact, taking advantage of
> +		 * warm caches and TLB hits. in default vmalloc is used to
> +		 * reduce the pressure of kernel slab system. as we know,
> +		 * mimimal size of vmalloc is one page since vmalloc would
> +		 * always align the requested size to page size
> +		 */
> +		if (pool->gfp & GFP_ATOMIC)
> +			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
> +		else
> +			slot = __vmalloc_node(size, sizeof(void *), pool->gfp,
> +				cpu_to_node(i), __builtin_return_address(0));
> +		if (!slot)
> +			return -ENOMEM;
> +		memset(slot, 0, size);
> +		pool->cpu_slots[i] = slot;
> +
> +		/* initialize the objpool_slot of cpu node i */
> +		rc = objpool_init_percpu_slot(pool, slot, nodes, context, objinit);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/* cleanup all percpu slots of the object pool */
> +static void objpool_fini_percpu_slots(struct objpool_head *pool)
> +{
> +	int i;
> +
> +	if (!pool->cpu_slots)
> +		return;
> +
> +	for (i = 0; i < pool->nr_cpus; i++)
> +		kvfree(pool->cpu_slots[i]);
> +	kfree(pool->cpu_slots);
> +}
> +
> +/* initialize object pool and pre-allocate objects */
> +int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
> +		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
> +		objpool_fini_cb release)
> +{
> +	int rc, capacity, slot_size;
> +
> +	/* check input parameters */
> +	if (nr_objs <= 0 || nr_objs > OBJPOOL_NR_OBJECT_MAX ||
> +	    object_size <= 0 || object_size > OBJPOOL_OBJECT_SIZE_MAX)
> +		return -EINVAL;
> +
> +	/* align up to unsigned long size */
> +	object_size = ALIGN(object_size, sizeof(long));
> +
> +	/* calculate capacity of percpu objpool_slot */
> +	capacity = roundup_pow_of_two(nr_objs);
> +	if (!capacity)
> +		return -EINVAL;
> +
> +	/* initialize objpool pool */
> +	memset(pool, 0, sizeof(struct objpool_head));
> +	pool->nr_cpus = nr_cpu_ids;
> +	pool->obj_size = object_size;
> +	pool->capacity = capacity;
> +	pool->gfp = gfp & ~__GFP_ZERO;
> +	pool->context = context;
> +	pool->release = release;
> +	slot_size = pool->nr_cpus * sizeof(struct objpool_slot);
> +	pool->cpu_slots = kzalloc(slot_size, pool->gfp);
> +	if (!pool->cpu_slots)
> +		return -ENOMEM;
> +
> +	/* initialize per-cpu slots */
> +	rc = objpool_init_percpu_slots(pool, nr_objs, context, objinit);
> +	if (rc)
> +		objpool_fini_percpu_slots(pool);
> +	else
> +		refcount_set(&pool->ref, pool->nr_objs + 1);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(objpool_init);
> +
> +/* adding object to slot, abort if the slot was already full */
> +static inline int
> +objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
> +{
> +	struct objpool_slot *slot = pool->cpu_slots[cpu];
> +	uint32_t head, tail;
> +
> +	/* loading tail and head as a local snapshot, tail first */
> +	tail = READ_ONCE(slot->tail);
> +
> +	do {
> +		head = READ_ONCE(slot->head);
> +		/* fault caught: something must be wrong */
> +		WARN_ON_ONCE(tail - head > pool->nr_objs);
> +	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> +
> +	/* now the tail position is reserved for the given obj */
> +	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
> +	/* update sequence to make this obj available for pop() */
> +	smp_store_release(&slot->last, tail + 1);
> +
> +	return 0;
> +}
> +
> +/* reclaim an object to object pool */
> +int objpool_push(void *obj, struct objpool_head *pool)
> +{
> +	unsigned long flags;
> +	int rc;
> +
> +	/* disable local irq to avoid preemption & interruption */
> +	raw_local_irq_save(flags);
> +	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
> +	raw_local_irq_restore(flags);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(objpool_push);
> +
> +/* try to retrieve object from slot */
> +static inline void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
> +{
> +	struct objpool_slot *slot = pool->cpu_slots[cpu];
> +	/* load head snapshot, other cpus may change it */
> +	uint32_t head = smp_load_acquire(&slot->head);
> +
> +	while (head != READ_ONCE(slot->last)) {
> +		void *obj;
> +
> +		/* obj must be retrieved before moving forward head */
> +		obj = READ_ONCE(slot->entries[head & slot->mask]);
> +
> +		/* move head forward to mark it's consumption */
> +		if (try_cmpxchg_release(&slot->head, &head, head + 1))
> +			return obj;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* allocate an object from object pool */
> +void *objpool_pop(struct objpool_head *pool)
> +{
> +	void *obj = NULL;
> +	unsigned long flags;
> +	int i, cpu;
> +
> +	/* disable local irq to avoid preemption & interruption */
> +	raw_local_irq_save(flags);
> +
> +	cpu = raw_smp_processor_id();
> +	for (i = 0; i < num_possible_cpus(); i++) {
> +		obj = objpool_try_get_slot(pool, cpu);
> +		if (obj)
> +			break;
> +		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
> +	}
> +	raw_local_irq_restore(flags);
> +
> +	return obj;
> +}
> +EXPORT_SYMBOL_GPL(objpool_pop);
> +
> +/* release whole objpool forcely */
> +void objpool_free(struct objpool_head *pool)
> +{
> +	if (!pool->cpu_slots)
> +		return;
> +
> +	/* release percpu slots */
> +	objpool_fini_percpu_slots(pool);
> +
> +	/* call user's cleanup callback if provided */
> +	if (pool->release)
> +		pool->release(pool, pool->context);
> +}
> +EXPORT_SYMBOL_GPL(objpool_free);
> +
> +/* drop the allocated object, rather reclaim it to objpool */
> +int objpool_drop(void *obj, struct objpool_head *pool)
> +{
> +	if (!obj || !pool)
> +		return -EINVAL;
> +
> +	if (refcount_dec_and_test(&pool->ref)) {
> +		objpool_free(pool);
> +		return 0;
> +	}
> +
> +	return -EAGAIN;
> +}
> +EXPORT_SYMBOL_GPL(objpool_drop);
> +
> +/* drop unused objects and defref objpool for releasing */
> +void objpool_fini(struct objpool_head *pool)
> +{
> +	int count = 1; /* extra ref for objpool itself */
> +
> +	/* drop all remained objects from objpool */
> +	while (objpool_pop(pool))
> +		count++;
> +
> +	if (refcount_sub_and_test(count, &pool->ref))
> +		objpool_free(pool);
> +}
> +EXPORT_SYMBOL_GPL(objpool_fini);
> -- 
> 
> Regards,
> Wuqiang
> 
> On 2023/10/16 20:18, Masami Hiramatsu (Google) wrote:
> > Hi Wuqiang,
> > 
> > On Mon, 16 Oct 2023 10:45:30 +0800
> > "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> > 
> >> On 2023/10/16 07:26, Masami Hiramatsu (Google) wrote:
> >>> On Mon, 16 Oct 2023 00:06:11 +0800
> >>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> >>>
> >>>> On 2023/10/15 23:43, Masami Hiramatsu (Google) wrote:
> >>>>> On Sun, 15 Oct 2023 13:32:47 +0800
> >>>>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> >>>>>
> >>>>>> objpool is a scalable implementation of high performance queue for
> >>>>>> object allocation and reclamation, such as kretprobe instances.
> >>>>>>
> >>>>>> With leveraging percpu ring-array to mitigate hot spots of memory
> >>>>>> contention, it delivers near-linear scalability for high parallel
> >>>>>> scenarios. The objpool is best suited for the following cases:
> >>>>>> 1) Memory allocation or reclamation are prohibited or too expensive
> >>>>>> 2) Consumers are of different priorities, such as irqs and threads
> >>>>>>
> >>>>>> Limitations:
> >>>>>> 1) Maximum objects (capacity) is fixed after objpool creation
> >>>>>> 2) All pre-allocated objects are managed in percpu ring array,
> >>>>>>       which consumes more memory than linked lists
> >>>>>>
> >>>>>
> >>>>> Thanks for updating! This looks good to me except 2 points.
> >>>>>
> >>>>> [...]
> >>>>>> +
> >>>>>> +/* initialize object pool and pre-allocate objects */
> >>>>>> +int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
> >>>>>> +		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
> >>>>>> +		objpool_fini_cb release)
> >>>>>> +{
> >>>>>> +	int rc, capacity, slot_size;
> >>>>>> +
> >>>>>> +	/* check input parameters */
> >>>>>> +	if (nr_objs <= 0 || nr_objs > OBJPOOL_NR_OBJECT_MAX ||
> >>>>>> +	    object_size <= 0 || object_size > OBJPOOL_OBJECT_SIZE_MAX)
> >>>>>> +		return -EINVAL;
> >>>>>> +
> >>>>>> +	/* align up to unsigned long size */
> >>>>>> +	object_size = ALIGN(object_size, sizeof(long));
> >>>>>> +
> >>>>>> +	/* calculate capacity of percpu objpool_slot */
> >>>>>> +	capacity = roundup_pow_of_two(nr_objs);
> >>>>>
> >>>>> This must be 'roundup_pow_of_two(nr_objs + 1)' because if nr_objs is power
> >>>>> of 2 and all objects are pushed on the same slot, tail == head. This
> >>>>> means empty and full is the same.
> >>>>
> >>>> That won't happen. Would tail and head wrap only when >= 2^32. When all
> >>>> objects are pushed to the same slot, tail will be (head + capacity).
> >>>
> >>> Ah, indeed. OK.
> >>>
> >>>>
> >>>>>
> >>>>>> +	if (!capacity)
> >>>>>> +		return -EINVAL;
> >>>>>> +
> >>>>>> +	/* initialize objpool pool */
> >>>>>> +	memset(pool, 0, sizeof(struct objpool_head));
> >>>>>> +	pool->nr_cpus = nr_cpu_ids;
> >>>>>> +	pool->obj_size = object_size;
> >>>>>> +	pool->capacity = capacity;
> >>>>>> +	pool->gfp = gfp & ~__GFP_ZERO;
> >>>>>> +	pool->context = context;
> >>>>>> +	pool->release = release;
> >>>>>> +	slot_size = pool->nr_cpus * sizeof(struct objpool_slot);
> >>>>>> +	pool->cpu_slots = kzalloc(slot_size, pool->gfp);
> >>>>>> +	if (!pool->cpu_slots)
> >>>>>> +		return -ENOMEM;
> >>>>>> +
> >>>>>> +	/* initialize per-cpu slots */
> >>>>>> +	rc = objpool_init_percpu_slots(pool, nr_objs, context, objinit);
> >>>>>> +	if (rc)
> >>>>>> +		objpool_fini_percpu_slots(pool);
> >>>>>> +	else
> >>>>>> +		refcount_set(&pool->ref, pool->nr_objs + 1);
> >>>>>> +
> >>>>>> +	return rc;
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL_GPL(objpool_init);
> >>>>>> +
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>> +
> >>>>>> +/* drop unused objects and defref objpool for releasing */
> >>>>>> +void objpool_fini(struct objpool_head *pool)
> >>>>>> +{
> >>>>>> +	void *obj;
> >>>>>> +
> >>>>>> +	do {
> >>>>>> +		/* grab object from objpool and drop it */
> >>>>>> +		obj = objpool_pop(pool);
> >>>>>> +
> >>>>>> +		/*
> >>>>>> +		 * drop reference of objpool anyway even if
> >>>>>> +		 * the obj is NULL, since one extra ref upon
> >>>>>> +		 * objpool was already grabbed during pool
> >>>>>> +		 * initialization in objpool_init()
> >>>>>> +		 */
> >>>>>> +		if (refcount_dec_and_test(&pool->ref))
> >>>>>> +			objpool_free(pool);
> >>>>>
> >>>>> Nit: you can call objpool_drop() instead of repeating the same thing here.
> >>>>
> >>>> objpool_drop won't deref objpool if given obj is NULL. But here we need
> >>>> drop objpool anyway even if obj is NULL.
> >>>
> >>> I guess you decrement for the 'objpool' itself if obj=NULL, but I think
> >>> it is a bit hacky (so you added the comment).
> >>> e.g. rethook is doing something like below.
> >>>
> >>> ---
> >>> /* extra count for this pool itself */
> >>> count = 1;
> >>> /* make the pool empty */
> >>> while (objpool_pop(pool))
> >>> 	count++;
> >>>
> >>> if (refcount_sub_and_test(count, &pool->ref))
> >>> 	objpool_free(pool);
> >>> ---
> >>
> >> Right, that's reasonable. Better one single atomic operation than multiple.
> > 
> > I found another comment issue about a small window which this may not work.
> > This is not a real issue for this series because this doesn't happen on
> > rethook/kretprobe, but if you apply this to other use-case, it must be
> > cared.
> > 
> > Since we use reserve-commit on 'push' operation, this 'pop' loop will miss
> > an object which is under 'push' op. I mean
> > 
> > CPU0                    CPU1
> > 
> > objpool_fini() {
> > do {
> >                           objpool_push() {
> >                              update slot->tail; // reserve
> >    obj = objpool_pop();
> >                              update slot->last;  // commit
> > } while (obj);
> > 
> > In this case, the refcount can not be 0 and we can not release objpool.
> > To avoid this, we make sure all ongoing 'push()' must be finished.
> > 
> > Actually in the rethook/kretprobe, it already sync the rcu so this doesn't
> > happen. So you should document it the user must use RCU sync after stop
> > using the objpool, then call objpool_fini().
> > 
> > E.g.
> > 
> > start_using() {
> > objpool_init();
> > active = true;
> > }
> > 
> > obj_alloc() {
> > rcu_read_lock();
> > if (active)
> > 	obj = objpool_pop();
> > else
> > 	obj = NULL;
> > rcu_read_unlock();
> > }
> > 
> > /* use obj for something, it is OK to change the context */
> > 
> > obj_return() {
> > rcu_read_lock();
> > if (active)
> > 	objpool_push(obj);
> > else
> > 	objpool_drop(obj);
> > rcu_read_unlock();
> > }
> > 
> > /* kretprobe style */
> > stop_using() {
> > active = false;
> > synchronize_rcu();
> > objpool_fini();
> > }
> > 
> > /* rethook style */
> > stop_using() {
> > active = false;
> > call_rcu(objpool_fini);
> > }
> > 
> > Hmm, yeah, if we can add this 'active' flag to objpool, it is good. But
> > since kretprobe has different design of the interface, it is hard.
> > Anyway, can you add a comment that user must ensure that any 'push' including
> > ongoing one does not happen while 'fini'? objpool does not care that so user
> > must take care of that. For example using rcu_read_lock() for the 'push/pop'
> > operation and rcu-sync before 'fini' operation.
> > 
> > Thanks,
> > 
> >>
> >>>>
> >>>>> Thank you,
> >>>>>
> >>>>>> +	} while (obj);
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL_GPL(objpool_fini);
> >>>>>> -- 
> >>>>>> 2.40.1
> >>>>>>
> >>>>
> >>>> Thanks for your time
> >>>>
> >>>>
> >>>
> >>>
> >>
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
