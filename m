Return-Path: <linux-kernel+bounces-7550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D481A987
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527B21F214E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EDF4F611;
	Wed, 20 Dec 2023 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buqh9i23"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853024F5FA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/d9mpve/qdOWVGsQDSuYBEYTclHzlkzYvVo312FD3s0=;
	b=buqh9i23Y9gx8Dd2VOUxxJ+MuyNTLfwyqy7ZOiNps2a5c2vXAt1UPhA2U2MAQ9KxrQbgVC
	4WGvhjWxrPIhzvsc7rGc71o1JA48MEzRsaWklh0cAkf1A6eg+vOZpOAFjjXTOibZPB4T3F
	fbGVTtTDfxajJ3Cfckngdou5ROj0p6s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-h8r1ias0P2CwC8ml7LleWA-1; Wed,
 20 Dec 2023 17:46:08 -0500
X-MC-Unique: h8r1ias0P2CwC8ml7LleWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 923D42803609;
	Wed, 20 Dec 2023 22:46:07 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44B9640C6EB9;
	Wed, 20 Dec 2023 22:46:05 +0000 (UTC)
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
Subject: [PATCH v2 23/40] mm/rmap: introduce folio_remove_rmap_[pte|ptes|pmd]()
Date: Wed, 20 Dec 2023 23:44:47 +0100
Message-ID: <20231220224504.646757-24-david@redhat.com>
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

Let's mimic what we did with folio_add_file_rmap_*() and
folio_add_anon_rmap_*() so we can similarly replace page_remove_rmap()
next.

Make the compiler always special-case on the granularity by using
__always_inline.

We're adding folio_remove_rmap_ptes() handling right away, as we want to
use that soon for batching rmap operations when unmapping PTE-mapped
large folios.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  6 ++++
 mm/rmap.c            | 82 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index bf6cb79aa7a0a..57e045093f047 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -243,6 +243,12 @@ void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
+void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
+		struct vm_area_struct *);
+#define folio_remove_rmap_pte(folio, page, vma) \
+	folio_remove_rmap_ptes(folio, page, 1, vma)
+void folio_remove_rmap_pmd(struct folio *, struct page *,
+		struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
diff --git a/mm/rmap.c b/mm/rmap.c
index 2b386b9f6791c..1273180753953 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1510,25 +1510,37 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		bool compound)
 {
 	struct folio *folio = page_folio(page);
+
+	if (likely(!compound))
+		folio_remove_rmap_pte(folio, page, vma);
+	else
+		folio_remove_rmap_pmd(folio, page, vma);
+}
+
+static __always_inline void __folio_remove_rmap(struct folio *folio,
+		struct page *page, int nr_pages, struct vm_area_struct *vma,
+		enum rmap_level level)
+{
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int nr = 0, nr_pmdmapped = 0;
-	bool last;
+	int last, nr = 0, nr_pmdmapped = 0;
 	enum node_stat_item idx;
 
-	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
-	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
-
-	/* Is page being unmapped by PTE? Is this its last map to be removed? */
-	if (likely(!compound)) {
-		last = atomic_add_negative(-1, &page->_mapcount);
-		nr = last;
-		if (last && folio_test_large(folio)) {
-			nr = atomic_dec_return_relaxed(mapped);
-			nr = (nr < COMPOUND_MAPPED);
-		}
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
+	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
+
+	switch (level) {
+	case RMAP_LEVEL_PTE:
+		do {
+			last = atomic_add_negative(-1, &page->_mapcount);
+			if (last && folio_test_large(folio)) {
+				last = atomic_dec_return_relaxed(mapped);
+				last = (last < COMPOUND_MAPPED);
+			}
 
+			if (last)
+				nr++;
+		} while (page++, --nr_pages > 0);
+		break;
+	case RMAP_LEVEL_PMD:
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
@@ -1543,6 +1555,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 				nr = 0;
 			}
 		}
+		break;
 	}
 
 	if (nr_pmdmapped) {
@@ -1564,7 +1577,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		 * is still mapped.
 		 */
 		if (folio_test_large(folio) && folio_test_anon(folio))
-			if (!compound || nr < nr_pmdmapped)
+			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
 				deferred_split_folio(folio);
 	}
 
@@ -1579,6 +1592,43 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	munlock_vma_folio(folio, vma);
 }
 
+/**
+ * folio_remove_rmap_ptes - remove PTE mappings from a page range of a folio
+ * @folio:	The folio to remove the mappings from
+ * @page:	The first page to remove
+ * @nr_pages:	The number of pages that will be removed from the mapping
+ * @vma:	The vm area from which the mappings are removed
+ *
+ * The page range of the folio is defined by [page, page + nr_pages)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_remove_rmap_ptes(struct folio *folio, struct page *page,
+		int nr_pages, struct vm_area_struct *vma)
+{
+	__folio_remove_rmap(folio, page, nr_pages, vma, RMAP_LEVEL_PTE);
+}
+
+/**
+ * folio_remove_rmap_pmd - remove a PMD mapping from a page range of a folio
+ * @folio:	The folio to remove the mapping from
+ * @page:	The first page to remove
+ * @vma:	The vm area from which the mapping is removed
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	__folio_remove_rmap(folio, page, HPAGE_PMD_NR, vma, RMAP_LEVEL_PMD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
-- 
2.43.0


