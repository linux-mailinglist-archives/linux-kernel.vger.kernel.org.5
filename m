Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645507CB3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjJPUHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjJPUHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:07:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D85B83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-694ed84c981so3824033b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697486816; x=1698091616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dowlsYISY/BEh4ltWtb6fy0PpeiHEk3DajdxWZY/uS8=;
        b=ZymhdnWbKZ87bAuTMygb33npqOkU+9YCKJ2mM6s5lGVETQDZ61iTSfN8/jYIdBBTKM
         LMx1xyr+ioWpD9ltXJ9jKUaoj/dh848kIsAo3h32EzgAwGVlFJr8RvtzH7Fk5a0ghwH0
         KMfLC0vufvHB9bLbIoBniuc6yCNr8lifeFlvXrSfwNwyxSUp3PJkvvkfRy4Ky0JX3iNl
         ItDAhFqocp/2tekjOuZNa6YWBG/sSiKwigT8RxslQEQwysD40QBsEQ83xeITFANwZWuG
         fC0hZAuNz7kUwnXMGSmDs/Thoame69WTv9M/Ro9kb79JZb2UxrMwph8/9gy3zRN9wTQ3
         sonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486816; x=1698091616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dowlsYISY/BEh4ltWtb6fy0PpeiHEk3DajdxWZY/uS8=;
        b=s0Qy1ePX/F1XFg9oRIFe7K+iQ/5IWaUHjKunJS1UO6dychdwlmC4inmEfBsIFPWtmL
         An3EuzhW5S2pH90IiDbszgTr5vU2QXbXadUN5M2Z3AEeQl1wjSQG3dMiyN7lX0OW7XBl
         cF2hr5e7Fodfkp2OlvwGzvPz42O3MttZ5qYpNYVsQ50Jc+jkkJxSUMdgdkPcWLVsd2H5
         nhwPa3nZUg3C/mPDXfhNsdjQrBCNMrwR+HrWcrB2AXwjbpNFR8bZlDe5gSeOxFuGmUwP
         Fihk/kMxP2gUAPWRYo2SEYwhVWvUSqLLLvurRnBsRK9WCnFahs+ivbOvpWuNkCxWg7NU
         DWZw==
X-Gm-Message-State: AOJu0YwtlQdbQlMNYT8N6Rhr807001aRIKBTHeetxy4TW6h39Yeu9WuK
        gV33kb2of5lyrakdbiPCDILvh3CP1iI=
X-Google-Smtp-Source: AGHT+IHNAbR5P9OXapRD4T0zOXCwzPhLQ3rt7wyj9Cgg9D9ndiZau71+lTiikiZfhKBGtwidV+lYHQ==
X-Received: by 2002:a05:6300:8003:b0:12c:b10d:693d with SMTP id an3-20020a056300800300b0012cb10d693dmr97230pzc.6.1697486816530;
        Mon, 16 Oct 2023 13:06:56 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id t16-20020a17090b019000b002772faee740sm5162367pjs.5.2023.10.16.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:06:56 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/5] mm/khugepaged: Convert __collapse_huge_page_isolate() to use folios
Date:   Mon, 16 Oct 2023 13:05:06 -0700
Message-Id: <20231016200510.7387-2-vishal.moola@gmail.com>
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

Replaces 11 calls to compound_head() with 1, and removes 1375 bytes of
kernel text.

Previously, to determine if any pte was shared, the page mapcount
corresponding exactly to the pte was checked. This gave us a precise
number of shared ptes. Using folio_estimated_sharers() instead uses
the mapcount of the head page, giving us an estimate for tail page ptes.

This means if a tail page's mapcount is greater than its head page's
mapcount, folio_estimated_sharers() would be underestimating the number of
shared ptes, and vice versa.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/khugepaged.c | 51 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88433cc25d8a..7a552fe16c92 100644
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
@@ -634,27 +633,27 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
 
@@ -668,13 +667,13 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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

