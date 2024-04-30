Return-Path: <linux-kernel+bounces-163474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64B8B6BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4611C21E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD8E199E85;
	Tue, 30 Apr 2024 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z+pbr3pU"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B645035;
	Tue, 30 Apr 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462155; cv=none; b=GzjkQ228jNdKXLiAIpdSNymiI6Hj1aBwkAK77HeYlpCtX9GRsAKT2rSMDqGybRmKRMiq4IdHvIs2s8Z67XwihZq4+NpA84BnWnzHWPRXkwgl+ykjkr+zxtyCVmnkwXWY2VKk4VMQAI8Jb0eHrW9vgH7DOG5U+C/lv/xn+0gK3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462155; c=relaxed/simple;
	bh=WfbHQ9J7Vj6Au6Wu1gSPNi7Hq04hHOwQv7EbexUSc80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSMsDqgqc6YSrBNk7slRbBMfzjS89qXELvCkMHgNijWXvtZdqeKI49bsPqSgDX8Ht9l8/lniTF5LV8b8xl5kvcyREJ2NVAKgy0N1zOGDIPm8HA6M2IVgKBj4UdW5SGs/IFJrDLixqPREMX31+ZI1S44VAZ07Sdt8K/ouKK4jLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z+pbr3pU; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B95EB24000A;
	Tue, 30 Apr 2024 07:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714462150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7+0uNrudWCYDEwJNq5iDZw6vcb4ldKLdBbxspu2IAY=;
	b=Z+pbr3pUxZKx7YLOUuYBhbhqgqQQSGFa+G6CfWtyrESIM7dZp9gqGorJEk0CPB8KpJltmk
	8C/ys1ygbS9gegAdyz3ArsPxmCUPa7zIltE5CXOS/Z5UaI9XX1Y5VZrVhLMp6FMtDLtkQj
	TZmSup1g6Rubz8dWzW4Nao4qyiJTKhE2l8W4YJ/FzR3S3pcRKVG+J7tAJC67Ht9N0oOPAS
	gm/+33aZLv+r2DLMqYY1nxxC/9au7pdgN8bpshd9wvhIoldjf5GoWspNaf4+U4BX03WCKU
	whb8Nzf5UzbmSwzivpbZcQbjESwdwnzRmKzlQGRKERGV2fgS6h/rUif4qSlITA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 30 Apr 2024 09:29:45 +0200
Subject: [PATCH net-next v5 5/7] net: stmmac: dwmac-socfpga: use
 pcs_init/pcs_exit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rzn1-gmac1-v5-5-62f65a84f418@bootlin.com>
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

Use the newly introduced pcs_init() and pcs_exit() operations to
create and destroy the PCS instance at a more appropriate moment during
the driver lifecycle, thereby avoiding publishing a network device to
userspace that has not yet finished its PCS initialisation.

There are other similar issues with this driver which remain
unaddressed, but these are out of scope for this patch.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
[rgantois: removed second parameters of new callbacks]
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 107 ++++++++++-----------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 12b4a80ea3aa1..b3d45f9dfb556 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -379,6 +379,56 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 	return 0;
 }
 
+static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv)
+{
+	struct socfpga_dwmac *dwmac = priv->plat->bsp_priv;
+	struct regmap_config pcs_regmap_cfg = {
+		.reg_bits = 16,
+		.val_bits = 16,
+		.reg_shift = REGMAP_UPSHIFT(1),
+	};
+	struct mdio_regmap_config mrc;
+	struct regmap *pcs_regmap;
+	struct phylink_pcs *pcs;
+	struct mii_bus *pcs_bus;
+
+	if (!dwmac->tse_pcs_base)
+		return 0;
+
+	pcs_regmap = devm_regmap_init_mmio(priv->device, dwmac->tse_pcs_base,
+					   &pcs_regmap_cfg);
+	if (IS_ERR(pcs_regmap))
+		return PTR_ERR(pcs_regmap);
+
+	memset(&mrc, 0, sizeof(mrc));
+	mrc.regmap = pcs_regmap;
+	mrc.parent = priv->device;
+	mrc.valid_addr = 0x0;
+	mrc.autoscan = false;
+
+	/* Can't use ndev->name here because it will not have been initialised,
+	 * and in any case, the user can rename network interfaces at runtime.
+	 */
+	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii",
+		 dev_name(priv->device));
+	pcs_bus = devm_mdio_regmap_register(priv->device, &mrc);
+	if (IS_ERR(pcs_bus))
+		return PTR_ERR(pcs_bus);
+
+	pcs = lynx_pcs_create_mdiodev(pcs_bus, 0);
+	if (IS_ERR(pcs))
+		return PTR_ERR(pcs);
+
+	priv->hw->phylink_pcs = pcs;
+	return 0;
+}
+
+static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv)
+{
+	if (priv->hw->phylink_pcs)
+		lynx_pcs_destroy(priv->hw->phylink_pcs);
+}
+
 static int socfpga_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -426,6 +476,8 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	dwmac->ops = ops;
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
+	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
+	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
@@ -444,48 +496,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dvr_remove;
 
-	/* Create a regmap for the PCS so that it can be used by the PCS driver,
-	 * if we have such a PCS
-	 */
-	if (dwmac->tse_pcs_base) {
-		struct regmap_config pcs_regmap_cfg;
-		struct mdio_regmap_config mrc;
-		struct regmap *pcs_regmap;
-		struct mii_bus *pcs_bus;
-
-		memset(&pcs_regmap_cfg, 0, sizeof(pcs_regmap_cfg));
-		memset(&mrc, 0, sizeof(mrc));
-
-		pcs_regmap_cfg.reg_bits = 16;
-		pcs_regmap_cfg.val_bits = 16;
-		pcs_regmap_cfg.reg_shift = REGMAP_UPSHIFT(1);
-
-		pcs_regmap = devm_regmap_init_mmio(&pdev->dev, dwmac->tse_pcs_base,
-						   &pcs_regmap_cfg);
-		if (IS_ERR(pcs_regmap)) {
-			ret = PTR_ERR(pcs_regmap);
-			goto err_dvr_remove;
-		}
-
-		mrc.regmap = pcs_regmap;
-		mrc.parent = &pdev->dev;
-		mrc.valid_addr = 0x0;
-		mrc.autoscan = false;
-
-		snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii", ndev->name);
-		pcs_bus = devm_mdio_regmap_register(&pdev->dev, &mrc);
-		if (IS_ERR(pcs_bus)) {
-			ret = PTR_ERR(pcs_bus);
-			goto err_dvr_remove;
-		}
-
-		stpriv->hw->phylink_pcs = lynx_pcs_create_mdiodev(pcs_bus, 0);
-		if (IS_ERR(stpriv->hw->phylink_pcs)) {
-			ret = PTR_ERR(stpriv->hw->phylink_pcs);
-			goto err_dvr_remove;
-		}
-	}
-
 	return 0;
 
 err_dvr_remove:
@@ -494,17 +504,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void socfpga_dwmac_remove(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct phylink_pcs *pcs = priv->hw->phylink_pcs;
-
-	stmmac_pltfr_remove(pdev);
-
-	lynx_pcs_destroy(pcs);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int socfpga_dwmac_resume(struct device *dev)
 {
@@ -576,7 +575,7 @@ MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
 
 static struct platform_driver socfpga_dwmac_driver = {
 	.probe  = socfpga_dwmac_probe,
-	.remove_new = socfpga_dwmac_remove,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "socfpga-dwmac",
 		.pm		= &socfpga_dwmac_pm_ops,

-- 
2.44.0


