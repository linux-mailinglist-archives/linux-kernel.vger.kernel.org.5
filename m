Return-Path: <linux-kernel+bounces-110738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7F886303
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B65D1F230BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3971386C5;
	Thu, 21 Mar 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd6/fIsO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722041386A9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058916; cv=none; b=d0DJATnfHL+Mzoitbzfq53eq1qUOEz5fVgRfCnh64imBx2r9JzEV4lv6K4jsKu/WBxojmOyKg26axEpCNyMCn1heBBWjy8XJrztuZr+DvQvzWwwrf5RFwvFxDao/L+ofrfPZj7GZq3yQZtuAJ8BQHMwchFqRymjcmQdqql3hkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058916; c=relaxed/simple;
	bh=JCGnxD1BohZitMTzx7yYKiVmGWHn7FCotr9St3beHS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWFzVGoDRn9+BjDLZEtBitiLfuosAIoIDodIJFP9d0p26LwRisOJZtC2ev14Mf52hvz99ba5tQEzWcr5eHo4PAMc8rS1Ze97VwMog1OuLc7YynBB3gHDzlYYpOXcyGOJR6FTebgjujEI1oYsfwEgOlKvA5/I6uk9pK2ozQOjiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jd6/fIsO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKAkS039JEm9eSlNjnxGInSB8mOTV3IHPzDUFjGHTVk=;
	b=Jd6/fIsOSh/xM+NSmFc9k2PILZ0AQz0Rd+zhfRve2OVQNF1hBiKkDHVnbfdzmTcjCHDTus
	rXENBlpcxPxVHg04MetFWzcJfZh0uS/QyiE+mJcLWeumw/kUqaZcu7p2cZDnFnEHFmy5tP
	wBEdePRwCW9PlssxMQNLWcCz/UcowjI=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-Y7qGGGu6OF29F7vdo4oEZQ-1; Thu, 21 Mar 2024 18:08:32 -0400
X-MC-Unique: Y7qGGGu6OF29F7vdo4oEZQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-221a566a435so551712fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058909; x=1711663709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKAkS039JEm9eSlNjnxGInSB8mOTV3IHPzDUFjGHTVk=;
        b=ds3YpMiROOfyDGcH8OjK39Wq71GWmyQ8oKsC/DXhy3bqnTJaDZY4LzxTjknhDnF4Sj
         r76xNvGglrWCnY7IUsi5iMid0kyc5Xz/XBfP0cUvlZQuUCJm+66FPrPSH7fztPSJT2fF
         1qH3ntAY0u94OlPq6lZDho+lT+r2rt5tU9f3BMbWZvXA9gk9DXxzDTDkvxm6motDm7kG
         na4DoW+nYqIMmpM6nhfb/tfUmsk6QOFZ8dyHJczQjPgYNTLooOYPqre0/WuGdmDz1gQB
         FZvDSzUn7388qhYqM++yT3jzrPWJVJ8USOPst0XRqBFIsDoLedYQPGDQ58kEuv/E6iOF
         qnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6VYRJfIs61YeYBrIa9H7lcr4M5MMmnivg4hUKHyWI5JO+Tx9/v2qphpF/IjbxTN3ROVV8zkq0lSqH2Dd39tA26Oa3NF5v5WORXZWL
X-Gm-Message-State: AOJu0YxFVZZP2heZl28wiEu0oszdGgbMf7WookMMM45bdAvUt/FQMuRS
	XOBuDCutHmMqytDNtpY9Mlz1SJ42uTI+c7BztqZwp1Qob89oQ5yyEW+KK1bkAHfxLya/I53Dmun
	carcUk5YtfKGb4Bxkl4G3xJ37KgMXYifZVPcpowyb9erGfpCncIvYGhepB7iVPw==
X-Received: by 2002:a4a:d5ce:0:b0:5a2:26c7:397b with SMTP id a14-20020a4ad5ce000000b005a226c7397bmr912023oot.0.1711058909583;
        Thu, 21 Mar 2024 15:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7bJa0sTEC4z3o8Ei9oO8UNdi6+GHr5ekBXamqtFS26QUeqg4nthASLLtCNNWPAVCCH5AJXA==
X-Received: by 2002:a4a:d5ce:0:b0:5a2:26c7:397b with SMTP id a14-20020a4ad5ce000000b005a226c7397bmr911987oot.0.1711058909121;
        Thu, 21 Mar 2024 15:08:29 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:28 -0700 (PDT)
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
Subject: [PATCH v3 12/12] mm/gup: Handle hugetlb in the generic follow_page_mask code
Date: Thu, 21 Mar 2024 18:08:02 -0400
Message-ID: <20240321220802.679544-13-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  7 ----
 mm/gup.c                | 15 +++------
 mm/hugetlb.c            | 71 -----------------------------------------
 3 files changed, 5 insertions(+), 88 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 52d9efcf1edf..85e1c9931ae5 100644
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
index 43a2e0a203cd..2eb5911ba849 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -997,18 +997,11 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 {
 	pgd_t *pgd, pgdval;
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
 	pgdval = *pgd;
 
@@ -1020,6 +1013,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	else
 		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
 
+	vma_pgtable_walk_end(vma);
+
 	return page;
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index abec04575c89..2e320757501b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6883,77 +6883,6 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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


