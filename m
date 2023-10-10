Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31D7C4223
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJJVNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbjJJVM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:12:59 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C27AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:12:57 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c63117a659so3588390a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696972376; x=1697577176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCa1l139dV9fkfDRgcINbFP6JVo4HEiw2AUoI1RI/Aw=;
        b=FMmzjXCbK1JHMwhljHfc0egJrM9hDdW5wtT3oo2VyLPxaTia4E9WmYZSfNqLoBTfi0
         85o6FwTI/uJed/dar1X+WObji7unpPOH+7QEw9mwBGlrdQml15mLaswr2M+SfWGtcK3T
         MW0faTOLCJ0OthNuIoEGmkPwpnzmbGQvxI2OIYtu+QhNJ93bOB6mugEfW4eNmO7ubGvY
         XOF8EjWezSA8XarkyASW20TY0KU1oanA0ZDgp6fazULLZxVMsNL3ghBwyIOkTIUyi3M0
         irgDWZ/FuYCHc+hFF2bvJmSDoP+11me/L7awcH6bkrJNOMdFJfCWdzEm/bSUD7/dcZUt
         xpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972376; x=1697577176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCa1l139dV9fkfDRgcINbFP6JVo4HEiw2AUoI1RI/Aw=;
        b=CWrCKGonx+w4aJkVch2KLQ2UAc7MTHgvsop2mACHUNcGD+IQViBMEv9849DQohKvwx
         UmT9ZJufswwCePiSIvtJx2jujQwX+wlpVccc+6fs/TJnnY66sbJDvtrZOL3vfW4+o2yu
         YFvPhEm9ST24Uo8F4GKU1Thd19P8V+DHqM2rPr8vn7sMLFr4nl1UpfpuAerdR0UNM5SN
         wJEhNzkUtc97dI1McG6dAyyeKKo7bJ+DfPABNwBmiZViORrMsO9GVKjWtYKNowsxCZiY
         ShPcKHwDgfepceZ4IL1GT+1qCOUNW1LInBhcLl/MpRl+LaA+L3ZiKE8K+bySRM3K54oi
         T3Sw==
X-Gm-Message-State: AOJu0YyHMl3aj2Wb7QfPAhD6R0ABqfF9elsJEb1ogYdck4XEGnrEElyH
        lJQ36PWtRt4jknf/2wao/n4bxA==
X-Google-Smtp-Source: AGHT+IHa/1QpnSwzAFy2OFnEmS/d+HFZ/3vew4ebbhr6hbK5N4280IBIPblT2DCyyJGPXfMl92LUsg==
X-Received: by 2002:a05:6870:9693:b0:1b0:454b:1c3d with SMTP id o19-20020a056870969300b001b0454b1c3dmr20893867oaq.36.1696972376336;
        Tue, 10 Oct 2023 14:12:56 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ed46-20020a056870b7ae00b001e98b1544fesm52494oab.9.2023.10.10.14.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:12:56 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] staging: iio: resolver: ad2s1210: simplify code with guard(mutex)
Date:   Tue, 10 Oct 2023 16:12:35 -0500
Message-ID: <20231010-ad2s1210-mainline-v5-3-35a0f6ffa04a@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
References: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
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

We can simplify the code and get rid of most of the gotos by using
guard(mutex) from cleanup.h.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes: None (rebased).

Review comment from v4 is no longer applicable as it was addressed in
"staging: iio: resolver: ad2s1210: refactor sample toggle"

 drivers/staging/iio/resolver/ad2s1210.c | 153 ++++++++++----------------------
 1 file changed, 49 insertions(+), 104 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index cf4018434447..bd4a90c222b5 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -47,6 +47,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -447,7 +448,8 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 	s64 timestamp;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ad2s1210_toggle_sample_line(st);
 	timestamp = iio_get_time_ns(indio_dev);
 
@@ -459,14 +461,13 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 		ret = ad2s1210_set_mode(st, MOD_VEL);
 		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = spi_read(st->sdev, &st->sample, 3);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	switch (chan->type) {
 	case IIO_ANGL:
@@ -478,14 +479,11 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
 	ad2s1210_push_events(indio_dev, st->sample.fault, timestamp);
 
-error_ret:
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -493,11 +491,9 @@ static int ad2s1210_get_hysteresis(struct ad2s1210_state *st, int *val)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
 			       AD2S1210_ENABLE_HYSTERESIS);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -507,15 +503,10 @@ static int ad2s1210_get_hysteresis(struct ad2s1210_state *st, int *val)
 
 static int ad2s1210_set_hysteresis(struct ad2s1210_state *st, int val)
 {
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
-				 AD2S1210_ENABLE_HYSTERESIS,
-				 val ? AD2S1210_ENABLE_HYSTERESIS : 0);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				  AD2S1210_ENABLE_HYSTERESIS,
+				  val ? AD2S1210_ENABLE_HYSTERESIS : 0);
 }
 
 static int ad2s1210_get_phase_lock_range(struct ad2s1210_state *st,
@@ -523,11 +514,9 @@ static int ad2s1210_get_phase_lock_range(struct ad2s1210_state *st,
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
 			       AD2S1210_PHASE_LOCK_RANGE_44);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -547,7 +536,7 @@ static int ad2s1210_get_phase_lock_range(struct ad2s1210_state *st,
 static int ad2s1210_set_phase_lock_range(struct ad2s1210_state *st,
 					 int val, int val2)
 {
-	int deg, ret;
+	int deg;
 
 	/* convert radians to degrees - only two allowable values */
 	if (val == PHASE_44_DEG_TO_RAD_INT && val2 == PHASE_44_DEG_TO_RAD_MICRO)
@@ -558,12 +547,10 @@ static int ad2s1210_set_phase_lock_range(struct ad2s1210_state *st,
 	else
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
-	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
-				 AD2S1210_PHASE_LOCK_RANGE_44,
-				 deg == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
-	mutex_unlock(&st->lock);
-	return ret;
+	guard(mutex)(&st->lock);
+	return regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				  AD2S1210_PHASE_LOCK_RANGE_44,
+				  deg == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
 }
 
 /* map resolution to microradians/LSB for LOT registers */
@@ -580,10 +567,8 @@ static int ad2s1210_get_voltage_threshold(struct ad2s1210_state *st,
 	unsigned int reg_val;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_read(st->regmap, reg, &reg_val);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -595,15 +580,11 @@ static int ad2s1210_set_voltage_threshold(struct ad2s1210_state *st,
 					  unsigned int reg, int val)
 {
 	unsigned int reg_val;
-	int ret;
 
 	reg_val = val / THRESHOLD_MILLIVOLT_PER_LSB;
 
-	mutex_lock(&st->lock);
-	ret = regmap_write(st->regmap, reg, reg_val);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return regmap_write(st->regmap, reg, reg_val);
 }
 
 static int ad2s1210_get_lot_high_threshold(struct ad2s1210_state *st,
@@ -612,10 +593,8 @@ static int ad2s1210_get_lot_high_threshold(struct ad2s1210_state *st,
 	unsigned int reg_val;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &reg_val);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -634,18 +613,18 @@ static int ad2s1210_set_lot_high_threshold(struct ad2s1210_state *st,
 	if (val != 0)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	/*
 	 * We need to read both high and low registers first so we can preserve
 	 * the hysteresis.
 	 */
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &high_reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_LOW_THRD, &low_reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	hysteresis = high_reg_val - low_reg_val;
 	high_reg_val = val2 / ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
@@ -653,14 +632,9 @@ static int ad2s1210_set_lot_high_threshold(struct ad2s1210_state *st,
 
 	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, high_reg_val);
 	if (ret < 0)
-		goto error_ret;
-
-	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD, low_reg_val);
-
-error_ret:
-	mutex_unlock(&st->lock);
+		return ret;
 
-	return ret;
+	return regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD, low_reg_val);
 }
 
 static int ad2s1210_get_lot_low_threshold(struct ad2s1210_state *st,
@@ -669,16 +643,13 @@ static int ad2s1210_get_lot_low_threshold(struct ad2s1210_state *st,
 	unsigned int high_reg_val, low_reg_val;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &high_reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_LOW_THRD, &low_reg_val);
-
-error_ret:
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -701,18 +672,14 @@ static int ad2s1210_set_lot_low_threshold(struct ad2s1210_state *st,
 
 	hysteresis = val2 / ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
-	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD,
+	return regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD,
 			   reg_val - hysteresis);
-
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static int ad2s1210_get_excitation_frequency(struct ad2s1210_state *st, int *val)
@@ -720,31 +687,23 @@ static int ad2s1210_get_excitation_frequency(struct ad2s1210_state *st, int *val
 	unsigned int reg_val;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = regmap_read(st->regmap, AD2S1210_REG_EXCIT_FREQ, &reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	*val = reg_val * st->clkin_hz / (1 << 15);
-	ret = IIO_VAL_INT;
-
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
+	return IIO_VAL_INT;
 }
 
 static int ad2s1210_set_excitation_frequency(struct ad2s1210_state *st, int val)
 {
-	int ret;
-
 	if (val < AD2S1210_MIN_EXCIT || val > AD2S1210_MAX_EXCIT)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
-	ret = ad2s1210_reinit_excitation_frequency(st, val);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return ad2s1210_reinit_excitation_frequency(st, val);
 }
 
 static const int ad2s1210_velocity_scale[] = {
@@ -1020,10 +979,8 @@ static ssize_t event_attr_voltage_reg_show(struct device *dev,
 	unsigned int value;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_read(st->regmap, iattr->address, &value);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -1043,11 +1000,9 @@ static ssize_t event_attr_voltage_reg_store(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_write(st->regmap, iattr->address,
 			   data / THRESHOLD_MILLIVOLT_PER_LSB);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -1121,7 +1076,7 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	unsigned int data;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* Use default config register value plus resolution from devicetree. */
 	data = FIELD_PREP(AD2S1210_PHASE_LOCK_RANGE_44, 1);
@@ -1131,13 +1086,9 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 
 	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
 	if (ret < 0)
-		goto error_ret;
-
-	ret = ad2s1210_reinit_excitation_frequency(st, AD2S1210_DEF_EXCIT);
+		return ret;
 
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
+	return ad2s1210_reinit_excitation_frequency(st, AD2S1210_DEF_EXCIT);
 }
 
 static int ad2s1210_read_label(struct iio_dev *indio_dev,
@@ -1281,18 +1232,13 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 				       unsigned int *readval)
 {
 	struct ad2s1210_state *st = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	if (readval)
-		ret = regmap_read(st->regmap, reg, readval);
-	else
-		ret = regmap_write(st->regmap, reg, writeval);
-
-	mutex_unlock(&st->lock);
+		return regmap_read(st->regmap, reg, readval);
 
-	return ret;
+	return regmap_write(st->regmap, reg, writeval);
 }
 
 static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
@@ -1303,7 +1249,7 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 	size_t chan = 0;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	memset(&st->scan, 0, sizeof(st->scan));
 	ad2s1210_toggle_sample_line(st);
@@ -1336,7 +1282,6 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
 
 error_ret:
-	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

-- 
2.42.0

