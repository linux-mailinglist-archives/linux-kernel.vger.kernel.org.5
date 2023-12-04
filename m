Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09004803671
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbjLDOXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345398AbjLDOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EBE1BD5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMp/rsTScJnGvEHSBNzvW50JXqbYQ0nspFlZU7tqJ/c=;
        b=PaCFXDen46GeXpgUnGOLkf1/jSHuq7Tx0C02rdNeVRRBm79WRaQ9dI5KiJVCRIusdPYi7I
        bOnxKcEGu5PTMptePOuGSVb9gbQmx0YdcShGQh3+Mnj21KKT6oDj1M5ag/CZ9fcpW3HE8g
        kVknUCuH5xnXnBLC3/Dx33nnuLKzwlA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-KFAuLerwMeGWU5ALc3K4CQ-1; Mon, 04 Dec 2023 09:22:32 -0500
X-MC-Unique: KFAuLerwMeGWU5ALc3K4CQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F04185A58C;
        Mon,  4 Dec 2023 14:22:32 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A5802026D4C;
        Mon,  4 Dec 2023 14:22:30 +0000 (UTC)
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
Subject: [PATCH RFC 23/39] mm/rmap: introduce folio_remove_rmap_[pte|ptes|pmd]()
Date:   Mon,  4 Dec 2023 15:21:30 +0100
Message-ID: <20231204142146.91437-24-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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
 mm/rmap.c            | 76 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 017b216915f19..dd4ffb1d8ae04 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -241,6 +241,12 @@ void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
+void folio_remove_rmap_ptes(struct folio *, struct page *, unsigned int nr,
+		struct vm_area_struct *);
+#define folio_remove_rmap_pte(folio, page, vma) \
+	folio_remove_rmap_ptes(folio, page, 1, vma)
+void folio_remove_rmap_pmd(struct folio *, struct page *,
+		struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
diff --git a/mm/rmap.c b/mm/rmap.c
index 3587225055c5e..50b6909157ac1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1463,25 +1463,36 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
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
+		struct page *page, unsigned int nr_pages,
+		struct vm_area_struct *vma, enum rmap_mode mode)
+{
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int nr = 0, nr_pmdmapped = 0;
-	bool last;
+	int last, nr = 0, nr_pmdmapped = 0;
 	enum node_stat_item idx;
 
-	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
-	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
+	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
 
 	/* Is page being unmapped by PTE? Is this its last map to be removed? */
-	if (likely(!compound)) {
-		last = atomic_add_negative(-1, &page->_mapcount);
-		nr = last;
-		if (last && folio_test_large(folio)) {
-			nr = atomic_dec_return_relaxed(mapped);
-			nr = (nr < COMPOUND_MAPPED);
-		}
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
+	if (likely(mode == RMAP_MODE_PTE)) {
+		do {
+			last = atomic_add_negative(-1, &page->_mapcount);
+			if (last && folio_test_large(folio)) {
+				last = atomic_dec_return_relaxed(mapped);
+				last = (last < COMPOUND_MAPPED);
+			}
 
+			if (last)
+				nr++;
+		} while (page++, --nr_pages > 0);
+	} else if (mode == RMAP_MODE_PMD) {
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
@@ -1517,7 +1528,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		 * is still mapped.
 		 */
 		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
-			if (!compound || nr < nr_pmdmapped)
+			if (mode == RMAP_MODE_PTE || nr < nr_pmdmapped)
 				deferred_split_folio(folio);
 	}
 
@@ -1532,6 +1543,43 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
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
+		unsigned int nr_pages, struct vm_area_struct *vma)
+{
+	__folio_remove_rmap(folio, page, nr_pages, vma, RMAP_MODE_PTE);
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
+	__folio_remove_rmap(folio, page, HPAGE_PMD_NR, vma, RMAP_MODE_PMD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
-- 
2.41.0

