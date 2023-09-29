Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5057B38E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjI2R0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjI2R0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:26:19 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E41707
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:06 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57bb0f5d00aso6062580eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008366; x=1696613166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQiK9e6k/k3elncVTDWla6vxSl60Qa2thMpCj5Ylb5I=;
        b=gFtxuSp4+GT2pttCpDxlsSBntQEusVEabOR9hAWgjFG2yRw26ghXnWShHXNpYcsT09
         /3qj3tWgw7g9BhppER7uAjZ8/IhqZXJVS3oFD0kB3xNT6ssuNAEDihpxxRuO2nnsF0hL
         YsD0ik0H5SPXPgAHf+5fQ6psQ9c1p3yrbE+GeWkimoo5uvibHY2NIW+CAsYhMKHlostY
         4d7p3Pe7F1stgBkBhI74wmeazfICpCS3o5GDFJFZE0MHJ2Nz7/0ykcz8Vi5O6YNKKJl2
         n1q6lnpca9v4Sep248epLbXJ381q11eJA84lKhZHUFl4n9BxamH0mXbyoDO3+Q/YcAR9
         qpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008366; x=1696613166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQiK9e6k/k3elncVTDWla6vxSl60Qa2thMpCj5Ylb5I=;
        b=f1RjckTIFfLGMplrA0xp4BswY7244aDCAaUmvEGj+T140t8F2rH9ZHVHs1UYfoTS0N
         R1wzouo/dMJ+7gJKp7BzCIUVcHiY5vkw9vZw3yKrLPg+FyS6dxLpC6hZCtXjSxeHZdzS
         EjSlOS8DxvsKgGpg3QgRUWnh/6phCWPqqbb9VAzIdB5+i58arpJNVojj3a9MvmQOtX5+
         KIAfRIthzfTno806f5VeQv1FLvU1L6qjQtBECTRAXG1ddmPhEJz+Uh976hllwOXV1/Fo
         S7aWDX7IjQgR8coUr5ZlB0jjkgLGWqyNC2Bm1Rif+K2XU6e0opYS9kCi20V83LcMB3NL
         4yAw==
X-Gm-Message-State: AOJu0YxH+y8yhTi5mrI1p1V062HE5wXwE3wH8yKVhMdb7kIbp826bM5U
        2/28Tr4gSoBm+skdIqX2bgIBbQ==
X-Google-Smtp-Source: AGHT+IGG4ceRC3OIgn9BN1LHHJTnCteZ/tsndmKUn6JWBARbkIrxiWcmhYbEyXqj6PC+2IhirkH+AQ==
X-Received: by 2002:a4a:6c02:0:b0:56e:466c:7393 with SMTP id q2-20020a4a6c02000000b0056e466c7393mr5369513ooc.5.1696008365954;
        Fri, 29 Sep 2023 10:26:05 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:26:05 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 21/27] staging: iio: resolver: ad2s1210: convert LOT threshold attrs to event attrs
Date:   Fri, 29 Sep 2023 12:23:26 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-21-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

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

v3 changes: This is a new patch in v3

 drivers/staging/iio/resolver/ad2s1210.c | 191 ++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index c0bc9eac18e8..5cc8106800d6 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -440,6 +440,123 @@ static int ad2s1210_set_phase_lock_range(struct ad2s1210_state *st,
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
@@ -604,12 +721,19 @@ static IIO_DEVICE_ATTR(dos_rst_max_thrd, 0644,
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
@@ -653,6 +777,15 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
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
@@ -680,8 +813,6 @@ static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_rst_min_thrd.dev_attr.attr,
-	&iio_dev_attr_lot_high_thrd.dev_attr.attr,
-	&iio_dev_attr_lot_low_thrd.dev_attr.attr,
 	NULL,
 };
 
@@ -689,14 +820,40 @@ static const struct attribute_group ad2s1210_attribute_group = {
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
 IIO_CONST_ATTR(in_phase0_mag_value_available,
 	       __stringify(PHASE_44_DEG_TO_RAD_INT) "."
 	       __stringify(PHASE_44_DEG_TO_RAD_MICRO) " "
 	       __stringify(PHASE_360_DEG_TO_RAD_INT) "."
 	       __stringify(PHASE_360_DEG_TO_RAD_MICRO));
+IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_value_available, 0);
+IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_hysteresis_available, 0);
 
 static struct attribute *ad2s1210_event_attributes[] = {
 	&iio_const_attr_in_phase0_mag_value_available.dev_attr.attr,
+	&iio_dev_attr_in_angl1_thresh_rising_value_available.dev_attr.attr,
+	&iio_dev_attr_in_angl1_thresh_rising_hysteresis_available.dev_attr.attr,
 	NULL,
 };
 
@@ -738,6 +895,15 @@ static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
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
@@ -755,6 +921,15 @@ static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
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

