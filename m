Return-Path: <linux-kernel+bounces-56084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8963F84C5C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BA81C2401E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CE1F955;
	Wed,  7 Feb 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr5oE67C"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE66200CB;
	Wed,  7 Feb 2024 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292095; cv=none; b=QL2tP2LddTsUfbG6KiywI4TFoftf9BrDnsXjRzqCEnBFb5wuUuK5MhGm9VcAduJs7fWEyuXK8HxtXrUESmW8LDCDO6NaJohilGd1V8GxsXoptl2V+ne4dl6hjDT0jfztZjJzjEeZWTPkHnnPLpMpwxfkPFq0x5jVXpB1rKniP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292095; c=relaxed/simple;
	bh=ri+WczZgfCk/Bs48orRzfM50sbALOzL2ilwgKSDkGas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDgamyk5NE3C37aTXhv0sTacDbMjj0lurBGyTqpsBTr1Gtn5TFuKiZDuUARaFZDSAwTYcWYzPiFjPtLv+gRRTh0jfzGBY59Rxrz2/85gHQhlnaPJ4eyDvYz0hSv69GAu8mIIbmaQl6NnaWeFNR+H9tKDXK9HeeWl3mCVn1Zw9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr5oE67C; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so366598a12.2;
        Tue, 06 Feb 2024 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707292092; x=1707896892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQZpW2zpNJKnTPRcz/HMnMfZDp7UUElxg76lRkYKBT4=;
        b=cr5oE67CS2egWNe37GhTZe9PUVmxs0qcmp+jy+Nal33u7RMMTtDYr6/jJu37prU1V2
         xFxDn9L+DdXSC+D91tIl3A1bdNAW718myhMpeNWni6ST3PDgiX6GTg+JdxL4rBuIBv2o
         A0Jx50JWOIEqxuYpKMxSR3/lVZtZtK/GP+5SNPWsiIrjNVdrHa0gWeYJapXV6neJePX3
         JGwVhQIHsLfGxqUKh1PVBEKPPWVVReGUrgTKTkiRIi7vmAxasrRIVDj45WQMm8tF9/TR
         qKZt8g88WAGV2mYkRql4Zt3E3dE3bT/H9o3u7AWXk+JTGp92dNgmVq1Wm0EkKgh84BBR
         vyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292092; x=1707896892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQZpW2zpNJKnTPRcz/HMnMfZDp7UUElxg76lRkYKBT4=;
        b=S21e6fislwxFmPOh95Hi6qYADK1+6/XXk9xfsr4QZsKMDvwZm9qMHZk4Jx/PocJCuM
         OUWOhaotI858JA/oILCqnGfPg+CZSfxk6XSxTQ0ABtSTD8as0qcl+FRg+i50vYIyhof2
         Zf29Dxx97Ul5r8rb5NwEy1KOr4l2m7ffqjWboPWa9xHG4DT21cJLALKMKNRMFoTRrSSP
         u0LtgHXyZDcy6sc7JIVQk2h0EgWDb1lDX004IY+Y5omRuaiYuwBMLqB0zWRa1vvxCYor
         KIFgOnB9E9gdoJJq85bmkae8+oFHj6jWCW5HzT2yaC/v4FumOsKr1xY2J4z+tcbqTm7O
         zxXA==
X-Forwarded-Encrypted: i=1; AJvYcCXpXT/O+Dq/WlfRZLttJnPiNZycNGvf5hy+IfNPkN5MyJZTAugMSnR8yzxPzpwmMnoe5D80SsZUVu/BrZZo3gzjQraq9LrM08BtkA0rl5SC/8SUBpTbP7S7hwtvH57SjeU6wL5zD60B
X-Gm-Message-State: AOJu0YwFhsJDEL75RVQQOc2+mmVWXaCD3B6H0I3XdJHh2BLfxESGcY59
	ZCemnFaFoMaTKIxKrQ6YNTfTBEiwwyBbG0+HLuKIfy3y2R5gs2Cq
X-Google-Smtp-Source: AGHT+IG50+/HPt2G1TPlBkrqH0kPS7NWxR6BDVIMcp6VMBNbq2Pka0aE6Ql/YPhYCKvcB1NpmKSw4g==
X-Received: by 2002:aa7:c6d4:0:b0:560:4e74:20a4 with SMTP id b20-20020aa7c6d4000000b005604e7420a4mr3713372eds.34.1707292091833;
        Tue, 06 Feb 2024 23:48:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVq7xhA2oZzc+SfiDBU1DVhamVE6ams8LTkwfXdrSE0pw61QrlYsKnJxGjmjT5kEMgpY7jTqlnO/Ab4DOX8lvGQh3FtX50DKJY86+rIbsUd+maZl85tAgqDZtOdeTCB9+00rOiSkSpDiI2bpXzQpn9BZd6Xy4/UfdCqsuLwhDG+oq9jh2z1fDQtc6p9yp8DvQxPkUZINEnrieeBhsAomyMYUtN3iljggVn+DikCRk/O0ESq5j2m05Iee/JoL7SySYQ6vbu58Ars2W9dmH8JkVw+
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id f3-20020a05640214c300b00560556fe9b7sm378558edx.78.2024.02.06.23.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 23:48:11 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] iio: humidity: hdc3020: drop u8 register pairs
Date: Wed,  7 Feb 2024 08:47:51 +0100
Message-Id: <20240207074758.4138724-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207074758.4138724-1-dima.fedrau@gmail.com>
References: <20240207074758.4138724-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to 16bit defines. Create helper functions that are aware of the
new register format and apply them wherever possible.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/humidity/hdc3020.c | 200 +++++++++++----------------------
 1 file changed, 63 insertions(+), 137 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ed70415512f6..4ae4dd3187db 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -21,26 +21,22 @@
 
 #include <linux/iio/iio.h>
 
-#define HDC3020_HEATER_CMD_MSB		0x30 /* shared by all heater commands */
-#define HDC3020_HEATER_ENABLE		0x6D
-#define HDC3020_HEATER_DISABLE		0x66
-#define HDC3020_HEATER_CONFIG		0x6E
+#define HDC3020_S_AUTO_10HZ_MOD0	0x2737
+#define HDC3020_HEATER_DISABLE		0x3066
+#define HDC3020_HEATER_ENABLE		0x306D
+#define HDC3020_HEATER_CONFIG		0x306E
+#define HDC3020_EXIT_AUTO		0x3093
+#define HDC3020_R_T_RH_AUTO		0xE000
+#define HDC3020_R_T_LOW_AUTO		0xE002
+#define HDC3020_R_T_HIGH_AUTO		0xE003
+#define HDC3020_R_RH_LOW_AUTO		0xE004
+#define HDC3020_R_RH_HIGH_AUTO		0xE005
 
 #define HDC3020_READ_RETRY_TIMES	10
 #define HDC3020_BUSY_DELAY_MS		10
 
 #define HDC3020_CRC8_POLYNOMIAL		0x31
 
-static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
-
-static const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
-
-static const u8 HDC3020_R_T_RH_AUTO[2] = { 0xE0, 0x00 };
-static const u8 HDC3020_R_T_LOW_AUTO[2] = { 0xE0, 0x02 };
-static const u8 HDC3020_R_T_HIGH_AUTO[2] = { 0xE0, 0x03 };
-static const u8 HDC3020_R_RH_LOW_AUTO[2] = { 0xE0, 0x04 };
-static const u8 HDC3020_R_RH_HIGH_AUTO[2] = { 0xE0, 0x05 };
-
 struct hdc3020_data {
 	struct i2c_client *client;
 	/*
@@ -82,7 +78,7 @@ static const struct iio_chan_spec hdc3020_channels[] = {
 
 DECLARE_CRC8_TABLE(hdc3020_crc8_table);
 
-static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf, u8 len)
+static int hdc3020_write_bytes(struct hdc3020_data *data, u8 *buf, u8 len)
 {
 	struct i2c_client *client = data->client;
 	struct i2c_msg msg;
@@ -90,7 +86,7 @@ static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf, u8 len)
 
 	msg.addr = client->addr;
 	msg.flags = 0;
-	msg.buf = (char *)buf;
+	msg.buf = buf;
 	msg.len = len;
 
 	/*
@@ -109,26 +105,28 @@ static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf, u8 len)
 	return -ETIMEDOUT;
 }
 
-static int hdc3020_read_bytes(struct hdc3020_data *data, const u8 *buf,
-			      void *val, int len)
+static
+int hdc3020_read_bytes(struct hdc3020_data *data, u16 reg, u8 *buf, int len)
 {
+	u8 reg_buf[2];
 	int ret, cnt;
 	struct i2c_client *client = data->client;
 	struct i2c_msg msg[2] = {
 		[0] = {
 			.addr = client->addr,
 			.flags = 0,
-			.buf = (char *)buf,
+			.buf = reg_buf,
 			.len = 2,
 		},
 		[1] = {
 			.addr = client->addr,
 			.flags = I2C_M_RD,
-			.buf = val,
+			.buf = buf,
 			.len = len,
 		},
 	};
 
+	put_unaligned_be16(reg, reg_buf);
 	/*
 	 * During the measurement process, HDC3020 will not return data.
 	 * So wait for a while and try again
@@ -145,48 +143,12 @@ static int hdc3020_read_bytes(struct hdc3020_data *data, const u8 *buf,
 	return -ETIMEDOUT;
 }
 
-static int hdc3020_read_measurement(struct hdc3020_data *data,
-				    enum iio_chan_type type, int *val)
-{
-	u8 crc, buf[6];
-	int ret;
-
-	ret = hdc3020_read_bytes(data, HDC3020_R_T_RH_AUTO, buf, 6);
-	if (ret < 0)
-		return ret;
-
-	/* CRC check of the temperature measurement */
-	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
-	if (crc != buf[2])
-		return -EINVAL;
-
-	/* CRC check of the relative humidity measurement */
-	crc = crc8(hdc3020_crc8_table, buf + 3, 2, CRC8_INIT_VALUE);
-	if (crc != buf[5])
-		return -EINVAL;
-
-	if (type == IIO_TEMP)
-		*val = get_unaligned_be16(buf);
-	else if (type == IIO_HUMIDITYRELATIVE)
-		*val = get_unaligned_be16(&buf[3]);
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-/*
- * After exiting the automatic measurement mode or resetting, the peak
- * value will be reset to the default value
- * This method is used to get the highest temp measured during automatic
- * measurement
- */
-static int hdc3020_read_high_peak_t(struct hdc3020_data *data, int *val)
+static int hdc3020_read_be16(struct hdc3020_data *data, u16 reg)
 {
 	u8 crc, buf[3];
 	int ret;
 
-	ret = hdc3020_read_bytes(data, HDC3020_R_T_HIGH_AUTO, buf, 3);
+	ret = hdc3020_read_bytes(data, reg, buf, 3);
 	if (ret < 0)
 		return ret;
 
@@ -194,73 +156,43 @@ static int hdc3020_read_high_peak_t(struct hdc3020_data *data, int *val)
 	if (crc != buf[2])
 		return -EINVAL;
 
-	*val = get_unaligned_be16(buf);
-
-	return 0;
+	return get_unaligned_be16(buf);
 }
 
-/*
- * This method is used to get the lowest temp measured during automatic
- * measurement
- */
-static int hdc3020_read_low_peak_t(struct hdc3020_data *data, int *val)
+static int hdc3020_exec_cmd(struct hdc3020_data *data, u16 reg)
 {
-	u8 crc, buf[3];
-	int ret;
-
-	ret = hdc3020_read_bytes(data, HDC3020_R_T_LOW_AUTO, buf, 3);
-	if (ret < 0)
-		return ret;
-
-	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
-	if (crc != buf[2])
-		return -EINVAL;
-
-	*val = get_unaligned_be16(buf);
+	u8 reg_buf[2];
 
-	return 0;
+	put_unaligned_be16(reg, reg_buf);
+	return hdc3020_write_bytes(data, reg_buf, 2);
 }
 
-/*
- * This method is used to get the highest humidity measured during automatic
- * measurement
- */
-static int hdc3020_read_high_peak_rh(struct hdc3020_data *data, int *val)
+static int hdc3020_read_measurement(struct hdc3020_data *data,
+				    enum iio_chan_type type, int *val)
 {
-	u8 crc, buf[3];
+	u8 crc, buf[6];
 	int ret;
 
-	ret = hdc3020_read_bytes(data, HDC3020_R_RH_HIGH_AUTO, buf, 3);
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_RH_AUTO, buf, 6);
 	if (ret < 0)
 		return ret;
 
+	/* CRC check of the temperature measurement */
 	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
 	if (crc != buf[2])
 		return -EINVAL;
 
-	*val = get_unaligned_be16(buf);
-
-	return 0;
-}
-
-/*
- * This method is used to get the lowest humidity measured during automatic
- * measurement
- */
-static int hdc3020_read_low_peak_rh(struct hdc3020_data *data, int *val)
-{
-	u8 crc, buf[3];
-	int ret;
-
-	ret = hdc3020_read_bytes(data, HDC3020_R_RH_LOW_AUTO, buf, 3);
-	if (ret < 0)
-		return ret;
-
-	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
-	if (crc != buf[2])
+	/* CRC check of the relative humidity measurement */
+	crc = crc8(hdc3020_crc8_table, buf + 3, 2, CRC8_INIT_VALUE);
+	if (crc != buf[5])
 		return -EINVAL;
 
-	*val = get_unaligned_be16(buf);
+	if (type == IIO_TEMP)
+		*val = get_unaligned_be16(buf);
+	else if (type == IIO_HUMIDITYRELATIVE)
+		*val = get_unaligned_be16(&buf[3]);
+	else
+		return -EINVAL;
 
 	return 0;
 }
@@ -286,28 +218,28 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 	}
 	case IIO_CHAN_INFO_PEAK: {
 		guard(mutex)(&data->lock);
-		if (chan->type == IIO_TEMP) {
-			ret = hdc3020_read_high_peak_t(data, val);
-			if (ret < 0)
-				return ret;
-		} else {
-			ret = hdc3020_read_high_peak_rh(data, val);
-			if (ret < 0)
-				return ret;
-		}
+		if (chan->type == IIO_TEMP)
+			ret = hdc3020_read_be16(data, HDC3020_R_T_HIGH_AUTO);
+		else
+			ret = hdc3020_read_be16(data, HDC3020_R_RH_HIGH_AUTO);
+
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
 		return IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_TROUGH: {
 		guard(mutex)(&data->lock);
-		if (chan->type == IIO_TEMP) {
-			ret = hdc3020_read_low_peak_t(data, val);
-			if (ret < 0)
-				return ret;
-		} else {
-			ret = hdc3020_read_low_peak_rh(data, val);
-			if (ret < 0)
-				return ret;
-		}
+		if (chan->type == IIO_TEMP)
+			ret = hdc3020_read_be16(data, HDC3020_R_T_LOW_AUTO);
+		else
+			ret = hdc3020_read_be16(data, HDC3020_R_RH_LOW_AUTO);
+
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
 		return IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_SCALE:
@@ -352,23 +284,17 @@ static int hdc3020_update_heater(struct hdc3020_data *data, int val)
 	if (val < hdc3020_heater_vals[0] || val > hdc3020_heater_vals[2])
 		return -EINVAL;
 
-	buf[0] = HDC3020_HEATER_CMD_MSB;
+	if (!val)
+		hdc3020_exec_cmd(data, HDC3020_HEATER_DISABLE);
 
-	if (!val) {
-		buf[1] = HDC3020_HEATER_DISABLE;
-		return hdc3020_write_bytes(data, buf, 2);
-	}
-
-	buf[1] = HDC3020_HEATER_CONFIG;
+	put_unaligned_be16(HDC3020_HEATER_CONFIG, buf);
 	put_unaligned_be16(val & GENMASK(13, 0), &buf[2]);
 	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
 	ret = hdc3020_write_bytes(data, buf, 5);
 	if (ret < 0)
 		return ret;
 
-	buf[1] = HDC3020_HEATER_ENABLE;
-
-	return hdc3020_write_bytes(data, buf, 2);
+	return hdc3020_exec_cmd(data, HDC3020_HEATER_ENABLE);
 }
 
 static int hdc3020_write_raw(struct iio_dev *indio_dev,
@@ -397,7 +323,7 @@ static const struct iio_info hdc3020_info = {
 
 static void hdc3020_stop(void *data)
 {
-	hdc3020_write_bytes((struct hdc3020_data *)data, HDC3020_EXIT_AUTO, 2);
+	hdc3020_exec_cmd((struct hdc3020_data *)data, HDC3020_EXIT_AUTO);
 }
 
 static int hdc3020_probe(struct i2c_client *client)
@@ -425,7 +351,7 @@ static int hdc3020_probe(struct i2c_client *client)
 	indio_dev->channels = hdc3020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
 
-	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
+	ret = hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
 	if (ret)
 		return dev_err_probe(&client->dev, ret,
 				     "Unable to set up measurement\n");
-- 
2.39.2


