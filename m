Return-Path: <linux-kernel+bounces-147109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E024C8A6F99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9D5B23B86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3CC131E2A;
	Tue, 16 Apr 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VzeFNnfS"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA0130AF2;
	Tue, 16 Apr 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280749; cv=fail; b=eUXAmPfLlVAD3WCpLlNDbItTnvXDpNkWXFQznVhOJRMN/7SPbHor5sqlEDjuXgj1l2f1Wkp9rPPuxaH6egV2h7ndGD87FpUkMLI1ueXmE7UHA3UK1kQ/yAQI6GWMpHMwqNs+q7hYHTJsdMPpvaUyNP2AdsqgcQPXfykfMmIl5+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280749; c=relaxed/simple;
	bh=oUBRcmkGSLrlkCgx3fL24X9JKZDEqdGA8tYxWr1acv0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kEa4cX+R8vWPVFW9Ksxl4vNMOJfwxcMSUTWmAeHlm/kEgq/gy5n2oK7MT68vkqQtm/lvEfidjjR68a4I+idkmVo1AcDiOH1ZSN0qhf0Sz7NEaNtp6EHf1hUhZg2DiAtFg4jmdBthQtSCuhGmeBr1Ifn/ho8J8NFfsxOXMbnRbRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VzeFNnfS; arc=fail smtp.client-ip=40.107.105.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH4SqJwMkUOxn0/sUyKWGTaC9H5def7L736x/QIEcoKTC47AX6Xwx1aemKM3zA+jTHwhDwJI5bVVadZCOA5eWcqIq3rf5eEzRXeOueDrDMMix3n6nrO4tlWnME0P7PFWBxRfa9t1KIpdYcfHVuG42QeOdC4LP9xjIqy0VCotUcyEZYHaXeGP0hYuBK2o5wRgg6Oa4hK+hs0uZTrD8iahBk4Wx347xMpY0e5n/PV9DzvCECZqLJo5ZZ9zZpAHIJ92yvf83SjCGlYqtpiUy18qZDHzTmvGBfzwltVYcbk+H3KL1/tU6f/5LS/3Z2eCvslvlXymKYITxrE/JBt174o+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKgyZEJN/tuLVi8zm0HzDZF2ertIWMp8rOl19QvQk/E=;
 b=SulJmD0rmPVD8GdenxA6HZPSUbYJml15hOz4eItuUIxfDQPSZAOm/rN2EZMQQkPYorCm+B/9mu2nmOkLnV9nX0sE2aruivGlYmpWiPox0CeNNuuydAyKfiy6nn4I+85/wgDIzh+0FEXshlDn7aMf+A0N4xOaj0exlnExhLOiWj50x2KNXRmJYHdkPlNVmML/Am12FTHeCSel3uUim/GgSuRiJMDwi2XR5rryaiwZ0XFoX2tpg4wx8k57pr9gOpiX7oAzjQLINI+Ch77N1KUlux9bZcU+0KLaYkyY1J5JyxEQKyvZ0WY7Q1L24wOF7ZLlnaEQlyn9wYPN0/ceJJkvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKgyZEJN/tuLVi8zm0HzDZF2ertIWMp8rOl19QvQk/E=;
 b=VzeFNnfSm9hkilCoizQ8JFtcHOb1VCUiC49iwmR9d0ViQGgvuNpvXLQQIcwbsgQnfrdSIkWm0grBdGBwRbZbA6XR61wt7BO5b3kk6Df5G0F/IKPsp5WcZFPpZImlRvuFiiIufcwB1e4NtHlJK1N0HpC0ssTNM6dw7gjMVzkp46k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:39 +0800
Subject: [PATCH 03/11] arm64: dts: imx93: assign usdhc[1..3] root clock to
 400MHz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-3-da8ac02e8413@nxp.com>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
In-Reply-To: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281223; l=2352;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=43TMrikuJPDeKTPwXqNdDtrx1wbjdfaZV735qSE9yLs=;
 b=4e7sAum6gdSVCl2B4SZLuWPHS4aK0E7Kn9gNuqgLiHQ5MmDcgwLE5ovqWlYuWEcN3TcuIPNbY
 7FMaPbchnnpAhDN+MEGwvABNEVVF22mSiaiqQEGFxtFtPXM/QWSpT40
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 874f4a8d-7c58-4b33-4540-08dc5e288d8f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mhCo2/73P5ak6I1FKyHs820tErPTMhY5kEC3anfL7qGnbW4EdffurA/mUu78Sf37G8vCAsKeQRSQKyt4RhTkkx/9p+js6YZn0sElqBSASYdh5okqbidy8feqBUHB/NcdVS8ygiKYM3+1bjNKsBpMt4dK+YKcFLsPAtzegHHu0+/paEH2StFyOedAaYb26Mc5dfBwYT34oUXMfU7olEbhbtvzIjtWT2pdG0bUlLHPS9V4kpwiSiXI024QDxMcut8KYtEE9ajAyS+0FKP5QIyWvVJd7h2K4U5PBgghwmhXWaKDmSvGhFDxwgKYdqViruiwry5H2LoNHkeH2ocI2GRlKVklLsx5WuxQmHFpulrjpbIVPMltC/Bpwi6pKFlCML2L/EH4MBD2yGUP+1XyZr24XUg0RldxrV2A4GfVCiWQLNMCiIGtRmf22LRuMW6HxUKm3wLgznWSIodahYfWjGz+9CC33or6S9WCINwhIaZzCWqOPd/wznQ9UDcmFMS5NiEkXhSjFE08H4TeURMSDIIqCQLQLXQOKt1eMgpe7zqvYuAJbsP9G7476ppOtlxr2rdrna/DUdYCD/k4TM0PCP2biB+hqODkMjKzWJSeU0N7h9Mjmqs4XdXWSDCTLGc7hJpmpYmCcnY6LfjNaKRGVjZGjNeSe9iY5qYjM0VCeH2LjHp26YyWiTIDXFSyh/7rvoKEnxqxnnwl7Mup7BhXMYASlPqHBUQBaktwwpEjz+7BKqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ky8rdTEzWEtYckJVTDNycDkwdktCd21WYXJvZGhPa0UvWjVKM3RPQnNUdmow?=
 =?utf-8?B?T2dFd0dtbG5TR2I4QU1vVXJybnovT3diQ0Y2V25ZMkh4MTRiaENFY2NTZmkw?=
 =?utf-8?B?SlF5T3ZWR01IaFZFNXRJTGZ5TVZFQ2dDbkx6d3IvcmFZVU4vVnZUcUZjWUZN?=
 =?utf-8?B?NklhdGQvaE1SYmYvOHM3d2dFbkZvWUZDQkFnL3pBTnFvbk9DZ3d0WHZQd3hn?=
 =?utf-8?B?eDZ4WEQ5cTlDNXh6ZkxCQWFNQWpLV3lGNzBGN0xVMTROR0JRMzdlRmwrTTdF?=
 =?utf-8?B?a1dmNE1QMFIyR1p5aXpURmVIaXVNc3B2OXBocDVZVCtoN2VqeUg2UjVRMWRJ?=
 =?utf-8?B?dDVEOHBXbmFkZUJZaU1mU01Ia3JBdUxVd2Z1aHdjNmI4QnJ5SS80UXdoYkt3?=
 =?utf-8?B?a0x3dlM0ZUt2MFFhTjFKMkhLR0crekZpc2lzb1MxazN3dHNlSGhMb0NsWDJV?=
 =?utf-8?B?a3laS3FmTkYrelZaeTF6WFVXUC9FYmY5Y2JuNjVLZ0ZtOEJtcFhndEtVZXNj?=
 =?utf-8?B?T21CL3pVODNSU0JyWXlWeTZyK0JpRGdwRDJQT09NbEE5NlYxc09jZllLR1A1?=
 =?utf-8?B?UVVXNzU2SkFqeGNzQkg4dXZuaVdlbksrYTlwdUs3VzVvcHRzVk9yd1hFMHEz?=
 =?utf-8?B?MzlQMlRkQkJ5RWhKZUJlNG9WenU0cW5Ec0trYUI4eWpmWHZwNDNnQ0l4Umwv?=
 =?utf-8?B?OU5URWJEdHF3ZWg2UlBsZUVheGZtbzNQbjk0alcxMzBEa1krQWYwRG5Gd0Vv?=
 =?utf-8?B?dHlOL0lJSmJSdmhGdFdQaW53aUQrbHpXYXRTR2RRS0kvN3h5blpURlg1RWdG?=
 =?utf-8?B?Y05kRTlBdlNDUkEyTEliR1psQXJXcVpDRUJmaCs2dlMzd1ZPMXpCZ3B4Y2xQ?=
 =?utf-8?B?RWs1Q1lDcFp3aUlGS2xjU3QraWE1M0d6Rm1MenhxSjRQeW5KdVJxV2xIa2M0?=
 =?utf-8?B?TGN3OEJqM2N3cERFZnZ1QzIvbGVCS2l1VFQvR0U1b29iSE56R0xnazdhdE5F?=
 =?utf-8?B?cko1R0VUQW0vaS9ZOGhCNDNJcEJ2SVU4WVJwYk1tcnNWaVN5aGJKSk9Odld0?=
 =?utf-8?B?blVTZ3cvUmg3UzRUNDdZcUtlTHFOcDcwVjNMOU9nL3QvTVRSTHRGNDVuNkdG?=
 =?utf-8?B?bkx5ZHhlNmV5amZVTXRoWE1oUnptUDJ0Q2luOFE5Q1J5MTNnTHRNaHhLcU94?=
 =?utf-8?B?c25EZC9Yb0MrUEVMWFJieEh4MUdBNEdkRjQ5UEppN1o1aWoyN200RU52R0tw?=
 =?utf-8?B?S0hMZ2RIN3ltZmZ1Si9tTWd0L0UrK1ozaWplZ1orajVCeDFSemNBT2dLYkRZ?=
 =?utf-8?B?aUtlYU5MRzlvWXptV291V0FENTVTLzFTRkM4c0VaTmMzM3VhRExNUHJYZGQ5?=
 =?utf-8?B?WUlVQXNzYTVWMXpqQTVoWFFPVHJvSlBqQ3p6dDZhU0szWFMxbHVrUW9xS0dU?=
 =?utf-8?B?WjBTWXpYM3ZDWVh6ajZ3bXVhcWRKSHJJdHZNdGZ0SDgzcXdGWDM3VFo3R1hE?=
 =?utf-8?B?czcvT3QxTGxYTytkT3h3T05GQjNwUVRqYWpvWE1oZ09KZ1NQb0RsQ3JmM0x1?=
 =?utf-8?B?ME9hdWtMWmtkdjNnWXFLMVYvckxucWp4NFBxdDRia0xuUVAzb0RPTmZlVlpE?=
 =?utf-8?B?SUNwaHc3b205OG9aMU5hRytPeFRvVTdpSEFUbEM4cXhGZHhUTUlsMzAxZDAr?=
 =?utf-8?B?L1puQ2wvaTVlUW1kaUIvQ1lOdzNnN2VESWNRcVdtTThCem1LdDB6dDcrQjVN?=
 =?utf-8?B?ODlwWHBOcGtsdVJSTDg1NlFIeFN6emNXdnAxTzNYRDJwamduWjRVWEpkRk95?=
 =?utf-8?B?Q3NPRjNyOWtDM2J6VVh6TWdFclVvQXkvQ2VtbzQvSStvNTZkb2Jlb0kzamtD?=
 =?utf-8?B?UUdHWklCY3lQb0p6NkVsSy9BRXZQa1BPSnpyUVRSa0lUenBUeWI5S2hBWGRU?=
 =?utf-8?B?OVRFZ3d6NmNkS01SNEFYUDlNRTRsMlcrOWl4Yk1UaFIzMHNhdGdaRzNnc0FU?=
 =?utf-8?B?cW12U0RsTmZ0eEd3M3BSUDFibS9FZWthM1cyS1luZU1PNGhyTEM1ck1HQ2Rj?=
 =?utf-8?B?N2ZjMUtqV1dGZTBtSElTQ3kwQVhBdlQ3K3hQYldzRlVPTXFiTzJvMTlOZG4w?=
 =?utf-8?Q?WVO8H+ZySJgZUpctHkQdf+p+G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874f4a8d-7c58-4b33-4540-08dc5e288d8f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:04.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQawTUF66RDK6UWsYVNjaVFO+p6pLCwOdRKOhhxJhXuGxYwDKL5jEUuS1Jub7HnXRjdTpSDRw7PezvsZT3RqBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183

From: Haibo Chen <haibo.chen@nxp.com>

1. Config SDHC1 clock 400MHz to support eMMC HS400ES mode
2. The original usdhc2 and usdhc3 root clock is 200MHz. Then WIFI
on usdhc3 at SDR104 mode can work under 200MHz. But if imx93 work
under Low Drive mode, the usdhc3 pad signal is not good under 200MHz,
SDR104 mode can't work stable. Need to downgrade to 133MHz to let
WIFI work stable. To cover all the cases, for Norminal Drive mode,
keep usdhc root at 400MHz, then card(SD/wifi) can work at SDR104 mode
under 200MHz to get the best performance. For Low Drive mode,
bootloader need override usdhc root clock to 266MHz, and the
card(SD/wifi) work at SDR104 mode under 133MHz, can work stable.

Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 00f2526c4011..1c5e2049a37a 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1017,6 +1017,9 @@ usdhc1: mmc@42850000 {
 					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC1_GATE>;
 				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&clk IMX93_CLK_USDHC1>;
+				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
+				assigned-clock-rates = <400000000>;
 				bus-width = <8>;
 				fsl,tuning-start-tap = <1>;
 				fsl,tuning-step = <2>;
@@ -1031,6 +1034,9 @@ usdhc2: mmc@42860000 {
 					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC2_GATE>;
 				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&clk IMX93_CLK_USDHC2>;
+				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
+				assigned-clock-rates = <400000000>;
 				bus-width = <4>;
 				fsl,tuning-start-tap = <1>;
 				fsl,tuning-step = <2>;
@@ -1094,6 +1100,9 @@ usdhc3: mmc@428b0000 {
 					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC3_GATE>;
 				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&clk IMX93_CLK_USDHC3>;
+				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
+				assigned-clock-rates = <400000000>;
 				bus-width = <4>;
 				fsl,tuning-start-tap = <1>;
 				fsl,tuning-step = <2>;

-- 
2.37.1


