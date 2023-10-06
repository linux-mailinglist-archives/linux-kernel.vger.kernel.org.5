Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13EC7BAFC3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjJFAv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJFAvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:14 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33084DB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:11 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1e58a522e41so28166fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553470; x=1697158270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUOSgD5Wnesa4+fjnvBe7ifVAcJB2uD2jmt8gBsN0qI=;
        b=TRNXvHZ1NP5U2Nqwg/faDmxeNVrrqufGpMMcI0KncAEClpD4jEVmZByLQV+B7wA+8Y
         MIsiwOVwNjf6E47EjEsCJy7e6wKrc75abCP7O8p1ENWN2a/S7fdOhQ606q7O7SKu/MRc
         5S5MNyxE7rqPoaQ4KbSMjG9HrQSemTfqQ95xWwK5LvZPgZDy2QPLwImiFb6KiSHAd8nc
         3FRtecuVClv/LX1y0s6/2sY+bNkXDhmR09mx1zam/ShOqK6OHAH2A7jT7/h4YPRg2Fk7
         jdrz2MkUzDHwg6M6jMVt2a9iqWax4mi6Dc9mQZlkiY5UgXluUfy+kODJ6s0iKG7j+1M/
         n+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553470; x=1697158270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUOSgD5Wnesa4+fjnvBe7ifVAcJB2uD2jmt8gBsN0qI=;
        b=nzdhJM8yXbeZ31Dv9QF20HKuU5I925Cia1qVvWS47cr7vb9dx6+fV9WabdoocWOcyb
         GQZB6hD3jWP9e+gyzqO3FA6Q2LhlyuhLe2zj5tX/ysUhOP/FkuUjLT6TNKwS/QqGGaoN
         QpCPi6/UHdRnG3+u4SAn01yDgTcnRbo2lZ7Eo7H1ruVTk1wAkZkEF+KNS4BHKJR5VPEw
         gUXX9Z1VtiwxfQ6OyGUWRKK2dr1EeRzvPS0CjoYziw9popf5ta4+usxo/Ql1i6bzh6LG
         G6RqWB2EdtoqZr+Ykar5xkxXlFASPHLMNhZ0N7Dy5vAQGVmLx/bm2SO7mY6aieFeLZRA
         buSw==
X-Gm-Message-State: AOJu0YyvnjDaXxCAe2D06noDa0O3WaBZPXEV2SDlLsomeEkH13iIWrA3
        2E9NpExFbY4kHOz4u5mX89YtvA==
X-Google-Smtp-Source: AGHT+IEqQxVuz4szBM5r2U8kWRslQosr+UpgndYLxnyVdb0qha7UINJDHbS1oFerR97nEHVwcsbziw==
X-Received: by 2002:a05:6870:6111:b0:1d0:e0c9:f33d with SMTP id s17-20020a056870611100b001d0e0c9f33dmr7967874oae.46.1696553470486;
        Thu, 05 Oct 2023 17:51:10 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:10 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/17] staging: iio: resolver: ad2s1210: convert LOT threshold attrs to event attrs
Date:   Thu,  5 Oct 2023 19:50:24 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-7-ec00746840fc@baylibre.com>
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

The AD2S1210 monitors the internal error signal (difference between
estimated angle and measured angle) to determine a loss of position
tracking (LOT) condition. When the error value exceeds a threshold, a
fault is triggered. This threshold is user-configurable.

This patch converts the custom lot_high_thrd and lot_low_thrd attributes
in the ad2s1210 driver to standard event attributes. This will allow
tooling to be able to expose these in a generic way.

Since the low threshold determines the hysteresis, it requires some
special handling to expose the difference between the high and low
register values as the hysteresis instead of exposing the low register
value directly.

The attributes also return the values in radians now as required by the
ABI.

Actually emitting the fault event will be done in a later patch.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Fixed missing static qualifier on attribute definition.

v3 changes: This is a new patch in v3

 drivers/staging/iio/resolver/ad2s1210.c | 191 ++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 4d651a2d0f38..12437f697f79 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -443,6 +443,123 @@ static int ad2s1210_set_phase_lock_range(struct ad2s1210_state *st,
 	return ret;
 }
 
+/* map resolution to microradians/LSB for LOT registers */
+static const int ad2s1210_lot_threshold_urad_per_lsb[] = {
+	6184, /* 10-bit: ~0.35 deg/LSB, 45 deg max */
+	2473, /* 12-bit: ~0.14 deg/LSB, 18 deg max */
+	1237, /* 14-bit: ~0.07 deg/LSB, 9 deg max */
+	1237, /* 16-bit: same as 14-bit */
+};
+
+static int ad2s1210_get_lot_high_threshold(struct ad2s1210_state *st,
+					   int *val, int *val2)
+{
+	unsigned int reg_val;
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &reg_val);
+	mutex_unlock(&st->lock);
+
+	if (ret < 0)
+		return ret;
+
+	*val = 0;
+	*val2 = reg_val * ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ad2s1210_set_lot_high_threshold(struct ad2s1210_state *st,
+					   int val, int val2)
+{
+	unsigned int high_reg_val, low_reg_val, hysteresis;
+	int ret;
+
+	/* all valid values are between 0 and pi/4 radians */
+	if (val != 0)
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+	/*
+	 * We need to read both high and low registers first so we can preserve
+	 * the hysteresis.
+	 */
+	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &high_reg_val);
+	if (ret < 0)
+		goto error_ret;
+
+	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_LOW_THRD, &low_reg_val);
+	if (ret < 0)
+		goto error_ret;
+
+	hysteresis = high_reg_val - low_reg_val;
+	high_reg_val = val2 / ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
+	low_reg_val = high_reg_val - hysteresis;
+
+	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, high_reg_val);
+	if (ret < 0)
+		goto error_ret;
+
+	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD, low_reg_val);
+
+error_ret:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad2s1210_get_lot_low_threshold(struct ad2s1210_state *st,
+					  int *val, int *val2)
+{
+	unsigned int high_reg_val, low_reg_val;
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &high_reg_val);
+	if (ret < 0)
+		goto error_ret;
+
+	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_LOW_THRD, &low_reg_val);
+
+error_ret:
+	mutex_unlock(&st->lock);
+
+	if (ret < 0)
+		return ret;
+
+	/* sysfs value is hysteresis rather than actual low value */
+	*val = 0;
+	*val2 = (high_reg_val - low_reg_val) *
+		ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ad2s1210_set_lot_low_threshold(struct ad2s1210_state *st,
+					  int val, int val2)
+{
+	unsigned int reg_val, hysteresis;
+	int ret;
+
+	/* all valid values are between 0 and pi/4 radians */
+	if (val != 0)
+		return -EINVAL;
+
+	hysteresis = val2 / ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
+
+	mutex_lock(&st->lock);
+	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &reg_val);
+	if (ret < 0)
+		goto error_ret;
+
+	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD,
+			   reg_val - hysteresis);
+
+error_ret:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static int ad2s1210_get_excitation_frequency(struct ad2s1210_state *st, int *val)
 {
 	unsigned int reg_val;
@@ -608,12 +725,19 @@ static IIO_DEVICE_ATTR(dos_rst_max_thrd, 0644,
 static IIO_DEVICE_ATTR(dos_rst_min_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_DOS_RST_MIN_THRD);
-static IIO_DEVICE_ATTR(lot_high_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_LOT_HIGH_THRD);
-static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_LOT_LOW_THRD);
+
+static const struct iio_event_spec ad2s1210_position_event_spec[] = {
+	{
+		/* Tracking error exceeds LOT threshold fault. */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate =
+			/* Loss of tracking high threshold. */
+			BIT(IIO_EV_INFO_VALUE) |
+			/* Loss of tracking low threshold. */
+			BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
 
 static const struct iio_event_spec ad2s1210_phase_event_spec[] = {
 	{
@@ -657,6 +781,15 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 				      BIT(IIO_CHAN_INFO_SCALE),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(2),
+	{
+		/* used to configure LOT thresholds and get tracking error */
+		.type = IIO_ANGL,
+		.indexed = 1,
+		.channel = 1,
+		.scan_index = -1,
+		.event_spec = ad2s1210_position_event_spec,
+		.num_event_specs = ARRAY_SIZE(ad2s1210_position_event_spec),
+	},
 	{
 		/* used to configure phase lock range and get phase lock error */
 		.type = IIO_PHASE,
@@ -684,8 +817,6 @@ static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_rst_min_thrd.dev_attr.attr,
-	&iio_dev_attr_lot_high_thrd.dev_attr.attr,
-	&iio_dev_attr_lot_low_thrd.dev_attr.attr,
 	NULL,
 };
 
@@ -693,14 +824,40 @@ static const struct attribute_group ad2s1210_attribute_group = {
 	.attrs = ad2s1210_attributes,
 };
 
+static ssize_t
+in_angl1_thresh_rising_value_available_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	int step = ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
+
+	return sysfs_emit(buf, "[0 0.%06d 0.%06d]\n", step, step * 0x7F);
+}
+
+static ssize_t
+in_angl1_thresh_rising_hysteresis_available_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	int step = ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
+
+	return sysfs_emit(buf, "[0 0.%06d 0.%06d]\n", step, step * 0x7F);
+}
+
 static IIO_CONST_ATTR(in_phase0_mag_rising_value_available,
 		      __stringify(PHASE_44_DEG_TO_RAD_INT) "."
 		      __stringify(PHASE_44_DEG_TO_RAD_MICRO) " "
 		      __stringify(PHASE_360_DEG_TO_RAD_INT) "."
 		      __stringify(PHASE_360_DEG_TO_RAD_MICRO));
+static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_value_available, 0);
+static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_hysteresis_available, 0);
 
 static struct attribute *ad2s1210_event_attributes[] = {
 	&iio_const_attr_in_phase0_mag_rising_value_available.dev_attr.attr,
+	&iio_dev_attr_in_angl1_thresh_rising_value_available.dev_attr.attr,
+	&iio_dev_attr_in_angl1_thresh_rising_hysteresis_available.dev_attr.attr,
 	NULL,
 };
 
@@ -742,6 +899,15 @@ static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
 	struct ad2s1210_state *st = iio_priv(indio_dev);
 
 	switch (chan->type) {
+	case IIO_ANGL:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			return ad2s1210_get_lot_high_threshold(st, val, val2);
+		case IIO_EV_INFO_HYSTERESIS:
+			return ad2s1210_get_lot_low_threshold(st, val, val2);
+		default:
+			return -EINVAL;
+		}
 	case IIO_PHASE:
 		return ad2s1210_get_phase_lock_range(st, val, val2);
 	default:
@@ -759,6 +925,15 @@ static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
 	struct ad2s1210_state *st = iio_priv(indio_dev);
 
 	switch (chan->type) {
+	case IIO_ANGL:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			return ad2s1210_set_lot_high_threshold(st, val, val2);
+		case IIO_EV_INFO_HYSTERESIS:
+			return ad2s1210_set_lot_low_threshold(st, val, val2);
+		default:
+			return -EINVAL;
+		}
 	case IIO_PHASE:
 		return ad2s1210_set_phase_lock_range(st, val, val2);
 	default:

-- 
2.42.0

