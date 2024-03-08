Return-Path: <linux-kernel+bounces-96844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A41587621B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D69B21FA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7255E73;
	Fri,  8 Mar 2024 10:35:25 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753253E01;
	Fri,  8 Mar 2024 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894124; cv=none; b=d/A0x4kB9Ecc6yyAGzulmy2HwKZfGTidiBB3SXxRd/XPkpD3BngadUSkrngO4EdZl4mb6LDPkdUt3tDfVeM0TTRpDISILTNqiuvn3d82ZHbmqzOxr7l+7N0HsPi+DZ1Bdc+Op1xPqit6nlvA8BVHVQ6WB1SSKwc46II6ZdP7jU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894124; c=relaxed/simple;
	bh=VAZZuZU4/k55x2dgXDSEwUL8k2KGnFg5JRRMZYXSHwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHXWfxW47wgS4s+zyDkqjta49h/Lbo8H/cZ8AdhMkCHdq92H9YUCDtjUmmb4C+3ocLxU9QIKwAeZFcEWO+ofXuk6tjn8fTa0Z3sGwzdh8JrdPxFANxVzkVy/7XHm7VfNZfsjwnna7WAe7qEy6G9tqtsX3bkf6oT85IMkpRH8yqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: QjBtn9Yf61NWRZzhY9usEOv540jZ92qSXj4+jFrV3oLzPxmKzIFRXZl90uIsRHGSItpH3XdH9j
 JHoVjt1yzL+g==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 08 Mar 2024 16:05:07 +0530
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
Subject: [PATCH v3 02/11] mfd: tps6594: use volatile_table instead of volatile_reg
Date: Fri,  8 Mar 2024 16:04:46 +0530
Message-Id: <20240308103455.242705-3-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308103455.242705-1-bhargav.r@ltts.com>
References: <20240308103455.242705-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In regmap_config use volatile_table instead of volatile_reg. This change
makes it easier to add support for TPS65224 PMIC.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/mfd/tps6594-core.c  | 16 ++++++++++------
 drivers/mfd/tps6594-i2c.c   |  2 +-
 drivers/mfd/tps6594-spi.c   |  2 +-
 include/linux/mfd/tps6594.h |  4 +++-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
index 783ee5990..089ab8cc8 100644
--- a/drivers/mfd/tps6594-core.c
+++ b/drivers/mfd/tps6594-core.c
@@ -319,12 +319,16 @@ static struct regmap_irq_chip tps6594_irq_chip = {
 	.handle_post_irq = tps6594_handle_post_irq,
 };
 
-bool tps6594_is_volatile_reg(struct device *dev, unsigned int reg)
-{
-	return (reg >= TPS6594_REG_INT_TOP && reg <= TPS6594_REG_STAT_READBACK_ERR) ||
-	       reg == TPS6594_REG_RTC_STATUS;
-}
-EXPORT_SYMBOL_GPL(tps6594_is_volatile_reg);
+static const struct regmap_range tps6594_volatile_ranges[] = {
+	regmap_reg_range(TPS6594_REG_INT_TOP, TPS6594_REG_STAT_READBACK_ERR),
+	regmap_reg_range(TPS6594_REG_RTC_STATUS, TPS6594_REG_RTC_STATUS),
+};
+
+const struct regmap_access_table tps6594_volatile_table = {
+	.yes_ranges = tps6594_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(tps6594_volatile_ranges),
+};
+EXPORT_SYMBOL_GPL(tps6594_volatile_table);
 
 static int tps6594_check_crc_mode(struct tps6594 *tps, bool primary_pmic)
 {
diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
index 899c88c0f..c125b474b 100644
--- a/drivers/mfd/tps6594-i2c.c
+++ b/drivers/mfd/tps6594-i2c.c
@@ -187,7 +187,7 @@ static const struct regmap_config tps6594_i2c_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
-	.volatile_reg = tps6594_is_volatile_reg,
+	.volatile_table = &tps6594_volatile_table,
 	.read = tps6594_i2c_read,
 	.write = tps6594_i2c_write,
 };
diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
index 24b72847e..5afb1736f 100644
--- a/drivers/mfd/tps6594-spi.c
+++ b/drivers/mfd/tps6594-spi.c
@@ -70,7 +70,7 @@ static const struct regmap_config tps6594_spi_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
-	.volatile_reg = tps6594_is_volatile_reg,
+	.volatile_table = &tps6594_volatile_table,
 	.reg_read = tps6594_spi_reg_read,
 	.reg_write = tps6594_spi_reg_write,
 	.use_single_read = true,
diff --git a/include/linux/mfd/tps6594.h b/include/linux/mfd/tps6594.h
index 1d8969594..6c5a2889f 100644
--- a/include/linux/mfd/tps6594.h
+++ b/include/linux/mfd/tps6594.h
@@ -1344,7 +1344,9 @@ struct tps6594 {
 	struct regmap_irq_chip_data *irq_data;
 };
 
-bool tps6594_is_volatile_reg(struct device *dev, unsigned int reg);
+extern const struct regmap_access_table tps6594_volatile_table;
+extern const struct regmap_access_table tps65224_volatile_table;
+
 int tps6594_device_init(struct tps6594 *tps, bool enable_crc);
 
 #endif /*  __LINUX_MFD_TPS6594_H */
-- 
2.25.1


