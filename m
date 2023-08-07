Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EFD771C34
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjHGIXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHGIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:23:30 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F0C170A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:23:27 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3778NDqf098860;
        Mon, 7 Aug 2023 16:23:13 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 7 Aug 2023
 16:23:10 +0800
From:   Dylan Jhong <dylan@andestech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <ajones@ventanamicro.com>,
        <alexghiti@rivosinc.com>, <anup@brainfault.org>, <rppt@kernel.org>,
        <samuel@sholland.org>, <panqinglin2020@iscas.ac.cn>,
        <sergey.matyukevich@syntacore.com>, <maz@kernel.org>,
        <linux-riscv@lists.infradead.org>, <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>
CC:     <ycliang@andestech.com>, <x5710999x@gmail.com>,
        <tim609@andestech.com>, Dylan Jhong <dylan@andestech.com>
Subject: [PATCH 1/1] riscv: Implement arch_sync_kernel_mappings() for "preventive" TLB flush
Date:   Mon, 7 Aug 2023 16:23:05 +0800
Message-ID: <20230807082305.198784-2-dylan@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807082305.198784-1-dylan@andestech.com>
References: <20230807082305.198784-1-dylan@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3778NDqf098860
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since RISC-V is a microarchitecture that allows caching invalid entries in the TLB,
it is necessary to issue a "preventive" SFENCE.VMA to ensure that each core obtains
the correct kernel mapping.

The patch implements TLB flushing in arch_sync_kernel_mappings(), ensuring that kernel
page table mappings created via vmap/vmalloc() are updated before switching MM.

Signed-off-by: Dylan Jhong <dylan@andestech.com>
---
 arch/riscv/include/asm/page.h |  2 ++
 arch/riscv/mm/tlbflush.c      | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index b55ba20903ec..6c86ab69687e 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -21,6 +21,8 @@
 #define HPAGE_MASK              (~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
 
+#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PTE_MODIFIED
+
 /*
  * PAGE_OFFSET -- the first address of the first page of memory.
  * When not using MMU this corresponds to the first free page in
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 77be59aadc73..d63364948c85 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -149,3 +149,15 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
 }
 #endif
+
+/*
+ * Since RISC-V is a microarchitecture that allows caching invalid entries in the TLB,
+ * it is necessary to issue a "preventive" SFENCE.VMA to ensure that each core obtains
+ * the correct kernel mapping. arch_sync_kernel_mappings() will ensure that kernel
+ * page table mappings created via vmap/vmalloc() are updated before switching MM.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	if (start < VMALLOC_END && end > VMALLOC_START)
+		flush_tlb_all();
+}
\ No newline at end of file
-- 
2.34.1

