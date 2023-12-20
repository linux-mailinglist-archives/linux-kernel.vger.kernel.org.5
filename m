Return-Path: <linux-kernel+bounces-7592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F251F81AAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313101C22D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014606E2D2;
	Wed, 20 Dec 2023 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c09fI4Pq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64C5647C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKdh92e0zNAps0SI5GoWH5U4FWHuHogZgqgLcAEKNJQ=;
	b=c09fI4PqxnrMnoRagGB01ycO9Sxmg+fS0vhg/v00GP+XC+bQWcabOTxZWCOXJTnsHCZ18n
	PK7LajEf6HzeIoq9wxz6Q1b+WsHpGKpZ6qHvYZ0AiQKtzmuCjBCXNK6nAgtn2tJfQxBntL
	y2UlfGMVNg4nHJm36a0S3ZWhyH+48N4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-nZxpfJamMleZQ6ECjJXe1Q-1; Wed, 20 Dec 2023 17:46:23 -0500
X-MC-Unique: nZxpfJamMleZQ6ECjJXe1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87B8A86EB22;
	Wed, 20 Dec 2023 22:46:22 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0D2E40C6EB9;
	Wed, 20 Dec 2023 22:46:19 +0000 (UTC)
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
Subject: [PATCH v2 29/40] mm/migrate_device: page_remove_rmap() -> folio_remove_rmap_pte()
Date: Wed, 20 Dec 2023 23:44:53 +0100
Message-ID: <20231220224504.646757-30-david@redhat.com>
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

Let's convert migrate_vma_collect_pmd(). While at it, perform more
folio conversion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate_device.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 81193363f8cd5..39b7754480c67 100644
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
2.43.0


