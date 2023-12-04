Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C000803658
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbjLDOWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbjLDOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B91A1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWanwqicBfazF+1iBEpyOQZ25LJEujBQqHyMDlWvhqA=;
        b=LAlUzxoTyYLO0ukIM9henASMEmCRTRSh4aGJPKaCytwf4HCDnHzrRhaJXTryPDhxp3+QVN
        CJoyKXp8xctxkOMMePl2kFlSCCcxNMug8X7APeLBZPJcKg63S1G4ETcgewRLEwuIoFpP07
        jF89SvjseSB7Ksw4MsjUQ4mliVFAx8s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-zbIm8uHQNrW7J5QBtxdQDA-1; Mon,
 04 Dec 2023 09:22:04 -0500
X-MC-Unique: zbIm8uHQNrW7J5QBtxdQDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C48C2825E93;
        Mon,  4 Dec 2023 14:22:03 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF5FB2026D68;
        Mon,  4 Dec 2023 14:22:01 +0000 (UTC)
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
Subject: [PATCH RFC 08/39] mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()
Date:   Mon,  4 Dec 2023 15:21:15 +0100
Message-ID: <20231204142146.91437-9-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's convert insert_page_into_pte_locked() and do_set_pmd(). While at it,
perform some folio conversion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 15325587cff01..be7fe58f7c297 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1845,12 +1845,14 @@ static int validate_page_before_insert(struct page *page)
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 			unsigned long addr, struct page *page, pgprot_t prot)
 {
+	struct folio *folio = page_folio(page);
+
 	if (!pte_none(ptep_get(pte)))
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
-	get_page(page);
+	folio_get(folio);
 	inc_mm_counter(vma->vm_mm, mm_counter_file(page));
-	page_add_file_rmap(page, vma, false);
+	folio_add_file_rmap_pte(folio, page, vma);
 	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
 	return 0;
 }
@@ -4308,6 +4310,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
@@ -4317,8 +4320,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (!transhuge_vma_suitable(vma, haddr))
 		return ret;
 
-	page = compound_head(page);
-	if (compound_order(page) != HPAGE_PMD_ORDER)
+	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
 		return ret;
 
 	/*
@@ -4327,7 +4329,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	 * check.  This kind of THP just can be PTE mapped.  Access to
 	 * the corrupted subpage should trigger SIGBUS as expected.
 	 */
-	if (unlikely(PageHasHWPoisoned(page)))
+	if (unlikely(folio_test_has_hwpoisoned(folio)))
 		return ret;
 
 	/*
@@ -4351,7 +4353,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
 	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
-	page_add_file_rmap(page, vma, true);
+	folio_add_file_rmap_pmd(folio, page, vma);
 
 	/*
 	 * deposit and withdraw with pmd lock held
-- 
2.41.0

