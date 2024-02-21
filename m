Return-Path: <linux-kernel+bounces-74139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FA285D05F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B04B24D21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE783A29C;
	Wed, 21 Feb 2024 06:21:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761A39FE8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496482; cv=none; b=fJ04dfN3Wbssday8Nx3n+ccNAeMHmG7W0YAEfaJbsO2L/lLbr12iV4DzAlRZWwWJHQxSPZkt7AubSrrlKDcjwVoZld76h3nOskXF40jkfkHiuOlAxyU0Rm9DiRaWVPrFggXcZ/bQvnw27h+d5ICXRp6F1mR8HfXYGdMqmuC7lUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496482; c=relaxed/simple;
	bh=WfSr1jYTESYyeMkWhvPbUe788ZXRrUMxYNEYzRNxAJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLzi4p+iYG4WamlwniaPu+sVkG5yoiLcZZV/Cy0RQI9Tjb1ZJVELBLatbKxcHF4tZd9Y9szxIuUIOS3oIraThW2mLK/3+OQ1WiAgdNed1HbYFGUAMotyQK7iFu/TY6vbMfXPfFWOeSPZAA3S7SN7q8Socg7L0n6HzehO+ZRrV+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rcfyh-00010T-4X; Wed, 21 Feb 2024 07:21:11 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rcfye-001zFF-OO; Wed, 21 Feb 2024 07:21:08 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rcfye-003GaR-29;
	Wed, 21 Feb 2024 07:21:08 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v5 5/8] net: phy: Immediately call adjust_link if only tx_lpi_enabled changes
Date: Wed, 21 Feb 2024 07:21:04 +0100
Message-Id: <20240221062107.778661-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221062107.778661-1-o.rempel@pengutronix.de>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
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

The MAC driver changes its EEE hardware configuration in its
adjust_link callback. This is called when auto-neg
completes. Disabling EEE via eee_enabled false will trigger an
autoneg, and as a result the adjust_link callback will be called with
phydev->enable_tx_lpi set to false. Similarly, eee_enabled set to true
and with a change of advertised link modes will result in a new
autoneg, and a call the adjust_link call.

If set_eee is called with only a change to tx_lpi_enabled which does
not trigger an auto-neg, it is necessary to call the adjust_link
callback so that the MAC is reconfigured to take this change into
account.

When setting phydev->enable_tx_lpi, take both eee_enabled and
tx_lpi_enabled into account, so the MAC drivers just needs to act on
phydev->enable_tx_lpi and not the whole EEE configuration.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/phy-c45.c | 11 ++++++++---
 drivers/net/phy/phy.c     | 25 ++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index c69568e7695e..217d4df59eb6 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1549,6 +1549,8 @@ EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
  * advertised, but the previously advertised link modes are
  * retained. This allows EEE to be enabled/disabled in a
  * non-destructive way.
+ * Returns either error code, 0 if there was no change, or positive
+ * value if there was a change which triggered auto-neg.
  */
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data)
@@ -1580,9 +1582,12 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 	ret = genphy_c45_an_config_eee_aneg(phydev);
 	if (ret < 0)
 		return ret;
-	if (ret > 0)
-		return phy_restart_aneg(phydev);
-
+	if (ret > 0) {
+		ret = phy_restart_aneg(phydev);
+		if (ret < 0)
+			return ret;
+		return 1;
+	}
 	return 0;
 }
 EXPORT_SYMBOL(genphy_c45_ethtool_set_eee);
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 7f3629d56503..dad827717ad9 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -988,7 +988,8 @@ static int phy_check_link_status(struct phy_device *phydev)
 		if (err < 0)
 			phydev->enable_tx_lpi = false;
 		else
-			phydev->enable_tx_lpi = err;
+			phydev->enable_tx_lpi = (err & phydev->eee_cfg.tx_lpi_enabled);
+
 		phy_link_up(phydev);
 	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
 		phydev->state = PHY_NOLINK;
@@ -1679,6 +1680,21 @@ int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
 }
 EXPORT_SYMBOL(phy_ethtool_get_eee);
 
+/* auto-neg not triggered, directly inform the MAC if something
+ * changed'
+ */
+static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
+				      struct ethtool_keee *data)
+{
+	if (phydev->eee_cfg.tx_lpi_enabled !=
+	    data->tx_lpi_enabled) {
+		eee_to_eeecfg(data, &phydev->eee_cfg);
+		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
+		if (phydev->link)
+			phy_link_up(phydev);
+	}
+}
+
 /**
  * phy_ethtool_set_eee - set EEE supported and status
  * @phydev: target phy_device struct
@@ -1695,11 +1711,14 @@ int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 
 	mutex_lock(&phydev->lock);
 	ret = genphy_c45_ethtool_set_eee(phydev, data);
-	if (!ret)
+	if (ret >= 0) {
+		if (ret == 0)
+			phy_ethtool_set_eee_noneg(phydev, data);
 		eee_to_eeecfg(data, &phydev->eee_cfg);
+	}
 	mutex_unlock(&phydev->lock);
 
-	return ret;
+	return (ret < 0 ? ret : 0);
 }
 EXPORT_SYMBOL(phy_ethtool_set_eee);
 
-- 
2.39.2


