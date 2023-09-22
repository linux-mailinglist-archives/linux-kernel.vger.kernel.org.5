Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98B37ABA26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjIVThD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjIVTg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:36:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F21C2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:36:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso22700055ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695411411; x=1696016211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0U3LCSGR9Uhg87btUKAqCyaspyDfBYXfRcxhUzWxmiQ=;
        b=RJ1Pn7SLjrmyrRJCcDvVHX0ZDO2xd98vIi6eI/fYIw/qz5Ng/wr2PTKxRbG+z5+cNS
         A6Glm/F0kFMb1Qy3DHBW/mlUGHrExQhs21C4gnZbNXjpHwf5kFNvDPraG+Hrh1v45Ty0
         SZUUgTZKD4t5ycVbF7iaKDX9mICC5hvahuXRY7M7ERsuxm7zBFDflzhb2zh0H+KL25Ul
         vp3qXGDTIFZXsMW80kroaZmOOq1G6LB8/9tQANhkDMR5wIX/USyfkCLOyZqziytbEesQ
         9dSRdYZMqOkA5hdpzJBHOsGi1tELTHNraMlCSz1M1fJRScE19CK/kg6ro/Bo8XZjxYLa
         OCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695411411; x=1696016211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0U3LCSGR9Uhg87btUKAqCyaspyDfBYXfRcxhUzWxmiQ=;
        b=Jg2bvA9o8DxK2XjrneC0ebhsS1kAhbsZcTeM9wFiKCKb1mBdZVwv2vWJ05UgsQyry/
         3wrnUdSeAd8jl5N819RWjw2SIQtX7PGhavyx/Hmk3i1Vl035kMzwCsjV6Dox9XQE1DoX
         friQvWEsBGZHV0TD2aXM0N3NglfK2182Wt/dFXvcMMvFcbzf4yY+CZH6U+Z5zIw7tB2T
         AFvOBCc6LvDN/y3MrkqxSECKApa/m2QeuBmHiQSGTQO1FrcKmDYjhAtt12q5uqu51AZX
         TI5V2+EvA5faeHYNCpQw7hHeZ+kAJJGOz46qrIHgJG2tmBrOSr+TpX9WKWo4yhVec9I7
         Ie9Q==
X-Gm-Message-State: AOJu0YwKlf0jNG1ZYDqtTmig0AXHprjlQ9j6sx7PHJy7eqyXcVb2B37D
        aCyXXac2qWH0CNH31YBif2U=
X-Google-Smtp-Source: AGHT+IFXiOoyqmw7Xh6EuLjaPNmIhMs1ArpEPXr7cCXwinyLyUAQ1cQwwDEcx7Cz+xj6D8q4+onGTQ==
X-Received: by 2002:a17:902:9004:b0:1c5:ea60:85c1 with SMTP id a4-20020a170902900400b001c5ea6085c1mr365596plp.12.1695411411279;
        Fri, 22 Sep 2023 12:36:51 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id q16-20020a170902dad000b001c0cb2aa2easm3841833plx.121.2023.09.22.12.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:36:50 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH 2/2] mm/khugepaged: Remove compound_pagelist
Date:   Fri, 22 Sep 2023 12:36:39 -0700
Message-Id: <20230922193639.10158-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230922193639.10158-1-vishal.moola@gmail.com>
References: <20230922193639.10158-1-vishal.moola@gmail.com>
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

Currently, khugepaged builds a compound_pagelist while scanning, which
is used to properly account for compound pages. We can now account
for a compound page as a singular folio instead, so remove this list.

Large folios are guaranteed to have consecutive ptes and addresses, so
once the first pte of a large folio is found skip over the rest.

This helps convert khugepaged to use folios. It removes 3 compound_head
calls in __collapse_huge_page_copy_succeeded(), and removes 980 bytes of
kernel text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 76 ++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 58 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f46a7a7c489f..b6c7d55a8231 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -498,10 +498,9 @@ static void release_pte_page(struct page *page)
 	release_pte_folio(page_folio(page));
 }
 
-static void release_pte_pages(pte_t *pte, pte_t *_pte,
-		struct list_head *compound_pagelist)
+static void release_pte_folios(pte_t *pte, pte_t *_pte)
 {
-	struct folio *folio, *tmp;
+	struct folio *folio;
 
 	while (--_pte >= pte) {
 		pte_t pteval = ptep_get(_pte);
@@ -514,12 +513,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 			continue;
 		folio = pfn_folio(pfn);
 		if (folio_test_large(folio))
-			continue;
-		release_pte_folio(folio);
-	}
-
-	list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
-		list_del(&folio->lru);
+			_pte -= folio_nr_pages(folio) - 1;
 		release_pte_folio(folio);
 	}
 }
@@ -538,8 +532,7 @@ static bool is_refcount_suitable(struct page *page)
 static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 					unsigned long address,
 					pte_t *pte,
-					struct collapse_control *cc,
-					struct list_head *compound_pagelist)
+					struct collapse_control *cc)
 {
 	struct folio *folio = NULL;
 	pte_t *_pte;
@@ -588,19 +581,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			}
 		}
 
-		if (folio_test_large(folio)) {
-			struct folio *f;
-
-			/*
-			 * Check if we have dealt with the compound page
-			 * already
-			 */
-			list_for_each_entry(f, compound_pagelist, lru) {
-				if (folio == f)
-					goto next;
-			}
-		}
-
 		/*
 		 * We can do it before isolate_lru_page because the
 		 * page can't be freed from under us. NOTE: PG_lock
@@ -644,9 +624,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
-		if (folio_test_large(folio))
-			list_add_tail(&folio->lru, compound_pagelist);
-next:
 		/*
 		 * If collapse was initiated by khugepaged, check that there is
 		 * enough young pte to justify collapsing the page
@@ -660,6 +637,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		if (pte_write(pteval))
 			writable = true;
 
+		if (folio_test_large(folio)) {
+			_pte += folio_nr_pages(folio) - 1;
+			address += folio_size(folio) - PAGE_SIZE;
+		}
 	}
 
 	if (unlikely(!writable)) {
@@ -673,7 +654,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		return result;
 	}
 out:
-	release_pte_pages(pte, _pte, compound_pagelist);
+	release_pte_folios(pte, _pte);
 	trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
 					    referenced, writable, result);
 	return result;
@@ -682,11 +663,9 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 						struct vm_area_struct *vma,
 						unsigned long address,
-						spinlock_t *ptl,
-						struct list_head *compound_pagelist)
+						spinlock_t *ptl)
 {
 	struct page *src_page;
-	struct page *tmp;
 	pte_t *_pte;
 	pte_t pteval;
 
@@ -706,8 +685,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 			}
 		} else {
 			src_page = pte_page(pteval);
-			if (!PageCompound(src_page))
-				release_pte_page(src_page);
+			release_pte_page(src_page);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
 			 * be disabled to update the per-cpu stats
@@ -720,23 +698,12 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 			free_page_and_swap_cache(src_page);
 		}
 	}
-
-	list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
-		list_del(&src_page->lru);
-		mod_node_page_state(page_pgdat(src_page),
-				    NR_ISOLATED_ANON + page_is_file_lru(src_page),
-				    -compound_nr(src_page));
-		unlock_page(src_page);
-		free_swap_cache(src_page);
-		putback_lru_page(src_page);
-	}
 }
 
 static void __collapse_huge_page_copy_failed(pte_t *pte,
 					     pmd_t *pmd,
 					     pmd_t orig_pmd,
-					     struct vm_area_struct *vma,
-					     struct list_head *compound_pagelist)
+					     struct vm_area_struct *vma)
 {
 	spinlock_t *pmd_ptl;
 
@@ -753,7 +720,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 	 * Release both raw and compound pages isolated
 	 * in __collapse_huge_page_isolate.
 	 */
-	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
+	release_pte_folios(pte, pte + HPAGE_PMD_NR);
 }
 
 /*
@@ -769,7 +736,6 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
  * @vma: the original raw pages' virtual memory area
  * @address: starting address to copy
  * @ptl: lock on raw pages' PTEs
- * @compound_pagelist: list that stores compound pages
  */
 static int __collapse_huge_page_copy(pte_t *pte,
 				     struct page *page,
@@ -777,8 +743,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
 				     pmd_t orig_pmd,
 				     struct vm_area_struct *vma,
 				     unsigned long address,
-				     spinlock_t *ptl,
-				     struct list_head *compound_pagelist)
+				     spinlock_t *ptl)
 {
 	struct page *src_page;
 	pte_t *_pte;
@@ -804,11 +769,9 @@ static int __collapse_huge_page_copy(pte_t *pte,
 	}
 
 	if (likely(result == SCAN_SUCCEED))
-		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
-						    compound_pagelist);
+		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl);
 	else
-		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
-						 compound_pagelist);
+		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma);
 
 	return result;
 }
@@ -1081,7 +1044,6 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 			      int referenced, int unmapped,
 			      struct collapse_control *cc)
 {
-	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
 	pte_t *pte;
 	pgtable_t pgtable;
@@ -1168,8 +1130,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
-		result = __collapse_huge_page_isolate(vma, address, pte, cc,
-						      &compound_pagelist);
+		result = __collapse_huge_page_isolate(vma, address, pte, cc);
 		spin_unlock(pte_ptl);
 	} else {
 		result = SCAN_PMD_NULL;
@@ -1198,8 +1159,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	anon_vma_unlock_write(vma->anon_vma);
 
 	result = __collapse_huge_page_copy(pte, hpage, pmd, _pmd,
-					   vma, address, pte_ptl,
-					   &compound_pagelist);
+					   vma, address, pte_ptl);
 	pte_unmap(pte);
 	if (unlikely(result != SCAN_SUCCEED))
 		goto out_up_write;
-- 
2.40.1

