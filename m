Return-Path: <linux-kernel+bounces-164914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAE38B84D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADEF1C22611
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E843AD9;
	Wed,  1 May 2024 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOqTeFp/"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6B433D5
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537642; cv=none; b=X4UNz9JCZ+GRRZ0O4IjAp8nG4EZBLJazCQ3YjPl1/dTFOzZDwYURIM8noKEeJSj6FeQzb/FUgZoz36Nne2Lqv96ULmZe21yuT2CQoObr7DqWuLJpazDUwmQS1bHV3co6IW4IaqwJp/O9plWIKTHUOJn8f27OMOwEF3X33RCMylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537642; c=relaxed/simple;
	bh=uV2/14QUugpYgH1LYX0hwV/yJj37Hyi7gXmkQUiVLdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RjZKIHt1H+SeWY6EuZ1/UNZn7nlH5sKb0MV07ikhU8QZQXFCvVm2WQyHn43XkYLgFj+HWyWPPlXgfCe6SPOqDHjvS1Mpp2W3bcczOvWlY7mwV/05s51vizDKG99x3ZMd/mJAPdXQAA+B3eCOSjuyp3HezzW0LM8lkMDkx6vt3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOqTeFp/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso366943b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537640; x=1715142440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROFqZ6lfkIoUlwY4du6p7l8Lb0MkeIYOr3uqszlhzvk=;
        b=SOqTeFp/DHlvDeGUEzwOznd9SXymQehtJab0fVQJ+LthkK/EGpsdl3QiiIELqeUxg6
         PfpNegWgldBzc6Trj/4pAN10dmbtXZoA+HG6wwldafX1eVruybiylFAv4a85eKyu3UEx
         SVr0UGxIkc0Xp67WxK5kakl0qyRh+iwY5KiSJo6yhh0t77vGkMTvco3QavB3wgG1OZWq
         Q94bGtFk/qHl2izXNePihycDJndJtBdMnOFIozGCPd1ZRjjzB03nFD91Be3bNKI/46iw
         LuEUiiZ/MhdOku2v7asnNrN5VtVxdCrwvMXbGHFHUdOzgGoqhMh5uf16I7ReuW2rLd4g
         T4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537640; x=1715142440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROFqZ6lfkIoUlwY4du6p7l8Lb0MkeIYOr3uqszlhzvk=;
        b=Bd6UdYW30Hz6WXh9jryYDP6uV2N0ned/3jxDgH8SI6y3VBrg18/82oBQfV6VT0UkMM
         lP63EQGsrGiXRrxP2g9tqCA/bHg9zG3aFGE9aOQt7UFWWTze34UtgXZR/WvXmJr1AZI9
         bkCXOfOkWAdx7anCiVs0UylI7PRY8aln9bUUDDF722BulzUMjNPgeUrmmb4aQJXAJGCc
         qTmIZpEhzDUFARg1LcB2cQPjwYprrSGBqiTjaDFfh+WuywZQ8fSdOAkPnr1SNFbqJhjq
         sT26LlGfA4AQ47e0qmREeQbEhI5qNIxY24W8rWVd8bAFCWL2OJxeWpVJhisWqYMgCGzm
         9HZw==
X-Forwarded-Encrypted: i=1; AJvYcCVt4g210taKe57HWiQfL+c8tWj97FRMOKp2+KYMOOoWu5Yvxe9MFOIgP/9GdOi6xFyDciKMFHiJajedoUAYXUEVwMUVlwUNqHbMh8S3
X-Gm-Message-State: AOJu0Yx5BxF5AWe5LHHI32x7Ar3+zW5C0Iai2SnT46lIIxRCO3ibjmaw
	nwOeCDFO1Jf+Yk2RauhDGGJJBIBIolSjBEWETpRYsIoZjEEbrmu9
X-Google-Smtp-Source: AGHT+IF2W0eVQxBQaMDY8AWoFZ/AvARxWOBrEttWhO+PAqpgYqb/8VwaVvuvijythAV5TvB4SnJUzQ==
X-Received: by 2002:a05:6a20:431a:b0:1ad:4978:adf4 with SMTP id h26-20020a056a20431a00b001ad4978adf4mr7731975pzk.1.1714537640184;
        Tue, 30 Apr 2024 21:27:20 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id m15-20020a656a0f000000b005dc4806ad7dsm19165970pgu.40.2024.04.30.21.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:27:19 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
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
Subject: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
Date: Wed,  1 May 2024 12:26:59 +0800
Message-Id: <20240501042700.83974-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240501042700.83974-1-ioworker0@gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
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
 include/linux/huge_mm.h | 20 ++++++++++++++++++++
 mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
 mm/rmap.c               | 24 +++++++++++++++++------
 3 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c8d3ec116e29..38c4b5537715 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -409,6 +409,20 @@ static inline bool thp_migration_supported(void)
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
 }
 
+void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
+			   pmd_t *pmd, bool freeze, struct folio *folio);
+
+static inline void align_huge_pmd_range(struct vm_area_struct *vma,
+					unsigned long *start,
+					unsigned long *end)
+{
+	*start = ALIGN(*start, HPAGE_PMD_SIZE);
+	*end = ALIGN_DOWN(*end, HPAGE_PMD_SIZE);
+
+	VM_WARN_ON_ONCE(vma->vm_start > *start);
+	VM_WARN_ON_ONCE(vma->vm_end < *end);
+}
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline bool folio_test_pmd_mappable(struct folio *folio)
@@ -471,6 +485,12 @@ static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio) {}
 static inline void split_huge_pmd_address(struct vm_area_struct *vma,
 		unsigned long address, bool freeze, struct folio *folio) {}
+static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
+					 unsigned long address, pmd_t *pmd,
+					 bool freeze, struct folio *folio) {}
+static inline void align_huge_pmd_range(struct vm_area_struct *vma,
+					unsigned long *start,
+					unsigned long *end) {}
 
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
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
index 7e2575d669a9..432601154583 100644
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
@@ -1650,6 +1647,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	range.end = vma_address_end(&pvmw);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address, range.end);
+	if (flags & TTU_SPLIT_HUGE_PMD)
+		align_huge_pmd_range(vma, &range.start, &range.end);
 	if (folio_test_hugetlb(folio)) {
 		/*
 		 * If sharing is possible, start and end will be adjusted
@@ -1664,9 +1663,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
-		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
-
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */
@@ -1678,6 +1674,22 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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


