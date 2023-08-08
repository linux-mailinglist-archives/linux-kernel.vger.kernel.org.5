Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8EC773FF6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjHHQ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjHHQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:56:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3920A5FF4;
        Tue,  8 Aug 2023 09:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8ppX1Wfv5UO2MpLbcn+40ldYLj7XHDTIYbqSvCkP1uu1b1ySz82Is0UoLv8hNZFD0kRJu+QfwFt9Twp0kmNpSUvvfYD9+9uSalxfSyD1fFhidLUx/P0oQFY6COuHFz3ZY+S0IUrA+DhXGJePoarlcmSl0CgGp74+bYBEJifo5Ej+hULf22z7kKeS6T0OcJIYUk2W9wMGQbYBJri2SsoR8msqC2fyB1y4DGKKu6OQlCVgbONy6x4NYEI8+oggQh/PxWKWcxhKAJ34rc5TcEnWSuYaloUAm7J69aZ4XzBxRqtCbNHjGtoBuchi/nH3DsooI6l825UtD81b0T951L9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjdYfwlcd+Ck0oUiw1WBvfrp6aszp8jfZYqlsSGCu8g=;
 b=G1ZZdlY90NaXRwN+kL4Cht+CNc2ZGhBJt0/81zUGovlcpekuud/15xDZQ+mOxF3J4IJ15PhOpXGlrghvHS6aqWwRxG6Y9f5r7gKiqy/70OuqyMSUIoybDqJBFoMeVf66PyBfWM0aEogtUabvDaiIU/5x4hZrNCdt0Yhrbnug4rDe/4TGeO7RNIxvi8fsKKH4C+enxlTfAzpJZ9pAJprw0JvvbrMTKIPjlfJUPBTi6n3QALM9Y6jjSOKxvLof7EXC0GMGhQiXWUvg/hQ6DXqAPit7Cu/Q4Ds26ho7Eekj9NYuG2vsms4y0CJJO0GkcIY53j8V5P8X8H0YaYlrBJRZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by KL1PR06MB6323.apcprd06.prod.outlook.com (2603:1096:820:e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:56:53 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:56:53 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, michael.wang@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>,
        Gary Wang <garywang@aaeon.com.tw>
Subject: [PATCH V5 1/3] mfd: Add support for UP board CPLD/FPGA
Date:   Tue,  8 Aug 2023 22:55:59 +0800
Message-Id: <20230808145601.9401-2-larry.lai@yunjingtech.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf6055ef-f24f-4fc3-b58d-08db981fb3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aO5Ey+IWT89+79aB2QP0HVNV6MEJgZ+genSB4RX170xkzIIIcpSj+ZGaUa84h7AUGEPWbhAue12r9XhT5RNzgZAzHgdHEcXBqBBbXkhtGH4nKPQYDcCabga6X0quZIoeIWR//CT/epKbRzdKqH+sI5bB0Y8Q2qgy/NLOY/pNi0izcheub4S3M4uzv9/ZtejCKwNgEYx/2sggwXyaI412Is09EuY5MY/LDJPxK3sUlVpWHQhdDKl9ny068os/IREyf7TdtP5Cf6POl/W8qpFY/BI4FoqNeAL67WnXUzfQ4/6z1vctjMCzGfPXD9v7wuPNmsQMFdABIhTC4r/F8ovi83llO1D/S9e3Aym10Q/hzglFHnyVj/7Rdu3+7RXaf1vQBPopcPTI2S3mFuOSzKcTRDJn5WaLNmRiQQ0nPteB/apyctcrCNEa/mbU3INugGe4mKLfPGTX7UAuI7qnJ1LtA/4DrAPJslmTN0/VSLTbvm58HRmjUDuG0CLRd32LLkeUBP+cyAORBDRklEC0jk3GCO5AEAlm4gmAZhAgoAEnNZSnZHPXbFid568H7TnpSQwMwBcut0nQimdtOeewxAI2BIwC2kTlSmlnEwi0GuyaQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(346002)(39830400003)(451199021)(186006)(1800799003)(2616005)(36756003)(4326008)(6512007)(316002)(478600001)(38100700002)(54906003)(52116002)(38350700002)(66946007)(86362001)(66556008)(66476007)(6486002)(6506007)(1076003)(26005)(8676002)(8936002)(41300700001)(2906002)(83380400001)(30864003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WSnIwAMpEt4SF1tRA99p3vx5EwSNJnpgpusMDQDuXjWIIXUFzfBz8/WoanJo?=
 =?us-ascii?Q?CxrMT89CRhlUoYENo2/NCXCCk9qJP6ZtA0oDJqTqe4fS92rQ/TX6pALi0xJJ?=
 =?us-ascii?Q?jufUScT5CDFjmv3PZDEIbt7Uw/T22LiBsKG2jrfbZLWlrBap9hZEA8LFu/l5?=
 =?us-ascii?Q?imH2QjuqrZmmkHRCpCEWVN0d9g20uGeatVzhCjtou6LELw2vbiJw/NmeqyGN?=
 =?us-ascii?Q?6GvJMqN5NZWQG9bdATHex9RvgSrqSyuRWNp7TucPOu/UlDjgA9zCK5kU+UFR?=
 =?us-ascii?Q?HiO9/50YFTsz1V312QrT7xlc8IgTzVBNlOywTV8zTxt0D2cEmE5G4HTPpeRp?=
 =?us-ascii?Q?VzafrWDm10/sC8ealKm9ZtSuae8l8MXRWWWmczXUljI/ARYVF/H5eYT7KuGZ?=
 =?us-ascii?Q?QVpRgP+JSMpQVrN3oNRAwYRbD8O62buX8s/jOe7lZN2dIjYcQ+eAzDpzJ35D?=
 =?us-ascii?Q?oXCVl0z/bX+8/LQSZMLUxYMjZIsKvUEfOv+wD9eNM6WfYMrKTNhvCTkjjiSx?=
 =?us-ascii?Q?vxMWHp6je8feqH8h6y8+iZdYh1bZzahIGdyfWczI391uGUbEGflkaFTBzI8l?=
 =?us-ascii?Q?FQzij5EsWzJ6RVbxUt97WNEOCEfrhkQGAITggLpyLtdVlCfgEk63XH34KeAR?=
 =?us-ascii?Q?7KIjHwueeZVGfxNwO/GCli4clRAVm+oGgg47uQlTqvoeQjGXmUFdhtpC35sT?=
 =?us-ascii?Q?cHUV0U44f3N34eIB6+T3JcIq3q16QyS4O8Dis7YibLNa0RpgydVg7HKJq8nM?=
 =?us-ascii?Q?RkwlYSTb2ySG4uVCYofCOCyyb5hU/bWh9Y+AOMmnFAmj+MdMluGgsowQEMnA?=
 =?us-ascii?Q?2Z0xXXc5NnQnnEBu0zPeVuCNfYnPRsZtqWFOKjzY0By2f2EP5NHl7P83vMPr?=
 =?us-ascii?Q?fcwCs/co85urjXRNCrDL/MVfek3W+MhYRdxiejHXJYn5MqH0kgabsPnzzFk6?=
 =?us-ascii?Q?o5m5zZ5Ot6LSfIAjqjbyZyj+bsYIviUy7Qs1w1oLuPqKp1VdJ81x6hyJBBJW?=
 =?us-ascii?Q?YTblxsc2/xR2eaSuDIiWZDJeZGhelxE/gLBbxw5JdlDA42YuQD1dUYmP4RUS?=
 =?us-ascii?Q?SQlwwku65UmPiLti4z4hNQxeo8xtfax3KYyvCNuTgWx/Dls+kI+pkdHOjZJc?=
 =?us-ascii?Q?555+IlXKyltoI37f2w1QolpPMBmxYQZiDyt5gQoPDuW1wGnAZQBD75HHTaEq?=
 =?us-ascii?Q?m0FcZyv/2lOjUCG6E5rn84j5Fv4Qx51W+m4Nn/R0qSK/qgVTjxYsQZFYQDUe?=
 =?us-ascii?Q?CrU4RrlmoGJK8CMly9sOceKXmvNxvLeC63s0fccdH2XOhY6opvoWF3zAaV5U?=
 =?us-ascii?Q?1ruxcuxcIl9GB7QQJXmy7eAAnTyeHBihw26t4xYv+V2Plk+uIVps3mwUTCWP?=
 =?us-ascii?Q?o9rQMhdtyYq+ytBCDz9V0Eu5P+1W/YkOm6gn8qlpQWl33mQ4Gt7p4ZunZGNF?=
 =?us-ascii?Q?uWQr2ufBud4ealCpKkKF91+NqndFgISxjB4R3KBlkVAgHbFoAOOUeFM5S6Gy?=
 =?us-ascii?Q?/gsnQ8XqUToANML4X2IQdzZVo/vxpWDlZi4fK8tYN387l6IE8y/outBx2UQ7?=
 =?us-ascii?Q?SlKxSNFjmL2faIjcVTwD2s50ViZiMeZH4aPRRtS5lOVgD7Vwxkme6OhDhKD+?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6055ef-f24f-4fc3-b58d-08db981fb3e2
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:56:53.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6Y7SIGlEOlJ0ZQb3Z+zFhTU8pw/Gneu9AnqF82AZ9ci4LOBsFJ0DJCgjVcZ4m9lY3UQglEqkzEM4zKHuC0ko4/4P1a8UvjBsrRzWTZ0i64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 000000000000..5db9be871a51
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
index 000000000000..f7f46b4e8887
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
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct regmap_config		*regmap_config;
+	struct gpio_desc		*enable_gpio;
+	struct gpio_desc		*reset_gpio;
+	struct gpio_desc		*clear_gpio;
+	struct gpio_desc		*strobe_gpio;
+	struct gpio_desc		*datain_gpio;
+	struct gpio_desc		*dataout_gpio;
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

