Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE23F797489
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjIGPjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245250AbjIGPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:38 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC691BFA;
        Thu,  7 Sep 2023 08:35:19 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id D6F0BD6694;
        Thu,  7 Sep 2023 09:24:35 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63D5B40004;
        Thu,  7 Sep 2023 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694078653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omfLr8sHaUj1FxSEZuFWzZWjI2Jn7oLXwE8BQG3Uhp8=;
        b=oHYORDdIfpnMH3f6Ld4RU9ozCfffa0NmjANliebtJ6ZZSgX/hhg+YakgBM0eY6AXN8hGSE
        phtGfAYfHjnoH6PfbAQuSm+gegpE+ZHAgELFetifhoCLj/auGRHpGhWiJV5LTVzlIxuVwy
        RaWIO5EeFQYgU48hIkAoPc4HtXeZAvxYgWdfsIURx8U0qkU1sKiP48v21yMLYh+fHQZsOX
        0TTbmQT0WJb+OZsf26bNRoM/kou/RLVKd92/xEjUzDNbS9Lbwk+0R+l89q1HuAGSzXJ221
        0+3AeSclcTWtjfUj17lo2r8KFM3Vc8G92WKYUfzk4q5KDQDmzJfGP3AVSNE0zA==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and phy namespaces
Date:   Thu,  7 Sep 2023 11:23:59 +0200
Message-ID: <20230907092407.647139-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

The numbering is maintained per-netdev, hence the notion of PHY
namespaces. The numbering works similarly to a netdevice's ifindex, with
identifiers that are only recycled once INT_MAX has been reached.

This prevents races that could occur between PHY listing and SFP
transceiver removal/insertion.

The identifiers are assigned at phy_attach time, as the numbering
depends on the netdevice the phy is attached to.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/Makefile     |  2 +-
 drivers/net/phy/phy_device.c | 13 ++++++++
 drivers/net/phy/phy_ns.c     | 65 ++++++++++++++++++++++++++++++++++++
 include/linux/netdevice.h    |  2 ++
 include/linux/phy.h          |  4 +++
 include/linux/phy_ns.h       | 30 +++++++++++++++++
 net/core/dev.c               |  3 ++
 7 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/phy_ns.c
 create mode 100644 include/linux/phy_ns.h

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..baa95d9f24e4 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Linux PHY drivers
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
-				   linkmode.o
+				   linkmode.o phy_ns.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..0c029ae5130a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -29,6 +29,7 @@
 #include <linux/phy.h>
 #include <linux/phylib_stubs.h>
 #include <linux/phy_led_triggers.h>
+#include <linux/phy_ns.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/property.h>
 #include <linux/rtnetlink.h>
@@ -265,6 +266,14 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 
 static struct phy_driver genphy_driver;
 
+static struct phy_namespace *phy_get_ns(struct phy_device *phydev)
+{
+	if (phydev->attached_dev)
+		return &phydev->attached_dev->phy_ns;
+
+	return NULL;
+}
+
 static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
@@ -677,6 +686,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 
 	dev->state = PHY_DOWN;
 	INIT_LIST_HEAD(&dev->leds);
+	INIT_LIST_HEAD(&dev->node);
 
 	mutex_init(&dev->lock);
 	INIT_DELAYED_WORK(&dev->state_queue, phy_state_machine);
@@ -1489,6 +1499,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 		if (phydev->sfp_bus_attached)
 			dev->sfp_bus = phydev->sfp_bus;
+
+		phy_ns_add_phy(&dev->phy_ns, phydev);
 	}
 
 	/* Some Ethernet drivers try to connect to a PHY device before
@@ -1814,6 +1826,7 @@ void phy_detach(struct phy_device *phydev)
 	if (dev) {
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
+		phy_ns_del_phy(&dev->phy_ns, phydev);
 	}
 	phydev->phylink = NULL;
 
diff --git a/drivers/net/phy/phy_ns.c b/drivers/net/phy/phy_ns.c
new file mode 100644
index 000000000000..d7865028ab20
--- /dev/null
+++ b/drivers/net/phy/phy_ns.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Infrastructure to handle all PHY devices connected to a given netdev,
+ * either directly or indirectly attached.
+ *
+ * Copyright (c) 2023 Maxime Chevallier<maxime.chevallier@bootlin.com>
+ */
+
+#include <linux/phy.h>
+#include <linux/phy_ns.h>
+
+static int phy_ns_next_phyindex(struct phy_namespace *phy_ns)
+{
+	int phyindex = phy_ns->last_attributed_index;
+
+	for (;;) {
+		if (++phyindex <= 0)
+			phyindex = 1;
+		if (!phy_ns_get_by_index(phy_ns, phyindex))
+			return phy_ns->last_attributed_index = phyindex;
+	}
+}
+
+struct phy_device *phy_ns_get_by_index(struct phy_namespace *phy_ns,
+				       int phyindex)
+{
+	struct phy_device *phy;
+
+	mutex_lock(&phy_ns->ns_lock);
+	list_for_each_entry(phy, &phy_ns->phys, node)
+		if (phy->phyindex == phyindex)
+			goto unlock;
+
+	phy = NULL;
+unlock:
+	mutex_unlock(&phy_ns->ns_lock);
+	return phy;
+}
+EXPORT_SYMBOL_GPL(phy_ns_get_by_index);
+
+void phy_ns_add_phy(struct phy_namespace *phy_ns, struct phy_device *phy)
+{
+	/* PHYs can be attached and detached, they will keep their id */
+	if (!phy->phyindex)
+		phy->phyindex = phy_ns_next_phyindex(phy_ns);
+
+	mutex_lock(&phy_ns->ns_lock);
+	list_add(&phy->node, &phy_ns->phys);
+	mutex_unlock(&phy_ns->ns_lock);
+}
+EXPORT_SYMBOL_GPL(phy_ns_add_phy);
+
+void phy_ns_del_phy(struct phy_namespace *phy_ns, struct phy_device *phy)
+{
+	mutex_lock(&phy_ns->ns_lock);
+	list_del(&phy->node);
+	mutex_unlock(&phy_ns->ns_lock);
+}
+EXPORT_SYMBOL_GPL(phy_ns_del_phy);
+
+void phy_ns_init(struct phy_namespace *phy_ns)
+{
+	INIT_LIST_HEAD(&phy_ns->phys);
+	mutex_init(&phy_ns->ns_lock);
+}
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7..ef86cb87a38a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -43,6 +43,7 @@
 
 #include <linux/netdev_features.h>
 #include <linux/neighbour.h>
+#include <linux/phy_ns.h>
 #include <uapi/linux/netdevice.h>
 #include <uapi/linux/if_bonding.h>
 #include <uapi/linux/pkt_cls.h>
@@ -2380,6 +2381,7 @@ struct net_device {
 	struct netprio_map __rcu *priomap;
 #endif
 	struct phy_device	*phydev;
+	struct phy_namespace	phy_ns;
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 1351b802ffcf..b12fd33aa84a 100644
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
@@ -761,6 +764,7 @@ struct phy_device {
 	/* MACsec management functions */
 	const struct macsec_ops *macsec_ops;
 #endif
+	struct list_head node;
 };
 
 /* Generic phy_device::dev_flags */
diff --git a/include/linux/phy_ns.h b/include/linux/phy_ns.h
new file mode 100644
index 000000000000..ae173e637c62
--- /dev/null
+++ b/include/linux/phy_ns.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PHY device namespaces allow maintaining a list of PHY devices that are
+ * part of a netdevice's link topology. PHYs can for example be chained,
+ * as is the case when using a PHY that exposes an SFP module, on which an
+ * SFP transceiver that embeds a PHY is connected.
+ *
+ * This list can then be used by userspace to leverage individual PHY
+ * capabilities.
+ */
+#ifndef __PHY_NS_H
+#define __PHY_NS_H
+
+struct mutex;
+
+struct phy_namespace {
+	struct list_head phys;
+	int last_attributed_index;
+
+	/* Protects the .phys list */
+	struct mutex ns_lock;
+};
+
+struct phy_device *phy_ns_get_by_index(struct phy_namespace *phy_ns,
+				       int phyindex);
+void phy_ns_add_phy(struct phy_namespace *phy_ns, struct phy_device *phy);
+void phy_ns_del_phy(struct phy_namespace *phy_ns, struct phy_device *phy);
+void phy_ns_init(struct phy_namespace *phy_ns);
+
+#endif /* __PHY_NS_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..aa8b924269d7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10729,6 +10729,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	INIT_LIST_HEAD(&dev->net_notifier_list);
 #ifdef CONFIG_NET_SCHED
 	hash_init(dev->qdisc_hash);
+#endif
+#ifdef CONFIG_PHYLIB
+	phy_ns_init(&dev->phy_ns);
 #endif
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
-- 
2.41.0

