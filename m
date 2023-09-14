Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA847A02F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbjINLpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbjINLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:45:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5C81FCE;
        Thu, 14 Sep 2023 04:45:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c1f7f7151fso6763715ad.1;
        Thu, 14 Sep 2023 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691916; x=1695296716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZphNssh9VfwLKx98RXX0JIFD92NbTglhfoRdVrmqJ6A=;
        b=rwzcX+eAIXoteKSfYvB1F4Nb/qmGBIv7HH4JMf7REND3eybAPtmQuySmiisjtxq2Xf
         v3FBVw+Riq5j+3jC0d4wfy2k+tsZx363y27eL8Xm0Y3viEIdGWqlmauTPM66WeWi8uYQ
         6UY08yBNVjTbn5qK6kngQ1c3ek9UwfbIQA/lvAecB0tEWtU8xkBYDuGyWvrG3QbJCRlL
         atJrV5sFnqWjQzZ/8a08CJdnSOfwWCuAzYiqMgKs1ANYOf5jGuCwW4ywK+0GP1BgxYhu
         BUzF/7G8CqoTflxRwwlXUd2/1fZiWxU4Sqht0PNWq0HMRVtVj+Z5/pDkckT6Lb/iQRXa
         3BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691916; x=1695296716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZphNssh9VfwLKx98RXX0JIFD92NbTglhfoRdVrmqJ6A=;
        b=OnG4xtq0rsH6rrzRbPYiNAYw28+E02CPo5MyKuCpIqJRjrLSoSXAKAzn20cNF8UVRc
         KgBfIwOaAMEfpp2LHaklJjrEylC6AY629G3p1J60XXYf97QjjNYfMbTZpdnFHrfdl8+z
         dOhNJvQNA5Wr1l2+3YFi6xoGqz7GBIRgaUr8DGZajA02O8rJkpk9/HpnCWXFzdRLUliY
         Ix6VCWkM5k52ukbEb97R+neN/SRzRLWKaEm9kzHgbbEIKHCddWVr52GNPuCjKLACTnfe
         S6dExPH2WMqH5BdSa6xnTA4B7jtAzbbgtwJbWD/c0lg14O+kAN7u/wVc9j6J8dKr+4EY
         Qghg==
X-Gm-Message-State: AOJu0Yws1Z6kEaIyMjW5VOb8rg8uAlaAlqhxkq1qkNVB2FsiClctUN1L
        Q8D8JycfB77gSVG10YuvIrTcmAnaVkaZjg==
X-Google-Smtp-Source: AGHT+IHfMw0rZNFe3r5jeYNlPT4fh7hC9MsQALYMPCoYUOs29ISRsGOjyqOtVRh5eLmS9gUnSmS7Fw==
X-Received: by 2002:a17:903:24f:b0:1c3:5159:af00 with SMTP id j15-20020a170903024f00b001c35159af00mr6189086plh.44.1694691915626;
        Thu, 14 Sep 2023 04:45:15 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001b9cea4e8a2sm1388570pll.293.2023.09.14.04.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:45:15 -0700 (PDT)
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
Subject: [PATCH v5 3/3] net: stmmac: Add glue layer for Loongson-1 SoC
Date:   Thu, 14 Sep 2023 19:44:35 +0800
Message-Id: <20230914114435.481900-4-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914114435.481900-1-keguang.zhang@gmail.com>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This glue driver is created based on the arch-code
implemented earlier with the platform-specific settings.

Use syscon for SYSCON register access.

And modify MAINTAINERS to add a new F: entry for this driver.

Partially based on the previous work by Serge Semin.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V4 -> V5: Replace stmmac_probe_config_dt() with devm_stmmac_probe_config_dt()
          Replace stmmac_pltfr_probe() with devm_stmmac_pltfr_probe()
          Add a new F: entry for this driver.
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

 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 209 ++++++++++++++++++
 4 files changed, 222 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e514b53fb225..b71aff479a8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14383,6 +14383,7 @@ F:	Documentation/devicetree/bindings/*/loongson,ls1*.yaml
 F:	arch/mips/include/asm/mach-loongson32/
 F:	arch/mips/loongson32/
 F:	drivers/*/*loongson1*
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
 
 MIPS/LOONGSON2EF ARCHITECTURE
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
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
index 000000000000..3e86810717d3
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
@@ -0,0 +1,209 @@
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
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
+				     "dt configuration failed\n");
+
+	plat_dat->bsp_priv = dwmac;
+	plat_dat->init = init;
+	dwmac->plat_dat = plat_dat;
+	dwmac->regmap = regmap;
+
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
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

