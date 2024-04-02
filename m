Return-Path: <linux-kernel+bounces-127880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972889522C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7A7B20FF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4B7A141;
	Tue,  2 Apr 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KzhPKTag"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90526995D;
	Tue,  2 Apr 2024 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058275; cv=none; b=E9WaoQtUl/RcvnP+sIRrI2pTzXU9+Qtw1fMX2mF8Lc2NalCi+RPI1NxChP0FFHgX/h233vETIc6Cz4526XJXvT0s0RqBdeJdKkN8jFZv/7NKukTVSYRwiEwvZ5EQCjxMD7qr/sxxvJv8vrXjLMzbKdLJS1DQlWtjE0jGleb+nBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058275; c=relaxed/simple;
	bh=Svu2J0QByVKEd+oG1fGX0qhew1gVrOOxuzeTtp1W2Ek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+KpoFMpKyc8xjIk2kR9TnGPCDPZQOng29pxikkXifihYqWZn0BDGijPrJi+3huyJhkUGAHWMQj8r0dsaA+EE1JSL68Xyk/HpJivSIuQXslLhIPCTeJeZsdFLkY+r/k97/DtHSe1Nb2aAEoJU16Vbw0FuoEsyPxoNMdMOTLDYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KzhPKTag; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432BiBiR032587;
	Tue, 2 Apr 2024 06:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712058251;
	bh=SxV8boPVmRxehIfPNpyaJ0E0+yqaB5xXHEUkGcUpAmg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KzhPKTagl7NnzINDBrrukRGWXuirqW01DNfdMKorSEGmoyoPIpDR7S6Wpyu4GReCr
	 HMlOenq2WZIn83djYVLvPkNoYOK6NN9qZJ5xjuO30mgI8YsSDGqBQAf8a2BXQZ89o3
	 YRrfRkpsTC3ESsrRvMj9Qj60nf+HP0BEXHf0SKyE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432BiBPU090315
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 06:44:11 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 06:44:11 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 06:44:11 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432BiAqe126413;
	Tue, 2 Apr 2024 06:44:10 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Chintan Vankar
	<c-vankar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v5 2/2] net: ethernet: ti: am65-cpsw/ethtool: Enable RX HW timestamp only for PTP packets
Date: Tue, 2 Apr 2024 17:14:05 +0530
Message-ID: <20240402114405.219100-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402114405.219100-1-c-vankar@ti.com>
References: <20240402114405.219100-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

In the current mechanism of timestamping, am65-cpsw-nuss driver
enables hardware timestamping for all received packets by setting
the TSTAMP_EN bit in CPTS_CONTROL register, which directs the CPTS
module to timestamp all received packets, followed by passing
timestamp via DMA descriptors. This mechanism causes CPSW Port to
Lock up.

To prevent port lock up, don't enable rx packet timestamping by
setting TSTAMP_EN bit in CPTS_CONTROL register. The workaround for
timestamping received packets is to utilize the CPTS Event FIFO
that records timestamps corresponding to certain events. The CPTS
module is configured to generate timestamps for Multicast Ethernet,
UDP/IPv4 and UDP/IPv6 PTP packets.

Update supported hwtstamp_rx_filters values for CPSW's timestamping
capability.

Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v4:
https://lore.kernel.org/r/20240327054234.1906957-2-c-vankar@ti.com/

Changes from v4 to v5:
- Updated commit message.
- Combined [PATCH v4 2/3] and [PATCH v4 3/3] in v5.

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 13 +++++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 50 ++++++++++-----------
 drivers/net/ethernet/ti/am65-cpts.c         | 23 ----------
 drivers/net/ethernet/ti/am65-cpts.h         |  5 ---
 4 files changed, 35 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index d6ce2c9f0a8d..a1d0935d1ebe 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -695,6 +695,17 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 					 struct ethtool_ts_info *info)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	unsigned int ptp_v2_filter;
+
+	ptp_v2_filter = BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L2_SYNC)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
+			BIT(HWTSTAMP_FILTER_PTP_V2_EVENT)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_SYNC)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ);
 
 	if (!IS_ENABLED(CONFIG_TI_K3_AM65_CPTS))
 		return ethtool_op_get_ts_info(ndev, info);
@@ -708,7 +719,7 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 	info->phc_index = am65_cpts_phc_index(common->cpts);
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
-	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | ptp_v2_filter;
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2939a21ca74f..7809bb814934 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -101,6 +101,12 @@
 #define AM65_CPSW_PN_TS_CTL_TX_HOST_TS_EN	BIT(11)
 #define AM65_CPSW_PN_TS_CTL_MSG_TYPE_EN_SHIFT	16
 
+#define AM65_CPSW_PN_TS_CTL_RX_ANX_F_EN		BIT(0)
+#define AM65_CPSW_PN_TS_CTL_RX_VLAN_LT1_EN	BIT(1)
+#define AM65_CPSW_PN_TS_CTL_RX_VLAN_LT2_EN	BIT(2)
+#define AM65_CPSW_PN_TS_CTL_RX_ANX_D_EN		BIT(3)
+#define AM65_CPSW_PN_TS_CTL_RX_ANX_E_EN		BIT(9)
+
 /* AM65_CPSW_PORTN_REG_TS_SEQ_LTYPE_REG register fields */
 #define AM65_CPSW_PN_TS_SEQ_ID_OFFSET_SHIFT	16
 
@@ -124,6 +130,11 @@
 	 AM65_CPSW_PN_TS_CTL_TX_ANX_E_EN |	\
 	 AM65_CPSW_PN_TS_CTL_TX_ANX_F_EN)
 
+#define AM65_CPSW_TS_RX_ANX_ALL_EN		\
+	(AM65_CPSW_PN_TS_CTL_RX_ANX_D_EN |	\
+	 AM65_CPSW_PN_TS_CTL_RX_ANX_E_EN |	\
+	 AM65_CPSW_PN_TS_CTL_RX_ANX_F_EN)
+
 #define AM65_CPSW_ALE_AGEOUT_DEFAULT	30
 /* Number of TX/RX descriptors */
 #define AM65_CPSW_MAX_TX_DESC	500
@@ -749,18 +760,6 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
 	return ret;
 }
 
-static void am65_cpsw_nuss_rx_ts(struct sk_buff *skb, u32 *psdata)
-{
-	struct skb_shared_hwtstamps *ssh;
-	u64 ns;
-
-	ns = ((u64)psdata[1] << 32) | psdata[0];
-
-	ssh = skb_hwtstamps(skb);
-	memset(ssh, 0, sizeof(*ssh));
-	ssh->hwtstamp = ns_to_ktime(ns);
-}
-
 /* RX psdata[2] word format - checksum information */
 #define AM65_CPSW_RX_PSD_CSUM_ADD	GENMASK(15, 0)
 #define AM65_CPSW_RX_PSD_CSUM_ERR	BIT(16)
@@ -841,9 +840,6 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	skb->dev = ndev;
 
 	psdata = cppi5_hdesc_get_psdata(desc_rx);
-	/* add RX timestamp */
-	if (port->rx_ts_enabled)
-		am65_cpsw_nuss_rx_ts(skb, psdata);
 	csum_info = psdata[2];
 	dev_dbg(dev, "%s rx csum_info:%#x\n", __func__, csum_info);
 
@@ -856,6 +852,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 		ndev_priv = netdev_priv(ndev);
 		am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
 		skb_put(skb, pkt_len);
+		if (port->rx_ts_enabled)
+			am65_cpts_rx_timestamp(common->cpts, skb);
 		skb->protocol = eth_type_trans(skb, ndev);
 		am65_cpsw_nuss_rx_csum(skb, csum_info);
 		napi_gro_receive(&common->napi_rx, skb);
@@ -1334,7 +1332,6 @@ static int am65_cpsw_nuss_ndo_slave_set_mac_address(struct net_device *ndev,
 static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 				       struct ifreq *ifr)
 {
-	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	u32 ts_ctrl, seq_id, ts_ctrl_ltype2, ts_vlan_ltype;
 	struct hwtstamp_config cfg;
@@ -1358,11 +1355,6 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	case HWTSTAMP_FILTER_NONE:
 		port->rx_ts_enabled = false;
 		break;
-	case HWTSTAMP_FILTER_ALL:
-	case HWTSTAMP_FILTER_SOME:
-	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
-	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
@@ -1372,10 +1364,13 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-	case HWTSTAMP_FILTER_NTP_ALL:
 		port->rx_ts_enabled = true;
-		cfg.rx_filter = HWTSTAMP_FILTER_ALL;
+		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_SOME:
+	case HWTSTAMP_FILTER_NTP_ALL:
+		return -EOPNOTSUPP;
 	default:
 		return -ERANGE;
 	}
@@ -1405,6 +1400,10 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 		ts_ctrl |= AM65_CPSW_TS_TX_ANX_ALL_EN |
 			   AM65_CPSW_PN_TS_CTL_TX_VLAN_LT1_EN;
 
+	if (port->rx_ts_enabled)
+		ts_ctrl |= AM65_CPSW_TS_RX_ANX_ALL_EN |
+			   AM65_CPSW_PN_TS_CTL_RX_VLAN_LT1_EN;
+
 	writel(seq_id, port->port_base + AM65_CPSW_PORTN_REG_TS_SEQ_LTYPE_REG);
 	writel(ts_vlan_ltype, port->port_base +
 	       AM65_CPSW_PORTN_REG_TS_VLAN_LTYPE_REG);
@@ -1412,9 +1411,6 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	       AM65_CPSW_PORTN_REG_TS_CTL_LTYPE2);
 	writel(ts_ctrl, port->port_base + AM65_CPSW_PORTN_REG_TS_CTL);
 
-	/* en/dis RX timestamp */
-	am65_cpts_rx_enable(common->cpts, port->rx_ts_enabled);
-
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
 
@@ -1431,7 +1427,7 @@ static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
 	cfg.tx_type = port->tx_ts_enabled ?
 		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
 	cfg.rx_filter = port->rx_ts_enabled ?
-			HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
+			HWTSTAMP_FILTER_PTP_V2_EVENT : HWTSTAMP_FILTER_NONE;
 
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index bc0bfda1db12..43ab43a13931 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -859,29 +859,6 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
 	return delay;
 }
 
-/**
- * am65_cpts_rx_enable - enable rx timestamping
- * @cpts: cpts handle
- * @en: enable
- *
- * This functions enables rx packets timestamping. The CPTS can timestamp all
- * rx packets.
- */
-void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
-{
-	u32 val;
-
-	mutex_lock(&cpts->ptp_clk_lock);
-	val = am65_cpts_read32(cpts, control);
-	if (en)
-		val |= AM65_CPTS_CONTROL_TSTAMP_EN;
-	else
-		val &= ~AM65_CPTS_CONTROL_TSTAMP_EN;
-	am65_cpts_write32(cpts, val, control);
-	mutex_unlock(&cpts->ptp_clk_lock);
-}
-EXPORT_SYMBOL_GPL(am65_cpts_rx_enable);
-
 static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
 {
 	unsigned int ptp_class = ptp_classify_raw(skb);
diff --git a/drivers/net/ethernet/ti/am65-cpts.h b/drivers/net/ethernet/ti/am65-cpts.h
index 90296968a75c..6099d772799d 100644
--- a/drivers/net/ethernet/ti/am65-cpts.h
+++ b/drivers/net/ethernet/ti/am65-cpts.h
@@ -25,7 +25,6 @@ int am65_cpts_phc_index(struct am65_cpts *cpts);
 void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
 void am65_cpts_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
 void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
-void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en);
 u64 am65_cpts_ns_gettime(struct am65_cpts *cpts);
 int am65_cpts_estf_enable(struct am65_cpts *cpts, int idx,
 			  struct am65_cpts_estf_cfg *cfg);
@@ -64,10 +63,6 @@ static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
 {
 }
 
-static inline void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
-{
-}
-
 static inline s64 am65_cpts_ns_gettime(struct am65_cpts *cpts)
 {
 	return 0;
-- 
2.34.1


