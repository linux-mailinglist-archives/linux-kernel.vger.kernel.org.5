Return-Path: <linux-kernel+bounces-150955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C98AA723
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BAA1C20BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A808BC2D6;
	Fri, 19 Apr 2024 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Rgy+3yqU"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD81BE4B;
	Fri, 19 Apr 2024 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497362; cv=fail; b=NrZy9fv15GasaiWsswOVJVroclVLzi98p036DLWh5coo5c7leKZtIeLEHAes2D52Lwtu+pjGP/74z4QV+2cYI8TpfDsJKQdKIHAvsmulqaT/HiAhOV3tKQf5a8psCj2+4jCBZqY8SlKPdlOTEDjm9PIWrwXn/kxmXMZqo2D92QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497362; c=relaxed/simple;
	bh=xRpBB/Jkb+9uoV9pa2fn9OZ/fKq5Ko7y8YDwyoLXEYY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OKDjoP6E8CGNwPAVaG3ys586cpTOQNeNbrmVJWepa2y4xaJJu/+BWQhht+hJQ/dCGtcABefZevqAaeE3PC28Rj+QF7rOjKv09o5JitUQKrqGl+wPBdULSgJnqT7eaFkzNs9N1QKjrHOMhUADSlu4L2fn2vTH6bY61TSj9PVZvK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Rgy+3yqU; arc=fail smtp.client-ip=40.107.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhVtbAKUNeru8aOMasQz5vpzjQqbW4H1RjkNcHXCqBE7zzSUcFn2DpdMpu3juDswzMxgdVOKiMnSeHFxqvuvwSVoz9cJQs4OIedilaAZpew9UTmKi5dDTUfEaR2FlM4z3Ryg6Xu02ARYAsvXIHjKeIuJ3WHpN1C5gS62aWPeay9mHjQigizyXF2OD+CFNaqmAdVcdMassXgYhQfQHpkYKZvSrUUF4kTskXqQhnT9nbTUuFLis7saP7HynwuB51+X1UhQcwuyL6RASjdzdRk7MfAvzwm0upSwUMrv5EFeX/iTEKxMSOt8R9T3OLTZOmFyfkeGeofqmBBHqF4AFncEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvFkWbra2HvnIKpQ8gfJIcI1E03ufmEmFyiAVvLw6Ys=;
 b=ON22uesurfturUURXW7YqWBIutCAss1qbW/+ESnEfvAPSBDoQFgejLPxyePqn3CxRlZiLWJnk5K+gix+dkCL/WveD/kaI+leaWcTKEDRqYDrdErfY5ZgEjF8quU+HnpQDsiOEOD3W76GXKI9k2zKsek1Fm7okCW5dw3AUH6fuyBoRET7WHPv5giWMR9nRsxJIixgSvVKSbUJcNXj3KnRruKIf3h/uJd3Vglv3Ess+mMLcs6wbqHy/cjAOMXUEhiB8bbIgKYna5RBP4IDb2Ig7mt/CavNKTa9bHGVuVGeI4lo1lVvvIMpB/2Xaz9otaQwzKnOsk5LuUnbuVq48FNDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvFkWbra2HvnIKpQ8gfJIcI1E03ufmEmFyiAVvLw6Ys=;
 b=Rgy+3yqU7+wouGjIgMoRH5n8X1J95y7fZDwccc4Rlk5Bc1lAXgyaFEEwTDGL6MhsVQzUdnCxAJ/DNftKhMLJ/YTM6gQyc8/gkqrAMUWB+04zgJWnJnxXw6MoRr5EYZLwDkYlSbyMDyTmnf/KahS64UAaNFpFOME6vRJ8n3J881k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:36:57 +0800
Subject: [PATCH v2 02/12] arm64: dts: imx93: add dma support for
 lpi2c[1..8]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-2-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=2706;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=oc6Fvu2CN/MVZ1zStQH3SPFzDWzYrcG02QceK0Pv/vM=;
 b=VwyY1aH/N270aMd58WWeElu6SqlannFuoSNH7yaIQWp4A4ld7KXtlQ2YtlqCu7slXMX4/Y0v8
 S0zPPKYYouvDnkvgz1JfGj910eqVyWkuAfI8cu2TmhdhBL6Z5dq6J0I
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 82bd4e7f-f064-468e-860e-08dc6020e536
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t5o/ZhI/Qur2/SWBP2Mz3us5M65c55isJYco55j7ifSFzfwkTI7aiinX43wCNBZmgHVSbkZThekJH0aTKtW5V4VVyNDw47Qc2igENCO+Fqk4P3VExW/3tP6770V5zmJW5bEK/5fsCv1CsuXWx5sdBb6QCi88xalf3tnLmD/2NdL/+4fY/Xydwk/o8W4HMiKkw8vw860jehXWhmSWSIwwC9yayPQOJLeKiJIL0CLNNzeXuBj38us6197l4AcBYg8YEeLPmJkSXg060JA7PdASM3LVu3XX2/xnYB2WRSVXA5oy3Zk8nfdD9kuuQV0lV9STsN2Qr5IunuXclqq3MD4pe25Havk5oX5mWuzNguic4kKy++DWVxhuMr98Wq1+nfmf2d/uZ7FuaCtqCTrKllCg/KYazc0k6PFG6NunzqRKOz9tIAu2Gdd348JSXnQMA9He5n32oTdSUxML6g8NmBA7AcNfalGOCuZgsKjhJCdnaR8D4oKooPBmArAvqUrSaX2zeSrIFJVoNSASkTKz4xfIuZY/89dVVX5Vj+X0VDhnOHx6NckW9O+XASHBmV6yKDDCzhbw24XvDvX6tIvm360bgKH2/WvTPmq28qb7k7Q1RDBauQMlSLXeOWtB2MnpECE28V0ye0nw8VsFskPmtm3YDST/79g7gnQ/kauN9FL19ayeqXUNxqr284qyvocA2Y6KqyqG8MpXV8SJL0kXrzt/DA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlJvMTlpK0w3cmdKMDRtYkw5NWtiT0VvVXVGdzBuRDBoUlBobXVPQ1ZCTVRM?=
 =?utf-8?B?emltUjVqdDFmU0t3Q0s3alZ0dnVWY3AwTFljdk95WjZqY0ZYd2ZQS0V5VWl6?=
 =?utf-8?B?a0tKUGRkRnF0QzBFTXNRNnhqTXdPNS9LVHoxRHo1Sk5TTFhydGlBRnhTdmhw?=
 =?utf-8?B?elRzVlZFWVByOUwySjhIQ0tGY3FFS0xTMGVSZUJVNS9Gb09EZDlnOE82WVF5?=
 =?utf-8?B?WVpIM0Rsb3RvR1h6UXVVbkgxTFV6bmFEUmlTZ3hlWUhIck9HRFdCZGlKeUhN?=
 =?utf-8?B?VEdSUSt5MWl1Z1o5elZ2am43bW50MFMrblIzZytVOFowUzBYR0d1MHhaS3dC?=
 =?utf-8?B?eGNRZk80NFBLSks5OUJVZlY0dnVxaTNWTHVTSE9xZEhxanBpRStuSGd3ZXdB?=
 =?utf-8?B?UTdGVkxJYS9pLzdxNWFkVXlJWjlWdVlNSDJmRGZLbXRBSFlNTUMxUG1Rei82?=
 =?utf-8?B?QW8wUjlpRW1lc0huaUozY2tTNXJHNEt1NnU3MWZ6ZHM1NDFzSERCLzkzekFw?=
 =?utf-8?B?SjUyRnkzQ1VSaVhYQkY4QlJYSElxRnNpLzJUK2xHcmUybkp0cTdzN2dKOURo?=
 =?utf-8?B?ZjllWmY5Ym80WitJK3NSc2lXWjVJcmJJZzVxNDN5MFpRalJ1TERON0R6MWg0?=
 =?utf-8?B?T1h1WU1kRk8wZFRyY0JQMkp4cVoycVBYT05ndFFlVFZIelJ2NENzdnA0N1l4?=
 =?utf-8?B?Q2J1TlJZNDQwVFVZYm44NVNoT2xJQWlyb2hsYnJwNXozRXByQjlKQ3hUOHhr?=
 =?utf-8?B?QWpxMi9tOVpCYVY2Si9OSitqNWhERDV2NzJCNmVzM08zZWhkL0F2ZEplTVph?=
 =?utf-8?B?bE1TZ2FrUUxtSU9FcEs3MTgrK0tQRElXMWVjOStESERXKzl6UDc3ZVZER0cw?=
 =?utf-8?B?OWo4M0FQdkNWVlFaMVVkOTdDNWhacVNuN3dyZTdNenA0WmN1U2ZnWDBqSjNB?=
 =?utf-8?B?S1NjSFc4eUhVVlhsUW5RZkwzQkMrTjVjY0tIV05GV0VtbmVTdW9LZGlnVGJm?=
 =?utf-8?B?NzJDOW01NkZFaytERXpNK0g4eVhuVFMrYXlFVUMrL25WZ2dGZ0IvYjc0aHph?=
 =?utf-8?B?dkJlbVV0SXRlMWViZFB2aERmZG9wdTBYaDdIc3FNeGw0V0thUmxlQkJ3Wjh6?=
 =?utf-8?B?RWNxeUNoMjhNTm5oaW5Da25GUnRGbGtnU3ZCTXdNd0FGVk5UZlhuSmtzNVIw?=
 =?utf-8?B?TUcyeHVRQnhLUTZuZWRlSjJ6QjlaUjFOd3lnSGxHTFVtK1JnOWpVTXdaNmhV?=
 =?utf-8?B?WmVHeW9aMEZLYzFPYUdKbk9lcEFjZUllSENERExSeVdPeXlSU2ZKbk9nNFI3?=
 =?utf-8?B?bnFYRldObHRlVlpCWXFFaWVsMXp2UGp4N0dvYUhBSm45cHVRelV4Y0lVcjQy?=
 =?utf-8?B?VTRWVmh3N3Q3NG5TL01DSXFqQXErL0t2ZVB3KzlhMldvWWlEOGdFMzBWcmhE?=
 =?utf-8?B?VGszSndlUGwrVDAzWE5Cc2VkQUwvNUhrTUd0aFVxMEpBNE8xUTJtY29JVmxZ?=
 =?utf-8?B?QkErck1HZDFsa2ovOTFGbjN0aE9vbllXZUYxazZIZ2VjMVVWK2lzMDArVkxK?=
 =?utf-8?B?Q3JIbVF2bHByRWdjdHhyRUNPOGFMa0YyREFob1NHZVpGOGo1ckdncVN5K0Zn?=
 =?utf-8?B?dXpob05iRlNsdEZlcnlzOU5Fa0lkRmxPMGUxZVM3SSt2b0hNaFhpNS83bVY2?=
 =?utf-8?B?blNBTjJQbHlGQ3dkeHJab2krODZtekpPSmZyWnRUZHBSZGpJdlNsZjhpc2E3?=
 =?utf-8?B?K040dkZYZlFybUVLem9UNitLM044a28xZGVsSjBHZWc4bUdzY1loTVlEczNT?=
 =?utf-8?B?VHRaRE9pNlhoNGxTRUFkdDcyYmxmWTdiWW5SS1VOYWtmcnZxN3Ryb1JXTFR1?=
 =?utf-8?B?cVFwaTZMczJOOHZzejE1TVprcEJpVzdXeFgrQVBnTURPRHppbzZnMVdDL24y?=
 =?utf-8?B?VTRCOHVaYlJJbU5DMzE1NGMrZkdPalZlTkNmNnArMG5wclAxQm8zbzZpeVBR?=
 =?utf-8?B?cTVFMVJjSkVBOUMvdStIKzhiZTBBQzhoV3JzRnE3ZWJmYzZPZTJDTVV1YUZO?=
 =?utf-8?B?ZDlNM2poWER0Z1dMY1JPZmYvMFMwOUg3RTFQZ1o3SUxRQUtlM05seEQrcDNC?=
 =?utf-8?Q?JW266fGgEh2pRV1O+J3qCkEWI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bd4e7f-f064-468e-860e-08dc6020e536
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:18.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4SLwf2a96ClD7arLFEOjECTXv6JbA9tX/jDLtmysJ4X+sC9AiRtTu9cieKxR41UuIOEwmphoHLyxwl6vwty8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Peng Fan <peng.fan@nxp.com>

Add dma support for lpi2c[1..8].

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 42bbe491a29b..93c1d0fae291 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -317,6 +317,8 @@ lpi2c1: i2c@44340000 {
 				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
 					 <&clk IMX93_CLK_BUS_AON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 7 0 0>, <&edma1 8 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -329,6 +331,8 @@ lpi2c2: i2c@44350000 {
 				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
 					 <&clk IMX93_CLK_BUS_AON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 9 0 0>, <&edma1 10 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -693,6 +697,8 @@ lpi2c3: i2c@42530000 {
 				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 8 0 0>, <&edma2 9 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -705,6 +711,8 @@ lpi2c4: i2c@42540000 {
 				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 10 0 0>, <&edma2 11 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -882,6 +890,8 @@ lpi2c5: i2c@426b0000 {
 				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 71 0 0>, <&edma2 72 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -894,6 +904,8 @@ lpi2c6: i2c@426c0000 {
 				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 73 0 0>, <&edma2 74 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -906,6 +918,8 @@ lpi2c7: i2c@426d0000 {
 				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 75 0 0>, <&edma2 76 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -918,6 +932,8 @@ lpi2c8: i2c@426e0000 {
 				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
 					 <&clk IMX93_CLK_BUS_WAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 77 0 0>, <&edma2 78 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 

-- 
2.37.1


