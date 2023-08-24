Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9904A786FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjHXMvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbjHXMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:50:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDD1CD0;
        Thu, 24 Aug 2023 05:50:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a3b66f350so4268375b3a.3;
        Thu, 24 Aug 2023 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692881456; x=1693486256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2qJ+ZrE2rzRm3KwJwNRefCH5p7DDBNIE1s+DWcekf0=;
        b=KNy3mkRfpXrDFNb4pEQ1bSCkG3nDncH/8rFKxkV8NUK5KsNcj7g+3ZxHxJlXEU0HFm
         8cqs1VASeUGmB951dZWObLPT9+xHKRVBBSnV8W+HprgDJelj1Vm4v5AxwZPkD+PvJ+ph
         2fWZVJkMi2E2vnjs+yldnt6+3YB00R7cCDvk22kJOCgWbK1D1LEow+jwnwy5Xp66gcEb
         jXqUHC8lIXfUV3Z7y7MQQs/MwNhTP91ZAtZU468XhGOqJS3nh9emQrnOoxKHFVTizZq8
         hADjVXYP5ETWedWzA0R2AuSMn7EXp6zXc+b/oVMwGH2K8smrexUrRwKW3bGdfRgU0WBW
         hhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881456; x=1693486256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2qJ+ZrE2rzRm3KwJwNRefCH5p7DDBNIE1s+DWcekf0=;
        b=fmUpht2iPrjL4yQlFnT6mshHpwWMu2UUCw/+FSq9A5ax9H9GfNdsjnVD8hjoK0exG3
         fn5XUUDMd5c8XPRR/e0hcAWD8LeYtqghB5hdAt3NuZfpDszx/GLqrV8tudJLCsaJgUWs
         fen9D03N2gTOAJon9tvGqsIyvwwFcaqZgMXfUgjPGozvjh1+X0up0R9S3bn4FtN2v5kt
         c2sZv4JlwtVLnxQtD5KQJs8j26jmqfBMpCGrT7yCbTMsshScfN+DyruMDV9aVvZ8yWCr
         RCStNHbY0V/B7y0UNSHriFgK+YwRkAkc0msyrhsW0Q/1aPBD0haseMm1Ow8wxxixNC6P
         VlMA==
X-Gm-Message-State: AOJu0YwNAd2QQhVGegM+TmhJrom+yV1B0J1k9GyEAPUGhWHrozigfWrl
        roI+S65fqEYsByKiGTNJYbgJSxWPDyOBX+TN
X-Google-Smtp-Source: AGHT+IHs+SBXK7T/NEjvUUeGBnWj2OMsKKo8fCDtKIuoqZNtLVyGBLkZCLRAMGU1VqCjyUd3KBRbKA==
X-Received: by 2002:a05:6a20:3ca7:b0:149:7a49:f7be with SMTP id b39-20020a056a203ca700b001497a49f7bemr10374697pzj.4.1692881456111;
        Thu, 24 Aug 2023 05:50:56 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001afd821c057sm12837295pli.58.2023.08.24.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:50:55 -0700 (PDT)
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
Subject: [PATCH v3 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Date:   Thu, 24 Aug 2023 20:50:11 +0800
Message-Id: <20230824125012.1040288-4-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824125012.1040288-1-keguang.zhang@gmail.com>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
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
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 240 ++++++++++++++++++
 3 files changed, 252 insertions(+)
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
index 000000000000..347d842141e4
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
@@ -0,0 +1,240 @@
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
+#define LS1X_GMAC0_BASE		(0xe10000)
+#define LS1X_GMAC1_BASE		(0xe20000)
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
+#define PHY_INTF_SELI_SHIFT	28
+
+struct ls1x_dwmac_syscon {
+	int (*syscon_init)(struct plat_stmmacenet_data *plat);
+};
+
+struct ls1x_dwmac {
+	unsigned long reg_base;
+	struct device *dev;
+	struct plat_stmmacenet_data *plat_dat;
+	const struct ls1x_dwmac_syscon *syscon;
+	struct regmap *regmap;
+};
+
+static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
+{
+	struct ls1x_dwmac *dwmac = plat->bsp_priv;
+	struct regmap *regmap = dwmac->regmap;
+
+	if ((dwmac->reg_base & LS1X_GMAC0_BASE) == LS1X_GMAC0_BASE) {
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
+			dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
+				plat->phy_interface);
+			return -EOPNOTSUPP;
+		}
+
+		regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
+	}
+
+	if ((dwmac->reg_base & LS1X_GMAC1_BASE) == LS1X_GMAC1_BASE) {
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
+			dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
+				plat->phy_interface);
+			return -EOPNOTSUPP;
+		}
+
+		regmap_update_bits(regmap, LS1X_SYSCON1, GMAC1_SHUT, 0);
+	}
+
+	return 0;
+}
+
+static int ls1c_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
+{
+	struct ls1x_dwmac *dwmac = plat->bsp_priv;
+	struct regmap *regmap = dwmac->regmap;
+
+	switch (plat->phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI, 0);
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
+				   4 << PHY_INTF_SELI_SHIFT);
+		break;
+	default:
+		dev_err(dwmac->dev, "Unsupported PHY-mode %u\n",
+			plat->phy_interface);
+		return -EOPNOTSUPP;
+	}
+
+	regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
+
+	return 0;
+}
+
+static const struct ls1x_dwmac_syscon ls1b_dwmac_syscon = {
+	.syscon_init = ls1b_dwmac_syscon_init,
+};
+
+static const struct ls1x_dwmac_syscon ls1c_dwmac_syscon = {
+	.syscon_init = ls1c_dwmac_syscon_init,
+};
+
+static int ls1x_dwmac_init(struct platform_device *pdev, void *priv)
+{
+	struct ls1x_dwmac *dwmac = priv;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Could not get IO_MEM resources\n");
+		return -EINVAL;
+	}
+	dwmac->reg_base = (unsigned long)res->start;
+
+	if (dwmac->syscon->syscon_init) {
+		ret = dwmac->syscon->syscon_init(dwmac->plat_dat);
+		if (ret)
+			return ret;
+	}
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
+	const struct ls1x_dwmac_syscon *syscon;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	/* Probe syscon */
+	regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						 "loongson,ls1-syscon");
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
+		return ret;
+	}
+
+	syscon = of_device_get_match_data(&pdev->dev);
+	if (!syscon) {
+		dev_err(&pdev->dev, "No of match data provided\n");
+		return -EINVAL;
+	}
+
+	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
+	if (!dwmac)
+		return -ENOMEM;
+
+	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat)) {
+		dev_err(&pdev->dev, "dt configuration failed\n");
+		return PTR_ERR(plat_dat);
+	}
+
+	plat_dat->bsp_priv = dwmac;
+	plat_dat->init = ls1x_dwmac_init;
+	dwmac->dev = &pdev->dev;
+	dwmac->plat_dat = plat_dat;
+	dwmac->syscon = syscon;
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
+	{ .compatible = "loongson,ls1b-gmac", .data = &ls1b_dwmac_syscon, },
+	{ .compatible = "loongson,ls1c-emac", .data = &ls1c_dwmac_syscon, },
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
+MODULE_DESCRIPTION("Loongson1 DWMAC glue layer");
+MODULE_LICENSE("GPL");
-- 
2.39.2

