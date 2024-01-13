Return-Path: <linux-kernel+bounces-25217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D90382CA95
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871F61F232F9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108FC17FE;
	Sat, 13 Jan 2024 08:48:22 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC764B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TBsVG5rYczNl3S;
	Sat, 13 Jan 2024 16:47:34 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id AF13118001D;
	Sat, 13 Jan 2024 16:48:15 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Jan
 2024 16:48:14 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<anshuman.khandual@arm.com>
CC: <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v3 2/3] arm64: mm: HVO: support BBM of vmemmap pgtable safely
Date: Sat, 13 Jan 2024 17:44:35 +0800
Message-ID: <20240113094436.2506396-3-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240113094436.2506396-1-sunnanyong@huawei.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Implement vmemmap_update_pmd and vmemmap_update_pte on arm64 to do
BBM(break-before-make) logic when change the page table of vmemmap
address, they will under the init_mm.page_table_lock.
If a translation fault of vmemmap address concurrently happened after
pte/pmd cleared, vmemmap page fault handler will acquire the
init_mm.page_table_lock to wait for vmemmap update to complete,
by then the virtual address is valid again, so PF can return and
access can continue.
In other case, do the traditional kernel fault.

Implement vmemmap_flush_tlb_all/range on arm64 with nothing
to do because tlb already flushed in every single BBM.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/arm64/include/asm/esr.h      |  4 ++
 arch/arm64/include/asm/pgtable.h  |  8 ++++
 arch/arm64/include/asm/tlbflush.h | 16 +++++++
 arch/arm64/mm/fault.c             | 78 +++++++++++++++++++++++++++++--
 arch/arm64/mm/mmu.c               | 28 +++++++++++
 5 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index ae35939f395b..1c63256efd25 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -116,6 +116,10 @@
 #define ESR_ELx_FSC_SERROR	(0x11)
 #define ESR_ELx_FSC_ACCESS	(0x08)
 #define ESR_ELx_FSC_FAULT	(0x04)
+#define ESR_ELx_FSC_FAULT_L0    (0x04)
+#define ESR_ELx_FSC_FAULT_L1    (0x05)
+#define ESR_ELx_FSC_FAULT_L2    (0x06)
+#define ESR_ELx_FSC_FAULT_L3    (0x07)
 #define ESR_ELx_FSC_PERM	(0x0C)
 #define ESR_ELx_FSC_SEA_TTW0	(0x14)
 #define ESR_ELx_FSC_SEA_TTW1	(0x15)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 79ce70fbb751..b50270107e2f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1124,6 +1124,14 @@ extern pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
 extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 				    unsigned long addr, pte_t *ptep,
 				    pte_t old_pte, pte_t new_pte);
+
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+void vmemmap_update_pmd(unsigned long addr, pmd_t *pmdp, pte_t *ptep);
+#define vmemmap_update_pmd vmemmap_update_pmd
+void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
+#define vmemmap_update_pte vmemmap_update_pte
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 1deb5d789c2e..79e932a1bdf8 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -504,6 +504,22 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 	dsb(ish);
 	isb();
 }
+
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+static inline void vmemmap_flush_tlb_all(void)
+{
+	/* do nothing, already flushed tlb in every single BBM */
+}
+#define vmemmap_flush_tlb_all vmemmap_flush_tlb_all
+
+static inline void vmemmap_flush_tlb_range(unsigned long start,
+					   unsigned long end)
+{
+	/* do nothing, already flushed tlb in every single BBM */
+}
+#define vmemmap_flush_tlb_range vmemmap_flush_tlb_range
+#endif
+
 #endif
 
 #endif
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 55f6455a8284..13189322a38f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -368,6 +368,75 @@ static bool is_el1_mte_sync_tag_check_fault(unsigned long esr)
 	return false;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+static inline bool vmemmap_fault_may_fixup(unsigned long addr,
+					   unsigned long esr)
+{
+	if (addr < VMEMMAP_START || addr >= VMEMMAP_END)
+		return false;
+
+	/*
+	 * Only try to handle translation fault level 2 or level 3,
+	 * because hugetlb vmemmap optimize only clear pmd or pte.
+	 */
+	switch (esr & ESR_ELx_FSC) {
+	case ESR_ELx_FSC_FAULT_L2:
+	case ESR_ELx_FSC_FAULT_L3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * PMD mapped vmemmap should has been split as PTE mapped
+ * by HVO now, here we only check this case, other cases
+ * should fail.
+ * Also should check the addr is healthy enough that will not cause
+ * a level2 or level3 translation fault again after page fault
+ * handled with success, so we need check both bits[1:0] of PMD and
+ * PTE as ARM Spec mentioned below:
+ * A Translation fault is generated if bits[1:0] of a translation
+ * table descriptor identify the descriptor as either a Fault
+ * encoding or a reserved encoding.
+ */
+static inline bool vmemmap_addr_healthy(unsigned long addr)
+{
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+
+	pmdp = pmd_off_k(addr);
+	pmd = pmdp_get(pmdp);
+	if (!pmd_table(pmd))
+		return false;
+
+	ptep = pte_offset_kernel(pmdp, addr);
+	pte = ptep_get(ptep);
+	return (pte_val(pte) & PTE_TYPE_MASK) == PTE_TYPE_PAGE;
+}
+
+static bool vmemmap_handle_page_fault(unsigned long addr,
+				      unsigned long esr)
+{
+	bool ret;
+
+	if (likely(!vmemmap_fault_may_fixup(addr, esr)))
+		return false;
+
+	spin_lock(&init_mm.page_table_lock);
+	ret = vmemmap_addr_healthy(addr);
+	spin_unlock(&init_mm.page_table_lock);
+
+	return ret;
+}
+#else
+static inline bool vmemmap_handle_page_fault(unsigned long addr,
+					     unsigned long esr)
+{
+	return false;
+}
+#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
+
 static bool is_translation_fault(unsigned long esr)
 {
 	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
@@ -405,9 +474,12 @@ static void __do_kernel_fault(unsigned long addr, unsigned long esr,
 	} else if (addr < PAGE_SIZE) {
 		msg = "NULL pointer dereference";
 	} else {
-		if (is_translation_fault(esr) &&
-		    kfence_handle_page_fault(addr, esr & ESR_ELx_WNR, regs))
-			return;
+		if (is_translation_fault(esr)) {
+			if (kfence_handle_page_fault(addr, esr & ESR_ELx_WNR, regs))
+				return;
+			if (vmemmap_handle_page_fault(addr, esr))
+				return;
+		}
 
 		msg = "paging request";
 	}
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1ac7467d34c9..d794b2f4b5a3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1146,6 +1146,34 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 	return 1;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+/*
+ * In the window between the page table entry is cleared and filled
+ * with a new value, other threads have the opportunity to concurrently
+ * access the vmemmap area then page translation fault occur.
+ * Therefore, we need to ensure that the init_mm.page_table_lock is held
+ * to synchronize the vmemmap page fault handling which will wait for
+ * this lock to be released to ensure that the page table entry has been
+ * refreshed with a new valid value.
+ */
+void vmemmap_update_pmd(unsigned long addr, pmd_t *pmdp, pte_t *ptep)
+{
+	lockdep_assert_held(&init_mm.page_table_lock);
+	pmd_clear(pmdp);
+	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+	pmd_populate_kernel(&init_mm, pmdp, ptep);
+}
+
+void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
+{
+	spin_lock(&init_mm.page_table_lock);
+	pte_clear(&init_mm, addr, ptep);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	set_pte_at(&init_mm, addr, ptep, pte);
+	spin_unlock(&init_mm.page_table_lock);
+}
+#endif
+
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
-- 
2.25.1


