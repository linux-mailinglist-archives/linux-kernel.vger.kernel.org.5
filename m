Return-Path: <linux-kernel+bounces-150507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09E28AA042
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396AF1F22D56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2E171E41;
	Thu, 18 Apr 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MeJ8IAGA"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6C17994D;
	Thu, 18 Apr 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458241; cv=fail; b=kUTHN44KOsX7pLQPE7tjAGv8O39aHC0Txix8L1XquxuBqJymvJwIDEpfOmmWSJKugI3ZRbLdIv64olw49Vn4nNEbMcP9mSbHp/IFoCDBP4OJ1yFfWBU/O+rNO8Wwqnt4F3X+y5BMazz+uWyNSVIFcwCM8c/4U01myoB3Qyaz6oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458241; c=relaxed/simple;
	bh=U/DnG+FGcXigMnyuuG1EoDI7itzwetaHR2aYuCsXZng=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g1BmpevgfR2ua1m4hs9XsgLlLSgEspSLz3AN1I0l/GOq2v/6wZDlaKUkUReiOEkKT4EZL3E6ETG3y0mhJoAJ9THqHjcsKODabk4BzhDQt79sjwlyiQ30ie8t2Bk6LZfx2l6tamUIIGQzMtFDDr5yWw/9ZK7/u2zwIWX9TBMr68I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MeJ8IAGA; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeZhLA5Xq9oAQ7xQwG3mlUKGRHubEfLfpNZVShdQ7LUUmYN96PSOsVV5FppNyL4zuSJFYrQENZCMbh193q4nR0hbBJUGBb51xH0lNDGQIlpM1bZnfjtcAvbEqicJwsiznMhhbW9noF/e2zkVvt1g6+TwK14fgHX/keCh2AMYQbuBoR7Bi1tGBfZHqsbtejlLdLp63J8TU4PiZLDDVrj1fjirG/N+9qvCLikvKG61m8hiIcYa/D1yFVIOjG8hCfdq+vnHM9E0Pqr6Oil+4XKMBnfcGVPM0MS4M2hGmFhhl88Ro/rmrwIAKTzzCEOH4ZMKyJEZK+qcUYEm5bXAcz03zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZtRRCqhXVCDe2q5J7khme35bBWcuz60jNui5paDWqI=;
 b=Tj08BUhBlS4S7A6jOJlPDwlKTTukMYAxqWozmeezoCMSCoH6Dc23v68XgVtJ65UwXINkopmORRKcw03NgedisGztLmxe3PTS5vpOjxPiYe3b5wU6Yg+Dev/SvKzNyIT/8H1Wi3ZotreOUwtH+o4WgrZSiv9y8mOCzgy0CzP9MxZsA8HLyoMJ2Js6Xgejlwhqbgqr6UTwBkIwrmsS2gvkxSEZM/9Lv8i1mzP1EGAOGfZVR65/znjq9rj722lr+NIdM39KCKc9EWEAcLdTRZZQkQSI4OgXa3lCRhvz0Eord+sszQaPfrHP13tc5pu5KToRse1hCIpClocBWD8tGfnuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZtRRCqhXVCDe2q5J7khme35bBWcuz60jNui5paDWqI=;
 b=MeJ8IAGAEjBgkShqP+0zWKcexwgoIrBFzq9NKRkmIGt3ncu0xfWlM6doIoY2Q+gxEkNNC9dpUS/M6OgqdbTafK8IKCqDWAhGEpRW3+bWA3dw3W5V1XMlEoT1SEIxfSc2EzHjteaSTEMeIbjpfeDkoiQqRTbCKS3yAjdPY682i4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:37:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:37:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:42 -0400
Subject: [PATCH v2 07/10] arm64: dts: imx8qm-mek: add flexcan support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-7-e40fe76b60a6@nxp.com>
References: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
In-Reply-To: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=3123;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=U/DnG+FGcXigMnyuuG1EoDI7itzwetaHR2aYuCsXZng=;
 b=Fe9d02z0ySmdG2QLqcnTlAWmptppsP2xLLLPAIggcGzsPKIqQWjQPdJxgwDsIl5fGDiCAPbuS
 hnBAdFVr0W0BQcuwib7ws+S2goVKoIojw0so4cjO8HQ+c0sa/27duU8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: efde89f9-82a8-44d2-7e44-08dc5fc5ceb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7TZHObl2nZWomF10wpdAIMe38mNVc9A8Suy1RPwnnUeFJRi0YfSD3+pHGzNF0rRCKtIVw6aR0ZuAA85y5sMiBMLJceG0TXBuoN5es5ycvIsEAuEsTLMyKXvUv2GIHoaJYu3ITtgskk6JQzE95u+i4LnlpFdnupODfyPXq6XsRdUL/QOCHZr9WJAYqHip1u2RierTDK4CFyeVRd19C7JmnOchqRSRj8eyFlykQabG/FV9JGEt2T53Kue3HbL3IrTtoUftVKtEcVpawayZHW+/s+Wz0QQFdvjzRYeY9gwdTGICqwzmV/rL8K20ZHlpxkzl5WWTK8CZUpOtkCgC28ID8DrVL+GbmC7Mu5PCZneLqMYpT43B5IqQwWTwoWhCUb7aO+NAcLWhYyfPoYgN1v7yltmRyP2zRj3iQWj4NoxbEomvB4lZXI7z3GjitVE8J/yyFRNdUS3qX2vlyI2paA5nTU4Suf/f682UE1HAiB025xJRz+2r2BksC1OWtnFYip1kb+M2gL2Q1biVmMXOytyO8+/oEIoTZn9omJBNefcywyvAFDKKA8tl0HsjGBSaSXHPh8kFdIVH7Mob+pJFpSPG6G2gWCdh7GSD65RTUoX6r1H/7H3iOIA7ujfBHLUfVOtw4hXP7WSJUfrtM+Mr9Zr8DwUrcumCp+DfD+3Z8idW9U9Fwij+RXYDgZX/+3fcRbPeE0RA9vSRGcrMwR2/SuF2Dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFJ6UTl1NGxERm9iWnR3d2R2T0R4K2gxQ2EvNzlJcGlnOVlFbVhGOVBneksz?=
 =?utf-8?B?ZTQ2YnNGQW1RNTQ2K3ZLZWQ1UE1CSE03bDFKbE5GU213MXRGdFhsNHViQ2Iw?=
 =?utf-8?B?YTlBSStLRmRCQ0diZ0lNRXdaaDNlVm9kSjVSYmlESFVKSG92T2RsY0FvTnl4?=
 =?utf-8?B?UDNaSGdnUElNTHovV3Fuc2lHd2RxMEIvQnVGWmp5VnhIZExRQms1KzVRL3VQ?=
 =?utf-8?B?azV1bXB1SENWMFByWisxbUJxbEZNbFVmWjE4SnY2d0FPV1JNTHEzRU1SQWxM?=
 =?utf-8?B?REhUMXV5UGRsZFhNczROT3RpdkthNFYzWGM2QksreEhSKyt3MzJnQTk0Nmc3?=
 =?utf-8?B?bkFFYVpQSmFrK056WlhMSTVHN2lIeEJiaUhITytKRlpXK0dwSDVKaTNsMGFz?=
 =?utf-8?B?Ryt3eWpEaVpoWi9JSkF3ZDI0Ri9HZTI2VElFaW5pTmIwWGV2L2dTTk84a09E?=
 =?utf-8?B?eXRPQzhrQnVPNTlWTk0ybXlsQUQ1Z1hxYUJMN1p3K2lMbW5NR0kxazkyZEFy?=
 =?utf-8?B?enhIUncwbmRQa0VHMms5aXgwRmg2S0hjMUJ4UEM5cXg1OFkrakZFR0hXQ3BK?=
 =?utf-8?B?T1VKcHYvT0xZTzdtaEp2NldybGVmamdZV2YyT0tGYW5hbUIyL3NCanhsdWI2?=
 =?utf-8?B?RWtlQll2UWxISDJIRmtNS0JKQ1NHNzBjR3pQUUE5V0tldldOaXovMmtyK1B4?=
 =?utf-8?B?Z1FlWW04T2dBNzVMYnFCKzM2cDJtV1lvNHU3SzBtNTNlL0lPOUUyemYxKzRo?=
 =?utf-8?B?MXE3VENPTzNxYUlFaGN0c000MUJaSitDRGZKK2F4T1hGaHdKcFdXb29CcVA4?=
 =?utf-8?B?alBtNmFDUzR2V0EwbUg2dTZpNzF2VHBRSWZXbjU2RVFYeVp6c204bzU4M0hH?=
 =?utf-8?B?ZnhPNXNlbHRmYUEreFNxS05OSkV6TGxqYU5LY0Fic2ZmSUxyVnRnbHc2KzJT?=
 =?utf-8?B?SXZYbHQvRVFHbnJ0MWpBQ0Q2UFBDaWFYK3NPS2VDbnduV1k1dlRZajloNDZj?=
 =?utf-8?B?cExubnZ4YU1RUjB6MFpHZis4cyszWmFTVFFyR1ZuSkwyRXo3YmZWNXZ6WG9W?=
 =?utf-8?B?OVNkUm04OEMvTHpidFlXOE9NeXM4UVBOMU9kZUxUaC95T1p5ZnkyV2R3WGtP?=
 =?utf-8?B?eThKN1Vnd0J2USsweWdhaldDWVVLRlNjLy83TkI3QklqSVlRTWNnZVZJb2tI?=
 =?utf-8?B?U1FCeGpMM29YZmx5Q2hRVnZwN2JFS25ydU1ndUVHdUFFZlNlWmlOVVc3VGJ6?=
 =?utf-8?B?ZGJXUnAwRmxyYm5GTFhSVlg1b2o5dTAwUjdwTDRlbFZOQVIwOU1TMCtZV0Rs?=
 =?utf-8?B?NjZDaXJ1cUhOSWROYnlrQ2tUV1J3T0R4Q3V1L0NhY2FHK2I2cGF0YVBNZkl6?=
 =?utf-8?B?SzlhWWFVNVp0dzU4MTg4b2Q2T2g1eW1tN3hPVi9obndCTUFEemlFclAraXVY?=
 =?utf-8?B?VHdJTmhCdWhndXNmMnJtNUgreEtyRWI3OFFMdFJlZldJRkErUXo3VUd5V1BI?=
 =?utf-8?B?TlhGRll0QWEwNHhCUjc2ZFhNUGw2Y3lKSXgrNXZESmp4dmZ0SWtXVUtTVjR5?=
 =?utf-8?B?cCtQaFpzWmliMDdhYmpZT1U2eTJHNTYrOVJ0Y3B2NEs1eXg5WjNVVXBQdjl0?=
 =?utf-8?B?RnZ5VytKUGpuNExHWThKMDNXam5PdWhFNTU4US9RL2Q1elk0OWc0Nk1sMUxt?=
 =?utf-8?B?WVRKUzYvODhPaC9aVWZjYVIyV1hFVWUwQmpRejFQZkIvUUlvTGtGZ2x6TU93?=
 =?utf-8?B?d3ZBUzV5S1oyM0Z2bWEyQ0sxclh0ZCtvZGNxOGVZc1BSNE5jQWNTT29zcjgz?=
 =?utf-8?B?QVlRbnMyZ1ZFWWpvMjJwQXgrZFhKQVVkV0FqTjI4UU5OR2tnSkVmOXQ5QW1k?=
 =?utf-8?B?cjlmUXZVb09iTjdjSnMzNkNvM3dYc1VJUm1PMzN3ZW9BYW9HUmVEeXhBN3Fm?=
 =?utf-8?B?YlBkZStjY2V0aHBKTXRDWDB1UWZzTm5zdk1qdXROQnNZWFBpYzJaWE00a2J1?=
 =?utf-8?B?ZjhpYzQ5MlRHcnpUT3Z0R1B0dzhTdm8yeXVCRy81TDRRL2Zzd2l1TlVYOWNH?=
 =?utf-8?B?bXlHMWZtTjE5ckxaU3MrUVRncVErMFBYMmpoQy9kbmV3blNyMzh4MStJT0Ra?=
 =?utf-8?Q?//D7sDCgrCfAqLAn2aRI9Fbng?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efde89f9-82a8-44d2-7e44-08dc5fc5ceb2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:37:16.1647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81ZHf7eb/GR5x/7p6LYjBLpAObJWH8gXKYBX8texygn3jSupKbTxe0nI7VWe3vmrW6m+JqkldkdFqTupTRxoyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

Add flexcan[1,2,3] support for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 765ff15b16410..068bb77ed08aa 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -40,6 +40,44 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		enable-active-high;
 	};
 
+	reg_can01_en: regulator-can01-gen {
+		compatible = "regulator-fixed";
+		regulator-name = "can01-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can2_en: regulator-can2-gen {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can01_stby: regulator-can01-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can01-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can01_en>;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can2_en>;
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
@@ -242,6 +280,27 @@ &cm41_intmux {
 	status = "okay";
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can01_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can01_stby>;
+	status = "okay";
+};
+
+&flexcan3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan3>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -434,6 +493,27 @@ IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan0grp {
+		fsl,pins = <
+			IMX8QM_FLEXCAN0_TX_DMA_FLEXCAN0_TX            0x21
+			IMX8QM_FLEXCAN0_RX_DMA_FLEXCAN0_RX            0x21
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan1grp {
+		fsl,pins = <
+			IMX8QM_FLEXCAN1_TX_DMA_FLEXCAN1_TX            0x21
+			IMX8QM_FLEXCAN1_RX_DMA_FLEXCAN1_RX            0x21
+			>;
+	};
+
+	pinctrl_flexcan3: flexcan3grp {
+		fsl,pins = <
+			IMX8QM_FLEXCAN2_TX_DMA_FLEXCAN2_TX            0x21
+			IMX8QM_FLEXCAN2_RX_DMA_FLEXCAN2_RX            0x21
+			>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020

-- 
2.34.1


