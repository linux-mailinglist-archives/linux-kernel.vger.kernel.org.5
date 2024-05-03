Return-Path: <linux-kernel+bounces-167651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058DA8BACC5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3771C21345
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6036153592;
	Fri,  3 May 2024 12:48:57 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0F139CE0;
	Fri,  3 May 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740535; cv=fail; b=oy8thwR2lbiecT5+TnU2rK7Y7VkQncCPScGOQgFPmmfHwEvV/a7zxnoQSTA3LjzhRzILHekJI+jcRHgWUfBKWXSWZ4RrH0LzxpAGrO3OA2HtF67lieeBfvwNk6ClZ1ykmaEcYRg/CICP3D7u2z+kyyJ4UfnZPtL+sDYGQQp5TGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740535; c=relaxed/simple;
	bh=RVvTspYhIcN86g2PKVAdE++YimNgJ1InhEo0JKgf/0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glQaTdTYSSl3KjtJ4DOQ7NkRNsWd38ZkRXzYBgDwPnkOzCNQ//sfH9SE8j82SNgQNzB6OInn7tEdodlFG2MgVGrWnQRXf4/Z8oxJp9CY4L2wd5k/VjobyWX0XUjK3TzZw+h+iIOnxRFLWlfztWvr5s7k/qhnBqaYU4sxignHReQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaMA5oLHEn8AUhqn6l8zgjHPvL4HEWDbOMh5qKICfKhusMbCxGLFAEBczGXWLkg3GJZw5SF6W/g85m7KBnFHy6ffxF8uvDOw2hRtVACfRqQxnD211GOQuTUSfOjIjuesdOH7XkZCrT16lFRKZMrz3r8tPOOHtuvqBfSfJVIdwNEcl1Li2TiYkfnmJmUJLG1FpT54dUC97UdgI4Q7lkEWiMg2ccx7/xjRmae5I5WuwUXEFmIM1YPxayWmyj2bzuYSDfJFSUp6GuBCyRKUvHoVpNTtityRRCQPOv3+v6YCfZB17Tu5G3DMxODiECbcx1KQesd3FouCghxpTg5F1kb+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDdCVsDCb/VueupHtMM8rDUA+vzCW0UtHbAaJOIf6VY=;
 b=QKS2v848HrJRAXM6Fm4nrfG1lQo6/4ptYCzITUfQMGoDw3+G+x90oti8K9p/K6ezldCI9E4mLQe1cj4sXRXCrdkMTQlAtOuWkWFbGIaMsCU+Ke4ARC+6xdB2/NatxRl6c8+N3NU0J6/uoqtWPx8XDaci5nPSzS5AG7w3DkEffyW+HzpBGiFu8vWcIoerLO+sITjmYn3SwiT29TGNNkXHxPHX4OG3JC+cV3YpSkbAPzKoWVYS/NE4sNKI5fy9jCH8fPTaMyUX3tinFAhxZaMN03AAipf6Y3VhQSgEVX+dbdMlEI0LNgKbKsIMlUaxbLjcbW0w1UOmamrzYBmQaSbNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) by ZQ0PR01MB1238.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 3 May
 2024 11:14:53 +0000
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 ([fe80::feb4:a4b4:1132:58f4]) by
 ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn ([fe80::feb4:a4b4:1132:58f4%5])
 with mapi id 15.20.7472.044; Fri, 3 May 2024 11:14:53 +0000
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH v3 2/7] pinctrl: starfive: jh8100: add main driver and sys_east domain sub-driver
Date: Fri,  3 May 2024 19:14:31 +0800
Message-Id: <20240503111436.113089-3-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
References: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::20) To ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1176:EE_|ZQ0PR01MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: aec45f71-2f6e-47c9-e0e7-08dc6b624166
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lgFP9C2Znwsl25f2b7eY18mYHoT5G/TB8r/u8ixqFZpqHEfQ11fAG0W31sL+E6Y22EsctfJmlcCqHIcbWqqjpfMryo/6X/jLsHFD0NzKvNI/Roue5Z307IwjHEvq8C984vWLkN0r3QNgAGZGKmaFgrlWm1YEKZs46cwhibKzR1w/63Ba6dbkpOtBIN1UrlpfHy9awSeQW/kL1iYeDNsq6UCBPo+e+4zXdnnC00Nq5bCH3kUDAvVINEyoOczEU6TRwvtDDeQBpBUZxWw0DSzExpdQ5lnRVnrHaWOkdp854q32ujwQPtJTEYkqQmCDzEy1cMKbVuzR2yq3sH6Psm8fKDOqpBPEJOpTkf1hjdBwEv6UuCd6CCK7sO4pQgWrIovFZo6e/CbYHY6W27scm2YUv5LAot4B+0onbHNUXz4nc+IpM/lv5GBF5uuStLVMLe/hvi5skx93FIPkdF++7lWfLxmub8YFH5MhVfp/6pplXoMHkSf8RCXzfl+WzqESdf1Ngc7SMWeKqLqSsVjSjEz1eP1EvkoOdud6RZIhsqEMvFG6DrRH6lTuVexbEN4n1VhCwCsPLGdlT64ZwCrp/FF3sC173RPM5ByjyJnNlm0Lzg2dIr38khIYHPZbqNpNFGnv+y/dO1sFyFAujc3pEU0MsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(41320700004)(7416005)(366007)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4S9Zby6l9uw05im4PUnOkZ8iBGN7rY3SaWlQjFJl1BFw6ZpCoLoCKy8XOhoA?=
 =?us-ascii?Q?j+tX3r0youbR+J/ZTz60+m7fbZ/2Mb+M7jDvneLWjxyv9eZRvKZ3fsxv8ncj?=
 =?us-ascii?Q?Bn9rmBPb9biUiD44LbHQ9fdWmvNir7YNqPTFTl0TCmYEQgtfb9Xe7FYcsmEd?=
 =?us-ascii?Q?WLI7ZkGfs6ndE5xpKxv1i1+KuBQy3Pl89n5Wg6UAY6e2EGuTG3oJZMXylBKW?=
 =?us-ascii?Q?b/63capXcW85taX2itvWjHT02eysinsLxTqOlTNzjwbiQqcHoOXaw+D+ShqJ?=
 =?us-ascii?Q?Oz9gMF27Zqms92ZEyt9l3WGcAUiOYQJjfPsjvFUjl+rOFCVppLxgE6ODrpyN?=
 =?us-ascii?Q?vqtJj86CPP4sgQvHHyLpADsWoYhxxV5uLBqt3MEY4+T+OaNEpVb7kg5XfrjA?=
 =?us-ascii?Q?jVTawaAGBWftLWeZ3AhdrNcpTHcNg21ma61nk7wr7MZjUFzwR7aSBpDt88PC?=
 =?us-ascii?Q?vm/OVxUxNciPaCGvdiOXvPLaFlU5TSpQ2K1q0vppE04+6Fze4nCdYYTVKBdP?=
 =?us-ascii?Q?eZGOSip/TFw/RO8iGzDnhch6dWcfhC0TWEryKCYdTXbYrYkZYZM3puTac+QR?=
 =?us-ascii?Q?h7HJhIc8t0QAOKKj1CJ3uIIn8xtaVbXqFq1UanG+w0yUerLRin2LCmbT5qDI?=
 =?us-ascii?Q?j0ApMzMQ/ZxI2/Dy/zoTnjPipaiHQMkA4SXdoIwsNXORh7atduDf8p3M3ePF?=
 =?us-ascii?Q?xSBjFt+xbdIFDx3pNBwgF/yluNRxkaEmNoSjB0Cx1J7CvK7SnT2q4U8el0FI?=
 =?us-ascii?Q?5VbJoRdO4QplCrliuG7mG7C+8eQWcmfsABL0NaJkW0sZ15mPJtdpju17fv/r?=
 =?us-ascii?Q?wUwTWaTo5BApyBmW6BFkg5WaqOoxl7t1MD8GTjpkJ5ZC+MzMJXm8SOOsb/03?=
 =?us-ascii?Q?M+L2YC/CYMcBgM2vDr5/kB1Yhqpk5HW4nNQhVVp8OO1UNc4WHqMszKUEQT2u?=
 =?us-ascii?Q?z6C9178iz5DVJH1u/WC9L2R8OoCsUj7sFa4+2ZTVk/n0gG4Mxn7DY5BzmvoO?=
 =?us-ascii?Q?dCgsiTdoymKwMc5Q34h0oVV5YVWgogyP3sVO6Tzd8IsIgvLDSQ3z8P50giNr?=
 =?us-ascii?Q?D96wiNSWLpFC4ZFcHnDQDyS1lU0+s6r7l8Aq2seZeLSb2dRDQN4+KROH68G9?=
 =?us-ascii?Q?9FRAyE6iDoJR/bxLCsqcTEfLjrFfs53HqGFfz17TB018cKARjClNX+nluIa4?=
 =?us-ascii?Q?AwbENiBAAEbVk4hlqPUxWs6uL0M9iMmhoLoh4SQjWCKr5gXePhXLPLe6EcTn?=
 =?us-ascii?Q?PrQbMXhP+5s/XRqVUfNV971WAhMHvnHoOfGQaIq9R2lqihTQcX/3kZBgucwA?=
 =?us-ascii?Q?JmNjEdcrGRHlmldIjpeh/PiuOgh5S48whjuSqTdF6LF+3O+4w532MZOts5CT?=
 =?us-ascii?Q?j36E+k2f63ggF3xRQ4jh280r5ThSZyGJoU9+uLCkOzh5AWKR7vjCh9UhQBVw?=
 =?us-ascii?Q?6CpTi2y1nRGFrQSOfP3DJLiQCYJJ8sHpSh7YyUWKfPY4uVpcNTTcljoddUXq?=
 =?us-ascii?Q?NimioWbmpBKvbBSDjWDpgAVYuHhvKKX9UqyEHRxNIjRpdX7pOznZb7gFqJSl?=
 =?us-ascii?Q?RvYRYEOu8TsOo+nPX6vpzyLZs7uleIajnPPqDcAQwNqQ6KLedUGY8E1oOECI?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec45f71-2f6e-47c9-e0e7-08dc6b624166
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:14:52.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sf1WVLkKkXrhic+QPIm0xKjcIrXiN7yZ7Vuwne0FB8F2qfueqAgkTSUbCCAlOGBxDZJHwXi1jq6A5ZSVmBKyaMuENimHPRiRTo+7ra+uOhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1238

Add Starfive JH8100 SoC pinctrl main driver to provide the
common APIs that are used by the sub-drivers of pinctrl
domains:
- sys_east,
- sys_west,
- sys_gmac,
- aon (always-on)

to implement the following tasks:

- applies pin multiplexing, function selection, and pin
  configuration for devices during system initialization
  or change of pinctrl state due to power management.
- read or set pin configuration from user space.

Also, add the sys_east domain sub-driver since it requires
at least one domain sub-driver to run the probe function in
the main driver to enable the basic pinctrl functionalities
on the system.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 drivers/pinctrl/starfive/Kconfig              |   21 +
 drivers/pinctrl/starfive/Makefile             |    3 +
 .../pinctrl-starfive-jh8100-sys-east.c        |  220 ++++
 .../starfive/pinctrl-starfive-jh8100.c        | 1094 +++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |  111 ++
 5 files changed, 1449 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-east.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h

diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
index 8192ac2087fc..afcbf9d4dc8d 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -49,3 +49,24 @@ config PINCTRL_STARFIVE_JH7110_AON
 	  This also provides an interface to the GPIO pins not used by other
 	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
 	  and interrupts on input changes.
+
+config PINCTRL_STARFIVE_JH8100
+	bool
+	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select OF_GPIO
+
+config PINCTRL_STARFIVE_JH8100_SYS_EAST
+	tristate "StarFive JH8100 SoC System IOMUX-East pinctrl and GPIO driver"
+	depends on ARCH_STARFIVE  || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE_JH8100
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support system iomux-east pin control on the StarFive JH8100 SoC.
+	  This also provides an interface to the GPIO pins not used by other
+	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
+	  and interrupts on input changes.
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive/Makefile
index ee0d32d085cb..45698c502b48 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -5,3 +5,6 @@ obj-$(CONFIG_PINCTRL_STARFIVE_JH7100)	+= pinctrl-starfive-jh7100.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH7110)		+= pinctrl-starfive-jh7110.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH7110_SYS)	+= pinctrl-starfive-jh7110-sys.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH7110_AON)	+= pinctrl-starfive-jh7110-aon.o
+
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100)		+= pinctrl-starfive-jh8100.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_EAST)	+= pinctrl-starfive-jh8100-sys-east.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-east.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-east.c
new file mode 100644
index 000000000000..45ade4d68d66
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-east.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC sys east controller
+ *
+ * Copyright (C) 2023-2024 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+#include "pinctrl-starfive-jh8100.h"
+
+#define JH8100_SYS_E_GC_BASE			16
+
+/* registers */
+#define JH8100_SYS_E_DOEN			0x000
+#define JH8100_SYS_E_DOUT			0x030
+#define JH8100_SYS_E_GPI			0x060
+#define JH8100_SYS_E_GPIOIN			0x0f4
+
+#define JH8100_SYS_E_GPIOEN			0x0b8
+#define JH8100_SYS_E_GPIOIS0			0x0bc
+#define JH8100_SYS_E_GPIOIS1			0x0c0
+#define JH8100_SYS_E_GPIOIC0			0x0c4
+#define JH8100_SYS_E_GPIOIC1			0x0c8
+#define JH8100_SYS_E_GPIOIBE0			0x0cc
+#define JH8100_SYS_E_GPIOIBE1			0x0d0
+#define JH8100_SYS_E_GPIOIEV0			0x0d4
+#define JH8100_SYS_E_GPIOIEV1			0x0d8
+#define JH8100_SYS_E_GPIOIE0			0x0dc
+#define JH8100_SYS_E_GPIOIE1			0x0e0
+#define JH8100_SYS_E_GPIORIS0			0x0e4
+#define JH8100_SYS_E_GPIORIS1			0x0e8
+#define JH8100_SYS_E_GPIOMIS0			0x0ec
+#define JH8100_SYS_E_GPIOMIS1			0x0f0
+
+static const struct pinctrl_pin_desc jh8100_sys_e_pins[] = {
+	PINCTRL_PIN(0,	"SYS_E_GPIO0"),
+	PINCTRL_PIN(1,	"SYS_E_GPIO1"),
+	PINCTRL_PIN(2,	"SYS_E_GPIO2"),
+	PINCTRL_PIN(3,	"SYS_E_GPIO3"),
+	PINCTRL_PIN(4,	"SYS_E_GPIO4"),
+	PINCTRL_PIN(5,	"SYS_E_GPIO5"),
+	PINCTRL_PIN(6,	"SYS_E_GPIO6"),
+	PINCTRL_PIN(7,	"SYS_E_GPIO7"),
+	PINCTRL_PIN(8,	"SYS_E_GPIO8"),
+	PINCTRL_PIN(9,	"SYS_E_GPIO9"),
+	PINCTRL_PIN(10,	"SYS_E_GPIO10"),
+	PINCTRL_PIN(11,	"SYS_E_GPIO11"),
+	PINCTRL_PIN(12,	"SYS_E_GPIO12"),
+	PINCTRL_PIN(13,	"SYS_E_GPIO13"),
+	PINCTRL_PIN(14,	"SYS_E_GPIO14"),
+	PINCTRL_PIN(15,	"SYS_E_GPIO15"),
+	PINCTRL_PIN(16,	"SYS_E_GPIO16"),
+	PINCTRL_PIN(17,	"SYS_E_GPIO17"),
+	PINCTRL_PIN(18,	"SYS_E_GPIO18"),
+	PINCTRL_PIN(19,	"SYS_E_GPIO19"),
+	PINCTRL_PIN(20,	"SYS_E_GPIO20"),
+	PINCTRL_PIN(21,	"SYS_E_GPIO21"),
+	PINCTRL_PIN(22,	"SYS_E_GPIO22"),
+	PINCTRL_PIN(23,	"SYS_E_GPIO23"),
+	PINCTRL_PIN(24,	"SYS_E_GPIO24"),
+	PINCTRL_PIN(25,	"SYS_E_GPIO25"),
+	PINCTRL_PIN(26,	"SYS_E_GPIO26"),
+	PINCTRL_PIN(27,	"SYS_E_GPIO27"),
+	PINCTRL_PIN(28,	"SYS_E_GPIO28"),
+	PINCTRL_PIN(29,	"SYS_E_GPIO29"),
+	PINCTRL_PIN(30,	"SYS_E_GPIO30"),
+	PINCTRL_PIN(31,	"SYS_E_GPIO31"),
+	PINCTRL_PIN(32,	"SYS_E_GPIO32"),
+	PINCTRL_PIN(33,	"SYS_E_GPIO33"),
+	PINCTRL_PIN(34,	"SYS_E_GPIO34"),
+	PINCTRL_PIN(35,	"SYS_E_GPIO35"),
+	PINCTRL_PIN(36,	"SYS_E_GPIO36"),
+	PINCTRL_PIN(37,	"SYS_E_GPIO37"),
+	PINCTRL_PIN(38,	"SYS_E_GPIO38"),
+	PINCTRL_PIN(39,	"SYS_E_GPIO39"),
+	PINCTRL_PIN(40,	"SYS_E_GPIO40"),
+	PINCTRL_PIN(41,	"SYS_E_GPIO41"),
+	PINCTRL_PIN(42,	"SYS_E_GPIO42"),
+	PINCTRL_PIN(43,	"SYS_E_GPIO43"),
+	PINCTRL_PIN(44,	"SYS_E_GPIO44"),
+	PINCTRL_PIN(45,	"SYS_E_GPIO45"),
+	PINCTRL_PIN(46,	"SYS_E_GPIO46"),
+	PINCTRL_PIN(47,	"SYS_E_GPIO47"),
+};
+
+static const struct jh8100_gpio_func_sel
+	jh8100_sys_e_func_sel[ARRAY_SIZE(jh8100_sys_e_pins)] = {
+	[20]    = { 0x1d4,  0, 2 },
+	[21]    = { 0x1d4,  2, 2 },
+	[22]    = { 0x1d4,  4, 2 },
+	[23]    = { 0x1d4,  6, 2 },
+	[24]    = { 0x1d4,  8, 2 },
+	[25]    = { 0x1d4, 10, 2 },
+	[26]    = { 0x1d4, 12, 2 },
+	[27]    = { 0x1d4, 14, 2 },
+	[28]    = { 0x1d4, 16, 2 },
+	[29]    = { 0x1d4, 18, 2 },
+	[30]    = { 0x1d4, 20, 2 },
+	[31]    = { 0x1d4, 22, 2 },
+	[32]    = { 0x1d4, 24, 2 },
+	[33]    = { 0x1d4, 26, 2 },
+	[34]    = { 0x1d4, 28, 2 },
+	[35]    = { 0x1d4, 30, 2 },
+
+	[36]    = { 0x1d8,  0, 2 },
+	[37]    = { 0x1d8,  2, 2 },
+	[38]    = { 0x1d8,  4, 2 },
+	[39]    = { 0x1d8,  6, 2 },
+	[40]    = { 0x1d8,  8, 2 },
+	[41]    = { 0x1d8, 10, 2 },
+	[42]    = { 0x1d8, 12, 2 },
+	[43]    = { 0x1d8, 14, 2 },
+	[44]    = { 0x1d8, 16, 2 },
+	[45]    = { 0x1d8, 18, 2 },
+	[46]    = { 0x1d8, 20, 2 },
+	[47]    = { 0x1d8, 22, 2 },
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_sys_e_pinctrl_suspend(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		sfp->jh8100_sys_east_regs[i] = readl_relaxed(sfp->base + (i * 4));
+
+	return pinctrl_force_sleep(sfp->pctl);
+}
+
+static int jh8100_sys_e_pinctrl_resume(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		writel_relaxed(sfp->jh8100_sys_east_regs[i], sfp->base + (i * 4));
+
+	return pinctrl_force_default(sfp->pctl);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(jh8100_sys_e_pinctrl_dev_pm_ops,
+			 jh8100_sys_e_pinctrl_suspend,
+			 jh8100_sys_e_pinctrl_resume);
+
+static const struct jh8100_gpio_irq_reg jh8100_sys_e_irq_reg = {
+	.is_reg_base	= JH8100_SYS_E_GPIOIS0,
+	.ic_reg_base	= JH8100_SYS_E_GPIOIC0,
+	.ic1_reg_base	= JH8100_SYS_E_GPIOIC1,
+	.ibe_reg_base	= JH8100_SYS_E_GPIOIBE0,
+	.iev_reg_base	= JH8100_SYS_E_GPIOIEV0,
+	.ie_reg_base	= JH8100_SYS_E_GPIOIE0,
+	.ris_reg_base	= JH8100_SYS_E_GPIORIS0,
+	.mis_reg_base	= JH8100_SYS_E_GPIOMIS0,
+	.mis1_reg_base	= JH8100_SYS_E_GPIOMIS1,
+	.ien_reg_base	= JH8100_SYS_E_GPIOEN,
+};
+
+static const struct jh8100_pinctrl_domain_info jh8100_sys_e_pinctrl_info = {
+	.pins				= jh8100_sys_e_pins,
+	.npins				= ARRAY_SIZE(jh8100_sys_e_pins),
+	.ngpios				= JH8100_SYS_E_NGPIO,
+	.gc_base			= JH8100_SYS_E_GC_BASE,
+	.name				= JH8100_SYS_E_DOMAIN_NAME,
+	.nregs				= JH8100_SYS_E_REG_NUM,
+	.dout_reg_base			= JH8100_SYS_E_DOUT,
+	.dout_mask			= GENMASK(6, 0),
+	.doen_reg_base			= JH8100_SYS_E_DOEN,
+	.doen_mask			= GENMASK(5, 0),
+	.gpi_reg_base			= JH8100_SYS_E_GPI,
+	.gpi_mask			= GENMASK(5, 0),
+	.gpioin_reg_base		= JH8100_SYS_E_GPIOIN,
+	.func_sel			= jh8100_sys_e_func_sel,
+	.irq_reg			= &jh8100_sys_e_irq_reg,
+	.mis_pin_num			= 32,
+	.mis1_pin_num			= 16,
+};
+
+static const struct of_device_id jh8100_sys_e_pinctrl_of_match[] = {
+	{
+		.compatible = "starfive,jh8100-sys-pinctrl-east",
+		.data = &jh8100_sys_e_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh8100_sys_e_pinctrl_of_match);
+
+static struct platform_driver jh8100_sys_e_pinctrl_driver = {
+	.probe = jh8100_pinctrl_probe,
+	.driver = {
+		.name = "starfive-jh8100-sys-pinctrl-east",
+#ifdef CONFIG_PM_SLEEP
+		.pm = &jh8100_sys_e_pinctrl_dev_pm_ops,
+#endif
+		.of_match_table = jh8100_sys_e_pinctrl_of_match,
+	},
+};
+module_platform_driver(jh8100_sys_e_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for StarFive JH8100 SoC sys east controller");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
new file mode 100644
index 000000000000..4b68463ff5a5
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
@@ -0,0 +1,1094 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC
+ *
+ * Copyright (C) 2023-2024 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/reset.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+#include "pinctrl-starfive-jh8100.h"
+
+/* pad control bits */
+#define JH8100_PADCFG_POS	BIT(7)
+#define JH8100_PADCFG_SMT	BIT(6)
+#define JH8100_PADCFG_SLEW	BIT(5)
+#define JH8100_PADCFG_PD	BIT(4)
+#define JH8100_PADCFG_PU	BIT(3)
+#define JH8100_PADCFG_BIAS_MASK	(JH8100_PADCFG_PD | JH8100_PADCFG_PU)
+#define JH8100_PADCFG_DS_MASK	GENMASK(2, 1)
+#define JH8100_PADCFG_DS_2MA	(0U << 1)
+#define JH8100_PADCFG_DS_4MA	(1U << 1)
+#define JH8100_PADCFG_DS_8MA	(2U << 1)
+#define JH8100_PADCFG_DS_12MA	(3U << 1)
+#define JH8100_PADCFG_IE	BIT(0)
+
+/*
+ * The packed pinmux values from the device tree look like this:
+ *
+ *  | 31 - 24 | 23 - 16 | 15 - 10 |  9 - 8   | 7 - 0 |
+ *  |   din   |  dout   |  doen   | function |  pin  |
+ */
+static unsigned int jh8100_pinmux_din(u32 v)
+{
+	return (v & GENMASK(31, 24)) >> 24;
+}
+
+static u32 jh8100_pinmux_dout(u32 v)
+{
+	return (v & GENMASK(23, 16)) >> 16;
+}
+
+static u32 jh8100_pinmux_doen(u32 v)
+{
+	return (v & GENMASK(15, 10)) >> 10;
+}
+
+static u32 jh8100_pinmux_function(u32 v)
+{
+	return (v & GENMASK(9, 8)) >> 8;
+}
+
+static unsigned int jh8100_pinmux_pin(u32 v)
+{
+	return v & GENMASK(7, 0);
+}
+
+static struct jh8100_pinctrl *jh8100_from_irq_data(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	return container_of(gc, struct jh8100_pinctrl, gc);
+}
+
+struct jh8100_pinctrl *jh8100_from_irq_desc(struct irq_desc *desc)
+{
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+
+	return container_of(gc, struct jh8100_pinctrl, gc);
+}
+EXPORT_SYMBOL_GPL(jh8100_from_irq_desc);
+
+#ifdef CONFIG_DEBUG_FS
+static void jh8100_pin_dbg_show(struct pinctrl_dev *pctldev,
+				struct seq_file *s, unsigned int pin)
+{
+	struct jh8100_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
+	const struct jh8100_pinctrl_domain_info *info = sfp->info;
+
+	seq_printf(s, "%s", dev_name(pctldev->dev));
+
+	if (pin < sfp->gc.ngpio) {
+		unsigned int offset = 4 * (pin / 4);
+		unsigned int shift  = 8 * (pin % 4);
+		u32 dout = readl_relaxed(sfp->base + info->dout_reg_base + offset);
+		u32 doen = readl_relaxed(sfp->base + info->doen_reg_base + offset);
+		u32 gpi = readl_relaxed(sfp->base + info->gpi_reg_base + offset);
+
+		dout = (dout >> shift) & info->dout_mask;
+		doen = (doen >> shift) & info->doen_mask;
+		gpi = ((gpi >> shift) - 2) & info->gpi_mask;
+
+		seq_printf(s, " dout=%u doen=%u din=%u", dout, doen, gpi);
+	}
+}
+#else
+#define jh8100_pin_dbg_show NULL
+#endif
+
+static int jh8100_dt_node_to_map(struct pinctrl_dev *pctldev,
+				 struct device_node *np,
+				 struct pinctrl_map **maps,
+				 unsigned int *num_maps)
+{
+	struct jh8100_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
+	struct device *dev = sfp->gc.parent;
+	struct device_node *child;
+	struct pinctrl_map *map;
+	const char **pgnames;
+	const char *grpname;
+	int ngroups;
+	int nmaps;
+	int ret;
+
+	ngroups = 0;
+	for_each_child_of_node(np, child)
+		ngroups += 1;
+	nmaps = 2 * ngroups;
+
+	pgnames = devm_kcalloc(dev, ngroups, sizeof(*pgnames), GFP_KERNEL);
+	if (!pgnames)
+		return -ENOMEM;
+
+	map = kcalloc(nmaps, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	nmaps = 0;
+	ngroups = 0;
+	mutex_lock(&sfp->mutex);
+	for_each_child_of_node(np, child) {
+		int npins = of_property_count_u32_elems(child, "pinmux");
+		int *pins;
+		u32 *pinmux;
+		int i;
+
+		if (npins < 1) {
+			dev_err(dev,
+				"invalid pinctrl group %pOFn.%pOFn: pinmux not set\n",
+				np, child);
+			ret = -EINVAL;
+			goto put_child;
+		}
+
+		grpname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn.%pOFn", np, child);
+		if (!grpname) {
+			ret = -ENOMEM;
+			goto put_child;
+		}
+
+		pgnames[ngroups++] = grpname;
+
+		pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
+		if (!pins) {
+			ret = -ENOMEM;
+			goto put_child;
+		}
+
+		pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux), GFP_KERNEL);
+		if (!pinmux) {
+			ret = -ENOMEM;
+			goto put_child;
+		}
+
+		ret = of_property_read_u32_array(child, "pinmux", pinmux, npins);
+		if (ret)
+			goto put_child;
+
+		for (i = 0; i < npins; i++)
+			pins[i] = jh8100_pinmux_pin(pinmux[i]);
+
+		map[nmaps].type = PIN_MAP_TYPE_MUX_GROUP;
+		map[nmaps].data.mux.function = np->name;
+		map[nmaps].data.mux.group = grpname;
+		nmaps += 1;
+
+		ret = pinctrl_generic_add_group(pctldev, grpname,
+						pins, npins, pinmux);
+		if (ret < 0) {
+			dev_err(dev, "error adding group %s: %d\n", grpname, ret);
+			goto put_child;
+		}
+
+		ret = pinconf_generic_parse_dt_config(child, pctldev,
+						      &map[nmaps].data.configs.configs,
+						      &map[nmaps].data.configs.num_configs);
+		if (ret) {
+			dev_err(dev, "error parsing pin config of group %s: %d\n",
+				grpname, ret);
+			goto put_child;
+		}
+
+		/* don't create a map if there are no pinconf settings */
+		if (map[nmaps].data.configs.num_configs == 0)
+			continue;
+
+		map[nmaps].type = PIN_MAP_TYPE_CONFIGS_GROUP;
+		map[nmaps].data.configs.group_or_pin = grpname;
+		nmaps += 1;
+	}
+
+	ret = pinmux_generic_add_function(pctldev, np->name,
+					  pgnames, ngroups, NULL);
+	if (ret < 0) {
+		dev_err(dev, "error adding function %s: %d\n", np->name, ret);
+		goto free_map;
+	}
+	mutex_unlock(&sfp->mutex);
+
+	*maps = map;
+	*num_maps = nmaps;
+	return 0;
+
+put_child:
+	of_node_put(child);
+free_map:
+	pinctrl_utils_free_map(pctldev, map, nmaps);
+	mutex_unlock(&sfp->mutex);
+	return ret;
+}
+
+static const struct pinctrl_ops jh8100_pinctrl_ops = {
+	.get_groups_count = pinctrl_generic_get_group_count,
+	.get_group_name   = pinctrl_generic_get_group_name,
+	.get_group_pins   = pinctrl_generic_get_group_pins,
+	.pin_dbg_show     = jh8100_pin_dbg_show,
+	.dt_node_to_map   = jh8100_dt_node_to_map,
+	.dt_free_map      = pinctrl_utils_free_map,
+};
+
+void jh8100_set_gpiomux(struct jh8100_pinctrl *sfp, unsigned int pin,
+			unsigned int din, u32 dout, u32 doen)
+{
+	const struct jh8100_pinctrl_domain_info *info = sfp->info;
+
+	unsigned int offset = 4 * (pin / 4);
+	unsigned int shift  = 8 * (pin % 4);
+	u32 dout_mask = info->dout_mask << shift;
+	u32 done_mask = info->doen_mask << shift;
+	u32 ival, imask;
+	u32 tmp;
+	void __iomem *reg_dout;
+	void __iomem *reg_doen;
+	void __iomem *reg_din;
+	unsigned long flags;
+
+	reg_dout = sfp->base + info->dout_reg_base + offset;
+	reg_doen = sfp->base + info->doen_reg_base + offset;
+	dout <<= shift;
+	doen <<= shift;
+	if (din != 255) {
+		unsigned int ioffset = 4 * (din / 4);
+		unsigned int ishift  = 8 * (din % 4);
+
+		reg_din = sfp->base + info->gpi_reg_base + ioffset;
+		ival = (pin + 2) << ishift;
+		imask = info->gpi_mask << ishift;
+	} else {
+		reg_din = NULL;
+	}
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	dout |= readl_relaxed(reg_dout) & ~dout_mask;
+	writel_relaxed(dout, reg_dout);
+	doen |= readl_relaxed(reg_doen) & ~done_mask;
+	writel_relaxed(doen, reg_doen);
+	if (reg_din) {
+		tmp = readl_relaxed(reg_din) & ~imask;
+		writel_relaxed(tmp, reg_din);
+		ival |= readl_relaxed(reg_din) & ~imask;
+		writel_relaxed(ival, reg_din);
+	}
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh8100_set_function(struct jh8100_pinctrl *sfp,
+				unsigned int pin, u32 func)
+{
+	const struct jh8100_gpio_func_sel *fs = &sfp->info->func_sel[pin];
+	unsigned long flags;
+	void __iomem *reg;
+	u32 mask;
+
+	if (!fs->offset)
+		return;
+
+	if (func > fs->max)
+		return;
+
+	reg = sfp->base + fs->offset;
+	func = func << fs->shift;
+	mask = 0x3U << fs->shift;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	func |= readl_relaxed(reg) & ~mask;
+	writel_relaxed(func, reg);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static int jh8100_set_one_pin_mux(struct jh8100_pinctrl *sfp,
+				  unsigned int pin,
+				  unsigned int din, u32 dout,
+				  u32 doen, u32 func)
+{
+	if (pin < sfp->gc.ngpio && func == 0)
+		jh8100_set_gpiomux(sfp, pin, din, dout, doen);
+
+	if (!strcmp(sfp->info->name, JH8100_SYS_E_DOMAIN_NAME) &&
+	    pin < sfp->gc.ngpio && func == 1)
+		jh8100_set_function(sfp, pin, func);
+
+	return 0;
+}
+
+static int jh8100_set_mux(struct pinctrl_dev *pctldev,
+			  unsigned int fsel, unsigned int gsel)
+{
+	struct jh8100_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
+	const struct group_desc *group;
+	const u32 *pinmux;
+	unsigned int i;
+
+	group = pinctrl_generic_get_group(pctldev, gsel);
+	if (!group)
+		return -EINVAL;
+
+	pinmux = group->data;
+
+	for (i = 0; i < group->grp.npins; i++) {
+		u32 v = pinmux[i];
+
+		jh8100_set_one_pin_mux(sfp,
+				       jh8100_pinmux_pin(v),
+				       jh8100_pinmux_din(v),
+				       jh8100_pinmux_dout(v),
+				       jh8100_pinmux_doen(v),
+				       jh8100_pinmux_function(v));
+		}
+
+	return 0;
+}
+
+static const struct pinmux_ops jh8100_pinmux_ops = {
+	.get_functions_count = pinmux_generic_get_function_count,
+	.get_function_name   = pinmux_generic_get_function_name,
+	.get_function_groups = pinmux_generic_get_function_groups,
+	.set_mux             = jh8100_set_mux,
+	.strict              = true,
+};
+
+static const u8 jh8100_drive_strength_mA[4] = { 2, 4, 8, 12 };
+
+static u32 jh8100_padcfg_ds_to_mA(u32 padcfg)
+{
+	return jh8100_drive_strength_mA[(padcfg >> 1) & 3U];
+}
+
+static u32 jh8100_padcfg_ds_to_uA(u32 padcfg)
+{
+	return jh8100_drive_strength_mA[(padcfg >> 1) & 3U] * 1000;
+}
+
+static u32 jh8100_padcfg_ds_from_mA(u32 v)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(jh8100_drive_strength_mA); i++) {
+		if (v <= jh8100_drive_strength_mA[i])
+			break;
+	}
+	return i << 1;
+}
+
+static u32 jh8100_padcfg_ds_from_uA(u32 v)
+{
+	/* Convert from uA to mA */
+	v /= 1000;
+
+	return jh8100_padcfg_ds_from_mA(v);
+}
+
+static int jh8100_get_padcfg_base(struct jh8100_pinctrl *sfp,
+				  unsigned int pin)
+{
+	if (!strcmp(sfp->info->name, JH8100_SYS_E_DOMAIN_NAME)) {
+		if (pin < JH8100_SYS_E_NGPIO)
+			return JH8100_SYS_E_GPO_PDA_00_47_CFG;
+	}
+
+	return -ENXIO;
+}
+
+static void jh8100_padcfg_rmw(struct jh8100_pinctrl *sfp,
+			      unsigned int pin, u32 mask, u32 value)
+{
+	void __iomem *reg;
+	unsigned long flags;
+	int padcfg_base;
+
+	padcfg_base = jh8100_get_padcfg_base(sfp, pin);
+	if (padcfg_base < 0)
+		return;
+
+	reg = sfp->base + padcfg_base + 4 * pin;
+	value &= mask;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value |= readl_relaxed(reg) & ~mask;
+	writel_relaxed(value, reg);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static int jh8100_pinconf_get(struct pinctrl_dev *pctldev,
+			      unsigned int pin, unsigned long *config)
+{
+	struct jh8100_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
+	int param = pinconf_to_config_param(*config);
+	u32 padcfg, arg;
+	bool enabled;
+	int padcfg_base;
+
+	padcfg_base = jh8100_get_padcfg_base(sfp, pin);
+	if (padcfg_base < 0)
+		return 0;
+
+	padcfg = readl_relaxed(sfp->base + padcfg_base + 4 * pin);
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		enabled = !(padcfg & JH8100_PADCFG_BIAS_MASK);
+		arg = 0;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		enabled = padcfg & JH8100_PADCFG_PD;
+		arg = 1;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		enabled = padcfg & JH8100_PADCFG_PU;
+		arg = 1;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		enabled = true;
+		arg = jh8100_padcfg_ds_to_mA(padcfg);
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		enabled = true;
+		arg = jh8100_padcfg_ds_to_uA(padcfg);
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		enabled = padcfg & JH8100_PADCFG_IE;
+		arg = enabled;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		enabled = padcfg & JH8100_PADCFG_SMT;
+		arg = enabled;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		enabled = true;
+		arg = !!(padcfg & JH8100_PADCFG_SLEW);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+	return enabled ? 0 : -EINVAL;
+}
+
+static int jh8100_pinconf_set(struct pinctrl_dev *pctldev,
+			      unsigned int gpio, unsigned long *config,
+			      unsigned int num_configs)
+{
+	struct jh8100_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
+	u32 param;
+	u32 arg;
+	u32 value;
+	u32 mask;
+	int i;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(config[i]);
+		arg = pinconf_to_config_argument(config[i]);
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			mask  = JH8100_PADCFG_BIAS_MASK;
+			value = 0;
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			if (arg == 0)
+				return -ENOTSUPP;
+			mask  = JH8100_PADCFG_BIAS_MASK;
+			value = JH8100_PADCFG_PD;
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			if (arg == 0)
+				return -ENOTSUPP;
+			mask  = JH8100_PADCFG_BIAS_MASK;
+			value = JH8100_PADCFG_PU;
+			break;
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+			return 0;
+		case PIN_CONFIG_INPUT_ENABLE:
+			mask  = JH8100_PADCFG_IE;
+			value = arg ? JH8100_PADCFG_IE : 0;
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			mask  = JH8100_PADCFG_SMT;
+			value = arg ? JH8100_PADCFG_SMT : 0;
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+
+		jh8100_padcfg_rmw(sfp, gpio, mask, value);
+	}
+
+	return 0;
+}
+
+static int jh8100_pinconf_group_get(struct pinctrl_dev *pctldev,
+				    unsigned int gsel,
+				    unsigned long *config)
+{
+	const struct group_desc *group;
+
+	group = pinctrl_generic_get_group(pctldev, gsel);
+	if (!group)
+		return -EINVAL;
+
+	return jh8100_pinconf_get(pctldev, group->grp.pins[0], config);
+}
+
+static int jh8100_pinconf_group_set(struct pinctrl_dev *pctldev,
+				    unsigned int gsel,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	struct jh8100_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
+	const struct group_desc *group;
+	u16 mask, value;
+	int i;
+
+	group = pinctrl_generic_get_group(pctldev, gsel);
+	if (!group)
+		return -EINVAL;
+
+	mask = 0;
+	value = 0;
+	for (i = 0; i < num_configs; i++) {
+		int param = pinconf_to_config_param(configs[i]);
+		u32 arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			mask |= JH8100_PADCFG_BIAS_MASK;
+			value &= ~JH8100_PADCFG_BIAS_MASK;
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			if (arg == 0)
+				return -ENOTSUPP;
+			mask |= JH8100_PADCFG_BIAS_MASK;
+			value = (value & ~JH8100_PADCFG_BIAS_MASK) | JH8100_PADCFG_PD;
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			if (arg == 0)
+				return -ENOTSUPP;
+			mask |= JH8100_PADCFG_BIAS_MASK;
+			value = (value & ~JH8100_PADCFG_BIAS_MASK) | JH8100_PADCFG_PU;
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			mask |= JH8100_PADCFG_DS_MASK;
+			value = (value & ~JH8100_PADCFG_DS_MASK) |
+				jh8100_padcfg_ds_from_mA(arg);
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH_UA:
+			mask |= JH8100_PADCFG_DS_MASK;
+			value = (value & ~JH8100_PADCFG_DS_MASK) |
+				jh8100_padcfg_ds_from_uA(arg);
+			break;
+		case PIN_CONFIG_INPUT_ENABLE:
+			mask |= JH8100_PADCFG_IE;
+			if (arg)
+				value |= JH8100_PADCFG_IE;
+			else
+				value &= ~JH8100_PADCFG_IE;
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			mask |= JH8100_PADCFG_SMT;
+			if (arg)
+				value |= JH8100_PADCFG_SMT;
+			else
+				value &= ~JH8100_PADCFG_SMT;
+			break;
+		case PIN_CONFIG_SLEW_RATE:
+			mask |= JH8100_PADCFG_SLEW;
+			if (arg)
+				value |= JH8100_PADCFG_SLEW;
+			else
+				value &= ~JH8100_PADCFG_SLEW;
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	for (i = 0; i < group->grp.npins; i++)
+		jh8100_padcfg_rmw(sfp, group->grp.pins[i], mask, value);
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void jh8100_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+				    struct seq_file *s, unsigned int pin)
+{
+	struct jh8100_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
+	u32 value;
+	int padcfg_base;
+
+	padcfg_base = jh8100_get_padcfg_base(sfp, pin);
+	if (padcfg_base < 0)
+		return;
+
+	value = readl_relaxed(sfp->base + padcfg_base + 4 * pin);
+	seq_printf(s, " (0x%02x)", value);
+}
+#else
+#define jh8100_pinconf_dbg_show NULL
+#endif
+
+static const struct pinconf_ops jh8100_pinconf_ops = {
+	.pin_config_get         = jh8100_pinconf_get,
+	.pin_config_set         = jh8100_pinconf_set,
+	.pin_config_group_get   = jh8100_pinconf_group_get,
+	.pin_config_group_set   = jh8100_pinconf_group_set,
+	.pin_config_dbg_show    = jh8100_pinconf_dbg_show,
+	.is_generic             = true,
+};
+
+static int jh8100_gpio_get_direction(struct gpio_chip *gc,
+				     unsigned int gpio)
+{
+	struct jh8100_pinctrl *sfp = container_of(gc,
+			struct jh8100_pinctrl, gc);
+	const struct jh8100_pinctrl_domain_info *info = sfp->info;
+	unsigned int offset = 4 * (gpio / 4);
+	unsigned int shift  = 8 * (gpio % 4);
+	u32 doen = readl_relaxed(sfp->base + info->doen_reg_base + offset);
+
+	doen = (doen >> shift) & info->doen_mask;
+
+	return doen == 0 ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
+static int jh8100_gpio_direction_input(struct gpio_chip *gc,
+				       unsigned int gpio)
+{
+	struct jh8100_pinctrl *sfp = container_of(gc,
+			struct jh8100_pinctrl, gc);
+
+	/* enable input and schmitt trigger */
+	jh8100_padcfg_rmw(sfp, gpio,
+			  JH8100_PADCFG_IE | JH8100_PADCFG_SMT,
+			  JH8100_PADCFG_IE | JH8100_PADCFG_SMT);
+
+	jh8100_set_one_pin_mux(sfp, gpio, 255, 0, 1, 0);
+
+	return 0;
+}
+
+static int jh8100_gpio_direction_output(struct gpio_chip *gc,
+					unsigned int gpio, int value)
+{
+	struct jh8100_pinctrl *sfp = container_of(gc,
+			struct jh8100_pinctrl, gc);
+
+	jh8100_set_one_pin_mux(sfp, gpio,
+			       255, value ? 1 : 0,
+			       0, 0);
+
+	/* disable input, schmitt trigger and bias */
+	jh8100_padcfg_rmw(sfp, gpio,
+			  JH8100_PADCFG_IE | JH8100_PADCFG_SMT,
+			  0);
+	return 0;
+}
+
+static int jh8100_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct jh8100_pinctrl *sfp = container_of(gc,
+			struct jh8100_pinctrl, gc);
+	const struct jh8100_pinctrl_domain_info *info = sfp->info;
+	void __iomem *reg = sfp->base + info->gpioin_reg_base
+			+ 4 * (gpio / 32);
+
+	return !!(readl_relaxed(reg) & BIT(gpio % 32));
+}
+
+static void jh8100_gpio_set(struct gpio_chip *gc,
+			    unsigned int gpio, int value)
+{
+	struct jh8100_pinctrl *sfp = container_of(gc,
+			struct jh8100_pinctrl, gc);
+	const struct jh8100_pinctrl_domain_info *info = sfp->info;
+	unsigned int offset = 4 * (gpio / 4);
+	unsigned int shift  = 8 * (gpio % 4);
+	void __iomem *reg_dout = sfp->base + info->dout_reg_base + offset;
+	u32 dout = (value ? 1 : 0) << shift;
+	u32 mask = info->dout_mask << shift;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	dout |= readl_relaxed(reg_dout) & ~mask;
+	writel_relaxed(dout, reg_dout);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh8100_irq_ack(struct irq_data *d)
+{
+	struct jh8100_pinctrl *sfp = jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ic = sfp->base + irq_reg->ic_reg_base
+		+ 4 * (gpio / 32);
+	u32 mask = BIT(gpio % 32);
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ic) & ~mask;
+	writel_relaxed(value, ic);
+	writel_relaxed(value | mask, ic);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh8100_irq_mask(struct irq_data *d)
+{
+	struct jh8100_pinctrl *sfp = jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ie = sfp->base + irq_reg->ie_reg_base
+		+ 4 * (gpio / 32);
+	u32 mask = BIT(gpio % 32);
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ie) & ~mask;
+	writel_relaxed(value, ie);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+
+	gpiochip_disable_irq(&sfp->gc, d->hwirq);
+}
+
+static void jh8100_irq_mask_ack(struct irq_data *d)
+{
+	struct jh8100_pinctrl *sfp = jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ie = sfp->base + irq_reg->ie_reg_base
+		+ 4 * (gpio / 32);
+	void __iomem *ic = sfp->base + irq_reg->ic_reg_base
+		+ 4 * (gpio / 32);
+	u32 mask = BIT(gpio % 32);
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ie) & ~mask;
+	writel_relaxed(value, ie);
+
+	value = readl_relaxed(ic) & ~mask;
+	writel_relaxed(value, ic);
+	writel_relaxed(value | mask, ic);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh8100_irq_unmask(struct irq_data *d)
+{
+	struct jh8100_pinctrl *sfp = jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ie = sfp->base + irq_reg->ie_reg_base
+		+ 4 * (gpio / 32);
+	u32 mask = BIT(gpio % 32);
+	unsigned long flags;
+	u32 value;
+
+	gpiochip_enable_irq(&sfp->gc, d->hwirq);
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ie) | mask;
+	writel_relaxed(value, ie);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static int jh8100_irq_set_type(struct irq_data *d, unsigned int trigger)
+{
+	struct jh8100_pinctrl *sfp = jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *base = sfp->base + 4 * (gpio / 32);
+	u32 mask = BIT(gpio % 32);
+	u32 irq_type, edge_both, polarity;
+	unsigned long flags;
+
+	switch (trigger) {
+	case IRQ_TYPE_EDGE_RISING:
+		irq_type  = mask; /* 1: edge triggered */
+		edge_both = 0;    /* 0: single edge */
+		polarity  = mask; /* 1: rising edge */
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_type  = mask; /* 1: edge triggered */
+		edge_both = 0;    /* 0: single edge */
+		polarity  = 0;    /* 0: falling edge */
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		irq_type  = mask; /* 1: edge triggered */
+		edge_both = mask; /* 1: both edges */
+		polarity  = 0;    /* 0: ignored */
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_type  = 0;    /* 0: level triggered */
+		edge_both = 0;    /* 0: ignored */
+		polarity  = mask; /* 1: high level */
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type  = 0;    /* 0: level triggered */
+		edge_both = 0;    /* 0: ignored */
+		polarity  = 0;    /* 0: low level */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (trigger & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(d, handle_edge_irq);
+	else
+		irq_set_handler_locked(d, handle_level_irq);
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	irq_type |= readl_relaxed(base + irq_reg->is_reg_base) & ~mask;
+	writel_relaxed(irq_type, base + irq_reg->is_reg_base);
+
+	edge_both |= readl_relaxed(base + irq_reg->ibe_reg_base) & ~mask;
+	writel_relaxed(edge_both, base + irq_reg->ibe_reg_base);
+
+	polarity |= readl_relaxed(base + irq_reg->iev_reg_base) & ~mask;
+	writel_relaxed(polarity, base + irq_reg->iev_reg_base);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+	return 0;
+}
+
+static int jh8100_irq_set_wake(struct irq_data *d, unsigned int enable)
+{
+	struct jh8100_pinctrl *sfp = jh8100_from_irq_data(d);
+	int ret = 0;
+
+	if (enable)
+		ret = enable_irq_wake(sfp->wakeup_irq);
+	else
+		ret = disable_irq_wake(sfp->wakeup_irq);
+	if (ret)
+		dev_err(sfp->dev, "failed to %s wake-up interrupt\n",
+			enable ? "enable" : "disable");
+
+	return ret;
+}
+
+static void jh8100_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct jh8100_pinctrl *sfp = jh8100_from_irq_data(d);
+
+	seq_printf(p, sfp->gc.label);
+}
+
+static const struct irq_chip jh8100_irq_chip = {
+	.irq_ack        = jh8100_irq_ack,
+	.irq_mask       = jh8100_irq_mask,
+	.irq_mask_ack   = jh8100_irq_mask_ack,
+	.irq_unmask     = jh8100_irq_unmask,
+	.irq_set_type   = jh8100_irq_set_type,
+	.irq_set_wake   = jh8100_irq_set_wake,
+	.irq_print_chip = jh8100_irq_print_chip,
+	.flags          = IRQCHIP_SET_TYPE_MASKED |
+			  IRQCHIP_IMMUTABLE |
+			  IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND |
+			  IRQCHIP_MASK_ON_SUSPEND |
+			  IRQCHIP_SKIP_SET_WAKE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static void jh8100_gpio_irq_handler(struct irq_desc *desc)
+{
+	struct jh8100_pinctrl *sfp = jh8100_from_irq_desc(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct gpio_irq_chip *girq = &sfp->gc.irq;
+	unsigned long mis;
+	unsigned int pin;
+
+	chained_irq_enter(chip, desc);
+
+	mis = readl_relaxed(sfp->base + sfp->info->irq_reg->mis_reg_base);
+	for_each_set_bit(pin, &mis, sfp->info->mis_pin_num)
+		generic_handle_domain_irq(girq->domain, pin);
+
+	if (sfp->info->irq_reg->mis1_reg_base) {
+		mis = readl_relaxed(sfp->base + sfp->info->irq_reg->mis1_reg_base);
+		for_each_set_bit(pin, &mis, sfp->info->mis1_pin_num)
+			generic_handle_domain_irq(girq->domain, pin + 32);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int jh8100_gpio_init_hw(struct gpio_chip *gc)
+{
+	struct jh8100_pinctrl *sfp = container_of(gc,
+				struct jh8100_pinctrl, gc);
+
+	/* mask all GPIO interrupts */
+	writel_relaxed(0U, sfp->base + sfp->info->irq_reg->ie_reg_base);
+	/* clear edge interrupt flags */
+	writel_relaxed(0U, sfp->base + sfp->info->irq_reg->ic_reg_base);
+	writel_relaxed(~0U, sfp->base + sfp->info->irq_reg->ic_reg_base);
+	if (sfp->info->irq_reg->ic1_reg_base) {
+		writel_relaxed(0U, sfp->base + sfp->info->irq_reg->ic1_reg_base);
+		writel_relaxed(~0U, sfp->base + sfp->info->irq_reg->ic1_reg_base);
+	}
+	/* enable GPIO interrupts */
+	writel_relaxed(1, sfp->base + sfp->info->irq_reg->ien_reg_base);
+
+	return 0;
+}
+
+static void jh8100_disable_clock(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+int jh8100_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_irq_chip *girq;
+	const struct jh8100_pinctrl_domain_info *info;
+	struct jh8100_pinctrl *sfp;
+	struct pinctrl_desc *jh8100_pinctrl_desc;
+	struct reset_control *rst;
+	struct clk *clk;
+	int ret;
+
+	info = of_device_get_match_data(&pdev->dev);
+	if (!info)
+		return -ENODEV;
+
+	sfp = devm_kzalloc(dev, sizeof(*sfp), GFP_KERNEL);
+	if (!sfp)
+		return -ENOMEM;
+
+	sfp->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sfp->base))
+		return PTR_ERR(sfp->base);
+
+	clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "could not get clock\n");
+
+	rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "could not get reset control\n");
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not enable clock\n");
+
+	ret = devm_add_action_or_reset(dev, jh8100_disable_clock, clk);
+	if (ret)
+		return ret;
+
+	/*
+	 * we don't want to assert reset and risk undoing pin muxing for the
+	 * early boot serial console, but let's make sure the reset line is
+	 * deasserted in case someone runs a really minimal bootloader.
+	 */
+	ret = reset_control_deassert(rst);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not deassert reset\n");
+
+	jh8100_pinctrl_desc = devm_kzalloc(&pdev->dev,
+					   sizeof(*jh8100_pinctrl_desc),
+					   GFP_KERNEL);
+	if (!jh8100_pinctrl_desc)
+		return -ENOMEM;
+
+	jh8100_pinctrl_desc->name = dev_name(dev);
+	jh8100_pinctrl_desc->pins = info->pins;
+	jh8100_pinctrl_desc->npins = info->npins;
+	jh8100_pinctrl_desc->pctlops = &jh8100_pinctrl_ops;
+	jh8100_pinctrl_desc->pmxops = &jh8100_pinmux_ops;
+	jh8100_pinctrl_desc->confops = &jh8100_pinconf_ops;
+	jh8100_pinctrl_desc->owner = THIS_MODULE;
+
+	sfp->info = info;
+	sfp->dev = dev;
+	platform_set_drvdata(pdev, sfp);
+	sfp->gc.parent = dev;
+	raw_spin_lock_init(&sfp->lock);
+	mutex_init(&sfp->mutex);
+
+	ret = devm_pinctrl_register_and_init(dev,
+					     jh8100_pinctrl_desc,
+					     sfp, &sfp->pctl);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "could not register pinctrl driver\n");
+
+	sfp->gc.label = dev_name(dev);
+	sfp->gc.owner = THIS_MODULE;
+	sfp->gc.request = pinctrl_gpio_request;
+	sfp->gc.free = pinctrl_gpio_free;
+	sfp->gc.get_direction = jh8100_gpio_get_direction;
+	sfp->gc.direction_input = jh8100_gpio_direction_input;
+	sfp->gc.direction_output = jh8100_gpio_direction_output;
+	sfp->gc.get = jh8100_gpio_get;
+	sfp->gc.set = jh8100_gpio_set;
+	sfp->gc.set_config = gpiochip_generic_config;
+	sfp->gc.base = info->gc_base;
+	sfp->gc.ngpio = info->ngpios;
+
+	girq = &sfp->gc.irq;
+
+	if (info->irq_reg) {
+		gpio_irq_chip_set_chip(girq, &jh8100_irq_chip);
+		girq->parent_handler = jh8100_gpio_irq_handler;
+		girq->num_parents = 1;
+		girq->parents = devm_kcalloc(dev, girq->num_parents,
+					     sizeof(*girq->parents),
+					     GFP_KERNEL);
+		if (!girq->parents)
+			return -ENOMEM;
+		girq->default_type = IRQ_TYPE_NONE;
+		girq->handler = handle_bad_irq;
+		girq->init_hw = jh8100_gpio_init_hw;
+
+		ret = platform_get_irq(pdev, 0);
+		if (ret < 0)
+			return ret;
+		girq->parents[0] = ret;
+	}
+
+	ret = pinctrl_enable(sfp->pctl);
+	if (ret)
+		return ret;
+
+	if (sfp->gc.ngpio > 0) {
+		ret = devm_gpiochip_add_data(dev, &sfp->gc, sfp);
+		if (ret)
+			return dev_err_probe(dev, ret, "could not register gpiochip\n");
+
+		dev_info(dev, "StarFive JH8100 GPIO chip registered %d GPIOs\n", sfp->gc.ngpio);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(jh8100_pinctrl_probe);
+
+MODULE_DESCRIPTION("Pinctrl driver for the StarFive JH8100 SoC");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
new file mode 100644
index 000000000000..6eb4f1896a90
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC
+ *
+ * Copyright (C) 2023-2024 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#ifndef __PINCTRL_STARFIVE_JH8100_H__
+#define __PINCTRL_STARFIVE_JH8100_H__
+
+#include "../core.h"
+
+#define JH8100_SYS_E_DOMAIN_NAME	"jh8100-sys-east"
+
+#define JH8100_SYS_E_NGPIO		48
+
+#define JH8100_SYS_E_REG_NUM		116
+
+#define JH8100_SYS_E_GPO_PDA_00_47_CFG	0x114
+
+struct jh8100_pinctrl {
+	struct device *dev;
+	struct gpio_chip gc;
+	struct pinctrl_gpio_range gpios;
+	raw_spinlock_t lock;
+	void __iomem *base;
+	struct pinctrl_dev *pctl;
+	/* register read/write mutex */
+	struct mutex mutex;
+	const struct jh8100_pinctrl_domain_info *info;
+	unsigned int jh8100_sys_east_regs[JH8100_SYS_E_REG_NUM];
+	/* wakeup */
+	struct irq_domain *irq_domain;
+	struct gpio_desc *wakeup_gpio;
+	int wakeup_irq;
+};
+
+struct jh8100_gpio_func_sel {
+	unsigned short offset;
+	unsigned char shift;
+	unsigned char max;
+};
+
+struct jh8100_gpio_irq_reg {
+	unsigned int is_reg_base;
+	unsigned int ic_reg_base;
+	unsigned int ic1_reg_base;
+	unsigned int ibe_reg_base;
+	unsigned int iev_reg_base;
+	unsigned int ie_reg_base;
+	unsigned int ris_reg_base;
+	unsigned int mis_reg_base;
+	unsigned int mis1_reg_base;
+	unsigned int ien_reg_base;
+};
+
+struct jh8100_pinctrl_domain_info {
+	const struct pinctrl_pin_desc *pins;
+	unsigned int npins;
+	unsigned int ngpios;
+	unsigned int gc_base;
+
+	const char *name;
+	unsigned int nregs;
+
+	/* gpio dout/doen/din/gpioinput register */
+	unsigned int dout_reg_base;
+	unsigned int dout_mask;
+	unsigned int doen_reg_base;
+	unsigned int doen_mask;
+	unsigned int gpi_reg_base;
+	unsigned int gpi_mask;
+	unsigned int gpioin_reg_base;
+
+	const struct jh8100_gpio_func_sel *func_sel;
+	const struct jh8100_gpio_irq_reg *irq_reg;
+
+	/* gpio chip */
+	unsigned int mis_pin_num;
+	unsigned int mis1_pin_num;
+};
+
+int jh8100_pinctrl_probe(struct platform_device *pdev);
+void jh8100_set_gpiomux(struct jh8100_pinctrl *sfp, unsigned int pin,
+			unsigned int din, u32 dout, u32 doen);
+struct jh8100_pinctrl *jh8100_from_irq_desc(struct irq_desc *desc);
+void pinctrl_utils_free_map(struct pinctrl_dev *pctldev,
+			    struct pinctrl_map *map, unsigned int num_maps);
+int pinmux_generic_get_function_count(struct pinctrl_dev *pctldev);
+const char *pinmux_generic_get_function_name(struct pinctrl_dev *pctldev,
+					     unsigned int selector);
+int pinmux_generic_get_function_groups(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const char * const **groups,
+				       unsigned int * const num_groups);
+int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
+				const char *name,
+				const char * const *groups,
+				unsigned int const num_groups,
+				void *data);
+
+#if defined(CONFIG_GENERIC_PINCONF) && defined(CONFIG_OF)
+int pinconf_generic_parse_dt_config(struct device_node *np,
+				    struct pinctrl_dev *pctldev,
+				    unsigned long **configs,
+				    unsigned int *nconfigs);
+#endif
+
+#endif /* __PINCTRL_STARFIVE_JH8100_H__ */
-- 
2.25.1


