Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3217AA0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjIUUuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjIUUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:49:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393D88AE6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:39:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so2621244a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317963; x=1695922763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC6Tj/wZ71OdWmHfRNe2x49Rd8CoFCC05cRR7nhn858=;
        b=xfyEMLZ9nPlOSFp7g01Ba29mZS7fnL34InjOc1pS+FYWsmjlJ4Sq9T715W+NAA1jNq
         7gzsKyK1OdCTeRL1C7yyZDtm52/pA04ZB2v2l6QAlJAcDzR0qD8bFHJX0VBFWvx9IBIS
         PvXSwuVCXmGdcx2bWyCzJjz1yP4mHwPkadmjWb0bEUGgl6f2KdEaaFwwIV8hAGvvxMtU
         F6UtxET1JDqkWhGsW3Jw0MNWhkh4VCJoKJ0EzWqlRYaGHMCVyAS4w3OpHW/w15Q8R4Fp
         A+sLWNZxZjzVGBKlIUjzkHbVpa84D1QmI6Y0kKzNdWUB4aDHrVksBhHx1wYuhiKJOc3e
         JcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317963; x=1695922763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC6Tj/wZ71OdWmHfRNe2x49Rd8CoFCC05cRR7nhn858=;
        b=kV7XN2yKcL15M69Jp3I2FrTd8l7VT3LTvUSKfatC/HsdyN4GBbjP/Z+NCbwaR/7JP9
         4SfJ0D05BuzCxedC3rkz0b+d5S+fdxuo0daUtknyYQVFrEt0/Jq7A3BXguzPY30njie+
         u7885HyJ807DzZfuZ8jXv6sNzuMBWS+rloE5noz+Cf4ZHp90d4J1XUNLGnnNDcAixJJj
         F/NS18UExr3KViMOsA8pva3Cw9iCeQBJjsdFpU9TtnniGLz4RBQW50/D0gctfuLh3zVo
         nb9/GsH3zHRJOpOovYtzzBT1czcQ7kbwd0FCu94M1zFwQaXph8Vq8ZQMeBp3H1HS6Xht
         aePQ==
X-Gm-Message-State: AOJu0YzFBgr6ynBSFx+ZTC4sPgLbMaRU+bDr9fSSQxmSdGgzPEttSxiO
        kkkOz5ddJ2sYOeGAIExNzHLBdhy64+nExm8jYGinlur0
X-Google-Smtp-Source: AGHT+IEeRgrsoxDfX29qrjpP91FiFRBv3vO2R0yidMQo5d2X1FKFBQlgvaBLgvFag4zdxsrc6bIIrA==
X-Received: by 2002:a05:600c:3789:b0:3fb:c075:b308 with SMTP id o9-20020a05600c378900b003fbc075b308mr4598503wmr.12.1695307457067;
        Thu, 21 Sep 2023 07:44:17 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:16 -0700 (PDT)
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
Subject: [PATCH v2 05/19] staging: iio: resolver: ad2s1210: fix probe
Date:   Thu, 21 Sep 2023 09:43:46 -0500
Message-Id: <20230921144400.62380-6-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a number of issues in the ad2s1210_probe() function:
- Move call to ad2s1210_setup_gpios() after `st->sdev = spi;`. This
  fixes use of this pointer before it is initialized.
- Check return value on ad2s1210_initial().
- Move devm_iio_device_register() to the end to avoid race of
  registering before fully initialized.
- Remove call to spi_setup(). Note: MODE_3 was incorrect, it should be
  MODE_1 but we can let the device tree select this.
- Change default value for fclkin. This is an external oscillator, not
  the SPI bus clock. (Will use device tree to get the correct value
  in a future patch. For now, using the eval board value.)
- Remove spi_set_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0bdd5a30d45d..9c7f76114360 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -3,6 +3,7 @@
  * ad2s1210.c support for the ADI Resolver to Digital Converters: AD2S1210
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
+ * Copyright (C) 2023 BayLibre, SAS
  */
 #include <linux/types.h>
 #include <linux/mutex.h>
@@ -657,12 +658,8 @@ static int ad2s1210_probe(struct spi_device *spi)
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
-	st = iio_priv(indio_dev);
-	ret = ad2s1210_setup_gpios(st);
-	if (ret < 0)
-		return ret;
 
-	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
@@ -671,22 +668,25 @@ static int ad2s1210_probe(struct spi_device *spi)
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
+	ret = ad2s1210_setup_clocks(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad2s1210_setup_gpios(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad2s1210_initial(st);
+	if (ret < 0)
+		return ret;
+
 	indio_dev->info = &ad2s1210_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1210_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-
-	st->fclkin = spi->max_speed_hz;
-	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
-	ad2s1210_initial(st);
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad2s1210_of_match[] = {
-- 
2.34.1

