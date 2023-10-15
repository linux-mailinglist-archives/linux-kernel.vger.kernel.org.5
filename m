Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1952A7C99BB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjJOPSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjJOPSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:18:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B529106;
        Sun, 15 Oct 2023 08:18:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso34445945e9.0;
        Sun, 15 Oct 2023 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697383082; x=1697987882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGL0YH1al5bgYEOMpJxA3ocj/opSXqoY++n/reNrEe0=;
        b=m1w304aMx90BQVokAicwtTBiENyzY7q8VNXoCLJEqAF/+Z2keC6vZ7GB6TFcsoN/T5
         e+hx5Lznnzq7rB9pxFi0ImdP2rxZXdc9Zu4iOMcrROAJj1zyJSZIn1v9WJnZMqepMZvZ
         0fh7n+CriQ3d7VovZ48K8V1/mKeHXVOZsYq3YJig+0KhBysdRT1UGLZExecM6ChXuhC8
         WL3TMEOlvkjMRVxDzLTuIfeMOOGzwNKptik1Xl4N5UGzw4h39oqMVNS5SQy5Ba4GxwoH
         6aZB+K1DGQDoq2mBG04jHaor9td4iQb1mrYeLpgSzkByXEczzf03qTcq489jFE1u62rJ
         KCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697383082; x=1697987882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGL0YH1al5bgYEOMpJxA3ocj/opSXqoY++n/reNrEe0=;
        b=rT1kigJS3Tng7haArCBTNjmoz2QNkradwaFdTtlhFHnpc8x0E4eUp3r5APa+vPtcNa
         wZ3x3jd6cOHAjnbFrlA8RRUMl6/UAd6hqJq9cept9iggumcglIVl4yAHjuljE5h5LQUJ
         zS130VujncmrRu/X46/gHnjs5qza/Hx2wIwVzTgxqFsqyP9mpSU0qHrXRIXjRXPCnH4F
         o7ePRLB6FT4JfNA8xvFoKyUOeeK8/l8UaZZyIQXNxpELuzXQOYTys+8gB0r4pvXtQQgy
         A/au58C1Hlfcc/wjQSNiGTsuMs1VDFbrTBf87MySjj08yz9tk8RVzYjRS719Ve9OrGdS
         FbzA==
X-Gm-Message-State: AOJu0YxqllE4wzyo+iYtBxEhaBM8lK6PHFc9JXIOyfhO7qtb8qv2I5FB
        wJlH4Z47maSyU1Pc3r9t6uQrlKZNGB0=
X-Google-Smtp-Source: AGHT+IHbKiw2KshL5xnnoHRY/OyeIGCE+QyRr3scTeOYIQmiUnEQOdlTCGm3ZO7AXNAzyTirIR5TNg==
X-Received: by 2002:a05:600c:214f:b0:405:3251:47a1 with SMTP id v15-20020a05600c214f00b00405325147a1mr27399649wml.40.1697383082133;
        Sun, 15 Oct 2023 08:18:02 -0700 (PDT)
Received: from localhost.localdomain (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003fc16ee2864sm4712455wms.48.2023.10.15.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 08:18:01 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/5] iio: pressure: bmp280: Rearrange vars in reverse xmas tree order
Date:   Sun, 15 Oct 2023 17:16:25 +0200
Message-ID: <7db5fe65a78513137206ae6b33abb1e48d356fbf.1697381932.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697381932.git.ang.iglesiasg@gmail.com>
References: <cover.1697381932.git.ang.iglesiasg@gmail.com>
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

Small cleanup reordering local variable declarations following reverse
christmas tree convention.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6089f3f9d8f4..ea02a623bb58 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -766,8 +766,8 @@ static const struct iio_info bmp280_info = {
 
 static int bmp280_chip_config(struct bmp280_data *data)
 {
-	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
-		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
+	u8 osrs = FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1) |
+		  FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1);
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index b3e069730f97..34e3bc758493 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -7,9 +7,9 @@
 
 static int bmp280_i2c_probe(struct i2c_client *client)
 {
-	struct regmap *regmap;
-	const struct bmp280_chip_info *chip_info;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct bmp280_chip_info *chip_info;
+	struct regmap *regmap;
 
 	chip_info = i2c_get_match_data(client);
 
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 2eed483a8cc4..433d6fac83c4 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -14,8 +14,7 @@
 static int bmp280_regmap_spi_write(void *context, const void *data,
                                    size_t count)
 {
-	struct device *dev = context;
-	struct spi_device *spi = to_spi_device(dev);
+	struct spi_device *spi = to_spi_device(context);
 	u8 buf[2];
 
 	memcpy(buf, data, 2);
@@ -31,8 +30,7 @@ static int bmp280_regmap_spi_write(void *context, const void *data,
 static int bmp280_regmap_spi_read(void *context, const void *reg,
                                   size_t reg_size, void *val, size_t val_size)
 {
-	struct device *dev = context;
-	struct spi_device *spi = to_spi_device(dev);
+	struct spi_device *spi = to_spi_device(context);
 
 	return spi_write_then_read(spi, reg, reg_size, val, val_size);
 }
-- 
2.42.0

