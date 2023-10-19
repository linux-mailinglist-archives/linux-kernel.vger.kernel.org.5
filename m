Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF07CFC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbjJSO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346107AbjJSO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:29:48 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6221F12A;
        Thu, 19 Oct 2023 07:29:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8FEB60012;
        Thu, 19 Oct 2023 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697725784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNrKy8uw5SHl33VoHbsSV7X+NyIhoa5MW6cneL8IdTE=;
        b=jUwABvawl63KScnssbujvwJ8Kf7B7ctUdyuldxNvTAQmtPFor8mxs0xhLYDpkkc/XKMxkp
        EJkWmjmCYxZRZhH2cJ4Pjd8m1Xj95JIrHMtsltLoIjDiQdzcEVpmp1po3CN4ICqDHy8Ao5
        EmTrkXBVkggYgMFqgVN4Agkl3Uvq9qCVlXKN+o1Nv6oZRovZzvqnWOjfD/jsnb4B+LksZ2
        Y4Afhj6ro0e2Sr9kDLwjMiPTDtINrRfiL39cPt+wEO0gnPNXzM6dMo/GTO+aKYnbq0sO8b
        dF4yN/w8EIjLkE3Nnlb0s657f07f05i5TL60q4jPi5RC1n3SK0mfE7kIm9vk7g==
From:   =?utf-8?q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>
Date:   Thu, 19 Oct 2023 16:29:18 +0200
Subject: [PATCH net-next v6 03/16] net: ethtool: Refactor identical
 get_ts_info implementations.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231019-feature_ptp_netnext-v6-3-71affc27b0e5@bootlin.com>
References: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
In-Reply-To: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
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
        Kory Maincent <kory.maincent@bootlin.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Jay Vosburgh <jay.vosburgh@canonical.com>
---

Change in v5:
- Fixe typo.

Change in v6:
- Removed unused variable spotted by kernel test robot.
---
 drivers/net/bonding/bond_main.c | 29 ++---------------------------
 drivers/net/macvlan.c           | 14 +-------------
 include/linux/ethtool.h         |  8 ++++++++
 net/8021q/vlan_dev.c            | 15 +--------------
 net/ethtool/common.c            |  6 ++++++
 5 files changed, 18 insertions(+), 54 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ed7212e61c54..fe25fa59fd08 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5749,10 +5749,8 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
 {
 	struct bonding *bond = netdev_priv(bond_dev);
 	struct ethtool_ts_info ts_info;
-	const struct ethtool_ops *ops;
 	struct net_device *real_dev;
 	bool sw_tx_support = false;
-	struct phy_device *phydev;
 	struct list_head *iter;
 	struct slave *slave;
 	int ret = 0;
@@ -5763,29 +5761,12 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
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
@@ -5797,15 +5778,9 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
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

