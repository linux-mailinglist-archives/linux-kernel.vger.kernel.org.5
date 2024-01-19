Return-Path: <linux-kernel+bounces-30920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F658325EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5512328520B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6C286B0;
	Fri, 19 Jan 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oNwvnVCj"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D11E895
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653818; cv=none; b=ZjfhjDqYynK/zOLXmMnYMQ87VwbuVAqPLfawGWMMDTxtTgiXkP3UVeG0XNOHVCscDQ/MTAxJober+1kvVQ9lvahjqf6BduYoKMhAv52+qQFdXiLgqb0OYfU0EdQIkL0YHo+8Ekq8HGFT75T5+fIZAdFt781IKQbzsDPIYwVJqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653818; c=relaxed/simple;
	bh=ptf1HR9yRb1jC/RRprHqgf//qYN+lezB2C1lPxTDC1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1Dzy5+TnGP8O6/w/+TdfuDUTVHlSErhTnR399aBJWybRiWTi+PzSPpGZhYX5ol/uwqx2gA6GKWEifCKE7lsoREM+/DVcF17DjTTQuyQbhHiszLLf4VVH7qM5dQo40kO+AurOfyyWhBlp2dgQ9bxTirs2h25hXJAFqDRPAFxU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oNwvnVCj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eab4bf47aso486342e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705653814; x=1706258614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et4CtZLo0Zs8wJbeGnnolJcmqvepEHLWSur8uVrZQBk=;
        b=oNwvnVCj56jxK6kvGa5xI70IyOWt6thG6VUd2/RbNE2bK1neztEaeJkMJGLToyNigP
         7JeNv6lYdnC4cwyYCM3B4KHtXJtIkivfPbtD3zLdXqunjQNK7AXX44oOAN5BPjHrLa3Z
         lXvTjvUPXQgaBw+/V7VLec4VN2yZqaZDixBuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705653814; x=1706258614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Et4CtZLo0Zs8wJbeGnnolJcmqvepEHLWSur8uVrZQBk=;
        b=FC5ZFzevufonK4pd6ZQ+1kM64U0b/DWlL4mRv4Vez2Bm9TFNYlq2QmP0tFWKsdL35B
         l+HYnmifPc/FsbsX11rzf8Y4OiQGdlo1z2n5GrKfwOcL2MHatKycoabZvUgleSarjbiy
         fwH0x/EaTV8RfLthRiDpjYSypS8ZfNgqVK164c5ntNbTE+2ydYA95CQo+XJZHYivCJfG
         KppGjdjpTJKWpzSL49xqTtsWLrS/EHBzjahYFlPLtikYFk/QuC0bcrDsJ2X6g6dXfcwC
         roIQCIQN2DnnGtscvDoKNptEg7vwfM/ifclQLL+Cbs92nLtu2tSYq+6aPDfhMbQsge/m
         axTA==
X-Gm-Message-State: AOJu0YyDF6xhbO+LdG4XSxHZVuj4QtXEyaeUXPTHPvXjsSvIJrA/gZpB
	42/uRPJknN6zgST4UMmIQSmtc/kpa6Ei5e86uwFde+URIwthFCgUeGdIFZUuJA==
X-Google-Smtp-Source: AGHT+IFYJwW224ISBqEbH1mxAWe2JvYdmTswXUM+MtTz4PbFSklOcWlQMDyWS5CnDgt7/6kndQxAJA==
X-Received: by 2002:a05:6512:32a1:b0:50f:de3:b0a5 with SMTP id q1-20020a05651232a100b0050f0de3b0a5mr414682lfe.1.1705653814683;
        Fri, 19 Jan 2024 00:43:34 -0800 (PST)
Received: from cracow.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id q23-20020ac246f7000000b0050e6aff6630sm905591lfo.152.2024.01.19.00.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:43:34 -0800 (PST)
From: Lukasz Majczak <lma@chromium.org>
To: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Lukasz Majczak <lma@chromium.org>
Subject: [PATCH v3 2/3] watchdog: Add ChromeOS EC-based watchdog driver
Date: Fri, 19 Jan 2024 08:43:26 +0000
Message-ID: <20240119084328.3135503-3-lma@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119084328.3135503-1-lma@chromium.org>
References: <20240119084328.3135503-1-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Embedded Controller (EC) present on Chromebook devices
can be used as a watchdog.
Implement a driver to support it.

Signed-off-by: Lukasz Majczak <lma@chromium.org>
---
 MAINTAINERS                    |   6 +
 drivers/watchdog/Kconfig       |  11 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/cros_ec_wdt.c | 202 +++++++++++++++++++++++++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 drivers/watchdog/cros_ec_wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ef90ddc0fda6..aaae581aae70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4981,6 +4981,12 @@ R:	Sami Kyöstilä <skyostil@chromium.org>
 S:	Maintained
 F:	drivers/platform/chrome/cros_hps_i2c.c
 
+CHROMEOS EC WATCHDOG
+M:	Lukasz Majczak <lma@chromium.org>
+L:	chrome-platform@lists.linux.dev
+S:	Maintained
+F:	drivers/watchdog/cros_ec_wdt.c
+
 CHRONTEL CH7322 CEC DRIVER
 M:	Joe Tessler <jrt@google.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7d22051b15a2..4700b218340f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -181,6 +181,17 @@ config BD957XMUF_WATCHDOG
 	  watchdog. Alternatively say M to compile the driver as a module,
 	  which will be called bd9576_wdt.
 
+config CROS_EC_WATCHDOG
+	tristate "ChromeOS EC-based watchdog"
+	select WATCHDOG_CORE
+	depends on CROS_EC
+	help
+	  Watchdog driver for Chromebook devices equipped with embedded controller.
+	  Trigger event is recorded in EC and checked on the subsequent boot.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_wdt.
+
 config DA9052_WATCHDOG
 	tristate "Dialog DA9052 Watchdog"
 	depends on PMIC_DA9052 || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7cbc34514ec1..3710c218f05e 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -217,6 +217,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 
 # Architecture Independent
 obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
+obj-$(CONFIG_CROS_EC_WATCHDOG) += cros_ec_wdt.o
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
 obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
diff --git a/drivers/watchdog/cros_ec_wdt.c b/drivers/watchdog/cros_ec_wdt.c
new file mode 100644
index 000000000000..d03eb0562e08
--- /dev/null
+++ b/drivers/watchdog/cros_ec_wdt.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 Google LLC.
+ * Author: Lukasz Majczak <lma@chromium.com>
+ */
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+#define CROS_EC_WATCHDOG_DEFAULT_TIME	30 /* seconds */
+#define DRV_NAME	"cros-ec-wdt"
+
+union cros_ec_wdt_data {
+	struct ec_params_hang_detect req;
+	struct ec_response_hang_detect resp;
+} __packed;
+
+static int cros_ec_wdt_send_cmd(struct cros_ec_device *cros_ec,
+				union cros_ec_wdt_data *arg)
+{
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		union cros_ec_wdt_data data;
+	} __packed buf = {
+		.msg = {
+			.version = 0,
+			.command = EC_CMD_HANG_DETECT,
+			.insize  = (arg->req.command == EC_HANG_DETECT_CMD_GET_STATUS) ?
+				   sizeof(struct ec_response_hang_detect) :
+				   0,
+			.outsize = sizeof(struct ec_params_hang_detect),
+		},
+		.data.req = arg->req
+	};
+
+	ret = cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
+	if (ret < 0)
+		return ret;
+
+	arg->resp = buf.data.resp;
+
+	return 0;
+}
+
+static int cros_ec_wdt_ping(struct watchdog_device *wdd)
+{
+	struct cros_ec_device *cros_ec = watchdog_get_drvdata(wdd);
+	union cros_ec_wdt_data arg;
+	int ret;
+
+	arg.req.command = EC_HANG_DETECT_CMD_RELOAD;
+	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
+	if (ret < 0)
+		dev_dbg(wdd->parent, "Failed to ping watchdog (%d)", ret);
+
+	return ret;
+}
+
+static int cros_ec_wdt_start(struct watchdog_device *wdd)
+{
+	struct cros_ec_device *cros_ec = watchdog_get_drvdata(wdd);
+	union cros_ec_wdt_data arg;
+	int ret;
+
+	/* Prepare watchdog on EC side */
+	arg.req.command = EC_HANG_DETECT_CMD_SET_TIMEOUT;
+	arg.req.reboot_timeout_sec = wdd->timeout;
+	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
+	if (ret < 0)
+		dev_dbg(wdd->parent, "Failed to start watchdog (%d)", ret);
+
+	return ret;
+}
+
+static int cros_ec_wdt_stop(struct watchdog_device *wdd)
+{
+	struct cros_ec_device *cros_ec = watchdog_get_drvdata(wdd);
+	union cros_ec_wdt_data arg;
+	int ret;
+
+	arg.req.command = EC_HANG_DETECT_CMD_CANCEL;
+	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
+	if (ret < 0)
+		dev_dbg(wdd->parent, "Failed to stop watchdog (%d)", ret);
+
+	return ret;
+}
+
+static int cros_ec_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
+{
+	unsigned int old_timeout = wdd->timeout;
+	int ret;
+
+	wdd->timeout = t;
+	ret = cros_ec_wdt_start(wdd);
+	if (ret < 0)
+		wdd->timeout = old_timeout;
+
+	return ret;
+}
+
+static const struct watchdog_info cros_ec_wdt_ident = {
+	.options          = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.firmware_version = 0,
+	.identity         = DRV_NAME,
+};
+
+static const struct watchdog_ops cros_ec_wdt_ops = {
+	.owner		 = THIS_MODULE,
+	.ping		 = cros_ec_wdt_ping,
+	.start		 = cros_ec_wdt_start,
+	.stop		 = cros_ec_wdt_stop,
+	.set_timeout = cros_ec_wdt_set_timeout,
+};
+
+static int cros_ec_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
+	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
+	struct watchdog_device *wdd;
+	union cros_ec_wdt_data arg;
+	int ret = 0;
+
+	wdd = devm_kzalloc(&pdev->dev, sizeof(struct watchdog_device), GFP_KERNEL);
+	if (!wdd)
+		return -ENOMEM;
+
+	arg.req.command = EC_HANG_DETECT_CMD_GET_STATUS;
+	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get watchdog bootstatus");
+
+	wdd->parent = &pdev->dev;
+	wdd->info = &cros_ec_wdt_ident;
+	wdd->ops = &cros_ec_wdt_ops;
+	wdd->timeout = CROS_EC_WATCHDOG_DEFAULT_TIME;
+	wdd->min_timeout = EC_HANG_DETECT_MIN_TIMEOUT;
+	wdd->max_timeout = EC_HANG_DETECT_MAX_TIMEOUT;
+	if (arg.resp.status == EC_HANG_DETECT_AP_BOOT_EC_WDT)
+		wdd->bootstatus = WDIOF_CARDRESET;
+
+	arg.req.command = EC_HANG_DETECT_CMD_CLEAR_STATUS;
+	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to clear watchdog bootstatus");
+
+	watchdog_stop_on_reboot(wdd);
+	watchdog_stop_on_unregister(wdd);
+	watchdog_set_drvdata(wdd, cros_ec);
+	platform_set_drvdata(pdev, wdd);
+
+	return devm_watchdog_register_device(dev, wdd);
+}
+
+static int __maybe_unused cros_ec_wdt_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	if (watchdog_active(wdd))
+		ret = cros_ec_wdt_stop(wdd);
+
+	return ret;
+}
+
+static int __maybe_unused cros_ec_wdt_resume(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	if (watchdog_active(wdd))
+		ret = cros_ec_wdt_start(wdd);
+
+	return ret;
+}
+
+static struct platform_driver cros_ec_wdt_driver = {
+	.probe		= cros_ec_wdt_probe,
+	.suspend	= pm_ptr(cros_ec_wdt_suspend),
+	.resume		= pm_ptr(cros_ec_wdt_resume),
+	.driver		= {
+		.name	= DRV_NAME,
+	},
+};
+
+module_platform_driver(cros_ec_wdt_driver);
+
+static const struct platform_device_id cros_ec_wdt_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_wdt_id);
+MODULE_DESCRIPTION("Cros EC Watchdog Device Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0.429.g432eaa2c6b-goog


