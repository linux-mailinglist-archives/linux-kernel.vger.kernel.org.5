Return-Path: <linux-kernel+bounces-85646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDDC86B8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391C3286311
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893FA5E08B;
	Wed, 28 Feb 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hxwL7HnV"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2072.outbound.protection.outlook.com [40.107.15.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21C5E070;
	Wed, 28 Feb 2024 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150130; cv=fail; b=adLWeAc8p4vJ9oVOpjEJxjBmTD0gBrS/1rHGxohki+SMYYn4ixNYbrEl4aFd4dkwYpZGOy8xLOA5s+1h34v9sHSPFBxgIV9HE/07HENXZNXwPWfYU43aK3TsezWaKNFEC+qbOC11HC2alw8Rks46/SDlL+ln6gs/LoEYvRldJn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150130; c=relaxed/simple;
	bh=ThP5p/J0iJWdCIkevcwRdcO+pbD6V77BAEiUspXNY4s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ACQJFn5vCfWLr8StgBoCnSIU4ZvQueZT7By0wrtphocdzPB0WpGMbnZpeyeS3A2XUPKHMdGhQxM7CkX+XreDrHTF4PQnR8amvH6+tJtXhRiU34kysAvzaPDRJvS2I3hZQGi2qvRFBnZ0gCJcbB/f939PChyZFnDSGJeG+V6b3PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hxwL7HnV; arc=fail smtp.client-ip=40.107.15.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGcqjRkJsFLZPFtM2Mc/zOcTETs078XsU2FFVsWcyovoBgu/rPDymbqPqXIo9Iq7zovwdJolERFe0wQxmNFmLDOSjW+VfGCnu7scC3k9DfOJTAJOES/BvqqojQ9APqq9p8wz0A/2z0L8/BtSU0Elpclc3/hgrWCPmwh1iwYtJ8W2W15USuL1pBXhTUh9zHN+4ARAikjW5muWEoeE6WldLt0Hvl6uZ5d1R9BRlbpn64hD5YV99EpTGKeD4B/yKsq8FkmUN6XAftkDoyCYqsM88t2Gl78DMxeODZZVkYbW2HYEEokHf19XDbeshZc48GWdTBRk/RtYjlWy9s7EyU9aVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K34834RDL43ByZGkv2mH5Az0xJrenKJ6hsrb8MfGrSc=;
 b=Sylbmhl1L73gQFYQLYZ7Vcb1+xZe5kKsnc+VYqmelrtxnhvIO2FfhpgHS297FezD2gZPgJU+SfRPsSg/OB1wyF/7ov4cnOnQJdsJNM60IHqM/CDDv8KXVz0CxTK38jK2HOCXFcHR96tyspUKnwd5NfggATPWL/011ufsiulMwOObqF11IlWlAzm+l7/6Clu3R67UgJQR33SDP8meiiqA2xZq4ZoSYK3c5lZ3taWDCTSWN4y1PGjtqIi405lyjefUyD2fKvcDdxaRQgRWlpt4dsM0AsCrYzP8GLqersuBGQv+89xoaEDnyhmKe5dW4IscYJGZyD+EuPRq4TOYwqz44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K34834RDL43ByZGkv2mH5Az0xJrenKJ6hsrb8MfGrSc=;
 b=hxwL7HnVceFHK2Z92GToGKCmFiArmuMOPda7eWORtXqTcaeGAsQsepHAQZifd8zWdjSsIMUbW685dwowis7dboPf67wIilkR6gKMFE3SyQd0M+XJ8Kilywr5aX4LVaxoeAdeyjkmcWrOyR8uqPCUmwcvIT+aX/ednH/e+jAxb2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7732.eurprd04.prod.outlook.com (2603:10a6:20b:237::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 28 Feb
 2024 19:55:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:55:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] arm64: dts: imx8: add cm40 and cm40_uart
Date: Wed, 28 Feb 2024 14:54:56 -0500
Message-Id: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCP32UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyML3VyT+JyC0sSiEl1jA3NLw2QDY6M0o0QloPqCotS0zAqwWdGxtbU
 ASmO+uFsAAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709150122; l=871;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ThP5p/J0iJWdCIkevcwRdcO+pbD6V77BAEiUspXNY4s=;
 b=5zLI5v/jlpk189ghJrYILD/WeX92rvgTHugP6qEBOheDGNKMx8GU4KTvkxoO5t9wqmLTruQIF
 /ZHso7xF30lC73C9WNqGuxGXLM3c6ao/JD5RQimd7rFsfAE9BbZPy1q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d83fb9f-b8ae-43da-3bed-08dc389734f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	teddlNI9Rq7CFEXoU6LMY9sUm6+AwvngNJBWgpLrr74X4enf6VrsqFktv8C2MOqA6+ei6sKIFu+o8Q7JoZ0Vx4mnw9iSXWXq/TgA00saGf4NwqvB4BNela8xu0y9g3yPpQjKZMZ2TdDEaGMPMYPh+0CZHnzK/JDQ0UPdTsK0iccjrsR+lFanz477QNO/IPnoYisKgsPw0u+v2Fl5yd1uN4V/+jOGguiTxT5Pi+6JR2JTz1/PRwt8SEiFBnUt07nCysRPwi0nTq2HGGPWIJfpMDEkmtRWnB9YXlln+RvJKPHGMwAvfoAcnfegfulHNjnFdKzTLe1vGWZ87l1SuF+q9p6aPLBMBUX+VkrQzhgekXbjfGfBAb8x8K4Oahz7X4bpHhXAqhkhdpQfpXK+hPI2DlnA+lKRLyQtahmVj52mwHkMZnEZ/5/F6ZCztgRd7Tg7kDU2tqOg+lJsv1p0kvXglitrCFO1xXlKRPm+AZnLInkPDSQ6/JrGecn3LTsCDQ6unnV5v54cxZgOwHbknm0DheDqVCrRSmYZDcDt0jAel384ds6O9vSBzeZQ8sl8AbVtnTrwGs5QwCzkJMo9Ij8z6RwIaFtEmCeZbSuyogHO/5Vkzxa6asJwltJYXSzkOJfo0iwtxo4MvsqNxCHu2YYiQSkmT8SILjgVfPw7Icsjmslq3M5BfAe3jJ0sRkkpuGPmig/jYf/l6auyiYbBNOftPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1pQcFZmWTBlTWRJM1NrVzRSQ2JrSzhEZ2VwczJiZW9jaUFqa2p0SE55ZW40?=
 =?utf-8?B?ZTFRZ0ZRelA0WUxjMlB3cXZtaTZFQmdDODN3S1V2NlNnd3pINFR6czBKbXpw?=
 =?utf-8?B?Y21YQjYwcTloS1ZLZHY2QzBsakFXN1M2VExMSzZqbjg0aVJRN2RZUDBRL3ZJ?=
 =?utf-8?B?ZGUwU3ZNdUl5cUcrVkNHSW55QWp1VlRPZ2tzRyt4Q3hHTlZlYytxSEErUXF3?=
 =?utf-8?B?STNHNjZuWVBOZXhUd1RBNm5hdXhNc0tHa2xyWVcvU2xUcGRBdEdjbVdsd3pp?=
 =?utf-8?B?Q1pDeGxqZ21vNXdYc0wwV2dVUy9qUzJLemNUTndvT2VRWFlxTnFmZElEbHVU?=
 =?utf-8?B?aVEzWlZsUmt5bVdtTklROW95b04vUVNYRG5sdnU1NkZZVnJYVkpzTW9zTjJY?=
 =?utf-8?B?STRSRmZNVHdadTE3TWx0d1RNTjc0NWppeXAvR0VMeHJwY3dOUGY1TGtzbTUx?=
 =?utf-8?B?K2QxS2MxTUFXTUhBQlppQnRLTjY1SEIwbk0xeHFoTnBSVW1jNEtEc0R0S212?=
 =?utf-8?B?RzVxM3BkR004a3lHV0hGMDZocUs4dkxYTVdOUkltdW1zSkRuU3puU2s1WC8y?=
 =?utf-8?B?YWFsR2Y2eW93ZnRMeThxV0lFN2NFUEQ3VkdoUDRBbHk5K2hTQ3BTcmVFWmZM?=
 =?utf-8?B?cFF3eGpHMFBxSFcxVTZvRGxKdncxSnR0UmxhRkkya3pNRnczdUYyYWpkVHAy?=
 =?utf-8?B?K0pLcUtSRE9TdU5Ma2xLK1NkbEhkUnlSei9kU2pmamMxZDFWbjZsYlZWVzR4?=
 =?utf-8?B?WC9OWUhzWXRIZmUwQVJveGswQ0I3WlF5d2VjWnZCaUFVRVZqR2duYmpZTXRG?=
 =?utf-8?B?bFZRUERwazBkMjhTQm55S0lKKzArZmxDOEJ1cjB0SERGckhieGtaR25YVHFR?=
 =?utf-8?B?VjVEOGhMSUNuZS8raUJYTmNzTWFLRnVrK2RpcStwbmRPSVRLSzFDWGIzQ3l0?=
 =?utf-8?B?N3dKSHF2MXUvVHpidDJIcnFLaWdmY3VKOVhJY3Z3eHZtQnAzcE54dVdiNEVy?=
 =?utf-8?B?eTFXWlFDNXJRL1BsUmNzVW1VMk9FdCtXeXlMY21MM3pSR0p5Mk5uaElWdWo2?=
 =?utf-8?B?TFFCR1BzaDFuUlNraVNLSzIzeEJ5L3Ryb04vK1lvMFZUalZFVldWUmtFV1V6?=
 =?utf-8?B?djd5R291c1JKa0pxUGtJMzhpYnNTUGpnS0hvczd2SXNKRVRWalZjQTNFZHVQ?=
 =?utf-8?B?VHBFd3M3ajB4ekwvZmwycEdXT2grK0dmWXhmK0FIZitORnhuTFpvdS9wUDU4?=
 =?utf-8?B?a1RIcnhKemI3OU56RHFvR25OaFJMcXhwNXFua1dWaTlmSVhOMzdVRytrSFJD?=
 =?utf-8?B?V2V0bFljL1RERzZjdE9KazhvY3hFUFd1OHhQNGFyeVErbURtSHd0NUlMcWpn?=
 =?utf-8?B?K1kyRmpnbm8xZWRyNWQ3aTVVUDhxdklBOWNnV2Z2cGJ4cmdBcENOSVFBa3lT?=
 =?utf-8?B?RmRrZmFxT3VZZ2w3MVpUaXd6My9mL0U1UC9FaERZNTFJcnhDYUlCWTZJTGpY?=
 =?utf-8?B?UkgySjJqRHNSUi9OTlg0eDNodXR4dkVrSEJ0S0RXMTRHbENPUFVwOEpRb3cr?=
 =?utf-8?B?SWZlK1BiUlptMHlqMVdTRis4M1RDM2VXdngvRFpxbndqeEJIaFY1b0phdlNG?=
 =?utf-8?B?aFhiYmFnd044RTR4RXJEL0laWmpEZDk0b3g0Y2ZkdG8wSTkyUnhrdTNiQ0o3?=
 =?utf-8?B?UElkVnBsSUNSK2FyQXMzSWRmZXJpaVB0RkxJVGxpM1BiVWQwa0QweHlPN1Fs?=
 =?utf-8?B?VjNtRDhtMVJTTGJwcFJDeUpSSlVyaHhRQTczU3JHbVVibWN2Mk5mcjhMcFpn?=
 =?utf-8?B?alZscnhJMnVWK215QW1LRERTK0lMUUtKNHpXY2RVcjEwYTg3UnEwMFMyRzg1?=
 =?utf-8?B?VU9NVXVIZENvTm5TS2FHUlZMMXJsUnVqZ3c1VndYRGRoNzB2OG5hcHBaeGNr?=
 =?utf-8?B?ZEZES3pxU1N1dzZVaXVxQ24waFpnTk92ZEdKeVFIell3Vkh1clIvYlJha1JU?=
 =?utf-8?B?VHVnT29PMHB1Q1RqbFNNbjBRRHRjNkJMRW0zWVFMRGpkelI1Y3lvRjZiazdQ?=
 =?utf-8?B?ek00engzbVJmbS9RVzVUMzFLMmN4VDJ5eGRYaVhHblNKTmMxbDNRRWtBMG9o?=
 =?utf-8?Q?upzM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d83fb9f-b8ae-43da-3bed-08dc389734f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:55:26.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19aTvWEmjJyuTGNcfCiiUORM+DdsFA1uUsNHuN41z1ULEVf0lHUXRjWoOPHMgEZW5dd0XJlDhKIv6PI3EYxtnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7732

Add cm40 subsystem.
Add cm40_lpuart and lpurt1 for 8dxl evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Alice Guo (1):
      arm64: dts: imx8dxl: add lpuart device in cm40 subsystem

Dong Aisheng (1):
      arm64: dts: imx8: add cm40 subsystem dtsi

Frank Li (2):
      arm64: dts: imx8dxl: update cm40 irq number informaiton
      dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart

 arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 92 +++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts   | 50 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi      | 13 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |  1 +
 4 files changed, 156 insertions(+)
---
base-commit: 62a517a071e93c650cc847ce300b04a94b0cb7f2
change-id: 20240228-m4_lpuart-30791c032f2a

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


