Return-Path: <linux-kernel+bounces-61060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E73D850CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6211C23CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3BB749F;
	Mon, 12 Feb 2024 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aic1is5C"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609053A1;
	Mon, 12 Feb 2024 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707702606; cv=none; b=tvRZxtE3KQeMUsKVO1EbMIk35SwBsPp2RuNQ1vwCMmCXjjwZ5pIMWW06QHuC7gX42jxa866wDxUbejhMfyP75a6/HIVONLuv2QMI2X98NN2GplgweU/vs5ELRcupKGQ93MAEFtq7Vpf2tFsxPBCd7AxOv94GxAbGYR7AExiRFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707702606; c=relaxed/simple;
	bh=4H4FN5p/dLRBc4UInIB5xEnrfCp5/nfaFL6RntBbI4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jIB6RtcZ6boft/D89Da8SZ8Sil31BROZnxWTkDx/VrCLM3PGkZGVZ1513+DYxsWTRoeUcJYx1QpyAeCWagWmlh/2mW3Lqz9yuhPay+d6mp1+skF6BjI5LHccNqIlZjHZjyyjuGLyeyabj41b1ENaa0rIHH+eBn7S1j4oVVzfjtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aic1is5C; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 71018C0000D8;
	Sun, 11 Feb 2024 17:49:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 71018C0000D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707702598;
	bh=4H4FN5p/dLRBc4UInIB5xEnrfCp5/nfaFL6RntBbI4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aic1is5CI6YlvWP+lfvNuE64DAajWXAw/jyVZic6AqDZjSFpGMtUFirzZ6RR6jS9m
	 HzxqD7P65xYTetD5zSV4uak2/sktvjziVMDWCuyOXZBWdq6YFtADWj6EolKP1JyEBI
	 gD0Z5nYgDzKx30eNDRFm5yfaljBE+kGZpCTsr0rk=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id B6BD918041CAC4;
	Sun, 11 Feb 2024 17:49:56 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM GENET ETHERNET DRIVER),
	netdev@vger.kernel.org (open list:BROADCOM GENET ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 5.15 v3] net: bcmgenet: Fix EEE implementation
Date: Sun, 11 Feb 2024 17:48:58 -0800
Message-Id: <20240212014859.3860032-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212014859.3860032-1-florian.fainelli@broadcom.com>
References: <20240212014859.3860032-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a9f31047baca57d47440c879cf259b86f900260c upstream

We had a number of short comings:

- EEE must be re-evaluated whenever the state machine detects a link
  change as wight be switching from a link partner with EEE
  enabled/disabled

- tx_lpi_enabled controls whether EEE should be enabled/disabled for the
  transmit path, which applies to the TBUF block

- We do not need to forcibly enable EEE upon system resume, as the PHY
  state machine will trigger a link event that will do that, too

Fixes: 6ef398ea60d9 ("net: bcmgenet: add EEE support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20230606214348.2408018-1-florian.fainelli@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Changes in v3:

- correctly apply to the 5.15 queue

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 22 +++++++------------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  3 +++
 drivers/net/ethernet/broadcom/genet/bcmmii.c  |  6 +++++
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index eeadeeec17ba..380bf7a328ba 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1018,7 +1018,8 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 	}
 }
 
-static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	u32 off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
@@ -1038,7 +1039,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	/* Enable EEE and switch to a 27Mhz clock automatically */
 	reg = bcmgenet_readl(priv->base + off);
-	if (enable)
+	if (tx_lpi_enabled)
 		reg |= TBUF_EEE_EN | TBUF_PM_EN;
 	else
 		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
@@ -1059,6 +1060,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	priv->eee.eee_enabled = enable;
 	priv->eee.eee_active = enable;
+	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
 }
 
 static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
@@ -1074,6 +1076,7 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
 
 	e->eee_enabled = p->eee_enabled;
 	e->eee_active = p->eee_active;
+	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
 
 	return phy_ethtool_get_eee(dev->phydev, e);
@@ -1083,7 +1086,6 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct ethtool_eee *p = &priv->eee;
-	int ret = 0;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1094,16 +1096,11 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
 	p->eee_enabled = e->eee_enabled;
 
 	if (!p->eee_enabled) {
-		bcmgenet_eee_enable_set(dev, false);
+		bcmgenet_eee_enable_set(dev, false, false);
 	} else {
-		ret = phy_init_eee(dev->phydev, 0);
-		if (ret) {
-			netif_err(priv, hw, dev, "EEE initialization failed\n");
-			return ret;
-		}
-
+		p->eee_active = phy_init_eee(dev->phydev, false) >= 0;
 		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
-		bcmgenet_eee_enable_set(dev, true);
+		bcmgenet_eee_enable_set(dev, p->eee_active, e->tx_lpi_enabled);
 	}
 
 	return phy_ethtool_set_eee(dev->phydev, e);
@@ -3688,9 +3685,6 @@ static int bcmgenet_resume(struct device *d)
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-	if (priv->eee.eee_enabled)
-		bcmgenet_eee_enable_set(dev, true);
-
 	bcmgenet_netif_start(dev);
 
 	netif_device_attach(dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 5b7c2f9241d0..29bf256d13f6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -736,4 +736,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 			       enum bcmgenet_power_mode mode);
 
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled);
+
 #endif /* __BCMGENET_H__ */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 2fbec2acb606..026f00ccaa0c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -25,6 +25,7 @@
 
 #include "bcmgenet.h"
 
+
 /* setup netdev link state when PHY link status change and
  * update UMAC and RGMII block when link up
  */
@@ -96,6 +97,11 @@ void bcmgenet_mii_setup(struct net_device *dev)
 			       CMD_RX_PAUSE_IGNORE | CMD_TX_PAUSE_IGNORE);
 		reg |= cmd_bits;
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+
+		priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
+		bcmgenet_eee_enable_set(dev,
+					priv->eee.eee_enabled && priv->eee.eee_active,
+					priv->eee.tx_lpi_enabled);
 	} else {
 		/* done if nothing has changed */
 		if (!status_changed)
-- 
2.34.1


