Return-Path: <linux-kernel+bounces-127129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA3894747
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AB61C212DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EAB57323;
	Mon,  1 Apr 2024 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CRIAky0O"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2107.outbound.protection.outlook.com [40.107.14.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488656754;
	Mon,  1 Apr 2024 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010356; cv=fail; b=lnaZkEEFRc9ZdeX4RLr1KxJ/5d4OxnuRSWwuUJLC6hG+HC5YrRnBjfOWH0oHzb2t270BhItP8/RShwrIDi1pT0jzVLpmlpZuE4bC6YJ6SAWuUIgGz1dmopy0GREQ7uz1gQyCiNF1uFkBlyCDCseauJuDgeSE/voKCT+CEIIdEeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010356; c=relaxed/simple;
	bh=fdsoDcgdp2uhQaS8/tOFn5VfeICbpQvKk3TSdwKDGp4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MwH4hZ7Y3Q1FgxECd+7SadX/j/yVsWubZm7FpsesoNATRv4IyQb4ynarm/ed+KzrMhG/cm1OZQraduAcRvdci8+mdqWOQm/k0UKvJKDQ3sm8xCGxPlCTXjBfMUoiliplcKOPpYnu103C5PoBp8rSvLO2clBiaL6f9i2Q2sby0K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CRIAky0O; arc=fail smtp.client-ip=40.107.14.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8UopdBYQsXS8w2/0xFZ9BBDmYW4JBbF+i33Hn9n92a0wQ3cPbgyH7RJ1aKEo0Ek/Kc0/6Ct4pCSBt3csoGHE473+z/+DTlaykTd8dV14Kp5LATRt5NSaSwmWfDA0Ly5ExfJltIxlcg9Pj8dFCI2IHrHyW3Ggck6Mm5UOZFhC4eGPLCMu1+h5KyAn5+hMLUnbpjRyJrW8w2UEw8mihKBElPNZGeNe0ndPkehP7XqahG24iAB2Nd/6BWz3FmVzgVL9ASpYSX7cqxFC6nVh20HMeFHtkT01nqO4k91HL7Gin0Bc71TRqhpl0kUwEseB7mrENJZPv25kQnhubjbn7lBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82v2SoKhMzQ7onXLz6M6U1dv/j+k4JRrE+7GSWRTOk8=;
 b=GR2OoS1ddW5gH2D9XW0Vi2VNyxCZCW9+HWYLMpXecBM6IETsmqhAybgmbzKIhnbLBRiqqW7DytJik4tTnkzdvnTkERoFwkMb/YfByDRCTaOtlJq6vE4mYreiH8dWiW549wZai/s4lzFiUoZV0hTs0dYk6RboPawFOPWCCNuLr+zoP+NVVHQmvMDtqy2IUsrh/vIJvi3ZUbW5QBHmI7M+hlYxeMplk8kUpNcnn3YH2xuSY13gsy1pvEzH2wMNfgpu7xsYQddxmUGU1I8uK9ZO/fEiYmayaujQqdt99j1trEOcW/LaheX8MOOHWTDTsZrsPzNHcvnz4l+f4PybgKcaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82v2SoKhMzQ7onXLz6M6U1dv/j+k4JRrE+7GSWRTOk8=;
 b=CRIAky0Ovh9T+VmQa7+abDuBC84tyztsOzoCWMkFps9K+9O4TP0WUctvgKGCjdAz3nf6GipA7ET8DhBZmJXCdm71IzK1+GYhTDjBAZIEPKGHBeHYXRLZMDWIj2MCIcG5EqkszrxgKWcbn/oSJLy7lIjo+57IXbummYUE+ogRjv8=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 22:25:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 22:25:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Apr 2024 18:25:06 -0400
Subject: [PATCH 4/7] arm64: dts: imx8-ss-dma: fix pwm lpcg indices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-dts_fix-v1-4-8c51ce52d411@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712010330; l=1745;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fdsoDcgdp2uhQaS8/tOFn5VfeICbpQvKk3TSdwKDGp4=;
 b=Hh3oHxBHwLYgBiYlmxkonIQ2s0FE32klh2UftURC2duBM/QoEZKeS/irbACu2GxSeH9yqGfw0
 2bTkFJb5AfXBRpA6yxmOrZN7SZZ1kjxCf0hOkK3LWlYp9nrWlz5CTLI
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
 Fye7lKqJHORFe6N9XfLjlIOVK9GX7EkUHar5+h4AzMCQ1Fn8yrtAW2XtP0kIkYS1Sdq8wBAqo7wqAZuYsRcd2FQWQya9oYXmbpqiKgfi8+n2RdTFK/psnbVG1lR3mXPt7Wls5yiJ+jn4y7lIyAS+1CeCFr3dFGAPrwSU8EGk8LuRQt0vqpGkUcUlPo3IuSAzV4WGwXdh9YBWAV5qCjVsVPyfljincGdLmGF6qdEktdAc84yJoMadUD5onyOLj/YBB/xHfswnslELGbasKsRjYQ6K+lnhPRdB3gAtjru9TM4vKvh+fX1ASfs9XWqjK2oOdqXQ4dqWs4zDkdRzl2tPTJJWG9rctoNuiPUabdlP1nIzqdlmXsEpfu00EoCZXiRaHzWS/w7ko6O2bvkNdlT0rkUMuMSFIyLjAlk5K576lk6cIvYPuCOhYJZI0bclXrfpjVo87ha/Qw3pYJJdo7M5r/NF+fD1sui3KGgzgf4DNZCXN6Xfx5Z3ZHv4I9PC9ckOzGYjUAhfJo435x+kPMbxKkcYy1/bPy8WV5nEmnbxP6TVuJRH81kdwpTTvr4nhkJggpnMyTPqyWG0Cm0YZuqLIcLGr8mVfNTyJ7eiEt50vEfHZQ0NUbyqtkStWgyKfAgTk27Jqq62yJoXx3pbjsPyma44sBY+ButjVTFJjtP20GnHdmBp5SI5rcVTF0n4uPFN7KNLwDBAK1d4XxtLtdVqbHgXDumVy+bjoezR34zdgEk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SGd2MnN6ZmRuNm1WaVNwMmlKT0JEZXJFdDZPRnZqK3hsVlV6Y3U2MWR0dHRC?=
 =?utf-8?B?MCtnbW94THJTUHZjeklZVTE5dUU4bHBURjBPd1BnOUxWNmdUaTZiZUdDWlpS?=
 =?utf-8?B?T0UyMklxWFplbW9QVVdueW5HeVYxVDdQc296Umo4UW10OW9LUEpwTjNhMFYx?=
 =?utf-8?B?YzFJZmVKdUR4Qk9BeFFnYU9QQTFscEhmODlOZTZNZkRIT0k3Vk05ZnBPVCtB?=
 =?utf-8?B?RC8vbzhQOFh4ZEpaM3gzdEFCQ0VwZm5RWmpMOWZJOFlDN09nZmlNUG1VcXVR?=
 =?utf-8?B?L3ZWM3BKcis2aU5NSEFKYXRvelFmVkVJaERSY2E5bnFmLzlmelZmemx1MEdR?=
 =?utf-8?B?ejZXUExTRFZINkF3eHFCWTZKNUZEYnBQRnJOSm01TmEyQXpRdmQ2UVUzSGpY?=
 =?utf-8?B?VDFPTkVYMkUzU2pTb2xkOGtvNFJiY2dXVTR6Q2pKWnNzR2JkbUhSRzlpR0JN?=
 =?utf-8?B?YW9zV3R5b3hHaGlHMFRnNWxNbk00WDRZYW1HVHdOWFJaWk1lU1lCaWIwUk9N?=
 =?utf-8?B?UUFXSEYrVzNzNkpRSjd5ZmVGS1JldmNTRmQ3YWdjMVJGZ1AzSUJScU5ualY0?=
 =?utf-8?B?cUVwSlVMVjU3NEo5d0szcnRYeWtDcFVFalNqbGtYSmg5aThNUGI2Uk1Hc1hG?=
 =?utf-8?B?R3hhVW1XdUZGeG40dFlBand6OGlDQzAybkpwZFQyRG5McmhwWTdXem8vU1lE?=
 =?utf-8?B?MzJLa1J6aE50UDRRVHcxQ0V4Uzk5NzM2MDRoZnB5NXAxTDRQV1VSeGdEd3J6?=
 =?utf-8?B?bG1SNHF0a1VaR1d3SHladUp2c2toVUE5MEdNK2tHbWpOenozTm1hS1RPT3Zi?=
 =?utf-8?B?YTY2Z3ZVVEJINjBaa0p4RCs1Vm14dEJydDM0K0l0MktHc1JGWFBURnhZZk5C?=
 =?utf-8?B?eEczUDdhYjhiM2FySWNDUkgzWGg3NVBFWWNYd3UrRXA5USs1emc0T2dXeGFK?=
 =?utf-8?B?U0J3d1p1aVJQU0NuYXRUaEVtV3U3NHpQN2NjVEU0STVXam92ZFZ6YmVrSXJv?=
 =?utf-8?B?YkVoNis2SkVETklKbFBQYldwbnFjdkdFckE1MTFqNlYzQktYSGdnNmwycW1M?=
 =?utf-8?B?ZisvSXVUWFNWd2tYa2FNM0hXRVNlczBTZHp0OEtMRFVqVG1URVJMQTZSc1p2?=
 =?utf-8?B?bzBJY2lvZEFsTVgzZE9ZcnJERlFQY2NySHBoZENYMHBzWENkT3ZrcGR3aVJO?=
 =?utf-8?B?dXl4RGJhMHI2STk3c01seXpkK05ydkVoeXU3Ync5VitYTllOVHh2SVNDQ0xV?=
 =?utf-8?B?eWMyaklPTzFLc2tzRTNJQzhHUmZlS0hMNkp4eThMZlRaQSt6L29Fc2pRajRI?=
 =?utf-8?B?L0lFQVVZTE9vYzNPVGRpV0pvbnYrVW15MVVPeEoyOXd0SW1sK01uR0F3elBR?=
 =?utf-8?B?SkNGQWY0VDlmSkY2WVZpeWdnU1pDOFNpOGlLOE5zb1ltanlZMXlPUWdTd0x3?=
 =?utf-8?B?SXhqeS9aS1NZNTRFeEx6SEtqQTFaeWovMU4rNWVzKzRtMnpUbTNGZ0FWeXhC?=
 =?utf-8?B?UzZUSWFxUlpHbDhmNExsY014L1cvUFRTdEM2ZXExSHdlbUh3NUVjVUxoZXNI?=
 =?utf-8?B?ckJLUkcvYnpld21kQjlqdFBSMmpFa3d3YlY0cDJESy9kTUthL2toakFKRHU5?=
 =?utf-8?B?QTFuQXkrVTY0bkVnTi9zL3gyMmZxSmVqWUkwZDUrbi9WSGR5TEVoZ3hXbWdr?=
 =?utf-8?B?Q211ZWs5ZWhnWXBNZU1JQ2N5bTlFMEF4YWkxcjl0Tnp6TFZKTEVXR2tYVExp?=
 =?utf-8?B?SGNrdWpqY2xNdHlWRW4zUmpnMzZybytLY2prSEVCbHMxTW1QN0srTjY4M0xN?=
 =?utf-8?B?ejVUYnVsNFhEZGtQUWptVnZucjNZOStqSFlPZ05mUFY3M0dJQnZJTnBYUHVu?=
 =?utf-8?B?N21FRGdaKzBMajBiT2NSTDlNbkVuWFZuWUxqOVp1aHpRaWZwMjFPYk5sQ3V0?=
 =?utf-8?B?SktNbkkxUFZ1L0pSVFFkcmxCd3VXb0Y2TWV3c2E2QWlhVkFFdEZ4eW9yUThV?=
 =?utf-8?B?VjlIOTdlQ08vbjFHMUEzSTZXT1kxRzEyWkpzV001cE8xNU81UnJjRmhRcFJO?=
 =?utf-8?B?OUxvK25OOUlsTjAycVcrQzVxTTcrWEJEd3ZFQVVXVXhTTXc4bHIrMkNWMytN?=
 =?utf-8?Q?pQ0w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a7e5bd-1707-4ca6-bf32-08dc529ab078
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 22:25:51.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsRmB/Wna8OXWVmxaQrB4n1JaqRTbZDbVpLJ6rPIWUz7CV7YODLhuwUuFZHT1IZUiNShfGA9oJ6ZZ2snFmNXYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

adma_pwm_lpcg: clock-controller@5a590000 {
	...							 col1 col2
	clocks = <&clk IMX_SC_R_LCD_0_PWM_0 IMX_SC_PM_CLK_PER>,// 0   0
		 <&dma_ipg_clk>;                               // 1   4
	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
        ...
};

Col1: index, which exited dts try to get.
Col2: actual index in lpcg driver.

adma_pwm: pwm@5a190000 {
	...
	clocks = <&adma_pwm_lpcg 1>, <&adma_pwm_lpcg 0>;
				 ^^		     ^^
Should be
	clocks = <&adma_pwm_lpcg IMX_LPCG_CLK_4>,
		 <&adma_pwm_lpcg IMX_LPCG_CLK_0>;
};

Arg0 will be divided by 4 in lcpg driver, so pwm will get IMX_SC_PM_CLK_PER
by <&adma_pwm_lpcg 1>, <&adma_pwm_lpcg 0>. Although function can work, code
logic is wrong. Fix it by use correct indices.

Cc: stable@vger.kernel.org
Fixes: f1d6a6b991ef ("arm64: dts: imx8qxp: add adma_pwm in adma")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index a124d6598406d..d4637037ba1b6 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -144,8 +144,8 @@ adma_pwm: pwm@5a190000 {
 		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
 		reg = <0x5a190000 0x1000>;
 		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&adma_pwm_lpcg 1>,
-			 <&adma_pwm_lpcg 0>;
+		clocks = <&adma_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&adma_pwm_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "per";
 		assigned-clocks = <&clk IMX_SC_R_LCD_0_PWM_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;

-- 
2.34.1


