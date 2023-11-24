Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04697F7516
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjKXN36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbjKXN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E80710FA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nZeFmARPNGvb6d3sXI2ciVXy/9aT4qOMIkiPA0/sq4=;
        b=gVv6tq921bqmqMH1s1nn3UT0EyVUwrXyzHVr+xrw/Caz8F8mTec9df74iUGQI+Zxqpa20F
        6LFymO1lJgW+ksjgF/4Ids1iwVR9beM7GxxRrqY2lI69JJOhUxgJC9m1y4S9qg34zeH8jT
        D3F6vd4riKjF8EkHFDwFOoWvap+3m/0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-qEni6tCTMAipvOzVZRL0Sg-1; Fri,
 24 Nov 2023 08:27:44 -0500
X-MC-Unique: qEni6tCTMAipvOzVZRL0Sg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF09F2806052;
        Fri, 24 Nov 2023 13:27:43 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 870CD2166B2A;
        Fri, 24 Nov 2023 13:27:40 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH WIP v1 20/20] mm/rmap: perform all mapcount operations of large folios under the rmap seqcount
Date:   Fri, 24 Nov 2023 14:26:25 +0100
Message-ID: <20231124132626.235350-21-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's extend the atomic seqcount to also protect modifications of:
* The subpage mapcounts
* The entire mapcount
* folio->_nr_pages_mapped

This way, we can avoid another 1/2 atomic RMW operations on the fast
path (and significantly more when patching): When we are the exclusive
writer, we only need two atomic RMW operations to manage the atomic
seqcount.

Let's document how the existing atomic seqcount memory barriers keep the
old behavior unmodified: especially, how it makes sure that folio
refcount updates cannot be reordered with folio mapcount updates.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 95 ++++++++++++++++++++++++++------------------
 mm/rmap.c            | 84 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 137 insertions(+), 42 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 538c23d3c0c9..3cff4aa71393 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -301,6 +301,12 @@ static inline bool __folio_write_large_rmap_begin(struct folio *folio)
 	exclusive = raw_write_atomic_seqcount_begin(&folio->_rmap_atomic_seqcount,
 						    true);
 	if (likely(exclusive)) {
+		/*
+		 * Note: raw_write_atomic_seqcount_begin() implies a full
+		 * memory barrier like non-exclusive mapcount operations
+		 * will. Any refcount updates that happened before this call
+		 * are visible before any mapcount updates on other CPUs.
+		 */
 		prefetchw(&folio->_rmap_val0);
 		if (unlikely(folio_order(folio) > RMAP_SUBID_4_MAX_ORDER))
 			prefetchw(&folio->_rmap_val4);
@@ -311,6 +317,12 @@ static inline bool __folio_write_large_rmap_begin(struct folio *folio)
 static inline void __folio_write_large_rmap_end(struct folio *folio,
 		bool exclusive)
 {
+	/*
+	 * Note: raw_write_atomic_seqcount_end() implies a full memory
+	 * barrier like non-exclusive mapcount operations will. Any
+	 * refcount updates happening after this call are visible after any
+	 * mapcount updates on other CPUs.
+	 */
 	raw_write_atomic_seqcount_end(&folio->_rmap_atomic_seqcount,
 				      exclusive);
 }
@@ -367,52 +379,46 @@ static inline void folio_set_large_mapcount(struct folio *folio,
 static inline void folio_inc_large_mapcount(struct folio *folio,
 		struct vm_area_struct *vma)
 {
-	bool exclusive;
+	atomic_inc(&folio->_total_mapcount);
+	__folio_add_large_rmap_val(folio, 1, vma->vm_mm);
+}
 
-	exclusive = __folio_write_large_rmap_begin(folio);
-	if (likely(exclusive)) {
-		atomic_set(&folio->_total_mapcount,
-			   atomic_read(&folio->_total_mapcount) + 1);
-		__folio_add_large_rmap_val_exclusive(folio, 1, vma->vm_mm);
-	} else {
-		atomic_inc(&folio->_total_mapcount);
-		__folio_add_large_rmap_val(folio, 1, vma->vm_mm);
-	}
-	__folio_write_large_rmap_end(folio, exclusive);
+static inline void folio_inc_large_mapcount_exclusive(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	atomic_set(&folio->_total_mapcount,
+		   atomic_read(&folio->_total_mapcount) + 1);
+	__folio_add_large_rmap_val_exclusive(folio, 1, vma->vm_mm);
 }
 
 static inline void folio_add_large_mapcount(struct folio *folio,
 		int count, struct vm_area_struct *vma)
 {
-	bool exclusive;
+	atomic_add(count, &folio->_total_mapcount);
+	__folio_add_large_rmap_val(folio, count, vma->vm_mm);
+}
 
-	exclusive = __folio_write_large_rmap_begin(folio);
-	if (likely(exclusive)) {
-		atomic_set(&folio->_total_mapcount,
-			   atomic_read(&folio->_total_mapcount) + count);
-		__folio_add_large_rmap_val_exclusive(folio, count, vma->vm_mm);
-	} else {
-		atomic_add(count, &folio->_total_mapcount);
-		__folio_add_large_rmap_val(folio, count, vma->vm_mm);
-	}
-	__folio_write_large_rmap_end(folio, exclusive);
+static inline void folio_add_large_mapcount_exclusive(struct folio *folio,
+		int count, struct vm_area_struct *vma)
+{
+	atomic_set(&folio->_total_mapcount,
+		   atomic_read(&folio->_total_mapcount) + count);
+	__folio_add_large_rmap_val_exclusive(folio, count, vma->vm_mm);
 }
 
 static inline void folio_dec_large_mapcount(struct folio *folio,
 		struct vm_area_struct *vma)
 {
-	bool exclusive;
+	atomic_dec(&folio->_total_mapcount);
+	__folio_add_large_rmap_val(folio, -1, vma->vm_mm);
+}
 
-	exclusive = __folio_write_large_rmap_begin(folio);
-	if (likely(exclusive)) {
-		atomic_set(&folio->_total_mapcount,
-			   atomic_read(&folio->_total_mapcount) - 1);
-		__folio_add_large_rmap_val_exclusive(folio, -1, vma->vm_mm);
-	} else {
-		atomic_dec(&folio->_total_mapcount);
-		__folio_add_large_rmap_val(folio, -1, vma->vm_mm);
-	}
-	__folio_write_large_rmap_end(folio, exclusive);
+static inline void folio_dec_large_mapcount_exclusive(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	atomic_set(&folio->_total_mapcount,
+		   atomic_read(&folio->_total_mapcount) - 1);
+	__folio_add_large_rmap_val_exclusive(folio, -1, vma->vm_mm);
 }
 
 /* RMAP flags, currently only relevant for some anon rmap operations. */
@@ -462,6 +468,7 @@ static inline void __page_dup_rmap(struct page *page,
 		struct vm_area_struct *dst_vma, bool compound)
 {
 	struct folio *folio = page_folio(page);
+	bool exclusive;
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 	if (likely(!folio_test_large(folio))) {
@@ -475,11 +482,23 @@ static inline void __page_dup_rmap(struct page *page,
 		return;
 	}
 
-	if (compound)
-		atomic_inc(&folio->_entire_mapcount);
-	else
-		atomic_inc(&page->_mapcount);
-	folio_inc_large_mapcount(folio, dst_vma);
+	exclusive = __folio_write_large_rmap_begin(folio);
+	if (likely(exclusive)) {
+		if (compound)
+			atomic_set(&folio->_entire_mapcount,
+				   atomic_read(&folio->_entire_mapcount) + 1);
+		else
+			atomic_set(&page->_mapcount,
+				   atomic_read(&page->_mapcount) + 1);
+		folio_inc_large_mapcount_exclusive(folio, dst_vma);
+	} else {
+		if (compound)
+			atomic_inc(&folio->_entire_mapcount);
+		else
+			atomic_inc(&page->_mapcount);
+		folio_inc_large_mapcount(folio, dst_vma);
+	}
+	__folio_write_large_rmap_end(folio, exclusive);
 }
 
 static inline void page_dup_file_rmap(struct page *page,
diff --git a/mm/rmap.c b/mm/rmap.c
index 80ac53633332..755a62b046e2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1109,7 +1109,8 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 		struct vm_area_struct *vma, bool compound, int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int first, count, nr = 0;
+	int first, val, count, nr = 0;
+	bool exclusive;
 
 	VM_WARN_ON_FOLIO(compound && page != &folio->page, folio);
 	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
@@ -1119,8 +1120,23 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 	if (likely(!folio_test_large(folio)))
 		return atomic_inc_and_test(&page->_mapcount);
 
+	exclusive = __folio_write_large_rmap_begin(folio);
+
 	/* Is page being mapped by PTE? Is this its first map to be added? */
-	if (!compound) {
+	if (likely(exclusive) && !compound) {
+		count = nr_pages;
+		do {
+			val = atomic_read(&page->_mapcount) + 1;
+			atomic_set(&page->_mapcount, val);
+			if (!val) {
+				val = atomic_read(mapped) + 1;
+				atomic_set(mapped, val);
+				if (val < COMPOUND_MAPPED)
+					nr++;
+			}
+		} while (page++, --count > 0);
+		folio_add_large_mapcount_exclusive(folio, nr_pages, vma);
+	} else if (!compound) {
 		count = nr_pages;
 		do {
 			first = atomic_inc_and_test(&page->_mapcount);
@@ -1131,6 +1147,26 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 			}
 		} while (page++, --count > 0);
 		folio_add_large_mapcount(folio, nr_pages, vma);
+	} else if (likely(exclusive) && folio_test_pmd_mappable(folio)) {
+		/* That test is redundant: it's for safety or to optimize out */
+
+		val = atomic_read(&folio->_entire_mapcount) + 1;
+		atomic_set(&folio->_entire_mapcount, val);
+		if (!val) {
+			nr = atomic_read(mapped) + COMPOUND_MAPPED;
+			atomic_set(mapped, nr);
+			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
+				*nr_pmdmapped = folio_nr_pages(folio);
+				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				/* Raced ahead of a remove and another add? */
+				if (unlikely(nr < 0))
+					nr = 0;
+			} else {
+				/* Raced ahead of a remove of COMPOUND_MAPPED */
+				nr = 0;
+			}
+		}
+		folio_inc_large_mapcount_exclusive(folio, vma);
 	} else if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
@@ -1152,6 +1188,8 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 	} else {
 		VM_WARN_ON_ONCE_FOLIO(true, folio);
 	}
+
+	__folio_write_large_rmap_end(folio, exclusive);
 	return nr;
 }
 
@@ -1160,7 +1198,8 @@ static unsigned int __folio_remove_rmap_range(struct folio *folio,
 		struct vm_area_struct *vma, bool compound, int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int last, count, nr = 0;
+	int last, val, count, nr = 0;
+	bool exclusive;
 
 	VM_WARN_ON_FOLIO(compound && page != &folio->page, folio);
 	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
@@ -1170,8 +1209,23 @@ static unsigned int __folio_remove_rmap_range(struct folio *folio,
 	if (likely(!folio_test_large(folio)))
 		return atomic_add_negative(-1, &page->_mapcount);
 
+	exclusive = __folio_write_large_rmap_begin(folio);
+
 	/* Is page being unmapped by PTE? Is this its last map to be removed? */
-	if (!compound) {
+	if (likely(exclusive) && !compound) {
+		folio_add_large_mapcount_exclusive(folio, -nr_pages, vma);
+		count = nr_pages;
+		do {
+			val = atomic_read(&page->_mapcount) - 1;
+			atomic_set(&page->_mapcount, val);
+			if (val < 0) {
+				val = atomic_read(mapped) - 1;
+				atomic_set(mapped, val);
+				if (val < COMPOUND_MAPPED)
+					nr++;
+			}
+		} while (page++, --count > 0);
+	} else if (!compound) {
 		folio_add_large_mapcount(folio, -nr_pages, vma);
 		count = nr_pages;
 		do {
@@ -1182,6 +1236,26 @@ static unsigned int __folio_remove_rmap_range(struct folio *folio,
 					nr++;
 			}
 		} while (page++, --count > 0);
+	} else if (likely(exclusive) && folio_test_pmd_mappable(folio)) {
+		/* That test is redundant: it's for safety or to optimize out */
+
+		folio_dec_large_mapcount_exclusive(folio, vma);
+		val = atomic_read(&folio->_entire_mapcount) - 1;
+		atomic_set(&folio->_entire_mapcount, val);
+		if (val < 0) {
+			nr = atomic_read(mapped) - COMPOUND_MAPPED;
+			atomic_set(mapped, nr);
+			if (likely(nr < COMPOUND_MAPPED)) {
+				*nr_pmdmapped = folio_nr_pages(folio);
+				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				/* Raced ahead of another remove and an add? */
+				if (unlikely(nr < 0))
+					nr = 0;
+			} else {
+				/* An add of COMPOUND_MAPPED raced ahead */
+				nr = 0;
+			}
+		}
 	} else if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
@@ -1203,6 +1277,8 @@ static unsigned int __folio_remove_rmap_range(struct folio *folio,
 	} else {
 		VM_WARN_ON_ONCE_FOLIO(true, folio);
 	}
+
+	__folio_write_large_rmap_end(folio, exclusive);
 	return nr;
 }
 
-- 
2.41.0

