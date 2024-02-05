Return-Path: <linux-kernel+bounces-52008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCB48492B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AD81F2291C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9772910A39;
	Mon,  5 Feb 2024 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T4188pvJ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66925FBE4;
	Mon,  5 Feb 2024 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102838; cv=fail; b=NJ56t/8F6vUZiXl0uJSgWuSh3T2O3l1am7SfyX2dd1HDbPaO/cVHb4T8fiVPw2GNhSDJVOOu//+swNkBcN5ciWYplp6fDl2ksK/OK43LkyczPvO0zwi0hsv0JLbX1O3z95p56f2S4LUChhBq/ZmCwgA7JvlpSrfLhEcwX3FwOHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102838; c=relaxed/simple;
	bh=+AZwIs35769rOh0AJUL5/+pjoFxEhfA6COElew/DlgY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qSS7S9bZ5kvCJQJoFD7jWEmmeE2lJIWvnzG4nz7EqV/mME8wqeHsOifBSnGaMgw5HxWBkXUiLtuCXOd6cR6pg7TLFJb3usbMOm52B+xwt6+Qeri0pJBtYePG7+9K+yAW52XwimaLC6FcgXTNZukscUDN5hfwKTbGQ66Imw3WK3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T4188pvJ; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCQZNUNJc8uIxPPH6ro5qLu1GTlLXC6teh1Gw1Xh+kLVqrlAeuvkV06ceRphpYSfW+3XbubV14xwF3pXYJwojp15sqgZtmPhfYr8OWwL7snfJYiuCrPDHAwkZ7MhZ+G8R3+az2jvG+o4uiW8Xqm345AlPUnSVOsRiivxZQ8w5AU1kb73Lotd2o7Eot9cWKcGwKwD4LSKWRENxD8DEelERDIOoVynYV5/NfPJYugQZDHKPedD3of30BVvVEH2X4eRw7uSI29v0TOzmXbo5iBydUg4oU+SiWXv46F70vgdeZG8wRVYA+uYFaLvJXmNEd8Lnp1Bene+zkRHFZratiLLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TegOzBMjAC22i+VOCdqXTFe0niiil+if8P6XAWAiVSI=;
 b=J8NV8Tu2nxtSL9ElHy6EUNQrMmuxHge+4zjqCH0Tm46GALWcfAAd787eLhdtw58webuh2n52mWOKXLlvySWeBZZEruE0amdSMpw56kDG8lGexke2VwLUH2dTsHvgjj1mwIz2kUVg8ighJkdDdsdVSqtPjGtmf7JUAFYZ37QUYwB84V0ZvQvNsYgDDiHhDNRzJ4JCOYi6cn/vJqHn2/tD6WXsNq5q4U3R2fzmszhCMPHbP6zVEuuni7SisinKcPvAUSyWmlVfcoxhVAv8Svs3p2eL71OcSVBjh/z5kMbkE77U6W0lWFi6vjS/KIzBDrK8W2wAharndACW02c8xhFVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TegOzBMjAC22i+VOCdqXTFe0niiil+if8P6XAWAiVSI=;
 b=T4188pvJuttHCJjPYP073F+fwHyUXTHmM1RNtqfM16z3k2Y5y0ES3xtyGSii6g8IDY5ZVxfQir0DFgAZ0b75S+TGX8rnOt93ibZXpHMYafLtXSiF9i9LEmUvvScj083LJeidJhQjTbf8i3tOtI0I6cpS5Y63OrMtVIVGSPyZ2Go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 03:13:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 03:13:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 05 Feb 2024 11:17:59 +0800
Subject: [PATCH v4 3/3] clocksource/drivers/imx-sysctr: support i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-imx-sysctr-v4-3-ca5a6e1552e7@nxp.com>
References: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
In-Reply-To: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707103086; l=3432;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pt63jqyhMBliY87I8GK5zQvXIIYgDLjOAKhWPgnofho=;
 b=GqakVs6kgXKRZxv8TrVvQlfyHNAJcDJEEDRMdZFpGhFn/ZlKyFmXsBHdRH6Slb7IuW6XZg0px
 RZK36fPr/ebD0c2aMPWNc9jmGlOkZw4YplXoMSt+i6Cq4wmGQa98uJ6
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: fd816224-d7b0-4ac1-8598-08dc25f87c30
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o3Fh/5N9irtaT4x/8a3rxyvlMKpkfq03hwyRLPmw1OEBKowqC2wQLIil6mDxikPAMRl/6K/98vJns7N1lOLyH8UDKUWfbYqgJd8ITgG1oNfRbu/ANpXD1Pt/b+4G9JRIn5uyKmo2IYvVQZYtMXT2cY+yZ0XHKQ227S/EEOcKeFVJWdfbypZkZg4iU7oBxOa1zKSsYOaBoFTyAV/YVcZlhgSA8rtMixDOAIv6E+p7OsmxiLI/8UyKyl7RZFY0BJn2mt9fU6/ieCnGmPttCidgfWBL03lm/O5V+Te3Qw3JLG8oA1mNKclG2VHfEqY7Y37JdhTSIMbpEIZKXULy+TPvrtPOx8Y8fP+J74lUWgLBpRLkXQ4x5xloxd9nLJ90/hJzOdMR3p6przTxOHaCsY4iisyKB0jfbcaJNq6ZPPC5v1+PC0fFaKThX4DPkOFy/so0+XS4123zO+D6QDSKKsZaNb6QlB9Uka0dwW2xQxSR/o03nsh8DuK8uatkHDga2+5PJvSDrMcqknc3lIb7Fr/asDE2KUR8CcBBGmYU2P7EVp6LY8tSOub+7pPJK8qa7rBl/pAh2na1DHkGYL1wQs2PWZtcacrtHaKMfIGeZF7TBPU3L0Y5OYiJVvwrGBQSka6JyjUEqJwc1qV385MB3hjNCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(52116002)(6506007)(83380400001)(38100700002)(26005)(86362001)(41300700001)(4326008)(36756003)(8936002)(8676002)(9686003)(6512007)(921011)(478600001)(2906002)(6486002)(7416002)(5660300002)(66476007)(316002)(66946007)(66556008)(38350700005)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVp4YjZxY09jQ3E5N2htaG5xNjRodjFhTHZiSmhPMUFFMVNMSytSU1Q3dzl0?=
 =?utf-8?B?VlQ0MHVnSDZUTFRTRzE3SDJFUnUwV2pIeE1yNytmbGVxYzRJZUlTd04wTU9Y?=
 =?utf-8?B?QUpKUDQzbkptUjhFaUNZN3Awbko5dEpmd3NBZTRIMm8xZXJCUE9VbDJUcHRo?=
 =?utf-8?B?Q2lEdlRTRnAzUGw2U210bFVZbXRYMTd3b1pCN29hcnRXQWV3VEVnZ0Q5OGRI?=
 =?utf-8?B?S3VwOWRrejgrM3EyWGFFNDJRNDRocDVUMVhYaTd1YnFENEhMb1N4SWNiVndh?=
 =?utf-8?B?YjFEaXIrQ1Y1SHdmMmdJR3FVYVZycnJJZDcwWGVpVXBnZVBQRHZQZlVQekw2?=
 =?utf-8?B?dys3dXZwU1BuWVNsMmhJdkcyZFNlMkw5Ryt1OEFJTDVOdVZFVVZpZzRyYXd1?=
 =?utf-8?B?dUhYTUZDckhuQTVIUElKcHU4c2lvRmx2UXk4Z3ZiTE1ET1FUWjdScm91aCsw?=
 =?utf-8?B?T20zOFhkRjI2NXRPYlRSSTNRYUYvZEp0MG1aZVZKTnVHMzVpUjRGV3JyZ1Fa?=
 =?utf-8?B?VDJ4eXpxSzZsUnhWaXg0bjBuNDhIWW9TQWdicm9xUGNCQ1h5MHRQZ2VEZXVY?=
 =?utf-8?B?N3BGMU51dEl4d29oOFc1TDB1Q3BhWmR6SHk0bU9DMXN1a1pkQyt4RFY3ZVAw?=
 =?utf-8?B?cWpFSkMvTENrdmRjUEk0eVlHZFZ4aVdnTXRuREZtaGNqeDhwR3dYdVQ3ekJX?=
 =?utf-8?B?SExRdHlPWGplNEdTbktFMWF3bHc2dHJBVk8xSy9Yb2g3OUZFSlZWM3hqcUR6?=
 =?utf-8?B?S285MnAvY0dOUDZkYVBqOE8rREFBc1ZLM0V0bm9OMUpwUTVOM0pra2Fhek1C?=
 =?utf-8?B?N2Rac2ZGNzducXV3am43aDV4MlUrZkkvOGhWVHM1enZCVllHd3YwcE1rWkQ5?=
 =?utf-8?B?cUZiZmp5VzVsQVI0Y2QvUXZUUzRLalB1L1IzdW9qQllGZ1dTWHRhWHBRYm9h?=
 =?utf-8?B?aHFqNHk3RExwRUo0TFJWd3pSZnEvUHBUNXNpb1B6MzEwM2pucDV5QmZlZENi?=
 =?utf-8?B?TlZ6RDcyNlY2MUFQSWtzVWRsbjdGR2pYc1hLMUV3Yy9yMnk2QWNwVG0xeXQ2?=
 =?utf-8?B?Sm5GOHp2WDF6eWM3NFBDNDdjY2lSMklMZ1RVa1lVcDl4bDUxTVQxSlJlOXNs?=
 =?utf-8?B?ZXNIbUNRako0ci9NcFQyQ3NteWxWUWdDOVU2WnpIb01WTXJJcWdUMlZhb2M0?=
 =?utf-8?B?aFZyczg5aDJNZ3ZBQzYyT3VqOVhDcDNydVBYYTg1NG9jT3NoSXRaQjk0ZVpq?=
 =?utf-8?B?Qmc4akhXVjdoOFFtdHQwY3BPMkJCQUVkT255cU82RURyNURLeGJ6cFZQQnNs?=
 =?utf-8?B?ZElEdUpmZWh4TXAzM1RQMS9ZZmxTbDg4ZTlzdHRGbFhtTGp5NWdTdkdRT1Uz?=
 =?utf-8?B?YTJOVWgxdFI0YUU1dTVNTVYxcDBTVEIzVThvT1BxaHFXeTAzenY2TTZHckR5?=
 =?utf-8?B?U3JwSHF1bXM1cVJEeHJoWjI5NUlLMDk5M3h1bmtaNDUraHZwZDM4SUwrN3BB?=
 =?utf-8?B?UWdlKzlEVDdDQkgxeG1DNXZERlR2NU5UWXRoR2lJNW5sMmdoSXlFYW40Z0ZX?=
 =?utf-8?B?WVhibzFZQlFDNTdIQlRTK0liQVg4bE5WS3RhWVRSQlRLMVEzNFU0R2VRTzcz?=
 =?utf-8?B?WlUvNzlvUFN1NzdUNi9yemlxdktNRDhBcEZHZitrRDdGSVZyejhpYWIxVTdG?=
 =?utf-8?B?Ty9vTUFrb1V2dHd1aE9LZVBBY1pBbjE2SEtPSTJybVcyU1dyMmFBdnJkYzF1?=
 =?utf-8?B?Z0F1QnRFbVhyaTVnOUM4ZklTZ0RTdFJ4bk5uTkxsZ1U0RUVtci9ubzJaNDB6?=
 =?utf-8?B?cVg2RklsWUNBTnZHYytLQTJNZ3lVN1U1MktUZStHZVBSeXVGTXFFeTltVTFS?=
 =?utf-8?B?Wi9oSTlzWXoyYkxUdDFiR1A3eVoxSzRuNHdpYWpWdUlyUkJrM0FBV1dVU1Ru?=
 =?utf-8?B?cytXK0s5UFJFMHlqbEJDeTg2MEJOUXRWbGtBWjIxUUdxZVYyaWRIY3BDVGxC?=
 =?utf-8?B?WU9OYmd4QVg0dmtQaGs4ckdvNytuZm9mZ3V2TkJQci9pT0lIWkxTSFZGUFBu?=
 =?utf-8?B?VDlIREtwZ1J2VnhvaDhBYThLVUtTSHlISWR4VFZwcTNtQ1ZVZ2N1UFA0bGVP?=
 =?utf-8?Q?vltprWJXoBDlhQ4l+O+GNr6C0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd816224-d7b0-4ac1-8598-08dc25f87c30
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 03:13:54.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +udCGzz18f7bRfUl1qAAc7eoY4v5GSYHWL/o3Gr7XtTyLJ4wz6wy4dF66aFInNNGrE0zRxMuGfxjn6Le6sOhYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

From: Peng Fan <peng.fan@nxp.com>

To i.MX95 System counter module, we use Read register space to get
the counter, not the Control register space to get the counter, because
System Manager firmware not allow Linux to read Control register space,
so add a new TIMER_OF_DECLARE entry for i.MX95.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 53 +++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index c075ea89a214..44525813be1e 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -9,12 +9,15 @@
 #include "timer-of.h"
 
 #define CMP_OFFSET	0x10000
+#define RD_OFFSET	0x20000
 
 #define CNTCV_LO	0x8
 #define CNTCV_HI	0xc
 #define CMPCV_LO	(CMP_OFFSET + 0x20)
 #define CMPCV_HI	(CMP_OFFSET + 0x24)
 #define CMPCR		(CMP_OFFSET + 0x2c)
+#define CNTCV_LO_IMX95	(RD_OFFSET + 0x8)
+#define CNTCV_HI_IMX95	(RD_OFFSET + 0xc)
 
 #define SYS_CTR_EN		0x1
 #define SYS_CTR_IRQ_MASK	0x2
@@ -23,6 +26,8 @@
 
 struct sysctr_private {
 	u32 cmpcr;
+	u32 lo_off;
+	u32 hi_off;
 };
 
 static void sysctr_timer_enable(struct clock_event_device *evt, bool enable)
@@ -47,13 +52,14 @@ static void sysctr_irq_acknowledge(struct clock_event_device *evt)
 static inline u64 sysctr_read_counter(struct clock_event_device *evt)
 {
 	struct timer_of *to = to_timer_of(evt);
+	struct sysctr_private *priv = to->private_data;
 	void __iomem *base = timer_of_base(to);
 	u32 cnt_hi, tmp_hi, cnt_lo;
 
 	do {
-		cnt_hi = readl_relaxed(base + CNTCV_HI);
-		cnt_lo = readl_relaxed(base + CNTCV_LO);
-		tmp_hi = readl_relaxed(base + CNTCV_HI);
+		cnt_hi = readl_relaxed(base + priv->hi_off);
+		cnt_lo = readl_relaxed(base + priv->lo_off);
+		tmp_hi = readl_relaxed(base + priv->hi_off);
 	} while (tmp_hi != cnt_hi);
 
 	return  ((u64) cnt_hi << 32) | cnt_lo;
@@ -127,7 +133,7 @@ static struct timer_of to_sysctr = {
 	},
 };
 
-static int __init sysctr_timer_init(struct device_node *np)
+static int __init __sysctr_timer_init(struct device_node *np)
 {
 	struct sysctr_private *priv;
 	void __iomem *base;
@@ -154,9 +160,48 @@ static int __init sysctr_timer_init(struct device_node *np)
 	base = timer_of_base(&to_sysctr);
 	priv->cmpcr = readl(base + CMPCR) & ~SYS_CTR_EN;
 
+	return 0;
+}
+
+static int __init sysctr_timer_init(struct device_node *np)
+{
+	struct sysctr_private *priv;
+	int ret;
+
+	ret = __sysctr_timer_init(np);
+	if (ret)
+		return ret;
+
+	priv = to_sysctr.private_data;
+	priv->lo_off = CNTCV_LO;
+	priv->hi_off = CNTCV_HI;
+
 	clockevents_config_and_register(&to_sysctr.clkevt,
 					timer_of_rate(&to_sysctr),
 					0xff, 0x7fffffff);
+
 	return 0;
 }
+
+static int __init sysctr_timer_imx95_init(struct device_node *np)
+{
+	struct sysctr_private *priv;
+	int ret;
+
+	ret = __sysctr_timer_init(np);
+	if (ret)
+		return ret;
+
+	priv = to_sysctr.private_data;
+	priv->lo_off = CNTCV_LO_IMX95;
+	priv->hi_off = CNTCV_HI_IMX95;
+
+	clockevents_config_and_register(&to_sysctr.clkevt,
+					timer_of_rate(&to_sysctr),
+					0xff, 0x7fffffff);
+
+	return 0;
+}
+
 TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);
+TIMER_OF_DECLARE(sysctr_timer_imx95, "nxp,imx95-sysctr-timer", sysctr_timer_imx95_init);

-- 
2.37.1


