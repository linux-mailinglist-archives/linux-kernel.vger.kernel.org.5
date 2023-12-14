Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF4C81289C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443247AbjLNG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:57:06 -0500
X-Greylist: delayed 923 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 22:57:11 PST
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E662CB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:57:11 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SrN2q1Gx2z1FDx3;
        Thu, 14 Dec 2023 14:38:11 +0800 (CST)
Received: from kwepemm000003.china.huawei.com (unknown [7.193.23.66])
        by mail.maildlp.com (Postfix) with ESMTPS id 4017C1A0597;
        Thu, 14 Dec 2023 14:41:48 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm000003.china.huawei.com
 (7.193.23.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 14:41:47 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
        <akpm@linux-foundation.org>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 2/3] arm64: mm: HVO: support BBM of vmemmap pgtable safely
Date:   Thu, 14 Dec 2023 15:39:11 +0800
Message-ID: <20231214073912.1938330-3-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214073912.1938330-1-sunnanyong@huawei.com>
References: <20231214073912.1938330-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement vmemmap_update_pmd and vmemmap_update_pte on arm64 to do
BBM(break-before-make) logic when change the page table of vmemmap
address, they will under the init_mm.page_table_lock.
If a translation fault of vmemmap address concurrently happened after
pte/pmd cleared, vmemmap page fault handler will acquire the
init_mm.page_table_lock to wait for vmemmap update to complete,
by then the virtual address is valid again, so PF can return and
access can continue.
In other case, do the traditional kernel fault.

Implement flush_tlb_vmemmap_all and flush_tlb_vmemmap_range on arm64
with nothing to do because tlb already flushed in every single BBM.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/arm64/include/asm/esr.h |  4 ++
 arch/arm64/include/asm/mmu.h | 20 ++++++++
 arch/arm64/mm/fault.c        | 94 ++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c          | 28 +++++++++++
 4 files changed, 146 insertions(+)

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
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 2fcf51231d6e..fcec5827f54f 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -76,5 +76,25 @@ extern bool kaslr_requires_kpti(void);
 #define INIT_MM_CONTEXT(name)	\
 	.pgd = init_pg_dir,
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+void vmemmap_update_pmd(unsigned long start, pmd_t *pmd, pte_t *pgtable);
+#define vmemmap_update_pmd vmemmap_update_pmd
+void vmemmap_update_pte(unsigned long addr, pte_t *pte, pte_t entry);
+#define vmemmap_update_pte vmemmap_update_pte
+
+static inline void flush_tlb_vmemmap_all(void)
+{
+	/* do nothing, already flushed tlb in every single BBM */
+}
+#define flush_tlb_vmemmap_all flush_tlb_vmemmap_all
+
+static inline void flush_tlb_vmemmap_range(unsigned long start,
+					   unsigned long end)
+{
+	/* do nothing, already flushed tlb in every single BBM */
+}
+#define flush_tlb_vmemmap_range flush_tlb_vmemmap_range
+#endif
+
 #endif	/* !__ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 460d799e1296..7066a273c1e0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -368,6 +368,97 @@ static bool is_el1_mte_sync_tag_check_fault(unsigned long esr)
 	return false;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+static inline bool is_vmemmap_address(unsigned long addr)
+{
+	return (addr >= VMEMMAP_START) && (addr < VMEMMAP_END);
+}
+
+static inline bool vmemmap_fault_may_fixup(unsigned long addr,
+					   unsigned long esr)
+{
+	if (!is_vmemmap_address(addr))
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
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+
+	pgdp = pgd_offset_k(addr);
+	if (pgd_none(READ_ONCE(*pgdp)))
+		return false;
+
+	p4dp = p4d_offset(pgdp, addr);
+	if (p4d_none(READ_ONCE(*p4dp)))
+		return false;
+
+	pudp = pud_offset(p4dp, addr);
+	pud = READ_ONCE(*pudp);
+	if (pud_none(pud))
+		return false;
+
+	pmdp = pmd_offset(pudp, addr);
+	pmd = READ_ONCE(*pmdp);
+	if (!pmd_table(pmd))
+		return false;
+
+	ptep = pte_offset_kernel(pmdp, addr);
+	pte = READ_ONCE(*ptep);
+	return (pte_val(pte) & PTE_TYPE_MASK) == PTE_TYPE_PAGE;
+}
+
+static bool vmemmap_handle_page_fault(unsigned long addr,
+				      unsigned long esr)
+{
+	bool ret = false;
+
+	if (likely(!vmemmap_fault_may_fixup(addr, esr)))
+		return false;
+
+	spin_lock(&init_mm.page_table_lock);
+	if (vmemmap_addr_healthy(addr))
+		ret = true;
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
+#endif /*CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
+
 static bool is_translation_fault(unsigned long esr)
 {
 	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
@@ -409,6 +500,9 @@ static void __do_kernel_fault(unsigned long addr, unsigned long esr,
 		    kfence_handle_page_fault(addr, esr & ESR_ELx_WNR, regs))
 			return;
 
+		if (vmemmap_handle_page_fault(addr, esr))
+			return;
+
 		msg = "paging request";
 	}
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 15f6347d23b6..81a600ccac7c 100644
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
+void vmemmap_update_pmd(unsigned long start, pmd_t *pmd, pte_t *pgtable)
+{
+	lockdep_assert_held(&init_mm.page_table_lock);
+	pmd_clear(pmd);
+	flush_tlb_kernel_range(start, start + PMD_SIZE);
+	pmd_populate_kernel(&init_mm, pmd, pgtable);
+}
+
+void vmemmap_update_pte(unsigned long addr, pte_t *pte, pte_t entry)
+{
+	spin_lock(&init_mm.page_table_lock);
+	pte_clear(&init_mm, addr, pte);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	set_pte_at(&init_mm, addr, pte, entry);
+	spin_unlock(&init_mm.page_table_lock);
+}
+#endif
+
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
-- 
2.25.1

