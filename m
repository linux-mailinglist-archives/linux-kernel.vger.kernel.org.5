Return-Path: <linux-kernel+bounces-163469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DA08B6BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D411D1C21E01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0258E40BEE;
	Tue, 30 Apr 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZxwuCRRb"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25B39FEF;
	Tue, 30 Apr 2024 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462151; cv=none; b=aj3+9tM/Q0rtMGbQ41xC7WT4eIVC0PxhRQoeEUUrTwLLunGbvGVVaORnM2j8HjF7KIrvkkuCGNIBu/JVkbJyM5pWQeC4+OjZwJ98zJMfDYjf2ZDo44FB94mt3kwhyG5dpBNmy2jfOTcdiDxhF7FHiS0CTSZpoX0yKQrLhJjxhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462151; c=relaxed/simple;
	bh=wqQBKvD/8mW1etTfTpBxYw2E+JdyqE03VV3MwM6d0K8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HI3A1dDr9h2/76hcZpxfQAcZbE9+aYtEUJkHygYLOO5m1AqYEQLAPgJ2pond58CZzEtbrte78GBQITxD9ZnuvvCE8ZqeATiJf8m8yA+brbeXHHdZeTvlpwuu16bRTT0vfc0JvPls4aUdrm3bB4E2YDk9sclNchnz4N6nzHoUTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZxwuCRRb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 319CF24000B;
	Tue, 30 Apr 2024 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714462147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Quwz6Y6DCJb6oI8QivjHVeJ8W6gP2+As4r5PbpcMIik=;
	b=ZxwuCRRbn1FQlBI4z2c9GSAvPY/TW1CMBCxRD+iRIiteCUzjtF+IQ4XvRXzA/TeRQbyojZ
	Rrp3s1TWVVeyGCBCwMd4y9jTQG14n56nB6m+ILT0XBATUXn9G88e2bheoEKc1ByN5lP9Ql
	WnQyfPmWAOdArHELhHYAVH71FPH+pI3pqEpNas/kF0+XvsgIQEJfT07qbTSd6nTKfrzKRe
	rIPIDNup+s4Ez3ptqXYR4Gs45cAkb0L9RucYO03U1W2aBlTatCwTa9shguXaA0E6FCsedZ
	jsqZNnusVtA8SdVHVeLSFFNCKqMo7ZppyHuEaKF1jIJHxOkKmQVQTd3Kn/uflQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 30 Apr 2024 09:29:42 +0200
Subject: [PATCH net-next v5 2/7] net: stmmac: Add dedicated XPCS cleanup
 method
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rzn1-gmac1-v5-2-62f65a84f418@bootlin.com>
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

Currently the XPCS handler destruction is performed in the
stmmac_mdio_unregister() method. It doesn't look good because the handler
isn't originally created in the corresponding protagonist
stmmac_mdio_unregister(), but in the stmmac_xpcs_setup() function. In
order to have more coherent MDIO and XPCS setup/cleanup procedures,
let's move the DW XPCS destruction to the dedicated stmmac_pcs_clean()
method.

This method will also be used to cleanup PCS hardware using the
pcs_exit() callback that will be introduced to stmmac in a subsequent
patch.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Co-developed-by: Romain Gantois <romain.gantois@bootlin.com>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  6 +++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 12 +++++++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index dddcaa9220cc3..7e0d727ed795b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -361,6 +361,7 @@ int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
 int stmmac_xpcs_setup(struct mii_bus *mii);
+void stmmac_pcs_clean(struct stmmac_priv *priv);
 void stmmac_set_ethtool_ops(struct net_device *netdev);
 
 int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 59bf83904b62d..2a55c5d07f6b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7789,8 +7789,9 @@ int stmmac_dvr_probe(struct device *device,
 
 error_netdev_register:
 	phylink_destroy(priv->phylink);
-error_xpcs_setup:
 error_phy_setup:
+	stmmac_pcs_clean(priv);
+error_xpcs_setup:
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
@@ -7832,6 +7833,9 @@ void stmmac_dvr_remove(struct device *dev)
 	if (priv->plat->stmmac_rst)
 		reset_control_assert(priv->plat->stmmac_rst);
 	reset_control_assert(priv->plat->stmmac_ahb_rst);
+
+	stmmac_pcs_clean(priv);
+
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 0542cfd1817e6..508bd39cbe2b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -523,6 +523,15 @@ int stmmac_xpcs_setup(struct mii_bus *bus)
 	return 0;
 }
 
+void stmmac_pcs_clean(struct stmmac_priv *priv)
+{
+	if (!priv->hw->xpcs)
+		return;
+
+	xpcs_destroy(priv->hw->xpcs);
+	priv->hw->xpcs = NULL;
+}
+
 /**
  * stmmac_mdio_register
  * @ndev: net device structure
@@ -679,9 +688,6 @@ int stmmac_mdio_unregister(struct net_device *ndev)
 	if (!priv->mii)
 		return 0;
 
-	if (priv->hw->xpcs)
-		xpcs_destroy(priv->hw->xpcs);
-
 	mdiobus_unregister(priv->mii);
 	priv->mii->priv = NULL;
 	mdiobus_free(priv->mii);

-- 
2.44.0


