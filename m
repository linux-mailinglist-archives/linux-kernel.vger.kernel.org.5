Return-Path: <linux-kernel+bounces-34081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534938372F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71FF1F2791E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BE048796;
	Mon, 22 Jan 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epISbfNM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D73F8F8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952606; cv=none; b=k3J7nxyn0dmlqSOVN0PcMQ+3YpAiSbHXgYhBVGUf8kKwjbZ+twlRplUOEzYdLgWDSMhirlfYwpmsf6QDjJdJoE0AGewu+c/uBeg3A3VteRIDKrJvRC5dHzSJwDHptuQsd9Whvr4qQdu6i0E4cPHy6r0g+L1zAChpmF/dqg2TEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952606; c=relaxed/simple;
	bh=+D3SaXuaqQwzE9ncRc3UUmq2axp2FJWdRXhF/fUl0+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGKpUJs091VOzgae7Wu+Hpg7WJAcRYkg/mNKSseOHnCnT3hh+JHoX1adNru9F9Vr5KqAxtKKqxWUX8ceKRxOprWkQtfCrz1U50CCgUIA7hJG4CEvVxldBdP4HASKeszseYdgxJe1/zTR8/3Uuf6pqArIVYz1C4+fp+GPLFDaT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epISbfNM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705952604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPsvEkVgYnC21FVdKrk6yuEGSmSqLr856lIR4lg3IVs=;
	b=epISbfNMsFymD8bEd6Gm/XAxGGp/qvluvDYWJZKLuaRZlKTUbkJc9plqovX5P5OAsFL5bP
	VNAdgmM9xuyQRlzHWEhXmStfBWVItleAfwUyeUgIPZRTTKG5SoFrVJ0BYCdxeOiFfCIdmR
	F8bHg61fXVmOLKZxn7f1KTHPJio/pfI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-YpW0JN5UPxiQRu3cMsFdBw-1; Mon, 22 Jan 2024 14:43:18 -0500
X-MC-Unique: YpW0JN5UPxiQRu3cMsFdBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2508C87A38D;
	Mon, 22 Jan 2024 19:43:15 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 192C124ED;
	Mon, 22 Jan 2024 19:43:08 +0000 (UTC)
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
Subject: [PATCH v1 11/11] mm/memory: ignore writable bit in folio_pte_batch()
Date: Mon, 22 Jan 2024 20:42:00 +0100
Message-ID: <20240122194200.381241-12-david@redhat.com>
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

.. and conditionally return to the caller if any pte except the first one
is writable. fork() has to make sure to properly write-protect in case any
PTE is writable. Other users (e.g., page unmaping) won't care.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 341b2be845b6e..a26fd0669016b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -955,7 +955,7 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
 
 static inline pte_t __pte_batch_clear_ignored(pte_t pte)
 {
-	return pte_clear_soft_dirty(pte_mkclean(pte_mkold(pte)));
+	return pte_wrprotect(pte_clear_soft_dirty(pte_mkclean(pte_mkold(pte))));
 }
 
 /*
@@ -963,20 +963,29 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte)
  * pages of the same folio.
  *
  * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.
- * the accessed bit, dirty bit and soft-dirty bit.
+ * the accessed bit, dirty bit, soft-dirty bit and writable bit.
+ . If "any_writable" is set, it will indicate if any other PTE besides the
+ * first (given) PTE is writable.
  */
 static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
-		pte_t *start_ptep, pte_t pte, int max_nr)
+		pte_t *start_ptep, pte_t pte, int max_nr, bool *any_writable)
 {
 	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte));
 	pte_t *ptep = start_ptep + 1;
+	bool writable;
+
+	if (any_writable)
+		*any_writable = false;
 
 	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
 
 	while (ptep != end_ptep) {
-		pte = __pte_batch_clear_ignored(ptep_get(ptep));
+		pte = ptep_get(ptep);
+		if (any_writable)
+			writable = !!pte_write(pte);
+		pte = __pte_batch_clear_ignored(pte);
 
 		if (!pte_same(pte, expected_pte))
 			break;
@@ -989,6 +998,9 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		if (pte_pfn(pte) == folio_end_pfn)
 			break;
 
+		if (any_writable)
+			*any_writable |= writable;
+
 		expected_pte = pte_next_pfn(expected_pte);
 		ptep++;
 	}
@@ -1010,6 +1022,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 {
 	struct page *page;
 	struct folio *folio;
+	bool any_writable;
 	int err, nr;
 
 	page = vm_normal_page(src_vma, addr, pte);
@@ -1024,7 +1037,8 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	 * by keeping the batching logic separate.
 	 */
 	if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
-		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr);
+		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr,
+				     &any_writable);
 		if (folio_test_anon(folio)) {
 			folio_ref_add(folio, nr);
 			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
@@ -1039,6 +1053,8 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 			folio_dup_file_rmap_ptes(folio, page, nr);
 			rss[mm_counter_file(page)] += nr;
 		}
+		if (any_writable)
+			pte = pte_mkwrite(pte, src_vma);
 		__copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte, pte,
 				    addr, nr);
 		return nr;
-- 
2.43.0


