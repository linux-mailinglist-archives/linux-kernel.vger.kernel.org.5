Return-Path: <linux-kernel+bounces-12608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D4881F7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F7E1C22113
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A748F79C3;
	Thu, 28 Dec 2023 11:30:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520E6FBD;
	Thu, 28 Dec 2023 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636821:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 28 Dec 2023 19:29:37 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 28 Dec
 2023 19:29:36 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Thu, 28 Dec 2023 19:29:36 +0800
From: <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
	ChiYuan Huang <cy_huang@richtek.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: adc: rtq6056: Add support for the whole RTQ6056 family
Date: Thu, 28 Dec 2023 19:29:35 +0800
Message-ID: <74db15583a9a68701dbff5a1a967c0d987d6dfb6.1703762557.git.cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1703762557.git.cy_huang@richtek.com>
References: <cover.1703762557.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

RTQ6053 and RTQ6059 are the same series of RTQ6056.

The respective differences with RTQ6056 are listed below
RTQ6053
- chip package type

RTQ6059
- Reduce the pinout for vbus sensing pin
- Some internal ADC scaling change

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
v2
- Remove rtq6053 in DT match table and make rtq6053 fallback compatible
  with rtq6056
---
 drivers/iio/adc/rtq6056.c | 264 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 250 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index ad4cea6839b2..5587178cea83 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -39,6 +39,16 @@
 #define RTQ6056_DEFAULT_CONFIG	0x4127
 #define RTQ6056_CONT_ALLON	7
 
+#define RTQ6059_DEFAULT_CONFIG	0x3C47
+#define RTQ6059_VBUS_LSB_OFFSET	3
+#define RTQ6059_AVG_BASE	8
+
+enum {
+	RICHTEK_DEV_RTQ6056 = 0,
+	RICHTEK_DEV_RTQ6059,
+	RICHTEK_DEV_MAX
+};
+
 enum {
 	RTQ6056_CH_VSHUNT = 0,
 	RTQ6056_CH_VBUS,
@@ -50,16 +60,29 @@ enum {
 enum {
 	F_OPMODE = 0,
 	F_VSHUNTCT,
+	F_SADC = F_VSHUNTCT,
 	F_VBUSCT,
+	F_BADC = F_VBUSCT,
 	F_AVG,
+	F_PGA = F_AVG,
 	F_RESET,
 	F_MAX_FIELDS
 };
 
+struct richtek_dev_data {
+	int dev_id;
+	int default_conv_time;
+	unsigned int default_config;
+	unsigned int calib_coefficient;
+	const struct reg_field *reg_fields;
+	const struct iio_chan_spec *channels;
+};
+
 struct rtq6056_priv {
 	struct device *dev;
 	struct regmap *regmap;
 	struct regmap_field *rm_fields[F_MAX_FIELDS];
+	const struct richtek_dev_data *devdata;
 	u32 shunt_resistor_uohm;
 	int vshuntct_us;
 	int vbusct_us;
@@ -74,6 +97,14 @@ static const struct reg_field rtq6056_reg_fields[F_MAX_FIELDS] = {
 	[F_RESET] = REG_FIELD(RTQ6056_REG_CONFIG, 15, 15),
 };
 
+static const struct reg_field rtq6059_reg_fields[F_MAX_FIELDS] = {
+	[F_OPMODE] = REG_FIELD(RTQ6056_REG_CONFIG, 0, 2),
+	[F_SADC] = REG_FIELD(RTQ6056_REG_CONFIG, 3, 6),
+	[F_BADC] = REG_FIELD(RTQ6056_REG_CONFIG, 7, 10),
+	[F_PGA]	= REG_FIELD(RTQ6056_REG_CONFIG, 11, 12),
+	[F_RESET] = REG_FIELD(RTQ6056_REG_CONFIG, 15, 15),
+};
+
 static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL + 1] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -151,10 +182,93 @@ static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL + 1] = {
 	IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL),
 };
 
+/*
+ * Difference between RTQ6056 and RTQ6059
+ * - Fixed sampling conversion time
+ * - Average sample numbers
+ * - Channel scale
+ * - calibration coefficient
+ */
+static const struct iio_chan_spec rtq6059_channels[RTQ6056_MAX_CHANNEL + 1] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.address = RTQ6056_REG_SHUNTVOLT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 1,
+		.address = RTQ6056_REG_BUSVOLT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_POWER,
+		.indexed = 1,
+		.channel = 2,
+		.address = RTQ6056_REG_POWER,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_CURRENT,
+		.indexed = 1,
+		.channel = 3,
+		.address = RTQ6056_REG_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL),
+};
+
 static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
 				    struct iio_chan_spec const *ch,
 				    int *val)
 {
+	const struct richtek_dev_data *devdata = priv->devdata;
 	struct device *dev = priv->dev;
 	unsigned int addr = ch->address;
 	unsigned int regval;
@@ -168,10 +282,18 @@ static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
 		return ret;
 
 	/* Power and VBUS is unsigned 16-bit, others are signed 16-bit */
-	if (addr == RTQ6056_REG_BUSVOLT || addr == RTQ6056_REG_POWER)
+	switch (addr) {
+	case RTQ6056_REG_BUSVOLT:
+		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
+			regval >>= RTQ6059_VBUS_LSB_OFFSET;
+		fallthrough;
+	case RTQ6056_REG_POWER:
 		*val = regval;
-	else
+		break;
+	default:
 		*val = sign_extend32(regval, 16);
+		break;
+	}
 
 	return IIO_VAL_INT;
 }
@@ -199,6 +321,28 @@ static int rtq6056_adc_read_scale(struct iio_chan_spec const *ch, int *val,
 	}
 }
 
+static int rtq6059_adc_read_scale(struct iio_chan_spec const *ch, int *val,
+				  int *val2)
+{
+	switch (ch->address) {
+	case RTQ6056_REG_SHUNTVOLT:
+		/* VSHUNT lsb  10uV */
+		*val = 10000;
+		*val2 = 1000000;
+		return IIO_VAL_FRACTIONAL;
+	case RTQ6056_REG_BUSVOLT:
+		/* VBUS lsb 4mV */
+		*val = 4;
+		return IIO_VAL_INT;
+	case RTQ6056_REG_POWER:
+		/* Power lsb 20mW */
+		*val = 20;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Sample frequency for channel VSHUNT and VBUS. The indices correspond
  * with the bit value expected by the chip. And it can be found at
@@ -248,6 +392,10 @@ static const int rtq6056_avg_sample_list[] = {
 	1, 4, 16, 64, 128, 256, 512, 1024,
 };
 
+static const int rtq6059_avg_sample_list[] = {
+	1, 2, 4, 8, 16, 32, 64, 128,
+};
+
 static int rtq6056_adc_set_average(struct rtq6056_priv *priv, int val)
 {
 	unsigned int selector;
@@ -268,6 +416,30 @@ static int rtq6056_adc_set_average(struct rtq6056_priv *priv, int val)
 	return 0;
 }
 
+static int rtq6059_adc_set_average(struct rtq6056_priv *priv, int val)
+{
+	unsigned int selector;
+	int ret;
+
+	if (val > 128 || val < 1)
+		return -EINVAL;
+
+	/* The supported average sample is 2^x (x from 0 to 7) */
+	selector = fls(val) - 1;
+
+	ret = regmap_field_write(priv->rm_fields[F_BADC],
+				 RTQ6059_AVG_BASE + selector);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(priv->rm_fields[F_SADC],
+				 RTQ6059_AVG_BASE + selector);
+
+	priv->avg_sample = BIT(selector + 1);
+
+	return 0;
+}
+
 static int rtq6056_adc_get_sample_freq(struct rtq6056_priv *priv,
 				       struct iio_chan_spec const *ch, int *val)
 {
@@ -292,11 +464,15 @@ static int rtq6056_adc_read_raw(struct iio_dev *indio_dev,
 				int *val2, long mask)
 {
 	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	const struct richtek_dev_data *devdata = priv->devdata;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		return rtq6056_adc_read_channel(priv, chan, val);
 	case IIO_CHAN_INFO_SCALE:
+		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
+			return rtq6059_adc_read_scale(chan, val, val2);
+
 		return rtq6056_adc_read_scale(chan, val, val2);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = priv->avg_sample;
@@ -313,16 +489,28 @@ static int rtq6056_adc_read_avail(struct iio_dev *indio_dev,
 				  const int **vals, int *type, int *length,
 				  long mask)
 {
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	const struct richtek_dev_data *devdata = priv->devdata;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
+			return -EINVAL;
+
 		*vals = rtq6056_samp_freq_list;
 		*type = IIO_VAL_INT;
 		*length = ARRAY_SIZE(rtq6056_samp_freq_list);
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		*vals = rtq6056_avg_sample_list;
+		if (devdata->dev_id == RICHTEK_DEV_RTQ6059) {
+			*vals = rtq6059_avg_sample_list;
+			*length = ARRAY_SIZE(rtq6059_avg_sample_list);
+		} else {
+			*vals = rtq6056_avg_sample_list;
+			*length = ARRAY_SIZE(rtq6056_avg_sample_list);
+		}
+
 		*type = IIO_VAL_INT;
-		*length = ARRAY_SIZE(rtq6056_avg_sample_list);
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -334,6 +522,7 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
 				 int val2, long mask)
 {
 	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	const struct richtek_dev_data *devdata = priv->devdata;
 	int ret;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
@@ -342,10 +531,16 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = rtq6056_adc_set_samp_freq(priv, chan, val);
+		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
+			ret = -EINVAL;
+		else
+			ret = rtq6056_adc_set_samp_freq(priv, chan, val);
 		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = rtq6056_adc_set_average(priv, val);
+		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
+			ret = rtq6059_adc_set_average(priv, val);
+		else
+			ret = rtq6056_adc_set_average(priv, val);
 		break;
 	default:
 		ret = -EINVAL;
@@ -374,6 +569,7 @@ static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
 static int rtq6056_set_shunt_resistor(struct rtq6056_priv *priv,
 				      int resistor_uohm)
 {
+	const struct richtek_dev_data *devdata = priv->devdata;
 	unsigned int calib_val;
 	int ret;
 
@@ -382,8 +578,8 @@ static int rtq6056_set_shunt_resistor(struct rtq6056_priv *priv,
 		return -EINVAL;
 	}
 
-	/* calibration = 5120000 / (Rshunt (uOhm) * current lsb (1mA)) */
-	calib_val = 5120000 / resistor_uohm;
+	/* calibration = coefficient / (Rshunt (uOhm) * current lsb (1mA)) */
+	calib_val = devdata->calib_coefficient / resistor_uohm;
 	ret = regmap_write(priv->regmap, RTQ6056_REG_CALIBRATION, calib_val);
 	if (ret)
 		return ret;
@@ -445,11 +641,16 @@ static const struct iio_info rtq6056_info = {
 	.read_label = rtq6056_adc_read_label,
 };
 
+static const struct iio_info rtq6059_info = {
+	.attrs = &rtq6056_attribute_group,
+};
+
 static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	const struct richtek_dev_data *devdata = priv->devdata;
 	struct device *dev = priv->dev;
 	struct {
 		u16 vals[RTQ6056_MAX_CHANNEL];
@@ -469,6 +670,10 @@ static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
 		if (ret)
 			goto out;
 
+		if (devdata->dev_id == RICHTEK_DEV_RTQ6059 &&
+		    addr == RTQ6056_REG_BUSVOLT)
+			raw >>= RTQ6059_VBUS_LSB_OFFSET;
+
 		data.vals[i++] = raw;
 	}
 
@@ -528,20 +733,26 @@ static int rtq6056_probe(struct i2c_client *i2c)
 	struct rtq6056_priv *priv;
 	struct device *dev = &i2c->dev;
 	struct regmap *regmap;
+	const struct richtek_dev_data *devdata;
 	unsigned int vendor_id, shunt_resistor_uohm;
 	int ret;
 
 	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
+	devdata = device_get_match_data(dev);
+	if (!devdata)
+		return dev_err_probe(dev, -EINVAL, "Invalid dev data\n");
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	priv = iio_priv(indio_dev);
 	priv->dev = dev;
-	priv->vshuntct_us = priv->vbusct_us = 1037;
+	priv->vshuntct_us = priv->vbusct_us = devdata->default_conv_time;
 	priv->avg_sample = 1;
+	priv->devdata = devdata;
 	i2c_set_clientdata(i2c, priv);
 
 	regmap = devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
@@ -556,20 +767,26 @@ static int rtq6056_probe(struct i2c_client *i2c)
 		return dev_err_probe(dev, ret,
 				     "Failed to get manufacturer info\n");
 
+	/* For RTQ6059, this vendor id value is meaningless */
 	if (vendor_id != RTQ6056_VENDOR_ID)
 		return dev_err_probe(dev, -ENODEV,
 				     "Invalid vendor id 0x%04x\n", vendor_id);
 
 	ret = devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fields,
-					   rtq6056_reg_fields, F_MAX_FIELDS);
+					   devdata->reg_fields, F_MAX_FIELDS);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init regmap field\n");
 
 	/*
+	 * RTQ6053 & RTQ6056:
 	 * By default, configure average sample as 1, bus and shunt conversion
 	 * time as 1037 microsecond, and operating mode to all on.
+	 *
+	 * RTQ6059:
+	 * By default, configure average sample as 1, bus and shunt conversion
+	 * time as 532 microsecond, and operating mode to all on.
 	 */
-	ret = regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAULT_CONFIG);
+	ret = regmap_write(regmap, RTQ6056_REG_CONFIG, devdata->default_config);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to enable continuous sensing\n");
@@ -598,8 +815,8 @@ static int rtq6056_probe(struct i2c_client *i2c)
 
 	indio_dev->name = "rtq6056";
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = rtq6056_channels;
-	indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
+	indio_dev->channels = devdata->channels;
+	indio_dev->num_channels = RTQ6056_MAX_CHANNEL + 1;
 	indio_dev->info = &rtq6056_info;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
@@ -640,8 +857,27 @@ static int rtq6056_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(rtq6056_pm_ops, rtq6056_runtime_suspend,
 				 rtq6056_runtime_resume, NULL);
 
+static const struct richtek_dev_data rtq6056_devdata = {
+	.dev_id = RICHTEK_DEV_RTQ6056,
+	.default_conv_time = 1037,
+	.calib_coefficient = 5120000,
+	.default_config = RTQ6056_DEFAULT_CONFIG,
+	.reg_fields = rtq6056_reg_fields,
+	.channels = rtq6056_channels,
+};
+
+static const struct richtek_dev_data rtq6059_devdata = {
+	.dev_id = RICHTEK_DEV_RTQ6059,
+	.default_conv_time = 532,
+	.calib_coefficient = 40960000,
+	.default_config = RTQ6059_DEFAULT_CONFIG,
+	.reg_fields = rtq6059_reg_fields,
+	.channels = rtq6059_channels,
+};
+
 static const struct of_device_id rtq6056_device_match[] = {
-	{ .compatible = "richtek,rtq6056" },
+	{ .compatible = "richtek,rtq6056", .data = &rtq6056_devdata },
+	{ .compatible = "richtek,rtq6059", .data = &rtq6059_devdata },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rtq6056_device_match);
-- 
2.34.1


