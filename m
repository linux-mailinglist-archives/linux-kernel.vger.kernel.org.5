Return-Path: <linux-kernel+bounces-7602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C34A81AABA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4D61C23283
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790E495E6;
	Wed, 20 Dec 2023 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1EgXdOy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204879466
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eh/NeqNby3APEgZIeJ5Gbh/kC7oqyH0NpFSKRwTjdSA=;
	b=X1EgXdOyFPsmvtIfea/CPW5Zz2voWuHtSd54QeBrrX+MYP9B/gTL9HZqGJRuYSBrpbHKsQ
	cQaQo08h6zF2SSlrRw7I6Bo9PvDQAiEGg6NPKlNfVKX7jxR2FIESD24uvc+asriIffjZFr
	Up+OM8M34e9iwRhFSiTgLVG57Me90pI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-ZfLMWBpIMNiX3NN0QdVaEA-1; Wed,
 20 Dec 2023 17:46:40 -0500
X-MC-Unique: ZfLMWBpIMNiX3NN0QdVaEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 538C13C23FCD;
	Wed, 20 Dec 2023 22:46:39 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1209840C6EBC;
	Wed, 20 Dec 2023 22:46:36 +0000 (UTC)
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
Subject: [PATCH v2 35/40] mm/huge_memory: page_try_dup_anon_rmap() -> folio_try_dup_anon_rmap_pmd()
Date: Wed, 20 Dec 2023 23:44:59 +0100
Message-ID: <20231220224504.646757-36-david@redhat.com>
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

Let's convert copy_huge_pmd() and fixup the comment in copy_huge_pud().
While at it, perform more folio conversion in copy_huge_pmd().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e7bc0f38ddc53..edbca08449357 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1275,6 +1275,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 {
 	spinlock_t *dst_ptl, *src_ptl;
 	struct page *src_page;
+	struct folio *src_folio;
 	pmd_t pmd;
 	pgtable_t pgtable = NULL;
 	int ret = -ENOMEM;
@@ -1341,11 +1342,12 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	src_page = pmd_page(pmd);
 	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
+	src_folio = page_folio(src_page);
 
-	get_page(src_page);
-	if (unlikely(page_try_dup_anon_rmap(src_page, true, src_vma))) {
+	folio_get(src_folio);
+	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, src_vma))) {
 		/* Page maybe pinned: split and retry the fault on PTEs. */
-		put_page(src_page);
+		folio_put(src_folio);
 		pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
@@ -1454,8 +1456,8 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	/*
-	 * TODO: once we support anonymous pages, use page_try_dup_anon_rmap()
-	 * and split if duplicating fails.
+	 * TODO: once we support anonymous pages, use
+	 * folio_try_dup_anon_rmap_*() and split if duplicating fails.
 	 */
 	pudp_set_wrprotect(src_mm, addr, src_pud);
 	pud = pud_mkold(pud_wrprotect(pud));
-- 
2.43.0


