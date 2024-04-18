Return-Path: <linux-kernel+bounces-150510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C17F8AA048
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A5D1F22F05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A506517B4F8;
	Thu, 18 Apr 2024 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rhPHwGcA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B29917AD8D;
	Thu, 18 Apr 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458249; cv=fail; b=jTiKZFZUJd8NALgUdy86N2E2b5qM2S4QF8EH6cgE8p7gO9wtmMT58jq/Nso19Tdq+pqUCH7UicsHaOeJWkByC+7sJlXGIjAA3HbIo42Mvmu5/M+BMe30uN/cUIRzDB4c8rMY5FcPj3ofUK0Hu2SrwbPxmeY2r40njHggwj/FUBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458249; c=relaxed/simple;
	bh=iABd3AXBm1528gmAK301whXV8Exmx1dF3ftflY3C/1g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MfC+sdrUnbTh4U9DBcSRvcjGZnw20EY8LUC4FhD2jpcJLhSkSiWiUentM3MsBJ/3iWtSMPN5byEGbnEZCuoKXJVe0wQPKWmA6d82aQPKXpVUErgL/7S9D4Nk9jfRrjWbxc3ewQ01rfDrK+GmBzq+aZevyWeIF9ADGX45uaYQpAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rhPHwGcA; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/kHmWYoYgBdBjhA7jzZWaksdFKn4S+KfwR/upSH5KG1SK18Y9IWgr0kofkoK9nD4E0oubykXgvvVLGLcKMHODRNER0PFhZ9NuZ7N3lVB5DIrgK1SI1GYmZ/l6K+sADY109qiu/ze/B3V/340OoLVGxFKD6YBYyrmu8ZdRuhODBe6KwM4f3LQjogzjkp9hb2j77O/TxuyBm64EaiVllb8XvrDG1I9ZgSHShQ/ymbQeirvh+jhWtFSEbkSGEIC00jpONhPB5+uTni9lO7YbzcIcWvNTmF3iOu63N8mwrVu0njR1dJg3SC0tvZeFahjaryj5NRtOFe9fkIKduJ1YxYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yuPjruf6RlNTPh5lXCrWgoKwk8FTu49cksCCTIh3js=;
 b=dFyG0mJGalap6MbBpUg6N1fhJC+IH3HmIgRF2jc+O0QCCgCjhE4yYq39AuTiOhQvO6GE6gALdnmhNivEtyMaP9Fr/0/hPRdpZLBHkdjoGlAx/k71MoStzIHtpjlHjOvGJVj5ae5LdQeuKvp7Kt388n+KvT/vYP4R0fAv9PTwVvAcPGNhhGCAjIMS0vWEff/niOr0A+hQ4A4oIUohGfRTv+QujKKONii/6QcHDB8wbo7tOZiPrybjUPAmZnH8dQBOk5+xRtpUBtn5t7kCO6r3Vev8lFnHqUwAODn33RJgBjMAX8Tdl4BMLF4fEYWWdHNVnM83gTJKkXVHeEco0jBBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yuPjruf6RlNTPh5lXCrWgoKwk8FTu49cksCCTIh3js=;
 b=rhPHwGcAOvPAeh6WEr4hYoHnXtbdPHRVU562wP0nC/lpLXzaqJ+e9i389j6QxgG1yV5sRmuYs33AxW/hzLeL8PR8za175NBcgm8sEoqpSVJqCjgKAlH5zCFMJ0e91DFsKC6PkyWxUDuXAk6eTq5Yo2WTeXPfFdyTpGksW1HPNn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8681.eurprd04.prod.outlook.com (2603:10a6:20b:43c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 16:37:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:37:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:45 -0400
Subject: [PATCH v2 10/10] arm64: dts: imx8qm-mek: add fec2 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-10-e40fe76b60a6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=2437;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iABd3AXBm1528gmAK301whXV8Exmx1dF3ftflY3C/1g=;
 b=TIPMxU+8+Z5to+OVc214rWt2MNFlG8DZobQyL3xg49kOtIdWucluPwvviaizIBn/yb5GqjqWB
 dmohMeLLGYADWW5Isi6wpR/GQmZdElVGTBlrjeD3X9DRKd5JkwFYba7
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: a47df804-c8a4-469d-86cb-08dc5fc5d4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UOV3PfrQJob2dvm54gxr72VB2UrGJ8Ze4051d3+gcGkW3N08M1GkHMk/RD3tOKyX6PE/6JolpTFF8YuV6bPKBImJ053FQUvP6aOnwCgB+OBVvVaZJ8da7ZG2ubiAcDrgEtzxWZwhmH1SkiwuFkpqdP44sysagKPIPt3oqAo4xAwzQL6Dmi0S9c2BCiMZkoVbyLFwG55nV2k/rhsght08OHLZkOC5BShXwMdSgGsnAqlz/qNTsRRVoUJE0dXkj2v7DvlhOEgKGFGh400nPRjdPNxTk04Ro3weq93Pc0WLb8/z0RViFWR3Q2grvkUr5/JLEmDPZ5ZPbzhu7dK8QwJxeylDzwdb2I1iwuPCiMHf2ANVGQQ4C2BhavZRBOKi7zBi5Q0LrN1sPpe+8nMr9WWkvlQV206f/RWP+0DPBhJjaqDh+RZDg4o8wQn5oA7mCR4KcHYwHb1g32EwBSzbmxRlwrBeFwHrg/CJUcUC7nX6Ckq0xaj21DeR6oXmuxRo5U/10HEg8mO1VsguFtUhHfP5La1Sfx/Bj105sg0LjqkomK/w/U4SwxTcdrFK6rmGbkKKWssOmr57cM7VjsjUsBP4UYA4fPO5sg6pMDaQzowGTYObpg6W3/zfk/rMYegUdxm0aSnhc26QFtQnqtgDkC2geofjUwEOay4t6JsXMP/1g573aOpLpl4lYPu2iQ2ccfznQ4LnQH93sSyNAYABn/uo+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnR2OHhXcGdCYStSeW9wSHhIRlVpUUFtL2lEZzVWbmNlcUdkMTlKeVBJbUJ2?=
 =?utf-8?B?M1JxMmNvK3gzNXkyTHlZUlpOQmRRTFJQbVdLTk1VYzk4cmVDS2pIRVZOK3JZ?=
 =?utf-8?B?Z1VZRHJzeDN1WTBzaFVzeXJqOW4rYXZTUlBjMFQ3Qjlvd2ZVQXZjcnNBbzNY?=
 =?utf-8?B?OWpvN2FTTmhwMTZYL3orSWtLWVBRWGV2QXVlNzJsdnBJYm9QZW42Um5mYmNw?=
 =?utf-8?B?d1dEcFpNNXl2UTEwWkxnUDNrbFFvc2RxTlo1TGxBaU5hTFNRTm05S3VTMFhr?=
 =?utf-8?B?b2IzN29YMURqVXJGOFo5Ui9aY0ZuK1lQdFZFWWRSNXJXNkdLSU5DU3hPS0NO?=
 =?utf-8?B?RTlqQkd4YzVicjBsdW1qVXV6VlF4SjRsL1Rqa2tyOHlveHB4aDdFR3hXWnhk?=
 =?utf-8?B?TkNnUklaNkMxRUJLUkw4am1UT0FOMVJwVFVCenpxV1JoZU5BbHJqZGw0L1I5?=
 =?utf-8?B?WkwzSDdoVFg1UUx6Z1lNbk9sbjc4endjam5tOTR1WkgrendVUU5oM1RoQSti?=
 =?utf-8?B?ZmVQUHRQSGFqVW1IUGNLUlZtVkxvWkc4RS9nOGdEVHJaYzNSWVJ6bVlBSGF5?=
 =?utf-8?B?TjJBcVpZV0NxS3RhT3FmNWQ2Q1ZDMmpCNE9DaFFvSWZXWktRVjBEdTV1Y09E?=
 =?utf-8?B?ckIzaWl5YnlHOVVIVlgxZllWWVAzWDRzaXNKczVvSWN2cWVKQmRtVEQyTGJK?=
 =?utf-8?B?RzRIekhGT3ZxQ3VxMW82VDVUbVVabkZHS3dTeXJ3TEdsUExrMXJpeDBEcUh3?=
 =?utf-8?B?Qm96a1dscCtjMDdqTmVkVUN4YWc5MnNUUnZXTHM3M3doc2h2TkpVNFlZVXVP?=
 =?utf-8?B?b3J1OFVtYWkxVGM4Y0RwaGxPNVJqM1Z1TUowT2Y4TmxPTU1wZzkwYUtTWVFV?=
 =?utf-8?B?eVpTZU5nRC9UbXJBZDJ1Z0FCTnBMUURlTWtybUZmZXkreVZVajNsci9aVllC?=
 =?utf-8?B?Mk1oNDhwQ0NENW9CbGlhZHlwWk1LNWk3dnBmQWdwaXdGSEdGNjRSbVNGMVMr?=
 =?utf-8?B?VzNIVkdSa0F4SmgxbHdRWXJleWpreEU4TW95bTRuTkhBd25JUjZyUTcwUGJv?=
 =?utf-8?B?ZFRScXJ5NWJ4eEVoRGxmdzZWcW5hdk52Y0hML01HTmhKdVZPcTFXRVNpRG5p?=
 =?utf-8?B?QU1iNDhlOVdNUHp5dzVuMXM3ZnpZbHh2VUsvdlM3bHREdFg3eGRuV1JlZjdT?=
 =?utf-8?B?TmsxTWlYSGJiNzBTZEJ5UVVkb1dsY2hKcURiaEl4SEo5azJYVlNtMXRnLzFj?=
 =?utf-8?B?SjFpbkNOMzJ5UzI3TmFobU9xempsaXJFdnUrUTlFeFduOGZiQWlpYzVYN1Jh?=
 =?utf-8?B?Vy81UU5zZ05OaTdCOXp6bDNWZllZeFBPdVRxZXdHdVNKMlFVMlFJRURwSXlV?=
 =?utf-8?B?dWIweFVBTEZseU11SXdmQm1vTkwwSVNCSUFUTzk0VDRBbWFGajRwZE9VRXJl?=
 =?utf-8?B?YTJEb21pbnJqTTNWang3N0tIZFozWDBNWFhBUUtRUDJUUmw3NFk1eUJTa3V5?=
 =?utf-8?B?VkoxQktONFEzVnVZYURJWVIwa21NOTNNYVBvMjNFU3BEc0YrUGNSNjE4QXdi?=
 =?utf-8?B?RlBUYXNEYk5HZm1Cc2ZhVmhLRGFLclNMRFkzOVlHVk10eWZaQ3UwN1FvVjJv?=
 =?utf-8?B?R3FZTHNURVB2ZVpoRTJHczRvazlXaGJyUDNEOFUxbzIvOFNUZ0U5UGpNekY3?=
 =?utf-8?B?Wi8zMHFsWTkyVDJoeFpEaG83OXhEd3dxendBN0k5dmM3dzV5aWlWcXo4NmN5?=
 =?utf-8?B?ZHBhcXVMdzdnaWo0cTNRRjNtY2ZXLzAxc3VsWmJsYjBXN2ZmN01DOEpqWXE0?=
 =?utf-8?B?djc4bThTaWhDYTFVNUZKSlVWK0t1VDQ1MnFQWkFFUmpqMHZrTEx2NFNaVlNv?=
 =?utf-8?B?Vk1QN0dqYjBvZzY2U0pzajBrVEkyZEtOcGxCUTVBUktWeWo0MzhQcXE0eWVC?=
 =?utf-8?B?Q0dkWS8zMHRIbGh0MnQvMk9mczR4ZFpTT3U4RGI4MDhvWHBxVVdsdnRIVFhl?=
 =?utf-8?B?M1hvQVlrQnF2ZEk3amdpQUExbC9LdmVrKy9YcGdxQTB1ZEQ3R0Y2ZkFzS0VW?=
 =?utf-8?B?WjNrRlBYYnIxT3hIcnB0c280ck1JZDBOcXN3eHJBbjYvZWp2VHZmUjNtcURK?=
 =?utf-8?Q?v5wOkaPF3rtAdKsdJGVpN+lcP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47df804-c8a4-469d-86cb-08dc5fc5d4a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:37:26.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dT7tkF5oJL8DXsuXl+XiVAx1B6CVThUtQYWCS6xyBce8O3wadxuv1h0uGIgSYgluNFf4BaWYoiVo0SpvjHMazg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8681

Add fec2 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index c8b24c46c30a4..09f2d3e76a3fe 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -40,6 +40,15 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		enable-active-high;
 	};
 
+	reg_fec2_supply: fec2_nvcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fec2_nvcc";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_can01_en: regulator-can01-gen {
 		compatible = "regulator-fixed";
 		regulator-name = "can01-en";
@@ -382,6 +391,19 @@ ethphy1: ethernet-phy@1 {
 	};
 };
 
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec2>;
+	phy-mode = "rgmii-txid";
+	phy-handle = <&ethphy1>;
+	phy-supply = <&reg_fec2_supply>;
+	nvmem-cells = <&fec_mac1>;
+	nvmem-cell-names = "mac-address";
+	rx-internal-delay-ps = <2000>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -501,6 +523,24 @@ IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
 		>;
 	};
 
+	pinctrl_fec2: fec2grp {
+		fsl,pins = <
+			IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETA_PAD		0x000014a0
+			IMX8QM_ENET1_RGMII_TX_CTL_CONN_ENET1_RGMII_TX_CTL	0x00000060
+			IMX8QM_ENET1_RGMII_TXC_CONN_ENET1_RGMII_TXC		0x00000060
+			IMX8QM_ENET1_RGMII_TXD0_CONN_ENET1_RGMII_TXD0		0x00000060
+			IMX8QM_ENET1_RGMII_TXD1_CONN_ENET1_RGMII_TXD1		0x00000060
+			IMX8QM_ENET1_RGMII_TXD2_CONN_ENET1_RGMII_TXD2		0x00000060
+			IMX8QM_ENET1_RGMII_TXD3_CONN_ENET1_RGMII_TXD3		0x00000060
+			IMX8QM_ENET1_RGMII_RXC_CONN_ENET1_RGMII_RXC		0x00000060
+			IMX8QM_ENET1_RGMII_RX_CTL_CONN_ENET1_RGMII_RX_CTL	0x00000060
+			IMX8QM_ENET1_RGMII_RXD0_CONN_ENET1_RGMII_RXD0		0x00000060
+			IMX8QM_ENET1_RGMII_RXD1_CONN_ENET1_RGMII_RXD1		0x00000060
+			IMX8QM_ENET1_RGMII_RXD2_CONN_ENET1_RGMII_RXD2		0x00000060
+			IMX8QM_ENET1_RGMII_RXD3_CONN_ENET1_RGMII_RXD3		0x00000060
+		>;
+	};
+
 	pinctrl_flexcan1: flexcan0grp {
 		fsl,pins = <
 			IMX8QM_FLEXCAN0_TX_DMA_FLEXCAN0_TX            0x21

-- 
2.34.1


