Return-Path: <linux-kernel+bounces-163473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555528B6BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A47B21CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CFD13AD2F;
	Tue, 30 Apr 2024 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cE/jd3OH"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BF3E478;
	Tue, 30 Apr 2024 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462153; cv=none; b=ZPgwPA9ae7D1xI6r1htrK7fFzmFl013A2avAVtnUgkDAj27zg1y0Cz/E+1bX3Pu3WV1AHVZETnW80L7wA8QyrN0fR0Oo32EFojXFG/1M4992cI0L4yJoNsQr9rMNdcWFYfpP1u/iFjsWaLYKKUPqnjBrRpDroU63bfQWMV5ijM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462153; c=relaxed/simple;
	bh=B3/uuEQKrO405t7es5+Y1fjgKbaZC53LaBScd9e7gNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HukUpSLX75PKQn2msvPN5blcBGtH04LlFVE8nXGGg3dHT9/PksK044Z0d1577LK2tSdGZ3eFJwDs3sc/EQOiBVjcN82HAu+DwJm5grFxH1NYUkHlE5cn/mRoo2ayWHkSyMBZ6TvbolVf0b2iuTYDVMCmZ1uutLC8mxKnl6QRrik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cE/jd3OH; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77A2C24000D;
	Tue, 30 Apr 2024 07:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714462149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5xJj++e/DBPx9ddAMfQsap+qn6muqbGCvqtygpbwCk=;
	b=cE/jd3OH5C4sWGElGhuhLznxd5UCD3Vf6u6N1drukFen+XxyVsOikegWQ6dC4laMHLVTor
	KvXcE47qheuvCv1Z9UE/8+l3WCP5xqjfUDpHBrv+UQlKflGvZPMIIWIpGovomB5+mTW1oz
	ldjjXkWkYExoWYL2QMZT+xcA01y/lrOHqevDt+SKiRhmPp7gqHIRYJiW9ihiDWdSy28+UO
	kXsxfhylKYVhyEZlyQ+hFLHZzYGuXHxt9p1QDpUHJRR87rtmkDt+L/UYMGeLjWZD9a5YEf
	LkT38NHGdZYJsXxidcWSjzz3FraTOGkqXaKvJfqIfhQk3HwXMShdskXYe56x/A==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 30 Apr 2024 09:29:44 +0200
Subject: [PATCH net-next v5 4/7] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rzn1-gmac1-v5-4-62f65a84f418@bootlin.com>
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
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: romain.gantois@bootlin.com

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Introduce a mechanism whereby platforms can create their PCS instances
prior to the network device being published to userspace, but after
some of the core stmmac initialisation has been completed. This means
that the data structures that platforms need will be available.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Co-developed-by: Romain Gantois <romain.gantois@bootlin.com>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 +++++++-
 include/linux/stmmac.h                            | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index af8ad9768da10..1c788caea0cfb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -505,7 +505,10 @@ int stmmac_pcs_setup(struct net_device *ndev)
 	priv = netdev_priv(ndev);
 	mode = priv->plat->phy_interface;
 
-	if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
+	if (priv->plat->pcs_init) {
+		ret = priv->plat->pcs_init(priv);
+	} else if (priv->plat->mdio_bus_data &&
+		   priv->plat->mdio_bus_data->has_xpcs) {
 		/* Try to probe the XPCS by scanning all addresses */
 		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
 			xpcs = xpcs_create_mdiodev(priv->mii, addr, mode);
@@ -531,6 +534,9 @@ int stmmac_pcs_setup(struct net_device *ndev)
 
 void stmmac_pcs_clean(struct stmmac_priv *priv)
 {
+	if (priv->plat->pcs_exit)
+		priv->plat->pcs_exit(priv);
+
 	if (!priv->hw->xpcs)
 		return;
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756a..4a24a246c617d 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -285,6 +285,8 @@ struct plat_stmmacenet_data {
 	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,
 			   void *ctx);
 	void (*dump_debug_regs)(void *priv);
+	int (*pcs_init)(struct stmmac_priv *priv);
+	void (*pcs_exit)(struct stmmac_priv *priv);
 	void *bsp_priv;
 	struct clk *stmmac_clk;
 	struct clk *pclk;

-- 
2.44.0


