Return-Path: <linux-kernel+bounces-167681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1EB8BAD69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC861C20FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB715697A;
	Fri,  3 May 2024 13:14:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449615380B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742054; cv=none; b=Q1ZC/xUW1PuzRDkrBSngO6LfR4Jw5zdChWX5QQMr+ygJBuRslPQC0pJqcOcTBIYqa08FTIlWyRA6uAB6/erlzXYsb1UZzTBlDV5lFkI/enKZmfR/i8XLt7ypKhf/B18gkNt09oZvnCIdOm9Yjdbykw3lt0/SXL0z1PnoMODe7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742054; c=relaxed/simple;
	bh=NF9GzWVktH8BSliMRqgx+ee5qg8xRlRidi+8vtNWNls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdD2YiuJaSbDbpfTyuagdw6uZcnRV9t5Bnl+ZInhNN4OFXOmLl4LTugWsEuj4WF/u159/Py4qMZmUEIJ7WzYVV7osyJIbvohmgftB4PDKWr35jJwML63beMCQgCmnjY8jmxASizl641gkZkIfYUhp62sf4huxAkridmyGk59OBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjb-0006EI-6l; Fri, 03 May 2024 15:13:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-00FiKF-QQ; Fri, 03 May 2024 15:13:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-008GHJ-2D;
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
Subject: [PATCH net-next v7 06/12] net: dsa: microchip: dcb: add special handling for KSZ88X3 family
Date: Fri,  3 May 2024 15:13:45 +0200
Message-Id: <20240503131351.1969097-7-o.rempel@pengutronix.de>
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

KSZ88X3 switches have different behavior on different ports:
- It seems to be not possible to disable VLAN PCP classification on port
  2. It means, as soon as mutliqueue support is enabled, frames with
     VLAN tag will get PCP prios. This behavior do not affect Port 1 -
     it is possible to disable PCP prios.
- DSCP classification is not working on Port 2.

Since there are still usable configuration combinations, I added some
quirks to make sure user will get appropriate error message if not
possible configuration is chosen.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
changes v5:
- add KSZ_PORT_1/2 defines, to make code readable
- streamline function and variable naming with port names used in the
  documentation
changes v3:
- move ksz8_port2_supported_apptrust[] to this patch, where it is
  actually used.
---
 drivers/net/dsa/microchip/ksz8.h       |   1 +
 drivers/net/dsa/microchip/ksz8795.c    |  15 ++
 drivers/net/dsa/microchip/ksz_common.h |   3 +
 drivers/net/dsa/microchip/ksz_dcb.c    | 226 ++++++++++++++++++++++++-
 4 files changed, 242 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 9a286d73e9cfe..ae43077e76c35 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -58,5 +58,6 @@ void ksz8_phylink_mac_link_up(struct phylink_config *config,
 			      struct phy_device *phydev, unsigned int mode,
 			      phy_interface_t interface, int speed, int duplex,
 			      bool tx_pause, bool rx_pause);
+int ksz8_all_queues_split(struct ksz_device *dev, int queues);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 51b8ffe5a61f8..95f5a5a9898cd 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -179,6 +179,21 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 	return ksz_prmw8(dev, port, reg_2q, mask_2q, data_2q);
 }
 
+int ksz8_all_queues_split(struct ksz_device *dev, int queues)
+{
+	struct dsa_switch *ds = dev->ds;
+	const struct dsa_port *dp;
+
+	dsa_switch_for_each_port(dp, ds) {
+		int ret = ksz8_port_queue_split(dev, dp->index, queues);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt)
 {
 	const u32 *masks;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a0ae9dffa133f..42f445aef9c90 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -19,6 +19,9 @@
 #include "ksz_ptp.h"
 
 #define KSZ_MAX_NUM_PORTS 8
+/* all KSZ switches count ports from 1 */
+#define KSZ_PORT_1 0
+#define KSZ_PORT_2 1
 
 struct ksz_device;
 struct ksz_port;
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index de46329ed6e85..80fb322de8f74 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -82,6 +82,10 @@ static const u8 ksz_supported_apptrust[] = {
 	IEEE_8021QAZ_APP_SEL_DSCP,
 };
 
+static const u8 ksz8_port2_supported_apptrust[] = {
+	DCB_APP_SEL_PCP,
+};
+
 static const char * const ksz_supported_apptrust_variants[] = {
 	"empty", "dscp", "pcp", "dscp pcp"
 };
@@ -181,6 +185,49 @@ int ksz_port_get_default_prio(struct dsa_switch *ds, int port)
 	return (data & mask) >> shift;
 }
 
+/**
+ * ksz88x3_port_set_default_prio_quirks - Quirks for default priority
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number for which to set the default priority
+ * @prio: Priority value to set
+ *
+ * This function implements quirks for setting the default priority on KSZ88x3
+ * devices. On Port 2, no other priority providers are working
+ * except of PCP. So, configuring default priority on Port 2 is not possible.
+ * On Port 1, it is not possible to configure port priority if PCP
+ * apptrust on Port 2 is disabled. Since we disable multiple queues on the
+ * switch to disable PCP on Port 2, we need to ensure that the default priority
+ * configuration on Port 1 is in agreement with the configuration on Port 2.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_port_set_default_prio_quirks(struct ksz_device *dev, int port,
+						u8 prio)
+{
+	if (!prio)
+		return 0;
+
+	if (port == KSZ_PORT_2) {
+		dev_err(dev->dev, "Port priority configuration is not working on Port 2\n");
+		return -EINVAL;
+	} else if (port == KSZ_PORT_1) {
+		u8 port2_data;
+		int ret;
+
+		ret = ksz_pread8(dev, KSZ_PORT_2, KSZ8_REG_PORT_1_CTRL_0,
+				 &port2_data);
+		if (ret)
+			return ret;
+
+		if (!(port2_data & KSZ8_PORT_802_1P_ENABLE)) {
+			dev_err(dev->dev, "Not possible to configur port priority on Port 1 if PCP apptrust on Port 2 is disabled\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ksz_port_set_default_prio - Sets the default priority for a port on a KSZ
  *			       switch
@@ -196,12 +243,18 @@ int ksz_port_get_default_prio(struct dsa_switch *ds, int port)
 int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 {
 	struct ksz_device *dev = ds->priv;
-	int reg, shift;
+	int reg, shift, ret;
 	u8 mask;
 
 	if (prio >= dev->info->num_ipvs)
 		return -EINVAL;
 
+	if (ksz_is_ksz88x3(dev)) {
+		ret = ksz88x3_port_set_default_prio_quirks(dev, port, prio);
+		if (ret)
+			return ret;
+	}
+
 	ksz_get_default_port_prio_reg(dev, &reg, &mask, &shift);
 
 	return ksz_prmw8(dev, port, reg, mask, (prio << shift) & mask);
@@ -408,6 +461,155 @@ static int ksz_port_set_apptrust_validate(struct ksz_device *dev, int port,
 	return -EINVAL;
 }
 
+/**
+ * ksz88x3_port1_apptrust_quirk - Quirk for apptrust configuration on Port 1
+ *				  of KSZ88x3 devices
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number for which to set the apptrust selectors
+ * @reg: Register address for the apptrust configuration
+ * @port1_data: Data to set for the apptrust configuration
+ *
+ * This function implements a quirk for apptrust configuration on Port 1 of
+ * KSZ88x3 devices. It ensures that apptrust configuration on Port 1 is not
+ * possible if PCP apptrust on Port 2 is disabled. This is because the Port 2
+ * seems to be permanently hardwired to PCP classification, so we need to
+ * do Port 1 configuration always in agreement with Port 2 configuration.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_port1_apptrust_quirk(struct ksz_device *dev, int port,
+					int reg, u8 port1_data)
+{
+	u8 port2_data;
+	int ret;
+
+	/* If no apptrust is requested for Port 1, no need to care about Port 2
+	 * configuration.
+	 */
+	if (!(port1_data & (KSZ8_PORT_802_1P_ENABLE | KSZ8_PORT_DIFFSERV_ENABLE)))
+		return 0;
+
+	/* We got request to enable any apptrust on Port 1. To make it possible,
+	 * we need to enable multiple queues on the switch. If we enable
+	 * multiqueue support, PCP classification on Port 2 will be
+	 * automatically activated by HW.
+	 */
+	ret = ksz_pread8(dev, KSZ_PORT_2, reg, &port2_data);
+	if (ret)
+		return ret;
+
+	/* If KSZ8_PORT_802_1P_ENABLE bit is set on Port 2, the driver showed
+	 * the interest in PCP classification on Port 2. In this case,
+	 * multiqueue support is enabled and we can enable any apptrust on
+	 * Port 1.
+	 * If KSZ8_PORT_802_1P_ENABLE bit is not set on Port 2, the PCP
+	 * classification on Port 2 is still active, but the driver disabled
+	 * multiqueue support and made frame prioritization inactive for
+	 * all ports. In this case, we can't enable any apptrust on Port 1.
+	 */
+	if (!(port2_data & KSZ8_PORT_802_1P_ENABLE)) {
+		dev_err(dev->dev, "Not possible to enable any apptrust on Port 1 if PCP apptrust on Port 2 is disabled\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * ksz88x3_port2_apptrust_quirk - Quirk for apptrust configuration on Port 2
+ *				  of KSZ88x3 devices
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number for which to set the apptrust selectors
+ * @reg: Register address for the apptrust configuration
+ * @port2_data: Data to set for the apptrust configuration
+ *
+ * This function implements a quirk for apptrust configuration on Port 2 of
+ * KSZ88x3 devices. It ensures that DSCP apptrust is not working on Port 2 and
+ * that it is not possible to disable PCP on Port 2. The only way to disable PCP
+ * on Port 2 is to disable multiple queues on the switch.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_port2_apptrust_quirk(struct ksz_device *dev, int port,
+					int reg, u8 port2_data)
+{
+	struct dsa_switch *ds = dev->ds;
+	u8 port1_data;
+	int ret;
+
+	/* First validate Port 2 configuration. DiffServ/DSCP is not working
+	 * on this port.
+	 */
+	if (port2_data & KSZ8_PORT_DIFFSERV_ENABLE) {
+		dev_err(dev->dev, "DSCP apptrust is not working on Port 2\n");
+		return -EINVAL;
+	}
+
+	/* If PCP support is requested, we need to enable all queues on the
+	 * switch to make PCP priority working on Port 2.
+	 */
+	if (port2_data & KSZ8_PORT_802_1P_ENABLE)
+		return ksz8_all_queues_split(dev, dev->info->num_tx_queues);
+
+	/* We got request to disable PCP priority on Port 2.
+	 * Now, we need to compare Port 2 configuration with Port 1
+	 * configuration.
+	 */
+	ret = ksz_pread8(dev, KSZ_PORT_1, reg, &port1_data);
+	if (ret)
+		return ret;
+
+	/* If Port 1 has any apptrust enabled, we can't disable multiple queues
+	 * on the switch, so we can't disable PCP on Port 2.
+	 */
+	if (port1_data & (KSZ8_PORT_802_1P_ENABLE | KSZ8_PORT_DIFFSERV_ENABLE)) {
+		dev_err(dev->dev, "Not possible to disable PCP on Port 2 if any apptrust is enabled on Port 1\n");
+		return -EINVAL;
+	}
+
+	/* Now we need to ensure that default priority on Port 1 is set to 0
+	 * otherwise we can't disable multiqueue support on the switch.
+	 */
+	ret = ksz_port_get_default_prio(ds, KSZ_PORT_1);
+	if (ret < 0) {
+		return ret;
+	} else if (ret) {
+		dev_err(dev->dev, "Not possible to disable PCP on Port 2 if non zero default priority is set on Port 1\n");
+		return -EINVAL;
+	}
+
+	/* Port 1 has no apptrust or default priority set and we got request to
+	 * disable PCP on Port 2. We can disable multiqueue support to disable
+	 * PCP on Port 2.
+	 */
+	return ksz8_all_queues_split(dev, 1);
+}
+
+/**
+ * ksz88x3_port_apptrust_quirk - Quirk for apptrust configuration on KSZ88x3
+ *			       devices
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number for which to set the apptrust selectors
+ * @reg: Register address for the apptrust configuration
+ * @data: Data to set for the apptrust configuration
+ *
+ * This function implements a quirk for apptrust configuration on KSZ88x3
+ * devices. It ensures that apptrust configuration on Port 1 and
+ * Port 2 is done in agreement with each other.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_port_apptrust_quirk(struct ksz_device *dev, int port,
+				       int reg, u8 data)
+{
+	if (port == KSZ_PORT_1)
+		return ksz88x3_port1_apptrust_quirk(dev, port, reg, data);
+	else if (port == KSZ_PORT_2)
+		return ksz88x3_port2_apptrust_quirk(dev, port, reg, data);
+
+	return 0;
+}
+
 /**
  * ksz_port_set_apptrust - Sets the apptrust selectors for a port on a KSZ
  *			   switch
@@ -448,6 +650,12 @@ int ksz_port_set_apptrust(struct dsa_switch *ds, int port,
 		}
 	}
 
+	if (ksz_is_ksz88x3(dev)) {
+		ret = ksz88x3_port_apptrust_quirk(dev, port, reg, data);
+		if (ret)
+			return ret;
+	}
+
 	return ksz_prmw8(dev, port, reg, mask, data);
 }
 
@@ -502,7 +710,9 @@ int ksz_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel, int *nsel)
  */
 int ksz_dcb_init_port(struct ksz_device *dev, int port)
 {
+	const u8 *sel;
 	int ret, ipv;
+	int sel_len;
 
 	if (is_ksz8(dev)) {
 		ipv = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
@@ -518,8 +728,18 @@ int ksz_dcb_init_port(struct ksz_device *dev, int port)
 	if (ret)
 		return ret;
 
-	return ksz_port_set_apptrust(dev->ds, port, ksz_supported_apptrust,
-				     ARRAY_SIZE(ksz_supported_apptrust));
+	if (ksz_is_ksz88x3(dev) && port == KSZ_PORT_2) {
+		/* KSZ88x3 devices do not support DSCP classification on
+		 * "Port 2.
+		 */
+		sel = ksz8_port2_supported_apptrust;
+		sel_len = ARRAY_SIZE(ksz8_port2_supported_apptrust);
+	} else {
+		sel = ksz_supported_apptrust;
+		sel_len = ARRAY_SIZE(ksz_supported_apptrust);
+	}
+
+	return ksz_port_set_apptrust(dev->ds, port, sel, sel_len);
 }
 
 /**
-- 
2.39.2


