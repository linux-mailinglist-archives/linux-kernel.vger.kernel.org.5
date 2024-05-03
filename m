Return-Path: <linux-kernel+bounces-167684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3F78BAD70
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E13B21D02
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03099156C5B;
	Fri,  3 May 2024 13:14:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B71514E4
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742054; cv=none; b=cXccBXMBIDung4Mrbu6ykSlE83GM0E70xapwOYTyttxykiezqJ61384NpTXmeOzhQcmvjamKElYh3Zbb7XxVPfThBFf9d0llupem5xlo01VXCIpDpOJJvz5a31qIxBCOYmjzqw6u/eoBz4vIaFKR+sDa8rXxq4/ll6h5HP6kVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742054; c=relaxed/simple;
	bh=wPlqpNcXNTq2uI/ebP1XEfVX1/oJMULiK+SesdSkB4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ommsF0fy34tf8N9XTK/IOT/sy5ew/q9Y5IZCJO3HyXJliXCVp0dH4Vrl/wnn6EyBbMTKBEPVIzBHa2gxejrN8exMqWen4jt42XV5RrNs61Udjwusa3i//4Y+mYZtNibWyHIy4I8ti2B8FOlVCY5TGZ6AxoE6L7ilP0r86wQBSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjb-0006EH-6l; Fri, 03 May 2024 15:13:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-00FiKC-OG; Fri, 03 May 2024 15:13:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-008GH8-29;
	Fri, 03 May 2024 15:13:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v7 05/12] net: dsa: microchip: add support for different DCB app configurations
Date: Fri,  3 May 2024 15:13:44 +0200
Message-Id: <20240503131351.1969097-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503131351.1969097-1-o.rempel@pengutronix.de>
References: <20240503131351.1969097-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add DCB support to configure app trust sources and default port priority.

Following commands can be used for testing:
dcb apptrust set dev lan1 order pcp dscp
dcb app replace dev lan1 default-prio 3

Since it is not possible to configure DSCP-Prio mapping per port, this
patch provide only ability to read switch global dscp-prio mapping and
way to enable/disable app trust for DSCP.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
changes v5:
- reorder port_set_apptrust and port_get_apptrust
- s/defult/default
- group all the get register function in top of file
- s/invalid/err_sel_not_vaild
- s/apptrus_/apptrust_
changes v3:
- move ksz8_port2_supported_apptrust[] to a followup patch
---
 drivers/net/dsa/microchip/Kconfig      |   2 +
 drivers/net/dsa/microchip/Makefile     |   2 +-
 drivers/net/dsa/microchip/ksz_common.c |  12 +-
 drivers/net/dsa/microchip/ksz_common.h |   5 +
 drivers/net/dsa/microchip/ksz_dcb.c    | 543 +++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_dcb.h    |  21 +
 6 files changed, 583 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/dsa/microchip/ksz_dcb.c
 create mode 100644 drivers/net/dsa/microchip/ksz_dcb.h

diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
index 394ca8678d2ba..c1b906c05a025 100644
--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -4,6 +4,8 @@ menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
 	depends on NET_DSA
 	select NET_DSA_TAG_KSZ
 	select NET_DSA_TAG_NONE
+	select NET_IEEE8021Q_HELPERS
+	select DCB
 	help
 	  This driver adds support for Microchip KSZ9477 series switch and
 	  KSZ8795/KSZ88x3 switch chips.
diff --git a/drivers/net/dsa/microchip/Makefile b/drivers/net/dsa/microchip/Makefile
index 49459a50dbc81..1cfba1ec9355a 100644
--- a/drivers/net/dsa/microchip/Makefile
+++ b/drivers/net/dsa/microchip/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON)	+= ksz_switch.o
-ksz_switch-objs := ksz_common.o
+ksz_switch-objs := ksz_common.o ksz_dcb.o
 ksz_switch-objs += ksz9477.o ksz9477_acl.o ksz9477_tc_flower.o
 ksz_switch-objs += ksz8795.o
 ksz_switch-objs += lan937x_main.o
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 034d4a5c63fbf..5f02559a18bf5 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -28,6 +28,7 @@
 #include <net/switchdev.h>
 
 #include "ksz_common.h"
+#include "ksz_dcb.h"
 #include "ksz_ptp.h"
 #include "ksz8.h"
 #include "ksz9477.h"
@@ -2411,6 +2412,10 @@ static int ksz_setup(struct dsa_switch *ds)
 		goto out_ptp_clock_unregister;
 	}
 
+	ret = ksz_dcb_init(dev);
+	if (ret)
+		goto out_ptp_clock_unregister;
+
 	/* start switch */
 	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
 			   SW_START, SW_START);
@@ -2739,7 +2744,7 @@ static int ksz_port_setup(struct dsa_switch *ds, int port)
 	 * there is no need to do anything.
 	 */
 
-	return 0;
+	return ksz_dcb_init_port(dev, port);
 }
 
 void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
@@ -3983,6 +3988,11 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.port_setup_tc		= ksz_setup_tc,
 	.get_mac_eee		= ksz_get_mac_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
+	.port_get_default_prio	= ksz_port_get_default_prio,
+	.port_set_default_prio	= ksz_port_set_default_prio,
+	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
+	.port_get_apptrust	= ksz_port_get_apptrust,
+	.port_set_apptrust	= ksz_port_set_apptrust,
 };
 
 struct ksz_device *ksz_switch_alloc(struct device *base, void *priv)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 962e060f6f829..a0ae9dffa133f 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -620,6 +620,11 @@ static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 	return dev->chip_id == KSZ8830_CHIP_ID;
 }
 
+static inline bool is_ksz8(struct ksz_device *dev)
+{
+	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev);
+}
+
 static inline int is_lan937x(struct ksz_device *dev)
 {
 	return dev->chip_id == LAN9370_CHIP_ID ||
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
new file mode 100644
index 0000000000000..de46329ed6e85
--- /dev/null
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+
+#include <linux/dsa/ksz_common.h>
+#include <net/dsa.h>
+#include <net/dscp.h>
+#include <net/ieee8021q.h>
+
+#include "ksz_common.h"
+#include "ksz_dcb.h"
+#include "ksz8.h"
+
+#define KSZ8_REG_PORT_1_CTRL_0			0x10
+#define KSZ8_PORT_DIFFSERV_ENABLE		BIT(6)
+#define KSZ8_PORT_802_1P_ENABLE			BIT(5)
+#define KSZ8_PORT_BASED_PRIO_M			GENMASK(4, 3)
+
+#define KSZ88X3_REG_TOS_DSCP_CTRL		0x60
+#define KSZ8765_REG_TOS_DSCP_CTRL		0x90
+
+#define KSZ9477_REG_SW_MAC_TOS_CTRL		0x033e
+#define KSZ9477_SW_TOS_DSCP_REMAP		BIT(0)
+#define KSZ9477_SW_TOS_DSCP_DEFAULT_PRIO_M	GENMASK(5, 3)
+
+#define KSZ9477_REG_DIFFSERV_PRIO_MAP		0x0340
+
+#define KSZ9477_REG_PORT_MRI_PRIO_CTRL		0x0801
+#define KSZ9477_PORT_HIGHEST_PRIO		BIT(7)
+#define KSZ9477_PORT_OR_PRIO			BIT(6)
+#define KSZ9477_PORT_MAC_PRIO_ENABLE		BIT(4)
+#define KSZ9477_PORT_VLAN_PRIO_ENABLE		BIT(3)
+#define KSZ9477_PORT_802_1P_PRIO_ENABLE		BIT(2)
+#define KSZ9477_PORT_DIFFSERV_PRIO_ENABLE	BIT(1)
+#define KSZ9477_PORT_ACL_PRIO_ENABLE		BIT(0)
+
+#define KSZ9477_REG_PORT_MRI_MAC_CTRL		0x0802
+#define KSZ9477_PORT_BASED_PRIO_M		GENMASK(2, 0)
+
+struct ksz_apptrust_map {
+	u8 apptrust;
+	u8 bit;
+};
+
+static const struct ksz_apptrust_map ksz8_apptrust_map_to_bit[] = {
+	{ DCB_APP_SEL_PCP, KSZ8_PORT_802_1P_ENABLE },
+	{ IEEE_8021QAZ_APP_SEL_DSCP, KSZ8_PORT_DIFFSERV_ENABLE },
+};
+
+static const struct ksz_apptrust_map ksz9477_apptrust_map_to_bit[] = {
+	{ DCB_APP_SEL_PCP, KSZ9477_PORT_802_1P_PRIO_ENABLE },
+	{ IEEE_8021QAZ_APP_SEL_DSCP, KSZ9477_PORT_DIFFSERV_PRIO_ENABLE },
+};
+
+/* ksz_supported_apptrust[] - Supported apptrust selectors and Priority Order
+ *			      of Internal Priority Value (IPV) sources.
+ *
+ * This array defines the apptrust selectors supported by the hardware, where
+ * the index within the array indicates the priority of the selector - lower
+ * indices correspond to higher priority. This fixed priority scheme is due to
+ * the hardware's design, which does not support configurable priority among
+ * different priority sources.
+ *
+ * The priority sources, including Tail Tag, ACL, VLAN PCP and DSCP are ordered
+ * by the hardware's fixed logic, as detailed below. The order reflects a
+ * non-configurable precedence where certain types of priority information
+ * override others:
+ *
+ * 1. Tail Tag - Highest priority, overrides ACL, VLAN PCP, and DSCP priorities.
+ * 2. ACL - Overrides VLAN PCP and DSCP priorities.
+ * 3. VLAN PCP - Overrides DSCP priority.
+ * 4. DSCP - Lowest priority, does not override any other priority source.
+ *
+ * In this context, the array's lower index (higher priority) for
+ * 'DCB_APP_SEL_PCP' suggests its relative priority over
+ * 'IEEE_8021QAZ_APP_SEL_DSCP' within the system's fixed priority scheme.
+ *
+ * DCB_APP_SEL_PCP - Priority Code Point selector
+ * IEEE_8021QAZ_APP_SEL_DSCP - Differentiated Services Code Point selector
+ */
+static const u8 ksz_supported_apptrust[] = {
+	DCB_APP_SEL_PCP,
+	IEEE_8021QAZ_APP_SEL_DSCP,
+};
+
+static const char * const ksz_supported_apptrust_variants[] = {
+	"empty", "dscp", "pcp", "dscp pcp"
+};
+
+static void ksz_get_default_port_prio_reg(struct ksz_device *dev, int *reg,
+					  u8 *mask, int *shift)
+{
+	if (is_ksz8(dev)) {
+		*reg = KSZ8_REG_PORT_1_CTRL_0;
+		*mask = KSZ8_PORT_BASED_PRIO_M;
+		*shift = __bf_shf(KSZ8_PORT_BASED_PRIO_M);
+	} else {
+		*reg = KSZ9477_REG_PORT_MRI_MAC_CTRL;
+		*mask = KSZ9477_PORT_BASED_PRIO_M;
+		*shift = __bf_shf(KSZ9477_PORT_BASED_PRIO_M);
+	}
+}
+
+/**
+ * ksz_get_dscp_prio_reg - Retrieves the DSCP-to-priority-mapping register
+ * @dev: Pointer to the KSZ switch device structure
+ * @reg: Pointer to the register address to be set
+ * @per_reg: Pointer to the number of DSCP values per register
+ * @mask: Pointer to the mask to be set
+ *
+ * This function retrieves the DSCP to priority mapping register, the number of
+ * DSCP values per register, and the mask to be set.
+ */
+static void ksz_get_dscp_prio_reg(struct ksz_device *dev, int *reg,
+				  int *per_reg, u8 *mask)
+{
+	if (ksz_is_ksz87xx(dev)) {
+		*reg = KSZ8765_REG_TOS_DSCP_CTRL;
+		*per_reg = 4;
+		*mask = GENMASK(1, 0);
+	} else if (ksz_is_ksz88x3(dev)) {
+		*reg = KSZ88X3_REG_TOS_DSCP_CTRL;
+		*per_reg = 4;
+		*mask = GENMASK(1, 0);
+	} else {
+		*reg = KSZ9477_REG_DIFFSERV_PRIO_MAP;
+		*per_reg = 2;
+		*mask = GENMASK(2, 0);
+	}
+}
+
+/**
+ * ksz_get_apptrust_map_and_reg - Retrieves the apptrust map and register
+ * @dev: Pointer to the KSZ switch device structure
+ * @map: Pointer to the apptrust map to be set
+ * @reg: Pointer to the register address to be set
+ * @mask: Pointer to the mask to be set
+ *
+ * This function retrieves the apptrust map and register address for the
+ * apptrust configuration.
+ */
+static void ksz_get_apptrust_map_and_reg(struct ksz_device *dev,
+					 const struct ksz_apptrust_map **map,
+					 int *reg, u8 *mask)
+{
+	if (is_ksz8(dev)) {
+		*map = ksz8_apptrust_map_to_bit;
+		*reg = KSZ8_REG_PORT_1_CTRL_0;
+		*mask = KSZ8_PORT_DIFFSERV_ENABLE | KSZ8_PORT_802_1P_ENABLE;
+	} else {
+		*map = ksz9477_apptrust_map_to_bit;
+		*reg = KSZ9477_REG_PORT_MRI_PRIO_CTRL;
+		*mask = KSZ9477_PORT_802_1P_PRIO_ENABLE |
+			KSZ9477_PORT_DIFFSERV_PRIO_ENABLE;
+	}
+}
+
+/**
+ * ksz_port_get_default_prio - Retrieves the default priority for a port on a
+ *			       KSZ switch
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number from which to get the default priority
+ *
+ * This function fetches the default priority for the specified port on a KSZ
+ * switch.
+ *
+ * Return: The default priority of the port on success, or a negative error
+ * code on failure.
+ */
+int ksz_port_get_default_prio(struct dsa_switch *ds, int port)
+{
+	struct ksz_device *dev = ds->priv;
+	int ret, reg, shift;
+	u8 data, mask;
+
+	ksz_get_default_port_prio_reg(dev, &reg, &mask, &shift);
+
+	ret = ksz_pread8(dev, port, reg, &data);
+	if (ret)
+		return ret;
+
+	return (data & mask) >> shift;
+}
+
+/**
+ * ksz_port_set_default_prio - Sets the default priority for a port on a KSZ
+ *			       switch
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number for which to set the default priority
+ * @prio: Priority value to set
+ *
+ * This function sets the default priority for the specified port on a KSZ
+ * switch.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
+{
+	struct ksz_device *dev = ds->priv;
+	int reg, shift;
+	u8 mask;
+
+	if (prio >= dev->info->num_ipvs)
+		return -EINVAL;
+
+	ksz_get_default_port_prio_reg(dev, &reg, &mask, &shift);
+
+	return ksz_prmw8(dev, port, reg, mask, (prio << shift) & mask);
+}
+
+/**
+ * ksz_port_get_dscp_prio - Retrieves the priority for a DSCP value on a KSZ
+ *			    switch
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number for which to get the priority
+ * @dscp: DSCP value for which to get the priority
+ *
+ * This function fetches the priority value from switch global DSCP-to-priorty
+ * mapping table for the specified DSCP value.
+ *
+ * Return: The priority value for the DSCP on success, or a negative error
+ * code on failure.
+ */
+int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
+{
+	struct ksz_device *dev = ds->priv;
+	int reg, per_reg, ret, shift;
+	u8 data, mask;
+
+	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
+
+	/* If DSCP remapping is disabled, DSCP bits 3-5 are used as Internal
+	 * Priority Value (IPV)
+	 */
+	if (!is_ksz8(dev)) {
+		ret = ksz_read8(dev, KSZ9477_REG_SW_MAC_TOS_CTRL, &data);
+		if (ret)
+			return ret;
+
+		/* If DSCP remapping is disabled, DSCP bits 3-5 are used as
+		 * Internal Priority Value (IPV)
+		 */
+		if (!(data & KSZ9477_SW_TOS_DSCP_REMAP))
+			return FIELD_GET(KSZ9477_SW_TOS_DSCP_DEFAULT_PRIO_M,
+					 dscp);
+	}
+
+	/* In case DSCP remapping is enabled, we need to write the DSCP to
+	 * priority mapping table.
+	 */
+	reg += dscp / per_reg;
+	ret = ksz_read8(dev, reg, &data);
+	if (ret)
+		return ret;
+
+	shift = (dscp % per_reg) * (8 / per_reg);
+
+	return (data >> shift) & mask;
+}
+
+/**
+ * ksz_init_global_dscp_map - Initializes the global DSCP-to-priority mapping
+ * @dev: Pointer to the KSZ switch device structure
+ *
+ * This function initializes the global DSCP-to-priority mapping table for the
+ * switch.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz_init_global_dscp_map(struct ksz_device *dev)
+{
+	int reg, per_reg, ret, dscp;
+	u8 data = 0;
+	u8 mask;
+
+	/* On KSZ9xxx variants, DSCP remapping is disabled by default.
+	 * Enable to have, predictable and reproducible behavior across
+	 * different devices.
+	 */
+	if (!is_ksz8(dev)) {
+		ret = ksz_rmw8(dev, KSZ9477_REG_SW_MAC_TOS_CTRL,
+			       KSZ9477_SW_TOS_DSCP_REMAP,
+			       KSZ9477_SW_TOS_DSCP_REMAP);
+		if (ret)
+			return ret;
+	}
+
+	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
+
+	for (dscp = 0; dscp < DSCP_MAX; dscp++) {
+		int ipv, shift, tt;
+
+		/* Map DSCP to Traffic Type, which is corresponding to the
+		 * Internal Priority Value (IPV) in the switch.
+		 */
+		if (!is_ksz8(dev)) {
+			ipv = ietf_dscp_to_ieee8021q_tt(dscp);
+		} else {
+			/* On KSZ8xxx variants we do not have IPV to queue
+			 * remapping table. We need to convert DSCP to Traffic
+			 * Type and then to queue.
+			 */
+			tt = ietf_dscp_to_ieee8021q_tt(dscp);
+			if (tt < 0)
+				return tt;
+
+			ipv = ieee8021q_tt_to_tc(tt, dev->info->num_tx_queues);
+		}
+
+		if (ipv < 0)
+			return ipv;
+
+		shift = (dscp % per_reg) * (8 / per_reg);
+		data |= (ipv & mask) << shift;
+
+		if (dscp % per_reg == per_reg - 1) {
+			ret = ksz_write8(dev, reg + (dscp / per_reg), data);
+			if (ret)
+				return ret;
+
+			data = 0;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ksz_apptrust_error - Prints an error message for an invalid apptrust selector
+ * @dev: Pointer to the KSZ switch device structure
+ *
+ * This function prints an error message when an invalid apptrust selector is
+ * provided.
+ */
+static void ksz_apptrust_error(struct ksz_device *dev)
+{
+	char supported_apptrust_variants[64];
+	int i;
+
+	supported_apptrust_variants[0] = '\0';
+	for (i = 0; i < ARRAY_SIZE(ksz_supported_apptrust_variants); i++) {
+		if (i > 0)
+			strlcat(supported_apptrust_variants, ", ",
+				sizeof(supported_apptrust_variants));
+		strlcat(supported_apptrust_variants,
+			ksz_supported_apptrust_variants[i],
+			sizeof(supported_apptrust_variants));
+	}
+
+	dev_err(dev->dev, "Invalid apptrust selector or priority order. Supported: %s\n",
+		supported_apptrust_variants);
+}
+
+/**
+ * ksz_port_set_apptrust_validate - Validates the apptrust selectors
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number for which to set the apptrust selectors
+ * @sel: Array of apptrust selectors to validate
+ * @nsel: Number of apptrust selectors in the array
+ *
+ * This function validates the apptrust selectors provided and ensures that
+ * they are in the correct order.
+ *
+ * This family of switches supports two apptrust selectors: DCB_APP_SEL_PCP and
+ * IEEE_8021QAZ_APP_SEL_DSCP. The priority order of the selectors is fixed and
+ * cannot be changed. The order is as follows:
+ * 1. DCB_APP_SEL_PCP - Priority Code Point selector (highest priority)
+ * 2. IEEE_8021QAZ_APP_SEL_DSCP - Differentiated Services Code Point selector
+ *   (lowest priority)
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz_port_set_apptrust_validate(struct ksz_device *dev, int port,
+					  const u8 *sel, int nsel)
+{
+	int i, j, found;
+	int j_prev = 0;
+
+	/* Iterate through the requested selectors */
+	for (i = 0; i < nsel; i++) {
+		found = 0;
+
+		/* Check if the current selector is supported by the hardware */
+		for (j = 0; j < sizeof(ksz_supported_apptrust); j++) {
+			if (sel[i] != ksz_supported_apptrust[j])
+				continue;
+
+			found = 1;
+
+			/* Ensure that no higher priority selector (lower index)
+			 * precedes a lower priority one
+			 */
+			if (i > 0 && j <= j_prev)
+				goto err_sel_not_vaild;
+
+			j_prev = j;
+			break;
+		}
+
+		if (!found)
+			goto err_sel_not_vaild;
+	}
+
+	return 0;
+
+err_sel_not_vaild:
+	ksz_apptrust_error(dev);
+
+	return -EINVAL;
+}
+
+/**
+ * ksz_port_set_apptrust - Sets the apptrust selectors for a port on a KSZ
+ *			   switch
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number for which to set the apptrust selectors
+ * @sel: Array of apptrust selectors to set
+ * @nsel: Number of apptrust selectors in the array
+ *
+ * This function sets the apptrust selectors for the specified port on a KSZ
+ * switch.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+int ksz_port_set_apptrust(struct dsa_switch *ds, int port,
+			  const u8 *sel, int nsel)
+{
+	const struct ksz_apptrust_map *map;
+	struct ksz_device *dev = ds->priv;
+	int reg, i, ret;
+	u8 data = 0;
+	u8 mask;
+
+	ret = ksz_port_set_apptrust_validate(dev, port, sel, nsel);
+	if (ret)
+		return ret;
+
+	ksz_get_apptrust_map_and_reg(dev, &map, &reg, &mask);
+
+	for (i = 0; i < nsel; i++) {
+		int j;
+
+		for (j = 0; j < ARRAY_SIZE(ksz_supported_apptrust); j++) {
+			if (sel[i] != ksz_supported_apptrust[j])
+				continue;
+
+			data |= map[j].bit;
+			break;
+		}
+	}
+
+	return ksz_prmw8(dev, port, reg, mask, data);
+}
+
+/**
+ * ksz_port_get_apptrust - Retrieves the apptrust selectors for a port on a KSZ
+ *			   switch
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number for which to get the apptrust selectors
+ * @sel: Array to store the apptrust selectors
+ * @nsel: Number of apptrust selectors in the array
+ *
+ * This function fetches the apptrust selectors for the specified port on a KSZ
+ * switch.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+int ksz_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel, int *nsel)
+{
+	const struct ksz_apptrust_map *map;
+	struct ksz_device *dev = ds->priv;
+	int reg, i, ret;
+	u8 data;
+	u8 mask;
+
+	ksz_get_apptrust_map_and_reg(dev, &map, &reg, &mask);
+
+	ret = ksz_pread8(dev, port, reg, &data);
+	if (ret)
+		return ret;
+
+	*nsel = 0;
+	for (i = 0; i < ARRAY_SIZE(ksz_supported_apptrust); i++) {
+		if (data & map[i].bit)
+			sel[(*nsel)++] = ksz_supported_apptrust[i];
+	}
+
+	return 0;
+}
+
+/**
+ * ksz_dcb_init_port - Initializes the DCB configuration for a port on a KSZ
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number for which to initialize the DCB configuration
+ *
+ * This function initializes the DCB configuration for the specified port on a
+ * KSZ switch. Particular DCB configuration is set for the port, including the
+ * default priority and apptrust selectors.
+ * The default priority is set to Best Effort, and the apptrust selectors are
+ * set to all supported selectors.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+int ksz_dcb_init_port(struct ksz_device *dev, int port)
+{
+	int ret, ipv;
+
+	if (is_ksz8(dev)) {
+		ipv = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
+					 dev->info->num_tx_queues);
+		if (ipv < 0)
+			return ipv;
+	} else {
+		ipv = IEEE8021Q_TT_BE;
+	}
+
+	/* Set the default priority for the port to Best Effort */
+	ret = ksz_port_set_default_prio(dev->ds, port, ipv);
+	if (ret)
+		return ret;
+
+	return ksz_port_set_apptrust(dev->ds, port, ksz_supported_apptrust,
+				     ARRAY_SIZE(ksz_supported_apptrust));
+}
+
+/**
+ * ksz_dcb_init - Initializes the DCB configuration for a KSZ switch
+ * @dev: Pointer to the KSZ switch device structure
+ *
+ * This function initializes the DCB configuration for a KSZ switch. The global
+ * DSCP-to-priority mapping table is initialized.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+int ksz_dcb_init(struct ksz_device *dev)
+{
+	int ret;
+
+	ret = ksz_init_global_dscp_map(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/drivers/net/dsa/microchip/ksz_dcb.h b/drivers/net/dsa/microchip/ksz_dcb.h
new file mode 100644
index 0000000000000..254c0e7bdafca
--- /dev/null
+++ b/drivers/net/dsa/microchip/ksz_dcb.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de> */
+
+#ifndef __KSZ_DCB_H
+#define __KSZ_DCB_H
+
+#include <net/dsa.h>
+
+#include "ksz_common.h"
+
+int ksz_port_get_default_prio(struct dsa_switch *ds, int port);
+int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio);
+int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp);
+int ksz_port_set_apptrust(struct dsa_switch *ds, int port,
+			  const unsigned char *sel,
+			  int nsel);
+int ksz_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel, int *nsel);
+int ksz_dcb_init_port(struct ksz_device *dev, int port);
+int ksz_dcb_init(struct ksz_device *dev);
+
+#endif /* __KSZ_DCB_H */
-- 
2.39.2


