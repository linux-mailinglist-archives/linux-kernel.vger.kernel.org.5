Return-Path: <linux-kernel+bounces-121504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53E88E906
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EF63223E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B713D2B8;
	Wed, 27 Mar 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI8ExIct"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E913B2B3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553038; cv=none; b=jPp1tjl7z5GTLs/w9ofur0EtcShB2vYjQ042I/M2JZZ3SHo6hnndFmiuindXbqu8fkxBI+6whOKRyjxZ6MeSLJRcG250gB8J/PwjzpFUajeNsOqhHxkkwvHFWOhI63t1+dhIcOvkbodiii4as1/QoX92RHb5QnNHJzt06dXQYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553038; c=relaxed/simple;
	bh=Rl12oXX/DgRCeB0bnnaEvwP2u/mMsRnIEWLnhgn6owg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFP846J7TqsgWLS41EWEV6afNCUO2onH64YU/Htze1JoxpxVOJ0ZxeG3bARQefW+9/Rp+f2QqJKgauI96e5kBO9a+kTLIfPasyJmgo/dyUgzhyJumFagGAtRkNs7bejCUzBRel67qc15vx8BL4eW0phGO6zgyCoVYeHKAi6QSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aI8ExIct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/UoYTg8lz4bAl/L4a1cbQCJuXO8WYRlAVPmeKHJK2E=;
	b=aI8ExIctnz+MO/k6HG2PjQHoK7pnFpP2+SER0XfNPlo5wJteoPn3ii3xq0IUGXWVJRI0fj
	qhbD3uJbSpSksMN9zZSC0uoXaDWAJh4AtOfumaqW5kPT5qQ/2d3N52Xc9bJ1QHeHtcnB28
	cvu58NOWDkUqnU3kvwoSf+OaTzlSlG4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-5wHuOjQ6PaiGVfCXL-ovSg-1; Wed, 27 Mar 2024 11:23:54 -0400
X-MC-Unique: 5wHuOjQ6PaiGVfCXL-ovSg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7830635331bso149215085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553033; x=1712157833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/UoYTg8lz4bAl/L4a1cbQCJuXO8WYRlAVPmeKHJK2E=;
        b=xLr2Lb0F/MA/i9iNoTeW2NSKAFy4MTPJ4Psclv71QfyDWSyLxhmsjy/BqVkCFtByPr
         DvJJEvOLXwjuaOM6vn0lg4r/zmfPnxWP2YoQfPkgHXEgWRIZ6i/rLdEgRwaoIZ8MCVUL
         ju/C3CF14iqmnJL564n9X5zGpD2Xxleouihrn6YDHq7r7EKF+YXJQpLRs9oI+Yz7czKb
         /8ACwD8mHYNh8/MAtlFn+9oN0yq71ncMFmo0cSb00LnbYhVKGuIOmIEisiYcXWc9pSg/
         XhYTA87eOMS/4gcaQY19zlOlbl5fcx6JYj4eKzI+kdbQlVwOl+U7HNTIPFNBEoDMDren
         gFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaGku7OlDqQwxzewqK9rdPaLlwG4edvDvQtbrqXE1+8eSxnHwRLFaQU6vuGrhveBDMHXov6hm90u7haVRStd59tOK6K407b/Te39pa
X-Gm-Message-State: AOJu0YywoWbQeEamYXC6G8i8vvw0SCXoYqEk7bc77+MnY4iduXGwf5wW
	VsfJqA65Ury376hyLvHPnIHSNAd6x6G1lxOzySc9y0ts0a5Sy06CjbT/vYov1oVMZjm8OJ2pz6Y
	9fZ82U509JHE5K1h7o27CEXiKJ2VoEOyNkLLWNbfCtnwAdATwrqFe5hKIqdBzDA==
X-Received: by 2002:a05:6214:4a8a:b0:696:ad00:7deb with SMTP id pi10-20020a0562144a8a00b00696ad007debmr2078362qvb.2.1711553033242;
        Wed, 27 Mar 2024 08:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Fh1FPXUmWlSE4Ssu3coIMvek7Et1xEVKx+8QTY39hYxqq3mRFRgZ7bz+i1V9Jmd/zYMv6Q==
X-Received: by 2002:a05:6214:4a8a:b0:696:ad00:7deb with SMTP id pi10-20020a0562144a8a00b00696ad007debmr2078325qvb.2.1711553032687;
        Wed, 27 Mar 2024 08:23:52 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:52 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	peterx@redhat.com,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v4 08/13] mm/gup: Handle hugetlb for no_page_table()
Date: Wed, 27 Mar 2024 11:23:27 -0400
Message-ID: <20240327152332.950956-9-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152332.950956-1-peterx@redhat.com>
References: <20240327152332.950956-1-peterx@redhat.com>
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
index c2881772216b..ef46a7053e16 100644
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


