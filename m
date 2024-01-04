Return-Path: <linux-kernel+bounces-16413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9ED823E21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775E5282D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC31208CA;
	Thu,  4 Jan 2024 09:04:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBD11EB3D;
	Thu,  4 Jan 2024 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636809:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 04 Jan 2024 17:03:33 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 4 Jan
 2024 17:03:32 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Thu, 4 Jan 2024 17:03:32 +0800
From: <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
	ChiYuan Huang <cy_huang@richtek.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] iio: adc: rtq6056: Add support for the whole RTQ6056 family
Date: Thu, 4 Jan 2024 17:03:31 +0800
Message-ID: <2980b67de00bae1fc25004188e8aabf53073d940.1704357933.git.cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1704357933.git.cy_huang@richtek.com>
References: <cover.1704357933.git.cy_huang@richtek.com>
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
v4
- Remove the unused chip type enum
- Directly return in switch case of read_channel function
- Refine in write_raw switch case for IIO_CHAN_INFO_SAMP_FREQ
  If sample frequency is fixed, return invalid and break switch case
- Use devdata->num_channels to replace the predefined constant
- Change the rtq6059 difference part for the control bitfield name from
  the general 'F_xxx' to 'F_RTQ6059_xxx'
- Fix rtq6059 average sample variable store problem in 'set_average' function

v3
- Resotre the enum for control field.
- Put all the predefined datas/callbacks in dev_data.
- Remove the unused 'rtq6059_info'.
- Change 'default_conv_time' to 'default_conv_time_us'.
- Move the comment for default config above the dev_data setting line.

v2
- Remove rtq6053 in DT match table and make rtq6053 fallback compatible
  with rtq6056
---
 drivers/iio/adc/rtq6056.c | 275 +++++++++++++++++++++++++++++++++++---
 1 file changed, 255 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index ad4cea6839b2..897760161757 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -39,6 +39,10 @@
 #define RTQ6056_DEFAULT_CONFIG	0x4127
 #define RTQ6056_CONT_ALLON	7
 
+#define RTQ6059_DEFAULT_CONFIG	0x3C47
+#define RTQ6059_VBUS_LSB_OFFSET	3
+#define RTQ6059_AVG_BASE	8
+
 enum {
 	RTQ6056_CH_VSHUNT = 0,
 	RTQ6056_CH_VBUS,
@@ -47,19 +51,46 @@ enum {
 	RTQ6056_MAX_CHANNEL
 };
 
+/*
+ * The enum is to present the 0x00 CONFIG RG bitfield for the 16bit RG value
+ * field value order from LSB to MSB
+ * RTQ6053/6 is OPMODE->VSHUNTCT->VBUSCT->AVG->RESET
+ * RTQ6059 is OPMODE->SADC->BADC->PGA->RESET
+ */
 enum {
 	F_OPMODE = 0,
 	F_VSHUNTCT,
+	F_RTQ6059_SADC = F_VSHUNTCT,
 	F_VBUSCT,
+	F_RTQ6059_BADC = F_VBUSCT,
 	F_AVG,
+	F_RTQ6059_PGA = F_AVG,
 	F_RESET,
 	F_MAX_FIELDS
 };
 
+struct rtq6056_priv;
+
+struct richtek_dev_data {
+	bool fixed_samp_freq;
+	u8 vbus_offset;
+	int default_conv_time_us;
+	unsigned int default_config;
+	unsigned int calib_coefficient;
+	const int *avg_sample_list;
+	int avg_sample_list_length;
+	const struct reg_field *reg_fields;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	int (*read_scale)(struct iio_chan_spec const *ch, int *val, int *val2);
+	int (*set_average)(struct rtq6056_priv *priv, int val);
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
@@ -74,6 +105,14 @@ static const struct reg_field rtq6056_reg_fields[F_MAX_FIELDS] = {
 	[F_RESET] = REG_FIELD(RTQ6056_REG_CONFIG, 15, 15),
 };
 
+static const struct reg_field rtq6059_reg_fields[F_MAX_FIELDS] = {
+	[F_OPMODE] = REG_FIELD(RTQ6056_REG_CONFIG, 0, 2),
+	[F_VSHUNTCT] = REG_FIELD(RTQ6056_REG_CONFIG, 3, 6),
+	[F_VBUSCT] = REG_FIELD(RTQ6056_REG_CONFIG, 7, 10),
+	[F_AVG]	= REG_FIELD(RTQ6056_REG_CONFIG, 11, 12),
+	[F_RESET] = REG_FIELD(RTQ6056_REG_CONFIG, 15, 15),
+};
+
 static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL + 1] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -151,10 +190,93 @@ static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL + 1] = {
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
@@ -168,12 +290,21 @@ static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
 		return ret;
 
 	/* Power and VBUS is unsigned 16-bit, others are signed 16-bit */
-	if (addr == RTQ6056_REG_BUSVOLT || addr == RTQ6056_REG_POWER)
+	switch (addr) {
+	case RTQ6056_REG_BUSVOLT:
+		regval >>= devdata->vbus_offset;
 		*val = regval;
-	else
+		return IIO_VAL_INT;
+	case RTQ6056_REG_POWER:
+		*val = regval;
+		return IIO_VAL_INT;
+	case RTQ6056_REG_SHUNTVOLT:
+	case RTQ6056_REG_CURRENT:
 		*val = sign_extend32(regval, 16);
-
-	return IIO_VAL_INT;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int rtq6056_adc_read_scale(struct iio_chan_spec const *ch, int *val,
@@ -199,6 +330,28 @@ static int rtq6056_adc_read_scale(struct iio_chan_spec const *ch, int *val,
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
@@ -248,6 +401,10 @@ static const int rtq6056_avg_sample_list[] = {
 	1, 4, 16, 64, 128, 256, 512, 1024,
 };
 
+static const int rtq6059_avg_sample_list[] = {
+	1, 2, 4, 8, 16, 32, 64, 128,
+};
+
 static int rtq6056_adc_set_average(struct rtq6056_priv *priv, int val)
 {
 	unsigned int selector;
@@ -268,6 +425,30 @@ static int rtq6056_adc_set_average(struct rtq6056_priv *priv, int val)
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
+	ret = regmap_field_write(priv->rm_fields[F_RTQ6059_BADC],
+				 RTQ6059_AVG_BASE + selector);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(priv->rm_fields[F_RTQ6059_SADC],
+				 RTQ6059_AVG_BASE + selector);
+
+	priv->avg_sample = BIT(selector);
+
+	return 0;
+}
+
 static int rtq6056_adc_get_sample_freq(struct rtq6056_priv *priv,
 				       struct iio_chan_spec const *ch, int *val)
 {
@@ -292,12 +473,13 @@ static int rtq6056_adc_read_raw(struct iio_dev *indio_dev,
 				int *val2, long mask)
 {
 	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	const struct richtek_dev_data *devdata = priv->devdata;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		return rtq6056_adc_read_channel(priv, chan, val);
 	case IIO_CHAN_INFO_SCALE:
-		return rtq6056_adc_read_scale(chan, val, val2);
+		return devdata->read_scale(chan, val, val2);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = priv->avg_sample;
 		return IIO_VAL_INT;
@@ -313,6 +495,9 @@ static int rtq6056_adc_read_avail(struct iio_dev *indio_dev,
 				  const int **vals, int *type, int *length,
 				  long mask)
 {
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	const struct richtek_dev_data *devdata = priv->devdata;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*vals = rtq6056_samp_freq_list;
@@ -320,9 +505,9 @@ static int rtq6056_adc_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(rtq6056_samp_freq_list);
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		*vals = rtq6056_avg_sample_list;
+		*vals = devdata->avg_sample_list;
+		*length = devdata->avg_sample_list_length;
 		*type = IIO_VAL_INT;
-		*length = ARRAY_SIZE(rtq6056_avg_sample_list);
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -334,6 +519,7 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
 				 int val2, long mask)
 {
 	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	const struct richtek_dev_data *devdata = priv->devdata;
 	int ret;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
@@ -342,10 +528,15 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (devdata->fixed_samp_freq) {
+			ret = -EINVAL;
+			break;
+		}
+
 		ret = rtq6056_adc_set_samp_freq(priv, chan, val);
 		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = rtq6056_adc_set_average(priv, val);
+		ret = devdata->set_average(priv, val);
 		break;
 	default:
 		ret = -EINVAL;
@@ -374,6 +565,7 @@ static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
 static int rtq6056_set_shunt_resistor(struct rtq6056_priv *priv,
 				      int resistor_uohm)
 {
+	const struct richtek_dev_data *devdata = priv->devdata;
 	unsigned int calib_val;
 	int ret;
 
@@ -382,8 +574,8 @@ static int rtq6056_set_shunt_resistor(struct rtq6056_priv *priv,
 		return -EINVAL;
 	}
 
-	/* calibration = 5120000 / (Rshunt (uOhm) * current lsb (1mA)) */
-	calib_val = 5120000 / resistor_uohm;
+	/* calibration = coefficient / (Rshunt (uOhm) * current lsb (1mA)) */
+	calib_val = devdata->calib_coefficient / resistor_uohm;
 	ret = regmap_write(priv->regmap, RTQ6056_REG_CALIBRATION, calib_val);
 	if (ret)
 		return ret;
@@ -450,6 +642,7 @@ static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	const struct richtek_dev_data *devdata = priv->devdata;
 	struct device *dev = priv->dev;
 	struct {
 		u16 vals[RTQ6056_MAX_CHANNEL];
@@ -469,6 +662,9 @@ static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
 		if (ret)
 			goto out;
 
+		if (addr == RTQ6056_REG_BUSVOLT)
+			raw >>= devdata->vbus_offset;
+
 		data.vals[i++] = raw;
 	}
 
@@ -528,20 +724,26 @@ static int rtq6056_probe(struct i2c_client *i2c)
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
+	priv->vshuntct_us = priv->vbusct_us = devdata->default_conv_time_us;
 	priv->avg_sample = 1;
+	priv->devdata = devdata;
 	i2c_set_clientdata(i2c, priv);
 
 	regmap = devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
@@ -561,15 +763,11 @@ static int rtq6056_probe(struct i2c_client *i2c)
 				     "Invalid vendor id 0x%04x\n", vendor_id);
 
 	ret = devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fields,
-					   rtq6056_reg_fields, F_MAX_FIELDS);
+					   devdata->reg_fields, F_MAX_FIELDS);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init regmap field\n");
 
-	/*
-	 * By default, configure average sample as 1, bus and shunt conversion
-	 * time as 1037 microsecond, and operating mode to all on.
-	 */
-	ret = regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAULT_CONFIG);
+	ret = regmap_write(regmap, RTQ6056_REG_CONFIG, devdata->default_config);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to enable continuous sensing\n");
@@ -598,8 +796,8 @@ static int rtq6056_probe(struct i2c_client *i2c)
 
 	indio_dev->name = "rtq6056";
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = rtq6056_channels;
-	indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
+	indio_dev->channels = devdata->channels;
+	indio_dev->num_channels = devdata->num_channels;
 	indio_dev->info = &rtq6056_info;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
@@ -640,8 +838,45 @@ static int rtq6056_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(rtq6056_pm_ops, rtq6056_runtime_suspend,
 				 rtq6056_runtime_resume, NULL);
 
+static const struct richtek_dev_data rtq6056_devdata = {
+	.default_conv_time_us = 1037,
+	.calib_coefficient = 5120000,
+	/*
+	 * By default, configure average sample as 1, bus and shunt conversion
+	 * time as 1037 microsecond, and operating mode to all on.
+	 */
+	.default_config = RTQ6056_DEFAULT_CONFIG,
+	.avg_sample_list = rtq6056_avg_sample_list,
+	.avg_sample_list_length = ARRAY_SIZE(rtq6056_avg_sample_list),
+	.reg_fields = rtq6056_reg_fields,
+	.channels = rtq6056_channels,
+	.num_channels = ARRAY_SIZE(rtq6056_channels),
+	.read_scale = rtq6056_adc_read_scale,
+	.set_average = rtq6056_adc_set_average,
+};
+
+static const struct richtek_dev_data rtq6059_devdata = {
+	.fixed_samp_freq = true,
+	.vbus_offset = RTQ6059_VBUS_LSB_OFFSET,
+	.default_conv_time_us = 532,
+	.calib_coefficient = 40960000,
+	/*
+	 * By default, configure average sample as 1, bus and shunt conversion
+	 * time as 532 microsecond, and operating mode to all on.
+	 */
+	.default_config = RTQ6059_DEFAULT_CONFIG,
+	.avg_sample_list = rtq6059_avg_sample_list,
+	.avg_sample_list_length = ARRAY_SIZE(rtq6059_avg_sample_list),
+	.reg_fields = rtq6059_reg_fields,
+	.channels = rtq6059_channels,
+	.num_channels = ARRAY_SIZE(rtq6059_channels),
+	.read_scale = rtq6059_adc_read_scale,
+	.set_average = rtq6059_adc_set_average,
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


