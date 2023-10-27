Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F387D9CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbjJ0P2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjJ0P2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:28:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7818A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:28:37 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso30994001fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1698420515; x=1699025315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXUmekLw1GEFnBbnbx9xiufl4bE1wbCiB6K9UiIw9hY=;
        b=OlbMcgqbh9KDvhDSF2SUUn2kTEG67Vmq5a9kte9IVj9PFZvfhLeFsKncbF6/+Jjs8U
         KZFxUf2KE+KJyV16k6HG7JYqY6BgJlcYSfbjhrAwY4vWGcTZdIopmzf2p08Yq2ke2zmZ
         YUjRq+edna3NcrKZ7yp2gYkzdpGyIpGIw6q9L3YvbiNoUozd8YtgG3tEFbX5PMUnS2sA
         f5EpFne4UOgdt+qAhLPN6erMHGEqeuqMEwaK2SMXlX1GnromhnmwWQPoVzxaymGJ9vKw
         LfF1nvp9kwJ8gNN3mFWMobM1lVn/WOCnNZbK28HmfgEAbq1MXxRajQyN6+I4vWjQgpCx
         s0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698420515; x=1699025315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXUmekLw1GEFnBbnbx9xiufl4bE1wbCiB6K9UiIw9hY=;
        b=QaFRMBBgC7N0UJYythSxcxqlnQfX2sSHjUNB6dko/mjD3biry2jCcjKD6zb9eqIiWl
         N6QeEXDbP0AhkF83Cej8P8UsB7oa8occvicJWQi3dAL7M8rqLwAL4ziaag05GvfHALJN
         ODJtOmJJ05KTzNUoqfsL6ZcnJkouJsJI5PKf+ExnAsrzuQhTphC4q/apPfUO6j3IOLEt
         atKeL7O+cf/fB9ZVz3u6hMnx+TWsLlmHU+eLE7Vs3W/ZE5xsSOONeMMh2C0Y5tSnW5dE
         SQxewV6ZRmy5DZPTNbM9OHZjRD7ODgpE4QY/SfVeShtacCYYBe0ngE+eY31KqmYEfErJ
         v6HA==
X-Gm-Message-State: AOJu0YzUssZhXvMmzFdPMYa78lfgrh/5TS0sdQoRIpqDHm1fBePwAbnD
        wVZzR5pzvCBRUEpY1mn7I7iFmQ==
X-Google-Smtp-Source: AGHT+IFPPkTC206+yrjoVKX7YSoR1y3QWKxomFd5kE0Tx1waO2OJORc3Xr55GOT+zRwc9FpDwOYWxw==
X-Received: by 2002:a05:651c:b9f:b0:2c5:623:aa01 with SMTP id bg31-20020a05651c0b9f00b002c50623aa01mr2018337ljb.49.1698420514939;
        Fri, 27 Oct 2023 08:28:34 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b0040836519dd9sm1902688wmo.25.2023.10.27.08.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:28:34 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v6 1/2] regulator (max5970): Add hwmon support
Date:   Fri, 27 Oct 2023 15:28:28 +0000
Message-ID: <20231027152830.1269895-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
and current monitoring. This feature is seamlessly integrated through
the hwmon subsystem.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
Change in V6:
- Remove unrelated change
- Add necessary return value check
- Remove unneeded NULL check
Changes in V5:
- Simplify memory allocation for rdevs
Changes in V4:
- Use IS_REACHABLE
- Use rdevs array for hwmon ops.
- Remove duplicate i2c_set_clientdata
Changes in V3:
- Update signed-off
- Add break
- Update hwmon dev register name to max5970
- Remove changes in Kconfig.
Changes in V2:
- default case added for switch statement
- Add dependency on HWMON
---
 drivers/regulator/max5970-regulator.c | 144 +++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index b56a174cde3d..56cc56ae63b7 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/hwmon.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -32,6 +33,132 @@ enum max597x_regulator_id {
 	MAX597X_SW1,
 };
 
+static int max5970_read_adc(struct regmap *regmap, int reg, long *val)
+{
+	u8 reg_data[2];
+	int ret;
+
+	ret = regmap_bulk_read(regmap, reg, &reg_data[0], 2);
+	if (ret < 0)
+		return ret;
+
+	*val = (reg_data[0] << 2) | (reg_data[1] & 3);
+
+	return 0;
+}
+
+static int max5970_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct regulator_dev **rdevs = dev_get_drvdata(dev);
+	struct max5970_regulator *ddata = rdev_get_drvdata(rdevs[channel]);
+	struct regmap *regmap = ddata->regmap;
+	int ret;
+
+	switch (type) {
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			ret = max5970_read_adc(regmap, MAX5970_REG_CURRENT_H(channel), val);
+			if (ret < 0)
+				return ret;
+			/*
+			 * Calculate current from ADC value, IRNG range & shunt resistor value.
+			 * ddata->irng holds the voltage corresponding to the maximum value the
+			 * 10-bit ADC can measure.
+			 * To obtain the output, multiply the ADC value by the IRNG range (in
+			 * millivolts) and then divide it by the maximum value of the 10-bit ADC.
+			 */
+			*val = (*val * ddata->irng) >> 10;
+			/* Convert the voltage meansurement across shunt resistor to current */
+			*val = (*val * 1000) / ddata->shunt_micro_ohms;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			ret = max5970_read_adc(regmap, MAX5970_REG_VOLTAGE_H(channel), val);
+			if (ret < 0)
+				return ret;
+			/*
+			 * Calculate voltage from ADC value and MON range.
+			 * ddata->mon_rng holds the voltage corresponding to the maximum value the
+			 * 10-bit ADC can measure.
+			 * To obtain the output, multiply the ADC value by the MON range (in
+			 * microvolts) and then divide it by the maximum value of the 10-bit ADC.
+			 */
+			*val = mul_u64_u32_shr(*val, ddata->mon_rng, 10);
+			/* uV to mV */
+			*val = *val / 1000;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t max5970_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	struct regulator_dev **rdevs = (struct regulator_dev **)data;
+	struct max5970_regulator *ddata;
+
+	if (channel >= MAX5970_NUM_SWITCHES || !rdevs[channel])
+		return 0;
+
+	ddata = rdev_get_drvdata(rdevs[channel]);
+
+	if (channel >= ddata->num_switches)
+		return 0;
+
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			/* Current measurement requires knowledge of the shunt resistor value. */
+			if (ddata->shunt_micro_ohms)
+				return 0444;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_ops max5970_hwmon_ops = {
+	.is_visible = max5970_is_visible,
+	.read = max5970_read,
+};
+
+static const struct hwmon_channel_info *max5970_info[] = {
+	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT, HWMON_I_INPUT),
+	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT, HWMON_C_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info max5970_chip_info = {
+	.ops = &max5970_hwmon_ops,
+	.info = max5970_info,
+};
+
 static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
 {
 	int ret, reg;
@@ -431,7 +558,8 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
+	struct regulator_dev **rdevs = NULL;
+	struct device *hwmon_dev;
 	int num_switches;
 	int ret, i;
 
@@ -442,6 +570,11 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	if (!max597x)
 		return -ENOMEM;
 
+	rdevs = devm_kcalloc(&i2c->dev, MAX5970_NUM_SWITCHES, sizeof(struct regulator_dev *),
+			     GFP_KERNEL);
+	if (!rdevs)
+		return -ENOMEM;
+
 	i2c_set_clientdata(i2c, max597x);
 
 	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
@@ -485,6 +618,15 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
 	}
 
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970", rdevs,
+								 &max5970_chip_info, NULL);
+		if (IS_ERR(hwmon_dev)) {
+			return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev),
+					     "Unable to register hwmon device\n");
+		}
+	}
+
 	if (i2c->irq) {
 		ret =
 		    max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,

base-commit: e95d9ba0eb4ef2f9f7fa0451c3ad4f77c685538d
-- 
2.41.0

