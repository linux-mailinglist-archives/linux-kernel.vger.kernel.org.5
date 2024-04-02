Return-Path: <linux-kernel+bounces-128188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EDC8957B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B2BB2DD4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3FC13F42D;
	Tue,  2 Apr 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kBnVntp2"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2123.outbound.protection.outlook.com [40.107.8.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FF9135A6D;
	Tue,  2 Apr 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068913; cv=fail; b=JSl8K+ya8wujZ+rMWRLSAtcAkT3vmJcbY73cd8OsPAMzhuB9/VV0HwCseLXHc60K1ECWytiOce4GfqMEy62ZPETtWW4bSha8K7c0GMCa2NgjS7Lf2nd3TXqCfLh0grPpKlKZyg/yqyDS/HbxQSwPV3HxTOjCVyxzl7EIRRHLaHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068913; c=relaxed/simple;
	bh=ezKESm04hb0tDtOJej/9auHfcDxeNUg9OneAZwc9sB8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K69YFKhxFn4KFoC4ZHIwTEOV/C5CyENnXVERXcQu6jFWh9F2GZ+wT81lWs7Uchil410oyu6iVyDMaXo9zURHaYyeD6lQohcQrcnpZWy8qWODDgybs5CcjqcyEql7H/3ful14oAtkf8JpVwL2LcoRVPmQWklRq4NE4prixYDhCks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kBnVntp2; arc=fail smtp.client-ip=40.107.8.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBELy29Fz8Z8WgK/D2FwXRV/5K9p8ferMeDve5u/2pitSeW9x3w0S1PWa9WsEahdb8TjaBLzsr6o9fzNdDdDeTuUx13YQbowbCUPJrwoRI58cEfvEyMCnPk6u4YF9gySfJkhGu58acnoQOTKJgPsmjf7HO9oNHdDUkPtnG05smwbq0hwcDyAjV5jxo4mQ4u2nCCGMz3laaqSl8ef1sApLOw12X8AAobilWJ4TE1vWrNegQMWPugl6I75RpyayYVrV6S8ew0WMOwAemZhBjQOQr1L7dowdL6prfuUiHweXrNLn4tBQgbfJRBjGRR+yq4DV7ZkwkYc+yOH9Xqb5oq3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PBu9Ofbvdq3w4toNq1T9N2XvBAWs+zwfckiy/WpQ0U=;
 b=jqis8jj6LNyhX3cDdFoXr/fIENjuiQeUeTyX+4crc6iOhU/x1xSQ5EK493Dnc+re5gkaqMhL8l6YbHCMHnPwOqFUBMlcLEv49udKLX2dwFP1DMMzVUxTBtyKLwdR3uPT/c+JQq582ep5oxGnbpxTL55QIW3q9zYNgqXlMaQzY7tQUWt3VzoE15VaHmzKLsm5hqISlHE6otv83Z7OuUoWAQBMWeS9pBHqvdy33dOE4zUeFHanObj7tG0eaDKKTF6JMW0gxV6TqZkT9Ps+AOCHFDHsLlVrMRRfO4CRoS/enezwktnb6AWyAbrvs3LYHFgeA+Sd8CHKnK51WfOf3poO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PBu9Ofbvdq3w4toNq1T9N2XvBAWs+zwfckiy/WpQ0U=;
 b=kBnVntp2U93sqHXPoCJQLTjqqk/YIfQyF5SFzpFcYdwN/OLZplHy8UwC7QzJwBBRWAakW5NFhk4HOVhJoxsCyaHgapRJQmXKXyQjrM2MO84GBbSrZFUrYmusL63sSNwLOIsHjTp1VU96JsDnRElgxMnAGwcS6R7DRL7wM5dFF9g=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:41:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:41:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:41:29 -0400
Subject: [PATCH v5 2/4] arm64: dts: imx8dxl: add lpuart device in cm40
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-m4_lpuart-v5-2-3292629ba808@nxp.com>
References: <20240402-m4_lpuart-v5-0-3292629ba808@nxp.com>
In-Reply-To: <20240402-m4_lpuart-v5-0-3292629ba808@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068900; l=1956;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xhftbmI39MyNZ7AlH9MPH4XMpN/P+j2DoWHw2Dq2AB0=;
 b=Ek8XrOh6Z5I0ju5ZoIv3DUhznbRU8ENoO6rMQfH7wg9XnuJgxNxh/iZ1a/veunkZjzBxkyFxl
 UbpRkdgVKj8Dos9GQNyaEcCaxzzGfM0BsXQyooF1m76k+aLxHOCjsRz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:510:324::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YtNubLfhYbgiLCaElkYnF4WAX9U+AFt0ffYnEwW7cSaMlTe30hgBtX71WLvLLH4H+/sy/00I8HL9DX0g6dMQe+uJb9P7KhmF5Ci/kqx1zSrhEL2CRm3OfPkV01v7UQobxWQGHiUtg+kItHAxkZ65H4VqQsZQju35C/R6a4L3UpynW9nslkMUzR14IDFnhfnKEJgrGmq1i3i5OLRgSGcznbyhbxC01wMAAGGNPl+Qh/E3nyonQ9HPwtU/00P1Z8fDDSKlMoFOFLnpEX23ymC6P1QDGkog5DWHW/SL1s3Lkef3huv1Uqe65O1ByBsGhHAqc7vRpePejysNe7Sa1FYd117/bz/MGeRyyXY+rJfXT2H4GJmPvgff0gbDbtNKSclpCwIQoQ6c/kWgUsU+L1g4JD5GlnhNMwoSIZpl9TBmYa3lfwpA6pw1C4w9bQn9NT0upXZPBfqfAsxZYUZDbbz8Tv35NJzR/YFKfdZrCwSFNFx2xvXDUVuTPDfPbQcObtndGHt/dcove6zML/Qja5Y5rDM8yqI54mQxWc9MzCLoH77J/KDUHpaDuxFgSwwfGhSOJZeSBSQLa6Ph4fj9p/aFRKPZZeiycIqcl1oCaMm/ZZClEgEdCxy4uvK6G7WLewrVbsfurkI1Qe9DdIDQM8ethp9KxF342JokuIJdnqXpgAow556N8mcIXWeDxH6a1pjt4enL7a4uiyGIGK8NsSMF+akMhk8N1hIbYrtkkvvKpzI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEJzei9EMFRnWEh1RnFOS3Bvb090RWY0Q2lFMDJXTTlieG5HbVpHTDdkR0FT?=
 =?utf-8?B?K2VJcmNkblBSUkhIanE1dXBNQmRtb3djVGlIM3Z5U0FOVjBjN0cxK1NyTVBX?=
 =?utf-8?B?aVZPSWZVQXY1bmpwb2pDOGtvS09kU04wTUVOWVZFdTZhcmNlR25sdGcrckdV?=
 =?utf-8?B?bGRxeHMxcHpWSnF3bkorbnBJQklESHRIcFhudTVpc2FlWjNJVlFUbUxaM2lM?=
 =?utf-8?B?cCtwSDFqK1BUb3dLRnpkZ2hGcUROQ0tKK0JqRURaNWhvbVdBMlErRml6VEN3?=
 =?utf-8?B?d2FOT0ttaC85YzRXWU5zR3hPdUlqS2RaeDlsRm5oQUZZdFBqM1BuOFRRc3Bh?=
 =?utf-8?B?bU9DdHdJR0E1cWE5S0R6a0JBRlZvdW9RZytvSVdpMElCTXBpZTZBaDRvQTY5?=
 =?utf-8?B?bkMwWmkzOTRhUVlmWEJNbjBNU2VoeWJucnB4Sm1vMDF1SUV1OSt6eHlUM0c1?=
 =?utf-8?B?K2ZYWjJaQm1Kc0xKeGcwUGg5TGNmZGx0MU90NmNLYTdTY0hwNWxOcmNEY1Fm?=
 =?utf-8?B?LzJic1hvOTBjb00zZGxCQXRxUTVhV09NaVBDNVJqNzVGK1VwelRMUmh6ajVG?=
 =?utf-8?B?blgzdm9oUHgvUGFBOElUOUpFOWQyNFFuWHNXMy8xMFdRc3Vhd3UzMWZoU1gv?=
 =?utf-8?B?WE1tQzNNTHd0b3kzY20rQkk0cGpWVDJ0UlR0UmQxZGFTb1AyS2E0MHJNZU5Q?=
 =?utf-8?B?WlkxR2NHaGxOWGg3RzcrbVdMOXBDNzJDY2Jpa0hYOXhvNHljbmRrd09SOGdX?=
 =?utf-8?B?bEN0ZkdadHZZc1hVb0daNlNBNTZvSWJGMkl0V29uNGtRRmtFN2VnNWs2VjJ1?=
 =?utf-8?B?M1NwSVIrdDBXZ0dJRmNpWUtnTjYyR2p2WnpQRENyTUJjVlNGMlladktzVnZZ?=
 =?utf-8?B?OWJWYTZVeVNmZURlcFh5a2pEdVRRUzNUSVRNUjdVRi82TElNMnBSQWd5Rnds?=
 =?utf-8?B?L1JjaGs2eEttRGRSZ1pKWHF1S05lMmRybzFVZlR3dDBCNlZlRDdWTmxSUXMr?=
 =?utf-8?B?SEo3d01pdVRhY3hyR2xMdkMzSkNrMExzVFV4ZS9ud1MvZWpoYitZR0puZklw?=
 =?utf-8?B?NlJFcWt6bmxMU0ltYVpJSDllU21qRUFyOEtqMGNIM2d0aW5pQ1RKMndPZWFo?=
 =?utf-8?B?VmN6MnlFQzBvMWh3TmFFQkROSGZnTzNJVHA4dGtLR05PMHVRR0lFNjROSjdV?=
 =?utf-8?B?Yy9HbENXNzFMaXlBVFNGcC9Ja0g2OWZ0cVp2RmduWVUrNW9rd2ZueEtNWVVx?=
 =?utf-8?B?OG1oNEpPNElUMm5kd1BLQTE2QlcrSzF2U0wvUzJvMmlDMVRwRllIZnNwSkVy?=
 =?utf-8?B?cFFqVC9NVkcyNFVJN2FCVm56ZUxtK3poNi9ESnhpbWZGakNJN1JNYzZCNG1C?=
 =?utf-8?B?WXE4NklDSjBQWkdhOWZ3d3dTRWQrcjF0S1ZuRnVjSVRBODZDWmhvazg4MkIr?=
 =?utf-8?B?bVdEYmoxWFFPY3RIU3pxZWZVd3IwVUtWNDgrL1pYVnVUU0h0cG1CbTRPbWsz?=
 =?utf-8?B?V2JVVVMrMmhkaUR6L2x4aERNaHg2ejZjWTM3MS9nMm4xZ0hVQ1lYdTFvZnZC?=
 =?utf-8?B?S0tvMVVud2lDaWhncDZRZjVvV3hORjdtOFV5TTZ5KzhVTXBuMTR4dnNDN1dW?=
 =?utf-8?B?VU9NUzE5VHB5MDROYnB0NTBLREsraUdYcHkrbTRBMzRNS3JxenEwNkoyOTVB?=
 =?utf-8?B?WGRKUEJHRGZqZ1BZd0V5aTV5OTNmSDlFWUlrSVpQdENrblNNL01JVXU3TDZ0?=
 =?utf-8?B?cUQzTWlGQXVRV210SlpTNmI2UTcvVTkyMklvQ3M5Y0NCenBsdjhjd2JnRUNk?=
 =?utf-8?B?cGY2dUdkMC9CRnBTN0xUdExRdnpoVFRJT3JQcW5rTjQ2cEcyZmZnQUg2Z3VQ?=
 =?utf-8?B?dFFBVlRKZ3VianhqdDhoTjlQWGdXMWpIUUM2ZmczeVpvT0hLeWJ3MlJqRVZE?=
 =?utf-8?B?NEwrZERFekxGMTk5eTZDb3pubTFJZy9UUWNpOVNKT0x4Z2RRdVZvTHZTbEUw?=
 =?utf-8?B?Mlk3Z0JqMTRlSHg5WTUzTWlIS0JPd0ZOTllYcmVwUFJMLzZFY3lEN3ZWMk9T?=
 =?utf-8?B?YjNuL1Y1Z0xJZFFDbkhzUEJzMGM3a3A0eWRKVS80K25DN0VnWWsxQUJLbHZ1?=
 =?utf-8?Q?aCMtespUQ4HJiNifsWpBv8YXT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa5fbca-6228-4e55-dea7-08dc53230815
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:41:50.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioCBc+BnFHZtMGjgdr+n+erv08lViu3KVSl0kqUNW3CpMkawyqSX5f+vWGCDzAKZUh+4XLXgP+gvA3Nzg1urIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

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
index 84d7ae01e5f40..92752c0c5eb5b 100644
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


