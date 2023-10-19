Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10887D00B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbjJSRfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjJSRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:35:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD6182;
        Thu, 19 Oct 2023 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736907; x=1729272907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2FyMFKyMhc+AxK+IILlJGCje9zC4QbnuYvc9XHRShSo=;
  b=MB0AKiCmhXhObWG61YcNyT2SprE6H/SDAaK9LcDGPkEOWSlI/TSTHRag
   98O0Uj/W37Eg3x7p4Mnguie5fn1Njqs5AWnvGctqwmIZC3YKeEzVTfH9Q
   I0RTzAh+ouDqNEtPG2xYA1N0/vN+a8wiKxkLeDo2nhASnUkFNbOZd3qX4
   6AsOx6ArpbO65iYJY2uqLUvdPBFuo6HR78IE6zJjBUI0t9xlogEZemsbx
   I7yS0HbOciXvtqk+5PrZmJuENG4pRlMUUsgBqAYt6c3bz0sOWou2b4dM4
   NWddzNzpAp/zhZ0qpOEEcFDLhqB+1J60Qn3QLF2sQhIRecwMcPJKcmDyj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389184255"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389184255"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760723567"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760723567"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2023 10:35:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5BC259CE; Thu, 19 Oct 2023 20:35:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 2/3] gpiolib: Fix debug messaging in gpiod_find_and_request()
Date:   Thu, 19 Oct 2023 20:34:56 +0300
Message-Id: <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When consolidating GPIO lookups in ACPI code, the debug messaging
had been broken and hence lost a bit of sense. Restore debug
messaging in gpiod_find_and_request() when configuring the GPIO
line via gpiod_configure_flags().

Reported-by: Ferry Toth <ftoth@exalondelft.nl>
Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c   |  9 ++++-----
 drivers/gpio/gpiolib-acpi.h   | 13 +++++++------
 drivers/gpio/gpiolib-of.c     | 13 +++++++------
 drivers/gpio/gpiolib-of.h     |  8 ++++----
 drivers/gpio/gpiolib-swnode.c |  4 ++--
 drivers/gpio/gpiolib-swnode.h |  1 +
 drivers/gpio/gpiolib.c        | 21 ++++++++++++++-------
 7 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 51e41676de0b..a2899b2a58bd 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -973,24 +973,23 @@ static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 }
 
 struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
-				 const char *con_id,
-				 unsigned int idx,
+				 const char *con_id, unsigned int idx,
+				 char *propname, size_t propsize,
 				 enum gpiod_flags *dflags,
 				 unsigned long *lookupflags)
 {
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
-	char propname[32];
 	int i;
 
 	/* Try first from _DSD */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id) {
-			snprintf(propname, sizeof(propname), "%s-%s",
+			snprintf(propname, propsize, "%s-%s",
 				 con_id, gpio_suffixes[i]);
 		} else {
-			snprintf(propname, sizeof(propname), "%s",
+			snprintf(propname, propsize, "%s",
 				 gpio_suffixes[i]);
 		}
 
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 0fcd7e14d7f9..b5f0de249765 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -28,8 +28,8 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
 
 struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
-				 const char *con_id,
-				 unsigned int idx,
+				 const char *con_id, unsigned int idx,
+				 char *propname, size_t propsize,
 				 enum gpiod_flags *dflags,
 				 unsigned long *lookupflags);
 
@@ -44,10 +44,11 @@ acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
 static inline void
 acpi_gpiochip_free_interrupts(struct gpio_chip *chip) { }
 
-static inline struct gpio_desc *
-acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id,
-	       unsigned int idx, enum gpiod_flags *dflags,
-	       unsigned long *lookupflags)
+static inline struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
+					       const char *con_id, unsigned int idx,
+					       char *propname, size_t propsize,
+					       enum gpiod_flags *dflags,
+					       unsigned long *lookupflags)
 {
 	return ERR_PTR(-ENOENT);
 }
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 531faabead0f..017ee5cbfb60 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -621,10 +621,11 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
 	NULL
 };
 
-struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
-			       unsigned int idx, unsigned long *flags)
+struct gpio_desc *of_find_gpio(struct device_node *np,
+			       const char *con_id, unsigned int idx,
+			       char *propname, size_t propsize,
+			       unsigned long *flags)
 {
-	char prop_name[32]; /* 32 is max size of property name */
 	enum of_gpio_flags of_flags;
 	const of_find_gpio_quirk *q;
 	struct gpio_desc *desc;
@@ -633,13 +634,13 @@ struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
 	/* Try GPIO property "foo-gpios" and "foo-gpio" */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id)
-			snprintf(prop_name, sizeof(prop_name), "%s-%s", con_id,
+			snprintf(propname, propsize, "%s-%s", con_id,
 				 gpio_suffixes[i]);
 		else
-			snprintf(prop_name, sizeof(prop_name), "%s",
+			snprintf(propname, propsize, "%s",
 				 gpio_suffixes[i]);
 
-		desc = of_get_named_gpiod_flags(np, prop_name, idx, &of_flags);
+		desc = of_get_named_gpiod_flags(np, propname, idx, &of_flags);
 
 		if (!gpiod_not_found(desc))
 			break;
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index 6b3a5347c5d9..c2517e7913ee 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -16,16 +16,16 @@ struct gpio_device;
 
 #ifdef CONFIG_OF_GPIO
 struct gpio_desc *of_find_gpio(struct device_node *np,
-			       const char *con_id,
-			       unsigned int idx,
+			       const char *con_id, unsigned int idx,
+			       char *propname, size_t propsize,
 			       unsigned long *lookupflags);
 int of_gpiochip_add(struct gpio_chip *gc);
 void of_gpiochip_remove(struct gpio_chip *gc);
 int of_gpio_get_count(struct device *dev, const char *con_id);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device_node *np,
-					     const char *con_id,
-					     unsigned int idx,
+					     const char *con_id, unsigned int idx,
+					     char *propname, size_t propsize,
 					     unsigned long *lookupflags)
 {
 	return ERR_PTR(-ENOENT);
diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index b5a6eaf3729b..12c94f620f6b 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -51,20 +51,20 @@ static struct gpio_chip *swnode_get_chip(struct fwnode_handle *fwnode)
 
 struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 				   const char *con_id, unsigned int idx,
+				   char *propname, size_t propsize,
 				   unsigned long *flags)
 {
 	const struct software_node *swnode;
 	struct fwnode_reference_args args;
 	struct gpio_chip *chip;
 	struct gpio_desc *desc;
-	char propname[32]; /* 32 is max size of property name */
 	int error;
 
 	swnode = to_software_node(fwnode);
 	if (!swnode)
 		return ERR_PTR(-EINVAL);
 
-	swnode_format_propname(con_id, propname, sizeof(propname));
+	swnode_format_propname(con_id, propname, propsize);
 
 	/*
 	 * We expect all swnode-described GPIOs have GPIO number and
diff --git a/drivers/gpio/gpiolib-swnode.h b/drivers/gpio/gpiolib-swnode.h
index af849e56f6bc..b75fbb1fa7a6 100644
--- a/drivers/gpio/gpiolib-swnode.h
+++ b/drivers/gpio/gpiolib-swnode.h
@@ -8,6 +8,7 @@ struct gpio_desc;
 
 struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 				   const char *con_id, unsigned int idx,
+				   char *propname, size_t propsize,
 				   unsigned long *flags);
 int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id);
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 40a0022ea719..beac3031246e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3938,8 +3938,8 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
 
 static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 					      struct device *consumer,
-					      const char *con_id,
-					      unsigned int idx,
+					      const char *con_id, unsigned int idx,
+					      char *propname, size_t propsize,
 					      enum gpiod_flags *flags,
 					      unsigned long *lookupflags)
 {
@@ -3948,15 +3948,18 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	if (is_of_node(fwnode)) {
 		dev_dbg(consumer, "using DT '%pfw' for '%s' GPIO lookup\n",
 			fwnode, con_id);
-		desc = of_find_gpio(to_of_node(fwnode), con_id, idx, lookupflags);
+		desc = of_find_gpio(to_of_node(fwnode), con_id, idx, propname, propsize,
+				    lookupflags);
 	} else if (is_acpi_node(fwnode)) {
 		dev_dbg(consumer, "using ACPI '%pfw' for '%s' GPIO lookup\n",
 			fwnode, con_id);
-		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
+		desc = acpi_find_gpio(fwnode, con_id, idx, propname, propsize,
+				      flags, lookupflags);
 	} else if (is_software_node(fwnode)) {
 		dev_dbg(consumer, "using swnode '%pfw' for '%s' GPIO lookup\n",
 			fwnode, con_id);
-		desc = swnode_find_gpio(fwnode, con_id, idx, lookupflags);
+		desc = swnode_find_gpio(fwnode, con_id, idx, propname, propsize,
+					lookupflags);
 	}
 
 	return desc;
@@ -3970,11 +3973,15 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 						const char *label,
 						bool platform_lookup_allowed)
 {
+	char propname[32] = ""; /* 32 is max size of property name */
+	const char *funcname = con_id ?: propname;
 	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
 	struct gpio_desc *desc;
 	int ret;
 
-	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, &flags, &lookupflags);
+	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
+				    propname, sizeof(propname),
+				    &flags, &lookupflags);
 	if (gpiod_not_found(desc) && platform_lookup_allowed) {
 		/*
 		 * Either we are not using DT or ACPI, or their lookup did not
@@ -4012,7 +4019,7 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 		return desc;
 	}
 
-	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
+	ret = gpiod_configure_flags(desc, funcname, lookupflags, flags);
 	if (ret < 0) {
 		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
 		gpiod_put(desc);
-- 
2.40.0.1.gaa8946217a0b

