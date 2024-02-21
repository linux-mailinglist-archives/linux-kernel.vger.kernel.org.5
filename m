Return-Path: <linux-kernel+bounces-74716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B831F85D82B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3B71C21FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3132D69DF9;
	Wed, 21 Feb 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKzdxqBn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019469319;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519547; cv=none; b=mUqvWfNzopMonhU/7RMMWIC8vLUjSMbfB1+Vv/aRIXNlnMpg903iCEAt8YfLshb3jyJso2KjooDxTHY0l734UW4lxIUhvYhIKqFAZY1FpNzu7RUE4sI+ELeafjELuofvtxdeTdP/7oTt47/XUrOMYE3KZaNexSF2EG9Bv/dnD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519547; c=relaxed/simple;
	bh=u4vpXIR6YpFDOXxvm1QRh4p+LNt6YmfgCM1kdJlQxAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hiqfDOP+P4t6bSgACUnDdhzPufaQTxvH469R8jWtsfXUXFqerVvwExRVfdButt2kzfQmKhRKh5x79FfRDUZh9s7fZZoitCA8+n3Hf5t9SnKu0NUJYy6Eo2E3lqECKyU/WrFBhYKMloFL9Um0qLse5SjuaCtCmVrxkT5ptJZ/I30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKzdxqBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5BC6C433B2;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519546;
	bh=u4vpXIR6YpFDOXxvm1QRh4p+LNt6YmfgCM1kdJlQxAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KKzdxqBnGtbniHN4670+G+tsomcpye0kFKBTdrDEcocqmAOhYBrpilqk21mQ7//So
	 Tf2zUBLvEgRBL7/XIUhUJC3B6Bf5AfqXAbG8QxXDgw0io1zdT0dse9TEwBZnd3IrGa
	 kvgVKVTsdpGjn3I1VRAau0yU/OckCGw1hCZ7DSrEIMDgrke+/8wNY9blPULWrfauek
	 8fg78qZQBb8hkYg2T9s1inE2ex8GNrFcRuC97gT/5XwXiPndHVCyRa5tyFVhmoK3v3
	 zzEWRYDobeZkh/NssyWo9BvpWqDdstpjtC86qLCUfz3jfK7M7mASyD74WXGhSCpJZK
	 PJIj4Zpf5zo4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6FDC5478A;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 21 Feb 2024 20:45:05 +0800
Subject: [PATCH v6 3/5] mmc: dw_mmc: add support for hi3798mv200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-b4-mmc-hi3798mv200-v6-3-bc41bf6a9769@outlook.com>
References: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
In-Reply-To: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708519512; l=9080;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=VWClb6vzYk02WnyIr07Zo0x0wPmet1IIxC7XxdXuqqw=;
 b=npLWqA6ijjFBXG9IQiTQlbpfqa/5k6A0F7gkTEyahZEaaPqQLcSZBis1jAMGGeo2Y6TdNluPs
 Vl+rs2ugndZDaZEVlCSlpbnBvm6Rjvg+lnqy1mEerWyY4crYPUythV7
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
 drivers/mmc/host/dw_mmc-hi3798mv200.c | 239 ++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)

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
index 000000000000..73aaa21040ea
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
@@ -0,0 +1,239 @@
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
+	struct regmap *crg_reg;
+	u32 sap_dll_offset;
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
+
+	return regmap_clear_bits(priv->crg_reg, priv->sap_dll_offset, SAP_DLL_CTRL_DLLMODE);
+}
+
+static inline int dw_mci_hi3798mv200_disable_tuning(struct dw_mci_slot *slot)
+{
+	struct dw_mci_hi3798mv200_priv *priv = slot->host->priv;
+
+	return regmap_set_bits(priv->crg_reg, priv->sap_dll_offset, SAP_DLL_CTRL_DLLMODE);
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
+	int ret;
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
+	priv->crg_reg = syscon_regmap_lookup_by_phandle(np, "hisilicon,sap-dll-reg");
+	if (IS_ERR(priv->crg_reg))
+		return dev_err_probe(host->dev, PTR_ERR(priv->crg_reg),
+				     "failed to get CRG reg\n");
+
+	ret = of_property_read_u32_index(np, "hisilicon,sap-dll-reg", 1, &priv->sap_dll_offset);
+	if (ret)
+		return dev_err_probe(host->dev, ret, "failed to get sample DLL register offset\n");
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


