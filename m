Return-Path: <linux-kernel+bounces-117301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365A88A9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A101F66672
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951916F8E5;
	Mon, 25 Mar 2024 14:56:32 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2016F29A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378592; cv=none; b=ErbjE9n3e5GJijHQrTsn2mrzp5QB1nOrPFX28fvrEZrOrRwDlvNt6k9P2QGQzVGiKlkhr4AqCd2AKLzpAkuqlVP6TWn0WorWSPFrWHFbv/dZxicfYc5WLSwRB8vZswDAv5+fTafnzQU284HN3T6qpl5SakpO5SI01SlXid7yS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378592; c=relaxed/simple;
	bh=4ts0uoP1Urxiva7aePDf1AHFQE/7fSObtY1zE6Z2IwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWTXhRt8FYv5+hzmoF8EhtuIAmNasuK6t31XpDujgyIMIx4qA9j05g24kK6mw8mPpoJwVy5kokYkSK1VVXAecip4JgZjJbfbEF/ibVhCW1LAKILCNohp4VQ2iTXGCKUzsKo+U9DCJBX0HQHQ2V3M6zLHJd2quvMaM3HBCvF1vPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4V3GGP1D5Qz9sqT;
	Mon, 25 Mar 2024 15:56:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 70e8zKdeppRM; Mon, 25 Mar 2024 15:56:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4V3GGK36JTz9sfW;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6731A8B765;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ZS39sT5H_ogC; Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A48B8B770;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 3/8] mm: Provide pmd to pte_leaf_size()
Date: Mon, 25 Mar 2024 15:55:56 +0100
Message-ID: <32921d5b2767fe7d6f16ec09afe1bf8a571cb538.1711377230.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711377230.git.christophe.leroy@csgroup.eu>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711378567; l=4399; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=4ts0uoP1Urxiva7aePDf1AHFQE/7fSObtY1zE6Z2IwU=; b=a05y8ni8WptI6RYZT/NgealekJsHbCYwBgmtjyMtZc/BKP6kcg4jNxmDeoGDUWSnnyYi3u2Op 17yI9VGc556Aj1+EarKB2yZYxn8f5BXklKDyWXoNYXVM9tCfIpuXUrt
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

On powerpc 8xx, when a page is 8M size, the information is in the PMD
entry. So provide it to pte_leaf_size().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/arm64/include/asm/pgtable.h             | 2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
 arch/riscv/include/asm/pgtable.h             | 2 +-
 arch/sparc/include/asm/pgtable_64.h          | 2 +-
 arch/sparc/mm/hugetlbpage.c                  | 2 +-
 include/linux/pgtable.h                      | 2 +-
 kernel/events/core.c                         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index afdd56d26ad7..57c40f2498ab 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -624,7 +624,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #define pmd_bad(pmd)		(!pmd_table(pmd))
 
 #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
-#define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
+#define pte_leaf_size(pmd, pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
 
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
 static inline bool pud_sect(pud_t pud) { return false; }
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 137dc3c84e45..07df6b664861 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -151,7 +151,7 @@ static inline unsigned long pgd_leaf_size(pgd_t pgd)
 
 #define pgd_leaf_size pgd_leaf_size
 
-static inline unsigned long pte_leaf_size(pte_t pte)
+static inline unsigned long pte_leaf_size(pmd_t pmd, pte_t pte)
 {
 	pte_basic_t val = pte_val(pte);
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 20242402fc11..45fa27810f25 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -439,7 +439,7 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
-#define pte_leaf_size(pte)	(pte_napot(pte) ?				\
+#define pte_leaf_size(pmd, pte)	(pte_napot(pte) ?				\
 					napot_cont_size(napot_cont_order(pte)) :\
 					PAGE_SIZE)
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 4d1bafaba942..67063af2ff8f 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1175,7 +1175,7 @@ extern unsigned long pud_leaf_size(pud_t pud);
 extern unsigned long pmd_leaf_size(pmd_t pmd);
 
 #define pte_leaf_size pte_leaf_size
-extern unsigned long pte_leaf_size(pte_t pte);
+extern unsigned long pte_leaf_size(pmd_t pmd, pte_t pte);
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 5a342199e837..60c845a15bee 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -276,7 +276,7 @@ static unsigned long huge_tte_to_size(pte_t pte)
 
 unsigned long pud_leaf_size(pud_t pud) { return 1UL << tte_to_shift(*(pte_t *)&pud); }
 unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift(*(pte_t *)&pmd); }
-unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift(pte); }
+unsigned long pte_leaf_size(pmd_t pmd, pte_t pte) { return 1UL << tte_to_shift(pte); }
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 85fc7554cd52..e605a4149fc7 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1802,7 +1802,7 @@ typedef unsigned int pgtbl_mod_mask;
 #define pmd_leaf_size(x) PMD_SIZE
 #endif
 #ifndef pte_leaf_size
-#define pte_leaf_size(x) PAGE_SIZE
+#define pte_leaf_size(x, y) PAGE_SIZE
 #endif
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..5c1c083222b2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7585,7 +7585,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 
 	pte = ptep_get_lockless(ptep);
 	if (pte_present(pte))
-		size = pte_leaf_size(pte);
+		size = pte_leaf_size(pmd, pte);
 	pte_unmap(ptep);
 #endif /* CONFIG_HAVE_FAST_GUP */
 
-- 
2.43.0


