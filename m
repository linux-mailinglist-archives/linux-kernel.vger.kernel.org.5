Return-Path: <linux-kernel+bounces-118179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C288B580
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAD71C3ACD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E93127B43;
	Mon, 25 Mar 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UAjLEjUR"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DED84D36
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410151; cv=none; b=aSyw2/P5WE29RS0b+Rz7b7nvGVk5gYF17WPYfYtjN1P4wNPCV8LmMjr+hMAVRRjSpAIQzl+VGWZCQmoC2XNCXFk9449wgwb3vtwi6tRI+NrNZj7wrYmyQlbEqGTTBe4h4Sh3Fm7qegmERR2LHkpyrgl9wydnq5W5aj5V/8m65fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410151; c=relaxed/simple;
	bh=fsjkodhL8grV1QBLXNjixrtYC9NfJF+MMKlB8IzvKL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4St6vmEIy/fgolOcP5ZRbf+fU+xELTnFsXmGwCtTwOvdiNeM4evS95l6dzDXNpB469361z7DkRmLXIB6MIR252Jc2nEFJRTvFoQgd4ECuPYDhFQsd4XM+dHEbizat65hhfkZugglR1VFv/4NhT0n1U//XkuY7SARdX9MxRDBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UAjLEjUR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so3203675b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711410149; x=1712014949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ca/Lt827hCMDYh5dE02lZPJJvXokhyEjRY2l8MfDd8=;
        b=UAjLEjURH5U8jxXqja0VvfPK4oggnmtj2wusImYk/2U8ljwcjy4Y8OvC1Nk+fdwYk4
         dz4kuz2WBYLAQLnHlFkLYgpfz/3aPzIfvC/I/SXElwGrH5F+tYjyLkzhRtZZ7828ue99
         YqrCtzgtNHcQUMD3PEcZPPm8oUGcguAyJjw6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410149; x=1712014949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ca/Lt827hCMDYh5dE02lZPJJvXokhyEjRY2l8MfDd8=;
        b=pPYF7/KylZBudz2N2sUpLPIake6ongraCnnjp9Q6uFpUvEoEIkJ93XTLoym5Tveehw
         fznPHsAhrVfw5+k31ww/Usjv4gd6KeBdp9MsVStLr+MafelzHy90Mb9H3rBlcd89935P
         mpBNBtyvXmzRC6CJDkOcvRiDchY9dztJFK1D45dc5OF2tIYtscU4DDeBDrQwftrZ+O0W
         cUXwh3dGy+ymbPPq3l3QpYkGTyNl4B9bnEcP+AOSZHE/wUqbQ1V2f3SgUfs1zNKe67zc
         NQrfB0I2PJtll47ejMIGbSxG0u1n5ApVvmF3WDhAyy3LQ6qIkqZuuXTPmGZ/zNmILnOz
         /l3g==
X-Gm-Message-State: AOJu0YyyQKzQkm/qCsX0OIc2diMbFrXREg4+YhP1ALy+SHQ4E7fjjSTX
	8PPyXAdY9uDOlP1ym0pr1VXmQI48XJABd3V5SyX9Hnbc7xmjKh1kCr145dx+yw==
X-Google-Smtp-Source: AGHT+IFwYOye/EwjEDySLlO26UqAhGZnkSQngTI9ec0QPp9cogBBG7/AB25Te6NR1yj2dOb/oFbMxw==
X-Received: by 2002:a05:6a00:92a8:b0:6ea:b82d:6205 with SMTP id jw40-20020a056a0092a800b006eab82d6205mr1142055pfb.16.1711410149156;
        Mon, 25 Mar 2024 16:42:29 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id e12-20020aa7824c000000b006e5f754646csm4705250pfn.139.2024.03.25.16.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:42:28 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Date: Mon, 25 Mar 2024 23:42:27 +0000
Subject: [PATCH v2 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-public-ucsi-h-v2-3-a6d716968bb1@chromium.org>
References: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
In-Reply-To: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 chrome-platform@lists.linux.dev, Pavan Holla <pholla@chromium.org>
X-Mailer: b4 0.12.4

Implementation of transport driver for UCSI. This driver will be used
if the ChromeOS EC implements a PPM.

Signed-off-by: Pavan Holla <pholla@chromium.org>
---
 drivers/platform/chrome/Kconfig                |  14 ++
 drivers/platform/chrome/Makefile               |   1 +
 drivers/platform/chrome/cros_ec_ucsi.c         | 247 +++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  19 ++
 4 files changed, 281 insertions(+)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 7a83346bfa53..67ab79a6815b 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -238,6 +238,20 @@ config CROS_EC_TYPEC
 	  To compile this driver as a module, choose M here: the module will be
 	  called cros-ec-typec.
 
+config CROS_EC_UCSI
+	tristate "UCSI Driver for ChromeOS EC"
+	depends on MFD_CROS_EC_DEV
+	depends on CROS_USBPD_NOTIFY
+	depends on TYPEC_UCSI
+	depends on !EXTCON_TCSS_CROS_EC
+	default MFD_CROS_EC_DEV
+	help
+	  This driver enables UCSI support for a ChromeOS EC. The EC is
+	  expected to implement a PPM.
+
+	  To compile the driver as a module, choose M here: the module
+	  will be called cros_ec_ucsi.
+
 config CROS_HPS_I2C
 	tristate "ChromeOS HPS device"
 	depends on HID && I2C && PM
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 2dcc6ccc2302..85964e165a70 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_CROS_EC_UART)		+= cros_ec_uart.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
 cros-ec-typec-objs			:= cros_ec_typec.o cros_typec_vdm.o
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros-ec-typec.o
+obj-$(CONFIG_CROS_EC_UCSI)		+= cros_ec_ucsi.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
diff --git a/drivers/platform/chrome/cros_ec_ucsi.c b/drivers/platform/chrome/cros_ec_ucsi.c
new file mode 100644
index 000000000000..9fee300a3d93
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_ucsi.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UCSI driver for ChromeOS EC
+ *
+ * Copyright 2024 Google LLC.
+ */
+
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_usbpd_notify.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/usb/ucsi.h>
+#include <linux/wait.h>
+
+#define DRV_NAME "cros-ec-ucsi"
+
+#define MAX_EC_DATA_SIZE 256
+#define WRITE_TMO_MS 500
+
+#define COMMAND_PENDING 1
+#define ACK_PENDING     2
+
+#define UCSI_COMMAND(_cmd_) ((_cmd_) & 0xff)
+#define UCSI_ACK_CC_CI 0x04
+
+struct cros_ucsi_data {
+	struct device *dev;
+	struct ucsi *ucsi;
+
+	struct cros_ec_device *ec;
+	struct notifier_block nb;
+	struct work_struct work;
+
+	struct completion complete;
+	unsigned long flags;
+};
+
+static int cros_ucsi_read(struct ucsi *ucsi, unsigned int offset, void *val,
+			  size_t val_len)
+{
+	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
+	struct ec_params_ucsi_ppm_get req = {
+		.offset = offset,
+		.size = val_len,
+	};
+	int ret;
+
+	if (val_len > MAX_EC_DATA_SIZE) {
+		dev_err(udata->dev, "Can't read %zu bytes. Too big.", val_len);
+		return -EINVAL;
+	}
+
+	ret = cros_ec_cmd(udata->ec, 0, EC_CMD_UCSI_PPM_GET,
+			  &req, sizeof(req), val, val_len);
+	if (ret < 0) {
+		dev_warn(udata->dev, "Failed to send EC message UCSI_PPM_GET: error=%d", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int cros_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
+				 const void *val, size_t val_len)
+{
+	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
+	uint8_t ec_buffer[MAX_EC_DATA_SIZE + sizeof(struct ec_params_ucsi_ppm_set)];
+	struct ec_params_ucsi_ppm_set *req = (struct ec_params_ucsi_ppm_set *)ec_buffer;
+	int ret = 0;
+
+	if (val_len > MAX_EC_DATA_SIZE) {
+		dev_err(udata->dev, "Can't write %zu bytes. Too big.", val_len);
+		return -EINVAL;
+	}
+
+	memset(req, 0, sizeof(ec_buffer));
+	req->offset = offset;
+	memcpy(req->data, val, val_len);
+	ret = cros_ec_cmd(udata->ec, 0, EC_CMD_UCSI_PPM_SET,
+			  req, sizeof(struct ec_params_ucsi_ppm_set) + val_len, NULL, 0);
+
+	if (ret < 0) {
+		dev_warn(udata->dev, "Failed to send EC message UCSI_PPM_SET: error=%d", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int cros_ucsi_sync_write(struct ucsi *ucsi, unsigned int offset,
+				const void *val, size_t val_len)
+{
+	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
+	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
+	int ret;
+
+	if (ack)
+		set_bit(ACK_PENDING, &udata->flags);
+	else
+		set_bit(COMMAND_PENDING, &udata->flags);
+
+	ret = cros_ucsi_async_write(ucsi, offset, val, val_len);
+	if (ret)
+		goto out;
+
+	if (!wait_for_completion_timeout(&udata->complete, WRITE_TMO_MS))
+		ret = -ETIMEDOUT;
+
+out:
+	if (ack)
+		clear_bit(ACK_PENDING, &udata->flags);
+	else
+		clear_bit(COMMAND_PENDING, &udata->flags);
+	return ret;
+}
+
+struct ucsi_operations cros_ucsi_ops = {
+	.read = cros_ucsi_read,
+	.async_write = cros_ucsi_async_write,
+	.sync_write = cros_ucsi_sync_write,
+};
+
+static void cros_ucsi_work(struct work_struct *work)
+{
+	struct cros_ucsi_data *udata = container_of(work, struct cros_ucsi_data, work);
+	u32 cci;
+	int ret;
+
+	ret = cros_ucsi_read(udata->ucsi, UCSI_CCI, &cci, sizeof(cci));
+	if (ret)
+		return;
+
+	if (UCSI_CCI_CONNECTOR(cci))
+		ucsi_connector_change(udata->ucsi, UCSI_CCI_CONNECTOR(cci));
+
+	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &udata->flags))
+		complete(&udata->complete);
+	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
+	    test_bit(COMMAND_PENDING, &udata->flags))
+		complete(&udata->complete);
+}
+
+static int cros_ucsi_event(struct notifier_block *nb,
+			   unsigned long host_event, void *_notify)
+{
+	struct cros_ucsi_data *udata = container_of(nb, struct cros_ucsi_data, nb);
+
+	if (!(host_event & PD_EVENT_PPM))
+		return NOTIFY_OK;
+
+	dev_dbg(udata->dev, "UCSI notification received");
+	flush_work(&udata->work);
+	schedule_work(&udata->work);
+
+	return NOTIFY_OK;
+}
+
+static int cros_ucsi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ucsi_data *udata;
+	int ret;
+
+	udata = devm_kzalloc(dev, sizeof(*udata), GFP_KERNEL);
+	if (!udata)
+		return -ENOMEM;
+
+	udata->dev = dev;
+
+	udata->ec = ((struct cros_ec_dev *) dev_get_drvdata(pdev->dev.parent))->ec_dev;
+	if (!udata->ec) {
+		dev_err(dev, "couldn't find parent EC device\n");
+		return -ENODEV;
+	}
+
+	platform_set_drvdata(pdev, udata);
+
+	INIT_WORK(&udata->work, cros_ucsi_work);
+	init_completion(&udata->complete);
+
+	udata->ucsi = ucsi_create(udata->dev, &cros_ucsi_ops);
+	if (IS_ERR(udata->ucsi)) {
+		dev_err(dev, "failed to allocate UCSI instance\n");
+		return PTR_ERR(udata->ucsi);
+	}
+
+	ucsi_set_drvdata(udata->ucsi, udata);
+
+	ret = ucsi_register(udata->ucsi);
+	if (ret) {
+		ucsi_destroy(udata->ucsi);
+		udata->ucsi = NULL;
+		return ret;
+	}
+
+	udata->nb.notifier_call = cros_ucsi_event;
+	ret = cros_usbpd_register_notify(&udata->nb);
+	return ret;
+}
+
+static int cros_ucsi_remove(struct platform_device *dev)
+{
+	struct cros_ucsi_data *udata = platform_get_drvdata(dev);
+
+	if (udata->ucsi) {
+		ucsi_unregister(udata->ucsi);
+		ucsi_destroy(udata->ucsi);
+		udata->ucsi = NULL;
+	}
+	return 0;
+}
+
+static int cros_ucsi_suspend(struct device *dev)
+{
+	struct cros_ucsi_data *udata = dev_get_drvdata(dev);
+
+	cancel_work_sync(&udata->work);
+
+	return 0;
+}
+
+static int cros_ucsi_resume(struct device *dev)
+{
+	struct cros_ucsi_data *udata = dev_get_drvdata(dev);
+
+	return ucsi_resume(udata->ucsi);
+}
+
+static SIMPLE_DEV_PM_OPS(cros_ucsi_pm_ops, cros_ucsi_suspend,
+			 cros_ucsi_resume);
+
+static struct platform_driver cros_ucsi_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.pm = &cros_ucsi_pm_ops,
+	},
+	.probe = cros_ucsi_probe,
+	.remove = cros_ucsi_remove,
+};
+
+module_platform_driver(cros_ucsi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("UCSI driver for ChromeOS EC.");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ecc47d5fe239..39f6f54bbe4c 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4933,6 +4933,7 @@ struct ec_response_pd_status {
 #define PD_EVENT_POWER_CHANGE      BIT(1)
 #define PD_EVENT_IDENTITY_RECEIVED BIT(2)
 #define PD_EVENT_DATA_SWAP         BIT(3)
+#define PD_EVENT_PPM               BIT(5)
 struct ec_response_host_event_status {
 	uint32_t status;      /* PD MCU host event status */
 } __ec_align4;
@@ -5994,6 +5995,24 @@ struct ec_response_typec_vdm_response {
 
 #undef VDO_MAX_SIZE
 
+/*
+ * Read/write interface for UCSI OPM <-> PPM communication.
+ */
+#define EC_CMD_UCSI_PPM_SET 0x0140
+
+/* The data size is stored in the host command protocol header. */
+struct ec_params_ucsi_ppm_set {
+	uint16_t offset;
+	uint8_t data[];
+} __ec_align2;
+
+#define EC_CMD_UCSI_PPM_GET 0x0141
+
+struct ec_params_ucsi_ppm_get {
+	uint16_t offset;
+	uint8_t size;
+} __ec_align2;
+
 /*****************************************************************************/
 /* The command range 0x200-0x2FF is reserved for Rotor. */
 

-- 
2.44.0.396.g6e790dbe36-goog


