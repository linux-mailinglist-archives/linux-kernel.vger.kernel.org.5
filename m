Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601737ED8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbjKPBaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbjKPB3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F9B1730
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltEuMSvLIUou1PxvqED3QFklmTWz+odfLbJoVHfc4cY=;
        b=dwaBAIPJz8s/GuNVAuAOY6anN5K7DDxzyrHzDfGhoPOPlsN9BgnA/xC+sClGscAgVsJubc
        zjaBYCukv2BVOYDg12/ecd7HzXoqlSVyPi49UxsC7LSEr+JzCWhg6DOt8LsunoexMqHmZY
        Nlha1nX3SNtBs5Rg3cyH5PMUUNW3Yvg=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-0vpsEUi9ObuiQU58p1qRsg-1; Wed, 15 Nov 2023 20:29:30 -0500
X-MC-Unique: 0vpsEUi9ObuiQU58p1qRsg-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-46107bc7936so12677137.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098169; x=1700702969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltEuMSvLIUou1PxvqED3QFklmTWz+odfLbJoVHfc4cY=;
        b=cXhbHvZBlO3I+KA5cSlgRjcp2da8/VS/7PgSvMi64WHqV06HSZ+PxsF3jhobftjYR5
         WMidV0fdMrR5H7JlnbZ9cpfWrK797Q6bR479OEk+GQ21UcnHen7E48frq+qZMm9hdhA5
         zXi05er4mayNKpUFzEMpGUFDtbuIGQfCPdSCvwYaznF4GB/C29BYpg4jOx61lJUcbX5W
         NfLMQ8hD79sQd6w9zch7nmh0bkL+zVJpRatWgryE4WA5h27qLulLmfvepDYjzcvC5eyr
         8/9L+ki2Cvv6OtPxcZHOv9SH2dwnCiaYxilHmllnHwzwqTJYtr7csrji3xA/5kLEL82P
         VkKg==
X-Gm-Message-State: AOJu0YyOT0LtXmDOnvJmXT0P7DI+4ZTq4aHqT3feQybrsnMqImGAmTOB
        ECSVBcSSwUztTMsJnIc0mjktGDvNCu31oInccZMb5QTRZ85Kug2Gu+RBT5qQUkHHUfuj7i+pifG
        yHdI/UAlMVl7o8SoZ0rD3UZtBYx/VmReoo0ll4KD3Wfov/2WdmGy1d0i/lpGV3gs3eGeNuQLNth
        HCTaH3fg==
X-Received: by 2002:a1f:1f95:0:b0:4ac:3094:fc14 with SMTP id f143-20020a1f1f95000000b004ac3094fc14mr7205523vkf.1.1700098169418;
        Wed, 15 Nov 2023 17:29:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmlcK0wHn56i8+DaE6cZQcDPiXYda86sHdfw6XVjm04MvVaxCRJjJBn7Y0oU98rdXaw93h4g==
X-Received: by 2002:a1f:1f95:0:b0:4ac:3094:fc14 with SMTP id f143-20020a1f1f95000000b004ac3094fc14mr7205497vkf.1.1700098169016;
        Wed, 15 Nov 2023 17:29:29 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:28 -0800 (PST)
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
Subject: [PATCH RFC 11/12] mm/gup: Handle hugepd for follow_page()
Date:   Wed, 15 Nov 2023 20:29:07 -0500
Message-ID: <20231116012908.392077-12-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
References: <20231116012908.392077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugepd is only used in PowerPC's hugetlbfs.  follow_page_mask() used to
leverage hugetlb APIs to access hugepd entries.  Teach follow_page_mask()
itself on hugepd.

With previous refactors on fast-gup gup_huge_pd(), most of the code can be
easily leveraged.  Since follow_page() always only fetch one page, set the
end to "address + PAGE_SIZE" should suffice.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7c210206470f..e635278f65f9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -25,6 +25,11 @@
 
 #include "internal.h"
 
+static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+				  unsigned long addr, unsigned int pdshift,
+				  unsigned int flags,
+				  struct follow_page_context *ctx);
+
 static inline void sanity_check_pinned_pages(struct page **pages,
 					     unsigned long npages)
 {
@@ -713,6 +718,9 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		return page;
 	}
+	if (unlikely(is_hugepd(__hugepd(pmd_val(pmdval)))))
+		return follow_hugepd(vma, __hugepd(pmd_val(pmdval)),
+				     address, PMD_SHIFT, flags, ctx);
 	if (likely(!pmd_thp_or_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
@@ -764,6 +772,10 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	if (unlikely(pud_bad(pud)))
 		return no_page_table(vma, flags, address);
 
+	if (unlikely(is_hugepd(__hugepd(pud_val(pud)))))
+		return follow_hugepd(vma, __hugepd(pud_val(pud)),
+				     address, PUD_SHIFT, flags, ctx);
+
 	return follow_pmd_mask(vma, address, pudp, flags, ctx);
 }
 
@@ -772,15 +784,19 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 				    unsigned int flags,
 				    struct follow_page_context *ctx)
 {
-	p4d_t *p4d;
+	p4d_t *p4d, p4dval;
 
 	p4d = p4d_offset(pgdp, address);
-	if (p4d_none(*p4d))
-		return no_page_table(vma, flags, address);
-	BUILD_BUG_ON(p4d_huge(*p4d));
-	if (unlikely(p4d_bad(*p4d)))
+	p4dval = *p4d;
+	BUILD_BUG_ON(p4d_huge(p4dval));
+
+	if (p4d_none(p4dval) || unlikely(p4d_bad(p4dval)))
 		return no_page_table(vma, flags, address);
 
+	if (unlikely(is_hugepd(__hugepd(p4d_val(p4dval)))))
+		return follow_hugepd(vma, __hugepd(p4d_val(p4dval)),
+				     address, P4D_SHIFT, flags, ctx);
+
 	return follow_pud_mask(vma, address, p4d, flags, ctx);
 }
 
@@ -812,7 +828,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 			      unsigned long address, unsigned int flags,
 			      struct follow_page_context *ctx)
 {
-	pgd_t *pgd;
+	pgd_t *pgd, pgdval;
 	struct mm_struct *mm = vma->vm_mm;
 
 	ctx->page_mask = 0;
@@ -827,11 +843,17 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 						&ctx->page_mask);
 
 	pgd = pgd_offset(mm, address);
+	pgdval = *pgd;
 
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		return no_page_table(vma, flags, address);
+		page = no_page_table(vma, flags, address);
+	else if (unlikely(is_hugepd(__hugepd(pgd_val(pgdval)))))
+		page = follow_hugepd(vma, __hugepd(pgd_val(pgdval)),
+				     address, PGDIR_SHIFT, flags, ctx);
+	else
+		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
 
-	return follow_p4d_mask(vma, address, pgd, flags, ctx);
+	return page;
 }
 
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
@@ -2850,6 +2872,37 @@ static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 
 	return 1;
 }
+
+static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+				  unsigned long addr, unsigned int pdshift,
+				  unsigned int flags,
+				  struct follow_page_context *ctx)
+{
+	struct page *page;
+	struct hstate *h;
+	spinlock_t *ptl;
+	int nr = 0, ret;
+	pte_t *ptep;
+
+	/* Only hugetlb supports hugepd */
+	if (WARN_ON_ONCE(!is_vm_hugetlb_page(vma)))
+		return ERR_PTR(-EFAULT);
+
+	h = hstate_vma(vma);
+	ptep = hugepte_offset(hugepd, addr, pdshift);
+	ptl = huge_pte_lock(h, mm, ptep);
+	ret = gup_huge_pd(hugepd, addr, pdshift, addr + PAGE_SIZE,
+			  flags, &page, &nr)) {
+	spin_unlock(ptl);
+
+	if (ret) {
+		WARN_ON_ONCE(nr != 1);
+		ctx->page_mask = (1U << huge_page_order(h)) - 1;
+		return page;
+	}
+
+	return NULL;
+}
 #else
 static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 		unsigned int pdshift, unsigned long end, unsigned int flags,
@@ -2857,6 +2910,14 @@ static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 {
 	return 0;
 }
+
+static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+				  unsigned long addr, unsigned int pdshift,
+				  unsigned int flags,
+				  struct follow_page_context *ctx)
+{
+	return NULL;
+}
 #endif /* CONFIG_ARCH_HAS_HUGEPD */
 
 static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-- 
2.41.0

