Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E93779F03D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjIMRRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjIMRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:17:12 -0400
Received: from out-222.mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B095D212A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:17:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694625421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6OFfwxwVZx7oqRr59fNDzzOOQmJw0k24eVuDSDilTk=;
        b=iZqHPx4f/wcAAX6htIe3HmT20tHPT3znA2vDH4S/em2UcGFdml1qecOGFN5tBuJcXsaeSs
        NiEGa/AdC8wq/6VxUz6W4Joy5rfNfXtgBfp4X3vBzhkONxZ85SEY4j5PzMbE8moO/6iQxW
        P9SPTh0BEOQwZjBHsaixmdVGcJAg7ZU=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 14/19] lib/stackdepot, kasan: add flags to __stack_depot_save and rename
Date:   Wed, 13 Sep 2023 19:14:39 +0200
Message-Id: <2a161c99c47a45f8e9f7a21a732c60f0cd674a66.1694625260.git.andreyknvl@google.com>
In-Reply-To: <cover.1694625260.git.andreyknvl@google.com>
References: <cover.1694625260.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Change the bool can_alloc argument of __stack_depot_save to a
u32 argument that accepts a set of flags.

The following patch will add another flag to stack_depot_save_flags
besides the existing STACK_DEPOT_FLAG_CAN_ALLOC.

Also rename the function to stack_depot_save_flags, as __stack_depot_save
is a cryptic name,

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- This is a new patch.
---
 include/linux/stackdepot.h | 36 +++++++++++++++++++++++++-----------
 lib/stackdepot.c           | 16 +++++++++++-----
 mm/kasan/common.c          |  7 ++++---
 mm/kasan/generic.c         |  9 +++++----
 mm/kasan/kasan.h           |  2 +-
 mm/kasan/tags.c            |  3 ++-
 6 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index e58306783d8e..0b262e14144e 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -32,6 +32,17 @@ typedef u32 depot_stack_handle_t;
  */
 #define STACK_DEPOT_EXTRA_BITS 5
 
+typedef u32 depot_flags_t;
+
+/*
+ * Flags that can be passed to stack_depot_save_flags(); see the comment next
+ * to its declaration for more details.
+ */
+#define STACK_DEPOT_FLAG_CAN_ALLOC	((depot_flags_t)0x0001)
+
+#define STACK_DEPOT_FLAGS_NUM	1
+#define STACK_DEPOT_FLAGS_MASK	((depot_flags_t)((1 << STACK_DEPOT_FLAGS_NUM) - 1))
+
 /*
  * Using stack depot requires its initialization, which can be done in 3 ways:
  *
@@ -69,31 +80,34 @@ static inline int stack_depot_early_init(void)	{ return 0; }
 #endif
 
 /**
- * __stack_depot_save - Save a stack trace to stack depot
+ * stack_depot_save_flags - Save a stack trace to stack depot
  *
  * @entries:		Pointer to the stack trace
  * @nr_entries:		Number of frames in the stack
  * @alloc_flags:	Allocation GFP flags
- * @can_alloc:		Allocate stack pools (increased chance of failure if false)
+ * @depot_flags:	Stack depot flags
+ *
+ * Saves a stack trace from @entries array of size @nr_entries.
  *
- * Saves a stack trace from @entries array of size @nr_entries. If @can_alloc is
- * %true, stack depot can replenish the stack pools in case no space is left
- * (allocates using GFP flags of @alloc_flags). If @can_alloc is %false, avoids
- * any allocations and fails if no space is left to store the stack trace.
+ * If STACK_DEPOT_FLAG_CAN_ALLOC is set in @depot_flags, stack depot can
+ * replenish the stack pools in case no space is left (allocates using GFP
+ * flags of @alloc_flags). Otherwise, stack depot avoids any allocations and
+ * fails if no space is left to store the stack trace.
  *
  * If the provided stack trace comes from the interrupt context, only the part
  * up to the interrupt entry is saved.
  *
- * Context: Any context, but setting @can_alloc to %false is required if
+ * Context: Any context, but setting STACK_DEPOT_FLAG_CAN_ALLOC is required if
  *          alloc_pages() cannot be used from the current context. Currently
  *          this is the case for contexts where neither %GFP_ATOMIC nor
  *          %GFP_NOWAIT can be used (NMI, raw_spin_lock).
  *
  * Return: Handle of the stack struct stored in depot, 0 on failure
  */
-depot_stack_handle_t __stack_depot_save(unsigned long *entries,
-					unsigned int nr_entries,
-					gfp_t gfp_flags, bool can_alloc);
+depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
+					    unsigned int nr_entries,
+					    gfp_t gfp_flags,
+					    depot_flags_t depot_flags);
 
 /**
  * stack_depot_save - Save a stack trace to stack depot
@@ -103,7 +117,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
  * @alloc_flags:	Allocation GFP flags
  *
  * Context: Contexts where allocations via alloc_pages() are allowed.
- *          See __stack_depot_save() for more details.
+ *          See stack_depot_save_flags() for more details.
  *
  * Return: Handle of the stack trace stored in depot, 0 on failure
  */
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 1b08897ebd2b..e5121225f124 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -438,19 +438,24 @@ static inline struct stack_record *find_stack(struct list_head *bucket,
 	return NULL;
 }
 
-depot_stack_handle_t __stack_depot_save(unsigned long *entries,
-					unsigned int nr_entries,
-					gfp_t alloc_flags, bool can_alloc)
+depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
+					    unsigned int nr_entries,
+					    gfp_t alloc_flags,
+					    depot_flags_t depot_flags)
 {
 	struct list_head *bucket;
 	struct stack_record *found = NULL;
 	depot_stack_handle_t handle = 0;
 	struct page *page = NULL;
 	void *prealloc = NULL;
+	bool can_alloc = depot_flags & STACK_DEPOT_FLAG_CAN_ALLOC;
 	bool need_alloc = false;
 	unsigned long flags;
 	u32 hash;
 
+	if (depot_flags & ~STACK_DEPOT_FLAGS_MASK)
+		return 0;
+
 	/*
 	 * If this stack trace is from an interrupt, including anything before
 	 * interrupt entry usually leads to unbounded stack depot growth.
@@ -529,13 +534,14 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		handle = found->handle.handle;
 	return handle;
 }
-EXPORT_SYMBOL_GPL(__stack_depot_save);
+EXPORT_SYMBOL_GPL(stack_depot_save_flags);
 
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries,
 				      gfp_t alloc_flags)
 {
-	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
+	return stack_depot_save_flags(entries, nr_entries, alloc_flags,
+				      STACK_DEPOT_FLAG_CAN_ALLOC);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 256930da578a..825a0240ec02 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/slab.h>
+#include <linux/stackdepot.h>
 #include <linux/stacktrace.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -37,19 +38,19 @@ struct slab *kasan_addr_to_slab(const void *addr)
 	return NULL;
 }
 
-depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
+depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
-	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
+	return stack_depot_save_flags(entries, nr_entries, flags, depot_flags);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
 {
 	track->pid = current->pid;
-	track->stack = kasan_save_stack(flags, true);
+	track->stack = kasan_save_stack(flags, STACK_DEPOT_FLAG_CAN_ALLOC);
 }
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 4d837ab83f08..5d168c9afb32 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/slab.h>
+#include <linux/stackdepot.h>
 #include <linux/stacktrace.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -472,7 +473,7 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 			sizeof(struct kasan_free_meta) : 0);
 }
 
-static void __kasan_record_aux_stack(void *addr, bool can_alloc)
+static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 {
 	struct slab *slab = kasan_addr_to_slab(addr);
 	struct kmem_cache *cache;
@@ -489,17 +490,17 @@ static void __kasan_record_aux_stack(void *addr, bool can_alloc)
 		return;
 
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(0, can_alloc);
+	alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
 }
 
 void kasan_record_aux_stack(void *addr)
 {
-	return __kasan_record_aux_stack(addr, true);
+	return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC);
 }
 
 void kasan_record_aux_stack_noalloc(void *addr)
 {
-	return __kasan_record_aux_stack(addr, false);
+	return __kasan_record_aux_stack(addr, 0);
 }
 
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index f70e3d7a602e..de3206e11888 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -370,7 +370,7 @@ static inline void kasan_init_cache_meta(struct kmem_cache *cache, unsigned int
 static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *object) { }
 #endif
 
-depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
+depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
 void kasan_save_free_info(struct kmem_cache *cache, void *object);
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 7dcfe341d48e..4fd32121b0fd 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -13,6 +13,7 @@
 #include <linux/memblock.h>
 #include <linux/memory.h>
 #include <linux/mm.h>
+#include <linux/stackdepot.h>
 #include <linux/static_key.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -101,7 +102,7 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	struct kasan_stack_ring_entry *entry;
 	void *old_ptr;
 
-	stack = kasan_save_stack(gfp_flags, true);
+	stack = kasan_save_stack(gfp_flags, STACK_DEPOT_FLAG_CAN_ALLOC);
 
 	/*
 	 * Prevent save_stack_info() from modifying stack ring
-- 
2.25.1

