Return-Path: <linux-kernel+bounces-78035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0F860E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76062B23A87
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361515CDD5;
	Fri, 23 Feb 2024 09:38:33 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD305D47A;
	Fri, 23 Feb 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681112; cv=none; b=Mws5n4uZefahz9FTfz9/puDatulRh07/0F4bpq/7q6cHf1FRygMkccllCUEXLtU01e1Zx/KRqFOd5KQ1w8ycuw0q/MwOOqoiMqFVJet/2OuJ5mt/xGuACzWot4bvDjjwPso1YHZcEnJqoLXW6aMhwNpNG20h9uXC1+dyl2SDw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681112; c=relaxed/simple;
	bh=bIYWeV6UlLBAi1dlqnzn/tg+3fzIeekvQyeRXUiIzDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrFDu/8AyIc1vm/yUBAeqcnrWjBjXdRnooiaxr1/PjtpmtjTMsXHm/NtXd5QP7N9VIFEkNcxai2HQdOrTow5r8Lip6hvEno5Sgl5HnZDo3kHaTrJtjmeKHAOG6h7eKw68tnXtMm4E++f+/JdFi5dmrt33UFkGwy47IYj+wM4KWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: EurZgV/oiuT6ybOHFxdGTGSswDRCVYVINgWl/D4lOfsb8XmPxXgJj8swBa1LPwYTRWW0tIffTo
 Rr9Ohz94+8Lg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 23 Feb 2024 15:07:13 +0530
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
Subject: [PATCH v2 05/14] mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
Date: Fri, 23 Feb 2024 15:06:52 +0530
Message-Id: <20240223093701.66034-6-bhargav.r@ltts.com>
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

Add support for TPS65224 PMIC in TPS6594's I2C driver which has
significant functional overlap.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/mfd/tps6594-i2c.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
index e80e0af2b..c5b352ecc 100644
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
 	{ .compatible = "ti,tps6594-q1", .data = (void *)&match_data[TPS6594], },
 	{ .compatible = "ti,tps6593-q1", .data = (void *)&match_data[TPS6593], },
 	{ .compatible = "ti,lp8764-q1",  .data = (void *)&match_data[LP8764], },
+	{ .compatible = "ti,tps65224-q1", .data = (void *)&match_data[TPS65224], },
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


