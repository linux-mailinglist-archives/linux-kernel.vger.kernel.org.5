Return-Path: <linux-kernel+bounces-82291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B309A8681F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EAF28E8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0C12F5A5;
	Mon, 26 Feb 2024 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Svu+4FKd"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EC199B8;
	Mon, 26 Feb 2024 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979662; cv=fail; b=E58+cPqAbvR1zxWRkcUpmMvQkYmTWmYN5BsL6hUpNpBhiqZWsC3ZDNsDFqNhGAU20nuKTfd8OLXwK/O4IBgfqrmZ82SJmmWmWVc55l7UlRq6kQwOegjngTwUhQbZJkKbZKndGp6aWUV8ZwuDFUklt4VsSV+yWb/1K6VmmbofrV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979662; c=relaxed/simple;
	bh=/thWKmFM88Qm4V0wdQ1nHPTpJXKfddXvwNYHLQVgh54=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IIY1yDjvp2P/hh8ZbKs9l8OcE9YU78TP3dQFW0AiwAeZBIBKw8fLfVjR+Jx5lhwK+gq2bDETQeqOr8ntqeVJ3sXSJBxp+OQOGR5E2ppKDjG0p0fGQnc0n3tMky9ZYrO+TklYTdc97xp8Ufb4O0BUxrazNRtrII+dSE/pwgCvbhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Svu+4FKd; arc=fail smtp.client-ip=40.107.14.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLrQ0R+0Pq4dIDTXt1OBecoU1EQWNi9zLDwiaUjYDJpSWcYID7YbQZcq/uDTgtv3FyweBdeH0obzQAM2I1LRF9tConycjektAXtFxO/9lDjhwKYP8Il6Mi9T21B6voBsz7k+jkarltSVyX7bcUZrLqx3FQURj2sAe5rP6BH3t9usrfpVbFcRaescK3RNJJxoFUylLQ4+P25yA4lXTKRuNLy8dvdppia+r5XebyXAt2fOvMxBMkLExeYX0JmWM60LB+AChpebMsbzndI4+z4UmcP8llLGEbKEMVMsQljo1w0WC9XrTMFbV0cqnI6VVAfy56UodXYQbpTGmQKErOvW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Und65RQfmD2bKhKh/5iDJGy6ai6LNHUBAkBVgBixEz0=;
 b=QTIEUuF3H0d7h9uGvrMLisCmiLKWam2I2nJhsoFTpmfFjjlBivOMDmI+PkLmuni3a6ScLG5Fpn07KAn7E8Dz8+RUSmt2JzmAvzvFZvRxQlzU1ae2RXeIiGSNcWwHkt58iZutwsbzO6Pwm0AucKp61QFx3IsbX+dSp3iyOL08rEdFNT4/jKkec5uHmNcVcTxjjoQxUDLD9n2o7Y7m7LJMvCzBf4TV5EycJPDAXIx2b3thE7MBYwk0fIYj0RNG+z4Zj7J9hpXHzGaxXqNeSrMQoO+yoSahVaPG1R+nl7lAPA8kHS9AYc1KYfFpzZrBMMgGTJG68yLRLnvpSJengutMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Und65RQfmD2bKhKh/5iDJGy6ai6LNHUBAkBVgBixEz0=;
 b=Svu+4FKdDPK5s+Z2EoBGRmOxNuOyx8EDFzcatoXwgN2VHJKY9L1WSrkoHknHfjVp7FSP1yXXq43CFUb2ybK3x48PT7BWw0YModKKdrWDtwuP1bzsJ4xVVAV7feU/5HbPsvgpzRr20nsZvDOg0iwsxH13fcUlZdUIfV1pZtTFolw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 20:34:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 20:34:17 +0000
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
Subject: [PATCH 1/3] arm64: dts: imx8qm-mek: add adc0 support
Date: Mon, 26 Feb 2024 15:33:55 -0500
Message-Id: <20240226203358.275986-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: d559de64-6df7-45c2-dc9f-08dc370a4da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	88+w6DcoXrMLYN/hb3cSPIhjHWS4uOyB3vymOofYktwdKZmB7idQ53XvW1p63H1dBau+bZQoIuwG1hmS4sYNVTsSo6VC33B2bFXjQIe+vpba1aMuaMAT3WgsWKrd1bMZv/cqsGi1yHph8/JsQaSemLjV8e8ns8tYSZ/hOkaL6V2uNIzHm4Q75kGyKnp5oPZb5ZvaSKDul4rByQr/0EYw0mXppN1k3hzR2rLAOtWzJLu6q2QPucKMydEzu3DHBvpZZDRtC6jgHq42KhGdIhHMlEEB3iwGtepIXVgi8dVWgTVLshLwsrvwng6SswyYRx/lqF9JJ7McHgBfs8qJADyYEvxaIl/ycAYFLDKRG6ShvLK8/iWcqi+qV98xsWb62Bln6UFUCOb+CA1L+xVTIBEIVi9tAYRQDa+8xkHKT6B7KHNi506S+DzH9Br3kC4S8OESQipqeZdG/BOBBeeO6VBP4RX6wxX/gI11Am0GjjUMcC/ulyljLhzdpR/VU0VZeCRcRroeTujYySJ2xABbFpa7bSz21rO5M1rEQQIfW4/JIbs/SYLT7d4zSGAMCJ9awBYgOmLTRZ7xzqGY75lKHJU5W8xzQkR4486907ztCJV0fHvUm1bqC4pxjMxepiL+Jrfn0cx49QkDTzaCMV2GraSrt51K1cjtmtfAtEIi3m6pZIcBwN485nbJp5Tzn2UdYJqXg/yOSGFqgfLLLECOYiQiVod90jBnUMq8ijYObNssDMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YwJJuWX15M4OYpJAm+ZEHumK8RhnIoJUAxURTMGc9o6CREhmnr5zC0vRkgfh?=
 =?us-ascii?Q?H7xbIoi99NXuY7AbZLWBS1PYwhqqqvjnHq6K8v0upQD3ThQQo1Gq+/ZStFP7?=
 =?us-ascii?Q?24E/q0dfcFtieDbFRbLmaL51bPGsXWCoQ33sr6m1vOm3x/IsHijhb3in99Fh?=
 =?us-ascii?Q?drUVWHcR3ZJnptz1nxdS5XVfOJnEbtCFG3AvLIpgM363iMfM0pHpKK69LkM8?=
 =?us-ascii?Q?Z7wEkjK+GLfZeprMMgfRT/zuWZJOtcH3ekloRi5YeQAD8ApjRixQFLEzgVdj?=
 =?us-ascii?Q?5euwKlNr2r7+2jBqQwEh3/8H0WUMJXwdTK3guGxElA4GDRAPBsVmpWr9GrYZ?=
 =?us-ascii?Q?f8kS1UMKHR3qBjhm3E0VKpSigxa/SOQFGEstsFtTfi1DxN2bNxcmsQhcEEVK?=
 =?us-ascii?Q?sSeaAeUYAiClyGRK+5xmJ+imCkOy2KarHzy50cvMbkPWTzIe+8COiRb15K+R?=
 =?us-ascii?Q?CF9mFD+x/uNxxOX4h2HxpnE+k+yVOthc7tpfloPC96v7dU/bJ1egYsevKM6z?=
 =?us-ascii?Q?B1d+hysCm7ELgyLKf9JbvmiHsdJ1zt8zOa0VSPrl5+esdEogx/I+R6f4WfDX?=
 =?us-ascii?Q?5Lz2DeRXrWo+uFi29/kXlJkQMR5DC99/TjlIMbM1d8oV5uDvPUraLlKJ+E54?=
 =?us-ascii?Q?jr1rk98U2wnTVkBTQ88xSrXeFZNQ+68/r0eQDl9Lj2IMndeQZnVRtthuyIxv?=
 =?us-ascii?Q?kxklrkvfx3dSW/dP//6iU/aTUqcdYLijuLv8T9pJdsx1R+1mI3qORkBCNJx6?=
 =?us-ascii?Q?oJcehQpEfN1qFBy24qFefyvD+5WUP/vLboUZPNNeSSa6hKvIcgmWzhAYFwwS?=
 =?us-ascii?Q?3bpfiS94Ad/8q73RgR2yeXMCGyD2D7P4373xP8CTy1oLLxvGCMYJmSjQff6q?=
 =?us-ascii?Q?g/4tQ4HJSnUr92NSGqIuTI4JGswgfxLmWUJ+eVF/dNtr5gxrDvfCUpbAPRE8?=
 =?us-ascii?Q?9HZYVh093Y34q/ppSylqFS3Vthb9DMHQRlY2X8JCTooDg6h9keU0w0QSaMvT?=
 =?us-ascii?Q?1fGZYn1tquyjEfNnNOfIpdvxgNBiVRm4D8QcaIWvnrrDD3plx+Bj9TdH4ne8?=
 =?us-ascii?Q?aLSJoiDxVAv8LCp6YOtQhf2Qeyw0/qyjUS6R/EdxrnoGOlyqSJYdR06La/pQ?=
 =?us-ascii?Q?tNHX7V2CO9Tql6B2z/Rd4y6r/nJA9JvhKwYoJrtTHWfys8bVbUox3GcHPA1e?=
 =?us-ascii?Q?L40+Goc1teBs6iOrq0hqxueQBRUDkIrbj1yPYxc6YuNu/81z1nPk5tIO9s3D?=
 =?us-ascii?Q?lzN210pYPwSEX7RMTOdGikxr3/h6+pnu3N5tVrvfWuR7vGSKZi2EOPdUYlGM?=
 =?us-ascii?Q?7UswFjp0iB3f64+e4B+vY/VzazhhPBOANGy2r52G/pSHSGN9KL9LMyQr+d20?=
 =?us-ascii?Q?glbzh3hSC3zKr0SG7e/FQuyO2YUjd8VkfFbfX1zt/qT4KMhBY2YrbDEEgXIR?=
 =?us-ascii?Q?Mm44W03y3dPBMfJ9hYf8PmQYZf9PSt1UCVrMSmnoEGO/AL3yHyOaBgU5XTGg?=
 =?us-ascii?Q?wcOiICunNkiV4d1Wb0pyjAvc94370GZMwq5kfE24MsSv7IkgyoNP3SyAO8KD?=
 =?us-ascii?Q?crS/GbpIdE1BGULI4UdIBACotup5WF1b6rJCOX4Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d559de64-6df7-45c2-dc9f-08dc370a4da7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 20:34:17.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NUs18tRBEE7Wj1RhSOJmh4sjUikoHh324BexNwPnZbH4NsCWpPDkDpfJ3CzsTZKfFVqKL70drgPiLwWU1N5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

Add adc0 for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 77ac0efdfaada..0c4972724b041 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -39,6 +39,20 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0>;
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
 };
 
 &i2c1 {
@@ -130,6 +144,12 @@ IMX8QM_GPT0_CAPTURE_LSIO_GPIO0_IO15	0xc600004c
 		>;
 	};
 
+	pinctrl_adc0: adc0grp {
+		fsl,pins = <
+			IMX8QM_ADC_IN0_DMA_ADC0_IN0				0xc0000060
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020
-- 
2.34.1


