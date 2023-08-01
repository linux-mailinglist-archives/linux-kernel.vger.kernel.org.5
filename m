Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD176B037
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjHAKBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjHAKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:01:21 -0400
X-Greylist: delayed 1789 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 03:01:18 PDT
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB1110C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:01:17 -0700 (PDT)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
        by Atcsqr.andestech.com with ESMTP id 3719EdXp068515
        for <linux-kernel@vger.kernel.org>; Tue, 1 Aug 2023 17:14:39 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 37199auJ066580;
        Tue, 1 Aug 2023 17:09:36 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 1 Aug 2023
 17:09:32 +0800
From:   Dylan Jhong <dylan@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <wangkefeng.wang@huawei.com>, <tongtiangen@huawei.com>,
        <guoren@kernel.org>, <sergey.matyukevich@syntacore.com>,
        <gregkh@linuxfoundation.org>, <ajones@ventanamicro.com>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor.dooley@microchip.com>
CC:     <x5710999x@gmail.com>, <tim609@andestech.com>,
        <cl634@andestech.com>, <ycliang@andestech.com>,
        Dylan Jhong <dylan@andestech.com>
Subject: [PATCH] riscv: Flush stale TLB entry with VMAP_STACK enabled
Date:   Tue, 1 Aug 2023 17:09:27 +0800
Message-ID: <20230801090927.2018653-1-dylan@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3719EdXp068515
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VMAP_STACK is enabled, the kernel stack will be obtained through
vmalloc(). Normally, we rely on the logic in vmalloc_fault() to update stale
P*D entries covering the vmalloc space in a task's page tables when it first
accesses the problematic region. Unfortunately, this is not sufficient when
the kernel stack resides in the vmalloc region, because vmalloc_fault() is a
C function that needs a stack to run. So we need to ensure that these P*D
entries are up to date *before* the MM switch.

Here's our symptom:
core 0: A speculative load lead the kernel stack load to the TLB before the
        corresponding kernel stack's page table is created.
core 1: Create page table mapping of that kernel stack.
core 0: After a context switch, the kernel attempts to use the stack region.
        However, even if the page table is correct, the stack address mapping
        in the TLB is invalid, leading to subsequent nested exceptions.

This fix is inspired by ARM's approach[*1], commit a1c510d0adc6 ("ARM:
implement support for vmap'ed stacks"), it also performs a TLB flush after
setting up the page tables in vmalloc().

Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
Signed-off-by: Dylan Jhong <dylan@andestech.com>
---
 arch/riscv/include/asm/page.h |  4 ++++
 arch/riscv/mm/tlbflush.c      | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 349fad5e35de..c9b080a72855 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -21,6 +21,10 @@
 #define HPAGE_MASK              (~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
 
+#ifdef CONFIG_VMAP_STACK
+#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PTE_MODIFIED
+#endif
+
 /*
  * PAGE_OFFSET -- the first address of the first page of memory.
  * When not using MMU this corresponds to the first free page in
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index ef701fa83f36..0799978913ee 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -86,3 +86,19 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PMD_SIZE);
 }
 #endif
+
+#ifdef CONFIG_VMAP_STACK
+/*
+ * Normally, we rely on the logic in vmalloc_fault() to update stale P*D
+ * entries covering the vmalloc space in a task's page tables when it first
+ * accesses the problematic region. Unfortunately, this is not sufficient when
+ * the kernel stack resides in the vmalloc region, because vmalloc_fault() is a
+ * C function that needs a stack to run. So we need to ensure that these P*D
+ * entries are up to date *before* the MM switch.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	if (start < VMALLOC_END && end > VMALLOC_START)
+		flush_tlb_all();
+}
+#endif
-- 
2.34.1

