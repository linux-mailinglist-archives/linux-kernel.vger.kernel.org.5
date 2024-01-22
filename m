Return-Path: <linux-kernel+bounces-34075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491638372FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A623BB2DA5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979247A55;
	Mon, 22 Jan 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS0Qs/Mm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A143FE57
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952574; cv=none; b=DjtU3qULHXSq6yrJpKR3h3L2YusaTeUVVFd2lAAg0pgTI5Ru0kas5PgknG57DUsNYpIxf2nLW1WlkPuW4CggHX+QPeMErTL/BR92gYoFk6QE7o0RuoKxz4k9Z+bAXGpbEkSOhL2qONmsAe0B0/XMejjwNNEQbv6HRU6ogPK8M+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952574; c=relaxed/simple;
	bh=NbEQcOnB7H8EdKo3GSKPQlbo4RmfFSlQlC73a0ZWeIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vyu/wGSc1LFdrMlmKGNkDVZoH3fhooV8r4rzJj7Tb8gDozTBQxiBnqKss1++PiROz9iWQ6ZjPKFF02qjd7CBfGvNeHYLLcNe6b3eitKhfRgPiS8fVj9uGnuy557CAgT9VJ00E2kqNFvRC3BZ049DsqbY+bKBajYLW1uA4dVY9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS0Qs/Mm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705952572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aezdbNXr3jeNg/oq4Ir7c4pnUJMPrBPlV8tZyKwBKMo=;
	b=JS0Qs/MmKwkKUVOnblmSpXiRAtjpFzoGCcTwnDeRxEgvj2Q+DwsBWzJFhIxOuW+fWkig3H
	K0PH+2tNBe4D1pmLeuhXsONO1ZYyudSFy834/pW9JZpGZFGk7YuWeY+FbrPSViLlEORtuz
	MGNV/cJpWe2eiYobNw1KRIhQiCteXuA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-dLhPkRjVM62_BryuXLzoyw-1; Mon,
 22 Jan 2024 14:42:48 -0500
X-MC-Unique: dLhPkRjVM62_BryuXLzoyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 175DA3806063;
	Mon, 22 Jan 2024 19:42:47 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B54363C2E;
	Mon, 22 Jan 2024 19:42:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v1 07/11] mm/memory: factor out copying the actual PTE in copy_present_pte()
Date: Mon, 22 Jan 2024 20:41:56 +0100
Message-ID: <20240122194200.381241-8-david@redhat.com>
In-Reply-To: <20240122194200.381241-1-david@redhat.com>
References: <20240122194200.381241-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Let's prepare for further changes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 60 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463aa..2aa2051ee51d3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -930,6 +930,29 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	return 0;
 }
 
+static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, pte_t *dst_pte, pte_t *src_pte,
+		pte_t pte, unsigned long addr)
+{
+	struct mm_struct *src_mm = src_vma->vm_mm;
+
+	/* If it's a COW mapping, write protect it both processes. */
+	if (is_cow_mapping(src_vma->vm_flags) && pte_write(pte)) {
+		ptep_set_wrprotect(src_mm, addr, src_pte);
+		pte = pte_wrprotect(pte);
+	}
+
+	/* If it's a shared mapping, mark it clean in the child. */
+	if (src_vma->vm_flags & VM_SHARED)
+		pte = pte_mkclean(pte);
+	pte = pte_mkold(pte);
+
+	if (!userfaultfd_wp(dst_vma))
+		pte = pte_clear_uffd_wp(pte);
+
+	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
+}
+
 /*
  * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
  * is required to copy this pte.
@@ -939,16 +962,16 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
 		 struct folio **prealloc)
 {
-	struct mm_struct *src_mm = src_vma->vm_mm;
-	unsigned long vm_flags = src_vma->vm_flags;
 	pte_t pte = ptep_get(src_pte);
 	struct page *page;
 	struct folio *folio;
 
 	page = vm_normal_page(src_vma, addr, pte);
-	if (page)
-		folio = page_folio(page);
-	if (page && folio_test_anon(folio)) {
+	if (unlikely(!page))
+		goto copy_pte;
+
+	folio = page_folio(page);
+	if (folio_test_anon(folio)) {
 		/*
 		 * If this page may have been pinned by the parent process,
 		 * copy the page immediately for the child so that we'll always
@@ -963,34 +986,15 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 						 addr, rss, prealloc, page);
 		}
 		rss[MM_ANONPAGES]++;
-	} else if (page) {
+		VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
+	} else {
 		folio_get(folio);
 		folio_dup_file_rmap_pte(folio, page);
 		rss[mm_counter_file(page)]++;
 	}
 
-	/*
-	 * If it's a COW mapping, write protect it both
-	 * in the parent and the child
-	 */
-	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
-		ptep_set_wrprotect(src_mm, addr, src_pte);
-		pte = pte_wrprotect(pte);
-	}
-	VM_BUG_ON(page && folio_test_anon(folio) && PageAnonExclusive(page));
-
-	/*
-	 * If it's a shared mapping, mark it clean in
-	 * the child
-	 */
-	if (vm_flags & VM_SHARED)
-		pte = pte_mkclean(pte);
-	pte = pte_mkold(pte);
-
-	if (!userfaultfd_wp(dst_vma))
-		pte = pte_clear_uffd_wp(pte);
-
-	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
+copy_pte:
+	__copy_present_pte(dst_vma, src_vma, dst_pte, src_pte, pte, addr);
 	return 0;
 }
 
-- 
2.43.0


