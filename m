Return-Path: <linux-kernel+bounces-86797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF47E86CAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C61F236F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0A11350DD;
	Thu, 29 Feb 2024 14:08:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931912BF22
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215703; cv=none; b=EHCl0uFTxMNHv21CT7U9Nb8Aw1KcqORx9UhIYxFNTqpzUwzkDvHf/ZC3QRttTIyL2Z4oUTbvFXK5ri8fR6i5eKQ2hr1NBhuGAGkgEeAPKwlLCBWX1fHQAfvUzo1fvKUgYrVbgo39T9dz1YYLhWqbhFvuc2OSwbLAW+LrkshJ32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215703; c=relaxed/simple;
	bh=JO8ieonndskihpfJzOJE8oPTytpJgtmq3zUd6sxNeYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiYwYx9oKWmoxzrPyl+u1pkSZQ5vWi35rr5SVCtcIzXdu/YcLC2emfmHfyCftd7+YHNwkF695/+kcn2HUaUx0KW5Oukm3207m5QA6MxvR1AmangUGV852Q27O/8etCPuIrmUuL2+PPnW4r6SU9n8JQpfOKfM+za/u36IbPSh2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4t-0000St-MW; Thu, 29 Feb 2024 15:08:03 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4r-003bZq-MN; Thu, 29 Feb 2024 15:08:01 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4r-00ELm2-1Z;
	Thu, 29 Feb 2024 15:08:01 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v7 2/8] net: phy: Add phydev->enable_tx_lpi to simplify adjust link callbacks
Date: Thu, 29 Feb 2024 15:07:54 +0100
Message-Id: <20240229140800.3420180-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229140800.3420180-1-o.rempel@pengutronix.de>
References: <20240229140800.3420180-1-o.rempel@pengutronix.de>
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

MAC drivers which support EEE need to know the results of the EEE
auto-neg in order to program the hardware to perform EEE or not.  The
oddly named phy_init_eee() can be used to determine this, it returns 0
if EEE should be used, or a negative error code,
e.g. -EOPPROTONOTSUPPORT if the PHY does not support EEE or negotiate
resulted in it not being used.

However, many MAC drivers get this wrong. Add phydev->enable_tx_lpi
which indicates the result of the autoneg for EEE, including if EEE is
administratively disabled with ethtool. The MAC driver can then access
this in the same way as link speed and duplex in the adjust link
callback. If enable_tx_lpi is true, the MAC should send low power
indications and does not need to consider anything else with respect
to EEE.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
v2: Check for errors from genphy_c45_eee_is_active
v5: Rename to enable_tx_lpi to fit better with phylink changes
v6: enable_tx_lpi = !!err
---
 drivers/net/phy/phy.c | 7 +++++++
 include/linux/phy.h   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 14224e06d69fa..2bc0a7d51c63f 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -983,9 +983,16 @@ static int phy_check_link_status(struct phy_device *phydev)
 	if (phydev->link && phydev->state != PHY_RUNNING) {
 		phy_check_downshift(phydev);
 		phydev->state = PHY_RUNNING;
+		err = genphy_c45_eee_is_active(phydev,
+					       NULL, NULL, NULL);
+		if (err < 0)
+			phydev->enable_tx_lpi = false;
+		else
+			phydev->enable_tx_lpi = !!err;
 		phy_link_up(phydev);
 	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
 		phydev->state = PHY_NOLINK;
+		phydev->enable_tx_lpi = false;
 		phy_link_down(phydev);
 	}
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e3ab2c347a598..a880f6d7170ea 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -594,6 +594,7 @@ struct macsec_ops;
  * @supported_eee: supported PHY EEE linkmodes
  * @advertising_eee: Currently advertised EEE linkmodes
  * @eee_enabled: Flag indicating whether the EEE feature is enabled
+ * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
  * @eee_broken_modes: Energy efficient ethernet modes which should be prohibited
@@ -713,6 +714,7 @@ struct phy_device {
 
 	/* Energy efficient ethernet modes which should be prohibited */
 	u32 eee_broken_modes;
+	bool enable_tx_lpi;
 
 #ifdef CONFIG_LED_TRIGGER_PHY
 	struct phy_led_trigger *phy_led_triggers;
-- 
2.39.2


