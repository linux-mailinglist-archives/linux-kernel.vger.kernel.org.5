Return-Path: <linux-kernel+bounces-125181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED28921B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11031C2574E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7973613C;
	Fri, 29 Mar 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="np6heawx"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2099.outbound.protection.outlook.com [40.107.20.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711D13473B;
	Fri, 29 Mar 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730261; cv=fail; b=q3d57WZOMciULUx4jf0jBKfEIaN2VyAcGmSZQUT9Nr+eviXUSJog+uVViCs2o0kmRycwJ3VGCSA2emPzFhj2QMGqOT4imeu1LJA3IR4sFV8AVlUQjDR8h+r6IRt54CkTYf4hU0kV89z9JbeWWiVAPq7hzd816YCE1lcA9F9GqcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730261; c=relaxed/simple;
	bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FM3YopktSJRDTo+HUEL6OE1jZjXMeA4V1mmSOYfx5oWL3wf+PCoH9lvTvjl4GCBIgAbL4rmF+MFxjndZys2HmKdOmj8wObq++ZII0rXw/LE3vml8sFBgJ4ArX7g4x4xqiCt8j0AIOgPJMzZkXc9k+31EkuBfZE0FyZ8qYtEU8A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=np6heawx; arc=fail smtp.client-ip=40.107.20.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK8G8/BKNqF0PGD7gROs+j1E/Ogw77jDKjV8Ae3TRMKFbHqQVC0/gTNx7OZxM42k2Fhf0+zlAYicoeTEVsah6exTJBV3fSiqwR5SJFYmcaRNo2LC6WxvCOQ/4+o7TJgn+LB+dhq/zAI7F/Rtgb/4nEmNxmh56KvSF6vafRT+FZjX69QJiW5Oq3358QoLlss5oxp6KkiunZrQC53HZJhpFJ2NZGxlExJd2oAtHE2mHBaoh7bKnP0vnkGnENdYoAWNXwS/I3BsZuFcVrKiiCmM5CkxDs91emUDQIKyeqoU/XPNRbNl+OKzCplDFRrsf6j3uaCXzsdaGEnKk5T0kUV3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=e70q5qtcEoSn4MqYEbF24kPloAVlDpKKkgXCmnxBZmOhxDWx6jHdA838vvamZb7rzGHUgGLfu1xRGHf44XzRuAg3f2K+B5Wg98JcRvi4uAfyozS5lNRyqbmgSvGNGi8KBPCD/lS8sNvkbdlxinmbA26yT3qpZSu+yhmLT5b/x/gOVCZljmZzI9eH9SRZxaGvCnHx1vJdfoYz38QCgV76por+lJ2zux4SSPpkJcGkBpB8dbBvjK2wKbdpO3G2qP0MkIx59ZasEfCp4QkNiICYv76G5w8rYhn7CNJ6RwM2PqzYo7eZWoTiBqukzMvzfvP2gLL80qDPISORiVncqgeoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=np6heawxdN3bpDQglzeBsEVfIChU8TQA2xRLS3z51HmsRtimmGNg2ooEpVY36le3JhzDgNOVkXbogJcnCrpwMUR/OXmUwxt6IwditDPMXaOx72j89eqrDQhH4/KmPfTZkcw1o2bHsDz5o39ZUhJU31C6eavWhUr43O1OmLKubrU=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Fri, 29 Mar
 2024 16:37:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 16:37:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 29 Mar 2024 12:37:07 -0400
Subject: [PATCH v4 3/4] arm64: dts: imx8dxl: update cm40 irq number
 information
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-m4_lpuart-v4-3-c11d9ca2a317@nxp.com>
References: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
In-Reply-To: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711730244; l=974;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
 b=zdeQTDwr8LqQ4mAT3CptL4lEc6lR4xdXn0bd4cfkJ5sCXC1QX/A0LqaINcBxR1MJMnxjSvvvj
 u6pSx52SUzqC0xIBvAB/tUDJGPFh5vrauUCa07KG6KzBTjnIni5TI95
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Qk6HwusPQMNShTMIQ6rDDHjag6kCCgf9v323LMSvDwSf2AP/U8bB37RhdJFc0rNtqaetTDO4EdqPuMhfiHDPTnKuJjPW3cQg2mM99Qb5I/nuSIFj2bjNu/fMP1hbgUTuUENsxLGjNTTTGSM5jsXrX+jg+1q8AtbnqO1WEVF+q2dx8RJt6VC78WoMoicN09KNLpv4Llg7yYMkpePPQWgKOqGS8ejLRF/L6qN+sJA4Vz3CD6NAkIllJ4P7gEsoT8BQveBb3GQhAsPakvFIjgb6wE1uOoU/23ru81mclus9QxCPKEY2bMFVdi15H9a7Hzef9VD6Wb0C9A+fxkyCH89hkseXjomPzQSnqXgtSEH3V92VEuOBUKoZQmyStifuVCeyQ5l9pGvoNXDzjvO13VV51cuWZuP83wWHieSpfDbsCyAn7kqIfgen88ePkOY/7wxaNYxkyk+SbpYV2kFtvxmViOg/sgm/1z6mxZgPNEWCLb3Db7JskuJTWytIWFaf2998zVoLqlfi5397JqayGRKBYiEgggUR5u4+vAN3qVKKFUojpYnSg7DjTz1Vw4Zn53F9rozDxN9/MRDj7/50kFiGtNrW1A+GOzuE8QC4kPYU5RFAkCGxbky6Eey1+6/4Ibn1V6Vx/VTBgeO9uEKaHx1M0Pp8eW8dlBTAAd3BuAGf0ZLDKw6trWlxH8S7PDsOMIgK0tkSH48gD+lr59Vi/clG9QcD32HSrgyNitEW9xPE7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmlhbzFEZVJZaWpJTjJ5ejlxQkVkSUhrcVl3cnlGVmVqNCtVYUh0MVpkbGlY?=
 =?utf-8?B?NVRpd2tzU0hFek40bkxWWlRiZXN3WVZyY1MxM2Znd3k4OTBUSGZBTEZmUUlB?=
 =?utf-8?B?eWNpUFlLUDZkdnA5YlVpZFFuMkIyamhPM2l0dGYyYTUrS29Wcm0zQlMrVTRo?=
 =?utf-8?B?Tm4xSFN4R014WXJMT0gyYzQ5RWx6aVpLMlNJMnJpV1NRWUw3NnJFM00zZkMw?=
 =?utf-8?B?eFR5amV5YlYvMWZEOXBmeTFmQVNNY1M3ckxIYzkyOHlZOWJuYTFOcitqekhB?=
 =?utf-8?B?WWgvV3g1VmpFQkRLZXhCSU5OeCtJNUpWN1YwVVgwVmd4REZGd09FNnF4bkV1?=
 =?utf-8?B?aTZIczFKMkdabjVmZVpvdGdyQkFyb1orZHIvaWdydS9PbDdkQzlUMjVQaTdh?=
 =?utf-8?B?eXl3OVIrMGN3Z3JROHBOVTdBWk9xMERNVkdHWnB1enI5VXYvcE12YU9FUlpQ?=
 =?utf-8?B?TVJjZDM4OVlNU0xHNGdDZ2JGdWF1SmRwZWgxNHI5M0R3aW1WenM2dWdaZGds?=
 =?utf-8?B?MUt0ZkJUamZRM3hQUDFhZENtc01UUWc4QXV1YW1FYkdnUVg0Tlk2ams3TUlK?=
 =?utf-8?B?L1pJWDQ0dkhkS0ExZEpnbXpNSnRWenpDYkZRdlFOUGZmVVVqcExWcVRDc2Ur?=
 =?utf-8?B?dFVUd2pQQTZHL1RQYUNVQkpZdGVUTmNyS1FuKzVPb0dZa09xWGc2ZVZkVWYx?=
 =?utf-8?B?YzBMS09ZSU1UVkFZTWpFYUFPZ1hBdmp3V3BmS0dLeVN4L0IzTVRhMzRZNDMx?=
 =?utf-8?B?dHZkOStaTlhKSjhuc3d0RTZjWjNoUCtyMGJuYlo3Z0FzZ0ZpOTJkZlVveGJ5?=
 =?utf-8?B?SWM2aU9HbDdpZko4S29yT2s0WWg1OHozdHJIMm9NcnZpN202YWtac3RoaFMw?=
 =?utf-8?B?RW9Fd1h1TENYVGFlcEczaStFV3VSdjVPRExSTkdsRjJiLzJ0TVZLNjA5UmMw?=
 =?utf-8?B?Q2FUUzR1cWNYdUZtOGJpSTY1dFFqaHRKb01udWlja3RhcjdLMFoxLzVxdmsx?=
 =?utf-8?B?VEpZTnJERFZrdW5Fa0VWRUNhT2RreEJRWkZJVFRjQU0zRVVDZE1EaXF5UGFl?=
 =?utf-8?B?bnZlQ0t4TFlXclEwZVdpZGFuQzJYTDhRNDlGcmpqbVlCYVh5bW41djl3NCt2?=
 =?utf-8?B?eVhnVTZBTmgzL3lTcnJEZzJvNmpqYmZDVGlVQlQva1BSNFpqT09VYklRZ1VP?=
 =?utf-8?B?Zk1hUHM4L2ZNQWhOWXFwOEVhMzJxL0hvcFgrV0kzQ0Fzc2NJSjNIRnFjbUNu?=
 =?utf-8?B?alVEUUo4SEQ1WnkrNFNCeDA4c3daOEFaRzdBc0hZNDBhQWcweExyS0ZKTmdo?=
 =?utf-8?B?ZGJPTlRCRDlSVnlPenp0N3d6QzhyTWt2TlNiZUZwOUdoY0RtU1JZWmN4UHRB?=
 =?utf-8?B?ekNkeG9NMi9keEVpRlFrSXZhMGtBRG90T2UzdENJRktJZm4yU1dRUVI3TDhu?=
 =?utf-8?B?cG9ReDUvbzBDREplS2liR3dTcUxGSlhFdnFORDUwRmZubjJyQTMxNEhHMWhi?=
 =?utf-8?B?Y3JCektoRUVHU1FWUmhabXI4NUNXMm5CZnI1V3l1ZGpCKzQwY25ONWVkRmRO?=
 =?utf-8?B?SW9SamNqZ0hCRWw1Rm5OazJHdStIS1U3ZWV4UGdOSEE0N0RrRXFlbVNHRm5G?=
 =?utf-8?B?Nm1EanNDLzRva3dCaHpyR3cwYnpldEYxaWI5K2tXeU81OUcrbkplcm5LTnUy?=
 =?utf-8?B?UFJmR3hLZ3BDd2tTYXBia3NGL01QV2tnb3lLejlOVlFaM3pLYXNDSzhVS3hH?=
 =?utf-8?B?QXplT1lIUDRFaHVwYjExZ24vRStiSVBBZGV6NlFyUGdFUjBTTXoyOVd3dGhu?=
 =?utf-8?B?blowMlp4bzd1UVQrWkVqTGJMV3l3WTA3ZlZqUGphQjF3bnRlL2ZFcDQ0dnd2?=
 =?utf-8?B?aGpTSzJ5WjNwcWwxa0RQSDZJS0N1ZU4xeFVRMlhESm9IYkdnUjArSGhtK3lX?=
 =?utf-8?B?ZEdoYi9YYzJjVk4rYUl2alppUk5xZXRTRDNMYllsRDNIMlRuSmN1WkdCWUVH?=
 =?utf-8?B?ZlgvcGIrdmJiSWdQZUIra0dpVnVjbEM4Ti84SnZ6eUFYdVo5elY2VHlhNk0z?=
 =?utf-8?B?VXZpQ0VlTnYrcHc0bVBlT3UxYXJyc0cvMW56dC93MFJhN2duc0VlRm9iTDdS?=
 =?utf-8?Q?mjjcpYm0VSx4Hqeyvglr8kGP/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dc3016-94b8-4216-5a49-08dc500e8b4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 16:37:37.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUloJyXmfyWRA0ZhsMmoV0cwilH9XDQnfwvjeL4BBBG1Hz0O+H1lqkSW2j0tr0fBldTYTFN0j8xnjGDr+EOwoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

Update cm40 irq number for imx8dxl chip.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 9d49c75a26222..b9d137d69f5a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -243,3 +243,14 @@ xtal24m: clock-xtal24m {
 #include "imx8dxl-ss-conn.dtsi"
 #include "imx8dxl-ss-lsio.dtsi"
 #include "imx8dxl-ss-ddr.dtsi"
+
+&cm40_intmux {
+	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+};

-- 
2.34.1


