Return-Path: <linux-kernel+bounces-149834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9568A9683
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ADB1C21BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA90E15E7EA;
	Thu, 18 Apr 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="37WzhxbD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8F15B96D;
	Thu, 18 Apr 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433309; cv=none; b=EaL0i7ccSlAAir549l+dUpnIBzjvyn7fl6I9TrBiyrYY7RITUDAowu+OyGW2whCUoXnxswjU2B7ozS39e4Y76NC47T7bRGbdICRnjaMctPz2/Fiej/PkQcTiamjAEN5E1UqoGbi5WnAuKPBK1bgqPJU4QmRUYpz+XvbVAY8+0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433309; c=relaxed/simple;
	bh=HutkkugHrqMd2uUFtowMQxRDssuoDexqUjYh9nxhXJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSMmoS/a1NsR7BMfC6mogZuYhCyDWKl+c9KrsuFVA5vtGW2ZzfTjq38cf6ZFhMeiljRNF6CjFkS/GwQ7V2Q58u9YE4S+/uUwok/j/SCYdvyPPGwuJ1N+FriQmwZTYpUmOee4o/MqJHeQv4RjZ+Wdw5QmfjjGNW6gbPUvVtK8tyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=37WzhxbD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713433304;
	bh=HutkkugHrqMd2uUFtowMQxRDssuoDexqUjYh9nxhXJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=37WzhxbD/ayhckhPLRDAnPChSJCHWqhQ4ZQ3fF1iuwnX8HS5s/2rHFAyNZXlKp4GN
	 5X+vKThcKmGtiQ+1kJZRv35EB7+vJRwDTjVukPrfyt0JenGdj6+b3JaAxJtMB0iMyB
	 xb+JnkNaULZQ7iKKh8KCjOhvGNdO6J01XM3U7u6T02s8LCe7aXleXPEcfRurgteTu/
	 Hua837jdf+OUNNzpMF+TsYPgq44IXmbIq78Lh634f544T5/YHaxbOl/RUYjPIlecbI
	 6mbEK3N1XefmBhw0Dbc06d+u9H57RleI1CyQcJ4/owxHfDaTc0rMqC6ok5GglhfBCb
	 M5SPJ+m5mK1Jg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A01C03782149;
	Thu, 18 Apr 2024 09:41:43 +0000 (UTC)
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
Subject: [PATCH v4 5/7] regulator: Remove mtk-dvfsrc-regulator.c
Date: Thu, 18 Apr 2024 11:41:32 +0200
Message-ID: <20240418094134.203330-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418094134.203330-1-angelogioacchino.delregno@collabora.com>
References: <20240418094134.203330-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver never worked, and never got even compiled, because it was
missing the DVFSRC driver entirely, including headers it relies on!

In preparation of a full refactoring of this driver, remove it.

The Makefile and Kconfig entries are retained, as those are reused
as-is for the refactored code.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/mtk-dvfsrc-regulator.c | 214 -----------------------
 1 file changed, 214 deletions(-)
 delete mode 100644 drivers/regulator/mtk-dvfsrc-regulator.c

diff --git a/drivers/regulator/mtk-dvfsrc-regulator.c b/drivers/regulator/mtk-dvfsrc-regulator.c
deleted file mode 100644
index f1280d45265d..000000000000
--- a/drivers/regulator/mtk-dvfsrc-regulator.c
+++ /dev/null
@@ -1,214 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Copyright (c) 2020 MediaTek Inc.
-
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/of_.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/of_regulator.h>
-#include <linux/soc/mediatek/mtk_dvfsrc.h>
-
-#define DVFSRC_ID_VCORE		0
-#define DVFSRC_ID_VSCP		1
-
-#define MT_DVFSRC_REGULAR(match, _name,	_volt_table)	\
-[DVFSRC_ID_##_name] = {					\
-	.desc = {					\
-		.name = match,				\
-		.of_match = of_match_ptr(match),	\
-		.ops = &dvfsrc_vcore_ops,		\
-		.type = REGULATOR_VOLTAGE,		\
-		.id = DVFSRC_ID_##_name,		\
-		.owner = THIS_MODULE,			\
-		.n_voltages = ARRAY_SIZE(_volt_table),	\
-		.volt_table = _volt_table,		\
-	},	\
-}
-
-/*
- * DVFSRC regulators' information
- *
- * @desc: standard fields of regulator description.
- * @voltage_selector:  Selector used for get_voltage_sel() and
- *			   set_voltage_sel() callbacks
- */
-
-struct dvfsrc_regulator {
-	struct regulator_desc	desc;
-};
-
-/*
- * MTK DVFSRC regulators' init data
- *
- * @size: num of regulators
- * @regulator_info: regulator info.
- */
-struct dvfsrc_regulator_init_data {
-	u32 size;
-	struct dvfsrc_regulator *regulator_info;
-};
-
-static inline struct device *to_dvfsrc_dev(struct regulator_dev *rdev)
-{
-	return rdev_get_dev(rdev)->parent;
-}
-
-static int dvfsrc_set_voltage_sel(struct regulator_dev *rdev,
-				  unsigned int selector)
-{
-	struct device *dvfsrc_dev = to_dvfsrc_dev(rdev);
-	int id = rdev_get_id(rdev);
-
-	if (id == DVFSRC_ID_VCORE)
-		mtk_dvfsrc_send_request(dvfsrc_dev,
-					MTK_DVFSRC_CMD_VCORE_REQUEST,
-					selector);
-	else if (id == DVFSRC_ID_VSCP)
-		mtk_dvfsrc_send_request(dvfsrc_dev,
-					MTK_DVFSRC_CMD_VSCP_REQUEST,
-					selector);
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int dvfsrc_get_voltage_sel(struct regulator_dev *rdev)
-{
-	struct device *dvfsrc_dev = to_dvfsrc_dev(rdev);
-	int id = rdev_get_id(rdev);
-	int val, ret;
-
-	if (id == DVFSRC_ID_VCORE)
-		ret = mtk_dvfsrc_query_info(dvfsrc_dev,
-					    MTK_DVFSRC_CMD_VCORE_LEVEL_QUERY,
-					    &val);
-	else if (id == DVFSRC_ID_VSCP)
-		ret = mtk_dvfsrc_query_info(dvfsrc_dev,
-					    MTK_DVFSRC_CMD_VSCP_LEVEL_QUERY,
-					    &val);
-	else
-		return -EINVAL;
-
-	if (ret != 0)
-		return ret;
-
-	return val;
-}
-
-static const struct regulator_ops dvfsrc_vcore_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.get_voltage_sel = dvfsrc_get_voltage_sel,
-	.set_voltage_sel = dvfsrc_set_voltage_sel,
-};
-
-static const unsigned int mt8183_voltages[] = {
-	725000,
-	800000,
-};
-
-static struct dvfsrc_regulator mt8183_regulators[] = {
-	MT_DVFSRC_REGULAR("dvfsrc-vcore", VCORE,
-			  mt8183_voltages),
-};
-
-static const struct dvfsrc_regulator_init_data regulator_mt8183_data = {
-	.size = ARRAY_SIZE(mt8183_regulators),
-	.regulator_info = &mt8183_regulators[0],
-};
-
-static const unsigned int mt6873_voltages[] = {
-	575000,
-	600000,
-	650000,
-	725000,
-};
-
-static struct dvfsrc_regulator mt6873_regulators[] = {
-	MT_DVFSRC_REGULAR("dvfsrc-vcore", VCORE,
-			  mt6873_voltages),
-	MT_DVFSRC_REGULAR("dvfsrc-vscp", VSCP,
-			  mt6873_voltages),
-};
-
-static const struct dvfsrc_regulator_init_data regulator_mt6873_data = {
-	.size = ARRAY_SIZE(mt6873_regulators),
-	.regulator_info = &mt6873_regulators[0],
-};
-
-static const struct of_device_id mtk_dvfsrc_regulator_match[] = {
-	{
-		.compatible = "mediatek,mt8183-dvfsrc",
-		.data = &regulator_mt8183_data,
-	}, {
-		.compatible = "mediatek,mt8192-dvfsrc",
-		.data = &regulator_mt6873_data,
-	}, {
-		.compatible = "mediatek,mt6873-dvfsrc",
-		.data = &regulator_mt6873_data,
-	}, {
-		/* sentinel */
-	},
-};
-MODULE_DEVICE_TABLE(of, mtk_dvfsrc_regulator_match);
-
-static int dvfsrc_vcore_regulator_probe(struct platform_device *pdev)
-{
-	const struct of_device_id *match;
-	struct device *dev = &pdev->dev;
-	struct regulator_config config = { };
-	struct regulator_dev *rdev;
-	const struct dvfsrc_regulator_init_data *regulator_init_data;
-	struct dvfsrc_regulator *mt_regulators;
-	int i;
-
-	match = of_match_node(mtk_dvfsrc_regulator_match, dev->parent->of_node);
-
-	if (!match) {
-		dev_err(dev, "invalid compatible string\n");
-		return -ENODEV;
-	}
-
-	regulator_init_data = match->data;
-
-	mt_regulators = regulator_init_data->regulator_info;
-	for (i = 0; i < regulator_init_data->size; i++) {
-		config.dev = dev->parent;
-		config.driver_data = (mt_regulators + i);
-		rdev = devm_regulator_register(dev, &(mt_regulators + i)->desc,
-					       &config);
-		if (IS_ERR(rdev)) {
-			dev_err(dev, "failed to register %s\n",
-				(mt_regulators + i)->desc.name);
-			return PTR_ERR(rdev);
-		}
-	}
-
-	return 0;
-}
-
-static struct platform_driver mtk_dvfsrc_regulator_driver = {
-	.driver = {
-		.name  = "mtk-dvfsrc-regulator",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-	},
-	.probe = dvfsrc_vcore_regulator_probe,
-};
-
-static int __init mtk_dvfsrc_regulator_init(void)
-{
-	return platform_driver_register(&mtk_dvfsrc_regulator_driver);
-}
-subsys_initcall(mtk_dvfsrc_regulator_init);
-
-static void __exit mtk_dvfsrc_regulator_exit(void)
-{
-	platform_driver_unregister(&mtk_dvfsrc_regulator_driver);
-}
-module_exit(mtk_dvfsrc_regulator_exit);
-
-MODULE_AUTHOR("Arvin wang <arvin.wang@mediatek.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.44.0


