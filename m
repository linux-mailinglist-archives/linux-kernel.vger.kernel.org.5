Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588B47CDE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjJROJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344856AbjJROJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5B095
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:09:07 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9Xdw4TSzzvQ9v;
        Wed, 18 Oct 2023 22:04:20 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 22:09:04 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 10/19] mm: huge_memory: use a folio in change_huge_pmd()
Date:   Wed, 18 Oct 2023 22:07:57 +0800
Message-ID: <20231018140806.2783514-11-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
References: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a folio in change_huge_pmd(), which helps to remove last
xchg_page_access_time() caller.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5455dfe4c3c7..f01f345141da 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1856,7 +1856,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 	if (is_swap_pmd(*pmd)) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
-		struct page *page = pfn_swap_entry_to_page(entry);
+		struct folio *folio = page_folio(pfn_swap_entry_to_page(entry));
 		pmd_t newpmd;
 
 		VM_BUG_ON(!is_pmd_migration_entry(*pmd));
@@ -1865,7 +1865,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			 * A protection check is difficult so
 			 * just be safe and disable write
 			 */
-			if (PageAnon(page))
+			if (folio_test_anon(folio))
 				entry = make_readable_exclusive_migration_entry(swp_offset(entry));
 			else
 				entry = make_readable_migration_entry(swp_offset(entry));
@@ -1887,7 +1887,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #endif
 
 	if (prot_numa) {
-		struct page *page;
+		struct folio *folio;
 		bool toptier;
 		/*
 		 * Avoid trapping faults against the zero page. The read-only
@@ -1900,8 +1900,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (pmd_protnone(*pmd))
 			goto unlock;
 
-		page = pmd_page(*pmd);
-		toptier = node_is_toptier(page_to_nid(page));
+		folio = page_folio(pmd_page(*pmd));
+		toptier = node_is_toptier(folio_nid(folio));
 		/*
 		 * Skip scanning top tier node if normal numa
 		 * balancing is disabled
@@ -1912,7 +1912,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 		    !toptier)
-			xchg_page_access_time(page, jiffies_to_msecs(jiffies));
+			folio_xchg_access_time(folio,
+					       jiffies_to_msecs(jiffies));
 	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
-- 
2.27.0

