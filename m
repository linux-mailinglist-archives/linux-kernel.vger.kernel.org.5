Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12CA80D055
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbjLKP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbjLKP6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96710FC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJSSYac1nr+7xVv+4BgklrjvdDaeoEoSEBfa7pAELWg=;
        b=NvdAjT3xHBDI58QOlDRGBJtkg4gP6Vaz/Ig0DFi/o/769AEkg9ZSxyJu0f97H67sSC0Ik/
        O/4vRufZKoFYq0KQsyM4VpKqd1MjyylBBSmQ27rZmpdhBNdrEeToPDtezfJLCGmaWuTp/c
        uJoYrOjj+KWjdNRg/8ItrhnKyTQxPSM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-cwKjNob0OqmmW5y0fjpgYA-1; Mon, 11 Dec 2023 10:58:33 -0500
X-MC-Unique: cwKjNob0OqmmW5y0fjpgYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6830185A787;
        Mon, 11 Dec 2023 15:58:32 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14FA71121306;
        Mon, 11 Dec 2023 15:58:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 38/39] mm: convert page_try_share_anon_rmap() to folio_try_share_anon_rmap_[pte|pmd]()
Date:   Mon, 11 Dec 2023 16:56:51 +0100
Message-ID: <20231211155652.131054-39-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's convert it like we converted all the other rmap functions.
Don't introduce folio_try_share_anon_rmap_ptes() for now, as we don't
have a user that wants rmap batching in sight. Pretty easy to add later.

All users are easy to convert -- only ksm.c doesn't use folios yet but
that is left for future work -- so let's just do it in a single shot.

While at it, turn the BUG_ON into a WARN_ON_ONCE.

Note that page_try_share_anon_rmap() so far didn't care about pte/pmd
mappings (no compound parameter). We're changing that so we can perform
better sanity checks and make the code actually more readable/consistent.
For example, __folio_rmap_sanity_checks() will make sure that a PMD
range actually falls completely into the folio.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 95 +++++++++++++++++++++++++++++++++-----------
 mm/gup.c             |  2 +-
 mm/huge_memory.c     |  9 +++--
 mm/internal.h        |  4 +-
 mm/ksm.c             |  5 ++-
 mm/migrate_device.c  |  2 +-
 mm/rmap.c            | 11 ++---
 7 files changed, 89 insertions(+), 39 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 1e37ee6ae0ba..1e54a28cc884 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -272,7 +272,7 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 	return 0;
 }
 
-/* See page_try_share_anon_rmap() */
+/* See folio_try_share_anon_rmap_*() */
 static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
@@ -481,30 +481,15 @@ static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
 #endif
 }
 
-/**
- * page_try_share_anon_rmap - try marking an exclusive anonymous page possibly
- *			      shared to prepare for KSM or temporary unmapping
- * @page: the exclusive anonymous page to try marking possibly shared
- *
- * The caller needs to hold the PT lock and has to have the page table entry
- * cleared/invalidated.
- *
- * This is similar to folio_try_dup_anon_rmap_*(), however, not used during
- * fork() to duplicate a mapping, but instead to prepare for KSM or temporarily
- * unmapping a page (swap, migration) via folio_remove_rmap_*().
- *
- * Marking the page shared can only fail if the page may be pinned; device
- * private pages cannot get pinned and consequently this function cannot fail.
- *
- * Returns 0 if marking the page possibly shared succeeded. Returns -EBUSY
- * otherwise.
- */
-static inline int page_try_share_anon_rmap(struct page *page)
+static __always_inline int __folio_try_share_anon_rmap(struct folio *folio,
+		struct page *page, int nr_pages, enum rmap_mode mode)
 {
-	VM_BUG_ON_PAGE(!PageAnon(page) || !PageAnonExclusive(page), page);
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	VM_WARN_ON_FOLIO(!PageAnonExclusive(page), folio);
+	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
 
-	/* device private pages cannot get pinned via GUP. */
-	if (unlikely(is_device_private_page(page))) {
+	/* device private folios cannot get pinned via GUP. */
+	if (unlikely(folio_is_device_private(folio))) {
 		ClearPageAnonExclusive(page);
 		return 0;
 	}
@@ -555,7 +540,7 @@ static inline int page_try_share_anon_rmap(struct page *page)
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
 		smp_mb();
 
-	if (unlikely(page_maybe_dma_pinned(page)))
+	if (unlikely(folio_maybe_dma_pinned(folio)))
 		return -EBUSY;
 	ClearPageAnonExclusive(page);
 
@@ -568,6 +553,68 @@ static inline int page_try_share_anon_rmap(struct page *page)
 	return 0;
 }
 
+/**
+ * folio_try_share_anon_rmap_pte - try marking an exclusive anonymous page
+ *				   mapped by a PTE possibly shared to prepare
+ *				   for KSM or temporary unmapping
+ * @folio:	The folio to share a mapping of
+ * @page:	The mapped exclusive page
+ *
+ * The caller needs to hold the page table lock and has to have the page table
+ * entries cleared/invalidated.
+ *
+ * This is similar to folio_try_dup_anon_rmap_pte(), however, not used during
+ * fork() to duplicate mappings, but instead to prepare for KSM or temporarily
+ * unmapping parts of a folio (swap, migration) via folio_remove_rmap_pte().
+ *
+ * Marking the mapped page shared can only fail if the folio maybe pinned;
+ * device private folios cannot get pinned and consequently this function cannot
+ * fail.
+ *
+ * Returns 0 if marking the mapped page possibly shared succeeded. Returns
+ * -EBUSY otherwise.
+ */
+static inline int folio_try_share_anon_rmap_pte(struct folio *folio,
+		struct page *page)
+{
+	return __folio_try_share_anon_rmap(folio, page, 1, RMAP_MODE_PTE);
+}
+
+/**
+ * folio_try_share_anon_rmap_pmd - try marking an exclusive anonymous page
+ *				   range mapped by a PMD possibly shared to
+ *				   prepare for temporary unmapping
+ * @folio:	The folio to share the mapping of
+ * @page:	The first page to share the mapping of
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
+ *
+ * The caller needs to hold the page table lock and has to have the page table
+ * entries cleared/invalidated.
+ *
+ * This is similar to folio_try_dup_anon_rmap_pmd(), however, not used during
+ * fork() to duplicate a mapping, but instead to prepare for temporarily
+ * unmapping parts of a folio (swap, migration) via folio_remove_rmap_pmd().
+ *
+ * Marking the mapped pages shared can only fail if the folio maybe pinned;
+ * device private folios cannot get pinned and consequently this function cannot
+ * fail.
+ *
+ * Returns 0 if marking the mapped pages possibly shared succeeded. Returns
+ * -EBUSY otherwise.
+ */
+static inline int folio_try_share_anon_rmap_pmd(struct folio *folio,
+		struct page *page)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	return __folio_try_share_anon_rmap(folio, page, HPAGE_PMD_NR,
+					 RMAP_MODE_PMD);
+#else
+	WARN_ON_ONCE(true);
+	return -EBUSY;
+#endif
+}
+
 /*
  * Called from mm/vmscan.c to handle paging out
  */
diff --git a/mm/gup.c b/mm/gup.c
index 0a5f0e91bfec..df83182ec72d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -177,7 +177,7 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	/*
 	 * Adjust the pincount before re-checking the PTE for changes.
 	 * This is essentially a smp_mb() and is paired with a memory
-	 * barrier in page_try_share_anon_rmap().
+	 * barrier in folio_try_share_anon_rmap_*().
 	 */
 	smp_mb__after_atomic();
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 34f878916621..c681296fa429 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2523,10 +2523,11 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 * In case we cannot clear PageAnonExclusive(), split the PMD
 		 * only and let try_to_migrate_one() fail later.
 		 *
-		 * See page_try_share_anon_rmap(): invalidate PMD first.
+		 * See folio_try_share_anon_rmap_pmd(): invalidate PMD first.
 		 */
 		anon_exclusive = PageAnonExclusive(page);
-		if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
+		if (freeze && anon_exclusive &&
+		    folio_try_share_anon_rmap_pmd(folio, page))
 			freeze = false;
 		if (!freeze) {
 			rmap_t rmap_flags = RMAP_NONE;
@@ -3554,9 +3555,9 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
 	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
 
-	/* See page_try_share_anon_rmap(): invalidate PMD first. */
+	/* See folio_try_share_anon_rmap_pmd(): invalidate PMD first. */
 	anon_exclusive = folio_test_anon(folio) && PageAnonExclusive(page);
-	if (anon_exclusive && page_try_share_anon_rmap(page)) {
+	if (anon_exclusive && folio_try_share_anon_rmap_pmd(folio, page)) {
 		set_pmd_at(mm, address, pvmw->pmd, pmdval);
 		return -EBUSY;
 	}
diff --git a/mm/internal.h b/mm/internal.h
index a94355e70bd7..29589bc3f046 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1047,7 +1047,7 @@ enum {
  * * Ordinary GUP: Using the PT lock
  * * GUP-fast and fork(): mm->write_protect_seq
  * * GUP-fast and KSM or temporary unmapping (swap, migration): see
- *    page_try_share_anon_rmap()
+ *    folio_try_share_anon_rmap_*()
  *
  * Must be called with the (sub)page that's actually referenced via the
  * page table entry, which might not necessarily be the head page for a
@@ -1090,7 +1090,7 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
 		return is_cow_mapping(vma->vm_flags);
 	}
 
-	/* Paired with a memory barrier in page_try_share_anon_rmap(). */
+	/* Paired with a memory barrier in folio_try_share_anon_rmap_*(). */
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
 		smp_rmb();
 
diff --git a/mm/ksm.c b/mm/ksm.c
index b3d0cfaa2533..be76e9dabf4f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1161,8 +1161,9 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 			goto out_unlock;
 		}
 
-		/* See page_try_share_anon_rmap(): clear PTE first. */
-		if (anon_exclusive && page_try_share_anon_rmap(page)) {
+		/* See folio_try_share_anon_rmap_pte(): clear PTE first. */
+		if (anon_exclusive &&
+		    folio_try_share_anon_rmap_pte(page_folio(page), page)) {
 			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
 			goto out_unlock;
 		}
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index c51c99151ebb..9d0c1ad73722 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -202,7 +202,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (anon_exclusive) {
 				pte = ptep_clear_flush(vma, addr, ptep);
 
-				if (page_try_share_anon_rmap(page)) {
+				if (folio_try_share_anon_rmap_pte(folio, page)) {
 					set_pte_at(mm, addr, ptep, pte);
 					folio_unlock(folio);
 					folio_put(folio);
diff --git a/mm/rmap.c b/mm/rmap.c
index b08dd7d6779d..45296739236f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1868,9 +1868,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				break;
 			}
 
-			/* See page_try_share_anon_rmap(): clear PTE first. */
+			/* See folio_try_share_anon_rmap(): clear PTE first. */
 			if (anon_exclusive &&
-			    page_try_share_anon_rmap(subpage)) {
+			    folio_try_share_anon_rmap_pte(folio, subpage)) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
@@ -2144,7 +2144,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			pte_t swp_pte;
 
 			if (anon_exclusive)
-				BUG_ON(page_try_share_anon_rmap(subpage));
+				WARN_ON_ONCE(folio_try_share_anon_rmap_pte(folio,
+									   subpage));
 
 			/*
 			 * Store the pfn of the page in a special migration
@@ -2215,7 +2216,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			VM_BUG_ON_PAGE(pte_write(pteval) && folio_test_anon(folio) &&
 				       !anon_exclusive, subpage);
 
-			/* See page_try_share_anon_rmap(): clear PTE first. */
+			/* See folio_try_share_anon_rmap_pte(): clear PTE first. */
 			if (folio_test_hugetlb(folio)) {
 				if (anon_exclusive &&
 				    hugetlb_try_share_anon_rmap(folio)) {
@@ -2226,7 +2227,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 					break;
 				}
 			} else if (anon_exclusive &&
-				   page_try_share_anon_rmap(subpage)) {
+				   folio_try_share_anon_rmap_pte(folio, subpage)) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
-- 
2.43.0

