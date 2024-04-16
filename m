Return-Path: <linux-kernel+bounces-147062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E413B8A6EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B26284CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E9131759;
	Tue, 16 Apr 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfqiIyh3"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31D131725;
	Tue, 16 Apr 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278919; cv=fail; b=YbbEbEaBv5xjAsexNylJvFHK/C/329EYXqgv7pt8vLEN9oY6iqW2bG2nwOj02b7AvbM/nbqmgH5AzPZsET6Xh7WVMH119mnQwFuNs5+xrd8RUbUkWx0BPZ6X6bpl0Lm8fJum9bxuatvkOde0EzTDOJYRAB2PHz76yvAHb3jg/Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278919; c=relaxed/simple;
	bh=usGAMv2iGqCBXUMAKkOIkuRGk5as4/0Zz7sWmBECzTw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EEVuHqQHURCS1WovFLg4r3sxMGxc14edGFA5rpqALGXRhuIgaPGeEQFno8lRmN0fSQjwrtEHlkA2T19wtv6IMoeWJcag3TUuLLpa0bmlI24NlDB8rkrbrjXyYNhfVZVf9M2G/5DeZz/BJX3W1jBd9gE1PzS5XdbtboSCMPi++wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mfqiIyh3; arc=fail smtp.client-ip=40.107.249.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWUOMnd89l8yo/3jd5Um7sXOY6xUFM60Hqwj9YfOCE6Hbwkt70jV99wDJijrBoGe55ga2aNw8fHI33IzJAr4NuoGQxOefcZgXYkmFYQccdpXrU4vSj5TGv5KCuFyxcw6FE4vjpmKZlaWw1szbAJtNzlR/y6TF8n0xRHEagszA/sYSnoorSkdYS1n6L9bNQIurE/x08fEaUtP/8SVbQR+9qh5ijqzoMtxTTqy9WFQPa+NG4dDThycagJor2bk40Fqj9r3ELW+Rn+BflZNg4LSEybKtvKFlygEtVwriAESdLGahp3OuXUFaoJQ02CqszvknvnW0cUKqCwQxyNI/4w1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1uQ5MekJYcNGzwltr4NIu+JKx+tCC5Ht7ocupxms3A=;
 b=b8CubSgs3obvekQ8J/kZVZTI46bHzQdJ/sw/UBZnTaImNQ8eVWUESNvFW17ZGxm9eNvR3S13kQlWNXujNpEdAi1GYIn8xckEgmyp8GiCAUNEDL4EChPhy0HVeNGSIbej2Cg3DocjrwjiLOZ/UKZnJBvp4AlJgfp1K/Na0GgoJDu+/k5lh/yWMr8K2wkAR9PNN3htsyOX4p0F9jbl5FuROtI8NBHORbTYO663PstX/lRsje3oDHXjahhPJuajQV2EZwpdCTb1bMhJ6Or1qGdBlEoNJ6pvq6ofda1UmI/QK/Uy/VZl4xDyYAnetsttu7ENiAgaF6HZOqZXh9y9fALPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1uQ5MekJYcNGzwltr4NIu+JKx+tCC5Ht7ocupxms3A=;
 b=mfqiIyh3Gd4hHOUZUsP09D5uUoYTCzJYT/++IRtohW2YvgBfqmn2w5NL/Oe4J39zSN5Xv+O2SKSH9JeYyQNL1Rwn4sBnPAizN8j8qZuO9rxjG7lujskqQ0gzfkWMy2xES+yKxFhjGncffEEVuUqDJ79Y9LMNeq+Gsqhf6ZKlWDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:48:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:48:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Apr 2024 10:47:50 -0400
Subject: [PATCH v2 4/4] arm: dts: nxp: imx6qdl: fix esai clock warning when
 do dtb_check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-esai_arm_dts_warning-v2-4-879e59c0c3b8@nxp.com>
References: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
In-Reply-To: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713278896; l=1947;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=usGAMv2iGqCBXUMAKkOIkuRGk5as4/0Zz7sWmBECzTw=;
 b=OPajSP5wmUQnitDHC9hxBvyYlbYomGkO3U22Pj5PQwberoY+ReNa+kpTjvUaSWS52N91wmUCj
 Ai4nhovGITHDq9/mK/XV7tLg+I0T0xl9sGJqLKzX4fx+FZP/ZTdJ3xI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: c16090e0-8618-48f3-49e3-08dc5e244b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ojP6co351OV4nRI/LuQOYYeMFW+kH+3gFI8w7f8yU2Tx+NUX6ZEDFUCH5H6Y/6v53SiBE0fOSLsAKvi4kmGzxlAmHYditmMYy7jDsB5XYWfI7q5ai2OTMgvlidIbt3Z3tYLigZlXR1VPlaRf69ZkrhAvq+E3u3n8B3dQfwd/FrE9tbJm8/fjsYzj7+Gw3noL8nnFFBAK4dKuztK4xzN8PMVLkPAKk9JDI1Scsf1Ura4TcMedYo4RzZMdY/u2F8aSaucMU2y49j9jfh/52uJAPd/GH2vLe65UhUWTp93LAwqpHlEWFEuvl61xY5CNNe1vnxmOZLpd0gRBJEUfXH/i4Ybvlp91CzyqdqTpvTnmtWHYQbYcGbcU3Hrs+RYNM/O9IcZhNycaRTj+YT0Nq99dzg8RsxdKi8kjFOjpe6GDoKXNavWMy0NIVK955YLsVbv4cC0j8WdRxaAvJWEl+Kd8nMrPKjTNR8WX9vvaH+YTHVr09cAkNwyuwSUAZDhDwznPEGwEcDLht1W2991S/PEieYE7uf/QA3ORH67KVnSSf2YBzWbAMsrqz7CatgvRGHCk31NKV3HTJ8/18UiAukN3Wtvnmkfdw0s1B1fFc6UsXvfC3/RdVc6pBBQoBxtCky2hoj7jGWnC1qEsDnH62gTLJ2bi1i2HrtSJUp12Diw5gU46ETlwP62Trach+XwEmA7s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDFmTTdwUzJQSmcwbkpTZlF2TFByVVhHSGlEN0x5aXhwZ0p1VTFUSHNBSm1q?=
 =?utf-8?B?VDNwL1hUT0pRb1ptOUJwdlg3QjVFdXpkQjFQeEtONEdIVVRENkIrWU56M0R2?=
 =?utf-8?B?N2g1U3pZek9sb3Q5b3lIejJjS3ZITHBEeFVXSnpXSS9uTG11QnhNdGhuWWZl?=
 =?utf-8?B?WkQ2ckd2amlBUk9LWlJBeVV6Ym82SWhNaFpXYUYxbGNRdDdpWU1pZ1lGWjEx?=
 =?utf-8?B?amVPdTh1bGlUaUJ2T0w4R2o2eW1qS25NTXlEZGlJTGVhZ0JaMUFFS1QwalNP?=
 =?utf-8?B?dmtRTzBMNDRNUkVsRTJEOEN3NStKbU1BVVlVY0E4YUUyd29ucDVMZ0g0cld1?=
 =?utf-8?B?UHlDOE9zMTlkOTFsaDBvWC9qYXlxQU5KUXpId2pQdklWdTgvcEsvc0Y0RW1C?=
 =?utf-8?B?VWp1NmI3SzY2RStIK1hJYjNGOHJMckdYZkw0TkZCT2UvM2IrMGRVQlZnUUJE?=
 =?utf-8?B?YlBDc2RXOXVNN09GUDFxc2E3c003Z04wWk9aWEthS29KRzlWcXFEdnBMQUFo?=
 =?utf-8?B?NVhmYTJJS0JwSHBKZzRjNlQvRXJ6RkVuTnM3cjBkTS9ZMWtySE5qUUExR1Rw?=
 =?utf-8?B?eVNNdWVKZ2x1Vk01YTFLRXBoUkE4TlRvQ09QWDZmY1VhWXdLZTRTQnRuTlFW?=
 =?utf-8?B?TDVHWWFGTEt0QkZRY1RyazlXajlJeUp3WmV1WERTN09sVTdQT2lGRkFTYXRF?=
 =?utf-8?B?TFM2R243NXdjYVBrSWNmOVp4dmRaaGwrWFBQVkpzN3BsOXpZcWwyNkxuZWtj?=
 =?utf-8?B?VDU1OUp4MXowZTk0Mld5Q3FydUdrcFhKZjFzcHJ6R2VIeGhLNi9KOWZrcnNv?=
 =?utf-8?B?Sk1rZEZPbHNjaG9CdGdwTlVQU0c2UFZSbjl1anA5TnRsY3JBUUN5RHhvN0ph?=
 =?utf-8?B?eGxZd1d6Y3k2cXVIY2dNeWxGU1J3dGl6dzRFSGZJNTA0R21VUXFlK0VYdVdN?=
 =?utf-8?B?TFJ2bEQvMjFYWlZ4d3FKVkJmQ1hOWCt4Snd2UjltVVN5YVFueThRSXFuM1ZT?=
 =?utf-8?B?U3ZhVlQ4T2h5SmI2RTZIMUVkWjdyb082aEJOQ3F2VmtOaEd3UVA3dy8zRmdH?=
 =?utf-8?B?SWFVdDNvLzVyaUYxRGhVUmVSSlk3REpBVHVmQk00NmlTdVhIdE1XRnpaUHUy?=
 =?utf-8?B?RFJzN0pSSjNVR1JZR0lDTkNiSHhsa3Jpa2t6WUpBa2Q4MWNsNEsyTGp0empG?=
 =?utf-8?B?K3NBVVZBaFl6Mi95RDZ3aHpZV0I0OTZINmRRV09rTXNtTmZzdlczcmNGRVFI?=
 =?utf-8?B?ZVRhSnUvSWNESS9LdEN0bDQxYzgrVEthdy9mRVpKbERQTWIzbDZCUmJMdXM1?=
 =?utf-8?B?c1ViTXNGWERVODhQOUNaL0xDM2F5aVN0OUR0ZUR4RVJVRFZRLysxVFFiNGY0?=
 =?utf-8?B?T2JXTGFYajJVaDVoY0JBdm9vdDEvd3huN3BSd3g2WlVzWmN2K05mQXI2L3Y1?=
 =?utf-8?B?T2FMTXg5SHZrMkdWQXIzOVZNRzBscGx2UjM0dEo4cXA0OWxHTXgxTFNNOFcz?=
 =?utf-8?B?N3VYTXlQYllXWmE1dlNvcktTVEQxbTNEMEhmVXBmRysrM3dvTnkxYnIxQnd4?=
 =?utf-8?B?L24vbXFvYzNLc1JZVU9zWFg0dmlpdTRqdU5iR0hTSkI4aVRRcG1JYmdtU3pu?=
 =?utf-8?B?bmhXZXpMd0N3aFlQeXNqVzJIOXFjNTJlSGp1ZVlUT1BveVM4TTlNY2lIb0dX?=
 =?utf-8?B?WUtvVTJtL0MzUHFlaE1oeDVpYUJpcE10TEVTaW1KaHF1MWRBaXRvTVVsNy8z?=
 =?utf-8?B?a0Z1bVFhaHczS2J6akRNalFXa2JxdUxHcWExQWcyODhoUFFrVVAzV3ZmMDVI?=
 =?utf-8?B?WHpYWUNSdWh0Vkw0UkZscjRJdURmQVd4ZDdFQWk1c2xPUFJZZ3liekZ5TGFU?=
 =?utf-8?B?b09JRU1hd1lab2pINzVJeW5rU09zNWltUDd1U1o3aXpLTW9tSXkvek0xaVpD?=
 =?utf-8?B?VzM0MWxCb0YyaEduZE4wRGwyOXo2TDlYZkh3RXdEMklXbUVtajRYVWdtWWNx?=
 =?utf-8?B?VVozekdNZ2hUZ0lPRVNwdmVHN2Z3NlpDZW1xQUova1Fjd3VyTU14bzJnTVV1?=
 =?utf-8?B?WWJsWk5nWVJSZXV4QjFOcUMzRlVrZHArZHFNSXY3ME5xcnJTTWNTVkNObTB4?=
 =?utf-8?Q?Y25hRsmp9cY4YZFfQC8Mo2X9N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16090e0-8618-48f3-49e3-08dc5e244b50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:48:35.6375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U8DhVknGdmb1iuBlozxAXXrTPxmIav6r115OWfcmLI/3YJL0Cy8T9m/BJ95Fzmpv9EcY4FsZqaquuqzeG6C3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

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


