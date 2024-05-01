Return-Path: <linux-kernel+bounces-164951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE58B855B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611AF1C212E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17A4F1E5;
	Wed,  1 May 2024 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e1qVXIhW"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCCB4CB2B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541573; cv=fail; b=ZzbDMa36k0uc6bSRg6BYVWyo2LQJC589mRYr8dEFAIY2hsY9aosS52pgNuX87YWCTTMW8F1/rqBJl9aO/mpi1mu+Tn1qnN4itGiEYIRX+GNxKgxnucjqZOFtMX5fSAmyb0KMPfxdd/k/MXcp75ncvT//8Q9kul4UmZn6ZkuqIdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541573; c=relaxed/simple;
	bh=cD8zyb2JTqCacVJU/hDe9jgHLyB03yBrDRPXpURABuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TXnydsYeNbpjyv+WfBZIv9e4uxJHydTxMuAd0BB5f8x0Tl3UiYohGFKUO9w3wa1g0XnPHtRjkVA33KTviX2yw441xSxM27V7LIDHOjPA1r6NO71QyL55t/tMRFmCkdaKVo2AABjRSrdEUiimkdOAugGcMfgSELoRazP64JPSo5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e1qVXIhW; arc=fail smtp.client-ip=40.107.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0dKCf0gzSt2y5LTDkJGRKXUBAAbj9zEpDQq6sRXMQnAQaQBTNyB/NcusZ694vysCezHpbkGuPilEsL98Ug65f7+kjgT73YdE6qX7cPDoQSCaJkvXUCJO9cDqjarm3rbWEo2gRcn80GERkI1t7k/QU+Rejh/5ghyCRbew8ippNWo+4jADcYUYBVDzzQxLdcnLn0fVLGQPDD0+FwWpdKPijZrG/DqWcEnxsHQ4sbJ59IkiOBnP2aE8ubv0DMRPoKhsilrn+iHbHA7YTC61b+hohH9iMacq6+G1998qgQ7Fxcl0g4erEI7ac1wE9ZW7vpxx8qHb4vPhPbZZDzBj9rHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZgGzP0D+SRYaz7uBC0SPJ/jBax6W3d2k+CgRnb4yB8=;
 b=ANKgAY1+dmTNVvwa7uGgaWJNo3jn2M9wfOzPoPiqRKfVYNo9SrSpkj+1Z+sbTOK1AVy+NcRn17o3pgwXGtzLw46hm/IH/FvJl7bNkH5qTso+1r7apph907xmeguyPvwXw/he+VO0g8vqvqr96mfcJATFcjQ7mPHBirnMslHY9+KgNN4YihdCropWUsHwjGCjuNd13kfIAs4XjbsvBrlJqrGxtSEVIOUpMMSYvV7x/8Dm3WsQ1p2riiBv7p+xZw8KNvhbLBMTNXfQDC1QddhD9HvBmX28N6s+Ofrg56cXmKWqt1knP7X78JW+8v4ki6J7ZA6zM4ZNvcUTGfaiBbAO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZgGzP0D+SRYaz7uBC0SPJ/jBax6W3d2k+CgRnb4yB8=;
 b=e1qVXIhWpk2U7YfkD9tFKUxvJRO38Tc8uutxOdXaAziaZBq+q65Ub/Oj7ZgSeCf2i/zIEJfgXOJlfVufQ7mJYrqOqPgBZej1cm4mMHpOVOWTyTnTdNrg62pDGRyhBETvCzAqTM3j9Rur7cg2+PrHLTym2sYfLkEeOVzZ1XAD6T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 05:32:48 +0000
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab]) by DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 05:32:48 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-imx@nxp.com,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: Silvano Di Ninno <silvano.dininno@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	frank.li@nxp.com,
	daniel.baluta@nxp.com,
	Vabhav Sharma <vabhav.sharma@nxp.com>,
	Franck LENORMAND <franck.lenormand@nxp.com>
Subject: [PATCH 4/4] arm64: dts: imx8q: Add node for Security Violation
Date: Wed,  1 May 2024 07:32:05 +0200
Message-Id: <20240501053205.1737248-5-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
References: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::20) To DB9PR04MB9354.eurprd04.prod.outlook.com
 (2603:10a6:10:36c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9354:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d89033b-58fe-4050-35cd-08dc69a022cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tq/4kKHzI371tQ6zfVdv6IysBm38GFUgLVyU2MOYYpP9wFaDKco7JDi8VE4X?=
 =?us-ascii?Q?9iWVfm3IWTNj14o8xoBil1MS/hujTDdNRZyi4vuG+BUduQEp7xYcA6Q6sJ07?=
 =?us-ascii?Q?0n9TunLLYcL7v1bFZsLHxFqiyszaFzgAgHIlR+jiOOxZU5/J3RP0HAEZ68Y/?=
 =?us-ascii?Q?+jEoTG8MM3OUX2NCIWKYOPE/xlhn7dhtUOh8n8Y26AQTANLgR9viS6UHhKGS?=
 =?us-ascii?Q?JC7/+nqUQIUmZsAA7L+/K1iVNwxiR0x/GWu5UUZkaOEfrBoHUJB8inbDEDZd?=
 =?us-ascii?Q?QmaFGowZdCtcSJViG2iMC9vkQuZIDxNg6YSTPEahkDIdGMZ0+L6eXqMGCmhj?=
 =?us-ascii?Q?Ozrq/CGVLSox7NPKkvIiQWE22PBFGGb88chhACVZvszZw/Ke93T+GmkmBavX?=
 =?us-ascii?Q?RsPJ6ZMq2fadu8M/iznTijvUvjTc/d4zeR8HNMWrqvjcn7XC7S/8GD6yieXX?=
 =?us-ascii?Q?q219Ouhgl5RjNEqJmV0JhBKOlCofJAi3T771OhEZEl4NByoIT9vO1HWuXAdb?=
 =?us-ascii?Q?MGw3PcKtdwGA+POHvpWitH7ZSO0HoT+yhe4w/NiMMX4I+s8U359OhDI6LXo/?=
 =?us-ascii?Q?/0g3mNUgTPT6AuahMQwBQJJ3KzqD+yDOtCTzd7EV0jrro62EMNupYAJaMgn4?=
 =?us-ascii?Q?atZ/ZgbO6wG+p70eI9BTmCca40dXJN38Ag8qnfOV6SuJtLQ8xmEs6IC7ZG+T?=
 =?us-ascii?Q?ypi83Q8/Ytx40X+heyGYtiMws3g/VNMLA4vKYtiH9C7E1a0Lq2B8xsEhk0/e?=
 =?us-ascii?Q?88UL/oACMRwPKBZ0lLeSPC8yWFPiz6iCZSuid1FncAeYHtCt7PdKi64rSaW8?=
 =?us-ascii?Q?47i2KfAf7TlcRRqAE35lX7F6bkQAEP/XGeHhgMNN5zMDauA/Fh+vPL7h4x2y?=
 =?us-ascii?Q?T0IhS+nozrIwgcnmmmarzeokjohFi3tU9GvHjvAJT1KeeOymlf4V5tJOCzXj?=
 =?us-ascii?Q?u88/E+h5o/88r2gH3HBJP1HCS9vfXMTHnAPJKNyqRR/gAuirozrC7KTL8DMo?=
 =?us-ascii?Q?mKczUrWskEAcLmNGyAEljD0qujEtkzk/iHrnCMtUJczDaJ17DYy1DxrgQOiB?=
 =?us-ascii?Q?IYyjpA/RkUVmF9VbdneSVxsmmxp2c/MWzPh1vNITKiIkySq61AZvFr1sogOV?=
 =?us-ascii?Q?UbU2MICBfEe2aGO74eKY4y1uZu/Lkjiqs6wTNxJriL9WhTwra6G5gxHNAdXE?=
 =?us-ascii?Q?qkhFFHLIfRHYM20Nr3JhTJRsjQNXeAshkPomjZSPW+SaaphnHwEqaZ7urTQO?=
 =?us-ascii?Q?i4Ix1fTT/TxPLLH8LoOmGu+UQMkbUWriVIrwIOOtzOvs+Z0wqs1hUrJxLoFw?=
 =?us-ascii?Q?PXBDknjtP0HEBWTXHyzJTjfiub3yKf2lpzzUeY4I3Shhcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9354.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I0/QsTrmOE0ITnht8NQDkexW7pcfCrHTbZTQ7aCGvAK1GRwm+4y1WejsRisD?=
 =?us-ascii?Q?cO8I2P6Ee3nn4gskeww8Mau9Yg0yLyZbYxO0uMx4arQQzPeNGu6H2q3rRzHZ?=
 =?us-ascii?Q?7+aUcQI4LWxepjbN3/oJBpmbt16DRRYRpGEr/ZKlF65Kv3rqJu+V5rUaQXfz?=
 =?us-ascii?Q?ubFHpWzf2r/CHLhYty7ip5K7uS2N9eab8mbokTXO2hHjRzbHMGzlw1eQe3AV?=
 =?us-ascii?Q?aFkOwbPxPp6d9eDxcyW5W1CbPjJs3xz8ggMlj21f70lP0Rvw3UZaF1paH74p?=
 =?us-ascii?Q?3VyvOhbAc4zAnSQ27uAs/jfYpPfm22VrPswdUl1HU24ECpfpVPlu+lffaCWN?=
 =?us-ascii?Q?WvzuIrMmWnJSynbNR4wwaOUBR+pt7mBuQduROy1IKGs3UwKQKEIVjzUGAqyH?=
 =?us-ascii?Q?O/saDXMKuofg6lbNUx885Y4k4FwD2IhVugEyss0fqkm6+O+wwCfQ4hVFZx3R?=
 =?us-ascii?Q?PbjsmSo9sVtUwJWBUAdtJPVzTYF8Mg1hEk/r6JXr2bNAHIrweJR1LkBe9pdG?=
 =?us-ascii?Q?wbtclHudSdKWkMyJ90Cr+3PtEJmZhjaFz/xbwqd+oILmuC0UbsgoWh99yFVF?=
 =?us-ascii?Q?PYeZrKcszHEHGALRwPfV5zdU5ScP0vE4+5GsIkBNqJ4K2zblzfHEVT1yjZnd?=
 =?us-ascii?Q?oArXgDApYCOJo9pw+K2QLAdsSTJVjU5J+r+ryou/3lGxyyRhLrYAwoZY/On2?=
 =?us-ascii?Q?yYJXju/OefAMNtZpziIxg0xl8Cut8NHUUlwrsLsXLiLS3TRc3nqcmt9YUjq0?=
 =?us-ascii?Q?h9wnza7EANjBW/7cMdQ+MB2G/3B4bosQUqEYLQ/rIWkYosxI28MJIhxZ27b1?=
 =?us-ascii?Q?cmI4ah1A+xEia/94OYZnT4HvmFzXrjKrYItH4s90adOL3Qwp9ysXaF75uv4Y?=
 =?us-ascii?Q?QLUpZrOSj9ny5Hl6To0w9tqgbCws3Ivhh0w4io6Vgn/9fO7RfIpOYse1pNgW?=
 =?us-ascii?Q?J4T82dcwGTI3/q4omphebTYQw5wHWyS+BGLWBDXpsGuawZXumnzMN9/inbEJ?=
 =?us-ascii?Q?wA2ro0sbIP0OHLukvg1t8kB1IsG1LJ+h7fbWh29L7osiROPxcn6umAvlAYLa?=
 =?us-ascii?Q?lYo+G2FY+2zpXb/PzweyRt5itYAXYgTbHwpwbR28wEUbxCK5MB8/GDj/+Gze?=
 =?us-ascii?Q?j0M7oGU5ikCKA+/tCOeJFpTxFPVvPx5pt6KuIA+TPYkAyGY47Dn6bc/yX/bt?=
 =?us-ascii?Q?8IuQ/yn4fa1KLlQamn8f2wCuGwuGi+bmQf2byUq3Jte7IMelmjljYs5tJ2mD?=
 =?us-ascii?Q?AKdPPJbVw6ylr4eKnUINC8VW9RSBCkjtd2ADt0EDQkXb6DDqI1IMuud0iVZN?=
 =?us-ascii?Q?T/Gv6BXLGbQVWHvE566tZTeowSwBXosyx+/GTw+/n51v5ZVKU1X08PtUirOx?=
 =?us-ascii?Q?tsZ8mw8iyWg7/Ot4syVncmFMmnWa0p4910gyDYgDQrFiEHCQrYMvQRIR+Zmo?=
 =?us-ascii?Q?ePG+FNDbFTgx/T74dv7mxh6iaj0aQ52QeMr22vvmie4r00tXcSkdLhf8Xd/A?=
 =?us-ascii?Q?IbgcgG6weVo2s8fMalq+IiM2vUU42LLpogTyZYqcCigNC3Z9+fKrALJbGr8X?=
 =?us-ascii?Q?D9OLo68ChUCI2J6TMED1dSuQ7XHwqxFWVw+5OA2y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d89033b-58fe-4050-35cd-08dc69a022cb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 05:32:48.0908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psCwuK2qpk8hIfKHRE/o7dgM4/n1cDI9Jst5C1KXEpv+2kzcBvyXK3gJaBo7AgZw5rtZuIhJ6sduPOlgE3ArqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

Add secvio node definition for imx8qxp.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 958267b33340..5cd9701d47b9 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -241,6 +241,11 @@ rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
 
+		secvio: secvio {
+			compatible = "fsl,imx-sc-secvio";
+			nvmem = <&ocotp>;
+		};
+
 		watchdog {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;
-- 
2.25.1


