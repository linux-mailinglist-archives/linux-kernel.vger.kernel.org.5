Return-Path: <linux-kernel+bounces-150616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927908AA1D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E6FB240C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6117BB03;
	Thu, 18 Apr 2024 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M5fmrolI"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6217AD90;
	Thu, 18 Apr 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463792; cv=fail; b=bhqRt4GeMTR5H57v/9ABP31Xzna7HSz5zfz+NR3fB3pnvAX1DjvKcxuvELL/IVGfv96T+ONtgf1qaU8qhDthGpIIdZ+vzqHRKmwnEH9gZSzH6I8IXURHBBmTHmcQBmJaIFsfHbSgZUC+u3soIX2P6fdESMEj0hJ0tfgP4xLIv4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463792; c=relaxed/simple;
	bh=Pb2xJ326G08zDczLWmtTjquqBs26RkMH+2P/O8c7Xjw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ajdNhb7SSOG1glX/hTDoxJ2eAwl0hnsTB4Nw9cb7DtiT07uzK1abOf74bA8kenNm43LZ/+IjHv7eW2xDB8BExtirRW3Ifa27oEQnzRB4SjzljYP9YAFy1+LJ6LmvYU/Qiv1yGpkxYuXQdqHXSPN+jHYyXkxmc197Jf2ac2QQTIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M5fmrolI; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9eGvjFN9kALGaOQPO8N7Y68tu+y15OyIImgNGMWcyvlyGRmDTzCirGG285oJ59BPOwZ8clMN9QqEcaqcKeBZRur8hs7xr8vHidWXYihRf8BlbgrKYw5Hbw5n8WDBGX0C38XmeFzIAMkNFA+ImR69WGHrKIjMj7DBjibOrbwpQdWJ8uWjEgEEA725wkbthn7FcsfzrN4cigoYYYptbnyLbAKDLKZqy76iB6qGAY0M/9Cu66q4R/jbtIGLjCiyjFDYuXhCtuxzFUzlQLEC7ZfVe640mwdCAbgITV8pk+793g3fUTDk5Diyo5ti2v+Ol3H/zCg3Zceo1SRPOE2CzBgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1E5tWdskaG5q9hW4N9SbZJIBbNlov855pXDnzG9tqs=;
 b=ccXeByEAs6IoYELooDmev+sDNn7+9D0Ud7C4q3mmCfSAFNprWeSrQ6+uzR6a7xgXsBJI39Ao/RuvP7C1jyiPKyO4vBNMXF5jQZx1lx5+W0uE7Khe03ulJgh4n2WHu7yShcUhAll4NNYBJKpHu52jYT6d6uRs9+SdFtCD8R7ABySE/gpN7N/MF8/X0oMCZ58pStxJqkvdLw1AtOrvBP2vRQweZw5oYr+BLXb2p+FlZttrJu1W8++QScBPY/o5iZWCkvPLBr7uHtP08U5GZW7/UeKoaLbalK1yRY4/aUuNtDb3dnV+KzxvwV6H8WXKhNO643x/JiIM3UzZ0bzSrC7SHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1E5tWdskaG5q9hW4N9SbZJIBbNlov855pXDnzG9tqs=;
 b=M5fmrolIF1k1xQDg0cL0tT/eu2wc7qGWxqcLw/GFo49NCUPuxFBIgfiq1+rMxqF1aQR1FKKOKBKrcFuMJtyfXfukHflQ516RZ9NoHt+mRCdeeHqrUbnes1ibz6+LskjMTn82e5QpTYucugMokzzO+54ebP9hNVpc1fqNVMXzisU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 18:09:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 18:09:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 14:09:30 -0400
Subject: [PATCH v2 3/3] arm64: dts: imx8dxl-evk: add audio nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-dts_dxl_audio-v2-3-e4e2747b3a49@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713463776; l=7897;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Pb2xJ326G08zDczLWmtTjquqBs26RkMH+2P/O8c7Xjw=;
 b=RlIv1T7TmW+CrDgiwOXwh5aHRW61q+r/yV2T25iOiXpImh9NyImrNDlnHNp9E0uuy7+vNisU9
 XErErujVgL7A8Px4v4PJfDbg87KKn5NASEp2th/H70GSWmEoAd6GJCj
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
X-MS-Office365-Filtering-Correlation-Id: 895e66ea-af7a-4e2f-8522-08dc5fd2bc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p8E3GTZBZvv2hh7eCmZpAkm8QUci33ULTRejvIbZoaSW0WCkY2VXzJN32pLz8yRAP4Xmxsfp1EACthANvDlhyAjgQ1Y8gmq8HKgC+9acNDjLKRUJt4yIswqk1iKe1+B3jqf+tpdtc07Ug4uDBL92qLn2PSJD/ci+kgKPvPjJgIuzY4HN3kZvLaU12PrP2RsTuwLhUHAmxnwPSZv681s5SNeF4Wc2i5q/FYiHMfVLBg5ybOmvy/uP3NOhwvuvOckpUrgu1GDRj64hZNEuotwU6CioHDqYs/WY/OLevuIKUottE1avjTujpN7HIZUxxX7ey66Tu6INXGJU4lQV+L1rVTFiIqilJME2Y+OpTuihjDzjwlx2EnpCX90SvAqLM178OuFbqRkzIPTt/78l6VImHMBRvj+vgsPtd0ZT71OhMbgqwGFI9TyAHjmpVEheGMqNCgGqdx2AcRqKUt+2jKteGrJVS8qLctNAIh27NKgyBGzTkPE3xNtm47iTwrrn2IABh7TCzBuf/lYxYbg5nzIXPB1HV+CUe3FJj5GQ7udXGBo+9J070gnVKHHztx6UC0cymvgvGoRIOVgo9mWfMsvLXmwxmNLQ5jByILrAAZ4PmJIe/wl9dfdCGlKAMcvSftD8+iojCKDqlZrsQqHTYBY162QRxsGyZTiukuMzhWjzzLvcSTSb9xroomBhdB7VMbPhno/VaA7+6DOdi/2ii5CzX/bUgdhnVlTUjgkdAp8/xko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZXa1J1V3YrZ2VjK3lyUlIzbGJMTTM3ekZ3NFZXTkNkWFdVVDE5MXhzcDNB?=
 =?utf-8?B?TjJRdkxkNjlVcmozeS9PbHM3c3JuVWkyY0lCSlREMTE2Z29pQzlqY085NkRn?=
 =?utf-8?B?WWtjZ2tjazljdld1cUVEdjQvWWFrUHM1NnVlcTNEMW9SY2tOSW1xSTNDa0F0?=
 =?utf-8?B?RkhPSW1UVWhuaGllRGJIQmRKTm02QTJYTHEwdCtaK2hKZEFWUlpOSW9FQzNO?=
 =?utf-8?B?a2pHNXhkTEt3UkxZSHY2b1FrSUhMRGx6dGUyaTFKcHdJZmt4N3k4MDR4OGJN?=
 =?utf-8?B?U3VtS1pzZ2xBLzlaeW9HQnRBSHNHbGlHWmVGcEF1akVTUmF6NVVraitNVm5s?=
 =?utf-8?B?T29QaGFmM0ZERWg0b0JDdit6ZnAwdkRzbUphN3JkdHFTTzhJQjJ6WTUzeTVm?=
 =?utf-8?B?WlBkTk1zYWlMZEttbE9rZ3VGUi9na09HZ1N4MHNlTTRNVW1PaE1ndnFhQlJl?=
 =?utf-8?B?NW5tUXMzYjhEQjRjTmhwQmpyUmJYeVJia1VQM3krVnVybjdNbW13OE5ZV1JI?=
 =?utf-8?B?VXEzc1ZOWnloRUVsUFJzVUhYVXF2QzR0SC9VemtLWXUxN2tRdmRQMUtSa3ky?=
 =?utf-8?B?WElnd3g2WkZVSWhwNXRNNVZ3ZjlNMmdCdmlWRm5zWXZ4TWM3amxaTGxEQkdy?=
 =?utf-8?B?SFVONFFpNDRkcGFsdHRyQlpuRFNtQ1F6U3g4bkFOcnNJWjc1VzYwOGxTUnFD?=
 =?utf-8?B?RG1GdEIzYzFvUmNDam1ETEI0RlMyU2M0YTlTOTV4cllKcGxOSDQ0M3RoSGhG?=
 =?utf-8?B?UDFoNEVhWFIzNlF6M1dDck9sdVl1a2lDaWQxcU1CYVNsYzRSWkRmNE9CWFVD?=
 =?utf-8?B?QlBqN0F0eTZzeThMejhvb3Fqd25rRkdzelpYQ00rNEJDOVpzZ3NhUStURXJw?=
 =?utf-8?B?ZkJLdmZUNXdZcUVVaFBGOVZhTDhSM2ZFa1RUZFdOQ2VwL050d1pWUFV1ekg3?=
 =?utf-8?B?QUdmUFB2TW1Jb0t0c2xLVjFwV2x5aTllQ2ZKNEhOWnhlWXQyWmR2MXI5WXBl?=
 =?utf-8?B?M0tpaGFpeDEzZFgxZ0JIZUZHc3dRWlU5MlhiV3RNZC80cUkzZkRWanpncjN2?=
 =?utf-8?B?Y09KZTdIMUM2bHJYbHJDSkJYejZXaFpOR05IM3YvTEozYW8yNDVYR1R2eEtO?=
 =?utf-8?B?MlJ4d1o2ZlZnMndIVEpJL3YwWFIvUmNmVk9iSXRLaDczNEpHVm45ZEY0V0Zs?=
 =?utf-8?B?VU5DS0o0UWlTRVdFS2cyMThONUMzS2M5VUxNakxJVE51WnFVUCtFYVBhem1J?=
 =?utf-8?B?NGhiTFBJZk5HdFRoYzJMdjNxR2Y5L2s4a2ZBV2JFTVpLVXdNZEVZeUp0RUtN?=
 =?utf-8?B?V2phcjVEcUprRlVtTm4rczlrS3ZzYW5rZGR5QUIyNDErTDR6N2tSYllYUElo?=
 =?utf-8?B?b2xBZnVGODJybmJZQzU2K0s5aStQdExsOXNJR1RxbjRHbGVwbStuZUhuV2or?=
 =?utf-8?B?QXNJeG13ZE1kUkY5S0tKVlRvVEJLMExycE52TUt2N3dIMHZDcDRUT1A3OHdL?=
 =?utf-8?B?RmZRdnNlakVNZExjajltb1FSQkI4NWpTelRmQ3g3WlAzSzFzMkw0L1VrajJp?=
 =?utf-8?B?QkxPZkVtNnRuRGtRVmRTcG1vdVF5LzNyemN4MGozTWJVVWVjRFZ3cmUrM0p6?=
 =?utf-8?B?NjBuVkFSU2dNdWR4K21LUG9nTjN6d1lyS0pnS0VBdDFaUDZma0FlcFhuc0JG?=
 =?utf-8?B?dkV4cTREdytHbmFQMENyV1ZnYlVhOGk0TFFvSHRKa0RKalFjTHNBQmwwKysv?=
 =?utf-8?B?ZVRBdHpyeXhnRzBzV081VkkyWTNpaXFaTEVod1Jid0JQc0RrWmdCMWRONjQz?=
 =?utf-8?B?VkQ1OU1WcVhwczJXdVlqaFJqRGZoMXJEcjBGNGlONmY0OEIxZDlzZEhCUmxD?=
 =?utf-8?B?VGlYa040NlNoYWwyaWRlQklUYXcwQXZvVFprdFdpZE1yZmtyV2FiRGh5Y21V?=
 =?utf-8?B?Z3NOazlMbkhla3hCUG13NmJyYUxVSHk2ODJRMWppengwU1ZaSXZENklEcnZE?=
 =?utf-8?B?WlRCSnF3TGVJM0pHYmo4WHFDVHg2cmVNcTlzNU1Mc2UzbFlCUkNVcDFadmg0?=
 =?utf-8?B?UXFBT2VVcmtSTTVTT3lOZlRwR2RYNEFFNVhTK1A4Y2RiRzJuQ0Jvdzl2ZkdO?=
 =?utf-8?Q?gJIeXFp0QoRL2Jtd0aK/WXsPu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895e66ea-af7a-4e2f-8522-08dc5fd2bc4b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:09:48.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opEsWvyAx46keNwP0dHsNVPgORw8AlUhsQfQv44brWe4t34rmc4ckI+b6mrz267XB+n+XHGaZxXjwR0hnPZ4Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270

Add audio nodes for imx8dxl-evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 232 ++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 2123d431e0613..b91ab1813fed5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -125,6 +125,79 @@ mii_select: regulator-4 {
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
@@ -132,6 +205,11 @@ &adc0 {
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
@@ -259,6 +337,78 @@ max7322: gpio@68 {
 			};
 		};
 
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			wm8960_1: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			wm8960_2: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			wm8960_3: audio-codec@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+			};
+		};
+
 		i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -362,6 +512,53 @@ &lsio_gpio5 {
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
@@ -595,6 +792,41 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
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


