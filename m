Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0628811BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379339AbjLMSBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378951AbjLMSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:01:39 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B440DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:41 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35f6993ee96so8274345ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702490500; x=1703095300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5qK8QS6dwScbIe3rQCRc5uzPcj/O6N72QtvEWBOA2c=;
        b=L+u1mDoOzdc9sgPAeI1y4kLKqvddgUALb7hBH63ECeetoWifVdm05MTaLkvg2vQLu4
         bawTNXI1nuG5281ECpdY8g9Tdfx0AKnRx+B1IcKzXNUFBWTAkFahaomUmcGOKWY9/7wE
         QCjPRew/+n8ojf7QY2nFMmUbk8At7s+/+RY4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490500; x=1703095300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5qK8QS6dwScbIe3rQCRc5uzPcj/O6N72QtvEWBOA2c=;
        b=MJ6a/j0QOmyXe60t28IJQzx8vEiXhS0+yjHpR5nMNMdB54O5ld0Sb03YUXY2nBV7NH
         IUrHp+bAE+x1udin/NErFfW2ykd9hb/vUUcKwZut3X5dv1XBUYewLwxx/Snz8GX+3Mwl
         oSQPa87qQOv5uDE5/faOLYLO7hEp/uz3AxBb4xTuTq7Sf0Izmwlc7mH7cuBAXRT6Uqmu
         gChpZveLqvfXIciNsKBIMqaWVXBv7u0kd/OZ7eWp5p82EOx+kbbkaoyYBWUN5Tn+nM8D
         w0W6sjm9XPImMmlu9D1KSHqmy/GFQjGWeWNsas2MdmLWiEDKYj2V2z1rIQKlOx04xOdc
         XvAQ==
X-Gm-Message-State: AOJu0Yxeo70umI1yN379Jc9NjaQZYCGbMUISb9ubuBQZwcYK7V5BMyd2
        ayKVnukn48pTD66xL/yhcur6FxfMcU0Xg+9CcD8=
X-Google-Smtp-Source: AGHT+IHwwQCGAqk3K2H7z+oyei3zs1SVekAYtXUGN/4qtITuv4SPfFUvXBs9uNjiMLZyb44/Rk+5tw==
X-Received: by 2002:a05:6e02:1a6e:b0:35d:5995:904d with SMTP id w14-20020a056e021a6e00b0035d5995904dmr7513188ilv.64.1702490500074;
        Wed, 13 Dec 2023 10:01:40 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.224])
        by smtp.gmail.com with ESMTPSA id o28-20020a02cc3c000000b0046671f9717csm3161206jap.109.2023.12.13.10.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:01:39 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Rob Barnes <robbarnes@google.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v1 6/6] platform/chrome: cros_ec: Use PM subsystem to manage wakeirq
Date:   Wed, 13 Dec 2023 11:00:24 -0700
Message-ID: <20231213110009.v1.6.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros ec driver is manually managing the wake irq by calling
enable_irq_wake/disable_irq_wake during suspend/resume.

Modify the driver to use the power management subsystem to manage the
wakeirq.

The wake capability of the interrupt is provided by the underlying
firmware/device tree. Some Chromebooks rely solely on the ec_sync pin to
wake the AP but they do not specify the interrupt as wake capable in the
ACPI _CRS or device tree. For LPC/ACPI based systems a DMI quirk is
introduced listing boards whose firmware should not be trusted to
provide correct wake capable values.

The irq wake logic was added on an interface basis (lpc, spi, uart) as
opposed to adding it to cros_ec.c because the i2c subsystem already does
this work on our behalf.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 drivers/platform/chrome/cros_ec.c           |  9 ----
 drivers/platform/chrome/cros_ec_lpc.c       | 51 +++++++++++++++++++--
 drivers/platform/chrome/cros_ec_spi.c       | 48 +++++++++++++++----
 drivers/platform/chrome/cros_ec_uart.c      | 34 ++++++++++++--
 include/linux/platform_data/cros_ec_proto.h |  2 -
 5 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index badc68bbae8cc..f24d2f2084399 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -353,12 +353,6 @@ EXPORT_SYMBOL(cros_ec_suspend_prepare);
 
 static void cros_ec_disable_irq(struct cros_ec_device *ec_dev)
 {
-	struct device *dev = ec_dev->dev;
-	if (device_may_wakeup(dev))
-		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
-	else
-		ec_dev->wake_enabled = false;
-
 	disable_irq(ec_dev->irq);
 	ec_dev->suspended = true;
 }
@@ -440,9 +434,6 @@ static void cros_ec_enable_irq(struct cros_ec_device *ec_dev)
 	ec_dev->suspended = false;
 	enable_irq(ec_dev->irq);
 
-	if (ec_dev->wake_enabled)
-		disable_irq_wake(ec_dev->irq);
-
 	/*
 	 * Let the mfd devices know about events that occur during
 	 * suspend. This way the clients know what to do with them.
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index ed498278a223f..d5beae1b779d3 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -21,6 +21,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/printk.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
@@ -50,6 +51,27 @@ static struct lpc_driver_ops cros_ec_lpc_ops = { };
 
 static struct platform_device *pdev_extcon;
 
+static const struct dmi_system_id untrusted_fw_irq_wake_capable[] = {
+	{
+		.ident = "Brya",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya")
+		}
+	},
+	{
+		.ident = "Brask",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brask")
+		}
+	}
+}
+MODULE_DEVICE_TABLE(dmi, untrusted_fw_irq_wake_capable);
+
+static bool cros_ec_should_force_irq_wake_capable(void)
+{
+	return dmi_first_match(untrusted_fw_irq_wake_capable) != NULL;
+}
+
 /*
  * A generic instance of the read function of struct lpc_driver_ops, used for
  * the LPC EC.
@@ -352,9 +374,11 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 static int cros_ec_lpc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	bool irq_wake = false;
 	struct acpi_device *adev;
 	acpi_status status;
 	struct cros_ec_device *ec_dev;
+	struct resource irqres;
 	u8 buf[2] = {};
 	int irq, ret;
 
@@ -430,20 +454,36 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	 * Some boards do not have an IRQ allotted for cros_ec_lpc,
 	 * which makes ENXIO an expected (and safe) scenario.
 	 */
-	irq = platform_get_irq_optional(pdev, 0);
-	if (irq > 0)
+	irq = platform_get_irq_resource(pdev, 0, &irqres);
+	if (irq > 0) {
 		ec_dev->irq = irq;
-	else if (irq != -ENXIO) {
+		if (cros_ec_should_force_irq_wake_capable())
+			irq_wake = true;
+		else
+			irq_wake = irqres.flags & IORESOURCE_IRQ_WAKECAPABLE;
+		dev_dbg(dev, "IRQ: %i, wake_capable: %i\n", irq, irq_wake);
+	} else if (irq != -ENXIO) {
 		dev_err(dev, "couldn't retrieve IRQ number (%d)\n", irq);
 		return irq;
 	}
 
 	ret = cros_ec_register(ec_dev);
 	if (ret) {
-		dev_err(dev, "couldn't register ec_dev (%d)\n", ret);
+		dev_err_probe(dev, ret, "couldn't register ec_dev (%d)\n", ret);
 		return ret;
 	}
 
+	if (irq_wake) {
+		ret = device_init_wakeup(dev, true);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to init device for wakeup");
+			return ret;
+		}
+		ret = dev_pm_set_wake_irq(dev, irq);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Connect a notify handler to process MKBP messages if we have a
 	 * companion ACPI device.
@@ -472,6 +512,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 static int cros_ec_lpc_remove(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec_dev = platform_get_drvdata(pdev);
+	struct device *dev = ec_dev->dev;
 	struct acpi_device *adev;
 
 	platform_device_unregister(pdev_extcon);
@@ -481,6 +522,8 @@ static int cros_ec_lpc_remove(struct platform_device *pdev)
 		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   cros_ec_lpc_acpi_notify);
 
+	dev_pm_clear_wake_irq(dev);
+	device_init_wakeup(dev, false);
 	cros_ec_unregister(ec_dev);
 
 	return 0;
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 3e88cc92e8192..f99296ab0b8ec 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -7,9 +7,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <uapi/linux/sched/types.h>
@@ -70,6 +72,7 @@
  * @end_of_msg_delay: used to set the delay_usecs on the spi_transfer that
  *      is sent when we want to turn off CS at the end of a transaction.
  * @high_pri_worker: Used to schedule high priority work.
+ * @irq_wake: Whether or not irq assertion should wake the system.
  */
 struct cros_ec_spi {
 	struct spi_device *spi;
@@ -77,6 +80,7 @@ struct cros_ec_spi {
 	unsigned int start_of_msg_delay;
 	unsigned int end_of_msg_delay;
 	struct kthread_worker *high_pri_worker;
+	bool irq_wake;
 };
 
 typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
@@ -689,12 +693,17 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
 }
 
-static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
+static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct spi_device *spi)
 {
-	struct device_node *np = dev->of_node;
+	struct cros_ec_device *ec_dev = spi_get_drvdata(spi);
+	struct device_node *np = spi->dev.of_node;
+	struct resource irqres;
 	u32 val;
 	int ret;
 
+	if (!np)
+		return;
+
 	ret = of_property_read_u32(np, "google,cros-ec-spi-pre-delay", &val);
 	if (!ret)
 		ec_spi->start_of_msg_delay = val;
@@ -702,6 +711,17 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 	ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
 	if (!ret)
 		ec_spi->end_of_msg_delay = val;
+
+	if (ec_dev->irq > 0) {
+		ret = of_irq_to_resource(np, 0, &irqres);
+		if (ret != ec_dev->irq) {
+			dev_err(&spi->dev, "irq mismatch detecting wake capability(%d != %d)\n",
+					ret, ec_dev->irq);
+			return;
+		}
+		ec_spi->irq_wake = irqres.flags & IORESOURCE_IRQ_WAKECAPABLE;
+		dev_dbg(&spi->dev, "IRQ: %i, wake_capable: %i\n", ec_dev->irq, ec_spi->irq_wake);
+	}
 }
 
 static void cros_ec_spi_high_pri_release(void *worker)
@@ -753,9 +773,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	if (!ec_dev)
 		return -ENOMEM;
 
-	/* Check for any DT properties */
-	cros_ec_spi_dt_probe(ec_spi, dev);
-
 	spi_set_drvdata(spi, ec_dev);
 	ec_dev->dev = dev;
 	ec_dev->priv = ec_spi;
@@ -768,6 +785,9 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 			   sizeof(struct ec_response_get_protocol_info);
 	ec_dev->dout_size = sizeof(struct ec_host_request);
 
+	/* Check for any DT properties */
+	cros_ec_spi_dt_probe(ec_spi, spi);
+
 	ec_spi->last_transfer_ns = ktime_get_ns();
 
 	err = cros_ec_spi_devm_high_pri_alloc(dev, ec_spi);
@@ -776,19 +796,31 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 
 	err = cros_ec_register(ec_dev);
 	if (err) {
-		dev_err(dev, "cannot register EC\n");
+		dev_err_probe(dev, err, "cannot register EC\n");
 		return err;
 	}
 
-	device_init_wakeup(&spi->dev, true);
+	if (ec_spi->irq_wake) {
+		err = device_init_wakeup(dev, true);
+		if (err) {
+			dev_err_probe(dev, err, "Failed to init device for wakeup\n");
+			return err;
+		}
+		err = dev_pm_set_wake_irq(dev, ec_dev->irq);
+		if (err)
+			dev_err_probe(dev, err, "Failed to set irq(%d) for wake\n", ec_dev->irq);
+	}
 
-	return 0;
+	return err;
 }
 
 static void cros_ec_spi_remove(struct spi_device *spi)
 {
 	struct cros_ec_device *ec_dev = spi_get_drvdata(spi);
+	struct device *dev = ec_dev->dev;
 
+	dev_pm_clear_wake_irq(dev);
+	device_init_wakeup(dev, false);
 	cros_ec_unregister(ec_dev);
 }
 
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 788246559bbba..54255f523d8b7 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 #include <uapi/linux/sched/types.h>
@@ -70,6 +71,7 @@ struct response_info {
  * @baudrate:		UART baudrate of attached EC device.
  * @flowcontrol:	UART flowcontrol of attached device.
  * @irq:		Linux IRQ number of associated serial device.
+ * @irq_wake:		Whether or not irq assertion should wake the system.
  * @response:		Response info passing between cros_ec_uart_pkt_xfer()
  *			and cros_ec_uart_rx_bytes()
  */
@@ -78,6 +80,7 @@ struct cros_ec_uart {
 	u32 baudrate;
 	u8 flowcontrol;
 	u32 irq;
+	bool irq_wake;
 	struct response_info response;
 };
 
@@ -225,8 +228,10 @@ static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
 static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
 {
 	int ret;
+	struct resource irqres;
 	LIST_HEAD(resources);
-	struct acpi_device *adev = ACPI_COMPANION(&ec_uart->serdev->dev);
+	struct device *dev = &ec_uart->serdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 
 	ret = acpi_dev_get_resources(adev, &resources, cros_ec_uart_resource, ec_uart);
 	if (ret < 0)
@@ -235,12 +240,13 @@ static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
 	acpi_dev_free_resource_list(&resources);
 
 	/* Retrieve GpioInt and translate it to Linux IRQ number */
-	ret = acpi_dev_gpio_irq_get(adev, 0);
+	ret = acpi_dev_get_gpio_irq_resource(adev, NULL, 0, &irqres);
 	if (ret < 0)
 		return ret;
 
-	ec_uart->irq = ret;
-	dev_dbg(&ec_uart->serdev->dev, "IRQ number %d\n", ec_uart->irq);
+	ec_uart->irq = irqres.start;
+	ec_uart->irq_wake = irqres.flags & IORESOURCE_IRQ_WAKECAPABLE;
+	dev_dbg(dev, "IRQ: %i, wake_capable: %i\n", ec_uart->irq, ec_uart->irq_wake);
 
 	return 0;
 }
@@ -302,13 +308,31 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 
 	serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
 
-	return cros_ec_register(ec_dev);
+	/* Register a new cros_ec device */
+	ret = cros_ec_register(ec_dev);
+	if (ret) {
+		dev_err(dev, "Couldn't register ec_dev (%d)\n", ret);
+		return ret;
+	}
+
+	if (ec_uart->irq_wake) {
+		ret = device_init_wakeup(dev, true);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to init device for wakeup");
+			return ret;
+		}
+		ret = dev_pm_set_wake_irq(dev, ec_uart->irq);
+	}
+	return ret;
 }
 
 static void cros_ec_uart_remove(struct serdev_device *serdev)
 {
 	struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
+	struct device *dev = ec_dev->dev;
 
+	dev_pm_clear_wake_irq(dev);
+	device_init_wakeup(dev, false);
 	cros_ec_unregister(ec_dev);
 };
 
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 4f9f756bc17ce..a9d952a0f6eda 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -115,7 +115,6 @@ struct cros_ec_command {
  *        performance advantage to using dword.
  * @din_size: Size of din buffer to allocate (zero to use static din).
  * @dout_size: Size of dout buffer to allocate (zero to use static dout).
- * @wake_enabled: True if this device can wake the system from sleep.
  * @suspended: True if this device had been suspended.
  * @cmd_xfer: Send command to EC and get response.
  *            Returns the number of bytes received if the communication
@@ -173,7 +172,6 @@ struct cros_ec_device {
 	u8 *dout;
 	int din_size;
 	int dout_size;
-	bool wake_enabled;
 	bool suspended;
 	int (*cmd_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
-- 
2.43.0.472.g3155946c3a-goog

