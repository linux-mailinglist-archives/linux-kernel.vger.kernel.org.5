Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4105F78CA74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbjH2RNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjH2RM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:12:57 -0400
Received: from out-243.mta1.migadu.com (out-243.mta1.migadu.com [IPv6:2001:41d0:203:375::f3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27221CEB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:12:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VaH0nAjv38F7wcUNXUY6R+pPhb94jTIKfgVe1zCE0Y8=;
        b=W3s6IJQiOTNsLFWQX22lPhTUoCW/6QB06+fYLBi4rvyMjQlY8pZ19z1qHG5iTI4lSOXxc8
        JzhL/UMWrVr1qyOR/ywQgLHEg1XcWVwHXHXc51/PGHp/Ttkp9aeef95fXkmWHkZlAw9eZI
        YwpKJwq1b7mI2IEYsDbLMikoFrHR7d4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 11/15] stackdepot: use read/write lock
Date:   Tue, 29 Aug 2023 19:11:21 +0200
Message-Id: <6db160185d3bd9b3312da4ccc073adcdac58709e.1693328501.git.andreyknvl@google.com>
In-Reply-To: <cover.1693328501.git.andreyknvl@google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Currently, stack depot uses the following locking scheme:

1. Lock-free accesses when looking up a stack record, which allows to
   have multiple users to look up records in parallel;
2. Spinlock for protecting the stack depot pools and the hash table
   when adding a new record.

For implementing the eviction of stack traces from stack depot, the
lock-free approach is not going to work anymore, as we will need to be
able to also remove records from the hash table.

Convert the spinlock into a read/write lock, and drop the atomic accesses,
as they are no longer required.

Looking up stack traces is now protected by the read lock and adding new
records - by the write lock. One of the following patches will add a new
function for evicting stack records, which will be protected by the write
lock as well.

With this change, multiple users can still look up records in parallel.

This is preparatory patch for implementing the eviction of stack records
from the stack depot.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 76 ++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 9011f4adcf20..5ad454367379 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -23,6 +23,7 @@
 #include <linux/percpu.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/stacktrace.h>
 #include <linux/stackdepot.h>
 #include <linux/string.h>
@@ -92,15 +93,15 @@ static void *new_pool;
 static int pools_num;
 /* Next stack in the freelist of stack records within stack_pools. */
 static struct stack_record *next_stack;
-/* Lock that protects the variables above. */
-static DEFINE_RAW_SPINLOCK(pool_lock);
 /*
  * Stack depot tries to keep an extra pool allocated even before it runs out
  * of space in the currently used pool. This flag marks whether this extra pool
  * needs to be allocated. It has the value 0 when either an extra pool is not
  * yet allocated or if the limit on the number of pools is reached.
  */
-static int new_pool_required = 1;
+static bool new_pool_required = true;
+/* Lock that protects the variables above. */
+static DEFINE_RWLOCK(pool_rwlock);
 
 static int __init disable_stack_depot(char *str)
 {
@@ -248,12 +249,7 @@ static void depot_init_pool(void *pool)
 
 	/* Save reference to the pool to be used by depot_fetch_stack. */
 	stack_pools[pools_num] = pool;
-
-	/*
-	 * WRITE_ONCE pairs with potential concurrent read in
-	 * depot_fetch_stack.
-	 */
-	WRITE_ONCE(pools_num, pools_num + 1);
+	pools_num++;
 }
 
 /* Keeps the preallocated memory to be used for a new stack depot pool. */
@@ -262,10 +258,8 @@ static void depot_keep_new_pool(void **prealloc)
 	/*
 	 * If a new pool is already saved or the maximum number of
 	 * pools is reached, do not use the preallocated memory.
-	 * READ_ONCE is only used to mark the variable as atomic,
-	 * there are no concurrent writes.
 	 */
-	if (!READ_ONCE(new_pool_required))
+	if (!new_pool_required)
 		return;
 
 	/*
@@ -281,9 +275,8 @@ static void depot_keep_new_pool(void **prealloc)
 	 * At this point, either a new pool is kept or the maximum
 	 * number of pools is reached. In either case, take note that
 	 * keeping another pool is not required.
-	 * smp_store_release pairs with smp_load_acquire in stack_depot_save.
 	 */
-	smp_store_release(&new_pool_required, 0);
+	new_pool_required = false;
 }
 
 /* Updates refences to the current and the next stack depot pools. */
@@ -300,7 +293,7 @@ static bool depot_update_pools(void **prealloc)
 
 		/* Take note that we might need a new new_pool. */
 		if (pools_num < DEPOT_MAX_POOLS)
-			smp_store_release(&new_pool_required, 1);
+			new_pool_required = true;
 
 		/* Try keeping the preallocated memory for new_pool. */
 		goto out_keep_prealloc;
@@ -369,18 +362,13 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 {
 	union handle_parts parts = { .handle = handle };
-	/*
-	 * READ_ONCE pairs with potential concurrent write in
-	 * depot_init_pool.
-	 */
-	int pools_num_cached = READ_ONCE(pools_num);
 	void *pool;
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
-	if (parts.pool_index > pools_num_cached) {
+	if (parts.pool_index > pools_num) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-			parts.pool_index, pools_num_cached, handle);
+			parts.pool_index, pools_num, handle);
 		return NULL;
 	}
 
@@ -439,6 +427,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	depot_stack_handle_t handle = 0;
 	struct page *page = NULL;
 	void *prealloc = NULL;
+	bool need_alloc = false;
 	unsigned long flags;
 	u32 hash;
 
@@ -458,22 +447,26 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	hash = hash_stack(entries, nr_entries);
 	bucket = &stack_table[hash & stack_hash_mask];
 
-	/*
-	 * Fast path: look the stack trace up without locking.
-	 * smp_load_acquire pairs with smp_store_release to |bucket| below.
-	 */
-	found = find_stack(smp_load_acquire(bucket), entries, nr_entries, hash);
-	if (found)
+	read_lock_irqsave(&pool_rwlock, flags);
+
+	/* Fast path: look the stack trace up without full locking. */
+	found = find_stack(*bucket, entries, nr_entries, hash);
+	if (found) {
+		read_unlock_irqrestore(&pool_rwlock, flags);
 		goto exit;
+	}
+
+	/* Take note if another stack pool needs to be allocated. */
+	if (new_pool_required)
+		need_alloc = true;
+
+	read_unlock_irqrestore(&pool_rwlock, flags);
 
 	/*
-	 * Check if another stack pool needs to be allocated. If so, allocate
-	 * the memory now: we won't be able to do that under the lock.
-	 *
-	 * smp_load_acquire pairs with smp_store_release
-	 * in depot_update_pools and depot_keep_new_pool.
+	 * Allocate memory for a new pool if required now:
+	 * we won't be able to do that under the lock.
 	 */
-	if (unlikely(can_alloc && smp_load_acquire(&new_pool_required))) {
+	if (unlikely(can_alloc && need_alloc)) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
@@ -487,7 +480,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
+	write_lock_irqsave(&pool_rwlock, flags);
 
 	found = find_stack(*bucket, entries, nr_entries, hash);
 	if (!found) {
@@ -496,11 +489,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 
 		if (new) {
 			new->next = *bucket;
-			/*
-			 * smp_store_release pairs with smp_load_acquire
-			 * from |bucket| above.
-			 */
-			smp_store_release(bucket, new);
+			*bucket = new;
 			found = new;
 		}
 	} else if (prealloc) {
@@ -511,7 +500,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		depot_keep_new_pool(&prealloc);
 	}
 
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	write_unlock_irqrestore(&pool_rwlock, flags);
 exit:
 	if (prealloc) {
 		/* Stack depot didn't use this memory, free it. */
@@ -535,6 +524,7 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
 	struct stack_record *stack;
+	unsigned long flags;
 
 	*entries = NULL;
 	/*
@@ -546,8 +536,12 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	if (!handle || stack_depot_disabled)
 		return 0;
 
+	read_lock_irqsave(&pool_rwlock, flags);
+
 	stack = depot_fetch_stack(handle);
 
+	read_unlock_irqrestore(&pool_rwlock, flags);
+
 	*entries = stack->entries;
 	return stack->size;
 }
-- 
2.25.1

