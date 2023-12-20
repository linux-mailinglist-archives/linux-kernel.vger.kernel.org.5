Return-Path: <linux-kernel+bounces-7533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C081A952
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BA41C22E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61EB4C631;
	Wed, 20 Dec 2023 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bb8xDvev"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09774B125
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7RNQidug/EwvaArOE9sRzRSaxqKYQznxGvOG5hZ9FI=;
	b=Bb8xDvevptcNtFYvkKSTKnWMVXa5mLFUr+PZYRjlh5Y+JMvgPd1hcxAh8vD+EwMmAkvLmA
	3Hojw2i2a3FsgXenkxqQowaW8CJJlPpm+tefomU1KU+l2fMJTI9lG0AaBo6K9NkL2Vt6/J
	bQZss4eOp1fwH3Rt8TYbl0XxcR5kZV4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-pT_9TgFiNeKKCpu7Ia4-ig-1; Wed,
 20 Dec 2023 17:45:28 -0500
X-MC-Unique: pT_9TgFiNeKKCpu7Ia4-ig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11CCF1C41B24;
	Wed, 20 Dec 2023 22:45:28 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD23A40C6EB9;
	Wed, 20 Dec 2023 22:45:25 +0000 (UTC)
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
Subject: [PATCH v2 08/40] mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()
Date: Wed, 20 Dec 2023 23:44:32 +0100
Message-ID: <20231220224504.646757-9-david@redhat.com>
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

Let's convert insert_page_into_pte_locked() and do_set_pmd(). While at it,
perform some folio conversion.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7f957e5a84311..c77d3952d261f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1859,12 +1859,14 @@ static int validate_page_before_insert(struct page *page)
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 			unsigned long addr, struct page *page, pgprot_t prot)
 {
+	struct folio *folio = page_folio(page);
+
 	if (!pte_none(ptep_get(pte)))
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
-	get_page(page);
+	folio_get(folio);
 	inc_mm_counter(vma->vm_mm, mm_counter_file(page));
-	page_add_file_rmap(page, vma, false);
+	folio_add_file_rmap_pte(folio, page, vma);
 	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
 	return 0;
 }
@@ -4409,6 +4411,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
@@ -4418,8 +4421,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
 		return ret;
 
-	page = compound_head(page);
-	if (compound_order(page) != HPAGE_PMD_ORDER)
+	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
 		return ret;
 
 	/*
@@ -4428,7 +4430,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	 * check.  This kind of THP just can be PTE mapped.  Access to
 	 * the corrupted subpage should trigger SIGBUS as expected.
 	 */
-	if (unlikely(PageHasHWPoisoned(page)))
+	if (unlikely(folio_test_has_hwpoisoned(folio)))
 		return ret;
 
 	/*
@@ -4452,7 +4454,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
 	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
-	page_add_file_rmap(page, vma, true);
+	folio_add_file_rmap_pmd(folio, page, vma);
 
 	/*
 	 * deposit and withdraw with pmd lock held
-- 
2.43.0


