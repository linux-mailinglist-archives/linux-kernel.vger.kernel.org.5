Return-Path: <linux-kernel+bounces-68917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE48581E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681631C222BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2EB1339BE;
	Fri, 16 Feb 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GCBgVuzI"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C01130E2A;
	Fri, 16 Feb 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098791; cv=none; b=TRTwuQoXDwPLT2N7pGbO53cjELWr/38X8Ju+AF8aH+QEVFq0sXuM0AKSNFkDC/z4eYC2cF7zWQlrrcZ9jG2X2Ao6uSRDTyG7V2BIhYmzigdkUBIIgXVBOgJBZFljVVlSnL+bsUtoQqYkMiImDuag9VnFXToIr1kpdOp7adaXmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098791; c=relaxed/simple;
	bh=p4k+G+UENZZwT9m+vicBPi70Di2KtSUeEUKGPeu0mKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuAH5dVBUYH7ChNYA6urZuyBUDfjnSAgyLFzhT2b/x1YqrzubiSit/pDMHVGAxK6DVTQPI5h1Hqv5kY8oHY8Mp3VRH0Wa767wpogH364qpLj44mBk+v9lSJ9g2dRu0IBHZhepojq85LZwJ9EdEUABCjHtiGyZUUi7IiuKr4zyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GCBgVuzI; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE44624000F;
	Fri, 16 Feb 2024 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708098780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AViVClO7/kjsbmrmHVM/OSAbZ50VLtEyyTI8eLncFM=;
	b=GCBgVuzIj+sNLhknxPxoFGSPMGlQYz/pIyJgN6rAduJeYVa6YY006Rr2FcXkbkEfKUzD7C
	+35vdTIO6tPHpkw3ydOUUXFgytK8w8mZIcMEXJUTnAdVYJdq2x55eEwcHom1HVJXHXRxTD
	wZCm0Fe9NljXzL9eDXREhwTJwna8zodEsZDT159AsotGd2HPu2owoFS7pBrPGbL4R4xFdI
	e0T9nrw97OxAS2aDj230qwyW1iseddWQ3mrezEPYkCNU/yPR4s8Zz8o/2COU1tLJ3l3QwQ
	cMQgSfvFmZH1CfJKWmj/+ijx/JwamQOarz9fQj5sVUkJqYbzsemqi4uGJM8yxA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 16 Feb 2024 16:52:22 +0100
Subject: [PATCH RFC net-next v8 04/13] net: Change the API of PHY default
 timestamp to MAC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
In-Reply-To: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
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
X-Mailer: b4 0.12.4
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
---
 drivers/net/phy/bcm-phy-ptp.c     |  3 +++
 drivers/net/phy/dp83640.c         |  3 +++
 drivers/net/phy/micrel.c          |  6 ++++++
 drivers/net/phy/mscc/mscc_ptp.c   |  3 +++
 drivers/net/phy/nxp-c45-tja11xx.c |  3 +++
 include/linux/phy.h               | 17 +++++++++++++++++
 net/core/dev_ioctl.c              |  8 +++-----
 net/core/timestamping.c           | 10 ++++++++--
 net/ethtool/common.c              |  2 +-
 9 files changed, 47 insertions(+), 8 deletions(-)

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
index 9b6973581989..1c9eba331b01 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3177,6 +3177,9 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
+
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
 }
 
 static int lan8814_ptp_probe_once(struct phy_device *phydev)
@@ -4613,6 +4616,9 @@ static int lan8841_probe(struct phy_device *phydev)
 
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
index c2dda21b39e1..9a31243e9f7e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -607,6 +607,8 @@ struct macsec_ops;
  *                 handling shall be postponed until PHY has resumed
  * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
  *             requiring a rerun of the interrupt handler after resume
+ * @default_timestamp: Flag indicating whether we are using the phy
+ *		       timestamp as the default one
  * @interface: enum phy_interface_t value
  * @possible_interfaces: bitmap if interface modes that the attached PHY
  *			 will switch between depending on media speed.
@@ -672,6 +674,8 @@ struct phy_device {
 	unsigned irq_suspended:1;
 	unsigned irq_rerun:1;
 
+	unsigned default_timestamp:1;
+
 	int rate_matching;
 
 	enum phy_state state;
@@ -1613,6 +1617,19 @@ static inline void phy_txtstamp(struct phy_device *phydev, struct sk_buff *skb,
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
index 847254fd7f13..3342834597cd 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -260,9 +260,7 @@ static int dev_eth_ioctl(struct net_device *dev,
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
@@ -272,7 +270,7 @@ static int dev_eth_ioctl(struct net_device *dev,
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg)
 {
-	if (phy_has_hwtstamp(dev->phydev))
+	if (phy_is_default_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);
 
 	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
@@ -329,7 +327,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	bool phy_ts = phy_has_hwtstamp(dev->phydev);
+	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
 	struct kernel_hwtstamp_config old_cfg = {};
 	bool changed = false;
 	int err;
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 04840697fe79..891bfc2f62fd 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -25,7 +25,10 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
 	struct sk_buff *clone;
 	unsigned int type;
 
-	if (!skb->sk)
+	if (!skb->sk || !skb->dev)
+		return;
+
+	if (!phy_is_default_hwtstamp(skb->dev->phydev))
 		return;
 
 	type = classify(skb);
@@ -47,7 +50,10 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
 	struct mii_timestamper *mii_ts;
 	unsigned int type;
 
-	if (!skb->dev || !skb->dev->phydev || !skb->dev->phydev->mii_ts)
+	if (!skb->dev)
+		return false;
+
+	if (!phy_is_default_hwtstamp(skb->dev->phydev))
 		return false;
 
 	if (skb_headroom(skb) < ETH_HLEN)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index ce486cec346c..e56bde53cd5c 100644
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
2.25.1


