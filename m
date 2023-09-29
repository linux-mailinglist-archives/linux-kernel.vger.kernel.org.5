Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11BB7B38D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjI2R0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjI2R0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:26:18 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13F1704
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:05 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c63588b554so969942a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008365; x=1696613165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+I4VRfCfFP72yApzhIwo9Fg0drG4LlaaDXwdDXV7tg=;
        b=T087fHIxBpaE5+JlAXJ/WoSyhVhZRaTYD2L7JiAsZsRx4ZfJOQaybsCXS+Nj+4kJZ+
         oQuDnLusWpVLgWzkvoREjFeKfNcaMncwTemJva6+AGJwQ6lg6CIog/0OGJOABoi23m9s
         IuSHBmRKEXLzN+Jf6myRq1/r2QTQzX6i2W33SImGmLblvLvDWfSDynFBVX2v1sGy6K9z
         w/jWphXvfj75MXgcm/JQ912W7NspF4FQmQkvnW7CLssFj76eHV3oiHNXeQSvp2w/CzmD
         j06wHPTYCwk5WareSQxQOuCFLp5A0ek3vddVR7M5+15BdrMsucB/xe1L9OCQUlZ9oXi3
         EMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008365; x=1696613165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+I4VRfCfFP72yApzhIwo9Fg0drG4LlaaDXwdDXV7tg=;
        b=loufpAEkRg0qrjBBZE0INY5JoIUrxuSL9HeoDh9tvQNunvGDLLYXlPlr9gGL5Lifm8
         xW37Ig8U7sI/5h33x7RihSpGk2VCJWFlqBfFJEm5+qY2iKIxZhS/VcxQS99amlMkz+sX
         m2rR9md+FDF5/00g06ISqqfRPmO34DJ1HotNVYb+AgRHWU62FWWoZfmf2EQ+pMTKf16L
         cPrGAuHe6tDWy6sYWqzdJTBQ4SzE+xUo1KxjYxffAL6lwpY2aIuc299gaMya1wZZr12V
         /3L2kMLDk6X9PNbBDojjycifQq2j+UMIQBsnTO2KmCyFZ+ok0mj9IjC8AhLfych23j7O
         FRBg==
X-Gm-Message-State: AOJu0YwCXIQoDtS2BpQuiGQ5WkSUX4dXvAxVXE++tEiLi3K4mWdTkeq5
        l7OvsYeaPzUMZyzuvNeCStSw9g==
X-Google-Smtp-Source: AGHT+IEDk3K0gISCTUXG8sbkK43ecAqVNck02OE2zcrr8O7+YohLLZ0CWNYmMufLd09XXF4qj6WujA==
X-Received: by 2002:a05:6830:16d8:b0:6c4:e6d8:2cdc with SMTP id l24-20020a05683016d800b006c4e6d82cdcmr5028313otr.23.1696008364886;
        Fri, 29 Sep 2023 10:26:04 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:26:04 -0700 (PDT)
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
Subject: [PATCH v3 20/27] staging: iio: resolver: ad2s1210: add triggered buffer support
Date:   Fri, 29 Sep 2023 12:23:25 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-20-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

This adds support for triggered buffers to the AD2S1210 resolver driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Dropped setting datasheet_name of channels.

 drivers/staging/iio/resolver/ad2s1210.c | 83 ++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index bafc134eed97..c0bc9eac18e8 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -20,8 +20,11 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define DRV_NAME "ad2s1210"
 
@@ -92,6 +95,12 @@ struct ad2s1210_state {
 	enum ad2s1210_resolution resolution;
 	/** For reading raw sample value via SPI. */
 	__be16 sample __aligned(IIO_DMA_MINALIGN);
+	/** Scan buffer */
+	struct {
+		__be16 chan[2];
+		/* Ensure timestamp is naturally aligned. */
+		s64 timestamp __aligned(8);
+	} scan;
 	/** SPI transmit buffer. */
 	u8 rx[2];
 	/** SPI receive buffer. */
@@ -617,6 +626,13 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.type = IIO_ANGL,
 		.indexed = 1,
 		.channel = 0,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_HYSTERESIS),
@@ -626,9 +642,18 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
 		.channel = 0,
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
-	}, {
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+	{
 		/* used to configure phase lock range and get phase lock error */
 		.type = IIO_PHASE,
 		.indexed = 1,
@@ -756,6 +781,55 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	size_t chan = 0;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	memset(&st->scan, 0, sizeof(st->scan));
+	gpiod_set_value(st->sample_gpio, 1);
+
+	if (test_bit(0, indio_dev->active_scan_mask)) {
+		ret = ad2s1210_set_mode(st, MOD_POS);
+		if (ret < 0)
+			goto error_ret;
+
+		/* REVIST: we can read 3 bytes here and also get fault flags */
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0)
+			goto error_ret;
+
+		memcpy(&st->scan.chan[chan++], st->rx, 2);
+	}
+
+	if (test_bit(1, indio_dev->active_scan_mask)) {
+		ret = ad2s1210_set_mode(st, MOD_VEL);
+		if (ret < 0)
+			goto error_ret;
+
+		/* REVIST: we can read 3 bytes here and also get fault flags */
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0)
+			goto error_ret;
+
+		memcpy(&st->scan.chan[chan++], st->rx, 2);
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
+
+error_ret:
+	gpiod_set_value(st->sample_gpio, 0);
+	mutex_unlock(&st->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info ad2s1210_info = {
 	.event_attrs = &ad2s1210_event_attribute_group,
 	.read_raw = ad2s1210_read_raw,
@@ -944,6 +1018,13 @@ static int ad2s1210_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad2s1210_trigger_handler, NULL);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "iio triggered buffer setup failed\n");
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 

-- 
2.42.0

