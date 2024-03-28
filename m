Return-Path: <linux-kernel+bounces-122907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEFB88FF48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7139B22AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF0681AAB;
	Thu, 28 Mar 2024 12:40:43 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917780029;
	Thu, 28 Mar 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629642; cv=none; b=MbM54jMaZUfH4zNA9IodL1M3Br5XtxcCmk3+Xis5+sjDpso65pbCO74958+HP5/jlv1Mz/QwEku+y9TzoVAxNgfQVkYq7a2yxmj+vxCa5EoBHrPESHTVrGjy+LRtKqBEdgAsnF6pCYjdVKMxaC26U4CkCCsh8jezZhWC+MPBplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629642; c=relaxed/simple;
	bh=SQtS1moFzY8TfD0WnLZVCwjP4N3w+K0NYbbTwsrDKjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lS1Ob1IF6nt/X244GafzDZoTJbo5W9dZsYbPnTw+k52Xq0RrPjWcRhTbNZJwLvdDr2f9xItJKMdRRavuARxazOLU2A7yDA1IuDp1RHoFKpFQx2bcN2ZMtqcg51rM/aFqs2FGfLjFvSHseSN79jbAHK6urNkZUgHPOu7Kw2n5sNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: Ea7ANm+7ESGwKTzEKR4yMJiq6buhlTX3Q3w1Cvz23WK20QG72yEeGtpWQo7fygbUQ/AaAfdkzt
 tqXA+PoqkZUQ==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 28 Mar 2024 18:10:36 +0530
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
	eblanc@baylibre.com,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v5 05/11] mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
Date: Thu, 28 Mar 2024 18:10:10 +0530
Message-Id: <20240328124016.161959-6-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328124016.161959-1-bhargav.r@ltts.com>
References: <20240328124016.161959-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TPS65224 PMIC in TPS6594's I2C driver which has
significant functional overlap.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/mfd/tps6594-i2c.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
index 9e2ed48b7..0d741da74 100644
--- a/drivers/mfd/tps6594-i2c.c
+++ b/drivers/mfd/tps6594-i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * I2C access driver for TI TPS6594/TPS6593/LP8764 PMICs
+ * I2C access driver for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
  *
  * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
  */
@@ -192,16 +192,27 @@ static const struct regmap_config tps6594_i2c_regmap_config = {
 	.write = tps6594_i2c_write,
 };
 
+static const struct regmap_config tps65224_i2c_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
+	.volatile_table = &tps65224_volatile_table,
+	.read = tps6594_i2c_read,
+	.write = tps6594_i2c_write,
+};
+
 static const struct tps6594_match_data match_data[] = {
 	[TPS6594] = {TPS6594, &tps6594_i2c_regmap_config},
 	[TPS6593] = {TPS6593, &tps6594_i2c_regmap_config},
 	[LP8764] = {LP8764, &tps6594_i2c_regmap_config},
+	[TPS65224] = {TPS65224, &tps65224_i2c_regmap_config},
 };
 
 static const struct of_device_id tps6594_i2c_of_match_table[] = {
 	{ .compatible = "ti,tps6594-q1", .data = &match_data[TPS6594], },
 	{ .compatible = "ti,tps6593-q1", .data = &match_data[TPS6593], },
 	{ .compatible = "ti,lp8764-q1",  .data = &match_data[LP8764], },
+	{ .compatible = "ti,tps65224-q1", .data = &match_data[TPS65224], },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6594_i2c_of_match_table);
@@ -248,5 +259,5 @@ static struct i2c_driver tps6594_i2c_driver = {
 module_i2c_driver(tps6594_i2c_driver);
 
 MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
-MODULE_DESCRIPTION("TPS6594 I2C Interface Driver");
+MODULE_DESCRIPTION("I2C Interface Driver for TPS65224, TPS6594/3, and LP8764");
 MODULE_LICENSE("GPL");
-- 
2.25.1


