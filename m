Return-Path: <linux-kernel+bounces-33765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58350836E50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1CF1C23BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B89A5EE76;
	Mon, 22 Jan 2024 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vz21bdLK"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED43D57C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943774; cv=none; b=FNLVzhm5m0z31zndSk8PJWSytEVZuvebVVSVwTXGJz0qq0KGWkCqMwi6KjJim8jafpkwFuvQUfspNqQoocrx/PfNnhTL2yO4rtOzwB/ssowC4Badxa/GZegUVARmRBYJgkwHkg46npko1xuEE7LhDYKSTboSZOxmsM4qLAA8UXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943774; c=relaxed/simple;
	bh=eSXrV3HKgyMlnf1tirSBCKNMtpchJL1nchJ7DsOVBps=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hZAa8AJHfw/+rVqn2Mb3L+Vj6SvbGv7Pgl6wYp+VlfTZOHb0cg8adZKy/2zD9hzAdYJR4WUl7OxqTpUkZZioig/IcNv91VacNr6GGlsYx4LbCab6rhR+o46c4nWe/yTfegKYbUD8pNpbR6unvjMtHGF7ZA/HwORe5JUIwuAX44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vz21bdLK; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-558b84a7eeeso2030526a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705943770; x=1706548570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IeBiO5JIOcbB3aarK4M/MV2q2unRSMAULj52Ob3ZR74=;
        b=vz21bdLKsUSYvX5jzH0+jEQGP21rpg8JscY7jgyjG85B4kW7r3pJPDYRlTH7Kg49vM
         Mn4lu3Jr15gWb9WEyFGTEFUeBso3ID7Cp43Ccp7D5R5dNnjbLIwdLE81N6MIs4o37xVK
         iOeA65VGoBdzbC7OK2IaGZYwmNFSOD8tGLSnE9WL0JkYp8rThBp5/WmSn+Gc7YJfTrzV
         ksOAYsHuLxrWoi89XfoLUc1E5aYdgvn/1drqMIjb/XFlKTPF3B4Z9q4RSqnoqxBcWGdF
         T/Dh0vQhf+BbWxyXEquwHXQceKmMhHxQKe/zN6dEvR9C7fqueiH+tlMIUiHQmpAX6+ul
         SWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705943770; x=1706548570;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IeBiO5JIOcbB3aarK4M/MV2q2unRSMAULj52Ob3ZR74=;
        b=YGNkx+Maiyzfjopx+xHQq665TtS8DULDuLw3Dp3xpRRLVcWYvSL6S6KjkLDVUpuaFW
         x0IG7uNgjFfydQTb2nBnG7lOUl3/UWoGewdavG1o1O2/nqgC9dteNOG8PmHi37Yf8wep
         PE4wNLsMxc7lB/ZE2r6S/jJU+JT8uOh/TBFXnrvPOYc2yIynAMRF4LS3NMYslt1HZ0vF
         12sFWZ2oVmVhWZ+EUijifM0YTz9dLz8OYDWZ1i5p8O26HMGnXeTm2OxbNKh9z7Lp7ZQo
         S872/o2G7BraM+CNobg1mkrvZOfxeWt+YpIXbRXrdUp/+3icgJLC7BBWkcOfeSvIOjd0
         Pbgw==
X-Gm-Message-State: AOJu0YxxxB8imMOTrM46s74ySmvyxEWc9/MDLBjbXj14JomXjyBwYma1
	jObRJPaUBZA9b4NGllfrtcufAo4pl2rAGJxMwHvlOtSGkhEQ7Rg3DS8yrVPzUMS0HQsmfkGz3Q=
	=
X-Google-Smtp-Source: AGHT+IG6FACQXom5w3f7gHO27sxHOSB2FVLWUKGdi4S+O46ejh+lyp6MF71wZTC449rYG1KxBVOV5ggoeA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:511d:f6cb:99a8:ac0d])
 (user=elver job=sendgmr) by 2002:a05:6402:4004:b0:55a:6821:7753 with SMTP id
 d4-20020a056402400400b0055a68217753mr992eda.1.1705943770543; Mon, 22 Jan 2024
 09:16:10 -0800 (PST)
Date: Mon, 22 Jan 2024 18:11:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122171215.319440-2-elver@google.com>
Subject: [RFC PATCH] stackdepot: use variable size records for non-evictable entries
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com
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
  allocations: 29657
  frees: 6425
  in_use: 23232
  freelist_size: 3493

Fixes: 108be8def46e ("lib/stackdepot: allow users to evict stack traces")
Signed-off-by: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---

Sending this out as an early RFC.

We're stilling mulling over what to do with generic KASAN, because stack
depot eviction support was only added due to concern of too much memory
usage.

If this general approach makes sense, then I'd be in favour of just
reverting all the KASAN-generic eviction patches and leaving KASAN-tag
as the only user of evictions.

Thoughts?

---
 lib/stackdepot.c | 163 +++++++++++++++++++++++++----------------------
 1 file changed, 88 insertions(+), 75 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5caa1f566553..726002d2ac09 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -93,9 +93,6 @@ struct stack_record {
 	};
 };
 
-#define DEPOT_STACK_RECORD_SIZE \
-	ALIGN(sizeof(struct stack_record), 1 << DEPOT_STACK_ALIGN)
-
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
 static bool __stack_depot_early_init_passed __initdata;
@@ -121,6 +118,8 @@ static void *stack_pools[DEPOT_MAX_POOLS];
 static void *new_pool;
 /* Number of pools in stack_pools. */
 static int pools_num;
+/* Offset to the unused space in the currently used pool. */
+static size_t pool_offset = DEPOT_POOL_SIZE;
 /* Freelist of stack records within stack_pools. */
 static LIST_HEAD(free_stacks);
 /*
@@ -294,48 +293,44 @@ int stack_depot_init(void)
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
 /*
- * Initializes new stack depot @pool, release all its entries to the freelist,
- * and update the list of pools.
+ * Initializes new stack pool, and update the list of pools.
  */
-static void depot_init_pool(void *pool)
+static bool depot_init_pool(void **prealloc)
 {
-	int offset;
+	void *pool = NULL;
 
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
+	if (new_pool) {
+		/* We have a new pool saved, use it. */
+		pool = new_pool;
+		new_pool = NULL;
 
-		INIT_LIST_HEAD(&stack->hash_list);
-		/*
-		 * Add to the freelist front to prioritize never-used entries:
-		 * required in case there are entries in the freelist, but their
-		 * RCU cookie still belongs to the current RCU grace period
-		 * (there can still be concurrent readers).
-		 */
-		list_add(&stack->free_list, &free_stacks);
-		counters[DEPOT_COUNTER_FREELIST_SIZE]++;
+		/* Take note that we might need a new new_pool. */
+		if (pools_num < DEPOT_MAX_POOLS)
+			WRITE_ONCE(new_pool_required, true);
+	} else if (unlikely(pools_num >= DEPOT_MAX_POOLS)) {
+		/* Bail out if we reached the pool limit. */
+		WARN_ONCE(1, "Stack depot reached limit capacity");
+	} else if (*prealloc) {
+		/* We have preallocated memory, use it. */
+		pool = *prealloc;
+		*prealloc = NULL;
 	}
 
+	if (!pool)
+		return false;
+
 	/* Save reference to the pool to be used by depot_fetch_stack(). */
 	stack_pools[pools_num] = pool;
 
 	/* Pairs with concurrent READ_ONCE() in depot_fetch_stack(). */
 	WRITE_ONCE(pools_num, pools_num + 1);
 	ASSERT_EXCLUSIVE_WRITER(pools_num);
+
+	pool_offset = 0;
+
+	return true;
 }
 
 /* Keeps the preallocated memory to be used for a new stack depot pool. */
@@ -368,39 +363,40 @@ static void depot_keep_new_pool(void **prealloc)
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
 
 /* Try to find next free usable entry. */
@@ -420,7 +416,7 @@ static struct stack_record *depot_pop_free(void)
 	 * check the first entry.
 	 */
 	stack = list_first_entry(&free_stacks, struct stack_record, free_list);
-	if (stack->size && !poll_state_synchronize_rcu(stack->rcu_state))
+	if (!poll_state_synchronize_rcu(stack->rcu_state))
 		return NULL;
 
 	list_del(&stack->free_list);
@@ -429,45 +425,62 @@ static struct stack_record *depot_pop_free(void)
 	return stack;
 }
 
+static inline size_t depot_stack_record_size(struct stack_record *s, size_t nr_entries)
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
+	stack->size = nr_entries;
+	/* stack->handle is already filled in by depot_pop_free_pool(). */
 	refcount_set(&stack->count, 1);
-	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
+	memcpy(stack->entries, entries, flex_array_size(stack, entries, nr_entries));
 
 	/*
 	 * Let KMSAN know the stored stack record is initialized. This shall
 	 * prevent false positive reports if instrumented code accesses it.
 	 */
-	kmsan_unpoison_memory(stack, DEPOT_STACK_RECORD_SIZE);
+	kmsan_unpoison_memory(stack, record_size);
 
 	counters[DEPOT_COUNTER_ALLOCS]++;
 	counters[DEPOT_COUNTER_INUSE]++;
@@ -681,7 +694,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	found = find_stack(bucket, entries, nr_entries, hash, depot_flags);
 	if (!found) {
 		struct stack_record *new =
-			depot_alloc_stack(entries, nr_entries, hash, &prealloc);
+			depot_alloc_stack(entries, nr_entries, hash, depot_flags, &prealloc);
 
 		if (new) {
 			/*
-- 
2.43.0.429.g432eaa2c6b-goog


