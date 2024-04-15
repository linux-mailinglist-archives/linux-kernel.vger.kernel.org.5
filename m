Return-Path: <linux-kernel+bounces-145844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B78A5BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6851F285687
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8FB16193C;
	Mon, 15 Apr 2024 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oo32UvU7"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E1161909;
	Mon, 15 Apr 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210459; cv=fail; b=K1KEQqsI36ZJ2RWnkC1WR4P/EcdN+VUD1sqIal9ZnXv2EurGp9jfp12Y++KM7gxCQq1j1/2R/sYbpfe+rx3bHGa5+MBqsmGzdSQNW6RaP6X8oMzfupUhOi55YM7KK7tg4eCM/0OdC1VauEQYAKs3/WbDG66wgyqeWrQbNAQ6vxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210459; c=relaxed/simple;
	bh=QYcBTO0DJIGgBY1H48Gg1/3ZmHABa2cHIw+DBG2kg4k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Sw45lMt4ML7ZMYR5poi3P9+UIcf/7dn+2X41DKdUWhGHoeVrLwDfVUD7+1dRzVWAB9RvG4pcZyKYGydo0BlGQoFWB054SQmF7V+Fj4O7x+OMKT33kbWjt69y2drrIGyF62GPWver6anXb9b5OoMT03XQD6lfPpzqTzqgH0dekjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Oo32UvU7; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAMRnR9wPcWTG4kVDB/Ny6xZEcUuriXZUfKLikOOMPKVrhmMKkVA4yGeGizHwN+u+1nwSl+GWXFt5+lXaZdy88B2hhyTI4HaU3X2bPjOPwZ2d2CUeFq1pEGJsHkco2NMfUpYyzzjZro94EoA0bQlPQctxA0c50QvbWItMSGHjy+KudQJjLtvBLXeiq/SATc0sz5POIN2BNUUBQJJ4kVAxtYSaTqx6ywmwr4TjgCZBAEwdU0ByJllZB4Q/2ayo7umHz8ECC1mRtapyPMZoNTKQOrKBa6tbqxZzCsIlmL9O85T5r/WmFApGUt7kVIjUUFeJ/VpPoGrRG36niKXR6Oybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Iqg2SvkHjEtNt/RHGFIr2r2ij9ttF5UpZBwVpmIvfY=;
 b=e/maj4xVBO3hzbVOyfytt0KW0dg678KFrNpQ/3NRR9gMNjKDGdb4+fBPVMSCs07kvlF+FhP+f88O27pHmss6DGGvcRljROLpDbfUQw4uPRFoI7ZintVcRmVWsDFgbP9ILKPR7cNlXyHuLGdHiW1TCYdy8I8rzpqEt64kVEiRAaVcNh6tKz/xUXK5QpbjqMszHep2xaMTZWVK6Y0XxTtx7+qOCsxQiKC2zwIUN+Ce+RS+hCKEX6WQcI6WTq172O1Yjs2eeIUxqSixsGB/+tnFgDXOqpT7NVG24gFqknpMft72dSf3NqOjgZdsrm7wq6anZ68XPz0UjClSEIaqHp5zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Iqg2SvkHjEtNt/RHGFIr2r2ij9ttF5UpZBwVpmIvfY=;
 b=Oo32UvU7Z/Gamvz81cMKExeOD5bBMo4mED/fuisuFyM0ptbpanFCWda7TC6E6t1xOrNBslj05hpIXgEw9nspbChYZvQwSHYpRy/zngIyusBY1QnXJBqCrc/dbGhEFl+y7xDNNV+pI5BvrZxDsD/dnQZPstbn+DZ5lCKcQkIDiew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9060.eurprd04.prod.outlook.com (2603:10a6:102:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 15 Apr
 2024 19:47:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:46 -0400
Subject: [PATCH 10/10] arm64: dts: imx8qm-mek: add fec2 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-10-2976c35a0c52@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210421; l=2437;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QYcBTO0DJIGgBY1H48Gg1/3ZmHABa2cHIw+DBG2kg4k=;
 b=2qcpOpMxO5ealvsnsSKdYFDGU0oMJNHK8SOift4X89e/HomlR+qv7+VGRTaME5nykQRp7ykGr
 awCIyrtdnVLBHOE8Xvb2upc4Pxe1hhpnfnAqPZP2uYrOhZ8ZLKq1pGX
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 23229a2b-9fe9-439f-3447-08dc5d84e4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gvyuaAd0kvuFkX1TQy+MkTuNZ7UK0qFQG1BFHtNZM2Vem7M8o2t8134UZ5GoV5fqHafXtYowtd9iV9OsiT+RC06M/mUfEE+GfUAoI8DtPvOqMOGlT7NpO4/eIVbn/4gUUVtI3kz44cH2+wF0V8y1PrkH5bfmDav08N460FpEqzhwQ+aiG3teWQCMjgSBbbyAxWC4LWg9Ie79YSPhXtkTgsdaMWDCNSdMxx+UlVpHJja8YYunDT872OnSLWGRX5WB4H6A7EbMhoIOl8vfZlYh9zsSq2cg0QvBKc2LwHEwuatVbxh4XiNG4Tj0cFCthuIt9ZrQD7BPBJrztzowsCiV/gdvn8IT8+ebi+hoxEJ+SpkdpCoVTHX6U+D5doKsimOFviLnKvHrWDNM1qNsELwR8xqi4oJT9XEUl1KgfXBk2WRrL/aSlZ4k9Yymi/IqsPTAdFeH0SkH+bzPJ/Uc+UM3qhs253OjgvjPeN9Wm7F48hDscend87dSrjYrWX2rim/51JC0FjM5CeWHBc8IIuab6DEAi3w0BTMPNfJoWra6mpZEh/MM3Eg0oTaSbL1iaja1IdZioiq3MhdlsHT6z6TMn0yt2FwCu4aXIaSU0VoiZj+QfAqmuKoiOrCZh0utSlS0LU/c66MocVOpDF3FUWrZR7GlGAkgOWQeE+lOEnYQ+L+CURJeYc5TyxgPLRSf3A/Iq9gmPWXiPAexXG0tPgx73A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUt4R3JqY3E5TUxCaEg0aCtDUGtpdVd2d3BObjdybXp6dzdxUm9MblRMQ0k0?=
 =?utf-8?B?RlpPdkdhVlBwR2gzSnRiVjJxUUJoTTFQT0ZHVmRUbUM2ei96WGU5QWlDdUt4?=
 =?utf-8?B?OS9NYVpnV1RsNnBwM0p1RGtnWjhYL25Cd1luYll3cEQ1UzROOFJhK1p2UUNp?=
 =?utf-8?B?elpNcWNORjFsK2FXOVJackhwYjRyOXV3NllFb0xTRWhYUlBWS2NxNDBHdkNt?=
 =?utf-8?B?U1lLa1BySnFvSHBsdS9tUWpFMzMrZjNLL1I4dW5NUThHQzdKWUhCT29lSTIz?=
 =?utf-8?B?alBDZzBDbStyYkpQaElKUTUxKy9Nb1g4RGNpeWRPTm91VVRWb3JINXREL1Zo?=
 =?utf-8?B?Vmdlci9GRG1zd0JnQUZVaVpoa2hOWEFDbU5UT0drL2pWR1M5N3BlNXR4ZG1q?=
 =?utf-8?B?K3pheEVSbU9rcUpVVVk3WjArUzRtbHVWYjlNaGZvcG95c0YzVnRaQkY5ZjFr?=
 =?utf-8?B?Rit5dGRMUDdMdCs1WnhOQXFkYi92S3ZHTVBKRmRqYkNBbHBsS1pjd0FLN1Ji?=
 =?utf-8?B?T2NJc1JOUXJ6YmNJelVvenMxTmVMVUdKWWx6VXduVFYrV2pSQXJ3L09pSjRy?=
 =?utf-8?B?cWxZem9tK0NrTHNEajBHWGgrYy9XYi90bWxqai9BVHZ3QXYrN29JZjFtOWxF?=
 =?utf-8?B?WFprc0UxbzFqZWYxMlFEOEJSL21Od3g4QWxNMTZ1a3czWm1ZZzVxZzFob2xK?=
 =?utf-8?B?SmJGUHBoQ3c2YndOcnNuVFhGamFvWEIyZkExL0orRE45WkxibzREL2hZZ0JL?=
 =?utf-8?B?R1J5RXZDNE9DY0hKZVdzZDg4YklwWUh1blpncmdxOGJDcXFLakVTZ0h5V3RN?=
 =?utf-8?B?V3ZDaXU3akZXamNpL21RakNWVFpCNmFhVUFMeFZpaFZhRStZRjRZbkMvQXJI?=
 =?utf-8?B?emRMVHdRSjRILzd4TG9yUUU0LytramtjaU1yazYxWVIzb0EwUyt3ZlFRalNm?=
 =?utf-8?B?OGtHMXJzU1JDYnRFaHlKS0M0dnJjKzlTNG9tSGNYTU1rWGpic3NHSlZScVpv?=
 =?utf-8?B?QmpHa2VzTDRGVjczS1dvcTVlUjdPOUw2V2k0K2IycWJHVXdEVVVNMUJkZlQ5?=
 =?utf-8?B?REFwSmMyRmlBb3U1THc4a3JQbXZqTjdMQjBmRXE1STVlaDRQMW4xMFJtWkYz?=
 =?utf-8?B?Yi9ERFpjelpoTXhKMzM0NEs0enREVjlRVWx0dEprbUdHZHNFTldHem9ZaFVQ?=
 =?utf-8?B?WjdFRzhmcjE5bXRVVisrZ0hIOGoyWXlZYTJ0ZU83OXduS0FCK094L0dVanE1?=
 =?utf-8?B?MDd6cHJVVkpqZkNxVzQ1UXNWandTaVlGWW9VVG5DdEVwalhhb1l1S0NDODhV?=
 =?utf-8?B?QTlxQTJLdCttcHpVNWdFbHdPL2VRbFUyYjFwa2piT0JpZ3VGSXdIRWxJd1F6?=
 =?utf-8?B?RVdUVWZWaEE1UzNablVndGJSdnM1V2tUckYvZEcxOU5tMmlDVTNvUjBOTlhy?=
 =?utf-8?B?YW9GNzBCeXlPY1c3Q3FGb3FQZ1FhVUZ6a2xzSmZkSkVEaER3T0FVbzJ0L3Bp?=
 =?utf-8?B?bTlCYlZweTJaeXdJKzdzajNkM0ovWEJhMktMWFduSmhyZUNyak1jTXR3aENq?=
 =?utf-8?B?V21oRWdzSldUU1FWRXE3Q2hPWFdhRTI2RjN5MExXSzNXdzBhdWhXOUNWak5F?=
 =?utf-8?B?eTRSMVBpaFVhWkxHb1prM0FsUVlZY2FKc3ZFSHI4dWtjcjBWMHdMTFk4VWho?=
 =?utf-8?B?UzlGNWtaM3VxRzZWekkrbU1zVldvczlpM1JQTUxBTWZ6WkVKenlIaHZGMzJu?=
 =?utf-8?B?N285V3pYQjNzblE1QWZqS01xM05MVHNPMHZOT1pVU3c2K1h4VWxub3VKQmF2?=
 =?utf-8?B?TE9YeUUvWGlhK2t3VGRZUXo2c3pFUHJPc244QTFlS1VhMzFSQnZwVFNQTWFB?=
 =?utf-8?B?QlcrODF5MUdFUDU1QklnMHhLY3U1eUJBTGZSekhWOEJIOHBhc1hyWDVBSWdr?=
 =?utf-8?B?QlNxQTY4WXJPM0RqMDRqR0IyZEJuWVRseXh0K3dtYWUxTnNrQWozVnJ5RjZ6?=
 =?utf-8?B?dUwyUzB0QzVvYnhoemVJaGpSQUdvOGw5RmVhZGF4dnVzZzBsN1NVTVFuSnlj?=
 =?utf-8?B?d2ZnbloyYUJzR2Y4N01JWjVBK2hzQXF4TzRaV2daeTJiUkZPUy93MDVoMVVU?=
 =?utf-8?Q?+jxBcJ8c2iwVb2J6c1lhZFPmE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23229a2b-9fe9-439f-3447-08dc5d84e4db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:33.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwGkbLbVSrdkv8sl32O8TXu0Ddbkcp2OTkH0BENCSNp5G8hZ46rvm1218l+lmYjVAmkZjjkcBxP07mJhc1b2Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9060

Add fec2 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index da17161055179..84372c060e200 100644
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
+	fsl,magic-packet;
+	nvmem-cells = <&fec_mac1>;
+	nvmem-cell-names = "mac-address";
+	rx-internal-delay-ps = <2000>;
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


