Return-Path: <linux-kernel+bounces-147113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B618A6FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8B32831D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7452513342E;
	Tue, 16 Apr 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OH18DYND"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1D132C3F;
	Tue, 16 Apr 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280763; cv=fail; b=lKik6/7s9DuiE39qcutfEvY0Z75MxUvFiOQfVP94aUA4jlUElwjQEQT2/58jbbHu3jdRinN+loJ+13Ex3yU7FXB2Jspc0V6e9tS4pAMP+82Usbhx1kmyWWvMF6unEV4GyYin4qD3GlkiHkfrAn8/qAPA3BA9sufAIz7H6NCYRo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280763; c=relaxed/simple;
	bh=rCXQfCCspkzGniKwFuLpmzstHntuvG3bS66sT5PAxiM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OkMJ4bFGerM+cN62aeed3ETvVZdj/jLFTB+4v2quH0ivIocnZOf6/9ujKJIZuQTIqLi/7867YQ+YFN++obRf6yq4VfasQJEpapqiMQHYjw/PC3Y/OiKykciaG4K4EVBI3s23KV7jh/Wt3Bw7a+1jMf36dT1voWkN1Qhw+M7fvw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OH18DYND; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAndsr0KN5tSPv8A4ZFiVx5/Ov3hPIi55cG1ibAZ6c7vJdMRCVwBvWlnLN8XMLvJVCyaD9Yi6zzVRcBlw/GRKQ3KNHdUakNaickaFfRo/NHRnTWS9v9npSaXwHsrNqmL4bR8/tXeMoB45Zpcp750Y5CYgzGreeK+CwN+e9k3OH/sIYEjDUwWcZBMQ8dWQ8fkbr0V7Akdt28sRHjJyW4GHDPKSxMxpZXEwq0MP1tEYXID3w5vN8yK42OykijxNUOjTD0mAO4RSRwm0+bS+5r6JcpNpncolhrGb/uyd89GWNPSCT1giDWtxAj7LKISxoO384MCXP3PJL0Ax4g0yvMWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7Z1E91NTteX96MebwxrBMYq7DIWOfOT9dKPSgrWvQw=;
 b=hvghnYQSf8VDD4JracHMC5Og8FzORqeNnJ16JmLsQcDI2SnyzvkeQLwvqc3b9xvpReN1KGhWYMJ/HkzzD/FotaZ+j6mzIZs8eWqcD0Mq7joDc5eaIXIIQBNH+dU4tXy/LVVyV3egsrGwfeDtKXTAz1AJRQ7CRa5Bh03fCm0ObyHjcGWf80A0Vj40cZ5ed0EvMHBrkswIGoAN5yyVBO37E7tF0aHobxDP22oFfcpLHYh0jVwX9rvOEFZDyEisyM23umIl/xboBx+WZZ1uwkCKQ5XajLqztpIA/Qf6iB6wSodaqDKBjwAjJH5T8idJHXEv0OdNh1vuMsVUq6dFpzmq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Z1E91NTteX96MebwxrBMYq7DIWOfOT9dKPSgrWvQw=;
 b=OH18DYNDOZNEJEhcjt4qxIek/2wEP5TVWNZ/i1TVOCjTqyUXTNqmSHgcdd2JhyGNiFDdIVyrs5mbRISqubtbKzcx49C+D9b6gOep5hKxL/BULYxkLQOelgKTbKIYJLLmvj7B34ahWDeZaq35uD9xqUl3G3cKa7RWvnZ2X6ffhkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:43 +0800
Subject: [PATCH 07/11] arm64: dts: imx93-11x11-evk: add sleep pinctrl for
 eqos and fec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-7-da8ac02e8413@nxp.com>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
In-Reply-To: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281224; l=2999;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=nfM6Wo+VmL/ZWUcSpFUHf0VCuNybDxhQy3VHzlu51Ro=;
 b=ZbCOHDZ8GTppE7zbFQV7RqnqBVJy3vWQeu9AUjQx0vLwwIltGxYinngLVsHfFTeEV5gLIhHyK
 lAs1139DkvyDP8u6IRTmKLq2aWUcZuEfyTdPjMbmHmqoN0Ed2+bLXhs
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 6439247a-f915-431e-441e-08dc5e2896b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6kumEte0x6cIuK+bdL9Wc7j30+SvxiezblOfPT+Typ+Qlb1QuLehErVyvCUvRWQhhyxYqTWPv0JpQ+dBADgWqcHYhTNbmuOen++gHHh4YPbPSHqV/Z9rzkJW8xZo7+HX3XvGecRAGpxW43FhboCMn81X0t1ZhWzP1kAjhaRBmE0Nk6l/li2P1iIPukYHoX1zZvUrOmAiS5dgM0mD8VDgGBa5BpGjn1uhHtvng8EUU7ZCNPtvcoyE6x7GoQil7p2nUGLny48PlMEHGNO3DzhX5yFp6OqSj3+81yI/8VnE//2eCKFhv+bgZR5miW5hwUnjCtiKIQt2T2DVptKHUudfi8zW58yySy13sLhfh8T1p4zbV0yYT0dAgCVLqNQyr24k1nZgtxhAts+iPVPqJgsFd9yp+X4K2QoHDih75YLgQp+h0qyfdaeFHjiBw9h5XGsJBWi28xo8LG3mGpemGdl+/f2T0O/m/Qw/q1Zx2KMKnUPWYeyKWLU6TLSB+wGe7xiM8U/raUnnvFS59qFdQhy4ahLaLQYTfnW8EKoKM7RvBZ+pI9zIGFUEBLulc4TIW+E76Hc9jcTNJVCoMIErJge3ligG5IiSAbk7km84CMwzQ9UW7jfL2qr/oQCo8ZKpno4ZJ9ckAYtNQUei/GtcTeVdpsseX7v5RN8hvxmIir9jZgeXLK6RGdhYe/g38XIH5mkJDBOZiZYrmwCnVyrSVCNT3okCIeF9EXzbJA1gcjlfmKA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1ZCV2hqWW9PbkM3OE9kY0NoRTYwMUw1ZDVDNnYzN1VJY2x5ekF4VFhrM0hI?=
 =?utf-8?B?UysvdEU5V0Z3KzBkbGlTZUVPVWFxSlhGeTNvSXZKV2dTWmNhdi9DSEhYQWZ0?=
 =?utf-8?B?VUM1U0ZHb1kyaktIMU5CMVVwNTUwZ002dkF0emV6Q2tjMEE4ZG9QZmUyUE53?=
 =?utf-8?B?bmQrb0VKMWFaTFYyV0lxWmpoK0J1ZUpMSHFBeVZoTi9kQVZvUlVGemdBMk9t?=
 =?utf-8?B?VGtIQ3E1QlVwRjl4Q0tQK1hrRUZyaVBLWUwxeTZQNFdGWi90aUZLcmx0dWJK?=
 =?utf-8?B?N1FEWHVPM1hFdUpEWi8wdGdXYThKYnBJQUpYYnZvOVhiMXUydUx1TFA2Ti9H?=
 =?utf-8?B?ZDNsNC9hZHRoblRiZFJXVG1aRnRsbUhDRHd4ekIyeUs2UTBlVVJ6NDNHdmJU?=
 =?utf-8?B?TlFnSUZ1eG40OG5RL2Q4M3RDZCtuZU5Sc1k5TmdDWEJ0ZDdydkpiUTZNR1F0?=
 =?utf-8?B?a2lLRW05YThGZWtFeU9hcEIvVG13WjN1MmIzS2VRTkxKS1N3T0ZZejVhZzlZ?=
 =?utf-8?B?T3FQRktCMDk0OFdXaWRNampFUVdkK05SSXdTb2tHSUdqUERRNWcvN0tPNVp1?=
 =?utf-8?B?K1FVcDVVQ3I0Zll0d1Q4N21HQXdKelMrSUc5ZHQ3N2JrRW5GZmxWRTl5QjZm?=
 =?utf-8?B?OENjMEVKZnFFYTluWjJ6ZzFBNzZNb05jTGFDOUhVYVdHYkkyUVFHR0o4dk0r?=
 =?utf-8?B?bFpac1NMR1F4dFJ0TnlpV1djSnJsdXh5TmMrQk5rYndwZitPalVOQjRIa2ZO?=
 =?utf-8?B?WW9yOG1TM2IzOThyekVaRHF0eHdIbUZGZ044MlR6a1grbk4wam9UWlc0K0tU?=
 =?utf-8?B?UDRnQmlhY2V0SGU0cjE5Tk54WFYrVmpDVzhzYS95cmN3QnlncmdBYW4rM3c4?=
 =?utf-8?B?K0JNTjkyZkRvS01TcVVBMGJ5aGt5dEVsZlBDSHJFQjdHakpVNWYvc3pwK0xq?=
 =?utf-8?B?WWYrUlNUbGxGT0ovOTJncFR0TUxqbDNNMGpxN2l2dS9pZTZkeXZ4VmZJYWxx?=
 =?utf-8?B?Z0FWR3ZXaEp2TWJ6UFJUdzVWZ2FPV014a1FPbWhET1Nzb3czd2daUTM0cHpS?=
 =?utf-8?B?WTNLRDJseit6MjJrQXpvU282amF5eGpKQ2JJaEZ5allTOWttbXNOQVNvT0Vv?=
 =?utf-8?B?SVNESnk2UlMzcWFqSldSOFU4UkVTR2dXT2VUSTlaUHVuWDFaU0Z0VURLVnZk?=
 =?utf-8?B?NGh3MXh2R095ZWhGckFFK1czdzBCWWtZVFNUOGZCbXp5U00yMTdZbUN3cG9n?=
 =?utf-8?B?eUhHWk9hSG5sbGpYNjZKM0JmbW8xVlFIZ3BmbTNtMzNFekwySWt3UDRCZ09k?=
 =?utf-8?B?QTEyc0pCUCtlVW42dGIwTE84RGVDYlk0cFhnZzVkZFJmZFFBVzNDa3lPTVpU?=
 =?utf-8?B?VE1RbklLcU1YVVh3NTRZa25XK2N0NHVZVHRDVCtsTmdSVDRCcy90c3RRd2FI?=
 =?utf-8?B?bEs1WExETnI5dmFCSE1KYlVmb2xuYUg3WHFTUnpPbmphSVl0VFRzbS9iNlRN?=
 =?utf-8?B?amtwZ1p3OUJldUpKN0FOdEp0b0xvUVlDeWhuMmttc0RpaHhlbUNyZWMyV2Rs?=
 =?utf-8?B?a3ZCSmltY3FJaWlJaGlic3JLOUl0K2FaWkJiQVk1ZHRjK3lwdU9LS0dNTUM5?=
 =?utf-8?B?c1hia0d6M3gxK0cybzlhRU9leVhCSXlId1hpTmt5NEV2UEFXWkhaSFB2SGlW?=
 =?utf-8?B?R0pjVk50c0pYS2lWbDZaMFBUR1BhenloNEpmNWs1MU0ybGVUVFUzbWlWQjk2?=
 =?utf-8?B?MnVHV2EvT3hYQ2I1bU9RWER4U2NZNU5mVm5Zd2l5UTB0aGZTd3FEMUswdnZ4?=
 =?utf-8?B?Q25hMEtvNExqemM5RWZNTWIzSkNxNDFSckJNcGZyZGJvY0VRNFljOHJwbndK?=
 =?utf-8?B?V3gxRi9VcW5hQU43S014bzhVNEJ3TmwvbS83bWJGRXp4NlF4anVWR21KQTYx?=
 =?utf-8?B?YURYdTY2MGJrU0VnN0l1dWhpRUR4WmpCTXdhQVBoMzdxcDYvRTJzY1ZEU1gv?=
 =?utf-8?B?T2lPazJCTGJUTUEzMHdnMDNhVEZ0MmMvQlh1TlcrQVZpK2tNMGxtb1JOSG40?=
 =?utf-8?B?empVQUZmbU8zNVB0emt1RUtiRFdxUHZJSC8vbG15THY3Z1NFbkVkZEI1WnQy?=
 =?utf-8?Q?oMJXhL9WB44OwbidQwBP5VEyX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6439247a-f915-431e-441e-08dc5e2896b5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:20.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJJe2Yn/n+RFYtF+Ht25hhJ2951dHX1P2WzIpP5qgcOa9s0u1O44RiYRa4q6Z2Jo2S24GhI434jwcvfGsyuUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183

From: Peng Fan <peng.fan@nxp.com>

Add sleep pinctrl settings for EQoS and FEC to save power when suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 44 +++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index b7b52576586f..2b67724db685 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -105,8 +105,9 @@ &mu2 {
 };
 
 &eqos {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 	status = "okay";
@@ -125,8 +126,9 @@ ethphy1: ethernet-phy@1 {
 };
 
 &fec {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy2>;
 	fsl,magic-packet;
@@ -301,6 +303,25 @@ MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
 		>;
 	};
 
+	pinctrl_eqos_sleep: eqossleepgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__GPIO4_IO00				0x31e
+			MX93_PAD_ENET1_MDIO__GPIO4_IO01				0x31e
+			MX93_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
+			MX93_PAD_ENET1_RD1__GPIO4_IO11				0x31e
+			MX93_PAD_ENET1_RD2__GPIO4_IO12				0x31e
+			MX93_PAD_ENET1_RD3__GPIO4_IO13				0x31e
+			MX93_PAD_ENET1_RXC__GPIO4_IO09                          0x31e
+			MX93_PAD_ENET1_RX_CTL__GPIO4_IO08			0x31e
+			MX93_PAD_ENET1_TD0__GPIO4_IO05                          0x31e
+			MX93_PAD_ENET1_TD1__GPIO4_IO04                          0x31e
+			MX93_PAD_ENET1_TD2__GPIO4_IO03				0x31e
+			MX93_PAD_ENET1_TD3__GPIO4_IO02				0x31e
+			MX93_PAD_ENET1_TXC__GPIO4_IO07                          0x31e
+			MX93_PAD_ENET1_TX_CTL__GPIO4_IO06                       0x31e
+		>;
+	};
+
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
 			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
@@ -320,6 +341,25 @@ MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
 		>;
 	};
 
+	pinctrl_fec_sleep: fecsleepgrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__GPIO4_IO14			0x51e
+			MX93_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
+			MX93_PAD_ENET2_RD0__GPIO4_IO24			0x51e
+			MX93_PAD_ENET2_RD1__GPIO4_IO25			0x51e
+			MX93_PAD_ENET2_RD2__GPIO4_IO26			0x51e
+			MX93_PAD_ENET2_RD3__GPIO4_IO27			0x51e
+			MX93_PAD_ENET2_RXC__GPIO4_IO23                  0x51e
+			MX93_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
+			MX93_PAD_ENET2_TD0__GPIO4_IO19			0x51e
+			MX93_PAD_ENET2_TD1__GPIO4_IO18			0x51e
+			MX93_PAD_ENET2_TD2__GPIO4_IO17			0x51e
+			MX93_PAD_ENET2_TD3__GPIO4_IO16			0x51e
+			MX93_PAD_ENET2_TXC__GPIO4_IO21                  0x51e
+			MX93_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e

-- 
2.37.1


