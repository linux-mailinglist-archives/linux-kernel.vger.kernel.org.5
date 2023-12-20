Return-Path: <linux-kernel+bounces-7531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27D81A94F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B21B249DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B264A9BB;
	Wed, 20 Dec 2023 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z75FHK3B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7C4C603
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KK8FwY1ijiDBkQheEy+hwW/ONUEObbiexE1hMATnzWI=;
	b=Z75FHK3B3xBLe1kW5dLtuQBfZYhhfKiOXZvckz94YFOAXILP02xWZ3iEfhWabGhodS79zR
	jGVRHMKE+c6jWQIqUpgBYfjduZCwsZ8XP+dQ5WpqutCNhdZ/DpxoLzpufPWHYyNjrqcEZf
	MfgeicKFCeXjCXzyZ8cPNbIA4AVbiQw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-rNvmpqCaPpiEFQBUirp3Jg-1; Wed,
 20 Dec 2023 17:45:26 -0500
X-MC-Unique: rNvmpqCaPpiEFQBUirp3Jg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D9911C41B25;
	Wed, 20 Dec 2023 22:45:25 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5448740C6EB9;
	Wed, 20 Dec 2023 22:45:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 07/40] mm/rmap: convert folio_add_file_rmap_range() into folio_add_file_rmap_[pte|ptes|pmd]()
Date: Wed, 20 Dec 2023 23:44:31 +0100
Message-ID: <20231220224504.646757-8-david@redhat.com>
In-Reply-To: <20231220224504.646757-1-david@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Let's get rid of the compound parameter and instead define explicitly
which mappings we're adding. That is more future proof, easier to read
and harder to mess up.

Use an enum to express the granularity internally. Make the compiler
always special-case on the granularity by using __always_inline. Replace
the "compound" check by a switch-case that will be removed by the
compiler completely.

Add plenty of sanity checks with CONFIG_DEBUG_VM. Replace the
folio_test_pmd_mappable() check by a config check in the caller and
sanity checks. Convert the single user of folio_add_file_rmap_range().

While at it, consistently use "int" instead of "unisgned int" in rmap
code when dealing with mapcounts and the number of pages.

This function design can later easily be extended to PUDs and to batch
PMDs. Note that for now we don't support anything bigger than
PMD-sized folios (as we cleanly separated hugetlb handling). Sanity checks
will catch if that ever changes.

Next up is removing page_remove_rmap() along with its "compound"
parameter and smilarly converting all other rmap functions.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 46 ++++++++++++++++++++++++--
 mm/memory.c          |  2 +-
 mm/rmap.c            | 79 ++++++++++++++++++++++++++++----------------
 3 files changed, 95 insertions(+), 32 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index d6fefa0f04105..3d86a76b28368 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -191,6 +191,44 @@ typedef int __bitwise rmap_t;
  */
 #define RMAP_COMPOUND		((__force rmap_t)BIT(1))
 
+/*
+ * Internally, we're using an enum to specify the granularity. We make the
+ * compiler emit specialized code for each granularity.
+ */
+enum rmap_level {
+	RMAP_LEVEL_PTE = 0,
+	RMAP_LEVEL_PMD,
+};
+
+static inline void __folio_rmap_sanity_checks(struct folio *folio,
+		struct page *page, int nr_pages, enum rmap_level level)
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
+	switch (level) {
+	case RMAP_LEVEL_PTE:
+		break;
+	case RMAP_LEVEL_PMD:
+		/*
+		 * We don't support folios larger than a single PMD yet. So
+		 * when RMAP_LEVEL_PMD is set, we assume that we are creating
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
@@ -201,8 +239,12 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
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
index 149f779910fd5..7f957e5a84311 100644
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
index 6a1829324053e..cc1fc2d570f0d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1378,31 +1378,18 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
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
+		enum rmap_level level)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	unsigned int nr_pmdmapped = 0, first;
-	int nr = 0;
+	int nr = 0, nr_pmdmapped = 0, first;
 
-	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
-	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
+	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
-	/* Is page being mapped by PTE? Is this its first map to be added? */
-	if (likely(!compound)) {
+	switch (level) {
+	case RMAP_LEVEL_PTE:
 		do {
 			first = atomic_inc_and_test(&page->_mapcount);
 			if (first && folio_test_large(folio)) {
@@ -1413,9 +1400,8 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 			if (first)
 				nr++;
 		} while (page++, --nr_pages > 0);
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
+		break;
+	case RMAP_LEVEL_PMD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
@@ -1430,6 +1416,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 				nr = 0;
 			}
 		}
+		break;
 	}
 
 	if (nr_pmdmapped)
@@ -1443,6 +1430,43 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
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
+	__folio_add_file_rmap(folio, page, nr_pages, vma, RMAP_LEVEL_PTE);
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
+	__folio_add_file_rmap(folio, page, HPAGE_PMD_NR, vma, RMAP_LEVEL_PMD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /**
  * page_add_file_rmap - add pte mapping to a file page
  * @page:	the page to add the mapping to
@@ -1455,16 +1479,13 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
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


