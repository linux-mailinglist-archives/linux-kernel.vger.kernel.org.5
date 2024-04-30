Return-Path: <linux-kernel+bounces-163472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB2A8B6BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5A51F21791
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83829126F2C;
	Tue, 30 Apr 2024 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pAzY4Ekj"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB603BBE3;
	Tue, 30 Apr 2024 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462153; cv=none; b=HaQqQ0QZLd7HXwzZeTzyDhUbbXc3WM2zkzPdOIUrcBRU55oteZyDxcYOwZTLPKUImQqOA751APQStg3duqEM4sie12aW96wQgULAPnpu6AAKWTW+mV5mheau4UJVL9PWMO1k9EZ47ibU+Itg0lue7T+tBRiSLtOYwK3Fn0lOmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462153; c=relaxed/simple;
	bh=DPDVe3LFA+6CBx24SDwxAb8CpjYU1B/6sGWsr7qWW2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WK4U1dVscWgTmGGqWzjQXAu/kO5zPUKw3LUjIF7oXn7H213ozhoA/qFsz35I0UICZ26TKgxPfJl6rIw1TZ/0rpPTFzJrnhtcgwrZWlma/fzfwx2MtXzpxDMqmiXY7n/JUQwEX9465zMQcHMSg39Ia+54pRBfpUOdfd2iBz+DLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pAzY4Ekj; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F098240002;
	Tue, 30 Apr 2024 07:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714462148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCc/5DWJr0Wmss9ouvVqM9KULQkT2TgxRDjtMCmvwS4=;
	b=pAzY4EkjIuGARnGVvAgIDQ8cFa96R1aR/0FBMmGH0wAg9XCt29+nv+QwPoBRNRcvxDjRyP
	3kftfVP8AnZ9r7v768bnOjFeLVzt/bNbvIq1kSFP3h1tOcgfK6QA5nHG/9yv+v4ftvy+Bw
	s7b1gybW1popET48vA9HOmukGVWregAlxbRNdmiXNC2Z0tHw1IYX61/LIVNMWjjiFJfYzh
	tVc7MsxzstZfij/xRn5D4u4thT5/opX0LMeALRtFlkzYbYAJrzg4ANqFsLrasoUPlh7rJb
	iVlgj50FHZJLoADkZW/shx9MLgw+u272By/mWEnzAc3knPdTGbuUITOGpzYzuQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 30 Apr 2024 09:29:43 +0200
Subject: [PATCH net-next v5 3/7] net: stmmac: Make stmmac_xpcs_setup()
 generic to all PCS devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rzn1-gmac1-v5-3-62f65a84f418@bootlin.com>
References: <20240430-rzn1-gmac1-v5-0-62f65a84f418@bootlin.com>
In-Reply-To: <20240430-rzn1-gmac1-v5-0-62f65a84f418@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: romain.gantois@bootlin.com

From: Serge Semin <fancer.lancer@gmail.com>

A pcs_init() callback will be introduced to stmmac in a future patch. This
new function will be called during the hardware initialization phase.
Instead of separately initializing XPCS and PCS components, let's group all
PCS-related hardware initialization logic in the current
stmmac_xpcs_setup() function.

Rename stmmac_xpcs_setup() to stmmac_pcs_setup() and move the conditional
call to stmmac_xpcs_setup() inside the function itself.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Co-developed-by: Romain Gantois <romain.gantois@bootlin.com>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 28 ++++++++++++++---------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7e0d727ed795b..f275f2fd91c3e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -360,7 +360,7 @@ enum stmmac_state {
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
-int stmmac_xpcs_setup(struct mii_bus *mii);
+int stmmac_pcs_setup(struct net_device *ndev);
 void stmmac_pcs_clean(struct stmmac_priv *priv);
 void stmmac_set_ethtool_ops(struct net_device *netdev);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a55c5d07f6b8..72f4deda76407 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7754,11 +7754,9 @@ int stmmac_dvr_probe(struct device *device,
 	if (priv->plat->speed_mode_2500)
 		priv->plat->speed_mode_2500(ndev, priv->plat->bsp_priv);
 
-	if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
-		ret = stmmac_xpcs_setup(priv->mii);
-		if (ret)
-			goto error_xpcs_setup;
-	}
+	ret = stmmac_pcs_setup(ndev);
+	if (ret)
+		goto error_pcs_setup;
 
 	ret = stmmac_phy_setup(priv);
 	if (ret) {
@@ -7791,7 +7789,7 @@ int stmmac_dvr_probe(struct device *device,
 	phylink_destroy(priv->phylink);
 error_phy_setup:
 	stmmac_pcs_clean(priv);
-error_xpcs_setup:
+error_pcs_setup:
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 508bd39cbe2b3..af8ad9768da10 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -495,31 +495,37 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 	return 0;
 }
 
-int stmmac_xpcs_setup(struct mii_bus *bus)
+int stmmac_pcs_setup(struct net_device *ndev)
 {
-	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv;
 	struct dw_xpcs *xpcs;
+	int ret = -ENODEV;
 	int mode, addr;
 
 	priv = netdev_priv(ndev);
 	mode = priv->plat->phy_interface;
 
-	/* Try to probe the XPCS by scanning all addresses. */
-	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-		xpcs = xpcs_create_mdiodev(bus, addr, mode);
-		if (IS_ERR(xpcs))
-			continue;
+	if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
+		/* Try to probe the XPCS by scanning all addresses */
+		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
+			xpcs = xpcs_create_mdiodev(priv->mii, addr, mode);
+			if (IS_ERR(xpcs))
+				continue;
 
-		priv->hw->xpcs = xpcs;
-		break;
+			ret = 0;
+			break;
+		}
+	} else {
+		return 0;
 	}
 
-	if (!priv->hw->xpcs) {
+	if (ret) {
 		dev_warn(priv->device, "No xPCS found\n");
-		return -ENODEV;
+		return ret;
 	}
 
+	priv->hw->xpcs = xpcs;
+
 	return 0;
 }
 

-- 
2.44.0


