Return-Path: <linux-kernel+bounces-108494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5065880B33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37C31C220EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8681CD1E;
	Wed, 20 Mar 2024 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Spilz8Pp"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FD4224C6;
	Wed, 20 Mar 2024 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915830; cv=fail; b=Djk7lzdVrb5ukx01AOOTpMLNplNJ072c3DIPWg/rAsfpghmskYY1c9x3i/g0IrHoVA7LVX9+fvrmcSs1jiEAjUE2VuPCEK9xQGuZgJ+XOfNhGFOXr6co+lP3FYL8U2RGFOX/40dMl2+/s2niZnSHjM6ovOS7gPuxQH1gyGNbhkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915830; c=relaxed/simple;
	bh=3DpucUs91yhxhahH0dJDXkut+D8qMIEDsffCnPKmano=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ixFSeasfhOmQ3hjynl6AWailmVGNvXwzdoQ1zx+iA7msTInCniXvQ5eeoHmB9W3hm028tcF/CFizgrET+nl1FRpAjcfwDOkpdkm1/JLPV6hYrE48KWBXhkVJY29WWzg4fyG/Z0K6fwIrEhSCJpqnYnqllR04mmmMq4gV+ZDisF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Spilz8Pp; arc=fail smtp.client-ip=40.107.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fipSAL8yzQ3EotW+0xx98upwUTKmfZZQ21RulZY4Gk9C99tTTjgcu9o8AcNdxy95R4p1OUEvl5UKMOWz/yivLcVaKSDJvsbQXkwS7EBcG6R/EVK9K+R3qB+ihOldlcyK/RnTVSZ4TZ7Lk4hfMQvrPa0e4fj75RPQXP2YvSDAzGkOJmp0OpGaJe+SYKXmMAx1rp0n+n+Y72YSWToQmfhAoVkwYlQY6Yvqaag7zfCVofkcXy1x0K7EGeBcnrCzl1bTZxCq9psKI0RoHAH4oRQUr53d7xcWuf2g/hHYQlxyGnQ2lmRhxPKO5ls0Rn1BdLoUG1Wn0KpxqZfl0Qkbl+SnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp0a3BKJvLmcXvoFPgEcIgiHvVhMJ0AoyUW84uxLV/8=;
 b=LG0jbhyh6zt7zye72JgQdXukvRHd+azGr7w00Onzdg4jq+v46K/aOK/EyJHHMpMYTLYPhLb2TWxQdu4ersoYOyz1ttM6pvJDsGsEevpEiEvOgg0oDs0qY+N6lUx7pd5PUlrbBO025BwoVHnxe74q769hMg6UGl7p1J9GYqFxgw6lcBzj4cLTrmMKXF3pWoyRq83RY0xlIg7uNtsTG9fvAme8kbt2RVM51A3b2pdB60JIFwefgqhDnjWkh23lbKoC5F+/AfKNhZE0xzfarKVT9tYhBidyDIrYNiIuTFf7ix55TfDe6crQraP0FQIoOiTEXDmJINcY039y843sMsBA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp0a3BKJvLmcXvoFPgEcIgiHvVhMJ0AoyUW84uxLV/8=;
 b=Spilz8PpsKs0NNxLeLOr3zzQjtwP9/SrLuIAsgwNUyNw/gXqKzGe4mT1/UtVe4cYC+dDZPsCrZwUJ0lIw46dD7QY8sojYWgshqwwsMQktrslDAofrSaBdS5EHr0ip/oAgC6oODKfCK60v+bg+j6gg95aQM+Or5AprWalV6eBkHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:23:46 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 06:23:46 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Date: Wed, 20 Mar 2024 14:28:49 +0800
Message-Id: <20240320062849.1321423-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240320062849.1321423-1-joy.zou@nxp.com>
References: <20240320062849.1321423-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9367:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 975aa0a7-cdfd-47cc-5e09-08dc48a64c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t+IuQz1yntA/vFs+q6OMHKJqziwcPc14Ka6/mFxfCJoaadyEgvUpZ9SV8ZWhyLbxAGh8ERGsDRF/9S/dzfT6Fn0b4Df4NkFSF/0zqecEEXupRbpacGdcKcS3RjQeX87S91Slil/XaG0lbsn2j7qrZ0bDsHBcmsU9IVYqJHs9ykNvcb87XpyHJIhap0nwxAVmhc+sxJrjVTSsL8DDVXgBmAr3GSEeIFdOzM9R9AaJlMQEUFBPbEil/VpgNtQj3r293SSzg5sd8zIeQxNRGXLJUZZYP5dk3L0UR42QFhaCMtRrUTOouINhraqsmuNzLlQlGvDiv3GIdvW5w+ONKyo6F4WgNhkWSO8EP7Mdrl8Yts+L8rAILJajJ8wzqxiZJVHCw+Dv4B3ZA+YzgzJrTzxsXlz7EmjAtwJBdzBjuffDSVkzyBkCEW2Uz0BdQPwdDDxQtwbrIUCFwIK5zc0K3tNN2g589B5e//qiqzu9xZDuWZ/LJNl5Z7+ueWnaLTprZBzYADsqvSkBZwyugeg+ETz556kTq2VJJOE/KXGvIZN7bwKxNY0Mg7JsrPDdYRu7D34zNGDdoH/+dBO+s2GFtdjoxsOeuP7RfGGxsSbi8jy7x32K1otsGbL9BXHcMjhbxYQZE5y4+xW2UUzgUcYzwpy7p6sUFnCarG3lTzXti6S82dxqP7G5wzQvjnvBkG6I13aRLUTapCnmcVD7dPL3X4j4ug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nbNBoCaEGjL+62A03gP5jXB1GZ0TycHhnNukhJjFGcDj9e5uySlb47W+FhUu?=
 =?us-ascii?Q?LDj51+Ny3Z8V5aQTMPEQpm+Axa7mIcQiHj21NTZmtoY9v8z8RYTuCAgUyPqS?=
 =?us-ascii?Q?7xeg4Hx5pyK3nGoja55HO7Nh/7thWf6xINpWStzrUudzdiWT9+pUc8L6CQD3?=
 =?us-ascii?Q?hxiR8EqZgfAjU3paeb45jyMswLWKqLeEhIFUHH7o84DgZSW2MXGtinkR9wD8?=
 =?us-ascii?Q?p69jVoF/bINzwY2/7TiPuDSdNdXIU8/ED1OvpoysTOvB/PzQCvztcSzOvwDd?=
 =?us-ascii?Q?JiybxjmBsouu6Jzw8Z4vA61sOzDQs3zFAKcvx/qDoHuqyuO2uirVa16gzKcj?=
 =?us-ascii?Q?im0kATA6hKIR5AtyN08G/vkXoX98b0Y+QkawJHyelWr9ixe+cZM6NvytYzM9?=
 =?us-ascii?Q?IncBZBgE8jcKVtDz+Hjlg/1JcW6QfvNxAicEmHABAW/9mNL64g3dmQs8Qtkf?=
 =?us-ascii?Q?IQ7lILxgMh71d15kSsxDLEfkyQ9VW/8kThKti3PgmGDOHNmqa6lb7valpQM1?=
 =?us-ascii?Q?T+kVHMx+ysEa0KBRyOA2ZcVjDj7sDUI2VZ4/t5MaUVqybtn8tGCrvLkk2SY4?=
 =?us-ascii?Q?d26TYJaneCDyR4HUtcO9S4OmJngFOFVOJc7V3PhoxgHDUH2LMU2hMPJ3WeDk?=
 =?us-ascii?Q?l7f7Shbg9PECIXMNGrk1YVSdXGfWtyETrObBPJPrN/ZQWcshqDGRH4JiUnsc?=
 =?us-ascii?Q?AmhMu29jGVFVL8vI1GXxseYzBqSUCHWTkW7Oi96vB4gOuiWIZqQwUKaZDhkr?=
 =?us-ascii?Q?KIHwrHCsau0AQIpulUIWvRcQmJAwPpl8knfMXiWt1mAIUPMxAeAcLZ8eYHiH?=
 =?us-ascii?Q?tZgzKyCyvnIn+Vfgxmi0mhRkgHCg5WDvzkwr+iiHoVyxK4kVeGhX1d2chAsm?=
 =?us-ascii?Q?/Emq/p0WsgJK9i/VM51ERVcDOPorvEJqBB9RToH6q4wYooR+MkVMTqRmJMFX?=
 =?us-ascii?Q?dScg1XTp0pbcl+IX9RFjaMg6FVJmx2McSDjmhy8ohmVu6Gn85gMFQLFGftQ5?=
 =?us-ascii?Q?COyr5B8696z4QZahMP+fWy7Kdj8wl2MEjba00rZYhNYZVZ4+q1a1iStzKL3w?=
 =?us-ascii?Q?Wq/x2UxIdPSyuEqcRfPBcpD2WxQ2Lab93SBHBU45K2PiWxTLYwtJZcd5LjjK?=
 =?us-ascii?Q?K7cpOXg4MaZld4gKmCAz5ygdbYfEUpeNIfo+fPgP/ojKZPaHZNlxazpg7hku?=
 =?us-ascii?Q?ZJ8W4DKg19JuSvRomsioWIG4rZpCOPFsdQEfjAnWwxUHOLTS9TqMDyMOTaIk?=
 =?us-ascii?Q?lIjuRb2CBrt2SXNvZpG2Or02Rm9RwpNqkr6e0rRcLvnBKT5K5f48udV61llR?=
 =?us-ascii?Q?yP8rQc0OmqbfAEcf4NydzWd5fX+2BcsRafCMR4jcS6lElJPvOn4XguACyxgy?=
 =?us-ascii?Q?aEexGV4Y0OMKgbjgelBeh2hsycM+gA86z178xZ97pkmUp+3au6pFRSXUzARF?=
 =?us-ascii?Q?AYSi/bnDuOZWtHRJxC8gz4yDIcRNDvVPDVg1gwa1HfbPAGbW3xIqx1jkgyrj?=
 =?us-ascii?Q?W5QmkxHaMVb3CnCANC9NySWrrNO4p1t1C6i9pG/biNcEfZ0Bg3e3EPyDAegj?=
 =?us-ascii?Q?f2IJWSZGUz6OIzdEWMCrQMV7Uuj8JUS35yEKqqEN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975aa0a7-cdfd-47cc-5e09-08dc48a64c3b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:23:46.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqWfll55bFiXpa2aTruG1mRJFM93wJJZV2tlkZt4qUUh0ubbG9rP3Y98VQwUNgkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879

Support pca9451a on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
1.Change the reg to the second property.

Changes in v5:
1.adjust gpio@22 to the front of pmic@25.

Changes in v4:
1. modify the comment for uSDHC but not i2c.

Changes in v3:
1. modify the voltages constraints according to the imx93 datasheet.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 9921ea13ab48..07e85a30a25f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -183,6 +183,104 @@ &wdog3 {
 	status = "okay";
 };
 
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <610000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <670000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1060000>;
+				regulator-max-microvolt = <1140000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <1980000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <840000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
@@ -238,6 +336,19 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
 		>;
 	};
 
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
+
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-- 
2.37.1


