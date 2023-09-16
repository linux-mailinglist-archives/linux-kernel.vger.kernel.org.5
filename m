Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D577A2EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbjIPJME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjIPJLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:11:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ABC173B;
        Sat, 16 Sep 2023 02:11:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB14AC433C7;
        Sat, 16 Sep 2023 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694855495;
        bh=zxWRKx6qcJqNX0nIAEXQQKlcB3+IREcOJx11K9aTCFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUUy2ASHBy00tqqzciqnGjjgz0DPJwWQG1rx5x28KmfI2BjAUZkYJXRo9cSG9zkCE
         eLWtrpCVfKQbjCrZ8ANyZ+9WlNXU8MgME5fQfyBBOCfXb+rx8t3dTPmL/8RvSf4+Qi
         P4WGfeyY8jgtcrSLnOuXVS9lupXW7JPWPkyd3Yhfvra3LovGA2KGgs9fKh/Xv6T6Sw
         VO1UHw/uQLl0yFySWAROQ/qS2WjAGWjIIodu59SkMstJbWP+8ermfIbpKwBNq0LTDD
         hqMTLcBnFgJTR31kyFE1VJbwGwgjDHWz3MxDtPsMdOsbV1rgi7eQ6tUNMmMh23KH/u
         fxrtC1uud5U5w==
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [RFC PATCH 1/2] MIPS: AR7: remove VLYNQ init
Date:   Sat, 16 Sep 2023 11:11:23 +0200
Message-Id: <20230916091125.3221-2-wsa@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230916091125.3221-1-wsa@kernel.org>
References: <20230916091125.3221-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

VLYNQ bus support is going to be removed from the Kernel because there
has never been a vlynq_driver in the tree since 2009. So, it doesn't
make sense to setup a bus controller when it is not going to be
accessed. Remove the VLYNQ init code to remove the bus driver later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/mips/Kconfig                    |   1 -
 arch/mips/ar7/platform.c             | 193 +--------------------------
 arch/mips/include/asm/mach-ar7/ar7.h |   1 -
 3 files changed, 1 insertion(+), 194 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bc8421859006..0e8aff7355fb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -219,7 +219,6 @@ config AR7
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_ZBOOT_UART16550
 	select GPIOLIB
-	select VLYNQ
 	help
 	  Support for the Texas Instruments AR7 System-on-a-Chip
 	  family: TNETD7100, 7200 and 7300.
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 215149a85d83..b23dd74ca40e 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -14,7 +14,6 @@
 #include <linux/serial_8250.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
-#include <linux/vlynq.h>
 #include <linux/leds.h>
 #include <linux/string.h>
 #include <linux/etherdevice.h>
@@ -27,156 +26,6 @@
 #include <asm/mach-ar7/ar7.h>
 #include <asm/mach-ar7/prom.h>
 
-/*****************************************************************************
- * VLYNQ Bus
- ****************************************************************************/
-struct plat_vlynq_data {
-	struct plat_vlynq_ops ops;
-	int gpio_bit;
-	int reset_bit;
-};
-
-static int vlynq_on(struct vlynq_device *dev)
-{
-	int ret;
-	struct plat_vlynq_data *pdata = dev->dev.platform_data;
-
-	ret = gpio_request(pdata->gpio_bit, "vlynq");
-	if (ret)
-		goto out;
-
-	ar7_device_reset(pdata->reset_bit);
-
-	ret = ar7_gpio_disable(pdata->gpio_bit);
-	if (ret)
-		goto out_enabled;
-
-	ret = ar7_gpio_enable(pdata->gpio_bit);
-	if (ret)
-		goto out_enabled;
-
-	ret = gpio_direction_output(pdata->gpio_bit, 0);
-	if (ret)
-		goto out_gpio_enabled;
-
-	msleep(50);
-
-	gpio_set_value(pdata->gpio_bit, 1);
-
-	msleep(50);
-
-	return 0;
-
-out_gpio_enabled:
-	ar7_gpio_disable(pdata->gpio_bit);
-out_enabled:
-	ar7_device_disable(pdata->reset_bit);
-	gpio_free(pdata->gpio_bit);
-out:
-	return ret;
-}
-
-static void vlynq_off(struct vlynq_device *dev)
-{
-	struct plat_vlynq_data *pdata = dev->dev.platform_data;
-
-	ar7_gpio_disable(pdata->gpio_bit);
-	gpio_free(pdata->gpio_bit);
-	ar7_device_disable(pdata->reset_bit);
-}
-
-static struct resource vlynq_low_res[] = {
-	{
-		.name	= "regs",
-		.flags	= IORESOURCE_MEM,
-		.start	= AR7_REGS_VLYNQ0,
-		.end	= AR7_REGS_VLYNQ0 + 0xff,
-	},
-	{
-		.name	= "irq",
-		.flags	= IORESOURCE_IRQ,
-		.start	= 29,
-		.end	= 29,
-	},
-	{
-		.name	= "mem",
-		.flags	= IORESOURCE_MEM,
-		.start	= 0x04000000,
-		.end	= 0x04ffffff,
-	},
-	{
-		.name	= "devirq",
-		.flags	= IORESOURCE_IRQ,
-		.start	= 80,
-		.end	= 111,
-	},
-};
-
-static struct resource vlynq_high_res[] = {
-	{
-		.name	= "regs",
-		.flags	= IORESOURCE_MEM,
-		.start	= AR7_REGS_VLYNQ1,
-		.end	= AR7_REGS_VLYNQ1 + 0xff,
-	},
-	{
-		.name	= "irq",
-		.flags	= IORESOURCE_IRQ,
-		.start	= 33,
-		.end	= 33,
-	},
-	{
-		.name	= "mem",
-		.flags	= IORESOURCE_MEM,
-		.start	= 0x0c000000,
-		.end	= 0x0cffffff,
-	},
-	{
-		.name	= "devirq",
-		.flags	= IORESOURCE_IRQ,
-		.start	= 112,
-		.end	= 143,
-	},
-};
-
-static struct plat_vlynq_data vlynq_low_data = {
-	.ops = {
-		.on	= vlynq_on,
-		.off	= vlynq_off,
-	},
-	.reset_bit	= 20,
-	.gpio_bit	= 18,
-};
-
-static struct plat_vlynq_data vlynq_high_data = {
-	.ops = {
-		.on	= vlynq_on,
-		.off	= vlynq_off,
-	},
-	.reset_bit	= 16,
-	.gpio_bit	= 19,
-};
-
-static struct platform_device vlynq_low = {
-	.id		= 0,
-	.name		= "vlynq",
-	.dev = {
-		.platform_data	= &vlynq_low_data,
-	},
-	.resource	= vlynq_low_res,
-	.num_resources	= ARRAY_SIZE(vlynq_low_res),
-};
-
-static struct platform_device vlynq_high = {
-	.id		= 1,
-	.name		= "vlynq",
-	.dev = {
-		.platform_data	= &vlynq_high_data,
-	},
-	.resource	= vlynq_high_res,
-	.num_resources	= ARRAY_SIZE(vlynq_high_res),
-};
-
 /*****************************************************************************
  * Flash
  ****************************************************************************/
@@ -592,34 +441,6 @@ static int __init ar7_register_uarts(void)
 
 static void __init titan_fixup_devices(void)
 {
-	/* Set vlynq0 data */
-	vlynq_low_data.reset_bit = 15;
-	vlynq_low_data.gpio_bit = 14;
-
-	/* Set vlynq1 data */
-	vlynq_high_data.reset_bit = 16;
-	vlynq_high_data.gpio_bit = 7;
-
-	/* Set vlynq0 resources */
-	vlynq_low_res[0].start = TITAN_REGS_VLYNQ0;
-	vlynq_low_res[0].end = TITAN_REGS_VLYNQ0 + 0xff;
-	vlynq_low_res[1].start = 33;
-	vlynq_low_res[1].end = 33;
-	vlynq_low_res[2].start = 0x0c000000;
-	vlynq_low_res[2].end = 0x0fffffff;
-	vlynq_low_res[3].start = 80;
-	vlynq_low_res[3].end = 111;
-
-	/* Set vlynq1 resources */
-	vlynq_high_res[0].start = TITAN_REGS_VLYNQ1;
-	vlynq_high_res[0].end = TITAN_REGS_VLYNQ1 + 0xff;
-	vlynq_high_res[1].start = 34;
-	vlynq_high_res[1].end = 34;
-	vlynq_high_res[2].start = 0x40000000;
-	vlynq_high_res[2].end = 0x43ffffff;
-	vlynq_high_res[3].start = 112;
-	vlynq_high_res[3].end = 143;
-
 	/* Set cpmac0 data */
 	cpmac_low_data.phy_mask = 0x40000000;
 
@@ -656,18 +477,6 @@ static int __init ar7_register_devices(void)
 	if (ar7_is_titan())
 		titan_fixup_devices();
 
-	ar7_device_disable(vlynq_low_data.reset_bit);
-	res = platform_device_register(&vlynq_low);
-	if (res)
-		pr_warn("unable to register vlynq-low: %d\n", res);
-
-	if (ar7_has_high_vlynq()) {
-		ar7_device_disable(vlynq_high_data.reset_bit);
-		res = platform_device_register(&vlynq_high);
-		if (res)
-			pr_warn("unable to register vlynq-high: %d\n", res);
-	}
-
 	if (ar7_has_high_cpmac()) {
 		res = fixed_phy_add(PHY_POLL, cpmac_high.id,
 				    &fixed_phy_status);
@@ -706,7 +515,7 @@ static int __init ar7_register_devices(void)
 	val = readl(bootcr);
 	iounmap(bootcr);
 	if (val & AR7_WDT_HW_ENA) {
-		if (ar7_has_high_vlynq())
+		if (ar7_has_high_cpmac())
 			ar7_wdt_res.start = UR8_REGS_WDT;
 		else
 			ar7_wdt_res.start = AR7_REGS_WDT;
diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-ar7/ar7.h
index 1e8621a6afa3..faa6a15503d6 100644
--- a/arch/mips/include/asm/mach-ar7/ar7.h
+++ b/arch/mips/include/asm/mach-ar7/ar7.h
@@ -142,7 +142,6 @@ static inline int ar7_has_high_cpmac(void)
 		return -ENXIO;
 	}
 }
-#define ar7_has_high_vlynq ar7_has_high_cpmac
 #define ar7_has_second_uart ar7_has_high_cpmac
 
 static inline void ar7_device_enable(u32 bit)
-- 
2.35.1

