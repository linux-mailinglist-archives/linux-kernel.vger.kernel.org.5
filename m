Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4844D7FC154
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345254AbjK1RLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345259AbjK1RKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:10:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A054210E7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:10:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2B3C433C7;
        Tue, 28 Nov 2023 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701191453;
        bh=iM+xZst1VjqFpl93EFJuL7dnDJZW/yzYtTzRVqc2mUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgtT1szd3vUdCUlqJpV3ZYI1mTMKbNOJKIOhoS4SuIt3V7tkOK1ldeu9biRp53Nxc
         tDHjoLRzUo3tDWMn17xaJCxe3/b9I3ge9Q092hJ0/ttyMFBGIh/cM16tib0OmuapEW
         See4gGia5PbhJuKYNjRJ5kKFzh8g6oVFUkSf16M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.300
Date:   Tue, 28 Nov 2023 17:10:41 +0000
Message-ID: <2023112841-epic-cornhusk-c90a@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023112841-myspace-outsell-affd@gregkh>
References: <2023112841-myspace-outsell-affd@gregkh>
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
index 84a44cc190ae..74741cde46b2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 299
+SUBLEVEL = 300
 EXTRAVERSION =
 NAME = "People's Front"
 
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
index 593eeb573138..786c65954ec4 100644
--- a/arch/parisc/include/uapi/asm/pdc.h
+++ b/arch/parisc/include/uapi/asm/pdc.h
@@ -443,6 +443,7 @@ struct pdc_model {		/* for PDC_MODEL */
 	unsigned long arch_rev;
 	unsigned long pot_key;
 	unsigned long curr_key;
+	unsigned long width;	/* default of PSW_W bit (1=enabled) */
 };
 
 struct pdc_cache_cf {		/* for PDC_CACHE  (I/D-caches) */
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index e8b503cd54f5..a0c251c4f302 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -522,13 +522,13 @@
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
@@ -536,8 +536,7 @@
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
index 92bc2fa7e692..efa078b3aa45 100644
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
index 2ee7b3e0dcc1..4be36bfb2477 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -414,6 +414,7 @@
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d7a9b07ce0b8..0548ae57826f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2460,6 +2460,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 		break;
 
@@ -2763,6 +2764,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 		msr_info->data = 0;
 		break;
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index b4ff063a4371..a830d49341ec 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -585,13 +585,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
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
index 62e11835f220..1e9de81ef84f 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -174,6 +174,8 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 	err = pcrypt_do_parallel(padata, &ctx->cb_cpu, &pencrypt);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
@@ -218,6 +220,8 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 	err = pcrypt_do_parallel(padata, &ctx->cb_cpu, &pdecrypt);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 827c6d5e6177..b6d8c2660e4a 100644
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
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index ee41aec106ac..eff38d22738c 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -431,7 +431,6 @@ static struct clk_fixed_factor gpll0_out_main_div2 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -478,7 +477,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -511,7 +509,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -545,7 +542,6 @@ static struct clk_alpha_pll_postdiv gpll6 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -559,7 +555,6 @@ static struct clk_fixed_factor gpll6_out_main_div2 = {
 		},
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -624,7 +619,6 @@ static struct clk_alpha_pll_postdiv nss_crypto_pll = {
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 43f4d5c4d6fa..998d9115add6 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -294,6 +294,7 @@ static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
 	writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP		/* free-run */
+			| ATMEL_TC_ASWTRG_SET		/* TIOA0 rises at software trigger */
 			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
 			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
 			tcaddr + ATMEL_TC_REG(0, CMR));
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 165fbbb1c9a0..0e67026d782f 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -473,12 +473,16 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
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
 
@@ -491,11 +495,15 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
 
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
index ad9be6ed47a3..e18090f83bec 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -520,7 +520,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 	src_maxburst = chan->dma_config.src_maxburst;
 	dst_maxburst = chan->dma_config.dst_maxburst;
 
-	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
+	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
 	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
 	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
 
@@ -948,7 +948,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 	if (!desc)
 		return NULL;
 
-	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
+	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
 	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
 	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index fda8d68a87fd..b9a94c431f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -168,6 +168,7 @@ int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
 	}
 
 	rcu_read_unlock();
+	*result = NULL;
 	return -ENOENT;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index ee4a0b7cb452..41a9cc9e0f9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -391,6 +391,9 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_rreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
@@ -430,6 +433,9 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_wreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index fdcc8ab19bf3..25b8a8f93382 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -281,7 +281,7 @@ uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		return tg->funcs->get_frame_count(tg);
@@ -305,7 +305,7 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
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
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a9d6f8acf70b..93faf083e550 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -343,6 +343,7 @@
 
 #define USB_VENDOR_ID_DELL				0x413c
 #define USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE	0x301a
+#define USB_DEVICE_ID_DELL_PRO_WIRELESS_KM5221W		0x4503
 
 #define USB_VENDOR_ID_DELORME		0x1163
 #define USB_DEVICE_ID_DELORME_EARTHMATE	0x0100
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index a2ab338166e6..0b85f95810b3 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -68,6 +68,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_STRAFE), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_PRO_WIRELESS_KM5221W), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES), HID_QUIRK_MULTI_INPUT },
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 6017f6aeee89..c18b899e510e 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -712,15 +712,11 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
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
@@ -743,9 +739,12 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
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
diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index a8dd12e525f8..e1b6da777558 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -45,6 +45,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -273,12 +274,6 @@ static u32 extract_speed(u16 linkstat)
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
@@ -291,7 +286,7 @@ static void update_lbus_info(struct hfi1_devdata *dd)
 		return;
 	}
 
-	dd->lbus_width = extract_width(linkstat);
+	dd->lbus_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);
 	dd->lbus_speed = extract_speed(linkstat);
 	snprintf(dd->lbus_info, sizeof(dd->lbus_info),
 		 "PCIe,%uMHz,x%u", dd->lbus_speed, dd->lbus_width);
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 6e7e91387f3c..c8c6d217aaa9 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -251,6 +251,7 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev)
 	return 0;
 
 out:
+	put_device(&dev->dev);
 
 	return ret;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index b7354232221e..6bb6be4bb40a 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -105,7 +105,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	return 0;
 
 err:
-	put_device(&mdev->dev);
+	mcb_free_dev(mdev);
 
 	return ret;
 }
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 0ecdaa15c296..24a6e4ecf77d 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -359,7 +359,7 @@ session_get_prop_buf_req(struct hfi_msg_session_property_info_pkt *pkt,
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
index fbcc67c10993..b1bca3bf9dc9 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -220,6 +220,11 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 
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
@@ -287,6 +292,11 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
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
index 39ca9a56448c..9f6009ac5e25 100644
--- a/drivers/media/platform/vivid/vivid-rds-gen.c
+++ b/drivers/media/platform/vivid/vivid-rds-gen.c
@@ -145,7 +145,7 @@ void vivid_rds_gen_fill(struct vivid_rds_gen *rds, unsigned freq,
 	rds->ta = alt;
 	rds->ms = true;
 	snprintf(rds->psname, sizeof(rds->psname), "%6d.%1d",
-		 freq / 16, ((freq & 0xf) * 10) / 16);
+		 (freq / 16) % 1000000, (((freq & 0xf) * 10) / 16) % 10);
 	if (alt)
 		strlcpy(rds->radiotext,
 			" The Radio Data System can switch between different Radio Texts ",
diff --git a/drivers/media/rc/ir-sharp-decoder.c b/drivers/media/rc/ir-sharp-decoder.c
index f96e0c992eed..dbddf987df97 100644
--- a/drivers/media/rc/ir-sharp-decoder.c
+++ b/drivers/media/rc/ir-sharp-decoder.c
@@ -23,7 +23,9 @@
 #define SHARP_UNIT		40000  /* ns */
 #define SHARP_BIT_PULSE		(8    * SHARP_UNIT) /* 320us */
 #define SHARP_BIT_0_PERIOD	(25   * SHARP_UNIT) /* 1ms (680us space) */
-#define SHARP_BIT_1_PERIOD	(50   * SHARP_UNIT) /* 2ms (1680ms space) */
+#define SHARP_BIT_1_PERIOD	(50   * SHARP_UNIT) /* 2ms (1680us space) */
+#define SHARP_BIT_0_SPACE	(17   * SHARP_UNIT) /* 680us space */
+#define SHARP_BIT_1_SPACE	(42   * SHARP_UNIT) /* 1680us space */
 #define SHARP_ECHO_SPACE	(1000 * SHARP_UNIT) /* 40 ms */
 #define SHARP_TRAILER_SPACE	(125  * SHARP_UNIT) /* 5 ms (even longer) */
 
@@ -176,8 +178,8 @@ static const struct ir_raw_timings_pd ir_sharp_timings = {
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
index d6f5f5b3f75f..b71792f49117 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -302,7 +302,11 @@ static ssize_t ir_lirc_transmit_ir(struct file *file, const char __user *buf,
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
index 2b09af8865f4..5e785343528c 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -28,6 +28,7 @@
 
 #include <linux/input.h>
 #include <linux/sched/signal.h>
+#include <linux/bitops.h>
 
 #include "gspca.h"
 
@@ -1033,6 +1034,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
 			sd->params.exposure.expMode = 2;
 			sd->exposure_status = EXPOSURE_NORMAL;
 		}
+		if (sd->params.exposure.gain >= BITS_PER_TYPE(currentexp))
+			return -EINVAL;
 		currentexp = currentexp << sd->params.exposure.gain;
 		sd->params.exposure.gain = 0;
 		/* round down current exposure to nearest value */
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 28f07d410043..12441faa2808 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -931,7 +931,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
 	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
-	cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
 
 	meson_mmc_set_response_bits(cmd, &cmd_cfg);
 
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 5a985a0d9d85..1d08318bd707 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2321,6 +2321,7 @@ static int vub300_probe(struct usb_interface *interface,
 		vub300->read_only =
 			(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	} else {
+		retval = -EINVAL;
 		goto error5;
 	}
 	usb_set_intfdata(interface, vub300);
diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdio.c
index cc9c2ea1c4fe..d2c463ae0041 100644
--- a/drivers/net/dsa/lan9303_mdio.c
+++ b/drivers/net/dsa/lan9303_mdio.c
@@ -41,7 +41,7 @@ static int lan9303_mdio_write(void *ctx, uint32_t reg, uint32_t val)
 	struct lan9303_mdio *sw_dev = (struct lan9303_mdio *)ctx;
 
 	reg <<= 2; /* reg num to offset */
-	mutex_lock(&sw_dev->device->bus->mdio_lock);
+	mutex_lock_nested(&sw_dev->device->bus->mdio_lock, MDIO_MUTEX_NESTED);
 	lan9303_mdio_real_write(sw_dev->device, reg, val & 0xffff);
 	lan9303_mdio_real_write(sw_dev->device, reg + 2, (val >> 16) & 0xffff);
 	mutex_unlock(&sw_dev->device->bus->mdio_lock);
@@ -59,7 +59,7 @@ static int lan9303_mdio_read(void *ctx, uint32_t reg, uint32_t *val)
 	struct lan9303_mdio *sw_dev = (struct lan9303_mdio *)ctx;
 
 	reg <<= 2; /* reg num to offset */
-	mutex_lock(&sw_dev->device->bus->mdio_lock);
+	mutex_lock_nested(&sw_dev->device->bus->mdio_lock, MDIO_MUTEX_NESTED);
 	*val = lan9303_mdio_real_read(sw_dev->device, reg);
 	*val |= (lan9303_mdio_real_read(sw_dev->device, reg + 2) << 16);
 	mutex_unlock(&sw_dev->device->bus->mdio_lock);
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index f8a3d1fecb0a..b7ebe5eb46f5 100644
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
@@ -1153,6 +1153,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1167,9 +1168,30 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
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
@@ -1997,15 +2019,6 @@ static int gmac_change_mtu(struct net_device *netdev, int new_mtu)
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
@@ -2226,7 +2239,6 @@ static const struct net_device_ops gmac_351x_ops = {
 	.ndo_set_mac_address	= gmac_set_mac_address,
 	.ndo_get_stats64	= gmac_get_stats64,
 	.ndo_change_mtu		= gmac_change_mtu,
-	.ndo_fix_features	= gmac_fix_features,
 	.ndo_set_features	= gmac_set_features,
 };
 
@@ -2482,11 +2494,12 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
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
index 0b12f89bf89a..ad913f15e89b 100644
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
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d6b01f34cfa4..ecdf628e3bb8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4628,9 +4628,7 @@ static void rtl_set_rx_mode(struct net_device *dev)
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
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index ecb10fb249af..34126abb28d8 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -418,7 +418,7 @@ static struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port,
 	return addr;
 }
 
-static int ipvlan_process_v4_outbound(struct sk_buff *skb)
+static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 {
 	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net_device *dev = skb->dev;
@@ -460,13 +460,11 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
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
@@ -476,27 +474,38 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
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
index e1f95fd08d72..29d5fd46c09a 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -769,7 +769,7 @@ static void macvlan_change_rx_flags(struct net_device *dev, int change)
 	if (dev->flags & IFF_UP) {
 		if (change & IFF_ALLMULTI)
 			dev_set_allmulti(lowerdev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
+		if (!macvlan_passthru(vlan->port) && change & IFF_PROMISC)
 			dev_set_promiscuity(lowerdev,
 					    dev->flags & IFF_PROMISC ? 1 : -1);
 
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 047f6c68a441..7a1b903d3fb8 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -467,6 +467,10 @@ ppp_sync_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
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
@@ -702,7 +706,7 @@ ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
 
 	/* strip address/control field if present */
 	p = skb->data;
-	if (p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
+	if (skb->len >= 2 && p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
 		/* chop off address/control */
 		if (skb->len < 3)
 			goto err;
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 4e980e78ba95..9586deab5c00 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1146,7 +1146,7 @@ void ath10k_debug_get_et_strings(struct ieee80211_hw *hw,
 				 u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath10k_gstrings_stats,
+		memcpy(data, ath10k_gstrings_stats,
 		       sizeof(ath10k_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 84fe68670949..e0a4e3fa8730 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1297,7 +1297,7 @@ void ath9k_get_et_strings(struct ieee80211_hw *hw,
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
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 765357b87ff6..5fa7c0f09fa5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -376,7 +376,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = ks_dw_pcie_link_up,
 };
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static int ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 
@@ -385,7 +385,7 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __init ks_pcie_probe(struct platform_device *pdev)
+static int ks_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
@@ -452,9 +452,9 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_driver ks_pcie_driver __refdata = {
+static struct platform_driver ks_pcie_driver = {
 	.probe  = ks_pcie_probe,
-	.remove = __exit_p(ks_pcie_remove),
+	.remove = ks_pcie_remove,
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = of_match_ptr(ks_pcie_of_match),
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 2c46f7dcd2f5..2777c459706a 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -496,7 +496,7 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state, d_max;
 
-	if (pdev->no_d3cold)
+	if (pdev->no_d3cold || !pdev->d3cold_allowed)
 		d_max = ACPI_STATE_D3_HOT;
 	else
 		d_max = ACPI_STATE_D3_COLD;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7d3fb70568e3..f68798763af8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -519,10 +519,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 		return -EINVAL;
 
 	pdev->d3cold_allowed = !!val;
-	if (pdev->d3cold_allowed)
-		pci_d3cold_enable(pdev);
-	else
-		pci_d3cold_disable(pdev);
+	pci_bridge_d3_update(pdev);
 
 	pm_runtime_resume(dev);
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 912ce5cb2f08..1036ec368dda 100644
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
index 796eeffdf93b..8ff2dd5c52e6 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -346,7 +346,8 @@ ssize_t ptp_read(struct posix_clock *pc,
 
 	for (i = 0; i < cnt; i++) {
 		event[i] = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 
 	spin_unlock_irqrestore(&queue->lock, flags);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 89632cc9c28f..1e92bd897aa4 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -68,10 +68,11 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
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
index 05f6b6a9bbd5..1e02b5ae6127 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -68,9 +68,13 @@ struct ptp_clock {
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
index f97a5eefa2e2..b9e2f0896068 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -91,7 +91,8 @@ static ssize_t extts_fifo_show(struct device *dev,
 	qcnt = queue_cnt(queue);
 	if (qcnt) {
 		event = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 	spin_unlock_irqrestore(&queue->lock, flags);
 
diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index f653109d56af..f84c8a9846ab 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -250,6 +250,12 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
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
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 50e87823baab..0b45424e7ca5 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -853,6 +853,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
 
 	/* We need to know how many queues before we allocate. */
 	num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
+	num_queues = min_t(unsigned int, nr_cpu_ids, num_queues);
 
 	num_targets = virtscsi_config_get(vdev, max_target) + 1;
 
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 59d85bdd132b..c89f93ff07c5 100644
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
index 1838d0be3704..adb0bbcecd24 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -72,7 +72,8 @@
 #define AML_UART_BAUD_USE		BIT(23)
 #define AML_UART_BAUD_XTAL		BIT(24)
 
-#define AML_UART_PORT_NUM		6
+#define AML_UART_PORT_NUM		12
+#define AML_UART_PORT_OFFSET		6
 #define AML_UART_DEV_NAME		"ttyAML"
 
 
@@ -370,10 +371,14 @@ static void meson_uart_set_termios(struct uart_port *port,
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
 
@@ -664,13 +669,27 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
 
 static int meson_uart_probe(struct platform_device *pdev)
 {
-	struct resource *res_mem, *res_irq;
+	struct resource *res_mem;
 	struct uart_port *port;
+	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
+	int irq;
+	bool has_rtscts;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
 
+	if (pdev->id < 0) {
+		int id;
+
+		for (id = AML_UART_PORT_OFFSET; id < AML_UART_PORT_NUM; id++) {
+			if (!meson_ports[id]) {
+				pdev->id = id;
+				break;
+			}
+		}
+	}
+
 	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
 		return -EINVAL;
 
@@ -678,9 +697,12 @@ static int meson_uart_probe(struct platform_device *pdev)
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
@@ -703,14 +725,16 @@ static int meson_uart_probe(struct platform_device *pdev)
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
index 10a832a2135e..31ecba113315 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -586,18 +586,22 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
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
 
@@ -631,6 +635,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto unreg_tty;
 	}
 	port->domain = kstrdup(domain, GFP_KERNEL);
+	if (!port->domain) {
+		rv = -ENOMEM;
+		goto unreg_tty;
+	}
+
 
 	mdesc_release(hp);
 
@@ -660,8 +669,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
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
index 960666aba12b..3b27b98175c6 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -490,7 +490,9 @@ static void lateeoi_list_add(struct irq_info *info)
 
 	spin_lock_irqsave(&eoi->eoi_list_lock, flags);
 
-	if (list_empty(&eoi->eoi_list)) {
+	elem = list_first_entry_or_null(&eoi->eoi_list, struct irq_info,
+					eoi_list);
+	if (!elem || info->eoi_time < elem->eoi_time) {
 		list_add(&info->eoi_list, &eoi->eoi_list);
 		mod_delayed_work_on(info->eoi_cpu, system_wq,
 				    &eoi->delayed, delay);
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
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 288213cad914..f4b3d450dead 100644
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
@@ -1940,9 +1937,7 @@ static int ext4_convert_meta_bg(struct super_block *sb, struct inode *inode)
 
 errout:
 	ret = ext4_journal_stop(handle);
-	if (!err)
-		err = ret;
-	return ret;
+	return err ? err : ret;
 
 invalid_resize_inode:
 	ext4_error(sb, "corrupted/inconsistent resize inode");
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index dd0f9bc13164..9f753595d90e 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -434,6 +434,17 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
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
 
diff --git a/fs/iomap.c b/fs/iomap.c
index ac7b2152c3ad..04e82b6bd9bf 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -109,6 +109,7 @@ static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
+	unsigned int nr_blocks = PAGE_SIZE / i_blocksize(inode);
 
 	if (iop || i_blocksize(inode) == PAGE_SIZE)
 		return iop;
@@ -118,6 +119,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	atomic_set(&iop->write_count, 0);
 	spin_lock_init(&iop->uptodate_lock);
 	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+	if (PageUptodate(page))
+		bitmap_fill(iop->uptodate, nr_blocks);
 
 	/*
 	 * migrate_page_move_mapping() assumes that pages with private data have
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
index b20fffc8b4c1..2f452b5ee731 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -100,7 +100,7 @@ static int dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno,
 static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks);
 static int dbFindBits(u32 word, int l2nb);
 static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno);
-static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx);
+static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl);
 static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 		      int nblocks);
 static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
@@ -193,7 +193,8 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
 
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
-	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
+	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE ||
+		bmp->db_l2nbperpage < 0) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
@@ -207,6 +208,12 @@ int dbMount(struct inode *ipbmap)
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
@@ -1791,7 +1798,7 @@ static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno)
 		 * dbFindLeaf() returns the index of the leaf at which
 		 * free space was found.
 		 */
-		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx);
+		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx, true);
 
 		/* release the buffer.
 		 */
@@ -2038,7 +2045,7 @@ dbAllocDmapLev(struct bmap * bmp,
 	 * free space.  if sufficient free space is found, dbFindLeaf()
 	 * returns the index of the leaf at which free space was found.
 	 */
-	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
+	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, false))
 		return -ENOSPC;
 
 	if (leafidx < 0)
@@ -2998,14 +3005,18 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
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
@@ -3026,6 +3037,8 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
 			/* sufficient free space found.  move to the next
 			 * level (or quit if this is the last level).
 			 */
+			if (x + n > max_size)
+				return -ENOSPC;
 			if (l2nb <= tp->dmt_stree[x + n])
 				break;
 		}
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 7565e00e8818..b45cc109e506 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1335,7 +1335,7 @@ diInitInode(struct inode *ip, int iagno, int ino, int extno, struct iag * iagp)
 int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 {
 	int rc, ino, iagno, addext, extno, bitno, sword;
-	int nwords, rem, i, agno;
+	int nwords, rem, i, agno, dn_numag;
 	u32 mask, inosmap, extsmap;
 	struct inode *ipimap;
 	struct metapage *mp;
@@ -1371,6 +1371,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
+	if (agno < 0 || agno > dn_numag)
+		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
 		/*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3651619468d7..c44efead1a32 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5143,7 +5143,7 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_WRITE];
 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
-	nfs4_state_protect_write(server->nfs_client, clnt, msg, hdr);
+	nfs4_state_protect_write(hdr->ds_clp ? hdr->ds_clp : server->nfs_client, clnt, msg, hdr);
 }
 
 static void nfs4_proc_commit_rpc_prepare(struct rpc_task *task, struct nfs_commit_data *data)
@@ -5184,7 +5184,8 @@ static void nfs4_proc_commit_setup(struct nfs_commit_data *data, struct rpc_mess
 	data->res.server = server;
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_COMMIT];
 	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, 0);
-	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
+	nfs4_state_protect(data->ds_clp ? data->ds_clp : server->nfs_client,
+			NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
 }
 
 static int _nfs4_proc_commit(struct file *dst, struct nfs_commitargs *args,
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 190aee02bd6c..868936076f41 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2385,6 +2385,20 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
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
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index bd7d611d63e9..c6e981035c3f 100644
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
diff --git a/include/net/sock.h b/include/net/sock.h
index 373e34b46a3c..81888513b3b9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1759,21 +1759,33 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
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
 
@@ -1906,7 +1918,7 @@ static inline void dst_negative_advice(struct sock *sk)
 		if (ndst != dst) {
 			rcu_assign_pointer(sk->sk_dst_cache, ndst);
 			sk_tx_queue_clear(sk);
-			sk->sk_dst_pending_confirm = 0;
+			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		}
 	}
 }
@@ -1917,7 +1929,7 @@ __sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = rcu_dereference_protected(sk->sk_dst_cache,
 					    lockdep_sock_is_held(sk));
 	rcu_assign_pointer(sk->sk_dst_cache, dst);
@@ -1930,7 +1942,7 @@ sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = xchg((__force struct dst_entry **)&sk->sk_dst_cache, dst);
 	dst_release(old_dst);
 }
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 50952d6d8120..ff33536ae1ad 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -557,11 +557,18 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
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
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 12f351b253bb..2f6f77658eba 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -639,6 +639,12 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 		}
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
index 65a3b7e55b9f..4fd05d9d5d6d 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -439,7 +439,6 @@ static void stress_inorder_work(struct work_struct *work)
 	} while (!time_after(jiffies, stress->timeout));
 
 	kfree(order);
-	kfree(stress);
 }
 
 struct reorder_lock {
@@ -504,7 +503,6 @@ static void stress_reorder_work(struct work_struct *work)
 	list_for_each_entry_safe(ll, ln, &locks, link)
 		kfree(ll);
 	kfree(order);
-	kfree(stress);
 }
 
 static void stress_one_work(struct work_struct *work)
@@ -525,8 +523,6 @@ static void stress_one_work(struct work_struct *work)
 			break;
 		}
 	} while (!time_after(jiffies, stress->timeout));
-
-	kfree(stress);
 }
 
 #define STRESS_INORDER BIT(0)
@@ -537,15 +533,24 @@ static void stress_one_work(struct work_struct *work)
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
@@ -569,9 +574,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 		if (!fn)
 			continue;
 
-		stress = kmalloc(sizeof(*stress), GFP_KERNEL);
-		if (!stress)
-			break;
+		stress = &stress_array[count++];
 
 		INIT_WORK(&stress->work, fn);
 		stress->locks = locks;
@@ -586,6 +589,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_destroy(&locks[n]);
+	kfree(stress_array);
 	kfree(locks);
 
 	return 0;
diff --git a/kernel/padata.c b/kernel/padata.c
index 7f2b6d369fd4..a9e14183e188 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -121,7 +121,7 @@ int padata_do_parallel(struct padata_instance *pinst,
 	if (!cpumask_test_cpu(cb_cpu, pd->cpumask.cbcpu))
 		goto out;
 
-	err =  -EBUSY;
+	err = -EBUSY;
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index f2635fc751d9..5abe4582df1b 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2376,8 +2376,9 @@ static void *get_highmem_page_buffer(struct page *page,
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
@@ -2557,8 +2558,9 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
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
@@ -2589,8 +2591,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
 
-	handle->sync_read = 1;
-
 	if (!handle->cur) {
 		if (!buffer)
 			/* This makes the buffer be freed by swsusp_free() */
@@ -2631,7 +2631,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			memory_bm_position_reset(&orig_bm);
 			restore_pblist = NULL;
 			handle->buffer = get_buffer(&orig_bm, &ca);
-			handle->sync_read = 0;
 			if (IS_ERR(handle->buffer))
 				return PTR_ERR(handle->buffer);
 		}
@@ -2643,9 +2642,8 @@ int snapshot_write_next(struct snapshot_handle *handle)
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
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b876e97b61c9..0e837feaa527 100644
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
diff --git a/net/core/sock.c b/net/core/sock.c
index e1d0c8c715b8..62d169bcfcfa 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -496,7 +496,7 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 
 	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
-		sk->sk_dst_pending_confirm = 0;
+		WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
 		dst_release(dst);
 		return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3dd62cf739e3..a0875dc60e08 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1090,7 +1090,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	skb_set_hash_from_sk(skb, sk);
 	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
 
-	skb_set_dst_pending_confirm(skb, sk->sk_dst_pending_confirm);
+	skb_set_dst_pending_confirm(skb, READ_ONCE(sk->sk_dst_pending_confirm));
 
 	/* Build TCP header and checksum it. */
 	th = (struct tcphdr *)skb->data;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5659af1bec17..77d8ed184c1c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2452,6 +2452,10 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	else
 		*dbm = sdata->vif.bss_conf.txpower;
 
+	/* INT_MIN indicates no power level was set yet */
+	if (*dbm == INT_MIN)
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 8105563593b6..ab57c0ee9923 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1004,12 +1004,13 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 
 skip:
 		if (!ingress) {
-			notify_and_destroy(net, skb, n, classid,
-					   dev->qdisc, new);
+			old = dev->qdisc;
 			if (new && !new->ops->attach)
 				qdisc_refcount_inc(new);
 			dev->qdisc = new ? : &noop_qdisc;
 
+			notify_and_destroy(net, skb, n, classid, old, new);
+
 			if (new && new->ops->attach)
 				new->ops->attach(new);
 		} else {
diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 59e8e17d8da9..2276a0704a63 100644
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
index 2ac656db0b1c..b2c459ca56d0 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -72,7 +72,7 @@ struct snd_info_private_data {
 };
 
 static int snd_info_version_init(void);
-static void snd_info_disconnect(struct snd_info_entry *entry);
+static void snd_info_clear_entries(struct snd_info_entry *entry);
 
 /*
 
@@ -598,11 +598,16 @@ void snd_info_card_disconnect(struct snd_card *card)
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
 
@@ -776,15 +781,14 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
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
 
@@ -801,8 +805,9 @@ void snd_info_free_entry(struct snd_info_entry * entry)
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
index eee422390d8e..2569f82b6fa0 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -241,8 +241,10 @@ struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
 	struct hdac_stream *res = NULL;
 
 	/* make a non-zero unique key for the substream */
-	int key = (substream->pcm->device << 16) | (substream->number << 2) |
-		(substream->stream + 1);
+	int key = (substream->number << 2) | (substream->stream + 1);
+
+	if (substream->pcm)
+		key |= (substream->pcm->device << 16);
 
 	list_for_each_entry(azx_dev, &bus->stream_list, list) {
 		if (azx_dev->direction != substream->stream)
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e5d85887759b..184f6af9c210 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7168,6 +7168,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x10c0, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x10d0, "ASUS X540LA/X540LJ", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x10d3, "ASUS K6500ZC", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1271, "ASUS X430UN", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
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
