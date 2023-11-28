Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE56C7FC2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbjK1RVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345467AbjK1RVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:21:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E519AA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:21:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36078C433C8;
        Tue, 28 Nov 2023 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701192100;
        bh=TtxHMGAf5tGM09GUf9kbeCSgtdm421u6N6ow040OIPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K96+ia1p/bSeGOvn0tgX21U0H5jaK8GJiR6wNo8D+fKX0f1mCdjOqgC642AEKCfbX
         S9zsLHMlvuI+z1YLwrY9Pzu3bM3e8PBek24uBjsuqJfi7YgrMtGmCzeF8JJ+39j202
         4RA5bycPm9Ff985Zx+hP1iYqmLSi2VReOb4oanK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.140
Date:   Tue, 28 Nov 2023 17:21:27 +0000
Message-ID: <2023112827-batch-twenty-9c81@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023112827-slogan-capitol-571e@gregkh>
References: <2023112827-slogan-capitol-571e@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 2acf6ff74c95..90d878daaba6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 139
+SUBLEVEL = 140
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
index 58e039a851af..3c82975d46db 100644
--- a/arch/arm/include/asm/exception.h
+++ b/arch/arm/include/asm/exception.h
@@ -10,10 +10,6 @@
 
 #include <linux/interrupt.h>
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 #define __exception_irq_entry	__irq_entry
-#else
-#define __exception_irq_entry
-#endif
 
 #endif /* __ASM_ARM_EXCEPTION_H */
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5ab4b0520eab..68874d3856b9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1153,6 +1153,8 @@ choice
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
 	depends on !LD_IS_LLD || LLD_VERSION >= 130000
+	# https://github.com/llvm/llvm-project/commit/1379b150991f70a5782e9a143c2ba5308da1161c
+	depends on AS_IS_GNU || AS_VERSION >= 150000
 	help
 	  Say Y if you plan on running a kernel with a big-endian userspace.
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 12e59777363f..9bb360db6b19 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1179,26 +1179,34 @@ sata1: sata@3210000 {
 			dma-coherent;
 		};
 
-		usb0: usb@3100000 {
-			status = "disabled";
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <0 80 0x4>; /* Level high type */
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-		};
+		bus: bus {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			compatible = "simple-bus";
+			ranges;
+			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
+
+			usb0: usb@3100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <0 80 0x4>; /* Level high type */
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				status = "disabled";
+			};
 
-		usb1: usb@3110000 {
-			status = "disabled";
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3110000 0x0 0x10000>;
-			interrupts = <0 81 0x4>; /* Level high type */
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			usb1: usb@3110000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3110000 0x0 0x10000>;
+				interrupts = <0 81 0x4>; /* Level high type */
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				status = "disabled";
+			};
 		};
 
 		ccn@4000000 {
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 3ca198f866c3..dde6fde10f8d 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -129,12 +129,6 @@ scm {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x80>;
-		#hwlock-cells = <1>;
-	};
-
 	pmuv8: pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
@@ -175,7 +169,7 @@ q6_region: memory@4ab00000 {
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_region>;
-		hwlocks = <&tcsr_mutex 0>;
+		hwlocks = <&tcsr_mutex 3>;
 	};
 
 	soc: soc {
@@ -253,9 +247,10 @@ gcc: gcc@1800000 {
 			#reset-cells = <1>;
 		};
 
-		tcsr_mutex_regs: syscon@1905000 {
-			compatible = "syscon";
-			reg = <0x0 0x01905000 0x0 0x8000>;
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,ipq6018-tcsr-mutex", "qcom,tcsr-mutex";
+			reg = <0x0 0x01905000 0x0 0x20000>;
+			#hwlock-cells = <1>;
 		};
 
 		tcsr: syscon@1937000 {
diff --git a/arch/parisc/include/uapi/asm/pdc.h b/arch/parisc/include/uapi/asm/pdc.h
index 15211723ebf5..ee903551ae10 100644
--- a/arch/parisc/include/uapi/asm/pdc.h
+++ b/arch/parisc/include/uapi/asm/pdc.h
@@ -465,6 +465,7 @@ struct pdc_model {		/* for PDC_MODEL */
 	unsigned long arch_rev;
 	unsigned long pot_key;
 	unsigned long curr_key;
+	unsigned long width;	/* default of PSW_W bit (1=enabled) */
 };
 
 struct pdc_cache_cf {		/* for PDC_CACHE  (I/D-caches) */
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index 437c8d31f390..02e849a65aa8 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -497,13 +497,13 @@
 	 * to a CPU TLB 4k PFN (4k => 12 bits to shift) */
 	#define PAGE_ADD_SHIFT		(PAGE_SHIFT-12)
 	#define PAGE_ADD_HUGE_SHIFT	(REAL_HPAGE_SHIFT-12)
+	#define PFN_START_BIT	(63-ASM_PFN_PTE_SHIFT+(63-58)-PAGE_ADD_SHIFT)
 
 	/* Drop prot bits and convert to page addr for iitlbt and idtlbt */
 	.macro		convert_for_tlb_insert20 pte,tmp
 #ifdef CONFIG_HUGETLB_PAGE
 	copy		\pte,\tmp
-	extrd,u		\tmp,(63-ASM_PFN_PTE_SHIFT)+(63-58)+PAGE_ADD_SHIFT,\
-				64-PAGE_SHIFT-PAGE_ADD_SHIFT,\pte
+	extrd,u		\tmp,PFN_START_BIT,PFN_START_BIT+1,\pte
 
 	depdi		_PAGE_SIZE_ENCODING_DEFAULT,63,\
 				(63-58)+PAGE_ADD_SHIFT,\pte
@@ -511,8 +511,7 @@
 	depdi		_HUGE_PAGE_SIZE_ENCODING_DEFAULT,63,\
 				(63-58)+PAGE_ADD_HUGE_SHIFT,\pte
 #else /* Huge pages disabled */
-	extrd,u		\pte,(63-ASM_PFN_PTE_SHIFT)+(63-58)+PAGE_ADD_SHIFT,\
-				64-PAGE_SHIFT-PAGE_ADD_SHIFT,\pte
+	extrd,u		\pte,PFN_START_BIT,PFN_START_BIT+1,\pte
 	depdi		_PAGE_SIZE_ENCODING_DEFAULT,63,\
 				(63-58)+PAGE_ADD_SHIFT,\pte
 #endif
diff --git a/arch/parisc/kernel/head.S b/arch/parisc/kernel/head.S
index 598d0938449d..2f95c2429f77 100644
--- a/arch/parisc/kernel/head.S
+++ b/arch/parisc/kernel/head.S
@@ -69,9 +69,8 @@ $bss_loop:
 	stw,ma          %arg2,4(%r1)
 	stw,ma          %arg3,4(%r1)
 
-#if !defined(CONFIG_64BIT) && defined(CONFIG_PA20)
-	/* This 32-bit kernel was compiled for PA2.0 CPUs. Check current CPU
-	 * and halt kernel if we detect a PA1.x CPU. */
+#if defined(CONFIG_PA20)
+	/* check for 64-bit capable CPU as required by current kernel */
 	ldi		32,%r10
 	mtctl		%r10,%cr11
 	.level 2.0
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 1078784b74c9..c9fc0edf56b1 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1342,8 +1342,7 @@ static void power_pmu_disable(struct pmu *pmu)
 		/*
 		 * Disable instruction sampling if it was enabled
 		 */
-		if (cpuhw->mmcr.mmcra & MMCRA_SAMPLE_ENABLE)
-			val &= ~MMCRA_SAMPLE_ENABLE;
+		val &= ~MMCRA_SAMPLE_ENABLE;
 
 		/* Disable BHRB via mmcra (BHRBRD) for p10 */
 		if (ppmu->flags & PPMU_ARCH_31)
@@ -1354,7 +1353,7 @@ static void power_pmu_disable(struct pmu *pmu)
 		 * instruction sampling or BHRB.
 		 */
 		if (val != mmcra) {
-			mtspr(SPRN_MMCRA, mmcra);
+			mtspr(SPRN_MMCRA, val);
 			mb();
 			isync();
 		}
diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index 113bdb151f68..40e26e9f318f 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -24,13 +24,20 @@
 #include <linux/uaccess.h>
 
 
+struct opal_prd_msg {
+	union {
+		struct opal_prd_msg_header header;
+		DECLARE_FLEX_ARRAY(u8, data);
+	};
+};
+
 /*
  * The msg member must be at the end of the struct, as it's followed by the
  * message data.
  */
 struct opal_prd_msg_queue_item {
-	struct list_head		list;
-	struct opal_prd_msg_header	msg;
+	struct list_head	list;
+	struct opal_prd_msg	msg;
 };
 
 static struct device_node *prd_node;
@@ -156,7 +163,7 @@ static ssize_t opal_prd_read(struct file *file, char __user *buf,
 	int rc;
 
 	/* we need at least a header's worth of data */
-	if (count < sizeof(item->msg))
+	if (count < sizeof(item->msg.header))
 		return -EINVAL;
 
 	if (*ppos)
@@ -186,7 +193,7 @@ static ssize_t opal_prd_read(struct file *file, char __user *buf,
 			return -EINTR;
 	}
 
-	size = be16_to_cpu(item->msg.size);
+	size = be16_to_cpu(item->msg.header.size);
 	if (size > count) {
 		err = -EINVAL;
 		goto err_requeue;
@@ -352,7 +359,7 @@ static int opal_prd_msg_notifier(struct notifier_block *nb,
 	if (!item)
 		return -ENOMEM;
 
-	memcpy(&item->msg, msg->params, msg_size);
+	memcpy(&item->msg.data, msg->params, msg_size);
 
 	spin_lock_irqsave(&opal_prd_msg_queue_lock, flags);
 	list_add_tail(&item->list, &opal_prd_msg_queue);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index ec5d84b4958c..aa5f8074e9b1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1241,7 +1241,6 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct dma_win *window;
 	struct property *win64;
-	bool ddw_enabled = false;
 	struct failed_ddw_pdn *fpdn;
 	bool default_win_removed = false, direct_mapping = false;
 	bool pmem_present;
@@ -1256,7 +1255,6 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len)) {
 		direct_mapping = (len >= max_ram_len);
-		ddw_enabled = true;
 		goto out_unlock;
 	}
 
@@ -1411,8 +1409,8 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
 				 dn, ret);
 
-		/* Make sure to clean DDW if any TCE was set*/
-		clean_dma_window(pdn, win64->value);
+			/* Make sure to clean DDW if any TCE was set*/
+			clean_dma_window(pdn, win64->value);
 			goto out_del_list;
 		}
 	} else {
@@ -1459,7 +1457,6 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	spin_unlock(&dma_win_list_lock);
 
 	dev->dev.archdata.dma_offset = win_addr;
-	ddw_enabled = true;
 	goto out_unlock;
 
 out_del_list:
@@ -1495,10 +1492,10 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * as RAM, then we failed to create a window to cover persistent
 	 * memory and need to set the DMA limit.
 	 */
-	if (pmem_present && ddw_enabled && direct_mapping && len == max_ram_len)
+	if (pmem_present && direct_mapping && len == max_ram_len)
 		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset + (1ULL << len);
 
-    return ddw_enabled && direct_mapping;
+	return direct_mapping;
 }
 
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
index a20568bd1f1a..41bf1eb0110d 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -24,7 +24,7 @@ static inline bool rv_insn_reg_set_val(struct pt_regs *regs, u32 index,
 				       unsigned long val)
 {
 	if (index == 0)
-		return false;
+		return true;
 	else if (index <= 31)
 		*((unsigned long *)regs + index) = val;
 	else
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index 18a6381097a9..627767fdc85e 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -131,7 +131,7 @@ static void mark_kernel_pud(p4d_t *p4d, unsigned long addr, unsigned long end)
 			continue;
 		if (!pud_folded(*pud)) {
 			page = phys_to_page(pud_val(*pud));
-			for (i = 0; i < 3; i++)
+			for (i = 0; i < 4; i++)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_pmd(pud, addr, next);
@@ -152,7 +152,7 @@ static void mark_kernel_p4d(pgd_t *pgd, unsigned long addr, unsigned long end)
 			continue;
 		if (!p4d_folded(*p4d)) {
 			page = phys_to_page(p4d_val(*p4d));
-			for (i = 0; i < 3; i++)
+			for (i = 0; i < 4; i++)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_pud(p4d, addr, next);
@@ -174,7 +174,7 @@ static void mark_kernel_pgd(void)
 			continue;
 		if (!pgd_folded(*pgd)) {
 			page = phys_to_page(pgd_val(*pgd));
-			for (i = 0; i < 3; i++)
+			for (i = 0; i < 4; i++)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_p4d(pgd, addr, next);
diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 44340a1139e0..959afa705e95 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -24,8 +24,17 @@
 #include <linux/types.h>
 #include <crypto/sha1.h>
 #include <crypto/sha1_base.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int sha1_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len, sha1_block_fn *sha1_xform)
 {
@@ -301,6 +310,9 @@ static inline void unregister_sha1_ni(void) { }
 
 static int __init sha1_ssse3_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (register_sha1_ssse3())
 		goto fail;
 
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 3a5f6be7dbba..d25235f0ccaf 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -38,11 +38,20 @@
 #include <crypto/sha2.h>
 #include <crypto/sha256_base.h>
 #include <linux/string.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
 				       const u8 *data, int blocks);
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int _sha256_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len, sha256_block_fn *sha256_xform)
 {
@@ -366,6 +375,9 @@ static inline void unregister_sha256_ni(void) { }
 
 static int __init sha256_ssse3_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (register_sha256_ssse3())
 		goto fail;
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 5d929e413282..5672ccb80eb1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -511,6 +511,7 @@
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
+#define MSR_AMD64_TW_CFG		0xc0011023
 
 #define MSR_AMD64_DE_CFG		0xc0011029
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	 1
diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0d..ef2844d69173 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -12,13 +12,6 @@
 
 #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
 
-/*
- * Too small node sizes may confuse the VM badly. Usually they
- * result from BIOS bugs. So dont recognize nodes as standalone
- * NUMA entities that have less than this amount of RAM listed:
- */
-#define NODE_MIN_SIZE (4*1024*1024)
-
 extern int numa_off;
 
 /*
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index c393b8773ace..9e8380bd4fb9 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -86,8 +86,12 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		/* Socket ID is ApicId[6] for these processors. */
-		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
+		/*
+		 * Socket ID is ApicId[6] for the processors with model <= 0x3
+		 * when running on host.
+		 */
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && c->x86_model <= 0x3)
+			c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
 
 		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index a067c7ce8e19..29a96d1c7e2b 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -701,10 +701,12 @@ static int stimer_set_count(struct kvm_vcpu_hv_stimer *stimer, u64 count,
 
 	stimer_cleanup(stimer);
 	stimer->count = count;
-	if (stimer->count == 0)
-		stimer->config.enable = 0;
-	else if (stimer->config.auto_enable)
-		stimer->config.enable = 1;
+	if (!host) {
+		if (stimer->count == 0)
+			stimer->config.enable = 0;
+		else if (stimer->config.auto_enable)
+			stimer->config.enable = 1;
+	}
 
 	if (stimer->config.enable)
 		stimer_mark_pending(stimer, false);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7e9b61565306..aa6f700f8c5f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3393,6 +3393,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 		break;
 
@@ -3733,6 +3734,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 	/*
 	 * Intel Sandy Bridge CPUs must support the RAPL (running average power
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index e360c6892a58..1a1c0c242f27 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -601,13 +601,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 		if (start >= end)
 			continue;
 
-		/*
-		 * Don't confuse VM with a node that doesn't have the
-		 * minimum amount of memory:
-		 */
-		if (end && (end - start) < NODE_MIN_SIZE)
-			continue;
-
 		alloc_node_data(nid);
 	}
 
diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 9d10b846ccf7..005a36cb21bc 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -117,6 +117,8 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 	err = padata_do_parallel(ictx->psenc, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
@@ -164,6 +166,8 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 	err = padata_do_parallel(ictx->psdec, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index a2056c4c8cb7..271092f2700a 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -194,12 +194,19 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 		record_header = (void *)subtable_header + offset;
 		offset += record_header->length;
 
+		if (!record_header->length) {
+			pr_err(FW_BUG "Zero-length record found in FPTD.\n");
+			result = -EINVAL;
+			goto err;
+		}
+
 		switch (record_header->type) {
 		case RECORD_S3_RESUME:
 			if (subtable_type != SUBTABLE_S3PT) {
 				pr_err(FW_BUG "Invalid record %d for subtable %s\n",
 				     record_header->type, signature);
-				return -EINVAL;
+				result = -EINVAL;
+				goto err;
 			}
 			if (record_resume) {
 				pr_err("Duplicate resume performance record found.\n");
@@ -208,7 +215,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 			record_resume = (struct resume_performance_record *)record_header;
 			result = sysfs_create_group(fpdt_kobj, &resume_attr_group);
 			if (result)
-				return result;
+				goto err;
 			break;
 		case RECORD_S3_SUSPEND:
 			if (subtable_type != SUBTABLE_S3PT) {
@@ -223,13 +230,14 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 			record_suspend = (struct suspend_performance_record *)record_header;
 			result = sysfs_create_group(fpdt_kobj, &suspend_attr_group);
 			if (result)
-				return result;
+				goto err;
 			break;
 		case RECORD_BOOT:
 			if (subtable_type != SUBTABLE_FBPT) {
 				pr_err(FW_BUG "Invalid %d for subtable %s\n",
 				     record_header->type, signature);
-				return -EINVAL;
+				result = -EINVAL;
+				goto err;
 			}
 			if (record_boot) {
 				pr_err("Duplicate boot performance record found.\n");
@@ -238,7 +246,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 			record_boot = (struct boot_performance_record *)record_header;
 			result = sysfs_create_group(fpdt_kobj, &boot_attr_group);
 			if (result)
-				return result;
+				goto err;
 			break;
 
 		default:
@@ -247,6 +255,18 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 		}
 	}
 	return 0;
+
+err:
+	if (record_boot)
+		sysfs_remove_group(fpdt_kobj, &boot_attr_group);
+
+	if (record_suspend)
+		sysfs_remove_group(fpdt_kobj, &suspend_attr_group);
+
+	if (record_resume)
+		sysfs_remove_group(fpdt_kobj, &resume_attr_group);
+
+	return result;
 }
 
 static int __init acpi_init_fpdt(void)
@@ -255,6 +275,7 @@ static int __init acpi_init_fpdt(void)
 	struct acpi_table_header *header;
 	struct fpdt_subtable_entry *subtable;
 	u32 offset = sizeof(*header);
+	int result;
 
 	status = acpi_get_table(ACPI_SIG_FPDT, 0, &header);
 
@@ -263,8 +284,8 @@ static int __init acpi_init_fpdt(void)
 
 	fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
 	if (!fpdt_kobj) {
-		acpi_put_table(header);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto err_nomem;
 	}
 
 	while (offset < header->length) {
@@ -272,8 +293,10 @@ static int __init acpi_init_fpdt(void)
 		switch (subtable->type) {
 		case SUBTABLE_FBPT:
 		case SUBTABLE_S3PT:
-			fpdt_process_subtable(subtable->address,
+			result = fpdt_process_subtable(subtable->address,
 					      subtable->type);
+			if (result)
+				goto err_subtable;
 			break;
 		default:
 			/* Other types are reserved in ACPI 6.4 spec. */
@@ -282,6 +305,12 @@ static int __init acpi_init_fpdt(void)
 		offset += sizeof(*subtable);
 	}
 	return 0;
+err_subtable:
+	kobject_put(fpdt_kobj);
+
+err_nomem:
+	acpi_put_table(header);
+	return result;
 }
 
 fs_initcall(acpi_init_fpdt);
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index a404dcebc0f9..fa91ca32b9af 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -467,6 +467,18 @@ static const struct dmi_system_id maingear_laptop[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
 		}
 	},
+	{
+		/* TongFang GMxXGxx/TUXEDO Polaris 15 Gen5 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
+		},
+	},
+	{
+		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
+		},
+	},
 	{
 		.ident = "MAINGEAR Vector Pro 2 17",
 		.matches = {
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index bc8e8d9f176b..ce56306eeb6c 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2293,19 +2293,21 @@ static int get_esi(struct atm_dev *dev)
 static int reset_sar(struct atm_dev *dev)  
 {  
 	IADEV *iadev;  
-	int i, error = 1;  
+	int i, error;
 	unsigned int pci[64];  
 	  
 	iadev = INPH_IA_DEV(dev);  
-	for(i=0; i<64; i++)  
-	  if ((error = pci_read_config_dword(iadev->pci,  
-				i*4, &pci[i])) != PCIBIOS_SUCCESSFUL)  
-  	      return error;  
+	for (i = 0; i < 64; i++) {
+		error = pci_read_config_dword(iadev->pci, i * 4, &pci[i]);
+		if (error != PCIBIOS_SUCCESSFUL)
+			return error;
+	}
 	writel(0, iadev->reg+IPHASE5575_EXT_RESET);  
-	for(i=0; i<64; i++)  
-	  if ((error = pci_write_config_dword(iadev->pci,  
-					i*4, pci[i])) != PCIBIOS_SUCCESSFUL)  
-	    return error;  
+	for (i = 0; i < 64; i++) {
+		error = pci_write_config_dword(iadev->pci, i * 4, pci[i]);
+		if (error != PCIBIOS_SUCCESSFUL)
+			return error;
+	}
 	udelay(5);  
 	return 0;  
 }  
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index ab0b2eb5fa07..0bd166ad6f13 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1228,8 +1228,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		else if (drv->remove)
 			drv->remove(dev);
 
-		device_links_driver_cleanup(dev);
-
 		devres_release_all(dev);
 		arch_teardown_dma_ops(dev);
 		kfree(dev->dma_range_map);
@@ -1241,6 +1239,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		pm_runtime_reinit(dev);
 		dev_pm_set_driver_flags(dev, 0);
 
+		device_links_driver_cleanup(dev);
+
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
 		if (dev->bus)
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 0b517a83c449..b04e8c90aca2 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -325,6 +325,11 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
 	return 0;
 }
 
+static int rbtree_all(const void *key, const struct rb_node *node)
+{
+	return 0;
+}
+
 /**
  * regcache_sync - Sync the register cache with the hardware.
  *
@@ -342,6 +347,7 @@ int regcache_sync(struct regmap *map)
 	unsigned int i;
 	const char *name;
 	bool bypass;
+	struct rb_node *node;
 
 	if (WARN_ON(map->cache_type == REGCACHE_NONE))
 		return -EINVAL;
@@ -386,6 +392,30 @@ int regcache_sync(struct regmap *map)
 	map->async = false;
 	map->cache_bypass = bypass;
 	map->no_sync_defaults = false;
+
+	/*
+	 * If we did any paging with cache bypassed and a cached
+	 * paging register then the register and cache state might
+	 * have gone out of sync, force writes of all the paging
+	 * registers.
+	 */
+	rb_for_each(node, 0, &map->range_tree, rbtree_all) {
+		struct regmap_range_node *this =
+			rb_entry(node, struct regmap_range_node, node);
+
+		/* If there's nothing in the cache there's nothing to sync */
+		ret = regcache_read(map, this->selector_reg, &i);
+		if (ret != 0)
+			continue;
+
+		ret = _regmap_write(map, this->selector_reg, i);
+		if (ret != 0) {
+			dev_err(map->dev, "Failed to write %x = %x: %d\n",
+				this->selector_reg, i, ret);
+			break;
+		}
+	}
+
 	map->unlock(map->lock_arg);
 
 	regmap_async_complete(map);
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d2ba849bb8d1..affeca0dbc7e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -743,6 +743,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
+	size_t max_dma_size;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -844,7 +845,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, -1U);
 
-	max_size = virtio_max_dma_size(vdev);
+	max_dma_size = virtio_max_dma_size(vdev);
+	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
 
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c01d02f41bcb..a862f859f7a5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -436,6 +436,18 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3586), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8852BE Bluetooth devices */
+	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0xb85b), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3570), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
@@ -2497,6 +2509,9 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 		goto err_free_wc;
 	}
 
+	if (data->evt_skb == NULL)
+		goto err_free_wc;
+
 	/* Parse and handle the return WMT event */
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
 	if (wmt_evt->whdr.op != hdr->op) {
diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index cde62a11f573..4c5c7a8f41d0 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -75,7 +75,6 @@ static struct clk_fixed_factor gpll0_out_main_div2 = {
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -89,7 +88,6 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -164,7 +162,6 @@ static struct clk_alpha_pll_postdiv gpll6 = {
 				&gpll6_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -195,7 +192,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 				&gpll4_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -246,7 +242,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 				&gpll2_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -277,7 +272,6 @@ static struct clk_alpha_pll_postdiv nss_crypto_pll = {
 				&nss_crypto_pll_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index d6d5defb82c9..0393154fea2f 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -418,7 +418,6 @@ static struct clk_fixed_factor gpll0_out_main_div2 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -465,7 +464,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -498,7 +496,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -532,7 +529,6 @@ static struct clk_alpha_pll_postdiv gpll6 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -546,7 +542,6 @@ static struct clk_fixed_factor gpll6_out_main_div2 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -611,7 +606,6 @@ static struct clk_alpha_pll_postdiv nss_crypto_pll = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
diff --git a/drivers/clk/socfpga/stratix10-clk.h b/drivers/clk/socfpga/stratix10-clk.h
index 75234e0783e1..83fe4eb3133c 100644
--- a/drivers/clk/socfpga/stratix10-clk.h
+++ b/drivers/clk/socfpga/stratix10-clk.h
@@ -7,8 +7,10 @@
 #define	__STRATIX10_CLK_H
 
 struct stratix10_clock_data {
-	struct clk_hw_onecell_data	clk_data;
 	void __iomem		*base;
+
+	/* Must be last */
+	struct clk_hw_onecell_data	clk_data;
 };
 
 struct stratix10_pll_clock {
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 27af17c99590..2a90c92a9182 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -315,6 +315,7 @@ static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
 	writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP		/* free-run */
+			| ATMEL_TC_ASWTRG_SET		/* TIOA0 rises at software trigger */
 			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
 			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
 			tcaddr + ATMEL_TC_REG(0, CMR));
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 7b2c70f2f353..fabff69e52e5 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -454,12 +454,16 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
 		return -ENOMEM;
 
 	imxtm->base = of_iomap(np, 0);
-	if (!imxtm->base)
-		return -ENXIO;
+	if (!imxtm->base) {
+		ret = -ENXIO;
+		goto err_kfree;
+	}
 
 	imxtm->irq = irq_of_parse_and_map(np, 0);
-	if (imxtm->irq <= 0)
-		return -EINVAL;
+	if (imxtm->irq <= 0) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
 
 	imxtm->clk_ipg = of_clk_get_by_name(np, "ipg");
 
@@ -472,11 +476,15 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
 
 	ret = _mxc_timer_init(imxtm);
 	if (ret)
-		return ret;
+		goto err_kfree;
 
 	initialized = 1;
 
 	return 0;
+
+err_kfree:
+	kfree(imxtm);
+	return ret;
 }
 
 static int __init imx1_timer_init_dt(struct device_node *np)
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1570d6f3e75d..6e57df7a2249 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -131,25 +131,25 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
 				stats->freq_table[i]);
 	}
-	if (len >= PAGE_SIZE)
-		return PAGE_SIZE;
+	if (len >= PAGE_SIZE - 1)
+		return PAGE_SIZE - 1;
 
 	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 
 	for (i = 0; i < stats->state_num; i++) {
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u: ",
 				stats->freq_table[i]);
 
 		for (j = 0; j < stats->state_num; j++) {
-			if (len >= PAGE_SIZE)
+			if (len >= PAGE_SIZE - 1)
 				break;
 
 			if (pending)
@@ -159,12 +159,12 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 
 			len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ", count);
 		}
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 	}
 
-	if (len >= PAGE_SIZE) {
+	if (len >= PAGE_SIZE - 1) {
 		pr_warn_once("cpufreq transition table exceeds PAGE_SIZE. Disabling\n");
 		return -EFBIG;
 	}
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 58248c8c25a7..76202029a3f0 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -509,7 +509,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 	src_maxburst = chan->dma_config.src_maxburst;
 	dst_maxburst = chan->dma_config.dst_maxburst;
 
-	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
+	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
 	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
 	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
 
@@ -937,7 +937,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 	if (!desc)
 		return NULL;
 
-	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
+	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
 	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
 	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 18e1a4b80401..139c8c401254 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -136,6 +136,12 @@ static enum qcom_scm_convention __get_convention(void)
 	if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
 		return qcom_scm_convention;
 
+	/*
+	 * Per the "SMC calling convention specification", the 64-bit calling
+	 * convention can only be used when the client is 64-bit, otherwise
+	 * system will encounter the undefined behaviour.
+	 */
+#if IS_ENABLED(CONFIG_ARM64)
 	/*
 	 * Device isn't required as there is only one argument - no device
 	 * needed to dma_map_single to secure world
@@ -156,6 +162,7 @@ static enum qcom_scm_convention __get_convention(void)
 		forced = true;
 		goto found;
 	}
+#endif
 
 	probed_convention = SMC_CONVENTION_ARM_32;
 	ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 71354f505b84..1f916adf74dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "atom.h"
 
+#include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -289,6 +290,10 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
+	/* ATRM is for on-platform devices only */
+	if (dev_is_removable(&adev->pdev->dev))
+		return false;
+
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
 		dhandle = ACPI_HANDLE(&pdev->dev);
 		if (!dhandle)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 714178f1b6c6..9fb8012007e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -178,6 +178,7 @@ int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
 	}
 
 	rcu_read_unlock();
+	*result = NULL;
 	return -ENOENT;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 348629ea0e15..beb199d13451 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -458,6 +458,9 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_rreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
@@ -517,6 +520,9 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_wreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f57334fff7fc..19e32f38a4c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5116,7 +5116,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * Flush RAM to disk so that after reboot
 	 * the user can read log and see why the system rebooted.
 	 */
-	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
+	if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
+		amdgpu_ras_get_context(adev)->reboot) {
 		DRM_WARN("Emergency reboot.");
 
 		ksys_sync_helper();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 96a8fd0ca1df..439ea256ed25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1192,7 +1192,8 @@ static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	sysfs_remove_file_from_group(&adev->dev->kobj,
+	if (adev->dev->kobj.sd)
+		sysfs_remove_file_from_group(&adev->dev->kobj,
 				&con->badpages_attr.attr,
 				RAS_FS_NAME);
 }
@@ -1209,7 +1210,8 @@ static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
 		.attrs = attrs,
 	};
 
-	sysfs_remove_group(&adev->dev->kobj, &group);
+	if (adev->dev->kobj.sd)
+		sysfs_remove_group(&adev->dev->kobj, &group);
 
 	return 0;
 }
@@ -1257,7 +1259,8 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 	if (!obj || !obj->attr_inuse)
 		return -EINVAL;
 
-	sysfs_remove_file_from_group(&adev->dev->kobj,
+	if (adev->dev->kobj.sd)
+		sysfs_remove_file_from_group(&adev->dev->kobj,
 				&obj->sysfs_attr.attr,
 				RAS_FS_NAME);
 	obj->attr_inuse = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 4e8274de8fc0..083f9c637a82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -238,6 +238,8 @@ static int amdgpu_vkms_conn_get_modes(struct drm_connector *connector)
 
 	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+		if (!mode)
+			continue;
 		drm_mode_probed_add(connector, mode);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 86135ca33e5b..2cbe8ea16f24 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -550,8 +550,15 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 
 void svm_range_vram_node_free(struct svm_range *prange)
 {
-	svm_range_bo_unref(prange->svm_bo);
-	prange->ttm_res = NULL;
+	/* serialize prange->svm_bo unref */
+	mutex_lock(&prange->lock);
+	/* prange->svm_bo has not been unref */
+	if (prange->ttm_res) {
+		prange->ttm_res = NULL;
+		mutex_unlock(&prange->lock);
+		svm_range_bo_unref(prange->svm_bo);
+	} else
+		mutex_unlock(&prange->lock);
 }
 
 struct amdgpu_device *
@@ -691,7 +698,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			prange->flags &= ~attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
-			prange->granularity = attrs[i].value;
+			prange->granularity = min_t(uint32_t, attrs[i].value, 0x3F);
 			break;
 		default:
 			WARN_ONCE(1, "svm_range_check_attrs wasn't called?");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 317ddc807158..f5b257cb32cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1911,7 +1911,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	struct dmub_srv_create_params create_params;
 	struct dmub_srv_region_params region_params;
 	struct dmub_srv_region_info region_info;
-	struct dmub_srv_fb_params fb_params;
+	struct dmub_srv_memory_params memory_params;
 	struct dmub_srv_fb_info *fb_info;
 	struct dmub_srv *dmub_srv;
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -2021,6 +2021,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		adev->dm.dmub_fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 		PSP_HEADER_BYTES;
+	region_params.is_mailbox_in_inbox = false;
 
 	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
 					   &region_info);
@@ -2042,10 +2043,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return r;
 
 	/* Rebase the regions on the framebuffer address. */
-	memset(&fb_params, 0, sizeof(fb_params));
-	fb_params.cpu_addr = adev->dm.dmub_bo_cpu_addr;
-	fb_params.gpu_addr = adev->dm.dmub_bo_gpu_addr;
-	fb_params.region_info = &region_info;
+	memset(&memory_params, 0, sizeof(memory_params));
+	memory_params.cpu_fb_addr = adev->dm.dmub_bo_cpu_addr;
+	memory_params.gpu_fb_addr = adev->dm.dmub_bo_gpu_addr;
+	memory_params.region_info = &region_info;
 
 	adev->dm.dmub_fb_info =
 		kzalloc(sizeof(*adev->dm.dmub_fb_info), GFP_KERNEL);
@@ -2057,7 +2058,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -ENOMEM;
 	}
 
-	status = dmub_srv_calc_fb_info(dmub_srv, &fb_params, fb_info);
+	status = dmub_srv_calc_mem_info(dmub_srv, &memory_params, fb_info);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error calculating DMUB FB info: %d\n", status);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ffe7479a047d..3919e75fec16 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -886,7 +886,8 @@ static bool dc_construct(struct dc *dc,
 	/* set i2c speed if not done by the respective dcnxxx__resource.c */
 	if (dc->caps.i2c_speed_in_khz_hdcp == 0)
 		dc->caps.i2c_speed_in_khz_hdcp = dc->caps.i2c_speed_in_khz;
-
+	if (dc->caps.max_optimizable_video_width == 0)
+		dc->caps.max_optimizable_video_width = 5120;
 	dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc->res_pool->dccg);
 	if (!dc->clk_mgr)
 		goto fail;
@@ -2053,6 +2054,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 }
 
 static enum surface_update_type get_scaling_info_update_type(
+		const struct dc *dc,
 		const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
@@ -2087,6 +2089,12 @@ static enum surface_update_type get_scaling_info_update_type(
 			update_flags->bits.clock_change = 1;
 	}
 
+	if (u->scaling_info->src_rect.width > dc->caps.max_optimizable_video_width &&
+		(u->scaling_info->clip_rect.width > u->surface->clip_rect.width ||
+		 u->scaling_info->clip_rect.height > u->surface->clip_rect.height))
+		 /* Changing clip size of a large surface may result in MPC slice count change */
+		update_flags->bits.bandwidth_change = 1;
+
 	if (u->scaling_info->src_rect.x != u->surface->src_rect.x
 			|| u->scaling_info->src_rect.y != u->surface->src_rect.y
 			|| u->scaling_info->clip_rect.x != u->surface->clip_rect.x
@@ -2124,7 +2132,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	type = get_plane_info_update_type(u);
 	elevate_update_type(&overall_type, type);
 
-	type = get_scaling_info_update_type(u);
+	type = get_scaling_info_update_type(dc, u);
 	elevate_update_type(&overall_type, type);
 
 	if (u->flip_addr)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index f0f54f4d3d9b..5dd57cf170f5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -562,7 +562,7 @@ uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		return tg->funcs->get_frame_count(tg);
@@ -621,7 +621,7 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		tg->funcs->get_scanoutpos(tg,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e0f58fab5e8e..09a8726c2639 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -164,6 +164,11 @@ struct dc_caps {
 	uint32_t dmdata_alloc_size;
 	unsigned int max_cursor_size;
 	unsigned int max_video_width;
+	/*
+	 * max video plane width that can be safely assumed to be always
+	 * supported by single DPP pipe.
+	 */
+	unsigned int max_optimizable_video_width;
 	unsigned int min_horizontal_blanking_period;
 	int linear_pitch_alignment;
 	bool dcc_const_color;
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 0fc4f90d9e3e..96ceae1e199f 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -166,6 +166,7 @@ struct dmub_srv_region_params {
 	uint32_t vbios_size;
 	const uint8_t *fw_inst_const;
 	const uint8_t *fw_bss_data;
+	bool is_mailbox_in_inbox;
 };
 
 /**
@@ -185,20 +186,25 @@ struct dmub_srv_region_params {
  */
 struct dmub_srv_region_info {
 	uint32_t fb_size;
+	uint32_t inbox_size;
 	uint8_t num_regions;
 	struct dmub_region regions[DMUB_WINDOW_TOTAL];
 };
 
 /**
- * struct dmub_srv_fb_params - parameters used for driver fb setup
+ * struct dmub_srv_memory_params - parameters used for driver fb setup
  * @region_info: region info calculated by dmub service
- * @cpu_addr: base cpu address for the framebuffer
- * @gpu_addr: base gpu virtual address for the framebuffer
+ * @cpu_fb_addr: base cpu address for the framebuffer
+ * @cpu_inbox_addr: base cpu address for the gart
+ * @gpu_fb_addr: base gpu virtual address for the framebuffer
+ * @gpu_inbox_addr: base gpu virtual address for the gart
  */
-struct dmub_srv_fb_params {
+struct dmub_srv_memory_params {
 	const struct dmub_srv_region_info *region_info;
-	void *cpu_addr;
-	uint64_t gpu_addr;
+	void *cpu_fb_addr;
+	void *cpu_inbox_addr;
+	uint64_t gpu_fb_addr;
+	uint64_t gpu_inbox_addr;
 };
 
 /**
@@ -496,8 +502,8 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
  *   DMUB_STATUS_OK - success
  *   DMUB_STATUS_INVALID - unspecified error
  */
-enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
-				       const struct dmub_srv_fb_params *params,
+enum dmub_status dmub_srv_calc_mem_info(struct dmub_srv *dmub,
+				       const struct dmub_srv_memory_params *params,
 				       struct dmub_srv_fb_info *out);
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 75a91cfaf036..dc4ecbfbd4e8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -318,7 +318,7 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	uint32_t fw_state_size = DMUB_FW_STATE_SIZE;
 	uint32_t trace_buffer_size = DMUB_TRACE_BUFFER_SIZE;
 	uint32_t scratch_mem_size = DMUB_SCRATCH_MEM_SIZE;
-
+	uint32_t previous_top = 0;
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
 
@@ -343,8 +343,15 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	bios->base = dmub_align(stack->top, 256);
 	bios->top = bios->base + params->vbios_size;
 
-	mail->base = dmub_align(bios->top, 256);
-	mail->top = mail->base + DMUB_MAILBOX_SIZE;
+	if (params->is_mailbox_in_inbox) {
+		mail->base = 0;
+		mail->top = mail->base + DMUB_MAILBOX_SIZE;
+		previous_top = bios->top;
+	} else {
+		mail->base = dmub_align(bios->top, 256);
+		mail->top = mail->base + DMUB_MAILBOX_SIZE;
+		previous_top = mail->top;
+	}
 
 	fw_info = dmub_get_fw_meta_info(params);
 
@@ -363,7 +370,7 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 			dmub->fw_version = fw_info->fw_version;
 	}
 
-	trace_buff->base = dmub_align(mail->top, 256);
+	trace_buff->base = dmub_align(previous_top, 256);
 	trace_buff->top = trace_buff->base + dmub_align(trace_buffer_size, 64);
 
 	fw_state->base = dmub_align(trace_buff->top, 256);
@@ -374,11 +381,14 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 
 	out->fb_size = dmub_align(scratch_mem->top, 4096);
 
+	if (params->is_mailbox_in_inbox)
+		out->inbox_size = dmub_align(mail->top, 4096);
+
 	return DMUB_STATUS_OK;
 }
 
-enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
-				       const struct dmub_srv_fb_params *params,
+enum dmub_status dmub_srv_calc_mem_info(struct dmub_srv *dmub,
+				       const struct dmub_srv_memory_params *params,
 				       struct dmub_srv_fb_info *out)
 {
 	uint8_t *cpu_base;
@@ -393,8 +403,8 @@ enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
 	if (params->region_info->num_regions != DMUB_NUM_WINDOWS)
 		return DMUB_STATUS_INVALID;
 
-	cpu_base = (uint8_t *)params->cpu_addr;
-	gpu_base = params->gpu_addr;
+	cpu_base = (uint8_t *)params->cpu_fb_addr;
+	gpu_base = params->gpu_fb_addr;
 
 	for (i = 0; i < DMUB_NUM_WINDOWS; ++i) {
 		const struct dmub_region *reg =
@@ -402,6 +412,12 @@ enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
 
 		out->fb[i].cpu_addr = cpu_base + reg->base;
 		out->fb[i].gpu_addr = gpu_base + reg->base;
+
+		if (i == DMUB_WINDOW_4_MAILBOX && params->cpu_inbox_addr != 0) {
+			out->fb[i].cpu_addr = (uint8_t *)params->cpu_inbox_addr + reg->base;
+			out->fb[i].gpu_addr = params->gpu_inbox_addr + reg->base;
+		}
+
 		out->fb[i].size = reg->top - reg->base;
 	}
 
diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index 0b6a057e0a4c..5aac8d545bdc 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -78,7 +78,7 @@ typedef struct _ATOM_PPLIB_THERMALCONTROLLER
 typedef struct _ATOM_PPLIB_STATE
 {
     UCHAR ucNonClockStateIndex;
-    UCHAR ucClockStateIndices[1]; // variable-sized
+    UCHAR ucClockStateIndices[]; // variable-sized
 } ATOM_PPLIB_STATE;
 
 
@@ -473,7 +473,7 @@ typedef struct _ATOM_PPLIB_STATE_V2
       /**
       * Driver will read the first ucNumDPMLevels in this array
       */
-      UCHAR clockInfoIndex[1];
+      UCHAR clockInfoIndex[];
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 73794c1c1208..23f3cd9f2e8b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -807,7 +807,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	if (count > 127)
+	if (count > 127 || count == 0)
 		return -EINVAL;
 
 	if (*buf == 's')
@@ -827,7 +827,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	else
 		return -EINVAL;
 
-	memcpy(buf_cpy, buf, count+1);
+	memcpy(buf_cpy, buf, count);
+	buf_cpy[count] = 0;
 
 	tmp_str = buf_cpy;
 
@@ -844,6 +845,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 			return -EINVAL;
 		parameter_size++;
 
+		if (!tmp_str)
+			break;
+
 		while (isspace(*tmp_str))
 			tmp_str++;
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index b0ac4d121adc..e0e40b054c08 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
@@ -164,7 +164,7 @@ typedef struct _ATOM_Tonga_State {
 typedef struct _ATOM_Tonga_State_Array {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;		/* Number of entries. */
-	ATOM_Tonga_State entries[1];	/* Dynamically allocate entries. */
+	ATOM_Tonga_State entries[];	/* Dynamically allocate entries. */
 } ATOM_Tonga_State_Array;
 
 typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
@@ -179,7 +179,7 @@ typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
 typedef struct _ATOM_Tonga_MCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_MCLK_Dependency_Record entries[1];				/* Dynamically allocate entries. */
+	ATOM_Tonga_MCLK_Dependency_Record entries[];				/* Dynamically allocate entries. */
 } ATOM_Tonga_MCLK_Dependency_Table;
 
 typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
@@ -194,7 +194,7 @@ typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
 typedef struct _ATOM_Tonga_SCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_SCLK_Dependency_Record entries[1];				 /* Dynamically allocate entries. */
+	ATOM_Tonga_SCLK_Dependency_Record entries[];				 /* Dynamically allocate entries. */
 } ATOM_Tonga_SCLK_Dependency_Table;
 
 typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
@@ -210,7 +210,7 @@ typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
 typedef struct _ATOM_Polaris_SCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;							/* Number of entries. */
-	ATOM_Polaris_SCLK_Dependency_Record entries[1];				 /* Dynamically allocate entries. */
+	ATOM_Polaris_SCLK_Dependency_Record entries[];				 /* Dynamically allocate entries. */
 } ATOM_Polaris_SCLK_Dependency_Table;
 
 typedef struct _ATOM_Tonga_PCIE_Record {
@@ -222,7 +222,7 @@ typedef struct _ATOM_Tonga_PCIE_Record {
 typedef struct _ATOM_Tonga_PCIE_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_PCIE_Record entries[1];							/* Dynamically allocate entries. */
+	ATOM_Tonga_PCIE_Record entries[];							/* Dynamically allocate entries. */
 } ATOM_Tonga_PCIE_Table;
 
 typedef struct _ATOM_Polaris10_PCIE_Record {
@@ -235,7 +235,7 @@ typedef struct _ATOM_Polaris10_PCIE_Record {
 typedef struct _ATOM_Polaris10_PCIE_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Polaris10_PCIE_Record entries[1];                      /* Dynamically allocate entries. */
+	ATOM_Polaris10_PCIE_Record entries[];                      /* Dynamically allocate entries. */
 } ATOM_Polaris10_PCIE_Table;
 
 
@@ -252,7 +252,7 @@ typedef struct _ATOM_Tonga_MM_Dependency_Record {
 typedef struct _ATOM_Tonga_MM_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_MM_Dependency_Record entries[1]; 			   /* Dynamically allocate entries. */
+	ATOM_Tonga_MM_Dependency_Record entries[]; 			   /* Dynamically allocate entries. */
 } ATOM_Tonga_MM_Dependency_Table;
 
 typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
@@ -265,7 +265,7 @@ typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
 typedef struct _ATOM_Tonga_Voltage_Lookup_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_Voltage_Lookup_Record entries[1];				/* Dynamically allocate entries. */
+	ATOM_Tonga_Voltage_Lookup_Record entries[];				/* Dynamically allocate entries. */
 } ATOM_Tonga_Voltage_Lookup_Table;
 
 typedef struct _ATOM_Tonga_Fan_Table {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index e672b9cffee3..88b58153f9d6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -1223,7 +1223,7 @@ int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
 	return 0;
 }
 
-static void
+static int
 komeda_pipeline_unbound_components(struct komeda_pipeline *pipe,
 				   struct komeda_pipeline_state *new)
 {
@@ -1243,8 +1243,12 @@ komeda_pipeline_unbound_components(struct komeda_pipeline *pipe,
 		c = komeda_pipeline_get_component(pipe, id);
 		c_st = komeda_component_get_state_and_set_user(c,
 				drm_st, NULL, new->crtc);
+		if (PTR_ERR(c_st) == -EDEADLK)
+			return -EDEADLK;
 		WARN_ON(IS_ERR(c_st));
 	}
+
+	return 0;
 }
 
 /* release unclaimed pipeline resource */
@@ -1266,9 +1270,8 @@ int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
 	if (WARN_ON(IS_ERR_OR_NULL(st)))
 		return -EINVAL;
 
-	komeda_pipeline_unbound_components(pipe, st);
+	return komeda_pipeline_unbound_components(pipe, st);
 
-	return 0;
 }
 
 /* Since standalong disabled components must be disabled separately and in the
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 60f6a731f1bf..0eb4a0739fa2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -642,6 +642,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
 		if (idx >= pc->num_user_engines)
 			return -EINVAL;
 
+		idx = array_index_nospec(idx, pc->num_user_engines);
 		pe = &pc->user_engines[idx];
 
 		/* Only render engine supports RPCS configuration. */
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 774d45142091..f4d27ceafdce 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -3795,11 +3795,8 @@ int i915_perf_open_ioctl(struct drm_device *dev, void *data,
 	u32 known_open_flags;
 	int ret;
 
-	if (!perf->i915) {
-		drm_dbg(&perf->i915->drm,
-			"i915 perf interface not available for this system\n");
+	if (!perf->i915)
 		return -ENOTSUPP;
-	}
 
 	known_open_flags = I915_PERF_FLAG_FD_CLOEXEC |
 			   I915_PERF_FLAG_FD_NONBLOCK |
@@ -4090,11 +4087,8 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 	struct i915_oa_reg *regs;
 	int err, id;
 
-	if (!perf->i915) {
-		drm_dbg(&perf->i915->drm,
-			"i915 perf interface not available for this system\n");
+	if (!perf->i915)
 		return -ENOTSUPP;
-	}
 
 	if (!perf->metrics_kobj) {
 		drm_dbg(&perf->i915->drm,
@@ -4256,11 +4250,8 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
 	struct i915_oa_config *oa_config;
 	int ret;
 
-	if (!perf->i915) {
-		drm_dbg(&perf->i915->drm,
-			"i915 perf interface not available for this system\n");
+	if (!perf->i915)
 		return -ENOTSUPP;
-	}
 
 	if (i915_perf_stream_paranoid && !perfmon_capable()) {
 		drm_dbg(&perf->i915->drm,
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 62b742e701d2..f9d31069f484 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -263,26 +263,9 @@ int dp_panel_get_modes(struct dp_panel *dp_panel,
 
 static u8 dp_panel_get_edid_checksum(struct edid *edid)
 {
-	struct edid *last_block;
-	u8 *raw_edid;
-	bool is_edid_corrupt = false;
+	edid += edid->extensions;
 
-	if (!edid) {
-		DRM_ERROR("invalid edid input\n");
-		return 0;
-	}
-
-	raw_edid = (u8 *)edid;
-	raw_edid += (edid->extensions * EDID_LENGTH);
-	last_block = (struct edid *)raw_edid;
-
-	/* block type extension */
-	drm_edid_block_valid(raw_edid, 1, false, &is_edid_corrupt);
-	if (!is_edid_corrupt)
-		return last_block->checksum;
-
-	DRM_ERROR("Invalid block, no checksum\n");
-	return 0;
+	return edid->checksum;
 }
 
 void dp_panel_handle_sink_request(struct dp_panel *dp_panel)
diff --git a/drivers/gpu/drm/panel/panel-arm-versatile.c b/drivers/gpu/drm/panel/panel-arm-versatile.c
index abb0788843c6..503ecea72c5e 100644
--- a/drivers/gpu/drm/panel/panel-arm-versatile.c
+++ b/drivers/gpu/drm/panel/panel-arm-versatile.c
@@ -267,6 +267,8 @@ static int versatile_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = vpanel->panel_type->bus_flags;
 
 	mode = drm_mode_duplicate(connector->dev, &vpanel->panel_type->mode);
+	if (!mode)
+		return -ENOMEM;
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index a2c303e5732c..f50cc70e6337 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -428,29 +428,30 @@ static int st7703_prepare(struct drm_panel *panel)
 		return 0;
 
 	dev_dbg(ctx->dev, "Resetting the panel\n");
-	ret = regulator_enable(ctx->vcc);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	ret = regulator_enable(ctx->iovcc);
 	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to enable vcc supply: %d\n", ret);
+		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
 		return ret;
 	}
-	ret = regulator_enable(ctx->iovcc);
+
+	ret = regulator_enable(ctx->vcc);
 	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
-		goto disable_vcc;
+		dev_err(ctx->dev, "Failed to enable vcc supply: %d\n", ret);
+		regulator_disable(ctx->iovcc);
+		return ret;
 	}
 
-	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-	usleep_range(20, 40);
+	/* Give power supplies time to stabilize before deasserting reset. */
+	usleep_range(10000, 20000);
+
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
-	msleep(20);
+	usleep_range(15000, 20000);
 
 	ctx->prepared = true;
 
 	return 0;
-
-disable_vcc:
-	regulator_disable(ctx->vcc);
-	return ret;
 }
 
 static int st7703_get_modes(struct drm_panel *panel,
diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
index e3791dad6830..3360e7ccb0a7 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -379,6 +379,8 @@ static int tpg110_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = tpg->panel_mode->bus_flags;
 
 	mode = drm_mode_duplicate(connector->dev, &tpg->panel_mode->mode);
+	if (!mode)
+		return -ENOMEM;
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 9e0a1e836011..dc04412784a0 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1221,6 +1221,9 @@ int qxl_destroy_monitors_object(struct qxl_device *qdev)
 	if (!qdev->monitors_config_bo)
 		return 0;
 
+	kfree(qdev->dumb_heads);
+	qdev->dumb_heads = NULL;
+
 	qdev->monitors_config = NULL;
 	qdev->ram_header->monitors_config = 0;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5d53a5f9d123..872af7d4b3fc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -807,9 +807,9 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 	metadata->num_sizes = num_sizes;
 	user_srf->size = size;
 	metadata->sizes =
-		memdup_user((struct drm_vmw_size __user *)(unsigned long)
+		memdup_array_user((struct drm_vmw_size __user *)(unsigned long)
 			    req->size_addr,
-			    sizeof(*metadata->sizes) * metadata->num_sizes);
+			    metadata->num_sizes, sizeof(*metadata->sizes));
 	if (IS_ERR(metadata->sizes)) {
 		ret = PTR_ERR(metadata->sizes);
 		goto out_no_sizes;
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5fceefb3c707..caca5d6e95d6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -349,6 +349,7 @@
 
 #define USB_VENDOR_ID_DELL				0x413c
 #define USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE	0x301a
+#define USB_DEVICE_ID_DELL_PRO_WIRELESS_KM5221W		0x4503
 
 #define USB_VENDOR_ID_DELORME		0x1163
 #define USB_DEVICE_ID_DELORME_EARTHMATE	0x0100
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 93b1f935e526..901c1959efed 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -50,7 +50,12 @@ struct lenovo_drvdata {
 	int select_right;
 	int sensitivity;
 	int press_speed;
-	u8 middlebutton_state; /* 0:Up, 1:Down (undecided), 2:Scrolling */
+	/* 0: Up
+	 * 1: Down (undecided)
+	 * 2: Scrolling
+	 * 3: Patched firmware, disable workaround
+	 */
+	u8 middlebutton_state;
 	bool fn_lock;
 };
 
@@ -529,31 +534,48 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
 {
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	/* "wheel" scroll events */
-	if (usage->type == EV_REL && (usage->code == REL_WHEEL ||
-			usage->code == REL_HWHEEL)) {
-		/* Scroll events disable middle-click event */
-		cptkbd_data->middlebutton_state = 2;
-		return 0;
-	}
+	if (cptkbd_data->middlebutton_state != 3) {
+		/* REL_X and REL_Y events during middle button pressed
+		 * are only possible on patched, bug-free firmware
+		 * so set middlebutton_state to 3
+		 * to never apply workaround anymore
+		 */
+		if (cptkbd_data->middlebutton_state == 1 &&
+				usage->type == EV_REL &&
+				(usage->code == REL_X || usage->code == REL_Y)) {
+			cptkbd_data->middlebutton_state = 3;
+			/* send middle button press which was hold before */
+			input_event(field->hidinput->input,
+				EV_KEY, BTN_MIDDLE, 1);
+			input_sync(field->hidinput->input);
+		}
 
-	/* Middle click events */
-	if (usage->type == EV_KEY && usage->code == BTN_MIDDLE) {
-		if (value == 1) {
-			cptkbd_data->middlebutton_state = 1;
-		} else if (value == 0) {
-			if (cptkbd_data->middlebutton_state == 1) {
-				/* No scrolling inbetween, send middle-click */
-				input_event(field->hidinput->input,
-					EV_KEY, BTN_MIDDLE, 1);
-				input_sync(field->hidinput->input);
-				input_event(field->hidinput->input,
-					EV_KEY, BTN_MIDDLE, 0);
-				input_sync(field->hidinput->input);
+		/* "wheel" scroll events */
+		if (usage->type == EV_REL && (usage->code == REL_WHEEL ||
+				usage->code == REL_HWHEEL)) {
+			/* Scroll events disable middle-click event */
+			cptkbd_data->middlebutton_state = 2;
+			return 0;
+		}
+
+		/* Middle click events */
+		if (usage->type == EV_KEY && usage->code == BTN_MIDDLE) {
+			if (value == 1) {
+				cptkbd_data->middlebutton_state = 1;
+			} else if (value == 0) {
+				if (cptkbd_data->middlebutton_state == 1) {
+					/* No scrolling inbetween, send middle-click */
+					input_event(field->hidinput->input,
+						EV_KEY, BTN_MIDDLE, 1);
+					input_sync(field->hidinput->input);
+					input_event(field->hidinput->input,
+						EV_KEY, BTN_MIDDLE, 0);
+					input_sync(field->hidinput->input);
+				}
+				cptkbd_data->middlebutton_state = 0;
 			}
-			cptkbd_data->middlebutton_state = 0;
+			return 1;
 		}
-		return 1;
 	}
 
 	return 0;
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 96ca7d981ee2..225138a39d32 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -66,6 +66,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_STRAFE), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_PRO_WIRELESS_KM5221W), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES), HID_QUIRK_MULTI_INPUT },
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index b79e1380ff68..5ceb81319634 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -456,10 +456,16 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 
 		/*
 		 * Because we don't know the buffer length in the
-		 * I2C_FUNC_SMBUS_BLOCK_DATA case, we can't stop
-		 * the transaction here.
+		 * I2C_FUNC_SMBUS_BLOCK_DATA case, we can't stop the
+		 * transaction here. Also disable the TX_EMPTY IRQ
+		 * while waiting for the data length byte to avoid the
+		 * bogus interrupts flood.
 		 */
-		if (buf_len > 0 || flags & I2C_M_RECV_LEN) {
+		if (flags & I2C_M_RECV_LEN) {
+			dev->status |= STATUS_WRITE_IN_PROGRESS;
+			intr_mask &= ~DW_IC_INTR_TX_EMPTY;
+			break;
+		} else if (buf_len > 0) {
 			/* more bytes to be written */
 			dev->status |= STATUS_WRITE_IN_PROGRESS;
 			break;
@@ -495,6 +501,13 @@ i2c_dw_recv_len(struct dw_i2c_dev *dev, u8 len)
 	msgs[dev->msg_read_idx].len = len;
 	msgs[dev->msg_read_idx].flags &= ~I2C_M_RECV_LEN;
 
+	/*
+	 * Received buffer length, re-enable TX_EMPTY interrupt
+	 * to resume the SMBUS transaction.
+	 */
+	regmap_update_bits(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_TX_EMPTY,
+			   DW_IC_INTR_TX_EMPTY);
+
 	return len;
 }
 
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 656e2acf3cd9..30b725d11178 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -702,15 +702,11 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		return i801_check_post(priv, result ? priv->status : -ETIMEDOUT);
 	}
 
-	for (i = 1; i <= len; i++) {
-		if (i == len && read_write == I2C_SMBUS_READ)
-			smbcmd |= SMBHSTCNT_LAST_BYTE;
-		outb_p(smbcmd, SMBHSTCNT(priv));
-
-		if (i == 1)
-			outb_p(inb(SMBHSTCNT(priv)) | SMBHSTCNT_START,
-			       SMBHSTCNT(priv));
+	if (len == 1 && read_write == I2C_SMBUS_READ)
+		smbcmd |= SMBHSTCNT_LAST_BYTE;
+	outb_p(smbcmd | SMBHSTCNT_START, SMBHSTCNT(priv));
 
+	for (i = 1; i <= len; i++) {
 		status = i801_wait_byte_done(priv);
 		if (status)
 			goto exit;
@@ -733,9 +729,12 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 			data->block[0] = len;
 		}
 
-		/* Retrieve/store value in SMBBLKDAT */
-		if (read_write == I2C_SMBUS_READ)
+		if (read_write == I2C_SMBUS_READ) {
 			data->block[i] = inb_p(SMBBLKDAT(priv));
+			if (i == len - 1)
+				outb_p(smbcmd | SMBHSTCNT_LAST_BYTE, SMBHSTCNT(priv));
+		}
+
 		if (read_write == I2C_SMBUS_WRITE && i+1 <= len)
 			outb_p(data->block[i+1], SMBBLKDAT(priv));
 
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index a636ea0eb50a..35ca2c02c9b9 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -264,6 +264,9 @@ struct pxa_i2c {
 	u32			hs_mask;
 
 	struct i2c_bus_recovery_info recovery;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pinctrl_default;
+	struct pinctrl_state	*pinctrl_recovery;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -1302,12 +1305,13 @@ static void i2c_pxa_prepare_recovery(struct i2c_adapter *adap)
 	 */
 	gpiod_set_value(i2c->recovery.scl_gpiod, ibmr & IBMR_SCLS);
 	gpiod_set_value(i2c->recovery.sda_gpiod, ibmr & IBMR_SDAS);
+
+	WARN_ON(pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_recovery));
 }
 
 static void i2c_pxa_unprepare_recovery(struct i2c_adapter *adap)
 {
 	struct pxa_i2c *i2c = adap->algo_data;
-	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 	u32 isr;
 
 	/*
@@ -1321,7 +1325,7 @@ static void i2c_pxa_unprepare_recovery(struct i2c_adapter *adap)
 		i2c_pxa_do_reset(i2c);
 	}
 
-	WARN_ON(pinctrl_select_state(bri->pinctrl, bri->pins_default));
+	WARN_ON(pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_default));
 
 	dev_dbg(&i2c->adap.dev, "recovery: IBMR 0x%08x ISR 0x%08x\n",
 	        readl(_IBMR(i2c)), readl(_ISR(i2c)));
@@ -1343,20 +1347,76 @@ static int i2c_pxa_init_recovery(struct pxa_i2c *i2c)
 	if (IS_ENABLED(CONFIG_I2C_PXA_SLAVE))
 		return 0;
 
-	bri->pinctrl = devm_pinctrl_get(dev);
-	if (PTR_ERR(bri->pinctrl) == -ENODEV) {
-		bri->pinctrl = NULL;
+	i2c->pinctrl = devm_pinctrl_get(dev);
+	if (PTR_ERR(i2c->pinctrl) == -ENODEV)
+		i2c->pinctrl = NULL;
+	if (IS_ERR(i2c->pinctrl))
+		return PTR_ERR(i2c->pinctrl);
+
+	if (!i2c->pinctrl)
+		return 0;
+
+	i2c->pinctrl_default = pinctrl_lookup_state(i2c->pinctrl,
+						    PINCTRL_STATE_DEFAULT);
+	i2c->pinctrl_recovery = pinctrl_lookup_state(i2c->pinctrl, "recovery");
+
+	if (IS_ERR(i2c->pinctrl_default) || IS_ERR(i2c->pinctrl_recovery)) {
+		dev_info(dev, "missing pinmux recovery information: %ld %ld\n",
+			 PTR_ERR(i2c->pinctrl_default),
+			 PTR_ERR(i2c->pinctrl_recovery));
+		return 0;
+	}
+
+	/*
+	 * Claiming GPIOs can influence the pinmux state, and may glitch the
+	 * I2C bus. Do this carefully.
+	 */
+	bri->scl_gpiod = devm_gpiod_get(dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
+	if (bri->scl_gpiod == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+	if (IS_ERR(bri->scl_gpiod)) {
+		dev_info(dev, "missing scl gpio recovery information: %pe\n",
+			 bri->scl_gpiod);
+		return 0;
+	}
+
+	/*
+	 * We have SCL. Pull SCL low and wait a bit so that SDA glitches
+	 * have no effect.
+	 */
+	gpiod_direction_output(bri->scl_gpiod, 0);
+	udelay(10);
+	bri->sda_gpiod = devm_gpiod_get(dev, "sda", GPIOD_OUT_HIGH_OPEN_DRAIN);
+
+	/* Wait a bit in case of a SDA glitch, and then release SCL. */
+	udelay(10);
+	gpiod_direction_output(bri->scl_gpiod, 1);
+
+	if (bri->sda_gpiod == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+
+	if (IS_ERR(bri->sda_gpiod)) {
+		dev_info(dev, "missing sda gpio recovery information: %pe\n",
+			 bri->sda_gpiod);
 		return 0;
 	}
-	if (IS_ERR(bri->pinctrl))
-		return PTR_ERR(bri->pinctrl);
 
 	bri->prepare_recovery = i2c_pxa_prepare_recovery;
 	bri->unprepare_recovery = i2c_pxa_unprepare_recovery;
+	bri->recover_bus = i2c_generic_scl_recovery;
 
 	i2c->adap.bus_recovery_info = bri;
 
-	return 0;
+	/*
+	 * Claiming GPIOs can change the pinmux state, which confuses the
+	 * pinctrl since pinctrl's idea of the current setting is unaffected
+	 * by the pinmux change caused by claiming the GPIO. Work around that
+	 * by switching pinctrl to the GPIO state here. We do it this way to
+	 * avoid glitching the I2C bus.
+	 */
+	pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_recovery);
+
+	return pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_default);
 }
 
 static int i2c_pxa_probe(struct platform_device *dev)
diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 9e3483f507ff..f2ed13b55108 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -201,6 +201,11 @@ static int p2wi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (clk_freq == 0) {
+		dev_err(dev, "clock-frequency is set to 0 in DT\n");
+		return -EINVAL;
+	}
+
 	if (of_get_child_count(np) > 1) {
 		dev_err(dev, "P2WI only supports one slave device\n");
 		return -EINVAL;
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 8ce261167a2d..ea17f13b44c8 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -29,7 +29,7 @@ int i2c_dev_irq_from_resources(const struct resource *resources,
  */
 static inline bool i2c_in_atomic_xfer_mode(void)
 {
-	return system_state > SYSTEM_RUNNING && irqs_disabled();
+	return system_state > SYSTEM_RUNNING && !preemptible();
 }
 
 static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 6fd2b6718b08..9fefceb3a95d 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -450,8 +450,8 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (rdwr_arg.nmsgs > I2C_RDWR_IOCTL_MAX_MSGS)
 			return -EINVAL;
 
-		rdwr_pa = memdup_user(rdwr_arg.msgs,
-				      rdwr_arg.nmsgs * sizeof(struct i2c_msg));
+		rdwr_pa = memdup_array_user(rdwr_arg.msgs,
+					    rdwr_arg.nmsgs, sizeof(struct i2c_msg));
 		if (IS_ERR(rdwr_pa))
 			return PTR_ERR(rdwr_pa);
 
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 5b37ffe5ad5b..4a49c75a9408 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -192,7 +192,7 @@
 #define SLV_STATUS1_HJ_DIS		BIT(18)
 #define SLV_STATUS1_MR_DIS		BIT(17)
 #define SLV_STATUS1_PROT_ERR		BIT(16)
-#define SLV_STATUS1_DA(x)		(((s) & GENMASK(15, 9)) >> 9)
+#define SLV_STATUS1_DA(s)		(((s) & GENMASK(15, 9)) >> 9)
 #define SLV_STATUS1_HAS_DA		BIT(8)
 #define SLV_STATUS1_DDR_RX_FULL		BIT(7)
 #define SLV_STATUS1_DDR_TX_FULL		BIT(6)
@@ -1624,13 +1624,13 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	/* Device ID0 is reserved to describe this master. */
 	master->maxdevs = CONF_STATUS0_DEVS_NUM(val);
 	master->free_rr_slots = GENMASK(master->maxdevs, 1);
+	master->caps.ibirfifodepth = CONF_STATUS0_IBIR_DEPTH(val);
+	master->caps.cmdrfifodepth = CONF_STATUS0_CMDR_DEPTH(val);
 
 	val = readl(master->regs + CONF_STATUS1);
 	master->caps.cmdfifodepth = CONF_STATUS1_CMD_DEPTH(val);
 	master->caps.rxfifodepth = CONF_STATUS1_RX_DEPTH(val);
 	master->caps.txfifodepth = CONF_STATUS1_TX_DEPTH(val);
-	master->caps.ibirfifodepth = CONF_STATUS0_IBIR_DEPTH(val);
-	master->caps.cmdrfifodepth = CONF_STATUS0_CMDR_DEPTH(val);
 
 	spin_lock_init(&master->ibi.lock);
 	master->ibi.num_slots = CONF_STATUS1_IBI_HW_RES(val);
diff --git a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
index 97bb49ff5b53..47b9b4d4ed3f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
@@ -64,15 +64,17 @@ static int hci_dat_v1_init(struct i3c_hci *hci)
 		return -EOPNOTSUPP;
 	}
 
-	/* use a bitmap for faster free slot search */
-	hci->DAT_data = bitmap_zalloc(hci->DAT_entries, GFP_KERNEL);
-	if (!hci->DAT_data)
-		return -ENOMEM;
-
-	/* clear them */
-	for (dat_idx = 0; dat_idx < hci->DAT_entries; dat_idx++) {
-		dat_w0_write(dat_idx, 0);
-		dat_w1_write(dat_idx, 0);
+	if (!hci->DAT_data) {
+		/* use a bitmap for faster free slot search */
+		hci->DAT_data = bitmap_zalloc(hci->DAT_entries, GFP_KERNEL);
+		if (!hci->DAT_data)
+			return -ENOMEM;
+
+		/* clear them */
+		for (dat_idx = 0; dat_idx < hci->DAT_entries; dat_idx++) {
+			dat_w0_write(dat_idx, 0);
+			dat_w1_write(dat_idx, 0);
+		}
 	}
 
 	return 0;
@@ -87,7 +89,13 @@ static void hci_dat_v1_cleanup(struct i3c_hci *hci)
 static int hci_dat_v1_alloc_entry(struct i3c_hci *hci)
 {
 	unsigned int dat_idx;
+	int ret;
 
+	if (!hci->DAT_data) {
+		ret = hci_dat_v1_init(hci);
+		if (ret)
+			return ret;
+	}
 	dat_idx = find_first_zero_bit(hci->DAT_data, hci->DAT_entries);
 	if (dat_idx >= hci->DAT_entries)
 		return -ENOENT;
@@ -103,7 +111,8 @@ static void hci_dat_v1_free_entry(struct i3c_hci *hci, unsigned int dat_idx)
 {
 	dat_w0_write(dat_idx, 0);
 	dat_w1_write(dat_idx, 0);
-	__clear_bit(dat_idx, hci->DAT_data);
+	if (hci->DAT_data)
+		__clear_bit(dat_idx, hci->DAT_data);
 }
 
 static void hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index af873a9be050..dd2dc0039960 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -734,7 +734,7 @@ static bool hci_dma_irq_handler(struct i3c_hci *hci, unsigned int mask)
 	unsigned int i;
 	bool handled = false;
 
-	for (i = 0; mask && i < 8; i++) {
+	for (i = 0; mask && i < rings->total; i++) {
 		struct hci_rh_data *rh;
 		u32 status;
 
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d495c6186381..15a412e88dd5 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -165,6 +165,7 @@ struct svc_i3c_xfer {
  * @ibi.slots: Available IBI slots
  * @ibi.tbq_slot: To be queued IBI slot
  * @ibi.lock: IBI lock
+ * @lock: Transfer lock, protect between IBI work thread and callbacks from master
  */
 struct svc_i3c_master {
 	struct i3c_master_controller base;
@@ -192,6 +193,7 @@ struct svc_i3c_master {
 		/* Prevent races within IBI handlers */
 		spinlock_t lock;
 	} ibi;
+	struct mutex lock;
 };
 
 /**
@@ -292,6 +294,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	struct i3c_ibi_slot *slot;
 	unsigned int count;
 	u32 mdatactrl;
+	int ret, val;
 	u8 *buf;
 
 	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
@@ -301,6 +304,13 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	slot->len = 0;
 	buf = slot->data;
 
+	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
+						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
+	if (ret) {
+		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
+		return ret;
+	}
+
 	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
@@ -345,6 +355,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	u32 status, val;
 	int ret;
 
+	mutex_lock(&master->lock);
 	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
 	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
 	       SVC_I3C_MCTRL_IBIRESP_AUTO,
@@ -355,6 +366,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for IBIWON\n");
+		svc_i3c_master_emit_stop(master);
 		goto reenable_ibis;
 	}
 
@@ -421,12 +433,13 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 
 reenable_ibis:
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
+	mutex_unlock(&master->lock);
 }
 
 static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 {
 	struct svc_i3c_master *master = (struct svc_i3c_master *)dev_id;
-	u32 active = readl(master->regs + SVC_I3C_MINTMASKED);
+	u32 active = readl(master->regs + SVC_I3C_MSTATUS);
 
 	if (!SVC_I3C_MSTATUS_SLVSTART(active))
 		return IRQ_NONE;
@@ -926,6 +939,9 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	u32 reg;
 	int ret;
 
+	/* clean SVC_I3C_MINT_IBIWON w1c bits */
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
 	       xfer_type |
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
@@ -939,6 +955,23 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (ret)
 		goto emit_stop;
 
+	/*
+	 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a Frame
+	 * with I3C Target Address.
+	 *
+	 * The I3C Controller normally should start a Frame, the Address may be arbitrated, and so
+	 * the Controller shall monitor to see whether an In-Band Interrupt request, a Controller
+	 * Role Request (i.e., Secondary Controller requests to become the Active Controller), or
+	 * a Hot-Join Request has been made.
+	 *
+	 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, return failure
+	 * and yield the above events handler.
+	 */
+	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
@@ -1095,9 +1128,11 @@ static int svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
 	cmd->read_len = 0;
 	cmd->continued = false;
 
+	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
+	mutex_unlock(&master->lock);
 
 	ret = xfer->ret;
 	kfree(buf);
@@ -1141,9 +1176,11 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->read_len = read_len;
 	cmd->continued = false;
 
+	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
+	mutex_unlock(&master->lock);
 
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
@@ -1197,9 +1234,11 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 		cmd->continued = (i + 1) < nxfers;
 	}
 
+	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
+	mutex_unlock(&master->lock);
 
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
@@ -1235,9 +1274,11 @@ static int svc_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 		cmd->continued = (i + 1 < nxfers);
 	}
 
+	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
+	mutex_unlock(&master->lock);
 
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
@@ -1407,6 +1448,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
 	INIT_WORK(&master->hj_work, svc_i3c_master_hj_work);
 	INIT_WORK(&master->ibi_work, svc_i3c_master_ibi_work);
+	mutex_init(&master->lock);
+
 	ret = devm_request_irq(dev, master->irq, svc_i3c_master_irq_handler,
 			       IRQF_NO_SUSPEND, "svc-i3c-irq", master);
 	if (ret)
diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index a0802332c8cb..5395cf56fbd9 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2015 - 2019 Intel Corporation.
  */
 
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -212,12 +213,6 @@ static u32 extract_speed(u16 linkstat)
 	return speed;
 }
 
-/* return the PCIe link speed from the given link status */
-static u32 extract_width(u16 linkstat)
-{
-	return (linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
-}
-
 /* read the link status and set dd->{lbus_width,lbus_speed,lbus_info} */
 static void update_lbus_info(struct hfi1_devdata *dd)
 {
@@ -230,7 +225,7 @@ static void update_lbus_info(struct hfi1_devdata *dd)
 		return;
 	}
 
-	dd->lbus_width = extract_width(linkstat);
+	dd->lbus_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);
 	dd->lbus_speed = extract_speed(linkstat);
 	snprintf(dd->lbus_info, sizeof(dd->lbus_info),
 		 "PCIe,%uMHz,x%u", dd->lbus_speed, dd->lbus_width);
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 8341ea7c4eb6..a87af6a89508 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -449,6 +449,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
+	XPAD_XBOXONE_VENDOR(0x10f5),		/* Turtle Beach Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
 	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index ce58d34b06d0..5f949e26d837 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -246,6 +246,7 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev)
 	return 0;
 
 out:
+	put_device(&dev->dev);
 
 	return ret;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 656b6b71c768..1ae37e693de0 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -106,7 +106,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	return 0;
 
 err:
-	put_device(&mdev->dev);
+	mcb_free_dev(mdev);
 
 	return ret;
 }
diff --git a/drivers/media/cec/platform/Makefile b/drivers/media/cec/platform/Makefile
index ea6f8ee8161c..e5e441faa0ba 100644
--- a/drivers/media/cec/platform/Makefile
+++ b/drivers/media/cec/platform/Makefile
@@ -6,7 +6,7 @@
 # Please keep it in alphabetic order
 obj-$(CONFIG_CEC_CROS_EC)	+= cros-ec/
 obj-$(CONFIG_CEC_GPIO)		+= cec-gpio/
-obj-$(CONFIG_CEC_MESON_AO)	+= meson/
+obj-y				+= meson/
 obj-$(CONFIG_CEC_SAMSUNG_S5P)	+= s5p/
 obj-$(CONFIG_CEC_SECO)		+= seco/
 obj-$(CONFIG_CEC_STI)		+= sti/
diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 67bb770ed63f..9dc5d42b3199 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3089,7 +3089,7 @@ static int ccs_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 		try_fmt->code = sensor->internal_csi_format->code;
 		try_fmt->field = V4L2_FIELD_NONE;
 
-		if (ssd != sensor->pixel_array)
+		if (ssd == sensor->pixel_array)
 			continue;
 
 		try_comp = v4l2_subdev_get_try_compose(sd, fh->state, i);
diff --git a/drivers/media/i2c/ccs/ccs-quirk.h b/drivers/media/i2c/ccs/ccs-quirk.h
index 5838fcda92fd..0b1a64958d71 100644
--- a/drivers/media/i2c/ccs/ccs-quirk.h
+++ b/drivers/media/i2c/ccs/ccs-quirk.h
@@ -32,12 +32,10 @@ struct ccs_sensor;
  *		@reg: Pointer to the register to access
  *		@value: Register value, set by the caller on write, or
  *			by the quirk on read
- *
- * @flags: Quirk flags
- *
  *		@return: 0 on success, -ENOIOCTLCMD if no register
  *			 access may be done by the caller (default read
  *			 value is zero), else negative error code on error
+ * @flags: Quirk flags
  */
 struct ccs_quirk {
 	int (*limits)(struct ccs_sensor *sensor);
diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index 16af58f2f93c..f9cee061517b 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -8,6 +8,7 @@
  *  All rights reserved.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <media/i2c/adv7604.h>
 #include <media/i2c/adv7842.h>
@@ -210,17 +211,17 @@ void cobalt_pcie_status_show(struct cobalt *cobalt)
 	pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &stat);
 	cobalt_info("PCIe link capability 0x%08x: %s per lane and %u lanes\n",
 			capa, get_link_speed(capa),
-			(capa & PCI_EXP_LNKCAP_MLW) >> 4);
+			FIELD_GET(PCI_EXP_LNKCAP_MLW, capa));
 	cobalt_info("PCIe link control 0x%04x\n", ctrl);
 	cobalt_info("PCIe link status 0x%04x: %s per lane and %u lanes\n",
 		    stat, get_link_speed(stat),
-		    (stat & PCI_EXP_LNKSTA_NLW) >> 4);
+		    FIELD_GET(PCI_EXP_LNKSTA_NLW, stat));
 
 	/* Bus */
 	pcie_capability_read_dword(pci_bus_dev, PCI_EXP_LNKCAP, &capa);
 	cobalt_info("PCIe bus link capability 0x%08x: %s per lane and %u lanes\n",
 			capa, get_link_speed(capa),
-			(capa & PCI_EXP_LNKCAP_MLW) >> 4);
+			FIELD_GET(PCI_EXP_LNKCAP_MLW, capa));
 
 	/* Slot */
 	pcie_capability_read_dword(pci_dev, PCI_EXP_SLTCAP, &capa);
@@ -239,7 +240,7 @@ static unsigned pcie_link_get_lanes(struct cobalt *cobalt)
 	if (!pci_is_pcie(pci_dev))
 		return 0;
 	pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &link);
-	return (link & PCI_EXP_LNKSTA_NLW) >> 4;
+	return FIELD_GET(PCI_EXP_LNKSTA_NLW, link);
 }
 
 static unsigned pcie_bus_link_get_lanes(struct cobalt *cobalt)
@@ -250,7 +251,7 @@ static unsigned pcie_bus_link_get_lanes(struct cobalt *cobalt)
 	if (!pci_is_pcie(pci_dev))
 		return 0;
 	pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &link);
-	return (link & PCI_EXP_LNKCAP_MLW) >> 4;
+	return FIELD_GET(PCI_EXP_LNKCAP_MLW, link);
 }
 
 static void msi_config_show(struct cobalt *cobalt, struct pci_dev *pci_dev)
diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index f2b4ddd31177..292061090444 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -407,8 +407,10 @@ static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
 							   fwh,
 							   struct v4l2_async_subdev);
 	of_node_put(ep);
-	if (IS_ERR(asd))
+	if (IS_ERR(asd)) {
+		v4l2_async_notifier_cleanup(&csi2rx->notifier);
 		return PTR_ERR(asd);
+	}
 
 	csi2rx->notifier.ops = &csi2rx_notifier_ops;
 
@@ -471,6 +473,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	return 0;
 
 err_cleanup:
+	v4l2_async_notifier_unregister(&csi2rx->notifier);
 	v4l2_async_notifier_cleanup(&csi2rx->notifier);
 err_free_priv:
 	kfree(csi2rx);
@@ -481,6 +484,8 @@ static int csi2rx_remove(struct platform_device *pdev)
 {
 	struct csi2rx_priv *csi2rx = platform_get_drvdata(pdev);
 
+	v4l2_async_notifier_unregister(&csi2rx->notifier);
+	v4l2_async_notifier_cleanup(&csi2rx->notifier);
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
 	kfree(csi2rx);
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 02cb8005504a..af264c1f7b0e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2020-2021 Linaro Ltd.
  */
 
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -498,35 +497,20 @@ static int vfe_enable_output(struct vfe_line *line)
 	return 0;
 }
 
-static int vfe_disable_output(struct vfe_line *line)
+static void vfe_disable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
 	unsigned long flags;
 	unsigned int i;
-	bool done;
-	int timeout = 0;
-
-	do {
-		spin_lock_irqsave(&vfe->output_lock, flags);
-		done = !output->gen2.active_num;
-		spin_unlock_irqrestore(&vfe->output_lock, flags);
-		usleep_range(10000, 20000);
-
-		if (timeout++ == 100) {
-			dev_err(vfe->camss->dev, "VFE idle timeout - resetting\n");
-			vfe_reset(vfe);
-			output->gen2.active_num = 0;
-			return 0;
-		}
-	} while (!done);
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
 	for (i = 0; i < output->wm_num; i++)
 		vfe_wm_stop(vfe, output->wm_idx[i]);
+	output->gen2.active_num = 0;
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 
-	return 0;
+	vfe_reset(vfe);
 }
 
 /*
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index e0f3a36f3f3f..8beea27004ca 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -533,7 +533,8 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
 		struct camss_clock *clock = &vfe->clock[i];
 
 		if (!strcmp(clock->name, "vfe0") ||
-		    !strcmp(clock->name, "vfe1")) {
+		    !strcmp(clock->name, "vfe1") ||
+		    !strcmp(clock->name, "vfe_lite")) {
 			u64 min_rate = 0;
 			unsigned long rate;
 
@@ -607,7 +608,7 @@ static int vfe_get(struct vfe_device *vfe)
 	} else {
 		ret = vfe_check_clock_rates(vfe);
 		if (ret < 0)
-			goto error_pm_runtime_get;
+			goto error_pm_domain;
 	}
 	vfe->power_count++;
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index ef100d5f7763..e53f575b32f5 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1369,6 +1369,12 @@ static int camss_probe(struct platform_device *pdev)
 		goto err_cleanup;
 	}
 
+	ret = camss_configure_pd(camss);
+	if (ret < 0) {
+		dev_err(dev, "Failed to configure power domains: %d\n", ret);
+		goto err_cleanup;
+	}
+
 	ret = camss_init_subdevices(camss);
 	if (ret < 0)
 		goto err_cleanup;
@@ -1421,12 +1427,6 @@ static int camss_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = camss_configure_pd(camss);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure power domains: %d\n", ret);
-		return ret;
-	}
-
 	pm_runtime_enable(dev);
 
 	return 0;
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 9a2bdb002edc..68f208e3071d 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -367,7 +367,7 @@ session_get_prop_buf_req(struct hfi_msg_session_property_info_pkt *pkt,
 		memcpy(&bufreq[idx], buf_req, sizeof(*bufreq));
 		idx++;
 
-		if (idx > HFI_BUFFER_TYPE_MAX)
+		if (idx >= HFI_BUFFER_TYPE_MAX)
 			return HFI_ERR_SESSION_INVALID_PARAMETER;
 
 		req_bytes -= sizeof(struct hfi_buffer_requirements);
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 5b8389b98299..a04673d2c3ed 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -19,6 +19,9 @@ static void init_codecs(struct venus_core *core)
 	struct hfi_plat_caps *caps = core->caps, *cap;
 	unsigned long bit;
 
+	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
+		return;
+
 	for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
 		cap = &caps[core->codecs_count++];
 		cap->codec = BIT(bit);
@@ -86,6 +89,9 @@ static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
 {
 	const struct hfi_profile_level *pl = data;
 
+	if (cap->num_pl + num >= HFI_MAX_PROFILE_COUNT)
+		return;
+
 	memcpy(&cap->pl[cap->num_pl], pl, num * sizeof(*pl));
 	cap->num_pl += num;
 }
@@ -111,6 +117,9 @@ fill_caps(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 {
 	const struct hfi_capability *caps = data;
 
+	if (cap->num_caps + num >= MAX_CAP_ENTRIES)
+		return;
+
 	memcpy(&cap->caps[cap->num_caps], caps, num * sizeof(*caps));
 	cap->num_caps += num;
 }
@@ -137,6 +146,9 @@ static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
 {
 	const struct raw_formats *formats = fmts;
 
+	if (cap->num_fmts + num_fmts >= MAX_FMT_ENTRIES)
+		return;
+
 	memcpy(&cap->fmts[cap->num_fmts], formats, num_fmts * sizeof(*formats));
 	cap->num_fmts += num_fmts;
 }
@@ -159,6 +171,9 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 		rawfmts[i].buftype = fmt->buffer_type;
 		i++;
 
+		if (i >= MAX_FMT_ENTRIES)
+			return;
+
 		if (pinfo->num_planes > MAX_PLANES)
 			break;
 
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index c1e44cd2ef6d..9dd715af2379 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -205,6 +205,11 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 
 	new_wr_idx = wr_idx + dwords;
 	wr_ptr = (u32 *)(queue->qmem.kva + (wr_idx << 2));
+
+	if (wr_ptr < (u32 *)queue->qmem.kva ||
+	    wr_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*wr_ptr)))
+		return -EINVAL;
+
 	if (new_wr_idx < qsize) {
 		memcpy(wr_ptr, packet, dwords << 2);
 	} else {
@@ -272,6 +277,11 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 	}
 
 	rd_ptr = (u32 *)(queue->qmem.kva + (rd_idx << 2));
+
+	if (rd_ptr < (u32 *)queue->qmem.kva ||
+	    rd_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*rd_ptr)))
+		return -EINVAL;
+
 	dwords = *rd_ptr >> 2;
 	if (!dwords)
 		return -EINVAL;
diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 72e4bb0fb71e..4e7c3d889d5c 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -2427,6 +2427,12 @@ static int imon_probe(struct usb_interface *interface,
 		goto fail;
 	}
 
+	if (first_if->dev.driver != interface->dev.driver) {
+		dev_err(&interface->dev, "inconsistent driver matching\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
 	if (ifnum == 0) {
 		ictx = imon_init_intf0(interface, id);
 		if (!ictx) {
diff --git a/drivers/media/rc/ir-sharp-decoder.c b/drivers/media/rc/ir-sharp-decoder.c
index d09c38c07dbd..053151cd8f21 100644
--- a/drivers/media/rc/ir-sharp-decoder.c
+++ b/drivers/media/rc/ir-sharp-decoder.c
@@ -15,7 +15,9 @@
 #define SHARP_UNIT		40  /* us */
 #define SHARP_BIT_PULSE		(8    * SHARP_UNIT) /* 320us */
 #define SHARP_BIT_0_PERIOD	(25   * SHARP_UNIT) /* 1ms (680us space) */
-#define SHARP_BIT_1_PERIOD	(50   * SHARP_UNIT) /* 2ms (1680ms space) */
+#define SHARP_BIT_1_PERIOD	(50   * SHARP_UNIT) /* 2ms (1680us space) */
+#define SHARP_BIT_0_SPACE	(17   * SHARP_UNIT) /* 680us space */
+#define SHARP_BIT_1_SPACE	(42   * SHARP_UNIT) /* 1680us space */
 #define SHARP_ECHO_SPACE	(1000 * SHARP_UNIT) /* 40 ms */
 #define SHARP_TRAILER_SPACE	(125  * SHARP_UNIT) /* 5 ms (even longer) */
 
@@ -168,8 +170,8 @@ static const struct ir_raw_timings_pd ir_sharp_timings = {
 	.header_pulse  = 0,
 	.header_space  = 0,
 	.bit_pulse     = SHARP_BIT_PULSE,
-	.bit_space[0]  = SHARP_BIT_0_PERIOD,
-	.bit_space[1]  = SHARP_BIT_1_PERIOD,
+	.bit_space[0]  = SHARP_BIT_0_SPACE,
+	.bit_space[1]  = SHARP_BIT_1_SPACE,
 	.trailer_pulse = SHARP_BIT_PULSE,
 	.trailer_space = SHARP_ECHO_SPACE,
 	.msb_first     = 1,
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 7f591ff5269d..888177b91152 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -287,7 +287,11 @@ static ssize_t lirc_transmit(struct file *file, const char __user *buf,
 		if (ret < 0)
 			goto out_kfree_raw;
 
-		count = ret;
+		/* drop trailing space */
+		if (!(ret % 2))
+			count = ret - 1;
+		else
+			count = ret;
 
 		txbuf = kmalloc_array(count, sizeof(unsigned int), GFP_KERNEL);
 		if (!txbuf) {
diff --git a/drivers/media/test-drivers/vivid/vivid-rds-gen.c b/drivers/media/test-drivers/vivid/vivid-rds-gen.c
index b5b104ee64c9..c57771119a34 100644
--- a/drivers/media/test-drivers/vivid/vivid-rds-gen.c
+++ b/drivers/media/test-drivers/vivid/vivid-rds-gen.c
@@ -145,7 +145,7 @@ void vivid_rds_gen_fill(struct vivid_rds_gen *rds, unsigned freq,
 	rds->ta = alt;
 	rds->ms = true;
 	snprintf(rds->psname, sizeof(rds->psname), "%6d.%1d",
-		 freq / 16, ((freq & 0xf) * 10) / 16);
+		 (freq / 16) % 1000000, (((freq & 0xf) * 10) / 16) % 10);
 	if (alt)
 		strscpy(rds->radiotext,
 			" The Radio Data System can switch between different Radio Texts ",
diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index 46ed95483e22..5f5fa851ca64 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -18,6 +18,7 @@
 
 #include <linux/input.h>
 #include <linux/sched/signal.h>
+#include <linux/bitops.h>
 
 #include "gspca.h"
 
@@ -1028,6 +1029,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
 			sd->params.exposure.expMode = 2;
 			sd->exposure_status = EXPOSURE_NORMAL;
 		}
+		if (sd->params.exposure.gain >= BITS_PER_TYPE(currentexp))
+			return -EINVAL;
 		currentexp = currentexp << sd->params.exposure.gain;
 		sd->params.exposure.gain = 0;
 		/* round down current exposure to nearest value */
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3382cf4905de..0223e96aae47 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -81,6 +81,7 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774B1		0x002b
 #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
+#define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
 
 static DEFINE_IDA(pci_endpoint_test_ida);
 
@@ -996,6 +997,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
+	  .driver_data = (kernel_ulong_t)&default_data,
+	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 	  .driver_data = (kernel_ulong_t)&j721e_data,
 	},
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 287705729064..db2491d9a95c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -811,7 +811,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
 	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
-	cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
 
 	meson_mmc_set_response_bits(cmd, &cmd_cfg);
 
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index ad50f16658fe..c40dec3da890 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -23,6 +23,12 @@
 #define   GLI_9750_WT_EN_ON	    0x1
 #define   GLI_9750_WT_EN_OFF	    0x0
 
+#define PCI_GLI_9750_PM_CTRL	0xFC
+#define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
+
+#define PCI_GLI_9750_CORRERR_MASK				0x214
+#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
+
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -421,8 +427,12 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
 
 static void gl9750_hw_setting(struct sdhci_host *host)
 {
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev;
 	u32 value;
 
+	pdev = slot->chip->pdev;
+
 	gl9750_wt_on(host);
 
 	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
@@ -432,6 +442,18 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 			    GLI_9750_CFG2_L1DLY_VALUE);
 	sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
 
+	/* toggle PM state to allow GL9750 to enter ASPM L1.2 */
+	pci_read_config_dword(pdev, PCI_GLI_9750_PM_CTRL, &value);
+	value |= PCI_GLI_9750_PM_STATE;
+	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
+	value &= ~PCI_GLI_9750_PM_STATE;
+	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
+
+	/* mask the replay timer timeout of AER */
+	pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
+	value |= PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
+	pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
+
 	gl9750_wt_off(host);
 }
 
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 0158b2b1507d..210701e4fc13 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -600,7 +600,7 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 		return 0;
 	}
 
-	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
+	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
 
 		ret = device_property_read_u32(dev, td[i].otap_binding,
 					       &sdhci_am654->otap_del_sel[i]);
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 7dc0e91dabfc..05ffd5bf5a6f 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2311,6 +2311,7 @@ static int vub300_probe(struct usb_interface *interface,
 		vub300->read_only =
 			(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	} else {
+		retval = -EINVAL;
 		goto error5;
 	}
 	usb_set_intfdata(interface, vub300);
diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 54f92d09d9cf..02aaf09d6f5c 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -421,9 +421,25 @@ read_pri_intelext(struct map_info *map, __u16 adr)
 		extra_size = 0;
 
 		/* Protection Register info */
-		if (extp->NumProtectionFields)
+		if (extp->NumProtectionFields) {
+			struct cfi_intelext_otpinfo *otp =
+				(struct cfi_intelext_otpinfo *)&extp->extra[0];
+
 			extra_size += (extp->NumProtectionFields - 1) *
-				      sizeof(struct cfi_intelext_otpinfo);
+				sizeof(struct cfi_intelext_otpinfo);
+
+			if (extp_size >= sizeof(*extp) + extra_size) {
+				int i;
+
+				/* Do some byteswapping if necessary */
+				for (i = 0; i < extp->NumProtectionFields - 1; i++) {
+					otp->ProtRegAddr = le32_to_cpu(otp->ProtRegAddr);
+					otp->FactGroups = le16_to_cpu(otp->FactGroups);
+					otp->UserGroups = le16_to_cpu(otp->UserGroups);
+					otp++;
+				}
+			}
+		}
 	}
 
 	if (extp->MinorVersion >= '1') {
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 80e42852ffef..9aed194d308d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1473,6 +1473,10 @@ static void bond_compute_features(struct bonding *bond)
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
+	bool was_up = !!(bond_dev->flags & IFF_UP);
+
+	dev_close(bond_dev);
+
 	bond_dev->header_ops	    = slave_dev->header_ops;
 
 	bond_dev->type		    = slave_dev->type;
@@ -1487,6 +1491,8 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
 		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
 	}
+	if (was_up)
+		dev_open(bond_dev, NULL);
 }
 
 /* On bonding slaves other than the currently active slave, suppress
diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdio.c
index bbb7032409ba..25c55fba5803 100644
--- a/drivers/net/dsa/lan9303_mdio.c
+++ b/drivers/net/dsa/lan9303_mdio.c
@@ -32,7 +32,7 @@ static int lan9303_mdio_write(void *ctx, uint32_t reg, uint32_t val)
 	struct lan9303_mdio *sw_dev = (struct lan9303_mdio *)ctx;
 
 	reg <<= 2; /* reg num to offset */
-	mutex_lock(&sw_dev->device->bus->mdio_lock);
+	mutex_lock_nested(&sw_dev->device->bus->mdio_lock, MDIO_MUTEX_NESTED);
 	lan9303_mdio_real_write(sw_dev->device, reg, val & 0xffff);
 	lan9303_mdio_real_write(sw_dev->device, reg + 2, (val >> 16) & 0xffff);
 	mutex_unlock(&sw_dev->device->bus->mdio_lock);
@@ -50,7 +50,7 @@ static int lan9303_mdio_read(void *ctx, uint32_t reg, uint32_t *val)
 	struct lan9303_mdio *sw_dev = (struct lan9303_mdio *)ctx;
 
 	reg <<= 2; /* reg num to offset */
-	mutex_lock(&sw_dev->device->bus->mdio_lock);
+	mutex_lock_nested(&sw_dev->device->bus->mdio_lock, MDIO_MUTEX_NESTED);
 	*val = lan9303_mdio_real_read(sw_dev->device, reg);
 	*val |= (lan9303_mdio_real_read(sw_dev->device, reg + 2) << 16);
 	mutex_unlock(&sw_dev->device->bus->mdio_lock);
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c.h b/drivers/net/ethernet/atheros/atl1c/atl1c.h
index 43d821fe7a54..63ba64dbb731 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c.h
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c.h
@@ -504,15 +504,12 @@ struct atl1c_rrd_ring {
 	u16 next_to_use;
 	u16 next_to_clean;
 	struct napi_struct napi;
-	struct page *rx_page;
-	unsigned int rx_page_offset;
 };
 
 /* board specific private data structure */
 struct atl1c_adapter {
 	struct net_device   *netdev;
 	struct pci_dev      *pdev;
-	unsigned int	    rx_frag_size;
 	struct atl1c_hw        hw;
 	struct atl1c_hw_stats  hw_stats;
 	struct mii_if_info  mii;    /* MII interface info */
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index dad21b4fbc0b..c6f621c0ca83 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -493,15 +493,10 @@ static int atl1c_set_mac_addr(struct net_device *netdev, void *p)
 static void atl1c_set_rxbufsize(struct atl1c_adapter *adapter,
 				struct net_device *dev)
 {
-	unsigned int head_size;
 	int mtu = dev->mtu;
 
 	adapter->rx_buffer_len = mtu > AT_RX_BUF_SIZE ?
 		roundup(mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN, 8) : AT_RX_BUF_SIZE;
-
-	head_size = SKB_DATA_ALIGN(adapter->rx_buffer_len + NET_SKB_PAD + NET_IP_ALIGN) +
-		    SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	adapter->rx_frag_size = roundup_pow_of_two(head_size);
 }
 
 static netdev_features_t atl1c_fix_features(struct net_device *netdev,
@@ -974,7 +969,6 @@ static void atl1c_init_ring_ptrs(struct atl1c_adapter *adapter)
 static void atl1c_free_ring_resources(struct atl1c_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
-	int i;
 
 	dma_free_coherent(&pdev->dev, adapter->ring_header.size,
 			  adapter->ring_header.desc, adapter->ring_header.dma);
@@ -987,12 +981,6 @@ static void atl1c_free_ring_resources(struct atl1c_adapter *adapter)
 		kfree(adapter->tpd_ring[0].buffer_info);
 		adapter->tpd_ring[0].buffer_info = NULL;
 	}
-	for (i = 0; i < adapter->rx_queue_count; ++i) {
-		if (adapter->rrd_ring[i].rx_page) {
-			put_page(adapter->rrd_ring[i].rx_page);
-			adapter->rrd_ring[i].rx_page = NULL;
-		}
-	}
 }
 
 /**
@@ -1764,48 +1752,11 @@ static inline void atl1c_rx_checksum(struct atl1c_adapter *adapter,
 	skb_checksum_none_assert(skb);
 }
 
-static struct sk_buff *atl1c_alloc_skb(struct atl1c_adapter *adapter,
-				       u32 queue, bool napi_mode)
-{
-	struct atl1c_rrd_ring *rrd_ring = &adapter->rrd_ring[queue];
-	struct sk_buff *skb;
-	struct page *page;
-
-	if (adapter->rx_frag_size > PAGE_SIZE) {
-		if (likely(napi_mode))
-			return napi_alloc_skb(&rrd_ring->napi,
-					      adapter->rx_buffer_len);
-		else
-			return netdev_alloc_skb_ip_align(adapter->netdev,
-							 adapter->rx_buffer_len);
-	}
-
-	page = rrd_ring->rx_page;
-	if (!page) {
-		page = alloc_page(GFP_ATOMIC);
-		if (unlikely(!page))
-			return NULL;
-		rrd_ring->rx_page = page;
-		rrd_ring->rx_page_offset = 0;
-	}
-
-	skb = build_skb(page_address(page) + rrd_ring->rx_page_offset,
-			adapter->rx_frag_size);
-	if (likely(skb)) {
-		skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
-		rrd_ring->rx_page_offset += adapter->rx_frag_size;
-		if (rrd_ring->rx_page_offset >= PAGE_SIZE)
-			rrd_ring->rx_page = NULL;
-		else
-			get_page(page);
-	}
-	return skb;
-}
-
 static int atl1c_alloc_rx_buffer(struct atl1c_adapter *adapter, u32 queue,
 				 bool napi_mode)
 {
 	struct atl1c_rfd_ring *rfd_ring = &adapter->rfd_ring[queue];
+	struct atl1c_rrd_ring *rrd_ring = &adapter->rrd_ring[queue];
 	struct pci_dev *pdev = adapter->pdev;
 	struct atl1c_buffer *buffer_info, *next_info;
 	struct sk_buff *skb;
@@ -1824,13 +1775,27 @@ static int atl1c_alloc_rx_buffer(struct atl1c_adapter *adapter, u32 queue,
 	while (next_info->flags & ATL1C_BUFFER_FREE) {
 		rfd_desc = ATL1C_RFD_DESC(rfd_ring, rfd_next_to_use);
 
-		skb = atl1c_alloc_skb(adapter, queue, napi_mode);
+		/* When DMA RX address is set to something like
+		 * 0x....fc0, it will be very likely to cause DMA
+		 * RFD overflow issue.
+		 *
+		 * To work around it, we apply rx skb with 64 bytes
+		 * longer space, and offset the address whenever
+		 * 0x....fc0 is detected.
+		 */
+		if (likely(napi_mode))
+			skb = napi_alloc_skb(&rrd_ring->napi, adapter->rx_buffer_len + 64);
+		else
+			skb = netdev_alloc_skb(adapter->netdev, adapter->rx_buffer_len + 64);
 		if (unlikely(!skb)) {
 			if (netif_msg_rx_err(adapter))
 				dev_warn(&pdev->dev, "alloc rx buffer failed\n");
 			break;
 		}
 
+		if (((unsigned long)skb->data & 0xfff) == 0xfc0)
+			skb_reserve(skb, 64);
+
 		/*
 		 * Make buffer alignment 2 beyond a 16 byte boundary
 		 * this will result in a 16 byte aligned IP header after
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index d0ba5ca862cf..675c6dda45e2 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -432,8 +432,8 @@ static const struct gmac_max_framelen gmac_maxlens[] = {
 		.val = CONFIG0_MAXLEN_1536,
 	},
 	{
-		.max_l3_len = 1542,
-		.val = CONFIG0_MAXLEN_1542,
+		.max_l3_len = 1548,
+		.val = CONFIG0_MAXLEN_1548,
 	},
 	{
 		.max_l3_len = 9212,
@@ -1145,6 +1145,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1159,9 +1160,30 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->ip_summed != CHECKSUM_NONE) {
+	if (skb->len >= ETH_FRAME_LEN) {
+		/* Hardware offloaded checksumming isn't working on frames
+		 * bigger than 1514 bytes. A hypothesis about this is that the
+		 * checksum buffer is only 1518 bytes, so when the frames get
+		 * bigger they get truncated, or the last few bytes get
+		 * overwritten by the FCS.
+		 *
+		 * Just use software checksumming and bypass on bigger frames.
+		 */
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			ret = skb_checksum_help(skb);
+			if (ret)
+				return ret;
+		}
+		word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
+		/* We do not switch off the checksumming on non TCP/UDP
+		 * frames: as is shown from tests, the checksumming engine
+		 * is smart enough to see that a frame is not actually TCP
+		 * or UDP and then just pass it through without any changes
+		 * to the frame.
+		 */
 		if (skb->protocol == htons(ETH_P_IP)) {
 			word1 |= TSS_IP_CHKSUM_BIT;
 			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
@@ -1978,15 +2000,6 @@ static int gmac_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
-static netdev_features_t gmac_fix_features(struct net_device *netdev,
-					   netdev_features_t features)
-{
-	if (netdev->mtu + ETH_HLEN + VLAN_HLEN > MTU_SIZE_BIT_MASK)
-		features &= ~GMAC_OFFLOAD_FEATURES;
-
-	return features;
-}
-
 static int gmac_set_features(struct net_device *netdev,
 			     netdev_features_t features)
 {
@@ -2208,7 +2221,6 @@ static const struct net_device_ops gmac_351x_ops = {
 	.ndo_set_mac_address	= gmac_set_mac_address,
 	.ndo_get_stats64	= gmac_get_stats64,
 	.ndo_change_mtu		= gmac_change_mtu,
-	.ndo_fix_features	= gmac_fix_features,
 	.ndo_set_features	= gmac_set_features,
 };
 
@@ -2458,11 +2470,12 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
 	netdev->hw_features = GMAC_OFFLOAD_FEATURES;
 	netdev->features |= GMAC_OFFLOAD_FEATURES | NETIF_F_GRO;
-	/* We can handle jumbo frames up to 10236 bytes so, let's accept
-	 * payloads of 10236 bytes minus VLAN and ethernet header
+	/* We can receive jumbo frames up to 10236 bytes but only
+	 * transmit 2047 bytes so, let's accept payloads of 2047
+	 * bytes minus VLAN and ethernet header
 	 */
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = 10236 - VLAN_ETH_HLEN;
+	netdev->max_mtu = MTU_SIZE_BIT_MASK - VLAN_ETH_HLEN;
 
 	port->freeq_refill = 0;
 	netif_napi_add(netdev, &port->napi, gmac_napi_poll, NAPI_POLL_WEIGHT);
diff --git a/drivers/net/ethernet/cortina/gemini.h b/drivers/net/ethernet/cortina/gemini.h
index 9fdf77d5eb37..24bb989981f2 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -502,7 +502,7 @@ union gmac_txdesc_3 {
 #define SOF_BIT			0x80000000
 #define EOF_BIT			0x40000000
 #define EOFIE_BIT		BIT(29)
-#define MTU_SIZE_BIT_MASK	0x1fff
+#define MTU_SIZE_BIT_MASK	0x7ff /* Max MTU 2047 bytes */
 
 /* GMAC Tx Descriptor */
 struct gmac_txdesc {
@@ -787,7 +787,7 @@ union gmac_config0 {
 #define  CONFIG0_MAXLEN_1536	0
 #define  CONFIG0_MAXLEN_1518	1
 #define  CONFIG0_MAXLEN_1522	2
-#define  CONFIG0_MAXLEN_1542	3
+#define  CONFIG0_MAXLEN_1548	3
 #define  CONFIG0_MAXLEN_9k	4	/* 9212 */
 #define  CONFIG0_MAXLEN_10k	5	/* 10236 */
 #define  CONFIG0_MAXLEN_1518__6	6
diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index c2bd2584201f..277d6d657c42 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -131,11 +131,20 @@ struct hclge_vf_to_pf_msg {
 };
 
 struct hclge_pf_to_vf_msg {
-	u16 code;
-	u16 vf_mbx_msg_code;
-	u16 vf_mbx_msg_subcode;
-	u16 resp_status;
-	u8 resp_data[HCLGE_MBX_MAX_RESP_DATA_SIZE];
+	__le16 code;
+	union {
+		/* used for mbx response */
+		struct {
+			__le16 vf_mbx_msg_code;
+			__le16 vf_mbx_msg_subcode;
+			__le16 resp_status;
+			u8 resp_data[HCLGE_MBX_MAX_RESP_DATA_SIZE];
+		};
+		/* used for general mbx */
+		struct {
+			u8 msg_data[HCLGE_MBX_MAX_MSG_SIZE];
+		};
+	};
 };
 
 struct hclge_mbx_vf_to_pf_cmd {
@@ -145,7 +154,7 @@ struct hclge_mbx_vf_to_pf_cmd {
 	u8 rsv1[1];
 	u8 msg_len;
 	u8 rsv2;
-	u16 match_id;
+	__le16 match_id;
 	struct hclge_vf_to_pf_msg msg;
 };
 
@@ -156,7 +165,7 @@ struct hclge_mbx_pf_to_vf_cmd {
 	u8 rsv[3];
 	u8 msg_len;
 	u8 rsv1;
-	u16 match_id;
+	__le16 match_id;
 	struct hclge_pf_to_vf_msg msg;
 };
 
@@ -166,6 +175,28 @@ struct hclge_vf_rst_cmd {
 	u8 rsv[22];
 };
 
+#pragma pack(1)
+struct hclge_mbx_link_status {
+	__le16 link_status;
+	__le32 speed;
+	__le16 duplex;
+	u8 flag;
+};
+
+struct hclge_mbx_link_mode {
+	__le16 idx;
+	__le64 link_mode;
+};
+
+struct hclge_mbx_port_base_vlan {
+	__le16 state;
+	__le16 vlan_proto;
+	__le16 qos;
+	__le16 vlan_tag;
+};
+
+#pragma pack()
+
 /* used by VF to store the received Async responses from PF */
 struct hclgevf_mbx_arq_ring {
 #define HCLGE_MBX_MAX_ARQ_MSG_SIZE	8
@@ -174,7 +205,7 @@ struct hclgevf_mbx_arq_ring {
 	u32 head;
 	u32 tail;
 	atomic_t count;
-	u16 msg_q[HCLGE_MBX_MAX_ARQ_MSG_NUM][HCLGE_MBX_MAX_ARQ_MSG_SIZE];
+	__le16 msg_q[HCLGE_MBX_MAX_ARQ_MSG_NUM][HCLGE_MBX_MAX_ARQ_MSG_SIZE];
 };
 
 #define hclge_mbx_ring_ptr_move_crq(crq) \
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index fde1ff358045..60e610ab976d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4915,7 +4915,7 @@ static int hns3_init_mac_addr(struct net_device *netdev)
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	char format_mac_addr[HNAE3_FORMAT_MAC_ADDR_LEN];
 	struct hnae3_handle *h = priv->ae_handle;
-	u8 mac_addr_temp[ETH_ALEN];
+	u8 mac_addr_temp[ETH_ALEN] = {0};
 	int ret = 0;
 
 	if (h->ae_algo->ops->get_mac_addr)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ca59e1cd992e..9e33f0f0b75d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -72,6 +72,7 @@ static void hclge_sync_promisc_mode(struct hclge_dev *hdev);
 static void hclge_sync_fd_table(struct hclge_dev *hdev);
 static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret,
 				      int wait_cnt);
+static int hclge_update_port_info(struct hclge_dev *hdev);
 
 static struct hnae3_ae_algo ae_algo;
 
@@ -2950,6 +2951,9 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 
 	if (state != hdev->hw.mac.link) {
 		hdev->hw.mac.link = state;
+		if (state == HCLGE_LINK_STATUS_UP)
+			hclge_update_port_info(hdev);
+
 		client->ops->link_status_change(handle, state);
 		hclge_config_mac_tnl_int(hdev, state);
 		if (rclient && rclient->ops->link_status_change)
@@ -10196,8 +10200,6 @@ static void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
 	struct hclge_vport_vlan_cfg *vlan, *tmp;
 	struct hclge_dev *hdev = vport->back;
 
-	mutex_lock(&hdev->vport_lock);
-
 	list_for_each_entry_safe(vlan, tmp, &vport->vlan_list, node) {
 		if (vlan->vlan_id == vlan_id) {
 			if (is_write_tbl && vlan->hd_tbl_status)
@@ -10212,8 +10214,6 @@ static void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
 			break;
 		}
 	}
-
-	mutex_unlock(&hdev->vport_lock);
 }
 
 void hclge_rm_vport_all_vlan_table(struct hclge_vport *vport, bool is_del_list)
@@ -10618,11 +10618,16 @@ int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
 	 * handle mailbox. Just record the vlan id, and remove it after
 	 * reset finished.
 	 */
+	mutex_lock(&hdev->vport_lock);
 	if ((test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
 	     test_bit(HCLGE_STATE_RST_FAIL, &hdev->state)) && is_kill) {
 		set_bit(vlan_id, vport->vlan_del_fail_bmap);
+		mutex_unlock(&hdev->vport_lock);
 		return -EBUSY;
+	} else if (!is_kill && test_bit(vlan_id, vport->vlan_del_fail_bmap)) {
+		clear_bit(vlan_id, vport->vlan_del_fail_bmap);
 	}
+	mutex_unlock(&hdev->vport_lock);
 
 	/* when port base vlan enabled, we use port base vlan as the vlan
 	 * filter entry. In this case, we don't update vlan filter table
@@ -10637,17 +10642,22 @@ int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
 	}
 
 	if (!ret) {
-		if (!is_kill)
+		if (!is_kill) {
 			hclge_add_vport_vlan_table(vport, vlan_id,
 						   writen_to_tbl);
-		else if (is_kill && vlan_id != 0)
+		} else if (is_kill && vlan_id != 0) {
+			mutex_lock(&hdev->vport_lock);
 			hclge_rm_vport_vlan_table(vport, vlan_id, false);
+			mutex_unlock(&hdev->vport_lock);
+		}
 	} else if (is_kill) {
 		/* when remove hw vlan filter failed, record the vlan id,
 		 * and try to remove it from hw later, to be consistence
 		 * with stack
 		 */
+		mutex_lock(&hdev->vport_lock);
 		set_bit(vlan_id, vport->vlan_del_fail_bmap);
+		mutex_unlock(&hdev->vport_lock);
 	}
 
 	hclge_set_vport_vlan_fltr_change(vport);
@@ -10687,6 +10697,7 @@ static void hclge_sync_vlan_filter(struct hclge_dev *hdev)
 	int i, ret, sync_cnt = 0;
 	u16 vlan_id;
 
+	mutex_lock(&hdev->vport_lock);
 	/* start from vport 1 for PF is always alive */
 	for (i = 0; i < hdev->num_alloc_vport; i++) {
 		struct hclge_vport *vport = &hdev->vport[i];
@@ -10697,21 +10708,26 @@ static void hclge_sync_vlan_filter(struct hclge_dev *hdev)
 			ret = hclge_set_vlan_filter_hw(hdev, htons(ETH_P_8021Q),
 						       vport->vport_id, vlan_id,
 						       true);
-			if (ret && ret != -EINVAL)
+			if (ret && ret != -EINVAL) {
+				mutex_unlock(&hdev->vport_lock);
 				return;
+			}
 
 			clear_bit(vlan_id, vport->vlan_del_fail_bmap);
 			hclge_rm_vport_vlan_table(vport, vlan_id, false);
 			hclge_set_vport_vlan_fltr_change(vport);
 
 			sync_cnt++;
-			if (sync_cnt >= HCLGE_MAX_SYNC_COUNT)
+			if (sync_cnt >= HCLGE_MAX_SYNC_COUNT) {
+				mutex_unlock(&hdev->vport_lock);
 				return;
+			}
 
 			vlan_id = find_first_bit(vport->vlan_del_fail_bmap,
 						 VLAN_N_VID);
 		}
 	}
+	mutex_unlock(&hdev->vport_lock);
 
 	hclge_sync_vlan_fltr_state(hdev);
 }
@@ -11701,6 +11717,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		goto err_msi_irq_uninit;
 
 	if (hdev->hw.mac.media_type == HNAE3_MEDIA_TYPE_COPPER) {
+		clear_bit(HNAE3_DEV_SUPPORT_FEC_B, ae_dev->caps);
 		if (hnae3_dev_phy_imp_supported(hdev))
 			ret = hclge_update_tp_port_info(hdev);
 		else
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 4a5b11b6fed3..5182051e5414 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -56,17 +56,19 @@ static int hclge_gen_resp_to_vf(struct hclge_vport *vport,
 	resp_pf_to_vf->msg_len = vf_to_pf_req->msg_len;
 	resp_pf_to_vf->match_id = vf_to_pf_req->match_id;
 
-	resp_pf_to_vf->msg.code = HCLGE_MBX_PF_VF_RESP;
-	resp_pf_to_vf->msg.vf_mbx_msg_code = vf_to_pf_req->msg.code;
-	resp_pf_to_vf->msg.vf_mbx_msg_subcode = vf_to_pf_req->msg.subcode;
+	resp_pf_to_vf->msg.code = cpu_to_le16(HCLGE_MBX_PF_VF_RESP);
+	resp_pf_to_vf->msg.vf_mbx_msg_code =
+				cpu_to_le16(vf_to_pf_req->msg.code);
+	resp_pf_to_vf->msg.vf_mbx_msg_subcode =
+				cpu_to_le16(vf_to_pf_req->msg.subcode);
 	resp = hclge_errno_to_resp(resp_msg->status);
 	if (resp < SHRT_MAX) {
-		resp_pf_to_vf->msg.resp_status = resp;
+		resp_pf_to_vf->msg.resp_status = cpu_to_le16(resp);
 	} else {
 		dev_warn(&hdev->pdev->dev,
 			 "failed to send response to VF, response status %u is out-of-bound\n",
 			 resp);
-		resp_pf_to_vf->msg.resp_status = EIO;
+		resp_pf_to_vf->msg.resp_status = cpu_to_le16(EIO);
 	}
 
 	if (resp_msg->len > 0)
@@ -106,9 +108,9 @@ static int hclge_send_mbx_msg(struct hclge_vport *vport, u8 *msg, u16 msg_len,
 
 	resp_pf_to_vf->dest_vfid = dest_vfid;
 	resp_pf_to_vf->msg_len = msg_len;
-	resp_pf_to_vf->msg.code = mbx_opcode;
+	resp_pf_to_vf->msg.code = cpu_to_le16(mbx_opcode);
 
-	memcpy(&resp_pf_to_vf->msg.vf_mbx_msg_code, msg, msg_len);
+	memcpy(resp_pf_to_vf->msg.msg_data, msg, msg_len);
 
 	trace_hclge_pf_mbx_send(hdev, resp_pf_to_vf);
 
@@ -124,8 +126,8 @@ static int hclge_send_mbx_msg(struct hclge_vport *vport, u8 *msg, u16 msg_len,
 int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport)
 {
 	struct hclge_dev *hdev = vport->back;
+	__le16 msg_data;
 	u16 reset_type;
-	u8 msg_data[2];
 	u8 dest_vfid;
 
 	BUILD_BUG_ON(HNAE3_MAX_RESET > U16_MAX);
@@ -139,10 +141,10 @@ int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport)
 	else
 		reset_type = HNAE3_VF_FUNC_RESET;
 
-	memcpy(&msg_data[0], &reset_type, sizeof(u16));
+	msg_data = cpu_to_le16(reset_type);
 
 	/* send this requested info to VF */
-	return hclge_send_mbx_msg(vport, msg_data, sizeof(msg_data),
+	return hclge_send_mbx_msg(vport, (u8 *)&msg_data, sizeof(msg_data),
 				  HCLGE_MBX_ASSERTING_RESET, dest_vfid);
 }
 
@@ -338,16 +340,14 @@ int hclge_push_vf_port_base_vlan_info(struct hclge_vport *vport, u8 vfid,
 				      u16 state,
 				      struct hclge_vlan_info *vlan_info)
 {
-#define MSG_DATA_SIZE	8
+	struct hclge_mbx_port_base_vlan base_vlan;
 
-	u8 msg_data[MSG_DATA_SIZE];
+	base_vlan.state = cpu_to_le16(state);
+	base_vlan.vlan_proto = cpu_to_le16(vlan_info->vlan_proto);
+	base_vlan.qos = cpu_to_le16(vlan_info->qos);
+	base_vlan.vlan_tag = cpu_to_le16(vlan_info->vlan_tag);
 
-	memcpy(&msg_data[0], &state, sizeof(u16));
-	memcpy(&msg_data[2], &vlan_info->vlan_proto, sizeof(u16));
-	memcpy(&msg_data[4], &vlan_info->qos, sizeof(u16));
-	memcpy(&msg_data[6], &vlan_info->vlan_tag, sizeof(u16));
-
-	return hclge_send_mbx_msg(vport, msg_data, sizeof(msg_data),
+	return hclge_send_mbx_msg(vport, (u8 *)&base_vlan, sizeof(base_vlan),
 				  HCLGE_MBX_PUSH_VLAN_INFO, vfid);
 }
 
@@ -487,10 +487,9 @@ int hclge_push_vf_link_status(struct hclge_vport *vport)
 #define HCLGE_VF_LINK_STATE_UP		1U
 #define HCLGE_VF_LINK_STATE_DOWN	0U
 
+	struct hclge_mbx_link_status link_info;
 	struct hclge_dev *hdev = vport->back;
 	u16 link_status;
-	u8 msg_data[9];
-	u16 duplex;
 
 	/* mac.link can only be 0 or 1 */
 	switch (vport->vf_info.link_state) {
@@ -506,14 +505,13 @@ int hclge_push_vf_link_status(struct hclge_vport *vport)
 		break;
 	}
 
-	duplex = hdev->hw.mac.duplex;
-	memcpy(&msg_data[0], &link_status, sizeof(u16));
-	memcpy(&msg_data[2], &hdev->hw.mac.speed, sizeof(u32));
-	memcpy(&msg_data[6], &duplex, sizeof(u16));
-	msg_data[8] = HCLGE_MBX_PUSH_LINK_STATUS_EN;
+	link_info.link_status = cpu_to_le16(link_status);
+	link_info.speed = cpu_to_le32(hdev->hw.mac.speed);
+	link_info.duplex = cpu_to_le16(hdev->hw.mac.duplex);
+	link_info.flag = HCLGE_MBX_PUSH_LINK_STATUS_EN;
 
 	/* send this requested info to VF */
-	return hclge_send_mbx_msg(vport, msg_data, sizeof(msg_data),
+	return hclge_send_mbx_msg(vport, (u8 *)&link_info, sizeof(link_info),
 				  HCLGE_MBX_LINK_STAT_CHANGE, vport->vport_id);
 }
 
@@ -521,22 +519,22 @@ static void hclge_get_link_mode(struct hclge_vport *vport,
 				struct hclge_mbx_vf_to_pf_cmd *mbx_req)
 {
 #define HCLGE_SUPPORTED   1
+	struct hclge_mbx_link_mode link_mode;
 	struct hclge_dev *hdev = vport->back;
 	unsigned long advertising;
 	unsigned long supported;
 	unsigned long send_data;
-	u8 msg_data[10] = {};
 	u8 dest_vfid;
 
 	advertising = hdev->hw.mac.advertising[0];
 	supported = hdev->hw.mac.supported[0];
 	dest_vfid = mbx_req->mbx_src_vfid;
-	msg_data[0] = mbx_req->msg.data[0];
-
-	send_data = msg_data[0] == HCLGE_SUPPORTED ? supported : advertising;
+	send_data = mbx_req->msg.data[0] == HCLGE_SUPPORTED ? supported :
+							      advertising;
+	link_mode.idx = cpu_to_le16((u16)mbx_req->msg.data[0]);
+	link_mode.link_mode = cpu_to_le64(send_data);
 
-	memcpy(&msg_data[2], &send_data, sizeof(unsigned long));
-	hclge_send_mbx_msg(vport, msg_data, sizeof(msg_data),
+	hclge_send_mbx_msg(vport, (u8 *)&link_mode, sizeof(link_mode),
 			   HCLGE_MBX_LINK_STAT_MODE, dest_vfid);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
index 5b0b71bd6120..8510b88d4982 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
@@ -62,7 +62,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
 
 	TP_fast_assign(
 		__entry->vfid = req->dest_vfid;
-		__entry->code = req->msg.code;
+		__entry->code = le16_to_cpu(req->msg.code);
 		__assign_str(pciname, pci_name(hdev->pdev));
 		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index bc140e3620d6..880feeac0637 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1710,6 +1710,8 @@ static int hclgevf_set_vlan_filter(struct hnae3_handle *handle,
 	     test_bit(HCLGEVF_STATE_RST_FAIL, &hdev->state)) && is_kill) {
 		set_bit(vlan_id, hdev->vlan_del_fail_bmap);
 		return -EBUSY;
+	} else if (!is_kill && test_bit(vlan_id, hdev->vlan_del_fail_bmap)) {
+		clear_bit(vlan_id, hdev->vlan_del_fail_bmap);
 	}
 
 	hclgevf_build_send_msg(&send_msg, HCLGE_MBX_SET_VLAN,
@@ -1737,20 +1739,25 @@ static void hclgevf_sync_vlan_filter(struct hclgevf_dev *hdev)
 	int ret, sync_cnt = 0;
 	u16 vlan_id;
 
+	if (bitmap_empty(hdev->vlan_del_fail_bmap, VLAN_N_VID))
+		return;
+
+	rtnl_lock();
 	vlan_id = find_first_bit(hdev->vlan_del_fail_bmap, VLAN_N_VID);
 	while (vlan_id != VLAN_N_VID) {
 		ret = hclgevf_set_vlan_filter(handle, htons(ETH_P_8021Q),
 					      vlan_id, true);
 		if (ret)
-			return;
+			break;
 
 		clear_bit(vlan_id, hdev->vlan_del_fail_bmap);
 		sync_cnt++;
 		if (sync_cnt >= HCLGEVF_MAX_SYNC_COUNT)
-			return;
+			break;
 
 		vlan_id = find_first_bit(hdev->vlan_del_fail_bmap, VLAN_N_VID);
 	}
+	rtnl_unlock();
 }
 
 static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
@@ -2480,8 +2487,18 @@ static enum hclgevf_evt_cause hclgevf_check_evt_cause(struct hclgevf_dev *hdev,
 	return HCLGEVF_VECTOR0_EVENT_OTHER;
 }
 
+static void hclgevf_reset_timer(struct timer_list *t)
+{
+	struct hclgevf_dev *hdev = from_timer(hdev, t, reset_timer);
+
+	hclgevf_clear_event_cause(hdev, HCLGEVF_VECTOR0_EVENT_RST);
+	hclgevf_reset_task_schedule(hdev);
+}
+
 static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 {
+#define HCLGEVF_RESET_DELAY	5
+
 	enum hclgevf_evt_cause event_cause;
 	struct hclgevf_dev *hdev = data;
 	u32 clearval;
@@ -2493,7 +2510,8 @@ static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 
 	switch (event_cause) {
 	case HCLGEVF_VECTOR0_EVENT_RST:
-		hclgevf_reset_task_schedule(hdev);
+		mod_timer(&hdev->reset_timer,
+			  jiffies + msecs_to_jiffies(HCLGEVF_RESET_DELAY));
 		break;
 	case HCLGEVF_VECTOR0_EVENT_MBX:
 		hclgevf_mbx_handler(hdev);
@@ -3470,6 +3488,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		 HCLGEVF_DRIVER_NAME);
 
 	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
+	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
 
 	return 0;
 
@@ -3809,7 +3828,7 @@ static void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
 }
 
 void hclgevf_update_port_base_vlan_info(struct hclgevf_dev *hdev, u16 state,
-					u8 *port_base_vlan_info, u8 data_size)
+				struct hclge_mbx_port_base_vlan *port_base_vlan)
 {
 	struct hnae3_handle *nic = &hdev->nic;
 	struct hclge_vf_to_pf_msg send_msg;
@@ -3834,7 +3853,7 @@ void hclgevf_update_port_base_vlan_info(struct hclgevf_dev *hdev, u16 state,
 	/* send msg to PF and wait update port based vlan info */
 	hclgevf_build_send_msg(&send_msg, HCLGE_MBX_SET_VLAN,
 			       HCLGE_MBX_PORT_BASE_VLAN_CFG);
-	memcpy(send_msg.data, port_base_vlan_info, data_size);
+	memcpy(send_msg.data, port_base_vlan, sizeof(*port_base_vlan));
 	ret = hclgevf_send_mbx_msg(hdev, &send_msg, false, NULL, 0);
 	if (!ret) {
 		if (state == HNAE3_PORT_BASE_VLAN_DISABLE)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index f6f736c0091c..5c7538ca36a7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -281,6 +281,7 @@ struct hclgevf_dev {
 	enum hnae3_reset_type reset_level;
 	unsigned long reset_pending;
 	enum hnae3_reset_type reset_type;
+	struct timer_list reset_timer;
 
 #define HCLGEVF_RESET_REQUESTED		0
 #define HCLGEVF_RESET_PENDING		1
@@ -355,5 +356,5 @@ void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
 void hclgevf_reset_task_schedule(struct hclgevf_dev *hdev);
 void hclgevf_mbx_task_schedule(struct hclgevf_dev *hdev);
 void hclgevf_update_port_base_vlan_info(struct hclgevf_dev *hdev, u16 state,
-					u8 *port_base_vlan_info, u8 data_size);
+			struct hclge_mbx_port_base_vlan *port_base_vlan);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index c5ac6ecf36e1..608a14fc27ac 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -60,6 +60,9 @@ static int hclgevf_get_mbx_resp(struct hclgevf_dev *hdev, u16 code0, u16 code1,
 		i++;
 	}
 
+	/* ensure additional_info will be seen after received_resp */
+	smp_rmb();
+
 	if (i >= HCLGEVF_MAX_TRY_TIMES) {
 		dev_err(&hdev->pdev->dev,
 			"VF could not get mbx(%u,%u) resp(=%d) from PF in %d tries\n",
@@ -121,7 +124,7 @@ int hclgevf_send_mbx_msg(struct hclgevf_dev *hdev,
 	if (need_resp) {
 		mutex_lock(&hdev->mbx_resp.mbx_mutex);
 		hclgevf_reset_mbx_resp_status(hdev);
-		req->match_id = hdev->mbx_resp.match_id;
+		req->match_id = cpu_to_le16(hdev->mbx_resp.match_id);
 		status = hclgevf_cmd_send(&hdev->hw, &desc, 1);
 		if (status) {
 			dev_err(&hdev->pdev->dev,
@@ -159,27 +162,33 @@ static bool hclgevf_cmd_crq_empty(struct hclgevf_hw *hw)
 static void hclgevf_handle_mbx_response(struct hclgevf_dev *hdev,
 					struct hclge_mbx_pf_to_vf_cmd *req)
 {
+	u16 vf_mbx_msg_subcode = le16_to_cpu(req->msg.vf_mbx_msg_subcode);
+	u16 vf_mbx_msg_code = le16_to_cpu(req->msg.vf_mbx_msg_code);
 	struct hclgevf_mbx_resp_status *resp = &hdev->mbx_resp;
+	u16 resp_status = le16_to_cpu(req->msg.resp_status);
+	u16 match_id = le16_to_cpu(req->match_id);
 
 	if (resp->received_resp)
 		dev_warn(&hdev->pdev->dev,
-			 "VF mbx resp flag not clear(%u)\n",
-			 req->msg.vf_mbx_msg_code);
-
-	resp->origin_mbx_msg =
-			(req->msg.vf_mbx_msg_code << 16);
-	resp->origin_mbx_msg |= req->msg.vf_mbx_msg_subcode;
-	resp->resp_status =
-		hclgevf_resp_to_errno(req->msg.resp_status);
+			"VF mbx resp flag not clear(%u)\n",
+			 vf_mbx_msg_code);
+
+	resp->origin_mbx_msg = (vf_mbx_msg_code << 16);
+	resp->origin_mbx_msg |= vf_mbx_msg_subcode;
+	resp->resp_status = hclgevf_resp_to_errno(resp_status);
 	memcpy(resp->additional_info, req->msg.resp_data,
 	       HCLGE_MBX_MAX_RESP_DATA_SIZE * sizeof(u8));
-	if (req->match_id) {
+
+	/* ensure additional_info will be seen before setting received_resp */
+	smp_wmb();
+
+	if (match_id) {
 		/* If match_id is not zero, it means PF support match_id.
 		 * if the match_id is right, VF get the right response, or
 		 * ignore the response. and driver will clear hdev->mbx_resp
 		 * when send next message which need response.
 		 */
-		if (req->match_id == resp->match_id)
+		if (match_id == resp->match_id)
 			resp->received_resp = true;
 	} else {
 		resp->received_resp = true;
@@ -196,7 +205,7 @@ static void hclgevf_handle_mbx_msg(struct hclgevf_dev *hdev,
 	    HCLGE_MBX_MAX_ARQ_MSG_NUM) {
 		dev_warn(&hdev->pdev->dev,
 			 "Async Q full, dropping msg(%u)\n",
-			 req->msg.code);
+			 le16_to_cpu(req->msg.code));
 		return;
 	}
 
@@ -215,6 +224,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 	struct hclgevf_cmq_ring *crq;
 	struct hclgevf_desc *desc;
 	u16 flag;
+	u16 code;
 
 	crq = &hdev->hw.cmq.crq;
 
@@ -228,10 +238,11 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 		req = (struct hclge_mbx_pf_to_vf_cmd *)desc->data;
 
 		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
+		code = le16_to_cpu(req->msg.code);
 		if (unlikely(!hnae3_get_bit(flag, HCLGEVF_CMDQ_RX_OUTVLD_B))) {
 			dev_warn(&hdev->pdev->dev,
 				 "dropped invalid mailbox message, code = %u\n",
-				 req->msg.code);
+				 code);
 
 			/* dropping/not processing this invalid message */
 			crq->desc[crq->next_to_use].flag = 0;
@@ -247,7 +258,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 		 * timeout and simultaneously queue the async messages for later
 		 * prcessing in context of mailbox task i.e. the slow path.
 		 */
-		switch (req->msg.code) {
+		switch (code) {
 		case HCLGE_MBX_PF_VF_RESP:
 			hclgevf_handle_mbx_response(hdev, req);
 			break;
@@ -261,7 +272,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 		default:
 			dev_err(&hdev->pdev->dev,
 				"VF received unsupported(%u) mbx msg from PF\n",
-				req->msg.code);
+				code);
 			break;
 		}
 		crq->desc[crq->next_to_use].flag = 0;
@@ -283,14 +294,18 @@ static void hclgevf_parse_promisc_info(struct hclgevf_dev *hdev,
 
 void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 {
+	struct hclge_mbx_port_base_vlan *vlan_info;
+	struct hclge_mbx_link_status *link_info;
+	struct hclge_mbx_link_mode *link_mode;
 	enum hnae3_reset_type reset_type;
 	u16 link_status, state;
-	u16 *msg_q, *vlan_info;
+	__le16 *msg_q;
+	u16 opcode;
 	u8 duplex;
 	u32 speed;
 	u32 tail;
 	u8 flag;
-	u8 idx;
+	u16 idx;
 
 	tail = hdev->arq.tail;
 
@@ -303,13 +318,14 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 		}
 
 		msg_q = hdev->arq.msg_q[hdev->arq.head];
-
-		switch (msg_q[0]) {
+		opcode = le16_to_cpu(msg_q[0]);
+		switch (opcode) {
 		case HCLGE_MBX_LINK_STAT_CHANGE:
-			link_status = msg_q[1];
-			memcpy(&speed, &msg_q[2], sizeof(speed));
-			duplex = (u8)msg_q[4];
-			flag = (u8)msg_q[5];
+			link_info = (struct hclge_mbx_link_status *)(msg_q + 1);
+			link_status = le16_to_cpu(link_info->link_status);
+			speed = le32_to_cpu(link_info->speed);
+			duplex = (u8)le16_to_cpu(link_info->duplex);
+			flag = link_info->flag;
 
 			/* update upper layer with new link link status */
 			hclgevf_update_speed_duplex(hdev, speed, duplex);
@@ -321,13 +337,14 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 
 			break;
 		case HCLGE_MBX_LINK_STAT_MODE:
-			idx = (u8)msg_q[1];
+			link_mode = (struct hclge_mbx_link_mode *)(msg_q + 1);
+			idx = le16_to_cpu(link_mode->idx);
 			if (idx)
-				memcpy(&hdev->hw.mac.supported, &msg_q[2],
-				       sizeof(unsigned long));
+				hdev->hw.mac.supported =
+					le64_to_cpu(link_mode->link_mode);
 			else
-				memcpy(&hdev->hw.mac.advertising, &msg_q[2],
-				       sizeof(unsigned long));
+				hdev->hw.mac.advertising =
+					le64_to_cpu(link_mode->link_mode);
 			break;
 		case HCLGE_MBX_ASSERTING_RESET:
 			/* PF has asserted reset hence VF should go in pending
@@ -335,25 +352,27 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 			 * has been completely reset. After this stack should
 			 * eventually be re-initialized.
 			 */
-			reset_type = (enum hnae3_reset_type)msg_q[1];
+			reset_type =
+				(enum hnae3_reset_type)le16_to_cpu(msg_q[1]);
 			set_bit(reset_type, &hdev->reset_pending);
 			set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
 			hclgevf_reset_task_schedule(hdev);
 
 			break;
 		case HCLGE_MBX_PUSH_VLAN_INFO:
-			state = msg_q[1];
-			vlan_info = &msg_q[1];
+			vlan_info =
+				(struct hclge_mbx_port_base_vlan *)(msg_q + 1);
+			state = le16_to_cpu(vlan_info->state);
 			hclgevf_update_port_base_vlan_info(hdev, state,
-							   (u8 *)vlan_info, 8);
+							   vlan_info);
 			break;
 		case HCLGE_MBX_PUSH_PROMISC_INFO:
-			hclgevf_parse_promisc_info(hdev, msg_q[1]);
+			hclgevf_parse_promisc_info(hdev, le16_to_cpu(msg_q[1]));
 			break;
 		default:
 			dev_err(&hdev->pdev->dev,
 				"fetched unsupported(%u) message from arq\n",
-				msg_q[0]);
+				opcode);
 			break;
 		}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
index e4bfb6191fef..5d4895bb57a1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
@@ -29,7 +29,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
 
 	TP_fast_assign(
 		__entry->vfid = req->dest_vfid;
-		__entry->code = req->msg.code;
+		__entry->code = le16_to_cpu(req->msg.code);
 		__assign_str(pciname, pci_name(hdev->pdev));
 		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.c b/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.c
index 7edde4d536fd..19d05fb4aab2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.c
@@ -155,3 +155,50 @@ struct mlx5_modify_hdr *mlx5e_mod_hdr_get(struct mlx5e_mod_hdr_handle *mh)
 	return mh->modify_hdr;
 }
 
+char *
+mlx5e_mod_hdr_alloc(struct mlx5_core_dev *mdev, int namespace,
+		    struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts)
+{
+	int new_num_actions, max_hw_actions;
+	size_t new_sz, old_sz;
+	void *ret;
+
+	if (mod_hdr_acts->num_actions < mod_hdr_acts->max_actions)
+		goto out;
+
+	max_hw_actions = mlx5e_mod_hdr_max_actions(mdev, namespace);
+	new_num_actions = min(max_hw_actions,
+			      mod_hdr_acts->actions ?
+			      mod_hdr_acts->max_actions * 2 : 1);
+	if (mod_hdr_acts->max_actions == new_num_actions)
+		return ERR_PTR(-ENOSPC);
+
+	new_sz = MLX5_MH_ACT_SZ * new_num_actions;
+	old_sz = mod_hdr_acts->max_actions * MLX5_MH_ACT_SZ;
+
+	ret = krealloc(mod_hdr_acts->actions, new_sz, GFP_KERNEL);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
+
+	memset(ret + old_sz, 0, new_sz - old_sz);
+	mod_hdr_acts->actions = ret;
+	mod_hdr_acts->max_actions = new_num_actions;
+
+out:
+	return mod_hdr_acts->actions + (mod_hdr_acts->num_actions * MLX5_MH_ACT_SZ);
+}
+
+void
+mlx5e_mod_hdr_dealloc(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts)
+{
+	kfree(mod_hdr_acts->actions);
+	mod_hdr_acts->actions = NULL;
+	mod_hdr_acts->num_actions = 0;
+	mod_hdr_acts->max_actions = 0;
+}
+
+char *
+mlx5e_mod_hdr_get_item(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts, int pos)
+{
+	return mod_hdr_acts->actions + (pos * MLX5_MH_ACT_SZ);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.h b/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.h
index 33b23d8f9182..b8cd1a7a31be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.h
@@ -15,6 +15,11 @@ struct mlx5e_tc_mod_hdr_acts {
 	void *actions;
 };
 
+char *mlx5e_mod_hdr_alloc(struct mlx5_core_dev *mdev, int namespace,
+			  struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts);
+void mlx5e_mod_hdr_dealloc(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts);
+char *mlx5e_mod_hdr_get_item(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts, int pos);
+
 struct mlx5e_mod_hdr_handle *
 mlx5e_mod_hdr_attach(struct mlx5_core_dev *mdev,
 		     struct mod_hdr_tbl *tbl,
@@ -28,4 +33,12 @@ struct mlx5_modify_hdr *mlx5e_mod_hdr_get(struct mlx5e_mod_hdr_handle *mh);
 void mlx5e_mod_hdr_tbl_init(struct mod_hdr_tbl *tbl);
 void mlx5e_mod_hdr_tbl_destroy(struct mod_hdr_tbl *tbl);
 
+static inline int mlx5e_mod_hdr_max_actions(struct mlx5_core_dev *mdev, int namespace)
+{
+	if (namespace == MLX5_FLOW_NAMESPACE_FDB) /* FDB offloading */
+		return MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, max_modify_header_actions);
+	else /* namespace is MLX5_FLOW_NAMESPACE_KERNEL - NIC offloading */
+		return MLX5_CAP_FLOWTABLE_NIC_RX(mdev, max_modify_header_actions);
+}
+
 #endif /* __MLX5E_EN_MOD_HDR_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 899a9a73eef6..a4c12c5bb0dc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -655,11 +655,11 @@ static int mlx5e_rx_reporter_dump(struct devlink_health_reporter *reporter,
 
 void mlx5e_reporter_rx_timeout(struct mlx5e_rq *rq)
 {
-	char icosq_str[MLX5E_REPORTER_PER_Q_MAX_LEN] = {};
 	char err_str[MLX5E_REPORTER_PER_Q_MAX_LEN];
 	struct mlx5e_icosq *icosq = rq->icosq;
 	struct mlx5e_priv *priv = rq->priv;
 	struct mlx5e_err_ctx err_ctx = {};
+	char icosq_str[32] = {};
 
 	err_ctx.ctx = rq;
 	err_ctx.recover = mlx5e_rx_reporter_timeout_recover;
@@ -668,7 +668,7 @@ void mlx5e_reporter_rx_timeout(struct mlx5e_rq *rq)
 	if (icosq)
 		snprintf(icosq_str, sizeof(icosq_str), "ICOSQ: 0x%x, ", icosq->sqn);
 	snprintf(err_str, sizeof(err_str),
-		 "RX timeout on channel: %d, %sRQ: 0x%x, CQ: 0x%x",
+		 "RX timeout on channel: %d, %s RQ: 0x%x, CQ: 0x%x",
 		 rq->ix, icosq_str, rq->rqn, rq->cq.mcq.cqn);
 
 	mlx5e_health_report(priv, priv->rx_reporter, err_str, &err_ctx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
index 6552ecee3f9b..d08723a444e3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
@@ -5,6 +5,7 @@
 #include <net/psample.h>
 #include "en/mapping.h"
 #include "en/tc/post_act.h"
+#include "en/mod_hdr.h"
 #include "sample.h"
 #include "eswitch.h"
 #include "en_tc.h"
@@ -255,12 +256,12 @@ sample_modify_hdr_get(struct mlx5_core_dev *mdev, u32 obj_id,
 		goto err_modify_hdr;
 	}
 
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 	return modify_hdr;
 
 err_modify_hdr:
 err_post_act:
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 err_set_regc0:
 	return ERR_PTR(err);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 94200f2dd92b..80a49d7af05d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -609,22 +609,15 @@ mlx5_tc_ct_entry_create_nat(struct mlx5_tc_ct_priv *ct_priv,
 	struct flow_action *flow_action = &flow_rule->action;
 	struct mlx5_core_dev *mdev = ct_priv->dev;
 	struct flow_action_entry *act;
-	size_t action_size;
 	char *modact;
 	int err, i;
 
-	action_size = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto);
-
 	flow_action_for_each(i, act, flow_action) {
 		switch (act->id) {
 		case FLOW_ACTION_MANGLE: {
-			err = alloc_mod_hdr_actions(mdev, ct_priv->ns_type,
-						    mod_acts);
-			if (err)
-				return err;
-
-			modact = mod_acts->actions +
-				 mod_acts->num_actions * action_size;
+			modact = mlx5e_mod_hdr_alloc(mdev, ct_priv->ns_type, mod_acts);
+			if (IS_ERR(modact))
+				return PTR_ERR(modact);
 
 			err = mlx5_tc_ct_parse_mangle_to_mod_act(act, modact);
 			if (err)
@@ -707,11 +700,11 @@ mlx5_tc_ct_entry_create_mod_hdr(struct mlx5_tc_ct_priv *ct_priv,
 		attr->modify_hdr = mlx5e_mod_hdr_get(*mh);
 	}
 
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 	return 0;
 
 err_mapping:
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 	mlx5_put_label_mapping(ct_priv, attr->ct_attr.ct_labels_id);
 	return err;
 }
@@ -1463,7 +1456,7 @@ static int tc_ct_pre_ct_add_rules(struct mlx5_ct_ft *ct_ft,
 	}
 	pre_ct->miss_rule = rule;
 
-	dealloc_mod_hdr_actions(&pre_mod_acts);
+	mlx5e_mod_hdr_dealloc(&pre_mod_acts);
 	kvfree(spec);
 	return 0;
 
@@ -1472,7 +1465,7 @@ static int tc_ct_pre_ct_add_rules(struct mlx5_ct_ft *ct_ft,
 err_flow_rule:
 	mlx5_modify_header_dealloc(dev, pre_ct->modify_hdr);
 err_mapping:
-	dealloc_mod_hdr_actions(&pre_mod_acts);
+	mlx5e_mod_hdr_dealloc(&pre_mod_acts);
 	kvfree(spec);
 	return err;
 }
@@ -1872,14 +1865,14 @@ __mlx5_tc_ct_flow_offload(struct mlx5_tc_ct_priv *ct_priv,
 	}
 
 	attr->ct_attr.ct_flow = ct_flow;
-	dealloc_mod_hdr_actions(&pre_mod_acts);
+	mlx5e_mod_hdr_dealloc(&pre_mod_acts);
 
 	return ct_flow->pre_ct_rule;
 
 err_insert_orig:
 	mlx5_modify_header_dealloc(priv->mdev, pre_ct_attr->modify_hdr);
 err_mapping:
-	dealloc_mod_hdr_actions(&pre_mod_acts);
+	mlx5e_mod_hdr_dealloc(&pre_mod_acts);
 	mlx5_chains_put_chain_mapping(ct_priv->chains, ct_flow->chain_mapping);
 err_get_chain:
 	kfree(ct_flow->pre_ct_attr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index d90c6dc41c9f..303e6e7a5c44 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -294,9 +294,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
-	e->encap_size = ipv4_encap_size;
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -316,6 +313,8 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
+	e->encap_size = ipv4_encap_size;
+	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv4_put(&attr);
@@ -398,16 +397,12 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
-	e->encap_size = ipv4_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto release_neigh;
+		goto free_encap;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -421,6 +416,10 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
+	e->encap_size = ipv4_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv4_put(&attr);
@@ -559,9 +558,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
-	e->encap_size = ipv6_encap_size;
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -581,6 +577,8 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
+	e->encap_size = ipv6_encap_size;
+	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv6_put(&attr);
@@ -662,16 +660,12 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
-	e->encap_size = ipv6_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto release_neigh;
+		goto free_encap;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -685,6 +679,10 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
+	e->encap_size = ipv6_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv6_put(&attr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 3d614bf5cff9..7a00faa62d99 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -66,13 +66,17 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
+	int count;
 
 	strlcpy(drvinfo->driver, mlx5e_rep_driver_name,
 		sizeof(drvinfo->driver));
-	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
-		 "%d.%d.%04d (%.16s)",
-		 fw_rev_maj(mdev), fw_rev_min(mdev),
-		 fw_rev_sub(mdev), mdev->board_id);
+	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
+			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
+	if (count == sizeof(drvinfo->fw_version))
+		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%d.%d.%04d", fw_rev_maj(mdev),
+			 fw_rev_min(mdev), fw_rev_sub(mdev));
 }
 
 static const struct counter_desc sw_rep_stats_desc[] = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index d123d9b4adf5..78538a15c097 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -71,7 +71,6 @@
 #include "lag_mp.h"
 
 #define nic_chains(priv) ((priv)->fs.tc.chains)
-#define MLX5_MH_ACT_SZ MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)
 
 #define MLX5E_TC_TABLE_NUM_GROUPS 4
 #define MLX5E_TC_TABLE_MAX_GROUP_SIZE BIT(18)
@@ -209,12 +208,9 @@ mlx5e_tc_match_to_reg_set_and_get_id(struct mlx5_core_dev *mdev,
 	char *modact;
 	int err;
 
-	err = alloc_mod_hdr_actions(mdev, ns, mod_hdr_acts);
-	if (err)
-		return err;
-
-	modact = mod_hdr_acts->actions +
-		 (mod_hdr_acts->num_actions * MLX5_MH_ACT_SZ);
+	modact = mlx5e_mod_hdr_alloc(mdev, ns, mod_hdr_acts);
+	if (IS_ERR(modact))
+		return PTR_ERR(modact);
 
 	/* Firmware has 5bit length field and 0 means 32bits */
 	if (mlen == 32)
@@ -316,7 +312,7 @@ void mlx5e_tc_match_to_reg_mod_hdr_change(struct mlx5_core_dev *mdev,
 	int mlen = mlx5e_tc_attr_to_reg_mappings[type].mlen;
 	char *modact;
 
-	modact = mod_hdr_acts->actions + (act_id * MLX5_MH_ACT_SZ);
+	modact = mlx5e_mod_hdr_get_item(mod_hdr_acts, act_id);
 
 	/* Firmware has 5bit length field and 0 means 32bits */
 	if (mlen == 32)
@@ -1059,7 +1055,7 @@ mlx5e_tc_add_nic_flow(struct mlx5e_priv *priv,
 
 	if (attr->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) {
 		err = mlx5e_attach_mod_hdr(priv, flow, parse_attr);
-		dealloc_mod_hdr_actions(&parse_attr->mod_hdr_acts);
+		mlx5e_mod_hdr_dealloc(&parse_attr->mod_hdr_acts);
 		if (err)
 			return err;
 	}
@@ -1557,7 +1553,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 	mlx5_tc_ct_match_del(get_ct_priv(priv), &flow->attr->ct_attr);
 
 	if (attr->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) {
-		dealloc_mod_hdr_actions(&attr->parse_attr->mod_hdr_acts);
+		mlx5e_mod_hdr_dealloc(&attr->parse_attr->mod_hdr_acts);
 		if (vf_tun && attr->modify_hdr)
 			mlx5_modify_header_dealloc(priv->mdev, attr->modify_hdr);
 		else
@@ -2768,7 +2764,7 @@ static struct mlx5_fields fields[] = {
 	OFFLOAD(DIPV6_31_0,   32, U32_MAX, ip6.daddr.s6_addr32[3], 0,
 		dst_ipv4_dst_ipv6.ipv6_layout.ipv6[12]),
 	OFFLOAD(IPV6_HOPLIMIT, 8,  U8_MAX, ip6.hop_limit, 0, ttl_hoplimit),
-	OFFLOAD(IP_DSCP, 16,  0xc00f, ip6, 0, ip_dscp),
+	OFFLOAD(IP_DSCP, 16,  0x0fc0, ip6, 0, ip_dscp),
 
 	OFFLOAD(TCP_SPORT, 16, U16_MAX, tcp.source,  0, tcp_sport),
 	OFFLOAD(TCP_DPORT, 16, U16_MAX, tcp.dest,    0, tcp_dport),
@@ -2779,21 +2775,31 @@ static struct mlx5_fields fields[] = {
 	OFFLOAD(UDP_DPORT, 16, U16_MAX, udp.dest,   0, udp_dport),
 };
 
-static unsigned long mask_to_le(unsigned long mask, int size)
+static u32 mask_field_get(void *mask, struct mlx5_fields *f)
 {
-	__be32 mask_be32;
-	__be16 mask_be16;
-
-	if (size == 32) {
-		mask_be32 = (__force __be32)(mask);
-		mask = (__force unsigned long)cpu_to_le32(be32_to_cpu(mask_be32));
-	} else if (size == 16) {
-		mask_be32 = (__force __be32)(mask);
-		mask_be16 = *(__be16 *)&mask_be32;
-		mask = (__force unsigned long)cpu_to_le16(be16_to_cpu(mask_be16));
+	switch (f->field_bsize) {
+	case 32:
+		return be32_to_cpu(*(__be32 *)mask) & f->field_mask;
+	case 16:
+		return be16_to_cpu(*(__be16 *)mask) & (u16)f->field_mask;
+	default:
+		return *(u8 *)mask & (u8)f->field_mask;
 	}
+}
 
-	return mask;
+static void mask_field_clear(void *mask, struct mlx5_fields *f)
+{
+	switch (f->field_bsize) {
+	case 32:
+		*(__be32 *)mask &= ~cpu_to_be32(f->field_mask);
+		break;
+	case 16:
+		*(__be16 *)mask &= ~cpu_to_be16((u16)f->field_mask);
+		break;
+	default:
+		*(u8 *)mask &= ~(u8)f->field_mask;
+		break;
+	}
 }
 static int offload_pedit_fields(struct mlx5e_priv *priv,
 				int namespace,
@@ -2803,13 +2809,13 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 				struct netlink_ext_ack *extack)
 {
 	struct pedit_headers *set_masks, *add_masks, *set_vals, *add_vals;
-	int i, action_size, first, last, next_z;
 	void *headers_c, *headers_v, *action, *vals_p;
-	u32 *s_masks_p, *a_masks_p, s_mask, a_mask;
 	struct mlx5e_tc_mod_hdr_acts *mod_acts;
+	void *s_masks_p, *a_masks_p;
+	int i, first, last, next_z;
 	struct mlx5_fields *f;
-	unsigned long mask, field_mask;
-	int err;
+	unsigned long mask;
+	u32 s_mask, a_mask;
 	u8 cmd;
 
 	mod_acts = &parse_attr->mod_hdr_acts;
@@ -2821,21 +2827,15 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 	set_vals = &hdrs[0].vals;
 	add_vals = &hdrs[1].vals;
 
-	action_size = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto);
-
 	for (i = 0; i < ARRAY_SIZE(fields); i++) {
 		bool skip;
 
 		f = &fields[i];
-		/* avoid seeing bits set from previous iterations */
-		s_mask = 0;
-		a_mask = 0;
-
 		s_masks_p = (void *)set_masks + f->offset;
 		a_masks_p = (void *)add_masks + f->offset;
 
-		s_mask = *s_masks_p & f->field_mask;
-		a_mask = *a_masks_p & f->field_mask;
+		s_mask = mask_field_get(s_masks_p, f);
+		a_mask = mask_field_get(a_masks_p, f);
 
 		if (!s_mask && !a_mask) /* nothing to offload here */
 			continue;
@@ -2862,22 +2862,20 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 					 match_mask, f->field_bsize))
 				skip = true;
 			/* clear to denote we consumed this field */
-			*s_masks_p &= ~f->field_mask;
+			mask_field_clear(s_masks_p, f);
 		} else {
 			cmd  = MLX5_ACTION_TYPE_ADD;
 			mask = a_mask;
 			vals_p = (void *)add_vals + f->offset;
 			/* add 0 is no change */
-			if ((*(u32 *)vals_p & f->field_mask) == 0)
+			if (!mask_field_get(vals_p, f))
 				skip = true;
 			/* clear to denote we consumed this field */
-			*a_masks_p &= ~f->field_mask;
+			mask_field_clear(a_masks_p, f);
 		}
 		if (skip)
 			continue;
 
-		mask = mask_to_le(mask, f->field_bsize);
-
 		first = find_first_bit(&mask, f->field_bsize);
 		next_z = find_next_zero_bit(&mask, f->field_bsize, first);
 		last  = find_last_bit(&mask, f->field_bsize);
@@ -2890,26 +2888,23 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 			return -EOPNOTSUPP;
 		}
 
-		err = alloc_mod_hdr_actions(priv->mdev, namespace, mod_acts);
-		if (err) {
+		action = mlx5e_mod_hdr_alloc(priv->mdev, namespace, mod_acts);
+		if (IS_ERR(action)) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "too many pedit actions, can't offload");
 			mlx5_core_warn(priv->mdev,
 				       "mlx5: parsed %d pedit actions, can't do more\n",
 				       mod_acts->num_actions);
-			return err;
+			return PTR_ERR(action);
 		}
 
-		action = mod_acts->actions +
-			 (mod_acts->num_actions * action_size);
 		MLX5_SET(set_action_in, action, action_type, cmd);
 		MLX5_SET(set_action_in, action, field, f->field);
 
 		if (cmd == MLX5_ACTION_TYPE_SET) {
+			unsigned long field_mask = f->field_mask;
 			int start;
 
-			field_mask = mask_to_le(f->field_mask, f->field_bsize);
-
 			/* if field is bit sized it can start not from first bit */
 			start = find_first_bit(&field_mask, f->field_bsize);
 
@@ -2931,57 +2926,6 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 	return 0;
 }
 
-static int mlx5e_flow_namespace_max_modify_action(struct mlx5_core_dev *mdev,
-						  int namespace)
-{
-	if (namespace == MLX5_FLOW_NAMESPACE_FDB) /* FDB offloading */
-		return MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, max_modify_header_actions);
-	else /* namespace is MLX5_FLOW_NAMESPACE_KERNEL - NIC offloading */
-		return MLX5_CAP_FLOWTABLE_NIC_RX(mdev, max_modify_header_actions);
-}
-
-int alloc_mod_hdr_actions(struct mlx5_core_dev *mdev,
-			  int namespace,
-			  struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts)
-{
-	int action_size, new_num_actions, max_hw_actions;
-	size_t new_sz, old_sz;
-	void *ret;
-
-	if (mod_hdr_acts->num_actions < mod_hdr_acts->max_actions)
-		return 0;
-
-	action_size = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto);
-
-	max_hw_actions = mlx5e_flow_namespace_max_modify_action(mdev,
-								namespace);
-	new_num_actions = min(max_hw_actions,
-			      mod_hdr_acts->actions ?
-			      mod_hdr_acts->max_actions * 2 : 1);
-	if (mod_hdr_acts->max_actions == new_num_actions)
-		return -ENOSPC;
-
-	new_sz = action_size * new_num_actions;
-	old_sz = mod_hdr_acts->max_actions * action_size;
-	ret = krealloc(mod_hdr_acts->actions, new_sz, GFP_KERNEL);
-	if (!ret)
-		return -ENOMEM;
-
-	memset(ret + old_sz, 0, new_sz - old_sz);
-	mod_hdr_acts->actions = ret;
-	mod_hdr_acts->max_actions = new_num_actions;
-
-	return 0;
-}
-
-void dealloc_mod_hdr_actions(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts)
-{
-	kfree(mod_hdr_acts->actions);
-	mod_hdr_acts->actions = NULL;
-	mod_hdr_acts->num_actions = 0;
-	mod_hdr_acts->max_actions = 0;
-}
-
 static const struct pedit_headers zero_masks = {};
 
 static int
@@ -3004,7 +2948,7 @@ parse_pedit_to_modify_hdr(struct mlx5e_priv *priv,
 		goto out_err;
 	}
 
-	if (!mlx5e_flow_namespace_max_modify_action(priv->mdev, namespace)) {
+	if (!mlx5e_mod_hdr_max_actions(priv->mdev, namespace)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "The pedit offload action is not supported");
 		goto out_err;
@@ -3096,7 +3040,7 @@ static int alloc_tc_pedit_action(struct mlx5e_priv *priv, int namespace,
 	return 0;
 
 out_dealloc_parsed_actions:
-	dealloc_mod_hdr_actions(&parse_attr->mod_hdr_acts);
+	mlx5e_mod_hdr_dealloc(&parse_attr->mod_hdr_acts);
 	return err;
 }
 
@@ -3502,10 +3446,50 @@ static int validate_goto_chain(struct mlx5e_priv *priv,
 	return 0;
 }
 
-static int parse_tc_nic_actions(struct mlx5e_priv *priv,
-				struct flow_action *flow_action,
+static int
+actions_prepare_mod_hdr_actions(struct mlx5e_priv *priv,
 				struct mlx5e_tc_flow *flow,
+				struct mlx5_flow_attr *attr,
+				struct pedit_headers_action *hdrs,
 				struct netlink_ext_ack *extack)
+{
+	struct mlx5e_tc_flow_parse_attr *parse_attr = attr->parse_attr;
+	enum mlx5_flow_namespace_type ns_type;
+	int err;
+
+	if (!hdrs[TCA_PEDIT_KEY_EX_CMD_SET].pedits &&
+	    !hdrs[TCA_PEDIT_KEY_EX_CMD_ADD].pedits)
+		return 0;
+
+	ns_type = get_flow_name_space(flow);
+
+	err = alloc_tc_pedit_action(priv, ns_type, parse_attr, hdrs,
+				    &attr->action, extack);
+	if (err)
+		return err;
+
+	/* In case all pedit actions are skipped, remove the MOD_HDR flag. */
+	if (parse_attr->mod_hdr_acts.num_actions > 0)
+		return 0;
+
+	attr->action &= ~MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
+	mlx5e_mod_hdr_dealloc(&parse_attr->mod_hdr_acts);
+
+	if (ns_type != MLX5_FLOW_NAMESPACE_FDB)
+		return 0;
+
+	if (!((attr->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP) ||
+	      (attr->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH)))
+		attr->esw_attr->split_count = 0;
+
+	return 0;
+}
+
+static int
+parse_tc_nic_actions(struct mlx5e_priv *priv,
+		     struct flow_action *flow_action,
+		     struct mlx5e_tc_flow *flow,
+		     struct netlink_ext_ack *extack)
 {
 	struct mlx5e_tc_flow_parse_attr *parse_attr;
 	struct mlx5_flow_attr *attr = flow->attr;
@@ -3617,21 +3601,6 @@ static int parse_tc_nic_actions(struct mlx5e_priv *priv,
 		}
 	}
 
-	if (hdrs[TCA_PEDIT_KEY_EX_CMD_SET].pedits ||
-	    hdrs[TCA_PEDIT_KEY_EX_CMD_ADD].pedits) {
-		err = alloc_tc_pedit_action(priv, MLX5_FLOW_NAMESPACE_KERNEL,
-					    parse_attr, hdrs, &action, extack);
-		if (err)
-			return err;
-		/* in case all pedit actions are skipped, remove the MOD_HDR
-		 * flag.
-		 */
-		if (parse_attr->mod_hdr_acts.num_actions == 0) {
-			action &= ~MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
-			dealloc_mod_hdr_actions(&parse_attr->mod_hdr_acts);
-		}
-	}
-
 	attr->action = action;
 
 	if (attr->dest_chain && parse_attr->mirred_ifindex[0]) {
@@ -3639,8 +3608,9 @@ static int parse_tc_nic_actions(struct mlx5e_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
-	if (attr->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
-		attr->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	err = actions_prepare_mod_hdr_actions(priv, flow, attr, hdrs, extack);
+	if (err)
+		return err;
 
 	if (!actions_match_supported(priv, flow_action, parse_attr, flow, extack))
 		return -EOPNOTSUPP;
@@ -4195,26 +4165,12 @@ static int parse_tc_fdb_actions(struct mlx5e_priv *priv,
 			return err;
 	}
 
-	if (hdrs[TCA_PEDIT_KEY_EX_CMD_SET].pedits ||
-	    hdrs[TCA_PEDIT_KEY_EX_CMD_ADD].pedits) {
-		err = alloc_tc_pedit_action(priv, MLX5_FLOW_NAMESPACE_FDB,
-					    parse_attr, hdrs, &action, extack);
-		if (err)
-			return err;
-		/* in case all pedit actions are skipped, remove the MOD_HDR
-		 * flag. we might have set split_count either by pedit or
-		 * pop/push. if there is no pop/push either, reset it too.
-		 */
-		if (parse_attr->mod_hdr_acts.num_actions == 0) {
-			action &= ~MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
-			dealloc_mod_hdr_actions(&parse_attr->mod_hdr_acts);
-			if (!((action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP) ||
-			      (action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH)))
-				esw_attr->split_count = 0;
-		}
-	}
-
 	attr->action = action;
+
+	err = actions_prepare_mod_hdr_actions(priv, flow, attr, hdrs, extack);
+	if (err)
+		return err;
+
 	if (!actions_match_supported(priv, flow_action, parse_attr, flow, extack))
 		return -EOPNOTSUPP;
 
@@ -4601,7 +4557,7 @@ mlx5e_add_nic_flow(struct mlx5e_priv *priv,
 
 err_free:
 	flow_flag_set(flow, FAILED);
-	dealloc_mod_hdr_actions(&parse_attr->mod_hdr_acts);
+	mlx5e_mod_hdr_dealloc(&parse_attr->mod_hdr_acts);
 	mlx5e_flow_put(priv, flow);
 out:
 	return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
index f48af82781f8..26a85a11eb6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
@@ -244,11 +244,6 @@ int mlx5e_tc_add_flow_mod_hdr(struct mlx5e_priv *priv,
 			      struct mlx5e_tc_flow *flow,
 			      struct mlx5_flow_attr *attr);
 
-int alloc_mod_hdr_actions(struct mlx5_core_dev *mdev,
-			  int namespace,
-			  struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts);
-void dealloc_mod_hdr_actions(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts);
-
 struct mlx5e_tc_flow;
 u32 mlx5e_tc_get_flow_tun_id(struct mlx5e_tc_flow *flow);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/indir_table.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/indir_table.c
index 425c91814b34..c275fe028b6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/indir_table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/indir_table.c
@@ -14,6 +14,7 @@
 #include "fs_core.h"
 #include "esw/indir_table.h"
 #include "lib/fs_chains.h"
+#include "en/mod_hdr.h"
 
 #define MLX5_ESW_INDIR_TABLE_SIZE 128
 #define MLX5_ESW_INDIR_TABLE_RECIRC_IDX_MAX (MLX5_ESW_INDIR_TABLE_SIZE - 2)
@@ -226,7 +227,7 @@ static int mlx5_esw_indir_table_rule_get(struct mlx5_eswitch *esw,
 		goto err_handle;
 	}
 
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 	rule->handle = handle;
 	rule->vni = esw_attr->rx_tun_attr->vni;
 	rule->mh = flow_act.modify_hdr;
@@ -243,7 +244,7 @@ static int mlx5_esw_indir_table_rule_get(struct mlx5_eswitch *esw,
 	mlx5_modify_header_dealloc(esw->dev, flow_act.modify_hdr);
 err_mod_hdr_alloc:
 err_mod_hdr_regc1:
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 err_mod_hdr_regc0:
 err_ethertype:
 	kfree(rule);
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4cb2510f6fac..d4de5ec690e5 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2553,9 +2553,7 @@ static void rtl_set_rx_mode(struct net_device *dev)
 		rx_mode &= ~AcceptMulticast;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_46 ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_48) {
+		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
 		/* accept all multicasts */
 	} else if (netdev_mc_empty(dev)) {
 		rx_mode &= ~AcceptMulticast;
@@ -4714,10 +4712,16 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	rtl8169_cleanup(tp, true);
 
 	rtl_prepare_power_down(tp);
+
+	if (tp->dash_type != RTL_DASH_NONE)
+		rtl8168_driver_stop(tp);
 }
 
 static void rtl8169_up(struct rtl8169_private *tp)
 {
+	if (tp->dash_type != RTL_DASH_NONE)
+		rtl8168_driver_start(tp);
+
 	pci_set_master(tp->pci_dev);
 	phy_init_hw(tp->phydev);
 	phy_resume(tp->phydev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a43628dd1f4c..2b4c30a5ffcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5165,10 +5165,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			len = 0;
 		}
 
+read_again:
 		if (count >= limit)
 			break;
 
-read_again:
 		buf1_len = 0;
 		buf2_len = 0;
 		entry = next_entry;
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 905542df3b68..5aa9217240d5 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -412,7 +412,7 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 	return addr;
 }
 
-static int ipvlan_process_v4_outbound(struct sk_buff *skb)
+static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 {
 	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net_device *dev = skb->dev;
@@ -454,13 +454,11 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static int ipvlan_process_v6_outbound(struct sk_buff *skb)
+
+static noinline_for_stack int
+ipvlan_route_v6_outbound(struct net_device *dev, struct sk_buff *skb)
 {
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
-	struct net_device *dev = skb->dev;
-	struct net *net = dev_net(dev);
-	struct dst_entry *dst;
-	int err, ret = NET_XMIT_DROP;
 	struct flowi6 fl6 = {
 		.flowi6_oif = dev->ifindex,
 		.daddr = ip6h->daddr,
@@ -470,27 +468,38 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 		.flowi6_mark = skb->mark,
 		.flowi6_proto = ip6h->nexthdr,
 	};
+	struct dst_entry *dst;
+	int err;
 
-	dst = ip6_route_output(net, NULL, &fl6);
-	if (dst->error) {
-		ret = dst->error;
+	dst = ip6_route_output(dev_net(dev), NULL, &fl6);
+	err = dst->error;
+	if (err) {
 		dst_release(dst);
-		goto err;
+		return err;
 	}
 	skb_dst_set(skb, dst);
+	return 0;
+}
+
+static int ipvlan_process_v6_outbound(struct sk_buff *skb)
+{
+	struct net_device *dev = skb->dev;
+	int err, ret = NET_XMIT_DROP;
+
+	err = ipvlan_route_v6_outbound(dev, skb);
+	if (unlikely(err)) {
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return err;
+	}
 
 	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 
-	err = ip6_local_out(net, skb->sk, skb);
+	err = ip6_local_out(dev_net(dev), skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
-	goto out;
-err:
-	DEV_STATS_INC(dev, tx_errors);
-	kfree_skb(skb);
-out:
 	return ret;
 }
 #else
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 3dd1528dde02..6f0b6c924d72 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -770,7 +770,7 @@ static void macvlan_change_rx_flags(struct net_device *dev, int change)
 	if (dev->flags & IFF_UP) {
 		if (change & IFF_ALLMULTI)
 			dev_set_allmulti(lowerdev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
+		if (!macvlan_passthru(vlan->port) && change & IFF_PROMISC)
 			dev_set_promiscuity(lowerdev,
 					    dev->flags & IFF_PROMISC ? 1 : -1);
 
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 422dc92ecac9..514e7f9e0339 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -853,6 +853,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
+		netif_carrier_off(pl->netdev);
 	} else if (config->type == PHYLINK_DEV) {
 		pl->dev = config->dev;
 	} else {
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index af3e048695b6..692c558beed5 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -464,6 +464,10 @@ ppp_sync_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
 	case PPPIOCSMRU:
 		if (get_user(val, (int __user *) argp))
 			break;
+		if (val > U16_MAX) {
+			err = -EINVAL;
+			break;
+		}
 		if (val < PPP_MRU)
 			val = PPP_MRU;
 		ap->mru = val;
@@ -699,7 +703,7 @@ ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
 
 	/* strip address/control field if present */
 	p = skb->data;
-	if (p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
+	if (skb->len >= 2 && p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
 		/* chop off address/control */
 		if (skb->len < 3)
 			goto err;
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 39378e3f9b2b..6e1b65b8ae65 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1139,7 +1139,7 @@ void ath10k_debug_get_et_strings(struct ieee80211_hw *hw,
 				 u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath10k_gstrings_stats,
+		memcpy(data, ath10k_gstrings_stats,
 		       sizeof(ath10k_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 73fe77e7824b..439df8a404d8 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -828,12 +828,20 @@ static void ath10k_snoc_hif_get_default_pipe(struct ath10k *ar,
 
 static inline void ath10k_snoc_irq_disable(struct ath10k *ar)
 {
-	ath10k_ce_disable_interrupts(ar);
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int id;
+
+	for (id = 0; id < CE_COUNT_MAX; id++)
+		disable_irq(ar_snoc->ce_irqs[id].irq_line);
 }
 
 static inline void ath10k_snoc_irq_enable(struct ath10k *ar)
 {
-	ath10k_ce_enable_interrupts(ar);
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int id;
+
+	for (id = 0; id < CE_COUNT_MAX; id++)
+		enable_irq(ar_snoc->ce_irqs[id].irq_line);
 }
 
 static void ath10k_snoc_rx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
@@ -1089,6 +1097,8 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 		goto err_free_rri;
 	}
 
+	ath10k_ce_enable_interrupts(ar);
+
 	return 0;
 
 err_free_rri:
@@ -1253,8 +1263,8 @@ static int ath10k_snoc_request_irq(struct ath10k *ar)
 
 	for (id = 0; id < CE_COUNT_MAX; id++) {
 		ret = request_irq(ar_snoc->ce_irqs[id].irq_line,
-				  ath10k_snoc_per_engine_handler, 0,
-				  ce_name[id], ar);
+				  ath10k_snoc_per_engine_handler,
+				  IRQF_NO_AUTOEN, ce_name[id], ar);
 		if (ret) {
 			ath10k_err(ar,
 				   "failed to register IRQ handler for CE %d: %d\n",
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 357abd87d549..dfdb2eeaf040 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1603,14 +1603,20 @@ static void ath11k_htt_pktlog(struct ath11k_base *ab, struct sk_buff *skb)
 	u8 pdev_id;
 
 	pdev_id = FIELD_GET(HTT_T2H_PPDU_STATS_INFO_PDEV_ID, data->hdr);
+
+	rcu_read_lock();
+
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, pdev_id);
 	if (!ar) {
 		ath11k_warn(ab, "invalid pdev id %d on htt pktlog\n", pdev_id);
-		return;
+		goto out;
 	}
 
 	trace_ath11k_htt_pktlog(ar, data->payload, hdr->size,
 				ar->ab->pktlog_defs_checksum);
+
+out:
+	rcu_read_unlock();
 }
 
 static void ath11k_htt_backpressure_event_handler(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b11070cf159c..28b4527b993f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6809,6 +6809,8 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 		   ev->detector_id, ev->segment_id, ev->timestamp, ev->is_chirp,
 		   ev->freq_offset, ev->sidx);
 
+	rcu_read_lock();
+
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
 
 	if (!ar) {
@@ -6826,6 +6828,8 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 		ieee80211_radar_detected(ar->hw);
 
 exit:
+	rcu_read_unlock();
+
 	kfree(tb);
 }
 
@@ -6855,15 +6859,19 @@ ath11k_wmi_pdev_temperature_event(struct ath11k_base *ab,
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
 		   "pdev temperature ev temp %d pdev_id %d\n", ev->temp, ev->pdev_id);
 
+	rcu_read_lock();
+
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
 	if (!ar) {
 		ath11k_warn(ab, "invalid pdev id in pdev temperature ev %d", ev->pdev_id);
-		kfree(tb);
-		return;
+		goto exit;
 	}
 
 	ath11k_thermal_event_temperature(ar, ev->temp);
 
+exit:
+	rcu_read_unlock();
+
 	kfree(tb);
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 4c81b1d7f417..6a043a49dfe6 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1284,7 +1284,7 @@ void ath9k_get_et_strings(struct ieee80211_hw *hw,
 			  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath9k_gstrings_stats,
+		memcpy(data, ath9k_gstrings_stats,
 		       sizeof(ath9k_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index c55aab01fff5..e79bbcd3279a 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -428,7 +428,7 @@ void ath9k_htc_get_et_strings(struct ieee80211_hw *hw,
 			      u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath9k_htc_gstrings_stats,
+		memcpy(data, ath9k_htc_gstrings_stats,
 		       sizeof(ath9k_htc_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 4375da00f7cf..08dd227bad4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -479,16 +479,20 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			flags |= IWL_TX_FLAGS_ENCRYPT_DIS;
 
 		/*
-		 * For data packets rate info comes from the fw. Only
-		 * set rate/antenna during connection establishment or in case
-		 * no station is given.
+		 * For data and mgmt packets rate info comes from the fw. Only
+		 * set rate/antenna for injected frames with fixed rate, or
+		 * when no sta is given.
 		 */
-		if (!sta || !ieee80211_is_data(hdr->frame_control) ||
-		    mvmsta->sta_state < IEEE80211_STA_AUTHORIZED) {
+		if (unlikely(!sta ||
+			     info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)) {
 			flags |= IWL_TX_FLAGS_CMD_RATE;
 			rate_n_flags =
 				iwl_mvm_get_tx_rate_n_flags(mvm, info, sta,
 							    hdr->frame_control);
+		} else if (!ieee80211_is_data(hdr->frame_control) ||
+			   mvmsta->sta_state < IEEE80211_STA_AUTHORIZED) {
+			/* These are important frames */
+			flags |= IWL_TX_FLAGS_HIGH_PRI;
 		}
 
 		if (mvm->trans->trans_cfg->device_family >=
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 6eb3c845640b..7d7350258683 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2615,7 +2615,7 @@ static void mac80211_hwsim_get_et_strings(struct ieee80211_hw *hw,
 					  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *mac80211_hwsim_gstrings_stats,
+		memcpy(data, mac80211_hwsim_gstrings_stats,
 		       sizeof(mac80211_hwsim_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 380699983a75..e2cd1589818f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1458,7 +1458,7 @@ int wilc_wlan_init(struct net_device *dev)
 	}
 
 	if (!wilc->vmm_table)
-		wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE, GFP_KERNEL);
+		wilc->vmm_table = kcalloc(WILC_VMM_TBL_SIZE, sizeof(u32), GFP_KERNEL);
 
 	if (!wilc->vmm_table) {
 		ret = -ENOBUFS;
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c24dab383654..2696a4544f10 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -377,7 +377,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit exynos_pcie_remove(struct platform_device *pdev)
+static int exynos_pcie_remove(struct platform_device *pdev)
 {
 	struct exynos_pcie *ep = platform_get_drvdata(pdev);
 
@@ -433,7 +433,7 @@ static const struct of_device_id exynos_pcie_of_match[] = {
 
 static struct platform_driver exynos_pcie_driver = {
 	.probe		= exynos_pcie_probe,
-	.remove		= __exit_p(exynos_pcie_remove),
+	.remove		= exynos_pcie_remove,
 	.driver = {
 		.name	= "exynos-pcie",
 		.of_match_table = exynos_pcie_of_match,
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 865258d8c53c..eacdcb0a8771 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1080,7 +1080,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
-static int __init ks_pcie_probe(struct platform_device *pdev)
+static int ks_pcie_probe(struct platform_device *pdev)
 {
 	const struct dw_pcie_host_ops *host_ops;
 	const struct dw_pcie_ep_ops *ep_ops;
@@ -1284,7 +1284,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static int ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
@@ -1300,9 +1300,9 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver ks_pcie_driver __refdata = {
+static struct platform_driver ks_pcie_driver = {
 	.probe  = ks_pcie_probe,
-	.remove = __exit_p(ks_pcie_remove),
+	.remove = ks_pcie_remove,
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = of_match_ptr(ks_pcie_of_match),
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 765abe073228..2f82da76e371 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -7,6 +7,7 @@
  * Author: Vidya Sagar <vidyas@nvidia.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -328,8 +329,7 @@ static void apply_bad_link_workaround(struct pcie_port *pp)
 	 */
 	val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
 	if (val & PCI_EXP_LNKSTA_LBMS) {
-		current_link_width = (val & PCI_EXP_LNKSTA_NLW) >>
-				     PCI_EXP_LNKSTA_NLW_SHIFT;
+		current_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
 		if (pcie->init_link_width > current_link_width) {
 			dev_warn(pci->dev, "PCIe link is bad, width reduced\n");
 			val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
@@ -731,8 +731,7 @@ static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 
 	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKSTA);
-	pcie->init_link_width = (val_w & PCI_EXP_LNKSTA_NLW) >>
-				PCI_EXP_LNKSTA_NLW_SHIFT;
+	pcie->init_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val_w);
 
 	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKCTL);
@@ -889,7 +888,7 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 	/* Configure Max lane width from DT */
 	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_MLW;
-	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
+	val |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, pcie->num_lanes);
 	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
 
 	config_gen3_gen4_eq_presets(pcie);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 813e0d25e841..8f4a4fc48efa 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -910,7 +910,7 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state, d_max;
 
-	if (pdev->no_d3cold)
+	if (pdev->no_d3cold || !pdev->d3cold_allowed)
 		d_max = ACPI_STATE_D3_HOT;
 	else
 		d_max = ACPI_STATE_D3_COLD;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f2909ae93f2f..9cf79afc0ec7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -12,7 +12,7 @@
  * Modeled after usb's driverfs.c
  */
 
-
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
@@ -208,8 +208,7 @@ static ssize_t current_link_width_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	return sysfs_emit(buf, "%u\n",
-		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
+	return sysfs_emit(buf, "%u\n", FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat));
 }
 static DEVICE_ATTR_RO(current_link_width);
 
@@ -509,10 +508,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 		return -EINVAL;
 
 	pdev->d3cold_allowed = !!val;
-	if (pdev->d3cold_allowed)
-		pci_d3cold_enable(pdev);
-	else
-		pci_d3cold_disable(pdev);
+	pci_bridge_d3_update(pdev);
 
 	pm_runtime_resume(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 244c1c2e0876..cc3f620b73bd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3649,14 +3649,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 		return 0;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
-	cap &= PCI_REBAR_CAP_SIZES;
+	cap = FIELD_GET(PCI_REBAR_CAP_SIZES, cap);
 
 	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
 	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
-	    bar == 0 && cap == 0x7000)
-		cap = 0x3f000;
+	    bar == 0 && cap == 0x700)
+		return 0x3f00;
 
-	return cap >> 4;
+	return cap;
 }
 EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
 
@@ -6071,8 +6071,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
 		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
-		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
-			PCI_EXP_LNKSTA_NLW_SHIFT;
+		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 
 		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
 
@@ -6144,7 +6143,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 	if (lnkcap)
-		return (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+		return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
 
 	return PCIE_LNK_WIDTH_UNKNOWN;
 }
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 4a2c229205fd..233e42ddaa9d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1231,6 +1231,8 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 			link->aspm_disable &= ~ASPM_STATE_L1;
 	} else {
 		link->aspm_disable |= state;
+		if (state & ASPM_STATE_L1)
+			link->aspm_disable |= ASPM_STATE_L1SS;
 	}
 
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5955e682c434..5d8768cd7c50 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5379,6 +5379,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
+static void quirk_no_ats(struct pci_dev *pdev)
+{
+	pci_info(pdev, "disabling ATS\n");
+	pdev->ats_cap = 0;
+}
+
 /*
  * Some devices require additional driver setup to enable ATS.  Don't use
  * ATS for those devices as ATS will be enabled before the driver has had a
@@ -5392,14 +5398,10 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 		    (pdev->subsystem_device == 0xce19 ||
 		     pdev->subsystem_device == 0xcc10 ||
 		     pdev->subsystem_device == 0xcc08))
-			goto no_ats;
-		else
-			return;
+			quirk_no_ats(pdev);
+	} else {
+		quirk_no_ats(pdev);
 	}
-
-no_ats:
-	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
 }
 
 /* AMD Stoney platform GPU */
@@ -5422,6 +5424,25 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
 /* AMD Raven platform iGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
+
+/*
+ * Intel IPU E2000 revisions before C0 implement incorrect endianness
+ * in ATS Invalidate Request message body. Disable ATS for those devices.
+ */
+static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
+{
+	if (pdev->revision < 0x20)
+		quirk_no_ats(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1451, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1452, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1453, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1454, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1455, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3dc055ce6e61..99c19a0b9151 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9766,6 +9766,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
 	TPACPI_Q_LNV3('R', '0', 'B', true), /* Thinkpad 11e gen 3 */
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index af3bc65c4595..9311f3d09c8f 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -487,7 +487,8 @@ ssize_t ptp_read(struct posix_clock *pc,
 
 	for (i = 0; i < cnt; i++) {
 		event[i] = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 
 	spin_unlock_irqrestore(&queue->lock, flags);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 8a652a367625..e70c6dec3a3a 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -56,10 +56,11 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
 	dst->t.sec = seconds;
 	dst->t.nsec = remainder;
 
+	/* Both WRITE_ONCE() are paired with READ_ONCE() in queue_cnt() */
 	if (!queue_free(queue))
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 
-	queue->tail = (queue->tail + 1) % PTP_MAX_TIMESTAMPS;
+	WRITE_ONCE(queue->tail, (queue->tail + 1) % PTP_MAX_TIMESTAMPS);
 
 	spin_unlock_irqrestore(&queue->lock, flags);
 }
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index dba6be477067..b336c12bb697 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -74,9 +74,13 @@ struct ptp_vclock {
  * that a writer might concurrently increment the tail does not
  * matter, since the queue remains nonempty nonetheless.
  */
-static inline int queue_cnt(struct timestamp_event_queue *q)
+static inline int queue_cnt(const struct timestamp_event_queue *q)
 {
-	int cnt = q->tail - q->head;
+	/*
+	 * Paired with WRITE_ONCE() in enqueue_external_timestamp(),
+	 * ptp_read(), extts_fifo_show().
+	 */
+	int cnt = READ_ONCE(q->tail) - READ_ONCE(q->head);
 	return cnt < 0 ? PTP_MAX_TIMESTAMPS + cnt : cnt;
 }
 
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 9233bfedeb17..0bdfdd4bb0fa 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -79,7 +79,8 @@ static ssize_t extts_fifo_show(struct device *dev,
 	qcnt = queue_cnt(queue);
 	if (qcnt) {
 		event = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 	spin_unlock_irqrestore(&queue->lock, flags);
 
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index d9b804943d19..4968964ac5de 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -955,6 +955,10 @@ EXPORT_SYMBOL(ap_driver_unregister);
 
 void ap_bus_force_rescan(void)
 {
+	/* Only trigger AP bus scans after the initial scan is done */
+	if (atomic64_read(&ap_scan_bus_count) <= 0)
+		return;
+
 	/* processing a asynchronous bus rescan */
 	del_timer(&ap_config_timer);
 	queue_work(system_long_wq, &ap_scan_work);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index b8a12d3ad5f2..d1c07e7cb60d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4718,6 +4718,12 @@ static void debugfs_bist_init_v3_hw(struct hisi_hba *hisi_hba)
 	hisi_hba->debugfs_bist_linkrate = SAS_LINK_RATE_1_5_GBPS;
 }
 
+static void debugfs_exit_v3_hw(struct hisi_hba *hisi_hba)
+{
+	debugfs_remove_recursive(hisi_hba->debugfs_dir);
+	hisi_hba->debugfs_dir = NULL;
+}
+
 static void debugfs_init_v3_hw(struct hisi_hba *hisi_hba)
 {
 	struct device *dev = hisi_hba->dev;
@@ -4741,18 +4747,13 @@ static void debugfs_init_v3_hw(struct hisi_hba *hisi_hba)
 
 	for (i = 0; i < hisi_sas_debugfs_dump_count; i++) {
 		if (debugfs_alloc_v3_hw(hisi_hba, i)) {
-			debugfs_remove_recursive(hisi_hba->debugfs_dir);
+			debugfs_exit_v3_hw(hisi_hba);
 			dev_dbg(dev, "failed to init debugfs!\n");
 			break;
 		}
 	}
 }
 
-static void debugfs_exit_v3_hw(struct hisi_hba *hisi_hba)
-{
-	debugfs_remove_recursive(hisi_hba->debugfs_dir);
-}
-
 static int
 hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index d169ba772450..85444ca1ae21 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1518,7 +1518,11 @@ static struct ibmvfc_event *ibmvfc_get_event(struct ibmvfc_queue *queue)
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->l_lock, flags);
-	BUG_ON(list_empty(&queue->free));
+	if (list_empty(&queue->free)) {
+		ibmvfc_log(queue->vhost, 4, "empty event pool on queue:%ld\n", queue->hwq_id);
+		spin_unlock_irqrestore(&queue->l_lock, flags);
+		return NULL;
+	}
 	evt = list_entry(queue->free.next, struct ibmvfc_event, queue_list);
 	atomic_set(&evt->free, 0);
 	list_del(&evt->queue_list);
@@ -1947,9 +1951,15 @@ static int ibmvfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	if (vhost->using_channels) {
 		scsi_channel = hwq % vhost->scsi_scrqs.active_queues;
 		evt = ibmvfc_get_event(&vhost->scsi_scrqs.scrqs[scsi_channel]);
+		if (!evt)
+			return SCSI_MLQUEUE_HOST_BUSY;
+
 		evt->hwq = hwq % vhost->scsi_scrqs.active_queues;
-	} else
+	} else {
 		evt = ibmvfc_get_event(&vhost->crq);
+		if (!evt)
+			return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
 	ibmvfc_init_event(evt, ibmvfc_scsi_done, IBMVFC_CMD_FORMAT);
 	evt->cmnd = cmnd;
@@ -2037,6 +2047,11 @@ static int ibmvfc_bsg_timeout(struct bsg_job *job)
 
 	vhost->aborting_passthru = 1;
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		spin_unlock_irqrestore(vhost->host->host_lock, flags);
+		return -ENOMEM;
+	}
+
 	ibmvfc_init_event(evt, ibmvfc_bsg_timeout_done, IBMVFC_MAD_FORMAT);
 
 	tmf = &evt->iu.tmf;
@@ -2095,6 +2110,10 @@ static int ibmvfc_bsg_plogi(struct ibmvfc_host *vhost, unsigned int port_id)
 		goto unlock_out;
 
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		rc = -ENOMEM;
+		goto unlock_out;
+	}
 	ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_MAD_FORMAT);
 	plogi = &evt->iu.plogi;
 	memset(plogi, 0, sizeof(*plogi));
@@ -2213,6 +2232,11 @@ static int ibmvfc_bsg_request(struct bsg_job *job)
 	}
 
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		spin_unlock_irqrestore(vhost->host->host_lock, flags);
+		rc = -ENOMEM;
+		goto out;
+	}
 	ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_MAD_FORMAT);
 	mad = &evt->iu.passthru;
 
@@ -2301,6 +2325,11 @@ static int ibmvfc_reset_device(struct scsi_device *sdev, int type, char *desc)
 		else
 			evt = ibmvfc_get_event(&vhost->crq);
 
+		if (!evt) {
+			spin_unlock_irqrestore(vhost->host->host_lock, flags);
+			return -ENOMEM;
+		}
+
 		ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_CMD_FORMAT);
 		tmf = ibmvfc_init_vfc_cmd(evt, sdev);
 		iu = ibmvfc_get_fcp_iu(vhost, tmf);
@@ -2504,6 +2533,8 @@ static struct ibmvfc_event *ibmvfc_init_tmf(struct ibmvfc_queue *queue,
 	struct ibmvfc_tmf *tmf;
 
 	evt = ibmvfc_get_event(queue);
+	if (!evt)
+		return NULL;
 	ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_MAD_FORMAT);
 
 	tmf = &evt->iu.tmf;
@@ -2560,6 +2591,11 @@ static int ibmvfc_cancel_all_mq(struct scsi_device *sdev, int type)
 
 		if (found_evt && vhost->logged_in) {
 			evt = ibmvfc_init_tmf(&queues[i], sdev, type);
+			if (!evt) {
+				spin_unlock(queues[i].q_lock);
+				spin_unlock_irqrestore(vhost->host->host_lock, flags);
+				return -ENOMEM;
+			}
 			evt->sync_iu = &queues[i].cancel_rsp;
 			ibmvfc_send_event(evt, vhost, default_timeout);
 			list_add_tail(&evt->cancel, &cancelq);
@@ -2773,6 +2809,10 @@ static int ibmvfc_abort_task_set(struct scsi_device *sdev)
 
 	if (vhost->state == IBMVFC_ACTIVE) {
 		evt = ibmvfc_get_event(&vhost->crq);
+		if (!evt) {
+			spin_unlock_irqrestore(vhost->host->host_lock, flags);
+			return -ENOMEM;
+		}
 		ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_CMD_FORMAT);
 		tmf = ibmvfc_init_vfc_cmd(evt, sdev);
 		iu = ibmvfc_get_fcp_iu(vhost, tmf);
@@ -4029,6 +4069,12 @@ static void ibmvfc_tgt_send_prli(struct ibmvfc_target *tgt)
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	ibmvfc_init_event(evt, ibmvfc_tgt_prli_done, IBMVFC_MAD_FORMAT);
 	evt->tgt = tgt;
@@ -4136,6 +4182,12 @@ static void ibmvfc_tgt_send_plogi(struct ibmvfc_target *tgt)
 	kref_get(&tgt->kref);
 	tgt->logo_rcvd = 0;
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_INIT_WAIT);
 	ibmvfc_init_event(evt, ibmvfc_tgt_plogi_done, IBMVFC_MAD_FORMAT);
@@ -4212,6 +4264,8 @@ static struct ibmvfc_event *__ibmvfc_tgt_get_implicit_logout_evt(struct ibmvfc_t
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt)
+		return NULL;
 	ibmvfc_init_event(evt, done, IBMVFC_MAD_FORMAT);
 	evt->tgt = tgt;
 	mad = &evt->iu.implicit_logout;
@@ -4239,6 +4293,13 @@ static void ibmvfc_tgt_implicit_logout(struct ibmvfc_target *tgt)
 	vhost->discovery_threads++;
 	evt = __ibmvfc_tgt_get_implicit_logout_evt(tgt,
 						   ibmvfc_tgt_implicit_logout_done);
+	if (!evt) {
+		vhost->discovery_threads--;
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_INIT_WAIT);
 	if (ibmvfc_send_event(evt, vhost, default_timeout)) {
@@ -4378,6 +4439,12 @@ static void ibmvfc_tgt_move_login(struct ibmvfc_target *tgt)
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_INIT_WAIT);
 	ibmvfc_init_event(evt, ibmvfc_tgt_move_login_done, IBMVFC_MAD_FORMAT);
@@ -4544,6 +4611,14 @@ static void ibmvfc_adisc_timeout(struct timer_list *t)
 	vhost->abort_threads++;
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		tgt_err(tgt, "Failed to get cancel event for ADISC.\n");
+		vhost->abort_threads--;
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		spin_unlock_irqrestore(vhost->host->host_lock, flags);
+		return;
+	}
 	ibmvfc_init_event(evt, ibmvfc_tgt_adisc_cancel_done, IBMVFC_MAD_FORMAT);
 
 	evt->tgt = tgt;
@@ -4594,6 +4669,12 @@ static void ibmvfc_tgt_adisc(struct ibmvfc_target *tgt)
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	ibmvfc_init_event(evt, ibmvfc_tgt_adisc_done, IBMVFC_MAD_FORMAT);
 	evt->tgt = tgt;
@@ -4697,6 +4778,12 @@ static void ibmvfc_tgt_query_target(struct ibmvfc_target *tgt)
 
 	kref_get(&tgt->kref);
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		kref_put(&tgt->kref, ibmvfc_release_tgt);
+		__ibmvfc_reset_host(vhost);
+		return;
+	}
 	vhost->discovery_threads++;
 	evt->tgt = tgt;
 	ibmvfc_init_event(evt, ibmvfc_tgt_query_target_done, IBMVFC_MAD_FORMAT);
@@ -4869,6 +4956,13 @@ static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_discover_targets *mad;
 	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
+
+	if (!evt) {
+		ibmvfc_log(vhost, level, "Discover Targets failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
 
 	ibmvfc_init_event(evt, ibmvfc_discover_targets_done, IBMVFC_MAD_FORMAT);
 	mad = &evt->iu.discover_targets;
@@ -4946,8 +5040,15 @@ static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
 	struct ibmvfc_scsi_channels *scrqs = &vhost->scsi_scrqs;
 	unsigned int num_channels =
 		min(vhost->client_scsi_channels, vhost->max_vios_scsi_channels);
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 	int i;
 
+	if (!evt) {
+		ibmvfc_log(vhost, level, "Channel Setup failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
+
 	memset(setup_buf, 0, sizeof(*setup_buf));
 	if (num_channels == 0)
 		setup_buf->flags = cpu_to_be32(IBMVFC_CANCEL_CHANNELS);
@@ -5009,6 +5110,13 @@ static void ibmvfc_channel_enquiry(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_channel_enquiry *mad;
 	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
+
+	if (!evt) {
+		ibmvfc_log(vhost, level, "Channel Enquiry failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
 
 	ibmvfc_init_event(evt, ibmvfc_channel_enquiry_done, IBMVFC_MAD_FORMAT);
 	mad = &evt->iu.channel_enquiry;
@@ -5131,6 +5239,12 @@ static void ibmvfc_npiv_login(struct ibmvfc_host *vhost)
 	struct ibmvfc_npiv_login_mad *mad;
 	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
 
+	if (!evt) {
+		ibmvfc_dbg(vhost, "NPIV Login failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
+
 	ibmvfc_gather_partition_info(vhost);
 	ibmvfc_set_login_info(vhost);
 	ibmvfc_init_event(evt, ibmvfc_npiv_login_done, IBMVFC_MAD_FORMAT);
@@ -5195,6 +5309,12 @@ static void ibmvfc_npiv_logout(struct ibmvfc_host *vhost)
 	struct ibmvfc_event *evt;
 
 	evt = ibmvfc_get_event(&vhost->crq);
+	if (!evt) {
+		ibmvfc_dbg(vhost, "NPIV Logout failed: no available events\n");
+		ibmvfc_hard_reset_host(vhost);
+		return;
+	}
+
 	ibmvfc_init_event(evt, ibmvfc_npiv_logout_done, IBMVFC_MAD_FORMAT);
 
 	mad = &evt->iu.npiv_logout;
diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index 19cd4a95d354..d158c5eff059 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -241,6 +241,12 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
 	}
 	mutex_lock(&lport->disc.disc_mutex);
 	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
+	if (!lport->ptp_rdata) {
+		printk(KERN_WARNING "libfc: Failed to setup lport 0x%x\n",
+			lport->port_id);
+		mutex_unlock(&lport->disc.disc_mutex);
+		return;
+	}
 	kref_get(&lport->ptp_rdata->kref);
 	lport->ptp_rdata->ids.port_name = remote_wwpn;
 	lport->ptp_rdata->ids.node_name = remote_wwnn;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 00b8b7a85388..c2c247a49ce9 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -263,13 +263,13 @@ u32 megasas_readl(struct megasas_instance *instance,
 	 * Fusion registers could intermittently return all zeroes.
 	 * This behavior is transient in nature and subsequent reads will
 	 * return valid value. As a workaround in driver, retry readl for
-	 * upto three times until a non-zero value is read.
+	 * up to thirty times until a non-zero value is read.
 	 */
 	if (instance->adapter_type == AERO_SERIES) {
 		do {
 			ret_val = readl(addr);
 			i++;
-		} while (ret_val == 0 && i < 3);
+		} while (ret_val == 0 && i < 30);
 		return ret_val;
 	} else {
 		return readl(addr);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index d7dabf53a0d5..e524e1fc53fa 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -224,8 +224,8 @@ _base_readl_ext_retry(const volatile void __iomem *addr)
 
 	for (i = 0 ; i < 30 ; i++) {
 		ret_val = readl(addr);
-		if (ret_val == 0)
-			continue;
+		if (ret_val != 0)
+			break;
 	}
 
 	return ret_val;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 1b175e5c0cfc..a2d3f8bb63a0 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1823,8 +1823,16 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 		}
 
 		spin_lock_irqsave(qp->qp_lock_ptr, *flags);
-		if (ret_cmd && blk_mq_request_started(scsi_cmd_to_rq(cmd)))
-			sp->done(sp, res);
+		switch (sp->type) {
+		case SRB_SCSI_CMD:
+			if (ret_cmd && blk_mq_request_started(scsi_cmd_to_rq(cmd)))
+				sp->done(sp, res);
+			break;
+		default:
+			if (ret_cmd)
+				sp->done(sp, res);
+			break;
+		}
 	} else {
 		sp->done(sp, res);
 	}
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index f2f066ce8d9e..141acc662eba 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -377,18 +377,21 @@ void xen_console_resume(void)
 #ifdef CONFIG_HVC_XEN_FRONTEND
 static void xencons_disconnect_backend(struct xencons_info *info)
 {
-	if (info->irq > 0)
-		unbind_from_irqhandler(info->irq, NULL);
-	info->irq = 0;
+	if (info->hvc != NULL)
+		hvc_remove(info->hvc);
+	info->hvc = NULL;
+	if (info->irq > 0) {
+		evtchn_put(info->evtchn);
+		info->irq = 0;
+		info->evtchn = 0;
+	}
+	/* evtchn_put() will also close it so this is only an error path */
 	if (info->evtchn > 0)
 		xenbus_free_evtchn(info->xbdev, info->evtchn);
 	info->evtchn = 0;
 	if (info->gntref > 0)
 		gnttab_free_grant_references(info->gntref);
 	info->gntref = 0;
-	if (info->hvc != NULL)
-		hvc_remove(info->hvc);
-	info->hvc = NULL;
 }
 
 static void xencons_free(struct xencons_info *info)
@@ -433,7 +436,7 @@ static int xencons_connect_backend(struct xenbus_device *dev,
 	if (ret)
 		return ret;
 	info->evtchn = evtchn;
-	irq = bind_interdomain_evtchn_to_irq_lateeoi(dev, evtchn);
+	irq = bind_evtchn_to_irq_lateeoi(evtchn);
 	if (irq < 0)
 		return irq;
 	info->irq = irq;
@@ -553,10 +556,23 @@ static void xencons_backend_changed(struct xenbus_device *dev,
 		if (dev->state == XenbusStateClosed)
 			break;
 		fallthrough;	/* Missed the backend's CLOSING state */
-	case XenbusStateClosing:
+	case XenbusStateClosing: {
+		struct xencons_info *info = dev_get_drvdata(&dev->dev);;
+
+		/*
+		 * Don't tear down the evtchn and grant ref before the other
+		 * end has disconnected, but do stop userspace from trying
+		 * to use the device before we allow the backend to close.
+		 */
+		if (info->hvc) {
+			hvc_remove(info->hvc);
+			info->hvc = NULL;
+		}
+
 		xenbus_frontend_closed(dev);
 		break;
 	}
+	}
 }
 
 static const struct xenbus_device_id xencons_ids[] = {
@@ -587,7 +603,7 @@ static int __init xen_hvc_init(void)
 		ops = &dom0_hvc_ops;
 		r = xen_initial_domain_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 		info = vtermno_to_xencons(HVC_COOKIE);
 	} else {
 		ops = &domU_hvc_ops;
@@ -596,7 +612,7 @@ static int __init xen_hvc_init(void)
 		else
 			r = xen_pv_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 
 		info = vtermno_to_xencons(HVC_COOKIE);
 		info->irq = bind_evtchn_to_irq_lateeoi(info->evtchn);
@@ -615,12 +631,13 @@ static int __init xen_hvc_init(void)
 		list_del(&info->list);
 		spin_unlock_irqrestore(&xencons_lock, flags);
 		if (info->irq)
-			unbind_from_irqhandler(info->irq, NULL);
+			evtchn_put(info->evtchn);
 		kfree(info);
 		return r;
 	}
 
 	r = 0;
+ register_fe:
 #ifdef CONFIG_HVC_XEN_FRONTEND
 	r = xenbus_register_frontend(&xencons_driver);
 #endif
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 62e6c1af1344..7e653d681ac0 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -368,10 +368,14 @@ static void meson_uart_set_termios(struct uart_port *port,
 	else
 		val |= AML_UART_STOP_BIT_1SB;
 
-	if (cflags & CRTSCTS)
-		val &= ~AML_UART_TWO_WIRE_EN;
-	else
+	if (cflags & CRTSCTS) {
+		if (port->flags & UPF_HARD_FLOW)
+			val &= ~AML_UART_TWO_WIRE_EN;
+		else
+			termios->c_cflag &= ~CRTSCTS;
+	} else {
 		val |= AML_UART_TWO_WIRE_EN;
+	}
 
 	writel(val, port->membase + AML_UART_CONTROL);
 
@@ -726,10 +730,12 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
 
 static int meson_uart_probe(struct platform_device *pdev)
 {
-	struct resource *res_mem, *res_irq;
+	struct resource *res_mem;
 	struct uart_port *port;
 	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
+	int irq;
+	bool has_rtscts;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -752,11 +758,12 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!res_mem)
 		return -ENODEV;
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_irq)
-		return -ENODEV;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
 
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
@@ -779,8 +786,10 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->iotype = UPIO_MEM;
 	port->mapbase = res_mem->start;
 	port->mapsize = resource_size(res_mem);
-	port->irq = res_irq->start;
+	port->irq = irq;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
+	if (has_rtscts)
+		port->flags |= UPF_HARD_FLOW;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
 	port->dev = &pdev->dev;
 	port->line = pdev->id;
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 4ffed77f8001..a3d54a1bd8ac 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -263,13 +263,14 @@ static void sysrq_handle_showallcpus(int key)
 		if (in_hardirq())
 			regs = get_irq_regs();
 
-		pr_info("CPU%d:\n", smp_processor_id());
+		pr_info("CPU%d:\n", get_cpu());
 		if (regs)
 			show_regs(regs);
 		else
 			show_stack(NULL, NULL, KERN_INFO);
 
 		schedule_work(&sysrq_showallcpus);
+		put_cpu();
 	}
 }
 
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index e11383ae1e7e..71356d9684ba 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -578,18 +578,22 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		return -ENOMEM;
 
 	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
+	if (!name) {
+		rv = -ENOMEM;
+		goto free_port;
+	}
 
 	rv = vio_driver_init(&port->vio, vdev, VDEV_CONSOLE_CON, vcc_versions,
 			     ARRAY_SIZE(vcc_versions), NULL, name);
 	if (rv)
-		goto free_port;
+		goto free_name;
 
 	port->vio.debug = vcc_dbg_vio;
 	vcc_ldc_cfg.debug = vcc_dbg_ldc;
 
 	rv = vio_ldc_alloc(&port->vio, &vcc_ldc_cfg, port);
 	if (rv)
-		goto free_port;
+		goto free_name;
 
 	spin_lock_init(&port->lock);
 
@@ -623,6 +627,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto unreg_tty;
 	}
 	port->domain = kstrdup(domain, GFP_KERNEL);
+	if (!port->domain) {
+		rv = -ENOMEM;
+		goto unreg_tty;
+	}
+
 
 	mdesc_release(hp);
 
@@ -652,8 +661,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	vcc_table_remove(port->index);
 free_ldc:
 	vio_ldc_free(&port->vio);
-free_port:
+free_name:
 	kfree(name);
+free_port:
 	kfree(port);
 
 	return rv;
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index aabaedb2e069..bd095ae569ed 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1429,7 +1429,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_composite_dev *cdev = c->cdev;
 	struct f_ncm		*ncm = func_to_ncm(f);
 	struct usb_string	*us;
-	int			status;
+	int			status = 0;
 	struct usb_ep		*ep;
 	struct f_ncm_opts	*ncm_opts;
 
@@ -1447,22 +1447,17 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 		f->os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
 	}
 
-	/*
-	 * in drivers/usb/gadget/configfs.c:configfs_composite_bind()
-	 * configurations are bound in sequence with list_for_each_entry,
-	 * in each configuration its functions are bound in sequence
-	 * with list_for_each_entry, so we assume no race condition
-	 * with regard to ncm_opts->bound access
-	 */
-	if (!ncm_opts->bound) {
-		mutex_lock(&ncm_opts->lock);
-		gether_set_gadget(ncm_opts->net, cdev->gadget);
+	mutex_lock(&ncm_opts->lock);
+	gether_set_gadget(ncm_opts->net, cdev->gadget);
+	if (!ncm_opts->bound)
 		status = gether_register_netdev(ncm_opts->net);
-		mutex_unlock(&ncm_opts->lock);
-		if (status)
-			goto fail;
-		ncm_opts->bound = true;
-	}
+	mutex_unlock(&ncm_opts->lock);
+
+	if (status)
+		goto fail;
+
+	ncm_opts->bound = true;
+
 	us = usb_gstrings_attach(cdev, ncm_strings,
 				 ARRAY_SIZE(ncm_string_defs));
 	if (IS_ERR(us)) {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index d0223facb92a..af5b5b4fa5d1 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -509,7 +509,9 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
 	pm_runtime_put_noidle(&dev->dev);
 
-	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
+	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
+		pm_runtime_forbid(&dev->dev);
+	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
 
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 63862803421f..7bf28545b47a 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -153,14 +153,14 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
 	timeout = clamp_t(unsigned int, timeout, 1, wdd->max_hw_heartbeat_ms / 1000);
 
 	if (action)
-		sbsa_gwdt_reg_write(gwdt->clk * timeout, gwdt);
+		sbsa_gwdt_reg_write((u64)gwdt->clk * timeout, gwdt);
 	else
 		/*
 		 * In the single stage mode, The first signal (WS0) is ignored,
 		 * the timeout is (WOR * 2), so the WOR should be configured
 		 * to half value of timeout.
 		 */
-		sbsa_gwdt_reg_write(gwdt->clk / 2 * timeout, gwdt);
+		sbsa_gwdt_reg_write(((u64)gwdt->clk / 2) * timeout, gwdt);
 
 	return 0;
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 9339f2aad567..ee691b20d4a3 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -599,7 +599,9 @@ static void lateeoi_list_add(struct irq_info *info)
 
 	spin_lock_irqsave(&eoi->eoi_list_lock, flags);
 
-	if (list_empty(&eoi->eoi_list)) {
+	elem = list_first_entry_or_null(&eoi->eoi_list, struct irq_info,
+					eoi_list);
+	if (!elem || info->eoi_time < elem->eoi_time) {
 		list_add(&info->eoi_list, &eoi->eoi_list);
 		mod_delayed_work_on(info->eoi_cpu, system_wq,
 				    &eoi->delayed, delay);
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index ee331845e2c7..31799ac10e33 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -73,7 +73,7 @@ ssize_t v9fs_xattr_get(struct dentry *dentry, const char *name,
 	struct p9_fid *fid;
 	int ret;
 
-	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu\n",
+	p9_debug(P9_DEBUG_VFS, "name = '%s' value_len = %zu\n",
 		 name, buffer_size);
 	fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
@@ -144,7 +144,8 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 
 ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
-	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
+	/* Txattrwalk with an empty string lists xattrs instead */
+	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
 }
 
 static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index b934429c2435..4feddabe40a4 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -312,9 +312,6 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	} else {
 		if (current->journal_info)
 			flush = BTRFS_RESERVE_FLUSH_LIMIT;
-
-		if (btrfs_transaction_in_commit(fs_info))
-			schedule_timeout(1);
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 353bd0dd7026..66b4413b94f7 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -64,8 +64,8 @@ struct key_type cifs_spnego_key_type = {
  * strlen(";sec=ntlmsspi") */
 #define MAX_MECH_STR_LEN	13
 
-/* strlen of "host=" */
-#define HOST_KEY_LEN		5
+/* strlen of ";host=" */
+#define HOST_KEY_LEN		6
 
 /* strlen of ";ip4=" or ";ip6=" */
 #define IP_KEY_LEN		5
diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index 390cc5e8c746..0f2e0ce84a03 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -430,6 +430,8 @@ generate_smb3signingkey(struct cifs_ses *ses,
 				  ptriplet->encryption.context,
 				  ses->smb3encryptionkey,
 				  SMB3_ENC_DEC_KEY_SIZE);
+		if (rc)
+			return rc;
 		rc = generate_key(ses, ptriplet->decryption.label,
 				  ptriplet->decryption.context,
 				  ses->smb3decryptionkey,
@@ -438,9 +440,6 @@ generate_smb3signingkey(struct cifs_ses *ses,
 			return rc;
 	}
 
-	if (rc)
-		return rc;
-
 #ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
 	cifs_dbg(VFS, "%s: dumping generated AES session keys\n", __func__);
 	/*
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index b22d6c984f8c..cfa46d8cf5b3 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -330,14 +330,20 @@ static int exfat_find_empty_entry(struct inode *inode,
 		if (exfat_check_max_dentries(inode))
 			return -ENOSPC;
 
-		/* we trust p_dir->size regardless of FAT type */
-		if (exfat_find_last_cluster(sb, p_dir, &last_clu))
-			return -EIO;
-
 		/*
 		 * Allocate new cluster to this directory
 		 */
-		exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
+		if (ei->start_clu != EXFAT_EOF_CLUSTER) {
+			/* we trust p_dir->size regardless of FAT type */
+			if (exfat_find_last_cluster(sb, p_dir, &last_clu))
+				return -EIO;
+
+			exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
+		} else {
+			/* This directory is empty */
+			exfat_chain_set(&clu, EXFAT_EOF_CLUSTER, 0,
+					ALLOC_NO_FAT_CHAIN);
+		}
 
 		/* allocate a cluster */
 		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode));
@@ -347,6 +353,11 @@ static int exfat_find_empty_entry(struct inode *inode,
 		if (exfat_zeroed_cluster(inode, clu.dir))
 			return -EIO;
 
+		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
+			ei->start_clu = clu.dir;
+			p_dir->dir = clu.dir;
+		}
+
 		/* append to the FAT chain */
 		if (clu.flags != p_dir->flags) {
 			/* no-fat-chain bit is disabled,
@@ -644,7 +655,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->type = exfat_get_entry_type(ep);
 	info->attr = le16_to_cpu(ep->dentry.file.attr);
 	info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
-	if ((info->type == TYPE_FILE) && (info->size == 0)) {
+	if (info->size == 0) {
 		info->flags = ALLOC_NO_FAT_CHAIN;
 		info->start_clu = EXFAT_EOF_CLUSTER;
 	} else {
@@ -891,6 +902,9 @@ static int exfat_check_dir_empty(struct super_block *sb,
 
 	dentries_per_clu = sbi->dentries_per_clu;
 
+	if (p_dir->dir == EXFAT_EOF_CLUSTER)
+		return 0;
+
 	exfat_chain_dup(&clu, p_dir);
 
 	while (clu.dir != EXFAT_EOF_CLUSTER) {
@@ -1274,7 +1288,8 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		}
 
 		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
-		if (new_entry_type == TYPE_DIR) {
+		if (new_entry_type == TYPE_DIR &&
+		    new_ei->start_clu != EXFAT_EOF_CLUSTER) {
 			/* new_ei, new_clu_to_free */
 			struct exfat_chain new_clu_to_free;
 
diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 3219669732bf..0db6ae0ca936 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,6 +68,11 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
+	/* usually, the umask is applied by posix_acl_create(), but if
+	   ext4 ACL support is disabled at compile time, we need to do
+	   it here, because posix_acl_create() will never be called */
+	inode->i_mode &= ~current_umask();
+
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index fee54ab42bba..7806adcc41a7 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1366,8 +1366,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			}
 		}
 		if (count_reserved)
-			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
-				   &orig_es, &rc);
+			count_rsvd(inode, orig_es.es_lblk + len1,
+				   orig_es.es_len - len1 - len2, &orig_es, &rc);
 		goto out_get_reserved;
 	}
 
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 589ed99856f3..d0c41343a5c4 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -556,13 +556,8 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 		if (meta_bg == 0 && !ext4_bg_has_super(sb, group))
 			goto handle_itb;
 
-		if (meta_bg == 1) {
-			ext4_group_t first_group;
-			first_group = ext4_meta_bg_first_group(sb, group);
-			if (first_group != group + 1 &&
-			    first_group != group + EXT4_DESC_PER_BLOCK(sb) - 1)
-				goto handle_itb;
-		}
+		if (meta_bg == 1)
+			goto handle_itb;
 
 		block = start + ext4_bg_has_super(sb, group);
 		/* Copy all of the GDT blocks into the backup in this group */
@@ -1165,8 +1160,10 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
 			   ext4_group_first_block_no(sb, group));
 		BUFFER_TRACE(bh, "get_write_access");
 		if ((err = ext4_journal_get_write_access(handle, sb, bh,
-							 EXT4_JTR_NONE)))
+							 EXT4_JTR_NONE))) {
+			brelse(bh);
 			break;
+		}
 		lock_buffer(bh);
 		memcpy(bh->b_data, data, size);
 		if (rest)
@@ -1555,6 +1552,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int gdb_num_end = ((group + flex_gd->count - 1) /
 				   EXT4_DESC_PER_BLOCK(sb));
 		int meta_bg = ext4_has_feature_meta_bg(sb);
+		sector_t padding_blocks = meta_bg ? 0 : sbi->s_sbh->b_blocknr -
+					 ext4_group_first_block_no(sb, 0);
 		sector_t old_gdb = 0;
 
 		update_backups(sb, ext4_group_first_block_no(sb, 0),
@@ -1566,8 +1565,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 						     gdb_num);
 			if (old_gdb == gdb_bh->b_blocknr)
 				continue;
-			update_backups(sb, gdb_bh->b_blocknr, gdb_bh->b_data,
-				       gdb_bh->b_size, meta_bg);
+			update_backups(sb, gdb_bh->b_blocknr - padding_blocks,
+				       gdb_bh->b_data, gdb_bh->b_size, meta_bg);
 			old_gdb = gdb_bh->b_blocknr;
 		}
 	}
@@ -1936,9 +1935,7 @@ static int ext4_convert_meta_bg(struct super_block *sb, struct inode *inode)
 
 errout:
 	ret = ext4_journal_stop(handle);
-	if (!err)
-		err = ret;
-	return ret;
+	return err ? err : ret;
 
 invalid_resize_inode:
 	ext4_error(sb, "corrupted/inconsistent resize inode");
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 455fac164fda..3982b4a7618c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1906,7 +1906,7 @@ void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi)
 int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
-	char slab_name[32];
+	char slab_name[35];
 
 	sprintf(slab_name, "f2fs_page_array_entry-%u:%u", MAJOR(dev), MINOR(dev));
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 97ee17843b4d..462e957eda8b 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1848,16 +1848,24 @@ static const char *gfs2_get_link(struct dentry *dentry,
 int gfs2_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask)
 {
+	int may_not_block = mask & MAY_NOT_BLOCK;
 	struct gfs2_inode *ip;
 	struct gfs2_holder i_gh;
+	struct gfs2_glock *gl;
 	int error;
 
 	gfs2_holder_mark_uninitialized(&i_gh);
 	ip = GFS2_I(inode);
-	if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
-		if (mask & MAY_NOT_BLOCK)
+	gl = rcu_dereference_check(ip->i_gl, !may_not_block);
+	if (unlikely(!gl)) {
+		/* inode is getting torn down, must be RCU mode */
+		WARN_ON_ONCE(!may_not_block);
+		return -ECHILD;
+        }
+	if (gfs2_glock_is_locked_by_me(gl) == NULL) {
+		if (may_not_block)
 			return -ECHILD;
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
 		if (error)
 			return error;
 	}
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index dc77080a82bb..c381580095ba 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -431,6 +431,17 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 	    (sync_gen && (qd->qd_sync_gen >= *sync_gen)))
 		return 0;
 
+	/*
+	 * If qd_change is 0 it means a pending quota change was negated.
+	 * We should not sync it, but we still have a qd reference and slot
+	 * reference taken by gfs2_quota_change -> do_qc that need to be put.
+	 */
+	if (!qd->qd_change && test_and_clear_bit(QDF_CHANGE, &qd->qd_flags)) {
+		slot_put(qd);
+		qd_put(qd);
+		return 0;
+	}
+
 	if (!lockref_get_not_dead(&qd->qd_lockref))
 		return 0;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 51b44da4a0d6..268651ac9fc8 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1436,7 +1436,7 @@ static void gfs2_evict_inode(struct inode *inode)
 		wait_on_bit_io(&ip->i_flags, GIF_GLOP_PENDING, TASK_UNINTERRUPTIBLE);
 		gfs2_glock_add_to_lru(ip->i_gl);
 		gfs2_glock_put_eventually(ip->i_gl);
-		ip->i_gl = NULL;
+		rcu_assign_pointer(ip->i_gl, NULL);
 	}
 }
 
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index cce36a76fd02..8a960c6edb6e 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -283,6 +283,8 @@ int jbd2_journal_recover(journal_t *journal)
 	journal_superblock_t *	sb;
 
 	struct recovery_info	info;
+	errseq_t		wb_err;
+	struct address_space	*mapping;
 
 	memset(&info, 0, sizeof(info));
 	sb = journal->j_superblock;
@@ -300,6 +302,9 @@ int jbd2_journal_recover(journal_t *journal)
 		return 0;
 	}
 
+	wb_err = 0;
+	mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	errseq_check_and_advance(&mapping->wb_err, &wb_err);
 	err = do_one_pass(journal, &info, PASS_SCAN);
 	if (!err)
 		err = do_one_pass(journal, &info, PASS_REVOKE);
@@ -318,6 +323,9 @@ int jbd2_journal_recover(journal_t *journal)
 
 	jbd2_journal_clear_revoke(journal);
 	err2 = sync_blockdev(journal->j_fs_dev);
+	if (!err)
+		err = err2;
+	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
 	if (!err)
 		err = err2;
 	/* Make sure all replayed data is on permanent storage */
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index da4f9c3b714f..5b01026fff9b 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -87,7 +87,7 @@ static int dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno,
 static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks);
 static int dbFindBits(u32 word, int l2nb);
 static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno);
-static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx);
+static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl);
 static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 		      int nblocks);
 static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
@@ -180,7 +180,8 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
 
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
-	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
+	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE ||
+		bmp->db_l2nbperpage < 0) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
@@ -194,6 +195,12 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
 	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
 	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
+	if (bmp->db_maxag >= MAXAG || bmp->db_maxag < 0 ||
+		bmp->db_agpref >= MAXAG || bmp->db_agpref < 0) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
+
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
@@ -1778,7 +1785,7 @@ static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno)
 		 * dbFindLeaf() returns the index of the leaf at which
 		 * free space was found.
 		 */
-		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx);
+		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx, true);
 
 		/* release the buffer.
 		 */
@@ -2025,7 +2032,7 @@ dbAllocDmapLev(struct bmap * bmp,
 	 * free space.  if sufficient free space is found, dbFindLeaf()
 	 * returns the index of the leaf at which free space was found.
 	 */
-	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
+	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, false))
 		return -ENOSPC;
 
 	if (leafidx < 0)
@@ -2989,14 +2996,18 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
  *	leafidx	- return pointer to be set to the index of the leaf
  *		  describing at least l2nb free blocks if sufficient
  *		  free blocks are found.
+ *	is_ctl	- determines if the tree is of type ctl
  *
  * RETURN VALUES:
  *	0	- success
  *	-ENOSPC	- insufficient free blocks.
  */
-static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
+static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 {
 	int ti, n = 0, k, x = 0;
+	int max_size;
+
+	max_size = is_ctl ? CTLTREESIZE : TREESIZE;
 
 	/* first check the root of the tree to see if there is
 	 * sufficient free space.
@@ -3017,6 +3028,8 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
 			/* sufficient free space found.  move to the next
 			 * level (or quit if this is the last level).
 			 */
+			if (x + n > max_size)
+				return -ENOSPC;
 			if (l2nb <= tp->dmt_stree[x + n])
 				break;
 		}
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 4899663996d8..6ed2e1d4c894 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1320,7 +1320,7 @@ diInitInode(struct inode *ip, int iagno, int ino, int extno, struct iag * iagp)
 int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 {
 	int rc, ino, iagno, addext, extno, bitno, sword;
-	int nwords, rem, i, agno;
+	int nwords, rem, i, agno, dn_numag;
 	u32 mask, inosmap, extsmap;
 	struct inode *ipimap;
 	struct metapage *mp;
@@ -1356,6 +1356,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
+	if (agno < 0 || agno > dn_numag)
+		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
 		/*
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 3781bca2c8fc..83f805248a81 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1105,6 +1105,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		struct smb_acl *pdacl;
 		struct smb_sid *powner_sid = NULL, *pgroup_sid = NULL;
 		int powner_sid_size = 0, pgroup_sid_size = 0, pntsd_size;
+		int pntsd_alloc_size;
 
 		if (parent_pntsd->osidoffset) {
 			powner_sid = (struct smb_sid *)((char *)parent_pntsd +
@@ -1117,9 +1118,10 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pgroup_sid_size = 1 + 1 + 6 + (pgroup_sid->num_subauth * 4);
 		}
 
-		pntsd = kzalloc(sizeof(struct smb_ntsd) + powner_sid_size +
-				pgroup_sid_size + sizeof(struct smb_acl) +
-				nt_size, GFP_KERNEL);
+		pntsd_alloc_size = sizeof(struct smb_ntsd) + powner_sid_size +
+			pgroup_sid_size + sizeof(struct smb_acl) + nt_size;
+
+		pntsd = kzalloc(pntsd_alloc_size, GFP_KERNEL);
 		if (!pntsd) {
 			rc = -ENOMEM;
 			goto free_aces_base;
@@ -1134,6 +1136,27 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		pntsd->gsidoffset = parent_pntsd->gsidoffset;
 		pntsd->dacloffset = parent_pntsd->dacloffset;
 
+		if ((u64)le32_to_cpu(pntsd->osidoffset) + powner_sid_size >
+		    pntsd_alloc_size) {
+			rc = -EINVAL;
+			kfree(pntsd);
+			goto free_aces_base;
+		}
+
+		if ((u64)le32_to_cpu(pntsd->gsidoffset) + pgroup_sid_size >
+		    pntsd_alloc_size) {
+			rc = -EINVAL;
+			kfree(pntsd);
+			goto free_aces_base;
+		}
+
+		if ((u64)le32_to_cpu(pntsd->dacloffset) + sizeof(struct smb_acl) + nt_size >
+		    pntsd_alloc_size) {
+			rc = -EINVAL;
+			kfree(pntsd);
+			goto free_aces_base;
+		}
+
 		if (pntsd->osidoffset) {
 			struct smb_sid *owner_sid = (struct smb_sid *)((char *)pntsd +
 					le32_to_cpu(pntsd->osidoffset));
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 565d11a21f5e..d65af9a60c35 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5608,7 +5608,7 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_WRITE];
 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
-	nfs4_state_protect_write(server->nfs_client, clnt, msg, hdr);
+	nfs4_state_protect_write(hdr->ds_clp ? hdr->ds_clp : server->nfs_client, clnt, msg, hdr);
 }
 
 static void nfs4_proc_commit_rpc_prepare(struct rpc_task *task, struct nfs_commit_data *data)
@@ -5649,7 +5649,8 @@ static void nfs4_proc_commit_setup(struct nfs_commit_data *data, struct rpc_mess
 	data->res.server = server;
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_COMMIT];
 	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, 0);
-	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
+	nfs4_state_protect(data->ds_clp ? data->ds_clp : server->nfs_client,
+			NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
 }
 
 static int _nfs4_proc_commit(struct file *dst, struct nfs_commitargs *args,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f54ef526f25d..9b660491f393 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2686,7 +2686,7 @@ static int client_opens_release(struct inode *inode, struct file *file)
 
 	/* XXX: alternatively, we could get/drop in seq start/stop */
 	drop_client(clp);
-	return 0;
+	return seq_release(inode, file);
 }
 
 static const struct file_operations client_states_fops = {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e18025b5c887..5310271cf2e3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2140,7 +2140,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		ovl_trusted_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	sb->s_iflags |= SB_I_SKIP_SYNC;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 0b7a00ed6c49..caa421ba078f 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1765,7 +1765,6 @@ static const struct sysctl_alias sysctl_aliases[] = {
 	{"hung_task_panic",			"kernel.hung_task_panic" },
 	{"numa_zonelist_order",			"vm.numa_zonelist_order" },
 	{"softlockup_all_cpu_backtrace",	"kernel.softlockup_all_cpu_backtrace" },
-	{"softlockup_panic",			"kernel.softlockup_panic" },
 	{ }
 };
 
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6088d73d29ce..75e593b1c03e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2396,6 +2396,20 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
 	if (sb_has_quota_loaded(sb, type))
 		return -EBUSY;
 
+	/*
+	 * Quota files should never be encrypted.  They should be thought of as
+	 * filesystem metadata, not user data.  New-style internal quota files
+	 * cannot be encrypted by users anyway, but old-style external quota
+	 * files could potentially be incorrectly created in an encrypted
+	 * directory, hence this explicit check.  Some reasons why encrypted
+	 * quota files don't work include: (1) some filesystems that support
+	 * encryption don't handle it in their quota_read and quota_write, and
+	 * (2) cleaning up encrypted quota files at unmount would need special
+	 * consideration, as quota files are cleaned up later than user files.
+	 */
+	if (IS_ENCRYPTED(inode))
+		return -EINVAL;
+
 	dqopt->files[type] = igrab(inode);
 	if (!dqopt->files[type])
 		return -EIO;
diff --git a/fs/xfs/libxfs/xfs_dir2_leaf.c b/fs/xfs/libxfs/xfs_dir2_leaf.c
index d9b66306a9a7..cb9e950a911d 100644
--- a/fs/xfs/libxfs/xfs_dir2_leaf.c
+++ b/fs/xfs/libxfs/xfs_dir2_leaf.c
@@ -146,6 +146,8 @@ xfs_dir3_leaf_check_int(
 	xfs_dir2_leaf_tail_t		*ltp;
 	int				stale;
 	int				i;
+	bool				isleaf1 = (hdr->magic == XFS_DIR2_LEAF1_MAGIC ||
+						   hdr->magic == XFS_DIR3_LEAF1_MAGIC);
 
 	ltp = xfs_dir2_leaf_tail_p(geo, leaf);
 
@@ -158,8 +160,7 @@ xfs_dir3_leaf_check_int(
 		return __this_address;
 
 	/* Leaves and bests don't overlap in leaf format. */
-	if ((hdr->magic == XFS_DIR2_LEAF1_MAGIC ||
-	     hdr->magic == XFS_DIR3_LEAF1_MAGIC) &&
+	if (isleaf1 &&
 	    (char *)&hdr->ents[hdr->count] > (char *)xfs_dir2_leaf_bests_p(ltp))
 		return __this_address;
 
@@ -175,6 +176,10 @@ xfs_dir3_leaf_check_int(
 		}
 		if (hdr->ents[i].address == cpu_to_be32(XFS_DIR2_NULL_DATAPTR))
 			stale++;
+		if (isleaf1 && xfs_dir2_dataptr_to_db(geo,
+				be32_to_cpu(hdr->ents[i].address)) >=
+				be32_to_cpu(ltp->bestcount))
+			return __this_address;
 	}
 	if (hdr->stale != stale)
 		return __this_address;
diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
index 20095233d7bc..c1f965af8432 100644
--- a/fs/xfs/libxfs/xfs_inode_fork.c
+++ b/fs/xfs/libxfs/xfs_inode_fork.c
@@ -330,6 +330,7 @@ xfs_iformat_attr_fork(
 	}
 
 	if (error) {
+		xfs_idestroy_fork(ip->i_afp);
 		kmem_cache_free(xfs_ifork_zone, ip->i_afp);
 		ip->i_afp = NULL;
 	}
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index ff69a0000817..81a065b0b571 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -108,12 +108,6 @@ struct xlog_recover {
 
 #define ITEM_TYPE(i)	(*(unsigned short *)(i)->ri_buf[0].i_addr)
 
-/*
- * This is the number of entries in the l_buf_cancel_table used during
- * recovery.
- */
-#define	XLOG_BC_TABLE_SIZE	64
-
 #define	XLOG_RECOVER_CRCPASS	0
 #define	XLOG_RECOVER_PASS1	1
 #define	XLOG_RECOVER_PASS2	2
@@ -126,5 +120,13 @@ int xlog_recover_iget(struct xfs_mount *mp, xfs_ino_t ino,
 		struct xfs_inode **ipp);
 void xlog_recover_release_intent(struct xlog *log, unsigned short intent_type,
 		uint64_t intent_id);
+int xlog_alloc_buf_cancel_table(struct xlog *log);
+void xlog_free_buf_cancel_table(struct xlog *log);
+
+#ifdef DEBUG
+void xlog_check_buf_cancel_table(struct xlog *log);
+#else
+#define xlog_check_buf_cancel_table(log) do { } while (0)
+#endif
 
 #endif	/* __XFS_LOG_RECOVER_H__ */
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 5e300daa2559..2db9d9d12344 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -423,7 +423,7 @@ xfs_calc_remove_reservation(
 {
 	return XFS_DQUOT_LOGRES(mp) +
 		xfs_calc_iunlink_add_reservation(mp) +
-		max((xfs_calc_inode_res(mp, 1) +
+		max((xfs_calc_inode_res(mp, 2) +
 		     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp),
 				      XFS_FSB_TO_B(mp, 1))),
 		    (xfs_calc_buf_res(4, mp->m_sb.sb_sectsize) +
diff --git a/fs/xfs/xfs_attr_inactive.c b/fs/xfs/xfs_attr_inactive.c
index 2b5da6218977..2afa6d9a7f8f 100644
--- a/fs/xfs/xfs_attr_inactive.c
+++ b/fs/xfs/xfs_attr_inactive.c
@@ -158,6 +158,7 @@ xfs_attr3_node_inactive(
 	}
 	child_fsb = be32_to_cpu(ichdr.btree[0].before);
 	xfs_trans_brelse(*trans, bp);	/* no locks for later trans */
+	bp = NULL;
 
 	/*
 	 * If this is the node level just above the leaves, simply loop
@@ -211,12 +212,8 @@ xfs_attr3_node_inactive(
 				&child_bp);
 		if (error)
 			return error;
-		error = bp->b_error;
-		if (error) {
-			xfs_trans_brelse(*trans, child_bp);
-			return error;
-		}
 		xfs_trans_binval(*trans, child_bp);
+		child_bp = NULL;
 
 		/*
 		 * If we're not done, re-read the parent to get the next
@@ -233,6 +230,7 @@ xfs_attr3_node_inactive(
 						  bp->b_addr);
 			child_fsb = be32_to_cpu(phdr.btree[i + 1].before);
 			xfs_trans_brelse(*trans, bp);
+			bp = NULL;
 		}
 		/*
 		 * Atomically commit the whole invalidate stuff.
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index e04e44ef14c6..31cbe7deebfa 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -23,6 +23,15 @@
 #include "xfs_dir2.h"
 #include "xfs_quota.h"
 
+/*
+ * This is the number of entries in the l_buf_cancel_table used during
+ * recovery.
+ */
+#define	XLOG_BC_TABLE_SIZE	64
+
+#define XLOG_BUF_CANCEL_BUCKET(log, blkno) \
+	((log)->l_buf_cancel_table + ((uint64_t)blkno % XLOG_BC_TABLE_SIZE))
+
 /*
  * This structure is used during recovery to record the buf log items which
  * have been canceled and should not be replayed.
@@ -1003,3 +1012,60 @@ const struct xlog_recover_item_ops xlog_buf_item_ops = {
 	.commit_pass1		= xlog_recover_buf_commit_pass1,
 	.commit_pass2		= xlog_recover_buf_commit_pass2,
 };
+
+#ifdef DEBUG
+void
+xlog_check_buf_cancel_table(
+	struct xlog	*log)
+{
+	int		i;
+
+	for (i = 0; i < XLOG_BC_TABLE_SIZE; i++)
+		ASSERT(list_empty(&log->l_buf_cancel_table[i]));
+}
+#endif
+
+int
+xlog_alloc_buf_cancel_table(
+	struct xlog	*log)
+{
+	void		*p;
+	int		i;
+
+	ASSERT(log->l_buf_cancel_table == NULL);
+
+	p = kmalloc_array(XLOG_BC_TABLE_SIZE, sizeof(struct list_head),
+			  GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	log->l_buf_cancel_table = p;
+	for (i = 0; i < XLOG_BC_TABLE_SIZE; i++)
+		INIT_LIST_HEAD(&log->l_buf_cancel_table[i]);
+
+	return 0;
+}
+
+void
+xlog_free_buf_cancel_table(
+	struct xlog	*log)
+{
+	int		i;
+
+	if (!log->l_buf_cancel_table)
+		return;
+
+	for (i = 0; i < XLOG_BC_TABLE_SIZE; i++) {
+		struct xfs_buf_cancel	*bc;
+
+		while ((bc = list_first_entry_or_null(
+				&log->l_buf_cancel_table[i],
+				struct xfs_buf_cancel, bc_list))) {
+			list_del(&bc->bc_list);
+			kmem_free(bc);
+		}
+	}
+
+	kmem_free(log->l_buf_cancel_table);
+	log->l_buf_cancel_table = NULL;
+}
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 81c445e9489b..b0ccec92e015 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -224,13 +224,18 @@ int
 xfs_errortag_init(
 	struct xfs_mount	*mp)
 {
+	int ret;
+
 	mp->m_errortag = kmem_zalloc(sizeof(unsigned int) * XFS_ERRTAG_MAX,
 			KM_MAYFAIL);
 	if (!mp->m_errortag)
 		return -ENOMEM;
 
-	return xfs_sysfs_init(&mp->m_errortag_kobj, &xfs_errortag_ktype,
-			       &mp->m_kobj, "errortag");
+	ret = xfs_sysfs_init(&mp->m_errortag_kobj, &xfs_errortag_ktype,
+				&mp->m_kobj, "errortag");
+	if (ret)
+		kmem_free(mp->m_errortag);
+	return ret;
 }
 
 void
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index b2ea85318214..df64b902842d 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -378,8 +378,8 @@ xfs_isilocked(
 	}
 
 	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
-		return __xfs_rwsem_islocked(&VFS_I(ip)->i_rwsem,
-				(lock_flags & XFS_IOLOCK_SHARED));
+		return __xfs_rwsem_islocked(&VFS_I(ip)->i_mapping->invalidate_lock,
+				(lock_flags & XFS_MMAPLOCK_SHARED));
 	}
 
 	if (lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) {
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 0fb7d05ca308..eba295f666ac 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -2061,8 +2061,6 @@ xlog_dealloc_log(
 	xlog_in_core_t	*iclog, *next_iclog;
 	int		i;
 
-	xlog_cil_destroy(log);
-
 	/*
 	 * Cycle all the iclogbuf locks to make sure all log IO completion
 	 * is done before we tear down these buffers.
@@ -2074,6 +2072,13 @@ xlog_dealloc_log(
 		iclog = iclog->ic_next;
 	}
 
+	/*
+	 * Destroy the CIL after waiting for iclog IO completion because an
+	 * iclog EIO error will try to shut down the log, which accesses the
+	 * CIL to wake up the waiters.
+	 */
+	xlog_cil_destroy(log);
+
 	iclog = log->l_iclog;
 	for (i = 0; i < log->l_iclog_bufs; i++) {
 		next_iclog = iclog->ic_next;
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index f3d68ca39f45..03393595676f 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -454,9 +454,6 @@ struct xlog {
 	struct rw_semaphore	l_incompat_users;
 };
 
-#define XLOG_BUF_CANCEL_BUCKET(log, blkno) \
-	((log)->l_buf_cancel_table + ((uint64_t)blkno % XLOG_BC_TABLE_SIZE))
-
 /*
  * Bits for operational state
  */
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 581aeb288b32..3d844a250b71 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2560,6 +2560,7 @@ xlog_recover_process_intents(
 	for (lip = xfs_trans_ail_cursor_first(ailp, &cur, 0);
 	     lip != NULL;
 	     lip = xfs_trans_ail_cursor_next(ailp, &cur)) {
+		const struct xfs_item_ops	*ops;
 		/*
 		 * We're done when we see something other than an intent.
 		 * There should be no intents left in the AIL now.
@@ -2584,13 +2585,17 @@ xlog_recover_process_intents(
 		 * deferred ops, you /must/ attach them to the capture list in
 		 * the recover routine or else those subsequent intents will be
 		 * replayed in the wrong order!
+		 *
+		 * The recovery function can free the log item, so we must not
+		 * access lip after it returns.
 		 */
 		spin_unlock(&ailp->ail_lock);
-		error = lip->li_ops->iop_recover(lip, &capture_list);
+		ops = lip->li_ops;
+		error = ops->iop_recover(lip, &capture_list);
 		spin_lock(&ailp->ail_lock);
 		if (error) {
 			trace_xlog_intent_recovery_failed(log->l_mp, error,
-					lip->li_ops->iop_recover);
+					ops->iop_recover);
 			break;
 		}
 	}
@@ -2739,6 +2744,7 @@ xlog_recover_process_one_iunlink(
 	 * Call xlog_recover_clear_agi_bucket() to perform a transaction to
 	 * clear the inode pointer in the bucket.
 	 */
+	xfs_inodegc_flush(mp);
 	xlog_recover_clear_agi_bucket(mp, agno, bucket);
 	return NULLAGINO;
 }
@@ -3248,7 +3254,7 @@ xlog_do_log_recovery(
 	xfs_daddr_t	head_blk,
 	xfs_daddr_t	tail_blk)
 {
-	int		error, i;
+	int		error;
 
 	ASSERT(head_blk != tail_blk);
 
@@ -3256,37 +3262,25 @@ xlog_do_log_recovery(
 	 * First do a pass to find all of the cancelled buf log items.
 	 * Store them in the buf_cancel_table for use in the second pass.
 	 */
-	log->l_buf_cancel_table = kmem_zalloc(XLOG_BC_TABLE_SIZE *
-						 sizeof(struct list_head),
-						 0);
-	for (i = 0; i < XLOG_BC_TABLE_SIZE; i++)
-		INIT_LIST_HEAD(&log->l_buf_cancel_table[i]);
+	error = xlog_alloc_buf_cancel_table(log);
+	if (error)
+		return error;
 
 	error = xlog_do_recovery_pass(log, head_blk, tail_blk,
 				      XLOG_RECOVER_PASS1, NULL);
-	if (error != 0) {
-		kmem_free(log->l_buf_cancel_table);
-		log->l_buf_cancel_table = NULL;
-		return error;
-	}
+	if (error != 0)
+		goto out_cancel;
+
 	/*
 	 * Then do a second pass to actually recover the items in the log.
 	 * When it is complete free the table of buf cancel items.
 	 */
 	error = xlog_do_recovery_pass(log, head_blk, tail_blk,
 				      XLOG_RECOVER_PASS2, NULL);
-#ifdef DEBUG
-	if (!error) {
-		int	i;
-
-		for (i = 0; i < XLOG_BC_TABLE_SIZE; i++)
-			ASSERT(list_empty(&log->l_buf_cancel_table[i]));
-	}
-#endif	/* DEBUG */
-
-	kmem_free(log->l_buf_cancel_table);
-	log->l_buf_cancel_table = NULL;
-
+	if (!error)
+		xlog_check_buf_cancel_table(log);
+out_cancel:
+	xlog_free_buf_cancel_table(log);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 623244650a2f..792736e29a37 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -1244,6 +1244,13 @@ xfs_qm_flush_one(
 			error = -EINVAL;
 			goto out_unlock;
 		}
+
+		if (!(bp->b_flags & _XBF_DELWRI_Q)) {
+			error = -EAGAIN;
+			xfs_buf_relse(bp);
+			goto out_unlock;
+		}
+
 		xfs_buf_unlock(bp);
 
 		xfs_buf_delwri_pushbuf(bp, buffer_list);
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 36832e4bc803..793bdf5ac2f7 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -340,9 +340,41 @@ xfs_find_trim_cow_extent(
 	return 0;
 }
 
-/* Allocate all CoW reservations covering a range of blocks in a file. */
-int
-xfs_reflink_allocate_cow(
+static int
+xfs_reflink_convert_unwritten(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	struct xfs_bmbt_irec	*cmap,
+	bool			convert_now)
+{
+	xfs_fileoff_t		offset_fsb = imap->br_startoff;
+	xfs_filblks_t		count_fsb = imap->br_blockcount;
+	int			error;
+
+	/*
+	 * cmap might larger than imap due to cowextsize hint.
+	 */
+	xfs_trim_extent(cmap, offset_fsb, count_fsb);
+
+	/*
+	 * COW fork extents are supposed to remain unwritten until we're ready
+	 * to initiate a disk write.  For direct I/O we are going to write the
+	 * data and need the conversion, but for buffered writes we're done.
+	 */
+	if (!convert_now || cmap->br_state == XFS_EXT_NORM)
+		return 0;
+
+	trace_xfs_reflink_convert_cow(ip, cmap);
+
+	error = xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
+	if (!error)
+		cmap->br_state = XFS_EXT_NORM;
+
+	return error;
+}
+
+static int
+xfs_reflink_fill_cow_hole(
 	struct xfs_inode	*ip,
 	struct xfs_bmbt_irec	*imap,
 	struct xfs_bmbt_irec	*cmap,
@@ -351,25 +383,12 @@ xfs_reflink_allocate_cow(
 	bool			convert_now)
 {
 	struct xfs_mount	*mp = ip->i_mount;
-	xfs_fileoff_t		offset_fsb = imap->br_startoff;
-	xfs_filblks_t		count_fsb = imap->br_blockcount;
 	struct xfs_trans	*tp;
-	int			nimaps, error = 0;
-	bool			found;
 	xfs_filblks_t		resaligned;
-	xfs_extlen_t		resblks = 0;
-
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
-	if (!ip->i_cowfp) {
-		ASSERT(!xfs_is_reflink_inode(ip));
-		xfs_ifork_init_cow(ip);
-	}
-
-	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
-		return error;
-	if (found)
-		goto convert;
+	xfs_extlen_t		resblks;
+	int			nimaps;
+	int			error;
+	bool			found;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -385,17 +404,17 @@ xfs_reflink_allocate_cow(
 
 	*lockmode = XFS_ILOCK_EXCL;
 
-	/*
-	 * Check for an overlapping extent again now that we dropped the ilock.
-	 */
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
 	if (error || !*shared)
 		goto out_trans_cancel;
+
 	if (found) {
 		xfs_trans_cancel(tp);
 		goto convert;
 	}
 
+	ASSERT(cmap->br_startoff > imap->br_startoff);
+
 	/* Allocate the entire reservation as unwritten blocks. */
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
@@ -415,23 +434,135 @@ xfs_reflink_allocate_cow(
 	 */
 	if (nimaps == 0)
 		return -ENOSPC;
+
 convert:
-	xfs_trim_extent(cmap, offset_fsb, count_fsb);
-	/*
-	 * COW fork extents are supposed to remain unwritten until we're ready
-	 * to initiate a disk write.  For direct I/O we are going to write the
-	 * data and need the conversion, but for buffered writes we're done.
-	 */
-	if (!convert_now || cmap->br_state == XFS_EXT_NORM)
-		return 0;
-	trace_xfs_reflink_convert_cow(ip, cmap);
-	return xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
+	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
 	return error;
 }
 
+static int
+xfs_reflink_fill_delalloc(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	struct xfs_bmbt_irec	*cmap,
+	bool			*shared,
+	uint			*lockmode,
+	bool			convert_now)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	int			nimaps;
+	int			error;
+	bool			found;
+
+	do {
+		xfs_iunlock(ip, *lockmode);
+		*lockmode = 0;
+
+		error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, 0, 0,
+				false, &tp);
+		if (error)
+			return error;
+
+		*lockmode = XFS_ILOCK_EXCL;
+
+		error = xfs_find_trim_cow_extent(ip, imap, cmap, shared,
+				&found);
+		if (error || !*shared)
+			goto out_trans_cancel;
+
+		if (found) {
+			xfs_trans_cancel(tp);
+			break;
+		}
+
+		ASSERT(isnullstartblock(cmap->br_startblock) ||
+		       cmap->br_startblock == DELAYSTARTBLOCK);
+
+		/*
+		 * Replace delalloc reservation with an unwritten extent.
+		 */
+		nimaps = 1;
+		error = xfs_bmapi_write(tp, ip, cmap->br_startoff,
+				cmap->br_blockcount,
+				XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0,
+				cmap, &nimaps);
+		if (error)
+			goto out_trans_cancel;
+
+		xfs_inode_set_cowblocks_tag(ip);
+		error = xfs_trans_commit(tp);
+		if (error)
+			return error;
+
+		/*
+		 * Allocation succeeded but the requested range was not even
+		 * partially satisfied?  Bail out!
+		 */
+		if (nimaps == 0)
+			return -ENOSPC;
+	} while (cmap->br_startoff + cmap->br_blockcount <= imap->br_startoff);
+
+	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
+
+out_trans_cancel:
+	xfs_trans_cancel(tp);
+	return error;
+}
+
+/* Allocate all CoW reservations covering a range of blocks in a file. */
+int
+xfs_reflink_allocate_cow(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	struct xfs_bmbt_irec	*cmap,
+	bool			*shared,
+	uint			*lockmode,
+	bool			convert_now)
+{
+	int			error;
+	bool			found;
+
+	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
+	if (error || !*shared)
+		return error;
+
+	/* CoW fork has a real extent */
+	if (found)
+		return xfs_reflink_convert_unwritten(ip, imap, cmap,
+				convert_now);
+
+	/*
+	 * CoW fork does not have an extent and data extent is shared.
+	 * Allocate a real extent in the CoW fork.
+	 */
+	if (cmap->br_startoff > imap->br_startoff)
+		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
+				lockmode, convert_now);
+
+	/*
+	 * CoW fork has a delalloc reservation. Replace it with a real extent.
+	 * There may or may not be a data fork mapping.
+	 */
+	if (isnullstartblock(cmap->br_startblock) ||
+	    cmap->br_startblock == DELAYSTARTBLOCK)
+		return xfs_reflink_fill_delalloc(ip, imap, cmap, shared,
+				lockmode, convert_now);
+
+	/* Shouldn't get here. */
+	ASSERT(0);
+	return -EFSCORRUPTED;
+}
+
 /*
  * Cancel CoW reservations for some block range of an inode.
  *
diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
index 43585850f154..513095e353a5 100644
--- a/fs/xfs/xfs_sysfs.h
+++ b/fs/xfs/xfs_sysfs.h
@@ -33,10 +33,15 @@ xfs_sysfs_init(
 	const char		*name)
 {
 	struct kobject		*parent;
+	int err;
 
 	parent = parent_kobj ? &parent_kobj->kobject : NULL;
 	init_completion(&kobj->complete);
-	return kobject_init_and_add(&kobj->kobject, ktype, parent, "%s", name);
+	err = kobject_init_and_add(&kobj->kobject, ktype, parent, "%s", name);
+	if (err)
+		kobject_put(&kobj->kobject);
+
+	return err;
 }
 
 static inline void
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 3fad741df53e..c998f9c139ed 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -781,10 +781,10 @@ int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index);
 
 /**
  * ethtool_sprintf - Write formatted string to ethtool string data
- * @data: Pointer to start of string to update
+ * @data: Pointer to a pointer to the start of string to update
  * @fmt: Format of string to write
  *
- * Write formatted string to data. Update data to point at start of
+ * Write formatted string to *data. Update *data to point at start of
  * next string.
  */
 extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 61590c1f2d33..c4f245262f98 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -48,7 +48,7 @@ LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
@@ -265,7 +265,7 @@ LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
+LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 4d244e295e85..9c4534a69a8f 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -77,14 +77,42 @@
 /* preempt_count() and related functions, depends on PREEMPT_NEED_RESCHED */
 #include <asm/preempt.h>
 
+/**
+ * interrupt_context_level - return interrupt context level
+ *
+ * Returns the current interrupt context level.
+ *  0 - normal context
+ *  1 - softirq context
+ *  2 - hardirq context
+ *  3 - NMI context
+ */
+static __always_inline unsigned char interrupt_context_level(void)
+{
+	unsigned long pc = preempt_count();
+	unsigned char level = 0;
+
+	level += !!(pc & (NMI_MASK));
+	level += !!(pc & (NMI_MASK | HARDIRQ_MASK));
+	level += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
+
+	return level;
+}
+
+/*
+ * These macro definitions avoid redundant invocations of preempt_count()
+ * because such invocations would result in redundant loads given that
+ * preempt_count() is commonly implemented with READ_ONCE().
+ */
+
 #define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #ifdef CONFIG_PREEMPT_RT
 # define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
+# define irq_count()		((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | softirq_count())
 #else
 # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+# define irq_count()		(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_MASK))
 #endif
-#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
  * Macros to retrieve the current execution context:
@@ -97,7 +125,11 @@
 #define in_nmi()		(nmi_count())
 #define in_hardirq()		(hardirq_count())
 #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
+#ifdef CONFIG_PREEMPT_RT
+# define in_task()		(!((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | in_serving_softirq()))
+#else
+# define in_task()		(!(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
+#endif
 
 /*
  * The following macros are deprecated and should not be used in new code:
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c7bfa64aeb14..03c42e742dfe 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -44,8 +44,8 @@ struct pwm_args {
 };
 
 enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_EXPORTED = 1 << 1,
+	PWMF_REQUESTED = 0,
+	PWMF_EXPORTED = 1,
 };
 
 /*
diff --git a/include/linux/string.h b/include/linux/string.h
index d68097b4f600..3b9f5abe5ee8 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -5,7 +5,9 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -14,6 +16,44 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result may be not
+ * physically contiguous. Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 9fcf5ffc4f9a..71ec22b1df86 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -83,6 +83,7 @@ struct rpc_clnt {
 	};
 	const struct cred	*cl_cred;
 	unsigned int		cl_max_connect; /* max number of transports not to the same IP */
+	struct super_block *pipefs_sb;
 };
 
 /*
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 9c91c3531d83..d3cbe4bf4fab 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -468,6 +468,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
 	EVENT_FILE_FL_PID_FILTER_BIT,
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
+	EVENT_FILE_FL_FREED_BIT,
 };
 
 extern struct trace_event_file *trace_get_event_file(const char *instance,
@@ -606,6 +607,7 @@ extern int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...);
  *  TRIGGER_COND  - When set, one or more triggers has an associated filter
  *  PID_FILTER    - When set, the event is filtered based on pid
  *  WAS_ENABLED   - Set when enabled to know to clear trace on module removal
+ *  FREED         - File descriptor is freed, all fields should be considered invalid
  */
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
@@ -619,6 +621,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
 	EVENT_FILE_FL_WAS_ENABLED	= (1 << EVENT_FILE_FL_WAS_ENABLED_BIT),
+	EVENT_FILE_FL_FREED		= (1 << EVENT_FILE_FL_FREED_BIT),
 };
 
 struct trace_event_file {
@@ -647,6 +650,7 @@ struct trace_event_file {
 	 * caching and such. Which is mostly OK ;-)
 	 */
 	unsigned long		flags;
+	atomic_t		ref;	/* ref count for opened files */
 	atomic_t		sm_ref;	/* soft-mode reference counter */
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index fe95f0922526..816d7a0d2aad 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -116,13 +116,9 @@ enum {
 
 static __always_inline int trace_get_context_bit(void)
 {
-	unsigned long pc = preempt_count();
+	unsigned char bit = interrupt_context_level();
 
-	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
-		return TRACE_CTX_NORMAL;
-	else
-		return pc & NMI_MASK ? TRACE_CTX_NMI :
-			pc & HARDIRQ_MASK ? TRACE_CTX_IRQ : TRACE_CTX_SOFTIRQ;
+	return TRACE_CTX_NORMAL - bit;
 }
 
 #ifdef CONFIG_FTRACE_RECORD_RECURSION
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 20a47eb94b0f..1e96680f5023 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -222,18 +222,16 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
  * to generate better code.
  */
 #ifdef CONFIG_LOCKDEP
-#define __INIT_WORK(_work, _func, _onstack)				\
+#define __INIT_WORK_KEY(_work, _func, _onstack, _key)			\
 	do {								\
-		static struct lock_class_key __key;			\
-									\
 		__init_work((_work), _onstack);				\
 		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
-		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, &__key, 0); \
+		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, (_key), 0); \
 		INIT_LIST_HEAD(&(_work)->entry);			\
 		(_work)->func = (_func);				\
 	} while (0)
 #else
-#define __INIT_WORK(_work, _func, _onstack)				\
+#define __INIT_WORK_KEY(_work, _func, _onstack, _key)			\
 	do {								\
 		__init_work((_work), _onstack);				\
 		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
@@ -242,12 +240,22 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 	} while (0)
 #endif
 
+#define __INIT_WORK(_work, _func, _onstack)				\
+	do {								\
+		static __maybe_unused struct lock_class_key __key;	\
+									\
+		__INIT_WORK_KEY(_work, _func, _onstack, &__key);	\
+	} while (0)
+
 #define INIT_WORK(_work, _func)						\
 	__INIT_WORK((_work), (_func), 0)
 
 #define INIT_WORK_ONSTACK(_work, _func)					\
 	__INIT_WORK((_work), (_func), 1)
 
+#define INIT_WORK_ONSTACK_KEY(_work, _func, _key)			\
+	__INIT_WORK_KEY((_work), (_func), 1, _key)
+
 #define __INIT_DELAYED_WORK(_work, _func, _tflags)			\
 	do {								\
 		INIT_WORK(&(_work)->work, (_func));			\
@@ -632,8 +640,32 @@ static inline long work_on_cpu_safe(int cpu, long (*fn)(void *), void *arg)
 	return fn(arg);
 }
 #else
-long work_on_cpu(int cpu, long (*fn)(void *), void *arg);
-long work_on_cpu_safe(int cpu, long (*fn)(void *), void *arg);
+long work_on_cpu_key(int cpu, long (*fn)(void *),
+		     void *arg, struct lock_class_key *key);
+/*
+ * A new key is defined for each caller to make sure the work
+ * associated with the function doesn't share its locking class.
+ */
+#define work_on_cpu(_cpu, _fn, _arg)			\
+({							\
+	static struct lock_class_key __key;		\
+							\
+	work_on_cpu_key(_cpu, _fn, _arg, &__key);	\
+})
+
+long work_on_cpu_safe_key(int cpu, long (*fn)(void *),
+			  void *arg, struct lock_class_key *key);
+
+/*
+ * A new key is defined for each caller to make sure the work
+ * associated with the function doesn't share its locking class.
+ */
+#define work_on_cpu_safe(_cpu, _fn, _arg)		\
+({							\
+	static struct lock_class_key __key;		\
+							\
+	work_on_cpu_safe_key(_cpu, _fn, _arg, &__key);	\
+})
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_FREEZER
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 695ed45841f0..d31a18824cd5 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -66,7 +66,6 @@ struct inet_connection_sock_af_ops {
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
  * @icsk_clean_acked	   Clean acked data hook
- * @icsk_listen_portaddr_node	hash to the portaddr listener hashtable
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -96,7 +95,6 @@ struct inet_connection_sock {
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
 	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
-	struct hlist_node         icsk_listen_portaddr_node;
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 53c22b64e972..a7a8e66a1bad 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -111,11 +111,7 @@ struct inet_bind_hashbucket {
 #define LISTENING_NULLS_BASE (1U << 29)
 struct inet_listen_hashbucket {
 	spinlock_t		lock;
-	unsigned int		count;
-	union {
-		struct hlist_head	head;
-		struct hlist_nulls_head	nulls_head;
-	};
+	struct hlist_nulls_head	nulls_head;
 };
 
 /* This is for listening sockets, thus all sockets which possess wildcards. */
@@ -143,32 +139,8 @@ struct inet_hashinfo {
 	/* The 2nd listener table hashed by local port and address */
 	unsigned int			lhash2_mask;
 	struct inet_listen_hashbucket	*lhash2;
-
-	/* All the above members are written once at bootup and
-	 * never written again _or_ are predominantly read-access.
-	 *
-	 * Now align to a new cache line as all the following members
-	 * might be often dirty.
-	 */
-	/* All sockets in TCP_LISTEN state will be in listening_hash.
-	 * This is the only table where wildcard'd TCP sockets can
-	 * exist.  listening_hash is only hashed by local port number.
-	 * If lhash2 is initialized, the same socket will also be hashed
-	 * to lhash2 by port and address.
-	 */
-	struct inet_listen_hashbucket	listening_hash[INET_LHTABLE_SIZE]
-					____cacheline_aligned_in_smp;
 };
 
-#define inet_lhash2_for_each_icsk_continue(__icsk) \
-	hlist_for_each_entry_continue(__icsk, icsk_listen_portaddr_node)
-
-#define inet_lhash2_for_each_icsk(__icsk, list) \
-	hlist_for_each_entry(__icsk, list, icsk_listen_portaddr_node)
-
-#define inet_lhash2_for_each_icsk_rcu(__icsk, list) \
-	hlist_for_each_entry_rcu(__icsk, list, icsk_listen_portaddr_node)
-
 static inline struct inet_listen_hashbucket *
 inet_lhash2_bucket(struct inet_hashinfo *h, u32 hash)
 {
@@ -219,23 +191,11 @@ static inline u32 inet_bhashfn(const struct net *net, const __u16 lport,
 void inet_bind_hash(struct sock *sk, struct inet_bind_bucket *tb,
 		    const unsigned short snum);
 
-/* These can have wildcards, don't try too hard. */
-static inline u32 inet_lhashfn(const struct net *net, const unsigned short num)
-{
-	return (num + net_hash_mix(net)) & (INET_LHTABLE_SIZE - 1);
-}
-
-static inline int inet_sk_listen_hashfn(const struct sock *sk)
-{
-	return inet_lhashfn(sock_net(sk), inet_sk(sk)->inet_num);
-}
-
 /* Caller must disable local BH processing. */
 int __inet_inherit_port(const struct sock *sk, struct sock *child);
 
 void inet_put_port(struct sock *sk);
 
-void inet_hashinfo_init(struct inet_hashinfo *h);
 void inet_hashinfo2_init(struct inet_hashinfo *h, const char *name,
 			 unsigned long numentries, int scale,
 			 unsigned long low_limit,
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index a0b47f2b896e..8e9c5bc1a9e6 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -144,14 +144,29 @@ static inline void nft_reg_store16(u32 *dreg, u16 val)
 	*(u16 *)dreg = val;
 }
 
+static inline void nft_reg_store_be16(u32 *dreg, __be16 val)
+{
+	nft_reg_store16(dreg, (__force __u16)val);
+}
+
 static inline u16 nft_reg_load16(const u32 *sreg)
 {
 	return *(u16 *)sreg;
 }
 
-static inline void nft_reg_store64(u32 *dreg, u64 val)
+static inline __be16 nft_reg_load_be16(const u32 *sreg)
+{
+	return (__force __be16)nft_reg_load16(sreg);
+}
+
+static inline __be32 nft_reg_load_be32(const u32 *sreg)
+{
+	return *(__force __be32 *)sreg;
+}
+
+static inline void nft_reg_store64(u64 *dreg, u64 val)
 {
-	put_unaligned(val, (u64 *)dreg);
+	put_unaligned(val, dreg);
 }
 
 static inline u64 nft_reg_load64(const u32 *sreg)
diff --git a/include/net/sock.h b/include/net/sock.h
index 640bd7a36777..e19eebaf59f7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1923,21 +1923,33 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
 	/* sk_tx_queue_mapping accept only upto a 16-bit value */
 	if (WARN_ON_ONCE((unsigned short)tx_queue >= USHRT_MAX))
 		return;
-	sk->sk_tx_queue_mapping = tx_queue;
+	/* Paired with READ_ONCE() in sk_tx_queue_get() and
+	 * other WRITE_ONCE() because socket lock might be not held.
+	 */
+	WRITE_ONCE(sk->sk_tx_queue_mapping, tx_queue);
 }
 
 #define NO_QUEUE_MAPPING	USHRT_MAX
 
 static inline void sk_tx_queue_clear(struct sock *sk)
 {
-	sk->sk_tx_queue_mapping = NO_QUEUE_MAPPING;
+	/* Paired with READ_ONCE() in sk_tx_queue_get() and
+	 * other WRITE_ONCE() because socket lock might be not held.
+	 */
+	WRITE_ONCE(sk->sk_tx_queue_mapping, NO_QUEUE_MAPPING);
 }
 
 static inline int sk_tx_queue_get(const struct sock *sk)
 {
-	if (sk && sk->sk_tx_queue_mapping != NO_QUEUE_MAPPING)
-		return sk->sk_tx_queue_mapping;
+	if (sk) {
+		/* Paired with WRITE_ONCE() in sk_tx_queue_clear()
+		 * and sk_tx_queue_set().
+		 */
+		int val = READ_ONCE(sk->sk_tx_queue_mapping);
 
+		if (val != NO_QUEUE_MAPPING)
+			return val;
+	}
 	return -1;
 }
 
@@ -2071,7 +2083,7 @@ static inline void __dst_negative_advice(struct sock *sk)
 		if (ndst != dst) {
 			rcu_assign_pointer(sk->sk_dst_cache, ndst);
 			sk_tx_queue_clear(sk);
-			sk->sk_dst_pending_confirm = 0;
+			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		}
 	}
 }
@@ -2088,7 +2100,7 @@ __sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = rcu_dereference_protected(sk->sk_dst_cache,
 					    lockdep_sock_is_held(sk));
 	rcu_assign_pointer(sk->sk_dst_cache, dst);
@@ -2101,7 +2113,7 @@ sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = xchg((__force struct dst_entry **)&sk->sk_dst_cache, dst);
 	dst_release(old_dst);
 }
diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
index 4f2cc4fb56b7..9a5429260ece 100644
--- a/include/sound/soc-card.h
+++ b/include/sound/soc-card.h
@@ -40,6 +40,43 @@ int snd_soc_card_add_dai_link(struct snd_soc_card *card,
 void snd_soc_card_remove_dai_link(struct snd_soc_card *card,
 				  struct snd_soc_dai_link *dai_link);
 
+#ifdef CONFIG_PCI
+static inline void snd_soc_card_set_pci_ssid(struct snd_soc_card *card,
+					     unsigned short vendor,
+					     unsigned short device)
+{
+	card->pci_subsystem_vendor = vendor;
+	card->pci_subsystem_device = device;
+	card->pci_subsystem_set = true;
+}
+
+static inline int snd_soc_card_get_pci_ssid(struct snd_soc_card *card,
+					    unsigned short *vendor,
+					    unsigned short *device)
+{
+	if (!card->pci_subsystem_set)
+		return -ENOENT;
+
+	*vendor = card->pci_subsystem_vendor;
+	*device = card->pci_subsystem_device;
+
+	return 0;
+}
+#else /* !CONFIG_PCI */
+static inline void snd_soc_card_set_pci_ssid(struct snd_soc_card *card,
+					     unsigned short vendor,
+					     unsigned short device)
+{
+}
+
+static inline int snd_soc_card_get_pci_ssid(struct snd_soc_card *card,
+					    unsigned short *vendor,
+					    unsigned short *device)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_PCI */
+
 /* device driver data */
 static inline void snd_soc_card_set_drvdata(struct snd_soc_card *card,
 					    void *data)
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5872a8864f3b..3f0369aae2fa 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -880,6 +880,17 @@ struct snd_soc_card {
 #ifdef CONFIG_DMI
 	char dmi_longname[80];
 #endif /* CONFIG_DMI */
+
+#ifdef CONFIG_PCI
+	/*
+	 * PCI does not define 0 as invalid, so pci_subsystem_set indicates
+	 * whether a value has been written to these fields.
+	 */
+	unsigned short pci_subsystem_vendor;
+	unsigned short pci_subsystem_device;
+	bool pci_subsystem_set;
+#endif /* CONFIG_PCI */
+
 	char topology_shortname[32];
 
 	struct device *dev;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d00bedfdadbb..e26292d8b845 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -10411,7 +10411,7 @@ static int io_uring_show_cred(struct seq_file *m, unsigned int id,
 
 static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 {
-	struct io_sq_data *sq = NULL;
+	int sq_pid = -1, sq_cpu = -1;
 	bool has_lock;
 	int i;
 
@@ -10424,13 +10424,19 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 	has_lock = mutex_trylock(&ctx->uring_lock);
 
 	if (has_lock && (ctx->flags & IORING_SETUP_SQPOLL)) {
-		sq = ctx->sq_data;
-		if (!sq->thread)
-			sq = NULL;
+		struct io_sq_data *sq = ctx->sq_data;
+
+		if (mutex_trylock(&sq->lock)) {
+			if (sq->thread) {
+				sq_pid = task_pid_nr(sq->thread);
+				sq_cpu = task_cpu(sq->thread);
+			}
+			mutex_unlock(&sq->lock);
+		}
 	}
 
-	seq_printf(m, "SqThread:\t%d\n", sq ? task_pid_nr(sq->thread) : -1);
-	seq_printf(m, "SqThreadCpu:\t%d\n", sq ? task_cpu(sq->thread) : -1);
+	seq_printf(m, "SqThread:\t%d\n", sq_pid);
+	seq_printf(m, "SqThreadCpu:\t%d\n", sq_cpu);
 	seq_printf(m, "UserFiles:\t%u\n", ctx->nr_user_files);
 	for (i = 0; has_lock && i < ctx->nr_user_files; i++) {
 		struct file *f = io_file_from_index(ctx, i);
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 2acf7ca49154..edbeffee64b8 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -527,11 +527,18 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 	unsigned long ino;
 	dev_t dev;
 
-	exe_file = get_task_exe_file(tsk);
+	/* only do exe filtering if we are recording @current events/records */
+	if (tsk != current)
+		return 0;
+
+	if (!current->mm)
+		return 0;
+	exe_file = get_mm_exe_file(current->mm);
 	if (!exe_file)
 		return 0;
 	ino = file_inode(exe_file)->i_ino;
 	dev = file_inode(exe_file)->i_sb->s_dev;
 	fput(exe_file);
+
 	return audit_mark_compare(mark, ino, dev);
 }
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f7c27c1cc593..36c2896ee45f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -605,7 +605,11 @@ static __always_inline int bpf_tree_comp(void *key, struct latch_tree_node *n)
 
 	if (val < ksym->start)
 		return -1;
-	if (val >= ksym->end)
+	/* Ensure that we detect return addresses as part of the program, when
+	 * the final instruction is a call for a program part of the stack
+	 * trace. Therefore, do val > ksym->end instead of val >= ksym->end.
+	 */
+	if (val > ksym->end)
 		return  1;
 
 	return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a4be7c1c11aa..5d8f352faebd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2189,7 +2189,12 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 	if (class == BPF_ALU || class == BPF_ALU64) {
 		if (!(*reg_mask & dreg))
 			return 0;
-		if (opcode == BPF_MOV) {
+		if (opcode == BPF_END || opcode == BPF_NEG) {
+			/* sreg is reserved and unused
+			 * dreg still need precision before this insn
+			 */
+			return 0;
+		} else if (opcode == BPF_MOV) {
 			if (BPF_SRC(insn->code) == BPF_X) {
 				/* dreg = sreg
 				 * dreg needs precision after this insn
@@ -2885,7 +2890,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		   insn->imm != 0 && env->bpf_capable) {
 		struct bpf_reg_state fake_reg = {};
 
-		__mark_reg_known(&fake_reg, (u32)insn->imm);
+		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type = SCALAR_VALUE;
 		save_register_state(state, spi, &fake_reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 7beceb447211..f40ca4f09afc 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1018,6 +1018,9 @@ void kgdb_panic(const char *msg)
 	if (panic_timeout)
 		return;
 
+	debug_locks_off();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
 	if (dbg_kdb_mode)
 		kdb_printf("PANIC: %s\n", msg);
 
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index aa23ffdaf819..5150d5f84c03 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -210,12 +210,7 @@ DEFINE_OUTPUT_COPY(__output_copy_user, arch_perf_out_copy_user)
 
 static inline int get_recursion_context(int *recursion)
 {
-	unsigned int pc = preempt_count();
-	unsigned char rctx = 0;
-
-	rctx += !!(pc & (NMI_MASK));
-	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK));
-	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
+	unsigned char rctx = interrupt_context_level();
 
 	if (recursion[rctx])
 		return -1;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index f40da32f5e75..6808873555f0 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -696,6 +696,12 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		watermark = 0;
 	}
 
+	/*
+	 * kcalloc_node() is unable to allocate buffer if the size is larger
+	 * than: PAGE_SIZE << MAX_ORDER; directly bail out in this case.
+	 */
+	if (get_order((unsigned long)nr_pages * sizeof(void *)) > MAX_ORDER)
+		return -ENOMEM;
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
 				     node);
 	if (!rb->aux_pages)
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index cc7cdd26e23e..e7b8168e8513 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -541,21 +541,34 @@ EXPORT_SYMBOL_GPL(irq_setup_alt_chip);
 void irq_remove_generic_chip(struct irq_chip_generic *gc, u32 msk,
 			     unsigned int clr, unsigned int set)
 {
-	unsigned int i = gc->irq_base;
+	unsigned int i, virq;
 
 	raw_spin_lock(&gc_lock);
 	list_del(&gc->list);
 	raw_spin_unlock(&gc_lock);
 
-	for (; msk; msk >>= 1, i++) {
+	for (i = 0; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))
 			continue;
 
+		/*
+		 * Interrupt domain based chips store the base hardware
+		 * interrupt number in gc::irq_base. Otherwise gc::irq_base
+		 * contains the base Linux interrupt number.
+		 */
+		if (gc->domain) {
+			virq = irq_find_mapping(gc->domain, gc->irq_base + i);
+			if (!virq)
+				continue;
+		} else {
+			virq = gc->irq_base + i;
+		}
+
 		/* Remove handler first. That will mask the irq line */
-		irq_set_handler(i, NULL);
-		irq_set_chip(i, &no_irq_chip);
-		irq_set_chip_data(i, NULL);
-		irq_modify_status(i, clr, set);
+		irq_set_handler(virq, NULL);
+		irq_set_chip(virq, &no_irq_chip);
+		irq_set_chip_data(virq, NULL);
+		irq_modify_status(virq, clr, set);
 	}
 }
 EXPORT_SYMBOL_GPL(irq_remove_generic_chip);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c..5ff1dcc4acb7 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -240,7 +240,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 3e82f449b4ff..da36997d8742 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -426,7 +426,6 @@ static void stress_inorder_work(struct work_struct *work)
 	} while (!time_after(jiffies, stress->timeout));
 
 	kfree(order);
-	kfree(stress);
 }
 
 struct reorder_lock {
@@ -491,7 +490,6 @@ static void stress_reorder_work(struct work_struct *work)
 	list_for_each_entry_safe(ll, ln, &locks, link)
 		kfree(ll);
 	kfree(order);
-	kfree(stress);
 }
 
 static void stress_one_work(struct work_struct *work)
@@ -512,8 +510,6 @@ static void stress_one_work(struct work_struct *work)
 			break;
 		}
 	} while (!time_after(jiffies, stress->timeout));
-
-	kfree(stress);
 }
 
 #define STRESS_INORDER BIT(0)
@@ -524,15 +520,24 @@ static void stress_one_work(struct work_struct *work)
 static int stress(int nlocks, int nthreads, unsigned int flags)
 {
 	struct ww_mutex *locks;
-	int n;
+	struct stress *stress_array;
+	int n, count;
 
 	locks = kmalloc_array(nlocks, sizeof(*locks), GFP_KERNEL);
 	if (!locks)
 		return -ENOMEM;
 
+	stress_array = kmalloc_array(nthreads, sizeof(*stress_array),
+				     GFP_KERNEL);
+	if (!stress_array) {
+		kfree(locks);
+		return -ENOMEM;
+	}
+
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_init(&locks[n], &ww_class);
 
+	count = 0;
 	for (n = 0; nthreads; n++) {
 		struct stress *stress;
 		void (*fn)(struct work_struct *work);
@@ -556,9 +561,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 		if (!fn)
 			continue;
 
-		stress = kmalloc(sizeof(*stress), GFP_KERNEL);
-		if (!stress)
-			break;
+		stress = &stress_array[count++];
 
 		INIT_WORK(&stress->work, fn);
 		stress->locks = locks;
@@ -573,6 +576,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_destroy(&locks[n]);
+	kfree(stress_array);
 	kfree(locks);
 
 	return 0;
diff --git a/kernel/padata.c b/kernel/padata.c
index c6025a48fb49..47f146f061fb 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -194,7 +194,7 @@ int padata_do_parallel(struct padata_shell *ps,
 		*cb_cpu = cpu;
 	}
 
-	err =  -EBUSY;
+	err = -EBUSY;
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 475d630e650f..2b063e0a15c6 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2414,8 +2414,9 @@ static void *get_highmem_page_buffer(struct page *page,
 		pbe->copy_page = tmp;
 	} else {
 		/* Copy of the page will be stored in normal memory */
-		kaddr = safe_pages_list;
-		safe_pages_list = safe_pages_list->next;
+		kaddr = __get_safe_page(ca->gfp_mask);
+		if (!kaddr)
+			return ERR_PTR(-ENOMEM);
 		pbe->copy_page = virt_to_page(kaddr);
 	}
 	pbe->next = highmem_pblist;
@@ -2595,8 +2596,9 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 		return ERR_PTR(-ENOMEM);
 	}
 	pbe->orig_address = page_address(page);
-	pbe->address = safe_pages_list;
-	safe_pages_list = safe_pages_list->next;
+	pbe->address = __get_safe_page(ca->gfp_mask);
+	if (!pbe->address)
+		return ERR_PTR(-ENOMEM);
 	pbe->next = restore_pblist;
 	restore_pblist = pbe;
 	return pbe->address;
@@ -2627,8 +2629,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
 
-	handle->sync_read = 1;
-
 	if (!handle->cur) {
 		if (!buffer)
 			/* This makes the buffer be freed by swsusp_free() */
@@ -2664,7 +2664,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			memory_bm_position_reset(&orig_bm);
 			restore_pblist = NULL;
 			handle->buffer = get_buffer(&orig_bm, &ca);
-			handle->sync_read = 0;
 			if (IS_ERR(handle->buffer))
 				return PTR_ERR(handle->buffer);
 		}
@@ -2674,9 +2673,8 @@ int snapshot_write_next(struct snapshot_handle *handle)
 		handle->buffer = get_buffer(&orig_bm, &ca);
 		if (IS_ERR(handle->buffer))
 			return PTR_ERR(handle->buffer);
-		if (handle->buffer != buffer)
-			handle->sync_read = 0;
 	}
+	handle->sync_read = (handle->buffer == buffer);
 	handle->cur++;
 	return PAGE_SIZE;
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index df016f6d0662..66c1ca01dd0e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/export.h>
 #include <linux/completion.h>
+#include <linux/kmemleak.h>
 #include <linux/moduleparam.h>
 #include <linux/panic.h>
 #include <linux/panic_notifier.h>
@@ -1906,10 +1907,22 @@ static bool rcu_gp_fqs_check_wake(int *gfp)
  */
 static void rcu_gp_fqs(bool first_time)
 {
+	int nr_fqs = READ_ONCE(rcu_state.nr_fqs_jiffies_stall);
 	struct rcu_node *rnp = rcu_get_root();
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
+
+	WARN_ON_ONCE(nr_fqs > 3);
+	/* Only countdown nr_fqs for stall purposes if jiffies moves. */
+	if (nr_fqs) {
+		if (nr_fqs == 1) {
+			WRITE_ONCE(rcu_state.jiffies_stall,
+				   jiffies + rcu_jiffies_till_stall_check());
+		}
+		WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, --nr_fqs);
+	}
+
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
 		force_qs_rnp(dyntick_save_progress_counter);
@@ -3597,6 +3610,14 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
 
+	/*
+	 * The kvfree_rcu() caller considers the pointer freed at this point
+	 * and likely removes any references to it. Since the actual slab
+	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
+	 * this object (no scanning or false positives reporting).
+	 */
+	kmemleak_ignore(ptr);
+
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 	    !krcp->monitor_todo) {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb408..2da96d8b894a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -351,6 +351,10 @@ struct rcu_state {
 						/*  in jiffies. */
 	unsigned long jiffies_stall;		/* Time at which to check */
 						/*  for CPU stalls. */
+	int nr_fqs_jiffies_stall;		/* Number of fqs loops after
+						 * which read jiffies and set
+						 * jiffies_stall. Stall
+						 * warnings disabled if !0. */
 	unsigned long jiffies_resched;		/* Time at which to resched */
 						/*  a reluctant CPU. */
 	unsigned long n_force_qs_gpstart;	/* Snapshot of n_force_qs at */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 677ee3d8671b..6c1234fd927c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -121,12 +121,17 @@ static void panic_on_rcu_stall(void)
 /**
  * rcu_cpu_stall_reset - restart stall-warning timeout for current grace period
  *
+ * To perform the reset request from the caller, disable stall detection until
+ * 3 fqs loops have passed. This is required to ensure a fresh jiffies is
+ * loaded.  It should be safe to do from the fqs loop as enough timer
+ * interrupts and context switches should have passed.
+ *
  * The caller must disable hard irqs.
  */
 void rcu_cpu_stall_reset(void)
 {
-	WRITE_ONCE(rcu_state.jiffies_stall,
-		   jiffies + rcu_jiffies_till_stall_check());
+	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 3);
+	WRITE_ONCE(rcu_state.jiffies_stall, ULONG_MAX);
 }
 
 //////////////////////////////////////////////////////////////////////////////
@@ -142,6 +147,7 @@ static void record_gp_stall_check_time(void)
 	WRITE_ONCE(rcu_state.gp_start, j);
 	j1 = rcu_jiffies_till_stall_check();
 	smp_mb(); // ->gp_start before ->jiffies_stall and caller's ->gp_seq.
+	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 0);
 	WRITE_ONCE(rcu_state.jiffies_stall, j + j1);
 	rcu_state.jiffies_resched = j + j1 / 2;
 	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
@@ -662,6 +668,16 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    !rcu_gp_in_progress())
 		return;
 	rcu_stall_kick_kthreads();
+
+	/*
+	 * Check if it was requested (via rcu_cpu_stall_reset()) that the FQS
+	 * loop has to set jiffies to ensure a non-stale jiffies value. This
+	 * is required to have good jiffies value after coming out of long
+	 * breaks of jiffies updates. Not doing so can cause false positives.
+	 */
+	if (READ_ONCE(rcu_state.nr_fqs_jiffies_stall) > 0)
+		return;
+
 	j = jiffies;
 
 	/*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f7440c0c7e43..c0271417dbed 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -65,6 +65,7 @@ EXPORT_SYMBOL_GPL(pm_power_off_prepare);
 void emergency_restart(void)
 {
 	kmsg_dump(KMSG_DUMP_EMERG);
+	system_state = SYSTEM_RESTART;
 	machine_emergency_restart();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e5dc7b5a261c..a930a9d7d834 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3249,14 +3249,9 @@ static __always_inline int
 trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	unsigned int val = cpu_buffer->current_context;
-	unsigned long pc = preempt_count();
-	int bit;
+	int bit = interrupt_context_level();
 
-	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
-		bit = RB_CTX_NORMAL;
-	else
-		bit = pc & NMI_MASK ? RB_CTX_NMI :
-			pc & HARDIRQ_MASK ? RB_CTX_IRQ : RB_CTX_SOFTIRQ;
+	bit = RB_CTX_NORMAL - bit;
 
 	if (unlikely(val & (1 << (bit + cpu_buffer->nest)))) {
 		/*
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7453840c77be..c35c805e4ab1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4900,6 +4900,20 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
+	mutex_lock(&event_mutex);
+
+	/* Fail if the file is marked for removal */
+	if (file->flags & EVENT_FILE_FL_FREED) {
+		trace_array_put(file->tr);
+		ret = -ENODEV;
+	} else {
+		event_file_get(file);
+	}
+
+	mutex_unlock(&event_mutex);
+	if (ret)
+		return ret;
+
 	filp->private_data = inode->i_private;
 
 	return 0;
@@ -4910,6 +4924,7 @@ int tracing_release_file_tr(struct inode *inode, struct file *filp)
 	struct trace_event_file *file = inode->i_private;
 
 	trace_array_put(file->tr);
+	event_file_put(file);
 
 	return 0;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a4a90bd3373b..c6eb116dc279 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1620,6 +1620,9 @@ extern int register_event_command(struct event_command *cmd);
 extern int unregister_event_command(struct event_command *cmd);
 extern int register_trigger_hist_enable_disable_cmds(void);
 
+extern void event_file_get(struct trace_event_file *file);
+extern void event_file_put(struct trace_event_file *file);
+
 /**
  * struct event_trigger_ops - callbacks for trace event triggers
  *
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f8af4a15c3a8..0a7348b90ba5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -969,26 +969,38 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 	}
 }
 
-static void remove_event_file_dir(struct trace_event_file *file)
+void event_file_get(struct trace_event_file *file)
 {
-	struct dentry *dir = file->dir;
-	struct dentry *child;
+	atomic_inc(&file->ref);
+}
 
-	if (dir) {
-		spin_lock(&dir->d_lock);	/* probably unneeded */
-		list_for_each_entry(child, &dir->d_subdirs, d_child) {
-			if (d_really_is_positive(child))	/* probably unneeded */
-				d_inode(child)->i_private = NULL;
-		}
-		spin_unlock(&dir->d_lock);
+void event_file_put(struct trace_event_file *file)
+{
+	if (WARN_ON_ONCE(!atomic_read(&file->ref))) {
+		if (file->flags & EVENT_FILE_FL_FREED)
+			kmem_cache_free(file_cachep, file);
+		return;
+	}
 
-		tracefs_remove(dir);
+	if (atomic_dec_and_test(&file->ref)) {
+		/* Count should only go to zero when it is freed */
+		if (WARN_ON_ONCE(!(file->flags & EVENT_FILE_FL_FREED)))
+			return;
+		kmem_cache_free(file_cachep, file);
 	}
+}
+
+static void remove_event_file_dir(struct trace_event_file *file)
+{
+	struct dentry *dir = file->dir;
+
+	tracefs_remove(dir);
 
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
-	kmem_cache_free(file_cachep, file);
+	file->flags |= EVENT_FILE_FL_FREED;
+	event_file_put(file);
 }
 
 /*
@@ -1361,7 +1373,7 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
 
-	if (!file)
+	if (!file || flags & EVENT_FILE_FL_FREED)
 		return -ENODEV;
 
 	if (flags & EVENT_FILE_FL_ENABLED &&
@@ -1399,7 +1411,7 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
 		file = event_file_data(filp);
-		if (likely(file))
+		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED)))
 			ret = ftrace_event_enable_disable(file, val);
 		mutex_unlock(&event_mutex);
 		break;
@@ -1668,7 +1680,7 @@ event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	file = event_file_data(filp);
-	if (file)
+	if (file && !(file->flags & EVENT_FILE_FL_FREED))
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
@@ -2784,6 +2796,7 @@ trace_create_new_event(struct trace_event_call *call,
 	atomic_set(&file->tm_ref, 0);
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
+	event_file_get(file);
 
 	return file;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 06d6318ee537..60c34fc44a63 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1872,6 +1872,9 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 	struct event_filter *filter = NULL;
 	int err;
 
+	if (file->flags & EVENT_FILE_FL_FREED)
+		return -ENODEV;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_disable(file);
 		filter = event_filter(file);
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 1e02bb431dcb..43da364737a0 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -454,7 +454,7 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 		if ((unsigned long)str_val < TASK_SIZE)
-			ret = strncpy_from_user_nofault(str_field, str_val, STR_VAR_LEN_MAX);
+			ret = strncpy_from_user_nofault(str_field, (const void __user *)str_val, STR_VAR_LEN_MAX);
 		else
 #endif
 			ret = strncpy_from_kernel_nofault(str_field, str_val, STR_VAR_LEN_MAX);
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 54cbaa971139..ae31bf8d2feb 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -338,7 +338,7 @@ long watch_queue_set_filter(struct pipe_inode_info *pipe,
 	    filter.__reserved != 0)
 		return -EINVAL;
 
-	tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
+	tf = memdup_array_user(_filter->filters, filter.nr_filters, sizeof(*tf));
 	if (IS_ERR(tf))
 		return PTR_ERR(tf);
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 1cfa269bd448..271a015d2b85 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -183,6 +183,13 @@ static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
+static int __init softlockup_panic_setup(char *str)
+{
+	softlockup_panic = simple_strtoul(str, NULL, 0);
+	return 1;
+}
+__setup("softlockup_panic=", softlockup_panic_setup);
+
 static int __init nowatchdog_setup(char *str)
 {
 	watchdog_user_enabled = 0;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 19868cf58877..962ee27ec7d7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5209,50 +5209,54 @@ static void work_for_cpu_fn(struct work_struct *work)
 }
 
 /**
- * work_on_cpu - run a function in thread context on a particular cpu
+ * work_on_cpu_key - run a function in thread context on a particular cpu
  * @cpu: the cpu to run on
  * @fn: the function to run
  * @arg: the function arg
+ * @key: The lock class key for lock debugging purposes
  *
  * It is up to the caller to ensure that the cpu doesn't go offline.
  * The caller must not hold any locks which would prevent @fn from completing.
  *
  * Return: The value @fn returns.
  */
-long work_on_cpu(int cpu, long (*fn)(void *), void *arg)
+long work_on_cpu_key(int cpu, long (*fn)(void *),
+		     void *arg, struct lock_class_key *key)
 {
 	struct work_for_cpu wfc = { .fn = fn, .arg = arg };
 
-	INIT_WORK_ONSTACK(&wfc.work, work_for_cpu_fn);
+	INIT_WORK_ONSTACK_KEY(&wfc.work, work_for_cpu_fn, key);
 	schedule_work_on(cpu, &wfc.work);
 	flush_work(&wfc.work);
 	destroy_work_on_stack(&wfc.work);
 	return wfc.ret;
 }
-EXPORT_SYMBOL_GPL(work_on_cpu);
+EXPORT_SYMBOL_GPL(work_on_cpu_key);
 
 /**
- * work_on_cpu_safe - run a function in thread context on a particular cpu
+ * work_on_cpu_safe_key - run a function in thread context on a particular cpu
  * @cpu: the cpu to run on
  * @fn:  the function to run
  * @arg: the function argument
+ * @key: The lock class key for lock debugging purposes
  *
  * Disables CPU hotplug and calls work_on_cpu(). The caller must not hold
  * any locks which would prevent @fn from completing.
  *
  * Return: The value @fn returns.
  */
-long work_on_cpu_safe(int cpu, long (*fn)(void *), void *arg)
+long work_on_cpu_safe_key(int cpu, long (*fn)(void *),
+			  void *arg, struct lock_class_key *key)
 {
 	long ret = -ENODEV;
 
 	cpus_read_lock();
 	if (cpu_online(cpu))
-		ret = work_on_cpu(cpu, fn, arg);
+		ret = work_on_cpu_key(cpu, fn, arg, key);
 	cpus_read_unlock();
 	return ret;
 }
-EXPORT_SYMBOL_GPL(work_on_cpu_safe);
+EXPORT_SYMBOL_GPL(work_on_cpu_safe_key);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_FREEZER
diff --git a/mm/cma.c b/mm/cma.c
index a972c3440c40..26967c70e9c7 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -503,7 +503,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	 */
 	if (page) {
 		for (i = 0; i < count; i++)
-			page_kasan_tag_reset(page + i);
+			page_kasan_tag_reset(nth_page(page, i));
 	}
 
 	if (ret && !no_warn) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b68b2fe639fd..6f969ba0d688 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2822,7 +2822,8 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
  * Moreover, it should not come from DMA buffer and is not readily
  * reclaimable. So those GFP bits should be masked off.
  */
-#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
+#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
+				 __GFP_ACCOUNT | __GFP_NOFAIL)
 
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 81f2a97c886c..bf611c55fc66 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1677,7 +1677,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		 */
 		if (HPageMigratable(head))
 			goto found;
-		skip = compound_nr(head) - (page - head);
+		skip = compound_nr(head) - (pfn - page_to_pfn(head));
 		pfn += skip - 1;
 	}
 	return -ENOENT;
diff --git a/net/9p/client.c b/net/9p/client.c
index 9fdcaa956c00..ead458486fdc 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -2020,7 +2020,7 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *file_fid,
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P,
-		 ">>> TXATTRWALK file_fid %d, attr_fid %d name %s\n",
+		 ">>> TXATTRWALK file_fid %d, attr_fid %d name '%s'\n",
 		 file_fid->fid, attr_fid->fid, attr_name);
 
 	req = p9_client_rpc(clnt, P9_TXATTRWALK, "dds",
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index f359cfdc1858..b44b77d3b35d 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -835,14 +835,21 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 		goto out_free_ts;
 	if (!(ts->rd->f_mode & FMODE_READ))
 		goto out_put_rd;
-	/* prevent workers from hanging on IO when fd is a pipe */
-	ts->rd->f_flags |= O_NONBLOCK;
+	/* Prevent workers from hanging on IO when fd is a pipe.
+	 * It's technically possible for userspace or concurrent mounts to
+	 * modify this flag concurrently, which will likely result in a
+	 * broken filesystem. However, just having bad flags here should
+	 * not crash the kernel or cause any other sort of bug, so mark this
+	 * particular data race as intentional so that tooling (like KCSAN)
+	 * can allow it and detect further problems.
+	 */
+	data_race(ts->rd->f_flags |= O_NONBLOCK);
 	ts->wr = fget(wfd);
 	if (!ts->wr)
 		goto out_put_rd;
 	if (!(ts->wr->f_mode & FMODE_WRITE))
 		goto out_put_wr;
-	ts->wr->f_flags |= O_NONBLOCK;
+	data_race(ts->wr->f_flags |= O_NONBLOCK);
 
 	client->trans = ts;
 	client->status = Connected;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5f1e388c2b95..ce538dbe89d1 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -135,13 +135,11 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 			hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
 	}
 
-	hci_conn_del_sysfs(conn);
-
 	debugfs_remove_recursive(conn->debugfs);
 
-	hci_dev_put(hdev);
+	hci_conn_del_sysfs(conn);
 
-	hci_conn_put(conn);
+	hci_dev_put(hdev);
 }
 
 static void le_scan_cleanup(struct work_struct *work)
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 08542dfc2dc5..633b82d54272 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -33,7 +33,7 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	conn->dev.type = &bt_link;
 	conn->dev.class = bt_class;
@@ -46,27 +46,30 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (device_is_registered(&conn->dev))
 		return;
 
 	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
 
-	if (device_add(&conn->dev) < 0) {
+	if (device_add(&conn->dev) < 0)
 		bt_dev_err(hdev, "failed to register connection device");
-		return;
-	}
-
-	hci_dev_hold(hdev);
 }
 
 void hci_conn_del_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	if (!device_is_registered(&conn->dev))
+	bt_dev_dbg(hdev, "conn %p", conn);
+
+	if (!device_is_registered(&conn->dev)) {
+		/* If device_add() has *not* succeeded, use *only* put_device()
+		 * to drop the reference count.
+		 */
+		put_device(&conn->dev);
 		return;
+	}
 
 	while (1) {
 		struct device *dev;
@@ -78,9 +81,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		put_device(dev);
 	}
 
-	device_del(&conn->dev);
-
-	hci_dev_put(hdev);
+	device_unregister(&conn->dev);
 }
 
 static void bt_host_release(struct device *dev)
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index fdbed3158555..d14b2dbbd1df 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -36,7 +36,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 	ktime_t tstamp = skb->tstamp;
 	struct ip_frag_state state;
 	struct iphdr *iph;
-	int err;
+	int err = 0;
 
 	/* for offloaded checksums cleanup checksum before fragmentation */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 97805ec424c1..1967fd063cfb 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -53,7 +53,7 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 			goto err;
 
 		br_vlan_get_proto(br_dev, &p_proto);
-		nft_reg_store16(dest, htons(p_proto));
+		nft_reg_store_be16(dest, htons(p_proto));
 		return;
 	}
 	default:
diff --git a/net/core/sock.c b/net/core/sock.c
index 8faa0f9cc083..662cd6d54ac7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -557,7 +557,7 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 	    INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check, ipv4_dst_check,
 			       dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
-		sk->sk_dst_pending_confirm = 0;
+		WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
 		dst_release(dst);
 		return NULL;
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 0b0567a692a8..1b285a57c7aa 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -1131,7 +1131,6 @@ static int __init dccp_init(void)
 
 	BUILD_BUG_ON(sizeof(struct dccp_skb_cb) >
 		     sizeof_field(struct sk_buff, cb));
-	inet_hashinfo_init(&dccp_hashinfo);
 	rc = inet_hashinfo2_init_mod(&dccp_hashinfo);
 	if (rc)
 		goto out_fail;
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index ae70e07c5244..09cabed358fd 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1028,12 +1028,13 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 		if (!(idiag_states & TCPF_LISTEN) || r->id.idiag_dport)
 			goto skip_listen_ht;
 
-		for (i = s_i; i < INET_LHTABLE_SIZE; i++) {
+		for (i = s_i; i <= hashinfo->lhash2_mask; i++) {
 			struct inet_listen_hashbucket *ilb;
 			struct hlist_nulls_node *node;
 
 			num = 0;
-			ilb = &hashinfo->listening_hash[i];
+			ilb = &hashinfo->lhash2[i];
+
 			spin_lock(&ilb->lock);
 			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
 				struct inet_sock *inet = inet_sk(sk);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 2936676f86eb..b4e0120af9c2 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -193,42 +193,6 @@ inet_lhash2_bucket_sk(struct inet_hashinfo *h, struct sock *sk)
 	return inet_lhash2_bucket(h, hash);
 }
 
-static void inet_hash2(struct inet_hashinfo *h, struct sock *sk)
-{
-	struct inet_listen_hashbucket *ilb2;
-
-	if (!h->lhash2)
-		return;
-
-	ilb2 = inet_lhash2_bucket_sk(h, sk);
-
-	spin_lock(&ilb2->lock);
-	if (sk->sk_reuseport && sk->sk_family == AF_INET6)
-		hlist_add_tail_rcu(&inet_csk(sk)->icsk_listen_portaddr_node,
-				   &ilb2->head);
-	else
-		hlist_add_head_rcu(&inet_csk(sk)->icsk_listen_portaddr_node,
-				   &ilb2->head);
-	ilb2->count++;
-	spin_unlock(&ilb2->lock);
-}
-
-static void inet_unhash2(struct inet_hashinfo *h, struct sock *sk)
-{
-	struct inet_listen_hashbucket *ilb2;
-
-	if (!h->lhash2 ||
-	    WARN_ON_ONCE(hlist_unhashed(&inet_csk(sk)->icsk_listen_portaddr_node)))
-		return;
-
-	ilb2 = inet_lhash2_bucket_sk(h, sk);
-
-	spin_lock(&ilb2->lock);
-	hlist_del_init_rcu(&inet_csk(sk)->icsk_listen_portaddr_node);
-	ilb2->count--;
-	spin_unlock(&ilb2->lock);
-}
-
 static inline int compute_score(struct sock *sk, struct net *net,
 				const unsigned short hnum, const __be32 daddr,
 				const int dif, const int sdif)
@@ -282,12 +246,11 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 				const __be32 daddr, const unsigned short hnum,
 				const int dif, const int sdif)
 {
-	struct inet_connection_sock *icsk;
 	struct sock *sk, *result = NULL;
+	struct hlist_nulls_node *node;
 	int score, hiscore = 0;
 
-	inet_lhash2_for_each_icsk_rcu(icsk, &ilb2->head) {
-		sk = (struct sock *)icsk;
+	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = lookup_reuseport(net, sk, skb, doff,
@@ -628,7 +591,7 @@ static int inet_reuseport_add_sock(struct sock *sk,
 int __inet_hash(struct sock *sk, struct sock *osk)
 {
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
-	struct inet_listen_hashbucket *ilb;
+	struct inet_listen_hashbucket *ilb2;
 	int err = 0;
 
 	if (sk->sk_state != TCP_LISTEN) {
@@ -638,25 +601,23 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 		return 0;
 	}
 	WARN_ON(!sk_unhashed(sk));
-	ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
+	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 
-	spin_lock(&ilb->lock);
+	spin_lock(&ilb2->lock);
 	if (sk->sk_reuseport) {
-		err = inet_reuseport_add_sock(sk, ilb);
+		err = inet_reuseport_add_sock(sk, ilb2);
 		if (err)
 			goto unlock;
 	}
+	sock_set_flag(sk, SOCK_RCU_FREE);
 	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
 		sk->sk_family == AF_INET6)
-		__sk_nulls_add_node_tail_rcu(sk, &ilb->nulls_head);
+		__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
 	else
-		__sk_nulls_add_node_rcu(sk, &ilb->nulls_head);
-	inet_hash2(hashinfo, sk);
-	ilb->count++;
-	sock_set_flag(sk, SOCK_RCU_FREE);
+		__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
-	spin_unlock(&ilb->lock);
+	spin_unlock(&ilb2->lock);
 
 	return err;
 }
@@ -673,23 +634,6 @@ int inet_hash(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(inet_hash);
 
-static void __inet_unhash(struct sock *sk, struct inet_listen_hashbucket *ilb)
-{
-	if (sk_unhashed(sk))
-		return;
-
-	if (rcu_access_pointer(sk->sk_reuseport_cb))
-		reuseport_stop_listen_sock(sk);
-	if (ilb) {
-		struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
-
-		inet_unhash2(hashinfo, sk);
-		ilb->count--;
-	}
-	__sk_nulls_del_node_init_rcu(sk);
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-}
-
 void inet_unhash(struct sock *sk)
 {
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
@@ -698,20 +642,34 @@ void inet_unhash(struct sock *sk)
 		return;
 
 	if (sk->sk_state == TCP_LISTEN) {
-		struct inet_listen_hashbucket *ilb;
+		struct inet_listen_hashbucket *ilb2;
 
-		ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
+		ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 		/* Don't disable bottom halves while acquiring the lock to
 		 * avoid circular locking dependency on PREEMPT_RT.
 		 */
-		spin_lock(&ilb->lock);
-		__inet_unhash(sk, ilb);
-		spin_unlock(&ilb->lock);
+		spin_lock(&ilb2->lock);
+		if (sk_unhashed(sk)) {
+			spin_unlock(&ilb2->lock);
+			return;
+		}
+
+		if (rcu_access_pointer(sk->sk_reuseport_cb))
+			reuseport_stop_listen_sock(sk);
+
+		__sk_nulls_del_node_init_rcu(sk);
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+		spin_unlock(&ilb2->lock);
 	} else {
 		spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 
 		spin_lock_bh(lock);
-		__inet_unhash(sk, NULL);
+		if (sk_unhashed(sk)) {
+			spin_unlock_bh(lock);
+			return;
+		}
+		__sk_nulls_del_node_init_rcu(sk);
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		spin_unlock_bh(lock);
 	}
 }
@@ -859,29 +817,14 @@ int inet_hash_connect(struct inet_timewait_death_row *death_row,
 }
 EXPORT_SYMBOL_GPL(inet_hash_connect);
 
-void inet_hashinfo_init(struct inet_hashinfo *h)
-{
-	int i;
-
-	for (i = 0; i < INET_LHTABLE_SIZE; i++) {
-		spin_lock_init(&h->listening_hash[i].lock);
-		INIT_HLIST_NULLS_HEAD(&h->listening_hash[i].nulls_head,
-				      i + LISTENING_NULLS_BASE);
-		h->listening_hash[i].count = 0;
-	}
-
-	h->lhash2 = NULL;
-}
-EXPORT_SYMBOL_GPL(inet_hashinfo_init);
-
 static void init_hashinfo_lhash2(struct inet_hashinfo *h)
 {
 	int i;
 
 	for (i = 0; i <= h->lhash2_mask; i++) {
 		spin_lock_init(&h->lhash2[i].lock);
-		INIT_HLIST_HEAD(&h->lhash2[i].head);
-		h->lhash2[i].count = 0;
+		INIT_HLIST_NULLS_HEAD(&h->lhash2[i].nulls_head,
+				      i + LISTENING_NULLS_BASE);
 	}
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6dcb77a2bde6..86dff7abdfd6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4554,7 +4554,6 @@ void __init tcp_init(void)
 	timer_setup(&tcp_orphan_timer, tcp_orphan_update, TIMER_DEFERRABLE);
 	mod_timer(&tcp_orphan_timer, jiffies + TCP_ORPHAN_TIMER_PERIOD);
 
-	inet_hashinfo_init(&tcp_hashinfo);
 	inet_hashinfo2_init(&tcp_hashinfo, "tcp_listen_portaddr_hash",
 			    thash_entries, 21,  /* one slot per 2 MB*/
 			    0, 64 * 1024);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f89cb184649e..0666be6b9ec9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2343,16 +2343,15 @@ static void *listening_get_first(struct seq_file *seq)
 	st->offset = 0;
 	for (; st->bucket <= tcp_hashinfo.lhash2_mask; st->bucket++) {
 		struct inet_listen_hashbucket *ilb2;
-		struct inet_connection_sock *icsk;
+		struct hlist_nulls_node *node;
 		struct sock *sk;
 
 		ilb2 = &tcp_hashinfo.lhash2[st->bucket];
-		if (hlist_empty(&ilb2->head))
+		if (hlist_nulls_empty(&ilb2->nulls_head))
 			continue;
 
 		spin_lock(&ilb2->lock);
-		inet_lhash2_for_each_icsk(icsk, &ilb2->head) {
-			sk = (struct sock *)icsk;
+		sk_nulls_for_each(sk, node, &ilb2->nulls_head) {
 			if (seq_sk_match(seq, sk))
 				return sk;
 		}
@@ -2371,15 +2370,14 @@ static void *listening_get_next(struct seq_file *seq, void *cur)
 {
 	struct tcp_iter_state *st = seq->private;
 	struct inet_listen_hashbucket *ilb2;
-	struct inet_connection_sock *icsk;
+	struct hlist_nulls_node *node;
 	struct sock *sk = cur;
 
 	++st->num;
 	++st->offset;
 
-	icsk = inet_csk(sk);
-	inet_lhash2_for_each_icsk_continue(icsk) {
-		sk = (struct sock *)icsk;
+	sk = sk_nulls_next(sk);
+	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk))
 			return sk;
 	}
@@ -2788,16 +2786,15 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 {
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct tcp_iter_state *st = &iter->state;
-	struct inet_connection_sock *icsk;
+	struct hlist_nulls_node *node;
 	unsigned int expected = 1;
 	struct sock *sk;
 
 	sock_hold(start_sk);
 	iter->batch[iter->end_sk++] = start_sk;
 
-	icsk = inet_csk(start_sk);
-	inet_lhash2_for_each_icsk_continue(icsk) {
-		sk = (struct sock *)icsk;
+	sk = sk_nulls_next(start_sk);
+	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9d5e652c9bba..8032ccb69463 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1318,7 +1318,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	skb->destructor = skb_is_tcp_pure_ack(skb) ? __sock_wfree : tcp_wfree;
 	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
 
-	skb_set_dst_pending_confirm(skb, sk->sk_dst_pending_confirm);
+	skb_set_dst_pending_confirm(skb, READ_ONCE(sk->sk_dst_pending_confirm));
 
 	/* Build TCP header and checksum it. */
 	th = (struct tcphdr *)skb->data;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b4a5e01e1201..c40cbdfc6247 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -138,12 +138,11 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 		const __be16 sport, const struct in6_addr *daddr,
 		const unsigned short hnum, const int dif, const int sdif)
 {
-	struct inet_connection_sock *icsk;
 	struct sock *sk, *result = NULL;
+	struct hlist_nulls_node *node;
 	int score, hiscore = 0;
 
-	inet_lhash2_for_each_icsk_rcu(icsk, &ilb2->head) {
-		sk = (struct sock *)icsk;
+	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = lookup_reuseport(net, sk, skb, doff,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 4fa216a108ae..02bd90a53705 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2762,6 +2762,10 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	else
 		*dbm = sdata->vif.bss_conf.txpower;
 
+	/* INT_MIN indicates no power level was set yet */
+	if (*dbm == INT_MIN)
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 292374fb0779..520ee6585055 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -66,20 +66,103 @@ static int mptcp_diag_dump_one(struct netlink_callback *cb,
 	return err;
 }
 
+struct mptcp_diag_ctx {
+	long s_slot;
+	long s_num;
+	unsigned int l_slot;
+	unsigned int l_num;
+};
+
+static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callback *cb,
+				      const struct inet_diag_req_v2 *r,
+				      bool net_admin)
+{
+	struct inet_diag_dump_data *cb_data = cb->data;
+	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
+	struct nlattr *bc = cb_data->inet_diag_nla_bc;
+	struct net *net = sock_net(skb->sk);
+	int i;
+
+	for (i = diag_ctx->l_slot; i <= tcp_hashinfo.lhash2_mask; i++) {
+		struct inet_listen_hashbucket *ilb;
+		struct hlist_nulls_node *node;
+		struct sock *sk;
+		int num = 0;
+
+		ilb = &tcp_hashinfo.lhash2[i];
+
+		rcu_read_lock();
+		spin_lock(&ilb->lock);
+		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
+			const struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(sk);
+			struct inet_sock *inet = inet_sk(sk);
+			int ret;
+
+			if (num < diag_ctx->l_num)
+				goto next_listen;
+
+			if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->name, "mptcp"))
+				goto next_listen;
+
+			sk = ctx->conn;
+			if (!sk || !net_eq(sock_net(sk), net))
+				goto next_listen;
+
+			if (r->sdiag_family != AF_UNSPEC &&
+			    sk->sk_family != r->sdiag_family)
+				goto next_listen;
+
+			if (r->id.idiag_sport != inet->inet_sport &&
+			    r->id.idiag_sport)
+				goto next_listen;
+
+			if (!refcount_inc_not_zero(&sk->sk_refcnt))
+				goto next_listen;
+
+			ret = sk_diag_dump(sk, skb, cb, r, bc, net_admin);
+
+			sock_put(sk);
+
+			if (ret < 0) {
+				spin_unlock(&ilb->lock);
+				rcu_read_unlock();
+				diag_ctx->l_slot = i;
+				diag_ctx->l_num = num;
+				return;
+			}
+			diag_ctx->l_num = num + 1;
+			num = 0;
+next_listen:
+			++num;
+		}
+		spin_unlock(&ilb->lock);
+		rcu_read_unlock();
+
+		cond_resched();
+		diag_ctx->l_num = 0;
+	}
+
+	diag_ctx->l_num = 0;
+	diag_ctx->l_slot = i;
+}
+
 static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			    const struct inet_diag_req_v2 *r)
 {
 	bool net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN);
+	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
 	struct inet_diag_dump_data *cb_data;
 	struct mptcp_sock *msk;
 	struct nlattr *bc;
 
+	BUILD_BUG_ON(sizeof(cb->ctx) < sizeof(*diag_ctx));
+
 	cb_data = cb->data;
 	bc = cb_data->inet_diag_nla_bc;
 
-	while ((msk = mptcp_token_iter_next(net, &cb->args[0], &cb->args[1])) !=
-	       NULL) {
+	while ((msk = mptcp_token_iter_next(net, &diag_ctx->s_slot,
+					    &diag_ctx->s_num)) != NULL) {
 		struct inet_sock *inet = (struct inet_sock *)msk;
 		struct sock *sk = (struct sock *)msk;
 		int ret = 0;
@@ -101,11 +184,14 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		sock_put(sk);
 		if (ret < 0) {
 			/* will retry on the same position */
-			cb->args[1]--;
+			diag_ctx->s_num--;
 			break;
 		}
 		cond_resched();
 	}
+
+	if ((r->idiag_states & TCPF_LISTEN) && r->id.idiag_dport == 0)
+		mptcp_diag_dump_listeners(skb, cb, r, net_admin);
 }
 
 static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
@@ -119,6 +205,19 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 
 	r->idiag_rqueue = sk_rmem_alloc_get(sk);
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
+
+	if (inet_sk_state_load(sk) == TCP_LISTEN) {
+		struct sock *lsk = READ_ONCE(msk->first);
+
+		if (lsk) {
+			/* override with settings from tcp listener,
+			 * so Send-Q will show accept queue.
+			 */
+			r->idiag_rqueue = READ_ONCE(lsk->sk_ack_backlog);
+			r->idiag_wqueue = READ_ONCE(lsk->sk_max_ack_backlog);
+		}
+	}
+
 	if (!info)
 		return;
 
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index f8854bff286c..62fb1031763d 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,11 +89,6 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
-	if (had_link)
-		netif_carrier_off(ndp->ndev.dev);
-	else
-		netif_carrier_on(ndp->ndev.dev);
-
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8f12e83280cb..bf0bd44f2fb3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6049,6 +6049,12 @@ static int nft_setelem_deactivate(const struct net *net,
 	return ret;
 }
 
+static void nft_setelem_catchall_destroy(struct nft_set_elem_catchall *catchall)
+{
+	list_del_rcu(&catchall->list);
+	kfree_rcu(catchall, rcu);
+}
+
 static void nft_setelem_catchall_remove(const struct net *net,
 					const struct nft_set *set,
 					const struct nft_set_elem *elem)
@@ -6057,8 +6063,7 @@ static void nft_setelem_catchall_remove(const struct net *net,
 
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		if (catchall->elem == elem->priv) {
-			list_del_rcu(&catchall->list);
-			kfree_rcu(catchall, rcu);
+			nft_setelem_catchall_destroy(catchall);
 			break;
 		}
 	}
@@ -9042,9 +9047,8 @@ void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
 	call_rcu(&trans->rcu, nft_trans_gc_trans_free);
 }
 
-static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
-						  unsigned int gc_seq,
-						  bool sync)
+struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
+						 unsigned int gc_seq)
 {
 	struct nft_set_elem_catchall *catchall;
 	const struct nft_set *set = gc->set;
@@ -9060,11 +9064,7 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 
 		nft_set_elem_dead(ext);
 dead_elem:
-		if (sync)
-			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
-		else
-			gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
-
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
 		if (!gc)
 			return NULL;
 
@@ -9074,15 +9074,34 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 	return gc;
 }
 
-struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
-						 unsigned int gc_seq)
-{
-	return nft_trans_gc_catchall(gc, gc_seq, false);
-}
-
 struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 {
-	return nft_trans_gc_catchall(gc, 0, true);
+	struct nft_set_elem_catchall *catchall, *next;
+	const struct nft_set *set = gc->set;
+	struct nft_set_elem elem;
+	struct nft_set_ext *ext;
+
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net));
+
+	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
+		ext = nft_set_elem_ext(set, catchall->elem);
+
+		if (!nft_set_elem_expired(ext))
+			continue;
+
+		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
+		if (!gc)
+			return NULL;
+
+		memset(&elem, 0, sizeof(elem));
+		elem.priv = catchall->elem;
+
+		nft_setelem_data_deactivate(gc->net, gc->set, &elem);
+		nft_setelem_catchall_destroy(catchall);
+		nft_trans_gc_elem_add(gc, elem.priv);
+	}
+
+	return gc;
 }
 
 static void nf_tables_module_autoload_cleanup(struct net *net)
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 7b0b8fecb220..adf208b7929f 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -38,20 +38,22 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 
 	switch (priv->size) {
 	case 8: {
+		u64 *dst64 = (void *)dst;
 		u64 src64;
 
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = nft_reg_load64(&src[i]);
-				nft_reg_store64(&dst[i], be64_to_cpu(src64));
+				nft_reg_store64(&dst64[i],
+						be64_to_cpu((__force __be64)src64));
 			}
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = (__force __u64)
 					cpu_to_be64(nft_reg_load64(&src[i]));
-				nft_reg_store64(&dst[i], src64);
+				nft_reg_store64(&dst64[i], src64);
 			}
 			break;
 		}
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 14412f69a34e..35aba304a25b 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -63,7 +63,7 @@ nft_meta_get_eval_time(enum nft_meta_keys key,
 {
 	switch (key) {
 	case NFT_META_TIME_NS:
-		nft_reg_store64(dest, ktime_get_real_ns());
+		nft_reg_store64((u64 *)dest, ktime_get_real_ns());
 		break;
 	case NFT_META_TIME_DAY:
 		nft_reg_store8(dest, nft_meta_weekday());
diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index 720dc9fba6d4..c9c124200a4d 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -99,7 +99,7 @@ static int nft_osf_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	if (nla_put_u8(skb, NFTA_OSF_TTL, priv->ttl))
 		goto nla_put_failure;
 
-	if (nla_put_be32(skb, NFTA_OSF_FLAGS, ntohl(priv->flags)))
+	if (nla_put_u32(skb, NFTA_OSF_FLAGS, ntohl((__force __be32)priv->flags)))
 		goto nla_put_failure;
 
 	if (nft_dump_register(skb, NFTA_OSF_DREG, priv->dreg))
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 9ad9cc0d1d27..1725e7349f3d 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -162,7 +162,7 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->key = ntohl(nla_get_u32(tb[NFTA_SOCKET_KEY]));
+	priv->key = ntohl(nla_get_be32(tb[NFTA_SOCKET_KEY]));
 	switch(priv->key) {
 	case NFT_SOCKET_TRANSPARENT:
 	case NFT_SOCKET_WILDCARD:
@@ -178,7 +178,7 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 		if (!tb[NFTA_SOCKET_LEVEL])
 			return -EINVAL;
 
-		level = ntohl(nla_get_u32(tb[NFTA_SOCKET_LEVEL]));
+		level = ntohl(nla_get_be32(tb[NFTA_SOCKET_LEVEL]));
 		if (level > 255)
 			return -EOPNOTSUPP;
 
@@ -200,12 +200,12 @@ static int nft_socket_dump(struct sk_buff *skb,
 {
 	const struct nft_socket *priv = nft_expr_priv(expr);
 
-	if (nla_put_u32(skb, NFTA_SOCKET_KEY, htonl(priv->key)))
+	if (nla_put_be32(skb, NFTA_SOCKET_KEY, htonl(priv->key)))
 		return -1;
 	if (nft_dump_register(skb, NFTA_SOCKET_DREG, priv->dreg))
 		return -1;
 	if (priv->key == NFT_SOCKET_CGROUPV2 &&
-	    nla_put_u32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level)))
+	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level)))
 		return -1;
 	return 0;
 }
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index 9fea90ed79d4..e9679cb4afbe 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -52,11 +52,11 @@ static void nft_tproxy_eval_v4(const struct nft_expr *expr,
 				   skb->dev, NF_TPROXY_LOOKUP_ESTABLISHED);
 
 	if (priv->sreg_addr)
-		taddr = regs->data[priv->sreg_addr];
+		taddr = nft_reg_load_be32(&regs->data[priv->sreg_addr]);
 	taddr = nf_tproxy_laddr4(skb, taddr, iph->daddr);
 
 	if (priv->sreg_port)
-		tport = nft_reg_load16(&regs->data[priv->sreg_port]);
+		tport = nft_reg_load_be16(&regs->data[priv->sreg_port]);
 	if (!tport)
 		tport = hp->dest;
 
@@ -124,7 +124,7 @@ static void nft_tproxy_eval_v6(const struct nft_expr *expr,
 	taddr = *nf_tproxy_laddr6(skb, &taddr, &iph->daddr);
 
 	if (priv->sreg_port)
-		tport = nft_reg_load16(&regs->data[priv->sreg_port]);
+		tport = nft_reg_load_be16(&regs->data[priv->sreg_port]);
 	if (!tport)
 		tport = hp->dest;
 
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index cbbbc4ecad3a..3553f89fd057 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -50,7 +50,7 @@ static int nft_xfrm_get_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	priv->key = ntohl(nla_get_u32(tb[NFTA_XFRM_KEY]));
+	priv->key = ntohl(nla_get_be32(tb[NFTA_XFRM_KEY]));
 	switch (priv->key) {
 	case NFT_XFRM_KEY_REQID:
 	case NFT_XFRM_KEY_SPI:
@@ -132,13 +132,13 @@ static void nft_xfrm_state_get_key(const struct nft_xfrm *priv,
 		WARN_ON_ONCE(1);
 		break;
 	case NFT_XFRM_KEY_DADDR_IP4:
-		*dest = state->id.daddr.a4;
+		*dest = (__force __u32)state->id.daddr.a4;
 		return;
 	case NFT_XFRM_KEY_DADDR_IP6:
 		memcpy(dest, &state->id.daddr.in6, sizeof(struct in6_addr));
 		return;
 	case NFT_XFRM_KEY_SADDR_IP4:
-		*dest = state->props.saddr.a4;
+		*dest = (__force __u32)state->props.saddr.a4;
 		return;
 	case NFT_XFRM_KEY_SADDR_IP6:
 		memcpy(dest, &state->props.saddr.in6, sizeof(struct in6_addr));
@@ -147,7 +147,7 @@ static void nft_xfrm_state_get_key(const struct nft_xfrm *priv,
 		*dest = state->props.reqid;
 		return;
 	case NFT_XFRM_KEY_SPI:
-		*dest = state->id.spi;
+		*dest = (__force __u32)state->id.spi;
 		return;
 	}
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 7756c62e0c3e..af1ca707c3d3 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -111,7 +111,8 @@ static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
-		__rpc_clnt_remove_pipedir(clnt);
+		if (pipefs_sb == clnt->pipefs_sb)
+			__rpc_clnt_remove_pipedir(clnt);
 		rpc_put_sb_net(net);
 	}
 }
@@ -151,6 +152,8 @@ rpc_setup_pipedir(struct super_block *pipefs_sb, struct rpc_clnt *clnt)
 {
 	struct dentry *dentry;
 
+	clnt->pipefs_sb = pipefs_sb;
+
 	if (clnt->cl_program->pipe_dir_name != NULL) {
 		dentry = rpc_setup_pipedir_sb(pipefs_sb, clnt);
 		if (IS_ERR(dentry))
@@ -2088,6 +2091,7 @@ call_connect_status(struct rpc_task *task)
 	task->tk_status = 0;
 	switch (status) {
 	case -ECONNREFUSED:
+	case -ECONNRESET:
 		/* A positive refusal suggests a rebind is needed. */
 		if (RPC_IS_SOFTCONN(task))
 			break;
@@ -2096,7 +2100,6 @@ call_connect_status(struct rpc_task *task)
 			goto out_retry;
 		}
 		fallthrough;
-	case -ECONNRESET:
 	case -ECONNABORTED:
 	case -ENETDOWN:
 	case -ENETUNREACH:
diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 647b323cc1d5..638b14f28101 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -746,6 +746,10 @@ void rpcb_getport_async(struct rpc_task *task)
 
 	child = rpcb_call_async(rpcb_clnt, map, proc);
 	rpc_release_client(rpcb_clnt);
+	if (IS_ERR(child)) {
+		/* rpcb_map_release() has freed the arguments */
+		return;
+	}
 
 	xprt->stat.bind_count++;
 	rpc_put_task(child);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 0377679678f9..9a80d3be1f63 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -852,7 +852,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	if (ret == -EINVAL)
 		svc_rdma_send_error(rdma_xprt, ctxt, ret);
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
-	return ret;
+	svc_xprt_deferred_close(xprt);
+	return -ENOTCONN;
 
 out_backchannel:
 	svc_rdma_handle_bc_reply(rqstp, ctxt);
diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index ce00f271ca6b..116a97e30144 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -101,6 +101,7 @@ static int tipc_add_tlv(struct sk_buff *skb, u16 type, void *data, u16 len)
 		return -EMSGSIZE;
 
 	skb_put(skb, TLV_SPACE(len));
+	memset(tlv, 0, TLV_SPACE(len));
 	tlv->tlv_type = htons(type);
 	tlv->tlv_len = htons(TLV_LENGTH(len));
 	if (len && data)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 748769f4ba05..16b04e553a6c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2529,15 +2529,16 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	if (!(state->flags & MSG_PEEK))
 		WRITE_ONCE(u->oob_skb, NULL);
-
+	else
+		skb_get(oob_skb);
 	unix_state_unlock(sk);
 
 	chunk = state->recv_actor(oob_skb, 0, chunk, state);
 
-	if (!(state->flags & MSG_PEEK)) {
+	if (!(state->flags & MSG_PEEK))
 		UNIXCB(oob_skb).consumed += 1;
-		kfree_skb(oob_skb);
-	}
+
+	consume_skb(oob_skb);
 
 	mutex_unlock(&u->iolock);
 
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 334741a31d0a..60e9359a71a5 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -209,12 +209,14 @@ static void partition_struct(tree *fields, unsigned long length, struct partitio
 
 static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prng_state)
 {
-	unsigned long i, x;
+	unsigned long i, x, index;
 	struct partition_group size_group[length];
 	unsigned long num_groups = 0;
 	unsigned long randnum;
 
 	partition_struct(newtree, length, (struct partition_group *)&size_group, &num_groups);
+
+	/* FIXME: this group shuffle is currently a no-op. */
 	for (i = num_groups - 1; i > 0; i--) {
 		struct partition_group tmp;
 		randnum = ranval(prng_state) % (i + 1);
@@ -224,11 +226,14 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
 	}
 
 	for (x = 0; x < num_groups; x++) {
-		for (i = size_group[x].start + size_group[x].length - 1; i > size_group[x].start; i--) {
+		for (index = size_group[x].length - 1; index > 0; index--) {
 			tree tmp;
+
+			i = size_group[x].start + index;
 			if (DECL_BIT_FIELD_TYPE(newtree[i]))
 				continue;
-			randnum = ranval(prng_state) % (i + 1);
+			randnum = ranval(prng_state) % (index + 1);
+			randnum += size_group[x].start;
 			// we could handle this case differently if desired
 			if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
 				continue;
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 65418e0906c1..cb251ab0e707 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -66,9 +66,32 @@ struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
 	return iint;
 }
 
-static void iint_free(struct integrity_iint_cache *iint)
+#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH+1)
+
+/*
+ * It is not clear that IMA should be nested at all, but as long is it measures
+ * files both on overlayfs and on underlying fs, we need to annotate the iint
+ * mutex to avoid lockdep false positives related to IMA + overlayfs.
+ * See ovl_lockdep_annotate_inode_mutex_key() for more details.
+ */
+static inline void iint_lockdep_annotate(struct integrity_iint_cache *iint,
+					 struct inode *inode)
+{
+#ifdef CONFIG_LOCKDEP
+	static struct lock_class_key iint_mutex_key[IMA_MAX_NESTING];
+
+	int depth = inode->i_sb->s_stack_depth;
+
+	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
+		depth = 0;
+
+	lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
+#endif
+}
+
+static void iint_init_always(struct integrity_iint_cache *iint,
+			     struct inode *inode)
 {
-	kfree(iint->ima_hash);
 	iint->ima_hash = NULL;
 	iint->version = 0;
 	iint->flags = 0UL;
@@ -80,6 +103,14 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+	mutex_init(&iint->mutex);
+	iint_lockdep_annotate(iint, inode);
+}
+
+static void iint_free(struct integrity_iint_cache *iint)
+{
+	kfree(iint->ima_hash);
+	mutex_destroy(&iint->mutex);
 	kmem_cache_free(iint_cache, iint);
 }
 
@@ -112,6 +143,8 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	if (!iint)
 		return NULL;
 
+	iint_init_always(iint, inode);
+
 	write_lock(&integrity_iint_lock);
 
 	p = &integrity_iint_tree.rb_node;
@@ -161,25 +194,18 @@ void integrity_inode_free(struct inode *inode)
 	iint_free(iint);
 }
 
-static void init_once(void *foo)
+static void iint_init_once(void *foo)
 {
 	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
 
 	memset(iint, 0, sizeof(*iint));
-	iint->ima_file_status = INTEGRITY_UNKNOWN;
-	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
-	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_read_status = INTEGRITY_UNKNOWN;
-	iint->ima_creds_status = INTEGRITY_UNKNOWN;
-	iint->evm_status = INTEGRITY_UNKNOWN;
-	mutex_init(&iint->mutex);
 }
 
 static int __init integrity_iintcache_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
-			      0, SLAB_PANIC, init_once);
+			      0, SLAB_PANIC, iint_init_once);
 	return 0;
 }
 DEFINE_LSM(integrity) = {
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 2c6c3a5228b5..04b9e465463b 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -216,6 +216,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
+	struct inode *real_inode = d_real_inode(file_dentry(file));
 	const char *filename = file->f_path.dentry->d_name.name;
 	int result = 0;
 	int length;
@@ -266,6 +267,10 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	iint->ima_hash = tmpbuf;
 	memcpy(iint->ima_hash, &hash, length);
 	iint->version = i_version;
+	if (real_inode != inode) {
+		iint->real_ino = real_inode->i_ino;
+		iint->real_dev = real_inode->i_sb->s_dev;
+	}
 
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e9a361109dd2..7cd9df849929 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,7 @@
 #include <linux/ima.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
+#include <linux/iversion.h>
 
 #include "ima.h"
 
@@ -202,7 +203,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *backing_inode, *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
@@ -278,6 +279,19 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		iint->measured_pcrs = 0;
 	}
 
+	/* Detect and re-evaluate changes made to the backing file. */
+	backing_inode = d_real_inode(file_dentry(file));
+	if (backing_inode != inode &&
+	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
+		if (!IS_I_VERSION(backing_inode) ||
+		    backing_inode->i_sb->s_dev != iint->real_dev ||
+		    backing_inode->i_ino != iint->real_ino ||
+		    !inode_eq_iversion(backing_inode, iint->version)) {
+			iint->flags &= ~IMA_DONE_MASK;
+			iint->measured_pcrs = 0;
+		}
+	}
+
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..06b0cb5ebaf4 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -131,6 +131,8 @@ struct integrity_iint_cache {
 	unsigned long flags;
 	unsigned long measured_pcrs;
 	unsigned long atomic_flags;
+	unsigned long real_ino;
+	dev_t real_dev;
 	enum integrity_status ima_file_status:4;
 	enum integrity_status ima_mmap_status:4;
 	enum integrity_status ima_bprm_status:4;
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 386e5f6e368a..a2d301d1a4b3 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -354,17 +354,17 @@ static int __init init_trusted(void)
 		if (!get_random)
 			get_random = kernel_get_random;
 
-		static_call_update(trusted_key_seal,
-				   trusted_key_sources[i].ops->seal);
-		static_call_update(trusted_key_unseal,
-				   trusted_key_sources[i].ops->unseal);
-		static_call_update(trusted_key_get_random,
-				   get_random);
-		trusted_key_exit = trusted_key_sources[i].ops->exit;
-		migratable = trusted_key_sources[i].ops->migratable;
-
 		ret = trusted_key_sources[i].ops->init();
-		if (!ret)
+		if (!ret) {
+			static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
+			static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
+			static_call_update(trusted_key_get_random, get_random);
+
+			trusted_key_exit = trusted_key_sources[i].ops->exit;
+			migratable = trusted_key_sources[i].ops->migratable;
+		}
+
+		if (!ret || ret != -ENODEV)
 			break;
 	}
 
diff --git a/sound/core/info.c b/sound/core/info.c
index 9f6714e29bbc..63252abf9998 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -56,7 +56,7 @@ struct snd_info_private_data {
 };
 
 static int snd_info_version_init(void);
-static void snd_info_disconnect(struct snd_info_entry *entry);
+static void snd_info_clear_entries(struct snd_info_entry *entry);
 
 /*
 
@@ -569,11 +569,16 @@ void snd_info_card_disconnect(struct snd_card *card)
 {
 	if (!card)
 		return;
-	mutex_lock(&info_mutex);
+
 	proc_remove(card->proc_root_link);
-	card->proc_root_link = NULL;
 	if (card->proc_root)
-		snd_info_disconnect(card->proc_root);
+		proc_remove(card->proc_root->p);
+
+	mutex_lock(&info_mutex);
+	if (card->proc_root)
+		snd_info_clear_entries(card->proc_root);
+	card->proc_root_link = NULL;
+	card->proc_root = NULL;
 	mutex_unlock(&info_mutex);
 }
 
@@ -745,15 +750,14 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
 }
 EXPORT_SYMBOL(snd_info_create_card_entry);
 
-static void snd_info_disconnect(struct snd_info_entry *entry)
+static void snd_info_clear_entries(struct snd_info_entry *entry)
 {
 	struct snd_info_entry *p;
 
 	if (!entry->p)
 		return;
 	list_for_each_entry(p, &entry->children, list)
-		snd_info_disconnect(p);
-	proc_remove(entry->p);
+		snd_info_clear_entries(p);
 	entry->p = NULL;
 }
 
@@ -770,8 +774,9 @@ void snd_info_free_entry(struct snd_info_entry * entry)
 	if (!entry)
 		return;
 	if (entry->p) {
+		proc_remove(entry->p);
 		mutex_lock(&info_mutex);
-		snd_info_disconnect(entry);
+		snd_info_clear_entries(entry);
 		mutex_unlock(&info_mutex);
 	}
 
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index eea22cf72aef..ec95d0449bfe 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -320,8 +320,10 @@ struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
 	struct hdac_stream *res = NULL;
 
 	/* make a non-zero unique key for the substream */
-	int key = (substream->pcm->device << 16) | (substream->number << 2) |
-		(substream->stream + 1);
+	int key = (substream->number << 2) | (substream->stream + 1);
+
+	if (substream->pcm)
+		key |= (substream->pcm->device << 16);
 
 	spin_lock_irq(&bus->reg_lock);
 	list_for_each_entry(azx_dev, &bus->stream_list, list) {
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 59e11a070c20..4ab3cbef72e8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9113,6 +9113,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x10c0, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x10d0, "ASUS X540LA/X540LJ", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x10d3, "ASUS K6500ZC", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
@@ -9963,22 +9964,6 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
 		{0x21, 0x03211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
-		{0x14, 0x90170110},
-		{0x21, 0x04211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
-		{0x14, 0x90170110},
-		{0x21, 0x04211030}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
-		ALC295_STANDARD_PINS,
-		{0x17, 0x21014020},
-		{0x18, 0x21a19030}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
-		ALC295_STANDARD_PINS,
-		{0x17, 0x21014040},
-		{0x18, 0x21a19050}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
-		ALC295_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC298_STANDARD_PINS,
 		{0x17, 0x90170110}),
@@ -10022,6 +10007,9 @@ static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+		{0x19, 0x40000000},
+		{0x1b, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index dd1a8b7bc794..8973f439123f 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1678,6 +1678,9 @@ static int wsa_macro_spk_boost_event(struct snd_soc_dapm_widget *w,
 		boost_path_cfg1 = CDC_WSA_RX1_RX_PATH_CFG1;
 		reg = CDC_WSA_RX1_RX_PATH_CTL;
 		reg_mix = CDC_WSA_RX1_RX_PATH_MIX_CTL;
+	} else {
+		dev_warn(component->dev, "Incorrect widget name in the driver\n");
+		return -EINVAL;
 	}
 
 	switch (event) {
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 4479d74f0a45..81d2be87e973 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -74,14 +74,16 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 		return -EINVAL;
 	}
 
-	pm_runtime_put_sync(mcbsp->dev);
+	if (mcbsp->active)
+		pm_runtime_put_sync(mcbsp->dev);
 
 	r = clk_set_parent(mcbsp->fclk, fck_src);
 	if (r)
 		dev_err(mcbsp->dev, "CLKS: could not clk_set_parent() to %s\n",
 			src);
 
-	pm_runtime_get_sync(mcbsp->dev);
+	if (mcbsp->active)
+		pm_runtime_get_sync(mcbsp->dev);
 
 	clk_put(fck_src);
 
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a3197efe52c6..65ada8065cfc 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2100,7 +2100,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if ((DO_BIC(BIC_CPU_c6) || soft_c1_residency_display(BIC_CPU_c6)) && !do_knl_cstates) {
 		if (get_msr(cpu, MSR_CORE_C6_RESIDENCY, &c->c6))
 			return -7;
-	} else if (do_knl_cstates || soft_c1_residency_display(BIC_CPU_c6)) {
+	} else if (do_knl_cstates && soft_c1_residency_display(BIC_CPU_c6)) {
 		if (get_msr(cpu, MSR_KNL_CORE_C6_RESIDENCY, &c->c6))
 			return -7;
 	}
@@ -5543,6 +5543,7 @@ void process_cpuid()
 	rapl_probe(family, model);
 	perf_limit_reasons_probe(family, model);
 	automatic_cstate_conversion_probe(family, model);
+	prewake_cstate_probe(family, model);
 
 	check_tcc_offset(model_orig);
 
diff --git a/tools/testing/selftests/efivarfs/create-read.c b/tools/testing/selftests/efivarfs/create-read.c
index 9674a19396a3..7bc7af4eb2c1 100644
--- a/tools/testing/selftests/efivarfs/create-read.c
+++ b/tools/testing/selftests/efivarfs/create-read.c
@@ -32,8 +32,10 @@ int main(int argc, char **argv)
 	rc = read(fd, buf, sizeof(buf));
 	if (rc != 0) {
 		fprintf(stderr, "Reading a new var should return EOF\n");
+		close(fd);
 		return EXIT_FAILURE;
 	}
 
+	close(fd);
 	return EXIT_SUCCESS;
 }
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 3b0454e7fc82..dd9f9db70af4 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -91,9 +91,6 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	if (!validate_resctrl_feature_request(CMT_STR))
-		return -1;
-
 	ret = get_cbm_mask("L3", cbm_mask);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 97dc98c0c949..ff8b588b63ed 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -12,7 +12,7 @@
 
 #define RESULT_FILE_NAME	"result_mba"
 #define NUM_OF_RUNS		5
-#define MAX_DIFF_PERCENT	5
+#define MAX_DIFF_PERCENT	8
 #define ALLOCATION_MAX		100
 #define ALLOCATION_MIN		10
 #define ALLOCATION_STEP		10
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 280187628054..5dc1dce89733 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -11,7 +11,7 @@
 #include "resctrl.h"
 
 #define RESULT_FILE_NAME	"result_mbm"
-#define MAX_DIFF_PERCENT	5
+#define MAX_DIFF_PERCENT	8
 #define NUM_OF_RUNS		5
 
 static int
