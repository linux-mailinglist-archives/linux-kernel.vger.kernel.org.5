Return-Path: <linux-kernel+bounces-150954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B088AA721
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3261C20DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397E3BA39;
	Fri, 19 Apr 2024 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N15nd99J"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B98F6C;
	Fri, 19 Apr 2024 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497359; cv=fail; b=fKuIf+0BPwcjfPulhnZwQ5e4OVa/ufzIE7KJRRS1JF+ZzYcw95sVN/pfmdVfw3ObEe/iXnKR90sK3sFmZPHoj//w67/HAhGe+WXm69D9b2CB1iztMg1xtN5mDh5dgM04nk/2aBOWyAXa9eRfq1zaFqLVWV8yM5DjGvL3dyzd1eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497359; c=relaxed/simple;
	bh=A0lhJxWzt0za0qG4Fd0QZh67vl6drqVx5p0Yx5YeeYo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CRrr5Q4NCRKKtRcvtESObIalSAMAHkw8w4nIUM2wa2F6h5O+VbSd+K92S/N0IB16WAbu5oFxl0iytfhQjVmzZnNhjj2Wn6CMa6sgkpRtNivOl7AWQhIvwGrVtnxMWxYqoVkL9bmVS8LJvJhB1d6ZVdnyn0lUWBVjhJ9ih74H5GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N15nd99J; arc=fail smtp.client-ip=40.107.6.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkRtmbKk5BNlmC8C0Q0Q/1x3w6mKwRQe8iym8vAFCQTClep6u0KXyBNzDWV4n6YpleTUrahjPPqFzF7fQwdI++PZP8waRoZ9iTDD1g9JXu7A0ZbbYp4STSHOnqG9gY96jXbkvpk9wLRmTzGhY6Lmqln07R6HaKphTAhUpgQCJQLcdecFYX7P7PzYVZbnHRf03839Z3ptdyC/TxeBtHSjxnlVPW8qPsIxmK7zqXS2cEihgxKr0CcmmY7LOC9K/8bbMmmnZFnyEtCcHw+x0VyciT9voCIesxZS5KPn+RU64SZMgTMuTSZp5FF1eV5guf+cyGW+zoMjkFhtunaQ3X820Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NASOKxKFqVoTaZL/w/kh3vGj2Io5X0Kr26ME9SQ+1GI=;
 b=CQqKJQ607fzUhah/P3rDwsAc8/HQ0KAboBEXXEtJGtlF30RBaO5F50+GOw1gVJPS8Wu7E5EHN3GYpxhqV+OAvoL8CxZ9yayvh/3bEiYZhbvAw2bt+mil4tCT8XCDi195rcStG/pLZbRa9lBaZvN/867q45XCk4pAsS0pOKrwcmYnlBzdg2LOdiFz1c4DNdQDlQPYfX2Y9F2ZFP1ufL6cAdEEfGYO6OOqbGAPMRc15XmWFZv2P4AqDIVnNHS9IvWIDYGl3fLxx2zmViqaPfixt5TJe3B2PfQtKSlOQlBkFzJzXmAokX+RSuK962SsMa+nDQSXts4ZImBKGc9vd348Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NASOKxKFqVoTaZL/w/kh3vGj2Io5X0Kr26ME9SQ+1GI=;
 b=N15nd99JqL09p+AKz80bg7AsFgzLAH2O5sC4IF6wTCrDOvX3tjAOrQ+ZmaJCF9mcU9SrdpHxlvtka1sVXNYpFWRnad6lO09VZsvuaOVeRDYpQZRho5Y/tW00XbNy00BMvOeMc66jTYXF8ZLrXpfe70EKJM36dmBlisFl8I1985k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:36:56 +0800
Subject: [PATCH v2 01/12] arm64: dts: imx93: use FSL_EDMA_RX for rx channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-1-9076e1d7d399@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=4918;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=mySjYXM7AfvKO72Ck9WGrzZ9bsmjWK8wxHuq8kOXlEw=;
 b=h3ys0yUa/7rh1qoccebB/FDPpE86WFuOPowf3R52Yngl1PyVjTgLxtm+LzERo8HwI1KrkQQ5p
 wYpLk5khhnfBrmKLTNuOgqnJoV0fZI8lfL99/bU3me72SIQWeNjlNw1
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
X-MS-Office365-Filtering-Correlation-Id: caca1c47-295e-44ca-3ca2-08dc6020e2ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JNh3HUJoXmMOWDOF4DvtZRx+1Yf5Vmq88HZl0j8BSbPwA4pHGQWFyEYKx08XctqCM+HyCXIukjpEDBuw/gfwAd6bT+X/lgDv/Pt0UyokAZGldczsXIkrx2WDndZJe5jIXItRP1DQblY/uNo1Ohwr99smgHcA2KvhTU1+TgVo3FeNQ9ovgFBO/oLPy0y+OrwATBIJaxAnw8VZ6TGBaaROUSH/jxbVFOJdkp24DN3RlvsAZiZXGhtLOLlZ+SzqVh7a6LUZmjThh3VLYypCHuYUsriHdVcn3s13czCh4E+n0u7D9W3fNIYIzPb+D9J1GWaNDQ6ksMPtviIUgDj26CxVLZQSTO11BaJZrs8wvG3uxKyjVSsDBXLK+yUk/Cs7uUw6kTK+1FQCF40Ut+j4rdzAfLfAKpm3YfOeKbYnMATv7bSqhkyRJDrYSJpr3nB2GFlTKc0+mkGL0Zz/zT2zt3NQexCzv6F8ycx+OACRYDmPihZNZysBIex7rTyIYoFufGFSRCgrYKq0IWfF3F4Eb81rtg4DID7AWXCQbqxyrolIPBBKh2ceXwlYjI/WyGa20Z6lZw/1yPBFzcX3dQKNNgC8C6TUDdyRkm7kbp6RWFi/Nh1OI506AbcdveicQkIkoQHPZP0TGeSfg41Yo5GPUY174JRFR6POqlGUz+vavSgZvmfT/sUPvbdnzvqMl+SIN3XOi/5KaG+pLV9NAxU+WGNR6s+ocNOyiEu+91YGu4bAdIQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnBVUEhGV1VGTVdPVUJKalJySDZUaC9Vcy95by9jOWZOOXExRkVTQUFKZThQ?=
 =?utf-8?B?alpONDh4MktVdUFSMzJzTkdPOFpZc1grbm1XclVnNjg3VU5hdktuUFhVZ2cz?=
 =?utf-8?B?VU5pQnNoWnRLKy9qQmNuRFdCVFc5dHIyQ045SDIxMkNaL2ZFOTlMM3Q5czRj?=
 =?utf-8?B?T1hMNGJ1TEpSVGU4M3IyNFlNM3A0c0UzbFVKL2NnckREUGxXUDRISC9JRkFu?=
 =?utf-8?B?TWxQTWViN1ZQVDFBYXpqb1N0TnNsZXJEbmxxVUFzMTNHdkZ0ekg1ZytReUFH?=
 =?utf-8?B?ZWt6a0dReWlDZCtja0JubStVNVBuQm96NmJvNWJUOGd3amNzbWFFaG8rQ3dW?=
 =?utf-8?B?aG1ud21wRlpkR1hLRUt2SlJ0NkI1MUdwL2Nkcm1ZU2ZLZlZyY1R6SVdTOEQ1?=
 =?utf-8?B?eTF6cFVlYy9NUG02NndLQjNHcE1KWlRwTnMrN2ZVK2xKMWo1SzRiUDVmUzhX?=
 =?utf-8?B?WTdtb1lTRzg1ekROZzBkbm5sSWQ3eGo5SkRUM2tLVHV6dHhSclRBQjh4TVJj?=
 =?utf-8?B?VDdJRVpBTXpYYVNtVjdMUUF5ZEF3YUhSMTJ5eEhNVXdxZkxudlN5NVpGMWVZ?=
 =?utf-8?B?TXJueUtxbTM5cENUeHcvcnFraEd5Zm1xZERiV2hnNWZKOUZsZTV2cWRrcm8y?=
 =?utf-8?B?bmhwb2x5U3ZheFc0eTFDeUtnUDlZNW9jYjZRZjNnVStBRVNqQTF1YmpZWlVu?=
 =?utf-8?B?LzBLMTk1Um40Zjd4RUVab08zYmkySnRncWc0NHp2RUI1dHZXU0VDa2R6QmNJ?=
 =?utf-8?B?ejhyb2lsN0RBTjB3NkpRb3hRN1NSS2ZmaUdpOGZBYi9WMGJFMlhWdFRJWEE2?=
 =?utf-8?B?dXR4alN3MTNnVmgwZHhVeStHZDZrd2NpSy9hOFNnR0JrOWZIbHpLdWhOakRO?=
 =?utf-8?B?aUwxckNIbmdQbFRDQTdGdVg3MHNMM3VOUjRqL2lvQ21KR254TWdhZEh2TmVP?=
 =?utf-8?B?SnRpNHFaZDhwT2lFUXZKVmVKa0dCMDNZS1FDSmNGWW1SalZxeW1CYUdSTjVO?=
 =?utf-8?B?am82V2xvOW93KzQ2Y2M2cmxEcWhxY2ZwVGxKeW44WDk0SnkvcmgyM1c3MlFu?=
 =?utf-8?B?bnhhbFdLdlhzNkloMnNTMjZVbkx6bFdZeHQ4UTJwNVcwZDhBV011elpYajQz?=
 =?utf-8?B?aHJ3SU9Td0MzSGdIMklnb2lxSHkxbDg1QkxvRE5HSEZkeWVzUWpncEh0TE5s?=
 =?utf-8?B?ZVI3bFlvZm5iNm1DL3BOMisrbHoyM0pkQ0pvYjhZMjlHUjJBeW1FZ2Q1WmZr?=
 =?utf-8?B?eUI1VVFJYlVnUk1LbEw2SUxhMFBUUmVLQmlsY2V1RkRFdkNpQmMzcCt1MmtS?=
 =?utf-8?B?NFBvN253S1lZR3hqVnpwb3NGVFMzQW1IVU1rMEJ0QUdQZExSL3dWT2VqcWds?=
 =?utf-8?B?ZEJQWHg0R2J3ZVRhK1Y3d3pGQXpneW4ySE0wY1NwdmZadlJFN1IxSzFTa2o0?=
 =?utf-8?B?MWRqbW1LUG5WNVVtT2JFeFJTRWtDK050Zko5ZXJWcDQzZXBFMU1ZSUFZY1dN?=
 =?utf-8?B?Vmg1bXRkVGJDTURhTCtmc0Q2c3RiYTJxY1NDS3hYY2h3Y21nS1JJUzBSQ3hV?=
 =?utf-8?B?Q1hjOTlwY3ZoWUJCdnFQRHd4SUw5Vlp5dFgvZXpxSjV0bE5iMkRzenB2Q3FF?=
 =?utf-8?B?L0ZDaVEwWWIrUlJnN0p0TEQremNnaWMwZStRVE1GNkhJQ2M1RTRudUFHaEZ1?=
 =?utf-8?B?enhUaDdLTnZ4cEFtbFlGUFJnNzlQUXFGSFpyRXdsUitoL1dEaFppcUlNbHky?=
 =?utf-8?B?RGMyaWp6Nm1zSW1Xdy80cjEwS2lINzI2MGwzWVFzM1lWVDJMMGlxOUIycUxm?=
 =?utf-8?B?T044NmRHUklrRkZhbEhDK0NFS2VRU2JsL1hyV3pBQzNYV25sSVhoMWhqTnA0?=
 =?utf-8?B?ZHU1MnV5TU56eWlzTnRtMmtpRUlQU1VlUDRsY1NTOU45T0FBK1FRNFJGT3I2?=
 =?utf-8?B?VnZ5MFdwSWY5RkxiQVZTYzh0MHE2dUlrNlVBOHA2OFhta0pPOVE2MXU4V1ov?=
 =?utf-8?B?UGNvZW1Ga1J5SlJMRUI3Nkw4RHYwUXUvaVd3MDZxd2cwMVdJNHRaK3RQSkV3?=
 =?utf-8?B?S0NTbzdpNG83bDJaeXNnY29XbFJVaG5ucllCSS9CWjVMRENKUGVuT0tMVkdX?=
 =?utf-8?Q?solC1W2ArmuN6LG6kL+lMZtV8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caca1c47-295e-44ca-3ca2-08dc6020e2ef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:14.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2Hmz6RIApCgC0OIRSRD88N800eR8eo0zAFrAepoUSH/XSu079IlIc1fOIGykPIlQk7A8oXWSiM6/iUdFWtaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Peng Fan <peng.fan@nxp.com>

Use FSL_EDMA_RX for dma rx channel bitmask, which is intuitive.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index b8ef9b938856..42bbe491a29b 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -361,7 +362,7 @@ lpuart1: serial@44380000 {
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma1 17 0 1>, <&edma1 16 0 0>;
+				dmas = <&edma1 17 0 FSL_EDMA_RX>, <&edma1 16 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -372,7 +373,7 @@ lpuart2: serial@44390000 {
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma1 19 0 1>, <&edma1 18 0 0>;
+				dmas = <&edma1 19 0 FSL_EDMA_RX>, <&edma1 18 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -400,7 +401,7 @@ sai1: sai@443b0000 {
 					 <&clk IMX93_CLK_SAI1_GATE>, <&clk IMX93_CLK_DUMMY>,
 					 <&clk IMX93_CLK_DUMMY>;
 				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
-				dmas = <&edma1 22 0 1>, <&edma1 21 0 0>;
+				dmas = <&edma1 22 0 FSL_EDMA_RX>, <&edma1 21 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -737,7 +738,7 @@ lpuart3: serial@42570000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 18 0 1>, <&edma2 17 0 0>;
+				dmas = <&edma2 18 0 FSL_EDMA_RX>, <&edma2 17 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -748,7 +749,7 @@ lpuart4: serial@42580000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 20 0 1>, <&edma2 19 0 0>;
+				dmas = <&edma2 20 0 FSL_EDMA_RX>, <&edma2 19 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -759,7 +760,7 @@ lpuart5: serial@42590000 {
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 22 0 1>, <&edma2 21 0 0>;
+				dmas = <&edma2 22 0 FSL_EDMA_RX>, <&edma2 21 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -770,7 +771,7 @@ lpuart6: serial@425a0000 {
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 24 0 1>, <&edma2 23 0 0>;
+				dmas = <&edma2 24 0 FSL_EDMA_RX>, <&edma2 23 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -813,7 +814,7 @@ sai2: sai@42650000 {
 					 <&clk IMX93_CLK_SAI2_GATE>, <&clk IMX93_CLK_DUMMY>,
 					 <&clk IMX93_CLK_DUMMY>;
 				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
-				dmas = <&edma2 59 0 1>, <&edma2 58 0 0>;
+				dmas = <&edma2 59 0 FSL_EDMA_RX>, <&edma2 58 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -826,7 +827,7 @@ sai3: sai@42660000 {
 					 <&clk IMX93_CLK_SAI3_GATE>, <&clk IMX93_CLK_DUMMY>,
 					 <&clk IMX93_CLK_DUMMY>;
 				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
-				dmas = <&edma2 61 0 1>, <&edma2 60 0 0>;
+				dmas = <&edma2 61 0 FSL_EDMA_RX>, <&edma2 60 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -845,7 +846,7 @@ xcvr: xcvr@42680000 {
 					 <&clk IMX93_CLK_DUMMY>,
 					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
 				clock-names = "ipg", "phy", "spba", "pll_ipg";
-				dmas = <&edma2 65 0 1>, <&edma2 66 0 0>;
+				dmas = <&edma2 65 0 FSL_EDMA_RX>, <&edma2 66 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -856,7 +857,7 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 88 0 1>, <&edma2 87 0 0>;
+				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -867,7 +868,7 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
 				clock-names = "ipg";
-				dmas = <&edma2 90 0 1>, <&edma2 89 0 0>;
+				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};

-- 
2.37.1


