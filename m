Return-Path: <linux-kernel+bounces-7527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DB481A94A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72016283FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF04B5A2;
	Wed, 20 Dec 2023 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VurQXmUA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF5D4B133
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zb5u0xx47K41JJXfyNoHDQEukBbwbPO9Q+a2q/uOjFE=;
	b=VurQXmUAASwMygg+NZJy+r8hpV029Fsj/be65Qc3/CfO0OVg/Tk0tZgDj3TMWpx/wN/fi6
	fbZQmHd8fODnVrQXf9N8E9tCAMJufJsYGMpbVoJV+kpIZfc339fq9pdyipuByv0fisgGtd
	NNoTBL/cmDBm3isdq4UFes8TCqGvDzs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-JUWNMJ1_NEm_REskD0WbEQ-1; Wed, 20 Dec 2023 17:45:13 -0500
X-MC-Unique: JUWNMJ1_NEm_REskD0WbEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3710986EB20;
	Wed, 20 Dec 2023 22:45:13 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 273FD40C6EB9;
	Wed, 20 Dec 2023 22:45:10 +0000 (UTC)
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
Subject: [PATCH v2 02/40] mm/rmap: introduce and use hugetlb_remove_rmap()
Date: Wed, 20 Dec 2023 23:44:26 +0100
Message-ID: <20231220224504.646757-3-david@redhat.com>
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

hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
For example, hugetlb currently only supports entire mappings, and treats
any mapping as mapped using a single "logical PTE". Let's move it out
of the way so we can overhaul our "ordinary" rmap.
implementation/interface.

Let's introduce and use hugetlb_remove_rmap() and remove the hugetlb
code from page_remove_rmap(). This effectively removes one check on the
small-folio path as well.

Add sanity checks that we end up with the right folios in the right
functions.

Note: all possible candidates that need care are page_remove_rmap() that
      pass compound=true.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  7 +++++++
 mm/hugetlb.c         |  4 ++--
 mm/rmap.c            | 18 +++++++++---------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 36096ba69bdcd..64ae6c4d72720 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -211,6 +211,13 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
+static inline void hugetlb_remove_rmap(struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+
+	atomic_dec(&folio->_entire_mapcount);
+}
+
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
 	if (compound) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 305f3ca1dee62..ef48ae6738909 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5676,7 +5676,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 					make_pte_marker(PTE_MARKER_UFFD_WP),
 					sz);
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
-		page_remove_rmap(page, vma, true);
+		hugetlb_remove_rmap(page_folio(page));
 
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
@@ -5987,7 +5987,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
-		page_remove_rmap(&old_folio->page, vma, true);
+		hugetlb_remove_rmap(old_folio);
 		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
 		if (huge_pte_uffd_wp(pte))
 			newpte = huge_pte_mkuffd_wp(newpte);
diff --git a/mm/rmap.c b/mm/rmap.c
index 9845499b22f8f..261e1af0d254f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1480,15 +1480,9 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	bool last;
 	enum node_stat_item idx;
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
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
@@ -1846,7 +1840,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -2199,7 +2196,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
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
2.43.0


