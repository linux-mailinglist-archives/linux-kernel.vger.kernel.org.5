Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A47650A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjG0KLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjG0KLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:11:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CED136;
        Thu, 27 Jul 2023 03:11:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so1337811e87.1;
        Thu, 27 Jul 2023 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690452696; x=1691057496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xioESDlEZRXvAywpPVcmCtLFXIaE7Ja4TwB5X0jtFI=;
        b=hEvNYIQAgP+QPUbFn88d8dpaeM6Zr0tikkHYFoZ5OcUGYYU2YYO3slrKgstkBlSOi4
         hNTh0Ahn2cLfIw/BstYTFV5Zx9kIbl9iBXdXSvwDWFZNpLt5wKHuQCvCPXkUaKfVfZH8
         gI/7bCEyavBdTXN+uIQal5CCVe3s+st7pXm6LtTKyYfBeq86MiWm8/dp8EakUwg9GT+4
         AF3DLLh6XGV9FjAr/mWIb3bv9K6wxVYSW5uORY4Z87wxtQPAyKHTPbvPSoEubMaF2pB5
         PCqvurf3AMNay9yshGm7iWsBPEtuD2VSIAuxbduMLPkYKZqwYgryu4Z5uIbfLsGKUhkd
         buQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690452696; x=1691057496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xioESDlEZRXvAywpPVcmCtLFXIaE7Ja4TwB5X0jtFI=;
        b=WoQz63Z3sO4gwRET+qkhwrrmAZI5GMIUtkuOiG8aIZg90E52aSTFRJBoxZ3nUDlCYw
         UM+yhsLhu2B8ft76RCGwbcWvUzPe925Yy/tVQH/bAeQluk76VkUnnWfV/vKPvFvCZ+wo
         nF2DYUtycQ4LCBk8DdDNs7wcLyODXQCjxSwb7+MghbReJuamKk0QReTx8vaBaXd/VEBo
         SimkHSiUi9GK06fcinbO9k00WWXerZ31twS+6PrHzZMGqgUZzBgPnKFEIUWE1kIh+tXi
         BZ/3g7CIegiTfnMcYtoAMSYEzbUtkUavAxuGosXda+0KRe4j78ATvqHmGZWqu5mtrpGq
         OS8g==
X-Gm-Message-State: ABy/qLaKy8qyQySdCqw7tDCAwtFYpPXmJpaM2rTgo8XK6RHuHhrWdrtH
        7P7P/6UXYI4T6Y2nsf0QsKg=
X-Google-Smtp-Source: APBJJlEMmVquXSTHgeFboDTQg723iuV8l2OUObF5OAbi+zIaSEeO/noaSip9eW+XW/Ll6gbSuR/W6w==
X-Received: by 2002:a05:6512:313c:b0:4fb:9f93:365e with SMTP id p28-20020a056512313c00b004fb9f93365emr1252285lfd.41.1690452695457;
        Thu, 27 Jul 2023 03:11:35 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 3-20020ac24843000000b004fb504b0f32sm243664lfy.69.2023.07.27.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 03:11:34 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Thu, 27 Jul 2023 12:13:18 +0200
Message-Id: <20230727101318.2764379-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230727101318.2764379-1-marcus.folkesson@gmail.com>
References: <20230727101318.2764379-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip does have many similar chips, add support for those.

The new supported chips are:
  - microchip,mcp3910
  - microchip,mcp3912
  - microchip,mcp3913
  - microchip,mcp3914
  - microchip,mcp3918
  - microchip,mcp3919

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 377 +++++++++++++++++++++++++++++++-------
 1 file changed, 314 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 974c5bd923a6..def3944e2508 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -61,12 +61,44 @@
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 6) | (0 << 0)) & 0xff)
 #define MCP3911_REG_MASK		GENMASK(4, 1)
 
-#define MCP3911_NUM_CHANNELS		2
 #define MCP3911_NUM_SCALES		6
 
+
+/* These registers are common for all chips in the family except MCP3911 */
+#define MCP39XX_REG_STATUSCOM		0x0c
+#define MCP39XX_STATUSCOM_READ		GENMASK(23, 22)
+#define MCP39XX_STATUSCOM_DRHIZ         BIT(20)
+
+#define MCP39XX_REG_GAIN		0x0b
+
+#define MCP39XX_REG_CONFIG0		0x0d
+#define MCP39XX_CONFIG0_EN_OFFCAL	BIT(23)
+#define MCP39XX_CONFIG0_OSR		GENMASK(15, 13)
+
+#define MCP39XX_REG_CONFIG1		0x0e
+#define MCP39XX_CONFIG1_CLKEXT		BIT(6)
+#define MCP39XX_CONFIG1_VREFEXT		BIT(7)
+
+#define MCP39XX_REG_OFFCAL_CH0		0x0f
+#define MCP39XX_OFFCAL(x)		(MCP39XX_REG_OFFCAL_CH0 + x * 6)
+
+
+/* Maximal number of channels used by the MCP39XX family */
+#define MCP39XX_MAX_NUM_CHANNELS	8
+
 static const int mcp3911_osr_table[] = { 32, 64, 128, 256, 512, 1024, 2048, 4096 };
 static u32 mcp3911_scale_table[MCP3911_NUM_SCALES][2];
 
+enum mcp3911_id {
+	MCP3910,
+	MCP3911,
+	MCP3912,
+	MCP3913,
+	MCP3914,
+	MCP3918,
+	MCP3919,
+};
+
 struct mcp3911 {
 	struct spi_device *spi;
 	struct mutex lock;
@@ -74,14 +106,15 @@ struct mcp3911 {
 	struct clk *clki;
 	u32 dev_addr;
 	struct iio_trigger *trig;
-	u32 gain[MCP3911_NUM_CHANNELS];
+	u32 gain[MCP39XX_MAX_NUM_CHANNELS];
+	enum mcp3911_id chipid;
 	struct {
-		u32 channels[MCP3911_NUM_CHANNELS];
+		u32 channels[MCP39XX_MAX_NUM_CHANNELS];
 		s64 ts __aligned(8);
 	} scan;
 
-	u8 tx_buf __aligned(IIO_DMA_MINALIGN);
-	u8 rx_buf[MCP3911_NUM_CHANNELS * 3];
+	u8 tx_buf[MCP39XX_MAX_NUM_CHANNELS * 3] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[MCP39XX_MAX_NUM_CHANNELS * 3];
 };
 
 static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
@@ -182,19 +215,28 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_OFFSET:
-		ret = mcp3911_read(adc,
-				   MCP3911_OFFCAL(channel->channel), val, 3);
+		if (adc->chipid == MCP3911)
+			ret = mcp3911_read(adc,
+					   MCP3911_OFFCAL(channel->channel), val, 3);
+		else
+			ret = mcp3911_read(adc,
+					   MCP39XX_OFFCAL(channel->channel), val, 3);
 		if (ret)
 			goto out;
 
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = mcp3911_read(adc, MCP3911_REG_CONFIG, val, 2);
+		if (adc->chipid == MCP3911) {
+			ret = mcp3911_read(adc, MCP3911_REG_CONFIG, val, 2);
+			*val = FIELD_GET(MCP3911_CONFIG_OSR, *val);
+		} else {
+			ret = mcp3911_read(adc, MCP39XX_REG_CONFIG0, val, 3);
+			*val = FIELD_GET(MCP39XX_CONFIG0_OSR, *val);
+		}
 		if (ret)
 			goto out;
 
-		*val = FIELD_GET(MCP3911_CONFIG_OSR, *val);
 		*val = 32 << *val;
 		ret = IIO_VAL_INT;
 		break;
@@ -226,9 +268,15 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 				val2 == mcp3911_scale_table[i][1]) {
 
 				adc->gain[channel->channel] = BIT(i);
-				ret = mcp3911_update(adc, MCP3911_REG_GAIN,
-						MCP3911_GAIN_MASK(channel->channel),
-						MCP3911_GAIN_VAL(channel->channel, i), 1);
+
+				if (adc->chipid == MCP3911)
+					ret = mcp3911_update(adc, MCP3911_REG_GAIN,
+							MCP3911_GAIN_MASK(channel->channel),
+							MCP3911_GAIN_VAL(channel->channel, i), 1);
+				else
+					ret = mcp3911_update(adc, MCP39XX_REG_GAIN,
+							MCP3911_GAIN_MASK(channel->channel),
+							MCP3911_GAIN_VAL(channel->channel, i), 3);
 			}
 		}
 		break;
@@ -238,24 +286,45 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		/* Write offset */
-		ret = mcp3911_write(adc, MCP3911_OFFCAL(channel->channel), val,
-				    3);
-		if (ret)
-			goto out;
+		if (adc->chipid == MCP3911) {
+			/* Write offset */
+			ret = mcp3911_write(adc, MCP3911_OFFCAL(channel->channel), val,
+					    3);
+			if (ret)
+				goto out;
+
+			/* Enable offset*/
+			ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM,
+					MCP3911_STATUSCOM_EN_OFFCAL,
+					MCP3911_STATUSCOM_EN_OFFCAL, 2);
+		} else {
+			/* Write offset */
+			ret = mcp3911_write(adc, MCP39XX_OFFCAL(channel->channel), val,
+					    3);
+			if (ret)
+				goto out;
+
+			/* Enable offset*/
+			ret = mcp3911_update(adc, MCP39XX_REG_CONFIG0,
+					MCP39XX_CONFIG0_EN_OFFCAL,
+					MCP39XX_CONFIG0_EN_OFFCAL, 3);
+		}
 
-		/* Enable offset*/
-		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM,
-				MCP3911_STATUSCOM_EN_OFFCAL,
-				MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		for (int i = 0; i < ARRAY_SIZE(mcp3911_osr_table); i++) {
 			if (val == mcp3911_osr_table[i]) {
-				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
-				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
-						val, 2);
+				if (adc->chipid == MCP3911) {
+					val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
+					ret = mcp3911_update(adc, MCP3911_REG_CONFIG,
+							MCP3911_CONFIG_OSR, val, 2);
+
+				} else {
+					val = FIELD_PREP(MCP39XX_CONFIG0_OSR, i);
+					ret = mcp3911_update(adc, MCP39XX_REG_CONFIG0,
+							MCP39XX_CONFIG0_OSR, val, 3);
+				}
 				break;
 			}
 		}
@@ -305,6 +374,11 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 	return 0;
 }
 
+struct mcp3911_chip_info {
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
 #define MCP3911_CHAN(idx) {					\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
@@ -326,33 +400,108 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 		},						\
 }
 
+static const struct iio_chan_spec mcp3910_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
 static const struct iio_chan_spec mcp3911_channels[] = {
 	MCP3911_CHAN(0),
 	MCP3911_CHAN(1),
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static const struct iio_chan_spec mcp3912_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	MCP3911_CHAN(2),
+	MCP3911_CHAN(3),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const struct iio_chan_spec mcp3913_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	MCP3911_CHAN(2),
+	MCP3911_CHAN(3),
+	MCP3911_CHAN(4),
+	MCP3911_CHAN(5),
+	IIO_CHAN_SOFT_TIMESTAMP(6),
+};
+
+static const struct iio_chan_spec mcp3914_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	MCP3911_CHAN(2),
+	MCP3911_CHAN(3),
+	MCP3911_CHAN(4),
+	MCP3911_CHAN(5),
+	MCP3911_CHAN(6),
+	MCP3911_CHAN(7),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+};
+
+static const struct iio_chan_spec mcp3918_channels[] = {
+	MCP3911_CHAN(0),
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct iio_chan_spec mcp3919_channels[] = {
+	MCP3911_CHAN(0),
+	MCP3911_CHAN(1),
+	MCP3911_CHAN(2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct mcp3911_chip_info mcp3911_chip_info[] = {
+	[MCP3910] = {
+		.channels = mcp3910_channels,
+		.num_channels = ARRAY_SIZE(mcp3910_channels),
+	},
+	[MCP3911] = {
+		.channels = mcp3911_channels,
+		.num_channels = ARRAY_SIZE(mcp3911_channels),
+	},
+	[MCP3912] = {
+		.channels = mcp3912_channels,
+		.num_channels = ARRAY_SIZE(mcp3912_channels),
+	},
+	[MCP3913] = {
+		.channels = mcp3913_channels,
+		.num_channels = ARRAY_SIZE(mcp3913_channels),
+	},
+	[MCP3914] = {
+		.channels = mcp3914_channels,
+		.num_channels = ARRAY_SIZE(mcp3914_channels),
+	},
+	[MCP3918] = {
+		.channels = mcp3918_channels,
+		.num_channels = ARRAY_SIZE(mcp3918_channels),
+	},
+	[MCP3919] = {
+		.channels = mcp3919_channels,
+		.num_channels = ARRAY_SIZE(mcp3919_channels),
+	},
+};
+
 static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mcp3911 *adc = iio_priv(indio_dev);
-	struct spi_transfer xfer[] = {
-		{
-			.tx_buf = &adc->tx_buf,
-			.len = 1,
-		}, {
-			.rx_buf = adc->rx_buf,
-			.len = sizeof(adc->rx_buf),
-		},
+	struct spi_transfer xfer = {
+		.tx_buf = adc->tx_buf,
+		.rx_buf = adc->rx_buf,
+		.len = (mcp3911_chip_info[adc->chipid].num_channels - 1) * 3,
 	};
 	int scan_index;
 	int i = 0;
 	int ret;
 
 	mutex_lock(&adc->lock);
-	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
-	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
+	adc->tx_buf[0] = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
+	ret = spi_sync_transfer(adc->spi, &xfer, 1);
 	if (ret < 0) {
 		dev_warn(&adc->spi->dev,
 				"failed to get conversion data\n");
@@ -383,26 +532,9 @@ static const struct iio_info mcp3911_info = {
 
 static int mcp3911_config(struct mcp3911 *adc)
 {
-	struct device *dev = &adc->spi->dev;
 	u32 regval;
 	int ret;
 
-	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
-
-	/*
-	 * Fallback to "device-addr" due to historical mismatch between
-	 * dt-bindings and implementation
-	 */
-	if (ret)
-		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
-	if (adc->dev_addr > 3) {
-		dev_err(&adc->spi->dev,
-			"invalid device address (%i). Must be in range 0-3.\n",
-			adc->dev_addr);
-		return -EINVAL;
-	}
-	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
-
 	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &regval, 2);
 	if (ret)
 		return ret;
@@ -439,7 +571,102 @@ static int mcp3911_config(struct mcp3911 *adc)
 	regval &= ~MCP3911_STATUSCOM_READ;
 	regval |= FIELD_PREP(MCP3911_STATUSCOM_READ, 0x02);
 
-	return  mcp3911_write(adc, MCP3911_REG_STATUSCOM, regval, 2);
+	regval &= ~MCP3911_STATUSCOM_DRHIZ;
+	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+		regval |= FIELD_PREP(MCP3911_STATUSCOM_DRHIZ, 0);
+	else
+		regval |= FIELD_PREP(MCP3911_STATUSCOM_DRHIZ, 1);
+
+	/* Disable offset to ignore any old values in offset register*/
+	regval &= ~MCP3911_STATUSCOM_EN_OFFCAL;
+
+	ret =  mcp3911_write(adc, MCP3911_REG_STATUSCOM, regval, 2);
+	if (ret)
+		return ret;
+
+       /* Set gain to 1 for all channels */
+	ret = mcp3911_read(adc, MCP3911_REG_GAIN, &regval, 1);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < mcp3911_chip_info[adc->chipid].num_channels - 1; i++) {
+		adc->gain[i] = 1;
+		regval &= ~MCP3911_GAIN_MASK(i);
+	}
+	return mcp3911_write(adc, MCP3911_REG_GAIN, regval, 1);
+
+
+}
+
+static int mcp39xx_config(struct mcp3911 *adc)
+{
+	u32 regval;
+	int ret;
+
+	ret = mcp3911_read(adc, MCP39XX_REG_CONFIG1, &regval, 3);
+	if (ret)
+		return ret;
+
+	regval &= ~MCP39XX_CONFIG1_VREFEXT;
+	if (adc->vref) {
+		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
+		regval |= FIELD_PREP(MCP39XX_CONFIG1_VREFEXT, 1);
+	} else {
+		dev_dbg(&adc->spi->dev,
+			"use internal voltage reference (1.2V)\n");
+		regval |= FIELD_PREP(MCP39XX_CONFIG1_VREFEXT, 0);
+	}
+
+	regval &= ~MCP39XX_CONFIG1_CLKEXT;
+	if (adc->clki) {
+		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
+		regval |= FIELD_PREP(MCP39XX_CONFIG1_CLKEXT, 1);
+	} else {
+		dev_dbg(&adc->spi->dev,
+			"use crystal oscillator as clocksource\n");
+		regval |= FIELD_PREP(MCP39XX_CONFIG1_CLKEXT, 0);
+	}
+
+	ret = mcp3911_write(adc, MCP39XX_REG_CONFIG1, regval, 3);
+	if (ret)
+		return ret;
+
+	ret = mcp3911_read(adc, MCP39XX_REG_STATUSCOM, &regval, 3);
+	if (ret)
+		return ret;
+
+	/* Address counter incremented, cycle through register types */
+	regval &= ~MCP39XX_STATUSCOM_READ;
+	regval |= FIELD_PREP(MCP39XX_STATUSCOM_READ, 0x02);
+
+
+	regval &= ~MCP39XX_STATUSCOM_DRHIZ;
+	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+		regval |= FIELD_PREP(MCP39XX_STATUSCOM_DRHIZ, 0);
+	else
+		regval |= FIELD_PREP(MCP39XX_STATUSCOM_DRHIZ, 1);
+
+	ret = mcp3911_write(adc, MCP39XX_REG_STATUSCOM, regval, 3);
+	if (ret)
+		return ret;
+
+       /* Set gain to 1 for all channels */
+	ret = mcp3911_read(adc, MCP39XX_REG_GAIN, &regval, 3);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < mcp3911_chip_info[adc->chipid].num_channels - 1; i++) {
+		adc->gain[i] = 1;
+		regval &= ~MCP3911_GAIN_MASK(i);
+	}
+	ret = mcp3911_write(adc, MCP39XX_REG_GAIN, regval, 3);
+	if (ret)
+		return ret;
+
+	/* Disable offset to ignore any old values in offset register*/
+	return mcp3911_update(adc, MCP39XX_REG_CONFIG0,
+				MCP39XX_CONFIG0_EN_OFFCAL,
+				MCP39XX_CONFIG0_EN_OFFCAL, 3);
 }
 
 static void mcp3911_cleanup_regulator(void *vref)
@@ -476,6 +703,7 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
+	adc->chipid = spi_get_device_id(spi)->driver_data;
 
 	adc->vref = devm_regulator_get_optional(&adc->spi->dev, "vref");
 	if (IS_ERR(adc->vref)) {
@@ -511,16 +739,27 @@ static int mcp3911_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = mcp3911_config(adc);
+	ret = device_property_read_u32(&adc->spi->dev, "microchip,device-addr", &adc->dev_addr);
+
+	/*
+	 * Fallback to "device-addr" due to historical mismatch between
+	 * dt-bindings and implementation
+	 */
 	if (ret)
-		return ret;
+		device_property_read_u32(&adc->spi->dev, "device-addr", &adc->dev_addr);
+	if (adc->dev_addr > 3) {
+		dev_err(&adc->spi->dev,
+			"invalid device address (%i). Must be in range 0-3.\n",
+			adc->dev_addr);
+		return -EINVAL;
+	}
+	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
 
-	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
-		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				0, 2);
+
+	if (adc->chipid == MCP3911)
+		ret = mcp3911_config(adc);
 	else
-		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				MCP3911_STATUSCOM_DRHIZ, 2);
+		ret = mcp39xx_config(adc);
 	if (ret)
 		return ret;
 
@@ -529,7 +768,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		return ret;
 
        /* Set gain to 1 for all channels */
-	for (int i = 0; i < MCP3911_NUM_CHANNELS; i++) {
+	for (int i = 0; i < mcp3911_chip_info[adc->chipid].num_channels - 1; i++) {
 		adc->gain[i] = 1;
 		ret = mcp3911_update(adc, MCP3911_REG_GAIN,
 				MCP3911_GAIN_MASK(i),
@@ -543,8 +782,8 @@ static int mcp3911_probe(struct spi_device *spi)
 	indio_dev->info = &mcp3911_info;
 	spi_set_drvdata(spi, indio_dev);
 
-	indio_dev->channels = mcp3911_channels;
-	indio_dev->num_channels = ARRAY_SIZE(mcp3911_channels);
+	indio_dev->channels = mcp3911_chip_info[adc->chipid].channels;
+	indio_dev->num_channels = mcp3911_chip_info[adc->chipid].num_channels;
 
 	mutex_init(&adc->lock);
 
@@ -583,13 +822,25 @@ static int mcp3911_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id mcp3911_dt_ids[] = {
+	{ .compatible = "microchip,mcp3910" },
 	{ .compatible = "microchip,mcp3911" },
+	{ .compatible = "microchip,mcp3912" },
+	{ .compatible = "microchip,mcp3913" },
+	{ .compatible = "microchip,mcp3914" },
+	{ .compatible = "microchip,mcp3918" },
+	{ .compatible = "microchip,mcp3919" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp3911_dt_ids);
 
 static const struct spi_device_id mcp3911_id[] = {
-	{ "mcp3911", 0 },
+	{ "mcp3910", MCP3910 },
+	{ "mcp3911", MCP3911 },
+	{ "mcp3912", MCP3912 },
+	{ "mcp3913", MCP3913 },
+	{ "mcp3914", MCP3914 },
+	{ "mcp3918", MCP3918 },
+	{ "mcp3919", MCP3919 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp3911_id);
-- 
2.40.1

