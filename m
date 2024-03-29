Return-Path: <linux-kernel+bounces-125180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E348921B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDFD1F23A71
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D31E249E5;
	Fri, 29 Mar 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cSu/FLGt"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2099.outbound.protection.outlook.com [40.107.20.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC41327E4;
	Fri, 29 Mar 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730259; cv=fail; b=QcoU7ag3OG1i4ikui5/bQmLxJi7b+2f0jY/OKxckd0Yuk4oZCmV8XttXkYRJU8ytg0CQt8CTTPrUIkPQOrlFfMkSKZgyCjNY8oZ2WhPkLwUBiz5MBZfrjmvAD6LdR2uSU8PAHFkVRrd8yeUCwcQrnK+AlER+3S+ImxQD/yGMiVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730259; c=relaxed/simple;
	bh=gagRF9fYZkE2upHp/O+2fkaPU3gayQR32W21kqsrxRg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Va1I0NyFxEp5MfUdWdN8srOUq3e2czMg1vVusla0yyuTUM3IDO7TQpbBKnTVZZn68gxEXsbp7/jS5ju63JU09T6+E+IwtOJnNDs3ROiBYTwbpuLZQHEU83Km54XePMfQDmmaBx/fxZszM8mwOaM5Ea5gZp/Dftk4xhEmXtlfelA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cSu/FLGt; arc=fail smtp.client-ip=40.107.20.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZe30gO51+6OIUQAo3aGoDgzBjcL8Ia6ob+FIS6+3evmVSBQs+UnLq1J0cZ87r8bDK0fqa7m68uCroJRmb52aISbsJLqTrYzUuPW0/1BP+dtxvFg46lWnC9/svSeXb7U1fL7x28/9sKXpiR5GjnGG+sgkrDwQWW+aRYkf2RJDIjrblSeR6wFc3B19T9rY2Sc/stz32t71JBKQQFW5ieVYp9AT4KKN2L+ybdkYy3XFjnFIjf9qzfaBSZYVnteboTbxvDgpssO7OS7FwZv38fghf//QD6F61v+bUzZ69KsA6sspLWog6hT/W4Bg2a9PjXgb8jyw2hGNrR0jSEnuwX1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkrxEcKwbjSy97qtP/Vp7yecwYocTcv8DpJ4g2/PjxI=;
 b=U6/BzVnwjf0sBJ1PxSLZFGUASLjceER4lLZ5sMENwh3BAfhPgpvW6yUC4J8x8MqTER6JHKhF/cHKJIuBp33Lsd5DurT/Ndo4s8R8zakLHI9wQb8HJDwpq4e0WwutG8KRI8DY5KGKRvD72M/gWpqw2gpa621INUluTlfMquPgt2IdhgDNw+DKuTxHjKixAkfJkOPOYqRBclgx+IOGA134jP8rkGUkNazBRS+8JylTpFVYCMAehhhLG19QzQttkqR+wd5httuTE3ITFcKMYJvoSRdTm/I2vjJWPgnFChSflHuNCfxpit+/uG4Zayj613J7RZSitv1UwvpuGluAYEPlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkrxEcKwbjSy97qtP/Vp7yecwYocTcv8DpJ4g2/PjxI=;
 b=cSu/FLGt0Zpaxm0E9rfJUQ8yHAIUAh51O5EG3meovUf+wJTyHFGRyIC8MIlkfSypcc+moSVa8HCaRfxZS/7IsfSeSP62eKzkWzTi7Gfgkf134Z1jts8TYQRTMcdMxkLWxtJcGXxf3d99QBY2XCsOlh5nRyycvhohDu/ZuVY2k4s=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Fri, 29 Mar
 2024 16:37:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 16:37:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 29 Mar 2024 12:37:06 -0400
Subject: [PATCH v4 2/4] arm64: dts: imx8dxl: add lpuart device in cm40
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-m4_lpuart-v4-2-c11d9ca2a317@nxp.com>
References: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
In-Reply-To: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711730244; l=1956;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=P2q2uJGnx61JQDTdrXYuXgRztlk7dx955FyY/5tzPog=;
 b=Bta97xWN2ISR8kvcG1vVf7cV90XBThg++qeuPVnfaonrSQ0JfaWDn/o4EYHBI6vwGrKhkJiF5
 eE3nFoexMu7CaR9Dujs68OjUFn35Op8OVtbPriKqmKAKMTxpNqil1cS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bf+ay1b44NpsDY+bxIJwUp9/J6o6lFwmRkfcwM52DZzDZI+kxmGGHDnKBLfrlnOG5oDZCop++f6fWyGQax6bTvLdPW6314FZNJeThSAg5rToND4zp8iMJIalnAzUOXSt1HWl+JCkBQ5rhy7wmgwHVhMoE3RJ2RvBPrACvourYbqg5EXP3C/prp9tp2aYg71oFXQpIthE8wZMvkLaqxXf+1gGdH0RxsVfQ/o9U53/XgnORoCZ/ohMB91YzeZhJcc/kxezJ+Pl10iO/y83yNJBtrV1usY6nWtuVhAK8DNdQgvdsLMA49cEbgX5y6WOhbNoLH3g1dgpCSAxgHAolfju7u4YTJ7ZD+cq9fCWmIhZksdN7EQcXf9R8ILKe3M9KdUS73+iySArTi29a3OuvT4NItoxYcShHN6GK+JTI+W3eZJizGXS+ck08beGXpMbae+0fVi8mwXSskplD48sgCvSu2CRBatyJ+czpyPa+A4gG9tRfWqjX6UQKvjJkNJt3bAdzJWvsNJv1HV6Q3mgmf0v3DkFR3TPgWgOkpe5cgi3wHqHoiDjRqJvB2XkJcTam9oAJubhosrQR6tZctFeOAeaCvmgOQ6soqHEbP1meccEpW5I9/XCQCnUQy8jUzpf56xqWoZ4tN465ZNPSJBvhZun++W3Etaup6o3IrY2BcDye7/j3UicgQ5l1iS9jHZvKSGYFwmh4McKxrebpa5n11XP/qOUtL+ipgb3rJcDPrL/ZLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxsaE1QRGoxdncyR0FVaExDekJCT2RrcEtBRkRTemJ4MEJZVlovZ0puZjdQ?=
 =?utf-8?B?eDVLYWpYZXh1OXFmYVovNTBVVzFPb3F3V0o1bVE1YW9yZ0JLZEVIU3NPUWZR?=
 =?utf-8?B?VWRvMG1SMS8ycHA1UkxjdElZREd3cW85QjVmOHFpNHZQVTZBUE9RUm5zWFpu?=
 =?utf-8?B?eFcyZkZQR04relQ1bHhaSmFSRG5FR0hJb2JNWkdVZFlibXZWUmt0T0xwS0Er?=
 =?utf-8?B?cTVTZ0xqd2xBb04vajJFT0tEYWVVYzhYQ0piRW1UTllKeUlKV0pYcU9FRlJT?=
 =?utf-8?B?b0NWU2xCR0FCOHp4QjB5a0plZ2YxM1gyT1BDd2l3R0FRdkRRU21TSU11YjlB?=
 =?utf-8?B?ajVEblpkK2hVSzh2VFcrSG1abURqelJSTWVHN1YwZFFJU3dpZitMdjVGcVlD?=
 =?utf-8?B?U0ZpZ3AybmxHRGFzcFphdjVoN0tiZ3RsZVkrVmpSVGV5ZDVETXdhVGIxdjVM?=
 =?utf-8?B?czBMbVRDQVVxa1JHOVJtZW55SnFLUVJZcHVKMjFqeUxMWWRTbG5sbU10d1oy?=
 =?utf-8?B?aWRITUNreThWNDdybnBxaFZncWNVUGU2LzNhU0d0MnpMSUJNR0h0TW9XNUpK?=
 =?utf-8?B?TGpRVm5GeXdKYVZaSzEyTk9LeDdZS2FzV2lGOXV6OHFnMmcwc1NRZTFZQ2VR?=
 =?utf-8?B?NC9jMXFwSm9lOUUzSTluWktUandqVit3OFh6MzMrczB4eDF2Z0h2cURTcjMz?=
 =?utf-8?B?akF0b29Ia1Yva3RYaGlpUzkxVVlZVDlLQkpSN1FBWHUvQ29WTzEzVy93VTRs?=
 =?utf-8?B?VURwSWFGbDh0enYrellWalNReHh1WXVLR1JFSGdFTTh3Q2tyTEE1RVJWWXZL?=
 =?utf-8?B?ZHRQL2NBZVNQYUtGTXh4L1Q1T1JSeWFqSkdGOUpadE9nMUNOVzNuVS9neGda?=
 =?utf-8?B?M3pCQmw3K1ZJQmJJby9nNVNIWjd3M29oQk0xL0MrbFlTL0greFNIOUxDc0Fo?=
 =?utf-8?B?cldBZGVQUFFRSG15aGtTL1FJQkthSkRaMysya21WN0p5dys2bmxCMmN4eDVh?=
 =?utf-8?B?UTdRaXI0aElXb2prRW83N2tOUW45d0VtdmlUYjU4WHpBNjFMbGtrbENUYUJH?=
 =?utf-8?B?eHEyYk5YM2J6VzNKa1NSQjl5c2FJVTNyRktIMmtqZmtQT3RwendCY3F1ZXZQ?=
 =?utf-8?B?WkFzallseXIvVWd4OW95b1hzWldxRGpjYmJiR0JmS05IdU5wWVpkYUJVWXN4?=
 =?utf-8?B?dGlqUmhQSmY3bVd5QWZuOG5MR1BhSHBxTWYraFFnMUQzTGN0U2c2elFOaFBw?=
 =?utf-8?B?ZUhnUkRYWFRJS3M0RVRUYXVZUEpqbm1uV0IwSVdRcHQ3SnFuNjdZbE5RazY1?=
 =?utf-8?B?bVd0djZOcTZNQzNIZTBrU1E5NmlSUVIzUHp3TWRJNm1kdWpZaUZYMGkyVUpX?=
 =?utf-8?B?SFhTang5ZUlmSUNWK0xQTGQrSzZxcDIwcWFuU1hWWVNUbzFqRlEvcUNiTU5r?=
 =?utf-8?B?TkVLWkxmaE1za3RJMmJCbWdTQXVEQmtWWUcrbVlYbExhN05rL2JKd1p5L25H?=
 =?utf-8?B?QmZTMHEyM0Uwb3ROYmtob29aYzh5MllpZmp2NVFaN3BWWE53Z3J3dy9zK0xZ?=
 =?utf-8?B?Sms1L0wxMnprenZsbzhFZWgvSmxVU1EvSmdNYTR3aWlJYi9WOExXSHMzTXNs?=
 =?utf-8?B?aTI0V1JCdy91YlV6dGd0RXAydXpsZnVGWXBWOFhTc1RlOG5Vd3BWWXh5U2hJ?=
 =?utf-8?B?c2JkZ3AzYks1dk9WUko3VnVwQTBWOXJ5bHg3aFBucVJ5VUVDdGhRclEreWV0?=
 =?utf-8?B?WVo0NWE2a1BQMmJFT3RWME9RemtUWkRxUjh2b1o0ZVgyR21Ia3o3d2ZnVC9F?=
 =?utf-8?B?eklWSmFRMHNPSktUN0pvVzFBOEc4aXhIWEs1TktZaVFaRnRaZHdyb1RYS0ty?=
 =?utf-8?B?NnJUQzU2cXFHd0Y4NDRuZDRXR0hlVFgvbFBtb2g2NWpOakphVlBRTDZManBR?=
 =?utf-8?B?bFpWYVQxM3lINXY2UlJ4YXVRZWszeGhQcnhrRUVQY2RZenJUTVFOQlU4MXVV?=
 =?utf-8?B?YVJ3RkdVSHZGc1ROeFJGT1FVMmYyYzdEMlp4ZkdaUVVVSDNPb2t6YVU1MFBr?=
 =?utf-8?B?ZDU5UjVWMGtQSEVTZUNtOW4xdE1XdFUycng1dmpQekNsN0krSDFyTWRTNGMy?=
 =?utf-8?Q?UBSvkPkipRx0IDLLXqU6AV/hn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cb5d66-6bff-4411-9474-08dc500e8987
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 16:37:34.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpZc+U52IxEYFRqQF0sreSQxa+c23Nng/0h849P/qGQqbuyB3CsmB9jLTMFTyB0o4ZOt5nM2/3qZtqr+Dp6g5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

From: Alice Guo <alice.guo@nxp.com>

Add lpuart device in cm40 subsystem.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
index 10a05db06ade9..5cff052b95d18 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
@@ -20,6 +20,18 @@ cm40_subsys: bus@34000000 {
 	ranges = <0x34000000 0x0 0x34000000 0x4000000>;
 	interrupt-parent = <&cm40_intmux>;
 
+	cm40_lpuart: serial@37220000 {
+		compatible = "fsl,imx8qxp-lpuart";
+		reg = <0x37220000 0x1000>;
+		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cm40_uart_lpcg IMX_LPCG_CLK_1>, <&cm40_uart_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_M4_0_UART IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_M4_0_UART>;
+		status = "disabled";
+	};
+
 	cm40_i2c: i2c@37230000 {
 		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 		reg = <0x37230000 0x1000>;
@@ -53,6 +65,18 @@ cm40_intmux: intmux@37400000 {
 		status = "disabled";
 	};
 
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
+
 	cm40_i2c_lpcg: clock-controller@37630000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x37630000 0x1000>;

-- 
2.34.1


