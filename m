Return-Path: <linux-kernel+bounces-60716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0D48508D8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A10B1F2206E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1455A781;
	Sun, 11 Feb 2024 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="lSTo42tk";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="s7psO4HT"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74025A4CB;
	Sun, 11 Feb 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650797; cv=pass; b=XyoO0qxUcAwZ4SSWlJreocgELWlWmZwzzEgl79UyhdJ5Gjacqji5hz9OQC0pelm0N9XXK/qLDkt03UY6bG9KHVnw1tK8dgK+R/ATzxUX5A65WuCBiSTqA1PteFzg9Hu/8ZK+Y3mNNE+Ih1C85nxK25Eg8neq3ZAuJKp1Y1uzSJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650797; c=relaxed/simple;
	bh=4SWQUKmQtmoWQXzQQMMtE1DYO8jXvHaMTdz8cPnTd+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YnKGmoQEXG3vRqS+2g/bajPMT2LfkNnePN7dizF/WGZoH/HSVQZoeIuuGAOPEdiJFXmlj9sKqQghgbBtzeMSpk/aFTADbH0S/DqqLoBoCanuHMVQXOjqlueAP0iok1G6Fa+xxMd6xZq/DsxiRqRtXxx6SP8NOCN1pSbUQUPopsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=lSTo42tk; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=s7psO4HT; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1707650777; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PcI2lXVJKxM/BrrG28+piWwRO51Sw9CnTp+D5tRz1qjVTqapHDEQSHariAdFpMMLmm
    KtF98vyQv3PIR9oRgcds6g9LAa3FYor1P1O7dWEaZmznYwfWLvHfXJpeohCIFJczNrDa
    6ctAUUDIMEcFsf+esp7hGQTe/2lh0YqrHABqmHVKi7JEF2L7rhNnuq4EDXnDYhBhFooa
    LdsIcJf3tLXB+7Uc0V7upByHIPGbHQE7x6BZRowL8+ZPVQ98wK2d2jYZJOxwRYIeTWXM
    uzI3BW5gKj5B327ru/xK3jtGfFVEhUq5JXm+lObuuR+VV1ZL0qPrZKp9GPnYJvH8MBHC
    I6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707650777;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=S5Ljm+XPD97kVHXzfli1JWTSSsP8Gsn2YEl2BbOwS8w=;
    b=gUMH+AMhLScZ0QwTT6bbvx5R/MdExbY/QXocFXSivyX1qor7FIbPiXskjO/BDKu0Ir
    ui4/JJY/YQOXTzqooZUqHeT+5blN0YTZ6/ViImPzBEFnjQbu+sWUbRq3m50a7q/gADl/
    rsXz+Xx0O9F6jNIz/zNBmVYFOx90BO18EshKNXGwi9Ar/MtVsdsxOoy7IMiNcblj27Uj
    mPWbxYk8g6ijxJ5uSlKmGryzGgSSzxyTm6ZeGiAxL7CHDNvvynHYd2sIcodkc53bOpa5
    aP4UkIjIVuAeATHNJEGlYvpaYp6ACNP36ICZ8WWKA9SNdXu+BUD3UfXLRnxoIa3enT+X
    jqxg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707650777;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=S5Ljm+XPD97kVHXzfli1JWTSSsP8Gsn2YEl2BbOwS8w=;
    b=lSTo42tk3dVsE4RNvOksIiZXVWFWXAoJs2Pp7vmwyuXWAft1iNDGW8RVS3Z7hlBj+i
    oAxsPGIHFyJgy6zrcil/ZqQr3A/a60ykJZ3hOaWL89h9k55Ue1GQ5N3wBY+da77blSA8
    dHgRDZxiTWg2vZ+82+ftkTwlqeuOU0xxsk4w7OpDtRXhAu+ayzAyISPIfUmygMTJ6VLp
    WeX6uHrnMNRoQnk9TZhE+Kr14Jd6X/Iy9ZO69lAf3tIwOIoJSV5PuZjLQNtDL4yDXiGC
    6Bs0tjqZl81i9sLf1+FlUVgCJwkFK9cuEptkfgEA97FObfu6jIdA5dmC64nbhAjTODJQ
    D2uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707650777;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=S5Ljm+XPD97kVHXzfli1JWTSSsP8Gsn2YEl2BbOwS8w=;
    b=s7psO4HTn3xQqyOxPexvbxeDPycNF8/4ik3zAnMBd6SosPnYOsvM7+t5FsrA8UYYYO
    zWeFJiiJ7kWtepWs8GBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p3mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.11.2 DYNA|AUTH)
    with ESMTPSA id ze34f101BBQGwzu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 11 Feb 2024 12:26:16 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
Date: Sun, 11 Feb 2024 12:25:51 +0100
Subject: [PATCH RESEND v3 2/2] Input: add Himax HX852x(ES) touchscreen
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-hx852x-v3-2-f682e2fcf11d@gerhold.net>
References: <20240211-hx852x-v3-0-f682e2fcf11d@gerhold.net>
In-Reply-To: <20240211-hx852x-v3-0-f682e2fcf11d@gerhold.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.4

From: Jonathan Albrieux <jonathan.albrieux@gmail.com>

Add a simple driver for the Himax HX852x(ES) touch panel controller,
with support for multi-touch and capacitive touch keys.

The driver is somewhat based on sample code from Himax. However, that
code was so extremely confusing that we spent a significant amount of
time just trying to understand the packet format and register commands.
In this driver they are described with clean structs and defines rather
than lots of magic numbers and offset calculations.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 MAINTAINERS                              |   7 +
 drivers/input/touchscreen/Kconfig        |  10 +
 drivers/input/touchscreen/Makefile       |   1 +
 drivers/input/touchscreen/himax_hx852x.c | 500 +++++++++++++++++++++++++++++++
 4 files changed, 518 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0595c832c248..2460736e3b21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9271,6 +9271,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
 F:	drivers/input/touchscreen/himax_hx83112b.c
 
+HIMAX HX852X TOUCHSCREEN DRIVER
+M:	Stephan Gerhold <stephan@gerhold.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml
+F:	drivers/input/touchscreen/himax_hx852x.c
+
 HIPPI
 M:	Jes Sorensen <jes@trained-monkey.org>
 L:	linux-hippi@sunsite.dk
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index c821fe3ee794..1ae3113fd4d7 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -458,6 +458,16 @@ config TOUCHSCREEN_HIDEEP
 	  To compile this driver as a module, choose M here : the
 	  module will be called hideep_ts.
 
+config TOUCHSCREEN_HIMAX_HX852X
+	tristate "Himax HX852x(ES) touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have a Himax HX852x(ES) touchscreen.
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called himax_hx852x.
+
 config TOUCHSCREEN_HYCON_HY46XX
 	tristate "Hycon hy46xx touchscreen support"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index a81cb5aa21a5..5d7c10858ffb 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI)	+= goodix_berlin_spi.o
 obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
+obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX852X)	+= himax_hx852x.o
 obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
 obj-$(CONFIG_TOUCHSCREEN_ILITEK)	+= ilitek_ts_i2c.o
diff --git a/drivers/input/touchscreen/himax_hx852x.c b/drivers/input/touchscreen/himax_hx852x.c
new file mode 100644
index 000000000000..6aa39f02829d
--- /dev/null
+++ b/drivers/input/touchscreen/himax_hx852x.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Himax HX852x(ES) Touchscreen Driver
+ * Copyright (c) 2020-2023 Stephan Gerhold <stephan@gerhold.net>
+ * Copyright (c) 2020 Jonathan Albrieux <jonathan.albrieux@gmail.com>
+ *
+ * Based on the Himax Android Driver Sample Code Ver 0.3 for HMX852xES chipset:
+ * Copyright (c) 2014 Himax Corporation.
+ */
+
+#include <asm/unaligned.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#define HX852X_COORD_SIZE(fingers)	((fingers) * sizeof(struct hx852x_coord))
+#define HX852X_WIDTH_SIZE(fingers)	ALIGN(fingers, 4)
+#define HX852X_BUF_SIZE(fingers)	(HX852X_COORD_SIZE(fingers) + \
+					 HX852X_WIDTH_SIZE(fingers) + \
+					 sizeof(struct hx852x_touch_info))
+
+#define HX852X_MAX_FINGERS		12
+#define HX852X_MAX_KEY_COUNT		4
+#define HX852X_MAX_BUF_SIZE		HX852X_BUF_SIZE(HX852X_MAX_FINGERS)
+
+#define HX852X_TS_SLEEP_IN		0x80
+#define HX852X_TS_SLEEP_OUT		0x81
+#define HX852X_TS_SENSE_OFF		0x82
+#define HX852X_TS_SENSE_ON		0x83
+#define HX852X_READ_ONE_EVENT		0x85
+#define HX852X_READ_ALL_EVENTS		0x86
+#define HX852X_READ_LATEST_EVENT	0x87
+#define HX852X_CLEAR_EVENT_STACK	0x88
+
+#define HX852X_REG_SRAM_SWITCH		0x8c
+#define HX852X_REG_SRAM_ADDR		0x8b
+#define HX852X_REG_FLASH_RPLACE		0x5a
+
+#define HX852X_SRAM_SWITCH_TEST_MODE	0x14
+#define HX852X_SRAM_ADDR_CONFIG		0x7000
+
+struct hx852x {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	struct touchscreen_properties props;
+	struct gpio_desc *reset_gpiod;
+	struct regulator_bulk_data supplies[2];
+	unsigned int max_fingers;
+	unsigned int keycount;
+	unsigned int keycodes[HX852X_MAX_KEY_COUNT];
+};
+
+struct hx852x_config {
+	u8 rx_num;
+	u8 tx_num;
+	u8 max_pt;
+	u8 padding1[3];
+	__be16 x_res;
+	__be16 y_res;
+	u8 padding2[2];
+} __packed __aligned(4);
+
+struct hx852x_coord {
+	__be16 x;
+	__be16 y;
+} __packed __aligned(4);
+
+struct hx852x_touch_info {
+	u8 finger_num;
+	__le16 finger_pressed;
+	u8 padding;
+} __packed __aligned(4);
+
+static int hx852x_i2c_read(struct hx852x *hx, u8 cmd, void *data, u16 len)
+{
+	struct i2c_client *client = hx->client;
+	int ret;
+
+	struct i2c_msg msg[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &cmd,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = len,
+			.buf = data,
+		},
+	};
+
+	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		dev_err(&client->dev, "failed to read %#x: %d\n", cmd, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hx852x_power_on(struct hx852x *hx)
+{
+	struct device *dev = &hx->client->dev;
+	int error;
+
+	error = regulator_bulk_enable(ARRAY_SIZE(hx->supplies), hx->supplies);
+	if (error) {
+		dev_err(dev, "failed to enable regulators: %d\n", error);
+		return error;
+	}
+
+	gpiod_set_value_cansleep(hx->reset_gpiod, 1);
+	msleep(20);
+	gpiod_set_value_cansleep(hx->reset_gpiod, 0);
+	msleep(20);
+
+	return 0;
+}
+
+static int hx852x_start(struct hx852x *hx)
+{
+	struct device *dev = &hx->client->dev;
+	int error;
+
+	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_OUT);
+	if (error) {
+		dev_err(dev, "failed to send TS_SLEEP_OUT: %d\n", error);
+		return error;
+	}
+	msleep(30);
+
+	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_ON);
+	if (error) {
+		dev_err(dev, "failed to send TS_SENSE_ON: %d\n", error);
+		return error;
+	}
+	msleep(20);
+
+	return 0;
+}
+
+static int hx852x_stop(struct hx852x *hx)
+{
+	struct device *dev = &hx->client->dev;
+	int error;
+
+	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_OFF);
+	if (error) {
+		dev_err(dev, "failed to send TS_SENSE_OFF: %d\n", error);
+		return error;
+	}
+	msleep(20);
+
+	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_IN);
+	if (error) {
+		dev_err(dev, "failed to send TS_SLEEP_IN: %d\n", error);
+		return error;
+	}
+	msleep(30);
+
+	return 0;
+}
+
+static int hx852x_power_off(struct hx852x *hx)
+{
+	struct device *dev = &hx->client->dev;
+	int error;
+
+	error = regulator_bulk_disable(ARRAY_SIZE(hx->supplies), hx->supplies);
+	if (error) {
+		dev_err(dev, "failed to disable regulators: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int hx852x_read_config(struct hx852x *hx)
+{
+	struct device *dev = &hx->client->dev;
+	struct hx852x_config conf;
+	int x_res, y_res;
+	int error;
+
+	error = hx852x_power_on(hx);
+	if (error)
+		return error;
+
+	/* Sensing must be turned on briefly to load the config */
+	error = hx852x_start(hx);
+	if (error)
+		goto err_power_off;
+
+	error = hx852x_stop(hx);
+	if (error)
+		goto err_power_off;
+
+	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH,
+					  HX852X_SRAM_SWITCH_TEST_MODE);
+	if (error)
+		goto err_power_off;
+
+	error = i2c_smbus_write_word_data(hx->client, HX852X_REG_SRAM_ADDR,
+					  HX852X_SRAM_ADDR_CONFIG);
+	if (error)
+		goto err_test_mode;
+
+	error = hx852x_i2c_read(hx, HX852X_REG_FLASH_RPLACE, &conf, sizeof(conf));
+	if (error)
+		goto err_test_mode;
+
+	x_res = be16_to_cpu(conf.x_res);
+	y_res = be16_to_cpu(conf.y_res);
+	hx->max_fingers = (conf.max_pt & 0xf0) >> 4;
+	dev_dbg(dev, "x res: %u, y res: %u, max fingers: %u\n",
+		x_res, y_res, hx->max_fingers);
+
+	if (hx->max_fingers > HX852X_MAX_FINGERS) {
+		dev_err(dev, "max supported fingers: %u, found: %u\n",
+			HX852X_MAX_FINGERS, hx->max_fingers);
+		error = -EINVAL;
+		goto err_test_mode;
+	}
+
+	if (x_res && y_res) {
+		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_X, 0, x_res - 1, 0, 0);
+		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_Y, 0, y_res - 1, 0, 0);
+	}
+
+err_test_mode:
+	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0) ? : error;
+err_power_off:
+	return hx852x_power_off(hx) ? : error;
+}
+
+static int hx852x_handle_events(struct hx852x *hx)
+{
+	/*
+	 * The event packets have variable size, depending on the amount of
+	 * supported fingers (hx->max_fingers). They are laid out as follows:
+	 *  - struct hx852x_coord[hx->max_fingers]: Coordinates for each finger
+	 *  - u8[ALIGN(hx->max_fingers, 4)]: Touch width for each finger
+	 *      with padding for 32-bit alignment
+	 *  - struct hx852x_touch_info
+	 *
+	 * Load everything into a 32-bit aligned buffer so the coordinates
+	 * can be assigned directly, without using get_unaligned_*().
+	 */
+	u8 buf[HX852X_MAX_BUF_SIZE] __aligned(4);
+	struct hx852x_coord *coord = (struct hx852x_coord *)buf;
+	u8 *width = &buf[HX852X_COORD_SIZE(hx->max_fingers)];
+	struct hx852x_touch_info *info = (struct hx852x_touch_info *)
+		&width[HX852X_WIDTH_SIZE(hx->max_fingers)];
+	unsigned long finger_pressed, key_pressed;
+	unsigned int i, x, y, w;
+	int error;
+
+	error = hx852x_i2c_read(hx, HX852X_READ_ALL_EVENTS, buf,
+				HX852X_BUF_SIZE(hx->max_fingers));
+	if (error)
+		return error;
+
+	finger_pressed = get_unaligned_le16(&info->finger_pressed);
+	key_pressed = finger_pressed >> HX852X_MAX_FINGERS;
+
+	/* All bits are set when no touch is detected */
+	if (info->finger_num == 0xff || !(info->finger_num & 0x0f))
+		finger_pressed = 0;
+	if (key_pressed == 0xf)
+		key_pressed = 0;
+
+	for_each_set_bit(i, &finger_pressed, hx->max_fingers) {
+		x = be16_to_cpu(coord[i].x);
+		y = be16_to_cpu(coord[i].y);
+		w = width[i];
+
+		input_mt_slot(hx->input_dev, i);
+		input_mt_report_slot_state(hx->input_dev, MT_TOOL_FINGER, 1);
+		touchscreen_report_pos(hx->input_dev, &hx->props, x, y, true);
+		input_report_abs(hx->input_dev, ABS_MT_TOUCH_MAJOR, w);
+	}
+	input_mt_sync_frame(hx->input_dev);
+
+	for (i = 0; i < hx->keycount; i++)
+		input_report_key(hx->input_dev, hx->keycodes[i], key_pressed & BIT(i));
+
+	input_sync(hx->input_dev);
+	return 0;
+}
+
+static irqreturn_t hx852x_interrupt(int irq, void *ptr)
+{
+	struct hx852x *hx = ptr;
+	int error;
+
+	error = hx852x_handle_events(hx);
+	if (error) {
+		dev_err_ratelimited(&hx->client->dev, "failed to handle events: %d\n", error);
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int hx852x_input_open(struct input_dev *dev)
+{
+	struct hx852x *hx = input_get_drvdata(dev);
+	int error;
+
+	error = hx852x_power_on(hx);
+	if (error)
+		return error;
+
+	error = hx852x_start(hx);
+	if (error) {
+		hx852x_power_off(hx);
+		return error;
+	}
+
+	enable_irq(hx->client->irq);
+	return 0;
+}
+
+static void hx852x_input_close(struct input_dev *dev)
+{
+	struct hx852x *hx = input_get_drvdata(dev);
+
+	hx852x_stop(hx);
+	disable_irq(hx->client->irq);
+	hx852x_power_off(hx);
+}
+
+static int hx852x_parse_properties(struct hx852x *hx)
+{
+	struct device *dev = &hx->client->dev;
+	int error, count;
+
+	count = device_property_count_u32(dev, "linux,keycodes");
+	if (count == -EINVAL) {
+		/* Property does not exist, keycodes are optional */
+		return 0;
+	} else if (count < 0) {
+		dev_err(dev, "Failed to read linux,keycodes: %d\n", count);
+		return count;
+	} else if (count > HX852X_MAX_KEY_COUNT) {
+		dev_err(dev, "max supported keys: %u, found: %u\n",
+			HX852X_MAX_KEY_COUNT, hx->keycount);
+		return -EINVAL;
+	}
+	hx->keycount = count;
+
+	error = device_property_read_u32_array(dev, "linux,keycodes",
+					       hx->keycodes, hx->keycount);
+	if (error) {
+		dev_err(dev, "failed to read linux,keycodes: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int hx852x_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct hx852x *hx;
+	int error, i;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
+				     I2C_FUNC_SMBUS_WRITE_BYTE |
+				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
+		dev_err(dev, "not all required i2c functionality supported\n");
+		return -ENXIO;
+	}
+
+	hx = devm_kzalloc(dev, sizeof(*hx), GFP_KERNEL);
+	if (!hx)
+		return -ENOMEM;
+
+	hx->client = client;
+	hx->input_dev = devm_input_allocate_device(dev);
+	if (!hx->input_dev)
+		return -ENOMEM;
+
+	hx->input_dev->name = "Himax HX852x";
+	hx->input_dev->id.bustype = BUS_I2C;
+	hx->input_dev->open = hx852x_input_open;
+	hx->input_dev->close = hx852x_input_close;
+
+	i2c_set_clientdata(client, hx);
+	input_set_drvdata(hx->input_dev, hx);
+
+	hx->supplies[0].supply = "vcca";
+	hx->supplies[1].supply = "vccd";
+	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->supplies), hx->supplies);
+	if (error)
+		return dev_err_probe(dev, error, "failed to get regulators\n");
+
+	hx->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(hx->reset_gpiod))
+		return dev_err_probe(dev, PTR_ERR(hx->reset_gpiod),
+				     "failed to get reset gpio\n");
+
+	error = devm_request_threaded_irq(dev, client->irq, NULL, hx852x_interrupt,
+					  IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, hx);
+	if (error)
+		return dev_err_probe(dev, error, "failed to request irq %d", client->irq);
+
+	error = hx852x_read_config(hx);
+	if (error)
+		return error;
+
+	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_X);
+	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_Y);
+	input_set_abs_params(hx->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(hx->input_dev, true, &hx->props);
+	error = hx852x_parse_properties(hx);
+	if (error)
+		return error;
+
+	hx->input_dev->keycode = hx->keycodes;
+	hx->input_dev->keycodemax = hx->keycount;
+	hx->input_dev->keycodesize = sizeof(hx->keycodes[0]);
+	for (i = 0; i < hx->keycount; i++)
+		input_set_capability(hx->input_dev, EV_KEY, hx->keycodes[i]);
+
+	error = input_mt_init_slots(hx->input_dev, hx->max_fingers,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error)
+		return dev_err_probe(dev, error, "failed to init MT slots\n");
+
+	error = input_register_device(hx->input_dev);
+	if (error)
+		return dev_err_probe(dev, error, "failed to register input device\n");
+
+	return 0;
+}
+
+static int hx852x_suspend(struct device *dev)
+{
+	struct hx852x *hx = dev_get_drvdata(dev);
+	int error = 0;
+
+	mutex_lock(&hx->input_dev->mutex);
+	if (input_device_enabled(hx->input_dev))
+		error = hx852x_stop(hx);
+	mutex_unlock(&hx->input_dev->mutex);
+
+	return error;
+}
+
+static int hx852x_resume(struct device *dev)
+{
+	struct hx852x *hx = dev_get_drvdata(dev);
+	int error = 0;
+
+	mutex_lock(&hx->input_dev->mutex);
+	if (input_device_enabled(hx->input_dev))
+		error = hx852x_start(hx);
+	mutex_unlock(&hx->input_dev->mutex);
+
+	return error;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(hx852x_pm_ops, hx852x_suspend, hx852x_resume);
+
+#ifdef CONFIG_OF
+static const struct of_device_id hx852x_of_match[] = {
+	{ .compatible = "himax,hx852es" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hx852x_of_match);
+#endif
+
+static struct i2c_driver hx852x_driver = {
+	.probe = hx852x_probe,
+	.driver = {
+		.name = "himax_hx852x",
+		.pm = pm_sleep_ptr(&hx852x_pm_ops),
+		.of_match_table = of_match_ptr(hx852x_of_match),
+	},
+};
+module_i2c_driver(hx852x_driver);
+
+MODULE_DESCRIPTION("Himax HX852x(ES) Touchscreen Driver");
+MODULE_AUTHOR("Jonathan Albrieux <jonathan.albrieux@gmail.com>");
+MODULE_AUTHOR("Stephan Gerhold <stephan@gerhold.net>");
+MODULE_LICENSE("GPL");

-- 
2.43.1


