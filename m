Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E504F773FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjHHQvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjHHQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:50:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB0170C0;
        Tue,  8 Aug 2023 08:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yam/BsvVxiHWbT90nLTApiJfgjb8En2J7noUMpMlWGbExU666pr9w3ylYR3s/R8+nTXDLOptoLoByLx4E9F2l4s16JdpIDuBlHM7eTOIsIXs2VX4uuAg8EJSD9Y17iSnJbiOor4a3v/KP2P+WfrXFyDKV5vLE8KKSjLLOcu4V2TEIrvosdlk0udJnI5dV9RTlN02LWq2K82D1hEiOOJY/mtOM6lni3x7E1DMhF/CsN0YEZJVve4rucWPAZKT81tPr6cvwcsJwm6TT++Pj2x5Q/47RM+OHTq5Upn4oLuhtXd9yRJuqFezuz4QhBFnF3LUfAdhO1r/i/MnIC+ajFYXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaOI1jZ6bAU07tk5ty6P0APvUTBwaEbb40MJc9gKrRI=;
 b=mT9gQiqhFncwLCdMXJujTe30MNQQQSqFPBYqNutAbPUqUKpng59SDIbdMqH8XFZb0uuvjFYo2Ge57WX2c1c2VPVmQFZ/1AoxLFkTZfuO3bmYR8udDHCRnp5K5yjcQ9ddbRTS2mE2FhJ5wZeGRxy/U+I/IuRWVnikr47MR71/yFQFmHcQmCl2t1MBkI+pXflaIGdXNunJnU0tK6VfLmvGSSFD+KsGXOcK6FSyg80i/BoDoOM/kSKDm2yudlWzb2ofvnDWtuxJAdEwhfA8r6AsmKlxr8OqNfYA9kjVcp01/qem24Ws3cYEEuI+a1cbWyzCx5NzG2Nj/lVnHsbGc62uAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by KL1PR06MB6323.apcprd06.prod.outlook.com (2603:1096:820:e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:57:05 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:57:05 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, michael.wang@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>,
        Gary Wang <garywang@aaeon.com.tw>
Subject: [PATCH V5 3/3] leds: Add support for UP board CPLD onboard LEDS
Date:   Tue,  8 Aug 2023 22:56:01 +0800
Message-Id: <20230808145601.9401-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808145601.9401-1-larry.lai@yunjingtech.com>
References: <20230808145601.9401-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To SEYPR06MB6507.apcprd06.prod.outlook.com
 (2603:1096:101:177::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|KL1PR06MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 663e7e48-9ab9-49d8-25c1-08db981fba95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuId9HS4+BHf/pio6f8+BfaPAO8WtVPqQzPqukfDkckqu1posJ5MLQTap48ad02V7iVVcn9W1NyfpUO/5D+d19Hsn7AsBw+VXDOrwe9ycSaj7Yb2Hodf3dSuuqma2Rg6HLOrxo5KNxsBKKkauyDmD6f77Yot+sctCR7cbJabbpP7pLJMxPZq4JFuJrw4F1viPnHaM08QGkfKddzaQmIP1ekTOCXnUrPM6FDNPEmmMr3SiV0OA3I8Ibb3Fz8UJytmRusjQfqU5AU7se9ntIIJ42OG+ZbtIeiUHjarHd0zG258tM28Tbf5b+qftyInrVk8SxihPcur5PjW5ZkOymRmW4edqKO2vwQlNGSAd+vSdncGhk7KakB+6Zq7IRhfeh/Di+rtS80d7AG0m1meCLQ83nrglOBTSIJGokb4QDJIIfK52NHYSpc110mJxKT4fr+zPddVS/LYfmFWv5aUAp6+Wd44mbIU6x2j5A0LntbyBr/HhYQ7yEI384wa3h16vcHg2sPGQNrfpdfTmC1apCChrr8uqZZhbrbQrSWqcJr9N8cuB9AxtwNB+LUWKfdXyB5b/wKqIgDs8absFWxBPNVKzHBTykYaa0ar+lk3V6h5aO1SFRhFU0nMS8fBRykjWfMf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(346002)(39830400003)(451199021)(186006)(1800799003)(2616005)(36756003)(4326008)(6512007)(316002)(478600001)(38100700002)(54906003)(52116002)(38350700002)(66946007)(86362001)(6666004)(66556008)(66476007)(6486002)(6506007)(1076003)(26005)(8676002)(8936002)(41300700001)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eiz6jmmwMUUUk0x2ERNapjvIWXo/BjGc9mgGQGMfbuUW2lrV3B+Zu+zR0kJO?=
 =?us-ascii?Q?k0JeNaT6h1M8cjLN/GBaGwxM8rbaq+qPwYVWuPbvblLzlbJvwXdgOYJJ2iiO?=
 =?us-ascii?Q?8nDX/9H1Arz+EUqJu4sZfvrWNH/tVebHpOqdnMtLjrSLvftOIuw5JR2kMvNf?=
 =?us-ascii?Q?XTYHiJAwDU2vPagoal8mJw7SqOHOYtRwED4M9f0G63J5QaDWmDLSXVrDey1E?=
 =?us-ascii?Q?iUbUPkePR6pEKYf0D1bt72TXDeQ3OE9kxVTwmmKB+awm82XvT+RF7wccDM7W?=
 =?us-ascii?Q?nqKVuDCMax6NjL1O9p9F9f1MSrIE7T89dDzYOFdsYttIx6xelu8feuOxM72Q?=
 =?us-ascii?Q?68TXlxKi/cp6xAGOUlWk9ybFUaCyBhSyjuiFNVhoa2fcPT5BCoVtgn2d5kPl?=
 =?us-ascii?Q?/UZ4dKP67SXu0JDP/kTf9S+Xd9uHYt3H2QCswQ2a8Mud9OQfsAtXo4k7UwGz?=
 =?us-ascii?Q?2fyDkk0C2l8EacObQvZA5SjhLdWSlS6TiBO6avz66IW4GmwchTTIXNJwlBmi?=
 =?us-ascii?Q?l2sT5q6Y+3/hBp/QqAozdSgZIJ4brM3sK4OqnB04JLk/oQ7AlbHhOf/Tut+5?=
 =?us-ascii?Q?+1NgFfOS9qZ5nBw5py8VQkQOCwfG/et6ooyHtUsAJ5dNCwVZR6/9Xb0RzUwM?=
 =?us-ascii?Q?d2W6aXLiAFmXvm2C7UCdL7oPb9sNIZqzveoH6iiYVMrJKCrL91QmI/KftP+y?=
 =?us-ascii?Q?Dy8fZUeXZCaxn+i5BALbtWCirQ1iyAMmXlD7bISnP/7lm+vCvSIXf9jcO01S?=
 =?us-ascii?Q?I7fvwsYIFcp0x1+aaEaGTpgCb6w3etjZcjl86RQKgG3V+q59cepXA+IxYVzV?=
 =?us-ascii?Q?21/+/k/JpaqytPFAcAFlJKYg7oq6dwYxlIsdj914Ji8fzmhJCQBxN9+qItz/?=
 =?us-ascii?Q?TKQ/3J8mSEbsEek1perPSB76D+68nT4R2feYF3VinZVO3BItMb+XsHmUvB/n?=
 =?us-ascii?Q?VVsr/CYguFFwX5B986MDsQhff3Tw/tnGkQE0eFXTRlpgFFc5snsAxCfNvPWz?=
 =?us-ascii?Q?PT+bVZQ5UL480E98zwrSL7tfic2zslehcYs294gPadrzh6UiRYGo78gi6b+4?=
 =?us-ascii?Q?KL2Za93XoVQgxlfzjd9XM2DkvMQH49hEhcIYkqGuuCj3gD9oFJZJJzHeudvW?=
 =?us-ascii?Q?H8nw+tMNAx63GFxuIp5pheQwLbjmbQnolUEW5NH2ytjSwhW5B2KQesB89RJy?=
 =?us-ascii?Q?JrHd8nlCQektmnN/Y/j+Y8xGj3H3t21puZOTV40sQCeUSn7jFxIQlPOhSF1d?=
 =?us-ascii?Q?UG9YZvATAqMsEJgsy5leOvFXLfRg/jWxqqRNUokqH/Shj85KoDgp7H4p2E2U?=
 =?us-ascii?Q?T9nTcqVbO0x2UaIXiY33labDQ+0w9jV8N/8Lpk285x+EljL1wfEtgAudg7RF?=
 =?us-ascii?Q?AtETKuKsc7F/Y6yPM4zvQ9h3wAhKRw9wUxIiCyAjsv1y29Eg6bODKszcD4/S?=
 =?us-ascii?Q?sQKfDq8nkzDUfH+ENJ2lyhqiSCmcFxjT/hhrWaQq2eOl8qL97GDnpY/SCprI?=
 =?us-ascii?Q?2NQmJ3y/mReXCkX5NKbhjJF2+UVmDQOt6aVHTOLQAXq89u8RcXXK6HHdQK+J?=
 =?us-ascii?Q?WM95VjJVSTelJcF/+jxlha8DR0r1lcy5VN0YXz2SJnPq01okanvVr6vfXJsJ?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663e7e48-9ab9-49d8-25c1-08db981fba95
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:57:04.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxJimU9GiRcAmkL9BoKiStdVCzYd12aGsVBVMJfmNWrz2klFJQ5e37p+SLZ+vHuwTONdtO8kywGqCPbPeSRYo+Cohfv5ByeyqSRikQpzpuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
PATCH V4 -> PATCH V5 : There is no change.
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

