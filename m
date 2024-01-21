Return-Path: <linux-kernel+bounces-32051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D18355C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027901C20D06
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C73374EC;
	Sun, 21 Jan 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HL8piWul"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2010.outbound.protection.outlook.com [40.92.107.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3743C36B11;
	Sun, 21 Jan 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705840999; cv=fail; b=Jm4bGHh4V1XYqJm5mkqOS4XbWrV63h9+bRQ7OS72v1lj/xCDHOtlnVu+z8j8DVJA7CikrvrgGtSYarSvtuTht7GAro4PZx4hGB4W3e/Uw14ANsgBCV4sp7c7+wmfFHBABd1ztrctwZDRG21BepwUktSqYBKQbn89kjSp8eBgctU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705840999; c=relaxed/simple;
	bh=jf+V2ehhSFMY9EC/5lReOyz0z3eL5GBjZ/28bznQ0ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JltveNZFCUJbTWU0/7kSFe9AWAmmIPLCa9Cg1xJ+WjtJanpI7UAgEAqcGiHrf6mnLkjDVdFV/MgMikoIbsbfTRggu4hKZW2aGAPgYZYaxWaSjTkGW8grgwGI0TWogHDGJ3d40dWuy+2geSLHa0RTt3b74LzUkKSX38T9NqXSrbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HL8piWul; arc=fail smtp.client-ip=40.92.107.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hibBk8iisnmc3Usum+U4LJSottmV2RmykDa6t3oIZeRmgDok24DUmW7D37BqKdurafXPH/kJHmfK6vma5xxsRxzjTdlAtwZygfDARKBvirzxXcQkeCHypc/ISWeBGQE5+OC4lHCNryyrqJHyy3LoaZ2cxZGJweVbALI8x9ji38Nsriz7FSvPVJ3O9X75KHccLwnV9T49/Pogyq8soHq+iPAocarnLJa6AiETT/TzBm7/+Z8/tZh89VyAO09p8ItxdXOy2ZyCn2RdFmLIey+eRoS+xXDrxjiuvnH6sxOtHkqbGq1nqmkPZCgEoHnjWI3B3Xiw/qoaPnNJRhXrrpmXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls5iZk9+6AOKEwoiGEMApJrlGG7kLp4Iq7ZOGLzRpTA=;
 b=XG1PqwC17gDZzOU/1QoPLgfsaFEyGmHjVrjTRL6f0PevNAvqi5agI0jJWoROfCMqHP1cR/oBRaxvUh08uBNRNQ8W1TeFrhSAEPASJqa6wI5tF8kTznt+b0rW8ps1CsozKtcLF9tpgDqSKuRti5AlLTUXA8XuRnbQmvSmtZxhGKkvJoOZk29GRCCUOBlKpBEIL4gcztuk49VPNc4+ln1a5ya06yLPe+m+hDQl6A+VfPqyF/1/1VWN7fKMebee4jePHeffbKPBuKg/0ltghaAeAS4UvB4spx6FNCNQxkSwvznuwsjEcjPj/JB7hrl/iDTliIX9hyyy94bstV8kOEWsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls5iZk9+6AOKEwoiGEMApJrlGG7kLp4Iq7ZOGLzRpTA=;
 b=HL8piWul2F72faocLghHTwQHlpRqGt4wrnv6NlCCLPTTYMOcFC+f6EUOmCaj9AMEoNusubr9mjx3eL7Y8kTnbteLEcM4qqfKEHVDbPZ2ps99apDGxcq0Xk8y2ENVvdlpKXLbWwI08RQmT7f+ANtopA1IIOwabg4bbxBHf66fNgq27e+2uNGbne5pdmH10Y92iIPe6+a+cd8zK3qOIOJuHlFMrfce5YG0wGRHPI3JTHYOQwqQqbPCRwCHFIgu2hFYqiCi2R9z/v5WHx9ay14B3CDLeWirV339Bke9SV3EV94btb3ET87NV+MqglGXR/BDVI2KJ9I+l3NWEHLTymhH/w==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by OSQPR01MB6119.apcprd01.prod.exchangelabs.com
 (2603:1096:604:27b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 12:43:13 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0%7]) with mapi id 15.20.7181.019; Sun, 21 Jan 2024
 12:43:13 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 3/8] net: stmmac: Introduce Qualcomm IPQ50xx DWMAC driver
Date: Sun, 21 Jan 2024 20:42:32 +0800
Message-ID:
 <TYZPR01MB5556B8833322A83632709631C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [TWmxGVjBcn4YOFc3SDNoL+zyIrEoNbHonA/dHyOJ6qeYK5wOx8if/w==]
X-ClientProxiedBy: PH8PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::26) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20240121124237.3328702-3-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|OSQPR01MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: abab521f-d649-48f3-f2f6-08dc1a7e87fc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rd50zM/Gwtvp5byiDmAvgjydkmjjWpmxkJi5uPS5Lh44CChrt57o/tWwOBklerMpHAQQLssR34YBSQcnMyKSaAqXNLxDcTyrD2TmK3TW9ry7xQEjua9Fy/iZ8MaB6irmhw+tBCQ9tJnhr1IZMAQ227P5reDCgNF8666uwEn9FGF7n1aksr0Vxi/P6AiBsdmkLzGImr0fIDAer1OXWBFt1TXTqc3XjEFgNwuJ8vWvVqjUEugdzFHBoUiCiHRCxf3UQeBW2dSq+vNU2XrOSixc8QS7y0h7mtNdgBjMLa3pYpCOBk0fFYV+JxV+atNTjqwcgJJfhwxR1TQ9myn4C6Y855NnwgEldqjPesT8pB0sVkhWcwjuAmevvKXMFZaeNlsX9W7kY1futxx6+kWJYY+VXLZ4bb3Sc5/J8XmU3DgmRl0aWp0zo1IVD81FTC8kUJE/dEnabufBV7X27HvOYLSJaWPv6eZNt7Vu6MCQRBYNCSN99wyo8SGHCk0Fbmuqlv+ULJxn/+rGbRJ0muR8Caw/hIAS9OMJ7rPmS6/0RU/Hf5OiwTBjbIdtbFTOSHWHCKkHp0+tAXurK8beUYuYfbn9OvEbPanjPwyegoYlzYzbV30=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j+4enaxO3PM6PIQWpgkjQKzkMN8wAnEbI1sQVow2JEX8dZAwbQg5zEkhPi58?=
 =?us-ascii?Q?69EKs5CLCrOWrsoxSoW3pMNxMEpbBAAQgzj8REOe33VgiiLQ7xa1iZS3OxVP?=
 =?us-ascii?Q?BswgYPPya6Q2mlqU50+OyCjyhiI/YDGDzNaikf57wjV1DHtYodRHeLXIGGJF?=
 =?us-ascii?Q?mRS2c3nuMR+G/05K+tDwFifjsTwwmjG/ZPtAfhtrNVwZb2TyLJ7VtAzLc8KF?=
 =?us-ascii?Q?p0Vu238Ipd6Wn74HiZw1EusVlHYeJA50811jbj97Dk/nOiuknRTAW2kdZKql?=
 =?us-ascii?Q?lcoGuHOy854lUcx4HGEL9rrzBIaWuffi3YuZiM3d4MIoefAHXM49bpQHpOkS?=
 =?us-ascii?Q?hMK4GRG95hvLgF8CB4OCq48hOoukfXUCtEDOif9fO0qN2gFMFeED3pReX1M6?=
 =?us-ascii?Q?mkT2BoIeZiRKbOHdsXr1W6nUiebHkXrFkkt3x6zNB2+2a4oFK2WLDwZhx4wa?=
 =?us-ascii?Q?cxxeFmeoq9DP5e5i99CtRNuT29ZVHiDsNHO1DSW1/zG56Dcv1hXCIwwTzkYX?=
 =?us-ascii?Q?TLFCoAD4l0hHRNpBH4Nerc98dNeB6vptwXt0Uxim0rT67CA5+edsqRl+j1s4?=
 =?us-ascii?Q?v+SQEszTKGyl5nXfXj+Odc9C6P3fzMSzX2myGKWVdWWA53/AcZv/7qSNH5gM?=
 =?us-ascii?Q?bGbP839Umj9AHJ9FjDcEMNhJOoVJIIg3tGRdyg90Pn6SPN6aZwCu5iIiRzZA?=
 =?us-ascii?Q?6ZerWO6cLOaoxd5aBGTjJ5QavQKn5VSDgS6RqFIEvNhp6Rcjaqubskd/rLEH?=
 =?us-ascii?Q?QIpW7f1FAfljBBCxZDkJ8ZfDSzqwAe+kOFKezAPN6FtyyLooFAraot1iM3p8?=
 =?us-ascii?Q?mzcIxI3pEBURVD+xVv2HiyVEj26Ocmf5M6cyUU/WJG3umwr3J1V7OCWO1s6B?=
 =?us-ascii?Q?bdz8h4VyCNa5PAD9jATprZ7MGLVVtSTB+Xd4NC7ZnVwUijlNlxVJ7AxCl1SD?=
 =?us-ascii?Q?aMh6bFLwwbwiCeuicbtyyisJjADKmDv5q3XMpnDOVOTyi3HwK6FMXCnjzk2C?=
 =?us-ascii?Q?MuoLY25P3CP2i9SXtHSC6yc2wqG+Irt04jIIAidJMjNRcqcVxSR3bIisTSPp?=
 =?us-ascii?Q?SVGeEheRIuTcZILRBLBPUwlsvMDnCPn8A6BK+v/9qOGPitpsUd4Bm2eaJB3+?=
 =?us-ascii?Q?qoI6Y3CqeAj77bhOst01em8Xm7Onz6ixtotDStVlixc9pv4fjqBQeZ7l5S/A?=
 =?us-ascii?Q?VXXUd+bQAOfhKjxIvfwk1hlIYNKu2TBCi6OrSdwqRkGIs0u/0oyS7f1G9WNe?=
 =?us-ascii?Q?qwOyTt4X4gdIAD3vTSfW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abab521f-d649-48f3-f2f6-08dc1a7e87fc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 12:43:13.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6119

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   7 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-ipq50xx.c   | 155 ++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq50xx.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 06c6871f8788..baf6601d759c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -78,6 +78,13 @@ config DWMAC_INGENIC
 	  device driver. This driver is used on for the Ingenic SoCs
 	  MAC ethernet controller.
 
+config DWMAC_IPQ50XX
+	tristate "Qualcomm IPQ50xx DWMAC driver"
+	default ARCH_QCOM
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	help
+	  Support for the Qualcomm IPQ50xx DWMAC.
+
 config DWMAC_IPQ806X
 	tristate "QCA IPQ806x DWMAC support"
 	default ARCH_QCOM
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 5b57aee19267..eec4405d76d2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -15,6 +15,7 @@ stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
 obj-$(CONFIG_STMMAC_PLATFORM)	+= stmmac-platform.o
 obj-$(CONFIG_DWMAC_ANARION)	+= dwmac-anarion.o
 obj-$(CONFIG_DWMAC_INGENIC)	+= dwmac-ingenic.o
+obj-$(CONFIG_DWMAC_IPQ50XX)	+= dwmac-ipq50xx.o
 obj-$(CONFIG_DWMAC_IPQ806X)	+= dwmac-ipq806x.o
 obj-$(CONFIG_DWMAC_LPC18XX)	+= dwmac-lpc18xx.o
 obj-$(CONFIG_DWMAC_MEDIATEK)	+= dwmac-mediatek.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq50xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq50xx.c
new file mode 100644
index 000000000000..de8e9a0b2cb6
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq50xx.c
@@ -0,0 +1,155 @@
+#include <linux/clk.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/stmmac.h>
+
+#include "stmmac_platform.h"
+
+enum {
+	IPQ50XX_GMAC_CLK_SYS,
+	IPQ50XX_GMAC_CLK_CFG,
+	IPQ50XX_GMAC_CLK_AHB,
+	IPQ50XX_GMAC_CLK_AXI,
+	IPQ50XX_GMAC_CLK_RX,
+	IPQ50XX_GMAC_CLK_TX,
+	IPQ50XX_GMAC_CLK_PTP,
+};
+
+static const struct clk_bulk_data ipq50xx_gmac_clks[] = {
+	[IPQ50XX_GMAC_CLK_SYS]	= { .id = "sys" },
+	[IPQ50XX_GMAC_CLK_CFG]	= { .id = "cfg" },
+	[IPQ50XX_GMAC_CLK_AHB]	= { .id = "ahb" },
+	[IPQ50XX_GMAC_CLK_AXI]	= { .id = "axi" },
+	[IPQ50XX_GMAC_CLK_RX]	= { .id = "rx" },
+	[IPQ50XX_GMAC_CLK_TX]	= { .id = "tx" },
+	[IPQ50XX_GMAC_CLK_PTP]	= { .id = "ptp" },
+};
+
+struct ipq50xx_gmac {
+	struct device *dev;
+	struct clk_bulk_data clks[ARRAY_SIZE(ipq50xx_gmac_clks)];
+	struct reset_control *rst;
+	struct phy *uniphy;
+};
+
+static int ipq50xx_gmac_powerup(struct net_device *ndev, void *priv)
+{
+	struct ipq50xx_gmac *gmac = priv;
+	int ret;
+
+	ret = phy_init(gmac->uniphy);
+	if (ret)
+		return ret;
+
+	ret = phy_power_on(gmac->uniphy);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void ipq50xx_gmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
+{
+	struct ipq50xx_gmac *gmac = priv;
+	unsigned long rate;
+
+	switch(speed) {
+		case SPEED_10:
+			rate = 2500000;
+			break;
+		case SPEED_100:
+			rate = 25000000;
+			break;
+		case SPEED_1000:
+			rate = 125000000;
+			break;
+		case SPEED_2500:
+			rate = 312500000;
+			break;
+		default:
+			dev_err(gmac->dev, "Unsupported speed: %d\n", speed);
+			rate = 125000000;
+			break;
+	}
+
+	clk_set_rate(gmac->clks[IPQ50XX_GMAC_CLK_RX].clk, rate);
+	clk_set_rate(gmac->clks[IPQ50XX_GMAC_CLK_TX].clk, rate);
+	phy_calibrate(gmac->uniphy);
+}
+
+static int ipq50xx_gmac_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stmmac_resources stmmac_res;
+	struct plat_stmmacenet_data *plat_dat;
+	struct ipq50xx_gmac *gmac;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get stmmac platform resources\n");
+
+	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR_OR_NULL(plat_dat))
+		return dev_err_probe(dev, PTR_ERR(plat_dat),
+				     "failed to parse stmmac dt parameters\n");
+
+	gmac = devm_kzalloc(dev, sizeof(*gmac), GFP_KERNEL);
+	if (!gmac)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to allocate priv\n");
+
+	gmac->dev = dev;
+
+	memcpy(gmac->clks, ipq50xx_gmac_clks, sizeof(gmac->clks));
+	ret = devm_clk_bulk_get_optional(dev, ARRAY_SIZE(gmac->clks), gmac->clks);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to acquire clocks\n");
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(gmac->clks), gmac->clks);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable clocks\n");
+
+	gmac->rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR_OR_NULL(gmac->rst))
+		return dev_err_probe(dev, PTR_ERR(gmac->rst),
+				     "failed to acquire reset\n");
+
+	ret = reset_control_reset(gmac->rst);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to reset\n");
+
+	gmac->uniphy = devm_phy_optional_get(dev, "uniphy");
+	if (IS_ERR(gmac->uniphy))
+		return dev_err_probe(dev, PTR_ERR(gmac->uniphy),
+				     "failed to acquire uniphy\n");
+
+	plat_dat->bsp_priv = gmac;
+	plat_dat->serdes_powerup = ipq50xx_gmac_powerup;
+	plat_dat->fix_mac_speed = ipq50xx_gmac_fix_speed;
+
+	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id ipq50xx_gmac_dwmac_match[] = {
+	{ .compatible = "qcom,ipq50xx-gmac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ipq50xx_gmac_dwmac_match);
+
+static struct platform_driver ipq50xx_gmac_dwmac_driver = {
+	.probe = ipq50xx_gmac_probe,
+	.driver = {
+		.name		= "ipq50xx-gmac-dwmac",
+		.of_match_table	= ipq50xx_gmac_dwmac_match,
+	},
+};
+module_platform_driver(ipq50xx_gmac_dwmac_driver);
+
+MODULE_DESCRIPTION("Qualcomm IPQ50xx DWMAC driver");
+MODULE_AUTHOR("Ziyang Huang <hzyitc@outlook.com>");
-- 
2.40.1


