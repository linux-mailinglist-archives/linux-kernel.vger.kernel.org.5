Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF2778C2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjH2K4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjH2Kz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:55:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E933CE3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91890654AF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400AFC43397;
        Tue, 29 Aug 2023 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306471;
        bh=eOQEQqB/E1U1BFvNbWI5sTlMMYgIROpRNWJpNfEu8kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrpSCfxFAulKCGLD3TfFY01Fe8S7TYz2nQ1geT6dB+adsDb40Y/ZLjMh4TwJ3VE9Q
         kH5jm6ccuqxqTUtIczCO+l+A1H4YhA4OUrf0t3bHFQxGnpHU/puCMobbwCh8lD83Je
         QlRxdqd7nhjJPTNXHzznxD7+U8oEgnx1/+wfjECvNY4rwnx0G56oY1OH6jwOtjA06w
         A9RFeyLBvDXeqsL+eab/HvGM4jHZORZ0iCvcaEYESLcJTbbih79RbX1DdIgexRcNnf
         xOebA38s2ixp3Q/Qu5Zo14fjO4tG4rqtpDYfmywiiwN8LXODvnMThbbj4jEMJjw7yT
         uYtjzZ602eq6A==
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
Subject: [PATCH net-next 18/22] net: stmmac: dwmac-sun8i: use devm_stmmac_probe_config_dt()
Date:   Tue, 29 Aug 2023 18:40:29 +0800
Message-Id: <20230829104033.955-19-jszhang@kernel.org>
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

The calling of stmmac_pltfr_remove() now needs to be switched to
stmmac_pltfr_remove_no_dt().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index c23420863a8d..bfe49b5a9929 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1224,7 +1224,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return -EINVAL;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
@@ -1244,7 +1244,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 
 	ret = sun8i_dwmac_set_syscon(&pdev->dev, plat_dat);
 	if (ret)
-		goto dwmac_deconfig;
+		return ret;
 
 	ret = sun8i_dwmac_init(pdev, plat_dat->bsp_priv);
 	if (ret)
@@ -1295,8 +1295,6 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	sun8i_dwmac_exit(pdev, gmac);
 dwmac_syscon:
 	sun8i_dwmac_unset_syscon(gmac);
-dwmac_deconfig:
-	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
 }
@@ -1314,7 +1312,7 @@ static void sun8i_dwmac_remove(struct platform_device *pdev)
 		clk_put(gmac->ephy_clk);
 	}
 
-	stmmac_pltfr_remove(pdev);
+	stmmac_pltfr_remove_no_dt(pdev);
 	sun8i_dwmac_unset_syscon(gmac);
 }
 
-- 
2.40.1

