Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98CA7A142F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjIODMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIODMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:12:16 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF6F26A4;
        Thu, 14 Sep 2023 20:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNr4nSiyfXQzxasy4skvXLHG1toraO3ige6RGaIQe1PNRPwe+OooEBQY4NOGFX3+K8MGOG+bsiq4PyIRCKYwEpRHcJiJy32M9YaLQoC8VFgEMq2lY9wU7n2gP3VE5HQzH15BY3Lab2usub0v9nwZ6PrIHCOR0iGeHNsdOMw3KM8K/XtD6pWPpjepODz8b3QxxjZinvSgedqJFsg4Vcrkqt7HE7GrvWFxbYUyL5J9lzd0knOWziEb39ESqhJEej4K8aD1uKZmIu8/++I6waj3FAycaR5Xxb5tkN5OJrvhj1IldvJWqf5Yrr9PvYakqpnw55sOCw0lTRuWMR5bCVXxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2XBTr83M9b1TR4vEAsxJ8kiqCI6dJl6F9Z0gK9Z1Io=;
 b=gXBMWy83zFOzZ4uz6SGMulebNEHsyLMq4AHVnnezhSB/FZg3G3t7V9zXkBrOx0eUsBYFWfIdgPrgO7w1REJWxWA9mYit9lLPdg9Iq57Rfx7tlsDnNd27EMjnQNK0g35lhBShTF3eOOHDehnK/ZEawbcFIxLTtLDdlNJ+ZJNAxe6mOjWmyODtDFF8e2enr4aQwkH8CH3QVrx3za/r2bxAuC9KVTik/RGxjfnOt6Hl3MPJvR2IkbQDQdih5xhr08heG6cOxT3wGpAs4V9vq/fnOpU0zh90a/i07IuILC/ALoEoM2HPXdnYWgS9UOAwP4yZ8jPqIFZQBua+nBY0WOolMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by JH0PR06MB6654.apcprd06.prod.outlook.com (2603:1096:990:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 03:12:07 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 03:12:07 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>,
        Gary Wang <garywang@aaeon.com.tw>
Subject: [PATCH V6 1/3] mfd: Add support for UP board CPLD/FPGA
Date:   Fri, 15 Sep 2023 11:11:21 +0800
Message-Id: <20230915031123.14515-2-larry.lai@yunjingtech.com>
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
X-MS-Office365-Filtering-Correlation-Id: a0a89e7a-de28-48ec-f83e-08dbb5998ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYOG+gEN9X8V7/gom3Ynt2U5f3DROa8WHaGO2kAX2K+nlCnjjbQvGv2PFdI/iWnGDsFpTnAya12711ONhe2jPMB1O/yHhXKogYYb0S8UrP/hfspCn3VM/+kFkGcZqZ6rf0zo4rqZf6NWPTbw4feZYc7wIA6YcJX9nOEcPvcjwXuj/HPffvNaP9VESjxJTs0XRYo8ZA1nClo/HpeAjRH9HhOn4WpOpsSbsWZY+RgnFSkw9v1Fv2miLzQBDb9oaYyBTQH8pydvnV1ZRZ0IXXjUk/ZuEqkYEs2lzwhaNf76s1ZSUMQFgHacm49ymLDQGdi3VAWFDLrUfdI3xhFVCgiOPdPkS+1gCINm5cznuhiTDdhuuicGB9j+QUqHqQMes/qEt7GGk62B1M8uPaXwPNWlhcH4k210JVed/ECB7l7/POnDZ2EUZDs3yy8ln2WulGqjibDdQmDi5vQlukhizl0xzC4KjJqceBOe7E0zuSJXENyKbwHj2pQ4FYgwpj6/xKiNcyr9CV0vXCrnuwJ1UJLXmjWUGqzlLgxn93yBKZtRPHYHTAWLRqNQw5PTq0BgxGM7htZCSFzH58bmUKhPVB3jawoLyvGOlz9Qe3yO2f2HKEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39830400003)(346002)(376002)(451199024)(1800799009)(186009)(36756003)(38350700002)(38100700002)(86362001)(52116002)(6666004)(4326008)(6486002)(478600001)(2906002)(30864003)(8936002)(8676002)(41300700001)(5660300002)(6512007)(6506007)(83380400001)(54906003)(316002)(66556008)(66946007)(66476007)(1076003)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvI71kPnBtLxUpeg0x0pCjSvaLEJdvjOOm0yBMR1xutioD+LvKmQL3VveTlA?=
 =?us-ascii?Q?qxOKsgukFpmUbVxYkrkvZFqiT/MnWUJVbH6zGb+GoisehZGB4A477LOAirIE?=
 =?us-ascii?Q?rFoQKxH6lZGvyd8Uq60k6WtXBDXoW5WLhQXlnjoZZ83foj5kyydJgDZ2v1vl?=
 =?us-ascii?Q?/9pw25q89vVPlhxZsD9egXv79417vZ8dROULk+a24iPNSW5ez2B98FFgeNA5?=
 =?us-ascii?Q?nCsP1UlN7yusneGOfYyDrB+lQQn9Yj0kOCXHClXcr0qxyLsVfGZ8X0bruNh4?=
 =?us-ascii?Q?y9bx7gXM4pVOQCo3bez8yoch6qE6qS8xFGefmcj//MslJUJXDJ/jmbY0FnVZ?=
 =?us-ascii?Q?bs34WVWMbYlJHMuL2EBKF5aOFapRK/sxWWbFyuTFieU3nrbhGP/nUU1V4ugl?=
 =?us-ascii?Q?T5CCKgKELZUuL84BCKLigiFI9/e6XQNfJxFZ8mJYVoyKoVu76TW+IjuKwa/F?=
 =?us-ascii?Q?904Hzb0JIZA58STvL6d9xnhTbqrXzJsd5N4Aq8GipiM11dEcC/ITFKVHNpT1?=
 =?us-ascii?Q?XTwMc98mfLAnJJheW4flkN44ZPA7WgXa1mn70/kduD8g6pWEth3FDozf36PY?=
 =?us-ascii?Q?dRvtdVFqozWvY5l7E5CMyJeYEazM8RD0uJFmMIsMaI17kKGQq3wieoI91zsh?=
 =?us-ascii?Q?baWq0VJxNhNX4yBeJqtl0bWTvrR8qk6LEHXRZek9MADnNnSFVGv1yU3dcMEB?=
 =?us-ascii?Q?7o7tm1A0Wh6BFFhAlg6e2h71uk6paZ/zGAYsLcKn84zBuykgCuQ2V5b2s2Ve?=
 =?us-ascii?Q?YhRYk0T3H07H40waC3FMF0Q/BnqtXkZaRWgx4Hm8CdapnJDuN86s2Kq+Pn2Y?=
 =?us-ascii?Q?lTFWJ4LqgEoj4MNYlod1J8UyOkx8sG++y8HbYFV21aTPCz8BK56SFLvP/FQL?=
 =?us-ascii?Q?f4fi0xj+H3OCkhXwFp94YCOtLcDz4D2ZmKtnqnijM1guCfVH4RbmMEweHpqs?=
 =?us-ascii?Q?tDXN1MwPx4C4PUqpES9B3fvLs5ZJWCZW2uliPSBWMfK1hd4OIW3FRPh6BCi1?=
 =?us-ascii?Q?UGUtXloH1+sRgvjwTPQazPyxXDrpoWpBM5Bf1hRXQ4uUgbysGKYM2jozWgEJ?=
 =?us-ascii?Q?WGsYN9HeNSmhCfKDNsfQEbMw1WyjbUI2oLfa71A5k2J6baTQD9wKVgNghxo3?=
 =?us-ascii?Q?ehoK0JZttWQlr5zwiv49zjD54MUEC99aPJlQa3/RbiZnHA7U4pZYdcn+AoKx?=
 =?us-ascii?Q?a/g+3GiH/72qlqWGchVx54kMU3uh8SeJg+QqjPY/SaBNHKVRY0ob/FJBn376?=
 =?us-ascii?Q?LBtN2y5p5GbPHI7HaOduoyOSaRXK9ED6XDjRjT4kA0an3Iz7Gi6usK68y4vu?=
 =?us-ascii?Q?TghzthHX7QRMW8EdS09WTfChdAQTrHbv+CatAGKbGRgx2sbKropbQcbcdpjs?=
 =?us-ascii?Q?I7CdPJC0Pr7JCLEsJTbYaB5TiwF30YV49ycl77r4MSerjrrU9Lqy5SnTF+7K?=
 =?us-ascii?Q?/yUbxHRRBxGYNtCCxRzxZAo014fhdhYvPiWyZs3qattExi9gOWs9n8o5hCio?=
 =?us-ascii?Q?3RLDVlpafm+pqXXhGnsaAfvWogZBsOhZpwJpxWzouUJyvGVCKjfU83NHCVFE?=
 =?us-ascii?Q?yakpAt22E44k8sjay1ulJ0BdhvHVeeIdhouSC8d3pMNSrumlGThbfPiqm7UZ?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a89e7a-de28-48ec-f83e-08dbb5998ad2
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:12:06.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2XmXiFgeXOwHdkWpn41TYpUd39HWHUnSyu28M9dH/NkKcGPUwPieqrvdxEKxa5UnCKc7O2lYLt+jbs/FsQ3NBEWDfI1/6CbVNDTUFBltyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6654
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP Squared board <http://www.upboard.com> implements certain
features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.

This driver implements the line protocol to read and write registers
from the FPGA through regmap. The register address map is also included.

The UP Boards provide a few I/O pin headers (for both GPIO and
functions), including a 40-pin Raspberry Pi compatible header.

This patch implements support for the FPGA-based pin controller that
manages direction and enable state for those header pins.

Partial support UP boards:
* UP core + CREX
* UP core + CRST02

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
PATCH V5 -> PATCH V6
(1) Fixed kernel test robot compiler warning.
PATCH V4 -> PATCH V5
(1) Refer 2023/05/25 Lee Jones review, cleaned up coding style
and addressed review comments.
(2) Synchronizing upboard github to v1.0.5 tag.
RFC 2023/04/25 -> PATCH V4
(1) Fixed kernel test robot compiler warning.
(2) Remove mistakes with wrong Reviewed-by tags.
RFC 2022/11/23 -> RFC 2023/04/25
(1) Refer 2022/12/08 Andy Shevchenko review, cleaned up coding style
and addressed review comments.
PATCH V3 -> RFC 2022/11/23:
(1) Refer 2022/11/16 Lee Jones review, cleaned up coding style and
addressed review comments.
(2) Description on the UP Boards FPGA register read/write protocols
PATCH V2 -> V3:
(1) fixed kernel test robot compiler warning.
PATCH V1 -> V2:
(1) Synchronizing upboard github to rc2.
(2) Refer 2022/10/31 Lee Jones review, fixed some of the issues.
---
 drivers/mfd/Kconfig              |  12 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 492 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  55 ++++
 4 files changed, 560 insertions(+)
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 include/linux/mfd/upboard-fpga.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab1a1a4..1041e937fc7a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2104,6 +2104,18 @@ config MFD_QCOM_PM8008
 	  under it in the device tree. Additional drivers must be enabled in
 	  order to use the functionality of the device.
 
+config MFD_INTEL_UPBOARD_FPGA
+	tristate "Support for the Intel platform foundation kit UP board FPGA"
+	select MFD_CORE
+	depends on X86 && ACPI
+	help
+	  Select this option to enable the Intel AAEON UP and UP^2 on-board FPGA.
+	  This is core driver for the UP board that implements certain (pin
+	  control, onboard LEDs or CEC) through an on-board FPGA.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called upboard-fpga.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..8374a05f6f43 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -250,6 +250,7 @@ obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
 obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
+obj-$(CONFIG_MFD_INTEL_UPBOARD_FPGA)	+= upboard-fpga.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
diff --git a/drivers/mfd/upboard-fpga.c b/drivers/mfd/upboard-fpga.c
new file mode 100644
index 000000000000..b5c36f9dbfdd
--- /dev/null
+++ b/drivers/mfd/upboard-fpga.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board for control CPLD/FPGA to
+ * provide more GPIO driving power also provide CPLD LEDs and pin mux function
+ * recognize HID AANT0F00 ~ AAANT0F04 in ACPI name space
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+struct upboard_fpga_data {
+	const struct regmap_config *regmap_config;
+	const struct mfd_cell *cells;
+	size_t ncells;
+};
+
+static struct gpio_led_platform_data pdata;
+
+#define RESET_DEVICE 1
+#define ENABLE_DEVICE 1
+
+#define AAEON_MANUFACTURER_ID		0x01
+#define SUPPORTED_FW_MAJOR		0x0
+#define MENUFACTURER_ID_MASK		GENMASK(7, 0)
+
+#define FIRMWARE_ID_BUILD_OFFSET	12
+#define FIRMWARE_ID_MAJOR_OFFSET	8
+#define FIRMWARE_ID_MINOR_OFFSET	4
+#define FIRMWARE_ID_PATCH_OFFSET	0
+#define FIRMWARE_ID_MASK		GENMASK(3, 0)
+
+/*
+ * read CPLD register on custom protocol
+ * send clock and addr bit in strobe and datain pins then read from dataout pin
+ */
+static int upboard_fpga_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	/* clear to start new transcation */
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	reg |= UPFPGA_READ_FLAG;
+
+	/* send clock and data from strobe & datain */
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, !!(reg & BIT(i)));
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+	*val = 0;
+
+	/* read from dataout */
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		*val |= gpiod_get_value(fpga->dataout_gpio) << i;
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+}
+
+/*
+ * write CPLD register on custom protocol
+ * send clock and addr bit in strobe and datain pins then write to datain pin
+ */
+static int upboard_fpga_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	/* clear to start new transcation */
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	/* send clock and data from strobe & datain */
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, !!(reg & BIT(i)));
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+
+	/* write to datain pin */
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->datain_gpio, !!(val & BIT(i)));
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+}
+
+static const struct regmap_range upboard_up_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_range upboard_up_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_access_table upboard_up_readable_table = {
+	.yes_ranges = upboard_up_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up_writable_table = {
+	.yes_ranges = upboard_up_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_writable_ranges),
+};
+
+static const struct regmap_config upboard_up_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_fpga_read,
+	.reg_write = upboard_fpga_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_NONE,
+	.rd_table = &upboard_up_readable_table,
+	.wr_table = &upboard_up_writable_table,
+};
+
+/* 3 LEDs controlled by CPLD */
+static struct upboard_led_data upboard_up_led_data[] = {
+	{ .bit = 0, .colour = "yellow" },
+	{ .bit = 1, .colour = "green" },
+	{ .bit = 2, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up_mfd_cells[] = {
+	MFD_CELL_NAME("upboard-pinctrl"),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[0],
+		       sizeof(*upboard_up_led_data), 1),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[1],
+		       sizeof(*upboard_up_led_data), 2),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[2],
+		       sizeof(*upboard_up_led_data), 3),
+};
+
+/* UP Squared 6000 EHL board */
+
+static const struct upboard_fpga_data upboard_up_fpga_data = {
+	.regmap_config = &upboard_up_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+static const struct mfd_cell upboard_pinctrl_cells[] = {
+	MFD_CELL_NAME("upboard-pinctrl"),
+};
+
+static const struct upboard_fpga_data upboard_pinctrl_data = {
+	.regmap_config = &upboard_up_regmap_config,
+	.cells = upboard_pinctrl_cells,
+	.ncells = ARRAY_SIZE(upboard_pinctrl_cells),
+};
+
+/* UP^2 board */
+static const struct regmap_range upboard_up2_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_range upboard_up2_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_access_table upboard_up2_readable_table = {
+	.yes_ranges = upboard_up2_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up2_writable_table = {
+	.yes_ranges = upboard_up2_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_writable_ranges),
+};
+
+static const struct regmap_config upboard_up2_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_fpga_read,
+	.reg_write = upboard_fpga_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_NONE,
+	.rd_table = &upboard_up2_readable_table,
+	.wr_table = &upboard_up2_writable_table,
+};
+
+static struct upboard_led_data upboard_up2_led_data[] = {
+	{ .bit = 0, .colour = "blue" },
+	{ .bit = 1, .colour = "yellow" },
+	{ .bit = 2, .colour = "green" },
+	{ .bit = 3, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up2_mfd_cells[] = {
+	MFD_CELL_NAME("upboard-pinctrl"),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[0],
+		       sizeof(*upboard_up2_led_data), 1),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[1],
+		       sizeof(*upboard_up2_led_data), 2),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[2],
+		       sizeof(*upboard_up2_led_data), 3),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[3],
+		       sizeof(*upboard_up2_led_data), 4),
+};
+
+static const struct upboard_fpga_data upboard_up2_fpga_data = {
+	.regmap_config = &upboard_up2_regmap_config,
+	.cells = upboard_up2_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up2_mfd_cells),
+};
+
+/* UP-CRST02 carrier board for UP Core */
+
+/* same MAX10 config as UP2, but same LED cells as UP1 */
+static const struct upboard_fpga_data upboard_upcore_crst02_fpga_data = {
+	.regmap_config = &upboard_up2_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+static int __init upboard_fpga_gpio_init(struct upboard_fpga *fpga)
+{
+	enum gpiod_flags flags = fpga->uninitialised ? GPIOD_OUT_LOW : GPIOD_ASIS;
+
+	fpga->enable_gpio = devm_gpiod_get(fpga->dev, "enable", flags);
+	if (IS_ERR(fpga->enable_gpio))
+		return PTR_ERR(fpga->enable_gpio);
+
+	fpga->clear_gpio = devm_gpiod_get(fpga->dev, "clear", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->clear_gpio))
+		return PTR_ERR(fpga->clear_gpio);
+
+	fpga->strobe_gpio = devm_gpiod_get(fpga->dev, "strobe", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->strobe_gpio))
+		return PTR_ERR(fpga->strobe_gpio);
+
+	fpga->datain_gpio = devm_gpiod_get(fpga->dev, "datain", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->datain_gpio))
+		return PTR_ERR(fpga->datain_gpio);
+
+	fpga->dataout_gpio = devm_gpiod_get(fpga->dev, "dataout", GPIOD_IN);
+	if (IS_ERR(fpga->dataout_gpio))
+		return PTR_ERR(fpga->dataout_gpio);
+
+	/*
+	 * The SoC pinctrl driver may not support reserving the GPIO line for
+	 * FPGA reset without causing an undesired reset pulse. This will clear
+	 * any settings on the FPGA, so only do it if we must.
+	 * Reset GPIO defaults HIGH, get GPIO and set to LOW, then set back to
+	 * HIGH as a pulse.
+	 */
+	if (fpga->uninitialised) {
+		fpga->reset_gpio = devm_gpiod_get(fpga->dev, "reset", GPIOD_OUT_LOW);
+		if (IS_ERR(fpga->reset_gpio))
+			return PTR_ERR(fpga->reset_gpio);
+
+		gpiod_set_value(fpga->reset_gpio, RESET_DEVICE);
+	}
+
+	gpiod_set_value(fpga->enable_gpio, ENABLE_DEVICE);
+	fpga->uninitialised = false;
+
+	return 0;
+}
+
+static int __init upboard_fpga_verify_device(struct upboard_fpga *fpga)
+{
+	unsigned int platform_id, manufacturer_id;
+	unsigned int firmware_id, build, major, minor, patch;
+	int ret;
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_PLATFORM_ID, &platform_id);
+	if (ret)
+		return ret;
+
+	manufacturer_id = platform_id & MENUFACTURER_ID_MASK;
+	if (manufacturer_id != AAEON_MANUFACTURER_ID) {
+		dev_err(fpga->dev,
+			"Manufacturer ID 0x%02x not supported\n",
+			manufacturer_id);
+
+		return -ENODEV;
+	}
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_FIRMWARE_ID, &firmware_id);
+	if (ret)
+		return ret;
+
+	build = (firmware_id >> FIRMWARE_ID_BUILD_OFFSET) & FIRMWARE_ID_MASK;
+	major = (firmware_id >> FIRMWARE_ID_MAJOR_OFFSET) & FIRMWARE_ID_MASK;
+	minor = (firmware_id >> FIRMWARE_ID_MINOR_OFFSET) & FIRMWARE_ID_MASK;
+	patch = (firmware_id >> FIRMWARE_ID_PATCH_OFFSET) & FIRMWARE_ID_MASK;
+
+	if (major != SUPPORTED_FW_MAJOR) {
+		dev_err(fpga->dev, "Manufacturer ID 0x%02x not supported\n", build);
+
+		return -ENODEV;
+	}
+
+	dev_info(fpga->dev, "Compatible FPGA FW v%u.%u.%u build 0x%02x",
+		 major, minor, patch, build);
+
+	return 0;
+}
+
+static const struct mfd_cell upboard_gpio_led_cells[] = {
+	MFD_CELL_BASIC("leds-gpio", NULL,
+		       &pdata,
+		       sizeof(pdata), 0)
+};
+
+static int upboard_led_gpio_register(struct upboard_fpga *fpga)
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
+		return 0;
+
+	pdata.num_leds = num_leds;
+	pdata.leds = leds;
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
+/*
+ * --------------------------------------       ------------
+ * |    Intel SOC,1.8V                   | --- |ADC Chip   |  native driver
+ * | GPIO/I2C/SPI/UART/PWM               |     |SPI/I2C    |
+ * --------------------------------------      -------------
+ *            |                                     |
+ * ----------------------------------------------------------
+ * |        CPLD/FPGA Driver                                |   upboard-fpga CPLD control driver
+ * |   provide more GPIO driving power                      |   register leds-upboard
+ * |        HAT 40 pin mux function                         |   register pinctrl-upboard
+ * ---------------------------------------------------------
+ *    |                                      |
+ * ----------   -------------------------------------------
+ * |3 or 4|     |    HAT 40 pins, 3.3V                    |   leds-upboard
+ * | Leds |     |GPIO/ADC/I2C/SPI/UART/PWM                |  pinctrl-upboard
+ * ----------   -------------------------------------------
+ */
+static const struct acpi_device_id upboard_fpga_acpi_match[] = {
+	{ "AANT0000", (kernel_ulong_t)&upboard_pinctrl_data },
+	{ "AANT0F00", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ "AANT0F01", (kernel_ulong_t)&upboard_up2_fpga_data },
+	{ "AANT0F02", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ "AANT0F03", (kernel_ulong_t)&upboard_upcore_crst02_fpga_data },
+	{ "AANT0F04", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);
+
+static int __init upboard_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct upboard_fpga *ddata;
+	const struct acpi_device_id *id;
+	const struct upboard_fpga_data *fpga_data;
+	int ret;
+
+	id = acpi_match_device(upboard_fpga_acpi_match, dev);
+	if (!id)
+		return -ENODEV;
+
+	fpga_data = (const struct upboard_fpga_data *) id->driver_data;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ddata);
+	ddata->dev = dev;
+
+	ddata->regmap = devm_regmap_init(dev, NULL, ddata, fpga_data->regmap_config);
+	if (IS_ERR(ddata->regmap))
+		return PTR_ERR(ddata->regmap);
+
+	ddata->regmap_config = fpga_data->regmap_config;
+
+	ret = upboard_fpga_gpio_init(ddata);
+	if (ret) {
+		/* Not FPGA firmware, abort FPGA GPIO initialize process */
+		dev_warn(dev, "Failed to initialize FPGA common GPIOs: %d", ret);
+	} else {
+		upboard_fpga_verify_device(ddata);
+	}
+
+	ret = upboard_led_gpio_register(ddata);
+	if (ret) {
+		/* LEDs are optional. */
+		dev_warn(dev, "Failed to register LEDs: %d", ret);
+	}
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+				    fpga_data->cells,
+				    fpga_data->ncells,
+				    NULL, 0, NULL);
+}
+
+static struct platform_driver upboard_fpga_driver = {
+	.driver = {
+		.name = "upboard-fpga",
+		.acpi_match_table = upboard_fpga_acpi_match,
+	},
+};
+module_platform_driver_probe(upboard_fpga_driver, upboard_fpga_probe);
+
+MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
+MODULE_DESCRIPTION("UP Board CPLD/FPGA driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/upboard-fpga.h b/include/linux/mfd/upboard-fpga.h
new file mode 100644
index 000000000000..d6bf7dd11da8
--- /dev/null
+++ b/include/linux/mfd/upboard-fpga.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UP Board CPLD/FPGA driver
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ *
+ */
+
+#ifndef __MFD_UPBOARD_FPGA_H
+#define __MFD_UPBOARD_FPGA_H
+
+/* CPLD/FPGA protocol version */
+#define UPFPGA_PROTOCOL_V1_HRV		1
+#define UPFPGA_PROTOCOL_V2_HRV		2
+
+#define UPFPGA_ADDRESS_SIZE		7
+#define UPFPGA_REGISTER_SIZE		16
+
+#define UPFPGA_READ_FLAG		BIT(UPFPGA_ADDRESS_SIZE)
+
+enum upboard_fpgareg {
+	UPFPGA_REG_PLATFORM_ID		= 0x10,
+	UPFPGA_REG_FIRMWARE_ID		= 0x11,
+	UPFPGA_REG_FUNC_EN0		= 0x20,
+	UPFPGA_REG_FUNC_EN1		= 0x21,
+	UPFPGA_REG_GPIO_EN0		= 0x30,
+	UPFPGA_REG_GPIO_EN1		= 0x31,
+	UPFPGA_REG_GPIO_EN2		= 0x32,
+	UPFPGA_REG_GPIO_DIR0		= 0x40,
+	UPFPGA_REG_GPIO_DIR1		= 0x41,
+	UPFPGA_REG_GPIO_DIR2		= 0x42,
+	UPFPGA_REG_MAX,
+};
+
+struct upboard_fpga {
+	struct device				*dev;
+	struct regmap				*regmap;
+	const struct regmap_config	*regmap_config;
+	struct gpio_desc			*enable_gpio;
+	struct gpio_desc			*reset_gpio;
+	struct gpio_desc			*clear_gpio;
+	struct gpio_desc			*strobe_gpio;
+	struct gpio_desc			*datain_gpio;
+	struct gpio_desc			*dataout_gpio;
+	bool				uninitialised;
+};
+
+struct upboard_led_data {
+	unsigned int			bit;
+	const char			*colour;
+};
+
+#endif /*  __MFD_UPBOARD_FPGA_H */
-- 
2.17.1

