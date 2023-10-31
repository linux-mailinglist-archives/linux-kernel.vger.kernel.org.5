Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055227DC3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbjJaBvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJaBvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:51:49 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA6DE8;
        Mon, 30 Oct 2023 18:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsi4zm/Ss9UAZbM+QvQ9LCqPJU9Fzeu5pRPWJ+IuLVd/yThqM/eGaCTkA85qp+q/IM2LLeIU5YutgB7oyQaVQwNqU/zuBwD49KS+Fh59G0Ill61ECMDX3FfiazWt532qzQM2sDTTY9bgk9vESSGutRV1PJQJrwPQcgtIU7//1I/JZfFCw625FigYiG4zT+d6dZVpxvF/T6jzF7PCaZg89WyOeTFCEwG5/3X9B6jUFIVwyjOmaSLsyZilrwagp+kVKiK/GAD7g6nxQP3YRG/iPBqoIp4h3Kx151UUrZyU7vG2XpexFj6xo1ye70lvLtm+VhagAhy1zkODcFRg8BDhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM/eNQpgOr+Fxxslh8vIebV3PJ7HIhgPkWnUBRc48BM=;
 b=Lc+lZouqDft3oE6PvxcTgm2pgJm9y5Az8BfJdvLHEsuIpBz6FWg/IKsI12lBpRp5FsFVs3XLMvnpwoPgphspNfJyVw+M8/tm4rfbDAqDuxjOy41Wzl7vEpneffp7TlxMr7b9jFJ6PdMyklaQN8xzw/EazTav4kWIiKPgLd2iG3FjG57JzpNz7XhJFTtV99jOL3XsXWxBYRB6Frpvfng1jWZblW+iSjwMmKJ2eqXnRPLgc23eoACQj8NCM+U5py9Q1rouQUIYN6noKjRdLgDIBnW759PdBn+RbGFQhAt+NNR15uGE0WvPNmsIRZZ4mFDKrCxBoLaW731nFU4cFjx4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by SEZPR06MB6926.apcprd06.prod.outlook.com (2603:1096:101:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 01:51:41 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572%4]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 01:51:41 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>,
        Gary Wang <garywang@aaeon.com.tw>
Subject: [PATCH V7 1/3] mfd: Add support for UP board CPLD/FPGA
Date:   Tue, 31 Oct 2023 09:51:17 +0800
Message-Id: <20231031015119.29756-2-larry.lai@yunjingtech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99ec2792-97ad-4117-4c2e-08dbd9b3ed5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTV9WSqdR8N5OWlE+Rxh17czCEL280Gd/JRmDLMC0QOG0jxb2OoQfWTs+flc30d5HLbar7LPuaDoOanzBeqDzGi6nlkp0RlVW9xeYjBRGYonyt9LXUmfAxO5Qegy+QUFwXU3BRnR2XMRVqGlVLUxHow4BL58wFZjD+Pr873bQ/E4z++tSidQc+k0CcYGbPRUssWRBsblwEIalb2Yg2sZFqE9xIrOJbAtQ202v0vDQJzPSDJwbaPTGBoyVp+jF2L/DuuAyjrY7hGWYDl/b5LuiL0+NJTJgJogpZFKAEDgBSS/HBFn5eQvjTII4W4hNNlXnbfQJ11A2JFuk2rdFIeOcCcSHdX8Ul0/TbshcuEMDDr84jagPc6K55zvyZcheYCbW5yE77Rpkm4ehNfErdrIqZoW7yrwrBtviR49p7qm/sFojzWMSy9QRgTcXc8arSL+obJzxMIg+arYToI5wN9gDFnI4KULCrRMm+yXGKZ4ez1f7Y3SfCPBoa0EAxqetpPNzjGVDMUWNwAvHY3XNoESk99jwh1J/7SWQ+WNI/1eZdeOtJWEZxLlufpT6Z6NxdlsTfA7Xt5cKR3wQ2FoFMa+3PUVOCZ+IwINLwSZJsUEGYOJEHRmexoalMJ+Iff0Kk7ggFUpyBuDte8a08KEWY1deQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39830400003)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799009)(451199024)(30864003)(2906002)(38100700002)(86362001)(8676002)(8936002)(38350700005)(5660300002)(36756003)(41300700001)(4326008)(66946007)(478600001)(6512007)(6666004)(6506007)(52116002)(6486002)(66556008)(66476007)(54906003)(316002)(2616005)(83380400001)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dSNch8eeaYvafpGqeRDqAtflKo/829vqVk3Cyx2l1JA9ftnJOkSURJwuTwFF?=
 =?us-ascii?Q?5wW7UDod7BLmingV9cmw9/sNE7dr3RupwqHVpOnSIHHSawgmUBItZYyhoumu?=
 =?us-ascii?Q?cxCjPvFeiGrWL51iSRwK5jEtm1hCBYNy1BYC7AZxd1izo+olE4+/i6vA6X+A?=
 =?us-ascii?Q?OoIddyUuaoHzvUhBjqf7eOWFQgBr6OUPYMAbJDvMWgYa0xtMQwb7siPZGs8M?=
 =?us-ascii?Q?6nxWCI1BubMEntLiA9T3kuiJ2Rlf74yECcBBXHcS+0w7x32+/EdFK7tV2LGQ?=
 =?us-ascii?Q?EaYZWhpzEt0uhC+jn5640w7tUuBssV3p0RNWF3FOuH04mX9gImi5lNW633Tt?=
 =?us-ascii?Q?Qr85U17+HJ5BQpOvbMFvSpFczNA+R5CHeSoIVP6QPQytHzmAv4FyWGJKNG0P?=
 =?us-ascii?Q?5madijBFCRqMP0xWf6/Mb4ynozrOfpBQGSS0wL7EJa4EfHEqvgBfVUjC8GTs?=
 =?us-ascii?Q?ha9Ihu7mQGelrGtgWszl9Kb4PFFxWOOvXH86A5q0WCP70wMbxqOWCv5oHiRx?=
 =?us-ascii?Q?Ct7Nw1m52dT0O0/m+daap38kcs37I/t7HBsHyme9Wwljgz7AeZkczT40kpKA?=
 =?us-ascii?Q?UQTe8be4iLdWQ9DrePwhAAjPJ7ev4tMfsSGUqzfpxdRveybXtA1MESOuQbEI?=
 =?us-ascii?Q?6T7/zeCUg0NFz8R9qBwulkyu2uMnMhqzTVxN0zFqjpwpCcaMGrM3QxYahVrI?=
 =?us-ascii?Q?5rHxCrEDuUfL09S1l3OoIimcjT2qA02Ft+d6GOQKXTEUSmb99h7EUmm9ZsST?=
 =?us-ascii?Q?DeFWYIt/PkTV/efU7rkxfD3RoXF0nAoerOzgWkm7keVpY4s7oBWCBmdFmlbL?=
 =?us-ascii?Q?xGerCqFZV6UuxUOIwvPBzLEI/uyvWdvQ8eKH49+TOkX5zwZzB4ZW68/culag?=
 =?us-ascii?Q?yYQbP8cHtWHIq9a+cYYVkl5AUsnKsaSvuf56JQQQqqZFAXrwtMvCQoShOT2e?=
 =?us-ascii?Q?zrkZlt2AYm279ExZs/IQiBBPpewqgUQbF/oorBOtHnXV/aP6A+17otJBavx3?=
 =?us-ascii?Q?x5Pt3t1aLZLv9cOduUDOWutPKGAHryeRj88fQl6vtgsCIzxU1MV81Dj6yMLR?=
 =?us-ascii?Q?FX4vhR1tGvCkOVB/kLN+mqEJV9thn6XUvWzuFDGjObnqw36WL0AB/Jts4vV2?=
 =?us-ascii?Q?xmSXboG5uDRmw0L5D9hzd5dmtAV2pW36mMh6iBkOTYcrKpGdFOlHldGeA6/8?=
 =?us-ascii?Q?nZemJHvLvjKt1b5ruCfLOFoKy21T5RXxYT/6EtALGWkozHvi6DZyMZboncoq?=
 =?us-ascii?Q?SI/1X+mPegiAhB+9XqZfmTw89OFZM+eGQ5JDRoKwqLqv/x0gsC2yaTyyH1Cc?=
 =?us-ascii?Q?R4Ab7yL5L1L/4KYHsb+QNtEe6gfXUDQ0UicLH7QkaAdh8JJ1T8xc0Ce+vSAl?=
 =?us-ascii?Q?wRhayUXVpzd3HcAo6aroYOEtk3BRGDKhd9JoCtZRXyhagbeYgTtC7uwDE36j?=
 =?us-ascii?Q?b2J9z+dC04NVMCGFsiihJLuIbc/migrYG/X++OwZZbUl69QKrfLVNkNPlYxw?=
 =?us-ascii?Q?vYA+ekDzgC/EDAG3SC1xuwGzZrRRQhY9BHRjydaEXyIAAF9FBP31lpPNZNi2?=
 =?us-ascii?Q?97WUfnO0an5QiF+eR/MAU1DG+tqPC5S3R4jTyEPpK0ocu38mERjmxn5xXmIs?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ec2792-97ad-4117-4c2e-08dbd9b3ed5f
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 01:51:41.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKnlWO4JFJ6HhwkmNvlGrjZBeZEgg6RZzRMW2eQCS+VUFX+JPPH2NM5SmarrMi5oFAFsLhx/xf1MpujHAI84N9xPd5WYCXqRAJFBYZrcV5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6926
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
PATCH V6 -> PATCH V7
(1) Refer 2023/09/15 Lee Jones review, cleaned up coding style
and addressed review comments.
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
 drivers/mfd/upboard-fpga.c       | 404 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  62 +++++
 4 files changed, 479 insertions(+)
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
index 000000000000..c40d35ace24e
--- /dev/null
+++ b/drivers/mfd/upboard-fpga.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board control CPLD/FPGA to provide more GPIO driving power
+ * also provide CPLD LEDs and pin mux function
+ * recognize HID AANT0F00 ~ AAANT0F04 in ACPI name space
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
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
+static int upboard_cpld_read(void *context, unsigned int reg, unsigned int *val)
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
+static int upboard_cpld_write(void *context, unsigned int reg, unsigned int val)
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
+	.reg_read = upboard_cpld_read,
+	.reg_write = upboard_cpld_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_NONE,
+	.rd_table = &upboard_up_readable_table,
+	.wr_table = &upboard_up_writable_table,
+};
+
+static struct upboard_led_data upboard_gpio_led_data[] = {
+	{ .bit = 0, .colour = "gpio" },
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
+		       sizeof(*upboard_up_led_data), 0),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[1],
+		       sizeof(*upboard_up_led_data), 1),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[2],
+		       sizeof(*upboard_up_led_data), 2),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_gpio_led_data[0],
+		       sizeof(*upboard_gpio_led_data), 0),
+};
+
+/* UP Squared 6000 EHL board */
+static const struct mfd_cell upboard_pinctrl_cells[] = {
+	MFD_CELL_BASIC("upboard-pinctrl", NULL, &upboard_gpio_led_data[0],
+		       sizeof(*upboard_up_led_data), 0),
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
+	.reg_read = upboard_cpld_read,
+	.reg_write = upboard_cpld_write,
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
+		       sizeof(*upboard_up2_led_data), 0),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[1],
+		       sizeof(*upboard_up2_led_data), 1),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[2],
+		       sizeof(*upboard_up2_led_data), 2),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[3],
+		       sizeof(*upboard_up2_led_data), 3),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_gpio_led_data[0],
+		       sizeof(*upboard_gpio_led_data), 0),
+};
+
+static int __init upboard_cpld_gpio_init(struct upboard_fpga *fpga)
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
+/* This function is for debugging with user for showing firmware information. */
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
+static const struct acpi_device_id upboard_fpga_acpi_match[] = {
+	{ "AANT0000", AANT0000_ID },
+	{ "AANT0F00", AANT0F00_ID },
+	{ "AANT0F01", AANT0F01_ID },
+	{ "AANT0F02", AANT0F02_ID },
+	{ "AANT0F03", AANT0F03_ID },
+	{ "AANT0F04", AANT0F04_ID },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);
+
+static int __init upboard_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct upboard_fpga *ddata;
+	const struct acpi_device_id *id;
+	static const struct regmap_config *cpld_config;
+	static const struct mfd_cell *cells;
+	static size_t ncells;
+	int ret;
+
+	id = acpi_match_device(upboard_fpga_acpi_match, dev);
+	if (!id)
+		return -ENODEV;
+
+	switch (id->driver_data) {
+	case AANT0F00_ID:
+		cpld_config = &upboard_up_regmap_config;
+		cells = upboard_up_mfd_cells;
+		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
+		break;
+	case AANT0F01_ID:
+		cpld_config = &upboard_up2_regmap_config;
+		cells = upboard_up2_mfd_cells;
+		ncells = ARRAY_SIZE(upboard_up2_mfd_cells);
+		break;
+	case AANT0F02_ID:
+		cpld_config = &upboard_up_regmap_config;
+		cells = upboard_up_mfd_cells;
+		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
+		break;
+	case AANT0F03_ID:
+		cpld_config = &upboard_up2_regmap_config;
+		cells = upboard_up_mfd_cells;
+		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
+		break;
+	case AANT0F04_ID:
+		cpld_config = &upboard_up_regmap_config;
+		cells = upboard_up_mfd_cells;
+		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
+		break;
+	case AANT0000_ID:
+	default:
+		cpld_config = &upboard_up_regmap_config;
+		cells = upboard_pinctrl_cells;
+		ncells = ARRAY_SIZE(upboard_pinctrl_cells);
+		break;
+	}
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ddata);
+	ddata->dev = dev;
+	ddata->regmap = devm_regmap_init(dev, NULL, ddata, cpld_config);
+	if (IS_ERR(ddata->regmap))
+		return PTR_ERR(ddata->regmap);
+
+	ret = upboard_cpld_gpio_init(ddata);
+	if (ret) {
+		/* Not FPGA firmware, abort FPGA GPIO initialize process */
+		dev_warn(dev, "Failed to initialize CPLD common GPIOs: %d", ret);
+	} else {
+		upboard_fpga_verify_device(ddata);
+	}
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+				    cells,
+				    ncells,
+				    NULL, 0, NULL);
+}
+
+static struct platform_driver upboard_fpga_driver = {
+	.driver = {
+		.name = "upboard-cpld",
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
index 000000000000..6e7aa3c9cd24
--- /dev/null
+++ b/include/linux/mfd/upboard-fpga.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UP Board CPLD/FPGA driver
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ */
+
+#ifndef __MFD_UPBOARD_FPGA_H
+#define __MFD_UPBOARD_FPGA_H
+
+/* CPLD/FPGA protocol version */
+#define UPFPGA_PROTOCOL_V1_HRV	1
+#define UPFPGA_PROTOCOL_V2_HRV	2
+
+#define UPFPGA_ADDRESS_SIZE	7
+#define UPFPGA_REGISTER_SIZE	16
+
+#define UPFPGA_READ_FLAG	BIT(UPFPGA_ADDRESS_SIZE)
+
+enum upcpld_ids {
+	AANT0000_ID		= 255,
+	AANT0F00_ID		= 0,
+	AANT0F01_ID		= 1,
+	AANT0F02_ID		= 2,
+	AANT0F03_ID		= 3,
+	AANT0F04_ID		= 4,
+};
+
+enum upboard_fpgareg {
+	UPFPGA_REG_PLATFORM_ID	= 0x10,
+	UPFPGA_REG_FIRMWARE_ID	= 0x11,
+	UPFPGA_REG_FUNC_EN0	= 0x20,
+	UPFPGA_REG_FUNC_EN1	= 0x21,
+	UPFPGA_REG_GPIO_EN0	= 0x30,
+	UPFPGA_REG_GPIO_EN1	= 0x31,
+	UPFPGA_REG_GPIO_EN2	= 0x32,
+	UPFPGA_REG_GPIO_DIR0	= 0x40,
+	UPFPGA_REG_GPIO_DIR1	= 0x41,
+	UPFPGA_REG_GPIO_DIR2	= 0x42,
+	UPFPGA_REG_MAX,
+};
+
+struct upboard_fpga {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct gpio_desc	*enable_gpio;
+	struct gpio_desc	*reset_gpio;
+	struct gpio_desc	*clear_gpio;
+	struct gpio_desc	*strobe_gpio;
+	struct gpio_desc	*datain_gpio;
+	struct gpio_desc	*dataout_gpio;
+	bool			uninitialised;
+};
+
+struct upboard_led_data {
+	unsigned int		bit;
+	const char		*colour;
+};
+
+#endif /*  __MFD_UPBOARD_FPGA_H */
-- 
2.17.1

