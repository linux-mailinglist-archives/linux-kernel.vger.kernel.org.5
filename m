Return-Path: <linux-kernel+bounces-14848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C28822326
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C99A280F28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9791A5BE;
	Tue,  2 Jan 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PAfFIwoc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B2E1A27D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ba903342c2so711978739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229745; x=1704834545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gYVKYJQzeswl0d2/E7tMkWp3ZqYQjIB7uAjyZVlcw4=;
        b=PAfFIwocWHybLVBVF3+pQWecm7obgM9gBARpFcuydHBhTwMegiEn/TSeOryKURawSN
         pOo6iyAsT+RsEpJ+nvuQ1JoMuNfsH5ny7QrkENStE3bVViI0pCcZUCftQFNfDx/9/rWn
         lx7k6pgCzbZ078uPHvFt3AJlScXJgOQ5xJn+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229745; x=1704834545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gYVKYJQzeswl0d2/E7tMkWp3ZqYQjIB7uAjyZVlcw4=;
        b=Sw8pQfu0C16PW1GlKdjU/IY3YvlBfEc/UDjER77dk2QxTPn9+z3hccuhcmYNmX+xuL
         AhpQEfPc9zozLIrioWyCxsfgqaF2p5ADKLoJl5f6rLzW7EFDyr+7Ky8L+N/u0PtFr1cg
         XkdZrpc9LZ7b7j93t8V6LhawKqOdR+YjhaC9k3PEuKCPNGigMowxHONxwE9PSoQazYCO
         P+frsrtp7p5IJ7yoDlGvijKp6E5nEa69blhYiAC7fIAGpuMeE7kBEU7PQpvI0bGtuIH1
         HpWN2W4Ga7ScQdfKJI8pPT6YPBy0N/8I6X+l/SlM28i//D2ICVY46P/192wLbC4nJY8T
         QCqA==
X-Gm-Message-State: AOJu0YwZJjC314jb1hh5WIkWJ/OVq9NrAFbjkTTOMeUZy6wFLyRLbSaX
	YhRGv4NajC9KcNZPI9IoJLb6e9Bof0FN5Gy2kSgLPgLAYJIH
X-Google-Smtp-Source: AGHT+IFpMHUTbdSYjgTU7VYDGXbneJXB8oWhsCE6H0YwNdwQa4e5a0gLz60xS9+mXFMJ6HitoHxZdg==
X-Received: by 2002:a05:6602:2985:b0:7ba:ccbb:750d with SMTP id o5-20020a056602298500b007baccbb750dmr18015759ior.12.1704229745012;
        Tue, 02 Jan 2024 13:09:05 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:09:04 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Barnes <robbarnes@google.com>,
	Stephen Boyd <swboyd@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v4 24/24] platform/chrome: cros_ec: Use PM subsystem to manage wakeirq
Date: Tue,  2 Jan 2024 14:07:48 -0700
Message-ID: <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240102210820.2604667-1-markhas@chromium.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
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

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v4:
-Rebase on linux-next
-See each patch for patch specific changes
-Add Tzung-Bi's Ack tag
-Drop dev_err() during cros_ec_uart_probe()
-Initalize struct resource on stack
-Update error handling for platform_get_irq_resource_optional()

Changes in v3:
-Rebase on linux-next
-See each patch for patch specific changes
-Remove MODULE_DEVICE_TABLE
-Drop "cros_ec _" prefix from should_force_irq_wake_capable()
-Drop use of dev_err_probe() to be consistent with existing conventions
in the driver
-Drop *spi argument from cros_ec_spi_dt_probe()
-Drop null device_node check from cros_ec_spi_dt_probe()
-Add trailing commas to DMI table
-Drop redundant "!= NULL" in should_force_irq_wake_capable()
-Use str_yes_no() to print irq wake capability
-Move irqwake handling from the interface specific modules to cros_ec.c

Changes in v2:
-Rebase on linux-next
-Add cover letter
-See each patch for patch specific changes
-Look for 'wakeup-source' property in cros_ec_spi.c

 drivers/platform/chrome/cros_ec.c           | 48 +++++++++++++++++----
 drivers/platform/chrome/cros_ec_lpc.c       | 40 ++++++++++++++---
 drivers/platform/chrome/cros_ec_spi.c       | 15 ++++---
 drivers/platform/chrome/cros_ec_uart.c      | 14 ++++--
 include/linux/platform_data/cros_ec_proto.h |  4 +-
 5 files changed, 94 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index badc68bbae8cc..080b479f39a94 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
@@ -168,6 +169,35 @@ static int cros_ec_ready_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int enable_irq_for_wake(struct cros_ec_device *ec_dev)
+{
+	struct device *dev = ec_dev->dev;
+	int ret = device_init_wakeup(dev, true);
+
+	if (ret) {
+		dev_err(dev, "Failed to enable device for wakeup");
+		return ret;
+	}
+	ret = dev_pm_set_wake_irq(dev, ec_dev->irq);
+	if (ret)
+		device_init_wakeup(dev, false);
+
+	return ret;
+}
+
+static int disable_irq_for_wake(struct cros_ec_device *ec_dev)
+{
+	int ret;
+	struct device *dev = ec_dev->dev;
+
+	dev_pm_clear_wake_irq(dev);
+	ret = device_init_wakeup(dev, false);
+	if (ret)
+		dev_err(dev, "Failed to disable device for wakeup");
+
+	return ret;
+}
+
 /**
  * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
  * @ec_dev: Device to register.
@@ -221,6 +251,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 				ec_dev->irq, err);
 			goto exit;
 		}
+		dev_dbg(dev, "IRQ: %i, wake_capable: %s\n", ec_dev->irq,
+			str_yes_no(ec_dev->irq_wake));
+		if (ec_dev->irq_wake) {
+			err = enable_irq_for_wake(ec_dev);
+			if (err)
+				goto exit;
+		}
 	}
 
 	/* Register a platform device for the main EC instance */
@@ -313,6 +350,8 @@ EXPORT_SYMBOL(cros_ec_register);
  */
 void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
+	if (ec_dev->irq_wake)
+		disable_irq_for_wake(ec_dev);
 	platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
 	mutex_destroy(&ec_dev->lock);
@@ -353,12 +392,6 @@ EXPORT_SYMBOL(cros_ec_suspend_prepare);
 
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
@@ -440,9 +473,6 @@ static void cros_ec_enable_irq(struct cros_ec_device *ec_dev)
 	ec_dev->suspended = false;
 	enable_irq(ec_dev->irq);
 
-	if (ec_dev->wake_enabled)
-		disable_irq_wake(ec_dev->irq);
-
 	/*
 	 * Let the mfd devices know about events that occur during
 	 * suspend. This way the clients know what to do with them.
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index f0f3d3d561572..0204593d7b1c9 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -48,6 +48,27 @@ struct lpc_driver_ops {
 
 static struct lpc_driver_ops cros_ec_lpc_ops = { };
 
+static const struct dmi_system_id untrusted_fw_irq_wake_capable[] = {
+	{
+		.ident = "Brya",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
+		},
+	},
+	{
+		.ident = "Brask",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brask"),
+		},
+	},
+	{ }
+};
+
+static bool should_force_irq_wake_capable(void)
+{
+	return dmi_first_match(untrusted_fw_irq_wake_capable);
+}
+
 /*
  * A generic instance of the read function of struct lpc_driver_ops, used for
  * the LPC EC.
@@ -353,8 +374,9 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	struct acpi_device *adev;
 	acpi_status status;
 	struct cros_ec_device *ec_dev;
+	struct resource r = {};
 	u8 buf[2] = {};
-	int irq, ret;
+	int ret;
 
 	/*
 	 * The Framework Laptop (and possibly other non-ChromeOS devices)
@@ -428,12 +450,16 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	 * Some boards do not have an IRQ allotted for cros_ec_lpc,
 	 * which makes ENXIO an expected (and safe) scenario.
 	 */
-	irq = platform_get_irq_optional(pdev, 0);
-	if (irq > 0)
-		ec_dev->irq = irq;
-	else if (irq != -ENXIO) {
-		dev_err(dev, "couldn't retrieve IRQ number (%d)\n", irq);
-		return irq;
+	ret = platform_get_irq_resource_optional(pdev, 0, &r);
+	if (!ret) {
+		ec_dev->irq = r.start;
+		if (should_force_irq_wake_capable())
+			ec_dev->irq_wake = true;
+		else
+			ec_dev->irq_wake = r.flags & IORESOURCE_IRQ_WAKECAPABLE;
+	} else if (ret != -ENXIO) {
+		dev_err(dev, "couldn't retrieve IRQ number (%d)\n", ret);
+		return ret;
 	}
 
 	ret = cros_ec_register(ec_dev);
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 3e88cc92e8192..102cdc3d1956d 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
@@ -70,6 +71,7 @@
  * @end_of_msg_delay: used to set the delay_usecs on the spi_transfer that
  *      is sent when we want to turn off CS at the end of a transaction.
  * @high_pri_worker: Used to schedule high priority work.
+ * @irq_wake: Whether or not irq assertion should wake the system.
  */
 struct cros_ec_spi {
 	struct spi_device *spi;
@@ -77,6 +79,7 @@ struct cros_ec_spi {
 	unsigned int start_of_msg_delay;
 	unsigned int end_of_msg_delay;
 	struct kthread_worker *high_pri_worker;
+	bool irq_wake;
 };
 
 typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
@@ -689,9 +692,10 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
 }
 
-static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
+static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi)
 {
-	struct device_node *np = dev->of_node;
+	struct spi_device *spi = ec_spi->spi;
+	struct device_node *np = spi->dev.of_node;
 	u32 val;
 	int ret;
 
@@ -702,6 +706,8 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 	ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
 	if (!ret)
 		ec_spi->end_of_msg_delay = val;
+
+	ec_spi->irq_wake = spi->irq > 0 && of_property_present(np, "wakeup-source");
 }
 
 static void cros_ec_spi_high_pri_release(void *worker)
@@ -754,12 +760,13 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	/* Check for any DT properties */
-	cros_ec_spi_dt_probe(ec_spi, dev);
+	cros_ec_spi_dt_probe(ec_spi);
 
 	spi_set_drvdata(spi, ec_dev);
 	ec_dev->dev = dev;
 	ec_dev->priv = ec_spi;
 	ec_dev->irq = spi->irq;
+	ec_dev->irq_wake = ec_spi->irq_wake;
 	ec_dev->cmd_xfer = cros_ec_cmd_xfer_spi;
 	ec_dev->pkt_xfer = cros_ec_pkt_xfer_spi;
 	ec_dev->phys_name = dev_name(&ec_spi->spi->dev);
@@ -780,8 +787,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 		return err;
 	}
 
-	device_init_wakeup(&spi->dev, true);
-
 	return 0;
 }
 
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 68d80559fddc2..5de346a078745 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -69,6 +69,7 @@ struct response_info {
  * @serdev:		serdev uart device we are connected to.
  * @baudrate:		UART baudrate of attached EC device.
  * @flowcontrol:	UART flowcontrol of attached device.
+ * @irq_wake:		Whether or not irq assertion should wake the system.
  * @irq:		Linux IRQ number of associated serial device.
  * @response:		Response info passing between cros_ec_uart_pkt_xfer()
  *			and cros_ec_uart_rx_bytes()
@@ -77,6 +78,7 @@ struct cros_ec_uart {
 	struct serdev_device *serdev;
 	u32 baudrate;
 	u8 flowcontrol;
+	bool irq_wake;
 	u32 irq;
 	struct response_info response;
 };
@@ -224,8 +226,10 @@ static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
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
@@ -234,12 +238,12 @@ static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
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
 
 	return 0;
 }
@@ -293,6 +297,7 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 	ec_dev->dev = dev;
 	ec_dev->priv = ec_uart;
 	ec_dev->irq = ec_uart->irq;
+	ec_dev->irq_wake = ec_uart->irq_wake;
 	ec_dev->cmd_xfer = NULL;
 	ec_dev->pkt_xfer = cros_ec_uart_pkt_xfer;
 	ec_dev->din_size = sizeof(struct ec_host_response) +
@@ -301,6 +306,7 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 
 	serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
 
+	/* Register a new cros_ec device */
 	return cros_ec_register(ec_dev);
 }
 
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 8865e350c12a5..0fb2781b602d6 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -100,6 +100,7 @@ struct cros_ec_command {
  * @proto_version: The protocol version used for this device.
  * @priv: Private data.
  * @irq: Interrupt to use.
+ * @irq_wake: Whether or not irq assertion should wake the system.
  * @id: Device id.
  * @din: Input buffer (for data from EC). This buffer will always be
  *       dword-aligned and include enough space for up to 7 word-alignment
@@ -115,7 +116,6 @@ struct cros_ec_command {
  *        performance advantage to using dword.
  * @din_size: Size of din buffer to allocate (zero to use static din).
  * @dout_size: Size of dout buffer to allocate (zero to use static dout).
- * @wake_enabled: True if this device can wake the system from sleep.
  * @suspended: True if this device had been suspended.
  * @cmd_xfer: Send command to EC and get response.
  *            Returns the number of bytes received if the communication
@@ -169,11 +169,11 @@ struct cros_ec_device {
 	u16 proto_version;
 	void *priv;
 	int irq;
+	bool irq_wake;
 	u8 *din;
 	u8 *dout;
 	int din_size;
 	int dout_size;
-	bool wake_enabled;
 	bool suspended;
 	int (*cmd_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
-- 
2.43.0.472.g3155946c3a-goog


