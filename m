Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EECD7BCF32
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 17:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbjJHPtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344920AbjJHPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 11:49:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298CF107
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 08:49:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-693375d2028so3379430b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1696780174; x=1697384974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJH/3WbLfQaUX8yaz/YL48evBmEBAhUvlci46p2mjQY=;
        b=Bssoegulfu7Dpo1eiX9Q432UgvJn9q59KJhxYePz3g6N4SCii1MPG9H0sRgfunE5gj
         ovOgP/9Y/bXC9eU/NSYUeijkGJGg2yH6sxbyLXImSPSzhJbZ/CJvKG8mOEunO8awkeKS
         JT+TKJYvyzILtkatoTsjJeISnfWVFXVWlHAiGQyIARkyBc/6+XgTNcbIuoE77LpttYRp
         q6dsipRZ92J5upMKMAEzeKD/b3y454PXcT4ER5z6s1fXgr5/WX+q3XRPTZSn5mJbtQfp
         c/2yn61BX8z4ywMARMPab+Z8x4JTtkPxs5y8kzv0eiayi7yFxnx5Xz5UmKjrWtupsSFK
         Xj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696780174; x=1697384974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJH/3WbLfQaUX8yaz/YL48evBmEBAhUvlci46p2mjQY=;
        b=JUp4JEYur0+oDmwiBR9OIjJzDgxgutgUEi7VDOSaWvnsz+ryYKbz3Sc8LkdwBQNk0t
         NrTgXVo++0NNSLC8afUYPtJIQe/AmFzyNDXJVFcRGXZ1Y4yEP7UR29CBoZ6PtlQMaTVU
         Og5hNVOX4Egf0AmfE5YpGtJv4a37Hrd2WtwYzARFEOGBvNJD8U6zN3J8suCeWrGSaPUx
         AZvZj8HiKHwKUM3IB2fm6wv42dZRPINMdvbVYeMxn/EsDRdTABVSMifOjSG38tJvYi9G
         620mEJLDSximUr2/56qfwFrvHxVW/JY1Oq9y7HJLZHzFDTGXsWyp1upuqiWYuX2YhW8q
         5/jQ==
X-Gm-Message-State: AOJu0YzoSZeSooICDrmxKmqakby1pHIKqv08yLNfWy0v32NQNggkssvk
        tFi2Lo8ZxfzB4uhRyUKX6DawsA==
X-Google-Smtp-Source: AGHT+IFZKn+CrB143wtSKibd7BBZkrXX9f0DcdWcz6FiqCspIFx88FAjpNCLSuaOe9Gq89IjqdECkw==
X-Received: by 2002:a05:6a00:1506:b0:693:3fa0:5ffb with SMTP id q6-20020a056a00150600b006933fa05ffbmr16433558pfu.21.1696780173901;
        Sun, 08 Oct 2023 08:49:33 -0700 (PDT)
Received: from localhost.localdomain (2403-580d-82f4-0-65d1-409f-dd8-4287.ip6.aussiebb.net. [2403:580d:82f4:0:65d1:409f:dd8:4287])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7905a000000b0068fc48fcaa8sm4723374pfo.155.2023.10.08.08.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 08:49:33 -0700 (PDT)
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: [PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
Date:   Mon,  9 Oct 2023 02:18:57 +1030
Message-Id: <20231008154857.24162-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver support for Avago (Broadcom) APDS9306
Ambient Light Sensor with als and clear channels.
This driver exposes raw values for both the channels and
processed(lux) values for the als channel.
Support for both with or without hardware interrupt
configurations are provided.

Datasheet at https://docs.broadcom.com/doc/AV02-4755EN

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 drivers/iio/light/Kconfig    |   12 +
 drivers/iio/light/Makefile   |    1 +
 drivers/iio/light/apds9306.c | 1381 ++++++++++++++++++++++++++++++++++
 3 files changed, 1394 insertions(+)
 create mode 100644 drivers/iio/light/apds9306.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 45edba797e4c..04e7d10f1470 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -73,6 +73,18 @@ config APDS9300
 	  To compile this driver as a module, choose M here: the
 	  module will be called apds9300.
 
+config APDS9306
+	tristate "Avago APDS9306 Ambient Light Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_GTS_HELPER
+	help
+	  If you say Y or M here, you get support for Avago APDS9306
+	  Ambient Light Sensor.
+
+	  If built as a dynamically linked module, it will be called
+	  apds9306.
+
 config APDS9960
 	tristate "Avago APDS9960 gesture/RGB/ALS/proximity sensor"
 	select REGMAP_I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0db4c4c36ec..ab94eac04db0 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ADUX1020)		+= adux1020.o
 obj-$(CONFIG_AL3010)		+= al3010.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
+obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
 obj-$(CONFIG_AS73211)		+= as73211.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
new file mode 100644
index 000000000000..02c8285b230b
--- /dev/null
+++ b/drivers/iio/light/apds9306.c
@@ -0,0 +1,1381 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * APDS-9306/APDS-9306-065 Ambient Light Sensor
+ * I2C Address: 0x52
+ * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
+ *
+ * Copyright (C) 2023 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
+
+#include <asm/unaligned.h>
+
+#define APDS9306_MAIN_CTRL		0x00
+#define APDS9306_ALS_MEAS_RATE		0x04
+#define APDS9306_ALS_GAIN		0x05
+#define APDS9306_PART_ID		0x06
+#define APDS9306_MAIN_STATUS		0x07
+#define APDS9306_CLEAR_DATA_0		0x0A
+#define APDS9306_CLEAR_DATA_1		0x0B
+#define APDS9306_CLEAR_DATA_2		0x0C
+#define APDS9306_ALS_DATA_0		0x0D
+#define APDS9306_ALS_DATA_1		0x0E
+#define APDS9306_ALS_DATA_2		0x0F
+#define APDS9306_INT_CFG		0x19
+#define APDS9306_INT_PERSISTENCE	0x1A
+#define APDS9306_ALS_THRES_UP_0		0x21
+#define APDS9306_ALS_THRES_UP_1		0x22
+#define APDS9306_ALS_THRES_UP_2		0x23
+#define APDS9306_ALS_THRES_LOW_0	0x24
+#define APDS9306_ALS_THRES_LOW_1	0x25
+#define APDS9306_ALS_THRES_LOW_2	0x26
+#define APDS9306_ALS_THRES_VAR		0x27
+
+#define APDS9306_ALS_INT_STAT_MASK	BIT(4)
+#define APDS9306_ALS_DATA_STAT_MASK	BIT(3)
+
+#define APDS9306_ALS_THRES_VAL_MAX	0xFFFFF
+#define APDS9306_ALS_THRES_VAR_VAL_MAX	7
+#define APDS9306_ALS_PERSIST_VAL_MAX	15
+#define APDS9306_ALS_READ_DATA_DELAY_US	20000
+
+enum apds9306_power_states {
+	STANDBY,
+	ACTIVE,
+};
+
+enum apds9306_int_channels {
+	CLEAR,
+	ALS,
+};
+
+/**
+ * struct part_id_nlux_per_count - Part no. & corresponding nano lux per count
+ * @part_id: Part ID of the device
+ * @nlux_per_count: Nano lux per ADC count
+ */
+struct part_id_nlux_per_count {
+	int part_id;
+	int nlux_per_count;
+};
+
+/*
+ * As per the datasheet, at HW Gain = 3x, Integration time 100mS (32x),
+ * typical 2000 ADC counts are observed for 49.8 uW per sq cm (340.134 lux)
+ * for apds9306 and 43 uW per sq cm (293.69 lux) for apds9306-065.
+ * Assuming lux per count is linear across all integration time ranges,
+ * saving in nano lux per count.
+ * Nano Lux per count = (340.134 * 1000000000)/ (32 * 3 * 2000) for apds9306
+ * Nano Lux per count = (293.69 * 1000000000)/ (32 * 3 * 2000) for apds9306-065
+ */
+static struct part_id_nlux_per_count apds9306_part_id_nlux_per_count[] = {
+	{.part_id = 0xB1, .nlux_per_count = 1787156},
+	{.part_id = 0xB3, .nlux_per_count = 1529635},
+};
+
+/**
+ * apds9306_repeat_rate_freq - Sampling Frequency in uHz
+ */
+static const int apds9306_repeat_rate_freq[][2] = {
+	{40, 0},
+	{20, 0},
+	{10, 0},
+	{5,  0},
+	{2,  0},
+	{1,  0},
+	{0, 500000},
+};
+
+/**
+ * apds9306_repeat_rate_period - Sampling period in uSec
+ */
+static const int apds9306_repeat_rate_period[] = {
+	25000, 50000, 100000, 200000, 500000, 1000000, 2000000
+};
+static_assert(ARRAY_SIZE(apds9306_repeat_rate_freq) ==
+	      ARRAY_SIZE(apds9306_repeat_rate_period));
+
+/**
+ * struct apds9306_data - apds9306 private data and registers definitions
+ *
+ * All regfield definitions are named exactly according to datasheet for easy
+ * search
+ *
+ * @dev:	Pointer to the device structure
+ * @gts:	IIO Gain Time Scale structure
+ * @mutex:	Lock for protecting register access, adc reads and power
+ * @regmap:	Regmap structure pointer
+ * @regfield_sw_reset:	Reg: MAIN_CTRL, Field: SW_Reset
+ * @regfield_en:	Reg: MAIN_CTRL, Field: ALS_EN
+ * @regfield_intg_time:	Reg: ALS_MEAS_RATE, Field: ALS Resolution/Bit Width
+ * @regfield_repeat_rate:	Reg: ALS_MEAS_RATE, Field: ALS Measurement Rate
+ * @regfield_scale:	Reg: ALS_GAIN, Field: ALS Gain Range
+ * @regfield_int_src:	Reg: INT_CFG, Field: ALS Interrupt Source
+ * @regfield_int_thresh_var_en:	Reg: INT_CFG, Field: ALS Var Interrupt Mode
+ * @regfield_int_en:	Reg: INT_CFG, Field: ALS Interrupt Enable
+ * @regfield_int_persist_val:	Reg: INT_PERSISTENCE, Field: ALS_PERSIST
+ * @regfield_int_thresh_var_val:	Reg: ALS_THRESH_VAR, Field: ALS_THRES_VAR
+ * @nlux_per_count:	nano lux per ADC count for a particular model
+ * @read_data_available:	Flag set by IRQ handler for ADC data available
+ * @intg_time_idx:	Array index for integration times
+ * @repeat_rate_idx:	Array index for sampling frequency
+ * @gain_idx:	Array index for gain
+ * @int_ch:	Currently selected Interrupt channel
+ */
+struct apds9306_data {
+	struct device *dev;
+	struct iio_gts gts;
+	/*
+	 * Guard register access, single data reads, power up and down sequence.
+	 */
+	struct mutex mutex;
+
+	struct regmap *regmap;
+	struct regmap_field *regfield_sw_reset;
+	struct regmap_field *regfield_en;
+	struct regmap_field *regfield_intg_time;
+	struct regmap_field *regfield_repeat_rate;
+	struct regmap_field *regfield_scale;
+	struct regmap_field *regfield_int_src;
+	struct regmap_field *regfield_int_thresh_var_en;
+	struct regmap_field *regfield_int_en;
+	struct regmap_field *regfield_int_persist_val;
+	struct regmap_field *regfield_int_thresh_var_val;
+
+	int nlux_per_count;
+	int read_data_available;
+	u8 intg_time_idx;
+	u8 repeat_rate_idx;
+	u8 gain_idx;
+	u8 int_ch;
+};
+
+/*
+ * Available scales with gain 1x - 18x, timings 3.125, 25, 50, 100, 200,
+ * 400 mS
+ * Time impacts to gain: 1x, 8x, 16x, 32x, 64x, 128x
+ *
+ * Max total gain = HW gain * Intg time gain (18 * 128) = 2304
+ *
+ * For least precision loss, multiplier of 4 is required with
+ * 1736111.1 nanos (0.001736111).
+ */
+#define APDS9306_SCALE_1X	4
+
+#define APDS9306_GSEL_1X	0x00
+#define APDS9306_GSEL_3X	0x01
+#define APDS9306_GSEL_6X	0x02
+#define APDS9306_GSEL_9X	0x03
+#define APDS9306_GSEL_18X	0x04
+
+static const struct iio_gain_sel_pair apds9306_gains[] = {
+	GAIN_SCALE_GAIN(1, APDS9306_GSEL_1X),
+	GAIN_SCALE_GAIN(3, APDS9306_GSEL_3X),
+	GAIN_SCALE_GAIN(6, APDS9306_GSEL_6X),
+	GAIN_SCALE_GAIN(9, APDS9306_GSEL_9X),
+	GAIN_SCALE_GAIN(18, APDS9306_GSEL_18X),
+};
+
+#define APDS9306_MEAS_MODE_400MS	0x00
+#define APDS9306_MEAS_MODE_200MS	0x01
+#define APDS9306_MEAS_MODE_100MS	0x02
+#define APDS9306_MEAS_MODE_50MS		0x03
+#define APDS9306_MEAS_MODE_25MS		0x04
+#define APDS9306_MEAS_MODE_3125US	0x05
+
+static const struct iio_itime_sel_mul apds9306_itimes[] = {
+	GAIN_SCALE_ITIME_US(400000, APDS9306_MEAS_MODE_400MS, 128),
+	GAIN_SCALE_ITIME_US(200000, APDS9306_MEAS_MODE_200MS, 64),
+	GAIN_SCALE_ITIME_US(100000, APDS9306_MEAS_MODE_100MS, 32),
+	GAIN_SCALE_ITIME_US(50000, APDS9306_MEAS_MODE_50MS, 16),
+	GAIN_SCALE_ITIME_US(25000, APDS9306_MEAS_MODE_25MS, 8),
+	GAIN_SCALE_ITIME_US(3125, APDS9306_MEAS_MODE_3125US, 1),
+};
+
+static struct iio_event_spec apds9306_event_spec_als[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	}, {
+		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static struct iio_event_spec apds9306_event_spec_clear[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+#define APDS9306_CHANNEL(_type) \
+	.type = _type, \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | \
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | \
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+
+static struct iio_chan_spec apds9306_channels_with_events[] = {
+	{
+		APDS9306_CHANNEL(IIO_LIGHT)
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_PROCESSED),
+		.event_spec = apds9306_event_spec_als,
+		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_als),
+	}, {
+		APDS9306_CHANNEL(IIO_INTENSITY)
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.modified = 1,
+		.event_spec = apds9306_event_spec_clear,
+		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_clear),
+	},
+};
+
+static struct iio_chan_spec apds9306_channels_without_events[] = {
+	{
+		APDS9306_CHANNEL(IIO_LIGHT)
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_PROCESSED),
+	}, {
+		APDS9306_CHANNEL(IIO_INTENSITY)
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.modified = 1,
+	},
+};
+
+/* INT_PERSISTENCE available */
+IIO_CONST_ATTR(thresh_either_period_available, "[0 15]");
+
+/* ALS_THRESH_VAR available */
+IIO_CONST_ATTR(thresh_adaptive_either_values_available, "[0 7]");
+
+static struct attribute *apds9306_event_attributes[] = {
+	&iio_const_attr_thresh_either_period_available.dev_attr.attr,
+	&iio_const_attr_thresh_adaptive_either_values_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group apds9306_event_attr_group = {
+	.attrs = apds9306_event_attributes,
+};
+
+static const struct regmap_range apds9306_readable_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_CTRL, APDS9306_ALS_THRES_VAR)
+};
+
+static const struct regmap_range apds9306_writable_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_CTRL, APDS9306_ALS_GAIN),
+	regmap_reg_range(APDS9306_INT_CFG, APDS9306_ALS_THRES_VAR)
+};
+
+static const struct regmap_range apds9306_volatile_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_STATUS, APDS9306_MAIN_STATUS),
+	regmap_reg_range(APDS9306_CLEAR_DATA_0, APDS9306_ALS_DATA_2)
+};
+
+static const struct regmap_range apds9306_precious_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_STATUS, APDS9306_MAIN_STATUS)
+};
+
+static const struct regmap_access_table apds9306_readable_table = {
+	.yes_ranges = apds9306_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_readable_ranges)
+};
+
+static const struct regmap_access_table apds9306_writable_table = {
+	.yes_ranges = apds9306_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_writable_ranges)
+};
+
+static const struct regmap_access_table apds9306_volatile_table = {
+	.yes_ranges = apds9306_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_volatile_ranges)
+};
+
+static const struct regmap_access_table apds9306_precious_table = {
+	.yes_ranges = apds9306_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_precious_ranges)
+};
+
+static const struct regmap_config apds9306_regmap = {
+	.name = "apds9306_regmap",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &apds9306_readable_table,
+	.wr_table = &apds9306_writable_table,
+	.volatile_table = &apds9306_volatile_table,
+	.precious_table = &apds9306_precious_table,
+	.max_register = APDS9306_ALS_THRES_VAR,
+	.cache_type = REGCACHE_RBTREE,
+	.disable_locking = true,
+};
+
+static const struct reg_field apds9306_regfield_sw_reset =
+	REG_FIELD(APDS9306_MAIN_CTRL, 4, 4);
+
+static const struct reg_field apds9306_regfield_en =
+	REG_FIELD(APDS9306_MAIN_CTRL, 1, 1);
+
+static const struct reg_field apds9306_regfield_intg_time =
+	REG_FIELD(APDS9306_ALS_MEAS_RATE, 4, 6);
+
+static const struct reg_field apds9306_regfield_repeat_rate =
+	REG_FIELD(APDS9306_ALS_MEAS_RATE, 0, 2);
+
+static const struct reg_field apds9306_regfield_scale =
+	REG_FIELD(APDS9306_ALS_GAIN, 0, 2);
+
+static const struct reg_field apds9306_regfield_int_src =
+	REG_FIELD(APDS9306_INT_CFG, 4, 5);
+
+static const struct reg_field apds9306_regfield_int_thresh_var_en =
+	REG_FIELD(APDS9306_INT_CFG, 3, 3);
+
+static const struct reg_field apds9306_regfield_int_en =
+	REG_FIELD(APDS9306_INT_CFG, 2, 2);
+
+static const struct reg_field apds9306_regfield_int_persist_val =
+	REG_FIELD(APDS9306_INT_PERSISTENCE, 4, 7);
+
+static const struct reg_field apds9306_regfield_int_thresh_var_val =
+	REG_FIELD(APDS9306_ALS_THRES_VAR, 0, 2);
+
+static int apds9306_regfield_init(struct apds9306_data *data)
+{
+	struct device *dev = data->dev;
+	struct regmap *regmap = data->regmap;
+
+	data->regfield_sw_reset = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_sw_reset);
+	if (IS_ERR(data->regfield_sw_reset))
+		return PTR_ERR(data->regfield_sw_reset);
+
+	data->regfield_en = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_en);
+	if (IS_ERR(data->regfield_en))
+		return PTR_ERR(data->regfield_en);
+
+	data->regfield_intg_time = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_intg_time);
+	if (IS_ERR(data->regfield_intg_time))
+		return PTR_ERR(data->regfield_intg_time);
+
+	data->regfield_repeat_rate = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_repeat_rate);
+	if (IS_ERR(data->regfield_repeat_rate))
+		return PTR_ERR(data->regfield_repeat_rate);
+
+	data->regfield_scale = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_scale);
+	if (IS_ERR(data->regfield_scale))
+		return PTR_ERR(data->regfield_scale);
+
+	data->regfield_int_src = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_src);
+	if (IS_ERR(data->regfield_int_src))
+		return PTR_ERR(data->regfield_int_src);
+
+	data->regfield_int_thresh_var_en = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_thresh_var_en);
+	if (IS_ERR(data->regfield_int_thresh_var_en))
+		return PTR_ERR(data->regfield_int_thresh_var_en);
+
+	data->regfield_int_en = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_en);
+	if (IS_ERR(data->regfield_int_en))
+		return PTR_ERR(data->regfield_int_en);
+
+	data->regfield_int_persist_val = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_persist_val);
+	if (IS_ERR(data->regfield_int_persist_val))
+		return PTR_ERR(data->regfield_int_en);
+
+	data->regfield_int_thresh_var_val = devm_regmap_field_alloc(dev, regmap,
+			apds9306_regfield_int_thresh_var_val);
+	if (IS_ERR(data->regfield_int_thresh_var_val))
+		return PTR_ERR(data->regfield_int_thresh_var_en);
+
+	return 0;
+}
+
+static int apds9306_power_state(struct apds9306_data *data,
+		enum apds9306_power_states state)
+{
+	int ret;
+
+	/* Reset not included as it causes ugly I2C bus error */
+	switch (state) {
+	case STANDBY:
+		return regmap_field_write(data->regfield_en, 0);
+	case ACTIVE:
+		ret = regmap_field_write(data->regfield_en, 1);
+		if (ret)
+			return ret;
+		/* 5ms wake up time */
+		usleep_range(5000, 10000);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9306_runtime_power(struct apds9306_data *data, int en)
+{
+	struct device *dev = data->dev;
+	int ret;
+
+	if (en) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "runtime resume failed: %d\n", ret);
+			return ret;
+		}
+		return 0;
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return 0;
+}
+
+static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
+{
+	struct device *dev = data->dev;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	int ret, delay, intg_time, status = 0;
+	u8 buff[3];
+
+	ret = apds9306_runtime_power(data, 1);
+	if (ret)
+		return ret;
+
+	intg_time = iio_gts_find_int_time_by_sel(&data->gts,
+						 data->intg_time_idx);
+	if (intg_time < 0)
+		delay = apds9306_repeat_rate_period[data->repeat_rate_idx];
+
+	/*
+	 * Whichever is greater - integration time period or
+	 * sampling period.
+	 */
+	delay = max(intg_time,
+		    apds9306_repeat_rate_period[data->repeat_rate_idx]);
+
+
+	/*
+	 * Clear stale data flag that might have been set by the interrupt
+	 * handler if it got data available flag set in the status reg.
+	 */
+	data->read_data_available = 0;
+
+	/*
+	 * If this function runs parallel with the interrupt handler, either
+	 * this reads and clears the status registers or the interrupt handler
+	 * does. The interrupt handler sets a flag for read data available
+	 * which we read here.
+	 */
+	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS,
+				status, (status & (APDS9306_ALS_DATA_STAT_MASK |
+				APDS9306_ALS_INT_STAT_MASK)) ||
+				data->read_data_available,
+				APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
+
+	if (ret)
+		return ret;
+
+	/* If we reach here before the interrupt handler we push an event */
+	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
+		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+			       data->int_ch,
+			       IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(indio_dev));
+	}
+
+	if ((status & APDS9306_ALS_DATA_STAT_MASK) ||
+		data->read_data_available) {
+		ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
+		if (ret) {
+			dev_err(dev, "read data failed\n");
+			return ret;
+		}
+		*val = get_unaligned_le24(&buff);
+	}
+
+	return apds9306_runtime_power(data, 0);
+}
+
+static int apds9306_read_lux(struct apds9306_data *data, int *val)
+{
+	int ret, raw_count, gain, itime, scale, scale2;
+	u64 lux, new_scale;
+
+	itime = iio_gts_find_int_time_by_sel(&data->gts, data->intg_time_idx);
+	if (itime < 0)
+		return itime;
+
+	gain = iio_gts_find_gain_by_sel(&data->gts, data->gain_idx);
+	if (gain < 0)
+		return gain;
+
+	ret = iio_gts_get_scale(&data->gts, gain, itime, &scale, &scale2);
+	if (ret)
+		return ret;
+
+	ret = apds9306_read_data(data, &raw_count, APDS9306_ALS_DATA_0);
+	if (ret)
+		return ret;
+
+	lux = (u64)raw_count * data->nlux_per_count;
+
+	if (scale) {
+		new_scale = ((u64)scale * NANO) + scale2;
+		/* NANO scale is greater than max int, so reduce it */
+		do_div(new_scale, 10);
+		scale2 = (int)new_scale;
+		lux *= 10;
+	}
+
+	lux *= APDS9306_SCALE_1X;
+	do_div(lux, scale2);
+	*val = lux;
+
+	return 0;
+}
+
+static int apds9306_intg_time_get(struct apds9306_data *data, int *val2)
+{
+	*val2 = iio_gts_find_int_time_by_sel(&data->gts, data->intg_time_idx);
+	if (*val2 < 0)
+		return *val2;
+
+	return 0;
+}
+
+static int apds9306_intg_time_set_hw(struct apds9306_data *data, int sel)
+{
+	int ret;
+
+	ret = regmap_field_write(data->regfield_intg_time, sel);
+	if (ret)
+		return ret;
+	data->intg_time_idx = sel;
+
+	return ret;
+}
+
+static int apds9306_gain_set_hw(struct apds9306_data *data, int sel)
+{
+	int ret;
+
+	ret = regmap_field_write(data->regfield_scale, sel);
+	if (ret)
+		return ret;
+	data->gain_idx = sel;
+
+	return ret;
+}
+
+static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
+{
+	struct device *dev = data->dev;
+	int ret, intg_old, gain_old, gain_new, gain_new_closest;
+	bool ok;
+
+	if (!iio_gts_valid_time(&data->gts, val2)) {
+		dev_err(dev, "Unsupported integration time %u\n", val2);
+		return ret;
+	}
+
+	intg_old = iio_gts_find_int_time_by_sel(&data->gts,
+						data->intg_time_idx);
+	if (ret < 0)
+		return ret;
+
+	if (intg_old == val2)
+		return 0;
+
+	gain_old = iio_gts_find_gain_by_sel(&data->gts, data->gain_idx);
+	if (gain_old < 0)
+		return gain_old;
+
+	ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old,
+				intg_old, val2, &gain_new);
+	if (gain_new < 0) {
+		dev_err(dev, "Unsupported gain with time\n");
+		return gain_new;
+	}
+
+	gain_new_closest = iio_find_closest_gain_low(&data->gts, gain_new, &ok);
+	if (gain_new_closest < 0) {
+		gain_new_closest = iio_gts_get_min_gain(&data->gts);
+		if (gain_new_closest < 0)
+			return gain_new_closest < 0;
+	}
+	if (!ok)
+		dev_dbg(dev, "Unable to find optimum gain, setting minimum");
+
+	ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
+	if (ret < 0)
+		return ret;
+
+	ret = apds9306_intg_time_set_hw(data, ret);
+	if (ret)
+		return ret;
+
+	ret = iio_gts_find_sel_by_gain(&data->gts, gain_new_closest);
+	if (ret < 0)
+		return ret;
+
+	return apds9306_gain_set_hw(data, ret);
+}
+
+static int apds9306_sampling_freq_get(struct apds9306_data *data, int *val,
+				int *val2)
+{
+	if (data->repeat_rate_idx > ARRAY_SIZE(apds9306_repeat_rate_freq))
+		return -EINVAL;
+
+	*val = apds9306_repeat_rate_freq[data->repeat_rate_idx][0];
+	*val2 = apds9306_repeat_rate_freq[data->repeat_rate_idx][1];
+
+	return 0;
+}
+
+static int apds9306_sampling_freq_set(struct apds9306_data *data, int val,
+				int val2)
+{
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(apds9306_repeat_rate_freq); i++)
+		if (apds9306_repeat_rate_freq[i][0] == val &&
+				apds9306_repeat_rate_freq[i][1] == val2) {
+			ret = regmap_field_write(data->regfield_repeat_rate, i);
+			if (ret)
+				return ret;
+			data->repeat_rate_idx = i;
+			break;
+		}
+
+	return ret;
+}
+
+static int apds9306_scale_get(struct apds9306_data *data, int *val, int *val2)
+{
+	int gain, intg;
+
+	gain = iio_gts_find_gain_by_sel(&data->gts, data->gain_idx);
+	if (gain < 0)
+		return gain;
+
+	intg = iio_gts_find_int_time_by_sel(&data->gts, data->intg_time_idx);
+	if (intg < 0)
+		return intg;
+
+	return iio_gts_get_scale(&data->gts, gain, intg, val, val2);
+}
+
+static int apds9306_scale_set(struct apds9306_data *data, int val, int val2)
+{
+	int i, ret, time_sel, gain_sel;
+
+	/* Rounding up the last digit by one, otherwise matching table fails! */
+	if (val2 % 10)
+		val2 += 1;
+
+	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
+				data->intg_time_idx, val, val2, &gain_sel);
+	if (ret) {
+		for (i = 0; i < data->gts.num_itime; i++) {
+			time_sel = data->gts.itime_table[i].sel;
+
+			if (time_sel == data->intg_time_idx)
+				continue;
+
+			ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
+						time_sel, val, val2, &gain_sel);
+			if (!ret)
+				break;
+		}
+		if (ret)
+			return -EINVAL;
+
+		ret = apds9306_intg_time_set_hw(data, time_sel);
+		if (ret)
+			return ret;
+	}
+
+	return apds9306_gain_set_hw(data, gain_sel);
+}
+
+static int apds9306_event_period_get(struct apds9306_data *data, int *val)
+{
+	int period, ret;
+
+	ret = regmap_field_read(data->regfield_int_persist_val, &period);
+	if (ret)
+		return ret;
+
+	if (period > APDS9306_ALS_PERSIST_VAL_MAX)
+		return -EINVAL;
+
+	*val = period;
+
+	return ret;
+}
+
+static int apds9306_event_period_set(struct apds9306_data *data, int val)
+{
+	if (val < 0 || val > APDS9306_ALS_PERSIST_VAL_MAX)
+		return -EINVAL;
+
+	return regmap_field_write(data->regfield_int_persist_val, val);
+}
+
+static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
+				     int *val)
+{
+	int var, ret;
+	u8 buff[3];
+
+	if (dir == IIO_EV_DIR_RISING)
+		var = APDS9306_ALS_THRES_UP_0;
+	else if (dir == IIO_EV_DIR_FALLING)
+		var = APDS9306_ALS_THRES_LOW_0;
+	else
+		return -EINVAL;
+
+	ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
+	if (ret)
+		return ret;
+	*val = get_unaligned_le24(&buff);
+	return 0;
+}
+
+static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
+				     int val)
+{
+	int var;
+	u8 buff[3];
+
+	if (dir == IIO_EV_DIR_RISING)
+		var = APDS9306_ALS_THRES_UP_0;
+	else if (dir == IIO_EV_DIR_FALLING)
+		var = APDS9306_ALS_THRES_LOW_0;
+	else
+		return -EINVAL;
+
+	if (val < 0 || val > APDS9306_ALS_THRES_VAL_MAX)
+		return -EINVAL;
+
+	put_unaligned_le24(val, buff);
+	return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
+}
+
+static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data,
+					      int *val)
+{
+	int thad, ret;
+
+	ret = regmap_field_read(data->regfield_int_thresh_var_val, &thad);
+	if (ret)
+		return ret;
+
+	if (thad > APDS9306_ALS_THRES_VAR_VAL_MAX)
+		return -EINVAL;
+
+	*val = thad;
+
+	return ret;
+}
+
+static int apds9306_event_thresh_adaptive_set(struct apds9306_data *data,
+		int val)
+{
+	if (val < 0 || val > APDS9306_ALS_THRES_VAR_VAL_MAX)
+		return -EINVAL;
+
+	return regmap_field_write(data->regfield_int_thresh_var_val, val);
+}
+
+static int apds9306_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret, reg;
+
+	mutex_lock(&data->mutex);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
+			reg = APDS9306_CLEAR_DATA_0;
+		else
+			reg = APDS9306_ALS_DATA_0;
+		ret = apds9306_read_data(data, val, reg);
+		if (ret)
+			break;
+		ret = IIO_VAL_INT;
+		*val2 = 0;
+		break;
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = apds9306_read_lux(data, val);
+		if (ret)
+			break;
+		*val2 = 0;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		ret = apds9306_intg_time_get(data, val2);
+		if (ret)
+			break;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = apds9306_sampling_freq_get(data, val, val2);
+		if (ret)
+			break;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = apds9306_scale_get(data, val, val2);
+		if (ret)
+			break;
+		ret = IIO_VAL_INT_PLUS_NANO;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+
+	return ret;
+};
+
+static int apds9306_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type,
+			       int *length, long mask)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return iio_gts_avail_times(&data->gts, vals, type, length);
+	case IIO_CHAN_INFO_SCALE:
+		return iio_gts_all_avail_scales(&data->gts, vals, type,
+						length);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(apds9306_repeat_rate_freq) * 2;
+		*vals = (const int *)apds9306_repeat_rate_freq;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9306_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9306_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (!val)
+			ret = apds9306_intg_time_set(data, val2);
+		else
+			ret = -EINVAL;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = apds9306_scale_set(data, val, val2);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = apds9306_sampling_freq_set(data, val, val2);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static irqreturn_t apds9306_irq_handler(int irq, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret, status;
+
+	/*
+	 * The interrupt line is released and the interrupt flag is
+	 * cleared as a result of reading the status register. All the
+	 * status flags are cleared as a result of this read.
+	 */
+	ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS, &status);
+	if (ret < 0) {
+		dev_err(data->dev, "status reg read failed\n");
+		return IRQ_HANDLED;
+	}
+
+	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
+		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+			       data->int_ch, IIO_EV_TYPE_THRESH,
+			       IIO_EV_DIR_EITHER), iio_get_time_ns(indio_dev));
+	}
+
+	/*
+	 * If a one-shot read through sysfs is underway at the same time
+	 * as this interrupt handler is executing and a read data available
+	 * flag was set, this flag is set to inform read_poll_timeout()
+	 * to exit.
+	 */
+	if ((status & APDS9306_ALS_DATA_STAT_MASK))
+		data->read_data_available = 1;
+
+	return IRQ_HANDLED;
+}
+
+static int apds9306_read_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
+			ret = apds9306_event_period_get(data, val);
+		else
+			ret = apds9306_event_thresh_get(data, dir, val);
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		ret = apds9306_event_thresh_adaptive_get(data, val);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+
+	if (ret)
+		return ret;
+
+	*val2 = 0;
+	return IIO_VAL_INT;
+}
+
+static int apds9306_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
+			ret = apds9306_event_period_set(data, val);
+		else
+			ret = apds9306_event_thresh_set(data, dir, val);
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		ret = apds9306_event_thresh_adaptive_set(data, val);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int apds9306_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	unsigned int val, val2;
+	int ret;
+
+	mutex_lock(&data->mutex);
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		ret = regmap_field_read(data->regfield_int_en, &val);
+		if (ret)
+			break;
+		ret = regmap_field_read(data->regfield_int_src, &val2);
+		if (ret)
+			break;
+		if (chan->type == IIO_LIGHT)
+			ret = val & val2;
+		else if (chan->type == IIO_INTENSITY)
+			ret = val & !val2;
+		else
+			ret = -EINVAL;
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		ret = regmap_field_read(data->regfield_int_thresh_var_en,
+					&val);
+		if (ret)
+			break;
+		ret = val;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int apds9306_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       int state)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	state = !!state;
+	mutex_lock(&data->mutex);
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		if (state) {
+			if (chan->type == IIO_LIGHT) {
+				ret = regmap_field_write(data->regfield_int_src, 1);
+				if (ret)
+					break;
+			} else if (chan->type == IIO_INTENSITY) {
+				ret = regmap_field_write(data->regfield_int_src, 0);
+				if (ret)
+					break;
+			} else {
+				ret = -EINVAL;
+				break;
+			}
+		}
+		ret = regmap_field_write(data->regfield_int_en, state);
+		if (ret)
+			break;
+		ret = apds9306_runtime_power(data, state);
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		ret = regmap_field_write(data->regfield_int_thresh_var_en,
+					 state);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+#define APDS9306_IIO_INFO \
+	.read_avail = apds9306_read_avail, \
+	.read_raw = apds9306_read_raw, \
+	.write_raw = apds9306_write_raw, \
+	.write_raw_get_fmt = apds9306_write_raw_get_fmt,
+
+static const struct iio_info apds9306_info_no_events = {
+	APDS9306_IIO_INFO
+};
+
+static const struct iio_info apds9306_info = {
+	APDS9306_IIO_INFO
+	.event_attrs = &apds9306_event_attr_group,
+	.read_event_value = apds9306_read_event,
+	.write_event_value = apds9306_write_event,
+	.read_event_config = apds9306_read_event_config,
+	.write_event_config = apds9306_write_event_config,
+};
+
+static int get_device_id_lux_per_count(struct apds9306_data *data)
+{
+	int ret, part_id;
+
+	ret = regmap_read(data->regmap, APDS9306_PART_ID, &part_id);
+	if (ret)
+		return ret;
+
+	if (part_id == apds9306_part_id_nlux_per_count[0].part_id)
+		data->nlux_per_count =
+			apds9306_part_id_nlux_per_count[0].nlux_per_count;
+	else if (part_id == apds9306_part_id_nlux_per_count[1].part_id)
+		data->nlux_per_count =
+			apds9306_part_id_nlux_per_count[1].nlux_per_count;
+	else
+		return -ENXIO;
+
+	return 0;
+}
+
+static void apds9306_powerdown(void *ptr)
+{
+	struct apds9306_data *data = (struct apds9306_data *)ptr;
+	struct device *dev = data->dev;
+	int ret;
+
+	/* Disable interrupts */
+	ret = regmap_field_write(data->regfield_int_thresh_var_en, 0);
+	if (ret)
+		dev_err(dev, "Failed to disable variance interrupts\n");
+	ret = regmap_field_write(data->regfield_int_en, 0);
+	if (ret)
+		dev_err(dev, "Failed to disable interrupts\n");
+	/* Put the device in standby mode */
+	ret = apds9306_power_state(data, STANDBY);
+	if (ret)
+		dev_err(dev, "Failed to power down device\n");
+}
+
+static int apds9306_init_device(struct apds9306_data *data)
+{
+	struct device *dev = data->dev;
+	int ret;
+
+	ret = apds9306_power_state(data, ACTIVE);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, 5000);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = regmap_reinit_cache(data->regmap, &apds9306_regmap);
+	if (ret)
+		return ret;
+
+	/* Get lux per count value according to the device ID */
+	ret = get_device_id_lux_per_count(data);
+	if (ret)
+		return ret;
+
+	/* Integration time: 100 msec */
+	ret = apds9306_intg_time_set_hw(data, 2);
+	if (ret)
+		return ret;
+
+	/* Sampling frequency: 100 msec, 10 Hz */
+	ret = apds9306_sampling_freq_set(data, 10, 0);
+	if (ret)
+		return ret;
+
+	/* Scale: x3 */
+	ret = apds9306_gain_set_hw(data, 1);
+	if (ret)
+		return ret;
+
+	/* Interrupt source channel: als */
+	ret = regmap_field_write(data->regfield_int_src, 1);
+	if (ret)
+		return ret;
+	data->int_ch = 1;
+
+	/* Interrupts disabled */
+	ret = regmap_field_write(data->regfield_int_en, 0);
+	if (ret)
+		return ret;
+
+	/* Threshold Variance disabled */
+	return regmap_field_write(data->regfield_int_thresh_var_en, 0);
+}
+
+static int apds9306_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct apds9306_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	mutex_init(&data->mutex);
+
+	data->regmap = devm_regmap_init_i2c(client, &apds9306_regmap);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "regmap initialization failed\n");
+
+	data->dev = dev;
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = apds9306_regfield_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "regfield initialization failed\n");
+
+	ret = devm_regulator_get_enable(dev, "vin");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	indio_dev->name = "apds9306";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (client->irq) {
+		indio_dev->info = &apds9306_info;
+		indio_dev->channels = apds9306_channels_with_events;
+		indio_dev->num_channels =
+				ARRAY_SIZE(apds9306_channels_with_events);
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					apds9306_irq_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"apds9306_event", indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					"failed to assign interrupt.\n");
+	} else {
+		indio_dev->info = &apds9306_info_no_events;
+		indio_dev->channels = apds9306_channels_without_events;
+		indio_dev->num_channels =
+				ARRAY_SIZE(apds9306_channels_without_events);
+	}
+
+	ret = devm_iio_init_iio_gts(dev, APDS9306_SCALE_1X, 0, apds9306_gains,
+				    ARRAY_SIZE(apds9306_gains), apds9306_itimes,
+				    ARRAY_SIZE(apds9306_itimes), &data->gts);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"failed to add action on driver unwind\n");
+
+	ret = apds9306_init_device(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init device\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int apds9306_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = apds9306_power_state(data, STANDBY);
+	if (ret)
+		regcache_cache_only(data->regmap, true);
+
+	return ret;
+}
+
+static int apds9306_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	regcache_cache_only(data->regmap, false);
+	ret = regcache_sync(data->regmap);
+	if (ret)
+		return ret;
+	ret = apds9306_power_state(data, ACTIVE);
+	if (ret)
+		regcache_cache_only(data->regmap, true);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(apds9306_pm_ops,
+				 apds9306_runtime_suspend,
+				 apds9306_runtime_resume,
+				 NULL);
+
+static const struct i2c_device_id apds9306_id[] = {
+	{ "apds9306" }, { }
+};
+MODULE_DEVICE_TABLE(i2c, apds9306_id);
+
+static const struct of_device_id apds9306_of_match[] = {
+	{ .compatible = "avago,apds9306" }, { }
+};
+MODULE_DEVICE_TABLE(of, apds9306_of_match);
+
+static struct i2c_driver apds9306_driver = {
+	.driver = {
+		.name = "apds9306",
+		.pm = pm_ptr(&apds9306_pm_ops),
+		.of_match_table = apds9306_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe_new = apds9306_probe,
+	.id_table = apds9306_id,
+};
+
+module_i2c_driver(apds9306_driver);
+
+MODULE_AUTHOR("Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>");
+MODULE_DESCRIPTION("APDS9306 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_GTS_HELPER);
-- 
2.34.1

