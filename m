Return-Path: <linux-kernel+bounces-78041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD08860E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E819E1F2642B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386F95F48C;
	Fri, 23 Feb 2024 09:38:41 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60F5E3BA;
	Fri, 23 Feb 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681120; cv=none; b=PqTqGTEiIC9U5Jr+Ygk+WPnxmqB+P4wN99MaYi/p6Ocjr2pE1tG/cEwaERtHD2qvc+J4HGIuUvTEQVg5jWsszd5iBPg+kmd22xMNHHA+dplE+0r+v3MPWWq+hbADK9aJ/dF1xCx9PgBGckJtnajhzRu5/n8V0pch4wtBqnh6jvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681120; c=relaxed/simple;
	bh=ANFQs58thb6Sfo8Tnd1vzz2cEfX0deEseKjVLICGrQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhY3D0qEJNjhb+6dSO7/8synmti0TDbLg7WMKqrJ/nhN+oCx220dMZpinmkrBBv0IDYyRIYvSWRAqoEdQBAqtb6cnNI6kwSUnr2N/0ZZsiyMGEFpqrsEsQwOleEOZkN9VXrPy2kf2KTsZhfYlcRSSWBd0561fCvUCL8/TDOXsds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: l7sBvG3RqvWxhq/IQT1+9LF4MByomStBnxI1m9a4CafVQhYI6NVKY/VHLkZg8zubQOTC2mgoXs
 muTIygVjDzeA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 23 Feb 2024 15:07:18 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jpanis@baylibre.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v2 11/14] misc: tps6594-esm: Add TI TPS65224 PMIC ESM
Date: Fri, 23 Feb 2024 15:06:58 +0530
Message-Id: <20240223093701.66034-12-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223093701.66034-1-bhargav.r@ltts.com>
References: <20240223093701.66034-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TPS65224 Error Signal Monitor in the TPS6594 ESM driver
as they share significant functionality.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/misc/tps6594-esm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/tps6594-esm.c b/drivers/misc/tps6594-esm.c
index d0f86b0e9..445d82bd3 100644
--- a/drivers/misc/tps6594-esm.c
+++ b/drivers/misc/tps6594-esm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * ESM (Error Signal Monitor) driver for TI TPS6594/TPS6593/LP8764 PMICs
+ * ESM (Error Signal Monitor) driver for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
  *
  * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
  */
@@ -20,6 +20,8 @@
 #define ESM_MODE_CFG_CLR  0x0
 #define ESM_START_CLR     0x0
 
+static struct reg_field tps65224_esm_mode_cfg = REG_FIELD(TPS6594_REG_ESM_MCU_MODE_CFG,  5, 6);
+static struct reg_field tps65224_esm_start    = REG_FIELD(TPS6594_REG_ESM_MCU_START_REG, 0, 0);
 static struct reg_field tps6594_esm_mode_cfg  = REG_FIELD(TPS6594_REG_ESM_SOC_MODE_CFG,  5, 6);
 static struct reg_field tps6594_esm_start     = REG_FIELD(TPS6594_REG_ESM_SOC_START_REG, 0, 0);
 
@@ -87,8 +89,14 @@ static int tps6594_esm_probe(struct platform_device *pdev)
 	if (!esm)
 		return -ENOMEM;
 
-	esm->esm_mode_cfg = devm_regmap_field_alloc(dev, tps->regmap, tps6594_esm_mode_cfg);
-	esm->esm_start = devm_regmap_field_alloc(dev, tps->regmap, tps6594_esm_start);
+	if (tps->chip_id == TPS65224) {
+		esm->esm_mode_cfg = devm_regmap_field_alloc(dev, tps->regmap,
+							    tps65224_esm_mode_cfg);
+		esm->esm_start = devm_regmap_field_alloc(dev, tps->regmap, tps65224_esm_start);
+	} else {
+		esm->esm_mode_cfg = devm_regmap_field_alloc(dev, tps->regmap, tps6594_esm_mode_cfg);
+		esm->esm_start = devm_regmap_field_alloc(dev, tps->regmap, tps6594_esm_start);
+	}
 
 	if (IS_ERR(esm->esm_mode_cfg)) {
 		dev_err(dev, "esm_mode_cfg reg field init failed\n");
@@ -176,5 +184,6 @@ module_platform_driver(tps6594_esm_driver);
 
 MODULE_ALIAS("platform:tps6594-esm");
 MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_AUTHOR("Bhargav Raviprakash <bhargav.r@ltts.com>");
 MODULE_DESCRIPTION("TPS6594 Error Signal Monitor Driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1


