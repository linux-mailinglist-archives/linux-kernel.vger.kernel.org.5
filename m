Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90D47BE571
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377607AbjJIPwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377694AbjJIPwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:52:03 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA638CF;
        Mon,  9 Oct 2023 08:51:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C9301C0003;
        Mon,  9 Oct 2023 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJJJLfXCbUFRk44s1J72eD6nlDzDv8eMO6YkqtQzXLI=;
        b=e0dmqWQAAZkkhPCEn/fBD854fwllIFP9gmgN+eMzKRA8oGUPFkDKM/AEKMckjWBrO3C5no
        44Bkz2xKmP/w/p1N0yXZCAFvTGrV8DM5wCwsY5j+z/VshqukKWbAF+z/XlxGLrpkU0gfJB
        YfmntKeLZDWVna2ojX9OQwHQNvAjV9GiSOKznc6DMiJNQhf697KGL8ygJSx2oLdArLiuXm
        HFpBEpRQZEeP88OFtv8gwVYVaRhP6WP7GZnHuTnhA/vWMEOVrVGFtcUdn5SyFxh+qavVJ9
        fc188nrwDy0991GDUexiFOXf7ac4NUjimFmhExdsJwPZFPQ/Bm2NaaBBnGuMFA==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 04/16] net: macb: Convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Mon,  9 Oct 2023 17:51:26 +0200
Message-Id: <20231009155138.86458-5-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

The hardware timestamping through ndo_eth_ioctl() is going away.
Convert the macb driver to the new API before that can be removed.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 15 ++++++---
 drivers/net/ethernet/cadence/macb_main.c | 42 +++++++++++++++++++-----
 drivers/net/ethernet/cadence/macb_ptp.c  | 28 ++++++----------
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

