Return-Path: <linux-kernel+bounces-99998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F9C87907C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7881C21DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EC578290;
	Tue, 12 Mar 2024 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dNM5EUXn"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801217827C;
	Tue, 12 Mar 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235025; cv=fail; b=NCCfE5/31N+x+cEL/iQlX3VBZObMaLuhqM/ow/5L+F24wm0Dm72Mvq8xYV7P4ONJ9X7OtsySVlr3te1iDzpY+E2neeM47DFiu1aVOl8Nj2BDyMl6qJrnHM1JFFQc5a99GYD0dvqS2PWyUHzuxr0OVGOGKrxT2EmTGwpZJgRViNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235025; c=relaxed/simple;
	bh=1Si9JFBytoNvebS6tAMt8fwgkW+y7pZnCoDtS2Oh2b4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIu7d7K5VrD9eRyXlxft3ZTyulD04MJwZibhaznluDIcWv9LZkLSTGTTIT2XX8N5nhsoamhQLzDlgF9Ev/+WouV6Uh6ZTVXK58gjyZrAPfvBjN/2klusVlOD6qvy3+2VZ+S701p2XQsrIlt1Bo/BAqf5NYmnP96dNiJHzaxDtto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dNM5EUXn; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQHvaQwX7yot5sFDbQjvq5AsizPBwgI4aw/kUJxTyKLGvZta0xVyJ343RF/iXA0eeCsmCEDEMvU//SpQhDA5nXyw+2uUfIKSFv1Bt3S6tc5j6WWITNnHBjf47OsiHibobhWUtLP484Log5X01rNGOipOg78i+2mIHyTmtR6JUxRa1WsQgKrCPitnrubpTPSsavxFy89/GOVvcPXHaXNOlDsCq++MORrRi1PtSsOOXeB33ztbP9Pot9Ue2yN6rBXuHXQW9V+ei4VTFHita9rq6FuD+9i+f95kSTIMcjlGaskXpnFTdQj9svohVCRiWFcI0XwFOlOl1B9RgewvKt+Jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v082gcxvW+qP4A5BsUxk1jySg8Js4VXKgkC/SS2pKa8=;
 b=DhPGK2zMDU5WZQT9YV964AjkVE+vrxx5PRDlmuirn4V45xVHrPDzwHhOcVuG1pSy9NIKQ5a5C7kd/kozO0jElCZrhz0NP8MfbmJuoAa00Hte8mDW4rykaOWMaP2IpMQVYrq5m4vcNdpqs6VZ8Y7TiHWbXQfnVAx4kVYoxwFvXUdC8dkxJJMCDrA7zTgic2pmUaHiSVVCtxUEgtsUFhaLcN9BSYH9sgktDOQUdWk3wUk7uiotZR8LbV82qO0OzD0LRho2CINZl0+T4PetawcQAn5pglTEg0Jekqp71cii1rJlnad7j1EgrTq6+WlsEisZZsefq0qpl6+CVfGUZNOi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v082gcxvW+qP4A5BsUxk1jySg8Js4VXKgkC/SS2pKa8=;
 b=dNM5EUXnIdcRDpgMmnIte0rZuvac7/GfcCkj0i3a3QrOYaZvf9JgH7s+Ci4cO2m0TpS0Mook3+53YQ3YzI9GgGK4s33WZnQ96Dm+dV1G9afb9OzqaSxk5HsX1lCQLBb9XlgbI1boI0VIqCLzCR8UdbJ5EOHnejq341GrZPoXd4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 09:17:00 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:17:00 +0000
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
Subject: [PATCH v8 02/10] arm64: dts: imx8ulp: add usb nodes
Date: Tue, 12 Mar 2024 17:16:55 +0800
Message-Id: <20240312091703.1220649-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312091703.1220649-1-xu.yang_2@nxp.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: c7571ff1-3c55-414f-17a1-08dc42752c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9xw0TV6avj9ZhgRlGCs/eb0Olm4p0JR7ljBCmPoBbtOXIAtoLH+Wug5+8X3sRVXmMo9zOrfSsgbagjZLMG9CJ3FLW4F8hCewsL1xssaK+lAOE3S1a3dEY7dxmvkwOuByYUfzSKcsryYp+9+d4XHBTdLRSHnCBhIIkFXZL8m05zkBY8g9ApSDwxNRsXa7qiCftUat3cwls+D8Q9mqVLl5Q9OpHdGwQgkrFuheXLZGzpaC1McZ0qnEt1FxVHSzDKMSacZoel2ccxcotXdBIT0icYpOleqOvrB7l6GZ4TuwvEy/w+sKIoQqjQ8Y8RZohokg6FwVv35/uJHoa/2R0HL9xg0UAHWEYmDMQzQ4w2n9YG0ZWC+Sqnp3iH5/OOTE0fqF2eVOCSMmnGXEb/ihFQOIM9OfE6uC1nvHl2yizJPoeatkrkGql4QHLr2JfEUozSnE3ut052bDDn3lshjXU83iBcSIr/bBN3Ox4EzigNHkxGJZFt8yg+h7tME3xq7lLKp69Ihg95TgwRwN3yc1YzNtFahCtA0XW58I/7BAMIQZJkU01e9E751l8qVxjApVqi79LDNMxnQBFWxbMsTlNvDBbXR9GKPxmqm+nr1kBizhip+IbwdmaSNrRSwYrqnHWyka1zJlF0sKVgr34mmyU3J+pUzrFDtYlOFn+zQGE8K3Z4E2rCAjg4T/VQd5WHuPB30hT69hS6o6Xaadu1UNmziS3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vGBpBVr6zDyd2UaFdtyQwqlrIbIS5fBhI3e0yJ5B8qmClMXTxSNquirKtnfu?=
 =?us-ascii?Q?uGyILzxNR0V0cPXRr71orGItUVEtwZE7sL7U717OFtsXk42Eyk9SEd89OKgd?=
 =?us-ascii?Q?HbmEJHTjnwVbJwU7sYXT9zGuhkyHkgIv/0QL3kKZcfcWL4UqGBowbkclsdHq?=
 =?us-ascii?Q?PipsTnwmWHFe57hp0zCcfjhV1MSRu0SbKQbmiL1e109oRLhROEyM+PfJI9vU?=
 =?us-ascii?Q?Elj4ajC3J19EQGp3A4/dk2vPx2BUGPWbj2KZkNW9rh5ZEfWUbaQZNGLsj+/G?=
 =?us-ascii?Q?pumK/8kXHrTweFEKGbvGI/Z8kUrDqEQ+WFZwkonxHczFFUwvXqN6NAaUAv1/?=
 =?us-ascii?Q?kq7Cm3oZwFQNoUMAM8bMPI+1l1E69jP1iIg2T0GLKCyNqSWSrql2JagueLbr?=
 =?us-ascii?Q?rBjT3kvA+TitfHap4BDDXKeCVYl+LX/xSy/GHgFqyHJ1qE4zE/5gtk6kxI2R?=
 =?us-ascii?Q?ubfxWH6ZvIPQzINZ20bdQk4IV2nlGabdIH4O39FnX59HZ5uVwCNG0ShY2ac/?=
 =?us-ascii?Q?MqPKDqFfrtU3e0RQirhbQvTcYPwfVvwJLU2OgVTJJ9vRu0D/4aN8c7KGebs6?=
 =?us-ascii?Q?9wg+K4pudpW4XA96MLYbN649QRSdNBJ/sJ+xQyD2hmR9MjcUH4hHlWmDYGjd?=
 =?us-ascii?Q?4ve9iFgJN6ZkGTB7JjJJ04E9GBVT+opFLoRag8WaVsyzXBbIWJwcjnCjlJkp?=
 =?us-ascii?Q?F90bw4A+Qn+7x/wNibJoNMktq/N4QplqdoMiX16fhA5WoAo1Qo2Y81Hpe0B5?=
 =?us-ascii?Q?KvIn6kqpO75yA2ATXpY0+IoQoQKx+QcfcHPRkcyMdfMxmGG832LUNkiQGugY?=
 =?us-ascii?Q?y/tHTdRBmHlS7K9E52K/tb45y63MTOnKk6NWtbTRBF25teBkUo2XZ2kuJE3k?=
 =?us-ascii?Q?p0MUUyQS7XqgfLW1lJoOFTirvixxbM44ontGG4ITD/FpdWonQwhd4nK2kkcS?=
 =?us-ascii?Q?yYWNiggw8OSkD3m2T0mqVsdx8T0U8OE/YYaOpSrVp5X6Q1A/Q8emyZynNN8L?=
 =?us-ascii?Q?Mo3Q+yVoD9N+JdI3pv3Ae70dXphhklzGL2iIn9QCKYF9k8c/9dV981vQGshc?=
 =?us-ascii?Q?nzicDQLPghGNjXIuop4zve5bfvYnsBIrWp9YURai9dEhrYnozoGF6ImVa+59?=
 =?us-ascii?Q?ZJT5tPyM21rqcLcLUjaz16JhFayVbgFsPMJS2iHMiYkFoe3zX5p0O/zjcVHT?=
 =?us-ascii?Q?rxwL4QCYrT2rj3mWxstkCO8bdmCqaQCYFrRM3zZ3CU6QWTAkXn0pt5E6qks0?=
 =?us-ascii?Q?/AMylpJ4L7LSu65JItUD1uyCU4QZIR5GShpKMN+pWCEuxEpCraIeEjO5ry6Y?=
 =?us-ascii?Q?ZGInrj6KFqSPuqtzUE33HuXb+nZWDcRTph4LliwOMNgrr/8d7nYIPKdYRVfQ?=
 =?us-ascii?Q?WJWSWvy/BTFHC8isYcCv8/DrgpclJ54JLzy+r4otXiEx+w5uDOBAAtXxTLJi?=
 =?us-ascii?Q?H/gOH3qvFImGwFAFwt+mqtYKGo0gLM96X4U8Gxi2CaPy/9mrsNqezayD26HO?=
 =?us-ascii?Q?XRq41mX+ylT68rbxcOLPGao6LWJ8eTD+7LfVvxCJ5MRo1tOD9CDJj205PVLq?=
 =?us-ascii?Q?AkAzEZ1aG+tZHmgAEWM5aQLbxBudAHsjfDXQjRWU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7571ff1-3c55-414f-17a1-08dc42752c8f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:17:00.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ego2HDGU11uVCN+z1ZGnRw20NMXr2QCA9l0vrK54VwSLJRzs/WYMBnMndxq5Pa98vSnFAPtKw+Np2i3S3ggTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

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
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c4a0082f30d3..7da9461a5745 100644
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
+						"fsl,imx6q-usbmisc";
+				#index-cells = <1>;
+				reg = <0x29900200 0x200>;
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
+						"fsl,imx6q-usbmisc";
+				#index-cells = <1>;
+				reg = <0x29920200 0x200>;
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


