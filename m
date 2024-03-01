Return-Path: <linux-kernel+bounces-88160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987786DE04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630E31C21858
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AA6A345;
	Fri,  1 Mar 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="J7wwGyTD"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197666A014
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284699; cv=none; b=JN52nfzXtVWcb0dDoq2aHuZje+5nDu7Ux6xDtSwgigcBzf55tLZ02PKNS5P7C4pxT8R8x1MjYPcKuUjy6pVO6gKF27TxfoU8nk+XtSssoIYlsAV5P0J4hgELz617KPzC4pvZWeTuEYzNhfcbskOjNps+57/BPxYHUoDdnVCwdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284699; c=relaxed/simple;
	bh=l7/QK0Td6iMIdSgS71BBF/zg1i+GlAsTZZtUi/hBDc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQnoM8qq6VoPQ+axCGMGy9d62pAj0FIhPV3/Kt+4ajgSwdSIilYI7CyYcwvg8gWtPSz+PMP+Hu2bXoo5YfAfVgmGnJhIIk7UCW0kSoWKH0Mlujyp1kvm2ieR9200AzspIsf6LKOpkVQHZyZxu2QkOsuxxhPomiKMgBDuazwL0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=J7wwGyTD; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so19371731fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709284695; x=1709889495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1tNyFTcsXe5j/Xz9tdKUfPkAneqDazbYHB6YPwtZWk=;
        b=J7wwGyTDEb8OPiPO4+X8cBztwaMmPYh7BVnvbzrIYGTJG5u15Jwf26VT9+PdV/lqQC
         wsO1e4PEe6xd9OEr7nznOJBH8HO3Fgx6JSlfQ5Y+Tk0Fps/FceUVwlyS0ejTkEf7n5Ox
         umt7w1nzubpNr5z7m/VqKFYgdHo2+v0l8LNRvyg/axcB3F3XBq0eUpm9PRsDZvHTXbLN
         1OMfhSqD/7zYF57CH/Lj8kwBFpihnloEeNupsPTjLThEUqmZBsGXtGxSgGOTrUognpr9
         Vl9TIkFuNhmUS5ew/+qILYN22cEmlO0mqJEue9YK80XdgRjCJAK9Tvgx+fiH1R04A6je
         wU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284695; x=1709889495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1tNyFTcsXe5j/Xz9tdKUfPkAneqDazbYHB6YPwtZWk=;
        b=ELa8f6Jlq692K3cPR4LzCiFnmibJMovoWuKD/kexVKByLJ4CYsiV/jLuPQLKdeCiYM
         RfDboA2OvOgtF4oa30GEKTxckMZTB/5cWda1Nu38WWGF5afTwzt8Gxhs+HXSOSDA83gI
         LDvUolhXk023FYOsWjb6g5H4q5ldbbjEotIE1yenFA6IADj0uYSgOEEe/MgFBFSr41Yq
         nrnCVj5rl3l5PzEs++31GK4TjoP1CPn/4C3yERNxqadC0jXu2kF2ufxt1YvdQVM/PHUP
         WFvdudxoO/0CbhllLG3x/a+NlORyAE/mNReqbz8iItuUewKQDfgoOEF/xWeymWyqAtif
         J0fg==
X-Forwarded-Encrypted: i=1; AJvYcCW6rqj96W8FgM32VVGDHKYftRmVjR3d53siT9qsJEy4Re+mDv2irl+PqrTjHgJlBhDtQT4mjENn58i+7UQHVm4Ks/TtyxllRRpdPy9w
X-Gm-Message-State: AOJu0Yz5vtWqcVmnKtWuyBapv7irAx8HWIaUByQ0Q6tYx0LfScDtdeaV
	UytqhcbJ5lzTTj+HpDGH2x2k0iuqfWjK8HgNHiOq0Tx+F9qSfkkw60pmPSqFi7E=
X-Google-Smtp-Source: AGHT+IGpqFyv1mrLhJ3nW6qi9rLC4OBLYLmhrJ+wNsqKGTezYuRrvThKSI3wD+ZkJxl8NSkgNWNgvg==
X-Received: by 2002:a05:651c:b1e:b0:2d2:cb34:2e0c with SMTP id b30-20020a05651c0b1e00b002d2cb342e0cmr1088079ljr.10.1709284695243;
        Fri, 01 Mar 2024 01:18:15 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bca54000000b0041290251dc2sm7744159wml.14.2024.03.01.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:18:14 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 3/9] mm: Use common huge_ptep_get() function for riscv/arm64
Date: Fri,  1 Mar 2024 10:14:49 +0100
Message-Id: <20240301091455.246686-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301091455.246686-1-alexghiti@rivosinc.com>
References: <20240301091455.246686-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For that, we need to introduce:

- a new config: ARCH_HAS_CONTPTE,
- a new arch specific function which returns the number of contiguous PTE
  in a mapping and its base page size,
- a pte_cont() helper, only introduced for riscv since we keep the arm64
  naming (contpte) which is more explicit than the riscv's (napot).

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++++
 arch/arm64/mm/hugetlbpage.c      | 55 ++------------------------------
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/hugetlb.h |  2 +-
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/mm/hugetlbpage.c      | 24 --------------
 mm/Kconfig                       |  3 ++
 mm/Makefile                      |  1 +
 mm/contpte.c                     | 45 ++++++++++++++++++++++++++
 10 files changed, 86 insertions(+), 78 deletions(-)
 create mode 100644 mm/contpte.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..5e6bd49169d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,6 +20,7 @@ config ARM64
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_CONTPTE
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 79ce70fbb751..3003a10547de 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1124,6 +1124,37 @@ extern pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
 extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 				    unsigned long addr, pte_t *ptep,
 				    pte_t old_pte, pte_t new_pte);
+
+static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+					      size_t *pgsize)
+{
+	int contig_ptes = 0;
+
+	*pgsize = size;
+
+	switch (size) {
+#ifndef __PAGETABLE_PMD_FOLDED
+	case PUD_SIZE:
+		if (pud_sect_supported())
+			contig_ptes = 1;
+		break;
+#endif
+	case PMD_SIZE:
+		contig_ptes = 1;
+		break;
+	case CONT_PMD_SIZE:
+		*pgsize = PMD_SIZE;
+		contig_ptes = CONT_PMDS;
+		break;
+	case CONT_PTE_SIZE:
+		*pgsize = PAGE_SIZE;
+		contig_ptes = CONT_PTES;
+		break;
+	}
+
+	return contig_ptes;
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 8116ac599f80..6b61714d7726 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -119,57 +119,6 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	return CONT_PTES;
 }
 
-static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
-{
-	int contig_ptes = 0;
-
-	*pgsize = size;
-
-	switch (size) {
-#ifndef __PAGETABLE_PMD_FOLDED
-	case PUD_SIZE:
-		if (pud_sect_supported())
-			contig_ptes = 1;
-		break;
-#endif
-	case PMD_SIZE:
-		contig_ptes = 1;
-		break;
-	case CONT_PMD_SIZE:
-		*pgsize = PMD_SIZE;
-		contig_ptes = CONT_PMDS;
-		break;
-	case CONT_PTE_SIZE:
-		*pgsize = PAGE_SIZE;
-		contig_ptes = CONT_PTES;
-		break;
-	}
-
-	return contig_ptes;
-}
-
-pte_t huge_ptep_get(pte_t *ptep)
-{
-	int ncontig, i;
-	size_t pgsize;
-	pte_t orig_pte = ptep_get(ptep);
-
-	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
-		return orig_pte;
-
-	ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
-	for (i = 0; i < ncontig; i++, ptep++) {
-		pte_t pte = ptep_get(ptep);
-
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
-	}
-	return orig_pte;
-}
-
 /*
  * Changing some bits of contiguous entries requires us to follow a
  * Break-Before-Make approach, breaking the whole contiguous set
@@ -250,7 +199,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long pfn, dpfn;
 	pgprot_t hugeprot;
 
-	ncontig = num_contig_ptes(sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
@@ -397,7 +346,7 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 	int i, ncontig;
 	size_t pgsize;
 
-	ncontig = num_contig_ptes(sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(NULL, sz, &pgsize);
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index dba28a756e63..121183768d1a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -19,6 +19,7 @@ config RISCV
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CONTPTE if RISCV_ISA_SVNAPOT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 20f9c3ba2341..a431a0c0e0fa 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -47,7 +47,7 @@ pte_t huge_ptep_get(pte_t *ptep);
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 
-#endif /*CONFIG_RISCV_ISA_SVNAPOT*/
+#endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
 #include <asm-generic/hugetlb.h>
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 951f3ceb5529..ddff4a56e12d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -302,6 +302,7 @@ static inline unsigned long pte_napot(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_NAPOT;
 }
+#define pte_cont	pte_napot
 
 #define pte_valid_napot(pte)	(pte_present(pte) && pte_napot(pte))
 
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 2477d20c1497..51ec80cf2028 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -3,30 +3,6 @@
 #include <linux/err.h>
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-pte_t huge_ptep_get(pte_t *ptep)
-{
-	unsigned long pte_num;
-	int i;
-	pte_t orig_pte = ptep_get(ptep);
-
-	if (!pte_present(orig_pte) || !pte_napot(orig_pte))
-		return orig_pte;
-
-	pte_num = napot_pte_num(napot_cont_order(orig_pte));
-
-	for (i = 0; i < pte_num; i++, ptep++) {
-		pte_t pte = ptep_get(ptep);
-
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
-	}
-
-	return orig_pte;
-}
-
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 		      struct vm_area_struct *vma,
 		      unsigned long addr,
diff --git a/mm/Kconfig b/mm/Kconfig
index ffc3a2ba3a8c..71d92e6c50d9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1001,6 +1001,9 @@ config IDLE_PAGE_TRACKING
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
+config ARCH_HAS_CONTPTE
+	bool
+
 config ARCH_HAS_CURRENT_STACK_POINTER
 	bool
 	help
diff --git a/mm/Makefile b/mm/Makefile
index e4b5b75aaec9..d5aa9326fc80 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+obj-$(CONFIG_ARCH_HAS_CONTPTE) += contpte.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 ifdef CONFIG_SWAP
diff --git a/mm/contpte.c b/mm/contpte.c
new file mode 100644
index 000000000000..c3f4b8039b19
--- /dev/null
+++ b/mm/contpte.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#include <linux/mm.h>
+#include <linux/pgtable.h>
+#include <linux/hugetlb.h>
+
+/*
+ * Any arch that wants to use that needs to define:
+ * * contpte macros
+ *   - pte_cont()
+ *   - arch_contpte_get_num_contig()
+ */
+
+/*
+ * This file implements the following contpte aware API:
+ * huge_ptep_get()
+ */
+
+pte_t huge_ptep_get(pte_t *ptep)
+{
+	int ncontig, i;
+	size_t pgsize;
+	pte_t orig_pte = ptep_get(ptep);
+
+	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
+		return orig_pte;
+
+	ncontig = arch_contpte_get_num_contig(ptep,
+					      page_size(pte_page(orig_pte)),
+					      &pgsize);
+
+	for (i = 0; i < ncontig; i++, ptep++) {
+		pte_t pte = ptep_get(ptep);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+	return orig_pte;
+}
-- 
2.39.2


