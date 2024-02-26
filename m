Return-Path: <linux-kernel+bounces-82293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489118681F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A031C23FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED770131E25;
	Mon, 26 Feb 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DoyYUA3i"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1E131723;
	Mon, 26 Feb 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979668; cv=fail; b=SwuUsxkdU+iUX+QY6ZC4+qQZxiAqdp5SCVk/IOMBF6cVEgBMsfPt/1dQOmOPgnLN099G7TWBHESnegSoVWpNCqf9LWwJuRnN0rJLtE4v8cUeFadDkIOHWyBZrNiRsmHhpRJpvrI23fe/pfh0f1Mmu5HuiUxffWLILaCOsCPGXBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979668; c=relaxed/simple;
	bh=RalpsgDEhFuwbr13RLo8XzOFoO+R11/hLWW7jPiFWhk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pnCptqrSKLAhPZpa3zjo5GI5aZESI1Yqx/xfVftk8rxJFD+rlelkauIa4NWUx/sYw2U2YmtAWTrE9olhZjpOvaUGK8TEtibjrRWkXcIQcaevzGEZehPJOGQ5JSUm1JqQtO5QtkmcQjVhqcMWOBYXEZTqmgd6ZVNLJtzHey33a40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DoyYUA3i; arc=fail smtp.client-ip=40.107.14.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3GAnXPEaaZbVv2WMZSWK+ZKIqKJWPFC61v9XtVG5ELgbS6o8o7TO6el4NxcmiYthrOcUsZHhedziowZXq7HhX3XQM4sL5GHbzwJc8Aq1EbyYNkemswvalEVtdRVLAtV3+H/WIyGyg/hw++VqQ4uHMj6GH+aYXD4Nb601EXvhhsiLacTH0ppgafAr+oepw/1I8g3HU8pWRbs9f1lGb86onoAfcCadctQcTP85ddB148a0sRuAs74WoBFOV6uiYhWlf+qu82L44ywQXUgYtyuOUAKEWLtVxtbBmDKiSFMPKfwtpJ07kHrjDBmpId2j9iRFkm0DL5R8lR7AE8rotuSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94elUAyqTRsGdLlF8H+i+PTZkxKog/OG+KH62Wpp7WY=;
 b=RKHkeV6jvgNafsiYq70TjiXpC9MQujNx4EJwapZR0r6UAZGQCrbCPw/Ma0+DSGiVaBTCN7bK1zAQBN1J98wQym6sYZoYgdJ+snuWAnbNAqT8I71GtxsBZft6aN/19TkSKCbw2pbtEubUW03Vk5tyZvGG6ptZDRmHi1/JKOaxDS5hTHJ8WhmaJdGps5uo/1WunnfpEMhQ2N3Uzq81gkmPJgha4xHa19uOwL6bl5NWYT4eArR3JzQgb5h9vFcM3UDQcHj4vpKg81HTIX/hueNtuFaFU8zi/KUusNnO6hQIlyuKeU7FKcpSGmW5p6+SKXO6i5GKb4rcr1ClD1GXsEaZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94elUAyqTRsGdLlF8H+i+PTZkxKog/OG+KH62Wpp7WY=;
 b=DoyYUA3i4v7vy0ooQ+9/i9m6nCy+3yXW8wC69/WS2jd7LMqJ2SpZks6wqvBpo+aEbd8qKyRsWushETfoKRNQab0wkMF0u2PTsUto+3l0MD+PAcUvtmvfuXeTSkH9NgLMyuAqCI8SHICo2Iff3lMk20ojv8W9apLangwHsy6Wvkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 20:34:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 20:34:23 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] arm64: dts: imx8qm-mek: add flexspi0 support
Date: Mon, 26 Feb 2024 15:33:57 -0500
Message-Id: <20240226203358.275986-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226203358.275986-1-Frank.Li@nxp.com>
References: <20240226203358.275986-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd76360-5fab-4c8c-acfa-08dc370a516d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qiyi189Bo+0DtnrUH1HSsHpSt803z81B/XCbsqfe+7Jdku5hh0H2Cg7xYXNAMCMY87kydnck96WxZwuSBkG087lqVGoVjy2uioo4WKeMd41bedZV9fABHdT7vMs6TNaDI+9lysNxL8q2sJMxk+KuwAP1q7PANBYtF4n8Rt6QqaFc6WLdrEsNJPr0CTk5Df1XARofPwhaMrmS0qROJI0Nj92TrBA7Xd0ndtJWHzMrGWIheNecJ5GDUk/fGD+h5E7rJjmFBwhhChlgimAIf86nVA1FX1LVifhFwID+KksHk7QyanzEv6w61XdAOQVDk2eZ8IZAA4WEu97K6gSsGzAlYRedyCnp7ois+6tFcbv7kXNgwPxfSsdsz6f232psk4pJWXnFXXGkylMZ8uResEicbBcEPD/xsDTNu5H5soolFjyjO1l2r2s+mE2gnF/XKN1WYjSQMCuTBkh4YdJjhDmXf/IlovlVrrzKjpXuS7a80vTKyU4VusduxEVRwksKB7IOVgma560zVRaZSarYltRalY1tiRKEZF/bj0aUN6HIdPq5oNHf79rT9vj0OXiQamU7Xq0s2zsnIPTDBHuf85fQt8b8HDALxZSzDgLEwgIVnoGGxRgLsckdMklNdl9tqeLoWG6Z4zbs5GdcnaqUfevK3nV3toay73KRPnO2wop25tl70pTZst5wg8HP9n+MHDnqW4NP97X8UxcZg5lWGKVuTAkqe5AoDaaowegpwLNX3e8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wlnoZ7Ly2BPYptg7lvVMeIdgQjsFeTdbbAw7+og7sS4NnhXYJVH2rj26jg8?=
 =?us-ascii?Q?gv7ARylD9OYH0vOUhVeFBhmNUPxxxoH+/Gtr2BdAr4pTHqn4gJW2wX2OMefT?=
 =?us-ascii?Q?dJHLxIqC+wkLUArZ4yNsgUXa9xwJxBdz/GbN5Im5ANot1eaue3CUESXFrFIt?=
 =?us-ascii?Q?MRJNHwqdSWEbINfJEFcnYUCkf1xP/mrTblXKgKNnLruaAI3DVXu3J81nPa2d?=
 =?us-ascii?Q?sceN/K5pzywv81P/cyFnUq8S+y/Z2TGza0kkolMWmbjtB2QFRBr+dwc1Xc75?=
 =?us-ascii?Q?rLF0yxqO9IOgTONdWWE9x5p9EVql+xwGkVLpsW7HHr5qTTFp4S0TYQ9HkzZZ?=
 =?us-ascii?Q?NUR1LeWid8AqiXm4bpz3avmMgz2DOt4E24B/Wj+yJo4fi+9ZmoBQEX0QB1kO?=
 =?us-ascii?Q?WEyxPoPuwXfI5TtOvnc+q64efcdNx/mRGGVSiti0GoDYUAYYq29WBZFsV+Da?=
 =?us-ascii?Q?ItorMJ3dLc7ZG/frnhng2DQ/gqxB1iv5DNgmMPZUqKdPKD16BYBurXQ/xwwq?=
 =?us-ascii?Q?oGwy1qmoSAKCRZYrycWeCmL6ae9FFDQBaM9hYrdxv1cWsP08kTgt5HyY0dCV?=
 =?us-ascii?Q?TlNNNxMSiUNr9lpU6h2rW/pa5Z8L1fnNMPmb14FPFt9Wb8SMgp4gs8SVSCrj?=
 =?us-ascii?Q?sWyguGpLa74YiCe6uqmFTYoWBDyhu6alkEkFD6hC9IHzV3ajMk7DE41pCTtF?=
 =?us-ascii?Q?7OCbHF7wbHPffLBX04pfRSniVQiLhkj7MUr4wdF4R+Y1NbfhNB2yJtrz/t83?=
 =?us-ascii?Q?0IlJe8jX2z1hjDwCUgoZ+33WrjSQdyAgnfxHbOeNtUg90hfzlitBQ0+hpC/I?=
 =?us-ascii?Q?AkSbhv7ufZkCdOnt+Qu/BZMtg7XRFIDBREtb+7hR6J0nh1RF7438sWLLqVqU?=
 =?us-ascii?Q?OuOnAMxksVvWlcpsxda/0AJ9e/hFV7WPctw2F+uCZOSiheKk1c2SL0YFeVDL?=
 =?us-ascii?Q?h5rdMV4Q87E3Xxnkkk64D5gUlyguQuEyCxvqdwfv0Qn1wM0GfPpzQsL8taTk?=
 =?us-ascii?Q?KEIFHsmX8BLtLCq8v3rZkGQ7f9Yk5dPE1wXuAEZP1QjTKal3xuWbbW0d/Wdm?=
 =?us-ascii?Q?/k23zypqYO1/MHekfwjAwjQ+G48QWW6XeahZQr0YQ6VeWVuIilBQamwtv0bP?=
 =?us-ascii?Q?b8NIqgq09SeROMhrWOhfCN53NNYbnvQGVGJIiJrSoIggdvKfYDZqzIFnCWtA?=
 =?us-ascii?Q?bsOrAmJB8Oui2hlYI+wvwSZjD+ouOkxloyMO2BlhmYtP3q/FJVFU4Jlsv2tH?=
 =?us-ascii?Q?GPnx8TZYfOR4pLPTX0j0VbHRYpO9+TBk7Rq8wXg31s3yB/cqQ3yubhCEYwgd?=
 =?us-ascii?Q?Ffd6/6RcroisK+XMTMsYaKc+AG4xjU62jNxJqjfrXXaaQ3rCmHNYv9Z/qkvW?=
 =?us-ascii?Q?RVLsxd9SodCwKRlmCdFUInls4joV54mVtQJTqSL65AEQ5pa74jheVo/n5ECj?=
 =?us-ascii?Q?IAF+kHsiyiMj8Wmth1qZfqQqOUQicGd9CfpzgkLzyDigaC/bRFaqTCedOSv/?=
 =?us-ascii?Q?/iUQC0oSYFz82fmBRsR4xA4K70wxxmPxPpHDVhvER5GBJLn879XUbZRH36hs?=
 =?us-ascii?Q?BP2fJUMTmOvuQXRgNVe2Rqw1Tf7K1HramOj1NSxb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd76360-5fab-4c8c-acfa-08dc370a516d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 20:34:23.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhUAmzOcaFJu5noBPAwwkizjj9Dq7AP3mG8lUMHsAVQhPRw1hZmWCnboju1p30ragwfGJKpRTyTt4HxribCoZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

Add flexspi0 support for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 800dcb67642b1..7077e394e855b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -101,6 +101,23 @@ spidev0: spi@0 {
 	};
 };
 
+&flexspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	nxp,fspi-dll-slvdly = <4>;
+	status = "okay";
+
+	flash0: mt35xu512aba@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
@@ -199,6 +216,27 @@ IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021
+			IMX8QM_QSPI0A_DATA1_LSIO_QSPI0A_DATA1     0x06000021
+			IMX8QM_QSPI0A_DATA2_LSIO_QSPI0A_DATA2     0x06000021
+			IMX8QM_QSPI0A_DATA3_LSIO_QSPI0A_DATA3     0x06000021
+			IMX8QM_QSPI0A_DQS_LSIO_QSPI0A_DQS         0x06000021
+			IMX8QM_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B     0x06000021
+			IMX8QM_QSPI0A_SS1_B_LSIO_QSPI0A_SS1_B     0x06000021
+			IMX8QM_QSPI0A_SCLK_LSIO_QSPI0A_SCLK       0x06000021
+			IMX8QM_QSPI0B_SCLK_LSIO_QSPI0B_SCLK       0x06000021
+			IMX8QM_QSPI0B_DATA0_LSIO_QSPI0B_DATA0     0x06000021
+			IMX8QM_QSPI0B_DATA1_LSIO_QSPI0B_DATA1     0x06000021
+			IMX8QM_QSPI0B_DATA2_LSIO_QSPI0B_DATA2     0x06000021
+			IMX8QM_QSPI0B_DATA3_LSIO_QSPI0B_DATA3     0x06000021
+			IMX8QM_QSPI0B_DQS_LSIO_QSPI0B_DQS         0x06000021
+			IMX8QM_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B     0x06000021
+			IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
+		>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020
-- 
2.34.1


