Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3EC78C2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjH2K4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjH2K4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:56:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60671CF2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AC7E6547C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2CEC433CB;
        Tue, 29 Aug 2023 10:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306478;
        bh=YIjtmUbVrg/RXcc1/xGF0odjZwPY+o3yQzwT12xvMT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kpGlg8goH2fAwB0KtHFx0u7iYJh4nD3j5g7QPH2L4u6HRlUygRl6b/C1MG7cjEyjb
         IC2R+66bEhVHHNB9qmp5eMtTBx5heJ6eHO9V157tTqah6E5SettWXei2mcweRCbSTH
         O5RwW2ZxMunS199TpsHVJBLJq+yKX4h58TpuF4xFcI1VxOo+r0sVxLql+XkcP/YM4/
         AIAfT6kxiOESS1vh9HmKMMlUcJjmwdGhvgRRZfHgptT7pz2YcKjeaeqsx2zF3rVCOH
         NmTj1OSnX7VpGGulAy8sLcGz/5CGkL1Wz3I8H3D7GT+s2Ixs6FECRLf8oZM7yd5FWc
         98F1DruYetwgA==
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
Subject: [PATCH net-next 19/22] net: stmmac: dwmac-sunxi: use devm_stmmac_probe_config_dt()
Date:   Tue, 29 Aug 2023 18:40:30 +0800
Message-Id: <20230829104033.955-20-jszhang@kernel.org>
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
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index beceeae579bf..b857235f5b1f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -108,36 +108,31 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	gmac = devm_kzalloc(dev, sizeof(*gmac), GFP_KERNEL);
-	if (!gmac) {
-		ret = -ENOMEM;
-		goto err_remove_config_dt;
-	}
+	if (!gmac)
+		return -ENOMEM;
 
 	ret = of_get_phy_mode(dev->of_node, &gmac->interface);
 	if (ret && ret != -ENODEV) {
 		dev_err(dev, "Can't get phy-mode\n");
-		goto err_remove_config_dt;
+		return ret;
 	}
 
 	gmac->tx_clk = devm_clk_get(dev, "allwinner_gmac_tx");
 	if (IS_ERR(gmac->tx_clk)) {
 		dev_err(dev, "could not get tx clock\n");
-		ret = PTR_ERR(gmac->tx_clk);
-		goto err_remove_config_dt;
+		return PTR_ERR(gmac->tx_clk);
 	}
 
 	/* Optional regulator for PHY */
 	gmac->regulator = devm_regulator_get_optional(dev, "phy");
 	if (IS_ERR(gmac->regulator)) {
-		if (PTR_ERR(gmac->regulator) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto err_remove_config_dt;
-		}
+		if (PTR_ERR(gmac->regulator) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_info(dev, "no regulator found\n");
 		gmac->regulator = NULL;
 	}
@@ -155,7 +150,7 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 
 	ret = sun7i_gmac_init(pdev, plat_dat->bsp_priv);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
@@ -165,8 +160,6 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 
 err_gmac_exit:
 	sun7i_gmac_exit(pdev, plat_dat->bsp_priv);
-err_remove_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
 }
@@ -179,7 +172,7 @@ MODULE_DEVICE_TABLE(of, sun7i_dwmac_match);
 
 static struct platform_driver sun7i_dwmac_driver = {
 	.probe  = sun7i_gmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "sun7i-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1

