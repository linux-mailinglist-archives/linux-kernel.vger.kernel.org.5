Return-Path: <linux-kernel+bounces-5921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E281918D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1581C24B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521039AD0;
	Tue, 19 Dec 2023 20:33:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D339AD7;
	Tue, 19 Dec 2023 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJI4ZSZ001694;
	Tue, 19 Dec 2023 15:32:56 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3v3g4ugf6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:32:55 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3BJKWsXM064527
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Dec 2023 15:32:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 19 Dec
 2023 15:32:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Dec 2023 15:32:53 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BJKWaH1030185;
	Tue, 19 Dec 2023 15:32:39 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 10/11] iio: adc: Add support for AD7091R-8
Date: Tue, 19 Dec 2023 17:32:36 -0300
Message-ID: <09d1d1c4b39cecc528488efac6094233715f5659.1703013352.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
References: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: XD11swfsi8EFtygbvLbg5BpAadaUyTsd
X-Proofpoint-GUID: XD11swfsi8EFtygbvLbg5BpAadaUyTsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190153

Add support for Analog Devices AD7091R-2, AD7091R-4, and AD7091R-8
low power 12-Bit SAR ADCs with SPI interface.
Extend ad7091r-base driver so it can be used by the AD7091R-8 driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/Kconfig        |  12 ++
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ad7091r-base.c |   6 +
 drivers/iio/adc/ad7091r-base.h |   6 +
 drivers/iio/adc/ad7091r8.c     | 272 +++++++++++++++++++++++++++++++++
 5 files changed, 297 insertions(+)
 create mode 100644 drivers/iio/adc/ad7091r8.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9d2d32d09166..3b73c509bd68 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -47,6 +47,18 @@ config AD7091R5
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
index 1e289d674d4d..d2fda54a3259 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o
+obj-$(CONFIG_AD7091R8) += ad7091r8.o
 obj-$(CONFIG_AD7124) += ad7124.o
 obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_AD7266) += ad7266.o
diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 665e930d67d0..f4255b91acfc 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -322,6 +322,12 @@ int ad7091r_probe(struct device *dev, const struct ad7091r_init_info *init_info,
 	iio_dev->info = &ad7091r_info;
 	iio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (init_info->setup) {
+		ret = init_info->setup(st);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (irq) {
 		st->chip_info = init_info->info_irq;
 		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index b50024ca33e9..696bf7a897bb 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -49,6 +49,7 @@
 }
 
 struct device;
+struct gpio_desc;
 
 enum ad7091r_mode {
 	AD7091R_MODE_SAMPLE,
@@ -59,10 +60,14 @@ enum ad7091r_mode {
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
 };
 
 struct ad7091r_chip_info {
@@ -80,6 +85,7 @@ struct ad7091r_init_info {
 	const struct regmap_config *regmap_config;
 	void (*init_adc_regmap)(struct ad7091r_state *st,
 				const struct regmap_config *regmap_conf);
+	int (*setup)(struct ad7091r_state *st);
 };
 
 extern const struct iio_event_spec ad7091r_events[3];
diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
new file mode 100644
index 000000000000..57700f124803
--- /dev/null
+++ b/drivers/iio/adc/ad7091r8.c
@@ -0,0 +1,272 @@
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
+#define AD7091R_SPI_REGMAP_CONFIG(n) {					\
+	.reg_bits = 8,							\
+	.val_bits = 16,							\
+	.volatile_reg = ad7091r_volatile_reg,				\
+	.writeable_reg = ad7091r_writeable_reg,				\
+	.max_register = AD7091R_REG_CH_HYSTERESIS(n),			\
+}
+
+static int ad7091r8_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
+{
+	/* AD7091R-2/-4/-8 don't set sample/command/autocycle mode in conf reg */
+	st->mode = mode;
+	return 0;
+}
+
+static unsigned int ad7091r8_reg_result_chan_id(unsigned int val)
+{
+	return AD7091R8_REG_RESULT_CH_ID(val);
+}
+
+#define AD7091R_SPI_CHIP_INFO(_n, _name) {				\
+	.name = _name,							\
+	.channels = ad7091r##_n##_channels,				\
+	.num_channels = ARRAY_SIZE(ad7091r##_n##_channels),		\
+	.vref_mV = 2500,						\
+	.reg_result_chan_id = &ad7091r8_reg_result_chan_id,	\
+	.set_mode = &ad7091r8_set_mode,				\
+}
+
+#define AD7091R_SPI_CHIP_INFO_IRQ(_n, _name) {				\
+	.name = _name,							\
+	.channels = ad7091r##_n##_channels_irq,				\
+	.num_channels = ARRAY_SIZE(ad7091r##_n##_channels_irq),		\
+	.vref_mV = 2500,						\
+	.reg_result_chan_id = &ad7091r8_reg_result_chan_id,	\
+	.set_mode = &ad7091r8_set_mode,				\
+}
+
+enum ad7091r8_info_ids {
+	AD7091R2_INFO,
+	AD7091R4_INFO,
+	AD7091R4_INFO_IRQ,
+	AD7091R8_INFO,
+	AD7091R8_INFO_IRQ,
+};
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
+static void ad7091r_pulse_convst(struct ad7091r_state *st)
+{
+	gpiod_set_value_cansleep(st->convst_gpio, 1);
+	gpiod_set_value_cansleep(st->convst_gpio, 0);
+}
+
+static int ad7091r_regmap_bus_reg_read(void *context, unsigned int reg,
+				       unsigned int *val)
+{
+	struct ad7091r_state *st = context;
+	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
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
+	st->tx_buf = cpu_to_be16(reg << 11);
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
+				 FIELD_PREP(AD7091R8_RD_WR_FLAG_MSK, 1) |
+				 FIELD_PREP(AD7091R8_REG_ADDR_MSK, reg));
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
+static const struct ad7091r_chip_info ad7091r8_infos[] = {
+	[AD7091R2_INFO] = AD7091R_SPI_CHIP_INFO(2, "ad7091r-2"),
+	[AD7091R4_INFO] = AD7091R_SPI_CHIP_INFO(4, "ad7091r-4"),
+	[AD7091R4_INFO_IRQ] = AD7091R_SPI_CHIP_INFO_IRQ(4, "ad7091r-4"),
+	[AD7091R8_INFO] = AD7091R_SPI_CHIP_INFO(8, "ad7091r-8"),
+	[AD7091R8_INFO_IRQ] = AD7091R_SPI_CHIP_INFO_IRQ(8, "ad7091r-8")
+};
+
+static const struct regmap_config ad7091r2_reg_conf = AD7091R_SPI_REGMAP_CONFIG(2);
+static const struct regmap_config ad7091r4_reg_conf = AD7091R_SPI_REGMAP_CONFIG(4);
+static const struct regmap_config ad7091r8_reg_conf = AD7091R_SPI_REGMAP_CONFIG(8);
+
+static void ad7091r8_regmap_init(struct ad7091r_state *st,
+				 const struct regmap_config *regmap_conf)
+{
+	st->map = devm_regmap_init(st->dev, &ad7091r8_regmap_bus, st,
+				   regmap_conf);
+}
+
+static int ad7091r8_gpio_setup(struct ad7091r_state *st)
+{
+	st->convst_gpio = devm_gpiod_get(st->dev, "convst", GPIOD_OUT_LOW);
+	if (IS_ERR(st->convst_gpio))
+		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
+				     "Error getting convst GPIO\n");
+
+	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(st->reset_gpio))
+		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
+				     "Error on requesting reset GPIO\n");
+
+	if (st->reset_gpio) {
+		fsleep(20);
+		gpiod_set_value_cansleep(st->reset_gpio, 0);
+	}
+
+	return 0;
+}
+
+static struct ad7091r_init_info ad7091r2_init_info = {
+	.info_no_irq = &ad7091r8_infos[AD7091R2_INFO],
+	.regmap_config = &ad7091r2_reg_conf,
+	.init_adc_regmap = &ad7091r8_regmap_init,
+	.setup = &ad7091r8_gpio_setup
+};
+
+static struct ad7091r_init_info ad7091r4_init_info = {
+	.info_no_irq = &ad7091r8_infos[AD7091R4_INFO],
+	.info_irq = &ad7091r8_infos[AD7091R4_INFO_IRQ],
+	.regmap_config = &ad7091r4_reg_conf,
+	.init_adc_regmap = &ad7091r8_regmap_init,
+	.setup = &ad7091r8_gpio_setup
+};
+
+static struct ad7091r_init_info ad7091r8_init_info = {
+	.info_no_irq = &ad7091r8_infos[AD7091R8_INFO],
+	.info_irq = &ad7091r8_infos[AD7091R8_INFO_IRQ],
+	.regmap_config = &ad7091r8_reg_conf,
+	.init_adc_regmap = &ad7091r8_regmap_init,
+	.setup = &ad7091r8_gpio_setup
+};
+
+static int ad7091r8_spi_probe(struct spi_device *spi)
+{
+	const struct ad7091r_init_info *init_info;
+
+	init_info = spi_get_device_match_data(spi);
+	if (!init_info)
+		return -EINVAL;
+
+	return ad7091r_probe(&spi->dev, init_info, spi->irq);
+}
+
+static const struct of_device_id ad7091r8_of_match[] = {
+	{ .compatible = "adi,ad7091r2", .data = &ad7091r2_init_info },
+	{ .compatible = "adi,ad7091r4", .data = &ad7091r4_init_info },
+	{ .compatible = "adi,ad7091r8", .data = &ad7091r8_init_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7091r8_of_match);
+
+static const struct spi_device_id ad7091r8_spi_id[] = {
+	{ "ad7091r2", (kernel_ulong_t)&ad7091r2_init_info },
+	{ "ad7091r4", (kernel_ulong_t)&ad7091r4_init_info },
+	{ "ad7091r8", (kernel_ulong_t)&ad7091r8_init_info },
+	{ }
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


