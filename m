Return-Path: <linux-kernel+bounces-7526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2ED81A949
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579901F240CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856B4B144;
	Wed, 20 Dec 2023 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNNrcXAr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3984AF9D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+bCjcGey/V7RsjKz554fGR3BU3YAAJC2JoClW1JlMc=;
	b=iNNrcXAra2Fi+3+pj3KEqyjCJ4vmyZFc0rgG2lyTi6Mo9oB//IzQUzFP+9pPllVq6qoFhA
	QNlh+MX6nCcKPFyf7VfKr5rH0UDZo5d/lNiQRoKmIEVlfNy4mcrpwqSV6Sg09JifGZYaZV
	WZwsJzh1j5KklzELHBn5z6EyfQUuP4s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-Wt5IrIHnNeaZg63pnEl0Gw-1; Wed, 20 Dec 2023 17:45:11 -0500
X-MC-Unique: Wt5IrIHnNeaZg63pnEl0Gw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB553848C06;
	Wed, 20 Dec 2023 22:45:10 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 608DF40C6EB9;
	Wed, 20 Dec 2023 22:45:08 +0000 (UTC)
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
	Peter Xu <peterx@redhat.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 01/40] mm/rmap: rename hugepage_add* to hugetlb_add*
Date: Wed, 20 Dec 2023 23:44:25 +0100
Message-ID: <20231220224504.646757-2-david@redhat.com>
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

Let's just call it "hugetlb_".

Yes, it's all already inconsistent and confusing because we have a lot
of "hugepage_" functions for legacy reasons. But "hugetlb" cannot possibly
be confused with transparent huge pages, and it matches "hugetlb.c" and
"folio_test_hugetlb()". So let's minimize confusion in rmap code.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 4 ++--
 mm/hugetlb.c         | 8 ++++----
 mm/migrate.c         | 4 ++--
 mm/rmap.c            | 8 ++++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0ae2bb0e77f5d..36096ba69bdcd 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -206,9 +206,9 @@ void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 
-void hugepage_add_anon_rmap(struct folio *, struct vm_area_struct *,
+void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
-void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
+void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
 static inline void __page_dup_rmap(struct page *page, bool compound)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6feb3e0630d18..305f3ca1dee62 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5285,7 +5285,7 @@ hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long add
 	pte_t newpte = make_huge_pte(vma, &new_folio->page, 1);
 
 	__folio_mark_uptodate(new_folio);
-	hugepage_add_new_anon_rmap(new_folio, vma, addr);
+	hugetlb_add_new_anon_rmap(new_folio, vma, addr);
 	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(old))
 		newpte = huge_pte_mkuffd_wp(newpte);
 	set_huge_pte_at(vma->vm_mm, addr, ptep, newpte, sz);
@@ -5988,7 +5988,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		page_remove_rmap(&old_folio->page, vma, true);
-		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
+		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
 		if (huge_pte_uffd_wp(pte))
 			newpte = huge_pte_mkuffd_wp(newpte);
 		set_huge_pte_at(mm, haddr, ptep, newpte, huge_page_size(h));
@@ -6277,7 +6277,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 
 	if (anon_rmap)
-		hugepage_add_new_anon_rmap(folio, vma, haddr);
+		hugetlb_add_new_anon_rmap(folio, vma, haddr);
 	else
 		page_dup_file_rmap(&folio->page, true);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
@@ -6732,7 +6732,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	if (folio_in_pagecache)
 		page_dup_file_rmap(&folio->page, true);
 	else
-		hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
+		hugetlb_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
 	/*
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
diff --git a/mm/migrate.c b/mm/migrate.c
index bad3039d165e6..7d1c3f292d24d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -249,8 +249,8 @@ static bool remove_migration_pte(struct folio *folio,
 
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
-				hugepage_add_anon_rmap(folio, vma, pvmw.address,
-						       rmap_flags);
+				hugetlb_add_anon_rmap(folio, vma, pvmw.address,
+						      rmap_flags);
 			else
 				page_dup_file_rmap(new, true);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte,
diff --git a/mm/rmap.c b/mm/rmap.c
index 23da5b1ac33b4..9845499b22f8f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2625,8 +2625,8 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
  *
  * RMAP_COMPOUND is ignored.
  */
-void hugepage_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
-			    unsigned long address, rmap_t flags)
+void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
+		unsigned long address, rmap_t flags)
 {
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
@@ -2637,8 +2637,8 @@ void hugepage_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 			 PageAnonExclusive(&folio->page), folio);
 }
 
-void hugepage_add_new_anon_rmap(struct folio *folio,
-			struct vm_area_struct *vma, unsigned long address)
+void hugetlb_add_new_anon_rmap(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long address)
 {
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
-- 
2.43.0


