Return-Path: <linux-kernel+bounces-7570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8481AA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B201C208D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0885954D;
	Wed, 20 Dec 2023 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZLLBOJZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9751004
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbXwGjN0pCeXqd5W9uMe29zoEexoygHhqKeEUbLF/bA=;
	b=CZLLBOJZ0IkuaJsw0ElmtXa4zycwdqWDwTH2aQPJ1q52vNizwiTGI9YVUc4jYuW9Qj3/l+
	j79RMjU7JVOi+wuY6aEQWXbASbwG9KycHu1s0l1uobyexHu0irDIP9s1uTI6xFlVjmw0qC
	ius5UMIJmyNdQZ2/04VIf26SmzrDbgo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-jF4_JFJ2M8CdeF3OMNX_YQ-1; Wed, 20 Dec 2023 17:46:15 -0500
X-MC-Unique: jF4_JFJ2M8CdeF3OMNX_YQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11D821019C82;
	Wed, 20 Dec 2023 22:46:15 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E63C540C6EB9;
	Wed, 20 Dec 2023 22:46:12 +0000 (UTC)
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
Subject: [PATCH v2 26/40] mm/khugepaged: page_remove_rmap() -> folio_remove_rmap_pte()
Date: Wed, 20 Dec 2023 23:44:50 +0100
Message-ID: <20231220224504.646757-27-david@redhat.com>
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

Let's convert __collapse_huge_page_copy_succeeded() and
collapse_pte_mapped_thp(). While at it, perform some more folio
conversion in __collapse_huge_page_copy_succeeded().

We can get rid of release_pte_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/khugepaged.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9cdea59fb4c03..15ec9c729ae58 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -494,11 +494,6 @@ static void release_pte_folio(struct folio *folio)
 	folio_putback_lru(folio);
 }
 
-static void release_pte_page(struct page *page)
-{
-	release_pte_folio(page_folio(page));
-}
-
 static void release_pte_pages(pte_t *pte, pte_t *_pte,
 		struct list_head *compound_pagelist)
 {
@@ -687,6 +682,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 						spinlock_t *ptl,
 						struct list_head *compound_pagelist)
 {
+	struct folio *src_folio;
 	struct page *src_page;
 	struct page *tmp;
 	pte_t *_pte;
@@ -708,16 +704,17 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 			}
 		} else {
 			src_page = pte_page(pteval);
-			if (!PageCompound(src_page))
-				release_pte_page(src_page);
+			src_folio = page_folio(src_page);
+			if (!folio_test_large(src_folio))
+				release_pte_folio(src_folio);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
 			 * be disabled to update the per-cpu stats
-			 * inside page_remove_rmap().
+			 * inside folio_remove_rmap_pte().
 			 */
 			spin_lock(ptl);
 			ptep_clear(vma->vm_mm, address, _pte);
-			page_remove_rmap(src_page, vma, false);
+			folio_remove_rmap_pte(src_folio, src_page, vma);
 			spin_unlock(ptl);
 			free_page_and_swap_cache(src_page);
 		}
@@ -1625,7 +1622,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 * PTE dirty? Shmem page is already dirty; file is read-only.
 		 */
 		ptep_clear(mm, addr, pte);
-		page_remove_rmap(page, vma, false);
+		folio_remove_rmap_pte(folio, page, vma);
 		nr_ptes++;
 	}
 
-- 
2.43.0


