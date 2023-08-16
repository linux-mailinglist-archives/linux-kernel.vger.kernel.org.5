Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B377E01A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbjHPLOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244246AbjHPLNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:13:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EA7E40;
        Wed, 16 Aug 2023 04:13:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-688731c6331so953042b3a.3;
        Wed, 16 Aug 2023 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692184432; x=1692789232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVAVZqZU+ixEqVLc2U4TIfPo7I2gstSbnX2bMIICFOA=;
        b=MJX42uUBtLEDpWOaYdmcRrcKtekazaAxTtW8hvhtj/5bktlsXDGd2bygjpo6YyO1id
         EA1jDjyUv0Y222az7JseaeTmfZVOw7qlrq1qXF0S2e22TOIeu9L+Cb+he8YGm02TLOLN
         1WEjm6sQFylEtcB+aw4sZGaYqAhKCdFTlU/IlXPxehZIv8GJdj/5f0E7OCvLsVQbTbjF
         LIGspJgPhsUl1YM3cZgXVRjzW1VrvRquTGp8Z73IQiPj40evIwkR8izZkk7biMOxM0HZ
         jbE7p5SxHjMzpAQjkK9FaOcxGAtAg7TfveSqWfd3oWt/+BKkauQxAj1BD/AoGCW09YFn
         PRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692184432; x=1692789232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVAVZqZU+ixEqVLc2U4TIfPo7I2gstSbnX2bMIICFOA=;
        b=eeJmEivZOHfhKo1Cppb/ZbjrTaDiG98Z7p5C+QHRoZffGESnLqVrFvfehPmESNCwGq
         agOqMHMO6MyzqC94sFgu0rG9urmfqhB5lVJiar9VmdiWH3OoK7Atl8MPGq0luFLNKkup
         lR8w2gmAcxd8rFWgG80jOUjFg8z7z0FineBUHE/tj5Be/bHok+wzBEKWe+SfWun0Eo3G
         +lN8JYzzO3nrMx8VMVlTjawnN9qhc6fe/d37BqJDcq32NAEkw4bLfkSdq89OHZgrPSKE
         KL8U9nclBtTRtqfV7p8xyplBGDQ6M1sr6GSDv07nldbGrk0/dWjWgPTveSbqzrNab7jK
         eHJA==
X-Gm-Message-State: AOJu0YyRTZv7bl2Gq9vAJVFQr5oDAMqMBxkvdnmTNAGgYyYmFI86XWbi
        LRXAwE3VuHLcc5G2Y9r8KVznXzCDNhHJu57A
X-Google-Smtp-Source: AGHT+IH9W4jI1YnO45ckBT5E8EObv1ZcB0foiNpGMzIIAlBbfSNvmL7lfW1ADK41O5+fpTfHxOkPvw==
X-Received: by 2002:a05:6a20:8421:b0:141:d54e:a908 with SMTP id c33-20020a056a20842100b00141d54ea908mr1933849pzd.41.1692184431662;
        Wed, 16 Aug 2023 04:13:51 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id r8-20020a638f48000000b00563e1ef0491sm11750627pgn.8.2023.08.16.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:13:51 -0700 (PDT)
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
Subject: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Date:   Wed, 16 Aug 2023 19:13:09 +0800
Message-Id: <20230816111310.1656224-4-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816111310.1656224-1-keguang.zhang@gmail.com>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This glue driver is created based on the arch-code
implemented earlier with the platform-specific settings.

Use syscon for SYSCON register access.

Partialy based on the previous work by Serge Semin.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Fix the build errors due to CONFIG_OF being unset
          Change struct reg_field definitions to const
          Rename the syscon property to "loongson,dwmac-syscon"
          Add MII PHY mode for LS1C

 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 273 ++++++++++++++++++
 3 files changed, 285 insertions(+)
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
index 000000000000..5210b5e8ae47
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
@@ -0,0 +1,273 @@
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
+/* Loongson-1 SYSCON Registers */
+#define LS1X_SYSCON0		(0x0)
+#define LS1X_SYSCON1		(0x4)
+
+struct ls1x_dwmac_syscon {
+	const struct reg_field *reg_fields;
+	unsigned int nr_reg_fields;
+	int (*syscon_init)(struct plat_stmmacenet_data *plat);
+};
+
+struct ls1x_dwmac {
+	struct device *dev;
+	struct plat_stmmacenet_data *plat_dat;
+	const struct ls1x_dwmac_syscon *syscon;
+	struct regmap *regmap;
+	struct regmap_field *regmap_fields[];
+};
+
+enum ls1b_dwmac_syscon_regfield {
+	GMAC1_USE_UART1,
+	GMAC1_USE_UART0,
+	GMAC1_SHUT,
+	GMAC0_SHUT,
+	GMAC1_USE_TXCLK,
+	GMAC0_USE_TXCLK,
+	GMAC1_USE_PWM23,
+	GMAC0_USE_PWM01,
+};
+
+enum ls1c_dwmac_syscon_regfield {
+	GMAC_SHUT,
+	PHY_INTF_SELI,
+};
+
+static const struct reg_field ls1b_dwmac_syscon_regfields[] = {
+	[GMAC1_USE_UART1]	= REG_FIELD(LS1X_SYSCON0, 4, 4),
+	[GMAC1_USE_UART0]	= REG_FIELD(LS1X_SYSCON0, 3, 3),
+	[GMAC1_SHUT]		= REG_FIELD(LS1X_SYSCON1, 13, 13),
+	[GMAC0_SHUT]		= REG_FIELD(LS1X_SYSCON1, 12, 12),
+	[GMAC1_USE_TXCLK]	= REG_FIELD(LS1X_SYSCON1, 3, 3),
+	[GMAC0_USE_TXCLK]	= REG_FIELD(LS1X_SYSCON1, 2, 2),
+	[GMAC1_USE_PWM23]	= REG_FIELD(LS1X_SYSCON1, 1, 1),
+	[GMAC0_USE_PWM01]	= REG_FIELD(LS1X_SYSCON1, 0, 0)
+};
+
+static const struct reg_field ls1c_dwmac_syscon_regfields[] = {
+	[GMAC_SHUT]		= REG_FIELD(LS1X_SYSCON0, 6, 6),
+	[PHY_INTF_SELI]		= REG_FIELD(LS1X_SYSCON1, 28, 30)
+};
+
+static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
+{
+	struct ls1x_dwmac *dwmac = plat->bsp_priv;
+	struct regmap_field **regmap_fields = dwmac->regmap_fields;
+
+	if (plat->bus_id) {
+		regmap_field_write(regmap_fields[GMAC1_USE_UART1], 1);
+		regmap_field_write(regmap_fields[GMAC1_USE_UART0], 1);
+
+		switch (plat->phy_interface) {
+		case PHY_INTERFACE_MODE_RGMII:
+			regmap_field_write(regmap_fields[GMAC1_USE_TXCLK], 0);
+			regmap_field_write(regmap_fields[GMAC1_USE_PWM23], 0);
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			regmap_field_write(regmap_fields[GMAC1_USE_TXCLK], 1);
+			regmap_field_write(regmap_fields[GMAC1_USE_PWM23], 1);
+			break;
+		default:
+			dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
+				plat->phy_interface);
+			return -EOPNOTSUPP;
+		}
+
+		regmap_field_write(regmap_fields[GMAC1_SHUT], 0);
+	} else {
+		switch (plat->phy_interface) {
+		case PHY_INTERFACE_MODE_RGMII:
+			regmap_field_write(regmap_fields[GMAC0_USE_TXCLK], 0);
+			regmap_field_write(regmap_fields[GMAC0_USE_PWM01], 0);
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			regmap_field_write(regmap_fields[GMAC0_USE_TXCLK], 1);
+			regmap_field_write(regmap_fields[GMAC0_USE_PWM01], 1);
+			break;
+		default:
+			dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
+				plat->phy_interface);
+			return -EOPNOTSUPP;
+		}
+
+		regmap_field_write(regmap_fields[GMAC0_SHUT], 0);
+	}
+
+	return 0;
+}
+
+static int ls1c_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
+{
+	struct ls1x_dwmac *dwmac = plat->bsp_priv;
+	struct regmap_field **regmap_fields = dwmac->regmap_fields;
+
+	switch (plat->phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		regmap_field_write(regmap_fields[PHY_INTF_SELI], 0);
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		regmap_field_write(regmap_fields[PHY_INTF_SELI], 4);
+		break;
+	default:
+		dev_err(dwmac->dev, "Unsupported PHY-mode %u\n",
+			plat->phy_interface);
+		return -EOPNOTSUPP;
+	}
+
+	regmap_field_write(regmap_fields[GMAC_SHUT], 0);
+
+	return 0;
+}
+
+static const struct ls1x_dwmac_syscon ls1b_dwmac_syscon = {
+	.reg_fields = ls1b_dwmac_syscon_regfields,
+	.nr_reg_fields = ARRAY_SIZE(ls1b_dwmac_syscon_regfields),
+	.syscon_init = ls1b_dwmac_syscon_init,
+};
+
+static const struct ls1x_dwmac_syscon ls1c_dwmac_syscon = {
+	.reg_fields = ls1c_dwmac_syscon_regfields,
+	.nr_reg_fields = ARRAY_SIZE(ls1c_dwmac_syscon_regfields),
+	.syscon_init = ls1c_dwmac_syscon_init,
+};
+
+static int ls1x_dwmac_init(struct platform_device *pdev, void *priv)
+{
+	struct ls1x_dwmac *dwmac = priv;
+	int ret;
+
+	ret = devm_regmap_field_bulk_alloc(dwmac->dev, dwmac->regmap,
+					   dwmac->regmap_fields,
+					   dwmac->syscon->reg_fields,
+					   dwmac->syscon->nr_reg_fields);
+	if (ret)
+		return ret;
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
+static const struct of_device_id ls1x_dwmac_syscon_match[] = {
+	{
+		.compatible = "loongson,ls1b-dwmac-syscon",
+		.data = &ls1b_dwmac_syscon,
+	},
+	{
+		.compatible = "loongson,ls1c-dwmac-syscon",
+		.data = &ls1c_dwmac_syscon,
+	},
+	{ }
+};
+
+static int ls1x_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct device_node *syscon_np;
+	const struct of_device_id *match;
+	struct regmap *regmap;
+	struct ls1x_dwmac *dwmac;
+	const struct ls1x_dwmac_syscon *syscon;
+	size_t size;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	/* Probe syscon */
+	syscon_np =
+	    of_parse_phandle(pdev->dev.of_node, "loongson,dwmac-syscon", 0);
+	if (!syscon_np) {
+		dev_err(&pdev->dev, "missing loongson,dwmac-syscon property\n");
+		return -ENODEV;
+	}
+
+	match = of_match_node(ls1x_dwmac_syscon_match, syscon_np);
+	if (!match) {
+		dev_err(&pdev->dev, "no matching node found in dtb\n");
+		of_node_put(syscon_np);
+		return -EINVAL;
+	}
+	syscon = (const struct ls1x_dwmac_syscon *)match->data;
+
+	regmap = syscon_node_to_regmap(syscon_np);
+	of_node_put(syscon_np);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
+		return ret;
+	}
+
+	size = syscon->nr_reg_fields * sizeof(struct regmap_field *);
+	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac) + size, GFP_KERNEL);
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
+	if (pdev->dev.of_node)
+		stmmac_remove_config_dt(pdev, plat_dat);
+
+	return ret;
+}
+
+static const struct of_device_id ls1x_dwmac_match[] = {
+	{ .compatible = "loongson,ls1b-dwmac" },
+	{ .compatible = "loongson,ls1c-dwmac" },
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

