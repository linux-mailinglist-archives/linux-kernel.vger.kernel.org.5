Return-Path: <linux-kernel+bounces-164314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1998D8B7C33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36F72850EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E701181332;
	Tue, 30 Apr 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DzNgpfrc"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8B17A93E;
	Tue, 30 Apr 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492248; cv=none; b=dRTBdIcPNfjFXOiHanc2zY+zhTmrZ0nur8oRIERI6EXO0t67L3yDkjvD/xD5cihLGcCxRD8NJ9Ne70mXVdXrup96n4Jg58PpfywaiplqWC4ruTHPF83mFmw+uOlbOBUeY0arhy6OzVXKc9SDkoBgfY/jfjD/NBm/fWls4YU5JIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492248; c=relaxed/simple;
	bh=NA3YKuEZTgjf6pl3CPj3TV2SVa3sM3MBTtyGoy7fIME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khhfN8eBq3PP5SHYg13wOGnDAF95tuwLShey11qLW4Cpp5qH5NgS8Xv7+t9UHzX6HuAjfL+mzBWcVl9hZta47hUAZVWT5XWnbwMNdSWuFJjneaz+V4OTEAqCZvZ8Wq2vEaYXx4fV3+EyXiMFL3pA/nm+izw7gzWBFkcmZIuDrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DzNgpfrc; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5EFE32001D;
	Tue, 30 Apr 2024 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714492237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7d2gbZpuv6OdFllYfLLmnzfk7XeytS2MufO4KvMB6Y=;
	b=DzNgpfrcXZ7XXun8AZmt8sOqwKUcKhKhrokBeARytwdbf7vOz8rZpnPAo2g8Skh9afJA7j
	Mf2tOpSAIpaTQY3hLzyrzqgUR0QnzkakGqpJrodqY84/BkIgT4wbZa9nU07QBITK+6OFZh
	THl4gtKh060ED7QgYINpcak+FFqqYRBngxp2OYJIU0gi61o9d7nuF/uFqnPxXhrV2GVrk1
	k63X9cOMBqkovoWqMqliHql+IeCfnxooBpRKM6iX/W7meHQKCGYeGuCgNjl5vGxsJ0YDF/
	5VB9vE4ASi5QmFUIaU9aFWDU8uKeV935JTSwZSbK1fN/y7qsyKRfweyab4hYWA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 30 Apr 2024 17:49:52 +0200
Subject: [PATCH net-next v12 09/13] net: Add the possibility to support a
 selected hwtstamp in netdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-feature_ptp_netnext-v12-9-2c5f24b6a914@bootlin.com>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
In-Reply-To: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
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

Change in v10:
- Set hwtstamp in netdevice as a pointer for future use of rcu lock.
- Fix a nit in teh order of setting phydev pointer.
- Add a missing kdoc description.
---
 drivers/net/phy/phy_device.c    | 10 ++++++++++
 include/linux/net_tstamp.h      |  7 +++++++
 include/linux/netdevice.h       |  5 +++++
 include/uapi/linux/net_tstamp.h | 11 +++++++++++
 net/core/dev_ioctl.c            | 38 ++++++++++++++++++++++++++++++++++++--
 net/core/timestamping.c         | 38 +++++++++++++++++++++++++++++++++-----
 6 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 616bd7ba46cb..7d1f03195661 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -32,6 +32,7 @@
 #include <linux/phy_link_topology.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/property.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/rtnetlink.h>
 #include <linux/sfp.h>
 #include <linux/skbuff.h>
@@ -1990,6 +1991,15 @@ void phy_detach(struct phy_device *phydev)
 
 	phy_suspend(phydev);
 	if (dev) {
+		struct hwtstamp_provider *hwtstamp = dev->hwtstamp;
+
+		/* Disable timestamp if selected */
+		if (hwtstamp &&
+		    ptp_clock_phydev(hwtstamp->ptp) == phydev) {
+			dev->hwtstamp = NULL;
+			kfree(hwtstamp);
+		}
+
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 		phy_link_topo_del_phy(dev->link_topo, phydev);
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 662074b08c94..4d936fc8527e 100644
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
@@ -31,6 +36,7 @@ enum hwtstamp_source {
  *	copied the ioctl request back to user space
  * @source: indication whether timestamps should come from the netdev or from
  *	an attached phylib PHY
+ * @qualifier: qualifier of the hwtstamp provider
  *
  * Prefer using this structure for in-kernel processing of hardware
  * timestamping configuration, over the inextensible struct hwtstamp_config
@@ -43,6 +49,7 @@ struct kernel_hwtstamp_config {
 	struct ifreq *ifr;
 	bool copied_to_user;
 	enum hwtstamp_source source;
+	enum hwtstamp_provider_qualifier qualifier;
 };
 
 static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f0e4572cdad5..f6333b8a630d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -46,6 +46,7 @@
 #include <uapi/linux/if_bonding.h>
 #include <uapi/linux/pkt_cls.h>
 #include <uapi/linux/netdev.h>
+#include <linux/net_tstamp.h>
 #include <linux/hashtable.h>
 #include <linux/rbtree.h>
 #include <net/net_trackers.h>
@@ -2026,6 +2027,8 @@ enum netdev_reg_state {
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
  *
+ *	@hwtstamp: Tracks which PTP performs hardware packet time stamping.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2400,6 +2403,8 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
+
+	struct hwtstamp_provider	*hwtstamp;
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
index 36cea843381f..acb0cadb7512 100644
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
@@ -269,6 +270,19 @@ static int dev_eth_ioctl(struct net_device *dev,
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg)
 {
+	if (dev->hwtstamp) {
+		struct ptp_clock *ptp = dev->hwtstamp->ptp;
+
+		cfg->qualifier = dev->hwtstamp->qualifier;
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
 
@@ -325,11 +339,31 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
 	struct kernel_hwtstamp_config old_cfg = {};
+	struct phy_device *phydev;
 	bool changed = false;
+	bool phy_ts;
 	int err;
 
+	if (dev->hwtstamp) {
+		struct ptp_clock *ptp = dev->hwtstamp->ptp;
+
+		if (ptp_clock_from_phylib(ptp)) {
+			phy_ts = true;
+			phydev = ptp_clock_phydev(ptp);
+		} else if (ptp_clock_from_netdev(ptp)) {
+			phy_ts = false;
+		} else {
+			return -EOPNOTSUPP;
+		}
+
+		cfg->qualifier = dev->hwtstamp->qualifier;
+	} else {
+		phy_ts = phy_is_default_hwtstamp(dev->phydev);
+		if (phy_ts)
+			phydev = dev->phydev;
+	}
+
 	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
 
 	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
@@ -351,7 +385,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
 
 	if (phy_ts) {
-		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
+		err = phy_hwtstamp_set(phydev, cfg, extack);
 		if (err) {
 			if (changed)
 				ops->ndo_hwtstamp_set(dev, &old_cfg, NULL);
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 3717fb152ecc..1bc9dc76efff 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -9,6 +9,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/skbuff.h>
 #include <linux/export.h>
+#include <linux/ptp_clock_kernel.h>
 
 static unsigned int classify(const struct sk_buff *skb)
 {
@@ -22,18 +23,31 @@ static unsigned int classify(const struct sk_buff *skb)
 void skb_clone_tx_timestamp(struct sk_buff *skb)
 {
 	struct mii_timestamper *mii_ts;
+	struct phy_device *phydev;
 	struct sk_buff *clone;
 	unsigned int type;
 
-	if (!skb->sk || !skb->dev ||
-	    !phy_is_default_hwtstamp(skb->dev->phydev))
+	if (!skb->sk || !skb->dev)
 		return;
 
+	if (skb->dev->hwtstamp) {
+		struct ptp_clock *ptp = skb->dev->hwtstamp->ptp;
+
+		if (!ptp_clock_from_phylib(ptp))
+			return;
+
+		phydev = ptp_clock_phydev(ptp);
+	} else {
+		phydev = skb->dev->phydev;
+		if (!phy_is_default_hwtstamp(phydev))
+			return;
+	}
+
 	type = classify(skb);
 	if (type == PTP_CLASS_NONE)
 		return;
 
-	mii_ts = skb->dev->phydev->mii_ts;
+	mii_ts = phydev->mii_ts;
 	if (likely(mii_ts->txtstamp)) {
 		clone = skb_clone_sk(skb);
 		if (!clone)
@@ -46,11 +60,25 @@ EXPORT_SYMBOL_GPL(skb_clone_tx_timestamp);
 bool skb_defer_rx_timestamp(struct sk_buff *skb)
 {
 	struct mii_timestamper *mii_ts;
+	struct phy_device *phydev;
 	unsigned int type;
 
-	if (!skb->dev || !phy_is_default_hwtstamp(skb->dev->phydev))
+	if (!skb->dev)
 		return false;
 
+	if (skb->dev->hwtstamp) {
+		struct ptp_clock *ptp = skb->dev->hwtstamp->ptp;
+
+		if (!ptp_clock_from_phylib(ptp))
+			return false;
+
+		phydev = ptp_clock_phydev(ptp);
+	} else {
+		phydev = skb->dev->phydev;
+		if (!phy_is_default_hwtstamp(phydev))
+			return false;
+	}
+
 	if (skb_headroom(skb) < ETH_HLEN)
 		return false;
 
@@ -63,7 +91,7 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
 	if (type == PTP_CLASS_NONE)
 		return false;
 
-	mii_ts = skb->dev->phydev->mii_ts;
+	mii_ts = phydev->mii_ts;
 	if (likely(mii_ts->rxtstamp))
 		return mii_ts->rxtstamp(mii_ts, skb, type);
 

-- 
2.34.1


