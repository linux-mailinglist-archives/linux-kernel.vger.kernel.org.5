Return-Path: <linux-kernel+bounces-127127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DED894741
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B63B2824DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6296B56457;
	Mon,  1 Apr 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="clrY7cnk"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2130.outbound.protection.outlook.com [40.107.14.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF856B95;
	Mon,  1 Apr 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010348; cv=fail; b=dKIS+X5paEInoGKRookkv3Rzfkef2kpk7cLjGfylCVEUtoIRT+/xvjIDU1eqid0MghqSigd2ZISwM30ewe+3pw/Mpg8sHb2snO9LZsRNqqTWSDj5O+1UglzzEkgFrSBeU6KenWYT4QA9idzeTHkPtUmPFj70QuOJ9WTfiWog7iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010348; c=relaxed/simple;
	bh=15tZk+yX7OFHAMdf72JNYEbxz/+Meras9AxnabVdvAw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=f5dEgU0EDcE2YMYxA9hgMGesQAg0x3BmejLAOV/xW3fGggVe3py02vlUstP7+NsI5pXIo+T6ov9ehIx0ljJhNr0UIMeOpsbIevTv2uRXp/z7i5C4wK39VUCmiBT6cTCBOgNja5ZYfLHcTHRMjXLpRKUIKzIVcdtBbU+OVdC7uvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=clrY7cnk; arc=fail smtp.client-ip=40.107.14.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWKF4lM7YH/GDXAmLB0v2/uyahBCswE5oQJUKlirWtrS+Uob176NMFR/bMsTPPxNlIC4TLj3RGoubxNNTMXrCbMz/Bl2UIOXs6ej0IBqltTMRqlwdT3ol72N8QjnUYj4vq4yb+v+wE+NtwpNXOLtusrZrVFkFMvGVyWXnqeVhvc/ZvqKZGT0l+NcOfcSXbBev+LzwntiLQyZ6WQjkAaO8K6Ww5JF+uL/oI2lb5NnkObT6dL4ywvboSOB/xjioGKPkzvpojJWr72/Y4H+5O2v6D2Da5N6H2kwDjFYKApC8jkGPBlpFxbrIp2nu9bUdteYDCfkFPWNcWzQ5Sfr388scQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgeaJ4Pw2vjEI+nYH49zTPm+XjL910/96N1mkwiyItk=;
 b=V1FLe+0UpTdfG9SSz9pjjyLizMDbSclP74r8biq1AxXoV5D+teZ0Kn8F0XVyJBuJkUWU2bzXhR6X8ilRj7WjIqtmFo7uOjghmP77LAMwtteVC2NbaOGgl/tLEmLlP7jzMWVSE88f6LEhGSnWBPaVzIJRHg5rPmI6vBjT70ND7r4P43DTIu1LWvgd5pU3BnIerFAziDJ8FxeNqNTK3d7qv7pYMZce2OvM43CrPzIjEvumTDuE5b5qh1EFYtWxGXNUBhT3cDJTFBkJDTvdpAOsf4S2X1+yNlOuqPwUav0J1ZklCTgmvM66kBLT/U3WFiu7BRXdKQDR4OCMs+dT3695Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgeaJ4Pw2vjEI+nYH49zTPm+XjL910/96N1mkwiyItk=;
 b=clrY7cnkjFvUKlDvu4R37AP9lMIexL9SwJBHiXA5ie9LwtjgFhVl3LjwOLXiRJTnh4tl5I/PqnGfVm5/U9jF4X0uUDvYC+sEoC8QABYytn8w12ZejZIU9ACitu//19qtavbul0WcQ9rnUHvSwQ8POq3Z7taG9begfnvA+0zbzCM=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 22:25:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 22:25:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Apr 2024 18:25:04 -0400
Subject: [PATCH 2/7] arm64: dts: imx8-ss-conn: fix usb lpcg indices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-dts_fix-v1-2-8c51ce52d411@nxp.com>
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
In-Reply-To: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712010330; l=1863;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=15tZk+yX7OFHAMdf72JNYEbxz/+Meras9AxnabVdvAw=;
 b=8Ouh/fd9586+6wrzrlVRY+YjTbuep81ZZLENa6lkxlhVT8LNXOPq7Us8UceoO+XnMGjamC4Lu
 WxXfOTQ2zU8DH3SQ9bnwdZNBWbxwSaDjlzomq11vC3xYln6TWWFULF6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9976:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 y/TM3YozDBRbNPvNo+jzzzmY6NtzPGBq8S8/zuC8yCBS5QXb7qitqL8wyfNTz/LH3Pq5Sya98CEr4y6z1w7c532KjmI2KGY1UTCFM1QnalfkwUksNMUxE17Ry/a4kEMvvPpu7HESIOiOPgymxgOnoPGfcaS6SDMvc+9Px6yB69NP6pGzd7h41wU6xD9lOEfWXcJm+7/D4KbVyKP8I4Zm60coC393Lb4FxaA1I46wIOm3Xt4Kwc3w2VYeuPBkSJkyPFaer/Yk13dDrjZTL6XNIP0achtv89cnOCqg2PaixugRb4V87mv9yNrH7giMoYUknFKkVeBjx/mjXEGeWXsKUXg9nvgIuAlzNFeY4dtTu5kVB+iRyMbkMZOkBhjkaTiYCxNCw8+jCTkLNNvbejFQrVeu3ZD0E1ImUvFOBmOHoH6fcG6rvoU5KWOhkpz9tUPgUzlXM6u8EUqsRl7nWeuZmcK9kgbJor6adzKwEO3A3Rm4y+KpwBL4vjUaW2Sn++lr0g4PJIWACBRAGgqG3JkHoQoNEeoWcS5awesbwXiwVp8P9hg+gt10HRrFWYbkqrOtmBG8urYR+93sDCZ/QXyHJT0udNn6usmaQWW/0gWrBPF/k7/M3JMj9AZOn89g7M1tLQt/Mu5Wk5WCiMtAPxaERL5FJJ2pp3iaj+/dSR1AP2E81bUNUZa9QuXLgPmx5l8JoJ4MlFolChgwi1agOHY9TXesx2Wyno+USZ6/x734rjQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R2p5M2tCVkZZMitiZjNvMXdadFJNR3pySUwwcjNlVnAvZ1puamVFWkdtUXo5?=
 =?utf-8?B?UEUwMGV0ekZMMDlaVlpNQUo3b0NXUUNHYWRoMWtBaXM1UFBDMWdVS1FaYkNE?=
 =?utf-8?B?dnNzaW5XUFNRb09yVjBuRWxCUU1PZzcydytsV0xKMTliNzVORGg4K0h1SmFP?=
 =?utf-8?B?ejZZRTlCcnk0RExYMnJqMGFTZmdrblhxVEd0allQTWx0ckF3N1dwbDVlaHdm?=
 =?utf-8?B?RXpjdFhKei8rL201M3JJdmxYVnFWNlM4OWZaWHEySDZ1bGlIcU9id3ROa1Q5?=
 =?utf-8?B?TzZXNUlGUm51U1ZQZDhYR2RKRk5RQ3pxSTdmb2VEWk56RTE0MWVoNEQ4cTlY?=
 =?utf-8?B?RTlQSExvRUk2a2d6eVF6anIySFl2UUdkZERienRzOExNWDlDVkdTQmhTUGpL?=
 =?utf-8?B?bE1sQkhiREJOcEM3ZDBUbHBwS0huRXVwL3p1S2V2eGgxb2J3U2lsU2N3bVBM?=
 =?utf-8?B?NGdGM1NPQWtjSGY0S25Xdk5MMXBwSHlzOXgrallscklicUo4MmkyQTFzM0hZ?=
 =?utf-8?B?YTdPRStFNmlMa0F1N2JvUGVlVWJ3a1RiUnNyc21xbnptUnpycVJkQWwyd2pK?=
 =?utf-8?B?K1grZTlsUFZqWnJtV3ErTHhJZFBDNEZtQ3FBa2pNN3BnbmpNZW1wTmFBdFZP?=
 =?utf-8?B?QlpEOCtiZ2RkYVE3ZEZRc2hRWkVOTU56VXp0cVdxWHhPTFhzOUFlTlVjZkRp?=
 =?utf-8?B?RjEwalJzVStkZjAzb3lUSUtUZ1ZYQThGaXBjMUV4eENEK2taM1REWXRuNkQz?=
 =?utf-8?B?Vy9vTmhXcnNaM3RnaGE5TEFGWGo3NEo3U3UxTEozODBGR21kenJQNklhN2NL?=
 =?utf-8?B?SUVBTTFpTWREVCtERVVrcDFPVmt0clFMQ1FRSTJGZWZQdzZrZnFiaCt4b2Vy?=
 =?utf-8?B?bmVSa2RTekpkWU5zNUI3N3JMRWRBTmo0aHp3dGJEdWhVZlJEaUpKdkV2R01H?=
 =?utf-8?B?Qk9hcDFLMGJmNENuZzQ5bEFmTXYvSzlUTU5TMWx5L0I4THRiekxwWXNzMHR0?=
 =?utf-8?B?TkJFM2JybzBpVzhJd3JtTTNPTUZkYnJ0TCtCTVUwc1dLS1pwQUp1aVF0SXdF?=
 =?utf-8?B?eXVOSDEzbEtlNFlubFpzdU1kQTNCS3RienA3dDVVbERpMFErck5oZTEvaFd5?=
 =?utf-8?B?SnpJZW1QYkszN0NHYWZ2Smo1NkhyQS9kcU1HcGhGbDN3SmVaVHVmRGMybXly?=
 =?utf-8?B?Q2RqdCs3T3VIY0Jvd1hkRUFsRXVkYlZYdXRCOWRJN3A1YmNjMlpycXdNVitR?=
 =?utf-8?B?Vmc4TVNyZk5pSGtkYXROV2Zob3hFVERZZE1Za1JRd0QvTUk3TkcwME1VK0FH?=
 =?utf-8?B?SjIyZHhLVzFCVzNKT0lad2ZyVFNNdUMrVFp6c2hWaXVIcHNPREJBTm03UFVy?=
 =?utf-8?B?aWRQWElEZFNPVmswU1FGVlNPL2pIMWZhazRQc0FQK1NOcVljQUt6azZXRWRh?=
 =?utf-8?B?Z2phYVMwY3dubFErQWZvZ1NyblRxMnpYalVjQURiOG1taU1qOFJFUmpRdDls?=
 =?utf-8?B?MGtkd2ttQXFpTFJoaFVvV3B0U2lsSE5laEkwN2JCU05GVnBLSDVkNkhka2tw?=
 =?utf-8?B?eHVpWm9PeXgwb05NYUY2SFZKZy96ZjZIei80TDBqRC9wNTZ2SkIwUHhhdVBp?=
 =?utf-8?B?Y2luQ2VxN3JOYWU5MmhSZlZuOEk5SGIyT1VDdnM2bDlSNVQrQ2pXSEp3dDV0?=
 =?utf-8?B?ZzgzaEtWNHlhb1gxeS9tb3lXdVB0aFVGNmRudndhd2dyOXBGcFdRTG9PTUFo?=
 =?utf-8?B?L3V3aVQvbjJDZ3BNTldqbE1peG1zYUp6Q1dRMTZrK3BrdkdLcmNrbGlHeDZP?=
 =?utf-8?B?b3lLU3VHNkdhRXNkQ0tTT0dQdTlxSUlHQnZXYjJ0SC82dnJyMVNjZXJ6VlVw?=
 =?utf-8?B?QXJOUjlTeXQ2L2dwWG1YNUZLMHoyN0pQNThpall2a2pGQitSbkRmdkZueWNF?=
 =?utf-8?B?ZWFrV1ZZR3YwWFRxcldIN3hrK0t1VVM3VzlyTzU4ZnZQbVE0Uk9XYmNoT3k5?=
 =?utf-8?B?VkRWbW01d09rRlpLWHVGUTk1L2h1b0dESVFZQWovNmRLZnBSTkQvcVoxQjE4?=
 =?utf-8?B?TFM3YnhvRnpRRWVWUWd4ekZ2YjBXWkt4RU5CYTNMdkRLVG5SYmhtU0Q3KzRw?=
 =?utf-8?Q?yKZM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947c0415-54bc-4302-e2a8-08dc529aab67
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 22:25:43.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEO0tk8PdJKL/3zAaBCsbZmukXMvnFvp/utTHmB2XDDrS4TU+sWKFGywzCb2KoMBARVC6tCfnCgeodgiB92opQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

usb2_lpcg: clock-controller@5b270000 {
	...                                                    Col1  Col2
	clocks = <&conn_ahb_clk>, <&conn_ipg_clk>;           // 0     6
	clock-indices = <IMX_LPCG_CLK_6>, <IMX_LPCG_CLK_7>;  // 0     7
        ...
};

Col1: index, which exited dts try to get.
Col2: actual index in lpcg driver.

usbotg1: usb@5b0d0000 {
	...
	clocks = <&usb2_lpcg 0>;
			     ^^
Should be:
	clocks = <&usb2_lpcg IMX_LPCG_CLK_6>;
};

usbphy1: usbphy@5b100000 {
	clocks = <&usb2_lpcg 1>;
			     ^^
SHould be:
	clocks = <&usb2_lpcg IMX_LPCG_CLK_7>;
};

Arg0 is divided by 4 in lpcg driver. So lpcg will do dummy enable. Fix it
by use correct clock indices.

Cc: stable@vger.kernel.org
Fixes: 8065fc937f0f ("arm64: dts: imx8dxl: add usb1 and usb2 support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 3c42240e78e24..d862d2285d208 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -41,7 +41,7 @@ usbotg1: usb@5b0d0000 {
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 		fsl,usbphy = <&usbphy1>;
 		fsl,usbmisc = <&usbmisc1 0>;
-		clocks = <&usb2_lpcg 0>;
+		clocks = <&usb2_lpcg IMX_LPCG_CLK_6>;
 		ahb-burst-config = <0x0>;
 		tx-burst-size-dword = <0x10>;
 		rx-burst-size-dword = <0x10>;
@@ -58,7 +58,7 @@ usbmisc1: usbmisc@5b0d0200 {
 	usbphy1: usbphy@5b100000 {
 		compatible = "fsl,imx7ulp-usbphy";
 		reg = <0x5b100000 0x1000>;
-		clocks = <&usb2_lpcg 1>;
+		clocks = <&usb2_lpcg IMX_LPCG_CLK_7>;
 		power-domains = <&pd IMX_SC_R_USB_0_PHY>;
 		status = "disabled";
 	};

-- 
2.34.1


