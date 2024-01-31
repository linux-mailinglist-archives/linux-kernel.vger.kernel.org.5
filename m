Return-Path: <linux-kernel+bounces-47368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4780844CE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386FC1F29ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25F213EFFF;
	Wed, 31 Jan 2024 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ONi+w8mT"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024613EFE8;
	Wed, 31 Jan 2024 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743311; cv=fail; b=sHmcJ9nf5k7ytxEye6XZg4vbdukcBFR//itbKe9XRd9osaAb8Xo7d7O/6IWEQ987MdYS6kZ1w7MILk+quEchHfNQIr08knjlI1VqlFamWp7tpFX6ZwatPRnI4886kppod50MeSpOYnMgzOCti0hFK/xg0kC+SgOAhuUTa1L597Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743311; c=relaxed/simple;
	bh=LNvnoYEPuJOC3Q7udUjfyXtGxEcwyGp7uy3bSHg159Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UFZkOChThSODIv8lzYGZZAJMxIlLLOW4bQ2Tlz1cQ2LwGAySzf9fFMSPr3PdtFY/wV9MGoGF9VN/I54Are9nMC40ZsDssgWCoawChmnN4NBSjXarvNBFVZdVJk8i5CCPcZMeT/pg+ZdPuFDH7+P64dlMKW96PBTKjAY+TYQXrng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ONi+w8mT; arc=fail smtp.client-ip=40.107.8.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6jHzL4aIjgUqzUC9iUk78VY+7e2R8UPyTR9uioJKksjVy8O5Ksx3LYtVwmMM05ZUSZmZgntEVp9Ly07SVKqLvRo5yd5W2o4RCJAu6M8suWbUu+xnv9EEg41CqSCuscsywTz2PipmBYMrW9U1yOLKOiOMxUP+7E6zcwi22d9aC1efd9hPEPY0JDFxRi6cEOMGeI1GH/jNAPsW2H0u8XR6qoYD3TBQfAmuMabiBAMq/WnuKFpJ4UdKMm6IGDu4GBreI7ShdsukChCv2d/AH5AxBLNbJ8fbkWEAojxs6EKvbP0kQTtcDuIzouN1z1o+UUYiWZIk/5vjLrgxa2N4fjipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTdoC8q5FApmt4DLfehA123RyfVCBe5apC77EnASDLU=;
 b=QlFXhhi4fK+98Zg4CoRVBWBDovi46kXU5FYk3r5Ag4yAhKpTLvUmllF4RjW5a6RXWCbheO8l5Fa6ypDsUPQ48CTuIacsiFOmvieA4BIEprmb5l2qDMJBygAhQEpzIle8wtgsBHQMgqyv3tve6Gv/LHr152ksIR7OEjNE69msVEhyTsHe4s6akaHOBI+rE7K45CCAL8E1VUnK334bhUQlbA2s9g7w/xJFB0yooLeqIDzSpimQMpYSIJSUjT/4gCDFcjPnLEiKrv9w/bwsz0j3tYW2VgO2V0pBRSjJcIB4w6j34j/GMwW2jFcWFOWZVnxvH35lZwv4pW+qfGckOQ4nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTdoC8q5FApmt4DLfehA123RyfVCBe5apC77EnASDLU=;
 b=ONi+w8mTgf0elc6jQPHznl7GHN5+Mf9m/zy/nQ5yeLzTBfvLqxpp26kPrs7QeBM4hYZacWDUutSmNesZhcvTVICVWMsBVGLWJaSBWsMBrevv7ysQwr9E4cMtI1YHSwpdzTiCMSCXWLmsY4v6luhI0C22EkAGkLa0xHcRHkBOd/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7396.eurprd04.prod.outlook.com (2603:10a6:20b:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 23:21:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 23:21:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 01 Feb 2024 07:25:40 +0800
Subject: [PATCH v6 4/4] mailbox: imx: support i.MX95 ELE/V2X MU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-imx-mailbox-v6-4-76f4f35b403e@nxp.com>
References: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
In-Reply-To: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706743555; l=2040;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lL3X7pJ74yWEAfSciMF66PVspSe1EXpJ2ahQLd5ain4=;
 b=i6/lCiQ2umyZUmJMNhniuiwQy9mXJA8EaTH/+NNH5USx8c/0JSX8+Imv3Dimnkj/lhrvZSfnK
 cvNEs+nZJn1DrkCJryn9eXr9vBuht1h7hhHcZk1aAmPGXBRU9K4rWD0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 744534cd-7f89-4a75-b66e-08dc22b36442
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zYO1/mHZLzc/9npkzLlRh+unuZm6Iz3sxBm+y5od/QUOrvoZrf6KDTlpOz78pRMESWxzJSfG7Ss/M3lave47ZNWjO+NgO0tV/JNiKO/hOXQzlqkIZTW2UAyeuOfq9HipWJld46jlC8vtk52KNpQEz+6G7H5MEqCfxMphNgf2rtRkoRApCpQMAnPZ01qcQOgvMWCwYiw1aRaSj/ql4dSbAIo0FbPpUtmcqTc9F6jcOQpN0rmbOqlkDuj1csF1FKjQJZp5yhqz0T5vgrrnizibVh3M2GHaDwuTGECSp4eI5fXZQjCA46ub3lnqBJdMtz9h8xCvOgQ1TL+qWf5dvBHeBVGj4JVgCaSpCPXb/R9lJ7VgPePeysQ/iVGFdf3UgLfEYU4fEWObYIicxdYJ739/EQWCGjicxpW52dosm1wlBJGK7bBIp/SuHVLomedXeud9QiIKfcI1WoUg9nkKfKqM0dqvS9Vbzawe/lqaIAW6sZ8jUatgcHSyyn33LsMQhLxs2l6Jff+EDSbnC8ATN2nkH8JyBRfscqAz8WAjvUsh8Dsj2qvCUfUJTU8ADi0pkiBW2JXc5D29RT+ydvgR3batydoPiz82cksyAbXzEF6N4/5n6XrOxyQOfcAmPF7NMAMrnrPXUh0PMUYlCzT/F0HlwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(921011)(26005)(41300700001)(316002)(38350700005)(66556008)(478600001)(36756003)(6512007)(9686003)(6506007)(83380400001)(52116002)(6486002)(6666004)(66476007)(38100700002)(66946007)(5660300002)(2906002)(8936002)(15650500001)(86362001)(8676002)(110136005)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1pKUFdNem4rcUE1b052VDZyVExDZ2Z6UXZLTGFKRGVBbTZIZm9VUWxPMk1K?=
 =?utf-8?B?VkJ6Q0cvb0ZqRU4ydGcrUTZPdXI0WVRzZHFyWVNDejBkWktySk1BakF5bXRK?=
 =?utf-8?B?YW9nQ1VweGNUQVZZN1RXN1haRkszWll4T1ZZdndRTHBGNEtra09OUnhqcWp4?=
 =?utf-8?B?WFhpOGpXU09YRnMvcjkxM1BNRmd6SFhxWWtrck8wdENUL1U5MmM2djA2U0Fh?=
 =?utf-8?B?Wm5pbERES043d1BSanR5QktpdWw4VXdiRWx3S2l6dDRsV0p5Q2gzRVlCQXMz?=
 =?utf-8?B?b2xSV2NGclAyYTZuYXN6L3NGa1l3VmdMZXRwQ1pUZlNOV3NPcWtaUWJpRU9F?=
 =?utf-8?B?V3NzajNHZG40L0hySld3b0NqNU04SVoycmtmVEZjbUF0aVVJajV5d3UrVFJh?=
 =?utf-8?B?c2ZGRld6eVVGeTJlYnBSLzlxaGZFWUdqc3dIS3JINy9FL05JVkQ2eTNoZDhj?=
 =?utf-8?B?RnRJNGc4dGN4dTNhVElKeFZIbU9rSkxscDdvWWNGUXFYZFYyS1dqckNzN2t5?=
 =?utf-8?B?SnhWUllTOEozK0dPcDVlL0pDMFRscU82ajB4MXN4NlRZbWxHL2RFSGM3Rzlw?=
 =?utf-8?B?NldoalBFNEFNYUJtTkdtZTk0RmtzdnY4VkxDMXVsdVBZdXJNbC9LL2tNMkoz?=
 =?utf-8?B?RHFUTHhvZTJoU3MxRWdBNDZwS2F6VWxNV1Flb0F2Y1EyTjN5QllFT2ZQaXky?=
 =?utf-8?B?cGFPakVsVEgzUlpRdGNJdjFwQWwvNDRLdTJ1dE9Vd3JEaUp4S1VLR2VXUlhU?=
 =?utf-8?B?WGRQTmZjYzQ1QXQ2YVNjdWxaNnpzc0t4ckxHcVk1NzYvUTladk9HaEJncmdO?=
 =?utf-8?B?Nm8zaUM1bWpNNjluRWVneHpNSFpnbE9CdFV0N0llNDkzSjZRTW1Yc0krRjhQ?=
 =?utf-8?B?SjdZKzV4WXhYeGRCbHpMbHVhQ2I2cnc2Rk9RdmNWdXhITFJZYjVIZkI1a0Jl?=
 =?utf-8?B?MXFzU0RIMmgzK0xwK09CN2JQZnBRSXlDNjNHT29WUFhia0k5WjNlZDR4WVR5?=
 =?utf-8?B?bGJOSnBkaGhwQlI1YXdqU3dLblU3Q0U4WVh3dSs2S29najJhZG9lUkUyNlIv?=
 =?utf-8?B?Z0huanFHZVpNUzlNMzUrNER5WWxheDdMQktlcStGa3ZBaVFDalFvaDczWXBK?=
 =?utf-8?B?Y2ZrSTFpdzNDWFBsNlFhb3QwNHh2SHRtR3hnSFpwY2lCeHpJNmloYWUrYjk3?=
 =?utf-8?B?QUwvY0lBa2JHSW1tbGN1c3ZUZ2xDWThtZC9nZTFTbG1YYkZtcmJOdC82cXUv?=
 =?utf-8?B?dUc3anN4RWxHeldkc3RqV21tOGhCZllBMXN1SEVUczdyQk51VUJZMzRQYnJw?=
 =?utf-8?B?MnFwMGp1c0l0Wms1ejI3Q3dlS2hsSzYvdjFTVCtaRXhNZG9LZkN1UjVueEYw?=
 =?utf-8?B?VzliQVhSQnZuYjE5R0xBSkVscVhCOCtUa2lvNzVuWDBFYXphTDV3MWZBcDJK?=
 =?utf-8?B?R3Y0SUZCbkxxaHozOXhDcC9XNDBKei9NQk5aTUEvd0dvcnhvdVhoaVVBai8x?=
 =?utf-8?B?K0NHQVZCT2h4ZWdCb2xpY1gxSTNENjlrZWJFeFFQSVVJNXl2WlR4QnNETUhB?=
 =?utf-8?B?TFVQSzJDejB3ckZta1hkaHdxVlZ0M3FnNjhKQWpWQy9iQmprdm1CQkU2QkhK?=
 =?utf-8?B?c3V4K2g1VEl6clRjbys3Y3p6dnY2RzlaVFMvcTk3U0tIcE1pOGtkaVBzb0pD?=
 =?utf-8?B?QjRSeDhRSVNJSzcxUEMxSHhOUzZHb2o4UkxhaW5tQ0hBSEU4Qm5tcG5RNHlo?=
 =?utf-8?B?b2JLcmxyVjVlUXlOVXY5cGdmYkloYVQ1NXI1MkxGLzhqa1FtdEM4VHgzbFdT?=
 =?utf-8?B?bGwxUTZHNUdidnJvbWVEN2tQV0orZjZvd29ycVZYNHRvUC83Ylh1UDBXcjZj?=
 =?utf-8?B?S0lTQ25vV1d5c3lHdEtqM25QeU15N09sSmVpbFY3NjNYSWpneUVQNzhtZ2ZL?=
 =?utf-8?B?UnVuTjVScUg1SmRLUTVwKzNubVVLamx3emVVd205Mm9ucjdlbHBTNXB6WFhn?=
 =?utf-8?B?VVV4bTd5Y29IcTBOQytFbUFyT1VjaXl0MWUzQWh6aUFodDh5NHFOUGtUTVQy?=
 =?utf-8?B?SmVrVTBWZzlqQ29RRS94Q1JEZnllK3ZHdUtvOXltdE9DRFRMajFNVGhZakZ3?=
 =?utf-8?Q?SNiOdJ92X22JIDRIVC4sy57Cv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744534cd-7f89-4a75-b66e-08dc22b36442
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:21:45.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2N9FEcRRNx42LO6D2fXV0v+29ahHb0/MoGLV77TLEYHnPXz56OanDZganphXBHIAOV7n2Cg6j2L8g6arltuIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 ELE/V2X MU support, its register layout is same as
i.MX8ULP, but the Parameter registers would show different
TR/RR. Since the driver already supports get TR/RR from Parameter
registers, not hardcoding the number, this patch just add
the compatible entry to reuse i.MX8ULP S4 cfg data.

To use the internal SRAM, need populate its sub-nodes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 9e89f773d2f9..5c1d09cad761 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -4,6 +4,7 @@
  * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/s4.h>
@@ -15,6 +16,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -919,6 +921,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_clk;
 
+	of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	pm_runtime_enable(dev);
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -1031,6 +1035,9 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
+	{ .compatible = "fsl,imx95-mu", .data = &imx_mu_cfg_imx8ulp },
+	{ .compatible = "fsl,imx95-mu-ele", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx95-mu-v2x", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },

-- 
2.37.1


