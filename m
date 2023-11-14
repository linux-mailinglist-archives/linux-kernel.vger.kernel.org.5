Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935247EAF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjKNL3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjKNL3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:17 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF81BDA;
        Tue, 14 Nov 2023 03:28:56 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27D9B6000F;
        Tue, 14 Nov 2023 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699961335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zf35sOHFYIOY2HOVCtwWkmKHY/uNOiLiCC6UQaPPXNc=;
        b=Jpg6DCuQNepBQ4ydkDe8NOmP5JfeyerOs3olf2kzcrPfcpYj9YjXKwFfJrUYsZMvLVjDQ1
        GnHo2donZGqmfpv+8O7pv0okw2n7d9Za7BIrVQsvwXRpaR5MfNPYp5Lqyw/wcfNEYlgEwy
        UCr2T5RIsc/rxYzRLENUh8UfYCqqr9G+XMi1jEFMjRvuLB97vwER2MP6ajuwFMYx6nE4bI
        DOcKhmf2SfPSLCY2ORTdFOBqYfMHm2/Dwq79UtXMzFPbhyNsBCOmLAzWaP5+Hap57E0SUW
        yeoOm/q5yhbdAKYALQNy3T5BtVu1iLKgRC/2FtunoNNVPmW0cXBKRrAfXnCYgw==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 12:28:32 +0100
Subject: [PATCH net-next v7 04/16] net: macb: Convert to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-4-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware timestamping through ndo_eth_ioctl() is going away.
Convert the macb driver to the new API before that can be removed.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/cadence/macb.h      | 15 ++++++++----
 drivers/net/ethernet/cadence/macb_main.c | 42 +++++++++++++++++++++++++-------
 drivers/net/ethernet/cadence/macb_ptp.c  | 28 ++++++++-------------
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 78c972bb1d96..aa5700ac9c00 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1165,9 +1165,10 @@ struct macb_ptp_info {
 	int (*get_ts_info)(struct net_device *dev,
 			   struct ethtool_ts_info *info);
 	int (*get_hwtst)(struct net_device *netdev,
-			 struct ifreq *ifr);
+			 struct kernel_hwtstamp_config *tstamp_config);
 	int (*set_hwtst)(struct net_device *netdev,
-			 struct ifreq *ifr, int cmd);
+			 struct kernel_hwtstamp_config *tstamp_config,
+			 struct netlink_ext_ack *extack);
 };
 
 struct macb_pm_data {
@@ -1314,7 +1315,7 @@ struct macb {
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
 	struct tsu_incr tsu_incr;
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 
 	/* RX queue filer rule set*/
 	struct ethtool_rx_fs_list rx_fs_list;
@@ -1363,8 +1364,12 @@ static inline void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb, stru
 
 	gem_ptp_rxstamp(bp, skb, desc);
 }
-int gem_get_hwtst(struct net_device *dev, struct ifreq *rq);
-int gem_set_hwtst(struct net_device *dev, struct ifreq *ifr, int cmd);
+
+int gem_get_hwtst(struct net_device *dev,
+		  struct kernel_hwtstamp_config *tstamp_config);
+int gem_set_hwtst(struct net_device *dev,
+		  struct kernel_hwtstamp_config *tstamp_config,
+		  struct netlink_ext_ack *extack);
 #else
 static inline void gem_ptp_init(struct net_device *ndev) { }
 static inline void gem_ptp_remove(struct net_device *ndev) { }
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index cebae0f418f2..898debfd4db3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3773,18 +3773,38 @@ static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	if (!netif_running(dev))
 		return -EINVAL;
 
-	if (bp->ptp_info) {
-		switch (cmd) {
-		case SIOCSHWTSTAMP:
-			return bp->ptp_info->set_hwtst(dev, rq, cmd);
-		case SIOCGHWTSTAMP:
-			return bp->ptp_info->get_hwtst(dev, rq);
-		}
-	}
-
 	return phylink_mii_ioctl(bp->phylink, rq, cmd);
 }
 
+static int macb_hwtstamp_get(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	if (!bp->ptp_info)
+		return -EOPNOTSUPP;
+
+	return bp->ptp_info->get_hwtst(dev, cfg);
+}
+
+static int macb_hwtstamp_set(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	if (!bp->ptp_info)
+		return -EOPNOTSUPP;
+
+	return bp->ptp_info->set_hwtst(dev, cfg, extack);
+}
+
 static inline void macb_set_txcsum_feature(struct macb *bp,
 					   netdev_features_t features)
 {
@@ -3884,6 +3904,8 @@ static const struct net_device_ops macb_netdev_ops = {
 #endif
 	.ndo_set_features	= macb_set_features,
 	.ndo_features_check	= macb_features_check,
+	.ndo_hwtstamp_set	= macb_hwtstamp_set,
+	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -4539,6 +4561,8 @@ static const struct net_device_ops at91ether_netdev_ops = {
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= at91ether_poll_controller,
 #endif
+	.ndo_hwtstamp_set	= macb_hwtstamp_set,
+	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 };
 
 static int at91ether_clk_init(struct platform_device *pdev, struct clk **pclk,
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 51d26fa190d7..a63bf29c4fa8 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -374,19 +374,16 @@ static int gem_ptp_set_ts_mode(struct macb *bp,
 	return 0;
 }
 
-int gem_get_hwtst(struct net_device *dev, struct ifreq *rq)
+int gem_get_hwtst(struct net_device *dev,
+		  struct kernel_hwtstamp_config *tstamp_config)
 {
-	struct hwtstamp_config *tstamp_config;
 	struct macb *bp = netdev_priv(dev);
 
-	tstamp_config = &bp->tstamp_config;
+	*tstamp_config = bp->tstamp_config;
 	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0)
 		return -EOPNOTSUPP;
 
-	if (copy_to_user(rq->ifr_data, tstamp_config, sizeof(*tstamp_config)))
-		return -EFAULT;
-	else
-		return 0;
+	return 0;
 }
 
 static void gem_ptp_set_one_step_sync(struct macb *bp, u8 enable)
@@ -401,22 +398,18 @@ static void gem_ptp_set_one_step_sync(struct macb *bp, u8 enable)
 		macb_writel(bp, NCR, reg_val & ~MACB_BIT(OSSMODE));
 }
 
-int gem_set_hwtst(struct net_device *dev, struct ifreq *ifr, int cmd)
+int gem_set_hwtst(struct net_device *dev,
+		  struct kernel_hwtstamp_config *tstamp_config,
+		  struct netlink_ext_ack *extack)
 {
 	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
 	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
-	struct hwtstamp_config *tstamp_config;
 	struct macb *bp = netdev_priv(dev);
 	u32 regval;
 
-	tstamp_config = &bp->tstamp_config;
 	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0)
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(tstamp_config, ifr->ifr_data,
-			   sizeof(*tstamp_config)))
-		return -EFAULT;
-
 	switch (tstamp_config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		break;
@@ -463,12 +456,11 @@ int gem_set_hwtst(struct net_device *dev, struct ifreq *ifr, int cmd)
 		return -ERANGE;
 	}
 
+	bp->tstamp_config = *tstamp_config;
+
 	if (gem_ptp_set_ts_mode(bp, tx_bd_control, rx_bd_control) != 0)
 		return -ERANGE;
 
-	if (copy_to_user(ifr->ifr_data, tstamp_config, sizeof(*tstamp_config)))
-		return -EFAULT;
-	else
-		return 0;
+	return 0;
 }
 

-- 
2.25.1

