Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1778DDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbjH3SxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244688AbjH3NnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:43:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929B1A3;
        Wed, 30 Aug 2023 06:43:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0bae4da38so6593425ad.0;
        Wed, 30 Aug 2023 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402987; x=1694007787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUnaYcHdg78olKUiBYZxRGGudCm0BIz7EXgTZrFFlmM=;
        b=e4cIkydFceJXrnuled5mJvSSAtXQJxVKN4TTLBi1Y9Earn1EZR/Gz6LMhB3/lhBbUG
         H7+htQEIJKU4N4TU7txdZ+CGQbC4Bx2jmo4yx6MSpezRGTHBmJpmZMPEJ16rlqdvrNw2
         BfoNKjX3lCVbL5hyNpBe5NMD0vkoSw7UFt9clhgycurnGOsVmf7PJFpJTiOy0Yr8Dy14
         zmcqOhTWGcZBT1N9Dc7yrpkK5QgA1uyY7emzzPmDmHeDvbxn11gmadWzEbHMnSezTyiC
         XttSrze0vRdg73zHAf5RdBqpFUVZeFYAHyQa/QzdMYCWg2AfdSOYvMRlyFDEdzEx3FO+
         dBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402987; x=1694007787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUnaYcHdg78olKUiBYZxRGGudCm0BIz7EXgTZrFFlmM=;
        b=CZx0+2nlPhXHrptUqk2TTNV1Lt80uPfY+/PneJCsd9qAwKnyoh9wVocoSZMdcQPdwh
         MLPR+QRi7Yw8ccB5iTdBTo3tnXO+bnUcTaXavaOtf6a6y3yaTIVHwVyEuACe2onW4HJr
         RlQDNjkTjz/gD16YBbGfwKRXyByW75qipafFnudUumlaGBjTLD7xiuG7m3mQbYTBndSK
         j6qEMVl/Q2GCtUvFhEDebWR0decJ2OtXZQzkR3HdUTunBz2RFuZu+1PslOTkOqNxIvcC
         Gz8hPlKy0YgVbYwYN7cAGnDfiYJmwrF9qu76f7LzTTr5HjXVc59p5sVEG2uT0G/3hxm/
         8//A==
X-Gm-Message-State: AOJu0YwL+wPdMyyPqxwGleYYO/2E2N3+HAjtSyHLBqoesK1+fSPmjX3w
        9LRRJYgkFsGngqAi09mcg497m8Wmi9uV3xez
X-Google-Smtp-Source: AGHT+IEtePLz1/bsMfnU+XPeeJU35uBsu0Zi8cUSQDpkzMeKQ3hkFOTDXEXNkaTTvht8/3NyxylbRQ==
X-Received: by 2002:a17:902:f0ca:b0:1bd:dbec:8673 with SMTP id v10-20020a170902f0ca00b001bddbec8673mr6987592pla.11.1693402986533;
        Wed, 30 Aug 2023 06:43:06 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001b86dd825e7sm11042280plh.108.2023.08.30.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:43:06 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v4 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Date:   Wed, 30 Aug 2023 21:42:40 +0800
Message-Id: <20230830134241.506464-4-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830134241.506464-1-keguang.zhang@gmail.com>
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This glue driver is created based on the arch-code
implemented earlier with the platform-specific settings.

Use syscon for SYSCON register access.

Partially based on the previous work by Serge Semin.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V3 -> V4: Drop ls1x_dwmac_syscon definition and its instances
          Drop three redundant fields from the ls1x_dwmac structure
          Drop the ls1x_dwmac_init() method.
          Some minor improvements
V2 -> V3: Determine the device ID by physical
          base address(suggested by Serge Semin)
          Use regmap instead of regmap fields
          Use syscon_regmap_lookup_by_phandle()
          Some minor fixes
V1 -> V2: Fix the build errors due to CONFIG_OF being unset
          Change struct reg_field definitions to const
          Rename the syscon property to "loongson,dwmac-syscon"
          Add MII PHY mode for LS1C

 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 219 ++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 06c6871f8788..a2b9e289aa36 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -239,6 +239,17 @@ config DWMAC_INTEL_PLAT
 	  the stmmac device driver. This driver is used for the Intel Keem Bay
 	  SoC.
 
+config DWMAC_LOONGSON1
+	tristate "Loongson1 GMAC support"
+	default MACH_LOONGSON32
+	depends on OF && (MACH_LOONGSON32 || COMPILE_TEST)
+	help
+	  Support for ethernet controller on Loongson1 SoC.
+
+	  This selects Loongson1 SoC glue layer support for the stmmac
+	  device driver. This driver is used for Loongson1-based boards
+	  like Loongson LS1B/LS1C.
+
 config DWMAC_TEGRA
 	tristate "NVIDIA Tegra MGBE support"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 5b57aee19267..80e598bd4255 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
 obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
 obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
 obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
+obj-$(CONFIG_DWMAC_LOONGSON1)	+= dwmac-loongson1.o
 obj-$(CONFIG_DWMAC_GENERIC)	+= dwmac-generic.o
 obj-$(CONFIG_DWMAC_IMX8)	+= dwmac-imx.o
 obj-$(CONFIG_DWMAC_TEGRA)	+= dwmac-tegra.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
new file mode 100644
index 000000000000..f1732f15ff87
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Loongson-1 DWMAC glue layer
+ *
+ * Copyright (C) 2011-2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "stmmac.h"
+#include "stmmac_platform.h"
+
+#define LS1B_GMAC0_BASE		(0x1fe10000)
+#define LS1B_GMAC1_BASE		(0x1fe20000)
+
+/* Loongson-1 SYSCON Registers */
+#define LS1X_SYSCON0		(0x0)
+#define LS1X_SYSCON1		(0x4)
+
+/* Loongson-1B SYSCON Register Bits */
+#define GMAC1_USE_UART1		BIT(4)
+#define GMAC1_USE_UART0		BIT(3)
+
+#define GMAC1_SHUT		BIT(13)
+#define GMAC0_SHUT		BIT(12)
+
+#define GMAC1_USE_TXCLK		BIT(3)
+#define GMAC0_USE_TXCLK		BIT(2)
+#define GMAC1_USE_PWM23		BIT(1)
+#define GMAC0_USE_PWM01		BIT(0)
+
+/* Loongson-1C SYSCON Register Bits */
+#define GMAC_SHUT		BIT(6)
+
+#define PHY_INTF_SELI		GENMASK(30, 28)
+#define PHY_INTF_MII		FIELD_PREP(PHY_INTF_SELI, 0)
+#define PHY_INTF_RMII		FIELD_PREP(PHY_INTF_SELI, 4)
+
+struct ls1x_dwmac {
+	struct plat_stmmacenet_data *plat_dat;
+	struct regmap *regmap;
+};
+
+static int ls1b_dwmac_syscon_init(struct platform_device *pdev, void *priv)
+{
+	struct ls1x_dwmac *dwmac = priv;
+	struct plat_stmmacenet_data *plat = dwmac->plat_dat;
+	struct regmap *regmap = dwmac->regmap;
+	struct resource *res;
+	unsigned long reg_base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Could not get IO_MEM resources\n");
+		return -EINVAL;
+	}
+	reg_base = (unsigned long)res->start;
+
+	if (reg_base == LS1B_GMAC0_BASE) {
+		switch (plat->phy_interface) {
+		case PHY_INTERFACE_MODE_RGMII_ID:
+			regmap_update_bits(regmap, LS1X_SYSCON0,
+					   GMAC0_USE_TXCLK | GMAC0_USE_PWM01,
+					   0);
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			regmap_update_bits(regmap, LS1X_SYSCON0,
+					   GMAC0_USE_TXCLK | GMAC0_USE_PWM01,
+					   GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
+			break;
+		default:
+			dev_err(&pdev->dev, "Unsupported PHY mode %u\n",
+				plat->phy_interface);
+			return -EOPNOTSUPP;
+		}
+
+		regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
+	} else if (reg_base == LS1B_GMAC1_BASE) {
+		regmap_update_bits(regmap, LS1X_SYSCON0,
+				   GMAC1_USE_UART1 | GMAC1_USE_UART0,
+				   GMAC1_USE_UART1 | GMAC1_USE_UART0);
+
+		switch (plat->phy_interface) {
+		case PHY_INTERFACE_MODE_RGMII_ID:
+			regmap_update_bits(regmap, LS1X_SYSCON1,
+					   GMAC1_USE_TXCLK | GMAC1_USE_PWM23,
+					   0);
+
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			regmap_update_bits(regmap, LS1X_SYSCON1,
+					   GMAC1_USE_TXCLK | GMAC1_USE_PWM23,
+					   GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
+			break;
+		default:
+			dev_err(&pdev->dev, "Unsupported PHY mode %u\n",
+				plat->phy_interface);
+			return -EOPNOTSUPP;
+		}
+
+		regmap_update_bits(regmap, LS1X_SYSCON1, GMAC1_SHUT, 0);
+	} else {
+		dev_err(&pdev->dev, "Invalid Ethernet MAC base address %lx",
+			reg_base);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ls1c_dwmac_syscon_init(struct platform_device *pdev, void *priv)
+{
+	struct ls1x_dwmac *dwmac = priv;
+	struct plat_stmmacenet_data *plat = dwmac->plat_dat;
+	struct regmap *regmap = dwmac->regmap;
+
+	switch (plat->phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
+				   PHY_INTF_MII);
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
+				   PHY_INTF_RMII);
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported PHY-mode %u\n",
+			plat->phy_interface);
+		return -EOPNOTSUPP;
+	}
+
+	regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
+
+	return 0;
+}
+
+static int ls1x_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct regmap *regmap;
+	struct ls1x_dwmac *dwmac;
+	int (*init)(struct platform_device *pdev, void *priv);
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	/* Probe syscon */
+	regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						 "loongson,ls1-syscon");
+	if (IS_ERR(regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
+				     "Unable to find syscon\n");
+
+	init = of_device_get_match_data(&pdev->dev);
+	if (!init) {
+		dev_err(&pdev->dev, "No of match data provided\n");
+		return -EINVAL;
+	}
+
+	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
+	if (!dwmac)
+		return -ENOMEM;
+
+	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
+				     "dt configuration failed\n");
+
+	plat_dat->bsp_priv = dwmac;
+	plat_dat->init = init;
+	dwmac->plat_dat = plat_dat;
+	dwmac->regmap = regmap;
+
+	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
+	if (ret)
+		goto err_remove_config_dt;
+
+	return 0;
+
+err_remove_config_dt:
+	stmmac_remove_config_dt(pdev, plat_dat);
+
+	return ret;
+}
+
+static const struct of_device_id ls1x_dwmac_match[] = {
+	{
+		.compatible = "loongson,ls1b-gmac",
+		.data = &ls1b_dwmac_syscon_init,
+	},
+	{
+		.compatible = "loongson,ls1c-emac",
+		.data = &ls1c_dwmac_syscon_init,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ls1x_dwmac_match);
+
+static struct platform_driver ls1x_dwmac_driver = {
+	.probe = ls1x_dwmac_probe,
+	.remove_new = stmmac_pltfr_remove,
+	.driver = {
+		.name = "loongson1-dwmac",
+		.of_match_table = ls1x_dwmac_match,
+	},
+};
+module_platform_driver(ls1x_dwmac_driver);
+
+MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson-1 DWMAC glue layer");
+MODULE_LICENSE("GPL");
-- 
2.39.2

