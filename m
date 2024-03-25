Return-Path: <linux-kernel+bounces-117299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE888A9CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC47342E04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75AA16AFD8;
	Mon, 25 Mar 2024 14:56:22 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03184FC9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378582; cv=none; b=s99WMSyJH6NvHlM0EGqWxsK/op03M3xh9dnxWB0F89fOeZPFWa5BNiy61KUOjM/NVgzfOLEgQ+KTN9J0C0JMey7ArAbKV6e/sTW4aXutTS3tUJKKy9CfvDlSdBgOFAm9yrGMre6uvbum43D1OZFONlPBlVe5hD9or9bBXILrS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378582; c=relaxed/simple;
	bh=ekqDiax6XYjI7QmradPChM7m3NA5stHWTQ4duig8CUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btLvVuOy4gCBZkFY3BcIIyqQWZywWZsvGMyUXAvp5T9ALBCvEGSRjz/rMxy8J/y2+PtCggtkU1miQcaPYGPa7yZFPLl976h+rrwj3+Aym6ivhjGTn4UMvPTb9bn6+AZxiMn/XKdwr7kPh5li6jX0lor0EfIZv2Vqv3QHWnCo/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4V3GGM0mf5z9sTD;
	Mon, 25 Mar 2024 15:56:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DFWWQuMGrNUw; Mon, 25 Mar 2024 15:56:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4V3GGK1jq7z9sbF;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 37A088B765;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Izv57FnJsesi; Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 131B68B76D;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/8] mm: Provide pagesize to pmd_populate()
Date: Mon, 25 Mar 2024 15:55:54 +0100
Message-ID: <54d78f1b7e7f1c671e40b7c0c637380bcb834326.1711377230.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711377230.git.christophe.leroy@csgroup.eu>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711378567; l=7768; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ekqDiax6XYjI7QmradPChM7m3NA5stHWTQ4duig8CUY=; b=372K9QS4WRy+tMs3GDykxT5niJJw9B8R1716FMGSolDQuf04emGhfpHWhk/1LFu8r6xDLN8Zv T9yhPnF3XT2CjU1pa0bAYbml2OpX9dP01GcgxUfRygbH9cm4HCInE+n
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Unlike many architectures, powerpc 8xx hardware tablewalk requires
a two level process for all page sizes, allthough second level only
has one entry when pagesize is 8M.

To fit with Linux page table topology and without requiring special
page directory layout like hugepd, the page entry will be replicated
1024 times in the standard page table. However for large pages it is
necessary to set bits in the level-1 (PMD) entry. At the time being,
for 512k pages the flag is kept in the PTE and inserted in the PMD
entry at TLB miss exception, that is necessary because we can have
pages of different sizes in a page table. However the 12 PTE bits are
fully used and there is no room for an additional bit for page size.

For 8M pages, there will be only one page per PMD entry, it is
therefore possible to flag the pagesize in the PMD entry, with the
advantage that the information will already be at the right place for
the hardware.

To do so, add a new helper called pmd_populate_size() which takes the
page size as an additional argument, and modify __pte_alloc() to also
take that argument. pte_alloc() is left unmodified in order to
reduce churn on callers, and a pte_alloc_size() is added for use by
pte_alloc_huge().

When an architecture doesn't provide pmd_populate_size(),
pmd_populate() is used as a fallback.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/mm.h | 12 +++++++-----
 mm/filemap.c       |  2 +-
 mm/internal.h      |  2 +-
 mm/memory.c        | 19 ++++++++++++-------
 mm/pgalloc-track.h |  2 +-
 mm/userfaultfd.c   |  4 ++--
 6 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2c0910bc3e4a..6c5c15955d4e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2801,8 +2801,8 @@ static inline void mm_inc_nr_ptes(struct mm_struct *mm) {}
 static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
 #endif
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
-int __pte_alloc_kernel(pmd_t *pmd);
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long sz);
+int __pte_alloc_kernel(pmd_t *pmd, unsigned long sz);
 
 #if defined(CONFIG_MMU)
 
@@ -2987,7 +2987,8 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 	pte_unmap(pte);					\
 } while (0)
 
-#define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
+#define pte_alloc_size(mm, pmd, sz) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd, sz))
+#define pte_alloc(mm, pmd) pte_alloc_size(mm, pmd, PAGE_SIZE)
 
 #define pte_alloc_map(mm, pmd, address)			\
 	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
@@ -2996,9 +2997,10 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 	(pte_alloc(mm, pmd) ?			\
 		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
 
-#define pte_alloc_kernel(pmd, address)			\
-	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
+#define pte_alloc_kernel_size(pmd, address, sz)			\
+	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd, sz))? \
 		NULL: pte_offset_kernel(pmd, address))
+#define pte_alloc_kernel(pmd, address)	pte_alloc_kernel_size(pmd, address, PAGE_SIZE)
 
 #if USE_SPLIT_PMD_PTLOCKS
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 7437b2bd75c1..b013000ea84f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3428,7 +3428,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 	}
 
 	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
-		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
+		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte, PAGE_SIZE);
 
 	return false;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 7e486f2c502c..b81c3ca59f45 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -206,7 +206,7 @@ void folio_activate(struct folio *folio);
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *start_vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked);
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte, unsigned long sz);
 
 struct zap_details;
 void unmap_page_range(struct mmu_gather *tlb,
diff --git a/mm/memory.c b/mm/memory.c
index f2bc6dd15eb8..c846bb75746b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -409,7 +409,12 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 	} while (vma);
 }
 
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+#ifndef pmd_populate_size
+#define pmd_populate_size(mm, pmdp, pte, sz) pmd_populate(mm, pmdp, pte)
+#define pmd_populate_kernel_size(mm, pmdp, pte, sz) pmd_populate_kernel(mm, pmdp, pte)
+#endif
+
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte, unsigned long sz)
 {
 	spinlock_t *ptl = pmd_lock(mm, pmd);
 
@@ -429,25 +434,25 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 		 * smp_rmb() barriers in page table walking code.
 		 */
 		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
-		pmd_populate(mm, pmd, *pte);
+		pmd_populate_size(mm, pmd, *pte, sz);
 		*pte = NULL;
 	}
 	spin_unlock(ptl);
 }
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long sz)
 {
 	pgtable_t new = pte_alloc_one(mm);
 	if (!new)
 		return -ENOMEM;
 
-	pmd_install(mm, pmd, &new);
+	pmd_install(mm, pmd, &new, sz);
 	if (new)
 		pte_free(mm, new);
 	return 0;
 }
 
-int __pte_alloc_kernel(pmd_t *pmd)
+int __pte_alloc_kernel(pmd_t *pmd, unsigned long sz)
 {
 	pte_t *new = pte_alloc_one_kernel(&init_mm);
 	if (!new)
@@ -456,7 +461,7 @@ int __pte_alloc_kernel(pmd_t *pmd)
 	spin_lock(&init_mm.page_table_lock);
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
 		smp_wmb(); /* See comment in pmd_install() */
-		pmd_populate_kernel(&init_mm, pmd, new);
+		pmd_populate_kernel_size(&init_mm, pmd, new, sz);
 		new = NULL;
 	}
 	spin_unlock(&init_mm.page_table_lock);
@@ -4738,7 +4743,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		}
 
 		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
+			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte, PAGE_SIZE);
 		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
 			return VM_FAULT_OOM;
 	}
diff --git a/mm/pgalloc-track.h b/mm/pgalloc-track.h
index e9e879de8649..90e37de7ab77 100644
--- a/mm/pgalloc-track.h
+++ b/mm/pgalloc-track.h
@@ -45,7 +45,7 @@ static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
 
 #define pte_alloc_kernel_track(pmd, address, mask)			\
 	((unlikely(pmd_none(*(pmd))) &&					\
-	  (__pte_alloc_kernel(pmd) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
+	  (__pte_alloc_kernel(pmd, PAGE_SIZE) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
 		NULL: pte_offset_kernel(pmd, address))
 
 #endif /* _LINUX_PGALLOC_TRACK_H */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 712160cd41ec..9baf507ce193 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -764,7 +764,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			break;
 		}
 		if (unlikely(pmd_none(dst_pmdval)) &&
-		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
+		    unlikely(__pte_alloc(dst_mm, dst_pmd, PAGE_SIZE))) {
 			err = -ENOMEM;
 			break;
 		}
@@ -1686,7 +1686,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 					err = -ENOENT;
 					break;
 				}
-				if (unlikely(__pte_alloc(mm, src_pmd))) {
+				if (unlikely(__pte_alloc(mm, src_pmd, PAGE_SIZE))) {
 					err = -ENOMEM;
 					break;
 				}
-- 
2.43.0


