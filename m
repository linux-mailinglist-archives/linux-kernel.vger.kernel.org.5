Return-Path: <linux-kernel+bounces-72443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B78C85B34D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8164C1C213F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D45A0F5;
	Tue, 20 Feb 2024 06:58:24 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130DA5A0E4;
	Tue, 20 Feb 2024 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412301; cv=fail; b=Lbc+r6pwWbI/MjwsiRkym9wN5rwhdInYl0BElr8gi4smFK9dDk/ma6y+GFgJSOFjNID3YMg+Zkyj3xJ4vK8XEkYfRef7qO3qzT57R+xkIvvvcGg7N6QK9RudtrYYh3PGiyrh/Smz8HKjz6ms8k8mYtxNB6gMtB5mrWANPC7QLzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412301; c=relaxed/simple;
	bh=WC1Hl4+4VCSVhZnxxKljgOmP+7PJSf5vVLeojIQXesM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bD/7/ym6KymFH5Y2zcPgD3o5ajX80Af6E5vj+KkjsA0RDntBG/2RQcLWgCJFL9KUrbYIDUh34EZY3R2TUzX2UpGnak6khp0pr3GLukvIlTgD/PYpF0O3No3AxaMM/7oCrORCIhzY2uXvQDxgWrcnO/mdckzlpQkYm28EEfSAxkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOrb8ytxv9e0n8u+XvlsGgeCMwp/4pvRk0jFwlU3iuIuZ0QbhQFgYyq8F1MNJPJG95NsCWVY/ZQKPWegLRCJevA4fhMOzMRNnscqTgPTDucxQwSyW4L9PpODoWfhZCw/xxUnwdUutqXOPXCMhxucgVgrbsimHpHN4YPZdc9oYe1IoJNxhN/lMxAU4lnVQd7IefhKSftQuWfCMzY79pMSoiHvOI0N6BZO7Int1fNQ9pHFO3J0jbWYfmyIQzkrlVoXZWy7v+rIi09NLDRLXib62RWv1DEhL6Qx7DI/fkQFyWoq0gtaGJKFhoPt1FXNWKmPyvEth+nk8OeP/C+NdheEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlB4BSeLTVQf+Qr/Usu22JYy6hXlJwMh67lqTgMqCHs=;
 b=QkP8LZ7L95UfUyUal8kBMHBqhZLyDOZaGrv2242MtVEkn/DsTafwt00hfyT8jFu2uo5Nk22J8fwATHk2LfMl8ihEliTZXBrssV9WsrsaMqUAItHU3O/EWrzIUAHOp/5ajHjlv15aXi4Wc3a0hpqYqyxCYJN5zDTQPEko+EXuAL8ECQja1cNtvPnac2gTbVvALRNllIGt+sEPEvSLRh8fKXi5SRHrlxm3b/x4LDDLkfs7ZqJIJ7F03tdX8Ww9S1mY9YDl6dg7Gfi2eCYmLr3UVaOcigXCAUteGCugwHh+zJTVKKuPUDirKGfLLa6HonhBqZcst1raCViT52Ub9lgKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 20 Feb
 2024 06:43:04 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::9d68:58f1:62cc:f1d3]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::9d68:58f1:62cc:f1d3%4])
 with mapi id 15.20.7270.047; Tue, 20 Feb 2024 06:43:04 +0000
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
Subject: [RFC PATCH v2 2/6] pinctrl: starfive: jh8100: add main and sys_east driver
Date: Tue, 20 Feb 2024 14:42:42 +0800
Message-ID: <20240220064246.467216-3-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1239:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e95b41-dd08-4c2b-fa4a-08dc31df308b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AS0RQ2OhyuIJ91mDVM1wXrLe53DOEHHftiU25ec747PjgZTmLkoxyXeXc2gAVLBSqOv8tQIog2LiA6kV+N23bc4PTAYUeLcERCFccIpiKAeW/d6eJCq2N0pzYyiCngMTLLMA2RKdlucVXlIox4BlsC1ccjbApbs8oBc9beGcnKku2AGy1Hmh6JSn7zgCTW0ksNtENIxUPHYMwsV9sV2yN5nOtIeHhXkqQtH845QbFBdHqmuNTP+3yOKyP7upi+OBeAUMY7iFvPm3YIiuyxFdhLW58B3oMVmKX4UzKAm+IX7T08u7uOs5rgt53vts8BqhHq7AB3CvpZYxH70xcVPGQITahMv+NKD+SsX8T8QEJd9MluTpCZXpD0Np9ab7dQ9NYvs6h74o7VGrIZ0C/iQ18Li1XMlD4TmMCVJ4WA6ce+Six7BfCH/CxakRuWs9xNSeyNIMRkPt7pnAAiL1BuajDgSrY+5MIuR1Ya7R5bW+Br/ZvchCdf9DUP1vJokA7pauFNLf+XHILTU2beI1WjyNdkbpj2Bpb8FQB8qgrOZDNO1WYB9zBSJAh+AKf7tYIfar5RBcve2rN6WZf6g4ZULKMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NO1RuD5l5WrwAH4+BYT+cAWqTFyrcFiAMwNm+Kxwnm24H/QLblK0xsq+3G9e?=
 =?us-ascii?Q?58S7zwS6X36jT5ypshlislJbV/1zAwm81hGh3iALl+ZDXNBnOLp4F6ierg5L?=
 =?us-ascii?Q?OdBr2hjuJyCylnwaV2NPSCgA5IGGKE9Ho0pp9yRo2mkLRLFtN1h9HDVxxU0J?=
 =?us-ascii?Q?/NkGhbWtFFJnNMcnuqHfNewFQEvlXz4Mgb7zoQW/tPAWX0dggR01eh/L+fkX?=
 =?us-ascii?Q?2exjM0iZER8lH/FdQyW3nc75hBdWLcBmWsb7IY1bjNi00Rcmix9CIbGfRbhR?=
 =?us-ascii?Q?Ywb1k4TApoSYAauYuvIHY9MjpNuXSAQLxoIREKspBKmzYFF2fmh0gMkK+67b?=
 =?us-ascii?Q?gxD2ewpz6F1YXBA9+ED/ybD4rEQXys94ekBt/V7AJS81FU0MVzyIb6rRAMsq?=
 =?us-ascii?Q?e64SpJ+Aui2lb7qBed6DPPYH7Ldd1zvOHBdXVlhaiDql/K/GW2ipQeF88Q+O?=
 =?us-ascii?Q?C1N4ylCH0A0G0H8wlfPRissoBQTGrr7Q2HEObGNfVnBaCj9Km6JirhpXNQj6?=
 =?us-ascii?Q?7E4OYS+lc3CDhHVdcYpaYFQ+G4aF0Ut6Y2fYSBeroPp9EUR8dWiUSNtpYhnP?=
 =?us-ascii?Q?+VpEAUiXbjotF8DrLbU9Y2X9eT6pRcfVjTQuYpZ3vj/E4eLSXAxqoySkm3GX?=
 =?us-ascii?Q?AgVQXTC/LhabC3OMSFL4KVbGEYYnXiwlbcG05CAj7DAMAFSc/u/qwJOouoCM?=
 =?us-ascii?Q?3zxLwucFyK0eY7mNvDRLgWwUUmgMVFKeA4YG0i6U72Jdg3b4E54bar4ApuLs?=
 =?us-ascii?Q?Y0y3N7U5lx1gAeZe1bxcu3R/uVOPGyWkb2lTAws8grepfAwEYAo0Wl7siicZ?=
 =?us-ascii?Q?sFlBcqEu2e4zKumuOSJnpkwIngaf1bpp6M4Ur6hc0x5MUHROX13y6lA0/noj?=
 =?us-ascii?Q?mz59EjEBQ9MS+HB5OB1bYEfiCnz7RkrzTY4ftE037Pd6Ug/BARMXoM/d5c5B?=
 =?us-ascii?Q?cHGX/I2+BFLKFI6IucRERS7Ca0rN263zdEg2XE9fpBizyx+wptKe4aWbhNm5?=
 =?us-ascii?Q?sxZKFolWA6rrHJ4VWeRlx2i9lGfdJvy/AzywMNyoDJWN+zCFpeZxZpmR0M94?=
 =?us-ascii?Q?tew1IXMMgCj2nU26qZekDbMTMwRD+eGFgv00SDTgak0KH/nimbEmO64aypzp?=
 =?us-ascii?Q?8a1oDcClDACqVgLwupigzk2+S+UZPZ8lwpsJCZ6Br5cDy+9BuEB0e8RLtEPV?=
 =?us-ascii?Q?QX4AaduJwuXoeUukiAPgKOveXttRyWvF4HYomHVrqH5YS+cpki/+RAAhvlVw?=
 =?us-ascii?Q?BHB3T+uE/DJg8NVHl0pcUjmes0Ud+LD3Ow01MYhbcx+pnONwlyzNJ32/TZI0?=
 =?us-ascii?Q?mX1vJDeEJ96vnaTL/2YzFPq2XrZJDcAYBBgu6idGxo8cCwWJu6QCzSvjY6HU?=
 =?us-ascii?Q?DhYAq2bhZWOb0Mo6korkHbeAMWFTwxXlCd8t4QuXTmnyJoZpRIz+R2rqPsew?=
 =?us-ascii?Q?M0KQjhbu/6bFoKRvq4FljSsmdFQaNg+hQr45MbmlOo+VocCL1IseIEdO7iJL?=
 =?us-ascii?Q?mKnn5HFPYHXzSbunIdRVspLP0JzvVduwXMyFdVrh8dF1WM1oZjseloiVPbYJ?=
 =?us-ascii?Q?CpLjfIW+FbGJR4xAUq12AplSky2RfQYEpklSPV0UAAD2EIRlYPtxzo+s4cOo?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e95b41-dd08-4c2b-fa4a-08dc31df308b
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:43:04.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3o2oPEJmpj3hoC8tj1dxb/EQO7bOHy5NgxLrxf1/IiYcGrKp6uGfdv9cOZ9alEcrSMs9Qw95CZvRmzoZyz+uooK57VmHN+qPIvBGro9hSKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

Add JH8100 pinctrl main and sys_east domain driver.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 drivers/pinctrl/starfive/Kconfig              |   21 +
 drivers/pinctrl/starfive/Makefile             |    3 +
 .../pinctrl-starfive-jh8100-sys-east.c        |  224 ++++
 .../starfive/pinctrl-starfive-jh8100.c        | 1181 +++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |   94 ++
 5 files changed, 1523 insertions(+)
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
index 000000000000..395ee9f86298
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-east.c
@@ -0,0 +1,224 @@
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
+#include "../core.h"
+#include "../pinmux.h"
+#include "../pinconf.h"
+#include "pinctrl-starfive-jh8100.h"
+
+#define JH8100_SYS_E_NGPIO			48
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
+	PINCTRL_PIN(PAD_GPIO0_E,	"SYS_E_GPIO0"),
+	PINCTRL_PIN(PAD_GPIO1_E,	"SYS_E_GPIO1"),
+	PINCTRL_PIN(PAD_GPIO2_E,	"SYS_E_GPIO2"),
+	PINCTRL_PIN(PAD_GPIO3_E,	"SYS_E_GPIO3"),
+	PINCTRL_PIN(PAD_GPIO4_E,	"SYS_E_GPIO4"),
+	PINCTRL_PIN(PAD_GPIO5_E,	"SYS_E_GPIO5"),
+	PINCTRL_PIN(PAD_GPIO6_E,	"SYS_E_GPIO6"),
+	PINCTRL_PIN(PAD_GPIO7_E,	"SYS_E_GPIO7"),
+	PINCTRL_PIN(PAD_GPIO8_E,	"SYS_E_GPIO8"),
+	PINCTRL_PIN(PAD_GPIO9_E,	"SYS_E_GPIO9"),
+	PINCTRL_PIN(PAD_GPIO10_E,	"SYS_E_GPIO10"),
+	PINCTRL_PIN(PAD_GPIO11_E,	"SYS_E_GPIO11"),
+	PINCTRL_PIN(PAD_GPIO12_E,	"SYS_E_GPIO12"),
+	PINCTRL_PIN(PAD_GPIO13_E,	"SYS_E_GPIO13"),
+	PINCTRL_PIN(PAD_GPIO14_E,	"SYS_E_GPIO14"),
+	PINCTRL_PIN(PAD_GPIO15_E,	"SYS_E_GPIO15"),
+	PINCTRL_PIN(PAD_GPIO16_E,	"SYS_E_GPIO16"),
+	PINCTRL_PIN(PAD_GPIO17_E,	"SYS_E_GPIO17"),
+	PINCTRL_PIN(PAD_GPIO18_E,	"SYS_E_GPIO18"),
+	PINCTRL_PIN(PAD_GPIO19_E,	"SYS_E_GPIO19"),
+	PINCTRL_PIN(PAD_GPIO20_E,	"SYS_E_GPIO20"),
+	PINCTRL_PIN(PAD_GPIO21_E,	"SYS_E_GPIO21"),
+	PINCTRL_PIN(PAD_GPIO22_E,	"SYS_E_GPIO22"),
+	PINCTRL_PIN(PAD_GPIO23_E,	"SYS_E_GPIO23"),
+	PINCTRL_PIN(PAD_GPIO24_E,	"SYS_E_GPIO24"),
+	PINCTRL_PIN(PAD_GPIO25_E,	"SYS_E_GPIO25"),
+	PINCTRL_PIN(PAD_GPIO26_E,	"SYS_E_GPIO26"),
+	PINCTRL_PIN(PAD_GPIO27_E,	"SYS_E_GPIO27"),
+	PINCTRL_PIN(PAD_GPIO28_E,	"SYS_E_GPIO28"),
+	PINCTRL_PIN(PAD_GPIO29_E,	"SYS_E_GPIO29"),
+	PINCTRL_PIN(PAD_GPIO30_E,	"SYS_E_GPIO30"),
+	PINCTRL_PIN(PAD_GPIO31_E,	"SYS_E_GPIO31"),
+	PINCTRL_PIN(PAD_GPIO32_E,	"SYS_E_GPIO32"),
+	PINCTRL_PIN(PAD_GPIO33_E,	"SYS_E_GPIO33"),
+	PINCTRL_PIN(PAD_GPIO34_E,	"SYS_E_GPIO34"),
+	PINCTRL_PIN(PAD_GPIO35_E,	"SYS_E_GPIO35"),
+	PINCTRL_PIN(PAD_GPIO36_E,	"SYS_E_GPIO36"),
+	PINCTRL_PIN(PAD_GPIO37_E,	"SYS_E_GPIO37"),
+	PINCTRL_PIN(PAD_GPIO38_E,	"SYS_E_GPIO38"),
+	PINCTRL_PIN(PAD_GPIO39_E,	"SYS_E_GPIO39"),
+	PINCTRL_PIN(PAD_GPIO40_E,	"SYS_E_GPIO40"),
+	PINCTRL_PIN(PAD_GPIO41_E,	"SYS_E_GPIO41"),
+	PINCTRL_PIN(PAD_GPIO42_E,	"SYS_E_GPIO42"),
+	PINCTRL_PIN(PAD_GPIO43_E,	"SYS_E_GPIO43"),
+	PINCTRL_PIN(PAD_GPIO44_E,	"SYS_E_GPIO44"),
+	PINCTRL_PIN(PAD_GPIO45_E,	"SYS_E_GPIO45"),
+	PINCTRL_PIN(PAD_GPIO46_E,	"SYS_E_GPIO46"),
+	PINCTRL_PIN(PAD_GPIO47_E,	"SYS_E_GPIO47"),
+};
+
+static const struct jh8100_gpio_func_sel
+	jh8100_sys_e_func_sel[ARRAY_SIZE(jh8100_sys_e_pins)] = {
+	[PAD_GPIO20_E]    = { 0x1d4,  0, 2 },
+	[PAD_GPIO21_E]    = { 0x1d4,  2, 2 },
+	[PAD_GPIO22_E]    = { 0x1d4,  4, 2 },
+	[PAD_GPIO23_E]    = { 0x1d4,  6, 2 },
+	[PAD_GPIO24_E]    = { 0x1d4,  8, 2 },
+	[PAD_GPIO25_E]    = { 0x1d4, 10, 2 },
+	[PAD_GPIO26_E]    = { 0x1d4, 12, 2 },
+	[PAD_GPIO27_E]    = { 0x1d4, 14, 2 },
+	[PAD_GPIO28_E]    = { 0x1d4, 16, 2 },
+	[PAD_GPIO29_E]    = { 0x1d4, 18, 2 },
+	[PAD_GPIO30_E]    = { 0x1d4, 20, 2 },
+	[PAD_GPIO31_E]    = { 0x1d4, 22, 2 },
+	[PAD_GPIO32_E]    = { 0x1d4, 24, 2 },
+	[PAD_GPIO33_E]    = { 0x1d4, 26, 2 },
+	[PAD_GPIO34_E]    = { 0x1d4, 28, 2 },
+	[PAD_GPIO35_E]    = { 0x1d4, 30, 2 },
+
+	[PAD_GPIO36_E]    = { 0x1d8,  0, 2 },
+	[PAD_GPIO37_E]    = { 0x1d8,  2, 2 },
+	[PAD_GPIO38_E]    = { 0x1d8,  4, 2 },
+	[PAD_GPIO39_E]    = { 0x1d8,  6, 2 },
+	[PAD_GPIO40_E]    = { 0x1d8,  8, 2 },
+	[PAD_GPIO41_E]    = { 0x1d8, 10, 2 },
+	[PAD_GPIO42_E]    = { 0x1d8, 12, 2 },
+	[PAD_GPIO43_E]    = { 0x1d8, 14, 2 },
+	[PAD_GPIO44_E]    = { 0x1d8, 16, 2 },
+	[PAD_GPIO45_E]    = { 0x1d8, 18, 2 },
+	[PAD_GPIO46_E]    = { 0x1d8, 20, 2 },
+	[PAD_GPIO47_E]    = { 0x1d8, 22, 2 },
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
index 000000000000..f21357ee0c20
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
@@ -0,0 +1,1181 @@
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
+#include <linux/of_gpio.h>
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
+#include "../core.h"
+#include "../pinctrl-utils.h"
+#include "../pinmux.h"
+#include "../pinconf.h"
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
+	if (din != GPI_NONE) {
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
+static u32 jh8100_padcfg_ds_from_mA(u32 v)
+{
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		if (v <= jh8100_drive_strength_mA[i])
+			break;
+	}
+	return i << 1;
+}
+
+static int jh8100_get_padcfg_base(struct jh8100_pinctrl *sfp,
+				  unsigned int pin)
+{
+	if (!strcmp(sfp->info->name, JH8100_SYS_E_DOMAIN_NAME)) {
+		if (pin <= PAD_GPIO47_E)
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
+	return doen == GPOEN_ENABLE ?
+		GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
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
+	jh8100_set_one_pin_mux(sfp, gpio,
+			       GPI_NONE, GPOUT_LOW, GPOEN_DISABLE, 0);
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
+			       GPI_NONE, value ? GPOUT_HIGH : GPOUT_LOW,
+			       GPOEN_ENABLE, 0);
+
+	/* disable input, schmitt trigger and bias */
+	jh8100_padcfg_rmw(sfp, gpio,
+			  JH8100_PADCFG_IE | JH8100_PADCFG_SMT |
+			  JH8100_PADCFG_BIAS_MASK, 0);
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
+	u32 dout = (value ? GPOUT_HIGH : GPOUT_LOW) << shift;
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
+static irqreturn_t jh8100_gpio_wake_irq_handler(int irq, void *data)
+{
+	struct jh8100_pinctrl *sfp = data;
+
+	if (!sfp || irq != sfp->wakeup_irq)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
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
+static int jh8100_gpio_irq_setup(struct device *dev, struct jh8100_pinctrl *sfp)
+{
+	struct device_node *np = dev->of_node;
+	struct gpio_irq_chip *girq = &sfp->gc.irq;
+	struct gpio_desc *gpiod;
+	struct irq_desc *desc;
+	irq_hw_number_t hwirq;
+	int i, ret;
+	int dir;
+
+	if (!girq->domain) {
+		sfp->irq_domain = irq_domain_add_linear(np, sfp->gc.ngpio,
+							&irq_domain_simple_ops,
+							sfp);
+	} else {
+		sfp->irq_domain = girq->domain;
+	}
+
+	if (!sfp->irq_domain) {
+		dev_err(dev, "Couldn't allocate IRQ domain\n");
+		return -ENXIO;
+	}
+
+	for (i = 0; i < sfp->gc.ngpio; i++) {
+		int virq = irq_create_mapping(sfp->irq_domain, i);
+
+		irq_set_chip_and_handler(virq, &jh8100_irq_chip,
+					 handle_edge_irq);
+		irq_set_chip_data(virq, &sfp->gc);
+	}
+
+	sfp->wakeup_gpio = of_get_named_gpio(np, "wakeup-gpios", 0);
+
+	if (gpio_is_valid(sfp->wakeup_gpio)) {
+		hwirq = pin_to_hwirq(sfp);
+		sfp->wakeup_irq = irq_find_mapping(sfp->irq_domain, hwirq);
+		desc = irq_to_desc(sfp->wakeup_irq);
+
+		gpiod = gpio_to_desc(sfp->wakeup_gpio);
+		if (!gpiod)
+			return -EINVAL;
+
+		dir = gpiod_get_direction(gpiod);
+		if (!dir) {
+			ret = gpiod_direction_input(gpiod);
+			if (ret) {
+				dev_err_probe(dev, ret,
+					      "unable to set wakeup gpio %d as input\n",
+					      sfp->wakeup_gpio);
+				return ret;
+			}
+		}
+	} else {
+		dev_err(dev, "invalid wakeup gpio: %d\n",
+			sfp->wakeup_gpio);
+		return sfp->wakeup_gpio;
+	}
+
+	if (!(desc->status_use_accessors & IRQ_NOREQUEST)) {
+		device_init_wakeup(dev, 1);
+		ret = devm_request_threaded_irq(dev, sfp->wakeup_irq, NULL,
+						jh8100_gpio_wake_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT |
+						IRQF_SHARED,
+						"wakeup-gpio", sfp);
+		if (ret) {
+			dev_err_probe(dev, ret, "unable to request wake IRQ %d\n",
+				      sfp->wakeup_irq);
+			return ret;
+		}
+	}
+
+	return 0;
+}
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
+	struct device_node *np = dev->of_node;
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
+	if (of_property_read_bool(np, "wakeup-source")) {
+		ret = jh8100_gpio_irq_setup(dev, sfp);
+		if (ret) {
+			return dev_err_probe(dev, ret,
+					     "failed to setup gpio irq wake\n");
+		}
+
+		ret = dev_pm_set_wake_irq(dev, sfp->wakeup_irq);
+		if (ret) {
+			return dev_err_probe(dev, ret,
+					     "failed to enable gpio irq wake\n");
+		}
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
index 000000000000..920cdd8b6376
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -0,0 +1,94 @@
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
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinmux.h>
+
+#define JH8100_SYS_E_DOMAIN_NAME	"jh8100-sys-east"
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
+	int wakeup_gpio;
+	int wakeup_irq;
+	struct irq_domain *irq_domain;
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
+static inline irq_hw_number_t pin_to_hwirq(struct jh8100_pinctrl *sfp)
+{
+	return sfp->wakeup_gpio - sfp->info->gc_base;
+}
+
+int jh8100_pinctrl_probe(struct platform_device *pdev);
+void jh8100_set_gpiomux(struct jh8100_pinctrl *sfp, unsigned int pin,
+			unsigned int din, u32 dout, u32 doen);
+struct jh8100_pinctrl *jh8100_from_irq_desc(struct irq_desc *desc);
+
+#endif /* __PINCTRL_STARFIVE_JH8100_H__ */
-- 
2.43.0


