Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FB778975
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjHKJIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjHKJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:08:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3DA2D61
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:08:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso2792941e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691744911; x=1692349711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7NPM0kpp70D9cWUQPi+156bGlIPhQX899VN4eEFZnE=;
        b=B2d1kgL3dty1+KwhOuGwsp8iqJSMD4QsEXAWgRvh+gktsYOrTeBIieOCRJfqh95P18
         BjRE6TY1AedVAk1n6rrXL+8DS9ddlmWUG8CJ6viIvA0XbzFcivNnYSleU3jSbk2XgmFQ
         HTk+gTIS8eII65N5BJmb/cp87xcrybDUW0g8Io8I2q26EznBk5uOg55N1aLGZVWPHuax
         HZ7J6Zky/AQeSdLEJD89fiooVtDJnjVtlAnOoiGwguc08ulM9rsLuIcT+hGEkeuNTbmD
         E1fBSjI8IeWQp4juqTDvKiRURH5h4Qzs1wrEVFY8EXtna+J2oTYtmTpmJxxBl9/CgGC3
         PVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691744911; x=1692349711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7NPM0kpp70D9cWUQPi+156bGlIPhQX899VN4eEFZnE=;
        b=iXZD91okkBj6qFYvpa/tmixgew6lGL+FpolmB9zE3o/ZI65/qBLhVzCvZNIhk6RfOb
         uMot/4SWO75KRBmUL19l7nKQ8XFgNtPgP+GCZcc4rtE9n5PQ56gPe4cSNJ0o7qjQ5x4W
         znM4ZQhJo7+Li4pqNXsqFMxMD8zySDkqd8+z6NRsv2Mrq9sJoFV7Wu5Mg/n1VjkGgqg6
         Kmg5VNpIK5/MqqW1PtGDezlTcW8Cj8hOGxf090u+xJxd42GiUQeoBOqdT8piSZfcTVH/
         DGFYaY5aZJGdNlp1MaXtZDMcnFIXDv/HpKq4AWFi6EiV9Tbv1kn9uo/nx7xU3rvpMVD7
         modA==
X-Gm-Message-State: AOJu0Yw29jIEHcZov2abmwIc4lyF3Wt7K/5SdYvVF10ErVJBJ89Vavyk
        p9UJ1Y9+eOxYnYA/+NH5f6VhOw==
X-Google-Smtp-Source: AGHT+IE1p1zITNLMrj2aa67zvJJLI14eSkD8lxv6zh/M2gHtA+o5SlKVhBUBqK+dq68Ktg3di/0NnA==
X-Received: by 2002:a05:6512:a95:b0:4fe:1f1c:184f with SMTP id m21-20020a0565120a9500b004fe1f1c184fmr1029405lfu.44.1691744910816;
        Fri, 11 Aug 2023 02:08:30 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm642340lfl.299.2023.08.11.02.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:08:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 11:08:26 +0200
Subject: [PATCH 2/2] iio: imu: lsm6dsx: Add support for ism330dhc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-iio-spacex-lsm6ds0-v1-2-e953a440170d@linaro.org>
References: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
In-Reply-To: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISM330DHC sensor is used in the SpaceX Starlink ground
terminals.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig           | 8 ++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  | 4 ++++
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 5865a295a4df..fbb5da92f954 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -12,10 +12,10 @@ config IIO_ST_LSM6DSX
 	help
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
-	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
-	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
-	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, lsm6dst
-	  and the accelerometer/gyroscope of lsm9ds1.
+	  ism330dlc, ism330dhc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx,
+	  lsm6dsr, lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop,
+	  lsm6dstx, lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb,
+	  lsm6dst and the accelerometer/gyroscope of lsm9ds1.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 4d013889c287..b702ec768067 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -20,6 +20,7 @@
 #define ST_LSM6DSL_DEV_NAME	"lsm6dsl"
 #define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
 #define ST_ISM330DLC_DEV_NAME	"ism330dlc"
+#define ST_ISM330DHC_DEV_NAME	"ism330dhc"
 #define ST_LSM6DSO_DEV_NAME	"lsm6dso"
 #define ST_ASM330LHH_DEV_NAME	"asm330lhh"
 #define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
@@ -45,6 +46,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DSL_ID,
 	ST_LSM6DSM_ID,
 	ST_ISM330DLC_ID,
+	ST_ISM330DHC_ID,
 	ST_LSM6DSO_ID,
 	ST_ASM330LHH_ID,
 	ST_LSM6DSOX_ID,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c743c4871ad6..e39651ac86fb 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -20,7 +20,7 @@
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 8KB
  *
- * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
+ * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/ISM330DHC/LSM6DS3TR-C:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
@@ -809,6 +809,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.hw_id = ST_LSM6DSRX_ID,
 				.name = ST_LSM6DSRX_DEV_NAME,
 				.wai = 0x6b,
+			}, {
+				.hw_id = ST_ISM330DHC_ID,
+				.name = ST_ISM330DHC_DEV_NAME,
+				.wai = 0x6b,
 			}, {
 				.hw_id = ST_LSM6DSO_ID,
 				.name = ST_LSM6DSO_DEV_NAME,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 911444ec57c0..506a5a146bd5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -62,6 +62,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,ism330dlc",
 		.data = (void *)ST_ISM330DLC_ID,
 	},
+	{
+		.compatible = "st,ism330dhc",
+		.data = (void *)ST_ISM330DHC_ID,
+	},
 	{
 		.compatible = "st,lsm6dso",
 		.data = (void *)ST_LSM6DSO_ID,
@@ -150,6 +154,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
 	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
 	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
+	{ ST_ISM330DHC_DEV_NAME, ST_ISM330DHC_ID },
 	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
 	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
 	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index f56c170c41a9..5ebe59cdc35f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -57,6 +57,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,ism330dlc",
 		.data = (void *)ST_ISM330DLC_ID,
 	},
+	{
+		.compatible = "st,ism330dhc",
+		.data = (void *)ST_ISM330DHC_ID,
+	},
 	{
 		.compatible = "st,lsm6dso",
 		.data = (void *)ST_LSM6DSO_ID,

-- 
2.34.1

