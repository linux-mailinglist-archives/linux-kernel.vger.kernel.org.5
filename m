Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6780ED18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376629AbjLLNRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376548AbjLLNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:17:10 -0500
Received: from fzi-msx-e-03.fzi.de (fzi-msx-e-03.fzi.de [141.21.8.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391E1EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:17:15 -0800 (PST)
From:   Frederik Haxel <haxel@fzi.de>
CC:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Frederik Haxel <haxel@fzi.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Greentime Hu" <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nam Cao <namcaov@gmail.com>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Baoquan He <bhe@redhat.com>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] riscv: Make XIP bootable again
Date:   Tue, 12 Dec 2023 14:01:12 +0100
Message-ID: <20231212130116.848530-2-haxel@fzi.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212130116.848530-1-haxel@fzi.de>
References: <20231212130116.848530-1-haxel@fzi.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [141.21.46.139]
X-ClientProxiedBy: fzi-msx-05.fzi.de (2001:67c:2acc:8:141:21:17:45) To
 fzi-msx-05.fzi.de (2001:67c:2acc:8:141:21:17:45)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the XIP kernel seems to fail to boot due to missing
XIP_FIXUP and a wrong page_offset value. A superfluous XIP_FIXUP
has also been removed.

Signed-off-by: Frederik Haxel <haxel@fzi.de>
---
 arch/riscv/kernel/head.S | 1 +
 arch/riscv/mm/init.c     | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index b77397432403..a2e2f0dd3899 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -89,6 +89,7 @@ relocate_enable_mmu:
 	/* Compute satp for kernel page tables, but don't load it yet */
 	srl a2, a0, PAGE_SHIFT
 	la a1, satp_mode
+	XIP_FIXUP_OFFSET a1
 	REG_L a1, 0(a1)
 	or a2, a2, a1
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2e011cbddf3a..a65937336cdc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -174,6 +174,9 @@ void __init mem_init(void)
 
 /* Limit the memory size via mem. */
 static phys_addr_t memory_limit;
+#ifdef CONFIG_XIP_KERNEL
+#define memory_limit	(*(phys_addr_t *)XIP_FIXUP(&memory_limit))
+#endif /* CONFIG_XIP_KERNEL */
 
 static int __init early_mem(char *p)
 {
@@ -952,7 +955,7 @@ static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 	 * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
 	 * kernel is mapped in the linear mapping, that makes no difference.
 	 */
-	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
+	dtb_early_va = kernel_mapping_pa_to_va(dtb_pa);
 #endif
 
 	dtb_early_pa = dtb_pa;
@@ -1055,9 +1058,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 	kernel_map.virt_addr = KERNEL_LINK_ADDR + kernel_map.virt_offset;
-	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 
 #ifdef CONFIG_XIP_KERNEL
+	kernel_map.page_offset = PAGE_OFFSET_L3;
 	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
@@ -1067,6 +1070,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
 #else
+	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 	kernel_map.phys_addr = (uintptr_t)(&_start);
 	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
 #endif
-- 
2.34.1

