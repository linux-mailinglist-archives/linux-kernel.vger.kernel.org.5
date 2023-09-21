Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67007A9F79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjIUUWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIUUWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:22:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D853C10182
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ad8bba8125so159472066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317389; x=1695922189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xPn0fJb1G79vmQneRtFHd9riwOuPrJO1tNQT+KG0zw=;
        b=vGywFzIyVlqaDtmzt/UED2fs7D4gyvtpUpoVEYskX/NnqTJWi+d2dOREdB9MHu3jhF
         iXa6d8zI2/l5YlGsHsS18qdy0IifUAfL7m5Eb883TRSFtDTrDNVXb7+t79iTsZoOgAjp
         bfwEH0mn6xsosTGSXQjuyDGGUG1kIxjqowW727EzLI5pzYmhUWbjRwFzQ/DVCOha2D44
         G0gA7K11g+N/iHfbjiMg03LHJCeCiKJ4JHRhDhP62sw04qX2+6gHH8Q+MBq1UoM5Ysdl
         l5Fbm9uz3Zi/lS7srCfesrx4C7uA7H4Yn9eFrOS7kXYhAgogiQ5Rm8aCdvcoPnRYnxUV
         5aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317389; x=1695922189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xPn0fJb1G79vmQneRtFHd9riwOuPrJO1tNQT+KG0zw=;
        b=RreOZaiTLF7pvd8XYXR0Xd661UKZKBuM1hJMhPdXvicijBLMs7E6XXUl/GtwXhBx83
         3y2ExcN1Xedw7J6WjdXHJ2KLL7kk8phNHflqjzaPygoJh0INfZn902OODse3uaiJOWMh
         j+0RvwqcDPKDXXE0n89R6FjodAysV9Lqjef8byxNAMK5McI75pQlc4qJFNL5qKjoUCpW
         +jgEM1sq2baKr7Wnr4zSLV41EOhotcJm4useYxy4yYzhUBbfazXStFOP4mY5LWJgfLXv
         RQ5AjNZhjMQR1fEt8vONwlpgL26eXLj7Fw+A/rJ9tMZJYZ9qrVVMArdh71blG1Y+C5Bp
         416A==
X-Gm-Message-State: AOJu0YzopoRev/spIpX7HwQvMFovmBfMRasYi478tEB1SDTKugjHdn08
        q7N0Jlk2k5ziEyzF9pdxWiQQBJz3iRwoR6ggWIzojkeH
X-Google-Smtp-Source: AGHT+IH24xvDRaPHH44BwrDTbzdtwnxnkxTSk7+JyUWRFP+k6Au8hn9xlr4Gj5hf6z+Ngqc6nhucog==
X-Received: by 2002:a7b:c859:0:b0:402:95a0:b2ae with SMTP id c25-20020a7bc859000000b0040295a0b2aemr4971411wml.32.1695307458717;
        Thu, 21 Sep 2023 07:44:18 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:18 -0700 (PDT)
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
Subject: [PATCH v2 07/19] staging: iio: resolver: ad2s1210: implement IIO_CHAN_INFO_SCALE
Date:   Thu, 21 Sep 2023 09:43:48 -0500
Message-Id: <20230921144400.62380-8-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
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

This adds an implementation of IIO_CHAN_INFO_SCALE to the ad2s1210
resolver driver. This allows userspace to get the scale factor for the
raw values.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 107 ++++++++++++++++--------
 1 file changed, 72 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 985b8fecd65a..95d43b241a75 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -458,56 +458,91 @@ static ssize_t ad2s1210_store_reg(struct device *dev,
 	return ret < 0 ? ret : len;
 }
 
+static const int ad2s1210_velocity_scale[] = {
+	17089132, /* 8.192MHz / (2*pi * 2500 / 2^15) */
+	42722830, /* 8.192MHz / (2*pi * 1000 / 2^15) */
+	85445659, /* 8.192MHz / (2*pi * 500 / 2^15) */
+	341782638, /* 8.192MHz / (2*pi * 125 / 2^15) */
+};
+
 static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val,
 			     int *val2,
-			     long m)
+			     long mask)
 {
 	struct ad2s1210_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	mutex_lock(&st->lock);
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
-	/* delay (6 * tck + 20) nano seconds */
-	udelay(1);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
+		/* delay (6 * tck + 20) nano seconds */
+		udelay(1);
+
+		switch (chan->type) {
+		case IIO_ANGL:
+			ad2s1210_set_mode(MOD_POS, st);
+			break;
+		case IIO_ANGL_VEL:
+			ad2s1210_set_mode(MOD_VEL, st);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		if (ret < 0)
+			goto error_info_raw;
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0)
+			goto error_info_raw;
+
+		switch (chan->type) {
+		case IIO_ANGL:
+			*val = be16_to_cpup((__be16 *)st->rx);
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_ANGL_VEL:
+			*val = (s16)be16_to_cpup((__be16 *)st->rx);
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 
-	switch (chan->type) {
-	case IIO_ANGL:
-		ad2s1210_set_mode(MOD_POS, st);
-		break;
-	case IIO_ANGL_VEL:
-		ad2s1210_set_mode(MOD_VEL, st);
-		break;
-	default:
-		ret = -EINVAL;
+error_info_raw:
+		gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
+		/* delay (2 * tck + 20) nano seconds */
+		udelay(1);
+		mutex_unlock(&st->lock);
 		break;
-	}
-	if (ret < 0)
-		goto error_ret;
-	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret < 0)
-		goto error_ret;
 
-	switch (chan->type) {
-	case IIO_ANGL:
-		*val = be16_to_cpup((__be16 *)st->rx);
-		ret = IIO_VAL_INT;
-		break;
-	case IIO_ANGL_VEL:
-		*val = (s16)be16_to_cpup((__be16 *)st->rx);
-		ret = IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL:
+			/* approx 0.3 arc min converted to radians */
+			*val = 0;
+			*val2 = 95874;
+			ret = IIO_VAL_INT_PLUS_NANO;
+			break;
+		case IIO_ANGL_VEL:
+			*val = st->fclkin;
+			*val2 = ad2s1210_velocity_scale[st->resolution];
+			ret = IIO_VAL_FRACTIONAL;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 		break;
+
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
-error_ret:
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
-	/* delay (2 * tck + 20) nano seconds */
-	udelay(1);
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -549,12 +584,14 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.type = IIO_ANGL,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
 	}
 };
 
-- 
2.34.1

