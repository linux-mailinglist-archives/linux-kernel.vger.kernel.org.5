Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1422B75F8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGXNtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjGXNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:49:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A741BC5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fd0f000f1cso27354865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690206409; x=1690811209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrBvXJXG5pOuPGnFnmmWgOCSm+Hu58ziTnCPKJdrxFI=;
        b=hpDj6ajLvbAW9mGF/M6fPkHM3QLBe4nIO3sZ+5rXgwwUYggGi/WBHwUVl1j7lubKb8
         LIXvVDqKO3ib1Q5crCeVVLcCwz6zNW1WL7yBf3YfRSnBoROpth2S/AcSHCUOGFSvOamJ
         WwynED0rZsIpTLVIUvw0WZlcGPrJtSbolW7vEwQvV4fqE/ypPbFP/TVjajy/h0SLgyJd
         DEkKUg1jUWxEp6QBOkRtSMiC3xBufpqtPJyRabtQ/i1vuBg6r5wxRkqLOsuG4q264q1h
         bnSfu1davANntTXapNjREHqzZwcU0yVx4hSTqtUWrFB7eFjVaKtY5FR0QwLONqCmO8lV
         fFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206409; x=1690811209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrBvXJXG5pOuPGnFnmmWgOCSm+Hu58ziTnCPKJdrxFI=;
        b=VuptH4MhAZNJJFuNrue9thiCzOvm8H3KwcqEGzFvXW19j7tLXeq5LPHhzdtzjS9YeD
         IJ8Qf45KwPfUEhGJ5y8BOhSfC1Yfpoqel8S10o1vYZAhmUttM+SEEo0rEIQgW35uPegY
         ybWyycyo5UZ1pfho7jZpwNQsz3UJwy/+728fXTX02ssRdJB0h+hpNVD6ewfFS7zNln5Y
         t+NJSte9MVaH4RAudzzapulgdMOx3Hp3Ry9R0eN2BZ3/DpslmbRd+8QIgdyuBS3hasN0
         Xy4BngaDMLmLPFsrjtdDvoFgON/fBXR4vfBua/dXD5ZHwH8RZisn8eiW61SEQg6f97Bi
         l6fg==
X-Gm-Message-State: ABy/qLYm+pdhEkJ22/n2f5rLSMp2Mim0ncWT3Y/GKlaGAciRZMG4LTMt
        e4iwE/0l/uBqPDrzHSiH3sE63A==
X-Google-Smtp-Source: APBJJlHk8KJWAC/OoxngikxSJIK1cZRDdcxZvpPXhgKaCZyVzjAtt+mOGG+/DXri1zptdNJ2s+Z0zg==
X-Received: by 2002:a7b:c8d7:0:b0:3fc:180:6463 with SMTP id f23-20020a7bc8d7000000b003fc01806463mr8081280wml.7.1690206409462;
        Mon, 24 Jul 2023 06:46:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:d7c4:7f46:8fed:f874])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbe791a0e8sm10209354wme.0.2023.07.24.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:46:48 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [RFC 2/4] mm/memblock: Add hugepage_size member to struct memblock_region
Date:   Mon, 24 Jul 2023 14:46:42 +0100
Message-Id: <20230724134644.1299963-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724134644.1299963-1-usama.arif@bytedance.com>
References: <20230724134644.1299963-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This propagates the hugepage size from the memblock APIs
(memblock_alloc_try_nid_raw and memblock_alloc_range_nid)
so that it can be stored in struct memblock region. This does not
introduce any functional change and hugepage_size is not used in
this commit. It is just a setup for the next commit where huge_pagesize
is used to skip initialization of struct pages that will be freed later
when HVO is enabled.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/arm64/mm/kasan_init.c                   |  2 +-
 arch/powerpc/platforms/pasemi/iommu.c        |  2 +-
 arch/powerpc/platforms/pseries/setup.c       |  4 +-
 arch/powerpc/sysdev/dart_iommu.c             |  2 +-
 include/linux/memblock.h                     |  8 ++-
 mm/cma.c                                     |  4 +-
 mm/hugetlb.c                                 |  6 +-
 mm/memblock.c                                | 60 ++++++++++++--------
 mm/mm_init.c                                 |  2 +-
 mm/sparse-vmemmap.c                          |  2 +-
 tools/testing/memblock/tests/alloc_nid_api.c |  2 +-
 11 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index f17d066e85eb..39992a418891 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -50,7 +50,7 @@ static phys_addr_t __init kasan_alloc_raw_page(int node)
 	void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
 						__pa(MAX_DMA_ADDRESS),
 						MEMBLOCK_ALLOC_NOLEAKTRACE,
-						node);
+						node, 0);
 	if (!p)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%llx\n",
 		      __func__, PAGE_SIZE, PAGE_SIZE, node,
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 375487cba874..6963cdf76bce 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -201,7 +201,7 @@ static int __init iob_init(struct device_node *dn)
 	/* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
 	iob_l2_base = memblock_alloc_try_nid_raw(1UL << 21, 1UL << 21,
 					MEMBLOCK_LOW_LIMIT, 0x80000000,
-					NUMA_NO_NODE);
+					NUMA_NO_NODE, 0);
 	if (!iob_l2_base)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx max_addr=%x\n",
 		      __func__, 1UL << 21, 1UL << 21, 0x80000000);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e2a57cfa6c83..cec7198b59d2 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -160,7 +160,7 @@ static void __init fwnmi_init(void)
 	 */
 	mce_data_buf = memblock_alloc_try_nid_raw(RTAS_ERROR_LOG_MAX * nr_cpus,
 					RTAS_ERROR_LOG_MAX, MEMBLOCK_LOW_LIMIT,
-					ppc64_rma_size, NUMA_NO_NODE);
+					ppc64_rma_size, NUMA_NO_NODE, 0);
 	if (!mce_data_buf)
 		panic("Failed to allocate %d bytes below %pa for MCE buffer\n",
 		      RTAS_ERROR_LOG_MAX * nr_cpus, &ppc64_rma_size);
@@ -176,7 +176,7 @@ static void __init fwnmi_init(void)
 		size = sizeof(struct slb_entry) * mmu_slb_size * nr_cpus;
 		slb_ptr = memblock_alloc_try_nid_raw(size,
 				sizeof(struct slb_entry), MEMBLOCK_LOW_LIMIT,
-				ppc64_rma_size, NUMA_NO_NODE);
+				ppc64_rma_size, NUMA_NO_NODE, 0);
 		if (!slb_ptr)
 			panic("Failed to allocate %zu bytes below %pa for slb area\n",
 			      size, &ppc64_rma_size);
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 98096bbfd62e..86c676b61899 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -239,7 +239,7 @@ static void __init allocate_dart(void)
 	 */
 	dart_tablebase = memblock_alloc_try_nid_raw(SZ_16M, SZ_16M,
 					MEMBLOCK_LOW_LIMIT, SZ_2G,
-					NUMA_NO_NODE);
+					NUMA_NO_NODE, 0);
 	if (!dart_tablebase)
 		panic("Failed to allocate 16MB below 2GB for DART table\n");
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f71ff9f0ec81..bb8019540d73 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -63,6 +63,7 @@ struct memblock_region {
 #ifdef CONFIG_NUMA
 	int nid;
 #endif
+	phys_addr_t hugepage_size;
 };
 
 /**
@@ -400,7 +401,8 @@ phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
 				      phys_addr_t start, phys_addr_t end);
 phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
 				      phys_addr_t align, phys_addr_t start,
-				      phys_addr_t end, int nid, bool exact_nid);
+				      phys_addr_t end, int nid, bool exact_nid,
+				      phys_addr_t hugepage_size);
 phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
 
 static __always_inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
@@ -415,7 +417,7 @@ void *memblock_alloc_exact_nid_raw(phys_addr_t size, phys_addr_t align,
 				 int nid);
 void *memblock_alloc_try_nid_raw(phys_addr_t size, phys_addr_t align,
 				 phys_addr_t min_addr, phys_addr_t max_addr,
-				 int nid);
+				 int nid, phys_addr_t hugepage_size);
 void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
 			     phys_addr_t min_addr, phys_addr_t max_addr,
 			     int nid);
@@ -431,7 +433,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
 {
 	return memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
 					  MEMBLOCK_ALLOC_ACCESSIBLE,
-					  NUMA_NO_NODE);
+					  NUMA_NO_NODE, 0);
 }
 
 static inline void *memblock_alloc_from(phys_addr_t size,
diff --git a/mm/cma.c b/mm/cma.c
index a4cfe995e11e..a270905aa7f2 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -334,7 +334,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 		if (!memblock_bottom_up() && memblock_end >= SZ_4G + size) {
 			memblock_set_bottom_up(true);
 			addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
-							limit, nid, true);
+							limit, nid, true, 0);
 			memblock_set_bottom_up(false);
 		}
 #endif
@@ -353,7 +353,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 
 		if (!addr) {
 			addr = memblock_alloc_range_nid(size, alignment, base,
-					limit, nid, true);
+					limit, nid, true, 0);
 			if (!addr) {
 				ret = -ENOMEM;
 				goto err;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 24352abbb9e5..5ba7fd702458 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3168,7 +3168,8 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	/* do node specific alloc */
 	if (nid != NUMA_NO_NODE) {
 		m = memblock_alloc_try_nid_raw(huge_page_size(h), huge_page_size(h),
-				0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+				0, MEMBLOCK_ALLOC_ACCESSIBLE, nid,
+				hugetlb_vmemmap_optimizable(h) ? huge_page_size(h) : 0);
 		if (!m)
 			return 0;
 		goto found;
@@ -3177,7 +3178,8 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
 		m = memblock_alloc_try_nid_raw(
 				huge_page_size(h), huge_page_size(h),
-				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
+				0, MEMBLOCK_ALLOC_ACCESSIBLE, node,
+				hugetlb_vmemmap_optimizable(h) ? huge_page_size(h) : 0);
 		/*
 		 * Use the beginning of the huge page to store the
 		 * huge_bootmem_page struct (until gather_bootmem
diff --git a/mm/memblock.c b/mm/memblock.c
index f9e61e565a53..e92d437bcb51 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -549,7 +549,8 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
 						   int idx, phys_addr_t base,
 						   phys_addr_t size,
 						   int nid,
-						   enum memblock_flags flags)
+						   enum memblock_flags flags,
+						   phys_addr_t hugepage_size)
 {
 	struct memblock_region *rgn = &type->regions[idx];
 
@@ -558,6 +559,7 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
 	rgn->base = base;
 	rgn->size = size;
 	rgn->flags = flags;
+	rgn->hugepage_size = hugepage_size;
 	memblock_set_region_node(rgn, nid);
 	type->cnt++;
 	type->total_size += size;
@@ -581,7 +583,7 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
  */
 static int __init_memblock memblock_add_range(struct memblock_type *type,
 				phys_addr_t base, phys_addr_t size,
-				int nid, enum memblock_flags flags)
+				int nid, enum memblock_flags flags, phys_addr_t hugepage_size)
 {
 	bool insert = false;
 	phys_addr_t obase = base;
@@ -598,6 +600,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		type->regions[0].base = base;
 		type->regions[0].size = size;
 		type->regions[0].flags = flags;
+		type->regions[0].hugepage_size = hugepage_size;
 		memblock_set_region_node(&type->regions[0], nid);
 		type->total_size = size;
 		return 0;
@@ -646,7 +649,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 				end_rgn = idx + 1;
 				memblock_insert_region(type, idx++, base,
 						       rbase - base, nid,
-						       flags);
+						       flags, hugepage_size);
 			}
 		}
 		/* area below @rend is dealt with, forget about it */
@@ -661,7 +664,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 				start_rgn = idx;
 			end_rgn = idx + 1;
 			memblock_insert_region(type, idx, base, end - base,
-					       nid, flags);
+					       nid, flags, hugepage_size);
 		}
 	}
 
@@ -705,7 +708,7 @@ int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
 	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
 		     &base, &end, nid, flags, (void *)_RET_IP_);
 
-	return memblock_add_range(&memblock.memory, base, size, nid, flags);
+	return memblock_add_range(&memblock.memory, base, size, nid, flags, 0);
 }
 
 /**
@@ -726,7 +729,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
 		     &base, &end, (void *)_RET_IP_);
 
-	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
+	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0, 0);
 }
 
 /**
@@ -782,7 +785,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 			type->total_size -= base - rbase;
 			memblock_insert_region(type, idx, rbase, base - rbase,
 					       memblock_get_region_node(rgn),
-					       rgn->flags);
+					       rgn->flags, 0);
 		} else if (rend > end) {
 			/*
 			 * @rgn intersects from above.  Split and redo the
@@ -793,7 +796,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 			type->total_size -= end - rbase;
 			memblock_insert_region(type, idx--, rbase, end - rbase,
 					       memblock_get_region_node(rgn),
-					       rgn->flags);
+					       rgn->flags, 0);
 		} else {
 			/* @rgn is fully contained, record it */
 			if (!*end_rgn)
@@ -863,14 +866,20 @@ int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
 	return memblock_remove_range(&memblock.reserved, base, size);
 }
 
-int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
+int __init_memblock memblock_reserve_huge(phys_addr_t base, phys_addr_t size,
+					   phys_addr_t hugepage_size)
 {
 	phys_addr_t end = base + size - 1;
 
 	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
 		     &base, &end, (void *)_RET_IP_);
 
-	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
+	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0, hugepage_size);
+}
+
+int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_reserve_huge(base, size, 0);
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -881,7 +890,7 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
 		     &base, &end, (void *)_RET_IP_);
 
-	return memblock_add_range(&physmem, base, size, MAX_NUMNODES, 0);
+	return memblock_add_range(&physmem, base, size, MAX_NUMNODES, 0, 0);
 }
 #endif
 
@@ -1365,6 +1374,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
  * @end: the upper bound of the memory region to allocate (phys address)
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  * @exact_nid: control the allocation fall back to other nodes
+ * @hugepage_size: size of the hugepages in bytes
  *
  * The allocation is performed from memory region limited by
  * memblock.current_limit if @end == %MEMBLOCK_ALLOC_ACCESSIBLE.
@@ -1385,7 +1395,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid,
-					bool exact_nid)
+					bool exact_nid, phys_addr_t hugepage_size)
 {
 	enum memblock_flags flags = choose_memblock_flags();
 	phys_addr_t found;
@@ -1402,14 +1412,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 again:
 	found = memblock_find_in_range_node(size, align, start, end, nid,
 					    flags);
-	if (found && !memblock_reserve(found, size))
+	if (found && !memblock_reserve_huge(found, size, hugepage_size))
 		goto done;
 
 	if (nid != NUMA_NO_NODE && !exact_nid) {
 		found = memblock_find_in_range_node(size, align, start,
 						    end, NUMA_NO_NODE,
 						    flags);
-		if (found && !memblock_reserve(found, size))
+		if (found && !memblock_reserve_huge(found, size, hugepage_size))
 			goto done;
 	}
 
@@ -1469,7 +1479,7 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
 		     __func__, (u64)size, (u64)align, &start, &end,
 		     (void *)_RET_IP_);
 	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
-					false);
+					false, 0);
 }
 
 /**
@@ -1488,7 +1498,7 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
 phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
 {
 	return memblock_alloc_range_nid(size, align, 0,
-					MEMBLOCK_ALLOC_ACCESSIBLE, nid, false);
+					MEMBLOCK_ALLOC_ACCESSIBLE, nid, false, 0);
 }
 
 /**
@@ -1514,7 +1524,7 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
 static void * __init memblock_alloc_internal(
 				phys_addr_t size, phys_addr_t align,
 				phys_addr_t min_addr, phys_addr_t max_addr,
-				int nid, bool exact_nid)
+				int nid, bool exact_nid, phys_addr_t hugepage_size)
 {
 	phys_addr_t alloc;
 
@@ -1530,12 +1540,12 @@ static void * __init memblock_alloc_internal(
 		max_addr = memblock.current_limit;
 
 	alloc = memblock_alloc_range_nid(size, align, min_addr, max_addr, nid,
-					exact_nid);
+					exact_nid, hugepage_size);
 
 	/* retry allocation without lower limit */
 	if (!alloc && min_addr)
 		alloc = memblock_alloc_range_nid(size, align, 0, max_addr, nid,
-						exact_nid);
+						exact_nid, hugepage_size);
 
 	if (!alloc)
 		return NULL;
@@ -1571,7 +1581,7 @@ void * __init memblock_alloc_exact_nid_raw(
 		     &max_addr, (void *)_RET_IP_);
 
 	return memblock_alloc_internal(size, align, min_addr, max_addr, nid,
-				       true);
+				       true, 0);
 }
 
 /**
@@ -1585,25 +1595,29 @@ void * __init memblock_alloc_exact_nid_raw(
  *	      is preferred (phys address), or %MEMBLOCK_ALLOC_ACCESSIBLE to
  *	      allocate only from memory limited by memblock.current_limit value
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
+ * @hugepage_size: size of the hugepages in bytes
  *
  * Public function, provides additional debug information (including caller
  * info), if enabled. Does not zero allocated memory, does not panic if request
  * cannot be satisfied.
  *
+ * If hugepage_size is not 0 and HVO is enabled, then only the struct pages
+ * that are not freed by HVO are initialized using the hugepage_size parameter.
+ *
  * Return:
  * Virtual address of allocated memory block on success, NULL on failure.
  */
 void * __init memblock_alloc_try_nid_raw(
 			phys_addr_t size, phys_addr_t align,
 			phys_addr_t min_addr, phys_addr_t max_addr,
-			int nid)
+			int nid, phys_addr_t hugepage_size)
 {
 	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
 		     __func__, (u64)size, (u64)align, nid, &min_addr,
 		     &max_addr, (void *)_RET_IP_);
 
 	return memblock_alloc_internal(size, align, min_addr, max_addr, nid,
-				       false);
+				       false, hugepage_size);
 }
 
 /**
@@ -1634,7 +1648,7 @@ void * __init memblock_alloc_try_nid(
 		     __func__, (u64)size, (u64)align, nid, &min_addr,
 		     &max_addr, (void *)_RET_IP_);
 	ptr = memblock_alloc_internal(size, align,
-					   min_addr, max_addr, nid, false);
+					   min_addr, max_addr, nid, false, 0);
 	if (ptr)
 		memset(ptr, 0, size);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..c36d768bb671 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1615,7 +1615,7 @@ void __init *memmap_alloc(phys_addr_t size, phys_addr_t align,
 	else
 		ptr = memblock_alloc_try_nid_raw(size, align, min_addr,
 						 MEMBLOCK_ALLOC_ACCESSIBLE,
-						 nid);
+						 nid, 0);
 
 	if (ptr && size > 0)
 		page_init_poison(ptr, size);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a044a130405b..56b8b8e684df 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -43,7 +43,7 @@ static void * __ref __earlyonly_bootmem_alloc(int node,
 				unsigned long goal)
 {
 	return memblock_alloc_try_nid_raw(size, align, goal,
-					       MEMBLOCK_ALLOC_ACCESSIBLE, node);
+					       MEMBLOCK_ALLOC_ACCESSIBLE, node, 0);
 }
 
 void * __meminit vmemmap_alloc_block(unsigned long size, int node)
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 49bb416d34ff..225044366fbb 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -43,7 +43,7 @@ static inline void *run_memblock_alloc_nid(phys_addr_t size,
 						    max_addr, nid);
 	if (alloc_nid_test_flags & TEST_F_RAW)
 		return memblock_alloc_try_nid_raw(size, align, min_addr,
-						  max_addr, nid);
+						  max_addr, nid, 0);
 	return memblock_alloc_try_nid(size, align, min_addr, max_addr, nid);
 }
 
-- 
2.25.1

