Return-Path: <linux-kernel+bounces-26349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC7C82DED6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86371F22C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92B18647;
	Mon, 15 Jan 2024 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLiJZGLA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA7182A1;
	Mon, 15 Jan 2024 18:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735D0C433C7;
	Mon, 15 Jan 2024 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705341716;
	bh=JEL8XlaqDb/9hYdN2JKEV6EZ2JQYHd2LCJ+oFKjseog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLiJZGLABnPtWq2opsSyg7y1cHp7Y+aprRXE+cRw1k9iyC7j8qt8I4nNBwumHBJg7
	 pqwTI6mD5ketIrJ4UtBY1J7ufFpQ3y1o3ubPZzHD8YwncxLjQPabfsXvA3TTPQphjH
	 FJgVEie4Wv/POmfXrvofgOu7DeI3N76QoZUQUXBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.147
Date: Mon, 15 Jan 2024 19:01:43 +0100
Message-ID: <2024011542-untimed-clay-62c0@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024011541-defective-scuff-c55e@gregkh>
References: <2024011541-defective-scuff-c55e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index bf3b4827b612..95170c5f75c2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 146
+SUBLEVEL = 147
 EXTRAVERSION =
 NAME = Trick or Treat
 
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
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index c4b618d0b16a..052ea7425c4d 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -563,7 +563,8 @@ static void kprobe_emulate_call_indirect(struct kprobe *p, struct pt_regs *regs)
 {
 	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
 
-	int3_emulate_call(regs, regs_get_register(regs, offs));
+	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + p->ainsn.size);
+	int3_emulate_jmp(regs, regs_get_register(regs, offs));
 }
 NOKPROBE_SYMBOL(kprobe_emulate_call_indirect);
 
diff --git a/block/fops.c b/block/fops.c
index 6c265a1bcf1b..4c8948979921 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -599,22 +599,33 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
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
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
 		break;
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 17c9d825188b..667ff40f3935 100644
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
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 22c2ff5272c6..b488c6cb8f10 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -471,6 +471,7 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	u32 request_val = AUX_CMD_REQ(msg->request);
 	u8 *buf = msg->buffer;
 	unsigned int len = msg->size;
+	unsigned int short_len;
 	unsigned int val;
 	int ret;
 	u8 addr_len[SN_AUX_LENGTH_REG + 1 - SN_AUX_ADDR_19_16_REG];
@@ -544,7 +545,8 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	}
 
 	if (val & AUX_IRQ_STATUS_AUX_SHORT) {
-		ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &len);
+		ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &short_len);
+		len = min(len, short_len);
 		if (ret)
 			goto exit;
 	} else if (val & AUX_IRQ_STATUS_NAT_I2C_FAIL) {
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 6cc125857808..a0c04b9d9c73 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3275,7 +3275,7 @@ static void intel_dp_process_phy_request(struct intel_dp *intel_dp,
 			  intel_dp->train_set, crtc_state->lane_count);
 
 	drm_dp_set_phy_test_pattern(&intel_dp->aux, data,
-				    link_status[DP_DPCD_REV]);
+				    intel_dp->dpcd[DP_DPCD_REV]);
 }
 
 static u8 intel_dp_autotest_phy_pattern(struct intel_dp *intel_dp)
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
index 206bd5523ab7..1fb6b6d99066 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -839,9 +839,10 @@ static const struct block_device_operations mmc_bdops = {
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
@@ -856,9 +857,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
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
@@ -3126,4 +3128,3 @@ module_exit(mmc_blk_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d739e2b631fe..8303b484449e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -661,6 +661,7 @@ EXPORT_SYMBOL(mmc_remove_host);
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
index 1cfc1aed4452..872d7f513c30 100644
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
index 42fa21829529..631639a19bad 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11749,6 +11749,8 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_cfg_ntp_filters(bp);
 	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event))
 		bnxt_hwrm_exec_fwd_req(bp);
+	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
+		netdev_info(bp->dev, "Receive PF driver unload event!\n");
 	if (test_and_clear_bit(BNXT_PERIODIC_STATS_SP_EVENT, &bp->sp_event)) {
 		bnxt_hwrm_port_qstats(bp, 0);
 		bnxt_hwrm_port_qstats_ext(bp, 0);
@@ -12694,8 +12696,6 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 			}
 		}
 	}
-	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
-		netdev_info(bp->dev, "Receive PF driver unload event!\n");
 }
 
 #else
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index f6a553e5df25..1c3f7efce8a7 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2090,8 +2090,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
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
index cf085bd8d790..10737418565f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -102,12 +102,18 @@ static struct workqueue_struct *i40e_wq;
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
@@ -16418,6 +16424,9 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 		return;
 
 	i40e_reset_and_rebuild(pf, false, false);
+#ifdef CONFIG_PCI_IOV
+	i40e_restore_all_vfs_msi_state(pdev);
+#endif /* CONFIG_PCI_IOV */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7950b18cb7a4..4d23ff936ce4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -152,6 +152,32 @@ void i40e_vc_notify_reset(struct i40e_pf *pf)
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
@@ -3427,16 +3453,16 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
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
 
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index e09ca21b8e3f..009416705dde 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -537,6 +537,7 @@ struct igc_nfc_filter {
 	u16 etype;
 	__be16 vlan_etype;
 	u16 vlan_tci;
+	u16 vlan_tci_mask;
 	u8 src_addr[ETH_ALEN];
 	u8 dst_addr[ETH_ALEN];
 	u8 user_data[8];
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 3bffd2729a43..9dfa618a3651 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -950,6 +950,7 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
 }
 
 #define ETHER_TYPE_FULL_MASK ((__force __be16)~0)
+#define VLAN_TCI_FULL_MASK ((__force __be16)~0)
 static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 				    struct ethtool_rxnfc *cmd)
 {
@@ -972,10 +973,16 @@ static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 		fsp->m_u.ether_spec.h_proto = ETHER_TYPE_FULL_MASK;
 	}
 
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) {
+		fsp->flow_type |= FLOW_EXT;
+		fsp->h_ext.vlan_etype = rule->filter.vlan_etype;
+		fsp->m_ext.vlan_etype = ETHER_TYPE_FULL_MASK;
+	}
+
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) {
 		fsp->flow_type |= FLOW_EXT;
 		fsp->h_ext.vlan_tci = htons(rule->filter.vlan_tci);
-		fsp->m_ext.vlan_tci = htons(VLAN_PRIO_MASK);
+		fsp->m_ext.vlan_tci = htons(rule->filter.vlan_tci_mask);
 	}
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR) {
@@ -1210,6 +1217,7 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 
 	if ((fsp->flow_type & FLOW_EXT) && fsp->m_ext.vlan_tci) {
 		rule->filter.vlan_tci = ntohs(fsp->h_ext.vlan_tci);
+		rule->filter.vlan_tci_mask = ntohs(fsp->m_ext.vlan_tci);
 		rule->filter.match_flags |= IGC_FILTER_FLAG_VLAN_TCI;
 	}
 
@@ -1247,11 +1255,19 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 		memcpy(rule->filter.user_mask, fsp->m_ext.data, sizeof(fsp->m_ext.data));
 	}
 
-	/* When multiple filter options or user data or vlan etype is set, use a
-	 * flex filter.
+	/* The i225/i226 has various different filters. Flex filters provide a
+	 * way to match up to the first 128 bytes of a packet. Use them for:
+	 *   a) For specific user data
+	 *   b) For VLAN EtherType
+	 *   c) For full TCI match
+	 *   d) Or in case multiple filter criteria are set
+	 *
+	 * Otherwise, use the simple MAC, VLAN PRIO or EtherType filters.
 	 */
 	if ((rule->filter.match_flags & IGC_FILTER_FLAG_USER_DATA) ||
 	    (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) ||
+	    ((rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) &&
+	     rule->filter.vlan_tci_mask == ntohs(VLAN_TCI_FULL_MASK)) ||
 	    (rule->filter.match_flags & (rule->filter.match_flags - 1)))
 		rule->flex = true;
 	else
@@ -1321,6 +1337,26 @@ static int igc_ethtool_add_nfc_rule(struct igc_adapter *adapter,
 		return -EINVAL;
 	}
 
+	/* There are two ways to match the VLAN TCI:
+	 *  1. Match on PCP field and use vlan prio filter for it
+	 *  2. Match on complete TCI field and use flex filter for it
+	 */
+	if ((fsp->flow_type & FLOW_EXT) &&
+	    fsp->m_ext.vlan_tci &&
+	    fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK) &&
+	    fsp->m_ext.vlan_tci != VLAN_TCI_FULL_MASK) {
+		netdev_dbg(netdev, "VLAN mask not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* VLAN EtherType can only be matched by full mask. */
+	if ((fsp->flow_type & FLOW_EXT) &&
+	    fsp->m_ext.vlan_etype &&
+	    fsp->m_ext.vlan_etype != ETHER_TYPE_FULL_MASK) {
+		netdev_dbg(netdev, "VLAN EtherType mask not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (fsp->location >= IGC_MAX_RXNFC_RULES) {
 		netdev_dbg(netdev, "Invalid location\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 356c7455c5ce..2330b1ff915e 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -185,7 +185,7 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 			wr32(IGC_TQAVCC(i), tqavcc);
 
 			wr32(IGC_TQAVHC(i),
-			     0x80000000 + ring->hicredit * 0x7735);
+			     0x80000000 + ring->hicredit * 0x7736);
 		} else {
 			/* Disable any CBS for the queue */
 			txqctl &= ~(IGC_TXQCTL_QAV_SEL_MASK);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 8ac95cb7bbb7..1a269a2e61fd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -505,6 +505,32 @@ static u8 cgx_get_lmac_type(void *cgxd, int lmac_id)
 	return (cfg >> CGX_LMAC_TYPE_SHIFT) & CGX_LMAC_TYPE_MASK;
 }
 
+static u32 cgx_get_lmac_fifo_len(void *cgxd, int lmac_id)
+{
+	struct cgx *cgx = cgxd;
+	u8 num_lmacs;
+	u32 fifo_len;
+
+	fifo_len = cgx->mac_ops->fifo_len;
+	num_lmacs = cgx->mac_ops->get_nr_lmacs(cgx);
+
+	switch (num_lmacs) {
+	case 1:
+		return fifo_len;
+	case 2:
+		return fifo_len / 2;
+	case 3:
+		/* LMAC0 gets half of the FIFO, reset 1/4th */
+		if (lmac_id == 0)
+			return fifo_len / 2;
+		return fifo_len / 4;
+	case 4:
+	default:
+		return fifo_len / 4;
+	}
+	return 0;
+}
+
 /* Configure CGX LMAC in internal loopback mode */
 int cgx_lmac_internal_loopback(void *cgxd, int lmac_id, bool enable)
 {
@@ -789,21 +815,8 @@ static void cgx_lmac_pause_frm_config(void *cgxd, int lmac_id, bool enable)
 
 	if (!is_lmac_valid(cgx, lmac_id))
 		return;
-	if (enable) {
-		/* Enable receive pause frames */
-		cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL);
-		cfg |= CGX_SMUX_RX_FRM_CTL_CTL_BCK;
-		cgx_write(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL, cfg);
-
-		cfg = cgx_read(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL);
-		cfg |= CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK;
-		cgx_write(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL, cfg);
-
-		/* Enable pause frames transmission */
-		cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_TX_CTL);
-		cfg |= CGX_SMUX_TX_CTL_L2P_BP_CONV;
-		cgx_write(cgx, lmac_id, CGXX_SMUX_TX_CTL, cfg);
 
+	if (enable) {
 		/* Set pause time and interval */
 		cgx_write(cgx, lmac_id, CGXX_SMUX_TX_PAUSE_PKT_TIME,
 			  DEFAULT_PAUSE_TIME);
@@ -820,21 +833,21 @@ static void cgx_lmac_pause_frm_config(void *cgxd, int lmac_id, bool enable)
 		cfg &= ~0xFFFFULL;
 		cgx_write(cgx, lmac_id, CGXX_GMP_GMI_TX_PAUSE_PKT_INTERVAL,
 			  cfg | (DEFAULT_PAUSE_TIME / 2));
-	} else {
-		/* ALL pause frames received are completely ignored */
-		cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL);
-		cfg &= ~CGX_SMUX_RX_FRM_CTL_CTL_BCK;
-		cgx_write(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL, cfg);
+	}
 
-		cfg = cgx_read(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL);
-		cfg &= ~CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK;
-		cgx_write(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL, cfg);
+	/* ALL pause frames received are completely ignored */
+	cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL);
+	cfg &= ~CGX_SMUX_RX_FRM_CTL_CTL_BCK;
+	cgx_write(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL, cfg);
 
-		/* Disable pause frames transmission */
-		cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_TX_CTL);
-		cfg &= ~CGX_SMUX_TX_CTL_L2P_BP_CONV;
-		cgx_write(cgx, lmac_id, CGXX_SMUX_TX_CTL, cfg);
-	}
+	cfg = cgx_read(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL);
+	cfg &= ~CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK;
+	cgx_write(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL, cfg);
+
+	/* Disable pause frames transmission */
+	cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_TX_CTL);
+	cfg &= ~CGX_SMUX_TX_CTL_L2P_BP_CONV;
+	cgx_write(cgx, lmac_id, CGXX_SMUX_TX_CTL, cfg);
 }
 
 void cgx_lmac_ptp_config(void *cgxd, int lmac_id, bool enable)
@@ -1570,6 +1583,7 @@ static struct mac_ops	cgx_mac_ops    = {
 	.tx_stats_cnt   =       18,
 	.get_nr_lmacs	=	cgx_get_nr_lmacs,
 	.get_lmac_type  =       cgx_get_lmac_type,
+	.lmac_fifo_len	=	cgx_get_lmac_fifo_len,
 	.mac_lmac_intl_lbk =    cgx_lmac_internal_loopback,
 	.mac_get_rx_stats  =	cgx_get_rx_stats,
 	.mac_get_tx_stats  =	cgx_get_tx_stats,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index b33e7d1d0851..f6eb9fec1e8d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -76,6 +76,7 @@ struct mac_ops {
 	 */
 	int			(*get_nr_lmacs)(void *cgx);
 	u8                      (*get_lmac_type)(void *cgx, int lmac_id);
+	u32                     (*lmac_fifo_len)(void *cgx, int lmac_id);
 	int                     (*mac_lmac_intl_lbk)(void *cgx, int lmac_id,
 						     bool enable);
 	/* Register Stats related functions */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 6e1192f52608..0f88efe39e41 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -490,7 +490,7 @@ struct npc_lt_def {
 	u8	ltype_mask;
 	u8	ltype_match;
 	u8	lid;
-};
+} __packed;
 
 struct npc_lt_def_ipsec {
 	u8	ltype_mask;
@@ -498,7 +498,7 @@ struct npc_lt_def_ipsec {
 	u8	lid;
 	u8	spi_offset;
 	u8	spi_nz;
-};
+} __packed;
 
 struct npc_lt_def_apad {
 	u8	ltype_mask;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 9ea2f6ac38ec..3ac26ba31e2f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -22,6 +22,7 @@ static struct mac_ops	rpm_mac_ops   = {
 	.tx_stats_cnt   =       34,
 	.get_nr_lmacs	=	rpm_get_nr_lmacs,
 	.get_lmac_type  =       rpm_get_lmac_type,
+	.lmac_fifo_len	=	rpm_get_lmac_fifo_len,
 	.mac_lmac_intl_lbk =    rpm_lmac_internal_loopback,
 	.mac_get_rx_stats  =	rpm_get_rx_stats,
 	.mac_get_tx_stats  =	rpm_get_tx_stats,
@@ -167,26 +168,6 @@ void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
 	u64 cfg;
 
 	if (enable) {
-		/* Enable 802.3 pause frame mode */
-		cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
-		cfg &= ~RPMX_MTI_MAC100X_COMMAND_CONFIG_PFC_MODE;
-		rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
-
-		/* Enable receive pause frames */
-		cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
-		cfg &= ~RPMX_MTI_MAC100X_COMMAND_CONFIG_RX_P_DISABLE;
-		rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
-
-		/* Enable forward pause to TX block */
-		cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
-		cfg &= ~RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_IGNORE;
-		rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
-
-		/* Enable pause frames transmission */
-		cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
-		cfg &= ~RPMX_MTI_MAC100X_COMMAND_CONFIG_TX_P_DISABLE;
-		rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
-
 		/* Set pause time and interval */
 		cfg = rpm_read(rpm, lmac_id,
 			       RPMX_MTI_MAC100X_CL01_PAUSE_QUANTA);
@@ -199,23 +180,22 @@ void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
 		cfg &= ~0xFFFFULL;
 		rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_CL01_QUANTA_THRESH,
 			  cfg | (RPM_DEFAULT_PAUSE_TIME / 2));
+	}
 
-	} else {
-		/* ALL pause frames received are completely ignored */
-		cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
-		cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_RX_P_DISABLE;
-		rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
+	/* ALL pause frames received are completely ignored */
+	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
+	cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_RX_P_DISABLE;
+	rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
 
-		/* Disable forward pause to TX block */
-		cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
-		cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_IGNORE;
-		rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
+	/* Disable forward pause to TX block */
+	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
+	cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_IGNORE;
+	rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
 
-		/* Disable pause frames transmission */
-		cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
-		cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_TX_P_DISABLE;
-		rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
-	}
+	/* Disable pause frames transmission */
+	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
+	cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_TX_P_DISABLE;
+	rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
 }
 
 int rpm_get_rx_stats(void *rpmd, int lmac_id, int idx, u64 *rx_stat)
@@ -282,6 +262,35 @@ u8 rpm_get_lmac_type(void *rpmd, int lmac_id)
 	return err;
 }
 
+u32 rpm_get_lmac_fifo_len(void *rpmd, int lmac_id)
+{
+	rpm_t *rpm = rpmd;
+	u64 hi_perf_lmac;
+	u8 num_lmacs;
+	u32 fifo_len;
+
+	fifo_len = rpm->mac_ops->fifo_len;
+	num_lmacs = rpm->mac_ops->get_nr_lmacs(rpm);
+
+	switch (num_lmacs) {
+	case 1:
+		return fifo_len;
+	case 2:
+		return fifo_len / 2;
+	case 3:
+		/* LMAC marked as hi_perf gets half of the FIFO and rest 1/4th */
+		hi_perf_lmac = rpm_read(rpm, 0, CGXX_CMRX_RX_LMACS);
+		hi_perf_lmac = (hi_perf_lmac >> 4) & 0x3ULL;
+		if (lmac_id == hi_perf_lmac)
+			return fifo_len / 2;
+		return fifo_len / 4;
+	case 4:
+	default:
+		return fifo_len / 4;
+	}
+	return 0;
+}
+
 int rpm_lmac_internal_loopback(void *rpmd, int lmac_id, bool enable)
 {
 	rpm_t *rpm = rpmd;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index ff580311edd0..39e9a1d06835 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -49,6 +49,7 @@
 /* Function Declarations */
 int rpm_get_nr_lmacs(void *rpmd);
 u8 rpm_get_lmac_type(void *rpmd, int lmac_id);
+u32 rpm_get_lmac_fifo_len(void *rpmd, int lmac_id);
 int rpm_lmac_internal_loopback(void *rpmd, int lmac_id, bool enable);
 void rpm_lmac_enadis_rx_pause_fwding(void *rpmd, int lmac_id, bool enable);
 int rpm_lmac_get_pause_frm_status(void *cgxd, int lmac_id, u8 *tx_pause,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 9d517e6dac2f..b4be1b597f33 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -813,7 +813,8 @@ u32  rvu_cgx_get_fifolen(struct rvu *rvu);
 void *rvu_first_cgx_pdata(struct rvu *rvu);
 int cgxlmac_to_pf(struct rvu *rvu, int cgx_id, int lmac_id);
 int rvu_cgx_config_tx(void *cgxd, int lmac_id, bool enable);
-
+int rvu_cgx_tx_enable(struct rvu *rvu, u16 pcifunc, bool enable);
+u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac);
 int npc_get_nixlf_mcam_index(struct npc_mcam *mcam, u16 pcifunc, int nixlf,
 			     int type);
 bool is_mcam_entry_enabled(struct rvu *rvu, struct npc_mcam *mcam, int blkaddr,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index f4c7bb6bf053..dd231d9f89db 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -456,6 +456,23 @@ int rvu_cgx_config_rxtx(struct rvu *rvu, u16 pcifunc, bool start)
 	return mac_ops->mac_rx_tx_enable(cgxd, lmac_id, start);
 }
 
+int rvu_cgx_tx_enable(struct rvu *rvu, u16 pcifunc, bool enable)
+{
+	int pf = rvu_get_pf(pcifunc);
+	struct mac_ops *mac_ops;
+	u8 cgx_id, lmac_id;
+	void *cgxd;
+
+	if (!is_cgx_config_permitted(rvu, pcifunc))
+		return LMAC_AF_ERR_PERM_DENIED;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	cgxd = rvu_cgx_pdata(cgx_id, rvu);
+	mac_ops = get_mac_ops(cgxd);
+
+	return mac_ops->mac_tx_enable(cgxd, lmac_id, enable);
+}
+
 int rvu_cgx_config_tx(void *cgxd, int lmac_id, bool enable)
 {
 	struct mac_ops *mac_ops;
@@ -831,6 +848,22 @@ u32 rvu_cgx_get_fifolen(struct rvu *rvu)
 	return fifo_len;
 }
 
+u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac)
+{
+	struct mac_ops *mac_ops;
+	void *cgxd;
+
+	cgxd = rvu_cgx_pdata(cgx, rvu);
+	if (!cgxd)
+		return 0;
+
+	mac_ops = get_mac_ops(cgxd);
+	if (!mac_ops->lmac_fifo_len)
+		return 0;
+
+	return mac_ops->lmac_fifo_len(cgxd, lmac);
+}
+
 static int rvu_cgx_config_intlbk(struct rvu *rvu, u16 pcifunc, bool en)
 {
 	int pf = rvu_get_pf(pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 5f9f6da5c45b..bda93e550b08 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -296,7 +296,6 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 	struct rvu_hwinfo *hw = rvu->hw;
 	struct sdp_node_info *sdp_info;
 	int pkind, pf, vf, lbkid, vfid;
-	struct mac_ops *mac_ops;
 	u8 cgx_id, lmac_id;
 	bool from_vf;
 	int err;
@@ -326,13 +325,6 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 		cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id, pkind);
 		rvu_npc_set_pkind(rvu, pkind, pfvf);
 
-		mac_ops = get_mac_ops(rvu_cgx_pdata(cgx_id, rvu));
-
-		/* By default we enable pause frames */
-		if ((pcifunc & RVU_PFVF_FUNC_MASK) == 0)
-			mac_ops->mac_enadis_pause_frm(rvu_cgx_pdata(cgx_id,
-								    rvu),
-						      lmac_id, true, true);
 		break;
 	case NIX_INTF_TYPE_LBK:
 		vf = (pcifunc & RVU_PFVF_FUNC_MASK) - 1;
@@ -3885,90 +3877,18 @@ static void nix_find_link_frs(struct rvu *rvu,
 		req->minlen = minlen;
 }
 
-static int
-nix_config_link_credits(struct rvu *rvu, int blkaddr, int link,
-			u16 pcifunc, u64 tx_credits)
-{
-	struct rvu_hwinfo *hw = rvu->hw;
-	int pf = rvu_get_pf(pcifunc);
-	u8 cgx_id = 0, lmac_id = 0;
-	unsigned long poll_tmo;
-	bool restore_tx_en = 0;
-	struct nix_hw *nix_hw;
-	u64 cfg, sw_xoff = 0;
-	u32 schq = 0;
-	u32 credits;
-	int rc;
-
-	nix_hw = get_nix_hw(rvu->hw, blkaddr);
-	if (!nix_hw)
-		return NIX_AF_ERR_INVALID_NIXBLK;
-
-	if (tx_credits == nix_hw->tx_credits[link])
-		return 0;
-
-	/* Enable cgx tx if disabled for credits to be back */
-	if (is_pf_cgxmapped(rvu, pf)) {
-		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
-		restore_tx_en = !rvu_cgx_config_tx(rvu_cgx_pdata(cgx_id, rvu),
-						    lmac_id, true);
-	}
-
-	mutex_lock(&rvu->rsrc_lock);
-	/* Disable new traffic to link */
-	if (hw->cap.nix_shaping) {
-		schq = nix_get_tx_link(rvu, pcifunc);
-		sw_xoff = rvu_read64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(schq));
-		rvu_write64(rvu, blkaddr,
-			    NIX_AF_TL1X_SW_XOFF(schq), BIT_ULL(0));
-	}
-
-	rc = NIX_AF_ERR_LINK_CREDITS;
-	poll_tmo = jiffies + usecs_to_jiffies(200000);
-	/* Wait for credits to return */
-	do {
-		if (time_after(jiffies, poll_tmo))
-			goto exit;
-		usleep_range(100, 200);
-
-		cfg = rvu_read64(rvu, blkaddr,
-				 NIX_AF_TX_LINKX_NORM_CREDIT(link));
-		credits = (cfg >> 12) & 0xFFFFFULL;
-	} while (credits != nix_hw->tx_credits[link]);
-
-	cfg &= ~(0xFFFFFULL << 12);
-	cfg |= (tx_credits << 12);
-	rvu_write64(rvu, blkaddr, NIX_AF_TX_LINKX_NORM_CREDIT(link), cfg);
-	rc = 0;
-
-	nix_hw->tx_credits[link] = tx_credits;
-
-exit:
-	/* Enable traffic back */
-	if (hw->cap.nix_shaping && !sw_xoff)
-		rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(schq), 0);
-
-	/* Restore state of cgx tx */
-	if (restore_tx_en)
-		rvu_cgx_config_tx(rvu_cgx_pdata(cgx_id, rvu), lmac_id, false);
-
-	mutex_unlock(&rvu->rsrc_lock);
-	return rc;
-}
-
 int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 				    struct msg_rsp *rsp)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = req->hdr.pcifunc;
 	int pf = rvu_get_pf(pcifunc);
-	int blkaddr, schq, link = -1;
-	struct nix_txsch *txsch;
-	u64 cfg, lmac_fifo_len;
+	int blkaddr, link = -1;
 	struct nix_hw *nix_hw;
 	struct rvu_pfvf *pfvf;
 	u8 cgx = 0, lmac = 0;
 	u16 max_mtu;
+	u64 cfg;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 	if (blkaddr < 0)
@@ -3989,25 +3909,6 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (req->update_minlen && req->minlen < NIC_HW_MIN_FRS)
 		return NIX_AF_ERR_FRS_INVALID;
 
-	/* Check if requester wants to update SMQ's */
-	if (!req->update_smq)
-		goto rx_frscfg;
-
-	/* Update min/maxlen in each of the SMQ attached to this PF/VF */
-	txsch = &nix_hw->txsch[NIX_TXSCH_LVL_SMQ];
-	mutex_lock(&rvu->rsrc_lock);
-	for (schq = 0; schq < txsch->schq.max; schq++) {
-		if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
-			continue;
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(schq));
-		cfg = (cfg & ~(0xFFFFULL << 8)) | ((u64)req->maxlen << 8);
-		if (req->update_minlen)
-			cfg = (cfg & ~0x7FULL) | ((u64)req->minlen & 0x7F);
-		rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(schq), cfg);
-	}
-	mutex_unlock(&rvu->rsrc_lock);
-
-rx_frscfg:
 	/* Check if config is for SDP link */
 	if (req->sdp_link) {
 		if (!hw->sdp_links)
@@ -4030,7 +3931,6 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (link < 0)
 		return NIX_AF_ERR_RX_LINK_INVALID;
 
-
 linkcfg:
 	nix_find_link_frs(rvu, req, pcifunc);
 
@@ -4040,15 +3940,7 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 		cfg = (cfg & ~0xFFFFULL) | req->minlen;
 	rvu_write64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link), cfg);
 
-	if (req->sdp_link || pf == 0)
-		return 0;
-
-	/* Update transmit credits for CGX links */
-	lmac_fifo_len =
-		rvu_cgx_get_fifolen(rvu) /
-		cgx_get_lmac_cnt(rvu_cgx_pdata(cgx, rvu));
-	return nix_config_link_credits(rvu, blkaddr, link, pcifunc,
-				       (lmac_fifo_len - req->maxlen) / 16);
+	return 0;
 }
 
 int rvu_mbox_handler_nix_set_rx_cfg(struct rvu *rvu, struct nix_rx_cfg *req,
@@ -4094,7 +3986,10 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 	struct rvu_hwinfo *hw = rvu->hw;
 	int cgx, lmac_cnt, slink, link;
 	u16 lbk_max_frs, lmac_max_frs;
+	unsigned long lmac_bmap;
 	u64 tx_credits, cfg;
+	u64 lmac_fifo_len;
+	int iter;
 
 	rvu_get_lbk_link_max_frs(rvu, &lbk_max_frs);
 	rvu_get_lmac_link_max_frs(rvu, &lmac_max_frs);
@@ -4128,12 +4023,23 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 		/* Skip when cgx is not available or lmac cnt is zero */
 		if (lmac_cnt <= 0)
 			continue;
-		tx_credits = ((rvu_cgx_get_fifolen(rvu) / lmac_cnt) -
-			       lmac_max_frs) / 16;
-		/* Enable credits and set credit pkt count to max allowed */
-		cfg =  (tx_credits << 12) | (0x1FF << 2) | BIT_ULL(1);
 		slink = cgx * hw->lmac_per_cgx;
-		for (link = slink; link < (slink + lmac_cnt); link++) {
+
+		/* Get LMAC id's from bitmap */
+		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
+		for_each_set_bit(iter, &lmac_bmap, MAX_LMAC_PER_CGX) {
+			lmac_fifo_len = rvu_cgx_get_lmac_fifolen(rvu, cgx, iter);
+			if (!lmac_fifo_len) {
+				dev_err(rvu->dev,
+					"%s: Failed to get CGX/RPM%d:LMAC%d FIFO size\n",
+					__func__, cgx, iter);
+				continue;
+			}
+			tx_credits = (lmac_fifo_len - lmac_max_frs) / 16;
+			/* Enable credits and set credit pkt count to max allowed */
+			cfg =  (tx_credits << 12) | (0x1FF << 2) | BIT_ULL(1);
+
+			link = iter + slink;
 			nix_hw->tx_credits[link] = tx_credits;
 			rvu_write64(rvu, blkaddr,
 				    NIX_AF_TX_LINKX_NORM_CREDIT(link), cfg);
@@ -4541,7 +4447,13 @@ int rvu_mbox_handler_nix_lf_stop_rx(struct rvu *rvu, struct msg_req *req,
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	clear_bit(NIXLF_INITIALIZED, &pfvf->flags);
 
-	return rvu_cgx_start_stop_io(rvu, pcifunc, false);
+	err = rvu_cgx_start_stop_io(rvu, pcifunc, false);
+	if (err)
+		return err;
+
+	rvu_cgx_tx_enable(rvu, pcifunc, true);
+
+	return 0;
 }
 
 void rvu_nix_lf_teardown(struct rvu *rvu, u16 pcifunc, int blkaddr, int nixlf)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index b743646993ca..572c981171ba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -262,6 +262,7 @@ int otx2_config_pause_frm(struct otx2_nic *pfvf)
 	mutex_unlock(&pfvf->mbox.lock);
 	return err;
 }
+EXPORT_SYMBOL(otx2_config_pause_frm);
 
 int otx2_set_flowkey_cfg(struct otx2_nic *pfvf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index f9bb0e9e7359..167b926196c8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1785,9 +1785,6 @@ int otx2_open(struct net_device *netdev)
 	if (pf->linfo.link_up && !(pf->pcifunc & RVU_PFVF_FUNC_MASK))
 		otx2_handle_link_event(pf);
 
-	/* Restore pause frame settings */
-	otx2_config_pause_frm(pf);
-
 	/* Install DMAC Filters */
 	if (pf->flags & OTX2_FLAG_DMACFLTR_SUPPORT)
 		otx2_dmacflt_reinstall_flows(pf);
@@ -2777,10 +2774,6 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* Enable link notifications */
 	otx2_cgx_config_linkevents(pf, true);
 
-	/* Enable pause frames by default */
-	pf->flags |= OTX2_FLAG_RX_PAUSE_ENABLED;
-	pf->flags |= OTX2_FLAG_TX_PAUSE_ENABLED;
-
 	return 0;
 
 err_pf_sriov_init:
@@ -2924,6 +2917,14 @@ static void otx2_remove(struct pci_dev *pdev)
 	if (pf->flags & OTX2_FLAG_RX_TSTAMP_ENABLED)
 		otx2_config_hw_rx_tstamp(pf, false);
 
+	/* Disable 802.3x pause frames */
+	if (pf->flags & OTX2_FLAG_RX_PAUSE_ENABLED ||
+	    (pf->flags & OTX2_FLAG_TX_PAUSE_ENABLED)) {
+		pf->flags &= ~OTX2_FLAG_RX_PAUSE_ENABLED;
+		pf->flags &= ~OTX2_FLAG_TX_PAUSE_ENABLED;
+		otx2_config_pause_frm(pf);
+	}
+
 	cancel_work_sync(&pf->reset_task);
 	/* Disable link notifications */
 	otx2_cgx_config_linkevents(pf, false);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index e69b0e2729cb..689e0853ab9c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -695,10 +695,6 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_unreg_netdev;
 
-	/* Enable pause frames by default */
-	vf->flags |= OTX2_FLAG_RX_PAUSE_ENABLED;
-	vf->flags |= OTX2_FLAG_TX_PAUSE_ENABLED;
-
 	return 0;
 
 err_unreg_netdev:
@@ -732,6 +728,14 @@ static void otx2vf_remove(struct pci_dev *pdev)
 
 	vf = netdev_priv(netdev);
 
+	/* Disable 802.3x pause frames */
+	if (vf->flags & OTX2_FLAG_RX_PAUSE_ENABLED ||
+	    (vf->flags & OTX2_FLAG_TX_PAUSE_ENABLED)) {
+		vf->flags &= ~OTX2_FLAG_RX_PAUSE_ENABLED;
+		vf->flags &= ~OTX2_FLAG_TX_PAUSE_ENABLED;
+		otx2_config_pause_frm(vf);
+	}
+
 	cancel_work_sync(&vf->reset_task);
 	otx2_unregister_dl(vf);
 	unregister_netdev(netdev);
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index 0d5a41a2ae01..227d01cace3f 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -267,6 +267,13 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 		priv->stats.rx_truncate_errors++;
 	}
 
+	/* Read receive consumer index before replenish so that this routine
+	 * returns accurate return value even if packet is received into
+	 * just-replenished buffer prior to exiting this routine.
+	 */
+	rx_ci = readq(priv->base + MLXBF_GIGE_RX_CQE_PACKET_CI);
+	rx_ci_rem = rx_ci % priv->rx_q_entries;
+
 	/* Let hardware know we've replenished one buffer */
 	rx_pi++;
 
@@ -279,8 +286,6 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 	rx_pi_rem = rx_pi % priv->rx_q_entries;
 	if (rx_pi_rem == 0)
 		priv->valid_polarity ^= 1;
-	rx_ci = readq(priv->base + MLXBF_GIGE_RX_CQE_PACKET_CI);
-	rx_ci_rem = rx_ci % priv->rx_q_entries;
 
 	if (skb)
 		netif_receive_skb(skb);
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 29837e533cee..127daad4410b 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -2589,6 +2589,7 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 
 	if (qdev->lrg_buf_q_alloc_virt_addr == NULL) {
 		netdev_err(qdev->ndev, "lBufQ failed\n");
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 	qdev->lrg_buf_q_virt_addr = qdev->lrg_buf_q_alloc_virt_addr;
@@ -2613,6 +2614,7 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 				  qdev->lrg_buf_q_alloc_size,
 				  qdev->lrg_buf_q_alloc_virt_addr,
 				  qdev->lrg_buf_q_alloc_phy_addr);
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c0a339ff43a6..16888e3f0929 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1191,7 +1191,7 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
 {
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 10);
+	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
 }
 
 static void rtl8168_driver_start(struct rtl8169_private *tp)
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index a804c754cd7d..0f2d6efdbba1 100644
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
index d9777d9a7c5d..bc6c8c253911 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -161,7 +161,9 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8 buf[ETH_ALEN];
 	struct ax88172a_private *priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index a2b1f9a0c6d9..f11748cc5b22 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -164,11 +164,12 @@
 	#define GMII_PHY_PGSEL_PAGE3	0x0003
 	#define GMII_PHY_PGSEL_PAGE5	0x0005
 
+static int ax88179_reset(struct usbnet *dev);
+
 struct ax88179_data {
 	u8  eee_enabled;
 	u8  eee_active;
 	u16 rxctl;
-	u16 reserved;
 	u8 in_pm;
 	u32 wol_supported;
 	u32 wolopts;
@@ -191,14 +192,14 @@ static const struct {
 
 static void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode)
 {
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	ax179_data->in_pm = pm_mode;
 }
 
 static int ax88179_in_pm(struct usbnet *dev)
 {
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	return ax179_data->in_pm;
 }
@@ -731,7 +732,7 @@ ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_eee *data)
 static int ax88179_chk_eee(struct usbnet *dev)
 {
 	struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET };
-	struct ax88179_data *priv = (struct ax88179_data *)dev->data;
+	struct ax88179_data *priv = dev->driver_priv;
 
 	mii_ethtool_gset(&dev->mii, &ecmd);
 
@@ -834,7 +835,7 @@ static void ax88179_enable_eee(struct usbnet *dev)
 static int ax88179_get_eee(struct net_device *net, struct ethtool_eee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = (struct ax88179_data *)dev->data;
+	struct ax88179_data *priv = dev->driver_priv;
 
 	edata->eee_enabled = priv->eee_enabled;
 	edata->eee_active = priv->eee_active;
@@ -845,7 +846,7 @@ static int ax88179_get_eee(struct net_device *net, struct ethtool_eee *edata)
 static int ax88179_set_eee(struct net_device *net, struct ethtool_eee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = (struct ax88179_data *)dev->data;
+	struct ax88179_data *priv = dev->driver_priv;
 	int ret;
 
 	priv->eee_enabled = edata->eee_enabled;
@@ -896,8 +897,8 @@ static const struct ethtool_ops ax88179_ethtool_ops = {
 static void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = (struct ax88179_data *)dev->data;
-	u8 *m_filter = ((u8 *)dev->data) + 12;
+	struct ax88179_data *data = dev->driver_priv;
+	u8 *m_filter = ((u8 *)dev->data);
 
 	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
 
@@ -909,7 +910,7 @@ static void ax88179_set_multicast(struct net_device *net)
 	} else if (netdev_mc_empty(net)) {
 		/* just broadcast and directed */
 	} else {
-		/* We use the 20 byte dev->data for our 8 byte filter buffer
+		/* We use dev->data for our 8 byte filter buffer
 		 * to avoid allocating memory that is tricky to free later
 		 */
 		u32 crc_bits;
@@ -1308,46 +1309,15 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 
 static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	u8 buf[5];
-	u16 *tmp16;
-	u8 *tmp;
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
-	struct ethtool_eee eee_data;
+	struct ax88179_data *ax179_data;
 
 	usbnet_get_endpoints(dev, intf);
 
-	tmp16 = (u16 *)buf;
-	tmp = (u8 *)buf;
-
-	memset(ax179_data, 0, sizeof(*ax179_data));
-
-	/* Power up ethernet PHY */
-	*tmp16 = 0;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
-	*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
-	msleep(200);
-
-	*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
-	msleep(100);
-
-	/* Read MAC address from DTB or asix chip */
-	ax88179_get_mac_addr(dev);
-	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
-
-	/* RX bulk configuration */
-	memcpy(tmp, &AX88179_BULKIN_SIZE[0], 5);
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
-
-	dev->rx_urb_size = 1024 * 20;
-
-	*tmp = 0x34;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
+	ax179_data = kzalloc(sizeof(*ax179_data), GFP_KERNEL);
+	if (!ax179_data)
+		return -ENOMEM;
 
-	*tmp = 0x52;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH,
-			  1, 1, tmp);
+	dev->driver_priv = ax179_data;
 
 	dev->net->netdev_ops = &ax88179_netdev_ops;
 	dev->net->ethtool_ops = &ax88179_ethtool_ops;
@@ -1369,52 +1339,14 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->net->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 				 NETIF_F_RXCSUM;
 
-	/* Enable checksum offload */
-	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
-	       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, tmp);
-
-	*tmp = AX_TXCOE_IP | AX_TXCOE_TCP | AX_TXCOE_UDP |
-	       AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, tmp);
-
-	/* Configure RX control register => start operation */
-	*tmp16 = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_IPE | AX_RX_CTL_START |
-		 AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16);
-
-	*tmp = AX_MONITOR_MODE_PMETYPE | AX_MONITOR_MODE_PMEPOL |
-	       AX_MONITOR_MODE_RWMP;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, tmp);
-
-	/* Configure default medium type => giga */
-	*tmp16 = AX_MEDIUM_RECEIVE_EN | AX_MEDIUM_TXFLOW_CTRLEN |
-		 AX_MEDIUM_RXFLOW_CTRLEN | AX_MEDIUM_FULL_DUPLEX |
-		 AX_MEDIUM_GIGAMODE;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
-			  2, 2, tmp16);
-
-	ax88179_led_setting(dev);
-
-	ax179_data->eee_enabled = 0;
-	ax179_data->eee_active = 0;
-
-	ax88179_disable_eee(dev);
-
-	ax88179_ethtool_get_eee(dev, &eee_data);
-	eee_data.advertised = 0;
-	ax88179_ethtool_set_eee(dev, &eee_data);
-
-	/* Restart autoneg */
-	mii_nway_restart(&dev->mii);
-
-	usbnet_link_change(dev, 0, 0);
+	ax88179_reset(dev);
 
 	return 0;
 }
 
 static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	u16 tmp16;
 
 	/* Configure RX control register => stop operation */
@@ -1427,6 +1359,8 @@ static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
 	/* Power down ethernet PHY */
 	tmp16 = 0;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
+
+	kfree(ax179_data);
 }
 
 static void
@@ -1599,7 +1533,7 @@ ax88179_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 
 static int ax88179_link_reset(struct usbnet *dev)
 {
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	u8 tmp[5], link_sts;
 	u16 mode, tmp16, delay = HZ / 10;
 	u32 tmp32 = 0x40000000;
@@ -1674,7 +1608,7 @@ static int ax88179_reset(struct usbnet *dev)
 	u8 buf[5];
 	u16 *tmp16;
 	u8 *tmp;
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	struct ethtool_eee eee_data;
 
 	tmp16 = (u16 *)buf;
@@ -1697,6 +1631,7 @@ static int ax88179_reset(struct usbnet *dev)
 
 	/* Read MAC address from DTB or asix chip */
 	ax88179_get_mac_addr(dev);
+	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
 
 	/* RX bulk configuration */
 	memcpy(tmp, &AX88179_BULKIN_SIZE[0], 5);
@@ -1711,12 +1646,6 @@ static int ax88179_reset(struct usbnet *dev)
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH,
 			  1, 1, tmp);
 
-	dev->net->features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-			      NETIF_F_RXCSUM;
-
-	dev->net->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-				 NETIF_F_RXCSUM;
-
 	/* Enable checksum offload */
 	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
 	       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 74959de9d700..04c801748b33 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -728,7 +728,7 @@ static inline void iwl_enable_rfkill_int(struct iwl_trans *trans)
 	}
 }
 
-void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans);
+void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq);
 
 static inline bool iwl_is_rfkill_set(struct iwl_trans *trans)
 {
@@ -775,7 +775,7 @@ static inline bool iwl_pcie_dbg_on(struct iwl_trans *trans)
 	return (trans->dbg.dest_tlv || iwl_trans_dbg_ini_valid(trans));
 }
 
-void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state);
+void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq);
 void iwl_trans_pcie_dump_regs(struct iwl_trans *trans);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index df201d40f6c9..29be7ed76894 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1780,7 +1780,7 @@ static u32 iwl_pcie_int_cause_ict(struct iwl_trans *trans)
 	return inta;
 }
 
-void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
+void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
@@ -1804,7 +1804,7 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
 	isr_stats->rfkill++;
 
 	if (prev != report)
-		iwl_trans_pcie_rf_kill(trans, report);
+		iwl_trans_pcie_rf_kill(trans, report, from_irq);
 	mutex_unlock(&trans_pcie->mutex);
 
 	if (hw_rfkill) {
@@ -1944,7 +1944,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 
 	/* HW RF KILL switch toggled */
 	if (inta & CSR_INT_BIT_RF_KILL) {
-		iwl_pcie_handle_rfkill_irq(trans);
+		iwl_pcie_handle_rfkill_irq(trans, true);
 		handled |= CSR_INT_BIT_RF_KILL;
 	}
 
@@ -2332,7 +2332,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	/* HW RF KILL switch toggled */
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_RF_KILL)
-		iwl_pcie_handle_rfkill_irq(trans);
+		iwl_pcie_handle_rfkill_irq(trans, true);
 
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_HW_ERR) {
 		IWL_ERR(trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 8a19463bc81c..8170d0697483 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1046,7 +1046,7 @@ bool iwl_pcie_check_hw_rf_kill(struct iwl_trans *trans)
 	report = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
 
 	if (prev != report)
-		iwl_trans_pcie_rf_kill(trans, report);
+		iwl_trans_pcie_rf_kill(trans, report, false);
 
 	return hw_rfkill;
 }
@@ -1170,7 +1170,7 @@ static void iwl_pcie_init_msix(struct iwl_trans_pcie *trans_pcie)
 	trans_pcie->hw_mask = trans_pcie->hw_init_mask;
 }
 
-static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
+static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool from_irq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -1197,7 +1197,8 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
-		iwl_pcie_synchronize_irqs(trans);
+		if (!from_irq)
+			iwl_pcie_synchronize_irqs(trans);
 		iwl_pcie_rx_napi_sync(trans);
 		iwl_pcie_tx_stop(trans);
 		iwl_pcie_rx_stop(trans);
@@ -1385,7 +1386,7 @@ void iwl_trans_pcie_handle_stop_rfkill(struct iwl_trans *trans,
 		clear_bit(STATUS_RFKILL_OPMODE, &trans->status);
 	}
 	if (hw_rfkill != was_in_rfkill)
-		iwl_trans_pcie_rf_kill(trans, hw_rfkill);
+		iwl_trans_pcie_rf_kill(trans, hw_rfkill, false);
 }
 
 static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
@@ -1400,12 +1401,12 @@ static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	mutex_lock(&trans_pcie->mutex);
 	trans_pcie->opmode_down = true;
 	was_in_rfkill = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
-	_iwl_trans_pcie_stop_device(trans);
+	_iwl_trans_pcie_stop_device(trans, false);
 	iwl_trans_pcie_handle_stop_rfkill(trans, was_in_rfkill);
 	mutex_unlock(&trans_pcie->mutex);
 }
 
-void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
+void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq)
 {
 	struct iwl_trans_pcie __maybe_unused *trans_pcie =
 		IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -1418,7 +1419,7 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
 		if (trans->trans_cfg->gen2)
 			_iwl_trans_pcie_gen2_stop_device(trans);
 		else
-			_iwl_trans_pcie_stop_device(trans);
+			_iwl_trans_pcie_stop_device(trans, from_irq);
 	}
 }
 
@@ -2741,7 +2742,7 @@ static ssize_t iwl_dbgfs_rfkill_write(struct file *file,
 	IWL_WARN(trans, "changing debug rfkill %d->%d\n",
 		 trans_pcie->debug_rfkill, new_value);
 	trans_pcie->debug_rfkill = new_value;
-	iwl_pcie_handle_rfkill_irq(trans);
+	iwl_pcie_handle_rfkill_irq(trans, false);
 
 	return count;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cc3f620b73bd..36f1e604191e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -820,6 +820,9 @@ int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask)
 			return 1;
 	}
 
+	if (dev->bus->self)
+		pcie_aspm_pm_state_change(dev->bus->self);
+
 	return 0;
 }
 
@@ -1140,6 +1143,9 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (need_restore)
 		pci_restore_bars(dev);
 
+	if (dev->bus->self)
+		pcie_aspm_pm_state_change(dev->bus->self);
+
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e6ea6e950428..72280e9b23b2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -595,10 +595,12 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
+void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
+static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 233e42ddaa9d..e3f81948ce72 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1038,6 +1038,25 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
+/* @pdev: the root port or switch downstream port */
+void pcie_aspm_pm_state_change(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link = pdev->link_state;
+
+	if (aspm_disabled || !link)
+		return;
+	/*
+	 * Devices changed PM state, we should recheck if latency
+	 * meets all functions' requirement
+	 */
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+	pcie_update_aspm_capable(link->root);
+	pcie_config_aspm_path(link);
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+}
+
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..701c150485b2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -867,8 +867,17 @@ static inline bool module_sig_ok(struct module *module)
 }
 #endif	/* CONFIG_MODULE_SIG */
 
+#if defined(CONFIG_MODULES) && defined(CONFIG_KALLSYMS)
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data);
+#else
+static inline int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
+						 struct module *, unsigned long),
+						 void *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
 #endif /* _LINUX_MODULE_H */
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
diff --git a/kernel/module.c b/kernel/module.c
index 3c90840133c0..ba9f2bb57889 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4482,7 +4482,6 @@ unsigned long module_kallsyms_lookup_name(const char *name)
 	return ret;
 }
 
-#ifdef CONFIG_LIVEPATCH
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data)
@@ -4514,7 +4513,6 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 	mutex_unlock(&module_mutex);
 	return ret;
 }
-#endif /* CONFIG_LIVEPATCH */
 #endif /* CONFIG_KALLSYMS */
 
 static void cfi_init(struct module *mod)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1c565db2de7b..21aef22a8489 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -735,6 +735,8 @@ static unsigned int number_of_same_symbols(char *func_name)
 
 	kallsyms_on_each_symbol(count_symbols, &args);
 
+	module_kallsyms_on_each_symbol(count_symbols, &args);
+
 	return args.count;
 }
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bcd71d8736be..1f23baa98ee9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1331,7 +1331,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * This check implies we don't kill processes if their pages
 	 * are in the swap cache early. Those are always late kills.
 	 */
-	if (!page_mapped(hpage))
+	if (!page_mapped(p))
 		return true;
 
 	if (PageKsm(p)) {
@@ -1397,10 +1397,10 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		}
 	}
 
-	unmap_success = !page_mapped(hpage);
+	unmap_success = !page_mapped(p);
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
-		       pfn, page_mapcount(hpage));
+		       pfn, page_mapcount(p));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
diff --git a/mm/memory.c b/mm/memory.c
index 1bb01b12db53..6044d9a4bcd6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3451,8 +3451,8 @@ EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows)
 {
-	pgoff_t hba = holebegin >> PAGE_SHIFT;
-	pgoff_t hlen = (holelen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pgoff_t hba = (pgoff_t)(holebegin) >> PAGE_SHIFT;
+	pgoff_t hlen = ((pgoff_t)(holelen) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* Check for overflow. */
 	if (sizeof(holelen) > sizeof(hlen)) {
diff --git a/net/can/raw.c b/net/can/raw.c
index 8877d22da67e..e32ffcd200f3 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -780,6 +780,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	struct sockcm_cookie sockc;
 	struct sk_buff *skb;
 	struct net_device *dev;
 	int ifindex;
@@ -825,11 +826,20 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (err < 0)
 		goto free_skb;
 
-	skb_setup_tx_timestamp(skb, sk->sk_tsflags);
+	sockcm_init(&sockc, sk);
+	if (msg->msg_controllen) {
+		err = sock_cmsg_send(sk, msg, &sockc);
+		if (unlikely(err))
+			goto free_skb;
+	}
 
 	skb->dev = dev;
 	skb->sk = sk;
 	skb->priority = sk->sk_priority;
+	skb->mark = sk->sk_mark;
+	skb->tstamp = sockc.transmit_time;
+
+	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
 	err = can_send(skb, ro->loopback);
 
diff --git a/net/core/dst.c b/net/core/dst.c
index 497ef9b3fc6a..1797c6ebdb85 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -82,12 +82,8 @@ void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
 
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
index 662cd6d54ac7..e254790d562e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1534,9 +1534,16 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		lv = sizeof(v.timestamping);
-		v.timestamping.flags = sk->sk_tsflags;
-		v.timestamping.bind_phc = sk->sk_bind_phc;
+		/* For the later-added case SO_TIMESTAMPING_NEW: Be strict about only
+		 * returning the flags when they were set through the same option.
+		 * Don't change the beviour for the old case SO_TIMESTAMPING_OLD.
+		 */
+		if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
+			v.timestamping.flags = sk->sk_tsflags;
+			v.timestamping.bind_phc = sk->sk_bind_phc;
+		}
 		break;
 
 	case SO_RCVTIMEO_OLD:
@@ -2544,6 +2551,7 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
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
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a5f09d64c6ed..a445e4e05e0d 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -990,7 +990,7 @@ static int __ip_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
 	paged = !!cork->gso_size;
 
-	if (cork->tx_flags & SKBTX_ANY_SW_TSTAMP &&
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
 	    sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
 		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 5045b479c2a9..7205473ba28d 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1484,7 +1484,7 @@ static int __ip6_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP6_MAX_MTU : cork->fragsize;
 	orig_mtu = mtu;
 
-	if (cork->tx_flags & SKBTX_ANY_SW_TSTAMP &&
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
 	    sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
 		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 7b26882b9e70..75eab4032f01 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -91,7 +91,7 @@ static struct dst_entry *ip6_negative_advice(struct dst_entry *);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev, int how);
-static int		 ip6_dst_gc(struct dst_ops *ops);
+static void		 ip6_dst_gc(struct dst_ops *ops);
 
 static int		ip6_pkt_discard(struct sk_buff *skb);
 static int		ip6_pkt_discard_out(struct net *net, struct sock *sk, struct sk_buff *skb);
@@ -3295,11 +3295,10 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *dev,
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
@@ -3307,11 +3306,10 @@ static int ip6_dst_gc(struct dst_ops *ops)
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
@@ -3321,7 +3319,6 @@ static int ip6_dst_gc(struct dst_ops *ops)
 out:
 	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
 	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
-	return entries > rt_max_size;
 }
 
 static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
@@ -6528,7 +6525,7 @@ static int __net_init ip6_route_net_init(struct net *net)
 #endif
 
 	net->ipv6.sysctl.flush_delay = 0;
-	net->ipv6.sysctl.ip6_rt_max_size = 4096;
+	net->ipv6.sysctl.ip6_rt_max_size = INT_MAX;
 	net->ipv6.sysctl.ip6_rt_gc_min_interval = HZ / 2;
 	net->ipv6.sysctl.ip6_rt_gc_timeout = 60*HZ;
 	net->ipv6.sysctl.ip6_rt_gc_interval = 30*HZ;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3ee0f632a942..3556818c7162 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1247,6 +1247,30 @@ static int nft_objname_hash_cmp(struct rhashtable_compare_arg *arg,
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
 static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
 			      const struct nlattr * const nla[])
 {
@@ -1261,6 +1285,9 @@ static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
 	u32 flags = 0;
 	int err;
 
+	if (!nft_supported_family(family))
+		return -EOPNOTSUPP;
+
 	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask,
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
index 57c2b78b446b..f7cfc703bd21 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -728,6 +728,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
 	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
 	struct sockaddr_storage address;
+	int save_len = msg->msg_namelen;
 	int ret;
 
 	if (msg->msg_name) {
@@ -737,6 +738,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 
 	ret = __sock_sendmsg(sock, msg);
 	msg->msg_name = save_addr;
+	msg->msg_namelen = save_len;
 
 	return ret;
 }
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 101d231c1b61..9ff3e4df2d6c 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1216,6 +1216,8 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 		}
 
 		sk_msg_page_add(msg_pl, page, copy, offset);
+		msg_pl->sg.copybreak = 0;
+		msg_pl->sg.curr = msg_pl->sg.end;
 		sk_mem_charge(sk, copy);
 
 		offset += copy;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8219ef80d7f9..5e0e19c4b509 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9054,6 +9054,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
+	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
diff --git a/sound/soc/fsl/fsl_rpmsg.c b/sound/soc/fsl/fsl_rpmsg.c
index d60f4dac6c1b..e82c0e6a60b5 100644
--- a/sound/soc/fsl/fsl_rpmsg.c
+++ b/sound/soc/fsl/fsl_rpmsg.c
@@ -191,7 +191,7 @@ static int fsl_rpmsg_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
 					      &fsl_rpmsg_dai, 1);
 	if (ret)
-		return ret;
+		goto err_pm_disable;
 
 	rpmsg->card_pdev = platform_device_register_data(&pdev->dev,
 							 "imx-audio-rpmsg",
@@ -201,16 +201,22 @@ static int fsl_rpmsg_probe(struct platform_device *pdev)
 	if (IS_ERR(rpmsg->card_pdev)) {
 		dev_err(&pdev->dev, "failed to register rpmsg card\n");
 		ret = PTR_ERR(rpmsg->card_pdev);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int fsl_rpmsg_remove(struct platform_device *pdev)
 {
 	struct fsl_rpmsg *rpmsg = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (rpmsg->card_pdev)
 		platform_device_unregister(rpmsg->card_pdev);
 
diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 1dfee1396843..1cd62ba56e06 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -71,6 +71,9 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int mux, reg;
 
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
 	regmap_field_read(priv->field_dat_sel, &reg);
 
@@ -101,7 +104,7 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 
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
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index ac638945b4cb..6e202db6c4d9 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -2,6 +2,8 @@
 #ifndef __GENELF_H__
 #define __GENELF_H__
 
+#include <linux/kernel.h>
+
 /* genelf.c */
 int jit_write_elf(int fd, uint64_t code_addr, const char *sym,
 		  const void *code, int csize, void *debug, int nr_debug_entries,
@@ -73,6 +75,6 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #endif
 
 /* The .text section is directly after the ELF header */
-#define GEN_ELF_TEXT_OFFSET sizeof(Elf_Ehdr)
+#define GEN_ELF_TEXT_OFFSET round_up(sizeof(Elf_Ehdr) + sizeof(Elf_Phdr), 16)
 
 #endif
diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/vm/memfd_secret.c
index 93e7e7ffed33..917749098148 100644
--- a/tools/testing/selftests/vm/memfd_secret.c
+++ b/tools/testing/selftests/vm/memfd_secret.c
@@ -62,6 +62,9 @@ static void test_mlock_limit(int fd)
 	char *mem;
 
 	len = mlock_limit_cur;
+	if (len % page_size != 0)
+		len = (len/page_size) * page_size;
+
 	mem = mmap(NULL, len, prot, mode, fd, 0);
 	if (mem == MAP_FAILED) {
 		fail("unable to mmap secret memory\n");

