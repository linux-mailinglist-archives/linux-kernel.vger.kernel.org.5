Return-Path: <linux-kernel+bounces-153381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBAD8ACD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1578428557B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56E152514;
	Mon, 22 Apr 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mISpvTLl"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761FE1509B8;
	Mon, 22 Apr 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790249; cv=none; b=jeeqZT0FhFhJAPXnRCdzGrhgsQXRRit3Gm+aD3E6nmB+dopezi9C+sIJCz1H6cSO1vSYtaylqXbFBP/0KA9r7AkS2EFyaXhKUzREA4r+Kdd92Xo1MQutP4ckALO1yDcJafndXxQ9be29VcbdJzAcNDh6k2W4wZwmVLRanPPbkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790249; c=relaxed/simple;
	bh=E+ceHwg51+x8TZoy98PGrZnlUUIAExA9XNbfjHl/3fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wm3nBKiVtJowvFrRGJW81cuJ+ZGvF2DL51oqWhgAvMzHcf5T/3dcr7gvn78ekwES8HYzF0nDc0poX/Y3afUSQcHw91YUy/yc4uunLyk9oAWIHSyyteB8D0z5lkz57mStSXmPsS09ScI21TyF7BTElMyWuZoLbHpq8THAdiolQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mISpvTLl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82DC1E0017;
	Mon, 22 Apr 2024 12:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713790245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icaFBDLb05mWT7QjMe3S991XiW036luksX3lEDusFjU=;
	b=mISpvTLlE66xgmOXhkhG8Jjk2hDiWJCiin0QM3M1/ggiuo0BKPSCMuJvRsCgTlpZxO/OoS
	mXKNIuEWTiBNBnYECX5/0EIcd+miZ/75XTIP72qoyeIbRHna/Wk8aP/hWpeC2SE/99FLgQ
	gtopic/NWtfITV47dVTSqSFOVf4X6yz2uzQEF51lhgpwZpqNloOMWdVI1OazoshGpwhLcK
	Q7grL2w16u6F0DYvE7Hlj+KUB6ZGYfGuoEDmqLjHpxHBhFLHblyw5DTBpC+Q9DiKkBxJOY
	Hup/f/tSMDYOO8B7Z0LLRVvll+8ZT+zzC0Vv8TMTynuvnwwnKBlxTIucMrfocw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 22 Apr 2024 14:50:23 +0200
Subject: [PATCH net-next v11 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-feature_ptp_netnext-v11-8-f14441f2a1d8@bootlin.com>
References: <20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com>
In-Reply-To: <20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com>
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

Prepare for future hardware timestamp selection by adding source and
corresponding pointers to ptp_clock structure. Additionally, introduce
helpers for registering specific phydev or netdev PTP clocks, retrieving
PTP clock information such as hwtstamp source or phydev/netdev pointers,
and obtaining the ptp_clock structure from the phc index.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch.

Change in v10:
- Add get and put function to avoid unregistering a ptp clock object used.
- Fix kdoc issues.

Change in v11:
- Remove useless extern.
---
 drivers/ptp/ptp_clock.c          | 114 +++++++++++++++++++++++++++++++++++++++
 drivers/ptp/ptp_private.h        |   5 ++
 include/linux/ptp_clock_kernel.h | 104 +++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c56cd0f63909..f962f460ec9d 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -512,6 +512,120 @@ void ptp_cancel_worker_sync(struct ptp_clock *ptp)
 }
 EXPORT_SYMBOL(ptp_cancel_worker_sync);
 
+struct ptp_clock *netdev_ptp_clock_register(struct ptp_clock_info *info,
+					    struct net_device *dev)
+{
+	struct ptp_clock *ptp;
+
+	ptp = ptp_clock_register(info, &dev->dev);
+	if (IS_ERR(ptp))
+		return ptp;
+
+	ptp->phc_source = HWTSTAMP_SOURCE_NETDEV;
+	ptp->netdev = dev;
+
+	return ptp;
+}
+EXPORT_SYMBOL(netdev_ptp_clock_register);
+
+struct ptp_clock *phydev_ptp_clock_register(struct ptp_clock_info *info,
+					    struct phy_device *phydev)
+{
+	struct ptp_clock *ptp;
+
+	ptp = ptp_clock_register(info, &phydev->mdio.dev);
+	if (IS_ERR(ptp))
+		return ptp;
+
+	ptp->phc_source = HWTSTAMP_SOURCE_PHYLIB;
+	ptp->phydev = phydev;
+
+	return ptp;
+}
+EXPORT_SYMBOL(phydev_ptp_clock_register);
+
+bool ptp_clock_from_phylib(struct ptp_clock *ptp)
+{
+	return ptp->phc_source == HWTSTAMP_SOURCE_PHYLIB;
+}
+EXPORT_SYMBOL(ptp_clock_from_phylib);
+
+bool ptp_clock_from_netdev(struct ptp_clock *ptp)
+{
+	return ptp->phc_source == HWTSTAMP_SOURCE_NETDEV;
+}
+EXPORT_SYMBOL(ptp_clock_from_netdev);
+
+struct net_device *ptp_clock_netdev(struct ptp_clock *ptp)
+{
+	if (ptp->phc_source != HWTSTAMP_SOURCE_NETDEV)
+		return NULL;
+
+	return ptp->netdev;
+}
+EXPORT_SYMBOL(ptp_clock_netdev);
+
+struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp)
+{
+	if (ptp->phc_source != HWTSTAMP_SOURCE_PHYLIB)
+		return NULL;
+
+	return ptp->phydev;
+}
+EXPORT_SYMBOL(ptp_clock_phydev);
+
+int ptp_clock_get(struct device *dev, struct ptp_clock *ptp)
+{
+	struct device_link *link;
+
+	if (!ptp)
+		return 0;
+
+	if (!try_module_get(ptp->info->owner))
+		return -EPROBE_DEFER;
+
+	get_device(&ptp->dev);
+
+	link = device_link_add(dev, &ptp->dev, DL_FLAG_STATELESS);
+	if (!link)
+		dev_warn(dev, "failed to create device link to %s\n",
+			 dev_name(&ptp->dev));
+
+	return 0;
+}
+EXPORT_SYMBOL(ptp_clock_get);
+
+struct ptp_clock *ptp_clock_get_by_index(struct device *dev, int index)
+{
+	struct ptp_clock *ptp;
+	int ret;
+
+	if (index < 0)
+		return NULL;
+
+	ptp = xa_load(&ptp_clocks_map, (unsigned long)index);
+	if (IS_ERR_OR_NULL(ptp))
+		return ptp;
+
+	ret = ptp_clock_get(dev, ptp);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return ptp;
+}
+EXPORT_SYMBOL(ptp_clock_get_by_index);
+
+void ptp_clock_put(struct device *dev, struct ptp_clock *ptp)
+{
+	if (!ptp)
+		return;
+
+	device_link_remove(dev, &ptp->dev);
+	put_device(&ptp->dev);
+	module_put(ptp->info->owner);
+}
+EXPORT_SYMBOL(ptp_clock_put);
+
 /* module operations */
 
 static void __exit ptp_exit(void)
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 18934e28469e..64d4bfafabfc 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -41,6 +41,11 @@ struct ptp_clock {
 	struct ptp_clock_info *info;
 	dev_t devid;
 	int index; /* index into clocks.map */
+	enum hwtstamp_source phc_source;
+	union { /* Pointer of the phc_source device */
+		struct net_device *netdev;
+		struct phy_device *phydev;
+	};
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 6e4b8206c7d0..23b43f59fcfb 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -9,7 +9,9 @@
 #define _PTP_CLOCK_KERNEL_H_
 
 #include <linux/device.h>
+#include <linux/netdevice.h>
 #include <linux/pps_kernel.h>
+#include <linux/phy.h>
 #include <linux/ptp_clock.h>
 #include <linux/timecounter.h>
 #include <linux/skbuff.h>
@@ -340,6 +342,90 @@ extern void ptp_clock_event(struct ptp_clock *ptp,
 
 extern int ptp_clock_index(struct ptp_clock *ptp);
 
+/**
+ * netdev_ptp_clock_register() - register a PTP hardware clock driver for
+ *				 a net device
+ *
+ * @info: Structure describing the new clock.
+ * @dev:  Pointer of the net device
+ */
+
+struct ptp_clock *
+netdev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct net_device *dev);
+
+/**
+ * phydev_ptp_clock_register() - register a PTP hardware clock driver for
+ *				 a phy device
+ *
+ * @info:   Structure describing the new clock.
+ * @phydev:  Pointer of the phy device
+ */
+
+struct ptp_clock *
+phydev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct phy_device *phydev);
+
+/**
+ * ptp_clock_from_phylib() - return true if the PTP clock comes from phylib
+ *
+ * @ptp:  The clock obtained from net/phy_ptp_clock_register().
+ */
+
+bool ptp_clock_from_phylib(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_from_netdev() - return true if the PTP clock comes from netdev
+ *
+ * @ptp:  The clock obtained from net/phy_ptp_clock_register().
+ */
+
+bool ptp_clock_from_netdev(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_netdev() - obtain the net_device of PTP clock
+ *
+ * @ptp:  The clock obtained from netdev_ptp_clock_register().
+ */
+
+struct net_device *ptp_clock_netdev(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_phydev() - obtain the phy_device of a PTP clock
+ *
+ * @ptp:  The clock obtained from phydev_ptp_clock_register().
+ */
+
+struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_get() - increment refcount of the PTP clock
+ *
+ * @dev:  The device which get the PTP clock.
+ * @ptp:  Pointer of a PTP clock.
+ */
+
+int ptp_clock_get(struct device *dev, struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_get_by_index() - obtain the PTP clock reference from a given
+ *			      PHC index
+ *
+ * @dev:  The device which get the PTP clock.
+ * @index:  The device index of a PTP clock.
+ */
+
+struct ptp_clock *ptp_clock_get_by_index(struct device *dev, int index);
+
+/**
+ * ptp_clock_put() - decrement refcount of the PTP clock
+ *
+ * @dev:  The device which get the PTP clock.
+ * @ptp:  Pointer of a PTP clock.
+ */
+
+void ptp_clock_put(struct device *dev, struct ptp_clock *ptp);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -405,6 +491,24 @@ static inline void ptp_clock_event(struct ptp_clock *ptp,
 { }
 static inline int ptp_clock_index(struct ptp_clock *ptp)
 { return -1; }
+static inline struct ptp_clock *
+netdev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct net_device *dev)
+{ return NULL; }
+static inline struct ptp_clock *
+phydev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct phy_device *phydev)
+{ return NULL; }
+static inline bool ptp_clock_from_phylib(struct ptp_clock *ptp)
+{ return false; }
+static inline bool ptp_clock_from_netdev(struct ptp_clock *ptp)
+{ return false; }
+static inline struct net_device *ptp_clock_netdev(struct ptp_clock *ptp)
+{ return NULL; }
+static inline struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp);
+{ return NULL; }
+static inline struct ptp_clock *ptp_clock_get_by_index(int index);
+{ return NULL; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
 			       enum ptp_pin_function func, unsigned int chan)
 { return -1; }

-- 
2.34.1


