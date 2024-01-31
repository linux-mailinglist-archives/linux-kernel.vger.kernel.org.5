Return-Path: <linux-kernel+bounces-47106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560C844951
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9488828D553
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED7538FB2;
	Wed, 31 Jan 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="FNBxrBCE"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2080.outbound.protection.outlook.com [40.95.54.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44F381D5;
	Wed, 31 Jan 2024 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.54.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734881; cv=fail; b=jKnifVEss6i7ZWEjt1HD5GW9am77dBaHPimoboRb9MK3OwzNtGDyddnEOaHJ30VtK11F+J8s5w/bnUlqmNOol7eacRCgMC+7kWGLnUyFeP/VPcHmqNku8SoRv8MK37yVg+9/iuS1qhu7kwGDZ0VmZBJ5I2YrlQBbo7RBN//Pw+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734881; c=relaxed/simple;
	bh=VsjhCULXIzr8VInXSCbCv0G06oUY1xXji3KF7l9m00c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOHgZrnScxyFFnxjQwkOoB2uvsvvpQFeOlhJGFNUGWypKaLw5WGf4MhhYSYue+aTXlAWYh0XiinVaUB9XY+koKAUUFpLYYxTiCmsGkduxFltAJH7saSuc/UjZ6zsRqEDWo0Q/bB1v9X5V7WhR5qNunMOHOQ9KXF9GY+NAKGwlmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=FNBxrBCE; arc=fail smtp.client-ip=40.95.54.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHiV3tXeOJwp1W79mkbWEZzgOMDJDqRd1lW89LZKiYJNKd029k2inID1mgL3NUxViSXpzzyHREVNtLOvl24BIwFXRo8lb7gZ3HX+8aHRmX5B0NmUwsAONRg5LydEElYjax5Vim2WJzrpIlBMutFCl0ojIcs2EOsCJEQpbytGrxbIxp9uztuF9QnYx7OOhdTFRe2X7N6rtDGokBVTIGz7VtJLJKpMRhL6VIuNnFVyhXKBO7MCOHII99qMwx4+OGQQ0fwcc1hFXwesysNKa6Bi3toHsE4J+beR0oCQ/8eBH1nibuLZpV6k/lMYIGNjclWJvvwIF65bBtRYY2YxM0iRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgOCG5/CbIgyd72O4YoXxWF1rGUgHbwgv8WcH53pdk0=;
 b=Up030mkeglciIOoMuXfkS8LYhDNA11/clRsdihFkXW/gTYqu3rrWAogtIo+wjvsPypWYazZrGDJesx4mGRB7TeOseXNJEgVPvcqI0A5XTJzBVGDfbMHMUzMoBf9zrSptXhoDPnxZklBvFza01GVXNOeiyymuQ9aSczXXyTMMqDKBZe6ettLwYDPwkfLQ7Nyh4uS/n+OmIkO3mi2Ovp3iaBgyDSu27jRJhUJ0WEmOxCHUu0Szfo1VKCjTNq2d7Czh1Bf6SAmw1fvfbTZTPjXbCYu3ao5oFDx3wYDkraQR7LiLWD+iTAxSMlOP3KYSVrHRaoIHERTCow/vGXXSlHJeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgOCG5/CbIgyd72O4YoXxWF1rGUgHbwgv8WcH53pdk0=;
 b=FNBxrBCEoxUhhyoClwXZOgdFZRTi1l48LJDfZtih00ZaFWhq+LDLbdl+naasaWiv4mqsd1p4wY1nTyNJp4JXrqeflEX5wZyHpbnxLGZ3DuRFBW2G65BNEW8KGzC0tcLrFhUAAp9lm7JxGH2q0xQIrAs5wwYuEbWxbOKnCkrQ7vo=
Received: from PU1PR06CA0023.apcprd06.prod.outlook.com (2603:1096:803:2a::35)
 by JH0PR03MB8352.apcprd03.prod.outlook.com (2603:1096:990:48::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 18:27:12 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:2a:cafe::96) by PU1PR06CA0023.outlook.office365.com
 (2603:1096:803:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 18:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 31 Jan 2024 18:27:12 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Feb
 2024 02:27:09 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 1 Feb
 2024 02:27:08 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 1 Feb 2024 02:27:08 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id B5D6B5F64E;
	Wed, 31 Jan 2024 20:27:07 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id B23E6DC08DB; Wed, 31 Jan 2024 20:27:07 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v23 3/3] clk: npcm8xx: add clock controller
Date: Wed, 31 Jan 2024 20:26:53 +0200
Message-ID: <20240131182653.2673554-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131182653.2673554-1-tmaimon77@gmail.com>
References: <20240131182653.2673554-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|JH0PR03MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: cb467ed7-e4d0-412a-c31b-08dc228a3e27
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	640mlNRWyiTalvlIcAccWTuMKfKuOKl1kJwUoZyvu0kAJM4MLOJzsMATSw7Iv31u1suC1KG37sGl/hN2n/koPTXXC6UqS41e6d2/qVd6AAcbqC7W4w0pIJznsbM6/ywytR23L/NwwGvhqKaz5j2iyyanVZlPJQnpmGhIMVKVOp9wCg1HxvUn1yhEtmSqe2oqA/MAoRP3tcEg+asCtWFcHU49+fEFr6r0FyAwJzz4jkyiIVt7tv5nPXZGT+N1kRlJKewcuYEesM73whexYAPhtQYpFAOMp7DpX4jqLNVtBf4g0OHvesnomj+xp8Xox0cQhnvfE0i5RRyPLHvEy52KFJz7nE+0kFUR6vmn2q+HT2g0jbZ6lgKkkHNAvMUn0fblDS4nOAere3vskTJfbqcvrFPMpKT0FKR6qY47BB0ZEFfUJddph+iiyjI6t6zUEjv/zdN//1inmOeY0ogm2HAlHFqZTuoDLSFGdZ9q9UTRwteRwpnLCVD1SomRrSnZiTCkJIyrARUll/MvAxNlr2i/w9W2GXhIJ/4hjaoO/r3Z5HRxn285ae3H9lz/NrNkhU17aCaeXSeaLas3dOgQ4e1w32+BFCJIKf58egJi+xnqXVdjh2Ecn6k0bMC/NUqPlKbGhXTsjW0wz6WH5K5hnm7DUaxo+1Z0GOnj0PnDAmNzIEAs2c157bJQBHcwsCZX4kkuAx6JqVk0Ux0jqTbEpB1xyjNCMFWoMiTCpng2kUk8lnJ5oOqzX6m0bpZDyBMw0b85gSyqHpvokXpOPF+86Jr42qbliDfx4lMScwmbvHmFTFMlRJgxYJwihzqfye1ML0aCM/W2cYphs6uXpLKdGKBmaOu0LJBPAAwCERjjhuIlx1dYkLX4niAT3FppFHebWxs9
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(82310400011)(64100799003)(61400799012)(451199024)(48200799006)(46966006)(40470700004)(47076005)(6666004)(55446002)(2616005)(1076003)(82202003)(73392003)(498600001)(83380400001)(42882007)(6266002)(40460700003)(26005)(336012)(70206006)(70586007)(356005)(54906003)(83170400001)(110136005)(40480700001)(82740400003)(76482006)(30864003)(2906002)(5660300002)(36756003)(8936002)(8676002)(7416002)(42186006)(316002)(4326008)(81166007)(35950700001)(41300700001)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 18:27:12.1517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb467ed7-e4d0-412a-c31b-08dc228a3e27
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8352

Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller which
generates and supplies clocks to all modules within the BMC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/Kconfig       |   8 +
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm8xx.c | 509 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 518 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 50af5fc7f570..a324678f3e12 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -334,6 +334,14 @@ config COMMON_CLK_LOCHNAGAR
 	  This driver supports the clocking features of the Cirrus Logic
 	  Lochnagar audio development board.
 
+config COMMON_CLK_NPCM8XX
+	tristate "Clock driver for the NPCM8XX SoC Family"
+	depends on ARCH_NPCM || COMPILE_TEST
+	help
+	  This driver supports the clocks on the Nuvoton BMC NPCM8XX SoC Family,
+	  all the clocks are initialized by the bootloader, so this driver
+	  allows only reading of current settings directly from the hardware.
+
 config COMMON_CLK_LOONGSON2
 	bool "Clock driver for Loongson-2 SoC"
 	depends on LOONGARCH || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 14fa8d4ecc1f..584fc82061f8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_MILBEAUT_M10V)	+= clk-milbeaut.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NPCM7XX)	    	+= clk-npcm7xx.o
+obj-$(CONFIG_COMMON_CLK_NPCM8XX)	+= clk-npcm8xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
 obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
new file mode 100644
index 000000000000..eacb579d30af
--- /dev/null
+++ b/drivers/clk/clk-npcm8xx.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton NPCM8xx Clock Generator
+ * All the clocks are initialized by the bootloader, so this driver allows only
+ * reading of current settings directly from the hardware.
+ *
+ * Copyright (C) 2020 Nuvoton Technologies
+ * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
+ */
+
+#define pr_fmt(fmt) "npcm8xx_clk: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#include <dt-bindings/clock/nuvoton,npcm845-clk.h>
+
+/* npcm8xx clock registers*/
+#define NPCM8XX_CLKSEL		0x04
+#define NPCM8XX_CLKDIV1		0x08
+#define NPCM8XX_CLKDIV2		0x2C
+#define NPCM8XX_CLKDIV3		0x58
+#define NPCM8XX_CLKDIV4		0x7C
+#define NPCM8XX_PLLCON0		0x0C
+#define NPCM8XX_PLLCON1		0x10
+#define NPCM8XX_PLLCON2		0x54
+#define NPCM8XX_PLLCONG		0x60
+#define NPCM8XX_THRTL_CNT	0xC0
+
+#define PLLCON_LOKI	BIT(31)
+#define PLLCON_LOKS	BIT(30)
+#define PLLCON_FBDV	GENMASK(27, 16)
+#define PLLCON_OTDV2	GENMASK(15, 13)
+#define PLLCON_PWDEN	BIT(12)
+#define PLLCON_OTDV1	GENMASK(10, 8)
+#define PLLCON_INDV	GENMASK(5, 0)
+
+struct npcm8xx_clk {
+	struct regmap	*clk_regmap;
+	unsigned int	offset;
+	const char	*name;
+	const u32	*table;
+	u32		mask;
+	u8		shift;
+	unsigned long	width;
+	unsigned long	flags;
+	struct clk_hw	hw;
+};
+
+#define to_npcm8xx_clk(_hw) container_of(_hw, struct npcm8xx_clk, hw)
+
+struct npcm8xx_clk_pll_data {
+	const char *name;
+	struct clk_parent_data parent;
+	unsigned int reg;
+	unsigned long flags;
+	struct clk_hw hw;
+};
+
+struct npcm8xx_clk_div_data {
+	u32 reg;
+	u8 shift;
+	u8 width;
+	const char *name;
+	const struct clk_hw *parent_hw;
+	unsigned long clk_divider_flags;
+	unsigned long flags;
+	int onecell_idx;
+	struct clk_hw hw;
+};
+
+struct npcm8xx_clk_mux_data {
+	u8 shift;
+	u32 mask;
+	const u32 *table;
+	const char *name;
+	const struct clk_parent_data *parent_data;
+	u8 num_parents;
+	unsigned long flags;
+	struct clk_hw hw;
+};
+
+/* external clock definition */
+#define NPCM8XX_CLK_S_REFCLK	"refclk"
+
+/* pll definition */
+#define NPCM8XX_CLK_S_PLL0	"pll0"
+#define NPCM8XX_CLK_S_PLL1	"pll1"
+#define NPCM8XX_CLK_S_PLL2	"pll2"
+#define NPCM8XX_CLK_S_PLL_GFX	"pll_gfx"
+
+/* early divider definition */
+#define NPCM8XX_CLK_S_PLL2_DIV2		"pll2_div2"
+#define NPCM8XX_CLK_S_PLL_GFX_DIV2	"pll_gfx_div2"
+#define NPCM8XX_CLK_S_PLL1_DIV2		"pll1_div2"
+
+/* mux definition */
+#define NPCM8XX_CLK_S_CPU_MUX     "cpu_mux"
+
+/* div definition */
+#define NPCM8XX_CLK_S_TH          "th"
+#define NPCM8XX_CLK_S_AXI         "axi"
+
+static struct clk_hw hw_pll1_div2, hw_pll2_div2, hw_gfx_div2, hw_pre_clk;
+static struct npcm8xx_clk_pll_data npcm8xx_pll_clks[] = {
+	{ NPCM8XX_CLK_S_PLL0, { .index = 0 }, NPCM8XX_PLLCON0, 0 },
+	{ NPCM8XX_CLK_S_PLL1, { .index = 0 }, NPCM8XX_PLLCON1, 0 },
+	{ NPCM8XX_CLK_S_PLL2, { .index = 0 }, NPCM8XX_PLLCON2, 0 },
+	{ NPCM8XX_CLK_S_PLL_GFX, { .index = 0 }, NPCM8XX_PLLCONG, 0 },
+};
+
+static const u32 cpuck_mux_table[] = { 0, 1, 2, 7 };
+static const struct clk_parent_data cpuck_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 },
+	{ .hw = &npcm8xx_pll_clks[2].hw }
+};
+
+static const u32 pixcksel_mux_table[] = { 0, 2 };
+static const struct clk_parent_data pixcksel_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[3].hw },
+	{ .index = 0 }
+};
+
+static const u32 default_mux_table[] = { 0, 1, 2, 3 };
+static const struct clk_parent_data default_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 },
+	{ .hw = &hw_pll2_div2 }
+};
+
+static const u32 sucksel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data sucksel_mux_parents[] = {
+	{ .index = 0 },
+	{ .hw = &hw_pll2_div2 }
+};
+
+static const u32 mccksel_mux_table[] = { 0, 2 };
+static const struct clk_parent_data mccksel_mux_parents[] = {
+	{ .hw = &hw_pll1_div2 },
+	{ .index = 0 }
+};
+
+static const u32 clkoutsel_mux_table[] = { 0, 1, 2, 3, 4 };
+static const struct clk_parent_data clkoutsel_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 },
+	{ .hw = &hw_gfx_div2 },
+	{ .hw = &hw_pll2_div2 }
+};
+
+static const u32 gfxmsel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data gfxmsel_mux_parents[] = {
+	{ .index = 0 },
+	{ .hw = &npcm8xx_pll_clks[2].hw }
+};
+
+static const u32 dvcssel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data dvcssel_mux_parents[] = {
+	{ .index = 0 },
+	{ .hw = &npcm8xx_pll_clks[2].hw }
+};
+
+static const u32 default3_mux_table[] = { 0, 1, 2 };
+static const struct clk_parent_data default3_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 }
+};
+
+static struct npcm8xx_clk_mux_data npcm8xx_muxes[] = {
+	{ 0, 7, cpuck_mux_table, NPCM8XX_CLK_S_CPU_MUX, cpuck_mux_parents,
+		ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL },
+	{ 4, 3, pixcksel_mux_table, "gfx_pixel_mux", pixcksel_mux_parents,
+		ARRAY_SIZE(pixcksel_mux_parents), 0 },
+	{ 6, 3, default_mux_table, "sd_mux", default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 8, 3, default_mux_table, "uart_mux", default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 10, 3, sucksel_mux_table, "serial_usb_mux", sucksel_mux_parents,
+		ARRAY_SIZE(sucksel_mux_parents), 0 },
+	{ 12, 3, mccksel_mux_table, "mc_mux", mccksel_mux_parents,
+		ARRAY_SIZE(mccksel_mux_parents), 0 },
+	{ 14, 3, default_mux_table, "adc_mux", default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 16, 3, default_mux_table, "gfx_mux", default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 18, 7, clkoutsel_mux_table, "clkout_mux", clkoutsel_mux_parents,
+		ARRAY_SIZE(clkoutsel_mux_parents), 0 },
+	{ 21, 3, gfxmsel_mux_table, "gfxm_mux", gfxmsel_mux_parents,
+		ARRAY_SIZE(gfxmsel_mux_parents), 0 },
+	{ 23, 3, dvcssel_mux_table, "dvc_mux", dvcssel_mux_parents,
+		ARRAY_SIZE(dvcssel_mux_parents), 0 },
+	{ 25, 3, default3_mux_table, "rg_mux", default3_mux_parents,
+		ARRAY_SIZE(default3_mux_parents), 0 },
+	{ 27, 3, default3_mux_table, "rcp_mux", default3_mux_parents,
+		ARRAY_SIZE(default3_mux_parents), 0 },
+};
+
+static struct npcm8xx_clk_div_data npcm8xx_pre_divs[] = {
+	{ NPCM8XX_CLKDIV1, 21, 5, "pre_adc", &npcm8xx_muxes[6].hw, CLK_DIVIDER_READ_ONLY, 0, -1 },
+	{ NPCM8XX_CLKDIV1, 26, 2, "ahb", &hw_pre_clk, CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB },
+};
+
+/* configurable dividers: */
+static struct npcm8xx_clk_div_data npcm8xx_divs[] = {
+	{ NPCM8XX_CLKDIV1, 28, 3, "adc", &npcm8xx_pre_divs[0].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_ADC },
+	{ NPCM8XX_CLKDIV1, 16, 5, "uart", &npcm8xx_muxes[3].hw, 0, 0, NPCM8XX_CLK_UART },
+	{ NPCM8XX_CLKDIV1, 11, 5, "mmc", &npcm8xx_muxes[2].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_MMC },
+	{ NPCM8XX_CLKDIV1, 6, 5, "spi3", &npcm8xx_pre_divs[1].hw, 0, 0, NPCM8XX_CLK_SPI3 },
+	{ NPCM8XX_CLKDIV1, 2, 4, "pci", &npcm8xx_muxes[7].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PCI },
+
+	{ NPCM8XX_CLKDIV2, 30, 2, "apb4", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB4 },
+	{ NPCM8XX_CLKDIV2, 28, 2, "apb3", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB3 },
+	{ NPCM8XX_CLKDIV2, 26, 2, "apb2", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB2 },
+	{ NPCM8XX_CLKDIV2, 24, 2, "apb1", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB1 },
+	{ NPCM8XX_CLKDIV2, 22, 2, "apb5", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB5 },
+	{ NPCM8XX_CLKDIV2, 16, 5, "clkout", &npcm8xx_muxes[8].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_CLKOUT },
+	{ NPCM8XX_CLKDIV2, 13, 3, "gfx", &npcm8xx_muxes[7].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_GFX },
+	{ NPCM8XX_CLKDIV2, 8, 5, "usb_bridge", &npcm8xx_muxes[4].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU },
+	{ NPCM8XX_CLKDIV2, 4, 4, "usb_host", &npcm8xx_muxes[4].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU48 },
+	{ NPCM8XX_CLKDIV2, 0, 4, "sdhc", &npcm8xx_muxes[2].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SDHC },
+
+	{ NPCM8XX_CLKDIV3, 16, 8, "spi1", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI1 },
+	{ NPCM8XX_CLKDIV3, 11, 5, "uart2", &npcm8xx_muxes[3].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UART2 },
+	{ NPCM8XX_CLKDIV3, 6, 5, "spi0", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0 },
+	{ NPCM8XX_CLKDIV3, 1, 5, "spix", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX },
+
+	{ NPCM8XX_CLKDIV4, 28, 4, "rg", &npcm8xx_muxes[11].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG },
+	{ NPCM8XX_CLKDIV4, 12, 4, "rcp", &npcm8xx_muxes[12].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP },
+
+	{ NPCM8XX_THRTL_CNT, 0, 2, NPCM8XX_CLK_S_TH, &npcm8xx_muxes[0].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_TH },
+};
+
+static struct clk_hw *
+npcm8xx_clk_register(struct device *dev, const char *name,
+		     struct regmap *clk_regmap, unsigned int offset,
+		     unsigned long flags, const struct clk_ops *npcm8xx_clk_ops,
+		     const struct clk_parent_data *parent_data,
+		     const struct clk_hw *parent_hw, u8 num_parents,
+		     u8 shift, u32 mask, unsigned long width,
+		     const u32 *table, unsigned long clk_flags)
+{
+	struct npcm8xx_clk *clk;
+	struct clk_init_data init = {};
+	int ret;
+
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = npcm8xx_clk_ops;
+	init.parent_data = parent_data;
+	init.parent_hws = parent_hw ? &parent_hw : NULL;
+	init.num_parents = num_parents;
+	init.flags = flags;
+
+	clk->clk_regmap = clk_regmap;
+	clk->hw.init = &init;
+	clk->offset = offset;
+	clk->shift = shift;
+	clk->mask = mask;
+	clk->width = width;
+	clk->table = table;
+	clk->flags = clk_flags;
+
+	ret = devm_clk_hw_register(dev, &clk->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &clk->hw;
+}
+
+static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct npcm8xx_clk *pll = to_npcm8xx_clk(hw);
+	unsigned long fbdv, indv, otdv1, otdv2;
+	unsigned int val;
+	u64 ret;
+
+	if (parent_rate == 0) {
+		pr_debug("%s: parent rate is zero\n", __func__);
+		return 0;
+	}
+
+	regmap_read(pll->clk_regmap, pll->offset, &val);
+
+	indv = FIELD_GET(PLLCON_INDV, val);
+	fbdv = FIELD_GET(PLLCON_FBDV, val);
+	otdv1 = FIELD_GET(PLLCON_OTDV1, val);
+	otdv2 = FIELD_GET(PLLCON_OTDV2, val);
+
+	ret = (u64)parent_rate * fbdv;
+	do_div(ret, indv * otdv1 * otdv2);
+
+	return ret;
+}
+
+static const struct clk_ops npcm8xx_clk_pll_ops = {
+	.recalc_rate = npcm8xx_clk_pll_recalc_rate,
+};
+
+static u8 npcm8xx_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct npcm8xx_clk *mux = to_npcm8xx_clk(hw);
+	u32 val;
+
+	regmap_read(mux->clk_regmap, mux->offset, &val);
+	val = val >> mux->shift;
+	val &= mux->mask;
+
+	return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
+}
+
+static const struct clk_ops npcm8xx_clk_mux_ops = {
+	.get_parent = npcm8xx_clk_mux_get_parent,
+};
+
+static unsigned long npcm8xx_clk_div_get_parent(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct npcm8xx_clk *div = to_npcm8xx_clk(hw);
+	unsigned int val;
+
+	regmap_read(div->clk_regmap, div->offset, &val);
+	val = val >> div->shift;
+	val &= clk_div_mask(div->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, NULL, div->flags,
+				   div->width);
+}
+
+static const struct clk_ops npcm8xx_clk_div_ops = {
+	.recalc_rate = npcm8xx_clk_div_get_parent,
+};
+
+static int npcm8xx_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
+	struct clk_hw_onecell_data *npcm8xx_clk_data;
+	struct device *dev = &pdev->dev;
+	struct regmap *clk_regmap;
+	struct clk_hw *hw;
+	unsigned int i;
+
+	npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
+							 NPCM8XX_NUM_CLOCKS),
+					GFP_KERNEL);
+	if (!npcm8xx_clk_data)
+		return -ENOMEM;
+
+	clk_regmap = syscon_node_to_regmap(parent_np);
+	of_node_put(parent_np);
+	if (IS_ERR(clk_regmap))
+		return dev_err_probe(dev, PTR_ERR(clk_regmap), "Can't register clock map\n");
+
+	npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
+
+	for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
+		npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	/* Register plls */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_pll_clks); i++) {
+		struct npcm8xx_clk_pll_data *pll_clk = &npcm8xx_pll_clks[i];
+
+		hw = npcm8xx_clk_register(dev, pll_clk->name, clk_regmap,
+					  pll_clk->reg, pll_clk->flags,
+					  &npcm8xx_clk_pll_ops, &pll_clk->parent,
+					  NULL, 1, 0, 0, 0, NULL, 0);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register pll\n");
+		pll_clk->hw = *hw;
+	}
+
+	/* Register fixed dividers */
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL1_DIV2,
+					       NPCM8XX_CLK_S_PLL1, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register fixed div\n");
+	hw_pll1_div2 = *hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL2_DIV2,
+					       NPCM8XX_CLK_S_PLL2, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register pll2 div2\n");
+	hw_pll2_div2 = *hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL_GFX_DIV2,
+					       NPCM8XX_CLK_S_PLL_GFX, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register gfx div2\n");
+	hw_gfx_div2 = *hw;
+
+	/* Register muxes */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
+		struct npcm8xx_clk_mux_data *mux_data = &npcm8xx_muxes[i];
+
+		hw = npcm8xx_clk_register(dev, mux_data->name, clk_regmap,
+					  NPCM8XX_CLKSEL, mux_data->flags,
+					  &npcm8xx_clk_mux_ops,
+					  mux_data->parent_data, NULL,
+					  mux_data->num_parents,
+					  mux_data->shift, mux_data->mask, 0,
+					  mux_data->table, 0);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register mux\n");
+		mux_data->hw = *hw;
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, "pre_clk",
+					       NPCM8XX_CLK_S_CPU_MUX, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register pre clk div2\n");
+	hw_pre_clk = *hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI,
+					       NPCM8XX_CLK_S_TH, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register axi div2\n");
+	npcm8xx_clk_data->hws[NPCM8XX_CLK_AXI] = hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, "atb", NPCM8XX_CLK_S_AXI, 0,
+					       1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register atb div2\n");
+	npcm8xx_clk_data->hws[NPCM8XX_CLK_ATB] = hw;
+
+	/* Register clock pre dividers specified in npcm8xx_divs */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_pre_divs); i++) {
+		struct npcm8xx_clk_div_data *div_data = &npcm8xx_pre_divs[i];
+
+		hw = npcm8xx_clk_register(dev, div_data->name, clk_regmap,
+					  div_data->reg, div_data->flags,
+					  &npcm8xx_clk_div_ops, NULL,
+					  div_data->parent_hw, 1,
+					  div_data->shift, 0, div_data->width,
+					  NULL, div_data->clk_divider_flags);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register pre div table\n");
+		div_data->hw = *hw;
+
+		if (div_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
+	}
+
+	/* Register clock dividers specified in npcm8xx_divs */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
+		struct npcm8xx_clk_div_data *div_data = &npcm8xx_divs[i];
+
+		hw = npcm8xx_clk_register(dev, div_data->name, clk_regmap,
+					  div_data->reg, div_data->flags,
+					  &npcm8xx_clk_div_ops, NULL,
+					  div_data->parent_hw, 1,
+					  div_data->shift, 0, div_data->width,
+					  NULL, div_data->clk_divider_flags);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register div table\n");
+
+		if (div_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   npcm8xx_clk_data);
+}
+
+static const struct of_device_id npcm8xx_clk_dt_ids[] = {
+	{ .compatible = "nuvoton,npcm845-clk", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, npcm8xx_clk_dt_ids);
+
+static struct platform_driver npcm8xx_clk_driver = {
+	.probe  = npcm8xx_clk_probe,
+	.driver = {
+		.name = "npcm8xx_clk",
+		.of_match_table = npcm8xx_clk_dt_ids,
+	},
+};
+
+static int __init npcm8xx_clk_driver_init(void)
+{
+	return platform_driver_register(&npcm8xx_clk_driver);
+}
+arch_initcall(npcm8xx_clk_driver_init);
+
+static void __exit npcm8xx_clk_exit(void)
+{
+	platform_driver_unregister(&npcm8xx_clk_driver);
+}
+module_exit(npcm8xx_clk_exit);
+
+MODULE_DESCRIPTION("Clock driver for Nuvoton NPCM8XX BMC SoC");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_LICENSE("GPL v2");
+
-- 
2.34.1


