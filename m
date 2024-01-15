Return-Path: <linux-kernel+bounces-26341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308482DEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B8B209AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A9182AA;
	Mon, 15 Jan 2024 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w5aR1eI4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7F1804E;
	Mon, 15 Jan 2024 18:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91C8C433C7;
	Mon, 15 Jan 2024 18:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705341676;
	bh=Qrs7W27QJ+jCHnSm1rBE/WcDhPz9MiAIUczOZGqyAdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w5aR1eI4aDtyX8jIE7STlYPuiUNUa69auhEUQHkjIySQJBfv7jHhjhUdSzKaN/lBk
	 dxDD1+uaJIFYemRmbQ2jVP6ilxhqRgPa578X+LfgTKdZb5jf6HKjf/jfDsZwXnD7II
	 bh+RGcBYyMOUxUB4KPx/5PxGzz593slWBNBaPgmA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.305
Date: Mon, 15 Jan 2024 19:01:11 +0100
Message-ID: <2024011509-glowing-starlit-e543@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024011508-shakiness-resonant-f15e@gregkh>
References: <2024011508-shakiness-resonant-f15e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index fc7bc81130dc..8887412d62c8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 304
+SUBLEVEL = 305
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index ff173e67eed2..527bb82072d9 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -805,12 +805,12 @@ static int __init sunxi_mc_smp_init(void)
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
index 9e7abc86de8c..9807a885e698 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -292,6 +292,51 @@ static char ohci_driver_name[] = KBUILD_MODNAME;
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
@@ -1730,6 +1775,9 @@ static u32 get_cycle_time(struct fw_ohci *ohci)
 	s32 diff01, diff12;
 	int i;
 
+	if (has_reboot_by_cycle_timer_read_quirk(ohci))
+		return 0;
+
 	c2 = reg_read(ohci, OHCI1394_IsochronousCycleTimer);
 
 	if (ohci->quirks & QUIRK_CYCLE_TIMER) {
@@ -3633,6 +3681,9 @@ static int pci_probe(struct pci_dev *dev,
 	if (param_quirks)
 		ohci->quirks = param_quirks;
 
+	if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev))
+		ohci->quirks |= QUIRK_REBOOT_BY_CYCLE_TIMER_READ;
+
 	/*
 	 * Because dma_alloc_coherent() allocates at least one page,
 	 * we save space by using a common buffer for the AR request/
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a5d986c75276..ef9422917e1c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -851,9 +851,10 @@ static const struct block_device_operations mmc_bdops = {
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
@@ -868,9 +869,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
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
index 9de8a3553d42..3e94401c0eb3 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -489,6 +489,7 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
+	cancel_delayed_work_sync(&host->detect);
 	mmc_pwrseq_free(host);
 	put_device(&host->class_dev);
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d79281c6d915..ca817b251ef5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7847,6 +7847,8 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_cfg_ntp_filters(bp);
 	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event))
 		bnxt_hwrm_exec_fwd_req(bp);
+	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
+		netdev_info(bp->dev, "Receive PF driver unload event!\n");
 	if (test_and_clear_bit(BNXT_VXLAN_ADD_PORT_SP_EVENT, &bp->sp_event)) {
 		bnxt_hwrm_tunnel_dst_port_alloc(
 			bp, bp->vxlan_port,
@@ -8407,8 +8409,6 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 			}
 		}
 	}
-	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
-		netdev_info(bp->dev, "Receive PF driver unload event!");
 }
 
 #else
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d51857731314..8bbc5dcf8cb4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1650,8 +1650,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
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
index 75a553f4e26f..97cf144a4ff9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -99,12 +99,18 @@ static struct workqueue_struct *i40e_wq;
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
@@ -14470,6 +14476,9 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 
 	i40e_reset_and_rebuild(pf, false, false);
+#ifdef CONFIG_PCI_IOV
+	i40e_restore_all_vfs_msi_state(pdev);
+#endif /* CONFIG_PCI_IOV */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1527c67b487b..412f8002f918 100644
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
@@ -3143,16 +3169,16 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
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
index 1e001b2bd761..c9e0a591a344 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -137,5 +137,8 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
 
 void i40e_vc_notify_link_state(struct i40e_pf *pf);
 void i40e_vc_notify_reset(struct i40e_pf *pf);
+#ifdef CONFIG_PCI_IOV
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev);
+#endif /* CONFIG_PCI_IOV */
 
 #endif /* _I40E_VIRTCHNL_PF_H_ */
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index d545593354c6..99949140c2e7 100644
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
@@ -1945,18 +1943,16 @@ static void ql_process_mac_tx_intr(struct ql3_adapter *qdev,
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
@@ -2023,10 +2019,9 @@ static void ql_process_mac_rx_intr(struct ql3_adapter *qdev,
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
@@ -2069,10 +2064,9 @@ static void ql_process_macip_rx_intr(struct ql3_adapter *qdev,
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
@@ -2321,9 +2315,9 @@ static int ql_send_map(struct ql3_adapter *qdev,
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
@@ -2359,11 +2353,11 @@ static int ql_send_map(struct ql3_adapter *qdev,
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
@@ -2425,24 +2419,24 @@ static int ql_send_map(struct ql3_adapter *qdev,
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
 
@@ -2528,9 +2522,8 @@ static int ql_alloc_net_req_rsp_queues(struct ql3_adapter *qdev)
 	wmb();
 
 	qdev->req_q_virt_addr =
-	    pci_alloc_consistent(qdev->pdev,
-				 (size_t) qdev->req_q_size,
-				 &qdev->req_q_phy_addr);
+	    dma_alloc_coherent(&qdev->pdev->dev, (size_t)qdev->req_q_size,
+			       &qdev->req_q_phy_addr, GFP_KERNEL);
 
 	if ((qdev->req_q_virt_addr == NULL) ||
 	    LS_64BITS(qdev->req_q_phy_addr) & (qdev->req_q_size - 1)) {
@@ -2539,16 +2532,14 @@ static int ql_alloc_net_req_rsp_queues(struct ql3_adapter *qdev)
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
 
@@ -2564,15 +2555,13 @@ static void ql_free_net_req_rsp_queues(struct ql3_adapter *qdev)
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
 
@@ -2596,12 +2585,13 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
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
@@ -2616,15 +2606,17 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
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
 
@@ -2641,17 +2633,15 @@ static void ql_free_buffer_queues(struct ql3_adapter *qdev)
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
 
@@ -2669,9 +2659,9 @@ static int ql_alloc_small_buffers(struct ql3_adapter *qdev)
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
@@ -2704,10 +2694,10 @@ static void ql_free_small_buffers(struct ql3_adapter *qdev)
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
@@ -2722,10 +2712,10 @@ static void ql_free_large_buffers(struct ql3_adapter *qdev)
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
@@ -2777,13 +2767,11 @@ static int ql_alloc_large_buffers(struct ql3_adapter *qdev)
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
@@ -2868,8 +2856,8 @@ static int ql_alloc_mem_resources(struct ql3_adapter *qdev)
 	 * Network Completion Queue Producer Index Register
 	 */
 	qdev->shadow_reg_virt_addr =
-		pci_alloc_consistent(qdev->pdev,
-				     PAGE_SIZE, &qdev->shadow_reg_phy_addr);
+		dma_alloc_coherent(&qdev->pdev->dev, PAGE_SIZE,
+				   &qdev->shadow_reg_phy_addr, GFP_KERNEL);
 
 	if (qdev->shadow_reg_virt_addr != NULL) {
 		qdev->preq_consumer_index = qdev->shadow_reg_virt_addr;
@@ -2924,10 +2912,9 @@ static int ql_alloc_mem_resources(struct ql3_adapter *qdev)
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
@@ -2940,10 +2927,9 @@ static void ql_free_mem_resources(struct ql3_adapter *qdev)
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
@@ -3644,18 +3630,15 @@ static void ql_reset_work(struct work_struct *work)
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
@@ -3787,13 +3770,10 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 
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
index 909755ef71ac..5881620e4436 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -198,7 +198,9 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8 buf[ETH_ALEN];
 	struct ax88172a_private *priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3a165710fbb8..eb507751c115 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5182,6 +5182,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
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
@@ -5194,8 +5200,7 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 	    (pdev->device == 0x7341 && pdev->revision != 0x00))
 		return;
 
-	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
+	quirk_no_ats(pdev);
 }
 
 /* AMD Stoney platform GPU */
@@ -5207,6 +5212,25 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
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
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0e03adbcf942..16252727ec2e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1314,8 +1314,16 @@ static int fuse_direntplus_link(struct file *file,
 			dput(dentry);
 			dentry = alias;
 		}
-		if (IS_ERR(dentry))
+		if (IS_ERR(dentry)) {
+			if (!IS_ERR(inode)) {
+				struct fuse_inode *fi = get_fuse_inode(inode);
+
+				spin_lock(&fc->lock);
+				fi->nlookup--;
+				spin_unlock(&fc->lock);
+			}
 			return PTR_ERR(dentry);
+		}
 	}
 	if (fc->readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
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
index f0e396ab9bec..8f4d013fa05f 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -72,8 +72,8 @@ struct netns_ipv6 {
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
index 3da3c63dccd1..c971d5e11f93 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -989,7 +989,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * This check implies we don't kill processes if their pages
 	 * are in the swap cache early. Those are always late kills.
 	 */
-	if (!page_mapped(hpage))
+	if (!page_mapped(p))
 		return true;
 
 	if (PageKsm(p)) {
@@ -1033,10 +1033,10 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
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
index b80ce6b3c8f4..1e108db4405c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3042,8 +3042,8 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
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
index 81ccf20e2826..1b1677683b97 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -97,10 +97,10 @@ void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
 {
 	struct dst_entry *dst;
 
-	if (ops->gc && dst_entries_get_fast(ops) > ops->gc_thresh) {
-		if (ops->gc(ops))
-			return NULL;
-	}
+	if (ops->gc &&
+	    !(flags & DST_NOCOUNT) &&
+	    dst_entries_get_fast(ops) > ops->gc_thresh)
+		ops->gc(ops);
 
 	dst = kmem_cache_alloc(ops->kmem_cachep, GFP_ATOMIC);
 	if (!dst)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 7b41d5d3575f..9dbc9c0cbc5a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -92,7 +92,7 @@ static struct dst_entry *ip6_negative_advice(struct dst_entry *);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev, int how);
-static int		 ip6_dst_gc(struct dst_ops *ops);
+static void		 ip6_dst_gc(struct dst_ops *ops);
 
 static int		ip6_pkt_discard(struct sk_buff *skb);
 static int		ip6_pkt_discard_out(struct net *net, struct sock *sk, struct sk_buff *skb);
@@ -2767,29 +2767,30 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *dev,
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
 
 static int ip6_convert_metrics(struct net *net, struct fib6_info *rt,
@@ -5332,7 +5333,7 @@ static int __net_init ip6_route_net_init(struct net *net)
 #endif
 
 	net->ipv6.sysctl.flush_delay = 0;
-	net->ipv6.sysctl.ip6_rt_max_size = 4096;
+	net->ipv6.sysctl.ip6_rt_max_size = INT_MAX;
 	net->ipv6.sysctl.ip6_rt_gc_min_interval = HZ / 2;
 	net->ipv6.sysctl.ip6_rt_gc_timeout = 60*HZ;
 	net->ipv6.sysctl.ip6_rt_gc_interval = 30*HZ;
@@ -5340,7 +5341,7 @@ static int __net_init ip6_route_net_init(struct net *net)
 	net->ipv6.sysctl.ip6_rt_mtu_expires = 10*60*HZ;
 	net->ipv6.sysctl.ip6_rt_min_advmss = IPV6_MIN_MTU - 20 - 40;
 
-	net->ipv6.ip6_rt_gc_expire = 30*HZ;
+	atomic_set(&net->ipv6.ip6_rt_gc_expire, 30*HZ);
 
 	ret = 0;
 out:
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3e3044116289..e0c224dea316 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -893,6 +893,30 @@ static int nft_chain_hash_cmp(struct rhashtable_compare_arg *arg,
 	return strcmp(chain->name, name);
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
@@ -908,6 +932,9 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	struct nft_ctx ctx;
 	int err;
 
+	if (!nft_supported_family(family))
+		return -EOPNOTSUPP;
+
 	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask);
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index c30b28465e64..a217830f0f34 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -157,6 +157,13 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 
 struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
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
@@ -190,10 +197,18 @@ static void local_release(struct kref *ref)
 
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
@@ -951,8 +966,17 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
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
@@ -1584,7 +1608,16 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
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
index 73e2ed576ceb..cbf44783024f 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -101,8 +101,10 @@ static int em_text_change(struct net *net, void *data, int len,
 
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
index 328f584345fb..49ac98cfda42 100644
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

