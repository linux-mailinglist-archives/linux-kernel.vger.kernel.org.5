Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61B757563
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjGRHa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGRHa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:30:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FA210CC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:30:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b4748fe4so32309235ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689665431; x=1692257431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbWcwbfvK0B2CiexlkN6if10zNcxlC4xkFU/ZNrDr6E=;
        b=RTBhYUAtUyp1r+ibatHO3UBkkXi2vAoU4ftfUkJEdqZ5covGG2LrEdGkeRrfMoiIX/
         43mJHEVgctd1WA/TXx4AU3dUISW4JFhDW96XSiiP626EClSSIcG9LED4NPVB/S2a5Ksa
         bOVlGj3x3cQU5GPzvMsIenAsKRNn99M/qkfqnsGJMxBg3b/eekGh+trEZeNPpX1NU1rt
         LxHwc00N5Oo8Hr5rfhx6BW1k43dt+frWKDeVvJD/pPCfFUtZnJcr96m5aq9EEtgkECnm
         232+Lr4wWnarcE7zN03K0xSPd9KmrSmZjDlqRzbt0CyAKYA83i34zm/p0Z1jLyYRSK15
         ebWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665431; x=1692257431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbWcwbfvK0B2CiexlkN6if10zNcxlC4xkFU/ZNrDr6E=;
        b=Zigc53WYpfzadkdANFGJAcqUb+9srHKgfrMyBEKpBiA867N5cidyV0sBgogbQ0zl9w
         rBgy7Vegz1EOmjotDCQMeZm4zgFeM10+SCEBcESQie5PI/jLfkVg1le0qHg/BXQm+kB1
         1aygD2nix7lBeYeYY6TWNvU4f7uEwqgHNGc1k5FoLmRxE1r/Dojy+2R1aOiGvPRkXrnp
         novcW6VzvoyfPNoqsaGMVGydlLZ/FEGRsPOR46fwCmOwtuzNlKTAAXP11v1JhJUaCdsr
         GGzTPOPN/8ATf67TPKUKLMH+JTJf13M8hWS3EByK1eE1Z37Iiwrce7lV1Uy2coQwDaDD
         zZ5Q==
X-Gm-Message-State: ABy/qLacTX72qOhp+OT9pLwZK8+eDZSmS89Tl2a6YrLteuzep2vurOzN
        010KjBsxwa4PzKNjj0cG+B5thA==
X-Google-Smtp-Source: APBJJlHdbX1rKsRTH2j6hYy8HdEIH2ErnTHEtAcfnkBvzSmi5oo+IMu9VNqZZekFlQsRPVqETGHKhQ==
X-Received: by 2002:a17:902:ecc1:b0:1b8:9b78:df44 with SMTP id a1-20020a170902ecc100b001b89b78df44mr13733451plh.20.1689665431200;
        Tue, 18 Jul 2023 00:30:31 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([2408:8656:30f8:e020::2:d])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709027c0600b001b0358848b0sm1096315pll.161.2023.07.18.00.30.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jul 2023 00:30:30 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3] mm: kfence: allocate kfence_metadata at runtime
Date:   Tue, 18 Jul 2023 15:30:19 +0800
Message-Id: <20230718073019.52513-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfence_metadata is currently a static array. For the purpose of allocating
scalable __kfence_pool, we first change it to runtime allocation of
metadata. Since the size of an object of kfence_metadata is 1160 bytes, we
can save at least 72 pages (with default 256 objects) without enabling
kfence.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
Changes since v2:
 - Fix missing renaming of kfence_alloc_pool.
 - Add __read_mostly for kfence_metadata and kfence_metadata_init.
 - Use smp_store_release() and smp_load_acquire() to access kfence_metadata.
 - Some tweaks to comments and git log.

v1: https://lore.kernel.org/lkml/20230710032714.26200-1-zhangpeng.00@bytedance.com/
v2: https://lore.kernel.org/lkml/20230712081616.45177-1-zhangpeng.00@bytedance.com/

 include/linux/kfence.h |  11 ++--
 mm/kfence/core.c       | 124 ++++++++++++++++++++++++++++-------------
 mm/kfence/kfence.h     |   5 +-
 mm/mm_init.c           |   2 +-
 4 files changed, 97 insertions(+), 45 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 726857a4b680..401af4757514 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -59,15 +59,16 @@ static __always_inline bool is_kfence_address(const void *addr)
 }
 
 /**
- * kfence_alloc_pool() - allocate the KFENCE pool via memblock
+ * kfence_alloc_pool_and_metadata() - allocate the KFENCE pool and KFENCE
+ * metadata via memblock
  */
-void __init kfence_alloc_pool(void);
+void __init kfence_alloc_pool_and_metadata(void);
 
 /**
  * kfence_init() - perform KFENCE initialization at boot time
  *
- * Requires that kfence_alloc_pool() was called before. This sets up the
- * allocation gate timer, and requires that workqueues are available.
+ * Requires that kfence_alloc_pool_and_metadata() was called before. This sets
+ * up the allocation gate timer, and requires that workqueues are available.
  */
 void __init kfence_init(void);
 
@@ -223,7 +224,7 @@ bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *sla
 #else /* CONFIG_KFENCE */
 
 static inline bool is_kfence_address(const void *addr) { return false; }
-static inline void kfence_alloc_pool(void) { }
+static inline void kfence_alloc_pool_and_metadata(void) { }
 static inline void kfence_init(void) { }
 static inline void kfence_shutdown_cache(struct kmem_cache *s) { }
 static inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags) { return NULL; }
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index dad3c0eb70a0..6b526435886c 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -116,7 +116,15 @@ EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
  * backing pages (in __kfence_pool).
  */
 static_assert(CONFIG_KFENCE_NUM_OBJECTS > 0);
-struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
+struct kfence_metadata *kfence_metadata __read_mostly;
+
+/*
+ * If kfence_metadata is not NULL, it may be accessed by kfence_shutdown_cache().
+ * So introduce kfence_metadata_init to initialize metadata, and then make
+ * kfence_metadata visible after initialization is successful. This prevents
+ * potential UAF or access to uninitialized metadata.
+ */
+static struct kfence_metadata *kfence_metadata_init __read_mostly;
 
 /* Freelist with available objects. */
 static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
@@ -591,7 +599,7 @@ static unsigned long kfence_init_pool(void)
 
 		__folio_set_slab(slab_folio(slab));
 #ifdef CONFIG_MEMCG
-		slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
+		slab->memcg_data = (unsigned long)&kfence_metadata_init[i / 2 - 1].objcg |
 				   MEMCG_DATA_OBJCGS;
 #endif
 	}
@@ -610,7 +618,7 @@ static unsigned long kfence_init_pool(void)
 	}
 
 	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
-		struct kfence_metadata *meta = &kfence_metadata[i];
+		struct kfence_metadata *meta = &kfence_metadata_init[i];
 
 		/* Initialize metadata. */
 		INIT_LIST_HEAD(&meta->list);
@@ -626,6 +634,12 @@ static unsigned long kfence_init_pool(void)
 		addr += 2 * PAGE_SIZE;
 	}
 
+	/*
+	 * Make kfence_metadata visible only when initialization is successful.
+	 * Otherwise, if the initialization fails and kfence_metadata is freed,
+	 * it may cause UAF in kfence_shutdown_cache().
+	 */
+	smp_store_release(&kfence_metadata, kfence_metadata_init);
 	return 0;
 
 reset_slab:
@@ -672,26 +686,10 @@ static bool __init kfence_init_pool_early(void)
 	 */
 	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
 	__kfence_pool = NULL;
-	return false;
-}
-
-static bool kfence_init_pool_late(void)
-{
-	unsigned long addr, free_size;
 
-	addr = kfence_init_pool();
-
-	if (!addr)
-		return true;
+	memblock_free_late(__pa(kfence_metadata_init), KFENCE_METADATA_SIZE);
+	kfence_metadata_init = NULL;
 
-	/* Same as above. */
-	free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
-#ifdef CONFIG_CONTIG_ALLOC
-	free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
-#else
-	free_pages_exact((void *)addr, free_size);
-#endif
-	__kfence_pool = NULL;
 	return false;
 }
 
@@ -841,19 +839,30 @@ static void toggle_allocation_gate(struct work_struct *work)
 
 /* === Public interface ===================================================== */
 
-void __init kfence_alloc_pool(void)
+void __init kfence_alloc_pool_and_metadata(void)
 {
 	if (!kfence_sample_interval)
 		return;
 
-	/* if the pool has already been initialized by arch, skip the below. */
-	if (__kfence_pool)
-		return;
-
-	__kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
-
+	/*
+	 * If the pool has already been initialized by arch, there is no need to
+	 * re-allocate the memory pool.
+	 */
 	if (!__kfence_pool)
+		__kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
+
+	if (!__kfence_pool) {
 		pr_err("failed to allocate pool\n");
+		return;
+	}
+
+	/* The memory allocated by memblock has been zeroed out. */
+	kfence_metadata_init = memblock_alloc(KFENCE_METADATA_SIZE, PAGE_SIZE);
+	if (!kfence_metadata_init) {
+		pr_err("failed to allocate metadata\n");
+		memblock_free(__kfence_pool, KFENCE_POOL_SIZE);
+		__kfence_pool = NULL;
+	}
 }
 
 static void kfence_init_enable(void)
@@ -895,33 +904,68 @@ void __init kfence_init(void)
 
 static int kfence_init_late(void)
 {
-	const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
+	const unsigned long nr_pages_pool = KFENCE_POOL_SIZE / PAGE_SIZE;
+	const unsigned long nr_pages_meta = KFENCE_METADATA_SIZE / PAGE_SIZE;
+	unsigned long addr = (unsigned long)__kfence_pool;
+	unsigned long free_size = KFENCE_POOL_SIZE;
+	int err = -ENOMEM;
+
 #ifdef CONFIG_CONTIG_ALLOC
 	struct page *pages;
-
-	pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node, NULL);
+	pages = alloc_contig_pages(nr_pages_pool, GFP_KERNEL, first_online_node,
+				   NULL);
 	if (!pages)
 		return -ENOMEM;
+
 	__kfence_pool = page_to_virt(pages);
+	pages = alloc_contig_pages(nr_pages_meta, GFP_KERNEL, first_online_node,
+				   NULL);
+	if (pages)
+		kfence_metadata_init = page_to_virt(pages);
 #else
-	if (nr_pages > MAX_ORDER_NR_PAGES) {
+	if (nr_pages_pool > MAX_ORDER_NR_PAGES ||
+	    nr_pages_meta > MAX_ORDER_NR_PAGES) {
 		pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
 		return -EINVAL;
 	}
+
 	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
 	if (!__kfence_pool)
 		return -ENOMEM;
+
+	kfence_metadata_init = alloc_pages_exact(KFENCE_METADATA_SIZE, GFP_KERNEL);
 #endif
 
-	if (!kfence_init_pool_late()) {
-		pr_err("%s failed\n", __func__);
-		return -EBUSY;
+	if (!kfence_metadata_init)
+		goto free_pool;
+
+	memzero_explicit(kfence_metadata_init, KFENCE_METADATA_SIZE);
+	addr = kfence_init_pool();
+	if (!addr) {
+		kfence_init_enable();
+		kfence_debugfs_init();
+		return 0;
 	}
 
-	kfence_init_enable();
-	kfence_debugfs_init();
+	pr_err("%s failed\n", __func__);
+	free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
+	err = -EBUSY;
 
-	return 0;
+#ifdef CONFIG_CONTIG_ALLOC
+	free_contig_range(page_to_pfn(virt_to_page((void *)kfence_metadata_init)),
+			  nr_pages_meta);
+free_pool:
+	free_contig_range(page_to_pfn(virt_to_page((void *)addr)),
+			  free_size / PAGE_SIZE);
+#else
+	free_pages_exact((void *)kfence_metadata_init, KFENCE_METADATA_SIZE);
+free_pool:
+	free_pages_exact((void *)addr, free_size);
+#endif
+
+	kfence_metadata_init = NULL;
+	__kfence_pool = NULL;
+	return err;
 }
 
 static int kfence_enable_late(void)
@@ -941,6 +985,10 @@ void kfence_shutdown_cache(struct kmem_cache *s)
 	struct kfence_metadata *meta;
 	int i;
 
+	/* Pairs with release in kfence_init_pool(). */
+	if (!smp_load_acquire(&kfence_metadata))
+		return;
+
 	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
 		bool in_use;
 
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 392fb273e7bd..f46fbb03062b 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -102,7 +102,10 @@ struct kfence_metadata {
 #endif
 };
 
-extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
+#define KFENCE_METADATA_SIZE PAGE_ALIGN(sizeof(struct kfence_metadata) * \
+					CONFIG_KFENCE_NUM_OBJECTS)
+
+extern struct kfence_metadata *kfence_metadata;
 
 static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
 {
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f7f9c677854..3d0a63c75829 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2721,7 +2721,7 @@ void __init mm_core_init(void)
 	 */
 	page_ext_init_flatmem();
 	mem_debugging_and_hardening_init();
-	kfence_alloc_pool();
+	kfence_alloc_pool_and_metadata();
 	report_meminit();
 	kmsan_init_shadow();
 	stack_depot_early_init();
-- 
2.20.1

