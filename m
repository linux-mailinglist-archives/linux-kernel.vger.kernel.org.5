Return-Path: <linux-kernel+bounces-141380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1897A8A1D79
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2551F21946
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B5E1DFFBB;
	Thu, 11 Apr 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TimF1Lo1"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F41DFFA9;
	Thu, 11 Apr 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855310; cv=fail; b=GqJRoF6Tc7/04E176oRw0P23FBZDRr3qpisazgibLb7BDXAkEMQkvM5yX9hPDe+AQ37Kg7kwFGNDEIxWAlCWLqU8jR9vJwkePNlCHik4XycLBcs3vEceK+u+vhXy4rOIB67iEW4Vq/QA3SMcMVG40SJgFrzQeH5/CXuTqF6Fnos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855310; c=relaxed/simple;
	bh=usGAMv2iGqCBXUMAKkOIkuRGk5as4/0Zz7sWmBECzTw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LA5vV2PO+1WWh8ru94/RkN8R5oHef+8IqX0ECQxN4LJuXWcpuRgSrH3BBCEgRONvK7Lroj4Pg8MRd9oZdGZY2QFBkYsZA6VhogTVIMOR8Pp1u5JV7x+RiX3jzP0UAaATUT/L2tkABKjym/JjNvAHeUf+VsyPlegDOo7SPngOFP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TimF1Lo1; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKJL2PqFpavbrc9vAl38G3bwFWA7c2/2xXRiGQLOkzxKLwwyNHVGo6sTppmzvrNNd1b3c8zMX1RyXr3ls6nZEfqEBa+Ypb3PC0HNNBTKBlhQWP+sJMlCYMcXMRJKIuRPNo4Eq+9fzlvESd6x1yVpIwwyfN0UvboMNn3pKnBLvGhlSYV+b8Gpgd4oNkwdEONtx8bNXHTgxJSuFbAlfdkKOcYgfTtDbV8Z8vKXAB+AOFYXuRY45YKbJY4/oEAUmw7h1vhKLLOVhz+P9Tb9DJ5pzTEYmhEHC0LYhxpj3votehIxqXxvgjNjT04/r8FN98sDQSJAmEOjR3Id+65jVpC8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1uQ5MekJYcNGzwltr4NIu+JKx+tCC5Ht7ocupxms3A=;
 b=UhnFGbUN73JooE0b75nts7xFWtlExxHkHiJRogNpffx5PTOih9n3tY66FpkM7yOLQ/Ne4vR7qXJjThAFQ/Js/NURh8yG1O+uJFWAPyMSJjmHGbhRfkzSG3PIy/iDuBgzQkIY4Bp9ZlSocGNKzZzLXLpI7N3ciyoHSu8r1rzdwl+lusj0GSEKkKiZ7FHB+kCWLks3ftC/NVYDuA/jxzk3rtAgFEr/jhWk1tX7Y2sRDToLjPSWag9wDUAwpFMEjXVJErYPLLdJXvt+TnAnaHjKRny8xJ9DC9RYHX/2svQM23Ywx4Tt2jCZyVmrL0raNCbO6LHvfgHbKrt10xOc6HJglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1uQ5MekJYcNGzwltr4NIu+JKx+tCC5Ht7ocupxms3A=;
 b=TimF1Lo1/xHO4mzH75aVv5PBRROHzmxJM/Zg30NHjpQrcGb+qtI/Qqi+RWGnxCecRR1vwAWpzDWPxM87ofoPlJHBevUFvfBSG7/6HhV84gBzoLMpvhnkl+IM4QN7pZ44DeQ1Fe7iFlYLG/1ZW2Eq2dMyiiqdTcXuNMHLT3OY0Gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8394.eurprd04.prod.outlook.com (2603:10a6:10:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 17:08:26 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 17:08:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Apr 2024 13:07:48 -0400
Subject: [PATCH 4/4] arm: dts: nxp: imx6qdl: fix esai clock warning when do
 dtb_check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-esai_arm_dts_warning-v1-4-5e1a7c7be9b9@nxp.com>
References: <20240411-esai_arm_dts_warning-v1-0-5e1a7c7be9b9@nxp.com>
In-Reply-To: <20240411-esai_arm_dts_warning-v1-0-5e1a7c7be9b9@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712855283; l=1947;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=usGAMv2iGqCBXUMAKkOIkuRGk5as4/0Zz7sWmBECzTw=;
 b=f7HlyOkpkewFjE0y7U+edfGWgooRGrKwUenhmOOvMseK0jXKPr1vBVNJokeYjXFTVOQ2aCd1j
 8beSEeySOvmDd9lcG2wvRF1qynUzR36B82ut2Zb7yFaLIsQQTkazuF4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcee29e-2c5e-46f4-65ba-08dc5a4a0032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QVa1/HzwqDryhyBm57egs370M5ZE1HskOaqCB2UGGn0D4FXfv9shtmSNZJpbzU8pFGf7owWlAZwSXHnrHVyGFGWGPTzm/+iA8QVvgMLoDnIgMFPlAE3wkNvvTYM1bKiHn46WjtT1Fuy7s1JCSmgu8iwxznoCmayj71LUESnXkc8n9MZzAUz4xV6edxk2dpg630yIgV0WMSboPGMXtSI4NfcdBuT3pdl/JY69R/o4L0S01eNN0FYm8toV/VdplwbxMMjwf1oKSaJFK7dJOW1uXtmIzaRyGcrT3+OmcptjlqNa1eQmyJp1eT3CtxAX3RuV+oLtu9nQtVf932Yf29a5AZvPOTZn1S95llpoKZUDC9NRsWjfzAVPm/XmKjwgQGcfnmMUwZvcAi25TUUkiukHgVZUJutBm/S+vmwFsTR02hCUmH8zinjRh6fVzhtWny9HlXNAfVXq4Cs/4wH0rkNINZtdlE5QYiqVbpcFFYMYOEL64WWwAoi1cjHe+ZCf4vEerpbJJgzTNY+chKBS4hrWkyve6+Lb2Qv6b979EabakH/azwKSJEU0FTp4FtIFYc1zewuBYS3+kekRHSl+eayDnQZpoRJz0x4wBs25vWIs8JjFg5+jZ3DcXLJcBjUBxfqHO+O0kDeLeZ0tfRbfdnH7xnoSNAiGy6nTtM/GQPdOQ4OEPnRqiAeNro14h4KXSCBX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjhFUmhoTlRpc0NBZjBzMjBnSEtqWkl4TzVZaEh6ZGwrdjdxbEM2eHQxTUo2?=
 =?utf-8?B?bWkyK1NaQUtJRUk3aHZmS2ovV2wxWlhiS3FIUk9xQzZDZTN3TmhGQjJRWHlU?=
 =?utf-8?B?Yk9jVFovRno1TDBBTlFtUkJXY0ViZ1FlSWdnWTJrcUhrbThleCtFZEJWWml5?=
 =?utf-8?B?ZjE2T280Zk5CZDRLL0tvS1piYTIzWW1XSG9taWdZY3I0aklpQjdNUFNNeE1F?=
 =?utf-8?B?UitITm9ObVl2UXFhS2xiMDdzb2lQSVYwOU5DVmhybjFsZHVDa2plR1pBc1RN?=
 =?utf-8?B?S3dQMEc1TDRiNndiclVMYzkxN3pzSkpjblp0UXhtNm5pS0dZOGM3RUxPVlRm?=
 =?utf-8?B?MUVsTk0yMzZiS1cxM3RUUC9IdzFKWHJKMzYwUWFUTGFhRHdIYTZUeDhQVEZm?=
 =?utf-8?B?K3RDS1FIaHlBdldIbEVWOEl0SGFiRzAzZ2VPZWt5bGVFcU9Od0wvWlhDNCtk?=
 =?utf-8?B?ZGl4WXJnc2ZQK1BnSUdIYWZrR1RULzUyYmhKV1M2RXE2elNLNUd5eVhZOHVj?=
 =?utf-8?B?UVp3TVhGSlFyendnRHVmcGRhdnBraHZyWWpvYmYveU1DVVI0MWEyTzlWdGw2?=
 =?utf-8?B?UENhbC9uSUZLTzlOSmNqZ2dsRitGLzVmeGk0U1BiT01xZjV3VHZjTG5ITlM3?=
 =?utf-8?B?S04xT1NUUUQzVzduZHBzakg0dGVRNnp2ZVpVQVRCTmpIbG10eTc5R2VXUXpE?=
 =?utf-8?B?VUNhMzZibEJ3T3RtdXRuUnhWc2Z6SWZPelJ6enpLY2ljTnNNV0lrQTVOZjQz?=
 =?utf-8?B?US9OSXdTNitpVmVRanFBUnVucDh4U1JxVkQ3N2pYanJzNXFkc3p5KzN0TjRJ?=
 =?utf-8?B?Q0VQb2pWWEptWXp0MHJBZHNHOGJGb0xxT3MrQ0ZhYzc5MGU2c0MyaC9FNnI1?=
 =?utf-8?B?V1FYU2t6TTJ3R0VaREZTSjFkMVJoT3dBRG9xLzRQcU5NZU15cXIyaUZKWmU0?=
 =?utf-8?B?UmwyaTVQeWkrWDIrNGRNek9UbStFWEVKU2JBUzV4eWRlRGZ3R3lEblVDVkV0?=
 =?utf-8?B?V3hTZEF4Z0xReWJyeDJwRHJrem5VMEFvencrWWpxSm9rNjZ2dmdZcmdEUHpR?=
 =?utf-8?B?OXV4QU5CM0NCRXhHaWxXaTBVOUV0OFdzZUJqUEQxWWMyK3Axb1ltSWlUcHIx?=
 =?utf-8?B?UnplVzlIMnBIbTBDWVJVTEhyR0lZZGRVZ01EM3pZNCtiS3puV1VKZGQwdmFQ?=
 =?utf-8?B?cFZDNXJGN3U3aVoyN2MwdFFzTUFxT0dnU25XK1NMZkJQZFcxcXlQUHZVd0Np?=
 =?utf-8?B?QUswZEZtTG5nbHVkaGQ4eU84K0NXSURsZTRLaW1MRDREK0lZdGpPeGlrR0p0?=
 =?utf-8?B?VHhMRFFuQ0pxdTYyTUFGT0ZxcmpvRXcvQ3RISkRGYWRWUkNKeVlpOVFvOUNU?=
 =?utf-8?B?WkdDT0JqOVQ5bU85MXpiZXJZcFBBdFE4K3NRMGlSQmNhMUZ5SCszMUEreEJj?=
 =?utf-8?B?cm5TUEJ3S3N2R2tpTThFSWVWUFZGdFRxdUVSRTRPNnY5MHUrWGpuMmhhelRo?=
 =?utf-8?B?OERKU0I3VGtkZ0FMUjlZSWExWW9QTWR2S1ZZTWRONU8yNGQ1ZlA1NDB1Si9Z?=
 =?utf-8?B?TTBHVW5QbXpBZkFuS0FJalV2WDEzZWIvcmhJL1dJWGkraXNSdnEyL0pWYm5C?=
 =?utf-8?B?aXUvRGZDRnFqaUNtYzIzYWJCc3VFb29WKzBkZUl5Q2gyaHNCQ2lNekxkK1BH?=
 =?utf-8?B?YUc4V2MzU2FLUnIwUkVNNGRDZ0FQNXZ0L0Y1MXNRRTFxNUVGZHRvZENiS25o?=
 =?utf-8?B?SFlJeWN4dzJCSjVFTFlHeVhadDhvRGJUMWxjdDAwTWNuZlJkbnBRU0oyWk5k?=
 =?utf-8?B?cnl1ZHEwN2JnRUdYL0xDd0RXNFJHT1JsUzBlNCtaUDIvL1NKT0k3RHdpNldK?=
 =?utf-8?B?aU1tZGYyU3dtSi9GRW1jQklSelZ1cnIrU1VpZ3FCTjhJNmlWZWtDYjZOcVdY?=
 =?utf-8?B?Q2RCVkVOSmM4K09pUElwekNmU25jdjF3YnhGNlVIRzREZ0Y0N2xEN2ZPTlFX?=
 =?utf-8?B?ZG9HQ3ZoK3pOQlRlS1BHdTdwMUpTUVRyZXRHSDB3YWord2FlbmVZRWs4cmJv?=
 =?utf-8?B?T3dlbDJlekk1UVRnTmRYb2wyNERQLzZoRUd0TlRYYXk4emowKzV4UVRZZTFq?=
 =?utf-8?Q?cAcbqNOVZCCwmTbH41cA/p9X4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcee29e-2c5e-46f4-65ba-08dc5a4a0032
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:08:25.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fTZEFODKPv/JTpSvzZjfDtLZCFSucT9gRUjvMVCTEYJbGmFxLJAZZcrs7k2ka82Fu8b9r6t8ANQYun4cT3oaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8394

Remove unused clock-names 'mem'.  Driver (sound/soc/fsl/fsl_esai.c.) never
use clock name 'mem'.

arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: clocks: [[2, 208], [2, 209], [2, 118], [2, 208], [2, 156]] is too long
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: clock-names:1: 'extal' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: clock-names:2: 'fsys' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: clock-names:3: 'spba' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: clock-names: ['core', 'mem', 'extal', 'fsys', 'spba'] is too long
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 8431b8a994f4c..d2200c9db25ae 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -397,11 +397,10 @@ esai: esai@2024000 {
 					reg = <0x02024000 0x4000>;
 					interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6QDL_CLK_ESAI_IPG>,
-						 <&clks IMX6QDL_CLK_ESAI_MEM>,
 						 <&clks IMX6QDL_CLK_ESAI_EXTAL>,
 						 <&clks IMX6QDL_CLK_ESAI_IPG>,
 						 <&clks IMX6QDL_CLK_SPBA>;
-					clock-names = "core", "mem", "extal", "fsys", "spba";
+					clock-names = "core", "extal", "fsys", "spba";
 					dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
 					dma-names = "rx", "tx";
 					status = "disabled";

-- 
2.34.1


