Return-Path: <linux-kernel+bounces-57726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373A84DCBF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563101C2264D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BE071B5D;
	Thu,  8 Feb 2024 09:21:24 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0E71B3B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384084; cv=none; b=LuyEbULJeM5s3fzOX8dKUGNEzoW2G/XGJ9lja5NmLhCIa6q27fb3PJTgnzo5Oe2lTmPUwC2QcSAtEyidEgBaZYB4S7Ij1RPgqf7K648BITgkV9fajI4r+wOaarFW+obF/tv2mw1y8SBWqpBE+rHrxZB7oWwca45w+c9qom0K7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384084; c=relaxed/simple;
	bh=ANFQs58thb6Sfo8Tnd1vzz2cEfX0deEseKjVLICGrQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myxtKiaHUTAF5Osm4p81EF458KwRBCJFK9dfwoJpG0xa8TH5584jFLjSGHcM/cyITyrhMil0BvNqZ56Ike8wyTiAqv/BTNoXIsBnW1CxiAVVRZkKUrV5CfPCVKkafxW7YPHR2qnDGOiAfBsKE5/neDpAoQz/hyVXi30+CxQQ/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: 4/N13WmplNXRIeMIGn/FrRpk2Cyz+WSpmbB8whz8wzehNUbXss/FbNbvDU0VTJjgrE49cV8rnq
 W6bek2HdD9xA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 08 Feb 2024 14:51:14 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v1 10/13] misc: tps6594-esm: Add TI TPS65224 PMIC ESM
Date: Thu,  8 Feb 2024 14:50:59 +0530
Message-Id: <20240208092059.1207134-4-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208092059.1207134-1-bhargav.r@ltts.com>
References: <20240208092059.1207134-1-bhargav.r@ltts.com>
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


