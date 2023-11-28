Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7447FC1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbjK1RVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjK1RVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:21:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F810CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:21:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05155C433C7;
        Tue, 28 Nov 2023 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701192091;
        bh=akxBg6uo8IL1IRzqnlb4XHbckpmts6IZg5j5O5ZI7uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdIMtkjU840YgJj4YSoUtcFnBEWl9QqrFg+9Sti3Rb6wNsizbMqsaqh7MlfisGvb+
         W8lCOpW8LnXfeZP3GAxeJyiVjf93uKeAvcs58u08sySD33zJndcAWm6e2Qk5F56B2J
         vsHqrvK/XKVlgwGyEf9EqHioXdG4zFTnMivWdyRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.202
Date:   Tue, 28 Nov 2023 17:21:22 +0000
Message-ID: <2023112821-snowstorm-chaplain-ddaa@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023112821-zoologist-wavy-3123@gregkh>
References: <2023112821-zoologist-wavy-3123@gregkh>
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
index 7ef22771de76..ed0e42c99c90 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 201
+SUBLEVEL = 202
 EXTRAVERSION =
 NAME = Dare mighty things
 
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
index 34bd4cba81e6..13cf137da999 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -986,6 +986,8 @@ choice
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
 	depends on !LD_IS_LLD || LLD_VERSION >= 130000
+	# https://github.com/llvm/llvm-project/commit/1379b150991f70a5782e9a143c2ba5308da1161c
+	depends on AS_IS_GNU || AS_VERSION >= 150000
 	help
 	  Say Y if you plan on running a kernel with a big-endian userspace.
 
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 2a1f03cdb52c..367720910677 100644
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
@@ -242,9 +236,10 @@ gcc: gcc@1800000 {
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
 
 		tcsr_q6: syscon@1945000 {
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
index 05bed27eef85..25bef679290f 100644
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
index 6e3e50614353..1dc98e2fce2e 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1289,8 +1289,7 @@ static void power_pmu_disable(struct pmu *pmu)
 		/*
 		 * Disable instruction sampling if it was enabled
 		 */
-		if (cpuhw->mmcr.mmcra & MMCRA_SAMPLE_ENABLE)
-			val &= ~MMCRA_SAMPLE_ENABLE;
+		val &= ~MMCRA_SAMPLE_ENABLE;
 
 		/* Disable BHRB via mmcra (BHRBRD) for p10 */
 		if (ppmu->flags & PPMU_ARCH_31)
@@ -1301,7 +1300,7 @@ static void power_pmu_disable(struct pmu *pmu)
 		 * instruction sampling or BHRB.
 		 */
 		if (val != mmcra) {
-			mtspr(SPRN_MMCRA, mmcra);
+			mtspr(SPRN_MMCRA, val);
 			mb();
 			isync();
 		}
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 8465fc8ffd99..7d7a3cbb8e01 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -505,6 +505,7 @@
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
index 205fa420ee7c..3f5c00b15e2c 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -89,8 +89,12 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
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
index e03e320847cd..20eb8f55e1f1 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -674,10 +674,12 @@ static int stimer_set_count(struct kvm_vcpu_hv_stimer *stimer, u64 count,
 
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
index c2899ff31a06..13e4699a0744 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3132,6 +3132,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 		break;
 
@@ -3485,6 +3486,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 	/*
 	 * Intel Sandy Bridge CPUs must support the RAPL (running average power
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 9dc31996c7ed..62a119170376 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -602,13 +602,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
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
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index bfd821173f86..ba70bcded128 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -442,6 +442,18 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
 		},
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
 		.ident = "Asus ExpertBook B2502",
 		.matches = {
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index a59554e5b8b0..cc90f550ab75 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2290,19 +2290,21 @@ static int get_esi(struct atm_dev *dev)
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
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f99d19077020..a1a8b282b99b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -415,6 +415,18 @@ static const struct usb_device_id blacklist_table[] = {
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
@@ -3095,6 +3107,9 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
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
 
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 787dbebbb432..5ea1efd87f58 100644
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
index 6cd5c8ab5d49..ab856dd2d5fc 100644
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
index 3e57176ca0ca..40b052c6733a 100644
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
index 96086e7df910..3e3e37e0e660 100644
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
index 00a190929b55..48df32dd352e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -575,6 +575,9 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_rreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
@@ -634,6 +637,9 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_wreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f0db9724ca85..a093f1b27724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4530,7 +4530,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * Flush RAM to disk so that after reboot
 	 * the user can read log and see why the system rebooted.
 	 */
-	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
+	if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
+		amdgpu_ras_get_context(adev)->reboot) {
 		DRM_WARN("Emergency reboot.");
 
 		ksys_sync_helper();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3638f0e12a2b..a8f1c4969fac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1031,7 +1031,8 @@ static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	sysfs_remove_file_from_group(&adev->dev->kobj,
+	if (adev->dev->kobj.sd)
+		sysfs_remove_file_from_group(&adev->dev->kobj,
 				&con->badpages_attr.attr,
 				RAS_FS_NAME);
 }
@@ -1048,7 +1049,8 @@ static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
 		.attrs = attrs,
 	};
 
-	sysfs_remove_group(&adev->dev->kobj, &group);
+	if (adev->dev->kobj.sd)
+		sysfs_remove_group(&adev->dev->kobj, &group);
 
 	return 0;
 }
@@ -1096,7 +1098,8 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 	if (!obj || !obj->attr_inuse)
 		return -EINVAL;
 
-	sysfs_remove_file_from_group(&adev->dev->kobj,
+	if (adev->dev->kobj.sd)
+		sysfs_remove_file_from_group(&adev->dev->kobj,
 				&obj->sysfs_attr.attr,
 				RAS_FS_NAME);
 	obj->attr_inuse = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 652ddec18838..54d6b4128721 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1293,7 +1293,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	struct dmub_srv_create_params create_params;
 	struct dmub_srv_region_params region_params;
 	struct dmub_srv_region_info region_info;
-	struct dmub_srv_fb_params fb_params;
+	struct dmub_srv_memory_params memory_params;
 	struct dmub_srv_fb_info *fb_info;
 	struct dmub_srv *dmub_srv;
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -1389,6 +1389,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		adev->dm.dmub_fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 		PSP_HEADER_BYTES;
+	region_params.is_mailbox_in_inbox = false;
 
 	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
 					   &region_info);
@@ -1410,10 +1411,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
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
@@ -1425,7 +1426,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -ENOMEM;
 	}
 
-	status = dmub_srv_calc_fb_info(dmub_srv, &fb_params, fb_info);
+	status = dmub_srv_calc_mem_info(dmub_srv, &memory_params, fb_info);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error calculating DMUB FB info: %d\n", status);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index d48fd87d3b95..8206c6edba74 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -534,7 +534,7 @@ uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		return tg->funcs->get_frame_count(tg);
@@ -593,7 +593,7 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		tg->funcs->get_scanoutpos(tg,
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 882b4e2816b5..733e41b81a4e 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -152,6 +152,7 @@ struct dmub_srv_region_params {
 	uint32_t vbios_size;
 	const uint8_t *fw_inst_const;
 	const uint8_t *fw_bss_data;
+	bool is_mailbox_in_inbox;
 };
 
 /**
@@ -171,20 +172,25 @@ struct dmub_srv_region_params {
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
@@ -398,8 +404,8 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
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
index 08da423b24a1..56c671d21dc8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -250,7 +250,7 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	uint32_t fw_state_size = DMUB_FW_STATE_SIZE;
 	uint32_t trace_buffer_size = DMUB_TRACE_BUFFER_SIZE;
 	uint32_t scratch_mem_size = DMUB_SCRATCH_MEM_SIZE;
-
+	uint32_t previous_top = 0;
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
 
@@ -275,8 +275,15 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
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
 
@@ -295,7 +302,7 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 			dmub->fw_version = fw_info->fw_version;
 	}
 
-	trace_buff->base = dmub_align(mail->top, 256);
+	trace_buff->base = dmub_align(previous_top, 256);
 	trace_buff->top = trace_buff->base + dmub_align(trace_buffer_size, 64);
 
 	fw_state->base = dmub_align(trace_buff->top, 256);
@@ -306,11 +313,14 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 
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
@@ -325,8 +335,8 @@ enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
 	if (params->region_info->num_regions != DMUB_NUM_WINDOWS)
 		return DMUB_STATUS_INVALID;
 
-	cpu_base = (uint8_t *)params->cpu_addr;
-	gpu_base = params->gpu_addr;
+	cpu_base = (uint8_t *)params->cpu_fb_addr;
+	gpu_base = params->gpu_fb_addr;
 
 	for (i = 0; i < DMUB_NUM_WINDOWS; ++i) {
 		const struct dmub_region *reg =
@@ -334,6 +344,12 @@ enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
 
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
index d58a59cf4f85..fb1aaf959e7c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -776,7 +776,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 
-	if (count > 127)
+	if (count > 127 || count == 0)
 		return -EINVAL;
 
 	if (*buf == 's')
@@ -792,7 +792,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	else
 		return -EINVAL;
 
-	memcpy(buf_cpy, buf, count+1);
+	memcpy(buf_cpy, buf, count);
+	buf_cpy[count] = 0;
 
 	tmp_str = buf_cpy;
 
@@ -807,6 +808,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 			return -EINVAL;
 		parameter_size++;
 
+		if (!tmp_str)
+			break;
+
 		while (isspace(*tmp_str))
 			tmp_str++;
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index 1e870f58dd12..0c61e2bc14cd 100644
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
index c3cdf283ecef..1e922703e26b 100644
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
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 4e8a19114e87..93a2ee0f772f 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -264,26 +264,9 @@ int dp_panel_get_modes(struct dp_panel *dp_panel,
 
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
index c22e7c49e077..67e1da0a7db5 100644
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
index d57ed75a977c..494cec50a682 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -378,6 +378,8 @@ static int tpg110_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = tpg->panel_mode->bus_flags;
 
 	mode = drm_mode_duplicate(connector->dev, &tpg->panel_mode->mode);
+	if (!mode)
+		return -ENOMEM;
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6712d99ad80d..7c688d7f8ccf 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -345,6 +345,7 @@
 
 #define USB_VENDOR_ID_DELL				0x413c
 #define USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE	0x301a
+#define USB_DEVICE_ID_DELL_PRO_WIRELESS_KM5221W		0x4503
 
 #define USB_VENDOR_ID_DELORME		0x1163
 #define USB_DEVICE_ID_DELORME_EARTHMATE	0x0100
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 0ff03fed9770..71f7b0d539df 100644
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
 
@@ -478,31 +483,48 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
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
index 4229e5de0674..787349f2de01 100644
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
index 106080b25e81..8a3d35cacdcb 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -362,10 +362,16 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 
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
@@ -401,6 +407,13 @@ i2c_dw_recv_len(struct dw_i2c_dev *dev, u8 len)
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
index 4aec451d7251..cb8f56022592 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -735,15 +735,11 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 		return i801_check_post(priv, status);
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
@@ -766,9 +762,12 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
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
 
diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 2f6f6468214d..4f7a4f5a1150 100644
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
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 3f2226928fe0..6b9df33ac561 100644
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
@@ -1622,13 +1622,13 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
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
diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 18d32f053d26..3aa0215fca41 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -45,6 +45,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -261,12 +262,6 @@ static u32 extract_speed(u16 linkstat)
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
@@ -279,7 +274,7 @@ static void update_lbus_info(struct hfi1_devdata *dd)
 		return;
 	}
 
-	dd->lbus_width = extract_width(linkstat);
+	dd->lbus_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);
 	dd->lbus_speed = extract_speed(linkstat);
 	snprintf(dd->lbus_info, sizeof(dd->lbus_info),
 		 "PCIe,%uMHz,x%u", dd->lbus_speed, dd->lbus_width);
diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 3c0809095a31..320e418cf753 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -90,6 +90,11 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 
 		temp = agg_peak[bucket] * bcm->vote_scale;
 		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
+
+		if (bcm->enable_mask && (bcm->vote_x[bucket] || bcm->vote_y[bucket])) {
+			bcm->vote_x[bucket] = 0;
+			bcm->vote_y[bucket] = bcm->enable_mask;
+		}
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index e5f61ab989e7..029a350c2884 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -81,6 +81,7 @@ struct qcom_icc_node {
  * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
  * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
  * @vote_scale: scaling factor for vote_x and vote_y
+ * @enable_mask: optional mask to send as vote instead of vote_x/vote_y
  * @dirty: flag used to indicate whether the bcm needs to be committed
  * @keepalive: flag used to indicate whether a keepalive is required
  * @aux_data: auxiliary data used when calculating threshold values and
@@ -97,6 +98,7 @@ struct qcom_icc_bcm {
 	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
 	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
 	u64 vote_scale;
+	u32 enable_mask;
 	bool dirty;
 	bool keepalive;
 	struct bcm_db aux_data;
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 806a3d9da12f..2ca69184ca1a 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -248,6 +248,7 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev)
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
diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index 1bd8bbe57a30..1f230b14cbfd 100644
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
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index b7d2293a5004..a9fee4a2e214 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1282,7 +1282,7 @@ static int vfe_get(struct vfe_device *vfe)
 	} else {
 		ret = vfe_check_clock_rates(vfe);
 		if (ret < 0)
-			goto error_pm_runtime_get;
+			goto error_pm_domain;
 	}
 	vfe->power_count++;
 
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 06a1908ca225..1d9b743062f1 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -351,7 +351,7 @@ session_get_prop_buf_req(struct hfi_msg_session_property_info_pkt *pkt,
 		memcpy(&bufreq[idx], buf_req, sizeof(*bufreq));
 		idx++;
 
-		if (idx > HFI_BUFFER_TYPE_MAX)
+		if (idx >= HFI_BUFFER_TYPE_MAX)
 			return HFI_ERR_SESSION_INVALID_PARAMETER;
 
 		req_bytes -= sizeof(struct hfi_buffer_requirements);
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 2dcf7eaea4ce..e13e555b3515 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -19,6 +19,9 @@ static void init_codecs(struct venus_core *core)
 	struct venus_caps *caps = core->caps, *cap;
 	unsigned long bit;
 
+	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
+		return;
+
 	for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
 		cap = &caps[core->codecs_count++];
 		cap->codec = BIT(bit);
@@ -86,6 +89,9 @@ static void fill_profile_level(struct venus_caps *cap, const void *data,
 {
 	const struct hfi_profile_level *pl = data;
 
+	if (cap->num_pl + num >= HFI_MAX_PROFILE_COUNT)
+		return;
+
 	memcpy(&cap->pl[cap->num_pl], pl, num * sizeof(*pl));
 	cap->num_pl += num;
 }
@@ -111,6 +117,9 @@ fill_caps(struct venus_caps *cap, const void *data, unsigned int num)
 {
 	const struct hfi_capability *caps = data;
 
+	if (cap->num_caps + num >= MAX_CAP_ENTRIES)
+		return;
+
 	memcpy(&cap->caps[cap->num_caps], caps, num * sizeof(*caps));
 	cap->num_caps += num;
 }
@@ -137,6 +146,9 @@ static void fill_raw_fmts(struct venus_caps *cap, const void *fmts,
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
index 9d939f63d16f..8b1375c97c81 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -206,6 +206,11 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 
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
@@ -273,6 +278,11 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
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
index 98a38755c694..253a1d1a840a 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -2430,6 +2430,12 @@ static int imon_probe(struct usb_interface *interface,
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
index 220363b9a868..9c888047fa99 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -286,7 +286,11 @@ static ssize_t lirc_transmit(struct file *file, const char __user *buf,
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
index d93d384286c1..de945e13c7c6 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -18,6 +18,7 @@
 
 #include <linux/input.h>
 #include <linux/sched/signal.h>
+#include <linux/bitops.h>
 
 #include "gspca.h"
 
@@ -1027,6 +1028,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
 			sd->params.exposure.expMode = 2;
 			sd->exposure_status = EXPOSURE_NORMAL;
 		}
+		if (sd->params.exposure.gain >= BITS_PER_TYPE(currentexp))
+			return -EINVAL;
 		currentexp = currentexp << sd->params.exposure.gain;
 		sd->params.exposure.gain = 0;
 		/* round down current exposure to nearest value */
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 6c4c85eb7147..b4a07a166605 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -79,6 +79,7 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774B1		0x002b
 #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
+#define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
 
 static DEFINE_IDA(pci_endpoint_test_ida);
 
@@ -993,6 +994,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
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
index 1992eea8b777..78c9a56b051d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -800,7 +800,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
 	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
-	cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
 
 	meson_mmc_set_response_bits(cmd, &cmd_cfg);
 
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8e52905458f9..eb52e0c5a020 100644
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
index 42001c49833b..a45a27c70c87 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -420,9 +420,25 @@ read_pri_intelext(struct map_info *map, __u16 adr)
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
index bcb019121d83..50fabba04248 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1433,6 +1433,10 @@ static void bond_compute_features(struct bonding *bond)
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
+	bool was_up = !!(bond_dev->flags & IFF_UP);
+
+	dev_close(bond_dev);
+
 	bond_dev->header_ops	    = slave_dev->header_ops;
 
 	bond_dev->type		    = slave_dev->type;
@@ -1447,6 +1451,8 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
 		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
 	}
+	if (was_up)
+		dev_open(bond_dev, NULL);
 }
 
 /* On bonding slaves other than the currently active slave, suppress
diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdio.c
index 9cbe80460b53..a5787dc370eb 100644
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
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 85ea073b742f..c78587ddb32f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -433,8 +433,8 @@ static const struct gmac_max_framelen gmac_maxlens[] = {
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
@@ -1146,6 +1146,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1160,9 +1161,30 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
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
@@ -1979,15 +2001,6 @@ static int gmac_change_mtu(struct net_device *netdev, int new_mtu)
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
@@ -2205,7 +2218,6 @@ static const struct net_device_ops gmac_351x_ops = {
 	.ndo_set_mac_address	= gmac_set_mac_address,
 	.ndo_get_stats64	= gmac_get_stats64,
 	.ndo_change_mtu		= gmac_change_mtu,
-	.ndo_fix_features	= gmac_fix_features,
 	.ndo_set_features	= gmac_set_features,
 };
 
@@ -2463,11 +2475,12 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
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
 	netif_napi_add(netdev, &port->napi, gmac_napi_poll,
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
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index ae7cd73c823b..4df5e91e86ce 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3974,7 +3974,7 @@ static int hns3_init_mac_addr(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = priv->ae_handle;
-	u8 mac_addr_temp[ETH_ALEN];
+	u8 mac_addr_temp[ETH_ALEN] = {0};
 	int ret = 0;
 
 	if (h->ae_algo->ops->get_mac_addr)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 7d05915c35e3..2bb0ce1761fb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2363,8 +2363,18 @@ static enum hclgevf_evt_cause hclgevf_check_evt_cause(struct hclgevf_dev *hdev,
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
@@ -2376,7 +2386,8 @@ static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 
 	switch (event_cause) {
 	case HCLGEVF_VECTOR0_EVENT_RST:
-		hclgevf_reset_task_schedule(hdev);
+		mod_timer(&hdev->reset_timer,
+			  jiffies + msecs_to_jiffies(HCLGEVF_RESET_DELAY));
 		break;
 	case HCLGEVF_VECTOR0_EVENT_MBX:
 		hclgevf_mbx_handler(hdev);
@@ -3269,6 +3280,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		 HCLGEVF_DRIVER_NAME);
 
 	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
+	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index c9b0fa5e8589..9469af8c49ac 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -274,6 +274,7 @@ struct hclgevf_dev {
 	enum hnae3_reset_type reset_level;
 	unsigned long reset_pending;
 	enum hnae3_reset_type reset_type;
+	struct timer_list reset_timer;
 
 #define HCLGEVF_RESET_REQUESTED		0
 #define HCLGEVF_RESET_PENDING		1
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 0e699330ae77..060561f63311 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -52,7 +52,7 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	u32 running_fw, stored_fw;
 	int err;
 
-	err = devlink_info_driver_name_put(req, DRIVER_NAME);
+	err = devlink_info_driver_name_put(req, KBUILD_MODNAME);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 90930e54b6f2..05bcd69994ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -267,9 +267,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
-	e->encap_size = ipv4_encap_size;
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -286,6 +283,8 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
+	e->encap_size = ipv4_encap_size;
+	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	mlx5e_route_lookup_ipv4_put(route_dev, n);
@@ -431,9 +430,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
-	e->encap_size = ipv6_encap_size;
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -451,6 +447,8 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
+	e->encap_size = ipv6_encap_size;
+	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	mlx5e_route_lookup_ipv6_put(route_dev, n);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 6a1b1363ac16..d3817dd07e3d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -40,9 +40,7 @@ void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 
-	strlcpy(drvinfo->driver, DRIVER_NAME, sizeof(drvinfo->driver));
-	strlcpy(drvinfo->version, DRIVER_VERSION,
-		sizeof(drvinfo->version));
+	strlcpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
 	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 		 "%d.%d.%04d (%.16s)",
 		 fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_sub(mdev),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index b991f03c7e99..f9f1a79d6bdd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -61,14 +61,17 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
+	int count;
 
 	strlcpy(drvinfo->driver, mlx5e_rep_driver_name,
 		sizeof(drvinfo->driver));
-	strlcpy(drvinfo->version, UTS_RELEASE, sizeof(drvinfo->version));
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
 
 static void mlx5e_uplink_rep_get_drvinfo(struct net_device *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 2cf7f0fc170b..d7bda7650767 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -39,7 +39,7 @@ static void mlx5i_get_drvinfo(struct net_device *dev,
 	struct mlx5e_priv *priv = mlx5i_epriv(dev);
 
 	mlx5e_ethtool_get_drvinfo(priv, drvinfo);
-	strlcpy(drvinfo->driver, DRIVER_NAME "[ib_ipoib]",
+	strlcpy(drvinfo->driver, KBUILD_MODNAME "[ib_ipoib]",
 		sizeof(drvinfo->driver));
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 22907f6364f5..35e11cb883c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -77,7 +77,6 @@
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_VERSION(DRIVER_VERSION);
 
 unsigned int mlx5_core_debug_mask;
 module_param_named(debug_mask, mlx5_core_debug_mask, uint, 0644);
@@ -228,7 +227,7 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 	strncat(string, ",", remaining_size);
 
 	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, DRIVER_NAME, remaining_size);
+	strncat(string, KBUILD_MODNAME, remaining_size);
 
 	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
 	strncat(string, ",", remaining_size);
@@ -313,7 +312,7 @@ static int request_bar(struct pci_dev *pdev)
 		return -ENODEV;
 	}
 
-	err = pci_request_regions(pdev, DRIVER_NAME);
+	err = pci_request_regions(pdev, KBUILD_MODNAME);
 	if (err)
 		dev_err(&pdev->dev, "Couldn't get PCI resources, aborting\n");
 
@@ -1620,7 +1619,7 @@ void mlx5_recover_device(struct mlx5_core_dev *dev)
 }
 
 static struct pci_driver mlx5_core_driver = {
-	.name           = DRIVER_NAME,
+	.name           = KBUILD_MODNAME,
 	.id_table       = mlx5_core_pci_table,
 	.probe          = init_one,
 	.remove         = remove_one,
@@ -1646,6 +1645,9 @@ static int __init mlx5_init(void)
 {
 	int err;
 
+	WARN_ONCE(strcmp(MLX5_ADEV_NAME, KBUILD_MODNAME),
+		  "mlx5_core name not in sync with kernel module name");
+
 	get_random_bytes(&sw_owner_id, sizeof(sw_owner_id));
 
 	mlx5_core_verify_params();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 8cec85ab419d..b285f1515e4e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -42,9 +42,6 @@
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/driver.h>
 
-#define DRIVER_NAME "mlx5_core"
-#define DRIVER_VERSION "5.0-0"
-
 extern uint mlx5_core_debug_mask;
 
 #define mlx5_core_dbg(__dev, format, ...)				\
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6e0fe77d1019..ab6af1f1ad5b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2581,9 +2581,7 @@ static void rtl_set_rx_mode(struct net_device *dev)
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 83e9a4d019c1..59a07a01e80c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3858,10 +3858,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
index b5a61b16a7ea..bfea28bd4502 100644
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
index 5869bc2c3aa7..9c77e6ab2b30 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -765,7 +765,7 @@ static void macvlan_change_rx_flags(struct net_device *dev, int change)
 	if (dev->flags & IFF_UP) {
 		if (change & IFF_ALLMULTI)
 			dev_set_allmulti(lowerdev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
+		if (!macvlan_passthru(vlan->port) && change & IFF_PROMISC)
 			dev_set_promiscuity(lowerdev,
 					    dev->flags & IFF_PROMISC ? 1 : -1);
 
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 57b1b138522e..cbdd01f31162 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -838,6 +838,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
+		netif_carrier_off(pl->netdev);
 	} else if (config->type == PHYLINK_DEV) {
 		pl->dev = config->dev;
 	} else {
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index f774b7e52da4..717431636275 100644
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
index e8250a665433..ab737177a86b 100644
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
index 4870a3dab0de..f7ee1032b172 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -827,12 +827,20 @@ static void ath10k_snoc_hif_get_default_pipe(struct ath10k *ar,
 
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
@@ -1048,6 +1056,8 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 		goto err_free_rri;
 	}
 
+	ath10k_ce_enable_interrupts(ar);
+
 	return 0;
 
 err_free_rri:
@@ -1209,8 +1219,8 @@ static int ath10k_snoc_request_irq(struct ath10k *ar)
 
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
index 583bcf148403..a50325f4634b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1578,14 +1578,20 @@ static void ath11k_htt_pktlog(struct ath11k_base *ab, struct sk_buff *skb)
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
index 53846dc9a5c5..7c2d74533521 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6355,6 +6355,8 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 		   ev->detector_id, ev->segment_id, ev->timestamp, ev->is_chirp,
 		   ev->freq_offset, ev->sidx);
 
+	rcu_read_lock();
+
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
 
 	if (!ar) {
@@ -6372,6 +6374,8 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 		ieee80211_radar_detected(ar->hw);
 
 exit:
+	rcu_read_unlock();
+
 	kfree(tb);
 }
 
@@ -6401,15 +6405,19 @@ ath11k_wmi_pdev_temperature_event(struct ath11k_base *ab,
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
index 859a865c5995..8d98347e0ddf 100644
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
index d310337b1625..99150fec151b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -532,16 +532,20 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
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
index 0d41f172a1dc..037358606a51 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2543,7 +2543,7 @@ static void mac80211_hwsim_get_et_strings(struct ieee80211_hw *hw,
 					  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *mac80211_hwsim_gstrings_stats,
+		memcpy(data, mac80211_hwsim_gstrings_stats,
 		       sizeof(mac80211_hwsim_gstrings_stats));
 }
 
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 242683cde04a..3823e5881996 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -503,7 +503,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit exynos_pcie_remove(struct platform_device *pdev)
+static int exynos_pcie_remove(struct platform_device *pdev)
 {
 	struct exynos_pcie *ep = platform_get_drvdata(pdev);
 
@@ -522,7 +522,7 @@ static const struct of_device_id exynos_pcie_of_match[] = {
 };
 
 static struct platform_driver exynos_pcie_driver = {
-	.remove		= __exit_p(exynos_pcie_remove),
+	.remove		= exynos_pcie_remove,
 	.driver = {
 		.name	= "exynos-pcie",
 		.of_match_table = exynos_pcie_of_match,
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 90482d5246ff..5b722287aac9 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1142,7 +1142,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
-static int __init ks_pcie_probe(struct platform_device *pdev)
+static int ks_pcie_probe(struct platform_device *pdev)
 {
 	const struct dw_pcie_host_ops *host_ops;
 	const struct dw_pcie_ep_ops *ep_ops;
@@ -1338,7 +1338,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static int ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
@@ -1354,9 +1354,9 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
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
index a215777df96c..80c2015b49d8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -7,6 +7,7 @@
  * Author: Vidya Sagar <vidyas@nvidia.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -346,8 +347,7 @@ static void apply_bad_link_workaround(struct pcie_port *pp)
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
@@ -885,7 +884,7 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 	/* Configure Max lane width from DT */
 	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_MLW;
-	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
+	val |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, pcie->num_lanes);
 	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
 
 	config_gen3_gen4_eq_presets(pcie);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 745a4e0c4994..bda45c524187 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -909,7 +909,7 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state, d_max;
 
-	if (pdev->no_d3cold)
+	if (pdev->no_d3cold || !pdev->d3cold_allowed)
 		d_max = ACPI_STATE_D3_HOT;
 	else
 		d_max = ACPI_STATE_D3_COLD;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 361de072dfdc..e14c83f59b48 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -500,10 +500,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 		return -EINVAL;
 
 	pdev->d3cold_allowed = !!val;
-	if (pdev->d3cold_allowed)
-		pci_d3cold_enable(pdev);
-	else
-		pci_d3cold_disable(pdev);
+	pci_bridge_d3_update(pdev);
 
 	pm_runtime_resume(dev);
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ef6f0ceb92f9..8ab8abd79e89 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1250,6 +1250,8 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 			link->aspm_disable &= ~ASPM_STATE_L1;
 	} else {
 		link->aspm_disable |= state;
+		if (state & ASPM_STATE_L1)
+			link->aspm_disable |= ASPM_STATE_L1SS;
 	}
 
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d8d241344d22..00ca996b4d4b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9718,6 +9718,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
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
index 21c4c34c52d8..ed766943a356 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -55,10 +55,11 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
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
index 6b97155148f1..d2cb95670676 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -55,9 +55,13 @@ struct ptp_clock {
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
index 8cd59e848163..8d52815e05b3 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -78,7 +78,8 @@ static ssize_t extts_fifo_show(struct device *dev,
 	qcnt = queue_cnt(queue);
 	if (qcnt) {
 		event = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 	spin_unlock_irqrestore(&queue->lock, flags);
 
diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index abb14b206be0..82b8477c7d73 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -238,6 +238,12 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
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
index ec9a19d94855..365279d7c982 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -248,13 +248,13 @@ u32 megasas_readl(struct megasas_instance *instance,
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
index 3728e4cf6e05..814ac2523805 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -216,8 +216,8 @@ _base_readl_ext_retry(const volatile void __iomem *addr)
 
 	for (i = 0 ; i < 30 ; i++) {
 		ret_val = readl(addr);
-		if (ret_val == 0)
-			continue;
+		if (ret_val != 0)
+			break;
 	}
 
 	return ret_val;
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 6f387a4fd96a..cf0fb650a924 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -363,18 +363,21 @@ void xen_console_resume(void)
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
@@ -538,10 +541,23 @@ static void xencons_backend_changed(struct xenbus_device *dev,
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
@@ -572,7 +588,7 @@ static int __init xen_hvc_init(void)
 		ops = &dom0_hvc_ops;
 		r = xen_initial_domain_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 		info = vtermno_to_xencons(HVC_COOKIE);
 	} else {
 		ops = &domU_hvc_ops;
@@ -581,7 +597,7 @@ static int __init xen_hvc_init(void)
 		else
 			r = xen_pv_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 
 		info = vtermno_to_xencons(HVC_COOKIE);
 		info->irq = bind_evtchn_to_irq_lateeoi(info->evtchn);
@@ -600,12 +616,13 @@ static int __init xen_hvc_init(void)
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
index 91b7359b79a2..bb66a3f06626 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -370,10 +370,14 @@ static void meson_uart_set_termios(struct uart_port *port,
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
 
@@ -726,15 +730,19 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
 
 static int meson_uart_probe(struct platform_device *pdev)
 {
-	struct resource *res_mem, *res_irq;
+	struct resource *res_mem;
 	struct uart_port *port;
+	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
-	int id = -1;
+	int irq;
+	bool has_rtscts;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
 
 	if (pdev->id < 0) {
+		int id;
+
 		for (id = AML_UART_PORT_OFFSET; id < AML_UART_PORT_NUM; id++) {
 			if (!meson_ports[id]) {
 				pdev->id = id;
@@ -750,9 +758,12 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!res_mem)
 		return -ENODEV;
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_irq)
-		return -ENODEV;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
 
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
@@ -775,15 +786,17 @@ static int meson_uart_probe(struct platform_device *pdev)
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
 	port->type = PORT_MESON;
 	port->x_char = 0;
 	port->ops = &meson_uart_ops;
-	port->fifosize = 64;
+	port->fifosize = fifosize;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 7ca209d4e088..ad08eddc1532 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -262,13 +262,14 @@ static void sysrq_handle_showallcpus(int key)
 		if (in_irq())
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
index 9ffd42e333b8..6b2d35ac6e3b 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -587,18 +587,22 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
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
 
@@ -632,6 +636,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto unreg_tty;
 	}
 	port->domain = kstrdup(domain, GFP_KERNEL);
+	if (!port->domain) {
+		rv = -ENOMEM;
+		goto unreg_tty;
+	}
+
 
 	mdesc_release(hp);
 
@@ -661,8 +670,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
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
index 00aea45a04e9..d42cd1d036bd 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1435,7 +1435,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_composite_dev *cdev = c->cdev;
 	struct f_ncm		*ncm = func_to_ncm(f);
 	struct usb_string	*us;
-	int			status;
+	int			status = 0;
 	struct usb_ep		*ep;
 	struct f_ncm_opts	*ncm_opts;
 
@@ -1453,22 +1453,17 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
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
index 7d0c2cccbfc0..0933a94ebe29 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -505,7 +505,9 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
 	pm_runtime_put_noidle(&dev->dev);
 
-	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
+	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
+		pm_runtime_forbid(&dev->dev);
+	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
 
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 5ee095a5d38a..eb70f07e3623 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -868,6 +868,58 @@ static void xhci_handle_halted_endpoint(struct xhci_hcd *xhci,
 	xhci_ring_cmd_db(xhci);
 }
 
+/*
+ * Fix up the ep ring first, so HW stops executing cancelled TDs.
+ * We have the xHCI lock, so nothing can modify this list until we drop it.
+ * We're also in the event handler, so we can't get re-interrupted if another
+ * Stop Endpoint command completes.
+ */
+
+static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep,
+					 struct xhci_dequeue_state *deq_state)
+{
+	struct xhci_hcd		*xhci;
+	struct xhci_td		*td = NULL;
+	struct xhci_td		*tmp_td = NULL;
+	struct xhci_ring	*ring;
+	u64			hw_deq;
+
+	xhci = ep->xhci;
+
+	list_for_each_entry_safe(td, tmp_td, &ep->cancelled_td_list, cancelled_td_list) {
+		xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
+				"Removing canceled TD starting at 0x%llx (dma).",
+				(unsigned long long)xhci_trb_virt_to_dma(
+					td->start_seg, td->first_trb));
+		list_del_init(&td->td_list);
+		ring = xhci_urb_to_transfer_ring(xhci, td->urb);
+		if (!ring) {
+			xhci_warn(xhci, "WARN Cancelled URB %p has invalid stream ID %u.\n",
+				  td->urb, td->urb->stream_id);
+			continue;
+		}
+		/*
+		 * If ring stopped on the TD we need to cancel, then we have to
+		 * move the xHC endpoint ring dequeue pointer past this TD.
+		 */
+		hw_deq = xhci_get_hw_deq(xhci, ep->vdev, ep->ep_index,
+					 td->urb->stream_id);
+		hw_deq &= ~0xf;
+
+		if (trb_in_td(xhci, td->start_seg, td->first_trb,
+			      td->last_trb, hw_deq, false)) {
+			xhci_find_new_dequeue_state(xhci, ep->vdev->slot_id,
+						    ep->ep_index,
+						    td->urb->stream_id,
+						    td, deq_state);
+		} else {
+			td_to_noop(xhci, ring, td, false);
+		}
+
+	}
+	return 0;
+}
+
 /*
  * When we get a command completion for a Stop Endpoint Command, we need to
  * unlink any cancelled TDs from the ring.  There are two ways to do that:
@@ -888,7 +940,6 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 	struct xhci_td *last_unlinked_td;
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_virt_device *vdev;
-	u64 hw_deq;
 	struct xhci_dequeue_state deq_state;
 
 	if (unlikely(TRB_TO_SUSPEND_PORT(le32_to_cpu(trb->generic.field[3])))) {
@@ -919,60 +970,7 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 		return;
 	}
 
-	/* Fix up the ep ring first, so HW stops executing cancelled TDs.
-	 * We have the xHCI lock, so nothing can modify this list until we drop
-	 * it.  We're also in the event handler, so we can't get re-interrupted
-	 * if another Stop Endpoint command completes
-	 */
-	list_for_each_entry(cur_td, &ep->cancelled_td_list, cancelled_td_list) {
-		xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
-				"Removing canceled TD starting at 0x%llx (dma).",
-				(unsigned long long)xhci_trb_virt_to_dma(
-					cur_td->start_seg, cur_td->first_trb));
-		ep_ring = xhci_urb_to_transfer_ring(xhci, cur_td->urb);
-		if (!ep_ring) {
-			/* This shouldn't happen unless a driver is mucking
-			 * with the stream ID after submission.  This will
-			 * leave the TD on the hardware ring, and the hardware
-			 * will try to execute it, and may access a buffer
-			 * that has already been freed.  In the best case, the
-			 * hardware will execute it, and the event handler will
-			 * ignore the completion event for that TD, since it was
-			 * removed from the td_list for that endpoint.  In
-			 * short, don't muck with the stream ID after
-			 * submission.
-			 */
-			xhci_warn(xhci, "WARN Cancelled URB %p "
-					"has invalid stream ID %u.\n",
-					cur_td->urb,
-					cur_td->urb->stream_id);
-			goto remove_finished_td;
-		}
-		/*
-		 * If we stopped on the TD we need to cancel, then we have to
-		 * move the xHC endpoint ring dequeue pointer past this TD.
-		 */
-		hw_deq = xhci_get_hw_deq(xhci, vdev, ep_index,
-					 cur_td->urb->stream_id);
-		hw_deq &= ~0xf;
-
-		if (trb_in_td(xhci, cur_td->start_seg, cur_td->first_trb,
-			      cur_td->last_trb, hw_deq, false)) {
-			xhci_find_new_dequeue_state(xhci, slot_id, ep_index,
-						    cur_td->urb->stream_id,
-						    cur_td, &deq_state);
-		} else {
-			td_to_noop(xhci, ep_ring, cur_td, false);
-		}
-
-remove_finished_td:
-		/*
-		 * The event handler won't see a completion for this TD anymore,
-		 * so remove it from the endpoint ring's TD list.  Keep it in
-		 * the cancelled TD list for URB completion later.
-		 */
-		list_del_init(&cur_td->td_list);
-	}
+	xhci_invalidate_cancelled_tds(ep, &deq_state);
 
 	xhci_stop_watchdog_timer_in_irq(xhci, ep);
 
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 52891546e697..24e39984914f 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -551,7 +551,9 @@ static void lateeoi_list_add(struct irq_info *info)
 
 	spin_lock_irqsave(&eoi->eoi_list_lock, flags);
 
-	if (list_empty(&eoi->eoi_list)) {
+	elem = list_first_entry_or_null(&eoi->eoi_list, struct irq_info,
+					eoi_list);
+	if (!elem || info->eoi_time < elem->eoi_time) {
 		list_add(&info->eoi_list, &eoi->eoi_list);
 		mod_delayed_work_on(info->eoi_cpu, system_wq,
 				    &eoi->delayed, delay);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index bacee09b7bfd..45b2a5ecd63a 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -307,9 +307,6 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	} else {
 		if (current->journal_info)
 			flush = BTRFS_RESERVE_FLUSH_LIMIT;
-
-		if (btrfs_transaction_in_commit(fs_info))
-			schedule_timeout(1);
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 7b9b876b513b..4f9d08ac9dde 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -76,8 +76,8 @@ struct key_type cifs_spnego_key_type = {
  * strlen(";sec=ntlmsspi") */
 #define MAX_MECH_STR_LEN	13
 
-/* strlen of "host=" */
-#define HOST_KEY_LEN		5
+/* strlen of ";host=" */
+#define HOST_KEY_LEN		6
 
 /* strlen of ";ip4=" or ";ip6=" */
 #define IP_KEY_LEN		5
diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index e6fa76ab70be..d659eb70df76 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -433,6 +433,8 @@ generate_smb3signingkey(struct cifs_ses *ses,
 				  ptriplet->encryption.context,
 				  ses->smb3encryptionkey,
 				  SMB3_ENC_DEC_KEY_SIZE);
+		if (rc)
+			return rc;
 		rc = generate_key(ses, ptriplet->decryption.label,
 				  ptriplet->decryption.context,
 				  ses->smb3decryptionkey,
@@ -441,9 +443,6 @@ generate_smb3signingkey(struct cifs_ses *ses,
 			return rc;
 	}
 
-	if (rc)
-		return rc;
-
 #ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
 	cifs_dbg(VFS, "%s: dumping generated AES session keys\n", __func__);
 	/*
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index bd00afc5e4c1..d62d961e278d 100644
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
 		ret = exfat_alloc_cluster(inode, 1, &clu);
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
@@ -890,6 +901,9 @@ static int exfat_check_dir_empty(struct super_block *sb,
 
 	dentries_per_clu = sbi->dentries_per_clu;
 
+	if (p_dir->dir == EXFAT_EOF_CLUSTER)
+		return 0;
+
 	exfat_chain_dup(&clu, p_dir);
 
 	while (clu.dir != EXFAT_EOF_CLUSTER) {
@@ -1296,7 +1310,8 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		}
 
 		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
-		if (new_entry_type == TYPE_DIR) {
+		if (new_entry_type == TYPE_DIR &&
+		    new_ei->start_clu != EXFAT_EOF_CLUSTER) {
 			/* new_ei, new_clu_to_free */
 			struct exfat_chain new_clu_to_free;
 
diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 9b63f5416a2f..7f3b25b3fa6d 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -67,6 +67,11 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
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
index 51cebc1990eb..9b4199a1e039 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -554,13 +554,8 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
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
@@ -1543,6 +1538,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int gdb_num_end = ((group + flex_gd->count - 1) /
 				   EXT4_DESC_PER_BLOCK(sb));
 		int meta_bg = ext4_has_feature_meta_bg(sb);
+		sector_t padding_blocks = meta_bg ? 0 : sbi->s_sbh->b_blocknr -
+					 ext4_group_first_block_no(sb, 0);
 		sector_t old_gdb = 0;
 
 		update_backups(sb, ext4_group_first_block_no(sb, 0),
@@ -1554,8 +1551,8 @@ static int ext4_flex_group_add(struct super_block *sb,
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
@@ -1916,9 +1913,7 @@ static int ext4_convert_meta_bg(struct super_block *sb, struct inode *inode)
 
 errout:
 	ret = ext4_journal_stop(handle);
-	if (!err)
-		err = ret;
-	return ret;
+	return err ? err : ret;
 
 invalid_resize_inode:
 	ext4_error(sb, "corrupted/inconsistent resize inode");
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1be9de40f0b5..a94e102d1586 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1574,7 +1574,7 @@ void f2fs_decompress_end_io(struct page **rpages,
 int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
-	char slab_name[32];
+	char slab_name[35];
 
 	sprintf(slab_name, "f2fs_page_array_entry-%u:%u", MAJOR(dev), MINOR(dev));
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 74a6b0800e05..d75d56d9ea0c 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1835,16 +1835,24 @@ static const char *gfs2_get_link(struct dentry *dentry,
 
 int gfs2_permission(struct inode *inode, int mask)
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
index ad953ecb5853..8c226aa28633 100644
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
index b61de8dab51a..8cf4ef61cdc4 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1471,7 +1471,7 @@ static void gfs2_evict_inode(struct inode *inode)
 		wait_on_bit_io(&ip->i_flags, GIF_GLOP_PENDING, TASK_UNINTERRUPTIBLE);
 		gfs2_glock_add_to_lru(ip->i_gl);
 		gfs2_glock_put_eventually(ip->i_gl);
-		ip->i_gl = NULL;
+		rcu_assign_pointer(ip->i_gl, NULL);
 	}
 }
 
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1ae1697fe99b..3755a462d7c7 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -287,6 +287,8 @@ int jbd2_journal_recover(journal_t *journal)
 	journal_superblock_t *	sb;
 
 	struct recovery_info	info;
+	errseq_t		wb_err;
+	struct address_space	*mapping;
 
 	memset(&info, 0, sizeof(info));
 	sb = journal->j_superblock;
@@ -304,6 +306,9 @@ int jbd2_journal_recover(journal_t *journal)
 		return 0;
 	}
 
+	wb_err = 0;
+	mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	errseq_check_and_advance(&mapping->wb_err, &wb_err);
 	err = do_one_pass(journal, &info, PASS_SCAN);
 	if (!err)
 		err = do_one_pass(journal, &info, PASS_REVOKE);
@@ -322,6 +327,9 @@ int jbd2_journal_recover(journal_t *journal)
 
 	jbd2_journal_clear_revoke(journal);
 	err2 = sync_blockdev(journal->j_fs_dev);
+	if (!err)
+		err = err2;
+	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
 	if (!err)
 		err = err2;
 	/* Make sure all replayed data is on permanent storage */
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a9c078fc2302..72eb5ed54c2a 100644
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
@@ -2985,14 +2992,18 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
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
@@ -3013,6 +3024,8 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
 			/* sufficient free space found.  move to the next
 			 * level (or quit if this is the last level).
 			 */
+			if (x + n > max_size)
+				return -ENOSPC;
 			if (l2nb <= tp->dmt_stree[x + n])
 				break;
 		}
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 67c67604b8c8..14f918a4831d 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1322,7 +1322,7 @@ diInitInode(struct inode *ip, int iagno, int ino, int extno, struct iag * iagp)
 int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 {
 	int rc, ino, iagno, addext, extno, bitno, sword;
-	int nwords, rem, i, agno;
+	int nwords, rem, i, agno, dn_numag;
 	u32 mask, inosmap, extsmap;
 	struct inode *ipimap;
 	struct metapage *mp;
@@ -1358,6 +1358,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
+	if (agno < 0 || agno > dn_numag)
+		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
 		/*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1c2ed14bccef..f3f41027f697 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5508,7 +5508,7 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_WRITE];
 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
-	nfs4_state_protect_write(server->nfs_client, clnt, msg, hdr);
+	nfs4_state_protect_write(hdr->ds_clp ? hdr->ds_clp : server->nfs_client, clnt, msg, hdr);
 }
 
 static void nfs4_proc_commit_rpc_prepare(struct rpc_task *task, struct nfs_commit_data *data)
@@ -5549,7 +5549,8 @@ static void nfs4_proc_commit_setup(struct nfs_commit_data *data, struct rpc_mess
 	data->res.server = server;
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_COMMIT];
 	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, 0);
-	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
+	nfs4_state_protect(data->ds_clp ? data->ds_clp : server->nfs_client,
+			NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
 }
 
 static int _nfs4_proc_commit(struct file *dst, struct nfs_commitargs *args,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b045be7394a0..d402ca0b535f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2647,7 +2647,7 @@ static int client_opens_release(struct inode *inode, struct file *file)
 
 	/* XXX: alternatively, we could get/drop in seq start/stop */
 	drop_client(clp);
-	return 0;
+	return seq_release(inode, file);
 }
 
 static const struct file_operations client_states_fops = {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e0384095ca96..5d7df839902d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2028,7 +2028,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_xattr = ovl_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	sb->s_iflags |= SB_I_SKIP_SYNC;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 682f2bf2e525..aff9593feb73 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1767,7 +1767,6 @@ static const struct sysctl_alias sysctl_aliases[] = {
 	{"hung_task_panic",			"kernel.hung_task_panic" },
 	{"numa_zonelist_order",			"vm.numa_zonelist_order" },
 	{"softlockup_all_cpu_backtrace",	"kernel.softlockup_all_cpu_backtrace" },
-	{"softlockup_panic",			"kernel.softlockup_panic" },
 	{ }
 };
 
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fd2ca079448d..4bb4b4b79827 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2398,6 +2398,20 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
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
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index d13631a5e908..693ed9c614b6 100644
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
@@ -255,7 +255,7 @@ LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
+LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 4f95b98215d8..2cd89af4dbf6 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -56,6 +56,8 @@
 #include <linux/ptp_clock_kernel.h>
 #include <net/devlink.h>
 
+#define MLX5_ADEV_NAME "mlx5_core"
+
 enum {
 	MLX5_BOARD_ID_LEN = 64,
 };
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a13ff383fa1d..c0cf6613373f 100644
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
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 02e7a5863d28..41ed614e6920 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -79,6 +79,7 @@ struct rpc_clnt {
 		struct work_struct	cl_work;
 	};
 	const struct cred	*cl_cred;
+	struct super_block *pipefs_sb;
 };
 
 /*
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 6fb20722f49b..f7ed0471d5a8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -369,6 +369,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
 	EVENT_FILE_FL_PID_FILTER_BIT,
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
+	EVENT_FILE_FL_FREED_BIT,
 };
 
 extern struct trace_event_file *trace_get_event_file(const char *instance,
@@ -507,6 +508,7 @@ extern int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...);
  *  TRIGGER_COND  - When set, one or more triggers has an associated filter
  *  PID_FILTER    - When set, the event is filtered based on pid
  *  WAS_ENABLED   - Set when enabled to know to clear trace on module removal
+ *  FREED         - File descriptor is freed, all fields should be considered invalid
  */
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
@@ -520,6 +522,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
 	EVENT_FILE_FL_WAS_ENABLED	= (1 << EVENT_FILE_FL_WAS_ENABLED_BIT),
+	EVENT_FILE_FL_FREED		= (1 << EVENT_FILE_FL_FREED_BIT),
 };
 
 struct trace_event_file {
@@ -548,6 +551,7 @@ struct trace_event_file {
 	 * caching and such. Which is mostly OK ;-)
 	 */
 	unsigned long		flags;
+	atomic_t		ref;	/* ref count for opened files */
 	atomic_t		sm_ref;	/* soft-mode reference counter */
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 1d59a109417d..2237657514e1 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1479,13 +1479,10 @@ struct nft_trans_chain {
 
 struct nft_trans_table {
 	bool				update;
-	bool				enable;
 };
 
 #define nft_trans_table_update(trans)	\
 	(((struct nft_trans_table *)trans->data)->update)
-#define nft_trans_table_enable(trans)	\
-	(((struct nft_trans_table *)trans->data)->enable)
 
 struct nft_trans_elem {
 	struct nft_set			*set;
diff --git a/include/net/sock.h b/include/net/sock.h
index 234196d90423..87ee284ea9cb 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1853,21 +1853,33 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
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
 
@@ -2001,7 +2013,7 @@ static inline void __dst_negative_advice(struct sock *sk)
 		if (ndst != dst) {
 			rcu_assign_pointer(sk->sk_dst_cache, ndst);
 			sk_tx_queue_clear(sk);
-			sk->sk_dst_pending_confirm = 0;
+			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		}
 	}
 }
@@ -2018,7 +2030,7 @@ __sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = rcu_dereference_protected(sk->sk_dst_cache,
 					    lockdep_sock_is_held(sk));
 	rcu_assign_pointer(sk->sk_dst_cache, dst);
@@ -2031,7 +2043,7 @@ sk_dst_set(struct sock *sk, struct dst_entry *dst)
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
index 3b038c563ae1..e973044143bc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -977,6 +977,17 @@ struct snd_soc_card {
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
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 1d8dd58f83a5..163b7ec577e7 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -165,6 +165,7 @@ enum nft_hook_attributes {
 enum nft_table_flags {
 	NFT_TABLE_F_DORMANT	= 0x1,
 };
+#define NFT_TABLE_F_MASK       (NFT_TABLE_F_DORMANT)
 
 /**
  * enum nft_table_attributes - nf_tables table netlink attributes
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 800b5cc385af..1fe05e70cc79 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -10238,7 +10238,7 @@ static int io_uring_show_cred(struct seq_file *m, unsigned int id,
 
 static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 {
-	struct io_sq_data *sq = NULL;
+	int sq_pid = -1, sq_cpu = -1;
 	bool has_lock;
 	int i;
 
@@ -10251,13 +10251,19 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
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
index d3f6a070875c..33ea6ab12f47 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -602,7 +602,11 @@ static __always_inline int bpf_tree_comp(void *key, struct latch_tree_node *n)
 
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
index 8f1e43df8c5f..45c50ee9b037 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1841,7 +1841,12 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
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
@@ -2534,7 +2539,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		   insn->imm != 0 && env->bpf_capable) {
 		struct bpf_reg_state fake_reg = {};
 
-		__mark_reg_known(&fake_reg, (u32)insn->imm);
+		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type = SCALAR_VALUE;
 		save_register_state(state, spi, &fake_reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 0f31b22abe8d..ef54254a5dd1 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1022,6 +1022,9 @@ void kgdb_panic(const char *msg)
 	if (panic_timeout)
 		return;
 
+	debug_locks_off();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
 	if (dbg_kdb_mode)
 		kdb_printf("PANIC: %s\n", msg);
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4032cd475000..01351e7e2543 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -691,6 +691,12 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		max_order--;
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
index e2999a070a99..4195e7ad1ff2 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -537,21 +537,34 @@ EXPORT_SYMBOL_GPL(irq_setup_alt_chip);
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
index 7d500219f96b..fdcd78302cd7 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -207,7 +207,7 @@ int padata_do_parallel(struct padata_shell *ps,
 		*cb_cpu = cpu;
 	}
 
-	err =  -EBUSY;
+	err = -EBUSY;
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index f5dccd445d36..c1bdaae07f4c 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2372,8 +2372,9 @@ static void *get_highmem_page_buffer(struct page *page,
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
@@ -2553,8 +2554,9 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
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
@@ -2585,8 +2587,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
 
-	handle->sync_read = 1;
-
 	if (!handle->cur) {
 		if (!buffer)
 			/* This makes the buffer be freed by swsusp_free() */
@@ -2622,7 +2622,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			memory_bm_position_reset(&orig_bm);
 			restore_pblist = NULL;
 			handle->buffer = get_buffer(&orig_bm, &ca);
-			handle->sync_read = 0;
 			if (IS_ERR(handle->buffer))
 				return PTR_ERR(handle->buffer);
 		}
@@ -2632,9 +2631,8 @@ int snapshot_write_next(struct snapshot_handle *handle)
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
index eec8e2f7537e..06bfe61d3cd3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/export.h>
 #include <linux/completion.h>
+#include <linux/kmemleak.h>
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
@@ -3547,6 +3548,14 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
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
diff --git a/kernel/reboot.c b/kernel/reboot.c
index af6f23d8bea1..e297b35fc652 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -64,6 +64,7 @@ EXPORT_SYMBOL_GPL(pm_power_off_prepare);
 void emergency_restart(void)
 {
 	kmsg_dump(KMSG_DUMP_EMERG);
+	system_state = SYSTEM_RESTART;
 	machine_emergency_restart();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 196eec0423ff..89a8bb8e24df 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4572,6 +4572,20 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
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
@@ -4582,6 +4596,7 @@ int tracing_release_file_tr(struct inode *inode, struct file *filp)
 	struct trace_event_file *file = inode->i_private;
 
 	trace_array_put(file->tr);
+	event_file_put(file);
 
 	return 0;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 7fa00b83dfa4..7c90872f2435 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1784,6 +1784,9 @@ extern int register_event_command(struct event_command *cmd);
 extern int unregister_event_command(struct event_command *cmd);
 extern int register_trigger_hist_enable_disable_cmds(void);
 
+extern void event_file_get(struct trace_event_file *file);
+extern void event_file_put(struct trace_event_file *file);
+
 /**
  * struct event_trigger_ops - callbacks for trace event triggers
  *
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c7f0a02442e5..4b5a8d7275be 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -746,26 +746,38 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
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
@@ -1138,7 +1150,7 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
 
-	if (!file)
+	if (!file || flags & EVENT_FILE_FL_FREED)
 		return -ENODEV;
 
 	if (flags & EVENT_FILE_FL_ENABLED &&
@@ -1176,7 +1188,7 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
 		file = event_file_data(filp);
-		if (likely(file))
+		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED)))
 			ret = ftrace_event_enable_disable(file, val);
 		mutex_unlock(&event_mutex);
 		break;
@@ -1445,7 +1457,7 @@ event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	file = event_file_data(filp);
-	if (file)
+	if (file && !(file->flags & EVENT_FILE_FL_FREED))
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
@@ -2482,6 +2494,7 @@ trace_create_new_event(struct trace_event_call *call,
 	atomic_set(&file->tm_ref, 0);
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
+	event_file_get(file);
 
 	return file;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a255ffbe342f..c1db5b62d811 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1893,6 +1893,9 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 	struct event_filter *filter = NULL;
 	int err;
 
+	if (file->flags & EVENT_FILE_FL_FREED)
+		return -ENODEV;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_disable(file);
 		filter = event_filter(file);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ec34d9f2eab2..78a4603e14cd 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -176,6 +176,13 @@ static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
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
diff --git a/mm/cma.c b/mm/cma.c
index 7f415d7cda9f..3c3f1436f643 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -482,7 +482,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	 */
 	if (page) {
 		for (i = 0; i < count; i++)
-			page_kasan_tag_reset(page + i);
+			page_kasan_tag_reset(nth_page(page, i));
 	}
 
 	if (ret && !no_warn) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 751e3670d7b0..ddc8ed096dec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2892,7 +2892,8 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
  * Moreover, it should not come from DMA buffer and is not readily
  * reclaimable. So those GFP bits should be masked off.
  */
-#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
+#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
+				 __GFP_ACCOUNT | __GFP_NOFAIL)
 
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5286945470b9..553b0705dce8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1263,7 +1263,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		head = compound_head(page);
 		if (page_huge_active(head))
 			goto found;
-		skip = compound_nr(head) - (page - head);
+		skip = compound_nr(head) - (pfn - page_to_pfn(head));
 		pfn += skip - 1;
 	}
 	return -ENOENT;
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index e070a0b8e5ca..63f4d2067059 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -823,14 +823,21 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
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
index a9f6089a2ae2..74721c3e49b3 100644
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
index ccd2c377bf83..266112c960ee 100644
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
diff --git a/net/core/sock.c b/net/core/sock.c
index fcb998dc2dc6..a069b5476df4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -532,7 +532,7 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 
 	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
-		sk->sk_dst_pending_confirm = 0;
+		WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
 		dst_release(dst);
 		return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4df287885dd7..f8ad8465f76c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1320,7 +1320,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	skb_set_hash_from_sk(skb, sk);
 	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
 
-	skb_set_dst_pending_confirm(skb, sk->sk_dst_pending_confirm);
+	skb_set_dst_pending_confirm(skb, READ_ONCE(sk->sk_dst_pending_confirm));
 
 	/* Build TCP header and checksum it. */
 	th = (struct tcphdr *)skb->data;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c6a7f1c99abc..45bb6f275598 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2726,6 +2726,10 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	else
 		*dbm = sdata->vif.bss_conf.txpower;
 
+	/* INT_MIN indicates no power level was set yet */
+	if (*dbm == INT_MIN)
+		return -EINVAL;
+
 	return 0;
 }
 
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
index 78b268bd7f01..dfb347f8d3ad 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -863,7 +863,8 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 		goto nla_put_failure;
 
 	if (nla_put_string(skb, NFTA_TABLE_NAME, table->name) ||
-	    nla_put_be32(skb, NFTA_TABLE_FLAGS, htonl(table->flags)) ||
+	    nla_put_be32(skb, NFTA_TABLE_FLAGS,
+			 htonl(table->flags & NFT_TABLE_F_MASK)) ||
 	    nla_put_be32(skb, NFTA_TABLE_USE, htonl(table->use)) ||
 	    nla_put_be64(skb, NFTA_TABLE_HANDLE, cpu_to_be64(table->handle),
 			 NFTA_TABLE_PAD))
@@ -1071,14 +1072,22 @@ static int nf_tables_table_enable(struct net *net, struct nft_table *table)
 
 static void nf_tables_table_disable(struct net *net, struct nft_table *table)
 {
+	table->flags &= ~NFT_TABLE_F_DORMANT;
 	nft_table_disable(net, table, 0);
+	table->flags |= NFT_TABLE_F_DORMANT;
 }
 
+#define __NFT_TABLE_F_INTERNAL		(NFT_TABLE_F_MASK + 1)
+#define __NFT_TABLE_F_WAS_DORMANT	(__NFT_TABLE_F_INTERNAL << 0)
+#define __NFT_TABLE_F_WAS_AWAKEN	(__NFT_TABLE_F_INTERNAL << 1)
+#define __NFT_TABLE_F_UPDATE		(__NFT_TABLE_F_WAS_DORMANT | \
+					 __NFT_TABLE_F_WAS_AWAKEN)
+
 static int nf_tables_updtable(struct nft_ctx *ctx)
 {
 	struct nft_trans *trans;
 	u32 flags;
-	int ret = 0;
+	int ret;
 
 	if (!ctx->nla[NFTA_TABLE_FLAGS])
 		return 0;
@@ -1090,6 +1099,10 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags == ctx->table->flags)
 		return 0;
 
+	/* No dormant off/on/off/on games in single transaction */
+	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
+		return -EINVAL;
+
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWTABLE,
 				sizeof(struct nft_trans_table));
 	if (trans == NULL)
@@ -1097,23 +1110,27 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 
 	if ((flags & NFT_TABLE_F_DORMANT) &&
 	    !(ctx->table->flags & NFT_TABLE_F_DORMANT)) {
-		nft_trans_table_enable(trans) = false;
+		ctx->table->flags |= NFT_TABLE_F_DORMANT;
+		if (!(ctx->table->flags & __NFT_TABLE_F_UPDATE))
+			ctx->table->flags |= __NFT_TABLE_F_WAS_AWAKEN;
 	} else if (!(flags & NFT_TABLE_F_DORMANT) &&
 		   ctx->table->flags & NFT_TABLE_F_DORMANT) {
 		ctx->table->flags &= ~NFT_TABLE_F_DORMANT;
-		ret = nf_tables_table_enable(ctx->net, ctx->table);
-		if (ret >= 0)
-			nft_trans_table_enable(trans) = true;
-		else
-			ctx->table->flags |= NFT_TABLE_F_DORMANT;
+		if (!(ctx->table->flags & __NFT_TABLE_F_UPDATE)) {
+			ret = nf_tables_table_enable(ctx->net, ctx->table);
+			if (ret < 0)
+				goto err_register_hooks;
+
+			ctx->table->flags |= __NFT_TABLE_F_WAS_DORMANT;
+		}
 	}
-	if (ret < 0)
-		goto err;
 
 	nft_trans_table_update(trans) = true;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
+
 	return 0;
-err:
+
+err_register_hooks:
 	nft_trans_destroy(trans);
 	return ret;
 }
@@ -8475,11 +8492,14 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWTABLE:
 			if (nft_trans_table_update(trans)) {
-				if (!nft_trans_table_enable(trans)) {
-					nf_tables_table_disable(net,
-								trans->ctx.table);
-					trans->ctx.table->flags |= NFT_TABLE_F_DORMANT;
+				if (!(trans->ctx.table->flags & __NFT_TABLE_F_UPDATE)) {
+					nft_trans_destroy(trans);
+					break;
 				}
+				if (trans->ctx.table->flags & NFT_TABLE_F_DORMANT)
+					nf_tables_table_disable(net, trans->ctx.table);
+
+				trans->ctx.table->flags &= ~__NFT_TABLE_F_UPDATE;
 			} else {
 				nft_clear(net, trans->ctx.table);
 			}
@@ -8728,11 +8748,17 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWTABLE:
 			if (nft_trans_table_update(trans)) {
-				if (nft_trans_table_enable(trans)) {
-					nf_tables_table_disable(net,
-								trans->ctx.table);
+				if (!(trans->ctx.table->flags & __NFT_TABLE_F_UPDATE)) {
+					nft_trans_destroy(trans);
+					break;
+				}
+				if (trans->ctx.table->flags & __NFT_TABLE_F_WAS_DORMANT) {
+					nf_tables_table_disable(net, trans->ctx.table);
 					trans->ctx.table->flags |= NFT_TABLE_F_DORMANT;
+				} else if (trans->ctx.table->flags & __NFT_TABLE_F_WAS_AWAKEN) {
+					trans->ctx.table->flags &= ~NFT_TABLE_F_DORMANT;
 				}
+				trans->ctx.table->flags &= ~__NFT_TABLE_F_UPDATE;
 				nft_trans_destroy(trans);
 			} else {
 				list_del_rcu(&trans->ctx.table->list);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index c7c1754f8744..360a3bcd91fe 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -109,7 +109,8 @@ static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
-		__rpc_clnt_remove_pipedir(clnt);
+		if (pipefs_sb == clnt->pipefs_sb)
+			__rpc_clnt_remove_pipedir(clnt);
 		rpc_put_sb_net(net);
 	}
 }
@@ -149,6 +150,8 @@ rpc_setup_pipedir(struct super_block *pipefs_sb, struct rpc_clnt *clnt)
 {
 	struct dentry *dentry;
 
+	clnt->pipefs_sb = pipefs_sb;
+
 	if (clnt->cl_program->pipe_dir_name != NULL) {
 		dentry = rpc_setup_pipedir_sb(pipefs_sb, clnt);
 		if (IS_ERR(dentry))
@@ -2074,6 +2077,7 @@ call_connect_status(struct rpc_task *task)
 	task->tk_status = 0;
 	switch (status) {
 	case -ECONNREFUSED:
+	case -ECONNRESET:
 		/* A positive refusal suggests a rebind is needed. */
 		if (RPC_IS_SOFTCONN(task))
 			break;
@@ -2082,7 +2086,6 @@ call_connect_status(struct rpc_task *task)
 			goto out_retry;
 		}
 		fallthrough;
-	case -ECONNRESET:
 	case -ECONNABORTED:
 	case -ENETDOWN:
 	case -ENETUNREACH:
diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 38fe2ce8a5aa..8fad45320e1b 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -743,6 +743,10 @@ void rpcb_getport_async(struct rpc_task *task)
 
 	child = rpcb_call_async(rpcb_clnt, map, proc);
 	rpc_release_client(rpcb_clnt);
+	if (IS_ERR(child)) {
+		/* rpcb_map_release() has freed the arguments */
+		return;
+	}
 
 	xprt->stat.bind_count++;
 	rpc_put_task(child);
diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 2d62932b5987..6f0c09b6a153 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -101,6 +101,7 @@ static int tipc_add_tlv(struct sk_buff *skb, u16 type, void *data, u16 len)
 		return -EMSGSIZE;
 
 	skb_put(skb, TLV_SPACE(len));
+	memset(tlv, 0, TLV_SPACE(len));
 	tlv->tlv_type = htons(type);
 	tlv->tlv_len = htons(TLV_LENGTH(len));
 	if (len && data)
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index bd29e4e7a524..c7ff92b4189c 100644
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
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..70efd4aa1bd1 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -212,6 +212,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
+	struct inode *real_inode = d_real_inode(file_dentry(file));
 	const char *filename = file->f_path.dentry->d_name.name;
 	int result = 0;
 	int length;
@@ -262,6 +263,10 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
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
index dd4b28b11ebe..8e0fe0ce6164 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,7 @@
 #include <linux/ima.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
+#include <linux/iversion.h>
 
 #include "ima.h"
 
@@ -197,7 +198,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *backing_inode, *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
@@ -271,6 +272,19 @@ static int process_measurement(struct file *file, const struct cred *cred,
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
index 413c803c5208..bc51a4e83989 100644
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
diff --git a/sound/core/info.c b/sound/core/info.c
index d6fb11c3250c..ebae11b49429 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -57,7 +57,7 @@ struct snd_info_private_data {
 };
 
 static int snd_info_version_init(void);
-static void snd_info_disconnect(struct snd_info_entry *entry);
+static void snd_info_clear_entries(struct snd_info_entry *entry);
 
 /*
 
@@ -570,11 +570,16 @@ void snd_info_card_disconnect(struct snd_card *card)
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
 
@@ -746,15 +751,14 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
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
 
@@ -771,8 +775,9 @@ void snd_info_free_entry(struct snd_info_entry * entry)
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
index 1e0f61affd97..5570722458ca 100644
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
index adfab80b8189..65f8dc65b967 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9036,6 +9036,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x10c0, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x10d0, "ASUS X540LA/X540LJ", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x10d3, "ASUS K6500ZC", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
@@ -9881,22 +9882,6 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
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
@@ -9940,6 +9925,9 @@ static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+		{0x19, 0x40000000},
+		{0x1b, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 6025b30bbe77..9a88992ac5f3 100644
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
index d33c9d427e57..9d4a249cc98b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1995,7 +1995,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if ((DO_BIC(BIC_CPU_c6) || soft_c1_residency_display(BIC_CPU_c6)) && !do_knl_cstates) {
 		if (get_msr(cpu, MSR_CORE_C6_RESIDENCY, &c->c6))
 			return -7;
-	} else if (do_knl_cstates || soft_c1_residency_display(BIC_CPU_c6)) {
+	} else if (do_knl_cstates && soft_c1_residency_display(BIC_CPU_c6)) {
 		if (get_msr(cpu, MSR_KNL_CORE_C6_RESIDENCY, &c->c6))
 			return -7;
 	}
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
