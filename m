Return-Path: <linux-kernel+bounces-7590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C9F81AAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6739281568
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47996DD03;
	Wed, 20 Dec 2023 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMu5bPPM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A75644C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Io0fNOjJFUJN+cQn2T3HaexKpR7MvH4XyxQbyfgzgvU=;
	b=KMu5bPPME8GaUknG1Y/BE6CuqDPRV1bTWpApKe1UBlnUvjsw85aUrDL168z8FEeHtG3ZpN
	vNhUKnBX2lhPBpt3RZLU5qIlxZgPogbFrKoYoIG4ihubbKUrj0NqofPCYSAzkJNLawdrkw
	wZ4P5P4fXgLcJywmou5WSqKkD2XMSHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-EEpn4mmfOKyp69_cUJHDvw-1; Wed, 20 Dec 2023 17:46:20 -0500
X-MC-Unique: EEpn4mmfOKyp69_cUJHDvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9284985A588;
	Wed, 20 Dec 2023 22:46:19 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B17A40C6EB9;
	Wed, 20 Dec 2023 22:46:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 28/40] mm/memory: page_remove_rmap() -> folio_remove_rmap_pte()
Date: Wed, 20 Dec 2023 23:44:52 +0100
Message-ID: <20231220224504.646757-29-david@redhat.com>
In-Reply-To: <20231220224504.646757-1-david@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Let's convert zap_pte_range() and closely-related
tlb_flush_rmap_batch(). While at it, perform some more folio conversion
in zap_pte_range().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c     | 23 +++++++++++++----------
 mm/mmu_gather.c |  2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6552ea27b0bfa..eda2181275d9b 100644
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
2.43.0


