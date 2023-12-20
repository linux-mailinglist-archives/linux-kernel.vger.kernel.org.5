Return-Path: <linux-kernel+bounces-7601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D481AAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F1D1C23131
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18DF79480;
	Wed, 20 Dec 2023 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqDgWJvh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462456467
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNA8pWEc7GnGKj0IRh6+wWeJkGUBzLslpaDMoEDhhnE=;
	b=DqDgWJvh3XCP8+KqS13BIitd0ivC81G7q+vckTABdSausW73Mto9oQaKYSEsXU/3z048BV
	xXEhYxdhCImJgVldBEr4Smfq2yt4JU3+pFTzl11D/j4wZHlsw9paUjFTZDn/Z9Ppa94n2d
	ies8NecZtcAVIAVTyR6bc10uowZxRzA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-FgP96C90Ok2CEIy_NFv94Q-1; Wed,
 20 Dec 2023 17:46:37 -0500
X-MC-Unique: FgP96C90Ok2CEIy_NFv94Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A735D38425B2;
	Wed, 20 Dec 2023 22:46:36 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F9F740C6EB9;
	Wed, 20 Dec 2023 22:46:34 +0000 (UTC)
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
Subject: [PATCH v2 34/40] mm/rmap: introduce folio_try_dup_anon_rmap_[pte|ptes|pmd]()
Date: Wed, 20 Dec 2023 23:44:58 +0100
Message-ID: <20231220224504.646757-35-david@redhat.com>
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

The last user of page_needs_cow_for_dma() and __page_dup_rmap() are gone,
remove them.

Add folio_try_dup_anon_rmap_ptes() right away, we want to perform rmap
baching during fork() soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h   |   6 --
 include/linux/rmap.h | 150 ++++++++++++++++++++++++++++++-------------
 2 files changed, 106 insertions(+), 50 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ae547b62f3252..30edf3f7d1f38 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1975,12 +1975,6 @@ static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
 	return folio_maybe_dma_pinned(folio);
 }
 
-static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
-					  struct page *page)
-{
-	return folio_needs_cow_for_dma(vma, page_folio(page));
-}
-
 /**
  * is_zero_page - Query if a page is a zero page
  * @page: The page to query
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 7607f862e795d..850aa74b6724c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -362,68 +362,130 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
 #endif
 }
 
-static inline void __page_dup_rmap(struct page *page, bool compound)
+static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
+		struct page *page, int nr_pages, struct vm_area_struct *src_vma,
+		enum rmap_level level)
 {
-	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
+	bool maybe_pinned;
+	int i;
+
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
-	if (compound) {
-		struct folio *folio = (struct folio *)page;
+	/*
+	 * If this folio may have been pinned by the parent process,
+	 * don't allow to duplicate the mappings but instead require to e.g.,
+	 * copy the subpage immediately for the child so that we'll always
+	 * guarantee the pinned folio won't be randomly replaced in the
+	 * future on write faults.
+	 */
+	maybe_pinned = likely(!folio_is_device_private(folio)) &&
+		       unlikely(folio_needs_cow_for_dma(src_vma, folio));
 
-		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
+	/*
+	 * No need to check+clear for already shared PTEs/PMDs of the
+	 * folio. But if any page is PageAnonExclusive, we must fallback to
+	 * copying if the folio maybe pinned.
+	 */
+	switch (level) {
+	case RMAP_LEVEL_PTE:
+		if (unlikely(maybe_pinned)) {
+			for (i = 0; i < nr_pages; i++)
+				if (PageAnonExclusive(page + i))
+					return -EBUSY;
+		}
+		do {
+			if (PageAnonExclusive(page))
+				ClearPageAnonExclusive(page);
+			atomic_inc(&page->_mapcount);
+		} while (page++, --nr_pages > 0);
+		break;
+	case RMAP_LEVEL_PMD:
+		if (PageAnonExclusive(page)) {
+			if (unlikely(maybe_pinned))
+				return -EBUSY;
+			ClearPageAnonExclusive(page);
+		}
 		atomic_inc(&folio->_entire_mapcount);
-	} else {
-		atomic_inc(&page->_mapcount);
+		break;
 	}
+	return 0;
 }
 
 /**
- * page_try_dup_anon_rmap - try duplicating a mapping of an already mapped
- *			    anonymous page
- * @page: the page to duplicate the mapping for
- * @compound: the page is mapped as compound or as a small page
- * @vma: the source vma
+ * folio_try_dup_anon_rmap_ptes - try duplicating PTE mappings of a page range
+ *				  of a folio
+ * @folio:	The folio to duplicate the mappings of
+ * @page:	The first page to duplicate the mappings of
+ * @nr_pages:	The number of pages of which the mapping will be duplicated
+ * @src_vma:	The vm area from which the mappings are duplicated
  *
- * The caller needs to hold the PT lock and the vma->vma_mm->write_protect_seq.
+ * The page range of the folio is defined by [page, page + nr_pages)
  *
- * Duplicating the mapping can only fail if the page may be pinned; device
- * private pages cannot get pinned and consequently this function cannot fail.
+ * The caller needs to hold the page table lock and the
+ * vma->vma_mm->write_protect_seq.
+ *
+ * Duplicating the mappings can only fail if the folio may be pinned; device
+ * private folios cannot get pinned and consequently this function cannot fail
+ * for them.
+ *
+ * If duplicating the mappings succeeded, the duplicated PTEs have to be R/O in
+ * the parent and the child. They must *not* be writable after this call
+ * succeeded.
+ *
+ * Returns 0 if duplicating the mappings succeeded. Returns -EBUSY otherwise.
+ */
+static inline int folio_try_dup_anon_rmap_ptes(struct folio *folio,
+		struct page *page, int nr_pages, struct vm_area_struct *src_vma)
+{
+	return __folio_try_dup_anon_rmap(folio, page, nr_pages, src_vma,
+					 RMAP_LEVEL_PTE);
+}
+#define folio_try_dup_anon_rmap_pte(folio, page, vma) \
+	folio_try_dup_anon_rmap_ptes(folio, page, 1, vma)
+
+/**
+ * folio_try_dup_anon_rmap_pmd - try duplicating a PMD mapping of a page range
+ *				 of a folio
+ * @folio:	The folio to duplicate the mapping of
+ * @page:	The first page to duplicate the mapping of
+ * @src_vma:	The vm area from which the mapping is duplicated
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
  *
- * If duplicating the mapping succeeds, the page has to be mapped R/O into
- * the parent and the child. It must *not* get mapped writable after this call.
+ * The caller needs to hold the page table lock and the
+ * vma->vma_mm->write_protect_seq.
+ *
+ * Duplicating the mapping can only fail if the folio may be pinned; device
+ * private folios cannot get pinned and consequently this function cannot fail
+ * for them.
+ *
+ * If duplicating the mapping succeeds, the duplicated PMD has to be R/O in
+ * the parent and the child. They must *not* be writable after this call
+ * succeeded.
  *
  * Returns 0 if duplicating the mapping succeeded. Returns -EBUSY otherwise.
  */
+static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
+		struct page *page, struct vm_area_struct *src_vma)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	return __folio_try_dup_anon_rmap(folio, page, HPAGE_PMD_NR, src_vma,
+					 RMAP_LEVEL_PMD);
+#else
+	WARN_ON_ONCE(true);
+	return -EBUSY;
+#endif
+}
+
 static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
 					 struct vm_area_struct *vma)
 {
-	VM_BUG_ON_PAGE(!PageAnon(page), page);
-
-	/*
-	 * No need to check+clear for already shared pages, including KSM
-	 * pages.
-	 */
-	if (!PageAnonExclusive(page))
-		goto dup;
-
-	/*
-	 * If this page may have been pinned by the parent process,
-	 * don't allow to duplicate the mapping but instead require to e.g.,
-	 * copy the page immediately for the child so that we'll always
-	 * guarantee the pinned page won't be randomly replaced in the
-	 * future on write faults.
-	 */
-	if (likely(!is_device_private_page(page)) &&
-	    unlikely(page_needs_cow_for_dma(vma, page)))
-		return -EBUSY;
+	struct folio *folio = page_folio(page);
 
-	ClearPageAnonExclusive(page);
-	/*
-	 * It's okay to share the anon page between both processes, mapping
-	 * the page R/O into both processes.
-	 */
-dup:
-	__page_dup_rmap(page, compound);
-	return 0;
+	if (likely(!compound))
+		return folio_try_dup_anon_rmap_pte(folio, page, vma);
+	return folio_try_dup_anon_rmap_pmd(folio, page, vma);
 }
 
 /**
-- 
2.43.0


