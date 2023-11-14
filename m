Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380947EAC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjKNJIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjKNJIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:08:30 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC2D56;
        Tue, 14 Nov 2023 01:08:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 959CAC000D;
        Tue, 14 Nov 2023 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699952898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcHkg2utZJkNow9gGS8+ZrCAW5lieoMDGWgRwpA5ePY=;
        b=ht7GUMpmVCWImqc8WBTexkV1pg+mIE2PYZHBgvmKFYZhnfLXMCwCdYM5XlEzr8bNjJqfnC
        qUrF4PCRdz4U53/9KNt2vACHa3l87BKc1rJcEou+APwXFQwL/5fTnLcRsnUAE95fTArof0
        YM83bghH+2QX1RFAdw9qJ9/s5jFGcog4YiCT/leOHjIiy05Lqfsmg8KmPjLwLfazyWPqYW
        eG2LhqBcSa2xCP3xy4cZwSg3CibdVO/nPWxWPgxZqPcYJ2QCSXsLauwxu7GaEF82RtpdZ1
        zvSSlQThvb9XQPhHvuodFPBb3eMYyCgwASVGXNnuRNUHlJ8WA+ShJJuVwTfAYg==
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
Subject: [PATCH net-next v2 3/8] net: qualcomm: ipqess: introduce the Qualcomm IPQESS driver
Date:   Tue, 14 Nov 2023 10:07:29 +0100
Message-ID: <20231114090743.865453-4-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114090743.865453-1-romain.gantois@bootlin.com>
References: <20231114090743.865453-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm IPQ4019 Ethernet Switch Subsystem for the IPQ4019 chip
includes an internal Ethernet switch based on the QCA8K IP.

The CPU-to-switch port data plane depends on the IPQESS EDMA Controller,
a simple 1G Ethernet controller. It is connected to the switch through an
internal link, and doesn't expose directly any external interface.

The EDMA controller has 16 RX and TX queues, with a very basic RSS fanout
configured at init time.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 MAINTAINERS                                   |    7 +
 drivers/net/dsa/qca/qca8k-common.c            |  119 +-
 drivers/net/ethernet/qualcomm/Kconfig         |   14 +
 drivers/net/ethernet/qualcomm/Makefile        |    2 +
 drivers/net/ethernet/qualcomm/ipqess/Makefile |    8 +
 .../ethernet/qualcomm/ipqess/ipqess_edma.c    | 1188 +++++++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_edma.h    |  488 +++++++
 .../qualcomm/ipqess/ipqess_notifiers.h        |   29 +
 .../ethernet/qualcomm/ipqess/ipqess_port.c    |  757 +++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_port.h    |   62 +
 .../ethernet/qualcomm/ipqess/ipqess_switch.c  |  546 ++++++++
 .../ethernet/qualcomm/ipqess/ipqess_switch.h  |   36 +
 include/linux/dsa/qca8k.h                     |   47 +-
 13 files changed, 3253 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/Makefile
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 350d00657f6b..ff5b0565c301 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17965,6 +17965,13 @@ F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
 F:	drivers/mailbox/qcom-ipcc.c
 F:	include/dt-bindings/mailbox/qcom-ipcc.h
 
+QUALCOMM IPQ4019 ESS DRIVER
+M:	Romain Gantois <romain.gantois@bootlin.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
+F:	drivers/net/ethernet/qualcomm/ipqess/
+
 QUALCOMM IPQ4019 USB PHY DRIVER
 M:	Robert Marko <robert.marko@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 43a2fe05f73d..a66a821ce4d6 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -61,24 +61,37 @@ const struct qca8k_mib_desc ar8327_mib[] = {
 	MIB_DESC(1, 0xa8, "RXUnicast"),
 	MIB_DESC(1, 0xac, "TXUnicast"),
 };
-EXPORT_SYMBOL(ar8327_mib);
+EXPORT_SYMBOL_GPL(ar8327_mib);
 
 int qca8k_read(struct qca8k_priv *priv, u32 reg, u32 *val)
 {
 	return regmap_read(priv->regmap, reg, val);
 }
-EXPORT_SYMBOL(qca8k_read);
+EXPORT_SYMBOL_GPL(qca8k_read);
 
 int qca8k_write(struct qca8k_priv *priv, u32 reg, u32 val)
 {
 	return regmap_write(priv->regmap, reg, val);
 }
-EXPORT_SYMBOL(qca8k_write);
+EXPORT_SYMBOL_GPL(qca8k_write);
 
 int qca8k_rmw(struct qca8k_priv *priv, u32 reg, u32 mask, u32 write_val)
 {
 	return regmap_update_bits(priv->regmap, reg, mask, write_val);
 }
+EXPORT_SYMBOL_GPL(qca8k_rmw);
+
+int qca8k_set_bits(struct qca8k_priv *priv, u32 reg, u32 bits)
+{
+	return regmap_set_bits(priv->regmap, reg, bits);
+}
+EXPORT_SYMBOL_GPL(qca8k_set_bits);
+
+int qca8k_clear_bits(struct qca8k_priv *priv, u32 reg, u32 bits)
+{
+	return regmap_clear_bits(priv->regmap, reg, bits);
+}
+EXPORT_SYMBOL_GPL(qca8k_clear_bits);
 
 static const struct regmap_range qca8k_readable_ranges[] = {
 	regmap_reg_range(0x0000, 0x00e4), /* Global control */
@@ -102,7 +115,7 @@ const struct regmap_access_table qca8k_readable_table = {
 	.yes_ranges = qca8k_readable_ranges,
 	.n_yes_ranges = ARRAY_SIZE(qca8k_readable_ranges),
 };
-EXPORT_SYMBOL(qca8k_readable_table);
+EXPORT_SYMBOL_GPL(qca8k_readable_table);
 
 static int qca8k_busy_wait(struct qca8k_priv *priv, u32 reg, u32 mask)
 {
@@ -164,8 +177,8 @@ static void qca8k_fdb_write(struct qca8k_priv *priv, u16 vid, u8 port_mask,
 			  QCA8K_ATU_TABLE_SIZE);
 }
 
-static int qca8k_fdb_access(struct qca8k_priv *priv, enum qca8k_fdb_cmd cmd,
-			    int port)
+int qca8k_fdb_access(struct qca8k_priv *priv, enum qca8k_fdb_cmd cmd,
+		     int port)
 {
 	u32 reg;
 	int ret;
@@ -199,9 +212,10 @@ static int qca8k_fdb_access(struct qca8k_priv *priv, enum qca8k_fdb_cmd cmd,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(qca8k_fdb_access);
 
-static int qca8k_fdb_next(struct qca8k_priv *priv, struct qca8k_fdb *fdb,
-			  int port)
+int qca8k_fdb_next(struct qca8k_priv *priv, struct qca8k_fdb *fdb,
+		   int port)
 {
 	int ret;
 
@@ -212,6 +226,7 @@ static int qca8k_fdb_next(struct qca8k_priv *priv, struct qca8k_fdb *fdb,
 
 	return qca8k_fdb_read(priv, fdb);
 }
+EXPORT_SYMBOL_GPL(qca8k_fdb_next);
 
 static int qca8k_fdb_add(struct qca8k_priv *priv, const u8 *mac,
 			 u16 port_mask, u16 vid, u8 aging)
@@ -226,8 +241,8 @@ static int qca8k_fdb_add(struct qca8k_priv *priv, const u8 *mac,
 	return ret;
 }
 
-static int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
-			 u16 port_mask, u16 vid)
+int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
+		  u16 port_mask, u16 vid)
 {
 	int ret;
 
@@ -238,6 +253,7 @@ static int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(qca8k_fdb_del);
 
 void qca8k_fdb_flush(struct qca8k_priv *priv)
 {
@@ -245,9 +261,10 @@ void qca8k_fdb_flush(struct qca8k_priv *priv)
 	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH, -1);
 	mutex_unlock(&priv->reg_mutex);
 }
+EXPORT_SYMBOL_GPL(qca8k_fdb_flush);
 
-static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
-				       const u8 *mac, u16 vid, u8 aging)
+int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
+				const u8 *mac, u16 vid, u8 aging)
 {
 	struct qca8k_fdb fdb = { 0 };
 	int ret;
@@ -282,9 +299,10 @@ static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(qca8k_fdb_search_and_insert);
 
-static int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
-				    const u8 *mac, u16 vid)
+int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
+			     const u8 *mac, u16 vid)
 {
 	struct qca8k_fdb fdb = { 0 };
 	int ret;
@@ -324,6 +342,7 @@ static int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(qca8k_fdb_search_and_del);
 
 static int qca8k_vlan_access(struct qca8k_priv *priv,
 			     enum qca8k_vlan_cmd cmd, u16 vid)
@@ -358,8 +377,8 @@ static int qca8k_vlan_access(struct qca8k_priv *priv,
 	return 0;
 }
 
-static int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
-			  bool untagged)
+int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
+		   bool untagged)
 {
 	u32 reg;
 	int ret;
@@ -395,8 +414,9 @@ static int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(qca8k_vlan_add);
 
-static int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid)
+int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid)
 {
 	u32 reg, mask;
 	int ret, i;
@@ -438,6 +458,7 @@ static int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(qca8k_vlan_del);
 
 int qca8k_mib_init(struct qca8k_priv *priv)
 {
@@ -465,7 +486,7 @@ int qca8k_mib_init(struct qca8k_priv *priv)
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
-EXPORT_SYMBOL(qca8k_mib_init);
+EXPORT_SYMBOL_GPL(qca8k_mib_init);
 
 void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 {
@@ -480,7 +501,7 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 	else
 		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
 }
-EXPORT_SYMBOL(qca8k_port_set_status);
+EXPORT_SYMBOL_GPL(qca8k_port_set_status);
 
 void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		       uint8_t *data)
@@ -494,7 +515,7 @@ void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	for (i = 0; i < priv->info->mib_count; i++)
 		ethtool_sprintf(&data, "%s", ar8327_mib[i].name);
 }
-EXPORT_SYMBOL(qca8k_get_strings);
+EXPORT_SYMBOL_GPL(qca8k_get_strings);
 
 void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 			     uint64_t *data)
@@ -528,7 +549,7 @@ void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 			data[i] |= (u64)hi << 32;
 	}
 }
-EXPORT_SYMBOL(qca8k_get_ethtool_stats);
+EXPORT_SYMBOL_GPL(qca8k_get_ethtool_stats);
 
 int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset)
 {
@@ -539,7 +560,7 @@ int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset)
 
 	return priv->info->mib_count;
 }
-EXPORT_SYMBOL(qca8k_get_sset_count);
+EXPORT_SYMBOL_GPL(qca8k_get_sset_count);
 
 int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
 		      struct ethtool_eee *eee)
@@ -564,7 +585,7 @@ int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_mutex);
 	return ret;
 }
-EXPORT_SYMBOL(qca8k_set_mac_eee);
+EXPORT_SYMBOL_GPL(qca8k_set_mac_eee);
 
 int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 		      struct ethtool_eee *e)
@@ -572,7 +593,7 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 	/* Nothing to do on the port's MAC */
 	return 0;
 }
-EXPORT_SYMBOL(qca8k_get_mac_eee);
+EXPORT_SYMBOL_GPL(qca8k_get_mac_eee);
 
 static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
 					 bool learning)
@@ -623,7 +644,7 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	qca8k_port_configure_learning(ds, port, learning);
 }
-EXPORT_SYMBOL(qca8k_port_stp_state_set);
+EXPORT_SYMBOL_GPL(qca8k_port_stp_state_set);
 
 int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 				struct switchdev_brport_flags flags,
@@ -634,7 +655,7 @@ int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 
 	return 0;
 }
-EXPORT_SYMBOL(qca8k_port_pre_bridge_flags);
+EXPORT_SYMBOL_GPL(qca8k_port_pre_bridge_flags);
 
 int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
 			    struct switchdev_brport_flags flags,
@@ -651,7 +672,7 @@ int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
 
 	return 0;
 }
-EXPORT_SYMBOL(qca8k_port_bridge_flags);
+EXPORT_SYMBOL_GPL(qca8k_port_bridge_flags);
 
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 			   struct dsa_bridge bridge,
@@ -688,7 +709,7 @@ int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 
 	return ret;
 }
-EXPORT_SYMBOL(qca8k_port_bridge_join);
+EXPORT_SYMBOL_GPL(qca8k_port_bridge_join);
 
 void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
 			     struct dsa_bridge bridge)
@@ -717,7 +738,7 @@ void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
 	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
 		  QCA8K_PORT_LOOKUP_MEMBER, BIT(cpu_port));
 }
-EXPORT_SYMBOL(qca8k_port_bridge_leave);
+EXPORT_SYMBOL_GPL(qca8k_port_bridge_leave);
 
 void qca8k_port_fast_age(struct dsa_switch *ds, int port)
 {
@@ -727,7 +748,7 @@ void qca8k_port_fast_age(struct dsa_switch *ds, int port)
 	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port);
 	mutex_unlock(&priv->reg_mutex);
 }
-EXPORT_SYMBOL(qca8k_port_fast_age);
+EXPORT_SYMBOL_GPL(qca8k_port_fast_age);
 
 int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
@@ -748,7 +769,7 @@ int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 				  QCA8K_ATU_AGE_TIME_MASK,
 				  QCA8K_ATU_AGE_TIME(val));
 }
-EXPORT_SYMBOL(qca8k_set_ageing_time);
+EXPORT_SYMBOL_GPL(qca8k_set_ageing_time);
 
 int qca8k_port_enable(struct dsa_switch *ds, int port,
 		      struct phy_device *phy)
@@ -763,7 +784,7 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
 
 	return 0;
 }
-EXPORT_SYMBOL(qca8k_port_enable);
+EXPORT_SYMBOL_GPL(qca8k_port_enable);
 
 void qca8k_port_disable(struct dsa_switch *ds, int port)
 {
@@ -772,7 +793,7 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
 	qca8k_port_set_status(priv, port, 0);
 	priv->port_enabled_map &= ~BIT(port);
 }
-EXPORT_SYMBOL(qca8k_port_disable);
+EXPORT_SYMBOL_GPL(qca8k_port_disable);
 
 int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
@@ -811,13 +832,13 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
 	return ret;
 }
-EXPORT_SYMBOL(qca8k_port_change_mtu);
+EXPORT_SYMBOL_GPL(qca8k_port_change_mtu);
 
 int qca8k_port_max_mtu(struct dsa_switch *ds, int port)
 {
 	return QCA8K_MAX_MTU;
 }
-EXPORT_SYMBOL(qca8k_port_max_mtu);
+EXPORT_SYMBOL_GPL(qca8k_port_max_mtu);
 
 int qca8k_port_fdb_insert(struct qca8k_priv *priv, const u8 *addr,
 			  u16 port_mask, u16 vid)
@@ -829,7 +850,7 @@ int qca8k_port_fdb_insert(struct qca8k_priv *priv, const u8 *addr,
 	return qca8k_fdb_add(priv, addr, port_mask, vid,
 			     QCA8K_ATU_STATUS_STATIC);
 }
-EXPORT_SYMBOL(qca8k_port_fdb_insert);
+EXPORT_SYMBOL_GPL(qca8k_port_fdb_insert);
 
 int qca8k_port_fdb_add(struct dsa_switch *ds, int port,
 		       const unsigned char *addr, u16 vid,
@@ -840,7 +861,7 @@ int qca8k_port_fdb_add(struct dsa_switch *ds, int port,
 
 	return qca8k_port_fdb_insert(priv, addr, port_mask, vid);
 }
-EXPORT_SYMBOL(qca8k_port_fdb_add);
+EXPORT_SYMBOL_GPL(qca8k_port_fdb_add);
 
 int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 		       const unsigned char *addr, u16 vid,
@@ -854,7 +875,7 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
 
 	return qca8k_fdb_del(priv, addr, port_mask, vid);
 }
-EXPORT_SYMBOL(qca8k_port_fdb_del);
+EXPORT_SYMBOL_GPL(qca8k_port_fdb_del);
 
 int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 			dsa_fdb_dump_cb_t *cb, void *data)
@@ -878,7 +899,7 @@ int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 
 	return 0;
 }
-EXPORT_SYMBOL(qca8k_port_fdb_dump);
+EXPORT_SYMBOL_GPL(qca8k_port_fdb_dump);
 
 int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
 		       const struct switchdev_obj_port_mdb *mdb,
@@ -894,7 +915,7 @@ int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
 	return qca8k_fdb_search_and_insert(priv, BIT(port), addr, vid,
 					   QCA8K_ATU_STATUS_STATIC);
 }
-EXPORT_SYMBOL(qca8k_port_mdb_add);
+EXPORT_SYMBOL_GPL(qca8k_port_mdb_add);
 
 int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 		       const struct switchdev_obj_port_mdb *mdb,
@@ -909,7 +930,7 @@ int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 
 	return qca8k_fdb_search_and_del(priv, BIT(port), addr, vid);
 }
-EXPORT_SYMBOL(qca8k_port_mdb_del);
+EXPORT_SYMBOL_GPL(qca8k_port_mdb_del);
 
 int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
 				 struct dsa_mall_mirror_tc_entry *mirror,
@@ -965,7 +986,7 @@ int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
 
 	return 0;
 }
-EXPORT_SYMBOL(qca8k_port_mirror_add);
+EXPORT_SYMBOL_GPL(qca8k_port_mirror_add);
 
 void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 			   struct dsa_mall_mirror_tc_entry *mirror)
@@ -1002,7 +1023,7 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 err:
 	dev_err(priv->dev, "Failed to del mirror port from %d", port);
 }
-EXPORT_SYMBOL(qca8k_port_mirror_del);
+EXPORT_SYMBOL_GPL(qca8k_port_mirror_del);
 
 int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
 			      bool vlan_filtering,
@@ -1023,7 +1044,7 @@ int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
 
 	return ret;
 }
-EXPORT_SYMBOL(qca8k_port_vlan_filtering);
+EXPORT_SYMBOL_GPL(qca8k_port_vlan_filtering);
 
 int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_vlan *vlan,
@@ -1054,7 +1075,7 @@ int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
 
 	return ret;
 }
-EXPORT_SYMBOL(qca8k_port_vlan_add);
+EXPORT_SYMBOL_GPL(qca8k_port_vlan_add);
 
 int qca8k_port_vlan_del(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_vlan *vlan)
@@ -1068,7 +1089,7 @@ int qca8k_port_vlan_del(struct dsa_switch *ds, int port,
 
 	return ret;
 }
-EXPORT_SYMBOL(qca8k_port_vlan_del);
+EXPORT_SYMBOL_GPL(qca8k_port_vlan_del);
 
 static bool qca8k_lag_can_offload(struct dsa_switch *ds,
 				  struct dsa_lag lag,
@@ -1239,14 +1260,14 @@ int qca8k_port_lag_join(struct dsa_switch *ds, int port, struct dsa_lag lag,
 
 	return qca8k_lag_refresh_portmap(ds, port, lag, false);
 }
-EXPORT_SYMBOL(qca8k_port_lag_join);
+EXPORT_SYMBOL_GPL(qca8k_port_lag_join);
 
 int qca8k_port_lag_leave(struct dsa_switch *ds, int port,
 			 struct dsa_lag lag)
 {
 	return qca8k_lag_refresh_portmap(ds, port, lag, true);
 }
-EXPORT_SYMBOL(qca8k_port_lag_leave);
+EXPORT_SYMBOL_GPL(qca8k_port_lag_leave);
 
 int qca8k_read_switch_id(struct qca8k_priv *priv)
 {
@@ -1276,6 +1297,6 @@ int qca8k_read_switch_id(struct qca8k_priv *priv)
 
 	return 0;
 }
-EXPORT_SYMBOL(qca8k_read_switch_id);
+EXPORT_SYMBOL_GPL(qca8k_read_switch_id);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index 9210ff360fdc..008d20ec9eae 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -61,6 +61,20 @@ config QCOM_EMAC
 	  low power, Receive-Side Scaling (RSS), and IEEE 1588-2008
 	  Precision Clock Synchronization Protocol.
 
+config QCOM_IPQ4019_ESS
+	tristate "Qualcomm Atheros IPQ4019 Ethernet Switch Subsystem support"
+	depends on (OF && ARCH_QCOM) || COMPILE_TEST
+	select PHYLINK
+	select NET_DSA
+	select NET_DSA_QCA8K_LIB
+	select PAGE_POOL
+	help
+	  This driver supports the Qualcomm Atheros IPQ40xx built-in
+	  Ethernet Switch Subsystem.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ipqess.
+
 source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
 
 endif # NET_VENDOR_QUALCOMM
diff --git a/drivers/net/ethernet/qualcomm/Makefile b/drivers/net/ethernet/qualcomm/Makefile
index 9250976dd884..63c62704a62d 100644
--- a/drivers/net/ethernet/qualcomm/Makefile
+++ b/drivers/net/ethernet/qualcomm/Makefile
@@ -12,3 +12,5 @@ qcauart-objs := qca_uart.o
 obj-y += emac/
 
 obj-$(CONFIG_RMNET) += rmnet/
+
+obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess/
diff --git a/drivers/net/ethernet/qualcomm/ipqess/Makefile b/drivers/net/ethernet/qualcomm/ipqess/Makefile
new file mode 100644
index 000000000000..f389080cc5aa
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the IPQ ESS driver
+#
+
+obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess.o
+
+ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_edma.o
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
new file mode 100644
index 000000000000..008e92de9eb7
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
@@ -0,0 +1,1188 @@
+// SPDX-License-Identifier: GPL-2.0 OR ISC
+/* Copyright (c) 2014 - 2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017 - 2018, John Crispin <john@phrozen.org>
+ * Copyright (c) 2018 - 2019, Christian Lamparter <chunkeey@gmail.com>
+ * Copyright (c) 2020 - 2021, Gabor Juhos <j4g8y7@gmail.com>
+ * Copyright (c) 2021 - 2022, Maxime Chevallier <maxime.chevallier@bootlin.com>
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/of_net.h>
+#include <linux/skbuff.h>
+#include <linux/if_vlan.h>
+#include <linux/reset.h>
+#include <linux/of_platform.h>
+#include <net/ip6_checksum.h>
+#include <net/dst_metadata.h>
+#include <net/page_pool/helpers.h>
+
+#include "ipqess_edma.h"
+#include "ipqess_port.h"
+#include "ipqess_switch.h"
+
+static void ipqess_edma_w32(struct ipqess_edma *edma, u32 reg, u32 val)
+{
+	writel(val, edma->hw_addr + reg);
+}
+
+static u32 ipqess_edma_r32(struct ipqess_edma *edma, u16 reg)
+{
+	return readl(edma->hw_addr + reg);
+}
+
+static void ipqess_edma_m32(struct ipqess_edma *edma, u32 mask, u32 val,
+			    u16 reg)
+{
+	u32 _val = ipqess_edma_r32(edma, reg);
+
+	_val &= ~mask;
+	_val |= val;
+
+	ipqess_edma_w32(edma, reg, _val);
+}
+
+static int ipqess_edma_tx_ring_alloc(struct ipqess_edma *edma)
+{
+	struct device *dev = &edma->pdev->dev;
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		struct ipqess_edma_tx_ring *tx_ring = &edma->tx_ring[i];
+		size_t size;
+		u32 idx;
+
+		tx_ring->edma = edma;
+		tx_ring->ring_id = i;
+		tx_ring->idx = i * 4;
+		tx_ring->count = IPQESS_EDMA_TX_RING_SIZE;
+		tx_ring->nq = netdev_get_tx_queue(edma->netdev, i);
+
+		size = sizeof(struct ipqess_edma_buf) * IPQESS_EDMA_TX_RING_SIZE;
+		tx_ring->buf = devm_kzalloc(dev, size, GFP_KERNEL);
+		if (!tx_ring->buf)
+			return -ENOMEM;
+
+		size = sizeof(struct ipqess_edma_tx_desc) * IPQESS_EDMA_TX_RING_SIZE;
+		tx_ring->desc = dmam_alloc_coherent(dev, size, &tx_ring->ring_dma,
+						    GFP_KERNEL);
+		if (!tx_ring->desc)
+			return -ENOMEM;
+
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_TPD_BASE_ADDR_Q(tx_ring->idx),
+				(u32)tx_ring->ring_dma);
+
+		idx = ipqess_edma_r32(edma, IPQESS_EDMA_REG_TPD_IDX_Q(tx_ring->idx));
+		idx >>= IPQESS_EDMA_TPD_CONS_IDX_SHIFT; /* need u32 here */
+		idx &= 0xffff;
+		tx_ring->head = idx;
+		tx_ring->tail = idx;
+
+		ipqess_edma_m32(edma,
+				IPQESS_EDMA_TPD_PROD_IDX_MASK
+					<< IPQESS_EDMA_TPD_PROD_IDX_SHIFT,
+				idx, IPQESS_EDMA_REG_TPD_IDX_Q(tx_ring->idx));
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_TX_SW_CONS_IDX_Q(tx_ring->idx),
+				idx);
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_TPD_RING_SIZE,
+				IPQESS_EDMA_TX_RING_SIZE);
+	}
+
+	return 0;
+}
+
+static int ipqess_edma_tx_unmap_and_free(struct device *dev,
+					 struct ipqess_edma_buf *buf)
+{
+	int len = 0;
+
+	if (buf->flags & IPQESS_EDMA_DESC_SINGLE)
+		dma_unmap_single(dev, buf->dma,	buf->length, DMA_TO_DEVICE);
+	else if (buf->flags & IPQESS_EDMA_DESC_PAGE)
+		dma_unmap_page(dev, buf->dma, buf->length, DMA_TO_DEVICE);
+
+	if (buf->flags & IPQESS_EDMA_DESC_LAST) {
+		len = buf->skb->len;
+		dev_kfree_skb_any(buf->skb);
+	}
+
+	buf->flags = 0;
+
+	return len;
+}
+
+static void ipqess_edma_tx_ring_free(struct ipqess_edma *edma)
+{
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		int j;
+
+		if (edma->tx_ring[i].desc)
+			continue;
+
+		for (j = 0; j < IPQESS_EDMA_TX_RING_SIZE; j++) {
+			struct ipqess_edma_buf *buf = &edma->tx_ring[i].buf[j];
+
+			ipqess_edma_tx_unmap_and_free(&edma->pdev->dev, buf);
+		}
+
+		edma->tx_ring[i].buf = NULL;
+	}
+}
+
+static int ipqess_edma_rx_buf_prepare(struct ipqess_edma_buf *buf,
+				      struct ipqess_edma_rx_ring *rx_ring)
+{
+	memset(buf->skb->data, 0, sizeof(struct ipqess_edma_rx_desc));
+
+	buf->dma = dma_map_single(rx_ring->ppdev, buf->skb->data,
+				  IPQESS_EDMA_RX_HEAD_BUFF_SIZE,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(rx_ring->ppdev, buf->dma)) {
+		dev_kfree_skb_any(buf->skb);
+		buf->skb = NULL;
+		return -EFAULT;
+	}
+
+	buf->length = IPQESS_EDMA_RX_HEAD_BUFF_SIZE;
+	rx_ring->desc_dma[rx_ring->head] = buf->dma;
+	rx_ring->head = (rx_ring->head + 1) % IPQESS_EDMA_RX_RING_SIZE;
+
+	ipqess_edma_m32(rx_ring->edma, IPQESS_EDMA_RFD_PROD_IDX_BITS,
+			(rx_ring->head + IPQESS_EDMA_RX_RING_SIZE - 1)
+			% IPQESS_EDMA_RX_RING_SIZE,
+			IPQESS_EDMA_REG_RFD_IDX_Q(rx_ring->idx));
+
+	return 0;
+}
+
+/* locking is handled by the caller */
+static int ipqess_edma_rx_buf_alloc_napi(struct ipqess_edma_rx_ring *rx_ring)
+{
+	struct ipqess_edma_buf *buf = &rx_ring->buf[rx_ring->head];
+	struct page *new_page = page_pool_dev_alloc_pages(rx_ring->page_pool);
+
+	if (!new_page)
+		return -ENOMEM;
+
+	buf->skb = napi_build_skb(page_address(new_page),
+				  SKB_HEAD_ALIGN(IPQESS_EDMA_RX_HEAD_BUFF_SIZE));
+	if (unlikely(!buf->skb)) {
+		page_pool_put_page(rx_ring->page_pool, new_page,
+				   IPQESS_EDMA_RX_HEAD_BUFF_SIZE,
+				   true);
+		return -ENOMEM;
+	}
+
+	skb_mark_for_recycle(buf->skb);
+
+	return ipqess_edma_rx_buf_prepare(buf, rx_ring);
+}
+
+static int ipqess_edma_rx_buf_alloc(struct ipqess_edma_rx_ring *rx_ring)
+{
+	struct ipqess_edma_buf *buf = &rx_ring->buf[rx_ring->head];
+	struct page *new_page = page_pool_dev_alloc_pages(rx_ring->page_pool);
+
+	if (!new_page)
+		return -ENOMEM;
+
+	buf->skb = build_skb(page_address(new_page),
+			     SKB_HEAD_ALIGN(IPQESS_EDMA_RX_HEAD_BUFF_SIZE));
+	if (unlikely(!buf->skb)) {
+		page_pool_put_page(rx_ring->page_pool, new_page,
+				   IPQESS_EDMA_RX_HEAD_BUFF_SIZE,
+				   true);
+		return -ENOMEM;
+	}
+
+	skb_mark_for_recycle(buf->skb);
+	skb_reserve(buf->skb, NET_IP_ALIGN);
+
+	return ipqess_edma_rx_buf_prepare(buf, rx_ring);
+}
+
+static void ipqess_edma_refill_work(struct work_struct *work)
+{
+	struct ipqess_edma_rx_ring_refill *rx_refill =
+			container_of(work, struct ipqess_edma_rx_ring_refill,
+				     refill_work);
+	struct ipqess_edma_rx_ring *rx_ring = rx_refill->rx_ring;
+	int refill = 0;
+
+	/* don't let this loop by accident. */
+	while (atomic_dec_and_test(&rx_ring->refill_count)) {
+		napi_disable(&rx_ring->napi_rx);
+		if (ipqess_edma_rx_buf_alloc(rx_ring)) {
+			refill++;
+			dev_dbg(rx_ring->ppdev,
+				"Not all buffers were reallocated");
+		}
+		napi_enable(&rx_ring->napi_rx);
+	}
+
+	if (atomic_add_return(refill, &rx_ring->refill_count))
+		schedule_work(&rx_refill->refill_work);
+}
+
+static int ipqess_edma_rx_ring_alloc(struct ipqess_edma *edma)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = IPQESS_EDMA_RX_RING_SIZE,
+		.nid = dev_to_node(&edma->pdev->dev),
+		.dev = &edma->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = IPQESS_EDMA_RX_HEAD_BUFF_SIZE,
+	};
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		struct ipqess_edma_rx_ring *rx_ring = &edma->rx_ring[i];
+		int j;
+
+		rx_ring->edma = edma;
+		rx_ring->ppdev = &edma->pdev->dev;
+		rx_ring->ring_id = i;
+		rx_ring->idx = i * 2;
+
+		rx_ring->buf =
+			devm_kzalloc(&edma->pdev->dev,
+				     sizeof(struct ipqess_edma_buf)
+				     * IPQESS_EDMA_RX_RING_SIZE,
+				     GFP_KERNEL);
+
+		if (!rx_ring->buf)
+			return -ENOMEM;
+
+		rx_ring->desc_dma =
+			dmam_alloc_coherent(&edma->pdev->dev,
+					    sizeof(dma_addr_t)
+					    * IPQESS_EDMA_RX_RING_SIZE,
+					    &rx_ring->ring_dma, GFP_KERNEL);
+
+		if (!rx_ring->desc_dma)
+			return -ENOMEM;
+
+		rx_ring->page_pool = page_pool_create(&pp_params);
+
+		/* Fill the entire ring once */
+		for (j = 0; j < IPQESS_EDMA_RX_RING_SIZE; j++)
+			if (ipqess_edma_rx_buf_alloc(rx_ring) < 0)
+				return -ENOMEM;
+
+		edma->rx_refill[i].rx_ring = &edma->rx_ring[i];
+		INIT_WORK(&edma->rx_refill[i].refill_work,
+			  ipqess_edma_refill_work);
+
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_RFD_BASE_ADDR_Q(rx_ring->idx),
+				(u32)(rx_ring->ring_dma));
+	}
+
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_DESC0,
+			(IPQESS_EDMA_RX_HEAD_BUFF_SIZE << IPQESS_EDMA_RX_BUF_SIZE_SHIFT) |
+			(IPQESS_EDMA_RX_RING_SIZE << IPQESS_EDMA_RFD_RING_SIZE_SHIFT));
+
+	return 0;
+}
+
+static void ipqess_edma_rx_ring_free(struct ipqess_edma *edma)
+{
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		struct ipqess_edma_rx_ring *rx_ring = &edma->rx_ring[i];
+		int j;
+
+		cancel_work_sync(&edma->rx_refill[i].refill_work);
+		atomic_set(&rx_ring->refill_count, 0);
+
+		for (j = 0; j < IPQESS_EDMA_RX_RING_SIZE; j++) {
+			dma_unmap_single(&edma->pdev->dev,
+					 rx_ring->buf[j].dma,
+					 rx_ring->buf[j].length,
+					 DMA_FROM_DEVICE);
+			dev_kfree_skb_any(rx_ring->buf[j].skb);
+		}
+		page_pool_destroy(rx_ring->page_pool);
+	}
+}
+
+static int ipqess_edma_redirect(struct ipqess_edma_rx_ring *rx_ring,
+				struct sk_buff *skb, int port_id)
+{
+	struct ipqess_port *port;
+
+	if (port_id == 0) {
+		/* The switch probably redirected an unknown frame to the CPU port
+		 * (IGMP,BC,unknown MC, unknown UC)
+		 */
+		return -EINVAL;
+	}
+
+	if (port_id < 0 || port_id > QCA8K_NUM_PORTS) {
+		dev_warn_ratelimited(rx_ring->edma->sw->priv->dev,
+				     "received packet tagged with out-of-bounds port id %d\n",
+				     port_id);
+		return -EINVAL;
+	}
+
+	port = rx_ring->edma->sw->port_list[port_id - 1];
+	if (!port) {
+		/* drop packets tagged from unregistered ports */
+		return -EINVAL;
+	}
+
+	skb->dev = port->netdev;
+	skb_push(skb, ETH_HLEN);
+	skb->pkt_type = PACKET_HOST;
+	skb->protocol = eth_type_trans(skb, skb->dev);
+
+	dev_sw_netstats_rx_add(skb->dev, skb->len);
+
+	napi_gro_receive(&rx_ring->napi_rx, skb);
+
+	return 0;
+}
+
+static int ipqess_edma_refill_rx_ring(struct ipqess_edma_rx_ring *rx_ring,
+				      u32 num_desc)
+{
+	struct work_struct *refill_work = &rx_ring->edma->rx_refill[rx_ring->ring_id].refill_work;
+
+	num_desc += atomic_xchg(&rx_ring->refill_count, 0);
+	while (num_desc) {
+		if (ipqess_edma_rx_buf_alloc_napi(rx_ring)) {
+			num_desc = atomic_add_return(num_desc,
+						     &rx_ring->refill_count);
+			if (num_desc >= DIV_ROUND_UP(IPQESS_EDMA_RX_RING_SIZE * 4, 7))
+				schedule_work(refill_work);
+
+			break;
+		}
+		num_desc--;
+	}
+
+	return num_desc;
+}
+
+static int ipqess_edma_rx_poll(struct ipqess_edma_rx_ring *rx_ring, int budget)
+{
+	u32 length = 0, num_desc, tail, rx_ring_tail;
+	int done = 0;
+	int port_id;
+
+	rx_ring_tail = rx_ring->tail;
+
+	tail = ipqess_edma_r32(rx_ring->edma,
+			       IPQESS_EDMA_REG_RFD_IDX_Q(rx_ring->idx));
+	tail >>= IPQESS_EDMA_RFD_CONS_IDX_SHIFT;
+	tail &= IPQESS_EDMA_RFD_CONS_IDX_MASK;
+
+	while (done < budget) {
+		struct ipqess_edma_rx_desc *rd;
+		struct sk_buff *skb;
+
+		if (rx_ring_tail == tail)
+			break;
+
+		dma_unmap_single(rx_ring->ppdev,
+				 rx_ring->buf[rx_ring_tail].dma,
+				 rx_ring->buf[rx_ring_tail].length,
+				 DMA_FROM_DEVICE);
+
+		skb = xchg(&rx_ring->buf[rx_ring_tail].skb, NULL);
+		rd = (struct ipqess_edma_rx_desc *)skb->data;
+		rx_ring_tail = IPQESS_EDMA_NEXT_IDX(rx_ring_tail,
+						    IPQESS_EDMA_RX_RING_SIZE);
+
+		/* Check if RRD is valid */
+		if (!(rd->rrd7 & cpu_to_le16(IPQESS_EDMA_RRD_DESC_VALID))) {
+			num_desc = 1;
+			dev_kfree_skb_any(skb);
+			goto skip;
+		}
+
+		num_desc = le16_to_cpu(rd->rrd1) & IPQESS_EDMA_RRD_NUM_RFD_MASK;
+		length = le16_to_cpu(rd->rrd6) & IPQESS_EDMA_RRD_PKT_SIZE_MASK;
+
+		/* rrd data should not be included in the packet data */
+		skb_reserve(skb, IPQESS_EDMA_RRD_SIZE);
+		if (num_desc > 1) {
+			struct sk_buff *skb_prev = NULL;
+			int size_remaining;
+			int i;
+
+			skb->data_len = 0;
+			skb->tail += (IPQESS_EDMA_RX_HEAD_BUFF_SIZE
+					- IPQESS_EDMA_RRD_SIZE);
+			skb->len = length;
+			skb->truesize = length;
+			size_remaining =
+				length - (IPQESS_EDMA_RX_HEAD_BUFF_SIZE
+						- IPQESS_EDMA_RRD_SIZE);
+
+			for (i = 1; i < num_desc; i++) {
+				struct sk_buff *skb_temp =
+					rx_ring->buf[rx_ring_tail].skb;
+
+				dma_unmap_single(rx_ring->ppdev,
+						 rx_ring->buf[rx_ring_tail].dma,
+						 rx_ring->buf[rx_ring_tail].length,
+						 DMA_FROM_DEVICE);
+
+				skb_put(skb_temp,
+					min(size_remaining, IPQESS_EDMA_RX_HEAD_BUFF_SIZE));
+				if (skb_prev)
+					skb_prev->next =
+						rx_ring->buf[rx_ring_tail].skb;
+				else
+					skb_shinfo(skb)->frag_list =
+						rx_ring->buf[rx_ring_tail].skb;
+				skb_prev = rx_ring->buf[rx_ring_tail].skb;
+				rx_ring->buf[rx_ring_tail].skb->next = NULL;
+
+				skb->data_len += rx_ring->buf[rx_ring_tail].skb->len;
+				size_remaining -= rx_ring->buf[rx_ring_tail].skb->len;
+
+				rx_ring_tail =
+					IPQESS_EDMA_NEXT_IDX(rx_ring_tail,
+							     IPQESS_EDMA_RX_RING_SIZE);
+			}
+
+		} else {
+			skb_put(skb, length);
+		}
+
+		skb->dev = rx_ring->edma->netdev;
+		skb->protocol = eth_type_trans(skb, rx_ring->edma->netdev);
+		skb_record_rx_queue(skb, rx_ring->ring_id);
+
+		if (rd->rrd6 & cpu_to_le16(IPQESS_EDMA_RRD_CSUM_FAIL_MASK))
+			skb_checksum_none_assert(skb);
+		else
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		if (rd->rrd7 & cpu_to_le16(IPQESS_EDMA_RRD_CVLAN))
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       le16_to_cpu(rd->rrd4));
+		else if (rd->rrd1 & cpu_to_le16(IPQESS_EDMA_RRD_SVLAN))
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021AD),
+					       le16_to_cpu(rd->rrd4));
+
+		port_id = FIELD_GET(IPQESS_EDMA_RRD_PORT_ID_MASK,
+				    le16_to_cpu(rd->rrd1));
+
+		if (ipqess_edma_redirect(rx_ring, skb, port_id)) {
+			dev_kfree_skb_any(skb);
+			goto skip;
+		}
+
+		rx_ring->edma->stats.rx_packets++;
+		rx_ring->edma->stats.rx_bytes += length;
+
+		done++;
+skip:
+		num_desc = ipqess_edma_refill_rx_ring(rx_ring, num_desc);
+	}
+
+	ipqess_edma_w32(rx_ring->edma,
+			IPQESS_EDMA_REG_RX_SW_CONS_IDX_Q(rx_ring->idx),
+			rx_ring_tail);
+	rx_ring->tail = rx_ring_tail;
+
+	return done;
+}
+
+static int ipqess_edma_tx_complete(struct ipqess_edma_tx_ring *tx_ring,
+				   int budget)
+{
+	int total = 0, ret;
+	int done = 0;
+	u32 tail;
+
+	tail = ipqess_edma_r32(tx_ring->edma,
+			       IPQESS_EDMA_REG_TPD_IDX_Q(tx_ring->idx));
+	tail >>= IPQESS_EDMA_TPD_CONS_IDX_SHIFT;
+	tail &= IPQESS_EDMA_TPD_CONS_IDX_MASK;
+
+	do {
+		ret = ipqess_edma_tx_unmap_and_free(&tx_ring->edma->pdev->dev,
+						    &tx_ring->buf[tx_ring->tail]);
+		tx_ring->tail = IPQESS_EDMA_NEXT_IDX(tx_ring->tail, tx_ring->count);
+
+		total += ret;
+	} while ((++done < budget) && (tx_ring->tail != tail));
+
+	ipqess_edma_w32(tx_ring->edma,
+			IPQESS_EDMA_REG_TX_SW_CONS_IDX_Q(tx_ring->idx),
+			tx_ring->tail);
+
+	if (netif_tx_queue_stopped(tx_ring->nq)) {
+		netdev_dbg(tx_ring->edma->netdev, "waking up tx queue %d\n",
+			   tx_ring->idx);
+		netif_tx_wake_queue(tx_ring->nq);
+	}
+
+	netdev_tx_completed_queue(tx_ring->nq, done, total);
+
+	return done;
+}
+
+static int ipqess_edma_tx_napi(struct napi_struct *napi, int budget)
+{
+	struct ipqess_edma_tx_ring *tx_ring =
+		container_of(napi, struct ipqess_edma_tx_ring, napi_tx);
+	int work_done = 0;
+	u32 tx_status;
+
+	tx_status = ipqess_edma_r32(tx_ring->edma, IPQESS_EDMA_REG_TX_ISR);
+	tx_status &= BIT(tx_ring->idx);
+
+	work_done = ipqess_edma_tx_complete(tx_ring, budget);
+
+	ipqess_edma_w32(tx_ring->edma, IPQESS_EDMA_REG_TX_ISR, tx_status);
+
+	if (likely(work_done < budget)) {
+		if (napi_complete_done(napi, work_done))
+			ipqess_edma_w32(tx_ring->edma,
+					IPQESS_EDMA_REG_TX_INT_MASK_Q(tx_ring->idx),
+					0x1);
+	}
+
+	return work_done;
+}
+
+static int ipqess_edma_rx_napi(struct napi_struct *napi, int budget)
+{
+	struct ipqess_edma_rx_ring *rx_ring =
+		container_of(napi, struct ipqess_edma_rx_ring, napi_rx);
+	struct ipqess_edma *edma = rx_ring->edma;
+	u32 rx_mask = BIT(rx_ring->idx);
+	int remaining_budget = budget;
+	int rx_done;
+	u32 status;
+
+	do {
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_ISR, rx_mask);
+		rx_done = ipqess_edma_rx_poll(rx_ring, remaining_budget);
+		remaining_budget -= rx_done;
+
+		status = ipqess_edma_r32(edma, IPQESS_EDMA_REG_RX_ISR);
+	} while (remaining_budget > 0 && (status & rx_mask));
+
+	if (remaining_budget <= 0)
+		return budget;
+
+	if (napi_complete_done(napi, budget - remaining_budget))
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_RX_INT_MASK_Q(rx_ring->idx),
+				0x1);
+
+	return budget - remaining_budget;
+}
+
+static irqreturn_t ipqess_edma_interrupt_tx(int irq, void *priv)
+{
+	struct ipqess_edma_tx_ring *tx_ring =
+		(struct ipqess_edma_tx_ring *)priv;
+
+	if (likely(napi_schedule_prep(&tx_ring->napi_tx))) {
+		__napi_schedule(&tx_ring->napi_tx);
+		ipqess_edma_w32(tx_ring->edma,
+				IPQESS_EDMA_REG_TX_INT_MASK_Q(tx_ring->idx),
+				0x0);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ipqess_edma_interrupt_rx(int irq, void *priv)
+{
+	struct ipqess_edma_rx_ring *rx_ring = (struct ipqess_edma_rx_ring *)priv;
+
+	if (likely(napi_schedule_prep(&rx_ring->napi_rx))) {
+		__napi_schedule(&rx_ring->napi_rx);
+		ipqess_edma_w32(rx_ring->edma,
+				IPQESS_EDMA_REG_RX_INT_MASK_Q(rx_ring->idx),
+				0x0);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void ipqess_edma_irq_enable(struct ipqess_edma *edma)
+{
+	int i;
+
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_ISR, 0xff);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_TX_ISR, 0xffff);
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_RX_INT_MASK_Q(edma->rx_ring[i].idx),
+				1);
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_TX_INT_MASK_Q(edma->tx_ring[i].idx),
+				1);
+	}
+}
+
+static void ipqess_edma_irq_disable(struct ipqess_edma *edma)
+{
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_RX_INT_MASK_Q(edma->rx_ring[i].idx),
+				0);
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_TX_INT_MASK_Q(edma->tx_ring[i].idx),
+				0);
+	}
+}
+
+static u16 ipqess_edma_tx_desc_available(struct ipqess_edma_tx_ring *tx_ring)
+{
+	u16 count = 0;
+
+	if (tx_ring->tail <= tx_ring->head)
+		count = IPQESS_EDMA_TX_RING_SIZE;
+
+	count += tx_ring->tail - tx_ring->head - 1;
+
+	return count;
+}
+
+static int ipqess_edma_cal_txd_req(struct sk_buff *skb)
+{
+	int tpds;
+
+	/* one TPD for the header, and one for each fragments */
+	tpds = 1 + skb_shinfo(skb)->nr_frags;
+	if (skb_is_gso(skb) && skb_is_gso_v6(skb)) {
+		/* for LSOv2 one extra TPD is needed */
+		tpds++;
+	}
+
+	return tpds;
+}
+
+static struct ipqess_edma_buf *ipqess_edma_get_tx_buffer(struct ipqess_edma_tx_ring *tx_ring,
+							 struct ipqess_edma_tx_desc *desc)
+{
+	return &tx_ring->buf[desc - tx_ring->desc];
+}
+
+static struct ipqess_edma_tx_desc *ipqess_edma_tx_desc_next(struct ipqess_edma_tx_ring *tx_ring)
+{
+	struct ipqess_edma_tx_desc *desc;
+
+	desc = &tx_ring->desc[tx_ring->head];
+	tx_ring->head = IPQESS_EDMA_NEXT_IDX(tx_ring->head, tx_ring->count);
+
+	return desc;
+}
+
+static void ipqess_edma_rollback_tx(struct ipqess_edma *eth,
+				    struct ipqess_edma_tx_desc *first_desc,
+				    int ring_id)
+{
+	struct ipqess_edma_tx_ring *tx_ring = &eth->tx_ring[ring_id];
+	struct ipqess_edma_tx_desc *desc = NULL;
+	struct ipqess_edma_buf *buf;
+	u16 start_index, index;
+
+	start_index = first_desc - tx_ring->desc;
+
+	index = start_index;
+	while (index != tx_ring->head) {
+		desc = &tx_ring->desc[index];
+		buf = &tx_ring->buf[index];
+		ipqess_edma_tx_unmap_and_free(&eth->pdev->dev, buf);
+		memset(desc, 0, sizeof(*desc));
+		if (++index == tx_ring->count)
+			index = 0;
+	}
+	tx_ring->head = start_index;
+}
+
+static int ipqess_edma_tx_map_and_fill(struct ipqess_edma_tx_ring *tx_ring,
+				       struct sk_buff *skb, int port_id)
+{
+	struct ipqess_edma_tx_desc *desc = NULL, *first_desc = NULL;
+	u32 word1 = 0, word3 = 0, lso_word1 = 0, svlan_tag = 0;
+	struct platform_device *pdev = tx_ring->edma->pdev;
+	struct ipqess_edma_buf *buf = NULL;
+	u16 len;
+	int i;
+
+	word3 |= port_id << IPQESS_EDMA_TPD_PORT_BITMAP_SHIFT;
+	word3 |= BIT(IPQESS_EDMA_TPD_FROM_CPU_SHIFT);
+	word3 |= 0x3e << IPQESS_EDMA_TPD_PORT_BITMAP_SHIFT;
+
+	if (skb_is_gso(skb)) {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
+			lso_word1 |= IPQESS_EDMA_TPD_IPV4_EN;
+			ip_hdr(skb)->check = 0;
+			tcp_hdr(skb)->check = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
+								 ip_hdr(skb)->daddr,
+								 0, IPPROTO_TCP, 0);
+		} else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6) {
+			lso_word1 |= IPQESS_EDMA_TPD_LSO_V2_EN;
+			ipv6_hdr(skb)->payload_len = 0;
+			tcp_hdr(skb)->check = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
+							       &ipv6_hdr(skb)->daddr,
+							       0, IPPROTO_TCP, 0);
+		}
+
+		lso_word1 |= IPQESS_EDMA_TPD_LSO_EN |
+					((skb_shinfo(skb)->gso_size & IPQESS_EDMA_TPD_MSS_MASK) <<
+						IPQESS_EDMA_TPD_MSS_SHIFT) |
+					(skb_transport_offset(skb) << IPQESS_EDMA_TPD_HDR_SHIFT);
+	} else if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
+		u8 css, cso;
+
+		cso = skb_checksum_start_offset(skb);
+		css = cso + skb->csum_offset;
+
+		word1 |= (IPQESS_EDMA_TPD_CUSTOM_CSUM_EN);
+		word1 |= (cso >> 1) << IPQESS_EDMA_TPD_HDR_SHIFT;
+		word1 |= ((css >> 1) << IPQESS_EDMA_TPD_CUSTOM_CSUM_SHIFT);
+	}
+
+	if (skb_vlan_tag_present(skb)) {
+		switch (skb->vlan_proto) {
+		case htons(ETH_P_8021Q):
+			word3 |= BIT(IPQESS_EDMA_TX_INS_CVLAN);
+			word3 |= skb_vlan_tag_get(skb) << IPQESS_EDMA_TX_CVLAN_TAG_SHIFT;
+			break;
+		case htons(ETH_P_8021AD):
+			word1 |= BIT(IPQESS_EDMA_TX_INS_SVLAN);
+			svlan_tag = skb_vlan_tag_get(skb);
+			break;
+		default:
+			dev_err(&pdev->dev, "no ctag or stag present\n");
+			goto vlan_tag_error;
+		}
+	}
+
+	if (eth_type_vlan(skb->protocol))
+		word1 |= IPQESS_EDMA_TPD_VLAN_TAGGED;
+
+	if (skb->protocol == htons(ETH_P_PPP_SES))
+		word1 |= IPQESS_EDMA_TPD_PPPOE_EN;
+
+	len = skb_headlen(skb);
+
+	first_desc = ipqess_edma_tx_desc_next(tx_ring);
+	desc = first_desc;
+	if (lso_word1 & IPQESS_EDMA_TPD_LSO_V2_EN) {
+		desc->addr = cpu_to_le32(skb->len);
+		desc->word1 = cpu_to_le32(word1 | lso_word1);
+		desc->svlan_tag = cpu_to_le16(svlan_tag);
+		desc->word3 = cpu_to_le32(word3);
+		desc = ipqess_edma_tx_desc_next(tx_ring);
+	}
+
+	buf = ipqess_edma_get_tx_buffer(tx_ring, desc);
+	buf->length = len;
+	buf->dma = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
+
+	if (dma_mapping_error(&pdev->dev, buf->dma))
+		goto dma_error;
+
+	desc->addr = cpu_to_le32(buf->dma);
+	desc->len = cpu_to_le16(len);
+
+	buf->flags |= IPQESS_EDMA_DESC_SINGLE;
+	desc->word1 = cpu_to_le32(word1 | lso_word1);
+	desc->svlan_tag = cpu_to_le16(svlan_tag);
+	desc->word3 = cpu_to_le32(word3);
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		len = skb_frag_size(frag);
+		desc = ipqess_edma_tx_desc_next(tx_ring);
+		buf = ipqess_edma_get_tx_buffer(tx_ring, desc);
+		buf->length = len;
+		buf->flags |= IPQESS_EDMA_DESC_PAGE;
+		buf->dma = skb_frag_dma_map(&pdev->dev, frag, 0, len,
+					    DMA_TO_DEVICE);
+
+		if (dma_mapping_error(&pdev->dev, buf->dma))
+			goto dma_error;
+
+		desc->addr = cpu_to_le32(buf->dma);
+		desc->len = cpu_to_le16(len);
+		desc->svlan_tag = cpu_to_le16(svlan_tag);
+		desc->word1 = cpu_to_le32(word1 | lso_word1);
+		desc->word3 = cpu_to_le32(word3);
+	}
+	desc->word1 |= cpu_to_le32(1 << IPQESS_EDMA_TPD_EOP_SHIFT);
+	buf->skb = skb;
+	buf->flags |= IPQESS_EDMA_DESC_LAST;
+
+	return 0;
+
+dma_error:
+	ipqess_edma_rollback_tx(tx_ring->edma, first_desc, tx_ring->ring_id);
+	dev_err(&pdev->dev, "TX DMA map failed\n");
+
+vlan_tag_error:
+	return -ENOMEM;
+}
+
+static void ipqess_edma_kick_tx(struct ipqess_edma_tx_ring *tx_ring)
+{
+	/* Ensure that all TPDs has been written completely */
+	dma_wmb();
+
+	/* update software producer index */
+	ipqess_edma_w32(tx_ring->edma, IPQESS_EDMA_REG_TPD_IDX_Q(tx_ring->idx),
+			tx_ring->head);
+}
+
+netdev_tx_t ipqess_edma_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct ipqess_edma *edma = port->edma;
+	struct ipqess_edma_tx_ring *tx_ring;
+	int port_id = port->index;
+	int tx_num;
+	int avail;
+	int ret;
+
+	tx_ring = &edma->tx_ring[skb_get_queue_mapping(skb)];
+	tx_num = ipqess_edma_cal_txd_req(skb);
+	avail = ipqess_edma_tx_desc_available(tx_ring);
+	if (avail < tx_num) {
+		netdev_dbg(netdev,
+			   "stopping tx queue %d, avail=%d req=%d im=%x\n",
+			   tx_ring->idx, avail, tx_num,
+			   ipqess_edma_r32(edma, IPQESS_EDMA_REG_TX_INT_MASK_Q(tx_ring->idx)));
+		netif_tx_stop_queue(tx_ring->nq);
+		ipqess_edma_w32(tx_ring->edma,
+				IPQESS_EDMA_REG_TX_INT_MASK_Q(tx_ring->idx),
+				0x1);
+		ipqess_edma_kick_tx(tx_ring);
+		return NETDEV_TX_BUSY;
+	}
+
+	ret = ipqess_edma_tx_map_and_fill(tx_ring, skb, port_id);
+	if (ret) {
+		dev_kfree_skb_any(skb);
+		edma->stats.tx_errors++;
+		return ret;
+	}
+
+	edma->stats.tx_packets++;
+	edma->stats.tx_bytes += skb->len;
+	netdev_tx_sent_queue(tx_ring->nq, skb->len);
+
+	if (!netdev_xmit_more() || netif_xmit_stopped(tx_ring->nq))
+		ipqess_edma_kick_tx(tx_ring);
+
+	return NETDEV_TX_OK;
+}
+EXPORT_SYMBOL(ipqess_edma_xmit);
+
+static void ipqess_edma_hw_stop(struct ipqess_edma *edma)
+{
+	int i;
+
+	/* disable all RX queue IRQs */
+	for (i = 0; i < IPQESS_EDMA_MAX_RX_QUEUE; i++)
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_INT_MASK_Q(i), 0);
+
+	/* disable all TX queue IRQs */
+	for (i = 0; i < IPQESS_EDMA_MAX_TX_QUEUE; i++)
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_TX_INT_MASK_Q(i), 0);
+
+	/* disable all other IRQs */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_MISC_IMR, 0);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_WOL_IMR, 0);
+
+	/* clear the IRQ status registers */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_ISR, 0xff);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_TX_ISR, 0xffff);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_MISC_ISR, 0x1fff);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_WOL_ISR, 0x1);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_WOL_CTRL, 0);
+
+	/* disable RX and TX queues */
+	ipqess_edma_m32(edma, IPQESS_EDMA_RXQ_CTRL_EN_MASK, 0,
+			IPQESS_EDMA_REG_RXQ_CTRL);
+	ipqess_edma_m32(edma, IPQESS_EDMA_TXQ_CTRL_TXQ_EN, 0,
+			IPQESS_EDMA_REG_TXQ_CTRL);
+}
+
+static int ipqess_edma_hw_init(struct ipqess_edma *edma)
+{
+	int i, err;
+	u32 tmp;
+
+	ipqess_edma_hw_stop(edma);
+
+	ipqess_edma_m32(edma, BIT(IPQESS_EDMA_INTR_SW_IDX_W_TYP_SHIFT),
+			IPQESS_EDMA_INTR_SW_IDX_W_TYPE
+				<< IPQESS_EDMA_INTR_SW_IDX_W_TYP_SHIFT,
+			IPQESS_EDMA_REG_INTR_CTRL);
+
+	/* enable IRQ delay slot */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_IRQ_MODRT_TIMER_INIT,
+			(IPQESS_EDMA_TX_IMT
+				<< IPQESS_EDMA_IRQ_MODRT_TX_TIMER_SHIFT) |
+			(IPQESS_EDMA_RX_IMT
+				<< IPQESS_EDMA_IRQ_MODRT_RX_TIMER_SHIFT));
+
+	/* Set Customer and Service VLAN TPIDs */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_VLAN_CFG,
+			(ETH_P_8021Q << IPQESS_EDMA_VLAN_CFG_CVLAN_TPID_SHIFT)
+			| (ETH_P_8021AD << IPQESS_EDMA_VLAN_CFG_SVLAN_TPID_SHIFT));
+
+	/* Configure the TX Queue bursting */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_TXQ_CTRL,
+			(IPQESS_EDMA_TPD_BURST << IPQESS_EDMA_TXQ_NUM_TPD_BURST_SHIFT)
+			| (IPQESS_EDMA_TXF_BURST << IPQESS_EDMA_TXQ_TXF_BURST_NUM_SHIFT)
+			| IPQESS_EDMA_TXQ_CTRL_TPD_BURST_EN);
+
+	/* Set RSS type */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RSS_TYPE,
+			IPQESS_EDMA_RSS_TYPE_IPV4TCP
+			| IPQESS_EDMA_RSS_TYPE_IPV6_TCP
+			| IPQESS_EDMA_RSS_TYPE_IPV4_UDP
+			| IPQESS_EDMA_RSS_TYPE_IPV6UDP
+			| IPQESS_EDMA_RSS_TYPE_IPV4
+			| IPQESS_EDMA_RSS_TYPE_IPV6);
+
+	/* Set RFD ring burst and threshold */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_DESC1,
+			(IPQESS_EDMA_RFD_BURST << IPQESS_EDMA_RXQ_RFD_BURST_NUM_SHIFT)
+			| (IPQESS_EDMA_RFD_THR << IPQESS_EDMA_RXQ_RFD_PF_THRESH_SHIFT)
+			| (IPQESS_EDMA_RFD_LTHR << IPQESS_EDMA_RXQ_RFD_LOW_THRESH_SHIFT));
+
+	/* Set Rx FIFO
+	 * - threshold to start to DMA data to host
+	 */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RXQ_CTRL,
+			IPQESS_EDMA_FIFO_THRESH_128_BYTE
+			| IPQESS_EDMA_RXQ_CTRL_RMV_VLAN);
+
+	err = ipqess_edma_rx_ring_alloc(edma);
+	if (err)
+		return err;
+
+	err = ipqess_edma_tx_ring_alloc(edma);
+	if (err)
+		goto err_rx_ring_free;
+
+	/* Load all of ring base address above into the dma engine */
+	ipqess_edma_m32(edma, 0, BIT(IPQESS_EDMA_LOAD_PTR_SHIFT),
+			IPQESS_EDMA_REG_TX_SRAM_PART);
+
+	/* Disable TX FIFO low watermark and high watermark */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_TXF_WATER_MARK, 0);
+
+	/* Configure RSS indirection table.
+	 * 128 hash will be configured in the following
+	 * pattern: hash{0,1,2,3} = {Q0,Q2,Q4,Q6} respectively
+	 * and so on
+	 */
+	for (i = 0; i < IPQESS_EDMA_NUM_IDT; i++)
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_RSS_IDT(i),
+				IPQESS_EDMA_RSS_IDT_VALUE);
+
+	/* Configure load balance mapping table.
+	 * 4 table entry will be configured according to the
+	 * following pattern: load_balance{0,1,2,3} = {Q0,Q1,Q3,Q4}
+	 * respectively.
+	 */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_LB_RING, IPQESS_EDMA_LB_REG_VALUE);
+
+	/* Configure Virtual queue for Tx rings */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_VQ_CTRL0, IPQESS_EDMA_VQ_REG_VALUE);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_VQ_CTRL1, IPQESS_EDMA_VQ_REG_VALUE);
+
+	/* Configure Max AXI Burst write size to 128 bytes*/
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_AXIW_CTRL_MAXWRSIZE,
+			IPQESS_EDMA_AXIW_MAXWRSIZE_VALUE);
+
+	/* Enable TX queues */
+	ipqess_edma_m32(edma, 0, IPQESS_EDMA_TXQ_CTRL_TXQ_EN,
+			IPQESS_EDMA_REG_TXQ_CTRL);
+
+	/* Enable RX queues */
+	tmp = 0;
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++)
+		tmp |= IPQESS_EDMA_RXQ_CTRL_EN(edma->rx_ring[i].idx);
+
+	ipqess_edma_m32(edma, IPQESS_EDMA_RXQ_CTRL_EN_MASK, tmp,
+			IPQESS_EDMA_REG_RXQ_CTRL);
+
+	return 0;
+
+err_rx_ring_free:
+
+	ipqess_edma_rx_ring_free(edma);
+	return err;
+}
+
+static void ipqess_edma_reset(struct ipqess_edma *edma)
+{
+	reset_control_assert(edma->edma_rst);
+
+	mdelay(10);
+
+	reset_control_deassert(edma->edma_rst);
+
+	/* Waiting for all inner tables to be flushed and reinitialized.
+	 * This takes between 5 and 10 ms
+	 */
+
+	mdelay(10);
+}
+
+int ipqess_edma_init(struct platform_device *pdev, struct device_node *np)
+{
+	struct ipqess_switch *sw = platform_get_drvdata(pdev);
+	struct net_device *netdev;
+	struct ipqess_edma *edma;
+	struct ipqess_port *port;
+	int i, err = 0;
+	int qid;
+
+	edma = devm_kzalloc(&pdev->dev, sizeof(*edma), GFP_KERNEL);
+	if (!edma)
+		return -ENOMEM;
+
+	edma->pdev = pdev;
+
+	spin_lock_init(&edma->stats_lock);
+
+	edma->hw_addr = devm_platform_ioremap_resource_byname(pdev, "edma");
+	if (IS_ERR(edma->hw_addr)) {
+		err = PTR_ERR(edma->hw_addr);
+		goto err_edma;
+	}
+
+	edma->edma_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(edma->edma_clk)) {
+		err = PTR_ERR(edma->edma_clk);
+		goto err_edma;
+	}
+
+	err = clk_prepare_enable(edma->edma_clk);
+	if (err)
+		goto err_edma;
+
+	edma->edma_rst = devm_reset_control_get(&pdev->dev, "ess");
+	if (IS_ERR(edma->edma_rst)) {
+		err = PTR_ERR(edma->edma_rst);
+		goto err_clk;
+	}
+
+	ipqess_edma_reset(edma);
+
+	for (i = 0; i < IPQESS_EDMA_MAX_TX_QUEUE; i++) {
+		edma->tx_irq[i] = platform_get_irq(pdev, i);
+		scnprintf(edma->tx_irq_names[i], sizeof(edma->tx_irq_names[i]),
+			  "%s:txq%d", pdev->name, i);
+	}
+
+	for (i = 0; i < IPQESS_EDMA_MAX_RX_QUEUE; i++) {
+		edma->rx_irq[i] = platform_get_irq(pdev,
+						   i + IPQESS_EDMA_MAX_TX_QUEUE);
+		scnprintf(edma->rx_irq_names[i], sizeof(edma->rx_irq_names[i]),
+			  "%s:rxq%d", pdev->name, i);
+	}
+
+	netdev = sw->napi_leader;
+	sw->edma = edma;
+	edma->sw = sw;
+	edma->netdev = netdev;
+
+	err = ipqess_edma_hw_init(edma);
+	if (err)
+		goto err_clk;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		netif_napi_add_tx(netdev, &edma->tx_ring[i].napi_tx,
+				  ipqess_edma_tx_napi);
+		netif_napi_add(netdev, &edma->rx_ring[i].napi_rx,
+			       ipqess_edma_rx_napi);
+	}
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		qid = edma->tx_ring[i].idx;
+		err = devm_request_irq(&netdev->dev, edma->tx_irq[qid],
+				       ipqess_edma_interrupt_tx, 0,
+				       edma->tx_irq_names[qid],
+				       &edma->tx_ring[i]);
+		if (err)
+			goto err_clk;
+
+		qid = edma->rx_ring[i].idx;
+		err = devm_request_irq(&netdev->dev, edma->rx_irq[qid],
+				       ipqess_edma_interrupt_rx, 0,
+				       edma->rx_irq_names[qid],
+				       &edma->rx_ring[i]);
+		if (err)
+			goto err_clk;
+
+		napi_enable(&edma->tx_ring[i].napi_tx);
+		napi_enable(&edma->rx_ring[i].napi_rx);
+	}
+
+	ipqess_edma_irq_enable(edma);
+	netif_tx_start_all_queues(netdev);
+
+	if (err)
+		goto err_hw_stop;
+
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port)
+			port->edma = edma;
+	}
+
+	return 0;
+
+err_hw_stop:
+	ipqess_edma_hw_stop(edma);
+
+	ipqess_edma_tx_ring_free(edma);
+	ipqess_edma_rx_ring_free(edma);
+err_clk:
+	clk_disable_unprepare(edma->edma_clk);
+err_edma:
+	devm_kfree(&pdev->dev, edma);
+
+	return err;
+}
+
+void ipqess_edma_uninit(struct ipqess_edma *edma)
+{
+	struct qca8k_priv *priv = edma->sw->priv;
+	u32 val;
+
+	ipqess_edma_irq_disable(edma);
+	ipqess_edma_hw_stop(edma);
+
+	ipqess_edma_tx_ring_free(edma);
+	ipqess_edma_rx_ring_free(edma);
+
+	/* This register read fixes a bug where
+	 * the switch ID is incorrect at the next probe.
+	 * The source of this issue is unknown.
+	 */
+	qca8k_read(priv, QCA8K_REG_MASK_CTRL, &val);
+
+	clk_disable_unprepare(edma->edma_clk);
+}
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
new file mode 100644
index 000000000000..172193d7126b
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
@@ -0,0 +1,488 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR ISC) */
+/* Copyright (c) 2014 - 2016, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017 - 2018, John Crispin <john@phrozen.org>
+ * Copyright (c) 2018 - 2019, Christian Lamparter <chunkeey@gmail.com>
+ * Copyright (c) 2020 - 2021, Gabor Juhos <j4g8y7@gmail.com>
+ * Copyright (c) 2021 - 2022, Maxime Chevallier <maxime.chevallier@bootlin.com>
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ *
+ */
+
+#ifndef _IPQESS_EDMA_H_
+#define _IPQESS_EDMA_H_
+
+#include "ipqess_switch.h"
+
+#define IPQESS_EDMA_NETDEV_QUEUES	4
+
+#define IPQESS_EDMA_TPD_EOP_SHIFT 31
+
+#define IPQESS_EDMA_PORT_ID_SHIFT 12
+#define IPQESS_EDMA_PORT_ID_MASK 0x7
+
+/* tpd word 3 bit 18-28 */
+#define IPQESS_EDMA_TPD_PORT_BITMAP_SHIFT 18
+
+#define IPQESS_EDMA_TPD_FROM_CPU_SHIFT 25
+
+#define IPQESS_EDMA_RX_RING_SIZE 128
+#define IPQESS_EDMA_RX_HEAD_BUFF_SIZE 1540
+#define IPQESS_EDMA_RRD_SIZE            16
+#define IPQESS_EDMA_NEXT_IDX(X, Y) (((X) + 1) & ((Y) - 1))
+#define IPQESS_EDMA_TX_DMA_BUF_LEN      0x3fff
+#define IPQESS_EDMA_TX_RING_SIZE 128
+#define IPQESS_EDMA_MAX_RX_QUEUE 8
+#define IPQESS_EDMA_MAX_TX_QUEUE 16
+
+/* Configurations */
+#define IPQESS_EDMA_INTR_CLEAR_TYPE 0
+#define IPQESS_EDMA_INTR_SW_IDX_W_TYPE 0
+#define IPQESS_EDMA_FIFO_THRESH_TYPE 0
+#define IPQESS_EDMA_RSS_TYPE 0
+#define IPQESS_EDMA_RX_IMT 0x0020
+#define IPQESS_EDMA_TX_IMT 0x0050
+#define IPQESS_EDMA_TPD_BURST 5
+#define IPQESS_EDMA_TXF_BURST 0x100
+#define IPQESS_EDMA_RFD_BURST 8
+#define IPQESS_EDMA_RFD_THR 16
+#define IPQESS_EDMA_RFD_LTHR 0
+
+/* Flags used in transmit direction */
+#define IPQESS_EDMA_DESC_LAST 0x1
+#define IPQESS_EDMA_DESC_SINGLE 0x2
+#define IPQESS_EDMA_DESC_PAGE 0x4
+
+struct ipqess_edma_tx_desc {
+	__le16  len;
+	__le16  svlan_tag;
+	__le32  word1;
+	__le32  addr;
+	__le32  word3;
+} __aligned(16) __packed;
+
+struct ipqess_edma_rx_desc {
+	__le16 rrd0;
+	__le16 rrd1;
+	__le16 rrd2;
+	__le16 rrd3;
+	__le16 rrd4;
+	__le16 rrd5;
+	__le16 rrd6;
+	__le16 rrd7;
+} __aligned(16) __packed;
+
+struct ipqess_edma_buf {
+	struct sk_buff *skb;
+	dma_addr_t dma;
+	u16 length;
+	u32 flags;
+};
+
+struct ipqess_edma_tx_ring {
+	struct ipqess_edma_tx_desc *desc;
+	struct ipqess_edma_buf *buf;
+	struct napi_struct napi_tx;
+	struct ipqess_edma *edma;
+	struct netdev_queue *nq;
+	dma_addr_t ring_dma;
+	int ring_id;
+	u16 count;
+	u32 idx;
+	u16 head;
+	u16 tail;
+};
+
+struct ipqess_edma_rx_ring {
+	struct ipqess_edma_buf *buf;
+	struct page_pool *page_pool;
+	struct napi_struct napi_rx;
+	struct ipqess_edma *edma;
+	atomic_t refill_count;
+	struct device *ppdev;
+	dma_addr_t *desc_dma;
+	dma_addr_t ring_dma;
+	int ring_id;
+	u32 idx;
+	u16 head;
+	u16 tail;
+};
+
+struct ipqess_edma_rx_ring_refill {
+	struct ipqess_edma_rx_ring *rx_ring;
+	struct work_struct refill_work;
+};
+
+#define IPQESS_EDMA_IRQ_NAME_LEN	32
+
+struct ipqess_edma {
+	void __iomem *hw_addr;
+
+	/* sw port device chosen as napi leader */
+	struct net_device *netdev;
+
+	struct clk *edma_clk;
+	struct reset_control *edma_rst;
+
+	struct ipqess_edma_rx_ring rx_ring[IPQESS_EDMA_NETDEV_QUEUES];
+
+	struct platform_device *pdev;
+
+	struct notifier_block netdev_notifier;
+	int dsa_ports;
+
+	struct ipqess_edma_tx_ring tx_ring[IPQESS_EDMA_NETDEV_QUEUES];
+
+	struct ipqess_switch *sw;
+
+	/* Protects stats */
+	spinlock_t stats_lock;
+	struct net_device_stats stats;
+
+	struct ipqess_edma_rx_ring_refill rx_refill[IPQESS_EDMA_NETDEV_QUEUES];
+	u32 tx_irq[IPQESS_EDMA_MAX_TX_QUEUE];
+	char tx_irq_names[IPQESS_EDMA_MAX_TX_QUEUE][IPQESS_EDMA_IRQ_NAME_LEN];
+	u32 rx_irq[IPQESS_EDMA_MAX_RX_QUEUE];
+	char rx_irq_names[IPQESS_EDMA_MAX_TX_QUEUE][IPQESS_EDMA_IRQ_NAME_LEN];
+};
+
+int ipqess_edma_init(struct platform_device *pdev, struct device_node *np);
+void ipqess_edma_uninit(struct ipqess_edma *edma);
+
+netdev_tx_t ipqess_edma_xmit(struct sk_buff *skb, struct net_device *netdev);
+
+/* register definition */
+#define IPQESS_EDMA_REG_MAS_CTRL 0x0
+#define IPQESS_EDMA_REG_TIMEOUT_CTRL 0x004
+#define IPQESS_EDMA_REG_DBG0 0x008
+#define IPQESS_EDMA_REG_DBG1 0x00C
+#define IPQESS_EDMA_REG_SW_CTRL0 0x100
+#define IPQESS_EDMA_REG_SW_CTRL1 0x104
+
+/* Interrupt Status Register */
+#define IPQESS_EDMA_REG_RX_ISR 0x200
+#define IPQESS_EDMA_REG_TX_ISR 0x208
+#define IPQESS_EDMA_REG_MISC_ISR 0x210
+#define IPQESS_EDMA_REG_WOL_ISR 0x218
+
+#define IPQESS_EDMA_MISC_ISR_RX_URG_Q(x) (1 << (x))
+
+#define IPQESS_EDMA_MISC_ISR_AXIR_TIMEOUT 0x00000100
+#define IPQESS_EDMA_MISC_ISR_AXIR_ERR 0x00000200
+#define IPQESS_EDMA_MISC_ISR_TXF_DEAD 0x00000400
+#define IPQESS_EDMA_MISC_ISR_AXIW_ERR 0x00000800
+#define IPQESS_EDMA_MISC_ISR_AXIW_TIMEOUT 0x00001000
+
+#define IPQESS_EDMA_WOL_ISR 0x00000001
+
+/* Interrupt Mask Register */
+#define IPQESS_EDMA_REG_MISC_IMR 0x214
+#define IPQESS_EDMA_REG_WOL_IMR 0x218
+
+#define IPQESS_EDMA_RX_IMR_NORMAL_MASK 0x1
+#define IPQESS_EDMA_TX_IMR_NORMAL_MASK 0x1
+#define IPQESS_EDMA_MISC_IMR_NORMAL_MASK 0x80001FFF
+#define IPQESS_EDMA_WOL_IMR_NORMAL_MASK 0x1
+
+/* Edma receive consumer index */
+#define IPQESS_EDMA_REG_RX_SW_CONS_IDX_Q(x) (0x220 + ((x) * 4))
+						    /* x is the queue id */
+
+/* Edma transmit consumer index */
+#define IPQESS_EDMA_REG_TX_SW_CONS_IDX_Q(x) (0x240 + ((x) * 4))
+						    /* x is the queue id */
+
+/* IRQ Moderator Initial Timer Register */
+#define IPQESS_EDMA_REG_IRQ_MODRT_TIMER_INIT 0x280
+#define IPQESS_EDMA_IRQ_MODRT_TIMER_MASK 0xFFFF
+#define IPQESS_EDMA_IRQ_MODRT_RX_TIMER_SHIFT 0
+#define IPQESS_EDMA_IRQ_MODRT_TX_TIMER_SHIFT 16
+
+/* Interrupt Control Register */
+#define IPQESS_EDMA_REG_INTR_CTRL 0x284
+#define IPQESS_EDMA_INTR_CLR_TYP_SHIFT 0
+#define IPQESS_EDMA_INTR_SW_IDX_W_TYP_SHIFT 1
+#define IPQESS_EDMA_INTR_CLEAR_TYPE_W1 0
+#define IPQESS_EDMA_INTR_CLEAR_TYPE_R 1
+
+/* RX Interrupt Mask Register */
+#define IPQESS_EDMA_REG_RX_INT_MASK_Q(x) (0x300 + ((x) * 4)) /* x = queue id */
+
+/* TX Interrupt mask register */
+#define IPQESS_EDMA_REG_TX_INT_MASK_Q(x) (0x340 + ((x) * 4)) /* x = queue id */
+
+/* Load Ptr Register
+ * Software sets this bit after the initialization of the head and tail
+ */
+#define IPQESS_EDMA_REG_TX_SRAM_PART 0x400
+#define IPQESS_EDMA_LOAD_PTR_SHIFT 16
+
+/* TXQ Control Register */
+#define IPQESS_EDMA_REG_TXQ_CTRL 0x404
+#define IPQESS_EDMA_TXQ_CTRL_IP_OPTION_EN 0x10
+#define IPQESS_EDMA_TXQ_CTRL_TXQ_EN 0x20
+#define IPQESS_EDMA_TXQ_CTRL_ENH_MODE 0x40
+#define IPQESS_EDMA_TXQ_CTRL_LS_8023_EN 0x80
+#define IPQESS_EDMA_TXQ_CTRL_TPD_BURST_EN 0x100
+#define IPQESS_EDMA_TXQ_CTRL_LSO_BREAK_EN 0x200
+#define IPQESS_EDMA_TXQ_NUM_TPD_BURST_MASK 0xF
+#define IPQESS_EDMA_TXQ_TXF_BURST_NUM_MASK 0xFFFF
+#define IPQESS_EDMA_TXQ_NUM_TPD_BURST_SHIFT 0
+#define IPQESS_EDMA_TXQ_TXF_BURST_NUM_SHIFT 16
+
+#define	IPQESS_EDMA_REG_TXF_WATER_MARK 0x408 /* In 8-bytes */
+#define IPQESS_EDMA_TXF_WATER_MARK_MASK 0x0FFF
+#define IPQESS_EDMA_TXF_LOW_WATER_MARK_SHIFT 0
+#define IPQESS_EDMA_TXF_HIGH_WATER_MARK_SHIFT 16
+#define IPQESS_EDMA_TXQ_CTRL_BURST_MODE_EN 0x80000000
+
+/* WRR Control Register */
+#define IPQESS_EDMA_REG_WRR_CTRL_Q0_Q3 0x40c
+#define IPQESS_EDMA_REG_WRR_CTRL_Q4_Q7 0x410
+#define IPQESS_EDMA_REG_WRR_CTRL_Q8_Q11 0x414
+#define IPQESS_EDMA_REG_WRR_CTRL_Q12_Q15 0x418
+
+/* Weight round robin(WRR), it takes queue as input, and computes
+ * starting bits where we need to write the weight for a particular
+ * queue
+ */
+#define IPQESS_EDMA_WRR_SHIFT(x) (((x) * 5) % 20)
+
+/* Tx Descriptor Control Register */
+#define IPQESS_EDMA_REG_TPD_RING_SIZE 0x41C
+#define IPQESS_EDMA_TPD_RING_SIZE_SHIFT 0
+#define IPQESS_EDMA_TPD_RING_SIZE_MASK 0xFFFF
+
+/* Transmit descriptor base addredma */
+#define IPQESS_EDMA_REG_TPD_BASE_ADDR_Q(x) (0x420 + ((x) * 4))
+						   /* x = queue id */
+
+/* TPD Index Register */
+#define IPQESS_EDMA_REG_TPD_IDX_Q(x) (0x460 + ((x) * 4)) /* x = queue id */
+
+#define IPQESS_EDMA_TPD_PROD_IDX_BITS 0x0000FFFF
+#define IPQESS_EDMA_TPD_CONS_IDX_BITS 0xFFFF0000
+#define IPQESS_EDMA_TPD_PROD_IDX_MASK 0xFFFF
+#define IPQESS_EDMA_TPD_CONS_IDX_MASK 0xFFFF
+#define IPQESS_EDMA_TPD_PROD_IDX_SHIFT 0
+#define IPQESS_EDMA_TPD_CONS_IDX_SHIFT 16
+
+/* TX Virtual Queue Mapping Control Register */
+#define IPQESS_EDMA_REG_VQ_CTRL0 0x4A0
+#define IPQESS_EDMA_REG_VQ_CTRL1 0x4A4
+
+/* Virtual QID shift, it takes queue as input, and computes
+ * Virtual QID position in virtual qid control register
+ */
+#define IPQESS_EDMA_VQ_ID_SHIFT(i) (((i) * 3) % 24)
+
+/* Virtual Queue Default Value */
+#define IPQESS_EDMA_VQ_REG_VALUE 0x240240
+
+/* Tx side Port Interface Control Register */
+#define IPQESS_EDMA_REG_PORT_CTRL 0x4A8
+#define IPQESS_EDMA_PAD_EN_SHIFT 15
+
+/* Tx side VLAN Configuration Register */
+#define IPQESS_EDMA_REG_VLAN_CFG 0x4AC
+
+#define IPQESS_EDMA_VLAN_CFG_SVLAN_TPID_SHIFT 0
+#define IPQESS_EDMA_VLAN_CFG_SVLAN_TPID_MASK 0xffff
+#define IPQESS_EDMA_VLAN_CFG_CVLAN_TPID_SHIFT 16
+#define IPQESS_EDMA_VLAN_CFG_CVLAN_TPID_MASK 0xffff
+
+#define IPQESS_EDMA_TX_CVLAN 16
+#define IPQESS_EDMA_TX_INS_CVLAN 17
+#define IPQESS_EDMA_TX_CVLAN_TAG_SHIFT 0
+
+#define IPQESS_EDMA_TX_SVLAN 14
+#define IPQESS_EDMA_TX_INS_SVLAN 15
+#define IPQESS_EDMA_TX_SVLAN_TAG_SHIFT 16
+
+/* Tx Queue Packet Statistic Register */
+#define IPQESS_EDMA_REG_TX_STAT_PKT_Q(x) (0x700 + ((x) * 8)) /* x = queue id */
+
+#define IPQESS_EDMA_TX_STAT_PKT_MASK 0xFFFFFF
+
+/* Tx Queue Byte Statistic Register */
+#define IPQESS_EDMA_REG_TX_STAT_BYTE_Q(x) (0x704 + ((x) * 8)) /* x = queue id */
+
+/* Load Balance Based Ring Offset Register */
+#define IPQESS_EDMA_REG_LB_RING 0x800
+#define IPQESS_EDMA_LB_RING_ENTRY_MASK 0xff
+#define IPQESS_EDMA_LB_RING_ID_MASK 0x7
+#define IPQESS_EDMA_LB_RING_PROFILE_ID_MASK 0x3
+#define IPQESS_EDMA_LB_RING_ENTRY_BIT_OFFSET 8
+#define IPQESS_EDMA_LB_RING_ID_OFFSET 0
+#define IPQESS_EDMA_LB_RING_PROFILE_ID_OFFSET 3
+#define IPQESS_EDMA_LB_REG_VALUE 0x6040200
+
+/* Load Balance Priority Mapping Register */
+#define IPQESS_EDMA_REG_LB_PRI_START 0x804
+#define IPQESS_EDMA_REG_LB_PRI_END 0x810
+#define IPQESS_EDMA_LB_PRI_REG_INC 4
+#define IPQESS_EDMA_LB_PRI_ENTRY_BIT_OFFSET 4
+#define IPQESS_EDMA_LB_PRI_ENTRY_MASK 0xf
+
+/* RSS Priority Mapping Register */
+#define IPQESS_EDMA_REG_RSS_PRI 0x820
+#define IPQESS_EDMA_RSS_PRI_ENTRY_MASK 0xf
+#define IPQESS_EDMA_RSS_RING_ID_MASK 0x7
+#define IPQESS_EDMA_RSS_PRI_ENTRY_BIT_OFFSET 4
+
+/* RSS Indirection Register */
+#define IPQESS_EDMA_REG_RSS_IDT(x) (0x840 + ((x) * 4))
+					   /* x = No. of indirection table */
+#define IPQESS_EDMA_NUM_IDT 16
+#define IPQESS_EDMA_RSS_IDT_VALUE 0x64206420
+
+/* Default RSS Ring Register */
+#define IPQESS_EDMA_REG_DEF_RSS 0x890
+#define IPQESS_EDMA_DEF_RSS_MASK 0x7
+
+/* RSS Hash Function Type Register */
+#define IPQESS_EDMA_REG_RSS_TYPE 0x894
+#define IPQESS_EDMA_RSS_TYPE_NONE 0x01
+#define IPQESS_EDMA_RSS_TYPE_IPV4TCP 0x02
+#define IPQESS_EDMA_RSS_TYPE_IPV6_TCP 0x04
+#define IPQESS_EDMA_RSS_TYPE_IPV4_UDP 0x08
+#define IPQESS_EDMA_RSS_TYPE_IPV6UDP 0x10
+#define IPQESS_EDMA_RSS_TYPE_IPV4 0x20
+#define IPQESS_EDMA_RSS_TYPE_IPV6 0x40
+#define IPQESS_EDMA_RSS_HASH_MODE_MASK 0x7f
+
+#define IPQESS_EDMA_REG_RSS_HASH_VALUE 0x8C0
+
+#define IPQESS_EDMA_REG_RSS_TYPE_RESULT 0x8C4
+
+#define IPQESS_EDMA_HASH_TYPE_START 0
+#define IPQESS_EDMA_HASH_TYPE_END 5
+#define IPQESS_EDMA_HASH_TYPE_SHIFT 12
+
+#define IPQESS_EDMA_RFS_FLOW_ENTRIES 1024
+#define IPQESS_EDMA_RFS_FLOW_ENTRIES_MASK (IPQESS_EDMA_RFS_FLOW_ENTRIES - 1)
+#define IPQESS_EDMA_RFS_EXPIRE_COUNT_PER_CALL 128
+
+/* RFD Base Addredma Register */
+#define IPQESS_EDMA_REG_RFD_BASE_ADDR_Q(x) (0x950 + ((x) * 4))
+						   /* x = queue id */
+
+/* RFD Index Register */
+#define IPQESS_EDMA_REG_RFD_IDX_Q(x) (0x9B0 + ((x) * 4)) /* x = queue id */
+
+#define IPQESS_EDMA_RFD_PROD_IDX_BITS 0x00000FFF
+#define IPQESS_EDMA_RFD_CONS_IDX_BITS 0x0FFF0000
+#define IPQESS_EDMA_RFD_PROD_IDX_MASK 0xFFF
+#define IPQESS_EDMA_RFD_CONS_IDX_MASK 0xFFF
+#define IPQESS_EDMA_RFD_PROD_IDX_SHIFT 0
+#define IPQESS_EDMA_RFD_CONS_IDX_SHIFT 16
+
+/* Rx Descriptor Control Register */
+#define IPQESS_EDMA_REG_RX_DESC0 0xA10
+#define IPQESS_EDMA_RFD_RING_SIZE_MASK 0xFFF
+#define IPQESS_EDMA_RX_BUF_SIZE_MASK 0xFFFF
+#define IPQESS_EDMA_RFD_RING_SIZE_SHIFT 0
+#define IPQESS_EDMA_RX_BUF_SIZE_SHIFT 16
+
+#define IPQESS_EDMA_REG_RX_DESC1 0xA14
+#define IPQESS_EDMA_RXQ_RFD_BURST_NUM_MASK 0x3F
+#define IPQESS_EDMA_RXQ_RFD_PF_THRESH_MASK 0x1F
+#define IPQESS_EDMA_RXQ_RFD_LOW_THRESH_MASK 0xFFF
+#define IPQESS_EDMA_RXQ_RFD_BURST_NUM_SHIFT 0
+#define IPQESS_EDMA_RXQ_RFD_PF_THRESH_SHIFT 8
+#define IPQESS_EDMA_RXQ_RFD_LOW_THRESH_SHIFT 16
+
+/* RXQ Control Register */
+#define IPQESS_EDMA_REG_RXQ_CTRL 0xA18
+#define IPQESS_EDMA_FIFO_THRESH_TYPE_SHIF 0
+#define IPQESS_EDMA_FIFO_THRESH_128_BYTE 0x0
+#define IPQESS_EDMA_FIFO_THRESH_64_BYTE 0x1
+#define IPQESS_EDMA_RXQ_CTRL_RMV_VLAN 0x00000002
+#define IPQESS_EDMA_RXQ_CTRL_EN_MASK			GENMASK(15, 8)
+#define IPQESS_EDMA_RXQ_CTRL_EN(__qid)		BIT(8 + (__qid))
+
+/* AXI Burst Size Config */
+#define IPQESS_EDMA_REG_AXIW_CTRL_MAXWRSIZE 0xA1C
+#define IPQESS_EDMA_AXIW_MAXWRSIZE_VALUE 0x0
+
+/* Rx Statistics Register */
+#define IPQESS_EDMA_REG_RX_STAT_BYTE_Q(x) (0xA30 + ((x) * 4))
+						  /* x = queue id */
+#define IPQESS_EDMA_REG_RX_STAT_PKT_Q(x) (0xA50 + ((x) * 4))
+						  /* x = queue id */
+
+/* WoL Pattern Length Register */
+#define IPQESS_EDMA_REG_WOL_PATTERN_LEN0 0xC00
+#define IPQESS_EDMA_WOL_PT_LEN_MASK 0xFF
+#define IPQESS_EDMA_WOL_PT0_LEN_SHIFT 0
+#define IPQESS_EDMA_WOL_PT1_LEN_SHIFT 8
+#define IPQESS_EDMA_WOL_PT2_LEN_SHIFT 16
+#define IPQESS_EDMA_WOL_PT3_LEN_SHIFT 24
+
+#define IPQESS_EDMA_REG_WOL_PATTERN_LEN1 0xC04
+#define IPQESS_EDMA_WOL_PT4_LEN_SHIFT 0
+#define IPQESS_EDMA_WOL_PT5_LEN_SHIFT 8
+#define IPQESS_EDMA_WOL_PT6_LEN_SHIFT 16
+
+/* WoL Control Register */
+#define IPQESS_EDMA_REG_WOL_CTRL 0xC08
+#define IPQESS_EDMA_WOL_WK_EN 0x00000001
+#define IPQESS_EDMA_WOL_MG_EN 0x00000002
+#define IPQESS_EDMA_WOL_PT0_EN 0x00000004
+#define IPQESS_EDMA_WOL_PT1_EN 0x00000008
+#define IPQESS_EDMA_WOL_PT2_EN 0x00000010
+#define IPQESS_EDMA_WOL_PT3_EN 0x00000020
+#define IPQESS_EDMA_WOL_PT4_EN 0x00000040
+#define IPQESS_EDMA_WOL_PT5_EN 0x00000080
+#define IPQESS_EDMA_WOL_PT6_EN 0x00000100
+
+/* MAC Control Register */
+#define IPQESS_EDMA_REG_MAC_CTRL0 0xC20
+#define IPQESS_EDMA_REG_MAC_CTRL1 0xC24
+
+/* WoL Pattern Register */
+#define IPQESS_EDMA_REG_WOL_PATTERN_START 0x5000
+#define IPQESS_EDMA_PATTERN_PART_REG_OFFSET 0x40
+
+/* TX descriptor fields */
+#define IPQESS_EDMA_TPD_HDR_SHIFT 0
+#define IPQESS_EDMA_TPD_PPPOE_EN 0x00000100
+#define IPQESS_EDMA_TPD_IP_CSUM_EN 0x00000200
+#define IPQESS_EDMA_TPD_TCP_CSUM_EN 0x0000400
+#define IPQESS_EDMA_TPD_UDP_CSUM_EN 0x00000800
+#define IPQESS_EDMA_TPD_CUSTOM_CSUM_EN 0x00000C00
+#define IPQESS_EDMA_TPD_LSO_EN 0x00001000
+#define IPQESS_EDMA_TPD_LSO_V2_EN 0x00002000
+/* The VLAN_TAGGED bit is not used in the publicly available
+ * drivers. The definition has been stolen from the Atheros
+ * 'alx' driver (drivers/net/ethernet/atheros/alx/hw.h). It
+ * seems that it has the same meaning in regard to the EDMA
+ * hardware.
+ */
+#define IPQESS_EDMA_TPD_VLAN_TAGGED 0x00004000
+#define IPQESS_EDMA_TPD_IPV4_EN 0x00010000
+#define IPQESS_EDMA_TPD_MSS_MASK 0x1FFF
+#define IPQESS_EDMA_TPD_MSS_SHIFT 18
+#define IPQESS_EDMA_TPD_CUSTOM_CSUM_SHIFT 18
+
+/* RRD descriptor fields */
+#define IPQESS_EDMA_RRD_NUM_RFD_MASK 0x000F
+#define IPQESS_EDMA_RRD_PKT_SIZE_MASK 0x3FFF
+#define IPQESS_EDMA_RRD_SRC_PORT_NUM_MASK 0x4000
+#define IPQESS_EDMA_RRD_SVLAN 0x8000
+#define IPQESS_EDMA_RRD_FLOW_COOKIE_MASK 0x07FF
+
+#define IPQESS_EDMA_RRD_PKT_SIZE_MASK 0x3FFF
+#define IPQESS_EDMA_RRD_CSUM_FAIL_MASK 0xC000
+#define IPQESS_EDMA_RRD_CVLAN 0x0001
+#define IPQESS_EDMA_RRD_DESC_VALID 0x8000
+
+#define IPQESS_EDMA_RRD_PRIORITY_SHIFT 4
+#define IPQESS_EDMA_RRD_PRIORITY_MASK 0x7
+#define IPQESS_EDMA_RRD_PORT_TYPE_SHIFT 7
+#define IPQESS_EDMA_RRD_PORT_TYPE_MASK 0x1F
+
+#define IPQESS_EDMA_RRD_PORT_ID_MASK 0x7000
+
+#define IPQESS_EDMA_MAX_MTU 9000
+
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
new file mode 100644
index 000000000000..47f06a757cf7
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 OR ISC */
+
+#ifndef IPQESS_NOTIFIERS_H
+#define IPQESS_NOTIFIERS_H
+
+#include <linux/if_ether.h>
+
+struct ipqess_switchdev_event_work {
+	struct net_device *netdev;
+	struct net_device *orig_netdev;
+	struct work_struct work;
+	unsigned long event;
+	/* Specific for SWITCHDEV_FDB_ADD_TO_DEVICE and
+	 * SWITCHDEV_FDB_DEL_TO_DEVICE
+	 */
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	bool host_addr;
+};
+
+extern struct notifier_block ipqess_switchdev_notifier;
+extern struct notifier_block ipqess_switchdev_blocking_notifier;
+
+int ipqess_notifiers_register(void);
+void ipqess_notifiers_unregister(void);
+
+void ipqess_flush_workqueue(void);
+
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
new file mode 100644
index 000000000000..f0f5fe3a7c24
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
@@ -0,0 +1,757 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Handling of a single switch port
+ *
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ * Based on net/dsa
+ */
+
+#include <linux/if_bridge.h>
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/of_net.h>
+
+#include "ipqess_port.h"
+#include "ipqess_edma.h"
+#include "ipqess_switch.h"
+#include "ipqess_notifiers.h"
+
+#define ipqess_port_from_pl_state(config, pl_config)\
+container_of(config, struct ipqess_port, pl_config)
+
+static struct device_type ipqess_port_type = {
+	.name	= "switch",
+};
+
+/* netdev ops */
+
+static void ipqess_port_fast_age(const struct ipqess_port *port)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+
+	mutex_lock(&priv->reg_mutex);
+	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port->index);
+	mutex_unlock(&priv->reg_mutex);
+}
+
+static void ipqess_port_stp_state_set(struct ipqess_port *port,
+				      u8 state)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	u32 stp_state;
+	int err;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_DISABLED;
+		break;
+	case BR_STATE_BLOCKING:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_BLOCKING;
+		break;
+	case BR_STATE_LISTENING:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_LISTENING;
+		break;
+	case BR_STATE_LEARNING:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
+		break;
+	case BR_STATE_FORWARDING:
+	default:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
+		break;
+	}
+
+	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
+			QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
+
+	if (err)
+		dev_warn(priv->dev,
+			 "failed to set STP state %d for port %d: err %d\n",
+			 stp_state, port->index, err);
+}
+
+static void ipqess_port_set_state_now(struct ipqess_port *port,
+				      u8 state, bool do_fast_age)
+{
+	ipqess_port_stp_state_set(port, state);
+
+	if ((port->stp_state == BR_STATE_LEARNING ||
+	     port->stp_state == BR_STATE_FORWARDING) &&
+	    (state == BR_STATE_DISABLED || state == BR_STATE_BLOCKING ||
+	    state == BR_STATE_LISTENING))
+		ipqess_port_fast_age(port);
+
+	port->stp_state = state;
+}
+
+static int ipqess_port_enable_rt(struct ipqess_port *port,
+				 struct phy_device *phy)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+
+	qca8k_port_set_status(priv, port->index, 1);
+	priv->port_enabled_map |= BIT(port->index);
+
+	phy_support_asym_pause(phy);
+
+	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
+
+	if (port->pl)
+		phylink_start(port->pl);
+
+	return 0;
+}
+
+static void ipqess_port_disable_rt(struct ipqess_port *port)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+
+	if (port->pl)
+		phylink_stop(port->pl);
+
+	ipqess_port_set_state_now(port, BR_STATE_DISABLED, false);
+
+	qca8k_port_set_status(priv, port->index, 0);
+	priv->port_enabled_map &= ~BIT(port->index);
+}
+
+static int ipqess_port_open(struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct phy_device *phy = netdev->phydev;
+
+	return ipqess_port_enable_rt(port, phy);
+}
+
+static int ipqess_port_close(struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+
+	ipqess_port_disable_rt(port);
+
+	return 0;
+}
+
+static netdev_tx_t ipqess_port_xmit(struct sk_buff *skb,
+				    struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+
+	dev_sw_netstats_tx_add(netdev, 1, skb->len);
+
+	memset(skb->cb, 0, sizeof(skb->cb));
+
+	return ipqess_edma_xmit(skb, port->netdev);
+}
+
+static int ipqess_port_set_mac_address(struct net_device *netdev, void *a)
+{
+	struct sockaddr *addr = a;
+	int err;
+
+	/* If the port is down, the address isn't synced yet to hardware
+	 * so there is nothing to change
+	 */
+	if (!(netdev->flags & IFF_UP)) {
+		eth_hw_addr_set(netdev, addr->sa_data);
+		return 0;
+	}
+
+	if (!ether_addr_equal(addr->sa_data, netdev->dev_addr)) {
+		err = dev_uc_add(netdev, addr->sa_data);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int ipqess_port_ioctl(struct net_device *netdev, struct ifreq *ifr,
+			     int cmd)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+
+	return phylink_mii_ioctl(port->pl, ifr, cmd);
+}
+
+static int ipqess_port_get_iflink(const struct net_device *dev)
+{
+	return dev->ifindex;
+}
+
+static int ipqess_port_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+	int err;
+
+	/* To change the MAX_FRAME_SIZE, the cpu port must be off
+	 * or the switch panics.
+	 */
+	if (port->sw->port0_enabled)
+		qca8k_port_set_status(priv, 0, 0);
+
+	err = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, new_mtu +
+			  ETH_HLEN + ETH_FCS_LEN);
+
+	if (port->sw->port0_enabled)
+		qca8k_port_set_status(priv, 0, 1);
+
+	if (err)
+		return err;
+
+	dev->mtu = new_mtu;
+
+	return 0;
+}
+
+static int ipqess_port_do_vlan_add(struct qca8k_priv *priv, int port_index,
+				   const struct switchdev_obj_port_vlan *vlan,
+				   struct netlink_ext_ack *extack)
+{
+	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	int ret;
+
+	ret = qca8k_vlan_add(priv, port_index, vlan->vid, untagged);
+	if (ret) {
+		dev_err(priv->dev, "Failed to add VLAN to port %d (%d)", port_index,
+			ret);
+		return ret;
+	}
+
+	if (pvid) {
+		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port_index),
+				QCA8K_EGREES_VLAN_PORT_MASK(port_index),
+				QCA8K_EGREES_VLAN_PORT(port_index, vlan->vid));
+		if (ret)
+			return ret;
+
+		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port_index),
+				  QCA8K_PORT_VLAN_CVID(vlan->vid) |
+				  QCA8K_PORT_VLAN_SVID(vlan->vid));
+	}
+
+	return ret;
+}
+
+static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
+				       u16 vid)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct switchdev_obj_port_vlan vlan = {
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.vid = vid,
+		/* This API only allows programming tagged, non-PVID VIDs */
+		.flags = 0,
+	};
+	struct netlink_ext_ack extack = {0};
+	int ret;
+
+	/* User port... */
+	ret = ipqess_port_do_vlan_add(port->sw->priv, port->index, &vlan, &extack);
+	if (ret) {
+		if (extack._msg)
+			netdev_err(dev, "%s\n", extack._msg);
+		return ret;
+	}
+
+	/* And CPU port... */
+	ret = ipqess_port_do_vlan_add(port->sw->priv, 0, &vlan, &extack);
+	if (ret) {
+		if (extack._msg)
+			netdev_err(dev, "CPU port %d: %s\n", 0, extack._msg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ipqess_port_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
+					u16 vid)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	int err;
+
+	err = qca8k_vlan_del(port->sw->priv, port->index, vid);
+	if (err)
+		return err;
+
+	err = qca8k_vlan_del(port->sw->priv, 0, vid);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int
+ipqess_port_fdb_do_dump(const unsigned char *addr, u16 vid,
+			bool is_static, void *data)
+{
+	struct ipqess_port_dump_ctx *dump = data;
+	u32 portid = NETLINK_CB(dump->cb->skb).portid;
+	u32 seq = dump->cb->nlh->nlmsg_seq;
+	struct nlmsghdr *nlh;
+	struct ndmsg *ndm;
+
+	if (dump->idx < dump->cb->args[2])
+		goto skip;
+
+	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
+			sizeof(*ndm), NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	ndm = nlmsg_data(nlh);
+	ndm->ndm_family  = AF_BRIDGE;
+	ndm->ndm_pad1    = 0;
+	ndm->ndm_pad2    = 0;
+	ndm->ndm_flags   = NTF_SELF;
+	ndm->ndm_type    = 0;
+	ndm->ndm_ifindex = dump->dev->ifindex;
+	ndm->ndm_state   = is_static ? NUD_NOARP : NUD_REACHABLE;
+
+	if (nla_put(dump->skb, NDA_LLADDR, ETH_ALEN, addr))
+		goto nla_put_failure;
+
+	if (vid && nla_put_u16(dump->skb, NDA_VLAN, vid))
+		goto nla_put_failure;
+
+	nlmsg_end(dump->skb, nlh);
+
+skip:
+	dump->idx++;
+	return 0;
+
+nla_put_failure:
+	nlmsg_cancel(dump->skb, nlh);
+	return -EMSGSIZE;
+}
+
+static int
+ipqess_port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
+		     struct net_device *dev, struct net_device *filter_dev,
+		     int *idx)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+	struct ipqess_port_dump_ctx dump = {
+		.dev = dev,
+		.skb = skb,
+		.cb = cb,
+		.idx = *idx,
+	};
+	int cnt = QCA8K_NUM_FDB_RECORDS;
+	struct qca8k_fdb _fdb = { 0 };
+	bool is_static;
+	int ret = 0;
+
+	mutex_lock(&priv->reg_mutex);
+	while (cnt-- && !qca8k_fdb_next(priv, &_fdb, port->index)) {
+		if (!_fdb.aging)
+			break;
+		is_static = (_fdb.aging == QCA8K_ATU_STATUS_STATIC);
+		ret = ipqess_port_fdb_do_dump(_fdb.mac, _fdb.vid, is_static, &dump);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&priv->reg_mutex);
+
+	*idx = dump.idx;
+
+	return ret;
+}
+
+static const struct net_device_ops ipqess_port_netdev_ops = {
+	.ndo_open               = ipqess_port_open,
+	.ndo_stop               = ipqess_port_close,
+	.ndo_set_mac_address    = ipqess_port_set_mac_address,
+	.ndo_eth_ioctl          = ipqess_port_ioctl,
+	.ndo_start_xmit         = ipqess_port_xmit,
+	.ndo_get_iflink         = ipqess_port_get_iflink,
+	.ndo_change_mtu         = ipqess_port_change_mtu,
+	.ndo_vlan_rx_add_vid    = ipqess_port_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid   = ipqess_port_vlan_rx_kill_vid,
+	.ndo_fdb_dump           = ipqess_port_fdb_dump,
+};
+
+/* phylink ops */
+
+static void
+ipqess_phylink_mac_config(struct phylink_config *config,
+			  unsigned int mode,
+			  const struct phylink_link_state *state)
+{
+	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
+	struct qca8k_priv *priv = port->sw->priv;
+
+	switch (port->index) {
+	case 0:
+		/* CPU port, no configuration needed */
+		return;
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+	case 5:
+		if (phy_interface_mode_is_rgmii(state->interface))
+			regmap_set_bits(priv->regmap,
+					QCA8K_IPQ4019_REG_RGMII_CTRL,
+					QCA8K_IPQ4019_RGMII_CTRL_CLK);
+		return;
+	default:
+		dev_err(priv->dev, "%s: unsupported port: %i\n", __func__,
+			port->index);
+		return;
+	}
+}
+
+static void
+ipqess_phylink_mac_link_down(struct phylink_config *config,
+			     unsigned int mode,
+			     phy_interface_t interface)
+{
+	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
+	struct qca8k_priv *priv = port->sw->priv;
+
+	qca8k_port_set_status(priv, port->index, 0);
+}
+
+static void ipqess_phylink_mac_link_up(struct phylink_config *config,
+				       struct phy_device *phydev,
+				       unsigned int mode,
+				       phy_interface_t interface,
+				       int speed, int duplex,
+				       bool tx_pause, bool rx_pause)
+{
+	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
+	struct qca8k_priv *priv = port->sw->priv;
+	u32 reg;
+
+	if (phylink_autoneg_inband(mode)) {
+		reg = QCA8K_PORT_STATUS_LINK_AUTO;
+	} else {
+		switch (speed) {
+		case SPEED_10:
+			reg = QCA8K_PORT_STATUS_SPEED_10;
+			break;
+		case SPEED_100:
+			reg = QCA8K_PORT_STATUS_SPEED_100;
+			break;
+		case SPEED_1000:
+			reg = QCA8K_PORT_STATUS_SPEED_1000;
+			break;
+		default:
+			reg = QCA8K_PORT_STATUS_LINK_AUTO;
+			break;
+		}
+
+		if (duplex == DUPLEX_FULL)
+			reg |= QCA8K_PORT_STATUS_DUPLEX;
+
+		if (rx_pause || port->index == 0)
+			reg |= QCA8K_PORT_STATUS_RXFLOW;
+
+		if (tx_pause || port->index == 0)
+			reg |= QCA8K_PORT_STATUS_TXFLOW;
+	}
+
+	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
+
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port->index), reg);
+}
+
+static const struct phylink_mac_ops ipqess_phylink_mac_ops = {
+	.mac_config = ipqess_phylink_mac_config,
+	.mac_link_down = ipqess_phylink_mac_link_down,
+	.mac_link_up = ipqess_phylink_mac_link_up,
+};
+
+static int ipqess_phylink_create(struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct phylink_config *pl_config = &port->pl_config;
+	phy_interface_t mode;
+	struct phylink *pl;
+	int err;
+
+	err = of_get_phy_mode(port->dn, &mode);
+	if (err)
+		mode = PHY_INTERFACE_MODE_NA;
+
+	switch (port->index) {
+	case 1:
+	case 2:
+	case 3:
+		__set_bit(PHY_INTERFACE_MODE_PSGMII,
+			  pl_config->supported_interfaces);
+		break;
+	case 4:
+	case 5:
+		phy_interface_set_rgmii(pl_config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_PSGMII,
+			  pl_config->supported_interfaces);
+		break;
+	case 0: /* CPU port, this shouldn't happen */
+	default:
+		return -EINVAL;
+	}
+	/* phylink caps */
+	pl_config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+		MAC_10 | MAC_100 | MAC_1000FD;
+
+	pl = phylink_create(pl_config, of_fwnode_handle(port->dn),
+			    mode, &ipqess_phylink_mac_ops);
+	if (IS_ERR(pl))
+		return PTR_ERR(pl);
+
+	port->pl = pl;
+	return 0;
+}
+
+static int ipqess_port_phy_connect(struct net_device *netdev, int addr,
+				   u32 flags)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+
+	netdev->phydev = mdiobus_get_phy(port->mii_bus, addr);
+	if (!netdev->phydev) {
+		netdev_err(netdev, "no phy at %d\n", addr);
+		return -ENODEV;
+	}
+
+	netdev->phydev->dev_flags |= flags;
+
+	return phylink_connect_phy(port->pl, netdev->phydev);
+}
+
+static int ipqess_port_phy_setup(struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct device_node *port_dn = port->dn;
+	u32 phy_flags = 0;
+	int ret;
+
+	port->pl_config.dev = &netdev->dev;
+	port->pl_config.type = PHYLINK_NETDEV;
+
+	ret = ipqess_phylink_create(netdev);
+	if (ret)
+		return ret;
+
+	ret = phylink_of_phy_connect(port->pl, port_dn, phy_flags);
+	if (ret == -ENODEV && port->mii_bus) {
+		/* We could not connect to a designated PHY or SFP, so try to
+		 * use the switch internal MDIO bus instead
+		 */
+		ret = ipqess_port_phy_connect(netdev, port->index, phy_flags);
+	}
+
+	if (ret) {
+		netdev_err(netdev, "failed to connect to PHY: %pe\n",
+			   ERR_PTR(ret));
+		phylink_destroy(port->pl);
+		port->pl = NULL;
+	}
+
+	dev_info(&netdev->dev, "enabled port's phy: %s",
+		 phydev_name(netdev->phydev));
+	return ret;
+}
+
+/* netlink */
+
+#define IFLA_IPQESS_UNSPEC 0
+#define IFLA_IPQESS_MAX 0
+
+static const struct nla_policy ipqess_port_policy[IFLA_IPQESS_MAX + 1] = {
+	[IFLA_IPQESS_MAX] = { .type = NLA_U32 },
+};
+
+static size_t ipqess_port_get_size(const struct net_device *dev)
+{
+	return nla_total_size(sizeof(u32));
+}
+
+static int ipqess_port_fill_info(struct sk_buff *skb,
+				 const struct net_device *dev)
+{
+	if (nla_put_u32(skb, IFLA_IPQESS_UNSPEC, dev->ifindex))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static struct rtnl_link_ops ipqess_port_link_ops __read_mostly = {
+	.kind         = "switch",
+	.priv_size    = sizeof(struct ipqess_port),
+	.maxtype      = 1,
+	.policy       = ipqess_port_policy,
+	.get_size     = ipqess_port_get_size,
+	.fill_info    = ipqess_port_fill_info,
+	.netns_refund = true,
+};
+
+/* devlink */
+
+static int ipqess_port_devlink_setup(struct ipqess_port *port)
+{
+	struct devlink_port *dlp = &port->devlink_port;
+	struct devlink *dl = port->sw->devlink;
+	struct devlink_port_attrs attrs = {};
+	const unsigned char *id;
+	unsigned int index = 0;
+	unsigned char len;
+	int err;
+
+	id = (const unsigned char *)&index;
+	len = sizeof(index);
+	memset(dlp, 0, sizeof(*dlp));
+
+	attrs.phys.port_number = port->index;
+	memcpy(attrs.switch_id.id, id, len);
+	attrs.switch_id.id_len = len;
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	devlink_port_attrs_set(dlp, &attrs);
+
+	err = devlink_port_register(dl, dlp, port->index);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/* register */
+
+int ipqess_port_register(struct ipqess_switch *sw,
+			 struct device_node *port_node)
+{
+	struct qca8k_priv *priv = sw->priv;
+	struct net_device *netdev;
+	struct ipqess_port *port;
+	const char *name;
+	int assign_type;
+	int num_queues;
+	u32 index;
+	int err;
+
+	err = of_property_read_u32(port_node, "reg", &index);
+	if (err) {
+		pr_err("Node without reg property!");
+		return err;
+	}
+
+	name = of_get_property(port_node, "label", NULL);
+	if (!name) {
+		name = "eth%d";
+		assign_type = NET_NAME_ENUM;
+	} else {
+		assign_type = NET_NAME_PREDICTABLE;
+	}
+
+	/* For the NAPI leader, we allocate one queue per MAC queue */
+	if (!sw->napi_leader)
+		num_queues = IPQESS_EDMA_NETDEV_QUEUES;
+	else
+		num_queues = 1;
+
+	netdev = alloc_netdev_mqs(sizeof(struct ipqess_port), name, assign_type,
+				  ether_setup, num_queues, num_queues);
+	if (!netdev)
+		return -ENOMEM;
+
+	if (!sw->napi_leader)
+		sw->napi_leader = netdev;
+
+	port = netdev_priv(netdev);
+	port->index = (int)index;
+	port->dn = port_node;
+	port->netdev = netdev;
+	port->edma = NULL; /* Assigned during edma initialization */
+	port->qid = port->index - 1;
+	port->sw = sw;
+
+	of_get_mac_address(port_node, port->mac);
+	if (!is_zero_ether_addr(port->mac))
+		eth_hw_addr_set(netdev, port->mac);
+	else
+		eth_hw_addr_random(netdev);
+
+	netdev->netdev_ops = &ipqess_port_netdev_ops;
+	netdev->max_mtu = QCA8K_MAX_MTU;
+	SET_NETDEV_DEVTYPE(netdev, &ipqess_port_type);
+	SET_NETDEV_DEV(netdev, priv->dev);
+	SET_NETDEV_DEVLINK_PORT(netdev, &port->devlink_port);
+	netdev->dev.of_node = port->dn;
+
+	netdev->rtnl_link_ops = &ipqess_port_link_ops;
+
+	netdev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!netdev->tstats) {
+		free_netdev(netdev);
+		return -ENOMEM;
+	}
+
+	err = ipqess_port_devlink_setup(port);
+	if (err)
+		goto out_free;
+
+	err = gro_cells_init(&port->gcells, netdev);
+	if (err)
+		goto out_devlink;
+
+	err = ipqess_port_phy_setup(netdev);
+	if (err) {
+		pr_err("error setting up PHY: %d\n", err);
+		goto out_gcells;
+	}
+
+	/* We use the qid and not the index because port 0 isn't registered */
+	sw->port_list[port->qid] = port;
+
+	err = register_netdev(netdev);
+	if (err) {
+		pr_err("error %d registering interface %s\n",
+		       err, netdev->name);
+		rtnl_unlock();
+		goto out_phy;
+	}
+
+	return 0;
+
+out_phy:
+	rtnl_lock();
+	phylink_disconnect_phy(port->pl);
+	rtnl_unlock();
+	phylink_destroy(port->pl);
+	port->pl = NULL;
+out_gcells:
+	gro_cells_destroy(&port->gcells);
+out_devlink:
+	devlink_port_unregister(&port->devlink_port);
+out_free:
+	free_percpu(netdev->tstats);
+	free_netdev(netdev);
+	sw->port_list[port->qid] = NULL;
+	return err;
+}
+
+void ipqess_port_unregister(struct ipqess_port *port)
+{
+	struct net_device *netdev = port->netdev;
+
+	unregister_netdev(netdev);
+
+	devlink_port_unregister(&port->devlink_port);
+
+	rtnl_lock();
+	phylink_disconnect_phy(port->pl);
+	rtnl_unlock();
+	phylink_destroy(port->pl);
+	port->pl = NULL;
+
+	gro_cells_destroy(&port->gcells);
+
+	free_percpu(netdev->tstats);
+	free_netdev(netdev);
+}
+
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
new file mode 100644
index 000000000000..26bac45dd811
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 OR ISC */
+
+#ifndef IPQESS_PORT_H
+#define IPQESS_PORT_H
+
+#include <net/gro_cells.h>
+#include <net/devlink.h>
+
+#include "ipqess_edma.h"
+#include "ipqess_switch.h"
+
+struct ipqess_port {
+	u16 index;
+	u16 qid;
+
+	struct ipqess_edma *edma;
+	struct ipqess_switch *sw;
+	struct phylink *pl;
+	struct phylink_config pl_config;
+	struct device_node *dn;
+	struct mii_bus *mii_bus;
+	struct net_device *netdev;
+	struct devlink_port devlink_port;
+
+	u8       stp_state;
+
+	u8       mac[ETH_ALEN];
+
+	/* Warning: the following bit field is not atomic, and updating it
+	 * can only be done from code paths where concurrency is not possible
+	 * (probe time or under rtnl_lock).
+	 */
+	u8			vlan_filtering:1;
+
+	unsigned int		ageing_time;
+
+	struct gro_cells	gcells;
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	struct netpoll		*netpoll;
+#endif
+};
+
+struct ipqess_port_dump_ctx {
+	struct net_device *dev;
+	struct sk_buff *skb;
+	struct netlink_callback *cb;
+	int idx;
+};
+
+struct ipqess_mac_addr {
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	refcount_t refcount;
+	struct list_head list;
+};
+
+int ipqess_port_register(struct ipqess_switch *sw,
+			 struct device_node *port_node);
+void ipqess_port_unregister(struct ipqess_port *port);
+
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
new file mode 100644
index 000000000000..927f834a62bc
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
@@ -0,0 +1,546 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ * Based on net/dsa
+ */
+
+#include <linux/dsa/qca8k.h>
+#include <linux/of_platform.h>
+#include <linux/of_mdio.h>
+#include <linux/reset.h>
+
+#include "ipqess_switch.h"
+#include "ipqess_port.h"
+#include "ipqess_edma.h"
+
+static struct regmap_config qca8k_ipqess_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x16ac, /* end MIB - Port6 range */
+	.rd_table = &qca8k_readable_table,
+};
+
+static struct regmap_config qca8k_ipqess_psgmii_phy_regmap_config = {
+	.name = "psgmii-phy",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x7fc,
+};
+
+static const struct qca8k_match_data ipqess = {
+	.id = IPQESS_SWITCH_ID,
+	.mib_count = QCA8K_QCA833X_MIB_COUNT,
+};
+
+/* devlink */
+
+static const struct devlink_ops ipqess_devlink_ops = {
+	/* no ops supported by this driver */
+};
+
+static int ipqess_switch_devlink_alloc(struct ipqess_switch *sw)
+{
+	struct ipqess_switch **dl_priv;
+	struct devlink *dl;
+
+	/* Add the switch to devlink before calling setup, so that setup can
+	 * add dpipe tables
+	 */
+	dl = devlink_alloc(&ipqess_devlink_ops, sizeof(*dl_priv), sw->priv->dev);
+	if (!dl)
+		return -ENOMEM;
+
+	sw->devlink = dl;
+
+	dl_priv = devlink_priv(sw->devlink);
+	*dl_priv = sw;
+
+	return 0;
+}
+
+/* setup */
+
+unsigned int ipqess_switch_fastest_ageing_time(struct ipqess_switch *sw,
+					       unsigned int ageing_time)
+{
+	struct ipqess_port *port;
+	int i;
+
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port && port->ageing_time && port->ageing_time < ageing_time)
+			ageing_time = port->ageing_time;
+	}
+
+	return ageing_time;
+}
+
+int ipqess_set_ageing_time(struct ipqess_switch *sw, unsigned int msecs)
+{
+	struct qca8k_priv *priv = sw->priv;
+	unsigned int secs = msecs / 1000;
+	u32 val;
+
+	/* AGE_TIME reg is set in 7s step */
+	val = secs / 7;
+
+	/* Handle case with 0 as val to NOT disable
+	 * learning
+	 */
+	if (!val)
+		val = 1;
+
+	return regmap_update_bits(priv->regmap, QCA8K_REG_ATU_CTRL,
+				  QCA8K_ATU_AGE_TIME_MASK,
+				  QCA8K_ATU_AGE_TIME(val));
+}
+
+static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct qca8k_pcs, pcs);
+}
+
+static void ipqess_switch_pcs_get_state(struct phylink_pcs *pcs,
+					struct phylink_link_state *state)
+{
+	struct qca8k_priv *priv = pcs_to_qca8k_pcs(pcs)->priv;
+	int port = pcs_to_qca8k_pcs(pcs)->port;
+	u32 reg;
+	int ret;
+
+	ret = qca8k_read(priv, QCA8K_REG_PORT_STATUS(port), &reg);
+	if (ret < 0) {
+		state->link = false;
+		return;
+	}
+
+	state->link = !!(reg & QCA8K_PORT_STATUS_LINK_UP);
+	state->an_complete = state->link;
+	state->duplex = (reg & QCA8K_PORT_STATUS_DUPLEX) ? DUPLEX_FULL :
+							DUPLEX_HALF;
+
+	switch (reg & QCA8K_PORT_STATUS_SPEED) {
+	case QCA8K_PORT_STATUS_SPEED_10:
+		state->speed = SPEED_10;
+		break;
+	case QCA8K_PORT_STATUS_SPEED_100:
+		state->speed = SPEED_100;
+		break;
+	case QCA8K_PORT_STATUS_SPEED_1000:
+		state->speed = SPEED_1000;
+		break;
+	default:
+		state->speed = SPEED_UNKNOWN;
+		break;
+	}
+
+	if (reg & QCA8K_PORT_STATUS_RXFLOW)
+		state->pause |= MLO_PAUSE_RX;
+	if (reg & QCA8K_PORT_STATUS_TXFLOW)
+		state->pause |= MLO_PAUSE_TX;
+}
+
+static int ipqess_switch_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
+				    phy_interface_t interface,
+				    const unsigned long *advertising,
+				    bool permit_pause_to_mac)
+{
+	return 0;
+}
+
+static void ipqess_switch_pcs_an_restart(struct phylink_pcs *pcs)
+{
+}
+
+static const struct phylink_pcs_ops qca8k_pcs_ops = {
+	.pcs_get_state = ipqess_switch_pcs_get_state,
+	.pcs_config = ipqess_switch_pcs_config,
+	.pcs_an_restart = ipqess_switch_pcs_an_restart,
+};
+
+static void ipqess_switch_setup_pcs(struct qca8k_priv *priv,
+				    struct qca8k_pcs *qpcs,
+				    int port_index)
+{
+	qpcs->pcs.ops = &qca8k_pcs_ops;
+
+	/* We don't have interrupts for link changes, so we need to poll */
+	qpcs->pcs.poll = true;
+	qpcs->priv = priv;
+	qpcs->port = port_index;
+}
+
+static int ipqess_switch_setup_port(struct ipqess_switch *sw, int port_index)
+{
+	struct qca8k_priv *priv = sw->priv;
+	u32 mask = 0;
+	int ret, i;
+	u32 reg;
+
+	/* CPU port gets connected to all registered ports of the switch */
+	if (port_index == IPQESS_SWITCH_CPU_PORT) {
+		for (i = 1; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+			if (sw->port_list[i - 1])
+				mask |= BIT(i);
+		}
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_index),
+				QCA8K_PORT_LOOKUP_MEMBER, mask);
+		if (ret)
+			return ret;
+		qca8k_read(priv, QCA8K_PORT_LOOKUP_CTRL(IPQESS_SWITCH_CPU_PORT), &reg);
+
+		/* Disable CPU ARP Auto-learning by default */
+		ret = regmap_clear_bits(priv->regmap,
+					QCA8K_PORT_LOOKUP_CTRL(port_index),
+					QCA8K_PORT_LOOKUP_LEARN);
+		if (ret)
+			return ret;
+	}
+
+	/* Individual user ports get connected to CPU port only */
+	if (port_index > 0 && sw->port_list[port_index - 1]) {
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_index),
+				QCA8K_PORT_LOOKUP_MEMBER,
+				BIT(IPQESS_SWITCH_CPU_PORT));
+		if (ret)
+			return ret;
+
+		/* Enable ARP Auto-learning by default */
+		ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(port_index),
+				      QCA8K_PORT_LOOKUP_LEARN);
+		if (ret)
+			return ret;
+
+		/* For port based vlans to work we need to set the
+		 * default egress vid
+		 */
+		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port_index),
+				QCA8K_EGREES_VLAN_PORT_MASK(port_index),
+				QCA8K_EGREES_VLAN_PORT(port_index, QCA8K_PORT_VID_DEF));
+		if (ret)
+			return ret;
+
+		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port_index),
+				  QCA8K_PORT_VLAN_CVID(QCA8K_PORT_VID_DEF) |
+				  QCA8K_PORT_VLAN_SVID(QCA8K_PORT_VID_DEF));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int ipqess_switch_setup(struct ipqess_switch *sw)
+{
+	struct qca8k_priv *priv = sw->priv;
+	int ret, i;
+	u32 reg;
+
+	ipqess_switch_setup_pcs(priv, &priv->pcs_port_0, 0);
+
+	/* Enable CPU Port */
+	ret = regmap_set_bits(priv->regmap, QCA8K_REG_GLOBAL_FW_CTRL0,
+			      QCA8K_GLOBAL_FW_CTRL0_CPU_PORT_EN);
+	if (ret) {
+		dev_err(priv->dev, "failed enabling CPU port");
+		return ret;
+	}
+
+	/* Enable MIB counters */
+	ret = qca8k_mib_init(priv);
+	if (ret)
+		dev_warn(priv->dev, "MIB init failed");
+
+	/* Disable forwarding by default on all ports */
+	for (i = 0; i < IPQESS_SWITCH_NUM_PORTS; i++) {
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
+				QCA8K_PORT_LOOKUP_MEMBER, 0);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable QCA header mode on the CPU port */
+	ret = qca8k_write(priv, QCA8K_REG_PORT_HDR_CTRL(IPQESS_SWITCH_CPU_PORT),
+			  FIELD_PREP(QCA8K_PORT_HDR_CTRL_TX_MASK, QCA8K_PORT_HDR_CTRL_ALL) |
+			  FIELD_PREP(QCA8K_PORT_HDR_CTRL_RX_MASK, QCA8K_PORT_HDR_CTRL_ALL));
+	if (ret) {
+		dev_err(priv->dev, "failed enabling QCA header mode");
+		return ret;
+	}
+
+	/* Disable MAC by default on all ports */
+	for (i = 0; i < IPQESS_SWITCH_NUM_PORTS; i++) {
+		if (i > 0)
+			qca8k_port_set_status(priv, i, 0);
+	}
+
+	/* Forward all unknown frames to all ports */
+	ret = qca8k_write(priv, QCA8K_REG_GLOBAL_FW_CTRL1,
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_IGMP_DP_MASK, 0x3f) |
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_BC_DP_MASK, 0x3f) |
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK, 0x3f) |
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK, 0x3f));
+	if (ret) {
+		pr_err("Error while disabling MAC and forwarding unknown frames %d\n",
+		       ret);
+		return ret;
+	}
+
+	/* Setup connection between CPU port & user ports */
+	for (i = 0; i < IPQESS_SWITCH_NUM_PORTS; i++) {
+		ret = ipqess_switch_setup_port(sw, i);
+		if (ret)
+			return ret;
+	}
+
+	/* Setup our port MTUs to match power on defaults */
+	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, ETH_FRAME_LEN + ETH_FCS_LEN);
+	if (ret)
+		dev_warn(priv->dev, "failed setting MTU settings");
+
+	/* Flush the FDB table */
+	qca8k_fdb_flush(priv);
+
+	if (ret < 0)
+		goto devlink_free;
+
+	/* set Port0 status */
+	reg  = QCA8K_PORT_STATUS_LINK_AUTO;
+	reg |= QCA8K_PORT_STATUS_DUPLEX;
+	reg |= QCA8K_PORT_STATUS_SPEED_1000;
+	reg |= QCA8K_PORT_STATUS_RXFLOW;
+	reg |= QCA8K_PORT_STATUS_TXFLOW;
+	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(0), reg);
+	sw->port0_enabled = true;
+
+	return 0;
+
+devlink_free:
+	pr_err("qca_switch_setup error: %d\n", ret);
+	return ret;
+}
+EXPORT_SYMBOL(ipqess_switch_setup);
+
+/* probe */
+
+static void ipqess_switch_psgmii_rst(struct ipqess_switch *sw)
+{
+	reset_control_assert(sw->psgmii_rst);
+
+	mdelay(10);
+
+	reset_control_deassert(sw->psgmii_rst);
+
+	mdelay(10);
+}
+
+static int ipqess_switch_probe(struct platform_device *pdev)
+{
+	struct device_node *ports, *port_np;
+	struct device_node *np, *mdio_np;
+	struct device *dev = &pdev->dev;
+	struct ipqess_port *port = NULL;
+	void __iomem *base, *psgmii;
+	struct ipqess_switch *sw;
+	struct qca8k_priv *priv;
+	int ret;
+	int i;
+
+	sw = devm_kzalloc(dev, sizeof(struct ipqess_switch), GFP_KERNEL);
+	if (!sw)
+		return -ENOMEM;
+
+	priv = devm_kzalloc(dev, sizeof(struct qca8k_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	sw->priv = priv;
+	sw->port0_enabled = false;
+	priv->dev = dev;
+	priv->info = &ipqess;
+	priv->ds = NULL;
+
+	np = dev->of_node;
+	ports = of_get_child_by_name(np, "ports");
+	if (!ports) {
+		dev_err(dev, "no 'ports' attribute found\n");
+		return -EINVAL;
+	}
+
+	/* Start by setting up the register mapping */
+	base = devm_platform_ioremap_resource_byname(pdev, "base");
+	if (IS_ERR(base)) {
+		dev_err(dev, "platform ioremap fail %li\n", PTR_ERR(base));
+		return PTR_ERR(base);
+	}
+
+	priv->regmap = devm_regmap_init_mmio(dev, base,
+					     &qca8k_ipqess_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		ret = PTR_ERR(priv->regmap);
+		dev_err(dev, "base regmap initialization failed, %d\n", ret);
+		return ret;
+	}
+
+	psgmii = devm_platform_ioremap_resource_byname(pdev, "psgmii_phy");
+	if (IS_ERR(psgmii)) {
+		ret = PTR_ERR(psgmii);
+		dev_err(dev, "platform ioremap psgmii fail %d\n", ret);
+		return ret;
+	}
+
+	priv->psgmii = devm_regmap_init_mmio(dev, psgmii,
+					     &qca8k_ipqess_psgmii_phy_regmap_config);
+	if (IS_ERR(priv->psgmii)) {
+		ret = PTR_ERR(priv->psgmii);
+		dev_err(dev, "PSGMII regmap initialization failed, %d\n", ret);
+		return ret;
+	}
+
+	mdio_np = of_parse_phandle(np, "mdio", 0);
+	if (!mdio_np) {
+		dev_err(dev, "unable to get MDIO bus phandle\n");
+		of_node_put(mdio_np);
+		return -EINVAL;
+	}
+
+	priv->bus = of_mdio_find_bus(mdio_np);
+	of_node_put(mdio_np);
+	if (!priv->bus) {
+		dev_err(dev, "unable to find MDIO bus\n");
+		return -EPROBE_DEFER;
+	}
+
+	/* If we don't reset the PSGMII here the switch id check will fail */
+	sw->psgmii_rst = devm_reset_control_get(&pdev->dev, "psgmii");
+	if (IS_ERR(sw->psgmii_rst)) {
+		ret = PTR_ERR(sw->psgmii_rst);
+		dev_err(dev, "Unable to get PSGMII reset line: err %d\n", ret);
+		return ret;
+	}
+
+	ipqess_switch_psgmii_rst(sw);
+
+	/* Check the detected switch id */
+	ret = qca8k_read_switch_id(sw->priv);
+	if (ret) {
+		dev_err(dev, "Failed to read switch id! error %d\n", ret);
+		return ret;
+	}
+
+	priv->ds = NULL;
+
+	mutex_init(&sw->addr_lists_lock);
+	INIT_LIST_HEAD(&sw->fdbs);
+	INIT_LIST_HEAD(&sw->mdbs);
+
+	mutex_init(&priv->reg_mutex);
+	platform_set_drvdata(pdev, sw);
+
+	ret = ipqess_switch_devlink_alloc(sw);
+	if (ret)
+		goto out_devlink;
+
+	devlink_register(sw->devlink);
+
+	/* Register switch front-facing ports */
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++)
+		sw->port_list[i] = NULL;
+
+	for_each_available_child_of_node(ports, port_np) {
+		ret = ipqess_port_register(sw, port_np);
+		if (ret) {
+			pr_err("Failed to register ipqess port! error %d\n", ret);
+			goto out_ports;
+		}
+	}
+	if (!sw->napi_leader) {
+		pr_err("No switch port registered as napi leader!\n");
+		ret = -EINVAL;
+		goto out_ports;
+	}
+
+	ret = ipqess_edma_init(pdev, np);
+	if (ret) {
+		dev_err(dev, "Failed to initialize EDMA controller! error %d\n", ret);
+		goto out_ports;
+	}
+
+	ipqess_switch_setup(sw);
+
+	return 0;
+
+out_ports:
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port)
+			ipqess_port_unregister(port);
+	}
+out_devlink:
+	devlink_free(sw->devlink);
+	pr_err("%s failed with error %d\n", __func__, ret);
+	return ret;
+}
+
+static int
+ipqess_switch_remove(struct platform_device *pdev)
+{
+	struct ipqess_switch *sw = platform_get_drvdata(pdev);
+	struct qca8k_priv *priv = sw->priv;
+	struct ipqess_port *port = NULL;
+	int i;
+
+	if (!sw)
+		return 0;
+
+	/* Release EDMA driver */
+	ipqess_edma_uninit(sw->edma);
+
+	/* Disable all user ports */
+	for (i = 1; i < QCA8K_NUM_PORTS; i++) {
+		qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
+			  QCA8K_PORT_LOOKUP_STATE_MASK,
+			  QCA8K_PORT_LOOKUP_STATE_DISABLED);
+		qca8k_port_set_status(priv, i, 0);
+		priv->port_enabled_map &= ~BIT(i);
+	}
+
+	/* Unregister user ports */
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port)
+			ipqess_port_unregister(port);
+	}
+
+	devlink_unregister(sw->devlink);
+	devlink_free(sw->devlink);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id qca8k_ipqess_of_match[] = {
+	{ .compatible = "qcom,ipq4019-ess", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver qca8k_ipqess_driver = {
+	.probe = ipqess_switch_probe,
+	.remove = ipqess_switch_remove,
+	.driver = {
+		.name = "ipqess",
+		.of_match_table = qca8k_ipqess_of_match,
+	},
+};
+
+module_platform_driver(qca8k_ipqess_driver);
+
+MODULE_AUTHOR("Romain Gantois <romain.gantois@bootlin.org>");
+MODULE_AUTHOR("Mathieu Olivari, John Crispin <john@phrozen.org>");
+MODULE_AUTHOR("Gabor Juhos <j4g8y7@gmail.com>, Robert Marko <robert.marko@sartura.hr>");
+MODULE_DESCRIPTION("Qualcomm IPQ4019 Ethernet Switch Subsystem driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
new file mode 100644
index 000000000000..221c628d1728
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 OR ISC */
+
+#ifndef IPQESS_SWITCH_H
+#define IPQESS_SWITCH_H
+
+#include <linux/dsa/qca8k.h>
+
+#define IPQESS_SWITCH_MAX_PORTS       5
+#define IPQESS_SWITCH_AGEING_TIME_MIN 7000
+#define IPQESS_SWITCH_AGEING_TIME_MAX 458745000
+#define IPQESS_SWITCH_CPU_PORT        0
+#define IPQESS_SWITCH_NUM_PORTS       5
+#define IPQESS_SWITCH_ID              0x14
+
+struct ipqess_switch {
+	struct net_device *napi_leader;
+	struct qca8k_priv *priv;
+	struct ipqess_edma *edma;
+	struct ipqess_port *port_list[IPQESS_SWITCH_MAX_PORTS];
+	struct devlink *devlink;
+	struct reset_control *psgmii_rst;
+	bool port0_enabled;
+
+	/* List of MAC addresses that must be forwarded on the cpu port */
+	struct mutex		addr_lists_lock;
+	struct list_head	fdbs;
+	struct list_head	mdbs;
+};
+
+unsigned int ipqess_switch_fastest_ageing_time(struct ipqess_switch *sw,
+					       unsigned int ageing_time);
+int ipqess_set_ageing_time(struct ipqess_switch *sw, unsigned int msecs);
+
+int ipqess_switch_setup(struct ipqess_switch *sw);
+
+#endif
diff --git a/include/linux/dsa/qca8k.h b/include/linux/dsa/qca8k.h
index 3c75c3704fa0..cafb727f4e8b 100644
--- a/include/linux/dsa/qca8k.h
+++ b/include/linux/dsa/qca8k.h
@@ -266,6 +266,7 @@
 #define   QCA8K_PORT_LOOKUP_STATE_LEARNING		QCA8K_PORT_LOOKUP_STATE(0x3)
 #define   QCA8K_PORT_LOOKUP_STATE_FORWARD		QCA8K_PORT_LOOKUP_STATE(0x4)
 #define   QCA8K_PORT_LOOKUP_LEARN			BIT(20)
+#define   QCA8K_PORT_LOOKUP_LOOPBACK_EN			BIT(21)
 #define   QCA8K_PORT_LOOKUP_ING_MIRROR_EN		BIT(25)
 
 #define QCA8K_REG_GOL_TRUNK_CTRL0			0x700
@@ -342,6 +343,31 @@
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
 enum {
 	QCA8K_PORT_SPEED_10M = 0,
 	QCA8K_PORT_SPEED_100M = 1,
@@ -467,6 +493,9 @@ struct qca8k_priv {
 	struct qca8k_pcs pcs_port_6;
 	const struct qca8k_match_data *info;
 	struct qca8k_led ports_led[QCA8K_LED_COUNT];
+
+	/* IPQ4019 specific */
+	struct regmap *psgmii;
 };
 
 struct qca8k_mib_desc {
@@ -507,6 +536,8 @@ int qca8k_read_switch_id(struct qca8k_priv *priv);
 int qca8k_read(struct qca8k_priv *priv, u32 reg, u32 *val);
 int qca8k_write(struct qca8k_priv *priv, u32 reg, u32 val);
 int qca8k_rmw(struct qca8k_priv *priv, u32 reg, u32 mask, u32 write_val);
+int qca8k_set_bits(struct qca8k_priv *priv, u32 reg, u32 bits);
+int qca8k_clear_bits(struct qca8k_priv *priv, u32 reg, u32 bits);
 
 /* Common ops function */
 void qca8k_fdb_flush(struct qca8k_priv *priv);
@@ -560,6 +591,16 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
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
@@ -577,8 +618,12 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
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

