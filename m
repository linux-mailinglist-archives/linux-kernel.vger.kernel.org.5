Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C159780D032
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344464AbjLKP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344491AbjLKP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FA4FF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFC4IqKosk2274JfAmIWQYXkgsQjdSCIu6Bum/spFuM=;
        b=BSFDW9HYPtLkYPg1P1jLd5BlFFZpPfadHrUDRrkiG1E3v1gpvFa4Ub12PpgnBeV74lEA2p
        r2SDtCSea7j84RuTnjX11onFxgYYyJk5jJDYY+Iy3bvmkl4LOO7WNOZLIruPwl8FZLrUQd
        3hBEh8fW0+9PxVgI1CmN0uDCwhJ2nm0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-HfiNUATqMv-A-RIgHEr9kQ-1; Mon, 11 Dec 2023 10:57:20 -0500
X-MC-Unique: HfiNUATqMv-A-RIgHEr9kQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B132B870830;
        Mon, 11 Dec 2023 15:57:19 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B9311121306;
        Mon, 11 Dec 2023 15:57:17 +0000 (UTC)
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
Subject: [PATCH v1 09/39] mm/huge_memory: page_add_file_rmap() -> folio_add_file_rmap_pmd()
Date:   Mon, 11 Dec 2023 16:56:22 +0100
Message-ID: <20231211155652.131054-10-david@redhat.com>
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

Let's convert remove_migration_pmd() and while at it, perform some folio
conversion.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3a387c6f18b6..1f5634b2f374 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3577,6 +3577,7 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 
 void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 {
+	struct folio *folio = page_folio(new);
 	struct vm_area_struct *vma = pvmw->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address = pvmw->address;
@@ -3588,7 +3589,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		return;
 
 	entry = pmd_to_swp_entry(*pvmw->pmd);
-	get_page(new);
+	folio_get(folio);
 	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
@@ -3599,10 +3600,10 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
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
@@ -3610,9 +3611,9 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
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
2.43.0

