Return-Path: <linux-kernel+bounces-42510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C1840263
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B791F223F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF8957865;
	Mon, 29 Jan 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFUQnssh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95C5730C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522835; cv=none; b=dAwdgsRID/VZlVB//V5ccmevPl5ize5A2EPRYjBr9k+LFd0k4otA3A/FLswL1tgAj0viyXF6Eda2dnX+ltw+NojcYxQebdOLmAFMu7KRhZkXAz0Z3wy5eIoi7O66Y89qDSiUR0x3yZijPvEHjSywDx5W6W6JNpwzm225fa6hTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522835; c=relaxed/simple;
	bh=qJin9rn1V448K73thjZg5Bf2l8KIVElbdl9pUYlvWsc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Id02Glzxt5mRPr2UdBcXFo8/vQJLby+MiQTgHzNc/TPL/iUmqwYixMTiccT5UTj/l/PN2reLuibTuIVs14cfCLTp04kfCczXkz6imgz+BO9eiS4cw/m2gGo+o0wZnV4Fw5gxkUQhq7UCVMSudRoeMa3+hvVsn/otyKJmooySOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFUQnssh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff817c96a5so43118537b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706522832; x=1707127632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LogR/Zah+zrx3k9gi8s3U+HMAC7cqgfXE5NI/I6QwMw=;
        b=fFUQnsshqL8Jlw/Dj1rdhiFpYjqX5lXSfUTgZQ8V1MBENcu0fA2GIIoTp0DlxjWQjb
         hcQCP0wQ3SuUrBeamD6jHcQ9r1AjvnC9DSOemy59C04NNcueUSyHe7nj8uZ8k5rYu9/r
         ovHVDIxx8tbLtFDI//PDqR5IU0t8NXzzignPrTHzc4IvyxNmSZeS5l4da8cC3hMxWQ+s
         LpYJGVjapG6W2BHYdcZZFwMMhMvAvjtJJH82TGwtZeEHTsHP4+Ipf6KVZEDsngKzdDKM
         Olj3c+AZIXze6bR8NW1v//epOL0MEfVuFVkNEBVx+jSq75/hgJAVtJt7nz7wUvAw97oq
         rIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706522832; x=1707127632;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LogR/Zah+zrx3k9gi8s3U+HMAC7cqgfXE5NI/I6QwMw=;
        b=OcrJw0v2n7XgmvKX7wYHlII34m2UdQgvwP7orcMGVnE3C213rd8GxWMZWbMgWMEFSY
         K2VzfALaSJQeGhDmBQRplqHrb9Lanty85xqsFDwcM+MiuNBi9aW8hMMbpP01CFmkxiaM
         9ZtvA+4KWcVhPlTAMNGzrdgLvUcJ+Sww3mrzYhFB/9na/0GeaxUABdm450te3X2ld/4A
         BeTbuQJ+BIoERqynin1asQDqCiS3n18/N3qJI6P492HHao3vVNmhnAm+7JRkRXFmXXPD
         19DrAv+JPfj3UFqL9FLtrqLKwphRy0gcGXPC/9DmYD2AZCTGFN28KOs3E3oyzlZ/nxmY
         WNeg==
X-Gm-Message-State: AOJu0YwdP5es4hJ+CzH+ui0DYAVbGhGhaOv/sIM2X1OnGPWPYHlWazgS
	eNJ5jlpp9lxk5RiXw7ErjCH6AyAo1bNub7sMH1Ua506cIvIY9WchUkjcf4jtyI/RPJizOZqR+Q=
	=
X-Google-Smtp-Source: AGHT+IHqTMXqqL2nyM3NecLgr0z5DQRBy+4JtepztXMJYecQ3LButAzydh2nIT281m8MW8DiWUDSDf5MCA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:cb16:eb72:6e81:bff1])
 (user=elver job=sendgmr) by 2002:a05:690c:dd6:b0:5fc:43cb:cb1e with SMTP id
 db22-20020a05690c0dd600b005fc43cbcb1emr1772952ywb.10.1706522832529; Mon, 29
 Jan 2024 02:07:12 -0800 (PST)
Date: Mon, 29 Jan 2024 11:07:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129100708.39460-1-elver@google.com>
Subject: [PATCH v2 1/2] stackdepot: use variable size records for
 non-evictable entries
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

With the introduction of stack depot evictions, each stack record is now
fixed size, so that future reuse after an eviction can safely store
differently sized stack traces. In all cases that do not make use of
evictions, this wastes lots of space.

Fix it by re-introducing variable size stack records (up to the max
allowed size) for entries that will never be evicted. We know if an
entry will never be evicted if the flag STACK_DEPOT_FLAG_GET is not
provided, since a later stack_depot_put() attempt is undefined behavior.

With my current kernel config that enables KASAN and also SLUB owner tracking,
I observe (after a kernel boot) a whopping reduction of 296 stack depot pools,
which translates into 4736 KiB saved. The savings here are from SLUB owner
tracking only, because KASAN generic mode still uses refcounting.

Before:

  pools: 893
  allocations: 29841
  frees: 6524
  in_use: 23317
  freelist_size: 3454

After:

  pools: 597
  refcounted_allocations: 17547
  refcounted_frees: 6477
  refcounted_in_use: 11070
  freelist_size: 3497
  persistent_count: 12163
  persistent_bytes: 1717008

Fixes: 108be8def46e ("lib/stackdepot: allow users to evict stack traces")
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
v2:
* Also remove KMSAN-specific DEPOT_POOLS_CAP (revert bd9d9624b7136).
* Let counters distinguish refcounted and non-refcounted entries.
* Comments.

v1 (since RFC):
* Get rid of new_pool_required to simplify the code.
* Warn on attempts to switch a non-refcounted entry to refcounting.
* Typos.
---
 include/linux/poison.h |   3 +
 lib/stackdepot.c       | 250 +++++++++++++++++++++--------------------
 2 files changed, 130 insertions(+), 123 deletions(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index 27a7dad17eef..1f0ee2459f2a 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -92,4 +92,7 @@
 /********** VFS **********/
 #define VFS_PTR_POISON ((void *)(0xF5 + POISON_POINTER_DELTA))
 
+/********** lib/stackdepot.c **********/
+#define STACK_DEPOT_POISON ((void *)(0xD390 + POISON_POINTER_DELTA))
+
 #endif
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5caa1f566553..8f3b2c84ec2d 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/poison.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -43,17 +44,7 @@
 #define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
 #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
 			       STACK_DEPOT_EXTRA_BITS)
-#if IS_ENABLED(CONFIG_KMSAN) && CONFIG_STACKDEPOT_MAX_FRAMES >= 32
-/*
- * KMSAN is frequently used in fuzzing scenarios and thus saves a lot of stack
- * traces. As KMSAN does not support evicting stack traces from the stack
- * depot, the stack depot capacity might be reached quickly with large stack
- * records. Adjust the maximum number of stack depot pools for this case.
- */
-#define DEPOT_POOLS_CAP (8192 * (CONFIG_STACKDEPOT_MAX_FRAMES / 16))
-#else
 #define DEPOT_POOLS_CAP 8192
-#endif
 #define DEPOT_MAX_POOLS \
 	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
 	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
@@ -93,9 +84,6 @@ struct stack_record {
 	};
 };
 
-#define DEPOT_STACK_RECORD_SIZE \
-	ALIGN(sizeof(struct stack_record), 1 << DEPOT_STACK_ALIGN)
-
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
 static bool __stack_depot_early_init_passed __initdata;
@@ -121,32 +109,31 @@ static void *stack_pools[DEPOT_MAX_POOLS];
 static void *new_pool;
 /* Number of pools in stack_pools. */
 static int pools_num;
+/* Offset to the unused space in the currently used pool. */
+static size_t pool_offset = DEPOT_POOL_SIZE;
 /* Freelist of stack records within stack_pools. */
 static LIST_HEAD(free_stacks);
-/*
- * Stack depot tries to keep an extra pool allocated even before it runs out
- * of space in the currently used pool. This flag marks whether this extra pool
- * needs to be allocated. It has the value 0 when either an extra pool is not
- * yet allocated or if the limit on the number of pools is reached.
- */
-static bool new_pool_required = true;
 /* The lock must be held when performing pool or freelist modifications. */
 static DEFINE_RAW_SPINLOCK(pool_lock);
 
 /* Statistics counters for debugfs. */
 enum depot_counter_id {
-	DEPOT_COUNTER_ALLOCS,
-	DEPOT_COUNTER_FREES,
-	DEPOT_COUNTER_INUSE,
+	DEPOT_COUNTER_REFD_ALLOCS,
+	DEPOT_COUNTER_REFD_FREES,
+	DEPOT_COUNTER_REFD_INUSE,
 	DEPOT_COUNTER_FREELIST_SIZE,
+	DEPOT_COUNTER_PERSIST_COUNT,
+	DEPOT_COUNTER_PERSIST_BYTES,
 	DEPOT_COUNTER_COUNT,
 };
 static long counters[DEPOT_COUNTER_COUNT];
 static const char *const counter_names[] = {
-	[DEPOT_COUNTER_ALLOCS]		= "allocations",
-	[DEPOT_COUNTER_FREES]		= "frees",
-	[DEPOT_COUNTER_INUSE]		= "in_use",
+	[DEPOT_COUNTER_REFD_ALLOCS]	= "refcounted_allocations",
+	[DEPOT_COUNTER_REFD_FREES]	= "refcounted_frees",
+	[DEPOT_COUNTER_REFD_INUSE]	= "refcounted_in_use",
 	[DEPOT_COUNTER_FREELIST_SIZE]	= "freelist_size",
+	[DEPOT_COUNTER_PERSIST_COUNT]	= "persistent_count",
+	[DEPOT_COUNTER_PERSIST_BYTES]	= "persistent_bytes",
 };
 static_assert(ARRAY_SIZE(counter_names) == DEPOT_COUNTER_COUNT);
 
@@ -294,48 +281,52 @@ int stack_depot_init(void)
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
 /*
- * Initializes new stack depot @pool, release all its entries to the freelist,
- * and update the list of pools.
+ * Initializes new stack pool, and updates the list of pools.
  */
-static void depot_init_pool(void *pool)
+static bool depot_init_pool(void **prealloc)
 {
-	int offset;
-
 	lockdep_assert_held(&pool_lock);
 
-	/* Initialize handles and link stack records into the freelist. */
-	for (offset = 0; offset <= DEPOT_POOL_SIZE - DEPOT_STACK_RECORD_SIZE;
-	     offset += DEPOT_STACK_RECORD_SIZE) {
-		struct stack_record *stack = pool + offset;
-
-		stack->handle.pool_index = pools_num;
-		stack->handle.offset = offset >> DEPOT_STACK_ALIGN;
-		stack->handle.extra = 0;
-
-		/*
-		 * Stack traces of size 0 are never saved, and we can simply use
-		 * the size field as an indicator if this is a new unused stack
-		 * record in the freelist.
-		 */
-		stack->size = 0;
+	if (unlikely(pools_num >= DEPOT_MAX_POOLS)) {
+		/* Bail out if we reached the pool limit. */
+		WARN_ON_ONCE(pools_num > DEPOT_MAX_POOLS); /* should never happen */
+		WARN_ON_ONCE(!new_pool); /* to avoid unnecessary pre-allocation */
+		WARN_ONCE(1, "Stack depot reached limit capacity");
+		return false;
+	}
 
-		INIT_LIST_HEAD(&stack->hash_list);
-		/*
-		 * Add to the freelist front to prioritize never-used entries:
-		 * required in case there are entries in the freelist, but their
-		 * RCU cookie still belongs to the current RCU grace period
-		 * (there can still be concurrent readers).
-		 */
-		list_add(&stack->free_list, &free_stacks);
-		counters[DEPOT_COUNTER_FREELIST_SIZE]++;
+	if (!new_pool && *prealloc) {
+		/* We have preallocated memory, use it. */
+		WRITE_ONCE(new_pool, *prealloc);
+		*prealloc = NULL;
 	}
 
+	if (!new_pool)
+		return false; /* new_pool and *prealloc are NULL */
+
 	/* Save reference to the pool to be used by depot_fetch_stack(). */
-	stack_pools[pools_num] = pool;
+	stack_pools[pools_num] = new_pool;
+
+	/*
+	 * Stack depot tries to keep an extra pool allocated even before it runs
+	 * out of space in the currently used pool.
+	 *
+	 * To indicate that a new preallocation is needed new_pool is reset to
+	 * NULL; do not reset to NULL if we have reached the maximum number of
+	 * pools.
+	 */
+	if (pools_num < DEPOT_MAX_POOLS)
+		WRITE_ONCE(new_pool, NULL);
+	else
+		WRITE_ONCE(new_pool, STACK_DEPOT_POISON);
 
 	/* Pairs with concurrent READ_ONCE() in depot_fetch_stack(). */
 	WRITE_ONCE(pools_num, pools_num + 1);
 	ASSERT_EXCLUSIVE_WRITER(pools_num);
+
+	pool_offset = 0;
+
+	return true;
 }
 
 /* Keeps the preallocated memory to be used for a new stack depot pool. */
@@ -347,63 +338,51 @@ static void depot_keep_new_pool(void **prealloc)
 	 * If a new pool is already saved or the maximum number of
 	 * pools is reached, do not use the preallocated memory.
 	 */
-	if (!new_pool_required)
+	if (new_pool)
 		return;
 
-	/*
-	 * Use the preallocated memory for the new pool
-	 * as long as we do not exceed the maximum number of pools.
-	 */
-	if (pools_num < DEPOT_MAX_POOLS) {
-		new_pool = *prealloc;
-		*prealloc = NULL;
-	}
-
-	/*
-	 * At this point, either a new pool is kept or the maximum
-	 * number of pools is reached. In either case, take note that
-	 * keeping another pool is not required.
-	 */
-	WRITE_ONCE(new_pool_required, false);
+	WRITE_ONCE(new_pool, *prealloc);
+	*prealloc = NULL;
 }
 
 /*
- * Try to initialize a new stack depot pool from either a previous or the
- * current pre-allocation, and release all its entries to the freelist.
+ * Try to initialize a new stack record from the current pool, a cached pool, or
+ * the current pre-allocation.
  */
-static bool depot_try_init_pool(void **prealloc)
+static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
 {
+	struct stack_record *stack;
+	void *current_pool;
+	u32 pool_index;
+
 	lockdep_assert_held(&pool_lock);
 
-	/* Check if we have a new pool saved and use it. */
-	if (new_pool) {
-		depot_init_pool(new_pool);
-		new_pool = NULL;
+	if (pool_offset + size > DEPOT_POOL_SIZE) {
+		if (!depot_init_pool(prealloc))
+			return NULL;
+	}
 
-		/* Take note that we might need a new new_pool. */
-		if (pools_num < DEPOT_MAX_POOLS)
-			WRITE_ONCE(new_pool_required, true);
+	if (WARN_ON_ONCE(pools_num < 1))
+		return NULL;
+	pool_index = pools_num - 1;
+	current_pool = stack_pools[pool_index];
+	if (WARN_ON_ONCE(!current_pool))
+		return NULL;
 
-		return true;
-	}
+	stack = current_pool + pool_offset;
 
-	/* Bail out if we reached the pool limit. */
-	if (unlikely(pools_num >= DEPOT_MAX_POOLS)) {
-		WARN_ONCE(1, "Stack depot reached limit capacity");
-		return false;
-	}
+	/* Pre-initialize handle once. */
+	stack->handle.pool_index = pool_index;
+	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
+	stack->handle.extra = 0;
+	INIT_LIST_HEAD(&stack->hash_list);
 
-	/* Check if we have preallocated memory and use it. */
-	if (*prealloc) {
-		depot_init_pool(*prealloc);
-		*prealloc = NULL;
-		return true;
-	}
+	pool_offset += size;
 
-	return false;
+	return stack;
 }
 
-/* Try to find next free usable entry. */
+/* Try to find next free usable entry from the freelist. */
 static struct stack_record *depot_pop_free(void)
 {
 	struct stack_record *stack;
@@ -420,7 +399,7 @@ static struct stack_record *depot_pop_free(void)
 	 * check the first entry.
 	 */
 	stack = list_first_entry(&free_stacks, struct stack_record, free_list);
-	if (stack->size && !poll_state_synchronize_rcu(stack->rcu_state))
+	if (!poll_state_synchronize_rcu(stack->rcu_state))
 		return NULL;
 
 	list_del(&stack->free_list);
@@ -429,48 +408,73 @@ static struct stack_record *depot_pop_free(void)
 	return stack;
 }
 
+static inline size_t depot_stack_record_size(struct stack_record *s, unsigned int nr_entries)
+{
+	const size_t used = flex_array_size(s, entries, nr_entries);
+	const size_t unused = sizeof(s->entries) - used;
+
+	WARN_ON_ONCE(sizeof(s->entries) < used);
+
+	return ALIGN(sizeof(struct stack_record) - unused, 1 << DEPOT_STACK_ALIGN);
+}
+
 /* Allocates a new stack in a stack depot pool. */
 static struct stack_record *
-depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
+depot_alloc_stack(unsigned long *entries, int nr_entries, u32 hash, depot_flags_t flags, void **prealloc)
 {
-	struct stack_record *stack;
+	struct stack_record *stack = NULL;
+	size_t record_size;
 
 	lockdep_assert_held(&pool_lock);
 
 	/* This should already be checked by public API entry points. */
-	if (WARN_ON_ONCE(!size))
+	if (WARN_ON_ONCE(!nr_entries))
 		return NULL;
 
-	/* Check if we have a stack record to save the stack trace. */
-	stack = depot_pop_free();
-	if (!stack) {
-		/* No usable entries on the freelist - try to refill the freelist. */
-		if (!depot_try_init_pool(prealloc))
-			return NULL;
+	/* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. */
+	if (nr_entries > CONFIG_STACKDEPOT_MAX_FRAMES)
+		nr_entries = CONFIG_STACKDEPOT_MAX_FRAMES;
+
+	if (flags & STACK_DEPOT_FLAG_GET) {
+		/*
+		 * Evictable entries have to allocate the max. size so they may
+		 * safely be re-used by differently sized allocations.
+		 */
+		record_size = depot_stack_record_size(stack, CONFIG_STACKDEPOT_MAX_FRAMES);
 		stack = depot_pop_free();
-		if (WARN_ON(!stack))
-			return NULL;
+	} else {
+		record_size = depot_stack_record_size(stack, nr_entries);
 	}
 
-	/* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. */
-	if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
-		size = CONFIG_STACKDEPOT_MAX_FRAMES;
+	if (!stack) {
+		stack = depot_pop_free_pool(prealloc, record_size);
+		if (!stack)
+			return NULL;
+	}
 
 	/* Save the stack trace. */
 	stack->hash = hash;
-	stack->size = size;
-	/* stack->handle is already filled in by depot_init_pool(). */
-	refcount_set(&stack->count, 1);
-	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
+	stack->size = nr_entries;
+	/* stack->handle is already filled in by depot_pop_free_pool(). */
+	memcpy(stack->entries, entries, flex_array_size(stack, entries, nr_entries));
+
+	if (flags & STACK_DEPOT_FLAG_GET) {
+		refcount_set(&stack->count, 1);
+		counters[DEPOT_COUNTER_REFD_ALLOCS]++;
+		counters[DEPOT_COUNTER_REFD_INUSE]++;
+	} else {
+		/* Warn on attempts to switch to refcounting this entry. */
+		refcount_set(&stack->count, REFCOUNT_SATURATED);
+		counters[DEPOT_COUNTER_PERSIST_COUNT]++;
+		counters[DEPOT_COUNTER_PERSIST_BYTES] += record_size;
+	}
 
 	/*
 	 * Let KMSAN know the stored stack record is initialized. This shall
 	 * prevent false positive reports if instrumented code accesses it.
 	 */
-	kmsan_unpoison_memory(stack, DEPOT_STACK_RECORD_SIZE);
+	kmsan_unpoison_memory(stack, record_size);
 
-	counters[DEPOT_COUNTER_ALLOCS]++;
-	counters[DEPOT_COUNTER_INUSE]++;
 	return stack;
 }
 
@@ -538,8 +542,8 @@ static void depot_free_stack(struct stack_record *stack)
 	list_add_tail(&stack->free_list, &free_stacks);
 
 	counters[DEPOT_COUNTER_FREELIST_SIZE]++;
-	counters[DEPOT_COUNTER_FREES]++;
-	counters[DEPOT_COUNTER_INUSE]--;
+	counters[DEPOT_COUNTER_REFD_FREES]++;
+	counters[DEPOT_COUNTER_REFD_INUSE]--;
 
 	printk_deferred_exit();
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
@@ -660,7 +664,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	 * Allocate memory for a new pool if required now:
 	 * we won't be able to do that under the lock.
 	 */
-	if (unlikely(can_alloc && READ_ONCE(new_pool_required))) {
+	if (unlikely(can_alloc && !READ_ONCE(new_pool))) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
@@ -681,7 +685,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	found = find_stack(bucket, entries, nr_entries, hash, depot_flags);
 	if (!found) {
 		struct stack_record *new =
-			depot_alloc_stack(entries, nr_entries, hash, &prealloc);
+			depot_alloc_stack(entries, nr_entries, hash, depot_flags, &prealloc);
 
 		if (new) {
 			/*
-- 
2.43.0.429.g432eaa2c6b-goog


