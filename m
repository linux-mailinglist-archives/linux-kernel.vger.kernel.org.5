Return-Path: <linux-kernel+bounces-35456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DDC83917C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512FA284DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7955FDB9;
	Tue, 23 Jan 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HqEOny0L"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20F5FBB8;
	Tue, 23 Jan 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020483; cv=fail; b=KPa+xEHm2c18kvusUh7BbcUphl/gpgxXlU04j2kC+/DGAJrLYdJ8oV1EdzqEEruQ2jbMuAu10LpO+DpERppdPdKcffe7e1Q7zxvBBrq3/JoKDpjLfQH0toIRB2RPDVQRG2Pnr6xuyfav2FWzptRPt1xoSHY4w1DLOJWsuba8+bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020483; c=relaxed/simple;
	bh=Ytq/YKUFw5O5WUHiokG4DeEcdEZDqmMhKqH3lDOhYL8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NyATQUvtrFpawl2izJDYEjHNh5FUfqs9uZEn1tL7Rw/bwRL71ue9uy7eONcjqH1+f4+tA1donhkCAqRO3pnNW/A2vm7D3ZTJEQHS3uDNoz17BnV1GIc9wuYB5+FZrMnr1FqYEU1/gd2C95AfXKqJW370AvAuECEWMdt//dS6Erk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HqEOny0L; arc=fail smtp.client-ip=40.107.105.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCDXee2RzRF3616cVR3D8Vmn4/qjFWjnALy0OmLCqVNdCAr6tMCuDOKQQcqJHVcV+Y1AWy9FhxucAfGDw6kYw9aTQap+p/CvsO3ivHaEJnos738T+AGaen1cqyrIQC6jmfNA7NkxN8FVHoD4SpsLEmfjw4ENza1Vhq8dbPPMxugiF6viFiHQcb1BWR6cs9o+9fmzel7n2Ggupgd1wAF+yj0nZ2eM+G9mvIE9hfSUdqJRIYc059OG+EYubZJIA0wcfiOaeL0//R2ZNp4ZUBwDFa3VD9ixlZtLFf4+u9oKIg9YyvKh+VoWIPBBJXP14pSze/GTYUghpBv5pSM5aAZOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjHoK34g7+uBu3xT/B+UpWr/KWX8YJRjxsgH0FR0FB4=;
 b=EL+CRCfqs6CNZ22Ajl+CrRkD65wlprgvxRBauD1IrFuMrHERoujv5ci3jVftqMr2G7dzL2zz5ixqBN/+ANdaJcOAyLBFZ9CzzmIg8Btbndag5mr03875FIPiT2ZuonqYZZKysq5IPKPy0SK5svoMAl0n3XiI3hiqUOatNVNgYAkSwRM1WfUj4imJGTRc/z9o0Nd0cgP6Tz0LtEGlJGKNmJJJ1DDtQsYPtel4u31IjCUfThI7Xa/Kyi7zEMMjEuWPQk61x5d13mQZbYd9H+jRsG2McNlkML6cMQHIopSyTw9O/aVqeCf8yohBsc4oX5AY1YCBQJ3NzpaHo8Zwaonsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjHoK34g7+uBu3xT/B+UpWr/KWX8YJRjxsgH0FR0FB4=;
 b=HqEOny0L73W2HogCyeuC4KXN8MnQ6HQ9956Ee0M790eKR6O5ydKemxI0WUNOeLPJxZvyswwXV9xn9y/B4IR+DYiyUZlwAGC9gw79qukQppTYEIvlOwWqtEEhiAEst1MscheJg5eRVin+/+yof0hEsx3mEdtKxjzShD/Z6urmLvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 14:34:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 14:34:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 23 Jan 2024 22:38:44 +0800
Subject: [PATCH v3 3/4] mailbox: imx: get RR/TR registers num from
 Parameter register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-imx-mailbox-v3-3-ed932945e0bf@nxp.com>
References: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
In-Reply-To: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706020734; l=4299;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SGrBffeqt2EmFannia/RLKGbk1G3zr8UaibaUsZBgP0=;
 b=Brgp/Gq4wbV6wFyz5OItN1mh7PRxzj91PGDVVJ/MbzF50cNQyV8jHIDW+O9hNpF7JTaFMmvqQ
 puu6+hyqw5PAzn1GlYbLj1SYSzpoIYOXKUtfOTLCqqJDnX7FB4jpuy5
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aedb9b6-8e35-4142-6903-08dc1c206d12
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6J2dsXWvIIYGl1cG4c6O+ldCPZYY3lXdR0C7rQ2B+T6punRaOisdQfJ7x7bpJnDy3VN7ZfkphSjIiPWZQE3Cw7XX1HFWQ6ZbdodFgBreRfzjJ92tIOXMlr46IjqSGiuYE4MQsyAbNF/Q5vopBRDvt4FqRRkrhcXaAQLK9tgsPuvx5/mzqj+aTR3Ay6+xWHX64G2s6qMT0SRPQ45jBQGgOSGWhJXJijR0YSRbS1ErGrucg1nkeb8Q3MBCKmBSugfXq16lTEgybzfPP7ZUvMd0N/3TeRCbMgTfrmykPSUwmWHwVtUNOCe0s0ZuH0ZgHcWhSu6ocoYqRVwEB5YK2fF7MrrBXLxDp3l5TiIK1csqnmpEKhxylTclgDc/m/1PjA1mCg45UVgC/mvwj1pLtURyfN4ZNDIfAWjl2XbjLg6CA5zjzOqKqaSwrxlDZNEq/DCn+e3C2E6pMZt6ezLv7mE75RGpYQbd4TwoNERQ3o/C4fTJJ+1g7Hzdzy/oDyinp6kZxm0woDulCmXm18VP8lfF+Qk9RkWc0RGqSPa+BD8Kb++ql8N+4D4MDOcXE8PlbznpYGE/PXsUU8+Q6VxpJEQbkwXxO4A1TsM1aVFaCf72/RMwJoiSFY65bBAa9XM9tDpG7Q4Oe+a87kev8Kz4boJRuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(66946007)(66476007)(66556008)(110136005)(316002)(26005)(6486002)(6512007)(6506007)(6666004)(9686003)(52116002)(478600001)(83380400001)(4326008)(2906002)(36756003)(86362001)(38100700002)(41300700001)(15650500001)(38350700005)(8936002)(8676002)(921011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUphbzJUWmJkSEhORjNnU1F2bWVFWWtkWTdpOVpWcGo3ZjZDYlI1ODBmSnpl?=
 =?utf-8?B?QjIvRGtOSmNITEc0bmtwRGNnRnY2UFdPVHAwRUlJVHZYR3YrSG5OMGc5UW5a?=
 =?utf-8?B?aE1ENGY1MXYxVHNCdmIwUU5Od3QrQWszWjRtZWRaVm5nUkJId2RHZ3YxMmhK?=
 =?utf-8?B?a2RRNTZVcDlHRVREcXNONkkzNmRRR1I1aXl5MStqTnRvMktDR1RHSnpySnEy?=
 =?utf-8?B?aXBVeUdnQjdhazdyTzdQL3RIR1NJaXF2L1pPd0Zwc1VNOVZCTGFySmxMS2gv?=
 =?utf-8?B?U1A2QzBtcWx0Qm9UakFMSllaaTV1Z2kxVFZxVEk2aHVWSE5EeWJnTHJwT09j?=
 =?utf-8?B?S1VYTnlmWVRob0pUVjB5eDNWQ2tkaFprdDdCL3orbUtRRVBqeGIzREJkQUZC?=
 =?utf-8?B?UnlOcTY0Qm9XVGhnVStpcnIzRGxhck93ZEFuM1hZcjJVRElKUmgzM1FKY2Vy?=
 =?utf-8?B?cjJ6SFZwNVVzcGMwajRqamt1UHEwMXFRYUZRaXVqZmhPRW12ZVRxNFBuVUFT?=
 =?utf-8?B?L3NJWHZHdmdoSkVUeG9ZckZwc2dEbFFBZDdCcmpzNXdqRk5ESHA2NldFcVVQ?=
 =?utf-8?B?c3lGMHdSS3FSZ3RuNlJPTkZSYklQYlJlYjVKelROcEllTzJPTjkvSklJanBT?=
 =?utf-8?B?UVZpNHJWQnlacC9ubDhCV2pPeTc0R0hialVNYU5QVHFDN3BhNWUyb0lBK2gz?=
 =?utf-8?B?SVAwS0ZPTEdXVCtxRUM0OS9IZWdTQktZRDFhazlwRlkwYkJzd1VibTMya0hk?=
 =?utf-8?B?SzFUU1BWbVdiUzlETHpCdlBlT2pCZ3FhaHpJUVpCNEhvZUw2dWxrR3hUVHVn?=
 =?utf-8?B?eHlxME5RT1lxaE1EcStwM1lPdkhMbVhwaUw0Ukd5WjZoejlYNnBYYSthbWQy?=
 =?utf-8?B?T21lTktuek90VUZZK0xaVnlmd2hMSG5panowQmRSQkVtekd1bFFnT1FpSnI0?=
 =?utf-8?B?bFNNekVDQWY2K2h1UXJQT2JUdFdrYUUxc2lKZytZSGtQNGhrV1FzeEgzV0Rx?=
 =?utf-8?B?c0Z4TjcrOG51a0hBVFhQYUl1VGpMRzdYbU9Bd2JNaHhiaWlUQXJPTWZwbVgr?=
 =?utf-8?B?UXlpMHQ4RUQrcXNaQ1hhQitWaXorTW5FRzNiWFQyeDRXL3ZFUjJIVGVMTUpZ?=
 =?utf-8?B?a2FyMFNFb0NOaXh5RVRYUnl2N1JZcy9MMXdaSmtvNlNCQ0hRbzJCb1REcUNu?=
 =?utf-8?B?TFFFMzFoSi9kbWNramdMdmMydkp5cTFWcFFJMXo1eG1aQ0JTUit1dWhCUDZG?=
 =?utf-8?B?ZHIvL0ovd1BzWVRzd21oVWVseDZpMGMwWHN3QTROUUtjNFpEdjVxN0xMVW1X?=
 =?utf-8?B?b2piWHFYRVl6ZDVia014dXlPV0FZSTNrVUw5UmFIejhFcHpGREJQZ3dxMndZ?=
 =?utf-8?B?ekY5eFFCTWErQmFZemIyV05nZklLb0hzVUNEM3kxMmhUTHExZVh1UmVhVGxn?=
 =?utf-8?B?QW1NOE1Md1JvVkpRZ3dsZUVKeGI2c091Tzg0bjJCdW5iRjE1U0VCb0Y5cDRK?=
 =?utf-8?B?eFdTOE1uVTZKUTFPTnBuVjJpRXFsUUlsRHRXN2NaV3VwczZabUZld2VXRVhK?=
 =?utf-8?B?U0Q0SHhXSVdGa3BKWW8rTUhvN3F2cUFHMW04WVMzNmIzTGUrYzVWQ1AvUy85?=
 =?utf-8?B?WlMzeUZSSkhEVlZOZU1yVHpsY0RtQWRFYmlaNXZDaWFrR2pzRkliT2dqY08y?=
 =?utf-8?B?Y2plczhtY1JNQTBGa0E4eEtSbUJLandYN016dm1TSmpEZDlLMTAzQlVKWVVO?=
 =?utf-8?B?SkpsNmRRK29IaXMzZ2hZS1ZxYmh0T1ZNUWYzZER4RE5MMlB0UDRPb1YzTVNz?=
 =?utf-8?B?Q1JXY3VsNzRaWHl3ZUpKNzB5dEdrV2hPS0xsUHZjQ3pPRUMyVWVEN0lUSHhI?=
 =?utf-8?B?eXZHSzBHTW5WS2p5YXFzblVoVkhQbEExZk5Oc2RVaUJFdlFyQko0WHdDOWZz?=
 =?utf-8?B?cllSRHRXMzdtSVNCVncrdFU0NUlxMVJkWGwydFc1dVMyOGFsZ3NXVUhSc255?=
 =?utf-8?B?STVDVjNFczFibGlpVGpPNXJXRGJCVjdkRkJuUFFrcVhYZCtVWmhMSWpIcjJQ?=
 =?utf-8?B?OVQ4Smx0RU1OZVhjYy91Y2dPZ2locVY5T2xLNWpjQStGZHJqbGRUTUlyRTM0?=
 =?utf-8?Q?n/9/WN3Yjxt0VuV6QNgNd1+oX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aedb9b6-8e35-4142-6903-08dc1c206d12
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:34:37.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Koplx3x0BL+QiqNrb3t9mvqA2draFY/MG5VmE5Vx57CGwK4FMcmuXScBISBMUUM2GbgMppVK2m7pPgHnV9neWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

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
index dced4614065f..9e89f773d2f9 100644
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
 static int imx_mu_init_generic(struct imx_mu_priv *priv)
 {
 	unsigned int i;
 	unsigned int val;
 
+	if (priv->num_rr > 4 || priv->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
 	for (i = 0; i < IMX_MU_CHANS; i++) {
 		struct imx_mu_con_priv *cp = &priv->con_priv[i];
 
@@ -768,8 +790,8 @@ static int imx_mu_init_generic(struct imx_mu_priv *priv)
 	imx_mu_write(priv, val, priv->dcfg->xSR[IMX_MU_GSR]);
 
 	/* Clear any pending RSR */
-	for (i = 0; i < IMX_MU_NUM_RR; i++)
-		imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+	for (i = 0; i < priv->num_rr; i++)
+		imx_mu_read(priv, priv->dcfg->xRR + i * 4);
 
 	return 0;
 }
@@ -874,6 +896,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	imx_mu_get_tr_rr(priv);
+
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
 
 	ret = priv->dcfg->init(priv);

-- 
2.37.1


