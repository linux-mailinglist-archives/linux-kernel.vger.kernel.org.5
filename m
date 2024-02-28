Return-Path: <linux-kernel+bounces-85580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25E286B7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4965C1F2734A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877C915F304;
	Wed, 28 Feb 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ETxHnBV3"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC374415;
	Wed, 28 Feb 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147694; cv=fail; b=BZkJ1Lfvssdr+0H89WcyXKZY9RV5JQMKARaIe8LlMxADz4xFoHI8o+M3F+odPrKhpKe9BZPOvMJdLwkS3drYoSnftuR7FJMYN1cAMx6FYFbZ9WOwcGuq5vO+/1szDMgBZtfyhvxuiH+4DQCOgMnQXFXEJ8HrheAoXsZ2YWka+8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147694; c=relaxed/simple;
	bh=scx2tJGGMPCuV31oHuIscaL9iO3JoVAe7DIQfQq/hnM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=drg3W9N4Lgpew78UqFQgy1/aNZH0Nvv2j1BPpkV9QjwvzOBcozAqOlv0QhpstwI9+oW7379BYQQ5Oir1P1BOVa09W1/S2SOHZAvO7qqCFHL2YsFXTcaE3xuLV70gVGXmW09xVyirPZGTDFDlhnk9tMaQBPelYD3xTbnLxyNVM+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ETxHnBV3; arc=fail smtp.client-ip=40.107.13.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmcyLLVikJdftgdSnKVaY70CtGA8GAiMIzsB6zeyFAGjvjd/8b1lxeSydBLxyP9eS1/Tx/pVhJLZqJ8WTc9MzIXh5vD56hsIfcTOS6YQvbmak473OTFsqaH5fiSqzKxl5CvOt2nw2xIk8pL4EXzEnZ4Qh4StDOfSMFTSu6jaWMfnnAKMzXevk3reKmsz/0dndwWH+gcQqwxNOR33bNoZMKO83lodsIPOjlZm5V0tO+vJc6RCwRuSYf2KUxrfgT5IpVVeVMFOTT2xDQH1pI8Y69usXSuse7RYysBo6rraGTYtQtPGjP8DZGnIstKYmH65zS/MKkyVX/s739MLms6BGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PZ5N9gHK+DW2QnqzPlUHbIbh+Ah3oD1V2TcxCSFXQE=;
 b=mc80zldJTs7FvoqOXCwLWZyv0ww0T7ZkqxQHoMVr/2wTJcnuHjfU+Ij+NZF5hpdSYTtHUOx2eD5f63VSe0T4+kTRWjQwMYuM6uE9ILcaY48TtFDuA6JVf5N5uhOwWLrQ08M81YRqu16PJMpNyQ3C2HOf81w79nl0ALzsj6/w+HXfcdvbh8OQoO1L7YUiJlYgv2vEbd0L5Jog7VqKLDlcQ7DCCyxAobyLDbAwVVeXuOLegSTVdn1xY9JDPzPZXnPeAa8P2tZMazJSqd8fc2GMpwu9U/AUDb1eDJHeCF9Jgnx1jckj+DlCqQxIAV6AFV4E7IjOwEYqC4fXFGJE/lHnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PZ5N9gHK+DW2QnqzPlUHbIbh+Ah3oD1V2TcxCSFXQE=;
 b=ETxHnBV3W52mH8X6RW+d9ylK49SJ8xf0wukiw8uNF2EP2GsoJzN3pBjHb+35IX7i37DmnAF4ew882IuNpYSLZcOj+SkpEg3pASPmWQwBdI0qbguEIhoY2cr+01ZKfcpjJ/pyrLTGAiCEcfdBw5PBTJ9MxydK7FRSzLXq6eeum4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8887.eurprd04.prod.outlook.com (2603:10a6:10:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 19:14:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:14:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Feb 2024 14:14:16 -0500
Subject: [PATCH v3 4/4] arm64: dts: imx8qxp: add asrc[0,1], esai0,
 spdif[0,1] and sai[4,5]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-asrc_8qxp-v3-4-d4d5935fd3aa@nxp.com>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
In-Reply-To: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709147666; l=10528;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=scx2tJGGMPCuV31oHuIscaL9iO3JoVAe7DIQfQq/hnM=;
 b=sHU+x1Vg5EFj8r6rels9h2fP8VCNCl0RVCmAWWhe15WTPYGuZcRWtjQzzMwsoQHcm467UFzDC
 iSEc7thAUecDro5J+Io7rZbQeD3wnRlHoTAXGcAuFoiQ+n4PcoT1ZXm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd53318-9b33-4dc8-2a9c-08dc38918656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UqpV8YPrWWehn1Fsaa3j1Yft2i7p6jSwMoLxxbpA6y5ToHdb5W6ZKqggu1Nzyrghwa8H13lanKfjXk/v1Qjr9vCPmPR9LR0v4v8fAuQeX2I6WPILyHJAw03Xegb/3f8S0d1kuUBYY//gLhCzZIFwihzeboHubsVF5IDjfBHod1KyCCfEs3ymBix00aF2ODfBJ5pKlirW22S+4TLJwrdnjzK1hr+BAqvOj2Pxu7+rqifmolWHBgQS0d9BGZ3AWM6LldezieOqi3sMpgFMWiZqIp4crfCfv8V3WBWgK+AzTIjlwr3Q/zpNz3gn/3U8bpKno6n/dcO85csuqoQ45TatdbAY+G2zUtPEan7psYb13CyVFVFayC1TajpxobZjiO/YsjSv5e5YdJcoc5+Px5B8NCsSBS6haGoZdbqy8ibFOp4xC5XAXxCJZmYhsx4hbIto9GfEXQGQ31qqLj9SmByhjjlaQDKGawgfjKrd0CwIkElxcmuJBoX/JViMIY5WFcA6k+oZ+JrSYk2sL9IiyvHZkKjuT6LL3Gjr7TP336sbvXtsGnVu8C9gpqjbgopkWF4kYWkdduFINmufRjWlmnAjAAumkdhS0KjO12h0iZ8N6+dEE963QNA/zcUgUxpYrSD5C2Hu1JT/JyEtZQppCkAT4qbP5N465QwhDeaH5JW+91z/6Y8JYny8du4OoncBfCTEgtEoulluxAUgEmuNf0qa6bW68+uCsVSi6zL7pBx8geY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym5ob2VRbWxkMURZNFdnOXAvKy9KbVAxYm5WQnRCeFB6Y05rOGI3U0laSTBB?=
 =?utf-8?B?WEVESUtRY1FEeWRlVkdlTzJ3MTRzYXlmcW5PeGpwUWlFOFdGSVIrQzJGS1Ri?=
 =?utf-8?B?V0FpWGpWOVZXajNWeDkxU0x4RHBGWEJhM0F1M253azB4TFBqbFhudzhzUnZX?=
 =?utf-8?B?aW45dk5MNWtpdXcybXkzWEVPeitwTzZuQ012eTd4QmlyaUhTRzFqZ2xFWmFx?=
 =?utf-8?B?OGJtV0lMVk9oNGlTSXdHRzUwL1Y3SlladmdkeFE2SkZKUDJ3RzdmOGpERVVF?=
 =?utf-8?B?OVh0ckRrYjBwdS9XbE43VXQ0Sk9vYTlBdm8vNitPV2lHWkVvV2YyQlZmWXRk?=
 =?utf-8?B?emlBT2ZNSnpWWEFUSkk4Y0YvaTF4dzkrZ2d1dVJDVkxRSjZEbG5ObXpDTmtj?=
 =?utf-8?B?SVVtei9GelRhQjFZUk1LeUhHdDRrQTZhZHpSQS9LN3B1ZmxTdnJzSEY4MmVN?=
 =?utf-8?B?VDJUZ05lVUVHeHdtWVA3c1VuWUMrdlpTUzF2STRIWmVYUVFSK1JjUTNCTnFk?=
 =?utf-8?B?T3pKZVZHdDZkU0lTR0RWdEpDcHovWHB6alVvQ29DTkljd2NvMFJPZjc5cG9w?=
 =?utf-8?B?WEViYmZNY3hqYS9BckhDTTczNWhqM3V6aFhKb0dUcTFnY0MzbkxNMngzTjBD?=
 =?utf-8?B?NE1PSE8vNVJqYzc3UkdFc3JLNW82YkdDRXYrTUdUV0J1OTN6WnkyTXlFbFV6?=
 =?utf-8?B?SkRVMVZRS3J1UVo1QzBNVVc4bjVKOG95Vk9SZ2g2OTdpTlJsWXJGVkptUDkw?=
 =?utf-8?B?Q0p6ckFPRXdMQ2drMHdDRnBQSGFjV3RXYzMvb0xuVnVwRklxVUx4c2xnbS8z?=
 =?utf-8?B?THlMbVF1UDR1a2psMlBDWFpoQ2p2NDBTMXBhZVNaendYaCtTckZsTFAwdDZW?=
 =?utf-8?B?dElRTkRWVXBtTzlrR3FXYnQ1UFFSQ2pzSmpPWW5xejJ3UzFMcjdDR3NDSTFk?=
 =?utf-8?B?b09aR0VHenF0N2pRWVRhcXdKVm1xVDg3TElKOUw2YVdTQnpRT2d0dTl0dFlo?=
 =?utf-8?B?S2pweXBEYUx4Q2dEejZ2dnkxR2wwOWVDRXRMMExYa3dydEFjbElVZXhQVllM?=
 =?utf-8?B?ai8yYlNydkMrVW1NdjJxVDRaRlhpa0tvN0R6NThraUFPQk5qdDF2amJBM2NG?=
 =?utf-8?B?c1NDbXdWN1BVaWlMZzdxT0VQbUEvL3BMcUx0MWNRSVo0dWlmZzkvK0NEYmJV?=
 =?utf-8?B?YjRRTXMyOHdVbnpGOFVyTTN2cXNWYkhJMXJQVDV3Zit4OEYvSVN3VEZ3Wkpq?=
 =?utf-8?B?S1YrZktLbU5aRmk3NzhKdFVsUkV4d2ZPMjhJRkFralRkMEkvdzBOanpFcC8v?=
 =?utf-8?B?Wlh4Ym5KZTViMUpEYWMxaVFxcFJvR3VHQTlqd0NsY0FsTmkrUVAybXJoeTFP?=
 =?utf-8?B?cGJjd2lzUmpQT0VjcWVxU25uTGNieE05Ni81U1JEd29Xa3RiMDlHMm91NzV0?=
 =?utf-8?B?WWgxaVJrWDF4OXFXOTBsaCtwdHJlR2xTQ09qWWNQd2R6OThGZTUzdGJsSkF1?=
 =?utf-8?B?ay8wUmJ4eWFFd1lpbVFQR3FiNFYyS0NOT3FGeHNYNTBYalBTNmo0cmhlNlE1?=
 =?utf-8?B?Tjhhai8yMDhGcVBycTRiL2J4MDZMQ2Mzd1hyRFkwa1htdTVHT0hGb2lia1Rl?=
 =?utf-8?B?Yjc3TC9JOERZYkZaTktqRzhDM0xSSG5wcmRTOFpsandrT1dOMWxFUDlnN0JN?=
 =?utf-8?B?RGtOWVRkTHJFTXpJdGlvMVppd2NEdmVaekltbFdyVEtZZmxOS21ZajB2ekR3?=
 =?utf-8?B?Mkt3N1gxb1FKTXgrZEtLRnRpZ2JSb2Qrbm5IT0FERWRvRktzOWQ2bVpjZHo1?=
 =?utf-8?B?ZFhDZlRCY1AvOCt6YW1LZ1BaZUV6dnFnYVozRHFsU0dvNTRlS3Jja1BNUFp3?=
 =?utf-8?B?RWFrdWRRSDhGRGt0RTJPRXFnMHA4K2dEdmRlZEtKQ0hZNzdXaGo1SytwN2x0?=
 =?utf-8?B?M01vcm9tNGxsS3Rsb3R0REFTd1VRQ2hxMVI0OGhUSUNDRkpNcGhzVlZPRzgv?=
 =?utf-8?B?UExhK0drRXp6THhCU2VCMUFld2syeXdUaXhoMkwzcGtkYVVtK1duQ1dwUU9K?=
 =?utf-8?B?NEkzZWxhcVkwL1FQZ2lqa3BWS3dHT3hqRTYxbmkyRlhGaFRSczNxTTYySjBE?=
 =?utf-8?Q?6bqt/0FOWRXNNen+dWlO/QM0l?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd53318-9b33-4dc8-2a9c-08dc38918656
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:14:45.5890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FumNqSaGQr4ynfRbuZqgb1yEeQA7KwwoRwJVHejAXKjVfKRWu1wxw/P0BJkm4rUDwiXTO7j7UDVUComjMKU+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8887

Add asrc[0,1], esai0, spdif[0,1], sai[4,5] and related lpcg node for
imx8 audio subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 304 +++++++++++++++++++++++
 1 file changed, 304 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 07afeb78ed564..78305559f15c9 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
 audio_ipg_clk: clock-audio-ipg {
@@ -481,4 +482,307 @@ acm: acm@59e00000 {
 			      "sai3_rx_bclk",
 			      "sai4_rx_bclk";
 	};
+
+	asrc0: asrc@59000000 {
+		compatible = "fsl,imx8qm-asrc";
+		reg = <0x59000000 0x10000>;
+		interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&asrc0_lpcg 0>,
+			 <&asrc0_lpcg 0>,
+			 <&aud_pll_div0_lpcg 0>,
+			 <&aud_pll_div1_lpcg 0>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "mem", "ipg",
+			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
+			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
+			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
+			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
+			      "spba";
+		dmas = <&edma0 0 0 0>,
+		       <&edma0 1 0 0>,
+		       <&edma0 2 0 0>,
+		       <&edma0 3 0 FSL_EDMA_RX>,
+		       <&edma0 4 0 FSL_EDMA_RX>,
+		       <&edma0 5 0 FSL_EDMA_RX>;
+		/* tx* is output channel of asrc, it is rx channel for eDMA */
+		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
+		fsl,asrc-rate  = <8000>;
+		fsl,asrc-width = <16>;
+		fsl,asrc-clk-map = <0>;
+		power-domains = <&pd IMX_SC_R_ASRC_0>;
+		status = "disabled";
+	};
+
+	esai0: esai@59010000 {
+		compatible = "fsl,imx8qm-esai", "fsl,imx6ull-esai";
+		reg = <0x59010000 0x10000>;
+		interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&esai0_lpcg 1>, <&esai0_lpcg 0>, <&esai0_lpcg 1>, <&clk_dummy>;
+		clock-names = "core", "extal", "fsys", "spba";
+		dmas = <&edma0 6 0 FSL_EDMA_RX>, <&edma0 7 0 0>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_ESAI_0>;
+		status = "disabled";
+	};
+
+	spdif0: spdif@59020000 {
+		compatible = "fsl,imx8qm-spdif";
+		reg = <0x59020000 0x10000>;
+		interrupts =  <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+			      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+		clocks = <&spdif0_lpcg 1>,	/* core */
+			 <&clk_dummy>,		/* rxtx0 */
+			 <&spdif0_lpcg 0>,	/* rxtx1 */
+			 <&clk_dummy>,		/* rxtx2 */
+			 <&clk_dummy>,		/* rxtx3 */
+			 <&clk_dummy>,		/* rxtx4 */
+			 <&audio_ipg_clk>,	/* rxtx5 */
+			 <&clk_dummy>,		/* rxtx6 */
+			 <&clk_dummy>,		/* rxtx7 */
+			 <&clk_dummy>;		/* spba */
+		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
+			      "rxtx5", "rxtx6", "rxtx7", "spba";
+		dmas = <&edma0 8 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
+		       <&edma0 9 0 FSL_EDMA_MULTI_FIFO>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_SPDIF_0>;
+		status = "disabled";
+	};
+
+	spdif1: spdif@59030000 {
+		compatible = "fsl,imx8qm-spdif";
+		reg = <0x59030000 0x10000>;
+		interrupts =  <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+			      <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+		clocks = <&spdif1_lpcg 1>,	/* core */
+			 <&clk_dummy>,		/* rxtx0 */
+			 <&spdif1_lpcg 0>,	/* rxtx1 */
+			 <&clk_dummy>,		/* rxtx2 */
+			 <&clk_dummy>,		/* rxtx3 */
+			 <&clk_dummy>,		/* rxtx4 */
+			 <&audio_ipg_clk>,	/* rxtx5 */
+			 <&clk_dummy>,		/* rxtx6 */
+			 <&clk_dummy>,		/* rxtx7 */
+			 <&clk_dummy>;		/* spba */
+		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
+			      "rxtx5", "rxtx6", "rxtx7", "spba";
+		dmas = <&edma0 10 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
+		       <&edma0 11 0 FSL_EDMA_MULTI_FIFO>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_SPDIF_1>;
+		status = "disabled";
+	};
+
+	asrc1: asrc@59800000 {
+		compatible = "fsl,imx8qm-asrc";
+		reg = <0x59800000 0x10000>;
+		interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&asrc1_lpcg 0>,
+			 <&asrc1_lpcg 0>,
+			 <&aud_pll_div0_lpcg 0>,
+			 <&aud_pll_div1_lpcg 0>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "mem", "ipg",
+			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
+			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
+			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
+			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
+			      "spba";
+		dmas = <&edma1 0 0 0>,
+		       <&edma1 1 0 0>,
+		       <&edma1 2 0 0>,
+		       <&edma1 3 0 FSL_EDMA_RX>,
+		       <&edma1 4 0 FSL_EDMA_RX>,
+		       <&edma1 5 0 FSL_EDMA_RX>;
+		/* tx* is output channel of asrc, it is rx channel for eDMA */
+		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
+		fsl,asrc-rate  = <8000>;
+		fsl,asrc-width = <16>;
+		fsl,asrc-clk-map = <1>;
+		power-domains = <&pd IMX_SC_R_ASRC_1>;
+		status = "disabled";
+	};
+
+	sai4: sai@59820000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59820000 0x10000>;
+		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai4_lpcg 1>,
+			 <&clk_dummy>,
+			 <&sai4_lpcg 0>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dmas = <&edma1 8 0 FSL_EDMA_RX>, <&edma1 9 0 0>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+		status = "disabled";
+	};
+
+	sai5: sai@59830000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59830000 0x10000>;
+		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai5_lpcg 1>,
+			 <&clk_dummy>,
+			 <&sai5_lpcg 0>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dmas = <&edma1 10 0 0>;
+		dma-names = "tx";
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+		status = "disabled";
+	};
+
+	amix: amix@59840000 {
+		compatible = "fsl,imx8qm-audmix";
+		reg = <0x59840000 0x10000>;
+		clocks = <&amix_lpcg 0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_AMIX>;
+		dais = <&sai4>, <&sai5>;
+		status = "disabled";
+	};
+
+	mqs: mqs@59850000 {
+		compatible = "fsl,imx8qm-mqs";
+		reg = <0x59850000 0x10000>;
+		clocks = <&mqs0_lpcg 0>,
+			<&mqs0_lpcg 1>;
+		clock-names = "mclk", "core";
+		power-domains = <&pd IMX_SC_R_MQS_0>;
+		status = "disabled";
+	};
+
+	asrc0_lpcg: clock-controller@59400000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59400000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "asrc0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ASRC_0>;
+	};
+
+	esai0_lpcg: clock-controller@59410000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59410000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "esai0_lpcg_extal_clk",
+				     "esai0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ESAI_0>;
+	};
+
+	spdif0_lpcg: clock-controller@59420000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59420000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spdif0_lpcg_tx_clk",
+				     "spdif0_lpcg_gclkw";
+		power-domains = <&pd IMX_SC_R_SPDIF_0>;
+	};
+
+	spdif1_lpcg: clock-controller@59430000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59430000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spdif1_lpcg_tx_clk",
+				     "spdif1_lpcg_gclkw";
+		power-domains = <&pd IMX_SC_R_SPDIF_1>;
+		status = "disabled";
+	};
+
+	asrc1_lpcg: clock-controller@59c00000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c00000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "asrc1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ASRC_1>;
+	};
+
+	sai4_lpcg: clock-controller@59c20000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "sai4_lpcg_mclk",
+				     "sai4_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+	};
+
+	sai5_lpcg: clock-controller@59c30000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "sai5_lpcg_mclk",
+				     "sai5_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+	};
+
+	amix_lpcg: clock-controller@59c40000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c40000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "amix_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_AMIX>;
+	};
+
+	mqs0_lpcg: clock-controller@59c50000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c50000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_MQS_TX_CLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "mqs0_lpcg_mclk",
+				     "mqs0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MQS_0>;
+	};
 };

-- 
2.34.1


