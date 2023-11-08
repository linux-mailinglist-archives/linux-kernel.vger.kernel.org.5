Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E917E57F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbjKHN12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjKHN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:27:25 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9577B1FC0;
        Wed,  8 Nov 2023 05:27:22 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94DF2C000B;
        Wed,  8 Nov 2023 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699450041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQLuZFQdMRFZFdhfwBAtb8c2sadoWU3zx6NaPWjqOg4=;
        b=hX9HqXM4t9P1SAQ1+H0ONsKDxSzgQ+dZ2qZAURaF76m3n1FerOiRf3oGzn0QlmudRZZRed
        +vBcKYCobDs7KJO1DAQqL11yZ61gpJqnuRVXAZMdoxZb1spf2LBkc+tVFIQP20Ns11VqlK
        dNTr8PrLt2hdhtbwpE2vmAyaSsq5ZSu+YG9/7TM8rJnYDwHiX2MhTI35c9X5BTBiCLCzik
        gkMq1jtVbGh5naWYGRC4SnWaQj7d8sHsDIk+X0aKnsjTkSiSpuPb4hwhxc0ti68kjia/LY
        lavvPI0DL5SX6fZB2Vn2mZrD6BMjyMY9g0zhfn1FoVsXZiat7Nl3B3HINO24gw==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v8 3/3] media: i2c: Introduce a driver for the Techwell TW9900 decoder
Date:   Wed,  8 Nov 2023 14:27:14 +0100
Message-ID: <93354996c95926970684498f08061b60a52bb84c.1699449537.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699449537.git.mehdi.djait@bootlin.com>
References: <cover.1699449537.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Techwell video decoder supports PAL, NTSC standards and
has a parallel BT.656 output interface.

This commit adds support for this device, with basic support
for NTSC and PAL, along with brightness and contrast controls.

The TW9900 is capable of automatic standard detection. This
driver is implemented with support for PAL and NTSC
autodetection.

Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
V7->V8: 
- added a mutex to Serialize access to hardware and current mode configuration
- added back pm_runtime
- split get_fmt and set_fmt callbacks 
- removed the tw9900_cancel_autodetect()

V6->V7: 
- added #include <linux/bitfield.h> to fix a Warning from the kernel
  robot
- removed a dev_info and replaced a dev_err by dev_err_probe

V5->V6: 
- dropped .skip_top and .field in the supported_modes
- added error handling for the i2c writes/reads
- added the colorimetry information to fill_fmt
- removed pm_runtime
- added the g_input_status callback
- dropped SECAM
- dropped the non-standard PAL/NTSC variants

V4->V5: 
- Added .querystd() and .g_tvnorms(), dropped the .open() and
  unified the g_fmt() / s_fmt().

V3->V4: 
- Fix a warning about an uninitialized ret variable in probe()

V2->V3: 
- Fix coding-style issues, and remove the use of the bulk API
  for regulators. Make the driver select the media-controller and
  V4L2-subdev APIs.

V1->V2: 
- Set the media entity type to decoder, and implement the
  s_std/g_std ops

 MAINTAINERS                |   6 +
 drivers/media/i2c/Kconfig  |  12 +
 drivers/media/i2c/Makefile |   1 +
 drivers/media/i2c/tw9900.c | 771 +++++++++++++++++++++++++++++++++++++
 4 files changed, 790 insertions(+)
 create mode 100644 drivers/media/i2c/tw9900.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b47e0b56859..c2e69b642609 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21142,6 +21142,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/ttusbir.c
 
+TECHWELL TW9900 VIDEO DECODER
+M:	Mehdi Djait <mehdi.djait@bootlin.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/media/i2c/tw9900.c
+
 TECHWELL TW9910 VIDEO DECODER
 L:	linux-media@vger.kernel.org
 S:	Orphan
diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 59ee0ca2c978..a9667428936e 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -1186,6 +1186,18 @@ config VIDEO_TW2804
 	  To compile this driver as a module, choose M here: the
 	  module will be called tw2804.
 
+config VIDEO_TW9900
+	tristate "Techwell TW9900 video decoder"
+	depends on VIDEO_DEV && I2C
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  Support for the Techwell tw9900 multi-standard video decoder.
+	  It supports NTSC, PAL standards with auto-detection features.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tw9900.
+
 config VIDEO_TW9903
 	tristate "Techwell TW9903 video decoder"
 	depends on VIDEO_DEV && I2C
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index f5010f80a21f..a17ee899a859 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -136,6 +136,7 @@ obj-$(CONFIG_VIDEO_TVP514X) += tvp514x.o
 obj-$(CONFIG_VIDEO_TVP5150) += tvp5150.o
 obj-$(CONFIG_VIDEO_TVP7002) += tvp7002.o
 obj-$(CONFIG_VIDEO_TW2804) += tw2804.o
+obj-$(CONFIG_VIDEO_TW9900) += tw9900.o
 obj-$(CONFIG_VIDEO_TW9903) += tw9903.o
 obj-$(CONFIG_VIDEO_TW9906) += tw9906.o
 obj-$(CONFIG_VIDEO_TW9910) += tw9910.o
diff --git a/drivers/media/i2c/tw9900.c b/drivers/media/i2c/tw9900.c
new file mode 100644
index 000000000000..6aa585da0864
--- /dev/null
+++ b/drivers/media/i2c/tw9900.c
@@ -0,0 +1,771 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Techwell TW9900 multi-standard video decoder.
+ *
+ * Copyright (C) 2018 Fuzhou Rockchip Electronics Co., Ltd.
+ * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
+ * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <media/media-entity.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-subdev.h>
+
+#define TW9900_REG_CHIP_ID	0x00
+#define TW9900_REG_CHIP_STATUS	0x01
+#define TW9900_REG_CHIP_STATUS_VDLOSS	BIT(7)
+#define TW9900_REG_CHIP_STATUS_HLOCK	BIT(6)
+#define TW9900_REG_OUT_FMT_CTL	0x03
+#define TW9900_REG_OUT_FMT_CTL_STANDBY		0xA7
+#define TW9900_REG_OUT_FMT_CTL_STREAMING	0xA0
+#define TW9900_REG_CKHY_HSDLY	0x04
+#define TW9900_REG_OUT_CTRL_I	0x05
+#define TW9900_REG_ANALOG_CTL	0x06
+#define TW9900_REG_CROP_HI	0x07
+#define TW9900_REG_VDELAY_LO	0x08
+#define TW9900_REG_VACTIVE_LO	0x09
+#define TW9900_REG_HACTIVE_LO	0x0B
+#define TW9900_REG_CNTRL1	0x0C
+#define TW9900_REG_BRIGHT_CTL	0x10
+#define TW9900_REG_CONTRAST_CTL	0x11
+#define TW9900_REG_VBI_CNTL	0x19
+#define TW9900_REG_ANAL_CTL_II	0x1A
+#define TW9900_REG_OUT_CTRL_II	0x1B
+#define TW9900_REG_STD_SEL	0x1C
+#define TW9900_REG_STD_SEL_AUTODETECT_IN_PROGRESS BIT(7)
+#define TW9900_STDNOW_MASK	GENMASK(6, 4)
+#define TW9900_REG_STDR		0x1D
+#define TW9900_REG_MISSCNT	0x26
+#define TW9900_REG_MISC_CTL_II	0x2F
+#define TW9900_REG_VVBI		0x55
+
+#define TW9900_CHIP_ID		0x00
+
+#define VSYNC_POLL_INTERVAL_MS	20
+#define VSYNC_WAIT_MAX_POLLS	50
+
+#define TW9900_STD_NTSC_M	0
+#define TW9900_STD_PAL_BDGHI	1
+#define TW9900_STD_AUTO		7
+
+#define TW9900_VIDEO_POLL_TRIES 20
+
+struct regval {
+	u8 addr;
+	u8 val;
+};
+
+struct tw9900_mode {
+	u32 width;
+	u32 height;
+	u32 std;
+	const struct regval *reg_list;
+	int n_regs;
+};
+
+struct tw9900 {
+	struct i2c_client *client;
+	struct gpio_desc *reset_gpio;
+	struct regulator *regulator;
+
+	bool streaming;
+
+	struct v4l2_subdev subdev;
+	struct v4l2_ctrl_handler hdl;
+	struct media_pad pad;
+
+	/* Serialize access to hardware and current mode configuration. */
+	struct mutex mutex;
+
+	const struct tw9900_mode *cur_mode;
+};
+
+#define to_tw9900(sd) container_of(sd, struct tw9900, subdev)
+
+static const struct regval tw9900_init_regs[] = {
+	{ TW9900_REG_MISC_CTL_II,	0xE6 },
+	{ TW9900_REG_MISSCNT,		0x24 },
+	{ TW9900_REG_OUT_FMT_CTL,	0xA7 },
+	{ TW9900_REG_ANAL_CTL_II,	0x0A },
+	{ TW9900_REG_VDELAY_LO,		0x19 },
+	{ TW9900_REG_STD_SEL,		0x00 },
+	{ TW9900_REG_VACTIVE_LO,	0xF0 },
+	{ TW9900_REG_STD_SEL,		0x07 },
+	{ TW9900_REG_CKHY_HSDLY,	0x00 },
+	{ TW9900_REG_ANALOG_CTL,	0x80 },
+	{ TW9900_REG_CNTRL1,		0xDC },
+	{ TW9900_REG_OUT_CTRL_I,	0x98 },
+};
+
+static const struct regval tw9900_pal_regs[] = {
+	{ TW9900_REG_STD_SEL,		0x01 },
+};
+
+static const struct regval tw9900_ntsc_regs[] = {
+	{ TW9900_REG_OUT_FMT_CTL,	0xA4 },
+	{ TW9900_REG_VDELAY_LO,		0x12 },
+	{ TW9900_REG_VACTIVE_LO,	0xF0 },
+	{ TW9900_REG_CROP_HI,		0x02 },
+	{ TW9900_REG_HACTIVE_LO,	0xD0 },
+	{ TW9900_REG_VBI_CNTL,		0x01 },
+	{ TW9900_REG_STD_SEL,		0x00 },
+};
+
+static const struct tw9900_mode supported_modes[] = {
+	{
+		.width = 720,
+		.height = 480,
+		.std = V4L2_STD_NTSC,
+		.reg_list = tw9900_ntsc_regs,
+		.n_regs = ARRAY_SIZE(tw9900_ntsc_regs),
+	},
+	{
+		.width = 720,
+		.height = 576,
+		.std = V4L2_STD_PAL,
+		.reg_list = tw9900_pal_regs,
+		.n_regs = ARRAY_SIZE(tw9900_pal_regs),
+	},
+};
+
+static int tw9900_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, reg, val);
+	if (ret < 0)
+		dev_err(&client->dev, "write reg error: %d\n", ret);
+
+	return ret;
+}
+
+static int tw9900_write_array(struct i2c_client *client,
+			      const struct regval *regs, int n_regs)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < n_regs; i++) {
+		ret = tw9900_write_reg(client, regs[i].addr, regs[i].val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tw9900_read_reg(struct i2c_client *client, u8 reg)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, reg);
+	if (ret < 0)
+		dev_err(&client->dev, "read reg error: %d\n", ret);
+
+	return ret;
+}
+
+static void tw9900_fill_fmt(const struct tw9900_mode *mode,
+			    struct v4l2_mbus_framefmt *fmt)
+{
+	fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
+	fmt->width = mode->width;
+	fmt->height = mode->height;
+	fmt->field = V4L2_FIELD_NONE;
+	fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
+	fmt->colorspace = V4L2_COLORSPACE_SMPTE170M;
+	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SMPTE170M);
+	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SMPTE170M);
+}
+
+static int tw9900_get_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *sd_state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct tw9900 *tw9900 = to_tw9900(sd);
+	struct v4l2_mbus_framefmt *mbus_fmt = &fmt->format;
+
+	mutex_lock(&tw9900->mutex);
+	tw9900_fill_fmt(tw9900->cur_mode, mbus_fmt);
+	mutex_unlock(&tw9900->mutex);
+
+	return 0;
+}
+
+static int tw9900_set_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *sd_state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct tw9900 *tw9900 = to_tw9900(sd);
+
+	if (tw9900->streaming)
+		return -EBUSY;
+
+	return tw9900_get_fmt(sd, sd_state, fmt);
+}
+
+static int tw9900_enum_mbus_code(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *sd_state,
+				 struct v4l2_subdev_mbus_code_enum *code)
+{
+	if (code->index > 0)
+		return -EINVAL;
+
+	code->code = MEDIA_BUS_FMT_UYVY8_2X8;
+
+	return 0;
+}
+
+static int tw9900_power_on(struct tw9900 *tw9900)
+{
+	int ret;
+
+	if (tw9900->reset_gpio)
+		gpiod_set_value_cansleep(tw9900->reset_gpio, 1);
+
+	ret = regulator_enable(tw9900->regulator);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(50000, 52000);
+
+	if (tw9900->reset_gpio)
+		gpiod_set_value_cansleep(tw9900->reset_gpio, 0);
+
+	usleep_range(1000, 2000);
+
+	mutex_lock(&tw9900->mutex);
+	ret = tw9900_write_array(tw9900->client, tw9900_init_regs,
+				 ARRAY_SIZE(tw9900_init_regs));
+	mutex_unlock(&tw9900->mutex);
+
+	/* This sleep is needed for the Horizontal Sync PLL to lock. */
+	msleep(300);
+
+	return ret;
+}
+
+static void tw9900_power_off(struct tw9900 *tw9900)
+{
+	if (tw9900->reset_gpio)
+		gpiod_set_value_cansleep(tw9900->reset_gpio, 1);
+
+	regulator_disable(tw9900->regulator);
+}
+
+static int tw9900_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct tw9900 *tw9900 = container_of(ctrl->handler, struct tw9900, hdl);
+	int ret;
+
+	if (pm_runtime_suspended(&tw9900->client->dev))
+		return 0;
+
+	/* v4l2_ctrl_lock() locks tw9900->mutex. */
+	switch (ctrl->id) {
+	case V4L2_CID_BRIGHTNESS:
+		ret = tw9900_write_reg(tw9900->client, TW9900_REG_BRIGHT_CTL,
+				       (u8)ctrl->val);
+		break;
+	case V4L2_CID_CONTRAST:
+		ret = tw9900_write_reg(tw9900->client, TW9900_REG_CONTRAST_CTL,
+				       (u8)ctrl->val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tw9900_s_stream(struct v4l2_subdev *sd, int on)
+{
+	struct tw9900 *tw9900 = to_tw9900(sd);
+	struct i2c_client *client = tw9900->client;
+	int ret;
+
+	if (tw9900->streaming == on)
+		return 0;
+
+	if (on) {
+		ret = pm_runtime_get_sync(&client->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(&client->dev);
+			return ret;
+		}
+
+		mutex_lock(&tw9900->mutex);
+
+		ret = __v4l2_ctrl_handler_setup(sd->ctrl_handler);
+		if (ret)
+			goto err_unlock;
+
+		ret = tw9900_write_array(tw9900->client,
+					 tw9900->cur_mode->reg_list,
+					 tw9900->cur_mode->n_regs);
+		if (ret)
+			goto err_unlock;
+
+		ret = tw9900_write_reg(client, TW9900_REG_OUT_FMT_CTL,
+				       TW9900_REG_OUT_FMT_CTL_STREAMING);
+		if (ret)
+			goto err_unlock;
+
+	} else {
+		mutex_lock(&tw9900->mutex);
+
+		ret = tw9900_write_reg(client, TW9900_REG_OUT_FMT_CTL,
+				       TW9900_REG_OUT_FMT_CTL_STANDBY);
+		if (ret)
+			goto err_unlock;
+
+		pm_runtime_put(&client->dev);
+	}
+
+	tw9900->streaming = on;
+	mutex_unlock(&tw9900->mutex);
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&tw9900->mutex);
+	pm_runtime_put(&client->dev);
+
+	return ret;
+}
+
+static int tw9900_runtime_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct tw9900 *tw9900 = to_tw9900(sd);
+
+	return tw9900_power_on(tw9900);
+}
+
+static int tw9900_runtime_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct tw9900 *tw9900 = to_tw9900(sd);
+
+	tw9900_power_off(tw9900);
+
+	return 0;
+}
+
+static int tw9900_subscribe_event(struct v4l2_subdev *sd,
+				  struct v4l2_fh *fh,
+				  struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_SOURCE_CHANGE:
+		return v4l2_src_change_event_subdev_subscribe(sd, fh, sub);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subdev_subscribe_event(sd, fh, sub);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tw9900_s_std(struct v4l2_subdev *sd, v4l2_std_id std)
+{
+	struct tw9900 *tw9900 = to_tw9900(sd);
+	const struct tw9900_mode *mode;
+	int i, ret = 0;
+
+	if (!(std & (V4L2_STD_NTSC | V4L2_STD_PAL)))
+		return -EINVAL;
+
+	mutex_lock(&tw9900->mutex);
+
+	for (i = 0; i < ARRAY_SIZE(supported_modes); i++)
+		if (supported_modes[i].std & std)
+			mode = &supported_modes[i];
+	if (!mode) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	tw9900->cur_mode = mode;
+
+out_unlock:
+	mutex_unlock(&tw9900->mutex);
+
+	return ret;
+}
+
+static int tw9900_get_stream_std(struct tw9900 *tw9900,
+				 v4l2_std_id *std)
+{
+	int cur_std, ret;
+
+	lockdep_assert_held(&tw9900->mutex);
+
+	ret = tw9900_read_reg(tw9900->client, TW9900_REG_STD_SEL);
+	if (ret < 0) {
+		*std = V4L2_STD_UNKNOWN;
+		return ret;
+	}
+
+	cur_std = FIELD_GET(TW9900_STDNOW_MASK, ret);
+	switch (cur_std) {
+	case TW9900_STD_NTSC_M:
+		*std = V4L2_STD_NTSC;
+		break;
+	case TW9900_STD_PAL_BDGHI:
+		*std = V4L2_STD_PAL;
+		break;
+	case TW9900_STD_AUTO:
+		*std = V4L2_STD_UNKNOWN;
+		break;
+	default:
+		*std = V4L2_STD_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
+
+static int tw9900_g_std(struct v4l2_subdev *sd, v4l2_std_id *std)
+{
+	struct tw9900 *tw9900 = to_tw9900(sd);
+
+	mutex_lock(&tw9900->mutex);
+	*std = tw9900->cur_mode->std;
+	mutex_unlock(&tw9900->mutex);
+
+	return 0;
+}
+
+static int tw9900_start_autodetect(struct tw9900 *tw9900)
+{
+	int ret;
+
+	lockdep_assert_held(&tw9900->mutex);
+
+	ret = tw9900_write_reg(tw9900->client, TW9900_REG_STDR,
+			       BIT(TW9900_STD_NTSC_M) |
+			       BIT(TW9900_STD_PAL_BDGHI));
+	if (ret)
+		return ret;
+
+	ret = tw9900_write_reg(tw9900->client, TW9900_REG_STD_SEL,
+			       TW9900_STD_AUTO);
+	if (ret)
+		return ret;
+
+	ret = tw9900_write_reg(tw9900->client, TW9900_REG_STDR,
+			       BIT(TW9900_STD_NTSC_M) |
+			       BIT(TW9900_STD_PAL_BDGHI) |
+			       BIT(TW9900_STD_AUTO));
+	if (ret)
+		return ret;
+
+	/*
+	 * Autodetect takes a while to start, and during the starting sequence
+	 * the autodetection status is reported as done.
+	 */
+	msleep(30);
+
+	return 0;
+}
+
+static int tw9900_detect_done(struct tw9900 *tw9900, bool *done)
+{
+	int ret;
+
+	lockdep_assert_held(&tw9900->mutex);
+
+	ret = tw9900_read_reg(tw9900->client, TW9900_REG_STD_SEL);
+	if (ret < 0)
+		return ret;
+
+	*done = !(ret & TW9900_REG_STD_SEL_AUTODETECT_IN_PROGRESS);
+
+	return 0;
+}
+
+static int tw9900_querystd(struct v4l2_subdev *sd, v4l2_std_id *std)
+{
+	struct tw9900 *tw9900 = to_tw9900(sd);
+	bool done = false;
+	int i, ret;
+
+	if (tw9900->streaming)
+		return -EBUSY;
+
+	ret = pm_runtime_get_sync(&tw9900->client->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&tw9900->client->dev);
+		return ret;
+	}
+
+	mutex_lock(&tw9900->mutex);
+
+	ret = tw9900_start_autodetect(tw9900);
+	if (ret)
+		goto out_unlock;
+
+	for (i = 0; i < TW9900_VIDEO_POLL_TRIES; i++) {
+		ret = tw9900_detect_done(tw9900, &done);
+		if (ret)
+			goto out_unlock;
+
+		if (done)
+			break;
+
+		msleep(20);
+	}
+
+	if (!done) {
+		ret = -ETIMEDOUT;
+		goto out_unlock;
+	}
+
+	ret = tw9900_get_stream_std(tw9900, std);
+
+out_unlock:
+	mutex_unlock(&tw9900->mutex);
+	pm_runtime_put(&tw9900->client->dev);
+
+	return ret;
+}
+
+static int tw9900_g_tvnorms(struct v4l2_subdev *sd, v4l2_std_id *std)
+{
+	*std = V4L2_STD_NTSC | V4L2_STD_PAL;
+
+	return 0;
+}
+
+static const struct dev_pm_ops tw9900_pm_ops = {
+	SET_RUNTIME_PM_OPS(tw9900_runtime_suspend,
+			   tw9900_runtime_resume, NULL)
+};
+
+static int tw9900_g_input_status(struct v4l2_subdev *sd, u32 *status)
+{
+	struct tw9900 *tw9900 = to_tw9900(sd);
+	int ret;
+
+	*status = V4L2_IN_ST_NO_SIGNAL;
+
+	ret = pm_runtime_get_sync(&tw9900->client->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&tw9900->client->dev);
+		return ret;
+	}
+
+	mutex_lock(&tw9900->mutex);
+	ret = tw9900_read_reg(tw9900->client, TW9900_REG_CHIP_STATUS);
+	mutex_unlock(&tw9900->mutex);
+
+	if (ret < 0) {
+		pm_runtime_put(&tw9900->client->dev);
+		return ret;
+	}
+
+	*status = ret & TW9900_REG_CHIP_STATUS_HLOCK ? 0 : V4L2_IN_ST_NO_SIGNAL;
+
+	pm_runtime_put(&tw9900->client->dev);
+
+	return 0;
+}
+
+static const struct v4l2_subdev_core_ops tw9900_core_ops = {
+	.subscribe_event	= tw9900_subscribe_event,
+	.unsubscribe_event	= v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_video_ops tw9900_video_ops = {
+	.s_std		= tw9900_s_std,
+	.g_std		= tw9900_g_std,
+	.querystd	= tw9900_querystd,
+	.g_tvnorms	= tw9900_g_tvnorms,
+	.g_input_status = tw9900_g_input_status,
+	.s_stream	= tw9900_s_stream,
+};
+
+static const struct v4l2_subdev_pad_ops tw9900_pad_ops = {
+	.enum_mbus_code		= tw9900_enum_mbus_code,
+	.get_fmt		= tw9900_get_fmt,
+	.set_fmt		= tw9900_set_fmt,
+};
+
+static const struct v4l2_subdev_ops tw9900_subdev_ops = {
+	.core	= &tw9900_core_ops,
+	.video	= &tw9900_video_ops,
+	.pad	= &tw9900_pad_ops,
+};
+
+static const struct v4l2_ctrl_ops tw9900_ctrl_ops = {
+	.s_ctrl	= tw9900_s_ctrl,
+};
+
+static int tw9900_check_id(struct tw9900 *tw9900,
+			   struct i2c_client *client)
+{
+	struct device *dev = &tw9900->client->dev;
+	int ret;
+
+	mutex_lock(&tw9900->mutex);
+	ret = tw9900_read_reg(client, TW9900_CHIP_ID);
+	mutex_unlock(&tw9900->mutex);
+
+	if (ret < 0)
+		return ret;
+
+	if (ret != TW9900_CHIP_ID) {
+		dev_err(dev, "Unexpected decoder id %#x\n", ret);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int tw9900_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct v4l2_ctrl_handler *hdl;
+	struct tw9900 *tw9900;
+	int ret = 0;
+
+	tw9900 = devm_kzalloc(dev, sizeof(*tw9900), GFP_KERNEL);
+	if (!tw9900)
+		return -ENOMEM;
+
+	tw9900->client = client;
+	tw9900->cur_mode = &supported_modes[0];
+
+	tw9900->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(tw9900->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(tw9900->reset_gpio),
+				     "Failed to get reset gpio\n");
+
+	tw9900->regulator = devm_regulator_get(&tw9900->client->dev, "vdd");
+	if (IS_ERR(tw9900->regulator))
+		return dev_err_probe(dev, PTR_ERR(tw9900->regulator),
+				     "Failed to get power regulator\n");
+
+	v4l2_i2c_subdev_init(&tw9900->subdev, client, &tw9900_subdev_ops);
+	tw9900->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
+				V4L2_SUBDEV_FL_HAS_EVENTS;
+
+	mutex_init(&tw9900->mutex);
+
+	hdl = &tw9900->hdl;
+
+	ret = v4l2_ctrl_handler_init(hdl, 2);
+	if (ret)
+		return ret;
+
+	hdl->lock = &tw9900->mutex;
+
+	v4l2_ctrl_new_std(hdl, &tw9900_ctrl_ops, V4L2_CID_BRIGHTNESS,
+			  -128, 127, 1, 0);
+	v4l2_ctrl_new_std(hdl, &tw9900_ctrl_ops, V4L2_CID_CONTRAST,
+			  0, 255, 1, 0x60);
+
+	tw9900->subdev.ctrl_handler = hdl;
+	if (hdl->error) {
+		ret = hdl->error;
+		goto err_free_handler;
+	}
+
+	ret = tw9900_power_on(tw9900);
+	if (ret)
+		goto err_free_handler;
+
+	ret = tw9900_check_id(tw9900, client);
+	if (ret)
+		goto err_power_off;
+
+	tw9900->pad.flags = MEDIA_PAD_FL_SOURCE;
+	tw9900->subdev.entity.function = MEDIA_ENT_F_DV_DECODER;
+
+	ret = media_entity_pads_init(&tw9900->subdev.entity, 1, &tw9900->pad);
+	if (ret < 0)
+		goto err_power_off;
+
+	ret = v4l2_async_register_subdev(&tw9900->subdev);
+	if (ret) {
+		dev_err(dev, "v4l2 async register subdev failed\n");
+		goto err_clean_entity;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
+	return 0;
+
+err_clean_entity:
+	media_entity_cleanup(&tw9900->subdev.entity);
+err_power_off:
+	tw9900_power_off(tw9900);
+err_free_handler:
+	v4l2_ctrl_handler_free(hdl);
+	mutex_destroy(&tw9900->mutex);
+
+	return ret;
+}
+
+static void tw9900_remove(struct i2c_client *client)
+{
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct tw9900 *tw9900 = to_tw9900(sd);
+
+	v4l2_async_unregister_subdev(sd);
+	media_entity_cleanup(&sd->entity);
+	v4l2_ctrl_handler_free(sd->ctrl_handler);
+
+	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev))
+		tw9900_power_off(tw9900);
+
+	pm_runtime_set_suspended(&client->dev);
+	mutex_destroy(&tw9900->mutex);
+}
+
+static const struct i2c_device_id tw9900_id[] = {
+	{ "tw9900", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tw9900_id);
+
+static const struct of_device_id tw9900_of_match[] = {
+	{ .compatible = "techwell,tw9900" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tw9900_of_match);
+
+static struct i2c_driver tw9900_i2c_driver = {
+	.driver = {
+		.name		= "tw9900",
+		.pm		= &tw9900_pm_ops,
+		.of_match_table	= tw9900_of_match,
+	},
+	.probe	  = tw9900_probe,
+	.remove	  = tw9900_remove,
+	.id_table = tw9900_id,
+};
+
+module_i2c_driver(tw9900_i2c_driver);
+
+MODULE_DESCRIPTION("tw9900 decoder driver");
+MODULE_LICENSE("GPL");
-- 
2.41.0

