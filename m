Return-Path: <linux-kernel+bounces-70728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE313859B98
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7A91F2221C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B13200AD;
	Mon, 19 Feb 2024 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kcQBdaDB"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B61F952;
	Mon, 19 Feb 2024 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319685; cv=fail; b=ArSimMqmCJ6hYHGgk4lVAsNQZh+xziBCs3vvp5/b0W3NQmAffX/euzLAD8gsVJOoc3IM86y9aBIqGlsOliSzcvSuMSGiDVU4nxOW30o3m7/mBaDHsyOT+9gNFcP1Zc/TE4ik1FwTAKjndbvnhxC+9m+din8QXAyy0pbHqGB7wb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319685; c=relaxed/simple;
	bh=1OUZeDlN1amBP7+PYcW7CUkThMi2ZyzKUKprJgVUa7I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=syZr8zbQ+Jkzdw3qZF8SwyCr/CAvzY2VVGdofyu+Ch7PH8IVWFaHFAycbZbOv/AgsQFkA668+IrAsQViO39E13Ozm6h3xulCyFKMJ7Q0mJvotHEYvEaoIt7i4iT5wtVSA8w1f1iNZj8R4LpSiMmOZWWOhziVPB2YsBmLmPYV4As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kcQBdaDB; arc=fail smtp.client-ip=40.107.13.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGRDC+2DC6Sl/WQSnHTouPEwTEGbLj2bHXRC0gT6bwV2fXNb137Q3Xgxbd/9O38eDHPnDaFgcWdsNm7AZINf56r+krnrcw+gP7yB3+r8PBTfom5ZcjGdK2jOqny0J+LR6yYJAuDDktZqrk6DrWHjdwpLbeV9BZooYxaNrHYD8GwDIa2ZbWXXRuZsulxh+GSJDq0udiJCdDb28Pfb1AZALvP4ohyo0o+KqGqGZOnyfeHr/pFVONIAL5S7GyT9tEs/gUW5hKKFsU6GzG9QB6lGUECn0aNTyFHFE+Urw/NtdGzK/7X5/FPUqgbDJYR+1a6wl7a2HQTkmLeMKJjD48PPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptTIaebQcuxJRRqep4bFx/oKrRjiTx/N+usGnZnKIkQ=;
 b=XvxDjwPHf3Awqwt/J7lzZa0fE2L7d+QYMv4KX9sFfyigrh77XflEAxTxn4PrZLH5BD1ev3hP5G0abtiGnj1OaJ8Zzc+Ly+S7zbcBTx/MT+iSkQ9X1ayXVt1vQgPiZ0ec4SzP8ZqhvA+ti9wYgLtuvhDL2aaGpuXH7P3s156OayE49AHQMIq9ScT9v1TqjgytjIYLLcL4f+G5p184v1eY3ea9sD0VGkiFOI0HtLJVVsbIl8qRWWtHGPcgtPl4hTCN5qWk+Zi0HZdIJf0+U3bMNuxfw3HR8f7NHNfTkDuTXPGvregRDDh87/rfw3WdCLrXdjK90czv3tGzJtvpH0nuIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptTIaebQcuxJRRqep4bFx/oKrRjiTx/N+usGnZnKIkQ=;
 b=kcQBdaDBR3tVIzv0Z7GcvzVSlCcgGokbS9I+GzMW2QvA4KkAjuUP/moTYfTkrUGzYVFNvUgySYlYjOAD0VYHS1a5ia5b4C3Xj3v7VbBSDc7PXlz/UVSVLl8MI7ih+9DkIfIbs3SX4tamS29ZNbcGt+r5QMrQPko2qM22X287jgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 05:14:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 05:14:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 19 Feb 2024 13:22:40 +0800
Subject: [PATCH v8 5/5] mailbox: imx: support i.MX95 Generic/ELE/V2X MU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-imx-mailbox-v8-5-75535a87794e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708320164; l=1293;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SPNe0FKcSKFv7bAkLa3HwYU4wd0uFOj0fhQIX1FNVn0=;
 b=JkLHlv+RQDYB9b2S7rCIxheJtOGUm0n0JoFKrWONQ8555b7x+y49cShVFhfk9f3GJBPoQMHS/
 u7PPBZ6M0g3AcsKRYF6ja4ELQ6Kg1DQ//A7WXwgIIe5NwklcGWH3riq
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
X-MS-Office365-Filtering-Correlation-Id: c8b12285-309a-4f2a-f383-08dc3109add0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s6yDi4zvbvbERNRfJKFrSWULUwuTeeqFWHVIpFK3QYf5A2+dN7VRh5TVc5SR38XWNm4UvtFlC5b9TlHZTH0es5V8/tvGlkCKxeajc88b4mU8XOK6KIDRvEIBh6xLNHMfkZ/fakUk7o1UfgBMOREBZJmRR3Ih/HVk97k6y9KOdKVzRKsdoC7SXk/fgiUHF7pO/IwEU5dDZMhtDNJZbGuce0jDfRQenY5CEs/xvKwHBL9qBBGr/18uBFPtUSQNceiHXQCTEapq26pF8RabE+gyy00nhvhpO33InPl6S1y+E6VCrEymkVb020HcvzBPBbUvWZdmB93EEmcdrQbYq0FOph1x+OujHf9cbhEiFlZP11k/6ev3N1sRGCy5WiSGMMsnfTM/Ba0d2xJ0+Yq94mjE1ln+9wVod9VqYAOwGMPAmsmEhQUphvIOloca/BGSehl89p+ebb954/FdG6FiIBHcuwNMABc15yiTf12b/zQM3lr1gk7E0KxdJzaeUWAtxL+mXfWbjKq2RF0UWeTb+VWyMh7eNKN3sfyOcEXZQCJ0qlW2k0BU8q82Fo8+jHdgfdKyTOfiCXktV+zhc8gbZVDkdzPR0TIxj3BzbrkxlwjK1PiNiv7TNpZB18Fx/6qtvSYpC1WqwucAb4tP4dsrNJMV4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(8676002)(4326008)(2906002)(8936002)(66476007)(66946007)(7416002)(66556008)(38100700002)(5660300002)(15650500001)(86362001)(52116002)(6512007)(316002)(36756003)(6506007)(9686003)(6486002)(921011)(83380400001)(110136005)(478600001)(26005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V24xYzhIY3RGS1Arc0dCZjlGaWp1c0ZyV0RubzNpMEJnMHl4NXE4a1hzNmVt?=
 =?utf-8?B?UjVtUkR6S2MzcVBhc1BOOWRGdnJjRjRLSjFyRW4wYVJFZDByTERvTTllR1hy?=
 =?utf-8?B?MXVUNG9xb0s4SEUyWk9ZS20rbnljTnQ4aHBIYW9IOW9WVUdZQnJkWDhzY2gz?=
 =?utf-8?B?VWdwdGhkVGpXNngxbXBJeTdmOHJUeEZSY2R3emhRTWRpaXZsYWU5MmRVK2xK?=
 =?utf-8?B?SlBxRmhyNVVUMzAycjJHazFRRGhsQW1hOGNnT1VLam1sMU9GdUZwS3ovU3dP?=
 =?utf-8?B?bzd6YStqWEEwbW9KOUI2dVJCWVhmSEFWYzY4K2ZNbWFIZzNOQzZMVUpBSlFM?=
 =?utf-8?B?c0N1aDRUaU04Y2NSeW5FZk8rQ3F0amI5cXJKOFgwUTlOaFZsYm1MVXFjeDJC?=
 =?utf-8?B?RTR3cUIwMEJ0WUt6d0ZncFo5K1l5MXY5NW40bUZ6NW50djMxWkZkTExSR2sw?=
 =?utf-8?B?clpJa1FTcWVwK2wrR0dKWHEyVzNwNThpMkhIMDRzb1dxUUlVTFFYQXN4V3Jz?=
 =?utf-8?B?eEIrcFJCV1dvQzZqbDdqUEpWcld3ZzRkQ2IvQS8wSkZQbytRQzl0eHdIcFVI?=
 =?utf-8?B?OXFWMnVtaFdnSlVzU1U4bW9uVCtmZVlVcCt6Zzl3QUZWZmNrS25oT3VlSzV2?=
 =?utf-8?B?V1NIcUhadnRHL2szQ0NGbVRHSnE2cWxzTnhROW9UYjNKUm9lcEVyVTFodVNr?=
 =?utf-8?B?Q1NVYkUzbWd1WFBSSDNWMCtpOXc2VXpmZ3lBUWowb1JmbWRWbFZYTDczcUFH?=
 =?utf-8?B?OHpWVHBtbVBSMGR3N0hwcmpmdTRzNnN1MjZzblFkY2RLVnpCQUR3cVkyZ0xL?=
 =?utf-8?B?dW5Pc0NEYUx1YXphWnA1TjU1MDhod0RmQkdjK0ZzOG5sWUZSK3ZKZnNxTUlJ?=
 =?utf-8?B?SXVCUHp4T2dBOUNMRVl4ZTN3bU02Wi9aNHpocGluYWhzaWU0TDlRNjF0aXln?=
 =?utf-8?B?dVh1ZjVqRjhNZWwzcERLQkFUQlhEdEtMQXkwM2RMZ21HQlNTOExIdjJidjZW?=
 =?utf-8?B?a2NXak5ONlJRRmhURWpLYU9Zd0JCODBhcXMvczFZVU9hRVNHOE96bFJkR3V2?=
 =?utf-8?B?WDBWdVFxWWlOd2NzeWNhbVpOc3ZNYXRyRWJEVDBRWVdiQ29oa2FEYnJXeDVI?=
 =?utf-8?B?OXpmRHJ0ZFRvR0hJTWpPSVZ4NmxtYmJmNEFXQWo4cjJucEVRNWdwWVl5TnJy?=
 =?utf-8?B?bGh3R09PMlNzK1BzSFNueis0Tkk1RkxneWIzNHVVMnFkSUwzUEloMzZtdEVq?=
 =?utf-8?B?RWlIbWx6dEtTemd3RUtnMmcvb0ZEaTJMSEdKcy9lMVBnaXFTUHl6YnBOM0Mx?=
 =?utf-8?B?RGdBSTR4Zk1sdGxRN2dWWXpWdXFpZVFSRmExeXBnWW9RSFlsdzUvdHErUjV5?=
 =?utf-8?B?b2FOaVdreS9VS0ErVHRkaFVFYnRtanVOS1R5Q0ZMb0VOdTMvTFJOZHJnZzFT?=
 =?utf-8?B?cW1vMzR4YWNPNzZGTk55RnlmRXY2QnBRTVUxemhGOHZWTlNKRmdrRHRtcElJ?=
 =?utf-8?B?YWxsL0llUFI1VXdiem5vNkxvdlVIWVB6Q3ZmWjFuNERCemVSNlhrWmk1Y0Uz?=
 =?utf-8?B?c3BrV0xsWmpHSzJrQVlRVTRWcDJ4WllZejNOMDRWdWdQVWZaQzZTUCtaT0NH?=
 =?utf-8?B?RkRUb1BVZUVCeDIzT3dkRHNXd1p5eFJxeUlMRExndk44WnhOTmRhRXUrZkMz?=
 =?utf-8?B?a1lpU3F6OXdrL3lianJDUTl2K2htdFppRzFoQ1FrYVl0MDlqL1MrOTFzZ1Jp?=
 =?utf-8?B?d0dLVnJYOEEzSTMvNjZxN3R3Z3hYQTZpZ1kweWVRRC8zaGxwdWZmNEl2eEZp?=
 =?utf-8?B?dVBSeENPRzJsL2V3d3NtZGVWaHF4OTBXdm8vb1hoUjgxdE15WE1IRDcrdFRh?=
 =?utf-8?B?SUpwL2twcXg1QTU4T0orNldXTkRHMzQyeGJ3LzB5eTdHSmQ0R0tlaTMxajVy?=
 =?utf-8?B?RTFzUTFIWVRqWGZMV25Cc2l4Yzh0ZzZtNHBjNXNlV1VYRy9MSEFhRjdueEJC?=
 =?utf-8?B?YWExWWpwTUdEM3ZQZzhPYktmdDMwaHlGcVFwd0dDZlppMnF5cDRPUVdkNk8z?=
 =?utf-8?B?QXF3NnBIL1BqZnllS2w2TjZ1ZGxtd3RQVkdlVERsaVMzakJ5NVpXbkFXSWc1?=
 =?utf-8?Q?MhrGMDLpO8nKERE5rDc1FBjdj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b12285-309a-4f2a-f383-08dc3109add0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 05:14:42.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HQxyyNMEhhjXWXor9hsHNojaeZhe20rohGTxrXhwnZrZSxh9XiMv9zBS8ht/W2zf8PSHhLLcPrhI+V1AzbozA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Generic/ELE/V2X MU support, its register layout is same as
i.MX8ULP, but the Parameter registers would show different
TR/RR. Since the driver already supports get TR/RR from Parameter
registers, not hardcoding the number, this patch just add
the compatible entry to reuse i.MX8ULP S4 cfg data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index b36267591db2..5c1d09cad761 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -1035,6 +1035,9 @@ static const struct of_device_id imx_mu_dt_ids[] = {
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


