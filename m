Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7485B778974
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjHKJIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjHKJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:08:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16CB211C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:08:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso2792922e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691744910; x=1692349710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5IY3ZLhNd20+9mDp30REpkLQW5BJhn/NlB26NgzDAI=;
        b=wKgpY+FFAt33BDk8lE6F8tALR4+XfqND6DCpRr94lyvCgeiStexdObeDeihDWXTXiQ
         GJZghMNZGjySP6Kr+G8EWyg57W/D08n6HQ6O+S3wIenxEXlSjC1hyhqvY8X5Umplx8QC
         eWD2a0EhOOXsL/zwO5exbNSv8jrdw+l3lE4jB5UgHKQUN8M2C5ui+Sloa71WgK/dt5zp
         zyl2Y9/GIiGjNMEvoYVpUZlDgkAepviADuoQfGJmqK/tJ+1zapYaWS1yubmOazEa2J/N
         K5ry194GohRQ9bb+diOZyBhcFbCWtLggevfcGS13tMQQ5S+9pcrAQhkszLUkwejA9yZU
         +Zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691744910; x=1692349710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5IY3ZLhNd20+9mDp30REpkLQW5BJhn/NlB26NgzDAI=;
        b=BHBEaISoVYR44+KcLtksy+4pHDu0ue404llXCs0KEAiYPMWK8mGS0RrWC7mjavm4nk
         DY20AmUnK7J+YfyFr3xmbDgEOJXqNuGRfNUmuS4ZsZjPYtw5dXcJz1RnsXArJDobFJiC
         rpy9UROj6hoA2a4rE5ahVyiMZW5zbkrPx711cBK/B2nwnO4ssB8RGoN16FrAtEnDC4mM
         6NKK0eeWPosiSqdaUODb1qchFdsqyb5x+x8pOD5AnVaXcp7Wl9k3E7lD+0Aj1Q9NbiK9
         2u4jRhBzQogk66YgSfPCYVABrZ4L39qKnvj8vKdPMoknJgldyTXE6EYa7VaiWGKb7bKZ
         2tQg==
X-Gm-Message-State: AOJu0YySfv2PR/cdFTOG3Un6DrsfiOO5xBpyfpoFnEqEhxHIl2m9YZ5p
        6k3MrsmIpt1+RECzWZonobF+Bw==
X-Google-Smtp-Source: AGHT+IFlMFYYzVflWTS0CtXtFQfKRmOmQKw9ADbxPGM1Ed6IP8phoOD1ggZU/0N368T3CJf59HGbpA==
X-Received: by 2002:a05:6512:acf:b0:4fb:9446:598b with SMTP id n15-20020a0565120acf00b004fb9446598bmr964118lfu.27.1691744909778;
        Fri, 11 Aug 2023 02:08:29 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm642340lfl.299.2023.08.11.02.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:08:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 11:08:25 +0200
Subject: [PATCH 1/2] iio: lsm6dsx: Support temperature channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-iio-spacex-lsm6ds0-v1-1-e953a440170d@linaro.org>
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

The LSM6DSX (possibly other ST IMUs as well) has a temperature
channel that can be read out. Modify the lsm6dsx core to
accomodate temperature readout: make headspace for three
members in the channels and odr_table, support offset and make
the available milli_hz frequency resolution optional.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 24 ++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  4 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 67 ++++++++++++++++++++++++--
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c19237717e81..4d013889c287 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -118,6 +118,23 @@ enum st_lsm6dsx_hw_id {
 	.ext_info = st_lsm6dsx_ext_info,				\
 }
 
+#define ST_LSM6DSX_TEMP(chan_type, addr, scan_idx)			\
+{									\
+	.type = chan_type,						\
+	.address = addr,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+				BIT(IIO_CHAN_INFO_SCALE) |		\
+				BIT(IIO_CHAN_INFO_OFFSET),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = scan_idx,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
 struct st_lsm6dsx_reg {
 	u8 addr;
 	u8 mask;
@@ -320,7 +337,7 @@ struct st_lsm6dsx_settings {
 	struct {
 		const struct iio_chan_spec *chan;
 		int len;
-	} channels[2];
+	} channels[3];
 	struct {
 		struct st_lsm6dsx_reg irq1;
 		struct st_lsm6dsx_reg irq2;
@@ -332,7 +349,7 @@ struct st_lsm6dsx_settings {
 		struct st_lsm6dsx_reg od;
 	} irq_config;
 	struct st_lsm6dsx_reg drdy_mask;
-	struct st_lsm6dsx_odr_table_entry odr_table[2];
+	struct st_lsm6dsx_odr_table_entry odr_table[3];
 	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
@@ -346,6 +363,7 @@ struct st_lsm6dsx_settings {
 enum st_lsm6dsx_sensor_id {
 	ST_LSM6DSX_ID_GYRO,
 	ST_LSM6DSX_ID_ACC,
+	ST_LSM6DSX_ID_TEMP,
 	ST_LSM6DSX_ID_EXT0,
 	ST_LSM6DSX_ID_EXT1,
 	ST_LSM6DSX_ID_EXT2,
@@ -364,6 +382,7 @@ enum st_lsm6dsx_fifo_mode {
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
  * @odr: Output data rate of the sensor [Hz].
+ * @offset: Constant offset of the sensor
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
@@ -378,6 +397,7 @@ struct st_lsm6dsx_sensor {
 
 	u32 gain;
 	u32 odr;
+	u32 offset;
 
 	u16 samples_to_discard;
 	u16 watermark;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 066fe561c5e8..c588451e2ddf 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -61,6 +61,7 @@ struct st_lsm6dsx_decimator_entry {
 enum st_lsm6dsx_fifo_tag {
 	ST_LSM6DSX_GYRO_TAG = 0x01,
 	ST_LSM6DSX_ACC_TAG = 0x02,
+	ST_LSM6DSX_TEMP_TAG = 0x03,
 	ST_LSM6DSX_TS_TAG = 0x04,
 	ST_LSM6DSX_EXT0_TAG = 0x0f,
 	ST_LSM6DSX_EXT1_TAG = 0x10,
@@ -532,6 +533,9 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
 	case ST_LSM6DSX_ACC_TAG:
 		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_ACC];
 		break;
+	case ST_LSM6DSX_TEMP_TAG:
+		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_TEMP];
+		break;
 	case ST_LSM6DSX_EXT0_TAG:
 		if (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT0))
 			iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT0];
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 6a18b363cf73..c743c4871ad6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -100,6 +100,11 @@ static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec st_lsm6dsx_temp_channels[] = {
+	ST_LSM6DSX_TEMP(IIO_TEMP, 0x20, 0),
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.reset = {
@@ -835,6 +840,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.chan = st_lsm6dsx_gyro_channels,
 				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
 			},
+			[ST_LSM6DSX_ID_TEMP] = {
+				.chan = st_lsm6dsx_temp_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_temp_channels),
+			},
 		},
 		.drdy_mask = {
 			.addr = 0x13,
@@ -869,6 +878,15 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[6] = { 833000, 0x07 },
 				.odr_len = 7,
 			},
+			[ST_LSM6DSX_ID_TEMP] = {
+				.reg = {
+					.addr = 0x0A,
+					.mask = GENMASK(5, 4),
+				},
+				.odr_avl[0] = {  26000, 0x02 },
+				.odr_avl[1] = {  52000, 0x03 },
+				.odr_len = 2,
+			},
 		},
 		.fs_table = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -937,6 +955,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x09,
 				.mask = GENMASK(7, 4),
 			},
+			[ST_LSM6DSX_ID_TEMP] = {
+				.addr = 0x0A,
+				.mask = GENMASK(5, 4),
+			},
 		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
@@ -1661,6 +1683,7 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
 	switch (sensor->id) {
 	case ST_LSM6DSX_ID_GYRO:
 		break;
+	case ST_LSM6DSX_ID_TEMP:
 	case ST_LSM6DSX_ID_EXT0:
 	case ST_LSM6DSX_ID_EXT1:
 	case ST_LSM6DSX_ID_EXT2:
@@ -1800,6 +1823,10 @@ static int st_lsm6dsx_read_raw(struct iio_dev *iio_dev,
 		*val2 = sensor->gain;
 		ret = IIO_VAL_INT_PLUS_NANO;
 		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = sensor->offset;
+		ret = IIO_VAL_INT;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2016,9 +2043,11 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 
 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < odr_table->odr_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
-				 odr_table->odr_avl[i].milli_hz / 1000,
-				 odr_table->odr_avl[i].milli_hz % 1000);
+		if (odr_table->odr_avl[i].milli_hz) {
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
+					 odr_table->odr_avl[i].milli_hz / 1000,
+					 odr_table->odr_avl[i].milli_hz % 1000);
+		}
 	buf[len - 1] = '\n';
 
 	return len;
@@ -2106,6 +2135,22 @@ static const struct iio_info st_lsm6dsx_gyro_info = {
 	.write_raw_get_fmt = st_lsm6dsx_write_raw_get_fmt,
 };
 
+static struct attribute *st_lsm6dsx_temp_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group st_lsm6dsx_temp_attribute_group = {
+	.attrs = st_lsm6dsx_temp_attributes,
+};
+
+static const struct iio_info st_lsm6dsx_temp_info = {
+	.attrs = &st_lsm6dsx_temp_attribute_group,
+	.read_raw = st_lsm6dsx_read_raw,
+	.write_raw = st_lsm6dsx_write_raw,
+	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
+};
+
 static int st_lsm6dsx_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
 {
 	struct device *dev = hw->dev;
@@ -2379,7 +2424,16 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor->id = id;
 	sensor->hw = hw;
 	sensor->odr = hw->settings->odr_table[id].odr_avl[0].milli_hz;
-	sensor->gain = hw->settings->fs_table[id].fs_avl[0].gain;
+	if (id == ST_LSM6DSX_ID_TEMP) {
+		/*
+		 * The temperature sensor has a fixed scale and offset such
+		 * that: temp_C = (raw / 256) + 25
+		 */
+		sensor->gain = 3906;
+		sensor->offset = 25;
+	} else {
+		sensor->gain = hw->settings->fs_table[id].fs_avl[0].gain;
+	}
 	sensor->watermark = 1;
 
 	switch (id) {
@@ -2393,6 +2447,11 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
 			  name);
 		break;
+	case ST_LSM6DSX_ID_TEMP:
+		iio_dev->info = &st_lsm6dsx_temp_info;
+		scnprintf(sensor->name, sizeof(sensor->name), "%s_temp",
+			  name);
+		break;
 	default:
 		return NULL;
 	}

-- 
2.34.1

