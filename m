Return-Path: <linux-kernel+bounces-40550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A1583E24E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0FA1C21E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3053422F0E;
	Fri, 26 Jan 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="apl6MWSi"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FB225CF;
	Fri, 26 Jan 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296407; cv=none; b=UY8jb12Vc6gstWXiUBsuxVF/szsKjo2+igMKb9Bhx5i4cyNRanX30xLkBfVXi2ZSmHbFyV4hRlKB/30gX+EH2dC94FVpR4XCB1quUHnM6AlL0+ndhWsS/tzyoYDXT7ZE5MDtoWSwAYZdpaP5biOGyp84KFKmzK6ru0lDUDtREGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296407; c=relaxed/simple;
	bh=WQe4wDwRNT0S65UeCvFunjCWa8R+Rf3G+Co3wYKG0EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUzIzSpXWEXnO7sAhGYhY5GmGFtnmDi7qNeOUi6wAAX85WCFo+ynO2Q+od3J6ykzsoZbb96iTZgU8CSnqpP2pckTBKrTdVBMLUAwTgEhnV6Onc3zZLYhJdObEJ7AvS9IFr8qXdOhPkY+37oeHdCLuR9PQgSYBpJ+sKsvDD15T68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=apl6MWSi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706296403;
	bh=WQe4wDwRNT0S65UeCvFunjCWa8R+Rf3G+Co3wYKG0EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apl6MWSi1VseoqQT1RQLbEFcA2AO7SynigxLKgFfP70pKA/38d3WHqbU1lgkb9HJx
	 hZHVcd5cf29ZpsqWNacchol/KkRuc2ceQ/MbXIFQ1DF/Jv+vHbD+MZammIb/iqa1ov
	 jUEzbiFqnqWGNMGsCpbGnijJ4EblMWH65owpKGKaGn5MXKjJGjo61mU+kvqd/VQNnG
	 oXigXZqmZlHrqk18enh5yGEOv+S9DJr/BIxJ+VQhoTdUPwshw3wDLQFjoyhys4V7v7
	 K2ExBksFBY5+3v3qqMAmqOxqb+zl+3v1ZjbeQ00a44sHR8hZnpDXj4JTgQyewgDn7G
	 uiYsSV9iumIDw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6F19B3782076;
	Fri, 26 Jan 2024 19:13:23 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v4 2/2] net: stmmac: dwmac-starfive: Add support for JH7100 SoC
Date: Fri, 26 Jan 2024 21:13:17 +0200
Message-ID: <20240126191319.1209821-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
References: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing quirk to enable support for the StarFive JH7100 SoC.

Additionally, for greater flexibility in operation, allow using the
rgmii-rxid and rgmii-txid phy modes.

Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 ++--
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 32 ++++++++++++++++---
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 85dcda51df05..4ec61f1ee71a 100644
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
index 5d630affb4d1..4e1076faee0c 100644
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
+	.gtxclk_dlychain = 4,
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
2.43.0


