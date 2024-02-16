Return-Path: <linux-kernel+bounces-68918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0158581E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636371C22330
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA8134758;
	Fri, 16 Feb 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YakwOkrI"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBAC12FB30;
	Fri, 16 Feb 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098791; cv=none; b=Q3tikFfBLQq0dyhbV/N7KUvpAlLc49lK4xWvN4sWVUhnhGIYdk7Reg6XqgwW65g5SlLQDKKhcTmFvoOY38SiCbFCmWGJxyr55rNeJL/giprGhQ2+e+DsGP47+VscrmlgsFqYyczDg/VQWiuSE2gJTEG7Xrgl+PPxiwdrbbhDbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098791; c=relaxed/simple;
	bh=Tsa4CinWUq3CtDVLwHjXUbLJIU0rUb5ePo7QXrfU5Gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSKLrA4WHz9qZwlsPePcm60iPI/t6BEcntJfaHJZ/Nufud1xH86Sg11KSl5fYsK89yoBbkloPLqFLnQrb/ng/xY3PthfqBt8TA3U5cQ0ajsO8Cakk1SqoIveVLyMj6V+RS+GvSUDEnTPIZ0Fo8KFcgoAXLXcwyx5YB/S1ql+gEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YakwOkrI; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9CD5240002;
	Fri, 16 Feb 2024 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708098787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIpKUEyKs7KPREcpGNCdAV6Tq8+1y4QvteCYCmdakZA=;
	b=YakwOkrIt+TJjhO64S6Mttgxlkrx2V9kh8LEm3Tx+xt7Ri+Kr1oFC5awMmwPNt/R0M7Gv+
	WoIIIGcq6fIYSIWup+fko/OrryKeMuhgskmEIBsB8m8yIgXdzkN4jLGKm2SIbzJzj35Msd
	ogYAvj9lazM5C1EoqVrX4ALw1fIgb06BgyBgaGZ/UPz8yxZUFCeJ+5eDqMw9BN3CCzBsXw
	InGFzcCr3RUmNm0APGKAyudcUHVvQoBympK50IMLBEMZO7ZHe4uBKdTg0IVgxXzjs9neUZ
	HX97vVcLmtP/ykrhxvYLPtj0nuEs8wM1SQgL4MU/FXX1RQEBI9sC6XT1gUuCxA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 16 Feb 2024 16:52:27 +0100
Subject: [PATCH RFC net-next v8 09/13] net: Add the possibility to support
 a selected hwtstamp in netdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-feature_ptp_netnext-v8-9-510f42f444fb@bootlin.com>
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

Introduce the description of a hwtstamp provider which is define with a
ptp_clock pointer and a qualifier value.

Add a hwtstamp provider description within the netdev structure to be able
to select the hwtstamp we want too use. By default we use the old API that
does not support hwtstamp selectability which mean the hwtstamp ptp_clock
pointer is unset.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch
---
 drivers/net/phy/phy_device.c    |  7 +++++++
 include/linux/net_tstamp.h      |  6 ++++++
 include/linux/netdevice.h       |  5 +++++
 include/uapi/linux/net_tstamp.h | 11 +++++++++++
 net/core/dev_ioctl.c            | 39 +++++++++++++++++++++++++++++++++++++--
 net/core/timestamping.c         | 34 ++++++++++++++++++++++++++++------
 6 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d63dca535746..afdd3f701399 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -31,6 +31,7 @@
 #include <linux/phy_led_triggers.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/property.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/rtnetlink.h>
 #include <linux/sfp.h>
 #include <linux/skbuff.h>
@@ -1925,6 +1926,12 @@ void phy_detach(struct phy_device *phydev)
 
 	phy_suspend(phydev);
 	if (dev) {
+		/* Disable timestamp if selected */
+		if (ptp_clock_phydev(dev->hwtstamp.ptp) == phydev) {
+			dev->hwtstamp.ptp = NULL;
+			dev->hwtstamp.qualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
+		}
+
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 	}
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 662074b08c94..263dfcf12000 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -19,6 +19,11 @@ enum hwtstamp_source {
 	HWTSTAMP_SOURCE_PHYLIB,
 };
 
+struct hwtstamp_provider {
+	struct ptp_clock *ptp;
+	enum hwtstamp_provider_qualifier qualifier;
+};
+
 /**
  * struct kernel_hwtstamp_config - Kernel copy of struct hwtstamp_config
  *
@@ -43,6 +48,7 @@ struct kernel_hwtstamp_config {
 	struct ifreq *ifr;
 	bool copied_to_user;
 	enum hwtstamp_source source;
+	enum hwtstamp_provider_qualifier qualifier;
 };
 
 static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 37cccdc333c6..583a18ed83d9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -47,6 +47,7 @@
 #include <uapi/linux/if_bonding.h>
 #include <uapi/linux/pkt_cls.h>
 #include <uapi/linux/netdev.h>
+#include <linux/net_tstamp.h>
 #include <linux/hashtable.h>
 #include <linux/rbtree.h>
 #include <net/net_trackers.h>
@@ -2107,6 +2108,8 @@ enum netdev_reg_state {
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
  *
+ *	@hwtstamp: Tracks which PTP performs hardware packet time stamping.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2478,6 +2481,8 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
+
+	struct hwtstamp_provider	hwtstamp;
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a2c66b3d7f0f..a9ed48ee8fc7 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -13,6 +13,17 @@
 #include <linux/types.h>
 #include <linux/socket.h>   /* for SO_TIMESTAMPING */
 
+/*
+ * Possible type of htstamp provider. Mainly "precise" the default one
+ * is for IEEE 1588 quality and "approx" is for NICs DMA point.
+ */
+enum hwtstamp_provider_qualifier {
+	HWTSTAMP_PROVIDER_QUALIFIER_PRECISE,
+	HWTSTAMP_PROVIDER_QUALIFIER_APPROX,
+
+	HWTSTAMP_PROVIDER_QUALIFIER_CNT,
+};
+
 /* SO_TIMESTAMPING flags */
 enum {
 	SOF_TIMESTAMPING_TX_HARDWARE = (1<<0),
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 3342834597cd..cd093c2aad67 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -6,6 +6,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/net_tstamp.h>
 #include <linux/phylib_stubs.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/wireless.h>
 #include <linux/if_bridge.h>
 #include <net/dsa_stubs.h>
@@ -270,6 +271,20 @@ static int dev_eth_ioctl(struct net_device *dev,
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg)
 {
+	cfg->qualifier = dev->hwtstamp.qualifier;
+
+	if (dev->hwtstamp.ptp) {
+		struct ptp_clock *ptp = dev->hwtstamp.ptp;
+
+		if (ptp_clock_from_phylib(ptp))
+			return phy_hwtstamp_get(ptp_clock_phydev(ptp), cfg);
+
+		if (ptp_clock_from_netdev(ptp))
+			return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
+
+		return -EOPNOTSUPP;
+	}
+
 	if (phy_is_default_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);
 
@@ -327,11 +342,31 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
 	struct kernel_hwtstamp_config old_cfg = {};
+	struct phy_device *phydev;
 	bool changed = false;
+	bool phy_ts;
 	int err;
 
+	cfg->qualifier = dev->hwtstamp.qualifier;
+
+	if (dev->hwtstamp.ptp) {
+		struct ptp_clock *ptp = dev->hwtstamp.ptp;
+
+		if (ptp_clock_from_phylib(ptp)) {
+			phy_ts = true;
+			phydev = ptp_clock_phydev(ptp);
+		} else if (ptp_clock_from_netdev(ptp)) {
+			phy_ts = false;
+		} else {
+			return -EOPNOTSUPP;
+		}
+	} else {
+		phy_ts = phy_is_default_hwtstamp(dev->phydev);
+		if (phy_ts)
+			phydev = dev->phydev;
+	}
+
 	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
 
 	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
@@ -353,7 +388,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
 
 	if (phy_ts) {
-		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
+		err = phy_hwtstamp_set(phydev, cfg, extack);
 		if (err) {
 			if (changed)
 				ops->ndo_hwtstamp_set(dev, &old_cfg, NULL);
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 891bfc2f62fd..a7b256ac3490 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -9,6 +9,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/skbuff.h>
 #include <linux/export.h>
+#include <linux/ptp_clock_kernel.h>
 
 static unsigned int classify(const struct sk_buff *skb)
 {
@@ -22,20 +23,31 @@ static unsigned int classify(const struct sk_buff *skb)
 void skb_clone_tx_timestamp(struct sk_buff *skb)
 {
 	struct mii_timestamper *mii_ts;
+	struct phy_device *phydev;
 	struct sk_buff *clone;
 	unsigned int type;
 
 	if (!skb->sk || !skb->dev)
 		return;
 
-	if (!phy_is_default_hwtstamp(skb->dev->phydev))
-		return;
+	if (skb->dev->hwtstamp.ptp) {
+		if (!ptp_clock_from_phylib(skb->dev->hwtstamp.ptp))
+			return;
+
+		phydev = ptp_clock_phydev(skb->dev->hwtstamp.ptp);
+
+	} else {
+		if (!phy_is_default_hwtstamp(phydev))
+			return;
+
+		phydev = skb->dev->phydev;
+	}
 
 	type = classify(skb);
 	if (type == PTP_CLASS_NONE)
 		return;
 
-	mii_ts = skb->dev->phydev->mii_ts;
+	mii_ts = phydev->mii_ts;
 	if (likely(mii_ts->txtstamp)) {
 		clone = skb_clone_sk(skb);
 		if (!clone)
@@ -48,13 +60,23 @@ EXPORT_SYMBOL_GPL(skb_clone_tx_timestamp);
 bool skb_defer_rx_timestamp(struct sk_buff *skb)
 {
 	struct mii_timestamper *mii_ts;
+	struct phy_device *phydev;
 	unsigned int type;
 
 	if (!skb->dev)
 		return false;
 
-	if (!phy_is_default_hwtstamp(skb->dev->phydev))
-		return false;
+	if (skb->dev->hwtstamp.ptp) {
+		if (!ptp_clock_from_phylib(skb->dev->hwtstamp.ptp))
+			return false;
+
+		phydev = ptp_clock_phydev(skb->dev->hwtstamp.ptp);
+	} else {
+		if (!phy_is_default_hwtstamp(phydev))
+			return false;
+
+		phydev = skb->dev->phydev;
+	}
 
 	if (skb_headroom(skb) < ETH_HLEN)
 		return false;
@@ -68,7 +90,7 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
 	if (type == PTP_CLASS_NONE)
 		return false;
 
-	mii_ts = skb->dev->phydev->mii_ts;
+	mii_ts = phydev->mii_ts;
 	if (likely(mii_ts->rxtstamp))
 		return mii_ts->rxtstamp(mii_ts, skb, type);
 

-- 
2.25.1


