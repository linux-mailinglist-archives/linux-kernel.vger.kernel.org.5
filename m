Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153CA7EF565
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjKQPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:40:24 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913D7D5E;
        Fri, 17 Nov 2023 07:40:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7382C1BF20C;
        Fri, 17 Nov 2023 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700235618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6UzJ+qgyifeQMiSGk773lYg6V+Won0QIn8kodlKz0lM=;
        b=ULh2xGqNynVfatvYjxoU/rSc9LDiTkr/Gim//rw0pqvwjSM3xL5gpNNYw4ODaS4deZFYIG
        AfZpXZHRdTHcSJ/wlo0g/IIHS93SpgxuTzi8dbUKW9aoz5eMDwsikF1ZIECDxCUgEnKoUX
        imZHe1p3990A3oEGtYw2SNf11/TdCpRL7VCC5feSOZpe1rBNJgiZSAqZ4Ggqd160ZEK6hc
        X35P/odLdcgD71tLV7wi1b73Fv6u8SiQcvFI9uUsc5wjTZD41lE4Hp4z05GYT4TaHf0QuK
        eiwiDMs7ueNTYGloc6kBuPnAYR/drK31D3Iged2pNU5U33Vz0qU7C6DV3vpzGQ==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
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
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [RFC PATCH net-next v2 01/10] net: phy: Introduce ethernet link topology representation
Date:   Fri, 17 Nov 2023 17:23:12 +0100
Message-ID: <20231117162323.626979-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
depends on the netdevice the phy is attached to.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 MAINTAINERS                        |  1 +
 drivers/net/phy/Makefile           |  2 +-
 drivers/net/phy/link_topology.c    | 78 ++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c       | 14 ++++++
 include/linux/link_topology.h      | 59 ++++++++++++++++++++++
 include/linux/link_topology_core.h | 17 +++++++
 include/linux/netdevice.h          |  3 +-
 include/linux/phy.h                |  3 ++
 include/uapi/linux/ethtool.h       |  7 +++
 net/core/dev.c                     |  4 ++
 10 files changed, 186 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/phy/link_topology.c
 create mode 100644 include/linux/link_topology.h
 create mode 100644 include/linux/link_topology_core.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 76dea3f2e391..08b5892cf349 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7820,6 +7820,7 @@ F:	include/linux/mii.h
 F:	include/linux/of_net.h
 F:	include/linux/phy.h
 F:	include/linux/phy_fixed.h
+F:	include/linux/phy_list.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 F:	include/linux/platform_data/mdio-gpio.h
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..41d528e0e532 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Linux PHY drivers
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
-				   linkmode.o
+				   linkmode.o link_topology.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
diff --git a/drivers/net/phy/link_topology.c b/drivers/net/phy/link_topology.c
new file mode 100644
index 000000000000..0a08ca729e84
--- /dev/null
+++ b/drivers/net/phy/link_topology.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Infrastructure to handle all PHY devices connected to a given netdev,
+ * either directly or indirectly attached.
+ *
+ * Copyright (c) 2023 Maxime Chevallier<maxime.chevallier@bootlin.com>
+ */
+
+#include <linux/link_topology.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+#include <linux/xarray.h>
+
+struct phy_device *link_topo_get_phy(struct link_topology *lt, int phyindex)
+{
+	struct phy_device_node *pdn = xa_load(&lt->phys, phyindex);
+
+	if (pdn)
+		return pdn->phy;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(link_topo_get_phy);
+
+int link_topo_add_phy(struct link_topology *lt, struct phy_device *phy,
+		      enum phy_upstream upt, void *upstream)
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
+	ret = xa_alloc_cyclic(&lt->phys, &phy->phyindex, pdn, xa_limit_32b,
+			      &lt->next_phy_index, GFP_KERNEL);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(pdn);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(link_topo_add_phy);
+
+void link_topo_del_phy(struct link_topology *lt, struct phy_device *phy)
+{
+	struct phy_device_node *pdn = xa_erase(&lt->phys, phy->phyindex);
+
+	kfree(pdn);
+}
+EXPORT_SYMBOL_GPL(link_topo_del_phy);
+
+void link_topo_init(struct link_topology *lt)
+{
+	xa_init_flags(&lt->phys, XA_FLAGS_ALLOC1);
+	lt->next_phy_index = 1;
+}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..b38b0dc00ef7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/link_topology.h>
 #include <linux/list.h>
 #include <linux/mdio.h>
 #include <linux/mii.h>
@@ -265,6 +266,14 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 
 static struct phy_driver genphy_driver;
 
+static struct link_topology *phy_get_link_topology(struct phy_device *phydev)
+{
+	if (phydev->attached_dev)
+		return &phydev->attached_dev->link_topo;
+
+	return NULL;
+}
+
 static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
@@ -1489,6 +1498,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 		if (phydev->sfp_bus_attached)
 			dev->sfp_bus = phydev->sfp_bus;
+
+		err = link_topo_add_phy(&dev->link_topo, phydev, PHY_UPSTREAM_MAC, dev);
+		if (err)
+			goto error;
 	}
 
 	/* Some Ethernet drivers try to connect to a PHY device before
@@ -1814,6 +1827,7 @@ void phy_detach(struct phy_device *phydev)
 	if (dev) {
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
+		link_topo_del_phy(&dev->link_topo, phydev);
 	}
 	phydev->phylink = NULL;
 
diff --git a/include/linux/link_topology.h b/include/linux/link_topology.h
new file mode 100644
index 000000000000..7054fcb7ebc5
--- /dev/null
+++ b/include/linux/link_topology.h
@@ -0,0 +1,59 @@
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
+#ifndef __LINK_TOPOLOGY_H
+#define __LINK_TOPOLOGY_H
+
+#include <linux/ethtool.h>
+#include <linux/link_topology_core.h>
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
+#if IS_ENABLED(CONFIG_PHYLIB)
+struct phy_device *link_topo_get_phy(struct link_topology *lt, int phyindex);
+int link_topo_add_phy(struct link_topology *lt, struct phy_device *phy,
+		      enum phy_upstream upt, void *upstream);
+
+void link_topo_del_phy(struct link_topology *lt, struct phy_device *phy);
+
+#else
+static struct phy_device *link_topo_get_phy(struct link_topology *lt, int phyindex)
+{
+	return NULL;
+}
+
+static int link_topo_add_phy(struct link_topology *lt, struct phy_device *phy,
+			     enum phy_upstream upt, void *upstream)
+{
+	return 0;
+}
+
+static void link_topo_del_phy(struct link_topology *lt, struct phy_device *phy)
+{
+}
+#endif
+
+#endif /* __LINK_TOPOLOGY_H */
diff --git a/include/linux/link_topology_core.h b/include/linux/link_topology_core.h
new file mode 100644
index 000000000000..e8f214a22e1f
--- /dev/null
+++ b/include/linux/link_topology_core.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINK_TOPOLOGY_CORE_H
+#define __LINK_TOPOLOGY_CORE_H
+
+struct xarray;
+
+struct link_topology {
+	struct xarray phys;
+	struct xarray ports;
+
+	u32 next_phy_index;
+	u32 next_port_index;
+};
+
+void link_topo_init(struct link_topology *lt);
+
+#endif /* __LINK_TOPOLOGY_CORE_H */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a16c9cc063fe..7021a0d3d982 100644
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
+#include <linux/link_topology_core.h>
 
 struct netpoll_info;
 struct device;
@@ -2405,6 +2405,7 @@ struct net_device {
 #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
 	struct netprio_map __rcu *priomap;
 #endif
+	struct link_topology	link_topo;
 	struct phy_device	*phydev;
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3cc52826f18e..d698180b1df0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -543,6 +543,8 @@ struct macsec_ops;
  * @drv: Pointer to the driver for this PHY instance
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
+ * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
+ *	      from userspace, similar to ifindex. It's never recycled.
  * @phy_id: UID for this device found during discovery
  * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
  * @is_c45:  Set to true if this PHY uses clause 45 addressing.
@@ -640,6 +642,7 @@ struct phy_device {
 
 	struct device_link *devlink;
 
+	int phyindex;
 	u32 phy_id;
 
 	struct phy_c45_device_ids c45_ids;
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..5794a2a55399 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2205,4 +2205,11 @@ struct ethtool_link_settings {
 	 * __u32 map_lp_advertising[link_mode_masks_nwords];
 	 */
 };
+
+enum phy_upstream {
+	PHY_UPSTREAM_MAC,
+	PHY_UPSTREAM_SFP,
+	PHY_UPSTREAM_PHY,
+};
+
 #endif /* _UAPI_LINUX_ETHTOOL_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..a78087240480 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -153,6 +153,7 @@
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
 #include <net/netdev_rx_queue.h>
+#include <linux/link_topology_core.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -10774,6 +10775,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	INIT_LIST_HEAD(&dev->net_notifier_list);
 #ifdef CONFIG_NET_SCHED
 	hash_init(dev->qdisc_hash);
+#endif
+#ifdef CONFIG_PHYLIB
+	link_topo_init(&dev->link_topo);
 #endif
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
-- 
2.41.0

