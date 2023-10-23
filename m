Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808157D3B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjJWPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjJWPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:50:17 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BAB101;
        Mon, 23 Oct 2023 08:50:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFBB81BF20D;
        Mon, 23 Oct 2023 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698076210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+NdzWvUbGq3zmLMsfefyovgECZPQbabjvtx+noQHsm8=;
        b=TiX0tkKlt9XAKxqYOxLClCzZ6R7kH7Ki41ma6yx8K7S7AuOFzzhoOpv3Rb+gxhbBGyS6GJ
        uWsPkGe/b2srWV7wN6yI1Q5cCaCI/l6zyqMb7J0aYYgRsqWOWUmVU6xr5b3IQf0KAciEPi
        P3sqYAwGWLwEEHMRCErkPwhfID1BKE3jmeL/ySUm2QYQA+0X1REE4xMIHnL9NGxudL5zoS
        JrQec8gYdHGvCdxYwEW0gO7dkSIiDDThpFY2C+1a3QJFz5XifDVkRxkB17zfeeF6Z2oUUh
        E4DqgOWDSKeAybD1PNL2sH8uvVQdwEN5X/xaQcmbO95ByiEdFotmK5fmK4gW5g==
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
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 2/5] net: dsa: qca: Make the QCA8K hardware library available globally
Date:   Mon, 23 Oct 2023 17:50:09 +0200
Message-ID: <20231023155013.512999-3-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023155013.512999-1-romain.gantois@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/dsa/qca/Kconfig                   | 10 ++
 drivers/net/dsa/qca/Makefile                  |  5 +-
 drivers/net/dsa/qca/qca8k-8xxx.c              |  2 +-
 drivers/net/dsa/qca/qca8k-common.c            | 97 +++++++++++++++----
 drivers/net/dsa/qca/qca8k-leds.c              |  2 +-
 .../net/dsa/qca => include/linux/dsa}/qca8k.h | 74 +++++++++++++-
 6 files changed, 167 insertions(+), 23 deletions(-)
 rename {drivers/net/dsa/qca => include/linux/dsa}/qca8k.h (87%)

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
index 4ce68e655a63..a11f4a6efef2 100644
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
index 9ff0a3c1cb91..aaa9c6785f13 100644
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
@@ -62,21 +61,37 @@ const struct qca8k_mib_desc ar8327_mib[] = {
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
 	return regmap_update_bits(priv->regmap, reg, mask, write_val);
 }
+EXPORT_SYMBOL(qca8k_rmw);
+
+int qca8k_set_bits(struct qca8k_priv *priv, u32 reg, u32 bits)
+{
+	return regmap_set_bits(priv->regmap, reg, bits);
+}
+EXPORT_SYMBOL(qca8k_set_bits);
+
+int qca8k_clear_bits(struct qca8k_priv *priv, u32 reg, u32 bits)
+{
+	return regmap_clear_bits(priv->regmap, reg, bits);
+}
+EXPORT_SYMBOL(qca8k_clear_bits);
 
 static const struct regmap_range qca8k_readable_ranges[] = {
 	regmap_reg_range(0x0000, 0x00e4), /* Global control */
@@ -100,6 +115,7 @@ const struct regmap_access_table qca8k_readable_table = {
 	.yes_ranges = qca8k_readable_ranges,
 	.n_yes_ranges = ARRAY_SIZE(qca8k_readable_ranges),
 };
+EXPORT_SYMBOL(qca8k_readable_table);
 
 static int qca8k_busy_wait(struct qca8k_priv *priv, u32 reg, u32 mask)
 {
@@ -161,8 +177,8 @@ static void qca8k_fdb_write(struct qca8k_priv *priv, u16 vid, u8 port_mask,
 			  QCA8K_ATU_TABLE_SIZE);
 }
 
-static int qca8k_fdb_access(struct qca8k_priv *priv, enum qca8k_fdb_cmd cmd,
-			    int port)
+int qca8k_fdb_access(struct qca8k_priv *priv, enum qca8k_fdb_cmd cmd,
+		     int port)
 {
 	u32 reg;
 	int ret;
@@ -196,9 +212,10 @@ static int qca8k_fdb_access(struct qca8k_priv *priv, enum qca8k_fdb_cmd cmd,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_fdb_access);
 
-static int qca8k_fdb_next(struct qca8k_priv *priv, struct qca8k_fdb *fdb,
-			  int port)
+int qca8k_fdb_next(struct qca8k_priv *priv, struct qca8k_fdb *fdb,
+		   int port)
 {
 	int ret;
 
@@ -209,6 +226,7 @@ static int qca8k_fdb_next(struct qca8k_priv *priv, struct qca8k_fdb *fdb,
 
 	return qca8k_fdb_read(priv, fdb);
 }
+EXPORT_SYMBOL(qca8k_fdb_next);
 
 static int qca8k_fdb_add(struct qca8k_priv *priv, const u8 *mac,
 			 u16 port_mask, u16 vid, u8 aging)
@@ -223,8 +241,8 @@ static int qca8k_fdb_add(struct qca8k_priv *priv, const u8 *mac,
 	return ret;
 }
 
-static int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
-			 u16 port_mask, u16 vid)
+int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
+		  u16 port_mask, u16 vid)
 {
 	int ret;
 
@@ -235,6 +253,7 @@ static int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_fdb_del);
 
 void qca8k_fdb_flush(struct qca8k_priv *priv)
 {
@@ -242,9 +261,10 @@ void qca8k_fdb_flush(struct qca8k_priv *priv)
 	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH, -1);
 	mutex_unlock(&priv->reg_mutex);
 }
+EXPORT_SYMBOL(qca8k_fdb_flush);
 
-static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
-				       const u8 *mac, u16 vid, u8 aging)
+int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
+				const u8 *mac, u16 vid, u8 aging)
 {
 	struct qca8k_fdb fdb = { 0 };
 	int ret;
@@ -265,10 +285,11 @@ static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
 		ret = qca8k_fdb_access(priv, QCA8K_FDB_PURGE, -1);
 		if (ret)
 			goto exit;
-	} else {
-		fdb.aging = aging;
 	}
 
+	/* Set aging */
+	fdb.aging = aging;
+
 	/* Add port to fdb portmask */
 	fdb.port_mask |= port_mask;
 
@@ -279,9 +300,10 @@ static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_fdb_search_and_insert);
 
-static int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
-				    const u8 *mac, u16 vid)
+int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
+			     const u8 *mac, u16 vid)
 {
 	struct qca8k_fdb fdb = { 0 };
 	int ret;
@@ -321,6 +343,7 @@ static int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_fdb_search_and_del);
 
 static int qca8k_vlan_access(struct qca8k_priv *priv,
 			     enum qca8k_vlan_cmd cmd, u16 vid)
@@ -355,8 +378,8 @@ static int qca8k_vlan_access(struct qca8k_priv *priv,
 	return 0;
 }
 
-static int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
-			  bool untagged)
+int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
+		   bool untagged)
 {
 	u32 reg;
 	int ret;
@@ -392,8 +415,9 @@ static int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_vlan_add);
 
-static int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid)
+int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid)
 {
 	u32 reg, mask;
 	int ret, i;
@@ -435,6 +459,7 @@ static int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid)
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_vlan_del);
 
 int qca8k_mib_init(struct qca8k_priv *priv)
 {
@@ -462,6 +487,7 @@ int qca8k_mib_init(struct qca8k_priv *priv)
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_mib_init);
 
 void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 {
@@ -476,6 +502,7 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 	else
 		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
 }
+EXPORT_SYMBOL(qca8k_port_set_status);
 
 void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		       uint8_t *data)
@@ -489,6 +516,7 @@ void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	for (i = 0; i < priv->info->mib_count; i++)
 		ethtool_sprintf(&data, "%s", ar8327_mib[i].name);
 }
+EXPORT_SYMBOL(qca8k_get_strings);
 
 void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 			     uint64_t *data)
@@ -522,6 +550,7 @@ void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 			data[i] |= (u64)hi << 32;
 	}
 }
+EXPORT_SYMBOL(qca8k_get_ethtool_stats);
 
 int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset)
 {
@@ -532,6 +561,7 @@ int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset)
 
 	return priv->info->mib_count;
 }
+EXPORT_SYMBOL(qca8k_get_sset_count);
 
 int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
 		      struct ethtool_eee *eee)
@@ -556,6 +586,7 @@ int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_set_mac_eee);
 
 int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 		      struct ethtool_eee *e)
@@ -563,6 +594,7 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 	/* Nothing to do on the port's MAC */
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_get_mac_eee);
 
 static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
 					 bool learning)
@@ -613,6 +645,7 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	qca8k_port_configure_learning(ds, port, learning);
 }
+EXPORT_SYMBOL(qca8k_port_stp_state_set);
 
 int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 				struct switchdev_brport_flags flags,
@@ -623,6 +656,7 @@ int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_pre_bridge_flags);
 
 int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
 			    struct switchdev_brport_flags flags,
@@ -639,6 +673,7 @@ int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_bridge_flags);
 
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 			   struct dsa_bridge bridge,
@@ -675,6 +710,7 @@ int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_port_bridge_join);
 
 void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
 			     struct dsa_bridge bridge)
@@ -703,6 +739,7 @@ void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
 	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
 		  QCA8K_PORT_LOOKUP_MEMBER, BIT(cpu_port));
 }
+EXPORT_SYMBOL(qca8k_port_bridge_leave);
 
 void qca8k_port_fast_age(struct dsa_switch *ds, int port)
 {
@@ -712,6 +749,7 @@ void qca8k_port_fast_age(struct dsa_switch *ds, int port)
 	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port);
 	mutex_unlock(&priv->reg_mutex);
 }
+EXPORT_SYMBOL(qca8k_port_fast_age);
 
 int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
@@ -732,6 +770,7 @@ int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 				  QCA8K_ATU_AGE_TIME_MASK,
 				  QCA8K_ATU_AGE_TIME(val));
 }
+EXPORT_SYMBOL(qca8k_set_ageing_time);
 
 int qca8k_port_enable(struct dsa_switch *ds, int port,
 		      struct phy_device *phy)
@@ -746,6 +785,7 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_enable);
 
 void qca8k_port_disable(struct dsa_switch *ds, int port)
 {
@@ -754,6 +794,7 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
 	qca8k_port_set_status(priv, port, 0);
 	priv->port_enabled_map &= ~BIT(port);
 }
+EXPORT_SYMBOL(qca8k_port_disable);
 
 int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
@@ -792,11 +833,13 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
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
@@ -808,6 +851,7 @@ int qca8k_port_fdb_insert(struct qca8k_priv *priv, const u8 *addr,
 	return qca8k_fdb_add(priv, addr, port_mask, vid,
 			     QCA8K_ATU_STATUS_STATIC);
 }
+EXPORT_SYMBOL(qca8k_port_fdb_insert);
 
 int qca8k_port_fdb_add(struct dsa_switch *ds, int port,
 		       const unsigned char *addr, u16 vid,
@@ -818,6 +862,7 @@ int qca8k_port_fdb_add(struct dsa_switch *ds, int port,
 
 	return qca8k_port_fdb_insert(priv, addr, port_mask, vid);
 }
+EXPORT_SYMBOL(qca8k_port_fdb_add);
 
 int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 		       const unsigned char *addr, u16 vid,
@@ -831,6 +876,7 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 
 	return qca8k_fdb_del(priv, addr, port_mask, vid);
 }
+EXPORT_SYMBOL(qca8k_port_fdb_del);
 
 int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 			dsa_fdb_dump_cb_t *cb, void *data)
@@ -854,6 +900,7 @@ int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_fdb_dump);
 
 int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
 		       const struct switchdev_obj_port_mdb *mdb,
@@ -869,6 +916,7 @@ int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
 	return qca8k_fdb_search_and_insert(priv, BIT(port), addr, vid,
 					   QCA8K_ATU_STATUS_STATIC);
 }
+EXPORT_SYMBOL(qca8k_port_mdb_add);
 
 int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 		       const struct switchdev_obj_port_mdb *mdb,
@@ -883,10 +931,11 @@ int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 
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
@@ -938,6 +987,7 @@ int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_port_mirror_add);
 
 void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 			   struct dsa_mall_mirror_tc_entry *mirror)
@@ -974,6 +1024,7 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 err:
 	dev_err(priv->dev, "Failed to del mirror port from %d", port);
 }
+EXPORT_SYMBOL(qca8k_port_mirror_del);
 
 int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
 			      bool vlan_filtering,
@@ -994,6 +1045,7 @@ int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_port_vlan_filtering);
 
 int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_vlan *vlan,
@@ -1024,6 +1076,7 @@ int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_port_vlan_add);
 
 int qca8k_port_vlan_del(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_vlan *vlan)
@@ -1037,6 +1090,7 @@ int qca8k_port_vlan_del(struct dsa_switch *ds, int port,
 
 	return ret;
 }
+EXPORT_SYMBOL(qca8k_port_vlan_del);
 
 static bool qca8k_lag_can_offload(struct dsa_switch *ds,
 				  struct dsa_lag lag,
@@ -1207,12 +1261,14 @@ int qca8k_port_lag_join(struct dsa_switch *ds, int port, struct dsa_lag lag,
 
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
@@ -1242,3 +1298,6 @@ int qca8k_read_switch_id(struct qca8k_priv *priv)
 
 	return 0;
 }
+EXPORT_SYMBOL(qca8k_read_switch_id);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index e8c16e76e34b..6500b5dd73de 100644
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
similarity index 87%
rename from drivers/net/dsa/qca/qca8k.h
rename to include/linux/dsa/qca8k.h
index 8f88b7db384d..42829aa1728a 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/include/linux/dsa/qca8k.h
@@ -13,6 +13,7 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/dsa/tag_qca.h>
+#include <net/dsa.h>
 
 #define QCA8K_ETHERNET_MDIO_PRIORITY			7
 #define QCA8K_ETHERNET_PHY_PRIORITY			6
@@ -265,6 +266,7 @@
 #define   QCA8K_PORT_LOOKUP_STATE_LEARNING		QCA8K_PORT_LOOKUP_STATE(0x3)
 #define   QCA8K_PORT_LOOKUP_STATE_FORWARD		QCA8K_PORT_LOOKUP_STATE(0x4)
 #define   QCA8K_PORT_LOOKUP_LEARN			BIT(20)
+#define   QCA8K_PORT_LOOKUP_LOOPBACK_EN			BIT(21)
 #define   QCA8K_PORT_LOOKUP_ING_MIRROR_EN		BIT(25)
 
 #define QCA8K_REG_GOL_TRUNK_CTRL0			0x700
@@ -341,6 +343,55 @@
 #define MII_ATH_MMD_ADDR				0x0d
 #define MII_ATH_MMD_DATA				0x0e
 
+/* IPQ4019 PSGMII PHY registers */
+#define QCA8K_IPQ4019_REG_RGMII_CTRL			0x004
+#define   QCA8K_IPQ4019_RGMII_CTRL_RGMII_RXC		GENMASK(1, 0)
+#define   QCA8K_IPQ4019_RGMII_CTRL_RGMII_TXC		GENMASK(9, 8)
+/* Some kind of CLK selection
+ * 0: gcc_ess_dly2ns
+ * 1: gcc_ess_clk
+ */
+#define   QCA8K_IPQ4019_RGMII_CTRL_CLK				BIT(10)
+#define   QCA8K_IPQ4019_RGMII_CTRL_DELAY_RMII0			GENMASK(17, 16)
+#define   QCA8K_IPQ4019_RGMII_CTRL_INVERT_RMII0_REF_CLK		BIT(18)
+#define   QCA8K_IPQ4019_RGMII_CTRL_DELAY_RMII1			GENMASK(20, 19)
+#define   QCA8K_IPQ4019_RGMII_CTRL_INVERT_RMII1_REF_CLK		BIT(21)
+#define   QCA8K_IPQ4019_RGMII_CTRL_INVERT_RMII0_MASTER_EN	BIT(24)
+#define   QCA8K_IPQ4019_RGMII_CTRL_INVERT_RMII1_MASTER_EN	BIT(25)
+
+#define PSGMIIPHY_MODE_CONTROL				0x1b4
+#define   PSGMIIPHY_MODE_ATHR_CSCO_MODE_25M		BIT(0)
+#define PSGMIIPHY_TX_CONTROL				0x288
+#define   PSGMIIPHY_TX_CONTROL_MAGIC_VALUE		0x8380
+#define PSGMIIPHY_VCO_CALIBRATION_CONTROL_REGISTER_1	0x9c
+#define   PSGMIIPHY_REG_PLL_VCO_CALIB_RESTART		BIT(14)
+#define PSGMIIPHY_VCO_CALIBRATION_CONTROL_REGISTER_2	0xa0
+#define   PSGMIIPHY_REG_PLL_VCO_CALIB_READY		BIT(0)
+
+#define   MII_QCA8075_SSTATUS				0x11
+#define   MII_QCA8075_SSTATUS_WAIT			8
+#define   MII_QCA8075_SSTATUS_TIMEOUT			800
+#define   QCA8075_PHY_SPEC_STATUS_LINK			BIT(10)
+#define   QCA8075_MMD7_CRC_AND_PKTS_COUNT		0x8029
+#define   QCA8075_MMD7_PKT_GEN_PKT_NUMB			0x8021
+#define   QCA8075_MMD7_PKT_GEN_PKT_SIZE			0x8062
+#define   QCA8075_MMD7_PKT_GEN_CTRL			0x8020
+#define   QCA8075_MMD7_CNT_SELFCLR			BIT(1)
+#define   QCA8075_MMD7_CNT_FRAME_CHK_EN			BIT(0)
+#define   QCA8075_MMD7_PKT_GEN_START			BIT(13)
+#define   QCA8075_MMD7_PKT_GEN_INPROGR			BIT(15)
+#define   QCA8075_MMD7_IG_FRAME_RECV_CNT_HI		0x802a
+#define   QCA8075_MMD7_IG_FRAME_RECV_CNT_LO		0x802b
+#define   QCA8075_MMD7_IG_FRAME_ERR_CNT			0x802c
+#define   QCA8075_MMD7_EG_FRAME_RECV_CNT_HI		0x802d
+#define   QCA8075_MMD7_EG_FRAME_RECV_CNT_LO		0x802e
+#define   QCA8075_MMD7_EG_FRAME_ERR_CNT			0x802f
+#define   QCA8075_MMD7_MDIO_BRDCST_WRITE		0x8028
+#define   QCA8075_MMD7_MDIO_BRDCST_WRITE_EN  BIT(15)
+#define   QCA8075_MDIO_BRDCST_PHY_ADDR			0x1f
+#define   QCA8075_PKT_GEN_PKTS_COUNT			4096
+#define   QCA8075_PKT_GEN_PKTS_SIZE			1504
+
 enum {
 	QCA8K_PORT_SPEED_10M = 0,
 	QCA8K_PORT_SPEED_100M = 1,
@@ -466,6 +517,11 @@ struct qca8k_priv {
 	struct qca8k_pcs pcs_port_6;
 	const struct qca8k_match_data *info;
 	struct qca8k_led ports_led[QCA8K_LED_COUNT];
+
+	/* IPQ4019 specific */
+	struct regmap *psgmii;
+	struct phy_device *psgmii_ethphy;
+	atomic_t psgmii_calibrated;
 };
 
 struct qca8k_mib_desc {
@@ -506,6 +562,8 @@ int qca8k_read_switch_id(struct qca8k_priv *priv);
 int qca8k_read(struct qca8k_priv *priv, u32 reg, u32 *val);
 int qca8k_write(struct qca8k_priv *priv, u32 reg, u32 val);
 int qca8k_rmw(struct qca8k_priv *priv, u32 reg, u32 mask, u32 write_val);
+int qca8k_set_bits(struct qca8k_priv *priv, u32 reg, u32 bits);
+int qca8k_clear_bits(struct qca8k_priv *priv, u32 reg, u32 bits);
 
 /* Common ops function */
 void qca8k_fdb_flush(struct qca8k_priv *priv);
@@ -559,6 +617,16 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 		       struct dsa_db db);
 int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 			dsa_fdb_dump_cb_t *cb, void *data);
+int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
+		  u16 port_mask, u16 vid);
+int qca8k_fdb_next(struct qca8k_priv *priv, struct qca8k_fdb *fdb,
+		   int port);
+int qca8k_fdb_access(struct qca8k_priv *priv, enum qca8k_fdb_cmd cmd,
+		     int port);
+int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
+				const u8 *mac, u16 vid, u8 aging);
+int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
+			     const u8 *mac, u16 vid);
 
 /* Common MDB function */
 int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
@@ -576,8 +644,12 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 			   struct dsa_mall_mirror_tc_entry *mirror);
 
 /* Common port VLAN function */
-int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
+int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
+			      bool vlan_filtering,
 			      struct netlink_ext_ack *extack);
+int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
+		   bool untagged);
+int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid);
 int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_vlan *vlan,
 			struct netlink_ext_ack *extack);
-- 
2.42.0

