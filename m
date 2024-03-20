Return-Path: <linux-kernel+bounces-109197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53F881604
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB141C21214
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D62B4EB47;
	Wed, 20 Mar 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FE5rrJUs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513FF10FA;
	Wed, 20 Mar 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953978; cv=none; b=r41G60QDTUf+eGIf06aIX0G5oaLJj3uozgvkwdUIXVPlkkfLKCywdWtP/zNWKtGKKU0C3zCE2V83WjNvUBT+yYA/5DWR5zoNuPrfvASPs/LpC5v4B7r1MxvlHF8zcHM5Rz4gc/BhYmZgFOAU9XNb5TgtT4FVkhrEOQhLY1pemoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953978; c=relaxed/simple;
	bh=s0/aLoxKix13bsWvxqVqF3isscoD1oqKeSGeoPdxMM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1Y7cnLBBkCY5LJK7pMhjdgVWLXUwOs1C6w/+cqXI8gHRqsbm40fbyfrQsSHhyBRranFmCssjXoN7coq0ECQh8g7uFmsZh7M21XyH82hOJ4enZmj1AOVJnDSb7Um3paPNpxTeowyBm4NeGAN8QlLsgpLzO1flam/T1irqFxtgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FE5rrJUs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710953976; x=1742489976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s0/aLoxKix13bsWvxqVqF3isscoD1oqKeSGeoPdxMM8=;
  b=FE5rrJUsfFsTyR0Wrc901MqAI/Gl6Y0dakmJQWE20wDmgHLmRp3Le5qn
   qa2okC2c8gZgf65wpbvyrKz8boN4EUtfu34yMIxJJd3Hmo3HV6I4S09et
   LeqFWP3ZU1ajkapB3rTdkNmuh4GnMMMT//CxuDEuy3eSlGJY41rsywRYk
   kjssQcnW/i5UDMDC8Q+b5Oh3g2rklOvhsFYj3I1qXfpF/QNNYNq9TPcs2
   Ar2E9q+LAuM0VP4zZZ9hPJHSF6FKcOACqwBic5hZumCRfFnlEirUR/Nxq
   Qv/t5eDNvYnBppBzCB3TC1v9Ms8cia3NtqlSR3CSXc/Jvw8cvJoUOES1y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6016995"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="6016995"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 09:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="937063900"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="937063900"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2024 09:59:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5204330D; Wed, 20 Mar 2024 18:59:32 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Stephen Boyd <swboyd@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 1/1] gpiolib: Fix debug messaging in gpiod_find_and_request()
Date: Wed, 20 Mar 2024 18:58:47 +0200
Message-ID: <20240320165930.1182653-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
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
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: completele reworked solution of
20231019173457.2445119-1-andriy.shevchenko@linux.intel.com
 drivers/gpio/gpiolib.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e2e583b40207..7d26e5de0b44 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2401,6 +2401,11 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
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
@@ -2429,10 +2434,11 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
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
 
@@ -2442,8 +2448,8 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 
 	ret = gpiod_configure_flags(desc, label, lflags, dflags);
 	if (ret) {
-		chip_err(gc, "setup of own GPIO %s failed\n", label);
 		gpiod_free_commit(desc);
+		chip_err(gc, "setup of own GPIO %s failed\n", name);
 		return ERR_PTR(ret);
 	}
 
@@ -4157,19 +4163,17 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
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
 
@@ -4185,6 +4189,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 					 bool platform_lookup_allowed)
 {
 	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
+	const char *name = function_name_or_default(con_id);
 	/*
 	 * scoped_guard() is implemented as a for loop, meaning static
 	 * analyzers will complain about these two not being initialized.
@@ -4207,8 +4212,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 		}
 
 		if (IS_ERR(desc)) {
-			dev_dbg(consumer, "No GPIO consumer %s found\n",
-				con_id);
+			dev_dbg(consumer, "No GPIO consumer %s found\n", name);
 			return desc;
 		}
 
@@ -4230,15 +4234,14 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
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
 
@@ -4354,6 +4357,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_optional);
 int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags)
 {
+	const char *name = function_name_or_default(con_id);
 	int ret;
 
 	if (lflags & GPIO_ACTIVE_LOW)
@@ -4397,7 +4401,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 
 	/* No particular flag request, return here... */
 	if (!(dflags & GPIOD_FLAGS_BIT_DIR_SET)) {
-		gpiod_dbg(desc, "no flags found for %s\n", con_id);
+		gpiod_dbg(desc, "no flags found for GPIO %s\n", name);
 		return 0;
 	}
 
-- 
2.43.0.rc1.1.gbec44491f096


