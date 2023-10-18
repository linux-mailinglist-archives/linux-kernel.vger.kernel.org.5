Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9B7CE904
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJRUdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjJRUdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:33:09 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1412A4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:07 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso4482279a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697661187; x=1698265987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN0zp0snARiXWQz31GgzZoIBHJFk7ynRrvZrhH9BDQE=;
        b=D2b1nL2Z0+kLLAkeFoJtazPKDb0mIfpq2MEulnM9kEayYpSPJ1BTw8TGMnUNwPXBrD
         fxXfdeO0bOacNxms4BKe071MgSnu5Cwp1hZgSU+mJmqSZtSXTIeeGzvvEb5Q11pPXoBr
         rXJw8Jv/yzKWyJM7yspm+cPXZ7CULsZ5qSs9pDytkKvogoXax7mQQRQXnC4LWkhnx4L8
         dkVH/D49siXJuVfQeqSmJlNQhcEGOaFgMwkrqo6HcUFQsBKWMarlo+ZcZuwA84klrEQv
         omP/zVxZloIagrKA9xMUwJ1BmdC82sYLzYVkIMSRcr8ksI2/tSEzVyYg9ueRxLMsSSIs
         koiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661187; x=1698265987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VN0zp0snARiXWQz31GgzZoIBHJFk7ynRrvZrhH9BDQE=;
        b=SFbG/fCzbpchebk0c6Bk8OGevZfJQULrHOKt2R3rFWsfETFmpsDlvRCOslJFw45H1d
         H86xWYg0KkysX13EEtAQrxcXb1xEai561zkmOe/CfG429+vOxIERCB3uhUlHRfnv7ZaZ
         HjH/FdW9gZ1k1PemodicfvDjbzo1Id3a+8VCt9j+8kbkx5Rn0YpsBHfHj7eXO3vIhAbw
         ErJ9uLb3heKQNjSgiVlCpr6ecqRnRziDzl/mQlCqztBFfaKOULVrVr5v6U4JwUwS7Q6+
         DWNNh92mxau45xiREF4WEHWrng35kJ4Rz6KQGEeCaClS0/N7IrPEc0UVnJ6CdGfMlr8/
         mvrw==
X-Gm-Message-State: AOJu0YyqxhlyM4ikECcL43zdRoz16yGajtb502BhlrpdG8c4Kq1+mMxH
        WKqcQEWHaLwzmF2C6+rtKf4=
X-Google-Smtp-Source: AGHT+IE6UrwDxrBBS7hjFHieWc31jxdejoBL6wMFdYPOtBiCq+4eALL+xiIct2VZuc3ylwqsKZTYgw==
X-Received: by 2002:a05:6a21:6da0:b0:14c:d494:77c5 with SMTP id wl32-20020a056a216da000b0014cd49477c5mr307966pzb.13.1697661187061;
        Wed, 18 Oct 2023 13:33:07 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id w12-20020a170902d3cc00b001c61e628e9dsm354412plb.77.2023.10.18.13.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:33:06 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/5] mm/khugepaged: Convert __collapse_huge_page_isolate() to use folios
Date:   Wed, 18 Oct 2023 13:32:09 -0700
Message-Id: <20231018203213.50224-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018203213.50224-1-vishal.moola@gmail.com>
References: <20231018203213.50224-1-vishal.moola@gmail.com>
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

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

