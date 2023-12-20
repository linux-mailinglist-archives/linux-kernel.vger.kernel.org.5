Return-Path: <linux-kernel+bounces-7534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0481A955
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D861C22EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520714CB46;
	Wed, 20 Dec 2023 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGjQPSJ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411484CB28
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ofk61e3x6rLiqTTNkmXQTXIg/O8hfjxoFIvAzETbtQ8=;
	b=ZGjQPSJ10g4nK5li01+ZvZOUDCVnFJ/kk8xNCgtlOQRndsyOHQU1JE816/1GuVy+pZEVCQ
	amPg3Sy3qevQ7gH8OoVc27t3Yb169vGJZ4YUmbj/5vjlFyerbl5IIzMPLDxbko4Q0bzqWt
	ot23GFIeIZ0mkCLxf67CH1UWP363EKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-veEaKfenML2oj5fpTRrRZA-1; Wed, 20 Dec 2023 17:45:31 -0500
X-MC-Unique: veEaKfenML2oj5fpTRrRZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B99F863B83;
	Wed, 20 Dec 2023 22:45:30 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 611A040C6EB9;
	Wed, 20 Dec 2023 22:45:28 +0000 (UTC)
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
Subject: [PATCH v2 09/40] mm/huge_memory: page_add_file_rmap() -> folio_add_file_rmap_pmd()
Date: Wed, 20 Dec 2023 23:44:33 +0100
Message-ID: <20231220224504.646757-10-david@redhat.com>
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

Let's convert remove_migration_pmd() and while at it, perform some folio
conversion.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c50dc2e1483fb..bce6f987f36a3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3577,6 +3577,7 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 
 void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 {
+	struct folio *folio = page_folio(new);
 	struct vm_area_struct *vma = pvmw->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address = pvmw->address;
@@ -3588,7 +3589,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		return;
 
 	entry = pmd_to_swp_entry(*pvmw->pmd);
-	get_page(new);
+	folio_get(folio);
 	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
@@ -3599,10 +3600,10 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (!is_migration_entry_young(entry))
 		pmde = pmd_mkold(pmde);
 	/* NOTE: this may contain setting soft-dirty on some archs */
-	if (PageDirty(new) && is_migration_entry_dirty(entry))
+	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
 		pmde = pmd_mkdirty(pmde);
 
-	if (PageAnon(new)) {
+	if (folio_test_anon(folio)) {
 		rmap_t rmap_flags = RMAP_COMPOUND;
 
 		if (!is_readable_migration_entry(entry))
@@ -3610,9 +3611,9 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 		page_add_anon_rmap(new, vma, haddr, rmap_flags);
 	} else {
-		page_add_file_rmap(new, vma, true);
+		folio_add_file_rmap_pmd(folio, new, vma);
 	}
-	VM_BUG_ON(pmd_write(pmde) && PageAnon(new) && !PageAnonExclusive(new));
+	VM_BUG_ON(pmd_write(pmde) && folio_test_anon(folio) && !PageAnonExclusive(new));
 	set_pmd_at(mm, haddr, pvmw->pmd, pmde);
 
 	/* No need to invalidate - it was non-present before */
-- 
2.43.0


