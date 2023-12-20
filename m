Return-Path: <linux-kernel+bounces-7675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76381AB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BFB1C23C30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F369524BA;
	Wed, 20 Dec 2023 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/KtLs3a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CAB50266
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7b7fdde8b26so7348139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116528; x=1703721328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4LntbTWAkvb3ubuXcE2yEZinwRXbecjdU87OrYLeRQ=;
        b=A/KtLs3a+q5u2Z+kgFF4rdclXeigCtkHU8l7JKORaO1NCAr+ZxtHqfHnU9W3idaX/6
         rxTJzNpS9gBeG+HBAR/+ETpJNKNkMO3wIaMHOsJDptSwaGPnCpLtw96y1CJsKfKf7GtN
         XX+YT0jrjPeO/jvZ8cFXSAHe/gw0KRoycOYm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116528; x=1703721328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4LntbTWAkvb3ubuXcE2yEZinwRXbecjdU87OrYLeRQ=;
        b=DvB9wzFB9atVOAVZz+nTtCXvFMy4XjIVEX0NHMJiCEMbFF7+OXF8YEPvTdFHylYjLo
         IrulHbsfVgrCzCT2qfDmxE0sIzkZFGFvXXR9/jzuNA6s4BdF0qWWibZsLIJmq0bI8bgb
         a1sQQjP5Ja0vaZJtrELvQaJf8EYahe89W51DH7VpviZDuYkoxoZFbX/tmIwAkJDO67HU
         v9PbKnv2EzF75ifZciFO+DXo/O8DiFDWT/qSCgfMnVnCSBQHX4L9nCIJTIcS98/KOWZj
         RVE6BYjkT3YtRO5HZWwilaIh5nSbjVAQRbckx6YjTd5NSuNzdr+6cYixfDyqmNgl2IUm
         LqdA==
X-Gm-Message-State: AOJu0YwOabgqfz7yvZNZ4BtPVprcf3OHLkLB7FgJWOJUH/BcALF/UIWU
	YOwXDvqmGB3wXRRBPq0V6BRE9rmbTkOg38ultWE=
X-Google-Smtp-Source: AGHT+IFAx/PaxXX+lr5qfGthnr+ElVsLssqVolh6NkqV0cO+WfS28o1kqCpFuafVxI51uDFrBehZvg==
X-Received: by 2002:a6b:5f10:0:b0:7ba:8569:8b37 with SMTP id t16-20020a6b5f10000000b007ba85698b37mr298479iob.25.1703116528068;
        Wed, 20 Dec 2023 15:55:28 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:27 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Hasemeyer <markhas@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Lee Jones <lee@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Barnes <robbarnes@google.com>,
	Stephen Boyd <swboyd@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsystem to manage wakeirq
Date: Wed, 20 Dec 2023 16:54:36 -0700
Message-ID: <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231220235459.2965548-1-markhas@chromium.org>
References: <20231220235459.2965548-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros ec driver is manually managing the wake IRQ by calling
enable_irq_wake()/disable_irq_wake() during suspend/resume.

Modify the driver to use the power management subsystem to manage the
wakeirq.

Rather than assuming that the IRQ is wake capable, use the underlying
firmware/device tree to determine whether or not to enable it as a wake
source. Some Chromebooks rely solely on the ec_sync pin to wake the AP
but do not specify the interrupt as wake capable in the ACPI _CRS. For
LPC/ACPI based systems a DMI quirk is introduced listing boards whose
firmware should not be trusted to provide correct wake capable values.
For device tree base systems, it is not an issue as the relevant device
tree entries have been updated and DTS is built from source for each
ChromeOS update.

The IRQ wake logic was added on an interface basis (lpc, spi, uart) as
opposed to adding it to cros_ec.c because the i2c subsystem already
enables the wakirq (if applicable) on our behalf.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v2:
-Rebase on linux-next
-Add cover letter
-See each patch for patch specific changes
-Look for 'wakeup-source' property in cros_ec_spi.c

 drivers/platform/chrome/cros_ec.c           |  9 ----
 drivers/platform/chrome/cros_ec_lpc.c       | 52 +++++++++++++++++++--
 drivers/platform/chrome/cros_ec_spi.c       | 41 ++++++++++++----
 drivers/platform/chrome/cros_ec_uart.c      | 34 ++++++++++++--
 include/linux/platform_data/cros_ec_proto.h |  2 -
 5 files changed, 110 insertions(+), 28 deletions(-)

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
index f0f3d3d561572..fec5aefd6f177 100644
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
@@ -48,6 +49,28 @@ struct lpc_driver_ops {
 
 static struct lpc_driver_ops cros_ec_lpc_ops = { };
 
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
+	},
+	{ }
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
@@ -350,9 +373,11 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
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
 
@@ -428,20 +453,36 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	 * Some boards do not have an IRQ allotted for cros_ec_lpc,
 	 * which makes ENXIO an expected (and safe) scenario.
 	 */
-	irq = platform_get_irq_optional(pdev, 0);
-	if (irq > 0)
+	irq = platform_get_irq_resource_optional(pdev, 0, &irqres);
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
@@ -463,6 +504,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 static void cros_ec_lpc_remove(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec_dev = platform_get_drvdata(pdev);
+	struct device *dev = ec_dev->dev;
 	struct acpi_device *adev;
 
 	adev = ACPI_COMPANION(&pdev->dev);
@@ -470,6 +512,8 @@ static void cros_ec_lpc_remove(struct platform_device *pdev)
 		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   cros_ec_lpc_acpi_notify);
 
+	dev_pm_clear_wake_irq(dev);
+	device_init_wakeup(dev, false);
 	cros_ec_unregister(ec_dev);
 }
 
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 3e88cc92e8192..0aad8b2f007f6 100644
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
@@ -689,12 +693,16 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
 }
 
-static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
+static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct spi_device *spi)
 {
-	struct device_node *np = dev->of_node;
+	struct cros_ec_device *ec_dev = spi_get_drvdata(spi);
+	struct device_node *np = spi->dev.of_node;
 	u32 val;
 	int ret;
 
+	if (!np)
+		return;
+
 	ret = of_property_read_u32(np, "google,cros-ec-spi-pre-delay", &val);
 	if (!ret)
 		ec_spi->start_of_msg_delay = val;
@@ -702,6 +710,11 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 	ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
 	if (!ret)
 		ec_spi->end_of_msg_delay = val;
+
+	if (ec_dev->irq > 0 && of_property_read_bool(np, "wakeup-source")) {
+		ec_spi->irq_wake = true;
+		dev_dbg(&spi->dev, "IRQ: %i, wake_capable: %i\n", ec_dev->irq, ec_spi->irq_wake);
+	}
 }
 
 static void cros_ec_spi_high_pri_release(void *worker)
@@ -753,9 +766,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	if (!ec_dev)
 		return -ENOMEM;
 
-	/* Check for any DT properties */
-	cros_ec_spi_dt_probe(ec_spi, dev);
-
 	spi_set_drvdata(spi, ec_dev);
 	ec_dev->dev = dev;
 	ec_dev->priv = ec_spi;
@@ -768,6 +778,9 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 			   sizeof(struct ec_response_get_protocol_info);
 	ec_dev->dout_size = sizeof(struct ec_host_request);
 
+	/* Check for any DT properties */
+	cros_ec_spi_dt_probe(ec_spi, spi);
+
 	ec_spi->last_transfer_ns = ktime_get_ns();
 
 	err = cros_ec_spi_devm_high_pri_alloc(dev, ec_spi);
@@ -776,19 +789,31 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 
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
index 68d80559fddc2..ced53bb40b2ef 100644
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
 
@@ -224,8 +227,10 @@ static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
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
@@ -234,12 +239,13 @@ static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
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
@@ -301,13 +307,31 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 
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
index 8865e350c12a5..91e32db4ef715 100644
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


