Return-Path: <linux-kernel+bounces-148217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B48A7F70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3FA1C21742
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1513BC27;
	Wed, 17 Apr 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EW1FTlr4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973513AD15;
	Wed, 17 Apr 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345297; cv=none; b=C9D93lzeZH2V5XkG0K6pgHeIp4D3iRDbBDTAiVzKmdtPfxc2QSdgT/ewkZ+c0izVFsnbj6TyWUCwkyn375MsfQPc+EDADdhGSitKjw6tBx6lqWu5NwKeY1LkWKc5KmXdplmrSIJbExJiPKeJMe2+2Vy7FSC5TV0V0lfqZKWkFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345297; c=relaxed/simple;
	bh=UYe8/W7VAx7VwajQk2KmjPzIcdGVq0lvp1J4Qo5OOus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuzk+b7DnlZjjmezr09cBB6gTstQifbY5+StRcLLDF7F81eAcoCwiArmc0EN+2x6z1sIIlRSacrJ+fiY9jBEhuBEGRGISzInwmoiqLlv9bjDlPFWl+GKx2hdx8tLAECuT9MonT/CTQe1sge7qQYE0cv4nS4sUdRdYflU7L990jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EW1FTlr4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713345294;
	bh=UYe8/W7VAx7VwajQk2KmjPzIcdGVq0lvp1J4Qo5OOus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EW1FTlr4dwiJHrWzkcxA9j3Qx4K4ZLflQYqZTdQwDC4KogBTN6GbFNNKCfzi+N+tX
	 o9MTcRWX4DF5hr2hahTOMu8/mA2Hvbrfv6ry/A1balm2Wr1XEMONLnj7AjMiUlrLZL
	 uW8ERbZts+h4XzU5Vxiu7UMEKet5Phmqg7s0b6bh0BgLFLoumxOJB5Qh5Wb7CUGm6b
	 AgTlZlTuAYAgQcWBAhQ3x+ONGzJuAe98fEcL8cCLbubFa7c8oYP1rMVQ5WvJLae0aT
	 rX5CiuWCgwJL0912LUSH09tvoWgwdwb71pBtYF/HEke/BkVWj7Joa1GaSqgAYQ6YMq
	 +MwU3EgpwnVDQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2219837820F9;
	Wed, 17 Apr 2024 09:14:53 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	keescook@chromium.org,
	gustavoars@kernel.org,
	henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	amergnat@baylibre.com
Subject: [PATCH v2 6/7] regulator: Add refactored mtk-dvfsrc-regulator driver
Date: Wed, 17 Apr 2024 11:14:41 +0200
Message-ID: <20240417091442.170505-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous driver never worked, and never got even compiled because
it was missing the DVFSRC driver entirely, including needed neaders.

This is a full (or nearly full) refactoring of the MediaTek DVFSRC
controlled Regulators driver, retaining support for the MT6873, MT8183
and MT8192 SoC, and adding MT8195.

As part of the refactoring, this driver is now probed using its own
devicetree compatible, as this is a child of the main DVFSRC driver
and gets probed as a subnode of that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/mtk-dvfsrc-regulator.c | 196 +++++++++++++++++++++++
 1 file changed, 196 insertions(+)
 create mode 100644 drivers/regulator/mtk-dvfsrc-regulator.c

diff --git a/drivers/regulator/mtk-dvfsrc-regulator.c b/drivers/regulator/mtk-dvfsrc-regulator.c
new file mode 100644
index 000000000000..9d398d72d2fb
--- /dev/null
+++ b/drivers/regulator/mtk-dvfsrc-regulator.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ * Copyright (c) 2024 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/soc/mediatek/dvfsrc.h>
+
+enum dvfsrc_regulator_id {
+	DVFSRC_ID_VCORE,
+	DVFSRC_ID_VSCP,
+	DVFSRC_ID_MAX
+};
+
+struct dvfsrc_regulator_pdata {
+	struct regulator_desc *descs;
+	u32 size;
+};
+
+#define MTK_DVFSRC_VREG(match, _name, _volt_table)	\
+{							\
+	.name = match,					\
+	.of_match = match,				\
+	.ops = &dvfsrc_vcore_ops,			\
+	.type = REGULATOR_VOLTAGE,			\
+	.id = DVFSRC_ID_##_name,			\
+	.owner = THIS_MODULE,				\
+	.n_voltages = ARRAY_SIZE(_volt_table),		\
+	.volt_table = _volt_table,			\
+}
+
+static inline struct device *to_dvfs_regulator_dev(struct regulator_dev *rdev)
+{
+	return rdev_get_dev(rdev)->parent;
+}
+
+static inline struct device *to_dvfsrc_dev(struct regulator_dev *rdev)
+{
+	return to_dvfs_regulator_dev(rdev)->parent;
+}
+
+static int dvfsrc_get_cmd(int rdev_id, enum mtk_dvfsrc_cmd *cmd)
+{
+	switch (rdev_id) {
+	case DVFSRC_ID_VCORE:
+		*cmd = MTK_DVFSRC_CMD_VCORE_LEVEL;
+		break;
+	case DVFSRC_ID_VSCP:
+		*cmd = MTK_DVFSRC_CMD_VSCP_LEVEL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dvfsrc_set_voltage_sel(struct regulator_dev *rdev,
+				  unsigned int selector)
+{
+	struct device *dvfsrc_dev = to_dvfsrc_dev(rdev);
+	enum mtk_dvfsrc_cmd req_cmd;
+	int id = rdev_get_id(rdev);
+	int ret;
+
+	ret = dvfsrc_get_cmd(id, &req_cmd);
+	if (ret)
+		return ret;
+
+	return mtk_dvfsrc_send_request(dvfsrc_dev, req_cmd, selector);
+}
+
+static int dvfsrc_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct device *dvfsrc_dev = to_dvfsrc_dev(rdev);
+	enum mtk_dvfsrc_cmd query_cmd;
+	int id = rdev_get_id(rdev);
+	int val, ret;
+
+	ret = dvfsrc_get_cmd(id, &query_cmd);
+	if (ret)
+		return ret;
+
+	ret = mtk_dvfsrc_query_info(dvfsrc_dev, query_cmd, &val);
+	if (ret)
+		return ret;
+
+	return val;
+}
+
+static const struct regulator_ops dvfsrc_vcore_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.get_voltage_sel = dvfsrc_get_voltage_sel,
+	.set_voltage_sel = dvfsrc_set_voltage_sel,
+};
+
+static const unsigned int mt6873_voltages[] = {
+	575000,
+	600000,
+	650000,
+	725000,
+};
+
+static struct regulator_desc mt6873_regulators[] = {
+	MTK_DVFSRC_VREG("dvfsrc-vcore", VCORE, mt6873_voltages),
+	MTK_DVFSRC_VREG("dvfsrc-vscp", VSCP, mt6873_voltages),
+};
+
+static const struct dvfsrc_regulator_pdata mt6873_data = {
+	.descs = mt6873_regulators,
+	.size = ARRAY_SIZE(mt6873_regulators),
+};
+
+static const unsigned int mt8183_voltages[] = {
+	725000,
+	800000,
+};
+
+static struct regulator_desc mt8183_regulators[] = {
+	MTK_DVFSRC_VREG("dvfsrc-vcore", VCORE, mt8183_voltages),
+};
+
+static const struct dvfsrc_regulator_pdata mt8183_data = {
+	.descs = mt8183_regulators,
+	.size = ARRAY_SIZE(mt8183_regulators),
+};
+
+static const unsigned int mt8195_voltages[] = {
+	550000,
+	600000,
+	650000,
+	750000,
+};
+
+static struct regulator_desc mt8195_regulators[] = {
+	MTK_DVFSRC_VREG("dvfsrc-vcore", VCORE, mt8195_voltages),
+	MTK_DVFSRC_VREG("dvfsrc-vscp", VSCP, mt8195_voltages),
+};
+
+static const struct dvfsrc_regulator_pdata mt8195_data = {
+	.descs = mt8195_regulators,
+	.size = ARRAY_SIZE(mt8195_regulators),
+};
+
+static int dvfsrc_vcore_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_config config = { .dev = &pdev->dev };
+	const struct dvfsrc_regulator_pdata *pdata;
+	int i;
+
+	pdata = device_get_match_data(&pdev->dev);
+	if (!pdata)
+		return -EINVAL;
+
+	for (i = 0; i < pdata->size; i++) {
+		struct regulator_desc *vrdesc = &pdata->descs[i];
+		struct regulator_dev *rdev;
+
+		rdev = devm_regulator_register(&pdev->dev, vrdesc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register %s\n", vrdesc->name);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mtk_dvfsrc_regulator_match[] = {
+	{ .compatible = "mediatek,mt6873-dvfsrc-regulator", .data = &mt6873_data },
+	{ .compatible = "mediatek,mt8183-dvfsrc-regulator", .data = &mt8183_data },
+	{ .compatible = "mediatek,mt8192-dvfsrc-regulator", .data = &mt6873_data },
+	{ .compatible = "mediatek,mt8195-dvfsrc-regulator", .data = &mt8195_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtk_dvfsrc_regulator_match);
+
+static struct platform_driver mtk_dvfsrc_regulator_driver = {
+	.driver = {
+		.name  = "mtk-dvfsrc-regulator",
+		.of_match_table = mtk_dvfsrc_regulator_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = dvfsrc_vcore_regulator_probe,
+};
+module_platform_driver(mtk_dvfsrc_regulator_driver);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_AUTHOR("Arvin wang <arvin.wang@mediatek.com>");
+MODULE_LICENSE("GPL");
-- 
2.44.0


