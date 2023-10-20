Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF177D15DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjJTSdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:33:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A493D5B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso1064047b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697826824; x=1698431624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr6V2LCgJ9TVJLB96vsUnm/xqKZcto4Za9cX8Go8cec=;
        b=HYX1L559DtEq154vwCpkFBPlvKAHxN1+kc/Em7pUEga2+In6+pmqasjNOF3gLEFzN4
         l+JOpLsoDjH/b0O6djwmNtee7I877AGNMNZ7sr63arV9huIvQQHj34LYVRkIDTMxQQdD
         JQszknP2THonG6VWkSZO0mzcPM0cs/i4HOz69FoAvnmLlcp7GDdIdpZc5S2aQ9K3uBUa
         GgavpWbXi1CHVA5GIV+0vmxj0hBDeiPebqmP7zs8IKBNzLYdNMOa/i5sAyJAzEyD3iUx
         4muJBKUwPCMW9Rbe0f1YW2gvSmeITDfcP+CN8dtI3TzR92USHnUHwYDsixvpfa1gyF4p
         k9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826824; x=1698431624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rr6V2LCgJ9TVJLB96vsUnm/xqKZcto4Za9cX8Go8cec=;
        b=Gh8Iisf1nYWWVYJ51ujq7RqIajWROQRuSw0BKJIydygsj40xw5QaweHPYa29ZoxlQw
         v0PtUvdhww7/sn9gXUbW74cREMusXrkWywXvCB2ZOOu0/PtotLH9QRjMLygOdybASbBP
         GFv3+8wtYpQ4043dufwYnCqM9Tc5OoVfT1b5iFTXJL5RPr4x8RqNAdKm6eXA50C9P6Uz
         lFJMgSf3OXHKDJ5KkbFjppK/JhPgaa7Coz3OusX5D8UKj5JXnYLwssK1tiQRxxUt/LH1
         dsxpkKYdCJe9utxWJmeL+5ryV38bZqETYEpU+OHEtabd6AIowpLDpi6ZIH56u040Kkg0
         2xKw==
X-Gm-Message-State: AOJu0YxiAVYPqJdSCyZZ5ZRACdrm7ADgPywVaHYJQ0TdqZXaKwjYe0+q
        9Sm8CyDp6NK8UlWTT5g2ay5zKloEMkU=
X-Google-Smtp-Source: AGHT+IGHwdGrDYHJU3ar4omw5xYzuwotpwlRbNDAoj/IKDWChBLhpJBOvVjPjaCZMcDR1LHeQ2sY9A==
X-Received: by 2002:a05:6a20:158c:b0:17c:cd46:73d with SMTP id h12-20020a056a20158c00b0017ccd46073dmr386382pzj.20.1697826823892;
        Fri, 20 Oct 2023 11:33:43 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id z14-20020aa7990e000000b006b4ac8885b4sm1911345pff.14.2023.10.20.11.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:33:43 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 1/5] mm/khugepaged: Convert __collapse_huge_page_isolate() to use folios
Date:   Fri, 20 Oct 2023 11:33:27 -0700
Message-Id: <20231020183331.10770-2-vishal.moola@gmail.com>
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

Replaces 11 calls to compound_head() with 1, and removes 1348 bytes of
kernel text.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88433cc25d8a..500756604488 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -542,6 +542,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 					struct list_head *compound_pagelist)
 {
 	struct page *page = NULL;
+	struct folio *folio = NULL;
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
 	bool writable = false;
@@ -576,7 +577,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 
-		VM_BUG_ON_PAGE(!PageAnon(page), page);
+		folio = page_folio(page);
+		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
 
 		if (page_mapcount(page) > 1) {
 			++shared;
@@ -588,16 +590,15 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
@@ -608,7 +609,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * is needed to serialize against split_huge_page
 		 * when invoked from the VM.
 		 */
-		if (!trylock_page(page)) {
+		if (!folio_trylock(folio)) {
 			result = SCAN_PAGE_LOCK;
 			goto out;
 		}
@@ -624,8 +625,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
@@ -634,27 +635,27 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
 
@@ -668,13 +669,13 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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

