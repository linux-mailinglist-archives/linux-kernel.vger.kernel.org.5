Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8F7A1D01
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjIOLBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjIOLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:00:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F7CD4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81a76a11eeso1468807276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775606; x=1695380406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwMqMOgZczlkXIp265D11obkAY0m5SEDJnzDVowAfdI=;
        b=vih8/iziYYW1X/tOkqfJNNWkbxGwS582WfHF/U0hzSVobzgMFe6aYnD76g1QnbuGnk
         g1bc2qZqtx/e16WL8CopzT/rFha1+XGgPECljvJO96C/q+wpuXIqpITO5FuqNCLRWCzs
         WmcDjmFhdAmwnmZWPrW16Tn3t+dog07QXRL7wIP7X8JmqGYeCQO+N1ipUH2xbFWO2dGr
         4PuRQ5dW4XowqGIKv1pDUpNEd+IWs4zzEvOl9/LdbRbXOfKmAROiCyGA5Z6SXuT4Neux
         HqVqRqwc4beAZDmvmCeYkK5VrSUTSr3WOF0B+LoW1JtQcCLN0qwY8LVeS8JvVrTL2bvT
         NLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775606; x=1695380406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwMqMOgZczlkXIp265D11obkAY0m5SEDJnzDVowAfdI=;
        b=rYZw+oOf2S8A0+s1nzMeu8rvxfdHiZWIEzZUuwwrw1OvHV2K7nZ3QKTSKOP4/OgrbY
         PoDjPq3T7x+zhQDMCo5GQQ+n53J7yeUDmRKxQicjC5QF4FOAR6vcd2KKyVBq/QXjoiRu
         8oRunFAj5FIbRY+6XopkPeLY9yEHDYG7Ai3Ar/eSzW0q27QLBoMFCsCSvHVq9XiY13GR
         7AcWROH9IcL8OgDlrkHVrT8rzIekMBq+DtFyvusY4i3vb7nkLaASK2xfHLpB0dXYigBg
         s+a06UmG9q8+ZjR+/CDlZBidoZvnisu2ptU/p9s6KkJzDcmMLasrCLoDvSBJaLhnGPb3
         u43A==
X-Gm-Message-State: AOJu0YwE7bgH5REafr+zp1kBrbIZy8n9zx747/TkhjtUH+a16n2l9svW
        70dsITiu7Bt3Zzcy0MQQ36Tflz8Zszv9VICtig==
X-Google-Smtp-Source: AGHT+IEZscvrc96V1gn1BF986Tuf/VhyLh041S+hHsJVTGzLN4PjtlTEnpTINuRLJ+4zXNfGiWlDrchNDKphRD7cog==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a05:6902:1341:b0:d80:cf4:7e80 with
 SMTP id g1-20020a056902134100b00d800cf47e80mr23456ybu.7.1694775606539; Fri,
 15 Sep 2023 04:00:06 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:30 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-12-matteorizzo@google.com>
Subject: [RFC PATCH 11/14] mm/slub: allocate slabs from virtual memory
From:   Matteo Rizzo <matteorizzo@google.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, matteorizzo@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

This is the main implementation of SLAB_VIRTUAL. With SLAB_VIRTUAL
enabled, slab memory is not allocated from the linear map but from a
dedicated region of virtual memory. The code ensures that once a range
of virtual addresses is assigned to a slab cache, that virtual memory is
never reused again except for other slabs in that same cache. This lets
us mitigate some exploits for use-after-free vulnerabilities where the
attacker makes SLUB release a slab page to the page allocator and then
makes it reuse that same page for a different slab cache ("cross-cache
attacks").

With SLAB_VIRTUAL enabled struct slab no longer overlaps struct page but
instead it is allocated from a dedicated region of virtual memory. This
makes it possible to have references to slabs whose physical memory has
been freed.

SLAB_VIRTUAL has a small performance overhead, about 1-2% on kernel
compilation time. We are using 4 KiB pages to map slab pages and slab
metadata area, instead of the 2 MiB pages that the kernel uses to map
the physmap. We experimented with a version of the patch that uses 2 MiB
pages and we did see some performance improvement but the code also
became much more complicated and ugly because we would need to allocate
and free multiple slabs at once.

In addition to the TLB contention, SLAB_VIRTUAL also adds new locks to
the slow path of the allocator. Lock contention also contributes to the
performance penalty to some extent, and this is more visible on machines
with many CPUs.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 arch/x86/include/asm/page_64.h          |  10 +
 arch/x86/include/asm/pgtable_64_types.h |   5 +
 arch/x86/mm/physaddr.c                  |  10 +
 include/linux/slab.h                    |   7 +
 init/main.c                             |   1 +
 mm/slab.h                               | 106 ++++++
 mm/slab_common.c                        |   4 +
 mm/slub.c                               | 439 +++++++++++++++++++++++-
 mm/usercopy.c                           |  12 +-
 9 files changed, 587 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..25fb734a2fe6 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_PAGE_64_H
 
 #include <asm/page_64_types.h>
+#include <asm/pgtable_types.h>
 
 #ifndef __ASSEMBLY__
 #include <asm/cpufeatures.h>
@@ -18,10 +19,19 @@ extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
 
+#ifdef CONFIG_SLAB_VIRTUAL
+unsigned long slab_virt_to_phys(unsigned long x);
+#endif
+
 static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
 	unsigned long y = x - __START_KERNEL_map;
 
+#ifdef CONFIG_SLAB_VIRTUAL
+	if (is_slab_addr(x))
+		return slab_virt_to_phys(x);
+#endif
+
 	/* use the carry flag to determine if x was < __START_KERNEL_map */
 	x = y + ((x > y) ? phys_base : (__START_KERNEL_map - PAGE_OFFSET));
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index e1a91eb084c4..4aae822a6a96 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -213,6 +213,11 @@ extern unsigned int ptrs_per_p4d;
 #define SLAB_VPAGES ((SLAB_END_ADDR - SLAB_BASE_ADDR) / PAGE_SIZE)
 #define SLAB_META_SIZE ALIGN(SLAB_VPAGES * STRUCT_SLAB_SIZE, PAGE_SIZE)
 #define SLAB_DATA_BASE_ADDR (SLAB_BASE_ADDR + SLAB_META_SIZE)
+
+#define is_slab_addr(ptr) ((unsigned long)(ptr) >= SLAB_DATA_BASE_ADDR && \
+	(unsigned long)(ptr) < SLAB_END_ADDR)
+#define is_slab_meta(ptr) ((unsigned long)(ptr) >= SLAB_BASE_ADDR && \
+	(unsigned long)(ptr) < SLAB_DATA_BASE_ADDR)
 #endif /* CONFIG_SLAB_VIRTUAL */
 
 #define CPU_ENTRY_AREA_PGD	_AC(-4, UL)
diff --git a/arch/x86/mm/physaddr.c b/arch/x86/mm/physaddr.c
index fc3f3d3e2ef2..7f1b81c75e4d 100644
--- a/arch/x86/mm/physaddr.c
+++ b/arch/x86/mm/physaddr.c
@@ -16,6 +16,11 @@ unsigned long __phys_addr(unsigned long x)
 {
 	unsigned long y = x - __START_KERNEL_map;
 
+#ifdef CONFIG_SLAB_VIRTUAL
+	if (is_slab_addr(x))
+		return slab_virt_to_phys(x);
+#endif
+
 	/* use the carry flag to determine if x was < __START_KERNEL_map */
 	if (unlikely(x > y)) {
 		x = y + phys_base;
@@ -48,6 +53,11 @@ bool __virt_addr_valid(unsigned long x)
 {
 	unsigned long y = x - __START_KERNEL_map;
 
+#ifdef CONFIG_SLAB_VIRTUAL
+	if (is_slab_addr(x))
+		return true;
+#endif
+
 	/* use the carry flag to determine if x was < __START_KERNEL_map */
 	if (unlikely(x > y)) {
 		x = y + phys_base;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index a2d82010d269..2180d5170995 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -793,5 +793,12 @@ int slab_dead_cpu(unsigned int cpu);
 #define slab_dead_cpu		NULL
 #endif
 
+#ifdef CONFIG_SLAB_VIRTUAL
+void __init init_slub_page_reclaim(void);
+#else
 #define is_slab_addr(addr) folio_test_slab(virt_to_folio(addr))
+static inline void init_slub_page_reclaim(void)
+{
+}
+#endif /* CONFIG_SLAB_VIRTUAL */
 #endif	/* _LINUX_SLAB_H */
diff --git a/init/main.c b/init/main.c
index ad920fac325c..72456964417e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1532,6 +1532,7 @@ static noinline void __init kernel_init_freeable(void)
 	workqueue_init();
 
 	init_mm_internals();
+	init_slub_page_reclaim();
 
 	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
diff --git a/mm/slab.h b/mm/slab.h
index 3fe0d1e26e26..460c802924bd 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -1,6 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef MM_SLAB_H
 #define MM_SLAB_H
+
+#include <linux/build_bug.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
 /*
  * Internal slab definitions
  */
@@ -49,7 +54,35 @@ struct kmem_cache_order_objects {
 
 /* Reuses the bits in struct page */
 struct slab {
+	/*
+	 * With CONFIG_SLAB_VIRTUAL enabled instances of struct slab are not
+	 * overlapped with struct page but instead they are allocated from
+	 * a dedicated virtual memory area.
+	 */
+#ifndef CONFIG_SLAB_VIRTUAL
 	unsigned long __page_flags;
+#else
+	/*
+	 * Used by virt_to_slab to find the actual struct slab for a slab that
+	 * spans multiple pages.
+	 */
+	struct slab *compound_slab_head;
+
+	/*
+	 * Pointer to the folio that the objects are allocated from, or NULL if
+	 * the slab is currently unused and no physical memory is allocated to
+	 * it. Protected by slub_kworker_lock.
+	 */
+	struct folio *backing_folio;
+
+	struct kmem_cache_order_objects oo;
+
+	struct list_head flush_list_elem;
+
+	/* Replaces the page lock */
+	spinlock_t slab_lock;
+
+#endif
 
 #if defined(CONFIG_SLAB)
 
@@ -104,12 +137,17 @@ struct slab {
 #error "Unexpected slab allocator configured"
 #endif
 
+	/* See comment for __page_flags above. */
+#ifndef CONFIG_SLAB_VIRTUAL
 	atomic_t __page_refcount;
+#endif
 #ifdef CONFIG_MEMCG
 	unsigned long memcg_data;
 #endif
 };
 
+/* See comment for __page_flags above. */
+#ifndef CONFIG_SLAB_VIRTUAL
 #define SLAB_MATCH(pg, sl)						\
 	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
 SLAB_MATCH(flags, __page_flags);
@@ -120,10 +158,15 @@ SLAB_MATCH(memcg_data, memcg_data);
 #endif
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
+#else
+static_assert(sizeof(struct slab) <= STRUCT_SLAB_SIZE);
+#endif
+
 #if defined(system_has_freelist_aba) && defined(CONFIG_SLUB)
 static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(freelist_aba_t)));
 #endif
 
+#ifndef CONFIG_SLAB_VIRTUAL
 /**
  * folio_slab - Converts from folio to slab.
  * @folio: The folio.
@@ -187,6 +230,14 @@ static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(freelist_aba_t)
  * Return: true if s points to a slab and false otherwise.
  */
 #define is_slab_page(s) folio_test_slab(slab_folio(s))
+#else
+#define slab_folio(s) (s->backing_folio)
+#define is_slab_page(s) is_slab_meta(s)
+/* Needed for check_heap_object but never actually used */
+#define folio_slab(folio) NULL
+static void *slab_to_virt(const struct slab *s);
+#endif /* CONFIG_SLAB_VIRTUAL */
+
 /*
  * If network-based swap is enabled, sl*b must keep track of whether pages
  * were allocated from pfmemalloc reserves.
@@ -213,7 +264,11 @@ static inline void __slab_clear_pfmemalloc(struct slab *slab)
 
 static inline void *slab_address(const struct slab *slab)
 {
+#ifdef CONFIG_SLAB_VIRTUAL
+	return slab_to_virt(slab);
+#else
 	return folio_address(slab_folio(slab));
+#endif
 }
 
 static inline int slab_nid(const struct slab *slab)
@@ -226,6 +281,52 @@ static inline pg_data_t *slab_pgdat(const struct slab *slab)
 	return folio_pgdat(slab_folio(slab));
 }
 
+#ifdef CONFIG_SLAB_VIRTUAL
+/*
+ * Internal helper. Returns the address of the struct slab corresponding to
+ * the virtual memory page containing kaddr. This does a simple arithmetic
+ * mapping and does *not* return the struct slab of the head page!
+ */
+static unsigned long virt_to_slab_raw(unsigned long addr)
+{
+	VM_WARN_ON(!is_slab_addr(addr));
+	return SLAB_BASE_ADDR +
+		((addr - SLAB_BASE_ADDR) / PAGE_SIZE * sizeof(struct slab));
+}
+
+static struct slab *virt_to_slab(const void *addr)
+{
+	struct slab *slab, *slab_head;
+
+	if (!is_slab_addr(addr))
+		return NULL;
+
+	slab = (struct slab *)virt_to_slab_raw((unsigned long)addr);
+	slab_head = slab->compound_slab_head;
+
+	if (CHECK_DATA_CORRUPTION(!is_slab_meta(slab_head),
+		"compound slab head out of meta range: %p", slab_head))
+		return NULL;
+
+	return slab_head;
+}
+
+static void *slab_to_virt(const struct slab *s)
+{
+	unsigned long slab_idx;
+	bool unaligned_slab =
+		((unsigned long)s - SLAB_BASE_ADDR) % sizeof(*s) != 0;
+
+	if (CHECK_DATA_CORRUPTION(!is_slab_meta(s), "slab not in meta range") ||
+	    CHECK_DATA_CORRUPTION(unaligned_slab, "unaligned slab pointer") ||
+	    CHECK_DATA_CORRUPTION(s->compound_slab_head != s,
+			"%s called on non-head slab", __func__))
+		return NULL;
+
+	slab_idx = ((unsigned long)s - SLAB_BASE_ADDR) / sizeof(*s);
+	return (void *)(SLAB_BASE_ADDR + PAGE_SIZE * slab_idx);
+}
+#else
 static inline struct slab *virt_to_slab(const void *addr)
 {
 	struct folio *folio = virt_to_folio(addr);
@@ -235,6 +336,7 @@ static inline struct slab *virt_to_slab(const void *addr)
 
 	return folio_slab(folio);
 }
+#endif /* CONFIG_SLAB_VIRTUAL */
 
 #define OO_SHIFT	16
 #define OO_MASK		((1 << OO_SHIFT) - 1)
@@ -251,7 +353,11 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 
 static inline int slab_order(const struct slab *slab)
 {
+#ifndef CONFIG_SLAB_VIRTUAL
 	return folio_order((struct folio *)slab_folio(slab));
+#else
+	return oo_order(slab->oo);
+#endif
 }
 
 static inline size_t slab_size(const struct slab *slab)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 42ceaf7e9f47..7754fdba07a0 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1064,6 +1064,10 @@ void kfree(const void *object)
 
 	if (unlikely(!is_slab_addr(object))) {
 		folio = virt_to_folio(object);
+		if (IS_ENABLED(CONFIG_SLAB_VIRTUAL) &&
+			CHECK_DATA_CORRUPTION(folio_test_slab(folio),
+			"unexpected slab page mapped outside slab range"))
+			return;
 		free_large_kmalloc(folio, (void *)object);
 		return;
 	}
diff --git a/mm/slub.c b/mm/slub.c
index a731fdc79bff..66ae60cdadaf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -38,6 +38,10 @@
 #include <linux/prefetch.h>
 #include <linux/memcontrol.h>
 #include <linux/random.h>
+#include <linux/kthread.h>
+#include <linux/io.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/sort.h>
@@ -168,6 +172,8 @@
 
 #ifdef CONFIG_SLAB_VIRTUAL
 unsigned long slub_addr_base = SLAB_DATA_BASE_ADDR;
+/* Protects slub_addr_base */
+static DEFINE_SPINLOCK(slub_valloc_lock);
 #endif /* CONFIG_SLAB_VIRTUAL */
 
 /*
@@ -430,19 +436,18 @@ static void prefetch_freepointer(const struct kmem_cache *s, void *object)
  * get_freepointer_safe() returns initialized memory.
  */
 __no_kmsan_checks
-static inline void *get_freepointer_safe(struct kmem_cache *s, void *object,
+static inline freeptr_t get_freepointer_safe(struct kmem_cache *s, void *object,
 					     struct slab *slab)
 {
-	unsigned long freepointer_addr;
+	unsigned long freepointer_addr = (unsigned long)object + s->offset;
 	freeptr_t p;
 
 	if (!debug_pagealloc_enabled_static())
-		return get_freepointer(s, object, slab);
+		return *(freeptr_t *)freepointer_addr;
 
 	object = kasan_reset_tag(object);
-	freepointer_addr = (unsigned long)object + s->offset;
 	copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
-	return freelist_ptr_decode(s, p, freepointer_addr, slab);
+	return p;
 }
 
 static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
@@ -478,6 +483,17 @@ static inline struct kmem_cache_order_objects oo_make(unsigned int order,
 	return x;
 }
 
+#ifdef CONFIG_SLAB_VIRTUAL
+unsigned long slab_virt_to_phys(unsigned long x)
+{
+	struct slab *slab = virt_to_slab((void  *)x);
+	struct folio *folio = slab_folio(slab);
+
+	return page_to_phys(folio_page(folio, 0)) + offset_in_folio(folio, x);
+}
+EXPORT_SYMBOL(slab_virt_to_phys);
+#endif
+
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
 {
@@ -506,18 +522,26 @@ slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
  */
 static __always_inline void slab_lock(struct slab *slab)
 {
+#ifdef CONFIG_SLAB_VIRTUAL
+	spin_lock(&slab->slab_lock);
+#else
 	struct page *page = slab_page(slab);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	bit_spin_lock(PG_locked, &page->flags);
+#endif
 }
 
 static __always_inline void slab_unlock(struct slab *slab)
 {
+#ifdef CONFIG_SLAB_VIRTUAL
+	spin_unlock(&slab->slab_lock);
+#else
 	struct page *page = slab_page(slab);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	__bit_spin_unlock(PG_locked, &page->flags);
+#endif
 }
 
 static inline bool
@@ -1863,6 +1887,10 @@ static void folio_set_slab(struct folio *folio, struct slab *slab)
 	/* Make the flag visible before any changes to folio->mapping */
 	smp_wmb();
 
+#ifdef CONFIG_SLAB_VIRTUAL
+	slab->backing_folio = folio;
+#endif
+
 	if (folio_is_pfmemalloc(folio))
 		slab_set_pfmemalloc(slab);
 }
@@ -1874,8 +1902,285 @@ static void folio_clear_slab(struct folio *folio, struct slab *slab)
 	/* Make the mapping reset visible before clearing the flag */
 	smp_wmb();
 	__folio_clear_slab(folio);
+#ifdef CONFIG_SLAB_VIRTUAL
+	slab->backing_folio = NULL;
+#endif
+}
+
+#ifdef CONFIG_SLAB_VIRTUAL
+/*
+ * Make sure we have the necessary page tables for the given address.
+ * Returns a pointer to the PTE, or NULL on allocation failure.
+ *
+ * We're using ugly low-level code here instead of the standard
+ * helpers because the normal code insists on using GFP_KERNEL.
+ *
+ * If may_alloc is false, throw an error if the PTE is not already mapped.
+ */
+static pte_t *slub_get_ptep(unsigned long address, gfp_t gfp_flags,
+			    bool may_alloc)
+{
+	pgd_t *pgd = pgd_offset_k(address);
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	unsigned long flags;
+	struct page *spare_page = NULL;
+
+retry:
+	spin_lock_irqsave(&slub_valloc_lock, flags);
+	/*
+	 * The top-level entry should already be present - see
+	 * preallocate_top_level_entries().
+	 */
+	BUG_ON(pgd_none(READ_ONCE(*pgd)));
+	p4d = p4d_offset(pgd, address);
+	if (p4d_none(READ_ONCE(*p4d))) {
+		if (!spare_page)
+			goto need_page;
+		p4d_populate(&init_mm, p4d, (pud_t *)page_to_virt(spare_page));
+		goto need_page;
+
+	}
+	pud = pud_offset(p4d, address);
+	if (pud_none(READ_ONCE(*pud))) {
+		if (!spare_page)
+			goto need_page;
+		pud_populate(&init_mm, pud, (pmd_t *)page_to_virt(spare_page));
+		goto need_page;
+	}
+	pmd = pmd_offset(pud, address);
+	if (pmd_none(READ_ONCE(*pmd))) {
+		if (!spare_page)
+			goto need_page;
+		pmd_populate_kernel(&init_mm, pmd,
+			(pte_t *)page_to_virt(spare_page));
+		spare_page = NULL;
+	}
+	spin_unlock_irqrestore(&slub_valloc_lock, flags);
+	if (spare_page)
+		__free_page(spare_page);
+	return pte_offset_kernel(pmd, address);
+
+need_page:
+	spin_unlock_irqrestore(&slub_valloc_lock, flags);
+	VM_WARN_ON(!may_alloc);
+	spare_page = alloc_page(gfp_flags);
+	if (unlikely(!spare_page))
+		return NULL;
+	/* ensure ordering between page zeroing and PTE write */
+	smp_wmb();
+	goto retry;
+}
+
+/*
+ * Reserve a range of virtual address space, ensure that we have page tables for
+ * it, and allocate a corresponding struct slab.
+ * This is cold code, we don't really have to worry about performance here.
+ */
+static struct slab *alloc_slab_meta(unsigned int order, gfp_t gfp_flags)
+{
+	unsigned long alloc_size = PAGE_SIZE << order;
+	unsigned long flags;
+	unsigned long old_base;
+	unsigned long data_range_start, data_range_end;
+	unsigned long meta_range_start, meta_range_end;
+	unsigned long addr;
+	struct slab *slab, *sp;
+	bool valid_start, valid_end;
+
+	gfp_flags &= (__GFP_HIGH | __GFP_RECLAIM | __GFP_IO |
+		      __GFP_FS | __GFP_NOWARN | __GFP_RETRY_MAYFAIL |
+		      __GFP_NOFAIL | __GFP_NORETRY | __GFP_MEMALLOC |
+		      __GFP_NOMEMALLOC);
+	/* New page tables and metadata pages should be zeroed */
+	gfp_flags |= __GFP_ZERO;
+
+	spin_lock_irqsave(&slub_valloc_lock, flags);
+retry_locked:
+	old_base = slub_addr_base;
+
+	/*
+	 * We drop the lock. The following code might sleep during
+	 * page table allocation. Any mutations we make before rechecking
+	 * slub_addr_base are idempotent, so that's fine.
+	 */
+	spin_unlock_irqrestore(&slub_valloc_lock, flags);
+
+	/*
+	 * [data_range_start, data_range_end) is the virtual address range where
+	 * this slab's objects will be mapped.
+	 * We want alignment appropriate for the order. Note that this could be
+	 * relaxed based on the alignment requirements of the objects being
+	 * allocated, but for now, we behave like the page allocator would.
+	 */
+	data_range_start = ALIGN(old_base, alloc_size);
+	data_range_end = data_range_start + alloc_size;
+
+	valid_start = data_range_start >= SLAB_BASE_ADDR &&
+		IS_ALIGNED(data_range_start, PAGE_SIZE);
+	valid_end = data_range_end >= SLAB_BASE_ADDR &&
+		IS_ALIGNED(data_range_end, PAGE_SIZE);
+	if (CHECK_DATA_CORRUPTION(!valid_start,
+			"invalid slab data range start") ||
+		CHECK_DATA_CORRUPTION(!valid_end,
+			"invalid slab data range end"))
+		return NULL;
+
+	/* We ran out of virtual memory for slabs */
+	if (WARN_ON_ONCE(data_range_start >= SLAB_END_ADDR ||
+		data_range_end >= SLAB_END_ADDR))
+		return NULL;
+
+	/*
+	 * [meta_range_start, meta_range_end) is the range where the struct
+	 * slabs for the current data range are mapped. The first struct slab,
+	 * located at meta_range_start is the head slab that contains the actual
+	 * data, all other struct slabs in the range point to the head slab.
+	 */
+	meta_range_start = virt_to_slab_raw(data_range_start);
+	meta_range_end = virt_to_slab_raw(data_range_end);
+
+	/* Ensure the meta range is mapped. */
+	for (addr = ALIGN_DOWN(meta_range_start, PAGE_SIZE);
+	     addr < meta_range_end; addr += PAGE_SIZE) {
+		pte_t *ptep = slub_get_ptep(addr, gfp_flags, true);
+
+		if (ptep == NULL)
+			return NULL;
+
+		spin_lock_irqsave(&slub_valloc_lock, flags);
+		if (pte_none(READ_ONCE(*ptep))) {
+			struct page *meta_page;
+
+			spin_unlock_irqrestore(&slub_valloc_lock, flags);
+			meta_page = alloc_page(gfp_flags);
+			if (meta_page == NULL)
+				return NULL;
+			spin_lock_irqsave(&slub_valloc_lock, flags);
+
+			/* Make sure that no one else has already mapped that page */
+			if (pte_none(READ_ONCE(*ptep)))
+				set_pte_safe(ptep,
+					mk_pte(meta_page, PAGE_KERNEL));
+			else
+				__free_page(meta_page);
+		}
+		spin_unlock_irqrestore(&slub_valloc_lock, flags);
+	}
+
+	/* Ensure we have page tables for the data range. */
+	for (addr = data_range_start; addr < data_range_end;
+		addr += PAGE_SIZE) {
+		pte_t *ptep = slub_get_ptep(addr, gfp_flags, true);
+
+		if (ptep == NULL)
+			return NULL;
+	}
+
+	/* Did we race with someone else who made forward progress? */
+	spin_lock_irqsave(&slub_valloc_lock, flags);
+	if (old_base != slub_addr_base)
+		goto retry_locked;
+
+	/* Success! Grab the range for ourselves. */
+	slub_addr_base = data_range_end;
+	spin_unlock_irqrestore(&slub_valloc_lock, flags);
+
+	slab = (struct slab *)meta_range_start;
+	spin_lock_init(&slab->slab_lock);
+
+	/* Initialize basic slub metadata for virt_to_slab() */
+	for (sp = slab; (unsigned long)sp < meta_range_end; sp++)
+		sp->compound_slab_head = slab;
+
+	return slab;
+}
+
+/* Get an unused slab, or allocate a new one */
+static struct slab *get_free_slab(struct kmem_cache *s,
+	struct kmem_cache_order_objects oo, gfp_t meta_gfp_flags,
+	struct list_head *freed_slabs)
+{
+	unsigned long flags;
+	struct slab *slab;
+
+	spin_lock_irqsave(&s->virtual.freed_slabs_lock, flags);
+	slab = list_first_entry_or_null(freed_slabs, struct slab, slab_list);
+
+	if (likely(slab)) {
+		list_del(&slab->slab_list);
+
+		spin_unlock_irqrestore(&s->virtual.freed_slabs_lock, flags);
+		return slab;
+	}
+
+	spin_unlock_irqrestore(&s->virtual.freed_slabs_lock, flags);
+	slab = alloc_slab_meta(oo_order(oo), meta_gfp_flags);
+	if (slab == NULL)
+		return NULL;
+
+	return slab;
 }
 
+static struct slab *alloc_slab_page(struct kmem_cache *s,
+		gfp_t meta_gfp_flags, gfp_t gfp_flags, int node,
+		struct kmem_cache_order_objects oo)
+{
+	struct folio *folio;
+	struct slab *slab;
+	unsigned int order = oo_order(oo);
+	unsigned long flags;
+	void *virt_mapping;
+	pte_t *ptep;
+	struct list_head *freed_slabs;
+
+	if (order == oo_order(s->min))
+		freed_slabs = &s->virtual.freed_slabs_min;
+	else
+		freed_slabs = &s->virtual.freed_slabs;
+
+	slab = get_free_slab(s, oo, meta_gfp_flags, freed_slabs);
+
+	/*
+	 * Avoid making UAF reads easily exploitable by repopulating
+	 * with pages containing attacker-controller data - always zero
+	 * pages.
+	 */
+	gfp_flags |= __GFP_ZERO;
+	if (node == NUMA_NO_NODE)
+		folio = (struct folio *)alloc_pages(gfp_flags, order);
+	else
+		folio = (struct folio *)__alloc_pages_node(node, gfp_flags,
+			order);
+
+	if (!folio) {
+		/* Rollback: put the struct slab back. */
+		spin_lock_irqsave(&s->virtual.freed_slabs_lock, flags);
+		list_add(&slab->slab_list, freed_slabs);
+		spin_unlock_irqrestore(&s->virtual.freed_slabs_lock, flags);
+
+		return NULL;
+	}
+	folio_set_slab(folio, slab);
+
+	slab->oo = oo;
+
+	virt_mapping = slab_to_virt(slab);
+
+	/* Wire up physical folio */
+	for (unsigned long i = 0; i < (1UL << oo_order(oo)); i++) {
+		ptep = slub_get_ptep(
+			(unsigned long)virt_mapping + i * PAGE_SIZE, 0, false);
+		if (CHECK_DATA_CORRUPTION(pte_present(*ptep),
+			"slab PTE already present"))
+			return NULL;
+		set_pte_safe(ptep, mk_pte(folio_page(folio, i), PAGE_KERNEL));
+	}
+
+	return slab;
+}
+#else
 static inline struct slab *alloc_slab_page(struct kmem_cache *s,
 		gfp_t meta_flags, gfp_t flags, int node,
 		struct kmem_cache_order_objects oo)
@@ -1897,6 +2202,7 @@ static inline struct slab *alloc_slab_page(struct kmem_cache *s,
 
 	return slab;
 }
+#endif /* CONFIG_SLAB_VIRTUAL */
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Pre-initialize the random sequence cache */
@@ -2085,6 +2391,94 @@ static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
 }
 
+#ifdef CONFIG_SLAB_VIRTUAL
+static DEFINE_SPINLOCK(slub_kworker_lock);
+static struct kthread_worker *slub_kworker;
+static LIST_HEAD(slub_tlbflush_queue);
+
+static void slub_tlbflush_worker(struct kthread_work *work)
+{
+	unsigned long irq_flags;
+	LIST_HEAD(local_queue);
+	struct slab *slab, *tmp;
+	unsigned long addr_start = ULONG_MAX;
+	unsigned long addr_end = 0;
+
+	spin_lock_irqsave(&slub_kworker_lock, irq_flags);
+	list_splice_init(&slub_tlbflush_queue, &local_queue);
+	list_for_each_entry(slab, &local_queue, flush_list_elem) {
+		unsigned long start = (unsigned long)slab_to_virt(slab);
+		unsigned long end = start + PAGE_SIZE *
+			(1UL << oo_order(slab->oo));
+
+		if (start < addr_start)
+			addr_start = start;
+		if (end > addr_end)
+			addr_end = end;
+	}
+	spin_unlock_irqrestore(&slub_kworker_lock, irq_flags);
+
+	if (addr_start < addr_end)
+		flush_tlb_kernel_range(addr_start, addr_end);
+
+	spin_lock_irqsave(&slub_kworker_lock, irq_flags);
+	list_for_each_entry_safe(slab, tmp, &local_queue, flush_list_elem) {
+		struct folio *folio = slab_folio(slab);
+		struct kmem_cache *s = slab->slab_cache;
+
+		list_del(&slab->flush_list_elem);
+		folio_clear_slab(folio, slab);
+		__free_pages(folio_page(folio, 0), oo_order(slab->oo));
+
+		/* IRQs are already off */
+		spin_lock(&s->virtual.freed_slabs_lock);
+		if (oo_order(slab->oo) == oo_order(s->oo)) {
+			list_add(&slab->slab_list, &s->virtual.freed_slabs);
+		} else {
+			WARN_ON(oo_order(slab->oo) != oo_order(s->min));
+			list_add(&slab->slab_list, &s->virtual.freed_slabs_min);
+		}
+		spin_unlock(&s->virtual.freed_slabs_lock);
+	}
+	spin_unlock_irqrestore(&slub_kworker_lock, irq_flags);
+}
+static DEFINE_KTHREAD_WORK(slub_tlbflush_work, slub_tlbflush_worker);
+
+static void __free_slab(struct kmem_cache *s, struct slab *slab)
+{
+	int order = oo_order(slab->oo);
+	unsigned long pages = 1UL << order;
+	unsigned long slab_base = (unsigned long)slab_address(slab);
+	unsigned long irq_flags;
+
+	/* Clear the PTEs for the slab we're freeing */
+	for (unsigned long i = 0; i < pages; i++) {
+		unsigned long addr = slab_base + i * PAGE_SIZE;
+		pte_t *ptep = slub_get_ptep(addr, 0, false);
+
+		if (CHECK_DATA_CORRUPTION(!pte_present(*ptep),
+			"slab PTE already clear"))
+			return;
+
+		ptep_clear(&init_mm, addr, ptep);
+	}
+
+	mm_account_reclaimed_pages(pages);
+	unaccount_slab(slab, order, s);
+
+	/*
+	 * We might not be able to a TLB flush here (e.g. hardware interrupt
+	 * handlers) so instead we give the slab to the TLB flusher thread
+	 * which will flush the TLB for us and only then free the physical
+	 * memory.
+	 */
+	spin_lock_irqsave(&slub_kworker_lock, irq_flags);
+	list_add(&slab->flush_list_elem, &slub_tlbflush_queue);
+	spin_unlock_irqrestore(&slub_kworker_lock, irq_flags);
+	if (READ_ONCE(slub_kworker) != NULL)
+		kthread_queue_work(slub_kworker, &slub_tlbflush_work);
+}
+#else
 static void __free_slab(struct kmem_cache *s, struct slab *slab)
 {
 	struct folio *folio = slab_folio(slab);
@@ -2096,6 +2490,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	unaccount_slab(slab, order, s);
 	__free_pages(&folio->page, order);
 }
+#endif /* CONFIG_SLAB_VIRTUAL */
 
 static void rcu_free_slab(struct rcu_head *h)
 {
@@ -3384,7 +3779,15 @@ static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
 	    unlikely(!object || !slab || !node_match(slab, node))) {
 		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	} else {
-		void *next_object = get_freepointer_safe(s, object, slab);
+		void *next_object;
+		freeptr_t next_encoded = get_freepointer_safe(s, object, slab);
+
+		if (unlikely(READ_ONCE(c->tid) != tid))
+			goto redo;
+
+		next_object = freelist_ptr_decode(s, next_encoded,
+			(unsigned long)kasan_reset_tag(object) + s->offset,
+			slab);
 
 		/*
 		 * The cmpxchg will only match if there was no additional
@@ -5050,6 +5453,30 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 	return s;
 }
 
+#ifdef CONFIG_SLAB_VIRTUAL
+/*
+ * Late initialization of reclaim kthread.
+ * This has to happen way later than kmem_cache_init() because it depends on
+ * having all the kthread infrastructure ready.
+ */
+void __init init_slub_page_reclaim(void)
+{
+	struct kthread_worker *w;
+
+	w = kthread_create_worker(0, "slub-physmem-reclaim");
+	if (IS_ERR(w))
+		panic("unable to create slub-physmem-reclaim worker");
+
+	/*
+	 * Make sure that the kworker is properly initialized before making
+	 * the store visible to other CPUs. The free path will check that
+	 * slub_kworker is not NULL before attempting to give the TLB flusher
+	 * pages to free.
+	 */
+	smp_store_release(&slub_kworker, w);
+}
+#endif /* CONFIG_SLAB_VIRTUAL */
+
 void __init kmem_cache_init(void)
 {
 	static __initdata struct kmem_cache boot_kmem_cache,
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 83c164aba6e0..8b30906ca7f9 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -189,9 +189,19 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	if (!virt_addr_valid(ptr))
 		return;
 
+	/*
+	 * We need to check this first because when CONFIG_SLAB_VIRTUAL is
+	 * enabled a slab address might not be backed by a folio.
+	 */
+	if (IS_ENABLED(CONFIG_SLAB_VIRTUAL) && is_slab_addr(ptr)) {
+		/* Check slab allocator for flags and size. */
+		__check_heap_object(ptr, n, virt_to_slab(ptr), to_user);
+		return;
+	}
+
 	folio = virt_to_folio(ptr);
 
-	if (folio_test_slab(folio)) {
+	if (!IS_ENABLED(CONFIG_SLAB_VIRTUAL) && folio_test_slab(folio)) {
 		/* Check slab allocator for flags and size. */
 		__check_heap_object(ptr, n, folio_slab(folio), to_user);
 	} else if (folio_test_large(folio)) {
-- 
2.42.0.459.ge4e396fd5e-goog

