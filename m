Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5480D047
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjLKP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344672AbjLKP6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC19D63
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8cPKSG16Q/IRVzSDalc66DZf+rAdIx9s1sCKVbyMk0=;
        b=bkQgCc7iScm601TY+SP2/nIMXhGFSByz/BeCUoNQklTwje7J524ass4Py91+umjwUZAskU
        36s1fkOsejZ3oR05R8+6I5xDKw+jdVLLvmLMa53LQBeg1miAs/6iNZTaiO6kqaiAbqdq4u
        CJOeOlC5Xoc7F1dfMIQ5NAQd8sfkl3c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-Qc9Fji3rOuid9DMrJtMfFQ-1; Mon,
 11 Dec 2023 10:58:08 -0500
X-MC-Unique: Qc9Fji3rOuid9DMrJtMfFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA5991C08BA2;
        Mon, 11 Dec 2023 15:58:07 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCEA41121306;
        Mon, 11 Dec 2023 15:58:05 +0000 (UTC)
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
Subject: [PATCH v1 28/39] mm/memory: page_remove_rmap() -> folio_remove_rmap_pte()
Date:   Mon, 11 Dec 2023 16:56:41 +0100
Message-ID: <20231211155652.131054-29-david@redhat.com>
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

Let's convert zap_pte_range() and closely-related
tlb_flush_rmap_batch(). While at it, perform some more folio conversion
in zap_pte_range().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c     | 23 +++++++++++++----------
 mm/mmu_gather.c |  2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 97e064883992..9a5724cf895f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1434,6 +1434,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = ptep_get(pte);
+		struct folio *folio;
 		struct page *page;
 
 		if (pte_none(ptent))
@@ -1459,21 +1460,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			}
 
+			folio = page_folio(page);
 			delay_rmap = 0;
-			if (!PageAnon(page)) {
+			if (!folio_test_anon(folio)) {
 				if (pte_dirty(ptent)) {
-					set_page_dirty(page);
+					folio_set_dirty(folio);
 					if (tlb_delay_rmap(tlb)) {
 						delay_rmap = 1;
 						force_flush = 1;
 					}
 				}
 				if (pte_young(ptent) && likely(vma_has_recency(vma)))
-					mark_page_accessed(page);
+					folio_mark_accessed(folio);
 			}
 			rss[mm_counter(page)]--;
 			if (!delay_rmap) {
-				page_remove_rmap(page, vma, false);
+				folio_remove_rmap_pte(folio, page, vma);
 				if (unlikely(page_mapcount(page) < 0))
 					print_bad_pte(vma, addr, ptent, page);
 			}
@@ -1489,6 +1491,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (is_device_private_entry(entry) ||
 		    is_device_exclusive_entry(entry)) {
 			page = pfn_swap_entry_to_page(entry);
+			folio = page_folio(page);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
 			/*
@@ -1500,8 +1503,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			WARN_ON_ONCE(!vma_is_anonymous(vma));
 			rss[mm_counter(page)]--;
 			if (is_device_private_entry(entry))
-				page_remove_rmap(page, vma, false);
-			put_page(page);
+				folio_remove_rmap_pte(folio, page, vma);
+			folio_put(folio);
 		} else if (!non_swap_entry(entry)) {
 			/* Genuine swap entry, hence a private anon page */
 			if (!should_zap_cows(details))
@@ -3220,10 +3223,10 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * threads.
 			 *
 			 * The critical issue is to order this
-			 * page_remove_rmap with the ptp_clear_flush above.
-			 * Those stores are ordered by (if nothing else,)
+			 * folio_remove_rmap_pte() with the ptp_clear_flush
+			 * above. Those stores are ordered by (if nothing else,)
 			 * the barrier present in the atomic_add_negative
-			 * in page_remove_rmap.
+			 * in folio_remove_rmap_pte();
 			 *
 			 * Then the TLB flush in ptep_clear_flush ensures that
 			 * no process can access the old page before the
@@ -3232,7 +3235,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * mapcount is visible. So transitively, TLBs to
 			 * old page will be flushed before it can be reused.
 			 */
-			page_remove_rmap(vmf->page, vma, false);
+			folio_remove_rmap_pte(old_folio, vmf->page, vma);
 		}
 
 		/* Free the old page.. */
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 4f559f4ddd21..604ddf08affe 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -55,7 +55,7 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_
 
 		if (encoded_page_flags(enc)) {
 			struct page *page = encoded_page_ptr(enc);
-			page_remove_rmap(page, vma, false);
+			folio_remove_rmap_pte(page_folio(page), page, vma);
 		}
 	}
 }
-- 
2.43.0

