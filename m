Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69728803676
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjLDOY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345176AbjLDOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:23:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F61BFC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nn9t1WIxRvDYJbnLiLQ2NH5amWMopIWzrUXghX6hcqw=;
        b=Ow/RMhuUyTobkGQavgMwZLbniXwskRrAB2zwxIm0MGm5WPB1sAhu0Ep+b0hYlcoS1pS4wC
        dPr/GRZtgAlUZ2Jz/HyGWg1pGf/uBVFui2uaff0XOBcO6+vokuzJ+0rJ/LdnSFSDEx0XC/
        +kFUYfzKRfAV9fIADFvyx2l7EKWVSQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-UIUYp5yyP5WVSRDqwEYaRg-1; Mon, 04 Dec 2023 09:22:44 -0500
X-MC-Unique: UIUYp5yyP5WVSRDqwEYaRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C4E68F9204;
        Mon,  4 Dec 2023 14:22:43 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1A552026D68;
        Mon,  4 Dec 2023 14:22:41 +0000 (UTC)
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
Subject: [PATCH RFC 29/39] mm/migrate_device: page_remove_rmap() -> folio_remove_rmap_pte()
Date:   Mon,  4 Dec 2023 15:21:36 +0100
Message-ID: <20231204142146.91437-30-david@redhat.com>
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

Let's convert migrate_vma_collect_pmd(). While at it, perform more
folio conversion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate_device.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 8ac1f79f754a2..c51c99151ebb5 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -107,6 +107,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
 		unsigned long mpfn = 0, pfn;
+		struct folio *folio;
 		struct page *page;
 		swp_entry_t entry;
 		pte_t pte;
@@ -168,41 +169,43 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		}
 
 		/*
-		 * By getting a reference on the page we pin it and that blocks
+		 * By getting a reference on the folio we pin it and that blocks
 		 * any kind of migration. Side effect is that it "freezes" the
 		 * pte.
 		 *
-		 * We drop this reference after isolating the page from the lru
-		 * for non device page (device page are not on the lru and thus
+		 * We drop this reference after isolating the folio from the lru
+		 * for non device folio (device folio are not on the lru and thus
 		 * can't be dropped from it).
 		 */
-		get_page(page);
+		folio = page_folio(page);
+		folio_get(folio);
 
 		/*
-		 * We rely on trylock_page() to avoid deadlock between
+		 * We rely on folio_trylock() to avoid deadlock between
 		 * concurrent migrations where each is waiting on the others
-		 * page lock. If we can't immediately lock the page we fail this
+		 * folio lock. If we can't immediately lock the folio we fail this
 		 * migration as it is only best effort anyway.
 		 *
-		 * If we can lock the page it's safe to set up a migration entry
-		 * now. In the common case where the page is mapped once in a
+		 * If we can lock the folio it's safe to set up a migration entry
+		 * now. In the common case where the folio is mapped once in a
 		 * single process setting up the migration entry now is an
 		 * optimisation to avoid walking the rmap later with
 		 * try_to_migrate().
 		 */
-		if (trylock_page(page)) {
+		if (folio_trylock(folio)) {
 			bool anon_exclusive;
 			pte_t swp_pte;
 
 			flush_cache_page(vma, addr, pte_pfn(pte));
-			anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
+			anon_exclusive = folio_test_anon(folio) &&
+					  PageAnonExclusive(page);
 			if (anon_exclusive) {
 				pte = ptep_clear_flush(vma, addr, ptep);
 
 				if (page_try_share_anon_rmap(page)) {
 					set_pte_at(mm, addr, ptep, pte);
-					unlock_page(page);
-					put_page(page);
+					folio_unlock(folio);
+					folio_put(folio);
 					mpfn = 0;
 					goto next;
 				}
@@ -214,7 +217,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			/* Set the dirty flag on the folio now the pte is gone. */
 			if (pte_dirty(pte))
-				folio_mark_dirty(page_folio(page));
+				folio_mark_dirty(folio);
 
 			/* Setup special migration page table entry */
 			if (mpfn & MIGRATE_PFN_WRITE)
@@ -248,16 +251,16 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			/*
 			 * This is like regular unmap: we remove the rmap and
-			 * drop page refcount. Page won't be freed, as we took
-			 * a reference just above.
+			 * drop the folio refcount. The folio won't be freed, as
+			 * we took a reference just above.
 			 */
-			page_remove_rmap(page, vma, false);
-			put_page(page);
+			folio_remove_rmap_pte(folio, page, vma);
+			folio_put(folio);
 
 			if (pte_present(pte))
 				unmapped++;
 		} else {
-			put_page(page);
+			folio_put(folio);
 			mpfn = 0;
 		}
 
-- 
2.41.0

