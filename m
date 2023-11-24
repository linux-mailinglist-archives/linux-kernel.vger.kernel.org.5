Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446D37F74EC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345250AbjKXN1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjKXN07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A438170C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJ96IMZVe5oCg8NRltA+Bp5PZmcoSK+MjUKn4pYnke0=;
        b=FM0OJ75bu4CiGpQIwlsLGqL+b36KzF5OtZ08MDNU3rz6kSWBiKvSVdCBLhiCSAcjcfzJ4x
        A5xYJeU7dBXk4M4oajgGIYdH7mVYaCmnthhpAIZjcIndrMg4ja61pqYJ3w2y1Ub1qYrZBb
        qZL72wZIhGyFcmcOP7X1Na1xsRMMu9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-j-wvy56dM2qBkwjy1JR5fQ-1; Fri, 24 Nov 2023 08:26:47 -0500
X-MC-Unique: j-wvy56dM2qBkwjy1JR5fQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E5A4811E7B;
        Fri, 24 Nov 2023 13:26:46 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46A822166B2A;
        Fri, 24 Nov 2023 13:26:43 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH WIP v1 04/20] mm/rmap: pass dst_vma to page_try_dup_anon_rmap() and page_dup_file_rmap()
Date:   Fri, 24 Nov 2023 14:26:09 +0100
Message-ID: <20231124132626.235350-5-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need access to the destination MM when modifying the total mapcount
of a partially-mappable folio next. So pass in the destination VMA for
consistency.

While at it, change the parameter order for page_try_dup_anon_rmap() such
that the "bool compound" parameter is last, to match the other rmap
functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 21 +++++++++++++--------
 mm/huge_memory.c     |  2 +-
 mm/hugetlb.c         |  9 +++++----
 mm/memory.c          |  6 +++---
 mm/migrate.c         |  2 +-
 5 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 42e2c74d4d6e..6cb497f6feab 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -208,7 +208,8 @@ void hugepage_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
-static inline void __page_dup_rmap(struct page *page, bool compound)
+static inline void __page_dup_rmap(struct page *page,
+		struct vm_area_struct *dst_vma, bool compound)
 {
 	struct folio *folio = page_folio(page);
 
@@ -225,17 +226,19 @@ static inline void __page_dup_rmap(struct page *page, bool compound)
 	atomic_inc(&folio->_total_mapcount);
 }
 
-static inline void page_dup_file_rmap(struct page *page, bool compound)
+static inline void page_dup_file_rmap(struct page *page,
+		struct vm_area_struct *dst_vma, bool compound)
 {
-	__page_dup_rmap(page, compound);
+	__page_dup_rmap(page, dst_vma, compound);
 }
 
 /**
  * page_try_dup_anon_rmap - try duplicating a mapping of an already mapped
  *			    anonymous page
  * @page: the page to duplicate the mapping for
+ * @dst_vma: the destination vma
+ * @src_vma: the source vma
  * @compound: the page is mapped as compound or as a small page
- * @vma: the source vma
  *
  * The caller needs to hold the PT lock and the vma->vma_mm->write_protect_seq.
  *
@@ -247,8 +250,10 @@ static inline void page_dup_file_rmap(struct page *page, bool compound)
  *
  * Returns 0 if duplicating the mapping succeeded. Returns -EBUSY otherwise.
  */
-static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
-					 struct vm_area_struct *vma)
+static inline int page_try_dup_anon_rmap(struct page *page,
+					 struct vm_area_struct *dst_vma,
+					 struct vm_area_struct *src_vma,
+					 bool compound)
 {
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 
@@ -267,7 +272,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
 	 * future on write faults.
 	 */
 	if (likely(!is_device_private_page(page) &&
-	    unlikely(page_needs_cow_for_dma(vma, page))))
+	    unlikely(page_needs_cow_for_dma(src_vma, page))))
 		return -EBUSY;
 
 	ClearPageAnonExclusive(page);
@@ -276,7 +281,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
 	 * the page R/O into both processes.
 	 */
 dup:
-	__page_dup_rmap(page, compound);
+	__page_dup_rmap(page, dst_vma, compound);
 	return 0;
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 874eeeb90e0b..51a878efca0e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1166,7 +1166,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
 
 	get_page(src_page);
-	if (unlikely(page_try_dup_anon_rmap(src_page, true, src_vma))) {
+	if (unlikely(page_try_dup_anon_rmap(src_page, dst_vma, src_vma, true))) {
 		/* Page maybe pinned: split and retry the fault on PTEs. */
 		put_page(src_page);
 		pte_free(dst_mm, pgtable);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cf84784064c7..1ddef4082cad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5401,9 +5401,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * sleep during the process.
 			 */
 			if (!folio_test_anon(pte_folio)) {
-				page_dup_file_rmap(&pte_folio->page, true);
+				page_dup_file_rmap(&pte_folio->page, dst_vma,
+						   true);
 			} else if (page_try_dup_anon_rmap(&pte_folio->page,
-							  true, src_vma)) {
+							  dst_vma, src_vma, true)) {
 				pte_t src_pte_old = entry;
 				struct folio *new_folio;
 
@@ -6272,7 +6273,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	if (anon_rmap)
 		hugepage_add_new_anon_rmap(folio, vma, haddr);
 	else
-		page_dup_file_rmap(&folio->page, true);
+		page_dup_file_rmap(&folio->page, vma, true);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	/*
@@ -6723,7 +6724,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
-		page_dup_file_rmap(&folio->page, true);
+		page_dup_file_rmap(&folio->page, dst_vma, true);
 	else
 		hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
diff --git a/mm/memory.c b/mm/memory.c
index 6bcfa763a146..14416d05e1b6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -836,7 +836,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		get_page(page);
 		rss[mm_counter(page)]++;
 		/* Cannot fail as these pages cannot get pinned. */
-		BUG_ON(page_try_dup_anon_rmap(page, false, src_vma));
+		BUG_ON(page_try_dup_anon_rmap(page, dst_vma, src_vma, false));
 
 		/*
 		 * We do not preserve soft-dirty information, because so
@@ -950,7 +950,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		 * future.
 		 */
 		folio_get(folio);
-		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
+		if (unlikely(page_try_dup_anon_rmap(page, dst_vma, src_vma, false))) {
 			/* Page may be pinned, we have to copy. */
 			folio_put(folio);
 			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
@@ -959,7 +959,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		rss[MM_ANONPAGES]++;
 	} else if (page) {
 		folio_get(folio);
-		page_dup_file_rmap(page, false);
+		page_dup_file_rmap(page, dst_vma, false);
 		rss[mm_counter_file(page)]++;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index fda41bc09903..341a84c3e8e4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -252,7 +252,7 @@ static bool remove_migration_pte(struct folio *folio,
 				hugepage_add_anon_rmap(folio, vma, pvmw.address,
 						       rmap_flags);
 			else
-				page_dup_file_rmap(new, true);
+				page_dup_file_rmap(new, vma, true);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte,
 					psize);
 		} else
-- 
2.41.0

