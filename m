Return-Path: <linux-kernel+bounces-15323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A50822A21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946E5B2329F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D153199D7;
	Wed,  3 Jan 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SB6vapr0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6F199A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704273381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2/9/uEWavAhcbGvkqENWO1xIuQmr8G4qpstfk2UpBk=;
	b=SB6vapr06Lb6yI0WaNz1St8AEfA19VPHQFdHLwyTNh9fQdlFzbkPAqvZPIIZ0oAWtqjOTd
	MpodwMLBOZ8SzVCe4SHZMUj23JYff4K2HD9IvmPT65l/MnpdgYXkomYJ0c7+HDstBce8Zo
	Hn6kwWZmITn/00kubCwMODHxJXtI0aU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-bfNmJltGNpCYZPt_-QXM8w-1; Wed, 03 Jan 2024 04:16:16 -0500
X-MC-Unique: bfNmJltGNpCYZPt_-QXM8w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 633D085CBA5;
	Wed,  3 Jan 2024 09:16:15 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E9FD492BE6;
	Wed,  3 Jan 2024 09:16:05 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Yang Shi <shy828301@gmail.com>,
	peterx@redhat.com,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Jones <andrew.jones@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 08/13] mm/gup: Handle hugetlb for no_page_table()
Date: Wed,  3 Jan 2024 17:14:18 +0800
Message-ID: <20240103091423.400294-9-peterx@redhat.com>
In-Reply-To: <20240103091423.400294-1-peterx@redhat.com>
References: <20240103091423.400294-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Peter Xu <peterx@redhat.com>

no_page_table() is not yet used for hugetlb code paths. Make it prepared.

The major difference here is hugetlb will return -EFAULT as long as page
cache does not exist, even if VM_SHARED.  See hugetlb_follow_page_mask().

Pass "address" into no_page_table() too, as hugetlb will need it.

Reviewed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3813aad79c4a..b8a80e2bfe08 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -501,19 +501,27 @@ static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
 
 #ifdef CONFIG_MMU
 static struct page *no_page_table(struct vm_area_struct *vma,
-		unsigned int flags)
+				  unsigned int flags, unsigned long address)
 {
+	if (!(flags & FOLL_DUMP))
+		return NULL;
+
 	/*
-	 * When core dumping an enormous anonymous area that nobody
-	 * has touched so far, we don't want to allocate unnecessary pages or
+	 * When core dumping, we don't want to allocate unnecessary pages or
 	 * page tables.  Return error instead of NULL to skip handle_mm_fault,
 	 * then get_dump_page() will return NULL to leave a hole in the dump.
 	 * But we can only make this optimization where a hole would surely
 	 * be zero-filled if handle_mm_fault() actually did handle it.
 	 */
-	if ((flags & FOLL_DUMP) &&
-			(vma_is_anonymous(vma) || !vma->vm_ops->fault))
+	if (is_vm_hugetlb_page(vma)) {
+		struct hstate *h = hstate_vma(vma);
+
+		if (!hugetlbfs_pagecache_present(h, vma, address))
+			return ERR_PTR(-EFAULT);
+	} else if ((vma_is_anonymous(vma) || !vma->vm_ops->fault)) {
 		return ERR_PTR(-EFAULT);
+	}
+
 	return NULL;
 }
 
@@ -593,7 +601,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!ptep)
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	pte = ptep_get(ptep);
 	if (!pte_present(pte))
 		goto no_page;
@@ -685,7 +693,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	pte_unmap_unlock(ptep, ptl);
 	if (!pte_none(pte))
 		return NULL;
-	return no_page_table(vma, flags);
+	return no_page_table(vma, flags, address);
 }
 
 static struct page *follow_pmd_mask(struct vm_area_struct *vma,
@@ -701,27 +709,27 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	pmd = pmd_offset(pudp, address);
 	pmdval = pmdp_get_lockless(pmd);
 	if (pmd_none(pmdval))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	if (!pmd_present(pmdval))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	if (pmd_devmap(pmdval)) {
 		ptl = pmd_lock(mm, pmd);
 		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
 		spin_unlock(ptl);
 		if (page)
 			return page;
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	}
 	if (likely(!pmd_trans_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
 	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 
 	ptl = pmd_lock(mm, pmd);
 	if (unlikely(!pmd_present(*pmd))) {
 		spin_unlock(ptl);
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	}
 	if (unlikely(!pmd_trans_huge(*pmd))) {
 		spin_unlock(ptl);
@@ -752,17 +760,17 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 
 	pud = pud_offset(p4dp, address);
 	if (pud_none(*pud))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	if (pud_devmap(*pud)) {
 		ptl = pud_lock(mm, pud);
 		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
 		spin_unlock(ptl);
 		if (page)
 			return page;
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	}
 	if (unlikely(pud_bad(*pud)))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 
 	return follow_pmd_mask(vma, address, pud, flags, ctx);
 }
@@ -776,10 +784,10 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 
 	p4d = p4d_offset(pgdp, address);
 	if (p4d_none(*p4d))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	BUILD_BUG_ON(p4d_huge(*p4d));
 	if (unlikely(p4d_bad(*p4d)))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 
 	return follow_pud_mask(vma, address, p4d, flags, ctx);
 }
@@ -829,7 +837,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	pgd = pgd_offset(mm, address);
 
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 
 	return follow_p4d_mask(vma, address, pgd, flags, ctx);
 }
-- 
2.41.0


