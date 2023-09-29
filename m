Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA617B3336
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjI2NPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjI2NPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:15:13 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7731B0;
        Fri, 29 Sep 2023 06:15:09 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 2BB078475B;
        Fri, 29 Sep 2023 15:15:07 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 29 Sep 2023 15:13:59 +0200
Subject: [PATCH RFC v3 1/6] ARM: pxa: Convert Spitz OHCI to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-pxa-gpio-v3-1-af8d5e5d1f34@skole.hr>
References: <20230929-pxa-gpio-v3-0-af8d5e5d1f34@skole.hr>
In-Reply-To: <20230929-pxa-gpio-v3-0-af8d5e5d1f34@skole.hr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=aaS8kMiqneoLRyB8TsJKCzQAPSmGaArXhTx/CbQd1hc=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlFs3Xj5wQjN90ornCql3PBgX73OCYrRwlY64sA
 JgAdNDzRkSJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRbN1wAKCRCaEZ6wQi2W
 4UCQD/9PeMpCFeB3z6+1NqdH4dYyQyrN7iGz1UNh3982GFr/W2vEZcum/j1/2eikIo5UNE3MA8S
 hA6SwiXEHkjc7e5tW2dueGqGLnk5W3jOXYfbuanl+AQj0rqq90b3wyxJIO7kwO6q2kqtFILq2Te
 hbJz0Q7B4prkPxoBx40cIrJpCpVFkA2cHHNpkqvRfQbVecWzJWqyeHYZ07KSYhF9ubOUZW67DH4
 aFmftqZdmXEMeFlXO/ZkGHDxvS5BZ/BE3GVX50wJOab2EK67gAkWIrD+QFPcb1vU5uHCpMX57mX
 towbsYYAldZC6i7kvGjr0hdoacTS9WbjL76T2t+Cx8l6Oo89mSxocx9bgreaYu9jRP09EL1SmL5
 Vjr/HFlI4dsZcl4NO2bCCGc1ZaYBpNn+N2nZ/SklIgNwBBoVFFgiwzQscDb+qnDMFeyo+BcPpAl
 1ysir8KsDuST0M+ZfdxfiMn3gr6351+eCH+Bve2l0PIMOSNnYcZEgNpc3n0iI4ijv2iIu23idR3
 A9v6lgtLAzRhof0N6w6QaDJr36MsxTd1c7Zm0HhlYCG3+zWYg1gDJYNp7DZOmfrwRsnJzFTGCkK
 aybLXf6zA/HHILGjioAT21ZdFL5HAV8nCQi3n2idvtVAysqFV7hZfnSKKDwRrJZh4I0EPDwT2ZI
 Li5nsUHMgv8UH+A==
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


