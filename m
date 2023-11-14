Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05957EAF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjKNLar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjKNL3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:50 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAED173F;
        Tue, 14 Nov 2023 03:29:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 838A060007;
        Tue, 14 Nov 2023 11:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699961346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ArWNLKEdYrTo7BZ7jCAhkaMSzcihjku1tRZqZigac9M=;
        b=Z+7ZSDrvDgk9eOdIMuyJsnARQvTfBCatJY1Y+c/a6DbatNU5ZXHZZNqJcm9fOeNMt2bZNo
        WTWav6ORXadlpBjOo/ov1HFyfMJM8iBhXV3KF/2gsiRnYOtuS0Cf3CP6yYjQ02U0xXENO8
        ZqY2gycUDpMa+U7mfNsW18vGFX1XWgZzq8koquOOSyK5RZBjfyWWjYwvTNJsaD1AoS5YKh
        /f6OGBv/aUV4vrOJ0JcuNwJ/4cDmr+y50ZXoKCnRpp0PJLvsLKKIsYGOIX0cKk9DZHhz1d
        h2XeVOX5+/KPPVUJFuX7dH+FdE4bAbUzarql6fA5kKjGHfMbgjcIqDcuzb+law==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 12:28:41 +0100
Subject: [PATCH net-next v7 13/16] net: Change the API of PHY default
 timestamp to MAC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-13-472e77951e40@bootlin.com>
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

Change the API to select MAC default time stamping instead of the PHY.
Indeed the PHY is closer to the wire therefore theoretically it has less
delay than the MAC timestamping but the reality is different. Due to lower
time stamping clock frequency, latency in the MDIO bus and no PHC hardware
synchronization between different PHY, the PHY PTP is often less precise
than the MAC. The exception is for PHY designed specially for PTP case but
these devices are not very widespread. For not breaking the compatibility I
introduce a default_timestamp flag in phy_device that is set by the phy
driver to know we are using the old API behavior.

The phy_set_timestamp function is called at each call of phy_attach_direct.
In case of MAC driver using phylink this function is called when the
interface is turned up. Then if the interface goes down and up again the
last choice of timestamp will be overwritten by the default choice.
A solution could be to cache the timestamp status but it can bring other
issues. In case of SFP, if we change the module, it doesn't make sense to
blindly re-set the timestamp back to PHY, if the new module has a PHY with
mediocre timestamping capabilities.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v5:
- Extract the API change in this patch.
- Rename whitelist to allowlist.
- Set NETDEV_TIMESTAMPING in register_netdevice function.
- Add software timestamping case description in ts_info.

Change in v6:
- Replace the allowlist phy with a default_timestamp flag to know which
  phy is using old API behavior.
- Fix dereferenced of a possible null pointer.
- Follow timestamping layer naming update.
- Update timestamp default set between MAC and software.
- Update ts_info returned in case of software timestamping.
---
 drivers/net/phy/bcm-phy-ptp.c     |  3 +++
 drivers/net/phy/dp83640.c         |  3 +++
 drivers/net/phy/micrel.c          |  6 ++++++
 drivers/net/phy/mscc/mscc_ptp.c   |  2 ++
 drivers/net/phy/nxp-c45-tja11xx.c |  3 +++
 drivers/net/phy/phy_device.c      | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/netdevice.h         |  5 +++++
 include/linux/phy.h               |  4 ++++
 net/core/dev.c                    |  3 +++
 net/core/dev_ioctl.c              | 36 ++++++++++++++++++++++--------------
 net/core/timestamping.c           | 10 ++++++++++
 net/ethtool/common.c              | 19 +++++++++++++++++--
 12 files changed, 115 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index 617d384d4551..d3e825c951ee 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -931,6 +931,9 @@ struct bcm_ptp_private *bcm_ptp_probe(struct phy_device *phydev)
 		return ERR_CAST(clock);
 	priv->ptp_clock = clock;
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
+
 	priv->phydev = phydev;
 	bcm_ptp_init(priv);
 
diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 5c42c47dc564..64fd1a109c0f 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1450,6 +1450,9 @@ static int dp83640_probe(struct phy_device *phydev)
 	phydev->mii_ts = &dp83640->mii_ts;
 	phydev->priv = dp83640;
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
+
 	spin_lock_init(&dp83640->rx_lock);
 	skb_queue_head_init(&dp83640->rx_queue);
 	skb_queue_head_init(&dp83640->tx_queue);
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index bd4cd082662f..2b8dd0131926 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3158,6 +3158,9 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
+
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
 }
 
 static int lan8814_ptp_probe_once(struct phy_device *phydev)
@@ -4586,6 +4589,9 @@ static int lan8841_probe(struct phy_device *phydev)
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
+
 	return 0;
 }
 
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index eb0b032cb613..fd174eb06d4a 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1570,6 +1570,8 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 		return PTR_ERR(vsc8531->load_save);
 	}
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
 	vsc8531->ptp->phydev = phydev;
 
 	return 0;
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 780ad353cf55..0515c7b979db 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1658,6 +1658,9 @@ static int nxp_c45_probe(struct phy_device *phydev)
 		priv->mii_ts.ts_info = nxp_c45_ts_info;
 		phydev->mii_ts = &priv->mii_ts;
 		ret = nxp_c45_init_ptp_clock(priv);
+
+		/* Timestamp selected by default to keep legacy API */
+		phydev->default_timestamp = true;
 	} else {
 		phydev_dbg(phydev, "PTP support not enabled even if the phy supports it");
 	}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..8c4794631daa 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1411,6 +1411,26 @@ int phy_sfp_probe(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_sfp_probe);
 
+/**
+ * phy_set_timestamp - set the default selected timestamping device
+ * @dev: Pointer to net_device
+ * @phydev: Pointer to phy_device
+ *
+ * This is used to set default timestamping device taking into account
+ * the new API choice, which is selecting the timestamping from MAC by
+ * default if the phydev does not have default_timestamp flag enabled.
+ */
+static void phy_set_timestamp(struct net_device *dev, struct phy_device *phydev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	if (!phy_has_tsinfo(phydev))
+		return;
+
+	if (!ops->get_ts_info || phydev->default_timestamp)
+		dev->ts_layer = PHY_TIMESTAMPING;
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device pointer
  * @dev: network device to attach
@@ -1484,6 +1504,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	phydev->phy_link_change = phy_link_change;
 	if (dev) {
+		phy_set_timestamp(dev, phydev);
 		phydev->attached_dev = dev;
 		dev->phydev = phydev;
 
@@ -1812,6 +1833,22 @@ void phy_detach(struct phy_device *phydev)
 
 	phy_suspend(phydev);
 	if (dev) {
+		const struct ethtool_ops *ops = dev->ethtool_ops;
+		struct ethtool_ts_info ts_info = {0};
+
+		if (ops->get_ts_info) {
+			ops->get_ts_info(dev, &ts_info);
+			if ((ts_info.so_timestamping &
+			    SOF_TIMESTAMPING_HARDWARE_MASK) ==
+			    SOF_TIMESTAMPING_HARDWARE_MASK)
+				dev->ts_layer = MAC_TIMESTAMPING;
+			else if ((ts_info.so_timestamping &
+				 SOF_TIMESTAMPING_SOFTWARE_MASK) ==
+				 SOF_TIMESTAMPING_SOFTWARE_MASK)
+				dev->ts_layer = SOFTWARE_TIMESTAMPING;
+		} else {
+			dev->ts_layer = NO_TIMESTAMPING;
+		}
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 	}
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2d840d7056f2..f020d2790c12 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -47,6 +47,7 @@
 #include <uapi/linux/if_bonding.h>
 #include <uapi/linux/pkt_cls.h>
 #include <uapi/linux/netdev.h>
+#include <uapi/linux/net_tstamp.h>
 #include <linux/hashtable.h>
 #include <linux/rbtree.h>
 #include <net/net_trackers.h>
@@ -2074,6 +2075,8 @@ enum netdev_ml_priv_type {
  *
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
+ *	@ts_layer:	Tracks which network device
+ *			performs packet	time stamping.
  *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
@@ -2435,6 +2438,8 @@ struct net_device {
 #if IS_ENABLED(CONFIG_DPLL)
 	struct dpll_pin		*dpll_pin;
 #endif
+
+	enum timestamping_layer	ts_layer;
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e5f1f41e399c..317def2a7843 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -604,6 +604,8 @@ struct macsec_ops;
  *                 handling shall be postponed until PHY has resumed
  * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
  *             requiring a rerun of the interrupt handler after resume
+ * @default_timestamp: Flag indicating whether we are using the phy
+ *		       timestamp as the default one
  * @interface: enum phy_interface_t value
  * @skb: Netlink message for cable diagnostics
  * @nest: Netlink nest used for cable diagnostics
@@ -667,6 +669,8 @@ struct phy_device {
 	unsigned irq_suspended:1;
 	unsigned irq_rerun:1;
 
+	unsigned default_timestamp:1;
+
 	int rate_matching;
 
 	enum phy_state state;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..784d65c059d0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10210,6 +10210,9 @@ int register_netdevice(struct net_device *dev)
 	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
 		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
 
+	if (dev->ethtool_ops->get_ts_info)
+		dev->ts_layer = MAC_TIMESTAMPING;
+
 out:
 	return ret;
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 267cd00269d0..bc8be9749376 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -259,9 +259,7 @@ static int dev_eth_ioctl(struct net_device *dev,
  * @dev: Network device
  * @cfg: Timestamping configuration structure
  *
- * Helper for enforcing a common policy that phylib timestamping, if available,
- * should take precedence in front of hardware timestamping provided by the
- * netdev.
+ * Helper for calling the selected hardware provider timestamping.
  *
  * Note: phy_mii_ioctl() only handles SIOCSHWTSTAMP (not SIOCGHWTSTAMP), and
  * there only exists a phydev->mii_ts->hwtstamp() method. So this will return
@@ -271,10 +269,14 @@ static int dev_eth_ioctl(struct net_device *dev,
 static int dev_get_hwtstamp_phylib(struct net_device *dev,
 				   struct kernel_hwtstamp_config *cfg)
 {
-	if (phy_has_hwtstamp(dev->phydev))
+	enum timestamping_layer ts_layer = dev->ts_layer;
+
+	if (ts_layer == PHY_TIMESTAMPING)
 		return phy_hwtstamp_get(dev->phydev, cfg);
+	else if (ts_layer == MAC_TIMESTAMPING)
+		return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
 
-	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
+	return -EOPNOTSUPP;
 }
 
 static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
@@ -315,9 +317,8 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
  * @cfg: Timestamping configuration structure
  * @extack: Netlink extended ack message structure, for error reporting
  *
- * Helper for enforcing a common policy that phylib timestamping, if available,
- * should take precedence in front of hardware timestamping provided by the
- * netdev. If the netdev driver needs to perform specific actions even for PHY
+ * Helper for calling the selected hardware provider timestamping.
+ * If the netdev driver needs to perform specific actions even for PHY
  * timestamping to work properly (a switch port must trap the timestamped
  * frames and not forward them), it must set IFF_SEE_ALL_HWTSTAMP_REQUESTS in
  * dev->priv_flags.
@@ -327,20 +328,26 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	bool phy_ts = phy_has_hwtstamp(dev->phydev);
+	enum timestamping_layer ts_layer = dev->ts_layer;
 	struct kernel_hwtstamp_config old_cfg = {};
 	bool changed = false;
 	int err;
 
-	cfg->source = phy_ts ? PHY_TIMESTAMPING : MAC_TIMESTAMPING;
+	cfg->source = ts_layer;
+
+	if (ts_layer != PHY_TIMESTAMPING &&
+	    ts_layer != MAC_TIMESTAMPING)
+		return -EOPNOTSUPP;
 
-	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
+	if (ts_layer == PHY_TIMESTAMPING &&
+	    dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS) {
 		err = ops->ndo_hwtstamp_get(dev, &old_cfg);
 		if (err)
 			return err;
 	}
 
-	if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
+	if (ts_layer == MAC_TIMESTAMPING ||
+	    dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS) {
 		err = ops->ndo_hwtstamp_set(dev, cfg, extack);
 		if (err) {
 			if (extack->_msg)
@@ -349,10 +356,11 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 		}
 	}
 
-	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS))
+	if (ts_layer == PHY_TIMESTAMPING &&
+	    dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)
 		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
 
-	if (phy_ts) {
+	if (ts_layer == PHY_TIMESTAMPING) {
 		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
 		if (err) {
 			if (changed)
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 04840697fe79..5cf51a523fb3 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -21,6 +21,7 @@ static unsigned int classify(const struct sk_buff *skb)
 
 void skb_clone_tx_timestamp(struct sk_buff *skb)
 {
+	enum timestamping_layer ts_layer;
 	struct mii_timestamper *mii_ts;
 	struct sk_buff *clone;
 	unsigned int type;
@@ -28,6 +29,10 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
 	if (!skb->sk)
 		return;
 
+	ts_layer = skb->dev->ts_layer;
+	if (ts_layer != PHY_TIMESTAMPING)
+		return;
+
 	type = classify(skb);
 	if (type == PTP_CLASS_NONE)
 		return;
@@ -44,12 +49,17 @@ EXPORT_SYMBOL_GPL(skb_clone_tx_timestamp);
 
 bool skb_defer_rx_timestamp(struct sk_buff *skb)
 {
+	enum timestamping_layer ts_layer;
 	struct mii_timestamper *mii_ts;
 	unsigned int type;
 
 	if (!skb->dev || !skb->dev->phydev || !skb->dev->phydev->mii_ts)
 		return false;
 
+	ts_layer = skb->dev->ts_layer;
+	if (ts_layer != PHY_TIMESTAMPING)
+		return false;
+
 	if (skb_headroom(skb) < ETH_HLEN)
 		return false;
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 11d8797f63f6..9f6e3b2c74e2 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -633,13 +633,28 @@ int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
+	enum timestamping_layer ts_layer;
+	int ret;
 
 	memset(info, 0, sizeof(*info));
 	info->cmd = ETHTOOL_GET_TS_INFO;
 
-	if (phy_has_tsinfo(phydev))
+	ts_layer = dev->ts_layer;
+	if (ts_layer == SOFTWARE_TIMESTAMPING) {
+		ret = ops->get_ts_info(dev, info);
+		if (ret)
+			return ret;
+		info->so_timestamping &= ~SOF_TIMESTAMPING_HARDWARE_MASK;
+		info->phc_index = -1;
+		info->rx_filters = 0;
+		info->tx_types = 0;
+		return 0;
+	}
+
+	if (ts_layer == PHY_TIMESTAMPING)
 		return phy_ts_info(phydev, info);
-	if (ops->get_ts_info)
+
+	if (ts_layer == MAC_TIMESTAMPING)
 		return ops->get_ts_info(dev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |

-- 
2.25.1

