Return-Path: <linux-kernel+bounces-127132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFFC894750
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C985B228AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4E1EB37;
	Mon,  1 Apr 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jyM0q79A"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2114.outbound.protection.outlook.com [40.107.14.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D256B8B;
	Mon,  1 Apr 2024 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010369; cv=fail; b=QMskZ8X1Ec+R8Ugi5gk3lhRxEaV491f5dwii6g7ctx42e3SbEec+Bgcp39nSNtluJEPyaUz5o/x1YCbTHrdBYXLMVco6Pz3/ricDSJzofBKaC7HGyY+3OtbjXALg+03MS62GUL9hKyNQLgyucAB9PPAlkGa9vRwEPfT3QF04ei0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010369; c=relaxed/simple;
	bh=+Xl/NBxQeZ+jWNsmzYScwfNZfXWDsmCFIP/CHujTKh0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=O/aojNSLlHKqrLW4mTnQbdl407vYkVs+LeCvlr5mQp0XwC1TaGzHSZPXZjmSz3/kiLdLQMkch9AsCVzvv+4pV+kfw7n9NDYgKxC6ch1kNu+InQ+uLKF5bwbjRj0zQ5hatC2/UPjFF6dp2q/Dr9HDD3TTMwE6Qpga3QZwSmBzg1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jyM0q79A; arc=fail smtp.client-ip=40.107.14.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNCw8eZRs+vOhF7XldOUm+Ez18cQgsbxulVah/kaBrpoBgLMQ0NdfN/dAssw6v8g1lSBKLW+qMxgIcMBznl7ZJ4CFtfSKRZ4hhforSGGC/orPi2H2HkBHfL/DTKmNFxyrgh8fudwBCNm+qdx95Kiyw38oS77M6Yt/a1egRsPz1eztj8PLUENbljt6mJu5a87HMZkl6lNK0TBI9GKreZaExGIpWWNzF2XNCjU+pmLWlN4JR+3UA7jWsSwrZ7rcckVh8dXQgTdzLf27ONxRknTN3PFvCCNqQp56+5cVNbtBdvbiq5HCcs4XAa3ue5G/oZy7qpqrpChPZCtIuSMG21uXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iBT8217c0X3M9h9xFyhs2PbHWFfGpPCyfNWe94VNDA=;
 b=jwXciYrLVi9VE3Qj62aKTMIfvHLO7XrNqEu2qNTMPpuGIEyQ2gHerrR+4V/GaDr0HEDbSovhkOLefjgi64EDfYHlfoIteKvtLdB+XYhL1U78INOfY1sWKEj1mHYDngB3jMBbXEstGvdKGB7kotjJdEtlfdDUobhOUlNEaQ8eq62NQMdcsDTnnYYlnQMvUr/COqtxYLp8U3prWhD+xSIh0bGIpQi2EJjppjjvjTu1hjGDnX0jkERtMxl6ZCJLt1xWP88VqF7pq5TpE0rSrsGnrDeUy6IWI8fk31nmhfTO8Y1JDF8ylgjHWmCfDLOXGfg+6ODq4q1MK2YOSD/+9W7zEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iBT8217c0X3M9h9xFyhs2PbHWFfGpPCyfNWe94VNDA=;
 b=jyM0q79AKd2hJS9BPqss3/Ymr/neZUQfYeQ8Up0Y91lGy/hiewwAE2dW+LEpOXbUAxJ5COfVuquEmJ8c3ZhRNZ/IHWx/L1tZtT8lr5aGWNGHM42quZO+F1gPCqgbjcBczNNYaek/vTRXA7BDeDCP+/4YgLtWoVofNKM/hwF3dSs=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 22:26:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 22:26:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Apr 2024 18:25:09 -0400
Subject: [PATCH 7/7] arm64: dts: imx8qm-ss-dma: fix can lpcg indices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-dts_fix-v1-7-8c51ce52d411@nxp.com>
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
In-Reply-To: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712010330; l=1806;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+Xl/NBxQeZ+jWNsmzYScwfNZfXWDsmCFIP/CHujTKh0=;
 b=jrIm5jsGkc0UB3hDjH5SJrKt3ZkK3KaUPw0E8aTe75F36K2+JuUiRFlOJQFNHfseu1aQxp+3V
 S7cMTAFNQSeA4viqwky/LgPwXC0ky+eSTW3p1aqlcTqXKyb74pJW+E0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9976:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 VLE83ChOaVZNM4zd7moPMCF2IsFqRRgSiZDRfvJpx0+yKTCv5rA35O0wz34haNXM28edcooyVOPd8+fhMzkOogrqVYO1tr/KdscZAgdUXh7LIvIaQNCugI4sg61W7h8XHKP4dwOcrN9OQphtJ1cG49H+zSpoq8VCIZBfyMnwaPtJUem6txrC8J/7Efvll/96JuQF8iYSJyl0VJ89nL7YlZ2iW+8mXXd171PRwabTgpiQQbX/6l6GvykSnyP7hTLBK02R0QL9twDMemJxiv7R2JvgEi2l8pAZN5BeOtDqllyRRCCVU1HarELwkwlZc25H+fqHBnfklhWDHIAh9AGAD0f2BkkEeoeQuP4ykmcwvWnSF3//Jnt9tCzoXFqlMdR+sUSXJfaWIGdKvAFIopnSA54U5FV0Rqu6GFnA1u1PgPfroOi5luwtdGVqAjCOBasBmm1oTPMCvEKHoGJTtJEvPXLBiW+xeA/HLl4ZYO+SgEwjhvTi0UhAV2yMAE89cjIKfo1Kbmplctrqpehlo7ySKzwEoRVY9UM+OKUjYnmsfF34SlIQJAUnFKPUrJBRrHG3AuUbdg2ayuuIN83p50EwBdjt2gtQo2BhjT9XObfK37UBaDypw/BGExInJ4XE1vzwRFjOI5SfQKT8d5do8u7HAWUWydcp1N1lQEJmCPvPoo2KtK7EUMd7Sn79MhiEmk6s1zXibHPgiM8CHay3cya9OkrS9wLpZ2+wz/F8lRhYw0o=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VzBPczNVRE5CQkFZZzdSOHpGN3dWaWVwdzkrd0VjajBZRGp6c244SXVveUVh?=
 =?utf-8?B?andLUzNqbkg1RkoxK1VKR3h1c09ZT1NwNkJpdGM2Z3R1bk9TQlFmOVo0SFhY?=
 =?utf-8?B?WG9Ea0M2bXdQdXg0UXVzVU1XQTloaUNGbGZxT3cvRDY1VVhzK1FvRE5EUmdX?=
 =?utf-8?B?SWprRnVMTitmZTVNV3l1elE1aGRKSFVpNkdFMUMwdTFTUzMyb3c0U2gwbEtS?=
 =?utf-8?B?c1FaVldzUE1uVG5VL2NCWmtLUHdBRGdUQ1NrUnRXeVFVS2E3aHQwdXNBSnRr?=
 =?utf-8?B?TmxybytNVEFSYmdnSS85NUowRGp5YWIzTkFPVHBKOG8vK2R1cStlMitXcVFo?=
 =?utf-8?B?Wm9oek9VOHU4SG56M1lJclQ4NU1MSFVlcy9ZU1JmbFMxQ2M1V2lKLzJZQkRL?=
 =?utf-8?B?UlU2UGxYVlVKTk9VRUo2Rm5ZcUpOYTFtdlFOb0svZ0xtd2FabzBwN3N5OXVs?=
 =?utf-8?B?MWRQVmVmektnMExUUi96dy9JemEzdE04K2h1dG9oWG4xZXNvV2xLVkVyZ1Ix?=
 =?utf-8?B?VlptNVdYelE3THVnVExuUWZwOXVtcWZxdk1YWllEclAxczk0WS9KNHU0SXB5?=
 =?utf-8?B?RUZmMmpGR0IrUWdldmhBcmNuSVJvemdnNDJJUDdqM0Nla0h3amJzRHhSZUhw?=
 =?utf-8?B?Umd2eDZEMXI0MWlOWDIxUjFFRFhFNjhEV1NWbkZ2VkoyeXI2MG1HaGhrUWtj?=
 =?utf-8?B?dGdnQVlFQzh5dEJzVTNmUUxxR05VSGlMZ1R6WXpsZHNvVU96SnBjYUVKcUpF?=
 =?utf-8?B?NVlrdDRTYTNmZC9qQjhhVWVxTjFydThpYnVkdVpReGZPazBQaXhyZVRGbVkv?=
 =?utf-8?B?U3Z6RHdRTk0zSER4YkZpb0x5Nys0U1FtLyt3enVpZFlZSXNDTjNxUHYxVnQw?=
 =?utf-8?B?TUV3d2t4eHN5TFlrNXJ3WnF1S29hOGcwUXRSSWtqd2d5VU9WZTFvNHgydi9W?=
 =?utf-8?B?K3NXL01sMnFLeGJOVXNqbnhENGU5cytRUTRWOUFpZmJnZWt2MjVYbE8vZGp1?=
 =?utf-8?B?cXdEOURzZFR6SlFhNU83c1F0VUdWV043UUx3Wnc5dkJ6N0FpejJvc21GOXJE?=
 =?utf-8?B?QitpUFA1UzQ0c1AvZnFSeCs2VDdzLzN1d2FaNlpnWWdpRkhCcEVTVHAxR0Vw?=
 =?utf-8?B?ZjA5T3RiMEZqNUwvTEZpWERuRUFSd0g4d29QRW4yWHpPRFFmZXVSRjM1UmxZ?=
 =?utf-8?B?WHNvVjhNeTJmNzd0NGMrYTF4enFxZENiMHVRbHhyWjVZZU5mcEdrWmlKL0xl?=
 =?utf-8?B?bGlDUjZPYTFNWElBdGxlSkZ3Mm9hMzJ0QzJLbDFjS1VVeW55VVdkb2ZyQlBH?=
 =?utf-8?B?ZkZCUUlxakNyR3N0T2RlYTNtdThhUUZUN0RlWnpIMVkwczYzSk82SFRra25S?=
 =?utf-8?B?VWJnWTZrRjc0dHJjcTg4WC9BblBkOUFESnVjcXJtZmpRblE5djF0NU8vNnlY?=
 =?utf-8?B?QVczdUxjS3lsYXNMSm1yaXVLMklVeVJPTTZCbG5ZYTFqZ044Tys1N1V4QVkr?=
 =?utf-8?B?ZDNzVVRwOXVpOUQ2NVZCRUhWdXhwVmFYMXZVNjlRNTdLaDJDaFJncWRyT2o3?=
 =?utf-8?B?S0RpUEUxcFdGK3RRbkhQRFZUdzRsZmQvMUdSVE93STZjUDAwdyt3ZXlwL1ov?=
 =?utf-8?B?MURtcEx5L3NKdWJhV3ZKdDBONWNRb0o0RFE1THRrV0tLeGYreVQxU050Nk0x?=
 =?utf-8?B?S2oxajFiZkZ3THB0aDU5a1lZaE8xVmFmVmVaUjEzZGhhUldQNzFEV1pGMGRB?=
 =?utf-8?B?dE01ME1KZXY0MzFzODloaGx6bCtvRXZoU2IzcjMzY2JzaHZYVnJjMERzd0Rt?=
 =?utf-8?B?VjJ4RlgxWEgwYkkxa0psT3pscVdxZjlMdWE2Wm5BNS9xZGRBOG1Fd29hMmlO?=
 =?utf-8?B?aG1lenRFTDVVZDJ4ZzR3bjhRWnhtKzl6SVFSVk1UYkx1RWx1aklVOFgyK0Fj?=
 =?utf-8?B?UDNhYWhjMS8yQWJFVlhyVFk1M1RwZG51KzdxOFJ0d1JVbTludE5UNkJZQUdx?=
 =?utf-8?B?TjN1UmZOM3g5OEFIeVlHdlh2bklDWFdndTZSbWtTbXZnVWJVZFlsOVBpamda?=
 =?utf-8?B?MXIrVlNhdkNwVEMxWkowdnNUNy91WjNVVm8wUUxUNCt4RDF0UHZoZWx5VExF?=
 =?utf-8?Q?gRNg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629f2247-8373-4336-4f63-08dc529ab80b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 22:26:04.6719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tTfeiYsc3EM64dZdMXgZiT2Fv0pVYGCqRIplyq27Z8FoSjZlB52uA0T5X7X1dnx//W34a+bz0IeXHcBKj4kdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

can1_lpcg: clock-controller@5ace0000 {
	...						    Col1   Col2
	clocks = <&clk IMX_SC_R_CAN_1 IMX_SC_PM_CLK_PER>,//  0       0
		 <&dma_ipg_clk>,			 //  1       4
		 <&dma_ipg_clk>;			 //  2       5
	clock-indices = <IMX_LPCG_CLK_0>,
			<IMX_LPCG_CLK_4>,
			<IMX_LPCG_CLK_5>;
};

Col1: index, which exited dts try to get.
Col2: actual index in lpcg driver

&flexcan2 {
	clocks = <&can1_lpcg 1>, <&can1_lpcg 0>;
			     ^^		     ^^
Should be:
	clocks = <&can1_lpcg IMX_LPCG_CLK_4>, <&can1_lpcg IMX_LPCG_CLK_0>;
};

Arg0 is divided by 4 in lpcg driver. So flexcan get IMX_SC_PM_CLK_PER by
<&can1_lpcg 1> and <&can1_lpcg 0>. Although function work, code logic is
wrong. Fix it by using correct clock indices.

Cc: stable@vger.kernel.org
Fixes: be85831de020 ("arm64: dts: imx8qm: add can node in devicetree")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 69cb8676732ea..475702947afff 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -112,15 +112,15 @@ &flexcan1 {
 };
 
 &flexcan2 {
-	clocks = <&can1_lpcg 1>,
-		 <&can1_lpcg 0>;
+	clocks = <&can1_lpcg IMX_LPCG_CLK_4>,
+		 <&can1_lpcg IMX_LPCG_CLK_0>;
 	assigned-clocks = <&clk IMX_SC_R_CAN_1 IMX_SC_PM_CLK_PER>;
 	fsl,clk-source = /bits/ 8 <1>;
 };
 
 &flexcan3 {
-	clocks = <&can2_lpcg 1>,
-		 <&can2_lpcg 0>;
+	clocks = <&can2_lpcg IMX_LPCG_CLK_4>,
+		 <&can2_lpcg IMX_LPCG_CLK_0>;
 	assigned-clocks = <&clk IMX_SC_R_CAN_2 IMX_SC_PM_CLK_PER>;
 	fsl,clk-source = /bits/ 8 <1>;
 };

-- 
2.34.1


