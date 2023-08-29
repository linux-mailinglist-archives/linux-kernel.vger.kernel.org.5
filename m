Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30878C2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjH2KyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjH2Kxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F70CCD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E992F65476
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AE7C43391;
        Tue, 29 Aug 2023 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306409;
        bh=4G9a4mrPnqX1xIr+Ys2g0Bqa6pgj8luMxBWuM3WyNt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNTMFXHSTWcBnjogVakmr53uQSkbyTupJUmAtIOYLSroK3hrvrd/qYSMShHZPy8qg
         nansELJH3pokb/f+jvHYRp5NBFB7zw/XSuC6OeIkpcgv/ems8RJIW6LuVEUUsL3d7b
         8mBCuLAOgWZv6xbc86lWjNOqsQ1g9aUV8ytcv2hbZRxh475WHesqJbwRPE/PkhR1+7
         8jNDdo6QU9MsGS3jEEeu59jg7WEBDpwmxjCMoAKjTHSS90wq1etIHxhHLnO6oEIDFw
         xz5eGoFNtmHZ//Ku19lSTPeCsM7/0tK2DDcCt7nvYDSePQrf9S9Y8hbd9whji25DQT
         UZH9Cyjj0xh7w==
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
Subject: [PATCH net-next 09/22] net: stmmac: dwmac-lpc18xx: use devm_stmmac_probe_config_dt()
Date:   Tue, 29 Aug 2023 18:40:20 +0800
Message-Id: <20230829104033.955-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230829104033.955-1-jszhang@kernel.org>
References: <20230829104033.955-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   | 21 +++++--------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 18e84ba693a6..5d4936642de5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -37,7 +37,7 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
@@ -46,8 +46,7 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 	reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
 	if (IS_ERR(reg)) {
 		dev_err(&pdev->dev, "syscon lookup failed\n");
-		ret = PTR_ERR(reg);
-		goto err_remove_config_dt;
+		return PTR_ERR(reg);
 	}
 
 	if (plat_dat->interface == PHY_INTERFACE_MODE_MII) {
@@ -56,23 +55,13 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 		ethmode = LPC18XX_CREG_CREG6_ETHMODE_RMII;
 	} else {
 		dev_err(&pdev->dev, "Only MII and RMII mode supported\n");
-		ret = -EINVAL;
-		goto err_remove_config_dt;
+		return -EINVAL;
 	}
 
 	regmap_update_bits(reg, LPC18XX_CREG_CREG6,
 			   LPC18XX_CREG_CREG6_ETHMODE_MASK, ethmode);
 
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
 
 static const struct of_device_id lpc18xx_dwmac_match[] = {
@@ -83,7 +72,7 @@ MODULE_DEVICE_TABLE(of, lpc18xx_dwmac_match);
 
 static struct platform_driver lpc18xx_dwmac_driver = {
 	.probe  = lpc18xx_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "lpc18xx-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1

