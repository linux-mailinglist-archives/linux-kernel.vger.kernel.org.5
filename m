Return-Path: <linux-kernel+bounces-82230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4351D8680E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186F2B22C71
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFA712F583;
	Mon, 26 Feb 2024 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CFklZ269"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96304130ACA;
	Mon, 26 Feb 2024 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975313; cv=fail; b=PavX/gT4Zs7eh1l43nKUvwlMCwIbOv06jD7z8xbVrDdARRfBc4A1U+wfAEApYu4+OFOtMfy2goOppFwwSeJqe3yrjaaTd8xt4Q9K8JcKqZyBep+hM+oLvRSFeArLnpZlQ7M0/CvriJEbLQyd7nQCCTK7nPVG9JpTdgdrlZUwUDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975313; c=relaxed/simple;
	bh=+MURKFlKnb49M6s8cCRZHjmcuQTKUmOaSJ3KbWMUNrs=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V6aWBf3qlQm2I49v9O5A60WJmCT35g1do6bRHwZSXePPMvK9QoEZgUvk9Sjn+aHCfIK6grosquRpLlOBlSMUIAqcOPHS5MErdFhSsT4RkwgNMljKfcCAAzHiatipXPQvXQcXI/Dnu3TKa6dhAr81ADTGcaVIkGDMfrJIRqtZIt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CFklZ269; arc=fail smtp.client-ip=40.107.7.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A01jz/eaoRz6F+XCLabb3LI/HWvTnriVaX8wVUX7Ei1p3KJXEGwHq0gQbmHUC3PmYxAnbhjh3xA7m9+Q/Fbnz4wMkAIl8ulhys1EM47PFz0cHkDuZke3oD4FHrdr/XOTGnKtk7z67pWFhadSLnYjpu8QJIXXx8lV3hmZZ3KNe5x3FEOH8TCweCDK2Xyub78XI7X/zdYVv9hbij8AymWIVhD4DrzIUnm1JtKe7Ka9NdExc1evZUcWeB39nAGhMEcYMDRn/XNtFWuh3vaJhkDiuGNBqO7RllUq7d75m+XNBuTYaQsOn6othh50S3n4Q/ti6s2RxkANk4NLhXI84eEonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+J0Cykbl6eNnedgfb1miI2CGaeEz8G9ulVQRuM1NJU=;
 b=TQsT5pURqMJ7LokzsMfxg7Qs38Ka3ImZef7f5bcUQJov4WEklBZCDE6qsvD7/ZTn7WZfw1Z6yFy7kng1BmQBPqWFFh31X8HKNSH8q8HIRvYaoWie8+3p6L39rdezJz8QbdjQYPnmTMZXlmyR1M3d3sslv7xmfbsFLEeAqtJV8+TLP8MUuO3E04WkkgXnwAlutFiYfiW2p4BsYJN/Rsjg3feC5oJZVAXdp0oCRC6+FXm80czpE90hDOxK+oKaDyV6oKWQGJjLUGf4zGESgXZF/MCFuXrbW2+hdN6nbUJNGm+/X8WEgIqA+oSC/X1XAlvKT/SkoaYZy77icShysVoCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+J0Cykbl6eNnedgfb1miI2CGaeEz8G9ulVQRuM1NJU=;
 b=CFklZ269jiAAlLea7BDrDp9DNHtGpX7Tis6jIL52NRME3zequttk1mJrN0+4JEW/E94PYnh0NoYGsKjPZ/ZHVcxiYnxcAMWR9QP4H3dg1auGoWVT/91Y4L8AOjB8ciEZ5wxfXVe/dzI6SDXy+6v56dH0KF4i1i7+pq3f5WfI2xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7704.eurprd04.prod.outlook.com (2603:10a6:20b:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 19:21:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 19:21:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif[0,1] and sai[4,5]
Date: Mon, 26 Feb 2024 14:21:29 -0500
Message-Id: <20240226192130.259288-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 6625c2c1-a5bc-40c2-58b3-08dc37002b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bf7MaQ6xqd7WTkNE3/KIjxQQ00WJmAyupRH7T+51BmADk1UCKqiakJpmpur2kf1rxtts/agAxyPI2bamd3IBY8dE0Fyg/QA6twkIpNrxE489SrkLjJCQ20pi3Plvb7lgjOx/P7ektfAspF9471RWRO/zSvRtN5HjtcznUdWC+sR/PjQrfseNcwHkSAHoBxvpMZ+kvoVuqOp0T/+1vF8f1SD0fkQHKv1MwRajuYG1kCCwqSy9MOQjYOptJxwpmqJ8T2gJiz9HFxy17LKFaT1sN59GpRLx+SUO+M3uaPH3PTNqB8n7tr2bpeWsQCGyYrJNNVG1dtO4EviE+HAoMI4k6njESxZB08ftIrhTclZtO1l8ZAzoVDncZpt3jdAefVWO0Trl1XNmkLsdMUo+4YIY07TTA3fyBPI1hkI19Cb4GJ1tcbrPbN/XVaMmVMUQdMwyG9zNT0aM6AMZ3YdZXmK7T97Qn3J4qKc58x+tjUMCuU5StFbrFe65Ksl5iIumRb4mZbXQPslMBTjYGdtWlQSgY7qMafpJvQDPmdMop7/Huc9i8k/qbMcDKZ+f9fjuwHM/nQQhGiqOTjM4Mj6FIFT8hzS3pJDqdWV3fx3gjmq3J0+3e7T8pnD8TR+W8DeC4LCO86d6rCx6MLOJQ5u2OraQ5pCW8CZLbjD5BBSJFxXMQHZ9EC/zmW9eq6hu/xklhDPQiRJKiHHMxXiJwfa0dSUJoNsX5ssjhHbDjZgwAt5oncA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvzq5pr3LAI/oJka7JNQ3vJW0zg7Iu0KCLjT8kGCBf6MgWxw+1k7Lc2ZaTVp?=
 =?us-ascii?Q?VmWMrDu6FPZCZa/0HPQI7ksZuvS2H4TKwndSoUJP93IQtuW/wJ7lM7uNI0jA?=
 =?us-ascii?Q?3+11/Qa2dtvZVQVRJEjxO/G3sqOksgiae6w5UjPBb7A96Ouc4TUb/MEYLEV6?=
 =?us-ascii?Q?PADE7heFfV10e0+wrveRGQsFDqmanA5rJGqdUKWveOmDrDWI9FoJDFiA1kuk?=
 =?us-ascii?Q?vFEnFdfTk0JTSfAqs8ux8QTv76BcjzfWWeT9BB6D1I25VQiTlu176vsxCq2F?=
 =?us-ascii?Q?As9BUfUB9FBXwmcx1Rrf1uFYN4bK680ZZt2AdFy3u27c49k50KETqGC49KeW?=
 =?us-ascii?Q?54BwYz24VU40bSEJrRhPScXGZWZIMgRSTdQwVdH0mjwcMXyjM+7nRBAEl0N1?=
 =?us-ascii?Q?zpqnK9peeWvu+W2p1h6AXlqrbwxN4LE7GMF7P+8Ik55SNLhUg+b2hAzYB6oA?=
 =?us-ascii?Q?0r/7cyaKUmTy9OsN3piuFWH09hk/Unk9R533455/l8vjn9Or4fH9UwsyJgA2?=
 =?us-ascii?Q?usYeQlN81O3nLJaLqUVlGYHBu11672hAB4A/0cSyeWWTzZjV/cj0h/dD97wU?=
 =?us-ascii?Q?RB31m7DCRg14L5OpiP+yNo7gDS0qMHbS3kLTA9IBju2zd0XUrn8U4oKqS+ck?=
 =?us-ascii?Q?a/iUA/4bLQBehhu8+DF95shXdYV3AOhVEFg74IKbgOnwxDioiKzNOWM18e6m?=
 =?us-ascii?Q?ce5+2IEX7UXVGVJL/EAVyyMi5weRkCfveTc1ycFg0+xK5HQ+pVcBYDsQMXW9?=
 =?us-ascii?Q?/m3t4tvc17o0BAlsSNHXzpGBK+rzUbfJU8oNGHYRD7jLvVjfJ5/me7wpMNDc?=
 =?us-ascii?Q?5TL7aHODVIF2Y1R/Bhxoma5y0XyA1uHywY4SzqoEGwCS7e4OCXPWKLZs1MxD?=
 =?us-ascii?Q?BRWqzDghFWSRRlCjWUDnvixXRMt2knyIlBXBbC+SqQojhDBMvfoLaLI3TSCt?=
 =?us-ascii?Q?U4uGJqWO/u3Ltqb+yfKqSnJcC4AMV5vfuCT7Oqyx8IF0GkZ+L6u1Zf6+EWjW?=
 =?us-ascii?Q?5ToSIhD1xl+0VwssCMa5UrUuL/0pH0I/x5NxGbCmswuKKd3JxqYdl+2didUy?=
 =?us-ascii?Q?IgFWv4oYySvXYzGL/NOSCuU+NQS6PZcn2O6p7341/9AAwbfmK/wtBIKAAjse?=
 =?us-ascii?Q?5hGYoBCMu8jMyY+AlbU6BmuD+IVvsa00rbMGSRlFT26tbha18duhlOwWY9ZN?=
 =?us-ascii?Q?kzmXV0++Kb9Xc43OaCmQfbGremkG7xrtXWnrM3TrVVRTIv0QLcV/VAoxUOvV?=
 =?us-ascii?Q?NeSqWF+n/Jf2uUO54ZBeAgku7dad4RWcle3y/mwWEkP/sD8c9Psk3alfLTBk?=
 =?us-ascii?Q?rlnLpUwahhr6HvLTR9J4U3A6Xr3wj+ZZzx2mmqhxzgdXfSRgEmyMh9ijW53j?=
 =?us-ascii?Q?xFg+wzEeCEHn9sIG9jGzN5VFNvyTmy9NN+ZhRxT0HUHn372jYseYXt6XkFka?=
 =?us-ascii?Q?kKIP8+RPRPTfFcYG3P9z3W3vLr/ebDm3N/sSTt8lhfnHG/IuzyO8gYwxNS8s?=
 =?us-ascii?Q?OiChzbzMT7mP58W/4hyTVIyjRssIWZ7i076evPEWLBCzRKcCeiouyCXSM2wM?=
 =?us-ascii?Q?jQ9pdVBdkyBCiHimktE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6625c2c1-a5bc-40c2-58b3-08dc37002b68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 19:21:45.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7EqQnkcFKa5iKhOk7ThgREw3TTFubAoND5Y1HcE03TPraSwB/xsJTRQXrXmrEraZBgSV418tNnMX5L1pNK90A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7704

Add asrc[0,1], esai0, spdif[0,1], sai[4,5] and related lpcg node for
imx8 audio subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 306 ++++++++++++++++++
 1 file changed, 306 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 07afeb78ed564..6d78d6c0d9002 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
 audio_ipg_clk: clock-audio-ipg {
@@ -481,4 +482,309 @@ acm: acm@59e00000 {
 			      "sai3_rx_bclk",
 			      "sai4_rx_bclk";
 	};
+
+	asrc0: asrc@59000000 {
+		compatible = "fsl,imx8qm-asrc";
+		reg = <0x59000000 0x10000>;
+		interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
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
+		clock-names = "ipg", "mem",
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
+		interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
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
+		clock-names = "ipg", "mem",
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
+		dma-names = "txa", "txb", "txc", "rxa", "rxb", "rxc";
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
+		clocks = <&mqs0_lpcg 1>,
+			<&mqs0_lpcg 0>;
+		clock-names = "core", "mclk";
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


