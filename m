Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47278C2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjH2Kx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjH2KxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2AA98
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DFCF6545C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC1C433CA;
        Tue, 29 Aug 2023 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306381;
        bh=NfmMNorB1i8iTRlNbscAGy8iJ8mMIBVk/gLt8TbXCus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0Yd+txvCUqerxhQdKMHb0eC2/pdb1ARG/YXEdJxh7lPhf7WSIVfH/mp/FDnBT6H5
         3vrpRt+lp8auapOTcS95cLi7kV8gW1zDrMoDnq7LKMtCblNlYgzC6JYhFrcL7M0Z1X
         FPNa5ip4SNX4pq8V+phSXRpOSQE0BQJcXC7tg67+bTDJ8sNVX7ORo8M0ceLgrcN6Jv
         Qmpr8sCk7f0/EIWqMpxfqcOlmveBkIA/NroYgYLIW0OLr1R/kPs/NP+wKpdngBHxoT
         /HzsbhEV+JciUgc/9tRr731hXBrarWO9LIyYV+QiRDIDue+629780wOpQqzpRlWvAM
         O1m+B6wPVY1og==
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
Subject: [PATCH net-next 05/22] net: stmmac: dwmac-imx: use devm_stmmac_probe_config_dt()
Date:   Tue, 29 Aug 2023 18:40:16 +0800
Message-Id: <20230829104033.955-6-jszhang@kernel.org>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 535856fffaea..f4c817e9fc13 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -331,15 +331,14 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (!dwmac)
 		return -ENOMEM;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
 	data = of_device_get_match_data(&pdev->dev);
 	if (!data) {
 		dev_err(&pdev->dev, "failed to get match data\n");
-		ret = -EINVAL;
-		goto err_match_data;
+		return -EINVAL;
 	}
 
 	dwmac->ops = data;
@@ -348,7 +347,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	ret = imx_dwmac_parse_dt(dwmac, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to parse OF data\n");
-		goto err_parse_dt;
+		return ret;
 	}
 
 	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
@@ -365,7 +364,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 
 	ret = imx_dwmac_clks_config(dwmac, true);
 	if (ret)
-		goto err_clks_config;
+		return ret;
 
 	ret = imx_dwmac_init(pdev, dwmac);
 	if (ret)
@@ -385,10 +384,6 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	imx_dwmac_exit(pdev, plat_dat->bsp_priv);
 err_dwmac_init:
 	imx_dwmac_clks_config(dwmac, false);
-err_clks_config:
-err_parse_dt:
-err_match_data:
-	stmmac_remove_config_dt(pdev, plat_dat);
 	return ret;
 }
 
@@ -423,7 +418,7 @@ MODULE_DEVICE_TABLE(of, imx_dwmac_match);
 
 static struct platform_driver imx_dwmac_driver = {
 	.probe  = imx_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "imx-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.40.1

