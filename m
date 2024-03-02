Return-Path: <linux-kernel+bounces-89266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E886ED8A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BFD1C21D72
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D91A23A0;
	Sat,  2 Mar 2024 00:44:47 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15095EBE
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709340286; cv=none; b=Y4FSVhUoT5noNH6Ccdr6047Hfb3kwKbAxy44sR/jFY9MzlEHDxuSdiCBD82oQeXhhJMyE41UCGeMun8cntjjUgSo+ossHTymZvHIP/xTZ4Wdafiz/NvbxQNLd/keH+N7JP5l0NrQouLpZfVXHOXjRRPrHJgXxZnKq2ax9QEA+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709340286; c=relaxed/simple;
	bh=N7aLsipkDvipYuH/b5r8b2CKLMOVSg0u+ObIwgGk21s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqT0emLYK3mdPM70WQMwhCatJ8m2KR3qsRyZ6ZCAKpkGMVyVeaw99CyLwS8koLk7Aqozcf6EzSLusrENd7AxGL+/LOvwrsqA2z/I1ctN0EVSCciF6nADVI/58fc5eDcxKVfqJGHVjLrJhBRA7YwlmHbO7nkdral4a9kXOLLFMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 0e94cdf9-d82e-11ee-b3cf-005056bd6ce9;
	Sat, 02 Mar 2024 02:44:42 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/1] gpio: nomadik: Finish conversion to use firmware node APIs
Date: Sat,  2 Mar 2024 02:44:18 +0200
Message-ID: <20240302004439.197232-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously driver got a few updates in order to replace OF APIs by
respective firmware node, however it was not finished to the logical
end, e.g., some APIs that has been used are still require OF node
to be passed. Finish that job by converting leftovers to use firmware
node APIs.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v2: also update necessary parts in the respective pin control driver
 drivers/gpio/Kconfig                      |  1 -
 drivers/gpio/gpio-nomadik.c               | 13 ++++++------
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 25 +++++++++++------------
 include/linux/gpio/gpio-nomadik.h         |  4 +++-
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index f633be517654..ef20ab921010 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -481,7 +481,6 @@ config GPIO_MXS
 config GPIO_NOMADIK
 	bool "Nomadik GPIO driver"
 	depends on ARCH_U8500 || ARCH_NOMADIK || MACH_EYEQ5 || COMPILE_TEST
-	depends on OF_GPIO
 	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to support the Nomadik SoC GPIO block. This block is also
diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index c9fd6631e0aa..483086deb397 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -23,10 +23,10 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -504,7 +504,7 @@ static inline void nmk_gpio_dbg_show_one(struct seq_file *s,
  * it is the pin controller or GPIO driver. However we need to use the right
  * platform device when looking up resources so pay attention to pdev.
  */
-struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
+struct nmk_gpio_chip *nmk_gpio_populate_chip(struct fwnode_handle *fwnode,
 					     struct platform_device *pdev)
 {
 	struct nmk_gpio_chip *nmk_chip;
@@ -517,9 +517,9 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	u32 id, ngpio;
 	int ret;
 
-	gpio_dev = bus_find_device_by_of_node(&platform_bus_type, np);
+	gpio_dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
 	if (!gpio_dev) {
-		pr_err("populate \"%pOFn\": device not found\n", np);
+		dev_err(&pdev->dev, "populate \"%pfwP\": device not found\n", fwnode);
 		return ERR_PTR(-ENODEV);
 	}
 	gpio_pdev = to_platform_device(gpio_dev);
@@ -624,7 +624,6 @@ static const struct irq_chip nmk_irq_chip = {
 static int nmk_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct nmk_gpio_chip *nmk_chip;
 	struct gpio_irq_chip *girq;
 	bool supports_sleepmode;
@@ -632,7 +631,7 @@ static int nmk_gpio_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	nmk_chip = nmk_gpio_populate_chip(np, pdev);
+	nmk_chip = nmk_gpio_populate_chip(dev_fwnode(dev), pdev);
 	if (IS_ERR(nmk_chip)) {
 		dev_err(dev, "could not populate nmk chip struct\n");
 		return PTR_ERR(nmk_chip);
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 7849144b3b80..b89b2609fdfd 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1190,8 +1190,8 @@ static int nmk_pinctrl_resume(struct device *dev)
 
 static int nmk_pinctrl_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct device_node *prcm_np;
+	struct device_node *fwnode = dev_fwnode(&pdev->dev);
+	struct device_node *prcm_fwnode;
 	struct nmk_pinctrl *npct;
 	uintptr_t version = 0;
 	int i;
@@ -1216,28 +1216,27 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 	 * or after this point: it shouldn't matter as the APIs are orthogonal.
 	 */
 	for (i = 0; i < NMK_MAX_BANKS; i++) {
-		struct device_node *gpio_np;
+		struct fwnode_handle *gpio_fwnode;
 		struct nmk_gpio_chip *nmk_chip;
 
-		gpio_np = of_parse_phandle(np, "nomadik-gpio-chips", i);
-		if (!gpio_np)
+		gpio_fwnode = fwnode_find_reference(fwnode, "nomadik-gpio-chips", i);
+		if (IS_ERR(gpio_fwnode))
 			continue;
 
-		dev_info(&pdev->dev, "populate NMK GPIO %d \"%pOFn\"\n",
-			 i, gpio_np);
-		nmk_chip = nmk_gpio_populate_chip(gpio_np, pdev);
+		dev_info(&pdev->dev, "populate NMK GPIO %d \"%pfwP\"\n", i, gpio_fwnode);
+		nmk_chip = nmk_gpio_populate_chip(gpio_fwnode, pdev);
 		if (IS_ERR(nmk_chip))
 			dev_err(&pdev->dev,
 				"could not populate nmk chip struct - continue anyway\n");
-		of_node_put(gpio_np);
+		fwnode_handle_put(gpio_fwnode);
 		/* We are NOT compatible with mobileye,eyeq5-gpio. */
 		BUG_ON(nmk_chip->is_mobileye_soc);
 	}
 
-	prcm_np = of_parse_phandle(np, "prcm", 0);
-	if (prcm_np) {
-		npct->prcm_base = of_iomap(prcm_np, 0);
-		of_node_put(prcm_np);
+	prcm_fwnode = fwnode_find_reference(fwnode, "prcm", 0);
+	if (!IS_ERR(prcm_fwnode)) {
+		npct->prcm_base = fwnode_iomap(prcm_fwnode, 0);
+		fwnode_handle_put(prcm_fwnode);
 	}
 	if (!npct->prcm_base) {
 		if (version == PINCTRL_NMK_STN8815) {
diff --git a/include/linux/gpio/gpio-nomadik.h b/include/linux/gpio/gpio-nomadik.h
index 9bdb09fda4c9..4a95ea7935fb 100644
--- a/include/linux/gpio/gpio-nomadik.h
+++ b/include/linux/gpio/gpio-nomadik.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_GPIO_NOMADIK_H
 #define __LINUX_GPIO_NOMADIK_H
 
+struct fwnode_handle;
+
 /* Package definitions */
 #define PINCTRL_NMK_STN8815	0
 #define PINCTRL_NMK_DB8500	1
@@ -263,7 +265,7 @@ void __nmk_gpio_make_output(struct nmk_gpio_chip *nmk_chip,
 			    unsigned int offset, int val);
 void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip, unsigned int offset,
 			 enum nmk_gpio_slpm mode);
-struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
+struct nmk_gpio_chip *nmk_gpio_populate_chip(struct fwnode_handle *fwnode,
 					     struct platform_device *pdev);
 
 /* Symbols declared in pinctrl-nomadik used by gpio-nomadik. */
-- 
2.44.0


