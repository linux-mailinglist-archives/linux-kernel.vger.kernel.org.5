Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8AB8090A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443748AbjLGSnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjLGSne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:43:34 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9B4170E;
        Thu,  7 Dec 2023 10:43:38 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7FrQ8K008060;
        Thu, 7 Dec 2023 13:43:19 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3utd13spjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:43:19 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3B7IhIFw056445
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 13:43:18 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Dec 2023 13:43:17 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Dec 2023 13:43:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Dec 2023 13:43:16 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3B7IgvdG015418;
        Thu, 7 Dec 2023 13:43:00 -0500
From:   Marcelo Schmitt <marcelo.schmitt@analog.com>
To:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dan.carpenter@linaro.org>, <marcelo.schmitt1@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 12/13] iio: adc: Add support for AD7091R-8
Date:   Thu, 7 Dec 2023 15:42:56 -0300
Message-ID: <0dd8b9682728b07a30877fcb37335b5055d046ff.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: m3mQ4jr1EGOBnfBHcjTeNZlWeE66rgVD
X-Proofpoint-GUID: m3mQ4jr1EGOBnfBHcjTeNZlWeE66rgVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312070156
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
low power 12-Bit SAR ADCs with SPI interface.
Extend ad7091r-base driver so it can be used by the AD7091R-8 driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/Kconfig        |  12 ++
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ad7091r-base.c |   7 +
 drivers/iio/adc/ad7091r-base.h |   8 +
 drivers/iio/adc/ad7091r8.c     | 261 +++++++++++++++++++++++++++++++++
 5 files changed, 289 insertions(+)
 create mode 100644 drivers/iio/adc/ad7091r8.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index dcf45d7478e1..284d898790a2 100644
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
index 5a7046f6f0ce..0add6e144d63 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -188,6 +189,12 @@ int ad7091r_probe(struct device *dev, const char *name,
 	iio_dev->info = &ad7091r_info;
 	iio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (init_info->ad7091r_setup) {
+		ret = init_info->ad7091r_setup(st);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (irq) {
 		st->chip_info = &init_info->irq_info;
 		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index c554f04e7448..7140d5fd0ac2 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -45,6 +45,8 @@
 	.scan_type.realbits = bits,					\
 }
 
+#include <linux/gpio/consumer.h>
+
 struct device;
 
 enum ad7091r_mode {
@@ -56,13 +58,18 @@ enum ad7091r_mode {
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
+	const char *name;
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
 	unsigned int vref_mV;
@@ -74,6 +81,7 @@ struct ad7091r_init_info {
 	struct ad7091r_chip_info irq_info;
 	struct ad7091r_chip_info info_no_irq;
 	const struct regmap_config *regmap_config;
+	int (*ad7091r_setup)(struct ad7091r_state *st);
 	void (*ad7091r_regmap_init)(struct ad7091r_state *st,
 				    const struct regmap_config *regmap_conf);
 };
diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
new file mode 100644
index 000000000000..8dc0f784913b
--- /dev/null
+++ b/drivers/iio/adc/ad7091r8.c
@@ -0,0 +1,261 @@
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
+#define AD7091R_SPI_REGMAP_CONFIG(n) {					\
+	.reg_bits = 8,							\
+	.val_bits = 16,							\
+	.volatile_reg = ad7091r_volatile_reg,				\
+	.writeable_reg = ad7091r_writeable_reg,				\
+	.max_register = AD7091R_REG_CH_HYSTERESIS(n),			\
+}
+
+#define AD7091R_SPI_CHIP_INFO(n) {					\
+	.name = AD7091R##n##_DEV_NAME,					\
+	.channels = ad7091r##n##_channels,				\
+	.num_channels = ARRAY_SIZE(ad7091r##n##_channels),		\
+	.vref_mV = 2500,						\
+	.ad7091r_reg_result_chan_id = &ad7091r8_reg_result_chan_id,	\
+	.ad7091r_set_mode = &ad7091r8_set_mode,				\
+}
+
+#define AD7091R_SPI_CHIP_INFO_IRQ(n) {					\
+	.name = AD7091R##n##_DEV_NAME,					\
+	.channels = ad7091r##n##_channels_irq,				\
+	.num_channels = ARRAY_SIZE(ad7091r##n##_channels_irq),		\
+	.vref_mV = 2500,						\
+	.ad7091r_reg_result_chan_id = &ad7091r8_reg_result_chan_id,	\
+	.ad7091r_set_mode = &ad7091r8_set_mode,				\
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
+static struct ad7091r_init_info ad7091r2_init_info = {
+	.info_no_irq = AD7091R_SPI_CHIP_INFO(2),
+	.regmap_config = &ad7091r2_reg_conf,
+	.ad7091r_regmap_init = &ad7091r8_regmap_init,
+	.ad7091r_setup = &ad7091r8_gpio_setup
+};
+
+static struct ad7091r_init_info ad7091r4_init_info = {
+	.irq_info = AD7091R_SPI_CHIP_INFO_IRQ(4),
+	.info_no_irq = AD7091R_SPI_CHIP_INFO(4),
+	.regmap_config = &ad7091r4_reg_conf,
+	.ad7091r_regmap_init = &ad7091r8_regmap_init,
+	.ad7091r_setup = &ad7091r8_gpio_setup
+};
+
+static struct ad7091r_init_info ad7091r8_init_info = {
+	.irq_info = AD7091R_SPI_CHIP_INFO_IRQ(8),
+	.info_no_irq = AD7091R_SPI_CHIP_INFO(8),
+	.regmap_config = &ad7091r8_reg_conf,
+	.ad7091r_regmap_init = &ad7091r8_regmap_init,
+	.ad7091r_setup = &ad7091r8_gpio_setup
+};
+
+static int ad7091r8_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct ad7091r_init_info *init_info;
+
+	init_info = spi_get_device_match_data(spi);
+	if (!init_info)
+		return -EINVAL;
+
+	return ad7091r_probe(&spi->dev, id->name, init_info, NULL, spi->irq);
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
+	{}
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

