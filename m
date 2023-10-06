Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003707BAFC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjJFAvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJFAvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:15 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F6E7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:11 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1e106eb414cso1018203fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553471; x=1697158271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM4Ayjhh+gt7c45GFZInkoNLtYsIIiLYRMc7hVnFLPQ=;
        b=hbHFAH9vKEfmaX5ge2PO096Y/9Dnx357xAxLwgdEhWOxGVuG+xLCCuViuod+VzqmE4
         7NhQNd+JD6WiS+cLbFCVBN2OdYr04bmb+loB0qtx0Z8TT7UhDS+CHFx6qHvnwdKAU/FM
         DuBkmypZjnc3qZj0E2RhikoBkkDVDKujHNSCrFAi4wmttkOw4IX2FMfVCnOt+iyz1Y7x
         +1S/bO6291kqkcxyeG+eP/zc3v6BFhmtRRP0psPXrAnCMahgao6jZKA/4SOCJqweSL36
         zIivKuA/Va8Z+7KfkSO3CcQzAYuphIrkDZmxVpsg/B7UjwXVx5f1Xtto+QtisUAPu5Y4
         oD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553471; x=1697158271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hM4Ayjhh+gt7c45GFZInkoNLtYsIIiLYRMc7hVnFLPQ=;
        b=v/jVZc/Ipm23LipyeP/D6hj+xD41bWkcHH2U+IlS6UADUv0d6Jcyp/PWd0XQOGgt5D
         +LZPlwMN0/8NNIFhBHXKd7eEvh7nPyXtCtG3yp2rfw04oyvU7guyGj9rKWggULVu9wgt
         Rl4B7ndUP1qGhcgP6V1ldzc12Ur5FfsIs2XMLFfcOMXHtNg04Qw647A6UCEE+69CH5TC
         zZFgOd1n+jyu12rNBJLzJLMhLkCtpvsyn9Lzu2/G7fvdauG4CHnJtsUnG3VqR9aFxcHB
         45EQv/tWtAjRO1ajeYTBLPwgEGkNBX6BAhygWwRrjHGydSrFC/xIUf9fXKhnhmwAgfsa
         hbkA==
X-Gm-Message-State: AOJu0YxgXYkVx4Nk7PvaUNXpXW2cj785ONNkuLaAS6crhMi5DN/i9mfL
        dElAd1oyGQysNBy4tXTGXy59yg==
X-Google-Smtp-Source: AGHT+IEOHZE0rFBG5N69cuvTa6028zZT19DN292HYj/Hkg3sx0yppG2XUjFRYYhkvx1v5Qvd4plTJQ==
X-Received: by 2002:a05:6870:1615:b0:1d5:da78:5c96 with SMTP id b21-20020a056870161500b001d5da785c96mr7173297oae.48.1696553471219;
        Thu, 05 Oct 2023 17:51:11 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.10
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
Subject: [PATCH v4 08/17] staging: iio: resolver: ad2s1210: convert LOS threshold to event attr
Date:   Thu,  5 Oct 2023 19:50:25 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-8-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD2S1210 has a programmable threshold for the loss of signal (LOS)
fault. This fault is triggered when either the sine or cosine input
falls below the threshold voltage.

This patch converts the custom device LOS threshold attribute to an
event falling edge threshold attribute on a new monitor signal channel.
The monitor signal is an internal signal that combines the amplitudes
of the sine and cosine inputs as well as the current angle and position
output. This signal is used to detect faults in the input signals.

The attribute now uses millivolts instead of the raw register value in
accordance with the IIO ABI.

Emitting the event will be implemented in a later patch.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Fixed missing static qualifier on attribute definition.

v3 changes: This is a new patch in v3

 drivers/staging/iio/resolver/ad2s1210.c | 76 +++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 12437f697f79..d52aed30ca66 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -66,6 +66,11 @@
 #define PHASE_360_DEG_TO_RAD_INT 6
 #define PHASE_360_DEG_TO_RAD_MICRO 283185
 
+/* Threshold voltage registers have 1 LSB == 38 mV */
+#define THRESHOLD_MILLIVOLT_PER_LSB 38
+/* max voltage for threshold registers is 0x7F * 38 mV */
+#define THRESHOLD_RANGE_STR "[0 38 4826]"
+
 enum ad2s1210_mode {
 	MOD_POS = 0b00,
 	MOD_VEL = 0b01,
@@ -451,6 +456,38 @@ static const int ad2s1210_lot_threshold_urad_per_lsb[] = {
 	1237, /* 16-bit: same as 14-bit */
 };
 
+static int ad2s1210_get_voltage_threshold(struct ad2s1210_state *st,
+					  unsigned int reg, int *val)
+{
+	unsigned int reg_val;
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_read(st->regmap, reg, &reg_val);
+	mutex_unlock(&st->lock);
+
+	if (ret < 0)
+		return ret;
+
+	*val = reg_val * THRESHOLD_MILLIVOLT_PER_LSB;
+	return IIO_VAL_INT;
+}
+
+static int ad2s1210_set_voltage_threshold(struct ad2s1210_state *st,
+					  unsigned int reg, int val)
+{
+	unsigned int reg_val;
+	int ret;
+
+	reg_val = val / THRESHOLD_MILLIVOLT_PER_LSB;
+
+	mutex_lock(&st->lock);
+	ret = regmap_write(st->regmap, reg, reg_val);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static int ad2s1210_get_lot_high_threshold(struct ad2s1210_state *st,
 					   int *val, int *val2)
 {
@@ -710,9 +747,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
-static IIO_DEVICE_ATTR(los_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_LOS_THRD);
 static IIO_DEVICE_ATTR(dos_ovr_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_DOS_OVR_THRD);
@@ -749,6 +783,16 @@ static const struct iio_event_spec ad2s1210_phase_event_spec[] = {
 	},
 };
 
+static const struct iio_event_spec ad2s1210_monitor_signal_event_spec[] = {
+	{
+		/* Sine/cosine below LOS threshold fault. */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		/* Loss of signal threshold. */
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 static const struct iio_chan_spec ad2s1210_channels[] = {
 	{
 		.type = IIO_ANGL,
@@ -807,12 +851,19 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_FREQUENCY),
+	}, {
+		/* monitor signal */
+		.type = IIO_ALTVOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.scan_index = -1,
+		.event_spec = ad2s1210_monitor_signal_event_spec,
+		.num_event_specs = ARRAY_SIZE(ad2s1210_monitor_signal_event_spec),
 	},
 };
 
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_fault.dev_attr.attr,
-	&iio_dev_attr_los_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
@@ -851,11 +902,14 @@ static IIO_CONST_ATTR(in_phase0_mag_rising_value_available,
 		      __stringify(PHASE_44_DEG_TO_RAD_MICRO) " "
 		      __stringify(PHASE_360_DEG_TO_RAD_INT) "."
 		      __stringify(PHASE_360_DEG_TO_RAD_MICRO));
+static IIO_CONST_ATTR(in_altvoltage0_thresh_falling_value_available,
+		      THRESHOLD_RANGE_STR);
 static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_value_available, 0);
 static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_hysteresis_available, 0);
 
 static struct attribute *ad2s1210_event_attributes[] = {
 	&iio_const_attr_in_phase0_mag_rising_value_available.dev_attr.attr,
+	&iio_const_attr_in_altvoltage0_thresh_falling_value_available.dev_attr.attr,
 	&iio_dev_attr_in_angl1_thresh_rising_value_available.dev_attr.attr,
 	&iio_dev_attr_in_angl1_thresh_rising_hysteresis_available.dev_attr.attr,
 	NULL,
@@ -908,6 +962,13 @@ static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_ALTVOLTAGE:
+		if (chan->output)
+			return -EINVAL;
+		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_FALLING)
+			return ad2s1210_get_voltage_threshold(st,
+						AD2S1210_REG_LOS_THRD, val);
+		return -EINVAL;
 	case IIO_PHASE:
 		return ad2s1210_get_phase_lock_range(st, val, val2);
 	default:
@@ -934,6 +995,13 @@ static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_ALTVOLTAGE:
+		if (chan->output)
+			return -EINVAL;
+		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_FALLING)
+			return ad2s1210_set_voltage_threshold(st,
+						AD2S1210_REG_LOS_THRD, val);
+		return -EINVAL;
 	case IIO_PHASE:
 		return ad2s1210_set_phase_lock_range(st, val, val2);
 	default:

-- 
2.42.0

