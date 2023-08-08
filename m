Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483A2774744
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjHHTN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjHHTNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:13:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A325351D3;
        Tue,  8 Aug 2023 09:35:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bc512526cso855135766b.1;
        Tue, 08 Aug 2023 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512502; x=1692117302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkJoIl6bqN5V/arz35UqS7vxqymZsvhTQ0NmSaBWTpc=;
        b=aWTCoVkGvg4zYFRtsVweX3Y1ZWkJ6IdzZGpjekBCTjqBYnGSn/T4rteLMQwje2pSpg
         FMYUu645hm7Ud2fgruVlMuhPxHMrIHHhC7jt39y6evuTau2WHegCxIPhN0dcapaj/ruT
         jSegFBzbnBjnbWdWU+W5BQB+FITxUDC2jCgxbVvyygOVOnrg8IWsGnFz7/INgxnkY+NK
         8i6Qmckdneg2sdqCAzIsoZaoSAIEu5s9oPHIuEfSHNnDAQQhqXjbc8C8SZsNaHoOByC2
         NuobX5ztpxbNBLu+F5zwefRN0/m2EY2hIKBqmmGovM8VwTvx0qmocL9o18QSBUYo7bm7
         KUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512502; x=1692117302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkJoIl6bqN5V/arz35UqS7vxqymZsvhTQ0NmSaBWTpc=;
        b=DnmleRf8VD7RP42jG6mlWexo+C9PpGyROXWPPy18UcUMSfuqKFIhX1coo5NuJaT/Ao
         U0AWO6fyd/5lziBf5oCUBq4Z+M/kvgrq2zdy95ImWwdem3Hiray7gxLte/uHBI5oi9E/
         SAKjwf9AMeb1HCVLxP1/ohIzksdTXrSwX46Gopp3pZUS9jUCKPd69RD836CuWkf/Q8ej
         Xyl/dQIwoRRobCbQ4Fv0g5Oa276eFCH0VEM4HlBk5E4mTyRB1OWcN4R8pfKUDAZ4+e0Q
         dN+SJxBVldgxk1R+ovIuqviddIXjpS82pOQ7GJqfvnC7ZDUCgNmR8ZvQhtPc+Rn3AC0a
         w2bA==
X-Gm-Message-State: AOJu0YxAS2ID7K7WQbwUmw0q/TytvsnOfE2p/461mVQy+Ydv8j4OiOHy
        BspOwA7woG65ckmW45UythVNretWgUBwtHF4
X-Google-Smtp-Source: AGHT+IHGGicBO6hh1cowRODMmbY3oe1devolNZrQRK4+F3jdN7CbErysf5M2mBuoBuAU0jdi9iQl5g==
X-Received: by 2002:a05:6512:31d6:b0:4f8:7772:3dfd with SMTP id j22-20020a05651231d600b004f877723dfdmr8655721lfe.11.1691492572360;
        Tue, 08 Aug 2023 04:02:52 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id q10-20020ac246ea000000b004fbad682ffesm1826587lfo.88.2023.08.08.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:02:51 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] iio: adc: mcp3911: fix indentation
Date:   Tue,  8 Aug 2023 13:04:31 +0200
Message-Id: <20230808110432.240773-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808110432.240773-1-marcus.folkesson@gmail.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file does not make use of indentation properly.
Fix that.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
        - New patch in this series

 drivers/iio/adc/mcp3911.c | 97 ++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 8bbf2f7c839e..8b465d2aad1a 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -33,7 +33,7 @@
 #define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * ch) & MCP3911_GAIN_MASK(ch))
 
 #define MCP3911_REG_STATUSCOM		0x0a
-#define MCP3911_STATUSCOM_DRHIZ         BIT(12)
+#define MCP3911_STATUSCOM_DRHIZ		BIT(12)
 #define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
@@ -112,7 +112,7 @@ static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
 }
 
 static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
-		u32 val, u8 len)
+			  u32 val, u8 len)
 {
 	u32 tmp;
 	int ret;
@@ -127,8 +127,8 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 }
 
 static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
-					struct iio_chan_spec const *chan,
-					long mask)
+				     struct iio_chan_spec const *chan,
+				     long mask)
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -141,9 +141,9 @@ static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
 }
 
 static int mcp3911_read_avail(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     const int **vals, int *type, int *length,
-			     long info)
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
 {
 	switch (info) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -212,8 +212,8 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 }
 
 static int mcp3911_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *channel, int val,
-			    int val2, long mask)
+			     struct iio_chan_spec const *channel, int val,
+			     int val2, long mask)
 {
 	struct mcp3911 *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
@@ -223,12 +223,12 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
 			if (val == mcp3911_scale_table[i][0] &&
-				val2 == mcp3911_scale_table[i][1]) {
+			    val2 == mcp3911_scale_table[i][1]) {
 
 				adc->gain[channel->channel] = BIT(i);
 				ret = mcp3911_update(adc, MCP3911_REG_GAIN,
-						MCP3911_GAIN_MASK(channel->channel),
-						MCP3911_GAIN_VAL(channel->channel, i), 1);
+						     MCP3911_GAIN_MASK(channel->channel),
+						     MCP3911_GAIN_VAL(channel->channel, i), 1);
 			}
 		}
 		break;
@@ -246,8 +246,8 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
 		/* Enable offset*/
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM,
-				MCP3911_STATUSCOM_EN_OFFCAL,
-				MCP3911_STATUSCOM_EN_OFFCAL, 2);
+				     MCP3911_STATUSCOM_EN_OFFCAL,
+				     MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -255,7 +255,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 			if (val == mcp3911_osr_table[i]) {
 				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
 				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
-						val, 2);
+						     val, 2);
 				break;
 			}
 		}
@@ -279,7 +279,7 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 		if (ret < 0) {
 			dev_err(&adc->spi->dev,
 				"failed to get vref voltage: %d\n",
-			       ret);
+				ret);
 			return ret;
 		}
 
@@ -305,25 +305,25 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 	return 0;
 }
 
-#define MCP3911_CHAN(idx) {					\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = idx,					\
-		.scan_index = idx,				\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
-			BIT(IIO_CHAN_INFO_OFFSET) |		\
-			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_shared_by_type_available =           \
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
-		.info_mask_separate_available =			\
-			BIT(IIO_CHAN_INFO_SCALE),		\
-		.scan_type = {					\
-			.sign = 's',				\
-			.realbits = 24,				\
-			.storagebits = 32,			\
-			.endianness = IIO_BE,			\
-		},						\
+#define MCP3911_CHAN(idx) {				\
+	.type = IIO_VOLTAGE,				\
+	.indexed = 1,					\
+	.channel = idx,					\
+	.scan_index = idx,				\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+	BIT(IIO_CHAN_INFO_OFFSET) |			\
+	BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_type_available =           \
+	BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.info_mask_separate_available =			\
+	BIT(IIO_CHAN_INFO_SCALE),			\
+	.scan_type = {					\
+		.sign = 's',				\
+		.realbits = 24,				\
+		.storagebits = 32,			\
+		.endianness = IIO_BE,			\
+	},						\
 }
 
 static const struct iio_chan_spec mcp3911_channels[] = {
@@ -355,7 +355,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
 	if (ret < 0) {
 		dev_warn(&adc->spi->dev,
-				"failed to get conversion data\n");
+			 "failed to get conversion data\n");
 		goto out;
 	}
 
@@ -494,7 +494,7 @@ static int mcp3911_probe(struct spi_device *spi)
 			return ret;
 
 		ret = devm_add_action_or_reset(&spi->dev,
-				mcp3911_cleanup_regulator, adc->vref);
+					       mcp3911_cleanup_regulator, adc->vref);
 		if (ret)
 			return ret;
 	}
@@ -517,10 +517,10 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	if (device_property_read_bool(&spi->dev, "microchip,data-ready-hiz"))
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				0, 2);
+				     0, 2);
 	else
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				MCP3911_STATUSCOM_DRHIZ, 2);
+				     MCP3911_STATUSCOM_DRHIZ, 2);
 	if (ret)
 		return ret;
 
@@ -528,12 +528,12 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-       /* Set gain to 1 for all channels */
+	/* Set gain to 1 for all channels */
 	for (int i = 0; i < MCP3911_NUM_CHANNELS; i++) {
 		adc->gain[i] = 1;
 		ret = mcp3911_update(adc, MCP3911_REG_GAIN,
-				MCP3911_GAIN_MASK(i),
-				MCP3911_GAIN_VAL(i, 0), 1);
+				     MCP3911_GAIN_MASK(i),
+				     MCP3911_GAIN_VAL(i, 0), 1);
 		if (ret)
 			return ret;
 	}
@@ -550,8 +550,8 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	if (spi->irq > 0) {
 		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
-				indio_dev->name,
-				iio_device_id(indio_dev));
+						   indio_dev->name,
+						   iio_device_id(indio_dev));
 		if (!adc->trig)
 			return -ENOMEM;
 
@@ -567,15 +567,16 @@ static int mcp3911_probe(struct spi_device *spi)
 		 * don't enable the interrupt to avoid extra load on the system.
 		 */
 		ret = devm_request_irq(&spi->dev, spi->irq,
-				&iio_trigger_generic_data_rdy_poll, IRQF_NO_AUTOEN | IRQF_ONESHOT,
-				indio_dev->name, adc->trig);
+				       &iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_AUTOEN | IRQF_ONESHOT,
+				       indio_dev->name, adc->trig);
 		if (ret)
 			return ret;
 	}
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-			NULL,
-			mcp3911_trigger_handler, NULL);
+					      NULL,
+					      mcp3911_trigger_handler, NULL);
 	if (ret)
 		return ret;
 
-- 
2.40.1

