Return-Path: <linux-kernel+bounces-74280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1E85D202
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D251F274CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25AE3C497;
	Wed, 21 Feb 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cwBQ4VkB"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BC3C46D;
	Wed, 21 Feb 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502579; cv=fail; b=iDwfXCcGO0MZGjKTgOjoOdFSFB15cyvQx+BzfAYEeaM0uvgrMkjpljRPfXnBfIBy0DWE9+57aYg8onErVWE8OPKI18dzeHgEcg7VF59s9CeMDmH3h11JE5b1Nmp98e9vVjv9Xzv9HfBXrLSwLitZEaDoA58A0XohEGEk19NC4yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502579; c=relaxed/simple;
	bh=nq1ihAcP1x1dSdpb/cAV8aLY/EzNGN9j7TrqPenQ2/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UkvMKvIZhFWlKr5hCSlU+dOaItCQtks/cOPPluWlZaPJekAqM90bUQlr9IOPeJjvy4yPRDQx3PD4i7jac/hlqRib05EYYlbWQhSmkUz6qMHk6iGEMSYdM/2Og92Vg/eKE8kQMynZqmlzzX/zsRLj0RBR75Z58DMJTNSr8ZsNkZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cwBQ4VkB; arc=fail smtp.client-ip=40.107.14.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkThKvC+tABSXDafDZM3pTMc+GUzL4B93u/05BETxKxe8pRzik1nIm70+IFvY4J9hZXfPzdMjzjcaDBvmqTeeK3Lu66PK0//PQyAdT243WdSXT7RoNDrmz/TtrOFRwOQWZSgj6bI4rLWeVKuXNut89VwiweduoV5RbM86nG717YLIBHy4LrzfrpaKXxCQk48DNFIEdaApYXhJOykrAKXYXk50FRuojfXeSKKex9j7PpRRMzIR3PMq3Y4/snln6csd2mRDVko1hgO6IWL4L2izhgRku3P7BlPkg42Hkw3SVV6COrTf4P3rDo9wqgc1p8gSnGXMtVIaisNBaoFKErEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4zReIWs7rc4IupR5I6CHPP+Uxix/ZgoGRzkBt7yCRc=;
 b=cdUAEY2/9B7VYNiHJIly+kpe12+9QZ/GMQyBuefj6+Uq5wgseb9obdFgZqEHlM8i3mm8EISQhT/iX9dqP6YIS6OJYTKzJEarWXOFKcrM6eMrTL+dG+1Wmnsad+9CQYETV8yFWqW9uc1kqb1ZP5XufK4z9/bF8JyEicFYg+7VPS3k0mdMV9Cq5Xp33eRPlmHN2iC2wAZWNkirGmBBol7SG/8zwair45TAwlYs+C6M7tLIiQpx8LAlixusdH6ySjXSVc5aWUq+Nua+zOy5Www16ke5sCTIEKi1ImRAoHB1Mxp/9wQEiKyte4nQwAaiwMfaElp7RLViVRVbKxZpXdmVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4zReIWs7rc4IupR5I6CHPP+Uxix/ZgoGRzkBt7yCRc=;
 b=cwBQ4VkBEom8PzkXu4UEqPzHcrQZxG/rehwniXXROn5Ne/n/zdBPW8oSCD5FicfHP+qpe0hidwehHNYbiHNd4PGCShUEdj+6OhfHZoKKxV9YhjVi+IBuRjEI02C0SOjVWNXhJ+BJCWPHFLKC7EcZW+vOon2xC9/S8RkDnvUD9HI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS5PR04MB9770.eurprd04.prod.outlook.com (2603:10a6:20b:654::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 08:02:53 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 08:02:53 +0000
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
Subject: [RESEND v6 3/9] arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes
Date: Wed, 21 Feb 2024 16:02:32 +0800
Message-Id: <20240221080238.1615536-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221080238.1615536-1-xu.yang_2@nxp.com>
References: <20240221080238.1615536-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS5PR04MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: d96eb9b9-d9d1-4259-d435-08dc32b38140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q8aQblnJXrYJ+PNt8U1qF3qT57gTDzQHFSVotKPC6vDPGmcgwInxKXaFJsjqEnw1wHkgNHjVWcw8PGa8k9pT2ba98UBlSVxNA6Kpf7eFj3I/9wAQUJ2GDyNuamOneGii4RL5zLBBW06JBViuZCI+22e3vfJWxLQr9Kxmwgpybp61FRn9WE1RprtMdWES7WXH5o6Sbuu5Y0dED7n8whBq+F4tvAUQri0XCMGWa7mzr+FrpffiGlO+DMPzXD2qmYxdlh5NCxHcwc/bvYgeSbO5//XBrMgtFyearlQCgGTCaiDNzbS8sgE8cX1UGgn+axLwqgtdVZqL9sE6v2oB5ZtZjVDvYGiTugmpsTVaN/TwX7qLbAjjYTBi9rd4fnSE4VHT3d8i39u88u1ZPyzFl8vSKmFpu9p9JY4qrwnA/ZHJS74q++KE7i14387WytQ72oy5HTq1oSGD2E+9Ac+TGcsTPL+M3fwuWJe3wJrxACps0JJQwb3eb2N82lDpLG5edg9dNTIY82kqNabyxqgiqtJY3jQZazEDlgnWmQVCtU6oZXh7Rmc/oj2wUiWt+tSDGO5hGJEg82Kvm1Hd7lK37CAsOdn3ssJatXGv71ja4tzlZ71rkxw66b2NtWbc3FXr/tyC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zz5BjmW/QJ5m3040nnTfKcqlz8GO3b5W1OBaEpj3k8zXF9wkTYtINBiAOVLx?=
 =?us-ascii?Q?TRVUTy3Jz8W8yvCy1rUdPdrAYbFS8s2G6hYqM4LlK1rO+D3tigz1IcLI1+g4?=
 =?us-ascii?Q?FUFvlkuXhO/ZB5goIuUi/+9SBgWWbvxVYpHlRN9zjx7mHl7IW1Kml2F/CIQN?=
 =?us-ascii?Q?6g8LYacmpyS7a2XWGvGWlo8FGNqYFmmCQ+v53Bcs2IXAwe1z71Ur6WsbCp+Y?=
 =?us-ascii?Q?YYiCvyaR/z5r31nOZnAv89mLXlQHa4sKMlLNyzOU0Dtfskkl46hVkgIH/XTg?=
 =?us-ascii?Q?78t2kQMaRDLDA77Vfkhm++uBJBLbtqN+nkeOtFds9CgeSbstRz8DndADZ6Nc?=
 =?us-ascii?Q?5xNRwYzQuvQuKs2Wq5RiQ0jpNkXHvR/q9qtTyEPgnaWcefD1olY4ntBE5tjT?=
 =?us-ascii?Q?zzg2TRIZxHhLoI9Pzt3ABegqvvqNAOxvDUhHIJ1nELpt5oY9OZWZ0t79hoMr?=
 =?us-ascii?Q?A5TVry6AyBB2Tsn3Bsb8NTVf5n0vM+zBfrweXSjVgZPcEfQoFs7SzNyo4PVM?=
 =?us-ascii?Q?sxVLMw617DRZlKzcSNrAcSNNBOJpMijo70h7ucAQnkJnm/xhanZK4wBC0QdR?=
 =?us-ascii?Q?Q7P+DwdyJ916VhG4foVygEhOdCEcNen27asW6gos+zPIVTXzyzV1dWoU7FTG?=
 =?us-ascii?Q?RcO9jAd0osxnqO3GrYrV1kYTh00rAFHoNGr1S/OxqBkYKRmo9JfBjzBaMAA3?=
 =?us-ascii?Q?RmM//HdDnUMcQY1sZQONhZF23wamIwkOtthYupDEN1h8wDPGQvrz99OdmqBV?=
 =?us-ascii?Q?rVfaZGwtKEYe5V+RMr6ONI9OqPqlN3rFE1B2UVPIxxdLdW5CB2c9opv7Gug/?=
 =?us-ascii?Q?fkWrYVFYg7YyIGETfOu+DMN5RxawfDo+RaXIshFvwaVrFziDtfebAbvD2OLx?=
 =?us-ascii?Q?zF/srcO1HifO9adTOK7E4PVddPOxfux5UWSA4jzBM9v2Qq9EC9HureBYfXEr?=
 =?us-ascii?Q?opIJWEbSDWeZZzAASQAwnEk/3nHBw+lWSJDzEcAUKyCpTMSD7W9P7H9MbNMg?=
 =?us-ascii?Q?6Q3MSJU+ycG481GRuTDtaG7OU1IHTnnJoFLhVmK/l3YR+JP/l2gYofI9rPCe?=
 =?us-ascii?Q?0EEi9NL6dCr8yI3+qYprMw3FWujZpWxgUlUUWifEwWbpBSaZbzu8JSXKBixC?=
 =?us-ascii?Q?n6iyRV1SSv2YMLBiMJEbUntKVyqfcUOQ1xVtEj/afIlTCmsILGoX/Ct93vpw?=
 =?us-ascii?Q?uCQCri7wa6T2cNfbErqTH/VtDyvZoWAQsTM5/CRrPFtXquGrGNM1MwWYT5r/?=
 =?us-ascii?Q?QFSaIXmm/7RY93cZPp6rkjQMXOHSOmMGemJULHm0V6Krrxz3C0vO+GrP4/E1?=
 =?us-ascii?Q?n0/PiLmpXuUfxsQjcGOmGxOoRLgp1FOSVWa54nbdE89H/6tl+Mwxv6tnD+Jc?=
 =?us-ascii?Q?cSUW1aCmEzQxDt3/6lcXs+vECNTNph159KZkr+1njzcP/ufj88p0t4pfIsjd?=
 =?us-ascii?Q?+HLjXi8+FC8MbAgAQfd3hEBoFkJ1I/Vd5WWU6VUdXlzfl1bbVEmTBbI5AVQE?=
 =?us-ascii?Q?Zioe2rHFg4qUGe7ht85BgBNrg2rJ2AbxqTPWvNEhkOa7ezV3RWBj/DwJSTlH?=
 =?us-ascii?Q?vHtQs32zM9SkErf5tqP7E++8wuTsM95tcFGIWGms?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96eb9b9-d9d1-4259-d435-08dc32b38140
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:02:53.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGctdFlYULqdGNogxuoav8l7Nw0jFMndTnTB76vdl9bLEMYVyUVXP2aBhxnknTSx0atzN/cl7vTQGhz8yRu7rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9770

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


