Return-Path: <linux-kernel+bounces-58524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02184E796
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440841F27533
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C2586AFD;
	Thu,  8 Feb 2024 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="pg7JONnp"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89DC823C2;
	Thu,  8 Feb 2024 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416452; cv=none; b=JK/GtQ+MrbmdEIqpl3KjH16WYIDSzU3Qoh/16zSnZGFsrGTZcuLa8zxCAFXmJi1JZ78iC35Mly5R+kkrba5mfYmqA7VBuxgnziOe98D6QAWbwGJKCmnKYJKt1i/F+hXdaXZtCpGw1IF6XoDS+yam/yjLYtkN/yMEjVHKH4+t7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416452; c=relaxed/simple;
	bh=oSNraDIjNZgqeOB4YZoeNAkbN+8dHm4kET6YmMe3Bl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFTzUt22xlKM5WlXiNzQaefobO4J6hSZngRLYbPnKLJJMdLQpdvWB7jpyOqNumkKroazO/bZBlJSxP5715Pdk9Dl4R1DQ7fQGMo/dWNrQgt4JRWIkNc++0D9+xrkvHBXXjsNG8E76EQpxj21Cf4MPFYmZQPuR6u0Q0moLwpBn8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=pg7JONnp; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1F7ABC00167E;
	Thu,  8 Feb 2024 10:20:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1F7ABC00167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707416450;
	bh=oSNraDIjNZgqeOB4YZoeNAkbN+8dHm4kET6YmMe3Bl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pg7JONnp28Gi/i148JjkxuqoXC9IcR0ehy0tZrOjiCFxQTQe//qZH4JQolvvCwca3
	 Ia/t3vrWxeJEyDHwYl7jLfjlVVmkdK+HJzLOaRPr19grj6KYAvRgL4Q4t0XI9ixNyr
	 iCDG3sFIXNZym9pcQnIGQQKeDkG0SK6W7mQWjC9g=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 7A72B18041CAC4;
	Thu,  8 Feb 2024 10:20:48 -0800 (PST)
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
Subject: [PATCH stable 5.15] net: bcmgenet: Fix EEE implementation
Date: Thu,  8 Feb 2024 10:20:41 -0800
Message-Id: <20240208182041.3228898-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208182041.3228898-1-florian.fainelli@broadcom.com>
References: <20240208182041.3228898-1-florian.fainelli@broadcom.com>
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


