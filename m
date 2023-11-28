Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80827FC153
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346432AbjK1Ow3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346389AbjK1OwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:52:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685C510E4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701183140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmPjXh3Vh8+yuItVsdShx0BHlebvdn/GvnE6+gvw2TQ=;
        b=KLu+zqHf5Q+HGbZEwSFGpWi/mHTELEO2zQxjZOJVyiO9zIfmrX3UyG90H8NUAFQeL90Rrr
        TY4tn7wtrN+yjT2S4be4U3P2M/IjtHjhLuBgEGjGorLYATklRH3BqF+iEtL945a2YFK3kl
        EvsAlhMm0mb/+/hsHB4KT/iIKLQwJ9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-3AskqEHWOzuit0KMJT14zw-1; Tue, 28 Nov 2023 09:52:12 -0500
X-MC-Unique: 3AskqEHWOzuit0KMJT14zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 665EB101A52D;
        Tue, 28 Nov 2023 14:52:09 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B2E35028;
        Tue, 28 Nov 2023 14:52:08 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 2/5] mm/rmap: introduce and use hugetlb_remove_rmap()
Date:   Tue, 28 Nov 2023 15:52:02 +0100
Message-ID: <20231128145205.215026-3-david@redhat.com>
In-Reply-To: <20231128145205.215026-1-david@redhat.com>
References: <20231128145205.215026-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

hugetlb rmap handling differs quite a lot from "ordinary" rmap code. We
don't want this hugetlb special-casing in the rmap functions, as
we're special casing the callers already. Let's simply use a separate
function for hugetlb.

Let's introduce and use hugetlb_remove_rmap() and remove the hugetlb
code from page_remove_rmap(). This effectively removes one check on the
small-folio path as well.

While this is a cleanup, this will also make it easier to change rmap
handling for partially-mappable folios.

Note: all possible candidates that need care are page_remove_rmap() that
      pass compound=true.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  5 +++++
 mm/hugetlb.c         |  4 ++--
 mm/rmap.c            | 17 ++++++++---------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 4c5bfeb05463..e8d1dc1d5361 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -208,6 +208,11 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
+static inline void hugetlb_remove_rmap(struct folio *folio)
+{
+	atomic_dec(&folio->_entire_mapcount);
+}
+
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
 	if (compound) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4cfa0679661e..d17bb53b19ff 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5669,7 +5669,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 					make_pte_marker(PTE_MARKER_UFFD_WP),
 					sz);
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
-		page_remove_rmap(page, vma, true);
+		hugetlb_remove_rmap(page_folio(page));
 
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
@@ -5980,7 +5980,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
-		page_remove_rmap(&old_folio->page, vma, true);
+		hugetlb_remove_rmap(old_folio);
 		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
 		if (huge_pte_uffd_wp(pte))
 			newpte = huge_pte_mkuffd_wp(newpte);
diff --git a/mm/rmap.c b/mm/rmap.c
index 112467c30b2c..5037581b79ec 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1440,13 +1440,6 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
-	/* Hugetlb pages are not counted in NR_*MAPPED */
-	if (unlikely(folio_test_hugetlb(folio))) {
-		/* hugetlb pages are always mapped with pmds */
-		atomic_dec(&folio->_entire_mapcount);
-		return;
-	}
-
 	/* Is page being unmapped by PTE? Is this its last map to be removed? */
 	if (likely(!compound)) {
 		last = atomic_add_negative(-1, &page->_mapcount);
@@ -1804,7 +1797,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			dec_mm_counter(mm, mm_counter_file(&folio->page));
 		}
 discard:
-		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+		if (unlikely(folio_test_hugetlb(folio)))
+			hugetlb_remove_rmap(folio);
+		else
+			page_remove_rmap(subpage, vma, false);
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
@@ -2157,7 +2153,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 		}
 
-		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+		if (unlikely(folio_test_hugetlb(folio)))
+			hugetlb_remove_rmap(folio);
+		else
+			page_remove_rmap(subpage, vma, false);
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
-- 
2.41.0

