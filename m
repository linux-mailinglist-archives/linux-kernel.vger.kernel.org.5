Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29667B47DC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjJAONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjJAONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:13:06 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEAEB0;
        Sun,  1 Oct 2023 07:13:04 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 3E63482EE4;
        Sun,  1 Oct 2023 16:13:02 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sun, 01 Oct 2023 16:12:52 +0200
Subject: [PATCH RFC v4 1/6] ARM: pxa: Convert Spitz OHCI to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231001-pxa-gpio-v4-1-0f3b975e6ed5@skole.hr>
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr>
In-Reply-To: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2808;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=4sX1PS5NLwZRhHOu3BMbTUbGwhVaNfoWO3+h0yX7Lg4=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlGX5oD5v1q3D2pBy2pnWW2mOiPNx+cRWWHjXfT
 RC/kxqaZVqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRl+aAAKCRCaEZ6wQi2W
 4WEWD/0TD83mGgXX8o3qZD8paDoQgp4k+yu4xZlTzVxdkLr+ylGQfiGcqEzT+aYJilDsxRL7+EP
 v4nB+OOzh93aPma4q19BpnlJ+Odk4hBzDL+ztx782nmj6zcbpYj6d0HaAh4XxOfxlqqrN0j2lbI
 twBW6A4eKIif1nmDu0g8ITuG+Z1TSLynaj8tKnc7irnO13NcM6xwj0zzSnaG+OUNZTUClpmj+H7
 XDaVRHwzymEMxVU+t8YlP6mDo/ev6EfIbq25sr+FT6Qbdlcga5eE29H+FeKpiiKYZ3k3fNlgnwI
 UF3OAsORFbf6fbgOtDWVDyAf2vw3THHfrGPu6gYBVHZP5QFRUHIE2E+APhhomuDuetSbhPDovJX
 +ZrX5vDvcVDABKRtLAFaNDZB0lMQy4BNLmO6w0RVDbe5FPnsAcaDcR+oRmOJG2pILgS9JySqEJe
 pH7nfCrJYVpFvUNlW4MHc1l3APqb/WALkyZy3wejzC00/wDsuKkDq7STUkbTNFnDoQo6jtN/Avz
 Vn29rj4CGQ/0eNocMPKRCtCdTkZXyndk/Znxz57hz6KNKfIEal6A5gqrh+VKoKqwhB3uGkxxiN2
 3yw2rWAWtSqyiHEqJhfjOVKPesl22i4CWHkIUbGYXSkr8Rx7HjbYNn1uHOxdFCMA+PKX0mFSE98
 EBnaGhZEiosq8dA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sharp's Spitz board still uses the legacy GPIO interface for controlling
a GPIO pin related to the USB host controller.

Convert this function to use the new GPIO descriptor interface.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c      | 13 ++++++-------
 drivers/usb/host/ohci-pxa27x.c |  7 +++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index cc691b199429..535e2b2e997b 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -649,23 +649,22 @@ static inline void spitz_mmc_init(void) {}
  * USB Host
  ******************************************************************************/
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+GPIO_LOOKUP_SINGLE(spitz_usb_host_gpio_table, "pxa27x-ohci", "gpio-pxa",
+		SPITZ_GPIO_USB_HOST, "usb-host", GPIO_ACTIVE_LOW);
+
 static int spitz_ohci_init(struct device *dev)
 {
-	int err;
-
-	err = gpio_request(SPITZ_GPIO_USB_HOST, "USB_HOST");
-	if (err)
-		return err;
+	gpiod_add_lookup_table(&spitz_usb_host_gpio_table);
 
 	/* Only Port 2 is connected, setup USB Port 2 Output Control Register */
 	UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
 
-	return gpio_direction_output(SPITZ_GPIO_USB_HOST, 1);
+	return 0;
 }
 
 static void spitz_ohci_exit(struct device *dev)
 {
-	gpio_free(SPITZ_GPIO_USB_HOST);
+	gpiod_remove_lookup_table(&spitz_usb_host_gpio_table);
 }
 
 static struct pxaohci_platform_data spitz_ohci_platform_data = {
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 357d9aee38a3..b70d452ca7c2 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -121,6 +121,7 @@ struct pxa27x_ohci {
 	void __iomem	*mmio_base;
 	struct regulator *vbus[3];
 	bool		vbus_enabled[3];
+	struct gpio_desc *usb_host;
 };
 
 #define to_pxa27x_ohci(hcd)	(struct pxa27x_ohci *)(hcd_to_ohci(hcd)->priv)
@@ -447,6 +448,10 @@ static int ohci_hcd_pxa27x_probe(struct platform_device *pdev)
 	pxa_ohci = to_pxa27x_ohci(hcd);
 	pxa_ohci->clk = usb_clk;
 	pxa_ohci->mmio_base = (void __iomem *)hcd->regs;
+	pxa_ohci->usb_host = gpiod_get_optional(&pdev->dev, "usb-host", GPIOD_OUT_LOW);
+	if (IS_ERR(pxa_ohci->usb_host))
+		dev_warn(&pdev->dev, "failed to get USB host GPIO with %pe\n",
+				pxa_ohci->usb_host);
 
 	for (i = 0; i < 3; ++i) {
 		char name[6];
@@ -512,6 +517,8 @@ static void ohci_hcd_pxa27x_remove(struct platform_device *pdev)
 	for (i = 0; i < 3; ++i)
 		pxa27x_ohci_set_vbus_power(pxa_ohci, i, false);
 
+	gpiod_put(pxa_ohci->usb_host);
+
 	usb_put_hcd(hcd);
 }
 

-- 
2.42.0


