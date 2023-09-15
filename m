Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35D27A1434
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjIODM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjIODMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:12:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45704270B;
        Thu, 14 Sep 2023 20:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgyC6nQRoargVnnBdH6gyJG6Q5yxcLw65WOUMHPzxOBn8nioFwe84E3O3Jtosd6msNpfDICSJUKYRiZC7rppSnCPRWRveslP2xV1odwTtNatYLSRH7G25iSQaWxpT0uuq3VTlW4Pc5kGa/gBT0t9nPjQUJEbzMudtl6oq0zueq5tlKvcEw5O/zH0MZLy8mJ8C0ttDnzx1Tw+ft8mkZwU9Pky9bZhMPyOpVfAW2p6RCYTCpsGRG19t88Fb+p59GyFmI+Jt/sU7ZICIN56LnO6o04IlF2G4BrXu6yQY6w3jvEm6aCO9LDo7apvhJI47kwf6L6y6ICNpApk7YIZc8BYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPEFak8DPIKg17Qx9spL/cql1Cl8xlsX59FcpvNA4j8=;
 b=NXCY13f2SQGb0TBvRjHCU9Vn4OEgx4B7ui+wFUs/+HCiLuzQZ62tiKaVNGv7U6GfghcInRlcsKP+p/mwvhz9kNc+xYrF4U7zYLuvrIiFnuqF+Adv+iQ0BakdnPzUEnwUCRQNQ6Bpmi3Iztqj4FGciCN23bVxSrsJH7Jhzl8dc1+JLT9kcTABmSlZHtmGmWVsxVOqVUioUS9MuTzabTkSR2akxHMcPtpQTgyqrAMv8tDaUHXcRoQpux4LCcu27aqvVygFBymTj0Zjf0qF0VfbNIvpThuWjR8vWr/YqETe3L9FsglJbLmjFMXaFmlVpdr46/EppS9/ezV19lvFLxp0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by JH0PR06MB6654.apcprd06.prod.outlook.com (2603:1096:990:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 03:12:11 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 03:12:11 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>,
        Gary Wang <garywang@aaeon.com.tw>
Subject: [PATCH V6 3/3] leds: Add support for UP board CPLD onboard LEDS
Date:   Fri, 15 Sep 2023 11:11:23 +0800
Message-Id: <20230915031123.14515-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915031123.14515-1-larry.lai@yunjingtech.com>
References: <20230915031123.14515-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To SEYPR06MB6507.apcprd06.prod.outlook.com
 (2603:1096:101:177::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|JH0PR06MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ea5b44-e3cd-46f7-6429-08dbb5998d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcFOmOxThUTHlf57ynylK+VOXqoIqb0gysYGalkKpJpFlFF2eXg/9zy06qWS4cOFtSjxod5aH+F67G/ywQg52H60HDWMTkyw72JDvQWU+adZtTwgxipSNSxWGH0IDsv9Boi0MvFAB+9FDHg048akfJwMheSZbr75IxLGpsYT30h/FIvvilpjdQRHn87FNyOaZ+6bZflzxRi83+Gwxondo9b+4iK7g4ENpIe6x7wnfT154kMQGCf0klVRageaf2MDH/2wv/GmLoB646aL7PQRw6l3gKmvsTaxfmDvuMP2k0y8EkeaSYo5+rIpJ3kH7nlhLvGZ2Id8batOV415z3AvlxUmpsicLoexvJX0TUQTzzs/4oPTROPr0Z5i2ukWfbaIuNNi9/TU1gXxW0H+fviGkzbIMFH4mvkUqsLGlLl4OamscuCE/i+xnVHzzSlDIkdIydu8D5dOUYpS6PKs1x7PAKr9ir8oTqqCyY7O2RII40fxtHGoqGfiS6xH2hVSElcvHBa3ZuiCcM21kohrlk8nsNBEc42RdBpBDB2RMOK6gnX7TpAZve1GOtb6qb2ZZ3uj8ZLqTtzTIcMN+kq9atnrN5gPBpJIvd3QQ/7Wt4rf12yyFpribXEcADLXg/Tw6Gw8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39830400003)(346002)(376002)(451199024)(1800799009)(186009)(36756003)(38350700002)(38100700002)(86362001)(52116002)(6666004)(4326008)(6486002)(478600001)(2906002)(8936002)(8676002)(41300700001)(5660300002)(6512007)(6506007)(83380400001)(54906003)(316002)(66556008)(66946007)(66476007)(1076003)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gGHqllS/rRe2sfyub0kQ/9bC5ZnyvFRaEcxjPfZY1HEIdzeJ37ldY8A49Zo+?=
 =?us-ascii?Q?4bjdJdpyNdy7lUjmeWIaX7u2/YzUiQrD9OxR9rtxnR1m4tI6KqqeQsLLaY5O?=
 =?us-ascii?Q?tRsOv9FLfeDhvCRg37JKrAgdyUHLtr65hI75u0z91p6bFDhYAUTOf+4rcBwB?=
 =?us-ascii?Q?JZmBGiXBhI9ySiIFbu9F4Sh5+lUkcJuqZan/fWH+6f+8JohSXWhKjWk8lVuV?=
 =?us-ascii?Q?bhFkgeeDg8uN7z7Pa9tDt8zsPQLB13OTbeX8vG+oKyI8srbPf3r5bSTrf4Bu?=
 =?us-ascii?Q?5Z4Ndtv7T09LSZNYLVkfc1JOO3fO1Pu9jb8BSN0yPncOzb5zqfp6yURdIUAh?=
 =?us-ascii?Q?4mqFWBSsGlwKCgjO5Xhyii66680WEQmfCsMgOLQBEnSEOdcQBJ3Ky7RP9vCS?=
 =?us-ascii?Q?ALYd7iOlJo0pvPKPcDlMnEloW3inyO9kJcmaTA2Rl83Oxx3cv7qnX2VeNRY2?=
 =?us-ascii?Q?QLxiFI5DAAELt7YxC+7ct868c0jC/9IZOREBhP+V9IQIFcDfN9lHE74KOVIR?=
 =?us-ascii?Q?1F/sEz94kEaFghChP9s42ec+FxL1oHMMPCA5ZenFRnQd3s0kKp5euMo4GMnH?=
 =?us-ascii?Q?Ahc0oe5VeWdr79slMQUIHdLi5T3y+rZrBqcDUEPpHIQOZ2kWISDyIsWcxDjP?=
 =?us-ascii?Q?vhGmxL8w/oEAIyUuR5WwWefHsbHXhE+bGnT9cciygr3LNnSrjazV6FIlHPf8?=
 =?us-ascii?Q?gtD752Uh/NjMUyiYva01vw9lR8IBRMPgjUsj+KkI1b9xJbhyLHvHhwW2Y2rP?=
 =?us-ascii?Q?msaSgYltItWnR8gH34dqZHKXiwuXe8KV/XvbixUTtwjhbo0uLVeyqpbL7dVd?=
 =?us-ascii?Q?uFOqxW6M6k8zOadfMhWkE8hx0yCTUwdi28UhOFQoMcL8lCm0c4WFDFBMqfeg?=
 =?us-ascii?Q?VewNJF9y40084bvVWviE6y7P36W3gsUOb1lj8ayEVBXY7aR1wsFiYfjpVWsV?=
 =?us-ascii?Q?4H3sytXCG771NioOs+lVKv1vmvja1u19zUgp9f69yEHuZ7V3PLGierEOQ6PW?=
 =?us-ascii?Q?Uxu2CVFtDOkjX0RFISFJvOVeVuSbRQ3yjULS5PeD+pra9wWw1fOW0szFwsxM?=
 =?us-ascii?Q?ul8DiA0gzXsktWTnPH3tjGkk0LU//UPWesI8pt96jLX38TuTzPNgCVMtuHex?=
 =?us-ascii?Q?f5+HcrR6seSe8kUqBnPxj01Dz+7dVV+ND52fJkbsKoyyD7HQIlLDMhS/Gpyz?=
 =?us-ascii?Q?cm9GLsH0vngjDXUNeliXQhChvXbhHwtj0Ry5tjroKJ2JHM+p1SrML5UIamL6?=
 =?us-ascii?Q?rEfxuEQPFWh7uSXR012uXoXJale/TH/NtOyibjsuSRa4kGSD2PDdMGyUhIap?=
 =?us-ascii?Q?9o5/oL/khCNzwdO3lTqjdfid5yvhjNvGEstgS0APdMFBASBLvxrXfvnlWugb?=
 =?us-ascii?Q?gUaA4RYQc5Foea4dWK4AznkNczZID2aOn58V+JugftbWE86MpwmmLbYA5yAK?=
 =?us-ascii?Q?eY2g6P1/mT8keqtn8Y/Rxgz+Sf7aRlnTAsohUsz4lxOqDRnQQ3m6qq6LLa5E?=
 =?us-ascii?Q?o74HxOvhzgY8vWF/a2eWEelvfa0ecs327FBTsunigiO9Zx0AXPuWSbI7PpBx?=
 =?us-ascii?Q?LrGMm+gPQkkq87kW+cHdQ93sY04uOERi1mizdV7eXrTPoPWgjjApoMyuNjQc?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ea5b44-e3cd-46f7-6429-08dbb5998d92
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:12:11.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYDYa3ueR9bora7gvMd6lWYz9CqHxWfIzAqImvb6PIEVIOgL89fjAXm6gpA/Csw+PHwvbesTYaiChU69HlT2ree5hjteO5AerP3s5EwIfj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6654
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
 drivers/leds/Kconfig        | 10 +++++
 drivers/leds/Makefile       |  1 +
 drivers/leds/leds-upboard.c | 79 +++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
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
index 000000000000..8a44afe8c526
--- /dev/null
+++ b/drivers/leds/leds-upboard.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board CPLD/FPGA based LED driver
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ */
+
+#include <linux/kernel.h>
+#include <linux/leds.h>
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
+static int __init upboard_led_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga * const up_fpga = dev_get_drvdata(pdev->dev.parent);
+	struct reg_field fldconf = {
+		.reg = UPFPGA_REG_FUNC_EN0,
+	};
+	struct upboard_led_data * const pdata = pdev->dev.platform_data;
+	struct upboard_led *led;
+
+	led = devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	fldconf.lsb = pdata->bit;
+	fldconf.msb = pdata->bit;
+	led->field = devm_regmap_field_alloc(&pdev->dev, up_fpga->regmap, fldconf);
+	if (IS_ERR(led->field))
+		return PTR_ERR(led->field);
+
+	led->cdev.brightness_get = upboard_led_brightness_get;
+	led->cdev.brightness_set = upboard_led_brightness_set;
+	led->cdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "upboard:%s:",
+					pdata->colour);
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

