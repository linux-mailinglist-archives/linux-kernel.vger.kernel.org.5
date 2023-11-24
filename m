Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62B27F7212
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbjKXKwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbjKXKv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:51:58 -0500
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B71018E;
        Fri, 24 Nov 2023 02:52:04 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AO78UKr003310;
        Fri, 24 Nov 2023 05:51:43 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ujq65gms4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 05:51:43 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3AOApgmP005751
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Nov 2023 05:51:42 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 24 Nov 2023 05:51:41 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 24 Nov 2023 05:51:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 24 Nov 2023 05:51:41 -0500
Received: from kimedia-VirtualBox.ad.analog.com (KPALLER2-L02.ad.analog.com [10.116.242.88])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3AOApMWb024857;
        Fri, 24 Nov 2023 05:51:33 -0500
From:   Kim Seer Paller <kimseer.paller@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Kim Seer Paller" <kimseer.paller@analog.com>,
        Crt Mori <cmo@melexis.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/2] iio: frequency: admfm2000: New driver
Date:   Fri, 24 Nov 2023 18:51:16 +0800
Message-ID: <20231124105116.5764-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124105116.5764-1-kimseer.paller@analog.com>
References: <20231124105116.5764-1-kimseer.paller@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: dCf6mjxOzhCr6BDisTVjISSq14Xa1wfT
X-Proofpoint-GUID: dCf6mjxOzhCr6BDisTVjISSq14Xa1wfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2311240085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dual microwave down converter module with input RF and LO frequency
ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
for each down conversion path.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V4 -> V5: Added missing return -ENODEV in setup function. Reordered variable
	  declarations in probe function.
V1 -> V4: No changes.

 MAINTAINERS                       |   1 +
 drivers/iio/frequency/Kconfig     |  10 +
 drivers/iio/frequency/Makefile    |   1 +
 drivers/iio/frequency/admfm2000.c | 310 ++++++++++++++++++++++++++++++
 4 files changed, 322 insertions(+)
 create mode 100644 drivers/iio/frequency/admfm2000.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f1692ec68..d8630e490 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1253,6 +1253,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
+F:	drivers/iio/frequency/admfm2000.c
 
 ANALOG DEVICES INC ADMV1013 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 9e85dfa58..c455be7d4 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -60,6 +60,16 @@ config ADF4377
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4377.
 
+config ADMFM2000
+	tristate "Analog Devices ADMFM2000 Dual Microwave Down Converter"
+	depends on GPIOLIB
+	help
+	  Say yes here to build support for Analog Devices ADMFM2000 Dual
+	  Microwave Down Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called admfm2000.
+
 config ADMV1013
 	tristate "Analog Devices ADMV1013 Microwave Upconverter"
 	depends on SPI && COMMON_CLK
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index b616c29b4..70d0e0b70 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
 obj-$(CONFIG_ADF4377) += adf4377.o
+obj-$(CONFIG_ADMFM2000) += admfm2000.o
 obj-$(CONFIG_ADMV1013) += admv1013.o
 obj-$(CONFIG_ADMV1014) += admv1014.o
 obj-$(CONFIG_ADMV4420) += admv4420.o
diff --git a/drivers/iio/frequency/admfm2000.c b/drivers/iio/frequency/admfm2000.c
new file mode 100644
index 000000000..351fb9044
--- /dev/null
+++ b/drivers/iio/frequency/admfm2000.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADMFM2000 Dual Microwave Down Converter
+ *
+ * Copyright 2023 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+#define ADMFM2000_MIXER_MODE		0
+#define ADMFM2000_DIRECT_IF_MODE	1
+#define ADMF20000_DSA_GPIOS		5
+#define ADMF20000_MODE_GPIOS		2
+#define ADMF20000_MAX_GAIN		0
+#define ADMF20000_MIN_GAIN		-31000
+#define ADMF20000_DEFAULT_GAIN		-0x20
+
+struct admfm2000_state {
+	struct mutex			lock; /* protect sensor state */
+	struct gpio_descs		*sw_ch[2];
+	struct gpio_descs		*dsa_gpios[2];
+	u32				gain[2];
+};
+
+static int admfm2000_mode(struct iio_dev *indio_dev, u32 reg, u32 mode)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	DECLARE_BITMAP(values, 2);
+
+	switch (mode) {
+	case ADMFM2000_MIXER_MODE:
+		values[0] = (reg == 0) ? 1 : 2;
+		gpiod_set_array_value_cansleep(st->sw_ch[reg]->ndescs,
+					       st->sw_ch[reg]->desc,
+					       NULL, values);
+		break;
+	case ADMFM2000_DIRECT_IF_MODE:
+		values[0] = (reg == 0) ? 2 : 1;
+		gpiod_set_array_value_cansleep(st->sw_ch[reg]->ndescs,
+					       st->sw_ch[reg]->desc,
+					       NULL, values);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int admfm2000_attenuation(struct iio_dev *indio_dev, u32 chan,
+				 u32 value)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	DECLARE_BITMAP(values, BITS_PER_TYPE(value));
+
+	values[0] = value;
+
+	gpiod_set_array_value_cansleep(st->dsa_gpios[chan]->ndescs,
+				       st->dsa_gpios[chan]->desc,
+				       NULL, values);
+	return 0;
+}
+
+static int admfm2000_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int *val,
+			      int *val2, long mask)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int gain;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		mutex_lock(&st->lock);
+		gain = ~(st->gain[chan->channel]) * -1000;
+		*val = gain / 1000;
+		*val2 = (gain % 1000) * 1000;
+		mutex_unlock(&st->lock);
+
+		return  IIO_VAL_INT_PLUS_MICRO_DB;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admfm2000_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int gain, ret;
+
+	if (val < 0)
+		gain = (val * 1000) - (val2 / 1000);
+	else
+		gain = (val * 1000) + (val2 / 1000);
+
+	if (gain > ADMF20000_MAX_GAIN || gain < ADMF20000_MIN_GAIN)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		mutex_lock(&st->lock);
+		st->gain[chan->channel] = ~((abs(gain) / 1000) & 0x1F);
+
+		ret = admfm2000_attenuation(indio_dev, chan->channel,
+					    st->gain[chan->channel]);
+
+		mutex_unlock(&st->lock);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int admfm2000_write_raw_get_fmt(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return IIO_VAL_INT_PLUS_MICRO_DB;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info admfm2000_info = {
+	.read_raw = &admfm2000_read_raw,
+	.write_raw = &admfm2000_write_raw,
+	.write_raw_get_fmt = &admfm2000_write_raw_get_fmt,
+};
+
+#define ADMFM2000_CHAN(_channel) {					\
+	.type = IIO_VOLTAGE,						\
+	.output = 1,							\
+	.indexed = 1,							\
+	.channel = _channel,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
+}
+
+static const struct iio_chan_spec admfm2000_channels[] = {
+	ADMFM2000_CHAN(0),
+	ADMFM2000_CHAN(1),
+};
+
+static int admfm2000_channel_config(struct admfm2000_state *st,
+				    struct iio_dev *indio_dev)
+{
+	struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *child;
+	u32 reg, mode;
+	int ret;
+
+	device_for_each_child_node(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, ret,
+					     "Failed to get reg property\n");
+		}
+
+		if (reg >= indio_dev->num_channels) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL, "reg bigger than: %d\n",
+					     indio_dev->num_channels);
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,mode", &mode);
+		if (ret) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, ret,
+					     "Failed to get mode property\n");
+		}
+
+		if (mode >= 2) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL, "mode bigger than: 1\n");
+		}
+
+		ret = admfm2000_mode(indio_dev, reg, mode);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int admfm2000_setup(struct admfm2000_state *st,
+			   struct iio_dev *indio_dev)
+{
+	struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
+	struct device *dev = &pdev->dev;
+
+	st->sw_ch[0] = devm_gpiod_get_array(dev, "switch1", GPIOD_OUT_LOW);
+	if (IS_ERR(st->sw_ch[0]))
+		return dev_err_probe(dev, PTR_ERR(st->sw_ch[0]),
+				     "Failed to get gpios\n");
+
+	if (st->sw_ch[0]->ndescs != ADMF20000_MODE_GPIOS) {
+		dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
+			      ADMF20000_MODE_GPIOS);
+		return -ENODEV;
+	}
+
+	st->sw_ch[1] = devm_gpiod_get_array(dev, "switch2", GPIOD_OUT_LOW);
+	if (IS_ERR(st->sw_ch[1]))
+		return dev_err_probe(dev, PTR_ERR(st->sw_ch[1]),
+				     "Failed to get gpios\n");
+
+	if (st->sw_ch[1]->ndescs != ADMF20000_MODE_GPIOS) {
+		dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
+			      ADMF20000_MODE_GPIOS);
+		return -ENODEV;
+	}
+
+	st->dsa_gpios[0] = devm_gpiod_get_array(dev, "attenuation1",
+						GPIOD_OUT_LOW);
+	if (IS_ERR(st->dsa_gpios[0]))
+		return dev_err_probe(dev, PTR_ERR(st->dsa_gpios[0]),
+				     "Failed to get gpios\n");
+
+	if (st->dsa_gpios[0]->ndescs != ADMF20000_DSA_GPIOS) {
+		dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
+			      ADMF20000_DSA_GPIOS);
+		return -ENODEV;
+	}
+
+	st->dsa_gpios[1] = devm_gpiod_get_array(dev, "attenuation2",
+						GPIOD_OUT_LOW);
+	if (IS_ERR(st->dsa_gpios[1]))
+		return dev_err_probe(dev, PTR_ERR(st->dsa_gpios[1]),
+				     "Failed to get gpios\n");
+
+	if (st->dsa_gpios[1]->ndescs != ADMF20000_DSA_GPIOS) {
+		dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
+			      ADMF20000_DSA_GPIOS);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int admfm2000_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct admfm2000_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	indio_dev->name = "admfm2000";
+	indio_dev->num_channels = ARRAY_SIZE(admfm2000_channels);
+	indio_dev->channels = admfm2000_channels;
+	indio_dev->info = &admfm2000_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	st->gain[0] = ADMF20000_DEFAULT_GAIN;
+	st->gain[1] = ADMF20000_DEFAULT_GAIN;
+
+	mutex_init(&st->lock);
+
+	ret = admfm2000_setup(st, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = admfm2000_channel_config(st, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id admfm2000_of_match[] = {
+	{ .compatible = "adi,admfm2000" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, admfm2000_of_match);
+
+static struct platform_driver admfm2000_driver = {
+	.driver = {
+		.name = "admfm2000",
+		.of_match_table = admfm2000_of_match,
+	},
+	.probe = admfm2000_probe,
+};
+module_platform_driver(admfm2000_driver);
+
+MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
+MODULE_DESCRIPTION("ADMFM2000 Dual Microwave Down Converter");
+MODULE_LICENSE("GPL");
-- 
2.34.1

