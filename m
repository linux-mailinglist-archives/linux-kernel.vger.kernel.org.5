Return-Path: <linux-kernel+bounces-89572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DFD86F229
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61FE1F21EF0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6A04206D;
	Sat,  2 Mar 2024 19:53:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606733FE4C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409201; cv=none; b=O4KeEzA5ds5AlmCU++LzNbCf+oI9wMLGDVtVC5WcivtXBdaazVueBFGcrbmZqGHcLaT77DvNDWF27y7/57tXcAGXIZHKdhtbylKgOnCtv01gK6XjFEpYalqJjcFArTNQP44rPZ6IQzIBPG7XDcljJyZ4bOP9gftRHjk8genJpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409201; c=relaxed/simple;
	bh=VwqUETHkMr9Jr4MpYgf8mhr2gN0RvJdCzWv8zQr3mPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmmDI8PDACvreH7B6+KyGb60H20ROcTpXNgMiPFz4HrHaIwrXHc8IPNXXcp8gegJUJfy72mLSoHju0KCMLADICXR1IQ2Eg8v7K+VwiF5wA5tbGI76BHGVgFNaGJY8yK5+A+Eo9Mt/vgosIGpXy4JzAEe3/V0Rw3Yd8qpmp9aTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPx-0007Gz-Ln; Sat, 02 Mar 2024 20:53:09 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-0041mM-S9; Sat, 02 Mar 2024 20:53:07 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-00DSV2-2W;
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
Subject: [PATCH net-next v9 7/7] net: fec: Fixup EEE
Date: Sat,  2 Mar 2024 20:53:06 +0100
Message-Id: <20240302195306.3207716-8-o.rempel@pengutronix.de>
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

The enabling/disabling of EEE in the MAC should happen as a result of
auto negotiation. So move the enable/disable into
fec_enet_adjust_link() which gets called by phylib when there is a
change in link status.

fec_enet_set_eee() now just stores away the LPI timer value.
Everything else is passed to phylib, so it can correctly setup the
PHY.

fec_enet_get_eee() relies on phylib doing most of the work,
the MAC driver just adds the LPI timer value.

Call phy_support_eee() if the quirk is present to indicate the MAC
actually supports EEE.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de> (On iMX8MP debix)
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
v2: Only call fec_enet_eee_mode_set for those that support EEE
v7: update against kernel v6.8-rc4
---
 drivers/net/ethernet/freescale/fec_main.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a2c786550342f..d7693fdf640d5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2033,13 +2033,8 @@ static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct ethtool_keee *p = &fep->eee;
 	unsigned int sleep_cycle, wake_cycle;
-	int ret = 0;
 
 	if (enable) {
-		ret = phy_init_eee(ndev->phydev, false);
-		if (ret)
-			return ret;
-
 		sleep_cycle = fec_enet_us_to_tx_cycle(ndev, p->tx_lpi_timer);
 		wake_cycle = sleep_cycle;
 	} else {
@@ -2047,8 +2042,6 @@ static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
 		wake_cycle = 0;
 	}
 
-	p->tx_lpi_enabled = enable;
-
 	writel(sleep_cycle, fep->hwp + FEC_LPI_SLEEP);
 	writel(wake_cycle, fep->hwp + FEC_LPI_WAKE);
 
@@ -2094,6 +2087,8 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 			netif_tx_unlock_bh(ndev);
 			napi_enable(&fep->napi);
 		}
+		if (fep->quirks & FEC_QUIRK_HAS_EEE)
+			fec_enet_eee_mode_set(ndev, phy_dev->enable_tx_lpi);
 	} else {
 		if (fep->link) {
 			netif_stop_queue(ndev);
@@ -2453,6 +2448,9 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 	else
 		phy_set_max_speed(phy_dev, 100);
 
+	if (fep->quirks & FEC_QUIRK_HAS_EEE)
+		phy_support_eee(phy_dev);
+
 	fep->link = 0;
 	fep->full_duplex = 0;
 
@@ -3172,7 +3170,6 @@ fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 		return -ENETDOWN;
 
 	edata->tx_lpi_timer = p->tx_lpi_timer;
-	edata->tx_lpi_enabled = p->tx_lpi_enabled;
 
 	return phy_ethtool_get_eee(ndev->phydev, edata);
 }
@@ -3182,7 +3179,6 @@ fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct ethtool_keee *p = &fep->eee;
-	int ret = 0;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
 		return -EOPNOTSUPP;
@@ -3192,15 +3188,6 @@ fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 
 	p->tx_lpi_timer = edata->tx_lpi_timer;
 
-	if (!edata->eee_enabled || !edata->tx_lpi_enabled ||
-	    !edata->tx_lpi_timer)
-		ret = fec_enet_eee_mode_set(ndev, false);
-	else
-		ret = fec_enet_eee_mode_set(ndev, true);
-
-	if (ret)
-		return ret;
-
 	return phy_ethtool_set_eee(ndev->phydev, edata);
 }
 
-- 
2.39.2


