Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE67DAABF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 05:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjJ2E1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 00:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjJ2E1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 00:27:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA8CC;
        Sat, 28 Oct 2023 21:27:35 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C16796607385;
        Sun, 29 Oct 2023 04:27:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698553653;
        bh=rQEEY6dQh5x1XU/k0bkvaMxbU5A9Ka+KlBHywJ6TdZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ply1YYfpowSWtHZbXt0ZnAxukmin99chjF272ojHa0/L8dD4MgwT8yDf3dX5K0kH7
         N3qheSFgI2+Na+BqE5ZPpFRj6DsYlmMgAw2ya2cl/vVMRYIBAgt0xG/J+EUyVSIyiq
         MHvqlJ79Hdy061OWUwAi2apEw/xePCHFtUJr6AgNclKW40CsbaR3bQKVG+x2MoF7Dy
         DsgtRJ84r+PAtfm/vxu2KtRmDXgEOEVOeY0kdp0HCH3WOAoNKlmFaGjtayHxc88GBW
         J4D3DP56T1NEpd9rfPxsYKjXw9qxOjXgEL9+Tnos5kBCwN/2V0M7glqryd5IscL55+
         seI9heDfUmE8A==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 05/12] net: stmmac: dwmac-starfive: Add support for JH7100 SoC
Date:   Sun, 29 Oct 2023 06:27:05 +0200
Message-ID: <20231029042712.520010-6-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing quirk to enable support for the StarFive JH7100 SoC.

Additionally, for greater flexibility in operation, allow using the
rgmii-rxid and rgmii-txid phy modes.

Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 ++--
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 32 ++++++++++++++++---
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index a2b9e289aa36..c3c2c8360047 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -165,9 +165,9 @@ config DWMAC_STARFIVE
 	help
 	  Support for ethernet controllers on StarFive RISC-V SoCs
 
-	  This selects the StarFive platform specific glue layer support for
-	  the stmmac device driver. This driver is used for StarFive JH7110
-	  ethernet controller.
+	  This selects the StarFive platform specific glue layer support
+	  for the stmmac device driver. This driver is used for the
+	  StarFive JH7100 and JH7110 ethernet controllers.
 
 config DWMAC_STI
 	tristate "STi GMAC support"
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 5d630affb4d1..88c431edcea0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -15,13 +15,20 @@
 
 #include "stmmac_platform.h"
 
-#define STARFIVE_DWMAC_PHY_INFT_RGMII	0x1
-#define STARFIVE_DWMAC_PHY_INFT_RMII	0x4
-#define STARFIVE_DWMAC_PHY_INFT_FIELD	0x7U
+#define STARFIVE_DWMAC_PHY_INFT_RGMII		0x1
+#define STARFIVE_DWMAC_PHY_INFT_RMII		0x4
+#define STARFIVE_DWMAC_PHY_INFT_FIELD		0x7U
+
+#define JH7100_SYSMAIN_REGISTER49_DLYCHAIN	0xc8
+
+struct starfive_dwmac_data {
+	unsigned int gtxclk_dlychain;
+};
 
 struct starfive_dwmac {
 	struct device *dev;
 	struct clk *clk_tx;
+	const struct starfive_dwmac_data *data;
 };
 
 static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
@@ -67,6 +74,8 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
 		mode = STARFIVE_DWMAC_PHY_INFT_RGMII;
 		break;
 
@@ -89,6 +98,14 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	if (err)
 		return dev_err_probe(dwmac->dev, err, "error setting phy mode\n");
 
+	if (dwmac->data) {
+		err = regmap_write(regmap, JH7100_SYSMAIN_REGISTER49_DLYCHAIN,
+				   dwmac->data->gtxclk_dlychain);
+		if (err)
+			return dev_err_probe(dwmac->dev, err,
+					     "error selecting gtxclk delay chain\n");
+	}
+
 	return 0;
 }
 
@@ -114,6 +131,8 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 	if (!dwmac)
 		return -ENOMEM;
 
+	dwmac->data = device_get_match_data(&pdev->dev);
+
 	dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
 	if (IS_ERR(dwmac->clk_tx))
 		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
@@ -144,8 +163,13 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
 
+static const struct starfive_dwmac_data jh7100_data = {
+	.gtxclk_dlychain = 4
+};
+
 static const struct of_device_id starfive_dwmac_match[] = {
-	{ .compatible = "starfive,jh7110-dwmac"	},
+	{ .compatible = "starfive,jh7100-dwmac", .data = &jh7100_data },
+	{ .compatible = "starfive,jh7110-dwmac" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
-- 
2.42.0

