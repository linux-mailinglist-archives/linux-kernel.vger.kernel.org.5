Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE257A3DC9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjIQVMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbjIQVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:12:02 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A112A;
        Sun, 17 Sep 2023 14:11:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso61552461fa.1;
        Sun, 17 Sep 2023 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694985114; x=1695589914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR0dF66Xzv3ASXk+JgLCo3Ex4ZJDHC7199qzFfOVypU=;
        b=VWo2BSUm1SW62OjDVWiKTDE5D8ZssUOD3Ov+Lq19Ykl+WW6mnZJyY1arlqr+JueMMy
         mhuTbgiGMcu1eh+DZsG1h/vD8HGh8KZdnmb+k/fBP6J+kNjHQallRmGVcciygeXPfg9d
         sFQ+lYndUxOlrpB2dUILAcXUGjOl8DG5NObp/DekQ9fu6hpTToVcjJv+U2iNfu+yLPEJ
         hb/mbcJoyPxVj+vRLZB5TcJfj92iAydWgXjHDEq/fUU9kHWP5rCU4oFoTPdjAp0PD/7j
         mcumSu0uGWZlDA9/M4O7pPc2Iv6aRuNqmemgLXPVD/BVpP3J9COSShf5UL6h1LA8Yzrz
         HlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694985114; x=1695589914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR0dF66Xzv3ASXk+JgLCo3Ex4ZJDHC7199qzFfOVypU=;
        b=FrIX1DarhVEMvBQF7iLMIY2ToquG8V+NVXKXZ8auCj2Hy8JIkeuoBxpxJJbKSjysrj
         Q/CR4BbMzIEkhd9ojFypn/1clVBoHARXDBq2NNAp6cfOqLlWtFHjjREAsoXS/Af8oRtT
         3wZ7HZJuovSXdd1DPXVOkEU4VmFZZ363hJnJbdS0EbOVRAYktsrXls77UeCLm9bWm76C
         HlozhAn6p+bsN4QkH1GX7yGgxY/zundLjbtgb3eYY1zyJCfd2lzCOlIHn7+0BtBtF5o/
         H2TkvhlndXraK48S/K1TuYQQEp2oGZIFx3taMXhcU12UL+eQLSwo8loRT1FhQrOJk+UM
         1Y0A==
X-Gm-Message-State: AOJu0Yw0bkSxESQeSNrGkes7Lsnio/iFr/E/ts7J2OARO5nGEYKXI1Xg
        qyAjRn23S2CyhlBaB+kbTPg=
X-Google-Smtp-Source: AGHT+IH41jA9YQfRuUnwluAyEtt1XT3Bwt9XAtb/xoQQJF4CsLjunp7UudVlEyQeNBifIKoVj+TzoQ==
X-Received: by 2002:a2e:9d98:0:b0:2bd:e3e:1a23 with SMTP id c24-20020a2e9d98000000b002bd0e3e1a23mr6334883ljj.45.1694985114198;
        Sun, 17 Sep 2023 14:11:54 -0700 (PDT)
Received: from fr.lan ([46.31.31.48])
        by smtp.googlemail.com with ESMTPSA id p15-20020a2e740f000000b002bce3123639sm1766309ljc.98.2023.09.17.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 14:11:53 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH 2/2] iio: adc: Add driver support for MAX34408/9
Date:   Mon, 18 Sep 2023 00:11:43 +0300
Message-ID: <20230917211143.7094-3-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917211143.7094-1-fr0st61te@gmail.com>
References: <20230917211143.7094-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iio/adc/max34408.c | 334 +++++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/iio/adc/max34408.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 517b3db114b8..538b086ed593 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -756,6 +756,17 @@ config MAX9611
 	  To compile this driver as a module, choose M here: the module will be
 	  called max9611.
 
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
 config MCP320X
 	tristate "Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 2facf979327d..8fee08546bcc 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
+obj-$(CONFIG_MAX34408) += max34408.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MCP3911) += mcp3911.o
diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
new file mode 100644
index 000000000000..96c1de59edb5
--- /dev/null
+++ b/drivers/iio/adc/max34408.c
@@ -0,0 +1,334 @@
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
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#define MAX34408_STATUS		0x0
+#define MAX34408_CONTROL	0x1
+#define MAX34408_OCDELAY	0x2
+#define MAX34408_SDDELAY	0x3
+
+#define MAX34408_ADC1		0x4
+#define MAX34408_ADC2		0x5
+/* ADC3 & ADC4 always returns 0x0 on 34408 */
+#define MAX34408_ADC3		0x6
+#define MAX34408_ADC4		0x7
+
+#define MAX34408_OCT1		0x8
+#define MAX34408_OCT2		0x9
+#define MAX34408_OCT3		0xA
+#define MAX34408_OCT4		0xB
+
+#define MAX34408_DID		0xC
+#define MAX34408_DCYY		0xD
+#define MAX34408_DCWW		0xE
+
+#define MAX34408_CHANNELS	2
+#define MAX34409_CHANNELS	4
+
+/* Bit masks for status register */
+#define STATUS_OC1		BIT(0)
+#define STATUS_OC2		BIT(1)
+/* OC3 & OC4 only for max34409 */
+#define STATUS_OC3		BIT(2)
+#define STATUS_OC4		BIT(3)
+#define STATUS_SHTDN		BIT(4)
+#define STATUS_ENA		BIT(5)
+
+/* Bit masks for control register */
+#define CONTROL_AVG0		BIT(0)
+#define CONTROL_AVG1		BIT(1)
+#define CONTROL_AVG2		BIT(2)
+#define CONTROL_ALERT		BIT(3)
+
+/* Bit masks for over current delay */
+#define OCDELAY_OCD0		BIT(0)
+#define OCDELAY_OCD1		BIT(1)
+#define OCDELAY_OCD2		BIT(2)
+#define OCDELAY_OCD3		BIT(3)
+#define OCDELAY_OCD4		BIT(4)
+#define OCDELAY_OCD5		BIT(5)
+#define OCDELAY_OCD6		BIT(6)
+#define OCDELAY_RESET		BIT(7)
+
+/* Bit masks for shutdown delay */
+#define SDDELAY_SHD0		BIT(0)
+#define SDDELAY_SHD1		BIT(1)
+#define SDDELAY_SHD2		BIT(2)
+#define SDDELAY_SHD3		BIT(3)
+#define SDDELAY_SHD4		BIT(4)
+#define SDDELAY_SHD5		BIT(5)
+#define SDDELAY_SHD6		BIT(6)
+#define SDDELAY_RESET		BIT(7)
+
+/**
+ * struct max34408_data - max34408/max34409 specific data.
+ * @regmap:	device register map.
+ * @dev:	max34408 device.
+ * @lock:	lock for protecting access to device hardware registers.
+ * @rsense:	Rsense value in uOhm.
+ */
+struct max34408_data {
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+	u32 rsense;
+};
+
+static const struct regmap_config max34408_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= MAX34408_DCWW,
+};
+
+static const struct iio_chan_spec max34408_channels[] = {
+	{
+		.type			= IIO_CURRENT,
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+					  BIT(IIO_CHAN_INFO_PROCESSED) |
+					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
+		.channel		= 0,
+		.indexed = 1,
+	},
+	{
+		.type			= IIO_CURRENT,
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+					  BIT(IIO_CHAN_INFO_PROCESSED) |
+					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
+		.channel		= 1,
+		.indexed = 1,
+	},
+};
+
+static const struct iio_chan_spec max34409_channels[] = {
+	{
+		.type			= IIO_CURRENT,
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+					  BIT(IIO_CHAN_INFO_PROCESSED) |
+					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
+		.channel		= 0,
+		.indexed = 1,
+	},
+	{
+		.type			= IIO_CURRENT,
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+					  BIT(IIO_CHAN_INFO_PROCESSED) |
+					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
+		.channel		= 1,
+		.indexed = 1,
+	},
+	{
+		.type			= IIO_CURRENT,
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+					  BIT(IIO_CHAN_INFO_PROCESSED) |
+					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
+		.channel		= 2,
+		.indexed = 1,
+	},
+	{
+		.type			= IIO_CURRENT,
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+					  BIT(IIO_CHAN_INFO_PROCESSED) |
+					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
+		.channel		= 3,
+		.indexed = 1,
+	},
+};
+
+static int max34408_read_adc(struct max34408_data *max34408, int channel,
+			     int *val)
+{
+	int rc;
+	u32 adc_reg;
+
+	switch (channel) {
+	case 0:
+		adc_reg = MAX34408_ADC1;
+		break;
+	case 1:
+		adc_reg = MAX34408_ADC2;
+		break;
+	case 2:
+		adc_reg = MAX34408_ADC3;
+		break;
+	case 3:
+		adc_reg = MAX34408_ADC4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rc = regmap_read(max34408->regmap, adc_reg, val);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int max34408_read_adc_avg(struct max34408_data *max34408, int channel, int *val)
+{
+	unsigned long ctrl;
+	int rc;
+	u8 tmp;
+
+	mutex_lock(&max34408->lock);
+	rc = regmap_read(max34408->regmap, MAX34408_CONTROL, (u32 *)&ctrl);
+	if (rc)
+		goto err_unlock;
+
+	/* set averaging (0b100) default values*/
+	tmp = ctrl;
+	set_bit(CONTROL_AVG2, &ctrl);
+	clear_bit(CONTROL_AVG1, &ctrl);
+	clear_bit(CONTROL_AVG0, &ctrl);
+	rc = regmap_write(max34408->regmap, MAX34408_CONTROL, ctrl);
+	if (rc) {
+		dev_err(max34408->dev,
+			"Error (%d) writing control register\n", rc);
+		goto err_unlock;
+	}
+
+	rc = max34408_read_adc(max34408, channel, val);
+	if (rc)
+		goto err_unlock;
+
+	/* back to old values */
+	rc = regmap_write(max34408->regmap, MAX34408_CONTROL, tmp);
+	if (rc)
+		dev_err(max34408->dev,
+			"Error (%d) writing control register\n", rc);
+
+err_unlock:
+	mutex_unlock(&max34408->lock);
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
+	case IIO_CHAN_INFO_PROCESSED:
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		rc = max34408_read_adc_avg(max34408, chan->channel,
+					   val);
+		if (rc)
+			return rc;
+
+		if (mask == IIO_CHAN_INFO_PROCESSED) {
+			/*
+			 * calcluate current for 8bit ADC with Rsense
+			 * value.
+			 * 10 mV * 1000 / Rsense uOhm = max current
+			 * (max current * adc val * 1000) / (2^8 - 1) mA
+			 */
+			*val = DIV_ROUND_CLOSEST((10000 / max34408->rsense) *
+						 *val * 1000, 256);
+		}
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		rc = max34408_read_adc(max34408, chan->channel, val);
+		if (rc)
+			return rc;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max34408_info = {
+	.read_raw	= max34408_read_raw,
+};
+
+static int max34408_probe(struct i2c_client *client)
+{
+	struct device_node *np = client->dev.of_node;
+	struct max34408_data *max34408;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int rc;
+
+	regmap = devm_regmap_init_i2c(client, &max34408_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "regmap_init failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max34408));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	max34408 = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	max34408->regmap = regmap;
+	max34408->dev = &client->dev;
+	mutex_init(&max34408->lock);
+	rc = device_property_read_u32(&client->dev,
+				      "maxim,rsense-val-micro-ohms",
+				      &max34408->rsense);
+	if (rc)
+		return -EINVAL;
+
+	/* disable ALERT and averaging */
+	rc = regmap_write(max34408->regmap, MAX34408_CONTROL, 0x0);
+	if (rc)
+		return rc;
+
+	if (of_device_is_compatible(np, "maxim,max34408")) {
+		indio_dev->channels = max34408_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max34408_channels);
+		indio_dev->name = "max34408";
+	} else if (of_device_is_compatible(np, "maxim,max34409")) {
+		indio_dev->channels = max34409_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max34409_channels);
+		indio_dev->name = "max34409";
+	}
+	indio_dev->info = &max34408_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.of_node = np;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id max34408_of_match[] = {
+	{
+		.compatible = "maxim,max34408",
+	},
+	{
+		.compatible = "maxim,max34409",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, max34408_of_match);
+
+static struct i2c_driver max34408_driver = {
+	.driver = {
+		.name   = "max34408",
+		.of_match_table = max34408_of_match,
+	},
+	.probe = max34408_probe,
+};
+module_i2c_driver(max34408_driver);
+
+MODULE_AUTHOR("Ivan Mikhaylov <fr0st61te@gmail.com>");
+MODULE_DESCRIPTION("Maxim MAX34408/34409 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.42.0

