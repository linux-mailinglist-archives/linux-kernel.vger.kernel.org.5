Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F077F5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350644AbjHQMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350621AbjHQMDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:03:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDCB26A8;
        Thu, 17 Aug 2023 05:03:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so11999837e87.2;
        Thu, 17 Aug 2023 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692273782; x=1692878582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb7oZIgg/B3E+dBegFgOfB9mM2QYvQbTAUSvlXHH+Sc=;
        b=LuDh+fSVz9XUIj4A+4gUB/0BhP/OgCcthKsuPXon36R93RAV+YfliYwhUw8oqW/7a8
         82ThO6+g9rzRL34VwOQLLLKcFm08VO7eSWAbyi3pgYaHG97p9GsSTR+En93P8KLceH4q
         VJYUJnxXU24Vyt4vN+C4C8ONpihKT+UCxa5taCf9rjzhcgrfEPrAPOF1FfU72iTuCJ0t
         nIlQkvF1pWsLQruk+rct1l15TPUe6+c2Q+1gyoIk5iTwp59ulAawCwKiF8jFfr2AQN2v
         clgL5PJHdb/Rbv4/FFSREMdJ8YzWPQkX0pGqD4HRSKNOLWmKswgdLQtxtsTX7hqPL5kj
         Kgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273782; x=1692878582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yb7oZIgg/B3E+dBegFgOfB9mM2QYvQbTAUSvlXHH+Sc=;
        b=ZdWNvANbBwc+zQfBLNNMFbXEeUILsF0r6nMPKF5RigpUjYAoXxNXmAK45KMLl2Xt8n
         AvFRaJavhPYxWN2bZq1sio7lS3FdmmN+Km68z9IKpDoaU8lW6oxub7gTFsuPjBwU2Yep
         ky4oNAEQuL7hvhA0I6Hr5n1p65JbDAfDAFgU/7zP0vXxc8NfZrHMuoDLewIZZj6lnGuU
         TwSyB/DOq1u0FvlOwLnnvdHQ8Q5BihtOoTjXYXDl6n8FoYidnbZG0hXDfiftFJbEFqUw
         bvqrzXyBp1HjDIkqfGvq1Kgzb5lniv2Qm92i9qa4n9ug4juaCwfxPv5LhH+N5RqEPCtH
         9pNg==
X-Gm-Message-State: AOJu0Yy7k0exDc4UD7qON2Q8J8nNX2hhuRhxUGCiTDowUZoP7NkppZf4
        U4aQjpgBLgh5xr3LX/4kg4s=
X-Google-Smtp-Source: AGHT+IEy7l/mUxc1HoHZnPcnAVsEONNeHw5AJ9CUE5YL7YrtnLNbv+kj1wdhAVRXnugnwVvA4nBlFA==
X-Received: by 2002:a2e:b285:0:b0:2b4:5cad:f246 with SMTP id 5-20020a2eb285000000b002b45cadf246mr3699537ljx.7.1692273781886;
        Thu, 17 Aug 2023 05:03:01 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002b9fec8961bsm3981213lji.123.2023.08.17.05.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:03:01 -0700 (PDT)
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
Subject: [PATCH v6 4/6] iio: adc: mcp3911: fix indentation
Date:   Thu, 17 Aug 2023 14:05:16 +0200
Message-ID: <20230817120518.153728-4-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817120518.153728-1-marcus.folkesson@gmail.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
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

The whole file does not make use of indentation properly.
Do something about it.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
        - New patch in this series
    v5:
        - Cosmetics
    v6:
        - Little rewording in commit message

 drivers/iio/adc/mcp3911.c | 41 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 2778abde239b..06c8c5ac7781 100644
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

