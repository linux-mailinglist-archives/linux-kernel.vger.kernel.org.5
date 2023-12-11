Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C30F80D038
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbjLKP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344506AbjLKP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AB210C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FvIn4PK1R1vqfE/cFFREYzckJVopW/NXl4TYpNX8kUk=;
        b=MkYo/Z9E6GScHnS2rT58BD8uNQTw4AhokrXrRuUriv5AQ1KS3HAgRCzxzsX3MtTjmEhWuF
        hQtGXZqBgPre+a5hXPDdZ38Iu+p8SEeO2RoiLf9/o387br3tSGbWIk44WIWz2A/OD3C1Ye
        giK6FqmUb1PL0S52PlCDvRqztgFzTTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-bp0xtxh7M-6waMAcw-G2oA-1; Mon, 11 Dec 2023 10:57:32 -0500
X-MC-Unique: bp0xtxh7M-6waMAcw-G2oA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA129870820;
        Mon, 11 Dec 2023 15:57:31 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 583EB1121306;
        Mon, 11 Dec 2023 15:57:29 +0000 (UTC)
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
Subject: [PATCH v1 14/39] mm/rmap: introduce folio_add_anon_rmap_[pte|ptes|pmd]()
Date:   Mon, 11 Dec 2023 16:56:27 +0100
Message-ID: <20231211155652.131054-15-david@redhat.com>
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

Let's mimic what we did with folio_add_file_rmap_*() so we can similarly
replace page_add_anon_rmap() next.

Make the compiler always special-case on the granularity by using
__always_inline.

Note that the new functions ignore the RMAP_COMPOUND flag, which we will
remove as soon as page_add_anon_rmap() is gone.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |   6 +++
 mm/rmap.c            | 118 ++++++++++++++++++++++++++++++-------------
 2 files changed, 88 insertions(+), 36 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 7198905dc8be..3b5357cb1c09 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -234,6 +234,12 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
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
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
diff --git a/mm/rmap.c b/mm/rmap.c
index c5761986a411..7787499fa2ad 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1300,38 +1300,20 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
 	struct folio *folio = page_folio(page);
-	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int nr = 0, nr_pmdmapped = 0;
-	bool compound = flags & RMAP_COMPOUND;
-	bool first;
 
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
+		unsigned long address, rmap_t flags, enum rmap_mode mode)
+{
+	unsigned int i, nr, nr_pmdmapped = 0;
 
+	nr = __folio_add_rmap(folio, page, nr_pages, mode, &nr_pmdmapped);
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
 	if (nr)
@@ -1345,18 +1327,34 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		 * folio->index right when not given the address of the head
 		 * page.
 		 */
-		VM_WARN_ON_FOLIO(folio_test_large(folio) && !compound, folio);
+		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
+				 mode != RMAP_MODE_PMD, folio);
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
+		switch (mode) {
+		case RMAP_MODE_PTE:
+			for (i = 0; i < nr_pages; i++)
+				SetPageAnonExclusive(page + i);
+			break;
+		case RMAP_MODE_PMD:
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
@@ -1368,6 +1366,54 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
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
+			      RMAP_MODE_PTE);
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
+			      RMAP_MODE_PMD);
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

