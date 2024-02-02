Return-Path: <linux-kernel+bounces-49435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CAB846A51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C373B1C277B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ED34F8BE;
	Fri,  2 Feb 2024 08:09:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCB54F610
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861382; cv=none; b=twdABk3ADFAsI0JyXAOz/08RHxuUIvhVmattNfba3tDj3EHK0ORhXsPEeUHXXtmjWDlPl1wSZm7Q7nqVmVblkKA7Gw4hSM6SPjC0jn8FCDmEc/KeH/VXtehWDh4dxwb4VbkmobgeQN4gT8/b/9CPGm6f2G+kIu0kmrDqkWbWwlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861382; c=relaxed/simple;
	bh=C8IJsRHAlzi06IQE0cvIeVvZjxgZ//dakiBGdJTsMfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sB2V06TSANeNrb7/3Kb/LHSEwlsmXvlY06oFr6gMQs5b/7RFGJiYgQTrSTV14jFQo+HYcob9X/TVvKQl7nT8pM5OJkslPdyVjVwxGKlN2gB2Znfer5cZPXdZlsXIMwlD8jOnwDjTY09BJjd0URv4eyj0X1u6DXBCEmm4oQCU+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B640A1BD0;
	Fri,  2 Feb 2024 00:10:22 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA6BF3F5A1;
	Fri,  2 Feb 2024 00:09:36 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 22/25] mm: Add pte_batch_hint() to reduce scanning in folio_pte_batch()
Date: Fri,  2 Feb 2024 08:07:53 +0000
Message-Id: <20240202080756.1453939-23-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202080756.1453939-1-ryan.roberts@arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures (e.g. arm64) can tell from looking at a pte, if some
follow-on ptes also map contiguous physical memory with the same pgprot.
(for arm64, these are contpte mappings).

Take advantage of this knowledge to optimize folio_pte_batch() so that
it can skip these ptes when scanning to create a batch. By default, if
an arch does not opt-in, folio_pte_batch() returns a compile-time 1, so
the changes are optimized out and the behaviour is as before.

arm64 will opt-in to providing this hint in the next patch, which will
greatly reduce the cost of ptep_get() when scanning a range of contptes.

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 18 ++++++++++++++++++
 mm/memory.c             | 20 +++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 50f32cccbd92..cba31f177d27 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -212,6 +212,24 @@ static inline int pmd_dirty(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
+#ifndef pte_batch_hint
+/**
+ * pte_batch_hint - Number of pages that can be added to batch without scanning.
+ * @ptep: Page table pointer for the entry.
+ * @pte: Page table entry.
+ *
+ * Some architectures know that a set of contiguous ptes all map the same
+ * contiguous memory with the same permissions. In this case, it can provide a
+ * hint to aid pte batching without the core code needing to scan every pte.
+ *
+ * May be overridden by the architecture, else pte_batch_hint is always 1.
+ */
+static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
+{
+	return 1;
+}
+#endif
+
 #ifndef pte_advance_pfn
 static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 65fbe4f886c1..902665b27702 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -988,16 +988,21 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 {
 	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
 	const pte_t *end_ptep = start_ptep + max_nr;
-	pte_t expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, 1), flags);
-	pte_t *ptep = start_ptep + 1;
+	pte_t expected_pte = __pte_batch_clear_ignored(pte, flags);
+	pte_t *ptep = start_ptep;
 	bool writable;
+	int nr;
 
 	if (any_writable)
 		*any_writable = false;
 
 	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
 
-	while (ptep != end_ptep) {
+	nr = pte_batch_hint(ptep, pte);
+	expected_pte = pte_advance_pfn(expected_pte, nr);
+	ptep += nr;
+
+	while (ptep < end_ptep) {
 		pte = ptep_get(ptep);
 		if (any_writable)
 			writable = !!pte_write(pte);
@@ -1011,17 +1016,18 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		 * corner cases the next PFN might fall into a different
 		 * folio.
 		 */
-		if (pte_pfn(pte) == folio_end_pfn)
+		if (pte_pfn(pte) >= folio_end_pfn)
 			break;
 
 		if (any_writable)
 			*any_writable |= writable;
 
-		expected_pte = pte_advance_pfn(expected_pte, 1);
-		ptep++;
+		nr = pte_batch_hint(ptep, pte);
+		expected_pte = pte_advance_pfn(expected_pte, nr);
+		ptep += nr;
 	}
 
-	return ptep - start_ptep;
+	return min(ptep - start_ptep, max_nr);
 }
 
 /*
-- 
2.25.1


