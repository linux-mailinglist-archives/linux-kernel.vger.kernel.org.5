Return-Path: <linux-kernel+bounces-162359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F5A8B59C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FF71C23629
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19170CCC;
	Mon, 29 Apr 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbSIcn9h"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844BF74400
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397013; cv=none; b=Wfu2X1mVsr7wB8PL3+cc8sucdUmR87MLTorrw1KZ0eFIwF7Q4TmHiOLFqtsMusFIdsBBDS9uc+KNr4FR1+cXgGglE9vcvQWjDbpJqRMUUMZCFSIXkt74WKOKHrW8V2YegqDqyqQNLpxMvagXUbUCuxp2zTh9DEFn1C8veBtHO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397013; c=relaxed/simple;
	bh=FQCe99Zmgdkp5da6xqXiTmyqRI6xYcw8mcbKi9jVijE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0rd0Ke/qufb3s3rR2lSUIqg4NpeSunTuYQj8elAA8KFnrVx6WBQaKwfn9N//fUUf1geV/XrIiVbCgiT1KmWc6ZDPSAt44ewxZnGCHFEgztMrVPtJ8LTQfUj5cu0Z/ZGI96w02cWP227tlfitVlncvXLBZBOcSfrSM7e5tpwieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbSIcn9h; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2446652a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714397011; x=1715001811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0uX1PNQF5MmTPU2a0E5f9o7BDyWnY3Y+gAjJZ1Yc8M=;
        b=KbSIcn9hVJI+thCSGJ1+iXBByTQbFlYNORO7et38mSwiGlbnfmuEWqalKplypBDnaK
         TC7NJDrvtMBTey9vc/bZd3vxS3ndBC/IJCZjsXwXS/csdaf0+ufPlNxrEY8zDute+Bsn
         KNaTMzWPHj9QpWHjqfzmm+XGGPtRZaRqS7cztJB6iTDQICIPwQYnID0c+0UioPKl/0Yw
         oBD7Cc12cGa0gZcIOP9kpRnzxuPKrIaOi8fttZuzN+h8tQ1/EoWCMHHkBvkK3bxI4xme
         MxvJjq7UnzPFyKmXq49wtjIpbgK0s30fzjAKFvMRXckLJZdqJ4uv3Nr2ll9TtvANRBkn
         C7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397011; x=1715001811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0uX1PNQF5MmTPU2a0E5f9o7BDyWnY3Y+gAjJZ1Yc8M=;
        b=UhK4qSeyF/tAGUhFjGmqsRoj6k8bFGzNWTgqEr2+5/uOBM58iwk2GdUSBwZVC7WSt7
         Mq14rIH/+wTzDzQT3dwaB82Ue1DARCNt7whFvUh+/d4A92D/DFvLikZqbFgYgtDj6iF3
         QtckVHz7iY2+URF++I2dgSZEdI+p4upuz4jquIo0BsUlJyDc3SwyyWBuERNOSUiwODso
         fXVbBiuB94Pe/SdhLfNr/M2JctHqa5KdYbwOCVQBlTj/+2hXGw7u+Hk+Jz+UiEonXamU
         P+EBcJTx3X7U9YJ5yP7TgB6kmmr+hjLW1h+XNlxo9UqAajR30yXIK9xiEzFmULCxX3ZR
         ykew==
X-Forwarded-Encrypted: i=1; AJvYcCUS14NZwjCXCtESgWhzGVvTgW/BAk6WedA4O5EXqX9nIVaei/sEzkZ2RgcUfxTc597r45KpiQfpY8/hQZBdb2/EGH1AWfxa+ysmNfRS
X-Gm-Message-State: AOJu0YyGec40t4QTVapTSm5otOQTqz++glvkl3jbNr9APDplJZNzIKmD
	J/0ewwWy5JWtyIkdyW9W6iS5PSeW+UFvXfTEHp+FPiIxORpjXM3/
X-Google-Smtp-Source: AGHT+IH00XT4RfnkbDwUikAke+mh2nPnvqKZSzC4cJaeYd/fumPPlELDwUFfWyS2bd6+sld6pIyFMg==
X-Received: by 2002:a17:90b:4387:b0:2af:e1f8:11a4 with SMTP id in7-20020a17090b438700b002afe1f811a4mr8642414pjb.19.1714397010666;
        Mon, 29 Apr 2024 06:23:30 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id pa5-20020a17090b264500b002b113ad5f10sm3562203pjb.12.2024.04.29.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:23:30 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v3 2/3] mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
Date: Mon, 29 Apr 2024 21:23:07 +0800
Message-Id: <20240429132308.38794-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240429132308.38794-1-ioworker0@gmail.com>
References: <20240429132308.38794-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
folios, start the pagewalk first, then call split_huge_pmd_address()
to split the folio.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  2 ++
 mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
 mm/rmap.c               | 26 +++++++++++++++++++------
 3 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c8d3ec116e29..2daadfcc6776 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -36,6 +36,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
+void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
+			   pmd_t *pmd, bool freeze, struct folio *folio);
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8261b5669397..145505a1dd05 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2584,6 +2584,27 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	pmd_populate(mm, pmd, pgtable);
 }
 
+void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
+			   pmd_t *pmd, bool freeze, struct folio *folio)
+{
+	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
+	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
+	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
+	VM_BUG_ON(freeze && !folio);
+
+	/*
+	 * When the caller requests to set up a migration entry, we
+	 * require a folio to check the PMD against. Otherwise, there
+	 * is a risk of replacing the wrong folio.
+	 */
+	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
+	    is_pmd_migration_entry(*pmd)) {
+		if (folio && folio != pmd_folio(*pmd))
+			return;
+		__split_huge_pmd_locked(vma, pmd, address, freeze);
+	}
+}
+
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio)
 {
@@ -2595,26 +2616,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pmd_lock(vma->vm_mm, pmd);
-
-	/*
-	 * If caller asks to setup a migration entry, we need a folio to check
-	 * pmd against. Otherwise we can end up replacing wrong folio.
-	 */
-	VM_BUG_ON(freeze && !folio);
-	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
-
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
-		/*
-		 * It's safe to call pmd_page when folio is set because it's
-		 * guaranteed that pmd is present.
-		 */
-		if (folio && folio != pmd_folio(*pmd))
-			goto out;
-		__split_huge_pmd_locked(vma, pmd, range.start, freeze);
-	}
-
-out:
+	split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 7e2575d669a9..e42f436c7ff3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	if (flags & TTU_SYNC)
 		pvmw.flags = PVMW_SYNC;
 
-	if (flags & TTU_SPLIT_HUGE_PMD)
-		split_huge_pmd_address(vma, address, false, folio);
-
 	/*
 	 * For THP, we have to assume the worse case ie pmd for invalidation.
 	 * For hugetlb, it could be much worse if we need to do pud
@@ -1650,6 +1647,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	range.end = vma_address_end(&pvmw);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address, range.end);
+	if (flags & TTU_SPLIT_HUGE_PMD) {
+		range.start = address & HPAGE_PMD_MASK;
+		range.end = (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
+	}
 	if (folio_test_hugetlb(folio)) {
 		/*
 		 * If sharing is possible, start and end will be adjusted
@@ -1664,9 +1665,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
-		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
-
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */
@@ -1678,6 +1676,22 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			goto walk_done_err;
 		}
 
+		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
+			/*
+			 * We temporarily have to drop the PTL and start once
+			 * again from that now-PTE-mapped page table.
+			 */
+			split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
+					      folio);
+			pvmw.pmd = NULL;
+			spin_unlock(pvmw.ptl);
+			flags &= ~TTU_SPLIT_HUGE_PMD;
+			continue;
+		}
+
+		/* Unexpected PMD-mapped THP? */
+		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
+
 		pfn = pte_pfn(ptep_get(pvmw.pte));
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
-- 
2.33.1


