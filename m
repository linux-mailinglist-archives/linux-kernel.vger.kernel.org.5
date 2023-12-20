Return-Path: <linux-kernel+bounces-7539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22281A95E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39112843CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B70D4D5BB;
	Wed, 20 Dec 2023 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUZTZ8Lr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C34D5A8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fT8ITtdjY970fgU9T3ISsA7bFyZzQFNQcv3TmnG2Cz0=;
	b=UUZTZ8Lr7mJJzCDSuyFXG2KJXfGA7heXeF516nbEK5PnfDPh8Y/BhQLZgB+eHXaAhqG27h
	Pha5cKLMBqUnO0A4DLYRhU7lA2Qdeli/mqaG32f79GseikBQYBEhA3XpY3qLRWa2kth52w
	vw7eVTx06Uurzyq05Rqt4fqDR4mqWFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-OvGVr2QHOyKfAifuTxGNMQ-1; Wed, 20 Dec 2023 17:45:44 -0500
X-MC-Unique: OvGVr2QHOyKfAifuTxGNMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FD2F863B83;
	Wed, 20 Dec 2023 22:45:44 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14DC940C6EB9;
	Wed, 20 Dec 2023 22:45:41 +0000 (UTC)
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
Subject: [PATCH v2 14/40] mm/rmap: introduce folio_add_anon_rmap_[pte|ptes|pmd]()
Date: Wed, 20 Dec 2023 23:44:38 +0100
Message-ID: <20231220224504.646757-15-david@redhat.com>
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

Let's mimic what we did with folio_add_file_rmap_*() so we can similarly
replace page_add_anon_rmap() next.

Make the compiler always special-case on the granularity by using
__always_inline.

For the PageAnonExclusive sanity checks, when adding a PMD mapping,
we're now also checking each individual subpage covered by that PMD,
instead of only the head page.

Note that the new functions ignore the RMAP_COMPOUND flag, which we will
remove as soon as page_add_anon_rmap() is gone.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |   6 +++
 mm/rmap.c            | 120 +++++++++++++++++++++++++++++--------------
 2 files changed, 88 insertions(+), 38 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 6a4db6933e7df..b5da3d86200e4 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -233,6 +233,12 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
  * rmap interfaces called when adding or removing pte of page
  */
 void folio_move_anon_rmap(struct folio *, struct vm_area_struct *);
+void folio_add_anon_rmap_ptes(struct folio *, struct page *, int nr_pages,
+		struct vm_area_struct *, unsigned long address, rmap_t flags);
+#define folio_add_anon_rmap_pte(folio, page, vma, address, flags) \
+	folio_add_anon_rmap_ptes(folio, page, 1, vma, address, flags)
+void folio_add_anon_rmap_pmd(struct folio *, struct page *,
+		struct vm_area_struct *, unsigned long address, rmap_t flags);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
 void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
diff --git a/mm/rmap.c b/mm/rmap.c
index 895a8534a935d..7f380f5a34c90 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1299,40 +1299,20 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
 	struct folio *folio = page_folio(page);
-	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int nr = 0, nr_pmdmapped = 0;
-	bool compound = flags & RMAP_COMPOUND;
-	bool first;
-
-	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 
-	/* Is page being mapped by PTE? Is this its first map to be added? */
-	if (likely(!compound)) {
-		first = atomic_inc_and_test(&page->_mapcount);
-		nr = first;
-		if (first && folio_test_large(folio)) {
-			nr = atomic_inc_return_relaxed(mapped);
-			nr = (nr < COMPOUND_MAPPED);
-		}
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
+	if (likely(!(flags & RMAP_COMPOUND)))
+		folio_add_anon_rmap_pte(folio, page, vma, address, flags);
+	else
+		folio_add_anon_rmap_pmd(folio, page, vma, address, flags);
+}
 
-		first = atomic_inc_and_test(&folio->_entire_mapcount);
-		if (first) {
-			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
-			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
-				nr_pmdmapped = folio_nr_pages(folio);
-				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
-				/* Raced ahead of a remove and another add? */
-				if (unlikely(nr < 0))
-					nr = 0;
-			} else {
-				/* Raced ahead of a remove of COMPOUND_MAPPED */
-				nr = 0;
-			}
-		}
-	}
+static __always_inline void __folio_add_anon_rmap(struct folio *folio,
+		struct page *page, int nr_pages, struct vm_area_struct *vma,
+		unsigned long address, rmap_t flags, enum rmap_level level)
+{
+	int i, nr, nr_pmdmapped = 0;
 
+	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
 	if (nr)
@@ -1346,18 +1326,34 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		 * folio->index right when not given the address of the head
 		 * page.
 		 */
-		VM_WARN_ON_FOLIO(folio_test_large(folio) && !compound, folio);
+		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
+				 level != RMAP_LEVEL_PMD, folio);
 		__folio_set_anon(folio, vma, address,
 				 !!(flags & RMAP_EXCLUSIVE));
 	} else if (likely(!folio_test_ksm(folio))) {
 		__page_check_anon_rmap(folio, page, vma, address);
 	}
-	if (flags & RMAP_EXCLUSIVE)
-		SetPageAnonExclusive(page);
-	/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
-	VM_WARN_ON_FOLIO((atomic_read(&page->_mapcount) > 0 ||
-			  (folio_test_large(folio) && folio_entire_mapcount(folio) > 1)) &&
-			 PageAnonExclusive(page), folio);
+
+	if (flags & RMAP_EXCLUSIVE) {
+		switch (level) {
+		case RMAP_LEVEL_PTE:
+			for (i = 0; i < nr_pages; i++)
+				SetPageAnonExclusive(page + i);
+			break;
+		case RMAP_LEVEL_PMD:
+			SetPageAnonExclusive(page);
+			break;
+		}
+	}
+	for (i = 0; i < nr_pages; i++) {
+		struct page *cur_page = page + i;
+
+		/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
+		VM_WARN_ON_FOLIO((atomic_read(&cur_page->_mapcount) > 0 ||
+				  (folio_test_large(folio) &&
+				   folio_entire_mapcount(folio) > 1)) &&
+				 PageAnonExclusive(cur_page), folio);
+	}
 
 	/*
 	 * For large folio, only mlock it if it's fully mapped to VMA. It's
@@ -1369,6 +1365,54 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		mlock_vma_folio(folio, vma);
 }
 
+/**
+ * folio_add_anon_rmap_ptes - add PTE mappings to a page range of an anon folio
+ * @folio:	The folio to add the mappings to
+ * @page:	The first page to add
+ * @nr_pages:	The number of pages which will be mapped
+ * @vma:	The vm area in which the mappings are added
+ * @address:	The user virtual address of the first page to map
+ * @flags:	The rmap flags
+ *
+ * The page range of folio is defined by [first_page, first_page + nr_pages)
+ *
+ * The caller needs to hold the page table lock, and the page must be locked in
+ * the anon_vma case: to serialize mapping,index checking after setting,
+ * and to ensure that an anon folio is not being upgraded racily to a KSM folio
+ * (but KSM folios are never downgraded).
+ */
+void folio_add_anon_rmap_ptes(struct folio *folio, struct page *page,
+		int nr_pages, struct vm_area_struct *vma, unsigned long address,
+		rmap_t flags)
+{
+	__folio_add_anon_rmap(folio, page, nr_pages, vma, address, flags,
+			      RMAP_LEVEL_PTE);
+}
+
+/**
+ * folio_add_anon_rmap_pmd - add a PMD mapping to a page range of an anon folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @vma:	The vm area in which the mapping is added
+ * @address:	The user virtual address of the first page to map
+ * @flags:	The rmap flags
+ *
+ * The page range of folio is defined by [first_page, first_page + HPAGE_PMD_NR)
+ *
+ * The caller needs to hold the page table lock, and the page must be locked in
+ * the anon_vma case: to serialize mapping,index checking after setting.
+ */
+void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma, unsigned long address, rmap_t flags)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	__folio_add_anon_rmap(folio, page, HPAGE_PMD_NR, vma, address, flags,
+			      RMAP_LEVEL_PMD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /**
  * folio_add_new_anon_rmap - Add mapping to a new anonymous folio.
  * @folio:	The folio to add the mapping to.
-- 
2.43.0


