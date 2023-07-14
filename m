Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E525A7534D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjGNIQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjGNIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:15:37 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E69B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:14:19 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b71cdb47e1so1286928a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689322458; x=1691914458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPtLz59g/19SfWdp+kBElyzwkcAzJrluFiYldivgMOw=;
        b=kEv0lRHWOSTTxdPqx2AViESAXrIH9TAXsvkIgr/I9YhIUecKifO2b0XDMKxsvY3y8T
         I0FMuPmDNP1n4gwHOwuy6LBlR+2m3CDExMEMBHoDsob6ypFCs836gWJ5yZz/GiJD7h2i
         STfvClsXiS/rmYGmy8UKqSW2la7vAfaXMpyA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322458; x=1691914458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPtLz59g/19SfWdp+kBElyzwkcAzJrluFiYldivgMOw=;
        b=UuUeBLZvHqoMN9QO/sDV6o7yujlOUQQ7z8rIeQXco3xhMAKbJHFNnMaCTTJsAN6bw8
         ckf2DcCa1SsPlGLV7VUwNUmd/5jrgPlHXndJSEoFMgRD27HefYCzYrYBUvw7DrtMzMgD
         tcizuwiXbnpqUMWVr38m55unxRVzNUQ5lGQm4ivKw2xuPiSSR3gSr4CMIVhrZ02YvO9P
         E2um8NUQjNakVLDOYOGw5shspXPz6Ju1spD2ZWd4WVC/CHHnJSr+4xn4pKbWMffvaP/v
         W09S7s9KmAhtmJJKJ+hbVARGVkHpsb1H8vl1gyA6hF3m1iiUk6Ia/EnyoOEbgBP4dm8l
         LApA==
X-Gm-Message-State: ABy/qLbcKlZnMMXQMNnFyxV87Sy2mLvTna05aUkEMj2KEi9jXeTpZmyQ
        Ofu7IvfVHWQKbaIA+bnFTmqx7g==
X-Google-Smtp-Source: APBJJlFLqpXez/eFjagyX0Itumc4CVUHbd2Jy7LULM8S6iPhAs/tlBhKCe3Q6AtHqdBVWLh1BYKNHA==
X-Received: by 2002:a05:6358:7242:b0:134:ed86:1a75 with SMTP id i2-20020a056358724200b00134ed861a75mr6484909rwa.28.1689322458205;
        Fri, 14 Jul 2023 01:14:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:a461:4528:3712:4aaa])
        by smtp.gmail.com with ESMTPSA id z26-20020aa791da000000b00682a908949bsm6827599pfa.92.2023.07.14.01.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:14:17 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] regulator: Use bitfield values for range selectors
Date:   Fri, 14 Jul 2023 16:14:07 +0800
Message-ID: <20230714081408.274567-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the regulator helpers expect raw register values for the range
selectors. This is different from the voltage selectors, which are
normalized as bitfield values. This leads to a bit of confusion. Also,
raw values are harder to copy from datasheets or match up with them,
as datasheets will typically have bitfield values.

Make the helpers expect bitfield values, and convert existing users. The
field in regulator_desc is renamed to |linear_range_selectors_bitfield|.
This is intended to cause drivers added in the same merge window and
out-of-tree drivers using the incorrect variable and values to break,
preventing incorrect values being used on actual hardware and potentially
producing magic smoke.

Also include bitops.h explicitly for ffs(), and reorder the header include
statements. While at it, also replace module.h with export.h, since the
only use is EXPORT_SYMBOL_GPL.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Changed .linear_range_selectors to .linear_range_selectors_bitfield,
  as suggested by David
- Dropped Matti's Reviewed-by due to this intrusive change
- Converted newly added max77541 regulator driver
- Fix up max77650 driver due to renamed field

Changes since v1:
- Fixed up bd71847_buck4_volt_range_sel in bd718x7-regulator.c

 drivers/regulator/atc260x-regulator.c  |  4 ++--
 drivers/regulator/bd718x7-regulator.c  | 22 +++++++++++-----------
 drivers/regulator/helpers.c            | 15 +++++++++------
 drivers/regulator/max77541-regulator.c |  6 +++---
 drivers/regulator/max77650-regulator.c |  2 +-
 drivers/regulator/rohm-regulator.c     |  2 +-
 drivers/regulator/tps6287x-regulator.c |  4 ++--
 include/linux/regulator/driver.h       | 11 ++++++-----
 8 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
index 87e237d740bc..7e4280cd8660 100644
--- a/drivers/regulator/atc260x-regulator.c
+++ b/drivers/regulator/atc260x-regulator.c
@@ -37,7 +37,7 @@ static const struct linear_range atc2609a_ldo_voltage_ranges1[] = {
 };
 
 static const unsigned int atc260x_ldo_voltage_range_sel[] = {
-	0x0, 0x20,
+	0x0, 0x1,
 };
 
 static int atc260x_dcdc_set_voltage_time_sel(struct regulator_dev *rdev,
@@ -427,7 +427,7 @@ enum atc2609a_reg_ids {
 	.vsel_mask = GENMASK(4, 1), \
 	.vsel_range_reg = ATC2609A_PMU_LDO##num##_CTL0, \
 	.vsel_range_mask = BIT(5), \
-	.linear_range_selectors = atc260x_ldo_voltage_range_sel, \
+	.linear_range_selectors_bitfield = atc260x_ldo_voltage_range_sel, \
 	.enable_reg = ATC2609A_PMU_LDO##num##_CTL0, \
 	.enable_mask = BIT(0), \
 	.enable_time = 2000, \
diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b0b9938c20a1..c3fb05dce40c 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -289,7 +289,7 @@ static const struct linear_range bd71837_buck5_volts[] = {
  * and 0x1 for last 3 ranges.
  */
 static const unsigned int bd71837_buck5_volt_range_sel[] = {
-	0x0, 0x0, 0x0, 0x80, 0x80, 0x80
+	0x0, 0x0, 0x0, 0x1, 0x1, 0x1
 };
 
 /*
@@ -309,7 +309,7 @@ static const struct linear_range bd71847_buck3_volts[] = {
 };
 
 static const unsigned int bd71847_buck3_volt_range_sel[] = {
-	0x0, 0x0, 0x0, 0x40, 0x80, 0x80, 0x80
+	0x0, 0x0, 0x0, 0x1, 0x2, 0x2, 0x2
 };
 
 static const struct linear_range bd71847_buck4_volts[] = {
@@ -317,7 +317,7 @@ static const struct linear_range bd71847_buck4_volts[] = {
 	REGULATOR_LINEAR_RANGE(2600000, 0x00, 0x03, 100000),
 };
 
-static const unsigned int bd71847_buck4_volt_range_sel[] = { 0x0, 0x40 };
+static const unsigned int bd71847_buck4_volt_range_sel[] = { 0x0, 0x1 };
 
 /*
  * BUCK6
@@ -360,7 +360,7 @@ static const struct linear_range bd718xx_ldo1_volts[] = {
 	REGULATOR_LINEAR_RANGE(1600000, 0x00, 0x03, 100000),
 };
 
-static const unsigned int bd718xx_ldo1_volt_range_sel[] = { 0x0, 0x20 };
+static const unsigned int bd718xx_ldo1_volt_range_sel[] = { 0x0, 0x1 };
 
 /*
  * LDO2
@@ -403,7 +403,7 @@ static const struct linear_range bd71847_ldo5_volts[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x0F, 100000),
 };
 
-static const unsigned int bd71847_ldo5_volt_range_sel[] = { 0x0, 0x20 };
+static const unsigned int bd71847_ldo5_volt_range_sel[] = { 0x0, 0x1 };
 
 /*
  * LDO6
@@ -817,7 +817,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_1ST_NODVS_BUCK_MASK,
 			.vsel_range_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
 			.vsel_range_mask = BD71847_BUCK3_RANGE_MASK,
-			.linear_range_selectors = bd71847_buck3_volt_range_sel,
+			.linear_range_selectors_bitfield = bd71847_buck3_volt_range_sel,
 			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.enable_time = BD71847_BUCK3_STARTUP_TIME,
@@ -845,7 +845,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD71847_BUCK4_MASK,
 			.vsel_range_reg = BD718XX_REG_2ND_NODVS_BUCK_VOLT,
 			.vsel_range_mask = BD71847_BUCK4_RANGE_MASK,
-			.linear_range_selectors = bd71847_buck4_volt_range_sel,
+			.linear_range_selectors_bitfield = bd71847_buck4_volt_range_sel,
 			.enable_mask = BD718XX_BUCK_EN,
 			.enable_time = BD71847_BUCK4_STARTUP_TIME,
 			.owner = THIS_MODULE,
@@ -916,7 +916,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_LDO1_MASK,
 			.vsel_range_reg = BD718XX_REG_LDO1_VOLT,
 			.vsel_range_mask = BD718XX_LDO1_RANGE_MASK,
-			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
+			.linear_range_selectors_bitfield = bd718xx_ldo1_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO1_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
 			.enable_time = BD71847_LDO1_STARTUP_TIME,
@@ -1010,7 +1010,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD71847_LDO5_MASK,
 			.vsel_range_reg = BD718XX_REG_LDO5_VOLT,
 			.vsel_range_mask = BD71847_LDO5_RANGE_MASK,
-			.linear_range_selectors = bd71847_ldo5_volt_range_sel,
+			.linear_range_selectors_bitfield = bd71847_ldo5_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO5_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
 			.enable_time = BD71847_LDO5_STARTUP_TIME,
@@ -1232,7 +1232,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD71837_BUCK5_MASK,
 			.vsel_range_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
 			.vsel_range_mask = BD71837_BUCK5_RANGE_MASK,
-			.linear_range_selectors = bd71837_buck5_volt_range_sel,
+			.linear_range_selectors_bitfield = bd71837_buck5_volt_range_sel,
 			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.enable_time = BD71837_BUCK5_STARTUP_TIME,
@@ -1328,7 +1328,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_LDO1_MASK,
 			.vsel_range_reg = BD718XX_REG_LDO1_VOLT,
 			.vsel_range_mask = BD718XX_LDO1_RANGE_MASK,
-			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
+			.linear_range_selectors_bitfield = bd718xx_ldo1_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO1_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
 			.enable_time = BD71837_LDO1_STARTUP_TIME,
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index e6c999ba3fa2..5ad5f3b3a6b5 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -5,13 +5,14 @@
 // Copyright 2007, 2008 Wolfson Microelectronics PLC.
 // Copyright 2008 SlimLogic Ltd.
 
-#include <linux/kernel.h>
-#include <linux/err.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
-#include <linux/module.h>
 
 #include "internal.h"
 
@@ -104,13 +105,14 @@ static int regulator_range_selector_to_index(struct regulator_dev *rdev,
 {
 	int i;
 
-	if (!rdev->desc->linear_range_selectors)
+	if (!rdev->desc->linear_range_selectors_bitfield)
 		return -EINVAL;
 
 	rval &= rdev->desc->vsel_range_mask;
+	rval >>= ffs(rdev->desc->vsel_range_mask) - 1;
 
 	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
-		if (rdev->desc->linear_range_selectors[i] == rval)
+		if (rdev->desc->linear_range_selectors_bitfield[i] == rval)
 			return i;
 	}
 	return -EINVAL;
@@ -194,7 +196,8 @@ int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
 	sel <<= ffs(rdev->desc->vsel_mask) - 1;
 	sel += rdev->desc->linear_ranges[i].min_sel;
 
-	range = rdev->desc->linear_range_selectors[i];
+	range = rdev->desc->linear_range_selectors_bitfield[i];
+	range <<= ffs(rdev->desc->vsel_mask) - 1;
 
 	if (rdev->desc->vsel_reg == rdev->desc->vsel_range_reg) {
 		ret = regmap_update_bits(rdev->regmap,
diff --git a/drivers/regulator/max77541-regulator.c b/drivers/regulator/max77541-regulator.c
index 2976f9cb3e26..e6b3d9147c37 100644
--- a/drivers/regulator/max77541-regulator.c
+++ b/drivers/regulator/max77541-regulator.c
@@ -44,7 +44,7 @@ static const struct linear_range max77541_buck_ranges[] = {
 };
 
 static const unsigned int max77541_buck_volt_range_sel[] = {
-	0x00, 0x00, 0x40, 0x40, 0x80, 0x80,
+	0x0, 0x0, 0x1, 0x1, 0x2, 0x2,
 };
 
 enum max77541_regulators {
@@ -67,7 +67,7 @@ enum max77541_regulators {
 		.vsel_mask = MAX77541_BITS_MX_VOUT,			\
 		.vsel_range_reg = MAX77541_REG_M ## _id ## _CFG1,	\
 		.vsel_range_mask = MAX77541_BITS_MX_CFG1_RNG,		\
-		.linear_range_selectors = max77541_buck_volt_range_sel, \
+		.linear_range_selectors_bitfield = max77541_buck_volt_range_sel, \
 		.owner = THIS_MODULE,					\
 	}
 
@@ -86,7 +86,7 @@ enum max77541_regulators {
 		.vsel_mask = MAX77541_BITS_MX_VOUT,			\
 		.vsel_range_reg = MAX77541_REG_M ## _id ## _CFG1,	\
 		.vsel_range_mask = MAX77541_BITS_MX_CFG1_RNG,		\
-		.linear_range_selectors = max77541_buck_volt_range_sel, \
+		.linear_range_selectors_bitfield = max77541_buck_volt_range_sel, \
 		.owner = THIS_MODULE,					\
 	}
 
diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index f6539b945037..94abfbb2bc1e 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -239,7 +239,7 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.supply_name		= "in-sbb1",
 		.id			= MAX77650_REGULATOR_ID_SBB1,
 		.ops			= &max77651_SBB1_regulator_ops,
-		.linear_range_selectors	= max77651_sbb1_volt_range_sel,
+		.linear_range_selectors_bitfield	= max77651_sbb1_volt_range_sel,
 		.linear_ranges		= max77651_sbb1_volt_ranges,
 		.n_linear_ranges	= ARRAY_SIZE(max77651_sbb1_volt_ranges),
 		.n_voltages		= 58,
diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
index f97a9a51ee76..0e2418ed957c 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -36,7 +36,7 @@ static int set_dvs_level(const struct regulator_desc *desc,
 	}
 	for (i = 0; i < desc->n_voltages; i++) {
 		/* NOTE to next hacker - Does not support pickable ranges */
-		if (desc->linear_range_selectors)
+		if (desc->linear_range_selectors_bitfield)
 			return -EINVAL;
 		if (desc->n_linear_ranges)
 			ret = regulator_desc_list_voltage_linear_range(desc, i);
diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index b1c0963586ac..c775016fab3c 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -41,7 +41,7 @@ static const struct linear_range tps6287x_voltage_ranges[] = {
 };
 
 static const unsigned int tps6287x_voltage_range_sel[] = {
-	0x0, 0x4, 0x8, 0xC
+	0x0, 0x1, 0x2, 0x3
 };
 
 static const unsigned int tps6287x_ramp_table[] = {
@@ -122,7 +122,7 @@ static struct regulator_desc tps6287x_reg = {
 	.n_voltages = 256,
 	.linear_ranges = tps6287x_voltage_ranges,
 	.n_linear_ranges = ARRAY_SIZE(tps6287x_voltage_ranges),
-	.linear_range_selectors = tps6287x_voltage_range_sel,
+	.linear_range_selectors_bitfield = tps6287x_voltage_range_sel,
 };
 
 static int tps6287x_i2c_probe(struct i2c_client *i2c)
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index c6ef7d68eb9a..4b7eceb3828b 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -292,11 +292,12 @@ enum regulator_type {
  * @ramp_delay: Time to settle down after voltage change (unit: uV/us)
  * @min_dropout_uV: The minimum dropout voltage this regulator can handle
  * @linear_ranges: A constant table of possible voltage ranges.
- * @linear_range_selectors: A constant table of voltage range selectors.
- *			    If pickable ranges are used each range must
- *			    have corresponding selector here.
+ * @linear_range_selectors_bitfield: A constant table of voltage range
+ *                                   selectors as bitfield values. If
+ *                                   pickable ranges are used each range
+ *                                   must have corresponding selector here.
  * @n_linear_ranges: Number of entries in the @linear_ranges (and in
- *		     linear_range_selectors if used) table(s).
+ *		     linear_range_selectors_bitfield if used) table(s).
  * @volt_table: Voltage mapping table (if table based mapping)
  * @curr_table: Current limit mapping table (if table based mapping)
  *
@@ -384,7 +385,7 @@ struct regulator_desc {
 	int min_dropout_uV;
 
 	const struct linear_range *linear_ranges;
-	const unsigned int *linear_range_selectors;
+	const unsigned int *linear_range_selectors_bitfield;
 
 	int n_linear_ranges;
 
-- 
2.41.0.455.g037347b96a-goog

