Return-Path: <linux-kernel+bounces-38478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE583C0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51087B2BA37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B8960265;
	Thu, 25 Jan 2024 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HzlLWHdE"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3D5FF1D;
	Thu, 25 Jan 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180752; cv=fail; b=NFaqWuGrp45b1ivOZcw1wecIZVNyJVNfeqBRTUWHqSWyqYdLX/jVm8pQYmhwPsrRBYRE1uqSNvYfiSWVbPyXxhCS4ZFwT+YP9HcrPgu/PWYlVNVqxylwi4gfIvS8dfkBcSXvFkhQ+jQJ/u0DMZux+lo1UnZZJpO8KLfB5Omc7Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180752; c=relaxed/simple;
	bh=aBLG5QljCVCTEwxxYjv47sVcETnZC/aCIiHAM0aoreM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gVW7Vj40ZB8xLRcEYegB5XT2qZKg8Zm0yabqEqRVf0o/VBJkyLwhnljbRfYJHVNt857GkvYWe79rT7iuKKbNPZdlxr828spFOxVif4oh+pdAsIyjbTEAeWoGMaIyMVVYyfGjRUaZtE1IdaWz8ZsbyeYPPS02NamozSx766j9CRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HzlLWHdE; arc=fail smtp.client-ip=40.107.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjaL1MFP0yWY+pIJEBDbzL1GApwU5CcOoaTfQbIF9ufEPf1xN0/jajxJphRTf62ownFwGpIKttwedpR8Rr8iLMLdyEuFe8zJesOBrkl2mYBVYNU95lmew2Asr7z3g+2w+owYJDX/qX1PNSF4l0JDorUzNPIPKKl1XVYZ/RjDFKaDJ56C1/VStV4C/1aMiZBnLIAU+nw+UMwPh76W6ai3udT/VJ7LaT71Lb/UQKUbkSqgDbgd6wC8q6O71MoPyZ5ZS2ei3p/l9nrhucS0l9UBTDwCAMvn1JWZV9PmSkR1sqwz5gv6UcyqUp4nF2/tnvnMumvwj2+vwL2rEKBInt9dQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1lUtjwppp5r6I2j8GSA70ZjQecm5QrSH07ZZ+SCFs0=;
 b=VyGqE+WakaylFiWkBjv6XQXFsWwx6B18S+Huausu2Dqo6gIdFztOlQdIxVXQpjEjDxHOdNCSZntpebQQJ//tDA4tszS9CsqKvV13aAEzUwlT3DesVyM/+67fQshgpzHf8BoQiUSCEoJgr7oCFCqmPHJy2GVPVR0FFBYNyy53Ogjqd/0M23jcksvux0/3OO3vGbTRwWWnHG90D0Er3pWU6DsNIUlUwfcIjQ917zUAyeU29nUU0jOgBZ5f/EIpuHKVDdhgeZ6p+c4HgdsHNhgIvZliC4wqEN+vhBg9l+Q5demiAQOfjEVJDOysM4RGmXxPdF6zCj6ALXlKCZMa2MQVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1lUtjwppp5r6I2j8GSA70ZjQecm5QrSH07ZZ+SCFs0=;
 b=HzlLWHdE6FugOl5BFS96TJQvYxr/awsvhqvtn13SjVC5YANOc+R0qv5b3W0Uykn75ukIyOG362pPAGEYPXVKVUqH9rdwa0LmCgwKy8KQdikibQt5dA9mSynjIuren6LRtUR0nnFF8CBlSeYlN4x69fPUZ445XAEMbBVds7cldYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 11:05:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 11:05:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 25 Jan 2024 19:09:49 +0800
Subject: [PATCH v2 3/3] clocksource/drivers/imx-sysctr: support i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-imx-sysctr-v2-3-7332470cd7ae@nxp.com>
References: <20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com>
In-Reply-To: <20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706180999; l=3432;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=o5T5BQKnKVPTSdGEy9mYdRRrgmMK7+tO3UEptrQOgLk=;
 b=FEsy12o6ILGS1hX1lH8QsgAY5uedRZp2M1mmWP6+s3XkZhWbMKRC/s3w+AGnYPWrxGGNgImFy
 nj0ChHfVJ90DlQyaU76EBMK7qvmBvi0wNTZGDYhafQwiUnlb4mQnaMg
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbe8eb3-51b2-4523-cb2e-08dc1d9594ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ji3JYLCtVMTgvY7umRPh4Dy+TTsIbbfG+MBkIyddiS6KCXtmn3zaMxBH9cV7VdZVa2nSd0QiacVvFzCpFEZ55oPW+XfFq7CEWFUAcEKB0NFk1qgqyloLGN5Z5J/ypAoX/6sZByB+jV+voQLeWNK2+vV2XhU4bSbi0oF6bpdAZoZruILrSbRaZMsMvaCkFXcbP/g+8TAgjXL6zXXMmK42BMbv01RlVcgRarAQZmBulxWXfK22N/OnBy6dUKbB6EfhnDAkZuaOm+bOd617hDZ5n2r8yUrlt/yeA+sjYBSOwm4QhUFmmR37+Qb+LaG00Hndgbwyv1Yx2NIvrzoeaUL/8PXBQHh9OwzmA/4x0xxQz7e8d59NlsfaR6KXjfF4v1DQQ0NfyQlmeCCzgc/UAbGM8LwApF944tL2UaLZ+PCiJ90+OZXQF+dxlj+/ow/xtzlJJWNRuxn+9ZWP31eIAGY/vrHPEH2Fl0QTeqsm4xg1sUW5jQYzvpXqEGwxTbTHS+k23DyB4Ab1ff6xPU+Wg+CCNOPsilf37lAC4P38+eQ2Q7ygB4lG4v/vUlzxUfd5Jw4rlG8nMd9pp2pYHCRINh+8Mws+lrtAk0nuAzT64VW7ux/G8NixWS/8ojf7aKJHTdnWvTvazyvOLU514mqL7+MHmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(2906002)(8936002)(110136005)(7416002)(66476007)(8676002)(5660300002)(66946007)(83380400001)(26005)(38350700005)(86362001)(36756003)(66556008)(316002)(921011)(52116002)(6486002)(9686003)(6512007)(6506007)(478600001)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXRRTkRtb1BpK09ROVg5Yk9Lc0pRaTFYZWRyY0pNa201dWRjaGFyV29VT05s?=
 =?utf-8?B?ZnQ0cHpVbXNrOG1FdTFKeTFvUU9qRklPSzhSbTJJMWRxM1ZCdW1TcHdEbjhV?=
 =?utf-8?B?MktXbzN6aXRJKzY1L1NxbmlpR0VYVUVYa0dMLysrbzY2eWJldlpPaUgwOXFi?=
 =?utf-8?B?clphNmxuOHBEQ3c3bFVDY1poTlpiaUdGbVFvcDM0and4SC9lWDlCS1g2NlBM?=
 =?utf-8?B?djVxTTFBWXNtVkpsRHh5YXBsczRlaWJIVVVwN2NUdGkySGUrc2djdjh3MHNh?=
 =?utf-8?B?bnY2RDh0b0RkcERKVEpQWWpCZVFPTy83bTZVR0RVSTRIUDFYbWpvUzBwd1FP?=
 =?utf-8?B?VUZ4NG5sZVJtd1pUazVXMzRpSXAwdmhNWHZXNE9vTHBNUzZrNktQOVIvY2tu?=
 =?utf-8?B?d25kcFBHdXBWbHlhUllGSW1RMVhpSVFGd0JDc1dDTzMxSDFlRXlVK3RKOGlX?=
 =?utf-8?B?dDBCVVhjSThuZ2U3Wkx3UkhGUUtIWm9uZzk3S0Y4QzBFa3NrYTFnRHlEMnlk?=
 =?utf-8?B?TmxBVTBpRVVjQVFjQkEwWlh0SW1CSnJMSmpZOU5GdnhrTll5cFBaMHQxRVg4?=
 =?utf-8?B?ZEgxNTRNcGdjSTRmTVlDTE4wcmFDVUpxT3ZpUnNIN0RiY2pmeHFTdHBGNUI4?=
 =?utf-8?B?SDNIQWU1VnBGL2ZOeVlUME1vWWlyK2gvOW5HTWVOd0xyYkE3Yk1lMUZLY21Y?=
 =?utf-8?B?dHlQTHliUkh3blJTcXdVeE45VGZ5R1lpSG1DZDA1U1kvU3NLeGZxaVBhVjZN?=
 =?utf-8?B?ckZ5eXBkRWZodDdkOTRGcjZTUkQ3dkZkTDE0b0E0TkJmWWpMaHU1VVRuWHc2?=
 =?utf-8?B?T29xTytPbzdmN2pwSUhta0htSUozS2VoNmwvb1FBWGdOZmJKcmxHamN0Y0xV?=
 =?utf-8?B?V1pmc3E5YlFUMVhNdU5tWERxZ0txZjUrcE5BOTVKNHZ4ZkxZcktDQ2xnNzcw?=
 =?utf-8?B?RVYrQ0ZoUUxTZDltalYwWE5oYjFpMEFqNXg1UGp0RWF5Vnl6QWExdGhIcTRO?=
 =?utf-8?B?QW02TjZxVElJaUVYV3ArMXFyK0swSG5VS3pjNG5kL0FUcE5iWGswSXlTTTZH?=
 =?utf-8?B?Y3VVeGtseVJsZlZQTTdGWTRycG1rUHdEUG9QZk85TllMQnRlQllwdjQ2NzBl?=
 =?utf-8?B?Y1BKU1dYQXVrYm9Talg3R3FwRmNob01jSnhSb3Y4NktaRHc5N2NaRXN5U3BU?=
 =?utf-8?B?dVpCRE9OUzY2RGxZRDZBS3QrZnhlZEt2R2N2ZnR5N0NwaFgyZHVzUVhZSEl5?=
 =?utf-8?B?V3ErQmpacjBaNFZoRFJUK3ZGcHpqNkgxYUpXRzdxQ0dCTlJna3NEdzU0TVkr?=
 =?utf-8?B?UFJaL2hHOFBFNUJtSDlHTTlSazJWUTJXSTRDTlBvajVLNWxzb29MTk0zU3Zl?=
 =?utf-8?B?MmYxekdnQ2pDVGFCbU5NRldOZmcwREZzUzVlV0dQMWJEbUZSUFhjK1o3RHhs?=
 =?utf-8?B?dHAyWlVIZkpMTXNUN1Z6Q0dmdC9WWFh3TGhRbEpTTFNidVZLNVNkZTYwZmNH?=
 =?utf-8?B?OUE4RmtSWTJHemo5UzdUYkRia2VQZzJGeEdOcWtvbTlqdlFmck9SNmQvckJr?=
 =?utf-8?B?RXk1RXZQdnBvenB0c1JmSzF5YUZ1UVpaZ1BvMlk3L3ZrNi82L1pIRnFKZlZ0?=
 =?utf-8?B?OWdzdFlXa3N2WFFLL043anE5UTJwQmpkN3ZDTEhXWmdwalJxUk9HU2JQSUh2?=
 =?utf-8?B?QTF0dWNHcEIrbll4TGY0SGlqWUxRV0pyZDFXcVFraG4zRytCeklVTnp3YXVD?=
 =?utf-8?B?UHI2K3h5SzJCUXFjWk5iVnIxNi85eUppRzNjbHJZSE5mYkFDOXZmRHZVNTNU?=
 =?utf-8?B?ZnZMbS9DbjJyM0owQ3EzMnlGbnNjWkRQc2lrY1BTRUpTQWVndXI3MG1KTTBH?=
 =?utf-8?B?bDBraFJLRTU3bjBxMHRNS21lSHR6L3RUOXkwYUwza2wxU2tiUmRUbC8rWTlV?=
 =?utf-8?B?M0p2VkdXSWZBVldlODNXS1RVMHE3dGduRFVTUU5FUDEycjUzdnlicnFvUGpx?=
 =?utf-8?B?NldqNzJBYmdEVXFiaWV6QnNFcjNDS2xYeXFVY3YrV05sSkljdG5WK1JwcU05?=
 =?utf-8?B?M0YwNTVJOTMzSWxMdTc0bjZWNktHRXlkYjUwRk9BNmNrelB4NVRDeXIyelRs?=
 =?utf-8?Q?kJY2iNtroJYzNKH20stQlJEMV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbe8eb3-51b2-4523-cb2e-08dc1d9594ec
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 11:05:46.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsNe3H2XsZWR5yYB/im+o7UN+HXlCXIH2DuIDCkQfuLoTaOujpysbPVbDu6SqmTL12GJY5SYGynAkzekBkaFbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013

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
index 8d5bfb8470fb..9b7c021c3b46 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -8,12 +8,15 @@
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
@@ -22,6 +25,8 @@
 
 struct sysctr_private {
 	u32 cmpcr;
+	u32 lo_off;
+	u32 hi_off;
 };
 
 static void sysctr_timer_enable(struct clock_event_device *evt, bool enable)
@@ -46,13 +51,14 @@ static void sysctr_irq_acknowledge(struct clock_event_device *evt)
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
@@ -126,7 +132,7 @@ static struct timer_of to_sysctr = {
 	},
 };
 
-static int __init sysctr_timer_init(struct device_node *np)
+static int __init __sysctr_timer_init(struct device_node *np)
 {
 	struct sysctr_private *priv;
 	void __iomem *base;
@@ -153,9 +159,48 @@ static int __init sysctr_timer_init(struct device_node *np)
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


