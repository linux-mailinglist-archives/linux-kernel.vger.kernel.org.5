Return-Path: <linux-kernel+bounces-57713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6502984DCA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D891F25DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186B6BFA1;
	Thu,  8 Feb 2024 09:20:54 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A296BB4F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384053; cv=none; b=TIGElBu0zhgTn0r2w0+VLWgkh0WFxGc+TLwxVNh3vPsK9j3Tg0B+IRNX+mZPPi2Xd9Xup0MeaHmKzETrNjSGaA2W1iaSTdWXZaJVXgwNKk3Zr3j+pLzyBCfT630jgCN1CZTr9q1gU/Qzi16IfEOceFWaUsV96agzOoDnjcAGukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384053; c=relaxed/simple;
	bh=MSMA/Ar5xNq7gjfGIgm/+GRGGaFMAfD3V43FNkMJOFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qByMmy/1BSJnqeWu55/xLJWC+0k39wcKR7lDNIA+QU/6NuwaN7wBQ2VsMW+tRs43T4oehntXz/P5FntE16APZ29yOUhYdJOGbViS3J0B6qUqDmoBjP65X2npuOkqub9tucQFxfsuBHVYeNagtbK8iYmHF8V1d0Ov+Bzzmo4xffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: efdHsa9RxU+vY/RUxS1obiEp5dzk0Ok5czPpEkroSH+9kLEgWkDox0AssIWwqKYcnsI+2PkOli
 E+J5cEa3pHzg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 08 Feb 2024 14:50:48 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v1 04/13] mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
Date: Thu,  8 Feb 2024 14:50:32 +0530
Message-Id: <20240208092034.1207057-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/mfd/tps6594-i2c.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
index c125b474b..4ab91c34d 100644
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
@@ -183,7 +183,7 @@ static int tps6594_i2c_write(void *context, const void *data, size_t count)
 	return ret;
 }
 
-static const struct regmap_config tps6594_i2c_regmap_config = {
+static struct regmap_config tps6594_i2c_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
@@ -196,6 +196,7 @@ static const struct of_device_id tps6594_i2c_of_match_table[] = {
 	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
 	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
 	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
+	{ .compatible = "ti,tps65224-q1", .data = (void *)TPS65224, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6594_i2c_of_match_table);
@@ -216,15 +217,18 @@ static int tps6594_i2c_probe(struct i2c_client *client)
 	tps->reg = client->addr;
 	tps->irq = client->irq;
 
-	tps->regmap = devm_regmap_init(dev, NULL, client, &tps6594_i2c_regmap_config);
-	if (IS_ERR(tps->regmap))
-		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
-
 	match = of_match_device(tps6594_i2c_of_match_table, dev);
 	if (!match)
 		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
 	tps->chip_id = (unsigned long)match->data;
 
+	if (tps->chip_id == TPS65224)
+		tps6594_i2c_regmap_config.volatile_table = &tps65224_volatile_table;
+
+	tps->regmap = devm_regmap_init(dev, NULL, client, &tps6594_i2c_regmap_config);
+	if (IS_ERR(tps->regmap))
+		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
+
 	crc8_populate_msb(tps6594_i2c_crc_table, TPS6594_CRC8_POLYNOMIAL);
 
 	return tps6594_device_init(tps, enable_crc);
@@ -240,5 +244,5 @@ static struct i2c_driver tps6594_i2c_driver = {
 module_i2c_driver(tps6594_i2c_driver);
 
 MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
-MODULE_DESCRIPTION("TPS6594 I2C Interface Driver");
+MODULE_DESCRIPTION("I2C Interface Driver for TPS65224, TPS6594/3, and LP8764");
 MODULE_LICENSE("GPL");
-- 
2.25.1


