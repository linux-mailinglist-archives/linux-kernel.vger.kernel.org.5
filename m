Return-Path: <linux-kernel+bounces-32266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D8835939
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B496B20B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CC2A34;
	Mon, 22 Jan 2024 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bRAC6I3J"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD62103;
	Mon, 22 Jan 2024 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705888936; cv=fail; b=P8/faJKHRhia3CtdKHrxlrNyt7S5RsZTrdyp0bO/wUNcE+j7gBORUZfK440OJW3BYDC6RRQj2yw+hwzqrXKpM2n1/1H1L69KdM9YVCAr65e4y9pArVVZu5rNIJiO6fG+gZE6Io/bksfC+pVKblDUCbj+MQ3+Pg327kpjw/SZH5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705888936; c=relaxed/simple;
	bh=Rppi4l+2cUbzP89VOD09YHTb/KvCtH9gc5rHbtx6/V4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=u2wItzqSEJLh4ZTfmSmLXxRpbOZPsu0CCJy6AZr0wO+w5Cijj7zxg6NTHjrmvhGYMLk/hIlswa/0YJxARKBp6yrXsh6Yc2PnbXhI3Yvbhq6vXOKR4a29NaA840fcRssUi9tzWJm9xROa25jPGxJ2b7ij68kPyrlEExgncKMlNPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bRAC6I3J; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxsc7w2v5TnxswYS5vXWbmpgyLfoCXooVBv/hVSpu3BjAhhO8Ielh8TW4qaq2CddCfSLruVULiFxjQiFtY7CxK9flYAUwY/h/ddLTyLzQB+uWUjLLqHrjQLN/tZkZrp42HL8QVIZT+OrXTidEsTVrQws7O17yf/R9Um99TeXMGw5gD2X+C0MaM3b6cHRib7sSLn/QK9eIOf564MZg4CY+mG0pfDx1dw9FcN/eHYecGsf61rxorbIrsHLgTce2H0DvZ3CkFpSwR+3T3THiqZTdp7ro7UY/c4uK1N/tP0K9A+2hwJD5ZpBSLaV59cYro1Z64ohUVUuc+/GKXxUahTQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he4OIZJtqx2Q7v153MilCDFIDshERVi2Xfa5pWrFZ3k=;
 b=ANAXQFWOwqEz1MTyFgAw+ZNbyvnwljINN3Eoo/Z47BbIjrPUOLuf2gdXOS7+RFaS5b6CVYJ6+5r0FGrr+yBF1Y8ZNCzN9jTg0lEHw4x1YUGN/A+FSPLC5dEtO6wiye45A+WVTpwsjTXZFFdVKXAR193dfkBaC2kCmuiCJ9WeHZ5cDoNWzbuaC51yzrID5MjjT2n3x0TLUAg5UaJpaJTUC9wwoHiBvoc2iT1+c+1erMIi0yyGLysgjlt3kCOQVDgb9kqLvDGyp9D0y8kgceY+/QsvP8XnHa40ZnSFHO4wPdtAQKU04uFN2hzBNkL4VO5vQACLy9RIeOV4DCXxhsXLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=he4OIZJtqx2Q7v153MilCDFIDshERVi2Xfa5pWrFZ3k=;
 b=bRAC6I3J9RZuHLoFQ9jd1fg7wbLu4riSX2RmnXImvEHhcXwKXos6TVPRSWijwqQPfxyz/qui+QZ9NcziD35r+ZIpBUWz2tqXEjDCQW182Q9q7uVNmdn5Ft08tFvfQxXbY4pw90y3TBI3SYYjDEFeogFeEcVuDpFajAp/uE7vZVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 02:02:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 02:02:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 22 Jan 2024 10:06:25 +0800
Subject: [PATCH 2/3] mailbox: imx: get RR/TR registers num from Parameter
 register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-imx-mailbox-v1-2-81413f655210@nxp.com>
References: <20240122-imx-mailbox-v1-0-81413f655210@nxp.com>
In-Reply-To: <20240122-imx-mailbox-v1-0-81413f655210@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705889191; l=4331;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Iy65IwSAFryjGNiSZCuX9XbUK1AgEleuTe1kp75FjPk=;
 b=4DTDySI4n47W41gW/HUXWgoid6rqmmmPrxiMmkNocsa7rjJdDuQjbrzHJg7pssV70slrQMtJe
 /n5q8UcUyulCxP2Zs7oKYVSNfFoh7A7mRuQzip0rHtevugnK+N8L0VS
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7b6291-00a5-40f1-a548-08dc1aee2543
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ntZM5BGuUHlDRZyguZWqqTarD/HQnYydv4KjRN7d/5SM6PjEeL6VZi3axQBbqm/rMVBSswp64x5xCddZTEDcLXncPetRMmz+huJpJIhxYn9nhEM+NcfKp7Ql/JiEE8IYjtRmd187KvkCEoDgX/fL3AdylGGVT3eniUAMvuBeWT2lTbwYLKt6IzatjAGLMLlO0Km5ywrcuwY0ANnzCSl+j4h6z+GLf5STCHk7uwdNQdQmxC7qFZcC1DLI4xAXZVV8N2Za4bdeWTVq0ipWp4e21eku5ZG7wPWLs0TwvxCvYLayfDTqjI3tMpjxJzE+oBmv4LqdtUViuEME9sOEzxFtOFTOegP4f4ihcqCXSwqRx5HvzAwM70683k5rhX4ziHiDsvO+gu+skslG77kTGPa7kjpumVMivV0+9MPy9CnXn3/zWuhHI/yctkTskfurdQxm25XJAvXKiNCAMiYyK1BAEuxExSWK0dCS9pQA8nGaGRNXsxFb+ViZe6L3VkLwDMx8nJBU9xVcBhi3xcJ4HP+d8oev0xTCoevj+o5LiZSGGor0bInBPAuDcmWa84jrcaNdMkLFRn9IL9LUClfvgkoJLeDoQO/eVMLDOuu7ZoTOCdowqD2XcZ47YMDv4YZh2y5yuqYOtcfMKSiDCr+Fv68ykQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(6506007)(6666004)(6512007)(9686003)(52116002)(83380400001)(478600001)(5660300002)(7416002)(15650500001)(2906002)(41300700001)(6486002)(110136005)(8936002)(4326008)(66556008)(66476007)(316002)(66946007)(8676002)(921011)(36756003)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlcyZ1VRY2NHYkVRaEhHMVdkaC9uc3Z5STREa2Z3Rk1ReGFob0xmQ0J6Z1Rq?=
 =?utf-8?B?OHZwNTJFM2x1UXNmNmkxeXVOZ0dOa3phYm1xWCtON2pHT1I3SXVGOG1rbXRz?=
 =?utf-8?B?YmZEZlF1c2RBNjJzdUM1N25DVmp0MzhISjVCZFdpekc3ZHluN2ZsRGxhYlJ4?=
 =?utf-8?B?bWluYWNjc3RrZHJ0aVltbmo4bVlNS201ek1kVzhCSm5LRXUwWHRvbS9vdW5i?=
 =?utf-8?B?T2tKN3Uycm5neVQxbGxoMFlxOU01VFd4ZjdWdkNXYjNsSDFTTkdsbmtkR0xt?=
 =?utf-8?B?R3djczNFQ3gzTXZVTjF6K3RqNDlwcGZFMmhxL3YvRzRJYUJWV2VyNUQ2Vloz?=
 =?utf-8?B?L2FaQlpaVE4wU1JxUVVkbDhvWG9PeEdILzN2bUtLdGpVdFV1a1hmSzRtRGxv?=
 =?utf-8?B?ZXNsc2x3cTByaEZZTjVPMmxPT24xbEZqalJVbDBSanYrWXFaWU5obUVUY1h0?=
 =?utf-8?B?M3Y3WGdmVnArM1NnbmFxalNlWkVka21jdHZZeDB2Mm1qb2JSeXdYZm5Ddy9S?=
 =?utf-8?B?ZUE2MjVQVWJ4N1ZMeUxxM004RVc5WjRBSlRTVGoxdkFvR0RBUW5EQXNad1pp?=
 =?utf-8?B?ZEluZzdtMWdBQWM5dENFcmpnTW03K21XUVlWSzJieFhnTGEyTzJrSzAzOUFQ?=
 =?utf-8?B?QUFITVBneThqc0VwYUN1NE93UUlBYjlLOVhITDg1amQ5WlM0b21RNWFmOGt6?=
 =?utf-8?B?TTlZUG56NEptR3BLTHRNcWtMQUw1bFA4R2hHeDNGUHVNK3o5eWdQcnRnSlVM?=
 =?utf-8?B?Zys1VENHaHI4M1RXOTl4SFk4OTI5UHZ4VjBLcjR4S014dEZ1NEpvdlpBWko0?=
 =?utf-8?B?aEJFb0VUSlhwbXFpTEtDNzYzS2xLaWp0bVlNSXM0VDFJRTNwK1ZrL1dnMm5X?=
 =?utf-8?B?U3BZQ3Z5SkhGTFM4R2xjVXJid05oQWVvTDdwNzBjZm5JZjBkamw2RGh4Qktn?=
 =?utf-8?B?aWlZcXJ3ajZ6c3FxL1gxZnQrd0ZTdkdISkcxTCtUV25GVW9TaWJxNkdXNnN1?=
 =?utf-8?B?U1hwZ3JxMk1FemJMdzd6dUpRZUcrQTFzUzJ2bmIyRGYwTklHZEZ0OGd2Vzhh?=
 =?utf-8?B?Q0hjSlFLQkdMTm1zRHZqRitvSlpEVkQ3RGEwTzYvc2VpZHF3bG1VNWVhSU1r?=
 =?utf-8?B?TElpblNDeTJ0aWJwL3FJVkE2UFl1SWlJclZ6aytob1NqclE2cktELzdSUWNB?=
 =?utf-8?B?Mi94Mjl1cnJscTFML0I4ekU3amVYT0tQaFN6VjR6eG8waVczby9UamZ5UjZz?=
 =?utf-8?B?aS8zNDNLZGR4U2paY1VkQWIzMFU2RC9Yang2dHdTMTZzWDRRa3hCelB0bmlp?=
 =?utf-8?B?VjlrTTMrK2dEMEVHM3pDRVFWOENhRGFVaXNCR3FjY1FHdEhjb2hZbnZvTzhF?=
 =?utf-8?B?ZmU4V2VrdnFxczM5RnB2YkpXeHJUZ09GOTZDV091Ny9GdGZNNHVRYzRMeGl6?=
 =?utf-8?B?S1d1eDhMSkxoQmEwS01OMEZNV3J5WmNrVkZXczczN0dQcHRURmJpWVFBMDI0?=
 =?utf-8?B?MnJhS2NqRlFQRzByRFFaOEtzdysyc2VqYUF1RkpOVWJxNXRLMmRaWjlKWGJI?=
 =?utf-8?B?aGFuUHQ4Q1hoVTl4UUxSODFEZE5RNTJPb1lET3dXSHV2b0NIRThxbHNWaUlS?=
 =?utf-8?B?VmtiL0dxVFJXTzlueE5iS0JuSTUxTHRhakhvdXJGM3ptSkxNbWQxbG1tUFRx?=
 =?utf-8?B?SElCUm4yZlJDVHZjbGVydjI3L0g3blcxa3dCVXMrRnMyNW5CSzBaQ0dKQURo?=
 =?utf-8?B?OTBuN01SRU1qTEVwdHZHSmtGRzlqZ0p4YlV6dEVwRXNyNjlQOHgvWDROMldC?=
 =?utf-8?B?a1dNdElkZzJHR2pUMTNZcFZ5aHQ2K2pOZVZ0ZXJsTExwV1BzYytPbmNaVDFN?=
 =?utf-8?B?Q3h4c2Q3SVhRaDNycWNDVDZXRW9PcS9VTWlQNXZmRDZQUEUvNnVkY1FTUTFK?=
 =?utf-8?B?NWFHRHNUQkFCZWZ3YnNaUk9nK3l1d0M1d1F5bkJFMm5ScDJEU0R3MHhjQ1Rx?=
 =?utf-8?B?VC9FankwOUVUeWcxYkM2TXF6OUMyUFdzcjFldStsMXc2ZXRBSWp0Ym16MXNH?=
 =?utf-8?B?c1ZERVV3dGdIUGl3NmxhWjVlNGFvVWhIby9vLzhSaGJmZWV1Y2lzSzAxU05z?=
 =?utf-8?Q?fob5XuLP8N1pcFlPh12g6C5Nd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7b6291-00a5-40f1-a548-08dc1aee2543
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 02:02:11.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOESyfKIYr2ai24U8tVkdK3QdZvYrxbpuhydCyoyMqW5gxHt+ZWg91ySo5Syqw7aw1qqpKyXqwZkXzo/CDp+dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP, i.MX93 MU has a Parameter register encoded as below:
BIT: 15 --- 8 | 7 --- 0
      RR_NUM    TR_NUM

So to make driver easy to support more variants, get the RR/TR
registers number from Parameter register.

The patch only adds support the specific MU, such as ELE MU.
For generic MU, not add support for number larger than 4.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 46 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 656171362fe9..f2a21baded29 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -29,7 +29,9 @@
 #define IMX_MU_S4_CHANS		2
 #define IMX_MU_CHAN_NAME_SIZE	20
 
-#define IMX_MU_NUM_RR		4
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
 
 #define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
 #define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
@@ -93,10 +95,11 @@ struct imx_mu_priv {
 	struct clk		*clk;
 	int			irq[IMX_MU_CHANS];
 	bool			suspend;
-
-	u32 xcr[IMX_MU_xCR_MAX];
-
 	bool			side_b;
+
+	u32			xcr[IMX_MU_xCR_MAX];
+	u32			num_tr;
+	u32			num_rr;
 };
 
 enum imx_mu_type {
@@ -264,18 +267,17 @@ static int imx_mu_generic_rxdb(struct imx_mu_priv *priv,
 static int imx_mu_specific_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data)
 {
 	u32 *arg = data;
+	u32 num_tr = priv->num_tr;
 	int i, ret;
 	u32 xsr;
-	u32 size, max_size, num_tr;
+	u32 size, max_size;
 
 	if (priv->dcfg->type & IMX_MU_V2_S4) {
 		size = ((struct imx_s4_rpc_msg_max *)data)->hdr.size;
 		max_size = sizeof(struct imx_s4_rpc_msg_max);
-		num_tr = 8;
 	} else {
 		size = ((struct imx_sc_rpc_msg_max *)data)->hdr.size;
 		max_size = sizeof(struct imx_sc_rpc_msg_max);
-		num_tr = 4;
 	}
 
 	switch (cp->type) {
@@ -324,6 +326,7 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 	int i, ret;
 	u32 xsr;
 	u32 size, max_size;
+	u32 num_rr = priv->num_rr;
 
 	data = (u32 *)priv->msg;
 
@@ -345,13 +348,13 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 
 	for (i = 1; i < size; i++) {
 		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_RSR], xsr,
-					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % 4), 0,
+					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % num_rr), 0,
 					 5 * USEC_PER_SEC);
 		if (ret) {
 			dev_err(priv->dev, "timeout read idx %d\n", i);
 			return ret;
 		}
-		*data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+		*data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % num_rr) * 4);
 	}
 
 	imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->type, 0), 0);
@@ -737,11 +740,30 @@ static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,
 	return imx_mu_xlate(mbox, sp);
 }
 
+static void imx_mu_get_tr_rr(struct imx_mu_priv *priv)
+{
+	u32 val;
+
+	if (priv->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(priv, IMX_MU_V2_PAR_OFF);
+		priv->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		priv->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		priv->num_tr = 4;
+		priv->num_rr = 4;
+	}
+}
+
 static void imx_mu_init_generic(struct imx_mu_priv *priv)
 {
 	unsigned int i;
 	unsigned int val;
 
+	if (priv->num_rr > 4 || priv->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return;
+	}
+
 	for (i = 0; i < IMX_MU_CHANS; i++) {
 		struct imx_mu_con_priv *cp = &priv->con_priv[i];
 
@@ -768,8 +790,8 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 	imx_mu_write(priv, val, priv->dcfg->xSR[IMX_MU_GSR]);
 
 	/* Clear any pending RSR */
-	for (i = 0; i < IMX_MU_NUM_RR; i++)
-		imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+	for (i = 0; i < priv->num_rr; i++)
+		imx_mu_read(priv, priv->dcfg->xRR + i * 4);
 }
 
 static void imx_mu_init_specific(struct imx_mu_priv *priv)
@@ -864,6 +886,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	imx_mu_get_tr_rr(priv);
+
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
 
 	priv->dcfg->init(priv);

-- 
2.37.1


