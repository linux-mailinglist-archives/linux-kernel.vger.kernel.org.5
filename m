Return-Path: <linux-kernel+bounces-66748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE19E85610C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19E51C20C75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927E412C559;
	Thu, 15 Feb 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MnWReYKz"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63846129A75;
	Thu, 15 Feb 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995411; cv=none; b=RVNGj8YWdCFHWBLhP7g9vW44sypJKBgFRWCDnSmudvjOR/FCZQG6A/x2g2WTk4X04/jABjY+J6JwZN4iXd6rHUZHiXxnzjD32bFyPwGYmlnAY4JglF80q4LBzsOtdWMSgMHBxyp6TsvNGomrS7tg1rr8fZsB2hSK/f4qzuqLDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995411; c=relaxed/simple;
	bh=BJwDCaMI0aYz6VnWacdyLdYJC4bbqH19di3iUcevG24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShtipA0RnOzWf3xlACnCsVtYiHWQzkO4rVuwrtGMGP6nVSODKKEEt62ZQ6fcRcKJXjcVtX1i4f79xjIEh3qAIExenLHyioH5TUK3Cc7u2h8E6Jvtey/jyEWKMFy6jue8Xb04QrZeiZgr9qOuRqGWBS9F0thjoJf7Q9jQWLEAUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MnWReYKz; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FBA0wY081722;
	Thu, 15 Feb 2024 05:10:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707995400;
	bh=M407onLK2mqpOgnXCBUnGsRyi/aiFxEPhpsZL7d0pG8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MnWReYKzA+1q3mB0FCeKc5q6tTrpn6Fq1u0o/t7dZeNGeAaCDkZzFNSdJYYq6v7x7
	 muKAnYTy3Or9RrpiSW7P98ZoROZVOHdwVYnKhWQeKDIS7Dq1iziDliuB1CHzko7eSf
	 X8WZsZfz30dlZhmo8x02T1UTGItUsQX0zJrupCNI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FBA0qV001868
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 05:10:00 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 05:10:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 05:10:00 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FB9x73111243;
	Thu, 15 Feb 2024 05:09:59 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw: Enable RX HW timestamp only for PTP packets
Date: Thu, 15 Feb 2024 16:39:53 +0530
Message-ID: <20240215110953.3225099-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215110953.3225099-1-c-vankar@ti.com>
References: <20240215110953.3225099-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The CPSW peripherals on J7AHP, J7VCL, J7AEP, J7ES, AM64 SoCs have
an errata i2401 "CPSW: Host Timestamps Cause CPSW Port to Lock up".

As a workaround, Disable timestamping on all RX packets and timestamp
only PTP packets.

Set Time Sync Receive bits in Time Sync control register so that
packets can be determined as a valid Ethernet Receive Event for time
synchronization.

Update the RX filter configuration to indicate Hardware Timestamping
support only for PTP packets.

Replace "am65_cpsw_rx_ts()" function with "am65_cpts_rx_timestamp()"
function which timestamps only PTP packets.

Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 51 +++++++++++-------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 9d2f4ac783e4..ab843fb64b93 100644
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
 
@@ -856,6 +852,9 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 		ndev_priv = netdev_priv(ndev);
 		am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
 		skb_put(skb, pkt_len);
+		skb_reset_mac_header(skb);
+		if (port->rx_ts_enabled)
+			am65_cpts_rx_timestamp(common->cpts, skb);
 		skb->protocol = eth_type_trans(skb, ndev);
 		am65_cpsw_nuss_rx_csum(skb, csum_info);
 		napi_gro_receive(&common->napi_rx, skb);
@@ -1334,7 +1333,6 @@ static int am65_cpsw_nuss_ndo_slave_set_mac_address(struct net_device *ndev,
 static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 				       struct ifreq *ifr)
 {
-	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	u32 ts_ctrl, seq_id, ts_ctrl_ltype2, ts_vlan_ltype;
 	struct hwtstamp_config cfg;
@@ -1358,11 +1356,6 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
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
@@ -1372,10 +1365,13 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
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
@@ -1405,6 +1401,10 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 		ts_ctrl |= AM65_CPSW_TS_TX_ANX_ALL_EN |
 			   AM65_CPSW_PN_TS_CTL_TX_VLAN_LT1_EN;
 
+	if (port->rx_ts_enabled)
+		ts_ctrl |= AM65_CPSW_TS_RX_ANX_ALL_EN |
+			   AM65_CPSW_PN_TS_CTL_RX_VLAN_LT1_EN;
+
 	writel(seq_id, port->port_base + AM65_CPSW_PORTN_REG_TS_SEQ_LTYPE_REG);
 	writel(ts_vlan_ltype, port->port_base +
 	       AM65_CPSW_PORTN_REG_TS_VLAN_LTYPE_REG);
@@ -1412,9 +1412,6 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	       AM65_CPSW_PORTN_REG_TS_CTL_LTYPE2);
 	writel(ts_ctrl, port->port_base + AM65_CPSW_PORTN_REG_TS_CTL);
 
-	/* en/dis RX timestamp */
-	am65_cpts_rx_enable(common->cpts, port->rx_ts_enabled);
-
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
 
@@ -1431,7 +1428,7 @@ static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
 	cfg.tx_type = port->tx_ts_enabled ?
 		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
 	cfg.rx_filter = port->rx_ts_enabled ?
-			HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
+			HWTSTAMP_FILTER_PTP_V2_EVENT : HWTSTAMP_FILTER_NONE;
 
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
-- 
2.34.1


