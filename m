Return-Path: <linux-kernel+bounces-89573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA87886F22F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC891F22000
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC7146549;
	Sat,  2 Mar 2024 19:53:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39F40859
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409203; cv=none; b=dMZ0dQVJzalkILiOOLkRco/ji8S0C99J3wlKyrUqKOcIUjxWeRZuquYptWnpQ8XbdMxVt8x+rhLa7QHy2oTOVoBDWci5jJbJK5ri3ggk6SZEUM/wnbU4c37tkjergVBj89HsRr4AGtrl+lHGo89E6v1dpogf6t4ykv4u+Vm2cBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409203; c=relaxed/simple;
	bh=zi9g+OpMxoJsipyIh0jSxJiyN/227S9V/hTBfIK19hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QlF83VqNb4TlkJma5W1VbskBoB9S+XzcFTUBJg+brurHw2NBJBZQZ+FdU1GPNUN6V2+JTROACKFgWTzjy4uIKave1Bsda4IAvVwisUcX+mNV4L+Y2Up5oMLcAoyEEz2cBHvOORqFeUxKvFNWl7xj8+h16d1uDuaaDVYmvA+SYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPx-0007Gw-Me; Sat, 02 Mar 2024 20:53:09 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-0041mF-Py; Sat, 02 Mar 2024 20:53:07 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-00DSUN-2H;
	Sat, 02 Mar 2024 20:53:07 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v9 3/7] net: phy: Keep track of EEE configuration
Date: Sat,  2 Mar 2024 20:53:02 +0100
Message-Id: <20240302195306.3207716-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240302195306.3207716-1-o.rempel@pengutronix.de>
References: <20240302195306.3207716-1-o.rempel@pengutronix.de>
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

From: Andrew Lunn <andrew@lunn.ch>

Have phylib keep track of the EEE configuration. This simplifies the
MAC drivers, in that they don't need to store it.

Future patches to phylib will also make use of this information to
further simplify the MAC drivers.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
v6: add @ in front of eee_cfg
---
 drivers/net/phy/phy.c | 7 +++++--
 include/linux/phy.h   | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 2bc0a7d51c63f..95c4ef5d4e97f 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1640,8 +1640,8 @@ EXPORT_SYMBOL(phy_get_eee_err);
  * @phydev: target phy_device struct
  * @data: ethtool_keee data
  *
- * Description: it reportes the Supported/Advertisement/LP Advertisement
- * capabilities.
+ * Description: reports the Supported/Advertisement/LP Advertisement
+ * capabilities, etc.
  */
 int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
@@ -1652,6 +1652,7 @@ int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
 
 	mutex_lock(&phydev->lock);
 	ret = genphy_c45_ethtool_get_eee(phydev, data);
+	eeecfg_to_eee(data, &phydev->eee_cfg);
 	mutex_unlock(&phydev->lock);
 
 	return ret;
@@ -1674,6 +1675,8 @@ int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 
 	mutex_lock(&phydev->lock);
 	ret = genphy_c45_ethtool_set_eee(phydev, data);
+	if (!ret)
+		eee_to_eeecfg(&phydev->eee_cfg, data);
 	mutex_unlock(&phydev->lock);
 
 	return ret;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a880f6d7170ea..695e366bd75c1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -30,6 +30,7 @@
 #include <linux/refcount.h>
 
 #include <linux/atomic.h>
+#include <net/eee.h>
 
 #define PHY_DEFAULT_FEATURES	(SUPPORTED_Autoneg | \
 				 SUPPORTED_TP | \
@@ -595,6 +596,7 @@ struct macsec_ops;
  * @advertising_eee: Currently advertised EEE linkmodes
  * @eee_enabled: Flag indicating whether the EEE feature is enabled
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
+ * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
  * @eee_broken_modes: Energy efficient ethernet modes which should be prohibited
@@ -715,6 +717,7 @@ struct phy_device {
 	/* Energy efficient ethernet modes which should be prohibited */
 	u32 eee_broken_modes;
 	bool enable_tx_lpi;
+	struct eee_config eee_cfg;
 
 #ifdef CONFIG_LED_TRIGGER_PHY
 	struct phy_led_trigger *phy_led_triggers;
-- 
2.39.2


