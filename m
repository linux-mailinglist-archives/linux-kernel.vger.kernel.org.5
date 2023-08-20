Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1DD781DD9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjHTMsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjHTMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:48:23 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA3E7;
        Sun, 20 Aug 2023 05:47:32 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RTFkV3Q18z9sp8;
        Sun, 20 Aug 2023 14:47:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1692535650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=BmfEc1dauESu/l54vOpG6u6qG7YRnDDmGZk3JLEI+Uc=;
        b=PVaPk924B2N6AWZqVRFE8FL5vZRR08M4Yq7KcK5Vxh6EjMReVnaPPx/jSLipnUoDZC7Yiv
        LDQbmRcNu4E2l8MoJejF2xv8k4cb14i9Iwb69GKILuJmNAPs4n00oqrgAYK0Zk+tViwkQ/
        Z4zCNQvutcR1zS9VVMW8ayLZwabJtBtWFXjZtmAziIXgTU3f1Y6zURMik5hVpmL1wYFFln
        MCoUw2oYtKIiPBqCfLMPdAnNX+9jylTwm/4iEQbGmzgrfoP1iKbDZHp/9pWT04LAhu6L7n
        mizhX2/ic3fBLjUYVxinMI5vs7Txo7pf/tUX3gF9hwL3oHE3Jdjio3mZueE3kw==
Date:   Sun, 20 Aug 2023 14:47:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1692535648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=BmfEc1dauESu/l54vOpG6u6qG7YRnDDmGZk3JLEI+Uc=;
        b=HN2rcbxnzhXk6e1FYDSi5LiEU+r1EoAwSiwOjV1HZZbjyk1P2qpDeBMDfp6p0PdvmGFxPQ
        yJs7zd+5Ysh1jsuDp1kRhrIz/6HdyssWnHDqiUlMN8/cLTQ2yh0BOBvnmb1l0jdGah4bhH
        1UIDWCAZYzOLkvPowITuYYw0HrgJG1iJlCItyzJ6jpzM3H2vMgV48+viTLzGeS9OktCu/L
        gwAK+L7sgDmHnQUViDgr6zDH8C9h+v3YGT2UEwA+jJlzN1SHvrH4pd30SICvqWM/BmcdY0
        nzOVKdhFUF17iiMM6I7vW2ytyIRgau+2n7Gw6/C7Izh3qW0QMw6/BKpbXKiUCQ==
From:   Loic Guegan <loic.guegan@mailbox.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: Add support for the INA260 chip to the INA219 and
 compatibles driver
Message-ID: <ZOILXb-1ObJRB1ck@lguegan-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Developer-Signature: v=1; a=openpgp-sha256; l=7412;
 i=loic.guegan@mailbox.org; h=from:subject;
 bh=k1A3/IqlkjkqzbLSro6/QO4DHjr4fiFwqaMD/U8WevI=;
 b=owNCWmg2MUFZJlNZfBv5zwAAuP///3/7/3//+r//+/97//5v/73//9///n+T/f//v//9u/9AA
 b3Orjpxk1BqbSaMIekemQmRk09TQZNomAEY1NMaJ6I2RHqMDQZTNR6aaGj1EbRHojJpkzQ0mmJm
 iYTE0aeKemofqnqeSZMmMU21E2QgNAAAA09QGgAAGgA9QNAAANAANDQAaANAAAAAAGgABoAABoP
 UBoaNAgAGgNA0NAGg0AABoAAAAaBoANNBoAaNGgAADQaAAaPUAAANAAAABoMh0MgeoAaaAAAADI
 AAAAAAyAAAAADIDQAAaANDQDQAAAAAABoGR6gYMUAGiRZEOigcbizCCRvzFWClEGe0yKw/eA/YJ
 suhokkOJhy1d9J6MEGWx73BBAQyrBtoRExmwMjh4v4ZQC/SlFeWxNUxJqwh9CxRkv/lMRILS3s2
 4x8kqJXO9qsElTyCJrGCHMNNCfR0u9g+lL5PVmQT0re6FICGPa40GbdClpGHUtEKqOzpPdQp3hB
 +wYXW9LDdNTFcwASk7DEkN7xRbWxmF2T0pjBEcsHzofC30SadYUHORxJFhFOM1raGTLQwHRZKtn
 7Fpz3DAExcXOZrObt7b5lChg4doj0cnST4w4UESHA9z1+495LiiDmYjhgNcBj9w59IQ5DlEba8B
 g/2VbTPpOCGQMLpIlM+SQIQTXU4qyNJQhUqL1Dsm55qNca5JYOuHn0aYytmMF8k1+yqWqABq0Ao
 2pwxikpQIcV1zYAnhTZAXj84wsRGRS61ZX8XdpQ7V41lFDLkusdAf2AZAKoTH09kXAbv8hHlVWT
 c/bpBAr/2J9xUyvWUQgS5Ehrx6ka88wH2aum0vBZ7NnaPT85RsIXJkLoaVMOlthYCzJHmNxd9k6
 zkPmb8gRwSn+FGA6B9DljFtqaBREE5JhSoJQUoJMsQFnenXvE+WNmVAwQpgCXkNnbSK9jzeoRRf
 kfTJVfX3s/gy5NjeqdDVOz5GNK8MUYyi0hSFwPoCgeUAtWUSIFV4BAm70Y4qwe7x2XrSikZrdK/
 35bzFmcLJBBrB6iU4tm7HjjQ+kw/eOm4/UipqxfQw1v6oYgXXnPMZSQC+ff4u5IpwoSD4N/OeA=
 =
X-Developer-Key: i=loic.guegan@mailbox.org; a=openpgp;
 fpr=73F4BD8CF0BF09D3CD3FEDB08D888D2184B6227F
X-MBO-RS-META: oga9sdcjh7u1w158cwp1w7qt3hcpqes6
X-MBO-RS-ID: 498c287df9f14bcd83c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to retrieve current, bus voltage and power
measurements from the INA260 using its default configuration.

As the INA260 provides integrated shunt, the "ishunt" configuration
parameter is introduced. As such, proper attributes can be attached
with hwmon and shunt calibration related routnies can be ignored. In
addition, the actual INA2XX current register address differ from the
INA260 as it does not provide a shunt register. Thus, a specific
register address INA2XX_CURRENT_ISHUNT for chips with integrated
shunts is proposed.

Signed-off-by: Loic Guegan <loic.guegan@mailbox.org>
---
 drivers/hwmon/Kconfig  |  2 +-
 drivers/hwmon/ina2xx.c | 77 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 307477b8a371..69b75a62c1cf 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2022,7 +2022,7 @@ config SENSORS_INA2XX
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for INA219, INA220, INA226,
-	  INA230, and INA231 power monitor chips.
+	  INA230, INA231 and INA260 power monitor chips.
 
 	  The INA2xx driver is configured for the default configuration of
 	  the part as described in the datasheet.
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index cfd7efef5cdf..e0b9604ae0b7 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -45,6 +45,7 @@
 #define INA2XX_BUS_VOLTAGE		0x02 /* readonly */
 #define INA2XX_POWER			0x03 /* readonly */
 #define INA2XX_CURRENT			0x04 /* readonly */
+#define INA2XX_CURRENT_ISHUNT		0x01 /* readonly */
 #define INA2XX_CALIBRATION		0x05
 
 /* INA226 register definitions */
@@ -55,18 +56,22 @@
 /* register count */
 #define INA219_REGISTERS		6
 #define INA226_REGISTERS		8
+#define INA260_REGISTERS		8
 
 #define INA2XX_MAX_REGISTERS		8
 
 /* settings - depend on use case */
 #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
 #define INA226_CONFIG_DEFAULT		0x4527	/* averages=16 */
+#define INA260_CONFIG_DEFAULT		0x6127	/* default from datasheet */
 
 /* worst case is 68.10 ms (~14.6Hz, ina219) */
 #define INA2XX_CONVERSION_RATE		15
 #define INA2XX_MAX_DELAY		69 /* worst case delay in ms */
 
 #define INA2XX_RSHUNT_DEFAULT		10000
+#define INA2XX_CURRENT_LSB_uA_DEFAULT	1250
+#define INA2XX_POWER_LSB_uW_DEFAULT	10000
 
 /* bit mask for reading the averaging setting in the configuration register */
 #define INA226_AVG_RD_MASK		0x0E00
@@ -99,10 +104,11 @@ static struct regmap_config ina2xx_regmap_config = {
 	.val_bits = 16,
 };
 
-enum ina2xx_ids { ina219, ina226 };
+enum ina2xx_ids { ina219, ina226, ina260 };
 
 struct ina2xx_config {
 	u16 config_default;
+	u8 ishunt;				/* integrated shunt? */
 	int calibration_value;
 	int registers;
 	int shunt_div;
@@ -126,6 +132,7 @@ struct ina2xx_data {
 static const struct ina2xx_config ina2xx_config[] = {
 	[ina219] = {
 		.config_default = INA219_CONFIG_DEFAULT,
+		.ishunt = 0,
 		.calibration_value = 4096,
 		.registers = INA219_REGISTERS,
 		.shunt_div = 100,
@@ -135,6 +142,7 @@ static const struct ina2xx_config ina2xx_config[] = {
 	},
 	[ina226] = {
 		.config_default = INA226_CONFIG_DEFAULT,
+		.ishunt = 0,
 		.calibration_value = 2048,
 		.registers = INA226_REGISTERS,
 		.shunt_div = 400,
@@ -142,6 +150,14 @@ static const struct ina2xx_config ina2xx_config[] = {
 		.bus_voltage_lsb = 1250,
 		.power_lsb_factor = 25,
 	},
+	[ina260] = {
+		.config_default = INA260_CONFIG_DEFAULT,
+		.ishunt = 1,
+		.registers = INA260_REGISTERS,
+		.shunt_div = 1,
+		.bus_voltage_shift = 0,
+		.bus_voltage_lsb = 1250,
+	},
 };
 
 /*
@@ -201,7 +217,10 @@ static int ina2xx_init(struct ina2xx_data *data)
 	if (ret < 0)
 		return ret;
 
-	return ina2xx_calibrate(data);
+	if (!data->config->ishunt)
+		return ina2xx_calibrate(data);
+
+	return 0;
 }
 
 static int ina2xx_read_reg(struct device *dev, int reg, unsigned int *regval)
@@ -213,6 +232,10 @@ static int ina2xx_read_reg(struct device *dev, int reg, unsigned int *regval)
 
 	for (retry = 5; retry; retry--) {
 
+		/* Shunt register is used for current register when using integrated shunt */
+		if (data->config->ishunt && reg == INA2XX_CURRENT)
+			reg = INA2XX_CURRENT_ISHUNT;
+
 		ret = regmap_read(data->regmap, reg, regval);
 		if (ret < 0)
 			return ret;
@@ -227,7 +250,7 @@ static int ina2xx_read_reg(struct device *dev, int reg, unsigned int *regval)
 		 * We do that extra read of the calibration register if there
 		 * is some hint of a chip reset.
 		 */
-		if (*regval == 0) {
+		if (*regval == 0 && !data->config->ishunt) {
 			unsigned int cal;
 
 			ret = regmap_read(data->regmap, INA2XX_CALIBRATION,
@@ -594,6 +617,18 @@ static const struct attribute_group ina2xx_group = {
 	.attrs = ina2xx_attrs,
 };
 
+/* integrated shunt devices attributes */
+static struct attribute *ina2xx_ishunt_attrs[] = {
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_power1_input.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ina2xx_ishunt_group = {
+	.attrs = ina2xx_ishunt_attrs,
+};
+
 static struct attribute *ina226_attrs[] = {
 	&sensor_dev_attr_in0_crit.dev_attr.attr,
 	&sensor_dev_attr_in0_lcrit.dev_attr.attr,
@@ -637,16 +672,19 @@ static int ina2xx_probe(struct i2c_client *client)
 	data->config = &ina2xx_config[chip];
 	mutex_init(&data->config_lock);
 
-	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
-		struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
+	/* Devices with no integrated shunt */
+	if (!data->config->ishunt) {
+		if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
+			struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
 
-		if (pdata)
-			val = pdata->shunt_uohms;
-		else
-			val = INA2XX_RSHUNT_DEFAULT;
-	}
+			if (pdata)
+				val = pdata->shunt_uohms;
+			else
+				val = INA2XX_RSHUNT_DEFAULT;
+		}
 
-	ina2xx_set_shunt(data, val);
+		ina2xx_set_shunt(data, val);
+	}
 
 	ina2xx_regmap_config.max_register = data->config->registers;
 
@@ -666,9 +704,15 @@ static int ina2xx_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	data->groups[group++] = &ina2xx_group;
-	if (chip == ina226)
-		data->groups[group++] = &ina226_group;
+	if (data->config->ishunt) {
+		data->groups[group++] = &ina2xx_ishunt_group;
+		data->current_lsb_uA = INA2XX_CURRENT_LSB_uA_DEFAULT;
+		data->power_lsb_uW = INA2XX_POWER_LSB_uW_DEFAULT;
+	} else {
+		data->groups[group++] = &ina2xx_group;
+		if (chip == ina226)
+			data->groups[group++] = &ina226_group;
+	}
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, data->groups);
@@ -687,6 +731,7 @@ static const struct i2c_device_id ina2xx_id[] = {
 	{ "ina226", ina226 },
 	{ "ina230", ina226 },
 	{ "ina231", ina226 },
+	{ "ina260", ina260 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
@@ -712,6 +757,10 @@ static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
 		.compatible = "ti,ina231",
 		.data = (void *)ina226
 	},
+	{
+		.compatible = "ti,ina260",
+		.data = (void *)ina260
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ina2xx_of_match);
-- 
2.41.0

