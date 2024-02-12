Return-Path: <linux-kernel+bounces-62148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BC851C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A381F2554A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11BE4BA94;
	Mon, 12 Feb 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="bAGGdHac"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DC45BE6;
	Mon, 12 Feb 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760458; cv=none; b=OIZ0QUltwfNRYj/zo3b7Ll/9QUxWUcrHEo5xTEarAdjtUJV0WZt+ABIheECtkdiNpEOUeJpkE+7HgNo/nlnRP7EUffPqfdX+2HS8Fl6+NMrzT14XDAEoFtkw1N+pZT6Gh1DKr0KY8vX2q7a2KcfVXidMvuBuHjn4VobMtqpj5Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760458; c=relaxed/simple;
	bh=Dre3xFkOEmvb+OBLI78OWTYhB5fzKgvXBnfovWXmJOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAJ3RBwkmVlImb5ZU6dJcN/18gkKovUYaYY31cyCrIwdN8o1CsGrexOar9IlTg0Bg2CUxcanXyBM7+32Gxly5D5QPAvClof6BjLt1G23629Wsjda8aT0SYfmCsLAOcQojbMQc9RC+4GKoVlW9Qfe8pHV/hEVDfcNaZBZ0joigNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=bAGGdHac; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707760454; bh=Dre3xFkOEmvb+OBLI78OWTYhB5fzKgvXBnfovWXmJOE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=bAGGdHacHyUIin9nwu0JaeJiTsqYEUpjJV1XMhMlpxigrZOnzcCNTY/ip09HDs5mP
	 iu29FcwaSJFrIb1Wn8c+f/ir115SupRiXMunbY3SIOk6XBjAA+44kaAnZac72fi1kw
	 C//vQCxMBpX7ZjK++As7L9H91H23g80Qa3HTXFhs=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>,
	Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: [PATCH v2 3/4] iio: magnetometer: add a driver for Voltafield AF8133J magnetometer
Date: Mon, 12 Feb 2024 18:53:55 +0100
Message-ID: <20240212175410.3101973-4-megi@xff.cz>
In-Reply-To: <20240212175410.3101973-1-megi@xff.cz>
References: <20240212175410.3101973-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Icenowy Zheng <icenowy@aosc.io>

AF8133J is a simple I2C-connected magnetometer, without interrupts.

Add a simple IIO driver for it.

Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Dalton Durst <dalton@ubports.com>
Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/iio/magnetometer/Kconfig   |  12 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/af8133j.c | 528 +++++++++++++++++++++++++++++
 3 files changed, 541 insertions(+)
 create mode 100644 drivers/iio/magnetometer/af8133j.c

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 38532d840f2a..cd2917d71904 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -6,6 +6,18 @@
 
 menu "Magnetometer sensors"
 
+config AF8133J
+	tristate "Voltafield AF8133J 3-Axis Magnetometer"
+	depends on I2C
+	depends on OF
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for Voltafield AF8133J I2C-based
+	  3-axis magnetometer chip.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called af8133j.
+
 config AK8974
 	tristate "Asahi Kasei AK8974 3-Axis Magnetometer"
 	depends on I2C
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index b1c784ea71c8..ec5c46fbf999 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -4,6 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_AF8133J)	+= af8133j.o
 obj-$(CONFIG_AK8974)	+= ak8974.o
 obj-$(CONFIG_AK8975)	+= ak8975.o
 obj-$(CONFIG_BMC150_MAGN) += bmc150_magn.o
diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
new file mode 100644
index 000000000000..1f64a2337f6e
--- /dev/null
+++ b/drivers/iio/magnetometer/af8133j.c
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * af8133j.c - Voltafield AF8133J magnetometer driver
+ *
+ * Copyright 2021 Icenowy Zheng <icenowy@aosc.io>
+ * Copyright 2024 Ondřej Jirman <megi@xff.cz>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define AF8133J_REG_OUT		0x03
+#define AF8133J_REG_PCODE	0x00
+#define AF8133J_REG_PCODE_VAL	0x5e
+#define AF8133J_REG_STATUS	0x02
+#define AF8133J_REG_STATUS_ACQ	BIT(0)
+#define AF8133J_REG_STATE	0x0a
+#define AF8133J_REG_STATE_STBY	0x00
+#define AF8133J_REG_STATE_WORK	0x01
+#define AF8133J_REG_RANGE	0x0b
+#define AF8133J_REG_RANGE_22G	0x12
+#define AF8133J_REG_RANGE_12G	0x34
+#define AF8133J_REG_SWR		0x11
+#define AF8133J_REG_SWR_PERFORM	0x81
+
+static const char * const af8133j_supply_names[] = {
+	"avdd",
+	"dvdd",
+};
+
+struct af8133j_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct mutex mutex;
+	struct iio_mount_matrix orientation;
+
+	struct gpio_desc *reset_gpiod;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(af8133j_supply_names)];
+
+	u8 range;
+};
+
+enum af8133j_axis {
+	AXIS_X = 0,
+	AXIS_Y,
+	AXIS_Z,
+};
+
+static struct iio_mount_matrix *
+af8133j_get_mount_matrix(struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct af8133j_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info af8133j_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, af8133j_get_mount_matrix),
+	{ }
+};
+
+#define AF8133J_CHANNEL(_si, _axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _axis, \
+	.address = AXIS_ ## _axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
+	.ext_info = af8133j_ext_info, \
+	.scan_index = _si, \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_LE, \
+	}, \
+}
+
+static const struct iio_chan_spec af8133j_channels[] = {
+	AF8133J_CHANNEL(0, X),
+	AF8133J_CHANNEL(1, Y),
+	AF8133J_CHANNEL(2, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static int af8133j_product_check(struct af8133j_data *data)
+{
+	struct device *dev = &data->client->dev;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(data->regmap, AF8133J_REG_PCODE, &val);
+	if (ret < 0) {
+		dev_err(dev, "Error reading product code (%d)\n", ret);
+		return ret;
+	}
+
+	if (val != AF8133J_REG_PCODE_VAL) {
+		dev_err(dev, "Invalid product code (0x%02x)\n", val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int af8133j_reset(struct af8133j_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	if (data->reset_gpiod) {
+		/* If we have GPIO reset line, use it */
+		gpiod_set_value_cansleep(data->reset_gpiod, 1);
+		udelay(10);
+		gpiod_set_value_cansleep(data->reset_gpiod, 0);
+	} else {
+		/* Otherwise use software reset */
+		ret = regmap_write(data->regmap, AF8133J_REG_SWR,
+				   AF8133J_REG_SWR_PERFORM);
+		if (ret < 0) {
+			dev_err(dev, "Failed to reset the chip\n");
+			return ret;
+		}
+	}
+
+	/* Wait for reset to finish */
+	usleep_range(1000, 1100);
+
+	/* Restore range setting */
+	if (data->range == AF8133J_REG_RANGE_22G) {
+		ret = regmap_write(data->regmap, AF8133J_REG_RANGE, data->range);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void af8133j_power_down(struct af8133j_data *data)
+{
+	gpiod_set_value_cansleep(data->reset_gpiod, 1);
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+}
+
+static int af8133j_power_up(struct af8133j_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret) {
+		dev_err(dev, "Could not enable regulators\n");
+		return ret;
+	}
+
+	gpiod_set_value_cansleep(data->reset_gpiod, 0);
+
+	/* Wait for power on reset */
+	usleep_range(15000, 16000);
+
+	ret = af8133j_reset(data);
+	if (ret) {
+		af8133j_power_down(data);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int af8133j_take_measurement(struct af8133j_data *data)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_write(data->regmap,
+			   AF8133J_REG_STATE, AF8133J_REG_STATE_WORK);
+	if (ret < 0)
+		return ret;
+
+	/* The datasheet says "Mesaure Time <1.5ms" */
+	ret = regmap_read_poll_timeout(data->regmap, AF8133J_REG_STATUS, val,
+				       val & AF8133J_REG_STATUS_ACQ,
+				       500, 1500);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(data->regmap,
+			   AF8133J_REG_STATE, AF8133J_REG_STATE_STBY);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int af8133j_read_measurement(struct af8133j_data *data, __le16 buf[3])
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		/*
+		 * Ignore EACCES because that happens when RPM is disabled
+		 * during system sleep, while userspace leave eg. hrtimer
+		 * trigger attached and IIO core keeps trying to do measurements.
+		 */
+		if (ret != -EACCES)
+			dev_err(dev, "Failed to power on (%d)\n", ret);
+		return ret;
+	}
+
+	scoped_guard(mutex, &data->mutex) {
+		ret = af8133j_take_measurement(data);
+		if (ret)
+			goto out_rpm_put;
+
+		ret = regmap_bulk_read(data->regmap, AF8133J_REG_OUT,
+				       buf, sizeof(__le16) * 3);
+	}
+
+out_rpm_put:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static const int af8133j_scales[][2] = {
+	[0] = { 0, 366210 }, // 12 gauss
+	[1] = { 0, 671386 }, // 22 gauss
+};
+
+static int af8133j_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct af8133j_data *data = iio_priv(indio_dev);
+	__le16 buf[3];
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = af8133j_read_measurement(data, buf);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(le16_to_cpu(buf[chan->address]),
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+
+		if (data->range == AF8133J_REG_RANGE_12G)
+			*val2 = af8133j_scales[0][1];
+		else
+			*val2 = af8133j_scales[1][1];
+
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int af8133j_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)af8133j_scales;
+		*length = ARRAY_SIZE(af8133j_scales) * 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int af8133j_set_scale(struct af8133j_data *data,
+			     unsigned int val, unsigned int val2)
+{
+	struct device *dev = &data->client->dev;
+	u8 range;
+	int ret = 0;
+
+	if (af8133j_scales[0][0] == val && af8133j_scales[0][1] == val2)
+		range = AF8133J_REG_RANGE_12G;
+	else if (af8133j_scales[1][0] == val && af8133j_scales[1][1] == val2)
+		range = AF8133J_REG_RANGE_22G;
+	else
+		return -EINVAL;
+
+	pm_runtime_disable(dev);
+
+	/*
+	 * When suspended, just store the new range to data->range to be
+	 * applied later during power up.
+	 */
+	if (!pm_runtime_status_suspended(dev))
+		ret = regmap_write(data->regmap, AF8133J_REG_RANGE, range);
+
+	pm_runtime_enable(dev);
+
+	data->range = range;
+	return ret;
+}
+
+static int af8133j_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct af8133j_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		scoped_guard(mutex, &data->mutex)
+			ret = af8133j_set_scale(data, val, val2);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int af8133j_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static const struct iio_info af8133j_info = {
+	.read_raw = af8133j_read_raw,
+	.read_avail = af8133j_read_avail,
+	.write_raw = af8133j_write_raw,
+	.write_raw_get_fmt = af8133j_write_raw_get_fmt,
+};
+
+static irqreturn_t af8133j_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct af8133j_data *data = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns(indio_dev);
+	struct {
+		__le16 values[3];
+		s64 timestamp __aligned(8);
+	} sample;
+	int ret;
+
+	memset(&sample, 0, sizeof(sample));
+
+	ret = af8133j_read_measurement(data, sample.values);
+	if (ret)
+		goto out_done;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &sample, timestamp);
+
+out_done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static const struct regmap_config af8133j_regmap_config = {
+	.name = "af8133j_regmap",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AF8133J_REG_SWR,
+	.cache_type = REGCACHE_NONE,
+};
+
+static void af8133j_power_down_action(void *ptr)
+{
+	struct af8133j_data *data = ptr;
+	struct device *dev = &data->client->dev;
+
+	pm_runtime_disable(dev);
+	if (!pm_runtime_status_suspended(dev))
+		af8133j_power_down(data);
+	pm_runtime_enable(dev);
+}
+
+static int af8133j_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct af8133j_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret, i;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &af8133j_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "regmap initialization failed\n");
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+	data->range = AF8133J_REG_RANGE_12G;
+	mutex_init(&data->mutex);
+
+	data->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpiod))
+		return dev_err_probe(dev, PTR_ERR(data->reset_gpiod),
+				     "Failed to get reset gpio\n");
+
+	for (i = 0; i < ARRAY_SIZE(af8133j_supply_names); i++)
+		data->supplies[i].supply = af8133j_supply_names[i];
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
+				      data->supplies);
+	if (ret)
+		return ret;
+
+	ret = iio_read_mount_matrix(dev, &data->orientation);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read mount matrix\n");
+
+	ret = af8133j_power_up(data);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_active(dev);
+
+	ret = devm_add_action_or_reset(dev, af8133j_power_down_action, data);
+	if (ret)
+		return ret;
+
+	ret = af8133j_product_check(data);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &af8133j_info;
+	indio_dev->name = "af8133j";
+	indio_dev->channels = af8133j_channels;
+	indio_dev->num_channels = ARRAY_SIZE(af8133j_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      &af8133j_trigger_handler, NULL);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to setup iio triggered buffer\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register iio device");
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 500);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int af8133j_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct af8133j_data *data = iio_priv(indio_dev);
+
+	af8133j_power_down(data);
+
+	return 0;
+}
+
+static int af8133j_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct af8133j_data *data = iio_priv(indio_dev);
+
+	return af8133j_power_up(data);
+}
+
+const struct dev_pm_ops af8133j_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(af8133j_runtime_suspend, af8133j_runtime_resume, NULL)
+};
+
+static const struct of_device_id af8133j_of_match[] = {
+	{ .compatible = "voltafield,af8133j", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, af8133j_of_match);
+
+static const struct i2c_device_id af8133j_id[] = {
+	{ "af8133j", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, af8133j_id);
+
+static struct i2c_driver af8133j_driver = {
+	.driver = {
+		.name = "af8133j",
+		.of_match_table = af8133j_of_match,
+		.pm = pm_ptr(&af8133j_pm_ops),
+	},
+	.probe = af8133j_probe,
+	.id_table = af8133j_id,
+};
+
+module_i2c_driver(af8133j_driver);
+
+MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.io>");
+MODULE_AUTHOR("Ondřej Jirman <megi@xff.cz>");
+MODULE_DESCRIPTION("Voltafield AF8133J magnetic sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


