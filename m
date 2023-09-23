Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793727ABF73
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjIWJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjIWJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:49:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B023C180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 02:49:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89379C433C7;
        Sat, 23 Sep 2023 09:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695462545;
        bh=tnFC1za/kz6jPKJf+cjcW3bCtsoLAKgSG6M0DtaAK+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sW92EqN+JWjVX3Y6HnLqbFvEsOJ7xgQi00WzqjFOR/FNck0lmtYoMQz8YF5aeTAzw
         R2tIT0cD1muDEYx7ACbOUU+aLX5eERBrfzfIZ57T4WI6tj+dJ2v2BuDBnluSIaVAqO
         V5CKZfHRtII+k2uMX9nKWn86megnOhv93QIn1FJAZ8h2/nEYVBWIOTvdurfrWNrmDF
         RPq0tdrLy8ilNw4xXsgmVM85PegqSA3PlqLefg8Zcp+J/Z15qWswSrbfCE1NovFcWT
         mR5Qdz/zTG/ZnC8gA+idKIC2xKRoyaXKydtMG74DCf80H7GnL/TLC9+eo1nR48Hp4n
         ciXXrOgXWqIig==
Date:   Sat, 23 Sep 2023 18:48:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v9 1/5] lib: objpool added: ring-array based lockless
 MPMC
Message-Id: <20230923184858.d82abcf71e5f02c4c070543b@kernel.org>
In-Reply-To: <20230905015255.81545-2-wuqiang.matt@bytedance.com>
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
        <20230905015255.81545-2-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wuqiang,

Sorry for replying later.

On Tue,  5 Sep 2023 09:52:51 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> The object pool is a scalable implementaion of high performance queue
> for object allocation and reclamation, such as kretprobe instances.
> 
> With leveraging percpu ring-array to mitigate the hot spot of memory
> contention, it could deliver near-linear scalability for high parallel
> scenarios. The objpool is best suited for following cases:
> 1) Memory allocation or reclamation are prohibited or too expensive
> 2) Consumers are of different priorities, such as irqs and threads
> 
> Limitations:
> 1) Maximum objects (capacity) is determined during pool initializing
>    and can't be modified (extended) after objpool creation

So the pool size is fixed in initialization.

> 2) The memory of objects won't be freed until objpool is finalized
> 3) Object allocation (pop) may fail after trying all cpu slots

This means that object allocation will fail if the all pools are empty,
right?

> 
> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  include/linux/objpool.h | 174 +++++++++++++++++++++
>  lib/Makefile            |   2 +-
>  lib/objpool.c           | 338 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 513 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/objpool.h
>  create mode 100644 lib/objpool.c
> 
> diff --git a/include/linux/objpool.h b/include/linux/objpool.h
> new file mode 100644
> index 000000000000..33c832216b98
> --- /dev/null
> +++ b/include/linux/objpool.h
> @@ -0,0 +1,174 @@
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
> + * Copyright: wuqiang.matt@bytedance.com
> + *
> + * The object pool is a scalable implementaion of high performance queue
> + * for objects allocation and reclamation, such as kretprobe instances.
> + *
> + * With leveraging per-cpu ring-array to mitigate the hot spots of memory
> + * contention, it could deliver near-linear scalability for high parallel
> + * scenarios. The ring-array is compactly managed in a single cache-line
> + * to benefit from warmed L1 cache for most cases (<= 4 objects per-core).
> + * The body of pre-allocated objects is stored in continuous cache-lines
> + * just after the ring-array.

I consider the size of entries may be big if we have larger number of
CPU cores, like 72-cores. And if user specifies (2^n) + 1 entries.
In this case, each CPU has (2^n - 1)/72 objects, but has 2^(n + 1)
entries in ring buffer. So it should be noted.

> + *
> + * The object pool is interrupt safe. Both allocation and reclamation
> + * (object pop and push operations) can be preemptible or interruptable.

You've added raw_spinlock_disable/enable(), so it is not preemptible
or interruptible anymore. (Anyway, caller doesn't take care of that)

> + *
> + * It's best suited for following cases:
> + * 1) Memory allocation or reclamation are prohibited or too expensive
> + * 2) Consumers are of different priorities, such as irqs and threads
> + *
> + * Limitations:
> + * 1) Maximum objects (capacity) is determined during pool initializing
> + * 2) The memory of objects won't be freed until the pool is finalized
> + * 3) Object allocation (pop) may fail after trying all cpu slots
> + */
> +
> +/**
> + * struct objpool_slot - percpu ring array of objpool
> + * @head: head of the local ring array (to retrieve at)
> + * @tail: tail of the local ring array (to append at)
> + * @bits: log2 of capacity (for bitwise operations)
> + * @mask: capacity - 1

These description doesn not give idea what those roles are.

> + *
> + * Represents a cpu-local array-based ring buffer, its size is specialized
> + * during initialization of object pool. The percpu objpool slot is to be
> + * allocated from local memory for NUMA system, and to be kept compact in
> + * continuous memory: ages[] is stored just after the body of objpool_slot,
> + * and then entries[]. ages[] describes revision of each item, solely used
> + * to avoid ABA; entries[] contains pointers of the actual objects
> + *
> + * Layout of objpool_slot in memory:
> + *
> + * 64bit:
> + *        4      8      12     16        32                 64
> + * | head | tail | bits | mask | ages[4] | ents[4]: (8 * 4) | objects
> + *
> + * 32bit:
> + *        4      8      12     16        32        48       64
> + * | head | tail | bits | mask | ages[4] | ents[4] | unused | objects

Hm, the '4' here means number of objects after this objpool_slot?
I don't recommend you to allocate several arraies after the header, instead,
using another data structure like this;

|head|tail|bits|mask|ents[N]{age:4|offs:4}|padding|objects

here N means the number of total objects.

struct objpool_entry {
	uint32_t	age;
	void *	ptr;
} __attribute__((packed,aligned(8))) ;

> + *
> + */
> +struct objpool_slot {
> +	uint32_t                head;
> +	uint32_t                tail;
> +	uint32_t                bits;
> +	uint32_t                mask;

	struct objpool_entry	entries[];

> +} __packed;

Then, you don't need complex macros to access object, but you need only one
inline function to get the actual object address.

static inline void *objpool_slot_object(struct objpool_slot *slot, int nth)
{
	if (nth > (1 << bits))
		return NULL;

	return (void *)((unsigned long)slot + slot.entries[nth].offs);
}


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
> + * @obj_size:   object & element size

What does the 'element' mean?

> + * @nr_objs:    total objs (to be pre-allocated)

but all objects must be pre-allocated, right? then it is simply

@nr_objs: the total number of objects in this objpool.

> + * @nr_cpus:    nr_cpu_ids

would we have to save it? or just use 'nr_cpu_ids'?

> + * @capacity:   max objects per cpuslot

what is 'cpuslot'?
This seems the size of objpool_entry array in objpool_slot.

> + * @gfp:        gfp flags for kmalloc & vmalloc
> + * @ref:        refcount for objpool
> + * @flags:      flags for objpool management
> + * @cpu_slots:  array of percpu slots
> + * @slot_sizes:	size in bytes of slots
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
> +	int                    *slot_sizes;
> +	objpool_fini_cb         release;
> +	void                   *context;
> +};
> +
> +#define OBJPOOL_FROM_VMALLOC	(0x800000000)	/* objpool allocated from vmalloc area */
> +#define OBJPOOL_HAVE_OBJECTS	(0x400000000)	/* objects allocated along with objpool */
> +
> +/**
> + * objpool_init() - initialize objpool and pre-allocated objects
> + * @head:    the object pool to be initialized, declared by caller
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
> + * will be called just after slot allocation and will be only once for
> + * each object. Since then the objpool won't touch any content of the
> + * objects. It's caller's duty to perform reinitialization after each
> + * pop (object allocation) or do clearance before each push (object
> + * reclamation).
> + */
> +int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
> +		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
> +		 objpool_fini_cb release);
> +
> +/**
> + * objpool_pop() - allocate an object from objpool
> + * @head: object pool
> + *
> + * return value: object ptr or NULL if failed
> + */
> +void *objpool_pop(struct objpool_head *head);
> +
> +/**
> + * objpool_push() - reclaim the object and return back to objpool
> + * @obj:  object ptr to be pushed to objpool
> + * @head: object pool
> + *
> + * return: 0 or error code (it fails only when user tries to push
> + * the same object multiple times or wrong "objects" into objpool)
> + */
> +int objpool_push(void *obj, struct objpool_head *head);
> +
> +/**
> + * objpool_drop() - discard the object and deref objpool
> + * @obj:  object ptr to be discarded
> + * @head: object pool
> + *
> + * return: 0 if objpool was released or error code
> + */
> +int objpool_drop(void *obj, struct objpool_head *head);
> +
> +/**
> + * objpool_free() - release objpool forcely (all objects to be freed)
> + * @head: object pool to be released
> + */
> +void objpool_free(struct objpool_head *head);
> +
> +/**
> + * objpool_fini() - deref object pool (also releasing unused objects)
> + * @head: object pool to be dereferenced
> + */
> +void objpool_fini(struct objpool_head *head);
> +
> +#endif /* _LINUX_OBJPOOL_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index 1ffae65bb7ee..7a84c922d9ff 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>  	 nmi_backtrace.o win_minmax.o memcat_p.o \
> -	 buildid.o
> +	 buildid.o objpool.o
>  
>  lib-$(CONFIG_PRINTK) += dump_stack.o
>  lib-$(CONFIG_SMP) += cpumask.o
> diff --git a/lib/objpool.c b/lib/objpool.c
> new file mode 100644
> index 000000000000..22e752371820
> --- /dev/null
> +++ b/lib/objpool.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/objpool.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/atomic.h>
> +#include <linux/prefetch.h>
> +#include <linux/irqflags.h>
> +#include <linux/cpumask.h>
> +#include <linux/log2.h>
> +
> +/*
> + * objpool: ring-array based lockless MPMC/FIFO queues
> + *
> + * Copyright: wuqiang.matt@bytedance.com
> + */
> +
> +#define SLOT_AGES(s) ((uint32_t *)((char *)(s) + sizeof(struct objpool_slot)))
> +#define SLOT_ENTS(s) ((void **)((char *)(s) + sizeof(struct objpool_slot) + \
> +			(sizeof(uint32_t) << (s)->bits)))
> +#define SLOT_OBJS(s) ((void *)((char *)(s) + sizeof(struct objpool_slot) + \
> +			((sizeof(uint32_t) + sizeof(void *)) << (s)->bits)))
> +#define SLOT_CORE(n) cpumask_nth((n) % num_possible_cpus(), cpu_possible_mask)
> +
> +/* compute the suitable num of objects to be managed per slot */
> +static int objpool_nobjs(int size)
> +{
> +	return rounddown_pow_of_two((size - sizeof(struct objpool_slot)) /
> +			(sizeof(uint32_t) + sizeof(void *)));
> +}
> +
> +/* allocate and initialize percpu slots */

@head: the objpool_head for managing this objpool
@nobjs: the total number of objects in this objpool
@context: context data for @objinit
@objinit: initialize callback for each object.

> +static int
> +objpool_init_percpu_slots(struct objpool_head *head, int nobjs,
> +			void *context, objpool_init_obj_cb objinit)
> +{
> +	int i, j, n, size, objsz, cpu = 0, nents = head->capacity;

'nents' is *round up to the power of 2* of the total number of objects.

> +
> +	/* aligned object size by sizeof(void *) */
> +	objsz = ALIGN(head->obj_size, sizeof(void *));
> +	/* shall we allocate objects along with percpu-slot */
> +	if (objsz)
> +		head->flags |= OBJPOOL_HAVE_OBJECTS;

Is there any chance that objsz == 0?

> +
> +	/* vmalloc is used in default to allocate percpu-slots */
> +	if (!(head->gfp & GFP_ATOMIC))
> +		head->flags |= OBJPOOL_FROM_VMALLOC;
> +
> +	for (i = 0; i < head->nr_cpus; i++) {
> +		struct objpool_slot *os;
> +
> +		/* skip the cpus which could never be present */
> +		if (!cpu_possible(i))
> +			continue;
> +
> +		/* compute how many objects to be managed by this slot */

"to be managed"? or "to be allocated with"?
It seems all objects are possible to be managed by each slot.

> +		n = nobjs / num_possible_cpus();
> +		if (cpu < (nobjs % num_possible_cpus()))
> +			n++;
> +		size = sizeof(struct objpool_slot) + sizeof(void *) * nents +
> +		       sizeof(uint32_t) * nents + objsz * n;
> +
> +		/*
> +		 * here we allocate percpu-slot & objects together in a single
> +		 * allocation, taking advantage of warm caches and TLB hits as
> +		 * vmalloc always aligns the request size to pages

"Since the objpool_entry array in the slot is mostly accessed from the
 i-th CPU, it should be allocated from the memory node for that CPU."

I think the reason of the memory node allocation is mainly for reducing the
penalty of the cache-miss, since it will be bigger if running on NUMA.

> +		 */
> +		if (head->flags & OBJPOOL_FROM_VMALLOC)
> +			os = __vmalloc_node(size, sizeof(void *), head->gfp,
> +				cpu_to_node(i), __builtin_return_address(0));
> +		else
> +			os = kmalloc_node(size, head->gfp, cpu_to_node(i));
> +		if (!os)
> +			return -ENOMEM;
> +
> +		/* initialize percpu slot for the i-th slot */
> +		memset(os, 0, size);
> +		os->bits = ilog2(head->capacity);
> +		os->mask = head->capacity - 1;
> +		head->cpu_slots[i] = os;
> +		head->slot_sizes[i] = size;
> +		cpu = cpu + 1;
> +
> +		/*
> +		 * manually set head & tail to avoid possible conflict:
> +		 * We assume that the head item is ready for retrieval
> +		 * iff head is equal to ages[head & mask]. but ages is
> +		 * initialized as 0, so in view of the caller of pop(),
> +		 * the 1st item (0th) is always ready, but the reality
> +		 * could be: push() is stalled before the final update,
> +		 * thus the item being inserted will be lost forever
> +		 */
> +		os->head = os->tail = head->capacity;
> +
> +		if (!objsz)
> +			continue;

Is it possible? and for what?

> +
> +		for (j = 0; j < n; j++) {
> +			uint32_t *ages = SLOT_AGES(os);
> +			void **ents = SLOT_ENTS(os);
> +			void *obj = SLOT_OBJS(os) + j * objsz;
> +			uint32_t ie = os->tail & os->mask;
> +
> +			/* perform object initialization */
> +			if (objinit) {
> +				int rc = objinit(obj, context);
> +				if (rc)
> +					return rc;
> +			}
> +
> +			/* add obj into the ring array */
> +			ents[ie] = obj;
> +			ages[ie] = os->tail;
> +			os->tail++;
> +			head->nr_objs++;
> +		}

To simplify the code, this loop should be another static function.

> +	}
> +
> +	return 0;
> +}
> +
> +/* cleanup all percpu slots of the object pool */
> +static void objpool_fini_percpu_slots(struct objpool_head *head)
> +{
> +	int i;
> +
> +	if (!head->cpu_slots)
> +		return;
> +
> +	for (i = 0; i < head->nr_cpus; i++) {
> +		if (!head->cpu_slots[i])
> +			continue;
> +		if (head->flags & OBJPOOL_FROM_VMALLOC)
> +			vfree(head->cpu_slots[i]);
> +		else
> +			kfree(head->cpu_slots[i]);
> +	}
> +	kfree(head->cpu_slots);
> +	head->cpu_slots = NULL;
> +	head->slot_sizes = NULL;
> +}
> +
> +/* initialize object pool and pre-allocate objects */
> +int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
> +		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
> +		objpool_fini_cb release)
> +{
> +	int nents, rc;
> +
> +	/* check input parameters */
> +	if (nr_objs <= 0 || object_size <= 0)
> +		return -EINVAL;
> +
> +	/* calculate percpu slot size (rounded to pow of 2) */
> +	nents = max_t(int, roundup_pow_of_two(nr_objs),
> +			objpool_nobjs(L1_CACHE_BYTES));
> +
> +	/* initialize objpool head */
> +	memset(head, 0, sizeof(struct objpool_head));
> +	head->nr_cpus = nr_cpu_ids;
> +	head->obj_size = object_size;
> +	head->capacity = nents;
> +	head->gfp = gfp & ~__GFP_ZERO;
> +	head->context = context;
> +	head->release = release;
> +
> +	/* allocate array for percpu slots */
> +	head->cpu_slots = kzalloc(head->nr_cpus * sizeof(void *) +
> +			       head->nr_cpus * sizeof(int), head->gfp);
> +	if (!head->cpu_slots)
> +		return -ENOMEM;
> +	head->slot_sizes = (int *)&head->cpu_slots[head->nr_cpus];
> +
> +	/* initialize per-cpu slots */
> +	rc = objpool_init_percpu_slots(head, nr_objs, context, objinit);
> +	if (rc)
> +		objpool_fini_percpu_slots(head);
> +	else
> +		refcount_set(&head->ref, nr_objs + 1);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(objpool_init);
> +
> +/* adding object to slot, abort if the slot was already full */
> +static inline int objpool_try_add_slot(void *obj, struct objpool_slot *os)
> +{
> +	uint32_t *ages = SLOT_AGES(os);
> +	void **ents = SLOT_ENTS(os);
> +	uint32_t head, tail;
> +
> +	do {
> +		/* perform memory loading for both head and tail */
> +		head = READ_ONCE(os->head);
> +		tail = READ_ONCE(os->tail);
> +		/* just abort if slot is full */
> +		if (tail - head > os->mask)
> +			return -ENOENT;

Is this really possible? The total number of objects must be less euqal to
the os->mask. If it means a bug, please use WARN_ON_ONCE() here for debug.

> +		/* try to extend tail by 1 using CAS to avoid races */
> +		if (try_cmpxchg_acquire(&os->tail, &tail, tail + 1))
> +			break;
> +	} while (1);

"if(cond) ~ break; } while(1)" should be "} (!cond);"

And this seems to be buggy since tail++ can be 0, then "tail - head" < 0.

if (tail < head)
	if (WARN_ON_ONCE(tail + (UINT32_MAX - head) > os->mask))
		return -ENOENT;
else
	if (WARN_ON_ONCE(tail - head > os->mask))
		return -ENOENT;

> +
> +	/* the tail-th of slot is reserved for the given obj */
> +	WRITE_ONCE(ents[tail & os->mask], obj);
> +	/* update epoch id to make this object available for pop() */
> +	smp_store_release(&ages[tail & os->mask], tail);

Note: since the ages array size is the power of 2, this is just a
(32 - os->bits) loop counter. :)

> +	return 0;
> +}
> +
> +/* reclaim an object to object pool */
> +int objpool_push(void *obj, struct objpool_head *oh)
> +{
> +	unsigned long flags;
> +	int cpu, rc;
> +
> +	/* disable local irq to avoid preemption & interruption */
> +	raw_local_irq_save(flags);
> +	cpu = raw_smp_processor_id();
> +	do {
> +		rc = objpool_try_add_slot(obj, oh->cpu_slots[cpu]);
> +		if (!rc)
> +			break;
> +		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
> +	} while (1);

Hmm, as I said, head->capacity >= nr_all_obj, this must not happen,
we can always push it on this CPU's slot, right?

> +	raw_local_irq_restore(flags);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(objpool_push);
> +
> +/* drop the allocated object, rather reclaim it to objpool */
> +int objpool_drop(void *obj, struct objpool_head *head)
> +{
> +	if (!obj || !head)
> +		return -EINVAL;
> +
> +	if (refcount_dec_and_test(&head->ref)) {
> +		objpool_free(head);
> +		return 0;
> +	}
> +
> +	return -EAGAIN;
> +}
> +EXPORT_SYMBOL_GPL(objpool_drop);
> +
> +/* try to retrieve object from slot */
> +static inline void *objpool_try_get_slot(struct objpool_slot *os)
> +{
> +	uint32_t *ages = SLOT_AGES(os);
> +	void **ents = SLOT_ENTS(os);
> +	/* do memory load of head to local head */
> +	uint32_t head = smp_load_acquire(&os->head);
> +
> +	/* loop if slot isn't empty */
> +	while (head != READ_ONCE(os->tail)) {
> +		uint32_t id = head & os->mask, prev = head;
> +
> +		/* do prefetching of object ents */
> +		prefetch(&ents[id]);
> +
> +		/* check whether this item was ready for retrieval */
> +		if (smp_load_acquire(&ages[id]) == head) {

We may not need this check, since we know head != tail and the
sizeof(ages) >= nr_all_objs.

Hmm, I guess we can remove ages[] from the code.

> +			/* node must have been udpated by push() */
> +			void *node = READ_ONCE(ents[id]);

Please use the same word for the same object.
I mean this is not 'node' but 'object'.

> +			/* commit and move forward head of the slot */
> +			if (try_cmpxchg_release(&os->head, &head, head + 1))
> +				return node;
> +			/* head was already updated by others */
> +		}
> +
> +		/* re-load head from memory and continue trying */
> +		head = READ_ONCE(os->head);
> +		/*
> +		 * head stays unchanged, so it's very likely there's an
> +		 * ongoing push() on other cpu nodes but yet not update
> +		 * ages[] to mark it's completion
> +		 */
> +		if (head == prev)
> +			break;

This is OK. If we always push() on the current CPU slot, and pop() from
any cpus, we can try again here if this slot is not current CPU. But that
maybe to much :P

Thank you,

> +	}
> +
> +	return NULL;
> +}
> +
> +/* allocate an object from object pool */
> +void *objpool_pop(struct objpool_head *head)
> +{
> +	unsigned long flags;
> +	int i, cpu;
> +	void *obj = NULL;
> +
> +	/* disable local irq to avoid preemption & interruption */
> +	raw_local_irq_save(flags);
> +
> +	cpu = raw_smp_processor_id();
> +	for (i = 0; i < num_possible_cpus(); i++) {
> +		obj = objpool_try_get_slot(head->cpu_slots[cpu]);
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
> +void objpool_free(struct objpool_head *head)
> +{
> +	if (!head->cpu_slots)
> +		return;
> +
> +	/* release percpu slots */
> +	objpool_fini_percpu_slots(head);
> +
> +	/* call user's cleanup callback if provided */
> +	if (head->release)
> +		head->release(head, head->context);
> +}
> +EXPORT_SYMBOL_GPL(objpool_free);
> +
> +/* drop unused objects and defref objpool for releasing */
> +void objpool_fini(struct objpool_head *head)
> +{
> +	void *nod;
> +
> +	do {
> +		/* grab object from objpool and drop it */
> +		nod = objpool_pop(head);
> +
> +		/* drop the extra ref of objpool */
> +		if (refcount_dec_and_test(&head->ref))
> +			objpool_free(head);
> +	} while (nod);
> +}
> +EXPORT_SYMBOL_GPL(objpool_fini);
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
