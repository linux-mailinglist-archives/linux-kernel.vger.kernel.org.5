Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480227B38D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjI2R0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjI2R0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:26:15 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849B2CEC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:00 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57b9cb05fa3so468735eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008359; x=1696613159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Poh3NcltZJCv8ErOckDuYAOGqnEo7FR3Od1QJodXfh4=;
        b=XZL5fqUy6jsM/2hgri2lGkEOLdPeJEqnQiF0vzkDquju09dgNyORdIWS3W4O6swQJz
         JyrZflus2mCu/KkFvGSAB7KTIQW715aAR+NATDYFE/61sJHJ+1xtbYy4dnKBzQzaGE1X
         V1za1w4upFvJXrBuBkenIigzXfWqPy/0sDtWcBfJSyQUcozQqHS2ay/hSy5r8denyc2S
         FUgHlNGjLOSOc3/To/I08mm4lSB4BJ8jc+kyrb8DTf1xb6uMSWfcCEN99HH08ljZyfay
         NSzmQTXVkQG00WGPvHaYtpXhAGAGReDUPbE5k2Jt1vwNTwWXqlO18DZpuzzRCwToBXzv
         qDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008359; x=1696613159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Poh3NcltZJCv8ErOckDuYAOGqnEo7FR3Od1QJodXfh4=;
        b=wxr+GmeFlKIkJq+ocerJndxcMFjzI5zFY30EpahejO5JA8SkDdvDhvBpzSEPP6SRsZ
         k0RZ605wKfQyib2BDBIBE+7jRd/1z9RQDcCXX9C1bWOWnC1YCpCYs8qqwblRjNXX2Szu
         1Gbps8hkwwNnUUhqe5ivDKJJh5L1Y4O72FljsQsg5SHTInRdONsQZqDk6wRHrTb5dUa0
         DiGSd3O+0SruaEk4ujXnqY8KjP8jlBXFOo0NpPv2/TQfILapVxvZceZiyBN2Ddctg0mI
         1Ly39xmf8v6KZ/L/tYzqz/OBIgqskQI3MemY5TphmmUB0mhbVjGxt7L1PMKTxTMjitMW
         GFtg==
X-Gm-Message-State: AOJu0YyxpEIqmN1L+fOxMKLhY8ihw3lgvwKJA9+a2eBCbX1qbyZ0Hoqj
        UUoBxpQSKgVTlWuhgZSEemuAMg==
X-Google-Smtp-Source: AGHT+IFcKaBoCPHTdIYrdiIJME1W/aXyuWm+uUQA3E3oI36LT3glA4oafOIzM/Cwr+iVAGhbAWzh9A==
X-Received: by 2002:a4a:a347:0:b0:576:bbf6:8a8e with SMTP id u7-20020a4aa347000000b00576bbf68a8emr3601045ool.2.1696008359600;
        Fri, 29 Sep 2023 10:25:59 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:59 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 14/27] staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
Date:   Fri, 29 Sep 2023 12:23:19 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-14-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

The AD2S1210 resolver has a hysteresis feature that can be used to
prevent flicker in the LSB of the position register. This can be either
enabled or disabled. Disabling hysteresis is useful for increasing
precision by oversampling.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Refactored into more functions to reduce complexity of switch statements.
* Use early return instead of break in switch statements.

 drivers/staging/iio/resolver/ad2s1210.c | 86 +++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0ec3598b600a..a82cb124a12f 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -78,7 +78,6 @@ struct ad2s1210_state {
 	/** The external oscillator frequency in Hz. */
 	unsigned long clkin_hz;
 	unsigned int fexcit;
-	bool hysteresis;
 	u8 resolution;
 	/** For reading raw sample value via SPI. */
 	__be16 sample __aligned(IIO_DMA_MINALIGN);
@@ -430,6 +429,35 @@ static int ad2s1210_single_conversion(struct ad2s1210_state *st,
 	return ret;
 }
 
+static int ad2s1210_get_hysteresis(struct ad2s1210_state *st, int *val)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
+			       AD2S1210_ENABLE_HYSTERESIS);
+	mutex_unlock(&st->lock);
+
+	if (ret < 0)
+		return ret;
+
+	*val = !!ret;
+	return IIO_VAL_INT;
+}
+
+static int ad2s1210_set_hysteresis(struct ad2s1210_state *st, int val)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				 AD2S1210_ENABLE_HYSTERESIS,
+				 val ? AD2S1210_ENABLE_HYSTERESIS : 0);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static const int ad2s1210_velocity_scale[] = {
 	17089132, /* 8.192MHz / (2*pi * 2500 / 2^15) */
 	42722830, /* 8.192MHz / (2*pi * 1000 / 2^15) */
@@ -462,7 +490,55 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			return ad2s1210_get_hysteresis(st, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad2s1210_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type,
+			       int *length, long mask)
+{
+	static const int hysteresis_available[] = { 0, 1 };
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			*vals = hysteresis_available;
+			*type = IIO_VAL_INT;
+			*length = ARRAY_SIZE(hysteresis_available);
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
 
+static int ad2s1210_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			return ad2s1210_set_hysteresis(st, val);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -503,7 +579,10 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE),
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.info_mask_separate_available =
+					BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
@@ -581,6 +660,8 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
+	.read_avail = ad2s1210_read_avail,
+	.write_raw = ad2s1210_write_raw,
 	.attrs = &ad2s1210_attribute_group,
 	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
@@ -696,7 +777,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
-	st->hysteresis = true;
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 

-- 
2.42.0

