Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE6377B84D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjHNMIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjHNMI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:08:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C02E4A;
        Mon, 14 Aug 2023 05:08:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so10977123a12.0;
        Mon, 14 Aug 2023 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692014899; x=1692619699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic0vlaawxL07MxL/FeSlZ1QW0HORdheFR5zZmTFnAUo=;
        b=AplH6W7nj3kZQ7oRvfKlhPqzSrudmVG3/EQC7ml8GnhEBlUU7bqj10Sr+HmUKgX+xe
         8tnXkeow23qxZdVMi4Zujm3PsaCkq+ECu9DmU2ImZ8dJ3vykKW9KnfhX6YO0BOBAtIyi
         njsY+UcawVEiFQp3Y2nwqF7bVIgkTc8oqX6dM6YYHwLoO5mLeIg3mml9wgF/NmQfTNv1
         0xEDikxpo2VfWL6EO2qfM6qQR0VNFds/Ye+ugQDSpg0hFf0v+nAGSj/cu7b8BfY7G99X
         uml7MdGridn9yz0Qh6V/NUtOlkdpMgnOSlGkb80GCwP7XIwhBFccHnvfDYQ3WQrCKG22
         lOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014899; x=1692619699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic0vlaawxL07MxL/FeSlZ1QW0HORdheFR5zZmTFnAUo=;
        b=HsUtP53cj9jWFTPdpk9urbww7Sw8WIjzEaE0IvXYfwZqKT0qtVlo+K52TbTPX+SFAz
         fsS5RgL0m1AXX0+7ylJhDRk0iTlMozq0E97oV0OU0+/zWe8p+0RLKfg1skYf7wh0EXaB
         QGrjiBPxppQ5I9jY3SXnhaC5kKDAyaCKaIFbTd+UmEDOCaNfA3BR9l0yltYbrBg10Zdy
         0FG47foDcsINisHIF1mhMBnhegndWfXMnPg2FkFJgnein1Paa2GjWd6VwTxY2HQCnjzy
         7GSzRQom8sxJJcvM/jPA/+OGiOnnRQWORFIHGcSl9/J3CXZGrkRIu3YkxrBECMlW3EJy
         u+rA==
X-Gm-Message-State: AOJu0YxpTv/N1rLbZDqmO+2bHS3POtD8NCbTTKrbC8zLW1gAlm06JzRO
        c+exWud7Wp7H33RIQZ/fM/w=
X-Google-Smtp-Source: AGHT+IHTYBNWA7GXWJdgovgaiVt/ldxOKHv7qOyZzGyI2BjFGAuVPAALsFKXlcS1AC9SFB/8mTMoEg==
X-Received: by 2002:a17:906:cc0d:b0:989:450:e565 with SMTP id ml13-20020a170906cc0d00b009890450e565mr10306173ejb.23.1692014899572;
        Mon, 14 Aug 2023 05:08:19 -0700 (PDT)
Received: from goliat.isc.local (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709063b8500b009930042510csm5600433ejf.222.2023.08.14.05.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:08:18 -0700 (PDT)
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
Subject: [PATCH v5 4/6] iio: adc: mcp3911: fix indentation
Date:   Mon, 14 Aug 2023 14:10:08 +0200
Message-ID: <20230814121010.184842-4-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814121010.184842-1-marcus.folkesson@gmail.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
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

The file does not make use of indentation properly.
Fix that.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
        - New patch in this series
    v5:
        - Cosmetics

 drivers/iio/adc/mcp3911.c | 41 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 12fa635ed199..1648eaa878eb 100644
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
@@ -111,8 +111,7 @@ static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
 	return spi_write(adc->spi, &val, len + 1);
 }
 
-static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
-		u32 val, u8 len)
+static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask, u32 val, u8 len)
 {
 	u32 tmp;
 	int ret;
@@ -127,8 +126,8 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 }
 
 static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
-					struct iio_chan_spec const *chan,
-					long mask)
+				     struct iio_chan_spec const *chan,
+				     long mask)
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -141,9 +140,9 @@ static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
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
@@ -212,8 +211,8 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 }
 
 static int mcp3911_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *channel, int val,
-			    int val2, long mask)
+			     struct iio_chan_spec const *channel, int val,
+			     int val2, long mask)
 {
 	struct mcp3911 *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
@@ -223,12 +222,12 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
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
@@ -246,8 +245,8 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
 		/* Enable offset*/
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM,
-				MCP3911_STATUSCOM_EN_OFFCAL,
-				MCP3911_STATUSCOM_EN_OFFCAL, 2);
+				     MCP3911_STATUSCOM_EN_OFFCAL,
+				     MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -255,7 +254,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 			if (val == mcp3911_osr_table[i]) {
 				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
 				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
-						val, 2);
+						     val, 2);
 				break;
 			}
 		}
@@ -506,10 +505,10 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	if (device_property_read_bool(dev, "microchip,data-ready-hiz"))
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				0, 2);
+				     0, 2);
 	else
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				MCP3911_STATUSCOM_DRHIZ, 2);
+				     MCP3911_STATUSCOM_DRHIZ, 2);
 	if (ret)
 		return ret;
 
@@ -517,12 +516,12 @@ static int mcp3911_probe(struct spi_device *spi)
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
-- 
2.41.0

