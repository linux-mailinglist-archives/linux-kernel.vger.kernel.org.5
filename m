Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C523A7FC272
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbjK1RLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjK1RLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:11:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0341727
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:11:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CADC433C8;
        Tue, 28 Nov 2023 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701191489;
        bh=lt+fq1NO+VXSzS+NcrmlV9A+F3rXvo3aRH8wvnw+PMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jodye/kkmW8QBPI6lTrJV/gy62vl6zOMn+lKAi+ykRyc9OeNPM+ReDUHqTDenso0l
         mTh7L5wJg1HAn2IgHfCYfBhRa2TKu/reZfVYwldCUv8SYHNrTT5esftLcS2QBn37+n
         XZuf/0jk38N7zSSWm2ZyxuPlQ8cVkDcTLeyY867o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.262
Date:   Tue, 28 Nov 2023 17:11:17 +0000
Message-ID: <2023112817-goatskin-unisexual-bc30@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023112817-snare-stylist-f3a0@gregkh>
References: <2023112817-snare-stylist-f3a0@gregkh>
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
index e1892469e2c5..b18a23b946b2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 261
+SUBLEVEL = 262
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
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
index 2f64f112934b..9ce4e525b392 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -511,13 +511,13 @@
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
@@ -525,8 +525,7 @@
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
index b59a0c3d3692..9fee4d626375 100644
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
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 7167a162d7be..5a4a391f556a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -469,6 +469,7 @@
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
+#define MSR_AMD64_TW_CFG		0xc0011023
 
 #define MSR_AMD64_DE_CFG		0xc0011029
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	 1
diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index bbfde3d2662f..4bcd9d0c7bee 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -11,13 +11,6 @@
 
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
index 232c9d683b38..43586b7586c0 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -88,8 +88,12 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
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
index f9603df799bf..8922f63f5566 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -555,10 +555,12 @@ static int stimer_set_count(struct kvm_vcpu_hv_stimer *stimer, u64 count,
 
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
index 8dd1d1c81c79..07154cae7a15 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2720,6 +2720,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 		break;
 
@@ -3029,6 +3030,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 		msr_info->data = 0;
 		break;
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 67c617c4a7f2..7316dca7e846 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -581,13 +581,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
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
index 276d2fd9e911..63e64164900e 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -118,6 +118,8 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 	err = padata_do_parallel(ictx->psenc, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
@@ -165,6 +167,8 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 	err = padata_do_parallel(ictx->psdec, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 95d19740c207..d2b6a5ddb7ed 100644
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
index 46990352b5d3..bfc889367d5e 100644
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
index 79f77315854f..dbba6a09e51e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -57,6 +57,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_IFNUM_2		0x80000
 #define BTUSB_CW6622		0x100000
 #define BTUSB_MEDIATEK		0x200000
+#define BTUSB_WIDEBAND_SPEECH	0x400000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -332,20 +333,42 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
 
 	/* Intel Bluetooth devices */
-	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
-	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW },
-	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW },
+	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
-	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW },
-	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL },
-	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW },
+	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Other Intel Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_IGNORE },
 
+	/* Realtek 8822CE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
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
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index e9835db941d8..052e168d2a2a 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -423,7 +423,6 @@ static struct clk_fixed_factor gpll0_out_main_div2 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -470,7 +469,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -503,7 +501,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -537,7 +534,6 @@ static struct clk_alpha_pll_postdiv gpll6 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -551,7 +547,6 @@ static struct clk_fixed_factor gpll6_out_main_div2 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -616,7 +611,6 @@ static struct clk_alpha_pll_postdiv nss_crypto_pll = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 7427b07495a8..906c1bfdccad 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -310,6 +310,7 @@ static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
 	writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP		/* free-run */
+			| ATMEL_TC_ASWTRG_SET		/* TIOA0 rises at software trigger */
 			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
 			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
 			tcaddr + ATMEL_TC_REG(0, CMR));
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 706c0d0ff56c..268c09417fa2 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -460,12 +460,16 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
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
 
@@ -478,11 +482,15 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
 
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
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index ed5a999bb32f..f90feb081861 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -510,7 +510,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 	src_maxburst = chan->dma_config.src_maxburst;
 	dst_maxburst = chan->dma_config.dst_maxburst;
 
-	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
+	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
 	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
 	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
 
@@ -938,7 +938,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 	if (!desc)
 		return NULL;
 
-	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
+	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
 	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
 	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index e0d2f79571ef..94a626fe9118 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -178,6 +178,7 @@ int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
 	}
 
 	rcu_read_unlock();
+	*result = NULL;
 	return -ENOENT;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a9a81e55777b..d81034023144 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -392,6 +392,9 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_rreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
@@ -431,6 +434,9 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_wreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index bb09243758fe..71b10b45a9b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -492,7 +492,7 @@ uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		return tg->funcs->get_frame_count(tg);
@@ -551,7 +551,7 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		tg->funcs->get_scanoutpos(tg,
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
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
index 1e870f58dd12..0c61e2bc14cd 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
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
index b848270e0a1f..31527fb66b5c 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -1171,7 +1171,7 @@ int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
 	return 0;
 }
 
-static void
+static int
 komeda_pipeline_unbound_components(struct komeda_pipeline *pipe,
 				   struct komeda_pipeline_state *new)
 {
@@ -1190,8 +1190,12 @@ komeda_pipeline_unbound_components(struct komeda_pipeline *pipe,
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
@@ -1213,9 +1217,8 @@ int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
 	if (WARN_ON(IS_ERR_OR_NULL(st)))
 		return -EINVAL;
 
-	komeda_pipeline_unbound_components(pipe, st);
+	return komeda_pipeline_unbound_components(pipe, st);
 
-	return 0;
 }
 
 void komeda_pipeline_disable(struct komeda_pipeline *pipe,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 64842926aff6..182068bf28c0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -350,6 +350,7 @@
 
 #define USB_VENDOR_ID_DELL				0x413c
 #define USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE	0x301a
+#define USB_DEVICE_ID_DELL_PRO_WIRELESS_KM5221W		0x4503
 
 #define USB_VENDOR_ID_DELORME		0x1163
 #define USB_DEVICE_ID_DELORME_EARTHMATE	0x0100
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 83c3322fcf18..fae784df084d 100644
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
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 7779f8e50256..50c972b3efe0 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -723,15 +723,11 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
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
@@ -754,9 +750,12 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
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
index 7c07ce116e38..540c33f4e350 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -202,6 +202,11 @@ static int p2wi_probe(struct platform_device *pdev)
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
index 517d98be68d2..328a2fff1935 100644
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
index 6d5719cea9f5..cc0944e2d330 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -189,7 +189,7 @@
 #define SLV_STATUS1_HJ_DIS		BIT(18)
 #define SLV_STATUS1_MR_DIS		BIT(17)
 #define SLV_STATUS1_PROT_ERR		BIT(16)
-#define SLV_STATUS1_DA(x)		(((s) & GENMASK(15, 9)) >> 9)
+#define SLV_STATUS1_DA(s)		(((s) & GENMASK(15, 9)) >> 9)
 #define SLV_STATUS1_HAS_DA		BIT(8)
 #define SLV_STATUS1_DDR_RX_FULL		BIT(7)
 #define SLV_STATUS1_DDR_TX_FULL		BIT(6)
@@ -1580,13 +1580,13 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
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
index 61362bd6d3ce..111705e6609c 100644
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
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 174461371b76..e051e4dd3352 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -248,6 +248,7 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev)
 	return 0;
 
 out:
+	put_device(&dev->dev);
 
 	return ret;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index a88862ff8507..268d5a482ab1 100644
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
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 04ef2286efc6..5694d18b43d5 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -350,7 +350,7 @@ session_get_prop_buf_req(struct hfi_msg_session_property_info_pkt *pkt,
 		memcpy(&bufreq[idx], buf_req, sizeof(*bufreq));
 		idx++;
 
-		if (idx > HFI_BUFFER_TYPE_MAX)
+		if (idx >= HFI_BUFFER_TYPE_MAX)
 			return HFI_ERR_SESSION_INVALID_PARAMETER;
 
 		req_bytes -= sizeof(struct hfi_buffer_requirements);
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 7f515a4b9bd1..ad22b51765d4 100644
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
index 0d8855014ab3..306082e25943 100644
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
diff --git a/drivers/media/platform/vivid/vivid-rds-gen.c b/drivers/media/platform/vivid/vivid-rds-gen.c
index b5b104ee64c9..c57771119a34 100644
--- a/drivers/media/platform/vivid/vivid-rds-gen.c
+++ b/drivers/media/platform/vivid/vivid-rds-gen.c
@@ -145,7 +145,7 @@ void vivid_rds_gen_fill(struct vivid_rds_gen *rds, unsigned freq,
 	rds->ta = alt;
 	rds->ms = true;
 	snprintf(rds->psname, sizeof(rds->psname), "%6d.%1d",
-		 freq / 16, ((freq & 0xf) * 10) / 16);
+		 (freq / 16) % 1000000, (((freq & 0xf) * 10) / 16) % 10);
 	if (alt)
 		strscpy(rds->radiotext,
 			" The Radio Data System can switch between different Radio Texts ",
diff --git a/drivers/media/rc/ir-sharp-decoder.c b/drivers/media/rc/ir-sharp-decoder.c
index 37fab0919131..e92bcd00e3a8 100644
--- a/drivers/media/rc/ir-sharp-decoder.c
+++ b/drivers/media/rc/ir-sharp-decoder.c
@@ -15,7 +15,9 @@
 #define SHARP_UNIT		40000  /* ns */
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
index f078f8a3aec8..7de97c26b622 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -292,7 +292,11 @@ static ssize_t ir_lirc_transmit_ir(struct file *file, const char __user *buf,
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
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 35bdca9384d5..8930dbd13c65 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -803,7 +803,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
 	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
-	cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
 
 	meson_mmc_set_response_bits(cmd, &cmd_cfg);
 
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 5e9d4c9c0186..177937dd69ae 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2318,6 +2318,7 @@ static int vub300_probe(struct usb_interface *interface,
 		vub300->read_only =
 			(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	} else {
+		retval = -EINVAL;
 		goto error5;
 	}
 	usb_set_intfdata(interface, vub300);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index afd327e88cf5..bb1c6743222e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1144,6 +1144,10 @@ static void bond_compute_features(struct bonding *bond)
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
+	bool was_up = !!(bond_dev->flags & IFF_UP);
+
+	dev_close(bond_dev);
+
 	bond_dev->header_ops	    = slave_dev->header_ops;
 
 	bond_dev->type		    = slave_dev->type;
@@ -1158,6 +1162,8 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
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
index a8a8b77c1611..4bcdb48b0e9c 100644
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
@@ -1152,6 +1152,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1166,9 +1167,30 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
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
@@ -1993,15 +2015,6 @@ static int gmac_change_mtu(struct net_device *netdev, int new_mtu)
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
@@ -2222,7 +2235,6 @@ static const struct net_device_ops gmac_351x_ops = {
 	.ndo_set_mac_address	= gmac_set_mac_address,
 	.ndo_get_stats64	= gmac_get_stats64,
 	.ndo_change_mtu		= gmac_change_mtu,
-	.ndo_fix_features	= gmac_fix_features,
 	.ndo_set_features	= gmac_set_features,
 };
 
@@ -2476,11 +2488,12 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
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
index ffd1018d43fb..d09cc10b3517 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3773,7 +3773,7 @@ static int hns3_init_mac_addr(struct net_device *netdev, bool init)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = priv->ae_handle;
-	u8 mac_addr_temp[ETH_ALEN];
+	u8 mac_addr_temp[ETH_ALEN] = {0};
 	int ret = 0;
 
 	if (h->ae_algo->ops->get_mac_addr && init) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index d63ce3feb65c..6e763699d504 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -55,7 +55,7 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	u32 running_fw, stored_fw;
 	int err;
 
-	err = devlink_info_driver_name_put(req, DRIVER_NAME);
+	err = devlink_info_driver_name_put(req, KBUILD_MODNAME);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 362f01bc8372..5a4bee5253ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -290,9 +290,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
-	e->encap_size = ipv4_encap_size;
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -309,6 +306,8 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
+	e->encap_size = ipv4_encap_size;
+	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	neigh_release(n);
@@ -408,9 +407,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
-	e->encap_size = ipv6_encap_size;
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -428,6 +424,8 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
+	e->encap_size = ipv6_encap_size;
+	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	neigh_release(n);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index e92cc60eade3..18e0cb02aee1 100644
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
index f448a139e222..ed37cc7c9ae0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -71,14 +71,17 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
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
index 90cb50fe17fd..f7f809887984 100644
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
index ff9ac7cffc32..a183613420d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -75,7 +75,6 @@
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_VERSION(DRIVER_VERSION);
 
 unsigned int mlx5_core_debug_mask;
 module_param_named(debug_mask, mlx5_core_debug_mask, uint, 0644);
@@ -222,7 +221,7 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 	strncat(string, ",", remaining_size);
 
 	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, DRIVER_NAME, remaining_size);
+	strncat(string, KBUILD_MODNAME, remaining_size);
 
 	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
 	strncat(string, ",", remaining_size);
@@ -307,7 +306,7 @@ static int request_bar(struct pci_dev *pdev)
 		return -ENODEV;
 	}
 
-	err = pci_request_regions(pdev, DRIVER_NAME);
+	err = pci_request_regions(pdev, KBUILD_MODNAME);
 	if (err)
 		dev_err(&pdev->dev, "Couldn't get PCI resources, aborting\n");
 
@@ -1618,7 +1617,7 @@ void mlx5_recover_device(struct mlx5_core_dev *dev)
 }
 
 static struct pci_driver mlx5_core_driver = {
-	.name           = DRIVER_NAME,
+	.name           = KBUILD_MODNAME,
 	.id_table       = mlx5_core_pci_table,
 	.probe          = init_one,
 	.remove         = remove_one,
@@ -1644,6 +1643,9 @@ static int __init mlx5_init(void)
 {
 	int err;
 
+	WARN_ONCE(strcmp(MLX5_ADEV_NAME, KBUILD_MODNAME),
+		  "mlx5_core name not in sync with kernel module name");
+
 	get_random_bytes(&sw_owner_id, sizeof(sw_owner_id));
 
 	mlx5_core_verify_params();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index b100489dc85c..e053a17e0c7a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -43,9 +43,6 @@
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/driver.h>
 
-#define DRIVER_NAME "mlx5_core"
-#define DRIVER_VERSION "5.0-0"
-
 extern uint mlx5_core_debug_mask;
 
 #define mlx5_core_dbg(__dev, format, ...)				\
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 28e2cd9c386a..e000cabf65f8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4292,9 +4292,7 @@ static void rtl_set_rx_mode(struct net_device *dev)
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
index 6a3b0f76d972..4eaa65e8d58f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3440,6 +3440,55 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
 }
 
+static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
+				       struct dma_desc *p,
+				       int status, unsigned int len)
+{
+	int ret, coe = priv->hw->rx_csum;
+	unsigned int plen = 0, hlen = 0;
+
+	/* Not first descriptor, buffer is always zero */
+	if (priv->sph && len)
+		return 0;
+
+	/* First descriptor, get split header length */
+	ret = stmmac_get_rx_header_len(priv, p, &hlen);
+	if (priv->sph && hlen) {
+		priv->xstats.rx_split_hdr_pkt_n++;
+		return hlen;
+	}
+
+	/* First descriptor, not last descriptor and not split header */
+	if (status & rx_not_ls)
+		return priv->dma_buf_sz;
+
+	plen = stmmac_get_rx_frame_len(priv, p, coe);
+
+	/* First descriptor and last descriptor and not split header */
+	return min_t(unsigned int, priv->dma_buf_sz, plen);
+}
+
+static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
+				       struct dma_desc *p,
+				       int status, unsigned int len)
+{
+	int coe = priv->hw->rx_csum;
+	unsigned int plen = 0;
+
+	/* Not split header, buffer is not available */
+	if (!priv->sph)
+		return 0;
+
+	/* Not last descriptor */
+	if (status & rx_not_ls)
+		return priv->dma_buf_sz;
+
+	plen = stmmac_get_rx_frame_len(priv, p, coe);
+
+	/* Last descriptor */
+	return plen - len;
+}
+
 /**
  * stmmac_rx - manage the receive process
  * @priv: driver private structure
@@ -3469,11 +3518,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, DMA_RX_SIZE, true);
 	}
 	while (count < limit) {
-		unsigned int hlen = 0, prev_len = 0;
+		unsigned int buf1_len = 0, buf2_len = 0;
 		enum pkt_hash_types hash_type;
 		struct stmmac_rx_buffer *buf;
 		struct dma_desc *np, *p;
-		unsigned int sec_len;
 		int entry;
 		u32 hash;
 
@@ -3488,11 +3536,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			len = 0;
 		}
 
+read_again:
 		if (count >= limit)
 			break;
 
-read_again:
-		sec_len = 0;
+		buf1_len = 0;
+		buf2_len = 0;
 		entry = next_entry;
 		buf = &rx_q->buf_pool[entry];
 
@@ -3517,7 +3566,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			np = rx_q->dma_rx + next_entry;
 
 		prefetch(np);
-		prefetch(page_address(buf->page));
 
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->dev->stats,
@@ -3534,69 +3582,61 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			goto read_again;
 		if (unlikely(error)) {
 			dev_kfree_skb(skb);
+			skb = NULL;
 			count++;
 			continue;
 		}
 
 		/* Buffer is good. Go on. */
 
-		if (likely(status & rx_not_ls)) {
-			len += priv->dma_buf_sz;
-		} else {
-			prev_len = len;
-			len = stmmac_get_rx_frame_len(priv, p, coe);
-
-			/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
-			 * Type frames (LLC/LLC-SNAP)
-			 *
-			 * llc_snap is never checked in GMAC >= 4, so this ACS
-			 * feature is always disabled and packets need to be
-			 * stripped manually.
-			 */
-			if (unlikely(priv->synopsys_id >= DWMAC_CORE_4_00) ||
-			    unlikely(status != llc_snap))
-				len -= ETH_FCS_LEN;
+		prefetch(page_address(buf->page));
+		if (buf->sec_page)
+			prefetch(page_address(buf->sec_page));
+
+		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
+		len += buf1_len;
+		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
+		len += buf2_len;
+
+		/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
+		 * Type frames (LLC/LLC-SNAP)
+		 *
+		 * llc_snap is never checked in GMAC >= 4, so this ACS
+		 * feature is always disabled and packets need to be
+		 * stripped manually.
+		 */
+		if (unlikely(priv->synopsys_id >= DWMAC_CORE_4_00) ||
+		    unlikely(status != llc_snap)) {
+			if (buf2_len)
+				buf2_len -= ETH_FCS_LEN;
+			else
+				buf1_len -= ETH_FCS_LEN;
+
+			len -= ETH_FCS_LEN;
 		}
 
 		if (!skb) {
-			int ret = stmmac_get_rx_header_len(priv, p, &hlen);
-
-			if (priv->sph && !ret && (hlen > 0)) {
-				sec_len = len;
-				if (!(status & rx_not_ls))
-					sec_len = sec_len - hlen;
-				len = hlen;
-
-				prefetch(page_address(buf->sec_page));
-				priv->xstats.rx_split_hdr_pkt_n++;
-			}
-
-			skb = napi_alloc_skb(&ch->rx_napi, len);
+			skb = napi_alloc_skb(&ch->rx_napi, buf1_len);
 			if (!skb) {
 				priv->dev->stats.rx_dropped++;
 				count++;
-				continue;
+				goto drain_data;
 			}
 
-			dma_sync_single_for_cpu(priv->device, buf->addr, len,
-						DMA_FROM_DEVICE);
+			dma_sync_single_for_cpu(priv->device, buf->addr,
+						buf1_len, DMA_FROM_DEVICE);
 			skb_copy_to_linear_data(skb, page_address(buf->page),
-						len);
-			skb_put(skb, len);
+						buf1_len);
+			skb_put(skb, buf1_len);
 
 			/* Data payload copied into SKB, page ready for recycle */
 			page_pool_recycle_direct(rx_q->page_pool, buf->page);
 			buf->page = NULL;
-		} else {
-			unsigned int buf_len = len - prev_len;
-
-			if (likely(status & rx_not_ls))
-				buf_len = priv->dma_buf_sz;
-
+		} else if (buf1_len) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
-						buf_len, DMA_FROM_DEVICE);
+						buf1_len, DMA_FROM_DEVICE);
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->page, 0, buf_len,
+					buf->page, 0, buf1_len,
 					priv->dma_buf_sz);
 
 			/* Data payload appended into SKB */
@@ -3604,22 +3644,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			buf->page = NULL;
 		}
 
-		if (sec_len > 0) {
+		if (buf2_len) {
 			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
-						sec_len, DMA_FROM_DEVICE);
+						buf2_len, DMA_FROM_DEVICE);
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->sec_page, 0, sec_len,
+					buf->sec_page, 0, buf2_len,
 					priv->dma_buf_sz);
 
-			len += sec_len;
-
 			/* Data payload appended into SKB */
 			page_pool_release_page(rx_q->page_pool, buf->sec_page);
 			buf->sec_page = NULL;
 		}
 
+drain_data:
 		if (likely(status & rx_not_ls))
 			goto read_again;
+		if (!skb)
+			continue;
 
 		/* Got entire packet into SKB. Finish it. */
 
@@ -3637,13 +3678,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		skb_record_rx_queue(skb, queue);
 		napi_gro_receive(&ch->rx_napi, skb);
+		skb = NULL;
 
 		priv->dev->stats.rx_packets++;
 		priv->dev->stats.rx_bytes += len;
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (status & rx_not_ls || skb) {
 		rx_q->state_saved = true;
 		rx_q->state.skb = skb;
 		rx_q->state.error = error;
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
index 545d18145350..46398b06676c 100644
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
 
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 0f338752c38b..55641e01192d 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -463,6 +463,10 @@ ppp_sync_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
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
@@ -698,7 +702,7 @@ ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
 
 	/* strip address/control field if present */
 	p = skb->data;
-	if (p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
+	if (skb->len >= 2 && p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
 		/* chop off address/control */
 		if (skb->len < 3)
 			goto err;
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 04c50a26a4f4..34db968c4bd0 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1138,7 +1138,7 @@ void ath10k_debug_get_et_strings(struct ieee80211_hw *hw,
 				 u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath10k_gstrings_stats,
+		memcpy(data, ath10k_gstrings_stats,
 		       sizeof(ath10k_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index b6762fe2efe2..29d52f7b4336 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -821,12 +821,20 @@ static void ath10k_snoc_hif_get_default_pipe(struct ath10k *ar,
 
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
@@ -1042,6 +1050,8 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 		goto err_free_rri;
 	}
 
+	ath10k_ce_enable_interrupts(ar);
+
 	return 0;
 
 err_free_rri:
@@ -1196,8 +1206,8 @@ static int ath10k_snoc_request_irq(struct ath10k *ar)
 
 	for (id = 0; id < CE_COUNT_MAX; id++) {
 		ret = request_irq(ar_snoc->ce_irqs[id].irq_line,
-				  ath10k_snoc_per_engine_handler, 0,
-				  ce_name[id], ar);
+				  ath10k_snoc_per_engine_handler,
+				  IRQF_NO_AUTOEN, ce_name[id], ar);
 		if (ret) {
 			ath10k_err(ar,
 				   "failed to register IRQ handler for CE %d: %d",
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
index 9a81ce299d0d..fbcd46aedade 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -529,16 +529,20 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
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
index a21739b2f44e..634e8c1e71cc 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2323,7 +2323,7 @@ static void mac80211_hwsim_get_et_strings(struct ieee80211_hw *hw,
 					  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *mac80211_hwsim_gstrings_stats,
+		memcpy(data, mac80211_hwsim_gstrings_stats,
 		       sizeof(mac80211_hwsim_gstrings_stats));
 }
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index c8c702c494a2..ddbb2b3db74a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1181,7 +1181,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
-static int __init ks_pcie_probe(struct platform_device *pdev)
+static int ks_pcie_probe(struct platform_device *pdev)
 {
 	const struct dw_pcie_host_ops *host_ops;
 	const struct dw_pcie_ep_ops *ep_ops;
@@ -1407,7 +1407,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static int ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
@@ -1423,9 +1423,9 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
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
index 120d64c1a27f..1cf94854c44f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -7,6 +7,7 @@
  * Author: Vidya Sagar <vidyas@nvidia.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -321,8 +322,7 @@ static void apply_bad_link_workaround(struct pcie_port *pp)
 	 */
 	val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
 	if (val & PCI_EXP_LNKSTA_LBMS) {
-		current_link_width = (val & PCI_EXP_LNKSTA_NLW) >>
-				     PCI_EXP_LNKSTA_NLW_SHIFT;
+		current_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
 		if (pcie->init_link_width > current_link_width) {
 			dev_warn(pci->dev, "PCIe link is bad, width reduced\n");
 			val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
@@ -596,8 +596,7 @@ static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 
 	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKSTA);
-	pcie->init_link_width = (val_w & PCI_EXP_LNKSTA_NLW) >>
-				PCI_EXP_LNKSTA_NLW_SHIFT;
+	pcie->init_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val_w);
 
 	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKCTL);
@@ -773,7 +772,7 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 	/* Configure Max lane width from DT */
 	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_MLW;
-	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
+	val |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, pcie->num_lanes);
 	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
 
 	config_gen3_gen4_eq_presets(pcie);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e30c2a78a88f..86dc5ae17c6d 100644
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
index 171988de988d..90d5a29a6ff3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -517,10 +517,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 		return -EINVAL;
 
 	pdev->d3cold_allowed = !!val;
-	if (pdev->d3cold_allowed)
-		pci_d3cold_enable(pdev);
-	else
-		pci_d3cold_disable(pdev);
+	pci_bridge_d3_update(pdev);
 
 	pm_runtime_resume(dev);
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 5d114088c88f..f0d6bb567d1d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9699,6 +9699,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
 	TPACPI_Q_LNV3('R', '0', 'B', true), /* Thinkpad 11e gen 3 */
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 9d72ab593f13..87bd6c072ac2 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -443,7 +443,8 @@ ssize_t ptp_read(struct posix_clock *pc,
 
 	for (i = 0; i < cnt; i++) {
 		event[i] = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 
 	spin_unlock_irqrestore(&queue->lock, flags);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index eedf067ee8e3..a6ff02a02cab 100644
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
index 9399e1455d59..97087eef05db 100644
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
index c4b9762f19ee..603c99fcb74e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -252,13 +252,13 @@ u32 megasas_readl(struct megasas_instance *instance,
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
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index bf8bb9ce4fab..abd68fd7a34d 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -587,7 +587,7 @@ static int __init xen_hvc_init(void)
 		ops = &dom0_hvc_ops;
 		r = xen_initial_domain_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 		info = vtermno_to_xencons(HVC_COOKIE);
 	} else {
 		ops = &domU_hvc_ops;
@@ -596,7 +596,7 @@ static int __init xen_hvc_init(void)
 		else
 			r = xen_pv_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 
 		info = vtermno_to_xencons(HVC_COOKIE);
 		info->irq = bind_evtchn_to_irq_lateeoi(info->evtchn);
@@ -621,6 +621,7 @@ static int __init xen_hvc_init(void)
 	}
 
 	r = 0;
+ register_fe:
 #ifdef CONFIG_HVC_XEN_FRONTEND
 	r = xenbus_register_frontend(&xencons_driver);
 #endif
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 849ce8c1ef39..adb0bbcecd24 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -371,10 +371,14 @@ static void meson_uart_set_termios(struct uart_port *port,
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
 
@@ -665,15 +669,19 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
 
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
@@ -689,9 +697,12 @@ static int meson_uart_probe(struct platform_device *pdev)
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
@@ -714,14 +725,16 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->iotype = UPIO_MEM;
 	port->mapbase = res_mem->start;
 	port->mapsize = resource_size(res_mem);
-	port->irq = res_irq->start;
+	port->irq = irq;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
+	if (has_rtscts)
+		port->flags |= UPF_HARD_FLOW;
 	port->dev = &pdev->dev;
 	port->line = pdev->id;
 	port->type = PORT_MESON;
 	port->x_char = 0;
 	port->ops = &meson_uart_ops;
-	port->fifosize = 64;
+	port->fifosize = fifosize;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
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
index 8d23a870b7b7..2ef2464a5043 100644
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
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 230e77f9637c..91806dc1236d 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -491,7 +491,9 @@ static void lateeoi_list_add(struct irq_info *info)
 
 	spin_lock_irqsave(&eoi->eoi_list_lock, flags);
 
-	if (list_empty(&eoi->eoi_list)) {
+	elem = list_first_entry_or_null(&eoi->eoi_list, struct irq_info,
+					eoi_list);
+	if (!elem || info->eoi_time < elem->eoi_time) {
 		list_add(&info->eoi_list, &eoi->eoi_list);
 		mod_delayed_work_on(info->eoi_cpu, system_wq,
 				    &eoi->delayed, delay);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index f4f531c4aa96..d3f16dc33d0f 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -324,9 +324,6 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	} else {
 		if (current->journal_info)
 			flush = BTRFS_RESERVE_FLUSH_LIMIT;
-
-		if (btrfs_transaction_in_commit(fs_info))
-			schedule_timeout(1);
 	}
 
 	if (delalloc_lock)
diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 7f01c6e60791..6eb65988321f 100644
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
index 80b5288cc0e9..cfd05e016f18 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1348,8 +1348,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
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
index 880307ba0f27..3616c437bea6 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -572,13 +572,8 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
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
@@ -1565,6 +1560,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int gdb_num_end = ((group + flex_gd->count - 1) /
 				   EXT4_DESC_PER_BLOCK(sb));
 		int meta_bg = ext4_has_feature_meta_bg(sb);
+		sector_t padding_blocks = meta_bg ? 0 : sbi->s_sbh->b_blocknr -
+					 ext4_group_first_block_no(sb, 0);
 		sector_t old_gdb = 0;
 
 		update_backups(sb, ext4_group_first_block_no(sb, 0),
@@ -1576,8 +1573,8 @@ static int ext4_flex_group_add(struct super_block *sb,
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
@@ -1938,9 +1935,7 @@ static int ext4_convert_meta_bg(struct super_block *sb, struct inode *inode)
 
 errout:
 	ret = ext4_journal_stop(handle);
-	if (!err)
-		err = ret;
-	return ret;
+	return err ? err : ret;
 
 invalid_resize_inode:
 	ext4_error(sb, "corrupted/inconsistent resize inode");
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index cbee745169b8..ce3d65787e01 100644
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
 
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index a4967b27ffb6..ed923a9765c2 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -247,6 +247,8 @@ int jbd2_journal_recover(journal_t *journal)
 	journal_superblock_t *	sb;
 
 	struct recovery_info	info;
+	errseq_t		wb_err;
+	struct address_space	*mapping;
 
 	memset(&info, 0, sizeof(info));
 	sb = journal->j_superblock;
@@ -264,6 +266,9 @@ int jbd2_journal_recover(journal_t *journal)
 		return 0;
 	}
 
+	wb_err = 0;
+	mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	errseq_check_and_advance(&mapping->wb_err, &wb_err);
 	err = do_one_pass(journal, &info, PASS_SCAN);
 	if (!err)
 		err = do_one_pass(journal, &info, PASS_REVOKE);
@@ -282,6 +287,9 @@ int jbd2_journal_recover(journal_t *journal)
 
 	jbd2_journal_clear_revoke(journal);
 	err2 = sync_blockdev(journal->j_fs_dev);
+	if (!err)
+		err = err2;
+	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
 	if (!err)
 		err = err2;
 	/* Make sure all replayed data is on permanent storage */
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a785c747a8cb..ea330ce921b1 100644
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
index c41d14962604..b7529656b430 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5369,7 +5369,7 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_WRITE];
 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
-	nfs4_state_protect_write(server->nfs_client, clnt, msg, hdr);
+	nfs4_state_protect_write(hdr->ds_clp ? hdr->ds_clp : server->nfs_client, clnt, msg, hdr);
 }
 
 static void nfs4_proc_commit_rpc_prepare(struct rpc_task *task, struct nfs_commit_data *data)
@@ -5410,7 +5410,8 @@ static void nfs4_proc_commit_setup(struct nfs_commit_data *data, struct rpc_mess
 	data->res.server = server;
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_COMMIT];
 	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, 0);
-	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
+	nfs4_state_protect(data->ds_clp ? data->ds_clp : server->nfs_client,
+			NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
 }
 
 static int _nfs4_proc_commit(struct file *dst, struct nfs_commitargs *args,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 477819700156..a0aa7e63739d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2571,7 +2571,7 @@ static int client_opens_release(struct inode *inode, struct file *file)
 
 	/* XXX: alternatively, we could get/drop in seq start/stop */
 	drop_client(clp);
-	return 0;
+	return seq_release(inode, file);
 }
 
 static const struct file_operations client_states_fops = {
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 3e56fe319663..d9da4a8c4317 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2388,6 +2388,20 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
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
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 3a19b9202a12..18fd0a030584 100644
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
index b2c9c460947d..d1c26f5174e5 100644
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
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index a8e9d1a04f82..b8b87e7ba93f 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -341,6 +341,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
 	EVENT_FILE_FL_PID_FILTER_BIT,
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
+	EVENT_FILE_FL_FREED_BIT,
 };
 
 /*
@@ -357,6 +358,7 @@ enum {
  *  TRIGGER_COND  - When set, one or more triggers has an associated filter
  *  PID_FILTER    - When set, the event is filtered based on pid
  *  WAS_ENABLED   - Set when enabled to know to clear trace on module removal
+ *  FREED         - File descriptor is freed, all fields should be considered invalid
  */
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
@@ -370,6 +372,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
 	EVENT_FILE_FL_WAS_ENABLED	= (1 << EVENT_FILE_FL_WAS_ENABLED_BIT),
+	EVENT_FILE_FL_FREED		= (1 << EVENT_FILE_FL_FREED_BIT),
 };
 
 struct trace_event_file {
@@ -398,6 +401,7 @@ struct trace_event_file {
 	 * caching and such. Which is mostly OK ;-)
 	 */
 	unsigned long		flags;
+	atomic_t		ref;	/* ref count for opened files */
 	atomic_t		sm_ref;	/* soft-mode reference counter */
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index a2d1ec4aba1a..0a49d44ddb84 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -371,7 +371,8 @@ struct nft_set_ops {
 	int				(*init)(const struct nft_set *set,
 						const struct nft_set_desc *desc,
 						const struct nlattr * const nla[]);
-	void				(*destroy)(const struct nft_set *set);
+	void				(*destroy)(const struct nft_ctx *ctx,
+						   const struct nft_set *set);
 	void				(*gc_init)(const struct nft_set *set);
 
 	unsigned int			elemsize;
@@ -401,6 +402,7 @@ void nft_unregister_set(struct nft_set_type *type);
  *
  *	@list: table set list node
  *	@bindings: list of set bindings
+ *	@refs: internal refcounting for async set destruction
  *	@table: table this set belongs to
  *	@net: netnamespace this set belongs to
  * 	@name: name of the set
@@ -427,6 +429,7 @@ void nft_unregister_set(struct nft_set_type *type);
 struct nft_set {
 	struct list_head		list;
 	struct list_head		bindings;
+	refcount_t			refs;
 	struct nft_table		*table;
 	possible_net_t			net;
 	char				*name;
@@ -445,7 +448,8 @@ struct nft_set {
 	unsigned char			*udata;
 	/* runtime data below here */
 	const struct nft_set_ops	*ops ____cacheline_aligned;
-	u16				flags:14,
+	u16				flags:13,
+					dead:1,
 					genmask:2;
 	u8				klen;
 	u8				dlen;
@@ -463,6 +467,11 @@ static inline void *nft_set_priv(const struct nft_set *set)
 	return (void *)set->data;
 }
 
+static inline bool nft_set_gc_is_pending(const struct nft_set *s)
+{
+	return refcount_read(&s->refs) != 1;
+}
+
 static inline struct nft_set *nft_set_container_of(const void *priv)
 {
 	return (void *)priv - offsetof(struct nft_set, data);
@@ -665,62 +674,8 @@ void *nft_set_elem_init(const struct nft_set *set,
 			u64 timeout, u64 expiration, gfp_t gfp);
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr);
-
-/**
- *	struct nft_set_gc_batch_head - nf_tables set garbage collection batch
- *
- *	@rcu: rcu head
- *	@set: set the elements belong to
- *	@cnt: count of elements
- */
-struct nft_set_gc_batch_head {
-	struct rcu_head			rcu;
-	const struct nft_set		*set;
-	unsigned int			cnt;
-};
-
-#define NFT_SET_GC_BATCH_SIZE	((PAGE_SIZE -				  \
-				  sizeof(struct nft_set_gc_batch_head)) / \
-				 sizeof(void *))
-
-/**
- *	struct nft_set_gc_batch - nf_tables set garbage collection batch
- *
- * 	@head: GC batch head
- * 	@elems: garbage collection elements
- */
-struct nft_set_gc_batch {
-	struct nft_set_gc_batch_head	head;
-	void				*elems[NFT_SET_GC_BATCH_SIZE];
-};
-
-struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
-						gfp_t gfp);
-void nft_set_gc_batch_release(struct rcu_head *rcu);
-
-static inline void nft_set_gc_batch_complete(struct nft_set_gc_batch *gcb)
-{
-	if (gcb != NULL)
-		call_rcu(&gcb->head.rcu, nft_set_gc_batch_release);
-}
-
-static inline struct nft_set_gc_batch *
-nft_set_gc_batch_check(const struct nft_set *set, struct nft_set_gc_batch *gcb,
-		       gfp_t gfp)
-{
-	if (gcb != NULL) {
-		if (gcb->head.cnt + 1 < ARRAY_SIZE(gcb->elems))
-			return gcb;
-		nft_set_gc_batch_complete(gcb);
-	}
-	return nft_set_gc_batch_alloc(set, gfp);
-}
-
-static inline void nft_set_gc_batch_add(struct nft_set_gc_batch *gcb,
-					void *elem)
-{
-	gcb->elems[gcb->head.cnt++] = elem;
-}
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem);
 
 struct nft_expr_ops;
 /**
@@ -1348,39 +1303,30 @@ static inline void nft_set_elem_change_active(const struct net *net,
 
 #endif /* IS_ENABLED(CONFIG_NF_TABLES) */
 
-/*
- * We use a free bit in the genmask field to indicate the element
- * is busy, meaning it is currently being processed either by
- * the netlink API or GC.
- *
- * Even though the genmask is only a single byte wide, this works
- * because the extension structure if fully constant once initialized,
- * so there are no non-atomic write accesses unless it is already
- * marked busy.
- */
-#define NFT_SET_ELEM_BUSY_MASK	(1 << 2)
+#define NFT_SET_ELEM_DEAD_MASK (1 << 2)
 
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_BUSY_BIT	2
+#define NFT_SET_ELEM_DEAD_BIT	2
 #elif defined(__BIG_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_BUSY_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 2)
+#define NFT_SET_ELEM_DEAD_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 2)
 #else
 #error
 #endif
 
-static inline int nft_set_elem_mark_busy(struct nft_set_ext *ext)
+static inline void nft_set_elem_dead(struct nft_set_ext *ext)
 {
 	unsigned long *word = (unsigned long *)ext;
 
 	BUILD_BUG_ON(offsetof(struct nft_set_ext, genmask) != 0);
-	return test_and_set_bit(NFT_SET_ELEM_BUSY_BIT, word);
+	set_bit(NFT_SET_ELEM_DEAD_BIT, word);
 }
 
-static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
+static inline int nft_set_elem_is_dead(const struct nft_set_ext *ext)
 {
 	unsigned long *word = (unsigned long *)ext;
 
-	clear_bit(NFT_SET_ELEM_BUSY_BIT, word);
+	BUILD_BUG_ON(offsetof(struct nft_set_ext, genmask) != 0);
+	return test_bit(NFT_SET_ELEM_DEAD_BIT, word);
 }
 
 /**
@@ -1446,13 +1392,10 @@ struct nft_trans_chain {
 
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
@@ -1487,6 +1430,35 @@ struct nft_trans_flowtable {
 #define nft_trans_flowtable(trans)	\
 	(((struct nft_trans_flowtable *)trans->data)->flowtable)
 
+#define NFT_TRANS_GC_BATCHCOUNT                256
+
+struct nft_trans_gc {
+	struct list_head	list;
+	struct net		*net;
+	struct nft_set		*set;
+	u32			seq;
+	u16			count;
+	void			*priv[NFT_TRANS_GC_BATCHCOUNT];
+	struct rcu_head		rcu;
+};
+
+struct nft_trans_gc *nft_trans_gc_alloc(struct nft_set *set,
+					unsigned int gc_seq, gfp_t gfp);
+void nft_trans_gc_destroy(struct nft_trans_gc *trans);
+
+struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
+					      unsigned int gc_seq, gfp_t gfp);
+void nft_trans_gc_queue_async_done(struct nft_trans_gc *gc);
+
+struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp);
+void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans);
+
+void nft_trans_gc_elem_add(struct nft_trans_gc *gc, void *priv);
+
+void nft_setelem_data_deactivate(const struct net *net,
+				 const struct nft_set *set,
+				 struct nft_set_elem *elem);
+
 int __init nft_chain_filter_init(void);
 void nft_chain_filter_fini(void);
 
@@ -1507,6 +1479,7 @@ struct nftables_pernet {
 	struct mutex		commit_mutex;
 	unsigned int		base_seq;
 	u8			validate_state;
+	unsigned int		gc_seq;
 };
 
 #endif /* _NET_NF_TABLES_H */
diff --git a/include/net/sock.h b/include/net/sock.h
index f73ef7087a18..5293f2b65fb5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1782,21 +1782,33 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
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
 
@@ -1929,7 +1941,7 @@ static inline void dst_negative_advice(struct sock *sk)
 		if (ndst != dst) {
 			rcu_assign_pointer(sk->sk_dst_cache, ndst);
 			sk_tx_queue_clear(sk);
-			sk->sk_dst_pending_confirm = 0;
+			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		}
 	}
 }
@@ -1940,7 +1952,7 @@ __sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = rcu_dereference_protected(sk->sk_dst_cache,
 					    lockdep_sock_is_held(sk));
 	rcu_assign_pointer(sk->sk_dst_cache, dst);
@@ -1953,7 +1965,7 @@ sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = xchg((__force struct dst_entry **)&sk->sk_dst_cache, dst);
 	dst_release(old_dst);
 }
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 0a995403172c..6a08c03a511d 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -162,6 +162,7 @@ enum nft_hook_attributes {
 enum nft_table_flags {
 	NFT_TABLE_F_DORMANT	= 0x1,
 };
+#define NFT_TABLE_F_MASK       (NFT_TABLE_F_DORMANT)
 
 /**
  * enum nft_table_attributes - nf_tables table netlink attributes
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 8a8fd732ff6d..2874ad5d06e4 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -542,11 +542,18 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 530664693ac4..0901911b42b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1469,7 +1469,12 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
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
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index f88611fadb19..1ab2e9703486 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -945,6 +945,9 @@ void kgdb_panic(const char *msg)
 	if (panic_timeout)
 		return;
 
+	debug_locks_off();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
 	if (dbg_kdb_mode)
 		kdb_printf("PANIC: %s\n", msg);
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index ffb59a4ef4ff..fb3edb2f8ac9 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -653,6 +653,12 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
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
index 92a4867e8adc..a544da60014c 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -130,7 +130,7 @@ int padata_do_parallel(struct padata_shell *ps,
 		*cb_cpu = cpu;
 	}
 
-	err =  -EBUSY;
+	err = -EBUSY;
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 5092b8bfa1db..336e56e97b8d 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2377,8 +2377,9 @@ static void *get_highmem_page_buffer(struct page *page,
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
@@ -2558,8 +2559,9 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
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
@@ -2590,8 +2592,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
 
-	handle->sync_read = 1;
-
 	if (!handle->cur) {
 		if (!buffer)
 			/* This makes the buffer be freed by swsusp_free() */
@@ -2632,7 +2632,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			memory_bm_position_reset(&orig_bm);
 			restore_pblist = NULL;
 			handle->buffer = get_buffer(&orig_bm, &ca);
-			handle->sync_read = 0;
 			if (IS_ERR(handle->buffer))
 				return PTR_ERR(handle->buffer);
 		}
@@ -2644,9 +2643,8 @@ int snapshot_write_next(struct snapshot_handle *handle)
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
diff --git a/kernel/reboot.c b/kernel/reboot.c
index ac19159d7158..a9f23d91025d 100644
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
index 85ad403006a2..a15dffe60722 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4257,6 +4257,20 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
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
@@ -4267,6 +4281,7 @@ int tracing_release_file_tr(struct inode *inode, struct file *filp)
 	struct trace_event_file *file = inode->i_private;
 
 	trace_array_put(file->tr);
+	event_file_put(file);
 
 	return 0;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f1f54111b856..40644e06536c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1696,6 +1696,9 @@ extern int register_event_command(struct event_command *cmd);
 extern int unregister_event_command(struct event_command *cmd);
 extern int register_trigger_hist_enable_disable_cmds(void);
 
+extern void event_file_get(struct trace_event_file *file);
+extern void event_file_put(struct trace_event_file *file);
+
 /**
  * struct event_trigger_ops - callbacks for trace event triggers
  *
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4f42dd088079..958789fe4cef 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -698,21 +698,33 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 	}
 }
 
+void event_file_get(struct trace_event_file *file)
+{
+	atomic_inc(&file->ref);
+}
+
+void event_file_put(struct trace_event_file *file)
+{
+	if (WARN_ON_ONCE(!atomic_read(&file->ref))) {
+		if (file->flags & EVENT_FILE_FL_FREED)
+			kmem_cache_free(file_cachep, file);
+		return;
+	}
+
+	if (atomic_dec_and_test(&file->ref)) {
+		/* Count should only go to zero when it is freed */
+		if (WARN_ON_ONCE(!(file->flags & EVENT_FILE_FL_FREED)))
+			return;
+		kmem_cache_free(file_cachep, file);
+	}
+}
+
 static void remove_event_file_dir(struct trace_event_file *file)
 {
 	struct dentry *dir = file->dir;
-	struct dentry *child;
-
-	if (dir) {
-		spin_lock(&dir->d_lock);	/* probably unneeded */
-		list_for_each_entry(child, &dir->d_subdirs, d_child) {
-			if (d_really_is_positive(child))	/* probably unneeded */
-				d_inode(child)->i_private = NULL;
-		}
-		spin_unlock(&dir->d_lock);
 
+	if (dir)
 		tracefs_remove_recursive(dir);
-	}
 
 	list_del(&file->list);
 	remove_subsystem(file->system);
@@ -1033,7 +1045,7 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
 
-	if (!file)
+	if (!file || flags & EVENT_FILE_FL_FREED)
 		return -ENODEV;
 
 	if (flags & EVENT_FILE_FL_ENABLED &&
@@ -1071,7 +1083,7 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
 		file = event_file_data(filp);
-		if (likely(file))
+		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED)))
 			ret = ftrace_event_enable_disable(file, val);
 		mutex_unlock(&event_mutex);
 		break;
@@ -1340,7 +1352,7 @@ event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	file = event_file_data(filp);
-	if (file)
+	if (file && !(file->flags & EVENT_FILE_FL_FREED))
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
@@ -2264,6 +2276,7 @@ trace_create_new_event(struct trace_event_call *call,
 	atomic_set(&file->tm_ref, 0);
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
+	event_file_get(file);
 
 	return file;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index bf44f6bbd0c3..bad8cf24837e 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1800,6 +1800,9 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 	struct event_filter *filter = NULL;
 	int err;
 
+	if (file->flags & EVENT_FILE_FL_FREED)
+		return -ENODEV;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_disable(file);
 		filter = event_filter(file);
diff --git a/mm/cma.c b/mm/cma.c
index 7de520c0a1db..a9635a560094 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -481,7 +481,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	 */
 	if (page) {
 		for (i = 0; i < count; i++)
-			page_kasan_tag_reset(page + i);
+			page_kasan_tag_reset(nth_page(page, i));
 	}
 
 	if (ret && !no_warn) {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index afdc0afa8ee7..e129b7fb6540 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -125,13 +125,11 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
 
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
index 9979cd602dfa..2c3c5df13934 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -545,7 +545,7 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 
 	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
-		sk->sk_dst_pending_confirm = 0;
+		WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
 		dst_release(dst);
 		return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 010743686017..1dce05bfa300 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1103,7 +1103,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	skb_set_hash_from_sk(skb, sk);
 	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
 
-	skb_set_dst_pending_confirm(skb, sk->sk_dst_pending_confirm);
+	skb_set_dst_pending_confirm(skb, READ_ONCE(sk->sk_dst_pending_confirm));
 
 	/* Build TCP header and checksum it. */
 	th = (struct tcphdr *)skb->data;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9e3bff5aaf8b..6428c0d37145 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2581,6 +2581,10 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
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
index 9fc4431242e2..78be121f38ac 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -26,12 +26,15 @@
 #define NFT_MODULE_AUTOLOAD_LIMIT (MODULE_NAME_LEN - sizeof("nft-expr-255-"))
 
 unsigned int nf_tables_net_id __read_mostly;
+EXPORT_SYMBOL_GPL(nf_tables_net_id);
 
 static LIST_HEAD(nf_tables_expressions);
 static LIST_HEAD(nf_tables_objects);
 static LIST_HEAD(nf_tables_flowtables);
 static LIST_HEAD(nf_tables_destroy_list);
+static LIST_HEAD(nf_tables_gc_list);
 static DEFINE_SPINLOCK(nf_tables_destroy_list_lock);
+static DEFINE_SPINLOCK(nf_tables_gc_list_lock);
 static u64 table_handle;
 
 enum {
@@ -88,6 +91,9 @@ static void nft_validate_state_update(struct net *net, u8 new_validate_state)
 static void nf_tables_trans_destroy_work(struct work_struct *w);
 static DECLARE_WORK(trans_destroy_work, nf_tables_trans_destroy_work);
 
+static void nft_trans_gc_work(struct work_struct *work);
+static DECLARE_WORK(trans_gc_work, nft_trans_gc_work);
+
 static void nft_ctx_init(struct nft_ctx *ctx,
 			 struct net *net,
 			 const struct sk_buff *skb,
@@ -213,9 +219,10 @@ static int nf_tables_register_hook(struct net *net,
 	return nf_register_net_hook(net, ops);
 }
 
-static void nf_tables_unregister_hook(struct net *net,
-				      const struct nft_table *table,
-				      struct nft_chain *chain)
+static void __nf_tables_unregister_hook(struct net *net,
+					const struct nft_table *table,
+					struct nft_chain *chain,
+					bool release_netdev)
 {
 	const struct nft_base_chain *basechain;
 	const struct nf_hook_ops *ops;
@@ -230,6 +237,16 @@ static void nf_tables_unregister_hook(struct net *net,
 		return basechain->type->ops_unregister(net, ops);
 
 	nf_unregister_net_hook(net, ops);
+	if (release_netdev &&
+	    table->family == NFPROTO_NETDEV)
+		nft_base_chain(chain)->ops.dev = NULL;
+}
+
+static void nf_tables_unregister_hook(struct net *net,
+				      const struct nft_table *table,
+				      struct nft_chain *chain)
+{
+	__nf_tables_unregister_hook(net, table, chain, false);
 }
 
 static int nft_trans_table_add(struct nft_ctx *ctx, int msg_type)
@@ -403,6 +420,27 @@ static int nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 	return 0;
 }
 
+static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
+				  struct nft_set *set,
+				  const struct nft_set_iter *iter,
+				  struct nft_set_elem *elem)
+{
+	nft_setelem_data_deactivate(ctx->net, set, elem);
+
+	return 0;
+}
+
+static void nft_map_deactivate(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct nft_set_iter iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+		.fn		= nft_mapelem_deactivate,
+	};
+
+	set->ops->walk(ctx, set, &iter);
+	WARN_ON_ONCE(iter.err);
+}
+
 static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	int err;
@@ -411,6 +449,9 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 	if (err < 0)
 		return err;
 
+	if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+		nft_map_deactivate(ctx, set);
+
 	nft_deactivate_next(ctx->net, set);
 	nft_use_dec(&ctx->table->use);
 
@@ -660,7 +701,8 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 		goto nla_put_failure;
 
 	if (nla_put_string(skb, NFTA_TABLE_NAME, table->name) ||
-	    nla_put_be32(skb, NFTA_TABLE_FLAGS, htonl(table->flags)) ||
+	    nla_put_be32(skb, NFTA_TABLE_FLAGS,
+			 htonl(table->flags & NFT_TABLE_F_MASK)) ||
 	    nla_put_be32(skb, NFTA_TABLE_USE, htonl(table->use)) ||
 	    nla_put_be64(skb, NFTA_TABLE_HANDLE, cpu_to_be64(table->handle),
 			 NFTA_TABLE_PAD))
@@ -849,14 +891,22 @@ static int nf_tables_table_enable(struct net *net, struct nft_table *table)
 
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
@@ -868,6 +918,10 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags == ctx->table->flags)
 		return 0;
 
+	/* No dormant off/on/off/on games in single transaction */
+	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
+		return -EINVAL;
+
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWTABLE,
 				sizeof(struct nft_trans_table));
 	if (trans == NULL)
@@ -875,23 +929,27 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 
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
@@ -3810,6 +3868,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	}
 
 	INIT_LIST_HEAD(&set->bindings);
+	refcount_set(&set->refs, 1);
 	set->table = table;
 	write_pnet(&set->net, net);
 	set->ops   = ops;
@@ -3840,7 +3899,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	return 0;
 
 err4:
-	ops->destroy(set);
+	ops->destroy(&ctx, set);
 err3:
 	kfree(set->name);
 err2:
@@ -3852,15 +3911,22 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	return err;
 }
 
-static void nft_set_destroy(struct nft_set *set)
+static void nft_set_put(struct nft_set *set)
+{
+	if (refcount_dec_and_test(&set->refs)) {
+		kfree(set->name);
+		kvfree(set);
+	}
+}
+
+static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	if (WARN_ON(set->use > 0))
 		return;
 
-	set->ops->destroy(set);
+	set->ops->destroy(ctx, set);
 	module_put(to_set_type(set->ops)->owner);
-	kfree(set->name);
-	kvfree(set);
+	nft_set_put(set);
 }
 
 static int nf_tables_delset(struct net *net, struct sock *nlsk,
@@ -3981,10 +4047,39 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	}
 }
 
+static void nft_setelem_data_activate(const struct net *net,
+				      const struct nft_set *set,
+				      struct nft_set_elem *elem);
+
+static int nft_mapelem_activate(const struct nft_ctx *ctx,
+				struct nft_set *set,
+				const struct nft_set_iter *iter,
+				struct nft_set_elem *elem)
+{
+	nft_setelem_data_activate(ctx->net, set, elem);
+
+	return 0;
+}
+
+static void nft_map_activate(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct nft_set_iter iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+		.fn		= nft_mapelem_activate,
+	};
+
+	set->ops->walk(ctx, set, &iter);
+	WARN_ON_ONCE(iter.err);
+}
+
 void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 {
-	if (nft_set_is_anonymous(set))
+	if (nft_set_is_anonymous(set)) {
+		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_activate(ctx, set);
+
 		nft_clear(ctx->net, set);
+	}
 
 	nft_use_inc_restore(&set->use);
 }
@@ -4005,13 +4100,20 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 		nft_use_dec(&set->use);
 		break;
 	case NFT_TRANS_PREPARE:
-		if (nft_set_is_anonymous(set))
-			nft_deactivate_next(ctx->net, set);
+		if (nft_set_is_anonymous(set)) {
+			if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+				nft_map_deactivate(ctx, set);
 
+			nft_deactivate_next(ctx->net, set);
+		}
 		nft_use_dec(&set->use);
 		return;
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
+		if (nft_set_is_anonymous(set) &&
+		    set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_deactivate(ctx, set);
+
 		nft_use_dec(&set->use);
 		/* fall through */
 	default:
@@ -4024,7 +4126,7 @@ EXPORT_SYMBOL_GPL(nf_tables_deactivate_set);
 void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	if (list_empty(&set->bindings) && nft_set_is_anonymous(set))
-		nft_set_destroy(set);
+		nft_set_destroy(ctx, set);
 }
 EXPORT_SYMBOL_GPL(nf_tables_destroy_set);
 
@@ -4194,8 +4296,12 @@ static int nf_tables_dump_setelem(const struct nft_ctx *ctx,
 				  const struct nft_set_iter *iter,
 				  struct nft_set_elem *elem)
 {
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	struct nft_set_dump_args *args;
 
+	if (nft_set_elem_expired(ext))
+		return 0;
+
 	args = container_of(iter, struct nft_set_dump_args, iter);
 	return nf_tables_fill_setelem(args->skb, set, elem);
 }
@@ -4574,6 +4680,7 @@ void *nft_set_elem_init(const struct nft_set *set,
 	return elem;
 }
 
+/* Drop references and destroy. Called from gc, dynset and abort path. */
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr)
 {
@@ -4602,11 +4709,11 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
 
-/* Only called from commit path, nft_set_elem_deactivate() already deals with
- * the refcounting from the preparation phase.
+/* Destroy element. References have been already dropped in the preparation
+ * path via nft_setelem_data_deactivate().
  */
-static void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
-				       const struct nft_set *set, void *elem)
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem)
 {
 	struct nft_set_ext *ext = nft_set_elem_ext(set, elem);
 
@@ -4614,6 +4721,7 @@ static void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
 		nf_tables_expr_destroy(ctx, nft_set_ext_expr(ext));
 	kfree(elem);
 }
+EXPORT_SYMBOL_GPL(nf_tables_set_elem_destroy);
 
 static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr, u32 nlmsg_flags)
@@ -4799,7 +4907,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (trans == NULL)
 		goto err4;
 
-	ext->genmask = nft_genmask_cur(ctx->net) | NFT_SET_ELEM_BUSY_MASK;
+	ext->genmask = nft_genmask_cur(ctx->net);
+
 	err = set->ops->insert(ctx->net, set, &elem, &ext2);
 	if (err) {
 		if (err == -EEXIST) {
@@ -4919,9 +5028,9 @@ void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 	}
 }
 
-static void nft_set_elem_activate(const struct net *net,
-				  const struct nft_set *set,
-				  struct nft_set_elem *elem)
+static void nft_setelem_data_activate(const struct net *net,
+				      const struct nft_set *set,
+				      struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 
@@ -4931,9 +5040,9 @@ static void nft_set_elem_activate(const struct net *net,
 		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
-static void nft_set_elem_deactivate(const struct net *net,
-				    const struct nft_set *set,
-				    struct nft_set_elem *elem)
+void nft_setelem_data_deactivate(const struct net *net,
+				 const struct nft_set *set,
+				 struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 
@@ -4942,6 +5051,7 @@ static void nft_set_elem_deactivate(const struct net *net,
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
 		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 }
+EXPORT_SYMBOL_GPL(nft_setelem_data_deactivate);
 
 static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 			   const struct nlattr *attr)
@@ -5000,7 +5110,7 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	kfree(elem.priv);
 	elem.priv = priv;
 
-	nft_set_elem_deactivate(ctx->net, set, &elem);
+	nft_setelem_data_deactivate(ctx->net, set, &elem);
 
 	nft_trans_elem(trans) = elem;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
@@ -5034,7 +5144,7 @@ static int nft_flush_set(const struct nft_ctx *ctx,
 	}
 	set->ndeact++;
 
-	nft_set_elem_deactivate(ctx->net, set, elem);
+	nft_setelem_data_deactivate(ctx->net, set, elem);
 	nft_trans_elem_set(trans) = set;
 	nft_trans_elem(trans) = *elem;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
@@ -5091,31 +5201,6 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 	return err;
 }
 
-void nft_set_gc_batch_release(struct rcu_head *rcu)
-{
-	struct nft_set_gc_batch *gcb;
-	unsigned int i;
-
-	gcb = container_of(rcu, struct nft_set_gc_batch, head.rcu);
-	for (i = 0; i < gcb->head.cnt; i++)
-		nft_set_elem_destroy(gcb->head.set, gcb->elems[i], true);
-	kfree(gcb);
-}
-EXPORT_SYMBOL_GPL(nft_set_gc_batch_release);
-
-struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
-						gfp_t gfp)
-{
-	struct nft_set_gc_batch *gcb;
-
-	gcb = kzalloc(sizeof(*gcb), gfp);
-	if (gcb == NULL)
-		return gcb;
-	gcb->head.set = set;
-	return gcb;
-}
-EXPORT_SYMBOL_GPL(nft_set_gc_batch_alloc);
-
 /*
  * Stateful objects
  */
@@ -5940,8 +6025,9 @@ nft_flowtable_type_get(struct net *net, u8 family)
 	return ERR_PTR(-ENOENT);
 }
 
-static void nft_unregister_flowtable_net_hooks(struct net *net,
-					       struct nft_flowtable *flowtable)
+static void __nft_unregister_flowtable_net_hooks(struct net *net,
+						 struct nft_flowtable *flowtable,
+						 bool release_netdev)
 {
 	int i;
 
@@ -5950,9 +6036,17 @@ static void nft_unregister_flowtable_net_hooks(struct net *net,
 			continue;
 
 		nf_unregister_net_hook(net, &flowtable->ops[i]);
+		if (release_netdev)
+			flowtable->ops[i].dev = NULL;
 	}
 }
 
+static void nft_unregister_flowtable_net_hooks(struct net *net,
+					       struct nft_flowtable *flowtable)
+{
+	__nft_unregister_flowtable_net_hooks(net, flowtable, false);
+}
+
 static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 				  struct sk_buff *skb,
 				  const struct nlmsghdr *nlh,
@@ -6038,6 +6132,9 @@ static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 			continue;
 
 		list_for_each_entry(ft, &table->flowtables, list) {
+			if (!nft_is_active_next(net, ft))
+				continue;
+
 			for (k = 0; k < ft->ops_len; k++) {
 				if (!ft->ops[k].dev)
 					continue;
@@ -6715,7 +6812,7 @@ static void nft_commit_release(struct nft_trans *trans)
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
 		break;
 	case NFT_MSG_DELSET:
-		nft_set_destroy(nft_trans_set(trans));
+		nft_set_destroy(&trans->ctx, nft_trans_set(trans));
 		break;
 	case NFT_MSG_DELSETELEM:
 		nf_tables_set_elem_destroy(&trans->ctx,
@@ -6894,6 +6991,197 @@ static void nft_chain_del(struct nft_chain *chain)
 	list_del_rcu(&chain->list);
 }
 
+static void nft_trans_gc_setelem_remove(struct nft_ctx *ctx,
+					struct nft_trans_gc *trans)
+{
+	void **priv = trans->priv;
+	unsigned int i;
+
+	for (i = 0; i < trans->count; i++) {
+		struct nft_set_elem elem = {
+			.priv = priv[i],
+		};
+
+		nft_setelem_data_deactivate(ctx->net, trans->set, &elem);
+		trans->set->ops->remove(trans->net, trans->set, &elem);
+	}
+}
+
+void nft_trans_gc_destroy(struct nft_trans_gc *trans)
+{
+	nft_set_put(trans->set);
+	put_net(trans->net);
+	kfree(trans);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_destroy);
+
+static void nft_trans_gc_trans_free(struct rcu_head *rcu)
+{
+	struct nft_set_elem elem = {};
+	struct nft_trans_gc *trans;
+	struct nft_ctx ctx = {};
+	unsigned int i;
+
+	trans = container_of(rcu, struct nft_trans_gc, rcu);
+	ctx.net = read_pnet(&trans->set->net);
+
+	for (i = 0; i < trans->count; i++) {
+		elem.priv = trans->priv[i];
+		atomic_dec(&trans->set->nelems);
+
+		nf_tables_set_elem_destroy(&ctx, trans->set, elem.priv);
+	}
+
+	nft_trans_gc_destroy(trans);
+}
+
+static bool nft_trans_gc_work_done(struct nft_trans_gc *trans)
+{
+	struct nftables_pernet *nft_net;
+	struct nft_ctx ctx = {};
+
+	nft_net = net_generic(trans->net, nf_tables_net_id);
+
+	mutex_lock(&nft_net->commit_mutex);
+
+	/* Check for race with transaction, otherwise this batch refers to
+	 * stale objects that might not be there anymore. Skip transaction if
+	 * set has been destroyed from control plane transaction in case gc
+	 * worker loses race.
+	 */
+	if (READ_ONCE(nft_net->gc_seq) != trans->seq || trans->set->dead) {
+		mutex_unlock(&nft_net->commit_mutex);
+		return false;
+	}
+
+	ctx.net = trans->net;
+	ctx.table = trans->set->table;
+
+	nft_trans_gc_setelem_remove(&ctx, trans);
+	mutex_unlock(&nft_net->commit_mutex);
+
+	return true;
+}
+
+static void nft_trans_gc_work(struct work_struct *work)
+{
+	struct nft_trans_gc *trans, *next;
+	LIST_HEAD(trans_gc_list);
+
+	spin_lock(&nf_tables_gc_list_lock);
+	list_splice_init(&nf_tables_gc_list, &trans_gc_list);
+	spin_unlock(&nf_tables_gc_list_lock);
+
+	list_for_each_entry_safe(trans, next, &trans_gc_list, list) {
+		list_del(&trans->list);
+		if (!nft_trans_gc_work_done(trans)) {
+			nft_trans_gc_destroy(trans);
+			continue;
+		}
+		call_rcu(&trans->rcu, nft_trans_gc_trans_free);
+	}
+}
+
+struct nft_trans_gc *nft_trans_gc_alloc(struct nft_set *set,
+					unsigned int gc_seq, gfp_t gfp)
+{
+	struct net *net = read_pnet(&set->net);
+	struct nft_trans_gc *trans;
+
+	trans = kzalloc(sizeof(*trans), gfp);
+	if (!trans)
+		return NULL;
+
+	trans->net = maybe_get_net(net);
+	if (!trans->net) {
+		kfree(trans);
+		return NULL;
+	}
+
+	refcount_inc(&set->refs);
+	trans->set = set;
+	trans->seq = gc_seq;
+
+	return trans;
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_alloc);
+
+void nft_trans_gc_elem_add(struct nft_trans_gc *trans, void *priv)
+{
+	trans->priv[trans->count++] = priv;
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_elem_add);
+
+static void nft_trans_gc_queue_work(struct nft_trans_gc *trans)
+{
+	spin_lock(&nf_tables_gc_list_lock);
+	list_add_tail(&trans->list, &nf_tables_gc_list);
+	spin_unlock(&nf_tables_gc_list_lock);
+
+	schedule_work(&trans_gc_work);
+}
+
+static int nft_trans_gc_space(struct nft_trans_gc *trans)
+{
+	return NFT_TRANS_GC_BATCHCOUNT - trans->count;
+}
+
+struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
+					      unsigned int gc_seq, gfp_t gfp)
+{
+	struct nft_set *set;
+
+	if (nft_trans_gc_space(gc))
+		return gc;
+
+	set = gc->set;
+	nft_trans_gc_queue_work(gc);
+
+	return nft_trans_gc_alloc(set, gc_seq, gfp);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_queue_async);
+
+void nft_trans_gc_queue_async_done(struct nft_trans_gc *trans)
+{
+	if (trans->count == 0) {
+		nft_trans_gc_destroy(trans);
+		return;
+	}
+
+	nft_trans_gc_queue_work(trans);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_queue_async_done);
+
+struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp)
+{
+	struct nft_set *set;
+
+	if (WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net)))
+		return NULL;
+
+	if (nft_trans_gc_space(gc))
+		return gc;
+
+	set = gc->set;
+	call_rcu(&gc->rcu, nft_trans_gc_trans_free);
+
+	return nft_trans_gc_alloc(set, 0, gfp);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_queue_sync);
+
+void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
+{
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(trans->net));
+
+	if (trans->count == 0) {
+		nft_trans_gc_destroy(trans);
+		return;
+	}
+
+	call_rcu(&trans->rcu, nft_trans_gc_trans_free);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_queue_sync_done);
+
 static void nf_tables_module_autoload_cleanup(struct net *net)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
@@ -6941,6 +7229,22 @@ static void nf_tables_commit_release(struct net *net)
 	mutex_unlock(&nft_net->commit_mutex);
 }
 
+static unsigned int nft_gc_seq_begin(struct nftables_pernet *nft_net)
+{
+	unsigned int gc_seq;
+
+	/* Bump gc counter, it becomes odd, this is the busy mark. */
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+
+	return gc_seq;
+}
+
+static void nft_gc_seq_end(struct nftables_pernet *nft_net, unsigned int gc_seq)
+{
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+}
+
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
@@ -6948,6 +7252,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
 	struct nft_table *table;
+	unsigned int gc_seq;
 	int err;
 
 	if (list_empty(&nft_net->commit_list)) {
@@ -7004,6 +7309,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	while (++nft_net->base_seq == 0)
 		;
 
+	gc_seq = nft_gc_seq_begin(nft_net);
+
 	/* step 3. Start new generation, rules_gen_X now in use. */
 	net->nft.gencursor = nft_gencursor_next(net);
 
@@ -7011,11 +7318,14 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
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
@@ -7081,6 +7391,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_DELSET:
+			nft_trans_set(trans)->dead = 1;
 			list_del_rcu(&nft_trans_set(trans)->list);
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_DELSET, GFP_KERNEL);
@@ -7142,6 +7453,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	}
 
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
+
+	nft_gc_seq_end(nft_net, gc_seq);
 	nf_tables_commit_release(net);
 
 	return 0;
@@ -7176,7 +7489,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
 		break;
 	case NFT_MSG_NEWSET:
-		nft_set_destroy(nft_trans_set(trans));
+		nft_set_destroy(&trans->ctx, nft_trans_set(trans));
 		break;
 	case NFT_MSG_NEWSETELEM:
 		nft_set_elem_destroy(nft_trans_elem_set(trans),
@@ -7207,11 +7520,17 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
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
@@ -7263,6 +7582,8 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_DELSET:
 			nft_use_inc_restore(&trans->ctx.table->use);
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
+			if (nft_trans_set(trans)->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+				nft_map_activate(&trans->ctx, nft_trans_set(trans));
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSETELEM:
@@ -7277,7 +7598,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_DELSETELEM:
 			te = (struct nft_trans_elem *)trans->data;
 
-			nft_set_elem_activate(net, te->set, &te->elem);
+			nft_setelem_data_activate(net, te->set, &te->elem);
 			te->set->ops->activate(net, te->set, &te->elem);
 			te->set->ndeact--;
 
@@ -7331,7 +7652,12 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
-	int ret = __nf_tables_abort(net, action);
+	unsigned int gc_seq;
+	int ret;
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+	ret = __nf_tables_abort(net, action);
+	nft_gc_seq_end(nft_net, gc_seq);
 
 	mutex_unlock(&nft_net->commit_mutex);
 
@@ -7909,16 +8235,24 @@ int __nft_release_basechain(struct nft_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(__nft_release_basechain);
 
+static void __nft_release_hook(struct net *net, struct nft_table *table)
+{
+	struct nft_flowtable *flowtable;
+	struct nft_chain *chain;
+
+	list_for_each_entry(chain, &table->chains, list)
+		__nf_tables_unregister_hook(net, table, chain, true);
+	list_for_each_entry(flowtable, &table->flowtables, list)
+		__nft_unregister_flowtable_net_hooks(net, flowtable, true);
+}
+
 static void __nft_release_hooks(struct net *net)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_table *table;
-	struct nft_chain *chain;
 
-	list_for_each_entry(table, &nft_net->tables, list) {
-		list_for_each_entry(chain, &table->chains, list)
-			nf_tables_unregister_hook(net, table, chain);
-	}
+	list_for_each_entry(table, &nft_net->tables, list)
+		__nft_release_hook(net, table);
 }
 
 static void __nft_release_table(struct net *net, struct nft_table *table)
@@ -7951,7 +8285,10 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	list_for_each_entry_safe(set, ns, &table->sets, list) {
 		list_del(&set->list);
 		nft_use_dec(&table->use);
-		nft_set_destroy(set);
+		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_deactivate(&ctx, set);
+
+		nft_set_destroy(&ctx, set);
 	}
 	list_for_each_entry_safe(obj, ne, &table->objects, list) {
 		nft_obj_del(obj);
@@ -7989,6 +8326,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	mutex_init(&nft_net->commit_mutex);
 	nft_net->base_seq = 1;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
+	nft_net->gc_seq = 0;
 
 	return 0;
 }
@@ -8005,20 +8343,33 @@ static void __net_exit nf_tables_pre_exit_net(struct net *net)
 static void __net_exit nf_tables_exit_net(struct net *net)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+	unsigned int gc_seq;
 
 	mutex_lock(&nft_net->commit_mutex);
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+
 	if (!list_empty(&nft_net->commit_list))
 		__nf_tables_abort(net, NFNL_ABORT_NONE);
 	__nft_release_tables(net);
+
+	nft_gc_seq_end(nft_net, gc_seq);
+
 	mutex_unlock(&nft_net->commit_mutex);
 	WARN_ON_ONCE(!list_empty(&nft_net->tables));
 	WARN_ON_ONCE(!list_empty(&nft_net->module_list));
 }
 
+static void nf_tables_exit_batch(struct list_head *net_exit_list)
+{
+	flush_work(&trans_gc_work);
+}
+
 static struct pernet_operations nf_tables_net_ops = {
 	.init		= nf_tables_init_net,
 	.pre_exit	= nf_tables_pre_exit_net,
 	.exit		= nf_tables_exit_net,
+	.exit_batch	= nf_tables_exit_batch,
 	.id		= &nf_tables_net_id,
 	.size		= sizeof(struct nftables_pernet),
 };
@@ -8083,6 +8434,7 @@ static void __exit nf_tables_module_exit(void)
 	nft_chain_filter_fini();
 	nft_chain_route_fini();
 	unregister_pernet_subsys(&nf_tables_net_ops);
+	cancel_work_sync(&trans_gc_work);
 	cancel_work_sync(&trans_destroy_work);
 	rcu_barrier();
 	rhltable_destroy(&nft_objname_ht);
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 04824d7dcc22..916195dba6f7 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -296,6 +296,9 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
 		if (strcmp(basechain->dev_name, dev->name) != 0)
 			return;
 
+		if (!basechain->ops.dev)
+			return;
+
 		/* UNREGISTER events are also happpening on netns exit.
 		 *
 		 * Altough nf_tables core releases all tables/chains, only
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index 087a056e34d1..b0f6b1490e1a 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -270,13 +270,14 @@ static int nft_bitmap_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_bitmap_destroy(const struct nft_set *set)
+static void nft_bitmap_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_bitmap *priv = nft_set_priv(set);
 	struct nft_bitmap_elem *be, *n;
 
 	list_for_each_entry_safe(be, n, &priv->list, head)
-		nft_set_elem_destroy(set, be, true);
+		nf_tables_set_elem_destroy(ctx, set, be);
 }
 
 static bool nft_bitmap_estimate(const struct nft_set_desc *desc, u32 features,
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index e7eb56b4b89e..0581d5499c5a 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -17,6 +17,9 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
+#include <net/netns/generic.h>
+
+extern unsigned int nf_tables_net_id;
 
 /* We target a hash table size of 4, element hint is 75% of final size */
 #define NFT_RHASH_ELEMENT_HINT 3
@@ -59,6 +62,8 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 
 	if (memcmp(nft_set_ext_key(&he->ext), x->key, x->set->klen))
 		return 1;
+	if (nft_set_elem_is_dead(&he->ext))
+		return 1;
 	if (nft_set_elem_expired(&he->ext))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
@@ -187,7 +192,6 @@ static void nft_rhash_activate(const struct net *net, const struct nft_set *set,
 	struct nft_rhash_elem *he = elem->priv;
 
 	nft_set_elem_change_active(net, set, &he->ext);
-	nft_set_elem_clear_busy(&he->ext);
 }
 
 static bool nft_rhash_flush(const struct net *net,
@@ -195,12 +199,9 @@ static bool nft_rhash_flush(const struct net *net,
 {
 	struct nft_rhash_elem *he = priv;
 
-	if (!nft_set_elem_mark_busy(&he->ext) ||
-	    !nft_is_active(net, &he->ext)) {
-		nft_set_elem_change_active(net, set, &he->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &he->ext);
+
+	return true;
 }
 
 static void *nft_rhash_deactivate(const struct net *net,
@@ -217,9 +218,8 @@ static void *nft_rhash_deactivate(const struct net *net,
 
 	rcu_read_lock();
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
-	if (he != NULL &&
-	    !nft_rhash_flush(net, set, he))
-		he = NULL;
+	if (he)
+		nft_set_elem_change_active(net, set, &he->ext);
 
 	rcu_read_unlock();
 
@@ -251,7 +251,9 @@ static bool nft_rhash_delete(const struct nft_set *set,
 	if (he == NULL)
 		return false;
 
-	return rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params) == 0;
+	nft_set_elem_dead(&he->ext);
+
+	return true;
 }
 
 static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
@@ -277,8 +279,6 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&he->ext))
-			goto cont;
 		if (!nft_set_elem_active(&he->ext, iter->genmask))
 			goto cont;
 
@@ -297,49 +297,77 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 static void nft_rhash_gc(struct work_struct *work)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_set *set;
 	struct nft_rhash_elem *he;
 	struct nft_rhash *priv;
-	struct nft_set_gc_batch *gcb = NULL;
 	struct rhashtable_iter hti;
+	struct nft_trans_gc *gc;
+	struct net *net;
+	u32 gc_seq;
 
 	priv = container_of(work, struct nft_rhash, gc_work.work);
 	set  = nft_set_container_of(priv);
+	net  = read_pnet(&set->net);
+	nft_net = net_generic(net, nf_tables_net_id);
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
 
 	rhashtable_walk_enter(&priv->ht, &hti);
 	rhashtable_walk_start(&hti);
 
 	while ((he = rhashtable_walk_next(&hti))) {
 		if (IS_ERR(he)) {
-			if (PTR_ERR(he) != -EAGAIN)
-				break;
-			continue;
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
 		}
 
+		if (nft_set_elem_is_dead(&he->ext))
+			goto dead_elem;
+
 		if (nft_set_ext_exists(&he->ext, NFT_SET_EXT_EXPR)) {
 			struct nft_expr *expr = nft_set_ext_expr(&he->ext);
 
 			if (expr->ops->gc &&
 			    expr->ops->gc(read_pnet(&set->net), expr))
-				goto gc;
+				goto needs_gc_run;
 		}
 		if (!nft_set_elem_expired(&he->ext))
 			continue;
-gc:
-		if (nft_set_elem_mark_busy(&he->ext))
-			continue;
 
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (gcb == NULL)
-			break;
-		rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params);
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, he);
+needs_gc_run:
+		nft_set_elem_dead(&he->ext);
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
+
+		nft_trans_gc_elem_add(gc, he);
 	}
+
+try_later:
+	/* catchall list iteration requires rcu read side lock. */
 	rhashtable_walk_stop(&hti);
 	rhashtable_walk_exit(&hti);
 
-	nft_set_gc_batch_complete(gcb);
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }
@@ -374,25 +402,36 @@ static int nft_rhash_init(const struct nft_set *set,
 		return err;
 
 	INIT_DEFERRABLE_WORK(&priv->gc_work, nft_rhash_gc);
-	if (set->flags & NFT_SET_TIMEOUT)
+	if (set->flags & (NFT_SET_TIMEOUT | NFT_SET_EVAL))
 		nft_rhash_gc_init(set);
 
 	return 0;
 }
 
+struct nft_rhash_ctx {
+	const struct nft_ctx	ctx;
+	const struct nft_set	*set;
+};
+
 static void nft_rhash_elem_destroy(void *ptr, void *arg)
 {
-	nft_set_elem_destroy(arg, ptr, true);
+	struct nft_rhash_ctx *rhash_ctx = arg;
+
+	nf_tables_set_elem_destroy(&rhash_ctx->ctx, rhash_ctx->set, ptr);
 }
 
-static void nft_rhash_destroy(const struct nft_set *set)
+static void nft_rhash_destroy(const struct nft_ctx *ctx,
+			      const struct nft_set *set)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
+	struct nft_rhash_ctx rhash_ctx = {
+		.ctx	= *ctx,
+		.set	= set,
+	};
 
 	cancel_delayed_work_sync(&priv->gc_work);
-	rcu_barrier();
 	rhashtable_free_and_destroy(&priv->ht, nft_rhash_elem_destroy,
-				    (void *)set);
+				    (void *)&rhash_ctx);
 }
 
 /* Number of buckets is stored in u32, so cap our result to 1U<<31 */
@@ -621,7 +660,8 @@ static int nft_hash_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_hash_destroy(const struct nft_set *set)
+static void nft_hash_destroy(const struct nft_ctx *ctx,
+			     const struct nft_set *set)
 {
 	struct nft_hash *priv = nft_set_priv(set);
 	struct nft_hash_elem *he;
@@ -631,7 +671,7 @@ static void nft_hash_destroy(const struct nft_set *set)
 	for (i = 0; i < priv->buckets; i++) {
 		hlist_for_each_entry_safe(he, next, &priv->table[i], node) {
 			hlist_del_rcu(&he->node);
-			nft_set_elem_destroy(set, he, true);
+			nf_tables_set_elem_destroy(ctx, set, he);
 		}
 	}
 }
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 2c58e9ae0b0e..d9c436fa91b5 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -14,6 +14,9 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
+#include <net/netns/generic.h>
+
+extern unsigned int nf_tables_net_id;
 
 struct nft_rbtree {
 	struct rb_root		root;
@@ -38,10 +41,18 @@ static bool nft_rbtree_interval_start(const struct nft_rbtree_elem *rbe)
 	return !nft_rbtree_interval_end(rbe);
 }
 
-static bool nft_rbtree_equal(const struct nft_set *set, const void *this,
-			     const struct nft_rbtree_elem *interval)
+static int nft_rbtree_cmp(const struct nft_set *set,
+			  const struct nft_rbtree_elem *e1,
+			  const struct nft_rbtree_elem *e2)
+{
+	return memcmp(nft_set_ext_key(&e1->ext), nft_set_ext_key(&e2->ext),
+		      set->klen);
+}
+
+static bool nft_rbtree_elem_expired(const struct nft_rbtree_elem *rbe)
 {
-	return memcmp(this, nft_set_ext_key(&interval->ext), set->klen) == 0;
+	return nft_set_elem_expired(&rbe->ext) ||
+	       nft_set_elem_is_dead(&rbe->ext);
 }
 
 static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
@@ -52,7 +63,6 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 	const struct nft_rbtree_elem *rbe, *interval = NULL;
 	u8 genmask = nft_genmask_cur(net);
 	const struct rb_node *parent;
-	const void *this;
 	int d;
 
 	parent = rcu_dereference_raw(priv->root.rb_node);
@@ -62,12 +72,11 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 
 		rbe = rb_entry(parent, struct nft_rbtree_elem, node);
 
-		this = nft_set_ext_key(&rbe->ext);
-		d = memcmp(this, key, set->klen);
+		d = memcmp(nft_set_ext_key(&rbe->ext), key, set->klen);
 		if (d < 0) {
 			parent = rcu_dereference_raw(parent->rb_left);
 			if (interval &&
-			    nft_rbtree_equal(set, this, interval) &&
+			    !nft_rbtree_cmp(set, rbe, interval) &&
 			    nft_rbtree_interval_end(rbe) &&
 			    nft_rbtree_interval_start(interval))
 				continue;
@@ -80,7 +89,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 				continue;
 			}
 
-			if (nft_set_elem_expired(&rbe->ext))
+			if (nft_rbtree_elem_expired(rbe))
 				return false;
 
 			if (nft_rbtree_interval_end(rbe)) {
@@ -98,7 +107,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 
 	if (set->flags & NFT_SET_INTERVAL && interval != NULL &&
 	    nft_set_elem_active(&interval->ext, genmask) &&
-	    !nft_set_elem_expired(&interval->ext) &&
+	    !nft_rbtree_elem_expired(interval) &&
 	    nft_rbtree_interval_start(interval)) {
 		*ext = &interval->ext;
 		return true;
@@ -214,43 +223,258 @@ static void *nft_rbtree_get(const struct net *net, const struct nft_set *set,
 	return rbe;
 }
 
+static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
+				 struct nft_rbtree *priv,
+				 struct nft_rbtree_elem *rbe)
+{
+	struct nft_set_elem elem = {
+		.priv	= rbe,
+	};
+
+	nft_setelem_data_deactivate(net, set, &elem);
+	rb_erase(&rbe->node, &priv->root);
+}
+
+static int nft_rbtree_gc_elem(const struct nft_set *__set,
+			      struct nft_rbtree *priv,
+			      struct nft_rbtree_elem *rbe,
+			      u8 genmask)
+{
+	struct nft_set *set = (struct nft_set *)__set;
+	struct rb_node *prev = rb_prev(&rbe->node);
+	struct net *net = read_pnet(&set->net);
+	struct nft_rbtree_elem *rbe_prev;
+	struct nft_trans_gc *gc;
+
+	gc = nft_trans_gc_alloc(set, 0, GFP_ATOMIC);
+	if (!gc)
+		return -ENOMEM;
+
+	/* search for end interval coming before this element.
+	 * end intervals don't carry a timeout extension, they
+	 * are coupled with the interval start element.
+	 */
+	while (prev) {
+		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+		if (nft_rbtree_interval_end(rbe_prev) &&
+		    nft_set_elem_active(&rbe_prev->ext, genmask))
+			break;
+
+		prev = rb_prev(prev);
+	}
+
+	if (prev) {
+		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+		nft_rbtree_gc_remove(net, set, priv, rbe_prev);
+
+		/* There is always room in this trans gc for this element,
+		 * memory allocation never actually happens, hence, the warning
+		 * splat in such case. No need to set NFT_SET_ELEM_DEAD_BIT,
+		 * this is synchronous gc which never fails.
+		 */
+		gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+		if (WARN_ON_ONCE(!gc))
+			return -ENOMEM;
+
+		nft_trans_gc_elem_add(gc, rbe_prev);
+	}
+
+	nft_rbtree_gc_remove(net, set, priv, rbe);
+	gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+	if (WARN_ON_ONCE(!gc))
+		return -ENOMEM;
+
+	nft_trans_gc_elem_add(gc, rbe);
+
+	nft_trans_gc_queue_sync_done(gc);
+
+	return 0;
+}
+
+static bool nft_rbtree_update_first(const struct nft_set *set,
+				    struct nft_rbtree_elem *rbe,
+				    struct rb_node *first)
+{
+	struct nft_rbtree_elem *first_elem;
+
+	first_elem = rb_entry(first, struct nft_rbtree_elem, node);
+	/* this element is closest to where the new element is to be inserted:
+	 * update the first element for the node list path.
+	 */
+	if (nft_rbtree_cmp(set, rbe, first_elem) < 0)
+		return true;
+
+	return false;
+}
+
 static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			       struct nft_rbtree_elem *new,
 			       struct nft_set_ext **ext)
 {
+	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL;
+	struct rb_node *node, *next, *parent, **p, *first = NULL;
 	struct nft_rbtree *priv = nft_set_priv(set);
+	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
-	struct nft_rbtree_elem *rbe;
-	struct rb_node *parent, **p;
-	int d;
+	int d, err;
 
+	/* Descend the tree to search for an existing element greater than the
+	 * key value to insert that is greater than the new element. This is the
+	 * first element to walk the ordered elements to find possible overlap.
+	 */
 	parent = NULL;
 	p = &priv->root.rb_node;
 	while (*p != NULL) {
 		parent = *p;
 		rbe = rb_entry(parent, struct nft_rbtree_elem, node);
-		d = memcmp(nft_set_ext_key(&rbe->ext),
-			   nft_set_ext_key(&new->ext),
-			   set->klen);
-		if (d < 0)
+		d = nft_rbtree_cmp(set, rbe, new);
+
+		if (d < 0) {
 			p = &parent->rb_left;
-		else if (d > 0)
+		} else if (d > 0) {
+			if (!first ||
+			    nft_rbtree_update_first(set, rbe, first))
+				first = &rbe->node;
+
 			p = &parent->rb_right;
-		else {
-			if (nft_rbtree_interval_end(rbe) &&
-			    nft_rbtree_interval_start(new)) {
+		} else {
+			if (nft_rbtree_interval_end(rbe))
 				p = &parent->rb_left;
-			} else if (nft_rbtree_interval_start(rbe) &&
-				   nft_rbtree_interval_end(new)) {
+			else
 				p = &parent->rb_right;
-			} else if (nft_set_elem_active(&rbe->ext, genmask)) {
-				*ext = &rbe->ext;
-				return -EEXIST;
-			} else {
-				p = &parent->rb_left;
+		}
+	}
+
+	if (!first)
+		first = rb_first(&priv->root);
+
+	/* Detect overlap by going through the list of valid tree nodes.
+	 * Values stored in the tree are in reversed order, starting from
+	 * highest to lowest value.
+	 */
+	for (node = first; node != NULL; node = next) {
+		next = rb_next(node);
+
+		rbe = rb_entry(node, struct nft_rbtree_elem, node);
+
+		if (!nft_set_elem_active(&rbe->ext, genmask))
+			continue;
+
+		/* perform garbage collection to avoid bogus overlap reports
+		 * but skip new elements in this transaction.
+		 */
+		if (nft_set_elem_expired(&rbe->ext) &&
+		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
+			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
+			if (err < 0)
+				return err;
+
+			continue;
+		}
+
+		d = nft_rbtree_cmp(set, rbe, new);
+		if (d == 0) {
+			/* Matching end element: no need to look for an
+			 * overlapping greater or equal element.
+			 */
+			if (nft_rbtree_interval_end(rbe)) {
+				rbe_le = rbe;
+				break;
+			}
+
+			/* first element that is greater or equal to key value. */
+			if (!rbe_ge) {
+				rbe_ge = rbe;
+				continue;
+			}
+
+			/* this is a closer more or equal element, update it. */
+			if (nft_rbtree_cmp(set, rbe_ge, new) != 0) {
+				rbe_ge = rbe;
+				continue;
+			}
+
+			/* element is equal to key value, make sure flags are
+			 * the same, an existing more or equal start element
+			 * must not be replaced by more or equal end element.
+			 */
+			if ((nft_rbtree_interval_start(new) &&
+			     nft_rbtree_interval_start(rbe_ge)) ||
+			    (nft_rbtree_interval_end(new) &&
+			     nft_rbtree_interval_end(rbe_ge))) {
+				rbe_ge = rbe;
+				continue;
 			}
+		} else if (d > 0) {
+			/* annotate element greater than the new element. */
+			rbe_ge = rbe;
+			continue;
+		} else if (d < 0) {
+			/* annotate element less than the new element. */
+			rbe_le = rbe;
+			break;
 		}
 	}
+
+	/* - new start element matching existing start element: full overlap
+	 *   reported as -EEXIST, cleared by caller if NLM_F_EXCL is not given.
+	 */
+	if (rbe_ge && !nft_rbtree_cmp(set, new, rbe_ge) &&
+	    nft_rbtree_interval_start(rbe_ge) == nft_rbtree_interval_start(new)) {
+		*ext = &rbe_ge->ext;
+		return -EEXIST;
+	}
+
+	/* - new end element matching existing end element: full overlap
+	 *   reported as -EEXIST, cleared by caller if NLM_F_EXCL is not given.
+	 */
+	if (rbe_le && !nft_rbtree_cmp(set, new, rbe_le) &&
+	    nft_rbtree_interval_end(rbe_le) == nft_rbtree_interval_end(new)) {
+		*ext = &rbe_le->ext;
+		return -EEXIST;
+	}
+
+	/* - new start element with existing closest, less or equal key value
+	 *   being a start element: partial overlap, reported as -ENOTEMPTY.
+	 *   Anonymous sets allow for two consecutive start element since they
+	 *   are constant, skip them to avoid bogus overlap reports.
+	 */
+	if (!nft_set_is_anonymous(set) && rbe_le &&
+	    nft_rbtree_interval_start(rbe_le) && nft_rbtree_interval_start(new))
+		return -ENOTEMPTY;
+
+	/* - new end element with existing closest, less or equal key value
+	 *   being a end element: partial overlap, reported as -ENOTEMPTY.
+	 */
+	if (rbe_le &&
+	    nft_rbtree_interval_end(rbe_le) && nft_rbtree_interval_end(new))
+		return -ENOTEMPTY;
+
+	/* - new end element with existing closest, greater or equal key value
+	 *   being an end element: partial overlap, reported as -ENOTEMPTY
+	 */
+	if (rbe_ge &&
+	    nft_rbtree_interval_end(rbe_ge) && nft_rbtree_interval_end(new))
+		return -ENOTEMPTY;
+
+	/* Accepted element: pick insertion point depending on key value */
+	parent = NULL;
+	p = &priv->root.rb_node;
+	while (*p != NULL) {
+		parent = *p;
+		rbe = rb_entry(parent, struct nft_rbtree_elem, node);
+		d = nft_rbtree_cmp(set, rbe, new);
+
+		if (d < 0)
+			p = &parent->rb_left;
+		else if (d > 0)
+			p = &parent->rb_right;
+		else if (nft_rbtree_interval_end(rbe))
+			p = &parent->rb_left;
+		else
+			p = &parent->rb_right;
+	}
+
 	rb_link_node_rcu(&new->node, parent, p);
 	rb_insert_color(&new->node, &priv->root);
 	return 0;
@@ -294,7 +518,6 @@ static void nft_rbtree_activate(const struct net *net,
 	struct nft_rbtree_elem *rbe = elem->priv;
 
 	nft_set_elem_change_active(net, set, &rbe->ext);
-	nft_set_elem_clear_busy(&rbe->ext);
 }
 
 static bool nft_rbtree_flush(const struct net *net,
@@ -302,12 +525,9 @@ static bool nft_rbtree_flush(const struct net *net,
 {
 	struct nft_rbtree_elem *rbe = priv;
 
-	if (!nft_set_elem_mark_busy(&rbe->ext) ||
-	    !nft_is_active(net, &rbe->ext)) {
-		nft_set_elem_change_active(net, set, &rbe->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &rbe->ext);
+
+	return true;
 }
 
 static void *nft_rbtree_deactivate(const struct net *net,
@@ -366,8 +586,6 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&rbe->ext))
-			goto cont;
 		if (!nft_set_elem_active(&rbe->ext, iter->genmask))
 			goto cont;
 
@@ -386,26 +604,42 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 static void nft_rbtree_gc(struct work_struct *work)
 {
-	struct nft_rbtree_elem *rbe, *rbe_end = NULL, *rbe_prev = NULL;
-	struct nft_set_gc_batch *gcb = NULL;
+	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
+	struct nftables_pernet *nft_net;
 	struct nft_rbtree *priv;
+	struct nft_trans_gc *gc;
 	struct rb_node *node;
 	struct nft_set *set;
+	unsigned int gc_seq;
 	struct net *net;
-	u8 genmask;
 
 	priv = container_of(work, struct nft_rbtree, gc_work.work);
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
-	genmask = nft_genmask_cur(net);
+	nft_net = net_generic(net, nf_tables_net_id);
+	gc_seq  = READ_ONCE(nft_net->gc_seq);
 
-	write_lock_bh(&priv->lock);
-	write_seqcount_begin(&priv->count);
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
+
+	read_lock_bh(&priv->lock);
 	for (node = rb_first(&priv->root); node != NULL; node = rb_next(node)) {
+
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
 
-		if (!nft_set_elem_active(&rbe->ext, genmask))
-			continue;
+		if (nft_set_elem_is_dead(&rbe->ext))
+			goto dead_elem;
 
 		/* elements are reversed in the rbtree for historical reasons,
 		 * from highest to lowest value, that is why end element is
@@ -415,43 +649,37 @@ static void nft_rbtree_gc(struct work_struct *work)
 			rbe_end = rbe;
 			continue;
 		}
+
 		if (!nft_set_elem_expired(&rbe->ext))
 			continue;
 
-		if (nft_set_elem_mark_busy(&rbe->ext)) {
-			rbe_end = NULL;
+		nft_set_elem_dead(&rbe->ext);
+
+		if (!rbe_end)
 			continue;
-		}
 
-		if (rbe_prev) {
-			rb_erase(&rbe_prev->node, &priv->root);
-			rbe_prev = NULL;
-		}
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (!gcb)
-			break;
+		nft_set_elem_dead(&rbe_end->ext);
 
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, rbe);
-		rbe_prev = rbe;
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
 
-		if (rbe_end) {
-			atomic_dec(&set->nelems);
-			nft_set_gc_batch_add(gcb, rbe_end);
-			rb_erase(&rbe_end->node, &priv->root);
-			rbe_end = NULL;
-		}
-		node = rb_next(node);
-		if (!node)
-			break;
+		nft_trans_gc_elem_add(gc, rbe_end);
+		rbe_end = NULL;
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
+
+		nft_trans_gc_elem_add(gc, rbe);
 	}
-	if (rbe_prev)
-		rb_erase(&rbe_prev->node, &priv->root);
-	write_seqcount_end(&priv->count);
-	write_unlock_bh(&priv->lock);
 
-	nft_set_gc_batch_complete(gcb);
+try_later:
+	read_unlock_bh(&priv->lock);
 
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }
@@ -480,7 +708,8 @@ static int nft_rbtree_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_rbtree_destroy(const struct nft_set *set)
+static void nft_rbtree_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe;
@@ -491,7 +720,7 @@ static void nft_rbtree_destroy(const struct nft_set *set)
 	while ((node = priv->root.rb_node) != NULL) {
 		rb_erase(node, &priv->root);
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
-		nft_set_elem_destroy(set, rbe, true);
+		nf_tables_set_elem_destroy(ctx, set, rbe);
 	}
 }
 
diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index bef28e900b3e..5c61b8ee7fc0 100644
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
diff --git a/sound/core/info.c b/sound/core/info.c
index d670bd5dd7a9..a68a9689ac06 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -57,7 +57,7 @@ struct snd_info_private_data {
 };
 
 static int snd_info_version_init(void);
-static void snd_info_disconnect(struct snd_info_entry *entry);
+static void snd_info_clear_entries(struct snd_info_entry *entry);
 
 /*
 
@@ -572,11 +572,16 @@ void snd_info_card_disconnect(struct snd_card *card)
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
 
@@ -748,15 +753,14 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
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
 
@@ -773,8 +777,9 @@ void snd_info_free_entry(struct snd_info_entry * entry)
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
index 2beb94828729..f810f401c1de 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -313,8 +313,10 @@ struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
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
index c0bcbab7b656..15413b41dd82 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8242,6 +8242,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x10c0, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x10d0, "ASUS X540LA/X540LJ", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x10d3, "ASUS K6500ZC", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 3273b317fa3b..3e8ed05f3ebd 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -74,7 +74,8 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 		return -EINVAL;
 	}
 
-	pm_runtime_put_sync(mcbsp->dev);
+	if (mcbsp->active)
+		pm_runtime_put_sync(mcbsp->dev);
 
 	r = clk_set_parent(mcbsp->fclk, fck_src);
 	if (r) {
@@ -84,7 +85,8 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 		return r;
 	}
 
-	pm_runtime_get_sync(mcbsp->dev);
+	if (mcbsp->active)
+		pm_runtime_get_sync(mcbsp->dev);
 
 	clk_put(fck_src);
 
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8bf6b01b3560..d4235d1ab912 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1881,7 +1881,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
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
