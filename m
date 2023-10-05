Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E4B7BA6DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjJEQm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjJEQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:40:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC2583C4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 00:55:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4065f29e933so6341555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696492515; x=1697097315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIE9AYbwv3uO7JusWOFs6HN5AgKZjN9zYhECnYhLFZY=;
        b=SWib971NI2mAcO9WQzSqQJQoEGTiGRGupJTSJKrxh+N0kHUnh6uwpXrt+OjBiG2Qpy
         SOVQzNySLDdXB3f9map5ISUZk+nvdn6zJpvGK2LSlPC3DsxPq6vkFKr7KmQe4mHmY9I0
         gUjzRVQ/QeyCuHKJljyTZfhrHJf9WurzSxX+QrIMGeOVumy0XdlxRNZ5PkLWGtlhMwO/
         Qsjao2Tjwc+HsEQ8tK+BqboZUA0K9q0hbDDektpr7XT3YR1atpZgfH5mpnf2FxxmHtBN
         EQUMam5T7U41u1u82fCDrNDTRUbf9n0NZ7Oaki9vdhiskPGaevJ3zxEPLJyaYzY+3ZQg
         dhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696492515; x=1697097315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIE9AYbwv3uO7JusWOFs6HN5AgKZjN9zYhECnYhLFZY=;
        b=eFpDp4kUj1w+egQj1vwpO5fSD806EOBclAVS0pnsQgYKCUeQ9xod5H+NJgwjvYs5Zj
         9O+Fc+FrWHD1O/emtiBb044lN0XMO7xBRP/JvvL/n2PB3r3IXRVCsX5MnpglBffY2aQ9
         j2L3YfQeE4YVzaIpJAyScj66/1Zfpaoyvxtu/uAQbB1jdrniaac7H+tB61s4sMFQ9cYX
         oRBnGrLFBclbogySi1fvfTprmnLRuwS/uMINfimqbAkg26jNkC7PpJ/8OsyCI6H85Iip
         YL8MXeQ8zi+K4DuTgK7ipETJ5sR0mfAP8nByKl5kM1ukAZFJDgagWs/E9p11jLsU6Jw5
         NB5w==
X-Gm-Message-State: AOJu0Yz/AJrLD/Nlr2ajgj0/NXo+GtlEQzAkVxuQhUBnz5KOWx6mVYEG
        q3aDEnj8ukTAac9Sfl+bVcYlXw==
X-Google-Smtp-Source: AGHT+IGNs0P3pnQfrPe7X4SUjWLXJDmDDg7Ujm36ZvHi/c9e5rbMzp9ZhK3w+OwtehRUjv9tg/yr/g==
X-Received: by 2002:a05:600c:44f:b0:3fe:1f93:8cf4 with SMTP id s15-20020a05600c044f00b003fe1f938cf4mr4317110wmb.8.1696492514545;
        Thu, 05 Oct 2023 00:55:14 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b00405623e0186sm3178648wmc.26.2023.10.05.00.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:55:14 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v5] regulator (max5970): Add hwmon support
Date:   Thu,  5 Oct 2023 09:55:07 +0200
Message-ID: <20231005075508.1656071-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/regulator/max5970-regulator.c | 141 +++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index b56a174cde3d..71b4a543339a 100644
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
@@ -32,6 +33,128 @@ enum max597x_regulator_id {
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
+			return ret;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			ret = max5970_read_adc(regmap, MAX5970_REG_VOLTAGE_H(channel), val);
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
+			return ret;
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
+	if (!ddata || channel >= ddata->num_switches)
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
@@ -431,7 +554,8 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
+	struct regulator_dev **rdevs = NULL;
+	struct device *hwmon_dev;
 	int num_switches;
 	int ret, i;
 
@@ -442,6 +566,11 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	if (!max597x)
 		return -ENOMEM;
 
+	rdevs = devm_kcalloc(&i2c->dev, MAX5970_NUM_SWITCHES, sizeof(struct regulator_dev *),
+			     GFP_KERNEL);
+	if (!rdevs)
+		return -ENOMEM;
+
 	i2c_set_clientdata(i2c, max597x);
 
 	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
@@ -451,7 +580,6 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
-	i2c_set_clientdata(i2c, max597x);
 	num_switches = max597x->num_switches;
 
 	for (i = 0; i < num_switches; i++) {
@@ -485,6 +613,15 @@ static int max597x_regulator_probe(struct platform_device *pdev)
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

base-commit: f9a1d31874c383f58bb4f89bfe79b764682cd026
-- 
2.41.0

