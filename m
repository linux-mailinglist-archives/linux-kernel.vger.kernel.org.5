Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490EB758FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGSHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjGSHxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:53:47 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD62100;
        Wed, 19 Jul 2023 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689753224;
  x=1721289224;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=9TTxf/t+F4ONHZWNnRL6J7zQaa33Dr5OM5xM0pTE7f0=;
  b=RD4c2LV9XW9f+83udG1dN5ws0kjC6+7TxlzWIV73siIgYckHKRmlj8Cf
   uvh/Xt0DP+qumiPzgjvT8Nyy4r9EMUjo25+RjOWRpV38hRCP6dUcOKPnM
   6YVX32SDQ0NjU6AnURe6xMI7s63EFZU0KrOa1/YAO39sS1dFeKSq+4hzS
   dBawMlOUB+I9S35+ZMCFytZBLYHEOjheTlI73sIYY4jVEr7/iSJrixi01
   C/jefiBYyc9zIQwSKCXwQ89vDIbMx3/N5t3NL6aq8tzctXu2U2f6GlCfr
   p7OK5482N5Fk6raQK5e18tUwnC8NfmMHmtq5TOnKLR357lpIVcCLIdv5c
   A==;
References: <cover.1689753076.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v4 3/3] iio: Add driver for Murata IRS-D200
In-Reply-To: <cover.1689753076.git.waqar.hameed@axis.com>
Date:   Wed, 19 Jul 2023 09:51:17 +0200
Message-ID: <d218a1bc75402b5ebd6e12a563f7315f83fe966c.1689753076.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murata IRS-D200 is a PIR sensor for human detection. It has support for
raw data measurements and detection event notification.

Add a driver with support for triggered buffer and events. Map the
various settings to the `iio` framework, e.g. threshold values, sampling
frequency, filter frequencies etc.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/iio/proximity/Kconfig   |  12 +
 drivers/iio/proximity/Makefile  |   1 +
 drivers/iio/proximity/irsd200.c | 962 ++++++++++++++++++++++++++++++++
 3 files changed, 975 insertions(+)
 create mode 100644 drivers/iio/proximity/irsd200.c

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 0e5c17530b8b..2ca3b0bc5eba 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -32,6 +32,18 @@ config CROS_EC_MKBP_PROXIMITY
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_mkbp_proximity.
 
+config IRSD200
+	tristate "Murata IRS-D200 PIR sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here to build a driver for the Murata IRS-D200 PIR sensor.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called irsd200.
+
 config ISL29501
 	tristate "Intersil ISL29501 Time Of Flight sensor"
 	depends on I2C
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index cc838bb5408a..f36598380446 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AS3935)		+= as3935.o
 obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
+obj-$(CONFIG_IRSD200)		+= irsd200.o
 obj-$(CONFIG_ISL29501)		+= isl29501.o
 obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
 obj-$(CONFIG_MB1232)		+= mb1232.o
diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
new file mode 100644
index 000000000000..19f7eb2a3ded
--- /dev/null
+++ b/drivers/iio/proximity/irsd200.c
@@ -0,0 +1,962 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Murata IRS-D200 PIR sensor.
+ *
+ * Copyright (C) 2023 Axis Communications AB
+ */
+
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/types.h>
+
+#define IRS_DRV_NAME "irsd200"
+
+/* Registers. */
+#define IRS_REG_OP		0x00	/* Operation mode. */
+#define IRS_REG_DATA_LO		0x02	/* Sensor data LSB. */
+#define IRS_REG_DATA_HI		0x03	/* Sensor data MSB. */
+#define IRS_REG_STATUS		0x04	/* Interrupt status. */
+#define IRS_REG_COUNT		0x05	/* Count of exceeding threshold. */
+#define IRS_REG_DATA_RATE	0x06	/* Output data rate. */
+#define IRS_REG_FILTER		0x07	/* High-pass and low-pass filter. */
+#define IRS_REG_INTR		0x09	/* Interrupt mode. */
+#define IRS_REG_NR_COUNT	0x0a	/* Number of counts before interrupt. */
+#define IRS_REG_THR_HI		0x0b	/* Upper threshold. */
+#define IRS_REG_THR_LO		0x0c	/* Lower threshold. */
+#define IRS_REG_TIMER_LO	0x0d	/* Timer setting LSB. */
+#define IRS_REG_TIMER_HI	0x0e	/* Timer setting MSB. */
+
+/* Interrupt status bits. */
+#define IRS_INTR_DATA		0	/* Data update. */
+#define IRS_INTR_TIMER		1	/* Timer expiration. */
+#define IRS_INTR_COUNT_THR_AND	2	/* Count "AND" threshold. */
+#define IRS_INTR_COUNT_THR_OR	3	/* Count "OR" threshold. */
+
+/* Operation states. */
+#define IRS_OP_ACTIVE		0x00
+#define IRS_OP_SLEEP		0x01
+
+/*
+ * Quantization scale value for threshold. Used for conversion from/to register
+ * value.
+ */
+#define IRS_THR_QUANT_SCALE	128
+
+#define IRS_UPPER_COUNT(count)	FIELD_GET(GENMASK(7, 4), count)
+#define IRS_LOWER_COUNT(count)	FIELD_GET(GENMASK(3, 0), count)
+
+/* Index corresponds to the value of IRS_REG_DATA_RATE register. */
+static const int irsd200_data_rates[] = {
+	50,
+	100,
+};
+
+/* Index corresponds to the (field) value of IRS_REG_FILTER register. */
+static const unsigned int irsd200_lp_filter_freq[] = {
+	10,
+	7,
+};
+
+/*
+ * Index corresponds to the (field) value of IRS_REG_FILTER register. Note that
+ * this represents a fractional value (e.g the first value corresponds to 3 / 10
+ * = 0.3 Hz).
+ */
+static const unsigned int irsd200_hp_filter_freq[][2] = {
+	{3, 10},
+	{5, 10},
+};
+
+/* Register fields. */
+enum irsd200_regfield {
+	/* Data interrupt. */
+	IRS_REGF_INTR_DATA,
+	/* Timer interrupt. */
+	IRS_REGF_INTR_TIMER,
+	/* AND count threshold interrupt. */
+	IRS_REGF_INTR_COUNT_THR_AND,
+	/* OR count threshold interrupt. */
+	IRS_REGF_INTR_COUNT_THR_OR,
+
+	/* Low-pass filter frequency. */
+	IRS_REGF_LP_FILTER,
+	/* High-pass filter frequency. */
+	IRS_REGF_HP_FILTER,
+
+	/* Sentinel value. */
+	IRS_REGF_MAX
+};
+
+static const struct reg_field irsd200_regfields[] = {
+	[IRS_REGF_INTR_DATA] =
+		REG_FIELD(IRS_REG_INTR, IRS_INTR_DATA, IRS_INTR_DATA),
+	[IRS_REGF_INTR_TIMER] =
+		REG_FIELD(IRS_REG_INTR, IRS_INTR_TIMER, IRS_INTR_TIMER),
+	[IRS_REGF_INTR_COUNT_THR_AND] = REG_FIELD(
+		IRS_REG_INTR, IRS_INTR_COUNT_THR_AND, IRS_INTR_COUNT_THR_AND),
+	[IRS_REGF_INTR_COUNT_THR_OR] = REG_FIELD(
+		IRS_REG_INTR, IRS_INTR_COUNT_THR_OR, IRS_INTR_COUNT_THR_OR),
+
+	[IRS_REGF_LP_FILTER] = REG_FIELD(IRS_REG_FILTER, 1, 1),
+	[IRS_REGF_HP_FILTER] = REG_FIELD(IRS_REG_FILTER, 0, 0),
+};
+
+static const struct regmap_config irsd200_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = IRS_REG_TIMER_HI,
+};
+
+struct irsd200_data {
+	struct regmap *regmap;
+	struct regmap_field *regfields[IRS_REGF_MAX];
+	struct device *dev;
+};
+
+static int irsd200_setup(struct irsd200_data *data)
+{
+	unsigned int val;
+	int ret;
+
+	/* Disable all interrupt sources. */
+	ret = regmap_write(data->regmap, IRS_REG_INTR, 0);
+	if (ret) {
+		dev_err(data->dev, "Could not set interrupt sources (%d)\n",
+			ret);
+		return ret;
+	}
+
+	/* Set operation to active. */
+	ret = regmap_write(data->regmap, IRS_REG_OP, IRS_OP_ACTIVE);
+	if (ret) {
+		dev_err(data->dev, "Could not set operation mode (%d)\n", ret);
+		return ret;
+	}
+
+	/* Clear threshold count. */
+	ret = regmap_read(data->regmap, IRS_REG_COUNT, &val);
+	if (ret) {
+		dev_err(data->dev, "Could not clear threshold count (%d)\n",
+			ret);
+		return ret;
+	}
+
+	/* Clear status. */
+	ret = regmap_write(data->regmap, IRS_REG_STATUS, 0x0f);
+	if (ret) {
+		dev_err(data->dev, "Could not clear status (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int irsd200_read_threshold(struct irsd200_data *data,
+				  enum iio_event_direction dir, int *val)
+{
+	unsigned int regval;
+	unsigned int reg;
+	int scale;
+	int ret;
+
+	/* Set quantization scale. */
+	if (dir == IIO_EV_DIR_RISING) {
+		scale = IRS_THR_QUANT_SCALE;
+		reg = IRS_REG_THR_HI;
+	} else if (dir == IIO_EV_DIR_FALLING) {
+		scale = -IRS_THR_QUANT_SCALE;
+		reg = IRS_REG_THR_LO;
+	} else {
+		return -EINVAL;
+	}
+
+	ret = regmap_read(data->regmap, reg, &regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read threshold (%d)\n", ret);
+		return ret;
+	}
+
+	*val = ((int)regval) * scale;
+
+	return 0;
+}
+
+static int irsd200_write_threshold(struct irsd200_data *data,
+				   enum iio_event_direction dir, int val)
+{
+	unsigned int regval;
+	unsigned int reg;
+	int scale;
+	int ret;
+
+	/* Set quantization scale. */
+	if (dir == IIO_EV_DIR_RISING) {
+		if (val < 0)
+			return -ERANGE;
+
+		scale = IRS_THR_QUANT_SCALE;
+		reg = IRS_REG_THR_HI;
+	} else if (dir == IIO_EV_DIR_FALLING) {
+		if (val > 0)
+			return -ERANGE;
+
+		scale = -IRS_THR_QUANT_SCALE;
+		reg = IRS_REG_THR_LO;
+	} else {
+		return -EINVAL;
+	}
+
+	regval = val / scale;
+
+	if (regval >= BIT(8))
+		return -ERANGE;
+
+	ret = regmap_write(data->regmap, reg, regval);
+	if (ret) {
+		dev_err(data->dev, "Could not write threshold (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int irsd200_read_data(struct irsd200_data *data, s16 *val)
+{
+	__le16 buf;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, IRS_REG_DATA_LO, &buf,
+			       sizeof(buf));
+	if (ret) {
+		dev_err(data->dev, "Could not bulk read data (%d)\n", ret);
+		return ret;
+	}
+
+	*val = le16_to_cpu(buf);
+
+	return 0;
+}
+
+static int irsd200_read_data_rate(struct irsd200_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, IRS_REG_DATA_RATE, &regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read data rate (%d)\n", ret);
+		return ret;
+	}
+
+	if (regval >= ARRAY_SIZE(irsd200_data_rates))
+		return -ERANGE;
+
+	*val = irsd200_data_rates[regval];
+
+	return 0;
+}
+
+static int irsd200_write_data_rate(struct irsd200_data *data, int val)
+{
+	size_t idx;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(irsd200_data_rates); ++idx) {
+		if (irsd200_data_rates[idx] == val)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(irsd200_data_rates))
+		return -ERANGE;
+
+	ret = regmap_write(data->regmap, IRS_REG_DATA_RATE, idx);
+	if (ret) {
+		dev_err(data->dev, "Could not write data rate (%d)\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Data sheet says the device needs 3 seconds of settling time. The
+	 * device operates normally during this period though. This is more of a
+	 * "guarantee" than trying to prevent other user space reads/writes.
+	 */
+	ssleep(3);
+
+	return 0;
+}
+
+static int irsd200_read_timer(struct irsd200_data *data, int *val, int *val2)
+{
+	__le16 buf;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, IRS_REG_TIMER_LO, &buf,
+			       sizeof(buf));
+	if (ret) {
+		dev_err(data->dev, "Could not bulk read timer (%d)\n", ret);
+		return ret;
+	}
+
+	ret = irsd200_read_data_rate(data, val2);
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(buf);
+
+	return 0;
+}
+
+static int irsd200_write_timer(struct irsd200_data *data, int val, int val2)
+{
+	unsigned int regval;
+	int data_rate;
+	__le16 buf;
+	int ret;
+
+	if (val < 0 || val2 < 0)
+		return -ERANGE;
+
+	ret = irsd200_read_data_rate(data, &data_rate);
+	if (ret)
+		return ret;
+
+	/* Quantize from seconds. */
+	regval = val * data_rate + (val2 * data_rate) / 1000000;
+
+	/* Value is 10 bits. */
+	if (regval >= BIT(10))
+		return -ERANGE;
+
+	buf = cpu_to_le16((u16)regval);
+
+	ret = regmap_bulk_write(data->regmap, IRS_REG_TIMER_LO, &buf,
+				sizeof(buf));
+	if (ret) {
+		dev_err(data->dev, "Could not bulk write timer (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int irsd200_read_nr_count(struct irsd200_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, IRS_REG_NR_COUNT, &regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read nr count (%d)\n", ret);
+		return ret;
+	}
+
+	*val = regval;
+
+	return 0;
+}
+
+static int irsd200_write_nr_count(struct irsd200_data *data, int val)
+{
+	unsigned int regval;
+	int ret;
+
+	/* A value of zero means that IRS_REG_STATUS is never set. */
+	if (val <= 0 || val >= 8)
+		return -ERANGE;
+
+	regval = val;
+
+	if (regval >= 2) {
+		/*
+		 * According to the data sheet, timer must be also set in this
+		 * case (i.e. be non-zero). Check and enforce that.
+		 */
+		ret = irsd200_read_timer(data, &val, &val);
+		if (ret)
+			return ret;
+
+		if (val == 0) {
+			dev_err(data->dev,
+				"Timer must be non-zero when nr count is %u\n",
+				regval);
+			return -EPERM;
+		}
+	}
+
+	ret = regmap_write(data->regmap, IRS_REG_NR_COUNT, regval);
+	if (ret) {
+		dev_err(data->dev, "Could not write nr count (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int irsd200_read_lp_filter(struct irsd200_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_field_read(data->regfields[IRS_REGF_LP_FILTER], &regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read lp filter frequency (%d)\n",
+			ret);
+		return ret;
+	}
+
+	*val = irsd200_lp_filter_freq[regval];
+
+	return 0;
+}
+
+static int irsd200_write_lp_filter(struct irsd200_data *data, int val)
+{
+	size_t idx;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(irsd200_lp_filter_freq); ++idx) {
+		if (irsd200_lp_filter_freq[idx] == val)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(irsd200_lp_filter_freq))
+		return -ERANGE;
+
+	ret = regmap_field_write(data->regfields[IRS_REGF_LP_FILTER], idx);
+	if (ret) {
+		dev_err(data->dev, "Could not write lp filter frequency (%d)\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int irsd200_read_hp_filter(struct irsd200_data *data, int *val,
+				  int *val2)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_field_read(data->regfields[IRS_REGF_HP_FILTER], &regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read hp filter frequency (%d)\n",
+			ret);
+		return ret;
+	}
+
+	*val = irsd200_hp_filter_freq[regval][0];
+	*val2 = irsd200_hp_filter_freq[regval][1];
+
+	return 0;
+}
+
+static int irsd200_write_hp_filter(struct irsd200_data *data, int val, int val2)
+{
+	size_t idx;
+	int ret;
+
+	/* Truncate fractional part to one digit. */
+	val2 /= 100000;
+
+	for (idx = 0; idx < ARRAY_SIZE(irsd200_hp_filter_freq); ++idx) {
+		if (irsd200_hp_filter_freq[idx][0] == val2)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(irsd200_hp_filter_freq) || val != 0)
+		return -ERANGE;
+
+	ret = regmap_field_write(data->regfields[IRS_REGF_HP_FILTER], idx);
+	if (ret) {
+		dev_err(data->dev, "Could not write hp filter frequency (%d)\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int irsd200_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct irsd200_data *data = iio_priv(indio_dev);
+	int ret;
+	s16 buf;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = irsd200_read_data(data, &buf);
+		if (ret)
+			return ret;
+
+		*val = buf;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = irsd200_read_data_rate(data, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = irsd200_read_lp_filter(data, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		ret = irsd200_read_hp_filter(data, val, val2);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int irsd200_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = irsd200_data_rates;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(irsd200_data_rates);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = irsd200_lp_filter_freq;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(irsd200_lp_filter_freq);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (int *)irsd200_hp_filter_freq;
+		*type = IIO_VAL_FRACTIONAL;
+		*length = 2 * ARRAY_SIZE(irsd200_hp_filter_freq);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int irsd200_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct irsd200_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return irsd200_write_data_rate(data, val);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return irsd200_write_lp_filter(data, val);
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		return irsd200_write_hp_filter(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int irsd200_read_event(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir,
+			      enum iio_event_info info, int *val, int *val2)
+{
+	struct irsd200_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = irsd200_read_threshold(data, dir, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_EV_INFO_RUNNING_PERIOD:
+		ret = irsd200_read_timer(data, val, val2);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_FRACTIONAL;
+	case IIO_EV_INFO_RUNNING_COUNT:
+		ret = irsd200_read_nr_count(data, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int irsd200_write_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info, int val, int val2)
+{
+	struct irsd200_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return irsd200_write_threshold(data, dir, val);
+	case IIO_EV_INFO_RUNNING_PERIOD:
+		return irsd200_write_timer(data, val, val2);
+	case IIO_EV_INFO_RUNNING_COUNT:
+		return irsd200_write_nr_count(data, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int irsd200_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct irsd200_data *data = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		ret = regmap_field_read(
+			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], &val);
+		if (ret)
+			return ret;
+
+		return val;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int irsd200_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, int state)
+{
+	struct irsd200_data *data = iio_priv(indio_dev);
+	unsigned int tmp;
+	int ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		/* Clear the count register (by reading from it). */
+		ret = regmap_read(data->regmap, IRS_REG_COUNT, &tmp);
+		if (ret)
+			return ret;
+
+		tmp = !!state;
+		ret = regmap_field_write(
+			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], tmp);
+		if (ret)
+			return ret;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t irsd200_irq_thread(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct irsd200_data *data = iio_priv(indio_dev);
+	enum iio_event_direction dir;
+	unsigned int lower_count;
+	unsigned int upper_count;
+	unsigned int status = 0;
+	unsigned int source = 0;
+	unsigned int clear = 0;
+	unsigned int count = 0;
+	int ret;
+
+	ret = regmap_read(data->regmap, IRS_REG_INTR, &source);
+	if (ret) {
+		dev_err(data->dev, "Could not read interrupt source (%d)\n",
+			ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = regmap_read(data->regmap, IRS_REG_STATUS, &status);
+	if (ret) {
+		dev_err(data->dev, "Could not acknowledge interrupt (%d)\n",
+			ret);
+		return IRQ_HANDLED;
+	}
+
+	if (status & BIT(IRS_INTR_DATA) && iio_buffer_enabled(indio_dev)) {
+		iio_trigger_poll_nested(indio_dev->trig);
+		clear |= BIT(IRS_INTR_DATA);
+	}
+
+	if (status & BIT(IRS_INTR_COUNT_THR_OR) &&
+	    source & BIT(IRS_INTR_COUNT_THR_OR)) {
+		/*
+		 * The register value resets to zero after reading. We therefore
+		 * need to read once and manually extract the lower and upper
+		 * count register fields.
+		 */
+		ret = regmap_read(data->regmap, IRS_REG_COUNT, &count);
+		if (ret)
+			dev_err(data->dev, "Could not read count (%d)\n", ret);
+
+		upper_count = IRS_UPPER_COUNT(count);
+		lower_count = IRS_LOWER_COUNT(count);
+
+		/*
+		 * We only check the OR mode to be able to push events for
+		 * rising and falling thresholds. AND mode is covered when both
+		 * upper and lower count is non-zero, and is signaled with
+		 * IIO_EV_DIR_EITHER.
+		 */
+		if (upper_count && !lower_count)
+			dir = IIO_EV_DIR_RISING;
+		else if (!upper_count && lower_count)
+			dir = IIO_EV_DIR_FALLING;
+		else
+			dir = IIO_EV_DIR_EITHER;
+
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH, dir),
+			       iio_get_time_ns(indio_dev));
+
+		/*
+		 * The OR mode will always trigger when the AND mode does, but
+		 * not vice versa. However, it seems like the AND bit needs to
+		 * be cleared if data capture _and_ threshold count interrupts
+		 * are desirable, even though it hasn't explicitly been selected
+		 * (with IRS_REG_INTR). Either way, it doesn't hurt...
+		 */
+		clear |= BIT(IRS_INTR_COUNT_THR_OR) |
+			 BIT(IRS_INTR_COUNT_THR_AND);
+	}
+
+	if (clear) {
+		ret = regmap_write(data->regmap, IRS_REG_STATUS, clear);
+		if (ret)
+			dev_err(data->dev,
+				"Could not clear interrupt status (%d)\n", ret);
+	}
+
+	return clear ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
+{
+	struct iio_dev *indio_dev = ((struct iio_poll_func *)pollf)->indio_dev;
+	struct irsd200_data *data = iio_priv(indio_dev);
+	s16 buf = 0;
+	int ret;
+
+	ret = irsd200_read_data(data, &buf);
+	if (ret)
+		goto end;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &buf,
+					   iio_get_time_ns(indio_dev));
+
+end:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int irsd200_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct irsd200_data *data = iio_trigger_get_drvdata(trig);
+	int ret;
+
+	ret = regmap_field_write(data->regfields[IRS_REGF_INTR_DATA], state);
+	if (ret) {
+		dev_err(data->dev, "Could not %s data interrupt source (%d)\n",
+			state ? "enable" : "disable", ret);
+	}
+
+	return ret;
+}
+
+static const struct iio_info irsd200_info = {
+	.read_raw = irsd200_read_raw,
+	.read_avail = irsd200_read_avail,
+	.write_raw = irsd200_write_raw,
+	.read_event_value = irsd200_read_event,
+	.write_event_value = irsd200_write_event,
+	.read_event_config = irsd200_read_event_config,
+	.write_event_config = irsd200_write_event_config,
+};
+
+static const struct iio_trigger_ops irsd200_trigger_ops = {
+	.set_trigger_state = irsd200_set_trigger_state,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static const struct iio_event_spec irsd200_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate =
+			BIT(IIO_EV_INFO_RUNNING_PERIOD) |
+			BIT(IIO_EV_INFO_RUNNING_COUNT) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec irsd200_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
+			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_separate_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
+			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
+		.event_spec = irsd200_event_spec,
+		.num_event_specs = ARRAY_SIZE(irsd200_event_spec),
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+};
+
+static int irsd200_probe(struct i2c_client *client)
+{
+	struct iio_trigger *trigger;
+	struct irsd200_data *data;
+	struct iio_dev *indio_dev;
+	size_t i;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return dev_err_probe(&client->dev, -ENOMEM,
+				     "Could not allocate iio device\n");
+
+	data = iio_priv(indio_dev);
+	data->dev = &client->dev;
+
+	data->regmap = devm_regmap_init_i2c(client, &irsd200_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(data->dev, PTR_ERR(data->regmap),
+				     "Could not initialize regmap\n");
+
+	for (i = 0; i < IRS_REGF_MAX; ++i) {
+		data->regfields[i] = devm_regmap_field_alloc(
+			data->dev, data->regmap, irsd200_regfields[i]);
+		if (IS_ERR(data->regfields[i]))
+			return dev_err_probe(
+				data->dev, PTR_ERR(data->regfields[i]),
+				"Could not allocate register field %zu\n", i);
+	}
+
+	ret = devm_regulator_get_enable(data->dev, "vdd");
+	if (ret)
+		return dev_err_probe(
+			data->dev, ret,
+			"Could not get and enable regulator (%d)\n", ret);
+
+	ret = irsd200_setup(data);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &irsd200_info;
+	indio_dev->name = IRS_DRV_NAME;
+	indio_dev->channels = irsd200_channels;
+	indio_dev->num_channels = ARRAY_SIZE(irsd200_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	if (!client->irq)
+		return dev_err_probe(data->dev, -ENXIO, "No irq available\n");
+
+	ret = devm_iio_triggered_buffer_setup(data->dev, indio_dev, NULL,
+					      irsd200_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(
+			data->dev, ret,
+			"Could not setup iio triggered buffer (%d)\n", ret);
+
+	ret = devm_request_threaded_irq(data->dev, client->irq, NULL,
+					irsd200_irq_thread,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					NULL, indio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not request irq (%d)\n", ret);
+
+	trigger = devm_iio_trigger_alloc(data->dev, "%s-dev%d", indio_dev->name,
+					 iio_device_id(indio_dev));
+	if (!trigger)
+		return dev_err_probe(data->dev, -ENOMEM,
+				     "Could not allocate iio trigger\n");
+
+	trigger->ops = &irsd200_trigger_ops;
+	iio_trigger_set_drvdata(trigger, data);
+
+	ret = devm_iio_trigger_register(data->dev, trigger);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not register iio trigger (%d)\n",
+				     ret);
+
+	ret = devm_iio_device_register(data->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not register iio device (%d)\n",
+				     ret);
+
+	return 0;
+}
+
+static const struct of_device_id irsd200_of_match[] = {
+	{
+		.compatible = "murata,irsd200",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, irsd200_of_match);
+
+static struct i2c_driver irsd200_driver = {
+	.driver = {
+		.name = IRS_DRV_NAME,
+		.of_match_table = irsd200_of_match,
+	},
+	.probe = irsd200_probe,
+};
+module_i2c_driver(irsd200_driver);
+
+MODULE_AUTHOR("Waqar Hameed <waqar.hameed@axis.com>");
+MODULE_DESCRIPTION("Murata IRS-D200 PIR sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2

