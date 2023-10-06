Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1411E7BAFC0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjJFAvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJFAvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:11 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD362F0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:09 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1e106eb414cso1018178fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553469; x=1697158269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zU4yH9HYeHVvR3l/YZIf0vPVGS/kXPo7bpaiXc8eDI=;
        b=SVwMw1TachEY2DX8vRMtORVFpsxCEMmAJJjVUKOwRWT170Y5QNs5Pv2kCRnN21uz6X
         Jh+4nfrjcq3vhX5fa4qapMbyRKMyByIMrlwdiceG/ijMlGykMKIDofgqXKOSEj1dFBcz
         IOlSv3xqYAg/GHNogfpoWB1l2wBAQYObbPjEnR2Px1EzhE9JMi62wf0OwgoglutmMHdr
         dqxKaGgD4MzXv/b1LWYG+cKxwLn1O6D6GvwwT/TiWpOsqZekvnmgQgCxP9xyFwzLTZ2Z
         dL8Zcxaavv5jzhapX6kIFZJi8f8pl0qZLqA+n01nShLJu/JTjiq19rH/Lepw69+/5bKE
         5qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553469; x=1697158269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zU4yH9HYeHVvR3l/YZIf0vPVGS/kXPo7bpaiXc8eDI=;
        b=t7FXDLaULge7G/qQXc5UnG0Yc7IYhQGsPlORwrKzHOckbTTaYM3WDTiIyEodz8Vqd/
         PQJIBoBCE645XdBYQLOWio7OxI78rPcj9RvmUTs0dWOojAtmQKXxPtHHlAXtnmzu/Wb1
         Po2zUGSV8erc6ovOrSaBZXJbBqnF7up8cfMC0ft5CVzMXV54s3rgApWKyExLOL31LqqD
         lP3CsUJXnmv2kFFk+7+mree+hmSxMMNePGfkbaXLkXoifrxCq924T1C1jS6ROcACIMsb
         5rH1Q6arJ2qggn+NUYqxeFpvI2vSUWgDfLCDtph4LyPD1McK3noapPrQ3seZOarglAON
         /Reg==
X-Gm-Message-State: AOJu0YzaU4m57KvCChxLrN4KajOrlJtyOXghRklQeUZpTfFHwq0kH9AE
        ceRdWPDhAlhg7YuosQm5lTqHgg==
X-Google-Smtp-Source: AGHT+IH+beqE42NlK15G9DHxDqaAjqRpKJK1/kQq77/aFcqHGvzT97tKtoRH+Mm/r2NUft++fgTZ3w==
X-Received: by 2002:a05:6870:9593:b0:1dd:7f3a:b703 with SMTP id k19-20020a056870959300b001dd7f3ab703mr7868485oao.0.1696553469000;
        Thu, 05 Oct 2023 17:51:09 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:08 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/17] staging: iio: resolver: ad2s1210: add phase lock range support
Date:   Thu,  5 Oct 2023 19:50:22 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-5-ec00746840fc@baylibre.com>
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

The AD2S1210 chip has a phase lock range feature that allows selecting
the allowable phase difference between the excitation output and the
sine and cosine inputs. This can be set to either 44 degrees (default)
or 360 degrees.

This patch adds a new phase channel with a phase0_mag_rising event that
can be used to configure the phase lock range. Actually emitting the
event will be added in a subsequent patch.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Changed event direction from none to rising.
* Fixed missing static qualifier on attribute definition.

v3 changes:
* This is a new patch to replace "staging: iio: resolver: ad2s1210: add
 phase_lock_range attributes"


 drivers/staging/iio/resolver/ad2s1210.c | 125 ++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 66ef35fbb6fe..83f6ac890dbc 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -56,6 +56,13 @@
 #define AD2S1210_MIN_FCW	0x4
 #define AD2S1210_MAX_FCW	0x50
 
+/* 44 degrees ~= 0.767945 radians */
+#define PHASE_44_DEG_TO_RAD_INT 0
+#define PHASE_44_DEG_TO_RAD_MICRO 767945
+/* 360 degrees ~= 6.283185 radians */
+#define PHASE_360_DEG_TO_RAD_INT 6
+#define PHASE_360_DEG_TO_RAD_MICRO 283185
+
 enum ad2s1210_mode {
 	MOD_POS = 0b00,
 	MOD_VEL = 0b01,
@@ -379,6 +386,54 @@ static int ad2s1210_set_hysteresis(struct ad2s1210_state *st, int val)
 	return ret;
 }
 
+static int ad2s1210_get_phase_lock_range(struct ad2s1210_state *st,
+					 int *val, int *val2)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
+			       AD2S1210_PHASE_LOCK_RANGE_44);
+	mutex_unlock(&st->lock);
+
+	if (ret < 0)
+		return ret;
+
+	if (ret) {
+		/* 44 degrees as radians */
+		*val = PHASE_44_DEG_TO_RAD_INT;
+		*val2 = PHASE_44_DEG_TO_RAD_MICRO;
+	} else {
+		/* 360 degrees as radians */
+		*val = PHASE_360_DEG_TO_RAD_INT;
+		*val2 = PHASE_360_DEG_TO_RAD_MICRO;
+	}
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ad2s1210_set_phase_lock_range(struct ad2s1210_state *st,
+					 int val, int val2)
+{
+	int deg, ret;
+
+	/* convert radians to degrees - only two allowable values */
+	if (val == PHASE_44_DEG_TO_RAD_INT && val2 == PHASE_44_DEG_TO_RAD_MICRO)
+		deg = 44;
+	else if (val == PHASE_360_DEG_TO_RAD_INT &&
+		 val2 == PHASE_360_DEG_TO_RAD_MICRO)
+		deg = 360;
+	else
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				 AD2S1210_PHASE_LOCK_RANGE_44,
+				 deg == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
 static int ad2s1210_get_excitation_frequency(struct ad2s1210_state *st, int *val)
 {
 	unsigned int reg_val;
@@ -551,6 +606,16 @@ static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_LOT_LOW_THRD);
 
+static const struct iio_event_spec ad2s1210_phase_event_spec[] = {
+	{
+		/* Phase error fault. */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		/* Phase lock range. */
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 static const struct iio_chan_spec ad2s1210_channels[] = {
 	{
 		.type = IIO_ANGL,
@@ -567,6 +632,14 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		/* used to configure phase lock range and get phase lock error */
+		.type = IIO_PHASE,
+		.indexed = 1,
+		.channel = 0,
+		.scan_index = -1,
+		.event_spec = ad2s1210_phase_event_spec,
+		.num_event_specs = ARRAY_SIZE(ad2s1210_phase_event_spec),
 	}, {
 		/* excitation frequency output */
 		.type = IIO_ALTVOLTAGE,
@@ -595,6 +668,21 @@ static const struct attribute_group ad2s1210_attribute_group = {
 	.attrs = ad2s1210_attributes,
 };
 
+static IIO_CONST_ATTR(in_phase0_mag_rising_value_available,
+		      __stringify(PHASE_44_DEG_TO_RAD_INT) "."
+		      __stringify(PHASE_44_DEG_TO_RAD_MICRO) " "
+		      __stringify(PHASE_360_DEG_TO_RAD_INT) "."
+		      __stringify(PHASE_360_DEG_TO_RAD_MICRO));
+
+static struct attribute *ad2s1210_event_attributes[] = {
+	&iio_const_attr_in_phase0_mag_rising_value_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad2s1210_event_attribute_group = {
+	.attrs = ad2s1210_event_attributes,
+};
+
 static int ad2s1210_initial(struct ad2s1210_state *st)
 {
 	unsigned char data;
@@ -619,6 +707,40 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	return ret;
 }
 
+static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int *val, int *val2)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+
+	switch (chan->type) {
+	case IIO_PHASE:
+		return ad2s1210_get_phase_lock_range(st, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      enum iio_event_info info,
+				      int val, int val2)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+
+	switch (chan->type) {
+	case IIO_PHASE:
+		return ad2s1210_set_phase_lock_range(st, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 				       unsigned int reg, unsigned int writeval,
 				       unsigned int *readval)
@@ -639,10 +761,13 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad2s1210_info = {
+	.event_attrs = &ad2s1210_event_attribute_group,
 	.read_raw = ad2s1210_read_raw,
 	.read_avail = ad2s1210_read_avail,
 	.write_raw = ad2s1210_write_raw,
 	.attrs = &ad2s1210_attribute_group,
+	.read_event_value = ad2s1210_read_event_value,
+	.write_event_value = ad2s1210_write_event_value,
 	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
 

-- 
2.42.0

