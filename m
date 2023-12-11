Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B780D044
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbjLKP6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344654AbjLKP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE511A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3iv72ytjW+obJugegMCmaB6S7PQkIGz8PWP7EAJvF9c=;
        b=VAHG4LjxX/ttdv1nerhq1cbTydsDcfyUIomsJ5msHCZaPWUVWjskezoXzanY6CpiKEUfVj
        S/U35hVnJ8IGmTi0ipFGVGMbIjya1sFSDWyJFA8mFD2myARZ4tGBcTIcMEz/o0jA3qyI7w
        iAePnpUmH2UE49VCKEi1zJF4g/3jwig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-jn5rk51mP9GOulr35P-yuw-1; Mon, 11 Dec 2023 10:58:00 -0500
X-MC-Unique: jn5rk51mP9GOulr35P-yuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2A9610133AE;
        Mon, 11 Dec 2023 15:57:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35F591121306;
        Mon, 11 Dec 2023 15:57:57 +0000 (UTC)
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
Subject: [PATCH v1 25/39] mm/huge_memory: page_remove_rmap() -> folio_remove_rmap_pmd()
Date:   Mon, 11 Dec 2023 16:56:38 +0100
Message-ID: <20231211155652.131054-26-david@redhat.com>
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

Let's convert zap_huge_pmd() and set_pmd_migration_entry(). While at it,
perform some more folio conversion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b03374d1bb94..cfaa8b823015 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1898,7 +1898,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (pmd_present(orig_pmd)) {
 			page = pmd_page(orig_pmd);
-			page_remove_rmap(page, vma, true);
+			folio_remove_rmap_pmd(page_folio(page), page, vma);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
 		} else if (thp_migration_supported()) {
@@ -2433,12 +2433,13 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			page = pfn_swap_entry_to_page(entry);
 		} else {
 			page = pmd_page(old_pmd);
-			if (!PageDirty(page) && pmd_dirty(old_pmd))
-				set_page_dirty(page);
-			if (!PageReferenced(page) && pmd_young(old_pmd))
-				SetPageReferenced(page);
-			page_remove_rmap(page, vma, true);
-			put_page(page);
+			folio = page_folio(page);
+			if (!folio_test_dirty(folio) && pmd_dirty(old_pmd))
+				folio_set_dirty(folio);
+			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
+				folio_set_referenced(folio);
+			folio_remove_rmap_pmd(folio, page, vma);
+			folio_put(folio);
 		}
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
@@ -2593,7 +2594,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	pte_unmap(pte - 1);
 
 	if (!pmd_migration)
-		page_remove_rmap(page, vma, true);
+		folio_remove_rmap_pmd(folio, page, vma);
 	if (freeze)
 		put_page(page);
 
@@ -3536,6 +3537,7 @@ late_initcall(split_huge_pages_debugfs);
 int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct vm_area_struct *vma = pvmw->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address = pvmw->address;
@@ -3551,14 +3553,14 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
 
 	/* See page_try_share_anon_rmap(): invalidate PMD first. */
-	anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
+	anon_exclusive = folio_test_anon(folio) && PageAnonExclusive(page);
 	if (anon_exclusive && page_try_share_anon_rmap(page)) {
 		set_pmd_at(mm, address, pvmw->pmd, pmdval);
 		return -EBUSY;
 	}
 
 	if (pmd_dirty(pmdval))
-		set_page_dirty(page);
+		folio_set_dirty(folio);
 	if (pmd_write(pmdval))
 		entry = make_writable_migration_entry(page_to_pfn(page));
 	else if (anon_exclusive)
@@ -3575,8 +3577,8 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	if (pmd_uffd_wp(pmdval))
 		pmdswp = pmd_swp_mkuffd_wp(pmdswp);
 	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
-	page_remove_rmap(page, vma, true);
-	put_page(page);
+	folio_remove_rmap_pmd(folio, page, vma);
+	folio_put(folio);
 	trace_set_migration_pmd(address, pmd_val(pmdswp));
 
 	return 0;
-- 
2.43.0

