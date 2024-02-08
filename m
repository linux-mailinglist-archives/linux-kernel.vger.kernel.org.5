Return-Path: <linux-kernel+bounces-58597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D65484E8AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A559C1F2DA05
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26AB28DBF;
	Thu,  8 Feb 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OeX9dN8p"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7725601;
	Thu,  8 Feb 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419171; cv=none; b=AZRNKJGrTRkADU3QGsJi6VlnoaolYwnz3+7lCXtwQjU4N0XRhq7W4UjQfThoiKbjK+Zv5drDM4bdvO7RVT6xcT8p03Kksd0Cb3k3YAMXA7pv11kQXVaxQkpWeOwLh4FnxBNC8k73Uhe4g/Z5arjnq4jyuu3rUcASkpyUodTh2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419171; c=relaxed/simple;
	bh=pyH+Ue54Wg/q6X3n+rbfohcY/QkgjD9zNm2XlWtPMdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDnfp6/uKe0rtmq6vpk5yolOPrbEIQzCxzJpMsbXdaUk/HZApA4u/3Zqv72DGSXHtYYDBb+sXKligw8RFzlsPAydvY+wp0qCCIG/yilALjM29Lvi/hPj1fZu8dGmXsEGVjxANKhH/PtGvGZ6z4Ga5/ZcIxP7EM9axtYlqdY/JYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OeX9dN8p; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9FA97C001CAD;
	Thu,  8 Feb 2024 11:06:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9FA97C001CAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707419168;
	bh=pyH+Ue54Wg/q6X3n+rbfohcY/QkgjD9zNm2XlWtPMdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OeX9dN8pKGCF8ytWIGGd88VHSocOFcVKIRUqTrA7UjTLXtlOOC0xpldeiWbsOYznB
	 rohTCl1F3LmGoT7quZb4COL3x6uoUBxd9gyUaPZ8cat3WOWJYN/qREOBvvwSz2U8qi
	 pa+To89xhUqa0JrIUOi3fWHn/fWdYNrp69tOayHA=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 1E08918041CAC4;
	Thu,  8 Feb 2024 11:06:07 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM GENET ETHERNET DRIVER),
	netdev@vger.kernel.org (open list:BROADCOM GENET ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 5.15 v2] net: bcmgenet: Fix EEE implementation
Date: Thu,  8 Feb 2024 11:06:05 -0800
Message-Id: <20240208190605.3341379-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208190605.3341379-1-florian.fainelli@broadcom.com>
References: <20240208190605.3341379-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit a9f31047baca57d47440c879cf259b86f900260c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- none

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 22 +++++++------------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  3 +++
 drivers/net/ethernet/broadcom/genet/bcmmii.c  |  5 +++++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 66f0c28298bf..7327a8d5dc75 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1318,7 +1318,8 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 	}
 }
 
-static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	u32 off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
@@ -1338,7 +1339,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	/* Enable EEE and switch to a 27Mhz clock automatically */
 	reg = bcmgenet_readl(priv->base + off);
-	if (enable)
+	if (tx_lpi_enabled)
 		reg |= TBUF_EEE_EN | TBUF_PM_EN;
 	else
 		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
@@ -1359,6 +1360,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	priv->eee.eee_enabled = enable;
 	priv->eee.eee_active = enable;
+	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
 }
 
 static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
@@ -1374,6 +1376,7 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
 
 	e->eee_enabled = p->eee_enabled;
 	e->eee_active = p->eee_active;
+	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
 
 	return phy_ethtool_get_eee(dev->phydev, e);
@@ -1383,7 +1386,6 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct ethtool_eee *p = &priv->eee;
-	int ret = 0;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1394,16 +1396,11 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
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
@@ -4219,9 +4216,6 @@ static int bcmgenet_resume(struct device *d)
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-	if (priv->eee.eee_enabled)
-		bcmgenet_eee_enable_set(dev, true);
-
 	bcmgenet_netif_start(dev);
 
 	netif_device_attach(dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index d111af605c44..95b3db100af6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -735,4 +735,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 			      enum bcmgenet_power_mode mode);
 
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled);
+
 #endif /* __BCMGENET_H__ */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 32fc845ade9e..72bb9364a471 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -87,6 +87,11 @@ static void bcmgenet_mac_config(struct net_device *dev)
 		reg |= CMD_TX_EN | CMD_RX_EN;
 	}
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+
+	priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
+	bcmgenet_eee_enable_set(dev,
+				priv->eee.eee_enabled && priv->eee.eee_active,
+				priv->eee.tx_lpi_enabled);
 }
 
 /* setup netdev link state when PHY link status change and
-- 
2.34.1


