Return-Path: <linux-kernel+bounces-167604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1648BABD4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3821283C77
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A801A152DE2;
	Fri,  3 May 2024 11:48:10 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6F2D047;
	Fri,  3 May 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736889; cv=fail; b=u3XCqypjJzvJIhUSVvFWIWCczajmD+Ox8MymQLXTHfbbsIZtimkfbfPYxIlvFXbyn2gXUt3/NrJTX7swPQee0aEGeEem+X+AciLT0qjLSzG9Ng6XaDck4GkqFr58pssZS7Y1IgqHfjAY1JR/qJKGdch/P8hlb5RqGNpHCvEgrRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736889; c=relaxed/simple;
	bh=o/Wod2U8hAhdsu3bhCQzkZbU9R6FXaQhXn2SqtUa5Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PLtDLfzdPl8FHQyYodvXKk6jh/mPHYRlvhAeIRDLbGfTNSlEdwBlVN0KKWkK0NRize/aAQprgafCMiVGBz4aPxYqTilSn9pfL/5DESplM972DhgxUpg/UtT+FJAV8ZlL/vOTBBSiAp2YMAHHUi9V+/F3u1jdw624JeYRMSvRDg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq6pobkJ+VnTrnfwfi0GzZXMl4YH5b+tdGSe5vqIwhQSn4OUiLd9slAhmdYn9pWEiYisPww+NX1E02zkDqxu1LlCPP3rpCdQbi8MzBgBXMzi4JUELbD+/SQV76SkjzvridqDSGwkkfDmtDYIhpnQy4aMGodX3zSN+dTjS961LW1/6EghCq8TnNFzaq6cTQjFj7U619e9cHIV869RQfNsDFOfWiyp5f14qQmeSZaciRqUdx7bdHhb8vfDxWdCugNSVYntDCPjfA9VJN7vlb2U3V09rvGadEVOU3pmISvloGtkiB2u9JHixPRo5V1uXxrD/7wzvUXlIyM7e8VbcM/elA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+kPXEwFOk6Vk6fj8TZBhGJ/JG1x9D8pU73iMkL4xfE=;
 b=lhsdWqIodwjDnN1Q+onQwgd16Ty4n2OGOE11kTafBFo4Bgd45YR92OnfByao2nHBl0W/ZdpCWIOH0Cxb4/xsr3FNfIhbTj63Sb1x0ZdpeGNS4DfgQVtXvUBK/ral5PGGyLERMPgWc8Rh6TAKGHMPHz2z9e3GQMMrPCG9xGvh0QwbfhzDZMY4vwf9d/sog5zuqUiqCWWlvUo8q02EiK/sxTAzId9ZEjQ0wGEHzQ68cxDtImXEVPEXI3a1SBf9FBbtk/SE6NRmqtsBwYh6lce910uuRzUy9gjaecos0KbAOCmZJOrVTDt6BQkUE7PNKiOywnJDTuCVM0lMs0mcGvCmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) by ZQ0PR01MB1238.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 3 May
 2024 11:14:59 +0000
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 ([fe80::feb4:a4b4:1132:58f4]) by
 ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn ([fe80::feb4:a4b4:1132:58f4%5])
 with mapi id 15.20.7472.044; Fri, 3 May 2024 11:14:59 +0000
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
Subject: [RFC PATCH v3 4/7] pinctrl: starfive: jh8100: add sys_gmac domain sub-driver
Date: Fri,  3 May 2024 19:14:33 +0800
Message-Id: <20240503111436.113089-5-yuklin.soo@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d7faab7-cbef-46ae-ceca-08dc6b624517
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LZxcT0xyLFmYe0ZJJTvXCd09ilen3M5IsP1qhP6c0ayaEhycrIoO/7YnSI0kfUq5j1iwCEsaB1nJvD5B7lRZfA/0rWGeKedsEQhMaG5MNldKCR00R2R4JwvwuJ62VdvXFeElNvsCl6sxeqNcCmWcoQpW8K2xqbDSb0Hjs8TIjGGWe6fgteeIg1WXaz9ZgEA01df/YoPsmpNQ6IpddSHizn4eHn+7nTk0mU4LFZ0ZX3+J3loB+R5qaHPJ8XQAC3Zlh6j0Xmrx1yveKyzH5n4YLhAWz+RknB6FAW2tqr+LMzf3gfS6aE2c6uz2P7hMqsLx9YL7OJGvmaJxJXJA7ujfqY5OnxCOP3VhIXdYk4RhqxJqc5ismJPtkZQAAA+KYvUtXCd0Ql742YP3Ia7+mSlg9K9ZXm+mOZZErMKcJv7ceOo538GV4YV3d9ONs3mezgcun5V2UMpOyvIjmFgcxwDbZTXiKdKkRvnaQvHGud/IjfmzPLn6meTFie3jKahiKjzkIX48zKGfAf011unlKAaJ2uu0vtQZm1xvOdaQVDRDu+zDIDbJdeQ3GthNumMiotv48BZTLoKGk+D7K73IW4nTgbLnvLGmxHBDaIgJxkekl6BxoSCKJiulAAG+qoq1W3ADF6FRmikDy0yJOoXzZdEDfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(41320700004)(7416005)(366007)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnQ7ZEx9FEyHPY+iw38HlOwBhTmLy0IhnlzhEyAy0yETKuljK/HLtMC5TLzz?=
 =?us-ascii?Q?+7SwSwkhRc9bBrNAjkClsbsVODm4mNsZTSAwUWRdXHwn3DQKvIV45LB2Wrx3?=
 =?us-ascii?Q?f3LyeHUgRTvbho+mttjZLnC6tzACZTW3Wcn1G3ue/x8Sczi/NwXEsSR1vIM1?=
 =?us-ascii?Q?4rXkfRjgfnB0uMB0yTs+Up5iCm/fLUf/g1tjVOh/FzEOJ2vgmQMQDxKsrTZ+?=
 =?us-ascii?Q?IwNk8yzu+J2U9YiLyuRp1/4/b1rVUme1aQU3yZWxbx7ioRAwlHZmBXAAur7d?=
 =?us-ascii?Q?NNyu/GnFrU84sWaTHvNk1GwsaZ+xylceo/UAcqK2g/8LWR3GuZTJ2L1+R5ve?=
 =?us-ascii?Q?M62Yi+VLypN8jZ1iTcO1fLmYleK104wAIqjTpelCPnRDV2CwUI4ZW7ueJVr7?=
 =?us-ascii?Q?u+tdUAs6TuT4BqJt1DvQ9ap4Fa68SBM15DZga6cqEAXGomfA9uN49SRKa16c?=
 =?us-ascii?Q?yabQ0vqC7A3lQ5Osk1PcOM8WffPtarWhKVU5kP5IqOe8lWftuCosiAFfuAq6?=
 =?us-ascii?Q?2VO6Yb5wTz3l88NAPsSjEZkkz3pmpcIQwWUR0DkiOJOynnR6Fj4uMn1pWGrl?=
 =?us-ascii?Q?PLvYz56+Tcm4OD5oOYqz2IYrZmXkBlrYG8k8Ax8pYjkAk7AqbrAletnUBjrl?=
 =?us-ascii?Q?Fgu1LIa1jN5/wFH3MgNf//MuUjgMjcj+xn4OKGpM+UmWgDYyNFTO0S5I5PBj?=
 =?us-ascii?Q?5akEhj2k4Fdqmzat/uJ6tj/eaoq1fiJ81po6zbLzLev1tc+4JUxm36Ce9nqp?=
 =?us-ascii?Q?SIcG+s58PJKD/tKEUqbz922yCFtQIlA+k1BBVO0QAmaltnYUzZrzKxnadAuT?=
 =?us-ascii?Q?Uckav4K5J6baagAes5bDLrK6vWZVx4QOn7lCfQoCBEuv0IROJmjZOy842aUD?=
 =?us-ascii?Q?tZ/elYyzeRpDFDu8PtKI9iJxo0n6yknbuxUyD4Q322YSbA1zEbUWvG59pF35?=
 =?us-ascii?Q?KM+jNQqliZ+RqsqekaaCkHTuu702wv4G91T+bHbMUYPyT4cCTdJmp9qH//wO?=
 =?us-ascii?Q?KOIFiJK4JNiGNZAZRcwtJaUWh9ZuVgij8LzrUwu2X9q6+ELqq2409Uu76Rc4?=
 =?us-ascii?Q?EydHvMdBClf58c05iPLuhdJnBqVPc6m/67hTxSSccFE4BwNvLU/KtCTRcbJc?=
 =?us-ascii?Q?fPpjbcLueakN3SJb09OpYAZA8wxh4sAW/ETbA+1mtxcdiwo+GMJ2gi6igA31?=
 =?us-ascii?Q?X1Hfb9BoUIWgS2a0eCf45t4hFki6wQpOsNJKa43AysU9q1+AEftziwgWoFpe?=
 =?us-ascii?Q?2LTFwTcFiScQQPENYWtrrLy99SxF85gsIl4vD0/WRBSep/pFHzmpjTVfmbpE?=
 =?us-ascii?Q?/hM56OuE/xoHSVe1cTb6wBFu81nERCE9O3yEnx/qljdTFkMXjT0e/+vFYw53?=
 =?us-ascii?Q?IQ3sFtwaJr3lm1d2imh6P/iC8Fi1YPq1ARjf2WnWDfAnh3u8ZWp/N7tLM7J5?=
 =?us-ascii?Q?tndBVQ3E7bf4u2UUjdjVMNhi8qerk599ukUgMVaGVw490RoSS5CRgBzzMNIr?=
 =?us-ascii?Q?OgE2GRbIZ5tVvRQMUnNZFTqFmnHFBxdc+F5X/W95ghFyb3TPIGOp4L+M8/nG?=
 =?us-ascii?Q?sa8EsApEgU4gsYtBqSWfJntQDdQaJMJWjhrANHrLXix1JSN1F5nPPh6TOVY1?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7faab7-cbef-46ae-ceca-08dc6b624517
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:14:59.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tws8oIYOsK8q+1inhguB+BWXqv4bNPNo1LCyghpl8xMY3CnQ848v7stb16QyfOpMfqaf3WbvutAOpp3LAlE82oYQCkb4gip4BZ1v4jOqhiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1238

Add sys_gmac domain sub-driver.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 drivers/pinctrl/starfive/Kconfig              | 12 +++
 drivers/pinctrl/starfive/Makefile             |  1 +
 .../pinctrl-starfive-jh8100-sys-gmac.c        | 89 +++++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |  4 +
 4 files changed, 106 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c

diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
index d78f161a636c..bc123c0bf35e 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -82,3 +82,15 @@ config PINCTRL_STARFIVE_JH8100_SYS_WEST
 	  This also provides an interface to the GPIO pins not used by other
 	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
 	  and interrupts on input changes.
+
+config PINCTRL_STARFIVE_JH8100_SYS_GMAC
+	tristate "StarFive JH8100 SoC System IOMUX-GMAC pinctrl and GPIO driver"
+	depends on ARCH_STARFIVE  || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE_JH8100
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support system iomux-gmac pin control on the StarFive JH8100 SoC.
+	  This provides syscon registers to indicate voltage level on SDIO1/GMAC1, to indicate
+	  GMAC1 pads voltage level under different GMAC interface modes, and to configure
+	  GMAC1 interface slew rate.
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive/Makefile
index 784465157ae2..236a693a8aef 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PINCTRL_STARFIVE_JH7110_AON)	+= pinctrl-starfive-jh7110-aon.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100)		+= pinctrl-starfive-jh8100.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_EAST)	+= pinctrl-starfive-jh8100-sys-east.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_WEST)	+= pinctrl-starfive-jh8100-sys-west.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_GMAC)	+= pinctrl-starfive-jh8100-sys-gmac.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c
new file mode 100644
index 000000000000..3758280e3660
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC sys gmac controller
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
+#define JH8100_SYS_G_GC_BASE			-1
+#define JH8100_SYS_G_DOMAIN_NAME		"jh8100-sys-gmac"
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_sys_gmac_pinctrl_suspend(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		sfp->jh8100_sys_gmac_regs[i] = readl_relaxed(sfp->base + (i * 4));
+
+	return pinctrl_force_sleep(sfp->pctl);
+}
+
+static int jh8100_sys_gmac_pinctrl_resume(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		writel_relaxed(sfp->jh8100_sys_gmac_regs[i], sfp->base + (i * 4));
+
+	return pinctrl_force_default(sfp->pctl);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(jh8100_sys_gmac_pinctrl_dev_pm_ops,
+			 jh8100_sys_gmac_pinctrl_suspend,
+			 jh8100_sys_gmac_pinctrl_resume);
+
+static const struct jh8100_pinctrl_domain_info jh8100_sys_gmac_pinctrl_info = {
+	.ngpios		= JH8100_SYS_G_NGPIO,
+	.gc_base	= JH8100_SYS_G_GC_BASE,
+	.name		= JH8100_SYS_G_DOMAIN_NAME,
+	.nregs		= JH8100_SYS_G_REG_NUM,
+};
+
+static const struct of_device_id jh8100_sys_gmac_pinctrl_of_match[] = {
+	{
+		.compatible = "starfive,jh8100-sys-pinctrl-gmac",
+		.data = &jh8100_sys_gmac_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh8100_sys_gmac_pinctrl_of_match);
+
+static struct platform_driver jh8100_sys_gmac_pinctrl_driver = {
+	.probe = jh8100_pinctrl_probe,
+	.driver = {
+		.name = "starfive-jh8100-sys-pinctrl-gmac",
+#ifdef CONFIG_PM_SLEEP
+		.pm = &jh8100_sys_gmac_pinctrl_dev_pm_ops,
+#endif
+		.of_match_table = jh8100_sys_gmac_pinctrl_of_match,
+	},
+};
+module_platform_driver(jh8100_sys_gmac_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for StarFive JH8100 SoC sys gmac controller");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
index 7c7a05c1c828..90eef6417dd7 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -14,12 +14,15 @@
 
 #define JH8100_SYS_W_DOMAIN_NAME	"jh8100-sys-west"
 #define JH8100_SYS_E_DOMAIN_NAME	"jh8100-sys-east"
+#define JH8100_SYS_G_DOMAIN_NAME	"jh8100-sys-gmac"
 
 #define JH8100_SYS_W_NGPIO		16
 #define JH8100_SYS_E_NGPIO		48
+#define JH8100_SYS_G_NGPIO		0
 
 #define JH8100_SYS_W_REG_NUM		44
 #define JH8100_SYS_E_REG_NUM		116
+#define JH8100_SYS_G_REG_NUM		19
 
 #define JH8100_SYS_W_GPO_PDA_00_15_CFG	0x074
 #define JH8100_SYS_E_GPO_PDA_00_47_CFG	0x114
@@ -36,6 +39,7 @@ struct jh8100_pinctrl {
 	const struct jh8100_pinctrl_domain_info *info;
 	unsigned int jh8100_sys_west_regs[JH8100_SYS_W_REG_NUM];
 	unsigned int jh8100_sys_east_regs[JH8100_SYS_E_REG_NUM];
+	unsigned int jh8100_sys_gmac_regs[JH8100_SYS_G_REG_NUM];
 	/* wakeup */
 	struct irq_domain *irq_domain;
 	struct gpio_desc *wakeup_gpio;
-- 
2.25.1


