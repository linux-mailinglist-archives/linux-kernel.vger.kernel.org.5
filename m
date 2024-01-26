Return-Path: <linux-kernel+bounces-39965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1984283D82B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73AB5B295BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8AB58223;
	Fri, 26 Jan 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z7m/No9/"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5F56B72
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263053; cv=none; b=ijfBA6HReqHIv0wT5W2EcowdzJurhP3kJePqQ6S1DKoZ1Q3kmWU1BQ8BPBF31JeW4yNAOrxUQzIgnGH9M75h7b7LYToczWlkWw/AdLK5JfgevUsJsujSHeafLrl/Mgc6cFkt4v7YMeHUTgRV04b3uFCryYA1w6ssCJ7OVQ4voNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263053; c=relaxed/simple;
	bh=7Fyi/QS44P8HncFn1cyKX4frA3CvgsJ21VAd9AVke0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bK55SYNfN2o0+S4jmNtVnWCVGl8bSs/mBatFdObaLH4CCKl8Zhjsbg9vRfW1aZqPwsTRbBTXqH5Z0hUxNDsTYjm3TKI0zRMBwkx2w0ZrOoZofu20wygA2BdTr1v32p+Gw+loCzNG/Z0bBecC49nLnTRfvKgqMgDsgG2Acto+WYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z7m/No9/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-510218ab26fso295300e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706263049; x=1706867849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADAeAiuz2kl457QW/qJtcIJbI3upkBxpKZcTk3uuIsY=;
        b=Z7m/No9/YPhB/U30DZq8wCZfxNmpo+3LN27wn8jKIJMnxi94dP7vB++AL7MGe4Of5L
         FwrTSqYdtIMqa7Uyz4/SjgNJGXMhZGnDlEbXHiD/aupJIH+z5aHB5mgBZPWnHQG1IRRN
         rrDutOo7+0w/r5VvMGLkkxczC6YX9guoGs4RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706263049; x=1706867849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADAeAiuz2kl457QW/qJtcIJbI3upkBxpKZcTk3uuIsY=;
        b=P2mGg+xItlMd5HSuZNMRGFJeRT0LGjAllayJJ12ggJLVkgEH0p++DjW2tPAhViqepg
         U6E/H0H3PAqrkn76k+l/6V+yDiragmdHIESQ2HjQAvDyo1KOsWyDL+QXYPGrsejDpgwl
         S5ZhwYy4Bpw9Qa2ijMVyiQzVfgFqDmA9AcElVK3862eYWU5S3kOemLYfJHYLOH65CPGl
         MQuIWLFtb5tZbbPmK0jqSdOc3TDOs/HTpjUDJDiQcAL7g4eWETDgrBGSb8N9X+19IqxG
         2Jnt8schJwadqaDCEDrMrTYS2IUCOd9mp63HveX6dZGToz6pllbfxzISMpB6XfbfKGAy
         q/6A==
X-Gm-Message-State: AOJu0YwH7nj/W0cRNuREgwNq0TJmwVyMGMrr7tXzfJfHpVZpEyj7pygN
	Ur5jnK8FXgbHsvDHu3gEF0K5IVh+8w/Fu6ABEh3Sxo/K9C955uJw+o1Txiz/Vg==
X-Google-Smtp-Source: AGHT+IGD25liiUHtquJUFdXngW8rT2M65JqLwwLYOqB7TmbEngCxTWSq5QXv6OBGsy1rtJAm2MB0NA==
X-Received: by 2002:ac2:5922:0:b0:510:272c:d011 with SMTP id v2-20020ac25922000000b00510272cd011mr639632lfi.69.1706263049244;
        Fri, 26 Jan 2024 01:57:29 -0800 (PST)
Received: from cracow.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id b16-20020a056512071000b0050ecae41c51sm129041lfs.135.2024.01.26.01.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:57:28 -0800 (PST)
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
Subject: [PATCH v4 2/3] watchdog: Add ChromeOS EC-based watchdog driver
Date: Fri, 26 Jan 2024 09:57:20 +0000
Message-ID: <20240126095721.782782-3-lma@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126095721.782782-1-lma@chromium.org>
References: <20240126095721.782782-1-lma@chromium.org>
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
 drivers/watchdog/cros_ec_wdt.c | 204 +++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+)
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
index 000000000000..ba045e29f9a5
--- /dev/null
+++ b/drivers/watchdog/cros_ec_wdt.c
@@ -0,0 +1,204 @@
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
+	wdd = devm_kzalloc(&pdev->dev, sizeof(*wdd), GFP_KERNEL);
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
+static const struct platform_device_id cros_ec_wdt_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+
+static struct platform_driver cros_ec_wdt_driver = {
+	.probe		= cros_ec_wdt_probe,
+	.suspend	= pm_ptr(cros_ec_wdt_suspend),
+	.resume		= pm_ptr(cros_ec_wdt_resume),
+	.driver		= {
+		.name	= DRV_NAME,
+	},
+	.id_table	= cros_ec_wdt_id,
+};
+
+module_platform_driver(cros_ec_wdt_driver);
+
+MODULE_DEVICE_TABLE(platform, cros_ec_wdt_id);
+MODULE_DESCRIPTION("Cros EC Watchdog Device Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0.429.g432eaa2c6b-goog


