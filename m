Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55FE803673
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbjLDOYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345591AbjLDOXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:23:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701811A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KbWS1WI33hCQDyuuf4OMcK1JcfvJiYhRWhxjjruqKZQ=;
        b=NFVV1l/8MKWY9ceMD+eUMGlWAvDSB8IwRFxOophuJWtMjG4F3TOk/aMUKyFRiuidJECV8X
        bgavYTx+mVv8FEZiwYC5OKUTq85kEIJaWqSPU1+59FoKLO/TLMFWBBuLQ7hN2gFrSKsfFt
        zLnQA12Pe34otTuespnW5T3pLydxs7k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-d-d9o59fPPm40XM48Es9-g-1; Mon, 04 Dec 2023 09:22:38 -0500
X-MC-Unique: d-d9o59fPPm40XM48Es9-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D93A9101A529;
        Mon,  4 Dec 2023 14:22:37 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 460F42026D4C;
        Mon,  4 Dec 2023 14:22:36 +0000 (UTC)
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
Subject: [PATCH RFC 26/39] mm/khugepaged: page_remove_rmap() -> folio_remove_rmap_pte()
Date:   Mon,  4 Dec 2023 15:21:33 +0100
Message-ID: <20231204142146.91437-27-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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
index 064654717843e..c2d7438fac22d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -493,11 +493,6 @@ static void release_pte_folio(struct folio *folio)
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
@@ -686,6 +681,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 						spinlock_t *ptl,
 						struct list_head *compound_pagelist)
 {
+	struct folio *src_folio;
 	struct page *src_page;
 	struct page *tmp;
 	pte_t *_pte;
@@ -707,16 +703,17 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
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
@@ -1619,7 +1616,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 * PTE dirty? Shmem page is already dirty; file is read-only.
 		 */
 		ptep_clear(mm, addr, pte);
-		page_remove_rmap(page, vma, false);
+		folio_remove_rmap_pte(folio, page, vma);
 		nr_ptes++;
 	}
 
-- 
2.41.0

