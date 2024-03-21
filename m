Return-Path: <linux-kernel+bounces-110733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265CE8862FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77C81F237A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3623137936;
	Thu, 21 Mar 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6M+PJYr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16E137914
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058904; cv=none; b=QiEYOWs2NhbryDzhINCB1U5wpViKaYtuOdh53UEGVlhWQtkpeUHB+bayj02nFydZ1ypkZOb18+ZxIDEEFdVn4wYlUhAWojsJMszFxJdTLLLlXl9DFHoUvg2GEHAYu7IziZmXlYGe66+zcrc0VJ7G6WLpSlNjoL12Dk4DK/G1vSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058904; c=relaxed/simple;
	bh=8dzAfFfd0rJLLlAOHkOIITBY0yDGO+q+j5nFR28BMCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2NedE5fqjYhGACMeWHi2LUWCJnqNPn/U8VEAUBd9epkr+4T6u2Sa4etVBjpJnpPeuzLmxGVUNJ4yRDqoWvK/kBpTLaJS6e3FB64a0waaNEgmrrlL9vB3NjCnHlT/vscGfRiXi5TbQkOLa3fGHYMK5HihOnKidYs7WaP3UCtYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6M+PJYr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+6dxwHwA9JOroUFOiyHgWbjpU2ZpFB4CR6YlbtDU08=;
	b=Z6M+PJYrCKwOBdZaM7dzxW1VWq3/BkrltsmAnsN7mWsL0uB2SKjIMBPqQANenKrnALdIlx
	ZV1yKodHU+dWU4J2fyaQlGqKgfoTOsG7yvWaQytuyf8lIoM+A1hINZfzCPI+QQHF5Eft1e
	mqdT7/9Xu9FmVbVxFE1045z66/T97U4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-0EQSc2GUNw6Qr_RYEG17Ag-1; Thu, 21 Mar 2024 18:08:19 -0400
X-MC-Unique: 0EQSc2GUNw6Qr_RYEG17Ag-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6961a54234cso2674296d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058899; x=1711663699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+6dxwHwA9JOroUFOiyHgWbjpU2ZpFB4CR6YlbtDU08=;
        b=AWDkQlJxPgl6ASqTU1ao6j9HY2DnH6vCOHbfOcSzVdqor+t20TdURARfYsHuRT9dAv
         HX+Xgi6rkI6afG7DMctLMjmyInirTD6/vrFFDyJn8u/9bqiI3g7rbNGsIu283OAxIoEd
         nApVEhjaw3JAP9VMOrrvGauS6bEDgSaTnagAz384HFVue+TxwPPVQACFPk6eluYS4VYV
         4EXBO2RNzcuB2De2Ord+zDHqW576C9IaEZQmF326zbMM+3IpLEWoDc3jvY5EYDnbK1aS
         D25M22ccRXlKwBcTHDiVGY81qPnzmRp0vbUGOjISy9WlJrxmxKVZPCpvqLTAZJzSjynq
         giWw==
X-Forwarded-Encrypted: i=1; AJvYcCWrEJuKiTw47fEbXqnlQEAU9pROkNg7MbdN+VOgoPyxxiV+uPJo1DOeywa8bzpvfYz45CtMJtJu+9IDmiwAU4TxmT6Y/dE9uXRBr/5W
X-Gm-Message-State: AOJu0YxVAsPLZf/72jllCAwURvbYWzqQBGKqlMfa0wjl2bxp5b0Nd9H6
	koFqE9TrCbD6pLSRTzh4YOAgDf7Hs/mHHWVWPJOwVEWB8m1nC5SX+hMJ6/24x7OD2ld7pwyR1T3
	CCBUn4BkivirboksuI8k8hTZ6Nx6RvMaRDtlde5kIknIWu/qLraDVCMh0z5lhJw==
X-Received: by 2002:a05:6214:3912:b0:691:456f:415a with SMTP id nh18-20020a056214391200b00691456f415amr179394qvb.4.1711058899093;
        Thu, 21 Mar 2024 15:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnkSxmKz4azbUELRR0cRTvXrQr4udCnJcoTFPGMx5l/qOyVfxe6G6Q7JjdIdQ6Zo0lZ2QFGA==
X-Received: by 2002:a05:6214:3912:b0:691:456f:415a with SMTP id nh18-20020a056214391200b00691456f415amr179365qvb.4.1711058898616;
        Thu, 21 Mar 2024 15:08:18 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:18 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	peterx@redhat.com,
	Yang Shi <shy828301@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 07/12] mm/gup: Handle hugetlb for no_page_table()
Date: Thu, 21 Mar 2024 18:07:57 -0400
Message-ID: <20240321220802.679544-8-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321220802.679544-1-peterx@redhat.com>
References: <20240321220802.679544-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

no_page_table() is not yet used for hugetlb code paths. Make it prepared.

The major difference here is hugetlb will return -EFAULT as long as page
cache does not exist, even if VM_SHARED.  See hugetlb_follow_page_mask().

Pass "address" into no_page_table() too, as hugetlb will need it.

Reviewed-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f3ae8f6ce8a4..943671736080 100644
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
@@ -777,10 +785,10 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	p4dp = p4d_offset(pgdp, address);
 	p4d = READ_ONCE(*p4dp);
 	if (!p4d_present(p4d))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	BUILD_BUG_ON(p4d_leaf(p4d));
 	if (unlikely(p4d_bad(p4d)))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 
 	return follow_pud_mask(vma, address, p4dp, flags, ctx);
 }
@@ -830,7 +838,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	pgd = pgd_offset(mm, address);
 
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 
 	return follow_p4d_mask(vma, address, pgd, flags, ctx);
 }
-- 
2.44.0


