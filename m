Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103F0809DAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573342AbjLHH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjLHH43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:56:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4D171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:56:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C42C433C8;
        Fri,  8 Dec 2023 07:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022191;
        bh=J4XyUpgcfuFfep1jSrtHiCiLu4YQHpz948e6uEGTB+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKpMoOGa56ew3dBgYvZV5JJaUPzzI6ImSLvNbL2twUD2WPhVj7h0shoNXLCuKkZLl
         uRPKWSjtPCwHZxE6OeqLrRmzRXBpxk2V9AtgOAqqoIluM7d9rZg/nVm2SszMregJ2s
         +mcA6INGuqOs8G2yUnIC3bw5cPi6PcLx13I0md4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.301
Date:   Fri,  8 Dec 2023 08:56:21 +0100
Message-ID: <2023120821-causing-reprocess-c877@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023120821-superbowl-baggy-51b5@gregkh>
References: <2023120821-superbowl-baggy-51b5@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 74741cde46b2..1db751784cf2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 300
+SUBLEVEL = 301
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index dd946c77e801..1623bfab4513 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -388,7 +388,8 @@ static int __init xen_guest_init(void)
 	 * for secondary CPUs as they are brought up.
 	 * For uniformity we use VCPUOP_register_vcpu_info even on cpu0.
 	 */
-	xen_vcpu_info = alloc_percpu(struct vcpu_info);
+	xen_vcpu_info = __alloc_percpu(sizeof(struct vcpu_info),
+				       1 << fls(sizeof(struct vcpu_info) - 1));
 	if (xen_vcpu_info == NULL)
 		return -ENOMEM;
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 05f41d8f7db3..a3cc478d2570 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -422,6 +422,29 @@ cpuid_feature_extract_unsigned_field(u64 features, int field)
 	return cpuid_feature_extract_unsigned_field_width(features, field, 4);
 }
 
+/*
+ * Fields that identify the version of the Performance Monitors Extension do
+ * not follow the standard ID scheme. See ARM DDI 0487E.a page D13-2825,
+ * "Alternative ID scheme used for the Performance Monitors Extension version".
+ */
+static inline u64 __attribute_const__
+cpuid_feature_cap_perfmon_field(u64 features, int field, u64 cap)
+{
+	u64 val = cpuid_feature_extract_unsigned_field(features, field);
+	u64 mask = GENMASK_ULL(field + 3, field);
+
+	/* Treat IMPLEMENTATION DEFINED functionality as unimplemented */
+	if (val == 0xf)
+		val = 0;
+
+	if (val > cap) {
+		features &= ~mask;
+		features |= (cap << field) & mask;
+	}
+
+	return features;
+}
+
 static inline u64 arm64_ftr_mask(const struct arm64_ftr_bits *ftrp)
 {
 	return (u64)GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 22266c7e2cc1..0a8342de5796 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -622,6 +622,12 @@
 #define ID_AA64DFR0_TRACEVER_SHIFT	4
 #define ID_AA64DFR0_DEBUGVER_SHIFT	0
 
+#define ID_AA64DFR0_PMUVER_8_1		0x4
+
+#define ID_DFR0_PERFMON_SHIFT		24
+
+#define ID_DFR0_PERFMON_8_1		0x4
+
 #define ID_ISAR5_RDM_SHIFT		24
 #define ID_ISAR5_CRC32_SHIFT		16
 #define ID_ISAR5_SHA2_SHIFT		12
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f06629bf2be1..2799e7e9915a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1049,6 +1049,16 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
 			kvm_debug("LORegions unsupported for guests, suppressing\n");
 
 		val &= ~(0xfUL << ID_AA64MMFR1_LOR_SHIFT);
+	} else if (id == SYS_ID_AA64DFR0_EL1) {
+		/* Limit guests to PMUv3 for ARMv8.1 */
+		val = cpuid_feature_cap_perfmon_field(val,
+						ID_AA64DFR0_PMUVER_SHIFT,
+						ID_AA64DFR0_PMUVER_8_1);
+	} else if (id == SYS_ID_DFR0_EL1) {
+		/* Limit guests to PMUv3 for ARMv8.1 */
+		val = cpuid_feature_cap_perfmon_field(val,
+						ID_DFR0_PERFMON_SHIFT,
+						ID_DFR0_PERFMON_8_1);
 	}
 
 	return val;
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 098a7afd4d38..8c466d6d4736 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -692,7 +692,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	int srcu_idx, err;
 	kvm_pfn_t pfn;
-	pte_t *ptep, entry, old_pte;
+	pte_t *ptep, entry;
 	bool writeable;
 	unsigned long prot_bits;
 	unsigned long mmu_seq;
@@ -765,7 +765,6 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	entry = pfn_pte(pfn, __pgprot(prot_bits));
 
 	/* Write the PTE */
-	old_pte = *ptep;
 	set_pte(ptep, entry);
 
 	err = 0;
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 529dcc21c3f9..31275e170ca8 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -29,6 +29,15 @@
 #include <asm/feature-fixups.h>
 
 #ifdef CONFIG_VSX
+#define __REST_1FPVSR(n,c,base)						\
+BEGIN_FTR_SECTION							\
+	b	2f;							\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
+	REST_FPR(n,base);						\
+	b	3f;							\
+2:	REST_VSR(n,c,base);						\
+3:
+
 #define __REST_32FPVSRS(n,c,base)					\
 BEGIN_FTR_SECTION							\
 	b	2f;							\
@@ -47,9 +56,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
 2:	SAVE_32VSRS(n,c,base);						\
 3:
 #else
+#define __REST_1FPVSR(n,b,base)		REST_FPR(n, base)
 #define __REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
 #define __SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
 #endif
+#define REST_1FPVSR(n,c,base)   __REST_1FPVSR(n,__REG_##c,__REG_##base)
 #define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base)
 #define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
 
@@ -72,6 +83,7 @@ _GLOBAL(store_fp_state)
 	SAVE_32FPVSRS(0, R4, R3)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r3)
+	REST_1FPVSR(0, R4, R3)
 	blr
 EXPORT_SYMBOL(store_fp_state)
 
@@ -136,6 +148,7 @@ _GLOBAL(save_fpu)
 2:	SAVE_32FPVSRS(0, R4, R6)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r6)
+	REST_1FPVSR(0, R4, R6)
 	blr
 
 /*
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 21165da0052d..11c0033dd59f 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -31,6 +31,7 @@ _GLOBAL(store_vr_state)
 	mfvscr	v0
 	li	r4, VRSTATE_VSCR
 	stvx	v0, r4, r3
+	lvx	v0, 0, r3
 	blr
 EXPORT_SYMBOL(store_vr_state)
 
@@ -101,6 +102,7 @@ _GLOBAL(save_altivec)
 	mfvscr	v0
 	li	r4,VRSTATE_VSCR
 	stvx	v0,r4,r7
+	lvx	v0,0,r7
 	blr
 
 #ifdef CONFIG_VSX
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index dc3cede7f2ec..182240411211 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -118,7 +118,7 @@ static void mark_kernel_pmd(pud_t *pud, unsigned long addr, unsigned long end)
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd) || pmd_large(*pmd))
 			continue;
-		page = virt_to_page(pmd_val(*pmd));
+		page = phys_to_page(pmd_val(*pmd));
 		set_bit(PG_arch_1, &page->flags);
 	} while (pmd++, addr = next, addr != end);
 }
@@ -136,8 +136,8 @@ static void mark_kernel_pud(p4d_t *p4d, unsigned long addr, unsigned long end)
 		if (pud_none(*pud) || pud_large(*pud))
 			continue;
 		if (!pud_folded(*pud)) {
-			page = virt_to_page(pud_val(*pud));
-			for (i = 0; i < 3; i++)
+			page = phys_to_page(pud_val(*pud));
+			for (i = 0; i < 4; i++)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_pmd(pud, addr, next);
@@ -157,8 +157,8 @@ static void mark_kernel_p4d(pgd_t *pgd, unsigned long addr, unsigned long end)
 		if (p4d_none(*p4d))
 			continue;
 		if (!p4d_folded(*p4d)) {
-			page = virt_to_page(p4d_val(*p4d));
-			for (i = 0; i < 3; i++)
+			page = phys_to_page(p4d_val(*p4d));
+			for (i = 0; i < 4; i++)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_pud(p4d, addr, next);
@@ -179,8 +179,8 @@ static void mark_kernel_pgd(void)
 		if (pgd_none(*pgd))
 			continue;
 		if (!pgd_folded(*pgd)) {
-			page = virt_to_page(pgd_val(*pgd));
-			for (i = 0; i < 3; i++)
+			page = phys_to_page(pgd_val(*pgd));
+			for (i = 0; i < 4; i++)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_p4d(pgd, addr, next);
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 994f168b54a8..4ffbc2a63f8f 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -81,6 +81,9 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 	if (pnp_port_valid(idev, 1)) {
 		ctl_addr = devm_ioport_map(&idev->dev,
 					   pnp_port_start(idev, 1), 1);
+		if (!ctl_addr)
+			return -ENOMEM;
+
 		ap->ioaddr.altstatus_addr = ctl_addr;
 		ap->ioaddr.ctl_addr = ctl_addr;
 		ap->ops = &isapnp_port_ops;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 6a2aa8562471..ad05eaf82da4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -995,8 +995,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		else if (drv->remove)
 			drv->remove(dev);
 
-		device_links_driver_cleanup(dev);
-
 		devres_release_all(dev);
 		dma_deconfigure(dev);
 		dev->driver = NULL;
@@ -1006,6 +1004,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		pm_runtime_reinit(dev);
 		dev_pm_set_driver_flags(dev, 0);
 
+		device_links_driver_cleanup(dev);
+
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
 		if (dev->bus)
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index a0cbbdfc7735..b3a392b4c928 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -240,6 +240,14 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.suspend = cpufreq_generic_suspend,
 };
 
+static void imx6x_disable_freq_in_opp(struct device *dev, unsigned long freq)
+{
+	int ret = dev_pm_opp_disable(dev, freq);
+
+	if (ret < 0 && ret != -ENODEV)
+		dev_warn(dev, "failed to disable %ldMHz OPP\n", freq / 1000000);
+}
+
 #define OCOTP_CFG3			0x440
 #define OCOTP_CFG3_SPEED_SHIFT		16
 #define OCOTP_CFG3_SPEED_1P2GHZ		0x3
@@ -275,17 +283,15 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
 	val &= 0x3;
 
 	if (val < OCOTP_CFG3_SPEED_996MHZ)
-		if (dev_pm_opp_disable(dev, 996000000))
-			dev_warn(dev, "failed to disable 996MHz OPP\n");
+		imx6x_disable_freq_in_opp(dev, 996000000);
 
 	if (of_machine_is_compatible("fsl,imx6q") ||
 	    of_machine_is_compatible("fsl,imx6qp")) {
 		if (val != OCOTP_CFG3_SPEED_852MHZ)
-			if (dev_pm_opp_disable(dev, 852000000))
-				dev_warn(dev, "failed to disable 852MHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 852000000);
+
 		if (val != OCOTP_CFG3_SPEED_1P2GHZ)
-			if (dev_pm_opp_disable(dev, 1200000000))
-				dev_warn(dev, "failed to disable 1.2GHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 1200000000);
 	}
 	iounmap(base);
 put_node:
@@ -338,20 +344,16 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
-	if (of_machine_is_compatible("fsl,imx6ul")) {
+	if (of_machine_is_compatible("fsl,imx6ul"))
 		if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
-			if (dev_pm_opp_disable(dev, 696000000))
-				dev_warn(dev, "failed to disable 696MHz OPP\n");
-	}
+			imx6x_disable_freq_in_opp(dev, 696000000);
 
 	if (of_machine_is_compatible("fsl,imx6ull")) {
-		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
-			if (dev_pm_opp_disable(dev, 792000000))
-				dev_warn(dev, "failed to disable 792MHz OPP\n");
+		if (val < OCOTP_CFG3_6ULL_SPEED_792MHZ)
+			imx6x_disable_freq_in_opp(dev, 792000000);
 
 		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
-			if (dev_pm_opp_disable(dev, 900000000))
-				dev_warn(dev, "failed to disable 900MHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 900000000);
 	}
 
 	return ret;
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 7c2eed76011e..a293b39fd4ce 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -732,14 +732,11 @@ static void create_units(struct fw_device *device)
 					fw_unit_attributes,
 					&unit->attribute_group);
 
-		if (device_register(&unit->device) < 0)
-			goto skip_unit;
-
 		fw_device_get(device);
-		continue;
-
-	skip_unit:
-		kfree(unit);
+		if (device_register(&unit->device) < 0) {
+			put_device(&unit->device);
+			continue;
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 35771e0e69fa..eb7717eb2614 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1261,13 +1261,13 @@ static const struct panel_desc innolux_g070y2_l01 = {
 static const struct display_timing innolux_g101ice_l01_timing = {
 	.pixelclock = { 60400000, 71100000, 74700000 },
 	.hactive = { 1280, 1280, 1280 },
-	.hfront_porch = { 41, 80, 100 },
-	.hback_porch = { 40, 79, 99 },
-	.hsync_len = { 1, 1, 1 },
+	.hfront_porch = { 30, 60, 70 },
+	.hback_porch = { 30, 60, 70 },
+	.hsync_len = { 22, 40, 60 },
 	.vactive = { 800, 800, 800 },
-	.vfront_porch = { 5, 11, 14 },
-	.vback_porch = { 4, 11, 14 },
-	.vsync_len = { 1, 1, 1 },
+	.vfront_porch = { 3, 8, 14 },
+	.vback_porch = { 3, 8, 14 },
+	.vsync_len = { 4, 7, 12 },
 	.flags = DISPLAY_FLAGS_DE_HIGH,
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ea692046be61..c502d24b8253 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -204,14 +204,22 @@ static inline void vop_cfg_done(struct vop *vop)
 	VOP_REG_SET(vop, common, cfg_done, 1);
 }
 
-static bool has_rb_swapped(uint32_t format)
+static bool has_rb_swapped(uint32_t version, uint32_t format)
 {
 	switch (format) {
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
-	case DRM_FORMAT_BGR888:
 	case DRM_FORMAT_BGR565:
 		return true;
+	/*
+	 * full framework (IP version 3.x) only need rb swapped for RGB888 and
+	 * little framework (IP version 2.x) only need rb swapped for BGR888,
+	 * check for 3.x to also only rb swap BGR888 for unknown vop version
+	 */
+	case DRM_FORMAT_RGB888:
+		return VOP_MAJOR(version) == 3;
+	case DRM_FORMAT_BGR888:
+		return VOP_MAJOR(version) != 3;
 	default:
 		return false;
 	}
@@ -798,7 +806,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
 	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
 
-	rb_swap = has_rb_swapped(fb->format->format);
+	rb_swap = has_rb_swapped(vop->data->version, fb->format->format);
 	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
 	/*
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c8d687f795ca..dd1d8d0a46d1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -701,15 +701,22 @@ static void hid_close_report(struct hid_device *device)
  * Free a device structure, all reports, and all fields.
  */
 
-static void hid_device_release(struct device *dev)
+void hiddev_free(struct kref *ref)
 {
-	struct hid_device *hid = to_hid_device(dev);
+	struct hid_device *hid = container_of(ref, struct hid_device, ref);
 
 	hid_close_report(hid);
 	kfree(hid->dev_rdesc);
 	kfree(hid);
 }
 
+static void hid_device_release(struct device *dev)
+{
+	struct hid_device *hid = to_hid_device(dev);
+
+	kref_put(&hid->ref, hiddev_free);
+}
+
 /*
  * Fetch a report description item from the data stream. We support long
  * items, though they are not used yet.
@@ -2259,10 +2266,12 @@ int hid_add_device(struct hid_device *hdev)
 			hid_warn(hdev, "bad device descriptor (%d)\n", ret);
 	}
 
+	hdev->id = atomic_inc_return(&id);
+
 	/* XXX hack, any other cleaner solution after the driver core
 	 * is converted to allow more than 20 bytes as the device name? */
 	dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
-		     hdev->vendor, hdev->product, atomic_inc_return(&id));
+		     hdev->vendor, hdev->product, hdev->id);
 
 	hid_debug_register(hdev, dev_name(&hdev->dev));
 	ret = device_add(&hdev->dev);
@@ -2305,6 +2314,7 @@ struct hid_device *hid_allocate_device(void)
 	spin_lock_init(&hdev->debug_list_lock);
 	sema_init(&hdev->driver_input_lock, 1);
 	mutex_init(&hdev->ll_open_lock);
+	kref_init(&hdev->ref);
 
 	return hdev;
 }
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 2abd30a4ff75..64ff5bd6579e 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1096,6 +1096,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 	list->hdev = (struct hid_device *) inode->i_private;
+	kref_get(&list->hdev->ref);
 	file->private_data = list;
 	mutex_init(&list->read_mutex);
 
@@ -1188,6 +1189,8 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
 	list_del(&list->node);
 	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
 	kfifo_free(&list->hid_debug_fifo);
+
+	kref_put(&list->hdev->ref, hiddev_free);
 	kfree(list);
 
 	return 0;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index 4d841a3c68f3..026557aa2307 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -2945,6 +2945,9 @@ static enum i40iw_status_code i40iw_sc_alloc_stag(
 	u64 header;
 	enum i40iw_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	page_size = (info->page_size == 0x200000) ? I40IW_PAGE_SIZE_2M : I40IW_PAGE_SIZE_4K;
 	cqp = dev->cqp;
 	wqe = i40iw_sc_cqp_get_next_send_wqe(cqp, scratch);
@@ -3003,6 +3006,9 @@ static enum i40iw_status_code i40iw_sc_mr_reg_non_shared(
 	u8 addr_type;
 	enum i40iw_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	page_size = (info->page_size == 0x200000) ? I40IW_PAGE_SIZE_2M : I40IW_PAGE_SIZE_4K;
 	if (info->access_rights & (I40IW_ACCESS_FLAGS_REMOTEREAD_ONLY |
 				   I40IW_ACCESS_FLAGS_REMOTEWRITE_ONLY))
diff --git a/drivers/infiniband/hw/i40iw/i40iw_type.h b/drivers/infiniband/hw/i40iw/i40iw_type.h
index adc8d2ec523d..5c4e2f206105 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_type.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_type.h
@@ -779,6 +779,7 @@ struct i40iw_allocate_stag_info {
 	bool use_hmc_fcn_index;
 	u8 hmc_fcn_index;
 	bool use_pf_rid;
+	bool all_memory;
 };
 
 struct i40iw_reg_ns_stag_info {
@@ -797,6 +798,7 @@ struct i40iw_reg_ns_stag_info {
 	bool use_hmc_fcn_index;
 	u8 hmc_fcn_index;
 	bool use_pf_rid;
+	bool all_memory;
 };
 
 struct i40iw_fast_reg_stag_info {
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 314d19153c99..6fde373300f5 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1581,7 +1581,8 @@ static int i40iw_handle_q_mem(struct i40iw_device *iwdev,
 static int i40iw_hw_alloc_stag(struct i40iw_device *iwdev, struct i40iw_mr *iwmr)
 {
 	struct i40iw_allocate_stag_info *info;
-	struct i40iw_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct i40iw_pd *iwpd = to_iwpd(pd);
 	enum i40iw_status_code status;
 	int err = 0;
 	struct i40iw_cqp_request *cqp_request;
@@ -1598,6 +1599,7 @@ static int i40iw_hw_alloc_stag(struct i40iw_device *iwdev, struct i40iw_mr *iwmr
 	info->stag_idx = iwmr->stag >> I40IW_CQPSQ_STAG_IDX_SHIFT;
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->total_len = iwmr->length;
+	info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	info->remote_access = true;
 	cqp_info->cqp_cmd = OP_ALLOC_STAG;
 	cqp_info->post_sq = 1;
@@ -1651,6 +1653,8 @@ static struct ib_mr *i40iw_alloc_mr(struct ib_pd *pd,
 	iwmr->type = IW_MEMREG_TYPE_MEM;
 	palloc = &iwpbl->pble_alloc;
 	iwmr->page_cnt = max_num_sg;
+	/* Use system PAGE_SIZE as the sg page sizes are unknown at this point */
+	iwmr->length = max_num_sg * PAGE_SIZE;
 	mutex_lock(&iwdev->pbl_mutex);
 	status = i40iw_get_pble(&iwdev->sc_dev, iwdev->pble_rsrc, palloc, iwmr->page_cnt);
 	mutex_unlock(&iwdev->pbl_mutex);
@@ -1747,7 +1751,8 @@ static int i40iw_hwreg_mr(struct i40iw_device *iwdev,
 {
 	struct i40iw_pbl *iwpbl = &iwmr->iwpbl;
 	struct i40iw_reg_ns_stag_info *stag_info;
-	struct i40iw_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct i40iw_pd *iwpd = to_iwpd(pd);
 	struct i40iw_pble_alloc *palloc = &iwpbl->pble_alloc;
 	enum i40iw_status_code status;
 	int err = 0;
@@ -1767,6 +1772,7 @@ static int i40iw_hwreg_mr(struct i40iw_device *iwdev,
 	stag_info->total_len = iwmr->length;
 	stag_info->access_rights = access;
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
+	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	stag_info->addr_type = I40IW_ADDR_TYPE_VA_BASED;
 	stag_info->page_size = iwmr->page_size;
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4591f60dd6e2..e330d28b59ec 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -133,6 +133,7 @@ static const struct xpad_device {
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f10, "Thrustmaster Modena GT Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0xb326, "Thrustmaster Gamepad GP XID", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
@@ -445,6 +446,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One Controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 71d670934a07..3518088d7ff1 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1379,7 +1379,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	memset(new_nodes, 0, sizeof(new_nodes));
 	closure_init_stack(&cl);
 
-	while (nodes < GC_MERGE_NODES && !IS_ERR(r[nodes].b))
+	while (nodes < GC_MERGE_NODES && !IS_ERR_OR_NULL(r[nodes].b))
 		keys += r[nodes++].keys;
 
 	blocks = btree_default_blocks(b->c) * 2 / 3;
@@ -1526,7 +1526,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 			atomic_dec(&b->c->prio_blocked);
 
 	for (i = 0; i < nodes; i++)
-		if (!IS_ERR(new_nodes[i])) {
+		if (!IS_ERR_OR_NULL(new_nodes[i])) {
 			btree_node_free(new_nodes[i]);
 			rw_unlock(true, new_nodes[i]);
 		}
@@ -1543,6 +1543,8 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 		return 0;
 
 	n = btree_node_alloc_replacement(replace, NULL);
+	if (IS_ERR(n))
+		return 0;
 
 	/* recheck reserve after allocating replacement node */
 	if (btree_check_reserve(b, NULL)) {
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 591d9c8107dd..64a72222a58c 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -992,7 +992,7 @@ SHOW(__bch_cache)
 			sum += INITIAL_PRIO - cached[i];
 
 		if (n)
-			do_div(sum, n);
+			sum = div64_u64(sum, n);
 
 		for (i = 0; i < ARRAY_SIZE(q); i++)
 			q[i] = INITIAL_PRIO - cached[n * (i + 1) /
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index f496213f8b67..7c0e7c662e07 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -30,7 +30,7 @@ struct delay_c {
 	struct workqueue_struct *kdelayd_wq;
 	struct work_struct flush_expired_bios;
 	struct list_head delayed_bios;
-	atomic_t may_delay;
+	bool may_delay;
 
 	struct delay_class read;
 	struct delay_class write;
@@ -191,7 +191,7 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
 	INIT_LIST_HEAD(&dc->delayed_bios);
 	mutex_init(&dc->timer_lock);
-	atomic_set(&dc->may_delay, 1);
+	dc->may_delay = true;
 	dc->argc = argc;
 
 	ret = delay_class_ctr(ti, &dc->read, argv);
@@ -245,7 +245,7 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	struct dm_delay_info *delayed;
 	unsigned long expires = 0;
 
-	if (!c->delay || !atomic_read(&dc->may_delay))
+	if (!c->delay)
 		return DM_MAPIO_REMAPPED;
 
 	delayed = dm_per_bio_data(bio, sizeof(struct dm_delay_info));
@@ -254,6 +254,10 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	delayed->expires = expires = jiffies + msecs_to_jiffies(c->delay);
 
 	mutex_lock(&delayed_bios_lock);
+	if (unlikely(!dc->may_delay)) {
+		mutex_unlock(&delayed_bios_lock);
+		return DM_MAPIO_REMAPPED;
+	}
 	c->ops++;
 	list_add_tail(&delayed->list, &dc->delayed_bios);
 	mutex_unlock(&delayed_bios_lock);
@@ -267,7 +271,10 @@ static void delay_presuspend(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	atomic_set(&dc->may_delay, 0);
+	mutex_lock(&delayed_bios_lock);
+	dc->may_delay = false;
+	mutex_unlock(&delayed_bios_lock);
+
 	del_timer_sync(&dc->delay_timer);
 	flush_bios(flush_delayed_bios(dc, 1));
 }
@@ -276,7 +283,7 @@ static void delay_resume(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	atomic_set(&dc->may_delay, 1);
+	dc->may_delay = true;
 }
 
 static int delay_map(struct dm_target *ti, struct bio *bio)
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index a433f5824f18..67b533c19e26 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -28,7 +28,8 @@ bool verity_fec_is_enabled(struct dm_verity *v)
  */
 static inline struct dm_verity_fec_io *fec_io(struct dm_verity_io *io)
 {
-	return (struct dm_verity_fec_io *) verity_io_digest_end(io->v, io);
+	return (struct dm_verity_fec_io *)
+		((char *)io + io->v->ti->per_io_data_size - sizeof(struct dm_verity_fec_io));
 }
 
 /*
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index d116495a3445..76d60c55d380 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -579,7 +579,9 @@ static void verity_end_io(struct bio *bio)
 	struct dm_verity_io *io = bio->bi_private;
 
 	if (bio->bi_status &&
-	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
+	    (!verity_fec_is_enabled(io->v) ||
+	     verity_is_system_shutting_down() ||
+	     (bio->bi_opf & REQ_RAHEAD))) {
 		verity_finish_io(io, bio->bi_status);
 		return;
 	}
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 3441c10b840c..6e65ec0e627a 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -109,12 +109,6 @@ static inline u8 *verity_io_want_digest(struct dm_verity *v,
 	return (u8 *)(io + 1) + v->ahash_reqsize + v->digest_size;
 }
 
-static inline u8 *verity_io_digest_end(struct dm_verity *v,
-				       struct dm_verity_io *io)
-{
-	return verity_io_want_digest(v, io) + v->digest_size;
-}
-
 extern int verity_for_bv_block(struct dm_verity *v, struct dm_verity_io *io,
 			       struct bvec_iter *iter,
 			       int (*process)(struct dm_verity *v,
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 039058fe6a41..a5d986c75276 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1470,6 +1470,8 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 			blk_mq_requeue_request(req, true);
 		else
 			__blk_mq_end_request(req, BLK_STS_OK);
+	} else if (mq->in_recovery) {
+		blk_mq_requeue_request(req, true);
 	} else {
 		blk_mq_end_request(req, BLK_STS_OK);
 	}
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6937f39fe657..3c299417c4ab 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -567,22 +567,25 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	host->cqe_ops->cqe_recovery_start(host);
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.opcode       = MMC_STOP_TRANSMISSION,
-	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC,
+	cmd.opcode       = MMC_STOP_TRANSMISSION;
+	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
-	mmc_wait_for_cmd(host, &cmd, 0);
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
+	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
 	cmd.arg          = 1; /* Discard entire queue */
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
-	err = mmc_wait_for_cmd(host, &cmd, 0);
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	host->cqe_ops->cqe_recovery_finish(host);
 
+	if (err)
+		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+
 	mmc_retune_release(host);
 
 	return err;
diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 495a09b5a8e7..a17b87fa2635 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -884,8 +884,8 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_tasks_cleared(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to clear tasks\n",
-			 mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to clear tasks\n",
+			mmc_hostname(mmc));
 
 	return ret;
 }
@@ -918,7 +918,7 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_halted(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
 
 	return ret;
 }
@@ -926,10 +926,10 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 /*
  * After halting we expect to be able to use the command line. We interpret the
  * failure to halt to mean the data lines might still be in use (and the upper
- * layers will need to send a STOP command), so we set the timeout based on a
- * generous command timeout.
+ * layers will need to send a STOP command), however failing to halt complicates
+ * the recovery, so set a timeout that would reasonably allow I/O to complete.
  */
-#define CQHCI_START_HALT_TIMEOUT	5
+#define CQHCI_START_HALT_TIMEOUT	500
 
 static void cqhci_recovery_start(struct mmc_host *mmc)
 {
@@ -1017,28 +1017,28 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
 
 	ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
 
-	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-		ok = false;
-
 	/*
 	 * The specification contradicts itself, by saying that tasks cannot be
 	 * cleared if CQHCI does not halt, but if CQHCI does not halt, it should
 	 * be disabled/re-enabled, but not to disable before clearing tasks.
 	 * Have a go anyway.
 	 */
-	if (!ok) {
-		pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
-		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
-		cqcfg &= ~CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		cqcfg |= CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		/* Be sure that there are no tasks */
-		ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
-		if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-			ok = false;
-		WARN_ON(!ok);
-	}
+	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
+		ok = false;
+
+	/* Disable to make sure tasks really are cleared */
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
+
+	if (!ok)
+		cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT);
 
 	cqhci_recover_mrqs(cq_host);
 
diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 6e8e7b1bb34b..3bd812435f1b 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -420,8 +420,25 @@ read_pri_intelext(struct map_info *map, __u16 adr)
 		extra_size = 0;
 
 		/* Protection Register info */
-		extra_size += (extp->NumProtectionFields - 1) *
-			      sizeof(struct cfi_intelext_otpinfo);
+		if (extp->NumProtectionFields) {
+			struct cfi_intelext_otpinfo *otp =
+				(struct cfi_intelext_otpinfo *)&extp->extra[0];
+
+			extra_size += (extp->NumProtectionFields - 1) *
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
@@ -695,14 +712,16 @@ static int cfi_intelext_partition_fixup(struct mtd_info *mtd,
 	 */
 	if (extp && extp->MajorVersion == '1' && extp->MinorVersion >= '3'
 	    && extp->FeatureSupport & (1 << 9)) {
+		int offs = 0;
 		struct cfi_private *newcfi;
 		struct flchip *chip;
 		struct flchip_shared *shared;
-		int offs, numregions, numparts, partshift, numvirtchips, i, j;
+		int numregions, numparts, partshift, numvirtchips, i, j;
 
 		/* Protection Register info */
-		offs = (extp->NumProtectionFields - 1) *
-		       sizeof(struct cfi_intelext_otpinfo);
+		if (extp->NumProtectionFields)
+			offs = (extp->NumProtectionFields - 1) *
+			       sizeof(struct cfi_intelext_otpinfo);
 
 		/* Burst Read info */
 		offs += extp->extra[offs+1]+2;
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 0e14892ff926..dc7650ae0464 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1753,6 +1753,7 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 	int bitflips = 0;
 	int page = addr >> chip->page_shift;
 	int ret;
+	void *ecc_chunk;
 
 	if (!buf) {
 		buf = chip->data_buf;
@@ -1768,7 +1769,9 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 		return ret;
 
 	for (i = 0; i < chip->ecc.steps; i++, oob += sas) {
-		ret = nand_check_erased_ecc_chunk(buf, chip->ecc.size,
+		ecc_chunk = buf + chip->ecc.size * i;
+		ret = nand_check_erased_ecc_chunk(ecc_chunk,
+						  chip->ecc.size,
 						  oob, sas, NULL, 0,
 						  chip->ecc.strength);
 		if (ret < 0)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index c1fb1e62557c..ec089b3a8aa2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -683,10 +683,24 @@ static void xgbe_service(struct work_struct *work)
 static void xgbe_service_timer(struct timer_list *t)
 {
 	struct xgbe_prv_data *pdata = from_timer(pdata, t, service_timer);
+	struct xgbe_channel *channel;
+	unsigned int i;
 
 	queue_work(pdata->dev_workqueue, &pdata->service_work);
 
 	mod_timer(&pdata->service_timer, jiffies + HZ);
+
+	if (!pdata->tx_usecs)
+		return;
+
+	for (i = 0; i < pdata->channel_count; i++) {
+		channel = pdata->channel[i];
+		if (!channel->tx_ring || channel->tx_timer_active)
+			break;
+		channel->tx_timer_active = 1;
+		mod_timer(&channel->tx_timer,
+			  jiffies + usecs_to_jiffies(pdata->tx_usecs));
+	}
 }
 
 static void xgbe_init_timers(struct xgbe_prv_data *pdata)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index a880f10e3e70..d74f45ce0686 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -314,10 +314,15 @@ static int xgbe_get_link_ksettings(struct net_device *netdev,
 
 	cmd->base.phy_address = pdata->phy.address;
 
-	cmd->base.autoneg = pdata->phy.autoneg;
-	cmd->base.speed = pdata->phy.speed;
-	cmd->base.duplex = pdata->phy.duplex;
+	if (netif_carrier_ok(netdev)) {
+		cmd->base.speed = pdata->phy.speed;
+		cmd->base.duplex = pdata->phy.duplex;
+	} else {
+		cmd->base.speed = SPEED_UNKNOWN;
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+	}
 
+	cmd->base.autoneg = pdata->phy.autoneg;
 	cmd->base.port = PORT_NONE;
 
 	XGBE_LM_COPY(cmd, supported, lks, supported);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index d291976d8b76..0e552022e659 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1178,7 +1178,19 @@ static int xgbe_phy_config_fixed(struct xgbe_prv_data *pdata)
 	if (pdata->phy.duplex != DUPLEX_FULL)
 		return -EINVAL;
 
-	xgbe_set_mode(pdata, mode);
+	/* Force the mode change for SFI in Fixed PHY config.
+	 * Fixed PHY configs needs PLL to be enabled while doing mode set.
+	 * When the SFP module isn't connected during boot, driver assumes
+	 * AN is ON and attempts autonegotiation. However, if the connected
+	 * SFP comes up in Fixed PHY config, the link will not come up as
+	 * PLL isn't enabled while the initial mode set command is issued.
+	 * So, force the mode change for SFI in Fixed PHY configuration to
+	 * fix link issues.
+	 */
+	if (mode == XGBE_MODE_SFI)
+		xgbe_change_mode(pdata, mode);
+	else
+		xgbe_set_mode(pdata, mode);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a1906804c139..d70c82c926ea 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1392,13 +1392,13 @@ static int ravb_open(struct net_device *ndev)
 	if (priv->chip_id == RCAR_GEN2)
 		ravb_ptp_init(ndev, priv->pdev);
 
-	netif_tx_start_all_queues(ndev);
-
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
 	if (error)
 		goto out_ptp_stop;
 
+	netif_tx_start_all_queues(ndev);
+
 	return 0;
 
 out_ptp_stop:
@@ -1447,6 +1447,12 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	struct net_device *ndev = priv->ndev;
 	int error;
 
+	if (!rtnl_trylock()) {
+		usleep_range(1000, 2000);
+		schedule_work(&priv->work);
+		return;
+	}
+
 	netif_tx_stop_all_queues(ndev);
 
 	/* Stop PTP Clock driver */
@@ -1479,7 +1485,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		 */
 		netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n",
 			   __func__, error);
-		return;
+		goto out_unlock;
 	}
 	ravb_emac_init(ndev);
 
@@ -1489,6 +1495,9 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
+
+out_unlock:
+	rtnl_unlock();
 }
 
 /* Packet transmit function for Ethernet AVB */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 5190402f779e..299162a74939 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -702,7 +702,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
 			/* Tx Full Checksum Offload Enabled */
 			cur_p->app0 |= 2;
-		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
 			csum_start_off = skb_transport_offset(skb);
 			csum_index_off = csum_start_off + skb->csum_offset;
 			/* Tx Partial Checksum Offload Enabled */
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 9528932361a8..ce17917b6f76 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2048,9 +2048,6 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
-
 	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
@@ -2148,16 +2145,18 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 			return hv_get_drvdata(ndev_ctx->device_ctx);
 	}
 
-	/* Fallback path to check synthetic vf with
-	 * help of mac addr
+	/* Fallback path to check synthetic vf with help of mac addr.
+	 * Because this function can be called before vf_netdev is
+	 * initialized (NETDEV_POST_INIT) when its perm_addr has not been copied
+	 * from dev_addr, also try to match to its dev_addr.
+	 * Note: On Hyper-V and Azure, it's not possible to set a MAC address
+	 * on a VF that matches to the MAC of a unrelated NETVSC device.
 	 */
 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
 		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
-		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
-			netdev_notice(vf_netdev,
-				      "falling back to mac addr based matching\n");
+		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
+		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))
 			return ndev;
-		}
 	}
 
 	netdev_notice(vf_netdev,
@@ -2165,6 +2164,19 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	return NULL;
 }
 
+static int netvsc_prepare_bonding(struct net_device *vf_netdev)
+{
+	struct net_device *ndev;
+
+	ndev = get_netvsc_byslot(vf_netdev);
+	if (!ndev)
+		return NOTIFY_DONE;
+
+	/* set slave flag before open to prevent IPv6 addrconf */
+	vf_netdev->flags |= IFF_SLAVE;
+	return NOTIFY_DONE;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev)
 {
 	struct net_device_context *net_device_ctx;
@@ -2481,6 +2493,8 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_POST_INIT:
+		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
 		return netvsc_register_vf(event_dev);
 	case NETDEV_UNREGISTER:
@@ -2514,12 +2528,17 @@ static int __init netvsc_drv_init(void)
 	}
 	netvsc_ring_bytes = ring_size * PAGE_SIZE;
 
+	register_netdevice_notifier(&netvsc_netdev_notifier);
+
 	ret = vmbus_driver_register(&netvsc_drv);
 	if (ret)
-		return ret;
+		goto err_vmbus_reg;
 
-	register_netdevice_notifier(&netvsc_netdev_notifier);
 	return 0;
+
+err_vmbus_reg:
+	unregister_netdevice_notifier(&netvsc_netdev_notifier);
+	return ret;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index cf6ff8732fb2..3df203feb09c 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1610,11 +1610,11 @@ static int ax88179_reset(struct usbnet *dev)
 
 	*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
-	msleep(200);
+	msleep(500);
 
 	*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
-	msleep(100);
+	msleep(200);
 
 	/* Ethernet PHY Auto Detach*/
 	ax88179_auto_detach(dev, 0);
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index a8148460f99f..99f062546f77 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1224,17 +1224,17 @@ EXPORT_SYMBOL_GPL(pinctrl_lookup_state);
 static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
-	struct pinctrl_state *old_state = p->state;
+	struct pinctrl_state *old_state = READ_ONCE(p->state);
 	int ret;
 
-	if (p->state) {
+	if (old_state) {
 		/*
 		 * For each pinmux setting in the old state, forget SW's record
 		 * of mux owner for that pingroup. Any pingroups which are
 		 * still owned by the new state will be re-acquired by the call
 		 * to pinmux_enable_setting() in the loop below.
 		 */
-		list_for_each_entry(setting, &p->state->settings, node) {
+		list_for_each_entry(setting, &old_state->settings, node) {
 			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
 				continue;
 			pinmux_disable_setting(setting);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index c0eee7b00442..1161bbd7eb78 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -725,18 +725,20 @@ static void dasd_profile_start(struct dasd_block *block,
 	 * we count each request only once.
 	 */
 	device = cqr->startdev;
-	if (device->profile.data) {
-		counter = 1; /* request is not yet queued on the start device */
-		list_for_each(l, &device->ccw_queue)
-			if (++counter >= 31)
-				break;
-	}
+	if (!device->profile.data)
+		return;
+
+	spin_lock(get_ccwdev_lock(device->cdev));
+	counter = 1; /* request is not yet queued on the start device */
+	list_for_each(l, &device->ccw_queue)
+		if (++counter >= 31)
+			break;
+	spin_unlock(get_ccwdev_lock(device->cdev));
+
 	spin_lock(&device->profile.lock);
-	if (device->profile.data) {
-		device->profile.data->dasd_io_nr_req[counter]++;
-		if (rq_data_dir(req) == READ)
-			device->profile.data->dasd_read_nr_req[counter]++;
-	}
+	device->profile.data->dasd_io_nr_req[counter]++;
+	if (rq_data_dir(req) == READ)
+		device->profile.data->dasd_read_nr_req[counter]++;
 	spin_unlock(&device->profile.lock);
 }
 
diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index d5f4ec1b73b1..08e2792cb732 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -2045,15 +2045,17 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 {
 	struct dwc2_qtd *qtd;
 	struct dwc2_host_chan *chan;
-	u32 hcint, hcintmsk;
+	u32 hcint, hcintraw, hcintmsk;
 
 	chan = hsotg->hc_ptr_array[chnum];
 
-	hcint = dwc2_readl(hsotg, HCINT(chnum));
+	hcintraw = dwc2_readl(hsotg, HCINT(chnum));
 	hcintmsk = dwc2_readl(hsotg, HCINTMSK(chnum));
+	hcint = hcintraw & hcintmsk;
+	dwc2_writel(hsotg, hcint, HCINT(chnum));
+
 	if (!chan) {
 		dev_err(hsotg->dev, "## hc_ptr_array for channel is NULL ##\n");
-		dwc2_writel(hsotg, hcint, HCINT(chnum));
 		return;
 	}
 
@@ -2062,11 +2064,9 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 			 chnum);
 		dev_vdbg(hsotg->dev,
 			 "  hcint 0x%08x, hcintmsk 0x%08x, hcint&hcintmsk 0x%08x\n",
-			 hcint, hcintmsk, hcint & hcintmsk);
+			 hcintraw, hcintmsk, hcint);
 	}
 
-	dwc2_writel(hsotg, hcint, HCINT(chnum));
-
 	/*
 	 * If we got an interrupt after someone called
 	 * dwc2_hcd_endpoint_disable() we don't want to crash below
@@ -2076,8 +2076,7 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 		return;
 	}
 
-	chan->hcint = hcint;
-	hcint &= hcintmsk;
+	chan->hcint = hcintraw;
 
 	/*
 	 * If the channel was halted due to a dequeue, the qtd list might
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2f3bbf73656b..c6de1dcf2827 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1530,6 +1530,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 err5:
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 0f090188e265..3fc06ca8c1aa 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -329,7 +329,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
@@ -343,7 +343,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 DP_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
@@ -357,7 +357,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 DM_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
@@ -371,7 +371,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 SS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 7fab049e790f..06bbb8d7a804 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -203,8 +203,8 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
-#define DELL_PRODUCT_FM101R			0x8213
-#define DELL_PRODUCT_FM101R_ESIM		0x8215
+#define DELL_PRODUCT_FM101R_ESIM		0x8213
+#define DELL_PRODUCT_FM101R			0x8215
 
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
@@ -609,6 +609,8 @@ static void option_instat_callback(struct urb *urb);
 #define UNISOC_VENDOR_ID			0x1782
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
+/* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
+#define LUAT_PRODUCT_AIR720U			0x4e00
 
 /* Device flags */
 
@@ -1546,7 +1548,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0165, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0167, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff),
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0191, 0xff, 0xff, 0xff), /* ZTE EuFi890 */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0196, 0xff, 0xff, 0xff) },
@@ -2249,6 +2252,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1782, 0x4d11, 0xff) },			/* Fibocom L610 (ECM/RNDIS mode) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0001, 0xff, 0xff, 0xff) },	/* Fibocom L716-EU (ECM/RNDIS mode) */
 	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
 	  .driver_info = RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
@@ -2271,6 +2275,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/video/fbdev/sticore.h b/drivers/video/fbdev/sticore.h
index fb8f58f9867a..0416e2bc27d8 100644
--- a/drivers/video/fbdev/sticore.h
+++ b/drivers/video/fbdev/sticore.h
@@ -237,7 +237,7 @@ struct sti_rom_font {
 	 u8 height;
 	 u8 font_type;		/* language type */
 	 u8 bytes_per_char;
-	u32 next_font;
+	s32 next_font;		/* note: signed int */
 	 u8 underline_height;
 	 u8 underline_pos;
 	 u8 res008[2];
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 1f535cd990d3..cb584c044f8a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6860,7 +6860,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	sctx->flags = arg->flags;
 
 	sctx->send_filp = fget(arg->send_fd);
-	if (!sctx->send_filp) {
+	if (!sctx->send_filp || !(sctx->send_filp->f_mode & FMODE_WRITE)) {
 		ret = -EBADF;
 		goto out;
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b69d6f7012f4..ceced5e56c5a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2760,7 +2760,7 @@ static struct extent_map *get_chunk_map(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (em->start > logical || em->start + em->len < logical) {
+	if (em->start > logical || em->start + em->len <= logical) {
 		btrfs_crit(fs_info,
 			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
 			   logical, length, em->start, em->start + em->len);
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index ef1a43f4bd66..7c9e5ed1644b 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -970,6 +970,7 @@ const struct inode_operations cifs_file_inode_ops = {
 
 const struct inode_operations cifs_symlink_inode_ops = {
 	.get_link = cifs_get_link,
+	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 };
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 1a7a1e298885..1c1eb873e6ec 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -268,8 +268,8 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 		return 0;
 
 	/*
-	 * If this is a sync(2) call or an emergency sync, all the super blocks
-	 * will be iterated, including upper_sb, so no need to do anything.
+	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
+	 * All the super blocks will be iterated, including upper_sb.
 	 *
 	 * If this is a syncfs(2) call, then we do need to call
 	 * sync_filesystem() on upper_sb, but enough if we do it when being
@@ -1664,6 +1664,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_xattr = ovl_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
+	sb->s_iflags |= SB_I_SKIP_SYNC;
 
 	err = -ENOMEM;
 	root_dentry = d_make_root(ovl_new_inode(sb, S_IFDIR, 0));
diff --git a/fs/sync.c b/fs/sync.c
index b54e0541ad89..917ebd12c251 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -76,7 +76,8 @@ static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 
 static void sync_fs_one_sb(struct super_block *sb, void *arg)
 {
-	if (!sb_rdonly(sb) && sb->s_op->sync_fs)
+	if (!sb_rdonly(sb) && !(sb->s_iflags & SB_I_SKIP_SYNC) &&
+	    sb->s_op->sync_fs)
 		sb->s_op->sync_fs(sb, *(int *)arg);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 95b8ef09b76c..f89748aac8c3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1351,6 +1351,8 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
 #define SB_I_UNTRUSTED_MOUNTER		0x00000040
 
+#define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
+
 /* Possible states of 'frozen' field */
 enum {
 	SB_UNFROZEN = 0,		/* FS is unfrozen */
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 79c6c3b4e004..63c2333a5705 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -625,8 +625,13 @@ struct hid_device {							/* device report descriptor */
 	struct list_head debug_list;
 	spinlock_t  debug_list_lock;
 	wait_queue_head_t debug_wait;
+	struct kref			ref;
+
+	unsigned int id;						/* system unique id */
 };
 
+void hiddev_free(struct kref *ref);
+
 #define to_hid_device(pdev) \
 	container_of(pdev, struct hid_device, dev)
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 7d82818b711e..5edf426fa414 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -221,8 +221,10 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 	int tv = prandom_u32() % max_delay;
 
 	im->tm_running = 1;
-	if (!mod_timer(&im->timer, jiffies+tv+2))
-		refcount_inc(&im->refcnt);
+	if (refcount_inc_not_zero(&im->refcnt)) {
+		if (mod_timer(&im->timer, jiffies + tv + 2))
+			ip_ma_put(im);
+	}
 }
 
 static void igmp_gq_start_timer(struct in_device *in_dev)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 9753d07bfc0b..f4d41ceef946 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -791,7 +791,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 			goto reject_redirect;
 	}
 
-	n = __ipv4_neigh_lookup(rt->dst.dev, new_gw);
+	n = __ipv4_neigh_lookup(rt->dst.dev, (__force u32)new_gw);
 	if (!n)
 		n = neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
 	if (!IS_ERR(n)) {
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index d5b9253ebd12..7c751c23e7e6 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -69,9 +69,32 @@ struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
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
@@ -83,6 +106,14 @@ static void iint_free(struct integrity_iint_cache *iint)
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
 
@@ -107,6 +138,8 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	if (!iint)
 		return NULL;
 
+	iint_init_always(iint, inode);
+
 	write_lock(&integrity_iint_lock);
 
 	p = &integrity_iint_tree.rb_node;
@@ -156,25 +189,18 @@ void integrity_inode_free(struct inode *inode)
 	iint_free(iint);
 }
 
-static void init_once(void *foo)
+static void iint_init_once(void *foo)
 {
 	struct integrity_iint_cache *iint = foo;
 
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
 security_initcall(integrity_iintcache_init);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index a02c5acfd403..377a6f7cd3c7 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -201,6 +201,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
+	struct inode *real_inode = d_real_inode(file_dentry(file));
 	const char *filename = file->f_path.dentry->d_name.name;
 	int result = 0;
 	int length;
@@ -243,6 +244,10 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
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
index c85aab3bd398..d9a33d433b9f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -29,6 +29,7 @@
 #include <linux/ima.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
+#include <linux/iversion.h>
 
 #include "ima.h"
 
@@ -170,7 +171,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *backing_inode, *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
 	struct ima_template_desc *template_desc;
 	char *pathbuf = NULL;
@@ -242,6 +243,19 @@ static int process_measurement(struct file *file, const struct cred *cred,
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
index e60473b13a8d..b0264ba45ddd 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -122,6 +122,8 @@ struct integrity_iint_cache {
 	unsigned long flags;
 	unsigned long measured_pcrs;
 	unsigned long atomic_flags;
+	unsigned long real_ino;
+	dev_t real_dev;
 	enum integrity_status ima_file_status:4;
 	enum integrity_status ima_mmap_status:4;
 	enum integrity_status ima_bprm_status:4;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index aaca36250dda..e66d8729c72f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2371,6 +2371,8 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugs.launchpad.net/bugs/1821663 */
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
+	/* KONTRON SinglePC may cause a stall at runtime resume */
+	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
 	{}
 };
 #endif /* CONFIG_PM */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 184f6af9c210..44daf2a57d7e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1917,6 +1917,7 @@ enum {
 	ALC887_FIXUP_ASUS_AUDIO,
 	ALC887_FIXUP_ASUS_HMIC,
 	ALCS1200A_FIXUP_MIC_VREF,
+	ALC888VD_FIXUP_MIC_100VREF,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2470,6 +2471,13 @@ static const struct hda_fixup alc882_fixups[] = {
 			{}
 		}
 	},
+	[ALC888VD_FIXUP_MIC_100VREF] = {
+		.type = HDA_FIXUP_PINCTLS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, PIN_VREF100 }, /* headset mic */
+			{}
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2539,6 +2547,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x4a00, "Macbook 5,2", ALC889_FIXUP_MBA11_VREF),
 
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
+	SND_PCI_QUIRK(0x10ec, 0x12d8, "iBase Elo Touch", ALC888VD_FIXUP_MIC_100VREF),
 	SND_PCI_QUIRK(0x13fe, 0x1009, "Advantech MIT-W101", ALC886_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
