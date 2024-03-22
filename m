Return-Path: <linux-kernel+bounces-112058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E328874B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126DE283BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F3E8173D;
	Fri, 22 Mar 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oomlzxRa"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714280629;
	Fri, 22 Mar 2024 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145172; cv=none; b=imltXplARLlJzS62QHMBV99pCy3XKHNDlbavqIsa1h1JrbdNoL2rQ4VjIQR1SZ0B2IReZ7mWObuGHkbuDs0a29SARbY2yqKFpuiXKJKxQTIFa1FEDgQGQoYWveiSDyiffqyisZdtqbkudMn8mmg+osShnH2yQr3k0jJFoDCPcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145172; c=relaxed/simple;
	bh=vPanP6/2jsrkvkH/FMk/DThorIM2n4NCYMQIkgYEQg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaydhY15nGMWplVZ6Wwpo96MjdsvK5w2hvzAYR+/A5rE02erYvoL10yQQPY0Lvodkg77TYX1l54fUX2YohR+1hU3iuglwidNm9cKfPo7hXLRuC492RbRcEjYEvqpClnA72sghmnBZcvOPoFzkDdbsZk6g0lt2BmT5ho58mx+wIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oomlzxRa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42MHMPOh014783;
	Fri, 22 Mar 2024 18:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=61cjb9Yfr0WmHvDS7LLQAyM8PNR+cDmXFYKVDi4E4KY=; b=oomlzxRag68F
	H4wK2dcocL8u0pJMQsuazVo4IorWH/RwqxtlQ9Z+w9Cg7T0rm1uT7JhSi3y6uXAj
	ZTULLohdQuOyEe3CbmsBfByvl/5m70dhhLwfoU3BE5RUqt0GgyyAmwhwL5QKzJqI
	5RE4pCew/jQL/L9mwGBhUoSHel5rDVL40hlipHuPwpeKEiuacuTFO2GwAQBJCO48
	sMSkLlMgFbrsVaava9AVliPKku2uF66ORBUpSdmm6NcWl5EVnTqTuFklE6d2Z8ji
	FXNu06OvfQWMNhIrQxaxNYdQfcb2IwDmjwuLq0qEF5iv63p1thHIBLGq08EAvbgV
	lTt40R6oRA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x0wxbcbby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 18:05:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 42MM5qwN023803
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Mar 2024 18:05:52 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 22 Mar
 2024 18:05:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 22 Mar 2024 18:05:51 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 42MM5Z3m028932;
	Fri, 22 Mar 2024 18:05:37 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iio: adc: Add support for AD4000
Date: Fri, 22 Mar 2024 19:05:34 -0300
Message-ID: <15a70e55d7b6f0a97c4042bdaa41c2b672eb4f2f.1711131830.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1711131830.git.marcelo.schmitt@analog.com>
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: XZCw8NJvM2MCwINC_biGf4wzadazGHrW
X-Proofpoint-ORIG-GUID: XZCw8NJvM2MCwINC_biGf4wzadazGHrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_14,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403220160

Add support for AD4000 series of high accuracy, high speed, low power,
successive aproximation register (SAR) ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Pasting relevant comment from cover letter here to aid reviewers.

Differently from AD7944, AD4000 devices have a configuration register to
toggle some features. For instance, turbo mode is set through configuration
register rather than an external pin. This simplifies hardware connections,
but then requires software interface. So, additional ABI being proposed 
in sysfs-bus-iio-adc-ad4000. The one I'm most in doubt about is 
span_compression_en which affects the in_voltageY_scale attribute.
That might be instead supported by providing _scale_available and allowing write
to _scale.

 .../ABI/testing/sysfs-bus-iio-adc-ad4000      |  36 +
 MAINTAINERS                                   |   2 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4000.c                      | 666 ++++++++++++++++++
 5 files changed, 717 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
 create mode 100644 drivers/iio/adc/ad4000.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
new file mode 100644
index 000000000000..98fb7539ad6d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
@@ -0,0 +1,36 @@
+What:		/sys/bus/iio/devices/iio:deviceX/turbo_en
+KernelVersion:	6.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to enable/disable turbo mode allowing
+		slower SPI clock rates (at a minimum SCK rate of 75 MHz) to
+		achieve the maximum throughput of 2 MSPS.
+
+What:		/sys/bus/iio/devices/iio:deviceX/span_compression_en
+KernelVersion:	6.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to enable/disable the input span
+		compression feature that reduces the ADC input range by 10% from
+		the top and bottom of the range while still accessing all
+		available ADC codes. Enabling span compression causes a
+		decrease in ADC scale which is reflected in the channel
+		in_voltageY_scale attribute.
+
+What:		/sys/bus/iio/devices/iio:deviceX/status_bits_en
+KernelVersion:	6.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to make the chip append a 6-bit status
+		word at the end of conversion results. The 6 status bits contain
+		the configuration register fields for OV clamp flag, span
+		compression, high-z mode, and turbo mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/high_impedance_en
+KernelVersion:	6.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to enable/disable high impedance mode
+		(high-z) which reduces nonlinear charge kickback to the ADC
+		input.
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 3ca90f842298..2ae98c700ff0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1140,7 +1140,9 @@ M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+F:	drivers/iio/adc/ad4000.c
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0d9282fa67f5..15db35f00ef0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -21,6 +21,18 @@ config AD_SIGMA_DELTA
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 
+config AD4000
+	tristate "Analog Devices AD4000 ADC Driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices AD4000 high speed
+	  SPI analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4000.
+
 config AD4130
 	tristate "Analog Device AD4130 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index b3c434722364..f535d617ae89 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
+obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o
diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
new file mode 100644
index 000000000000..f77104755979
--- /dev/null
+++ b/drivers/iio/adc/ad4000.c
@@ -0,0 +1,666 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD4000 SPI ADC driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+#include <asm/unaligned.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/units.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define AD400X_READ_COMMAND	0x54
+#define AD400X_WRITE_COMMAND	0x14
+
+#define AD4000_CONFIG_REG_MSK	0xFF
+
+/* AD4000 Configuration Register programmable bits */
+#define AD4000_STATUS		BIT(4) /* Status bits output */
+#define AD4000_SPAN_COMP	BIT(3) /* Input span compression  */
+#define AD4000_HIGHZ		BIT(2) /* High impedance mode  */
+#define AD4000_TURBO		BIT(1) /* Turbo mode */
+
+#define AD4000_16BIT_MSK	GENMASK(31, 16)
+#define AD4000_18BIT_MSK	GENMASK(31, 14)
+#define AD4000_20BIT_MSK	GENMASK(31, 12)
+
+#define AD4000_CHANNEL(_sign, _real_bits)				\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				      BIT(IIO_CHAN_INFO_SCALE),		\
+		.scan_type = {						\
+			.sign = _sign,					\
+			.realbits = _real_bits,				\
+			.storagebits = 32,				\
+			.endianness = IIO_BE,				\
+		},							\
+	}								\
+
+enum ad4000_ids {
+	ID_AD4000,
+	ID_AD4001,
+	ID_AD4002,
+	ID_AD4003,
+	ID_AD4004,
+	ID_AD4005,
+	ID_AD4006,
+	ID_AD4007,
+	ID_AD4008,
+	ID_AD4010,
+	ID_AD4011,
+	ID_AD4020,
+	ID_AD4021,
+	ID_AD4022,
+	ID_ADAQ4001,
+	ID_ADAQ4003,
+};
+
+struct ad4000_chip_info {
+	const char *dev_name;
+	struct iio_chan_spec chan_spec;
+};
+
+static const struct ad4000_chip_info ad4000_chips[] = {
+	[ID_AD4000] = {
+		.dev_name = "ad4000",
+		.chan_spec = AD4000_CHANNEL('u', 16),
+	},
+	[ID_AD4001] = {
+		.dev_name = "ad4001",
+		.chan_spec = AD4000_CHANNEL('s', 16),
+	},
+	[ID_AD4002] = {
+		.dev_name = "ad4002",
+		.chan_spec = AD4000_CHANNEL('u', 18),
+	},
+	[ID_AD4003] = {
+		.dev_name = "ad4003",
+		.chan_spec = AD4000_CHANNEL('s', 18),
+	},
+	[ID_AD4004] = {
+		.dev_name = "ad4004",
+		.chan_spec = AD4000_CHANNEL('u', 16),
+	},
+	[ID_AD4005] = {
+		.dev_name = "ad4005",
+		.chan_spec = AD4000_CHANNEL('s', 16),
+	},
+	[ID_AD4006] = {
+		.dev_name = "ad4006",
+		.chan_spec = AD4000_CHANNEL('u', 18),
+	},
+	[ID_AD4007] = {
+		.dev_name = "ad4007",
+		.chan_spec = AD4000_CHANNEL('s', 18),
+	},
+	[ID_AD4008] = {
+		.dev_name = "ad4008",
+		.chan_spec = AD4000_CHANNEL('u', 16),
+	},
+	[ID_AD4010] = {
+		.dev_name = "ad4010",
+		.chan_spec = AD4000_CHANNEL('u', 18),
+	},
+	[ID_AD4011] = {
+		.dev_name = "ad4011",
+		.chan_spec = AD4000_CHANNEL('s', 18),
+	},
+	[ID_AD4020] = {
+		.dev_name = "ad4020",
+		.chan_spec = AD4000_CHANNEL('s', 20),
+	},
+	[ID_AD4021] = {
+		.dev_name = "ad4021",
+		.chan_spec = AD4000_CHANNEL('s', 20),
+	},
+	[ID_AD4022] = {
+		.dev_name = "ad4022",
+		.chan_spec = AD4000_CHANNEL('s', 20),
+	},
+	[ID_ADAQ4001] = {
+		.dev_name = "adaq4001",
+		.chan_spec = AD4000_CHANNEL('s', 16),
+	},
+	[ID_ADAQ4003] = {
+		.dev_name = "adaq4003",
+		.chan_spec = AD4000_CHANNEL('s', 18),
+	},
+};
+
+enum ad4000_gains {
+	AD4000_0454_GAIN = 0,
+	AD4000_0909_GAIN = 1,
+	AD4000_1_GAIN = 2,
+	AD4000_1900_GAIN = 3,
+	AD4000_GAIN_LEN
+};
+
+/*
+ * Gains stored and computed as fractions to avoid introducing rounding erros.
+ */
+static const int ad4000_gains_frac[AD4000_GAIN_LEN][2] = {
+	[AD4000_0454_GAIN] = { 227, 500 },
+	[AD4000_0909_GAIN] = { 909, 1000 },
+	[AD4000_1_GAIN] = { 1, 1 },
+	[AD4000_1900_GAIN] = { 19, 10 },
+};
+
+struct ad4000_state {
+	struct spi_device *spi;
+	struct gpio_desc *cnv_gpio;
+	int vref;
+	bool status_bits;
+	bool span_comp;
+	bool turbo_mode;
+	bool high_z_mode;
+
+	enum ad4000_gains pin_gain;
+	int scale_tbl[AD4000_GAIN_LEN][2];
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	union {
+		struct {
+			u8 sample_buf[4];
+			s64 timestamp;
+		} scan;
+		u8 d8[2];
+	} data __aligned(IIO_DMA_MINALIGN);
+};
+
+static void ad4000_fill_scale_tbl(struct ad4000_state *st, int scale_bits)
+{
+	int val, val2, tmp0, tmp1, i;
+	u64 tmp2;
+
+	val2 = scale_bits;
+	for (i = 0; i < AD4000_GAIN_LEN; i++) {
+		val = st->vref / 1000;
+		/* Multiply by MILLI here to avoid losing precision */
+		val = mult_frac(val, ad4000_gains_frac[i][1] * MILLI,
+				ad4000_gains_frac[i][0]);
+		/* Would multiply by NANO here but we already multiplied by MILLI */
+		tmp2 = shift_right((u64)val * MICRO, val2);
+		tmp0 = (int)div_s64_rem(tmp2, NANO, &tmp1);
+		st->scale_tbl[i][0] = tmp0; /* Integer part */
+		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
+	}
+}
+
+static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
+{
+	struct spi_transfer t = {
+		.tx_buf	= st->data.d8,
+		.len = 2,
+	};
+	struct spi_message m;
+
+	put_unaligned_be16(AD400X_WRITE_COMMAND << BITS_PER_BYTE | val, st->data.d8);
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	return spi_sync(st->spi, &m);
+}
+
+static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
+{
+	struct spi_transfer t = {0};
+	struct spi_message m;
+	int ret;
+
+	st->data.d8[0] = AD400X_READ_COMMAND;
+
+	t.rx_buf = st->data.d8;
+	t.tx_buf = st->data.d8;
+	t.len = 2;
+
+	spi_message_init_with_transfers(&m, &t, 1);
+
+	ret = spi_sync(st->spi, &m);
+	if (ret < 0)
+		return ret;
+
+	*val = FIELD_GET(AD4000_CONFIG_REG_MSK, get_unaligned_be16(st->data.d8));
+
+	return ret;
+}
+
+static int ad4000_read_sample(struct ad4000_state *st, uint32_t *val)
+{
+	struct spi_transfer t = {0};
+	struct spi_message m;
+	int ret;
+
+	t.rx_buf = &st->data.scan.sample_buf;
+	t.len = 4;
+	t.delay.value = 60;
+	t.delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	spi_message_init_with_transfers(&m, &t, 1);
+
+	if (st->cnv_gpio)
+		gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_HIGH);
+
+	ret = spi_sync(st->spi, &m);
+	if (ret < 0)
+		return ret;
+
+	if (st->cnv_gpio)
+		gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_LOW);
+
+	*val = get_unaligned_be32(&st->data.scan.sample_buf);
+
+	return 0;
+}
+
+static int ad4000_single_conversion(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan, int *val)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+	u32 sample;
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad4000_read_sample(st, &sample);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	if (ret)
+		return ret;
+
+	switch (chan->scan_type.realbits) {
+	case 16:
+		sample = FIELD_GET(AD4000_16BIT_MSK, sample);
+		break;
+	case 18:
+		sample = FIELD_GET(AD4000_18BIT_MSK, sample);
+		break;
+	case 20:
+		sample = FIELD_GET(AD4000_20BIT_MSK, sample);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int ad4000_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long info)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		return ad4000_single_conversion(indio_dev, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->scale_tbl[st->pin_gain][0];
+		*val2 = st->scale_tbl[st->pin_gain][1];
+		if (st->span_comp)
+			*val2 = DIV_ROUND_CLOSEST(*val2 * 4, 5);
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t ad4000_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4000_state *st = iio_priv(indio_dev);
+
+	switch ((u32)this_attr->address) {
+	case AD4000_STATUS:
+		return sysfs_emit(buf, "%d\n", st->status_bits);
+	case AD4000_SPAN_COMP:
+		return sysfs_emit(buf, "%d\n", st->span_comp);
+	case AD4000_HIGHZ:
+		return sysfs_emit(buf, "%d\n", st->high_z_mode);
+	case AD4000_TURBO:
+		return sysfs_emit(buf, "%d\n", st->turbo_mode);
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ad4000_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4000_state *st = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned int reg_val;
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad4000_read_reg(st, &reg_val);
+	if (ret < 0)
+		goto err_release;
+
+	switch ((u32)this_attr->address) {
+	case AD4000_STATUS:
+		reg_val &= ~AD4000_STATUS;
+		reg_val |= FIELD_PREP(AD4000_STATUS, val);
+		ret = ad4000_write_reg(st, reg_val);
+		if (ret < 0)
+			goto err_release;
+
+		st->status_bits = val;
+		break;
+	case AD4000_SPAN_COMP:
+		reg_val &= ~AD4000_SPAN_COMP;
+		reg_val |= FIELD_PREP(AD4000_SPAN_COMP, val);
+		ret = ad4000_write_reg(st, reg_val);
+		if (ret < 0)
+			goto err_release;
+
+		st->span_comp = val;
+		break;
+	case AD4000_HIGHZ:
+		reg_val &= ~AD4000_HIGHZ;
+		reg_val |= FIELD_PREP(AD4000_HIGHZ, val);
+		ret = ad4000_write_reg(st, reg_val);
+		if (ret < 0)
+			goto err_release;
+
+		st->high_z_mode = val;
+		break;
+	case AD4000_TURBO:
+		reg_val &= ~AD4000_TURBO;
+		reg_val |= FIELD_PREP(AD4000_TURBO, val);
+		ret = ad4000_write_reg(st, reg_val);
+		if (ret < 0)
+			goto err_release;
+
+		st->turbo_mode = val;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_release;
+	}
+
+err_release:
+	iio_device_release_direct_mode(indio_dev);
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(status_bits_en, 0644, ad4000_show, ad4000_store,
+		       AD4000_STATUS);
+
+static IIO_DEVICE_ATTR(span_compression_en, 0644, ad4000_show, ad4000_store,
+		       AD4000_SPAN_COMP);
+
+static IIO_DEVICE_ATTR(high_impedance_en, 0644, ad4000_show, ad4000_store,
+		       AD4000_HIGHZ);
+
+static IIO_DEVICE_ATTR(turbo_en, 0644, ad4000_show, ad4000_store,
+		       AD4000_TURBO);
+
+static struct attribute *ad4000_attributes[] = {
+	&iio_dev_attr_status_bits_en.dev_attr.attr,
+	&iio_dev_attr_span_compression_en.dev_attr.attr,
+	&iio_dev_attr_high_impedance_en.dev_attr.attr,
+	&iio_dev_attr_turbo_en.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad4000_attribute_group = {
+	.attrs = ad4000_attributes,
+};
+
+static irqreturn_t ad4000_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4000_state *st = iio_priv(indio_dev);
+	struct spi_transfer t = {0};
+	struct spi_message m;
+	int ret;
+
+	t.rx_buf = &st->data.scan.sample_buf;
+	t.len = 4;
+	t.delay.value = 60;
+	t.delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	spi_message_init_with_transfers(&m, &t, 1);
+
+	if (st->cnv_gpio)
+		gpiod_set_value(st->cnv_gpio, GPIOD_OUT_HIGH);
+
+	ret = spi_sync(st->spi, &m);
+	if (ret < 0)
+		goto err_out;
+
+	if (st->cnv_gpio)
+		gpiod_set_value(st->cnv_gpio, GPIOD_OUT_LOW);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
+					   iio_get_time_ns(indio_dev));
+
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info ad4000_info = {
+	.read_raw = &ad4000_read_raw,
+	.attrs = &ad4000_attribute_group,
+};
+
+static void ad4000_regulator_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static int ad4000_probe(struct spi_device *spi)
+{
+	const struct ad4000_chip_info *chip;
+	struct regulator *vref_reg;
+	struct iio_dev *indio_dev;
+	struct ad4000_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = (const struct ad4000_chip_info *)device_get_match_data(&spi->dev);
+	if (!chip)
+		return -EINVAL;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	vref_reg = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(vref_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
+				     "Failed to get vref regulator\n");
+
+	ret = regulator_enable(vref_reg);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to enable voltage regulator\n");
+
+	ret = devm_add_action_or_reset(&spi->dev, ad4000_regulator_disable, vref_reg);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to add regulator disable action\n");
+
+	st->vref = regulator_get_voltage(vref_reg);
+	if (st->vref < 0)
+		return dev_err_probe(&spi->dev, st->vref, "Failed to get vref\n");
+
+	if (!device_property_present(&spi->dev, "adi,spi-cs-mode")) {
+		st->cnv_gpio = devm_gpiod_get(&spi->dev, "cnv", GPIOD_OUT_HIGH);
+		if (IS_ERR(st->cnv_gpio)) {
+			if (PTR_ERR(st->cnv_gpio) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+
+			return dev_err_probe(&spi->dev, PTR_ERR(st->cnv_gpio),
+					     "Failed to get CNV GPIO");
+		}
+	}
+
+	indio_dev->name = chip->dev_name;
+	indio_dev->info = &ad4000_info;
+	indio_dev->channels = &chip->chan_spec;
+	indio_dev->num_channels = 1;
+
+	if (device_property_present(&spi->dev, "adi,gain-milli")) {
+		u32 val;
+
+		ret = device_property_read_u32(&spi->dev, "adi,gain-milli", &val);
+		if (ret)
+			return ret;
+
+		switch (val) {
+		case 454:
+			st->pin_gain = AD4000_0454_GAIN;
+			break;
+		case 909:
+			st->pin_gain = AD4000_0909_GAIN;
+			break;
+		case 1000:
+			st->pin_gain = AD4000_1_GAIN;
+			break;
+		case 1900:
+			st->pin_gain = AD4000_1900_GAIN;
+			break;
+		default:
+			return dev_err_probe(&spi->dev, -EINVAL,
+					     "Invalid firmware provided gain\n");
+		}
+	} else {
+		st->pin_gain = AD4000_1_GAIN;
+	}
+
+	/*
+	 * ADCs that output twos complement code have one less bit to express
+	 * voltage magnitude.
+	 */
+	if (chip->chan_spec.scan_type.sign == 's')
+		ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realbits - 1);
+	else
+		ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realbits);
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad4000_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad4000_id[] = {
+	{ "ad4000", (kernel_ulong_t)&ad4000_chips[ID_AD4000] },
+	{ "ad4001", (kernel_ulong_t)&ad4000_chips[ID_AD4001] },
+	{ "ad4002", (kernel_ulong_t)&ad4000_chips[ID_AD4002] },
+	{ "ad4003", (kernel_ulong_t)&ad4000_chips[ID_AD4003] },
+	{ "ad4004", (kernel_ulong_t)&ad4000_chips[ID_AD4004] },
+	{ "ad4005", (kernel_ulong_t)&ad4000_chips[ID_AD4005] },
+	{ "ad4006", (kernel_ulong_t)&ad4000_chips[ID_AD4006] },
+	{ "ad4007", (kernel_ulong_t)&ad4000_chips[ID_AD4007] },
+	{ "ad4008", (kernel_ulong_t)&ad4000_chips[ID_AD4008] },
+	{ "ad4010", (kernel_ulong_t)&ad4000_chips[ID_AD4010] },
+	{ "ad4011", (kernel_ulong_t)&ad4000_chips[ID_AD4011] },
+	{ "ad4020", (kernel_ulong_t)&ad4000_chips[ID_AD4020] },
+	{ "ad4021", (kernel_ulong_t)&ad4000_chips[ID_AD4021] },
+	{ "ad4022", (kernel_ulong_t)&ad4000_chips[ID_AD4022] },
+	{ "adaq4001", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4001] },
+	{ "adaq4003", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4003] },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4000_id);
+
+static const struct of_device_id ad4000_of_match[] = {
+	{ .compatible = "adi,ad4000",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4000] },
+	{ .compatible = "adi,ad4001",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4001] },
+	{ .compatible = "adi,ad4002",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4002] },
+	{ .compatible = "adi,ad4003",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4003] },
+	{ .compatible = "adi,ad4004",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4004] },
+	{ .compatible = "adi,ad4005",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4005] },
+	{ .compatible = "adi,ad4006",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4006] },
+	{ .compatible = "adi,ad4007",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4007] },
+	{ .compatible = "adi,ad4008",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4008] },
+	{ .compatible = "adi,ad4010",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4010] },
+	{ .compatible = "adi,ad4011",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4011] },
+	{ .compatible = "adi,ad4020",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4020] },
+	{ .compatible = "adi,ad4021",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4021] },
+	{ .compatible = "adi,ad4022",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4022] },
+	{ .compatible = "adi,adaq4001",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_ADAQ4001] },
+	{ .compatible = "adi,adaq4003",
+	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_ADAQ4003] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4000_of_match);
+
+static struct spi_driver ad4000_driver = {
+	.driver = {
+		.name   = "ad4000",
+		.of_match_table = ad4000_of_match,
+	},
+	.probe          = ad4000_probe,
+	.id_table       = ad4000_id,
+};
+module_spi_driver(ad4000_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4000 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


