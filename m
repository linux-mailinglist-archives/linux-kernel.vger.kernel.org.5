Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56AD7B44D7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 02:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjJAA6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 20:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjJAA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 20:58:05 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31638D3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 17:58:02 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qmklZ-0008G8-0V;
        Sat, 30 Sep 2023 20:57:01 -0400
From:   riel@surriel.com
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, leit@meta.com, willy@infradead.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and page fault
Date:   Sat, 30 Sep 2023 20:55:49 -0400
Message-ID: <20231001005659.2185316-3-riel@surriel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001005659.2185316-1-riel@surriel.com>
References: <20231001005659.2185316-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

Malloc libraries, like jemalloc and tcalloc, take decisions on when
to call madvise independently from the code in the main application.

This sometimes results in the application page faulting on an address,
right after the malloc library has shot down the backing memory with
MADV_DONTNEED.

Usually this is harmless, because we always have some 4kB pages
sitting around to satisfy a page fault. However, with hugetlbfs
systems often allocate only the exact number of huge pages that
the application wants.

Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
any lock taken on the page fault path, which can open up the following
race condition:

       CPU 1                            CPU 2

       MADV_DONTNEED
       unmap page
       shoot down TLB entry
                                       page fault
                                       fail to allocate a huge page
                                       killed with SIGBUS
       free page

Fix that race by pulling the locking from __unmap_hugepage_final_range
into helper functions called from zap_page_range_single. This ensures
page faults stay locked out of the MADV_DONTNEED VMA until the
huge pages have actually been freed.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/hugetlb.h | 35 +++++++++++++++++++++++++++++++++--
 mm/hugetlb.c            | 20 +++++++++++---------
 mm/memory.c             | 13 ++++++++-----
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 694928fa06a3..d9ec500cfef9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -139,7 +139,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 void unmap_hugepage_range(struct vm_area_struct *,
 			  unsigned long, unsigned long, struct page *,
 			  zap_flags_t);
-void __unmap_hugepage_range_final(struct mmu_gather *tlb,
+void __unmap_hugepage_range(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
 			  struct page *ref_page, zap_flags_t zap_flags);
@@ -246,6 +246,25 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
 
+extern void __hugetlb_zap_begin(struct vm_area_struct *vma,
+				unsigned long *begin, unsigned long *end);
+extern void __hugetlb_zap_end(struct vm_area_struct *vma,
+			      struct zap_details *details);
+
+static inline void hugetlb_zap_begin(struct vm_area_struct *vma,
+				     unsigned long *start, unsigned long *end)
+{
+	if (is_vm_hugetlb_page(vma))
+		__hugetlb_zap_begin(vma, start, end);
+}
+
+static inline void hugetlb_zap_end(struct vm_area_struct *vma,
+				   struct zap_details *details)
+{
+	if (is_vm_hugetlb_page(vma))
+		__hugetlb_zap_end(vma, details);
+}
+
 void hugetlb_vma_lock_read(struct vm_area_struct *vma);
 void hugetlb_vma_unlock_read(struct vm_area_struct *vma);
 void hugetlb_vma_lock_write(struct vm_area_struct *vma);
@@ -297,6 +316,18 @@ static inline void adjust_range_if_pmd_sharing_possible(
 {
 }
 
+static inline void hugetlb_zap_begin(
+				struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+}
+
+static inline void hugetlb_zap_end(
+				struct vm_area_struct *vma,
+				struct zap_details *details)
+{
+}
+
 static inline struct page *hugetlb_follow_page_mask(
     struct vm_area_struct *vma, unsigned long address, unsigned int flags,
     unsigned int *page_mask)
@@ -442,7 +473,7 @@ static inline long hugetlb_change_protection(
 	return 0;
 }
 
-static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
+static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, struct page *ref_page,
 			zap_flags_t zap_flags)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ee7497f37098..397a26f70deb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5306,9 +5306,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	return len + old_addr - old_end;
 }
 
-static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end,
-				   struct page *ref_page, zap_flags_t zap_flags)
+void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end,
+			    struct page *ref_page, zap_flags_t zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -5435,16 +5435,18 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		tlb_flush_mmu_tlbonly(tlb);
 }
 
-void __unmap_hugepage_range_final(struct mmu_gather *tlb,
-			  struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, struct page *ref_page,
-			  zap_flags_t zap_flags)
+void __hugetlb_zap_begin(struct vm_area_struct *vma,
+			 unsigned long *start, unsigned long *end)
 {
+	adjust_range_if_pmd_sharing_possible(vma, start, end);
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
+}
 
-	/* mmu notification performed in caller */
-	__unmap_hugepage_range(tlb, vma, start, end, ref_page, zap_flags);
+void __hugetlb_zap_end(struct vm_area_struct *vma,
+		       struct zap_details *details)
+{
+	zap_flags_t zap_flags = details ? details->zap_flags : 0;
 
 	if (zap_flags & ZAP_FLAG_UNMAP) {	/* final unmap */
 		/*
diff --git a/mm/memory.c b/mm/memory.c
index 6c264d2f969c..517221f01303 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1683,7 +1683,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			if (vma->vm_file) {
 				zap_flags_t zap_flags = details ?
 				    details->zap_flags : 0;
-				__unmap_hugepage_range_final(tlb, vma, start, end,
+				__unmap_hugepage_range(tlb, vma, start, end,
 							     NULL, zap_flags);
 			}
 		} else
@@ -1728,8 +1728,12 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
 	do {
-		unmap_single_vma(tlb, vma, start_addr, end_addr, &details,
+		unsigned long start = start_addr;
+		unsigned long end = end_addr;
+		hugetlb_zap_begin(vma, &start, &end);
+		unmap_single_vma(tlb, vma, start, end, &details,
 				 mm_wr_locked);
+		hugetlb_zap_end(vma, &details);
 	} while ((vma = mas_find(mas, tree_end - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
@@ -1753,9 +1757,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address, end);
-	if (is_vm_hugetlb_page(vma))
-		adjust_range_if_pmd_sharing_possible(vma, &range.start,
-						     &range.end);
+	hugetlb_zap_begin(vma, &range.start, &range.end);
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1766,6 +1768,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	unmap_single_vma(&tlb, vma, address, end, details, false);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
+	hugetlb_zap_end(vma, details);
 }
 
 /**
-- 
2.41.0

