Return-Path: <linux-kernel+bounces-131172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C7898404
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FD11F27C04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744CF79955;
	Thu,  4 Apr 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ogdQq+G8"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA6745D6;
	Thu,  4 Apr 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223015; cv=none; b=amEfMteszyckI0jU8dO0mW6ZvADbUIX/C05rOg3K4qf1dLfj2mZm8FfDJZpqwAPckDG/4WKydtCgynteeTxcCcysByx/28bELnPNdtSCSm0Iz7l9kI1rnyA7Kwzm9tqJEel2DzdK9HPccklfDEQvbYFZ6f8YiFVUYrs7SnbDYbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223015; c=relaxed/simple;
	bh=gSSy9IwU5Qli3XeqpfmiWVztuUV0QBCpN8DWVtISeQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRWP/+aNO0WcfcvsNSIB5QAMQ+o90aDyF2i4ntL8kzBWmZtBFdi+o+SpeGWYu1C6dMirwqOPX77dnn+k1LGDsHbyZ4JFvukHytgb5+7ua5Ivvy2xSVFvCOW9XIHwuG5A0MmdipV5kz4uAiqiyna9CEQwx2pkk2Eaur4/UPVtMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ogdQq+G8; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B254C0006;
	Thu,  4 Apr 2024 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712223010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYATN45vaKU9vt9WOnIU0RdtyBAhqI6A9KmXkQV7big=;
	b=ogdQq+G81oDapqjTFSnYN7Re0fbZllbFtfbCpWpLLwLAa1B3JQMi6n52PcbxzNv9jjPRPt
	Ecohxx75PWBewhwZvDjX391+avuxAcgl8eDU6BIuyGEEOmcvDL9hSq0wORXzWybXk6i8j4
	gdqf04vzmVDITSAAMxb1r9r910YlvSt79AIrIurynuCuHdWCOJHuqWTFgoYTwxSLVdRHvM
	RxlIQX5PtfYUHyO9oPRUTNrHgY9oPpprhLdsrW8PT3tOFWmYK7xLgUeEjy/UW0wlkm2NrA
	xjmG9ZKRhQtec2k02xwLt/Lu5WW/gu56boMToZqGHti7VpxZPC8a2YnhJpkgwQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next v11 01/13] net: phy: Introduce ethernet link topology representation
Date: Thu,  4 Apr 2024 11:29:51 +0200
Message-ID: <20240404093004.2552221-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Link topologies containing multiple network PHYs attached to the same
net_device can be found when using a PHY as a media converter for use
with an SFP connector, on which an SFP transceiver containing a PHY can
be used.

With the current model, the transceiver's PHY can't be used for
operations such as cable testing, timestamping, macsec offload, etc.

The reason being that most of the logic for these configuration, coming
from either ethtool netlink or ioctls tend to use netdev->phydev, which
in multi-phy systems will reference the PHY closest to the MAC.

Introduce a numbering scheme allowing to enumerate PHY devices that
belong to any netdev, which can in turn allow userspace to take more
precise decisions with regard to each PHY's configuration.

The numbering is maintained per-netdev, in a phy_device_list.
The numbering works similarly to a netdevice's ifindex, with
identifiers that are only recycled once INT_MAX has been reached.

This prevents races that could occur between PHY listing and SFP
transceiver removal/insertion.

The identifiers are assigned at phy_attach time, as the numbering
depends on the netdevice the phy is attached to. The PHY index can be
re-used for PHYs that are persistent.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V11: - No changes
V10: - No changes
V9: - No changes
V8: - Rebase on net-next and fixed conflicts
V7: - Protected the phy_link_topo helpers/stubs with IS_REACHABLE
V6: - Made link_topo a pointer
    - Reworked the init/cleanup sequence
    - Added phy_index recycling if possible
V5: - Dropped the ASSERT_RTNL()
    - Made the phy_link_topo_get_phy inline
V4: - Moved the phy_link_topo_init() code to an inline header function
    - Made the code build without phylib
V3: - Renamed to phy_link_topology
    - Added assertions for RTNL
    - Various cleanups of leftover, unused test code
    - Made the PHY index u32

 MAINTAINERS                            |   2 +
 drivers/net/phy/Makefile               |   2 +-
 drivers/net/phy/phy_device.c           |   7 ++
 drivers/net/phy/phy_link_topology.c    | 105 +++++++++++++++++++++++++
 include/linux/netdevice.h              |   4 +-
 include/linux/phy.h                    |   4 +
 include/linux/phy_link_topology.h      |  72 +++++++++++++++++
 include/linux/phy_link_topology_core.h |  25 ++++++
 include/uapi/linux/ethtool.h           |  16 ++++
 net/core/dev.c                         |   9 +++
 10 files changed, 244 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/phy/phy_link_topology.c
 create mode 100644 include/linux/phy_link_topology.h
 create mode 100644 include/linux/phy_link_topology_core.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 909c2c531d8e..db0aa3a926ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8016,6 +8016,8 @@ F:	include/linux/mii.h
 F:	include/linux/of_net.h
 F:	include/linux/phy.h
 F:	include/linux/phy_fixed.h
+F:	include/linux/phy_link_topology.h
+F:	include/linux/phy_link_topology_core.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 F:	include/linux/platform_data/mdio-gpio.h
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 202ed7f450da..1d8be374915f 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Linux PHY drivers
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
-				   linkmode.o
+				   linkmode.o phy_link_topology.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6c6ec9475709..452fc8b3406d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -29,6 +29,7 @@
 #include <linux/phy.h>
 #include <linux/phylib_stubs.h>
 #include <linux/phy_led_triggers.h>
+#include <linux/phy_link_topology.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/property.h>
 #include <linux/rtnetlink.h>
@@ -1511,6 +1512,11 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 		if (phydev->sfp_bus_attached)
 			dev->sfp_bus = phydev->sfp_bus;
+
+		err = phy_link_topo_add_phy(dev->link_topo, phydev,
+					    PHY_UPSTREAM_MAC, dev);
+		if (err)
+			goto error;
 	}
 
 	/* Some Ethernet drivers try to connect to a PHY device before
@@ -1938,6 +1944,7 @@ void phy_detach(struct phy_device *phydev)
 	if (dev) {
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
+		phy_link_topo_del_phy(dev->link_topo, phydev);
 	}
 	phydev->phylink = NULL;
 
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
new file mode 100644
index 000000000000..985941c5c558
--- /dev/null
+++ b/drivers/net/phy/phy_link_topology.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Infrastructure to handle all PHY devices connected to a given netdev,
+ * either directly or indirectly attached.
+ *
+ * Copyright (c) 2023 Maxime Chevallier<maxime.chevallier@bootlin.com>
+ */
+
+#include <linux/phy_link_topology.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+#include <linux/rtnetlink.h>
+#include <linux/xarray.h>
+
+struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
+{
+	struct phy_link_topology *topo;
+
+	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
+	if (!topo)
+		return ERR_PTR(-ENOMEM);
+
+	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
+	topo->next_phy_index = 1;
+
+	return topo;
+}
+
+void phy_link_topo_destroy(struct phy_link_topology *topo)
+{
+	if (!topo)
+		return;
+
+	xa_destroy(&topo->phys);
+	kfree(topo);
+}
+
+int phy_link_topo_add_phy(struct phy_link_topology *topo,
+			  struct phy_device *phy,
+			  enum phy_upstream upt, void *upstream)
+{
+	struct phy_device_node *pdn;
+	int ret;
+
+	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
+	if (!pdn)
+		return -ENOMEM;
+
+	pdn->phy = phy;
+	switch (upt) {
+	case PHY_UPSTREAM_MAC:
+		pdn->upstream.netdev = (struct net_device *)upstream;
+		if (phy_on_sfp(phy))
+			pdn->parent_sfp_bus = pdn->upstream.netdev->sfp_bus;
+		break;
+	case PHY_UPSTREAM_PHY:
+		pdn->upstream.phydev = (struct phy_device *)upstream;
+		if (phy_on_sfp(phy))
+			pdn->parent_sfp_bus = pdn->upstream.phydev->sfp_bus;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
+	}
+	pdn->upstream_type = upt;
+
+	/* Attempt to re-use a previously allocated phy_index */
+	if (phy->phyindex) {
+		ret = xa_insert(&topo->phys, phy->phyindex, pdn, GFP_KERNEL);
+
+		/* Errors could be either -ENOMEM or -EBUSY. If the phy has an
+		 * index, and there's another entry at the same index, this is
+		 * unexpected and we still error-out
+		 */
+		if (ret)
+			goto err;
+		return 0;
+	}
+
+	ret = xa_alloc_cyclic(&topo->phys, &phy->phyindex, pdn, xa_limit_32b,
+			      &topo->next_phy_index, GFP_KERNEL);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(pdn);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
+
+void phy_link_topo_del_phy(struct phy_link_topology *topo,
+			   struct phy_device *phy)
+{
+	struct phy_device_node *pdn = xa_erase(&topo->phys, phy->phyindex);
+
+	/* We delete the PHY from the topology, however we don't re-set the
+	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
+	 * same index next time it's added back to the topology
+	 */
+
+	kfree(pdn);
+}
+EXPORT_SYMBOL_GPL(phy_link_topo_del_phy);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0c198620ac93..d45f330d083d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -40,7 +40,6 @@
 #include <net/dcbnl.h>
 #endif
 #include <net/netprio_cgroup.h>
-
 #include <linux/netdev_features.h>
 #include <linux/neighbour.h>
 #include <uapi/linux/netdevice.h>
@@ -52,6 +51,7 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <linux/phy_link_topology_core.h>
 
 struct netpoll_info;
 struct device;
@@ -1974,6 +1974,7 @@ enum netdev_reg_state {
  *	@fcoe_ddp_xid:	Max exchange id for FCoE LRO by ddp
  *
  *	@priomap:	XXX: need comments on this one
+ *	@link_topo:	Physical link topology tracking attached PHYs
  *	@phydev:	Physical device may attach itself
  *			for hardware timestamping
  *	@sfp_bus:	attached &struct sfp_bus structure.
@@ -2364,6 +2365,7 @@ struct net_device {
 #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
 	struct netprio_map __rcu *priomap;
 #endif
+	struct phy_link_topology	*link_topo;
 	struct phy_device	*phydev;
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e6e83304558e..8c848c79b1fd 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -550,6 +550,9 @@ struct macsec_ops;
  * @drv: Pointer to the driver for this PHY instance
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
+ * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
+ *	      from userspace, similar to ifindex. A zero index means the PHY
+ *	      wasn't assigned an id yet.
  * @phy_id: UID for this device found during discovery
  * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
  * @is_c45:  Set to true if this PHY uses clause 45 addressing.
@@ -650,6 +653,7 @@ struct phy_device {
 
 	struct device_link *devlink;
 
+	u32 phyindex;
 	u32 phy_id;
 
 	struct phy_c45_device_ids c45_ids;
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
new file mode 100644
index 000000000000..6b79feb607e7
--- /dev/null
+++ b/include/linux/phy_link_topology.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PHY device list allow maintaining a list of PHY devices that are
+ * part of a netdevice's link topology. PHYs can for example be chained,
+ * as is the case when using a PHY that exposes an SFP module, on which an
+ * SFP transceiver that embeds a PHY is connected.
+ *
+ * This list can then be used by userspace to leverage individual PHY
+ * capabilities.
+ */
+#ifndef __PHY_LINK_TOPOLOGY_H
+#define __PHY_LINK_TOPOLOGY_H
+
+#include <linux/ethtool.h>
+#include <linux/phy_link_topology_core.h>
+
+struct xarray;
+struct phy_device;
+struct net_device;
+struct sfp_bus;
+
+struct phy_device_node {
+	enum phy_upstream upstream_type;
+
+	union {
+		struct net_device	*netdev;
+		struct phy_device	*phydev;
+	} upstream;
+
+	struct sfp_bus *parent_sfp_bus;
+
+	struct phy_device *phy;
+};
+
+struct phy_link_topology {
+	struct xarray phys;
+	u32 next_phy_index;
+};
+
+static inline struct phy_device *
+phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
+{
+	struct phy_device_node *pdn = xa_load(&topo->phys, phyindex);
+
+	if (pdn)
+		return pdn->phy;
+
+	return NULL;
+}
+
+#if IS_REACHABLE(CONFIG_PHYLIB)
+int phy_link_topo_add_phy(struct phy_link_topology *topo,
+			  struct phy_device *phy,
+			  enum phy_upstream upt, void *upstream);
+
+void phy_link_topo_del_phy(struct phy_link_topology *lt, struct phy_device *phy);
+
+#else
+static inline int phy_link_topo_add_phy(struct phy_link_topology *topo,
+					struct phy_device *phy,
+					enum phy_upstream upt, void *upstream)
+{
+	return 0;
+}
+
+static inline void phy_link_topo_del_phy(struct phy_link_topology *topo,
+					 struct phy_device *phy)
+{
+}
+#endif
+
+#endif /* __PHY_LINK_TOPOLOGY_H */
diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
new file mode 100644
index 000000000000..0a6479055745
--- /dev/null
+++ b/include/linux/phy_link_topology_core.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PHY_LINK_TOPOLOGY_CORE_H
+#define __PHY_LINK_TOPOLOGY_CORE_H
+
+struct phy_link_topology;
+
+#if IS_REACHABLE(CONFIG_PHYLIB)
+
+struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
+void phy_link_topo_destroy(struct phy_link_topology *topo);
+
+#else
+
+static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
+{
+	return NULL;
+}
+
+static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
+{
+}
+
+#endif
+
+#endif /* __PHY_LINK_TOPOLOGY_CORE_H */
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 11fc18988bc2..95c2f09f0d0a 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2268,4 +2268,20 @@ struct ethtool_link_settings {
 	 * __u32 map_lp_advertising[link_mode_masks_nwords];
 	 */
 };
+
+/**
+ * enum phy_upstream - Represents the upstream component a given PHY device
+ * is connected to, as in what is on the other end of the MII bus. Most PHYs
+ * will be attached to an Ethernet MAC controller, but in some cases, there's
+ * an intermediate PHY used as a media-converter, which will driver another
+ * MII interface as its output.
+ * @PHY_UPSTREAM_MAC: Upstream component is a MAC (a switch port,
+ *		      or ethernet controller)
+ * @PHY_UPSTREAM_PHY: Upstream component is a PHY (likely a media converter)
+ */
+enum phy_upstream {
+	PHY_UPSTREAM_MAC,
+	PHY_UPSTREAM_PHY,
+};
+
 #endif /* _UAPI_LINUX_ETHTOOL_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index 9b821d96eff3..928cf377e843 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -158,6 +158,7 @@
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
 #include <net/rps.h>
+#include <linux/phy_link_topology_core.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -10962,6 +10963,12 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #ifdef CONFIG_NET_SCHED
 	hash_init(dev->qdisc_hash);
 #endif
+	dev->link_topo = phy_link_topo_create(dev);
+	if (IS_ERR(dev->link_topo)) {
+		dev->link_topo = NULL;
+		goto free_all;
+	}
+
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
 
@@ -11050,6 +11057,8 @@ void free_netdev(struct net_device *dev)
 	free_percpu(dev->xdp_bulkq);
 	dev->xdp_bulkq = NULL;
 
+	phy_link_topo_destroy(dev->link_topo);
+
 	/*  Compatibility with error handling in drivers */
 	if (dev->reg_state == NETREG_UNINITIALIZED) {
 		netdev_freemem(dev);
-- 
2.44.0


