Return-Path: <linux-kernel+bounces-30024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C638317FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6B228B9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F1C241F2;
	Thu, 18 Jan 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7tx5lo8"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A724214
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575748; cv=none; b=pQjprccTTEGMY85G7cEtMLWHPNiyNAm4SSwf8FoLjOgrl9yV6lk6e4CUdOxyNs+YDklWoVhsF54o7MOGr+CnBDBkhie2dt+pA8h2nKF/u4wMLMw52lFOZoAIMWeq8ogDc/PTiBAP1nq6iLsAhZKJVpGnPGruOk5zAKALsyDhnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575748; c=relaxed/simple;
	bh=cOlU9is5EgRdvUrV2P05nJEHAc4LJ/D5kFs4vECAuO0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type; b=Sp5osFCpfMGxAWzRDqqc/VM0ZUbBsbXFVbljP/JQfzi6JzXdBlWfYQE51AB4S0dvAG3bo3HUMLnrMfl5JdzZyjJspbI2zVqZl6IkxrkrJe/V1VT0KQA2KAIkn5CCf24FKVua/XMr7Bemiu9VTDz8Jwj4aHujyNJXFhj0PXX8uLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7tx5lo8; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-558b96568easo3550023a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705575744; x=1706180544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKCbla7ykmCxZ5zRnAg5LQd/i5SeGGTvEB8R+tet9MU=;
        b=S7tx5lo8rFDJvsW+BYrkL+ea1Qyio+7KqcSoRSXqGNSd9Bp72ts8MtuVtngpHI3lWl
         LuV8NNOD+hrAhSKm8YZbIHehGUq2NrlJ+Dvei7UTDZ29ucVuCCp4fuIKJ/i93Vcl3Bw+
         d7FpcOntKGowzmsE84M0hf6cGVmmd1AJWqzge9klrx7yjj3wg9PyiyxSc22zonnMk7Ol
         XXBMa1R0PLEeksyi3gA1oUVkpjxoPwn6FatAG/U1Xa3EaUl2MYuOIcihzEZ7B39XxiVl
         u/TwQ0y5oqav9RD+svrMclPjIG9mSqngKv+2ZkF++QU4QhFAO9mcyUzyufOENqJVqD40
         vPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705575744; x=1706180544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKCbla7ykmCxZ5zRnAg5LQd/i5SeGGTvEB8R+tet9MU=;
        b=R8DvdPiK3jdZonoi6fV5J9PY97yRSaKNBBq2QCgjyujELzTK318szWN+1u1a6YNlMc
         KvjE3tpewIuVqeFylW1+hAeFnTLWUhUqgppmMLh5VXjfywERb7XFNgcuqwf0I6FX4/KA
         aeTUB9Pj/ltiXw4LdWTwdTq9MHT/nMZDWJCAczlQVam3tRMpXbkG3+lYoDG8eNgcDDkZ
         fwBRoNhrqwAZ5IOVHYNEp6aQFFMxJGyLXQLA5XxBBgmbkDsOMWBZNe7YAhmtRnAw8/1P
         Vf6lmDhZD+IS18LHkmZ0HGRLMWHJWSlU7HsxmjwrmrRJfIKKBgmKFjtwSfEe9kAw/1TP
         eo+w==
X-Gm-Message-State: AOJu0YwkgePe8sxQQcI7p6FvFBd1jARkCSBFR9SQ/Puv/2dHKj1UeST6
	ZN/41BtxXhieIkTSmrIt22APYLPCxI5PCP7iuAs2TKkcVLtOTgO977VHw406NzoQ4OVkYZOZsw=
	=
X-Google-Smtp-Source: AGHT+IFmFydOdCd3RRupJqB5A7Yzx1aMQHRGcVconpRXxtmgtGB7PxOGBXaDID/29YMSGspD0qAjXHvcWw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:9d7e:25fb:9605:2bef])
 (user=elver job=sendgmr) by 2002:a05:6402:370f:b0:559:dc85:8f4d with SMTP id
 ek15-20020a056402370f00b00559dc858f4dmr4715edb.6.1705575744719; Thu, 18 Jan
 2024 03:02:24 -0800 (PST)
Date: Thu, 18 Jan 2024 12:01:30 +0100
In-Reply-To: <20240118110216.2539519-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240118110216.2539519-1-elver@google.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118110216.2539519-2-elver@google.com>
Subject: [PATCH 2/2] stackdepot: make fast paths lock-less again
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

With the introduction of the pool_rwlock (reader-writer lock), several
fast paths end up taking the pool_rwlock as readers. Furthermore,
stack_depot_put() unconditionally takes the pool_rwlock as a writer.

Despite allowing readers to make forward-progress concurrently,
reader-writer locks have inherent cache contention issues, which does
not scale well on systems with large CPU counts.

Rework the synchronization story of stack depot to again avoid taking
any locks in the fast paths. This is done by relying on RCU-protected
list traversal, and the NMI-safe subset of RCU to delay reuse of freed
stack records. See code comments for more details.

Along with the performance issues, this also fixes incorrect nesting of
rwlock within a raw_spinlock, given that stack depot should still be
usable from anywhere:

 | [ BUG: Invalid wait context ]
 | -----------------------------
 | swapper/0/1 is trying to lock:
 | ffffffff89869be8 (pool_rwlock){..--}-{3:3}, at: stack_depot_save_flags
 | other info that might help us debug this:
 | context-{5:5}
 | 2 locks held by swapper/0/1:
 |  #0: ffffffff89632440 (rcu_read_lock){....}-{1:3}, at: __queue_work
 |  #1: ffff888100092018 (&pool->lock){-.-.}-{2:2}, at: __queue_work  <-- raw_spin_lock

Stack depot usage stats are similar to the previous version after a
KASAN kernel boot:

 $ cat /sys/kernel/debug/stackdepot/stats
 pools: 838
 allocations: 29865
 frees: 6604
 in_use: 23261
 freelist_size: 1879

The number of pools is the same as previously. The freelist size is
minimally larger, but this may also be due to variance across system
boots. This shows that even though we do not eagerly wait for the next
RCU grace period (such as with synchronize_rcu() or call_rcu()) after
freeing a stack record - requiring depot_pop_free() to "poll" if an
entry may be used - new allocations are very likely to happen in later
RCU grace periods.

Fixes: 108be8def46e ("lib/stackdepot: allow users to evict stack traces")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
v1 (change since RFC):
* Remove smp_mb() in find_stack() - there still exists a dependency
  chain from the rcu_dereference(), through read of the handle, to use
  of the handle to recompute the stack record pointer - and later
  accesses are therefore ordered through the dependency-chain.
* Use rcu_read_lock_sched_notrace() to avoid recursion, because
  stackdepot may be called through KMSAN anywhere.
* Fix and add some comments.
---
 lib/stackdepot.c | 322 +++++++++++++++++++++++++++++++----------------
 1 file changed, 211 insertions(+), 111 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 80a8ca24ccc8..5caa1f566553 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -22,8 +22,9 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
-#include <linux/percpu.h>
 #include <linux/printk.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -68,12 +69,28 @@ union handle_parts {
 };
 
 struct stack_record {
-	struct list_head list;		/* Links in hash table or freelist */
+	struct list_head hash_list;	/* Links in the hash table */
 	u32 hash;			/* Hash in hash table */
 	u32 size;			/* Number of stored frames */
-	union handle_parts handle;
+	union handle_parts handle;	/* Constant after initialization */
 	refcount_t count;
-	unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
+	union {
+		unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
+		struct {
+			/*
+			 * An important invariant of the implementation is to
+			 * only place a stack record onto the freelist iff its
+			 * refcount is zero. Because stack records with a zero
+			 * refcount are never considered as valid, it is safe to
+			 * union @entries and freelist management state below.
+			 * Conversely, as soon as an entry is off the freelist
+			 * and its refcount becomes non-zero, the below must not
+			 * be accessed until being placed back on the freelist.
+			 */
+			struct list_head free_list;	/* Links in the freelist */
+			unsigned long rcu_state;	/* RCU cookie */
+		};
+	};
 };
 
 #define DEPOT_STACK_RECORD_SIZE \
@@ -113,8 +130,8 @@ static LIST_HEAD(free_stacks);
  * yet allocated or if the limit on the number of pools is reached.
  */
 static bool new_pool_required = true;
-/* Lock that protects the variables above. */
-static DEFINE_RWLOCK(pool_rwlock);
+/* The lock must be held when performing pool or freelist modifications. */
+static DEFINE_RAW_SPINLOCK(pool_lock);
 
 /* Statistics counters for debugfs. */
 enum depot_counter_id {
@@ -276,14 +293,15 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
-/* Initializes a stack depol pool. */
+/*
+ * Initializes new stack depot @pool, release all its entries to the freelist,
+ * and update the list of pools.
+ */
 static void depot_init_pool(void *pool)
 {
 	int offset;
 
-	lockdep_assert_held_write(&pool_rwlock);
-
-	WARN_ON(!list_empty(&free_stacks));
+	lockdep_assert_held(&pool_lock);
 
 	/* Initialize handles and link stack records into the freelist. */
 	for (offset = 0; offset <= DEPOT_POOL_SIZE - DEPOT_STACK_RECORD_SIZE;
@@ -294,19 +312,36 @@ static void depot_init_pool(void *pool)
 		stack->handle.offset = offset >> DEPOT_STACK_ALIGN;
 		stack->handle.extra = 0;
 
-		list_add(&stack->list, &free_stacks);
+		/*
+		 * Stack traces of size 0 are never saved, and we can simply use
+		 * the size field as an indicator if this is a new unused stack
+		 * record in the freelist.
+		 */
+		stack->size = 0;
+
+		INIT_LIST_HEAD(&stack->hash_list);
+		/*
+		 * Add to the freelist front to prioritize never-used entries:
+		 * required in case there are entries in the freelist, but their
+		 * RCU cookie still belongs to the current RCU grace period
+		 * (there can still be concurrent readers).
+		 */
+		list_add(&stack->free_list, &free_stacks);
 		counters[DEPOT_COUNTER_FREELIST_SIZE]++;
 	}
 
 	/* Save reference to the pool to be used by depot_fetch_stack(). */
 	stack_pools[pools_num] = pool;
-	pools_num++;
+
+	/* Pairs with concurrent READ_ONCE() in depot_fetch_stack(). */
+	WRITE_ONCE(pools_num, pools_num + 1);
+	ASSERT_EXCLUSIVE_WRITER(pools_num);
 }
 
 /* Keeps the preallocated memory to be used for a new stack depot pool. */
 static void depot_keep_new_pool(void **prealloc)
 {
-	lockdep_assert_held_write(&pool_rwlock);
+	lockdep_assert_held(&pool_lock);
 
 	/*
 	 * If a new pool is already saved or the maximum number of
@@ -329,17 +364,16 @@ static void depot_keep_new_pool(void **prealloc)
 	 * number of pools is reached. In either case, take note that
 	 * keeping another pool is not required.
 	 */
-	new_pool_required = false;
+	WRITE_ONCE(new_pool_required, false);
 }
 
-/* Updates references to the current and the next stack depot pools. */
-static bool depot_update_pools(void **prealloc)
+/*
+ * Try to initialize a new stack depot pool from either a previous or the
+ * current pre-allocation, and release all its entries to the freelist.
+ */
+static bool depot_try_init_pool(void **prealloc)
 {
-	lockdep_assert_held_write(&pool_rwlock);
-
-	/* Check if we still have objects in the freelist. */
-	if (!list_empty(&free_stacks))
-		goto out_keep_prealloc;
+	lockdep_assert_held(&pool_lock);
 
 	/* Check if we have a new pool saved and use it. */
 	if (new_pool) {
@@ -348,10 +382,9 @@ static bool depot_update_pools(void **prealloc)
 
 		/* Take note that we might need a new new_pool. */
 		if (pools_num < DEPOT_MAX_POOLS)
-			new_pool_required = true;
+			WRITE_ONCE(new_pool_required, true);
 
-		/* Try keeping the preallocated memory for new_pool. */
-		goto out_keep_prealloc;
+		return true;
 	}
 
 	/* Bail out if we reached the pool limit. */
@@ -368,12 +401,32 @@ static bool depot_update_pools(void **prealloc)
 	}
 
 	return false;
+}
+
+/* Try to find next free usable entry. */
+static struct stack_record *depot_pop_free(void)
+{
+	struct stack_record *stack;
 
-out_keep_prealloc:
-	/* Keep the preallocated memory for a new pool if required. */
-	if (*prealloc)
-		depot_keep_new_pool(prealloc);
-	return true;
+	lockdep_assert_held(&pool_lock);
+
+	if (list_empty(&free_stacks))
+		return NULL;
+
+	/*
+	 * We maintain the invariant that the elements in front are least
+	 * recently used, and are therefore more likely to be associated with an
+	 * RCU grace period in the past. Consequently it is sufficient to only
+	 * check the first entry.
+	 */
+	stack = list_first_entry(&free_stacks, struct stack_record, free_list);
+	if (stack->size && !poll_state_synchronize_rcu(stack->rcu_state))
+		return NULL;
+
+	list_del(&stack->free_list);
+	counters[DEPOT_COUNTER_FREELIST_SIZE]--;
+
+	return stack;
 }
 
 /* Allocates a new stack in a stack depot pool. */
@@ -382,20 +435,22 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 {
 	struct stack_record *stack;
 
-	lockdep_assert_held_write(&pool_rwlock);
+	lockdep_assert_held(&pool_lock);
 
-	/* Update current and new pools if required and possible. */
-	if (!depot_update_pools(prealloc))
+	/* This should already be checked by public API entry points. */
+	if (WARN_ON_ONCE(!size))
 		return NULL;
 
 	/* Check if we have a stack record to save the stack trace. */
-	if (list_empty(&free_stacks))
-		return NULL;
-
-	/* Get and unlink the first entry from the freelist. */
-	stack = list_first_entry(&free_stacks, struct stack_record, list);
-	list_del(&stack->list);
-	counters[DEPOT_COUNTER_FREELIST_SIZE]--;
+	stack = depot_pop_free();
+	if (!stack) {
+		/* No usable entries on the freelist - try to refill the freelist. */
+		if (!depot_try_init_pool(prealloc))
+			return NULL;
+		stack = depot_pop_free();
+		if (WARN_ON(!stack))
+			return NULL;
+	}
 
 	/* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. */
 	if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
@@ -421,37 +476,73 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 
 static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 {
+	const int pools_num_cached = READ_ONCE(pools_num);
 	union handle_parts parts = { .handle = handle };
 	void *pool;
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
-	lockdep_assert_held(&pool_rwlock);
+	lockdep_assert_not_held(&pool_lock);
 
-	if (parts.pool_index > pools_num) {
+	if (parts.pool_index > pools_num_cached) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-		     parts.pool_index, pools_num, handle);
+		     parts.pool_index, pools_num_cached, handle);
 		return NULL;
 	}
 
 	pool = stack_pools[parts.pool_index];
-	if (!pool)
+	if (WARN_ON(!pool))
 		return NULL;
 
 	stack = pool + offset;
+	if (WARN_ON(!refcount_read(&stack->count)))
+		return NULL;
+
 	return stack;
 }
 
 /* Links stack into the freelist. */
 static void depot_free_stack(struct stack_record *stack)
 {
-	lockdep_assert_held_write(&pool_rwlock);
+	unsigned long flags;
+
+	lockdep_assert_not_held(&pool_lock);
+
+	raw_spin_lock_irqsave(&pool_lock, flags);
+	printk_deferred_enter();
 
-	list_add(&stack->list, &free_stacks);
+	/*
+	 * Remove the entry from the hash list. Concurrent list traversal may
+	 * still observe the entry, but since the refcount is zero, this entry
+	 * will no longer be considered as valid.
+	 */
+	list_del_rcu(&stack->hash_list);
+
+	/*
+	 * Due to being used from constrained contexts such as the allocators,
+	 * NMI, or even RCU itself, stack depot cannot rely on primitives that
+	 * would sleep (such as synchronize_rcu()) or recursively call into
+	 * stack depot again (such as call_rcu()).
+	 *
+	 * Instead, get an RCU cookie, so that we can ensure this entry isn't
+	 * moved onto another list until the next grace period, and concurrent
+	 * RCU list traversal remains safe.
+	 */
+	stack->rcu_state = get_state_synchronize_rcu();
+
+	/*
+	 * Add the entry to the freelist tail, so that older entries are
+	 * considered first - their RCU cookie is more likely to no longer be
+	 * associated with the current grace period.
+	 */
+	list_add_tail(&stack->free_list, &free_stacks);
 
 	counters[DEPOT_COUNTER_FREELIST_SIZE]++;
 	counters[DEPOT_COUNTER_FREES]++;
 	counters[DEPOT_COUNTER_INUSE]--;
+
+	printk_deferred_exit();
+	raw_spin_unlock_irqrestore(&pool_lock, flags);
 }
 
 /* Calculates the hash for a stack. */
@@ -479,22 +570,52 @@ int stackdepot_memcmp(const unsigned long *u1, const unsigned long *u2,
 
 /* Finds a stack in a bucket of the hash table. */
 static inline struct stack_record *find_stack(struct list_head *bucket,
-					     unsigned long *entries, int size,
-					     u32 hash)
+					      unsigned long *entries, int size,
+					      u32 hash, depot_flags_t flags)
 {
-	struct list_head *pos;
-	struct stack_record *found;
+	struct stack_record *stack, *ret = NULL;
+
+	/*
+	 * Stack depot may be used from instrumentation that instruments RCU or
+	 * tracing itself; use variant that does not call into RCU and cannot be
+	 * traced.
+	 *
+	 * Note: Such use cases must take care when using refcounting to evict
+	 * unused entries, because the stack record free-then-reuse code paths
+	 * do call into RCU.
+	 */
+	rcu_read_lock_sched_notrace();
+
+	list_for_each_entry_rcu(stack, bucket, hash_list) {
+		if (stack->hash != hash || stack->size != size)
+			continue;
 
-	lockdep_assert_held(&pool_rwlock);
+		/*
+		 * This may race with depot_free_stack() accessing the freelist
+		 * management state unioned with @entries. The refcount is zero
+		 * in that case and the below refcount_inc_not_zero() will fail.
+		 */
+		if (data_race(stackdepot_memcmp(entries, stack->entries, size)))
+			continue;
 
-	list_for_each(pos, bucket) {
-		found = list_entry(pos, struct stack_record, list);
-		if (found->hash == hash &&
-		    found->size == size &&
-		    !stackdepot_memcmp(entries, found->entries, size))
-			return found;
+		/*
+		 * Try to increment refcount. If this succeeds, the stack record
+		 * is valid and has not yet been freed.
+		 *
+		 * If STACK_DEPOT_FLAG_GET is not used, it is undefined behavior
+		 * to then call stack_depot_put() later, and we can assume that
+		 * a stack record is never placed back on the freelist.
+		 */
+		if ((flags & STACK_DEPOT_FLAG_GET) && !refcount_inc_not_zero(&stack->count))
+			continue;
+
+		ret = stack;
+		break;
 	}
-	return NULL;
+
+	rcu_read_unlock_sched_notrace();
+
+	return ret;
 }
 
 depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
@@ -508,7 +629,6 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	struct page *page = NULL;
 	void *prealloc = NULL;
 	bool can_alloc = depot_flags & STACK_DEPOT_FLAG_CAN_ALLOC;
-	bool need_alloc = false;
 	unsigned long flags;
 	u32 hash;
 
@@ -531,31 +651,16 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	hash = hash_stack(entries, nr_entries);
 	bucket = &stack_table[hash & stack_hash_mask];
 
-	read_lock_irqsave(&pool_rwlock, flags);
-	printk_deferred_enter();
-
-	/* Fast path: look the stack trace up without full locking. */
-	found = find_stack(bucket, entries, nr_entries, hash);
-	if (found) {
-		if (depot_flags & STACK_DEPOT_FLAG_GET)
-			refcount_inc(&found->count);
-		printk_deferred_exit();
-		read_unlock_irqrestore(&pool_rwlock, flags);
+	/* Fast path: look the stack trace up without locking. */
+	found = find_stack(bucket, entries, nr_entries, hash, depot_flags);
+	if (found)
 		goto exit;
-	}
-
-	/* Take note if another stack pool needs to be allocated. */
-	if (new_pool_required)
-		need_alloc = true;
-
-	printk_deferred_exit();
-	read_unlock_irqrestore(&pool_rwlock, flags);
 
 	/*
 	 * Allocate memory for a new pool if required now:
 	 * we won't be able to do that under the lock.
 	 */
-	if (unlikely(can_alloc && need_alloc)) {
+	if (unlikely(can_alloc && READ_ONCE(new_pool_required))) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
@@ -569,31 +674,36 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	write_lock_irqsave(&pool_rwlock, flags);
+	raw_spin_lock_irqsave(&pool_lock, flags);
 	printk_deferred_enter();
 
-	found = find_stack(bucket, entries, nr_entries, hash);
+	/* Try to find again, to avoid concurrently inserting duplicates. */
+	found = find_stack(bucket, entries, nr_entries, hash, depot_flags);
 	if (!found) {
 		struct stack_record *new =
 			depot_alloc_stack(entries, nr_entries, hash, &prealloc);
 
 		if (new) {
-			list_add(&new->list, bucket);
+			/*
+			 * This releases the stack record into the bucket and
+			 * makes it visible to readers in find_stack().
+			 */
+			list_add_rcu(&new->hash_list, bucket);
 			found = new;
 		}
-	} else {
-		if (depot_flags & STACK_DEPOT_FLAG_GET)
-			refcount_inc(&found->count);
+	}
+
+	if (prealloc) {
 		/*
-		 * Stack depot already contains this stack trace, but let's
-		 * keep the preallocated memory for future.
+		 * Either stack depot already contains this stack trace, or
+		 * depot_alloc_stack() did not consume the preallocated memory.
+		 * Try to keep the preallocated memory for future.
 		 */
-		if (prealloc)
-			depot_keep_new_pool(&prealloc);
+		depot_keep_new_pool(&prealloc);
 	}
 
 	printk_deferred_exit();
-	write_unlock_irqrestore(&pool_rwlock, flags);
+	raw_spin_unlock_irqrestore(&pool_lock, flags);
 exit:
 	if (prealloc) {
 		/* Stack depot didn't use this memory, free it. */
@@ -618,7 +728,6 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
 	struct stack_record *stack;
-	unsigned long flags;
 
 	*entries = NULL;
 	/*
@@ -630,13 +739,13 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	if (!handle || stack_depot_disabled)
 		return 0;
 
-	read_lock_irqsave(&pool_rwlock, flags);
-	printk_deferred_enter();
-
 	stack = depot_fetch_stack(handle);
-
-	printk_deferred_exit();
-	read_unlock_irqrestore(&pool_rwlock, flags);
+	/*
+	 * Should never be NULL, otherwise this is a use-after-put (or just a
+	 * corrupt handle).
+	 */
+	if (WARN(!stack, "corrupt handle or use after stack_depot_put()"))
+		return 0;
 
 	*entries = stack->entries;
 	return stack->size;
@@ -646,29 +755,20 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
 void stack_depot_put(depot_stack_handle_t handle)
 {
 	struct stack_record *stack;
-	unsigned long flags;
 
 	if (!handle || stack_depot_disabled)
 		return;
 
-	write_lock_irqsave(&pool_rwlock, flags);
-	printk_deferred_enter();
-
 	stack = depot_fetch_stack(handle);
-	if (WARN_ON(!stack))
-		goto out;
-
-	if (refcount_dec_and_test(&stack->count)) {
-		/* Unlink stack from the hash table. */
-		list_del(&stack->list);
+	/*
+	 * Should always be able to find the stack record, otherwise this is an
+	 * unbalanced put attempt (or corrupt handle).
+	 */
+	if (WARN(!stack, "corrupt handle or unbalanced stack_depot_put()"))
+		return;
 
-		/* Free stack. */
+	if (refcount_dec_and_test(&stack->count))
 		depot_free_stack(stack);
-	}
-
-out:
-	printk_deferred_exit();
-	write_unlock_irqrestore(&pool_rwlock, flags);
 }
 EXPORT_SYMBOL_GPL(stack_depot_put);
 
-- 
2.43.0.381.gb435a96ce8-goog


