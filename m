Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72F980D02E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbjLKP52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbjLKP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A14E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYkHAajZElCwYCEwnUcbPY1wmlYkOiWYX0LP3vDIRKY=;
        b=KWKhpbCCYQYSNrnF/x008JUiuE7WszyL2p972EGZNnyWjNABQbsw0VYI7Gh7p1fMxgVxPm
        sD+8mTAlYll0g4crKBffqoAp4E8fbDqg5xAzGmK6YIKp53FIIKJlhK7RqGQ9plm7cc6SVZ
        Br/TBRIyck62HeQns74s9YKitP7yvbE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-vLDkjjTeNrqXiJAcMx9kjQ-1; Mon, 11 Dec 2023 10:57:15 -0500
X-MC-Unique: vLDkjjTeNrqXiJAcMx9kjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E97A4185A780;
        Mon, 11 Dec 2023 15:57:14 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEE511121306;
        Mon, 11 Dec 2023 15:57:12 +0000 (UTC)
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
Subject: [PATCH v1 07/39] mm/rmap: convert folio_add_file_rmap_range() into folio_add_file_rmap_[pte|ptes|pmd]()
Date:   Mon, 11 Dec 2023 16:56:20 +0100
Message-ID: <20231211155652.131054-8-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's get rid of the compound parameter and instead define implicitly
which mappings we're adding. That is more future proof, easier to read
and harder to mess up.

Use an enum to express the granularity internally. Make the compiler
always special-case on the granularity by using __always_inline. Replace
the "compound" check by a switch-case that will be removed by the
compiler completely.

Add plenty of sanity checks with CONFIG_DEBUG_VM. Replace the
folio_test_pmd_mappable() check by a config check in the caller and
sanity checks. Convert the single user of folio_add_file_rmap_range().

This function design can later easily be extended to PUDs and to batch
PMDs. Note that for now we don't support anything bigger than
PMD-sized folios (as we cleanly separated hugetlb handling). Sanity checks
will catch if that ever changes.

Next up is removing page_remove_rmap() along with its "compound"
parameter and smilarly converting all other rmap functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 47 +++++++++++++++++++++++++--
 mm/memory.c          |  2 +-
 mm/rmap.c            | 75 +++++++++++++++++++++++++++++---------------
 3 files changed, 95 insertions(+), 29 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e3857d26b944..1753900f4aed 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -191,6 +191,45 @@ typedef int __bitwise rmap_t;
  */
 #define RMAP_COMPOUND		((__force rmap_t)BIT(1))
 
+/*
+ * Internally, we're using an enum to specify the granularity. Usually,
+ * we make the compiler create specialized variants for the different
+ * granularity.
+ */
+enum rmap_mode {
+	RMAP_MODE_PTE = 0,
+	RMAP_MODE_PMD,
+};
+
+static inline void __folio_rmap_sanity_checks(struct folio *folio,
+		struct page *page, int nr_pages, enum rmap_mode mode)
+{
+	/* hugetlb folios are handled separately. */
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_large(folio) &&
+			 !folio_test_large_rmappable(folio), folio);
+
+	VM_WARN_ON_ONCE(nr_pages <= 0);
+	VM_WARN_ON_FOLIO(page_folio(page) != folio, folio);
+	VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio);
+
+	switch (mode) {
+	case RMAP_MODE_PTE:
+		break;
+	case RMAP_MODE_PMD:
+		/*
+		 * We don't support folios larger than a single PMD yet. So
+		 * when RMAP_MODE_PMD is set, we assume that we are creating
+		 * a single "entire" mapping of the folio.
+		 */
+		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
+		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
+		break;
+	default:
+		VM_WARN_ON_ONCE(true);
+	}
+}
+
 /*
  * rmap interfaces called when adding or removing pte of page
  */
@@ -203,8 +242,12 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 void page_add_file_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
-void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
-		struct vm_area_struct *, bool compound);
+void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
+		struct vm_area_struct *);
+#define folio_add_file_rmap_pte(folio, page, vma) \
+	folio_add_file_rmap_ptes(folio, page, 1, vma)
+void folio_add_file_rmap_pmd(struct folio *, struct page *,
+		struct vm_area_struct *);
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 
diff --git a/mm/memory.c b/mm/memory.c
index 8f0b936b90b5..6a5540ba3c65 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4515,7 +4515,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		folio_add_lru_vma(folio, vma);
 	} else {
 		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
-		folio_add_file_rmap_range(folio, page, nr, vma, false);
+		folio_add_file_rmap_ptes(folio, page, nr, vma);
 	}
 	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 41597da14f26..4f30930a1162 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1376,31 +1376,20 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
 }
 
-/**
- * folio_add_file_rmap_range - add pte mapping to page range of a folio
- * @folio:	The folio to add the mapping to
- * @page:	The first page to add
- * @nr_pages:	The number of pages which will be mapped
- * @vma:	the vm area in which the mapping is added
- * @compound:	charge the page as compound or small page
- *
- * The page range of folio is defined by [first_page, first_page + nr_pages)
- *
- * The caller needs to hold the pte lock.
- */
-void folio_add_file_rmap_range(struct folio *folio, struct page *page,
-			unsigned int nr_pages, struct vm_area_struct *vma,
-			bool compound)
+static __always_inline void __folio_add_file_rmap(struct folio *folio,
+		struct page *page, int nr_pages, struct vm_area_struct *vma,
+		enum rmap_mode mode)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	unsigned int nr_pmdmapped = 0, first;
 	int nr = 0;
 
-	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
-	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
+	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
-	if (likely(!compound)) {
+	switch (mode) {
+	case RMAP_MODE_PTE:
 		do {
 			first = atomic_inc_and_test(&page->_mapcount);
 			if (first && folio_test_large(folio)) {
@@ -1411,9 +1400,8 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 			if (first)
 				nr++;
 		} while (page++, --nr_pages > 0);
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
+		break;
+	case RMAP_MODE_PMD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
@@ -1428,6 +1416,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 				nr = 0;
 			}
 		}
+		break;
 	}
 
 	if (nr_pmdmapped)
@@ -1441,6 +1430,43 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 		mlock_vma_folio(folio, vma);
 }
 
+/**
+ * folio_add_file_rmap_ptes - add PTE mappings to a page range of a folio
+ * @folio:	The folio to add the mappings to
+ * @page:	The first page to add
+ * @nr_pages:	The number of pages that will be mapped using PTEs
+ * @vma:	The vm area in which the mappings are added
+ *
+ * The page range of the folio is defined by [page, page + nr_pages)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
+		int nr_pages, struct vm_area_struct *vma)
+{
+	__folio_add_file_rmap(folio, page, nr_pages, vma, RMAP_MODE_PTE);
+}
+
+/**
+ * folio_add_file_rmap_pmd - add a PMD mapping to a page range of a folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @vma:	The vm area in which the mapping is added
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	__folio_add_file_rmap(folio, page, HPAGE_PMD_NR, vma, RMAP_MODE_PMD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /**
  * page_add_file_rmap - add pte mapping to a file page
  * @page:	the page to add the mapping to
@@ -1453,16 +1479,13 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 		bool compound)
 {
 	struct folio *folio = page_folio(page);
-	unsigned int nr_pages;
 
 	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
 
 	if (likely(!compound))
-		nr_pages = 1;
+		folio_add_file_rmap_pte(folio, page, vma);
 	else
-		nr_pages = folio_nr_pages(folio);
-
-	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
+		folio_add_file_rmap_pmd(folio, page, vma);
 }
 
 /**
-- 
2.43.0

