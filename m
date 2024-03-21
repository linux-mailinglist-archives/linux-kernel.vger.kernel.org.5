Return-Path: <linux-kernel+bounces-109771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA3885580
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC25D1F2211A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAEA79DB1;
	Thu, 21 Mar 2024 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yoro9lSs"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66879B90;
	Thu, 21 Mar 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008911; cv=fail; b=Ive1DFhRf1oOmIZNGzRfJQmybTGBVRpl+pYRgEC10/12y1Wunf4I0lRKpDPsryPfRRxdseiXKnjmDSEwp2oCnqMmn8ZhJHxpjdmdvIqGoMj/Q2z7flmCixcyLEHIde3b/O+9SbseA3Ra72dUfRlgyM07hAdHlwiJsTWOsmsQ4kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008911; c=relaxed/simple;
	bh=YIEy50Oo7MdoYcfbIKu0NDEXgJ9FWh+HQGRR5McoaOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=np/iNsd6SHtVOu86OYej/8eAa/vOc6phlJt424Udf7uj09O2V2KbSrKTxW60T4wuR6F6TSnI7P6la3bM5x8A1Aje1uod9OpRcDOqqtEgXhzxmNM1WDgPWtIAQ1poLguiOflZmudpvBuH0JFnQ5TsDeqhnUYxvrFZ0Chn/qrhfsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yoro9lSs; arc=fail smtp.client-ip=40.107.8.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA26z1oY9j08CmKvI4A2VJpgMpy9sVxIxm3BzycqcdWeYtjSPOmz9psaTw+yPHC1TV3k9CJtdGnqv+Xzy9wA3I2qBnOUrcUr7veHoarmDFNPtkcORPNE6CIcq/Kgg7w/f/YAT3hmeCe04QOn81ETkx9BBnMbIybJgzNXxWQtOpCBNke1RtY79aD5pmFwpJf7f4NO/U8OESASTSrCEw3eB7TAqajhQkg0F4ynN2BnsrxHFt96DOsgRASZ4wdIpSasqOP9VbmAwZftCOYryqQAi8uQbz5kJMUJB2xllQPF03RdAUPiXCG22hEcTeIC6hCrytkDxBKXDtpn/sxNf3BUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKQnJhCdyY1RAh/c5O1GjnnLfAcp4SpZgusPVricJwQ=;
 b=GM6opdiNDMzdFHzL5kxaYrcF37CfArckFZPlh4JZI8/YVuWaF2nBxwSdcmFzRgCy1AJaqu2aw+WSunnXLpL2msLkAXeUw4ADUaHCCkYE41FfbZZSAEdvVzdlWz5WtGvqKlQUcD+pu01qJQjG7TBDiiAxWj7FAK5f0/jydl7/EpZ5q9UJuFWY3t7SfeDGvAAI41DmnB3Wns1H2qDPUAQQdOOEvQxFvA63BNkOv4YEFoI62BhcFPhCDkWkPNGJYgiBPSxulztb0eR6DzZJgJJ4IrX9Jc9UdRIi8i5WzO9eaYJVE9T9sDDb0iZMxWr/6ksSGQKjCTD/2MZjoln7XdIKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKQnJhCdyY1RAh/c5O1GjnnLfAcp4SpZgusPVricJwQ=;
 b=Yoro9lSs408qxAtyEh18SpXFkBLNOt4JcjY85NBGYyEwLXkqQnjWBUKPXAIb+lMEmVyTRSiZ5oWWDJ6vP3fpsDIb9vrcv9jZ1M4f5SLTPyUQgnPjSXVwyht8FWc3lHGYziIvw2iMXHMwDIL+93Uu0Nbqo3A8pobEA7Jdz7GIang=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:15:06 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:15:06 +0000
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
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 09/11] arm64: dts: imx93-11x11-evk: enable usb and typec nodes
Date: Thu, 21 Mar 2024 16:14:37 +0800
Message-Id: <20240321081439.541799-9-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321081439.541799-1-xu.yang_2@nxp.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1115ec-740a-4e08-0976-08dc497f0479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WAGaFx1fuJgb8tKnNH0meIqphnjd6L+CZTjkc0fVfoRAKBNe8c+V8fsfgyOMe8pJV5QxpgFhNWnxF3WdgLRsJ3iANmnrINAZYncfOScjl84PXrXiEXmtiB+aVV5uOJmzZgDX81zfcq32e3C3lRGrGEeVFAFZDDN7HuDMajwXkZ9oAeu/6/+wppz6pTwkYwgx1XxPRr8NPHkaP7HUHjN7c/G71pjDZGRYJw38JrHexUInC20TABNdW2XjPVbZeCjk75qAZTF/AJh2v8nPMwSC9lpqLGk0TZe2y7Amqoyu/iGsF3SGD3OgUngtuNRi/zi9K4nDmC/djpVTAbiq2VZDPdzz2o248wPBS9nD4W53nud5idFHkY7IqhkuyPvG4/vKDbYixNpEVv4ZbzgV6XafVXoYJ/gc+AKdyu/bDklscGMF5gfqewwCD3wUkQxk2i1CIM44BJuNMrv36EuPiZ3OhcA847OzhQL9WSOnL8NlQyDgu4lcNGpZ3Nmr2CtriLPspj4M25Zvjyag1bK4KYODHBt5gFj3JlyIrbxf/Vt5DS/8lmwsInR6A++wpEUnMmiKJ+cEPNjFQIJrwRCVhfYrziLld2wpaXnuUobpTW6wBacXXZjVIvTex3X0V4gtg9g6ODL1c7rPjymK28jtvaJ8qr9yHyypf0AOK6+r+uBls46AMmjwRyFeO40rggYZJVkiO5+6P0PddiNcG0XfrRuBfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nbSKh5rOV/lEAB7aY0IZTHFgAblihNneOG1kTMgFTAHE7XT1JY2i3j0XihlV?=
 =?us-ascii?Q?DCAtY+C7NasHwcQdw1bqkYF7ReCpgac5P+LaHzXpQpnW9mfik+dX7JdqY9T5?=
 =?us-ascii?Q?+9VT9ewT6nbhubKJLcsGHcYy9NWlVM4UXGhfJrUB3wYwAwlqMa4OoVm+58mi?=
 =?us-ascii?Q?OCp3qI2BRprjQYXHLVp2b1GA37/zqsmotqAyBqLQ78rrkcOIF1SXwYcxD+cA?=
 =?us-ascii?Q?s7leH/qCEmAaihpCdReIWa4WOu8SWWCFnsYM8bpLe1D+vgQFTP8ZsH/ra92Z?=
 =?us-ascii?Q?oytZ+PtnKZ6K0uPsPnk26oHN6pD3cQaSrpcy44hLbhkbFmTQg6Bybn7TSivR?=
 =?us-ascii?Q?j7hnUKlPaKLAgtk8m/o9nrR593l7EZx7+5yqxmKq3vZhM2F9QoVE0od1Kc+A?=
 =?us-ascii?Q?D3qPZb1S5XZDW9uNPqlSm/HglqynxKx42z3dyS3knc8BG2ljcCkFKZ3/sVCA?=
 =?us-ascii?Q?OHGtbXwdxW2EQUgGlbjxJbd13ppsz6iuOCs39AzAEpb73OCvsDwu0+FHVPEw?=
 =?us-ascii?Q?tgvy0eSxsvZfy4Ch6JFi7d8XotHJ5AxEcBkq2Fkn382bnL/K1nMuIBwe93c0?=
 =?us-ascii?Q?mxv5XHRf2Uo1gCEu+NkG5lWwDJ3SmTvfoB0npvqE/PyJVAy2hDmo5bGe5x/o?=
 =?us-ascii?Q?QEZqpVcB8fuOuhN2BFoGu9IeUBTPs83WaYpU0FWMvVBam1F3JToW4sDMOnZv?=
 =?us-ascii?Q?WZJsiaNs4gcyX8DheVZvPJ61cdH68nrxMRhRgT7fRXK2/tEyEGdHQOd4Rw3l?=
 =?us-ascii?Q?rW+O9ja61NYHOd864sAB3MJycnnFK+e7D+pLQ3seqc5zov8CtAzdhyqYJKeD?=
 =?us-ascii?Q?nQCA2+cP2ADAc4YMMWTYVDGoUMAgKeWcZYlEzKoxpTxrfiRgHETJMgEl4cQX?=
 =?us-ascii?Q?z8ofbPPTZ1IqiNMsnRb8iaw4k5LMMCH0V4TJ1IbYPth/eGBzfeQm83XK1bcN?=
 =?us-ascii?Q?0fzQ7FuYB9yAh3XsC8vi/V52PEHcsmNYj/sUHeKbJza5lqwcoVnfxK9qn6B5?=
 =?us-ascii?Q?i1fnI9qA5iHjr0tUf+CU7IqWrJ0RuvSwYdLad2F43KA6QHU6FQYX9IjVATqS?=
 =?us-ascii?Q?00ygvE8r6ugiDqbJTEl4tLzy67S7X3OWLfH3kqxlfXWIZZD0oTYIuP7+/ZCZ?=
 =?us-ascii?Q?hefTt5adgpHpYOn4/xiDTZT/jcyu1yiroEogwAfGk4eAogf3cJelz2riTvRc?=
 =?us-ascii?Q?AJ1f6KGkBq6dxiftIuYwaqDoVwHOqn+eG49pcSIOlCgm6h3dz7SuKhL4l/vP?=
 =?us-ascii?Q?MOlq2HuwicIWWU6utGZN41VVVA52NRneCcGlEfI6Rl4QL31wwNu5KLb86O9y?=
 =?us-ascii?Q?5E/Qqw6EOqG5YjZh9Xgk1kaqbyq3jurPvlr8oX0QGP95Eqlu67BEdUMPs3bV?=
 =?us-ascii?Q?WE3uklEoFVl9anJjCZ97jjk5Hrg4sqyVgzJbGo0+nLyJJ7CjDszJtPpvWA08?=
 =?us-ascii?Q?hukYrfpppC9u/cqi2eXZ/2RwNgXoS2HpZVVaUEMH35qO5VIfvpNR2MHj3G/T?=
 =?us-ascii?Q?1THsRI0mi8uJR0lcrDLHtpZhhZXGuHobX3TsShaO8vjQ65mxAVR+xBfgGbws?=
 =?us-ascii?Q?yyXMrHTZInaFfKnZOz8FNtMw604qTrjledHbaTlg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1115ec-740a-4e08-0976-08dc497f0479
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:15:06.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LLa292bsHb7KRpSec3dYmXM8/bIAsrOUPEwrOgqlZRhc0tlPKF3BSwjlMtB+7N/TXNzCZXY+qVlln5/qFPu0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

There are 2 Type-C ports and 2 USB controllers on i.MX93. Enable them.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - remove status property in ptn5110 nodes
 - fix dt-schema warnings
Changes in v3:
 - no changes
Changes in v4:
 - no changes
Changes in v5:
 - no changes
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - use compatible "nxp,ptn5110", "tcpci"
Changes in v10:
 - no changes
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 9921ea13ab48..ecc01d872e95 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/usb/pd.h>
 #include "imx93.dtsi"
 
 / {
@@ -104,6 +105,80 @@ &mu2 {
 	status = "okay";
 };
 
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	ptn5110_2: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x51>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+
+		typec2_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					typec2_dr_sw: endpoint {
+						remote-endpoint = <&usb2_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -156,6 +231,42 @@ &lpuart5 {
 	status = "okay";
 };
 
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb2_drd_sw: endpoint {
+			remote-endpoint = <&typec2_dr_sw>;
+		};
+	};
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -222,6 +333,13 @@ MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
 		>;
 	};
 
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-- 
2.34.1


