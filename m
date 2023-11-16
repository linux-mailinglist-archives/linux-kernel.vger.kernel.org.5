Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5F7ED8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbjKPB36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344331AbjKPB3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524AD4B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxqjSAwi8aTfo4zdaLYLd0e+DlQCcl09BvXUJR2cui0=;
        b=hIEgXfZbAOrqX4z98mch3jAAm23q23QDu+Aq8lyd13NZEJ1Q/SibbZQC3gXtWRm/FQbSMB
        xqmAClvuvk3/eymMzQ0fxsWnX8gZvPi54cKIiivOGHf+8M/beQQ9/vefR/Y23u9DdtsgKy
        X2J5mvgDswmKAX3LEEuKra+DpbDCeLM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-c5saubBzPJWJI-o4qu_cBQ-1; Wed, 15 Nov 2023 20:29:26 -0500
X-MC-Unique: c5saubBzPJWJI-o4qu_cBQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77a02ceef95so2904185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098165; x=1700702965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxqjSAwi8aTfo4zdaLYLd0e+DlQCcl09BvXUJR2cui0=;
        b=ANwI1CkwDUj98nrauz5703pYnACz6tz/f14E7bzSKJJUkOI+Xlkqs37rZGcaGlg1nu
         9yfToxOmMgDqjyEAsUELKbwT71XENoYOX63zoiSRrePmL//irgZmGrTQcmBdTa//qwTG
         zll3ly+5uTcbpNYRSTvoyQf6v8itw19kUw/zNra6x/wGBm30ceF+ZPee017oMFwXhN5m
         8Fh1XkG6R0d7o3uc3yJL0+kdm+C/CrkeST8FR3GRARpZGO1DYfFumjge/adBmXwQkLKw
         rJBue0H7yyneT2wyoDb/n1b1hIurNaQGTMmSoxgAT9CB9SGUQcsJMGWEqIryPKJclOJ2
         zDHA==
X-Gm-Message-State: AOJu0Yxu16moxEGh2N3tVTzc0Fpydzdo6RdQVkZkMQJ2WMIvtkteNn+2
        r13KyY+KSO5wEeJNPsy3cHtIQaTIICs6hlJ6JzWvFjSXjS/2YQE179CttWUx1KiVeBQKc1SDkAC
        IkW0Lz0QMaoJ6pzt0dYcgcdu7ThFznbIeicQApy40h7V9kdxFnxHks0CGreg0sE0iz1s4GqeUNz
        LdEXnrUg==
X-Received: by 2002:a05:622a:4291:b0:41c:d528:6589 with SMTP id cr17-20020a05622a429100b0041cd5286589mr8639226qtb.4.1700098164758;
        Wed, 15 Nov 2023 17:29:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJwc+nHfVii0rwj2VF/0wkfwbvSOBYLSzNseCq1M0oxHWvF5z7fbEvQHxGk1DiYrhq4t4KkQ==
X-Received: by 2002:a05:622a:4291:b0:41c:d528:6589 with SMTP id cr17-20020a05622a429100b0041cd5286589mr8639189qtb.4.1700098164258;
        Wed, 15 Nov 2023 17:29:24 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:23 -0800 (PST)
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
Subject: [PATCH RFC 08/12] mm/gup: Handle hugetlb for no_page_table()
Date:   Wed, 15 Nov 2023 20:29:04 -0500
Message-ID: <20231116012908.392077-9-peterx@redhat.com>
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

no_page_table() is not yet used for hugetlb code paths. Make it prepared.

The major difference here is hugetlb will return -EFAULT as long as page
cache does not exist, even if VM_SHARED.  See hugetlb_follow_page_mask().

Pass "address" into no_page_table() too, as hugetlb will need it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 69dae51f3eb1..89c1584d68f0 100644
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
@@ -701,9 +709,9 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
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
@@ -714,12 +722,12 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
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
@@ -750,7 +758,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 
 	pud = pud_offset(p4dp, address);
 	if (pud_none(*pud))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 	if (pud_devmap(*pud)) {
 		ptl = pud_lock(mm, pud);
 		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
@@ -758,7 +766,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 		return page;
 	}
 	if (unlikely(pud_bad(*pud)))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 
 	return follow_pmd_mask(vma, address, pud, flags, ctx);
 }
@@ -772,10 +780,10 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 
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
@@ -825,7 +833,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	pgd = pgd_offset(mm, address);
 
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		return no_page_table(vma, flags);
+		return no_page_table(vma, flags, address);
 
 	return follow_p4d_mask(vma, address, pgd, flags, ctx);
 }
-- 
2.41.0

