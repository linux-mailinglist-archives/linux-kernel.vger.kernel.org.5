Return-Path: <linux-kernel+bounces-109764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BAF885567
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0AA1C211E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A26F77F18;
	Thu, 21 Mar 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SlwWUv/a"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3D69D14;
	Thu, 21 Mar 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008880; cv=fail; b=WJqghWIufbJvHhBayjGERPMTjTzNqg12u6wQM1yd3eNgKoHExieh9wWxwCPELce2ndsp2XyeCZJ8tCKb63h9Fd8kAtCsBi+g03F9uqPEsnbr7q8NaYHWCM3Sd6TFMJdvuuA0gpHkUWNMom8rt6Muq3MxPWg7GLCYXT/gvGVWrek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008880; c=relaxed/simple;
	bh=kCXxv4MmwxxojQCRo7DIx1NL0PCAL2ISD18L7Fk9mdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=On1enkfEUF8eVGwGrnoCFL74IRq4GZya7Mh89uaA1p+ymzTWZ2kvr4C7YpKYui8MC1YBKAOiC26RfDtD1j95oUgh4zDwsEI2t1VqxXczwR/u/3YO15aEWJYMDYvBhKoW73QeEk0sjldIiQkey984+zUkBx6B5Kke0B9Tg0ahr2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SlwWUv/a; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8fVORMwCkUH00uJfNbQJ7iHLkl2DZ4Iy4ApzI4oqfilK5vK4CF29DhEZ2OwsWo6xWZ4lnvbXt0YdqLqhTEvwrK2j0VPXyM0xhO69NWNws8s+Yn4GXyBiIF9P9SS44NbZQbG6Uhzq/Fx8TS37m4stGagXCod5JqV7+3t2QOPtuTu/y5uINEulpySUeTtItPu/lxlCza7m+WZuSj6hZ05c4sc8pcheRuJuEwTAFywNa28Bee1iJB14lgJWc3mmEAav4MpoXNMZFTOKbcQ9yAjAjBVPJuo0UHnLCDhfJ9Wg9i8W7Szfxr1W/8Rjx2uK0IBniQ2lCp/uBPdm+6tQ9H6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INvSDznwF/5DPIzfj6/4g0ohrALxDNaVURXKeAXtrC8=;
 b=is1+ok5E75L0Xpf59Bd7f2vXy7rt1nSNPfV08fOZJZoYYU7W5gXxonQmX4PkrBArVOLOYvoGc2/kiJWxj8geZmIwLbCDEhNStglmDOuGiQ/yKlHQmVVdFsit8wRJtmUxyz5v0dIs/CP3ZreOt7X+xsb6CeuuKKhUkPLJ4PXuT5ZYVO1Yz6lpmdLQ0XHv7+kRppyvrJR6FdYB0wE8MFmy4Mno47oECIq7p/gRqvhBi9Z8AglV3HmekzvazcxhLvgZu6j9kY8PUUdHtay4qhp0vkfw8BhBy79LiqkMJWNv0Khvfm7ca/vCCL9jW4SatYdt5NFphbjgOjY429REuD+RGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INvSDznwF/5DPIzfj6/4g0ohrALxDNaVURXKeAXtrC8=;
 b=SlwWUv/abrIsuVqZtvN3EEi6ukjQpqU6E/zo03M20/VNODBsHxPemyc7pDgEKAFVALo7M4fZA0oI7vXJJOvsq75XVTXPFPZZ+9cff+PR1gAlM1gs2iJ6CxBzc/yySM9VrEizMNJg6uMvfz8++tQrUq49hdwwy7kZBIqrn+pzfes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:14:35 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:14:35 +0000
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
Subject: [PATCH v10 03/11] arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes
Date: Thu, 21 Mar 2024 16:14:31 +0800
Message-Id: <20240321081439.541799-3-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d726d0b-b036-43d2-0717-08dc497ef1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YQv3f4mIhBwPFwZYSil+g7McDcnHpnBGbKDAc03Rr5sNlcxbp7cNBfxz3eUb6EuVu7GDRoAezsc6NSWnRJWOVMBW1VOO076yr1cS3YMxHJwXdIR4zGPDctU1YZClneFH660EUEuMa/x5MnEzUGAdrSohJqOc/rJWlBO9XXAO8pNDjFvB0j1x4UrrgB/o1yATq7xrdc2JtC3lrF5/wJjLFl7CZw9CqQACU21Ug9HrbDWJZRfyLDC38NmJe+vpcLKYQvCem3iV/G8Rnj19q4HZjs1wDbBTsinorFMXw5Ng2bUzbJSNKC0POUFCAlEjWCW+yHPNNuzmpJqgJiY0kNrduGXx5PAJ0KNh31uTY36ePUNykQVx3yefcXaqZo41Fcfdya1RszEEzF5NPTS683Ru533MG8WNfLNIMzh/3xAM1VgThyiqLshh6WjhH2/nVZCkBZPdUKmdw3EhVmdi6uNjJD+2TeCFAKB4hJAuqTENFNO5/US3mD7cLHRb/oMY2pM4zsLhei0c26sQExXNbmELwMPu7TFrtXBZXHG10Kc9sDsrsz7+FrJFeJwW1x0NaQ65NFX9eTM8f9U1jCGY7q83UXRMpcRiBY1kl0p/JrSRt15POBN2DiOR8yyeXT/5Iivle1Mbk5Sctu1Uo5nDjY8kcLoufdbOUH7A+z369Xplk+ceRxIz86cuQoINICgkuTAlvB5sD8BXhBSmWtwlqY4hyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rzlJnLBaHjN664fqX/0AEOozu+hTaGVdUsYKTEYrF3E8zLDciHN9fqFiZ5hc?=
 =?us-ascii?Q?nXZvodNYzkM6zdqpHSX9i+4pPkm3QtsRbvYsYZUfyg7wohPQQdmGfPwwSlR2?=
 =?us-ascii?Q?IY91ZA2BIOUcPNqcuKfVSGRl61pRu8r2mjzyu+2THcDmtEVChAxoNHwlzP9p?=
 =?us-ascii?Q?V2aBcDNQcAS2If/sbz7RM2OXtiYYRPNhGvOmwuFxBNW5lQo+k/5/0wFDMNIJ?=
 =?us-ascii?Q?H8rl33t3OgwXT/1S2PzvzWN1OFpdTptBMJ7kVHcG7Pe1muCW+5KvoIoUGQ3j?=
 =?us-ascii?Q?Grib9wC/kl/v+kfiOU4hZOXAWrt24yuhZYHjTMujLK8PIyLR7cNGS4z7SchK?=
 =?us-ascii?Q?sIH//0TpN3nVR4IiEpsqOlPnF38A5ceexejVrhddNt9AdkRjsboTU9ryNXiR?=
 =?us-ascii?Q?Bc7TMcg615sQL2BcSiJ1/Fv+A+SMqLmz7lp+HB65JBITN57w1dcyXa3E8VH9?=
 =?us-ascii?Q?U5j4JBxjm4F1vczNxBau0lgnneCXWSdOkJFd/UbrIG6HJc78y+CLxiOSKQDs?=
 =?us-ascii?Q?JuSC2r/N4OTDKpm4gyVt/VudGG3wtKmV3phfe8OIA1dWpz36lZPDvpY2aJi7?=
 =?us-ascii?Q?Ilu2FY32A1EHR2saxQ9+P5l2LJjE1O7Ep+KcU6C56f08Hx9lvxeKKOG9P7Kb?=
 =?us-ascii?Q?ncx1v/MNNZKtZP0PI1tml/1hwe+FY2zgZpIOFL2Oa+xtBjdlBjuBpgyOv0Az?=
 =?us-ascii?Q?aiLkYvBeNtgmDdrJlUE0LLbSQ0zRmDjvRMRjKXHzHjyT2AfxKOOFOJb8qz8M?=
 =?us-ascii?Q?QpCTrF1FU5W4UP9HzxN/B0WyvboK++rN8fpx5qTVD06JZX7pYfoItvI+QVh4?=
 =?us-ascii?Q?gjfbKIgwZzfLpGZBkGjqiGTw/86bXh3FWewc6PmSA18UakP4rL6epxMiuT2C?=
 =?us-ascii?Q?2bVXqYJBsQ2X/MD9hdvu6nx2cefhBX+DPwOP6u57tyTm4iGDdwDVYTfsT0JM?=
 =?us-ascii?Q?CjuzPh3vZpbzgVbr0FUwSlQ0M6GyGTtScR5zMBvTD3hH+MEgLKVBEe58oEH2?=
 =?us-ascii?Q?3vDS4+FwGuATsXckVcwpgiBUf0jvw9o+w3A9Jd+qLjSMYcflMicRqTUx+5px?=
 =?us-ascii?Q?M3IAPbhf44uxPPA9QX3+6PGQt4kufQVSMzGuBq5BdxaGDr9dICyy/dd4HSUc?=
 =?us-ascii?Q?iELdYoR0/PrQwwxIK8FkEjjC/0j4hzIcyAFpWNRbla15hF+Be95hPy4siYvL?=
 =?us-ascii?Q?g/Fm2U15YRxPX3j2VMCBfXmT8EkX/9vnO0fR6k+XqN8I6ivmUb6TKNTGAbuN?=
 =?us-ascii?Q?d1H2sgHNgbvwYu5TkmVUw12BjtQVReejjkKjJRXItBP/gTakVqn/Whm1SpHT?=
 =?us-ascii?Q?PFRgN+k8RtYBuUgX0w9RtLjvDPab6vxFUL/9h/MJPbbZFhCKfwao5RFohwyU?=
 =?us-ascii?Q?XbSDwls+zlTuaD2LqvljkvxUTjBE2DfsNa9Yf3NiuNbal4cqxs7ZN0x0QQvZ?=
 =?us-ascii?Q?FL/vAXdJlX6yxKq7ufYciUQSMfM2NHkpHxgvKEgdb11o4N14pRjwwJfeVhfj?=
 =?us-ascii?Q?WNMp6ZtEVXxr4oU0ehbt7kafNTwWEKG6IVG67eR/piRp5l7Nt5o0VkH5BxT+?=
 =?us-ascii?Q?zBoxOiZVtBBuBr8cJq+pMl+aCxTmwguJYbQynyzL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d726d0b-b036-43d2-0717-08dc497ef1a5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:14:35.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v02exq2GOXd/tE5uvWG96KijG+XrEI+xYqM0AGBBAsrRjWMD2kRyArdVe8V4Mjhs4d2wyN0JJtLb3tKTNcIZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

Enable 2 USB nodes and add 2 PTN5150 nodes on i.MX8ULP evk board.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix format as suggusted by Fabio
 - add PTN5150 nodes
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
 - no changes
Changes in v10:
 - no changes
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 69dd8e31027c..bf418af31039 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -133,6 +133,64 @@ pcal6408: gpio@21 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	ptn5150_1: typec@1d {
+		compatible = "nxp,ptn5150";
+		reg = <0x1d>;
+		int-gpios = <&gpiof 3 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec1>;
+		status = "disabled";
+	};
+
+	ptn5150_2: typec@3d {
+		compatible = "nxp,ptn5150";
+		reg = <0x3d>;
+		int-gpios = <&gpiof 5 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec2>;
+		status = "disabled";
+	};
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc1 {
+	status = "okay";
+};
+
+&usbotg2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc2 {
+	status = "okay";
 };
 
 &usdhc0 {
@@ -224,6 +282,32 @@ MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
 		>;
 	};
 
+	pinctrl_typec1: typec1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF3__PTF3           0x3
+		>;
+	};
+
+	pinctrl_typec2: typec2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF5__PTF5           0x3
+		>;
+	};
+
+	pinctrl_usb1: usb1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF2__USB0_ID	0x10003
+			MX8ULP_PAD_PTF4__USB0_OC	0x10003
+		>;
+	};
+
+	pinctrl_usb2: usb2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTD23__USB1_ID	0x10003
+			MX8ULP_PAD_PTF6__USB1_OC	0x10003
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
-- 
2.34.1


