Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C897CE906
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjJRUd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjJRUdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:33:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6734115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ca74e77aecso606935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697661191; x=1698265991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcNlnHmZuXPr4rVPOwy7uUYyAYPeSLuYyJXFxeMfebs=;
        b=IOxHLuPUMNnOYZ0BYOAEsZwUbKBYATaTxCgnaTOKcUkgKI5TqyKoswj9MfHu9TzKlc
         mJcOHpLBnR0zXcjKExY26NhIZfqCm/CXr/rLYvfVdHIiOt4tXV3du3x8yntJUYUrYhrN
         QL/1nr2bNIyFScdthvE1RdO9XZR3g3UqK+TOvL+136/3rCmFLD8Yc9OMQC2tDaHvHhMW
         zFeGJyM42r0fFhyJcDE0P2aBh4iumaOyt4g8A/k+A8IQjkjtbdle7lbrl4aDeu/hDcJ5
         oj7Q4n51T15ipLl6uqJMJNOBP+tGoaYAHTkRjhjT4uOtteaBq9UjQ870Af0X2hEXnPVa
         W1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661191; x=1698265991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcNlnHmZuXPr4rVPOwy7uUYyAYPeSLuYyJXFxeMfebs=;
        b=REFBmIADc9NEZhOs3xyOm9cKfMuLxWGYWu7nRf+TmJiC/TFFARCck58MK0IejIgrsP
         BHQLvOmLmKYx0g0184+yYoJYKIr65wL9rmcyvv2p1yNiWYDNhfOQUMkJAwIbD5/aHOAR
         hSq1wIOO77G26L3F4eYkuWvf6XWeSq2MtOWLppJUIj40BEOOcrVjRzIiwlv6jFZ4SYG9
         cIDsfqBjwhpZy3Qex6/qSQVbsROlVKOv7Fh6aYYuFM/ui6UQYZ9jiGA1vGjGmeoKcYbz
         xXpLnjr8G0GZsxWd8TuLCVrrkPsFSC8qZro/7j2nv00XUwxNoe/2q3TLXspsVXKSjFeZ
         j1Wg==
X-Gm-Message-State: AOJu0Yw6FklT5kTzuEQUojKuWTwP4L2c0TuvDxC0mwCDa5JhsgIbCvi3
        Z0aMvqOKDwqqCgVDzRED+BM=
X-Google-Smtp-Source: AGHT+IEf7Gnz9O9WMz3CQOd+A4MjLM6TTZK4jiZl9DPWEVFFAHxMsHTxdrbBpGMTCyZdudHzKKxBQw==
X-Received: by 2002:a17:902:e5cb:b0:1c6:e1d:8be0 with SMTP id u11-20020a170902e5cb00b001c60e1d8be0mr677167plf.2.1697661191282;
        Wed, 18 Oct 2023 13:33:11 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id w12-20020a170902d3cc00b001c61e628e9dsm354412plb.77.2023.10.18.13.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:33:10 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 5/5] mm/khugepaged: Convert collapse_pte_mapped_thp() to use folios
Date:   Wed, 18 Oct 2023 13:32:13 -0700
Message-Id: <20231018203213.50224-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018203213.50224-1-vishal.moola@gmail.com>
References: <20231018203213.50224-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes 2 calls to compound_head() and helps convert khugepaged to
use folios throughout.

Previously, if the address passed to collapse_pte_mapped_thp()
corresponded to a tail page, the scan would fail immediately. Using
filemap_lock_folio() we can get the corresponding folio back and try to
operate on the folio instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d49aa22d99c9..94c1dd09a8a6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1475,7 +1475,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	bool notified = false;
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
 	struct vm_area_struct *vma = vma_lookup(mm, haddr);
-	struct page *hpage;
+	struct folio *folio;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, pgt_pmd;
 	spinlock_t *pml = NULL, *ptl;
@@ -1508,19 +1508,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_wp(vma))
 		return SCAN_PTE_UFFD_WP;
 
-	hpage = find_lock_page(vma->vm_file->f_mapping,
+	folio = filemap_lock_folio(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
-	if (!hpage)
+	if (!folio)
 		return SCAN_PAGE_NULL;
 
-	if (!PageHead(hpage)) {
-		result = SCAN_FAIL;
-		goto drop_hpage;
-	}
-
-	if (compound_order(hpage) != HPAGE_PMD_ORDER) {
+	if (folio_order(folio) != HPAGE_PMD_ORDER) {
 		result = SCAN_PAGE_COMPOUND;
-		goto drop_hpage;
+		goto drop_folio;
 	}
 
 	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
@@ -1534,13 +1529,13 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 */
 		goto maybe_install_pmd;
 	default:
-		goto drop_hpage;
+		goto drop_folio;
 	}
 
 	result = SCAN_FAIL;
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
-		goto drop_hpage;
+		goto drop_folio;
 
 	/* step 1: check all mapped PTEs are to the right huge page */
 	for (i = 0, addr = haddr, pte = start_pte;
@@ -1565,7 +1560,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 * Note that uprobe, debugger, or MAP_PRIVATE may change the
 		 * page table, but the new page will not be a subpage of hpage.
 		 */
-		if (hpage + i != page)
+		if (folio_page(folio, i) != page)
 			goto abort;
 	}
 
@@ -1580,7 +1575,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * page_table_lock) ptl nests inside pml. The less time we hold pml,
 	 * the better; but userfaultfd's mfill_atomic_pte() on a private VMA
 	 * inserts a valid as-if-COWed PTE without even looking up page cache.
-	 * So page lock of hpage does not protect from it, so we must not drop
+	 * So page lock of folio does not protect from it, so we must not drop
 	 * ptl before pgt_pmd is removed, so uffd private needs pml taken now.
 	 */
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
@@ -1604,7 +1599,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			continue;
 		/*
 		 * We dropped ptl after the first scan, to do the mmu_notifier:
-		 * page lock stops more PTEs of the hpage being faulted in, but
+		 * page lock stops more PTEs of the folio being faulted in, but
 		 * does not stop write faults COWing anon copies from existing
 		 * PTEs; and does not stop those being swapped out or migrated.
 		 */
@@ -1613,7 +1608,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			goto abort;
 		}
 		page = vm_normal_page(vma, addr, ptent);
-		if (hpage + i != page)
+		if (folio_page(folio, i) != page)
 			goto abort;
 
 		/*
@@ -1632,8 +1627,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 
 	/* step 3: set proper refcount and mm_counters. */
 	if (nr_ptes) {
-		page_ref_sub(hpage, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
+		folio_ref_sub(folio, nr_ptes);
+		add_mm_counter(mm, mm_counter_file(&folio->page), -nr_ptes);
 	}
 
 	/* step 4: remove empty page table */
@@ -1657,14 +1652,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 maybe_install_pmd:
 	/* step 5: install pmd entry */
 	result = install_pmd
-			? set_huge_pmd(vma, haddr, pmd, hpage)
+			? set_huge_pmd(vma, haddr, pmd, &folio->page)
 			: SCAN_SUCCEED;
-	goto drop_hpage;
+	goto drop_folio;
 abort:
 	if (nr_ptes) {
 		flush_tlb_mm(mm);
-		page_ref_sub(hpage, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
+		folio_ref_sub(folio, nr_ptes);
+		add_mm_counter(mm, mm_counter_file(&folio->page), -nr_ptes);
 	}
 	if (start_pte)
 		pte_unmap_unlock(start_pte, ptl);
@@ -1672,9 +1667,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		spin_unlock(pml);
 	if (notified)
 		mmu_notifier_invalidate_range_end(&range);
-drop_hpage:
-	unlock_page(hpage);
-	put_page(hpage);
+drop_folio:
+	folio_unlock(folio);
+	folio_put(folio);
 	return result;
 }
 
-- 
2.40.1

