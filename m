Return-Path: <linux-kernel+bounces-39659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE383D4AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529621C210C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213B1B97A;
	Fri, 26 Jan 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kcmu0JYX"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD081B96E;
	Fri, 26 Jan 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250318; cv=fail; b=LQ+2J1SHYCbV+X2g+PZpT3ZdHzuUZv9/DDntJ06nTrkLtSvfdF81kbsDLkfvzRm3IJ7sbcW3oNNagdfTZjQKX4ieWm7iz3vvsT2jnGJGV1v2dWyO6a67LG62rmj8weQQXR1ph5E2HPolW6YOOMLVJhmDnuGW1Q1DtIg8bZ833Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250318; c=relaxed/simple;
	bh=LNvnoYEPuJOC3Q7udUjfyXtGxEcwyGp7uy3bSHg159Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=INNYHGANF/OSsRv+WZj/HHh2fyqDLKKl8Wth12jeThAxxD4xzJpLNw9UddyJDS3+UDrLYMIfcdcGe5ttCi/qggz+vrASg8bdUC3k54aM6IxukS/XDxgZeVn6i5NJEeE8jRbAsMzSdOZdsoEMxD6f2fnpeYTGORoDKehbtWdsqzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kcmu0JYX; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsSKWfsr0UXzs7m6G3x5jucnyTFHoZK8QUzkLSHPSRITU+SE6XERYtsk2wky36T0sVK6Jpm+24EnZnRMDmfHnoslxgXClumj0AHp8LuIVsE3VCerZHWzg/eVLrP1Re2HykDDpe9AfWWVQNEucn3WxCSAdUxVIDF0ZKvg/+nrFSXduYIsdTbhmVMVjd+B8q9TylbonPOn9NGyVJLvhMK1ve3HzqEXR7RFdaKb/FLPD2Lf6qLToWGr7LJy45VKchdRVIGPXt/AjhlhnJ26snZMCUs9N/oFznuBSdUJT3g6VOe14nJn3l8p3EjgzjDNK0vS/5AF0ChJJ8caucjEr6tMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTdoC8q5FApmt4DLfehA123RyfVCBe5apC77EnASDLU=;
 b=L3MZJkY9Ae93EaInZKmSWDAQchsjgpRTul3GD2MoU6nzEYsRlVaNoN34DTdJcqgBzLO/az55Z/Kwj4U/W4/SffBTXi/u/O8ZXWlr251+AYphLytAbLldvWTfCEGsA252KA0oVmbO/MjfvF/HsMJAEnzPzFl/whQVZDSdahHBLbXnAw2s57KcnAo6LTiQnAYodhaN796DfVbkAAHOCmBPxXf/qvPyeds9j32qt1tsEQaIyfaX5q+5JT2EI+Tmdr00pd5/S2vKIkO41VsayEuRgc2R6BUhcx2UIugWJDmI/ENTXHg9riDefqEVW/fPcpP5q2xWp4z0yAKHSzZR1W+sYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTdoC8q5FApmt4DLfehA123RyfVCBe5apC77EnASDLU=;
 b=kcmu0JYXmILovr85af8NoX6xa8g/gyrmnD56roaP8Q7rCb8AA2YCz5e0kJk+RP8k4kLTVglgWSZ8t7Ny1MLKIojULIIr8H3cbcPffT7ehMNyWQU9SNFtFLCg6qHbIWaIQQxT7V8fdGapz0eFXs2xodi0Xnhme8A35PmAlaJkSI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 06:25:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 06:25:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 26 Jan 2024 14:29:17 +0800
Subject: [PATCH v5 4/4] mailbox: imx: support i.MX95 ELE/V2X MU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-imx-mailbox-v5-4-7ff3a3d53529@nxp.com>
References: <20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com>
In-Reply-To: <20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706250566; l=2040;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lL3X7pJ74yWEAfSciMF66PVspSe1EXpJ2ahQLd5ain4=;
 b=J+poOS+xfDxcmBGVFyHoworU/w3Yx2Fc3hqow81smu1OUoH2vOZeZuv2pS+Cnn/8HT2j8PnQs
 G2WVMCF2Fc3B5erqavRs7MGGLf17tw4ntQdoHxNr/U3fr4B5fOhHdUw
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: e95fc1ac-e4ab-466e-45e4-08dc1e378e99
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zAqHiP4JvaH4DI2mRnM4WVW0vOjxxHBNwO7EHg9ZAsFvmzTJCjjcxLXQz45c3X6LAel8VMRomcidwoOM/c552xbTH45ml9vf9cNk/1vQm5BOPnRLpySZ9E/aRKdx17xiSxgxvKA3QaxBQrxHXcRjH1hBrBxttudMGd7GAbT7fH7rbaIxxc8dPQJb4gJoUPz+itNAj9NMiDkpr9/9jx7Ym2+ZBhs52jVftUZnpn1SDAaPZiaqp7aaaBBby8FDt4f2FSqXCGkrxr+gReePAKvRztoVVgj/0IB9mym50kNlxfyrzHM20Tzd4eeRO4sQbVGgL09VVeRZLdNdUlwYriW8i1nml05CzSxTF4Py+EW0m45M8F5PW6W1I5C2DrPPgIRT2Js44FCpoXTF49EOSn7srIjYP0+k79QWyZllPhFVds8ywnvxphLV1t3928lC0pAnG0Fn6TuX66ddpzI9lD+TFRs3sCCKyUZ/uK7tPsV2wUaPq1EqKZTywydcSTxGQScw3lq4Emq6hpyFtlW1XtobRsaCi4Oah+Nb0nHS536WBpijKO/Efw+61fBe1sLTX2EjQ4m5T+Ubk5o8cAxAGu29TE09vFdFu7wJpNrsnEUjHBOztJ9TXVpgeiWBM1C6ftmGnSjhEMLRZLlU6Y79AdyBLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(52116002)(921011)(38350700005)(478600001)(6486002)(36756003)(86362001)(26005)(83380400001)(38100700002)(110136005)(8936002)(9686003)(4326008)(6512007)(15650500001)(8676002)(316002)(6506007)(2906002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnFjdEprNU5yK1FsZ01xdVdNWGxkSURSY2d6R2FDNmI5QnV6OG1yclJDN1NW?=
 =?utf-8?B?djhUbzcxOTRvKzNzenduaVU3aU9iNUdRMXBDc3ZCMTkwcEl6VXVvWWhSYVFx?=
 =?utf-8?B?MlYreUNHSllFbU1DYzR5c1U5V2NLM3ZWZ2JjNlJtVjJTRUg5NTJLRnRvem8z?=
 =?utf-8?B?ZmZMV2xlaDZvaWdrRUFLYUZXcHZqNWNqWk9MMGZlek5UMnBYaUxaVW4zSGR3?=
 =?utf-8?B?YVRwc252ay94ZXNqOVFORFZSUnFENWtGaUEzcWc4Y01ta1pSSWc4UXdCWTB4?=
 =?utf-8?B?N2FxeWdFdldLeC9CclFXMTdndmFoV1VyZFFESVowYU11bE9PQUFKQkZ4eUYy?=
 =?utf-8?B?L3d3akpaSHBlb1A2UnoyN0YwWjdGL1pmOFVnTTkzVW1mdzI4TTJLdWp5Y1U5?=
 =?utf-8?B?RVdoWW9MYmIwNWNKUFRyeXQvZkxkeWhwTlJMZ084ZkMyOHhxZHg2MElIRjdC?=
 =?utf-8?B?TkhrQjliZU9jU0NzOEJrMmhiOFVoRGNQRFExdjd5Z0wzVnBEeUxGRU9Vd09K?=
 =?utf-8?B?NUFjWWdyTVE3YTNhLzRuOHNsZnJ4aXNvL0tWUVFsOVE1OWlmbGwyMEhRSU1r?=
 =?utf-8?B?OS9pWGVGajhGcVdlZytFY0VQQUQxQStoYzVSRnYycVZQeEVjSGo0K0ozcHpT?=
 =?utf-8?B?d20zY1NJcE1pdWpsdk5kV1Qzb1c0eU45OVlkbjhLZzJXS2IvVjhaNzhReUtS?=
 =?utf-8?B?bU15a2RjcnpxRDM4RXhFNWlFYWt0dnBmWDhrSHhORitOb2FJaS9wMVlRSmlQ?=
 =?utf-8?B?dlFRMWc5ZTFIY3BYYTB0ZTlLSUZFZnplMEtuWnFDTEtmaWFvNksvcUlzenhw?=
 =?utf-8?B?Q0dCSEhqQkUwYzJJK2pIL0NQMm1nWWdvdjdkOForTjA4T28raVg3TEdzaWJR?=
 =?utf-8?B?aENhVXB2NUVlRGZ2bzB5OEFqYnJhTVVIVE5uSUNEckhkQkM2RVIvazhCQjhs?=
 =?utf-8?B?NXhEcUNSNWt4QkI4bHdHSkZIUHIwTHV2cDVpMEVnVnlpa2gwV0hOQmQzeE9T?=
 =?utf-8?B?M1NsdFJmSTJ4ZEw0eGJLMEpFM1RGRVk1aFk0c3Byd1pHTkp3dXpiRW1WM2ty?=
 =?utf-8?B?UFRPemV3L1Zjb25vWnV0MnFNU3JzNGd6WjRsR0w5d3RLcjdQS054OEc1RVF4?=
 =?utf-8?B?dyt1ZFhqSFkyN2VkY3VtK0E3enFTMDZKN3hjSE15TTRpU1BFWTFCTnMxcnhi?=
 =?utf-8?B?Q1pmR0ZTU2xCMVZtd0ZIUkVBaVVtWjRwRTBMQ2dVRXhadW5nak02RGZ2RFVt?=
 =?utf-8?B?bjlwaGVCTUFINjFKY2tXQ1FLVWk3MVpDUGhEdzVvU0Qwb2VIRTdWVXBGZUYr?=
 =?utf-8?B?dTgvbEhjZW1oZnQwNmF4Q0g5N0o3ZFhKb3FxSDZNdVgzYUt1Nnk5dVVlYXdH?=
 =?utf-8?B?KzN4ZXJBVWJ1U1dERFFRbWNzblN6WEJzNlMzalRKZHVFdDJ3MExjaEE4djhZ?=
 =?utf-8?B?OVBzeUdoNWhIb20xekQxS2MxcDJxeUdjYStYOFNoNUZuTWx0SWRCdGdDYnpL?=
 =?utf-8?B?SEU4d1FMSUlXS0E2WVRiSkN1cUM2dXBtc1JtWllmTmMvSG5oOHNvN2dMaVha?=
 =?utf-8?B?alRjUDducTEyRmdXa1paemxsdFFWTlErK25kNEpyOVpDVWlZUWxLdWx2K0tX?=
 =?utf-8?B?QjlINjlUU043ZUJqOXFjNFYxUTNyS1R4OTZEdHoxZEptSmdIekJOczNzK2Na?=
 =?utf-8?B?am1VUzkwc1lXVi9LblhPOUY2aUFVN25tWkJKOFhHaHYrUUhkSXBrVkpIVk8r?=
 =?utf-8?B?cDlEVWk5UDlKVFZzb2VYYkRqbGh1NnJtbHdrOExObnRKbjZkR2Zhajh0alFS?=
 =?utf-8?B?TkFYR0dYUHUxdGRWdXdHRFR4emtURGR5S1hTMUxIanRjTlplQUhRKzlRdE5H?=
 =?utf-8?B?cG5saHVsWmFnWWNGcUd6a25vWjNBbzUyOEJrUTJmM21NbXpkT1J0aStDWFk2?=
 =?utf-8?B?Z0ZzRTZtZThVNlVqbklaU25HWkFJUXp3TlNTMG1icFpKNEEvczdEU3dkOWR6?=
 =?utf-8?B?UERaQ3AzSGp4L055QWtpQ21vSS9wUytCYTFWUjNFVU83MW82YU1LdmRRcXJw?=
 =?utf-8?B?aVJPYlB3V3pMR29PRzROTUVBbGI4QUI3REJrYVBXUjB3Tk85bUFBQTNZc1Bo?=
 =?utf-8?Q?9dONHNQ3rorWVZs3/dxPFuQ3f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95fc1ac-e4ab-466e-45e4-08dc1e378e99
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 06:25:14.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAbxY/Mmb9urY5q+FiJi8wtm8+gfpmnAxAixM8vZERv66Rj2bL4TbPr+YCrdKEXaX0GsLzpV12jvninHU/9DUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

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


