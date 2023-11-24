Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0477F74FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjKXN2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345684AbjKXN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4746C1BF5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtSW4MwxrPZp0IyU2r08B+zJ2gAs9ZHqKJrFZADgzdE=;
        b=WeCLO36IZ9SNhaMFgnZu8voNGRCkCCJPoksdZVs0/7brTpb5DEAxPDojyg+BjTAiO+0/nA
        SayEjB50qiNcOo6MATyLZ4UAULHm3GhKd6PNukhIhK5FVxVNwjrV/rOt1Ko6lLUsPGVCuG
        MuF0ZlgAJrryMx5SaInDNhLl6h8JuXs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-S2Vde6e2MxqrSRyf_jNx7w-1; Fri, 24 Nov 2023 08:27:15 -0500
X-MC-Unique: S2Vde6e2MxqrSRyf_jNx7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B241E185A784;
        Fri, 24 Nov 2023 13:27:14 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3636A2166B2A;
        Fri, 24 Nov 2023 13:27:11 +0000 (UTC)
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
Subject: [PATCH WIP v1 12/20] mm/rmap: introduce folio_add_anon_rmap_range()
Date:   Fri, 24 Nov 2023 14:26:17 +0100
Message-ID: <20231124132626.235350-13-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are probably ways to have an even cleaner interface (e.g.,
pass the mapping granularity instead of "compound"). For now, let's
handle it like folio_add_file_rmap_range().

Use separate loops for handling the "SetPageAnonExclusive()" case and
performing debug checks. The latter should get optimized out automatically
without CONFIG_DEBUG_VM.

We'll use this function to batch rmap operations when PTE-remapping a
PMD-mapped THP next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  3 ++
 mm/rmap.c            | 69 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 39aeab457f4a..76e6fb1dad5c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -393,6 +393,9 @@ typedef int __bitwise rmap_t;
  * rmap interfaces called when adding or removing pte of page
  */
 void folio_move_anon_rmap(struct folio *, struct vm_area_struct *);
+void folio_add_anon_rmap_range(struct folio *, struct page *,
+		unsigned int nr_pages, struct vm_area_struct *,
+		unsigned long address, rmap_t flags);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
diff --git a/mm/rmap.c b/mm/rmap.c
index 689ad85cf87e..da7fa46a18fc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1240,25 +1240,29 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
 }
 
 /**
- * page_add_anon_rmap - add pte mapping to an anonymous page
- * @page:	the page to add the mapping to
- * @vma:	the vm area in which the mapping is added
- * @address:	the user virtual address mapped
- * @flags:	the rmap flags
+ * folio_add_anon_rmap_range - add mappings to a page range of an anon folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @nr_pages:	The number of pages which will be mapped
+ * @vma:	The vm area in which the mapping is added
+ * @address:	The user virtual address of the first page to map
+ * @flags:	The rmap flags
+ *
+ * The page range of folio is defined by [first_page, first_page + nr_pages)
  *
  * The caller needs to hold the pte lock, and the page must be locked in
  * the anon_vma case: to serialize mapping,index checking after setting,
- * and to ensure that PageAnon is not being upgraded racily to PageKsm
- * (but PageKsm is never downgraded to PageAnon).
+ * and to ensure that an anon folio is not being upgraded racily to a KSM folio
+ * (but KSM folios are never downgraded).
  */
-void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
+void folio_add_anon_rmap_range(struct folio *folio, struct page *page,
+		unsigned int nr_pages, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
-	struct folio *folio = page_folio(page);
-	unsigned int nr, nr_pmdmapped = 0;
+	unsigned int i, nr, nr_pmdmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
 
-	nr = __folio_add_rmap_range(folio, page, 1, vma, compound,
+	nr = __folio_add_rmap_range(folio, page, nr_pages, vma, compound,
 				    &nr_pmdmapped);
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
@@ -1279,12 +1283,20 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
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
+		for (i = 0; i < nr_pages; i++)
+			SetPageAnonExclusive(page + i);
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
@@ -1296,6 +1308,29 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		mlock_vma_folio(folio, vma);
 }
 
+/**
+ * page_add_anon_rmap - add mappings to an anonymous page
+ * @page:	The page to add the mapping to
+ * @vma:	The vm area in which the mapping is added
+ * @address:	The user virtual address of the page to map
+ * @flags:	The rmap flags
+ *
+ * See folio_add_anon_rmap_range().
+ */
+void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
+		unsigned long address, rmap_t flags)
+{
+	struct folio *folio = page_folio(page);
+	unsigned int nr_pages;
+
+	if (likely(!(flags & RMAP_COMPOUND)))
+		nr_pages = 1;
+	else
+		nr_pages = folio_nr_pages(folio);
+
+	folio_add_anon_rmap_range(folio, page, nr_pages, vma, address, flags);
+}
+
 /**
  * folio_add_new_anon_rmap - Add mapping to a new anonymous folio.
  * @folio:	The folio to add the mapping to.
-- 
2.41.0

