Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1897D64DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjJYIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjJYIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:22:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7166E123;
        Wed, 25 Oct 2023 01:22:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5b5354da665so3132756a12.2;
        Wed, 25 Oct 2023 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698222127; x=1698826927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vttA6hJLS6zADD5JYNpQXBw4vrNOMLTCm/2gpINgzWs=;
        b=Ir+w2scY0yenAlmxHpJtYAm609v7mU0AA1SOVRzHReyT8VKFMoT9C+Necjtypz7hn/
         7xHbRjFKh/1cP9wg23P9B6gSMGFuE2PfBREibhZdR4Y2jY6haX2EMJaWOLUn4l3Xg7E6
         TUKk21kjePULcmR6+gpzNUUUrXf01W1wdKIJCOOdPXcjmSaOwoo3VdCQzxhSqVrlmkrQ
         7JXtwDYyW1ADzQejwU/jW5XrHLywZEXq4VsUujLrNCJm68MTDYyi9rX3EOJjn3eHAWFn
         lFH64ySpUkwlvAD6oZYop6rhRcYIBWlzJUAsEquvRGFDg7tJ1wvvYJSmyfSaqvbQflHz
         /JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222127; x=1698826927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vttA6hJLS6zADD5JYNpQXBw4vrNOMLTCm/2gpINgzWs=;
        b=i3dLo2urCNUiqGOpGhhQ9dc/Y13+XfBTzL16AQ+O0KQFgijQT/J1uLyUZIHgEVWKBP
         SnC1ZWQVOb67Wu2oNgiHF4u8KVuKbI4YH1jPUaNeziLg6CvwN6m2kzn8LmIp19JX3HAY
         /IUOuceKsM5KqB6TWh+nbNbqY0SZcfQcG5HF0uHUVxXg9LxmJzeTY2A7oUzmSFTaOiLL
         Nro46oCp92+z64KIXmV4Gyr5t23Q8x6E2n/2IrZe6ccqa9a5q7bQ1OeMtNam/ON9bD2p
         ayouJGY4RDX9PSp2HFQRM2Eb++WiKyktURFoHeUecQi9zPn+856aLuwJtJeqXm9XcOGq
         bH9A==
X-Gm-Message-State: AOJu0YykCLA3lfs3iE5dauDsLTvLly6NUECBjWS5WJwjXha7bHnHguPe
        7uz9edTP7/uuzpJqpmDT86c=
X-Google-Smtp-Source: AGHT+IFOe9dCYMaSFbcRaSbB2P9YLbC0P5pERbLpQRlnvJ/IHRTvjzJRLtL/XB/66UHmS8Pp1gxFWw==
X-Received: by 2002:a05:6a20:914d:b0:174:52b7:f63 with SMTP id x13-20020a056a20914d00b0017452b70f63mr4967040pzc.26.1698222126561;
        Wed, 25 Oct 2023 01:22:06 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e38c-defd-6dc9-16c9-6f6d-2997.emome-ip6.hinet.net. [2001:b400:e38c:defd:6dc9:16c9:6f6d:2997])
        by smtp.gmail.com with ESMTPSA id y66-20020a62ce45000000b00690ca4356f1sm9255860pfg.198.2023.10.25.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:22:06 -0700 (PDT)
From:   Wei-Shih Lin <frank101417@gmail.com>
X-Google-Original-From: Wei-Shih Lin <Weishih_Lin@novatek.com.tw>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: Add driver for Novatek NT519XX series touchscreen devices
Date:   Wed, 25 Oct 2023 16:20:54 +0800
Message-ID: <20231025082054.1190-3-Weishih_Lin@novatek.com.tw>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20231025082054.1190-1-Weishih_Lin@novatek.com.tw>
References: <20231025082054.1190-1-Weishih_Lin@novatek.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for Novatek NT519XX series touchscreen devices.
Existing Novatek touchscreen driver code developed for Acer Iconia One 7
B1-750 tablet with Novatek IC NT11205 is novatek-nvt-ts.c in the path
drivers/input/touchscreen/. However, this patch supports touch features
for automotive display with Novatek TDDI NT519XX.

Signed-off-by: Wei-Shih Lin <Weishih_Lin@novatek.com.tw>
---
 drivers/input/touchscreen/Kconfig           |  12 +
 drivers/input/touchscreen/Makefile          |   1 +
 drivers/input/touchscreen/nt519xx.c         | 995 ++++++++++++++++++++
 drivers/input/touchscreen/nt519xx.h         | 130 +++
 drivers/input/touchscreen/nt519xx_mem_map.h | 262 ++++++
 5 files changed, 1400 insertions(+)
 create mode 100644 drivers/input/touchscreen/nt519xx.c
 create mode 100644 drivers/input/touchscreen/nt519xx.h
 create mode 100644 drivers/input/touchscreen/nt519xx_mem_map.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index c2cbd332af1d..6f84e31e7dbd 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1389,4 +1389,16 @@ config TOUCHSCREEN_HIMAX_HX83112B
 	  To compile this driver as a module, choose M here: the
 	  module will be called himax_hx83112b.
 
+config TOUCHSCREEN_NT519XX
+	tristate "Novatek NT519XX based touchscreens"
+	depends on I2C
+	help
+	  Say Y here if you have a Novatek NT519XX based touchscreen
+	  controller.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nt519xx.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 159cd5136fdb..598d38e4e06a 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -117,3 +117,4 @@ obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
 obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
 obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
+obj-$(CONFIG_TOUCHSCREEN_NT519XX)	+= nt519xx.o
diff --git a/drivers/input/touchscreen/nt519xx.c b/drivers/input/touchscreen/nt519xx.c
new file mode 100644
index 000000000000..f3cc884c65e9
--- /dev/null
+++ b/drivers/input/touchscreen/nt519xx.c
@@ -0,0 +1,995 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Novatek NT519xx touchscreens
+ *
+ * Copyright (C) 2023 Wei-Shih Lin <Weishih_Lin@novatek.com.tw>
+ * Copyright (C) 2023 Leo LS Chang <Leo_LS_Chang@novatek.com.tw>
+ *
+ * Copyright (C) 2010 - 2023 Novatek, Inc.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/proc_fs.h>
+#include <linux/input/mt.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+
+#include <linux/notifier.h>
+#include <linux/fb.h>
+
+#include "nt519xx.h"
+
+struct nvt_ts_data *ts;
+
+static int nvt_fb_notifier_callback(struct notifier_block *self,
+				    unsigned long event, void *data);
+
+static uint8_t bTouchIsAwake;
+static uint8_t debug_log;
+
+static void nvt_irq_enable(bool enable)
+{
+	struct irq_desc *desc;
+
+	if (enable) {
+		if (!ts->irq_enabled) {
+			enable_irq(ts->client->irq);
+			ts->irq_enabled = true;
+		}
+	} else {
+		if (ts->irq_enabled) {
+			disable_irq(ts->client->irq);
+			ts->irq_enabled = false;
+		}
+	}
+
+	desc = irq_to_desc(ts->client->irq);
+	NVT_LOG("enable=%d, desc->depth=%d\n", enable, desc->depth);
+}
+
+int32_t CTP_I2C_READ(struct i2c_client *client, uint16_t address, uint8_t *buf,
+		     uint16_t len)
+{
+	struct i2c_msg msgs[2];
+	int32_t ret = -1;
+	int32_t retries = 0;
+
+	mutex_lock(&ts->xbuf_lock);
+
+	msgs[0].flags = !I2C_M_RD;
+	msgs[0].addr = address;
+	msgs[0].len = 1;
+	msgs[0].buf = &buf[0];
+
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].addr = address;
+	msgs[1].len = len - 1;
+	msgs[1].buf = ts->xbuf;
+
+	while (retries < 5) {
+		ret = i2c_transfer(client->adapter, msgs, 2);
+		if (ret == 2)
+			break;
+		retries++;
+	}
+
+	if (unlikely(retries == 5)) {
+		NVT_ERR("ret=%d\n", ret);
+		ret = -EIO;
+	}
+
+	memcpy(buf + 1, ts->xbuf, len - 1);
+
+	mutex_unlock(&ts->xbuf_lock);
+
+	return ret;
+}
+
+int32_t CTP_I2C_WRITE(struct i2c_client *client, uint16_t address, uint8_t *buf,
+		      uint16_t len)
+{
+	struct i2c_msg msg;
+	int32_t ret = -1;
+	int32_t retries = 0;
+
+	mutex_lock(&ts->xbuf_lock);
+
+	msg.flags = !I2C_M_RD;
+	msg.addr = address;
+	msg.len = len;
+	memcpy(ts->xbuf, buf, len);
+	msg.buf = ts->xbuf;
+
+	while (retries < 5) {
+		ret = i2c_transfer(client->adapter, &msg, 1);
+		if (ret == 1)
+			break;
+		retries++;
+	}
+
+	if (unlikely(retries == 5)) {
+		NVT_ERR("ret=%d\n", ret);
+		ret = -EIO;
+	}
+
+	mutex_unlock(&ts->xbuf_lock);
+
+	return ret;
+}
+
+int32_t nvt_set_page(uint16_t i2c_addr, uint32_t addr)
+{
+	uint8_t buf[4] = { 0 };
+
+	buf[0] = 0xFF; // novatek set page command
+	buf[1] = (addr >> 16) & 0xFF;
+	buf[2] = (addr >> 8) & 0xFF;
+
+	return CTP_I2C_WRITE(ts->client, i2c_addr, buf, 3);
+}
+
+int32_t nvt_write_addr(uint32_t addr, uint8_t data)
+{
+	int32_t ret = 0;
+	uint8_t buf[2] = { 0 };
+
+	ret = nvt_set_page(I2C_FW_ADDRESS, addr);
+	if (ret < 0) {
+		NVT_ERR("Set page 0x%06X failed! ret=%d\n", addr, ret);
+		return ret;
+	}
+
+	buf[0] = addr & 0xFF;
+	buf[1] = data;
+	ret = CTP_I2C_WRITE(ts->client, I2C_FW_ADDRESS, buf, 2);
+	if (ret < 0) {
+		NVT_ERR("Write data to 0x%06X failed! ret=%d\n", addr, ret);
+		return ret;
+	}
+	ret = 0;
+
+	return ret;
+}
+
+int32_t nvt_read_reg(struct nvt_ts_reg reg, uint8_t *val)
+{
+	int32_t ret = 0;
+	uint32_t addr = 0;
+	uint8_t bitmask = 0;
+	uint8_t shift = 0;
+	uint8_t buf[8] = { 0 };
+	uint8_t temp = 0;
+
+	addr = reg.addr;
+	bitmask = reg.bitmask;
+	temp = reg.bitmask;
+	shift = 0;
+	while (1) {
+		if ((temp >> shift) & 0x01)
+			break;
+		if (shift == 8) {
+			NVT_ERR("bitmask all bits zero!\n");
+			ret = -1;
+			break;
+		}
+		shift++;
+	}
+
+	nvt_set_page(I2C_FW_ADDRESS, addr);
+	buf[0] = addr & 0xFF;
+	buf[1] = 0x00;
+	ret = CTP_I2C_READ(ts->client, I2C_FW_ADDRESS, buf, 2);
+	if (ret < 0) {
+		NVT_ERR("CTP_I2C_READ failed! ret=%d\n", ret);
+		goto nvt_read_register_exit;
+	}
+	*val = (buf[1] & bitmask) >> shift;
+
+nvt_read_register_exit:
+	return ret;
+}
+
+void nvt_sw_reset_idle(void)
+{
+	nvt_write_addr(SWRST_SIF_ADDR, 0xAA);
+
+	usleep_range(15000, 16000);
+
+	nvt_clear_crc_err_flag();
+}
+
+void nvt_bootloader_reset(void)
+{
+	NVT_LOG("start\n");
+
+	nvt_write_addr(SWRST_SIF_ADDR, 0x69);
+
+	msleep(35);
+
+	NVT_LOG("end\n");
+}
+
+bool nvt_check_fw_reset_state(enum rst_complete_state check_reset_state)
+{
+	uint8_t buf[8] = { 0 };
+	bool ret = true;
+	int32_t retry = 0;
+
+	nvt_set_page(I2C_FW_ADDRESS, ts->mmap->EVENT_BUF_ADDR);
+
+	while (1) {
+		usleep_range(10000, 11000);
+
+		buf[0] = EVENT_MAP_RESET_COMPLETE;
+		buf[1] = 0x00;
+		CTP_I2C_READ(ts->client, I2C_FW_ADDRESS, buf, 6);
+
+		if ((buf[1] >= check_reset_state) &&
+		    (buf[1] <= RESET_STATE_MAX)) {
+			ret = true;
+			break;
+		}
+
+		retry++;
+		if (unlikely(retry > 100)) {
+			NVT_ERR("retry=%d, buf[1]=0x%02X\n", retry, buf[1]);
+			ret = false;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int32_t nvt_check_cascade_chip_numbers(void)
+{
+	uint8_t enb_casc = 0;
+	uint8_t sdloc = 0;
+	uint8_t ic_num = 0;
+	int32_t ret = 0;
+
+	if (ts->cascade_type) {
+		if (ts->cascade_type == CASCADE_ENB_CASC) {
+			if (!ts->mmap->ENB_CASC_REG.addr) {
+				NVT_ERR("ENB_CASC_REG.addr is missing!\n");
+				return (-EIO);
+			}
+
+			nvt_set_page(I2C_FW_ADDRESS,
+				     ts->mmap->ENB_CASC_REG.addr);
+			nvt_read_reg(ts->mmap->ENB_CASC_REG, &enb_casc);
+
+			if (enb_casc == ENB_CASC_1CHIP)
+				ts->cascade_num = CASCADE_1CHIP;
+			else
+				ts->cascade_num = CASCADE_2CHIP;
+
+		} else if (ts->cascade_type == CASCADE_SDLOC) {
+			if (!ts->mmap->SDLOC_REG.addr) {
+				NVT_ERR("SDLOC_REG.addr is missing!\n");
+				return (-EIO);
+			}
+
+			nvt_set_page(I2C_FW_ADDRESS, ts->mmap->SDLOC_REG.addr);
+			nvt_read_reg(ts->mmap->SDLOC_REG, &sdloc);
+
+			switch (sdloc) {
+			case SDLOC_1CHIP:
+				ts->cascade_num = CASCADE_1CHIP;
+				break;
+			case SDLOC_2CHIP:
+				ts->cascade_num = CASCADE_2CHIP;
+				break;
+			case SDLOC_3CHIP_AND_ABOVE:
+				ts->cascade_num = CASCADE_3CHIP;
+				break;
+			default:
+				ts->cascade_num = CASCADE_CHECK_ERR;
+				NVT_ERR("Undefined CASCADE_TYPE_SDLOC: 0x%X!\n",
+					sdloc);
+				ret = (-EIO);
+				break;
+			}
+		} else if (ts->cascade_type == CASCADE_IC_NUM) {
+			if (!ts->mmap->IC_NUM_REG.addr) {
+				NVT_ERR("IC_NUM_REG.addr is missing!\n");
+				return (-EIO);
+			}
+
+			nvt_set_page(I2C_FW_ADDRESS, ts->mmap->IC_NUM_REG.addr);
+			nvt_read_reg(ts->mmap->IC_NUM_REG, &ic_num);
+
+			switch (ic_num) {
+			case IC_NUM_1CHIP:
+				ts->cascade_num = CASCADE_1CHIP;
+				break;
+			case IC_NUM_2CHIP:
+				ts->cascade_num = CASCADE_2CHIP;
+				break;
+			case IC_NUM_3CHIP:
+			case IC_NUM_3CHIP_AND_ABOVE:
+				ts->cascade_num = CASCADE_3CHIP;
+				break;
+			default:
+				ts->cascade_num = CASCADE_CHECK_ERR;
+				NVT_ERR("Undefined CASCADE_TYPE_IC_NUM: 0x%X!\n",
+					ic_num);
+				ret = (-EIO);
+				break;
+			}
+		}
+	} else {
+		ts->cascade_num = NONE_CASCADE_CASE;
+		NVT_LOG("CASCADE_NONE cascade_type: %d, cascade_num: %d\n",
+			ts->cascade_type, ts->cascade_num);
+	}
+
+	return ret;
+}
+
+int32_t nvt_get_fw_info(void)
+{
+	uint8_t buf[64] = { 0 };
+	uint8_t retry_count = 2;
+	int32_t ret = 0;
+
+info_retry:
+	nvt_set_page(I2C_FW_ADDRESS,
+		     ts->mmap->EVENT_BUF_ADDR | EVENT_MAP_FWINFO);
+
+	buf[0] = EVENT_MAP_FWINFO;
+	CTP_I2C_READ(ts->client, I2C_FW_ADDRESS, buf, 17);
+	if ((buf[1] + buf[2]) != 0xFF) {
+		NVT_ERR("FW info is broken! fw_ver=0x%02X, ~fw_ver=0x%02X\n",
+			buf[1], buf[2]);
+		if (retry_count < 3) {
+			retry_count++;
+			NVT_ERR("retry_count=%d\n", retry_count);
+			goto info_retry;
+		} else {
+			ts->fw_ver = 0;
+			NVT_ERR("Set default fw_ver=0x%02X\n", ts->fw_ver);
+			ret = -1;
+			goto out;
+		}
+	}
+	ts->fw_ver = buf[1];
+	ts->x_num = buf[3];
+	ts->y_num = buf[4];
+	ts->nvt_pid = (uint16_t)((buf[36] << 8) | buf[35]);
+
+	NVT_LOG("fw_ver=0x%02X, x_num=%0d, y_num=%0d, fw_type=0x%02X, PID=0x%04X\n",
+		ts->fw_ver, ts->x_num, ts->y_num, buf[14], ts->nvt_pid);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static void nvt_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+
+	ts->irq_gpio = of_get_named_gpio_flags(np, "novatek,irq-gpio", 0,
+					       &ts->irq_flags);
+	NVT_LOG("novatek,irq-gpio=%d\n", ts->irq_gpio);
+}
+#else /* CONFIG_OF */
+static void nvt_parse_dt(struct device *dev)
+{
+	ts->irq_gpio = NVTTOUCH_INT_PIN;
+}
+#endif /* CONFIG_OF */
+
+static int nvt_gpio_config(struct nvt_ts_data *ts)
+{
+	int32_t ret = 0;
+
+	if (gpio_is_valid(ts->irq_gpio)) {
+		ret = gpio_request_one(ts->irq_gpio, GPIOF_IN, "NVT-int");
+		if (ret) {
+			NVT_ERR("Failed to request NVT-int GPIO!\n");
+			goto err_request_irq_gpio;
+		}
+	}
+
+	return ret;
+
+err_request_irq_gpio:
+	return ret;
+}
+
+static void nvt_gpio_deconfig(struct nvt_ts_data *ts)
+{
+	if (gpio_is_valid(ts->irq_gpio))
+		gpio_free(ts->irq_gpio);
+}
+
+static uint8_t nvt_calculate_crc8(uint8_t *buf, uint8_t length)
+{
+	uint8_t i = 0, j = 0;
+	uint8_t crc8 = 0;
+	uint8_t poly = 0x1D; // x8 + x4 + x3 + x2 + 1
+
+	for (i = 0; i < length; i++) {
+		crc8 ^= *(buf + i);
+
+		for (j = 0; j < 8; j++) {
+			if (crc8 & 0x80)
+				crc8 = (crc8 << 1) ^ poly;
+			else
+				crc8 = (crc8 << 1);
+		}
+	}
+
+	crc8 ^= (uint8_t)0x00;
+	return crc8;
+}
+
+static int32_t nvt_ts_event_crc8(uint8_t *buf, uint8_t length)
+{
+	uint8_t crc8 = nvt_calculate_crc8(buf, length - 1);
+	uint32_t i = 0;
+
+	/* The lastest item is CRC8 which is reported by FW */
+	if (buf[length - 1] != crc8) {
+		NVT_ERR("CRC8 not match, FW reported: 0x%02X, Calulated CRC8: 0x%02X\n",
+			buf[length - 1], crc8);
+		if (debug_log) {
+			NVT_ERR("length=%d\n", length);
+			for (i = 0; i < length; i++) {
+				NVT_LOG("%02X ", buf[i]);
+				if (i % POINT_DATA_LEN == 0)
+					NVT_LOG("\n");
+			}
+			NVT_LOG("\n");
+		}
+		return -1;
+	}
+	return crc8;
+}
+
+static irqreturn_t nvt_ts_work_func(int irq, void *data)
+{
+	int32_t ret = -1;
+	uint8_t touch_event[DUMMY_BYTES + TOUCH_EVENT_CRC_LEN] = { 0 };
+	uint32_t event_size = ARRAY_SIZE(touch_event);
+	uint32_t position = 0;
+	uint32_t input_x = 0;
+	uint32_t input_y = 0;
+	uint8_t input_id = 0;
+	uint8_t press_id[TOUCH_MAX_FINGER_NUM] = { 0 };
+	int32_t i = 0;
+	int32_t finger_cnt = 0;
+
+	mutex_lock(&ts->lock);
+
+	ret = CTP_I2C_READ(ts->client, I2C_FW_ADDRESS, touch_event, event_size);
+	if (ret < 0) {
+		NVT_ERR("CTP_I2C_READ failed! ret=%d\n", ret);
+		goto nvt_ts_work_func_exit;
+	}
+
+	if (debug_log) {
+		NVT_LOG("Touch event buffer length: %d\n", event_size);
+		for (i = DUMMY_BYTES; i < event_size; i++) {
+			NVT_LOG("%02X ", touch_event[i]);
+			if (i % POINT_DATA_LEN == 0)
+				NVT_LOG("\n");
+		}
+		NVT_LOG("\n");
+	}
+
+	ret = nvt_ts_event_crc8(touch_event + DUMMY_BYTES,
+				event_size - DUMMY_BYTES);
+	if (ret < 0)
+		goto nvt_ts_work_func_exit;
+
+	finger_cnt = 0;
+
+	for (i = 0; i < ts->max_touch_num; i++) {
+		position = DUMMY_BYTES + ASIL_FLAG_LEN + POINT_DATA_LEN * i;
+		input_id = (uint8_t)(touch_event[position] >> 4);
+
+		if ((input_id == 0) || (input_id > ts->max_touch_num))
+			continue;
+
+		/* Finger down (enter or moving) */
+		if (((touch_event[position] & 0x07) == 0x01) ||
+		    ((touch_event[position] & 0x07) == 0x02)) {
+			input_x = (uint32_t)(touch_event[position + 1] << 8) +
+				  (uint32_t)(touch_event[position + 2]);
+			input_y = (uint32_t)(touch_event[position + 3] << 8) +
+				  (uint32_t)(touch_event[position + 4]);
+
+			if ((input_x > TOUCH_MAX_WIDTH) ||
+			    (input_y > TOUCH_MAX_HEIGHT))
+				continue;
+
+			press_id[input_id - 1] = 1;
+			input_mt_slot(ts->input_dev, input_id - 1);
+			input_mt_report_slot_state(ts->input_dev,
+						   MT_TOOL_FINGER, true);
+
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
+					 input_x);
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
+					 input_y);
+
+			finger_cnt++;
+		}
+	}
+
+	for (i = 0; i < ts->max_touch_num; i++) {
+		if (press_id[i] != 1) {
+			input_mt_slot(ts->input_dev, i);
+			input_mt_report_slot_state(ts->input_dev,
+						   MT_TOOL_FINGER, false);
+		}
+	}
+
+	input_report_key(ts->input_dev, BTN_TOUCH, (finger_cnt > 0));
+
+	input_sync(ts->input_dev);
+
+nvt_ts_work_func_exit:
+	mutex_unlock(&ts->lock);
+
+	return IRQ_HANDLED;
+}
+
+int32_t nvt_clear_crc_err_flag(void)
+{
+	uint8_t buf[2] = { 0x00 };
+	int ret = 0;
+
+	nvt_set_page(I2C_FW_ADDRESS, (uint32_t)BLD_SPE_PUPS_ADDR);
+
+	buf[0] = (uint32_t)BLD_SPE_PUPS_ADDR & 0xFF;
+	buf[1] = 0xA5;
+	ret = CTP_I2C_WRITE(ts->client, I2C_FW_ADDRESS, buf, 2);
+	if (ret < 0) {
+		NVT_LOG("Write 0x%02X to BLD_SPE_PUPS(0x%X) failed, ret=%d!\n",
+			(uint32_t)BLD_SPE_PUPS_ADDR, buf[1], ret);
+		return ret;
+	}
+
+	buf[0] = (uint32_t)BLD_SPE_PUPS_ADDR & 0xFF;
+	buf[1] = 0x00;
+	ret = CTP_I2C_READ(ts->client, I2C_FW_ADDRESS, buf, 2);
+	if (ret < 0) {
+		NVT_LOG("Read BLD_SPE_PUPS (0x%X) failed, ret=%d!\n",
+			(uint32_t)BLD_SPE_PUPS_ADDR, ret);
+		return ret;
+	}
+
+	NVT_LOG("BLD_SPE_PUPS(0x%X)=0x%02X\n", (uint32_t)BLD_SPE_PUPS_ADDR,
+		buf[1]);
+
+	if (buf[1] != 0xA5)
+		return (-EIO);
+
+	return ret;
+}
+
+void nvt_stop_crc_reboot(void)
+{
+	uint8_t buf[4] = { 0 };
+	int32_t i = 0;
+
+	/* Read dummy buffer to check CRC fail reboot is happening or not */
+	nvt_set_page(I2C_FW_ADDRESS, (uint32_t)CHIP_VER_TRIM_ADDR);
+
+	/* Read to check if buf is 0xFC which means IC is in CRC reboot */
+	buf[0] = (uint32_t)CHIP_VER_TRIM_ADDR & 0xFF;
+	CTP_I2C_READ(ts->client, I2C_FW_ADDRESS, buf, 4);
+
+	if (((buf[1] == 0xFB) && (buf[2] == 0xFB) && (buf[3] == 0xFB)) ||
+	    ((buf[1] == 0xFC) && (buf[2] == 0xFC) && (buf[3] == 0xFC)) ||
+	    ((buf[1] == 0xFF) && (buf[2] == 0xFF) && (buf[3] == 0xFF))) {
+		/* IC is in CRC fail reboot loop, needs to be stopped! */
+		for (i = 5; i > 0; i--) {
+			/*
+			 * Reset idle twice to ensure that the cmd will be
+			 * executed in CRC reboot process
+			 */
+			nvt_sw_reset_idle();
+
+			nvt_sw_reset_idle();
+			usleep_range(1000, 2000);
+
+			if (nvt_clear_crc_err_flag() >= 0)
+				break;
+		}
+		if (i == 0)
+			NVT_ERR("CRC auto reboot is not able to be stopped! buf[1]=0x%02X\n",
+				buf[1]);
+	}
+}
+
+static int8_t nvt_ts_check_chip_ver_trim(void)
+{
+	uint8_t buf[8] = { 0 };
+	int32_t i = 0;
+	int32_t j = 0;
+	int32_t k = 0;
+	int32_t found_nvt_chip = 0;
+	int32_t ret = -1;
+
+	nvt_bootloader_reset();
+
+	for (i = 5; i > 0; i--) {
+		nvt_sw_reset_idle();
+
+		nvt_set_page(I2C_FW_ADDRESS, (uint32_t)CHIP_VER_TRIM_ADDR);
+
+		buf[0] = ((uint32_t)CHIP_VER_TRIM_ADDR & 0xFF);
+		buf[1] = 0x00;
+		buf[2] = 0x00;
+		buf[3] = 0x00;
+		buf[4] = 0x00;
+		buf[5] = 0x00;
+		buf[6] = 0x00;
+		CTP_I2C_READ(ts->client, I2C_FW_ADDRESS, buf, 7);
+		NVT_LOG("EXT_CHIP_ID_RD(0x%X)=0x%02X, 0x%02X, 0x%02X, 0x%02X, 0x%02X, 0x%02X\n",
+			(uint32_t)CHIP_VER_TRIM_ADDR, buf[1], buf[2], buf[3],
+			buf[4], buf[5], buf[6]);
+
+		/* Stop CRC check to prevent IC auto reboot */
+		if (((buf[1] == 0xFB) && (buf[2] == 0xFB) &&
+		     (buf[3] == 0xFB)) ||
+		    ((buf[1] == 0xFC) && (buf[2] == 0xFC) &&
+		     (buf[3] == 0xFC)) ||
+		    ((buf[1] == 0xFF) && (buf[2] == 0xFF) &&
+		     (buf[3] == 0xFF))) {
+			nvt_stop_crc_reboot();
+			continue;
+		}
+
+		/* Compare read chip id on supported list */
+		for (j = 0; j < ARRAY_SIZE(trim_id_table); j++) {
+			found_nvt_chip = 0;
+
+			/* Compare each byte */
+			for (k = 0; k < NVT_ID_BYTE_MAX; k++) {
+				if (trim_id_table[j].mask[k]) {
+					if (buf[k + 1] !=
+					    trim_id_table[j].id[k])
+						break;
+				}
+			}
+
+			if (k == NVT_ID_BYTE_MAX)
+				found_nvt_chip = 1;
+
+			if (found_nvt_chip) {
+				ts->mmap = trim_id_table[j].mmap;
+				ts->cascade_type =
+					trim_id_table[j].hwinfo->cascade_type;
+
+				ret = nvt_check_cascade_chip_numbers();
+				if (ret < 0)
+					NVT_ERR("Get cascade chip numbers failed! ret=%d\n",
+						ret);
+
+				/* Find out the memory map of target chip numbers */
+				if (ts->cascade_num ==
+				    trim_id_table[j].hwinfo->cascade_num) {
+					if (ts->cascade_type ==
+					    CASCADE_ENB_CASC) {
+						NVT_LOG("ENB_CASC_REG.addr(0x%X)\n",
+							ts->mmap->ENB_CASC_REG
+								.addr);
+					} else if (ts->cascade_type ==
+						   CASCADE_IC_NUM) {
+						NVT_LOG("IC_NUM_REG.addr(0x%X)\n",
+						ts->mmap->IC_NUM_REG.addr;
+					} else {
+						NVT_LOG("Non cascade case\n");
+					}
+					NVT_LOG("trim_id_table[%d] is matched.\n",
+						j);
+					NVT_LOG("This is NVT touch IC.\n");
+					goto out;
+				}
+			}
+		}
+		usleep_range(10000, 11000);
+	}
+
+	ts->mmap = NULL;
+	ret = -1;
+
+out:
+	return ret;
+}
+
+static int32_t nvt_ts_probe(struct i2c_client *client)
+{
+	int32_t ret = 0;
+
+	ts = kzalloc(sizeof(struct nvt_ts_data), GFP_KERNEL);
+	if (ts == NULL) {
+		NVT_ERR("Failed to allocated memory for nvt ts data!\n");
+		return -ENOMEM;
+	}
+
+	ts->xbuf = kzalloc(NVT_XBUF_LEN, GFP_KERNEL);
+	if (ts->xbuf == NULL) {
+		NVT_ERR("kzalloc for xbuf failed!\n");
+		ret = -ENOMEM;
+		goto err_malloc_xbuf;
+	}
+
+	ts->client = client;
+	i2c_set_clientdata(client, ts);
+
+	nvt_parse_dt(&client->dev);
+
+	ret = nvt_gpio_config(ts);
+	if (ret) {
+		NVT_ERR("Gpio config error!\n");
+		goto err_gpio_config_failed;
+	}
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		NVT_ERR("i2c_check_functionality() failed! (no I2C_FUNC_I2C)\n");
+		ret = -ENODEV;
+		goto err_check_functionality_failed;
+	}
+
+	mutex_init(&ts->lock);
+	mutex_init(&ts->xbuf_lock);
+
+	/* Need 10ms delay after POR (power on reset) */
+	usleep_range(10000, 11000);
+
+	ret = nvt_ts_check_chip_ver_trim();
+	if (ret) {
+		NVT_ERR("This chip is not identified in mapping table!\n");
+		ret = -EINVAL;
+		goto err_chipvertrim_failed;
+	}
+
+	nvt_bootloader_reset();
+	nvt_check_fw_reset_state(RESET_STATE_INIT);
+	nvt_get_fw_info();
+
+	ts->input_dev = input_allocate_device();
+	if (ts->input_dev == NULL) {
+		NVT_ERR("Allocate input device failed!\n");
+		ret = -ENOMEM;
+		goto err_input_dev_alloc_failed;
+	}
+
+	ts->max_touch_num = TOUCH_MAX_FINGER_NUM;
+
+	ts->int_trigger_type = INT_TRIGGER_TYPE;
+	ts->input_dev->evbit[0] = BIT_MASK(EV_SYN) | BIT_MASK(EV_KEY) |
+				  BIT_MASK(EV_ABS);
+	ts->input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	ts->input_dev->propbit[0] = BIT(INPUT_PROP_DIRECT);
+
+	input_mt_init_slots(ts->input_dev, ts->max_touch_num, 0);
+
+#if TOUCH_MAX_FINGER_NUM > 1
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X, 0,
+			     TOUCH_MAX_WIDTH, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y, 0,
+			     TOUCH_MAX_HEIGHT, 0, 0);
+#endif
+
+	sprintf(ts->phys, "input/ts");
+	ts->input_dev->name = NVT_TS_NAME;
+	ts->input_dev->phys = ts->phys;
+	ts->input_dev->id.bustype = BUS_I2C;
+
+	ret = input_register_device(ts->input_dev);
+	if (ret) {
+		NVT_ERR("Register input device (%s) failed! ret=%d\n",
+			ts->input_dev->name, ret);
+		goto err_input_register_device_failed;
+	}
+
+	client->irq = gpio_to_irq(ts->irq_gpio);
+	if (client->irq) {
+		NVT_LOG("int_trigger_type=%d\n", ts->int_trigger_type);
+		ts->irq_enabled = true;
+		ret = request_threaded_irq(client->irq, NULL, nvt_ts_work_func,
+					   ts->int_trigger_type | IRQF_ONESHOT,
+					   NVT_I2C_NAME, ts);
+		if (ret != 0) {
+			NVT_ERR("Request irq failed! ret=%d\n", ret);
+			goto err_int_request_failed;
+		} else {
+			nvt_irq_enable(false);
+			NVT_LOG("Request irq %d succeed.\n", client->irq);
+		}
+	}
+
+	ts->fb_notif.notifier_call = nvt_fb_notifier_callback;
+	ret = fb_register_client(&ts->fb_notif);
+	if (ret) {
+		NVT_ERR("Register fb_notifier failed! ret=%d\n", ret);
+		goto err_register_fb_notif_failed;
+	}
+
+	bTouchIsAwake = 1;
+	NVT_LOG("end\n");
+
+	nvt_irq_enable(true);
+
+	return 0;
+
+	if (fb_unregister_client(&ts->fb_notif))
+		NVT_ERR("Error occurred while unregistering fb_notifier!\n");
+err_register_fb_notif_failed:
+	free_irq(client->irq, ts);
+err_int_request_failed:
+	input_unregister_device(ts->input_dev);
+	ts->input_dev = NULL;
+err_input_register_device_failed:
+	if (ts->input_dev) {
+		input_free_device(ts->input_dev);
+		ts->input_dev = NULL;
+	}
+err_input_dev_alloc_failed:
+err_chipvertrim_failed:
+	mutex_destroy(&ts->xbuf_lock);
+	mutex_destroy(&ts->lock);
+err_check_functionality_failed:
+	nvt_gpio_deconfig(ts);
+err_gpio_config_failed:
+	i2c_set_clientdata(client, NULL);
+	kfree(ts->xbuf);
+	ts->xbuf = NULL;
+err_malloc_xbuf:
+	kfree(ts);
+	ts = NULL;
+
+	return ret;
+}
+
+static void nvt_ts_remove(struct i2c_client *client)
+{
+	NVT_LOG("Removing driver...\n");
+
+	if (fb_unregister_client(&ts->fb_notif))
+		NVT_ERR("Error occurred while unregistering fb_notifier!\n");
+
+	nvt_irq_enable(false);
+	free_irq(client->irq, ts);
+
+	mutex_destroy(&ts->xbuf_lock);
+	mutex_destroy(&ts->lock);
+
+	nvt_gpio_deconfig(ts);
+
+	if (ts->input_dev) {
+		input_unregister_device(ts->input_dev);
+		ts->input_dev = NULL;
+	}
+
+	i2c_set_clientdata(client, NULL);
+
+	kfree(ts->xbuf);
+	ts->xbuf = NULL;
+
+	kfree(ts);
+	ts = NULL;
+}
+
+static void nvt_ts_shutdown(struct i2c_client *client)
+{
+	NVT_LOG("Shutdown driver...\n");
+
+	nvt_irq_enable(false);
+
+	if (fb_unregister_client(&ts->fb_notif))
+		NVT_ERR("Error occurred while unregistering fb_notifier!\n");
+}
+
+static int32_t nvt_ts_resume(struct device *dev)
+{
+	if (bTouchIsAwake) {
+		NVT_LOG("Touch is already resume.\n");
+		return 0;
+	}
+
+	mutex_lock(&ts->lock);
+
+	NVT_LOG("start\n");
+
+	nvt_bootloader_reset();
+	nvt_check_fw_reset_state(RESET_STATE_NORMAL_RUN);
+
+	nvt_irq_enable(true);
+
+	bTouchIsAwake = 1;
+
+	mutex_unlock(&ts->lock);
+
+	NVT_LOG("end\n");
+
+	return 0;
+}
+
+static int nvt_fb_notifier_callback(struct notifier_block *self,
+				    unsigned long event, void *data)
+{
+	struct fb_event *evdata = data;
+	int *blank;
+	struct nvt_ts_data *ts =
+		container_of(self, struct nvt_ts_data, fb_notif);
+
+	if (evdata && evdata->data && event == FB_EVENT_BLANK) {
+		blank = evdata->data;
+		if (*blank == FB_BLANK_UNBLANK) {
+			NVT_LOG("event=%lu, *blank=%d\n", event, *blank);
+			nvt_ts_resume(&ts->client->dev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id nvt_ts_id[] = { { NVT_I2C_NAME, 0 }, {} };
+
+#ifdef CONFIG_OF
+static const struct of_device_id nvt_match_table[] = {
+	{
+		.compatible = "novatek,NVT-ts",
+	},
+	{},
+};
+#endif
+
+static struct i2c_driver nvt_i2c_driver = {
+	.probe		= nvt_ts_probe,
+	.remove		= nvt_ts_remove,
+	.shutdown	= nvt_ts_shutdown,
+	.id_table	= nvt_ts_id,
+	.driver = {
+		.name	= NVT_I2C_NAME,
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = nvt_match_table,
+#endif
+	},
+};
+
+static int32_t __init nvt_driver_init(void)
+{
+	int32_t ret = 0;
+
+	NVT_LOG("start\n");
+
+	bTouchIsAwake = 0;
+
+	ret = i2c_add_driver(&nvt_i2c_driver);
+	if (ret) {
+		NVT_ERR("Failed to add i2c driver!");
+		goto err_driver;
+	}
+
+	NVT_LOG("end\n");
+
+err_driver:
+	return ret;
+}
+
+static void __exit nvt_driver_exit(void)
+{
+	i2c_del_driver(&nvt_i2c_driver);
+}
+
+module_init(nvt_driver_init);
+module_exit(nvt_driver_exit);
+
+MODULE_DESCRIPTION("Novatek Touchscreen Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/nt519xx.h b/drivers/input/touchscreen/nt519xx.h
new file mode 100644
index 000000000000..27521416cc6c
--- /dev/null
+++ b/drivers/input/touchscreen/nt519xx.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Driver for Novatek NT519xx touchscreens
+ *
+ * Copyright (C) 2023 Wei-Shih Lin <Weishih_Lin@novatek.com.tw>
+ * Copyright (C) 2023 Leo LS Chang <Leo_LS_Chang@novatek.com.tw>
+ *
+ * Copyright (C) 2010 - 2023 Novatek, Inc.
+ *
+ */
+#ifndef _LINUX_NVT_TOUCH_H
+#define _LINUX_NVT_TOUCH_H
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+
+#include "nt519xx_mem_map.h"
+
+#define NVT_DEBUG (1)
+
+/* GPIO Number */
+#define NVTTOUCH_RST_PIN (980)
+#define NVTTOUCH_INT_PIN (943)
+
+/* INT Trigger Mode */
+#define INT_TRIGGER_TYPE (IRQ_TYPE_EDGE_RISING)
+
+/* I2C Driver Info */
+#define NVT_I2C_NAME "NVT-ts"
+#define I2C_FW_ADDRESS (0x01)
+#define I2C_HW_ADDRESS (0x62)
+
+#if NVT_DEBUG
+#define NVT_LOG(fmt, args...)                                                 \
+	dev_err(&ts->client->dev, "[%s] %s %d: " fmt, NVT_I2C_NAME, __func__, \
+		__LINE__, ##args)
+#else
+#define NVT_LOG(fmt, args...)                                                  \
+	dev_info(&ts->client->dev, "[%s] %s %d: " fmt, NVT_I2C_NAME, __func__, \
+		 __LINE__, ##args)
+#endif
+#define NVT_ERR(fmt, args...)                                              \
+	dev_err(&ts->client->dev, "[ERROR][%s] %s %d: " fmt, NVT_I2C_NAME, \
+		__func__, __LINE__, ##args)
+
+/* Input Device Info */
+#define NVT_TS_NAME "NVTCapacitiveTouchScreen"
+
+/* Touch Info */
+#define TOUCH_MAX_WIDTH (1920)
+#define TOUCH_MAX_HEIGHT (1080)
+#define TOUCH_MAX_FINGER_NUM (10)
+
+/* Each data length in event buffer (unit: byte) */
+#define ASIL_FLAG_LEN (1)
+#define POINT_DATA_LEN (7)
+#define BUTTON_STATUS_LEN (2)
+#define TOUCH_EVENT_LEN                                            \
+	(ASIL_FLAG_LEN + (TOUCH_MAX_FINGER_NUM * POINT_DATA_LEN) + \
+	 BUTTON_STATUS_LEN)
+#define ASIL_INFO_LEN (6)
+#define CRC_VALUE_LEN (1)
+#define TOUCH_EVENT_CRC_LEN (TOUCH_EVENT_LEN + ASIL_INFO_LEN + CRC_VALUE_LEN)
+
+#define DUMMY_BYTES (1)
+#define NVT_XBUF_LEN (1025)
+
+struct nvt_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	int8_t phys[32];
+	struct notifier_block fb_notif;
+	uint8_t fw_ver;
+	uint8_t x_num;
+	uint8_t y_num;
+	uint8_t max_touch_num;
+	uint32_t int_trigger_type;
+	int32_t irq_gpio;
+	uint32_t irq_flags;
+	int32_t reset_gpio;
+	uint32_t reset_flags;
+	struct mutex lock;
+	const struct nvt_ts_mem_map *mmap;
+	enum cascade_type cascade_type;
+	enum cascade_chip_num cascade_num;
+	uint16_t nvt_pid;
+	uint8_t *xbuf;
+	struct mutex xbuf_lock;
+	bool irq_enabled;
+};
+
+enum rst_complete_state {
+	RESET_STATE_INIT = 0xA0,
+	RESET_STATE_REK,
+	RESET_STATE_REK_FINISH,
+	RESET_STATE_NORMAL_RUN,
+	RESET_STATE_MAX = 0xAF
+};
+
+enum {
+	EVENT_MAP_HOST_CMD = 0x50,
+	EVENT_MAP_HANDSHAKING_or_SUB_CMD_BYTE = 0x51,
+	EVENT_MAP_RESET_COMPLETE = 0x60,
+	EVENT_MAP_FWINFO = 0x78,
+	EVENT_MAP_CASCADE_CHIP_NUMBERS = 0x99,
+	EVENT_MAP_PROJECTID = 0x9A,
+};
+
+extern struct nvt_ts_data *ts;
+
+int32_t CTP_I2C_READ(struct i2c_client *client, uint16_t address, uint8_t *buf,
+		     uint16_t len);
+int32_t CTP_I2C_WRITE(struct i2c_client *client, uint16_t address, uint8_t *buf,
+		      uint16_t len);
+void nvt_bootloader_reset(void);
+void nvt_sw_reset_idle(void);
+int32_t nvt_clear_crc_err_flag(void);
+bool nvt_check_fw_reset_state(enum rst_complete_state check_reset_state);
+int32_t nvt_get_fw_info(void);
+int32_t nvt_check_cascade_chip_numbers(void);
+int32_t nvt_set_page(uint16_t i2c_addr, uint32_t addr);
+int32_t nvt_write_addr(uint32_t addr, uint8_t data);
+int32_t nvt_read_reg(struct nvt_ts_reg reg, uint8_t *val);
+
+void nvt_stop_crc_reboot(void);
+
+#endif /* _LINUX_NVT_TOUCH_H */
diff --git a/drivers/input/touchscreen/nt519xx_mem_map.h b/drivers/input/touchscreen/nt519xx_mem_map.h
new file mode 100644
index 000000000000..9e9847d73292
--- /dev/null
+++ b/drivers/input/touchscreen/nt519xx_mem_map.h
@@ -0,0 +1,262 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Driver for Novatek NT519xx touchscreens
+ *
+ * Copyright (C) 2023 Wei-Shih Lin <Weishih_Lin@novatek.com.tw>
+ * Copyright (C) 2023 Leo LS Chang <Leo_LS_Chang@novatek.com.tw>
+ *
+ * Copyright (C) 2010 - 2023 Novatek, Inc.
+ *
+ */
+
+#define CHIP_VER_TRIM_ADDR (0xFF004)
+#define SWRST_SIF_ADDR (0xFF0FE)
+#define BLD_SPE_PUPS_ADDR (0xFF135)
+
+enum {
+	BIT0 = 0x01,
+	BIT1 = 0x02,
+	BIT2 = 0x04,
+	BIT3 = 0x08,
+	BIT4 = 0x10,
+	BIT5 = 0x20,
+	BIT6 = 0x40,
+	BIT7 = 0x80
+};
+
+enum cascade_type {
+	CASCADE_NONE = 0x00,
+	CASCADE_ENB_CASC = 0x01,
+	CASCADE_SDLOC = 0x02,
+	CASCADE_IC_NUM = 0x03
+};
+
+enum { ENB_CASC_2CHIP = 0x00, ENB_CASC_1CHIP = 0x01 };
+
+enum { SDLOC_1CHIP = 0x04, SDLOC_2CHIP = 0x06, SDLOC_3CHIP_AND_ABOVE = 0x07 };
+
+enum {
+	IC_NUM_3CHIP = 0x00,
+	IC_NUM_1CHIP = 0x01,
+	IC_NUM_2CHIP = 0x02,
+	IC_NUM_3CHIP_AND_ABOVE = 0x03
+};
+
+enum cascade_chip_num {
+	CASCADE_CHECK_ERR = 0,
+	NONE_CASCADE_CASE = 1,
+	CASCADE_1CHIP = NONE_CASCADE_CASE,
+	CASCADE_2CHIP = 2,
+	CASCADE_3CHIP = 3,
+	CASCADE_4CHIP = 4,
+	CASCADE_5CHIP = 5,
+	CASCADE_CHIP_MAX = CASCADE_5CHIP
+};
+
+struct nvt_ts_reg {
+	uint32_t addr;
+	uint8_t bitmask;
+};
+
+struct nvt_ts_mem_map {
+	uint32_t EVENT_BUF_ADDR;
+	struct nvt_ts_reg ENB_CASC_REG;
+	struct nvt_ts_reg SDLOC_REG;
+	struct nvt_ts_reg IC_NUM_REG;
+};
+
+struct nvt_ts_hw_info {
+	enum cascade_type cascade_type;
+	enum cascade_chip_num cascade_num;
+	uint8_t default_x_num;
+	uint8_t default_y_num;
+	uint16_t default_abs_x_max;
+	uint16_t default_abs_y_max;
+	uint8_t default_max_touch_num;
+	uint8_t default_max_button_num;
+};
+
+static const struct nvt_ts_mem_map NT51900_memory_map = {
+	.EVENT_BUF_ADDR = 0x2A800,
+	.ENB_CASC_REG = { .addr = 0x3F02C, .bitmask = BIT0 },
+};
+
+static const struct nvt_ts_mem_map NT51920_1chip_memory_map = {
+	.EVENT_BUF_ADDR = 0x30500,
+	.ENB_CASC_REG = { .addr = 0x3F02C, .bitmask = BIT0 },
+};
+
+static const struct nvt_ts_mem_map NT51920_2chip_memory_map = {
+	.EVENT_BUF_ADDR = 0x30500,
+	.ENB_CASC_REG = { .addr = 0x3F02C, .bitmask = BIT0 },
+};
+
+static const struct nvt_ts_mem_map NT51923_1chip_memory_map = {
+	.EVENT_BUF_ADDR = 0x94000,
+	.SDLOC_REG = { .addr = 0xFF02C, .bitmask = (BIT2 | BIT1 | BIT0) },
+};
+
+static const struct nvt_ts_mem_map NT51923_2chip_memory_map = {
+	.EVENT_BUF_ADDR = 0x94000,
+	.SDLOC_REG = { .addr = 0xFF02C, .bitmask = (BIT2 | BIT1 | BIT0) },
+};
+
+static const struct nvt_ts_mem_map NT51923_3chip_memory_map = {
+	.EVENT_BUF_ADDR = 0x94000,
+	.SDLOC_REG = { .addr = 0xFF02C, .bitmask = (BIT2 | BIT1 | BIT0) },
+};
+
+static const struct nvt_ts_mem_map NT51926_1chip_memory_map = {
+	.EVENT_BUF_ADDR = 0x96A00,
+	.IC_NUM_REG = { .addr = 0xFF02C, .bitmask = (BIT3 | BIT2) },
+};
+
+static const struct nvt_ts_mem_map NT51926_2chip_memory_map = {
+	.EVENT_BUF_ADDR = 0x96A00,
+	.IC_NUM_REG = { .addr = 0xFF02C, .bitmask = (BIT3 | BIT2) },
+};
+
+static const struct nvt_ts_mem_map NT51926_3chip_memory_map = {
+	.EVENT_BUF_ADDR = 0x96A00,
+	.IC_NUM_REG = { .addr = 0xFF02C, .bitmask = (BIT3 | BIT2) },
+};
+
+static struct nvt_ts_hw_info NT51900_hw_info = {
+	.cascade_type = CASCADE_NONE,
+	.cascade_num = NONE_CASCADE_CASE,
+
+	.default_x_num = 40,
+	.default_y_num = 24,
+	.default_abs_x_max = 1280,
+	.default_abs_y_max = 720,
+	.default_max_button_num = 0,
+};
+
+static struct nvt_ts_hw_info NT51920_1chip_hw_info = {
+	.cascade_type = CASCADE_ENB_CASC,
+	.cascade_num = CASCADE_1CHIP,
+
+	.default_x_num = 48,
+	.default_y_num = 20,
+	.default_abs_x_max = 960,
+	.default_abs_y_max = 540,
+	.default_max_button_num = 0,
+};
+
+static struct nvt_ts_hw_info NT51920_2chip_hw_info = {
+	.cascade_type = CASCADE_ENB_CASC,
+	.cascade_num = CASCADE_2CHIP,
+
+	.default_x_num = 56,
+	.default_y_num = 21,
+	.default_abs_x_max = 2880,
+	.default_abs_y_max = 1080,
+	.default_max_button_num = 0,
+};
+
+static struct nvt_ts_hw_info NT51923_1chip_hw_info = {
+	.cascade_type = CASCADE_SDLOC,
+	.cascade_num = CASCADE_1CHIP,
+
+	.default_x_num = 24,
+	.default_y_num = 60,
+	.default_abs_x_max = 2880,
+	.default_abs_y_max = 1080,
+	.default_max_button_num = 0,
+};
+
+static struct nvt_ts_hw_info NT51923_2chip_hw_info = {
+	.cascade_type = CASCADE_SDLOC,
+	.cascade_num = CASCADE_2CHIP,
+
+	.default_x_num = 48,
+	.default_y_num = 60,
+	.default_abs_x_max = 2880,
+	.default_abs_y_max = 1080,
+	.default_max_button_num = 0,
+};
+
+static struct nvt_ts_hw_info NT51923_3chip_hw_info = {
+	.cascade_type = CASCADE_SDLOC,
+	.cascade_num = CASCADE_3CHIP,
+
+	.default_x_num = 72,
+	.default_y_num = 40,
+	.default_abs_x_max = 2880,
+	.default_abs_y_max = 1620,
+	.default_max_button_num = 0,
+};
+
+static struct nvt_ts_hw_info NT51926_1chip_hw_info = {
+	.cascade_type = CASCADE_IC_NUM,
+	.cascade_num = CASCADE_1CHIP,
+	.default_x_num = 16,
+	.default_y_num = 60,
+	.default_abs_x_max = 2880,
+	.default_abs_y_max = 1080,
+	.default_max_button_num = 0,
+};
+static struct nvt_ts_hw_info NT51926_2chip_hw_info = {
+	.cascade_type = CASCADE_IC_NUM,
+	.cascade_num = CASCADE_2CHIP,
+	.default_x_num = 32,
+	.default_y_num = 60,
+	.default_abs_x_max = 1768,
+	.default_abs_y_max = 828,
+	.default_max_button_num = 0,
+};
+static struct nvt_ts_hw_info NT51926_3chip_hw_info = {
+	.cascade_type = CASCADE_IC_NUM,
+	.cascade_num = CASCADE_3CHIP,
+	.default_x_num = 48,
+	.default_y_num = 60,
+	.default_abs_x_max = 2880,
+	.default_abs_y_max = 1080,
+	.default_max_button_num = 0,
+};
+#define NVT_ID_BYTE_MAX 6
+struct nvt_ts_trim_id_table {
+	uint8_t id[NVT_ID_BYTE_MAX];
+	uint8_t mask[NVT_ID_BYTE_MAX];
+	const struct nvt_ts_mem_map *mmap;
+	const struct nvt_ts_hw_info *hwinfo;
+};
+
+static const struct nvt_ts_trim_id_table trim_id_table[] = {
+	{ .id = { 0x00, 0x00, 0x00, 0x00, 0x19, 0x05 },
+	  .mask = { 0, 0, 0, 1, 1, 1 },
+	  .mmap = &NT51900_memory_map,
+	  .hwinfo = &NT51900_hw_info },
+	{ .id = { 0x00, 0x00, 0x01, 0x20, 0x19, 0x05 },
+	  .mask = { 0, 0, 0, 1, 1, 1 },
+	  .mmap = &NT51920_1chip_memory_map,
+	  .hwinfo = &NT51920_1chip_hw_info },
+	{ .id = { 0x00, 0x00, 0x01, 0x20, 0x19, 0x05 },
+	  .mask = { 0, 0, 0, 1, 1, 1 },
+	  .mmap = &NT51920_2chip_memory_map,
+	  .hwinfo = &NT51920_2chip_hw_info },
+	{ .id = { 0x00, 0x00, 0x00, 0x23, 0x19, 0x05 },
+	  .mask = { 0, 0, 0, 1, 1, 1 },
+	  .mmap = &NT51923_1chip_memory_map,
+	  .hwinfo = &NT51923_1chip_hw_info },
+	{ .id = { 0x00, 0x00, 0x00, 0x23, 0x19, 0x05 },
+	  .mask = { 0, 0, 0, 1, 1, 1 },
+	  .mmap = &NT51923_2chip_memory_map,
+	  .hwinfo = &NT51923_2chip_hw_info },
+	{ .id = { 0x00, 0x00, 0x00, 0x23, 0x19, 0x05 },
+	  .mask = { 0, 0, 0, 1, 1, 1 },
+	  .mmap = &NT51923_3chip_memory_map,
+	  .hwinfo = &NT51923_3chip_hw_info },
+	{ .id = { 0x00, 0x00, 0x00, 0x26, 0x19, 0x05 },
+	  .mask = { 0, 0, 0, 1, 1, 1 },
+	  .mmap = &NT51926_1chip_memory_map,
+	  .hwinfo = &NT51926_1chip_hw_info },
+	{ .id = { 0x00, 0x00, 0x00, 0x26, 0x19, 0x05 },
+	  .mask = { 0, 0, 0, 1, 1, 1 },
+	  .mmap = &NT51926_2chip_memory_map,
+	  .hwinfo = &NT51926_2chip_hw_info },
+	{ .id = { 0x00, 0x00, 0x00, 0x26, 0x19, 0x05 },
+	  .mask = { 0, 0, 0, 1, 1, 1 },
+	  .mmap = &NT51926_3chip_memory_map,
+	  .hwinfo = &NT51926_3chip_hw_info },
+};
-- 
2.26.1

