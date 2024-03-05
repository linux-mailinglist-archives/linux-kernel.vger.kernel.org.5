Return-Path: <linux-kernel+bounces-92639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8FC872346
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166521F25F2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A20128807;
	Tue,  5 Mar 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OHmo4toD"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AAC1292C3;
	Tue,  5 Mar 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654121; cv=fail; b=SnSrQFNE+717Skis+loasZZUODOoC7whiqXUbV3rB3k6y/vM7ByUICiendG/XoGpYzeWe+OWGD6ExbhE88VikWEdWRg3eDqc4c4Cy9Gt3/aO33tjl5vReMtB3t8m3DjtiAxrmKKYUC2cRrnA6QQaOUW4BAs3WJLgccwu5P6jvXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654121; c=relaxed/simple;
	bh=ItdZ/VzRlX7BqO2EcdGrqRZGY6aRhLvbyf3GUaMZvJg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZBQxZotJG1ugGQYpJ10BS+ePJX/MVup14m3WRNeQ427OUobn724N6SyNfq/fQppWSo2I4fyCAoMpVltn8YB6cRcknet2ID4CtD73NAY010+2qChP/1WCmtfVzloJBrmLl0zum/7wa9ARgNP+5QgA1c2pIh2a0sluwYpDtiU8z6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OHmo4toD; arc=fail smtp.client-ip=40.107.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSOoQSm3kJ1o6ExIur7mWUAPnxD3yn5ks1T2lu/dMOxyBl3WowK1RcTv9jKwGA2VkU0OkyStAOeYxG35Xi/sPgg7fWHnyeT+p7xpq7vsbp/Ipc7CF/eAqWjHGdT1KFqx6TbQVrKpT83GbMSY6nEHhNjQuGmAtip/LbtKmmE2/eMt6YYHJzAoEAJZ4Znvtzq9kd4AH3f8kVc2feZc15cZoSmcFkRzQi19LXrg94vXBIrjDQg8Mdpzd/U7gprKMuKK3lyVQ6PltHwr5TgbDypkogUbVP22GE/QbML42EgUr4106aTOJ7atdT0eQeHr8ggHsZsSVBAG3UQAZWFGXCavXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3XWc4Tsihcke0wavhB/zF3Kq1IdK7NDa+k0N//ypEo=;
 b=ErfBhW64jQSd5rxUgf42xcBmEbPCMSenQ8F1Q7Xm6talmHuwxu4FwDojmH/qXIn2XST0k2NhVyfsSVnVvuwyM3MPVJcyyiM5ddNNR7h9A8xixUFX4EA6dnce/JtwHdKHMhHsW+Gwgi+gPEPerEftnQVSIq01guOLi6ZItmJGN9s+caBLIfZ7lgUW7so3idauHFuC/yGNcqX0eXPdu/9udi85BUhPDaEGdvrc7Kg9w7cEA04bvEvijJJxLt3HtWBWwQVPQH7fG6RBPL+kNOzYUbBrZTYPdm3PhdkJq0uZFIwUibAi7jk38GtwQII6hzF0mj0NUbYRtu+Su8rrkmG82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3XWc4Tsihcke0wavhB/zF3Kq1IdK7NDa+k0N//ypEo=;
 b=OHmo4toD5WWvCNIKsaREsHccq0rBJDFk0kH3gGS6TLypQ3LfFJFr89TmyE0rcb0qOKEzjCp+U8NnMs0/m5S+l9AmZOTeN73FKpShOjxpkLFq8FjVomrtiuXEefdBzJUQUHUSBIvRK52lmHoEEJPFlpE2ifzLxUEtBjIZesRA6I8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:55:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:55:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 05 Mar 2024 10:54:56 -0500
Subject: [PATCH v3 2/4] arm64: dts: imx8dxl: add lpuart device in cm40
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-m4_lpuart-v3-2-592463ef1d22@nxp.com>
References: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
In-Reply-To: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
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
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709654104; l=1930;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WdFo7Hx8KYQl6mGiFS4ptyxH5Ku3MPG1inOiZuswong=;
 b=K/pOIAnN22yQ/5o1JspK/S6S+8zRkGg2dIjbLqwGJv1R3YBFjjhCF/50ZaBYWdKN6ONMBT/sd
 aPTxBBczW43Cv8A9br4Ah8pQ44chqUKbVk8XJCvuEeuSxu20qV4FuaE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 2003103d-2832-41da-7411-08dc3d2ca5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U5lFO++Qm4c+RmQq5+ce/TGf38N6eS5b+nzCjhqJEraHxK0aZfw0kTbue6zLdkr1y2o1aukSzuVS3ZJ8aWNJhYASHfIhKZTkc01nuYmd4r4ckyhyCkCP0yCcTJ/r24aY7qBoqRVjykgx7aoWcfb6dWDU4YntG3MLFqk5BfA3c+G7OIpMbPv/VDVb/lgzsQcT5qqlO9lDkCnNSUHJhEuDJOehwvYvO6oUuA4iyb8z/GjBMSfBFJr5rIUmq+IoP7CL26OzYut34OyJJ0NsbDL57/dz2ONHL5fejIUuN7EDdfDL4GW1fLGGcJq8ruVFnv/eATBwTAdVVbZvJkG2g3uMr/4CswsRiRXjsz5aykuFK3idC4M6klAcO99d4lKvbNpHCevj3uWQmLWxtVrfu9C+eahRqQZlP10q+r+8Vm9JxmfZFSi9UGbzSa1ESv5RjL5qckcqxnv4qn0kv9oEBIq81ucClkW6Rr4NfXbLsa5Ix28RfL4YAY0GXEJpLIBBHlOb5fTOUKIefTYlD0gOlqf79uuoxh1jtfKd4Hid1NnCKySMsDyQ/t6SbFEVkPvTN1MB+gcnl7tIjzql/K4FM2lfgi86Gpc679VAoqvbXXowow1qdqaCxul/3g0F6CSUtAtjnHQDm1mNasAHLHn8d4byB800oS9uts+DVhLiqHKyWFJWm/fIsesQLFgKBlniLfa05B7aAzpeToFB+4S1aqYQbyFBwkFbkqaOeJKmTwKGngI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTN1SVI3VUxyNm5meXA1Q2ZOVjlnclhGdUcwT2wxTVZ0Y3J2NjJGY29XNjBL?=
 =?utf-8?B?Y2tKam1CZzc3K1dHM0JHcDVhckYyU3o2MjArenB5OWxVKzlMNG44YjZITTN6?=
 =?utf-8?B?TS9SWjk3bkVHYXJYZUJCcUxhTWNUMll6dE9wc3FyNXFKTkdMOUo2Vk80bllB?=
 =?utf-8?B?a3pjbGxONUU0QU51N2RiQWFocFY5MWlEN0RpekdGTkNlRjN6dFd0QjFqendt?=
 =?utf-8?B?TFBhVjZpNmxhejhIKzNoOEhRQTc3NXMyNzIrMDVpM01pcG44TEJ4a3hEeG5m?=
 =?utf-8?B?UVJuS2UzVktGOVVCWFo2WTI5anZPMjdENUgxZmNmYXNSY2tnTnl5aDZSZUM4?=
 =?utf-8?B?RkFOWXZFVkEvaVVCWHh2VFllQnZDdTdTVDFHaVVHUjIwdEFCdlVCdk40TktO?=
 =?utf-8?B?VlUwY1BwUlh3eXVJMXFvby8yMFBLV0kzQ2pka1lhRWJTT0FpRzlzcnQ2clM2?=
 =?utf-8?B?QlpNZm55czRSOEJzRzRKRHFOWnRoejNtMU5FcEdabVN1QWNCR3d4Nmc1LzdJ?=
 =?utf-8?B?Q3BOTUxwU2lneHlENUxIcVFjT2tpYndxOWZGRmdtbnIxKzFqOTFra21yZ3hM?=
 =?utf-8?B?MXdIc1p1aVFSdkhYKzRzc05ldm1rWmJObzlJcWJib05CcVVMUFBvZHdVQWRH?=
 =?utf-8?B?TEFsUUY5a1NyZVNLc2s3MkhEdENmOGM1OHI1VytYMWRFMWJnV2hLV3p0WHVG?=
 =?utf-8?B?dDJaRzRJTkpVYkk3L0FXRExaZDBNZnMxUkE4MzM1aU9KeWt1MXpiNmNjQjVz?=
 =?utf-8?B?WTBNOEZwbUxLWGl2WWx0dHBheGlBV0YyNUV0a1hFU3EyM25ZR1pobDdCTFlL?=
 =?utf-8?B?YVo0bFlKZlZlU1JVeEJsdlMrNFNzRlZUdWdlQSs0Q1plRUdtaUJ6eWFnYnJX?=
 =?utf-8?B?OGczOUVGR2pSdWV0S1VZQnNKT1VUbnlWRlpsYUxUQXdUY0psbnVjd2RLdlFO?=
 =?utf-8?B?VDdBWE5YaEhOM0VxMEo5dnJtZmw4R1lvanR4NThDVU85ZTdBVUt6UDJKTVdo?=
 =?utf-8?B?VVlNNXRZVm1yNDJ1dEJXMWZTZTdmb2NORHB6K1hEU1ZKRXFmeGlGMDZXQ1pH?=
 =?utf-8?B?V1ZWSE1iNW5JWFR0QmlEaW5FaWtiUmVqYjhneEVyU2hvNUg0c1huSzVxNE5s?=
 =?utf-8?B?QndNMjZBaVg0SDRPdnIvQ0FaM09GdjdybjBaTm94ZmxGS2pLM0ZjdCt5ZUVl?=
 =?utf-8?B?UTR2cE5SUGV1cEZ2SUtMc2hOejNXUFNveDZYdGNhcFBjMEZlMENJMDl2Qk5U?=
 =?utf-8?B?ekJ3OUpTd2xpcHlVa1V5Z2w3U0NpTGs5Vy9ZM1hVcS9OckVoWmg4ZG56czdo?=
 =?utf-8?B?eHRvY2E3Q0tGeDhrVXZVRWdkWlczWmdhNHVzVko1U0J5SXk0Y0g3T0lndTVE?=
 =?utf-8?B?TEVjY2RGbC9RQjFEUHBoWW9kTEdxVVhiMkFRTU5ia1ZsK3Vvd3VGNzhPa3Fk?=
 =?utf-8?B?dlh6SXhVTFJWN2RUOWh4MHRyM3E2MmJ2WG9FalF6VmxCZTJRR3VpNGNjRUFF?=
 =?utf-8?B?RndaL0dGSE9zVHVkUDJYcEYyNkZVNmFyVU9TTVd5aktFT0ZUYjVUUUlvK1NZ?=
 =?utf-8?B?UHJBMmk4VHpzZWVidVJjZmtiQ01WajZLakh1MHFmc2dsT01XNDJHR1J3YVBD?=
 =?utf-8?B?cjNjVzZmb2I2eDJidlErQXpNVTNXZmFpdjZoQVl3RkNFQ1VrMTFETFZwM0h6?=
 =?utf-8?B?bnNkbGtUVHN3YUozL0FXdWtnU2tIVDNvU3N3SGhCOUo0dlNEU0NFc0VsN2M4?=
 =?utf-8?B?bkdWMC9EZmE3NXBiR1F6b0JRN0FBS0N5TndRUVhIa3JqSDMzYW54NzA0eXVk?=
 =?utf-8?B?YXZhclNXb3lVYnI5RlNsSVZWYkp5ZmNxUjVQUmtWTjR1V3ZpS25xc2JQU3JQ?=
 =?utf-8?B?Y3BTTUQ0WU5zV0RLRFlRUW1zeFZ1UUtyb25CQWdkZitZRTU3M3JzNEVYWGFm?=
 =?utf-8?B?Z2U1NUo3eDlmcUdoaVVocGprV3N0RGg3bXV6SkhURldDVWhiTGZyWWxveDhI?=
 =?utf-8?B?M1pDdUNmdlAvZkFJQjFIMGVveUczdi94dTFTVzdnT0pVK0RIcnRrL3ZnbWdL?=
 =?utf-8?B?M29Mamltc3dzMFREdmhhbHd5eFhmVm5CQkMzcElkTWNkM000RlloM0N4SlVD?=
 =?utf-8?Q?8X859puEo+jdFqOf7KV5vubJo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2003103d-2832-41da-7411-08dc3d2ca5a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:55:14.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 237MAh5cyAbm4Ti5IAZ9L/VuYmUsdd3OHxklgjzbCnya+rF2DptX545/yoCHX2Y6CO4n34JeQ0rqaqbtQ5FlEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

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
index e918ebd76094d..453e4ea6d2c86 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
@@ -20,6 +20,18 @@ cm40_subsys: bus@34000000 {
 	ranges = <0x34000000 0x0 0x34000000 0x4000000>;
 	interrupt-parent = <&cm40_intmux>;
 
+	cm40_lpuart: serial@37220000 {
+		compatible = "fsl,imx8qxp-lpuart";
+		reg = <0x37220000 0x1000>;
+		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cm40_uart_lpcg 1>, <&cm40_uart_lpcg 0>;
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


