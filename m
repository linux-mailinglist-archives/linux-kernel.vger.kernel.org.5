Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F127EAC88
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjKNJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjKNJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:08:24 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A7D41;
        Tue, 14 Nov 2023 01:08:17 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A7C2C0004;
        Tue, 14 Nov 2023 09:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699952896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OwGcN79xETKZy+jJlv+sJ6YAfHIqez7LK9WRloxu4/k=;
        b=gVxg3zCK47zqTl+ZakUfYgh+mnh0Dz0Pg2jTUnT62mEsqlqZFZ9Oqt7xMLyfo/EtwomTez
        qtiw+aUf15ZpYd/ASv3jLaSCnmsXWPno779ajXsfHmnRUp5prtwKqISX6bgtaduSiD6gBP
        ZO5YikMQQxnPIXPQZSjUGffeVSOYK7OuNr6Oj8a6Rz+r0M3ssdmaoZOF4xxYlwI5xaJqNb
        VXz2jqYszV+oXS8wALzEfvqjeeVZ3n16SM2zowrjkZNOTSG9481sMQhssoNsbJYTpFc+cr
        +JzFH53xsJhe4U9Vi8uP4kfpc7rkqnXuXOxCGX7ECuA5vfROexQzubPkTfL9Fg==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH net-next v2 2/8] net: dsa: qca8k: Make the QCA8K hardware library available globally
Date:   Tue, 14 Nov 2023 10:07:28 +0100
Message-ID: <20231114090743.865453-3-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114090743.865453-1-romain.gantois@bootlin.com>
References: <20231114090743.865453-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm QCA8K Ethernet switch is already supported in the kernel, as a
DSA switch. However, the Qualcomm IPQ4019 SoC contains an internal modified
QCA8K switch that does not fit into the DSA model, since it uses an
out-of-band tagging protocol.

Move the qca8k.h header file out of the QCA8K DSA driver so that the
upcoming IPQ4019 QCA8K switchdev driver can include it.

Refactor qca8k-common into a separate module so that the IPQESS driver can
be built as a module.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/dsa/qca/Kconfig                   | 10 +++++
 drivers/net/dsa/qca/Makefile                  |  5 ++-
 drivers/net/dsa/qca/qca8k-8xxx.c              |  2 +-
 drivers/net/dsa/qca/qca8k-common.c            | 45 +++++++++++++++++--
 drivers/net/dsa/qca/qca8k-leds.c              |  2 +-
 .../net/dsa/qca => include/linux/dsa}/qca8k.h |  1 +
 6 files changed, 58 insertions(+), 7 deletions(-)
 rename {drivers/net/dsa/qca => include/linux/dsa}/qca8k.h (99%)

diff --git a/drivers/net/dsa/qca/Kconfig b/drivers/net/dsa/qca/Kconfig
index de9da469908b..37b8d938a7fc 100644
--- a/drivers/net/dsa/qca/Kconfig
+++ b/drivers/net/dsa/qca/Kconfig
@@ -11,6 +11,7 @@ config NET_DSA_AR9331
 config NET_DSA_QCA8K
 	tristate "Qualcomm Atheros QCA8K Ethernet switch family support"
 	select NET_DSA_TAG_QCA
+	select NET_DSA_QCA8K_LIB
 	select REGMAP
 	help
 	  This enables support for the Qualcomm Atheros QCA8K Ethernet
@@ -24,3 +25,12 @@ config NET_DSA_QCA8K_LEDS_SUPPORT
 	help
 	  This enabled support for LEDs present on the Qualcomm Atheros
 	  QCA8K Ethernet switch chips.
+
+config NET_DSA_QCA8K_LIB
+	tristate "Qualcomm Atheros QCA8K hardware support library"
+	select REGMAP
+	help
+	  This enables the hardware support library for the Qualcomm
+	  Atheros QCA8K Ethernet switch. It is used by the switchdev-based
+	  IPQ4019 integrated switch driver and by the DSA QCA8K switch
+	  driver.
diff --git a/drivers/net/dsa/qca/Makefile b/drivers/net/dsa/qca/Makefile
index ce66b1984e5f..05990339c04e 100644
--- a/drivers/net/dsa/qca/Makefile
+++ b/drivers/net/dsa/qca/Makefile
@@ -1,7 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NET_DSA_AR9331)	+= ar9331.o
 obj-$(CONFIG_NET_DSA_QCA8K)	+= qca8k.o
-qca8k-y 			+= qca8k-common.o qca8k-8xxx.o
+qca8k-y 			+= qca8k-8xxx.o
 ifdef CONFIG_NET_DSA_QCA8K_LEDS_SUPPORT
 qca8k-y				+= qca8k-leds.o
 endif
+
+obj-$(CONFIG_NET_DSA_QCA8K_LIB) += qca8k-lib.o
+qca8k-lib-y := qca8k-common.o
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ec57d9d52072..210667755b00 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -20,8 +20,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/etherdevice.h>
 #include <linux/dsa/tag_qca.h>
+#include <linux/dsa/qca8k.h>
 
-#include "qca8k.h"
 #include "qca8k_leds.h"
 
 static void
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 9243eff8918d..43a2fe05f73d 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -8,10 +8,9 @@
 
 #include <linux/netdevice.h>
 #include <net/dsa.h>
+#include <linux/dsa/qca8k.h>
 #include <linux/if_bridge.h>
 
-#include "qca8k.h"
-
 #define MIB_DESC(_s, _o, _n)	\
 	{			\
 		.size = (_s),	\
@@ -62,16 +61,19 @@ const struct qca8k_mib_desc ar8327_mib[] = {
 	MIB_DESC(1, 0xa8, "RXUnicast"),
 	MIB_DESC(1, 0xac, "TXUnicast"),
 };
+EXPORT_SYMBOL(ar8327_mib);
 
 int qca8k_read(struct qca8k_priv *priv, u32 reg, u32 *val)
 {
 	return regmap_read(priv->regmap, reg, val);
 }
+EXPORT_SYMBOL(qca8k_read);
 
 int qca8k_write(struct qca8k_priv *priv, u32 reg, u32 val)
 {
 	return regmap_write(priv->regmap, reg, val);
 }
+EXPORT_SYMBOL(qca8k_write);
 
 int qca8k_rmw(struct qca8k_priv *priv, u32 reg, u32 mask, u32 write_val)
 {
@@ -100,6 +102,7 @@ const struct regmap_access_table qca8k_readable_table = {
 	.yes_ranges = qca8k_readable_ranges,
 	.n_yes_ranges = ARRAY_SIZE(qca8k_readable_ranges),
 };
+EXPORT_SYMBOL(qca8k_readable_table);
 
 static int qca8k_busy_wait(struct qca8k_priv *priv, u32 reg, u32 mask)
 {
@@ -462,6 +465,7 @@ int qca8k_mib_init(struct qca8k_priv *priv)
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_mib_init);
 
 void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 {
@@ -476,6 +480,7 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 	else
 		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
 }
+EXPORT_SYMBOL(qca8k_port_set_status);
 
 void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		       uint8_t *data)
@@ -489,6 +494,7 @@ void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	for (i = 0; i < priv->info->mib_count; i++)
 		ethtool_sprintf(&data, "%s", ar8327_mib[i].name);
 }
+EXPORT_SYMBOL(qca8k_get_strings);
 
 void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 			     uint64_t *data)
@@ -522,6 +528,7 @@ void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 			data[i] |= (u64)hi << 32;
 	}
 }
+EXPORT_SYMBOL(qca8k_get_ethtool_stats);
 
 int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset)
 {
@@ -532,6 +539,7 @@ int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset)
 
 	return priv->info->mib_count;
 }
+EXPORT_SYMBOL(qca8k_get_sset_count);
 
 int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
 		      struct ethtool_eee *eee)
@@ -556,6 +564,7 @@ int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_set_mac_eee);
 
 int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 		      struct ethtool_eee *e)
@@ -563,6 +572,7 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 	/* Nothing to do on the port's MAC */
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_get_mac_eee);
 
 static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
 					 bool learning)
@@ -613,6 +623,7 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	qca8k_port_configure_learning(ds, port, learning);
 }
+EXPORT_SYMBOL(qca8k_port_stp_state_set);
 
 int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 				struct switchdev_brport_flags flags,
@@ -623,6 +634,7 @@ int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_pre_bridge_flags);
 
 int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
 			    struct switchdev_brport_flags flags,
@@ -639,6 +651,7 @@ int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_bridge_flags);
 
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 			   struct dsa_bridge bridge,
@@ -675,6 +688,7 @@ int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_port_bridge_join);
 
 void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
 			     struct dsa_bridge bridge)
@@ -703,6 +717,7 @@ void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
 	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
 		  QCA8K_PORT_LOOKUP_MEMBER, BIT(cpu_port));
 }
+EXPORT_SYMBOL(qca8k_port_bridge_leave);
 
 void qca8k_port_fast_age(struct dsa_switch *ds, int port)
 {
@@ -712,6 +727,7 @@ void qca8k_port_fast_age(struct dsa_switch *ds, int port)
 	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port);
 	mutex_unlock(&priv->reg_mutex);
 }
+EXPORT_SYMBOL(qca8k_port_fast_age);
 
 int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
@@ -732,6 +748,7 @@ int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 				  QCA8K_ATU_AGE_TIME_MASK,
 				  QCA8K_ATU_AGE_TIME(val));
 }
+EXPORT_SYMBOL(qca8k_set_ageing_time);
 
 int qca8k_port_enable(struct dsa_switch *ds, int port,
 		      struct phy_device *phy)
@@ -746,6 +763,7 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_enable);
 
 void qca8k_port_disable(struct dsa_switch *ds, int port)
 {
@@ -754,6 +772,7 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
 	qca8k_port_set_status(priv, port, 0);
 	priv->port_enabled_map &= ~BIT(port);
 }
+EXPORT_SYMBOL(qca8k_port_disable);
 
 int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
@@ -792,11 +811,13 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_port_change_mtu);
 
 int qca8k_port_max_mtu(struct dsa_switch *ds, int port)
 {
 	return QCA8K_MAX_MTU;
 }
+EXPORT_SYMBOL(qca8k_port_max_mtu);
 
 int qca8k_port_fdb_insert(struct qca8k_priv *priv, const u8 *addr,
 			  u16 port_mask, u16 vid)
@@ -808,6 +829,7 @@ int qca8k_port_fdb_insert(struct qca8k_priv *priv, const u8 *addr,
 	return qca8k_fdb_add(priv, addr, port_mask, vid,
 			     QCA8K_ATU_STATUS_STATIC);
 }
+EXPORT_SYMBOL(qca8k_port_fdb_insert);
 
 int qca8k_port_fdb_add(struct dsa_switch *ds, int port,
 		       const unsigned char *addr, u16 vid,
@@ -818,6 +840,7 @@ int qca8k_port_fdb_add(struct dsa_switch *ds, int port,
 
 	return qca8k_port_fdb_insert(priv, addr, port_mask, vid);
 }
+EXPORT_SYMBOL(qca8k_port_fdb_add);
 
 int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 		       const unsigned char *addr, u16 vid,
@@ -831,6 +854,7 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 
 	return qca8k_fdb_del(priv, addr, port_mask, vid);
 }
+EXPORT_SYMBOL(qca8k_port_fdb_del);
 
 int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 			dsa_fdb_dump_cb_t *cb, void *data)
@@ -854,6 +878,7 @@ int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_fdb_dump);
 
 int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
 		       const struct switchdev_obj_port_mdb *mdb,
@@ -869,6 +894,7 @@ int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
 	return qca8k_fdb_search_and_insert(priv, BIT(port), addr, vid,
 					   QCA8K_ATU_STATUS_STATIC);
 }
+EXPORT_SYMBOL(qca8k_port_mdb_add);
 
 int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 		       const struct switchdev_obj_port_mdb *mdb,
@@ -883,10 +909,11 @@ int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 
 	return qca8k_fdb_search_and_del(priv, BIT(port), addr, vid);
 }
+EXPORT_SYMBOL(qca8k_port_mdb_del);
 
 int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
-			  struct dsa_mall_mirror_tc_entry *mirror,
-			  bool ingress, struct netlink_ext_ack *extack)
+				 struct dsa_mall_mirror_tc_entry *mirror,
+				 bool ingress, struct netlink_ext_ack *extack)
 {
 	struct qca8k_priv *priv = ds->priv;
 	int monitor_port, ret;
@@ -938,6 +965,7 @@ int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_mirror_add);
 
 void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 			   struct dsa_mall_mirror_tc_entry *mirror)
@@ -974,6 +1002,7 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 err:
 	dev_err(priv->dev, "Failed to del mirror port from %d", port);
 }
+EXPORT_SYMBOL(qca8k_port_mirror_del);
 
 int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
 			      bool vlan_filtering,
@@ -994,6 +1023,7 @@ int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_port_vlan_filtering);
 
 int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_vlan *vlan,
@@ -1024,6 +1054,7 @@ int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_port_vlan_add);
 
 int qca8k_port_vlan_del(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_vlan *vlan)
@@ -1037,6 +1068,7 @@ int qca8k_port_vlan_del(struct dsa_switch *ds, int port,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_port_vlan_del);
 
 static bool qca8k_lag_can_offload(struct dsa_switch *ds,
 				  struct dsa_lag lag,
@@ -1207,12 +1239,14 @@ int qca8k_port_lag_join(struct dsa_switch *ds, int port, struct dsa_lag lag,
 
 	return qca8k_lag_refresh_portmap(ds, port, lag, false);
 }
+EXPORT_SYMBOL(qca8k_port_lag_join);
 
 int qca8k_port_lag_leave(struct dsa_switch *ds, int port,
 			 struct dsa_lag lag)
 {
 	return qca8k_lag_refresh_portmap(ds, port, lag, true);
 }
+EXPORT_SYMBOL(qca8k_port_lag_leave);
 
 int qca8k_read_switch_id(struct qca8k_priv *priv)
 {
@@ -1242,3 +1276,6 @@ int qca8k_read_switch_id(struct qca8k_priv *priv)
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_read_switch_id);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 90e30c2909e4..eca5abda5e77 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/dsa/qca8k.h>
 #include <net/dsa.h>
 
-#include "qca8k.h"
 #include "qca8k_leds.h"
 
 static u32 qca8k_phy_to_port(int phy)
diff --git a/drivers/net/dsa/qca/qca8k.h b/include/linux/dsa/qca8k.h
similarity index 99%
rename from drivers/net/dsa/qca/qca8k.h
rename to include/linux/dsa/qca8k.h
index 2ac7e88f8da5..3c75c3704fa0 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/include/linux/dsa/qca8k.h
@@ -13,6 +13,7 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/dsa/tag_qca.h>
+#include <net/dsa.h>
 
 #define QCA8K_ETHERNET_MDIO_PRIORITY			7
 #define QCA8K_ETHERNET_PHY_PRIORITY			6
-- 
2.42.0

