Return-Path: <linux-kernel+bounces-100088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C18791A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DF11C21E13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27278B46;
	Tue, 12 Mar 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U48ECZfe"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26077F32;
	Tue, 12 Mar 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237786; cv=none; b=kn/ewfnvVeAxuQ5WidOfBzmgnMwptSygKbGSkBoFhpBnslZQbrg8GwX3UpTybUz0krlUPlrPV7ba9p6UDUMhT6bRR6dI/BukAiJy5RTLfBiW6oovCiv2F2fxCDhZhCQNz0TfE/WaDQWHN1VDGLiEMOE+gwQ9ivb68gJE9S1JaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237786; c=relaxed/simple;
	bh=X2JdHfoFhDDx9qcJ2AjqW86BdZcBdjS55SMJWsvq66c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnD5+CpMegPZ3vxxWj8agFTNOu/ZaLvPtWfFKYLZiJlpJbG+z28Z4phahaDrm99+Z8dQOcrLEKd4ZNTxQlpGpOvGWc+CPw7WIAr3CNcFVB2Vjxxkhnd6CB73ZNBtPIqIfUZn2NdVC+9afIZQR7u0uiO2XzMvuVeyGJE2Tzn4u6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U48ECZfe; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CA2cVk080573;
	Tue, 12 Mar 2024 05:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710237758;
	bh=ESmzPjMa4Gpmyp5GhchrrCoCpXIRl/xxQcH+prg0UXQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=U48ECZfed64rLfnPMNSihKQBDB7T38abBanuJByfWGc7hKnCznTQpGsIUOLeo9p/U
	 Od+CObqPR6y14TOzqDfyNdD1D5qBy851XZ1xWzOgl+IZBt9jNvP3B6pXsdTWNU4lLN
	 49P7HXbIAFP/BEERksuwfv05iDXXUOcLdny6FUNs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CA2cDF018727
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Mar 2024 05:02:38 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 05:02:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 05:02:37 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CA2bQZ075069;
	Tue, 12 Mar 2024 05:02:37 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Chintan Vankar
	<c-vankar@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Grygorii
 Strashko" <grygorii.strashko@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, "Roger
 Quadros" <rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        "Eric
 Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v2 2/3] net: ethernet: ti: am65-cpsw: Enable RX HW timestamp only for PTP packets
Date: Tue, 12 Mar 2024 15:32:32 +0530
Message-ID: <20240312100233.941763-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312100233.941763-1-c-vankar@ti.com>
References: <20240312100233.941763-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The current mechanism of timestamping, am65-cpsw-nuss driver
timestamps all received packets by setting the TSTAMP_EN bit
in CPTS_CONTROL register, which directs the CPTS module to
timestamp all received packets, followed by passing timestamp
via DMA descriptors. This mechanism is responsible for triggering
errata i2401: "CPSW: Host Timestamps Cause CPSW Port to Lock up"

To prevent port lock up, disable TSTAMP_EN bit in CPTS_CONTROL
register. The workaround for timestamping received packets is to
utilize the CPTS Event FIFO that records timestamps corresponding to
certain events, with one such event being the reception of an
Ethernet packet with the EtherType field set to Precision Time
Protocol (PTP).

Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Changes from v1 to v2:
- Removed skb_reset_mac_header() from am65_cpsw_nuss_rx_packets()
  to call it for the packets which are to be timestamped.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 50 +++++++++++-------------
 1 file changed, 23 insertions(+), 27 deletions(-)

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
-- 
2.34.1


