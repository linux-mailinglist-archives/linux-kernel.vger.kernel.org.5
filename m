Return-Path: <linux-kernel+bounces-100734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6D879C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AAA1F256DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA9143725;
	Tue, 12 Mar 2024 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OGvTaPMl"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2122.outbound.protection.outlook.com [40.107.105.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B814265C;
	Tue, 12 Mar 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273438; cv=fail; b=Ngt9zere06HsQ24jB139GM+yHqQLO9J8cLN7YoCWdK25u8PzFTFs5KJAJ38iENbrjW7smy3EdNMBmige/BrQ2gGR0hT4seVPhnk9daaSfkG59VwN2zIW5uR5RwSsNOJvvqhIcIYIhgpNh//RI4xq90lha8HzZq6q418sQIxTOek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273438; c=relaxed/simple;
	bh=jVqEsw5h+C80ny6yrFTg0GegObQN1BXDtQEipHRaITw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HAal67EoqI4MKP2xUogDuXqSBSS9XWPgBHjqxT2m9eqeRcaZXyBsxqQf3Sjc2sFiHPFLUW/796KzUqSMnHgxfj77SEmx8rRPVvDgCLlHVl83UeDHHBOBz+g2tj+PYg7UB5bOpBLY8Cj+lVSlcx3W4zCn6EVVKjE9KNiAsBCITcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OGvTaPMl; arc=fail smtp.client-ip=40.107.105.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc2UYhbxuqWKOyyZJ1c151DUNwiSVdK4XQ0jnmpPAduung3RZGiQo/R/O0xgFRS8bfWy3VewPG4e8IK2gvsP2wBCfM9uuxz1dPDZGE8n4ilextK8v8OGHw77zhrehmIGrv7SU9iPXit+IAoT3WHSjPtoghK5/U+DQlO13y3y40tlAH4aO0zjpG6+/aWo4lF9NurANrgh6uz9i+4/vgMJEG0DimXax2teCFEn6oK3nurngP9OvrXUUxI+w0oc/pBfgjo1NwXAzmvdijS/fdyogEHcF5d80vFcdJYC5nj/vo860KyXAhNilZE4mc0BMc+NZ/OMsZ8FvjROz3XWzB+Hvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fB/Ot8Z4OGSnAIif93jvdZ4uDc+ELNqtntQwPIuwNzI=;
 b=c00Nl/UjCGs0XZMVisccGeqEWy6AWWaL071GzAj3saG4c7jYDH6e21/IXTCh9V7q9SMxMeNLiYrff7WAC218fmZzCtnhTpz+w9KIMmn58Fn5+iDyKvMcM53m8eTswCW1nqOBIWYmaWV6xD2b4psGg4KaaxYoYM7B/AvQi+8j7P0IoHdl6Uz8CopsBOCW9kPOVVeaRX/qHWUahvJeJikQP5qzeFuvDiyE1cMhrqtegwBETGYJH6towvsGG2nt/L0qn6B66cHoxTbi82a+HpifDioAsiGS5kendvwURnjqMuKBbmdzDpURxIygKPhIgK+BCvwBS3nQuPjwWTuBpdyUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB/Ot8Z4OGSnAIif93jvdZ4uDc+ELNqtntQwPIuwNzI=;
 b=OGvTaPMlNHKdjt3lW+8ylvmHiGi9TOAqXaHMGNE8/z9TFkDK4nr2dbrFIHMrzSAjBunRgYuJPqXr4NRnzEABB4ralAzNCfnz0uZ7HeB60y1FFdqPDLtdFTXQvMO7WZblbGOZMSxsbiNPCGKxr/HWqMB+7GQ3QaQJucngqV5VEPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB8601.eurprd04.prod.outlook.com (2603:10a6:20b:438::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 19:57:12 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 19:57:12 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 12 Mar 2024 20:56:54 +0100
Subject: [PATCH 1/2] arm64: dts: fsl-lx2162a-som: add description for rtc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-lx2162-rtc-v1-1-1f4cd431b1cf@solid-run.com>
References: <20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com>
In-Reply-To: <20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM9PR04MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0da541-23f7-4543-0957-08dc42ce9bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jv+P051A2Kby5K0foRH46qwXcjyLuUYEohmqEtODAtHWp6cwBlISHUqkq1KNFxgRS2L/PtKLkdT21yxL7dkB6AQTpWQFZvLghTQMa1k9WHaCYxh8bbnM96e/XOQytIe7801q1XKGbEVW3dLv7CxT4YTGY5KiCWV8jrT4gI1uI6HkJrjgWs4m8JHolxns7vP2FYa4vs/wmxV7OIC1rT4LzbEMyQmqfKx4++QRBwZnLn1Gv1hfMs9gqnS3XxYvs4fmyWEOy42qym74ftjEM6cBg0gFDA4yw1YF5nbDJsrRpzaTNbZiG5PxvZ967fFxSB/mhgJSaViAsyl7Vtf6rqFwkaeba5Wh/FTG4amTqcqbL92xrsxNQzcE5uIeOmz++WkV1dn3PYs2VhNGRTaADJoMz4jTh/VrePlehsaToUIbQ+r8rceD/pzgzf6Mzw/ShTQGsQXyNaL5dvGGtnBXZNV67A9vi/bM+GOGLxkY9OxN0t4VM0Xxu/BWVMiCybStZA9oxW891lMOYLBbG4H89kzRJYCr+BgX/Q7Pnxuc00nJZtMEpBgZ31xctUMywJ6QkZHt0q+SacTaeVgluPPpqF+J8jq4kdSLehUDgI7lU0TIlljZ9svlpgrefihzRoik2430KE1pHzi3ZhwRmgtr20vvHbL45jdY88Mi6JPZKTY10qA62vNyiPNpbSImUi5HGddIDYGnUgOpF06IyNs36tsF5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXg5YnpFblFLak1ia3pMR2dyT3lZVkVxaGZBSFU3MHBiS2oycDM4VmY0VGtn?=
 =?utf-8?B?cWlWQ01SN1lPY0hxZk0yUCt2aGJza0FpQTQ1d2RyTXU0c0RyRmFyS0RkdWIw?=
 =?utf-8?B?NTU4ZXp6K1k1TWNaajFzT0xUWE83NFpHa0ZoY2lSY2lYUklyc1d3VjNVSm5v?=
 =?utf-8?B?YmdtazZoa1laSlNGaWcxakhtaDJrMGxiWWQ4UjUrUjdFemNOelNDR3Q5M1ow?=
 =?utf-8?B?TGwwWUpXN2NleXI4VG9PaDZqbHQ1aC83WEVjNUNqaWplWDV5TTkvdEdFbVIw?=
 =?utf-8?B?dTV1eTFNNWl5TS9jcnBvaHU1aDBIcFVyUTF2eSs2bVV1aVR6dVJXNVAyay9q?=
 =?utf-8?B?bnFhQ28wL0RGWTl0NEpncllYUWtoUUUvK2xJSWthTExVcjRGL1V5aU5lalBi?=
 =?utf-8?B?MmsrTllHVEhtRjdSTGlva0ZhMER0cmNEZU5YNUJQekpWSi8xU3dLNGozajZP?=
 =?utf-8?B?Rmx6VmF4dW1tVUdVbXFwTk9yaVhya21NemtLc2FIWFVRS083UHphWXNZM3BE?=
 =?utf-8?B?L1pIekJTOEQ4NExNOUx0aDBhdzlpVVlSZkwyWWc0cDJjejBSVkZtaWNCaTdS?=
 =?utf-8?B?M1V0YlEzNi9LOUtpZGtTSnVxb2Rxcy83THcwVHhDa083OFdvVllKa09US3Zs?=
 =?utf-8?B?ZThFZ2Rmc3ZQVEhiYmtKWk9VRkd4NndDeGVSRmdHUEZ3S3B5d21qV1dEVy9C?=
 =?utf-8?B?QWlxNm1kbVVZSk1Oaks1ZHdLa1JhS1Z3SS9pR2lSZ3BpY2h4cE1nSHJMZXFJ?=
 =?utf-8?B?QWNyRlk5cnZITmlTa0ZUNG9jT2RLR0xpblJDSFMyeVE1eFhJNHdjclFXdk9H?=
 =?utf-8?B?RXFQWDNsUzRRdmo1SFdzV0U0NWVwS1RMTVUrMk1wV0VKRTdDREs1VU1QS1Bh?=
 =?utf-8?B?VDNBRE5PdndjQWNCMmcwcFhYc3NkZDJjVnhieU5LZkkreWhoclRxUXd3eUlx?=
 =?utf-8?B?OW16UjVtTktPNWVoYkRBbjVTcmZsblhVWlJzajM4QzMxMXE4M24yK090TWVM?=
 =?utf-8?B?enB3R013cWNJbm9xMW1FeUp6STNGVG8zOGdQZUlCUG4xTmdxNEpCZTIrM2dn?=
 =?utf-8?B?YXpKVGJFZG1qSnZGTDdpM0R0c0wxZjhuTGhQK2s3RWtFdk1pREk5aXFrTUls?=
 =?utf-8?B?UjRmbFZrUlZyVFhHaG1HTytzK2VRdzJqVEEwNE9UaTQyUUVmalNXdnhnOWlh?=
 =?utf-8?B?NEFsNmhPbVpTRmE1Z0NTeW80S0VlN00rU1hGdGhJSG9zNnhMK1NBUTQwdUcw?=
 =?utf-8?B?S0FUUW13aGJSOHdoMlFDMlQwM29vT0c1Kzd6ak5zTTBEazJMV1MrSXhLeElr?=
 =?utf-8?B?VEcyOThoNE9icVl1Ri9Ha0FXNHlpalJtL1pMOHlQbEVSZGwzcXBrVm04dnh1?=
 =?utf-8?B?MnpNcUtzM2lYSTl2czVMcHVrSHhZT1ExQlZKWFU5MTZNZXorNmc4TjZ3a0Nl?=
 =?utf-8?B?TjJuN1BKUk1kRnV4T2F2Zkd3ZkJjSjRnRll2T2pXOTRtb1U5ODViWWhnZFNy?=
 =?utf-8?B?SjhIZnBRRjVFSUUzVWdzOVRUMmhZK2QwUU56WUF6VnVwb3pNNys4NUpkN3Iv?=
 =?utf-8?B?RkJDRmhsY2pHYk5BM2hkRU8zdThOOERDV2xJbDBXaGUwc1J2SXdzNVpTSDR3?=
 =?utf-8?B?RHVJakZ0WmJGdUZ3a2pXemFCUlRYSDl1QlI0c2YyM1hqa1pEU1U3SkNSWUZh?=
 =?utf-8?B?MFdvRkZlNGZ0Zm1sQ1lwVkpJTFJwS3JMdjNRbjNVa3p0a2RJZlFiS2o5Z2dL?=
 =?utf-8?B?c2xzQ2RqblY1WkhDUzRDQkdmQXpFQlJnaTh1OTdUdGZML1pCNXJ0MUxrU3JJ?=
 =?utf-8?B?OTlneDB2WHlUQjAxam9BdUlEdDcxT2h3UHFqaEdkRllubHZ3NjlQQ3BqNURG?=
 =?utf-8?B?V1cvc0Q1d05zdUF4ZWl3QU9OL0dZQVhMaEpsb1kzL1ErZ3Nyd0VPZFJDNEVn?=
 =?utf-8?B?WGpGWXJ5RmtqSW5ieURwUHlIYjVYZXM0TzBOQU5xaWowY0ZwQ2REK0NJTzgz?=
 =?utf-8?B?VnRVZVpOc21zUzUvRnI2NS9oSlArcEtCbjViam9XRGg3QjRpV0FoamxlSDFM?=
 =?utf-8?B?ZHJLYUpSeXlYd0dPN3NxVHFzOWNyVGIyME9TM0JnWXpqd0kwL2l2ZnllaVlu?=
 =?utf-8?Q?8gfvWDLe5RSHJAMw6/KE1a2zH?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0da541-23f7-4543-0957-08dc42ce9bdc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 19:57:12.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knU0T7ZHrjOP442Augvsp92h29uqVrIGPFMjk2rAUPTvk7RKjkpHNCoronnCddjvnoELjQoBBmBX2WDO+RH7WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8601

SolidRun LX2162A SoM has an RTC on bus IIC6 (dts i2c5).
Enable this bus and add description for the rtc.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
index 0580ea30cfbc..e914291e63a1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -71,3 +71,12 @@ variable_eeprom: eeprom@54 {
 		reg = <0x54>;
 	};
 };
+
+&i2c5 {
+	status = "okay";
+
+	rtc@6f {
+		compatible = "microchip,mcp7940x";
+		reg = <0x6f>;
+	};
+};

-- 
2.35.3


