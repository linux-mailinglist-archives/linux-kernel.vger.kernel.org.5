Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C05787008
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbjHXNOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbjHXNNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:13:54 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7519A9;
        Thu, 24 Aug 2023 06:13:52 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 49E5A8CC65D; Thu, 24 Aug 2023 15:13:51 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] power: supply: bq24190_charger: Export current regulator
Date:   Thu, 24 Aug 2023 15:13:31 +0200
Message-ID: <20230824131342.206784-4-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824131342.206784-1-linkmauve@linkmauve.fr>
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
 <20230824131342.206784-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Courbot <acourbot@nvidia.com>

This prevents the charger from ever going over the current limit.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/power/supply/bq24190_charger.c | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index a56122b39687..cc1bd87f4982 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -530,6 +530,79 @@ static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
 }
 
 #ifdef CONFIG_REGULATOR
+static int bq24190_set_charging_current(struct regulator_dev *dev,
+			int min_uA, int max_uA)
+{
+	struct bq24190_dev_info *bdi = rdev_get_drvdata(dev);
+	u8 ss_reg;
+	int in_current_limit;
+	int ret = 0;
+
+	ret = bq24190_read(bdi, BQ24190_REG_SS, &ss_reg);
+	if (ret < 0)
+		goto error;
+
+	if (max_uA == 0 && ss_reg != 0)
+		return ret;
+
+	if (!(ss_reg & BQ24190_REG_SS_VBUS_STAT_MASK))
+		in_current_limit = 500;
+	else
+		in_current_limit = max_uA / 1000;
+
+	return bq24190_set_field_val(bdi, BQ24190_REG_ISC,
+			BQ24190_REG_ISC_IINLIM_MASK,
+			BQ24190_REG_ISC_IINLIM_SHIFT,
+			bq24190_isc_iinlim_values,
+			ARRAY_SIZE(bq24190_isc_iinlim_values),
+			in_current_limit);
+error:
+	dev_err(bdi->dev, "Charger enable failed, err = %d\n", ret);
+	return ret;
+}
+
+static const struct regulator_ops bq24190_chrg_ops = {
+	.set_current_limit = bq24190_set_charging_current,
+};
+
+static const struct regulator_desc bq24190_chrg_desc = {
+	.name = "charger",
+	.of_match = "charger",
+	.type = REGULATOR_CURRENT,
+	.owner = THIS_MODULE,
+	.ops = &bq24190_chrg_ops,
+};
+
+static const struct regulator_init_data bq24190_chrg_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS | REGULATOR_CHANGE_CURRENT,
+		.min_uA = 0,
+		.max_uA = 3000000,
+	},
+};
+
+static int bq24190_register_chrg_regulator(struct bq24190_dev_info *bdi)
+{
+	struct bq24190_platform_data *pdata = bdi->dev->platform_data;
+	struct regulator_config cfg = { };
+	struct regulator_dev *reg;
+	int ret = 0;
+
+	cfg.dev = bdi->dev;
+	if (pdata && pdata->regulator_init_data)
+		cfg.init_data = pdata->regulator_init_data;
+	else
+		cfg.init_data = &bq24190_chrg_init_data;
+	cfg.driver_data = bdi;
+	reg = devm_regulator_register(bdi->dev, &bq24190_chrg_desc, &cfg);
+	if (IS_ERR(reg)) {
+		ret = PTR_ERR(reg);
+		dev_err(bdi->dev, "Can't register regulator: %d\n", ret);
+	}
+
+	return ret;
+}
+
 static int bq24190_vbus_enable(struct regulator_dev *dev)
 {
 	return bq24190_set_otg_vbus(rdev_get_drvdata(dev), true);
@@ -611,6 +684,11 @@ static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
 	return ret;
 }
 #else
+static int bq24190_register_chrg_regulator(struct bq24190_dev_info *bdi)
+{
+	return 0;
+}
+
 static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
 {
 	return 0;
@@ -1879,6 +1957,10 @@ static int bq24190_probe(struct i2c_client *client)
 		goto out_charger;
 	}
 
+	ret = bq24190_register_chrg_regulator(bdi);
+	if (ret < 0)
+		goto out_charger;
+
 	ret = bq24190_register_vbus_regulator(bdi);
 	if (ret < 0)
 		goto out_charger;
-- 
2.42.0

