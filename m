Return-Path: <linux-kernel+bounces-136461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED05A89D444
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB7728113E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E182D7F;
	Tue,  9 Apr 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MEAaE4xw"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1980622;
	Tue,  9 Apr 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651234; cv=none; b=HBKj7CR/SG5TO9OVSWi5bifmGZfMqT+MW7NVJ+4vhdERkbCUDtYhLd6hNZWbNeatApC0K5cE673C9jiznWKyzM5+GNfS6gzEoV7T0sUmngDHRl91QKDUht8FR9Nqq0TpJhE40gZ4Y0nY7fBHrFKNGOFt1nyHUwX5oZJPu08uCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651234; c=relaxed/simple;
	bh=wtVAgX0xEY+zHwpauuBtwhJ06dc7ltmWs4Dbwtv8/Xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVqrdLy9H18oz7eTzugHnwohu3F1utqlwZIdZfJWe90n22LNxjJdDEd8w0QSYJXldbFlhsizSTBq0Kj6Cq3rlvMJXalEESWzPJWKgJx3Ymetjy7kllQkHjc4e3OVFyAcrWk+HqoHsSXRQCecO9hJjWw0hwm1VE9XOZOiP6DJWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MEAaE4xw; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89FD3FF809;
	Tue,  9 Apr 2024 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712651230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26JEEt95vJBs36sVv0o/zKUz9aheCKqymwrQT8wgIFY=;
	b=MEAaE4xwarOGRxS+1CvmUPO1DhBHn5ces2HZ006lO1A4lVdGWpiXWYN3uZc6FrvOnBhnX6
	YJg1O3EBxr4ET3NnhPg52zOOIQot9HhzU44brnJifo0lWhSwNO7PkbxLTFOvky7nkcKuGw
	Y6uNeB86fxwP+qmfj/9jWmGwF9HSh1a+KA8zwhxZgjxmiyq70aJCAI6XvsnFk38CV8961C
	euavzZE5bhpmNzX3mY/eP0v0WIVB+4h/gf1tj/3u5VSHtuo/6ySJaRTAIJPaaRTDHBtQ+c
	Si5dyXchfkeTgO3+01olp22vbIBc8LeSkyZD8sUA1YO+HKGEyCOhA4PRm3JJzA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 10:26:27 +0200
Subject: [PATCH net-next v10 05/13] net: Change the API of PHY default
 timestamp to MAC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_ptp_netnext-v10-5-0fa2ea5c89a9@bootlin.com>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
In-Reply-To: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Change the API to select MAC default time stamping instead of the PHY.
Indeed the PHY is closer to the wire therefore theoretically it has less
delay than the MAC timestamping but the reality is different. Due to lower
time stamping clock frequency, latency in the MDIO bus and no PHC hardware
synchronization between different PHY, the PHY PTP is often less precise
than the MAC. The exception is for PHY designed specially for PTP case but
these devices are not very widespread. For not breaking the compatibility
default_timestamp flag has been introduced in phy_device that is set by
the phy driver to know we are using the old API behavior.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
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

Change in v8:
- Reform the implementation to use a simple phy_is_default_hwtstamp helper
  instead of saving the hwtstamp in the net_device struct.

Change in v9:
- Update few nit following the review.
---
 drivers/net/phy/bcm-phy-ptp.c     |  3 +++
 drivers/net/phy/dp83640.c         |  2 ++
 drivers/net/phy/micrel.c          |  6 ++++++
 drivers/net/phy/mscc/mscc_ptp.c   |  3 +++
 drivers/net/phy/nxp-c45-tja11xx.c |  3 +++
 include/linux/phy.h               | 17 +++++++++++++++++
 net/core/dev_ioctl.c              |  8 +++-----
 net/core/timestamping.c           |  5 +++--
 net/ethtool/common.c              |  2 +-
 9 files changed, 41 insertions(+), 8 deletions(-)

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
index 5c42c47dc564..d3e72d5c1472 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1447,6 +1447,8 @@ static int dp83640_probe(struct phy_device *phydev)
 	for (i = 0; i < MAX_RXTS; i++)
 		list_add(&dp83640->rx_pool_data[i].list, &dp83640->rxpool);
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
 	phydev->mii_ts = &dp83640->mii_ts;
 	phydev->priv = dp83640;
 
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ddb50a0e2bc8..a9baa5e7eff0 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3201,6 +3201,9 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
+
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
 }
 
 static int lan8814_ptp_probe_once(struct phy_device *phydev)
@@ -4668,6 +4671,9 @@ static int lan8841_probe(struct phy_device *phydev)
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
+
 	return 0;
 }
 
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index eb0b032cb613..e66d20eff7c4 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1570,6 +1570,9 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 		return PTR_ERR(vsc8531->load_save);
 	}
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
+
 	vsc8531->ptp->phydev = phydev;
 
 	return 0;
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 3cf614b4cd52..d18c133e6013 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1660,6 +1660,9 @@ static int nxp_c45_probe(struct phy_device *phydev)
 		priv->mii_ts.ts_info = nxp_c45_ts_info;
 		phydev->mii_ts = &priv->mii_ts;
 		ret = nxp_c45_init_ptp_clock(priv);
+
+		/* Timestamp selected by default to keep legacy API */
+		phydev->default_timestamp = true;
 	} else {
 		phydev_dbg(phydev, "PTP support not enabled even if the phy supports it");
 	}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3ddfe7fe781a..d09a340b95e2 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -615,6 +615,8 @@ struct macsec_ops;
  *                 handling shall be postponed until PHY has resumed
  * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
  *             requiring a rerun of the interrupt handler after resume
+ * @default_timestamp: Flag indicating whether we are using the phy
+ *		       timestamp as the default one
  * @interface: enum phy_interface_t value
  * @possible_interfaces: bitmap if interface modes that the attached PHY
  *			 will switch between depending on media speed.
@@ -681,6 +683,8 @@ struct phy_device {
 	unsigned irq_suspended:1;
 	unsigned irq_rerun:1;
 
+	unsigned default_timestamp:1;
+
 	int rate_matching;
 
 	enum phy_state state;
@@ -1625,6 +1629,19 @@ static inline void phy_txtstamp(struct phy_device *phydev, struct sk_buff *skb,
 	phydev->mii_ts->txtstamp(phydev->mii_ts, skb, type);
 }
 
+/**
+ * phy_is_default_hwtstamp - return true if phy is the default hw timestamp
+ * @phydev: Pointer to phy_device
+ *
+ * This is used to get default timestamping device taking into account
+ * the new API choice, which is selecting the timestamping from MAC by
+ * default if the phydev does not have default_timestamp flag enabled.
+ */
+static inline bool phy_is_default_hwtstamp(struct phy_device *phydev)
+{
+	return phy_has_hwtstamp(phydev) && phydev->default_timestamp;
+}
+
 /**
  * phy_is_internal - Convenience function for testing if a PHY is internal
  * @phydev: the phy_device struct
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 6aaa8326bf8f..36cea843381f 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -259,9 +259,7 @@ static int dev_eth_ioctl(struct net_device *dev,
  * @dev: Network device
  * @cfg: Timestamping configuration structure
  *
- * Helper for enforcing a common policy that phylib timestamping, if available,
- * should take precedence in front of hardware timestamping provided by the
- * netdev.
+ * Helper for calling the default hardware provider timestamping.
  *
  * Note: phy_mii_ioctl() only handles SIOCSHWTSTAMP (not SIOCGHWTSTAMP), and
  * there only exists a phydev->mii_ts->hwtstamp() method. So this will return
@@ -271,7 +269,7 @@ static int dev_eth_ioctl(struct net_device *dev,
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg)
 {
-	if (phy_has_hwtstamp(dev->phydev))
+	if (phy_is_default_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);
 
 	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
@@ -327,7 +325,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	bool phy_ts = phy_has_hwtstamp(dev->phydev);
+	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
 	struct kernel_hwtstamp_config old_cfg = {};
 	bool changed = false;
 	int err;
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 04840697fe79..3717fb152ecc 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -25,7 +25,8 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
 	struct sk_buff *clone;
 	unsigned int type;
 
-	if (!skb->sk)
+	if (!skb->sk || !skb->dev ||
+	    !phy_is_default_hwtstamp(skb->dev->phydev))
 		return;
 
 	type = classify(skb);
@@ -47,7 +48,7 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
 	struct mii_timestamper *mii_ts;
 	unsigned int type;
 
-	if (!skb->dev || !skb->dev->phydev || !skb->dev->phydev->mii_ts)
+	if (!skb->dev || !phy_is_default_hwtstamp(skb->dev->phydev))
 		return false;
 
 	if (skb_headroom(skb) < ETH_HLEN)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..01b7550f12c6 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -637,7 +637,7 @@ int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 	memset(info, 0, sizeof(*info));
 	info->cmd = ETHTOOL_GET_TS_INFO;
 
-	if (phy_has_tsinfo(phydev))
+	if (phy_is_default_hwtstamp(phydev) && phy_has_tsinfo(phydev))
 		return phy_ts_info(phydev, info);
 	if (ops->get_ts_info)
 		return ops->get_ts_info(dev, info);

-- 
2.34.1


