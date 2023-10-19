Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E270F7D03B0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346622AbjJSVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346606AbjJSVVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:21:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531B18B;
        Thu, 19 Oct 2023 14:21:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FE2C433C9;
        Thu, 19 Oct 2023 21:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697750472;
        bh=YF2g5Ot7+WpThx+vTrEGGtzBy9ru0PPYxTrkos5U2os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHO/pOHwTdsm4tQ5i3PSA6HZUlDnBuPyRtoOl5Kpgjsv4eGexMR7qFuGsi6i9c4VB
         W9mov8nq3K8qrGgzq5RftFqyZBrx9hlXjGpI+Sgc444yfZU8kuFyp+8jaJDciVkQfV
         z2MH4hI8Dn8BJmHfk6n2gBhWFzC/igGPpIPM0hNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.5.8
Date:   Thu, 19 Oct 2023 23:21:00 +0200
Message-ID: <2023101900-hunger-yard-8ac6@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023101900-arise-clunky-c873@gregkh>
References: <2023101900-arise-clunky-c873@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 33b90e975e33..ea7db3618b23 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -31,8 +31,9 @@ properties:
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
-    description: The first cell should contain external interrupt number (IRQ0-7) and the
-                 second cell is used to specify the flag.
+    description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
+                 include/dt-bindings/interrupt-controller/irqc-rzg2l.h and the second
+                 cell is used to specify the flag.
     const: 2
 
   '#address-cells':
diff --git a/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml b/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
index 358019e85d90..326284e151f6 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
@@ -59,7 +59,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - fsl,imx8mq-csi
               - fsl,imx8mm-csi
     then:
       required:
diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index eb7d2c88ddec..8e1b27288afd 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -339,6 +339,18 @@ The specified lower directories will be stacked beginning from the
 rightmost one and going left.  In the above example lower1 will be the
 top, lower2 the middle and lower3 the bottom layer.
 
+Note: directory names containing colons can be provided as lower layer by
+escaping the colons with a single backslash.  For example:
+
+  mount -t overlay overlay -olowerdir=/a\:lower\:\:dir /merged
+
+Since kernel version v6.5, directory names containing colons can also
+be provided as lower layer using the fsconfig syscall from new mount api:
+
+  fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/a:lower::dir", 0);
+
+In the latter case, colons in lower layer directory names will be escaped
+as an octal characters (\072) when displayed in /proc/self/mountinfo.
 
 Metadata only copy up
 ---------------------
diff --git a/Makefile b/Makefile
index f9d5970f3441..a687c9a0646c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 5
-SUBLEVEL = 7
+SUBLEVEL = 8
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 36ef2dbe8add..3ee9266fa8e9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -905,7 +905,7 @@ sata: sata@1a200000 {
 		status = "disabled";
 	};
 
-	sata_phy: t-phy@1a243000 {
+	sata_phy: t-phy {
 		compatible = "mediatek,mt7622-tphy",
 			     "mediatek,generic-tphy-v1";
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 68539ea788df..24eda00e320d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -434,7 +434,7 @@ pcie_intc: interrupt-controller {
 			};
 		};
 
-		pcie_phy: t-phy@11c00000 {
+		pcie_phy: t-phy {
 			compatible = "mediatek,mt7986-tphy",
 				     "mediatek,generic-tphy-v2";
 			#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index b2485ddfd33b..5d635085fe3f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -48,7 +48,7 @@ key-0 {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0 0x40000000 0 0x80000000>;
+		reg = <0 0x40000000 0x2 0x00000000>;
 	};
 
 	reserved-memory {
@@ -56,13 +56,8 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
-		bl31_secmon_reserved: secmon@54600000 {
-			no-map;
-			reg = <0 0x54600000 0x0 0x200000>;
-		};
-
-		/* 12 MiB reserved for OP-TEE (BL32)
+		/*
+		 * 12 MiB reserved for OP-TEE (BL32)
 		 * +-----------------------+ 0x43e0_0000
 		 * |      SHMEM 2MiB       |
 		 * +-----------------------+ 0x43c0_0000
@@ -75,6 +70,34 @@ optee_reserved: optee@43200000 {
 			no-map;
 			reg = <0 0x43200000 0 0x00c00000>;
 		};
+
+		scp_mem: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+
+		vpu_mem: memory@53000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x53000000 0 0x1400000>; /* 20 MB */
+		};
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_mem: memory@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x200000>;
+		};
+
+		snd_dma_mem: memory@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0x1100000>;
+			no-map;
+		};
+
+		apu_mem: memory@62000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x62000000 0 0x1400000>; /* 20 MB */
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 4dbbf8fdab75..43011bc41da7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -313,6 +313,7 @@ dsu-pmu {
 		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
 		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
 		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+		status = "fail";
 	};
 
 	dmic_codec: dmic-codec {
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a7c3020a5de4..06c53000bb74 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3958,7 +3958,7 @@ dispcc: clock-controller@af00000 {
 
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8150-pdc", "qcom,pdc";
-			reg = <0 0x0b220000 0 0x400>;
+			reg = <0 0x0b220000 0 0x30000>;
 			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
 					  <125 63 1>;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index bd68e1b7f29f..2b9c0e0bd0fb 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -9,6 +9,7 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
+#include <linux/cpuidle.h>
 #include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/psci.h>
@@ -42,6 +43,25 @@
 #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
 	spe_interrupt) + sizeof(u16))
 
+/*
+ * Arm® Functional Fixed Hardware Specification Version 1.2.
+ * Table 2: Arm Architecture context loss flags
+ */
+#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
+
+static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
+{
+	if (arch_flags & CPUIDLE_CORE_CTXT)
+		return CPUIDLE_FLAG_TIMER_STOP;
+
+	return 0;
+}
+#define arch_get_idle_state_flags arch_get_idle_state_flags
+
+#define CPUIDLE_TRACE_CTXT		BIT(1) /* Trace context loss */
+#define CPUIDLE_GICR_CTXT		BIT(2) /* GICR */
+#define CPUIDLE_GICD_CTXT		BIT(3) /* GICD */
+
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1a89ebdc3acc..0238e6bd0d6c 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -94,6 +94,13 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 #define pte_wrprotect pte_wrprotect
 
+static inline int pte_read(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_RO) != _PAGE_NA;
+}
+
+#define pte_read pte_read
+
 static inline int pte_write(pte_t pte)
 {
 	return !(pte_val(pte) & _PAGE_RO);
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 287e25864ffa..072048e723c9 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -197,7 +197,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if (pte_young(*ptep))
+	if (!pte_young(*ptep))
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index a6caaaab6f92..3af11981fcd5 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -25,7 +25,9 @@ static inline int pte_write(pte_t pte)
 	return pte_val(pte) & _PAGE_RW;
 }
 #endif
+#ifndef pte_read
 static inline int pte_read(pte_t pte)		{ return 1; }
+#endif
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index fe27d41f9a3d..835797a66d72 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -138,8 +138,9 @@ ret_from_syscall:
 	lis	r4,icache_44x_need_flush@ha
 	lwz	r5,icache_44x_need_flush@l(r4)
 	cmplwi	cr0,r5,0
-	bne-	2f
+	bne-	.L44x_icache_flush
 #endif /* CONFIG_PPC_47x */
+.L44x_icache_flush_return:
 	kuep_unlock
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
@@ -173,10 +174,11 @@ syscall_exit_finish:
 	b	1b
 
 #ifdef CONFIG_44x
-2:	li	r7,0
+.L44x_icache_flush:
+	li	r7,0
 	iccci	r0,r0
 	stw	r7,icache_44x_need_flush@l(r4)
-	b	1b
+	b	.L44x_icache_flush_return
 #endif  /* CONFIG_44x */
 
 	.globl	ret_from_fork
diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index ca0674b0b683..69d78c372c59 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -185,7 +185,6 @@ _GLOBAL_TOC(plpar_hcall)
 plpar_hcall_trace:
 	HCALL_INST_PRECALL(R5)
 
-	std	r4,STK_PARAM(R4)(r1)
 	mr	r0,r4
 
 	mr	r4,r5
@@ -197,7 +196,7 @@ plpar_hcall_trace:
 
 	HVSC
 
-	ld	r12,STK_PARAM(R4)(r1)
+	ld	r12,STACK_FRAME_MIN_SIZE+STK_PARAM(R4)(r1)
 	std	r4,0(r12)
 	std	r5,8(r12)
 	std	r6,16(r12)
@@ -297,7 +296,6 @@ _GLOBAL_TOC(plpar_hcall9)
 plpar_hcall9_trace:
 	HCALL_INST_PRECALL(R5)
 
-	std	r4,STK_PARAM(R4)(r1)
 	mr	r0,r4
 
 	mr	r4,r5
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 1329e060c548..b43a6bb7e4dc 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -6,7 +6,6 @@
 # for more details.
 #
 
-OBJCOPYFLAGS    := -O binary
 LDFLAGS_vmlinux := -z norelro
 ifeq ($(CONFIG_RELOCATABLE),y)
 	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext --emit-relocs
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index e7882ccb0fd4..78ea44f76718 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -40,6 +40,15 @@ void arch_remove_kprobe(struct kprobe *p);
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
 bool kprobe_breakpoint_handler(struct pt_regs *regs);
 bool kprobe_single_step_handler(struct pt_regs *regs);
-
+#else
+static inline bool kprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	return false;
+}
+
+static inline bool kprobe_single_step_handler(struct pt_regs *regs)
+{
+	return false;
+}
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_RISCV_KPROBES_H */
diff --git a/arch/riscv/include/asm/uprobes.h b/arch/riscv/include/asm/uprobes.h
index f2183e00fdd2..3fc7deda9190 100644
--- a/arch/riscv/include/asm/uprobes.h
+++ b/arch/riscv/include/asm/uprobes.h
@@ -34,7 +34,18 @@ struct arch_uprobe {
 	bool simulate;
 };
 
+#ifdef CONFIG_UPROBES
 bool uprobe_breakpoint_handler(struct pt_regs *regs);
 bool uprobe_single_step_handler(struct pt_regs *regs);
-
+#else
+static inline bool uprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	return false;
+}
+
+static inline bool uprobe_single_step_handler(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
 #endif /* _ASM_RISCV_UPROBES_H */
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index a8efa053c4a5..9cc0a7669271 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -60,7 +60,7 @@ static void init_irq_stacks(void)
 }
 #endif /* CONFIG_VMAP_STACK */
 
-#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 #ifdef CONFIG_IRQ_STACKS
@@ -92,7 +92,7 @@ void do_softirq_own_stack(void)
 #endif
 		__do_softirq();
 }
-#endif /* CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK */
+#endif /* CONFIG_SOFTIRQ_ON_OWN_STACK */
 
 #else
 static void init_irq_stacks(void) {}
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 180d951d3624..21a4d0e111bc 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -311,13 +311,6 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
 	/* Align the stack frame. */
 	sp &= ~0xfUL;
 
-	/*
-	 * Fail if the size of the altstack is not large enough for the
-	 * sigframe construction.
-	 */
-	if (current->sas_ss_size && sp < current->sas_ss_sp)
-		return (void __user __force *)-1UL;
-
 	return (void __user *)sp;
 }
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f798c853bede..cd6f10c73a16 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -13,6 +13,8 @@
 #include <linux/kdebug.h>
 #include <linux/uaccess.h>
 #include <linux/kprobes.h>
+#include <linux/uprobes.h>
+#include <asm/uprobes.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/irq.h>
@@ -246,22 +248,28 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 	return GET_INSN_LENGTH(insn);
 }
 
+static bool probe_single_step_handler(struct pt_regs *regs)
+{
+	bool user = user_mode(regs);
+
+	return user ? uprobe_single_step_handler(regs) : kprobe_single_step_handler(regs);
+}
+
+static bool probe_breakpoint_handler(struct pt_regs *regs)
+{
+	bool user = user_mode(regs);
+
+	return user ? uprobe_breakpoint_handler(regs) : kprobe_breakpoint_handler(regs);
+}
+
 void handle_break(struct pt_regs *regs)
 {
-#ifdef CONFIG_KPROBES
-	if (kprobe_single_step_handler(regs))
+	if (probe_single_step_handler(regs))
 		return;
 
-	if (kprobe_breakpoint_handler(regs))
-		return;
-#endif
-#ifdef CONFIG_UPROBES
-	if (uprobe_single_step_handler(regs))
+	if (probe_breakpoint_handler(regs))
 		return;
 
-	if (uprobe_breakpoint_handler(regs))
-		return;
-#endif
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c648864c8cd1..3b4cb713e368 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -239,7 +239,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
 	if (!is_tail_call)
-		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
+		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
 		  is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
 		  ctx);
@@ -757,8 +757,10 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	if (ret)
 		return ret;
 
-	if (save_ret)
-		emit_sd(RV_REG_FP, -retval_off, regmap[BPF_REG_0], ctx);
+	if (save_ret) {
+		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
+		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
+	}
 
 	/* update branch with beqz */
 	if (ctx->insns) {
@@ -844,7 +846,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
 	if (save_ret) {
-		stack_size += 8;
+		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
 		retval_off = stack_size;
 	}
 
@@ -931,6 +933,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		if (ret)
 			goto out;
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
+		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
 		im->ip_after_call = ctx->insns + ctx->ninsns;
 		/* 2 nops reserved for auipc+jalr pair */
 		emit(rv_nop(), ctx);
@@ -962,8 +965,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_args(nregs, args_off, ctx);
 
-	if (save_ret)
+	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
+		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
+	}
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
 
@@ -1436,7 +1441,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (ret)
 			return ret;
 
-		emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
 	/* tail call */
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 2861e3360aff..e507692e51e7 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2066,6 +2066,7 @@ struct bpf_tramp_jit {
 				 * func_addr's original caller
 				 */
 	int stack_size;		/* Trampoline stack size */
+	int backchain_off;	/* Offset of backchain */
 	int stack_args_off;	/* Offset of stack arguments for calling
 				 * func_addr, has to be at the top
 				 */
@@ -2086,9 +2087,10 @@ struct bpf_tramp_jit {
 				 * for __bpf_prog_enter() return value and
 				 * func_addr respectively
 				 */
-	int r14_off;		/* Offset of saved %r14 */
 	int run_ctx_off;	/* Offset of struct bpf_tramp_run_ctx */
 	int tccnt_off;		/* Offset of saved tailcall counter */
+	int r14_off;		/* Offset of saved %r14, has to be at the
+				 * bottom */
 	int do_fexit;		/* do_fexit: label */
 };
 
@@ -2247,8 +2249,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 * Calculate the stack layout.
 	 */
 
-	/* Reserve STACK_FRAME_OVERHEAD bytes for the callees. */
+	/*
+	 * Allocate STACK_FRAME_OVERHEAD bytes for the callees. As the s390x
+	 * ABI requires, put our backchain at the end of the allocated memory.
+	 */
 	tjit->stack_size = STACK_FRAME_OVERHEAD;
+	tjit->backchain_off = tjit->stack_size - sizeof(u64);
 	tjit->stack_args_off = alloc_stack(tjit, nr_stack_args * sizeof(u64));
 	tjit->reg_args_off = alloc_stack(tjit, nr_reg_args * sizeof(u64));
 	tjit->ip_off = alloc_stack(tjit, sizeof(u64));
@@ -2256,16 +2262,25 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	tjit->bpf_args_off = alloc_stack(tjit, nr_bpf_args * sizeof(u64));
 	tjit->retval_off = alloc_stack(tjit, sizeof(u64));
 	tjit->r7_r8_off = alloc_stack(tjit, 2 * sizeof(u64));
-	tjit->r14_off = alloc_stack(tjit, sizeof(u64));
 	tjit->run_ctx_off = alloc_stack(tjit,
 					sizeof(struct bpf_tramp_run_ctx));
 	tjit->tccnt_off = alloc_stack(tjit, sizeof(u64));
-	/* The caller has already reserved STACK_FRAME_OVERHEAD bytes. */
-	tjit->stack_size -= STACK_FRAME_OVERHEAD;
+	tjit->r14_off = alloc_stack(tjit, sizeof(u64) * 2);
+	/*
+	 * In accordance with the s390x ABI, the caller has allocated
+	 * STACK_FRAME_OVERHEAD bytes for us. 8 of them contain the caller's
+	 * backchain, and the rest we can use.
+	 */
+	tjit->stack_size -= STACK_FRAME_OVERHEAD - sizeof(u64);
 	tjit->orig_stack_args_off = tjit->stack_size + STACK_FRAME_OVERHEAD;
 
+	/* lgr %r1,%r15 */
+	EMIT4(0xb9040000, REG_1, REG_15);
 	/* aghi %r15,-stack_size */
 	EMIT4_IMM(0xa70b0000, REG_15, -tjit->stack_size);
+	/* stg %r1,backchain_off(%r15) */
+	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_1, REG_0, REG_15,
+		      tjit->backchain_off);
 	/* mvc tccnt_off(4,%r15),stack_size+STK_OFF_TCCNT(%r15) */
 	_EMIT6(0xd203f000 | tjit->tccnt_off,
 	       0xf000 | (tjit->stack_size + STK_OFF_TCCNT));
diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index 76b1f8bb0fd5..dab4ed199227 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/insn.h>
+#include <linux/mm.h>
 
 #include "perf_event.h"
 
@@ -132,9 +133,9 @@ static int get_branch_type(unsigned long from, unsigned long to, int abort,
 		 * The LBR logs any address in the IP, even if the IP just
 		 * faulted. This means userspace can control the from address.
 		 * Ensure we don't blindly read any address by validating it is
-		 * a known text address.
+		 * a known text address and not a vsyscall address.
 		 */
-		if (kernel_text_address(from)) {
+		if (kernel_text_address(from) && !in_gate_area_no_mm(from)) {
 			addr = (void *)from;
 			/*
 			 * Assume we can get the maximum possible size
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d111350197f..b37abb55e948 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -637,12 +637,17 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-/* Fam 17h MSRs */
-#define MSR_F17H_IRPERF			0xc00000e9
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
+/* Zen 2 */
 #define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
 #define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
 
+/* Fam 17h MSRs */
+#define MSR_F17H_IRPERF			0xc00000e9
+
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
 #define MSR_F16H_L2I_PERF_CTR		0xc0010231
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 600cf25dbfc6..744a4cd5ac8c 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -134,8 +134,6 @@ void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
 
-bool smp_park_other_cpus_in_init(void);
-
 void smp_store_boot_cpu_info(void);
 void smp_store_cpu_info(int id);
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 44843a492e69..49b285544440 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -403,6 +403,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
+
+	/*
+	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
+	 * During the process, KASAN becomes confused seeing partial LA57
+	 * conversion and triggers a false-positive out-of-bound report.
+	 *
+	 * Disable KASAN until the patching is complete.
+	 */
+	kasan_disable_current();
+
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -452,6 +463,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 	}
+
+	kasan_enable_current();
 }
 
 static inline bool is_jcc32(struct insn *insn)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 28e77c5d6484..9a3394e8c425 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -80,6 +80,10 @@ static const int amd_div0[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
 
+static const int amd_erratum_1485[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
+			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
 	int osvw_id = *erratum++;
@@ -1149,6 +1153,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
 		setup_force_cpu_bug(X86_BUG_DIV0);
 	}
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	     cpu_has_amd_erratum(c, amd_erratum_1485))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 7eb18ca7bd45..cc8ef9bfcb52 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -131,7 +131,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 }
 
 /*
- * Disable virtualization, APIC etc. and park the CPU in a HLT loop
+ * this function calls the 'stop' function on all other CPUs in the system.
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
@@ -172,17 +172,13 @@ static void native_stop_other_cpus(int wait)
 	 * 2) Wait for all other CPUs to report that they reached the
 	 *    HLT loop in stop_this_cpu()
 	 *
-	 * 3) If the system uses INIT/STARTUP for CPU bringup, then
-	 *    send all present CPUs an INIT vector, which brings them
-	 *    completely out of the way.
+	 * 3) If #2 timed out send an NMI to the CPUs which did not
+	 *    yet report
 	 *
-	 * 4) If #3 is not possible and #2 timed out send an NMI to the
-	 *    CPUs which did not yet report
-	 *
-	 * 5) Wait for all other CPUs to report that they reached the
+	 * 4) Wait for all other CPUs to report that they reached the
 	 *    HLT loop in stop_this_cpu()
 	 *
-	 * #4 can obviously race against a CPU reaching the HLT loop late.
+	 * #3 can obviously race against a CPU reaching the HLT loop late.
 	 * That CPU will have reported already and the "have all CPUs
 	 * reached HLT" condition will be true despite the fact that the
 	 * other CPU is still handling the NMI. Again, there is no
@@ -198,7 +194,7 @@ static void native_stop_other_cpus(int wait)
 		/*
 		 * Don't wait longer than a second for IPI completion. The
 		 * wait request is not checked here because that would
-		 * prevent an NMI/INIT shutdown in case that not all
+		 * prevent an NMI shutdown attempt in case that not all
 		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
@@ -206,27 +202,7 @@ static void native_stop_other_cpus(int wait)
 			udelay(1);
 	}
 
-	/*
-	 * Park all other CPUs in INIT including "offline" CPUs, if
-	 * possible. That's a safe place where they can't resume execution
-	 * of HLT and then execute the HLT loop from overwritten text or
-	 * page tables.
-	 *
-	 * The only downside is a broadcast MCE, but up to the point where
-	 * the kexec() kernel brought all APs online again an MCE will just
-	 * make HLT resume and handle the MCE. The machine crashes and burns
-	 * due to overwritten text, page tables and data. So there is a
-	 * choice between fire and frying pan. The result is pretty much
-	 * the same. Chose frying pan until x86 provides a sane mechanism
-	 * to park a CPU.
-	 */
-	if (smp_park_other_cpus_in_init())
-		goto done;
-
-	/*
-	 * If park with INIT was not possible and the REBOOT_VECTOR didn't
-	 * take all secondary CPUs offline, try with the NMI.
-	 */
+	/* if the REBOOT_VECTOR didn't work, try with the NMI */
 	if (!cpumask_empty(&cpus_stop_mask)) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
@@ -249,7 +225,6 @@ static void native_stop_other_cpus(int wait)
 			udelay(1);
 	}
 
-done:
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 747b83a373a2..a0f49cc2a6e6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1346,33 +1346,6 @@ void arch_thaw_secondary_cpus_end(void)
 	cache_aps_init();
 }
 
-bool smp_park_other_cpus_in_init(void)
-{
-	unsigned int cpu, this_cpu = smp_processor_id();
-	unsigned int apicid;
-
-	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
-		return false;
-
-	/*
-	 * If this is a crash stop which does not execute on the boot CPU,
-	 * then this cannot use the INIT mechanism because INIT to the boot
-	 * CPU will reset the machine.
-	 */
-	if (this_cpu)
-		return false;
-
-	for_each_cpu_and(cpu, &cpus_booted_once_mask, cpu_present_mask) {
-		if (cpu == this_cpu)
-			continue;
-		apicid = apic->cpu_present_to_apicid(cpu);
-		if (apicid == BAD_APICID)
-			continue;
-		send_init_sequence(apicid);
-	}
-	return true;
-}
-
 /*
  * Early setup to make printk work.
  */
diff --git a/block/fops.c b/block/fops.c
index 838ffada5341..47c3e68253e2 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -659,24 +659,35 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
-	if (error)
-		goto fail;
-
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 660834a49c1f..c95d0edb0be9 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1913,6 +1913,17 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP 15-cx0041ur"),
 		},
 	},
+	{
+		/*
+		 * HP Pavilion Gaming Laptop 15-dk1xxx
+		 * https://github.com/systemd/systemd/issues/28942
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index dc615ef6550a..3a34a8c425fe 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1217,8 +1217,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = lpi->wake_latency;
 		state->target_residency = lpi->min_residency;
-		if (lpi->arch_flags)
-			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+		state->flags |= arch_get_idle_state_flags(lpi->arch_flags);
 		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
 			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
 		state->enter = acpi_idle_lpi_enter;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 32cfa3f4efd3..297a88587031 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -439,6 +439,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		.ident = "Asus ExpertBook B1402CBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
+		},
+	},
 	{
 		.ident = "Asus ExpertBook B1502CBA",
 		.matches = {
@@ -500,16 +507,23 @@ static const struct dmi_system_id maingear_laptop[] = {
 
 static const struct dmi_system_id pcspecialist_laptop[] = {
 	{
-		.ident = "PCSpecialist Elimina Pro 16 M",
-		/*
-		 * Some models have product-name "Elimina Pro 16 M",
-		 * others "GM6BGEQ". Match on board-name to match both.
-		 */
+		/* TongFang GM6BGEQ / PCSpecialist Elimina Pro 16 M, RTX 3050 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
 			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
 		},
 	},
+	{
+		/* TongFang GM6BG5Q, RTX 4050 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG5Q"),
+		},
+	},
+	{
+		/* TongFang GM6BG0Q / PCSpecialist Elimina Pro 16 M, RTX 4060 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d720f93d8b19..ee8d586bb51e 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4812,6 +4812,8 @@ static void binder_release_work(struct binder_proc *proc,
 				"undelivered TRANSACTION_ERROR: %u\n",
 				e->cmd);
 		} break;
+		case BINDER_WORK_TRANSACTION_PENDING:
+		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT:
 		case BINDER_WORK_TRANSACTION_COMPLETE: {
 			binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
 				"undelivered TRANSACTION_COMPLETE\n");
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6ae9cff6b50c..2a21f4d9500d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1977,6 +1977,96 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	return rc;
 }
 
+/**
+ *	ata_dev_power_set_standby - Set a device power mode to standby
+ *	@dev: target device
+ *
+ *	Issue a STANDBY IMMEDIATE command to set a device power mode to standby.
+ *	For an HDD device, this spins down the disks.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_dev_power_set_standby(struct ata_device *dev)
+{
+	unsigned long ap_flags = dev->link->ap->flags;
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	/* Issue STANDBY IMMEDIATE command only if supported by the device */
+	if (dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC)
+		return;
+
+	/*
+	 * Some odd clown BIOSes issue spindown on power off (ACPI S4 or S5)
+	 * causing some drives to spin up and down again. For these, do nothing
+	 * if we are being called on shutdown.
+	 */
+	if ((ap_flags & ATA_FLAG_NO_POWEROFF_SPINDOWN) &&
+	    system_state == SYSTEM_POWER_OFF)
+		return;
+
+	if ((ap_flags & ATA_FLAG_NO_HIBERNATE_SPINDOWN) &&
+	    system_entering_hibernation())
+		return;
+
+	ata_tf_init(dev, &tf);
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.command = ATA_CMD_STANDBYNOW1;
+
+	ata_dev_notice(dev, "Entering standby power mode\n");
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+	if (err_mask)
+		ata_dev_err(dev, "STANDBY IMMEDIATE failed (err_mask=0x%x)\n",
+			    err_mask);
+}
+
+/**
+ *	ata_dev_power_set_active -  Set a device power mode to active
+ *	@dev: target device
+ *
+ *	Issue a VERIFY command to enter to ensure that the device is in the
+ *	active power mode. For a spun-down HDD (standby or idle power mode),
+ *	the VERIFY command will complete after the disk spins up.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_dev_power_set_active(struct ata_device *dev)
+{
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	/*
+	 * Issue READ VERIFY SECTORS command for 1 sector at lba=0 only
+	 * if supported by the device.
+	 */
+	if (dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC)
+		return;
+
+	ata_tf_init(dev, &tf);
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.command = ATA_CMD_VERIFY;
+	tf.nsect = 1;
+	if (dev->flags & ATA_DFLAG_LBA) {
+		tf.flags |= ATA_TFLAG_LBA;
+		tf.device |= ATA_LBA;
+	} else {
+		/* CHS */
+		tf.lbal = 0x1; /* sect */
+	}
+
+	ata_dev_notice(dev, "Entering active power mode\n");
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+	if (err_mask)
+		ata_dev_err(dev, "VERIFY failed (err_mask=0x%x)\n",
+			    err_mask);
+}
+
 /**
  *	ata_read_log_page - read a specific log page
  *	@dev: target device
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 960ef5c6f2c1..150e7ab62d1a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -106,6 +106,14 @@ static const unsigned int ata_eh_flush_timeouts[] = {
 	UINT_MAX,
 };
 
+static const unsigned int ata_eh_pm_timeouts[] = {
+	10000,	/* most drives spin up by 10sec */
+	10000,	/* > 99% working drives spin up before 20sec */
+	35000,	/* give > 30 secs of idleness for outlier devices */
+	 5000,	/* and sweet one last chance */
+	UINT_MAX, /* > 1 min has elapsed, give up */
+};
+
 static const unsigned int ata_eh_other_timeouts[] = {
 	 5000,	/* same rationale as identify timeout */
 	10000,	/* ditto */
@@ -147,6 +155,8 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
 	  .timeouts = ata_eh_other_timeouts, },
 	{ .commands = CMDS(ATA_CMD_FLUSH, ATA_CMD_FLUSH_EXT),
 	  .timeouts = ata_eh_flush_timeouts },
+	{ .commands = CMDS(ATA_CMD_VERIFY),
+	  .timeouts = ata_eh_pm_timeouts },
 };
 #undef CMDS
 
@@ -498,7 +508,19 @@ static void ata_eh_unload(struct ata_port *ap)
 	struct ata_device *dev;
 	unsigned long flags;
 
-	/* Restore SControl IPM and SPD for the next driver and
+	/*
+	 * Unless we are restarting, transition all enabled devices to
+	 * standby power mode.
+	 */
+	if (system_state != SYSTEM_RESTART) {
+		ata_for_each_link(link, ap, PMP_FIRST) {
+			ata_for_each_dev(dev, link, ENABLED)
+				ata_dev_power_set_standby(dev);
+		}
+	}
+
+	/*
+	 * Restore SControl IPM and SPD for the next driver and
 	 * disable attached devices.
 	 */
 	ata_for_each_link(link, ap, PMP_FIRST) {
@@ -690,6 +712,10 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 				ehc->saved_xfer_mode[devno] = dev->xfer_mode;
 				if (ata_ncq_enabled(dev))
 					ehc->saved_ncq_enabled |= 1 << devno;
+
+				/* If we are resuming, wake up the device */
+				if (ap->pflags & ATA_PFLAG_RESUMING)
+					ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
 			}
 		}
 
@@ -753,6 +779,8 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 	/* clean up */
 	spin_lock_irqsave(ap->lock, flags);
 
+	ap->pflags &= ~ATA_PFLAG_RESUMING;
+
 	if (ap->pflags & ATA_PFLAG_LOADING)
 		ap->pflags &= ~ATA_PFLAG_LOADING;
 	else if ((ap->pflags & ATA_PFLAG_SCSI_HOTPLUG) &&
@@ -1244,6 +1272,13 @@ void ata_eh_detach_dev(struct ata_device *dev)
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long flags;
 
+	/*
+	 * If the device is still enabled, transition it to standby power mode
+	 * (i.e. spin down HDDs).
+	 */
+	if (ata_dev_enabled(dev))
+		ata_dev_power_set_standby(dev);
+
 	ata_dev_disable(dev);
 
 	spin_lock_irqsave(ap->lock, flags);
@@ -3042,6 +3077,15 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 		if (ehc->i.flags & ATA_EHI_DID_RESET)
 			readid_flags |= ATA_READID_POSTRESET;
 
+		/*
+		 * When resuming, before executing any command, make sure to
+		 * transition the device to the active power mode.
+		 */
+		if ((action & ATA_EH_SET_ACTIVE) && ata_dev_enabled(dev)) {
+			ata_dev_power_set_active(dev);
+			ata_eh_done(link, dev, ATA_EH_SET_ACTIVE);
+		}
+
 		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
 			WARN_ON(dev->class == ATA_DEV_PMP);
 
@@ -4015,6 +4059,7 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	unsigned long flags;
 	int rc = 0;
 	struct ata_device *dev;
+	struct ata_link *link;
 
 	/* are we suspending? */
 	spin_lock_irqsave(ap->lock, flags);
@@ -4027,6 +4072,12 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 
 	WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
 
+	/* Set all devices attached to the port in standby mode */
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		ata_for_each_dev(dev, link, ENABLED)
+			ata_dev_power_set_standby(dev);
+	}
+
 	/*
 	 * If we have a ZPODD attached, check its zero
 	 * power ready status before the port is frozen.
@@ -4109,6 +4160,7 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 	/* update the flags */
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags &= ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
+	ap->pflags |= ATA_PFLAG_RESUMING;
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 #endif /* CONFIG_PM */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ed3146c46091..cdbc382e949b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1100,15 +1100,13 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 		}
 	} else {
 		sdev->sector_size = ata_id_logical_sector_size(dev->id);
+
 		/*
-		 * Stop the drive on suspend but do not issue START STOP UNIT
-		 * on resume as this is not necessary and may fail: the device
-		 * will be woken up by ata_port_pm_resume() with a port reset
-		 * and device revalidation.
+		 * Ask the sd driver to issue START STOP UNIT on runtime suspend
+		 * and resume only. For system level suspend/resume, devices
+		 * power state is handled directly by libata EH.
 		 */
-		sdev->manage_system_start_stop = true;
 		sdev->manage_runtime_start_stop = true;
-		sdev->no_start_on_resume = 1;
 	}
 
 	/*
@@ -1284,7 +1282,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 	}
 
 	if (cdb[4] & 0x1) {
-		tf->nsect = 1;	/* 1 sector, lba=0 */
+		tf->nsect = 1;  /* 1 sector, lba=0 */
 
 		if (qc->dev->flags & ATA_DFLAG_LBA) {
 			tf->flags |= ATA_TFLAG_LBA;
@@ -1300,7 +1298,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 			tf->lbah = 0x0; /* cyl high */
 		}
 
-		tf->command = ATA_CMD_VERIFY;	/* READ VERIFY */
+		tf->command = ATA_CMD_VERIFY;   /* READ VERIFY */
 	} else {
 		/* Some odd clown BIOSen issue spindown on power off (ACPI S4
 		 * or S5) causing some drives to spin up and down again.
@@ -1310,7 +1308,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 			goto skip;
 
 		if ((qc->ap->flags & ATA_FLAG_NO_HIBERNATE_SPINDOWN) &&
-		     system_entering_hibernation())
+		    system_entering_hibernation())
 			goto skip;
 
 		/* Issue ATA STANDBY IMMEDIATE command */
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 76d0a5937b66..b4f6cbf6c1d2 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -62,6 +62,8 @@ extern int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags);
 extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 			      unsigned int readid_flags);
 extern int ata_dev_configure(struct ata_device *dev);
+extern void ata_dev_power_set_standby(struct ata_device *dev);
+extern void ata_dev_power_set_active(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 1af64d435d3c..cf87bbb52f1f 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -51,6 +51,13 @@ static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
 	ata_sff_pause(ap);
 }
 
+static void pata_parport_set_devctl(struct ata_port *ap, u8 ctl)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	pi->proto->write_regr(pi, 1, 6, ctl);
+}
+
 static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
 {
 	struct pi_adapter *pi = ap->host->private_data;
@@ -64,7 +71,7 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
 	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
 	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
 
-	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
+	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
 	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
 
 	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
@@ -252,6 +259,7 @@ static struct ata_port_operations pata_parport_port_ops = {
 	.hardreset		= NULL,
 
 	.sff_dev_select		= pata_parport_dev_select,
+	.sff_set_devctl		= pata_parport_set_devctl,
 	.sff_check_status	= pata_parport_check_status,
 	.sff_check_altstatus	= pata_parport_check_altstatus,
 	.sff_tf_load		= pata_parport_tf_load,
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 80acdf62794a..afc94d0062b1 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -247,8 +247,8 @@ static int counter_get_ext(const struct counter_comp *const ext,
 		if (*id == component_id)
 			return 0;
 
-		if (ext->type == COUNTER_COMP_ARRAY) {
-			element = ext->priv;
+		if (ext[*ext_idx].type == COUNTER_COMP_ARRAY) {
+			element = ext[*ext_idx].priv;
 
 			if (component_id - *id < element->length)
 				return 0;
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index e2d1dc6ca668..c7af13aca36c 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -98,7 +98,7 @@ static int mchp_tc_count_function_write(struct counter_device *counter,
 		priv->qdec_mode = 0;
 		/* Set highest rate based on whether soc has gclk or not */
 		bmr &= ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
-		if (priv->tc_cfg->has_gclk)
+		if (!priv->tc_cfg->has_gclk)
 			cmr |= ATMEL_TC_TIMER_CLOCK2;
 		else
 			cmr |= ATMEL_TC_TIMER_CLOCK1;
diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index c625bb2b5d56..628af51c81af 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -76,16 +76,11 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i]) {
 			if (!dma_fence_is_signaled(tmp)) {
 				++count;
-			} else if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
-					    &tmp->flags)) {
-				if (ktime_after(tmp->timestamp, timestamp))
-					timestamp = tmp->timestamp;
 			} else {
-				/*
-				 * Use the current time if the fence is
-				 * currently signaling.
-				 */
-				timestamp = ktime_get();
+				ktime_t t = dma_fence_timestamp(tmp);
+
+				if (ktime_after(t, timestamp))
+					timestamp = t;
 			}
 		}
 	}
diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index af57799c86ce..2e9a316c596a 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -268,13 +268,10 @@ static int sync_fill_fence_info(struct dma_fence *fence,
 		sizeof(info->driver_name));
 
 	info->status = dma_fence_get_status(fence);
-	while (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) &&
-	       !test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
-		cpu_relax();
 	info->timestamp_ns =
-		test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags) ?
-		ktime_to_ns(fence->timestamp) :
-		ktime_set(0, 0);
+		dma_fence_is_signaled(fence) ?
+			ktime_to_ns(dma_fence_timestamp(fence)) :
+			ktime_set(0, 0);
 
 	return info->status;
 }
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 9a15f0d12c79..97b505f1115a 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -492,6 +492,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	union idxd_command_reg cmd;
 	DECLARE_COMPLETION_ONSTACK(done);
 	u32 stat;
+	unsigned long flags;
 
 	if (idxd_device_is_halted(idxd)) {
 		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
@@ -505,7 +506,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	cmd.operand = operand;
 	cmd.int_req = 1;
 
-	spin_lock(&idxd->cmd_lock);
+	spin_lock_irqsave(&idxd->cmd_lock, flags);
 	wait_event_lock_irq(idxd->cmd_waitq,
 			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
 			    idxd->cmd_lock);
@@ -522,7 +523,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	 * After command submitted, release lock and go to sleep until
 	 * the command completes via interrupt.
 	 */
-	spin_unlock(&idxd->cmd_lock);
+	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
 	wait_for_completion(&done);
 	stat = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
 	spin_lock(&idxd->cmd_lock);
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index a1517ef1f4a0..0acf6a92a4ad 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -451,9 +451,8 @@ static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
 	mtk_uart_apdma_write(c, VFF_EN, VFF_EN_CLR_B);
 	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
 
-	synchronize_irq(c->irq);
-
 	spin_unlock_irqrestore(&c->vc.lock, flags);
+	synchronize_irq(c->irq);
 
 	return 0;
 }
diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 37674029cb42..592d48ecf241 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1113,8 +1113,10 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 		chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_PFCTRL;
 
 	/* Activate Double Buffer Mode if DMA triggers STM32 MDMA and more than 1 sg */
-	if (chan->trig_mdma && sg_len > 1)
+	if (chan->trig_mdma && sg_len > 1) {
 		chan->chan_reg.dma_scr |= STM32_DMA_SCR_DBM;
+		chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_CT;
+	}
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		ret = stm32_dma_set_xfer_param(chan, direction, &buswidth,
@@ -1387,11 +1389,12 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 
 	residue = stm32_dma_get_remaining_bytes(chan);
 
-	if (chan->desc->cyclic && !stm32_dma_is_current_sg(chan)) {
+	if ((chan->desc->cyclic || chan->trig_mdma) && !stm32_dma_is_current_sg(chan)) {
 		n_sg++;
 		if (n_sg == chan->desc->num_sgs)
 			n_sg = 0;
-		residue = sg_req->len;
+		if (!chan->trig_mdma)
+			residue = sg_req->len;
 	}
 
 	/*
@@ -1401,7 +1404,7 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 	 * residue = remaining bytes from NDTR + remaining
 	 * periods/sg to be transferred
 	 */
-	if (!chan->desc->cyclic || n_sg != 0)
+	if ((!chan->desc->cyclic && !chan->trig_mdma) || n_sg != 0)
 		for (i = n_sg; i < desc->num_sgs; i++)
 			residue += desc->sg_req[i].len;
 
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 1d0e9dd72ab3..2e37c47044af 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -778,8 +778,6 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 	/* Enable interrupts */
 	ccr &= ~STM32_MDMA_CCR_IRQ_MASK;
 	ccr |= STM32_MDMA_CCR_TEIE | STM32_MDMA_CCR_CTCIE;
-	if (sg_len > 1)
-		ccr |= STM32_MDMA_CCR_BTIE;
 	desc->ccr = ccr;
 
 	return 0;
@@ -1237,6 +1235,10 @@ static int stm32_mdma_resume(struct dma_chan *c)
 	unsigned long flags;
 	u32 status, reg;
 
+	/* Transfer can be terminated */
+	if (!chan->desc || (stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & STM32_MDMA_CCR_EN))
+		return -EPERM;
+
 	hwdesc = chan->desc->node[chan->curr_hwdesc].hwdesc;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
@@ -1317,21 +1319,35 @@ static int stm32_mdma_slave_config(struct dma_chan *c,
 
 static size_t stm32_mdma_desc_residue(struct stm32_mdma_chan *chan,
 				      struct stm32_mdma_desc *desc,
-				      u32 curr_hwdesc)
+				      u32 curr_hwdesc,
+				      struct dma_tx_state *state)
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	struct stm32_mdma_hwdesc *hwdesc;
-	u32 cbndtr, residue, modulo, burst_size;
+	u32 cisr, clar, cbndtr, residue, modulo, burst_size;
 	int i;
 
+	cisr = stm32_mdma_read(dmadev, STM32_MDMA_CISR(chan->id));
+
 	residue = 0;
-	for (i = curr_hwdesc + 1; i < desc->count; i++) {
+	/* Get the next hw descriptor to process from current transfer */
+	clar = stm32_mdma_read(dmadev, STM32_MDMA_CLAR(chan->id));
+	for (i = desc->count - 1; i >= 0; i--) {
 		hwdesc = desc->node[i].hwdesc;
+
+		if (hwdesc->clar == clar)
+			break;/* Current transfer found, stop cumulating */
+
+		/* Cumulate residue of unprocessed hw descriptors */
 		residue += STM32_MDMA_CBNDTR_BNDT(hwdesc->cbndtr);
 	}
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
 	residue += cbndtr & STM32_MDMA_CBNDTR_BNDT_MASK;
 
+	state->in_flight_bytes = 0;
+	if (chan->chan_config.m2m_hw && (cisr & STM32_MDMA_CISR_CRQA))
+		state->in_flight_bytes = cbndtr & STM32_MDMA_CBNDTR_BNDT_MASK;
+
 	if (!chan->mem_burst)
 		return residue;
 
@@ -1361,11 +1377,10 @@ static enum dma_status stm32_mdma_tx_status(struct dma_chan *c,
 
 	vdesc = vchan_find_desc(&chan->vchan, cookie);
 	if (chan->desc && cookie == chan->desc->vdesc.tx.cookie)
-		residue = stm32_mdma_desc_residue(chan, chan->desc,
-						  chan->curr_hwdesc);
+		residue = stm32_mdma_desc_residue(chan, chan->desc, chan->curr_hwdesc, state);
 	else if (vdesc)
-		residue = stm32_mdma_desc_residue(chan,
-						  to_stm32_mdma_desc(vdesc), 0);
+		residue = stm32_mdma_desc_residue(chan, to_stm32_mdma_desc(vdesc), 0, state);
+
 	dma_set_residue(state, residue);
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 4620c4712ce3..1005edeea39e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -169,6 +169,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		csum += pia[size - 1];
 	if (csum) {
 		DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
+		kfree(pia);
 		return -EIO;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 05496b97ef93..06ad7a77eb0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -250,7 +250,7 @@ static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
 
-	if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
+	if (!bo->tbo.resource || bo->tbo.resource->mem_type != TTM_PL_VRAM)
 		return false;
 
 	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index c435f7632e8e..5ee87965a078 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -157,7 +157,7 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
@@ -188,7 +188,7 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 5fc78bf927bb..475161521082 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -355,7 +355,7 @@ static void dcn32_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
@@ -401,7 +401,7 @@ static void dcn32_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1729fb727333..609048160aa2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1263,6 +1263,9 @@ static void disable_vbios_mode_if_required(
 		if (stream == NULL)
 			continue;
 
+		if (stream->apply_seamless_boot_optimization)
+			continue;
+
 		// only looking for first odm pipe
 		if (pipe->prev_odm_pipe)
 			continue;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2f3d9a698486..f2dd3c166af0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1348,6 +1348,41 @@ struct pipe_ctx *find_idle_secondary_pipe(
 	return secondary_pipe;
 }
 
+bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type)
+{
+#ifdef DBG
+	if (pipe_ctx->stream == NULL) {
+		/* a free pipe with dangling states */
+		ASSERT(!pipe_ctx->plane_state);
+		ASSERT(!pipe_ctx->prev_odm_pipe);
+		ASSERT(!pipe_ctx->next_odm_pipe);
+		ASSERT(!pipe_ctx->top_pipe);
+		ASSERT(!pipe_ctx->bottom_pipe);
+	} else if (pipe_ctx->top_pipe) {
+		/* a secondary DPP pipe must be signed to a plane */
+		ASSERT(pipe_ctx->plane_state)
+	}
+	/* Add more checks here to prevent corrupted pipe ctx. It is very hard
+	* to debug this issue afterwards because we can't pinpoint the code
+	* location causing inconsistent pipe context states.
+	*/
+#endif
+	switch (type) {
+	case OTG_MASTER:
+		return !pipe_ctx->prev_odm_pipe &&
+				!pipe_ctx->top_pipe &&
+				pipe_ctx->stream;
+	case OPP_HEAD:
+		return !pipe_ctx->top_pipe && pipe_ctx->stream;
+	case DPP_PIPE:
+		return pipe_ctx->plane_state && pipe_ctx->stream;
+	case FREE_PIPE:
+		return !pipe_ctx->plane_state && !pipe_ctx->stream;
+	default:
+		return false;
+	}
+}
+
 struct pipe_ctx *resource_get_head_pipe_for_stream(
 		struct resource_context *res_ctx,
 		struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index eaeb684c8a48..3088c6c65731 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -153,6 +153,112 @@ bool resource_attach_surfaces_to_context(
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
+/*
+ * pipe types are identified based on MUXes in DCN front end that are capable
+ * of taking input from one DCN pipeline to another DCN pipeline. The name is
+ * in a form of XXXX_YYYY, where XXXX is the DCN front end hardware block the
+ * pipeline ends with and YYYY is the rendering role that the pipe is in.
+ *
+ * For instance OTG_MASTER is a pipe ending with OTG hardware block in its
+ * pipeline and it is in a role of a master pipe for timing generation.
+ *
+ * For quick reference a diagram of each pipe type's areas of responsibility
+ * for outputting timings on the screen is shown below:
+ *
+ *       Timing Active for Stream 0
+ *        __________________________________________________
+ *       |OTG master 0 (OPP head 0)|OPP head 2 (DPP pipe 2) |
+ *       |             (DPP pipe 0)|                        |
+ *       | Top Plane 0             |                        |
+ *       |           ______________|____                    |
+ *       |          |DPP pipe 1    |DPP |                   |
+ *       |          |              |pipe|                   |
+ *       |          |  Bottom      |3   |                   |
+ *       |          |  Plane 1     |    |                   |
+ *       |          |              |    |                   |
+ *       |          |______________|____|                   |
+ *       |                         |                        |
+ *       |                         |                        |
+ *       | ODM slice 0             | ODM slice 1            |
+ *       |_________________________|________________________|
+ *
+ *       Timing Active for Stream 1
+ *        __________________________________________________
+ *       |OTG master 4 (OPP head 4)                         |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |               Blank Pixel Data                   |
+ *       |              (generated by DPG4)                 |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |__________________________________________________|
+ *
+ *       Inter-pipe Relation
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |         | |             |
+ *       |   1    | ------------- |         | |             |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   2    | -------------MPC--------- |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   3    | ------------- |           |             |
+ *       |        |               | blank     |             |
+ *       |   4    |               | ----------------------- |
+ *       |        |               |           |             |
+ *       |   5    |  (FREE)       |           |             |
+ *       |________|_______________|___________|_____________|
+ */
+enum pipe_type {
+	/* free pipe - free pipe is an uninitialized pipe without a stream
+	* associated with it. It is a free DCN pipe resource. It can be
+	* acquired as any type of pipe.
+	*/
+	FREE_PIPE,
+
+	/* OTG master pipe - the master pipe of its OPP head pipes with a
+	* functional OTG. It merges all its OPP head pipes pixel data in ODM
+	* block and output to backend DIG. OTG master pipe is responsible for
+	* generating entire crtc timing to backend DIG. An OTG master pipe may
+	* or may not have a plane. If it has a plane it blends it as the left
+	* most MPC slice of the top most layer. If it doesn't have a plane it
+	* can output pixel data from its OPP head pipes' test pattern
+	* generators (DPG) such as solid black pixel data to blank the screen.
+	*/
+	OTG_MASTER,
+
+	/* OPP head pipe - the head pipe of an MPC blending tree with a
+	* functional OPP outputting to an OTG. OPP head pipe is responsible for
+	* processing output pixels in its own ODM slice. It may or may not have
+	* a plane. If it has a plane it blends it as the top most layer within
+	* its own ODM slice. If it doesn't have a plane it can output pixel
+	* data from its DPG such as solid black pixel data to blank the pixel
+	* data in its own ODM slice. OTG master pipe is also an OPP head pipe
+	* but with more responsibility.
+	*/
+	OPP_HEAD,
+
+	/* DPP pipe - the pipe with a functional DPP outputting to an OPP head
+	* pipe's MPC. DPP pipe is responsible for processing pixel data from
+	* its own MPC slice of a plane. It must be connected to an OPP head
+	* pipe and it must have a plane associated with it.
+	*/
+	DPP_PIPE,
+};
+
+/*
+ * Determine if the input pipe ctx is of a pipe type.
+ * return - true if pipe ctx is of the input type.
+ */
+bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type);
+
 struct pipe_ctx *find_idle_secondary_pipe(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 41b8066f61ff..09fce8f75628 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -290,7 +290,8 @@ static int
 update_connector_routing(struct drm_atomic_state *state,
 			 struct drm_connector *connector,
 			 struct drm_connector_state *old_connector_state,
-			 struct drm_connector_state *new_connector_state)
+			 struct drm_connector_state *new_connector_state,
+			 bool added_by_user)
 {
 	const struct drm_connector_helper_funcs *funcs;
 	struct drm_encoder *new_encoder;
@@ -339,9 +340,13 @@ update_connector_routing(struct drm_atomic_state *state,
 	 * there's a chance the connector may have been destroyed during the
 	 * process, but it's better to ignore that then cause
 	 * drm_atomic_helper_resume() to fail.
+	 *
+	 * Last, we want to ignore connector registration when the connector
+	 * was not pulled in the atomic state by user-space (ie, was pulled
+	 * in by the driver, e.g. when updating a DP-MST stream).
 	 */
 	if (!state->duplicated && drm_connector_is_unregistered(connector) &&
-	    crtc_state->active) {
+	    added_by_user && crtc_state->active) {
 		drm_dbg_atomic(connector->dev,
 			       "[CONNECTOR:%d:%s] is not registered\n",
 			       connector->base.id, connector->name);
@@ -620,7 +625,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 	struct drm_connector *connector;
 	struct drm_connector_state *old_connector_state, *new_connector_state;
 	int i, ret;
-	unsigned int connectors_mask = 0;
+	unsigned int connectors_mask = 0, user_connectors_mask = 0;
+
+	for_each_oldnew_connector_in_state(state, connector, old_connector_state, new_connector_state, i)
+		user_connectors_mask |= BIT(i);
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		bool has_connectors =
@@ -685,7 +693,8 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 		 */
 		ret = update_connector_routing(state, connector,
 					       old_connector_state,
-					       new_connector_state);
+					       new_connector_state,
+					       BIT(i) & user_connectors_mask);
 		if (ret)
 			return ret;
 		if (old_connector_state->crtc) {
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 78dcae201cc6..916d55f2b711 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -537,7 +537,7 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj)
 	struct page **pages;
 	struct folio *folio;
 	struct folio_batch fbatch;
-	int i, j, npages;
+	long i, j, npages;
 
 	if (WARN_ON(!obj->filp))
 		return ERR_PTR(-EINVAL);
@@ -561,11 +561,13 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj)
 
 	i = 0;
 	while (i < npages) {
+		long nr;
 		folio = shmem_read_folio_gfp(mapping, i,
 				mapping_gfp_mask(mapping));
 		if (IS_ERR(folio))
 			goto fail;
-		for (j = 0; j < folio_nr_pages(folio); j++, i++)
+		nr = min(npages - i, folio_nr_pages(folio));
+		for (j = 0; j < nr; j++, i++)
 			pages[i] = folio_file_page(folio, i);
 
 		/* Make sure shmem keeps __GFP_DMA32 allocated pages in the
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 1f65bb33dd21..a8551ce322de 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1199,6 +1199,13 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 			goto err_unlock;
 	}
 
+	/*
+	 * Register engines early to ensure the engine list is in its final
+	 * rb-tree form, lowering the amount of code that has to deal with
+	 * the intermediate llist state.
+	 */
+	intel_engines_driver_register(dev_priv);
+
 	return 0;
 
 	/*
@@ -1246,8 +1253,6 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 void i915_gem_driver_register(struct drm_i915_private *i915)
 {
 	i915_gem_driver_register__shrinker(i915);
-
-	intel_engines_driver_register(i915);
 }
 
 void i915_gem_driver_unregister(struct drm_i915_private *i915)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index c2aaaded07ed..0be195f9149c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -119,6 +119,7 @@ static u64 _dpu_plane_calc_bw(const struct dpu_mdss_cfg *catalog,
 	struct dpu_sw_pipe_cfg *pipe_cfg)
 {
 	int src_width, src_height, dst_height, fps;
+	u64 plane_pixel_rate, plane_bit_rate;
 	u64 plane_prefill_bw;
 	u64 plane_bw;
 	u32 hw_latency_lines;
@@ -136,13 +137,12 @@ static u64 _dpu_plane_calc_bw(const struct dpu_mdss_cfg *catalog,
 	scale_factor = src_height > dst_height ?
 		mult_frac(src_height, 1, dst_height) : 1;
 
-	plane_bw =
-		src_width * mode->vtotal * fps * fmt->bpp *
-		scale_factor;
+	plane_pixel_rate = src_width * mode->vtotal * fps;
+	plane_bit_rate = plane_pixel_rate * fmt->bpp;
 
-	plane_prefill_bw =
-		src_width * hw_latency_lines * fps * fmt->bpp *
-		scale_factor * mode->vtotal;
+	plane_bw = plane_bit_rate * scale_factor;
+
+	plane_prefill_bw = plane_bw * hw_latency_lines;
 
 	if ((vbp+vpw) > hw_latency_lines)
 		do_div(plane_prefill_bw, (vbp+vpw));
@@ -733,9 +733,11 @@ static int dpu_plane_check_inline_rotation(struct dpu_plane *pdpu,
 static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
 		struct dpu_sw_pipe *pipe,
 		struct dpu_sw_pipe_cfg *pipe_cfg,
-		const struct dpu_format *fmt)
+		const struct dpu_format *fmt,
+		const struct drm_display_mode *mode)
 {
 	uint32_t min_src_size;
+	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
 
 	min_src_size = DPU_FORMAT_IS_YUV(fmt) ? 2 : 1;
 
@@ -774,6 +776,12 @@ static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
 		return -EINVAL;
 	}
 
+	/* max clk check */
+	if (_dpu_plane_calc_clk(mode, pipe_cfg) > kms->perf.max_core_clk_rate) {
+		DPU_DEBUG_PLANE(pdpu, "plane exceeds max mdp core clk limits\n");
+		return -E2BIG;
+	}
+
 	return 0;
 }
 
@@ -899,12 +907,13 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 		r_pipe_cfg->dst_rect.x1 = pipe_cfg->dst_rect.x2;
 	}
 
-	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt);
+	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt, &crtc_state->adjusted_mode);
 	if (ret)
 		return ret;
 
 	if (r_pipe->sspp) {
-		ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg, fmt);
+		ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg, fmt,
+						  &crtc_state->adjusted_mode);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index a7a5c7e0ab92..77a8d9366ed7 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1774,13 +1774,6 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 		return rc;
 
 	while (--link_train_max_retries) {
-		rc = dp_ctrl_reinitialize_mainlink(ctrl);
-		if (rc) {
-			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n",
-					rc);
-			break;
-		}
-
 		training_step = DP_TRAINING_NONE;
 		rc = dp_ctrl_setup_main_link(ctrl, &training_step);
 		if (rc == 0) {
@@ -1832,6 +1825,12 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 			/* stop link training before start re training  */
 			dp_ctrl_clear_training_pattern(ctrl);
 		}
+
+		rc = dp_ctrl_reinitialize_mainlink(ctrl);
+		if (rc) {
+			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n", rc);
+			break;
+		}
 	}
 
 	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN)
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 42427129acea..6375daaeb98e 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -1090,7 +1090,7 @@ int dp_link_process_request(struct dp_link *dp_link)
 	} else if (dp_link_read_psr_error_status(link)) {
 		DRM_ERROR("PSR IRQ_HPD received\n");
 	} else if (dp_link_psr_capability_changed(link)) {
-		drm_dbg_dp(link->drm_dev, "PSR Capability changed");
+		drm_dbg_dp(link->drm_dev, "PSR Capability changed\n");
 	} else {
 		ret = dp_link_process_link_status_update(link);
 		if (!ret) {
@@ -1107,7 +1107,7 @@ int dp_link_process_request(struct dp_link *dp_link)
 		}
 	}
 
-	drm_dbg_dp(link->drm_dev, "sink request=%#x",
+	drm_dbg_dp(link->drm_dev, "sink request=%#x\n",
 				dp_link->sink_request);
 	return ret;
 }
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 3f6dfb4f9d5a..9ac62651eb75 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1075,9 +1075,21 @@ static void dsi_wait4video_done(struct msm_dsi_host *msm_host)
 
 static void dsi_wait4video_eng_busy(struct msm_dsi_host *msm_host)
 {
+	u32 data;
+
 	if (!(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO))
 		return;
 
+	data = dsi_read(msm_host, REG_DSI_STATUS0);
+
+	/* if video mode engine is not busy, its because
+	 * either timing engine was not turned on or the
+	 * DSI controller has finished transmitting the video
+	 * data already, so no need to wait in those cases
+	 */
+	if (!(data & DSI_STATUS0_VIDEO_MODE_ENGINE_BUSY))
+		return;
+
 	if (msm_host->power_on && msm_host->enabled) {
 		dsi_wait4video_done(msm_host);
 		/* delay 4 ms to skip BLLP */
@@ -1887,10 +1899,9 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 	}
 
 	msm_host->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (msm_host->irq < 0) {
-		ret = msm_host->irq;
-		dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
-		return ret;
+	if (!msm_host->irq) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		return -EINVAL;
 	}
 
 	/* do not autoenable, will be enabled later */
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index dc276c346fd1..dcc5e79cfe87 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1343,9 +1343,7 @@ static const struct panel_init_cmd starry_himax83102_j02_init_cmd[] = {
 	_INIT_DCS_CMD(0xB1, 0x01, 0xBF, 0x11),
 	_INIT_DCS_CMD(0xCB, 0x86),
 	_INIT_DCS_CMD(0xD2, 0x3C, 0xFA),
-	_INIT_DCS_CMD(0xE9, 0xC5),
-	_INIT_DCS_CMD(0xD3, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0C, 0x01),
-	_INIT_DCS_CMD(0xE9, 0x3F),
+	_INIT_DCS_CMD(0xD3, 0x00, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0C, 0x01),
 	_INIT_DCS_CMD(0xE7, 0x02, 0x00, 0x28, 0x01, 0x7E, 0x0F, 0x7E, 0x10, 0xA0, 0x00, 0x00, 0x20, 0x40, 0x50, 0x40),
 	_INIT_DCS_CMD(0xBD, 0x02),
 	_INIT_DCS_CMD(0xD8, 0xFF, 0xFF, 0xBF, 0xFE, 0xAA, 0xA0, 0xFF, 0xFF, 0xBF, 0xFE, 0xAA, 0xA0),
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 506371c42745..5a3a622fc672 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -929,7 +929,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 
 		if (next) {
 			next->s_fence->scheduled.timestamp =
-				job->s_fence->finished.timestamp;
+				dma_fence_timestamp(&job->s_fence->finished);
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
 		}
diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 25e11ef11c4c..79112b1957d2 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -745,7 +745,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 
 		ret = devm_aperture_acquire_from_firmware(dev, res->start, resource_size(res));
 		if (ret) {
-			drm_err(dev, "could not acquire memory range %pr: %d\n", &res, ret);
+			drm_err(dev, "could not acquire memory range %pr: %d\n", res, ret);
 			return ERR_PTR(ret);
 		}
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index c43853597776..2bfac3aad7b7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -34,6 +34,8 @@
 
 static void vmw_bo_release(struct vmw_bo *vbo)
 {
+	WARN_ON(vbo->tbo.base.funcs &&
+		kref_read(&vbo->tbo.base.refcount) != 0);
 	vmw_bo_unmap(vbo);
 	drm_gem_object_release(&vbo->tbo.base);
 }
@@ -497,7 +499,7 @@ static int vmw_user_bo_synccpu_release(struct drm_file *filp,
 		if (!(flags & drm_vmw_synccpu_allow_cs)) {
 			atomic_dec(&vmw_bo->cpu_writers);
 		}
-		vmw_user_bo_unref(vmw_bo);
+		vmw_user_bo_unref(&vmw_bo);
 	}
 
 	return ret;
@@ -539,7 +541,7 @@ int vmw_user_bo_synccpu_ioctl(struct drm_device *dev, void *data,
 			return ret;
 
 		ret = vmw_user_bo_synccpu_grab(vbo, arg->flags);
-		vmw_user_bo_unref(vbo);
+		vmw_user_bo_unref(&vbo);
 		if (unlikely(ret != 0)) {
 			if (ret == -ERESTARTSYS || ret == -EBUSY)
 				return -EBUSY;
@@ -612,7 +614,6 @@ int vmw_user_bo_lookup(struct drm_file *filp,
 	}
 
 	*out = to_vmw_bo(gobj);
-	ttm_bo_get(&(*out)->tbo);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
index 1d433fceed3d..0d496dc9c6af 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
@@ -195,12 +195,19 @@ static inline struct vmw_bo *vmw_bo_reference(struct vmw_bo *buf)
 	return buf;
 }
 
-static inline void vmw_user_bo_unref(struct vmw_bo *vbo)
+static inline struct vmw_bo *vmw_user_bo_ref(struct vmw_bo *vbo)
 {
-	if (vbo) {
-		ttm_bo_put(&vbo->tbo);
-		drm_gem_object_put(&vbo->tbo.base);
-	}
+	drm_gem_object_get(&vbo->tbo.base);
+	return vbo;
+}
+
+static inline void vmw_user_bo_unref(struct vmw_bo **buf)
+{
+	struct vmw_bo *tmp_buf = *buf;
+
+	*buf = NULL;
+	if (tmp_buf)
+		drm_gem_object_put(&tmp_buf->tbo.base);
 }
 
 static inline struct vmw_bo *to_vmw_bo(struct drm_gem_object *gobj)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
index c0b24d1cacbf..a7c07692262b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -432,7 +432,7 @@ static int vmw_cotable_resize(struct vmw_resource *res, size_t new_size)
 	 * for the new COTable. Initially pin the buffer object to make sure
 	 * we can use tryreserve without failure.
 	 */
-	ret = vmw_bo_create(dev_priv, &bo_params, &buf);
+	ret = vmw_gem_object_create(dev_priv, &bo_params, &buf);
 	if (ret) {
 		DRM_ERROR("Failed initializing new cotable MOB.\n");
 		goto out_done;
@@ -502,7 +502,7 @@ static int vmw_cotable_resize(struct vmw_resource *res, size_t new_size)
 
 	vmw_resource_mob_attach(res);
 	/* Let go of the old mob. */
-	vmw_bo_unreference(&old_buf);
+	vmw_user_bo_unref(&old_buf);
 	res->id = vcotbl->type;
 
 	ret = dma_resv_reserve_fences(bo->base.resv, 1);
@@ -521,7 +521,7 @@ static int vmw_cotable_resize(struct vmw_resource *res, size_t new_size)
 out_wait:
 	ttm_bo_unpin(bo);
 	ttm_bo_unreserve(bo);
-	vmw_bo_unreference(&buf);
+	vmw_user_bo_unref(&buf);
 
 out_done:
 	MKS_STAT_TIME_POP(MKSSTAT_KERN_COTABLE_RESIZE);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 58bfdf203eca..3cd5090dedfc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -853,6 +853,10 @@ static inline bool vmw_resource_mob_attached(const struct vmw_resource *res)
 /**
  * GEM related functionality - vmwgfx_gem.c
  */
+struct vmw_bo_params;
+int vmw_gem_object_create(struct vmw_private *vmw,
+			  struct vmw_bo_params *params,
+			  struct vmw_bo **p_vbo);
 extern int vmw_gem_object_create_with_handle(struct vmw_private *dev_priv,
 					     struct drm_file *filp,
 					     uint32_t size,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 98e0723ca6f5..36987ef3fc30 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1151,7 +1151,7 @@ static int vmw_translate_mob_ptr(struct vmw_private *dev_priv,
 				 SVGAMobId *id,
 				 struct vmw_bo **vmw_bo_p)
 {
-	struct vmw_bo *vmw_bo;
+	struct vmw_bo *vmw_bo, *tmp_bo;
 	uint32_t handle = *id;
 	struct vmw_relocation *reloc;
 	int ret;
@@ -1164,7 +1164,8 @@ static int vmw_translate_mob_ptr(struct vmw_private *dev_priv,
 	}
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_MOB, VMW_BO_DOMAIN_MOB);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
-	vmw_user_bo_unref(vmw_bo);
+	tmp_bo = vmw_bo;
+	vmw_user_bo_unref(&tmp_bo);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -1206,7 +1207,7 @@ static int vmw_translate_guest_ptr(struct vmw_private *dev_priv,
 				   SVGAGuestPtr *ptr,
 				   struct vmw_bo **vmw_bo_p)
 {
-	struct vmw_bo *vmw_bo;
+	struct vmw_bo *vmw_bo, *tmp_bo;
 	uint32_t handle = ptr->gmrId;
 	struct vmw_relocation *reloc;
 	int ret;
@@ -1220,7 +1221,8 @@ static int vmw_translate_guest_ptr(struct vmw_private *dev_priv,
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM,
 			     VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
-	vmw_user_bo_unref(vmw_bo);
+	tmp_bo = vmw_bo;
+	vmw_user_bo_unref(&tmp_bo);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -1619,7 +1621,7 @@ static int vmw_cmd_tex_state(struct vmw_private *dev_priv,
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdSetTextureState);
 	SVGA3dTextureState *last_state = (SVGA3dTextureState *)
-	  ((unsigned long) header + header->size + sizeof(header));
+	  ((unsigned long) header + header->size + sizeof(*header));
 	SVGA3dTextureState *cur_state = (SVGA3dTextureState *)
 		((unsigned long) header + sizeof(*cmd));
 	struct vmw_resource *ctx;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index c0da89e16e6f..8b1eb0061610 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -111,6 +111,20 @@ static const struct drm_gem_object_funcs vmw_gem_object_funcs = {
 	.vm_ops = &vmw_vm_ops,
 };
 
+int vmw_gem_object_create(struct vmw_private *vmw,
+			  struct vmw_bo_params *params,
+			  struct vmw_bo **p_vbo)
+{
+	int ret = vmw_bo_create(vmw, params, p_vbo);
+
+	if (ret != 0)
+		goto out_no_bo;
+
+	(*p_vbo)->tbo.base.funcs = &vmw_gem_object_funcs;
+out_no_bo:
+	return ret;
+}
+
 int vmw_gem_object_create_with_handle(struct vmw_private *dev_priv,
 				      struct drm_file *filp,
 				      uint32_t size,
@@ -126,12 +140,10 @@ int vmw_gem_object_create_with_handle(struct vmw_private *dev_priv,
 		.pin = false
 	};
 
-	ret = vmw_bo_create(dev_priv, &params, p_vbo);
+	ret = vmw_gem_object_create(dev_priv, &params, p_vbo);
 	if (ret != 0)
 		goto out_no_bo;
 
-	(*p_vbo)->tbo.base.funcs = &vmw_gem_object_funcs;
-
 	ret = drm_gem_handle_create(filp, &(*p_vbo)->tbo.base, handle);
 out_no_bo:
 	return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1489ad73c103..818b7f109f53 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1471,8 +1471,8 @@ static int vmw_create_bo_proxy(struct drm_device *dev,
 	/* Reserve and switch the backing mob. */
 	mutex_lock(&res->dev_priv->cmdbuf_mutex);
 	(void) vmw_resource_reserve(res, false, true);
-	vmw_bo_unreference(&res->guest_memory_bo);
-	res->guest_memory_bo = vmw_bo_reference(bo_mob);
+	vmw_user_bo_unref(&res->guest_memory_bo);
+	res->guest_memory_bo = vmw_user_bo_ref(bo_mob);
 	res->guest_memory_offset = 0;
 	vmw_resource_unreserve(res, false, false, false, NULL, 0);
 	mutex_unlock(&res->dev_priv->cmdbuf_mutex);
@@ -1666,7 +1666,7 @@ static struct drm_framebuffer *vmw_kms_fb_create(struct drm_device *dev,
 err_out:
 	/* vmw_user_lookup_handle takes one ref so does new_fb */
 	if (bo)
-		vmw_user_bo_unref(bo);
+		vmw_user_bo_unref(&bo);
 	if (surface)
 		vmw_surface_unreference(&surface);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index fb85f244c3d0..c45b4724e414 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -451,7 +451,7 @@ int vmw_overlay_ioctl(struct drm_device *dev, void *data,
 
 	ret = vmw_overlay_update_stream(dev_priv, buf, arg, true);
 
-	vmw_user_bo_unref(buf);
+	vmw_user_bo_unref(&buf);
 
 out_unlock:
 	mutex_unlock(&overlay->mutex);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 71eeabf001c8..ca300c7427d2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -141,7 +141,7 @@ static void vmw_resource_release(struct kref *kref)
 		if (res->coherent)
 			vmw_bo_dirty_release(res->guest_memory_bo);
 		ttm_bo_unreserve(bo);
-		vmw_bo_unreference(&res->guest_memory_bo);
+		vmw_user_bo_unref(&res->guest_memory_bo);
 	}
 
 	if (likely(res->hw_destroy != NULL)) {
@@ -338,7 +338,7 @@ static int vmw_resource_buf_alloc(struct vmw_resource *res,
 		return 0;
 	}
 
-	ret = vmw_bo_create(res->dev_priv, &bo_params, &gbo);
+	ret = vmw_gem_object_create(res->dev_priv, &bo_params, &gbo);
 	if (unlikely(ret != 0))
 		goto out_no_bo;
 
@@ -457,11 +457,11 @@ void vmw_resource_unreserve(struct vmw_resource *res,
 			vmw_resource_mob_detach(res);
 			if (res->coherent)
 				vmw_bo_dirty_release(res->guest_memory_bo);
-			vmw_bo_unreference(&res->guest_memory_bo);
+			vmw_user_bo_unref(&res->guest_memory_bo);
 		}
 
 		if (new_guest_memory_bo) {
-			res->guest_memory_bo = vmw_bo_reference(new_guest_memory_bo);
+			res->guest_memory_bo = vmw_user_bo_ref(new_guest_memory_bo);
 
 			/*
 			 * The validation code should already have added a
@@ -551,7 +551,7 @@ vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
 	ttm_bo_put(val_buf->bo);
 	val_buf->bo = NULL;
 	if (guest_memory_dirty)
-		vmw_bo_unreference(&res->guest_memory_bo);
+		vmw_user_bo_unref(&res->guest_memory_bo);
 
 	return ret;
 }
@@ -727,7 +727,7 @@ int vmw_resource_validate(struct vmw_resource *res, bool intr,
 		goto out_no_validate;
 	else if (!res->func->needs_guest_memory && res->guest_memory_bo) {
 		WARN_ON_ONCE(vmw_resource_mob_attached(res));
-		vmw_bo_unreference(&res->guest_memory_bo);
+		vmw_user_bo_unref(&res->guest_memory_bo);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index 1e81ff2422cf..a01ca3226d0a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -180,7 +180,7 @@ static int vmw_gb_shader_init(struct vmw_private *dev_priv,
 
 	res->guest_memory_size = size;
 	if (byte_code) {
-		res->guest_memory_bo = vmw_bo_reference(byte_code);
+		res->guest_memory_bo = vmw_user_bo_ref(byte_code);
 		res->guest_memory_offset = offset;
 	}
 	shader->size = size;
@@ -809,7 +809,7 @@ static int vmw_shader_define(struct drm_device *dev, struct drm_file *file_priv,
 				    shader_type, num_input_sig,
 				    num_output_sig, tfile, shader_handle);
 out_bad_arg:
-	vmw_user_bo_unref(buffer);
+	vmw_user_bo_unref(&buffer);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5db403ee8261..3829be282ff0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -686,9 +686,6 @@ static void vmw_user_surface_base_release(struct ttm_base_object **p_base)
 	    container_of(base, struct vmw_user_surface, prime.base);
 	struct vmw_resource *res = &user_srf->srf.res;
 
-	if (res->guest_memory_bo)
-		drm_gem_object_put(&res->guest_memory_bo->tbo.base);
-
 	*p_base = NULL;
 	vmw_resource_unreference(&res);
 }
@@ -855,23 +852,21 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 	 * expect a backup buffer to be present.
 	 */
 	if (dev_priv->has_mob && req->shareable) {
-		uint32_t backup_handle;
-
-		ret = vmw_gem_object_create_with_handle(dev_priv,
-							file_priv,
-							res->guest_memory_size,
-							&backup_handle,
-							&res->guest_memory_bo);
+		struct vmw_bo_params params = {
+			.domain = VMW_BO_DOMAIN_SYS,
+			.busy_domain = VMW_BO_DOMAIN_SYS,
+			.bo_type = ttm_bo_type_device,
+			.size = res->guest_memory_size,
+			.pin = false
+		};
+
+		ret = vmw_gem_object_create(dev_priv,
+					    &params,
+					    &res->guest_memory_bo);
 		if (unlikely(ret != 0)) {
 			vmw_resource_unreference(&res);
 			goto out_unlock;
 		}
-		vmw_bo_reference(res->guest_memory_bo);
-		/*
-		 * We don't expose the handle to the userspace and surface
-		 * already holds a gem reference
-		 */
-		drm_gem_handle_delete(file_priv, backup_handle);
 	}
 
 	tmp = vmw_resource_reference(&srf->res);
@@ -1512,7 +1507,7 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 		if (ret == 0) {
 			if (res->guest_memory_bo->tbo.base.size < res->guest_memory_size) {
 				VMW_DEBUG_USER("Surface backup buffer too small.\n");
-				vmw_bo_unreference(&res->guest_memory_bo);
+				vmw_user_bo_unref(&res->guest_memory_bo);
 				ret = -EINVAL;
 				goto out_unlock;
 			} else {
@@ -1526,8 +1521,6 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 							res->guest_memory_size,
 							&backup_handle,
 							&res->guest_memory_bo);
-		if (ret == 0)
-			vmw_bo_reference(res->guest_memory_bo);
 	}
 
 	if (unlikely(ret != 0)) {
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 09ba2086c95c..1c00e4121c7e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4515,7 +4515,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			goto hid_hw_init_fail;
 	}
 
-	hidpp_connect_event(hidpp);
+	schedule_work(&hidpp->work);
+	flush_work(&hidpp->work);
 
 	if (will_restart) {
 		/* Reset the HID node state */
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 66dc5f97a009..6132c5b3db9c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1173,16 +1173,6 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 		goto out;
 	}
 
-	/*
-	 * In sysFS mode we can have multiple writers per sink.  Since this
-	 * sink is already enabled no memory is needed and the HW need not be
-	 * touched, even if the buffer size has changed.
-	 */
-	if (drvdata->mode == CS_MODE_SYSFS) {
-		atomic_inc(&csdev->refcnt);
-		goto out;
-	}
-
 	/*
 	 * If we don't have a buffer or it doesn't match the requested size,
 	 * use the buffer allocated above. Otherwise reuse the existing buffer.
@@ -1204,7 +1194,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 
 static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 {
-	int ret;
+	int ret = 0;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etr_buf *sysfs_buf = tmc_etr_get_sysfs_buffer(csdev);
@@ -1213,12 +1203,24 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		return PTR_ERR(sysfs_buf);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/*
+	 * In sysFS mode we can have multiple writers per sink.  Since this
+	 * sink is already enabled no memory is needed and the HW need not be
+	 * touched, even if the buffer size has changed.
+	 */
+	if (drvdata->mode == CS_MODE_SYSFS) {
+		atomic_inc(&csdev->refcnt);
+		goto out;
+	}
+
 	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
 	if (!ret) {
 		drvdata->mode = CS_MODE_SYSFS;
 		atomic_inc(&csdev->refcnt);
 	}
 
+out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (!ret)
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7bc3ebfe8081..ce96bf13fdfe 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,6 +177,7 @@ struct ad7192_chip_info {
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
+	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
@@ -1014,10 +1015,30 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
 
-	ret = regulator_get_voltage(st->avdd);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
-		return ret;
+	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
+	if (IS_ERR(st->vref)) {
+		if (PTR_ERR(st->vref) != -ENODEV)
+			return PTR_ERR(st->vref);
+
+		ret = regulator_get_voltage(st->avdd);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, AVdd voltage undefined\n");
+	} else {
+		ret = regulator_enable(st->vref);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(st->vref);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, Vref voltage undefined\n");
 	}
 	st->int_vref_mv = ret / 1000;
 
diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index f5a0fc9e64c5..fff6e5a2d956 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -38,8 +38,8 @@
 #define IMX8QXP_ADR_ADC_FCTRL		0x30
 #define IMX8QXP_ADR_ADC_SWTRIG		0x34
 #define IMX8QXP_ADR_ADC_TCTRL(tid)	(0xc0 + (tid) * 4)
-#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x100 + (cid) * 8)
-#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x104 + (cid) * 8)
+#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x100 + (cid) * 8)
+#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x104 + (cid) * 8)
 #define IMX8QXP_ADR_ADC_RESFIFO		0x300
 #define IMX8QXP_ADR_ADC_TST		0xffc
 
diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
index 877f9124803c..397544f23b85 100644
--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -24,6 +24,8 @@ config AD74413R
 	depends on GPIOLIB && SPI
 	select REGMAP_SPI
 	select CRC8
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD74412R/AD74413R
 	  quad-channel software configurable input/output solution.
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b72d39fc2434..6bfe5d6847e7 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -190,8 +190,11 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	/*
 	 * Ignore samples if the buffer is not set: it is needed if the ODR is
 	 * set but the buffer is not enabled yet.
+	 *
+	 * Note: iio_device_claim_buffer_mode() returns -EBUSY if the buffer
+	 * is not enabled.
 	 */
-	if (!iio_buffer_enabled(indio_dev))
+	if (iio_device_claim_buffer_mode(indio_dev) < 0)
 		return 0;
 
 	out = (s16 *)st->samples;
@@ -210,6 +213,7 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
 					   timestamp + delta);
 
+	iio_device_release_buffer_mode(indio_dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index d5ea1a1be122..a492e8f2fc0f 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -140,8 +140,8 @@ enum ad3552r_ch_vref_select {
 };
 
 enum ad3542r_id {
-	AD3542R_ID = 0x4008,
-	AD3552R_ID = 0x4009,
+	AD3542R_ID = 0x4009,
+	AD3552R_ID = 0x4008,
 };
 
 enum ad3552r_ch_output_range {
diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 8c8e0bbfc99f..8d9066c352bf 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -351,9 +351,9 @@ static int admv1013_update_mixer_vgate(struct admv1013_state *st)
 	if (vcm < 0)
 		return vcm;
 
-	if (vcm < 1800000)
+	if (vcm <= 1800000)
 		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
-	else if (vcm > 1800000 && vcm < 2600000)
+	else if (vcm > 1800000 && vcm <= 2600000)
 		mixer_vgate = (2375 * vcm / 1000000 + 125) / 100;
 	else
 		return -EINVAL;
diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index fa79b1ac4f85..83e53acfbe88 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -2,6 +2,8 @@
 
 config BOSCH_BNO055
 	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config BOSCH_BNO055_SERIAL
 	tristate "Bosch BNO055 attached via UART"
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6089f3f9d8f4..a2ef1373a274 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2179,7 +2179,7 @@ int bmp280_common_probe(struct device *dev,
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
+	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index b10dbf5cf494..1ff091b2f764 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -57,8 +57,8 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 
-/* Make sure sleep time is <= 20ms for usleep_range */
-#define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
+/* Make sure sleep time is <= 30ms for usleep_range */
+#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
 /* Silently handle error in rate value here */
 #define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
 
@@ -402,8 +402,8 @@ static int dps310_reset_wait(struct dps310_data *data)
 	if (rc)
 		return rc;
 
-	/* Wait for device chip access: 2.5ms in specification */
-	usleep_range(2500, 12000);
+	/* Wait for device chip access: 15ms in specification */
+	usleep_range(15000, 55000);
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 627497e61a63..2fc706f9d8ae 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -76,7 +76,7 @@ static bool ms5611_prom_is_valid(u16 *prom, size_t len)
 
 	crc = (crc >> 12) & 0x000F;
 
-	return crc_orig != 0x0000 && crc == crc_orig;
+	return crc == crc_orig;
 }
 
 static int ms5611_read_prom(struct iio_dev *indio_dev)
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index ced615b5ea09..040ba2224f9f 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1965,6 +1965,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
 	int win;
 
 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
 	req = __skb_put_zero(skb, sizeof(*req));
 	req->op_compl = htonl(WR_OP_V(FW_OFLD_CONNECTION_WR));
 	req->len16_pkd = htonl(FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*req), 16)));
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index cdb193317c3b..fab2e7240ef2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -130,6 +130,7 @@ static const struct xpad_device {
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
@@ -271,6 +272,7 @@ static const struct xpad_device {
 	{ 0x1038, 0x1430, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
+	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
 	{ 0x1209, 0x2882, "Ardwiino Controller", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
@@ -457,6 +459,7 @@ static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One controllers */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft Xbox 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft Xbox One controllers */
@@ -475,6 +478,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries controllers */
 	XPAD_XBOXONE_VENDOR(0x10f5),		/* Turtle Beach Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
+	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* Xbox 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane Xbox 360 controllers */
diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index c1c733a9cb89..db2ba89adaef 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -425,6 +425,7 @@ static void powermate_disconnect(struct usb_interface *intf)
 		pm->requires_update = 0;
 		usb_kill_urb(pm->irq);
 		input_unregister_device(pm->input);
+		usb_kill_urb(pm->config);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2118b2075f43..4e38229404b4 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -2114,6 +2114,7 @@ static int elantech_setup_ps2(struct psmouse *psmouse,
 	psmouse->protocol_handler = elantech_process_byte;
 	psmouse->disconnect = elantech_disconnect;
 	psmouse->reconnect = elantech_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->pktsize = info->hw_version > 1 ? 6 : 4;
 
 	return 0;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ada299ec5bba..cefc74b3b34b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1623,6 +1623,7 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->cleanup = synaptics_reset;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 1724d6cb8649..9c39553d30fa 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -618,6 +618,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
+	{
+		/* Fujitsu Lifebook E5411 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU CLIENT COMPUTING LIMITED"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E5411"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		/* Gigabyte M912 */
 		.matches = {
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f5aa240739f9..0f727dbc7232 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -900,6 +900,25 @@ static int goodix_add_acpi_gpio_mappings(struct goodix_ts_data *ts)
 		dev_info(dev, "No ACPI GpioInt resource, assuming that the GPIO order is reset, int\n");
 		ts->irq_pin_access_method = IRQ_PIN_ACCESS_ACPI_GPIO;
 		gpio_mapping = acpi_goodix_int_last_gpios;
+	} else if (ts->gpio_count == 1 && ts->gpio_int_idx == 0) {
+		/*
+		 * On newer devices there is only 1 GpioInt resource and _PS0
+		 * does the whole reset sequence for us.
+		 */
+		acpi_device_fix_up_power(ACPI_COMPANION(dev));
+
+		/*
+		 * Before the _PS0 call the int GPIO may have been in output
+		 * mode and the call should have put the int GPIO in input mode,
+		 * but the GPIO subsys cached state may still think it is
+		 * in output mode, causing gpiochip_lock_as_irq() failure.
+		 *
+		 * Add a mapping for the int GPIO to make the
+		 * gpiod_int = gpiod_get(..., GPIOD_IN) call succeed,
+		 * which will explicitly set the direction to input.
+		 */
+		ts->irq_pin_access_method = IRQ_PIN_ACCESS_NONE;
+		gpio_mapping = acpi_goodix_int_first_gpios;
 	} else {
 		dev_warn(dev, "Unexpected ACPI resources: gpio_count %d, gpio_int_idx %d\n",
 			 ts->gpio_count, ts->gpio_int_idx);
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 4bbfa2b0a4df..2cee5477be6b 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -118,7 +118,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &= ~(TSSEL_MASK << tssr_offset);
+		reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 978fdfc19a06..0cac5bead84f 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -387,17 +387,13 @@ EXPORT_SYMBOL_NS_GPL(mcb_free_dev, MCB);
 
 static int __mcb_bus_add_devices(struct device *dev, void *data)
 {
-	struct mcb_device *mdev = to_mcb_device(dev);
 	int retval;
 
-	if (mdev->is_added)
-		return 0;
-
 	retval = device_attach(dev);
-	if (retval < 0)
+	if (retval < 0) {
 		dev_err(dev, "Error adding device (%d)\n", retval);
-
-	mdev->is_added = true;
+		return retval;
+	}
 
 	return 0;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 2aef990f379f..656b6b71c768 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -99,8 +99,6 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	mdev->mem.end = mdev->mem.start + size - 1;
 	mdev->mem.flags = IORESOURCE_MEM;
 
-	mdev->is_added = false;
-
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
 		goto err;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 1dc6227d353e..dc0463bf3c2c 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -753,7 +753,8 @@ static int crypt_iv_eboiv_gen(struct crypt_config *cc, u8 *iv,
 	int err;
 	u8 *buf;
 
-	reqsize = ALIGN(crypto_skcipher_reqsize(tfm), __alignof__(__le64));
+	reqsize = sizeof(*req) + crypto_skcipher_reqsize(tfm);
+	reqsize = ALIGN(reqsize, __alignof__(__le64));
 
 	req = kmalloc(reqsize + cc->iv_size, GFP_NOIO);
 	if (!req)
diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 2ec179cd1264..a7c1415f46e4 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -517,6 +517,13 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 				       V4L2_SUBDEV_CLIENT_CAP_STREAMS;
 	int rval;
 
+	/*
+	 * If the streams API is not enabled, remove V4L2_SUBDEV_CAP_STREAMS.
+	 * Remove this when the API is no longer experimental.
+	 */
+	if (!v4l2_subdev_enable_streams_api)
+		streams_subdev = false;
+
 	switch (cmd) {
 	case VIDIOC_SUBDEV_QUERYCAP: {
 		struct v4l2_subdev_capability *cap = arg;
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e626de33e735..716bba8cc201 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -185,7 +185,7 @@ config CAN_SLCAN
 
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
-	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
+	depends on MACH_SUN4I || MACH_SUN7I || (RISCV && ARCH_SUNXI) || COMPILE_TEST
 	help
 	  Say Y here if you want to use CAN controller found on Allwinner
 	  A10/A20/D1 SoCs.
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 0ada0e160e93..743c2eb62b87 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -392,7 +392,13 @@ static irqreturn_t sja1000_reset_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 
 	netdev_dbg(dev, "performing a soft reset upon overrun\n");
-	sja1000_start(dev);
+
+	netif_tx_lock(dev);
+
+	can_free_echo_skb(dev, 0, NULL);
+	sja1000_set_mode(dev, CAN_MODE_START);
+
+	netif_tx_unlock(dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index efe9380d4a15..252089929eb9 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -505,8 +505,8 @@ qca8k_bulk_read(void *ctx, const void *reg_buf, size_t reg_len,
 		void *val_buf, size_t val_len)
 {
 	int i, count = val_len / sizeof(u32), ret;
-	u32 reg = *(u32 *)reg_buf & U16_MAX;
 	struct qca8k_priv *priv = ctx;
+	u32 reg = *(u16 *)reg_buf;
 
 	if (priv->mgmt_master &&
 	    !qca8k_read_eth(priv, reg, val_buf, val_len))
@@ -527,8 +527,8 @@ qca8k_bulk_gather_write(void *ctx, const void *reg_buf, size_t reg_len,
 			const void *val_buf, size_t val_len)
 {
 	int i, count = val_len / sizeof(u32), ret;
-	u32 reg = *(u32 *)reg_buf & U16_MAX;
 	struct qca8k_priv *priv = ctx;
+	u32 reg = *(u16 *)reg_buf;
 	u32 *val = (u32 *)val_buf;
 
 	if (priv->mgmt_master &&
@@ -666,6 +666,15 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 		goto err_read_skb;
 	}
 
+	/* It seems that accessing the switch's internal PHYs via management
+	 * packets still uses the MDIO bus within the switch internally, and
+	 * these accesses can conflict with external MDIO accesses to other
+	 * devices on the MDIO bus.
+	 * We therefore need to lock the MDIO bus onto which the switch is
+	 * connected.
+	 */
+	mutex_lock(&priv->bus->mdio_lock);
+
 	/* Actually start the request:
 	 * 1. Send mdio master packet
 	 * 2. Busy Wait for mdio master command
@@ -678,6 +687,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	mgmt_master = priv->mgmt_master;
 	if (!mgmt_master) {
 		mutex_unlock(&mgmt_eth_data->mutex);
+		mutex_unlock(&priv->bus->mdio_lock);
 		ret = -EINVAL;
 		goto err_mgmt_master;
 	}
@@ -765,6 +775,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 				    QCA8K_ETHERNET_TIMEOUT);
 
 	mutex_unlock(&mgmt_eth_data->mutex);
+	mutex_unlock(&priv->bus->mdio_lock);
 
 	return ret;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 29cc60988071..ea88ac04ab9a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -28,6 +28,9 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	struct vf_macvlans *mv_list;
 	int num_vf_macvlans, i;
 
+	/* Initialize list of VF macvlans */
+	INIT_LIST_HEAD(&adapter->vf_mvs.l);
+
 	num_vf_macvlans = hw->mac.num_rar_entries -
 			  (IXGBE_MAX_PF_MACVLANS + 1 + num_vfs);
 	if (!num_vf_macvlans)
@@ -36,8 +39,6 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
 			  GFP_KERNEL);
 	if (mv_list) {
-		/* Initialize list of VF macvlans */
-		INIT_LIST_HEAD(&adapter->vf_mvs.l);
 		for (i = 0; i < num_vf_macvlans; i++) {
 			mv_list[i].vf = -1;
 			mv_list[i].free = true;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 59b138214af2..6cc7a78968fc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -1357,10 +1357,12 @@ static int cn10k_mdo_upd_txsa(struct macsec_context *ctx)
 
 	if (netif_running(secy->netdev)) {
 		/* Keys cannot be changed after creation */
-		err = cn10k_write_tx_sa_pn(pfvf, txsc, sa_num,
-					   sw_tx_sa->next_pn);
-		if (err)
-			return err;
+		if (ctx->sa.update_pn) {
+			err = cn10k_write_tx_sa_pn(pfvf, txsc, sa_num,
+						   sw_tx_sa->next_pn);
+			if (err)
+				return err;
+		}
 
 		err = cn10k_mcs_link_tx_sa2sc(pfvf, secy, txsc,
 					      sa_num, sw_tx_sa->active);
@@ -1529,6 +1531,9 @@ static int cn10k_mdo_upd_rxsa(struct macsec_context *ctx)
 		if (err)
 			return err;
 
+		if (!ctx->sa.update_pn)
+			return 0;
+
 		err = cn10k_mcs_write_rx_sa_pn(pfvf, rxsc, sa_num,
 					       rx_sa->next_pn);
 		if (err)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 20ecc90d203e..379e1510b70c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1401,6 +1401,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		return 0;
 	}
 
+	pp_params.order = get_order(buf_size);
 	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
 	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
 	pp_params.nid = NUMA_NO_NODE;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 592b165530ff..6bce55978aa7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -612,7 +612,7 @@ static int mlx5e_macsec_upd_txsa(struct macsec_context *ctx)
 		goto out;
 	}
 
-	if (tx_sa->next_pn != ctx_tx_sa->next_pn_halves.lower) {
+	if (ctx->sa.update_pn) {
 		netdev_err(netdev, "MACsec offload: update TX sa %d PN isn't supported\n",
 			   assoc_num);
 		err = -EINVAL;
@@ -1017,7 +1017,7 @@ static int mlx5e_macsec_upd_rxsa(struct macsec_context *ctx)
 		goto out;
 	}
 
-	if (rx_sa->next_pn != ctx_rx_sa->next_pn_halves.lower) {
+	if (ctx->sa.update_pn) {
 		netdev_err(ctx->netdev,
 			   "MACsec offload update RX sa %d PN isn't supported\n",
 			   assoc_num);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7b494125eee..0cbe822ab084 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3952,13 +3952,14 @@ static int set_feature_rx_fcs(struct net_device *netdev, bool enable)
 	struct mlx5e_channels *chs = &priv->channels;
 	struct mlx5e_params new_params;
 	int err;
+	bool rx_ts_over_crc = !enable;
 
 	mutex_lock(&priv->state_lock);
 
 	new_params = chs->params;
 	new_params.scatter_fcs_en = enable;
 	err = mlx5e_safe_switch_params(priv, &new_params, mlx5e_set_rx_port_ts_wrap,
-				       &new_params.scatter_fcs_en, true);
+				       &rx_ts_over_crc, true);
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index bb8eeb86edf7..52c2fe3644d4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -310,8 +310,8 @@ const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops = {
 	.fdb_clear_offload = mlxsw_sp_nve_vxlan_clear_offload,
 };
 
-static bool mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
-					     bool learning_en)
+static int mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
+					    bool learning_en)
 {
 	char tnpc_pl[MLXSW_REG_TNPC_LEN];
 
diff --git a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
index f21cf1f40f98..153533cd8f08 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
@@ -210,6 +210,7 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 	unsigned int msg_len = nfp_flower_cmsg_get_data_len(skb);
 	struct nfp_flower_cmsg_merge_hint *msg;
 	struct nfp_fl_payload *sub_flows[2];
+	struct nfp_flower_priv *priv;
 	int err, i, flow_cnt;
 
 	msg = nfp_flower_cmsg_get_data(skb);
@@ -228,14 +229,15 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 		return;
 	}
 
-	rtnl_lock();
+	priv = app->priv;
+	mutex_lock(&priv->nfp_fl_lock);
 	for (i = 0; i < flow_cnt; i++) {
 		u32 ctx = be32_to_cpu(msg->flow[i].host_ctx);
 
 		sub_flows[i] = nfp_flower_get_fl_payload_from_ctx(app, ctx);
 		if (!sub_flows[i]) {
 			nfp_flower_cmsg_warn(app, "Invalid flow in merge hint\n");
-			goto err_rtnl_unlock;
+			goto err_mutex_unlock;
 		}
 	}
 
@@ -244,8 +246,8 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 	if (err == -ENOMEM)
 		nfp_flower_cmsg_warn(app, "Flow merge memory fail.\n");
 
-err_rtnl_unlock:
-	rtnl_unlock();
+err_mutex_unlock:
+	mutex_unlock(&priv->nfp_fl_lock);
 }
 
 static void
diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 73032173ac4e..308ca22b8909 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -2130,8 +2130,6 @@ nfp_fl_ct_offload_nft_flow(struct nfp_fl_ct_zone_entry *zt, struct flow_cls_offl
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct netlink_ext_ack *extack = NULL;
 
-	ASSERT_RTNL();
-
 	extack = flow->common.extack;
 	switch (flow->command) {
 	case FLOW_CLS_REPLACE:
@@ -2177,9 +2175,13 @@ int nfp_fl_ct_handle_nft_flow(enum tc_setup_type type, void *type_data, void *cb
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
-		rtnl_lock();
+		while (!mutex_trylock(&zt->priv->nfp_fl_lock)) {
+			if (!zt->nft) /* avoid deadlock */
+				return err;
+			msleep(20);
+		}
 		err = nfp_fl_ct_offload_nft_flow(zt, flow);
-		rtnl_unlock();
+		mutex_unlock(&zt->priv->nfp_fl_lock);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -2207,6 +2209,7 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_map_entry *ct_map_ent)
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct nfp_fl_ct_zone_entry *zt;
 	struct rhashtable *m_table;
+	struct nf_flowtable *nft;
 
 	if (!ct_map_ent)
 		return -ENOENT;
@@ -2225,8 +2228,12 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_map_entry *ct_map_ent)
 		if (ct_map_ent->cookie > 0)
 			kfree(ct_map_ent);
 
-		if (!zt->pre_ct_count) {
-			zt->nft = NULL;
+		if (!zt->pre_ct_count && zt->nft) {
+			nft = zt->nft;
+			zt->nft = NULL; /* avoid deadlock */
+			nf_flow_table_offload_del_cb(nft,
+						     nfp_fl_ct_handle_nft_flow,
+						     zt);
 			nfp_fl_ct_clean_nft_entries(zt);
 		}
 		break;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.h b/drivers/net/ethernet/netronome/nfp/flower/main.h
index 40372545148e..2b7c947ff4f2 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.h
@@ -297,6 +297,7 @@ struct nfp_fl_internal_ports {
  * @predt_list:		List to keep track of decap pretun flows
  * @neigh_table:	Table to keep track of neighbor entries
  * @predt_lock:		Lock to serialise predt/neigh table updates
+ * @nfp_fl_lock:	Lock to protect the flow offload operation
  */
 struct nfp_flower_priv {
 	struct nfp_app *app;
@@ -339,6 +340,7 @@ struct nfp_flower_priv {
 	struct list_head predt_list;
 	struct rhashtable neigh_table;
 	spinlock_t predt_lock; /* Lock to serialise predt/neigh table updates */
+	struct mutex nfp_fl_lock; /* Protect the flow operation */
 };
 
 /**
diff --git a/drivers/net/ethernet/netronome/nfp/flower/metadata.c b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
index 0f06ef6e24bf..80e4675582bf 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -528,6 +528,8 @@ int nfp_flower_metadata_init(struct nfp_app *app, u64 host_ctx_count,
 	if (err)
 		goto err_free_stats_ctx_table;
 
+	mutex_init(&priv->nfp_fl_lock);
+
 	err = rhashtable_init(&priv->ct_zone_table, &nfp_zone_table_params);
 	if (err)
 		goto err_free_merge_table;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index 18328eb7f5c3..24334deb62a1 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -1009,8 +1009,6 @@ int nfp_flower_merge_offloaded_flows(struct nfp_app *app,
 	u64 parent_ctx = 0;
 	int err;
 
-	ASSERT_RTNL();
-
 	if (sub_flow1 == sub_flow2 ||
 	    nfp_flower_is_merge_flow(sub_flow1) ||
 	    nfp_flower_is_merge_flow(sub_flow2))
@@ -1727,19 +1725,30 @@ static int
 nfp_flower_repr_offload(struct nfp_app *app, struct net_device *netdev,
 			struct flow_cls_offload *flower)
 {
+	struct nfp_flower_priv *priv = app->priv;
+	int ret;
+
 	if (!eth_proto_is_802_3(flower->common.protocol))
 		return -EOPNOTSUPP;
 
+	mutex_lock(&priv->nfp_fl_lock);
 	switch (flower->command) {
 	case FLOW_CLS_REPLACE:
-		return nfp_flower_add_offload(app, netdev, flower);
+		ret = nfp_flower_add_offload(app, netdev, flower);
+		break;
 	case FLOW_CLS_DESTROY:
-		return nfp_flower_del_offload(app, netdev, flower);
+		ret = nfp_flower_del_offload(app, netdev, flower);
+		break;
 	case FLOW_CLS_STATS:
-		return nfp_flower_get_stats(app, netdev, flower);
+		ret = nfp_flower_get_stats(app, netdev, flower);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	mutex_unlock(&priv->nfp_fl_lock);
+
+	return ret;
 }
 
 static int nfp_flower_setup_tc_block_cb(enum tc_setup_type type,
@@ -1778,6 +1787,7 @@ static int nfp_flower_setup_tc_block(struct net_device *netdev,
 	repr_priv = repr->app_priv;
 	repr_priv->block_shared = f->block_shared;
 	f->driver_block_list = &nfp_block_cb_list;
+	f->unlocked_driver_cb = true;
 
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
@@ -1876,6 +1886,8 @@ nfp_flower_setup_indr_tc_block(struct net_device *netdev, struct Qdisc *sch, str
 	     nfp_flower_internal_port_can_offload(app, netdev)))
 		return -EOPNOTSUPP;
 
+	f->unlocked_driver_cb = true;
+
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
 		cb_priv = nfp_flower_indr_block_cb_priv_lookup(app, netdev);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
index 99052a925d9e..e7180b4793c7 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
@@ -523,25 +523,31 @@ int nfp_flower_setup_qos_offload(struct nfp_app *app, struct net_device *netdev,
 {
 	struct netlink_ext_ack *extack = flow->common.extack;
 	struct nfp_flower_priv *fl_priv = app->priv;
+	int ret;
 
 	if (!(fl_priv->flower_ext_feats & NFP_FL_FEATS_VF_RLIM)) {
 		NL_SET_ERR_MSG_MOD(extack, "unsupported offload: loaded firmware does not support qos rate limit offload");
 		return -EOPNOTSUPP;
 	}
 
+	mutex_lock(&fl_priv->nfp_fl_lock);
 	switch (flow->command) {
 	case TC_CLSMATCHALL_REPLACE:
-		return nfp_flower_install_rate_limiter(app, netdev, flow,
-						       extack);
+		ret = nfp_flower_install_rate_limiter(app, netdev, flow, extack);
+		break;
 	case TC_CLSMATCHALL_DESTROY:
-		return nfp_flower_remove_rate_limiter(app, netdev, flow,
-						      extack);
+		ret = nfp_flower_remove_rate_limiter(app, netdev, flow, extack);
+		break;
 	case TC_CLSMATCHALL_STATS:
-		return nfp_flower_stats_rate_limiter(app, netdev, flow,
-						     extack);
+		ret = nfp_flower_stats_rate_limiter(app, netdev, flow, extack);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	mutex_unlock(&fl_priv->nfp_fl_lock);
+
+	return ret;
 }
 
 /* Offload tc action, currently only for tc police */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4d6b3b7d6abb..ef8f205f8ce1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2168,6 +2168,8 @@ static int ravb_close(struct net_device *ndev)
 			of_phy_deregister_fixed_link(np);
 	}
 
+	cancel_work_sync(&priv->work);
+
 	if (info->multi_irqs) {
 		free_irq(priv->tx_irqs[RAVB_NC], ndev);
 		free_irq(priv->rx_irqs[RAVB_NC], ndev);
@@ -2892,8 +2894,6 @@ static int ravb_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
-	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
-			  priv->desc_bat_dma);
 	/* Set reset mode */
 	ravb_write(ndev, CCC_OPC_RESET, CCC);
 	unregister_netdev(ndev);
@@ -2901,6 +2901,8 @@ static int ravb_remove(struct platform_device *pdev)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
 	ravb_mdio_release(priv);
+	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
+			  priv->desc_bat_dma);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(priv->rstc);
diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 660cbfe344d2..fb9a520f4207 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1255,7 +1255,7 @@ static void rswitch_adjust_link(struct net_device *ndev)
 		phy_print_status(phydev);
 		if (phydev->link)
 			phy_power_on(rdev->serdes);
-		else
+		else if (rdev->serdes->power_count)
 			phy_power_off(rdev->serdes);
 
 		rdev->etha->link = phydev->link;
@@ -1942,15 +1942,17 @@ static void rswitch_deinit(struct rswitch_private *priv)
 	rswitch_gwca_hw_deinit(priv);
 	rcar_gen4_ptp_unregister(priv->ptp_priv);
 
-	for (i = 0; i < RSWITCH_NUM_PORTS; i++) {
+	rswitch_for_each_enabled_port(priv, i) {
 		struct rswitch_device *rdev = priv->rdev[i];
 
-		phy_exit(priv->rdev[i]->serdes);
-		rswitch_ether_port_deinit_one(rdev);
 		unregister_netdev(rdev->ndev);
-		rswitch_device_free(priv, i);
+		rswitch_ether_port_deinit_one(rdev);
+		phy_exit(priv->rdev[i]->serdes);
 	}
 
+	for (i = 0; i < RSWITCH_NUM_PORTS; i++)
+		rswitch_device_free(priv, i);
+
 	rswitch_gwca_ts_queue_free(priv);
 	rswitch_gwca_linkfix_free(priv);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6931973028ae..e840cadb2d75 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5940,33 +5940,6 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/* Polling receive - used by NETCONSOLE and other diagnostic tools
- * to allow network I/O with interrupts disabled.
- */
-static void stmmac_poll_controller(struct net_device *dev)
-{
-	struct stmmac_priv *priv = netdev_priv(dev);
-	int i;
-
-	/* If adapter is down, do nothing */
-	if (test_bit(STMMAC_DOWN, &priv->state))
-		return;
-
-	if (priv->plat->multi_msi_en) {
-		for (i = 0; i < priv->plat->rx_queues_to_use; i++)
-			stmmac_msi_intr_rx(0, &priv->dma_conf.rx_queue[i]);
-
-		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
-			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
-	} else {
-		disable_irq(dev->irq);
-		stmmac_interrupt(dev->irq, dev);
-		enable_irq(dev->irq);
-	}
-}
-#endif
-
 /**
  *  stmmac_ioctl - Entry point for the Ioctl
  *  @dev: Device pointer.
@@ -6802,9 +6775,6 @@ static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_eth_ioctl = stmmac_ioctl,
 	.ndo_setup_tc = stmmac_setup_tc,
 	.ndo_select_queue = stmmac_select_queue,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller = stmmac_poll_controller,
-#endif
 	.ndo_set_mac_address = stmmac_set_mac_address,
 	.ndo_vlan_rx_add_vid = stmmac_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = stmmac_vlan_rx_kill_vid,
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index f9b10e84de06..9cb99dc65db3 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2741,7 +2741,6 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 	struct device_node *np = spi->dev.of_node;
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 	struct ca8210_platform_data *pdata = spi->dev.platform_data;
-	int ret = 0;
 
 	if (!np)
 		return -EFAULT;
@@ -2758,18 +2757,8 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 		dev_crit(&spi->dev, "Failed to register external clk\n");
 		return PTR_ERR(priv->clk);
 	}
-	ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
-	if (ret) {
-		clk_unregister(priv->clk);
-		dev_crit(
-			&spi->dev,
-			"Failed to register external clock as clock provider\n"
-		);
-	} else {
-		dev_info(&spi->dev, "External clock set as clock provider\n");
-	}
 
-	return ret;
+	return of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
 }
 
 /**
@@ -2781,8 +2770,8 @@ static void ca8210_unregister_ext_clock(struct spi_device *spi)
 {
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 
-	if (!priv->clk)
-		return
+	if (IS_ERR_OR_NULL(priv->clk))
+		return;
 
 	of_clk_del_provider(spi->dev.of_node);
 	clk_unregister(priv->clk);
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 2d64650f4eb3..1c60548c1ddd 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2394,6 +2394,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.tx_sa = tx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_txsa, &ctx);
@@ -2487,6 +2488,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.rx_sa = rx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_rxsa, &ctx);
diff --git a/drivers/net/phy/mscc/mscc_macsec.c b/drivers/net/phy/mscc/mscc_macsec.c
index 018253a573b8..4f39ba63a9a9 100644
--- a/drivers/net/phy/mscc/mscc_macsec.c
+++ b/drivers/net/phy/mscc/mscc_macsec.c
@@ -849,6 +849,9 @@ static int vsc8584_macsec_upd_rxsa(struct macsec_context *ctx)
 	struct macsec_flow *flow;
 	int ret;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_INGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
@@ -900,6 +903,9 @@ static int vsc8584_macsec_upd_txsa(struct macsec_context *ctx)
 	struct macsec_flow *flow;
 	int ret;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_EGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 48d7d278631e..99ec1d4a972d 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -222,13 +222,18 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 
 	__le16 res;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(dev->net, "Only internal phy supported\n");
 		return 0;
 	}
 
-	dm_read_shared_word(dev, 1, loc, &res);
+	err = dm_read_shared_word(dev, 1, loc, &res);
+	if (err < 0) {
+		netdev_err(dev->net, "MDIO read error: %d\n", err);
+		return err;
+	}
 
 	netdev_dbg(dev->net,
 		   "dm9601_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index f3f2c07423a6..fc3bb63b9ac3 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -41,8 +41,6 @@
 #include <asm/xen/hypercall.h>
 #include <xen/balloon.h>
 
-#define XENVIF_QUEUE_LENGTH 32
-
 /* Number of bytes allowed on the internal guest Rx queue. */
 #define XENVIF_RX_QUEUE_BYTES (XEN_NETIF_RX_RING_SIZE/2 * PAGE_SIZE)
 
@@ -530,8 +528,6 @@ struct xenvif *xenvif_alloc(struct device *parent, domid_t domid,
 	dev->features = dev->hw_features | NETIF_F_RXCSUM;
 	dev->ethtool_ops = &xenvif_ethtool_ops;
 
-	dev->tx_queue_len = XENVIF_QUEUE_LENGTH;
-
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU - VLAN_ETH_HLEN;
 
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index b8c15878bc86..43aba01399be 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1862,7 +1862,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 		u64 delta;
 		int i;
 
-		for (i = 0; i < CMN_DTM_NUM_COUNTERS; i++) {
+		for (i = 0; i < CMN_DT_NUM_COUNTERS; i++) {
 			if (status & (1U << i)) {
 				ret = IRQ_HANDLED;
 				if (WARN_ON(!dtc->counters[i]))
diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 569f12af2aaf..0a8b40edc3f3 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -126,6 +126,10 @@ struct lynx_28g_lane {
 struct lynx_28g_priv {
 	void __iomem *base;
 	struct device *dev;
+	/* Serialize concurrent access to registers shared between lanes,
+	 * like PCCn
+	 */
+	spinlock_t pcc_lock;
 	struct lynx_28g_pll pll[LYNX_28G_NUM_PLL];
 	struct lynx_28g_lane lane[LYNX_28G_NUM_LANE];
 
@@ -396,6 +400,8 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
+	spin_lock(&priv->pcc_lock);
+
 	switch (submode) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
@@ -412,6 +418,8 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lane->interface = submode;
 
 out:
+	spin_unlock(&priv->pcc_lock);
+
 	/* Power up the lane if necessary */
 	if (powered_up)
 		lynx_28g_power_on(phy);
@@ -507,11 +515,12 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
 
-		if (!lane->init)
-			continue;
+		mutex_lock(&lane->phy->mutex);
 
-		if (!lane->powered_up)
+		if (!lane->init || !lane->powered_up) {
+			mutex_unlock(&lane->phy->mutex);
 			continue;
+		}
 
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 		if (!(rrstctl & LYNX_28G_LNaRRSTCTL_CDR_LOCK)) {
@@ -520,6 +529,8 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 			} while (!(rrstctl & LYNX_28G_LNaRRSTCTL_RST_DONE));
 		}
+
+		mutex_unlock(&lane->phy->mutex);
 	}
 	queue_delayed_work(system_power_efficient_wq, &priv->cdr_check,
 			   msecs_to_jiffies(1000));
@@ -592,6 +603,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, priv);
 
+	spin_lock_init(&priv->pcc_lock);
 	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
 
 	queue_delayed_work(system_power_efficient_wq, &priv->cdr_check,
@@ -603,6 +615,14 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(provider);
 }
 
+static void lynx_28g_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lynx_28g_priv *priv = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&priv->cdr_check);
+}
+
 static const struct of_device_id lynx_28g_of_match_table[] = {
 	{ .compatible = "fsl,lynx-28g" },
 	{ },
@@ -611,6 +631,7 @@ MODULE_DEVICE_TABLE(of, lynx_28g_of_match_table);
 
 static struct platform_driver lynx_28g_driver = {
 	.probe	= lynx_28g_probe,
+	.remove_new = lynx_28g_remove,
 	.driver	= {
 		.name = "lynx-28g",
 		.of_match_table = lynx_28g_of_match_table,
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 401886c81344..b84781cfc259 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1012,17 +1012,20 @@ static int add_setting(struct pinctrl *p, struct pinctrl_dev *pctldev,
 
 static struct pinctrl *find_pinctrl(struct device *dev)
 {
-	struct pinctrl *p;
+	struct pinctrl *entry, *p = NULL;
 
 	mutex_lock(&pinctrl_list_mutex);
-	list_for_each_entry(p, &pinctrl_list, node)
-		if (p->dev == dev) {
-			mutex_unlock(&pinctrl_list_mutex);
-			return p;
+
+	list_for_each_entry(entry, &pinctrl_list, node) {
+		if (entry->dev == dev) {
+			p = entry;
+			kref_get(&p->users);
+			break;
 		}
+	}
 
 	mutex_unlock(&pinctrl_list_mutex);
-	return NULL;
+	return p;
 }
 
 static void pinctrl_free(struct pinctrl *p, bool inlist);
@@ -1130,7 +1133,6 @@ struct pinctrl *pinctrl_get(struct device *dev)
 	p = find_pinctrl(dev);
 	if (p) {
 		dev_dbg(dev, "obtain a copy of previously claimed pinctrl\n");
-		kref_get(&p->users);
 		return p;
 	}
 
diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
index 2d1c1652cfd9..8a9961ac8712 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -1062,13 +1062,13 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		gpio = &pctrl->gpio_bank[reg];
-		gpio->pctrl = pctrl;
-
 		if (reg >= WPCM450_NUM_BANKS)
 			return dev_err_probe(dev, -EINVAL,
 					     "GPIO index %d out of range!\n", reg);
 
+		gpio = &pctrl->gpio_bank[reg];
+		gpio->pctrl = pctrl;
+
 		bank = &wpcm450_banks[reg];
 		gpio->bank = bank;
 
diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 77730dc548ed..c8d519ca53eb 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -235,6 +235,7 @@ config PINCTRL_RZN1
 	depends on OF
 	depends on ARCH_RZN1 || COMPILE_TEST
 	select GENERIC_PINCONF
+	select PINMUX
 	help
 	  This selects pinctrl driver for Renesas RZ/N1 devices.
 
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 5fe729b4a03d..72747ad497b5 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -968,8 +968,6 @@ int jh7110_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not register gpiochip\n");
 
-	irq_domain_set_pm_device(sfp->gc.irq.domain, dev);
-
 	dev_info(dev, "StarFive GPIO chip registered %d GPIOs\n", sfp->gc.ngpio);
 
 	return pinctrl_enable(sfp->pctl);
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index e76e5458db35..8ebb7be52ee7 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1548,7 +1548,13 @@ static const struct dev_pm_ops hp_wmi_pm_ops = {
 	.restore  = hp_wmi_resume_handler,
 };
 
-static struct platform_driver hp_wmi_driver = {
+/*
+ * hp_wmi_bios_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver hp_wmi_driver __refdata = {
 	.driver = {
 		.name = "hp-wmi",
 		.pm = &hp_wmi_pm_ops,
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 79346881cadb..aee869769843 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1248,6 +1248,24 @@ static void tlmi_release_attr(void)
 	kset_unregister(tlmi_priv.authentication_kset);
 }
 
+static int tlmi_validate_setting_name(struct kset *attribute_kset, char *name)
+{
+	struct kobject *duplicate;
+
+	if (!strcmp(name, "Reserved"))
+		return -EINVAL;
+
+	duplicate = kset_find_obj(attribute_kset, name);
+	if (duplicate) {
+		pr_debug("Duplicate attribute name found - %s\n", name);
+		/* kset_find_obj() returns a reference */
+		kobject_put(duplicate);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int tlmi_sysfs_init(void)
 {
 	int i, ret;
@@ -1276,10 +1294,8 @@ static int tlmi_sysfs_init(void)
 			continue;
 
 		/* check for duplicate or reserved values */
-		if (kset_find_obj(tlmi_priv.attribute_kset, tlmi_priv.setting[i]->display_name) ||
-		    !strcmp(tlmi_priv.setting[i]->display_name, "Reserved")) {
-			pr_debug("duplicate or reserved attribute name found - %s\n",
-				tlmi_priv.setting[i]->display_name);
+		if (tlmi_validate_setting_name(tlmi_priv.attribute_kset,
+					       tlmi_priv.setting[i]->display_name) < 0) {
 			kfree(tlmi_priv.setting[i]->possible_values);
 			kfree(tlmi_priv.setting[i]);
 			tlmi_priv.setting[i] = NULL;
diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index de77df97b3a4..ec163d1bcd18 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -105,7 +105,7 @@ struct qcom_battmgr_property_request {
 
 struct qcom_battmgr_update_request {
 	struct pmic_glink_hdr hdr;
-	u32 battery_id;
+	__le32 battery_id;
 };
 
 struct qcom_battmgr_charge_time_request {
@@ -1282,9 +1282,9 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 {
 	struct qcom_battmgr *battmgr = container_of(work, struct qcom_battmgr, enable_work);
 	struct qcom_battmgr_enable_request req = {
-		.hdr.owner = PMIC_GLINK_OWNER_BATTMGR,
-		.hdr.type = PMIC_GLINK_NOTIFY,
-		.hdr.opcode = BATTMGR_REQUEST_NOTIFICATION,
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_NOTIFY),
+		.hdr.opcode = cpu_to_le32(BATTMGR_REQUEST_NOTIFICATION),
 	};
 	int ret;
 
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 9c67b97faba2..610ad8a801a5 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -103,7 +103,7 @@ config CCWGROUP
 
 config ISM
 	tristate "Support for ISM vPCI Adapter"
-	depends on PCI && SMC
+	depends on PCI
 	default n
 	help
 	  Select this option if you want to use the Internal Shared Memory
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 902655d75947..44680f65ea14 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1627,12 +1627,13 @@ int scsi_rescan_device(struct scsi_device *sdev)
 	device_lock(dev);
 
 	/*
-	 * Bail out if the device is not running. Otherwise, the rescan may
-	 * block waiting for commands to be executed, with us holding the
-	 * device lock. This can result in a potential deadlock in the power
-	 * management core code when system resume is on-going.
+	 * Bail out if the device or its queue are not running. Otherwise,
+	 * the rescan may block waiting for commands to be executed, with us
+	 * holding the device lock. This can result in a potential deadlock
+	 * in the power management core code when system resume is on-going.
 	 */
-	if (sdev->sdev_state != SDEV_RUNNING) {
+	if (sdev->sdev_state != SDEV_RUNNING ||
+	    blk_queue_pm_only(sdev->request_queue)) {
 		ret = -EWOULDBLOCK;
 		goto unlock;
 	}
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 372d64756ed6..3c15f6a9e91c 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -217,12 +217,12 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
 	return rc;
 }
 
+/* mutex must be held by caller */
 static void destroy_session(struct kref *ref)
 {
 	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
 						   refcount);
 
-	mutex_lock(&session_list_mutex);
 	list_del(&sess->list_node);
 	mutex_unlock(&session_list_mutex);
 	kfree(sess);
@@ -272,7 +272,8 @@ int amdtee_open_session(struct tee_context *ctx,
 	if (arg->ret != TEEC_SUCCESS) {
 		pr_err("open_session failed %d\n", arg->ret);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		goto out;
 	}
 
@@ -290,7 +291,8 @@ int amdtee_open_session(struct tee_context *ctx,
 		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
 		handle_close_session(ta_handle, session_info);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -331,7 +333,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 	handle_close_session(ta_handle, session_info);
 	handle_unload_ta(ta_handle);
 
-	kref_put(&sess->refcount, destroy_session);
+	kref_put_mutex(&sess->refcount, destroy_session, &session_list_mutex);
 
 	return 0;
 }
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index dbdcad8d73bf..d8b9c734abd3 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -41,6 +41,7 @@
 #define PHY_PORT_CS1_LINK_STATE_SHIFT	26
 
 #define ICM_TIMEOUT			5000	/* ms */
+#define ICM_RETRIES			3
 #define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
 
@@ -296,10 +297,9 @@ static bool icm_copy(struct tb_cfg_request *req, const struct ctl_pkg *pkg)
 
 static int icm_request(struct tb *tb, const void *request, size_t request_size,
 		       void *response, size_t response_size, size_t npackets,
-		       unsigned int timeout_msec)
+		       int retries, unsigned int timeout_msec)
 {
 	struct icm *icm = tb_priv(tb);
-	int retries = 3;
 
 	do {
 		struct tb_cfg_request *req;
@@ -410,7 +410,7 @@ static int icm_fr_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 		return -ENOMEM;
 
 	ret = icm_request(tb, &request, sizeof(request), switches,
-			  sizeof(*switches), npackets, ICM_TIMEOUT);
+			  sizeof(*switches), npackets, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		goto err_free;
 
@@ -463,7 +463,7 @@ icm_fr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -488,7 +488,7 @@ static int icm_fr_approve_switch(struct tb *tb, struct tb_switch *sw)
 	memset(&reply, 0, sizeof(reply));
 	/* Use larger timeout as establishing tunnels can take some time */
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -515,7 +515,7 @@ static int icm_fr_add_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -543,7 +543,7 @@ static int icm_fr_challenge_switch_key(struct tb *tb, struct tb_switch *sw,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -577,7 +577,7 @@ static int icm_fr_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1020,7 +1020,7 @@ icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, 10, 2000);
 	if (ret)
 		return ret;
 
@@ -1053,7 +1053,7 @@ static int icm_tr_approve_switch(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1081,7 +1081,7 @@ static int icm_tr_add_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1110,7 +1110,7 @@ static int icm_tr_challenge_switch_key(struct tb *tb, struct tb_switch *sw,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1144,7 +1144,7 @@ static int icm_tr_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1170,7 +1170,7 @@ static int icm_tr_xdomain_tear_down(struct tb *tb, struct tb_xdomain *xd,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1496,7 +1496,7 @@ icm_ar_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1522,7 +1522,7 @@ static int icm_ar_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1543,7 +1543,7 @@ static int icm_ar_get_boot_acl(struct tb *tb, uuid_t *uuids, size_t nuuids)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1604,7 +1604,7 @@ static int icm_ar_set_boot_acl(struct tb *tb, const uuid_t *uuids,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1626,7 +1626,7 @@ icm_icl_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, ICM_RETRIES, 20000);
 	if (ret)
 		return ret;
 
@@ -2298,7 +2298,7 @@ static int icm_usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 7ea63bb31714..c15c3b9b50d9 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2724,6 +2724,13 @@ int tb_switch_lane_bonding_enable(struct tb_switch *sw)
 	    !tb_port_is_width_supported(down, TB_LINK_WIDTH_DUAL))
 		return 0;
 
+	/*
+	 * Both lanes need to be in CL0. Here we assume lane 0 already be in
+	 * CL0 and check just for lane 1.
+	 */
+	if (tb_wait_for_port(down->dual_link_port, false) <= 0)
+		return -ENOTCONN;
+
 	ret = tb_port_lane_bonding_enable(up);
 	if (ret) {
 		tb_port_warn(up, "failed to enable lane bonding\n");
diff --git a/drivers/thunderbolt/tmu.c b/drivers/thunderbolt/tmu.c
index 0dfd1e083994..ae88e657dca5 100644
--- a/drivers/thunderbolt/tmu.c
+++ b/drivers/thunderbolt/tmu.c
@@ -382,7 +382,7 @@ static int tmu_mode_init(struct tb_switch *sw)
 		} else if (ucap && tb_port_tmu_is_unidirectional(up)) {
 			if (tmu_rates[TB_SWITCH_TMU_MODE_LOWRES] == rate)
 				sw->tmu.mode = TB_SWITCH_TMU_MODE_LOWRES;
-			else if (tmu_rates[TB_SWITCH_TMU_MODE_LOWRES] == rate)
+			else if (tmu_rates[TB_SWITCH_TMU_MODE_HIFI_UNI] == rate)
 				sw->tmu.mode = TB_SWITCH_TMU_MODE_HIFI_UNI;
 		} else if (rate) {
 			sw->tmu.mode = TB_SWITCH_TMU_MODE_HIFI_BI;
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 5b5566862318..9803f0bbf20d 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -703,6 +703,27 @@ static void update_property_block(struct tb_xdomain *xd)
 	mutex_unlock(&xdomain_lock);
 }
 
+static void start_handshake(struct tb_xdomain *xd)
+{
+	xd->state = XDOMAIN_STATE_INIT;
+	queue_delayed_work(xd->tb->wq, &xd->state_work,
+			   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
+}
+
+/* Can be called from state_work */
+static void __stop_handshake(struct tb_xdomain *xd)
+{
+	cancel_delayed_work_sync(&xd->properties_changed_work);
+	xd->properties_changed_retries = 0;
+	xd->state_retries = 0;
+}
+
+static void stop_handshake(struct tb_xdomain *xd)
+{
+	cancel_delayed_work_sync(&xd->state_work);
+	__stop_handshake(xd);
+}
+
 static void tb_xdp_handle_request(struct work_struct *work)
 {
 	struct xdomain_request_work *xw = container_of(work, typeof(*xw), work);
@@ -765,6 +786,15 @@ static void tb_xdp_handle_request(struct work_struct *work)
 	case UUID_REQUEST:
 		tb_dbg(tb, "%llx: received XDomain UUID request\n", route);
 		ret = tb_xdp_uuid_response(ctl, route, sequence, uuid);
+		/*
+		 * If we've stopped the discovery with an error such as
+		 * timing out, we will restart the handshake now that we
+		 * received UUID request from the remote host.
+		 */
+		if (!ret && xd && xd->state == XDOMAIN_STATE_ERROR) {
+			dev_dbg(&xd->dev, "restarting handshake\n");
+			start_handshake(xd);
+		}
 		break;
 
 	case LINK_STATE_STATUS_REQUEST:
@@ -1521,6 +1551,13 @@ static void tb_xdomain_queue_properties_changed(struct tb_xdomain *xd)
 			   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
 }
 
+static void tb_xdomain_failed(struct tb_xdomain *xd)
+{
+	xd->state = XDOMAIN_STATE_ERROR;
+	queue_delayed_work(xd->tb->wq, &xd->state_work,
+			   msecs_to_jiffies(XDOMAIN_DEFAULT_TIMEOUT));
+}
+
 static void tb_xdomain_state_work(struct work_struct *work)
 {
 	struct tb_xdomain *xd = container_of(work, typeof(*xd), state_work.work);
@@ -1547,7 +1584,7 @@ static void tb_xdomain_state_work(struct work_struct *work)
 		if (ret) {
 			if (ret == -EAGAIN)
 				goto retry_state;
-			xd->state = XDOMAIN_STATE_ERROR;
+			tb_xdomain_failed(xd);
 		} else {
 			tb_xdomain_queue_properties_changed(xd);
 			if (xd->bonding_possible)
@@ -1612,7 +1649,7 @@ static void tb_xdomain_state_work(struct work_struct *work)
 		if (ret) {
 			if (ret == -EAGAIN)
 				goto retry_state;
-			xd->state = XDOMAIN_STATE_ERROR;
+			tb_xdomain_failed(xd);
 		} else {
 			xd->state = XDOMAIN_STATE_ENUMERATED;
 		}
@@ -1623,6 +1660,8 @@ static void tb_xdomain_state_work(struct work_struct *work)
 		break;
 
 	case XDOMAIN_STATE_ERROR:
+		dev_dbg(&xd->dev, "discovery failed, stopping handshake\n");
+		__stop_handshake(xd);
 		break;
 
 	default:
@@ -1833,21 +1872,6 @@ static void tb_xdomain_release(struct device *dev)
 	kfree(xd);
 }
 
-static void start_handshake(struct tb_xdomain *xd)
-{
-	xd->state = XDOMAIN_STATE_INIT;
-	queue_delayed_work(xd->tb->wq, &xd->state_work,
-			   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
-}
-
-static void stop_handshake(struct tb_xdomain *xd)
-{
-	cancel_delayed_work_sync(&xd->properties_changed_work);
-	cancel_delayed_work_sync(&xd->state_work);
-	xd->properties_changed_retries = 0;
-	xd->state_retries = 0;
-}
-
 static int __maybe_unused tb_xdomain_suspend(struct device *dev)
 {
 	stop_handshake(tb_to_xdomain(dev));
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index d48a82f1634e..445235ee53b3 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1618,7 +1618,7 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
-	int err;
+	int err = 0;
 
 	serial8250_suspend_port(priv->line);
 
@@ -1628,7 +1628,8 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port) && console_suspend_enabled)
+		err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
 
 	return err;
@@ -1637,11 +1638,15 @@ static int omap8250_suspend(struct device *dev)
 static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int err;
 
-	err = pm_runtime_force_resume(dev);
-	if (err)
-		return err;
+	if (uart_console(&up->port) && console_suspend_enabled) {
+		err = pm_runtime_force_resume(dev);
+		if (err)
+			return err;
+	}
+
 	serial8250_resume_port(priv->line);
 	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
 	pm_runtime_mark_last_busy(dev);
@@ -1718,16 +1723,6 @@ static int omap8250_runtime_suspend(struct device *dev)
 
 	if (priv->line >= 0)
 		up = serial8250_get_port(priv->line);
-	/*
-	 * When using 'no_console_suspend', the console UART must not be
-	 * suspended. Since driver suspend is managed by runtime suspend,
-	 * preventing runtime suspend (by returning error) will keep device
-	 * active during suspend.
-	 */
-	if (priv->is_suspending && !console_suspend_enabled) {
-		if (up && uart_console(&up->port))
-			return -EBUSY;
-	}
 
 	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
 		int ret;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d033611e6..83c419ac78bc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -157,7 +157,7 @@ static void __uart_start(struct tty_struct *tty)
 	 * enabled, serial_port_runtime_resume() calls start_tx() again
 	 * after enabling the device.
 	 */
-	if (pm_runtime_active(&port_dev->dev))
+	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
 	pm_runtime_put_autosuspend(&port_dev->dev);
@@ -1410,12 +1410,18 @@ static void uart_set_rs485_termination(struct uart_port *port,
 static int uart_rs485_config(struct uart_port *port)
 {
 	struct serial_rs485 *rs485 = &port->rs485;
+	unsigned long flags;
 	int ret;
 
+	if (!(rs485->flags & SER_RS485_ENABLED))
+		return 0;
+
 	uart_sanitize_serial_rs485(port, rs485);
 	uart_set_rs485_termination(port, rs485);
 
+	spin_lock_irqsave(&port->lock, flags);
 	ret = port->rs485_config(port, NULL, rs485);
+	spin_unlock_irqrestore(&port->lock, flags);
 	if (ret)
 		memset(rs485, 0, sizeof(*rs485));
 
@@ -2480,11 +2486,10 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			if (ret == 0) {
 				if (tty)
 					uart_change_line_settings(tty, state, NULL);
+				uart_rs485_config(uport);
 				spin_lock_irq(&uport->lock);
 				if (!(uport->rs485.flags & SER_RS485_ENABLED))
 					ops->set_mctrl(uport, uport->mctrl);
-				else
-					uart_rs485_config(uport);
 				ops->start_tx(uport);
 				spin_unlock_irq(&uport->lock);
 				tty_port_set_initialized(port, true);
@@ -2593,10 +2598,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		port->mctrl &= TIOCM_DTR;
 		if (!(port->rs485.flags & SER_RS485_ENABLED))
 			port->ops->set_mctrl(port, port->mctrl);
-		else
-			uart_rs485_config(port);
 		spin_unlock_irqrestore(&port->lock, flags);
 
+		uart_rs485_config(port);
+
 		/*
 		 * If this driver supports console, and it hasn't been
 		 * successfully registered yet, try to re-register it.
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 80c48eb6bf85..3349c46e5fa2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6955,7 +6955,7 @@ static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag)
 			mask, 0, 1000, 1000);
 
 	dev_err(hba->dev, "Clearing task management function with tag %d %s\n",
-		tag, err ? "succeeded" : "failed");
+		tag, err < 0 ? "failed" : "succeeded");
 
 out:
 	return err;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index fff9ec9c391f..4b67749edb99 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1125,6 +1125,9 @@ static int cdnsp_gadget_ep_dequeue(struct usb_ep *ep,
 	unsigned long flags;
 	int ret;
 
+	if (request->status != -EINPROGRESS)
+		return 0;
+
 	if (!pep->endpoint.desc) {
 		dev_err(pdev->dev,
 			"%s: can't dequeue to disabled endpoint\n",
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 4a4dbc2c1561..81a9c9d6be08 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -131,8 +131,7 @@ void cdns_set_active(struct cdns *cdns, u8 set_active);
 #else /* CONFIG_PM_SLEEP */
 static inline int cdns_resume(struct cdns *cdns)
 { return 0; }
-static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
-{ return 0; }
+static inline void cdns_set_active(struct cdns *cdns, u8 set_active) { }
 static inline int cdns_suspend(struct cdns *cdns)
 { return 0; }
 #endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 26a27ff50408..f2c561ae4bfe 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -151,6 +151,10 @@ int usb_device_supports_lpm(struct usb_device *udev)
 	if (udev->quirks & USB_QUIRK_NO_LPM)
 		return 0;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return 0;
+
 	/* USB 2.1 (and greater) devices indicate LPM support through
 	 * their USB 2.0 Extended Capabilities BOS descriptor.
 	 */
@@ -327,6 +331,10 @@ static void usb_set_lpm_parameters(struct usb_device *udev)
 	if (!udev->lpm_capable || udev->speed < USB_SPEED_SUPER)
 		return;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
 	hub = usb_hub_to_struct_hub(udev->parent);
 	/* It doesn't take time to transition the roothub into U0, since it
 	 * doesn't have an upstream link.
@@ -2720,13 +2728,17 @@ int usb_authorize_device(struct usb_device *usb_dev)
 static enum usb_ssp_rate get_port_ssp_rate(struct usb_device *hdev,
 					   u32 ext_portstatus)
 {
-	struct usb_ssp_cap_descriptor *ssp_cap = hdev->bos->ssp_cap;
+	struct usb_ssp_cap_descriptor *ssp_cap;
 	u32 attr;
 	u8 speed_id;
 	u8 ssac;
 	u8 lanes;
 	int i;
 
+	if (!hdev->bos)
+		goto out;
+
+	ssp_cap = hdev->bos->ssp_cap;
 	if (!ssp_cap)
 		goto out;
 
@@ -4244,8 +4256,15 @@ static void usb_enable_link_state(struct usb_hcd *hcd, struct usb_device *udev,
 		enum usb3_link_state state)
 {
 	int timeout;
-	__u8 u1_mel = udev->bos->ss_cap->bU1devExitLat;
-	__le16 u2_mel = udev->bos->ss_cap->bU2DevExitLat;
+	__u8 u1_mel;
+	__le16 u2_mel;
+
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
+	u1_mel = udev->bos->ss_cap->bU1devExitLat;
+	u2_mel = udev->bos->ss_cap->bU2DevExitLat;
 
 	/* If the device says it doesn't have *any* exit latency to come out of
 	 * U1 or U2, it's probably lying.  Assume it doesn't implement that link
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 37897afd1b64..d44dd7f6623e 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -153,7 +153,7 @@ static inline int hub_is_superspeedplus(struct usb_device *hdev)
 {
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS &&
 		le16_to_cpu(hdev->descriptor.bcdUSB) >= 0x0310 &&
-		hdev->bos->ssp_cap);
+		hdev->bos && hdev->bos->ssp_cap);
 }
 
 static inline unsigned hub_power_on_good_delay(struct usb_hub *hub)
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..343d2570189f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -279,9 +279,46 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	 * XHCI driver will reset the host block. If dwc3 was configured for
 	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
+	/*
+	 * If the dr_mode is host and the dwc->current_dr_role is not the
+	 * corresponding DWC3_GCTL_PRTCAP_HOST, then the dwc3_core_init_mode
+	 * isn't executed yet. Ensure the phy is ready before the controller
+	 * updates the GCTL.PRTCAPDIR or other settings by soft-resetting
+	 * the phy.
+	 *
+	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
+	 * is port index. If this is a multiport host, then we need to reset
+	 * all active ports.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST) {
+		u32 usb3_port;
+		u32 usb2_port;
+
+		usb3_port = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+		usb3_port |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		usb2_port |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Small delay for phy reset assertion */
+		usleep_range(1000, 2000);
+
+		usb3_port &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Wait for clock synchronization */
+		msleep(50);
+		return 0;
+	}
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
 	reg &= ~DWC3_DCTL_RUN_STOP;
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 424bb3b666db..faf90a217419 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1171,7 +1171,8 @@ static int ncm_unwrap_ntb(struct gether *port,
 			  struct sk_buff_head *list)
 {
 	struct f_ncm	*ncm = func_to_ncm(&port->func);
-	__le16		*tmp = (void *) skb->data;
+	unsigned char	*ntb_ptr = skb->data;
+	__le16		*tmp;
 	unsigned	index, index2;
 	int		ndp_index;
 	unsigned	dg_len, dg_len2;
@@ -1184,6 +1185,10 @@ static int ncm_unwrap_ntb(struct gether *port,
 	const struct ndp_parser_opts *opts = ncm->parser_opts;
 	unsigned	crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
 	int		dgram_counter;
+	int		to_process = skb->len;
+
+parse_ntb:
+	tmp = (__le16 *)ntb_ptr;
 
 	/* dwSignature */
 	if (get_unaligned_le32(tmp) != opts->nth_sign) {
@@ -1230,7 +1235,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 		 * walk through NDP
 		 * dwSignature
 		 */
-		tmp = (void *)(skb->data + ndp_index);
+		tmp = (__le16 *)(ntb_ptr + ndp_index);
 		if (get_unaligned_le32(tmp) != ncm->ndp_sign) {
 			INFO(port->func.config->cdev, "Wrong NDP SIGN\n");
 			goto err;
@@ -1287,11 +1292,11 @@ static int ncm_unwrap_ntb(struct gether *port,
 			if (ncm->is_crc) {
 				uint32_t crc, crc2;
 
-				crc = get_unaligned_le32(skb->data +
+				crc = get_unaligned_le32(ntb_ptr +
 							 index + dg_len -
 							 crc_len);
 				crc2 = ~crc32_le(~0,
-						 skb->data + index,
+						 ntb_ptr + index,
 						 dg_len - crc_len);
 				if (crc != crc2) {
 					INFO(port->func.config->cdev,
@@ -1318,7 +1323,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 							 dg_len - crc_len);
 			if (skb2 == NULL)
 				goto err;
-			skb_put_data(skb2, skb->data + index,
+			skb_put_data(skb2, ntb_ptr + index,
 				     dg_len - crc_len);
 
 			skb_queue_tail(list, skb2);
@@ -1331,10 +1336,17 @@ static int ncm_unwrap_ntb(struct gether *port,
 		} while (ndp_len > 2 * (opts->dgram_item_len * 2));
 	} while (ndp_index);
 
-	dev_consume_skb_any(skb);
-
 	VDBG(port->func.config->cdev,
 	     "Parsed NTB with %d frames\n", dgram_counter);
+
+	to_process -= block_len;
+	if (to_process != 0) {
+		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
+		goto parse_ntb;
+	}
+
+	dev_consume_skb_any(skb);
+
 	return 0;
 err:
 	skb_queue_purge(list);
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index a4a7b90a97e7..3e5d82097c71 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -499,11 +499,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		/* Get the Buffer address and copy the transmit data.*/
 		eprambase = (u32 __force *)(udc->addr + ep->rambase);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF0COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -517,11 +519,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		eprambase = (u32 __force *)(udc->addr + ep->rambase +
 			     ep->ep_usb.maxpacket);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF1COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -1023,7 +1027,7 @@ static int __xudc_ep0_queue(struct xusb_ep *ep0, struct xusb_req *req)
 			   udc->addr);
 		length = req->usb_req.actual = min_t(u32, length,
 						     EP0_MAX_PACKET);
-		memcpy(corebuf, req->usb_req.buf, length);
+		memcpy_toio((void __iomem *)corebuf, req->usb_req.buf, length);
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, length);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
 	} else {
@@ -1752,7 +1756,7 @@ static void xudc_handle_setup(struct xusb_udc *udc)
 
 	/* Load up the chapter 9 command buffer.*/
 	ep0rambase = (u32 __force *) (udc->addr + XUSB_SETUP_PKT_ADDR_OFFSET);
-	memcpy(&setup, ep0rambase, 8);
+	memcpy_toio((void __iomem *)&setup, ep0rambase, 8);
 
 	udc->setup = setup;
 	udc->setup.wValue = cpu_to_le16(setup.wValue);
@@ -1839,7 +1843,7 @@ static void xudc_ep0_out(struct xusb_udc *udc)
 			     (ep0->rambase << 2));
 		buffer = req->usb_req.buf + req->usb_req.actual;
 		req->usb_req.actual = req->usb_req.actual + bytes_to_rx;
-		memcpy(buffer, ep0rambase, bytes_to_rx);
+		memcpy_toio((void __iomem *)buffer, ep0rambase, bytes_to_rx);
 
 		if (req->usb_req.length == req->usb_req.actual) {
 			/* Data transfer completed get ready for Status stage */
@@ -1915,7 +1919,7 @@ static void xudc_ep0_in(struct xusb_udc *udc)
 				     (ep0->rambase << 2));
 			buffer = req->usb_req.buf + req->usb_req.actual;
 			req->usb_req.actual = req->usb_req.actual + length;
-			memcpy(ep0rambase, buffer, length);
+			memcpy_toio((void __iomem *)ep0rambase, buffer, length);
 		}
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, count);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 0054d02239e2..0df5d807a77e 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1062,19 +1062,19 @@ static void xhci_get_usb3_port_status(struct xhci_port *port, u32 *status,
 		*status |= USB_PORT_STAT_C_CONFIG_ERROR << 16;
 
 	/* USB3 specific wPortStatus bits */
-	if (portsc & PORT_POWER) {
+	if (portsc & PORT_POWER)
 		*status |= USB_SS_PORT_STAT_POWER;
-		/* link state handling */
-		if (link_state == XDEV_U0)
-			bus_state->suspended_ports &= ~(1 << portnum);
-	}
 
-	/* remote wake resume signaling complete */
-	if (bus_state->port_remote_wakeup & (1 << portnum) &&
+	/* no longer suspended or resuming */
+	if (link_state != XDEV_U3 &&
 	    link_state != XDEV_RESUME &&
 	    link_state != XDEV_RECOVERY) {
-		bus_state->port_remote_wakeup &= ~(1 << portnum);
-		usb_hcd_end_port_resume(&hcd->self, portnum);
+		/* remote wake resume signaling complete */
+		if (bus_state->port_remote_wakeup & (1 << portnum)) {
+			bus_state->port_remote_wakeup &= ~(1 << portnum);
+			usb_hcd_end_port_resume(&hcd->self, portnum);
+		}
+		bus_state->suspended_ports &= ~(1 << portnum);
 	}
 
 	xhci_hub_report_usb3_link_state(xhci, status, portsc);
@@ -1131,6 +1131,7 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 			usb_hcd_end_port_resume(&port->rhub->hcd->self, portnum);
 		}
 		port->rexit_active = 0;
+		bus_state->suspended_ports &= ~(1 << portnum);
 	}
 }
 
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 19a402123de0..e318ac8d30c1 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2288,8 +2288,8 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
 	writel(erst_size, &ir->ir_set->erst_size);
 
 	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
-	erst_base &= ERST_PTR_MASK;
-	erst_base |= (ir->erst.erst_dma_addr & (u64) ~ERST_PTR_MASK);
+	erst_base &= ERST_BASE_RSVDP;
+	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
 	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
 
 	/* Set the event ring dequeue address of this interrupter */
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1dde53f6eb31..3e5dc0723a8f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -798,7 +798,7 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
 static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 		struct xhci_ring *ring, struct xhci_td *td)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_segment *seg = td->bounce_seg;
 	struct urb *urb = td->urb;
 	size_t len;
@@ -2996,7 +2996,8 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
  */
 static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 				     struct xhci_interrupter *ir,
-				     union xhci_trb *event_ring_deq)
+				     union xhci_trb *event_ring_deq,
+				     bool clear_ehb)
 {
 	u64 temp_64;
 	dma_addr_t deq;
@@ -3017,12 +3018,13 @@ static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 			return;
 
 		/* Update HC event ring dequeue pointer */
-		temp_64 &= ERST_PTR_MASK;
+		temp_64 &= ERST_DESI_MASK;
 		temp_64 |= ((u64) deq & (u64) ~ERST_PTR_MASK);
 	}
 
 	/* Clear the event handler busy flag (RW1C) */
-	temp_64 |= ERST_EHB;
+	if (clear_ehb)
+		temp_64 |= ERST_EHB;
 	xhci_write_64(xhci, temp_64, &ir->ir_set->erst_dequeue);
 }
 
@@ -3103,7 +3105,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	while (xhci_handle_event(xhci, ir) > 0) {
 		if (event_loop++ < TRBS_PER_SEGMENT / 2)
 			continue;
-		xhci_update_erst_dequeue(xhci, ir, event_ring_deq);
+		xhci_update_erst_dequeue(xhci, ir, event_ring_deq, false);
 		event_ring_deq = ir->event_ring->dequeue;
 
 		/* ring is half-full, force isoc trbs to interrupt more often */
@@ -3113,7 +3115,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		event_loop = 0;
 	}
 
-	xhci_update_erst_dequeue(xhci, ir, event_ring_deq);
+	xhci_update_erst_dequeue(xhci, ir, event_ring_deq, true);
 	ret = IRQ_HANDLED;
 
 out:
@@ -3469,7 +3471,7 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 static int xhci_align_td(struct xhci_hcd *xhci, struct urb *urb, u32 enqd_len,
 			 u32 *trb_buff_len, struct xhci_segment *seg)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int unalign;
 	unsigned int max_pkt;
 	u32 new_buff_len;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..5df370482521 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -514,7 +514,7 @@ struct xhci_intr_reg {
 #define	ERST_SIZE_MASK		(0xffff << 16)
 
 /* erst_base bitmasks */
-#define ERST_BASE_RSVDP		(0x3f)
+#define ERST_BASE_RSVDP		(GENMASK_ULL(5, 0))
 
 /* erst_dequeue bitmasks */
 /* Dequeue ERST Segment Index (DESI) - Segment number (or alias)
diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 83f14ca1d38e..36dd4971b780 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -409,6 +409,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2412) }, /* USB2412 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index aca5f50eb0da..f136dffb4a10 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -35,6 +35,7 @@ static const struct onboard_hub_pdata vialab_vl817_data = {
 };
 
 static const struct of_device_id onboard_hub_match[] = {
+	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2517", .data = &microchip_usb424_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 78c726a71b17..2d623284edf6 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -39,7 +39,7 @@ static const struct musb_register_map musb_regmap[] = {
 	{ "IntrUsbE",	MUSB_INTRUSBE,	8 },
 	{ "DevCtl",	MUSB_DEVCTL,	8 },
 	{ "VControl",	0x68,		32 },
-	{ "HWVers",	0x69,		16 },
+	{ "HWVers",	MUSB_HWVERS,	16 },
 	{ "LinkInfo",	MUSB_LINKINFO,	8 },
 	{ "VPLen",	MUSB_VPLEN,	8 },
 	{ "HS_EOF1",	MUSB_HS_EOF1,	8 },
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index a02c29216955..bc4507781167 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -321,10 +321,16 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
 
+	/*
+	 * musb->lock had been unlocked in musb_giveback, so qh may
+	 * be freed, need to get it again
+	 */
+	qh = musb_ep_get_qh(hw_ep, is_in);
+
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
 	 * invalidate qh as soon as list_empty(&hep->urb_list)
 	 */
-	if (list_empty(&qh->hep->urb_list)) {
+	if (qh && list_empty(&qh->hep->urb_list)) {
 		struct list_head	*head;
 		struct dma_controller	*dma = musb->dma_controller;
 
@@ -2398,6 +2404,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		 * and its URB list has emptied, recycle this qh.
 		 */
 		if (ready && list_empty(&qh->hep->urb_list)) {
+			musb_ep_set_qh(qh->hw_ep, is_in, NULL);
 			qh->hep->hcpriv = NULL;
 			list_del(&qh->ring);
 			kfree(qh);
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index cdf8261e22db..459e5eb1a789 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -304,6 +304,11 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 			typec_altmode_update_active(alt, false);
 			dp->data.status = 0;
 			dp->data.conf = 0;
+			if (dp->hpd) {
+				drm_connector_oob_hotplug_event(dp->connector_fwnode);
+				dp->hpd = false;
+				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
+			}
 			break;
 		case DP_CMD_STATUS_UPDATE:
 			dp->data.status = *vdo;
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index 4e1b846627d2..d29f9506e5f1 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -383,10 +383,6 @@ static int qcom_pmic_typec_pdphy_enable(struct pmic_typec_pdphy *pmic_typec_pdph
 	struct device *dev = pmic_typec_pdphy->dev;
 	int ret;
 
-	ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
-	if (ret)
-		return ret;
-
 	/* PD 2.0, DR=TYPEC_DEVICE, PR=TYPEC_SINK */
 	ret = regmap_update_bits(pmic_typec_pdphy->regmap,
 				 pmic_typec_pdphy->base + USB_PDPHY_MSG_CONFIG_REG,
@@ -424,8 +420,6 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
 	ret = regmap_write(pmic_typec_pdphy->regmap,
 			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
 
-	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
-
 	return ret;
 }
 
@@ -449,6 +443,10 @@ int qcom_pmic_typec_pdphy_start(struct pmic_typec_pdphy *pmic_typec_pdphy,
 	int i;
 	int ret;
 
+	ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
+	if (ret)
+		return ret;
+
 	pmic_typec_pdphy->tcpm_port = tcpm_port;
 
 	ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
@@ -469,6 +467,8 @@ void qcom_pmic_typec_pdphy_stop(struct pmic_typec_pdphy *pmic_typec_pdphy)
 		disable_irq(pmic_typec_pdphy->irq_data[i].irq);
 
 	qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
+
+	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
 }
 
 struct pmic_typec_pdphy *qcom_pmic_typec_pdphy_alloc(struct device *dev)
diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 384b42267f1f..b35c6e07911e 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -37,6 +37,15 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
 	struct device *dev = con->ucsi->dev;
 
 	device_property_read_u8(dev, "scope", &scope);
+	if (scope == POWER_SUPPLY_SCOPE_UNKNOWN) {
+		u32 mask = UCSI_CAP_ATTR_POWER_AC_SUPPLY |
+			   UCSI_CAP_ATTR_BATTERY_CHARGING;
+
+		if (con->ucsi->cap.attributes & mask)
+			scope = POWER_SUPPLY_SCOPE_SYSTEM;
+		else
+			scope = POWER_SUPPLY_SCOPE_DEVICE;
+	}
 	val->intval = scope;
 	return 0;
 }
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index f6901319639d..30675948d8d9 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -787,6 +787,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 
 	typec_set_mode(con->port, TYPEC_STATE_SAFE);
 
+	typec_partner_set_usb_power_delivery(con->partner, NULL);
 	ucsi_unregister_partner_pdos(con);
 	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
 	typec_unregister_partner(con->partner);
@@ -884,6 +885,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (ret < 0) {
 		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
 			__func__, ret);
+		clear_bit(EVENT_PENDING, &con->ucsi->flags);
 		goto out_unlock;
 	}
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 63efe5389783..aeac54eba299 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2559,7 +2559,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		ret = do_splice_direct(src_file, &src_off, dst_file,
 				       &dst_off, src_objlen, flags);
 		/* Abort on short copies or on error */
-		if (ret < src_objlen) {
+		if (ret < (long)src_objlen) {
 			dout("Failed partial copy (%zd)\n", ret);
 			goto out;
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8e5f41d45283..29fa35347b88 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -655,9 +655,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 			ci->i_truncate_seq = truncate_seq;
 
 			/* the MDS should have revoked these caps */
-			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_EXCL |
-					       CEPH_CAP_FILE_RD |
-					       CEPH_CAP_FILE_WR |
+			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_RD |
 					       CEPH_CAP_FILE_LAZYIO));
 			/*
 			 * If we hold relevant caps, or in the case where we're
diff --git a/fs/file.c b/fs/file.c
index 3fd003a8604f..568a98178007 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -668,7 +668,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
 
 /**
  * last_fd - return last valid index into fd table
- * @cur_fds: files struct
+ * @fdt: File descriptor table.
  *
  * Context: Either rcu read lock or files_lock must be held.
  *
@@ -723,6 +723,7 @@ static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
  *
  * @fd:     starting file descriptor to close
  * @max_fd: last file descriptor to close
+ * @flags:  CLOSE_RANGE flags.
  *
  * This closes a range of file descriptors. All file descriptors
  * from @fd up to and including @max_fd are closed.
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 375023e40161..896e89acac5c 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -162,6 +162,10 @@ EXPORT_SYMBOL(vfs_parse_fs_param);
 
 /**
  * vfs_parse_fs_string - Convenience function to just parse a string.
+ * @fc: Filesystem context.
+ * @key: Parameter name.
+ * @value: Default value.
+ * @v_size: Maximum number of bytes in the value.
  */
 int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			const char *value, size_t v_size)
@@ -188,17 +192,19 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 EXPORT_SYMBOL(vfs_parse_fs_string);
 
 /**
- * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
- * @ctx: The superblock configuration to fill in.
+ * vfs_parse_monolithic_sep - Parse key[=val][,key[=val]]* mount data
+ * @fc: The superblock configuration to fill in.
  * @data: The data to parse
+ * @sep: callback for separating next option
  *
- * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
- * called from the ->monolithic_mount_data() fs_context operation.
+ * Parse a blob of data that's in key[=val][,key[=val]]* form with a custom
+ * option separator callback.
  *
  * Returns 0 on success or the error returned by the ->parse_option() fs_context
  * operation on failure.
  */
-int generic_parse_monolithic(struct fs_context *fc, void *data)
+int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
+			     char *(*sep)(char **))
 {
 	char *options = data, *key;
 	int ret = 0;
@@ -210,7 +216,7 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 	if (ret)
 		return ret;
 
-	while ((key = strsep(&options, ",")) != NULL) {
+	while ((key = sep(&options)) != NULL) {
 		if (*key) {
 			size_t v_len = 0;
 			char *value = strchr(key, '=');
@@ -229,6 +235,28 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 
 	return ret;
 }
+EXPORT_SYMBOL(vfs_parse_monolithic_sep);
+
+static char *vfs_parse_comma_sep(char **s)
+{
+	return strsep(s, ",");
+}
+
+/**
+ * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
+ * @fc: The superblock configuration to fill in.
+ * @data: The data to parse
+ *
+ * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
+ * called from the ->monolithic_mount_data() fs_context operation.
+ *
+ * Returns 0 on success or the error returned by the ->parse_option() fs_context
+ * operation on failure.
+ */
+int generic_parse_monolithic(struct fs_context *fc, void *data)
+{
+	return vfs_parse_monolithic_sep(fc, data, vfs_parse_comma_sep);
+}
 EXPORT_SYMBOL(generic_parse_monolithic);
 
 /**
@@ -354,7 +382,7 @@ void fc_drop_locked(struct fs_context *fc)
 static void legacy_fs_context_free(struct fs_context *fc);
 
 /**
- * vfs_dup_fc_config: Duplicate a filesystem context.
+ * vfs_dup_fs_context - Duplicate a filesystem context.
  * @src_fc: The context to copy.
  */
 struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
@@ -400,7 +428,9 @@ EXPORT_SYMBOL(vfs_dup_fs_context);
 
 /**
  * logfc - Log a message to a filesystem context
- * @fc: The filesystem context to log to.
+ * @log: The filesystem context to log to, or NULL to use printk.
+ * @prefix: A string to prefix the output with, or NULL.
+ * @level: 'w' for a warning, 'e' for an error.  Anything else is a notice.
  * @fmt: The format of the buffer.
  */
 void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...)
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 5b2481cd4750..d413e0b8f6c2 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -109,9 +109,6 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
  * Returns 0 on success, -errno on error, 1 if this was the last
  * extent that will fit in user array.
  */
-#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
-#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
-#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
 int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 			    u64 phys, u64 len, u32 flags)
 {
@@ -127,6 +124,10 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
 		return 1;
 
+#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
+#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
+#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
+
 	if (flags & SET_UNKNOWN_FLAGS)
 		flags |= FIEMAP_EXTENT_UNKNOWN;
 	if (flags & SET_NO_UNMOUNTED_IO_FLAGS)
@@ -877,6 +878,9 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 #ifdef CONFIG_COMPAT
 /**
  * compat_ptr_ioctl - generic implementation of .compat_ioctl file operation
+ * @file: The file to operate on.
+ * @cmd: The ioctl command number.
+ * @arg: The argument to the ioctl.
  *
  * This is not normally called as a function, but instead set in struct
  * file_operations as
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 5d826274570c..c429c42a6867 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -8,16 +8,16 @@
 /**
  * kernel_read_file() - read file contents into a kernel buffer
  *
- * @file	file to read from
- * @offset	where to start reading from (see below).
- * @buf		pointer to a "void *" buffer for reading into (if
+ * @file:	file to read from
+ * @offset:	where to start reading from (see below).
+ * @buf:	pointer to a "void *" buffer for reading into (if
  *		*@buf is NULL, a buffer will be allocated, and
  *		@buf_size will be ignored)
- * @buf_size	size of buf, if already allocated. If @buf not
+ * @buf_size:	size of buf, if already allocated. If @buf not
  *		allocated, this is the largest size to allocate.
- * @file_size	if non-NULL, the full size of @file will be
+ * @file_size:	if non-NULL, the full size of @file will be
  *		written here.
- * @id		the kernel_read_file_id identifying the type of
+ * @id:		the kernel_read_file_id identifying the type of
  *		file contents being read (for LSMs to examine)
  *
  * @offset must be 0 unless both @buf and @file_size are non-NULL
diff --git a/fs/namei.c b/fs/namei.c
index 2bae29ea52ff..567ee547492b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -643,6 +643,8 @@ static bool nd_alloc_stack(struct nameidata *nd)
 
 /**
  * path_connected - Verify that a dentry is below mnt.mnt_root
+ * @mnt: The mountpoint to check.
+ * @dentry: The dentry to check.
  *
  * Rename can sometimes move a file or directory outside of a bind
  * mount, path_connected allows those cases to be detected.
@@ -1083,6 +1085,7 @@ fs_initcall(init_fs_namei_sysctls);
 /**
  * may_follow_link - Check symlink following for unsafe situations
  * @nd: nameidata pathwalk data
+ * @inode: Used for idmapping.
  *
  * In the case of the sysctl_protected_symlinks sysctl being enabled,
  * CAP_DAC_OVERRIDE needs to be specifically ignored if the symlink is
diff --git a/fs/open.c b/fs/open.c
index e6ead0f19964..7c9647a8f219 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1150,7 +1150,7 @@ EXPORT_SYMBOL_GPL(kernel_file_open);
  * backing_file_open - open a backing file for kernel internal use
  * @path:	path of the file to open
  * @flags:	open flags
- * @path:	path of the backing file
+ * @real_path:	path of the backing file
  * @cred:	credentials for open
  *
  * Open a backing file for a stackable filesystem (e.g., overlayfs).
@@ -1546,7 +1546,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 }
 
 /**
- * close_range() - Close all file descriptors in a given range.
+ * sys_close_range() - Close all file descriptors in a given range.
  *
  * @fd:     starting file descriptor to close
  * @max_fd: last file descriptor to close
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 306e1ecdc96d..2b703521871e 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -8,6 +8,7 @@
 struct ovl_config {
 	char *upperdir;
 	char *workdir;
+	char **lowerdirs;
 	bool default_permissions;
 	int redirect_mode;
 	bool index;
@@ -38,17 +39,8 @@ struct ovl_layer {
 	int idx;
 	/* One fsid per unique underlying sb (upper fsid == 0) */
 	int fsid;
-	char *name;
 };
 
-/*
- * ovl_free_fs() relies on @mnt being the first member when unmounting
- * the private mounts created for each layer. Let's check both the
- * offset and type.
- */
-static_assert(offsetof(struct ovl_layer, mnt) == 0);
-static_assert(__same_type(typeof_member(struct ovl_layer, mnt), struct vfsmount *));
-
 struct ovl_path {
 	const struct ovl_layer *layer;
 	struct dentry *dentry;
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index a63160dbb0f9..644badb13fe0 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -120,6 +120,34 @@ const struct fs_parameter_spec ovl_parameter_spec[] = {
 	{}
 };
 
+static char *ovl_next_opt(char **s)
+{
+	char *sbegin = *s;
+	char *p;
+
+	if (sbegin == NULL)
+		return NULL;
+
+	for (p = sbegin; *p; p++) {
+		if (*p == '\\') {
+			p++;
+			if (!*p)
+				break;
+		} else if (*p == ',') {
+			*p = '\0';
+			*s = p + 1;
+			return sbegin;
+		}
+	}
+	*s = NULL;
+	return sbegin;
+}
+
+static int ovl_parse_monolithic(struct fs_context *fc, void *data)
+{
+	return vfs_parse_monolithic_sep(fc, data, ovl_next_opt);
+}
+
 static ssize_t ovl_parse_param_split_lowerdirs(char *str)
 {
 	ssize_t nr_layers = 1, nr_colons = 0;
@@ -127,7 +155,8 @@ static ssize_t ovl_parse_param_split_lowerdirs(char *str)
 
 	for (s = d = str;; s++, d++) {
 		if (*s == '\\') {
-			s++;
+			/* keep esc chars in split lowerdir */
+			*d++ = *s++;
 		} else if (*s == ':') {
 			bool next_colon = (*(s + 1) == ':');
 
@@ -202,7 +231,7 @@ static void ovl_unescape(char *s)
 	}
 }
 
-static int ovl_mount_dir(const char *name, struct path *path)
+static int ovl_mount_dir(const char *name, struct path *path, bool upper)
 {
 	int err = -ENOMEM;
 	char *tmp = kstrdup(name, GFP_KERNEL);
@@ -211,7 +240,7 @@ static int ovl_mount_dir(const char *name, struct path *path)
 		ovl_unescape(tmp);
 		err = ovl_mount_dir_noesc(tmp, path);
 
-		if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
+		if (!err && upper && path->dentry->d_flags & DCACHE_OP_REAL) {
 			pr_err("filesystem on '%s' not supported as upperdir\n",
 			       tmp);
 			path_put_init(path);
@@ -232,7 +261,7 @@ static int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
 	struct path path;
 	char *dup;
 
-	err = ovl_mount_dir(name, &path);
+	err = ovl_mount_dir(name, &path, true);
 	if (err)
 		return err;
 
@@ -284,12 +313,6 @@ static void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
  *     Set "/lower1", "/lower2", and "/lower3" as lower layers and
  *     "/data1" and "/data2" as data lower layers. Any existing lower
  *     layers are replaced.
- * (2) lowerdir=:/lower4
- *     Append "/lower4" to current stack of lower layers. This requires
- *     that there already is at least one lower layer configured.
- * (3) lowerdir=::/lower5
- *     Append data "/lower5" as data lower layer. This requires that
- *     there's at least one regular lower layer present.
  */
 static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 {
@@ -311,49 +334,9 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 		return 0;
 	}
 
-	if (strncmp(name, "::", 2) == 0) {
-		/*
-		 * This is a data layer.
-		 * There must be at least one regular lower layer
-		 * specified.
-		 */
-		if (ctx->nr == 0) {
-			pr_err("data lower layers without regular lower layers not allowed");
-			return -EINVAL;
-		}
-
-		/* Skip the leading "::". */
-		name += 2;
-		data_layer = true;
-		/*
-		 * A data layer is automatically an append as there
-		 * must've been at least one regular lower layer.
-		 */
-		append = true;
-	} else if (*name == ':') {
-		/*
-		 * This is a regular lower layer.
-		 * If users want to append a layer enforce that they
-		 * have already specified a first layer before. It's
-		 * better to be strict.
-		 */
-		if (ctx->nr == 0) {
-			pr_err("cannot append layer if no previous layer has been specified");
-			return -EINVAL;
-		}
-
-		/*
-		 * Once a sequence of data layers has started regular
-		 * lower layers are forbidden.
-		 */
-		if (ctx->nr_data > 0) {
-			pr_err("regular lower layers cannot follow data lower layers");
-			return -EINVAL;
-		}
-
-		/* Skip the leading ":". */
-		name++;
-		append = true;
+	if (*name == ':') {
+		pr_err("cannot append lower layer");
+		return -EINVAL;
 	}
 
 	dup = kstrdup(name, GFP_KERNEL);
@@ -435,7 +418,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 		l = &ctx->lower[nr];
 		memset(l, 0, sizeof(*l));
 
-		err = ovl_mount_dir_noesc(dup_iter, &l->path);
+		err = ovl_mount_dir(dup_iter, &l->path, false);
 		if (err)
 			goto out_put;
 
@@ -642,6 +625,7 @@ static int ovl_reconfigure(struct fs_context *fc)
 }
 
 static const struct fs_context_operations ovl_context_ops = {
+	.parse_monolithic = ovl_parse_monolithic,
 	.parse_param = ovl_parse_param,
 	.get_tree    = ovl_get_tree,
 	.reconfigure = ovl_reconfigure,
@@ -712,12 +696,12 @@ void ovl_free_fs(struct ovl_fs *ofs)
 	if (ofs->upperdir_locked)
 		ovl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
 
-	/* Hack!  Reuse ofs->layers as a vfsmount array before freeing it */
-	mounts = (struct vfsmount **) ofs->layers;
+	/* Reuse ofs->config.lowerdirs as a vfsmount array before freeing it */
+	mounts = (struct vfsmount **) ofs->config.lowerdirs;
 	for (i = 0; i < ofs->numlayer; i++) {
 		iput(ofs->layers[i].trap);
+		kfree(ofs->config.lowerdirs[i]);
 		mounts[i] = ofs->layers[i].mnt;
-		kfree(ofs->layers[i].name);
 	}
 	kern_unmount_array(mounts, ofs->numlayer);
 	kfree(ofs->layers);
@@ -725,6 +709,7 @@ void ovl_free_fs(struct ovl_fs *ofs)
 		free_anon_bdev(ofs->fs[i].pseudo_dev);
 	kfree(ofs->fs);
 
+	kfree(ofs->config.lowerdirs);
 	kfree(ofs->config.upperdir);
 	kfree(ofs->config.workdir);
 	if (ofs->creator_cred)
@@ -874,16 +859,23 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	struct super_block *sb = dentry->d_sb;
 	struct ovl_fs *ofs = sb->s_fs_info;
 	size_t nr, nr_merged_lower = ofs->numlayer - ofs->numdatalayer;
-	const struct ovl_layer *data_layers = &ofs->layers[nr_merged_lower];
-
-	/* ofs->layers[0] is the upper layer */
-	seq_printf(m, ",lowerdir=%s", ofs->layers[1].name);
-	/* dump regular lower layers */
-	for (nr = 2; nr < nr_merged_lower; nr++)
-		seq_printf(m, ":%s", ofs->layers[nr].name);
-	/* dump data lower layers */
-	for (nr = 0; nr < ofs->numdatalayer; nr++)
-		seq_printf(m, "::%s", data_layers[nr].name);
+
+	/*
+	 * lowerdirs[] starts from offset 1, then
+	 * >= 0 regular lower layers prefixed with : and
+	 * >= 0 data-only lower layers prefixed with ::
+	 *
+	 * we need to escase comma and space like seq_show_option() does and
+	 * we also need to escape the colon separator from lowerdir paths.
+	 */
+	seq_puts(m, ",lowerdir=");
+	for (nr = 1; nr < ofs->numlayer; nr++) {
+		if (nr > 1)
+			seq_putc(m, ':');
+		if (nr >= nr_merged_lower)
+			seq_putc(m, ':');
+		seq_escape(m, ofs->config.lowerdirs[nr], ":, \t\n\\");
+	}
 	if (ofs->config.upperdir) {
 		seq_show_option(m, "upperdir", ofs->config.upperdir);
 		seq_show_option(m, "workdir", ofs->config.workdir);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 1090c68e5b05..80a70eaa30d9 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -565,11 +565,6 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 	upper_layer->idx = 0;
 	upper_layer->fsid = 0;
 
-	err = -ENOMEM;
-	upper_layer->name = kstrdup(ofs->config.upperdir, GFP_KERNEL);
-	if (!upper_layer->name)
-		goto out;
-
 	/*
 	 * Inherit SB_NOSEC flag from upperdir.
 	 *
@@ -1113,7 +1108,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		layers[ofs->numlayer].idx = ofs->numlayer;
 		layers[ofs->numlayer].fsid = fsid;
 		layers[ofs->numlayer].fs = &ofs->fs[fsid];
-		layers[ofs->numlayer].name = l->name;
+		/* Store for printing lowerdir=... in ovl_show_options() */
+		ofs->config.lowerdirs[ofs->numlayer] = l->name;
 		l->name = NULL;
 		ofs->numlayer++;
 		ofs->fs[fsid].is_lower = true;
@@ -1358,8 +1354,16 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!layers)
 		goto out_err;
 
+	ofs->config.lowerdirs = kcalloc(ctx->nr + 1, sizeof(char *), GFP_KERNEL);
+	if (!ofs->config.lowerdirs) {
+		kfree(layers);
+		goto out_err;
+	}
 	ofs->layers = layers;
-	/* Layer 0 is reserved for upper even if there's no upper */
+	/*
+	 * Layer 0 is reserved for upper even if there's no upper.
+	 * For consistency, config.lowerdirs[0] is NULL.
+	 */
 	ofs->numlayer = 1;
 
 	sb->s_stack_depth = 0;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index c7afe433d991..bfa423ae16e3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -233,19 +233,18 @@ static void put_quota_format(struct quota_format_type *fmt)
  * All dquots are placed to the end of inuse_list when first created, and this
  * list is used for invalidate operation, which must look at every dquot.
  *
- * When the last reference of a dquot will be dropped, the dquot will be
- * added to releasing_dquots. We'd then queue work item which would call
+ * When the last reference of a dquot is dropped, the dquot is added to
+ * releasing_dquots. We'll then queue work item which will call
  * synchronize_srcu() and after that perform the final cleanup of all the
- * dquots on the list. Both releasing_dquots and free_dquots use the
- * dq_free list_head in the dquot struct. When a dquot is removed from
- * releasing_dquots, a reference count is always subtracted, and if
- * dq_count == 0 at that point, the dquot will be added to the free_dquots.
+ * dquots on the list. Each cleaned up dquot is moved to free_dquots list.
+ * Both releasing_dquots and free_dquots use the dq_free list_head in the dquot
+ * struct.
  *
- * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
- * and this list is searched whenever we need an available dquot.  Dquots are
- * removed from the list as soon as they are used again, and
- * dqstats.free_dquots gives the number of dquots on the list. When
- * dquot is invalidated it's completely released from memory.
+ * Unused and cleaned up dquots are in the free_dquots list and this list is
+ * searched whenever we need an available dquot. Dquots are removed from the
+ * list as soon as they are used again and dqstats.free_dquots gives the number
+ * of dquots on the list. When dquot is invalidated it's completely released
+ * from memory.
  *
  * Dirty dquots are added to the dqi_dirty_list of quota_info when mark
  * dirtied, and this list is searched when writing dirty dquots back to
@@ -321,6 +320,7 @@ static inline void put_dquot_last(struct dquot *dquot)
 static inline void put_releasing_dquots(struct dquot *dquot)
 {
 	list_add_tail(&dquot->dq_free, &releasing_dquots);
+	set_bit(DQ_RELEASING_B, &dquot->dq_flags);
 }
 
 static inline void remove_free_dquot(struct dquot *dquot)
@@ -328,8 +328,10 @@ static inline void remove_free_dquot(struct dquot *dquot)
 	if (list_empty(&dquot->dq_free))
 		return;
 	list_del_init(&dquot->dq_free);
-	if (!atomic_read(&dquot->dq_count))
+	if (!test_bit(DQ_RELEASING_B, &dquot->dq_flags))
 		dqstats_dec(DQST_FREE_DQUOTS);
+	else
+		clear_bit(DQ_RELEASING_B, &dquot->dq_flags);
 }
 
 static inline void put_inuse(struct dquot *dquot)
@@ -581,12 +583,6 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			/* dquot in releasing_dquots, flush and retry */
-			if (!list_empty(&dquot->dq_free)) {
-				spin_unlock(&dq_list_lock);
-				goto restart;
-			}
-
 			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
@@ -605,6 +601,15 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			 * restart. */
 			goto restart;
 		}
+		/*
+		 * The last user already dropped its reference but dquot didn't
+		 * get fully cleaned up yet. Restart the scan which flushes the
+		 * work cleaning up released dquots.
+		 */
+		if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
+			spin_unlock(&dq_list_lock);
+			goto restart;
+		}
 		/*
 		 * Quota now has no users and it has been written on last
 		 * dqput()
@@ -696,6 +701,13 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 						 dq_dirty);
 
 			WARN_ON(!dquot_active(dquot));
+			/* If the dquot is releasing we should not touch it */
+			if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
+				spin_unlock(&dq_list_lock);
+				flush_delayed_work(&quota_release_work);
+				spin_lock(&dq_list_lock);
+				continue;
+			}
 
 			/* Now we have active dquot from which someone is
  			 * holding reference so we can safely just increase
@@ -809,18 +821,18 @@ static void quota_release_workfn(struct work_struct *work)
 	/* Exchange the list head to avoid livelock. */
 	list_replace_init(&releasing_dquots, &rls_head);
 	spin_unlock(&dq_list_lock);
+	synchronize_srcu(&dquot_srcu);
 
 restart:
-	synchronize_srcu(&dquot_srcu);
 	spin_lock(&dq_list_lock);
 	while (!list_empty(&rls_head)) {
 		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
-		/* Dquot got used again? */
-		if (atomic_read(&dquot->dq_count) > 1) {
-			remove_free_dquot(dquot);
-			atomic_dec(&dquot->dq_count);
-			continue;
-		}
+		WARN_ON_ONCE(atomic_read(&dquot->dq_count));
+		/*
+		 * Note that DQ_RELEASING_B protects us from racing with
+		 * invalidate_dquots() calls so we are safe to work with the
+		 * dquot even after we drop dq_list_lock.
+		 */
 		if (dquot_dirty(dquot)) {
 			spin_unlock(&dq_list_lock);
 			/* Commit dquot before releasing */
@@ -834,7 +846,6 @@ static void quota_release_workfn(struct work_struct *work)
 		}
 		/* Dquot is inactive and clean, now move it to free list */
 		remove_free_dquot(dquot);
-		atomic_dec(&dquot->dq_count);
 		put_dquot_last(dquot);
 	}
 	spin_unlock(&dq_list_lock);
@@ -875,6 +886,7 @@ void dqput(struct dquot *dquot)
 	BUG_ON(!list_empty(&dquot->dq_free));
 #endif
 	put_releasing_dquots(dquot);
+	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
 	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
 }
@@ -963,7 +975,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 		dqstats_inc(DQST_LOOKUPS);
 	}
 	/* Wait for dq_lock - after this we know that either dquot_release() is
-	 * already finished or it will be canceled due to dq_count > 1 test */
+	 * already finished or it will be canceled due to dq_count > 0 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot / allocate space in quota file */
 	if (!dquot_active(dquot)) {
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index f41f8d6108ce..85bd6213e98c 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -106,7 +106,7 @@ int ksmbd_query_inode_status(struct inode *inode)
 	ci = __ksmbd_inode_lookup(inode);
 	if (ci) {
 		ret = KSMBD_INODE_STATUS_OK;
-		if (ci->m_flags & S_DEL_PENDING)
+		if (ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS))
 			ret = KSMBD_INODE_STATUS_PENDING_DELETE;
 		atomic_dec(&ci->m_count);
 	}
@@ -116,7 +116,7 @@ int ksmbd_query_inode_status(struct inode *inode)
 
 bool ksmbd_inode_pending_delete(struct ksmbd_file *fp)
 {
-	return (fp->f_ci->m_flags & S_DEL_PENDING);
+	return (fp->f_ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS));
 }
 
 void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 641dc4843987..42c22a6ff48d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1476,6 +1476,15 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+#ifdef CONFIG_ACPI_PROCESSOR_IDLE
+#ifndef arch_get_idle_state_flags
+static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
+{
+	return 0;
+}
+#endif
+#endif /* CONFIG_ACPI_PROCESSOR_IDLE */
+
 #ifdef CONFIG_ACPI_PPTT
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 0d678e9a7b24..ebe78bd3d121 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -568,6 +568,25 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
 	fence->error = error;
 }
 
+/**
+ * dma_fence_timestamp - helper to get the completion timestamp of a fence
+ * @fence: fence to get the timestamp from.
+ *
+ * After a fence is signaled the timestamp is updated with the signaling time,
+ * but setting the timestamp can race with tasks waiting for the signaling. This
+ * helper busy waits for the correct timestamp to appear.
+ */
+static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
+{
+	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
+		return ktime_get();
+
+	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
+		cpu_relax();
+
+	return fence->timestamp;
+}
+
 signed long dma_fence_wait_timeout(struct dma_fence *,
 				   bool intr, signed long timeout);
 signed long dma_fence_wait_any_timeout(struct dma_fence **fences,
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index ff6341e09925..ae556dc8e18f 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -135,6 +135,8 @@ extern struct fs_context *vfs_dup_fs_context(struct fs_context *fc);
 extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			       const char *value, size_t v_size);
+int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
+			     char *(*sep)(char **));
 extern int generic_parse_monolithic(struct fs_context *fc, void *data);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 19ddc6c80400..747de50b6858 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -192,6 +192,7 @@ enum {
 	ATA_PFLAG_UNLOADING	= (1 << 9), /* driver is being unloaded */
 	ATA_PFLAG_UNLOADED	= (1 << 10), /* driver is unloaded */
 
+	ATA_PFLAG_RESUMING	= (1 << 16),  /* port is being resumed */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_INIT_GTM_VALID = (1 << 19), /* initial gtm data valid */
@@ -318,9 +319,10 @@ enum {
 	ATA_EH_ENABLE_LINK	= (1 << 3),
 	ATA_EH_PARK		= (1 << 5), /* unload heads and stop I/O */
 	ATA_EH_GET_SUCCESS_SENSE = (1 << 6), /* Get sense data for successful cmd */
+	ATA_EH_SET_ACTIVE	= (1 << 7), /* Set a device to active power mode */
 
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_PARK |
-				  ATA_EH_GET_SUCCESS_SENSE,
+				  ATA_EH_GET_SUCCESS_SENSE | ATA_EH_SET_ACTIVE,
 	ATA_EH_ALL_ACTIONS	= ATA_EH_REVALIDATE | ATA_EH_RESET |
 				  ATA_EH_ENABLE_LINK,
 
@@ -358,7 +360,7 @@ enum {
 	/* This should match the actual table size of
 	 * ata_eh_cmd_timeout_table in libata-eh.c.
 	 */
-	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 7,
+	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
 
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependent */
diff --git a/include/linux/mcb.h b/include/linux/mcb.h
index 1e5893138afe..0b971b24a804 100644
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -63,7 +63,6 @@ static inline struct mcb_bus *to_mcb_bus(struct device *dev)
 struct mcb_device {
 	struct device dev;
 	struct mcb_bus *bus;
-	bool is_added;
 	struct mcb_driver *driver;
 	u16 id;
 	int inst;
diff --git a/include/linux/quota.h b/include/linux/quota.h
index fd692b4a41d5..07071e64abf3 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -285,7 +285,9 @@ static inline void dqstats_dec(unsigned int type)
 #define DQ_FAKE_B	3	/* no limits only usage */
 #define DQ_READ_B	4	/* dquot was read into memory */
 #define DQ_ACTIVE_B	5	/* dquot is active (dquot_release not called) */
-#define DQ_LASTSET_B	6	/* Following 6 bits (see QIF_) are reserved\
+#define DQ_RELEASING_B	6	/* dquot is in releasing_dquots list waiting
+				 * to be cleaned up */
+#define DQ_LASTSET_B	7	/* Following 6 bits (see QIF_) are reserved\
 				 * for the mask of entries set via SETQUOTA\
 				 * quotactl. They are set under dq_data_lock\
 				 * and the quota format handling dquot can\
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 11a4becff3a9..4fa4ef0a173a 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -57,7 +57,7 @@ static inline bool dquot_is_busy(struct dquot *dquot)
 {
 	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
 		return true;
-	if (atomic_read(&dquot->dq_count) > 1)
+	if (atomic_read(&dquot->dq_count) > 0)
 		return true;
 	return false;
 }
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 441ed8fd4b5f..41c1884a3e41 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -258,6 +258,7 @@ struct macsec_context {
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
+		bool update_pn;
 		unsigned char assoc_num;
 		u8 key[MACSEC_MAX_KEY_LEN];
 		union {
diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
index 4d0ad22f83b5..9efc42382fdb 100644
--- a/include/uapi/linux/if_packet.h
+++ b/include/uapi/linux/if_packet.h
@@ -18,11 +18,7 @@ struct sockaddr_ll {
 	unsigned short	sll_hatype;
 	unsigned char	sll_pkttype;
 	unsigned char	sll_halen;
-	union {
-		unsigned char	sll_addr[8];
-		/* Actual length is in sll_halen. */
-		__DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
-	};
+	unsigned char	sll_addr[8];
 };
 
 /* Packet types */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93fd32f2957b..104681258d24 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14255,7 +14255,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	struct tnum enforce_attach_type_range = tnum_unknown;
 	const struct bpf_prog *prog = env->prog;
 	struct bpf_reg_state *reg;
-	struct tnum range = tnum_range(0, 1);
+	struct tnum range = tnum_range(0, 1), const_0 = tnum_const(0);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	int err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
@@ -14303,8 +14303,8 @@ static int check_return_code(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (!tnum_in(tnum_const(0), reg->var_off)) {
-			verbose_invalid_scalar(env, reg, &range, "async callback", "R0");
+		if (!tnum_in(const_0, reg->var_off)) {
+			verbose_invalid_scalar(env, reg, &const_0, "async callback", "R0");
 			return -EINVAL;
 		}
 		return 0;
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 83044312bc41..0a10aba49aa4 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -360,10 +360,9 @@ static int pidlist_array_load(struct cgroup *cgrp, enum cgroup_filetype type,
 	}
 	css_task_iter_end(&it);
 	length = n;
-	/* now sort & (if procs) strip out duplicates */
+	/* now sort & strip out duplicates (tgids or recycled thread PIDs) */
 	sort(array, length, sizeof(pid_t), cmppid, NULL);
-	if (type == CGROUP_FILE_PROCS)
-		length = pidlist_uniq(array, length);
+	length = pidlist_uniq(array, length);
 
 	l = cgroup_pidlist_find_create(cgrp, type);
 	if (!l) {
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e51ab3d4765e..e4a37d7a6752 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5741,9 +5741,13 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	list_for_each_entry(wq, &workqueues, list) {
 		if (!(wq->flags & WQ_UNBOUND))
 			continue;
+
 		/* creating multiple pwqs breaks ordering guarantee */
-		if (wq->flags & __WQ_ORDERED)
-			continue;
+		if (!list_empty(&wq->pwqs)) {
+			if (wq->flags & __WQ_ORDERED_EXPLICIT)
+				continue;
+			wq->flags &= ~__WQ_ORDERED;
+		}
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
 		if (!ctx) {
diff --git a/net/can/isotp.c b/net/can/isotp.c
index f02b5d3e4733..d1c6f206f429 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -948,21 +948,18 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-wait_free_buffer:
-	/* we do not support multiple buffers - for now */
-	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
-		return -EAGAIN;
+	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+		/* we do not support multiple buffers - for now */
+		if (msg->msg_flags & MSG_DONTWAIT)
+			return -EAGAIN;
 
-	/* wait for complete transmission of current pdu */
-	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
-	if (err)
-		goto err_event_drop;
-
-	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
 		if (so->tx.state == ISOTP_SHUTDOWN)
 			return -EADDRNOTAVAIL;
 
-		goto wait_free_buffer;
+		/* wait for complete transmission of current pdu */
+		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		if (err)
+			goto err_event_drop;
 	}
 
 	/* PDU size > default => try max_pdu_size */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5eb4898cccd4..04a0f35f9407 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -459,8 +459,8 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	set_sock_callbacks(sock, con);
 
 	con_sock_state_connecting(con);
-	ret = sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof(ss),
-				 O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
 		     ceph_pr_addr(&con->peer_addr),
diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c..968be1c20ca1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3285,15 +3285,19 @@ int skb_checksum_help(struct sk_buff *skb)
 
 	offset = skb_checksum_start_offset(skb);
 	ret = -EINVAL;
-	if (WARN_ON_ONCE(offset >= skb_headlen(skb))) {
+	if (unlikely(offset >= skb_headlen(skb))) {
 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
+		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",
+			  offset, skb_headlen(skb));
 		goto out;
 	}
 	csum = skb_checksum(skb, offset, skb->len - offset, 0);
 
 	offset += skb->csum_offset;
-	if (WARN_ON_ONCE(offset + sizeof(__sum16) > skb_headlen(skb))) {
+	if (unlikely(offset + sizeof(__sum16) > skb_headlen(skb))) {
 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
+		WARN_ONCE(true, "offset+2 (%zu) > skb_headlen() (%u)\n",
+			  offset + sizeof(__sum16), skb_headlen(skb));
 		goto out;
 	}
 	ret = skb_ensure_writable(skb, offset + sizeof(__sum16));
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 194340a8bb86..8c6a2e5140d4 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -58,7 +58,6 @@ struct devlink_health_reporter {
 	struct devlink *devlink;
 	struct devlink_port *devlink_port;
 	struct devlink_fmsg *dump_fmsg;
-	struct mutex dump_lock; /* lock parallel read/write from dump buffers */
 	u64 graceful_period;
 	bool auto_recover;
 	bool auto_dump;
@@ -125,7 +124,6 @@ __devlink_health_reporter_create(struct devlink *devlink,
 	reporter->graceful_period = graceful_period;
 	reporter->auto_recover = !!ops->recover;
 	reporter->auto_dump = !!ops->dump;
-	mutex_init(&reporter->dump_lock);
 	return reporter;
 }
 
@@ -226,7 +224,6 @@ EXPORT_SYMBOL_GPL(devlink_health_reporter_create);
 static void
 devlink_health_reporter_free(struct devlink_health_reporter *reporter)
 {
-	mutex_destroy(&reporter->dump_lock);
 	if (reporter->dump_fmsg)
 		devlink_fmsg_free(reporter->dump_fmsg);
 	kfree(reporter);
@@ -609,10 +606,10 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	}
 
 	if (reporter->auto_dump) {
-		mutex_lock(&reporter->dump_lock);
+		devl_lock(devlink);
 		/* store current dump of current error, for later analysis */
 		devlink_health_do_dump(reporter, priv_ctx, NULL);
-		mutex_unlock(&reporter->dump_lock);
+		devl_unlock(devlink);
 	}
 
 	if (!reporter->auto_recover)
@@ -1246,7 +1243,7 @@ int devlink_nl_cmd_health_reporter_diagnose_doit(struct sk_buff *skb,
 }
 
 static struct devlink_health_reporter *
-devlink_health_reporter_get_from_cb(struct netlink_callback *cb)
+devlink_health_reporter_get_from_cb_lock(struct netlink_callback *cb)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct devlink_health_reporter *reporter;
@@ -1256,10 +1253,12 @@ devlink_health_reporter_get_from_cb(struct netlink_callback *cb)
 	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
 	if (IS_ERR(devlink))
 		return NULL;
-	devl_unlock(devlink);
 
 	reporter = devlink_health_reporter_get_from_attrs(devlink, attrs);
-	devlink_put(devlink);
+	if (!reporter) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
+	}
 	return reporter;
 }
 
@@ -1268,16 +1267,20 @@ int devlink_nl_cmd_health_reporter_dump_get_dumpit(struct sk_buff *skb,
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_health_reporter *reporter;
+	struct devlink *devlink;
 	int err;
 
-	reporter = devlink_health_reporter_get_from_cb(cb);
+	reporter = devlink_health_reporter_get_from_cb_lock(cb);
 	if (!reporter)
 		return -EINVAL;
 
-	if (!reporter->ops->dump)
+	devlink = reporter->devlink;
+	if (!reporter->ops->dump) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
 		return -EOPNOTSUPP;
+	}
 
-	mutex_lock(&reporter->dump_lock);
 	if (!state->idx) {
 		err = devlink_health_do_dump(reporter, NULL, cb->extack);
 		if (err)
@@ -1293,7 +1296,8 @@ int devlink_nl_cmd_health_reporter_dump_get_dumpit(struct sk_buff *skb,
 	err = devlink_fmsg_dumpit(reporter->dump_fmsg, skb, cb,
 				  DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET);
 unlock:
-	mutex_unlock(&reporter->dump_lock);
+	devl_unlock(devlink);
+	devlink_put(devlink);
 	return err;
 }
 
@@ -1310,9 +1314,7 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 	if (!reporter->ops->dump)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&reporter->dump_lock);
 	devlink_health_dump_clear(reporter);
-	mutex_unlock(&reporter->dump_lock);
 	return 0;
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 37fd9537423f..a8f58f5e99a7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2441,6 +2441,7 @@ static int tcp_mtu_probe(struct sock *sk)
 
 	/* build the payload, and be prepared to abort if this fails. */
 	if (tcp_clone_payload(sk, nskb, probe_size)) {
+		tcp_skb_tsorted_anchor_cleanup(nskb);
 		consume_skb(nskb);
 		return -1;
 	}
diff --git a/net/mctp/route.c b/net/mctp/route.c
index ab62fe447038..7a47a58aa54b 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -737,6 +737,8 @@ struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 {
 	struct mctp_route *tmp, *rt = NULL;
 
+	rcu_read_lock();
+
 	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
 		/* TODO: add metrics */
 		if (mctp_rt_match_eid(tmp, dnet, daddr)) {
@@ -747,21 +749,29 @@ struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 		}
 	}
 
+	rcu_read_unlock();
+
 	return rt;
 }
 
 static struct mctp_route *mctp_route_lookup_null(struct net *net,
 						 struct net_device *dev)
 {
-	struct mctp_route *rt;
+	struct mctp_route *tmp, *rt = NULL;
 
-	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
-		if (rt->dev->dev == dev && rt->type == RTN_LOCAL &&
-		    refcount_inc_not_zero(&rt->refs))
-			return rt;
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
+		if (tmp->dev->dev == dev && tmp->type == RTN_LOCAL &&
+		    refcount_inc_not_zero(&tmp->refs)) {
+			rt = tmp;
+			break;
+		}
 	}
 
-	return NULL;
+	rcu_read_unlock();
+
+	return rt;
 }
 
 static int mctp_do_fragment_route(struct mctp_route *rt, struct sk_buff *skb,
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index f6684c052e3b..c8a686eee7c2 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1441,7 +1441,7 @@ static int bind_mcastif_addr(struct socket *sock, struct net_device *dev)
 	sin.sin_addr.s_addr  = addr;
 	sin.sin_port         = 0;
 
-	return sock->ops->bind(sock, (struct sockaddr*)&sin, sizeof(sin));
+	return kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
 }
 
 static void get_mcast_sockaddr(union ipvs_sockaddr *sa, int *salen,
@@ -1548,7 +1548,7 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->bcfg, id);
 	sock->sk->sk_bound_dev_if = dev->ifindex;
-	result = sock->ops->bind(sock, (struct sockaddr *)&mcast_addr, salen);
+	result = kernel_bind(sock, (struct sockaddr *)&mcast_addr, salen);
 	if (result < 0) {
 		pr_err("Error binding to the multicast addr\n");
 		goto error;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 6705bb895e23..1dac28136e6a 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -203,17 +203,13 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
 
 		if (tmp_sock->ssap == ssap && tmp_sock->dsap == dsap) {
 			llcp_sock = tmp_sock;
+			sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
 
 	read_unlock(&local->sockets.lock);
 
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
 	return llcp_sock;
 }
 
@@ -346,7 +342,8 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 
 static
 struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
-					    const u8 *sn, size_t sn_len)
+					    const u8 *sn, size_t sn_len,
+					    bool needref)
 {
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock, *tmp_sock;
@@ -382,6 +379,8 @@ struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
 
 		if (memcmp(sn, tmp_sock->service_name, sn_len) == 0) {
 			llcp_sock = tmp_sock;
+			if (needref)
+				sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
@@ -423,7 +422,8 @@ u8 nfc_llcp_get_sdp_ssap(struct nfc_llcp_local *local,
 		 * to this service name.
 		 */
 		if (nfc_llcp_sock_from_sn(local, sock->service_name,
-					  sock->service_name_len) != NULL) {
+					  sock->service_name_len,
+					  false) != NULL) {
 			mutex_unlock(&local->sdp_lock);
 
 			return LLCP_SAP_MAX;
@@ -824,16 +824,7 @@ static struct nfc_llcp_sock *nfc_llcp_connecting_sock_get(struct nfc_llcp_local
 static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 						  const u8 *sn, size_t sn_len)
 {
-	struct nfc_llcp_sock *llcp_sock;
-
-	llcp_sock = nfc_llcp_sock_from_sn(local, sn, sn_len);
-
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
-	return llcp_sock;
+	return nfc_llcp_sock_from_sn(local, sn, sn_len, true);
 }
 
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
@@ -1298,7 +1289,8 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			}
 
 			llcp_sock = nfc_llcp_sock_from_sn(local, service_name,
-							  service_name_len);
+							  service_name_len,
+							  true);
 			if (!llcp_sock) {
 				sap = 0;
 				goto add_snl;
@@ -1318,6 +1310,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 				if (sap == LLCP_SAP_MAX) {
 					sap = 0;
+					nfc_llcp_sock_put(llcp_sock);
 					goto add_snl;
 				}
 
@@ -1335,6 +1328,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 			pr_debug("%p %d\n", llcp_sock, sap);
 
+			nfc_llcp_sock_put(llcp_sock);
 add_snl:
 			sdp = nfc_llcp_build_sdres_tlv(tid, sap);
 			if (sdp == NULL)
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index fff755dde30d..6c9592d05120 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -909,6 +909,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
 		return -EINVAL;
 	}
 
+	if (protocol >= NFC_PROTO_MAX) {
+		pr_err("the requested nfc protocol is invalid\n");
+		return -EINVAL;
+	}
+
 	if (!(nci_target->supported_protocols & (1 << protocol))) {
 		pr_err("target does not support the requested protocol 0x%x\n",
 		       protocol);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a2935bd18ed9..a39b2a0dd542 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3605,7 +3605,12 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
 	if (dev) {
 		sll->sll_hatype = dev->type;
 		sll->sll_halen = dev->addr_len;
-		memcpy(sll->sll_addr_flex, dev->dev_addr, dev->addr_len);
+
+		/* Let __fortify_memcpy_chk() know the actual buffer size. */
+		memcpy(((struct sockaddr_storage *)sll)->__data +
+		       offsetof(struct sockaddr_ll, sll_addr) -
+		       offsetofend(struct sockaddr_ll, sll_family),
+		       dev->dev_addr, dev->addr_len);
 	} else {
 		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
 		sll->sll_halen = 0;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index d788c6d28986..a0046e99d6df 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -145,7 +145,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = sock->ops->bind(sock, addr, addrlen);
+	ret = kernel_bind(sock, addr, addrlen);
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 014fa24418c1..53b3535a1e4a 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -306,7 +306,7 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 		addr_len = sizeof(*sin);
 	}
 
-	ret = sock->ops->bind(sock, (struct sockaddr *)&ss, addr_len);
+	ret = kernel_bind(sock, (struct sockaddr *)&ss, addr_len);
 	if (ret < 0) {
 		rdsdebug("could not bind %s listener socket: %d\n",
 			 isv6 ? "IPv6" : "IPv4", ret);
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 1ab3c5a2c5ad..746be3996768 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -2,6 +2,7 @@
 config SMC
 	tristate "SMC socket protocol family"
 	depends on INET && INFINIBAND
+	depends on m || ISM != m
 	help
 	  SMC-R provides a "sockets over RDMA" solution making use of
 	  RDMA over Converged Ethernet (RoCE) technology to upgrade
diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index aa8928975cc6..9d32058db2b5 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -92,13 +92,14 @@ do { \
 	typeof(_smc_stats) stats = (_smc_stats); \
 	typeof(_tech) t = (_tech); \
 	typeof(_len) l = (_len); \
-	int _pos = fls64((l) >> 13); \
+	int _pos; \
 	typeof(_rc) r = (_rc); \
 	int m = SMC_BUF_MAX - 1; \
 	this_cpu_inc((*stats).smc[t].key ## _cnt); \
-	if (r <= 0) \
+	if (r <= 0 || l <= 0) \
 		break; \
-	_pos = (_pos < m) ? ((l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m; \
+	_pos = fls64((l - 1) >> 13); \
+	_pos = (_pos <= m) ? _pos : m; \
 	this_cpu_inc((*stats).smc[t].key ## _pd.buf[_pos]); \
 	this_cpu_add((*stats).smc[t].key ## _bytes, r); \
 } \
@@ -138,9 +139,12 @@ while (0)
 do { \
 	typeof(_len) _l = (_len); \
 	typeof(_tech) t = (_tech); \
-	int _pos = fls((_l) >> 13); \
+	int _pos; \
 	int m = SMC_BUF_MAX - 1; \
-	_pos = (_pos < m) ? ((_l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m; \
+	if (_l <= 0) \
+		break; \
+	_pos = fls((_l - 1) >> 13); \
+	_pos = (_pos <= m) ? _pos : m; \
 	this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
 } \
 while (0)
diff --git a/net/socket.c b/net/socket.c
index 95942c1786e5..2751c8e9674f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3467,7 +3467,11 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 
 int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
-	return sock->ops->bind(sock, addr, addrlen);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return sock->ops->bind(sock, (struct sockaddr *)&address, addrlen);
 }
 EXPORT_SYMBOL(kernel_bind);
 
diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index f8905400ee07..d2c264030017 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -34,6 +34,16 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 	q->ring_mask = nentries - 1;
 
 	size = xskq_get_ring_size(q, umem_queue);
+
+	/* size which is overflowing or close to SIZE_MAX will become 0 in
+	 * PAGE_ALIGN(), checking SIZE_MAX is enough due to the previous
+	 * is_power_of_2(), the rest will be handled by vmalloc_user()
+	 */
+	if (unlikely(size == SIZE_MAX)) {
+		kfree(q);
+		return NULL;
+	}
+
 	size = PAGE_ALIGN(size);
 
 	q->ring = vmalloc_user(size);
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index c6fc50d67214..85fb5c22529a 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -44,13 +44,12 @@ static const struct trusted_key_source trusted_key_sources[] = {
 #endif
 };
 
-DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
 DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
 DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
 			*trusted_key_sources[0].ops->unseal);
 DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
 			*trusted_key_sources[0].ops->get_random);
-DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
+static void (*trusted_key_exit)(void);
 static unsigned char migratable;
 
 enum {
@@ -359,19 +358,16 @@ static int __init init_trusted(void)
 		if (!get_random)
 			get_random = kernel_get_random;
 
-		static_call_update(trusted_key_init,
-				   trusted_key_sources[i].ops->init);
 		static_call_update(trusted_key_seal,
 				   trusted_key_sources[i].ops->seal);
 		static_call_update(trusted_key_unseal,
 				   trusted_key_sources[i].ops->unseal);
 		static_call_update(trusted_key_get_random,
 				   get_random);
-		static_call_update(trusted_key_exit,
-				   trusted_key_sources[i].ops->exit);
+		trusted_key_exit = trusted_key_sources[i].ops->exit;
 		migratable = trusted_key_sources[i].ops->migratable;
 
-		ret = static_call(trusted_key_init)();
+		ret = trusted_key_sources[i].ops->init();
 		if (!ret)
 			break;
 	}
@@ -388,7 +384,8 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	static_call_cond(trusted_key_exit)();
+	if (trusted_key_exit)
+		(*trusted_key_exit)();
 }
 
 late_initcall(init_trusted);
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index ce5faa620517..9ba77e685126 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -178,10 +178,14 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 					    cs35l41->speaker_id, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
-		return cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						     CS35L41_FIRMWARE_ROOT,
-						     cs35l41->acpi_subsystem_id, cs35l41->amp_name,
-						     cs35l41->speaker_id, "bin");
+		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						    CS35L41_FIRMWARE_ROOT,
+						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+						    cs35l41->speaker_id, "bin");
+		if (ret)
+			goto coeff_err;
+
+		return 0;
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
@@ -190,10 +194,14 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 					    cs35l41->amp_name, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
-		return cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						     CS35L41_FIRMWARE_ROOT,
-						     cs35l41->acpi_subsystem_id, cs35l41->amp_name,
-						     cs35l41->speaker_id, "bin");
+		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						    CS35L41_FIRMWARE_ROOT,
+						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+						    cs35l41->speaker_id, "bin");
+		if (ret)
+			goto coeff_err;
+
+		return 0;
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub<-spkidN>.wmfw */
@@ -208,10 +216,14 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 						    cs35l41->amp_name, cs35l41->speaker_id, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
-			return cs35l41_request_firmware_file(cs35l41, coeff_firmware,
-							     coeff_filename, CS35L41_FIRMWARE_ROOT,
-							     cs35l41->acpi_subsystem_id, NULL,
-							     cs35l41->speaker_id, "bin");
+			ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware,
+							    coeff_filename, CS35L41_FIRMWARE_ROOT,
+							    cs35l41->acpi_subsystem_id, NULL,
+							    cs35l41->speaker_id, "bin");
+		if (ret)
+			goto coeff_err;
+
+		return 0;
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub.wmfw */
@@ -226,12 +238,50 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 						    cs35l41->speaker_id, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
-			return cs35l41_request_firmware_file(cs35l41, coeff_firmware,
-							     coeff_filename, CS35L41_FIRMWARE_ROOT,
-							     cs35l41->acpi_subsystem_id, NULL,
-							     cs35l41->speaker_id, "bin");
+			ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware,
+							    coeff_filename, CS35L41_FIRMWARE_ROOT,
+							    cs35l41->acpi_subsystem_id, NULL,
+							    cs35l41->speaker_id, "bin");
+		if (ret)
+			goto coeff_err;
+	}
+
+	return ret;
+coeff_err:
+	release_firmware(*wmfw_firmware);
+	kfree(*wmfw_filename);
+	return ret;
+}
+
+static int cs35l41_fallback_firmware_file(struct cs35l41_hda *cs35l41,
+					  const struct firmware **wmfw_firmware,
+					  char **wmfw_filename,
+					  const struct firmware **coeff_firmware,
+					  char **coeff_filename)
+{
+	int ret;
+
+	/* Handle fallback */
+	dev_warn(cs35l41->dev, "Falling back to default firmware.\n");
+
+	/* fallback try cirrus/part-dspN-fwtype.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "wmfw");
+	if (ret)
+		goto err;
+
+	/* fallback try cirrus/part-dspN-fwtype.bin */
+	ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
+	if (ret) {
+		release_firmware(*wmfw_firmware);
+		kfree(*wmfw_filename);
+		goto err;
 	}
+	return 0;
 
+err:
+	dev_warn(cs35l41->dev, "Unable to find firmware and tuning\n");
 	return ret;
 }
 
@@ -247,7 +297,6 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 		ret = cs35l41_request_firmware_files_spkid(cs35l41, wmfw_firmware, wmfw_filename,
 							   coeff_firmware, coeff_filename);
 		goto out;
-
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
@@ -260,6 +309,9 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 						    CS35L41_FIRMWARE_ROOT,
 						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
 						    -1, "bin");
+		if (ret)
+			goto coeff_err;
+
 		goto out;
 	}
 
@@ -279,32 +331,23 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 							    CS35L41_FIRMWARE_ROOT,
 							    cs35l41->acpi_subsystem_id, NULL, -1,
 							    "bin");
+		if (ret)
+			goto coeff_err;
 	}
 
 out:
-	if (!ret)
-		return 0;
+	if (ret)
+		/* if all attempts at finding firmware fail, try fallback */
+		goto fallback;
 
-	/* Handle fallback */
-	dev_warn(cs35l41->dev, "Falling back to default firmware.\n");
+	return 0;
 
+coeff_err:
 	release_firmware(*wmfw_firmware);
 	kfree(*wmfw_filename);
-
-	/* fallback try cirrus/part-dspN-fwtype.wmfw */
-	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "wmfw");
-	if (!ret)
-		/* fallback try cirrus/part-dspN-fwtype.bin */
-		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
-
-	if (ret) {
-		release_firmware(*wmfw_firmware);
-		kfree(*wmfw_filename);
-		dev_warn(cs35l41->dev, "Unable to find firmware and tuning\n");
-	}
-	return ret;
+fallback:
+	return cs35l41_fallback_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					      coeff_firmware, coeff_filename);
 }
 
 #if IS_ENABLED(CONFIG_EFI)
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4a13747b2b0f..10703a3df7ea 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4639,6 +4639,22 @@ static void alc236_fixup_hp_mute_led_coefbit2(struct hda_codec *codec,
 	}
 }
 
+static void alc245_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
+					  const struct hda_fixup *fix,
+					  int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x0b;
+		spec->mute_led_coef.mask = 3 << 2;
+		spec->mute_led_coef.on = 2 << 2;
+		spec->mute_led_coef.off = 1 << 2;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -6972,6 +6988,29 @@ static void alc295_fixup_dell_inspiron_top_speakers(struct hda_codec *codec,
 	}
 }
 
+/* Forcibly assign NID 0x03 to HP while NID 0x02 to SPK */
+static void alc287_fixup_bind_dacs(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	static const hda_nid_t conn[] = { 0x02, 0x03 }; /* exclude 0x06 */
+	static const hda_nid_t preferred_pairs[] = {
+		0x17, 0x02, 0x21, 0x03, 0
+	};
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+	spec->gen.preferred_dacs = preferred_pairs;
+	spec->gen.auto_mute_via_amp = 1;
+	if (spec->gen.autocfg.speaker_pins[0] != 0x14) {
+		snd_hda_codec_write_cache(codec, 0x14, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+					0x0); /* Make sure 0x14 was disable */
+	}
+}
+
+
 enum {
 	ALC269_FIXUP_GPIO2,
 	ALC269_FIXUP_SONY_VAIO,
@@ -7231,6 +7270,10 @@ enum {
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
+	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
+	ALC245_FIXUP_HP_X360_MUTE_LEDS,
+	ALC287_FIXUP_THINKPAD_I2S_SPK,
+	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9309,6 +9352,26 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
+	[ALC245_FIXUP_HP_MUTE_LED_COEFBIT] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_mute_led_coefbit,
+	},
+	[ALC245_FIXUP_HP_X360_MUTE_LEDS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_mute_led_coefbit,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_GPIO_LED
+	},
+	[ALC287_FIXUP_THINKPAD_I2S_SPK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_bind_dacs,
+	},
+	[ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_bind_dacs,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9551,6 +9614,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x888a, "HP ENVY x360 Convertible 15-eu0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
@@ -9582,6 +9646,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x89d3, "HP EliteBook 645 G9 (MB 89D2)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
@@ -9720,7 +9785,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1254, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
-	SND_PCI_QUIRK(0x10ec, 0x12cc, "Intel Reference board", ALC225_FIXUP_HEADSET_JACK),
+	SND_PCI_QUIRK(0x10ec, 0x12cc, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
@@ -9854,14 +9919,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x22be, "Thinkpad X1 Carbon 8th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c1, "Thinkpad P1 Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c2, "Thinkpad X1 Extreme Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
-	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
@@ -9943,7 +10008,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
-	SND_PCI_QUIRK(0x8086, 0x3038, "Intel NUC 13", ALC225_FIXUP_HEADSET_JACK),
+	SND_PCI_QUIRK(0x8086, 0x3038, "Intel NUC 13", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0xf111, 0x0001, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0
@@ -10425,6 +10490,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x17, 0x90170111},
 		{0x19, 0x03a11030},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0287, 0x17aa, "Lenovo", ALC287_FIXUP_THINKPAD_I2S_SPK,
+		{0x17, 0x90170110},
+		{0x19, 0x03a11030},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0286, 0x1025, "Acer", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 5cc774b3da05..6153f9192613 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -234,6 +234,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82YM"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d21f69f05342..d661bc9255f9 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -531,7 +531,10 @@ static int hdmi_codec_fill_codec_params(struct snd_soc_dai *dai,
 	hp->sample_rate = sample_rate;
 	hp->channels = channels;
 
-	hcp->chmap_idx = idx;
+	if (pcm_audio)
+		hcp->chmap_idx = ca_id;
+	else
+		hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 
 	return 0;
 }
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index f7676d30c82f..0497bebae0ec 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -710,10 +710,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 {
 	unsigned int ofs = sai->soc_data->reg_offset;
 	bool tx = dir == TX;
-	u32 xcsr, count = 100;
+	u32 xcsr, count = 100, mask;
+
+	if (sai->soc_data->mclk_with_tere && sai->mclk_direction_output)
+		mask = FSL_SAI_CSR_TERE;
+	else
+		mask = FSL_SAI_CSR_TERE | FSL_SAI_CSR_BCE;
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
-			   FSL_SAI_CSR_TERE | FSL_SAI_CSR_BCE, 0);
+			   mask, 0);
 
 	/* TERE will remain set till the end of current frame */
 	do {
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 3019626b0592..a6fe350c3373 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -310,7 +310,8 @@ int asoc_simple_startup(struct snd_pcm_substream *substream)
 		if (fixed_sysclk % props->mclk_fs) {
 			dev_err(rtd->dev, "fixed sysclk %u not divisible by mclk_fs %u\n",
 				fixed_sysclk, props->mclk_fs);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto codec_err;
 		}
 		ret = snd_pcm_hw_constraint_minmax(substream->runtime, SNDRV_PCM_HW_PARAM_RATE,
 			fixed_rate, fixed_rate);
diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index d6c38d8ea2ff..ee57bfbca784 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -798,6 +798,16 @@ static const struct platform_device_id board_ids[] = {
 					SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK |
 					SOF_ES8336_JD_INVERTED),
 	},
+	{
+		.name = "mtl_es83x6_c1_h02",
+		.driver_data = (kernel_ulong_t)(SOF_ES8336_SSP_CODEC(1) |
+					SOF_NO_OF_HDMI_CAPTURE_SSP(2) |
+					SOF_HDMI_CAPTURE_1_SSP(0) |
+					SOF_HDMI_CAPTURE_2_SSP(2) |
+					SOF_SSP_HDMI_CAPTURE_PRESENT |
+					SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK |
+					SOF_ES8336_JD_INVERTED),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index c86f8f9a6100..93544eac23ad 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -385,6 +385,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
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
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index bcd66e0094b4..c4b57cca6b22 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -648,18 +648,18 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-adl-rt1316-l2-mono-rt714-l3.tplg",
 	},
-	{
-		.link_mask = 0x3, /* rt1316 on link1 & rt714 on link0 */
-		.links = adl_sdw_rt1316_link1_rt714_link0,
-		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-adl-rt1316-l1-mono-rt714-l0.tplg",
-	},
 	{
 		.link_mask = 0x7, /* rt714 on link0 & two rt1316s on link1 and link2 */
 		.links = adl_sdw_rt1316_link12_rt714_link0,
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-adl-rt1316-l12-rt714-l0.tplg",
 	},
+	{
+		.link_mask = 0x3, /* rt1316 on link1 & rt714 on link0 */
+		.links = adl_sdw_rt1316_link1_rt714_link0,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-adl-rt1316-l1-mono-rt714-l0.tplg",
+	},
 	{
 		.link_mask = 0x5, /* 2 active links required */
 		.links = adl_sdw_rt1316_link2_rt714_link0,
diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index ed9821adc1d9..d0bfefa7c9ec 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -30,6 +30,16 @@ static const struct snd_soc_acpi_codecs mtl_rt5682_rt5682s_hp = {
 	.codecs = {"10EC5682", "RTL5682"},
 };
 
+static const struct snd_soc_acpi_codecs mtl_lt6911_hdmi = {
+	.num_codecs = 1,
+	.codecs = {"INTC10B0"}
+};
+
+static const struct snd_soc_acpi_codecs mtl_essx_83x6 = {
+	.num_codecs = 3,
+	.codecs = { "ESSX8316", "ESSX8326", "ESSX8336"},
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
 	{
 		.comp_ids = &mtl_rt5682_rt5682s_hp,
@@ -45,6 +55,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
 		.quirk_data = &mtl_max98360a_amp,
 		.sof_tplg_filename = "sof-mtl-max98360a-rt5682.tplg",
 	},
+	{
+		.comp_ids = &mtl_essx_83x6,
+		.drv_name = "mtl_es83x6_c1_h02",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &mtl_lt6911_hdmi,
+		.sof_tplg_filename = "sof-mtl-es83x6-ssp1-hdmi-ssp02.tplg",
+	},
 	{
 		.comp_ids = &mtl_rt5682_rt5682s_hp,
 		.drv_name = "mtl_rt1019_rt5682",
@@ -52,6 +69,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
 		.quirk_data = &mtl_rt1019p_amp,
 		.sof_tplg_filename = "sof-mtl-rt1019-rt5682.tplg",
 	},
+	{
+		.comp_ids = &mtl_essx_83x6,
+		.drv_name = "sof-essx8336",
+		.sof_tplg_filename = "sof-mtl-es8336", /* the tplg suffix is added at run time */
+		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_SSP_NUMBER |
+					SND_SOC_ACPI_TPLG_INTEL_SSP_MSB |
+					SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER,
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_mtl_machines);
diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index 58b3092425f1..874230ffcbcc 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -34,7 +34,6 @@ static const struct sof_amd_acp_desc rembrandt_chip_info = {
 	.dsp_intr_base	= ACP6X_DSP_SW_INTR_BASE,
 	.sram_pte_offset = ACP6X_SRAM_PTE_OFFSET,
 	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
-	.acp_clkmux_sel = ACP6X_CLKMUX_SEL,
 	.fusion_dsp_offset = ACP6X_DSP_FUSION_RUNSTALL,
 };
 
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 9105ec623120..783a2493707e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1204,6 +1204,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 16;
 		}
 		break;
+	case USB_ID(0x1bcf, 0x2283): /* NexiGo N930AF FHD Webcam */
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			usb_audio_info(chip,
+				"set resolution quirk: cval->res = 16\n");
+			cval->res = 16;
+		}
+		break;
 	}
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 598659d761cc..4e64842245e1 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1994,7 +1994,11 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 		/* mic works only when ep packet size is set to wMaxPacketSize */
 		fp->attributes |= UAC_EP_CS_ATTR_FILL_MAX;
 		break;
-
+	case USB_ID(0x3511, 0x2b1e): /* Opencomm2 UC USB Bluetooth dongle */
+		/* mic works only when ep pitch control is not set */
+		if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			fp->attributes &= ~UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
 	}
 }
 
@@ -2173,6 +2177,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
+	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
