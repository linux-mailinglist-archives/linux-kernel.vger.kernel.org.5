Return-Path: <linux-kernel+bounces-117565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEFF88ACA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B963079DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91DA7FBD4;
	Mon, 25 Mar 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VK6jjGhG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368334EB5F;
	Mon, 25 Mar 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387093; cv=none; b=ft7gwenObrp7e/POtzUsgfOW7ZK50gtHqcN/aZpofxTauhWNqyDny38LEEGkmXYkd9eoa3UFke4FRUERi3dTRG/FUZVUQeggREP/IpBch2YJmkysZdMknjYc03qVj2K4qMVCFp//9DDAneKcfVr50VssQbulRxy3GLT5dfTX81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387093; c=relaxed/simple;
	bh=rVysmY2hoDOfSR8Roev4MtIq14Q/G7Fv9ugKPFwvn80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAy2XubkRbsFpIEIMKQD3ckPQVKbM6dMD+BWSmxm8QXsccqILJ08OV4SlwVEfFG76bM2gwbJVzu5QExJvY/5zwI1gFTL9jqLAYcbtsN1He2NVvu/CJQNSoTkZ3z8sCL/isCK/wHOOjCqGuDP5fAAuQPdqsl/9XokA2eKSzez+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VK6jjGhG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711387092; x=1742923092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rVysmY2hoDOfSR8Roev4MtIq14Q/G7Fv9ugKPFwvn80=;
  b=VK6jjGhGaxvSl6rInAV9X8fXuPIv9ApA4lcmkMGLzjLA8UNKT8ukUAb2
   s1Z+ff0+N6x8D/kwYIbiSaH1VeVeLxA2Mdx9/J8Ti4DYWBJ9L9XencSjb
   peRcM47Fxoh4gbSn6qksXcTzujeyYvSTsUP63sK60vyLqLsFdjmzyuYwp
   zovN4OKzCyPMFsYY7gWyDDA2NrDbg4J9dVfamfeWFQ3bKbgtooJspGfY2
   zxYhZqUSF7QWOMkJ4lu6YtrleLUMXhZVBCEEnbHZKvR4RZCbvu9uQ65Bu
   nzjtSbda5HgYKFiPSuNlWGHcLmCBHsp7hAxZvqAeqztVA8rreRTxV75/A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17546547"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17546547"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="937070691"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070691"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 10:18:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A5DFF484; Mon, 25 Mar 2024 19:18:05 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v4 1/2] gpiolib: Fix debug messaging in gpiod_find_and_request()
Date: Mon, 25 Mar 2024 19:16:25 +0200
Message-ID: <20240325171804.3375280-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325171804.3375280-1-andriy.shevchenko@linux.intel.com>
References: <20240325171804.3375280-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When consolidating GPIO lookups in ACPI code, the debug messaging
had been reworked that the user may see

  [   13.401147] (NULL device *): using ACPI '\_SB.LEDS.led-0' for '(null)' GPIO lookup
  [   13.401378] gpio gpiochip0: Persistence not supported for GPIO 40
  [   13.401402] gpio-40 (?): no flags found for (null)

instead of

  [   14.182962] gpio gpiochip0: Persistence not supported for GPIO 40
  [   14.182994] gpio-40 (?): no flags found for gpios

The '(null)' parts are less informative and likely scare the users.
Replace them by '(default)' which can point out to the default connection
IDs, such as 'gpios'.

While at it, amend other places where con_id is used in the messages.

Reported-by: Ferry Toth <ftoth@exalondelft.nl>
Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 06f6c84fc7b1..b98cbf4335e3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2396,6 +2396,11 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 }
 EXPORT_SYMBOL_GPL(gpiochip_dup_line_label);
 
+static inline const char *function_name_or_default(const char *con_id)
+{
+	return con_id ?: "(default)";
+}
+
 /**
  * gpiochip_request_own_desc - Allow GPIO chip to request its own descriptor
  * @gc: GPIO chip
@@ -2424,10 +2429,11 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    enum gpiod_flags dflags)
 {
 	struct gpio_desc *desc = gpiochip_get_desc(gc, hwnum);
+	const char *name = function_name_or_default(label);
 	int ret;
 
 	if (IS_ERR(desc)) {
-		chip_err(gc, "failed to get GPIO descriptor\n");
+		chip_err(gc, "failed to get GPIO %s descriptor\n", name);
 		return desc;
 	}
 
@@ -2437,8 +2443,8 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 
 	ret = gpiod_configure_flags(desc, label, lflags, dflags);
 	if (ret) {
-		chip_err(gc, "setup of own GPIO %s failed\n", label);
 		gpiod_free_commit(desc);
+		chip_err(gc, "setup of own GPIO %s failed\n", name);
 		return ERR_PTR(ret);
 	}
 
@@ -4152,19 +4158,17 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 					      enum gpiod_flags *flags,
 					      unsigned long *lookupflags)
 {
+	const char *name = function_name_or_default(con_id);
 	struct gpio_desc *desc = ERR_PTR(-ENOENT);
 
 	if (is_of_node(fwnode)) {
-		dev_dbg(consumer, "using DT '%pfw' for '%s' GPIO lookup\n",
-			fwnode, con_id);
+		dev_dbg(consumer, "using DT '%pfw' for '%s' GPIO lookup\n", fwnode, name);
 		desc = of_find_gpio(to_of_node(fwnode), con_id, idx, lookupflags);
 	} else if (is_acpi_node(fwnode)) {
-		dev_dbg(consumer, "using ACPI '%pfw' for '%s' GPIO lookup\n",
-			fwnode, con_id);
+		dev_dbg(consumer, "using ACPI '%pfw' for '%s' GPIO lookup\n", fwnode, name);
 		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
 	} else if (is_software_node(fwnode)) {
-		dev_dbg(consumer, "using swnode '%pfw' for '%s' GPIO lookup\n",
-			fwnode, con_id);
+		dev_dbg(consumer, "using swnode '%pfw' for '%s' GPIO lookup\n", fwnode, name);
 		desc = swnode_find_gpio(fwnode, con_id, idx, lookupflags);
 	}
 
@@ -4180,6 +4184,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 					 bool platform_lookup_allowed)
 {
 	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
+	const char *name = function_name_or_default(con_id);
 	/*
 	 * scoped_guard() is implemented as a for loop, meaning static
 	 * analyzers will complain about these two not being initialized.
@@ -4202,8 +4207,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 		}
 
 		if (IS_ERR(desc)) {
-			dev_dbg(consumer, "No GPIO consumer %s found\n",
-				con_id);
+			dev_dbg(consumer, "No GPIO consumer %s found\n", name);
 			return desc;
 		}
 
@@ -4225,15 +4229,14 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 		 *
 		 * FIXME: Make this more sane and safe.
 		 */
-		dev_info(consumer,
-			 "nonexclusive access to GPIO for %s\n", con_id);
+		dev_info(consumer, "nonexclusive access to GPIO for %s\n", name);
 		return desc;
 	}
 
 	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
 	if (ret < 0) {
-		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
 		gpiod_put(desc);
+		dev_dbg(consumer, "setup of GPIO %s failed\n", name);
 		return ERR_PTR(ret);
 	}
 
@@ -4349,6 +4352,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_optional);
 int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags)
 {
+	const char *name = function_name_or_default(con_id);
 	int ret;
 
 	if (lflags & GPIO_ACTIVE_LOW)
@@ -4392,7 +4396,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 
 	/* No particular flag request, return here... */
 	if (!(dflags & GPIOD_FLAGS_BIT_DIR_SET)) {
-		gpiod_dbg(desc, "no flags found for %s\n", con_id);
+		gpiod_dbg(desc, "no flags found for GPIO %s\n", name);
 		return 0;
 	}
 
-- 
2.43.0.rc1.1.gbec44491f096


