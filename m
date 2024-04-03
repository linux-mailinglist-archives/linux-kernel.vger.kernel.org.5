Return-Path: <linux-kernel+bounces-129384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DEE8969EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CE21C25C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CFE7318A;
	Wed,  3 Apr 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iQ4KrYJm"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2119.outbound.protection.outlook.com [40.107.22.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010971746;
	Wed,  3 Apr 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135062; cv=fail; b=XXzwTErcPFkHtBCzYXSHtC0L6NmbM3LIs06ABYRsYE4nNxpFFhDMO7b0ZzalpkfN+zvKPBW5+L56e+xd8yPJejyCMoprhmskCBH0G5Ee9jJPoXV7aqVaUhs2kJoqIIzW8OPLF/VMnmn0gNKYlhN5CIVpNuwP+L08O5JUjePc0s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135062; c=relaxed/simple;
	bh=H42S9YZSA21dR8rTQa5/Nc+1Io/cUlh/OxcqTUHqv0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtZ5g2QNQX57g0bJpX+4aqD93nyyxMJUwvsqiVP0Na3omfweLzpa9FVEg9qr3KEYsslR9fmgoSvKGdZQvOUtrTvNkr4x+8flyz6Ph5rux1yn5iUt41nM2okzFg3P40djfH03NpvGuQSRmSbjRyhuR3He1HxpaTdYoNOTRwH6ibo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iQ4KrYJm; arc=fail smtp.client-ip=40.107.22.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpdSGBKLGXxAKuICEdSVYXboVBM85h4mCmYbo4TugXbOIhXfz8Aw+CEIX+0QRrtC1+l87QT5r0POFmxwrPOc9YtUQeOWpQjMv8hDy05Ed8NePBh0EdEjm/BhGSiyr98QYsFfRXhtHoZ6hDtzx+LzU0e2jyxorfJVa1axmWKrXFATceVQ8obnVhbfSNQ6tjjcjc6JElNkC4bMBlGe3w1a/ibfxEt+IhkUEjq7dWzd788vxwTXUPyesauySSfvTAx/VXjnzJzxdQFSwaBBWEgbmXYnWtriDV0FpxdTajnEZpqrs1hjO2FXeL2Oypqj43coYzF4zGb0SvgxIDUjwJqL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we08JKSnLaYbRun1Tdtqo0WxMSKQ0rrGYY3E43qbAgY=;
 b=OAI8p9ZTogpTdEsqjVj9OWmfCC4JUeJGC0s9GH9HSPWVX705PQZtfqIq1ZJmdXSwR/iSWAdonQxoGTmFtAWh8tBKC+C2GjK89CwQr+AvOtHhN7Bosotj9Tr4PQJu3GT44N9GhOKgsIT8/ExGez5aC0S/iwNxwPFqO2khUZ0SIz8poOMQjOsaVjW4vuP5Q1fCQ65/MURj+Zj+OKZbASeN77IoRzeKecY3sONK3fnUzdY/YijwpOnsiBq606SLzIokXrPkZJR6pZS5BqFMBuqclps1c0da6XXA4fFFa6ljfACaxHy2l2bdE+ViqTfW3rWPRb0HE5OQjSaIzadUpg4UGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we08JKSnLaYbRun1Tdtqo0WxMSKQ0rrGYY3E43qbAgY=;
 b=iQ4KrYJmUtepQzGrN7WAh+tCITqIKga7RCUGxv7rJUgVqR9Irjf68YOh4p77Aw+OgShmOqxDyT7oajLucGbHyXy2nDGtxVn3GtCUDb2B52WYHrcaeUqEASMkO/foTiJfuC6ZxJpYTZVuD/Xts4U8dZ9mZyqXKJJRylo3AtQVGp8=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU0PR04MB9442.eurprd04.prod.outlook.com (2603:10a6:10:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:04:17 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:04:17 +0000
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
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/7] arm64: dts: imx8ulp: add usb nodes
Date: Wed,  3 Apr 2024 17:04:33 +0800
Message-Id: <20240403090438.583326-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403090438.583326-1-xu.yang_2@nxp.com>
References: <20240403090438.583326-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU0PR04MB9442:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LCs6T3tjYCRl+cWhdsRllqvNwfLhFjC+DtpgN1aASq6AAUbwk25+ToYd8nakybPb9iwCQwTNmr98eFDWrEdZbxultpQXR8z0Aeqt6C+0ne17aDIyaS6BNy97H8cyJzFDVec+ZN0/HSORYpYjM8VS1uzfteZbBaAJLHDy2PoH+Y8TALVWBlyBbICR+jpyO/KenvkngGgSIGM0Y/QyzDFFr3rkZT545AuUfLExQ7BMZ13bbei47k3OwcFAUdc1HGScRcmauM4G4VZLNcs+7UXxQs0RGEjN2I1PV1KQhSvNAjkWWIQYISkc7Exslm2MsvwoFDjye2lDFFY22GlWm5YrkVm/iA9qbrVlrGGZslnDaO9jn1rMaGFTZzO0o/b1GAhA+omM5MvMbGuA8MKp3961hvdH1P77xnls+LsY6Ypqep1M8P8rB7acYyrQp4uKiclMV9+j+iVdOwYccEzw5K/ndvYiP7Vukhz/e948zoSmUhR0Wq8818VVmIG36QOq29Jxm69hNuYzuPbhPmoZgDq8rSC0M5FcbwMP+TvMLbJ0PCAW80Hr7C8L6fFiqwYDsH4AWGen7fPRM0+QBCPTAVt8wum4hFOLwXZ87yk22xuqbnrXOT3Q7MmvGpm+q4JAbqTMB5PXP9lxwnDsFQnRkWvAFXdlMaMLz/OYx4t3KiECDkmGayygTTg0C+fhwwUcixhftTLN/je0+4gY2REocGJ9yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9RHqSBju6o28VAn5LwUGs4+impXzVtxQQV0m42gGExQRG3xznF1ZhwUJpPpL?=
 =?us-ascii?Q?e3w833/ildTXf4va4NHLoKf/qxdqc3C+9SbzoCoPoM+SN5g/yFxdbYY/TQUM?=
 =?us-ascii?Q?HFXsX3xeE3+vBDc9zQ/vkqOa2+m5/ElrNjJ5YIyZatZOlcROqilZYbH9nohe?=
 =?us-ascii?Q?mq84FHOyKAxW9gSX9MSVEanl+uil1Jo7GvD4DheeSsCb5I8COSRCANt6vCNK?=
 =?us-ascii?Q?S3z2WOt3ZZEZ3qzFCuPsDkfEkEiPk7NB1FJUi2Rpx3I60fEjSogiXKYPkrkB?=
 =?us-ascii?Q?ihveExp2qCDAF/vQKxPqtZF8IGBHIgnliL+y0nDmRqHZ3Gu1gBIJN+dZBGId?=
 =?us-ascii?Q?xY/dSj6OQbbMpJFiK4UZSLVApAoh8vVt68chZrnzrTKx/wMkGNEnrICS6i1X?=
 =?us-ascii?Q?tkCg+W7k/Y6Ine8puUv6+3Db83/JSPtzQVdvcAE4LeSq55+YnedgBGjSb/AX?=
 =?us-ascii?Q?GheqTXhDh35auHy6NqwI2lyMfckB1250I1NcKQ1xAWa36bknD2T50+VwSN4a?=
 =?us-ascii?Q?qtR7PMw7qBIB2sqzJXM9YCUh8rnNLMMz3ZOxyya7QZsunlwnxHEnBuEEj1l3?=
 =?us-ascii?Q?WdjWoaWWK2ml/DpFLVUKPGAB9hLym0v2ZyTOh4H/47Y8fScXXcm+z7+UMvZN?=
 =?us-ascii?Q?fGYdv/41Ia/qYhSMlF2d5bigsJ/zEGKLemFZk983qCnfn8YeFuwwX64XUpXR?=
 =?us-ascii?Q?5vWSIh0YPOVHI2nMksCkIiGTtqER/zoOamfVZwF+sLDQWfTQroXMjaA7NdrW?=
 =?us-ascii?Q?RRX5kmvlIE/QsFykEOgRp8J6uUWfcdBZSJp4nn8GuWnyDap0N+9Vo2AcSzSX?=
 =?us-ascii?Q?gZvvwUPA1iBSvKGAShm2NW5O+/MwsF0+mzs66e5CSCkjL39YOEPnYjyB4HFX?=
 =?us-ascii?Q?rNGIXufFeFP2wykdhOo5GZWLeaTVoRvCOMjRM38hgptORqe4VCFfOPPWZ3p8?=
 =?us-ascii?Q?QEXiYaFawuCFDVPZzN1Fp8kg56jKN41gBjDbJbkSCSAEDAXqwzfoI3sEhmFL?=
 =?us-ascii?Q?MPnOu3BSbacbVhyFToQY+Ov/pP0b5XFEdr9IKWDYyN3c/NctOAjdr2VN+Cpv?=
 =?us-ascii?Q?cjUQ1XOhhCjd+bGnczhLNme/kInkA+stzQa8yjWqo0LxXOmeW0oEONmOdTsM?=
 =?us-ascii?Q?CfBdtMXRQ3VU5TdJ2SznSF5CV71/asNU17V8m8wWKn7XRI6sV3q+dfYPISF8?=
 =?us-ascii?Q?OpeKLQCNrA8IAX+8K3snSoEbbr+QM8yNmuzcadTCBrPehBypj4kMnYTLSWff?=
 =?us-ascii?Q?lw/CbD4NAhap/eTo3MQ6+Vh4fwwfNGIN/BWbG/2Zo7bwLl/rGb2aDx/Xy+aA?=
 =?us-ascii?Q?Sz45f3/lqdjUmGsSe+ruNvShFDSGq+zjSLHyPTrBMRiTvruSPbBFU4oyEil/?=
 =?us-ascii?Q?DP1y+RtgVkf3Rv2RePckKFcU/AgKF7nfMBtVE2hL2fQJOm+vsP+VLQqDp0x7?=
 =?us-ascii?Q?lHbW7k2y67bS65Xsx1reAlB/zdPMGny/oIpfP09EX2cyGl8KqK7qLQ+/nWbU?=
 =?us-ascii?Q?ycjYewF8jeLoKTpTVZfO5tVmuyYwjQBO61BHgLDPG7OKv0CO13lV4b0ZpxM9?=
 =?us-ascii?Q?bejSlVUsRyZUMV6yCvrahBPKv0Abs1ndsbj7ak84?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc4e37-ac6b-4ffc-804b-08dc53bd0a64
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:04:17.0064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7x/epkxhAqRmzpKjqwuuvktVFUiYAMsvheD5RiFT+SfbJ2FELMEtKjyVwihL70Iiz+GPOHwXAdz+3RKQ4upUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9442

Add USB nodes on i.MX8ULP platform which has 2 USB controllers.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - no changes
Changes in v4:
 - no changes
Changes in v5:
 - no changes
Changes in v6:
 - drop usbphy aliases
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
 - no changes
Changes in v11:
 - adjust reg order
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c4a0082f30d3..cbed01bb8cc0 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -472,6 +472,68 @@ usdhc2: mmc@298f0000 {
 				status = "disabled";
 			};
 
+			usbotg1: usb@29900000 {
+				compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
+				reg = <0x29900000 0x200>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB0>;
+				power-domains = <&scmi_devpd IMX8ULP_PD_USB0>;
+				phys = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc1 0>;
+				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x8>;
+				rx-burst-size-dword = <0x8>;
+				status = "disabled";
+			};
+
+			usbmisc1: usbmisc@29900200 {
+				compatible = "fsl,imx8ulp-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
+				reg = <0x29900200 0x200>;
+				#index-cells = <1>;
+				status = "disabled";
+			};
+
+			usbphy1: usb-phy@29910000 {
+				compatible = "fsl,imx8ulp-usbphy", "fsl,imx7ulp-usbphy";
+				reg = <0x29910000 0x10000>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB0_PHY>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
+			usbotg2: usb@29920000 {
+				compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
+				reg = <0x29920000 0x200>;
+				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB1>;
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
+				phys = <&usbphy2>;
+				fsl,usbmisc = <&usbmisc2 0>;
+				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x8>;
+				rx-burst-size-dword = <0x8>;
+				status = "disabled";
+			};
+
+			usbmisc2: usbmisc@29920200 {
+				compatible = "fsl,imx8ulp-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
+				reg = <0x29920200 0x200>;
+				#index-cells = <1>;
+				status = "disabled";
+			};
+
+			usbphy2: usb-phy@29930000 {
+				compatible = "fsl,imx8ulp-usbphy", "fsl,imx7ulp-usbphy";
+				reg = <0x29930000 0x10000>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB1_PHY>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
 			fec: ethernet@29950000 {
 				compatible = "fsl,imx8ulp-fec", "fsl,imx6ul-fec", "fsl,imx6q-fec";
 				reg = <0x29950000 0x10000>;
-- 
2.34.1


