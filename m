Return-Path: <linux-kernel+bounces-128703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3589B895E63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CF7287305
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DDB15EFD8;
	Tue,  2 Apr 2024 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XdZp2mu+"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2094.outbound.protection.outlook.com [40.107.15.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C2F15F31F;
	Tue,  2 Apr 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091824; cv=fail; b=tsOiqR+YwelXtNbV4BGRhufocAoIRuWYUNwQVltQBtw+0iczChF5L+a6PPFGCpkxm2xtPRgwzNWai+5ZCEIgHau6S1GRYDmH09Ucgm2+3CZp0DAT1oKa9IWNPFHM6fMpmp5aL/hckxbf5jXY3TOdOe/SMsKiuWec216GzBzdRoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091824; c=relaxed/simple;
	bh=WIh5zNcrCN21FqqBVKhLrd4W6IaEfkdfwk/6OGdozSw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OgYlkmQjhEsvsbp1nGb5A4QpGAr8+E3eJy3y16uwuQPIOG2+H204Z/d6kC8co9O6DXxbXQWtGtrhMngZRF5bHOA/xaNkdJH1uf7tfRhMjs/kYAYkbaZQZMCy9fMlqGZRyQJoH7nQT7LVdMrpc/PJXPzlTg9coJIpso8Gt/gfcB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XdZp2mu+; arc=fail smtp.client-ip=40.107.15.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+7AzFC4Hk6I7MDExhSph7md029bCGuWH2/P6FXJ3g0z88WzzSHu+RVcodW0gcKduxQDdCxqIPQmfT1IEmPrVnrlSJ8Sk7xWggVoV3tYR3dxF7ow+FN3dogcuU9fp+0qfUNWsm7djtSJ6ktLxKu5+zym0Mdepl0KMFk+8VTQl1P3j/0hDmfMwMrpvqsgDVWGPp8D5Ah6VzNSYxsT8mEGEUGgIfDqIy6f/Yqc9AVDFWBkxfbv/UF3+9E03sopEZ5S7Cy8Ko8nMnF+vTNgPUYndyAqblkhruuUFMECpkgkVxtNGgWnLb1nqB5taDoVOpv+2lB7SHngYbpmssOZasRwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQHZ6tb+E+wCAs/bzDDCKaM7n30EXEtYUz4xcT4vdyQ=;
 b=EblrmjtgFa17FrCIYMXIiBFCrApWO2BQc14tatBkwN4ZIXB7UQRMsU/uSserb7DKrCjiV6QS49RAtRsmGjfmp3wINvN3exdVy3dIlhWMm3eeFzlOFwjpk69dbj7BCAPq1HaovoFYWo7T03GDjPUmyL92cz6v+NmEI8aU8npMfykvff7nlRVl4+IsNDmoNIiBaou6DWli33LHdNI2kvYM6JEZESnvPgABXzS4YPo1olLbEDaLHB+bxjWGow8Ew709Yw8nWikuEn6Z1RP1Hkz1eBoH/8jXuIGaeGn/qzWccO8bkWFuXIlzobpUm30Ley/BAljVsWKKCl5UaqBH6a7MxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQHZ6tb+E+wCAs/bzDDCKaM7n30EXEtYUz4xcT4vdyQ=;
 b=XdZp2mu+iKXeGjdpuGWH+WmAgivnuEEYSkXQjrby1wBmpYxfjYgJW0881PxT5jsLyCb+t5zmR9QaqMkTzM/sC65yYBQ3rZGAN7OkgEBBobHE2tNTO8uxsfPeNQA26/gX54wQB9v8XCNy0rBjNHlkEksWER1pYwcY8Q1BgrGYCNA=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6796.eurprd04.prod.outlook.com (2603:10a6:10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 21:03:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 21:03:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 17:02:30 -0400
Subject: [PATCH 3/3] arm64: dts: imx8dxl-evk: add audio nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-b4-dts_dxl_audio-v1-3-d26d25b84a08@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712091807; l=7918;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WIh5zNcrCN21FqqBVKhLrd4W6IaEfkdfwk/6OGdozSw=;
 b=aQ+bwGh8EVhBICKM4AJhtb6H667gk11EhQ7+J6qLn28lJrG9mhERbR82sOJbtugHYqnnO9y+4
 43Pa2VnV8d4D9V8s19vloZSrWB1SxV10G2t5Jb2FERdCCYMsPDf/op1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6796:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yUO3Z7ZD/nkSOqP6CePYGVmEJrTjJau3xV0oNVWxZkymMmIAkmaupZa3fOoOYCgfAZNCBgfc0N+Bp8bZI/tVKfv7UVTVCqj2KDm2RtlMMAvhQJeTYFHngcQksuCRLe7Ubjfef8UsZu8xogzGuiV5Yn/BjnQ0vZSrWy3cBfFGcJAnswKTdJbun97cFYAwI5vmqBsIC6tGzr89M2tvoZcPoSAugNVrc7hFnGbN2eQfToyUl/+gbATxLoTnbxl+w6a3WAstuGXSDDOkNMc0TOajecvndP8WM17wQ6K3oLOn5B/NvZZSGjUZTBlV01x1gTbi5uvmqM18Ii1Q2+01Oz29vti2qCO69WYtBsLZMlkQRoSIypcLEBLXKrF8g2W7oPCSG+UuUDR+PSAirFezVPofZN3dvwFxtPPp3SmufgZ7hcWkLfXccosE/SWtgoAr1ALjUKE5MpFVpSbKmKVKJm/tY6y4n0FcqjHnrNBzhHr2W8dHN3ZtVVgEtqNgO5dEmeUYq7KM7iJcKKkOv3gWy5zf7uIPJmunUy9L9jclXa4bm9jzgGM4e0gLs8SxY5KWuATT2Hb6px9umCxBZ2fibK9Yq/HShSBoNRFu+2To4PaZ2+TvXPTb3E60BqvZuqwm2r9jIqhkzMcpj8Hlck95HyivjuYktUMC8Xk48WJC9OWMhrKeCBuD4i7WI2ZfASMChFHExJzL9puC0yhOfbZ92/OrJUx87J434Sx4LEOHSLqhPtk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0NMZWEyMnBTOHo5c1FUTWRnM2VXTS95TWhJSEYxZHE1RzA4WEpkZldUTDI3?=
 =?utf-8?B?azdGdTBYYkdLWm5oaGlNNUlTZHZHSjEzb0ZyeXp3VzUwQ2VWNkNqdXFFMTlE?=
 =?utf-8?B?UGZGelkxRUZhWW9QS2lETzVzRTR2MlpiQ3JOVlYyU2tJNmp3clhIM1N4a3Y2?=
 =?utf-8?B?bVI4S0hxVnJJbTJJZzFHdTRJeGtHYW1WaGdPaHc4SC8wM0lTS3U1aFlxL2N1?=
 =?utf-8?B?MDVzRWZBQ2RPMzhEQ1RhYy9MVG9MTmlReUNzejJacHFjZkpDdmppK3N4NXZB?=
 =?utf-8?B?L2Q0dWZzSE1UYkFYck9JN2VqcytuWEdqY1NjeUQ1aTdDTzUvWTVuNGNrNitI?=
 =?utf-8?B?eHd3alRKUzJXYXdldlBORGZhNGNvdHhiWWRNS1BYVTlDMWRTeTljbFZ3QVBv?=
 =?utf-8?B?eVE3SVJFUkk2bThQbngybjFiRGI0Z1BaY3ZHQzRnVS80TXBtM01mUHpJUGhi?=
 =?utf-8?B?S1dycmRmTnVOMkJRUG5WM3dObXR1R0doQ0pPSU9KQ1JTbENaZDBXR1BzT0Yx?=
 =?utf-8?B?c1g4blMydWJhM09zUEIxOCtzN0UyZHpZK3pYaVBNdC9LQ0pmNTZoNjFNTGIr?=
 =?utf-8?B?d0FRS3lPK2I1U2RoRXJ4dVhoL0lDOUR0cTJQZy9abTF2N053aHZGbkRzUStY?=
 =?utf-8?B?Zms5d3ZwamxJVzJDcWVUVG1qbHU2WnJWZldTcE9ybXIvRi9MUk5NVjVNQzJ4?=
 =?utf-8?B?YVkxY1hQR09SaW1tUXAyMVJaRngvU2RNakZld1VPVEV0NjQzc1BrR1JsZjh2?=
 =?utf-8?B?YzhIS0hreG1NdnZYeXUzcTFmMHNlN2FwU1FBOTRkTmpUdFlsRWhlcnd0VFB5?=
 =?utf-8?B?WWZCb1IzaE5DRTZNUEp0d2ZlM2luZ3kvRzFsZWUwTXNrSmtSWVhybk1YeWUr?=
 =?utf-8?B?RVZCcUZJR0s1MitBZjhoKzg3R1pub1BKdGZJbWFPdFY0RnpndUxpaHJManJF?=
 =?utf-8?B?RGZSV3psUlA4enIvQkFTUzZlSGc5SGowMHFYRGhMZkNQZjIwNSsvekF0aEpT?=
 =?utf-8?B?VHI0OWNvb2hUQ3Z2NDFVUG0yUEpVczB1bC9kcGlVVUhoQllmc2pZdzliNE9z?=
 =?utf-8?B?NkZ6WHVZYWpTOVdMZW5sUFIwZnZnczVkY3UwVTRDOGgzaGkvOGk0RXlKMGlF?=
 =?utf-8?B?bDJ6TlYyUW5WKy9IVWVpM3NWVUdpdjVMTmgvZm9BeVNPWFJFUlpxcjVCbHF5?=
 =?utf-8?B?MlNHZGcyNStGbEhaaDhPQWR2OVN6SjRRaUtvNlY2Rzl4eXVBbkdBbEpRRjh0?=
 =?utf-8?B?MGlmOVdaZVJIdUQvS0drN0VCazdJL1RSM2JYSkIrYzVBMUgzc2tGdThPbWww?=
 =?utf-8?B?dzlUSDBpR3AvVk1SYW83TndOeW1CRVROTlBYVkhiM1RRZHZ6Wkl0RW56WWNS?=
 =?utf-8?B?MSt3RE5FdDd3aWRYT29wdEE3NWdGVy92Uk1XU3ViUXduRkZuQ1BzOElkK2dG?=
 =?utf-8?B?b1JzYThDVGN2L3ZmbE5MRURZeGpMbHBMMVFRdk5WZ2EwSnZGSldLRmxRVHNm?=
 =?utf-8?B?aitTRGp4K3paN3JWTWdpTEVVZFNhSWFub3ZHTmhJT1hrdW9IeUt6c1o3dlVh?=
 =?utf-8?B?WGNtVnhWa3c1Q0Q1cUdRVlMxNnBnVVpwbytqdktqYjl6UWtWZHhMTFk0MnVH?=
 =?utf-8?B?UHZTTk1sRWxCdEluM2QwK3Y5Tk5MazI1RDZqVUtaQ2h4NUpjUFMzb1BxSndT?=
 =?utf-8?B?enJMc2xtOXBlaGcrL3NaYm4vWEFMa0w1b09BWlN0U0ZCSHYyZFBvbkFBTzlS?=
 =?utf-8?B?UVVzU0N0ajF4NDVZVzdyU21CUG1VMDlIZTVtS04ydFJrK1AxckM0aGx5TDFr?=
 =?utf-8?B?R1Z2cllrM2ZPT2QxOEQvRE9GUndEZ3BSalAzWHFISVBVOVkrVktMZzRpREhJ?=
 =?utf-8?B?TXY1b2hOQ1ZFQVFVMDc5b285dDd5blZyYlVUdXIyck1mN25ON1VRbHRvWllx?=
 =?utf-8?B?akNhU21Sbk1rQVhEaXpsWjkvRWtnQXNidHpUZ0NrSGVaZ0tvQmJLTHlFdC92?=
 =?utf-8?B?Ymt0ZmFWanJMZSsxdzMxTDdXYXJibFVHclBMMDROOVNKWnRONkRDbU14ZDRB?=
 =?utf-8?B?Wkx6UjR5ZC9FUk1JYndSWXBQUVpwaHFLd1pJMFRXRkRhdXA3Z1k4NFo4dGV6?=
 =?utf-8?Q?a97mInZDpXo1KSzKfROqaaxkU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc23d36-ea97-4572-5975-08dc53585efb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:03:39.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHYtWSdn8yt2RFF+IyA7xml97xCS2U+36F8dejMCtKdbvX5wdDWNSCRQmVcsBdYVhJXu+SwlpMeY0Bp6lwtATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6796

Add audio nodes for imx8dxl-evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 234 ++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 2123d431e0613..ba4cdc3534362 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -125,6 +125,81 @@ mii_select: regulator-4 {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	bt_sco_codec: bt_sco_codec {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai0>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
+
+	sound-wm8960-1 {
+		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960_1>;
+		audio-asrc = <&asrc0>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+	};
+
+	sound-wm8960-2 {
+		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
+		model = "wm8960-audio-2";
+		audio-cpu = <&sai2>;
+		audio-codec = <&wm8960_2>;
+		capture-only;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+	};
+
+	sound-wm8960-3 {
+		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
+		model = "wm8960-audio-3";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8960_3>;
+		capture-only;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+	};
 };
 
 &adc0 {
@@ -132,6 +207,11 @@ &adc0 {
 	status = "okay";
 };
 
+&asrc0 {
+	fsl,asrc-rate  = <48000>;
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -259,6 +339,78 @@ max7322: gpio@68 {
 			};
 		};
 
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			wm8960_1: wm8960@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			wm8960_2: wm8960@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			wm8960_3: wm8960@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+			};
+		};
+
 		i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -362,6 +514,53 @@ &lsio_gpio5 {
 	status = "okay";
 };
 
+&sai0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			<&sai0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			<&sai1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai2 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			<&sai2_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai3 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			<&sai3_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
 &thermal_zones {
 	pmic-thermal {
 		polling-delay-passive = <250>;
@@ -595,6 +794,41 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8DXL_SPI0_CS0_ADMA_SAI0_RXD		0x06000060
+			IMX8DXL_SPI0_CS1_ADMA_SAI0_RXC		0x06000040
+			IMX8DXL_SPI0_SCK_ADMA_SAI0_TXC		0x06000060
+			IMX8DXL_SPI0_SDI_ADMA_SAI0_TXD		0x06000060
+			IMX8DXL_SPI0_SDO_ADMA_SAI0_TXFS		0x06000040
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8DXL_FLEXCAN0_RX_ADMA_SAI1_TXC     0x06000040
+			IMX8DXL_FLEXCAN0_TX_ADMA_SAI1_TXFS    0x06000040
+			IMX8DXL_FLEXCAN1_RX_ADMA_SAI1_TXD     0x06000060
+			IMX8DXL_FLEXCAN1_TX_ADMA_SAI1_RXD     0x06000060
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			IMX8DXL_SNVS_TAMPER_OUT3_ADMA_SAI2_RXC   0x06000040
+			IMX8DXL_SNVS_TAMPER_IN0_ADMA_SAI2_RXFS   0x06000040
+			IMX8DXL_SNVS_TAMPER_OUT4_ADMA_SAI2_RXD   0x06000060
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			IMX8DXL_SNVS_TAMPER_IN1_ADMA_SAI3_RXC    0x06000040
+			IMX8DXL_SNVS_TAMPER_IN3_ADMA_SAI3_RXFS   0x06000040
+			IMX8DXL_SNVS_TAMPER_IN2_ADMA_SAI3_RXD    0x06000060
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041

-- 
2.34.1


