Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528CE7F6449
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345101AbjKWQnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjKWQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:43:11 -0500
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C310EB;
        Thu, 23 Nov 2023 08:43:17 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ANDTpx7021671;
        Thu, 23 Nov 2023 11:43:03 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3uj2ch1r5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 11:43:02 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3ANGh18n045884
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 11:43:01 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 23 Nov 2023 11:43:00 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 23 Nov 2023 11:43:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 23 Nov 2023 11:43:00 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ANGgkEl019846;
        Thu, 23 Nov 2023 11:42:49 -0500
From:   Marcelo Schmitt <marcelo.schmitt@analog.com>
To:     <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC:     Marcelo Schmitt <marcelo.schmitt@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/7] iio: adc: Add support for AD7091R-8
Date:   Thu, 23 Nov 2023 13:42:45 -0300
Message-ID: <3513e59ec45663d6ac330adf4523d56335a70801.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: RxZk-YggfoENASrZi7f9vJnT_BE7SncB
X-Proofpoint-ORIG-GUID: RxZk-YggfoENASrZi7f9vJnT_BE7SncB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311230122
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Analog Devices AD7091R-2, AD7091R-4, and AD7091R-8
low power 12-Bit SAR ADCs.
Extend ad7091r-base driver so it can be used by AD7091R-8 drivers.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 MAINTAINERS                    |   1 +
 drivers/iio/adc/Kconfig        |  16 ++
 drivers/iio/adc/Makefile       |   4 +-
 drivers/iio/adc/ad7091r-base.c |  24 ++-
 drivers/iio/adc/ad7091r-base.h |  15 ++
 drivers/iio/adc/ad7091r5.c     |   2 +
 drivers/iio/adc/ad7091r8.c     | 270 +++++++++++++++++++++++++++++++++
 7 files changed, 324 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iio/adc/ad7091r8.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7c6c866396..54eff6f0c358 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1136,6 +1136,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
 F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.c
 F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.h
 F:	drivers/iio/adc/drivers/iio/adc/ad7091r5.c
+F:	drivers/iio/adc/drivers/iio/adc/ad7091r8.c
 
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alexandru Tachici <alexandru.tachici@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1e2b7a2c67c6..284d898790a2 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -36,13 +36,29 @@ config AD4130
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4130.
 
+config AD7091R
+	tristate
+
 config AD7091R5
 	tristate "Analog Devices AD7091R5 ADC Driver"
 	depends on I2C
+	select AD7091R
 	select REGMAP_I2C
 	help
 	  Say yes here to build support for Analog Devices AD7091R-5 ADC.
 
+config AD7091R8
+	tristate "Analog Devices AD7091R8 ADC Driver"
+	depends on SPI
+	select AD7091R
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD7091R-2, AD7091R-4,
+	  and AD7091R-8 ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7091r8.
+
 config AD7124
 	tristate "Analog Devices AD7124 and similar sigma-delta ADCs driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index c0803383a7cc..d2fda54a3259 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -7,7 +7,9 @@
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4130) += ad4130.o
-obj-$(CONFIG_AD7091R5) += ad7091r5.o ad7091r-base.o
+obj-$(CONFIG_AD7091R) += ad7091r-base.o
+obj-$(CONFIG_AD7091R5) += ad7091r5.o
+obj-$(CONFIG_AD7091R8) += ad7091r8.o
 obj-$(CONFIG_AD7124) += ad7124.o
 obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_AD7266) += ad7266.o
diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index c752cd2283e6..dbc60ea1bafc 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -16,7 +17,8 @@
 #include "ad7091r-base.h"
 
 /* AD7091R_REG_RESULT */
-#define AD7091R_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
+#define AD7091R5_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
+#define AD7091R8_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x7)
 #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
 
 /* AD7091R_REG_CONF */
@@ -66,10 +68,13 @@ static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
-				 AD7091R_REG_CONF_MODE_MASK, conf);
-	if (ret)
-		return ret;
+	/* AD7091R-2/4/8 don't set normal, command, autocycle modes in conf reg */
+	if (st->chip_info->type == AD7091R5) {
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+					 AD7091R_REG_CONF_MODE_MASK, conf);
+		if (ret)
+			return ret;
+	}
 
 	st->mode = mode;
 
@@ -109,8 +114,13 @@ static int ad7091r_read_one(struct iio_dev *iio_dev,
 	if (ret)
 		return ret;
 
-	if (AD7091R_REG_RESULT_CH_ID(val) != channel)
-		return -EIO;
+	if (st->chip_info->type == AD7091R5) {
+		if (AD7091R5_REG_RESULT_CH_ID(val) != channel)
+			return -EIO;
+	} else {
+		if (AD7091R8_REG_RESULT_CH_ID(val) != channel)
+			return -EIO;
+	}
 
 	*read_val = AD7091R_REG_RESULT_CONV_RESULT(val);
 
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 6997ea11998b..a42ea79a2893 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -29,6 +29,8 @@
 	.scan_type.realbits = bits,					\
 }
 
+#include <linux/gpio/consumer.h>
+
 struct device;
 
 enum ad7091r_mode {
@@ -40,13 +42,26 @@ enum ad7091r_mode {
 struct ad7091r_state {
 	struct device *dev;
 	struct regmap *map;
+	struct gpio_desc *convst_gpio;
+	struct gpio_desc *reset_gpio;
 	struct regulator *vref;
 	const struct ad7091r_chip_info *chip_info;
 	enum ad7091r_mode mode;
 	struct mutex lock; /*lock to prevent concurent reads */
+	__be16 tx_buf __aligned(IIO_DMA_MINALIGN);
+	__be16 rx_buf;
+};
+
+enum ad7091r_device_type {
+	AD7091R2,
+	AD7091R4,
+	AD7091R5,
+	AD7091R8,
 };
 
 struct ad7091r_chip_info {
+	const char *name;
+	enum ad7091r_device_type type;
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
 	unsigned int vref_mV;
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 1a27841d1bbc..5f587e0b55df 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -27,12 +27,14 @@ static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
 };
 
 static const struct ad7091r_chip_info ad7091r5_chip_info_irq = {
+	.type = AD7091R5,
 	.channels = ad7091r5_channels_irq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_irq),
 	.vref_mV = 2500,
 };
 
 static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
+	.type = AD7091R5,
 	.channels = ad7091r5_channels_noirq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
 	.vref_mV = 2500,
diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
new file mode 100644
index 000000000000..f062240873c6
--- /dev/null
+++ b/drivers/iio/adc/ad7091r8.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD7091R8 12-bit SAR ADC driver
+ *
+ * Copyright 2023 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
+#include <linux/spi/spi.h>
+
+#include "ad7091r-base.h"
+
+#define AD7091R8_REG_ADDR_MSK				GENMASK(15, 11)
+#define AD7091R8_RD_WR_FLAG_MSK				BIT(10)
+#define AD7091R8_REG_DATA_MSK				GENMASK(9, 0)
+
+#define AD7091R2_DEV_NAME				"ad7091r-2"
+#define AD7091R4_DEV_NAME				"ad7091r-4"
+#define AD7091R8_DEV_NAME				"ad7091r-8"
+
+#define AD7091R_SPI_CHIP_INFO(n) {					\
+	.name = AD7091R##n##_DEV_NAME,					\
+	.type =	AD7091R##n,						\
+	.channels = ad7091r##n##_channels,				\
+	.num_channels = ARRAY_SIZE(ad7091r##n##_channels),		\
+	.vref_mV = 2500,						\
+}
+
+#define AD7091R_SPI_CHIP_INFO_IRQ(n) {					\
+	.name = AD7091R##n##_DEV_NAME,					\
+	.type =	AD7091R##n,						\
+	.channels = ad7091r##n##_channels_irq,				\
+	.num_channels = ARRAY_SIZE(ad7091r##n##_channels_irq),		\
+	.vref_mV = 2500,						\
+}
+
+static const struct iio_chan_spec ad7091r2_channels[] = {
+	AD7091R_CHANNEL(0, 12, NULL, 0),
+	AD7091R_CHANNEL(1, 12, NULL, 0),
+};
+
+static const struct iio_chan_spec ad7091r4_channels[] = {
+	AD7091R_CHANNEL(0, 12, NULL, 0),
+	AD7091R_CHANNEL(1, 12, NULL, 0),
+	AD7091R_CHANNEL(2, 12, NULL, 0),
+	AD7091R_CHANNEL(3, 12, NULL, 0),
+};
+
+static const struct iio_chan_spec ad7091r4_channels_irq[] = {
+	AD7091R_CHANNEL(0, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(1, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(2, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(3, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+};
+
+static const struct iio_chan_spec ad7091r8_channels[] = {
+	AD7091R_CHANNEL(0, 12, NULL, 0),
+	AD7091R_CHANNEL(1, 12, NULL, 0),
+	AD7091R_CHANNEL(2, 12, NULL, 0),
+	AD7091R_CHANNEL(3, 12, NULL, 0),
+	AD7091R_CHANNEL(4, 12, NULL, 0),
+	AD7091R_CHANNEL(5, 12, NULL, 0),
+	AD7091R_CHANNEL(6, 12, NULL, 0),
+	AD7091R_CHANNEL(7, 12, NULL, 0),
+};
+
+static const struct iio_chan_spec ad7091r8_channels_irq[] = {
+	AD7091R_CHANNEL(0, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(1, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(2, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(3, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(4, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(5, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(6, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(7, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+};
+
+static const struct ad7091r_chip_info ad7091r_spi_chip_info[] = {
+	[AD7091R2] = AD7091R_SPI_CHIP_INFO(2),
+	[AD7091R4] = AD7091R_SPI_CHIP_INFO(4),
+	[AD7091R8] = AD7091R_SPI_CHIP_INFO(8),
+};
+
+static const struct ad7091r_chip_info ad7091r_spi_chip_info_irq[] = {
+	[AD7091R4] = AD7091R_SPI_CHIP_INFO_IRQ(4),
+	[AD7091R8] = AD7091R_SPI_CHIP_INFO_IRQ(8),
+};
+
+static void ad7091r_pulse_convst(struct ad7091r_state *st)
+{
+	gpiod_set_value_cansleep(st->convst_gpio, 1);
+	gpiod_set_value_cansleep(st->convst_gpio, 0);
+}
+
+static const struct regmap_config ad7091r_spi_regmap_config[] = {
+	[AD7091R2] = {
+		.reg_bits = 5,
+		.pad_bits = 3,
+		.val_bits = 16,
+		.volatile_reg = ad7091r_volatile_reg,
+		.writeable_reg = ad7091r_writeable_reg,
+		.max_register = AD7091R_REG_CH_HYSTERESIS(2),
+	},
+	[AD7091R4] = {
+		.reg_bits = 5,
+		.pad_bits = 3,
+		.val_bits = 16,
+		.volatile_reg = ad7091r_volatile_reg,
+		.writeable_reg = ad7091r_writeable_reg,
+		.max_register = AD7091R_REG_CH_HYSTERESIS(4),
+	},
+	[AD7091R8] = {
+		.reg_bits = 5,
+		.pad_bits = 3,
+		.write_flag_mask = BIT(2),
+		.val_bits = 16,
+		.volatile_reg = ad7091r_volatile_reg,
+		.writeable_reg = ad7091r_writeable_reg,
+		.max_register = AD7091R_REG_CH_HYSTERESIS(8),
+	},
+};
+
+static int ad7091r_regmap_bus_reg_read(void *context, unsigned int reg,
+				       unsigned int *val)
+{
+	struct ad7091r_state *st = context;
+	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
+	const struct regmap_config *conf = &ad7091r_spi_regmap_config[st->chip_info->type];
+	int ret;
+
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->tx_buf,
+			.len = 2,
+			.cs_change = 1,
+		}, {
+			.rx_buf = &st->rx_buf,
+			.len = 2,
+		}
+	};
+
+	if (reg == AD7091R_REG_RESULT)
+		ad7091r_pulse_convst(st);
+
+	reg <<= conf->pad_bits;
+	st->tx_buf = cpu_to_be16(reg << 8);
+
+	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	*val = be16_to_cpu(st->rx_buf);
+	return 0;
+}
+
+static int ad7091r_regmap_bus_reg_write(void *context, unsigned int reg,
+					unsigned int val)
+{
+	struct ad7091r_state *st = context;
+	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
+
+	/*
+	 * AD7091R-2/-4/-8 protocol (datasheet page 31) is to do a single SPI
+	 * transfer with reg address set in bits B15:B11 and value set in B9:B0.
+	 */
+	st->tx_buf = cpu_to_be16(FIELD_PREP(AD7091R8_REG_DATA_MSK, val) |
+			 FIELD_PREP(AD7091R8_RD_WR_FLAG_MSK, 1) |
+			 FIELD_PREP(AD7091R8_REG_ADDR_MSK, reg));
+
+	return spi_write(spi, &st->tx_buf, 2);
+}
+
+static struct regmap_bus ad7091r8_regmap_bus = {
+	.reg_read = ad7091r_regmap_bus_reg_read,
+	.reg_write = ad7091r_regmap_bus_reg_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static int ad7091r8_gpio_setup(struct ad7091r_state *st)
+{
+	st->convst_gpio = devm_gpiod_get(st->dev, "adi,conversion-start",
+					 GPIOD_OUT_LOW);
+	if (IS_ERR(st->convst_gpio))
+		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
+				     "Error getting convst GPIO\n");
+
+	st->reset_gpio =  devm_gpiod_get_optional(st->dev, "reset",
+						  GPIOD_OUT_HIGH);
+	if (IS_ERR(st->reset_gpio))
+		return PTR_ERR(st->reset_gpio);
+
+	if (st->reset_gpio) {
+		fsleep(20);
+		gpiod_set_value_cansleep(st->reset_gpio, 0);
+	}
+
+	return 0;
+}
+
+static int ad7091r8_spi_probe(struct spi_device *spi)
+{
+	const struct ad7091r_chip_info *chip_info;
+	struct ad7091r_state *st;
+	struct iio_dev *iio_dev;
+	struct regmap *map;
+	int ret;
+
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -EINVAL;
+
+	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(iio_dev);
+	st->dev = &spi->dev;
+
+	map = devm_regmap_init(&spi->dev, &ad7091r8_regmap_bus, st,
+			       &ad7091r_spi_regmap_config[chip_info->type]);
+
+	if (IS_ERR(map))
+		return dev_err_probe(&spi->dev, PTR_ERR(map),
+				     "Error initializing spi regmap\n");
+
+	ret = ad7091r8_gpio_setup(st);
+	if (ret < 0)
+		return ret;
+
+	if (spi->irq)
+		chip_info = &ad7091r_spi_chip_info_irq[chip_info->type];
+
+	return ad7091r_probe(iio_dev, chip_info->name, chip_info, map, spi->irq);
+}
+
+static const struct of_device_id ad7091r8_of_match[] = {
+	{ .compatible = "adi,ad7091r2", .data = &ad7091r_spi_chip_info[AD7091R2] },
+	{ .compatible = "adi,ad7091r4", .data = &ad7091r_spi_chip_info[AD7091R4] },
+	{ .compatible = "adi,ad7091r8", .data = &ad7091r_spi_chip_info[AD7091R8] },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad7091r8_of_match);
+
+static const struct spi_device_id ad7091r8_spi_id[] = {
+	{ "ad7091r2", (kernel_ulong_t)&ad7091r_spi_chip_info[AD7091R2] },
+	{ "ad7091r4", (kernel_ulong_t)&ad7091r_spi_chip_info[AD7091R4] },
+	{ "ad7091r8", (kernel_ulong_t)&ad7091r_spi_chip_info[AD7091R8] },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, ad7091r8_spi_id);
+
+static struct spi_driver ad7091r8_driver = {
+	.driver = {
+		.name = "ad7091r8",
+		.of_match_table = ad7091r8_of_match,
+	},
+	.probe = ad7091r8_spi_probe,
+	.id_table = ad7091r8_spi_id,
+};
+module_spi_driver(ad7091r8_driver);
+
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7091R8 ADC driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_AD7091R);
-- 
2.42.0

