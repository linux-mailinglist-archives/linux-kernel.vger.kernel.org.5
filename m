Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44D478BF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjH2HpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjH2Hoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:44:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E10113
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:44:50 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so30573871fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693295089; x=1693899889;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HoKHxCi31sYWMZUsZDNEe3+QfUTrLKmNWaVeGEEaAg=;
        b=pdKQyAu6G8ZHYvEyl4co8Ek4WHVUDKFiRDuD8n9FyrtI9ujfsia+Ay52/6QdXofh7K
         cNWLM3zyM1ZqROTnhPhnjmiRaFrDpSKbb6k4JWbf3xeXF6rJvSQ6mEyP2nYEavOKn0Xm
         rPMcTuDjmByr5LrMwiCvt3IBmIn0YxSMZSx8LbpQ1yPTcgWYfyrAsXLvjNMhV1s49Pyb
         sORxW1vRoHIni1B99rqPk48uUDUkYrheNW648lVONFI3EJex/ENTjuxzWIAbSv1HrVc4
         MSHQD5qC3Tpk/WMEu6gktOT/CWPGVeOM6TmBpJlmGr7Fsg32hvZ6yKsM+U9VO3svzFvZ
         ukRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693295089; x=1693899889;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HoKHxCi31sYWMZUsZDNEe3+QfUTrLKmNWaVeGEEaAg=;
        b=KOP7itMLA5c1vkPGBpq+jHWHLjIbRiQyUvTT96OZrofv7jg6nApeXC6cHf3TVgRtUa
         zkCtpBetxq3F4ObQFGdbESltpLZw9jP5yCdsWsGbh45jJDbx9V2qhz1VPIV7YsLzncBn
         J7VuWjRtkcPOZftfw3d1Lwj8bfOuKACTTLgkMvS/ozbTFgywu0Gcd9NPwtTPTpaj7beU
         9VxcIU03IeHwWv9N5WqI2Ko+RSTMYsNxWt1Jw1EVrjFswNltmz0wFtSEPqX8m30mcoGQ
         8d0fGGLS3WieH4mQStsjL24kIeS1vRHt4F725e6bsqKjgU6TtFPe/gWj7Gqdr/HCs7Nt
         1YMA==
X-Gm-Message-State: AOJu0YxB03tttahWhhLW6OuO2jfzXG0yDtjDcesCZcPzb+3kgqMUtCL4
        yO+BEQa5Ieo3j8FL2b8bUlSrkw==
X-Google-Smtp-Source: AGHT+IH603/f7BMDWm5MFnkc/oBPNjngIdCU8Y28ENJwuL40+PGiMZ75UAXojV2eACqikE7RxXBgTg==
X-Received: by 2002:a2e:b4bb:0:b0:2bc:fc2e:7671 with SMTP id q27-20020a2eb4bb000000b002bcfc2e7671mr5636569ljm.13.1693295089029;
        Tue, 29 Aug 2023 00:44:49 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w1-20020a2e3001000000b002b6c61bac2esm2036316ljw.92.2023.08.29.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 00:44:48 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Aug 2023 09:44:46 +0200
Subject: [PATCH v2] RFC: iio: lsm6dsx: Support temperature channel on some
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-iio-spacex-lsm6ds0-v2-1-584e161b612f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO2h7WQC/32NQQ6CMBBFr0Jm7ZiWFhRX3sOwqHSASZCSjiEY0
 rtbOYDL95L//g5CkUngVuwQaWXhMGcoTwV0o5sHQvaZoVSlUVetkTmgLK6jDSd51V4UGtM1pq6
 osc8e8nCJ1PN2RB9t5pHlHeLn+Fj1z/7NrRoVUlMZZ63SF+XvE88uhnOIA7QppS+JO0CMtQAAA
 A==
To:     Kevin Bosien <kbosien@spacex.com>, Jim Gruen <jgruen@spacex.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISM330 sensors (wai 0x6b) has a temperature channel that can
be read out. Modify the lsm6dsx core to accomodate temperature
readout on these sensors:

- Make headspace for three members in the channels and odr_table,
- Support offset
- Add code to avoid configuring the ODR of the temperature
  sensor, it has no real ODR control register.

This is investigated because the hardware has important real-life
use cases using the Linux kernel.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
The ISM330DHCX is used in the SpaceX Starlink terminals which
are running a realtime patched close-to-mainline Linux kernel so
let's support temperature readout on it because why not.
SpaceX is using the temperature.
---
Changes in v2:
- Put to RFC because I can't test changes.
- Added some mail addresses to SpaceX to the header. Maybe you
  guys can check if this works for you. Or forward to designated
  open source ambassador or whatever can help. (Addresses found
  in SpaceX code drop.)
- Drop the code with strings for ism330dhc as we concluded that
  this is probably ism330dhcx which is already supported.
  (Would be nice if SpaceX can confirm.)
- Don't write in nonsense register 0x0a for temperature sensor
- More elaborate code to just avoid writing ODR for the temperature
  sensor and instead rely on gyro or accelerometer to drive
  the odr
- Link to v1: https://lore.kernel.org/r/20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 24 +++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  4 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 79 +++++++++++++++++++++++++-
 3 files changed, 102 insertions(+), 5 deletions(-)

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
index 6a18b363cf73..76847d95c1b6 100644
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
@@ -869,6 +878,17 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[6] = { 833000, 0x07 },
 				.odr_len = 7,
 			},
+			[ST_LSM6DSX_ID_TEMP] = {
+				/*
+				 * NOTE: this ODR will be capped and controllerd by the
+				 * gyro and accelerometer don't have any reg to configure
+				 * this ODR.
+				 */
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_len = 3,
+			},
 		},
 		.fs_table = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -937,6 +957,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -1618,8 +1642,8 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val)
 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < odr_table->odr_len; i++) {
 		/*
-		 * ext devices can run at different odr respect to
-		 * accel sensor
+		 * ext devices and temp sensor can run at different odr
+		 * respect to accel sensor
 		 */
 		if (odr_table->odr_avl[i].milli_hz >= odr)
 			break;
@@ -1661,6 +1685,21 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
 	switch (sensor->id) {
 	case ST_LSM6DSX_ID_GYRO:
 		break;
+	case ST_LSM6DSX_ID_TEMP:
+		/*
+		 * According to the application note AN5398 Rev 3
+		 * for ISM330DHCX, section 10, page 109
+		 * the ODR for the temperature sensor is equal to the
+		 * accelerometer ODR if the gyroscope is powered-down,
+		 * up to 52 Hz, but constant 52 Hz if the gyroscope
+		 * is powered on. It never goes above 52 Hz.
+		 */
+		ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
+		if ((req_odr > 0) && (hw->enable_mask |= BIT(ref_sensor->id)))
+			/* Gyro is on! ODR fixed to 52 Hz */
+			return 0;
+		/* We fall through and activate accelerometer if need be */
+		fallthrough;
 	case ST_LSM6DSX_ID_EXT0:
 	case ST_LSM6DSX_ID_EXT1:
 	case ST_LSM6DSX_ID_EXT2:
@@ -1800,6 +1839,10 @@ static int st_lsm6dsx_read_raw(struct iio_dev *iio_dev,
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
@@ -2106,6 +2149,22 @@ static const struct iio_info st_lsm6dsx_gyro_info = {
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
@@ -2379,7 +2438,16 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
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
@@ -2393,6 +2461,11 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
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

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230811-iio-spacex-lsm6ds0-33c9365e94bf

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

