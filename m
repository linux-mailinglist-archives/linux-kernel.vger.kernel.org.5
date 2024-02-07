Return-Path: <linux-kernel+bounces-56086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D1184C5C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBCB28558D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F97200A8;
	Wed,  7 Feb 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwqZwMS6"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD88208A4;
	Wed,  7 Feb 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292110; cv=none; b=QEsfWamPnT/x+rkxeDYUeo3DDIBtq61pR8w75Trfm1dc7hRKY0maklMXCk5JarFHbwuobqmmG6voY/Cl0T1IfOfmwSt3ECqdtQJg0eE7o9nrWwThC1ijK2Pqpf0/+1o53cpb2GE4cFy7bVJJhEXU/3MQPCKSBJPgXUXrseVI9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292110; c=relaxed/simple;
	bh=BFqS0IsduglHjAAPmTqEr63P2VFfJG6M/f3yMwZNnOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCUgdixOMBtLXQK1UYAPUqzqzscn4qcWkYvAAjcRBat1WWISfpCSUG4QQ2AoEmv36VLhZg2b/gY1/Zx9gbyJ0xOZqsUrJIMOk3+sco0Gt/D4wl/BSAS0hRwLkGMcKfqYNCQx4Q5L/P4PTlZhzUhoppMmoqW26Qe9X7mhHP4mTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwqZwMS6; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511612e0c57so551434e87.2;
        Tue, 06 Feb 2024 23:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707292107; x=1707896907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSsDrkUl+1OnBfSZ0zcNQM1UdLPAtZZNZ7LvLO/kLi0=;
        b=kwqZwMS6iw21F3cpO+re5gXX3UXowc57HR4jit3lQorrytuIyWvMiBqLHG4Ly+z5Op
         m1aUOkYudD24nUS7ulol5DNI/WHU2SwpIOYc8u/T+E13l8QaMmq9FTNbC9dnuVj2CtyE
         PNbJBlOZqWGJ+40f2lR0j+L4gNCiThrb3sgH7cgIqYF73V14XwHb6ppko4bl0frbFrAH
         1E+vlIiVH93q38Amna4diTfh0XNwubGjPJDkjx6cmY/+2J3sNA1aOJbwJZc3czrperYv
         p/7iDj5dIlez8Rb5+g8oEQmD/OEEHTAbZIH7y+r0fanxznCefAwwZK03vMYTSCtVQxfa
         LJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292107; x=1707896907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSsDrkUl+1OnBfSZ0zcNQM1UdLPAtZZNZ7LvLO/kLi0=;
        b=cbCLTwPQT8loXFG2aNlS+pEzAFddqDZeyZ4m0OWk1UFkY2NJWjlnugrIivkaZCyH2k
         bJYuu44wTrCii805i8IxFb4u759s7Gv52v7LZa7IUC7OIStxtiTXtMuLV2OlV/u3QJlo
         P+qg+aXpSHiFDmDKo8whG0+uQ1Dw14Tua8rJHoBZ35+6cwacU9mMfYnBw2b/IuNagsAE
         SHOgYOeh9+k6gVGQQal3rxF/ExkWrYLBKwmqoutsLSC0Vw3GSCD3VapjA5xhUouMNbss
         YI9uJciTBQgnroVJMWR01QL1xreivDm7nCkOrvTjsFIw0e4GBct+0wYdPZmgeuTqNIc1
         V3aQ==
X-Gm-Message-State: AOJu0Yxfn7V3koR0PGMR7XjuBMnEHbgGpviPTIYlk0n4E49urY2lsQaC
	N/372JMveAMX9AsgYVAkqujgjI1RoNfatz4Ynmc1ykfNtrswCrHj
X-Google-Smtp-Source: AGHT+IHI0lxVcEyQGKPBYq0uAnDYIp/73NHJDZOXjmpn96nMXwfsyzcvv1hePFL6pN413ccTTMs0IQ==
X-Received: by 2002:a05:6512:2354:b0:511:5e6c:c021 with SMTP id p20-20020a056512235400b005115e6cc021mr3211479lfu.36.1707292106507;
        Tue, 06 Feb 2024 23:48:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU565gfw1ZQiQpMrRdgG7cijrH45AhzZQG/Hz0EkMTy5UzxV1iX0/FqKfVfELvPvTkkahPiCa1cw9AeYtJ9Trhd0kvtcn1hDMocGuqS0wlGbRxu5eMRh3iZQ0kaaLtLmAjtGggMC8jr3ISgO1EHHrNgfqfU0HZ5XTFX2cutKLtKRMRN6tAikJZyEWD291EPBO1KXsFtBfcPgB8sCfWwhPmK0nJK1rCgipb0dlWLYJehLm116RFt4vQpn00FwEHbKzDdxxTXCCT06a4QxFrSrDLP
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id f3-20020a05640214c300b00560556fe9b7sm378558edx.78.2024.02.06.23.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 23:48:25 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Li peiyu <579lpy@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] iio: humidity: hdc3020: add threshold events support
Date: Wed,  7 Feb 2024 08:47:53 +0100
Message-Id: <20240207074758.4138724-4-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207074758.4138724-1-dima.fedrau@gmail.com>
References: <20240207074758.4138724-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add threshold events support for temperature and relative humidity. To
enable them the higher and lower threshold registers must be programmed
and the higher threshold must be greater then or equal to the lower
threshold. Otherwise the event is disabled. Invalid hysteresis values
are ignored by the device. There is no further configuration possible.

Tested by setting thresholds/hysteresis and turning the heater on/off.
Used iio_event_monitor in tools/iio to catch events while constantly
displaying temperature and humidity values.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/humidity/hdc3020.c | 245 +++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 4ae4dd3187db..921d6061ef0d 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -8,35 +8,62 @@
  * Datasheet: https://www.ti.com/lit/ds/symlink/hdc3020.pdf
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/units.h>
 
 #include <asm/unaligned.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
 #define HDC3020_S_AUTO_10HZ_MOD0	0x2737
+#define HDC3020_S_STATUS		0x3041
 #define HDC3020_HEATER_DISABLE		0x3066
 #define HDC3020_HEATER_ENABLE		0x306D
 #define HDC3020_HEATER_CONFIG		0x306E
 #define HDC3020_EXIT_AUTO		0x3093
+#define HDC3020_S_T_RH_THRESH_LOW	0x6100
+#define HDC3020_S_T_RH_THRESH_LOW_CLR	0x610B
+#define HDC3020_S_T_RH_THRESH_HIGH_CLR	0x6116
+#define HDC3020_S_T_RH_THRESH_HIGH	0x611D
 #define HDC3020_R_T_RH_AUTO		0xE000
 #define HDC3020_R_T_LOW_AUTO		0xE002
 #define HDC3020_R_T_HIGH_AUTO		0xE003
 #define HDC3020_R_RH_LOW_AUTO		0xE004
 #define HDC3020_R_RH_HIGH_AUTO		0xE005
+#define HDC3020_R_T_RH_THRESH_LOW	0xE102
+#define HDC3020_R_T_RH_THRESH_LOW_CLR	0xE109
+#define HDC3020_R_T_RH_THRESH_HIGH_CLR	0xE114
+#define HDC3020_R_T_RH_THRESH_HIGH	0xE11F
+#define HDC3020_R_STATUS		0xF32D
+
+#define HDC3020_THRESH_TEMP_MASK	GENMASK(8, 0)
+#define HDC3020_THRESH_TEMP_TRUNC_SHIFT	7
+#define HDC3020_THRESH_HUM_MASK		GENMASK(15, 9)
+#define HDC3020_THRESH_HUM_TRUNC_SHIFT	9
+
+#define HDC3020_STATUS_T_LOW_ALERT	BIT(6)
+#define HDC3020_STATUS_T_HIGH_ALERT	BIT(7)
+#define HDC3020_STATUS_RH_LOW_ALERT	BIT(8)
+#define HDC3020_STATUS_RH_HIGH_ALERT	BIT(9)
 
 #define HDC3020_READ_RETRY_TIMES	10
 #define HDC3020_BUSY_DELAY_MS		10
 
 #define HDC3020_CRC8_POLYNOMIAL		0x31
 
+#define HDC3020_MIN_TEMP		-40
+#define HDC3020_MAX_TEMP		125
+
 struct hdc3020_data {
 	struct i2c_client *client;
 	/*
@@ -50,18 +77,37 @@ struct hdc3020_data {
 
 static const int hdc3020_heater_vals[] = {0, 1, 0x3FFF};
 
+static const struct iio_event_spec hdc3020_t_rh_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+		BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+		BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
 static const struct iio_chan_spec hdc3020_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
 		BIT(IIO_CHAN_INFO_TROUGH) | BIT(IIO_CHAN_INFO_OFFSET),
+		.event_spec = hdc3020_t_rh_event,
+		.num_event_specs = ARRAY_SIZE(hdc3020_t_rh_event),
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
 		BIT(IIO_CHAN_INFO_TROUGH),
+		.event_spec = hdc3020_t_rh_event,
+		.num_event_specs = ARRAY_SIZE(hdc3020_t_rh_event),
 	},
 	{
 		/*
@@ -315,10 +361,192 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int hdc3020_write_thresh(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+	u8 buf[5];
+	u64 tmp;
+	u16 reg;
+	int ret;
+
+	/* Supported temperature range is from –40 to 125 degree celsius */
+	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
+		return -EINVAL;
+
+	/* Select threshold register */
+	if (info == IIO_EV_INFO_VALUE) {
+		if (dir == IIO_EV_DIR_RISING)
+			reg = HDC3020_S_T_RH_THRESH_HIGH;
+		else
+			reg = HDC3020_S_T_RH_THRESH_LOW;
+	} else {
+		if (dir == IIO_EV_DIR_RISING)
+			reg = HDC3020_S_T_RH_THRESH_HIGH_CLR;
+		else
+			reg = HDC3020_S_T_RH_THRESH_LOW_CLR;
+	}
+
+	guard(mutex)(&data->lock);
+	ret = hdc3020_read_be16(data, reg);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_TEMP:
+		/*
+		 * Calculate temperature threshold, shift it down to get the
+		 * truncated threshold representation in the 9LSBs while keeping
+		 * the current humidity threshold in the 7 MSBs.
+		 */
+		tmp = ((u64)(((val + 45) * MICRO) + val2)) * 65535ULL;
+		tmp = div_u64(tmp, MICRO * 175);
+		val = tmp >> HDC3020_THRESH_TEMP_TRUNC_SHIFT;
+		val = FIELD_PREP(HDC3020_THRESH_TEMP_MASK, val);
+		val |= (FIELD_GET(HDC3020_THRESH_HUM_MASK, ret) <<
+			HDC3020_THRESH_HUM_TRUNC_SHIFT);
+		break;
+	case IIO_HUMIDITYRELATIVE:
+		/*
+		 * Calculate humidity threshold, shift it down and up to get the
+		 * truncated threshold representation in the 7MSBs while keeping
+		 * the current temperature threshold in the 9 LSBs.
+		 */
+		tmp = ((u64)((val * MICRO) + val2)) * 65535ULL;
+		tmp = div_u64(tmp, MICRO * 100);
+		val = tmp >> HDC3020_THRESH_HUM_TRUNC_SHIFT;
+		val = FIELD_PREP(HDC3020_THRESH_HUM_MASK, val);
+		val |= FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	put_unaligned_be16(reg, buf);
+	put_unaligned_be16(val, buf + 2);
+	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
+	return hdc3020_write_bytes(data, buf, 5);
+}
+
+static int hdc3020_read_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+	u16 reg;
+	int ret;
+
+	/* Select threshold register */
+	if (info == IIO_EV_INFO_VALUE) {
+		if (dir == IIO_EV_DIR_RISING)
+			reg = HDC3020_R_T_RH_THRESH_HIGH;
+		else
+			reg = HDC3020_R_T_RH_THRESH_LOW;
+	} else {
+		if (dir == IIO_EV_DIR_RISING)
+			reg = HDC3020_R_T_RH_THRESH_HIGH_CLR;
+		else
+			reg = HDC3020_R_T_RH_THRESH_LOW_CLR;
+	}
+
+	guard(mutex)(&data->lock);
+	ret = hdc3020_read_be16(data, reg);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_TEMP:
+		/*
+		 * Get the temperature threshold from 9 LSBs, shift them to get
+		 * the truncated temperature threshold representation and
+		 * calculate the threshold according to the formula in the
+		 * datasheet.
+		 */
+		*val = FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
+		*val = *val << HDC3020_THRESH_TEMP_TRUNC_SHIFT;
+		*val = -2949075 + (175 * (*val));
+		*val2 = 65535;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_HUMIDITYRELATIVE:
+		/*
+		 * Get the humidity threshold from 7 MSBs, shift them to get the
+		 * truncated humidity threshold representation and calculate the
+		 * threshold according to the formula in the datasheet.
+		 */
+		*val = FIELD_GET(HDC3020_THRESH_HUM_MASK, ret);
+		*val = (*val << HDC3020_THRESH_HUM_TRUNC_SHIFT) * 100;
+		*val2 = 65535;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static irqreturn_t hdc3020_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct hdc3020_data *data;
+	s64 time;
+	int ret;
+
+	data = iio_priv(indio_dev);
+	ret = hdc3020_read_be16(data, HDC3020_R_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & (HDC3020_STATUS_T_HIGH_ALERT | HDC3020_STATUS_T_LOW_ALERT |
+		HDC3020_STATUS_RH_HIGH_ALERT | HDC3020_STATUS_RH_LOW_ALERT)))
+		return IRQ_NONE;
+
+	time = iio_get_time_ns(indio_dev);
+	if (ret & HDC3020_STATUS_T_HIGH_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+						  time);
+
+	if (ret & HDC3020_STATUS_T_LOW_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
+						  time);
+
+	if (ret & HDC3020_STATUS_RH_HIGH_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+						  time);
+
+	if (ret & HDC3020_STATUS_RH_LOW_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
+						  time);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info hdc3020_info = {
 	.read_raw = hdc3020_read_raw,
 	.write_raw = hdc3020_write_raw,
 	.read_avail = hdc3020_read_available,
+	.read_event_value = hdc3020_read_thresh,
+	.write_event_value = hdc3020_write_thresh,
 };
 
 static void hdc3020_stop(void *data)
@@ -350,6 +578,23 @@ static int hdc3020_probe(struct i2c_client *client)
 	indio_dev->info = &hdc3020_info;
 	indio_dev->channels = hdc3020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, hdc3020_interrupt_handler,
+						IRQF_ONESHOT, "hdc3020",
+						indio_dev);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Failed to request IRQ\n");
+
+		/*
+		 * The alert output is activated by default upon power up,
+		 * hardware reset, and soft reset. Clear the status register.
+		 */
+		ret = hdc3020_exec_cmd(data, HDC3020_S_STATUS);
+		if (ret)
+			return ret;
+	}
 
 	ret = hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
 	if (ret)
-- 
2.39.2


