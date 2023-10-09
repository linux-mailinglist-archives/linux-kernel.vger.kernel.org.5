Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD31C7BE976
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378054AbjJISeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377192AbjJISeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:34:18 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0F6A6;
        Mon,  9 Oct 2023 11:34:16 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id C4A6C84B0E;
        Mon,  9 Oct 2023 20:34:14 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Mon, 09 Oct 2023 20:33:58 +0200
Subject: [PATCH RFT v7 1/6] ARM: pxa: Convert Spitz OHCI to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231009-pxa-gpio-v7-1-c8f5f403e856@skole.hr>
References: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr>
In-Reply-To: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=jWL4QZTf4q1nSMZnAZbdL0TeeJev2PtE9jP/v9y0QG0=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlJEeb8Mqi/WmO31Qsudy2XA1+EdKJJ3bTZShCD
 t2TKOe26fCJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSRHmwAKCRCaEZ6wQi2W
 4frUEACRzelN55l+SDUpHL2V1saJ44bio5LAoX1GqGdfFcaFFylwFMlveGz+74W6Y0P1xwux5sd
 cJavRQ1pXjInkkdDOAz2EPr8QndBM70OrsoungTdJa1RcPOtuMVHZvfM6NiWMsnuN82vqx2Nbud
 FTAddUtNYCV0GmYSwACnqmXc1RyMr6o0uMaHMPZoS39PIyTHjlaVyGHGQ/Z9QGTnjWs62PiXbHm
 yZaHWD2B4ftnugptVIcac5p3pIwz8rXC3OrUE+StJYhHn4LTlNThdh/6dHue0jc8ojVqpAMhfvM
 fGXvGqR9O5U2bRmKoE1VGekv5f3WA/8o14hfF6PFXi0n9jn+bBB4Qj1ON8pdGdJpfYMSahIG8La
 03kx7e5GAeI2bC6XKUF4UcfVd0JSWJtpYIHveYYK46bluBKGXBds8w4zxuwvpILP/uMkTx+U3xk
 PA4DeC0onSvOpvhbExX1KbRR0jP1LyR5v8UdulPQnl9L4kdoIVP/f8axQB8YTczS2KtYgE8ZBh8
 Yzxl2tYAO7xtcXSaEAOp+NV9zbTIARoxYCW7ru8WG8Uz/D+tnt/chHpTrFMsfAHgGIpvpfhA1Mx
 SfHfpD12ZjdWwegn8hXHRR/TSTTnuCZ5cjsdLeloHMNU/vNccL0NjhHMoqYIbdPrNjCa+e6v0Uk
 /H1V4k86R6eLW4g==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/host/ohci-pxa27x.c |  5 +++++
 2 files changed, 11 insertions(+), 7 deletions(-)

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
index 357d9aee38a3..a809ba0bb25e 100644
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
+	pxa_ohci->usb_host = devm_gpiod_get_optional(&pdev->dev, "usb-host", GPIOD_OUT_LOW);
+	if (IS_ERR(pxa_ohci->usb_host))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pxa_ohci->usb_host),
+				"failed to get USB host GPIO\n");
 
 	for (i = 0; i < 3; ++i) {
 		char name[6];

-- 
2.42.0


