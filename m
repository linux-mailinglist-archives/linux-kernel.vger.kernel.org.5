Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB007BE56E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377708AbjJIPwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377075AbjJIPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:51:59 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298EE0;
        Mon,  9 Oct 2023 08:51:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B157C1C0015;
        Mon,  9 Oct 2023 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCGdAto1+QXVw1w1qLCsJMnj81jolLUsBwWTGbRy+0Y=;
        b=momwC1vzc2IU8ca67lLfPkk/qA++etY65cxvjh3z3R/UngLPjgKgKSkYIZ1brHy7Y8XDp+
        dEHVGEAh/llfcpGbTx+VdnYfXwnv45AY20bAKciaCxUqoJ+OZMuL9/i5bV9Cl4My42QDm3
        Rm45KIHuB+sQ+pelfIgcKT37ErI9ERYo4FdsFhbhtffgQTiJNb1+YN3twFcsv5bhYJ5DH5
        oncTiKDNer+TTVsSYsaiCsQ074hCKSuvcY4/+Mp4o+92uFjH0RXMiKj6uiNRxg4Szg+SnL
        NMyHd6+vObOzuU9FUvmzJRSyXBkcAegX1v6WZbN8GCyQR1aSmhVf9RffmOMfJA==
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
Subject: [PATCH net-next v5 03/16] net: ethtool: Refactor identical get_ts_info implementations.
Date:   Mon,  9 Oct 2023 17:51:25 +0200
Message-Id: <20231009155138.86458-4-kory.maincent@bootlin.com>
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

From: Richard Cochran <richardcochran@gmail.com>

The vlan, macvlan and the bonding drivers call their "real" device driver
in order to report the time stamping capabilities.  Provide a core
ethtool helper function to avoid copy/paste in the stack.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v5:
- Fixe typo
---
 drivers/net/bonding/bond_main.c | 27 ++-------------------------
 drivers/net/macvlan.c           | 14 +-------------
 include/linux/ethtool.h         |  8 ++++++++
 net/8021q/vlan_dev.c            | 15 +--------------
 net/ethtool/common.c            |  6 ++++++
 5 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ed7212e61c54..18af563d20b2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5763,29 +5763,12 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
 	rcu_read_unlock();
 
 	if (real_dev) {
-		ops = real_dev->ethtool_ops;
-		phydev = real_dev->phydev;
-
-		if (phy_has_tsinfo(phydev)) {
-			ret = phy_ts_info(phydev, info);
-			goto out;
-		} else if (ops->get_ts_info) {
-			ret = ops->get_ts_info(real_dev, info);
-			goto out;
-		}
+		ret = ethtool_get_ts_info_by_layer(real_dev, info);
 	} else {
 		/* Check if all slaves support software tx timestamping */
 		rcu_read_lock();
 		bond_for_each_slave_rcu(bond, slave, iter) {
-			ret = -1;
-			ops = slave->dev->ethtool_ops;
-			phydev = slave->dev->phydev;
-
-			if (phy_has_tsinfo(phydev))
-				ret = phy_ts_info(phydev, &ts_info);
-			else if (ops->get_ts_info)
-				ret = ops->get_ts_info(slave->dev, &ts_info);
-
+			ret = ethtool_get_ts_info_by_layer(slave->dev, &ts_info);
 			if (!ret && (ts_info.so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE)) {
 				sw_tx_support = true;
 				continue;
@@ -5797,15 +5780,9 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
 		rcu_read_unlock();
 	}
 
-	ret = 0;
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
 	if (sw_tx_support)
 		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
 
-	info->phc_index = -1;
-
-out:
 	dev_put(real_dev);
 	return ret;
 }
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 02bd201bc7e5..759406fbaea8 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1086,20 +1086,8 @@ static int macvlan_ethtool_get_ts_info(struct net_device *dev,
 				       struct ethtool_ts_info *info)
 {
 	struct net_device *real_dev = macvlan_dev_real_dev(dev);
-	const struct ethtool_ops *ops = real_dev->ethtool_ops;
-	struct phy_device *phydev = real_dev->phydev;
 
-	if (phy_has_tsinfo(phydev)) {
-		return phy_ts_info(phydev, info);
-	} else if (ops->get_ts_info) {
-		return ops->get_ts_info(real_dev, info);
-	} else {
-		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE;
-		info->phc_index = -1;
-	}
-
-	return 0;
+	return ethtool_get_ts_info_by_layer(real_dev, info);
 }
 
 static netdev_features_t macvlan_fix_features(struct net_device *dev,
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..1159daac776e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1043,6 +1043,14 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
 	return -EINVAL;
 }
 
+/**
+ * ethtool_get_ts_info_by_layer - Obtains time stamping capabilities from the MAC or PHY layer.
+ * @dev: pointer to net_device structure
+ * @info: buffer to hold the result
+ * Returns zero on success, non-zero otherwise.
+ */
+int ethtool_get_ts_info_by_layer(struct net_device *dev, struct ethtool_ts_info *info);
+
 /**
  * ethtool_sprintf - Write formatted string to ethtool string data
  * @data: Pointer to start of string to update
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 2a7f1b15714a..407b2335f091 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -702,20 +702,7 @@ static int vlan_ethtool_get_ts_info(struct net_device *dev,
 				    struct ethtool_ts_info *info)
 {
 	const struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	const struct ethtool_ops *ops = vlan->real_dev->ethtool_ops;
-	struct phy_device *phydev = vlan->real_dev->phydev;
-
-	if (phy_has_tsinfo(phydev)) {
-		return phy_ts_info(phydev, info);
-	} else if (ops->get_ts_info) {
-		return ops->get_ts_info(vlan->real_dev, info);
-	} else {
-		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE;
-		info->phc_index = -1;
-	}
-
-	return 0;
+	return ethtool_get_ts_info_by_layer(vlan->real_dev, info);
 }
 
 static void vlan_dev_get_stats64(struct net_device *dev,
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index f5598c5f50de..e2315e24d695 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -661,6 +661,12 @@ int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index)
 }
 EXPORT_SYMBOL(ethtool_get_phc_vclocks);
 
+int ethtool_get_ts_info_by_layer(struct net_device *dev, struct ethtool_ts_info *info)
+{
+	return __ethtool_get_ts_info(dev, info);
+}
+EXPORT_SYMBOL(ethtool_get_ts_info_by_layer);
+
 const struct ethtool_phy_ops *ethtool_phy_ops;
 
 void ethtool_set_ethtool_phy_ops(const struct ethtool_phy_ops *ops)
-- 
2.25.1

