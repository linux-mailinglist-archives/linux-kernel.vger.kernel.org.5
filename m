Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0380D02F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbjLKP5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344486AbjLKP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECFEF4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6j0c9ENvnxisPX95qRO4NJave2eFRdDuqpK0xgwx6DM=;
        b=KpZeAeGJRDAN/jBkv/DGO11+O2YspIg2o3hKex3LIpd7FR1pDWBCX5d/MxtshL/sAmjO0R
        mw2I/gIv2/KjE3H+gCX/01xwcf7m1jwX2w+zZkZ3udCfiH711oVCghnNk3dmCFnU2RwqSU
        meU5O2PW3lnAamFgXAH3ulPGJpLB5Os=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-i-re_ooQPI6Z0iay6LlX8A-1; Mon,
 11 Dec 2023 10:57:17 -0500
X-MC-Unique: i-re_ooQPI6Z0iay6LlX8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 321B73C2865F;
        Mon, 11 Dec 2023 15:57:17 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4961121306;
        Mon, 11 Dec 2023 15:57:15 +0000 (UTC)
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
Subject: [PATCH v1 08/39] mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()
Date:   Mon, 11 Dec 2023 16:56:21 +0100
Message-ID: <20231211155652.131054-9-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6a5540ba3c65..70754fd65788 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1859,12 +1859,14 @@ static int validate_page_before_insert(struct page *page)
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
@@ -4409,6 +4411,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
@@ -4418,8 +4421,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
 		return ret;
 
-	page = compound_head(page);
-	if (compound_order(page) != HPAGE_PMD_ORDER)
+	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
 		return ret;
 
 	/*
@@ -4428,7 +4430,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	 * check.  This kind of THP just can be PTE mapped.  Access to
 	 * the corrupted subpage should trigger SIGBUS as expected.
 	 */
-	if (unlikely(PageHasHWPoisoned(page)))
+	if (unlikely(folio_test_has_hwpoisoned(folio)))
 		return ret;
 
 	/*
@@ -4452,7 +4454,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
 	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
-	page_add_file_rmap(page, vma, true);
+	folio_add_file_rmap_pmd(folio, page, vma);
 
 	/*
 	 * deposit and withdraw with pmd lock held
-- 
2.43.0

