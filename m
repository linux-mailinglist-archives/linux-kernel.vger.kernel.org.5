Return-Path: <linux-kernel+bounces-89568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956EF86F225
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E47283FE3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE6A405DD;
	Sat,  2 Mar 2024 19:53:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606453FB3C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409200; cv=none; b=ZUktSiIassDNXAtGQZ/p1+tZOpmA1LpUjS2Aqy1U9+cSxoQvetib1+Yp7c5tvNbnu5HKV9xiMClZ+HeeQEcChfx8XsVy1Nym6s8MiwmVm+fJNb45rrp3+nRRI0XTGVhIgAonpvFoUTU5vPdS/IbPHhwJJfLFA56RwruZ32tUKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409200; c=relaxed/simple;
	bh=m7EN2IvBTcINvgKKnoMcKpfpB8FVoTYDp93JD26psmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqUevCqDfUS30SwniYEetHn0M+E/f8d7R6u2wVjth7+AWWMEbxxVCub0oLtLJ85SvpnvhH8U6+pTZnCn2nUclNSV/TVbzOxdVbx70gCuebYAXVcwVq3de6pAyeq3eVu9aRec063XIhpW5gD/ywyiwAN576iMKXVPoLjQpb7PEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPx-0007Gx-Ln; Sat, 02 Mar 2024 20:53:09 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-0041mI-R9; Sat, 02 Mar 2024 20:53:07 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-00DSUi-2P;
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
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v9 5/7] net: phy: Add phy_support_eee() indicating MAC support EEE
Date: Sat,  2 Mar 2024 20:53:04 +0100
Message-Id: <20240302195306.3207716-6-o.rempel@pengutronix.de>
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

In order for EEE to operate, both the MAC and the PHY need to support
it, similar to how pause works. With some exception - a number of PHYs
have SmartEEE or AutoGrEEEn support in order to provide some EEE-like
power savings with non-EEE capable MACs.

Copy the pause concept and add the call phy_support_eee() which the MAC
makes after connecting the PHY to indicate it supports EEE. phylib will
then advertise EEE when auto-neg is performed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
v6: reword commit message and comment for phy_support_eee()
---
 drivers/net/phy/phy_device.c | 28 ++++++++++++++++++++++++++++
 include/linux/phy.h          |  3 ++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2eefee9708510..72452e6a478c0 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2910,6 +2910,34 @@ void phy_advertise_eee_all(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
 
+/**
+ * phy_support_eee - Set initial EEE policy configuration
+ * @phydev: Target phy_device struct
+ *
+ * This function configures the initial policy for Energy Efficient Ethernet
+ * (EEE) on the specified PHY device, influencing that EEE capabilities are
+ * advertised before the link is established. It should be called during PHY
+ * registration by the MAC driver and/or the PHY driver (for SmartEEE PHYs)
+ * if MAC supports LPI or PHY is capable to compensate missing LPI functionality
+ * of the MAC.
+ *
+ * The function sets default EEE policy parameters, including preparing the PHY
+ * to advertise EEE capabilities based on hardware support.
+ *
+ * It also sets the expected configuration for Low Power Idle (LPI) in the MAC
+ * driver. If the PHY framework determines that both local and remote
+ * advertisements support EEE, and the negotiated link mode is compatible with
+ * EEE, it will set enable_tx_lpi = true. The MAC driver is expected to act on
+ * this setting by enabling the LPI timer if enable_tx_lpi is set.
+ */
+void phy_support_eee(struct phy_device *phydev)
+{
+	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
+	phydev->eee_cfg.tx_lpi_enabled = true;
+	phydev->eee_cfg.eee_enabled = true;
+}
+EXPORT_SYMBOL(phy_support_eee);
+
 /**
  * phy_support_sym_pause - Enable support of symmetrical pause
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 695e366bd75c1..3f68b8239bb11 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -706,7 +706,7 @@ struct phy_device {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
 	/* used with phy_speed_down */
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv_old);
-	/* used for eee validation */
+	/* used for eee validation and configuration*/
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_eee);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising_eee);
 	bool eee_enabled;
@@ -1973,6 +1973,7 @@ void phy_advertise_supported(struct phy_device *phydev);
 void phy_advertise_eee_all(struct phy_device *phydev);
 void phy_support_sym_pause(struct phy_device *phydev);
 void phy_support_asym_pause(struct phy_device *phydev);
+void phy_support_eee(struct phy_device *phydev);
 void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
 		       bool autoneg);
 void phy_set_asym_pause(struct phy_device *phydev, bool rx, bool tx);
-- 
2.39.2


