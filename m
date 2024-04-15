Return-Path: <linux-kernel+bounces-145841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E58A5BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381FD1C20B85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A21607B3;
	Mon, 15 Apr 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cCg+Uwvb"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BA160780;
	Mon, 15 Apr 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210450; cv=fail; b=gAwB02d96h/7P4bs7rW/dfY7oXW3AA+YYyEtEcuuEvC79n1MVbhhoqHeuZAK70h9fxHWc48z0k5VzAQH6zj/nPtLfm21ZqB9FxcXOhe+oiZiV4/y+7/j4qs/Uzqu32HbpywwUXTIGpHu05zdPahK+XKp24TluvevfABkEXKvjHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210450; c=relaxed/simple;
	bh=xzVOLJ/3QBUu2XUZlH46uC1t8owOViMEX5LP9eNp/Gk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iZItNOuOG2d9EBAiiA6blUe05OmGu7vpjekIcR1EreuCjcBA04OOWFPkVqng/WEFTpRs930JQjctKLiC+1b+nXfXJCf1H38I7kLKTAivfLL6ObZRylJ6bzm+TYlgsd8IbaHV9YeeS3RU6cKAY0sT0Zibjh75hITH4MIYI0nmLOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cCg+Uwvb; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JU7LNdj4m29zunNBq5PTu4DMCM54ulu9IVmS3NNRRIxLg57S+xeLZjfxzEL/HH/joY2Z/FB0s+4nsTyeARsmmx4jrsCqloIvpRI+r7iLPsVT0oIQ9jKAsVpuD80KCQpQGU3lvfMYiiPrGe5/1mO0q8d1qtddu+9vlNupznDy9Qwmuv/gVwRoDynoOEmv2QrIQtaBr+gvm7dxbK6t8Ib/Zd58R9QdJwijzD0C9lO4ZgA5BPJ3EyGRfCSTo9e+2sF9hAaOqzLXHWVtDMRYxBESCscw0Dirv6z1tyMQKc8u4RmkQ8Vp2dxTDL7Ya3mkYDxiRYCrLk2p5OFoe6mj9N61iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyK9BLivKiYoYpvLScwI5qT/jokZbg+UE8GDQ/BWAhQ=;
 b=CVxP7bXwzlvXxPPw76O39zWBuLTS4gzu74jgOP31/clOeB2vqQMI3eSL9Yx7Sco9YZ4JcnB0aMHUrtYFqo9G3FXzoebklO+kZjsEiUPTtkUpMMX/A2QFUJicFAZgEec2f1h/NM+xrKjRaXPxqcN+CgDt9VZM4A5HDTrDo4My4Dy5BAHe7YJHlgVDtwl6abeK6yAYupBKTDTWSlzRUsuDMxYXAGfe3+zAEmxvBN8jOq4GvtENkax5YdcKDg4bRqSO7rA4/b1IEJ9Wmm0mh4KfApBkCW8V6Kt7UZcwM2N50jH6EznGWG6DLG6F6Frs9Oz6+2iCrIR3Bha6ehHdMD8XNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyK9BLivKiYoYpvLScwI5qT/jokZbg+UE8GDQ/BWAhQ=;
 b=cCg+UwvbjQTlL3EXLZLmRu2XPGLbZXOeFPx2mP31Lp9Iri9xdc3C3Y271tuSZ2diPzbDdtAHMOMA7qt2qJI/8Ks0CVErJyvuHoaUea1OmWuWdpLMQnLN2LTZ87ewApvA3WY2K506cSCZA1VMUxEVspfS6NFToWcoUxm6A4C9mUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:43 -0400
Subject: [PATCH 07/10] arm64: dts: imx8qm-mek: add flexcan support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-7-2976c35a0c52@nxp.com>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
In-Reply-To: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210421; l=3123;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xzVOLJ/3QBUu2XUZlH46uC1t8owOViMEX5LP9eNp/Gk=;
 b=HyDEuz7c78V/4aphrTwXTYu93M0RdolD3qrxG/9az+F2ytzHmHxyxBd0YSfPv+RwxWD7T+5Bq
 7qUqKaqpl7kBOlqIbcRdSnW/++cUUwQqW/0z5gBYA+4wHxspHiOM5Ps
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2d64d4-08a0-4d11-8542-08dc5d84df80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A0h0AwMmyH0FYvtH2XdOThBn6HiIIaNl2XTRlX8ysvcPoQQVA56+ybypaMJJ54pSgzln+AvC8Dvhm1cE5xlvyxq8C9Fnu8mpIloqUnuWk2NCVisFOBEPba6J07ocD1dtUdblhDnr4LDDXBOaMl++5cEeHq7s+eRvndMMJE4HcRFumdO5Az6sOqpylNDmAnl89IU1fUF33LYWGCYksFFN8I2DUgPYIFvs3zpd2iTn3jFcsiFHumGNwk8bO2hHqbT0MJ/HJwoTbCK4eb4shftKn+ggc/AHWD9ky1BU5Y5Hn6NWq8Kc3nXS9MOyB8PhQcO19KBHwA5aFJojXv57HouEQZ06xxBmAOwwxO1lX42GTYRHPDYz4GKR6RznyeXf1egfXfiExQirWbpfAUtgCNm57PrzQ5r4TRz2cCQ6TB9Rl3tEl8MKa53GLHazcUXQmY80/qIvATUrTq+s+dWfBKSDS6zmgWZyh1Bj89zMfBXS6aPhEEN4jVI540xISXMW6ZPsh7opluanwlQRZI90Ln3N0Cqf0EXyuzYNrQ6uz1HL1NU7VwJq2toJVEMj7kexMBLITfeLHYgRXco5j6CvP8Lb2qoNYOBDpLiI0+fs2eEoTJL9FJJj9i/TYgiBFSoDUlGA17mLaSz7JdYujBsCQH3oe/GOpps86nJthJ41j55uJa8DNAxN8Dty2YYVcMBXDnXnlfgzuPiZ69xVA1bnw4O6zw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3ZNVnN5ZWlhRmI4NDVyRk9FeTRyb1dLcGFkRHIvNXBEVHZQdmNZQWxZWkpl?=
 =?utf-8?B?RHZpenBPTUpqczlSdUpQdjZ3Uk9US1Jlalo3TUJWOWowSWFmc0RVeGhMOEVR?=
 =?utf-8?B?TTQzSmw1MFZudUk1TmZyYkRTcGxJNkk0RHJEakl0RnBuNTR1c0F1cDl4YW9T?=
 =?utf-8?B?MTc1cU9KbGExUTFQV3hKMStjbkF2b2ZNeGplcWdWdnVDczcwWll1MDZmWE5l?=
 =?utf-8?B?czNtSkdTdVM1dWNaRGhYSVBUUldGQzZHcUluWEVDRitPUHlVbkFzYXJmUktr?=
 =?utf-8?B?VXVnTTVMY2MwdEg0elM0RisxWDN0b214V2tjaGJiTlFuSmRpRTMwTXFpOWp0?=
 =?utf-8?B?TWhwTVNvWlBxMlluNVAxNmorZEFUVTdwenFNdXcxemtlbktURStBWWZ5SGhE?=
 =?utf-8?B?NktLME84SkE1ZzkwMXRvVHQ4Mjl0YUlrQVgxN1psZ2U4cERma21MemtLYk41?=
 =?utf-8?B?Y1BKYVRwdUxHUEkwNlFrL2RraDY2YkJHVElpTExzU2pPVVVNcE1WUzNtdjhn?=
 =?utf-8?B?bDYxTzB2TFlBVnhtQzFZa2JkQmUybWRpSXF5bTV3NHJ6MGt3S3dCbGdBdzBQ?=
 =?utf-8?B?S3Vjam90cWNkdlYvZEVURCtsaWtRblpUeEI5K1JEMllRU2V5YjNTc1lNMlBI?=
 =?utf-8?B?dkFxMUpYV1hqM1JvWTY2TG83cTNEc3VDZFI0bGVNTkdzY00xRFZQRHRmTStQ?=
 =?utf-8?B?aXJaVlRPV2tCNDVkUzhPekwrOHFLR2JtZFIyRnVqcDdwTkhSWlBmVkgwWUVn?=
 =?utf-8?B?dXFxZ3pIVmVVckpiNFBEdmZUZ1BOSlVGSWxON3V5VXc1VHh2S3VSU0pzd0l2?=
 =?utf-8?B?QUxXYWxYSlVwUzBveStqaDN3SklnTHZ0NWtYeVpjRk0xaHZSTDFHMW11bmxP?=
 =?utf-8?B?WjU3SWdJNnNCMUtmRjQ4UE5hUGdpcnlIYkJSckhvemdoTExUY1FxUlRBRlVr?=
 =?utf-8?B?UTFCWUhQWmFlSFJKc3hCakY1T1EzeWI2cHBCMUFnNk1OUXBxTVNGeGFwdENR?=
 =?utf-8?B?OG9PYzBKNTk3MWpWaDVjekl4amtqRkFWTkZKZ2NwS1dUMTRYQzZoaGgySkNJ?=
 =?utf-8?B?aERCcUJKeVJHN1lrbjBRN05QZEk0K3h3aXpvWDF3RStETXJYR2QxRlc5aU9I?=
 =?utf-8?B?Z3NyMkFZbTkxaDRRM3ovWkUrZ2M5bmQvaG9MWUNnbUFQVEhQSVNTS2wvcEtk?=
 =?utf-8?B?d1U2TExJbVR5eFFBaWZoSmxJZlB0ckQ0WnplbjVEMUVaWlUrZmlKaWFhMGNQ?=
 =?utf-8?B?YmwrWGRrSTUyUGlGdkVQYVlxbU1wYnl2NVFPdWU2U2JRVFI0MTd2dmJaZlAy?=
 =?utf-8?B?WWx3ZURFcWhuaXBVVlcvd256blVNVzFzVDJTRGVwT0NtR1l6UFBXTGhyeDll?=
 =?utf-8?B?TUhNbkRNVm1wdlY2ZXhPZHdCMGdXdmR6N0ltcUcvY000emRYRDl0VXVhVEo1?=
 =?utf-8?B?cHdmK2Zienl2dGZmcU1LbHhrREs0RW1hYUdMcmtOamplb3kyK1BJL0tycklQ?=
 =?utf-8?B?Z1ordDhaa0V1T2hvZ0hMdzF6UDlGMExHRmMwSE1GNGFiU00vbXY1U3lPUXJG?=
 =?utf-8?B?SS8xem9IRndSOWZEYVhQTjl6bWRPVUhPZWg2dWZzdXd5UnIzMDFvRzBHTUNZ?=
 =?utf-8?B?ZUFYRXdvWkp4TktjbWI3OHJTM0NmakRrNWxSVWlsTnhMQ1U1d2g2YzJxWUw3?=
 =?utf-8?B?V29KS01vRnVuVy9YR0hCQW95d3ZJeUZNdzNaUVpqem0xbStQYUVZN1JLRHdN?=
 =?utf-8?B?S3JGMEFOeTR1bGw1cnRlNGFURzNxYVBLSTNDL2lCV0NPSHRDUGpJbjN5eFdn?=
 =?utf-8?B?ZlY4eStsa0xZTDVkZVI0WnNISzhSd2hSODVYSTRZdWxCUzFLMW00am0zYnFa?=
 =?utf-8?B?Y1lxYWJPNitwdDJFMGEyQVg3aG10dVVKNUlUdlVERVVPM3VkR3JxWklzQzRr?=
 =?utf-8?B?ZmJGT3NxWGNpOEswbU03UTB2RUFnMHQ4SDVweGNLcDNXNEFsc1RxcTkyTFZn?=
 =?utf-8?B?alpoblIwM2w3ZzJDUXpvL3JSaTJ1U2ZMNEgyanRIQlNmUG1aT29iMkozbE9M?=
 =?utf-8?B?ZS9GRjRSZG1PN1BIK2dJUkFkNjRia0Q2cytqMWFTSkxQUXFRMkVNZUR3V3dQ?=
 =?utf-8?Q?OYW2P4dp+EYurEwgzOC5OLFaM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2d64d4-08a0-4d11-8542-08dc5d84df80
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:24.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3D9I679+3zkWXQcXRY7NP2K/raeRczGmVz21F8tx2HLw4mCx1NQh8rLsWjHkBb0cJfUlApL8yHLav77rYtb3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328

Add flexcan[1,2,3] support for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 4b87e13923328..94a4195d92320 100644
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


