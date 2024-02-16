Return-Path: <linux-kernel+bounces-69340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80643858796
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52731C26F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC21468FE;
	Fri, 16 Feb 2024 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/0HB01+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0DD135A74;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117351; cv=none; b=MNI0R2+Wnj9uAEgOm8UD+C46NcX9tyzy2Dh2ikRNwLppqpfjPMeIZH1HrP37JOtG7rx0VUMS/JKGHUHw2/wRaZKJw//jOf06YP2+lnXGY1iFwjeX7KV4c91a+Hk3lSLVR1hzfPKw331/iFphbS2gpfD8AySMKRoRypIWbyzHvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117351; c=relaxed/simple;
	bh=tv2Xuz6CpMKcrJjZYSehkqKc6XHdPD8PJ9seVNpS/PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffTRSd7pLe21VLKjQ0lGC92fK8q7iiIbkhRWzXiQh8/5spVFL7aqZqRcAU7tO2fss7wgvdDoo+2oat3jmh36G+32u7PZsOn+qryozKrV2EqN87z4UY9N9nltptQGFdDKFaxrsS13Wcb+8jWuIfWAQzD39q68GxsOkYn+QFPnCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/0HB01+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A48F9C43394;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708117350;
	bh=tv2Xuz6CpMKcrJjZYSehkqKc6XHdPD8PJ9seVNpS/PM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q/0HB01+As7lyU3BmbzetSKQsLo1/3c3UmBie8fMjy2is1afugW1dFWzXSEMgHb6l
	 ykVeev7bDmTsKYLIZCOK6CjbsVxPE3p9/FLlTIQ2zZhdvDh3HBie5ph2b+s9SF4WER
	 UHWaS1EmC0rekN49RrapdEhbtOCTcV9dFcK9d83kk8PVSHfiPoaEkKzVdTvzQWjcW6
	 Sj3NgsoNwkXTnUfNSQ2tiH2ys7w9UMDp4rbWMCYCtXtLP8fBpcxd/V+ysRWIItXjWJ
	 lD2QJboCYDzrVe/x7p0hGA1KYdyn/nrJuj/N5XsCCZn+GPK48oLT9ZKWv/JBK7Fajj
	 5L5wzkMdughUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A72DC48260;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 05:02:30 +0800
Subject: [PATCH v3 2/4] mmc: dw_mmc: add support for hi3798mv200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-b4-mmc-hi3798mv200-v3-2-f15464176947@outlook.com>
References: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
In-Reply-To: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708117349; l=8914;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=ZXUq4LugZ7YohpARkO8qzS8uuAtt58OsC2QWLmIjkWE=;
 b=AsQ6aCGfbnWFrgCrrTnCIuQdpgGtUjyHcVAWyPauvuEIj3ewsPkejkQcXFYFrtQNPBqgK/ORy
 2lpctIv00JJBMlQBsrOi4jCskOcssThc3sUZVVfQ3v8prPgTTKL2uWh
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Add support for Hi3798MV200 specific extension.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/host/Kconfig              |   9 ++
 drivers/mmc/host/Makefile             |   1 +
 drivers/mmc/host/dw_mmc-hi3798mv200.c | 235 ++++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 81f2c4e05287..aebc587f77a7 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -798,6 +798,15 @@ config MMC_DW_HI3798CV200
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on HiSilicon Hi3798CV200 SoC.
 
+config MMC_DW_HI3798MV200
+	tristate "Hi3798MV200 specific extensions for Synopsys DW Memory Card Interface"
+	depends on MMC_DW
+	select MMC_DW_PLTFM
+	help
+	  This selects support for HiSilicon Hi3798MV200 SoC specific extensions to the
+	  Synopsys DesignWare Memory Card Interface driver. Select this option
+	  for platforms based on HiSilicon Hi3798MV200 SoC.
+
 config MMC_DW_K3
 	tristate "K3 specific extensions for Synopsys DW Memory Card Interface"
 	depends on MMC_DW
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index d0be4465f3ec..f53f86d200ac 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_MMC_DW_PLTFM)	+= dw_mmc-pltfm.o
 obj-$(CONFIG_MMC_DW_BLUEFIELD)	+= dw_mmc-bluefield.o
 obj-$(CONFIG_MMC_DW_EXYNOS)	+= dw_mmc-exynos.o
 obj-$(CONFIG_MMC_DW_HI3798CV200) += dw_mmc-hi3798cv200.o
+obj-$(CONFIG_MMC_DW_HI3798MV200) += dw_mmc-hi3798mv200.o
 obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
new file mode 100644
index 000000000000..b7d1d1a31a3f
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Modified from dw_mmc-hi3798cv200.c
+ *
+ * Copyright (c) 2024 Yang Xiwen <forbidden405@outlook.com>
+ * Copyright (c) 2018 HiSilicon Technologies Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mmc/host.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "dw_mmc.h"
+#include "dw_mmc-pltfm.h"
+
+#define SDMMC_TUNING_CTRL	0x118
+#define SDMMC_TUNING_FIND_EDGE	BIT(5)
+
+#define ALL_INT_CLR		0x1ffff
+
+/* DLL ctrl reg */
+#define SAP_DLL_CTRL_DLLMODE	BIT(16)
+
+struct dw_mci_hi3798mv200_priv {
+	struct clk *sample_clk;
+	struct clk *drive_clk;
+	struct regmap *sap_dll_reg;
+	struct mmc_clk_phase_map phase_map;
+};
+
+static void dw_mci_hi3798mv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+{
+	struct dw_mci_hi3798mv200_priv *priv = host->priv;
+	struct mmc_clk_phase phase = priv->phase_map.phase[ios->timing];
+	u32 val;
+
+	val = mci_readl(host, ENABLE_SHIFT);
+	if (ios->timing == MMC_TIMING_MMC_DDR52
+	    || ios->timing == MMC_TIMING_UHS_DDR50)
+		val |= SDMMC_ENABLE_PHASE;
+	else
+		val &= ~SDMMC_ENABLE_PHASE;
+	mci_writel(host, ENABLE_SHIFT, val);
+
+	val = mci_readl(host, DDR_REG);
+	if (ios->timing == MMC_TIMING_MMC_HS400)
+		val |= SDMMC_DDR_HS400;
+	else
+		val &= ~SDMMC_DDR_HS400;
+	mci_writel(host, DDR_REG, val);
+
+	if (clk_set_rate(host->ciu_clk, ios->clock))
+		dev_warn(host->dev, "Failed to set rate to %u\n", ios->clock);
+	else
+		// CLK_MUX_ROUND_NEAREST is enabled for this clock
+		// The actual clock rate is not what we setted, but a rounded value
+		// so we should get the rate once again
+		host->bus_hz = clk_get_rate(host->ciu_clk);
+
+	if (phase.valid) {
+		clk_set_phase(priv->drive_clk, phase.out_deg);
+		clk_set_phase(priv->sample_clk, phase.in_deg);
+	} else {
+		dev_warn(host->dev,
+			 "The phase entry for timing mode %d is missing in device tree.\n",
+			 ios->timing);
+	}
+}
+
+static inline int dw_mci_hi3798mv200_enable_tuning(struct dw_mci_slot *slot)
+{
+	struct dw_mci_hi3798mv200_priv *priv = slot->host->priv;
+	struct regmap *dll_reg = priv->sap_dll_reg;
+
+	return regmap_clear_bits(dll_reg, 0, SAP_DLL_CTRL_DLLMODE);
+}
+
+static inline int dw_mci_hi3798mv200_disable_tuning(struct dw_mci_slot *slot)
+{
+	struct dw_mci_hi3798mv200_priv *priv = slot->host->priv;
+	struct regmap *dll_reg = priv->sap_dll_reg;
+
+	return regmap_set_bits(dll_reg, 0, SAP_DLL_CTRL_DLLMODE);
+}
+
+static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
+					     u32 opcode)
+{
+	static const int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
+	struct dw_mci *host = slot->host;
+	struct dw_mci_hi3798mv200_priv *priv = host->priv;
+	int raise_point = -1, fall_point = -1;
+	int err, prev_err = -1;
+	int found = 0;
+	int regval;
+	int i;
+	int ret;
+
+	// enable tuning
+	ret = dw_mci_hi3798mv200_enable_tuning(slot);
+	if (ret < 0)
+		return ret;
+	for (i = 0; i < ARRAY_SIZE(degrees); i++) {
+		clk_set_phase(priv->sample_clk, degrees[i]);
+		mci_writel(host, RINTSTS, ALL_INT_CLR);
+
+		err = mmc_send_tuning(slot->mmc, opcode, NULL);
+		if (!err) {
+			regval = mci_readl(host, TUNING_CTRL);
+			if (regval & SDMMC_TUNING_FIND_EDGE)
+				err = 1;
+			else
+				found = 1;
+		};
+
+		if (i > 0) {
+			if (err && !prev_err)
+				fall_point = i - 1;
+			if (!err && prev_err)
+				raise_point = i;
+		}
+
+		if (raise_point != -1 && fall_point != -1)
+			goto tuning_out;
+
+		prev_err = err;
+		err = 0;
+	}
+
+tuning_out:
+	ret = dw_mci_hi3798mv200_disable_tuning(slot);
+	if (ret < 0)
+		return ret;
+	if (found) {
+		if (raise_point == -1)
+			raise_point = 0;
+		if (fall_point == -1)
+			fall_point = ARRAY_SIZE(degrees) - 1;
+		if (fall_point < raise_point) {
+			if ((raise_point + fall_point) >
+			    (ARRAY_SIZE(degrees) - 1))
+				i = fall_point / 2;
+			else
+				i = (raise_point + ARRAY_SIZE(degrees) - 1) / 2;
+		} else {
+			i = (raise_point + fall_point) / 2;
+		}
+
+		// use the same phase table for both HS200 and HS400
+		priv->phase_map.phase[MMC_TIMING_MMC_HS200].in_deg = degrees[i];
+		priv->phase_map.phase[MMC_TIMING_MMC_HS400].in_deg = degrees[i];
+
+		clk_set_phase(priv->sample_clk, degrees[i]);
+		dev_dbg(host->dev, "Tuning clk_sample[%d, %d], set[%d]\n",
+			raise_point, fall_point, degrees[i]);
+		err = 0;
+	} else {
+		dev_err(host->dev, "No valid clk_sample shift! use default\n");
+		err = -EINVAL;
+	}
+
+	mci_writel(host, RINTSTS, ALL_INT_CLR);
+	return err;
+}
+
+static int dw_mci_hi3798mv200_init(struct dw_mci *host)
+{
+	struct dw_mci_hi3798mv200_priv *priv;
+	struct device_node *np = host->dev->of_node;
+
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
+
+	priv->sample_clk = devm_clk_get_enabled(host->dev, "ciu-sample");
+	if (IS_ERR(priv->sample_clk))
+		return dev_err_probe(host->dev, PTR_ERR(priv->sample_clk),
+				     "failed to get enabled ciu-sample clock\n");
+
+	priv->drive_clk = devm_clk_get_enabled(host->dev, "ciu-drive");
+	if (IS_ERR(priv->drive_clk))
+		return dev_err_probe(host->dev, PTR_ERR(priv->drive_clk),
+				     "failed to get enabled ciu-drive clock\n");
+
+	priv->sap_dll_reg = syscon_regmap_lookup_by_phandle(np, "hisilicon,sap-dll-reg");
+	if (IS_ERR(priv->sap_dll_reg))
+		return dev_err_probe(host->dev, PTR_ERR(priv->sap_dll_reg),
+				     "failed to get sap-dll-reg\n");
+
+	host->priv = priv;
+	return 0;
+}
+
+static const struct dw_mci_drv_data hi3798mv200_data = {
+	.common_caps = MMC_CAP_CMD23,
+	.init = dw_mci_hi3798mv200_init,
+	.set_ios = dw_mci_hi3798mv200_set_ios,
+	.execute_tuning = dw_mci_hi3798mv200_execute_tuning_mix_mode,
+};
+
+static const struct of_device_id dw_mci_hi3798mv200_match[] = {
+	{ .compatible = "hisilicon,hi3798mv200-dw-mshc" },
+	{},
+};
+
+static int dw_mci_hi3798mv200_probe(struct platform_device *pdev)
+{
+	return dw_mci_pltfm_register(pdev, &hi3798mv200_data);
+}
+
+static void dw_mci_hi3798mv200_remove(struct platform_device *pdev)
+{
+	dw_mci_pltfm_remove(pdev);
+}
+
+MODULE_DEVICE_TABLE(of, dw_mci_hi3798mv200_match);
+static struct platform_driver dw_mci_hi3798mv200_driver = {
+	.probe = dw_mci_hi3798mv200_probe,
+	.remove_new = dw_mci_hi3798mv200_remove,
+	.driver = {
+		.name = "dwmmc_hi3798mv200",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = dw_mci_hi3798mv200_match,
+	},
+};
+module_platform_driver(dw_mci_hi3798mv200_driver);
+
+MODULE_DESCRIPTION("HiSilicon Hi3798MV200 Specific DW-MSHC Driver Extension");
+MODULE_LICENSE("GPL");

-- 
2.43.0


