Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5352478C2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjH2KzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjH2Kyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE381B4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2CA265480
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186B9C433C9;
        Tue, 29 Aug 2023 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306443;
        bh=t/qZfTePzBF9rz4rKqEEIEiN88+VpqM8jDM5ugou+X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjQ407ej0DuppX7l3wWIoYPh59u+KPsZthsdM//5UrYvPZSkQAqSu74CuVjUGEQTI
         B0Rv/J1DzPIfgrEfbvDlGxhqYOdSBNWNlTjUT9vhKJgqE4XJSRq2Smjbx4vc5HLeq9
         pAdCwXsV3t5YDM6euVBmOQvj3G6Ngkx13CcHEDS2fnv9s898/0X6JpMtUScJ0kagqG
         EZImYNMThTlgCRHmAkxTI0zRZCU/xiO8e2490i++m724p2O2t4AuancmDFn1UvnToG
         qslIwQGICXTkA4H1MGZMk0BL95Oq2hGzPCE7rqRLGe95z/bxKTW2MML6YriuKXvSab
         99wnIhemypwnA==
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
Subject: [PATCH net-next 14/22] net: stmmac: dwmac-socfpga: use devm_stmmac_probe_config_dt()
Date:   Tue, 29 Aug 2023 18:40:25 +0800
Message-Id: <20230829104033.955-15-jszhang@kernel.org>
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

The calling of stmmac_pltfr_remove() now needs to be switched to
stmmac_pltfr_remove_no_dt().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c    | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 7db176e8691f..6d5e45fb54c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -400,21 +400,19 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	dwmac = devm_kzalloc(dev, sizeof(*dwmac), GFP_KERNEL);
-	if (!dwmac) {
-		ret = -ENOMEM;
-		goto err_remove_config_dt;
-	}
+	if (!dwmac)
+		return -ENOMEM;
 
 	dwmac->stmmac_ocp_rst = devm_reset_control_get_optional(dev, "stmmaceth-ocp");
 	if (IS_ERR(dwmac->stmmac_ocp_rst)) {
 		ret = PTR_ERR(dwmac->stmmac_ocp_rst);
 		dev_err(dev, "error getting reset control of ocp %d\n", ret);
-		goto err_remove_config_dt;
+		return ret;
 	}
 
 	reset_control_deassert(dwmac->stmmac_ocp_rst);
@@ -422,7 +420,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	ret = socfpga_dwmac_parse_data(dwmac, dev);
 	if (ret) {
 		dev_err(dev, "Unable to parse OF data\n");
-		goto err_remove_config_dt;
+		return ret;
 	}
 
 	dwmac->ops = ops;
@@ -431,7 +429,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-		goto err_remove_config_dt;
+		return ret;
 
 	ndev = platform_get_drvdata(pdev);
 	stpriv = netdev_priv(ndev);
@@ -492,8 +490,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 err_dvr_remove:
 	stmmac_dvr_remove(&pdev->dev);
-err_remove_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
 }
@@ -504,7 +500,7 @@ static void socfpga_dwmac_remove(struct platform_device *pdev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct phylink_pcs *pcs = priv->hw->lynx_pcs;
 
-	stmmac_pltfr_remove(pdev);
+	stmmac_pltfr_remove_no_dt(pdev);
 
 	lynx_pcs_destroy(pcs);
 }
-- 
2.40.1

