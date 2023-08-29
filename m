Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8D78C2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjH2Kyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjH2KyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A4CCF4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F6176545D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732C2C433CA;
        Tue, 29 Aug 2023 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306429;
        bh=isFMv5J3rpOHLVDhhNbIoTnhkQjoG9ObXVsYmwnSTWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhoBUQV2UlvEvXTJ6FesBJUWqQ8Fgm4vPFQR3HIO5bXsCvSSxhZFddMPEm0stx9ef
         lMRynaqBRCIVrvXglDzIgWvfuNXWJvNeMTNUO7MEx5bQMfUlG7YWN9DC40vnXhy2KA
         V5X06L2jau4ArXqR+Gt+rvakJx4Bmdoj7hYswq7SUCBC/nBTtRHqd1xNsgwOq6nMLb
         gDz7uN2o7DVL0uUpAuDv9Z0ZN1Ud+XK3jAiOUvfy5IjbvkK9P2RkafPzmqFpWUFHdD
         kiH9G4Cw9hG/3cIw2SuRlgzlWaS+bQb+NBToTsk7Nx/rNTImuQsh9u/B3Pz95GYWzC
         H19/PmdaPlrZg==
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
Subject: [PATCH net-next 12/22] net: stmmac: dwmac-meson8b: use devm_stmmac_probe_config_dt()
Date:   Tue, 29 Aug 2023 18:40:23 +0800
Message-Id: <20230829104033.955-13-jszhang@kernel.org>
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
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 55 ++++++-------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 0b159dc0d5f6..37f249980929 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -400,33 +400,27 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
-	if (!dwmac) {
-		ret = -ENOMEM;
-		goto err_remove_config_dt;
-	}
+	if (!dwmac)
+		return -ENOMEM;
 
 	dwmac->data = (const struct meson8b_dwmac_data *)
 		of_device_get_match_data(&pdev->dev);
-	if (!dwmac->data) {
-		ret = -EINVAL;
-		goto err_remove_config_dt;
-	}
+	if (!dwmac->data)
+		return -EINVAL;
 	dwmac->regs = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(dwmac->regs)) {
-		ret = PTR_ERR(dwmac->regs);
-		goto err_remove_config_dt;
-	}
+	if (IS_ERR(dwmac->regs))
+		return PTR_ERR(dwmac->regs);
 
 	dwmac->dev = &pdev->dev;
 	ret = of_get_phy_mode(pdev->dev.of_node, &dwmac->phy_mode);
 	if (ret) {
 		dev_err(&pdev->dev, "missing phy-mode property\n");
-		goto err_remove_config_dt;
+		return ret;
 	}
 
 	/* use 2ns as fallback since this value was previously hardcoded */
@@ -448,53 +442,40 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 		if (dwmac->rx_delay_ps > 3000 || dwmac->rx_delay_ps % 200) {
 			dev_err(dwmac->dev,
 				"The RGMII RX delay range is 0..3000ps in 200ps steps");
-			ret = -EINVAL;
-			goto err_remove_config_dt;
+			return -EINVAL;
 		}
 	} else {
 		if (dwmac->rx_delay_ps != 0 && dwmac->rx_delay_ps != 2000) {
 			dev_err(dwmac->dev,
 				"The only allowed RGMII RX delays values are: 0ps, 2000ps");
-			ret = -EINVAL;
-			goto err_remove_config_dt;
+			return -EINVAL;
 		}
 	}
 
 	dwmac->timing_adj_clk = devm_clk_get_optional(dwmac->dev,
 						      "timing-adjustment");
-	if (IS_ERR(dwmac->timing_adj_clk)) {
-		ret = PTR_ERR(dwmac->timing_adj_clk);
-		goto err_remove_config_dt;
-	}
+	if (IS_ERR(dwmac->timing_adj_clk))
+		return PTR_ERR(dwmac->timing_adj_clk);
 
 	ret = meson8b_init_rgmii_delays(dwmac);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = meson8b_init_rgmii_tx_clk(dwmac);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = dwmac->data->set_phy_mode(dwmac);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = meson8b_init_prg_eth(dwmac);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	plat_dat->bsp_priv = dwmac;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto err_remove_config_dt;
-
-	return 0;
-
-err_remove_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
-
-	return ret;
+	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
 
 static const struct meson8b_dwmac_data meson8b_dwmac_data = {
@@ -539,7 +520,7 @@ MODULE_DEVICE_TABLE(of, meson8b_dwmac_match);
 
 static struct platform_driver meson8b_dwmac_driver = {
 	.probe  = meson8b_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "meson8b-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1

