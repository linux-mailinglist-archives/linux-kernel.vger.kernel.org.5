Return-Path: <linux-kernel+bounces-131808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD3898BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6865283A49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306D812B148;
	Thu,  4 Apr 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qsLmga+j"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2104.outbound.protection.outlook.com [40.107.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1B517BA8;
	Thu,  4 Apr 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247577; cv=fail; b=tlrl158uOE5vwOJNPOsxV4mglvF5hzULAIstC7wdHHcVtMvWr/3kW9lqHjDiuxga45kEKRkpEczFVqB+iXPk/PWr2vxacRul4uWYb2z5okM834pu/gi8QgZlWuHLvMX2WhEDfD1TXdUOm7QWg88k84fab6FnKaBxsg5VCc9gLNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247577; c=relaxed/simple;
	bh=srYiov+bI4PV8aC3Ad5CrZJXP3DgFkpmt+xoy0yS6yc=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UxeLvkZlvSV6lK0oRq10OGIKPbkoalJOlKsj3ETee3coij7g932H44ofZmoWRUj3fXcxzHkEFJqijSJ244sM9zE5zSkHy4Oiy2QhCNt00TGOCNgFW+jCuVeYW+mhe3a8IIxaS6Mwo7CesDeieGtfthATGBAkgTGrCVhVuKga0q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qsLmga+j; arc=fail smtp.client-ip=40.107.22.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUM1MYi/e1UirZU/qvfJ5jyJzBRv+KlugIbmoKychEr/Tbj/5PWNgNs0CuOvtQoi7b5TkBJmbyJmy0IIZjpdM/+291vdTZXzhlMMZVFTu/yYp7Dx8LtyUQq+Zfo+iYDhLw4ah+WVGce5UcOfyWhrWQXypwTiuHXPZzF/nP/NOomi9IuBXuDtOJdnO9uGqP/NmTl6XJcaU6RnpFnpj0+4B4H/M2ONnkvnp5gPPCQq9He2aEzVGxAKuhl8t2CyQpzfCxc1tqS/6xubACWBTyQ5Q8ESdKvMNmo2S6RRnOdrDgwhzDh3oQIHH8B70bcH+YhCv+iEkuf0WizYWCLu4LoVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAQc60o0VgCHDyvwhk5AxFCYBn0J5WYZlBB9ZBlFbug=;
 b=iNLrDp+Br+p22Z3vkn1V2YeurYxSeqFvTuot5/K/IIz0ef8qGO55umeZuz3rCSr0oFlOJ2utp/+ikHHyUAmULNdwB5W3jE60fnUzIXLsvK7H3pGx+1mY5kanYYb3vqDoQwHLMYpKyMNef7dT3+Fh8llGHpVUrHoHsGMBeLDwFYC0hVM4d19F1Hq3lGAV7ZRtQZ2+2bhphameKAlsYfyTS9qAI50a6ThTU7hWxdSsIf83HFkeo8Y8raOLTtS+3T/eEGPwWo/w19Oqy2utNhSYej9g1CNTNI0bQ4tNGJxN++4zYqz8V1RPQFga6yRcH+9e54MskI2QQWq8lDndfAn2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAQc60o0VgCHDyvwhk5AxFCYBn0J5WYZlBB9ZBlFbug=;
 b=qsLmga+jgNppxppeIzTItblJCxE7jwFqjrFa4Q7rQTCFld8qR1gbKpXGDXkoW23RGt36ZakiUYHBwqBbUoLIwq48XyR+ItSdGy92kNcRq7Cn0eTIxpvS4s5o75f/AETlMFkMDiJjehkMHeF45YZlFOw0AXD7B5yUN+3j/N/Odnw=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8663.eurprd04.prod.outlook.com (2603:10a6:10:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 16:19:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 16:19:31 +0000
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
Subject: [PATCH 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960/wm8962 and sai[0,1,4,5]
Date: Thu,  4 Apr 2024 12:19:13 -0400
Message-Id: <20240404161914.1655305-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8663:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uCBTQRkGNMcs0ERtt0WEboUaBqoUQ9CSMO+//L+6oQub0BRsB1oAVvHc5rPUaDc5oYLZRkp7gI85UwjuDxDc3hu9+sGCX7GRMdOvanrFAnfJof8TC3/jfI5IkRurtLqAH733xACPI/i141yBlzwMzZvxiD297MuF+HW80vnHFXPHACzSWE4wsEMaCWAYOPjuNKk/2jy4+01ERWmrv95RLrTxib2vZb4mLkdr+fYo3vz9VqF9FIcsyQC4mVs41cab8Be/o4Q1iFkstNU5zgckK13OGyzgkY5GUZuz/kdInjCwMlC/mfgEugz/2F0RP1e5B9G9yG4mIwpClo6xjjS3mcPb2ZmCblZaVBmSlkHrUZf5xL8IUj5ogjPnDWNlRY0pHCtg3jyrrHvOUwrJ2Na674py3TbRfxcLhHlc4GDVxPWoLui6HLheSD3DZVWrGbDasKzlcAL3RTWa5FNqZFwnb602bkhjefWm/4TULbr1vGaOua4SNuVs/TDLZX2nj+cPfJNk03dFI8nJeLKcp6i7KD7q3utYxaLxfPODeIAIoxmNpyeVLo43X+51G8kQ/Rxjc+NJJ1gKUeSTYihERchdrxdjaatW19f2YhpLHMbpjcVzY7gO9U+FYWBJtpFH3ifw8tpB6mCteHQlNHNpMGB1DICdrKk1/+Iu8xx4Lqvi6VmQqAxHK6kobgQUjC9G/ZynKjc9QDvgOT1CaFmRVlWY8jT1KJuW9cUBZqzbO5jjn9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J+E5neu+Arl7h57r+sJQHqBgNZ5ytZzjpjlsVJn5vq5HDTI1tK6xHja7J9QR?=
 =?us-ascii?Q?cdElml4K574cZsf4edUx+DkKQ0Os8c6DARMLpPITccd9tkN7O3wqpMS18bYb?=
 =?us-ascii?Q?PHJkPaEjmmsZu9LdcL35BUNkSWd2HJV5mDh7QF9zS0pFp/cS1JCT8hdsyEde?=
 =?us-ascii?Q?8PLyxm491OlvhdZ7YLdbGQwsXXX/MGT16zMrIFeXMTvsom5Wwva/BU6mKKy6?=
 =?us-ascii?Q?M5uVF++Smy34qfwpw2VnN/PGkV3CtYJKiEpI7V9+DlOkqcA769NnCNNwO8Dg?=
 =?us-ascii?Q?NsfgieEmDASajdjEXJjNP5cgV4Ki0RovznySQnyPtwZHSzs2FNmEf56MCZ6h?=
 =?us-ascii?Q?qEi07n18cw55j36ftBYgm5OIGxn7xNGB8pXpZoIpnroc9SYK6PdCA4DMymHG?=
 =?us-ascii?Q?cd9komm5TDWVPpu9EURgKaKV4m1lGGoUT4Ly6xmk8NNuU6C7vDL4brkdeAOY?=
 =?us-ascii?Q?GeXoUWvD+e/W/qKHdK/G9LVfamiWsTSZIhuO65ffQkzfZsvwR29cRxlJdNiH?=
 =?us-ascii?Q?V477V0E7S+06YMafU/EqGi+bdpy5LkPFDDN1c3UYHSSkzN4sUEZYnJM3ar9b?=
 =?us-ascii?Q?C5JiOt0yzjT4pjEOs2GnXeYtj6rmjx/dVkQnLwQDyVPIjdq/uqTuANSrOhqY?=
 =?us-ascii?Q?rbNH6wawrjbnAeIj+YuVnUnl2E40X0Tfm/7n3mkHWjCJkOwLOofZMmOR291j?=
 =?us-ascii?Q?IBwNyV4gHNA2z8sz1E+Sk6fiXLDiak6s0MHljm/2BqLXAnqh9brKz0ttYEBL?=
 =?us-ascii?Q?u8MLBH7y5pQl62EB+aktd/ZFnfnFLlVElzA0fPwk52mpWoEOEVP2K4/gDxSf?=
 =?us-ascii?Q?EI9DLCa84RhX4kIPdl9nioI5WsGujlmfSVWHwyIxJAOSg6a8Vps4+/rwDOc6?=
 =?us-ascii?Q?DdcfFg5Cy6WRS3BCz8NuT2C+6Ne7ZQr/sFmelh74Dn8Oct4KJQ2Nrabk1Npt?=
 =?us-ascii?Q?hhRPzg2HVyncM+4IXE4SA3AsOakDLku6QdpHUsGvyzqipQRJS7akuhHA1CNU?=
 =?us-ascii?Q?4rl7blH5i3Xjr6mYbWGhgElFppc3H96AO5jAjo78EzdE2pWhuxIIqLRIBVo7?=
 =?us-ascii?Q?i2YZ62Dz8en7CKB71IOTxZT+xYH2IZ+ADS4ZPU+qpN8vwRvSkTieagy3SPCN?=
 =?us-ascii?Q?TKzSClVrBKhnXkRMTulz/kz1YfgzHXbzfrqhtE/s0t91Z18niE2l5IOuSH8a?=
 =?us-ascii?Q?46w8qJqrxUzD+hvmMMX2EmF9j0zkWX3uO+XOgcDlQu3ATxzoKjNjTqySq1iz?=
 =?us-ascii?Q?4u+ytqK3JCPCyjdDzkTVmyH81YjUT3yQRc706MiHmEROT/9JMzewTF+QQqiJ?=
 =?us-ascii?Q?GP7cS/FnuqTkD2/VzeKjHATW0LQCkkedDc/xIyBn+GgRXLDFuCKuz/+YToxX?=
 =?us-ascii?Q?QzPO7e8EnqAZUlhMlrCUpxOiAzbPxXyy5vWSejJGVDirrtDWsy5DY5YG2ass?=
 =?us-ascii?Q?39uVUrxvGDzewnEsRZ2WFzv6ScdQw7kiFDAc5VJNsfGRMOB2KdEa6mPlx/sl?=
 =?us-ascii?Q?WCOI+7cp5fTujuamx+EekIOXMrrYw/7gcDtd6jgz65Xe89O03Mtx1pMyVXE7?=
 =?us-ascii?Q?RDKElXkkgFwr5BsRy9nl96gvIuX184Xf25/4qf0G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca91fc9-5564-4cf0-b584-08dc54c3020e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 16:19:31.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqHsnpOEChPa0v32lL5mhvN1ojYJi7IjF6Fq814LTFGbTAKJb6JEVPc9G4qww66FZlI5/CD0BWQcM66hMuHwrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8663

imx8qxp-mek use two kind audio codec, wm8960 and wm8962. Using dummy gpio
i2c bus mux to connect both i2c devices. One will probe failure and other
will probe success when devices driver check whoami. So one dtb can cover
both board configuration.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 210 ++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 8360bb851ac03..adff87c7cf305 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -30,6 +30,13 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		enable-active-high;
 	};
 
+	reg_audio: regulator-wm8962 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_aud";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	gpio-sbu-mux {
 		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
 		pinctrl-names = "default";
@@ -44,6 +51,105 @@ usb3_data_ss: endpoint {
 			};
 		};
 	};
+
+	sound-wm8960 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960>;
+		hp-det-gpio = <&lsio_gpio1 0 GPIO_ACTIVE_HIGH>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+	};
+
+	sound-wm8962 {
+		compatible = "fsl,imx-audio-wm8962";
+		model = "wm8962-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8962>;
+		hp-det-gpio = <&lsio_gpio1 0 GPIO_ACTIVE_HIGH>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Ext Spk", "SPKOUTL",
+			"Ext Spk", "SPKOUTR",
+			"AMIC", "MICBIAS",
+			"IN3R", "AMIC",
+			"IN1R", "AMIC";
+	};
+
+	/*
+	 * This dummy i2c mux. GPIO actually will not impact selection. At actual boards, only 1
+	 * device connectted. I2C client driver will check ID when probe. Only matched ID's driver
+	 * probe successfully.
+	 */
+	i2cvmux: i2cmux {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mux-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_HIGH>; /* use an unused gpio */
+		i2c-parent = <&cm40_i2c>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* WCPU boards SCH-54536 */
+			wm8962: wm8962@1a {
+				compatible = "wlf,wm8962";
+				reg = <0x1a>;
+				clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+				DCVDD-supply = <&reg_audio>;
+				DBVDD-supply = <&reg_audio>;
+				AVDD-supply = <&reg_audio>;
+				CPVDD-supply = <&reg_audio>;
+				MICVDD-supply = <&reg_audio>;
+				PLLVDD-supply = <&reg_audio>;
+				SPKVDD1-supply = <&reg_audio>;
+				SPKVDD2-supply = <&reg_audio>;
+			};
+		};
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			wm8960: wm8960@1a {
+				compatible = "wlf,wm8960";
+				reg = <0x1a>;
+				clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+				clock-names = "mclk";
+				wlf,shared-lrclk;
+				wlf,hp-cfg = <2 2 3>;
+				wlf,gpio-cfg = <1 3>;
+				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+						  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+				assigned-clock-rates = <786432000>,
+						       <49152000>,
+						       <12288000>,
+						       <12288000>;
+			};
+		};
+	};
 };
 
 &dsp {
@@ -188,6 +294,29 @@ typec_con_ss: endpoint {
 
 };
 
+&cm40_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_cm40_i2c>;
+	pinctrl-1 = <&pinctrl_cm40_i2c_gpio>;
+	scl-gpios = <&lsio_gpio1 10 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&lsio_gpio1 9 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	pca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&cm40_intmux {
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -218,6 +347,53 @@ &scu_key {
 	status = "okay";
 };
 
+&sai0 {
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai4 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai4_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai5 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai5_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
 &thermal_zones {
 	pmic-thermal {
 		polling-delay-passive = <250>;
@@ -314,6 +490,21 @@ &vpu_core1 {
 };
 
 &iomuxc {
+
+	pinctrl_cm40_i2c: cm40i2cgrp {
+		fsl,pins = <
+			IMX8QXP_ADC_IN1_M40_I2C0_SDA                            0x0600004c
+			IMX8QXP_ADC_IN0_M40_I2C0_SCL                            0x0600004c
+		>;
+	};
+
+	pinctrl_cm40_i2c_gpio: cm40i2cgpio-grp {
+		fsl,pins = <
+			IMX8QXP_ADC_IN1_LSIO_GPIO1_IO09				0xc600004c
+			IMX8QXP_ADC_IN0_LSIO_GPIO1_IO10				0xc600004c
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
@@ -385,6 +576,25 @@ IMX8QXP_ENET0_REFCLK_125M_25M_LSIO_GPIO5_IO09           0x60
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8QXP_SAI0_TXD_ADMA_SAI0_TXD		0x06000060
+			IMX8QXP_SAI0_RXD_ADMA_SAI0_RXD		0x06000040
+			IMX8QXP_SAI0_TXC_ADMA_SAI0_TXC		0x06000040
+			IMX8QXP_SAI0_TXFS_ADMA_SAI0_TXFS	0x06000040
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8QXP_SAI1_RXD_ADMA_SAI1_RXD     0x06000040
+			IMX8QXP_SAI1_RXC_ADMA_SAI1_TXC     0x06000040
+			IMX8QXP_SAI1_RXFS_ADMA_SAI1_TXFS   0x06000040
+			IMX8QXP_SPI0_CS1_ADMA_SAI1_TXD     0x06000060
+			IMX8QXP_SPI2_CS0_LSIO_GPIO1_IO00   0x06000040
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK			0x06000041
-- 
2.34.1


