Return-Path: <linux-kernel+bounces-121509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2488E90C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7601F2E67B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E413E899;
	Wed, 27 Mar 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vo0xKbzH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5992513E6DC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553050; cv=none; b=s5FcZPXaRUv0EUE8eIJ+18Oxk7QbDrxrmw32ekZuPTbKQIU78+3D3LEUhVv4Upis3CxQSBCu7dE7F4tm7jyBZF3KsJxnczQZf1vslgnUQa3uVGJVwb9XTNIMxEskwXDwYfEpkVFudYh+pBsNvXIxkMe4g1LbnFvQOwOIfy+LFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553050; c=relaxed/simple;
	bh=wSpbBOWGGzwi1/5NMl6YGMIf3dXrsw5k5vnFDJI0MhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RosK2dFhIWT9RS+jOi0Tc3D4CovaaUyFN94OMDSeiTPkgx1ejoDsYEuCeS87Hd359UdCOI1WEQMlIvrys6moczg9gknxDozjqz2RmT93ayxDyxoVoD5KhKJtCSSrQFHSdvejRWVSAtg4swa9IAplD98lrNiRt4kwSxfI+OTYW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vo0xKbzH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqT6FBXOR6azzagmtpaiz+BS8+Dy8n2ikly9Wvyy/LU=;
	b=Vo0xKbzHkwn3b23WZbadSpoXUCzmoiGOzsY3CBFUal+e5eqGmrH9RjrawJ5a+ladOktSyL
	fSf1JpX4PiF1XWz0vQF7MY8cJ7JwmQBjmaVFlw/KmQXx2HzGecDHpv2NDZ7xldM+fNLnMm
	HiVrudPyTECCVP1qN7mYNJ5corvn0xQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-NmCDTP7mMguFK0WEbgROOA-1; Wed, 27 Mar 2024 11:24:06 -0400
X-MC-Unique: NmCDTP7mMguFK0WEbgROOA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6e4fe655c93so2426396a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553043; x=1712157843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqT6FBXOR6azzagmtpaiz+BS8+Dy8n2ikly9Wvyy/LU=;
        b=ROc9te8Xi2OYr4Q18hhJyvhdv7uvKiRgnKYkeBnqocPGwIlsLO1XwhIp/+jYY3kKgb
         qCrDkcaboRtuYmtoQb7D6TT1v7O1iwOh5fuG1kB0vsBUUtilT51Q+KbCtVJpzt3WKEXG
         H11ngRt+3rTrwhPDCV69WZ7Na/RtPU3PnkVWmRAZl+vYnqUwrX5GT8Kv0EudD/1eMC7a
         1MF7IxwfilmWC8JVePXZwXpoTgf+SflPOSwkiWE2GsPmawSDP/pW9casgGQwzl+xPHiv
         nYQlNCXornhhshI/G25NNlTxkTu8q3yZ6pZeb7lzADJBOTiIuv6O2St8c8tXbZmvpwUx
         lWUw==
X-Forwarded-Encrypted: i=1; AJvYcCX3AOlAm3U0ObpURcLvF8kJmHUcGb2RaWB4JFUoBGUSmNtEbmRntsHE9RcXBcGsv8DAAqmiyHKALHRkrOxiJB2gJPEk1GmlYqQFGsAr
X-Gm-Message-State: AOJu0Yx1SwqGqQRziIwoC5fRx4eA/BVZPkU4CNOLSNtzhTYo6QRG7Imq
	9xn0Cg8MZT1nF+2WUxfWeCcOpF0tovX7abWXK/1BkQ/eIvJ9Knbp34YhwmXuxXO64qbt+UHVvOO
	yK+yIkSlhoXw4Xnk0yNSQu70j704wK5eK1+9Dbs1vP+2LbWufiw45MARJklFijg==
X-Received: by 2002:a05:6808:1381:b0:3c3:d815:b670 with SMTP id c1-20020a056808138100b003c3d815b670mr278654oiw.2.1711553043450;
        Wed, 27 Mar 2024 08:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2f7pSTtNK/4lDxloQcNJtvLkvUR42Ph4fHUFnW1nCtEkqTm3cUEoT3r9uMsOerfq/WsXhuA==
X-Received: by 2002:a05:6808:1381:b0:3c3:d815:b670 with SMTP id c1-20020a056808138100b003c3d815b670mr278609oiw.2.1711553042809;
        Wed, 27 Mar 2024 08:24:02 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:24:02 -0700 (PDT)
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
Subject: [PATCH v4 13/13] mm/gup: Handle hugetlb in the generic follow_page_mask code
Date: Wed, 27 Mar 2024 11:23:32 -0400
Message-ID: <20240327152332.950956-14-peterx@redhat.com>
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

Now follow_page() is ready to handle hugetlb pages in whatever form, and
over all architectures.  Switch to the generic code path.

Time to retire hugetlb_follow_page_mask(), following the previous
retirement of follow_hugetlb_page() in 4849807114b8.

There may be a slight difference of how the loops run when processing slow
GUP over a large hugetlb range on cont_pte/cont_pmd supported archs: each
loop of __get_user_pages() will resolve one pgtable entry with the patch
applied, rather than relying on the size of hugetlb hstate, the latter may
cover multiple entries in one loop.

A quick performance test on an aarch64 VM on M1 chip shows 15% degrade over
a tight loop of slow gup after the path switched.  That shouldn't be a
problem because slow-gup should not be a hot path for GUP in general: when
page is commonly present, fast-gup will already succeed, while when the
page is indeed missing and require a follow up page fault, the slow gup
degrade will probably buried in the fault paths anyway.  It also explains
why slow gup for THP used to be very slow before 57edfcfd3419 ("mm/gup:
accelerate thp gup even for "pages != NULL"") lands, the latter not part of
a performance analysis but a side benefit.  If the performance will be a
concern, we can consider handle CONT_PTE in follow_page().

Before that is justified to be necessary, keep everything clean and simple.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  7 ----
 mm/gup.c                | 15 +++------
 mm/hugetlb.c            | 71 -----------------------------------------
 3 files changed, 5 insertions(+), 88 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 294c78b3549f..a546140f89cd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -328,13 +328,6 @@ static inline void hugetlb_zap_end(
 {
 }
 
-static inline struct page *hugetlb_follow_page_mask(
-    struct vm_area_struct *vma, unsigned long address, unsigned int flags,
-    unsigned int *page_mask)
-{
-	BUILD_BUG(); /* should never be compiled in if !CONFIG_HUGETLB_PAGE*/
-}
-
 static inline int copy_hugetlb_page_range(struct mm_struct *dst,
 					  struct mm_struct *src,
 					  struct vm_area_struct *dst_vma,
diff --git a/mm/gup.c b/mm/gup.c
index a02463c9420e..c803d0b0f358 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1135,18 +1135,11 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 {
 	pgd_t *pgd;
 	struct mm_struct *mm = vma->vm_mm;
+	struct page *page;
 
-	ctx->page_mask = 0;
-
-	/*
-	 * Call hugetlb_follow_page_mask for hugetlb vmas as it will use
-	 * special hugetlb page table walking code.  This eliminates the
-	 * need to check for hugetlb entries in the general walking code.
-	 */
-	if (is_vm_hugetlb_page(vma))
-		return hugetlb_follow_page_mask(vma, address, flags,
-						&ctx->page_mask);
+	vma_pgtable_walk_begin(vma);
 
+	ctx->page_mask = 0;
 	pgd = pgd_offset(mm, address);
 
 	if (unlikely(is_hugepd(__hugepd(pgd_val(*pgd)))))
@@ -1157,6 +1150,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	else
 		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
 
+	vma_pgtable_walk_end(vma);
+
 	return page;
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 65b9c9a48fd2..cc79891a3597 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6870,77 +6870,6 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 }
 #endif /* CONFIG_USERFAULTFD */
 
-struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
-				      unsigned long address, unsigned int flags,
-				      unsigned int *page_mask)
-{
-	struct hstate *h = hstate_vma(vma);
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long haddr = address & huge_page_mask(h);
-	struct page *page = NULL;
-	spinlock_t *ptl;
-	pte_t *pte, entry;
-	int ret;
-
-	hugetlb_vma_lock_read(vma);
-	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
-	if (!pte)
-		goto out_unlock;
-
-	ptl = huge_pte_lock(h, mm, pte);
-	entry = huge_ptep_get(pte);
-	if (pte_present(entry)) {
-		page = pte_page(entry);
-
-		if (!huge_pte_write(entry)) {
-			if (flags & FOLL_WRITE) {
-				page = NULL;
-				goto out;
-			}
-
-			if (gup_must_unshare(vma, flags, page)) {
-				/* Tell the caller to do unsharing */
-				page = ERR_PTR(-EMLINK);
-				goto out;
-			}
-		}
-
-		page = nth_page(page, ((address & ~huge_page_mask(h)) >> PAGE_SHIFT));
-
-		/*
-		 * Note that page may be a sub-page, and with vmemmap
-		 * optimizations the page struct may be read only.
-		 * try_grab_page() will increase the ref count on the
-		 * head page, so this will be OK.
-		 *
-		 * try_grab_page() should always be able to get the page here,
-		 * because we hold the ptl lock and have verified pte_present().
-		 */
-		ret = try_grab_page(page, flags);
-
-		if (WARN_ON_ONCE(ret)) {
-			page = ERR_PTR(ret);
-			goto out;
-		}
-
-		*page_mask = (1U << huge_page_order(h)) - 1;
-	}
-out:
-	spin_unlock(ptl);
-out_unlock:
-	hugetlb_vma_unlock_read(vma);
-
-	/*
-	 * Fixup retval for dump requests: if pagecache doesn't exist,
-	 * don't try to allocate a new page but just skip it.
-	 */
-	if (!page && (flags & FOLL_DUMP) &&
-	    !hugetlbfs_pagecache_present(h, vma, address))
-		page = ERR_PTR(-EFAULT);
-
-	return page;
-}
-
 long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
-- 
2.44.0


