Return-Path: <linux-kernel+bounces-126781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43B893CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 440DFB2221E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840945026B;
	Mon,  1 Apr 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRZ7U572"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E924778E;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984217; cv=none; b=JN7AC4vNzI6ZdKAbu22URQiLWm/JzjnSUs1QOnAd++aqOMvlAruaJZzzUHBB6LS4pTSxOMNvwcOkPIN2bfBKFSFdB/hwhEctuJGFxaNxmRUJp0s985Bz/5Kc4QHNNxw0WhG7s1UyRnC2Iuwmm1MFYi/2Z+IxBeOILaRLlW6hu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984217; c=relaxed/simple;
	bh=KNM3Z/xPIReDwB4TB74SR3DTpeDcKNy5Ue7Za5F40a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ip/OgA8D0RUXi/hEdOaEoDx7h5D2SmjjscRytF1JiIoYrYiuVBIRwHeFDVsckT5W/R+60x0G2Q6bAPMneHEzvCWtpXPKEBKW7DX8ATFWwiGcs7ZUPNtOrHN/CXFjto0Kj8cHmz5DSN95hA8Uwxqnlw9nPVHazYEQfRiaz0qlJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRZ7U572; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55C56C41679;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984217;
	bh=KNM3Z/xPIReDwB4TB74SR3DTpeDcKNy5Ue7Za5F40a8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gRZ7U572QYXVHu/OzMZAW2YGeyIoO6wR4T8Z1iYuTNJIXpLqMafJhqi9/+/pDmZDJ
	 gknfSf4Ynj3Z2/+dDnwt0G0L07cm0QiQAB/PVrYxxKiIkC9GK1jbr9VLhWmrx1th/k
	 jcmsSyCcvlecLzOGrriNi9T//03Sa7rREnSLiX+LNqCU09E+PL6oHh39Jemi8J7fNp
	 afyQPq/9mIuzlnCMom6m++VAXvlQZ1F33MRJ2VVSYLoPYCqghIE+gwZdJR3hWx2yjz
	 jGq2jujgFveQ8+fxUhBx+vEIU/l8XG0LzSS8S133N5pfuANX16mkQjtmqkP3n4dWDQ
	 5wxY2dc/JihwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF4ACD1288;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 01 Apr 2024 18:32:24 +0300
Subject: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-ad4111-v1-6-34618a9cc502@analog.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711985550; l=12578;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=kiHu5JNtgoCzcntlDNshNci5NsEdS6HEdpF8vTbhVrY=;
 b=3PzLgxXE80EKuvp129PliMgrHheZyY6v4yLLBSuo77eMS8g/Uv4fB8VlUVy9QvZYi1HQth4G/
 LvW21PcLKMkA7ZlJsym0F74JH1+8fmHHi4kue5czc/a9hTLtuoQ0JPk
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add support for AD4111/AD4112/AD4114/AD4115/AD4116.

The AD411X family encompasses a series of low power, low noise, 24-bit,
sigma-delta analog-to-digital converters that offer a versatile range of
specifications.

This family of ADCs integrates an analog front end suitable for processing
both fully differential and single-ended, bipolar voltage inputs
addressing a wide array of industrial and instrumentation requirements.

- All ADCs have inputs with a precision voltage divider with a division
  ratio of 10.
- AD4116 has 5 low level inputs without a voltage divider.
- AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
  shunt resistor.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 224 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 210 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 9526585e6929..ac32bd7dbd1e 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * AD717x family SPI ADC driver
+ * AD717x and AD411x family SPI ADC driver
  *
  * Supported devices:
+ *  AD4111/AD4112/AD4114/AD4115/AD4116
  *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
  *  AD7175-8/AD7176-2/AD7177-2
  *
@@ -72,6 +73,11 @@
 #define AD7175_2_ID			0x0cd0
 #define AD7172_4_ID			0x2050
 #define AD7173_ID			0x30d0
+#define AD4111_ID			0x30d0
+#define AD4112_ID			0x30d0
+#define AD4114_ID			0x30d0
+#define AD4116_ID			0x34d0
+#define AD4115_ID			0x38d0
 #define AD7175_8_ID			0x3cd0
 #define AD7177_ID			0x4fd0
 #define AD7173_ID_MASK			GENMASK(15, 4)
@@ -120,11 +126,20 @@
 #define AD7173_VOLTAGE_INT_REF_uV	2500000
 #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
 #define AD7177_ODR_START_VALUE		0x07
+#define AD4111_SHUNT_RESISTOR_OHM	50
+#define AD4111_DIVIDER_RATIO		10
+#define AD411X_VCOM_INPUT		0X10
+#define AD4111_CURRENT_CHAN_CUTOFF	16
 
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
 
 enum ad7173_ids {
+	ID_AD4111,
+	ID_AD4112,
+	ID_AD4114,
+	ID_AD4115,
+	ID_AD4116,
 	ID_AD7172_2,
 	ID_AD7172_4,
 	ID_AD7173_8,
@@ -134,16 +149,26 @@ enum ad7173_ids {
 	ID_AD7177_2,
 };
 
+enum ad4111_current_channels {
+	AD4111_CURRENT_IN0P_IN0N,
+	AD4111_CURRENT_IN1P_IN1N,
+	AD4111_CURRENT_IN2P_IN2N,
+	AD4111_CURRENT_IN3P_IN3N,
+};
+
 struct ad7173_device_info {
 	const unsigned int *sinc5_data_rates;
 	unsigned int num_sinc5_data_rates;
 	unsigned int odr_start_value;
+	unsigned int num_inputs_with_divider;
 	unsigned int num_channels;
 	unsigned int num_configs;
 	unsigned int num_inputs;
 	unsigned int clock;
 	unsigned int id;
 	char *name;
+	bool has_current_inputs;
+	bool has_vcom;
 	bool has_temp;
 	bool has_input_buf;
 	bool has_int_ref;
@@ -189,6 +214,24 @@ struct ad7173_state {
 #endif
 };
 
+static unsigned int ad4115_sinc5_data_rates[] = {
+	24845000, 24845000, 20725000, 20725000,	/*  0-3  */
+	15564000, 13841000, 10390000, 10390000,	/*  4-7  */
+	4994000,  2499000,  1000000,  500000,	/*  8-11 */
+	395500,   200000,   100000,   59890,	/* 12-15 */
+	49920,    20000,    16660,    10000,	/* 16-19 */
+	5000,	  2500,     2500,		/* 20-22 */
+};
+
+static unsigned int ad4116_sinc5_data_rates[] = {
+	12422360, 12422360, 12422360, 12422360,	/*  0-3  */
+	10362690, 10362690, 7782100,  6290530,	/*  4-7  */
+	5194800,  2496900,  1007600,  499900,	/*  8-11 */
+	390600,	  200300,   100000,   59750,	/* 12-15 */
+	49840,	  20000,    16650,    10000,	/* 16-19 */
+	5000,	  2500,	    1250,		/* 20-22 */
+};
+
 static const unsigned int ad7173_sinc5_data_rates[] = {
 	6211000, 6211000, 6211000, 6211000, 6211000, 6211000, 5181000, 4444000,	/*  0-7  */
 	3115000, 2597000, 1007000, 503800,  381000,  200300,  100500,  59520,	/*  8-15 */
@@ -204,7 +247,91 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
 	5000,					/* 20    */
 };
 
+static unsigned int ad4111_current_channel_config[] = {
+	[AD4111_CURRENT_IN0P_IN0N] = 0x1E8,
+	[AD4111_CURRENT_IN1P_IN1N] = 0x1C9,
+	[AD4111_CURRENT_IN2P_IN2N] = 0x1AA,
+	[AD4111_CURRENT_IN3P_IN3N] = 0x18B,
+};
+
 static const struct ad7173_device_info ad7173_device_info[] = {
+	[ID_AD4111] = {
+		.id = AD4111_ID,
+		.num_inputs_with_divider = 8,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_inputs = 8,
+		.num_gpios = 2,
+		.has_temp = true,
+		.has_vcom = true,
+		.has_input_buf = true,
+		.has_current_inputs = true,
+		.has_int_ref = true,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
+	[ID_AD4112] = {
+		.id = AD4112_ID,
+		.num_inputs_with_divider = 8,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_inputs = 8,
+		.num_gpios = 2,
+		.has_vcom = true,
+		.has_temp = true,
+		.has_input_buf = true,
+		.has_current_inputs = true,
+		.has_int_ref = true,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
+	[ID_AD4114] = {
+		.id = AD4114_ID,
+		.num_inputs_with_divider = 16,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_inputs = 16,
+		.num_gpios = 4,
+		.has_vcom = true,
+		.has_temp = true,
+		.has_input_buf = true,
+		.has_int_ref = true,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
+	[ID_AD4115] = {
+		.id = AD4115_ID,
+		.num_inputs_with_divider = 16,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_inputs = 16,
+		.num_gpios = 4,
+		.has_vcom = true,
+		.has_temp = true,
+		.has_input_buf = true,
+		.has_int_ref = true,
+		.clock = 8 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad4115_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad4115_sinc5_data_rates),
+	},
+	[ID_AD4116] = {
+		.id = AD4116_ID,
+		.num_inputs_with_divider = 11,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_inputs = 16,
+		.num_gpios = 4,
+		.has_vcom = true,
+		.has_temp = true,
+		.has_input_buf = true,
+		.has_int_ref = true,
+		.clock = 4 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad4116_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad4116_sinc5_data_rates),
+	},
 	[ID_AD7172_2] = {
 		.name = "ad7172-2",
 		.id = AD7172_2_ID,
@@ -670,18 +797,34 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->type == IIO_TEMP) {
+
+		switch (chan->type) {
+		case IIO_TEMP:
 			temp = AD7173_VOLTAGE_INT_REF_uV * MILLI;
 			temp /= AD7173_TEMP_SENSIIVITY_uV_per_C;
 			*val = temp;
 			*val2 = chan->scan_type.realbits;
-		} else {
+			break;
+		case IIO_VOLTAGE:
 			*val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
 			*val2 = chan->scan_type.realbits - !!(ch->cfg.bipolar);
+
+			if (chan->channel < st->info->num_inputs_with_divider)
+				*val *= AD4111_DIVIDER_RATIO;
+			break;
+		case IIO_CURRENT:
+			*val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
+			*val /= AD4111_SHUNT_RESISTOR_OHM;
+			*val2 = chan->scan_type.realbits - !!(ch->cfg.bipolar);
+			break;
+		default:
+			return -EINVAL;
 		}
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-		if (chan->type == IIO_TEMP) {
+
+		switch (chan->type) {
+		case IIO_TEMP:
 			/* 0 Kelvin -> raw sample */
 			temp   = -ABSOLUTE_ZERO_MILLICELSIUS;
 			temp  *= AD7173_TEMP_SENSIIVITY_uV_per_C;
@@ -690,8 +833,13 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 						       AD7173_VOLTAGE_INT_REF_uV *
 						       MILLI);
 			*val   = -temp;
-		} else {
+			break;
+		case IIO_VOLTAGE:
+		case IIO_CURRENT:
 			*val = -BIT(chan->scan_type.realbits - 1);
+			break;
+		default:
+			return -EINVAL;
 		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -909,6 +1057,24 @@ static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
 					   &st->int_clk_hw);
 }
 
+static int ad4111_validate_current_ain(struct ad7173_state *st,
+				       unsigned int ain[2])
+{
+	struct device *dev = &st->sd.spi->dev;
+
+	if (!st->info->has_current_inputs)
+		return dev_err_probe(dev, -EINVAL,
+			"Reg values equal to or higher than %d are restricted to models with current channels.\n",
+			AD4111_CURRENT_CHAN_CUTOFF);
+
+	if (ain[1] != 0 && ain[0] >= ARRAY_SIZE(ad4111_current_channel_config))
+		return dev_err_probe(dev, -EINVAL,
+			"For current channel diff-channels must be <[0-%d],0>\n",
+			ARRAY_SIZE(ad4111_current_channel_config) - 1);
+
+	return 0;
+}
+
 static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
 					      unsigned int ain[2])
 {
@@ -951,7 +1117,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *chan_arr, *chan;
 	unsigned int ain[2], chan_index = 0;
-	int ref_sel, ret, num_channels;
+	int ref_sel, ret, reg, num_channels;
 
 	num_channels = device_get_child_node_count(dev);
 
@@ -1004,10 +1170,20 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (ret)
 			return ret;
 
-		ret = ad7173_validate_voltage_ain_inputs(st, ain);
+		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret)
 			return ret;
 
+		if (reg >= AD4111_CURRENT_CHAN_CUTOFF) {
+			ret = ad4111_validate_current_ain(st, ain);
+			if (ret)
+				return ret;
+		} else {
+			ret = ad7173_validate_voltage_ain_inputs(st, ain);
+			if (ret)
+				return ret;
+		}
+
 		ret = fwnode_property_match_property_string(child,
 							    "adi,reference-select",
 							    ad7173_ref_sel_str,
@@ -1028,15 +1204,22 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		*chan = ad7173_channel_template;
 		chan->address = chan_index;
 		chan->scan_index = chan_index;
-		chan->channel = ain[0];
-		chan->channel2 = ain[1];
-		chan->differential = true;
 
-		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
+		if (reg >= AD4111_CURRENT_CHAN_CUTOFF) {
+			chan->type = IIO_CURRENT;
+			chan->channel = ain[0];
+			chan_st_priv->ain = ad4111_current_channel_config[ain[0]];
+		} else {
+			chan->channel = ain[0];
+			chan->channel2 = ain[1];
+			chan->differential = true;
+
+			chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
+			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
+		}
+
 		chan_st_priv->chan_reg = chan_index;
-		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.odr = 0;
-
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
 		if (chan_st_priv->cfg.bipolar)
 			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
@@ -1167,6 +1350,14 @@ static int ad7173_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad7173_of_match[] = {
+	{ .compatible = "ad4111",
+	  .data = &ad7173_device_info[ID_AD4111]},
+	{ .compatible = "ad4112",
+	  .data = &ad7173_device_info[ID_AD4112]},
+	{ .compatible = "ad4114",
+	  .data = &ad7173_device_info[ID_AD4114]},
+	{ .compatible = "ad4115",
+	  .data = &ad7173_device_info[ID_AD4115]},
 	{ .compatible = "adi,ad7172-2",
 	  .data = &ad7173_device_info[ID_AD7172_2]},
 	{ .compatible = "adi,ad7172-4",
@@ -1186,6 +1377,11 @@ static const struct of_device_id ad7173_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad7173_of_match);
 
 static const struct spi_device_id ad7173_id_table[] = {
+	{ "ad4111", (kernel_ulong_t)&ad7173_device_info[ID_AD4111]},
+	{ "ad4112", (kernel_ulong_t)&ad7173_device_info[ID_AD4112]},
+	{ "ad4114", (kernel_ulong_t)&ad7173_device_info[ID_AD4114]},
+	{ "ad4115", (kernel_ulong_t)&ad7173_device_info[ID_AD4115]},
+	{ "ad4116", (kernel_ulong_t)&ad7173_device_info[ID_AD4116]},
 	{ "ad7172-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_2]},
 	{ "ad7172-4", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_4]},
 	{ "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8]},
@@ -1210,5 +1406,5 @@ module_spi_driver(ad7173_driver);
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafo.de>");
 MODULE_AUTHOR("Dumitru Ceclan <dumitru.ceclan@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7172/AD7173/AD7175/AD7176 ADC driver");
+MODULE_DESCRIPTION("Analog Devices AD717x and AD411x ADC driver");
 MODULE_LICENSE("GPL");

-- 
2.43.0



