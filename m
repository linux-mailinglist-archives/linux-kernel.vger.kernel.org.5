Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4874B7C9679
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 23:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjJNVNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjJNVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 17:13:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0EED9;
        Sat, 14 Oct 2023 14:13:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507ad511315so8602e87.0;
        Sat, 14 Oct 2023 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697317980; x=1697922780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMyUmUzGR8feS8MHHaLSUawqGLPblMX7xTR7Nmoc35A=;
        b=J4aJGv4Y0jAfJ4q89GsFst2ZIjabgRk+IkRq7bn8pRxatD04M5Tbub0hJh3lLpYc00
         HARUIHVWKBD6g9vSo7inxs/awQUIxm4uy3YG76nOqSz4PmddN3S9sxUhm4YuFERRwD8b
         PHVGh2RXIOpOUxtZcw1/zzXL+443ZGvyFdb82uWuyCbFEa4Bb493+Tctt2V5UG+NOl7P
         5+cVNk0NcMDyfT6JLttNNFW5NwRhV2fanuIMS7wJC4ZdIaprJ5+eR/xQpngmRY+QIobP
         N/1kS4VlOgTDFq3TP9x3qzDdaUzBmJ84XFhzXJkJZCguQ3ir+LoQ4Ln/rVXSZU4XWANg
         HxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697317980; x=1697922780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMyUmUzGR8feS8MHHaLSUawqGLPblMX7xTR7Nmoc35A=;
        b=WhJ2Z3JvuHyIGI09WY6DZISxxA3L4OM7r2RV1L6WyS6V6CBysxJOlb9EsDtRa0DMQp
         9diiEmQI33KBdzhxr2CQBxH3gohMYx9eek6wci3ztmwS44sBrnQG1KFlFKhPyHuIQvGu
         4NmZLEq+507FNPaE6/n6aktbfoe0eeKhsfqWVZgnVhxu+lTGOFp9blvilErsH5mtPVgY
         qmY75rXuWsu/Mk01aBsgIPSZ4sD9xFjr/McbRC4volz4SRy5JEcK+FaUljyGaBR4tLpq
         e+rA4DPIj5AhWFXL3HGpl1XlRJbUAOQ+gVw3vwAeD7/ui4TEau7Cy84e04eaZ3v8z8og
         YMQw==
X-Gm-Message-State: AOJu0YyFfjIWtA+2i9oNf7TO7pFbCOuw8AKmT/UpOcihasEVFmlIVRYy
        0guYRJi88byV/MOiUTUZjOOc6N8DT7Yu5WUT
X-Google-Smtp-Source: AGHT+IGCQya/zg4gRfWGudNtDRo4vof6AfXUFV/WRwzbLOfnSfRG3hnhU9shQ1/lCvJNqB3p7LCZeQ==
X-Received: by 2002:a05:6512:210c:b0:4fb:bef0:948e with SMTP id q12-20020a056512210c00b004fbbef0948emr22291829lfr.5.1697317979480;
        Sat, 14 Oct 2023 14:12:59 -0700 (PDT)
Received: from fr.lan ([46.31.31.132])
        by smtp.googlemail.com with ESMTPSA id g3-20020a056512118300b00507a9b2eff4sm78759lfr.22.2023.10.14.14.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 14:12:59 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v6 2/2] iio: adc: Add driver support for MAX34408/9
Date:   Sun, 15 Oct 2023 00:12:54 +0300
Message-ID: <20231014211254.16719-3-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014211254.16719-1-fr0st61te@gmail.com>
References: <20231014211254.16719-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX34408/MAX34409 are two- and four-channel current monitors that are
configured and monitored with a standard I2C/SMBus serial interface. Each
unidirectional current sensor offers precision high-side operation with a
low full-scale sense voltage. The devices automatically sequence through
two or four channels and collect the current-sense samples and average them
to reduce the effect of impulse noise. The raw ADC samples are compared to
user-programmable digital thresholds to indicate overcurrent conditions.
Overcurrent conditions trigger a hardware output to provide an immediate
indication to shut down any necessary external circuitry.

Add as ADC driver which only supports current monitoring for now.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 drivers/iio/adc/Kconfig    |  11 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max34408.c | 276 +++++++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)
 create mode 100644 drivers/iio/adc/max34408.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 517b3db114b8..c215a2861350 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -735,6 +735,17 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
+config MAX34408
+	tristate "Maxim max34408/max344089 ADC driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Maxim max34408/max34409 current sense
+	  monitor with 8-bits ADC interface with overcurrent delay/threshold and
+	  shutdown delay.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max34408.
+
 config MAX77541_ADC
 	tristate "Analog Devices MAX77541 ADC driver"
 	depends on MFD_MAX77541
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 2facf979327d..46dceab85e9a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX34408) += max34408.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
new file mode 100644
index 000000000000..6c2ea2bc52c6
--- /dev/null
+++ b/drivers/iio/adc/max34408.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO driver for Maxim MAX34409/34408 ADC, 4-Channels/2-Channels, 8bits, I2C
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
+ *
+ * TODO: ALERT interrupt, Overcurrent delay, Shutdown delay
+ */
+
+#include <linux/bitfield.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#define MAX34408_STATUS_REG		0x0
+#define MAX34408_CONTROL_REG		0x1
+#define MAX34408_OCDELAY_REG		0x2
+#define MAX34408_SDDELAY_REG		0x3
+
+#define MAX34408_ADC1_REG		0x4
+#define MAX34408_ADC2_REG		0x5
+/* ADC3 & ADC4 always returns 0x0 on 34408 */
+#define MAX34409_ADC3_REG		0x6
+#define MAX34409_ADC4_REG		0x7
+
+#define MAX34408_OCT1_REG		0x8
+#define MAX34408_OCT2_REG		0x9
+#define MAX34409_OCT3_REG		0xA
+#define MAX34409_OCT4_REG		0xB
+
+#define MAX34408_DID_REG		0xC
+#define MAX34408_DCYY_REG		0xD
+#define MAX34408_DCWW_REG		0xE
+
+/* Bit masks for status register */
+#define MAX34408_STATUS_OC_MSK		GENMASK(1, 0)
+#define MAX34409_STATUS_OC_MSK		GENMASK(3, 0)
+#define MAX34408_STATUS_SHTDN		BIT(4)
+#define MAX34408_STATUS_ENA		BIT(5)
+
+/* Bit masks for control register */
+#define MAX34408_CONTROL_AVG0		BIT(0)
+#define MAX34408_CONTROL_AVG1		BIT(1)
+#define MAX34408_CONTROL_AVG2		BIT(2)
+#define MAX34408_CONTROL_ALERT		BIT(3)
+
+#define MAX34408_DEFAULT_AVG		0x4
+
+/* Bit masks for over current delay */
+#define MAX34408_OCDELAY_OCD_MSK	GENMASK(6, 0)
+#define MAX34408_OCDELAY_RESET		BIT(7)
+
+/* Bit masks for shutdown delay */
+#define MAX34408_SDDELAY_SHD_MSK	GENMASK(6, 0)
+#define MAX34408_SDDELAY_RESET		BIT(7)
+
+#define MAX34408_DEFAULT_RSENSE		1000
+
+/**
+ * struct max34408_data - max34408/max34409 specific data.
+ * @regmap:	device register map.
+ * @dev:	max34408 device.
+ * @lock:	lock for protecting access to device hardware registers, mostly
+ *		for read modify write cycles for control registers.
+ * @input_rsense:	Rsense values in uOhm, will be overwritten by
+ *			values from channel nodes.
+ */
+struct max34408_data {
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+	u32 input_rsense[4];
+};
+
+static const struct regmap_config max34408_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= MAX34408_DCWW_REG,
+};
+
+struct max34408_adc_model_data {
+	const char *model_name;
+	const struct iio_chan_spec *channels;
+	const int num_channels;
+};
+
+#define MAX34008_CHANNEL(_index, _address)			\
+	{							\
+		.type = IIO_CURRENT,				\
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
+					  BIT(IIO_CHAN_INFO_SCALE) | \
+					  BIT(IIO_CHAN_INFO_OFFSET), \
+		.channel = (_index),				\
+		.address = (_address),				\
+		.indexed = 1,					\
+	}
+
+static const struct iio_chan_spec max34408_channels[] = {
+	MAX34008_CHANNEL(0, MAX34408_ADC1_REG),
+	MAX34008_CHANNEL(1, MAX34408_ADC2_REG),
+};
+
+static const struct iio_chan_spec max34409_channels[] = {
+	MAX34008_CHANNEL(0, MAX34408_ADC1_REG),
+	MAX34008_CHANNEL(1, MAX34408_ADC2_REG),
+	MAX34008_CHANNEL(2, MAX34409_ADC3_REG),
+	MAX34008_CHANNEL(3, MAX34409_ADC4_REG),
+};
+
+static int max34408_read_adc_avg(struct max34408_data *max34408,
+				 const struct iio_chan_spec *chan, int *val)
+{
+	unsigned int ctrl;
+	int rc;
+
+	guard(mutex)(&max34408->lock);
+	rc = regmap_read(max34408->regmap, MAX34408_CONTROL_REG, (u32 *)&ctrl);
+	if (rc)
+		return rc;
+
+	/* set averaging (0b100) default values*/
+	rc = regmap_write(max34408->regmap, MAX34408_CONTROL_REG,
+			  MAX34408_DEFAULT_AVG);
+	if (rc) {
+		dev_err(max34408->dev,
+			"Error (%d) writing control register\n", rc);
+		return rc;
+	}
+
+	rc = regmap_read(max34408->regmap, chan->address, val);
+	if (rc)
+		return rc;
+
+	/* back to old values */
+	rc = regmap_write(max34408->regmap, MAX34408_CONTROL_REG, ctrl);
+	if (rc)
+		dev_err(max34408->dev,
+			"Error (%d) writing control register\n", rc);
+
+	return rc;
+}
+
+static int max34408_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max34408_data *max34408 = iio_priv(indio_dev);
+	int rc;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		rc = max34408_read_adc_avg(max34408, chan, val);
+		if (rc)
+			return rc;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * calcluate current for 8bit ADC with Rsense
+		 * value.
+		 * 10 mV * 1000 / Rsense uOhm = max current
+		 * (max current * adc val * 1000) / (2^8 - 1) mA
+		 */
+		*val = 10000 / max34408->input_rsense[chan->channel];
+		*val2 = 8;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max34408_info = {
+	.read_raw	= max34408_read_raw,
+};
+
+static const struct max34408_adc_model_data max34408_model_data = {
+	.model_name = "max34408",
+	.channels = max34408_channels,
+	.num_channels = 2,
+};
+
+static const struct max34408_adc_model_data max34409_model_data = {
+	.model_name = "max34409",
+	.channels = max34409_channels,
+	.num_channels = 4,
+};
+
+static int max34408_probe(struct i2c_client *client)
+{
+	const struct max34408_adc_model_data *model_data;
+	struct device *dev = &client->dev;
+	struct max34408_data *max34408;
+	struct fwnode_handle *node;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int rc, i = 0;
+
+	model_data = i2c_get_match_data(client);
+	if (!model_data)
+		return -EINVAL;
+
+	regmap = devm_regmap_init_i2c(client, &max34408_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err_probe(dev, PTR_ERR(regmap),
+			      "regmap_init failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*max34408));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	max34408 = iio_priv(indio_dev);
+	max34408->regmap = regmap;
+	max34408->dev = dev;
+	mutex_init(&max34408->lock);
+
+	device_for_each_child_node(dev, node) {
+		fwnode_property_read_u32(node, "maxim,rsense-val-micro-ohms",
+					 &max34408->input_rsense[i]);
+		i++;
+	}
+
+	/* disable ALERT and averaging */
+	rc = regmap_write(max34408->regmap, MAX34408_CONTROL_REG, 0x0);
+	if (rc)
+		return rc;
+
+	indio_dev->channels = model_data->channels;
+	indio_dev->num_channels = model_data->num_channels;
+	indio_dev->name = model_data->model_name;
+
+	indio_dev->info = &max34408_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id max34408_of_match[] = {
+	{
+		.compatible = "maxim,max34408",
+		.data = &max34408_model_data,
+	},
+	{
+		.compatible = "maxim,max34409",
+		.data = &max34409_model_data,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, max34408_of_match);
+
+static const struct i2c_device_id max34408_id[] = {
+	{ "max34408", (kernel_ulong_t)&max34408_model_data },
+	{ "max34409", (kernel_ulong_t)&max34409_model_data },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, max34408_id);
+
+static struct i2c_driver max34408_driver = {
+	.driver = {
+		.name   = "max34408",
+		.of_match_table = max34408_of_match,
+	},
+	.probe = max34408_probe,
+	.id_table = max34408_id,
+};
+module_i2c_driver(max34408_driver);
+
+MODULE_AUTHOR("Ivan Mikhaylov <fr0st61te@gmail.com>");
+MODULE_DESCRIPTION("Maxim MAX34408/34409 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.42.0

