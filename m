Return-Path: <linux-kernel+bounces-104107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8687C909
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BD6281EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA714AB7;
	Fri, 15 Mar 2024 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ay3JPXtH"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE312E71;
	Fri, 15 Mar 2024 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487494; cv=fail; b=dORqkvvCgKq5f2t8Px76DCHopVvP/Gduwf1QBCoyU1yJVSwKzKxCtvJo8JYl89hP7zDgy6fd66fnd81lXV8DE9ZNEUSnHDyy9ftuWJkeTtS0is/Fx7Lz++8kXcwHfAF9O1oiKufpm8ZS5xklqMv7j/k0cYEtqCO9MsUbabdhIAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487494; c=relaxed/simple;
	bh=ZZ13aOG4VHSq76ylU4ItLD5AW+FudwIlksKwfZmjO4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0K5FpMWrIYFkzeZNJbrNB7IJIbGcF+wZc2KIn7Agk5JCBaG16Rye4tLzF3IbQip6zhFR5j6IINQUlbgN6MFD4qp+VC03HQLkoLAQpnGWiSx78QuCVpXvKLwM7Vx6mrzuHsqbZo0uv/dS+uWMSEj/7hx4biVAMh6LJp3qKqIyHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ay3JPXtH; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlwS+xptDb6s0kA1jQLWqBts/+RfyDuVN+NMX9fOalpD2y30912Pg6m3yyMCfzcRt80FigZ6O+CMHXeMTyeub3F3C6DgCOSQN4ZpM1qEP+yiSjQZDSqak+lvSwPfon/EqxjJYop44u+aijA0W59LTC6WWrI0mg48UBkm6yewOS4vq/H+1FOzG8LByIcBS53D6nbHLccMLieHBNBLcZRHTVfY83/4FSQJb49JV5OCkQfEdu2ecegXNmfcO+j1gtu5xFvww3zHdFPIDGTKSbcsS53iK6m1sG0VPn33MLHfy2u5EMU6OyDMVJulxF4kFYR8e2OvA6WLXDFbosl0r7nOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s269dwNzt7fupNaWDyLDBy2xhA0wi7ImfCd0uGQlHo=;
 b=jJa1CCKTyqrzINTCPQCG73lk7UyzH5An24XJ3CB8skYq5SQHB5ly6NFchASHsfPR7kYTDR/v/mYVKhGMHEUncdcYRKLgWS0IaGfA9HyPUxhReEjrxbrwHPJOjJjlorbSYHpoUuHhso/T05lqjU1PQQO/pOEAD7vIU0UBpJ4epnj+RUW1gl81BxsLIE4Zc4M7KTW9f4tfegHoOAuxggAqpsd6ix/GMDJHccAbrYsnq2kVrkoA5GHvZ79hTpB1LTJBRYPpinrvdhkHSIQajg/Qli6LG5zRHpHGHfd4SsfF4m10NDsycsKcwCbk5u7IkioU3YwdcXjWocoOG5bYI9+9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s269dwNzt7fupNaWDyLDBy2xhA0wi7ImfCd0uGQlHo=;
 b=Ay3JPXtHBmQAaXNcMKcCaVTUVMFqvzsXYGhyd2YrQkgsr67COXG8j2+/3xeJxM4/jM8BtvJvJQv7ik0wgRhC27ubyl3m6M5t19Of1Pq3b8QW/VeuKoX6yyzmnJWxX9HD+7l1S+5/HpQbOJWgZgSflTamAEchn88+vDHxgN3agwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:24:48 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:24:48 +0000
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
Subject: [PATCH v9 02/11] arm64: dts: imx8ulp: add usb nodes
Date: Fri, 15 Mar 2024 15:24:46 +0800
Message-Id: <20240315072455.2481613-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315072455.2481613-1-xu.yang_2@nxp.com>
References: <20240315072455.2481613-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bbd7b7-3691-4c3d-d567-08dc44c0fece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JHdrBhHXYO5Q+BYw8CZePJac/Bn3mD/W/98XHeKJoz+I2IWj+I0juuwVG9MtbGAPTptR2qw+HY5Uvojh9frVRIOciWVQe6agPpKJAdsGBt1sOuYTkRMqjz/h2Az2gB7fqpKhfKILROdBhxpAlxwodTK1LqVKNlmRRD4CSWbxesGncLxgYr0dPWwKpaBMHN1vpaZKsV1ZttQV0MIhgiKLmbGt/+rxvxYqlSbFkeC6rrAMxUtxWTbuemfvYy7Tds6yZVa91iUUVDf95Dd55OvB4yIfMTos5FSoTbChk+FMWObp180vhoz4QGw+2zBRmd+nL07/QDyC9ZhmrAoq8Q5h2lTpfe0WCuXkj2526p0xDoMAkGe3l6YTFVHi7Fx5Uc7DK71wjWwmshSVqNKuv0UVkkwKUVf/VU2blzBjelAbeqBDLFQLdHGxxckw7vP55OAtqnj/85DyO5HEg49vl+clqNy0+4ue/1h/2U0ChORnWKntMOGct8zX7BCIprZJ0yGu5O8e1DzbAzCyEBxeoAeeSzmuo5egyOTQzkoK5r8nvTDcinNpHpsd831D3IMG3Jx6W7SxciVDOOhpwsHs8NG9ojOUcSuCWrCsb/SDqkgJza2N7sn4pcK7kLp6jgd/jvyocsHfgqXZ79YRiQrnp7TjePP3Jq06hz13q98OvFZLY9OZjWaC2CYx38944QMCcKuEN41JUPigFUUailRBMbYpLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bbAxpbugvjNr2cRB26/QUInq6+6lVRJyr3i9dV8ZAboOaUQdDuzrw0EitCtv?=
 =?us-ascii?Q?0aHJlGe2gPpdz8YjhptgvtlC3EEUdkd1hFS5t5skwW+E4PsQ/MKiZUW+8+aK?=
 =?us-ascii?Q?GIKdfAQQlq88g1TDcgI+duYEAx2V+qKpavLXLUxCxJaPffz6AF+foAJeqUX5?=
 =?us-ascii?Q?OIx9lOevEMS3AjX5+8PL6L8x4tsykv41oM+dIjM8Ibd4KAziqkKw3I4hhaKA?=
 =?us-ascii?Q?LJfvjgc/D9/RD9FooFRSW5ARrFifUD9OHaJthZi2NEf8zd9cArd7F9xwf3eF?=
 =?us-ascii?Q?NOZkjrNOsOrHmSlI+80gjLWJlgiqgCH54MsmqIaKpRYeqbdpf5Odsg3U6zTY?=
 =?us-ascii?Q?9+OEk0NYaPP6T9U94yqm5QxiR9fc9l71/nO07IJhyoNrhRK57Ly5PtB56ZZd?=
 =?us-ascii?Q?s92oyi2g57aBHI3UM/RxPjuQPFyZScup5oVQzmGpzuHKqzJzUgGPB7Tuw2Sl?=
 =?us-ascii?Q?W5LiSx/63hpgH9JflrTiKSvR8/rEGHg8XuvuRBk30HzjdXv6e3GaYzKYE7d+?=
 =?us-ascii?Q?z2GmrNgxDV5baxQstcTTaj0aVCnYjCRUB/VeK2Uf4YO7z1ursw1nRxqhj0yF?=
 =?us-ascii?Q?TA3U+LvVuzrIaQ6VN13lYaoDFqbZ+/mEyRhHNRJPqUywCmy08uFo8gU3tPGI?=
 =?us-ascii?Q?I52WucGPXgaDb3dxS323KBN5RPUjJuMtya1B34ArLgDdkjaGnJI3PbDHFwcg?=
 =?us-ascii?Q?Hrkkmb+j2tNnkOUTqfKHmSmd9XUeze+c8aSEWjlHbzdEZuE9EEXiKjG9E4Mr?=
 =?us-ascii?Q?WAxOjWdekLWJ8RXDD7410KYnxFEvK4eEVJS8kTaDWOmRlqk/Oee1nwqVJT+Y?=
 =?us-ascii?Q?e/vXjTkRxi9OJVr8lhz5zizKRBrE52tTPiz6OaiXx7XQfPtXyHsvDWRmxEau?=
 =?us-ascii?Q?0Ii0W08tGPEuS9zYLURdE/fe95wYWGQq2NWMKwx13N0YO2y1k1RiikqgQBek?=
 =?us-ascii?Q?GpfNYSW+MYy7rihXiltpC7JxxFrBbYTkqEeYS8OlmeZ09P/5EAHrFEQ51U/t?=
 =?us-ascii?Q?RiCsb5gv3XLQobmW3AxVM+6ZUzePJqWHPD9+RGNn7FOhSxtCLIZ5k2FS2tIg?=
 =?us-ascii?Q?kI1iAj+fncigIoCIGmDUE6YF88wAeD8Y31SPlkx7zVerfQxGwQWdfvMrsW1j?=
 =?us-ascii?Q?mLcCzyrfaQLPBhRsJFhorXfJ6pjcD8q5oeJfrho43n7nAIJqtotbYeFU12Xl?=
 =?us-ascii?Q?kb7WiqFgdu4/QJeqzIB4g+4RcQuRpQp6vS7lzxL+IZ9ZFtxdM1X4umKHHh9i?=
 =?us-ascii?Q?JzG9UkXFhIhrkkArKzdXcAJBQ/DPl4bMDkldZZCURN9t2AqQcQaMecvdrvig?=
 =?us-ascii?Q?xXDSxYohyqnx1KjpIt4REUmjFhZkq7ATgNPQlKdZ6uo3GG1ekmkSp/rtHdcX?=
 =?us-ascii?Q?Q9/ihsBE3dqhI6Mqunz7vRz33LlbJI2o/j8DjESO+SMI4AmE6gJ62rsyrGD2?=
 =?us-ascii?Q?M/FFKSL++PxgM+ZI0CXNZOPBurAuVaM87k/A16LhezT1bJOX2ZMXQ7/Qmo2e?=
 =?us-ascii?Q?SHo7AlqioWPLCDuIXO85lhm6fOAO+Jmvvbu50Cy5yCyq3Y6R6McCWi/BtiBI?=
 =?us-ascii?Q?B1S0te/E8axKdGL1SRnktJu+ldmQ0USPR2A7X+LJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bbd7b7-3691-4c3d-d567-08dc44c0fece
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:24:48.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IFtP7iBggUEKCRwV0HQeHTk9zaIfuQ+F0JdrGm/01BYJFELExwue4wNnEUiSr6ourmGTgNssiqNPb+y/J3bZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

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


