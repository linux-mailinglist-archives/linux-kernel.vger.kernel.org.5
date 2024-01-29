Return-Path: <linux-kernel+bounces-43554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83BB84156D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF171C240A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B62159571;
	Mon, 29 Jan 2024 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gxcb5cSV"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD3159573;
	Mon, 29 Jan 2024 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566516; cv=fail; b=A/idjT+fUHuP1qvbvXG0CEq0h98xLDlpvkMnOSbTPLXA/T/4JV4T3sRr6i6g3PfdN1RXSrijqaTHZyQg3LJkLyDg6QUzWDj6vTnIFuXdRW372X9IHYebvy0QKY+sitYLuY1MIU/1gNtkSVBAoTbAXEIuDBlKWqhd4cCrNqsGiEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566516; c=relaxed/simple;
	bh=6dsuEw2tJTI24RbU/wU1bc9ZYFkNYpW7KngEu6+BalI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RX6/FvoCxPeNoDniqkKOF/CqqzUBp+d41C1nnEtXHIIZFQCFoOVPZWC0GnMtUOF66jenK8HUnL+/qVS1I7ZINZZUjjQ7mExo4dwjdf3riuz8GpH88D7+eC5Wb33wt5mkE6M3e73IkEHNPPc7kktf6srS0DDtsUTOMXEMoKi5pdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gxcb5cSV; arc=fail smtp.client-ip=40.107.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvkHR3+MoQWNBGTN3QBTEp04rro8qE+CNzzvfidYf1FnPeohdFvYln2Jh2ZkxqXwWmQNp2ho9gdD16Kn+vxt6pUJD1bLgZOtdGRHiVksOeXC04FRrfMe4oF1ZE6wL79uybyYl/lhikt0f15tilXEdv2HOjMHZUKy6DYrU45zCDRUfvWtAYWik792z+WHpYn8nMuOFCjTfW6NTrvaeXhG5AAkSq5FlUjjsGRO+rnn6SuT1Kc/SuI9RAdiHep5aNxXXy66Iz8IG4yAYqKkpZ06WhUddUym1OG8mjPLS9VcK5e3fveNwUe7lFnRFbhrtVpknNDrCc4YuFczNy3A5BJm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH4yg5Z11iZjGhKGCS8FMSvaGn4QmE4Q6e6PpHzKWeE=;
 b=D7ckASlPQ3eK8mQxoIm0c/VwKEq5NjfGAk3DE3TFLMlV+nJ2P5k+rkqRVo34etlC1epw+GI+YiEIEh14ojpabDqugtDYCSJSYZz4AP66bBKSeKz4WOc2JcX/2Os84kvCjCIpExWE4oWVv84gBmvrRn/2xCftEapYkzEcf9fc2D8JtAh4pDBiKd8Kvt4iHOzC5lMydWg6U1TPHUh3AWAcHyWxNK0vdgs96t0bVEaYvplupg1zY8/cE4viFFYgHgp77u7TICi0oyr1y3+TaT69T186wlqPq/dec1OmiHBwxGc2wLrmdXPahDmo2A37+EJITK6qYWiV7DEZyEsmLOxopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH4yg5Z11iZjGhKGCS8FMSvaGn4QmE4Q6e6PpHzKWeE=;
 b=gxcb5cSVNEdTIfFCAHvAKjv7V/h4nOje1oL8f6SWZz5TYO6Ta3yjEA5YeKV+S6E26v34sO471XpyberFMsxJ4QCfAQp58YQrW3p12dhgyVQhYA22NFNJAKge30h4E20hLH5gHUt6zLeEl0NMx2xPMaAiwU5mGnk7ZjmxrG1cgj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7205.eurprd04.prod.outlook.com (2603:10a6:10:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 22:15:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 22:15:10 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/3] arm64: dts: imx8dxl: update flexcan[1-3] interrupt number
Date: Mon, 29 Jan 2024 17:14:56 -0500
Message-Id: <20240129221458.250492-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 011f2dfa-5552-4b18-7f43-08dc2117c230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l1nOEqQCq0UHSeFI5virN+YpPHePdWWcju2GYD0ZFZlk0NrbY/F7erMXY5xnE1lNCmcHcec1RHeWNTC1tkrr2DpTnO+Ot2D+okbqn+5PEboTp2mrc8EwPpmFpdcO8HnQL2dswdfO2KcvwISRqu5ektvbxvMm3WBRLrSDbRXKSkMKXDwAnE7wv9T3onyd/qwtuCwYrpmqTwgjMteNCPvsbrSBFhtVsTjB68A6fQ6W+aSpy2YCESFUEwG2VG8y4NZIE+A1EJDOMgEPl9NC/vExb66P3z41h+1qLYqlJMeSDTcrJHJV9EqKY7t7gI6txiq2I9ZEYsdJmFOkIrHURCYMJC0VdOaihWDdiiM6Nx9r4zGM5GA7zYoTW6++p9oaglHJmNxMrehEpYBkg5vZ4EM0UDw9wOBTBBfFGGhHHScy3wVEf+Mxkk9+ftDurF5Nv8prhE3AoeRkMfWto29qX3mhhHfM6j2L6xf2mh7fLixbnKc4+Maet6PIRVK5De1Z4SZZJUGoX8K5xnf4gZTR373ypjDkeTCaSCMY56DJRLym0ZG9o8DlPOYtXr/vGBCOefDTXtYwF6LGnDKk5WQ6c82DK3MRUW81kTSo0bivrgUWEcLY0wPCGboexMmYv8FpFfaeSIAlauHvVq5pg7uiq+oF15TrX1IhJ70bcNXrEUuLURE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(26005)(83380400001)(6506007)(6666004)(6512007)(52116002)(36756003)(86362001)(38350700005)(7416002)(15650500001)(8676002)(41300700001)(4326008)(8936002)(5660300002)(66946007)(38100700002)(6486002)(66476007)(2906002)(110136005)(921011)(66556008)(2616005)(4744005)(478600001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9V5UGPsHKTujMphIJym53vBHDobfOROrInsY6QFtbr3s8izKLpzE1hTNvTpg?=
 =?us-ascii?Q?XXZ2ke10X4n1TbavALQgV/nPR7bFY0QTzYbsF4C3d/JOu9JS1l3GidPkymc5?=
 =?us-ascii?Q?XBps7uHhgbCsVtdKeGxcNi4mpxaxc1pSZJ8EmBXCXCprDor9eS6TNTx/WLxo?=
 =?us-ascii?Q?jmq+D7VT9u9SocxYNLArDTHIAedwPw0xzCIqPRrAzt1emSkWDxmuB2gg+y06?=
 =?us-ascii?Q?3V7ezQmSZ9p1oZpH+VAPIMoermOp4HdJFEuAgxL7UtlvzHkpCMGutSCD2mSn?=
 =?us-ascii?Q?GCs5+33RJFP9k2HpJuRAT3Hlt4K3762MvIX5A9g4W7+LUQBR+j958jbjtj54?=
 =?us-ascii?Q?q4mmYvjX3A/Z+h6hR7xiV8TSy2tHjbpA3WuflTbXT+8x5wM0v9LZkzOWRGeC?=
 =?us-ascii?Q?FhsEdcEMHOCFTR3jhwPfJSRTYgjST9Hfq+7grDKCVK5TrwhibLgSOsR6DPS0?=
 =?us-ascii?Q?XYrCBAaUdPv6OWFA1i/2tAwFOGI/N2lnc6+1RfOx3ZUzH1F22VIc6AzDWYgQ?=
 =?us-ascii?Q?VDFOHpnLaegQ/giwzwTAs6NcPn9c2C2EtwBvOYaeedcnsb4iNlgBZDwKaD2d?=
 =?us-ascii?Q?n2gGeHI7vvmM6CijT1DQ1RzykQ2bGcpRFixc3zAkBgyuU5F8PhcVddwPHLjE?=
 =?us-ascii?Q?snngPiCggyj/KnKxUwJQrztB94ZlawxAqigHx2T4+ISE9csksK/xRi5M52Ka?=
 =?us-ascii?Q?ihcEEMNVw0Fh8m1YjyGbASVEcLkm4gnUcOee5AqKycy6wIMjU3nq/ncTWXQV?=
 =?us-ascii?Q?eN3W+AYROytVRh8vd2l4MuMy+9WpVREU8vH4j5qNTlbslhWNDzClUqVZJwC+?=
 =?us-ascii?Q?3I7uUIsHi1Pe67IOyyQ9b88/PrTYFMc/ZgjiOZJncNcUe+KsC1yau9wpLzcU?=
 =?us-ascii?Q?B2DgHHhNnxJvDb3xUJFeczmuxqy+cq6yWzv2ooRPPuzn6/7dy0N072KOHVJ2?=
 =?us-ascii?Q?1SOvjizSYoYaBroKsxL+nRLbPLocCI56TFkCSOpTXfxYRnW1S43r8cfwN5dc?=
 =?us-ascii?Q?HSt7pG92qObupzjFpgSNWIjdoAmiF4kCPPTevUJAT5QFaPESkJsBRMxkCKY7?=
 =?us-ascii?Q?4VyEpi+Q7RVimOYvUs7fcbxaGdG1IIQHYFkqtcsEm7mA/E0/KcaujpTJTNlR?=
 =?us-ascii?Q?I4ufAUI72JZb7GSnj6ZWs9zR3HKTjDQSJyr02x8hF2ShA8y6CsozlSAvLh34?=
 =?us-ascii?Q?foiOU2F2MHB5JUxqQTUEHAbo6BurYtxGGVAL346N/9zy86JQX37oL7yoK4Yx?=
 =?us-ascii?Q?BFJFqjZIt2xMGRzS9ATjf0O6mGR613QIYtg2V0hbt1h14DzPWDDEHq0O34gl?=
 =?us-ascii?Q?wsjVkbYOZXgSh+lbGlXc1d6o9N6y3RdmAqpFa9zjaeFDiv8VmAQg4QFB08aJ?=
 =?us-ascii?Q?cUjunpbfk2OqEryZbzIUQGW8O3K2n6lnz1hhE/a7dxYF83pkXZHFvmc3U7D4?=
 =?us-ascii?Q?CjoPMsHXYdGjcp1wkhoQg7unqdLYzpfQj9QhAIZWJadCczqSHiBnlAtlAqBY?=
 =?us-ascii?Q?TIt7FeEduJXXIr68iS5wPafy/fqcgZ4rivQ2r1wN6a5RlnLwYRBmtTKsEzER?=
 =?us-ascii?Q?fA2k7an6dO1p96mtiTZgayi8KN/CLpt1rS/5UhCu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011f2dfa-5552-4b18-7f43-08dc2117c230
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 22:15:10.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdiq+pJHYxvz1MW+CLsGM0PRs5c/ikmhI/uD9gQRRcKrlMk/EztrS0BQvPRTZ9b3vHTyGR0ew2yX0dyJ5Ilh6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7205

Update interrupt number of flexcan[1-3].

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index f8fca86babda7..5d012c95222f5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -102,6 +102,18 @@ &edma3 {
 		     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&flexcan1 {
+	interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&flexcan2 {
+	interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&flexcan3 {
+	interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &i2c0 {
 	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
 	interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


