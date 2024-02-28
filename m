Return-Path: <linux-kernel+bounces-84541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056386A80A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57032B21B75
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352821344;
	Wed, 28 Feb 2024 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YFmWBx52"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D220320;
	Wed, 28 Feb 2024 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709098496; cv=fail; b=gzcEQYbymu49iFF+0Dl7uD/zpzOZmIVZntDILwltZ1GpzsJBW6231jwJ8en+c+IAE3n5aLRZ4SqzgWjJMDmgLHYxQsfa7gkc3AcZtgcVSYzm6aEaYdrPUunxFinUWDQE6y7VCIi9/FCz8Rw+ZpwwHsd7TFBKJ1dQRHFg5yVNiEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709098496; c=relaxed/simple;
	bh=T3wdB7ehlBuGWKQDTwowLn+Jn/276/VgTnAm1rAIR8k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=up48+3MpJNZN/Loi1+3yAuXTKRjLmjF7pTNst4oJTsNVlJ/aewhYQLcvoFq/Ao/ZFsYoEzmVvYm+HddZgzgXPqxGiIB5B5d2KMJu3Y7omusF4qwna2cJwYqmgtAqS9n0DCF5fNzTRJHndgf6mX2Be+mQIwhI2DQKzCebz3j2VLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YFmWBx52; arc=fail smtp.client-ip=40.107.6.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1cOYjtn2ZD9QUSkd1kSBIMGXyTZKuLKI5gZAeJbwyLMJVM+3nvLMPbWuaipS2H5voCAncmsC23FB8U0+YHFbwhPZNuoweCpwzFa4foE9kO5rI05+Gp0Y9ji5mITW71hZP2tzy4HRZ8BgLCTscNNdASFnbvvf3kPtSO+eGbxn2P/o32T+a4biYwD2pVN8TPUdDqgszcZRL7L73XbQXoby4TPN0NUNEwp21kdXvBu8vV2pQUZp46QwU/lhX9WMjs7ilB2q3b/EoWCoaM7iLv1rahUsDrCW8oi4eoVl57qp0KmtGz66i9Jk6CeUIoLOCgjFZUYmsMqNl1YMLMRTHwL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eFQx1UCN7t0vc5on4z/ECIHNOSXtPqYrZzeIPPwcJY=;
 b=bjX1utLskMdysxhO9QB//uBfIos+ua5guDnWQWMhHyaUkDBrJ4t9klf5XhCh06ozX6esemlKHMyFpFPkx8BQUv8YuC62O1ZRZ+gx/heqkgT25LAJBb25HCPA/49Rzy/JwjU5R/5T/t+ruI9A252ILgkbEj/ITLBb5eQum78eDqnZxBlD7dPwr04/xrEMHCW5WNzB3W6oAnR69AcQ2N6FUAzgdMq378K4LOWbqeKp2P0D/k+Yt3QEQ2j7EPr3dX0FFi0zNacDRKGaKcvUgAKhVe4bWyYXQsCy/QCsHpZyXeCcDnlujbZZ15ZVehyw4IpH3ptBCD4HydJTSrhjmVULug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eFQx1UCN7t0vc5on4z/ECIHNOSXtPqYrZzeIPPwcJY=;
 b=YFmWBx52q24AqQRTkkcPeYtd4n0LhWIAMQIJfddJRQlFw6uejid5EbKcc/zK5w4DNcdw5YZ6InKhRDSTHMPnLIw+wVBfMb9CaIQrXY65BGduPWzykWIYNfPLT37HmVPQmiXJ2WJs+0Aslub4kITzLkPnzUPBFkBFrPMFjPDlbgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 05:34:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 05:34:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/2] Add support i.MX95 BLK CTL module clock features
Date: Wed, 28 Feb 2024 13:43:04 +0800
Message-Id: <20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjH3mUC/3XMywqDQAyF4VeRrJvixBG0q76HuNCYqaHemBGxi
 O/eqfsu/wPnOyCIVwnwSA7wsmnQeYpBtwS4b6aXoHaxgVKyKVGBOu5lju3wRl4HLMUVbBxbJoL
 4Wbw43S+vqmP3GtbZfy5+M7/1n7QZTLFs80YyNrYrsue0L3eeR6jP8/wCtllkJqgAAAA=
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709098992; l=1049;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=T3wdB7ehlBuGWKQDTwowLn+Jn/276/VgTnAm1rAIR8k=;
 b=z9Dr4FwW/cpptOHrN9dl6AAHj+lIy2CKUezNZvGGsrvWN1m2ycK+UnJzsA6XgQK716fDyf/in
 XDqAN0h9xlKDuDlXIJgKNPAmAfEvrFh3ToX2ci+Ambgy3pRAkyqFWCd
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: a254f5b5-3f74-44bf-3370-08dc381efbc8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Es3TC4jLdjTZ6wIKssGHd6T3o9JMcyOuu0CHQyo0FKXrtTTpMDAJ0NLd6i3g0KOX4tHv7dA7PSO/NpQ2LT4Ju+4ptyvNpAnGnwDazbJ+H47UJY04TSSQbI3+4Mrj2m7QfYIkdg0/9H3zl4b5XsDgaFChIkaZbku4YkrK8gwf3MosCbi/XwOU0sNLJiU5Q4OPGHosYMpbVpUNDaMbW4qHkmHZGgtTREMHDgPUxJiEOnSkIPP9qWr7inp9Dv4xhUUZNSSXBQYHGHl2OSC9GutYUSJL7OZTD1idRx2CAnr7DoZ2TF1rsePY94z8IVHO/bvG8q2TBYXXmGhaZVK7gZVX2VihCMlGNJr06mVxNeg5x1JlT/wwKZkAfcmJjkUUwCRtIHZOdadiv/y5tGFVCbWNxpR9eYBifno2YodaWBHG6LwPnHMuxlZ3EJJy1hObn7SeEo3hGG66juuqLWakx/uXmvApcjlg6IKUOy7q+BYKELIxosIjqQ3r3Ww4Wetca62qAfB8mizUrDpu6xoDuUX/BPrL2g/rfmOCxaF1YKHRUqSpl0ccQQ2D1K8zdFp3wa67tiSmHbza4LsJU/k2Xmhlt6ZsncRin2RJbaXPpPSCdisWfZTM0QIVScSA5pVk3Ln8O0eGBr1nMBPMpBJHQ1tkw8MlWbHNNPmQeoiNwCdKC1Q60bhpbaRB9GlyWV8a8b94nZigT4dj4sHHKF4kJywz8idYkoMObcYUzjEeTw2kMKo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3lXOHd3VE52MEJvSy94ZlpSTnhIU3BSU2hmbmw4OHRyT2dIVHR0Rnpma0RG?=
 =?utf-8?B?dHdTaExuczUzTUFFVkFod282bjBUWWZwTlRwRk9XUVowVlR1Wm4vNmsvbjNU?=
 =?utf-8?B?YXZad2xhaFJnK0lNL1pDa2tGMFRpL2F6VE1JelBRM1JNOFNqRFl4WjI1VFlv?=
 =?utf-8?B?U3FiMUtzYUZUVnJjS042dnA0enNweFNYN21PcFZxNnBZTEVxbDNUdGFZcENE?=
 =?utf-8?B?cmJjS243R29GMVUwY3VyaVczRk5GaE9OKzYzcFlZTWRxUXpPdXIzSytUMzFh?=
 =?utf-8?B?U2RtOGZQK2FDd3FRR1JBTFpNVUNueEVXS0Rhb3FublpBYytEOEVEYjRVL1Fr?=
 =?utf-8?B?YWwxZ2NuOHg3bkgyL1lranJJeFY3YVlVcHRkR0Mzb1c4YzVDZFFkRXBzWFdW?=
 =?utf-8?B?OUUrQTVZNHlxQVBCcXQ0NTNMZlpwNHIrTDVoR0E4K1dQNUlia1FyTk5XaEhR?=
 =?utf-8?B?L09CQUtOMkFadC9PUVQxRjVzSWZpRWdRaTZDdDRGS2tBQThjeW5sMlF1Mlc3?=
 =?utf-8?B?emdxKzhSa2JmZ0U2YWo4UThreFo2ejJaV24zUWlDZllFZmY4RS83OUNPZGhV?=
 =?utf-8?B?bTJOaUJTQS9aa2NhRDdWaWJ6czhkMnI2UlBoSEw0cG9Kd1JhU3VzZmFsQ0J6?=
 =?utf-8?B?LzBuU0laSTlBR2ZNK0VRSDZ4VXRld2FoZW5RNEVDWnVSMEppcG9QbkI1MG9t?=
 =?utf-8?B?amdENVE3a1Z3NFNXY1BIYTk1Y3BocTVrYjF0WTUvYjlXc1E4RjR0K3NIUExT?=
 =?utf-8?B?RmFIRm9DYzBSMTJORjNTMjcvcWpFdFdkV1NoTjhmR1JmQVpMejVrUlB6NzNY?=
 =?utf-8?B?b1RVVjJmeldtYVJKVzlWV2VacmR4TjFFQ294VHI5TW9RTU1pL0twdW8xZnBF?=
 =?utf-8?B?Rk95ME5ZOS93NTczR2NneFJKUUZmcWRIc1RTWW5CT1BiUkMwZWdaalJPYU43?=
 =?utf-8?B?SDlBcTBLZDR0cVE2NTl1VWYzM1JYdmtXckJweC9qRWMzWXlINDdIOGJLb2xC?=
 =?utf-8?B?WFFPc3JCbFpUSmRCS2NwL1hkYkQzSTlTWnUvM2Q4QnRhUW5OOXhWOXFSdTBw?=
 =?utf-8?B?SXdOVWo4Q3FFUEVuTTdyMmRtTmRRYkJ3V2NGenk2REMwMjVacVloK0xyY2cr?=
 =?utf-8?B?N1U3S1JJSjlTcUdRYnVKVFovWlVSNktIUWtZQVgvOTBGNlVNZHdyem9HOGRR?=
 =?utf-8?B?NnMvUlpVNTNYb2hTb3Y2SGliQmlGOHFMK2d4SzdWWWFUbDNvQm43ZCswbWE4?=
 =?utf-8?B?V2M2T2l5cisvSDlDTENYcXo3VVJaQkUzTEZycm5zS3Rjd3hlVlVlTGEyTEhh?=
 =?utf-8?B?VjU1OE9FRUdKWkM3ZmMwU2RlZ1ZwYVZrWm9pOWJlSjhLcXZXK2pBdGpzcTZl?=
 =?utf-8?B?OGVvekZhcGUrMjFvem9lMWlIbFBJcDhlUmNmZktSTGY5U0ZQVmEwenJwWXRX?=
 =?utf-8?B?UWMrSE0yK0Ztd1p0cVlHUGQrRHVFUUp1THcyc3k3M0tiMWhNMDhZNE5rdE14?=
 =?utf-8?B?ZjBSK1gzRU5DTzhzcURZeWdwOSt3bUFyemZQcTlVZkVnRjRJV1BSRFVxb0J2?=
 =?utf-8?B?aVNYQmZHYXBuZS9SUnZlODNiZ1I5L00rRmZVOUZwVmpzajF1U2l3SGUvaE8x?=
 =?utf-8?B?bGhDeG9kdk1EeXRISEJ2eUJJWklzQ3N6Y2FTdDNUVUtONVhKOEtqV1JvMHRp?=
 =?utf-8?B?bDRWY1F1UHE0QWRUa1o2TFVlVmJpZEN5TmY0aG5iYmtMekRMbC9Ib3MxVWpJ?=
 =?utf-8?B?eDVLSkM1MldSVkhxVzVETWh1U2xTTTh6UXZSbzBMTmlVWld5ZG80VHhLZENN?=
 =?utf-8?B?Umo2TG03VUYxYnpLMU5kTDVKNWF5OFp6T0IyS3pWSE1jaHNPczBOSlVKU2dQ?=
 =?utf-8?B?WEV5empMQkxWUjhOTDRHekVtandkcGg3ckd4V3IwQkFJdlBZZG5VTElHaks2?=
 =?utf-8?B?cWRCNDVwTlljREZ6V21oRnMydzNub04wd3dhcVZRK041Q2tqOU41eVdDT3FP?=
 =?utf-8?B?eVVpK0tQY2kyU0IwWUNDbXduUkc2TnFDNzFBVGpZUHJremZDOHhsUld3VG5C?=
 =?utf-8?B?WjRQdHRmcEc0a2RMcFZFWjlhV1lSdGtCY1pCTUJNblpNUFpsZU9UTGU0RkYw?=
 =?utf-8?Q?M0fRwJoVT7noq69PW9RzR/mIO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a254f5b5-3f74-44bf-3370-08dc381efbc8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 05:34:51.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dpoud/ao7t5uFbmqzOpQVnHmzHVWeE2v/7pqXQDCX1V2u3YP5aUsHJPtFqkrXCLr9KCzoEZjtyOsMA4HojADRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525

i.MX95's several MIXes has BLK CTL module which could be used for
clk settings, QoS settings, Misc settings for a MIX. This patchset
is to add the clk feature support, including dt-bindings

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Correct example node compatible string
- Link to v1: https://lore.kernel.org/r/20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com

---
Peng Fan (2):
      dt-bindindgs: clock: support NXP i.MX95 BLK CTL module
      clk: imx: add i.MX95 BLK CTL clk driver

 .../devicetree/bindings/clock/imx95-blk-ctl.yaml   |  61 +++
 drivers/clk/imx/Kconfig                            |   7 +
 drivers/clk/imx/Makefile                           |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 438 +++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  32 ++
 5 files changed, 539 insertions(+)
---
base-commit: 22ba90670a51a18c6b36d285fddf92b9887c0bc3
change-id: 20240228-imx95-blk-ctl-9ef8c1fc4c22

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


