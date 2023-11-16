Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5F7ED8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbjKPBaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344522AbjKPB35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEC01998
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k0e00AejVp7ba16+GtnRW4DXLpdJhvAKN3LJp7S4MZU=;
        b=emhn3xMiKf8ctbhmkRjms69Nrxdm/+sdzlZElYnyd4aFAdu44akvpFO/Pbl+JJDDUoLXqx
        3lAQ7Bq4N3RcuVQef3m5CXh6zrl2od9uQrTpt8U9BXBMhpfk/zJsImNPlRtUoyIqfc2F7a
        L6Hho4CKRyk4XPsUd93H7nSRzO8qjFU=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-0dE_vhAMM6SblPENVDGvlw-1; Wed, 15 Nov 2023 20:29:33 -0500
X-MC-Unique: 0dE_vhAMM6SblPENVDGvlw-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-46107bc7936so12697137.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098171; x=1700702971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0e00AejVp7ba16+GtnRW4DXLpdJhvAKN3LJp7S4MZU=;
        b=UyCkTtwkEgkbc3eMSRFpITGAXUFtSNRDgLZH0w6L8HfhPR7Vjl3SdjvKOFNGv6JyX8
         ZAATQT7XOWLu1w4SUhFfZt9/7RhK/8yycZG/jMyuri53fZ7OtIr+X0EzL+dngRPxHnu1
         dK/4LzSh1Ppb9XpBRhfhr6oZDGz0ZMKJ5t60Vgwe3E0Dr9dSW6zc+HjhSImFRyv2egCX
         HrCrueFi4FzIMWV9VCoruxIP8KbQtqXxjDnSkLvUL7SD8KexEySOC/ESwZ9+zL4O9FPK
         0HrhEZUgL/5Bv4Ewf29f3wswWeM4w2LIMY+3f6zLcu5rgw/Z/phgUbjtPaaAjfKwWHVk
         4hhQ==
X-Gm-Message-State: AOJu0YzsEHgzsUQYqOPyxXRGPyFvX99qU8mMInbHnD8jaZSNoc9EJ4NL
        KsMX6KLdP37RY/ajGhd6+RMGBER8U4OVcY+o0pa7QgcVCLfcnI6GWh0sD6NMkWj8aC0HDlb7p1b
        g0b08DkNxYg83gyHktNE8JTGDzJl9a3Dtlx1mEwxHzUnFELmkScyUby1y/yrRmyeV1VD2Ybe32e
        fDRVonpg==
X-Received: by 2002:a1f:a017:0:b0:4ac:3694:7011 with SMTP id j23-20020a1fa017000000b004ac36947011mr7269398vke.0.1700098171317;
        Wed, 15 Nov 2023 17:29:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFewvoOFObJgHzAs8T/gdoGZhF8fsIKsBFTyxvttvo0eTXlsdk7Fy6qUthUD5DfsgEESegFFg==
X-Received: by 2002:a1f:a017:0:b0:4ac:3694:7011 with SMTP id j23-20020a1fa017000000b004ac36947011mr7269371vke.0.1700098170969;
        Wed, 15 Nov 2023 17:29:30 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:30 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RFC 12/12] mm/gup: Merge hugetlb into generic mm code
Date:   Wed, 15 Nov 2023 20:29:08 -0500
Message-ID: <20231116012908.392077-13-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
References: <20231116012908.392077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now follow_page() is ready to handle hugetlb pages in whatever form, and
over all architectures.  Switch to the generic code path.

Time to retire hugetlb_follow_page_mask(), following the previous
retirement of follow_hugetlb_page() in 4849807114b8.

There may be a slight difference of how the loops run when processing GUP
over a large hugetlb range on either ARM64 (e.g. CONT_PMD) or RISCV (mostly
its Svnapot extension on 64K huge pages): each loop of __get_user_pages()
will resolve one pgtable entry with the patch applied, rather than relying
on the size of hugetlb hstate, the latter may cover multiple entries in one
loop.

However, the performance difference should hopefully not be a major
concern, considering that GUP just yet got 57edfcfd3419 ("mm/gup:
accelerate thp gup even for "pages != NULL""), and that's not part of a
performance analysis but a side dish.  If the performance will be a
concern, we can consider handle CONT_PTE in follow_page(), for example.

Before that is justified to be necessary, keep everything clean and simple.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  7 ----
 mm/gup.c                | 15 +++------
 mm/hugetlb.c            | 71 -----------------------------------------
 3 files changed, 5 insertions(+), 88 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bb07279b8991..87630a185acf 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -332,13 +332,6 @@ static inline void hugetlb_zap_end(
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
index e635278f65f9..23fcac5aa3db 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -830,18 +830,11 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
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
 
@@ -853,6 +846,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	else
 		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
 
+	vma_pgtable_walk_end(vma);
+
 	return page;
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 29705e5c6f40..3013122a739f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6783,77 +6783,6 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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
2.41.0

