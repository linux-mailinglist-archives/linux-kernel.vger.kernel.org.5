Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E81803659
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbjLDOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345282AbjLDOWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F45F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:11 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Bad9lET6NLK8wnUArWRxyg-1; Mon, 04 Dec 2023 09:22:06 -0500
X-MC-Unique: Bad9lET6NLK8wnUArWRxyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7602885A5B5;
        Mon,  4 Dec 2023 14:22:05 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C73B42026D4C;
        Mon,  4 Dec 2023 14:22:03 +0000 (UTC)
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
Subject: [PATCH RFC 09/39] mm/huge_memory: page_add_file_rmap() -> folio_add_file_rmap_pmd()
Date:   Mon,  4 Dec 2023 15:21:16 +0100
Message-ID: <20231204142146.91437-10-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's convert remove_migration_pmd() and while at it, perform some folio
conversion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f542444a91f2..cb33c6e0404cf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3276,6 +3276,7 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 
 void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 {
+	struct folio *folio = page_folio(new);
 	struct vm_area_struct *vma = pvmw->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address = pvmw->address;
@@ -3287,7 +3288,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		return;
 
 	entry = pmd_to_swp_entry(*pvmw->pmd);
-	get_page(new);
+	folio_get(folio);
 	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
@@ -3298,10 +3299,10 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (!is_migration_entry_young(entry))
 		pmde = pmd_mkold(pmde);
 	/* NOTE: this may contain setting soft-dirty on some archs */
-	if (PageDirty(new) && is_migration_entry_dirty(entry))
+	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
 		pmde = pmd_mkdirty(pmde);
 
-	if (PageAnon(new)) {
+	if (folio_test_anon(folio)) {
 		rmap_t rmap_flags = RMAP_COMPOUND;
 
 		if (!is_readable_migration_entry(entry))
@@ -3309,9 +3310,9 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 		page_add_anon_rmap(new, vma, haddr, rmap_flags);
 	} else {
-		page_add_file_rmap(new, vma, true);
+		folio_add_file_rmap_pmd(folio, new, vma);
 	}
-	VM_BUG_ON(pmd_write(pmde) && PageAnon(new) && !PageAnonExclusive(new));
+	VM_BUG_ON(pmd_write(pmde) && folio_test_anon(folio) && !PageAnonExclusive(new));
 	set_pmd_at(mm, haddr, pvmw->pmd, pmde);
 
 	/* No need to invalidate - it was non-present before */
-- 
2.41.0

