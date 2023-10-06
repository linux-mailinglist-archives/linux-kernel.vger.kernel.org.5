Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1657BAFC5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjJFAv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjJFAvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:13 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A01F4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:10 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1a1fa977667so1011423fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553470; x=1697158270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXPwGX9zI0UWI2DJ0yjP1Yyjk72nF2lCh2sU4lorTt8=;
        b=mo5FvSD2iLwm2foFsEVn8sM6LljNSL9Rc0reDj0VJEeV93w5qoOmiiqmt4tL3lT6yv
         ZByVXMFTFvXiX4yWh+YEsKRBlgzIeICTJEGN7pJwPmG1ZQwt+jVrDGMDn1rN8sY9u7zi
         pmu4F3FMkfTpdOYbzb2F+fNTQujGx1uJZ+sPUbG+hSf+mieK7YNmU4ofuiSFG6/2zoDB
         hHyztkzLbYrUX0cap+6bYAqFuoDFLiyb2Tojfs8SAZIzojRKLpoMqbsBu3rIj52mf2XO
         vXchG+X4JWB8l00jRxI6bKTCHUob1UFvJg4djNF7P4UjsvA29TfATVxPX9VNCtyPzfPl
         PMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553470; x=1697158270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXPwGX9zI0UWI2DJ0yjP1Yyjk72nF2lCh2sU4lorTt8=;
        b=Y7S28N8bCe5S9WLJBq2X7ALTjcKKLCRKAzvAbA3v51C8Umys9DOq+SPKwLi+GZlA4X
         YU43Wzl0uSJ0+6gjpjKGZXouZs1DiTXfcK5zK6zsOcHGdeGbG//B6c6fnBUCTwfwPJTy
         XthUlrLwy/WIarU+Hn5UP0r6NqI4ucA4bv/iEQHUtX+eivQXoA8Z9HavkK+L2R3/Bwmi
         DSJA0eS0ytVjtJinZ9j6YHQVk/NTErdXKym89m4OMdBgEExY49Cws4CPoPcOQ9l0QqZw
         Ev0xmkS53RpUgkN5IwfXDScW+AREIZrMSu+v2n3WQNBRhSWMJMh7hnySvdra5fhbUyLV
         VXcA==
X-Gm-Message-State: AOJu0YwANarfIwzkYN8i0NG+6CtLm/qqa2ok2K1K+dUsqcDdvDsjFSI9
        EEg5ofpMSPYIrDgwccOcyBfIdA==
X-Google-Smtp-Source: AGHT+IHAnVUP46ALOkARK2Ojzj4VFtRt5SK4wSY28v7FVdU8HRSn/OJxQaYVXPj3FTUz9NSp7xWnPw==
X-Received: by 2002:a05:6870:5492:b0:1d7:503:1502 with SMTP id f18-20020a056870549200b001d705031502mr7577660oan.59.1696553469775;
        Thu, 05 Oct 2023 17:51:09 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:09 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/17] staging: iio: resolver: ad2s1210: add triggered buffer support
Date:   Thu,  5 Oct 2023 19:50:23 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-6-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
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

v4 changes: None

v3 changes:
* Dropped setting datasheet_name of channels.

 drivers/staging/iio/resolver/ad2s1210.c | 83 ++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 83f6ac890dbc..4d651a2d0f38 100644
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
 
@@ -94,6 +97,12 @@ struct ad2s1210_state {
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
@@ -621,6 +630,13 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
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
@@ -630,9 +646,18 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
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
@@ -760,6 +785,55 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
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
@@ -957,6 +1031,13 @@ static int ad2s1210_probe(struct spi_device *spi)
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

