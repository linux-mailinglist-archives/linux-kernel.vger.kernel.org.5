Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9348378C2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjH2Kx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjH2Kx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:53:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19251A6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60ED565477
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042DCC433C9;
        Tue, 29 Aug 2023 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306402;
        bh=08rPVmjgSTC5liiFw2rBYcil6Ema5CtgYx2svnPVZ9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5HtVQg/NZDq8bzJbfWKwq8tryUNgQg8yaetqX9K5c4yo0GDp9ttEHol3rIDBiylv
         EqcnhPRKkLuSs+3TWvl68Co1GKm+imRd60uNXw6y9E6CtGeP0OV/T1K8+6vJQH/4dz
         YiVGAU+O+9z6xtVPi91F3t921Dg/OBD+WA1r/bUFIXmqpdVJ+8VvtTigIKtt4jx4tS
         ny50lX/LrFOLgbrkzAewDhK0pb2sdjKB9k4ixh4RGy9dtHKWFDf5I6kixKtGhhjQ6j
         Im9sFPuT0ffHm81u97su6N9yYn00q58lTt3kIOgpepJDbH39G51kLhziUnjyG3fW6N
         K36iDXIcTja7Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/22] net: stmmac: dwmac-ipq806x: use devm_stmmac_probe_config_dt()
Date:   Tue, 29 Aug 2023 18:40:19 +0800
Message-Id: <20230829104033.955-9-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230829104033.955-1-jszhang@kernel.org>
References: <20230829104033.955-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the driver's probe() function by using the devres
variant of stmmac_probe_config_dt().

The remove_new() callback now needs to be switched to
stmmac_pltfr_remove_no_dt().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   | 29 ++++++-------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index 9b0200749109..a9916fd07616 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -384,22 +384,20 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 	if (val)
 		return val;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	gmac = devm_kzalloc(dev, sizeof(*gmac), GFP_KERNEL);
-	if (!gmac) {
-		err = -ENOMEM;
-		goto err_remove_config_dt;
-	}
+	if (!gmac)
+		return -ENOMEM;
 
 	gmac->pdev = pdev;
 
 	err = ipq806x_gmac_of_parse(gmac);
 	if (err) {
 		dev_err(dev, "device tree parsing error\n");
-		goto err_remove_config_dt;
+		return err;
 	}
 
 	regmap_write(gmac->qsgmii_csr, QSGMII_PCS_CAL_LCKDT_CTL,
@@ -459,11 +457,11 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 	if (gmac->phy_mode == PHY_INTERFACE_MODE_SGMII) {
 		err = ipq806x_gmac_configure_qsgmii_params(gmac);
 		if (err)
-			goto err_remove_config_dt;
+			return err;
 
 		err = ipq806x_gmac_configure_qsgmii_pcs_speed(gmac);
 		if (err)
-			goto err_remove_config_dt;
+			return err;
 	}
 
 	plat_dat->has_gmac = true;
@@ -473,21 +471,12 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 	plat_dat->tx_fifo_size = 8192;
 	plat_dat->rx_fifo_size = 8192;
 
-	err = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (err)
-		goto err_remove_config_dt;
-
-	return 0;
+	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 
 err_unsupported_phy:
 	dev_err(&pdev->dev, "Unsupported PHY mode: \"%s\"\n",
 		phy_modes(gmac->phy_mode));
-	err = -EINVAL;
-
-err_remove_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
-
-	return err;
+	return -EINVAL;
 }
 
 static const struct of_device_id ipq806x_gmac_dwmac_match[] = {
@@ -498,7 +487,7 @@ MODULE_DEVICE_TABLE(of, ipq806x_gmac_dwmac_match);
 
 static struct platform_driver ipq806x_gmac_dwmac_driver = {
 	.probe = ipq806x_gmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name		= "ipq806x-gmac-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1

