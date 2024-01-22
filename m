Return-Path: <linux-kernel+bounces-34078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0748372F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2007A28C2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C226405F8;
	Mon, 22 Jan 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJeqeHTC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A4481BC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952585; cv=none; b=fXjE4rD9RA3QAPCAyiMjclYWohtW5visMqWwe/BMAYauoI08d+YMl3iQGO/O2LHgde8WhU7PFsLhFLduXE/E/UavAoO9PKeGFDsBlMKuJ3xIYZ95xq94x1AqII3LKU/sZDTvps22/pn94Sc00wsi9qtYuDwJzsL3REIhpv8W1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952585; c=relaxed/simple;
	bh=fPkEDAlAPODumzxVEMCPCCTfIyiW/SxnVVpJfM3vEJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENizfEWpI3WH6AX56Sd8l2I+KG0oBJIhHv2nUiSImhnsn8tdKa6sKs58f/FpVCOYvbOcVIx5FSxJ7xCoxiDTIlkLPCJ896Vv8Qyvk37Yza6fTkYen+FR/t02DHa4oCWLtJR407/Q/xab/uBfG7F29+wYAYkQQmZHAmxFvbt2mSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJeqeHTC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705952583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zE4dQFotU52w5fdTyhT0mbQikQr5RVENH6sHZzse5Ds=;
	b=RJeqeHTCheP9jiUl6pZ+hZRBvJfQ2j+vW/T/d6u0ZH1gANk6g6IQBx3H09KIwdpbFYQKUD
	FxmcPCUy3fQhcdq29OzQJfAiCCgiCvvPw78WTsrmVjdotuyv9Oeb04RzMmN0Vab5AAWtJ0
	FJik0sHZEEMxWlA9JH/5bhZ0wB/SXTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-qUji4n2QNQWDdxOalZIvKw-1; Mon, 22 Jan 2024 14:42:59 -0500
X-MC-Unique: qUji4n2QNQWDdxOalZIvKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24D858871C8;
	Mon, 22 Jan 2024 19:42:58 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 492083C2E;
	Mon, 22 Jan 2024 19:42:52 +0000 (UTC)
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
Subject: [PATCH v1 09/11] mm/memory: optimize fork() with PTE-mapped THP
Date: Mon, 22 Jan 2024 20:41:58 +0100
Message-ID: <20240122194200.381241-10-david@redhat.com>
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

Let's implement PTE batching when consecutive (present) PTEs map
consecutive pages of the same large folio, and all other PTE bits besides
the PFNs are equal.

We will optimize folio_pte_batch() separately, to ignore some other
PTE bits. This patch is based on work by Ryan Roberts.

Use __always_inline for __copy_present_ptes() and keep the handling for
single PTEs completely separate from the multi-PTE case: we really want
the compiler to optimize for the single-PTE case with small folios, to
not degrade performance.

Note that PTE batching will never exceed a single page table and will
always stay within VMA boundaries.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pgtable.h |  17 +++++-
 mm/memory.c             | 113 +++++++++++++++++++++++++++++++++-------
 2 files changed, 109 insertions(+), 21 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f6d0e3513948a..d32cedf6936ba 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -212,8 +212,6 @@ static inline int pmd_dirty(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
-#ifndef set_ptes
-
 #ifndef pte_next_pfn
 static inline pte_t pte_next_pfn(pte_t pte)
 {
@@ -221,6 +219,7 @@ static inline pte_t pte_next_pfn(pte_t pte)
 }
 #endif
 
+#ifndef set_ptes
 /**
  * set_ptes - Map consecutive pages to a contiguous range of addresses.
  * @mm: Address space to map the pages into.
@@ -650,6 +649,20 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 }
 #endif
 
+#ifndef wrprotect_ptes
+static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, unsigned int nr)
+{
+	for (;;) {
+		ptep_set_wrprotect(mm, addr, ptep);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+#endif
+
 /*
  * On some architectures hardware does not set page access bit when accessing
  * memory page, it is responsibility of software setting this bit. It brings
diff --git a/mm/memory.c b/mm/memory.c
index 185b4aff13d62..f563aec85b2a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -930,15 +930,15 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	return 0;
 }
 
-static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
+static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, pte_t *dst_pte, pte_t *src_pte,
-		pte_t pte, unsigned long addr)
+		pte_t pte, unsigned long addr, int nr)
 {
 	struct mm_struct *src_mm = src_vma->vm_mm;
 
 	/* If it's a COW mapping, write protect it both processes. */
 	if (is_cow_mapping(src_vma->vm_flags) && pte_write(pte)) {
-		ptep_set_wrprotect(src_mm, addr, src_pte);
+		wrprotect_ptes(src_mm, addr, src_pte, nr);
 		pte = pte_wrprotect(pte);
 	}
 
@@ -950,26 +950,94 @@ static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_clear_uffd_wp(pte);
 
-	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
+	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
+}
+
+/*
+ * Detect a PTE batch: consecutive (present) PTEs that map consecutive
+ * pages of the same folio.
+ *
+ * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.
+ */
+static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
+		pte_t *start_ptep, pte_t pte, int max_nr)
+{
+	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
+	const pte_t *end_ptep = start_ptep + max_nr;
+	pte_t expected_pte = pte_next_pfn(pte);
+	pte_t *ptep = start_ptep + 1;
+
+	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
+
+	while (ptep != end_ptep) {
+		pte = ptep_get(ptep);
+
+		if (!pte_same(pte, expected_pte))
+			break;
+
+		/*
+		 * Stop immediately once we reached the end of the folio. In
+		 * corner cases the next PFN might fall into a different
+		 * folio.
+		 */
+		if (pte_pfn(pte) == folio_end_pfn)
+			break;
+
+		expected_pte = pte_next_pfn(expected_pte);
+		ptep++;
+	}
+
+	return ptep - start_ptep;
 }
 
 /*
- * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
- * is required to copy this pte.
+ * Copy one present PTE, trying to batch-process subsequent PTEs that map
+ * consecutive pages of the same folio by copying them as well.
+ *
+ * Returns -EAGAIN if one preallocated page is required to copy the next PTE.
+ * Otherwise, returns the number of copied PTEs (at least 1).
  */
 static inline int
-copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		 pte_t *dst_pte, pte_t *src_pte, pte_t pte, unsigned long addr,
-		 int *rss, struct folio **prealloc)
+		 int max_nr, int *rss, struct folio **prealloc)
 {
 	struct page *page;
 	struct folio *folio;
+	int err, nr;
 
 	page = vm_normal_page(src_vma, addr, pte);
 	if (unlikely(!page))
 		goto copy_pte;
 
 	folio = page_folio(page);
+
+	/*
+	 * If we likely have to copy, just don't bother with batching. Make
+	 * sure that the common "small folio" case stays as fast as possible
+	 * by keeping the batching logic separate.
+	 */
+	if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
+		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr);
+		if (folio_test_anon(folio)) {
+			folio_ref_add(folio, nr);
+			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
+								  nr, src_vma))) {
+				folio_ref_sub(folio, nr);
+				return -EAGAIN;
+			}
+			rss[MM_ANONPAGES] += nr;
+			VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
+		} else {
+			folio_ref_add(folio, nr);
+			folio_dup_file_rmap_ptes(folio, page, nr);
+			rss[mm_counter_file(page)] += nr;
+		}
+		__copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte, pte,
+				    addr, nr);
+		return nr;
+	}
+
 	if (folio_test_anon(folio)) {
 		/*
 		 * If this page may have been pinned by the parent process,
@@ -981,8 +1049,9 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		if (unlikely(folio_try_dup_anon_rmap_pte(folio, page, src_vma))) {
 			/* Page may be pinned, we have to copy. */
 			folio_put(folio);
-			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
-						 addr, rss, prealloc, page);
+			err = copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
+						addr, rss, prealloc, page);
+			return err ? err : 1;
 		}
 		rss[MM_ANONPAGES]++;
 		VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
@@ -993,8 +1062,8 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	}
 
 copy_pte:
-	__copy_present_pte(dst_vma, src_vma, dst_pte, src_pte, pte, addr);
-	return 0;
+	__copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte, pte, addr, 1);
+	return 1;
 }
 
 static inline struct folio *folio_prealloc(struct mm_struct *src_mm,
@@ -1031,10 +1100,11 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	pte_t *src_pte, *dst_pte;
 	pte_t ptent;
 	spinlock_t *src_ptl, *dst_ptl;
-	int progress, ret = 0;
+	int progress, max_nr, ret = 0;
 	int rss[NR_MM_COUNTERS];
 	swp_entry_t entry = (swp_entry_t){0};
 	struct folio *prealloc = NULL;
+	int nr;
 
 again:
 	progress = 0;
@@ -1065,6 +1135,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	arch_enter_lazy_mmu_mode();
 
 	do {
+		nr = 1;
+
 		/*
 		 * We are holding two locks at this point - either of them
 		 * could generate latencies in another task on another CPU.
@@ -1101,9 +1173,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			 */
 			WARN_ON_ONCE(ret != -ENOENT);
 		}
-		/* copy_present_pte() will clear `*prealloc' if consumed */
-		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
-				       ptent, addr, rss, &prealloc);
+		/* copy_present_ptes() will clear `*prealloc' if consumed */
+		max_nr = (end - addr) / PAGE_SIZE;
+		ret = copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte,
+					ptent, addr, max_nr, rss, &prealloc);
 		/*
 		 * If we need a pre-allocated page for this pte, drop the
 		 * locks, allocate, and try again.
@@ -1120,8 +1193,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			folio_put(prealloc);
 			prealloc = NULL;
 		}
-		progress += 8;
-	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
+		nr = ret;
+		progress += 8 * nr;
+	} while (dst_pte += nr, src_pte += nr, addr += PAGE_SIZE * nr,
+		 addr != end);
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_src_pte, src_ptl);
@@ -1142,7 +1217,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		prealloc = folio_prealloc(src_mm, src_vma, addr, false);
 		if (!prealloc)
 			return -ENOMEM;
-	} else if (ret) {
+	} else if (ret < 0) {
 		VM_WARN_ON_ONCE(1);
 	}
 
-- 
2.43.0


