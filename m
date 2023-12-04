Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781EE80392B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbjLDPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjLDPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:49:49 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A9A4;
        Mon,  4 Dec 2023 07:49:54 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4D04Qb022336;
        Mon, 4 Dec 2023 07:49:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=ZGKlI/9Z29x9N3TD0xBfRQvJiculmlDdcKKsHrHsjyo=;
 b=VEpWjP8K9ke8kU822yDa2KbJ6ahGduIo2OQ2rrJSQf6Xj/2CTECl782BWruMlDcMGFj3
 l0003+nuAQ/bTU4qVCpIVbqYBlsmNYwyIsNLmQsp5OHstxME2B86ZvtJPhoXCSb0Lt2d
 YqxRAT4eXCqbAenBFr9/dPV/wXK6hsc+3RYyHd2PRCph57Cw5L62baDUCAjR8MUArKic
 M0eM6wwNso9oibXJoy0DYPOOzJUQ7NNn36L8afhRCaMXlEqPsm8wh8VVoTnJLRLMHn1Y
 ye7hpW26zCwM26t99JhuqTzgEc5xLJhfZPp91fDTCUmrFsx4gsA3ZGQYrDubwlIKojp5 BA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ur2tvdvhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 07:49:45 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Dec
 2023 07:49:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 4 Dec 2023 07:49:43 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 61B973F709B;
        Mon,  4 Dec 2023 07:49:42 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v2] octeon_ep: control net API framework to support offloads
Date:   Mon, 4 Dec 2023 07:49:39 -0800
Message-ID: <20231204154940.2583140-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: boxbTBDVQMRO9SiPSYmHDgwtx0m4uf-S
X-Proofpoint-GUID: boxbTBDVQMRO9SiPSYmHDgwtx0m4uf-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_15,2023-12-04_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inquire firmware on supported offloads, as well as convey offloads
enabled dynamically to firmware. New control net API functionality is
required for the above. Implement control net API framework for
offloads.

Additionally, fetch/insert offload metadata from hardware RX/TX
buffer respectively during receive/transmit.

Currently supported offloads include checksum and TSO.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Removed .ndo_fix_features implementation.
  - Solved big endian error thrown by sparse checks

V1: https://lore.kernel.org/all/20231201131815.2566189-1-srasheed@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         |  1 -
 .../ethernet/marvell/octeon_ep/octep_config.h | 33 +++++++--
 .../marvell/octeon_ep/octep_ctrl_net.c        | 22 +++++-
 .../marvell/octeon_ep/octep_ctrl_net.h        | 37 ++++++++++
 .../ethernet/marvell/octeon_ep/octep_main.c   | 68 ++++++++++++++++--
 .../ethernet/marvell/octeon_ep/octep_main.h   |  3 +-
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 12 ++--
 .../net/ethernet/marvell/octeon_ep/octep_rx.h | 34 +++++++--
 .../net/ethernet/marvell/octeon_ep/octep_tx.h | 72 ++++++++++++-------
 9 files changed, 231 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index 8baabd07e91f..9209f1ec1b52 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -231,7 +231,6 @@ static void octep_init_config_cn93_pf(struct octep_device *oct)
 
 	conf->iq.num_descs = OCTEP_IQ_MAX_DESCRIPTORS;
 	conf->iq.instr_type = OCTEP_64BYTE_INSTR;
-	conf->iq.pkind = 0;
 	conf->iq.db_min = OCTEP_DB_MIN;
 	conf->iq.intr_threshold = OCTEP_IQ_INTR_THRESHOLD;
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
index c528344a7d0c..1627660175c2 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
@@ -60,7 +60,6 @@
 #define CFG_GET_IQ_CFG(cfg)             ((cfg)->iq)
 #define CFG_GET_IQ_NUM_DESC(cfg)        ((cfg)->iq.num_descs)
 #define CFG_GET_IQ_INSTR_TYPE(cfg)      ((cfg)->iq.instr_type)
-#define CFG_GET_IQ_PKIND(cfg)           ((cfg)->iq.pkind)
 #define CFG_GET_IQ_INSTR_SIZE(cfg)      (64)
 #define CFG_GET_IQ_DB_MIN(cfg)          ((cfg)->iq.db_min)
 #define CFG_GET_IQ_INTR_THRESHOLD(cfg)  ((cfg)->iq.intr_threshold)
@@ -76,7 +75,6 @@
 #define CFG_GET_PORTS_ACTIVE_IO_RINGS(cfg) ((cfg)->pf_ring_cfg.active_io_rings)
 #define CFG_GET_PORTS_PF_SRN(cfg)          ((cfg)->pf_ring_cfg.srn)
 
-#define CFG_GET_DPI_PKIND(cfg)            ((cfg)->core_cfg.dpi_pkind)
 #define CFG_GET_CORE_TICS_PER_US(cfg)     ((cfg)->core_cfg.core_tics_per_us)
 #define CFG_GET_COPROC_TICS_PER_US(cfg)   ((cfg)->core_cfg.coproc_tics_per_us)
 
@@ -100,9 +98,6 @@ struct octep_iq_config {
 	/* Command size - 32 or 64 bytes */
 	u16 instr_type;
 
-	/* pkind for packets sent to Octeon */
-	u16 pkind;
-
 	/* Minimum number of commands pending to be posted to Octeon before driver
 	 * hits the Input queue doorbell.
 	 */
@@ -198,11 +193,37 @@ struct octep_ctrl_mbox_config {
 /* Info from firmware */
 struct octep_fw_info {
 	/* interface pkind */
-	u16 pkind;
+	u8 pkind;
+
+	/* front size data */
+	u8 fsz;
+
 	/* heartbeat interval in milliseconds */
 	u16 hb_interval;
+
 	/* heartbeat miss count */
 	u16 hb_miss_count;
+
+	/* reserved */
+	u16 reserved1;
+
+	/* supported rx offloads OCTEP_ETH_RX_OFFLOAD_* */
+	u16 rx_ol_flags;
+
+	/* supported tx offloads OCTEP_ETH_TX_OFFLOAD_* */
+	u16 tx_ol_flags;
+
+	/* reserved */
+	u32 reserved_offloads;
+
+	/* extra offload flags */
+	u64 ext_ol_flags;
+
+	/* supported features */
+	u64 features[2];
+
+	/* reserved */
+	u64 reserved2[3];
 };
 
 /* Data Structure to hold configuration limits and active config */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 4c39e2fabe0a..9dff2166dbb7 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -22,12 +22,15 @@ static const u32 mtu_sz = sizeof(struct octep_ctrl_net_h2f_req_cmd_mtu);
 static const u32 mac_sz = sizeof(struct octep_ctrl_net_h2f_req_cmd_mac);
 static const u32 state_sz = sizeof(struct octep_ctrl_net_h2f_req_cmd_state);
 static const u32 link_info_sz = sizeof(struct octep_ctrl_net_link_info);
+static const u32 offloads_sz = sizeof(struct octep_ctrl_net_offloads);
 static atomic_t ctrl_net_msg_id;
 
 /* Control plane version in which OCTEP_CTRL_NET_H2F_CMD was added */
 static const u32 octep_ctrl_net_h2f_cmd_versions[OCTEP_CTRL_NET_H2F_CMD_MAX] = {
 	[OCTEP_CTRL_NET_H2F_CMD_INVALID ... OCTEP_CTRL_NET_H2F_CMD_DEV_REMOVE] =
-	 OCTEP_CP_VERSION(1, 0, 0)
+	 OCTEP_CP_VERSION(1, 0, 0),
+	[OCTEP_CTRL_NET_H2F_CMD_OFFLOADS] = OCTEP_CP_VERSION(1, 0, 1)
+
 };
 
 /* Control plane version in which OCTEP_CTRL_NET_F2H_CMD was added */
@@ -405,6 +408,23 @@ int octep_ctrl_net_dev_remove(struct octep_device *oct, int vfid)
 
 	return octep_send_mbox_req(oct, &d, false);
 }
+
+int octep_ctrl_net_set_offloads(struct octep_device *oct, int vfid,
+				struct octep_ctrl_net_offloads *offloads,
+				bool wait_for_response)
+{
+	struct octep_ctrl_net_wait_data d = {};
+	struct octep_ctrl_net_h2f_req *req;
+
+	req = &d.data.req;
+	init_send_req(&d.msg, req, offloads_sz, vfid);
+	req->hdr.s.cmd = OCTEP_CTRL_NET_H2F_CMD_OFFLOADS;
+	req->offloads.cmd = OCTEP_CTRL_NET_CMD_SET;
+	req->offloads.offloads = *offloads;
+
+	return octep_send_mbox_req(oct, &d, wait_for_response);
+}
+
 int octep_ctrl_net_uninit(struct octep_device *oct)
 {
 	struct octep_ctrl_net_wait_data *pos, *n;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
index 0de4de2ceb8f..0b823bea9cd8 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
@@ -43,6 +43,7 @@ enum octep_ctrl_net_h2f_cmd {
 	OCTEP_CTRL_NET_H2F_CMD_LINK_INFO,
 	OCTEP_CTRL_NET_H2F_CMD_GET_INFO,
 	OCTEP_CTRL_NET_H2F_CMD_DEV_REMOVE,
+	OCTEP_CTRL_NET_H2F_CMD_OFFLOADS,
 	OCTEP_CTRL_NET_H2F_CMD_MAX
 };
 
@@ -113,6 +114,26 @@ struct octep_ctrl_net_h2f_req_cmd_link_info {
 	struct octep_ctrl_net_link_info info;
 };
 
+/* offloads */
+struct octep_ctrl_net_offloads {
+	/* supported rx offloads OCTEP_RX_OFFLOAD_* */
+	u16 rx_offloads;
+	/* supported tx offloads OCTEP_TX_OFFLOAD_* */
+	u16 tx_offloads;
+	/* reserved */
+	u32 reserved_offloads;
+	/* extra offloads */
+	u64 ext_offloads;
+};
+
+/* get/set offloads */
+struct octep_ctrl_net_h2f_req_cmd_offloads {
+	/* enum octep_ctrl_net_cmd */
+	u16 cmd;
+	/* struct octep_ctrl_net_offloads */
+	struct octep_ctrl_net_offloads offloads;
+};
+
 /* Host to fw request data */
 struct octep_ctrl_net_h2f_req {
 	union octep_ctrl_net_req_hdr hdr;
@@ -122,6 +143,7 @@ struct octep_ctrl_net_h2f_req {
 		struct octep_ctrl_net_h2f_req_cmd_state link;
 		struct octep_ctrl_net_h2f_req_cmd_state rx;
 		struct octep_ctrl_net_h2f_req_cmd_link_info link_info;
+		struct octep_ctrl_net_h2f_req_cmd_offloads offloads;
 	};
 } __packed;
 
@@ -179,6 +201,7 @@ struct octep_ctrl_net_h2f_resp {
 		struct octep_ctrl_net_h2f_resp_cmd_state rx;
 		struct octep_ctrl_net_link_info link_info;
 		struct octep_ctrl_net_h2f_resp_cmd_get_info info;
+		struct octep_ctrl_net_offloads offloads;
 	};
 } __packed;
 
@@ -381,6 +404,20 @@ int octep_ctrl_net_get_info(struct octep_device *oct, int vfid,
  */
 int octep_ctrl_net_dev_remove(struct octep_device *oct, int vfid);
 
+/**
+ * octep_ctrl_net_set_offloads() - Set offloads in firmware.
+ *
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @offloads: non-null pointer to struct octep_ctrl_net_offloads.
+ * @wait_for_response: poll for response.
+ *
+ * return value: 0 on success, -errno on failure.
+ */
+int octep_ctrl_net_set_offloads(struct octep_device *oct, int vfid,
+				struct octep_ctrl_net_offloads *offloads,
+				bool wait_for_response);
+
 /**
  * octep_ctrl_net_uninit() - Uninitialize data for ctrl net.
  *
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index f22fd309a78f..bbfc06581e77 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -822,6 +822,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 				    struct net_device *netdev)
 {
 	struct octep_device *oct = netdev_priv(netdev);
+	netdev_features_t feat  = netdev->features;
 	struct octep_tx_sglist_desc *sglist;
 	struct octep_tx_buffer *tx_buffer;
 	struct octep_tx_desc_hw *hw_desc;
@@ -855,8 +856,9 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	tx_buffer->skb = skb;
 
 	ih = &hw_desc->ih;
-	ih->tlen = skb->len;
-	ih->pkind = oct->pkind;
+	ih->pkind = oct->conf->fw_info.pkind;
+	ih->fsz = oct->conf->fw_info.fsz;
+	ih->tlen = skb->len + ih->fsz;
 
 	if (!nr_frags) {
 		tx_buffer->gather = 0;
@@ -903,6 +905,19 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 		hw_desc->dptr = tx_buffer->sglist_dma;
 	}
 
+	if (oct->conf->fw_info.tx_ol_flags) {
+		if ((feat & (NETIF_F_TSO)) && (skb_is_gso(skb))) {
+			hw_desc->txm.ol_flags = OCTEP_TX_OFFLOAD_CKSUM;
+			hw_desc->txm.ol_flags |= OCTEP_TX_OFFLOAD_TSO;
+			hw_desc->txm.gso_size =  skb_shinfo(skb)->gso_size;
+			hw_desc->txm.gso_segs =  skb_shinfo(skb)->gso_segs;
+		} else if (feat & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
+			hw_desc->txm.ol_flags = OCTEP_TX_OFFLOAD_CKSUM;
+		}
+		/* due to ESR txm will be swapped by hw */
+		hw_desc->txm64[0] = (__force u64)cpu_to_be64(hw_desc->txm64[0]);
+	}
+
 	xmit_more = netdev_xmit_more();
 
 	__netdev_tx_sent_queue(iq->netdev_q, skb->len, xmit_more);
@@ -1067,6 +1082,41 @@ static int octep_change_mtu(struct net_device *netdev, int new_mtu)
 	return err;
 }
 
+static int octep_set_features(struct net_device *dev, netdev_features_t features)
+{
+	struct octep_ctrl_net_offloads offloads = { 0 };
+	struct octep_device *oct = netdev_priv(dev);
+	int err;
+
+	/* We only support features received from firmware */
+	if ((features & dev->hw_features) != features)
+		return -EINVAL;
+
+	if (features & NETIF_F_TSO)
+		offloads.tx_offloads |= OCTEP_TX_OFFLOAD_TSO;
+
+	if (features & NETIF_F_TSO6)
+		offloads.tx_offloads |= OCTEP_TX_OFFLOAD_TSO;
+
+	if (features & NETIF_F_IP_CSUM)
+		offloads.tx_offloads |= OCTEP_TX_OFFLOAD_CKSUM;
+
+	if (features & NETIF_F_IPV6_CSUM)
+		offloads.tx_offloads |= OCTEP_TX_OFFLOAD_CKSUM;
+
+	if (features & NETIF_F_RXCSUM)
+		offloads.rx_offloads |= OCTEP_RX_OFFLOAD_CKSUM;
+
+	err = octep_ctrl_net_set_offloads(oct,
+					  OCTEP_CTRL_NET_INVALID_VFID,
+					  &offloads,
+					  true);
+	if (!err)
+		dev->features = features;
+
+	return err;
+}
+
 static const struct net_device_ops octep_netdev_ops = {
 	.ndo_open                = octep_open,
 	.ndo_stop                = octep_stop,
@@ -1075,6 +1125,7 @@ static const struct net_device_ops octep_netdev_ops = {
 	.ndo_tx_timeout          = octep_tx_timeout,
 	.ndo_set_mac_address     = octep_set_mac,
 	.ndo_change_mtu          = octep_change_mtu,
+	.ndo_set_features        = octep_set_features,
 };
 
 /**
@@ -1222,7 +1273,6 @@ int octep_device_setup(struct octep_device *oct)
 		goto unsupported_dev;
 	}
 
-	oct->pkind = CFG_GET_IQ_PKIND(oct->conf);
 
 	ret = octep_ctrl_net_init(oct);
 	if (ret)
@@ -1381,7 +1431,11 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netif_carrier_off(netdev);
 
 	netdev->hw_features = NETIF_F_SG;
-	netdev->features |= netdev->hw_features;
+	if (OCTEP_TX_IP_CSUM(octep_dev->conf->fw_info.tx_ol_flags))
+		netdev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
+
+	if (OCTEP_RX_IP_CSUM(octep_dev->conf->fw_info.rx_ol_flags))
+		netdev->hw_features |= NETIF_F_RXCSUM;
 
 	max_rx_pktlen = octep_ctrl_net_get_mtu(octep_dev, OCTEP_CTRL_NET_INVALID_VFID);
 	if (max_rx_pktlen < 0) {
@@ -1394,6 +1448,12 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->max_mtu = max_rx_pktlen - (ETH_HLEN + ETH_FCS_LEN);
 	netdev->mtu = OCTEP_DEFAULT_MTU;
 
+	if (OCTEP_TX_TSO(octep_dev->conf->fw_info.tx_ol_flags)) {
+		netdev->hw_features |= NETIF_F_TSO;
+		netif_set_tso_max_size(netdev, netdev->max_mtu);
+	}
+
+	netdev->features |= netdev->hw_features;
 	err = octep_ctrl_net_get_mac_addr(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
 					  octep_dev->mac_addr);
 	if (err) {
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index e1b4b2af618e..2cb93d425744 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -247,8 +247,7 @@ struct octep_device {
 
 	/* Tx queues (IQ: Instruction Queue) */
 	u16 num_iqs;
-	/* pkind value to be used in every Tx hardware descriptor */
-	u8 pkind;
+
 	/* Pointers to Octeon Tx queues */
 	struct octep_iq *iq[OCTEP_MAX_IQ];
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 3c43f8078528..4746a6b258f0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -143,7 +143,7 @@ static int octep_setup_oq(struct octep_device *oct, int q_no)
 	 * additional header is filled-in by Octeon after length field in
 	 * Rx packets. this header contains additional packet information.
 	 */
-	if (oct->caps_enabled)
+	if (oct->conf->fw_info.rx_ol_flags)
 		oq->max_single_buffer_size -= OCTEP_OQ_RESP_HW_EXT_SIZE;
 
 	oq->refill_threshold = CFG_GET_OQ_REFILL_THRESHOLD(oct->conf);
@@ -353,11 +353,13 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 				 struct octep_oq *oq, u16 pkts_to_process)
 {
 	struct octep_oq_resp_hw_ext *resp_hw_ext = NULL;
+	netdev_features_t feat = oq->netdev->features;
 	struct octep_rx_buffer *buff_info;
 	struct octep_oq_resp_hw *resp_hw;
 	u32 pkt, rx_bytes, desc_used;
 	struct sk_buff *skb;
 	u16 data_offset;
+	u16 rx_ol_flags;
 	u32 read_idx;
 
 	read_idx = oq->host_read_idx;
@@ -372,7 +374,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 
 		/* Swap the length field that is in Big-Endian to CPU */
 		buff_info->len = be64_to_cpu(resp_hw->length);
-		if (oct->caps_enabled & OCTEP_CAP_RX_CHECKSUM) {
+		if (oct->conf->fw_info.rx_ol_flags) {
 			/* Extended response header is immediately after
 			 * response header (resp_hw)
 			 */
@@ -384,11 +386,13 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 			 */
 			data_offset = OCTEP_OQ_RESP_HW_SIZE +
 				      OCTEP_OQ_RESP_HW_EXT_SIZE;
+			rx_ol_flags = resp_hw_ext->rx_ol_flags;
 		} else {
 			/* Data is immediately after
 			 * Hardware Rx response header.
 			 */
 			data_offset = OCTEP_OQ_RESP_HW_SIZE;
+			rx_ol_flags = 0;
 		}
 		rx_bytes += buff_info->len;
 
@@ -444,8 +448,8 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 
 		skb->dev = oq->netdev;
 		skb->protocol =  eth_type_trans(skb, skb->dev);
-		if (resp_hw_ext &&
-		    resp_hw_ext->csum_verified == OCTEP_CSUM_VERIFIED)
+		if (feat & NETIF_F_RXCSUM &&
+		    OCTEP_RX_CSUM_VERIFIED(rx_ol_flags))
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 		else
 			skb->ip_summed = CHECKSUM_NONE;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
index 49feae80d7d2..3b08e2d560dc 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
@@ -20,13 +20,33 @@ struct octep_oq_desc_hw {
 	dma_addr_t buffer_ptr;
 	u64 info_ptr;
 };
+
 static_assert(sizeof(struct octep_oq_desc_hw) == 16);
 
 #define OCTEP_OQ_DESC_SIZE    (sizeof(struct octep_oq_desc_hw))
 
-#define OCTEP_CSUM_L4_VERIFIED 0x1
-#define OCTEP_CSUM_IP_VERIFIED 0x2
-#define OCTEP_CSUM_VERIFIED (OCTEP_CSUM_L4_VERIFIED | OCTEP_CSUM_IP_VERIFIED)
+/* Rx offload flags */
+#define OCTEP_RX_OFFLOAD_VLAN_STRIP	BIT(0)
+#define OCTEP_RX_OFFLOAD_IPV4_CKSUM	BIT(1)
+#define OCTEP_RX_OFFLOAD_UDP_CKSUM	BIT(2)
+#define OCTEP_RX_OFFLOAD_TCP_CKSUM	BIT(3)
+
+#define OCTEP_RX_OFFLOAD_CKSUM		(OCTEP_RX_OFFLOAD_IPV4_CKSUM | \
+					 OCTEP_RX_OFFLOAD_UDP_CKSUM | \
+					 OCTEP_RX_OFFLOAD_TCP_CKSUM)
+
+#define OCTEP_RX_IP_CSUM(flags)		((flags) & \
+					 (OCTEP_RX_OFFLOAD_IPV4_CKSUM | \
+					  OCTEP_RX_OFFLOAD_TCP_CKSUM | \
+					  OCTEP_RX_OFFLOAD_UDP_CKSUM))
+
+/* bit 0 is vlan strip */
+#define OCTEP_RX_CSUM_IP_VERIFIED	BIT(1)
+#define OCTEP_RX_CSUM_L4_VERIFIED	BIT(2)
+
+#define OCTEP_RX_CSUM_VERIFIED(flags)	((flags) & \
+					 (OCTEP_RX_CSUM_L4_VERIFIED | \
+					  OCTEP_RX_CSUM_IP_VERIFIED))
 
 /* Extended Response Header in packet data received from Hardware.
  * Includes metadata like checksum status.
@@ -35,11 +55,12 @@ static_assert(sizeof(struct octep_oq_desc_hw) == 16);
  */
 struct octep_oq_resp_hw_ext {
 	/* Reserved. */
-	u64 reserved:62;
+	u64 rsvd:48;
 
-	/* checksum verified. */
-	u64 csum_verified:2;
+	/* offload flags */
+	u16 rx_ol_flags;
 };
+
 static_assert(sizeof(struct octep_oq_resp_hw_ext) == 8);
 
 #define  OCTEP_OQ_RESP_HW_EXT_SIZE   (sizeof(struct octep_oq_resp_hw_ext))
@@ -52,6 +73,7 @@ struct octep_oq_resp_hw {
 	/* The Length of the packet. */
 	__be64 length;
 };
+
 static_assert(sizeof(struct octep_oq_resp_hw) == 8);
 
 #define OCTEP_OQ_RESP_HW_SIZE   (sizeof(struct octep_oq_resp_hw))
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 1ba4ff65e54d..059fa921069f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -36,6 +36,7 @@ struct octep_tx_sglist_desc {
 	u16 len[4];
 	dma_addr_t dma_ptr[4];
 };
+
 static_assert(sizeof(struct octep_tx_sglist_desc) == 40);
 
 /* Each Scatter/Gather entry sent to hardwar hold four pointers.
@@ -237,32 +238,53 @@ struct octep_instr_hdr {
 	/* Reserved3 */
 	u64 reserved3:1;
 };
+
 static_assert(sizeof(struct octep_instr_hdr) == 8);
 
-/* Hardware Tx completion response header */
-struct octep_instr_resp_hdr {
-	/* Request ID  */
-	u64 rid:16;
+/* Tx offload flags */
+#define OCTEP_TX_OFFLOAD_VLAN_INSERT   BIT(0)
+#define OCTEP_TX_OFFLOAD_IPV4_CKSUM    BIT(1)
+#define OCTEP_TX_OFFLOAD_UDP_CKSUM     BIT(2)
+#define OCTEP_TX_OFFLOAD_TCP_CKSUM     BIT(3)
+#define OCTEP_TX_OFFLOAD_SCTP_CKSUM    BIT(4)
+#define OCTEP_TX_OFFLOAD_TCP_TSO       BIT(5)
+#define OCTEP_TX_OFFLOAD_UDP_TSO       BIT(6)
+
+#define OCTEP_TX_OFFLOAD_CKSUM         (OCTEP_TX_OFFLOAD_IPV4_CKSUM | \
+					OCTEP_TX_OFFLOAD_UDP_CKSUM | \
+					OCTEP_TX_OFFLOAD_TCP_CKSUM)
+
+#define OCTEP_TX_OFFLOAD_TSO           (OCTEP_TX_OFFLOAD_TCP_TSO | \
+					OCTEP_TX_OFFLOAD_UDP_TSO)
 
-	/* PCIe port to use for response */
-	u64 pcie_port:3;
+#define OCTEP_TX_IP_CSUM(flags)		((flags) & \
+					 (OCTEP_TX_OFFLOAD_IPV4_CKSUM | \
+					  OCTEP_TX_OFFLOAD_TCP_CKSUM | \
+					  OCTEP_TX_OFFLOAD_UDP_CKSUM))
 
-	/* Scatter indicator  1=scatter */
-	u64 scatter:1;
+#define OCTEP_TX_TSO(flags)		((flags) & \
+					 (OCTEP_TX_OFFLOAD_TCP_TSO | \
+					  OCTEP_TX_OFFLOAD_UDP_TSO))
 
-	/* Size of Expected result OR no. of entries in scatter list */
-	u64 rlenssz:14;
+struct tx_mdata {
 
-	/* Desired destination port for result */
-	u64 dport:6;
+	/* offload flags */
+	u16 ol_flags;
 
-	/* Opcode Specific parameters */
-	u64 param:8;
+	/* gso size */
+	u16 gso_size;
 
-	/* Opcode for the return packet  */
-	u64 opcode:16;
+	/* gso flags */
+	u16 gso_segs;
+
+	/* reserved */
+	u16 rsvd1;
+
+	/* reserved */
+	u64 rsvd2;
 };
-static_assert(sizeof(struct octep_instr_hdr) == 8);
+
+static_assert(sizeof(struct tx_mdata) == 16);
 
 /* 64-byte Tx instruction format.
  * Format of instruction for a 64-byte mode input queue.
@@ -281,18 +303,14 @@ struct octep_tx_desc_hw {
 		struct octep_instr_hdr ih;
 		u64 ih64;
 	};
-
-	/* Pointer where the response for a RAW mode packet will be written
-	 * by Octeon.
-	 */
-	u64 rptr;
-
-	/* Input Instruction Response Header. */
-	struct octep_instr_resp_hdr irh;
-
+	union  {
+		u64 txm64[2];
+		struct tx_mdata txm;
+	};
 	/* Additional headers available in a 64-byte instruction. */
-	u64 exhdr[4];
+	u64 exthdr[4];
 };
+
 static_assert(sizeof(struct octep_tx_desc_hw) == 64);
 
 #define OCTEP_IQ_DESC_SIZE (sizeof(struct octep_tx_desc_hw))
-- 
2.25.1

