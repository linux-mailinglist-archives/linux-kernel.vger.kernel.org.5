Return-Path: <linux-kernel+bounces-32005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D873835530
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE08A2824B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4D0364C1;
	Sun, 21 Jan 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dnO0ROuQ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83FA3717C;
	Sun, 21 Jan 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705832303; cv=fail; b=A4cpZnlItMbrwqiBwiXpA8zytcPf0N2PXs0qefCxuFuUu7e93PcTr3h6yz2WZwkME6ji7cia+wnVAHwbBYGeUVhYtczmRs0Nhm5S2g8/qngJY7GsXO+huNqw6GWbx+GJnaqLsdXa5kfJ2rlaxbc6gxsO+3NIdCaOWpsQw4W2FPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705832303; c=relaxed/simple;
	bh=CtAxHrOnauvNEXKRPnZhPz1iuf4Kwi9eN4TQrsy7Rjk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TbnoKf1OChC0XqefkOmTTbnAiFhYzuvGjzxe7LIAq4MjBXlhD1MzwSwVxRFX5QjKNVS9rq2pzFiU8YLU84o7EWK+z7mydgYoVY1KjHqP6k6dVY0iQnM0ERvSrAGNzeTuehzvAaubAgapTu3KB43huZXoDE8bt8MEMnImk/+62g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dnO0ROuQ; arc=fail smtp.client-ip=40.107.247.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKFH3xOKEfxEPqKJH/tfk7dza7up21cGc0UCDSSwrFnbDBpAXwdAmUw2qJHbcHJWIepUQOeFksVEYx+o2aljQJn68KpVWsXqfPdmCOYFu/AweuzOQfEr1FuFMQQEeT3XNrRVVIbqNT9hLTSJcN9Dga/QnVFuokpjTnunleStwPqBParhjf3U6vq0e8cFW8LFV/LMP8B6nwROUb7WKMrKU6JI8bkGufFj4xcNrLu/INljOP/yTId/Dbip/ZAk4kNdL+6TFAuokuJvYOhgzGz68e3TKlolip62jVxPCN0yka2sj1PhobSKmJV6H3zs2E3wX7qzyorb4HWiW5h1xAr0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rT6Unqbl4epoaqFQxHa1b7kDdvy9IdeiekSFSbBjwdE=;
 b=DouMb60jFJ6OQTEznmHtNeyACPEKzlH9SAoisw4L1bivXLgNHx5L+B3RpAOA+Ee4Cfk1Wcy37jasuAw1cG8tkWcrA25MI36FPYaGi7D8J9jJmliNJnJOAvyu/xGLYoEuW+PUkcPEXQKkiy/SPE2Dc/FmC2HfNxHX3jL6JsMXP4iZSphAa831Bc2v6ZtMDYBhjuOb3kVZTRhYQI+e4CcgywQbRCF3pLzE1NiAIfxaoYjKSRUYSSjnsjy23H91Nt0Bim9R8WRk9zUnsMJYT4JF/yuUPLEcOwvTp5RfyMyBhdMX+4qJon9whARQWUpXol70e+3G63cjjBxZAD1QFe6GGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT6Unqbl4epoaqFQxHa1b7kDdvy9IdeiekSFSbBjwdE=;
 b=dnO0ROuQagJmRAsztU726s+rDZEZWsrSIHr7TRVzC+pViflHr+JJGz28N3PuvXY2sa4izNJ8o/EWn7eal6gh2qRWNXztCaab8oGZxC7ljSGHn5StrDvI6W9Nd865m40PoN3A+Fi8W72WIDwPLskD9C5tQ3A4Pa8Svh9ZphAhzR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 10:18:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 10:18:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jan 2024 18:21:54 +0800
Subject: [PATCH NOT APPLY v3 5/6] firmware: scmi: support compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-pinctrl-scmi-v3-5-8d94ba79dca8@nxp.com>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
In-Reply-To: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705832540; l=8215;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=TViQlBYAhDtOG+ioNWB5ll8oU9TAN814RFWQxW74rTw=;
 b=rL2RBmgQC8pJl2rdiDbJ+7tlD3ovlMFj8jx/i/MofOVj/7PlwMFtyT5O4tPlgofE/Q/Qt71s7
 aq9KafHdcL6C1qK496JvG4FIgMH2EX70G22dapLncUQwV3ftpNA3iN1
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e07ff1f-fe83-4e5d-47ff-08dc1a6a4988
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8FrS2cdhKObeQov5R2xdCFV3N3sPftMmBXKGDBhpDiyeeEeVGnGyvjlx+mA2Hb/LJI2cx0Xh/8v6vRjgmLSY2S7jcurWBAKnKtDfsLMQqwn6U0DDgfOvoT5GAwCi7mXR+N3QLCFToNypBGlEijCI6nXZf6f7qZqpglyG+iGESzExUJQfYW7v4t9pIKD9y9BG7HWJ8t2oLx1j1i7lj9b12FKQtOc4j+oqCwx3SnhvdpsvbB+r1t3SdmbetbLtP4vwNioChyvcL7SLqdbJVfhG5SPBhO9u0U0Ojapab9eCjFB+RPO+6WFnxUE3Tnesz4N7BqZnyk16RqIyvAStMX2iHA/tixUoOXsOMjv3bfrXkgkr8V6GndD+bFs/UCCymEQgyoOr8AHTyZU2b8Alw2CbjXpwT+m6jPk7eg9QA5FNGPYXwksScIz8Y6GiDKskGWwCfrmsC9gxk4/AFVmMlzxHJstYghTkvUHROjb1lht2T1wcN56gK/Kp+Vs7DRzjV9Nr0u5up3uau1QayolflZWoi/rDLcFOhNoAPO75k3MNR/o74IqX45gmo7pCWzZLxktCoAOKlGpz92/2jp5IFMZt0GEsHGUw0GQ6NuP8sJFU0M4MTCfYmQ7t9a3eF/fXJiLlF2DGjlSohdlx0RhVfMLyGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(38100700002)(26005)(4326008)(8676002)(8936002)(2906002)(41300700001)(5660300002)(7416002)(478600001)(52116002)(6486002)(6512007)(6666004)(9686003)(66556008)(6506007)(54906003)(66946007)(316002)(66476007)(110136005)(921011)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGprZE1pSTdxT2pydHZVbmFYdVhFeFJrYlFrSHkxWHJvSFVQak0zRzlrZHRm?=
 =?utf-8?B?SWlHeElUN1VUVlkwVkxhNVREQmZGNU9xUlZqdzhzZUxHRlJtZi9vRENWZ2Mw?=
 =?utf-8?B?OVpIc3RrRlRMMk04N3VlZDhLMFNvRzNpbHNWUy90YTBWOFJEQWpZcnhxUW14?=
 =?utf-8?B?OFkwQmw2VjJaVjRvb1JpWGZyZm9CbTkrVHoyVzNjeFA2dEpCSTREbnc0S3N4?=
 =?utf-8?B?V0pwYkRKQnoxYmtLdmJRcEI1RTJGTG9OdGhaZTNLYmFqNUpUVlRDUnpiZjAy?=
 =?utf-8?B?VXFJL0s2WEhQb2FKZmFhcThZdXQzdmE0bDVKZ09LMStUdUJFV2dJeWhYRGNo?=
 =?utf-8?B?UE4wSXh6UjBIRFcxaHgrdkwvQUJEVHBDZTZyZzU0TjRXT0ladFFlOExMcS9p?=
 =?utf-8?B?SFB0bW9zMlZNUCtaR2Z2ejUycWhXMlJnckdrRFAxZCtDejJGd3Azd2psMysz?=
 =?utf-8?B?dHVUaHczT3l6UjE3V2gyRE8vWWQ5ZHZ6UCsyN0Q4WDJTQWU0SDVDS0RkK0Vv?=
 =?utf-8?B?MWhoalFDSUo5SFNHWXh6ZDE5cWRoUE9ZRW42bEpKdnFmTHJqRnh5YTc2cDh6?=
 =?utf-8?B?VWNOdHcwc1lXV20vazdySGRvenRKemVxNHVvUjZhZlZkcXNnVkx1OGxHSzdn?=
 =?utf-8?B?KzJlajluSHdyUmdJQW10SFErUkdJNElQRHMzTWxLZ2hnSzFCRFRsUDhCeGRk?=
 =?utf-8?B?NStlRUw1M3J5NUw2UWxqWE9QRkFacDZYUkp5K1ZEUUNQekwxM2hacEFibEFR?=
 =?utf-8?B?ZGZlZDBDL21pZHBCWEVtTWdGVU05QnkwL1FjcUFrRS9Iem5Mclp2QzNyMTFQ?=
 =?utf-8?B?SnFxVXFMSjBHYWhDenJMbUJwYktCbWpnOGxpSkMyVmhsMFZEU282ZlFpN2Z4?=
 =?utf-8?B?TVY2eWR1MndoOHppWnBVOUg5YlNEUE0wMnpLR3FucWVUQlhMbzkwUXRVRnJl?=
 =?utf-8?B?d2pSdzR0UEpMR0l1Y3p1bU15WXVUNGZFVVIrSlMrMGRqd2VwV3NmWUF6UUNl?=
 =?utf-8?B?aFNGSkRlODVBMmJhSFNtUEx0WEZjRTc4T1JlZDdraE5MRWJJRFM2K29vaDRM?=
 =?utf-8?B?RFFFMVRLYURVZjY1S2IxY21RT1BJeVpMekhOSTFzWlAyNXlnTlFIaTBwMTZQ?=
 =?utf-8?B?eGtkekttTU90ZERqSnRoVUpIZDhISzJoTG5nZ3FxbDZPU1RpOFplTElBYTlE?=
 =?utf-8?B?WGRtZU1NbnJvS2N4S21WSjMvVnFYY2tKVVhiMzJ2MFFPU1I0NzM1UzdicnZh?=
 =?utf-8?B?S3R2a3lFSU5KWGJNVHM5RmF0Njl6YkdtVnNyRW5JaWl5dXVJc1NWSmtWVGIw?=
 =?utf-8?B?MDJxdUtCL0NFdXNNSDRHbzFuK2cvTzVrb05NU29KY2ZPcjljMFNmeHZGVjZW?=
 =?utf-8?B?ZDhqdVo1NHBwOGN2WS9mMjN1YTFRNytmdzMxTGhja0VsaTByMnNTMU1GV3Ny?=
 =?utf-8?B?Z3lDYUlQQ3NodHJ4azJLTWovVjd5cFZHUGc0SWlZdEtRSGdWYXhFMkVOMEZ4?=
 =?utf-8?B?c1ZRcVBpcFFxMlhEUVIydHBxM2dIVC96cHZHMTFHTk1TdWRVNHg0VFJBRWJp?=
 =?utf-8?B?S0c5b2pBOTIzTVhZUTV2eXJtU1hvZkFmWGg3aTNUazREWDROTzZ4NHpOWWRl?=
 =?utf-8?B?TUpxT3pmRVpBNHN4TmRXWHplajNjVEM2NkRKQnlhT2JrM0FrVTlQTG5SdHhN?=
 =?utf-8?B?NEwyekgyelVOTEdocitJT2Z4VTAzajgvOGRmVC9TSWZMYm9vcEl3QTIwQ3RT?=
 =?utf-8?B?aE5CbHNJYk4xbVMzOW5oOXM0RFZWTHgrUVdDY2pHM0kwSUhwOXNnbUtKcU1J?=
 =?utf-8?B?bVRXR1dDTDBqSEVzNTRuZXkwNEh6WHNsanZldkd2WDgrc0tZcDFpVWcraHh5?=
 =?utf-8?B?d3VtSFBCOG0vR2RaWjVUcjhMbGdHVE5najQ1QVIwQXZMOVQzUkJSZU5SWlIy?=
 =?utf-8?B?L0VHMmttSzF4eTh5T3hSb3Z0aSt4MUx0RDE1QnZIcmhlZlk1cWlYcFhDT2tP?=
 =?utf-8?B?Y2xGZkdBWWpNeVlzVHJROTFoMjNZVm1zbVJzVXcxZzM4T1NBMEt6bll5R0Er?=
 =?utf-8?B?RmN1MHVxaDYrMW9kQ3BkUE9yWEd6SkJxTkhCUWpxc0NnZk1uSDVpakFDdTNs?=
 =?utf-8?Q?rEy71LdN8urONY8WOiab7OOkM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e07ff1f-fe83-4e5d-47ff-08dc1a6a4988
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 10:18:18.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDcXWDSgGZlPZl9Ku4MATL1ukgLamtCnWWCQ8yY21WddppJ3KQlXqpgWgNftfZCGUn1rRf4gcd++OgPishV7ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203

From: Peng Fan <peng.fan@nxp.com>

i.MX95 use SCMI PINCTRL OEM config type, so it could not reuse
pinctrl-scmi.c which use generic pinconf. Then need introduce
saying pinctrl-imx-scmi.c to support i.MX95, however both
pinctrl-scmi and pinctrl-imx-scmi driver will register a pinctrl device
with the same of_node(protocl@19). This will introduce an issue, because
the pinctrl subsystem will use of_node to find the exact pinctrl
device. But with two pinctrl devices registered by two drivers, it is
unknown which pinctrl device will be chosen.

So introduce compatible string to support cases that Vendor SCMI
driver which does almost same thing as generic SCMI driver, but
has some specific Vendor settings to do.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/bus.c    | 39 ++++++++++++++++++++++++++++++--------
 drivers/firmware/arm_scmi/common.h |  2 +-
 drivers/firmware/arm_scmi/driver.c | 15 ++++++++++-----
 include/linux/scmi_protocol.h      |  2 ++
 4 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 1f9735dbebec..9043f6366fa8 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -214,13 +214,21 @@ scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
 	if (!id)
 		return NULL;
 
-	for (; id->protocol_id; id++)
-		if (id->protocol_id == scmi_dev->protocol_id) {
-			if (!id->name)
+	for (; id->protocol_id; id++) {
+		if (id->protocol_id != scmi_dev->protocol_id)
+			continue;
+		if (!id->name)
+			return id;
+
+		if (!strcmp(id->name, scmi_dev->name)) {
+			if (!id->compatible &&
+			    device_property_read_string(&scmi_dev->dev, "compatible", NULL))
 				return id;
-			else if (!strcmp(id->name, scmi_dev->name))
+
+			if (id->compatible && device_is_compatible(&scmi_dev->dev, id->compatible))
 				return id;
 		}
+	}
 
 	return NULL;
 }
@@ -345,11 +353,14 @@ static void __scmi_device_destroy(struct scmi_device *scmi_dev)
 
 static struct scmi_device *
 __scmi_device_create(struct device_node *np, struct device *parent,
-		     int protocol, const char *name)
+		     int protocol, const char *name, const char *compatible)
 {
 	int id, retval;
 	struct scmi_device *scmi_dev;
 
+	if (compatible && !of_device_is_compatible(np, compatible))
+		return NULL;
+
 	/*
 	 * If the same protocol/name device already exist under the same parent
 	 * (i.e. SCMI instance) just return the existent device.
@@ -425,6 +436,7 @@ __scmi_device_create(struct device_node *np, struct device *parent,
  * @name: The requested-name of the device to be created; this is optional
  *	  and if no @name is provided, all the devices currently known to
  *	  be requested on the SCMI bus for @protocol will be created.
+ * @compatible: The compatible string
  *
  * This method can be invoked to create a single well-defined device (like
  * a transport device or a device requested by an SCMI driver loaded after
@@ -441,14 +453,14 @@ __scmi_device_create(struct device_node *np, struct device *parent,
  */
 struct scmi_device *scmi_device_create(struct device_node *np,
 				       struct device *parent, int protocol,
-				       const char *name)
+				       const char *name, const char *compatible)
 {
 	struct list_head *phead;
 	struct scmi_requested_dev *rdev;
 	struct scmi_device *scmi_dev = NULL;
 
 	if (name)
-		return __scmi_device_create(np, parent, protocol, name);
+		return __scmi_device_create(np, parent, protocol, name, compatible);
 
 	mutex_lock(&scmi_requested_devices_mtx);
 	phead = idr_find(&scmi_requested_devices, protocol);
@@ -462,9 +474,20 @@ struct scmi_device *scmi_device_create(struct device_node *np,
 	list_for_each_entry(rdev, phead, node) {
 		struct scmi_device *sdev;
 
+		if (compatible) {
+			if (!rdev->id_table->compatible)
+				continue;
+			if (strcmp(compatible, rdev->id_table->compatible))
+				continue;
+		} else {
+			if (rdev->id_table->compatible)
+				continue;
+		}
+
 		sdev = __scmi_device_create(np, parent,
 					    rdev->id_table->protocol_id,
-					    rdev->id_table->name);
+					    rdev->id_table->name,
+					    rdev->id_table->compatible);
 		/* Report errors and carry on... */
 		if (sdev)
 			scmi_dev = sdev;
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 00b165d1f502..ac0d83ed5803 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -149,7 +149,7 @@ extern struct blocking_notifier_head scmi_requested_devices_nh;
 
 struct scmi_device *scmi_device_create(struct device_node *np,
 				       struct device *parent, int protocol,
-				       const char *name);
+				       const char *name, const char *compatible);
 void scmi_device_destroy(struct device *parent, int protocol, const char *name);
 
 int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 4c3752749105..b78fce62a0de 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -261,15 +261,17 @@ EXPORT_SYMBOL_GPL(scmi_protocol_unregister);
  * @name: The optional name of the device to be created: if not provided this
  *	  call will lead to the creation of all the devices currently requested
  *	  for the specified protocol.
+ * @compatible: optional, the compatible string
  */
 static void scmi_create_protocol_devices(struct device_node *np,
 					 struct scmi_info *info,
-					 int prot_id, const char *name)
+					 int prot_id, const char *name,
+					 const char *compatible)
 {
 	struct scmi_device *sdev;
 
 	mutex_lock(&info->devreq_mtx);
-	sdev = scmi_device_create(np, info->dev, prot_id, name);
+	sdev = scmi_device_create(np, info->dev, prot_id, name, compatible);
 	if (name && !sdev)
 		dev_err(info->dev,
 			"failed to create device for protocol 0x%X (%s)\n",
@@ -2354,7 +2356,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	snprintf(name, 32, "__scmi_transport_device_%s_%02X",
 		 idx ? "rx" : "tx", prot_id);
 	/* Create a uniquely named, dedicated transport device for this chan */
-	tdev = scmi_device_create(of_node, info->dev, prot_id, name);
+	tdev = scmi_device_create(of_node, info->dev, prot_id, name, NULL);
 	if (!tdev) {
 		dev_err(info->dev,
 			"failed to create transport device (%s)\n", name);
@@ -2550,7 +2552,7 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
 	switch (action) {
 	case SCMI_BUS_NOTIFY_DEVICE_REQUEST:
 		scmi_create_protocol_devices(np, info, id_table->protocol_id,
-					     id_table->name);
+					     id_table->name, id_table->compatible);
 		break;
 	case SCMI_BUS_NOTIFY_DEVICE_UNREQUEST:
 		scmi_destroy_protocol_devices(info, id_table->protocol_id,
@@ -2802,10 +2804,13 @@ static int scmi_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(np, child) {
 		u32 prot_id;
+		const char *s = NULL;
 
 		if (of_property_read_u32(child, "reg", &prot_id))
 			continue;
 
+		of_property_read_string(child, "compatible", &s);
+
 		if (!FIELD_FIT(MSG_PROTOCOL_ID_MASK, prot_id))
 			dev_err(dev, "Out of range protocol %d\n", prot_id);
 
@@ -2828,7 +2833,7 @@ static int scmi_probe(struct platform_device *pdev)
 		}
 
 		of_node_get(child);
-		scmi_create_protocol_devices(child, info, prot_id, NULL);
+		scmi_create_protocol_devices(child, info, prot_id, NULL, s);
 	}
 
 	return 0;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 32580a4fd724..659a8e910bfc 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -914,6 +914,7 @@ struct scmi_device {
 	u32 id;
 	u8 protocol_id;
 	const char *name;
+	const char *compatible; /* Optional */
 	struct device dev;
 	struct scmi_handle *handle;
 };
@@ -923,6 +924,7 @@ struct scmi_device {
 struct scmi_device_id {
 	u8 protocol_id;
 	const char *name;
+	const char *compatible; /* Optional */
 };
 
 struct scmi_driver {

-- 
2.37.1


