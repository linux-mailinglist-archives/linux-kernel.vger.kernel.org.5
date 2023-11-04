Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800887E0DB9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbjKDD4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345405AbjKDDzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:55:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B5D47;
        Fri,  3 Nov 2023 20:55:46 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMkGH51DZzrTXs;
        Sat,  4 Nov 2023 11:52:39 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 4 Nov 2023 11:55:44 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 10/10] mm: convert mm_counter_file() to take a folio
Date:   Sat, 4 Nov 2023 11:55:22 +0800
Message-ID: <20231104035522.2418660-11-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231104035522.2418660-1-wangkefeng.wang@huawei.com>
References: <20231104035522.2418660-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all mm_counter_file() callers with a folio, let's convert
mm_counter_file() to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h      |  8 ++++----
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  5 +++--
 mm/khugepaged.c         |  4 ++--
 mm/memory.c             | 10 +++++-----
 mm/rmap.c               |  2 +-
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fea78900bf84..95573065a46b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2583,10 +2583,10 @@ static inline void dec_mm_counter(struct mm_struct *mm, int member)
 	mm_trace_rss_stat(mm, member);
 }
 
-/* Optimized variant when page is already known not to be PageAnon */
-static inline int mm_counter_file(struct page *page)
+/* Optimized variant when folio is already known not to be anon */
+static inline int mm_counter_file(struct folio *folio)
 {
-	if (PageSwapBacked(page))
+	if (folio_test_swapbacked(folio))
 		return MM_SHMEMPAGES;
 	return MM_FILEPAGES;
 }
@@ -2595,7 +2595,7 @@ static inline int mm_counter(struct folio *folio)
 {
 	if (folio_test_anon(folio))
 		return MM_ANONPAGES;
-	return mm_counter_file(&folio->page);
+	return mm_counter_file(folio);
 }
 
 static inline unsigned long get_mm_rss(struct mm_struct *mm)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 435aac1d8c27..ce251e3a4ae6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -188,7 +188,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		dec_mm_counter(mm, MM_ANONPAGES);
 
 	if (!folio_test_anon(old_folio)) {
-		dec_mm_counter(mm, mm_counter_file(old_page));
+		dec_mm_counter(mm, mm_counter_file(old_folio));
 		inc_mm_counter(mm, MM_ANONPAGES);
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78a00fe22c2d..88420d067477 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1742,7 +1742,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		} else {
 			if (arch_needs_pgtable_deposit())
 				zap_deposited_table(tlb->mm, pmd);
-			add_mm_counter(tlb->mm, mm_counter_file(page), -HPAGE_PMD_NR);
+			add_mm_counter(tlb->mm, mm_counter_file(folio),
+				       -HPAGE_PMD_NR);
 		}
 
 		spin_unlock(ptl);
@@ -2143,7 +2144,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			page_remove_rmap(&folio->page, vma, true);
 			folio_put(folio);
 		}
-		add_mm_counter(mm, mm_counter_file(&folio->page), -HPAGE_PMD_NR);
+		add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
 		return;
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 064654717843..39393f4262b2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1630,7 +1630,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	/* step 3: set proper refcount and mm_counters. */
 	if (nr_ptes) {
 		folio_ref_sub(folio, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(&folio->page), -nr_ptes);
+		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
 	}
 
 	/* step 4: remove empty page table */
@@ -1661,7 +1661,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (nr_ptes) {
 		flush_tlb_mm(mm);
 		folio_ref_sub(folio, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(&folio->page), -nr_ptes);
+		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
 	}
 	if (start_pte)
 		pte_unmap_unlock(start_pte, ptl);
diff --git a/mm/memory.c b/mm/memory.c
index ad30d4ad2223..3418ace5e0ad 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -960,7 +960,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	} else if (page) {
 		folio_get(folio);
 		page_dup_file_rmap(page, false);
-		rss[mm_counter_file(page)]++;
+		rss[mm_counter_file(folio)]++;
 	}
 
 	/*
@@ -1857,7 +1857,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 	folio = page_folio(page);
 	/* Ok, finally just insert the thing.. */
 	folio_get(folio);
-	inc_mm_counter(vma->vm_mm, mm_counter_file(page));
+	inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 	page_add_file_rmap(page, vma, false);
 	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
 	return 0;
@@ -3166,7 +3166,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	if (likely(vmf->pte && pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 		if (old_folio) {
 			if (!folio_test_anon(old_folio)) {
-				dec_mm_counter(mm, mm_counter_file(&old_folio->page));
+				dec_mm_counter(mm, mm_counter_file(old_folio));
 				inc_mm_counter(mm, MM_ANONPAGES);
 			}
 		} else {
@@ -4359,7 +4359,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
+	add_mm_counter(vma->vm_mm, mm_counter_file(folio), HPAGE_PMD_NR);
 	page_add_file_rmap(page, vma, true);
 
 	/*
@@ -4422,7 +4422,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		folio_add_new_anon_rmap(folio, vma, addr);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
+		add_mm_counter(vma->vm_mm, mm_counter_file(folio), nr);
 		folio_add_file_rmap_range(folio, page, nr, vma, false);
 	}
 	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
diff --git a/mm/rmap.c b/mm/rmap.c
index 7a563490ce08..9e3d0eff8b05 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1801,7 +1801,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 *
 			 * See Documentation/mm/mmu_notifier.rst
 			 */
-			dec_mm_counter(mm, mm_counter_file(&folio->page));
+			dec_mm_counter(mm, mm_counter_file(folio));
 		}
 discard:
 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
-- 
2.27.0

