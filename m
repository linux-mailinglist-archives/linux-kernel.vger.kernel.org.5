Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14F67BAFBD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjJFAvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJFAvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:09 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093DD6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:07 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1e5602c12e5so800810fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553466; x=1697158266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qps0yZuxIdvWJ2ZIT7jrzjOXstZNZBL41ajnUJMVQA=;
        b=qXy/VMjzHFE3uy+FEY/ywi6B/DmZsPdzKB77BQxYwsD7O5lX5A6rKwujWuZYTr3r6w
         S8tYAhzYClVxTUL4a8tJjb79qbeA1uOum+DlEt0R4nWy1I8IafcnKCTxOseeg1so2+W/
         s4VMjghp0AcCqTEDbpBTNPGcKRR0RoMYUy6RrPnUP8XADMr2tFx7ZklLCXdnwFkMqKwZ
         ArNvRTbgnU8TN22y6u/1dW+cRLNIkWETgStr1Ymb5GWiTkPpVC3UCLy4qdAiIA/nj0ef
         3B9Wjur9kASTaQ9wszeJrmyMCdMehGayJhCEvmsedPac3ulSbtRPT/wOuN8CYkonpVga
         jxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553466; x=1697158266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qps0yZuxIdvWJ2ZIT7jrzjOXstZNZBL41ajnUJMVQA=;
        b=XdS2TnMshjBIn+Z5z5ALDNAoYkHDymbXaj2ALxVWMH5BeylF5YKC7BMgiEvPHnoRzF
         N3iEEFAOIAm/7jLBXsjd1AiwJn4vdr3LNY+hbg3ToBKa5BhopPgeEhWIlSK2dxpiCcn3
         jRTUA7gIsuTr3Ac3CEPA/jcJ8cuwsbEVB+M5QbX4QDtdIgY32nXpi2nyzD2urxJLJKU6
         5DxNoBTn3jtaPKmDZYDyXFIlR+kssOiMVF7RByLM6mHPqBYzAGsLkKJwsaPmEWcaVQCe
         +QOTpi9es7iT4+XCeUXtDDze9tKxpoo4px/tX27kDGW0FQTZNbj6Ci5RufjcVDLAAq1U
         Xqyg==
X-Gm-Message-State: AOJu0Yz6I3DXR2uGrw/akR72IR9bYerYd4k0qSk5B6Alw2rXA8gOQeBe
        29ZezGmNO3Vk71Rx19ugzyu1Dg==
X-Google-Smtp-Source: AGHT+IG4I5ztMPys5r+CrTX2pZbWsep+z3Uons59yy9bAFOoVvI35cwLsgW+nO6BlaxHEsiQYhI2uQ==
X-Received: by 2002:a05:6871:592:b0:1d5:5659:4730 with SMTP id u18-20020a056871059200b001d556594730mr8210621oan.37.1696553466751;
        Thu, 05 Oct 2023 17:51:06 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:06 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/17] staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
Date:   Thu,  5 Oct 2023 19:50:19 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-2-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD2S1210 resolver has a hysteresis feature that can be used to
prevent flicker in the LSB of the position register. This can be either
enabled or disabled. Disabling hysteresis is useful for increasing
precision by oversampling.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Fixed hysteresis raw values when st->resolution != 16.

v3 changes:
* Refactored into more functions to reduce complexity of switch statements.
* Use early return instead of break in switch statements.


 drivers/staging/iio/resolver/ad2s1210.c | 91 +++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 8fbde9517fe9..af063eb25e9c 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -76,7 +76,8 @@ struct ad2s1210_state {
 	struct regmap *regmap;
 	/** The external oscillator frequency in Hz. */
 	unsigned long clkin_hz;
-	bool hysteresis;
+	/** Available raw hysteresis values based on resolution. */
+	int hysteresis_available[2];
 	u8 resolution;
 	/** For reading raw sample value via SPI. */
 	__be16 sample __aligned(IIO_DMA_MINALIGN);
@@ -311,6 +312,7 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 		goto error_ret;
 
 	st->resolution = udata;
+	st->hysteresis_available[1] = 1 << (16 - st->resolution);
 	ret = len;
 
 error_ret:
@@ -447,6 +449,35 @@ static int ad2s1210_single_conversion(struct ad2s1210_state *st,
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
+	*val = ret << (16 - st->resolution);
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
@@ -479,7 +510,55 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
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
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			*vals = st->hysteresis_available;
+			*type = IIO_VAL_INT;
+			*length = ARRAY_SIZE(st->hysteresis_available);
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
@@ -520,7 +599,10 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
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
@@ -596,6 +678,8 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
+	.read_avail = ad2s1210_read_avail,
+	.write_raw = ad2s1210_write_raw,
 	.attrs = &ad2s1210_attribute_group,
 	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
@@ -711,8 +795,9 @@ static int ad2s1210_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
-	st->hysteresis = true;
 	st->resolution = 12;
+	st->hysteresis_available[0] = 0;
+	st->hysteresis_available[1] = 1 << (16 - st->resolution);
 
 	ret = ad2s1210_setup_clocks(st);
 	if (ret < 0)

-- 
2.42.0

