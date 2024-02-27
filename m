Return-Path: <linux-kernel+bounces-83934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D3486A03E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C821F23B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D01149399;
	Tue, 27 Feb 2024 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c5GuIbyA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F651C50;
	Tue, 27 Feb 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062275; cv=fail; b=PLzQh7F7+B2bvn5J6bvuU0S1DWMZtcs5yjHRON/tArtGT1lJVZ2b7VvZdSQEjAwG8zr9T0K8pqgyZuCggKCjM7KSqaJvaVzN7TEf+0woWgp7h3sRc+dRASUXkKyUbQVGx3bJFK/9u92qCtbCIjRWBb7eVFv1BcsucrLO4ZLyICc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062275; c=relaxed/simple;
	bh=PdwhlRBhVaOuMCnjClwbj4R8cI2uD0jRnyx6xHGyvI4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UH7eItUNTxhoCKgweO8OQc9UNr+BAvCqX/8q53/rKKymcAMkt2VajWAiJAteIyW8EGtKDHXaVmqHwqYyxZXsLMFGxk7KGYIT4gPUDhQuqaUmc3ArJYzGSAw8jOgYgul4y+G5CkZc7Y8AWURV2UfYKwh78Aq7ehaUp0asAd0o9hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c5GuIbyA; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp5Mly4Y6+EPHQyFTHNexrhLfI7SbxepQRtCEZiljXlA3avbeW+vc/OIHuyldoeQksF8T56cx5ZWXvxmF8hjw9IRLWJrObaUPe/7i+WAvLmGUuVHMDfFFs4lr8DhVfemzFjmDuSvkuJoKBbelbF5RY/6Tr2NVG6P7C8rJ9CVqaNIfn+rAeLzTUmj6zemWz2UE9lY4SzKDnwdHpo065tzTJavmgOJtE16R8yDXqI22xALbNhd1JBOX5ch13WPdu/a05UFPQqsldXvMCukzOmYbsP1rVTBDOV1enUg7dLJ3ZXUO56AVLAPyWzWtpYq1jGnKVSAuxFzuxzBaxsXhOZTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN9RtW9mIrr0nnL4TcY/7557yfJkBbT5/Aeitge+tZY=;
 b=hkqyrOCbsaF1qdzecm7GDkvKJSmUTztz2sJc5gqhB93T1ympZ6Le202Djwdk10Jnvf5tiCXfvqBztSpQmoVXBSZCivI3hW1ORh8XUy75aGo94Gr+6nK9vOHO0eY/YhLEssY2Sm4fijj2X49EjwRx6w2U2SV9M2gMBIq9GDhfe4IwF7pR4f6SzzyiqDxATBMs3Dd+sj/OSMAV+OHGW81BpAx1mk+pg0yirub947e/nNRrLHPGQSQPTBo04HqJLDm6R/udKPWT5HSqDW+tjcgK+G7JL6K387YCJeLOnsQrAT1HEZMYi+ob8/fdtBDajnibjRulSk43XozfC87/10Em3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN9RtW9mIrr0nnL4TcY/7557yfJkBbT5/Aeitge+tZY=;
 b=c5GuIbyArvfqL7rTYjwrLBdHCdZ0o4oB/DGQBNwg2rFZ/JLTZdJZc9l8bp6a/Vp+O04kcl3gmgfIBmmG19GuJYVMnPAak7WCak+GTMcqUoExqppeJXOaziutZQPAX2M8Z7shZkd39ow5mu7jRFhrzTwnlpPcb6rl9KMAPiLMKEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10283.eurprd04.prod.outlook.com (2603:10a6:102:463::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 19:31:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 19:31:11 +0000
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
Subject: [PATCH v2 2/3] arm64: dts: imx8qm-mek: add lpspi2 support
Date: Tue, 27 Feb 2024 14:30:47 -0500
Message-Id: <20240227193049.457426-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227193049.457426-1-Frank.Li@nxp.com>
References: <20240227193049.457426-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10283:EE_
X-MS-Office365-Filtering-Correlation-Id: 3868f2ad-fd81-4448-dca9-08dc37caa7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A3Wxl1Nlgbitjs0qI4cBm01s5qyNmqoppBnlplNgbmBC8rhkaB2znmkfelWZVwbaAWmK7EsuXl7jqqwdXIBdWvGUhnnOKhd27aNxYfou54Pjj1gRZ6cn/arQ5e6S4v6Djlk3IkCUmTc0eyFLaX3E79Vgi9zqK/Dun1K2o6RNXdT1JChiUWnD4BLX16owBiZhCJbPuHUzJbcV3oIF7ZKLMRC9RtXb3Fv9yCFxDEQCdmxaYPkheosvLcb21MYioUgR13eimjc0XsJ+dQ4ksp1DfXRdGIk11f1H/UUqYTK+CKGsPoP9D7TkYZHMZDOnI5i1TUp78rQT922vUCS50g7FFN6Ku+j18HD3iY/+R+te8n6F83Xy2oEBKybqVYDKJq8R+prrYKMMkfgx3JKLfxWzvU0lGlcsOlaZtJ7lrahdVVU0zXZBT+P8MGVbaqjGjYUJSEOyZf7zzNUpp9F5/Nr+OpGSlfe0a7ifSdSo+1Iz169U6dIhfbug93oADc/tLXObt701dW1b943Obasy053XzQj6q4uvpCsDqBxEuGSh62E/aQvUEdQAwejSORwHOfSznBYo3TNACRazNZPQTZ/OPKz0eu2iiVY0g5036iI1qmhrMB5IMw1jCW93ihSVK3ZQztl3pU08vA+yEtZU/znGSreroZGPcNPAnGOKhlvaZ1Lm7stS+pAx1RUQ2AnBYERQAAQ5ShZ3RH/nFghZ6J9UEV7HlzErxNIY/pTX+h1d/ug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sIIwc828dB/qGH4eW+SUM376pNL1uYefmahavee+TAyVo738NUoBQplUjL48?=
 =?us-ascii?Q?yV2kCJG0IcRAvcEiaK7St/mEB5YtNvzE9jlkMQX+KCAO59524qiVDvCBaHrt?=
 =?us-ascii?Q?y26Fv9lVsel2gp0SPEgU5vMTrZXbb9k39El6X+3F6j8S12VGhEBHsk3Amcl9?=
 =?us-ascii?Q?x0h8+jQDLaw7XoYC9C1s7WbSSR3dX/DbxqXI897qhdIGiPLGzNaxZZu8AOCA?=
 =?us-ascii?Q?GpfAhCVXXiy+zoqLU736n+F5cIgKQvYW+cq9PuuQkSIJYc5gwxwtosb5qpDT?=
 =?us-ascii?Q?Iy0qKKqb2oKRMEZOS56GqWF/2dRyPz3/YyQw2QvNUUHN4hfjOsuff7yaWHSD?=
 =?us-ascii?Q?IxxgxzRCO6BWWKL3oBvE9WBO2YTsFMkPUJU4jMtv6fnSkJ0tW/R3AYrWzWaH?=
 =?us-ascii?Q?2otRIMpX1H/K5HqN/eE+fMtbXPWvH2sR/Lpf3EyVxvo+FZFjJ1YdTzlPPCvp?=
 =?us-ascii?Q?4r754s57Z6QBrpLhgqkQfWNEntfRpXVcLehiwDdZP1uNVTGCSEUKsa0ihHgO?=
 =?us-ascii?Q?mHnt5bEQ2MV0C97dYv6DSDrUS8BlgSeXSrjjrV+EffbzWwRz2O3CwlFVuB/Y?=
 =?us-ascii?Q?CrYUeZfNmzffQp5wQv+VKRrVzSIUahnPfRcvhQBFMeG2sR5kx83P6jGGu11n?=
 =?us-ascii?Q?9962PlossvJO8qECrpYymSp87m53E5NeZQsH1Iexifkv23r1Vvd/1jTYzjko?=
 =?us-ascii?Q?svuHYaskrMLP1i61tt+pukYJQrKNtl6TGECrOQABSsQtR+sMHr+NIJ3dZvXb?=
 =?us-ascii?Q?MXJj3V3Qq9mU6P20TbmEzo9i9R9yV8VtkHG7qZQWQixoH1Mc/ZiEfxNTL0VO?=
 =?us-ascii?Q?x4UWQNi/AIkBrEaeH3z+jJO5HYf2mjfoWiSqdXId//xY9SgLqmVLFKH2B5nR?=
 =?us-ascii?Q?ZmZtGJ2xKVlYrx6hGba2z8C3XL4MoqL2sAo5Q3Fs5VQax9WI0LTEBRP/JWj0?=
 =?us-ascii?Q?WLgItRrDQ6OkwGbn4S5GvJbLV+AaLyR5CKxj/5f65ndGhmR2NV9DyR29aL34?=
 =?us-ascii?Q?1LAbU+/MWfuiXYeK6QJf4LRuzCc4WtnC2THB/cgkiwdfGHo9IqAe1as+L7MD?=
 =?us-ascii?Q?KK1IKNvQ/JbrJ1EiwnS1yHw3pmrjALQcp+WzACqQ+OYvLWRnwoemJ1/IAkb7?=
 =?us-ascii?Q?I5BGzh4eLX4Hi5vA8g4yAf2hetd0P9UGopat4824/PJjybyU7pfG5Dq7eoLd?=
 =?us-ascii?Q?570797WKxnzVPwsrI487KI/Frv27u4ozIPjyPThGGDHIAFovQFCEAN76w6CR?=
 =?us-ascii?Q?tR8Rxf2E17kp+rvEMO7NrJuyiHPHfSX/UNhh5lMTY0AdL8OsDniJ10XwBLUV?=
 =?us-ascii?Q?B67vy+RMMf0+EodmEgzsuEiHwRB0mpFJNIfGc5J63I57wbUNpB4tz847qMNl?=
 =?us-ascii?Q?GjCi/4IhIUI+a4GZ9dVWujOlLWfdhNYpXJqv/rncPj7y3G17ii/DR/iEEPs7?=
 =?us-ascii?Q?4C4wemLodegn+S657qBx9DeKQV3NlWN+nTNAnHtofCb3dXs8ExvSn1B7lA8C?=
 =?us-ascii?Q?RPTwVMEJmYPJ1CvXXGCP7BIHvXXU7mQM2H2SwtPsgo1W1g1j6d/kn1+2l4FA?=
 =?us-ascii?Q?zBILt/pNtI6iEMLS9AXRtVr/IyRoBkAIG27bcEEL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3868f2ad-fd81-4448-dca9-08dc37caa7b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 19:31:11.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTpF5bJw7vhjSeRfdRVKYckOOqOYaaaUvjrl+y6W+YgiQOslUnjUTgxwgpXalJtSbUxrAv5rr+cqyQEvpN0sYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10283

Add lpspi2 support for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - remove unused property fsl,spi-num-chipselects = <1>;
    - rename lpspi2cs to lpspi2csgrp to fixed DTB_CHECK warning

 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 0c4972724b041..66e0400d7bf8a 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -85,6 +85,21 @@ &lpuart3 {
 	status = "okay";
 };
 
+&lpspi2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi2 &pinctrl_lpspi2_cs>;
+	cs-gpios = <&lsio_gpio3 10 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	spidev0: spi@0 {
+		reg = <0>;
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <30000000>;
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
@@ -169,6 +184,20 @@ IMX8QM_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
 		>;
 	};
 
+	pinctrl_lpspi2: lpspi2grp {
+		fsl,pins = <
+			IMX8QM_SPI2_SCK_DMA_SPI2_SCK		0x06000040
+			IMX8QM_SPI2_SDO_DMA_SPI2_SDO		0x06000040
+			IMX8QM_SPI2_SDI_DMA_SPI2_SDI		0x06000040
+		>;
+	};
+
+	pinctrl_lpspi2_cs: lpspi2csgrp {
+		fsl,pins = <
+			IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
+		>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020
-- 
2.34.1


