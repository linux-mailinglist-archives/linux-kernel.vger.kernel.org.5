Return-Path: <linux-kernel+bounces-39192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B39E83CC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03271C23679
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CC13AA2F;
	Thu, 25 Jan 2024 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6G4nsp+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02E137C41
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211228; cv=none; b=ly7ebO5ocCca3vT4yXyjg/kMcotBLla5ns15iLyc53tG7Bzd4rATlnx2J1LOX4zn6C2qVOVblwdyPTsLP4VyCZhzJlnXIzKF32wUT3e00w41sWk6RydxV/wtrI7i+t9usi1xPDnxBynnvwSjt5HAvwmcTdM2RwHkLQ2OFBaS/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211228; c=relaxed/simple;
	bh=jFvxDvMCUuRleg4b4uXwFulr+9I6bJoh7tuuFWyWIOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/taxRIUW9zeIjyloIZFfwTr9EZEGecszuSMCsuVph2feeuHmhxrzvmohrMUcXZ27RL/TRkyq73oCrn1kaAVp4fSj33adorHwdVgef0wDXiW09XEohgTmcuvB6Q5hES3cpWJfG7xREia78r1/v9Kcj9sYp/lsk14Umqfk/0PIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6G4nsp+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706211225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3s1Jv/6P5yjhblLF2udczJAUFVvnCKFeQLjRuwj24+c=;
	b=O6G4nsp+f9m150UyKJv1GWw9i0fAeRALLAHzYgNfqUWdPscvD7ksmuvG0Y5m+JOb6qBRhJ
	RdbrYU5sDTLYU1c5wHrpfqM13tadqo0JA14qJ3MArBYGb0hk98U56d+Ou0CvDk03bZvxpC
	hB47h+m91TiejNzhnzn1Wd3eFlu3qnc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-493L1nvTPrqpYIPc57u-fA-1; Thu, 25 Jan 2024 14:33:42 -0500
X-MC-Unique: 493L1nvTPrqpYIPc57u-fA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34A868432A1;
	Thu, 25 Jan 2024 19:33:41 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.154])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 074EA492BC9;
	Thu, 25 Jan 2024 19:33:34 +0000 (UTC)
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
Subject: [PATCH v2 11/15] mm/memory: factor out copying the actual PTE in copy_present_pte()
Date: Thu, 25 Jan 2024 20:32:23 +0100
Message-ID: <20240125193227.444072-12-david@redhat.com>
In-Reply-To: <20240125193227.444072-1-david@redhat.com>
References: <20240125193227.444072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Let's prepare for further changes.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 63 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463aa..10fc14ff8e49b 100644
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
@@ -939,23 +962,23 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
+	folio_get(folio);
+	if (folio_test_anon(folio)) {
 		/*
 		 * If this page may have been pinned by the parent process,
 		 * copy the page immediately for the child so that we'll always
 		 * guarantee the pinned page won't be randomly replaced in the
 		 * future.
 		 */
-		folio_get(folio);
 		if (unlikely(folio_try_dup_anon_rmap_pte(folio, page, src_vma))) {
 			/* Page may be pinned, we have to copy. */
 			folio_put(folio);
@@ -963,34 +986,14 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 						 addr, rss, prealloc, page);
 		}
 		rss[MM_ANONPAGES]++;
-	} else if (page) {
-		folio_get(folio);
+		VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
+	} else {
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


