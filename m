Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8893F7CB3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjJPUHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjJPUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:07:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F45EE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:07:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5a1d91a29a0so3670495a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697486820; x=1698091620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1jVF5fDDtB5E1xXw4u2h0Qq1/g1/HjZ8iamB/5OFoA=;
        b=aERMXq8DV73yjLippLpiuRtwzFcFw/WYuvqnlRbHHHfjn25nRadm3YMgWO+1fvmLSx
         148Kk/6Ks/w2NmbKpcJNf3srriXyzfQLBAzLns7MnPq1Gcgb8uM1G91NNv5+cx8nuu3g
         Dy5pvdCTKsq9lMFuKCkrLohcsygvLqvKtvQ7FZdokG5AwRHw0YCGKQUXzp+eyrFZZf7Q
         a0ToPBFaoEtnRFfBEKfsLoz/r80av0d3BWaxzzdIiC/ra2PdNovzBWGb1JxAwpwQCFlC
         5fM03Fn3X+GAqPeV23BOZNKMWjipUIYNY4ryxydn7dC8+nebZDZhvUmwXLOwujZ2IWMz
         JPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486820; x=1698091620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1jVF5fDDtB5E1xXw4u2h0Qq1/g1/HjZ8iamB/5OFoA=;
        b=bgXX9plPnK4RB+j7RJaYl8LMevRm18WLMteDEDuZ0zY7/YGufd4SPEPDebvFmZRobC
         rA5ysTg8bSAjAFb3LaW/2dX6avNQzu1JXSPWtBUjqo3hJSjf9aY6y786uQKacznbXAVW
         wEMYLhIk7tlgLq0bp4PsWp7phYo1/zDRwWPpfswszQvn1+XXpDyb9qGhWLEaPfgEdWgB
         ql8sDTOPJiOCkc/sqBGJP47jW3I1hLh9JC7WLkYUJKqIkur4iPkwhWFtTrx3FOaPpy9p
         fzT2CzlQxouijmVsmgnjXATd6uRdlBvjGFIliZjL9XWes89qvu9Sft5h7N1ewG7j2Zyp
         fDKg==
X-Gm-Message-State: AOJu0YwW9NpTMRRZ4dQTgFrJLChYOQSoJAPPPWoa+WuXETbVZmZWGEWe
        pnT/NPXYOWEUtuMtSL9/5qd+zJe/HPE=
X-Google-Smtp-Source: AGHT+IFPrGp2LxyePxJ2SGP9Uv5jwNSK/jlVnwKjorWrK64yF1KjrffZTKbz4NdtbcNvcYG72+5GCQ==
X-Received: by 2002:a17:90b:368d:b0:27d:f85:9505 with SMTP id mj13-20020a17090b368d00b0027d0f859505mr159453pjb.24.1697486820185;
        Mon, 16 Oct 2023 13:07:00 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id t16-20020a17090b019000b002772faee740sm5162367pjs.5.2023.10.16.13.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:06:59 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 5/5] mm/khugepaged: Convert collapse_pte_mapped_thp() to use folios
Date:   Mon, 16 Oct 2023 13:05:10 -0700
Message-Id: <20231016200510.7387-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016200510.7387-1-vishal.moola@gmail.com>
References: <20231016200510.7387-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 70bba8ddea13..99c437979848 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1471,7 +1471,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	bool notified = false;
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
 	struct vm_area_struct *vma = vma_lookup(mm, haddr);
-	struct page *hpage;
+	struct folio *folio;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, pgt_pmd;
 	spinlock_t *pml = NULL, *ptl;
@@ -1504,19 +1504,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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
@@ -1530,13 +1525,13 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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
@@ -1561,7 +1556,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 * Note that uprobe, debugger, or MAP_PRIVATE may change the
 		 * page table, but the new page will not be a subpage of hpage.
 		 */
-		if (hpage + i != page)
+		if (folio_page(folio, i) != page)
 			goto abort;
 	}
 
@@ -1576,7 +1571,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * page_table_lock) ptl nests inside pml. The less time we hold pml,
 	 * the better; but userfaultfd's mfill_atomic_pte() on a private VMA
 	 * inserts a valid as-if-COWed PTE without even looking up page cache.
-	 * So page lock of hpage does not protect from it, so we must not drop
+	 * So page lock of folio does not protect from it, so we must not drop
 	 * ptl before pgt_pmd is removed, so uffd private needs pml taken now.
 	 */
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
@@ -1600,7 +1595,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			continue;
 		/*
 		 * We dropped ptl after the first scan, to do the mmu_notifier:
-		 * page lock stops more PTEs of the hpage being faulted in, but
+		 * page lock stops more PTEs of the folio being faulted in, but
 		 * does not stop write faults COWing anon copies from existing
 		 * PTEs; and does not stop those being swapped out or migrated.
 		 */
@@ -1609,7 +1604,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			goto abort;
 		}
 		page = vm_normal_page(vma, addr, ptent);
-		if (hpage + i != page)
+		if (folio_page(folio, i) != page)
 			goto abort;
 
 		/*
@@ -1628,8 +1623,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 
 	/* step 3: set proper refcount and mm_counters. */
 	if (nr_ptes) {
-		page_ref_sub(hpage, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
+		folio_ref_sub(folio, nr_ptes);
+		add_mm_counter(mm, mm_counter_file(&folio->page), -nr_ptes);
 	}
 
 	/* step 4: remove empty page table */
@@ -1653,14 +1648,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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
@@ -1668,9 +1663,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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

