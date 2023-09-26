Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588997AE320
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjIZAx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjIZAxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:53:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDF010E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:53:11 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rvh4c4Mp8z15Mq5;
        Tue, 26 Sep 2023 08:50:56 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 08:53:09 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 3/9] mm: huge_memory: use a folio in change_huge_pmd()
Date:   Tue, 26 Sep 2023 08:52:48 +0800
Message-ID: <20230926005254.2861577-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
References: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a folio in change_huge_pmd(), this is in preparation for
xchg_page_access_time() to folio conversion.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0f93a73115f7..c7efa214add8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1849,7 +1849,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 	if (is_swap_pmd(*pmd)) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
-		struct page *page = pfn_swap_entry_to_page(entry);
+		struct folio *folio = page_folio(pfn_swap_entry_to_page(entry));
 		pmd_t newpmd;
 
 		VM_BUG_ON(!is_pmd_migration_entry(*pmd));
@@ -1858,7 +1858,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			 * A protection check is difficult so
 			 * just be safe and disable write
 			 */
-			if (PageAnon(page))
+			if (folio_test_anon(folio))
 				entry = make_readable_exclusive_migration_entry(swp_offset(entry));
 			else
 				entry = make_readable_migration_entry(swp_offset(entry));
@@ -1880,7 +1880,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #endif
 
 	if (prot_numa) {
-		struct page *page;
+		struct folio *folio;
 		bool toptier;
 		/*
 		 * Avoid trapping faults against the zero page. The read-only
@@ -1893,8 +1893,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (pmd_protnone(*pmd))
 			goto unlock;
 
-		page = pmd_page(*pmd);
-		toptier = node_is_toptier(page_to_nid(page));
+		folio = page_folio(pmd_page(*pmd));
+		toptier = node_is_toptier(folio_nid(folio));
 		/*
 		 * Skip scanning top tier node if normal numa
 		 * balancing is disabled
@@ -1905,7 +1905,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 		    !toptier)
-			xchg_page_access_time(page, jiffies_to_msecs(jiffies));
+			xchg_page_access_time(&folio->page,
+					      jiffies_to_msecs(jiffies));
 	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
-- 
2.27.0

