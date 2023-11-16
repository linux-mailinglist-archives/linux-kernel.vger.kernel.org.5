Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5E27ED8E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbjKPB3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbjKPB3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1958D7A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQy6k5CEHGKiOJI0ugKFVUkk8XVFLkY9zLGCNjIpOps=;
        b=PZVOBA2p58yqfiE/MULqsB2VuOZGQf8ep3XJx0mTdt8jVTAi4AnNPGZA8q0SYITqXi6BFg
        UIsfqiv3j5KOMzTcQxOJITXqX8Ij6+ootSU6rKJ/V0PibKoF+X4tRwBk1bjohVRxMQMcJO
        T9c+TxtooIQ7qKwZNrcvmG95MpWmXwQ=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-Wi3vBIUJP7mdtOhBrVfTNw-1; Wed, 15 Nov 2023 20:29:27 -0500
X-MC-Unique: Wi3vBIUJP7mdtOhBrVfTNw-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4ac1cbd8a18so40423e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098166; x=1700702966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQy6k5CEHGKiOJI0ugKFVUkk8XVFLkY9zLGCNjIpOps=;
        b=A4FX+XrrRViz7svb6iS1cRp3L64oJML0O7rditnVL9rVCXrvi15YT94MsVJh4LyWBG
         BZHgVsyv9ylfFXWCAi976yHXiSOLawYuWpgvoaSPgC2qUGcscqAOsZYnMZEYPQLGXVND
         POYzSKKtsqXCwDNV0mofSLjqrMVnh+V9P7fMKf5EPELzEzPv15sJ/jA3X+GdvV1Ewy9Q
         FPEUcOsCUWjufevJ9i4z5L1imMCdyRNRLJ9V49/KRZR8g9ydHJdlRcSRSCAA1J9jobSx
         SqxS3Nk1TOY/mx+zuycBJCEChk1qk4QatGswPSeeMp31o2vTspWXZb1WPO6E0qRjRAOH
         wPuA==
X-Gm-Message-State: AOJu0YwZWwVmj6eQXxo7PVulQhCR5HS+HKYruy2FiI9NbyIBBZef/R2Y
        wellOQ5TOHB0WpR3Bh5CaWAFwSAolKgy1uYV5FJeczgjvAzy8dTegRfJIX5XkNAQZC+Udqu3jn7
        Yf5yVaNPxp0M28jL3efqlcMP815nqGipKQaXxHDB63773/aEVyMtqtbtQmQqeu/9ijPDcveEN1A
        VMBmdz6A==
X-Received: by 2002:a05:6122:1484:b0:4ab:f831:98d4 with SMTP id z4-20020a056122148400b004abf83198d4mr7555133vkp.0.1700098166387;
        Wed, 15 Nov 2023 17:29:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNrGR90/jKzfekxV/YscaCCcqT0aN5ZcRXVaKloa9cNGZ2HnRMduZYMn8+Y4FcR5oknUprWw==
X-Received: by 2002:a05:6122:1484:b0:4ab:f831:98d4 with SMTP id z4-20020a056122148400b004abf83198d4mr7555100vkp.0.1700098165901;
        Wed, 15 Nov 2023 17:29:25 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:25 -0800 (PST)
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
Subject: [PATCH RFC 09/12] mm/gup: Handle huge pud for follow_pud_mask()
Date:   Wed, 15 Nov 2023 20:29:05 -0500
Message-ID: <20231116012908.392077-10-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
References: <20231116012908.392077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach follow_pud_mask() to be able to handle normal PUD pages like hugetlb.

Rename follow_devmap_pud() to follow_huge_pud(), move it out of config
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD, instead let that macro only
covers the devmap special operations, like pgmap.

In the new follow_huge_pud(), taking care of possible CoR for hugetlb if
necessary.

Since at it, optimize the non-present check by adding a pud_present() early
check before taking the pgtable lock, failing the follow_page() early if
PUD is not present: that is required by both devmap or hugetlb.  Use
pud_huge() to also cover the pud_devmap() case.

We need to export "struct follow_page_context" along the way, so that
huge_memory.c can understand it.

One trivial more thing to mention is, introduce "pud_t pud" in the code
paths along the way, so the code doesn't dereference *pudp multiple time.
Not only because that looks less straightforward, but also because if the
dereference really happened, it's not clear whether there can be race to
see different *pudp values when it's being modified at the same time.

Setting ctx->page_mask properly for a PUD entry.  As a side effect, this
should also be able to optimize devmap GUP on PUD to be able to jump over
the whole PUD range, but not yet verified.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 17 +++----
 mm/gup.c                | 22 ++++-----
 mm/huge_memory.c        | 98 +++++++++++++++++++++++------------------
 3 files changed, 73 insertions(+), 64 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ec463410aecc..84815012d3cf 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -7,6 +7,11 @@
 
 #include <linux/fs.h> /* only for vma_is_dax() */
 
+struct follow_page_context {
+	struct dev_pagemap *pgmap;
+	unsigned int page_mask;
+};
+
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
@@ -222,8 +227,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
-struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap);
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
@@ -372,18 +375,16 @@ static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *follow_devmap_pud(struct vm_area_struct *vma,
-	unsigned long addr, pud_t *pud, int flags, struct dev_pagemap **pgmap)
-{
-	return NULL;
-}
-
 static inline bool thp_migration_supported(void)
 {
 	return false;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+struct page *follow_huge_pud(struct vm_area_struct *vma, unsigned long addr,
+			     pud_t *pud, int flags,
+			     struct follow_page_context *ctx);
+
 static inline int split_folio_to_list(struct folio *folio,
 		struct list_head *list)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 89c1584d68f0..55a2ae55f00f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -25,11 +25,6 @@
 
 #include "internal.h"
 
-struct follow_page_context {
-	struct dev_pagemap *pgmap;
-	unsigned int page_mask;
-};
-
 static inline void sanity_check_pinned_pages(struct page **pages,
 					     unsigned long npages)
 {
@@ -751,24 +746,25 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 				    unsigned int flags,
 				    struct follow_page_context *ctx)
 {
-	pud_t *pud;
+	pud_t *pudp, pud;
 	spinlock_t *ptl;
 	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
-	pud = pud_offset(p4dp, address);
-	if (pud_none(*pud))
+	pudp = pud_offset(p4dp, address);
+	pud = *pudp;
+	if (pud_none(pud) || !pud_present(pud))
 		return no_page_table(vma, flags, address);
-	if (pud_devmap(*pud)) {
-		ptl = pud_lock(mm, pud);
-		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
+	if (pud_huge(pud)) {
+		ptl = pud_lock(mm, pudp);
+		page = follow_huge_pud(vma, address, pudp, flags, ctx);
 		spin_unlock(ptl);
 		return page;
 	}
-	if (unlikely(pud_bad(*pud)))
+	if (unlikely(pud_bad(pud)))
 		return no_page_table(vma, flags, address);
 
-	return follow_pmd_mask(vma, address, pud, flags, ctx);
+	return follow_pmd_mask(vma, address, pudp, flags, ctx);
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6eb55f97a3d2..6748ef5f3fd9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1207,49 +1207,6 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pud(vma, addr, pud);
 }
 
-struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pud_pfn(*pud);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pud_lockptr(mm, pud));
-
-	if (flags & FOLL_WRITE && !pud_write(*pud))
-		return NULL;
-
-	if (pud_present(*pud) && pud_devmap(*pud))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pud(vma, addr, pud, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 *
-	 * At least one of FOLL_GET | FOLL_PIN must be set, so assert that here:
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-
-	ret = try_grab_page(page, flags);
-	if (ret)
-		page = ERR_PTR(ret);
-
-	return page;
-}
-
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
 		  struct vm_area_struct *vma)
@@ -1305,6 +1262,61 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
+struct page *follow_huge_pud(struct vm_area_struct *vma, unsigned long addr,
+			     pud_t *pudp, int flags,
+			     struct follow_page_context *ctx)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page;
+	pud_t pud = *pudp;
+	unsigned long pfn = pud_pfn(pud);
+	int ret;
+
+	assert_spin_locked(pud_lockptr(mm, pudp));
+
+	if ((flags & FOLL_WRITE) && !pud_write(pud))
+		return NULL;
+
+	if (!pud_present(pud))
+		return NULL;
+
+	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	if (pud_devmap(pud)) {
+		/*
+		 * device mapped pages can only be returned if the caller
+		 * will manage the page reference count.
+		 *
+		 * At least one of FOLL_GET | FOLL_PIN must be set, so
+		 * assert that here:
+		 */
+		if (!(flags & (FOLL_GET | FOLL_PIN)))
+			return ERR_PTR(-EEXIST);
+
+		if (flags & FOLL_TOUCH)
+			touch_pud(vma, addr, pudp, flags & FOLL_WRITE);
+
+		ctx->pgmap = get_dev_pagemap(pfn, ctx->pgmap);
+		if (!ctx->pgmap)
+			return ERR_PTR(-EFAULT);
+	}
+#endif
+	page = pfn_to_page(pfn);
+
+	if (!pud_devmap(pud) && !pud_write(pud) &&
+	    gup_must_unshare(vma, flags, page))
+		return ERR_PTR(-EMLINK);
+
+	ret = try_grab_page(page, flags);
+	if (ret)
+		page = ERR_PTR(ret);
+	else
+		ctx->page_mask = HPAGE_PUD_NR - 1;
+
+	return page;
+}
+
 void huge_pmd_set_accessed(struct vm_fault *vmf)
 {
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-- 
2.41.0

