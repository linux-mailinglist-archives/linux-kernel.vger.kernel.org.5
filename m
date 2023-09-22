Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A10D7ABA25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjIVThA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjIVTg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:36:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C3CB9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:36:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c47309a8ccso30014465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695411410; x=1696016210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNVby2wunRWEn0qOBvwSo9+1ZckN5VFf0mdscjhq8sg=;
        b=nJCAz0FC+Vq+UkOOEWg9ffVDnkruRPAX4fdoldVba9zm0VYK1d0VTC1UrPAvR3sKAE
         CNWv8FJHyj63BnAuEHrF1PWkAhwlqDwYg0eO1IiCDmNGqfaAYgKiWIe/CcMTT0zqQ4hm
         0rYVQFiGyVxYSwmCkl73LQNOMfVBIV0NlteE6Z9kGRzPnyLW0Emmum4KFLBBLaW6hGTR
         xeDOiB3wReAQ27L3HrBugb8RZHqjuPMkE8GyKQ7WDuK/qbaRa8jON/IRqBhCD0WEeV1C
         vdv+xO2rLxGbsOPe/dh4RO6VBDk446phlp6mdmAZyh2yTmRkrGaQ2GEzQlb5eJcLTW/8
         oheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695411410; x=1696016210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNVby2wunRWEn0qOBvwSo9+1ZckN5VFf0mdscjhq8sg=;
        b=hQw88ly32lAJbiGow8979efZWMY1KB/tBLWWKaCB7x/cRBMN9hGXfyqgxZCULrSL9T
         5VwyCT71Opv0OXiSBcR2bBHHdyRiX+cwIaSVYRuI1LHPUHoi2WJwf+D1G0lKdz6fOxIG
         cfbzL/D4+tqC+VnvqWNgiQtib/0h7NgKkB60/RzAUEKQJh183kp0FS8KtikhWj5+ymya
         n5VlLdX1CQayBxkSdliLWrDUZ4xxTHtLudb+Dj3LB/E3kAN3BMfKbT6RAqy9rQJqpO13
         RtDDPQutVkhH/mM6y8yjK7QP9izFh3IARJsTjC/BZ86qBcR2GB+wgZG3Aom9Lb52MQX0
         sQTA==
X-Gm-Message-State: AOJu0YxZGnz60b/6wDJLWAgIOJkcsqIwxCk/PgEuV4z7GRKLJEzTmCXX
        6D9jirFjJvUMhnWA4URAeHc=
X-Google-Smtp-Source: AGHT+IGcVd17kQbCASxBJAiH40hBMFyzCh+Dp7Xr+380ebvaazbf0iRs5Z0HFn9TFwM6Y5hNVP2tfQ==
X-Received: by 2002:a17:903:18d:b0:1bd:d510:78fb with SMTP id z13-20020a170903018d00b001bdd51078fbmr5245132plg.3.1695411410275;
        Fri, 22 Sep 2023 12:36:50 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id q16-20020a170902dad000b001c0cb2aa2easm3841833plx.121.2023.09.22.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:36:49 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH 1/2] mm/khugepaged: Convert __collapse_huge_page_isolate() to use folios
Date:   Fri, 22 Sep 2023 12:36:38 -0700
Message-Id: <20230922193639.10158-2-vishal.moola@gmail.com>
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

This is in preparation for the removal of the khugepaged compound_pagelist.

Replaces 11 calls to compound_head() with 1, and removes 499 bytes of
kernel text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 52 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88433cc25d8a..f46a7a7c489f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -541,7 +541,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 					struct collapse_control *cc,
 					struct list_head *compound_pagelist)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
 	bool writable = false;
@@ -570,15 +570,15 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			result = SCAN_PTE_UFFD_WP;
 			goto out;
 		}
-		page = vm_normal_page(vma, address, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		folio = vm_normal_folio(vma, address, pteval);
+		if (unlikely(!folio) || unlikely(folio_is_zone_device(folio))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
 
-		VM_BUG_ON_PAGE(!PageAnon(page), page);
+		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
 
-		if (page_mapcount(page) > 1) {
+		if (folio_estimated_sharers(folio) > 1) {
 			++shared;
 			if (cc->is_khugepaged &&
 			    shared > khugepaged_max_ptes_shared) {
@@ -588,16 +588,15 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			}
 		}
 
-		if (PageCompound(page)) {
-			struct page *p;
-			page = compound_head(page);
+		if (folio_test_large(folio)) {
+			struct folio *f;
 
 			/*
 			 * Check if we have dealt with the compound page
 			 * already
 			 */
-			list_for_each_entry(p, compound_pagelist, lru) {
-				if (page == p)
+			list_for_each_entry(f, compound_pagelist, lru) {
+				if (folio == f)
 					goto next;
 			}
 		}
@@ -608,7 +607,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * is needed to serialize against split_huge_page
 		 * when invoked from the VM.
 		 */
-		if (!trylock_page(page)) {
+		if (!folio_trylock(folio)) {
 			result = SCAN_PAGE_LOCK;
 			goto out;
 		}
@@ -624,8 +623,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * but not from this process. The other process cannot write to
 		 * the page, only trigger CoW.
 		 */
-		if (!is_refcount_suitable(page)) {
-			unlock_page(page);
+		if (!is_refcount_suitable(&folio->page)) {
+			folio_unlock(folio);
 			result = SCAN_PAGE_COUNT;
 			goto out;
 		}
@@ -634,32 +633,33 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * Isolate the page to avoid collapsing an hugepage
 		 * currently in use by the VM.
 		 */
-		if (!isolate_lru_page(page)) {
-			unlock_page(page);
+		if (!folio_isolate_lru(folio)) {
+			folio_unlock(folio);
 			result = SCAN_DEL_PAGE_LRU;
 			goto out;
 		}
-		mod_node_page_state(page_pgdat(page),
-				NR_ISOLATED_ANON + page_is_file_lru(page),
-				compound_nr(page));
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		VM_BUG_ON_PAGE(PageLRU(page), page);
+		node_stat_mod_folio(folio,
+				NR_ISOLATED_ANON + folio_is_file_lru(folio),
+				folio_nr_pages(folio));
+		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
-		if (PageCompound(page))
-			list_add_tail(&page->lru, compound_pagelist);
+		if (folio_test_large(folio))
+			list_add_tail(&folio->lru, compound_pagelist);
 next:
 		/*
 		 * If collapse was initiated by khugepaged, check that there is
 		 * enough young pte to justify collapsing the page
 		 */
 		if (cc->is_khugepaged &&
-		    (pte_young(pteval) || page_is_young(page) ||
-		     PageReferenced(page) || mmu_notifier_test_young(vma->vm_mm,
+		    (pte_young(pteval) || folio_test_young(folio) ||
+		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
 								     address)))
 			referenced++;
 
 		if (pte_write(pteval))
 			writable = true;
+
 	}
 
 	if (unlikely(!writable)) {
@@ -668,13 +668,13 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		result = SCAN_LACK_REFERENCED_PAGE;
 	} else {
 		result = SCAN_SUCCEED;
-		trace_mm_collapse_huge_page_isolate(page, none_or_zero,
+		trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
 						    referenced, writable, result);
 		return result;
 	}
 out:
 	release_pte_pages(pte, _pte, compound_pagelist);
-	trace_mm_collapse_huge_page_isolate(page, none_or_zero,
+	trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
 					    referenced, writable, result);
 	return result;
 }
-- 
2.40.1

