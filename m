Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6886803674
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbjLDOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbjLDOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:23:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53B1B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWXNFAD1MN3p2bcOLf/LK1onshg4c1syDBwJJ/+GHnY=;
        b=dwT+6TRX6ItsxFnwBsyZx/EDPJpyZGHZPV2lZD7CgFlX+5ASdL7uw51ezPR1pCoaMUQ1o7
        VjPV4ZGpTEkMvv/JRuKi/erQG2NgZgAlB3dPK1Lf0O4XrAZ82Ish6PH+w4SM7p9NtrST0X
        DbX8RRYyo5b36Ao/0vmcOQkZi8rIfYE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-G1DqHr0HMdSb4ua9mh5Iag-1; Mon,
 04 Dec 2023 09:22:42 -0500
X-MC-Unique: G1DqHr0HMdSb4ua9mh5Iag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7F1A29AA3AE;
        Mon,  4 Dec 2023 14:22:41 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C88C2026D4C;
        Mon,  4 Dec 2023 14:22:39 +0000 (UTC)
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
Subject: [PATCH RFC 28/39] mm/memory: page_remove_rmap() -> folio_remove_rmap_pte()
Date:   Mon,  4 Dec 2023 15:21:35 +0100
Message-ID: <20231204142146.91437-29-david@redhat.com>
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

Let's convert zap_pte_range() and closely-related
tlb_flush_rmap_batch(). While at it, perform some more folio conversion
in zap_pte_range().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c     | 23 +++++++++++++----------
 mm/mmu_gather.c |  2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9543b6e2b749b..8c4f98bb617fa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1425,6 +1425,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = ptep_get(pte);
+		struct folio *folio;
 		struct page *page;
 
 		if (pte_none(ptent))
@@ -1450,21 +1451,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
@@ -1480,6 +1482,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (is_device_private_entry(entry) ||
 		    is_device_exclusive_entry(entry)) {
 			page = pfn_swap_entry_to_page(entry);
+			folio = page_folio(page);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
 			/*
@@ -1491,8 +1494,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
@@ -3210,10 +3213,10 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
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
@@ -3222,7 +3225,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * mapcount is visible. So transitively, TLBs to
 			 * old page will be flushed before it can be reused.
 			 */
-			page_remove_rmap(vmf->page, vma, false);
+			folio_remove_rmap_pte(old_folio, vmf->page, vma);
 		}
 
 		/* Free the old page.. */
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 4f559f4ddd217..604ddf08affed 100644
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
2.41.0

