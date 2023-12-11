Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7408080D045
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbjLKP6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbjLKP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CF111D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VER2ukZQXsfAHa/RpU4plqm2RzyVwEC40zuZNC17KhY=;
        b=gXhLSx8wfWrx+SsqvBXh/5A6QnWb3MraItxEdms0AYXbBmLOn1F7PP4FbeiaWZO+HUp6tv
        uR6aQNCJiR6TP175pkE1MhfuTlR2u/3vQzmT+dpIarTC8P5b5CcwTeTzPxjmONpcyQc0nb
        z/bwRemW2NiHpt+wwtL53pr3CxdVAFE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-O8xKFmHWPGuFDgNfrHONmg-1; Mon,
 11 Dec 2023 10:58:04 -0500
X-MC-Unique: O8xKFmHWPGuFDgNfrHONmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E3723C28642;
        Mon, 11 Dec 2023 15:58:03 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 094C11121312;
        Mon, 11 Dec 2023 15:57:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 26/39] mm/khugepaged: page_remove_rmap() -> folio_remove_rmap_pte()
Date:   Mon, 11 Dec 2023 16:56:39 +0100
Message-ID: <20231211155652.131054-27-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's convert __collapse_huge_page_copy_succeeded() and
collapse_pte_mapped_thp(). While at it, perform some more folio
conversion in __collapse_huge_page_copy_succeeded().

We can get rid of release_pte_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/khugepaged.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index de174d049e71..4d90c9548ec9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -494,11 +494,6 @@ static void release_pte_folio(struct folio *folio)
 	folio_putback_lru(folio);
 }
 
-static void release_pte_page(struct page *page)
-{
-	release_pte_folio(page_folio(page));
-}
-
 static void release_pte_pages(pte_t *pte, pte_t *_pte,
 		struct list_head *compound_pagelist)
 {
@@ -687,6 +682,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 						spinlock_t *ptl,
 						struct list_head *compound_pagelist)
 {
+	struct folio *src_folio;
 	struct page *src_page;
 	struct page *tmp;
 	pte_t *_pte;
@@ -708,16 +704,17 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 			}
 		} else {
 			src_page = pte_page(pteval);
-			if (!PageCompound(src_page))
-				release_pte_page(src_page);
+			src_folio = page_folio(src_page);
+			if (!folio_test_large(src_folio))
+				release_pte_folio(src_folio);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
 			 * be disabled to update the per-cpu stats
-			 * inside page_remove_rmap().
+			 * inside folio_remove_rmap_pte().
 			 */
 			spin_lock(ptl);
 			ptep_clear(vma->vm_mm, address, _pte);
-			page_remove_rmap(src_page, vma, false);
+			folio_remove_rmap_pte(src_folio, src_page, vma);
 			spin_unlock(ptl);
 			free_page_and_swap_cache(src_page);
 		}
@@ -1624,7 +1621,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 * PTE dirty? Shmem page is already dirty; file is read-only.
 		 */
 		ptep_clear(mm, addr, pte);
-		page_remove_rmap(page, vma, false);
+		folio_remove_rmap_pte(folio, page, vma);
 		nr_ptes++;
 	}
 
-- 
2.43.0

