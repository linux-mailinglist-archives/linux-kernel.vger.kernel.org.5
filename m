Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E37C80D04E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbjLKP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344582AbjLKP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:58:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE294136
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi7b3teT5yay/0ynlIbF8dSmjMX9HoAHjoRGBB4rTLU=;
        b=eczqDouvewc546nRfJRwY1yWGB/ezqT20jSSVGG6sYcQ2tQxnsANawyt3HfZotCFip2Eu2
        QLRbLcbG8ghx0xUQU0QunXGPRhIEGOMZcgIEE1a7NdpPrZI8SMqmaGkqEqaKggUGlwSnxB
        c4ZsTenjfCQC71xdLPpe0n9PWo2E+pI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-vRbs79ACOCeF2HWItzmhcA-1; Mon, 11 Dec 2023 10:58:23 -0500
X-MC-Unique: vRbs79ACOCeF2HWItzmhcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C070D86301D;
        Mon, 11 Dec 2023 15:58:22 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B14EA1121306;
        Mon, 11 Dec 2023 15:58:20 +0000 (UTC)
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
Subject: [PATCH v1 34/39] mm/rmap: introduce folio_try_dup_anon_rmap_[pte|ptes|pmd]()
Date:   Mon, 11 Dec 2023 16:56:47 +0100
Message-ID: <20231211155652.131054-35-david@redhat.com>
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
index ae547b62f325..30edf3f7d1f3 100644
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
index df60e44fecad..c6d8a02ecd56 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -365,68 +365,130 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
 #endif
 }
 
-static inline void __page_dup_rmap(struct page *page, bool compound)
+static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
+		struct page *page, int nr_pages, struct vm_area_struct *src_vma,
+		enum rmap_mode mode)
 {
-	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
+	bool maybe_pinned;
+	int i;
 
-	if (compound) {
-		struct folio *folio = (struct folio *)page;
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
 
-		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
+	/*
+	 * If this folio may have been pinned by the parent process,
+	 * don't allow to duplicate the mappings but instead require to e.g.,
+	 * copy the subpage immediately for the child so that we'll always
+	 * guarantee the pinned folio won't be randomly replaced in the
+	 * future on write faults.
+	 */
+	maybe_pinned = likely(!folio_is_device_private(folio)) &&
+		       unlikely(folio_needs_cow_for_dma(src_vma, folio));
+
+	/*
+	 * No need to check+clear for already shared PTEs/PMDs of the
+	 * folio. But if any page is PageAnonExclusive, we must fallback to
+	 * copying if the folio maybe pinned.
+	 */
+	switch (mode) {
+	case RMAP_MODE_PTE:
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
+	case RMAP_MODE_PMD:
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
+ *
+ * The page range of the folio is defined by [page, page + nr_pages)
  *
- * The caller needs to hold the PT lock and the vma->vma_mm->write_protect_seq.
+ * The caller needs to hold the page table lock and the
+ * vma->vma_mm->write_protect_seq.
  *
- * Duplicating the mapping can only fail if the page may be pinned; device
- * private pages cannot get pinned and consequently this function cannot fail.
+ * Duplicating the mappings can only fail if the folio may be pinned; device
+ * private folios cannot get pinned and consequently this function cannot fail
+ * for them.
  *
- * If duplicating the mapping succeeds, the page has to be mapped R/O into
- * the parent and the child. It must *not* get mapped writable after this call.
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
+					 RMAP_MODE_PTE);
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
+ *
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
+					 RMAP_MODE_PMD);
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
+	struct folio *folio = page_folio(page);
 
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
-
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

