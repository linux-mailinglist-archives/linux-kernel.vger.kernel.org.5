Return-Path: <linux-kernel+bounces-128702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B061F895E61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B8D1C221B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1685815E81E;
	Tue,  2 Apr 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QOqIn5Ig"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2139.outbound.protection.outlook.com [40.107.6.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA815EFD8;
	Tue,  2 Apr 2024 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091821; cv=fail; b=mGDMS/3DsvPZVG5H36Ce5E44mEAi6YCGoVLqV2NK5yGDE6EP9owdiWxt+/saU+xcYyxHdbb4Jql5JX956aAJPYdYgAp1Wxix94vZn4DmElP+fJZhEvmfjPROcoYnne8p2KFwrhwf78EHS0pg9PKLbI1KW2Bv9IgqHV/viZHU8Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091821; c=relaxed/simple;
	bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Bi57BqleddGB4nhD2CxA9YjvqIWS6eOWX2tkqy3y+PwdiNoJ4Cz+HLZDG/7C2KXf4Txc78tUb1R60t3yk2zMtKDpHCK4j4f+ni5PVW9ESDOxdp0XfgexP8ymYaFkTPjpwP3v+bLh9s2rUKc2k9XuVZ02X6sEHoiFv93mXkVS3fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QOqIn5Ig; arc=fail smtp.client-ip=40.107.6.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttygt79ppLIUWNB3Nm+mSJf2UAbXNVMdRXLCIi83UXlNEMB9bQdV32/BIWo2C6disDJfk0bMeYifV8DJDFS/BsfXjOMe8cVw0SaYOUAVpsepA4GrCDulHh8azCckQRT8aHKayA0yS2hOv+lfPrE125uKObV3rGjoWrhfq5m24WVk4+W4QQJl4pWabKlEOssg9pMG8EkZTO2JCKg9rduKYmi0CZSOP2cQKXXYiFvjsuS0aQ5dztWjEhpwCKT9ngO8a9vfc5R5n0G5uCK+FDFF2TLLoTqa3HN7Hra8TfuUEt8/Ktd/DXL3pafDWIODVMr+gc3ls9eFmjiPHXyskuT/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=R92ltnm7WMgnygD6Rr6rHv1j5zWNTOjEyF4OTYc2Mryc9v6+6k7gqo5Hh864/mqeWWD7EBPntaoyZKAp9ykA+AP4uYrSVv8nA21amvsRJmwLYhRS9At6B4Kgiot2WokLAl+K0m/C+vxPM0HX33hzZ9vDrvhZ44V9X1hbDEkA2psljF3jgTowhKJ1neodxKeoOT8ElrVfXqqhJhWKYH4192bnzzWtvYS0xYU3wvDglm3g4+SUZbwHz6s3uLk259BSvO0C3xoM8bAzKJurJWBXc5f35rAU5+MSWQhrbu/PdRyd+XXggNQ5nqHrxOWuOSmb/C9dkdoaOVjgt7gbYFrVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=QOqIn5IgKD+rAwnfVPYuOOxIGK/hXOlFxo+nWQUj7lioT2xULMoFMKbY5aLSl1Hpl0QflYcvQWmNnU3bdgYpNL4une8Dv0Gcf940j1JRddM9qRZqGC5bTqmmQNM8GqIBEjI35R5nJqg0fJCD1dZdaoTZ8KiQLwWxKt45G7T2kFA=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 21:03:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 21:03:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 17:02:29 -0400
Subject: [PATCH 2/3] arm64: dts: imx8dxl-ss-adma: update audio node power
 domains and IRQ number
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-b4-dts_dxl_audio-v1-2-d26d25b84a08@nxp.com>
References: <20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com>
In-Reply-To: <20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712091807; l=2570;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
 b=nEvg6EbzubYyEq4TseSGueKcQqnCx9DtFGVvXc4aMlKeIprMkXWNaUn044g++0PLwVzZ9lcBq
 RXrJ9iDtKwuDbx6gj9sePOS1XazX6LfRfKVW4DzFR9NKJwUok8K9gPU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8648:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SFcMpbf/tcozAaukhOwjNYX7b/f43Z2JHYamto+KoGtAGtgFBXhkedBvy3rrdK2WHTuBlEG01QyrHslNPKMkmmso5J4UJle9VlcS1diTnehVHp/w3kLcL4fpFqqBQBTfbnU+dfwm25LFVOV9fOJUxRsgkIIJ+lZA8HQwKsmWvxKvtco7C3ZcqpayIkhV9Z3cRHoGP1EaX6ha189SIweCR/JjgGtxguT0Pyv0T8Ju0WRxo6fa+r4ay2O63uWLwcyfAOLhWvWJa+YO2Yq5gCBEjupkymKRCznhYMtpWd7O5pRMCR7uXTsCE55SyWtQlHh+D9hiUPvjKXL0Y6UMz2pP04JowefAlR8F1PS6t0gUM5TS5X5Bna7UgqSk7BTKKQrWRC57R6zwal8du+M8UeinLRAW2YJIes8UWppAy15FWbiLtHng/gvOLNhK2quo7svBUFnbWB/iRE/+iK90q0rRUE12BrP8WKjxRACiekZ7oPqH74fDBywQykrDVJpoJapePXDnHw1LDdEKD3dlmYwELiVAKrc7vcv8SujLsImMmjE53Fv0VM0m68SjnFkf2kuA9CrkUP5/xhi7iOsNopyiOu5eY86h19cPMoITrqMysqtNX4vg8VzMqq+TFYG6ywlxVg0PEqW4Gi/MV+BjH5yirIljnl4Lq3cPMPHgmY7Bt/if5x6uNGwopn5DhfDrxXSqTO3iTNuvVgn/IWkTZVy8Yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzBIYm85WFZ2a3FST1Y0UWhHZENTSm5UbDBPZlROVkUvYmVpaDhPMmlWM0dy?=
 =?utf-8?B?Z1ZXdjUzU2plRUtFM3RtSGtRVEZHVTZNdDZFQmtweGhBWklxVktxUzRPNzRt?=
 =?utf-8?B?bGpmN0dGMktPMFRXR0YxRWE3YVQwK3RPZjhET3V0OGNWc09EOElCSmtDNDJ2?=
 =?utf-8?B?bFNpTHNOdmhtaFAvR3JoTEp0czRoRm5wMnBUNWluMno1Ty9ZY29vSlRBRmQy?=
 =?utf-8?B?WWlGYkFsbU9JQVpNd2tnOEJyclBweER0WVRBMjhib0lQRFM5OW1VaGZmbW9m?=
 =?utf-8?B?bXI4VVJTNFJvWDBEMFpXdW9FVGRUVThYY2dhM0NBVnBrdXhhU2VNQVBlRnZJ?=
 =?utf-8?B?dmpTUjBLTG43UVRPR0g4aVF3UE01V2ZTYWRsMVRhd1d4enZlbjZFL1A0SmJL?=
 =?utf-8?B?YnFSbTBrQVFUUi9VN0I1dVE3VkRzVGtZeFFwbExaYjB5L1Z6QVhMVjhxNU56?=
 =?utf-8?B?eXEwTjg3b0RKOTVueTBpaElCdytkdnR2bDJhTUtYQW1ibXZGb3o0dm40ejZt?=
 =?utf-8?B?dTM0eVhDY3F4OUtWWGVVdmwxT0I5MVg4SmlVSHN6NFZnRitJQlR3NGFZbnVX?=
 =?utf-8?B?ZHYxL0R5S0hnMnR0VTZ0VGU4VU1ybTlLdmE4c0djQ0x6eTFWK2tBWmR1YUI1?=
 =?utf-8?B?dTArbHJnUXprR2ZCMCtWLzNQTlpkd3p5dThjeEZ0QmNoMmJ3TWxLZGhSd0pT?=
 =?utf-8?B?c1pUemZsaFZ5bGpTNm54b1U4SE1CY0lOZ1hRbktKK1pLK3FRR1ZkSmk1REJk?=
 =?utf-8?B?dVhUUWVqM2NtT0ZMcE02OTNwU2VrRHY4Z2ZsQ0s3a1ZDaURMYXlobGcyYTdM?=
 =?utf-8?B?Z0tjcVYxZXlOMlZXL0FVU3ZzWmQvVFpSZGJBc0lhRUVoTkluaEYzOXBWdnpH?=
 =?utf-8?B?QUlVT1hsOGlHbHBGZ25XZy8zZnphZCs5c2h5NlBVS1FPR21YT0FBVXgvWkZE?=
 =?utf-8?B?OThhWUVMMkRGelk2bDZzNkNsMXZ4Q2V6Tyt6WFVOMmZOVzlDZlQzS1h3SU0v?=
 =?utf-8?B?Yi9qTTRtZDlXTzFVZnZGY1BLcHJaaXhGWC9aODVlMnBvcUdpdjZDS2gwdCtn?=
 =?utf-8?B?TVQ1TkdBRFRRaVdWRnAxOHJHcFRZVFdLWUJYdkVoZDlQd0I3WjRvZEhQeWxD?=
 =?utf-8?B?WlZFTjZQdW85aFh1SG1LZWN6VDdIT3dnTWxhMERwdVZtNnRobEMrckdnNUZB?=
 =?utf-8?B?Ny94RnUyTDBuQXR5T3ljTkpMNUNYbmhySHFXUHR2OHN1N3dDbjljTEVBM1c1?=
 =?utf-8?B?ZGdEOUovQzYvZSsyWDBOYzh5ckxrM1Q4MWZmSlhVa0ZnKzAvMGdQMkJIOVZ2?=
 =?utf-8?B?KzdrdlNUa1hkQmRleldnaFhFUG1reDRHckNZbm1VbmFsU1VvNG1aMFVYVEFq?=
 =?utf-8?B?V1RmdDlEa252aHE1aU1yanVnZFdOOUNmK0VIaVlYc0RjNWJEbVRjcFg5YUdm?=
 =?utf-8?B?dXlTQ05GYXdoS0RpODVIYU5HRVJnMVdJb2dhcDhpM1R1Qmt4ZHp1OGtNZXdu?=
 =?utf-8?B?bjM4KzN6dTVVeW9vOFpDNDNPa251WnptOENqNTdIZGVnSHQ5ZWM5U1d2UGwz?=
 =?utf-8?B?bFp5aUFGVFBrYjU3aVd2Z2Vhdms1ZitVY1VaUTd0ZkFsTllwK2Y1elM0Y01U?=
 =?utf-8?B?RnE1QUVTamowRGhJVVd3eThXZE12eXN1STAzMnR4ME9JM3FJUitaZDRGb21J?=
 =?utf-8?B?SXQrT1Z1cWJsbmU0ZExGZ0VRc2FqOTNlWTlpbzFkQ0JSSFNkNitFci9EUVR3?=
 =?utf-8?B?ci9YOHp3TVBEaEE2ZlV5SUZaZGp2K2thNmM2NnB0N1FWRzg3T09OaG40VnVW?=
 =?utf-8?B?WFNWQjNQb3RIc1hzTzFGcWRHRDJqY0JuQndvcW5TdTZFbzV0MFY0ekYwWkZ2?=
 =?utf-8?B?dHh3RFJhK0hVb2M1UlB2cWQ2YmNIaEF5SFNzSWRtR0pPeG1OaFNQa1FBSm1E?=
 =?utf-8?B?SXMzL0RKTlhOcHhPMit4d3FNbkgrNTVaUjNIZEZCZFBxb2JaY0JObThwYnVx?=
 =?utf-8?B?Zk5Ud3A4Q2dzVXI5VWdsdGhUbEh2YWpoUEgwSEs1cllIZ0cwa2o3Y08yU0hv?=
 =?utf-8?B?UDNUSzBqN2NaNHBreVd2TDZxYmZvZHdxenpKcVZqcjJLM2MxNmFicUlNMnE5?=
 =?utf-8?Q?kTegWC9DMHJkP5/72EwedZqtF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e08fd7a-3aa5-47d3-0c22-08dc53585d2c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:03:36.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMwsr9akROmYB65VQQLgNkkSclM1oca8TRA1ZNsQxOrDYut5g+w7nlahkXXpiknmlwQv/1CQxfxQA3aPxgUIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648

The power domains of i.MX8DXL's acm is difference i.MX8QXP. IRQ number of
sai[0..3] and spdif0 are also difference.

Update power domains information for i.MX8DXL.

Update sai[0..3] and spdif0's IRQ number for i.MX8DXL.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index f5dcdd9405928..72434529f78e6 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -17,6 +17,49 @@
 /delete-node/ &sai5;
 /delete-node/ &sai5_lpcg;
 
+&acm {
+	compatible = "fsl,imx8dxl-acm";
+	power-domains = <&pd IMX_SC_R_AUDIO_CLK_0>,
+			<&pd IMX_SC_R_AUDIO_CLK_1>,
+			<&pd IMX_SC_R_MCLK_OUT_0>,
+			<&pd IMX_SC_R_MCLK_OUT_1>,
+			<&pd IMX_SC_R_AUDIO_PLL_0>,
+			<&pd IMX_SC_R_AUDIO_PLL_1>,
+			<&pd IMX_SC_R_ASRC_0>,
+			<&pd IMX_SC_R_SAI_0>,
+			<&pd IMX_SC_R_SAI_1>,
+			<&pd IMX_SC_R_SAI_2>,
+			<&pd IMX_SC_R_SAI_3>,
+			<&pd IMX_SC_R_SPDIF_0>,
+			<&pd IMX_SC_R_MQS_0>;
+	clocks = <&aud_rec0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_rec1_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_ext_aud_mclk0>,
+		 <&clk_ext_aud_mclk1>,
+		 <&clk_spdif0_rx>,
+		 <&clk_sai0_rx_bclk>,
+		 <&clk_sai0_tx_bclk>,
+		 <&clk_sai1_rx_bclk>,
+		 <&clk_sai1_tx_bclk>,
+		 <&clk_sai2_rx_bclk>,
+		 <&clk_sai3_rx_bclk>;
+	clock-names = "aud_rec_clk0_lpcg_clk",
+		      "aud_rec_clk1_lpcg_clk",
+		      "aud_pll_div_clk0_lpcg_clk",
+		      "aud_pll_div_clk1_lpcg_clk",
+		      "ext_aud_mclk0",
+		      "ext_aud_mclk1",
+		      "spdif0_rx",
+		      "sai0_rx_bclk",
+		      "sai0_tx_bclk",
+		      "sai1_rx_bclk",
+		      "sai1_tx_bclk",
+		      "sai2_rx_bclk",
+		      "sai3_rx_bclk";
+};
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };
@@ -191,3 +234,24 @@ &lpspi2 {
 &lpspi3 {
 	interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&sai0 {
+	interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai1 {
+	interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai2 {
+	interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai3 {
+	interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&spdif0 {
+	interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+		     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+};

-- 
2.34.1


