Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF17DC402
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjJaBwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbjJaBv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:51:56 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD9E1;
        Mon, 30 Oct 2023 18:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbgMbl4W2SLt7HOIJGQPnF7MxQNY/Gq/b2N7zQ2NipKYSkVA7vvM0QgbB7biG5+9MMYpNiad9UrK27biG38jZTrEjAa0VOYxKPpXUSp0NklHZGzWCRWTBC0KyMxbv18R8+0DvCKrIfBK9sBj+JIAVwdaD9udQwQaQddgSuDzWtVfGDJeVSz6ekHzmn86u7bag4J16ulxGPH65i9bfnIQ8mL0LGUm1HrqXxNQdXmk3+5UchJDzytfAOFz+wqZ2BNF2jHgEvmYd7FDy8Zvw9pjRPOfuAyW9Ou4sANJ3sdo+BrIaLV5/ota2TzM1ZPL5hTNf9d2W4BfKBKhf4Wq2O+C3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qqHHhWXU4PAYV2tbCaQZ21hZNwgIki0aofBQpPT360=;
 b=G+9kowaiTpIXMZRQSdXU46mM8YnMUI4x3KUAk8gHZg+714/cZMbFgplMmo9fbSELt76z4Z+oeP8aovysuYaDVz77btUyC2yfqY1vDq4SBsfHEZaJQwOARHHJl7WJHMpVMmkX6h1HQ5wCu7ZByBt50+fUxOAiWbaWe4dI7ZD1QFgknzdlJRgMi0EynYK9c0RSmfFe6EzCqpqu8PDrKYA6wTP1yTj4wI6k0L9uNeYsIBTEUABo1ZlOHenTy9H4PBq/Dt6JxYSFHlDD0r5YxwnXlmvVBq0Zgr1PpI3gMO01MTmvhmT0ZROvXbbKiUV4futAQ+8R7O/U2tmTP++WYqKHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by SEZPR06MB6926.apcprd06.prod.outlook.com (2603:1096:101:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 01:51:47 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572%4]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 01:51:47 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>,
        Gary Wang <garywang@aaeon.com.tw>
Subject: [PATCH V7 3/3] leds: Add support for UP board CPLD onboard LEDS
Date:   Tue, 31 Oct 2023 09:51:19 +0800
Message-Id: <20231031015119.29756-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231031015119.29756-1-larry.lai@yunjingtech.com>
References: <20231031015119.29756-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:403:a::30) To SEYPR06MB6507.apcprd06.prod.outlook.com
 (2603:1096:101:177::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|SEZPR06MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d29f6b-f4dd-42cc-ec5e-08dbd9b3f16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUUBthBjw1W1rfZ2bT/b7W87QE9/dlniBL9mj4xXhldwwCRY8+1NJ2NXP70Yk+dXNH3wGDWL+n6uNpbI6Tn04PANiMGcFmFt8laSxfclYcMnK0PqVPfsW5p1VWEclVN+4zyF2Om/oG3wVsWOQpeX+57bl+Ea0S220ywKi95ms+uPRmIwjIvAxcga6g3BrKq2EG5CalZagHf1LXW76ZF8+5m297yMsLL6faAD0g83YnnhzV+TF7CthPpC0bkCPCIrK/POhy9kk+y64uisbcxsqkYRLpWPd4NqotWUWtBjhGNxLRx8b0QEjwkUI+Pq8phxtNqcDunP5C5byMjobZqQlWfuUVxLJGrNi8jc8TSO/7itdFUORzlU1kIaw3UuTcn53gt54SxmpoUV3sQe06RIxfmtP1JD5tqZIk1sDf+UsCUZmxthQsnMl7eqC/rjUWlhNcDZ0qAqK58RYKOAtN6vkOziHHa9A+0fDVvyPPRX8FD+qHFM7yn3OH241bmeWryFC1LBbMaoYlI9EtZ0zcCU2fnj5RyYSlUNrrSvUCWkJjRsYIXqGSlDUb+YOt5POsjedZwdlTJX1YCFtP9O9og5CrZfzjhpxO8pRIqy+te73l7wbvm4gqdGBbLjV/RpR3AWirmVy3mX8TGlj1dk9UNrFMKSQ+Y9tlX0zxLMV8nLkOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39830400003)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799009)(451199024)(2906002)(38100700002)(86362001)(8676002)(8936002)(38350700005)(5660300002)(36756003)(41300700001)(4326008)(66946007)(478600001)(6512007)(6666004)(6506007)(52116002)(6486002)(66556008)(66476007)(54906003)(316002)(2616005)(83380400001)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Ok8nfR3nrFUSZDCPR1GBO4N2Fj2BEheVSAiEag2GzUhVzfMzblmgFdhCw14?=
 =?us-ascii?Q?TXwwOfxgblkXK4BEMS+i6fUiECXvtaUoUWOCX7JvB9ksiqITnJb3vsOt2yL3?=
 =?us-ascii?Q?bwWD6w3EFXN7l67Zdx5rQUq7ZQoobwCuCzEI3lwaQOIy+xHStz6etl0oYR3q?=
 =?us-ascii?Q?XTxjRXIzmeiJenAND6iYc2W6dln24GMbKfUP7J9Ona2fLKrCP3zMjp2t8z1i?=
 =?us-ascii?Q?EXw2CAEJu2mOrkHFNFIybFlL9r3QhEI2U4kGAYb00NgBB68dFx2zHceHnv6H?=
 =?us-ascii?Q?9gq1ByiuMr9rwYac/866nYT8jo/YjpL2LQTC9FJ6ly11anzUE8fugdX/Mv5u?=
 =?us-ascii?Q?4JPan8psAhH+HM5Ke0ovEX9CzP2PxalQ1AtpER891IGnVSKOMx+D8WICt0zY?=
 =?us-ascii?Q?UZc3Vp+1vJRsdLDkxWvlRvAqmSuEZXtY8WgHfXjjo9rntkRZnD/pAD65hM8A?=
 =?us-ascii?Q?nI3dNrbrFV+ZbbkaBhr1g+D7ymw1jZ+2F26DjvN49Bo0mjtzgoTioO64/HDl?=
 =?us-ascii?Q?IGRuP4nT01gRlgK/HQn+oYKB45m6hAsmO7bBKT/vHxAjzGhmOunTzC2peo+F?=
 =?us-ascii?Q?5wGkva36StP+kYyriYVMt6aMNhdI/tf2ZAdVvmLltUa2aTjRfMtJ5YXc2qgR?=
 =?us-ascii?Q?+miN8cY6HyJCILA0anWeilCEGYz2KwNXiCD8zpjFx/IpYjYT6w6wQrtH0+GO?=
 =?us-ascii?Q?kaisSM5D5dFYGQ28z0urcezlhOSJseTFPwZ9pihwdNmnlVixYtcif3We6duN?=
 =?us-ascii?Q?RxDkiFJYREnI2IIdQM/A3hIPZIIGtoy5TnpSG9Mmzu/ke9lwMpU7tHYiqsQ6?=
 =?us-ascii?Q?GJLWEjiWkWaEu9/2M3yyWvmugGMM/vAPmw43E5HYomiChv0lFyzmqzmqaFKv?=
 =?us-ascii?Q?S88R8hxwRv3KGAu4pXSyGtVwfrAsQPacDyBIMUvct99RqHm+sPpvnVoiofHL?=
 =?us-ascii?Q?wsJkSaakMDaigH0O+/zL9Cg8+f5yDfs1XyB4jbKuuYkI24e52ia/34L1VNhU?=
 =?us-ascii?Q?M2yLCWQ1pyj8J2lUaVVjJGOpSjLb4SxwlCq0jrFsdy/ixUHmoPOgAATB+H1Y?=
 =?us-ascii?Q?9bF6sdCrXnrd1s574SwvDb2uFkhS7kGHfxvuCi1UGuFavWajKVK1M6IvA4ni?=
 =?us-ascii?Q?tTbZhyxIHj8f1E7AFxDrLPSzQ7M/rOWG+HIZaltNIeEW0flvb8D2Ac9NizN3?=
 =?us-ascii?Q?cPI+h2p0lC6dRERmzg0QXtYVADQega7wV6ouK22d1kWnAavwj54KfUrU/fKn?=
 =?us-ascii?Q?tCEQfweQJebKXU8Zm1i/rAqQkePUB45ZSf4RqXJJFufsrcSgtP9GmioklXqN?=
 =?us-ascii?Q?IoF+KRQ3+3WhIAeAIKN6lW9zxhiwjzl3OWlRjXdUFBxoG4av6VkR69132og2?=
 =?us-ascii?Q?/Yr4jv9q8eTuezLb6EBJG52fTqpi0d37rnG2YjfgJ5Jhmo3s9Hpx3pp3qMVp?=
 =?us-ascii?Q?QMVXdCVnqcCJ4BZEStylXk8iJYipbioHYAMoqp73kZ1rxgln0+OpBP/mQOI7?=
 =?us-ascii?Q?9tsd8bp3kHfVB4mD9G0jXFR8N9zXMHS8dp3kEm7BeCKhQKMzsu962yVs4RHA?=
 =?us-ascii?Q?DQvEZGgYRkCOOErH0zWQl6X4xFlgP5blW8orXEr/K3lxrc/0KCi3xoOFApIH?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d29f6b-f4dd-42cc-ec5e-08dbd9b3f16e
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 01:51:47.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUZI3/bAbZz73W5uLbQJMDWZSKJ0P/fM7dH6zWvpySO2qbR2Do3WT3ziPiOD0TUCe5sgcffflzmDKX8XsRfpT9Bphk5qLHbV6pi0V5DSsZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6926
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP boards come with a few FPGA-controlled onboard LEDs:
* UP Board: yellow, green, red
* UP Squared: blue, yellow, green, red

This patch depends on patch "mfd: Add support for UP board CPLD/FPGA".

Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
PATCH V6 --> PATCH V7: cleaned up coding style and addressed review
comments.
PATCH V4 -> PATCH V6 : There is no change.
RFC 2023/04/25 -> PATCH V4
(1) Fixed kernel test robot compiler warning.
(2) Remove mistakes with wrong Reviewed-by tags.
RFC 2022/11/23 --> RFC 2023/04/25: Refer 2022/12/08 Lee Jones review,
cleaned up coding style.
PATCH V3 -> RFC 2022/11/23: Update the changes Copyright.
PATCH V1 -> V3: There is no change.
PATCH --> PATCH V1: Refer 2022/10/03 Andy Shevchenko review, cleaned up
coding style.
---
 drivers/leds/Kconfig        |  10 +++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-upboard.c | 154 ++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..d9d533cb38ca 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -872,6 +872,16 @@ source "drivers/leds/flash/Kconfig"
 comment "RGB LED drivers"
 source "drivers/leds/rgb/Kconfig"
 
+config LEDS_UPBOARD
+	tristate "LED support for the UP board"
+	depends on LEDS_CLASS
+	depends on MFD_INTEL_UPBOARD_FPGA
+	help
+	  This option enables support for the UP board LEDs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-upboard.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4fd2f92cd198..e72956645646 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= leds-ti-lmu-common.o
 obj-$(CONFIG_LEDS_TLC591XX)		+= leds-tlc591xx.o
 obj-$(CONFIG_LEDS_TPS6105X)		+= leds-tps6105x.o
 obj-$(CONFIG_LEDS_TURRIS_OMNIA)		+= leds-turris-omnia.o
+obj-$(CONFIG_LEDS_UPBOARD)		+= leds-upboard.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+= leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+= leds-wm8350.o
 obj-$(CONFIG_LEDS_WRAP)			+= leds-wrap.o
diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
new file mode 100644
index 000000000000..8198f41563ea
--- /dev/null
+++ b/drivers/leds/leds-upboard.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board CPLD/FPGA based LED driver
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct upboard_led {
+	struct regmap_field *field;
+	struct led_classdev cdev;
+	unsigned char bit;
+};
+
+static enum led_brightness upboard_led_brightness_get(struct led_classdev *cdev)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+	int brightness = 0;
+
+	regmap_field_read(led->field, &brightness);
+
+	return brightness;
+};
+
+static void upboard_led_brightness_set(struct led_classdev *cdev, enum led_brightness brightness)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+
+	regmap_field_write(led->field, brightness != LED_OFF);
+};
+
+static struct gpio_led_platform_data upboard_gpio_led_pd;
+static const struct mfd_cell upboard_gpio_led_cells[] = {
+	MFD_CELL_BASIC("leds-gpio", NULL,
+		       &upboard_gpio_led_pd,
+		       sizeof(upboard_gpio_led_pd), 0)
+};
+
+int upboard_led_gpio_register(struct upboard_fpga *fpga)
+{
+	struct gpio_led blue_led, yellow_led, green_led, red_led;
+	struct gpio_desc *desc;
+	static struct gpio_led leds[4];
+	int num_leds = 0;
+	int ret;
+
+	desc = devm_gpiod_get(fpga->dev, "blue", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		blue_led.name = "upboard:blue:";
+		blue_led.gpio = desc_to_gpio(desc);
+		blue_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		leds[num_leds++] = blue_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	desc = devm_gpiod_get(fpga->dev, "yellow", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		yellow_led.name = "upboard:yellow:";
+		yellow_led.gpio = desc_to_gpio(desc);
+		yellow_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		leds[num_leds++] = yellow_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	desc = devm_gpiod_get(fpga->dev, "green", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		green_led.name = "upboard:green:";
+		green_led.gpio = desc_to_gpio(desc);
+		green_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		leds[num_leds++] = green_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	desc = devm_gpiod_get(fpga->dev, "red", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		red_led.name = "upboard:red:";
+		red_led.gpio = desc_to_gpio(desc);
+		red_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		leds[num_leds++] = red_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	/* No optional LEDs defined */
+	if (num_leds == 0)
+		return -ENODEV;
+
+	upboard_gpio_led_pd.num_leds = num_leds;
+	upboard_gpio_led_pd.leds = leds;
+
+	ret = devm_mfd_add_devices(fpga->dev, PLATFORM_DEVID_AUTO,
+				   upboard_gpio_led_cells,
+				   ARRAY_SIZE(upboard_gpio_led_cells),
+				   NULL, 0, NULL);
+	if (ret) {
+		dev_err(fpga->dev, "Failed to add GPIO LEDs, %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init upboard_led_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga * const cpld = dev_get_drvdata(pdev->dev.parent);
+	struct reg_field fldconf = {
+		.reg = UPFPGA_REG_FUNC_EN0,
+	};
+	struct upboard_led_data * const pdata = pdev->dev.platform_data;
+	struct upboard_led *led;
+
+	/* check & register GPIO LEDs */
+	if (strstr(pdata->colour, "gpio"))
+		return upboard_led_gpio_register(cpld);
+
+	led = devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	fldconf.lsb = pdata->bit;
+	fldconf.msb = pdata->bit;
+	led->field = devm_regmap_field_alloc(&pdev->dev, cpld->regmap, fldconf);
+	if (IS_ERR(led->field))
+		return PTR_ERR(led->field);
+
+	led->cdev.brightness_get = upboard_led_brightness_get;
+	led->cdev.brightness_set = upboard_led_brightness_set;
+	led->cdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "upboard:%s:", pdata->colour);
+	if (!led->cdev.name)
+		return -ENOMEM;
+
+	return devm_led_classdev_register(&pdev->dev, &led->cdev);
+};
+
+static struct platform_driver upboard_led_driver = {
+	.driver = {
+		.name = "upboard-led",
+	},
+};
+module_platform_driver_probe(upboard_led_driver, upboard_led_probe);
+
+MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
+MODULE_DESCRIPTION("UP Board LED driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:upboard-led");
-- 
2.17.1

