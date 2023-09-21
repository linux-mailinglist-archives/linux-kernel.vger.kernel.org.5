Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF627A9FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjIUU1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjIUU1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:27:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20CC444D2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:23:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b962c226ceso20418721fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317031; x=1695921831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BurSNjw3LRUUcMvXtonPsGB5QUx7CZPo8/XQKc8tXvQ=;
        b=efM7C+qLQF0wGTHY+ukd9E5ip7Beu+qwyG2enYzoccZRa0buiOMwUAZ5dp+iSDv7UT
         0f5xtl3v00IcAya+YxqPcMac8yOg8d1s2q/9AjjpOo5A//grV667/bTYJI+7wEfkqaCo
         P6i9VKtPO1TF/c3sAhef+M3Dtwzas1d0zzbMGOm+20GUdcM1AUgi5KQBVPnGcmtjkzuw
         7AJKLyWXNmkSAWIJasXNkU6jW+yC7StLh8JpbRIQFrui4PCqnkEuTkHbmyw+usESgzuf
         QNEg4XdLmbB8gJeyqRJygcixu3Kxrr22hE936o6fQ4qrGLWqNw9g+wfoKwv6kfDldtGG
         vGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317031; x=1695921831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BurSNjw3LRUUcMvXtonPsGB5QUx7CZPo8/XQKc8tXvQ=;
        b=qmKSjWure6mKbO9jTpuw30Bme0QXYAwVHwAUw01B30NgSRSKiIddsaWV50lSXkdqnK
         HVS72rJw8s+w58hP2VuztLsIj8wfY/MNPUB1Pc5/7W9+ng+6NpSLvJnODLIsm0uqGhJH
         PqudEMFBUetXOIZjaJLXNBTYz0YZ0NRYi29OdMIaeTV4a0691Y/iLDIEUotjbEXD6Skn
         i/2DBJOLxtOcSw4vwEXx4wB6JyjR2Ae/yGNF+uNL9pxPWn7X7gZ3XHq5HquBodvVvpLB
         B3XGltlM3Zm6PXG2rDwSWc2rkfZuxDw2kX4yGZQO3jRT59oAOAloHZXYiv/6LYt7qk9f
         yruA==
X-Gm-Message-State: AOJu0YxIBlD3Et5z5PfdYYBS8hRTqIqYHQUlhqfjLKG9QOf+/VWd1d60
        iLf+kRQmuvWQO1wSE8wxZhw+w+ila9uS1l1f+ZSV5R3r
X-Google-Smtp-Source: AGHT+IHNEr10kFqru6shnxnQjCxmHgYq/iqV95+VoS8aS+sGpqc8B3o89A4hIe6FM7kiYkFbjggLAA==
X-Received: by 2002:adf:f88f:0:b0:31d:3669:1c55 with SMTP id u15-20020adff88f000000b0031d36691c55mr5308299wrp.65.1695306153705;
        Thu, 21 Sep 2023 07:22:33 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:33 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [PATCH 2/2] staging: iio: resolver: ad2s1210: add triggered buffer support
Date:   Thu, 21 Sep 2023 09:19:30 -0500
Message-Id: <20230921141947.57784-5-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for triggered buffers to the AD2S1210 resolver driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 84 ++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index f5b8b290e860..44a2ecaeeeff 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -19,8 +19,11 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define DRV_NAME "ad2s1210"
 
@@ -85,6 +88,12 @@ struct ad2s1210_state {
 	unsigned long fclkin;
 	/** The selected resolution */
 	enum ad2s1210_resolution resolution;
+	/** Scan buffer */
+	struct {
+		__be16 chan[2];
+		/* Ensure timestamp is naturally aligned. */
+		s64 timestamp __aligned(8);
+	} scan;
 	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
 	u8 tx[2];
 };
@@ -592,18 +601,35 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
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
 		.info_mask_separate_available =
 					BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.datasheet_name = "position",
 	}, {
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
-	}
+		.datasheet_name = "velocity",
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static struct attribute *ad2s1210_attributes[] = {
@@ -665,6 +691,55 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
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
 	.read_raw = ad2s1210_read_raw,
 	.read_avail = ad2s1210_read_avail,
@@ -850,6 +925,13 @@ static int ad2s1210_probe(struct spi_device *spi)
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
2.34.1

