Return-Path: <linux-kernel+bounces-26343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F091F82DECE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AF01F22CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F718C01;
	Mon, 15 Jan 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Th1HKw7W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EDF182A7;
	Mon, 15 Jan 2024 18:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB96EC433F1;
	Mon, 15 Jan 2024 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705341685;
	bh=/Sekrfw4KqrsUIqtuq7gFHTAOvt2IeQ++Qf9mZRrv4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Th1HKw7WnrSa/gxLI0MuBk8fAXOG51rTSppcFGmt6rAzidcckTxdwvaMQ1BlclbUN
	 apNlTy4w7uyCGxtIG+Hh8KMideBNHrK7jBnfUjoy0v5qWg5Q6cuga/mSQEQ1wNd/aA
	 /9TKivGY9Pxv+/MO9xLBXIor5J0fs8xxQ381NPw4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.267
Date: Mon, 15 Jan 2024 19:01:21 +0100
Message-ID: <2024011520-stunt-regress-8bc6@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024011519-mating-tag-1f62@gregkh>
References: <2024011519-mating-tag-1f62@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 500edb9d9f15..7ce9119d77d2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 266
+SUBLEVEL = 267
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
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
 
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index e1fa832f9fd7..6603f13f5de9 100644
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
@@ -1717,6 +1762,9 @@ static u32 get_cycle_time(struct fw_ohci *ohci)
 	s32 diff01, diff12;
 	int i;
 
+	if (has_reboot_by_cycle_timer_read_quirk(ohci))
+		return 0;
+
 	c2 = reg_read(ohci, OHCI1394_IsochronousCycleTimer);
 
 	if (ohci->quirks & QUIRK_CYCLE_TIMER) {
@@ -3619,6 +3667,9 @@ static int pci_probe(struct pci_dev *dev,
 	if (param_quirks)
 		ohci->quirks = param_quirks;
 
+	if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev))
+		ohci->quirks |= QUIRK_REBOOT_BY_CYCLE_TIMER_READ;
+
 	/*
 	 * Because dma_alloc_coherent() allocates at least one page,
 	 * we save space by using a common buffer for the AR request/
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 328a2fff1935..1226617a27e1 100644
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
index 010a6dc0e7cf..db8c2e219325 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -850,9 +850,10 @@ static const struct block_device_operations mmc_bdops = {
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
@@ -867,9 +868,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
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
@@ -3091,4 +3093,3 @@ module_exit(mmc_blk_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 32801639e0be..2d63c0f188e1 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -570,6 +570,7 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
+	cancel_delayed_work_sync(&host->detect);
 	mmc_pwrseq_free(host);
 	put_device(&host->class_dev);
 }
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index b624589e62a0..ef89fdf1f904 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -223,15 +223,19 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
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
index 7f8531574400..2a12a4144261 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10340,6 +10340,8 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_cfg_ntp_filters(bp);
 	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event))
 		bnxt_hwrm_exec_fwd_req(bp);
+	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
+		netdev_info(bp->dev, "Receive PF driver unload event!\n");
 	if (test_and_clear_bit(BNXT_VXLAN_ADD_PORT_SP_EVENT, &bp->sp_event)) {
 		bnxt_hwrm_tunnel_dst_port_alloc(
 			bp, bp->vxlan_port,
@@ -11266,8 +11268,6 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 			}
 		}
 	}
-	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
-		netdev_info(bp->dev, "Receive PF driver unload event!");
 }
 
 #else
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 750acbf29464..eeadeeec17ba 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1648,8 +1648,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
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
index 3ccc248b1a8a..fa938281281a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -110,12 +110,18 @@ static struct workqueue_struct *i40e_wq;
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
@@ -15710,6 +15716,9 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 
 	i40e_reset_and_rebuild(pf, false, false);
+#ifdef CONFIG_PCI_IOV
+	i40e_restore_all_vfs_msi_state(pdev);
+#endif /* CONFIG_PCI_IOV */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 37ce764ed373..e79b8dc5c2a5 100644
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
@@ -3332,16 +3358,16 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
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
index 23182731a73d..75d916714ad8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -141,5 +141,8 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
 
 void i40e_vc_notify_link_state(struct i40e_pf *pf);
 void i40e_vc_notify_reset(struct i40e_pf *pf);
+#ifdef CONFIG_PCI_IOV
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev);
+#endif /* CONFIG_PCI_IOV */
 
 #endif /* _I40E_VIRTCHNL_PF_H_ */
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 2fa68592210d..5d0e65a3b6a8 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -316,12 +316,11 @@ static void ql_release_to_lrg_buf_free_list(struct ql3_adapter *qdev,
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
@@ -1803,13 +1802,12 @@ static int ql_populate_free_queue(struct ql3_adapter *qdev)
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
@@ -1944,18 +1942,16 @@ static void ql_process_mac_tx_intr(struct ql3_adapter *qdev,
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
@@ -2022,10 +2018,9 @@ static void ql_process_mac_rx_intr(struct ql3_adapter *qdev,
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
@@ -2068,10 +2063,9 @@ static void ql_process_macip_rx_intr(struct ql3_adapter *qdev,
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
@@ -2320,9 +2314,9 @@ static int ql_send_map(struct ql3_adapter *qdev,
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
@@ -2358,11 +2352,11 @@ static int ql_send_map(struct ql3_adapter *qdev,
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
@@ -2424,24 +2418,24 @@ static int ql_send_map(struct ql3_adapter *qdev,
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
 
@@ -2527,9 +2521,8 @@ static int ql_alloc_net_req_rsp_queues(struct ql3_adapter *qdev)
 	wmb();
 
 	qdev->req_q_virt_addr =
-	    pci_alloc_consistent(qdev->pdev,
-				 (size_t) qdev->req_q_size,
-				 &qdev->req_q_phy_addr);
+	    dma_alloc_coherent(&qdev->pdev->dev, (size_t)qdev->req_q_size,
+			       &qdev->req_q_phy_addr, GFP_KERNEL);
 
 	if ((qdev->req_q_virt_addr == NULL) ||
 	    LS_64BITS(qdev->req_q_phy_addr) & (qdev->req_q_size - 1)) {
@@ -2538,16 +2531,14 @@ static int ql_alloc_net_req_rsp_queues(struct ql3_adapter *qdev)
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
 
@@ -2563,15 +2554,13 @@ static void ql_free_net_req_rsp_queues(struct ql3_adapter *qdev)
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
 
@@ -2595,12 +2584,13 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
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
@@ -2615,15 +2605,17 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
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
 
@@ -2640,17 +2632,15 @@ static void ql_free_buffer_queues(struct ql3_adapter *qdev)
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
 
@@ -2668,9 +2658,9 @@ static int ql_alloc_small_buffers(struct ql3_adapter *qdev)
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
@@ -2703,10 +2693,10 @@ static void ql_free_small_buffers(struct ql3_adapter *qdev)
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
@@ -2721,10 +2711,10 @@ static void ql_free_large_buffers(struct ql3_adapter *qdev)
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
@@ -2776,13 +2766,11 @@ static int ql_alloc_large_buffers(struct ql3_adapter *qdev)
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
@@ -2867,8 +2855,8 @@ static int ql_alloc_mem_resources(struct ql3_adapter *qdev)
 	 * Network Completion Queue Producer Index Register
 	 */
 	qdev->shadow_reg_virt_addr =
-		pci_alloc_consistent(qdev->pdev,
-				     PAGE_SIZE, &qdev->shadow_reg_phy_addr);
+		dma_alloc_coherent(&qdev->pdev->dev, PAGE_SIZE,
+				   &qdev->shadow_reg_phy_addr, GFP_KERNEL);
 
 	if (qdev->shadow_reg_virt_addr != NULL) {
 		qdev->preq_consumer_index = qdev->shadow_reg_virt_addr;
@@ -2923,10 +2911,9 @@ static int ql_alloc_mem_resources(struct ql3_adapter *qdev)
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
@@ -2939,10 +2926,9 @@ static void ql_free_mem_resources(struct ql3_adapter *qdev)
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
@@ -3643,18 +3629,15 @@ static void ql_reset_work(struct work_struct *work)
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
@@ -3786,13 +3769,10 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 
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
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 6101d82102e7..bf65262e2256 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -186,7 +186,9 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8 buf[ETH_ALEN];
 	struct ax88172a_private *priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 01e05af5ae08..a03b7535c254 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1299,29 +1299,24 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id)
 	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
 	u32 ctrl_addr = ce_state->ctrl_addr;
 
-	spin_lock_bh(&ce->ce_lock);
-
-	/* Clear the copy-complete interrupts that will be handled here. */
+	/*
+	 * Clear before handling
+	 *
+	 * Misc CE interrupts are not being handled, but still need
+	 * to be cleared.
+	 *
+	 * NOTE: When the last copy engine interrupt is cleared the
+	 * hardware will go to sleep.  Once this happens any access to
+	 * the CE registers can cause a hardware fault.
+	 */
 	ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
-					  wm_regs->cc_mask);
-
-	spin_unlock_bh(&ce->ce_lock);
+					  wm_regs->cc_mask | wm_regs->wm_mask);
 
 	if (ce_state->recv_cb)
 		ce_state->recv_cb(ce_state);
 
 	if (ce_state->send_cb)
 		ce_state->send_cb(ce_state);
-
-	spin_lock_bh(&ce->ce_lock);
-
-	/*
-	 * Misc CE interrupts are not being handled, but still need
-	 * to be cleared.
-	 */
-	ath10k_ce_engine_int_status_clear(ar, ctrl_addr, wm_regs->wm_mask);
-
-	spin_unlock_bh(&ce->ce_lock);
 }
 EXPORT_SYMBOL(ath10k_ce_per_engine_service);
 
@@ -1372,45 +1367,55 @@ static void ath10k_ce_per_engine_handler_adjust(struct ath10k_ce_pipe *ce_state)
 	ath10k_ce_watermark_intr_disable(ar, ctrl_addr);
 }
 
-int ath10k_ce_disable_interrupts(struct ath10k *ar)
+void ath10k_ce_disable_interrupt(struct ath10k *ar, int ce_id)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct ath10k_ce_pipe *ce_state;
 	u32 ctrl_addr;
-	int ce_id;
 
-	for (ce_id = 0; ce_id < CE_COUNT; ce_id++) {
-		ce_state  = &ce->ce_states[ce_id];
-		if (ce_state->attr_flags & CE_ATTR_POLL)
-			continue;
+	ce_state  = &ce->ce_states[ce_id];
+	if (ce_state->attr_flags & CE_ATTR_POLL)
+		return;
 
-		ctrl_addr = ath10k_ce_base_address(ar, ce_id);
+	ctrl_addr = ath10k_ce_base_address(ar, ce_id);
 
-		ath10k_ce_copy_complete_intr_disable(ar, ctrl_addr);
-		ath10k_ce_error_intr_disable(ar, ctrl_addr);
-		ath10k_ce_watermark_intr_disable(ar, ctrl_addr);
-	}
+	ath10k_ce_copy_complete_intr_disable(ar, ctrl_addr);
+	ath10k_ce_error_intr_disable(ar, ctrl_addr);
+	ath10k_ce_watermark_intr_disable(ar, ctrl_addr);
+}
+EXPORT_SYMBOL(ath10k_ce_disable_interrupt);
 
-	return 0;
+void ath10k_ce_disable_interrupts(struct ath10k *ar)
+{
+	int ce_id;
+
+	for (ce_id = 0; ce_id < CE_COUNT; ce_id++)
+		ath10k_ce_disable_interrupt(ar, ce_id);
 }
 EXPORT_SYMBOL(ath10k_ce_disable_interrupts);
 
-void ath10k_ce_enable_interrupts(struct ath10k *ar)
+void ath10k_ce_enable_interrupt(struct ath10k *ar, int ce_id)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
-	int ce_id;
 	struct ath10k_ce_pipe *ce_state;
 
+	ce_state  = &ce->ce_states[ce_id];
+	if (ce_state->attr_flags & CE_ATTR_POLL)
+		return;
+
+	ath10k_ce_per_engine_handler_adjust(ce_state);
+}
+EXPORT_SYMBOL(ath10k_ce_enable_interrupt);
+
+void ath10k_ce_enable_interrupts(struct ath10k *ar)
+{
+	int ce_id;
+
 	/* Enable interrupts for copy engine that
 	 * are not using polling mode.
 	 */
-	for (ce_id = 0; ce_id < CE_COUNT; ce_id++) {
-		ce_state  = &ce->ce_states[ce_id];
-		if (ce_state->attr_flags & CE_ATTR_POLL)
-			continue;
-
-		ath10k_ce_per_engine_handler_adjust(ce_state);
-	}
+	for (ce_id = 0; ce_id < CE_COUNT; ce_id++)
+		ath10k_ce_enable_interrupt(ar, ce_id);
 }
 EXPORT_SYMBOL(ath10k_ce_enable_interrupts);
 
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index a7478c240f78..fe07521550b7 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -255,10 +255,13 @@ int ath10k_ce_cancel_send_next(struct ath10k_ce_pipe *ce_state,
 /*==================CE Interrupt Handlers====================*/
 void ath10k_ce_per_engine_service_any(struct ath10k *ar);
 void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id);
-int ath10k_ce_disable_interrupts(struct ath10k *ar);
+void ath10k_ce_disable_interrupt(struct ath10k *ar, int ce_id);
+void ath10k_ce_disable_interrupts(struct ath10k *ar);
+void ath10k_ce_enable_interrupt(struct ath10k *ar, int ce_id);
 void ath10k_ce_enable_interrupts(struct ath10k *ar);
 void ath10k_ce_dump_registers(struct ath10k *ar,
 			      struct ath10k_fw_crash_data *crash_data);
+
 void ath10k_ce_alloc_rri(struct ath10k *ar);
 void ath10k_ce_free_rri(struct ath10k *ar);
 
@@ -369,18 +372,14 @@ static inline u32 ath10k_ce_base_address(struct ath10k *ar, unsigned int ce_id)
 	(((x) & CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_MASK) >> \
 		CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_LSB)
 #define CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS			0x0000
-#define CE_INTERRUPT_SUMMARY		(GENMASK(CE_COUNT_MAX - 1, 0))
 
 static inline u32 ath10k_ce_interrupt_summary(struct ath10k *ar)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 
-	if (!ar->hw_params.per_ce_irq)
-		return CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_GET(
-			ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
-			CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
-	else
-		return CE_INTERRUPT_SUMMARY;
+	return CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_GET(
+		ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
+		CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
 }
 
 /* Host software's Copy Engine configuration. */
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 3e1adfa2f277..09e77be6e314 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -118,7 +118,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -154,7 +153,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -217,7 +215,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -252,7 +249,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -287,7 +283,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -325,7 +320,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -366,7 +360,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -414,7 +407,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -459,7 +451,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -494,7 +485,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -531,7 +521,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -573,7 +562,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -601,7 +589,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = TARGET_HL_TLV_NUM_WDS_ENTRIES,
 		.target_64bit = true,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL_DUAL_MAC,
-		.per_ce_irq = true,
 		.shadow_reg_support = true,
 		.rri_on_ddr = true,
 		.hw_filter_reset_required = false,
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index ae4c9edc445c..705ab83cdff4 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -590,9 +590,6 @@ struct ath10k_hw_params {
 	/* Target rx ring fill level */
 	u32 rx_ring_fill_level;
 
-	/* target supporting per ce IRQ */
-	bool per_ce_irq;
-
 	/* target supporting shadow register for ce write */
 	bool shadow_reg_support;
 
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 29d52f7b4336..e8700f0b23f7 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -927,6 +928,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 
+	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 	napi_enable(&ar->napi);
 	ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
@@ -1166,7 +1168,9 @@ static irqreturn_t ath10k_snoc_per_engine_handler(int irq, void *arg)
 		return IRQ_HANDLED;
 	}
 
-	ath10k_snoc_irq_disable(ar);
+	ath10k_ce_disable_interrupt(ar, ce_id);
+	set_bit(ce_id, ar_snoc->pending_ce_irqs);
+
 	napi_schedule(&ar->napi);
 
 	return IRQ_HANDLED;
@@ -1175,20 +1179,25 @@ static irqreturn_t ath10k_snoc_per_engine_handler(int irq, void *arg)
 static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 {
 	struct ath10k *ar = container_of(ctx, struct ath10k, napi);
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	int done = 0;
+	int ce_id;
 
 	if (test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags)) {
 		napi_complete(ctx);
 		return done;
 	}
 
-	ath10k_ce_per_engine_service_any(ar);
+	for (ce_id = 0; ce_id < CE_COUNT; ce_id++)
+		if (test_and_clear_bit(ce_id, ar_snoc->pending_ce_irqs)) {
+			ath10k_ce_per_engine_service(ar, ce_id);
+			ath10k_ce_enable_interrupt(ar, ce_id);
+		}
+
 	done = ath10k_htt_txrx_compl_task(ar, budget);
 
-	if (done < budget) {
+	if (done < budget)
 		napi_complete(ctx);
-		ath10k_snoc_irq_enable(ar);
-	}
 
 	return done;
 }
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index 9db823e46314..d61ca374fdf6 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -81,6 +81,7 @@ struct ath10k_snoc {
 	struct ath10k_clk_info *clk;
 	struct ath10k_qmi *qmi;
 	unsigned long flags;
+	DECLARE_BITMAP(pending_ce_irqs, CE_COUNT_MAX);
 };
 
 static inline struct ath10k_snoc *ath10k_snoc_priv(struct ath10k *ar)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 780223694c00..cc8f2ce1e881 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5389,6 +5389,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
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
@@ -5401,8 +5407,7 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 	    (pdev->device == 0x7341 && pdev->revision != 0x00))
 		return;
 
-	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
+	quirk_no_ats(pdev);
 }
 
 /* AMD Stoney platform GPU */
@@ -5414,6 +5419,25 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
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
diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 443863c7b8da..632086b2f644 100644
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
@@ -53,9 +53,11 @@ static inline int dst_entries_get_slow(struct dst_ops *dst)
 	return percpu_counter_sum_positive(&dst->pcpuc_entries);
 }
 
+#define DST_PERCPU_COUNTER_BATCH 32
 static inline void dst_entries_add(struct dst_ops *dst, int val)
 {
-	percpu_counter_add(&dst->pcpuc_entries, val);
+	percpu_counter_add_batch(&dst->pcpuc_entries, val,
+				 DST_PERCPU_COUNTER_BATCH);
 }
 
 static inline int dst_entries_init(struct dst_ops *dst)
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 022a0fd1a5a4..bf9c23fac74f 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -78,8 +78,8 @@ struct netns_ipv6 {
 	struct dst_ops		ip6_dst_ops;
 	rwlock_t		fib6_walker_lock;
 	spinlock_t		fib6_gc_lock;
-	unsigned int		 ip6_rt_gc_expire;
-	unsigned long		 ip6_rt_last_gc;
+	atomic_t		ip6_rt_gc_expire;
+	unsigned long		ip6_rt_last_gc;
 #ifdef CONFIG_IPV6_MULTIPLE_TABLES
 	unsigned int		fib6_rules_require_fldissect;
 	bool			fib6_has_custom_rules;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9030ab0d9d97..c6453f9ffd4d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -986,7 +986,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * This check implies we don't kill processes if their pages
 	 * are in the swap cache early. Those are always late kills.
 	 */
-	if (!page_mapped(hpage))
+	if (!page_mapped(p))
 		return true;
 
 	if (PageKsm(p)) {
@@ -1030,10 +1030,10 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = try_to_unmap(hpage, ttu);
+	unmap_success = try_to_unmap(p, ttu);
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
-		       pfn, page_mapcount(hpage));
+		       pfn, page_mapcount(p));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
diff --git a/mm/memory.c b/mm/memory.c
index d416e329442d..d514f69d9717 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2872,8 +2872,8 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
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
index bb837019d172..2f500d8a0af2 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -770,6 +770,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	struct sockcm_cookie sockc;
 	struct sk_buff *skb;
 	struct net_device *dev;
 	int ifindex;
@@ -815,11 +816,20 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
 	skb->sk  = sk;
 	skb->priority = sk->sk_priority;
+	skb->mark = sk->sk_mark;
+	skb->tstamp = sockc.transmit_time;
+
+	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
 	err = can_send(skb, ro->loopback);
 
diff --git a/net/core/dst.c b/net/core/dst.c
index 193af526e908..107aea25a564 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -81,14 +81,10 @@ void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
 {
 	struct dst_entry *dst;
 
-	if (ops->gc && dst_entries_get_fast(ops) > ops->gc_thresh) {
-		if (ops->gc(ops)) {
-			printk_ratelimited(KERN_NOTICE "Route cache is full: "
-					   "consider increasing sysctl "
-					   "net.ipv[4|6].route.max_size.\n");
-			return NULL;
-		}
-	}
+	if (ops->gc &&
+	    !(flags & DST_NOCOUNT) &&
+	    dst_entries_get_fast(ops) > ops->gc_thresh)
+		ops->gc(ops);
 
 	dst = kmem_cache_alloc(ops->kmem_cachep, GFP_ATOMIC);
 	if (!dst)
diff --git a/net/core/sock.c b/net/core/sock.c
index 2c3c5df13934..daeb0e69c71b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2303,6 +2303,7 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 		sockc->mark = *(u32 *)CMSG_DATA(cmsg);
 		break;
 	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
 			return -EINVAL;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index bf7c2333bc23..0f70c2dbbe5b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -993,7 +993,7 @@ static int __ip_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
 	paged = !!cork->gso_size;
 
-	if (cork->tx_flags & SKBTX_ANY_SW_TSTAMP &&
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
 	    sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
 		tskey = sk->sk_tskey++;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d3455585e6a8..c67d634dccd4 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1425,7 +1425,7 @@ static int __ip6_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP6_MAX_MTU : cork->fragsize;
 	orig_mtu = mtu;
 
-	if (cork->tx_flags & SKBTX_ANY_SW_TSTAMP &&
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
 	    sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
 		tskey = sk->sk_tskey++;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 209d52ebbd19..c26e832fddb7 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -88,7 +88,7 @@ static struct dst_entry *ip6_negative_advice(struct dst_entry *);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev, int how);
-static int		 ip6_dst_gc(struct dst_ops *ops);
+static void		 ip6_dst_gc(struct dst_ops *ops);
 
 static int		ip6_pkt_discard(struct sk_buff *skb);
 static int		ip6_pkt_discard_out(struct net *net, struct sock *sk, struct sk_buff *skb);
@@ -3207,29 +3207,30 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *dev,
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
+	unsigned int val;
 	int entries;
 
 	entries = dst_entries_get_fast(ops);
-	if (time_after(rt_last_gc + rt_min_interval, jiffies) &&
-	    entries <= rt_max_size)
+	if (entries > ops->gc_thresh)
+		entries = dst_entries_get_slow(ops);
+
+	if (time_after(rt_last_gc + rt_min_interval, jiffies))
 		goto out;
 
-	net->ipv6.ip6_rt_gc_expire++;
-	fib6_run_gc(net->ipv6.ip6_rt_gc_expire, net, true);
+	fib6_run_gc(atomic_inc_return(&net->ipv6.ip6_rt_gc_expire), net, true);
 	entries = dst_entries_get_slow(ops);
 	if (entries < ops->gc_thresh)
-		net->ipv6.ip6_rt_gc_expire = rt_gc_timeout>>1;
+		atomic_set(&net->ipv6.ip6_rt_gc_expire, rt_gc_timeout >> 1);
 out:
-	net->ipv6.ip6_rt_gc_expire -= net->ipv6.ip6_rt_gc_expire>>rt_elasticity;
-	return entries > rt_max_size;
+	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
+	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
 }
 
 static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
@@ -6317,7 +6318,7 @@ static int __net_init ip6_route_net_init(struct net *net)
 #endif
 
 	net->ipv6.sysctl.flush_delay = 0;
-	net->ipv6.sysctl.ip6_rt_max_size = 4096;
+	net->ipv6.sysctl.ip6_rt_max_size = INT_MAX;
 	net->ipv6.sysctl.ip6_rt_gc_min_interval = HZ / 2;
 	net->ipv6.sysctl.ip6_rt_gc_timeout = 60*HZ;
 	net->ipv6.sysctl.ip6_rt_gc_interval = 30*HZ;
@@ -6326,7 +6327,7 @@ static int __net_init ip6_route_net_init(struct net *net)
 	net->ipv6.sysctl.ip6_rt_min_advmss = IPV6_MIN_MTU - 20 - 40;
 	net->ipv6.sysctl.skip_notify_on_dev_down = 0;
 
-	net->ipv6.ip6_rt_gc_expire = 30*HZ;
+	atomic_set(&net->ipv6.ip6_rt_gc_expire, 30*HZ);
 
 	ret = 0;
 out:
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 78be121f38ac..915df77161e1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1005,6 +1005,30 @@ static int nft_objname_hash_cmp(struct rhashtable_compare_arg *arg,
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
@@ -1020,6 +1044,9 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	struct nft_ctx ctx;
 	int err;
 
+	if (!nft_supported_family(family))
+		return -EOPNOTSUPP;
+
 	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask);
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
index 38c26e20511d..e3a50f107d64 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -661,6 +661,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
 	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
 	struct sockaddr_storage address;
+	int save_len = msg->msg_namelen;
 	int ret;
 
 	if (msg->msg_name) {
@@ -670,6 +671,7 @@ int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 
 	ret = __sock_sendmsg(sock, msg);
 	msg->msg_name = save_addr;
+	msg->msg_namelen = save_len;
 
 	return ret;
 }
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 62bc7e5c58e5..38592d0871a3 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1211,6 +1211,8 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 		}
 
 		sk_msg_page_add(msg_pl, page, copy, offset);
+		msg_pl->sg.copybreak = 0;
+		msg_pl->sg.curr = msg_pl->sg.end;
 		sk_mem_charge(sk, copy);
 
 		offset += copy;
diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index e0d24592ebd7..f9188274f6b0 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -85,9 +85,13 @@ config SND_MESON_AXG_PDM
 	  Select Y or M to add support for PDM input embedded
 	  in the Amlogic AXG SoC family
 
+config SND_MESON_CODEC_GLUE
+	tristate
+
 config SND_MESON_G12A_TOHDMITX
 	tristate "Amlogic G12A To HDMI TX Control Support"
 	select REGMAP_MMIO
+	select SND_MESON_CODEC_GLUE
 	imply SND_SOC_HDMI_CODEC
 	help
 	  Select Y or M to add support for HDMI audio on the g12a SoC
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index 1a8b1470ed84..529a807b3f37 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -11,6 +11,7 @@ snd-soc-meson-axg-sound-card-objs := axg-card.o
 snd-soc-meson-axg-spdifin-objs := axg-spdifin.o
 snd-soc-meson-axg-spdifout-objs := axg-spdifout.o
 snd-soc-meson-axg-pdm-objs := axg-pdm.o
+snd-soc-meson-codec-glue-objs := meson-codec-glue.o
 snd-soc-meson-g12a-tohdmitx-objs := g12a-tohdmitx.o
 
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
@@ -24,4 +25,5 @@ obj-$(CONFIG_SND_MESON_AXG_SOUND_CARD) += snd-soc-meson-axg-sound-card.o
 obj-$(CONFIG_SND_MESON_AXG_SPDIFIN) += snd-soc-meson-axg-spdifin.o
 obj-$(CONFIG_SND_MESON_AXG_SPDIFOUT) += snd-soc-meson-axg-spdifout.o
 obj-$(CONFIG_SND_MESON_AXG_PDM) += snd-soc-meson-axg-pdm.o
+obj-$(CONFIG_SND_MESON_CODEC_GLUE) += snd-soc-meson-codec-glue.o
 obj-$(CONFIG_SND_MESON_G12A_TOHDMITX) += snd-soc-meson-g12a-tohdmitx.o
diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
index cbe47e0cae42..c875c350be07 100644
--- a/sound/soc/meson/g12a-tohdmitx.c
+++ b/sound/soc/meson/g12a-tohdmitx.c
@@ -12,112 +12,54 @@
 #include <sound/soc-dai.h>
 
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+#include "meson-codec-glue.h"
 
 #define G12A_TOHDMITX_DRV_NAME "g12a-tohdmitx"
 
 #define TOHDMITX_CTRL0			0x0
 #define  CTRL0_ENABLE_SHIFT		31
-#define  CTRL0_I2S_DAT_SEL		GENMASK(13, 12)
+#define  CTRL0_I2S_DAT_SEL_SHIFT	12
+#define  CTRL0_I2S_DAT_SEL		(0x3 << CTRL0_I2S_DAT_SEL_SHIFT)
 #define  CTRL0_I2S_LRCLK_SEL		GENMASK(9, 8)
 #define  CTRL0_I2S_BLK_CAP_INV		BIT(7)
 #define  CTRL0_I2S_BCLK_O_INV		BIT(6)
 #define  CTRL0_I2S_BCLK_SEL		GENMASK(5, 4)
 #define  CTRL0_SPDIF_CLK_CAP_INV	BIT(3)
 #define  CTRL0_SPDIF_CLK_O_INV		BIT(2)
-#define  CTRL0_SPDIF_SEL		BIT(1)
+#define  CTRL0_SPDIF_SEL_SHIFT		1
+#define  CTRL0_SPDIF_SEL		(0x1 << CTRL0_SPDIF_SEL_SHIFT)
 #define  CTRL0_SPDIF_CLK_SEL		BIT(0)
 
-struct g12a_tohdmitx_input {
-	struct snd_soc_pcm_stream params;
-	unsigned int fmt;
-};
-
-static struct snd_soc_dapm_widget *
-g12a_tohdmitx_get_input(struct snd_soc_dapm_widget *w)
-{
-	struct snd_soc_dapm_path *p = NULL;
-	struct snd_soc_dapm_widget *in;
-
-	snd_soc_dapm_widget_for_each_source_path(w, p) {
-		if (!p->connect)
-			continue;
-
-		/* Check that we still are in the same component */
-		if (snd_soc_dapm_to_component(w->dapm) !=
-		    snd_soc_dapm_to_component(p->source->dapm))
-			continue;
-
-		if (p->source->id == snd_soc_dapm_dai_in)
-			return p->source;
-
-		in = g12a_tohdmitx_get_input(p->source);
-		if (in)
-			return in;
-	}
-
-	return NULL;
-}
-
-static struct g12a_tohdmitx_input *
-g12a_tohdmitx_get_input_data(struct snd_soc_dapm_widget *w)
-{
-	struct snd_soc_dapm_widget *in =
-		g12a_tohdmitx_get_input(w);
-	struct snd_soc_dai *dai;
-
-	if (WARN_ON(!in))
-		return NULL;
-
-	dai = in->priv;
-
-	return dai->playback_dma_data;
-}
-
 static const char * const g12a_tohdmitx_i2s_mux_texts[] = {
 	"I2S A", "I2S B", "I2S C",
 };
 
-static SOC_ENUM_SINGLE_EXT_DECL(g12a_tohdmitx_i2s_mux_enum,
-				g12a_tohdmitx_i2s_mux_texts);
-
-static int g12a_tohdmitx_get_input_val(struct snd_soc_component *component,
-				       unsigned int mask)
-{
-	unsigned int val;
-
-	snd_soc_component_read(component, TOHDMITX_CTRL0, &val);
-	return (val & mask) >> __ffs(mask);
-}
-
-static int g12a_tohdmitx_i2s_mux_get_enum(struct snd_kcontrol *kcontrol,
-					  struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component =
-		snd_soc_dapm_kcontrol_component(kcontrol);
-
-	ucontrol->value.enumerated.item[0] =
-		g12a_tohdmitx_get_input_val(component, CTRL0_I2S_DAT_SEL);
-
-	return 0;
-}
-
 static int g12a_tohdmitx_i2s_mux_put_enum(struct snd_kcontrol *kcontrol,
-					  struct snd_ctl_elem_value *ucontrol)
+				   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component =
 		snd_soc_dapm_kcontrol_component(kcontrol);
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int mux = ucontrol->value.enumerated.item[0];
-	unsigned int val = g12a_tohdmitx_get_input_val(component,
-						       CTRL0_I2S_DAT_SEL);
+	unsigned int mux, changed;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
+	changed = snd_soc_component_test_bits(component, e->reg,
+					      CTRL0_I2S_DAT_SEL,
+					      FIELD_PREP(CTRL0_I2S_DAT_SEL,
+							 mux));
+
+	if (!changed)
+		return 0;
 
 	/* Force disconnect of the mux while updating */
-	if (val != mux)
-		snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
 
-	snd_soc_component_update_bits(component, TOHDMITX_CTRL0,
+	snd_soc_component_update_bits(component, e->reg,
 				      CTRL0_I2S_DAT_SEL |
 				      CTRL0_I2S_LRCLK_SEL |
 				      CTRL0_I2S_BCLK_SEL,
@@ -130,30 +72,19 @@ static int g12a_tohdmitx_i2s_mux_put_enum(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static SOC_ENUM_SINGLE_DECL(g12a_tohdmitx_i2s_mux_enum, TOHDMITX_CTRL0,
+			    CTRL0_I2S_DAT_SEL_SHIFT,
+			    g12a_tohdmitx_i2s_mux_texts);
+
 static const struct snd_kcontrol_new g12a_tohdmitx_i2s_mux =
 	SOC_DAPM_ENUM_EXT("I2S Source", g12a_tohdmitx_i2s_mux_enum,
-			  g12a_tohdmitx_i2s_mux_get_enum,
+			  snd_soc_dapm_get_enum_double,
 			  g12a_tohdmitx_i2s_mux_put_enum);
 
 static const char * const g12a_tohdmitx_spdif_mux_texts[] = {
 	"SPDIF A", "SPDIF B",
 };
 
-static SOC_ENUM_SINGLE_EXT_DECL(g12a_tohdmitx_spdif_mux_enum,
-				g12a_tohdmitx_spdif_mux_texts);
-
-static int g12a_tohdmitx_spdif_mux_get_enum(struct snd_kcontrol *kcontrol,
-					    struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component =
-		snd_soc_dapm_kcontrol_component(kcontrol);
-
-	ucontrol->value.enumerated.item[0] =
-		g12a_tohdmitx_get_input_val(component, CTRL0_SPDIF_SEL);
-
-	return 0;
-}
-
 static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
 					    struct snd_ctl_elem_value *ucontrol)
 {
@@ -162,13 +93,21 @@ static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int mux = ucontrol->value.enumerated.item[0];
-	unsigned int val = g12a_tohdmitx_get_input_val(component,
-						       CTRL0_SPDIF_SEL);
+	unsigned int mux, changed;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
+	changed = snd_soc_component_test_bits(component, TOHDMITX_CTRL0,
+					      CTRL0_SPDIF_SEL,
+					      FIELD_PREP(CTRL0_SPDIF_SEL, mux));
+
+	if (!changed)
+		return 0;
 
 	/* Force disconnect of the mux while updating */
-	if (val != mux)
-		snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
 
 	snd_soc_component_update_bits(component, TOHDMITX_CTRL0,
 				      CTRL0_SPDIF_SEL |
@@ -178,12 +117,16 @@ static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
 
-	return 0;
+	return 1;
 }
 
+static SOC_ENUM_SINGLE_DECL(g12a_tohdmitx_spdif_mux_enum, TOHDMITX_CTRL0,
+			    CTRL0_SPDIF_SEL_SHIFT,
+			    g12a_tohdmitx_spdif_mux_texts);
+
 static const struct snd_kcontrol_new g12a_tohdmitx_spdif_mux =
 	SOC_DAPM_ENUM_EXT("SPDIF Source", g12a_tohdmitx_spdif_mux_enum,
-			  g12a_tohdmitx_spdif_mux_get_enum,
+			  snd_soc_dapm_get_enum_double,
 			  g12a_tohdmitx_spdif_mux_put_enum);
 
 static const struct snd_kcontrol_new g12a_tohdmitx_out_enable =
@@ -201,83 +144,13 @@ static const struct snd_soc_dapm_widget g12a_tohdmitx_widgets[] = {
 			    &g12a_tohdmitx_out_enable),
 };
 
-static int g12a_tohdmitx_input_probe(struct snd_soc_dai *dai)
-{
-	struct g12a_tohdmitx_input *data;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	dai->playback_dma_data = data;
-	return 0;
-}
-
-static int g12a_tohdmitx_input_remove(struct snd_soc_dai *dai)
-{
-	kfree(dai->playback_dma_data);
-	return 0;
-}
-
-static int g12a_tohdmitx_input_hw_params(struct snd_pcm_substream *substream,
-					 struct snd_pcm_hw_params *params,
-					 struct snd_soc_dai *dai)
-{
-	struct g12a_tohdmitx_input *data = dai->playback_dma_data;
-
-	data->params.rates = snd_pcm_rate_to_rate_bit(params_rate(params));
-	data->params.rate_min = params_rate(params);
-	data->params.rate_max = params_rate(params);
-	data->params.formats = 1 << params_format(params);
-	data->params.channels_min = params_channels(params);
-	data->params.channels_max = params_channels(params);
-	data->params.sig_bits = dai->driver->playback.sig_bits;
-
-	return 0;
-}
-
-
-static int g12a_tohdmitx_input_set_fmt(struct snd_soc_dai *dai,
-				       unsigned int fmt)
-{
-	struct g12a_tohdmitx_input *data = dai->playback_dma_data;
-
-	/* Save the source stream format for the downstream link */
-	data->fmt = fmt;
-	return 0;
-}
-
-static int g12a_tohdmitx_output_startup(struct snd_pcm_substream *substream,
-					struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct g12a_tohdmitx_input *in_data =
-		g12a_tohdmitx_get_input_data(dai->capture_widget);
-
-	if (!in_data)
-		return -ENODEV;
-
-	if (WARN_ON(!rtd->dai_link->params)) {
-		dev_warn(dai->dev, "codec2codec link expected\n");
-		return -EINVAL;
-	}
-
-	/* Replace link params with the input params */
-	rtd->dai_link->params = &in_data->params;
-
-	if (!in_data->fmt)
-		return 0;
-
-	return snd_soc_runtime_set_dai_fmt(rtd, in_data->fmt);
-}
-
 static const struct snd_soc_dai_ops g12a_tohdmitx_input_ops = {
-	.hw_params	= g12a_tohdmitx_input_hw_params,
-	.set_fmt	= g12a_tohdmitx_input_set_fmt,
+	.hw_params	= meson_codec_glue_input_hw_params,
+	.set_fmt	= meson_codec_glue_input_set_fmt,
 };
 
 static const struct snd_soc_dai_ops g12a_tohdmitx_output_ops = {
-	.startup	= g12a_tohdmitx_output_startup,
+	.startup	= meson_codec_glue_output_startup,
 };
 
 #define TOHDMITX_SPDIF_FORMATS					\
@@ -304,8 +177,8 @@ static const struct snd_soc_dai_ops g12a_tohdmitx_output_ops = {
 	.id = (xid),							\
 	.playback = TOHDMITX_STREAM(xname, "Playback", xfmt, xchmax),	\
 	.ops = &g12a_tohdmitx_input_ops,				\
-	.probe = g12a_tohdmitx_input_probe,				\
-	.remove = g12a_tohdmitx_input_remove,				\
+	.probe = meson_codec_glue_input_dai_probe,			\
+	.remove = meson_codec_glue_input_dai_remove,			\
 }
 
 #define TOHDMITX_OUT(xname, xid, xfmt, xchmax) {			\
diff --git a/sound/soc/meson/meson-codec-glue.c b/sound/soc/meson/meson-codec-glue.c
new file mode 100644
index 000000000000..524a33472337
--- /dev/null
+++ b/sound/soc/meson/meson-codec-glue.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2019 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/module.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "meson-codec-glue.h"
+
+static struct snd_soc_dapm_widget *
+meson_codec_glue_get_input(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p = NULL;
+	struct snd_soc_dapm_widget *in;
+
+	snd_soc_dapm_widget_for_each_source_path(w, p) {
+		if (!p->connect)
+			continue;
+
+		/* Check that we still are in the same component */
+		if (snd_soc_dapm_to_component(w->dapm) !=
+		    snd_soc_dapm_to_component(p->source->dapm))
+			continue;
+
+		if (p->source->id == snd_soc_dapm_dai_in)
+			return p->source;
+
+		in = meson_codec_glue_get_input(p->source);
+		if (in)
+			return in;
+	}
+
+	return NULL;
+}
+
+static void meson_codec_glue_input_set_data(struct snd_soc_dai *dai,
+					    struct meson_codec_glue_input *data)
+{
+	dai->playback_dma_data = data;
+}
+
+struct meson_codec_glue_input *
+meson_codec_glue_input_get_data(struct snd_soc_dai *dai)
+{
+	return dai->playback_dma_data;
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_input_get_data);
+
+static struct meson_codec_glue_input *
+meson_codec_glue_output_get_input_data(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_widget *in =
+		meson_codec_glue_get_input(w);
+	struct snd_soc_dai *dai;
+
+	if (WARN_ON(!in))
+		return NULL;
+
+	dai = in->priv;
+
+	return meson_codec_glue_input_get_data(dai);
+}
+
+int meson_codec_glue_input_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
+{
+	struct meson_codec_glue_input *data =
+		meson_codec_glue_input_get_data(dai);
+
+	data->params.rates = snd_pcm_rate_to_rate_bit(params_rate(params));
+	data->params.rate_min = params_rate(params);
+	data->params.rate_max = params_rate(params);
+	data->params.formats = 1ULL << (__force int) params_format(params);
+	data->params.channels_min = params_channels(params);
+	data->params.channels_max = params_channels(params);
+	data->params.sig_bits = dai->driver->playback.sig_bits;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_input_hw_params);
+
+int meson_codec_glue_input_set_fmt(struct snd_soc_dai *dai,
+				   unsigned int fmt)
+{
+	struct meson_codec_glue_input *data =
+		meson_codec_glue_input_get_data(dai);
+
+	/* Save the source stream format for the downstream link */
+	data->fmt = fmt;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_input_set_fmt);
+
+int meson_codec_glue_output_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct meson_codec_glue_input *in_data =
+		meson_codec_glue_output_get_input_data(dai->capture_widget);
+
+	if (!in_data)
+		return -ENODEV;
+
+	if (WARN_ON(!rtd->dai_link->params)) {
+		dev_warn(dai->dev, "codec2codec link expected\n");
+		return -EINVAL;
+	}
+
+	/* Replace link params with the input params */
+	rtd->dai_link->params = &in_data->params;
+
+	if (!in_data->fmt)
+		return 0;
+
+	return snd_soc_runtime_set_dai_fmt(rtd, in_data->fmt);
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_output_startup);
+
+int meson_codec_glue_input_dai_probe(struct snd_soc_dai *dai)
+{
+	struct meson_codec_glue_input *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	meson_codec_glue_input_set_data(dai, data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_input_dai_probe);
+
+int meson_codec_glue_input_dai_remove(struct snd_soc_dai *dai)
+{
+	struct meson_codec_glue_input *data =
+		meson_codec_glue_input_get_data(dai);
+
+	kfree(data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_input_dai_remove);
+
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_DESCRIPTION("Amlogic Codec Glue Helpers");
+MODULE_LICENSE("GPL v2");
+
diff --git a/sound/soc/meson/meson-codec-glue.h b/sound/soc/meson/meson-codec-glue.h
new file mode 100644
index 000000000000..07f99446c0c6
--- /dev/null
+++ b/sound/soc/meson/meson-codec-glue.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2018 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef _MESON_CODEC_GLUE_H
+#define _MESON_CODEC_GLUE_H
+
+#include <sound/soc.h>
+
+struct meson_codec_glue_input {
+	struct snd_soc_pcm_stream params;
+	unsigned int fmt;
+};
+
+/* Input helpers */
+struct meson_codec_glue_input *
+meson_codec_glue_input_get_data(struct snd_soc_dai *dai);
+int meson_codec_glue_input_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai);
+int meson_codec_glue_input_set_fmt(struct snd_soc_dai *dai,
+				   unsigned int fmt);
+int meson_codec_glue_input_dai_probe(struct snd_soc_dai *dai);
+int meson_codec_glue_input_dai_remove(struct snd_soc_dai *dai);
+
+/* Output helpers */
+int meson_codec_glue_output_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai);
+
+#endif /* _MESON_CODEC_GLUE_H */

