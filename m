Return-Path: <linux-kernel+bounces-85648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601F886B8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC11C24E93
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD15E088;
	Wed, 28 Feb 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qmDuq2J4"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44527443E;
	Wed, 28 Feb 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150137; cv=fail; b=eqgS2+92fl5E9taa/ajtSXlRv8FzfRJ7nBN/rM9UGmT6YYLHOqx/4SGKkdF92cU2ZUeUQ4RB9jL/+R75ryTBA7jaxECR5szg8UD5sPue9eRtO3QlaHF71pQoInhN7haRs52J9i53ZuTLzZln4w9eV94vGbnauKDmZAUW6+tynmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150137; c=relaxed/simple;
	bh=2QZJp330z1NQ63ZIXsSuKg3K4fJZMNIQoHhEoAY9skM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bhLczevPOOa6iRwAti/uawAKjJj8B6tUcptKeJ31Bmur4hAmaJZkOtFzhQSjZTbFxQ9nMonNWYE+0l8VcLsQ0lBHTyR0+t82uWdweQVAOh+jBpY01oxChvm/+SdxVEC2CYsIJ9K9Sv8HRSAym4jDFxFzWIerLB5LJ+PLj3IWZBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qmDuq2J4; arc=fail smtp.client-ip=40.107.13.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6eHS0LpTKPmdJ4YMZBcuDhK/PSdhfd2gvfjFiqQhUTd0xe4Ras6yWO/Z6U+H29dLpdAQoZ3HQ/RBf4M4GePTjDZozb6ocGOUBsPOe9Ob8FI5/iQ3UdGie2El/1KRwV7n699DXi5KvP2rdVvTrRcs/1yQEUiBQ+fWnLvCU4l2W2+7FC5s/+KSGMkBpwLhVMP8fsp41QB5ur7enIKdMXrV9rGWztxCunNSbZwqXBAnFfYDC5F4+xiNHJAHaAFnyDrw9GEn3I/Zj7zwKvCHvZedkobhNVBcwcJ7NOhFNXZKP3ziBtMXX8APnykjRKQ/aFxT7XeQ5d/ruFvDRqogFW/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P54aU/0muKUHc9q9/FQCUV/wGdagnXe8QxHDl5HbLY=;
 b=B+Civ/5H435r0XgwCt0MzD9wNs3mf4wn+9Cl76R/rxse9GYdKl5TxHXUEa255oqGiegHZN1Mjbu24zYmtyp4+To+SYNGpmk8t/GhmV0q40OG8eO4vHv60DrETqP0/aCRDmMXSTCwk+CdntuTR3vRm7XsjQ+AefnRliRwxMBFJged7Giy+TO0mrexTqfyEH62uZeOTvAKUtp5Yck772PbgMYyvoy+iDyLFo/DFWLJ/Dj8MsJTSSQTI2cXFFxwvr5PYmbd2W2wwsDEIYFpgKNh4xxFopP431VQyoCzWoSSDJQALcG6EMc5mrgB4ea6qTCciFhgfPYg0NTtTrBXBINUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P54aU/0muKUHc9q9/FQCUV/wGdagnXe8QxHDl5HbLY=;
 b=qmDuq2J4Iiasb+QObH4MrtUzb09nj8q1esRZeOLH/bwAMqJPvc0VhBfw8EtCBMVg2h4weZXj/uq7XtZsHa/XcuNXEfgx/oSq3Sv5KmYOW6FU15jkgPGMbA/frG8sVjfS6XVnL7A/+Z5Hpvh6bBm4k25PNpa9Q9RmEg2O/SPsaKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7732.eurprd04.prod.outlook.com (2603:10a6:20b:237::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 28 Feb
 2024 19:55:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:55:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Feb 2024 14:54:58 -0500
Subject: [PATCH 2/4] arm64: dts: imx8dxl: add lpuart device in cm40
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-m4_lpuart-v1-2-9e6947be15e7@nxp.com>
References: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com>
In-Reply-To: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709150122; l=1587;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=m3swBKuCuixHgTnVFUAdeAbkaNmwg034YZcZhbnpy4E=;
 b=aOA4yCixLXsMmT4zn7IyNIfKiVNgsQfavhBKZvEOP1rofO+lJ1L7/DaX9MTBnzFctcn2ui5hY
 LD5LeIu+ISADktXube5VsmO7Uamj4z/TsUqFYNmQUAUA5fsV1zhAUHz
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
X-MS-Office365-Filtering-Correlation-Id: 6f8d55f4-62e5-4144-429e-08dc389738fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ii/0h80+WXJGWR8PyqY1bylDTowiwQkIcMv9L1YpdnioKBrnKCypMkzRcGGybiV8RgQxCa6YX/KTUNvCxqpssPiy7Dnh1Tv8U56441HoEypqA2PFs8+086P2uKPBlSW4Mg2KpnOZ/DVxx7Hlj8jVMyBF2IyF90fNOBPqKgI4y/6tmGgCXWJFKqW1Zx3WZSd+vQNVQHhSjfgahzyn6G3MT/DUADCoIlYk9rGg1yCnqREDYojBqQUItPgA1hNsKhOTK5q8z1i4gSxJnwF3+Yf6oNbl5AVzp7MaxZGZ9LrNJvz3NrVJ9cNB3NP74uFJY7oZE384hw7vjEPdHz0cTbOro5o7D4PjJ54oI+XLf7EghPChxkxnwFtzrsCQGwcVP7qgg4Rwa9XrqWoumeKWHbGDWLJqG9PKd7V3kBxNDfGDZSt0586ipI1jAJMTqQekPjhD4SiLW4Aq5Idk7Jy5p4Kmy4dKRGZbwrEL7pjPbw2gIKQE+I+/GpkScnRk2q9YRP597idI/6mlP/jZg8qYyn6NK6rmUPXekAi0bEtf5DqFPo9vjprXBVFGlpEVdq6lxpnj1jlKhZPBo552Qx5AONBxPuE1IVICR6PHCFqQ/jP2dvWjS7/KO7Dj/LNu2ja0lZxpzAAo4z28UqbuTErR6hHkd0TM7aCNyNfvMxHBFdof4REglSUDQxZOIoEmeEY21R7zm+gGh0YlQ/J4v8QklsZ7YVR4V/iBPmAY5HLHrQR84uQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEI3Mi8rQ1NtdWtBaGZLMnBvTCsxdVFWaXlaSHdWS2g2ODR6SHRmaHRHOVN1?=
 =?utf-8?B?V3pQd2FnUEZRTWh2dUFKUm0vQzhQMUEzNDByR1RRalQrZXRXK0dIL0NCNmRq?=
 =?utf-8?B?Q2RtZFhkWTEwQXVxbk9MT0FNR2FkbGR0MzFqczE5dzlSK2R1MWJ0RXYyWldS?=
 =?utf-8?B?d3hBa0xSRURpdXdGY1JaQmxlNjhrbFRoUUxycUR0UUZ3a2lWc1JUUkpVS3E1?=
 =?utf-8?B?aVpGZFdIVGlQd2p2OVNVblB4TzFDV2tUenFQQ0xpS0I2Sk0xZSt4WnlpUjJ6?=
 =?utf-8?B?ZFdhajhuWDV0cWpHSW1QVEEwenZ4dTVhVy95OFJZaHBJcjl5N2RNcmVSS1hv?=
 =?utf-8?B?ZGUxUWh5WTFlRUJyeE8xRW1RbnNhK3RGbTJURklCUjBZd0ZpcUFUajlzK21V?=
 =?utf-8?B?R1drR3picG42NEkwSzUxN25mNkVWOE9OdTBDZnNnTjJvZEdCQmpXOXpYVGI0?=
 =?utf-8?B?OEllT29Xc0hqSjBPV2diOGNEQ0JqUEx4ZG9ibkNDR2tvS0NkT251M1RhOWE0?=
 =?utf-8?B?SmFTVk51WnJPMFVaNXozNTZxUTNpSW5seDAzWmUyVTdRREJXM2JoY2Q5bENt?=
 =?utf-8?B?R0l0Rlp6UkNndkRjTjVPRDhSMVVLSWdkNVZYQjQyMmxIdXd3VjFIcHRiSEpI?=
 =?utf-8?B?OHRQSURwSy82KzN4ekw0Ky9QOURuRzQ3ejVsb3UzR0VvTyttVC95K0FJN2JR?=
 =?utf-8?B?V1RqWkhqbzZMdEx1dnR4UTZ1Wm5HbGpHemNYNFJiaFhKVkh4ZXM4L1lTM1ZX?=
 =?utf-8?B?Z0ZReFQzeUVNUTNsQlB5NDVCRmRCdnhIeXpOSnNmalZLMFBhbi9Na090aHhv?=
 =?utf-8?B?TzVFZHhpNFpNUmVJTEhEcHU3bnpZUS8vdjFYNDBoTURocUljMUE0N2dhcloy?=
 =?utf-8?B?NmdpUnkyeVNrNzNIcVN3dDNuM2NwUi9sMzI3Ui9RNkF3bG9HcG9MSWtxa09X?=
 =?utf-8?B?UWw2UlZSeWFTZkFpMDN4TzFHUThxYWRUM3cxU2o4NXV2SDNONUNrUjA4Z1cr?=
 =?utf-8?B?QTQzdGN6Z1J5MW9Va00wclBad0xBVmVuN3FHWWFoNTVGYVZZVGR1QUxNNzR2?=
 =?utf-8?B?cjdMRUhMKzh6dlN4bmpqZjlYdU54VWRvTlFuWWp6Zm1ZYjgxaHJrTmc0WFVR?=
 =?utf-8?B?RklLSGttbGtoMWVUNG9ZSk1mK2pvNVVDSlNBQ2l5TEkrTTZQUVBTelo4dGl0?=
 =?utf-8?B?NDI0RC9nb1ZvdjVPbGdQR09pNFlIRGdjMzAzaW53bkRJQVpTM1Y0QzhXZ3ly?=
 =?utf-8?B?eks5UVZtVk13OFJxeG9FZjJES3Uwc1NxQnpEU1EwYlRXcGhyOTZPQVYrMVhX?=
 =?utf-8?B?RnlCdWxUUE5LbWh0eVdIMTh1cm5ka3dTenI0M0ZKcFpveGV5SEpCY0tBbzMy?=
 =?utf-8?B?K1hqdTc1YXJhOFl1YlJobVJWM3BFN25BQ0F5QkpQeVhyazNCd3JhZ2Q0V3RT?=
 =?utf-8?B?b21ReHlEeDZSZVhlZ3lEa0dyaC9HcUROQmVlMSt5d1B1L04reEx5ZFRBR1J5?=
 =?utf-8?B?cEl6TXd3R25rOGNDdlMvc1UyYThlM3FYZ1lkUXZqQnBpQ2ptSUh6MlAzNHUr?=
 =?utf-8?B?RDUyYjg3blhBYjVsMFNrbENxRUJmMG4wRHdIdXl3VHIrOStQa2hpdlpTcWUr?=
 =?utf-8?B?KzhsQ1Zqck1ERW82Q1lPcnQ0UjZibERwOHBCUm1jQUwzK3dRYkMyY0lvVGp2?=
 =?utf-8?B?Q0d5UVRIc0txRzc5bmZmeWxEbDN2WFU1MktkM0tDOFdQS1ZoYmxEKzF2NEZR?=
 =?utf-8?B?RmFOSGNiQ2FLaUhpRjR2VFNFVGRpYVQ2bFVLRVhCSTdaNG9ZWmN4ekxOdE8y?=
 =?utf-8?B?TzBZL3UyN1FlSUFQYWI3TUNIZXliQk5YREQ2SGZqWk1OTHFpRXZzRlFvcGFx?=
 =?utf-8?B?YXNXOTdRVTlOWlErbFZoYmt2SngvWW9SNHJ1dGhYK0NoRG8zM1VjS1hYU1dG?=
 =?utf-8?B?eCt3VlA3OXZjTTErMzdDamlRTHQ0TEdVM2gwaHk0QlJNbG51NTV6WTB4bFZl?=
 =?utf-8?B?MnZsdC91S2VDdWFPWmFUTzZPZHRBMnArSUYrQXJSMi9mU2J3QUI5RU90MVVu?=
 =?utf-8?B?NXFGRXdoTmtmUEJhSFEvWGlrdTY1YXZiZnRjQVhxeWQ1dWQ3S2JQNVgwT3Fq?=
 =?utf-8?Q?9lTPq2Aj9bH3dAqtmdz/Up19J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8d55f4-62e5-4144-429e-08dc389738fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:55:32.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTI2PiXD5BYsQMYEbZtpvP1UwZTQW9/ISrLrJtPLKUTZJRq6AzymCKJKB7CrohF31mEEQMffEKhgjTwyk1SZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7732

From: Alice Guo <alice.guo@nxp.com>

Adding lpuart device in cm40 subsystem.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
index b1d626862ddf8..ecca5ada224b7 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
@@ -64,4 +64,29 @@ cm40_intmux: intmux@37400000 {
 		power-domains = <&pd IMX_SC_R_M4_0_INTMUX>;
 		status = "disabled";
 	};
+
+	cm40_lpuart: serial@37220000 {
+		compatible = "fsl,imx8qxp-lpuart";
+		reg = <0x37220000 0x1000>;
+		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&cm40_intmux>;
+		clocks = <&cm40_uart_lpcg 1>, <&cm40_uart_lpcg 0>;
+		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_M4_0_UART IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_M4_0_UART>;
+		status = "disabled";
+	};
+
+	cm40_uart_lpcg: clock-controller@37620000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x37620000 0x1000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_M4_0_UART IMX_SC_PM_CLK_PER>,
+			 <&cm40_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>;
+		clock-output-names = "cm40_lpcg_uart_clk",
+				     "cm40_lpcg_uart_ipg_clk";
+		power-domains = <&pd IMX_SC_R_M4_0_UART>;
+	};
 };

-- 
2.34.1


