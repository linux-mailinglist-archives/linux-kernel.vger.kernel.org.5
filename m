Return-Path: <linux-kernel+bounces-129422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB356896A92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0239CB25820
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC3135A55;
	Wed,  3 Apr 2024 09:29:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E01332B7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136557; cv=none; b=ihx6BxbtEjnS7THrncMahzbMv0aOW5BHoqWaAaCQp2I915tUOyYo54xxXwOne2rqs6bmMvJCzLg3T8so4ESTQJq+K4sMtjkrhVKtwuQY/UZ0NkQJ1KEzYX41xVh1jsC3Rm4FNhIHCXCPRxnL+TLP3iD4cMFgcGtP6UnSNE+kQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136557; c=relaxed/simple;
	bh=kwf9pgy60WZCw710ANFljHJwGh3mX35Palt3FcKdDtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzkU5VOhN34h4kCxte7Zm5dxrb/i5DdIDL86AQDo8kaq+4LPP5un/60SR2ZWaOGAn/iVuZHzS+RkbrAtpLyOo76S8S8vKNZYmR3rinttt7O8lKydbcihM0IVrnRXJxFe4Up3jtcEuWPSgKnRFckH0opWB2COIBu7jgnIuFlnXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrwvc-0005CO-Nm; Wed, 03 Apr 2024 11:29:08 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrwva-00A9Ht-CK; Wed, 03 Apr 2024 11:29:06 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrwva-008qHs-0s;
	Wed, 03 Apr 2024 11:29:06 +0200
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
Subject: [PATCH net-next v2 6/9] net: dsa: microchip: dcb: add special handling for KSZ88X3 family
Date: Wed,  3 Apr 2024 11:29:02 +0200
Message-Id: <20240403092905.2107522-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403092905.2107522-1-o.rempel@pengutronix.de>
References: <20240403092905.2107522-1-o.rempel@pengutronix.de>
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
---
 drivers/net/dsa/microchip/ksz8.h    |   1 +
 drivers/net/dsa/microchip/ksz8795.c |  15 +++
 drivers/net/dsa/microchip/ksz_dcb.c | 185 +++++++++++++++++++++++++++-
 3 files changed, 198 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 1a5225264e6a3..cf2f30fd7cfcd 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -60,5 +60,6 @@ void ksz8_phylink_mac_link_up(struct ksz_device *dev, int port,
 			      unsigned int mode, phy_interface_t interface,
 			      struct phy_device *phydev, int speed, int duplex,
 			      bool tx_pause, bool rx_pause);
+int ksz8_all_queues_split(struct ksz_device *dev, int queues);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 0ead198bacb2c..a520352d5b93e 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -179,6 +179,21 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 	return ksz_prmw8(dev, port, reg_2q, mask_2q, data_2q);
 }
 
+int ksz8_all_queues_split(struct ksz_device *dev, int queues)
+{
+	struct dsa_switch *ds = dev->ds;
+	const struct dsa_port *dp;
+	int ret;
+
+	dsa_switch_for_each_port(dp, ds) {
+		ret = ksz8_port_queue_split(dev, dp->index, queues);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt)
 {
 	const u32 *masks;
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index afc84c51963b3..2c28c4ed288a9 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -132,6 +132,48 @@ int ksz_port_get_default_prio(struct dsa_switch *ds, int port)
 	return (data & mask) >> shift;
 }
 
+/**
+ * ksz88x3_port_set_default_prio_quirks - Quirks for default priority
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number for which to set the default priority
+ * @prio: Priority value to set
+ *
+ * This function implements quirks for setting the default priority on KSZ88x3
+ * devices. On Port 2 (port == 1), no other priority providers are working
+ * except of PCP. So, configuring default priority on Port 2 is not possible.
+ * On Port 1 (port == 0), it is not possible to configure port priority if PCP
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
+	if (port == 1) {
+		dev_err(dev->dev, "Port priority configuration is not working on Port 2\n");
+		return -EINVAL;
+	} else if (port == 0) {
+		u8 port1_data;
+		int ret;
+
+		ret = ksz_pread8(dev, 1, KSZ8_REG_PORT_1_CTRL_0, &port1_data);
+		if (ret)
+			return ret;
+
+		if (!(port1_data & KSZ8_PORT_802_1P_ENABLE)) {
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
@@ -147,12 +189,19 @@ int ksz_port_get_default_prio(struct dsa_switch *ds, int port)
 int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 {
 	struct ksz_device *dev = ds->priv;
-	int reg, shift;
+	int reg, shift, ret;
 	u8 mask;
 
 	if (prio >= dev->info->num_tx_queues)
 		return -EINVAL;
 
+
+	if (ksz_is_ksz88x3(dev)) {
+		ret = ksz88x3_port_set_default_prio_quirks(dev, port, prio);
+		if (ret)
+			return ret;
+	}
+
 	ksz_get_defult_port_prio_reg(dev, &reg, &mask, &shift);
 
 	return ksz_prmw8(dev, port, reg, mask, (prio << shift) & mask);
@@ -413,6 +462,118 @@ static void ksz_get_apptrus_map_and_reg(struct ksz_device *dev,
 	}
 }
 
+/**
+ * ksz88x3_port0_apptrust_quirk - Quirk for apptrust configuration on Port 1
+ *				  (port == 0) of KSZ88x3 devices
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number for which to set the apptrust selectors
+ * @reg: Register address for the apptrust configuration
+ * @data: Data to set for the apptrust configuration
+ *
+ * This function implements a quirk for apptrust configuration on Port 1 of
+ * KSZ88x3 devices. It ensures that apptrust configuration on Port 1 is not
+ * possible if PCP apptrust on Port 2 is disabled. This is because the Port 2
+ * seems to be permanently hardwired to PCP classification, so we need to
+ * do Port 1 configuration always in agreement with Port 2 configuration.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_port0_apptrust_quirk(struct ksz_device *dev, int port,
+					int reg, u8 data)
+{
+	u8 port1_data;
+	int ret;
+
+	if (!(data & (KSZ8_PORT_802_1P_ENABLE | KSZ8_PORT_DIFFSERV_ENABLE)))
+		return 0;
+
+	ret = ksz_pread8(dev, 1, reg, &port1_data);
+	if (ret)
+		return ret;
+
+	if (!(port1_data & KSZ8_PORT_802_1P_ENABLE)) {
+		dev_err(dev->dev, "Not possible to enable any apptrust on Port 1 if PCP apptrust on Port 2 is disabled\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * ksz88x3_port1_apptrust_quirk - Quirk for apptrust configuration on Port 2
+ *				  (port == 1) of KSZ88x3 devices
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number for which to set the apptrust selectors
+ * @reg: Register address for the apptrust configuration
+ * @data: Data to set for the apptrust configuration
+ *
+ * This function implements a quirk for apptrust configuration on Port 2 of
+ * KSZ88x3 devices. It ensures that DSCP apptrust is not working on Port 2 and
+ * that it is not possible to disable PCP on Port 2. The only way to disable PCP
+ * on Port 2 is to disable multiple queues on the switch.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_port1_apptrust_quirk(struct ksz_device *dev, int port,
+					int reg, u8 data)
+{
+	struct dsa_switch *ds = dev->ds;
+	u8 port0_data;
+	int ret;
+
+	if (data & KSZ8_PORT_DIFFSERV_ENABLE) {
+		dev_err(dev->dev, "DSCP apptrust is not working on Port 2\n");
+		return -EINVAL;
+	}
+
+	if (data & KSZ8_PORT_802_1P_ENABLE)
+		return ksz8_all_queues_split(dev, dev->info->num_tx_queues);
+
+	ret = ksz_pread8(dev, 0, reg, &port0_data);
+	if (ret)
+		return ret;
+
+	if (port0_data & (KSZ8_PORT_802_1P_ENABLE | KSZ8_PORT_DIFFSERV_ENABLE)) {
+		dev_err(dev->dev, "Not possible to disable PCP on Port 2 if any apptrust is enabled on Port 1\n");
+		return -EINVAL;
+	}
+
+	ret = ksz_port_get_default_prio(ds, 0);
+	if (ret < 0) {
+		return ret;
+	} else if (ret) {
+		dev_err(dev->dev, "Not possible to disable PCP on Port 2 if non zero default priority is set on Port 1\n");
+		return -EINVAL;
+	}
+
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
+ * devices. It ensures that apptrust configuration on Port 1 (port == 0) and
+ * Port 2 (port == 1) is done in agreement with each other.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_port_apptrust_quirk(struct ksz_device *dev, int port,
+				       int reg, u8 data)
+{
+	if (port == 0) {
+		return ksz88x3_port0_apptrust_quirk(dev, port, reg, data);
+	} else if (port == 1)
+		return ksz88x3_port1_apptrust_quirk(dev, port, reg, data);
+
+	return 0;
+}
+
 /**
  * ksz_port_set_apptrust - Sets the apptrust selectors for a port on a KSZ
  *			   switch
@@ -453,6 +614,12 @@ int ksz_port_set_apptrust(struct dsa_switch *ds, int port,
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
 
@@ -507,7 +674,9 @@ int ksz_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel, int *nsel)
  */
 int ksz_dcb_init_port(struct ksz_device *dev, int port)
 {
+	const u8 *sel;
 	int ret, ipv;
+	int sel_len;
 
 	if (is_ksz8(dev)) {
 		ipv = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
@@ -523,8 +692,18 @@ int ksz_dcb_init_port(struct ksz_device *dev, int port)
 	if (ret)
 		return ret;
 
-	return ksz_port_set_apptrust(dev->ds, port, ksz_supported_apptrust,
-				     ARRAY_SIZE(ksz_supported_apptrust));
+	if (ksz_is_ksz88x3(dev) && port == 1) {
+		/* KSZ88x3 devices do not support DSCP classification on
+		 * "Port 2" (port == 1).
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


