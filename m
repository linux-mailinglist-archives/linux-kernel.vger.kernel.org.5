Return-Path: <linux-kernel+bounces-7528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903EA81A94B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC5B2841DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EFE4B5D1;
	Wed, 20 Dec 2023 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mys13Qxm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F74B14E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXqiJu2pun8vKoCf/nv4oO60M9YSAaLT+Ujt3IpxQcI=;
	b=Mys13QxmQwLAHCKZSp4mAEjX0DjbahtIKGVDoIz4XBp6kp22FvHxV3/kPlecLIOgzDn3KR
	sQptmYpgMcGfIdbamGwv0276ULWq+i4mEVePY+5jbuyxHoEOcx6kvEvOkFVHTGxyNPfMSZ
	nYFUFUQ/UeUp4PUxzqBoM7urzL0mApA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-YB96pkyOPFqEud271oQ8LQ-1; Wed, 20 Dec 2023 17:45:15 -0500
X-MC-Unique: YB96pkyOPFqEud271oQ8LQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36C35101A551;
	Wed, 20 Dec 2023 22:45:15 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7185940C6EB9;
	Wed, 20 Dec 2023 22:45:13 +0000 (UTC)
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
Subject: [PATCH v2 03/40] mm/rmap: introduce and use hugetlb_add_file_rmap()
Date: Wed, 20 Dec 2023 23:44:27 +0100
Message-ID: <20231220224504.646757-4-david@redhat.com>
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

Right now we're using page_dup_file_rmap() in some cases where "ordinary"
rmap code would have used page_add_file_rmap(). So let's introduce and
use hugetlb_add_file_rmap() instead. We won't be adding a
"hugetlb_dup_file_rmap()" functon for the fork() case, as it would be
doing the same: "dup" is just an optimization for "add".

What remains is a single page_dup_file_rmap() call in fork() code.

Add sanity checks that we end up with the right folios in the right
functions.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 8 ++++++++
 mm/hugetlb.c         | 6 +++---
 mm/migrate.c         | 2 +-
 mm/rmap.c            | 1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 64ae6c4d72720..56900a16f41a6 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -211,6 +211,14 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
+static inline void hugetlb_add_file_rmap(struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
+
+	atomic_inc(&folio->_entire_mapcount);
+}
+
 static inline void hugetlb_remove_rmap(struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ef48ae6738909..57e8981879314 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5408,7 +5408,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * sleep during the process.
 			 */
 			if (!folio_test_anon(pte_folio)) {
-				page_dup_file_rmap(&pte_folio->page, true);
+				hugetlb_add_file_rmap(pte_folio);
 			} else if (page_try_dup_anon_rmap(&pte_folio->page,
 							  true, src_vma)) {
 				pte_t src_pte_old = entry;
@@ -6279,7 +6279,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	if (anon_rmap)
 		hugetlb_add_new_anon_rmap(folio, vma, haddr);
 	else
-		page_dup_file_rmap(&folio->page, true);
+		hugetlb_add_file_rmap(folio);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	/*
@@ -6730,7 +6730,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
-		page_dup_file_rmap(&folio->page, true);
+		hugetlb_add_file_rmap(folio);
 	else
 		hugetlb_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 7d1c3f292d24d..0e912443a18c3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -252,7 +252,7 @@ static bool remove_migration_pte(struct folio *folio,
 				hugetlb_add_anon_rmap(folio, vma, pvmw.address,
 						      rmap_flags);
 			else
-				page_dup_file_rmap(new, true);
+				hugetlb_add_file_rmap(folio);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte,
 					psize);
 		} else
diff --git a/mm/rmap.c b/mm/rmap.c
index 261e1af0d254f..a57ec926daf0c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1395,6 +1395,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 	unsigned int nr_pmdmapped = 0, first;
 	int nr = 0;
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
-- 
2.43.0


