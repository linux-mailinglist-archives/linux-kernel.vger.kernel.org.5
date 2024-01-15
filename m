Return-Path: <linux-kernel+bounces-26346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F11B82DED0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507E01C21FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C1182D4;
	Mon, 15 Jan 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gwdEC1gK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8018E37;
	Mon, 15 Jan 2024 18:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7A4C433C7;
	Mon, 15 Jan 2024 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705341699;
	bh=QDVtRI2AjC821s5TZTQIRvwvdE6ZeslSKR/3A0SMYis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwdEC1gKYYANWPB5qdcSpLC1zMit6Gyph041EZBjj/+GDaMpXBYGXnJgAHdQlg8qG
	 //ZAiksm4qlxoW55blUYPSKnlLClXxb/6u9xOp2EeyMsUIfMVciCusEH5ZeXHqXis+
	 JB1/GrefUbDVxOtrLbqjkaW0qeRfr4VvqncpzWi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.208
Date: Mon, 15 Jan 2024 19:01:35 +0100
Message-ID: <2024011533-penpal-mousy-59ef@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024011532-lustiness-hybrid-fc72@gregkh>
References: <2024011532-lustiness-hybrid-fc72@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 2435bf3197de..a4b42141ba1b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 207
+SUBLEVEL = 208
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 26cbce135338..b2f5f4f28705 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -808,12 +808,12 @@ static int __init sunxi_mc_smp_init(void)
 			break;
 	}
 
-	is_a83t = sunxi_mc_smp_data[i].is_a83t;
-
 	of_node_put(node);
 	if (ret)
 		return -ENODEV;
 
+	is_a83t = sunxi_mc_smp_data[i].is_a83t;
+
 	if (!sunxi_mc_smp_cpu_table_init())
 		return -EINVAL;
 
diff --git a/arch/powerpc/kernel/ppc_save_regs.S b/arch/powerpc/kernel/ppc_save_regs.S
index 2d4d21bb46a9..5d284f78b0b4 100644
--- a/arch/powerpc/kernel/ppc_save_regs.S
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -58,10 +58,10 @@ _GLOBAL(ppc_save_regs)
 	lbz	r0,PACAIRQSOFTMASK(r13)
 	PPC_STL	r0,SOFTE-STACK_FRAME_OVERHEAD(r3)
 #endif
-	/* go up one stack frame for SP */
-	PPC_LL	r4,0(r1)
-	PPC_STL	r4,1*SZL(r3)
+	/* store current SP */
+	PPC_STL r1,1*SZL(r3)
 	/* get caller's LR */
+	PPC_LL	r4,0(r1)
 	PPC_LL	r0,LRSAVE(r4)
 	PPC_STL	r0,_LINK-STACK_FRAME_OVERHEAD(r3)
 	mflr	r0
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index c78b4946385e..e7edc9e4c6cd 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -569,7 +569,8 @@ static void kprobe_emulate_call_indirect(struct kprobe *p, struct pt_regs *regs)
 {
 	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
 
-	int3_emulate_call(regs, regs_get_register(regs, offs));
+	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + p->ainsn.size);
+	int3_emulate_jmp(regs, regs_get_register(regs, offs));
 }
 NOKPROBE_SYMBOL(kprobe_emulate_call_indirect);
 
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 9811c40956e5..45d19cc0aeac 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -279,6 +279,51 @@ static char ohci_driver_name[] = KBUILD_MODNAME;
 #define QUIRK_TI_SLLZ059		0x20
 #define QUIRK_IR_WAKE			0x40
 
+// On PCI Express Root Complex in any type of AMD Ryzen machine, VIA VT6306/6307/6308 with Asmedia
+// ASM1083/1085 brings an inconvenience that the read accesses to 'Isochronous Cycle Timer' register
+// (at offset 0xf0 in PCI I/O space) often causes unexpected system reboot. The mechanism is not
+// clear, since the read access to the other registers is enough safe; e.g. 'Node ID' register,
+// while it is probable due to detection of any type of PCIe error.
+#define QUIRK_REBOOT_BY_CYCLE_TIMER_READ	0x80000000
+
+#if IS_ENABLED(CONFIG_X86)
+
+static bool has_reboot_by_cycle_timer_read_quirk(const struct fw_ohci *ohci)
+{
+	return !!(ohci->quirks & QUIRK_REBOOT_BY_CYCLE_TIMER_READ);
+}
+
+#define PCI_DEVICE_ID_ASMEDIA_ASM108X	0x1080
+
+static bool detect_vt630x_with_asm1083_on_amd_ryzen_machine(const struct pci_dev *pdev)
+{
+	const struct pci_dev *pcie_to_pci_bridge;
+
+	// Detect any type of AMD Ryzen machine.
+	if (!static_cpu_has(X86_FEATURE_ZEN))
+		return false;
+
+	// Detect VIA VT6306/6307/6308.
+	if (pdev->vendor != PCI_VENDOR_ID_VIA)
+		return false;
+	if (pdev->device != PCI_DEVICE_ID_VIA_VT630X)
+		return false;
+
+	// Detect Asmedia ASM1083/1085.
+	pcie_to_pci_bridge = pdev->bus->self;
+	if (pcie_to_pci_bridge->vendor != PCI_VENDOR_ID_ASMEDIA)
+		return false;
+	if (pcie_to_pci_bridge->device != PCI_DEVICE_ID_ASMEDIA_ASM108X)
+		return false;
+
+	return true;
+}
+
+#else
+#define has_reboot_by_cycle_timer_read_quirk(ohci) false
+#define detect_vt630x_with_asm1083_on_amd_ryzen_machine(pdev)	false
+#endif
+
 /* In case of multiple matches in ohci_quirks[], only the first one is used. */
 static const struct {
 	unsigned short vendor, device, revision, flags;
@@ -1713,6 +1758,9 @@ static u32 get_cycle_time(struct fw_ohci *ohci)
 	s32 diff01, diff12;
 	int i;
 
+	if (has_reboot_by_cycle_timer_read_quirk(ohci))
+		return 0;
+
 	c2 = reg_read(ohci, OHCI1394_IsochronousCycleTimer);
 
 	if (ohci->quirks & QUIRK_CYCLE_TIMER) {
@@ -3615,6 +3663,9 @@ static int pci_probe(struct pci_dev *dev,
 	if (param_quirks)
 		ohci->quirks = param_quirks;
 
+	if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev))
+		ohci->quirks |= QUIRK_REBOOT_BY_CYCLE_TIMER_READ;
+
 	/*
 	 * Because dma_alloc_coherent() allocates at least one page,
 	 * we save space by using a common buffer for the AR request/
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 7f633f8b3239..a79c62c43a6f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5584,7 +5584,7 @@ void intel_dp_process_phy_request(struct intel_dp *intel_dp)
 	intel_dp_autotest_phy_ddi_enable(intel_dp, data->num_lanes);
 
 	drm_dp_set_phy_test_pattern(&intel_dp->aux, data,
-				    link_status[DP_DPCD_REV]);
+				    intel_dp->dpcd[DP_DPCD_REV]);
 }
 
 static u8 intel_dp_autotest_phy_pattern(struct intel_dp *intel_dp)
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index aae90a9ee1db..ee59ef2cba77 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -329,7 +329,7 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 				      u32 domain,
 				      size_t size,
 				      struct qxl_surface *surf,
-				      struct qxl_bo **qobj,
+				      struct drm_gem_object **gobj,
 				      uint32_t *handle);
 void qxl_gem_object_free(struct drm_gem_object *gobj);
 int qxl_gem_object_open(struct drm_gem_object *obj, struct drm_file *file_priv);
diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
index e377bdbff90d..f7bafc791b1e 100644
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -34,6 +34,7 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 {
 	struct qxl_device *qdev = to_qxl(dev);
 	struct qxl_bo *qobj;
+	struct drm_gem_object *gobj;
 	uint32_t handle;
 	int r;
 	struct qxl_surface surf;
@@ -62,11 +63,13 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 
 	r = qxl_gem_object_create_with_handle(qdev, file_priv,
 					      QXL_GEM_DOMAIN_SURFACE,
-					      args->size, &surf, &qobj,
+					      args->size, &surf, &gobj,
 					      &handle);
 	if (r)
 		return r;
+	qobj = gem_to_qxl_bo(gobj);
 	qobj->is_dumb = true;
+	drm_gem_object_put(gobj);
 	args->pitch = pitch;
 	args->handle = handle;
 	return 0;
diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index a08da0bd9098..fc5e3763c359 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -72,32 +72,41 @@ int qxl_gem_object_create(struct qxl_device *qdev, int size,
 	return 0;
 }
 
+/*
+ * If the caller passed a valid gobj pointer, it is responsible to call
+ * drm_gem_object_put() when it no longer needs to acess the object.
+ *
+ * If gobj is NULL, it is handled internally.
+ */
 int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 				      struct drm_file *file_priv,
 				      u32 domain,
 				      size_t size,
 				      struct qxl_surface *surf,
-				      struct qxl_bo **qobj,
+				      struct drm_gem_object **gobj,
 				      uint32_t *handle)
 {
-	struct drm_gem_object *gobj;
 	int r;
+	struct drm_gem_object *local_gobj;
 
-	BUG_ON(!qobj);
 	BUG_ON(!handle);
 
 	r = qxl_gem_object_create(qdev, size, 0,
 				  domain,
 				  false, false, surf,
-				  &gobj);
+				  &local_gobj);
 	if (r)
 		return -ENOMEM;
-	r = drm_gem_handle_create(file_priv, gobj, handle);
+	r = drm_gem_handle_create(file_priv, local_gobj, handle);
 	if (r)
 		return r;
-	/* drop reference from allocate - handle holds it now */
-	*qobj = gem_to_qxl_bo(gobj);
-	drm_gem_object_put(gobj);
+
+	if (gobj)
+		*gobj = local_gobj;
+	else
+		/* drop reference from allocate - handle holds it now */
+		drm_gem_object_put(local_gobj);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 5cea6eea72ab..9a02c4871400 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -39,7 +39,6 @@ static int qxl_alloc_ioctl(struct drm_device *dev, void *data,
 	struct qxl_device *qdev = to_qxl(dev);
 	struct drm_qxl_alloc *qxl_alloc = data;
 	int ret;
-	struct qxl_bo *qobj;
 	uint32_t handle;
 	u32 domain = QXL_GEM_DOMAIN_VRAM;
 
@@ -51,7 +50,7 @@ static int qxl_alloc_ioctl(struct drm_device *dev, void *data,
 						domain,
 						qxl_alloc->size,
 						NULL,
-						&qobj, &handle);
+						NULL, &handle);
 	if (ret) {
 		DRM_ERROR("%s: failed to create gem ret=%d\n",
 			  __func__, ret);
@@ -393,7 +392,6 @@ static int qxl_alloc_surf_ioctl(struct drm_device *dev, void *data,
 {
 	struct qxl_device *qdev = to_qxl(dev);
 	struct drm_qxl_alloc_surf *param = data;
-	struct qxl_bo *qobj;
 	int handle;
 	int ret;
 	int size, actual_stride;
@@ -413,7 +411,7 @@ static int qxl_alloc_surf_ioctl(struct drm_device *dev, void *data,
 						QXL_GEM_DOMAIN_SURFACE,
 						size,
 						&surf,
-						&qobj, &handle);
+						NULL, &handle);
 	if (ret) {
 		DRM_ERROR("%s: failed to create gem ret=%d\n",
 			  __func__, ret);
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index ea17f13b44c8..ec28024a646d 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -3,6 +3,7 @@
  * i2c-core.h - interfaces internal to the I2C framework
  */
 
+#include <linux/kconfig.h>
 #include <linux/rwsem.h>
 
 struct i2c_devinfo {
@@ -29,7 +30,8 @@ int i2c_dev_irq_from_resources(const struct resource *resources,
  */
 static inline bool i2c_in_atomic_xfer_mode(void)
 {
-	return system_state > SYSTEM_RUNNING && !preemptible();
+	return system_state > SYSTEM_RUNNING &&
+	       (IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled());
 }
 
 static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 41d98d7198be..8d842ff241b2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -800,9 +800,10 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -817,9 +818,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
@@ -3102,4 +3104,3 @@ module_exit(mmc_blk_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 1f46694b2e53..b949a4468bf5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -612,6 +612,7 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
+	cancel_delayed_work_sync(&host->detect);
 	mmc_pwrseq_free(host);
 	put_device(&host->class_dev);
 }
diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 28aa78aa08f3..ba59061fea8b 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -269,7 +269,7 @@ static int meson_mx_sdhc_enable_clks(struct mmc_host *mmc)
 static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
-	u32 rx_clk_phase;
+	u32 val, rx_clk_phase;
 	int ret;
 
 	meson_mx_sdhc_disable_clks(mmc);
@@ -290,27 +290,11 @@ static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
 		mmc->actual_clock = clk_get_rate(host->sd_clk);
 
 		/*
-		 * according to Amlogic the following latching points are
-		 * selected with empirical values, there is no (known) formula
-		 * to calculate these.
+		 * Phase 90 should work in most cases. For data transmission,
+		 * meson_mx_sdhc_execute_tuning() will find a accurate value
 		 */
-		if (mmc->actual_clock > 100000000) {
-			rx_clk_phase = 1;
-		} else if (mmc->actual_clock > 45000000) {
-			if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
-				rx_clk_phase = 15;
-			else
-				rx_clk_phase = 11;
-		} else if (mmc->actual_clock >= 25000000) {
-			rx_clk_phase = 15;
-		} else if (mmc->actual_clock > 5000000) {
-			rx_clk_phase = 23;
-		} else if (mmc->actual_clock > 1000000) {
-			rx_clk_phase = 55;
-		} else {
-			rx_clk_phase = 1061;
-		}
-
+		regmap_read(host->regmap, MESON_SDHC_CLKC, &val);
+		rx_clk_phase = FIELD_GET(MESON_SDHC_CLKC_CLK_DIV, val) / 4;
 		regmap_update_bits(host->regmap, MESON_SDHC_CLK2,
 				   MESON_SDHC_CLK2_RX_CLK_PHASE,
 				   FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE,
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d8e412bbb93b..52bfe356f1e5 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -224,15 +224,19 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
 	div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
 	sdhci_enable_clk(host, div);
 
+	val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
+	mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN | SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
 	/* Enable CLK_AUTO when the clock is greater than 400K. */
 	if (clk > 400000) {
-		val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
-		mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
-			SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
 		if (mask != (val & mask)) {
 			val |= mask;
 			sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
 		}
+	} else {
+		if (val & mask) {
+			val &= ~mask;
+			sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c67a108c2c07..584f365de563 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11143,6 +11143,8 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_cfg_ntp_filters(bp);
 	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event))
 		bnxt_hwrm_exec_fwd_req(bp);
+	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
+		netdev_info(bp->dev, "Receive PF driver unload event!\n");
 	if (test_and_clear_bit(BNXT_PERIODIC_STATS_SP_EVENT, &bp->sp_event)) {
 		bnxt_hwrm_port_qstats(bp, 0);
 		bnxt_hwrm_port_qstats_ext(bp, 0);
@@ -12097,8 +12099,6 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 			}
 		}
 	}
-	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
-		netdev_info(bp->dev, "Receive PF driver unload event!\n");
 }
 
 #else
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 145488449f13..8edf12077e66 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2086,8 +2086,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Note: if we ever change from DMA_TX_APPEND_CRC below we
 		 * will need to restore software padding of "runt" packets
 		 */
+		len_stat |= DMA_TX_APPEND_CRC;
+
 		if (!i) {
-			len_stat |= DMA_TX_APPEND_CRC | DMA_SOP;
+			len_stat |= DMA_SOP;
 			if (skb->ip_summed == CHECKSUM_PARTIAL)
 				len_stat |= DMA_TX_DO_CSUM;
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 36e387ae967f..d83b96aa3e42 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -101,12 +101,18 @@ static struct workqueue_struct *i40e_wq;
 static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
 				  struct net_device *netdev, int delta)
 {
+	struct netdev_hw_addr_list *ha_list;
 	struct netdev_hw_addr *ha;
 
 	if (!f || !netdev)
 		return;
 
-	netdev_for_each_mc_addr(ha, netdev) {
+	if (is_unicast_ether_addr(f->macaddr) || is_link_local_ether_addr(f->macaddr))
+		ha_list = &netdev->uc;
+	else
+		ha_list = &netdev->mc;
+
+	netdev_hw_addr_list_for_each(ha, ha_list) {
 		if (ether_addr_equal(ha->addr, f->macaddr)) {
 			ha->refcount += delta;
 			if (ha->refcount <= 0)
@@ -15758,6 +15764,9 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 
 	i40e_reset_and_rebuild(pf, false, false);
+#ifdef CONFIG_PCI_IOV
+	i40e_restore_all_vfs_msi_state(pdev);
+#endif /* CONFIG_PCI_IOV */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index dfaa34f2473a..7b0ed15f4df3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -99,6 +99,32 @@ void i40e_vc_notify_reset(struct i40e_pf *pf)
 			     (u8 *)&pfe, sizeof(struct virtchnl_pf_event));
 }
 
+#ifdef CONFIG_PCI_IOV
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)
+{
+	u16 vf_id;
+	u16 pos;
+
+	/* Continue only if this is a PF */
+	if (!pdev->is_physfn)
+		return;
+
+	if (!pci_num_vf(pdev))
+		return;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (pos) {
+		struct pci_dev *vf_dev = NULL;
+
+		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
+		while ((vf_dev = pci_get_device(pdev->vendor, vf_id, vf_dev))) {
+			if (vf_dev->is_virtfn && vf_dev->physfn == pdev)
+				pci_restore_msi_state(vf_dev);
+		}
+	}
+}
+#endif /* CONFIG_PCI_IOV */
+
 /**
  * i40e_vc_notify_vf_reset
  * @vf: pointer to the VF structure
@@ -3369,16 +3395,16 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 	bool found = false;
 	int bkt;
 
-	if (!tc_filter->action) {
+	if (tc_filter->action != VIRTCHNL_ACTION_TC_REDIRECT) {
 		dev_info(&pf->pdev->dev,
-			 "VF %d: Currently ADq doesn't support Drop Action\n",
-			 vf->vf_id);
+			 "VF %d: ADQ doesn't support this action (%d)\n",
+			 vf->vf_id, tc_filter->action);
 		goto err;
 	}
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > I40E_MAX_VF_VSI) {
+	    tc_filter->action_meta > vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 358bbdb58795..bd497cc5303a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -135,6 +135,9 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
 
 void i40e_vc_notify_link_state(struct i40e_pf *pf);
 void i40e_vc_notify_reset(struct i40e_pf *pf);
+#ifdef CONFIG_PCI_IOV
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev);
+#endif /* CONFIG_PCI_IOV */
 int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 		      struct ifla_vf_stats *vf_stats);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 407b9477da24..dc34e564c919 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -359,7 +359,7 @@ struct npc_lt_def {
 	u8	ltype_mask;
 	u8	ltype_match;
 	u8	lid;
-};
+} __packed;
 
 struct npc_lt_def_ipsec {
 	u8	ltype_mask;
@@ -367,7 +367,7 @@ struct npc_lt_def_ipsec {
 	u8	lid;
 	u8	spi_offset;
 	u8	spi_nz;
-};
+} __packed;
 
 struct npc_lt_def_cfg {
 	struct npc_lt_def	rx_ol2;
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 99fd35a8ca75..127daad4410b 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -315,12 +315,11 @@ static void ql_release_to_lrg_buf_free_list(struct ql3_adapter *qdev,
 			 * buffer
 			 */
 			skb_reserve(lrg_buf_cb->skb, QL_HEADER_SPACE);
-			map = pci_map_single(qdev->pdev,
+			map = dma_map_single(&qdev->pdev->dev,
 					     lrg_buf_cb->skb->data,
-					     qdev->lrg_buffer_len -
-					     QL_HEADER_SPACE,
-					     PCI_DMA_FROMDEVICE);
-			err = pci_dma_mapping_error(qdev->pdev, map);
+					     qdev->lrg_buffer_len - QL_HEADER_SPACE,
+					     DMA_FROM_DEVICE);
+			err = dma_mapping_error(&qdev->pdev->dev, map);
 			if (err) {
 				netdev_err(qdev->ndev,
 					   "PCI mapping failed with error: %d\n",
@@ -1802,13 +1801,12 @@ static int ql_populate_free_queue(struct ql3_adapter *qdev)
 				 * first buffer
 				 */
 				skb_reserve(lrg_buf_cb->skb, QL_HEADER_SPACE);
-				map = pci_map_single(qdev->pdev,
+				map = dma_map_single(&qdev->pdev->dev,
 						     lrg_buf_cb->skb->data,
-						     qdev->lrg_buffer_len -
-						     QL_HEADER_SPACE,
-						     PCI_DMA_FROMDEVICE);
+						     qdev->lrg_buffer_len - QL_HEADER_SPACE,
+						     DMA_FROM_DEVICE);
 
-				err = pci_dma_mapping_error(qdev->pdev, map);
+				err = dma_mapping_error(&qdev->pdev->dev, map);
 				if (err) {
 					netdev_err(qdev->ndev,
 						   "PCI mapping failed with error: %d\n",
@@ -1943,18 +1941,16 @@ static void ql_process_mac_tx_intr(struct ql3_adapter *qdev,
 		goto invalid_seg_count;
 	}
 
-	pci_unmap_single(qdev->pdev,
+	dma_unmap_single(&qdev->pdev->dev,
 			 dma_unmap_addr(&tx_cb->map[0], mapaddr),
-			 dma_unmap_len(&tx_cb->map[0], maplen),
-			 PCI_DMA_TODEVICE);
+			 dma_unmap_len(&tx_cb->map[0], maplen), DMA_TO_DEVICE);
 	tx_cb->seg_count--;
 	if (tx_cb->seg_count) {
 		for (i = 1; i < tx_cb->seg_count; i++) {
-			pci_unmap_page(qdev->pdev,
-				       dma_unmap_addr(&tx_cb->map[i],
-						      mapaddr),
+			dma_unmap_page(&qdev->pdev->dev,
+				       dma_unmap_addr(&tx_cb->map[i], mapaddr),
 				       dma_unmap_len(&tx_cb->map[i], maplen),
-				       PCI_DMA_TODEVICE);
+				       DMA_TO_DEVICE);
 		}
 	}
 	qdev->ndev->stats.tx_packets++;
@@ -2021,10 +2017,9 @@ static void ql_process_mac_rx_intr(struct ql3_adapter *qdev,
 	qdev->ndev->stats.rx_bytes += length;
 
 	skb_put(skb, length);
-	pci_unmap_single(qdev->pdev,
+	dma_unmap_single(&qdev->pdev->dev,
 			 dma_unmap_addr(lrg_buf_cb2, mapaddr),
-			 dma_unmap_len(lrg_buf_cb2, maplen),
-			 PCI_DMA_FROMDEVICE);
+			 dma_unmap_len(lrg_buf_cb2, maplen), DMA_FROM_DEVICE);
 	prefetch(skb->data);
 	skb_checksum_none_assert(skb);
 	skb->protocol = eth_type_trans(skb, qdev->ndev);
@@ -2067,10 +2062,9 @@ static void ql_process_macip_rx_intr(struct ql3_adapter *qdev,
 	skb2 = lrg_buf_cb2->skb;
 
 	skb_put(skb2, length);	/* Just the second buffer length here. */
-	pci_unmap_single(qdev->pdev,
+	dma_unmap_single(&qdev->pdev->dev,
 			 dma_unmap_addr(lrg_buf_cb2, mapaddr),
-			 dma_unmap_len(lrg_buf_cb2, maplen),
-			 PCI_DMA_FROMDEVICE);
+			 dma_unmap_len(lrg_buf_cb2, maplen), DMA_FROM_DEVICE);
 	prefetch(skb2->data);
 
 	skb_checksum_none_assert(skb2);
@@ -2319,9 +2313,9 @@ static int ql_send_map(struct ql3_adapter *qdev,
 	/*
 	 * Map the skb buffer first.
 	 */
-	map = pci_map_single(qdev->pdev, skb->data, len, PCI_DMA_TODEVICE);
+	map = dma_map_single(&qdev->pdev->dev, skb->data, len, DMA_TO_DEVICE);
 
-	err = pci_dma_mapping_error(qdev->pdev, map);
+	err = dma_mapping_error(&qdev->pdev->dev, map);
 	if (err) {
 		netdev_err(qdev->ndev, "PCI mapping failed with error: %d\n",
 			   err);
@@ -2357,11 +2351,11 @@ static int ql_send_map(struct ql3_adapter *qdev,
 		    (seg == 7 && seg_cnt > 8) ||
 		    (seg == 12 && seg_cnt > 13) ||
 		    (seg == 17 && seg_cnt > 18)) {
-			map = pci_map_single(qdev->pdev, oal,
+			map = dma_map_single(&qdev->pdev->dev, oal,
 					     sizeof(struct oal),
-					     PCI_DMA_TODEVICE);
+					     DMA_TO_DEVICE);
 
-			err = pci_dma_mapping_error(qdev->pdev, map);
+			err = dma_mapping_error(&qdev->pdev->dev, map);
 			if (err) {
 				netdev_err(qdev->ndev,
 					   "PCI mapping outbound address list with error: %d\n",
@@ -2423,24 +2417,24 @@ static int ql_send_map(struct ql3_adapter *qdev,
 		    (seg == 7 && seg_cnt > 8) ||
 		    (seg == 12 && seg_cnt > 13) ||
 		    (seg == 17 && seg_cnt > 18)) {
-			pci_unmap_single(qdev->pdev,
-				dma_unmap_addr(&tx_cb->map[seg], mapaddr),
-				dma_unmap_len(&tx_cb->map[seg], maplen),
-				 PCI_DMA_TODEVICE);
+			dma_unmap_single(&qdev->pdev->dev,
+					 dma_unmap_addr(&tx_cb->map[seg], mapaddr),
+					 dma_unmap_len(&tx_cb->map[seg], maplen),
+					 DMA_TO_DEVICE);
 			oal++;
 			seg++;
 		}
 
-		pci_unmap_page(qdev->pdev,
+		dma_unmap_page(&qdev->pdev->dev,
 			       dma_unmap_addr(&tx_cb->map[seg], mapaddr),
 			       dma_unmap_len(&tx_cb->map[seg], maplen),
-			       PCI_DMA_TODEVICE);
+			       DMA_TO_DEVICE);
 	}
 
-	pci_unmap_single(qdev->pdev,
+	dma_unmap_single(&qdev->pdev->dev,
 			 dma_unmap_addr(&tx_cb->map[0], mapaddr),
 			 dma_unmap_addr(&tx_cb->map[0], maplen),
-			 PCI_DMA_TODEVICE);
+			 DMA_TO_DEVICE);
 
 	return NETDEV_TX_BUSY;
 
@@ -2526,9 +2520,8 @@ static int ql_alloc_net_req_rsp_queues(struct ql3_adapter *qdev)
 	wmb();
 
 	qdev->req_q_virt_addr =
-	    pci_alloc_consistent(qdev->pdev,
-				 (size_t) qdev->req_q_size,
-				 &qdev->req_q_phy_addr);
+	    dma_alloc_coherent(&qdev->pdev->dev, (size_t)qdev->req_q_size,
+			       &qdev->req_q_phy_addr, GFP_KERNEL);
 
 	if ((qdev->req_q_virt_addr == NULL) ||
 	    LS_64BITS(qdev->req_q_phy_addr) & (qdev->req_q_size - 1)) {
@@ -2537,16 +2530,14 @@ static int ql_alloc_net_req_rsp_queues(struct ql3_adapter *qdev)
 	}
 
 	qdev->rsp_q_virt_addr =
-	    pci_alloc_consistent(qdev->pdev,
-				 (size_t) qdev->rsp_q_size,
-				 &qdev->rsp_q_phy_addr);
+	    dma_alloc_coherent(&qdev->pdev->dev, (size_t)qdev->rsp_q_size,
+			       &qdev->rsp_q_phy_addr, GFP_KERNEL);
 
 	if ((qdev->rsp_q_virt_addr == NULL) ||
 	    LS_64BITS(qdev->rsp_q_phy_addr) & (qdev->rsp_q_size - 1)) {
 		netdev_err(qdev->ndev, "rspQ allocation failed\n");
-		pci_free_consistent(qdev->pdev, (size_t) qdev->req_q_size,
-				    qdev->req_q_virt_addr,
-				    qdev->req_q_phy_addr);
+		dma_free_coherent(&qdev->pdev->dev, (size_t)qdev->req_q_size,
+				  qdev->req_q_virt_addr, qdev->req_q_phy_addr);
 		return -ENOMEM;
 	}
 
@@ -2562,15 +2553,13 @@ static void ql_free_net_req_rsp_queues(struct ql3_adapter *qdev)
 		return;
 	}
 
-	pci_free_consistent(qdev->pdev,
-			    qdev->req_q_size,
-			    qdev->req_q_virt_addr, qdev->req_q_phy_addr);
+	dma_free_coherent(&qdev->pdev->dev, qdev->req_q_size,
+			  qdev->req_q_virt_addr, qdev->req_q_phy_addr);
 
 	qdev->req_q_virt_addr = NULL;
 
-	pci_free_consistent(qdev->pdev,
-			    qdev->rsp_q_size,
-			    qdev->rsp_q_virt_addr, qdev->rsp_q_phy_addr);
+	dma_free_coherent(&qdev->pdev->dev, qdev->rsp_q_size,
+			  qdev->rsp_q_virt_addr, qdev->rsp_q_phy_addr);
 
 	qdev->rsp_q_virt_addr = NULL;
 
@@ -2594,12 +2583,13 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 		return -ENOMEM;
 
 	qdev->lrg_buf_q_alloc_virt_addr =
-		pci_alloc_consistent(qdev->pdev,
-				     qdev->lrg_buf_q_alloc_size,
-				     &qdev->lrg_buf_q_alloc_phy_addr);
+		dma_alloc_coherent(&qdev->pdev->dev,
+				   qdev->lrg_buf_q_alloc_size,
+				   &qdev->lrg_buf_q_alloc_phy_addr, GFP_KERNEL);
 
 	if (qdev->lrg_buf_q_alloc_virt_addr == NULL) {
 		netdev_err(qdev->ndev, "lBufQ failed\n");
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 	qdev->lrg_buf_q_virt_addr = qdev->lrg_buf_q_alloc_virt_addr;
@@ -2614,15 +2604,17 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 		qdev->small_buf_q_alloc_size = qdev->small_buf_q_size * 2;
 
 	qdev->small_buf_q_alloc_virt_addr =
-		pci_alloc_consistent(qdev->pdev,
-				     qdev->small_buf_q_alloc_size,
-				     &qdev->small_buf_q_alloc_phy_addr);
+		dma_alloc_coherent(&qdev->pdev->dev,
+				   qdev->small_buf_q_alloc_size,
+				   &qdev->small_buf_q_alloc_phy_addr, GFP_KERNEL);
 
 	if (qdev->small_buf_q_alloc_virt_addr == NULL) {
 		netdev_err(qdev->ndev, "Small Buffer Queue allocation failed\n");
-		pci_free_consistent(qdev->pdev, qdev->lrg_buf_q_alloc_size,
-				    qdev->lrg_buf_q_alloc_virt_addr,
-				    qdev->lrg_buf_q_alloc_phy_addr);
+		dma_free_coherent(&qdev->pdev->dev,
+				  qdev->lrg_buf_q_alloc_size,
+				  qdev->lrg_buf_q_alloc_virt_addr,
+				  qdev->lrg_buf_q_alloc_phy_addr);
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 
@@ -2639,17 +2631,15 @@ static void ql_free_buffer_queues(struct ql3_adapter *qdev)
 		return;
 	}
 	kfree(qdev->lrg_buf);
-	pci_free_consistent(qdev->pdev,
-			    qdev->lrg_buf_q_alloc_size,
-			    qdev->lrg_buf_q_alloc_virt_addr,
-			    qdev->lrg_buf_q_alloc_phy_addr);
+	dma_free_coherent(&qdev->pdev->dev, qdev->lrg_buf_q_alloc_size,
+			  qdev->lrg_buf_q_alloc_virt_addr,
+			  qdev->lrg_buf_q_alloc_phy_addr);
 
 	qdev->lrg_buf_q_virt_addr = NULL;
 
-	pci_free_consistent(qdev->pdev,
-			    qdev->small_buf_q_alloc_size,
-			    qdev->small_buf_q_alloc_virt_addr,
-			    qdev->small_buf_q_alloc_phy_addr);
+	dma_free_coherent(&qdev->pdev->dev, qdev->small_buf_q_alloc_size,
+			  qdev->small_buf_q_alloc_virt_addr,
+			  qdev->small_buf_q_alloc_phy_addr);
 
 	qdev->small_buf_q_virt_addr = NULL;
 
@@ -2667,9 +2657,9 @@ static int ql_alloc_small_buffers(struct ql3_adapter *qdev)
 		 QL_SMALL_BUFFER_SIZE);
 
 	qdev->small_buf_virt_addr =
-		pci_alloc_consistent(qdev->pdev,
-				     qdev->small_buf_total_size,
-				     &qdev->small_buf_phy_addr);
+		dma_alloc_coherent(&qdev->pdev->dev,
+				   qdev->small_buf_total_size,
+				   &qdev->small_buf_phy_addr, GFP_KERNEL);
 
 	if (qdev->small_buf_virt_addr == NULL) {
 		netdev_err(qdev->ndev, "Failed to get small buffer memory\n");
@@ -2702,10 +2692,10 @@ static void ql_free_small_buffers(struct ql3_adapter *qdev)
 		return;
 	}
 	if (qdev->small_buf_virt_addr != NULL) {
-		pci_free_consistent(qdev->pdev,
-				    qdev->small_buf_total_size,
-				    qdev->small_buf_virt_addr,
-				    qdev->small_buf_phy_addr);
+		dma_free_coherent(&qdev->pdev->dev,
+				  qdev->small_buf_total_size,
+				  qdev->small_buf_virt_addr,
+				  qdev->small_buf_phy_addr);
 
 		qdev->small_buf_virt_addr = NULL;
 	}
@@ -2720,10 +2710,10 @@ static void ql_free_large_buffers(struct ql3_adapter *qdev)
 		lrg_buf_cb = &qdev->lrg_buf[i];
 		if (lrg_buf_cb->skb) {
 			dev_kfree_skb(lrg_buf_cb->skb);
-			pci_unmap_single(qdev->pdev,
+			dma_unmap_single(&qdev->pdev->dev,
 					 dma_unmap_addr(lrg_buf_cb, mapaddr),
 					 dma_unmap_len(lrg_buf_cb, maplen),
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 			memset(lrg_buf_cb, 0, sizeof(struct ql_rcv_buf_cb));
 		} else {
 			break;
@@ -2775,13 +2765,11 @@ static int ql_alloc_large_buffers(struct ql3_adapter *qdev)
 			 * buffer
 			 */
 			skb_reserve(skb, QL_HEADER_SPACE);
-			map = pci_map_single(qdev->pdev,
-					     skb->data,
-					     qdev->lrg_buffer_len -
-					     QL_HEADER_SPACE,
-					     PCI_DMA_FROMDEVICE);
+			map = dma_map_single(&qdev->pdev->dev, skb->data,
+					     qdev->lrg_buffer_len - QL_HEADER_SPACE,
+					     DMA_FROM_DEVICE);
 
-			err = pci_dma_mapping_error(qdev->pdev, map);
+			err = dma_mapping_error(&qdev->pdev->dev, map);
 			if (err) {
 				netdev_err(qdev->ndev,
 					   "PCI mapping failed with error: %d\n",
@@ -2866,8 +2854,8 @@ static int ql_alloc_mem_resources(struct ql3_adapter *qdev)
 	 * Network Completion Queue Producer Index Register
 	 */
 	qdev->shadow_reg_virt_addr =
-		pci_alloc_consistent(qdev->pdev,
-				     PAGE_SIZE, &qdev->shadow_reg_phy_addr);
+		dma_alloc_coherent(&qdev->pdev->dev, PAGE_SIZE,
+				   &qdev->shadow_reg_phy_addr, GFP_KERNEL);
 
 	if (qdev->shadow_reg_virt_addr != NULL) {
 		qdev->preq_consumer_index = qdev->shadow_reg_virt_addr;
@@ -2922,10 +2910,9 @@ static int ql_alloc_mem_resources(struct ql3_adapter *qdev)
 err_buffer_queues:
 	ql_free_net_req_rsp_queues(qdev);
 err_req_rsp:
-	pci_free_consistent(qdev->pdev,
-			    PAGE_SIZE,
-			    qdev->shadow_reg_virt_addr,
-			    qdev->shadow_reg_phy_addr);
+	dma_free_coherent(&qdev->pdev->dev, PAGE_SIZE,
+			  qdev->shadow_reg_virt_addr,
+			  qdev->shadow_reg_phy_addr);
 
 	return -ENOMEM;
 }
@@ -2938,10 +2925,9 @@ static void ql_free_mem_resources(struct ql3_adapter *qdev)
 	ql_free_buffer_queues(qdev);
 	ql_free_net_req_rsp_queues(qdev);
 	if (qdev->shadow_reg_virt_addr != NULL) {
-		pci_free_consistent(qdev->pdev,
-				    PAGE_SIZE,
-				    qdev->shadow_reg_virt_addr,
-				    qdev->shadow_reg_phy_addr);
+		dma_free_coherent(&qdev->pdev->dev, PAGE_SIZE,
+				  qdev->shadow_reg_virt_addr,
+				  qdev->shadow_reg_phy_addr);
 		qdev->shadow_reg_virt_addr = NULL;
 	}
 }
@@ -3642,18 +3628,15 @@ static void ql_reset_work(struct work_struct *work)
 			if (tx_cb->skb) {
 				netdev_printk(KERN_DEBUG, ndev,
 					      "Freeing lost SKB\n");
-				pci_unmap_single(qdev->pdev,
-					 dma_unmap_addr(&tx_cb->map[0],
-							mapaddr),
-					 dma_unmap_len(&tx_cb->map[0], maplen),
-					 PCI_DMA_TODEVICE);
+				dma_unmap_single(&qdev->pdev->dev,
+						 dma_unmap_addr(&tx_cb->map[0], mapaddr),
+						 dma_unmap_len(&tx_cb->map[0], maplen),
+						 DMA_TO_DEVICE);
 				for (j = 1; j < tx_cb->seg_count; j++) {
-					pci_unmap_page(qdev->pdev,
-					       dma_unmap_addr(&tx_cb->map[j],
-							      mapaddr),
-					       dma_unmap_len(&tx_cb->map[j],
-							     maplen),
-					       PCI_DMA_TODEVICE);
+					dma_unmap_page(&qdev->pdev->dev,
+						       dma_unmap_addr(&tx_cb->map[j], mapaddr),
+						       dma_unmap_len(&tx_cb->map[j], maplen),
+						       DMA_TO_DEVICE);
 				}
 				dev_kfree_skb(tx_cb->skb);
 				tx_cb->skb = NULL;
@@ -3785,13 +3768,10 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
+	if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
 		pci_using_dac = 1;
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	} else if (!(err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+	else if (!(err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))))
 		pci_using_dac = 0;
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-	}
 
 	if (err) {
 		pr_err("%s no usable DMA configuration\n", pci_name(pdev));
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index 36b46ddb6710..0ea3168e0896 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -837,8 +837,10 @@ int efx_probe_filters(struct efx_nic *efx)
 		}
 
 		if (!success) {
-			efx_for_each_channel(channel, efx)
+			efx_for_each_channel(channel, efx) {
 				kfree(channel->rps_flow_id);
+				channel->rps_flow_id = NULL;
+			}
 			efx->type->filter_table_remove(efx);
 			rc = -ENOMEM;
 			goto out_unlock;
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index fd3a04d98dc1..2bdb163e458a 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -175,7 +175,9 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8 buf[ETH_ALEN];
 	struct ax88172a_private *priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index b258f7b8788e..700fdce2ecf1 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -98,7 +98,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_fast_assign(
 		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->qid = nvme_req_qid(req);
-		__entry->cid = nvme_req(req)->cmd->common.command_id;
+		__entry->cid = req->tag;
 		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		__entry->retries = nvme_req(req)->retries;
 		__entry->flags = nvme_req(req)->flags;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 158ff4331a14..500905dad643 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5353,6 +5353,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
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
@@ -5365,8 +5371,7 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 	    (pdev->device == 0x7341 && pdev->revision != 0x00))
 		return;
 
-	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
+	quirk_no_ats(pdev);
 }
 
 /* AMD Stoney platform GPU */
@@ -5378,6 +5383,25 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
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
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 29f020c4b2d0..906f985c74e7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2031,22 +2031,33 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		return error;
-
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			break;
+
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			break;
+
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			break;
+
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
 		break;
diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 88ff7bb2bb9b..632086b2f644 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -16,7 +16,7 @@ struct dst_ops {
 	unsigned short		family;
 	unsigned int		gc_thresh;
 
-	int			(*gc)(struct dst_ops *ops);
+	void			(*gc)(struct dst_ops *ops);
 	struct dst_entry *	(*check)(struct dst_entry *, __u32 cookie);
 	unsigned int		(*default_advmss)(const struct dst_entry *);
 	unsigned int		(*mtu)(const struct dst_entry *);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 652283a1353d..f320ff02cc19 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1010,7 +1010,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * This check implies we don't kill processes if their pages
 	 * are in the swap cache early. Those are always late kills.
 	 */
-	if (!page_mapped(hpage))
+	if (!page_mapped(p))
 		return true;
 
 	if (PageKsm(p)) {
@@ -1075,12 +1075,12 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 				unmap_success = false;
 			}
 		} else {
-			unmap_success = try_to_unmap(hpage, ttu);
+			unmap_success = try_to_unmap(p, ttu);
 		}
 	}
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
-		       pfn, page_mapcount(hpage));
+		       pfn, page_mapcount(p));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
diff --git a/mm/memory.c b/mm/memory.c
index cbc0a163d705..1d101aeae416 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3300,8 +3300,8 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows)
 {
-	pgoff_t hba = holebegin >> PAGE_SHIFT;
-	pgoff_t hlen = (holelen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pgoff_t hba = (pgoff_t)(holebegin) >> PAGE_SHIFT;
+	pgoff_t hlen = ((pgoff_t)(holelen) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* Check for overflow. */
 	if (sizeof(holelen) > sizeof(hlen)) {
diff --git a/net/core/dst.c b/net/core/dst.c
index fb3bcba87744..453ec8aafc4a 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -83,12 +83,8 @@ void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
 
 	if (ops->gc &&
 	    !(flags & DST_NOCOUNT) &&
-	    dst_entries_get_fast(ops) > ops->gc_thresh) {
-		if (ops->gc(ops)) {
-			pr_notice_ratelimited("Route cache is full: consider increasing sysctl net.ipv6.route.max_size.\n");
-			return NULL;
-		}
-	}
+	    dst_entries_get_fast(ops) > ops->gc_thresh)
+		ops->gc(ops);
 
 	dst = kmem_cache_alloc(ops->kmem_cachep, GFP_ATOMIC);
 	if (!dst)
diff --git a/net/core/sock.c b/net/core/sock.c
index a069b5476df4..769e969cd1dc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2395,6 +2395,7 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 		sockc->mark = *(u32 *)CMSG_DATA(cmsg);
 		break;
 	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
 			return -EINVAL;
 
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 03f8f33dc134..8324e9f97066 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
 static int
 dns_resolver_preparse(struct key_preparsed_payload *prep)
 {
-	const struct dns_server_list_v1_header *v1;
-	const struct dns_payload_header *bin;
 	struct user_key_payload *upayload;
 	unsigned long derrno;
 	int ret;
@@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 		return -EINVAL;
 
 	if (data[0] == 0) {
+		const struct dns_server_list_v1_header *v1;
+
 		/* It may be a server list. */
-		if (datalen <= sizeof(*bin))
+		if (datalen <= sizeof(*v1))
 			return -EINVAL;
 
-		bin = (const struct dns_payload_header *)data;
-		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
-		if (bin->content != DNS_PAYLOAD_IS_SERVER_LIST) {
+		v1 = (const struct dns_server_list_v1_header *)data;
+		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
+		if (v1->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported content type (%u)\n",
-				bin->content);
+				v1->hdr.content);
 			return -EINVAL;
 		}
 
-		if (bin->version != 1) {
+		if (v1->hdr.version != 1) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported server list version (%u)\n",
-				bin->version);
+				v1->hdr.version);
 			return -EINVAL;
 		}
 
-		v1 = (const struct dns_server_list_v1_header *)bin;
 		if ((v1->status != DNS_LOOKUP_GOOD &&
 		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
 			if (prep->expiry == TIME64_MAX)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a6d5c99f65a3..b23e42efb3df 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -89,7 +89,7 @@ static struct dst_entry *ip6_negative_advice(struct dst_entry *);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev, int how);
-static int		 ip6_dst_gc(struct dst_ops *ops);
+static void		 ip6_dst_gc(struct dst_ops *ops);
 
 static int		ip6_pkt_discard(struct sk_buff *skb);
 static int		ip6_pkt_discard_out(struct net *net, struct sock *sk, struct sk_buff *skb);
@@ -3184,11 +3184,10 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *dev,
 	return dst;
 }
 
-static int ip6_dst_gc(struct dst_ops *ops)
+static void ip6_dst_gc(struct dst_ops *ops)
 {
 	struct net *net = container_of(ops, struct net, ipv6.ip6_dst_ops);
 	int rt_min_interval = net->ipv6.sysctl.ip6_rt_gc_min_interval;
-	int rt_max_size = net->ipv6.sysctl.ip6_rt_max_size;
 	int rt_elasticity = net->ipv6.sysctl.ip6_rt_gc_elasticity;
 	int rt_gc_timeout = net->ipv6.sysctl.ip6_rt_gc_timeout;
 	unsigned long rt_last_gc = net->ipv6.ip6_rt_last_gc;
@@ -3196,11 +3195,10 @@ static int ip6_dst_gc(struct dst_ops *ops)
 	int entries;
 
 	entries = dst_entries_get_fast(ops);
-	if (entries > rt_max_size)
+	if (entries > ops->gc_thresh)
 		entries = dst_entries_get_slow(ops);
 
-	if (time_after(rt_last_gc + rt_min_interval, jiffies) &&
-	    entries <= rt_max_size)
+	if (time_after(rt_last_gc + rt_min_interval, jiffies))
 		goto out;
 
 	fib6_run_gc(atomic_inc_return(&net->ipv6.ip6_rt_gc_expire), net, true);
@@ -3210,7 +3208,6 @@ static int ip6_dst_gc(struct dst_ops *ops)
 out:
 	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
 	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
-	return entries > rt_max_size;
 }
 
 static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
@@ -6363,7 +6360,7 @@ static int __net_init ip6_route_net_init(struct net *net)
 #endif
 
 	net->ipv6.sysctl.flush_delay = 0;
-	net->ipv6.sysctl.ip6_rt_max_size = 4096;
+	net->ipv6.sysctl.ip6_rt_max_size = INT_MAX;
 	net->ipv6.sysctl.ip6_rt_gc_min_interval = HZ / 2;
 	net->ipv6.sysctl.ip6_rt_gc_timeout = 60*HZ;
 	net->ipv6.sysctl.ip6_rt_gc_interval = 30*HZ;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f244a4323a43..4d1a009dab45 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1186,6 +1186,30 @@ static int nft_objname_hash_cmp(struct rhashtable_compare_arg *arg,
 	return strcmp(obj->key.name, k->name);
 }
 
+static bool nft_supported_family(u8 family)
+{
+	return false
+#ifdef CONFIG_NF_TABLES_INET
+		|| family == NFPROTO_INET
+#endif
+#ifdef CONFIG_NF_TABLES_IPV4
+		|| family == NFPROTO_IPV4
+#endif
+#ifdef CONFIG_NF_TABLES_ARP
+		|| family == NFPROTO_ARP
+#endif
+#ifdef CONFIG_NF_TABLES_NETDEV
+		|| family == NFPROTO_NETDEV
+#endif
+#if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
+		|| family == NFPROTO_BRIDGE
+#endif
+#ifdef CONFIG_NF_TABLES_IPV6
+		|| family == NFPROTO_IPV6
+#endif
+		;
+}
+
 static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 			      struct sk_buff *skb, const struct nlmsghdr *nlh,
 			      const struct nlattr * const nla[],
@@ -1201,6 +1225,9 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	u32 flags = 0;
 	int err;
 
+	if (!nft_supported_family(family))
+		return -EOPNOTSUPP;
+
 	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask);
@@ -8994,26 +9021,38 @@ EXPORT_SYMBOL_GPL(nft_chain_validate_hooks);
 static int nf_tables_check_loops(const struct nft_ctx *ctx,
 				 const struct nft_chain *chain);
 
+static int nft_check_loops(const struct nft_ctx *ctx,
+			   const struct nft_set_ext *ext)
+{
+	const struct nft_data *data;
+	int ret;
+
+	data = nft_set_ext_data(ext);
+	switch (data->verdict.code) {
+	case NFT_JUMP:
+	case NFT_GOTO:
+		ret = nf_tables_check_loops(ctx, data->verdict.chain);
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
 static int nf_tables_loop_check_setelem(const struct nft_ctx *ctx,
 					struct nft_set *set,
 					const struct nft_set_iter *iter,
 					struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
-	const struct nft_data *data;
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
 	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
 		return 0;
 
-	data = nft_set_ext_data(ext);
-	switch (data->verdict.code) {
-	case NFT_JUMP:
-	case NFT_GOTO:
-		return nf_tables_check_loops(ctx, data->verdict.chain);
-	default:
-		return 0;
-	}
+	return nft_check_loops(ctx, ext);
 }
 
 static int nf_tables_check_loops(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 7d5b63c5a30a..d154fe67ca8a 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -78,7 +78,7 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 		case NFT_GOTO:
 			err = nf_tables_bind_chain(ctx, chain);
 			if (err < 0)
-				return err;
+				goto err1;
 			break;
 		default:
 			break;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 92f70686bee0..da3cb0d29b97 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -147,6 +147,13 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 
 static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
+	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
+	 * we hold a reference to local, we also need to hold a reference to
+	 * the device to avoid UAF.
+	 */
+	if (!nfc_get_device(local->dev->idx))
+		return NULL;
+
 	kref_get(&local->ref);
 
 	return local;
@@ -179,10 +186,18 @@ static void local_release(struct kref *ref)
 
 int nfc_llcp_local_put(struct nfc_llcp_local *local)
 {
+	struct nfc_dev *dev;
+	int ret;
+
 	if (local == NULL)
 		return 0;
 
-	return kref_put(&local->ref, local_release);
+	dev = local->dev;
+
+	ret = kref_put(&local->ref, local_release);
+	nfc_put_device(dev);
+
+	return ret;
 }
 
 static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
@@ -968,8 +983,17 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 	}
 
 	new_sock = nfc_llcp_sock(new_sk);
-	new_sock->dev = local->dev;
+
 	new_sock->local = nfc_llcp_local_get(local);
+	if (!new_sock->local) {
+		reason = LLCP_DM_REJ;
+		sock_put(&new_sock->sk);
+		release_sock(&sock->sk);
+		sock_put(&sock->sk);
+		goto fail;
+	}
+
+	new_sock->dev = local->dev;
 	new_sock->rw = sock->rw;
 	new_sock->miux = sock->miux;
 	new_sock->nfc_protocol = sock->nfc_protocol;
@@ -1607,7 +1631,16 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	if (local == NULL)
 		return -ENOMEM;
 
-	local->dev = ndev;
+	/* As we are going to initialize local's refcount, we need to get the
+	 * nfc_dev to avoid UAF, otherwise there is no point in continuing.
+	 * See nfc_llcp_local_get().
+	 */
+	local->dev = nfc_get_device(ndev->idx);
+	if (!local->dev) {
+		kfree(local);
+		return -ENODEV;
+	}
+
 	INIT_LIST_HEAD(&local->list);
 	kref_init(&local->ref);
 	mutex_init(&local->sdp_lock);
diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 6f3c1fb2fb44..f176afb70559 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -97,8 +97,10 @@ static int em_text_change(struct net *net, void *data, int len,
 
 static void em_text_destroy(struct tcf_ematch *m)
 {
-	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config)
+	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config) {
 		textsearch_destroy(EM_TEXT_PRIV(m)->config);
+		kfree(EM_TEXT_PRIV(m));
+	}
 }
 
 static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
diff --git a/net/socket.c b/net/socket.c
index 36e38ee434ea..2a48aa89c035 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -675,6 +675,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
 	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
 	struct sockaddr_storage address;
+	int save_len = msg->msg_namelen;
 	int ret;
 
 	if (msg->msg_name) {
@@ -684,6 +685,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 
 	ret = __sock_sendmsg(sock, msg);
 	msg->msg_name = save_addr;
+	msg->msg_namelen = save_len;
 
 	return ret;
 }
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 50eae668578a..dd980438f201 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1215,6 +1215,8 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 		}
 
 		sk_msg_page_add(msg_pl, page, copy, offset);
+		msg_pl->sg.copybreak = 0;
+		msg_pl->sg.curr = msg_pl->sg.end;
 		sk_mem_charge(sk, copy);
 
 		offset += copy;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0743fcd74707..99ba89723cd3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8990,6 +8990,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
+	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 9339fabccb79..5ddeb22ac685 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -46,6 +46,9 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, changed;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	changed = snd_soc_component_test_bits(component, e->reg,
 					      CTRL0_DAT_SEL,
@@ -82,7 +85,7 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
 
-	return 0;
+	return 1;
 }
 
 static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
index 6c99052feafd..4a9b67421c70 100644
--- a/sound/soc/meson/g12a-tohdmitx.c
+++ b/sound/soc/meson/g12a-tohdmitx.c
@@ -45,6 +45,9 @@ static int g12a_tohdmitx_i2s_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, changed;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	changed = snd_soc_component_test_bits(component, e->reg,
 					      CTRL0_I2S_DAT_SEL,
@@ -93,6 +96,9 @@ static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, changed;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	changed = snd_soc_component_test_bits(component, TOHDMITX_CTRL0,
 					      CTRL0_SPDIF_SEL,
@@ -112,7 +118,7 @@ static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
 
-	return 0;
+	return 1;
 }
 
 static SOC_ENUM_SINGLE_DECL(g12a_tohdmitx_spdif_mux_enum, TOHDMITX_CTRL0,

