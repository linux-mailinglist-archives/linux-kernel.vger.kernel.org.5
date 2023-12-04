Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57673803656
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345121AbjLDOWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbjLDOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E45011A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8nY91srGGOwHNmHB2IEECEkScJep9NeXgCbzBUOTxo=;
        b=BmVJAIfPcw8rV5BGoidQnofxE4E/A0/J/jJhmDh52n2XVTFrMcDXqQMaUiz+gzvkj3P51+
        Ft+xOoDjefgMiIbOBsB4lC1IYY3fC0DcHmrjzAgQ2+4sonKBJ7z/y9dTILCBd38EQNlOSE
        DHFD2dZhkaEo8VS2dGUEVo7LMumlQpw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-g2weQkhwMp-9jFxobmepBA-1; Mon,
 04 Dec 2023 09:22:02 -0500
X-MC-Unique: g2weQkhwMp-9jFxobmepBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE9EB1C0514B;
        Mon,  4 Dec 2023 14:22:01 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 118622026D68;
        Mon,  4 Dec 2023 14:21:59 +0000 (UTC)
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
Subject: [PATCH RFC 07/39] mm/rmap: convert folio_add_file_rmap_range() into folio_add_file_rmap_[pte|ptes|pmd]()
Date:   Mon,  4 Dec 2023 15:21:14 +0100
Message-ID: <20231204142146.91437-8-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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
always special-case on the granularity by using __always_inline.

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
 include/linux/rmap.h | 47 +++++++++++++++++++++++++++--
 mm/memory.c          |  2 +-
 mm/rmap.c            | 72 ++++++++++++++++++++++++++++----------------
 3 files changed, 92 insertions(+), 29 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 77e336f86c72d..a4a30c361ac50 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -186,6 +186,45 @@ typedef int __bitwise rmap_t;
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
+		struct page *page, unsigned int nr_pages, enum rmap_mode mode)
+{
+	/* hugetlb folios are handled separately. */
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_large(folio) &&
+			 !folio_test_large_rmappable(folio), folio);
+
+	VM_WARN_ON_ONCE(!nr_pages || nr_pages > folio_nr_pages(folio));
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
@@ -198,8 +237,12 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 void page_add_file_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
-void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
-		struct vm_area_struct *, bool compound);
+void folio_add_file_rmap_ptes(struct folio *, struct page *, unsigned int nr,
+		struct vm_area_struct *);
+#define folio_add_file_rmap_pte(folio, page, vma) \
+	folio_add_file_rmap_ptes(folio, page, 1, vma)
+void folio_add_file_rmap_pmd(struct folio *, struct page *,
+		struct vm_area_struct *);
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 
diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a54971..15325587cff01 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4414,7 +4414,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		folio_add_lru_vma(folio, vma);
 	} else {
 		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
-		folio_add_file_rmap_range(folio, page, nr, vma, false);
+		folio_add_file_rmap_ptes(folio, page, nr, vma);
 	}
 	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index a735ecca47a81..1614d98062948 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1334,31 +1334,19 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	SetPageAnonExclusive(&folio->page);
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
+		struct page *page, unsigned int nr_pages,
+		struct vm_area_struct *vma, enum rmap_mode mode)
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
+	if (likely(mode == RMAP_MODE_PTE)) {
 		do {
 			first = atomic_inc_and_test(&page->_mapcount);
 			if (first && folio_test_large(folio)) {
@@ -1369,9 +1357,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 			if (first)
 				nr++;
 		} while (page++, --nr_pages > 0);
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
+	} else if (mode == RMAP_MODE_PMD) {
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
@@ -1399,6 +1385,43 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
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
+		unsigned int nr_pages, struct vm_area_struct *vma)
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
@@ -1411,16 +1434,13 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
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
2.41.0

