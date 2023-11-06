Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83537E291F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjKFPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjKFPuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:50:16 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B1D69;
        Mon,  6 Nov 2023 07:50:09 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SPG1X25YHz1P7x5;
        Mon,  6 Nov 2023 23:46:56 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 23:50:02 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 09/10] mm: convert mm_counter() to take a folio
Date:   Mon, 6 Nov 2023 23:49:49 +0800
Message-ID: <20231106154950.3399469-10-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231106154950.3399469-1-wangkefeng.wang@huawei.com>
References: <20231106154950.3399469-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all mm_counter() callers with a folio, let's convert
mm_counter() to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/s390/mm/pgtable.c |  2 +-
 include/linux/mm.h     |  6 +++---
 mm/memory.c            | 10 +++++-----
 mm/rmap.c              |  8 ++++----
 mm/userfaultfd.c       |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 2f946b493fff..54b184648db6 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -732,7 +732,7 @@ static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 	else if (is_migration_entry(entry)) {
 		struct folio *folio = pfn_swap_entry_to_folio(entry);
 
-		dec_mm_counter(mm, mm_counter(&folio->page));
+		dec_mm_counter(mm, mm_counter(folio));
 	}
 	free_swap_and_cache(entry);
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..fea78900bf84 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2591,11 +2591,11 @@ static inline int mm_counter_file(struct page *page)
 	return MM_FILEPAGES;
 }
 
-static inline int mm_counter(struct page *page)
+static inline int mm_counter(struct folio *folio)
 {
-	if (PageAnon(page))
+	if (folio_test_anon(folio))
 		return MM_ANONPAGES;
-	return mm_counter_file(page);
+	return mm_counter_file(&folio->page);
 }
 
 static inline unsigned long get_mm_rss(struct mm_struct *mm)
diff --git a/mm/memory.c b/mm/memory.c
index dd3760988e02..3ffef84dd7bb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -803,7 +803,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	} else if (is_migration_entry(entry)) {
 		folio = pfn_swap_entry_to_folio(entry);
 
-		rss[mm_counter(&folio->page)]++;
+		rss[mm_counter(folio)]++;
 
 		if (!is_readable_migration_entry(entry) &&
 				is_cow_mapping(vm_flags)) {
@@ -835,7 +835,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * keep things as they are.
 		 */
 		folio_get(folio);
-		rss[mm_counter(page)]++;
+		rss[mm_counter(folio)]++;
 		/* Cannot fail as these pages cannot get pinned. */
 		BUG_ON(page_try_dup_anon_rmap(page, false, src_vma));
 
@@ -1466,7 +1466,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				if (pte_young(ptent) && likely(vma_has_recency(vma)))
 					folio_mark_accessed(folio);
 			}
-			rss[mm_counter(page)]--;
+			rss[mm_counter(folio)]--;
 			if (!delay_rmap) {
 				page_remove_rmap(page, vma, false);
 				if (unlikely(page_mapcount(page) < 0))
@@ -1496,7 +1496,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			 * see zap_install_uffd_wp_if_needed().
 			 */
 			WARN_ON_ONCE(!vma_is_anonymous(vma));
-			rss[mm_counter(page)]--;
+			rss[mm_counter(folio)]--;
 			if (is_device_private_entry(entry))
 				page_remove_rmap(page, vma, false);
 			folio_put(folio);
@@ -1511,7 +1511,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			folio = pfn_swap_entry_to_folio(entry);
 			if (!should_zap_folio(details, folio))
 				continue;
-			rss[mm_counter(&folio->page)]--;
+			rss[mm_counter(folio)]--;
 		} else if (pte_marker_entry_uffd_wp(entry)) {
 			/*
 			 * For anon: always drop the marker; for file: only
diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..7a563490ce08 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1678,7 +1678,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				set_huge_pte_at(mm, address, pvmw.pte, pteval,
 						hsz);
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter(folio));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -1693,7 +1693,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter(folio));
 		} else if (folio_test_anon(folio)) {
 			swp_entry_t entry = page_swap_entry(subpage);
 			pte_t swp_pte;
@@ -2075,7 +2075,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				set_huge_pte_at(mm, address, pvmw.pte, pteval,
 						hsz);
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter(folio));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -2090,7 +2090,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter(folio));
 		} else {
 			swp_entry_t entry;
 			pte_t swp_pte;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 96d9eae5c7cc..9a6759fa9b06 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -124,7 +124,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	 * Must happen after rmap, as mm_counter() checks mapping (via
 	 * PageAnon()), which is set by __page_set_anon_rmap().
 	 */
-	inc_mm_counter(dst_mm, mm_counter(page));
+	inc_mm_counter(dst_mm, mm_counter(folio));
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
-- 
2.27.0

