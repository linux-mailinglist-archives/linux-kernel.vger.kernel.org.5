Return-Path: <linux-kernel+bounces-7545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E481A968
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050551F2444B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB924F1EB;
	Wed, 20 Dec 2023 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOSVm+Zy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD244EB5D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mS0pWaBCqy9h91FWQHLx11u81chGpDs+z9F+Kww2vxc=;
	b=ZOSVm+Zy5YNGsxAyI/NPeK8LabP7933Z3TETlTXG399oxkuW7yYRZGiA01uYOVt3ePs3yu
	BSaSHMPxX7DvR+sc4Qe+UUGcHC2Zbvma7Ko0lwR33BKyZfJLO4PiKvkcndInl1WIX8FUlj
	DQ/vL8QvpDHDexzYy/VtXBpUBVFTUzQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509--oVgBcMTPd2G_zQpLfDtjg-1; Wed,
 20 Dec 2023 17:46:02 -0500
X-MC-Unique: -oVgBcMTPd2G_zQpLfDtjg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4742E3C23FCD;
	Wed, 20 Dec 2023 22:46:02 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3692540C6EB9;
	Wed, 20 Dec 2023 22:46:00 +0000 (UTC)
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
Subject: [PATCH v2 21/40] mm/rmap: remove page_add_anon_rmap()
Date: Wed, 20 Dec 2023 23:44:45 +0100
Message-ID: <20231220224504.646757-22-david@redhat.com>
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

All users are gone, remove it and all traces.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  2 --
 mm/rmap.c            | 31 ++++---------------------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b5da3d86200e4..fe7b5a8b0e75b 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -239,8 +239,6 @@ void folio_add_anon_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_add_anon_rmap_ptes(folio, page, 1, vma, address, flags)
 void folio_add_anon_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *, unsigned long address, rmap_t flags);
-void page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long address, rmap_t flags);
 void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
diff --git a/mm/rmap.c b/mm/rmap.c
index 7f380f5a34c90..87415bbf24022 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1270,7 +1270,7 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
 	 * The page's anon-rmap details (mapping and index) are guaranteed to
 	 * be set up correctly at this point.
 	 *
-	 * We have exclusion against page_add_anon_rmap because the caller
+	 * We have exclusion against folio_add_anon_rmap_*() because the caller
 	 * always holds the page locked.
 	 *
 	 * We have exclusion against folio_add_new_anon_rmap because those pages
@@ -1283,29 +1283,6 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
 		       page);
 }
 
-/**
- * page_add_anon_rmap - add pte mapping to an anonymous page
- * @page:	the page to add the mapping to
- * @vma:	the vm area in which the mapping is added
- * @address:	the user virtual address mapped
- * @flags:	the rmap flags
- *
- * The caller needs to hold the pte lock, and the page must be locked in
- * the anon_vma case: to serialize mapping,index checking after setting,
- * and to ensure that PageAnon is not being upgraded racily to PageKsm
- * (but PageKsm is never downgraded to PageAnon).
- */
-void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
-		unsigned long address, rmap_t flags)
-{
-	struct folio *folio = page_folio(page);
-
-	if (likely(!(flags & RMAP_COMPOUND)))
-		folio_add_anon_rmap_pte(folio, page, vma, address, flags);
-	else
-		folio_add_anon_rmap_pmd(folio, page, vma, address, flags);
-}
-
 static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags, enum rmap_level level)
@@ -1419,7 +1396,7 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
  *
- * Like page_add_anon_rmap() but must only be called on *new* folios.
+ * Like folio_add_anon_rmap_*() but must only be called on *new* folios.
  * This means the inc-and-test can be bypassed.
  * The folio does not have to be locked.
  *
@@ -1479,7 +1456,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 	if (nr)
 		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
 
-	/* See comments in page_add_anon_rmap() */
+	/* See comments in folio_add_anon_rmap_*() */
 	if (!folio_test_large(folio))
 		mlock_vma_folio(folio, vma);
 }
@@ -1593,7 +1570,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 
 	/*
 	 * It would be tidy to reset folio_test_anon mapping when fully
-	 * unmapped, but that might overwrite a racing page_add_anon_rmap
+	 * unmapped, but that might overwrite a racing folio_add_anon_rmap_*()
 	 * which increments mapcount after us but sets mapping before us:
 	 * so leave the reset to free_pages_prepare, and remember that
 	 * it's only reliable while mapped.
-- 
2.43.0


