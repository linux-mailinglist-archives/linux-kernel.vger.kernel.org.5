Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8516B7D15D9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjJTSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjJTSdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:33:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F0D67
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so1070790b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697826828; x=1698431628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shwuj1hNaDkCqNReHb+lM6WWmRCPMvGlFZhV2p81nh8=;
        b=LIsuR3S32a2PwSp4SAeorZnAZ+GiucSvi/qseMgpfo/GLEHPP4hmdhuddXdQj1MDuL
         +/KnLW/6eM4+Ryabr0n5D984ZWgNFPeXa9f1wptcPuaeLBAgncm9ILAitxq6H/nM7Yk/
         mT9bl9o61Cu54O7HIjk5uF5GnsvZUl+NErG9+MCMF9m0JeGAQRsfNFLOE74RLBSSPGvx
         mWx/o1rgPPwdk8LKJR5RR7nYPFFwcYwQMFZQXSGBASGwXakh6frzxr1v0EnlC8nyPCKj
         4a5NRCzj+AixK3yzH/madUihBRLdSXwVnydlXH5uvV0SQ4ZqkpdKZ+DCTEesJRVEQEBb
         8Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826828; x=1698431628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shwuj1hNaDkCqNReHb+lM6WWmRCPMvGlFZhV2p81nh8=;
        b=ExPf8CngRhkpLZz8Y7IZTu9QiOFfE24tpxEhT3/9U33kQ7lC6rh6aHp/GQLsKnKlVL
         ouFWX1IuitkhzlGPmh6ChvxOzJE0U4uMYxdL7Kf8xZOKqh2jkVoRrtFSGNR5E9b2+jup
         ym+7dUzEbqeCjInNplNtVDLZIiZ6wKAJb8ygIYqw+N+dQTH4DTwOW8pBW2OSKBJh2cw9
         yOlLGxKDnpeifMu0EfHPNxF6Wn96h1PlDmgJz37kNFqdCXiYieh2umd93C9+x+9ue6Ul
         j/AqcfOSyKlQvz6ZUmJS4FUswa3Fxxsj+t1M6lSSQWofVarnvPLAXr4lqaEOeJcMF/yZ
         yW6Q==
X-Gm-Message-State: AOJu0Yw3EGDK6n64h2JIm/RUWjOx1pIKx12B1jdMXHg+BiNaEvzRNWbI
        r9kIKTfVSZBqXo3gYaDFipo=
X-Google-Smtp-Source: AGHT+IFoA9q8+nleOsVaWYGKJMR5PUXVnKaxoWBcmjk+PdUFvUSMwibx6e8j5iJCbuEQcfjDcMuY/A==
X-Received: by 2002:a05:6a00:1ad1:b0:6bd:a7ea:5c7e with SMTP id f17-20020a056a001ad100b006bda7ea5c7emr2751158pfv.11.1697826827696;
        Fri, 20 Oct 2023 11:33:47 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id z14-20020aa7990e000000b006b4ac8885b4sm1911345pff.14.2023.10.20.11.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:33:47 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 5/5] mm/khugepaged: Convert collapse_pte_mapped_thp() to use folios
Date:   Fri, 20 Oct 2023 11:33:31 -0700
Message-Id: <20231020183331.10770-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231020183331.10770-1-vishal.moola@gmail.com>
References: <20231020183331.10770-1-vishal.moola@gmail.com>
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
filemap_lock_folio() we get the corresponding folio back and try to
operate on the folio instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6a7184cd291b..bc2d8ff269c7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1477,7 +1477,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	bool notified = false;
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
 	struct vm_area_struct *vma = vma_lookup(mm, haddr);
-	struct page *hpage;
+	struct folio *folio;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, pgt_pmd;
 	spinlock_t *pml = NULL, *ptl;
@@ -1510,19 +1510,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_wp(vma))
 		return SCAN_PTE_UFFD_WP;
 
-	hpage = find_lock_page(vma->vm_file->f_mapping,
+	folio = filemap_lock_folio(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
-	if (!hpage)
+	if (IS_ERR(folio))
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
@@ -1536,13 +1531,13 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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
@@ -1567,7 +1562,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 * Note that uprobe, debugger, or MAP_PRIVATE may change the
 		 * page table, but the new page will not be a subpage of hpage.
 		 */
-		if (hpage + i != page)
+		if (folio_page(folio, i) != page)
 			goto abort;
 	}
 
@@ -1582,7 +1577,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * page_table_lock) ptl nests inside pml. The less time we hold pml,
 	 * the better; but userfaultfd's mfill_atomic_pte() on a private VMA
 	 * inserts a valid as-if-COWed PTE without even looking up page cache.
-	 * So page lock of hpage does not protect from it, so we must not drop
+	 * So page lock of folio does not protect from it, so we must not drop
 	 * ptl before pgt_pmd is removed, so uffd private needs pml taken now.
 	 */
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
@@ -1606,7 +1601,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			continue;
 		/*
 		 * We dropped ptl after the first scan, to do the mmu_notifier:
-		 * page lock stops more PTEs of the hpage being faulted in, but
+		 * page lock stops more PTEs of the folio being faulted in, but
 		 * does not stop write faults COWing anon copies from existing
 		 * PTEs; and does not stop those being swapped out or migrated.
 		 */
@@ -1615,7 +1610,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			goto abort;
 		}
 		page = vm_normal_page(vma, addr, ptent);
-		if (hpage + i != page)
+		if (folio_page(folio, i) != page)
 			goto abort;
 
 		/*
@@ -1634,8 +1629,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 
 	/* step 3: set proper refcount and mm_counters. */
 	if (nr_ptes) {
-		page_ref_sub(hpage, nr_ptes);
-		add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
+		folio_ref_sub(folio, nr_ptes);
+		add_mm_counter(mm, mm_counter_file(&folio->page), -nr_ptes);
 	}
 
 	/* step 4: remove empty page table */
@@ -1659,14 +1654,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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
@@ -1674,9 +1669,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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

