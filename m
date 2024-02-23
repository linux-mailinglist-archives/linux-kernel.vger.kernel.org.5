Return-Path: <linux-kernel+bounces-77612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20A860815
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC60E1F2342E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3EEE57B;
	Fri, 23 Feb 2024 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bvP+Eg33"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601DD2FF;
	Fri, 23 Feb 2024 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650545; cv=fail; b=IjGAFfMe+l2cADuSr7Z+8TPlePiGwXzURpY5Hf44oHIrXQsFHCgXwYVxonYDujOlvo0wNzQpqugF3dW0J7TzhLgd1dR5z0w51MSdVhOZrmGWv6NMqTrM6Ybb8a90ROARwdYvk4oCscEqhFfcqiA6dqkF6Z278UTF2gDlHA+8Q8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650545; c=relaxed/simple;
	bh=5ITmc5uva/HTe705qku9tPU3KnGIwLiEr22e4lOjbpQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c9oM8EBL9DdMnWAXxrvuaps4XiXNlBMme49V/wGtXAxA1II9BqUDJcsSx/mSSH2d3kx/LaKAlbbQvlY3l+7JNU7vMFwaCV4wBSxN4JC2kPKI/6g1kf+DrenGjt7HlfPBbauEUwTGn1wd8qHZ1+Hsv5qzZ2XUmBDT88Xln+1NOQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bvP+Eg33; arc=fail smtp.client-ip=40.107.8.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7kTDmNW99W9rBWpRKt8Z2NfNlGe4JymUHLgkrEpwIclk+QqE14GMFfQRA3yXJVHXzyKuklUN8OJyRcaHD+Tl7fmH1JUebLmkrAMiRWrAcrcyAs7DAAdXYnljxkRUKIzsla/k48rY+4MjPwqyabmnAkgD5ZMd1dZ05GZ4xIjx1ZjnxBcMQdYkvOUh+KYVjMUJTXatmsA3dYLkQCM2B+2JG1PCo7jOoViv7ONiSY+SMdA39o7IF3XekI5nnJs1pylp0tGlWEeO3gf4CGpvrr8T4TQmNscXbbtRq7irFzEDpGxK8kdqbIuPdt5yBuiuuIV5V1bjaWPpQ4QKHDY566CEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udgdJYSrFzRlZijbx6NDrjt8bJBM2InMt3Qx0wZrW0E=;
 b=ZvN1GuecNeCIQjc+tmM809vBHklkx1H/KS1qF01XWzMRseof3vTHatRmmCeBcg73ZnwaVQDVn91BtChqj8w+drcYDxadaY+TuRGaQlTTcz1BOGBj2ZgBN/O2OtvtRd+YmFiY1mc0Xcxzr5zRlQOQI2wK5/egu9hsqMueZqyCktfnH2/TC58FBfnyebNaYKFFVBgK0OG0LvyMBS5gK7nJCcDjw3bnzBQqaMEhiEr0FfNsy5Vp9jRDw/DRR+kjMkJo/00zkN45CjbhiaHyfZlKrs5RCFmJHpT5SLgYqUpDtyatOTHOBRIHMCLTS38x33nhwE0rDnFhrjnlOLfWzndVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udgdJYSrFzRlZijbx6NDrjt8bJBM2InMt3Qx0wZrW0E=;
 b=bvP+Eg3352sS/UPzhICjJLI0j8MElmnOr7/+RIAKoX6R9tPU65+vRyzqnXv4+re3GF8UvEuTwJqpwEhDXXdY3WGQJSDIN6rCCAnvKH29VoJEBs1QiWAL0U98uEhmZ3T3GFc+QYcezFsDOx5ALZUafCFjwLhVl83XoeFASqTTB/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 01:09:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 01:09:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 23 Feb 2024 09:16:41 +0800
Subject: [PATCH v4 4/4] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-pinctrl-scmi-v4-4-10eb5a379274@nxp.com>
References: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
In-Reply-To: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708651021; l=19238;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=f/ftPAn1+b7xP3Hqqk8O5KBm5r1H0b7KvOCiADr7ttA=;
 b=KC4I62cI386TMkpuXl5j36VlimdTRNj6fCaFdEhuCX0GPAv/atXvYnpBjfgZ4OIvV2pgD7jko
 hRRpKpHY7uGDxmHif0/Hdz9K2MC3p2lX/LmRtP9N7rEk39naKLoeBOc
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b27c00-aa17-42e3-a40b-08dc340c04ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LWaoyPpVHOhOIanTUJoHO0lpIqBTaglQVbwTZv+o4if3W+ZBr6gceW5ll6F9iop9FIXP+Ueo3d/VFkIPPC1IXMYPXSpvvhGccYmsXG1vvWv8zxQlaiAGJX7X37ILX9f3thg6FAq32ktlMO+qrHgVNqmCTb5lhroon/oAXytTFxQ/i7dLB5ZJOXvot/p8YoX8g+3y+EIXTy3+ezREMAWzksy1P7TwCw/FWMSPi7PvzrjaNNWMb7VRUYdFTsvZASH2L2nAARjX4mct8Pl6OPBE7tHLGCxWJUjbQmhm45LsauNW5yQ/7dQTmIAEHYgUFcyGiZOkokbdnbfYLb1mftr+BsMfy7ewT3l54ur2CKfvm4VrIL0mbaxXXuLJ+Q2eldK30d8DH1ykJudMA/rDU9ELWvj/f634mAyFELtCEkc593lU3QXtMJp3rusc0sjE22xZmIxwsqfYP2OxXkYQn4tzk18S7TQzZYTkwx8DOUVKefidtaygtv4Wjx7ihO+ylqKU+yFO3wARk1HAkOYj9fbtq5B2rPByKIBLeZhjWKzs0m2kvakIpkC+nfnCms72FoUaOwsR7wHTiizbWCg3q3lzAhlxZk7lv3e9LadD/4N1pwxWKc2AzE/eztcumcYGLi5kppfp7BlhwSoibvbjiv3p+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1UwTWtwQjRpUUpYUEFua2l5cXkvbXE0NkYzczFnU2VBQmliN21XMkJNVGNX?=
 =?utf-8?B?ckk1NzNOUVo3bWJFNFdxeU1STThzZDJOdis3aUVFeUFQSkRQVmEvMkpkMHRH?=
 =?utf-8?B?d1NHVmNCNWw2VjU3aTJySk1neTdwaGhNZEJLRFhJcGFCUjFscEJqZ2xTMkZX?=
 =?utf-8?B?ZUUwQzVSVFA3NHV1OURyeUx3eW5UQ1NBcnNRVGpvNFhmektZZzlwcE1DSU9t?=
 =?utf-8?B?T3kyZzZNamgzWXBwWGFqMXA3RkNNY1pvSzRyazBXeTJObGZLcGc0bk1TUVRk?=
 =?utf-8?B?bHJ4a2w2bjJLR1JHZlNxWmFNTkoyenhYdVVBVi9LNXJ2RUxZRUtOeExOZ2hF?=
 =?utf-8?B?SFg0dDQySW1tSi9acmR1WkYwbGFBTlVmbFlsSy9YSERxNE83aW9QU3EyczVy?=
 =?utf-8?B?RDdYdGo1bnUwVVpsaEhrQVpMZXpRWm9OK2ROVmxPdllHNXdmK0tveTc2T0JW?=
 =?utf-8?B?NUN1dHVFNmd4WGJNTlF5TmR2YkJtUGU2eWhsN1h6dnVvMU9JTXFHdzFFZzA3?=
 =?utf-8?B?RVRXZG9aU3BpNEFzNlRYeXlxbFpZaElZVkFmTlRXRmhUaU82ZVZyUmxHOWk0?=
 =?utf-8?B?eHFhTmxnSXl0eWdTUjFnS0szZERmaUwveW9jUEI0Znp1cE9STTVlMXllWTVY?=
 =?utf-8?B?WGptMlp0UUVtZHRqS2JNSHBqdDJwQ1BCdFpnNHNabEE2ZTRvUWR6akhGUmFZ?=
 =?utf-8?B?UkhwRldZWFlhemk2TWl1b1hWUWZaRURHTzJTaXRzbkRFNTcxUklUaG5DQ0Ur?=
 =?utf-8?B?NFRLRlR0S00rSUxJR21VczBnVDBsZXpRSmxSMk1ZSVZQYjRoRndHSlg2WW9S?=
 =?utf-8?B?eVpacmdMeVduUS9jQW01TktIK0VwSmFKU3ZDeitqVkdQUVJmUFhWcDhRdHpP?=
 =?utf-8?B?OVNSV2Jhdm9JM0JYN0YzR0pnSXZjRGl3TkhlZTZZUlRBa3ZLTHVmMEVMT0tv?=
 =?utf-8?B?R1F5Mzh2MVljeGJhKysxZnR2MlRKVVJicG9TTkpxWWEzbHpsQTFyQVVxTXVy?=
 =?utf-8?B?T3JrYXFObjZ6Y1BUYjJGeFpnc1lRTUdTdTd4bTBOUFJmeU04N2FRejVZNURF?=
 =?utf-8?B?b3NZcTkzc0xBTUFFZlVSb1NvUWUyNG1QYVZ3NXkvcU1ldVMvY3VCbUNNNE1S?=
 =?utf-8?B?a1h1UlpHUVJDMVU2SnI3MkI5Qk1WYzE1ZVJveFJ2UVI2eVo5ZUJKNkxKOW9q?=
 =?utf-8?B?VXdPOFJGQUR5UHNsSjIxSW1DaUxMWEVMNmRVOC9PRGlEenV4UW9saXIxblhk?=
 =?utf-8?B?TFBkOWpkMTF6OHprODVEbVYxam5CaFRtYjkycGZpa25DOTBhMFBTRDk3MEkx?=
 =?utf-8?B?dkwzVG9YM3ZiYm1ZZjUyNEFqL1FaUmxwR2VKNDVvdkVlOEMxTitocjJLWVlL?=
 =?utf-8?B?amlIRGxZYXRBNC9DS1Npa3VBL1Bsd0d3YlBlZk43ZEVmbHh0KytuNnZNVGJV?=
 =?utf-8?B?aTFoemxkNTZNcC9TQUNLdVhtb1NPcWRteGRGMTlGREMzRE84UExFWlhnbDFF?=
 =?utf-8?B?N1Q1UGg4eEhzRUZtaUlRakhXdHdVclNjYVZjSHVFMnV6ZTlDN214aUNlelR0?=
 =?utf-8?B?YUwrYlFlTDRaMGxpdkQrT1ppd0ZXRlJXbDVlRUlGQStHYlJJYzVpaFR5eHQ5?=
 =?utf-8?B?OGFFNkl0L1FwZ2lvbVIwN0I2cEJuQkRHTHZxZUNSTklaeGc4NDRKQUgyZTdI?=
 =?utf-8?B?RFRWZk9PMHRKVWkxbnJlNVhoWktyOHNoL2VQZFdLNmY0WWFYa0xseFFFSENY?=
 =?utf-8?B?ajhIc2EycElRWGNFYzZxeGhWYmVlUkhmam1aNFNiZ2NMa0NhZmJCRjFjK2FP?=
 =?utf-8?B?NjZLc0V2UTdnNjlhM1ByU3pGRGZ2M0Nub1VNb0RYcTkzUk03UnZMY3FIMEx6?=
 =?utf-8?B?NjJsZE9mNHNPNmg3M1V3Qk5qdHpLeEFKSWZDOUtNa0VHckNQU29PcU54b0NN?=
 =?utf-8?B?MFZXaFBVUTNLU25ocnJXTm54cjk3WVF2WVo0UWZOSXpRZ3pmYmtDQmMwakhz?=
 =?utf-8?B?YkNHMThpZWNmYVR4L1VvOGVpclFJTDVHT25MUncxTExIblZYUWs3L2FTOFFQ?=
 =?utf-8?B?RGtXbnRGbDZIQ05mclZUbXFxSmRsRnBraVY2U0Q2QVFqcVhHcWlNMUtRNklR?=
 =?utf-8?Q?TijSQgwPva8AxUL4JF82DlpuT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b27c00-aa17-42e3-a40b-08dc340c04ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 01:09:00.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HYgDdpy8tWrFVzEFCm97olU7xaKC1egG1BN/pjywxcDj0ZPVUZsFHZWX9tXksp4BaVKEdi9mAMmDpxVOLgB8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8418

From: Peng Fan <peng.fan@nxp.com>

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 593 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 606 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c042ca394893..851216ba59b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21447,6 +21447,7 @@ F:	drivers/clk/clk-sc[mp]i.c
 F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
+F:	drivers/pinctrl/pinctrl-scmi.c
 F:	drivers/pmdomain/arm/
 F:	drivers/powercap/arm_scmi_powercap.c
 F:	drivers/regulator/scmi-regulator.c
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 8163a5983166..27b26e428f60 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -432,6 +432,17 @@ config PINCTRL_ROCKCHIP
 	help
           This support pinctrl and GPIO driver for Rockchip SoCs.
 
+config PINCTRL_SCMI
+	tristate "Pinctrl driver using SCMI protocol interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	select PINMUX
+	select GENERIC_PINCONF
+	help
+	  This driver provides support for pinctrl which is controlled
+	  by firmware that implements the SCMI interface.
+	  It uses SCMI Message Protocol to interact with the
+	  firmware providing all the pinctrl controls.
+
 config PINCTRL_SINGLE
 	tristate "One-register-per-pin type device tree based pinctrl driver"
 	depends on OF
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 1071f301cc70..ba755ed2d46c 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
new file mode 100644
index 000000000000..f2fef3fb85ae
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,593 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based pinctrl driver
+ *
+ * Copyright (C) 2024 EPAM
+ * Copyright 2024 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "pinctrl-utils.h"
+#include "core.h"
+#include "pinconf.h"
+
+#define DRV_NAME "scmi-pinctrl"
+
+/* Define num configs, if not large than 4 use stack, else use kcalloc */
+#define SCMI_NUM_CONFIGS	4
+
+static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
+
+struct scmi_pinctrl_funcs {
+	unsigned int num_groups;
+	const char **groups;
+};
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pctl_desc;
+	struct scmi_pinctrl_funcs *functions;
+	unsigned int nr_functions;
+	char **groups;
+	unsigned int nr_groups;
+	struct pinctrl_pin_desc *pins;
+	unsigned int nr_pins;
+};
+
+static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, GROUP_TYPE);
+}
+
+static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev,
+					       unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	ret = pinctrl_ops->name_get(pmx->ph, selector, GROUP_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const unsigned int **pins,
+				       unsigned int *num_pins)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->group_pins_get(pmx->ph, selector, pins, num_pins);
+}
+
+static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
+	.get_groups_count = pinctrl_scmi_get_groups_count,
+	.get_group_name = pinctrl_scmi_get_group_name,
+	.get_group_pins = pinctrl_scmi_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
+};
+
+static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, FUNCTION_TYPE);
+}
+
+static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctldev,
+						  unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	ret = pinctrl_ops->name_get(pmx->ph, selector, FUNCTION_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
+					    unsigned int selector,
+					    const char * const **groups,
+					    unsigned int * const num_groups)
+{
+	const unsigned int *group_ids;
+	int ret, i;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (!groups || !num_groups)
+		return -EINVAL;
+
+	if (selector < pmx->nr_functions &&
+	    pmx->functions[selector].num_groups) {
+		*groups = (const char * const *)pmx->functions[selector].groups;
+		*num_groups = pmx->functions[selector].num_groups;
+		return 0;
+	}
+
+	ret = pinctrl_ops->function_groups_get(pmx->ph, selector,
+					       &pmx->functions[selector].num_groups,
+					       &group_ids);
+	if (ret) {
+		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
+		return ret;
+	}
+
+	*num_groups = pmx->functions[selector].num_groups;
+	if (!*num_groups)
+		return -EINVAL;
+
+	pmx->functions[selector].groups =
+		devm_kcalloc(pmx->dev, *num_groups,
+			     sizeof(*pmx->functions[selector].groups),
+			     GFP_KERNEL);
+	if (!pmx->functions[selector].groups)
+		return -ENOMEM;
+
+	for (i = 0; i < *num_groups; i++) {
+		pmx->functions[selector].groups[i] =
+			pinctrl_scmi_get_group_name(pmx->pctldev,
+						    group_ids[i]);
+		if (!pmx->functions[selector].groups[i]) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+	}
+
+	*groups = (const char * const *)pmx->functions[selector].groups;
+
+	return 0;
+
+err_free:
+	devm_kfree(pmx->dev, pmx->functions[selector].groups);
+
+	return ret;
+}
+
+static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev,
+				     unsigned int selector, unsigned int group)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->mux_set(pmx->ph, selector, group);
+}
+
+static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
+				unsigned int offset)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_request(pmx->ph, offset);
+}
+
+static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int offset)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_free(pmx->ph, offset);
+}
+
+static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
+	.request = pinctrl_scmi_request,
+	.free = pinctrl_scmi_free,
+	.get_functions_count = pinctrl_scmi_get_functions_count,
+	.get_function_name = pinctrl_scmi_get_function_name,
+	.get_function_groups = pinctrl_scmi_get_function_groups,
+	.set_mux = pinctrl_scmi_func_set_mux,
+};
+
+static int pinctrl_scmi_map_pinconf_type(enum pin_config_param param,
+					 enum scmi_pinctrl_conf_type *type)
+{
+	u32 arg = param;
+
+	switch (arg) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		*type = SCMI_PIN_BIAS_BUS_HOLD;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		*type = SCMI_PIN_BIAS_DISABLE;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*type = SCMI_PIN_BIAS_HIGH_IMPEDANCE;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*type = SCMI_PIN_BIAS_PULL_DOWN;
+		break;
+	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+		*type = SCMI_PIN_BIAS_PULL_DEFAULT;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*type = SCMI_PIN_BIAS_PULL_UP;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		*type = SCMI_PIN_DRIVE_OPEN_DRAIN;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
+		*type = SCMI_PIN_DRIVE_OPEN_SOURCE;
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		*type = SCMI_PIN_DRIVE_PUSH_PULL;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		*type = SCMI_PIN_DRIVE_STRENGTH;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		*type = SCMI_PIN_DRIVE_STRENGTH;
+		break;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		*type = SCMI_PIN_INPUT_DEBOUNCE;
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		*type = SCMI_PIN_INPUT_MODE;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT:
+		*type = SCMI_PIN_INPUT_SCHMITT;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		*type = SCMI_PIN_INPUT_MODE;
+		break;
+	case PIN_CONFIG_MODE_LOW_POWER:
+		*type = SCMI_PIN_LOW_POWER_MODE;
+		break;
+	case PIN_CONFIG_OUTPUT:
+		*type = SCMI_PIN_OUTPUT_VALUE;
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		*type = SCMI_PIN_OUTPUT_MODE;
+		break;
+	case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
+		*type = SCMI_PIN_OUTPUT_VALUE;
+		break;
+	case PIN_CONFIG_POWER_SOURCE:
+		*type = SCMI_PIN_POWER_SOURCE;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		*type = SCMI_PIN_SLEW_RATE;
+		break;
+	case SCMI_PIN_OEM_START ... SCMI_PIN_OEM_END:
+		*type = arg;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
+				    unsigned int _pin, unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	enum scmi_pinctrl_conf_type type;
+	u32 config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+
+	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
+	if (ret) {
+		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, type,
+				      &config_value);
+	if (ret)
+		return ret;
+
+	*config = pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static int
+pinctrl_scmi_alloc_configs(struct pinctrl_dev *pctldev, u32 num_configs,
+			   u32 **p_config_value,
+			   enum scmi_pinctrl_conf_type **p_config_type)
+{
+	if (num_configs <= SCMI_NUM_CONFIGS)
+		return 0;
+
+	*p_config_value = kcalloc(num_configs, sizeof(u32), GFP_KERNEL);
+	*p_config_type = kcalloc(num_configs,
+				 sizeof(enum scmi_pinctrl_conf_type),
+				 GFP_KERNEL);
+
+	if (!*p_config_value || !*p_config_type) {
+		kfree(*p_config_value);
+		kfree(*p_config_type);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void
+pinctrl_scmi_free_configs(struct pinctrl_dev *pctldev, u32 num_configs,
+			  u32 **p_config_value,
+			  enum scmi_pinctrl_conf_type **p_config_type)
+{
+	if (num_configs <= SCMI_NUM_CONFIGS)
+		return;
+
+	kfree(*p_config_value);
+	kfree(*p_config_type);
+}
+
+static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
+				    unsigned int _pin,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
+	u32 config_value[SCMI_NUM_CONFIGS];
+	enum scmi_pinctrl_conf_type *p_config_type = config_type;
+	u32 *p_config_value = config_value;
+	enum pin_config_param param;
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
+					 &p_config_value);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		ret = pinctrl_scmi_map_pinconf_type(param, &p_config_type[i]);
+		if (ret) {
+			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+			goto free_config;
+		}
+		p_config_value[i] = pinconf_to_config_argument(configs[i]);
+	}
+
+	ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, num_configs,
+				      p_config_type,  p_config_value);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d\n", ret);
+
+free_config:
+	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
+				  &p_config_value);
+	return ret;
+}
+
+static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *configs,
+					  unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx =  pinctrl_dev_get_drvdata(pctldev);
+	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
+	u32 config_value[SCMI_NUM_CONFIGS];
+	enum scmi_pinctrl_conf_type *p_config_type = config_type;
+	u32 *p_config_value = config_value;
+	enum pin_config_param param;
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
+					 &p_config_value);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		ret = pinctrl_scmi_map_pinconf_type(param,
+						    &p_config_type[i]);
+		if (ret) {
+			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+			goto free_config;
+		}
+
+		p_config_value[i] = pinconf_to_config_argument(configs[i]);
+	}
+
+	ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, num_configs,
+				      p_config_type, p_config_value);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d", ret);
+
+free_config:
+	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
+				  &p_config_value);
+	return ret;
+};
+
+static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	enum scmi_pinctrl_conf_type type;
+	u32 config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
+	if (ret) {
+		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_ops->config_get(pmx->ph, group, GROUP_TYPE, type,
+				      &config_value);
+	if (ret)
+		return ret;
+
+	*config = pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = pinctrl_scmi_pinconf_get,
+	.pin_config_set = pinctrl_scmi_pinconf_set,
+	.pin_config_group_set = pinctrl_scmi_pinconf_group_set,
+	.pin_config_group_get = pinctrl_scmi_pinconf_group_get,
+	.pin_config_config_dbg_show = pinconf_generic_dump_config,
+};
+
+static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
+				 unsigned int *nr_pins,
+				 const struct pinctrl_pin_desc **pins)
+{
+	int ret, i;
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (pmx->nr_pins) {
+		*pins = pmx->pins;
+		*nr_pins = pmx->nr_pins;
+		return 0;
+	}
+
+	*nr_pins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
+
+	pmx->nr_pins = *nr_pins;
+	pmx->pins = devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins),
+				       GFP_KERNEL);
+	if (!pmx->pins)
+		return -ENOMEM;
+
+	for (i = 0; i < *nr_pins; i++) {
+		pmx->pins[i].number = i;
+		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE,
+					    &pmx->pins[i].name);
+		if (ret) {
+			dev_err(pmx->dev, "Can't get name for pin %d: rc %d", i, ret);
+			pmx->nr_pins = 0;
+			return ret;
+		}
+	}
+
+	*pins = pmx->pins;
+	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static int scmi_pinctrl_probe(struct scmi_device *sdev)
+{
+	int ret;
+	struct device *dev = &sdev->dev;
+	struct scmi_pinctrl *pmx;
+	const struct scmi_handle *handle;
+	struct scmi_protocol_handle *ph;
+
+	if (!sdev || !sdev->handle)
+		return -EINVAL;
+
+	handle = sdev->handle;
+
+	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL,
+						&ph);
+	if (IS_ERR(pinctrl_ops))
+		return PTR_ERR(pinctrl_ops);
+
+	pmx = devm_kzalloc(dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->ph = ph;
+
+	pmx->dev = dev;
+	pmx->pctl_desc.name = DRV_NAME;
+	pmx->pctl_desc.owner = THIS_MODULE;
+	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
+	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
+	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
+
+	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
+				    &pmx->pctl_desc.pins);
+	if (ret)
+		return ret;
+
+	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx,
+					     &pmx->pctldev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
+	pmx->nr_groups = pinctrl_scmi_get_groups_count(pmx->pctldev);
+
+	if (pmx->nr_functions) {
+		pmx->functions = devm_kcalloc(dev, pmx->nr_functions,
+					      sizeof(*pmx->functions),
+					      GFP_KERNEL);
+		if (!pmx->functions)
+			return -ENOMEM;
+	}
+
+	if (pmx->nr_groups) {
+		pmx->groups = devm_kcalloc(dev, pmx->nr_groups,
+					   sizeof(*pmx->groups), GFP_KERNEL);
+		if (!pmx->groups)
+			return -ENOMEM;
+	}
+
+	return pinctrl_enable(pmx->pctldev);
+}
+
+static struct scmi_driver scmi_pinctrl_driver = {
+	.name = DRV_NAME,
+	.probe = scmi_pinctrl_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_pinctrl_driver);
+
+MODULE_AUTHOR("Oleksii Moisieiev <oleksii_moisieiev@epam.com>");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("ARM SCMI pin controller driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


