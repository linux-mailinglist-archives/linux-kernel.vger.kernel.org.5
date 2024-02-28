Return-Path: <linux-kernel+bounces-84622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AA886A91C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E608B23684
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5852560B;
	Wed, 28 Feb 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WbgPIxOh"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DE28DAE;
	Wed, 28 Feb 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106029; cv=fail; b=nP1PiCeFtUxElEC4ECexYoAn8ez1rgouz+SxsNjre2ZltT9/cUq6xCucfNO1AItK6b12DwNE2md8RumK7/gCjuOtGr6zFTcJ5qyK0B9e2QhqemfHQeZYpBrn1QH7VZh6ZPGIJHH3yuB6R+TNR1uQesA2rS1DtzvHah635sY11WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106029; c=relaxed/simple;
	bh=fDE9BWjTxN0JFNMOAlkEvZ2Xp4/m3vom/AAIEN+mkLY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HLI85iHOqMmnaN91r6s0OtybLdvfIRabJgDNVk51kk+3OSCrhTay7jJypQ9GA+HJw3dW5zoiD6yEnfzzolcGXedrlzlDSydUmYdW40ncNUhiDmQmoTFP0Vm9nTdG1HaTE5PgVlq9Fp++NsgRf2TOGa4FJAAOovrVv+hjp0BuWoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WbgPIxOh; arc=fail smtp.client-ip=40.107.249.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjMm0JyscwSEnygRYOQwh1S601ofR1431aCjmeAyv6ACDsY5VNWvnxu00YZ6OKnzUMHqN5HtsNp2uPi2O38ekrwjvhcijFAadj7eFfxlihuTkOPTJLDrOyCg9UVrIJRQuGyVhhvZbT/5+gqOhbvdHMI2iCrWqNkoF1uWv8JbmBvL/OEiH7SwIAmv5nMiv9L7/p7X5jHgb+HHidPiwtBHr3unnxjUwbAqNlPi7Z26b+Mg0vPpc6g1jts+YCG/roWCTOy+gg9luuEyGgSNhBWnUsMJsl5R7fEOQbMlAPwYbdciKSBvjCuE+jKG/JgKZVEbtjYbm55sJv4VF5gomp/Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWFZDVTupKRHqGzPzOcozEj38Hip9TgR0m5LQhPIOCE=;
 b=CLFuLarM5sJu2Ho46ztOP9e/EsHLmsyp23UBC0/5EJ0bZN+hkMlaabSaVm/a2rLTfVuKE1SUpou3YoFusWfYQmcholXJQdmVjfWU56GGwdfI0ceRG0jYAyDMedUy6w4V4oYyf8wlr9kKFy5Uu2vdr+hUByYEC44Yw6JprDb/njDiYf9er/5QDipAYqZcvGR6GOe7Oh2tM61gEqSL+iZbfyI00Y8H1xntbCZIKTJ4fCVZZPevLoQsRM18bYhErs0dvDrzdb5JwYzDr0OGB/gXsF1XyB4OGBUYO1bqGTlW0yx1pZAOlTXp78iRCR8hOYdUXQRwC2z0Os9P0qW+YJdq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWFZDVTupKRHqGzPzOcozEj38Hip9TgR0m5LQhPIOCE=;
 b=WbgPIxOhtF/xLxNuDsBnO/AH4yrCbfnjT/eYmgojOqlACCLSoiM/5EgocY3V0bTDGg/0yTu8osHfFhHdNcyfBceGZHTZJHJE7VDxSP4RMNvcqXYLu01+4bELIpRmQyeR8AJQV8s7PvQSj6rr349RbWcw/qAP7L+auBF543RN3fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB9015.eurprd04.prod.outlook.com (2603:10a6:20b:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Wed, 28 Feb
 2024 07:40:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 07:40:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 28 Feb 2024 15:48:23 +0800
Subject: [PATCH v3 2/2] clk: imx: add i.MX95 BLK CTL clk driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-imx95-blk-ctl-v3-2-40ceba01a211@nxp.com>
References: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
In-Reply-To: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709106512; l=13492;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xdgyrgvjxybTyzDq8X/GTHuUjGIxReFNUQBlt7Wg4qY=;
 b=s1mN217LUoxdplJx26CqjKjkkixa+18xKYDuyjKDIvC6lT6VIomKJ92GD7/TMAHqRqJbDgxXc
 JBUFHrp1tRTD5MJXuzyi4v86S3KG3cTTGwHN2R2dY+Enos5qrqTxWYe
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e5eef1-1a28-4caa-83d4-08dc38308623
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z1Ip5yM3PSPTqdYEFX3OwCbkTiHen1i26pv3NFRvU+1yN9LnR5MRBmba4uF0J6mGZEX5OFM/1WwRKrnIh+b4Neq2CLdmb6se2zJq5z3O89Hc3c/ZRSO4Mg/BNkFmKIeYM3KXsN9hagmEwIN+jutRylK80cRBOyXXQXPdKyguordMQf4WmnvybA0Mm/YRSjPKOYGDI3IPBrzc44dMSYfT/3/b1IoYzqcT9x634jxStHGnVfRIos/xAht6uhP9gzWniHVf0DeFGAOHk9cw9if80iNu8sbA6sUqoGzoDv1Kt1F701XepphqzuxPK6GPZmFfJU6Zpw2zW3uMQuzPCetPUn+lsVCX7hDaTDL0OTe8uOcFXtfg8bqnIxZpIWqsGxVDgbSbcImVWOW2P+z2DuBOoZXZmzffyG4owzzWyLvCcklnJpsBsuGXCnaYjZifGthBC1I7Z/vv3XVA5hMo5mTzm6dn5+DSuV4FUB/nc3zVxexfQsy9DnrZclSJPhYPD0LfF/MypGmmDaw2/gFxJFnPy0KY83c+poCIwbJYsc2IDS0L3zWsyrU5U8iXf9yQS80HwP9Z6E5NOsYYf1cuf58gtBgH6B2JN47h7QDxn2oDJ/RhurIAQ3iBo2nghYQxlnhYHIm8/ZLL70ro6nw1NMNZ98UDa3qTFXlZAm9lxLV17DEJOruqrGdfzSlELV7tgtUaejmsA15ROnaJh5KGs9BYoBww2ufNBil8RqD16rNbIlE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T29naGF5STc0clhyQ1EwREg4aHg4OURqMTN4Q0FQUVVYdytzYzJZdWRLanJL?=
 =?utf-8?B?cjFCUmpBdnBtdi85eUZSdVVPNUwwSEd0ei8yZFdLb1Z2T3JBaXM5VkZKa2Vv?=
 =?utf-8?B?cm5VMXFJd1k0b2lUVkEwZUxYRFBPTFdER2ZncTFjTjZoMnRuMmo1UzIvN2VK?=
 =?utf-8?B?MmhuaDk5dGg0ZlB1NGpXM0VCT3RobFZyaktuVytYWHJTQ2kzeGd4WktWQmtO?=
 =?utf-8?B?VmNZUjlxWENDUGxTS1h6dlNJSEE0eFZSVjZlcFFZMEo2K1ZFalJUN0FqMzdy?=
 =?utf-8?B?Rjd5KzU5OHloUVU0N1oweXhpUG5TSkpKZnN6T1JjelBzL3pBTU9NcmZ5MmFE?=
 =?utf-8?B?Tmo2UXFGN01QRHJCM0FsNXQ2YUxGVDJDUWNhS05acnhCRlZBcFRScGlKTG5Z?=
 =?utf-8?B?cm16VjNKb1hTM1NtSERsL0pCdVVwdEJ6Q04zRGJiWi9KZy9ZeDQ1RDdkOTlS?=
 =?utf-8?B?M0RiT0NXZVZRNEdVYzY1bUhJdDQ2U1RBUVNPRXBTVkN4c1ZWZjZ4WkluNXNs?=
 =?utf-8?B?a05MSVN4TjB1MXo4V0I2Nm10NmxHUEJvWHltVWptZXlJMzNlcWlXWndrTzhX?=
 =?utf-8?B?Y0ZaNzNxdUtpMVgvM29vcmV6ekp1VFBPZW9ZRnQ1NUFtV3NqcWNWVEIyM1da?=
 =?utf-8?B?U0svbHd1eExjNXAzT3B0azkvb1BTTmZyYmJhUGE2aTQzRVRFUWMrL2gzV3hP?=
 =?utf-8?B?ejMzY1dyL0ZtQ3lHUVhnQXUrdWJVMkZtcE1xaFE0MEJwclM4dkdyWEIrWkVo?=
 =?utf-8?B?SitDUGVGTFg2SllOL1Mxc0dpcHFLdEJZeUloYXY5Sm0xZDVLUW84dGx1MGpk?=
 =?utf-8?B?d0xQUytPQUl6RXVhRkhZVTAyQVlXSTZORVQvUWxkZEU1bmRkdHZISU13OERL?=
 =?utf-8?B?TnRZcnp1RmZ3ZXdPcnNVWG5mRE5nVmFGUVVocmxvOGJ5b3pJS2Rya29sVXho?=
 =?utf-8?B?czcyZ2RHdVVkRk83dG04cEpFS3F5TkZoL24wdENnRmNvUU5kMHpjOVZMbi9i?=
 =?utf-8?B?dkF4blFiOU82cWw0OU5XcjRINXJNVWU0K09hY09uYTNvUEdFbnlNQ0RDVVBn?=
 =?utf-8?B?ekZYWUt0eUdQNnBqWlNYR3RKS24reGwvdGpzQnk0UG91VTVIT0V4N2dmTnpj?=
 =?utf-8?B?ZTRERmQrbGV1aEcxQTNvU0hRQlMyZFIyaGQvMVkvb0xqWkZDa0t4SU9MWFZI?=
 =?utf-8?B?ZEdjZEJBY1lIWFMzdW9vUGthUFRJMFFpU2FDbXZMU2JuY1pmRGt0eEhRT3Ns?=
 =?utf-8?B?WXZRNXYzQzRJaStXWEJwN09lWXEydWp5dC84RUlnQmtPQmlCZFFsOXYyUzRR?=
 =?utf-8?B?MEM5VjNFOVp4Y1dobWdiOEhNRkE2dWVHbTVSWU9JQVFQKzg4amhMYVBhcDhP?=
 =?utf-8?B?cWphZWRYcVV6Rnp3THNDL0N0VTI1WjZqNWV1ZXpSQ2EzamZrcGZEdWJjSVZK?=
 =?utf-8?B?MXdvMUlIcW0reTVsOUtsV2V1RTJOZEVJcVhBNHZqbGlybXExeS9CSUhSb2Yr?=
 =?utf-8?B?dFhCQnN1ZmlheGtQK3NYd0IwYUd0UFcwVk15SmJvYmpxdGZ5bG5wMDJzTVdJ?=
 =?utf-8?B?cXNlQjMvS28vUXIxbkVMOEZGeEIyVU9mbFFFM0xuamdlN2RwalB4WE5rb1hJ?=
 =?utf-8?B?SWdmNkZkYjR1eEFxaVhEajF3VGZmU1ZUakd0KzlsalphUENrM290NWhIYjJm?=
 =?utf-8?B?SmdpaHQrM3FORW5VZGROY3dWcXpDZUVKcjRoazVscG02Q3FJK1lTMDgxU2JM?=
 =?utf-8?B?MUF4UUJGcGhTT2Y1blBQdFJDOGl6eGZ0dzJscnVPVGdlMVZ5NW9meVQwMmFz?=
 =?utf-8?B?OFg1SlhwZ1JQUkc5NGZLUWxSV0VQYm82djBMdk91dHFFRXlBT3Zjd0J6NjZ5?=
 =?utf-8?B?bitkb1MzSFE0bExlTXRlR3M5K3lYMUVXR1hOWndGb1JKN0g3TjEzNndlSng1?=
 =?utf-8?B?a3ErUUUrZnJ2VHJGdDhjWnB1YU96NjhtaEttTjBpa3dyZkZEelIwQ3gybFVv?=
 =?utf-8?B?N1dyVVcvRGtJR3VxU0IxMXllNk9TRXRjNlV5Zys3eHM3dFNKdmZXNkNaNzc1?=
 =?utf-8?B?VGQwc21pNzF0QnBXaWJKUTdTelg2K3ZCWFZud3k1ZlhHazhjUUJRN1kyaXYz?=
 =?utf-8?Q?E89lyNB2DaiRLUwqiYTqzc8c2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e5eef1-1a28-4caa-83d4-08dc38308623
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:40:24.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dc41IDd8q/ShHbhwAD/xY04RrSD/euwXDt8IEPybwnwhf61EGcz3aRyLD88eHkn37giNyxXo0LN54bM5tPfcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9015

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has BLK CTL modules in various MIXes, the BLK CTL modules
support clock features such as mux/gate/div. This patch
is to add the clock feature of BLK CTL modules

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Kconfig             |   7 +
 drivers/clk/imx/Makefile            |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c | 438 ++++++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db3bca5f4ec9..6da0fba68225 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -114,6 +114,13 @@ config CLK_IMX93
 	help
 	    Build the driver for i.MX93 CCM Clock Driver
 
+config CLK_IMX95_BLK_CTL
+	tristate "IMX95 Clock Driver for BLK CTL"
+	depends on ARCH_MXC || COMPILE_TEST
+	select MXC_CLK
+	help
+	    Build the clock driver for i.MX95 BLK CTL
+
 config CLK_IMXRT1050
 	tristate "IMXRT1050 CCM Clock Driver"
 	depends on SOC_IMXRT || COMPILE_TEST
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index d4b8e10b1970..03f2b2a1ab63 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-imx8mp-audiomix.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
 obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
+obj-$(CONFIG_CLK_IMX95_BLK_CTL) += clk-imx95-blk-ctl.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o clk-imx-acm.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
new file mode 100644
index 000000000000..4448b7a3a2a3
--- /dev/null
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/clock/nxp,imx95-clock.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/pm_runtime.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+enum {
+	CLK_GATE,
+	CLK_DIVIDER,
+	CLK_MUX,
+};
+
+struct imx95_blk_ctl {
+	struct device *dev;
+	spinlock_t lock;
+	struct clk *clk_apb;
+
+	void __iomem *base;
+	/* clock gate register */
+	u32 clk_reg_restore;
+};
+
+struct imx95_blk_ctl_clk_dev_data {
+	const char *name;
+	const char * const *parent_names;
+	u32 num_parents;
+	u32 reg;
+	u32 bit_idx;
+	u32 bit_width;
+	u32 clk_type;
+	u32 flags;
+	u32 flags2;
+	u32 type;
+};
+
+struct imx95_blk_ctl_dev_data {
+	const struct imx95_blk_ctl_clk_dev_data *clk_dev_data;
+	u32 num_clks;
+	bool rpm_enabled;
+	u32 clk_reg_offset;
+};
+
+static const struct imx95_blk_ctl_clk_dev_data vpublk_clk_dev_data[] = {
+	[IMX95_CLK_VPUBLK_WAVE] = {
+		.name = "vpublk_wave_vpu",
+		.parent_names = (const char *[]){ "vpu", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_ENC] = {
+		.name = "vpublk_jpeg_enc",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_DEC] = {
+		.name = "vpublk_jpeg_dec",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 2,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data vpublk_dev_data = {
+	.num_clks = IMX95_CLK_VPUBLK_END,
+	.clk_dev_data = vpublk_clk_dev_data,
+	.rpm_enabled = true,
+	.clk_reg_offset = 8,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data camblk_clk_dev_data[] = {
+	[IMX95_CLK_CAMBLK_CSI2_FOR0] = {
+		.name = "camblk_csi2_for0",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_CSI2_FOR1] = {
+		.name = "camblk_csi2_for1",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_AXI] = {
+		.name = "camblk_isp_axi",
+		.parent_names = (const char *[]){ "camaxi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_PIXEL] = {
+		.name = "camblk_isp_pixel",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 5,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP] = {
+		.name = "camblk_isp",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 6,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data camblk_dev_data = {
+	.num_clks = IMX95_CLK_CAMBLK_END,
+	.clk_dev_data = camblk_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data lvds_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_LVDS_PHY_DIV] = {
+		.name = "ldb_phy_div",
+		.parent_names = (const char *[]){ "ldbpll", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 1,
+		.type = CLK_DIVIDER,
+		.flags2 = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH0_GATE] = {
+		.name = "lvds_ch0_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH1_GATE] = {
+		.name = "lvds_ch1_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI0_GATE] = {
+		.name = "lvds_di0_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 3,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI1_GATE] = {
+		.name = "lvds_di1_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+};
+
+static const struct imx95_blk_ctl_dev_data lvds_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_LVDS_CSR_END,
+	.clk_dev_data = lvds_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data dispmix_csr_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_ENG0_SEL] = {
+		.name = "disp_engine0_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	},
+	[IMX95_CLK_DISPMIX_ENG1_SEL] = {
+		.name = "disp_engine1_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data dispmix_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_END,
+	.clk_dev_data = dispmix_csr_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static int imx95_bc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	struct imx95_blk_ctl *bc;
+	struct clk_hw_onecell_data *clk_hw_data;
+	struct clk_hw **hws;
+	void __iomem *base;
+	int i, ret;
+
+	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
+	if (!bc)
+		return -ENOMEM;
+	bc->dev = dev;
+	dev_set_drvdata(&pdev->dev, bc);
+
+	spin_lock_init(&bc->lock);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	bc->base = base;
+	bc->clk_apb = devm_clk_get(dev, NULL);
+	if (IS_ERR(bc->clk_apb))
+		return dev_err_probe(dev, PTR_ERR(bc->clk_apb), "failed to get APB clock\n");
+
+	ret = clk_prepare_enable(bc->clk_apb);
+	if (ret) {
+		dev_err(dev, "failed to enable apb clock: %d\n", ret);
+		return ret;
+	}
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return devm_of_platform_populate(dev);
+
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc_data->num_clks),
+				   GFP_KERNEL);
+	if (!clk_hw_data)
+		return -ENOMEM;
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_enable(&pdev->dev);
+
+	clk_hw_data->num = bc_data->num_clks;
+	hws = clk_hw_data->hws;
+
+	for (i = 0; i < bc_data->num_clks; i++) {
+		const struct imx95_blk_ctl_clk_dev_data *data = &bc_data->clk_dev_data[i];
+		void __iomem *reg = base + data->reg;
+
+		if (data->type == CLK_MUX) {
+			hws[i] = clk_hw_register_mux(dev, data->name, data->parent_names,
+						     data->num_parents, data->flags, reg,
+						     data->bit_idx, data->bit_width,
+						     data->flags2, &bc->lock);
+		} else if (data->type == CLK_DIVIDER) {
+			hws[i] = clk_hw_register_divider(dev, data->name, data->parent_names[0],
+							 data->flags, reg, data->bit_idx,
+							 data->bit_width, data->flags2, &bc->lock);
+		} else {
+			hws[i] = clk_hw_register_gate(dev, data->name, data->parent_names[0],
+						      data->flags, reg, data->bit_idx,
+						      data->flags2, &bc->lock);
+		}
+		if (IS_ERR(hws[i])) {
+			ret = PTR_ERR(hws[i]);
+			dev_err(dev, "failed to register: %s:%d\n", data->name, ret);
+			goto cleanup;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret)
+		goto cleanup;
+
+	ret = devm_of_platform_populate(dev);
+	if (ret) {
+		of_clk_del_provider(dev->of_node);
+		goto cleanup;
+	}
+
+	if (pm_runtime_enabled(bc->dev))
+		clk_disable_unprepare(bc->clk_apb);
+
+	return 0;
+
+cleanup:
+	for (i = 0; i < bc_data->num_clks; i++) {
+		if (IS_ERR_OR_NULL(hws[i]))
+			continue;
+		clk_hw_unregister(hws[i]);
+	}
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int imx95_bc_runtime_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(bc->clk_apb);
+	return 0;
+}
+
+static int imx95_bc_runtime_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(bc->clk_apb);
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int imx95_bc_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	int ret;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	if (bc_data->rpm_enabled) {
+		ret = pm_runtime_get_sync(bc->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(bc->dev);
+			return ret;
+		}
+	}
+
+	bc->clk_reg_restore = readl(bc->base + bc_data->clk_reg_offset);
+
+	return 0;
+}
+
+static int imx95_bc_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	writel(bc->clk_reg_restore, bc->base + bc_data->clk_reg_offset);
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_put(bc->dev);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx95_bc_pm_ops = {
+	SET_RUNTIME_PM_OPS(imx95_bc_runtime_suspend, imx95_bc_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(imx95_bc_suspend, imx95_bc_resume)
+};
+
+static const struct of_device_id imx95_bc_of_match[] = {
+	{ .compatible = "nxp,imx95-cameramix-csr", .data = &camblk_dev_data },
+	{ .compatible = "nxp,imx95-display-master-csr", },
+	{ .compatible = "nxp,imx95-dispmix-lvds-csr", .data = &lvds_csr_dev_data },
+	{ .compatible = "nxp,imx95-dispmix-csr", .data = &dispmix_csr_dev_data },
+	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", },
+	{ .compatible = "nxp,imx95-vpumix-csr", .data = &vpublk_dev_data },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx95_blk_ctl_match);
+
+static struct platform_driver imx95_bc_driver = {
+	.probe = imx95_bc_probe,
+	.driver = {
+		.name = "imx95-blk-ctl",
+		.of_match_table = of_match_ptr(imx95_bc_of_match),
+		.pm = &imx95_bc_pm_ops,
+	},
+};
+module_platform_driver(imx95_bc_driver);
+
+MODULE_DESCRIPTION("NXP i.MX95 blk ctl driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


