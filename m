Return-Path: <linux-kernel+bounces-150615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF18AA1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABCA287112
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137E178CF2;
	Thu, 18 Apr 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VNmOvC1C"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDA17AD7E;
	Thu, 18 Apr 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463789; cv=fail; b=W4F4Z/DJ6u+kZ/ZYJU+90LwfOlAXWy8E4yZhyi2wZ2SVrGGPVrEhliLwUE0JafLzrWNeoywAr4stJPyKwKi5i8/1vAptNwrif2rLBawwsPZNLDRpK4jzobGxtovm1zAJqWTmwuM9jaK74Q/2sR6KkDOnlPQODpE9+6zyIYbuyYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463789; c=relaxed/simple;
	bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p0AOaHhJmfPBBt0nFxGOeWbqohvEyoXMWSTmSzEE57t8sGahFsLJzkwhTkvX4Md4zDboIiD1nDH7HksLBL6SCLkFzKqx46bUKhLqPwVsXNb8En0R7iRH/1pSXXW3tWiLIqEvAiNPo3IYHA9qZXynq4mREpZ5jsB3v7pGr+jw694=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VNmOvC1C; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLuirgfDLPF8N+tZ7hs+A3e08YfXScuwJppBYUHafnIcami9XSxUI/Q2UmbnxUwFH+qhx65jRSxqwczjJjefXZo9QZE3NjCl2QKXITTTh0U+6K911bOqjlKIIfQa0b/W+kUfDg+j/FOVxbuUT5ggKIH5qc2uossDyojlD+xQ8frmlXqnO2m+0SRFuq9os+cjhNfg58BHb8syhrhmUAiuOnqBFCun8A1fVWveVrBHjpUFIlbVqK6bjAOQVex0uc2w+sb1+OjGXyb/rYcEea5reFdgRRKv5bZfus+Rb9c+yj+jKAi03vh0fapOmSeAtXDOk3m+IG73c6ScYOM4C9BZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=QdWVQ9EQ1CHgTTz0PL/w325jZKRYDAdU0iJfO3oPabfky6bvHg+C80h92j3l7QSdTZLgRx2D1jY82AVHgyyCr3hzEmaPXG4Rn78iFOdK9s9ADw7yrKuTj6IS6dhUFNzgx0TEAkBzTAVeRizBbB8gs8caZ6FT9BcLjoUDAgtk7NhQ5SYlpwfYgViTCmpGQlObKBA6qEEif2iYJ39Iz5YFzov8zAaYgPeWJiZhzW/xsQ8m6aGjMRqUmXQI4bu8ZPtRxOQaGXVLKd6orcbfbzKXTzFrVBC4opbhzfeXBQtQPNn1DSsjOd0zjwYoqQ6K+8O/KqAu4WQHpTTcWTGq7WekBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=VNmOvC1Cx/TOqYMO/Mv5OMFR9X9aC2QUSSNBJ52fZ6Mfn+CTXd1NPnVbo0tfvRl6najvyIaPYFlSiSA2oDsnHuHQayXDl+ssQ9b+KOAJ6XcDn0P2GxR9tHZKh/h7RKDVV0vePklDgOgzpsT2KjMe61r4U0RqU9fRa+blAds2Sa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 18:09:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 18:09:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 14:09:29 -0400
Subject: [PATCH v2 2/3] arm64: dts: imx8dxl-ss-adma: update audio node
 power domains and IRQ number
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-dts_dxl_audio-v2-2-e4e2747b3a49@nxp.com>
References: <20240418-b4-dts_dxl_audio-v2-0-e4e2747b3a49@nxp.com>
In-Reply-To: <20240418-b4-dts_dxl_audio-v2-0-e4e2747b3a49@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713463776; l=2570;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
 b=8i/fVYZ38VphStFGXN0OHPMaiwTJIEC+F25xW4LHXtzTeS+m+PLyDHia1zmLyUOp+kMuhjQmO
 e07N886rf/CBvv1QYY3f4W518JcHcPo7tHwhr4qdM7vciSxTz7ubqnP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f9f3eb-bb49-4a76-e400-08dc5fd2ba6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hkT97tClxBzbIDGqxMWLJjUZYomO5mf1KkhIQjo7sbgOYBZmwESMq6XFPe3TOKITwPv2j3RK/8qYdKCSO/0nDZUd0KKqwtiLcd/nbGsVoH8Xn54CgjfzLMKq2LV73rkBjpU3J19p8yGVCsLRsUPdbYfDA5v36YBKSFGYqpFl5FBw1yeVmp/PBapRUGepMUhUGXJ/kffgWYOZpZHbhGxn0maTMQ8YSnWJjTRC5b4Du5kJXqQMUhEQOlsKqUbXGPsRUUltvo5po+WprpblJvweOKe6kYm+UwZdLBMhJWnNSnov3kILD8ZjSVb0I4qKiTq4KJVyeuzoOOdFHhrMg8a4EORzRHk1yJFq0nUjC4F+IxNhnYE/BDQ7sOT7YxUu5CI/rlHMSD+8XKEIC5Fr7E6g4sDi6rxb783Gh+2rweY/lFCkMsMVXhIn0HoiQBMyX7XLZApYZvBMQITd7B0rbyaOV1scTMBoLbLb7xtj+2OiDDatRtBE+CL5bk1VyQVa2TdcH0vOzH9eWrrg4337g53wb4F3H9FjXNH4wnrxVECiLtOVf7iLPXy27Pyltscv0lrJ74EBY8Jq5jxAntx67BJifJFN5RLnOFauJO8u/JIreTdzRiHgn5M+DEPeBSrtp8w2dasogVIz3K1b0m6cpIclu79EaPxRZksJwD9TeoI+b0+Jx5WMGxZiitwRAKljPIBUngCTgQ1zvrbm0WJFDLVVxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJndHFQc0szWWxtZ1lsVVhZczZEeEE0V2U4allwbitwVWpRaHdiRDNORVkz?=
 =?utf-8?B?MncvVnFleUQyYjBuTkV4OWJCRGNWS01hbnV4OGNTek0wV2RZSlg1aDUybHZP?=
 =?utf-8?B?Z1JrbFdqMmU4QzVnS0FjUWtoRHRGZTlVdGlGa1hNRTZJWFpBTmVtenEvdkxG?=
 =?utf-8?B?R28rN2Z1Wk5JV2pHNFd3dHk4ZEc5SUU1VlVMSzhmN2dRYzFwYmFpNmpOaDNp?=
 =?utf-8?B?ZUl0Y2N2YWtWQVppbGJHZFVBYUxxSENsNW5WdUVWdkZydFJOWHJPUElETWI5?=
 =?utf-8?B?RmgrRnUzVUhFb2p5cGY4MC9RdGh0K2RzVTNaQ0drSUh4MXJvVVFhd0pzSjJw?=
 =?utf-8?B?ZTBoUGJPMnhPUDZpSnlxYWpxTlp1MFJnRkdSOXN1Q0VucWxFdDVCd1VLSk5a?=
 =?utf-8?B?M3J6OGV6cGhsMDA5dlllRm5rU2NHbkZidGgrK0hWNG9hWnFtcEE5a0VIWFQr?=
 =?utf-8?B?QWtQSG1uU2Z5aHlHZnRjaytadkhjMThEM0RLT3kzbHVwdnJPS012a1VFWWNG?=
 =?utf-8?B?SG1jbWw3WDRRVUhaMWN6bVVadHZZcjAwa05FZjh3azV5cTM4N1UyNnZ3bllY?=
 =?utf-8?B?MVZ1eFZhSG1IVDhXT0hadVhhZUtKU0RzbnBSVlpKTmNReUJyVjJMRUdBMXVo?=
 =?utf-8?B?dlBqUmZ3MDVjZUJRbHF3bUdRSksrblF3YWJLME01bFlqb2huY0dzSlROdHBk?=
 =?utf-8?B?UXV2SWF6eE1CZnRuZ3dJWTBpWVF1UzAxS1NxRXJjbjJ6eE5FcXI4SWVIT3lT?=
 =?utf-8?B?RFZiVkdUaVBXZlV2QlNpRndLRUJ5ZnN2eVR3ZTBwd2FqWTRsWFcrcnhQWGN2?=
 =?utf-8?B?a3NVTnpBOGc1emxXOUZyZjlCSjl3d0JqQnYzWDdqck0wQ2FZVE8xQVJhR1BU?=
 =?utf-8?B?OGxKa2Zsd2tHYnNaS0FKaGh1bVlQUUNqS0xTMGExMllzRmp1VGRYL1k0V29z?=
 =?utf-8?B?a1I4dEFENGFtRU1RT0ppenA1UU4wZUFWRitGMXpSVTEyUWVtbWdKdVdHS1NV?=
 =?utf-8?B?ZEFoV083NVJtNHd1VEpCcHl1T1dlQnFTVEtxN0pNWXRINnZLbmF2Qk1NY1R4?=
 =?utf-8?B?RndIcDUwVldvWi95WFQyb04rMEhpbnRXdFJ0SGVNeE5UTnJEWnZXcEdVN2FY?=
 =?utf-8?B?c3BDQXdLbWN2SWR4LzNFZ1ltSndGK2NEcTBsY1ZmMkhqUFYxbWw1Tnljb083?=
 =?utf-8?B?S3c1YmwxMExPcnhaZklmUi9XT0Rxd1UzQ3BIY2VQWERuL1NTL1FxWkY0RE9r?=
 =?utf-8?B?Qm5iNmc2NGR0SWpEaC9ySTFEL0lOaHVFTFJ4MDJyak5qYnJxendrWlJuYnhN?=
 =?utf-8?B?TmhXc2hCcmt0TzFrc1dRVE5nRk96R2pScy9VYWlUNkx4R0RmRVkrd1VZdE5o?=
 =?utf-8?B?NmhKMXd1Q0xMTnV5RzJpTnNBa2h3WUtLNiswQ01DbWlXd1pyOWhaOS9BU3pH?=
 =?utf-8?B?Z0xGc2JsM2M3TmdCVnU5NWJ2MnZsckNZcXNPbGdMbmNRcTB2cnlRaFBnZTFt?=
 =?utf-8?B?d2taNEFoK1FvOFgrYVZBaDE1UmUyVDU4NjFFdnkwcTBZUDBvbURnNnhSa3Z1?=
 =?utf-8?B?a1hUbjZFKzRzS08xdXhFbWppWFZLclBTYlpVdkFoZHEwYVZSeVAzS0YvMGE4?=
 =?utf-8?B?d2xEMnB1Wm1sMHR5bEpWNlJWRG4yVVViSlh1Tlh1MFhId3VkTDVsN3FBNTdt?=
 =?utf-8?B?L29GN1Z4SlpZdVVLbnFIQ0NOUmJIVUpyYytLVW45dmwzUy9vdWJhUlRpb05P?=
 =?utf-8?B?dVVyck5tR21xQ1QxaDBGQmNxQmsxZ1dRR2s0bm1UNGwxbzZ1SDFPa3BBN0I0?=
 =?utf-8?B?VkVidFNQL1Z2dnlCZFMwUUFRZllsT2FOempsMlIrM2ZCcUlDUnhnMTlaMzV1?=
 =?utf-8?B?bEhtT3BDWVpiUXRXMUZVZG01cm1XVHFMQU9WLzRoYkllQVFlK3l1UlNQL3lk?=
 =?utf-8?B?V0JZK09EaVJMWXIzY3E2TVlra2dEblowOU4yRDVIZlo1L280VXdHc3VXVTU2?=
 =?utf-8?B?MmhzWm51elhjMEVWNzB2S2NvSlJrL0JPWXlvMDRvTi9taVh6b2M5TmtnVVFj?=
 =?utf-8?B?M09iOHZlVlppR0ZoYThKZllRbzVxQ1FQOG1ETzY4UEZ2YUkxMXpaWDJuaDJx?=
 =?utf-8?Q?iIbvzOWsXduRq9SB0+z/tATMa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f9f3eb-bb49-4a76-e400-08dc5fd2ba6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:09:45.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNJb7C8+zvIRFsBE3etd8B64zyrf5l2m4Fl26c5raQv3ue6kputx+5fByeUUQx8iBEBSAT7J88+zaDL3Un51Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270

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


