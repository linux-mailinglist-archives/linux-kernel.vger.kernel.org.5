Return-Path: <linux-kernel+bounces-74172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E285D0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54142833BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CE03C461;
	Wed, 21 Feb 2024 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZKELYpOX"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD43BB4C;
	Wed, 21 Feb 2024 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498329; cv=fail; b=IJXJpDEoMxVBYsHDqqudsC1PypI7sh5Gx+jkuzClFPxCXRmbWdDHTGv225oEjiGfvFrZjmpmRiIIaPnPBAW6IFf9/JDEztCWVL5ZSligK5liXe/0USxiW1I25vBZOuW7CjSluF0ACr6H4KFEHWpBP2+RpEeOaDM2RKgMopveWcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498329; c=relaxed/simple;
	bh=jmsEIIrxVlsX8CR5LTLM+eaREHvOtDv5OZFe5RyBabA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivzUrFw041kk48kVOrAmunC7Dx+o4cKsYX2CtB6unXESmUhBTpgdRI9da0ZQLm5BIf2Hyk2Q85iNoozVDrr+qarRz1tTa0Mhu40dyQhb6N80UZ3KEAH2E4YBUyxYTivoh8kNW0xldLbTu1Qr6JR+KAA3FRsX4XG9ddGJeHBYZds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZKELYpOX; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOrllwEw8iiZDWecjB3Dbe4ME2XUzKzW0Xfa1Wl3+WtwWXr5wlDQPkkytZ5N8B6e2o8Tnx85B7eWJBBeI14Gl+/KE5VnUf4esjDjjg9bgxxqC83eavg9ou7QAbQrxKaYfIzflONeFP+P2XTTd4lbF7jsr7ZmhRLtm6oYroBgYcFC0NpeIbCe8Z8sBWlg5yAuruFn599LQ3kPPlkl0oh2IhNekh0/6vJ8CzkH727Qk7EBZS6xGFUfuHeP643jCJMrWu4qHogNbhHNhn1DD4NqeTaZzTZaL9+VXjYXTse19V8VNYnzwBBolhcXTK2HEtyF263Y1XC7dTl3hIrOco+eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZk5CIesGMDmmmZaQzckc0HoESG5V5PKQKLRWtDUAh4=;
 b=geMeHv+kYVtGwNRUS21odi+bIXteF+ePX7vQl2ByOmSp5WMFHCYqp76UO1srpcswgrM5p2ohCpRqt4jXnIQSZw0MUx+lK0cshaCQFjwoviXFXl9kfZMsLAENRd81Fli6dAHQYHL3Rc4hBye1zUDQuM434LQd8B91Tr9x6wcVQxLuAEWrVDZPQSkMJ7OIRYpCyBS1xVS6EyaVmaq88jsW6+NgoGj/OOM+Iffl3f5+M2iXczuTh5B40rQT177VqRsbdqf7oUswZPNqwj1vf5LybHV8J1UZpfP78zxhMI5UH8VvgbvCRBOcYdYsaOV2T7CR7mrdpSSTeXryceJGtZKPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZk5CIesGMDmmmZaQzckc0HoESG5V5PKQKLRWtDUAh4=;
 b=ZKELYpOXAbYkxpW3+Ga2QLXvPAWpAyTBxTRKzkgJfSnwQfMbEevZb/J/3WYuEXA3jX0sq1rslU4AAyFoMN8q1zGImmL2ModFAIUHQ0+35ETcJt0RewkPiTxLxmBWoDS3NUCqVmMRTTbJFR8sa5WVOiJRe8Kjn0zeAJqdYkafupg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 06:52:04 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 06:52:04 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/9] arm64: dts: imx93: add usb nodes
Date: Wed, 21 Feb 2024 22:58:44 +0800
Message-Id: <20240221145846.1611627-7-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221145846.1611627-1-xu.yang_2@nxp.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: abb3210b-d687-4441-53db-08dc32a99cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dpAngd5wMFCdJryE63OFi1VxrdGH8IrSAh8jbCNmwJBWI/LQaqRDUCPMPqD2GZL6DEYpFxSvsxyyaidlcCxjRzaCdESwxXCZrwoL6WaBXYarP1+avEm3zgOsBU2D+vD7I+wsoxaeTeQoKKHbGnF1sJUm54KshN7pnJuDW2DlIAbA/mHOzkMzjbpG+8QGZ20tuEEtWvXwgGHd4taidbsXxVHV/vJTh0kjx0BykbvsBBMG7pzkkjcyE1efSPXtZLAQoD/2hYXnEo2RpAjwTk4QunKxHmxfYxFrgDXOf+6Ch1A9LNZqvEuxoxeQUbQtl+KPOtOpcxZnXXIlhGBqHfck7trLUcpWseKXpx0W4XHU954G48jnN6DiB1O80iHgM4vogEH8SCrLyOg6Kj1nWb/ASRiNrRcuvoq2NTwNaB8zs+E06BevpqjL7qjidwmwmuxoZRqlHM+jCMtGCLA8Fe4J8+KtVE55+S6Es8M92outcRBMDRWq0msBtsL2/+jcRFIU1oyGfm9psb4GOmAxaOdYw3JIh/JF/lMStdEvshlsUAxIpJOXwA5YxYTZqrS4M+Nb/rMAdzPAp7Am/X1q0m/pM6N1h8jtzS8QQAr3LKcmdQKJoniKe0eK4io0nwtgqQFm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dJAGliZ5ZwwvM1U+wH7eYXxqr8eqmEex9YjDbZePm6ewrvBgb+sJyC1Gqz0b?=
 =?us-ascii?Q?mf0d/AeBIbEKUAIUvgbZN/khZsZX+a10v911n9Aow1lYV6JZHqasKbxgNMBU?=
 =?us-ascii?Q?gax/cctJelOTv7xmQoWixQmZ472OY4k/lpRESMQynlgVZJleFVJlVLgMtSXc?=
 =?us-ascii?Q?k2akiYMzrvs0sA+aZa1UAju/m+kXFY4KNqc3WFHTI13Youvcxd7UV+d8UwUQ?=
 =?us-ascii?Q?ykbiWRQQN0ueYb0HS88TJvQuOMdjZN1o1LRabFLre0s5GADy0Rb9XfVO16VB?=
 =?us-ascii?Q?yljcFKxz3neJAAO9ulFiGmuIMTqM/BwN8gWObakgOvbtU3HN47Yhi7u5CttN?=
 =?us-ascii?Q?vFFQ0xDe9zHaKXpJLXBzFb6WNTqOa1BeW0crhauJ7tK5g7JXdd0rnM1RAzYg?=
 =?us-ascii?Q?p4l9CUSLqS04yV+nr0e31v5JjaTMa3jG7v1juHLONHyfwRNvTPcIZ976GIkV?=
 =?us-ascii?Q?/KxuvsCICux/I5E6nz7g+vfvvCvmAZWvH/h4lzB3PfHLvS6SwHc/wzrRQW5V?=
 =?us-ascii?Q?AbFlgJObSvJk4dMTIIo4SHIZFuKkKjxtQCKNRK/SbNN/AVMRfV+cOg/keRg9?=
 =?us-ascii?Q?W650tPs1ALru1pNE3BxtV7dQFoYgEYMDctcW2xEQPivFEKOZq5THKdJMUmRr?=
 =?us-ascii?Q?0QedD/T+Wx1AtU+ytU1GzDwQEJhtz69WFqU3ttraDpB4HUcYbAHk3Shly2X5?=
 =?us-ascii?Q?D+5g7hQMZtMiUN1wx+Co7uGcBzQe/M0xa/NN1n51wO0z/mAsENUfOREJlhNO?=
 =?us-ascii?Q?L9IO0d//XJIKPwFcdrg5GdgcILqAHX2LhrpNK+rK8oL5/Jy0CQvXFOwkSjnk?=
 =?us-ascii?Q?PTdvFX33vmGn2jiWOEYS4WaPZi+UBzIoAXk3TGyget1Uz556QWH30OolUj+u?=
 =?us-ascii?Q?/cC5b5S3MEFA1S4E22Z0OAntLFxZT2vEHUzhE/475DhxddJ0ERocomT5cJb/?=
 =?us-ascii?Q?ORvxXbkstwr3QERH6V1rHOueosIW2wRKlA7iEQTgs+PqZCI39q9BLS7d4N9Y?=
 =?us-ascii?Q?YMIKQcP9tX6bm/SOwUrdzmnkpX+4wk3wD242P8UFwy4KHAW9zfQHWL1h4juJ?=
 =?us-ascii?Q?Apz7dkNoW8Gn6WL21fTQexBT9Frxf3BbKE+4GiT+119AtiGv30/WZfvIXWvN?=
 =?us-ascii?Q?QhIH8al20IlB3MNynyLU4LkhfXVtpeZssEX3t1C1cgWzX0A18kJNZ78t/fub?=
 =?us-ascii?Q?Qf+GsEMXr3/jMcKHSOZU2sQVgi+ArNMuq4Q6hOVfkGmHirRsVLCSiiTMJJfy?=
 =?us-ascii?Q?zFiG28YrRiYEJcQ1ZULoPQGUg8j0VGUqGt8RKnN8so/4AYl0Cd8C8y7RNfRf?=
 =?us-ascii?Q?ykynoAtLQlvWfvkSxRVO8v7j5CYFWG8Bc18r6UeYnosEYHbaaOOUSmo+Iwt+?=
 =?us-ascii?Q?NK0a3nMDgmYppmLDDygqtxFv9dCXZ2lhyxDe31VCoK3sn9m5UKpECb/szQm4?=
 =?us-ascii?Q?e0PLJ3X2IfBw8225nKI64+NcojJaMImBWzjlm0uHZmOoilGIGigP5RlxXQvR?=
 =?us-ascii?Q?2eGmv4Qx4DnaCq9zr2qX/01/KG83HpXFh69ZV2RVuKvQIqCcygMunQRpZUI3?=
 =?us-ascii?Q?/l7QiHipXiXhjZq/5LU5kMAiIo9Dhks4c7qMbV0P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb3210b-d687-4441-53db-08dc32a99cfc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:52:04.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUQHMn/vGNc8LkJx3KnqX+gPgY4XCNteEg+z4Gi+KlpdusvC7lQCPUaaCzbr75C+nxq4C9fszvzMwFzq6UZcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476

There are 2 USB controllers on i.MX93. Add them.

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa9352LA/CA
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix format as suggested by Alexander
 - change compatible from fsl,imx8mm-usb to fsl,imx93-usb
Changes in v3:
 - replace deprecated fsl,usbphy with phys as suggested by Alexander
 - reorder nodes
Changes in v4:
 - fix the alignment
Changes in v5:
 - rename usb_wakeup_clk to usb_wakeup
Changes in v6:
 - rename usb_ctrl_root_clk to usb_ctrl_root
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8f2e7c42ad6e..4a7efccb4f67 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -183,6 +183,20 @@ mqs2: mqs2 {
 		status = "disabled";
 	};
 
+	usbphynop1: usbphynop1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
+		clock-names = "main_clk";
+	};
+
+	usbphynop2: usbphynop2 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
+		clock-names = "main_clk";
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -1167,6 +1181,50 @@ media_blk_ctrl: system-controller@4ac10000 {
 			status = "disabled";
 		};
 
+		usbotg1: usb@4c100000 {
+			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+			reg = <0x4c100000 0x200>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
+				 <&clk IMX93_CLK_HSIO_32K_GATE>;
+			clock-names = "usb_ctrl_root", "usb_wakeup";
+			assigned-clocks = <&clk IMX93_CLK_HSIO>;
+			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+			assigned-clock-rates = <133000000>;
+			phys = <&usbphynop1>;
+			fsl,usbmisc = <&usbmisc1 0>;
+			status = "disabled";
+		};
+
+		usbmisc1: usbmisc@4c100200 {
+			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+				     "fsl,imx6q-usbmisc";
+			reg = <0x4c100200 0x200>;
+			#index-cells = <1>;
+		};
+
+		usbotg2: usb@4c200000 {
+			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+			reg = <0x4c200000 0x200>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
+				 <&clk IMX93_CLK_HSIO_32K_GATE>;
+			clock-names = "usb_ctrl_root", "usb_wakeup";
+			assigned-clocks = <&clk IMX93_CLK_HSIO>;
+			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+			assigned-clock-rates = <133000000>;
+			phys = <&usbphynop2>;
+			fsl,usbmisc = <&usbmisc2 0>;
+			status = "disabled";
+		};
+
+		usbmisc2: usbmisc@4c200200 {
+			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+				     "fsl,imx6q-usbmisc";
+			reg = <0x4c200200 0x200>;
+			#index-cells = <1>;
+		};
+
 		ddr-pmu@4e300dc0 {
 			compatible = "fsl,imx93-ddr-pmu";
 			reg = <0x4e300dc0 0x200>;
-- 
2.34.1


