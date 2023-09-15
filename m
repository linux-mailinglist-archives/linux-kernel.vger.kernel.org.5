Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B605F7A1F14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjIOMpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjIOMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:45:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7004D2119
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:45:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-501bd164fbfso3421945e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694781923; x=1695386723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64O685rh5/+WceyOWRqSka2vt/nlTOc2EOjMCPDPopw=;
        b=U/ZozT7GKehDBYdy0Zs8M0i/4/8GZF3brPwcRU8Ccc9xV9Q6P544HU7/rLkCGuxO9l
         NzuuhilY5zAkXjleWAsdiTpEZFP55MPtuEPk5o/SE/NOoHo+yhz74kKKnNeWEYQqjs5S
         hWp+/zsBiE18IQONgz2gS4aNW2lcU9loqcp+kYsDVNOF0zCwk55JBKbv2JmFOtzufeGC
         /vC6siAcz+n/xks6IVMw11UYt9dLzIhdNXhkmNvpUC1ArygBVFPe/AgpHNiX7vEbW/Uf
         HZnGmpbZmASAgp2gkZh/OrIcaZmnrMOvisRfdBPam0avM8SZ8ubkN9FR5zyJ/awVWKDm
         u2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694781923; x=1695386723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64O685rh5/+WceyOWRqSka2vt/nlTOc2EOjMCPDPopw=;
        b=eSpuTYwjJc++0Ocj+BX6IM5XmaOxEguVcKRijxHKbnk+e4SqxwLvm3czI63K8dHA2Y
         wrFtBkVU0BNSgxnmmYZyudOfSjCoFkkPJDqL5Ac83Qlp+A0hma9fOMQxWtlmw6z8oLso
         ZqefyyAZAzFk/TiMJSEor/CUhl6Mt+D2dmhN3ZvHHDHCb/bCGD3YKf3ts0PjunicEfme
         J86zSK+BkPQDFNIosPXq3EoA6EeF+cKa9Q4KILF9x7OmU3rW1K3fODq5TW1FvurKymmG
         zlEIy+u5SY44uk8saSdkDxeRkHMGbFoCw3+nC7zv167MMvg8ZpfSkafFG6fx5wS3nq+D
         7BEQ==
X-Gm-Message-State: AOJu0YwaZeUMbL31fwM0Zv+aiQdwCjKK8QxvuFRucIqf/9hJ45t46gcs
        BTxUS1Ozd0gsLq9+oeGWVfGg9XZLNKjwAI8DKqJgMQ==
X-Google-Smtp-Source: AGHT+IGkDHYgV3kip0earhW8qVm96bbTxU9pilKgNREClOMWLZF8yMLIOibZL5pocXowUiXj3+h0pQ==
X-Received: by 2002:a19:4f5b:0:b0:500:be66:e014 with SMTP id a27-20020a194f5b000000b00500be66e014mr1336911lfk.53.1694781922641;
        Fri, 15 Sep 2023 05:45:22 -0700 (PDT)
Received: from [10.167.154.1] ([2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b004fe37199b87sm624752lfh.156.2023.09.15.05.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:45:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 15 Sep 2023 14:45:17 +0200
Subject: [PATCH v4 3/3] power: supply: Introduce MM8013 fuel gauge driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v4-3-975aecd173ed@linaro.org>
References: <20230621-topic-mm8013-v4-0-975aecd173ed@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v4-0-975aecd173ed@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694781917; l=10560;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/d00LHDio/XkeskUxaF8XCxl9oQdSy+AyWbT9L2roW0=;
 b=nUMXPvy/czZfkY9otvDRLjk8nchC3JmwdJnGvA6TDWNWwUtMhn6KngmjWwoK7tuiKWy56aRT5
 hAi9qGu/4TmBjX00GjHRDpKTpAME0N+jMHc+fGFInsPz6ohB7ELvvCV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Mitsumi MM8013 fuel gauge. The driver is a vastly
cleaned up and improved version of the one that shipped in some obscure
Lenovo downstream kernel [1], with some register definitions borrowed from
ChromeOS EC platform code [2].

[1] https://github.com/adazem009/kernel_lenovo_bengal/commit/b6b346427a871715709bd22aae449b9383f3b66b
[2] https://chromium.googlesource.com/chromiumos/platform/ec/+/master/driver/battery/mm8013.h
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---
uevent dump as of v4:
POWER_SUPPLY_NAME=mm8013
POWER_SUPPLY_TYPE=Battery
POWER_SUPPLY_CAPACITY=100
POWER_SUPPLY_CHARGE_FULL=7124000
POWER_SUPPLY_CHARGE_FULL_DESIGN=7500000
POWER_SUPPLY_CURRENT_NOW=0
POWER_SUPPLY_CYCLE_COUNT=27
POWER_SUPPLY_HEALTH=Good
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_STATUS=Full
POWER_SUPPLY_TEMP=300
POWER_SUPPLY_TIME_TO_EMPTY_AVG=888
POWER_SUPPLY_VOLTAGE_NOW=4402000
---
 MAINTAINERS                   |   5 +
 drivers/power/supply/Kconfig  |   9 ++
 drivers/power/supply/Makefile |   1 +
 drivers/power/supply/mm8013.c | 274 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 289 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa7487b7729b..555403b9f011 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14409,6 +14409,11 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-miropcm20*
 
+MITSUMI MM8013 FG DRIVER
+M:	Konrad Dybcio <konradybcio@kernel.org>
+F:	Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
+F:	drivers/power/supply/mm8013.c
+
 MMP SUPPORT
 R:	Lubomir Rintel <lkundrak@v3.sk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 0c80c68fb0d7..3ef608d010f9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -952,4 +952,13 @@ config CHARGER_QCOM_SMB2
 	  adds support for the SMB2 switch mode battery charger found
 	  in PMI8998 and related PMICs.
 
+config FUEL_GAUGE_MM8013
+	tristate "Mitsumi MM8013 fuel gauge driver"
+	depends on I2C
+	help
+	  Say Y here to enable the Mitsumi MM8013 fuel gauge driver.
+	  It enables the monitoring of many battery parameters, including
+	  the state of charge, temperature, cycle count, actual and design
+	  capacity, etc.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index a8a9fa6de1e9..ba2c41f060be 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -111,3 +111,4 @@ obj-$(CONFIG_BATTERY_SURFACE)	+= surface_battery.o
 obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_pmi8998_charger.o
+obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
new file mode 100644
index 000000000000..bd8d54d6597f
--- /dev/null
+++ b/drivers/power/supply/mm8013.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#define REG_BATID			0x00 /* This one is very unclear */
+ #define BATID_101			0x0101 /* 107kOhm */
+ #define BATID_102			0x0102 /* 10kOhm */
+#define REG_TEMPERATURE			0x06
+#define REG_VOLTAGE			0x08
+#define REG_FLAGS			0x0a
+ #define MM8013_FLAG_OTC		BIT(15)
+ #define MM8013_FLAG_OTD		BIT(14)
+ #define MM8013_FLAG_BATHI		BIT(13)
+ #define MM8013_FLAG_FC			BIT(9)
+ #define MM8013_FLAG_CHG		BIT(8)
+ #define MM8013_FLAG_DSG		BIT(0)
+#define REG_FULL_CHARGE_CAPACITY	0x0e
+#define REG_AVERAGE_CURRENT		0x14
+#define REG_AVERAGE_TIME_TO_EMPTY	0x16
+#define REG_AVERAGE_TIME_TO_FULL	0x18
+#define REG_CYCLE_COUNT			0x2a
+#define REG_STATE_OF_CHARGE		0x2c
+#define REG_DESIGN_CAPACITY		0x3c
+/* TODO: 0x62-0x68 seem to contain 'MM8013C' in a length-prefixed, non-terminated string */
+
+#define DECIKELVIN_TO_DECIDEGC(t)	(t - 2731)
+
+struct mm8013_chip {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+static int mm8013_checkdevice(struct mm8013_chip *chip)
+{
+	int battery_id, ret;
+	u32 val;
+
+	ret = regmap_write(chip->regmap, REG_BATID, 0x0008);
+	if (ret < 0)
+		return ret;
+
+	regmap_read(chip->regmap, REG_BATID, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val == BATID_102)
+		battery_id = 2;
+	else if (val == BATID_101)
+		battery_id = 1;
+	else
+		return -EINVAL;
+
+	dev_dbg(&chip->client->dev, "battery_id: %d\n", battery_id);
+
+	return 0;
+}
+
+static enum power_supply_property mm8013_battery_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+static int mm8013_get_property(struct power_supply *psy,
+			       enum power_supply_property psp,
+			       union power_supply_propval *val)
+{
+	struct mm8013_chip *chip = psy->drv_data;
+	int ret = 0;
+	u32 regval;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = regmap_read(chip->regmap, REG_STATE_OF_CHARGE, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = regval;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		ret = regmap_read(chip->regmap, REG_FULL_CHARGE_CAPACITY, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = 1000 * regval;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		ret = regmap_read(chip->regmap, REG_DESIGN_CAPACITY, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = 1000 * regval;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = regmap_read(chip->regmap, REG_AVERAGE_CURRENT, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = -1000 * (s16)regval;
+		break;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		ret = regmap_read(chip->regmap, REG_CYCLE_COUNT, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = regval;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = regmap_read(chip->regmap, REG_FLAGS, &regval);
+		if (ret < 0)
+			return ret;
+
+		if (regval & MM8013_FLAG_BATHI)
+			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		else if (regval & (MM8013_FLAG_OTD | MM8013_FLAG_OTC))
+			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
+		else
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = regmap_read(chip->regmap, REG_TEMPERATURE, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ((s16)regval > 0);
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = regmap_read(chip->regmap, REG_FLAGS, &regval);
+		if (ret < 0)
+			return ret;
+
+		if (regval & MM8013_FLAG_DSG)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (regval & MM8013_FLAG_CHG)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (regval & MM8013_FLAG_FC)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = regmap_read(chip->regmap, REG_TEMPERATURE, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = DECIKELVIN_TO_DECIDEGC(regval);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
+		ret = regmap_read(chip->regmap, REG_AVERAGE_TIME_TO_EMPTY, &regval);
+		if (ret < 0)
+			return ret;
+
+		/* The estimation is not yet ready */
+		if (regval == U16_MAX)
+			return -ENODATA;
+
+		val->intval = regval;
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
+		ret = regmap_read(chip->regmap, REG_AVERAGE_TIME_TO_FULL, &regval);
+		if (ret < 0)
+			return ret;
+
+		/* The estimation is not yet ready */
+		if (regval == U16_MAX)
+			return -ENODATA;
+
+		val->intval = regval;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = regmap_read(chip->regmap, REG_VOLTAGE, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = 1000 * regval;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct power_supply_desc mm8013_desc = {
+	.name			= "mm8013",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= mm8013_battery_props,
+	.num_properties		= ARRAY_SIZE(mm8013_battery_props),
+	.get_property		= mm8013_get_property,
+};
+
+static const struct regmap_config mm8013_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0x68,
+	.use_single_read = true,
+	.use_single_write = true,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int mm8013_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &client->dev;
+	struct power_supply *psy;
+	struct mm8013_chip *chip;
+	int ret = 0;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return dev_err_probe(dev, -EIO,
+				     "I2C_FUNC_SMBUS_WORD_DATA not supported\n");
+
+	chip = devm_kzalloc(dev, sizeof(struct mm8013_chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->client = client;
+
+	chip->regmap = devm_regmap_init_i2c(client, &mm8013_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(dev, ret, "Couldn't initialize regmap\n");
+
+	ret = mm8013_checkdevice(chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "MM8013 not found\n");
+
+	psy_cfg.drv_data = chip;
+	psy_cfg.of_node = dev->of_node;
+
+	psy = devm_power_supply_register(dev, &mm8013_desc, &psy_cfg);
+	if (IS_ERR(psy))
+		return PTR_ERR(psy);
+
+	return 0;
+}
+
+static const struct i2c_device_id mm8013_id_table[] = {
+	{ "mm8013", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mm8013_id_table);
+
+static const struct of_device_id mm8013_match_table[] = {
+	{ .compatible = "mitsumi,mm8013" },
+	{}
+};
+
+static struct i2c_driver mm8013_i2c_driver = {
+	.probe = mm8013_probe,
+	.id_table = mm8013_id_table,
+	.driver = {
+		.name = "mm8013",
+		.of_match_table = mm8013_match_table,
+	},
+};
+module_i2c_driver(mm8013_i2c_driver);
+
+MODULE_DESCRIPTION("MM8013 fuel gauge driver");
+MODULE_LICENSE("GPL");

-- 
2.42.0

