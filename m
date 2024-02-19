Return-Path: <linux-kernel+bounces-70727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292E0859B96
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA0F1C20F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E2200A5;
	Mon, 19 Feb 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g7YeAHHY"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676620DD5;
	Mon, 19 Feb 2024 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319683; cv=fail; b=V4rihHtAeKxXF+hS4kw+gqIqTq/JuS3qzIWBe+UR3H+/sRe4wFHZylaHdsZG6VV6HChg2iof+G01ZfeLZSuMsR6qFZpoOsdbJiJXaNdxyFjy6ibXTlizt3xJaiGMBflZd6+5q4lmRAu3xXu2tEvTbZpy90o1xPpj6qSJvYjJYyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319683; c=relaxed/simple;
	bh=pCeU+bTczyOqJg3nKPKJLkhMrLDlmg/Bi3NzPuoI1JQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bNdJnWKd0G9QpTTHbMwu5WTM+TjK3E0+6Z+Sm7LtUENIt7BwNH9f/OkRAhoZBBAM+UHn3IGCNn1C5w2FTpAHGZLEB5/kG2FMtujHKaT35gwCJiNb9DDttLCCdLN70WRcnrFkFyXvCT56hqah/04/Jb8oMyx7HNWty+Lnrm7XnOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=g7YeAHHY; arc=fail smtp.client-ip=40.107.13.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NagNDRFWCjR/W15elPSJ/CCP/xuXQ1l+LLe5Nxz1XtB4Uix/xMLXBcXyt0n4ifS7UsmWUtq5CiY+3vShm8S7NLRPd/Y65C3HpuVeP0RKeXrJc4agM/zt9VsNF8FfokeUE4uld/LkF663HD+1lpPBgTvt6brG0itALWb6J+lW2ikYQQRmmVpDt1kufndk5j/MpjdhPOA09nKMnnvGFMzZ5MD8Z3n6Z8i+kFYaQufWOVfZ8BZLFyxdf7NoUI/H7q1ePzDn6r+sYHOqDHlP+RxhzcVUFbbe4SoBLrkldXSNgac5Hu6l5PxqtEq2CvgIq5kqFc6AwsnQCJo+lvf0KCprug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvkBaNHIUgjGJ5yym/tBqi+SD6g5RuSBpWRmGGNYSaI=;
 b=PzoHRtJurAy4bq0mfwra8xlIeLyGpx3R5IV7/JcVVOYHZHNuHMEiaPGNquE5EpEm6IJTqEVdHU3VboXhXcsPZ2POUJvsNfwd3fnXgx/YicBP9mwg7HMxk5lRi4sGqNHYEpI0lLqeFm3JUsFPkpfR9ym+pEZ3ztLvsgLni//SiUHZP8X3HXynnDxP7cVfkZOo95EdKQpe/1nbWHDjsWZzS8ijljkUJeb0L/H4zvqicAjJlAvUpA9ZeO+5nvB9bL2VDxBAVMW3oGu99iA8USOhj7opM6PeTN4Yh4qZ4NtGkDFIB2qLiNDhttdLQKOAr8EiQ9+Z15l5kaUEbl0i2rRawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvkBaNHIUgjGJ5yym/tBqi+SD6g5RuSBpWRmGGNYSaI=;
 b=g7YeAHHYqDfX9x8sQ285vf6zwWl0/jxFmDsQ01SuRBI0DBWcQiWqJRwXHyuTEBCO2ck6S1IIHFZDP7MKSqCHXOQEis3N/ffA3riBgmf9FMdJIQS2I+YRttYnyaXfVYE82Xd4Nphhym3MmAKv9Oz07Hod75rwHbpR2fRKKw0I2x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 05:14:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 05:14:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 19 Feb 2024 13:22:39 +0800
Subject: [PATCH v8 4/5] mailbox: imx: populate sub-nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-imx-mailbox-v8-4-75535a87794e@nxp.com>
References: <20240219-imx-mailbox-v8-0-75535a87794e@nxp.com>
In-Reply-To: <20240219-imx-mailbox-v8-0-75535a87794e@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708320164; l=953;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zmP601mImThDTxLev7/0znMw6wmWmFmrzE1cC9FHOTg=;
 b=/3/HaJi+Vef9BHLHZ7pQtlvRQRBHaRyh+RoHiLrbdvd/dM5QoUAyUh7bgIbNg0yUffI/7v/+0
 yFAuTbkdLSCANhOcJ0/kLr6agoIHCVD+Wi/AKQvVVhY2HdRaDjIyKE1
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 5056ffe2-7b3c-4141-c04b-08dc3109ab4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mnYPkYodqqiNaFPKuFGf9xNItcNPeOWSPepsqmBlVG2ldiJ/TNGgnlCFFaf5qGZe91XpcleHVoWbuCTLYv+T8Cf5juN6Ux0rHNTIJnTpX63KnSZ6/+ShYCr3bLZaZavnG/SsK1fzlGBNrnZYfeo6LpF7s2r6nUsFFzC+l4Ys3CMpYXst82+tyBdtPi35UtPy7IpywuDFwXepG/NDRIxtoa3UDzVBTg1RYcRdnlCk7tjGa8yNugQyyNroID/cahkVS/ugsjcNNA6OWW6zg6KJy2cR8MYGAzGWmi1XKfYfGqW4zwfyG3QpN7Ld7jHCOJFVuefdKVpLqctiDIFmxTboOPzCZ8G+LPP+CgIQpR72B71q8QCrQIEA0G1u3DLHVSL0oCxJpU9YWS9jlHVVc9qP4lz5RQtBsIn0OmY+XA2bllfm8PVRedM9mow0BnM6wwnw9fvLrsuYWFr4bUfnq7gc7p2cAomLocFyJj7ytB8Kw3XPRLrXhm5zqiWNo4BF2/ASSwpvUmHEAhmiTs8vOHtOSpXQKKITGlL+F/EJ7cnyECwyoPt0W9k92yDE2bFf673bKI751kVxnzkXPcjVb6M/dAmFqTIzFWlQ+oECkpzv0djG9uLR4ahmPoiDdiwLp2o8dZp8TH0T/lqR3W4Sf0a2JA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(8676002)(4326008)(4744005)(2906002)(8936002)(66476007)(66946007)(7416002)(66556008)(38100700002)(5660300002)(15650500001)(86362001)(52116002)(6512007)(316002)(36756003)(6506007)(9686003)(6486002)(921011)(83380400001)(110136005)(478600001)(26005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3U5U2gwUU9kendRUno5SEE0N1I2UG1xMFl5SVEwRThGWVVoWEIzUjZKcVEy?=
 =?utf-8?B?L3JJZ1I0KzVjNTRiLzBuWmVwNkt4V2YvTVJMUTRSZHprNzRVNnRhTnoxRStr?=
 =?utf-8?B?MU1aK2RHam0xY1JnNis1aWRoVUFUdnBnOXdpdU1WVnJEUVZGTklyMWhwbXJM?=
 =?utf-8?B?Q2ZrYkFhK1JucnZqRkM0VlJDVmI0TFBxQjVXY1J3MFA3UjdIb0UyWFhhQW54?=
 =?utf-8?B?M1RwWERZWStJZmdhVDZCMGRVQXJXUzU5STZXaXBqWjVPWUJGOWJjNGZtSFM1?=
 =?utf-8?B?T0V1WDNVaUJJZ2ZzUDlJOGdxMkIyTXhyTjMrdzJMSTR5N0k1dlIxN1ljMjVh?=
 =?utf-8?B?WU9LMkdlY1hvVkZLb2Q1eVJHcXRSZnVDK0VTZHcrVVo0MXJ2aW55UHBrSU5M?=
 =?utf-8?B?YzZNaC9Wb1MxNDBMeEFUWTdjRjFPZGZxcFJvOVF0RllieXJKY3BndGV3dWpn?=
 =?utf-8?B?R0k0RVVJMGJSOHp6Q0JiOHEyVFFJcU1uam90ZzlIek5YRjlrLzJhMzl4d1RN?=
 =?utf-8?B?VktabG4xOGRwUGVBa1drR25xdGZCMXFzUFBVK2F2Yk9FYWZmbkRxT0ZjUzBK?=
 =?utf-8?B?VTBTVkZyQ2J5T0JJd2Zua08xN0EwR1Y2M0RhNGZkeHlSdUUydWo3NGdEWGFy?=
 =?utf-8?B?QkdnWGdoL0NsSW1yVkkvY3haa202SmlUSkk4NHVtZFNGd2RuVDVkQU5sbXNt?=
 =?utf-8?B?YWxadUtHNndZT3l5U3JpWUpMQ1hVS01CWkFJaGxPc1JWaHpjZUtpdlVZbENS?=
 =?utf-8?B?dVRDVTBNMXR1a3R5OFhPSEgxejM0NW9HUFhaN1pTWElTSUYzWHhMT1FCLzRk?=
 =?utf-8?B?enJvWndkWVdQK3pMRE4wRGVKYTZ0MUh4b0RMMW5DcDJGbGxEMWRTdTdDcUlF?=
 =?utf-8?B?a3pNMGUxcXRadnZvUGE4Z2grdzlsbEZHcUhEMmhYbzk5bkxtQnBMbG9FaGlm?=
 =?utf-8?B?ME9ZKzcrNUFzTDRWN2ExRDk3RzJ5NWNnSm5mL0RIVk9QOW1XVkh6TWNZaG54?=
 =?utf-8?B?S2JwbnFlZklSNzV1bkVqNWxLR09nUGdNRkIzVThuQi96eE4zREJmTlRjU083?=
 =?utf-8?B?c0d5aWc3TEt4RUNFMnpXMkxERXFRYmtTODNRb3YxaVNsUnl3QmdsVFd2aUdp?=
 =?utf-8?B?UmZ2WGhNTkFsNjR0SFp6amVWM3JSQ2h3ZVpoNnRheFg1eVB6RDhpY0Via1Zv?=
 =?utf-8?B?UmZVRWpzd0RGbjc3MzlPYk1FMUlRbjdQSTYzTHNuMWpremxqZU1ycUJVOFlz?=
 =?utf-8?B?QUZMYnN1V0F6eXA3N3NjMlorQVdZS2NtQ0lBRzdvY3QrTTJCMXV0VVBxYzd1?=
 =?utf-8?B?YUlHZTRURWZ0dzgvVXR1OUFoRU4ydmxHZE1yMVUvZmp4eW82MnYzUTNrczBV?=
 =?utf-8?B?Y1lLditHU1dQczBJUjFFZnEzTUduNlkwaHUwTlN0eDJFbmtFY2xGa3JDbU15?=
 =?utf-8?B?amdOZTBVaG4xdTdjUWNmQjZWakVNeW80Y01YL0NWNk1naVREdWhJVEpham1W?=
 =?utf-8?B?VWxOa1JlbW1yUS9vRnFYUjR4WC9IRUlJQTZwZXJUTXJvUHBTZmpYdGVPNjJ0?=
 =?utf-8?B?Y250ci81ZlhnK1UvYTk0alRhU2UrUWU0aDg3RmhwdmxUQ3BFSkkrRGkySEti?=
 =?utf-8?B?QThxbDkwdjA0aU9sTWpUT3RUb2VlOFBtelBoeFFkMXJkSGZGd21uOGtmbVhX?=
 =?utf-8?B?clRaQ3kxbno1dTZwejRoaUQ3ZjFuWVBlZHoraVJBcWVTSjIvMExLVTFDR3k3?=
 =?utf-8?B?MlJnVUFBV1hmbFIvYURCTjVseEgrTXFPazErWm1rdXhrdFcyNlVjSE1iQmg0?=
 =?utf-8?B?bWRuQ2lWbkt4enU2RDRDNk5XNFRqV1ZYMnVTZGw0S1crU0FtNGFKMk5Fb0dh?=
 =?utf-8?B?bE9HSkdTRnpZelpDSkkzS3lvTFlkd1lYd05nVnpXSS9LZm9SZ3ZGZHc4Mk5W?=
 =?utf-8?B?ajNCUFI5cTNXd085YytjYnNFREkvNG5Za1g5QjlGaEcxWDhlN1haVnBvTlQ3?=
 =?utf-8?B?Vnoybmd2ek03OUFqY1FPeHdIWUFsUnJ3Vk5LS09RYVFyWWlFREtmWC9ERFF1?=
 =?utf-8?B?QjdueWtCallCU284L3hlUzg1R2FSZi9lNG04WC9ZMDBweGI0aVdPN1U1MGpw?=
 =?utf-8?Q?8OtvfMtwRyduK0CRQsu31FbZj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5056ffe2-7b3c-4141-c04b-08dc3109ab4e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 05:14:37.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zSapXQplB6TPtmAEkXKkD9hoULv3OAAtbD4+s0OWXAG5xCLjVa9cQ50LfLAQsF8QuK3qqFaJSsWC69JP8ti4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228

From: Peng Fan <peng.fan@nxp.com>

Some MUs such as i.MX95 MU, have internal SRAM which could be used
for SCMI shared memory, so populate the sub-nodes to use the SRAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 306af1880415..b36267591db2 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -16,6 +16,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -920,6 +921,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_clk;
 
+	of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	pm_runtime_enable(dev);
 
 	ret = pm_runtime_resume_and_get(dev);

-- 
2.37.1


