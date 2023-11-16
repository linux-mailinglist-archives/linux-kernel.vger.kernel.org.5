Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33BC7ED8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbjKPBaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbjKPB3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBD61706
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEE21en6sv5Z4IJFnP9A/1kLw7BwwEfESnJrJ/3CqcU=;
        b=h7zlXrn8zrW74CJMkpadoUkRJcfR5gZpgT7jXdBD4voMj88YYiZ37923d7kM75THsruA01
        TVlx3y9AHjUCHu2gjJKejocUshcM9L+BYtQ++GV48G+SVVL0U6Omnt0c3i3Yu1SYhnJQdd
        X5UarljeMDla+lOez5uIOJd5PRcampE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-n_kWC-KfMnuTYLLrOvvnyg-1; Wed, 15 Nov 2023 20:29:28 -0500
X-MC-Unique: n_kWC-KfMnuTYLLrOvvnyg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-421be23b19aso883911cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098168; x=1700702968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEE21en6sv5Z4IJFnP9A/1kLw7BwwEfESnJrJ/3CqcU=;
        b=hihRItkr9GIqNlc44y2699XFRqY/xQFNB/VnCH4cVPlZn2p5q/XeOxahsNtb3PgJk9
         ciJ80ki/Qpi3RJYyUbn9NLzHlxNeap+BJ1VYkrs5JwVRyiMFL+GmeMlPqjP8L4aeDoPf
         YFpztV01MnHwVnESLjfp77gpRlMBObd1KKcZ+BQ2bFpwQskJkVo1cE6HX+B+m7bGZxab
         rhO9C7QsbNv5VBmFUn3pOYczSKTDRdQW4y99tlT5la3NQmBxaHXHvw2lNOM1neUaYsXO
         RgifVEnMPymoKztLKh64wT2lK06lnY6LfGaNOK7mOODbI403TTZ7JDg1cMJJFJ+YLT3p
         84pA==
X-Gm-Message-State: AOJu0YzrkWFiUSzgXuN+zt+gMKnO5wQd2GCSck2Wfl3rPCwqTUvbeMRu
        Bfjr0IhdtRA9R8o659aNrBnqN88prlIz7EE24I793MHoDRLX0iIWDhr/CkywMQh4PRSPqHrsuQ3
        ZcZcNAWwgvq+BTnwyPWqynrme6Uzp55Iq+0ERB3PS6oTyd0ndfb05GezyPhG3gnueVBvgi6gtwl
        RpTAAHVw==
X-Received: by 2002:ac8:5254:0:b0:421:c7ad:bb08 with SMTP id y20-20020ac85254000000b00421c7adbb08mr8123216qtn.6.1700098167845;
        Wed, 15 Nov 2023 17:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0pY05bEW1kuLTvTDTDFSfvrB9/wLj2Toyy995bIe7hSkDprXdYQMw37m3Xz3vWwWvq8gVXw==
X-Received: by 2002:ac8:5254:0:b0:421:c7ad:bb08 with SMTP id y20-20020ac85254000000b00421c7adbb08mr8123183qtn.6.1700098167489;
        Wed, 15 Nov 2023 17:29:27 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:27 -0800 (PST)
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
Subject: [PATCH RFC 10/12] mm/gup: Handle huge pmd for follow_pmd_mask()
Date:   Wed, 15 Nov 2023 20:29:06 -0500
Message-ID: <20231116012908.392077-11-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
References: <20231116012908.392077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do proper replacement of pmd_trans_huge() by using pmd_thp_or_huge() to
also cover pmd_huge() as long as enabled.

FOLL_TOUCH and FOLL_SPLIT_PMD only apply to THP, not yet huge.

Since now follow_trans_huge_pmd() can handle hugetlb pages, renaming it
into follow_huge_pmd() to match what it does.

When at it, move the ctx->page_mask setup into follow_huge_pmd(), only set
it when the page is valid.  It was not a bug to set it before even if GUP
failed (page==NULL), because follow_page_mask() callers always ignores
page_mask if so.  But doing so makes the code cleaner.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c         | 12 ++++++------
 mm/huge_memory.c | 19 ++++++++++---------
 mm/internal.h    |  6 +++---
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 55a2ae55f00f..7c210206470f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -713,31 +713,31 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		return page;
 	}
-	if (likely(!pmd_trans_huge(pmdval)))
+	if (likely(!pmd_thp_or_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
 	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
 		return no_page_table(vma, flags, address);
 
 	ptl = pmd_lock(mm, pmd);
-	if (unlikely(!pmd_present(*pmd))) {
+	pmdval = *pmd;
+	if (unlikely(!pmd_present(pmdval))) {
 		spin_unlock(ptl);
 		return no_page_table(vma, flags, address);
 	}
-	if (unlikely(!pmd_trans_huge(*pmd))) {
+	if (unlikely(!pmd_thp_or_huge(pmdval))) {
 		spin_unlock(ptl);
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
-	if (flags & FOLL_SPLIT_PMD) {
+	if (pmd_trans_huge(pmdval) && (flags & FOLL_SPLIT_PMD)) {
 		spin_unlock(ptl);
 		split_huge_pmd(vma, pmd, address);
 		/* If pmd was left empty, stuff a page table in there quickly */
 		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
 			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
-	page = follow_trans_huge_pmd(vma, address, pmd, flags);
+	page = follow_huge_pmd(vma, address, pmd, flags, ctx);
 	spin_unlock(ptl);
-	ctx->page_mask = HPAGE_PMD_NR - 1;
 	return page;
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6748ef5f3fd9..43fb81218c5e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1486,32 +1486,32 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 	return !userfaultfd_huge_pmd_wp(vma, pmd);
 }
 
-struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
-				   unsigned long addr,
-				   pmd_t *pmd,
-				   unsigned int flags)
+struct page *follow_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
+			     pmd_t *pmd, unsigned int flags,
+			     struct follow_page_context *ctx)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	pmd_t pmdval = *pmd;
 	struct page *page;
 	int ret;
 
 	assert_spin_locked(pmd_lockptr(mm, pmd));
 
-	page = pmd_page(*pmd);
+	page = pmd_page(pmdval);
 	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
 
 	if ((flags & FOLL_WRITE) &&
-	    !can_follow_write_pmd(*pmd, page, vma, flags))
+	    !can_follow_write_pmd(pmdval, page, vma, flags))
 		return NULL;
 
 	/* Avoid dumping huge zero page */
-	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
+	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(pmdval))
 		return ERR_PTR(-EFAULT);
 
 	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
 		return NULL;
 
-	if (!pmd_write(*pmd) && gup_must_unshare(vma, flags, page))
+	if (!pmd_write(pmdval) && gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
@@ -1521,10 +1521,11 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (flags & FOLL_TOUCH)
+	if (pmd_trans_huge(pmdval) && (flags & FOLL_TOUCH))
 		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
 
 	page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
+	ctx->page_mask = HPAGE_PMD_NR - 1;
 	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
 
 	return page;
diff --git a/mm/internal.h b/mm/internal.h
index 8450562744cf..bf0dc896c274 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1007,9 +1007,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags);
 /*
  * mm/huge_memory.c
  */
-struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
-				   unsigned long addr, pmd_t *pmd,
-				   unsigned int flags);
+struct page *follow_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
+			     pmd_t *pmd, unsigned int flags,
+			     struct follow_page_context *ctx);
 
 /*
  * mm/mmap.c
-- 
2.41.0

