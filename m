Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB17EAE65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjKNK4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjKNK4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:56:02 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DFF1A8;
        Tue, 14 Nov 2023 02:55:57 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7113E2000A;
        Tue, 14 Nov 2023 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699959356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuuOCKjlqLcnvt3M5sD79QPuk+XlpLSx15DuBOECLAE=;
        b=Y4+2OtAmY6PQy809BY9Ysb4e8ftI4RUQfxbQE/Zlz8DC3ZLfZk1VqtXQeT5jixKNF7Beat
        +m+ZA3xQonaKpTLSbc8jDzjEL8xxmsvEhOPfGoRTnMMJyH4RzOv4DtT4xkp6bMFdwXqPdx
        nD84n9/tQjw01TN3EGRmbUbdyU81MmCq6FXcSMpAdJLMMtf1aN1sQHBSNxzkPbQNpK39Me
        3oK2wYFGGNneEMfG11VV0huIDVLmqaCZeE/0yHLGnrEVQCuudTDrXkcxtuGn1YOVkz6hqR
        1nqnP/WIDC+PYjvhwMYyYE9hsfCGGiZ96StKiR+dyQT+4F8cY6mmnpn1GOrTAA==
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
Subject: [PATCH net-next v3 4/8] net: qualcomm: ipqess: Add Ethtool ops to IPQESS port netdevices
Date:   Tue, 14 Nov 2023 11:55:54 +0100
Message-ID: <20231114105600.1012056-5-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114105600.1012056-1-romain.gantois@bootlin.com>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQESS driver registers one netdevice for each front-facing switch
port. Add support for several ethtool operations to these netdevices.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/ethernet/qualcomm/ipqess/Makefile |   2 +-
 .../ethernet/qualcomm/ipqess/ipqess_ethtool.c | 245 ++++++++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_port.c    |   1 +
 .../ethernet/qualcomm/ipqess/ipqess_port.h    |   3 +
 4 files changed, 250 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c

diff --git a/drivers/net/ethernet/qualcomm/ipqess/Makefile b/drivers/net/ethernet/qualcomm/ipqess/Makefile
index f389080cc5aa..6253f1b0ffd2 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/Makefile
+++ b/drivers/net/ethernet/qualcomm/ipqess/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess.o
 
-ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_edma.o
+ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_edma.o ipqess_ethtool.o
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c
new file mode 100644
index 000000000000..06a8f2cccc4e
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Ethtool operations for a single switch port
+ *
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ * Based on net/dsa
+ */
+
+#include <net/selftests.h>
+
+#include "ipqess_port.h"
+
+static void ipqess_port_get_drvinfo(struct net_device *dev,
+				    struct ethtool_drvinfo *drvinfo)
+{
+	strscpy(drvinfo->driver, "qca8k-ipqess", sizeof(drvinfo->driver));
+	strscpy(drvinfo->bus_info, "platform", sizeof(drvinfo->bus_info));
+}
+
+static int ipqess_port_nway_reset(struct net_device *dev)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_nway_reset(port->pl);
+}
+
+static const char ipqess_gstrings_base_stats[][ETH_GSTRING_LEN] = {
+	"tx_packets",
+	"tx_bytes",
+	"rx_packets",
+	"rx_bytes",
+};
+
+static void ipqess_port_get_strings(struct net_device *dev,
+				    u32 stringset, u8 *data)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+	int i;
+
+	if (stringset == ETH_SS_STATS) {
+		memcpy(data, &ipqess_gstrings_base_stats,
+		       sizeof(ipqess_gstrings_base_stats));
+
+		if (stringset != ETH_SS_STATS)
+			return;
+
+		for (i = 0; i < priv->info->mib_count; i++)
+			memcpy(data + (4 + i) * ETH_GSTRING_LEN,
+			       ar8327_mib[i].name,
+			       ETH_GSTRING_LEN);
+
+	} else if (stringset == ETH_SS_TEST) {
+		net_selftest_get_strings(data);
+	}
+}
+
+static void ipqess_port_get_ethtool_stats(struct net_device *dev,
+					  struct ethtool_stats *stats,
+					  uint64_t *data)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+	const struct qca8k_mib_desc *mib;
+	struct pcpu_sw_netstats *s;
+	unsigned int start;
+	u32 reg, c, val;
+	u32 hi = 0;
+	int ret;
+	int i;
+
+	for_each_possible_cpu(i) {
+		u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
+
+		s = per_cpu_ptr(dev->tstats, i);
+		do {
+			start = u64_stats_fetch_begin(&s->syncp);
+			tx_packets = u64_stats_read(&s->tx_packets);
+			tx_bytes = u64_stats_read(&s->tx_bytes);
+			rx_packets = u64_stats_read(&s->rx_packets);
+			rx_bytes = u64_stats_read(&s->rx_bytes);
+		} while (u64_stats_fetch_retry(&s->syncp, start));
+		data[0] += tx_packets;
+		data[1] += tx_bytes;
+		data[2] += rx_packets;
+		data[3] += rx_bytes;
+	}
+
+	for (c = 0; c < priv->info->mib_count; c++) {
+		mib = &ar8327_mib[c];
+		reg = QCA8K_PORT_MIB_COUNTER(port->index) + mib->offset;
+
+		ret = qca8k_read(priv, reg, &val);
+		if (ret < 0)
+			continue;
+
+		if (mib->size == 2) {
+			ret = qca8k_read(priv, reg + 4, &hi);
+			if (ret < 0)
+				continue;
+		}
+
+		data[4 + c] = val;
+		if (mib->size == 2)
+			data[4 + c] |= (u64)hi << 32;
+	}
+}
+
+static int ipqess_port_get_sset_count(struct net_device *dev, int sset)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+
+	if (sset == ETH_SS_STATS) {
+		int count = 0;
+
+		if (sset != ETH_SS_STATS)
+			count = 0;
+		else
+			count = priv->info->mib_count;
+
+		if (count < 0)
+			return count;
+
+		return count + 4;
+	} else if (sset == ETH_SS_TEST) {
+		return net_selftest_get_count();
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int ipqess_port_set_wol(struct net_device *dev,
+			       struct ethtool_wolinfo *w)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_set_wol(port->pl, w);
+}
+
+static void ipqess_port_get_wol(struct net_device *dev,
+				struct ethtool_wolinfo *w)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	phylink_ethtool_get_wol(port->pl, w);
+}
+
+static int ipqess_port_set_eee(struct net_device *dev, struct ethtool_eee *eee)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	int ret;
+	u32 lpi_en = QCA8K_REG_EEE_CTRL_LPI_EN(port->index);
+	struct qca8k_priv *priv = port->sw->priv;
+	u32 lpi_ctl1;
+
+	/* Port's PHY and MAC both need to be EEE capable */
+	if (!dev->phydev || !port->pl)
+		return -ENODEV;
+
+	mutex_lock(&priv->reg_mutex);
+	lpi_ctl1 = qca8k_read(priv, QCA8K_REG_EEE_CTRL, &lpi_ctl1);
+	if (lpi_ctl1 < 0) {
+		mutex_unlock(&priv->reg_mutex);
+		return ret;
+	}
+
+	if (eee->tx_lpi_enabled && eee->eee_enabled)
+		lpi_ctl1 |= lpi_en;
+	else
+		lpi_ctl1 &= ~lpi_en;
+	ret = qca8k_write(priv, QCA8K_REG_EEE_CTRL, lpi_ctl1);
+	mutex_unlock(&priv->reg_mutex);
+
+	if (ret)
+		return ret;
+
+	return phylink_ethtool_set_eee(port->pl, eee);
+}
+
+static int ipqess_port_get_eee(struct net_device *dev, struct ethtool_eee *e)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	/* Port's PHY and MAC both need to be EEE capable */
+	if (!dev->phydev || !port->pl)
+		return -ENODEV;
+
+	return phylink_ethtool_get_eee(port->pl, e);
+}
+
+static int ipqess_port_get_link_ksettings(struct net_device *dev,
+					  struct ethtool_link_ksettings *cmd)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_ksettings_get(port->pl, cmd);
+}
+
+static int ipqess_port_set_link_ksettings(struct net_device *dev,
+					  const struct ethtool_link_ksettings *cmd)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_ksettings_set(port->pl, cmd);
+}
+
+static void ipqess_port_get_pauseparam(struct net_device *dev,
+				       struct ethtool_pauseparam *pause)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	phylink_ethtool_get_pauseparam(port->pl, pause);
+}
+
+static int ipqess_port_set_pauseparam(struct net_device *dev,
+				      struct ethtool_pauseparam *pause)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_set_pauseparam(port->pl, pause);
+}
+
+static const struct ethtool_ops ipqess_port_ethtool_ops = {
+	.get_drvinfo            = ipqess_port_get_drvinfo,
+	.nway_reset             = ipqess_port_nway_reset,
+	.get_link               = ethtool_op_get_link,
+	.get_strings            = ipqess_port_get_strings,
+	.get_ethtool_stats      = ipqess_port_get_ethtool_stats,
+	.get_sset_count         = ipqess_port_get_sset_count,
+	.self_test              = net_selftest,
+	.set_wol                = ipqess_port_set_wol,
+	.get_wol                = ipqess_port_get_wol,
+	.set_eee                = ipqess_port_set_eee,
+	.get_eee                = ipqess_port_get_eee,
+	.get_link_ksettings     = ipqess_port_get_link_ksettings,
+	.set_link_ksettings     = ipqess_port_set_link_ksettings,
+	.get_pauseparam         = ipqess_port_get_pauseparam,
+	.set_pauseparam         = ipqess_port_set_pauseparam,
+};
+
+void ipqess_port_set_ethtool_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &ipqess_port_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
index f0f5fe3a7c24..52d7baa7cae0 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
@@ -684,6 +684,7 @@ int ipqess_port_register(struct ipqess_switch *sw,
 	netdev->dev.of_node = port->dn;
 
 	netdev->rtnl_link_ops = &ipqess_port_link_ops;
+	ipqess_port_set_ethtool_ops(netdev);
 
 	netdev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 	if (!netdev->tstats) {
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
index 26bac45dd811..19d4b5d73625 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
@@ -59,4 +59,7 @@ int ipqess_port_register(struct ipqess_switch *sw,
 			 struct device_node *port_node);
 void ipqess_port_unregister(struct ipqess_port *port);
 
+/* Defined in ipqess_ethtool.c */
+void ipqess_port_set_ethtool_ops(struct net_device *netdev);
+
 #endif
-- 
2.42.0

