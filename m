Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172EF7E57D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344686AbjKHNLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjKHNLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:11:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E888A1BF3;
        Wed,  8 Nov 2023 05:11:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95AAC433C7;
        Wed,  8 Nov 2023 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699449077;
        bh=qtbyXJMi+8Dg/HzHqeOyoFCWhaOc+xqke0bl2mdllZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrNArwL26RJKlL9w5eD4/smhdi4brhKW+gKtl5R7YgrBqLHqzoq92u7XVn5GHiYW8
         dLGqiKvCIstvBOAmPR3wjJLU+fqj/4i4PgCy7MfP25nA+fL0DiUMb2Km1AfcCRxdGM
         Fa7LeoHmvChYwhSq9wLDp5X1COsecIe+rmu6/vN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.5.11
Date:   Wed,  8 Nov 2023 14:11:05 +0100
Message-ID: <2023110805-kilobyte-majestic-0903@gregkh>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <2023110804-lather-basket-a050@gregkh>
References: <2023110804-lather-basket-a050@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 303a443d9e29..9418fd66a8e9 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -29,6 +29,10 @@ properties:
           default: 0
           maximum: 100
 
+  rs485-rts-active-high:
+    description: drive RTS high when sending (this is the default).
+    $ref: /schemas/types.yaml#/definitions/flag
+
   rs485-rts-active-low:
     description: drive RTS low when sending (default is high).
     $ref: /schemas/types.yaml#/definitions/flag
diff --git a/Makefile b/Makefile
index ab9f291c1d3f..555cc34f4730 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 5
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 1d8dd14b65cf..2a9b89bf5269 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -146,7 +146,7 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
-			anomix_ns_gpr: syscon@44210000 {
+			aonmix_ns_gpr: syscon@44210000 {
 				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
 				reg = <0x44210000 0x1000>;
 			};
@@ -280,6 +280,7 @@ flexcan1: can@443a0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&aonmix_ns_gpr 0x14 0>;
 				status = "disabled";
 			};
 
@@ -532,6 +533,7 @@ flexcan2: can@425b0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&wakeupmix_gpr 0x0c 2>;
 				status = "disabled";
 			};
 
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 1c9410220040..0355b64e90ed 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -54,10 +54,9 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
  * @offset:    bus address of the memory
  * @size:      size of the resource to map
  */
-extern pgprot_t pgprot_wc;
-
 #define ioremap_wc(offset, size)	\
-	ioremap_prot((offset), (size), pgprot_val(pgprot_wc))
+	ioremap_prot((offset), (size),	\
+		pgprot_val(wc_enabled ? PAGE_KERNEL_WUC : PAGE_KERNEL_SUC))
 
 #define ioremap_cache(offset, size)	\
 	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
diff --git a/arch/loongarch/include/asm/linkage.h b/arch/loongarch/include/asm/linkage.h
index 81b0c4cfbf4f..e2eca1a25b4e 100644
--- a/arch/loongarch/include/asm/linkage.h
+++ b/arch/loongarch/include/asm/linkage.h
@@ -33,4 +33,12 @@
 	.cfi_endproc;					\
 	SYM_END(name, SYM_T_FUNC)
 
+#define SYM_CODE_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	.cfi_startproc;
+
+#define SYM_CODE_END(name)				\
+	.cfi_endproc;					\
+	SYM_END(name, SYM_T_NONE)
+
 #endif
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index de46a6b1e9f1..7b9ac012cd09 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -105,13 +105,15 @@ static inline pgprot_t pgprot_noncached(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+extern bool wc_enabled;
+
 #define pgprot_writecombine pgprot_writecombine
 
 static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 {
 	unsigned long prot = pgprot_val(_prot);
 
-	prot = (prot & ~_CACHE_MASK) | _CACHE_WUC;
+	prot = (prot & ~_CACHE_MASK) | (wc_enabled ? _CACHE_WUC : _CACHE_SUC);
 
 	return __pgprot(prot);
 }
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d737e3cf42d3..1781c6a5befa 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -18,7 +18,7 @@
 	.text
 	.cfi_sections	.debug_frame
 	.align	5
-SYM_FUNC_START(handle_syscall)
+SYM_CODE_START(handle_syscall)
 	csrrd		t0, PERCPU_BASE_KS
 	la.pcrel	t1, kernelsp
 	add.d		t1, t1, t0
@@ -66,7 +66,7 @@ SYM_FUNC_START(handle_syscall)
 	bl		do_syscall
 
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_syscall)
+SYM_CODE_END(handle_syscall)
 _ASM_NOKPROBE(handle_syscall)
 
 SYM_CODE_START(ret_from_fork)
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 78f066384657..2bb3aa2dcfcb 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -31,7 +31,7 @@ SYM_FUNC_START(__arch_cpu_idle)
 1:	jr	ra
 SYM_FUNC_END(__arch_cpu_idle)
 
-SYM_FUNC_START(handle_vint)
+SYM_CODE_START(handle_vint)
 	BACKUP_T0T1
 	SAVE_ALL
 	la_abs	t1, __arch_cpu_idle
@@ -46,11 +46,11 @@ SYM_FUNC_START(handle_vint)
 	la_abs	t0, do_vint
 	jirl	ra, t0, 0
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_vint)
+SYM_CODE_END(handle_vint)
 
-SYM_FUNC_START(except_vec_cex)
+SYM_CODE_START(except_vec_cex)
 	b	cache_parity_error
-SYM_FUNC_END(except_vec_cex)
+SYM_CODE_END(except_vec_cex)
 
 	.macro	build_prep_badv
 	csrrd	t0, LOONGARCH_CSR_BADV
@@ -66,7 +66,7 @@ SYM_FUNC_END(except_vec_cex)
 
 	.macro	BUILD_HANDLER exception handler prep
 	.align	5
-	SYM_FUNC_START(handle_\exception)
+	SYM_CODE_START(handle_\exception)
 	666:
 	BACKUP_T0T1
 	SAVE_ALL
@@ -76,7 +76,7 @@ SYM_FUNC_END(except_vec_cex)
 	jirl	ra, t0, 0
 	668:
 	RESTORE_ALL_AND_RET
-	SYM_FUNC_END(handle_\exception)
+	SYM_CODE_END(handle_\exception)
 	SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
 	.endm
 
@@ -93,7 +93,7 @@ SYM_FUNC_END(except_vec_cex)
 	BUILD_HANDLER watch watch none
 	BUILD_HANDLER reserved reserved none	/* others */
 
-SYM_FUNC_START(handle_sys)
+SYM_CODE_START(handle_sys)
 	la_abs	t0, handle_syscall
 	jr	t0
-SYM_FUNC_END(handle_sys)
+SYM_CODE_END(handle_sys)
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 9d830ab4e302..1351614042d4 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -161,19 +161,19 @@ static void __init smbios_parse(void)
 }
 
 #ifdef CONFIG_ARCH_WRITECOMBINE
-pgprot_t pgprot_wc = PAGE_KERNEL_WUC;
+bool wc_enabled = true;
 #else
-pgprot_t pgprot_wc = PAGE_KERNEL_SUC;
+bool wc_enabled = false;
 #endif
 
-EXPORT_SYMBOL(pgprot_wc);
+EXPORT_SYMBOL(wc_enabled);
 
 static int __init setup_writecombine(char *p)
 {
 	if (!strcmp(p, "on"))
-		pgprot_wc = PAGE_KERNEL_WUC;
+		wc_enabled = true;
 	else if (!strcmp(p, "off"))
-		pgprot_wc = PAGE_KERNEL_SUC;
+		wc_enabled = false;
 	else
 		pr_warn("Unknown writecombine setting \"%s\".\n", p);
 
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 3b7d8129570b..d967d881c3fe 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -68,11 +68,11 @@ void copy_user_highpage(struct page *to, struct page *from,
 {
 	void *vfrom, *vto;
 
-	vto = kmap_atomic(to);
-	vfrom = kmap_atomic(from);
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
 	copy_page(vto, vfrom);
-	kunmap_atomic(vfrom);
-	kunmap_atomic(vto);
+	kunmap_local(vfrom);
+	kunmap_local(vto);
 	/* Make sure this page is cleared on other CPU's too before using it */
 	smp_wmb();
 }
@@ -267,6 +267,7 @@ pgd_t swapper_pg_dir[_PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
 pgd_t invalid_pg_dir[_PTRS_PER_PGD] __page_aligned_bss;
 #ifndef __PAGETABLE_PUD_FOLDED
 pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligned_bss;
+EXPORT_SYMBOL(invalid_pud_table);
 #endif
 #ifndef __PAGETABLE_PMD_FOLDED
 pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index ca17dd3a1915..d5d682f3d29f 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -17,7 +17,7 @@
 #define PTRS_PER_PTE_BITS	(PAGE_SHIFT - 3)
 
 	.macro tlb_do_page_fault, write
-	SYM_FUNC_START(tlb_do_page_fault_\write)
+	SYM_CODE_START(tlb_do_page_fault_\write)
 	SAVE_ALL
 	csrrd		a2, LOONGARCH_CSR_BADV
 	move		a0, sp
@@ -25,13 +25,13 @@
 	li.w		a1, \write
 	bl		do_page_fault
 	RESTORE_ALL_AND_RET
-	SYM_FUNC_END(tlb_do_page_fault_\write)
+	SYM_CODE_END(tlb_do_page_fault_\write)
 	.endm
 
 	tlb_do_page_fault 0
 	tlb_do_page_fault 1
 
-SYM_FUNC_START(handle_tlb_protect)
+SYM_CODE_START(handle_tlb_protect)
 	BACKUP_T0T1
 	SAVE_ALL
 	move		a0, sp
@@ -41,9 +41,9 @@ SYM_FUNC_START(handle_tlb_protect)
 	la_abs		t0, do_page_fault
 	jirl		ra, t0, 0
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_tlb_protect)
+SYM_CODE_END(handle_tlb_protect)
 
-SYM_FUNC_START(handle_tlb_load)
+SYM_CODE_START(handle_tlb_load)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
@@ -187,16 +187,16 @@ nopage_tlb_load:
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_0
 	jr		t0
-SYM_FUNC_END(handle_tlb_load)
+SYM_CODE_END(handle_tlb_load)
 
-SYM_FUNC_START(handle_tlb_load_ptw)
+SYM_CODE_START(handle_tlb_load_ptw)
 	csrwr		t0, LOONGARCH_CSR_KS0
 	csrwr		t1, LOONGARCH_CSR_KS1
 	la_abs		t0, tlb_do_page_fault_0
 	jr		t0
-SYM_FUNC_END(handle_tlb_load_ptw)
+SYM_CODE_END(handle_tlb_load_ptw)
 
-SYM_FUNC_START(handle_tlb_store)
+SYM_CODE_START(handle_tlb_store)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
@@ -343,16 +343,16 @@ nopage_tlb_store:
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
-SYM_FUNC_END(handle_tlb_store)
+SYM_CODE_END(handle_tlb_store)
 
-SYM_FUNC_START(handle_tlb_store_ptw)
+SYM_CODE_START(handle_tlb_store_ptw)
 	csrwr		t0, LOONGARCH_CSR_KS0
 	csrwr		t1, LOONGARCH_CSR_KS1
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
-SYM_FUNC_END(handle_tlb_store_ptw)
+SYM_CODE_END(handle_tlb_store_ptw)
 
-SYM_FUNC_START(handle_tlb_modify)
+SYM_CODE_START(handle_tlb_modify)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
@@ -497,16 +497,16 @@ nopage_tlb_modify:
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
-SYM_FUNC_END(handle_tlb_modify)
+SYM_CODE_END(handle_tlb_modify)
 
-SYM_FUNC_START(handle_tlb_modify_ptw)
+SYM_CODE_START(handle_tlb_modify_ptw)
 	csrwr		t0, LOONGARCH_CSR_KS0
 	csrwr		t1, LOONGARCH_CSR_KS1
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
-SYM_FUNC_END(handle_tlb_modify_ptw)
+SYM_CODE_END(handle_tlb_modify_ptw)
 
-SYM_FUNC_START(handle_tlb_refill)
+SYM_CODE_START(handle_tlb_refill)
 	csrwr		t0, LOONGARCH_CSR_TLBRSAVE
 	csrrd		t0, LOONGARCH_CSR_PGD
 	lddir		t0, t0, 3
@@ -521,4 +521,4 @@ SYM_FUNC_START(handle_tlb_refill)
 	tlbfill
 	csrrd		t0, LOONGARCH_CSR_TLBRSAVE
 	ertn
-SYM_FUNC_END(handle_tlb_refill)
+SYM_CODE_END(handle_tlb_refill)
diff --git a/arch/powerpc/kernel/head_85xx.S b/arch/powerpc/kernel/head_85xx.S
index fdbee1093e2b..f9634111e82e 100644
--- a/arch/powerpc/kernel/head_85xx.S
+++ b/arch/powerpc/kernel/head_85xx.S
@@ -396,7 +396,7 @@ interrupt_base:
 #ifdef CONFIG_PPC_FPU
 	FP_UNAVAILABLE_EXCEPTION
 #else
-	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, unknown_exception)
+	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, emulation_assist_interrupt)
 #endif
 
 	/* System Call Interrupt */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d2a446216444..d35ba3ac218b 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -948,6 +948,8 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Parse memory topology */
 	mem_topology_setup();
+	/* Set max_mapnr before paging_init() */
+	set_max_mapnr(max_pfn);
 
 	/*
 	 * Release secondary cpus out of their spinloops at 0x60 now that
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8b121df7b08f..07e8f4f1e07f 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -288,7 +288,6 @@ void __init mem_init(void)
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-	set_max_mapnr(max_pfn);
 
 	kasan_late_init();
 
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 56a73134b49e..58108f0eb3fd 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -139,6 +139,7 @@ soc {
 		interrupt-parent = <&plic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		dma-noncoherent;
 		ranges;
 
 		plic: interrupt-controller@ffd8000000 {
diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index c67f59db7a51..f66d642251fe 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -57,6 +57,7 @@ static void kasan_populate_shadow(void)
 	pmd_t pmd_z = __pmd(__pa(kasan_early_shadow_pte) | _SEGMENT_ENTRY);
 	pud_t pud_z = __pud(__pa(kasan_early_shadow_pmd) | _REGION3_ENTRY);
 	p4d_t p4d_z = __p4d(__pa(kasan_early_shadow_pud) | _REGION2_ENTRY);
+	unsigned long memgap_start = 0;
 	unsigned long untracked_end;
 	unsigned long start, end;
 	int i;
@@ -101,8 +102,12 @@ static void kasan_populate_shadow(void)
 	 * +- shadow end ----+---------+- shadow end ---+
 	 */
 
-	for_each_physmem_usable_range(i, &start, &end)
+	for_each_physmem_usable_range(i, &start, &end) {
 		kasan_populate(start, end, POPULATE_KASAN_MAP_SHADOW);
+		if (memgap_start && physmem_info.info_source == MEM_DETECT_DIAG260)
+			kasan_populate(memgap_start, start, POPULATE_KASAN_ZERO_SHADOW);
+		memgap_start = end;
+	}
 	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
 		untracked_end = VMALLOC_START;
 		/* shallowly populate kasan shadow for vmalloc and modules */
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index bad7aa920cdc..d2b81cf2e16d 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -9,11 +9,6 @@
  *
  * The TD-2000 and certain older devices use a different protocol.
  * Try the fit2 protocol module with them.
- *
- * NB:  The FIT adapters do not appear to support the control
- * registers.  So, we map ALT_STATUS to STATUS and NO-OP writes
- * to the device control register - this means that IDE reset
- * will not work on these devices.
  */
 
 #include <linux/module.h>
@@ -37,8 +32,7 @@
 
 static void fit3_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 {
-	if (cont == 1)
-		return;
+	regr += cont << 3;
 
 	switch (pi->mode) {
 	case 0:
@@ -59,11 +53,7 @@ static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
 {
 	int  a, b;
 
-	if (cont) {
-		if (regr != 6)
-			return 0xff;
-		regr = 7;
-	}
+	regr += cont << 3;
 
 	switch (pi->mode) {
 	case 0:
diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index cf87bbb52f1f..a7adfdcb5e27 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -80,6 +80,72 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
 	return (nsect == 0x55) && (lbal == 0xaa);
 }
 
+static int pata_parport_wait_after_reset(struct ata_link *link,
+					 unsigned int devmask,
+					 unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct pi_adapter *pi = ap->host->private_data;
+	unsigned int dev0 = devmask & (1 << 0);
+	unsigned int dev1 = devmask & (1 << 1);
+	int rc, ret = 0;
+
+	ata_msleep(ap, ATA_WAIT_AFTER_RESET);
+
+	/* always check readiness of the master device */
+	rc = ata_sff_wait_ready(link, deadline);
+	if (rc) {
+		/*
+		 * some adapters return bogus values if master device is not
+		 * present, so don't abort now if a slave device is present
+		 */
+		if (!dev1)
+			return rc;
+		ret = -ENODEV;
+	}
+
+	/*
+	 * if device 1 was found in ata_devchk, wait for register
+	 * access briefly, then wait for BSY to clear.
+	 */
+	if (dev1) {
+		int i;
+
+		pata_parport_dev_select(ap, 1);
+
+		/*
+		 * Wait for register access.  Some ATAPI devices fail
+		 * to set nsect/lbal after reset, so don't waste too
+		 * much time on it.  We're gonna wait for !BSY anyway.
+		 */
+		for (i = 0; i < 2; i++) {
+			u8 nsect, lbal;
+
+			nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
+			lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
+			if (nsect == 1 && lbal == 1)
+				break;
+			/* give drive a breather */
+			ata_msleep(ap, 50);
+		}
+
+		rc = ata_sff_wait_ready(link, deadline);
+		if (rc) {
+			if (rc != -ENODEV)
+				return rc;
+			ret = rc;
+		}
+	}
+
+	pata_parport_dev_select(ap, 0);
+	if (dev1)
+		pata_parport_dev_select(ap, 1);
+	if (dev0)
+		pata_parport_dev_select(ap, 0);
+
+	return ret;
+}
+
 static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
 				      unsigned long deadline)
 {
@@ -94,7 +160,7 @@ static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	ap->last_ctl = ap->ctl;
 
 	/* wait the port to become ready */
-	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
+	return pata_parport_wait_after_reset(&ap->link, devmask, deadline);
 }
 
 static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 19ad0e788646..a61757835695 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -512,6 +512,7 @@ struct bcm4377_hw {
 	unsigned long disable_aspm : 1;
 	unsigned long broken_ext_scan : 1;
 	unsigned long broken_mws_transport_config : 1;
+	unsigned long broken_le_coded : 1;
 
 	int (*send_calibration)(struct bcm4377_data *bcm4377);
 	int (*send_ptb)(struct bcm4377_data *bcm4377,
@@ -2372,6 +2373,8 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev->quirks);
 	if (bcm4377->hw->broken_ext_scan)
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
+	if (bcm4377->hw->broken_le_coded)
+		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
 
 	pci_set_drvdata(pdev, bcm4377);
 	hci_set_drvdata(hdev, bcm4377);
@@ -2461,6 +2464,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
 		.bar0_core2_window2 = 0x18107000,
 		.has_bar0_core2_window2 = true,
 		.broken_mws_transport_config = true,
+		.broken_le_coded = true,
 		.send_calibration = bcm4378_send_calibration,
 		.send_ptb = bcm4378_send_ptb,
 	},
@@ -2474,6 +2478,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
 		.has_bar0_core2_window2 = true,
 		.clear_pciecfg_subsystem_ctrl_bit19 = true,
 		.broken_mws_transport_config = true,
+		.broken_le_coded = true,
 		.send_calibration = bcm4387_send_calibration,
 		.send_ptb = bcm4378_send_ptb,
 	},
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 89e82508c133..002833fb1fa0 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3668,6 +3668,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_disable(base->dev);
 
  report_failure:
 	d40_err(dev, "probe failed\n");
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1599f1176842..9cfac61812f6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -273,9 +273,13 @@ static __init int efivar_ssdt_load(void)
 		if (status == EFI_NOT_FOUND) {
 			break;
 		} else if (status == EFI_BUFFER_TOO_SMALL) {
-			name = krealloc(name, name_size, GFP_KERNEL);
-			if (!name)
+			efi_char16_t *name_tmp =
+				krealloc(name, name_size, GFP_KERNEL);
+			if (!name_tmp) {
+				kfree(name);
 				return -ENOMEM;
+			}
+			name = name_tmp;
 			continue;
 		}
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 146477da2b98..a5a856a7639e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -648,11 +648,8 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 			break;
 
 		case EFI_UNACCEPTED_MEMORY:
-			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
-				efi_warn_once(
-"The system has unaccepted memory,  but kernel does not support it\nConsider enabling CONFIG_UNACCEPTED_MEMORY\n");
+			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
 				continue;
-			}
 			e820_type = E820_TYPE_RAM;
 			process_unaccepted_memory(d->phys_addr,
 						  d->phys_addr + PAGE_SIZE * d->num_pages);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0dc9c655c4fb..aac52d9754e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -47,7 +47,6 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
 bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
 {
 	switch (ctx_prio) {
-	case AMDGPU_CTX_PRIORITY_UNSET:
 	case AMDGPU_CTX_PRIORITY_VERY_LOW:
 	case AMDGPU_CTX_PRIORITY_LOW:
 	case AMDGPU_CTX_PRIORITY_NORMAL:
@@ -55,6 +54,7 @@ bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
 	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
 		return true;
 	default:
+	case AMDGPU_CTX_PRIORITY_UNSET:
 		return false;
 	}
 }
@@ -64,7 +64,8 @@ amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
 {
 	switch (ctx_prio) {
 	case AMDGPU_CTX_PRIORITY_UNSET:
-		return DRM_SCHED_PRIORITY_UNSET;
+		pr_warn_once("AMD-->DRM context priority value UNSET-->NORMAL");
+		return DRM_SCHED_PRIORITY_NORMAL;
 
 	case AMDGPU_CTX_PRIORITY_VERY_LOW:
 		return DRM_SCHED_PRIORITY_MIN;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 12210598e5b8..ba3a87cb88cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -403,7 +403,10 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 				continue;
 		}
 
-		r = amdgpu_vm_clear_freed(adev, vm, NULL);
+		/* Reserve fences for two SDMA page table updates */
+		r = dma_resv_reserve_fences(resv, 2);
+		if (!r)
+			r = amdgpu_vm_clear_freed(adev, vm, NULL);
 		if (!r)
 			r = amdgpu_vm_handle_moved(adev, vm);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 63009db8b5a7..d156eeef466f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -586,7 +586,8 @@ static void dcn10_dmcu_set_psr_enable(struct dmcu *dmcu, bool enable, bool wait)
 				if (state == PSR_STATE0)
 					break;
 			}
-			fsleep(500);
+			/* must *not* be fsleep - this can be called from high irq levels */
+			udelay(500);
 		}
 
 		/* assert if max retry hit */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 0f24b6fbd220..4704c9c85ee6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -216,7 +216,8 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait, uint8
 					break;
 			}
 
-			fsleep(500);
+			/* must *not* be fsleep - this can be called from high irq levels */
+			udelay(500);
 		}
 
 		/* assert if max retry hit */
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 7726a72befc5..d48b39132b32 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -232,10 +232,6 @@ void ttm_device_fini(struct ttm_device *bdev)
 	struct ttm_resource_manager *man;
 	unsigned i;
 
-	man = ttm_manager_type(bdev, TTM_PL_SYSTEM);
-	ttm_resource_manager_set_used(man, false);
-	ttm_set_driver_manager(bdev, TTM_PL_SYSTEM, NULL);
-
 	mutex_lock(&ttm_global_mutex);
 	list_del(&bdev->device_list);
 	mutex_unlock(&ttm_global_mutex);
@@ -243,6 +239,10 @@ void ttm_device_fini(struct ttm_device *bdev)
 	drain_workqueue(bdev->wq);
 	destroy_workqueue(bdev->wq);
 
+	man = ttm_manager_type(bdev, TTM_PL_SYSTEM);
+	ttm_resource_manager_set_used(man, false);
+	ttm_set_driver_manager(bdev, TTM_PL_SYSTEM, NULL);
+
 	spin_lock(&bdev->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i)
 		if (list_empty(&man->lru[0]))
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 6132c5b3db9c..8311e1028ddb 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -610,7 +610,8 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 
 	flat_buf->vaddr = dma_alloc_noncoherent(real_dev, etr_buf->size,
 						&flat_buf->daddr,
-						DMA_FROM_DEVICE, GFP_KERNEL);
+						DMA_FROM_DEVICE,
+						GFP_KERNEL | __GFP_NOWARN);
 	if (!flat_buf->vaddr) {
 		kfree(flat_buf);
 		return -ENOMEM;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index cefc74b3b34b..22d16d80efb9 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1753,6 +1753,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 		psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
 		!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10);
 	const struct rmi_device_platform_data pdata = {
+		.reset_delay_ms = 30,
 		.sensor_pdata = {
 			.sensor_type = rmi_sensor_touchpad,
 			.axis_align.flip_y = true,
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 7059a2762aeb..b0b099b5528a 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -235,12 +235,29 @@ static void rmi_smb_clear_state(struct rmi_smb_xport *rmi_smb)
 
 static int rmi_smb_enable_smbus_mode(struct rmi_smb_xport *rmi_smb)
 {
-	int retval;
+	struct i2c_client *client = rmi_smb->client;
+	int smbus_version;
+
+	/*
+	 * psmouse driver resets the controller, we only need to wait
+	 * to give the firmware chance to fully reinitialize.
+	 */
+	if (rmi_smb->xport.pdata.reset_delay_ms)
+		msleep(rmi_smb->xport.pdata.reset_delay_ms);
 
 	/* we need to get the smbus version to activate the touchpad */
-	retval = rmi_smb_get_version(rmi_smb);
-	if (retval < 0)
-		return retval;
+	smbus_version = rmi_smb_get_version(rmi_smb);
+	if (smbus_version < 0)
+		return smbus_version;
+
+	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
+		smbus_version);
+
+	if (smbus_version != 2 && smbus_version != 3) {
+		dev_err(&client->dev, "Unrecognized SMB version %d\n",
+				smbus_version);
+		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -253,11 +270,10 @@ static int rmi_smb_reset(struct rmi_transport_dev *xport, u16 reset_addr)
 	rmi_smb_clear_state(rmi_smb);
 
 	/*
-	 * we do not call the actual reset command, it has to be handled in
-	 * PS/2 or there will be races between PS/2 and SMBus.
-	 * PS/2 should ensure that a psmouse_reset is called before
-	 * intializing the device and after it has been removed to be in a known
-	 * state.
+	 * We do not call the actual reset command, it has to be handled in
+	 * PS/2 or there will be races between PS/2 and SMBus. PS/2 should
+	 * ensure that a psmouse_reset is called before initializing the
+	 * device and after it has been removed to be in a known state.
 	 */
 	return rmi_smb_enable_smbus_mode(rmi_smb);
 }
@@ -272,7 +288,6 @@ static int rmi_smb_probe(struct i2c_client *client)
 {
 	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct rmi_smb_xport *rmi_smb;
-	int smbus_version;
 	int error;
 
 	if (!pdata) {
@@ -311,18 +326,9 @@ static int rmi_smb_probe(struct i2c_client *client)
 	rmi_smb->xport.proto_name = "smb";
 	rmi_smb->xport.ops = &rmi_smb_ops;
 
-	smbus_version = rmi_smb_get_version(rmi_smb);
-	if (smbus_version < 0)
-		return smbus_version;
-
-	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
-		smbus_version);
-
-	if (smbus_version != 2 && smbus_version != 3) {
-		dev_err(&client->dev, "Unrecognized SMB version %d\n",
-				smbus_version);
-		return -ENODEV;
-	}
+	error = rmi_smb_enable_smbus_mode(rmi_smb);
+	if (error)
+		return error;
 
 	i2c_set_clientdata(client, rmi_smb);
 
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 4adeee1bc391..e8d01b14ccdd 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -155,8 +155,16 @@ static int __init riscv_intc_init(struct device_node *node,
 	 * for each INTC DT node. We only need to do INTC initialization
 	 * for the INTC DT node belonging to boot CPU (or boot HART).
 	 */
-	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
+	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id()) {
+		/*
+		 * The INTC nodes of each CPU are suppliers for downstream
+		 * interrupt controllers (such as PLIC, IMSIC and APLIC
+		 * direct-mode) so we should mark an INTC node as initialized
+		 * if we are not creating IRQ domain for it.
+		 */
+		fwnode_dev_initialized(of_fwnode_handle(node), true);
 		return 0;
+	}
 
 	return riscv_intc_init_common(of_node_to_fwnode(node));
 }
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b5fa76ce5046..cb4b195bc849 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -459,6 +459,7 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static void stm32_irq_ack(struct irq_data *d)
diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
index 3af6125a2eee..4d9fd76e2f60 100644
--- a/drivers/media/i2c/ov8858.c
+++ b/drivers/media/i2c/ov8858.c
@@ -1850,9 +1850,9 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
 	}
 
 	ret = v4l2_fwnode_endpoint_parse(endpoint, &vep);
+	fwnode_handle_put(endpoint);
 	if (ret) {
 		dev_err(dev, "Failed to parse endpoint: %d\n", ret);
-		fwnode_handle_put(endpoint);
 		return ret;
 	}
 
@@ -1864,12 +1864,9 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
 	default:
 		dev_err(dev, "Unsupported number of data lanes %u\n",
 			ov8858->num_lanes);
-		fwnode_handle_put(endpoint);
 		return -EINVAL;
 	}
 
-	ov8858->subdev.fwnode = endpoint;
-
 	return 0;
 }
 
@@ -1913,7 +1910,7 @@ static int ov8858_probe(struct i2c_client *client)
 
 	ret = ov8858_init_ctrls(ov8858);
 	if (ret)
-		goto err_put_fwnode;
+		return ret;
 
 	sd = &ov8858->subdev;
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
@@ -1964,8 +1961,6 @@ static int ov8858_probe(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 err_free_handler:
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
-err_put_fwnode:
-	fwnode_handle_put(ov8858->subdev.fwnode);
 
 	return ret;
 }
@@ -1978,7 +1973,6 @@ static void ov8858_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(sd);
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
-	fwnode_handle_put(ov8858->subdev.fwnode);
 
 	pm_runtime_disable(&client->dev);
 	if (!pm_runtime_status_suspended(&client->dev))
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index ed4d0ef5e5c3..7e1acc68d435 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -71,6 +71,7 @@
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
+#define PCI_DEVICE_ID_TI_J721S2		0xb013
 #define PCI_DEVICE_ID_LS1088A			0x80c0
 #define PCI_DEVICE_ID_IMX8			0x0808
 
@@ -999,6 +1000,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM64),
 	  .driver_data = (kernel_ulong_t)&j721e_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721S2),
+	  .driver_data = (kernel_ulong_t)&j721e_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ff0fc18baf13..d8be69f4a0c3 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -348,7 +348,7 @@ static struct flexcan_devtype_data fsl_imx8mp_devtype_data = {
 static struct flexcan_devtype_data fsl_imx93_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
-		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_AUTO_STOP_MODE |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |
 		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
@@ -544,11 +544,6 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR) {
 		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
-	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE) {
-		/* For the auto stop mode, software do nothing, hardware will cover
-		 * all the operation automatically after system go into low power mode.
-		 */
-		return 0;
 	}
 
 	return flexcan_low_power_enter_ack(priv);
@@ -574,12 +569,6 @@ static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 	reg_mcr &= ~FLEXCAN_MCR_SLF_WAK;
 	priv->write(reg_mcr, &regs->mcr);
 
-	/* For the auto stop mode, hardware will exist stop mode
-	 * automatically after system go out of low power mode.
-	 */
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-		return 0;
-
 	return flexcan_low_power_exit_ack(priv);
 }
 
@@ -1994,13 +1983,18 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		ret = flexcan_setup_stop_mode_scfw(pdev);
 	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
 		ret = flexcan_setup_stop_mode_gpr(pdev);
-	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-		ret = 0;
 	else
 		/* return 0 directly if doesn't support stop mode feature */
 		return 0;
 
-	if (ret)
+	/* If ret is -EINVAL, this means SoC claim to support stop mode, but
+	 * dts file lack the stop mode property definition. For this case,
+	 * directly return 0, this will skip the wakeup capable setting and
+	 * will not block the driver probe.
+	 */
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
 		return ret;
 
 	device_set_wakeup_capable(&pdev->dev, true);
@@ -2320,16 +2314,8 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		if (device_may_wakeup(device)) {
+		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, true);
-			/* For auto stop mode, need to keep the clock on before
-			 * system go into low power mode. After system go into
-			 * low power mode, hardware will config the flexcan into
-			 * stop mode, and gate off the clock automatically.
-			 */
-			if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-				return 0;
-		}
 
 		err = pm_runtime_force_suspend(device);
 		if (err)
@@ -2347,15 +2333,9 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		/* For the wakeup in auto stop mode, no need to gate on the
-		 * clock here, hardware will do this automatically.
-		 */
-		if (!(device_may_wakeup(device) &&
-		      priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)) {
-			err = pm_runtime_force_resume(device);
-			if (err)
-				return err;
-		}
+		err = pm_runtime_force_resume(device);
+		if (err)
+			return err;
 
 		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, false);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 91402977780b..025c3417031f 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -68,8 +68,6 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
 /* Device supports RX via FIFO */
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
-/* auto enter stop mode to support wakeup */
-#define FLEXCAN_QUIRK_AUTO_STOP_MODE BIT(17)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 8d719f82854a..76de55306c4d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3816,6 +3816,8 @@ int t4_load_phy_fw(struct adapter *adap, int win,
 		 FW_PARAMS_PARAM_Z_V(FW_PARAMS_PARAM_DEV_PHYFW_DOWNLOAD));
 	ret = t4_set_params_timeout(adap, adap->mbox, adap->pf, 0, 1,
 				    &param, &val, 30000);
+	if (ret)
+		return ret;
 
 	/* If we have version number support, then check to see that the new
 	 * firmware got loaded properly.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 560800246573..285c13edc09f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -463,6 +463,17 @@ static int mlx5_esw_bridge_switchdev_event(struct notifier_block *nb,
 		/* only handle the event on peers */
 		if (mlx5_esw_bridge_is_local(dev, rep, esw))
 			break;
+
+		fdb_info = container_of(info,
+					struct switchdev_notifier_fdb_info,
+					info);
+		/* Mark for deletion to prevent the update wq task from
+		 * spuriously refreshing the entry which would mark it again as
+		 * offloaded in SW bridge. After this fallthrough to regular
+		 * async delete code.
+		 */
+		mlx5_esw_bridge_fdb_mark_deleted(dev, vport_num, esw_owner_vhca_id, br_offloads,
+						 fdb_info);
 		fallthrough;
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index f4fe1daa4afd..de1ed59239da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -1748,6 +1748,28 @@ void mlx5_esw_bridge_fdb_update_used(struct net_device *dev, u16 vport_num, u16
 	entry->lastuse = jiffies;
 }
 
+void mlx5_esw_bridge_fdb_mark_deleted(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
+				      struct mlx5_esw_bridge_offloads *br_offloads,
+				      struct switchdev_notifier_fdb_info *fdb_info)
+{
+	struct mlx5_esw_bridge_fdb_entry *entry;
+	struct mlx5_esw_bridge *bridge;
+
+	bridge = mlx5_esw_bridge_from_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
+	if (!bridge)
+		return;
+
+	entry = mlx5_esw_bridge_fdb_lookup(bridge, fdb_info->addr, fdb_info->vid);
+	if (!entry) {
+		esw_debug(br_offloads->esw->dev,
+			  "FDB mark deleted entry with specified key not found (MAC=%pM,vid=%u,vport=%u)\n",
+			  fdb_info->addr, fdb_info->vid, vport_num);
+		return;
+	}
+
+	entry->flags |= MLX5_ESW_BRIDGE_FLAG_DELETED;
+}
+
 void mlx5_esw_bridge_fdb_create(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
 				struct mlx5_esw_bridge_offloads *br_offloads,
 				struct switchdev_notifier_fdb_info *fdb_info)
@@ -1810,7 +1832,8 @@ void mlx5_esw_bridge_update(struct mlx5_esw_bridge_offloads *br_offloads)
 			unsigned long lastuse =
 				(unsigned long)mlx5_fc_query_lastuse(entry->ingress_counter);
 
-			if (entry->flags & MLX5_ESW_BRIDGE_FLAG_ADDED_BY_USER)
+			if (entry->flags & (MLX5_ESW_BRIDGE_FLAG_ADDED_BY_USER |
+					    MLX5_ESW_BRIDGE_FLAG_DELETED))
 				continue;
 
 			if (time_after(lastuse, entry->lastuse))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
index c2c7c70d99eb..d6f539161993 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
@@ -62,6 +62,9 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
 void mlx5_esw_bridge_fdb_update_used(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
 				     struct mlx5_esw_bridge_offloads *br_offloads,
 				     struct switchdev_notifier_fdb_info *fdb_info);
+void mlx5_esw_bridge_fdb_mark_deleted(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
+				      struct mlx5_esw_bridge_offloads *br_offloads,
+				      struct switchdev_notifier_fdb_info *fdb_info);
 void mlx5_esw_bridge_fdb_create(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
 				struct mlx5_esw_bridge_offloads *br_offloads,
 				struct switchdev_notifier_fdb_info *fdb_info);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
index 4911cc32161b..7c251af566c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
@@ -133,6 +133,7 @@ struct mlx5_esw_bridge_mdb_key {
 enum {
 	MLX5_ESW_BRIDGE_FLAG_ADDED_BY_USER = BIT(0),
 	MLX5_ESW_BRIDGE_FLAG_PEER = BIT(1),
+	MLX5_ESW_BRIDGE_FLAG_DELETED = BIT(2),
 };
 
 enum {
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 14497e5558bf..b64df36fbb11 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3656,6 +3656,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
@@ -3696,6 +3698,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
@@ -4059,6 +4063,9 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 	for (i = 0; wait && i < 5000; i++) {
 		u32 ocp_data;
 
+		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+			break;
+
 		usleep_range(1000, 2000);
 		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
 		if ((ocp_data & PATCH_READY) ^ check)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 321156ca273d..eb65170b97ff 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -688,7 +688,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
 /*
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
- * claim it.
+ * claim it. The same applies on the VanGogh platform device ([1022:163a]).
  *
  * But the dwc3 driver is a more specific driver for this device, and we'd
  * prefer to use it instead of xhci. To prevent xhci from claiming the
@@ -696,7 +696,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
  * defines as "USB device (not host controller)". The dwc3 driver can then
  * claim it based on its Vendor and Device ID.
  */
-static void quirk_amd_nl_class(struct pci_dev *pdev)
+static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
@@ -706,7 +706,9 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
-		quirk_amd_nl_class);
+		quirk_amd_dwc_class);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VANGOGH_USB,
+		quirk_amd_dwc_class);
 
 /*
  * Synopsys USB 3.x host HAPS platform has a class code of
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index f3696a54a2bd..d9615ad60012 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -607,24 +607,25 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	if (vring->cur_len + sizeof(u64) <= len) {
 		/* The whole word. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       sizeof(u64));
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       sizeof(u64));
+		} else {
+			memcpy(&data, addr + vring->cur_len,
+			       sizeof(u64));
 		}
 		vring->cur_len += sizeof(u64);
 	} else {
 		/* Leftover bytes. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       len - vring->cur_len);
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       len - vring->cur_len);
+		} else {
+			data = 0;
+			memcpy(&data, addr + vring->cur_len,
+			       len - vring->cur_len);
 		}
 		vring->cur_len = len;
 	}
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 3791aec69ddc..0d2e72a966c9 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -29,7 +29,7 @@
 struct class *power_supply_class;
 EXPORT_SYMBOL_GPL(power_supply_class);
 
-ATOMIC_NOTIFIER_HEAD(power_supply_notifier);
+BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
 EXPORT_SYMBOL_GPL(power_supply_notifier);
 
 static struct device_type power_supply_dev_type;
@@ -97,7 +97,7 @@ static void power_supply_changed_work(struct work_struct *work)
 		class_for_each_device(power_supply_class, NULL, psy,
 				      __power_supply_changed_work);
 		power_supply_update_leds(psy);
-		atomic_notifier_call_chain(&power_supply_notifier,
+		blocking_notifier_call_chain(&power_supply_notifier,
 				PSY_EVENT_PROP_CHANGED, psy);
 		kobject_uevent(&psy->dev.kobj, KOBJ_CHANGE);
 		spin_lock_irqsave(&psy->changed_lock, flags);
@@ -1262,13 +1262,13 @@ static void power_supply_dev_release(struct device *dev)
 
 int power_supply_reg_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&power_supply_notifier, nb);
+	return blocking_notifier_chain_register(&power_supply_notifier, nb);
 }
 EXPORT_SYMBOL_GPL(power_supply_reg_notifier);
 
 void power_supply_unreg_notifier(struct notifier_block *nb)
 {
-	atomic_notifier_chain_unregister(&power_supply_notifier, nb);
+	blocking_notifier_chain_unregister(&power_supply_notifier, nb);
 }
 EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c3c1f466fe01..605013d3ee83 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12913,8 +12913,10 @@ _mpt3sas_init(void)
 	mpt3sas_ctl_init(hbas_to_enumerate);
 
 	error = pci_register_driver(&mpt3sas_driver);
-	if (error)
+	if (error) {
+		mpt3sas_ctl_exit(hbas_to_enumerate);
 		scsih_exit();
+	}
 
 	return error;
 }
diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index eb353561509a..01a2b9de18b7 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -353,8 +353,9 @@ static int npcm_fiu_uma_read(struct spi_mem *mem,
 		uma_cfg |= ilog2(op->cmd.buswidth);
 		uma_cfg |= ilog2(op->addr.buswidth)
 			<< NPCM_FIU_UMA_CFG_ADBPCK_SHIFT;
-		uma_cfg |= ilog2(op->dummy.buswidth)
-			<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
+		if (op->dummy.nbytes)
+			uma_cfg |= ilog2(op->dummy.buswidth)
+				<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
 		uma_cfg |= ilog2(op->data.buswidth)
 			<< NPCM_FIU_UMA_CFG_RDBPCK_SHIFT;
 		uma_cfg |= op->dummy.nbytes << NPCM_FIU_UMA_CFG_DBSIZ_SHIFT;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5574b4b61a25..897bd575330c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -4058,6 +4058,8 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 
 static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 {
+	if (dlci->gsm->dead)
+		return -EL2HLT;
 	if (dlci->adaption == 2) {
 		/* Send convergence layer type 2 empty data frame. */
 		gsm_modem_upd_via_data(dlci, brk);
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index d2d547b5da95..d4029f008bb2 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2427,6 +2427,153 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init			= pci_oxsemi_tornado_init,
 		.setup		= pci_oxsemi_tornado_setup,
 	},
+	/*
+	 * Brainboxes devices - all Oxsemi based
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4027,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4028,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4029,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4019,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4016,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4015,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400A,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400E,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400C,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400B,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400F,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4010,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4011,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x401D,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x401E,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4013,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4017,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4018,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8811,
@@ -4911,6 +5058,12 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b1_bt_1_115200 },
 
+	/*
+	 * IntaShield IS-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D60,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
 	/*
 	 * IntaShield IS-200
 	 */
@@ -4923,6 +5076,27 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
+	/*
+	 * IntaShield IX-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4027,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * IntaShield IX-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4028,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * IntaShield IX-400
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4029,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
 	/* Brainboxes Devices */
 	/*
 	* Brainboxes UC-101
@@ -4938,10 +5112,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
 	/*
-	 * Brainboxes UC-257
+	 * Brainboxes UC-253/UC-734
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0CA1,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
@@ -4977,6 +5155,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-310
 	 */
@@ -4987,6 +5173,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-313
 	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5001,6 +5195,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-346
 	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5012,6 +5210,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A82,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5024,12 +5226,94 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
-	 * Brainboxes UC-420/431
+	 * Brainboxes UC-420
 	 */
 	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-607
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-836
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UP-189
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-869
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C02,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C03,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-880
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes PX-101
 	 */
@@ -5062,7 +5346,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4015,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_4_15625000 },
+		pbn_oxsemi_2_15625000 },
 	/*
 	 * Brainboxes PX-260/PX-701
 	 */
@@ -5070,6 +5354,13 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_oxsemi_4_15625000 },
+	/*
+	 * Brainboxes PX-275/279
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0E41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_8_115200 },
 	/*
 	 * Brainboxes PX-310
 	 */
@@ -5117,16 +5408,38 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_oxsemi_4_15625000 },
 	/*
-	 * Brainboxes PX-803
+	 * Brainboxes PX-475
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x401D,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes PX-803/PX-857
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4009,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_b0_1_115200 },
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4018,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x401E,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_1_15625000 },
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-820
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4002,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4013,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
 	/*
 	 * Brainboxes PX-846
 	 */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 83c419ac78bc..0c6c633c0924 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -147,7 +147,7 @@ static void __uart_start(struct tty_struct *tty)
 
 	/* Increment the runtime PM usage count for the active check below */
 	err = pm_runtime_get(&port_dev->dev);
-	if (err < 0) {
+	if (err < 0 && err != -EINPROGRESS) {
 		pm_runtime_put_noidle(&port_dev->dev);
 		return;
 	}
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index e549022642e5..ea106ad665a1 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -663,12 +663,12 @@ static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 	if (WARN_ON(in && dev->ep0_out_pending)) {
 		ret = -ENODEV;
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_unlock;
 	}
 	if (WARN_ON(!in && dev->ep0_in_pending)) {
 		ret = -ENODEV;
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_unlock;
 	}
 
 	dev->req->buf = data;
@@ -683,7 +683,7 @@ static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 				"fail, usb_ep_queue returned %d\n", ret);
 		spin_lock_irqsave(&dev->lock, flags);
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_queue_failed;
 	}
 
 	ret = wait_for_completion_interruptible(&dev->ep0_done);
@@ -692,13 +692,16 @@ static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 		usb_ep_dequeue(dev->gadget->ep0, dev->req);
 		wait_for_completion(&dev->ep0_done);
 		spin_lock_irqsave(&dev->lock, flags);
-		goto out_done;
+		if (dev->ep0_status == -ECONNRESET)
+			dev->ep0_status = -EINTR;
+		goto out_interrupted;
 	}
 
 	spin_lock_irqsave(&dev->lock, flags);
-	ret = dev->ep0_status;
 
-out_done:
+out_interrupted:
+	ret = dev->ep0_status;
+out_queue_failed:
 	dev->ep0_urb_queued = false;
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -1067,7 +1070,7 @@ static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 				"fail, usb_ep_queue returned %d\n", ret);
 		spin_lock_irqsave(&dev->lock, flags);
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_queue_failed;
 	}
 
 	ret = wait_for_completion_interruptible(&done);
@@ -1076,13 +1079,16 @@ static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 		usb_ep_dequeue(ep->ep, ep->req);
 		wait_for_completion(&done);
 		spin_lock_irqsave(&dev->lock, flags);
-		goto out_done;
+		if (ep->status == -ECONNRESET)
+			ep->status = -EINTR;
+		goto out_interrupted;
 	}
 
 	spin_lock_irqsave(&dev->lock, flags);
-	ret = ep->status;
 
-out_done:
+out_interrupted:
+	ret = ep->status;
+out_queue_failed:
 	ep->urb_queued = false;
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
diff --git a/drivers/usb/storage/unusual_cypress.h b/drivers/usb/storage/unusual_cypress.h
index 0547daf116a2..5df40759d77a 100644
--- a/drivers/usb/storage/unusual_cypress.h
+++ b/drivers/usb/storage/unusual_cypress.h
@@ -19,7 +19,7 @@ UNUSUAL_DEV(  0x04b4, 0x6831, 0x0000, 0x9999,
 		"Cypress ISD-300LP",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
 
-UNUSUAL_DEV( 0x14cd, 0x6116, 0x0160, 0x0160,
+UNUSUAL_DEV( 0x14cd, 0x6116, 0x0150, 0x0160,
 		"Super Top",
 		"USB 2.0  SATA BRIDGE",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 1596afee6c86..7ca611497a52 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1625,6 +1625,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (PD_VDO_VID(p[0]) != USB_SID_PD)
 				break;
 
+			if (IS_ERR_OR_NULL(port->partner))
+				break;
+
 			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
 				typec_partner_set_svdm_version(port->partner,
 							       PD_VDO_SVDM_VER(p[0]));
@@ -3970,6 +3973,8 @@ static void run_state_machine(struct tcpm_port *port)
 		port->potential_contaminant = ((port->enter_state == SRC_ATTACH_WAIT &&
 						port->state == SRC_UNATTACHED) ||
 					       (port->enter_state == SNK_ATTACH_WAIT &&
+						port->state == SNK_UNATTACHED) ||
+					       (port->enter_state == SNK_DEBOUNCED &&
 						port->state == SNK_UNATTACHED));
 
 	port->enter_state = port->state;
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index cba2b113b28b..a73114c1c691 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3440,11 +3440,15 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	}
 
 	info->fix.mmio_start = raddr;
+#if defined(__i386__) || defined(__ia64__)
 	/*
 	 * By using strong UC we force the MTRR to never have an
 	 * effect on the MMIO region on both non-PAT and PAT systems.
 	 */
 	par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
+#else
+	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+#endif
 	if (par->ati_regbase == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index ad65554b33c3..0be95b4e14fd 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1648,13 +1648,13 @@ static int omapfb_do_probe(struct platform_device *pdev,
 	}
 	fbdev->int_irq = platform_get_irq(pdev, 0);
 	if (fbdev->int_irq < 0) {
-		r = ENXIO;
+		r = -ENXIO;
 		goto cleanup;
 	}
 
 	fbdev->ext_irq = platform_get_irq(pdev, 1);
 	if (fbdev->ext_irq < 0) {
-		r = ENXIO;
+		r = -ENXIO;
 		goto cleanup;
 	}
 
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 78d85dae8ec8..c4559768f00f 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1931,10 +1931,10 @@ static void uvesafb_exit(void)
 		}
 	}
 
-	cn_del_callback(&uvesafb_cn_id);
 	driver_remove_file(&uvesafb_driver.driver, &driver_attr_v86d);
 	platform_device_unregister(uvesafb_device);
 	platform_driver_unregister(&uvesafb_driver);
+	cn_del_callback(&uvesafb_cn_id);
 }
 
 module_exit(uvesafb_exit);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4b0ba067e9c9..e40aafbfa7b9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -709,8 +709,8 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentry)
 		if (!d_same_name(udentry, pdentry, &dname))
 			goto next;
 
+		found = dget_dlock(udentry);
 		spin_unlock(&udentry->d_lock);
-		found = dget(udentry);
 		break;
 next:
 		spin_unlock(&udentry->d_lock);
diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index a9d82bbb4729..0b52bc968108 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1736,10 +1736,8 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			le_b = NULL;
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
-			if (!attr_b) {
-				err = -ENOENT;
-				goto out;
-			}
+			if (!attr_b)
+				return -ENOENT;
 
 			attr = attr_b;
 			le = le_b;
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 42631b31adf1..7c01735d1219 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -52,7 +52,8 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 
 	if (!attr->non_res) {
 		lsize = le32_to_cpu(attr->res.data_size);
-		le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
+		/* attr is resident: lsize < record_size (1K or 4K) */
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
@@ -80,7 +81,17 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 		if (err < 0)
 			goto out;
 
-		le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
+		/* attr is nonresident.
+		 * The worst case:
+		 * 1T (2^40) extremely fragmented file.
+		 * cluster = 4K (2^12) => 2^28 fragments
+		 * 2^9 fragments per one record => 2^19 records
+		 * 2^5 bytes of ATTR_LIST_ENTRY per one record => 2^24 bytes.
+		 *
+		 * the result is 16M bytes per attribute list.
+		 * Use kvmalloc to allocate in range [several Kbytes - dozen Mbytes]
+		 */
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 107e808e06ea..d66055e30aff 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -659,7 +659,8 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 		wnd->bits_last = wbits;
 
 	wnd->free_bits =
-		kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
+		kvmalloc_array(wnd->nwnd, sizeof(u16), GFP_KERNEL | __GFP_ZERO);
+
 	if (!wnd->free_bits)
 		return -ENOMEM;
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 063a6654199b..ec0566b322d5 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -309,7 +309,11 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		return 0;
 	}
 
-	dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+	/* NTFS: symlinks are "dir + reparse" or "file + reparse" */
+	if (fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT)
+		dt_type = DT_LNK;
+	else
+		dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
 
 	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
 }
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 16bd9faa2d28..05fb3dbe3907 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2148,7 +2148,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
-		if (i == idx)
+		if (i == idx || !pg)
 			continue;
 		unlock_page(pg);
 		put_page(pg);
@@ -3208,6 +3208,12 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 		if (!fname || !memcmp(&fname->dup, dup, sizeof(fname->dup)))
 			continue;
 
+		/* Check simple case when parent inode equals current inode. */
+		if (ino_get(&fname->home) == ni->vfs_inode.i_ino) {
+			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+			continue;
+		}
+
 		/* ntfs_iget5 may sleep. */
 		dir = ntfs_iget5(sb, &fname->home, NULL);
 		if (IS_ERR(dir)) {
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 12f28cdf5c83..98ccb6650858 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2168,8 +2168,10 @@ static int last_log_lsn(struct ntfs_log *log)
 
 			if (!page) {
 				page = kmalloc(log->page_size, GFP_NOFS);
-				if (!page)
-					return -ENOMEM;
+				if (!page) {
+					err = -ENOMEM;
+					goto out;
+				}
 			}
 
 			/*
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 9ddb2ab23b95..fbfe21dbb425 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -983,18 +983,11 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 	if (err)
 		return err;
 
-	mark_inode_dirty(&ni->vfs_inode);
+	mark_inode_dirty_sync(&ni->vfs_inode);
 	/* verify(!ntfs_update_mftmirr()); */
 
-	/*
-	 * If we used wait=1, sync_inode_metadata waits for the io for the
-	 * inode to finish. It hangs when media is removed.
-	 * So wait=0 is sent down to sync_inode_metadata
-	 * and filemap_fdatawrite is used for the data blocks.
-	 */
-	err = sync_inode_metadata(&ni->vfs_inode, 0);
-	if (!err)
-		err = filemap_fdatawrite(ni->vfs_inode.i_mapping);
+	/* write mft record on disk. */
+	err = _ni_write_inode(&ni->vfs_inode, 1);
 
 	return err;
 }
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index c12ebffc94da..02cc91ed8835 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -193,8 +193,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 {
 	const struct MFT_REC *rec = mi->mrec;
 	u32 used = le32_to_cpu(rec->used);
-	u32 t32, off, asize;
+	u32 t32, off, asize, prev_type;
 	u16 t16;
+	u64 data_size, alloc_size, tot_size;
 
 	if (!attr) {
 		u32 total = le32_to_cpu(rec->total);
@@ -213,6 +214,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (!is_rec_inuse(rec))
 			return NULL;
 
+		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
 		/* Check if input attr inside record. */
@@ -226,11 +228,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 		}
 
-		if (off + asize < off) {
-			/* Overflow check. */
+		/* Overflow check. */
+		if (off + asize < off)
 			return NULL;
-		}
 
+		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
@@ -250,7 +252,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* 0x100 is last known attribute for now. */
 	t32 = le32_to_cpu(attr->type);
-	if ((t32 & 0xf) || (t32 > 0x100))
+	if (!t32 || (t32 & 0xf) || (t32 > 0x100))
+		return NULL;
+
+	/* attributes in record must be ordered by type */
+	if (t32 < prev_type)
 		return NULL;
 
 	/* Check overflow and boundary. */
@@ -259,16 +265,15 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
+		/* Check resident fields. */
 		if (asize < SIZEOF_RESIDENT)
 			return NULL;
 
 		t16 = le16_to_cpu(attr->res.data_off);
-
 		if (t16 > asize)
 			return NULL;
 
-		t32 = le32_to_cpu(attr->res.data_size);
-		if (t16 + t32 > asize)
+		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
 			return NULL;
 
 		t32 = sizeof(short) * attr->name_len;
@@ -278,21 +283,52 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		return attr;
 	}
 
-	/* Check some nonresident fields. */
-	if (attr->name_len &&
-	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
-		    le16_to_cpu(attr->nres.run_off)) {
+	/* Check nonresident fields. */
+	if (attr->non_res != 1)
+		return NULL;
+
+	t16 = le16_to_cpu(attr->nres.run_off);
+	if (t16 > asize)
+		return NULL;
+
+	t32 = sizeof(short) * attr->name_len;
+	if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
+		return NULL;
+
+	/* Check start/end vcn. */
+	if (le64_to_cpu(attr->nres.svcn) > le64_to_cpu(attr->nres.evcn) + 1)
+		return NULL;
+
+	data_size = le64_to_cpu(attr->nres.data_size);
+	if (le64_to_cpu(attr->nres.valid_size) > data_size)
 		return NULL;
-	}
 
-	if (attr->nres.svcn || !is_attr_ext(attr)) {
+	alloc_size = le64_to_cpu(attr->nres.alloc_size);
+	if (data_size > alloc_size)
+		return NULL;
+
+	t32 = mi->sbi->cluster_mask;
+	if (alloc_size & t32)
+		return NULL;
+
+	if (!attr->nres.svcn && is_attr_ext(attr)) {
+		/* First segment of sparse/compressed attribute */
+		if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+			return NULL;
+
+		tot_size = le64_to_cpu(attr->nres.total_size);
+		if (tot_size & t32)
+			return NULL;
+
+		if (tot_size > alloc_size)
+			return NULL;
+	} else {
 		if (asize + 8 < SIZEOF_NONRESIDENT)
 			return NULL;
 
 		if (attr->nres.c_unit)
 			return NULL;
-	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
-		return NULL;
+	}
 
 	return attr;
 }
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index d6b5170253a6..32c5de569992 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -453,15 +453,23 @@ static struct proc_dir_entry *proc_info_root;
  * ntfs3.1
  * cluster size
  * number of clusters
+ * total number of mft records
+ * number of used mft records ~= number of files + folders
+ * real state of ntfs "dirty"/"clean"
+ * current state of ntfs "dirty"/"clean"
 */
 static int ntfs3_volinfo(struct seq_file *m, void *o)
 {
 	struct super_block *sb = m->private;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 
-	seq_printf(m, "ntfs%d.%d\n%u\n%zu\n", sbi->volume.major_ver,
-		   sbi->volume.minor_ver, sbi->cluster_size,
-		   sbi->used.bitmap.nbits);
+	seq_printf(m, "ntfs%d.%d\n%u\n%zu\n\%zu\n%zu\n%s\n%s\n",
+		   sbi->volume.major_ver, sbi->volume.minor_ver,
+		   sbi->cluster_size, sbi->used.bitmap.nbits,
+		   sbi->mft.bitmap.nbits,
+		   sbi->mft.bitmap.nbits - wnd_zeroes(&sbi->mft.bitmap),
+		   sbi->volume.real_dirty ? "dirty" : "clean",
+		   (sbi->volume.flags & VOLUME_FLAG_DIRTY) ? "dirty" : "clean");
 
 	return 0;
 }
@@ -490,7 +498,12 @@ static ssize_t ntfs3_label_write(struct file *file, const char __user *buffer,
 	struct super_block *sb = pde_data(file_inode(file));
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	ssize_t ret = count;
-	u8 *label = kmalloc(count, GFP_NOFS);
+	u8 *label;
+
+	if (sb_rdonly(sb))
+		return -EROFS;
+
+	label = kmalloc(count, GFP_NOFS);
 
 	if (!label)
 		return -ENOMEM;
@@ -838,7 +851,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	int err;
 	u32 mb, gb, boot_sector_size, sct_per_clst, record_size;
-	u64 sectors, clusters, mlcn, mlcn2;
+	u64 sectors, clusters, mlcn, mlcn2, dev_size0;
 	struct NTFS_BOOT *boot;
 	struct buffer_head *bh;
 	struct MFT_REC *rec;
@@ -847,6 +860,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	u32 boot_off = 0;
 	const char *hint = "Primary boot";
 
+	/* Save original dev_size. Used with alternative boot. */
+	dev_size0 = dev_size;
+
 	sbi->volume.blocks = dev_size >> PAGE_SHIFT;
 
 	bh = ntfs_bread(sb, 0);
@@ -1084,9 +1100,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	}
 
 out:
-	if (err == -EINVAL && !bh->b_blocknr && dev_size > PAGE_SHIFT) {
+	if (err == -EINVAL && !bh->b_blocknr && dev_size0 > PAGE_SHIFT) {
 		u32 block_size = min_t(u32, sector_size, PAGE_SIZE);
-		u64 lbo = dev_size - sizeof(*boot);
+		u64 lbo = dev_size0 - sizeof(*boot);
 
 		/*
 	 	 * Try alternative boot (last sector)
@@ -1100,6 +1116,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 		boot_off = lbo & (block_size - 1);
 		hint = "Alternative boot";
+		dev_size = dev_size0; /* restore original size. */
 		goto check_boot;
 	}
 	brelse(bh);
@@ -1388,7 +1405,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	bytes = inode->i_size;
-	sbi->def_table = t = kmalloc(bytes, GFP_NOFS | __GFP_NOWARN);
+	sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL);
 	if (!t) {
 		err = -ENOMEM;
 		goto put_inode_out;
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index f9544d9b670d..ac65f0626cfc 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -68,8 +68,7 @@ enum drm_sched_priority {
 	DRM_SCHED_PRIORITY_HIGH,
 	DRM_SCHED_PRIORITY_KERNEL,
 
-	DRM_SCHED_PRIORITY_COUNT,
-	DRM_SCHED_PRIORITY_UNSET = -2
+	DRM_SCHED_PRIORITY_COUNT
 };
 
 /* Used to chose between FIFO and RR jobs scheduling */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 8f9a459e1671..7702f078ef4a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -579,6 +579,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
+#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index a427f13c757f..85b86768c0b9 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -767,7 +767,7 @@ struct power_supply_battery_info {
 	int bti_resistance_tolerance;
 };
 
-extern struct atomic_notifier_head power_supply_notifier;
+extern struct blocking_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 87f8e1793af1..295d63437e4d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -423,6 +423,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 
 int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params, struct snd_soc_dai *dai);
+int snd_soc_dapm_widget_name_cmp(struct snd_soc_dapm_widget *widget, const char *s);
 
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index b27f84580c5b..cf3481088234 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1125,6 +1125,8 @@ struct snd_soc_pcm_runtime {
 	unsigned int pop_wait:1;
 	unsigned int fe_compr:1; /* for Dynamic PCM */
 
+	bool initialized;
+
 	int num_components;
 	struct snd_soc_component *components[]; /* CPU/Codec/Platform */
 };
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 1bce2208b65c..d61620e080d1 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -332,7 +332,7 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	unsigned final_ret = io_fixup_rw_res(req, ret);
 
-	if (req->flags & REQ_F_CUR_POS)
+	if (ret >= 0 && req->flags & REQ_F_CUR_POS)
 		req->file->f_pos = rw->kiocb.ki_pos;
 	if (ret >= 0 && (rw->kiocb.ki_complete == io_complete_rw)) {
 		if (!__io_complete_rw_common(req, ret)) {
diff --git a/mm/mmap.c b/mm/mmap.c
index 6d25c619911f..58b4bbb7c396 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -603,11 +603,12 @@ static inline void vma_complete(struct vma_prepare *vp,
  * dup_anon_vma() - Helper function to duplicate anon_vma
  * @dst: The destination VMA
  * @src: The source VMA
+ * @dup: Pointer to the destination VMA when successful.
  *
  * Returns: 0 on success.
  */
 static inline int dup_anon_vma(struct vm_area_struct *dst,
-			       struct vm_area_struct *src)
+		struct vm_area_struct *src, struct vm_area_struct **dup)
 {
 	/*
 	 * Easily overlooked: when mprotect shifts the boundary, make sure the
@@ -615,9 +616,15 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
 	 * anon pages imported.
 	 */
 	if (src->anon_vma && !dst->anon_vma) {
+		int ret;
+
 		vma_start_write(dst);
 		dst->anon_vma = src->anon_vma;
-		return anon_vma_clone(dst, src);
+		ret = anon_vma_clone(dst, src);
+		if (ret)
+			return ret;
+
+		*dup = dst;
 	}
 
 	return 0;
@@ -644,6 +651,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff,
 	       struct vm_area_struct *next)
 {
+	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
 	struct vma_prepare vp;
 
@@ -651,7 +659,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		int ret;
 
 		remove_next = true;
-		ret = dup_anon_vma(vma, next);
+		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
 			return ret;
 	}
@@ -683,6 +691,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
 }
 
@@ -881,6 +891,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
+	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
 	pgoff_t vma_pgoff;
 	int err = 0;
@@ -945,16 +956,16 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
 		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next);
+		err = dup_anon_vma(prev, next, &anon_dup);
 		if (curr) {				/* case 6 */
 			remove = curr;
 			remove2 = next;
 			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr);
+				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
-			err = dup_anon_vma(prev, curr);
+			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
 				remove = curr;
 			} else {			/* case 5 */
@@ -968,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = addr;
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev);
+			err = dup_anon_vma(next, prev, &anon_dup);
 		} else {
 			/*
 			 * Note that cases 3 and 8 are the ONLY ones where prev
@@ -981,17 +992,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
 				remove = curr;
-				err = dup_anon_vma(next, curr);
+				err = dup_anon_vma(next, curr, &anon_dup);
 			}
 		}
 	}
 
 	/* Error in anon_vma clone. */
 	if (err)
-		return NULL;
+		goto anon_vma_fail;
 
 	if (vma_iter_prealloc(vmi))
-		return NULL;
+		goto prealloc_fail;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
 	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
@@ -1024,6 +1035,15 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	khugepaged_enter_vma(res, vm_flags);
 
 	return res;
+
+prealloc_fail:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
+anon_vma_fail:
+	vma_iter_set(vmi, addr);
+	vma_iter_load(vmi);
+	return NULL;
 }
 
 /*
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e43d9508e7a9..6a05bed3cb46 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7604,6 +7604,16 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 	return -1;
 }
 
+static void audit_log_obj_reset(const struct nft_table *table,
+				unsigned int base_seq, unsigned int nentries)
+{
+	char *buf = kasprintf(GFP_ATOMIC, "%s:%u", table->name, base_seq);
+
+	audit_log_nfcfg(buf, table->family, nentries,
+			AUDIT_NFT_OP_OBJ_RESET, GFP_ATOMIC);
+	kfree(buf);
+}
+
 struct nft_obj_filter {
 	char		*table;
 	u32		type;
@@ -7618,8 +7628,10 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 	struct nftables_pernet *nft_net;
+	unsigned int entries = 0;
 	struct nft_object *obj;
 	bool reset = false;
+	int rc = 0;
 
 	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETOBJ_RESET)
 		reset = true;
@@ -7632,6 +7644,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
+		entries = 0;
 		list_for_each_entry_rcu(obj, &table->objects, list) {
 			if (!nft_is_active(net, obj))
 				goto cont;
@@ -7647,34 +7660,27 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 			    filter->type != NFT_OBJECT_UNSPEC &&
 			    obj->ops->type->type != filter->type)
 				goto cont;
-			if (reset) {
-				char *buf = kasprintf(GFP_ATOMIC,
-						      "%s:%u",
-						      table->name,
-						      nft_net->base_seq);
-
-				audit_log_nfcfg(buf,
-						family,
-						obj->handle,
-						AUDIT_NFT_OP_OBJ_RESET,
-						GFP_ATOMIC);
-				kfree(buf);
-			}
 
-			if (nf_tables_fill_obj_info(skb, net, NETLINK_CB(cb->skb).portid,
-						    cb->nlh->nlmsg_seq,
-						    NFT_MSG_NEWOBJ,
-						    NLM_F_MULTI | NLM_F_APPEND,
-						    table->family, table,
-						    obj, reset) < 0)
-				goto done;
+			rc = nf_tables_fill_obj_info(skb, net,
+						     NETLINK_CB(cb->skb).portid,
+						     cb->nlh->nlmsg_seq,
+						     NFT_MSG_NEWOBJ,
+						     NLM_F_MULTI | NLM_F_APPEND,
+						     table->family, table,
+						     obj, reset);
+			if (rc < 0)
+				break;
 
+			entries++;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 cont:
 			idx++;
 		}
+		if (reset && entries)
+			audit_log_obj_reset(table, nft_net->base_seq, entries);
+		if (rc < 0)
+			break;
 	}
-done:
 	rcu_read_unlock();
 
 	cb->args[0] = idx;
@@ -7779,7 +7785,7 @@ static int nf_tables_getobj(struct sk_buff *skb, const struct nfnl_info *info,
 
 		audit_log_nfcfg(buf,
 				family,
-				obj->handle,
+				1,
 				AUDIT_NFT_OP_OBJ_RESET,
 				GFP_ATOMIC);
 		kfree(buf);
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index e57eb168ee13..984f6f106e4a 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -700,8 +700,8 @@ nfulnl_log_packet(struct net *net,
 	unsigned int plen = 0;
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
+	enum ip_conntrack_info ctinfo = 0;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index da4c179a4d41..6663e971a13e 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -366,7 +366,7 @@ static int u32_init(struct tcf_proto *tp)
 	idr_init(&root_ht->handle_idr);
 
 	if (tp_c == NULL) {
-		tp_c = kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KERNEL);
+		tp_c = kzalloc(sizeof(*tp_c), GFP_KERNEL);
 		if (tp_c == NULL) {
 			kfree(root_ht);
 			return -ENOBUFS;
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index d479f8da8f38..50cbd767ea9d 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -6,7 +6,7 @@
 use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
-    marker::PhantomData,
+    marker::{PhantomData, PhantomPinned},
     mem::MaybeUninit,
     ops::{Deref, DerefMut},
     ptr::NonNull,
@@ -206,17 +206,26 @@ fn drop(&mut self) {
 ///
 /// This is meant to be used with FFI objects that are never interpreted by Rust code.
 #[repr(transparent)]
-pub struct Opaque<T>(MaybeUninit<UnsafeCell<T>>);
+pub struct Opaque<T> {
+    value: UnsafeCell<MaybeUninit<T>>,
+    _pin: PhantomPinned,
+}
 
 impl<T> Opaque<T> {
     /// Creates a new opaque value.
     pub const fn new(value: T) -> Self {
-        Self(MaybeUninit::new(UnsafeCell::new(value)))
+        Self {
+            value: UnsafeCell::new(MaybeUninit::new(value)),
+            _pin: PhantomPinned,
+        }
     }
 
     /// Creates an uninitialised value.
     pub const fn uninit() -> Self {
-        Self(MaybeUninit::uninit())
+        Self {
+            value: UnsafeCell::new(MaybeUninit::uninit()),
+            _pin: PhantomPinned,
+        }
     }
 
     /// Creates a pin-initializer from the given initializer closure.
@@ -240,7 +249,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
 
     /// Returns a raw pointer to the opaque data.
     pub fn get(&self) -> *mut T {
-        UnsafeCell::raw_get(self.0.as_ptr())
+        UnsafeCell::get(&self.value).cast::<T>()
     }
 
     /// Gets the value behind `this`.
@@ -248,7 +257,7 @@ pub fn get(&self) -> *mut T {
     /// This function is useful to get access to the value without creating intermediate
     /// references.
     pub const fn raw_get(this: *const Self) -> *mut T {
-        UnsafeCell::raw_get(this.cast::<UnsafeCell<T>>())
+        UnsafeCell::raw_get(this.cast::<UnsafeCell<MaybeUninit<T>>>()).cast::<T>()
     }
 }
 
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 2873420c9aca..bc03b5692983 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -343,6 +343,12 @@ static const struct config_entry config_table[] = {
 					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
 				}
 			},
+			{
+				.ident = "Google firmware",
+				.matches = {
+					DMI_MATCH(DMI_BIOS_VERSION, "Google"),
+				}
+			},
 			{}
 		}
 	},
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 581b334a6631..3bbe85091649 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -59,9 +59,6 @@ static void da7219_aad_btn_det_work(struct work_struct *work)
 	bool micbias_up = false;
 	int retries = 0;
 
-	/* Disable ground switch */
-	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
-
 	/* Drive headphones/lineout */
 	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
 			    DA7219_HP_L_AMP_OE_MASK,
@@ -155,9 +152,6 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 		tonegen_freq_hptest = cpu_to_le16(DA7219_AAD_HPTEST_RAMP_FREQ_INT_OSC);
 	}
 
-	/* Disable ground switch */
-	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
-
 	/* Ensure gain ramping at fastest rate */
 	gain_ramp_ctrl = snd_soc_component_read(component, DA7219_GAIN_RAMP_CTRL);
 	snd_soc_component_write(component, DA7219_GAIN_RAMP_CTRL, DA7219_GAIN_RAMP_RATE_X8);
@@ -421,6 +415,11 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 			 * handle a removal, and we can check at the end of
 			 * hptest if we have a valid result or not.
 			 */
+
+			cancel_delayed_work_sync(&da7219_aad->jack_det_work);
+			/* Disable ground switch */
+			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
+
 			if (statusa & DA7219_JACK_TYPE_STS_MASK) {
 				report |= SND_JACK_HEADSET;
 				mask |=	SND_JACK_HEADSET | SND_JACK_LINEOUT;
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a506d940a2ea..fae04e9fae4e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3251,6 +3251,8 @@ int rt5645_set_jack_detect(struct snd_soc_component *component,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 	}
 	rt5645_irq(0, rt5645);
 
diff --git a/sound/soc/codecs/tas2780.c b/sound/soc/codecs/tas2780.c
index 86bd6c18a944..41076be23854 100644
--- a/sound/soc/codecs/tas2780.c
+++ b/sound/soc/codecs/tas2780.c
@@ -39,7 +39,7 @@ static void tas2780_reset(struct tas2780_priv *tas2780)
 		usleep_range(2000, 2050);
 	}
 
-	snd_soc_component_write(tas2780->component, TAS2780_SW_RST,
+	ret = snd_soc_component_write(tas2780->component, TAS2780_SW_RST,
 				TAS2780_RST);
 	if (ret)
 		dev_err(tas2780->dev, "%s:errCode:0x%x Reset error!\n",
diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index b976c1946286..420bbf588efe 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -293,7 +293,7 @@
 #define ADC3XXX_BYPASS_RPGA		0x80
 
 /* MICBIAS control bits */
-#define ADC3XXX_MICBIAS_MASK		0x2
+#define ADC3XXX_MICBIAS_MASK		0x3
 #define ADC3XXX_MICBIAS1_SHIFT		5
 #define ADC3XXX_MICBIAS2_SHIFT		3
 
@@ -1099,7 +1099,7 @@ static int adc3xxx_parse_dt_micbias(struct adc3xxx *adc3xxx,
 	unsigned int val;
 
 	if (!of_property_read_u32(np, propname, &val)) {
-		if (val >= ADC3XXX_MICBIAS_AVDD) {
+		if (val > ADC3XXX_MICBIAS_AVDD) {
 			dev_err(dev, "Invalid property value for '%s'\n", propname);
 			return -EINVAL;
 		}
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 76b5bfc288fd..bab7d34cf585 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -52,8 +52,8 @@ struct codec_priv {
 	unsigned long mclk_freq;
 	unsigned long free_freq;
 	u32 mclk_id;
-	u32 fll_id;
-	u32 pll_id;
+	int fll_id;
+	int pll_id;
 };
 
 /**
@@ -206,7 +206,7 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Specific configuration for PLL */
-	if (codec_priv->pll_id && codec_priv->fll_id) {
+	if (codec_priv->pll_id >= 0 && codec_priv->fll_id >= 0) {
 		if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
 			pll_out = priv->sample_rate * 384;
 		else
@@ -248,7 +248,7 @@ static int fsl_asoc_card_hw_free(struct snd_pcm_substream *substream)
 
 	priv->streams &= ~BIT(substream->stream);
 
-	if (!priv->streams && codec_priv->pll_id && codec_priv->fll_id) {
+	if (!priv->streams && codec_priv->pll_id >= 0 && codec_priv->fll_id >= 0) {
 		/* Force freq to be free_freq to avoid error message in codec */
 		ret = snd_soc_dai_set_sysclk(asoc_rtd_to_codec(rtd, 0),
 					     codec_priv->mclk_id,
@@ -621,6 +621,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	priv->card.dapm_routes = audio_map;
 	priv->card.num_dapm_routes = ARRAY_SIZE(audio_map);
 	priv->card.driver_name = DRIVER_NAME;
+
+	priv->codec_priv.fll_id = -1;
+	priv->codec_priv.pll_id = -1;
+
 	/* Diversify the card configurations */
 	if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
 		codec_dai_name = "cs42888";
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 0745bf6a09aa..5005d3c9c659 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -701,10 +701,12 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		struct snd_soc_dai_link *dai_link = priv->dai_link;
 		struct simple_dai_props *dai_props = priv->dai_props;
 
+		ret = -EINVAL;
+
 		cinfo = dev->platform_data;
 		if (!cinfo) {
 			dev_err(dev, "no info for asoc-simple-card\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		if (!cinfo->name ||
@@ -713,7 +715,7 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		    !cinfo->platform ||
 		    !cinfo->cpu_dai.name) {
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		cpus			= dai_link->cpus;
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 93544eac23ad..a23a7a1a3581 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -366,6 +366,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		/* No Jack */
 		.driver_data = (void *)SOF_SDW_TGL_HDMI,
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0B14"),
+		},
+		/* No Jack */
+		.driver_data = (void *)SOF_SDW_TGL_HDMI,
+	},
+
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 4356cc320fea..10b5fe5a3af8 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -242,6 +242,7 @@ int snd_soc_component_notify_control(struct snd_soc_component *component,
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	struct snd_kcontrol *kctl;
 
+	/* When updating, change also snd_soc_dapm_widget_name_cmp() */
 	if (component->name_prefix)
 		snprintf(name, ARRAY_SIZE(name), "%s %s", component->name_prefix, ctl);
 	else
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1a0bde23f5e6..2d85164457f7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1259,7 +1259,7 @@ static int soc_init_pcm_runtime(struct snd_soc_card *card,
 	snd_soc_runtime_get_dai_fmt(rtd);
 	ret = snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
 	if (ret)
-		return ret;
+		goto err;
 
 	/* add DPCM sysfs entries */
 	soc_dpcm_debugfs_add(rtd);
@@ -1284,17 +1284,26 @@ static int soc_init_pcm_runtime(struct snd_soc_card *card,
 	/* create compress_device if possible */
 	ret = snd_soc_dai_compress_new(cpu_dai, rtd, num);
 	if (ret != -ENOTSUPP)
-		return ret;
+		goto err;
 
 	/* create the pcm */
 	ret = soc_new_pcm(rtd, num);
 	if (ret < 0) {
 		dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
 			dai_link->stream_name, ret);
-		return ret;
+		goto err;
 	}
 
-	return snd_soc_pcm_dai_new(rtd);
+	ret = snd_soc_pcm_dai_new(rtd);
+	if (ret < 0)
+		goto err;
+
+	rtd->initialized = true;
+
+	return 0;
+err:
+	snd_soc_link_exit(rtd);
+	return ret;
 }
 
 static void soc_set_name_prefix(struct snd_soc_card *card,
@@ -1892,7 +1901,8 @@ static void soc_cleanup_card_resources(struct snd_soc_card *card)
 
 	/* release machine specific resources */
 	for_each_card_rtds(card, rtd)
-		snd_soc_link_exit(rtd);
+		if (rtd->initialized)
+			snd_soc_link_exit(rtd);
 	/* remove and free each DAI */
 	soc_remove_link_dais(card);
 	soc_remove_link_components(card);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3091e8160bad..5fd32185fe63 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2726,6 +2726,18 @@ int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_update_dai);
 
+int snd_soc_dapm_widget_name_cmp(struct snd_soc_dapm_widget *widget, const char *s)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
+	const char *wname = widget->name;
+
+	if (component->name_prefix)
+		wname += strlen(component->name_prefix) + 1; /* plus space */
+
+	return strcmp(wname, s);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_widget_name_cmp);
+
 /*
  * dapm_update_widget_flags() - Re-compute widget sink and source flags
  * @w: The widget for which to update the flags
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index f5ece43d0ec2..f42c85df88a8 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -145,6 +145,13 @@ static const struct dmi_system_id community_key_platforms[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
 		}
 	},
+	{
+		.ident = "Google firmware",
+		.callback = chromebook_use_community_key,
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VERSION, "Google"),
+		}
+	},
 	{},
 };
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 4e64842245e1..ab2b938502eb 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2220,6 +2220,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2ab6, /* T+A devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2afd, /* McIntosh Laboratory, Inc. */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2d87, /* Cayin device */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3336, /* HEM devices */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7ef43f72098e..c779b9f2e622 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evlist *evlist)
 		.type	= PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
+		/* Avoid frequency mode for dummy events to avoid associated timers. */
+		.freq = 0,
+		.sample_period = 1,
 	};
 
 	return evsel__new_idx(&attr, evlist->core.nr_entries);
@@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 	evsel->core.attr.exclude_kernel = 1;
 	evsel->core.attr.exclude_guest = 1;
 	evsel->core.attr.exclude_hv = 1;
-	evsel->core.attr.freq = 0;
-	evsel->core.attr.sample_period = 1;
 	evsel->core.system_wide = system_wide;
 	evsel->no_aux_samples = true;
 	evsel->name = strdup("dummy:u");
diff --git a/tools/testing/selftests/netfilter/nft_audit.sh b/tools/testing/selftests/netfilter/nft_audit.sh
index 5267c88496d5..99ed5bd6e840 100755
--- a/tools/testing/selftests/netfilter/nft_audit.sh
+++ b/tools/testing/selftests/netfilter/nft_audit.sh
@@ -99,6 +99,12 @@ do_test 'nft add counter t1 c1' \
 do_test 'nft add counter t2 c1; add counter t2 c2' \
 'table=t2 family=2 entries=2 op=nft_register_obj'
 
+for ((i = 3; i <= 500; i++)); do
+	echo "add counter t2 c$i"
+done >$rulefile
+do_test "nft -f $rulefile" \
+'table=t2 family=2 entries=498 op=nft_register_obj'
+
 # adding/updating quotas
 
 do_test 'nft add quota t1 q1 { 10 bytes }' \
@@ -107,6 +113,12 @@ do_test 'nft add quota t1 q1 { 10 bytes }' \
 do_test 'nft add quota t2 q1 { 10 bytes }; add quota t2 q2 { 10 bytes }' \
 'table=t2 family=2 entries=2 op=nft_register_obj'
 
+for ((i = 3; i <= 500; i++)); do
+	echo "add quota t2 q$i { 10 bytes }"
+done >$rulefile
+do_test "nft -f $rulefile" \
+'table=t2 family=2 entries=498 op=nft_register_obj'
+
 # changing the quota value triggers obj update path
 do_test 'nft add quota t1 q1 { 20 bytes }' \
 'table=t1 family=2 entries=1 op=nft_register_obj'
@@ -156,6 +168,40 @@ done
 do_test 'nft reset set t1 s' \
 'table=t1 family=2 entries=3 op=nft_reset_setelem'
 
+# resetting counters
+
+do_test 'nft reset counter t1 c1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset counters t1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset counters t2' \
+'table=t2 family=2 entries=342 op=nft_reset_obj
+table=t2 family=2 entries=158 op=nft_reset_obj'
+
+do_test 'nft reset counters' \
+'table=t1 family=2 entries=1 op=nft_reset_obj
+table=t2 family=2 entries=341 op=nft_reset_obj
+table=t2 family=2 entries=159 op=nft_reset_obj'
+
+# resetting quotas
+
+do_test 'nft reset quota t1 q1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset quotas t1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset quotas t2' \
+'table=t2 family=2 entries=315 op=nft_reset_obj
+table=t2 family=2 entries=185 op=nft_reset_obj'
+
+do_test 'nft reset quotas' \
+'table=t1 family=2 entries=1 op=nft_reset_obj
+table=t2 family=2 entries=314 op=nft_reset_obj
+table=t2 family=2 entries=186 op=nft_reset_obj'
+
 # deleting rules
 
 readarray -t handles < <(nft -a list chain t1 c1 | \
