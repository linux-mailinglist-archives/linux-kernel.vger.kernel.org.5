Return-Path: <linux-kernel+bounces-97242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C687A876772
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B97828286B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F9A249F5;
	Fri,  8 Mar 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="skytGKec"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550D524CA;
	Fri,  8 Mar 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911894; cv=fail; b=Fs5+NqAXWWS4YuO2/59u35CQmEU95FF/bZbq4ahN76bbjLE9RBCOv9Qni2sLP9i4acVR2w80SJ3JHe4oHPKS6C/e24oQoeExYpsdw4Xk6mHQNdHviEPhh4IcSVe6VPTpHrDzRoRaIy9jtXzC4g7eybfVJiIXXxv+pB7s7/b6iic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911894; c=relaxed/simple;
	bh=D/R5xpB7nUStCi7qPZ8KjfQq8oLcfigi288bYzejh2I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DDWEAQzN6cQWsF77sEoyDXFDOBYsTGQTiVhBogcJNxLjnoSNuz0iUUNHvBm8h2ob1TCeOSC0jaKUw9NBd2cAW4ZaaDSif6dh/ULAM1Dd1BtjqakcMuGybDI61AxiCTPbkOlY2SSTJ0FJXKHDLSCcmLrx9BP3utJ1r3tmFTEaeOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=skytGKec; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHmmKfs++tOFXhfL+zHq1NFZZKsl19n+oEMFL0eJbvg9Q08v9W2AKU6pTFVmTNAWoy0UoV0gh4+CWHAUKhepNfHhI/gEHnZY+Oo3wUgSvR10ORwITxykTgfkSCuOttAHIykdHXR/gyWtT9Ya2DZDtzLhQtIJ1W8za6BpseHldGb2QbjaiHINWl4dKN/8UjuceEMU6HVEoe3fMtW8hUoBR+Iyc/JH/jbRyoek37pcCjlAGXu4yfD2856gK3iUQqtFEo99BAKIYM+WQMiOJrC/+lVl+aHdB261McTY3saNgvcZi6iFXKWX6kUk+0Dg5gS2a5gtMqLvHow+GB9pl1Jziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huR+ZJYUKZikB9kNtJDK+f8LbcOyOe0sZHlOK8cmly4=;
 b=BjgPO52oEvWfes0RrGmgTHkFNDH4cCTnSVEXpXvmW8IX9GoLpeZZyO3n5eKDXqfAJoT7Wl+txNnIloyuqFJi4K3rDeDIlu1w0rsAgjIAORQnwBpfzJhj4sF/ZxaLuT4TTuozdE3TYGomwZ+IF/a/eXIBMTmm/aZ7q/O1KpFujekQ+lomqZ2i5ERpFwc4wL/bU7D7RExf6kY2f0Kt2pJhG3J9ZzymsjUaGvoVt9I267UvN5sZrOiB7ZuQbM46844wmL+2xRVQJ0dU7V4Qw1Y2+pbjVkwabABdQQKz5SB4aI+DMbM6RireHBmtmJyBrZCVREB3yVcZsaPhGCWrnnzQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huR+ZJYUKZikB9kNtJDK+f8LbcOyOe0sZHlOK8cmly4=;
 b=skytGKeckAgcxC9TyPuPWBR/ugNuIxxNXyddo+o53dZL4363bwZXoCWneecmKgOzEg5Tb9PVp0bNpPzPisf0dM3ubu8MuQupN9zJ20Of1833z7A4GnckULo9jzaPpPsI0EeyIJtoQ9H4NcH/PZgiuW1w6HWuQaIiwnpRSzbzOc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 15:31:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:31:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Mar 2024 10:30:53 -0500
Subject: [PATCH v6 4/4] arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0
 and sai[4,5]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-asrc_8qxp-v6-4-e08f6d030e09@nxp.com>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
In-Reply-To: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709911866; l=9815;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=D/R5xpB7nUStCi7qPZ8KjfQq8oLcfigi288bYzejh2I=;
 b=QLkd08p225I9lhBgOIsU40d0OJPqQraMCnLM62TP4KPlZVTQImNRSzGWNEt+zCN8HZ3gVQWg6
 vL/DphLxuDcDliAfugy8dQcnHsnuaDNrLCKHpqG2C3qVP/XWtP9fhDZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecee955-ca56-4548-0991-08dc3f84d222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EAqxBZG7cUDDCr552WqhsPSv34/dFDA8UOOz9t6xJa9s/RJxbQU6d4veJFDLBm+uvnivjBA7O6JItvlW31DjqNujRaLwutP7xC7SF/lUIIDG8/AmXSnnC20BKEz0VKQ9IGu6psRq4GN3eOuJb+i0NAZgneG+y+jASpphFIVCSq/ydRRl3eloedjWbuboTvwXtHqo8GleTpGrXI4UF4O1Z3RlUadbUoDyizPMfkPdIMIXgwLxU0htzQaUxg/lLPWO9Cs8hPBSeb8Oi/mXpphFkCbcp2WmOLdznpgBgsEEjhEujlITXl+OuEjrRZ31+OJHGU/3cCxdni/1eSLCx/4NeTR2XmKcdxYGTSEC9PMSmwdx+q89iWpoEkPFhE5HQ7CwiSBzeAUE0cKahSyaoikZliCE99eMIRGONpChBp/oGJMi5IUnLpRjlU/QicfKoTIl4q6PmzQTP/jhTeDc3e5GCAc4+HDq1DdrsYrROtc4nrDHhPnFlLAvbl3eoxvChgaG6DdPJxvVRpf3qRIj0SCiadhv+dLSrnQy7w8os7kX4+cOxhexgsUqIAq49aXzhZoTQbnmi+y3dvLB1e+EDukAOyicaHzSGNVTt1SmBXzuaecmKhYPr6yM7n3CEcOYxlITI97qkYnzIGNZKbTBQuC9vFkc2Bb1pnga309O9bHInEFReDOxMtEbWTZWo5HsKuh5ugBiA9LfPJBH3SGgjHMEtrCaT2WmmgWfCAEWvzYENdc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkJYblB5aTdnUnJPTktBM2ZTWUhjV0xrN1JCT3VtYVhSMzVwcFF4NjhrbkMz?=
 =?utf-8?B?YVEzcHRGYkpKclRHcVhJQ294c3Vscm1WdGpaNVY1NmR0Zi9VZFJTY2tmU2Ry?=
 =?utf-8?B?MmdpTFNsNUhnN2JROHFLTFRVT1Fva1JjWnVIb0VqdW9aUUk2VldOV1czMEtr?=
 =?utf-8?B?bldCdWtxZXRFa29IbkhaZXZ0UEQ1emY5bytBZWpHWWk3S203K3lOVmV0UnRQ?=
 =?utf-8?B?SW5nZmExNHduVEdVc3lkTXUySCtZRk4wbmZ4V0dHYkZFNXJueFBmUkJoNzEx?=
 =?utf-8?B?MzJCYnBxbVZvVGx6MDVlUFI4S2tZbTJscE9ubStJRlMwOFNOQnlNNHVNelo4?=
 =?utf-8?B?QU1EQWlLMm5waHEzQlRVazd3dlQ0NWdqUjZ3ejEweER5L1lMTmcrSGptd0FJ?=
 =?utf-8?B?Mk95d3kvcEkxQ1NHODQ5ckdHaGNVakdBMDA0WVlNTkdldjBJNml2djZmVlNW?=
 =?utf-8?B?N0kvc1UwbGNpS0dHQmZQWCtjSDBBVXN1MjlTWkhPdGlwb3ZNRFgxdmxkQm9l?=
 =?utf-8?B?MnJPYncxL3I2cjl3MHE4QkNLNVVRSXFPUjhhV0M4MDVHKzdxM1lKa1pySDRJ?=
 =?utf-8?B?cXE3SGpDVXM0TjNIRmp3anRSL0R2MEd6Q3h0QUVVTzVuN1pjZ3ZqdnRHUEp1?=
 =?utf-8?B?Z1ZXMzZkZjFqVExHOW1lQnJjeVBYVHlhWmd3TjZIZkdmSk9RNXBXaW81ZEw0?=
 =?utf-8?B?YTB3azk4bWloWVJrV3VmT3R4WkYybWRQeW9wUEVIY1E1NTgvQmp3K2Z1K3Vk?=
 =?utf-8?B?WDVQRDNudk1oQ25IMjJUdlZJZ0hPcVArK1pMNWp0cE9rODJKeC9XVUNmeFRH?=
 =?utf-8?B?eG5aR201eDI3dENzcENaai9PbGdaZVJTSmFQYzVuOHJSbFZuaW1NWDNTWTJO?=
 =?utf-8?B?dVh4Q2thOFZVVWRFUlhDWHZNMk5nU1h1c1d2VFl6RjR3U0UycW9jd3hZcWVR?=
 =?utf-8?B?T1MzWkFaYlVJQTI1RWlneTZFMzZNVnk3ckdiOFVBUVBLMUR5aVdyZVdyMkNM?=
 =?utf-8?B?a285ZWxCdW5JZFd6bitjVzNkT3hsRFZ1dXhLSTk2ZWF6d3puRkJlUHJnMzFm?=
 =?utf-8?B?QmZiTXlrclRRODYzVVdCS0duclJNZlZpY3luYnFUMndCaExOOHNxNkNBckVp?=
 =?utf-8?B?amVJOXNRTmlSQUptUFZIVDFzTVo4QWpnVFF1VmduK05HeDRxUDVKdEJkVFdu?=
 =?utf-8?B?MjdZZGZ3T0pVbFVIdWtjekZKUFNSYXJjbkd0UmRHT3lCRGVhVjR3V3BmRS9z?=
 =?utf-8?B?aVcwM09sUG9uSWdIOU5VZWx4blFnVXlRaFlYWUI2Z2RiVk1aTHBxYnVGWHph?=
 =?utf-8?B?MU9HalhtcHc0NlBaOUd1UTBhRkIzUUhzWXBhMFFFQnc4cnZrandVNTZKMEha?=
 =?utf-8?B?QVpndkJINGpyMVg0UEtKSGxMMnZrbEduV1hCRU5hVmd4eXovU3Y2VGNiZ0I4?=
 =?utf-8?B?bGROUHJPejZGWk5Ic2d6c05XYmxGblY4ZzZoQ0RTY2o1L0RDZ1ZoOHdIQ1Vi?=
 =?utf-8?B?SzZMUFh2NTBhMDZuQ2ZxcXVQNlVkUkNKaFJxSlRmeXpaOGJOVWFKYW9EZVJ5?=
 =?utf-8?B?cmNNS0cyalYyRnc2RFVZeWk5TlNqS0s3WmZvYjNZREdnUUh4Ny9ZKy9lVVdx?=
 =?utf-8?B?Tmk4WlJVZ1cxQWtpQmM4blpNWDRKM2NOd1hCU29hYXdpYklvdUJzUXlobmhh?=
 =?utf-8?B?NHNmeFRrMHhPNUh6RVp6ZnhYcis3bnhTREFOQ2ZpRTFRVE80bUNFYXgwYWtM?=
 =?utf-8?B?U1RoejdJN1JBQkRXOGMvUHVNUUd1R1JHcGhxWE00cC9pNFZDRkNnck0wci8w?=
 =?utf-8?B?dVl4ZloyQUVHQzZvY3Jva3h2STZrSkFiZDhqUkUvbmNaTFJ0R3gwV1c0N1JH?=
 =?utf-8?B?alpBWnJ4M2lqQUI1Z3lRclZzWkt2NUtJdUtEc3B6Y2ZvdmR6SU9uZUJDSWIw?=
 =?utf-8?B?VXZIQVVxYmdHUDNHWm1oKy8vOXJTWXRWcXpua0lZc3d1b3d3SFFIcHRpWUVF?=
 =?utf-8?B?UW5lSi9WL1dBNnA4VU9xSXY2R2RRVkszbGRtL1A3ZDRnOEVKQXdpRjdmRmV1?=
 =?utf-8?B?WWFiajZXTVhLL2QyeTErelRUckQ0ellRWTN4SzFBS3N4Um1IUGR2T2tCYUJP?=
 =?utf-8?Q?D0JnCU9jU9bP0KIjuqCYwzhd5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecee955-ca56-4548-0991-08dc3f84d222
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:31:27.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dobCOPJ5YMqo2ez7M1I1h/Vln2e6P1GL2MbYSv7IbcC9aVmCYGLvfVSZgbB24Cor2pDCYs/MChMY6NZNC//Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393

Add asrc[0,1], esai0, spdif0, sai[4,5] and related lpcg node for
imx8 audio subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 267 +++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 07afeb78ed564..3c57593687f81 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
 audio_ipg_clk: clock-audio-ipg {
@@ -119,6 +120,86 @@ audio_subsys: bus@59000000 {
 	#size-cells = <1>;
 	ranges = <0x59000000 0x0 0x59000000 0x1000000>;
 
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
 	sai0: sai@59040000 {
 		compatible = "fsl,imx8qm-sai";
 		reg = <0x59040000 0x10000>;
@@ -239,6 +320,40 @@ edma0: dma-controller@591f0000 {
 				<&pd IMX_SC_R_DMA_0_CH23>;
 	};
 
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
 	sai0_lpcg: clock-controller@59440000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x59440000 0x10000>;
@@ -333,6 +448,102 @@ dsp: dsp@596e8000 {
 		status = "disabled";
 	};
 
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
 	edma1: dma-controller@599f0000 {
 		compatible = "fsl,imx8qm-edma";
 		reg = <0x599f0000 0xc0000>;
@@ -481,4 +692,60 @@ acm: acm@59e00000 {
 			      "sai3_rx_bclk",
 			      "sai4_rx_bclk";
 	};
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


