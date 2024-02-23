Return-Path: <linux-kernel+bounces-78066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C84860E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044001C247E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78D5F87D;
	Fri, 23 Feb 2024 09:45:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4D5C91F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681498; cv=none; b=AGgOghVegss1Kb5qxGeW59HSKdIB+OBwMQqbf1ARIj8RVS01n4JQ9HGUMwbKbWDkdZnsVkTpizhDeuc0G9p8QGDUOnyHpmd1CY5rpFqTqLh2USEPVwClqTwmuVx9E16ISLlSMsT4P3NdVytsARFp3FaW0D+0H778sec9rsEeUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681498; c=relaxed/simple;
	bh=Q16DNgegfwpHQ9ZZfUC5bEHajPNhkT5JWZ+zZi0btB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFk9MPPEOcwUHra3CE8MnaMbyeG3igvUT2xwNMuHBKvYi17NTCR2cItv80ETxILpP3Ti8Xu4YFOPXbMN4YFpULtSO3dhVVJupN9UREXUHnir8fIT2M65LiYR+GvavX0pphuQlyOv1qhrEqSIGnj7CK4fuhVT3J2cA4K5X8QE1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rdS6W-00080l-LM; Fri, 23 Feb 2024 10:44:28 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rdS6V-002OkU-B6; Fri, 23 Feb 2024 10:44:27 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rdS6V-002tpl-0s;
	Fri, 23 Feb 2024 10:44:27 +0100
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
Subject: [PATCH net-next v6 3/8] net: phy: Add helper to set EEE Clock stop enable bit
Date: Fri, 23 Feb 2024 10:44:20 +0100
Message-Id: <20240223094425.691209-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223094425.691209-1-o.rempel@pengutronix.de>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
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

The MAC driver can request that the PHY stops the clock during EEE
LPI. This has normally been does as part of phy_init_eee(), however
that function is overly complex and often wrongly used. Add a
standalone helper, to aid removing phy_init_eee().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/phy.c | 20 ++++++++++++++++++++
 include/linux/phy.h   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 2bc0a7d51c63..ab18b0d9beb4 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1579,6 +1579,26 @@ void phy_mac_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_mac_interrupt);
 
+/**
+ * phy_eee_clk_stop_enable - Clock should stop during LIP
+ * @phydev: target phy_device struct
+ *
+ * Description: Program the MMD register 3.0 setting the "Clock stop enable"
+ * bit.
+ */
+int phy_eee_clk_stop_enable(struct phy_device *phydev)
+{
+	int ret;
+
+	mutex_lock(&phydev->lock);
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
+			       MDIO_PCS_CTRL1_CLKSTOP_EN);
+	mutex_unlock(&phydev->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_eee_clk_stop_enable);
+
 /**
  * phy_init_eee - init and check the EEE feature
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a880f6d7170e..432c561f5809 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1995,6 +1995,7 @@ int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
+int phy_eee_clk_stop_enable(struct phy_device *phydev);
 int phy_get_eee_err(struct phy_device *phydev);
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data);
 int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data);
-- 
2.39.2


