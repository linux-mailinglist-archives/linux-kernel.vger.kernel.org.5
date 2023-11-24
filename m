Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF557F74ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbjKXN1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjKXN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA31730
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ZXmCy/cptnrW109242Bp79Yc/hIzrll+sgQ1b8Vj4U=;
        b=G82MZBUh3iwaP5zwmz+tCYWCC+6wc2m3xOxqRSVZgmLMFmkLIb2n6qnTOCu27cu4Q/jI6e
        9SWtNS6ByBuCPor/cFfZNaNoduD9ebWm29y7raoRBlJshg1jzPgFzjh3nFiSr0a0mHXBTR
        7Neq1ivoNSIwK480TAFQJLrkITfTBd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-PPvWI2VbOfaXtOuRopE19A-1; Fri, 24 Nov 2023 08:26:50 -0500
X-MC-Unique: PPvWI2VbOfaXtOuRopE19A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D82C7811E7B;
        Fri, 24 Nov 2023 13:26:49 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A59242166B2A;
        Fri, 24 Nov 2023 13:26:46 +0000 (UTC)
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
Subject: [PATCH WIP v1 05/20] mm/rmap: abstract total mapcount operations for partially-mappable folios
Date:   Fri, 24 Nov 2023 14:26:10 +0100
Message-ID: <20231124132626.235350-6-david@redhat.com>
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

Let's prepare for doing additional accounting whenever modifying the total
mapcount of partially-mappable (!hugetlb) folios. Pass the VMA as well.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 41 ++++++++++++++++++++++++++++++++++++++++-
 mm/rmap.c            | 23 ++++++++++++-----------
 2 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 6cb497f6feab..9d5c2ed6ced5 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -168,6 +168,39 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *folio_get_anon_vma(struct folio *folio);
 
+static inline void folio_set_large_mapcount(struct folio *folio,
+		int count, struct vm_area_struct *vma)
+{
+	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	/* increment count (starts at -1) */
+	atomic_set(&folio->_total_mapcount, count - 1);
+}
+
+static inline void folio_inc_large_mapcount(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	atomic_inc(&folio->_total_mapcount);
+}
+
+static inline void folio_add_large_mapcount(struct folio *folio,
+		int count, struct vm_area_struct *vma)
+{
+	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	atomic_add(count, &folio->_total_mapcount);
+}
+
+static inline void folio_dec_large_mapcount(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	atomic_dec(&folio->_total_mapcount);
+}
+
 /* RMAP flags, currently only relevant for some anon rmap operations. */
 typedef int __bitwise rmap_t;
 
@@ -219,11 +252,17 @@ static inline void __page_dup_rmap(struct page *page,
 		return;
 	}
 
+	if (unlikely(folio_test_hugetlb(folio))) {
+		atomic_inc(&folio->_entire_mapcount);
+		atomic_inc(&folio->_total_mapcount);
+		return;
+	}
+
 	if (compound)
 		atomic_inc(&folio->_entire_mapcount);
 	else
 		atomic_inc(&page->_mapcount);
-	atomic_inc(&folio->_total_mapcount);
+	folio_inc_large_mapcount(folio, dst_vma);
 }
 
 static inline void page_dup_file_rmap(struct page *page,
diff --git a/mm/rmap.c b/mm/rmap.c
index 38765796dca8..689ad85cf87e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1105,8 +1105,8 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 }
 
 static unsigned int __folio_add_rmap_range(struct folio *folio,
-		struct page *page, unsigned int nr_pages, bool compound,
-		int *nr_pmdmapped)
+		struct page *page, unsigned int nr_pages,
+		struct vm_area_struct *vma, bool compound, int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	int first, count, nr = 0;
@@ -1130,7 +1130,7 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 					nr++;
 			}
 		} while (page++, --count > 0);
-		atomic_add(nr_pages, &folio->_total_mapcount);
+		folio_add_large_mapcount(folio, nr_pages, vma);
 	} else if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
@@ -1148,7 +1148,7 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 				nr = 0;
 			}
 		}
-		atomic_inc(&folio->_total_mapcount);
+		folio_inc_large_mapcount(folio, vma);
 	} else {
 		VM_WARN_ON_ONCE_FOLIO(true, folio);
 	}
@@ -1258,7 +1258,8 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	unsigned int nr, nr_pmdmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
 
-	nr = __folio_add_rmap_range(folio, page, 1, compound, &nr_pmdmapped);
+	nr = __folio_add_rmap_range(folio, page, 1, vma, compound,
+				    &nr_pmdmapped);
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
 	if (nr)
@@ -1329,8 +1330,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	}
 
 	if (folio_test_large(folio))
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_total_mapcount, 0);
+		folio_set_large_mapcount(folio, 1, vma);
 
 	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
 	__folio_set_anon(folio, vma, address, true);
@@ -1355,7 +1355,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 {
 	unsigned int nr, nr_pmdmapped = 0;
 
-	nr = __folio_add_rmap_range(folio, page, nr_pages, compound,
+	nr = __folio_add_rmap_range(folio, page, nr_pages, vma, compound,
 				    &nr_pmdmapped);
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
@@ -1411,16 +1411,17 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
-	if (folio_test_large(folio))
-		atomic_dec(&folio->_total_mapcount);
-
 	/* Hugetlb pages are not counted in NR_*MAPPED */
 	if (unlikely(folio_test_hugetlb(folio))) {
 		/* hugetlb pages are always mapped with pmds */
 		atomic_dec(&folio->_entire_mapcount);
+		atomic_dec(&folio->_total_mapcount);
 		return;
 	}
 
+	if (folio_test_large(folio))
+		folio_dec_large_mapcount(folio, vma);
+
 	/* Is page being unmapped by PTE? Is this its last map to be removed? */
 	if (likely(!compound)) {
 		last = atomic_add_negative(-1, &page->_mapcount);
-- 
2.41.0

