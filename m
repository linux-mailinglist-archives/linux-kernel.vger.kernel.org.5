Return-Path: <linux-kernel+bounces-110736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D458862FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84871C21F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AF13848D;
	Thu, 21 Mar 2024 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSM2YzKC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBF8137C50
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058909; cv=none; b=Du04FJkmcl22zp1BtDr/vX3a3QLy4oAN1oYD60MO2WhP4u9E/Q62yC+xuku5qKKwH8mKCUx/0gp/9AG4ueb5ag055hFYIed2HQGF3rpP6r0IVFMgaAt6MydOsDUFYit95NXOVOlgVD5bM0XMJpb8ZYUMn5PjFYe0c4/uvKb944w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058909; c=relaxed/simple;
	bh=RitX2L5oxcTLCtcTacYVOZOKOLSZfotpY7TNTJ5lfcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxDnG39b9+IE+lWZ/Qc8LhMMvmqW47d2oJyw3sXc8rSpAlcCQ6sB30XOiIG7hfOFMsSe1FJcrCzvw12rrnUfL8qA1Q0VphgdGR42yw31mtRDFqMwo45aonE+NWm+ZoSOBmuljgxGXm0Y96chrto4zO05nu7GQE+JLA1kQnsMtFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSM2YzKC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESTHlGxPxGuUFdX3p2oamk2h4NMABnT27/X9cpNES3o=;
	b=OSM2YzKCNPNlfe/VmpZ0tOdwRfLd1ZrNp5PsgerlKc5zR0F6kNg5tqqY2fZAMHKOQUGAhY
	4SEQJYLoj3yJei/RgWSdkFW3vC/1srbfe+1FgQ3o3x5a1/VAa8yaD/OHI5LrPwronkdDka
	6HfjrEPgi7fRJd6pISVH6s/A7uCsxLs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-6zbDKf4rN3SMCOr3RtVMMg-1; Thu, 21 Mar 2024 18:08:25 -0400
X-MC-Unique: 6zbDKf4rN3SMCOr3RtVMMg-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6e67ee38ce7so413867a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058905; x=1711663705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESTHlGxPxGuUFdX3p2oamk2h4NMABnT27/X9cpNES3o=;
        b=lKCITpALbsCC6RTzN3KlCGPoyX4y+s0cCU+iUF7jtTy7WY8qz94uScuAwANMl3e621
         Lt0H2yJbYGOuyNtRjBZzKHgWJShHK83NvyvWP3P4sbnGZ+deAoEr9dowOmDvD+IVueN3
         2CNfj8Xxj1nAIAJ5bsOEtEnj3sG/q/R0eJ2nxAQH2Cqb7+GbcGfpXYJTAaUjaUIz1xDC
         4+tz7tp7EajB+0bxDztqt33GJwaSmV+XbZWZGQPsw0xNt9sgmrD20YGwlEGALtyNNgI7
         yCHJJLlJFPp9jVU2FpSjqdM4THqGpAuXPs9wFFF25FJTJNVu/HThwxu4CHXYlDXfgLGQ
         +egw==
X-Forwarded-Encrypted: i=1; AJvYcCUdyXDb3PCK3un150KmXQLcrQokBQijr81EbAI+xl+cT29h+qPkqCSiwSfZhtzXHTbEHwDb9FR1I4g9WO8smzOYyT24P42D95IbtXK9
X-Gm-Message-State: AOJu0YwHvIVMtPfC5IhF8eaLohm06IE/IaVPC1ZO0fODoRfoKGhLAHLE
	A1SV6dnAO6Fb44t3cL/hRN84De0BL1zAQ+eiTz52HV3/QVYepiAeWqWUPzloivzDhW56ztAc9FK
	uxSKLeWmwWZthMJ6KIwajoAKPjLZzzic2ARv+O9ZDQMmzflyfB4RMtPRoWFUpwg==
X-Received: by 2002:a4a:ca85:0:b0:5a5:1645:90f4 with SMTP id x5-20020a4aca85000000b005a5164590f4mr622764ooq.1.1711058904602;
        Thu, 21 Mar 2024 15:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4H/bBBZLy/REcdrgCXmaDlClCIl1Ey/SRhhRBkoU7cfytCZoQGoym/o3YpdiOnUWtv8D4UQ==
X-Received: by 2002:a4a:ca85:0:b0:5a5:1645:90f4 with SMTP id x5-20020a4aca85000000b005a5164590f4mr622720ooq.1.1711058904123;
        Thu, 21 Mar 2024 15:08:24 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:23 -0700 (PDT)
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
Subject: [PATCH v3 10/12] mm/gup: Handle huge pmd for follow_pmd_mask()
Date: Thu, 21 Mar 2024 18:08:00 -0400
Message-ID: <20240321220802.679544-11-peterx@redhat.com>
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

Replace pmd_trans_huge() with pmd_leaf() to also cover pmd_huge() as long
as enabled.

FOLL_TOUCH and FOLL_SPLIT_PMD only apply to THP, not yet huge.

Since now follow_trans_huge_pmd() can process hugetlb pages, renaming it
into follow_huge_pmd() to match what it does.  Move it into gup.c so not
depend on CONFIG_THP.

When at it, move the ctx->page_mask setup into follow_huge_pmd(), only set
it when the page is valid.  It was not a bug to set it before even if GUP
failed (page==NULL), because follow_page_mask() callers always ignores
page_mask if so.  But doing so makes the code cleaner.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c         | 107 ++++++++++++++++++++++++++++++++++++++++++++---
 mm/huge_memory.c |  86 +------------------------------------
 mm/internal.h    |   5 +--
 3 files changed, 105 insertions(+), 93 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ae21afb9434e..00cdf4cb0cd4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -580,6 +580,93 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 
 	return page;
 }
+
+/* FOLL_FORCE can write to even unwritable PMDs in COW mappings. */
+static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
+					struct vm_area_struct *vma,
+					unsigned int flags)
+{
+	/* If the pmd is writable, we can write to the page. */
+	if (pmd_write(pmd))
+		return true;
+
+	/* Maybe FOLL_FORCE is set to override it? */
+	if (!(flags & FOLL_FORCE))
+		return false;
+
+	/* But FOLL_FORCE has no effect on shared mappings */
+	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
+		return false;
+
+	/* ... or read-only private ones */
+	if (!(vma->vm_flags & VM_MAYWRITE))
+		return false;
+
+	/* ... or already writable ones that just need to take a write fault */
+	if (vma->vm_flags & VM_WRITE)
+		return false;
+
+	/*
+	 * See can_change_pte_writable(): we broke COW and could map the page
+	 * writable if we have an exclusive anonymous page ...
+	 */
+	if (!page || !PageAnon(page) || !PageAnonExclusive(page))
+		return false;
+
+	/* ... and a write-fault isn't required for other reasons. */
+	if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
+		return false;
+	return !userfaultfd_huge_pmd_wp(vma, pmd);
+}
+
+static struct page *follow_huge_pmd(struct vm_area_struct *vma,
+				    unsigned long addr, pmd_t *pmd,
+				    unsigned int flags,
+				    struct follow_page_context *ctx)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t pmdval = *pmd;
+	struct page *page;
+	int ret;
+
+	assert_spin_locked(pmd_lockptr(mm, pmd));
+
+	page = pmd_page(pmdval);
+	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
+
+	if ((flags & FOLL_WRITE) &&
+	    !can_follow_write_pmd(pmdval, page, vma, flags))
+		return NULL;
+
+	/* Avoid dumping huge zero page */
+	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(pmdval))
+		return ERR_PTR(-EFAULT);
+
+	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
+		return NULL;
+
+	if (!pmd_write(pmdval) && gup_must_unshare(vma, flags, page))
+		return ERR_PTR(-EMLINK);
+
+	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+			!PageAnonExclusive(page), page);
+
+	ret = try_grab_page(page, flags);
+	if (ret)
+		return ERR_PTR(ret);
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (pmd_trans_huge(pmdval) && (flags & FOLL_TOUCH))
+		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
+#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
+
+	page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
+	ctx->page_mask = HPAGE_PMD_NR - 1;
+	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
+
+	return page;
+}
+
 #else  /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 static struct page *follow_huge_pud(struct vm_area_struct *vma,
 				    unsigned long addr, pud_t *pudp,
@@ -587,6 +674,14 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 {
 	return NULL;
 }
+
+static struct page *follow_huge_pmd(struct vm_area_struct *vma,
+				    unsigned long addr, pmd_t *pmd,
+				    unsigned int flags,
+				    struct follow_page_context *ctx)
+{
+	return NULL;
+}
 #endif	/* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 
 static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
@@ -784,31 +879,31 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 			return page;
 		return no_page_table(vma, flags, address);
 	}
-	if (likely(!pmd_trans_huge(pmdval)))
+	if (likely(!pmd_leaf(pmdval)))
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
+	if (unlikely(!pmd_leaf(pmdval))) {
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
index f8bd2012bc27..e747dacb5051 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1206,8 +1206,8 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
-static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
-		      pmd_t *pmd, bool write)
+void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
+	       pmd_t *pmd, bool write)
 {
 	pmd_t _pmd;
 
@@ -1562,88 +1562,6 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 	return pmd_dirty(pmd);
 }
 
-/* FOLL_FORCE can write to even unwritable PMDs in COW mappings. */
-static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
-					struct vm_area_struct *vma,
-					unsigned int flags)
-{
-	/* If the pmd is writable, we can write to the page. */
-	if (pmd_write(pmd))
-		return true;
-
-	/* Maybe FOLL_FORCE is set to override it? */
-	if (!(flags & FOLL_FORCE))
-		return false;
-
-	/* But FOLL_FORCE has no effect on shared mappings */
-	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
-		return false;
-
-	/* ... or read-only private ones */
-	if (!(vma->vm_flags & VM_MAYWRITE))
-		return false;
-
-	/* ... or already writable ones that just need to take a write fault */
-	if (vma->vm_flags & VM_WRITE)
-		return false;
-
-	/*
-	 * See can_change_pte_writable(): we broke COW and could map the page
-	 * writable if we have an exclusive anonymous page ...
-	 */
-	if (!page || !PageAnon(page) || !PageAnonExclusive(page))
-		return false;
-
-	/* ... and a write-fault isn't required for other reasons. */
-	if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
-		return false;
-	return !userfaultfd_huge_pmd_wp(vma, pmd);
-}
-
-struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
-				   unsigned long addr,
-				   pmd_t *pmd,
-				   unsigned int flags)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pmd_lockptr(mm, pmd));
-
-	page = pmd_page(*pmd);
-	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
-
-	if ((flags & FOLL_WRITE) &&
-	    !can_follow_write_pmd(*pmd, page, vma, flags))
-		return NULL;
-
-	/* Avoid dumping huge zero page */
-	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
-		return ERR_PTR(-EFAULT);
-
-	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
-		return NULL;
-
-	if (!pmd_write(*pmd) && gup_must_unshare(vma, flags, page))
-		return ERR_PTR(-EMLINK);
-
-	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
-			!PageAnonExclusive(page), page);
-
-	ret = try_grab_page(page, flags);
-	if (ret)
-		return ERR_PTR(ret);
-
-	if (flags & FOLL_TOUCH)
-		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
-
-	page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
-	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
-
-	return page;
-}
-
 /* NUMA hinting page fault entry point for trans huge pmds */
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 63e4f6e001be..d47862e6d968 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1104,9 +1104,8 @@ int __must_check try_grab_page(struct page *page, unsigned int flags);
  */
 void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 	       pud_t *pud, bool write);
-struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
-				   unsigned long addr, pmd_t *pmd,
-				   unsigned int flags);
+void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
+	       pmd_t *pmd, bool write);
 
 #ifdef CONFIG_MEMCG
 static inline
-- 
2.44.0


