Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF377BE594
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377960AbjJIPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377871AbjJIPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:52:46 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A84D5B;
        Mon,  9 Oct 2023 08:52:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1AD31C0008;
        Mon,  9 Oct 2023 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQjM6ChqEsCv4tSv5WLWYJR8cO93SncXZdpKtRJANL0=;
        b=hq9Z5SYqgIU+6U0H+Rc2V7reHCBYxcV+n+KzVYKVJE562HkjyqVAvvPqCnMj1MGWUIhmL7
        /XAmFAEQskJ/EPKpb+z16k5pLcpFCQgJiKp7KH/3r3qOqpydiLGh4t/G3yfqm1MgzXW4rX
        rQ/rXF+A0op8mP2dS9u5/npNjLHAkhnAhEO8zZtzAESPpIIQ0O5IXNanwn3SAC9qcyaKqC
        uLrE1QjGqqo2Isq/QMCoyEtU8/P+b3chDfiQQWBR0qMZ5IzM4HZNzfJ9GkmuMSu4Id3eLL
        ykTAZUOlm4UdpA6VpfdAIuS46SSNBhcEnmfDfbx6q1Nh2VeMgGVHs6WXwbhKVg==
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
Subject: [PATCH net-next v5 13/16] net: Change the API of PHY default timestamp to MAC
Date:   Mon,  9 Oct 2023 17:51:35 +0200
Message-Id: <20231009155138.86458-14-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

Change the API to select MAC default time stamping instead of the PHY.
Indeed the PHY is closer to the wire therefore theoretically it have less
delay than the MAC timestamping but the reality is different. Due to lower
time stamping clock frequency, latency in the MDIO bus and no PHC hardware
synchronization between different PHY, the PHY PTP is often less precise
than the MAC. The exception is for PHY designed specially for PTP case but
these board are not very widespread. For not breaking the compatibility I
introduce an allowlist to reference all current PHYs that support
time stamping and let them keep the old API behavior.

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
---
 drivers/net/phy/phy_device.c | 68 ++++++++++++++++++++++++++++++++++++
 include/linux/netdevice.h    |  5 +++
 net/core/dev.c               |  3 ++
 net/core/dev_ioctl.c         | 36 +++++++++++--------
 net/core/timestamping.c      |  9 +++++
 net/ethtool/common.c         | 16 +++++++--
 6 files changed, 121 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..2d5a6d57acb3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1411,6 +1411,68 @@ int phy_sfp_probe(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_sfp_probe);
 
+/* An allowlist for PHYs selected as default timesetamping.
+ * Its use is to keep compatibility with old PTP API which is selecting
+ * these PHYs as default timestamping.
+ * The new API is selecting the MAC as default timestamping.
+ */
+const char * const phy_timestamping_allowlist[] = {
+	"Broadcom BCM5411",
+	"Broadcom BCM5421",
+	"Broadcom BCM54210E",
+	"Broadcom BCM5461",
+	"Broadcom BCM54612E",
+	"Broadcom BCM5464",
+	"Broadcom BCM5481",
+	"Broadcom BCM54810",
+	"Broadcom BCM54811",
+	"Broadcom BCM5482",
+	"Broadcom BCM50610",
+	"Broadcom BCM50610M",
+	"Broadcom BCM57780",
+	"Broadcom BCM5395",
+	"Broadcom BCM53125",
+	"Broadcom BCM53128",
+	"Broadcom BCM89610",
+	"NatSemi DP83640",
+	"Microchip LAN8841 Gigabit PHY",
+	"Microchip INDY Gigabit Quad PHY",
+	"Microsemi GE VSC856X SyncE",
+	"Microsemi GE VSC8575 SyncE",
+	"Microsemi GE VSC8582 SyncE",
+	"Microsemi GE VSC8584 SyncE",
+	"NXP C45 TJA1103",
+	NULL,
+};
+
+/**
+ * phy_set_timestamp - set the default selected timestamping device
+ * @dev: Pointer to net_device
+ * @phydev: Pointer to phy_device
+ *
+ * This is used to set default timestamping device taking into account
+ * the new API choice, which is selecting the timestamping from MAC by
+ * default.
+ */
+static void phy_set_timestamp(struct net_device *dev, struct phy_device *phydev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	int i;
+
+	/* Backward compatibility to old timestamping API */
+	for (i = 0; phy_timestamping_allowlist[i]; i++) {
+		if (!strcmp(phy_timestamping_allowlist[i],
+			    phydev->drv->name)) {
+			if (phy_has_tsinfo(phydev))
+				dev->ts_layer = PHYLIB_TIMESTAMPING;
+			return;
+		}
+	}
+
+	if (phy_has_tsinfo(phydev) && !ops->get_ts_info)
+		dev->ts_layer = PHYLIB_TIMESTAMPING;
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device pointer
  * @dev: network device to attach
@@ -1484,6 +1546,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	phydev->phy_link_change = phy_link_change;
 	if (dev) {
+		phy_set_timestamp(dev, phydev);
 		phydev->attached_dev = dev;
 		dev->phydev = phydev;
 
@@ -1794,6 +1857,7 @@ EXPORT_SYMBOL_GPL(devm_phy_package_join);
 void phy_detach(struct phy_device *phydev)
 {
 	struct net_device *dev = phydev->attached_dev;
+	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct module *ndev_owner = NULL;
 	struct mii_bus *bus;
 
@@ -1812,6 +1876,10 @@ void phy_detach(struct phy_device *phydev)
 
 	phy_suspend(phydev);
 	if (dev) {
+		if (ops->get_ts_info)
+			dev->ts_layer = NETDEV_TIMESTAMPING;
+		else
+			dev->ts_layer = NO_TIMESTAMPING;
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 	}
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b9d0411836db..4e1d01120511 100644
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
@@ -2054,6 +2055,8 @@ enum netdev_ml_priv_type {
  *
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
+ *	@ts_layer:	Tracks which network device
+ *			performs packet	time stamping.
  *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
@@ -2415,6 +2418,8 @@ struct net_device {
 #if IS_ENABLED(CONFIG_DPLL)
 	struct dpll_pin		*dpll_pin;
 #endif
+
+	u32			ts_layer;
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 606a366cc209..1d4890dee114 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10204,6 +10204,9 @@ int register_netdevice(struct net_device *dev)
 	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
 		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
 
+	if (dev->ethtool_ops->get_ts_info)
+		dev->ts_layer = NETDEV_TIMESTAMPING;
+
 out:
 	return ret;
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 45cc1ea9b195..20009462fa24 100644
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
+	u32 ts_layer = dev->ts_layer;
+
+	if (ts_layer & PHYLIB_TIMESTAMPING)
 		return phy_hwtstamp_get(dev->phydev, cfg);
+	else if (ts_layer & NETDEV_TIMESTAMPING)
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
 	struct kernel_hwtstamp_config old_cfg = {};
+	u32 ts_layer = dev->ts_layer;
 	bool changed = false;
 	int err;
 
-	cfg->source = phy_ts ? PHYLIB_TIMESTAMPING : NETDEV_TIMESTAMPING;
+	cfg->source = ts_layer;
+
+	if (!(ts_layer & PHYLIB_TIMESTAMPING) &&
+	    !(ts_layer & NETDEV_TIMESTAMPING))
+		return -EOPNOTSUPP;
 
-	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
+	if ((ts_layer & PHYLIB_TIMESTAMPING) &&
+	    (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
 		err = ops->ndo_hwtstamp_get(dev, &old_cfg);
 		if (err)
 			return err;
 	}
 
-	if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
+	if ((ts_layer & NETDEV_TIMESTAMPING) ||
+	    (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
 		err = ops->ndo_hwtstamp_set(dev, cfg, extack);
 		if (err) {
 			if (extack->_msg)
@@ -349,10 +356,11 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 		}
 	}
 
-	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS))
+	if ((ts_layer & PHYLIB_TIMESTAMPING) &&
+	    (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS))
 		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
 
-	if (phy_ts) {
+	if (ts_layer & PHYLIB_TIMESTAMPING) {
 		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
 		if (err) {
 			if (changed)
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 04840697fe79..4638b2fb0dbc 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -21,6 +21,7 @@ static unsigned int classify(const struct sk_buff *skb)
 
 void skb_clone_tx_timestamp(struct sk_buff *skb)
 {
+	u32 ts_layer = skb->dev->ts_layer;
 	struct mii_timestamper *mii_ts;
 	struct sk_buff *clone;
 	unsigned int type;
@@ -28,6 +29,9 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
 	if (!skb->sk)
 		return;
 
+	if (!(ts_layer & PHYLIB_TIMESTAMPING))
+		return;
+
 	type = classify(skb);
 	if (type == PTP_CLASS_NONE)
 		return;
@@ -46,10 +50,15 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
 {
 	struct mii_timestamper *mii_ts;
 	unsigned int type;
+	u32 ts_layer;
 
 	if (!skb->dev || !skb->dev->phydev || !skb->dev->phydev->mii_ts)
 		return false;
 
+	ts_layer = skb->dev->ts_layer;
+	if (!(ts_layer & PHYLIB_TIMESTAMPING))
+		return false;
+
 	if (skb_headroom(skb) < ETH_HLEN)
 		return false;
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index e2315e24d695..54a2acc20af0 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -633,13 +633,25 @@ int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
+	u32 ts_layer = dev->ts_layer;
+	int ret;
 
 	memset(info, 0, sizeof(*info));
 	info->cmd = ETHTOOL_GET_TS_INFO;
 
-	if (phy_has_tsinfo(phydev))
+	if (ts_layer == SOFTWARE_TIMESTAMPING) {
+		ret = ops->get_ts_info(dev, info);
+		if (ret)
+			return ret;
+		info->so_timestamping &= ~SOF_TIMESTAMPING_HARDWARE_MASK;
+		info->phc_index = -1;
+		return ret;
+	}
+
+	if (ts_layer & PHYLIB_TIMESTAMPING)
 		return phy_ts_info(phydev, info);
-	if (ops->get_ts_info)
+
+	if (ts_layer & NETDEV_TIMESTAMPING)
 		return ops->get_ts_info(dev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-- 
2.25.1

