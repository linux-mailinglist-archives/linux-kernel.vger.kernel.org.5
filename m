Return-Path: <linux-kernel+bounces-126388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEBD8936AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A43F281DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5D21362;
	Mon,  1 Apr 2024 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jgHNoHMV"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2124.outbound.protection.outlook.com [40.107.6.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F4623;
	Mon,  1 Apr 2024 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711933397; cv=fail; b=TTjtfLZgvkvddTeMj4kZnpdGLfkMnH3DmY2djg8Iw1b1tzidh6eVj7ULTUp6LypYkA9d7wdkCm4XNpw3RbgyUyov4QJhqYySyDPs0CK9uPmVyCi4n2Wd2X+vHWpiQaq5IjRJJmEO/a1zJTP2rat04lAYWgJQsW8RNvGTAP0YCTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711933397; c=relaxed/simple;
	bh=JetuwSOueTwY7PmrA5igNTT1XRasDNw0Sxh0G3DvX6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IIgLT7auD0xVgYi356t9i9WkyX9wWzBbOOyawof/QYS4tifd/6/yb9hmx73I6lfY6wJQhaiUBXvXrDjKgPFAYyDQoN+hRNN5YrCaAh/LSYUPgEQBBR8mxbFT7rJZdLYdWcFVUkrWnitSBqKhusRBHxUfTQhSaEt9nGM7e55vm4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jgHNoHMV; arc=fail smtp.client-ip=40.107.6.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOZNX8rmJvRU9pAVRzlXe+Xgi2zK9C8SYCKzKi5Jq04nKW5m4FMkJxMPlo+nctGR08HVwH7DVC8USzdorf9iF05JpRF902T07IifipVwD4PBugkk9yYWRwOKm2Jj63Ae5FQwSyApAgt0KcTUSF4ecUglWzZF60in6dp3P+c34RHVb0uw1bVHonwyNb6IvIk/6U/+tifwOLH/fZtXsqeRlx8zxlc47w0SPEzuXIyq/ZHPmRvoTiZpkInaD0BIP0MdTFuol+ElpCxD+7KAZQtJMJfTHMz8FPMp4EM21+UKnZ0v9vmmg6Nq8FwA+uedJVRQJw+gWliTiFc8mrMWpP4Kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCT9vwBoY2GujEKG069PStJQl5/x1B7fJ5gCvsM8J/Y=;
 b=N8/gc1IO1tOP5MOp75JD9uE52XsIfTNgHHIFM2mXlkR6I/KXYC7faWi0YEn08DxdQL0VPWgC73EX36ed9vYpl/N0GFRher7CCwHbEckzu0gQF1SM+vowW3+BiKJ2kWtUvVZV7jyuaK/RQvH0TSDP7YcjLsEfy7yhyJ0U7okvRP6UgfLc+He7exTU6JGMHnjqVAqdMpqvHGFp6tYyyNW/ra2B+OBFuG2YsrdLiL4QQqynOCMhHl+1khrKtXLfpNqbZ3EaWn9v3pAjyNiYgtjiBpeVr46R1sSdWqzW2Grgyw7iVfiRDdesE+aSTaGVq24hQWVYFYZK/EmXpM26p2HgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCT9vwBoY2GujEKG069PStJQl5/x1B7fJ5gCvsM8J/Y=;
 b=jgHNoHMVkv6q+dQ683SobM9YzlZ6OyOEstseEI1xRQyHLZTZGYJ/VVwZYrQ6IsBLuQNc9SAa0DPmLVKaN/FUhhmmb/s55K6joz4QjqY22t3wOtFCglZJ5ycswXCm/A0PpAhL55HjIwNppnKeEm88TWDa+dcJ5tDcfzJirE+Ntw4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 01:03:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 1 Apr 2024
 01:03:12 +0000
Date: Mon, 1 Apr 2024 10:02:49 +0800
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v4 1/4] arm64: dts: imx8: add cm40 subsystem dtsi
Message-ID: <20240401020249.gkiextdndgq5x3pj@localhost.localdomain>
References: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
 <20240329-m4_lpuart-v4-1-c11d9ca2a317@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329-m4_lpuart-v4-1-c11d9ca2a317@nxp.com>
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7257:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5b2I59tVUC5vUvG05hLA2h7O2cysiBaEZciqVxMcAyPbha5WE6HNUo9OJC7YiL0l8z8s+pCPIJEhTkNcoApLMXXJbD2iXiP74XHLxQP9KKwL46mf/dM6Wd7c1lzLeNe39Edv3dR5FJObFcNFRakEzzu3k6pNnvKkClwHxpN/j+nArdaQ7fXmrpwWjZDEpDIK6Aw/BIeIVT1yjnmWeFi3mOiNty7wI69e+KK6UJbd79ad8BeLYBeTY/nKQkRUF+hCwqmr5xcPomLyW6sQIfBMqvUElSlO4gNq1vyDNqZwGaQ8KSpvic2HiqaS9nVJJpPVqdbZ7/rNaUig4GMKZm2QYRDv5htQYRGQzVtkw0VCYq16NhrPikeI7Z7iZJggbqxWGDsuhbKP5BhEgvHW3z7O1/CsD8xo5Y40jWoua1jGI//Ae99jJDrscyC21ZYaY5WeNdmfcNzRfpKq1BlMX+g5y9PNgoTrP9bSHVTvdRTSAUFKQkhkfnVj1sfHLBIODHvYgsQkVbACdP0VHoEEzj0VXXJyLynaLzE8JTTzxpcno1S8yScnEoODb8CrvTeVFd0ElWN70R1URU3PX3+cAIkIo8MkMewsnD/b5dv9VC8ebr8Oz0t0yXWajAnJJ1ieYqTHBaQyM1OQbVqdfdl7qQyg/HcUhJ8PblIy0xrUtUaZb1Wxr7Ka2+wPm+tro1IXnuz0YH+IpSEHAUZY+XJawnQX/TEuokQhlPtnHq/0JfZA6mk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yKIXaF/69rG6tawCga9JbUNzjAmyDdm9LbSEcxLjmz5xmejhpxq9VjxogdZ0?=
 =?us-ascii?Q?ifvFTzZNqUwyMwuvuKpzvCOJ+YNOEedeIzqKWkLGuXvbl8khGPrr+Jzjr5DV?=
 =?us-ascii?Q?s4eI2bbJapiualYKhtsT7BzmYYlby/8LP9a1+yPlVhOto/lxOvVp6D2haPhB?=
 =?us-ascii?Q?Znh+cmcK6rR1YqQPDjlbrfSo108zi6CpNTHUDKDCEMHgD9yDpA/WnIQa5jCo?=
 =?us-ascii?Q?q0ktw7D5b0Wcu+h0YniDUqtKxyRGA1cfpEkJRYww0HFujzcZJS+S1Xz5707e?=
 =?us-ascii?Q?IYHeS0VQWcZorJ0yT0OygV0ncqsfoQWB9PEbA+L7OU5sjfzSL3RN7kmafQq3?=
 =?us-ascii?Q?VJRzvDtBscvG5fB6xJyatxnRNr3QWlTDXvxy5VrOXwemF1Qzvr1+xt1Wal9f?=
 =?us-ascii?Q?Ck+Zgbme1YNzZyYk93DFX0IlRwpGgOyTmu1C5dwTqy933xW73PJmsa3/YPuQ?=
 =?us-ascii?Q?vncwkaland6bFTtiJGM4WAGrphMn7UDQY4zskYJAytbia2vHP+9UtEnBHhkP?=
 =?us-ascii?Q?1BX6gA39TG86vrE4OUmwQC+h3byUzbT1o2gz+VvadxnuMsHXBvvGUuWoIA8d?=
 =?us-ascii?Q?MMceVwCHCrmfChGPn7XBGDKaI3Y+oAIXIEvT4ZJZAeHucJ993FnRY35cA9gJ?=
 =?us-ascii?Q?54ilBaWC2+AeZDW+v9ns7NDOZ2CWdmSy2EDAI4H6egOOLBylmX+isQvEtj77?=
 =?us-ascii?Q?b9d0QS+7vrWl/GZBZUYNfUk0bsCFOsANVd5oQ1F5huzNUyhE8qWZcx/97Zc9?=
 =?us-ascii?Q?FQ8FQkbRNGZYEzV363piT7zKQtK97ogqGQbyXraYIHT78xk44Ss8hoSWlQjm?=
 =?us-ascii?Q?sxVui6celBNMzt1DPRktQViHd+pSJLk7vLbcnU4Sv4u9b3Lba2XkidPjyNzX?=
 =?us-ascii?Q?W7AUPKgho2j2fzTZZL+ErSKuI+xPttJAV5xIXY+1bFX6rKdcD7cS4murEhUV?=
 =?us-ascii?Q?xP67wurT6EcROINiJqDhMAykL7tH3yMwBw8Jo1DsrnQjCqHcJwUUXPIquQC+?=
 =?us-ascii?Q?MXjZK3zQUH96qoa1LZPtTuLV/5QZVOovnbWYmDz2S9/F4GmNg7/+EUgvfMF/?=
 =?us-ascii?Q?qcRkYgQBqE+4PDC5vdpxbWmwOfti9qPNk5RE7cmgubOtUI6TnquTA/PE0rkd?=
 =?us-ascii?Q?/DCQBlXPwfw+alFzzSIn6ffLJhwqJqSolLjhmxsbf1U96KaWCABeO4ek3kxP?=
 =?us-ascii?Q?rtK5iAOJqYgPnbYhWUZOwqJx2AqMMjrUMuYUNHmKaatQmaKvkqA6mWTEq30J?=
 =?us-ascii?Q?MIWyh0m3/T4A2z+nxULVdZWT4nh7V+tbJckh6HVdkg+SSHv0WRzd3ixtQ3Lb?=
 =?us-ascii?Q?vYQYEM/4bmR4asvpTArhrE5PKIdOfpH7AnXXCewSmX0LquDvPXXaN8R/sa4p?=
 =?us-ascii?Q?ODbsYDf1sGyfq3Wen3PgOD2HcGAFwPjMjJSwsQ0jHzRcdZp8XGbley8uMikr?=
 =?us-ascii?Q?tnLlp/wcKKhHiSJyPY97Ndq0v9Kq+z51xsQnMPsgVWcKe6L0P2OFqJSuI7bk?=
 =?us-ascii?Q?85QMzHSajOa2ky/wfRjGn2wpIixCTc0fBUqRQyz+5srmBKxjs6jZxUv8oADa?=
 =?us-ascii?Q?gAg4udkdq1ptOhmyXH0dpOK0xiSL80Rt3vWSGLzy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397acc7f-d04b-4b56-1773-08dc51e780fa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 01:03:12.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qAd+JIvfPvVMAuh6dJm3rpQIwVwW6G7QTCn/TgAR5YZDo0k1D3thtEFZfR0lNSh1cjMIPbNmseHul7oIwWKAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257

On Fri, Mar 29, 2024 at 12:37:05PM -0400, Frank Li wrote:
>From: Dong Aisheng <aisheng.dong@nxp.com>
>
>Add cm40 subsystem dtsi.
>
>Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>Signed-off-by: Frank Li <Frank.Li@nxp.com>
>---
> arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 67 +++++++++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8dxl.dtsi      |  2 +
> arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |  1 +
> 3 files changed, 70 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
>new file mode 100644
>index 0000000000000..10a05db06ade9
>--- /dev/null
>+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
>@@ -0,0 +1,67 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Copyright 2019 NXP
The time needs to be 2024, otherwise LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>

>+ *	Dong Aisheng <aisheng.dong@nxp.com>
>+ */
>+
>+#include <dt-bindings/firmware/imx/rsrc.h>
>+
>+cm40_ipg_clk: clock-cm40-ipg {
>+	compatible = "fixed-clock";
>+	#clock-cells = <0>;
>+	clock-frequency = <132000000>;
>+	clock-output-names = "cm40_ipg_clk";
>+};
>+
>+cm40_subsys: bus@34000000 {
>+	compatible = "simple-bus";
>+	#address-cells = <1>;
>+	#size-cells = <1>;
>+	ranges = <0x34000000 0x0 0x34000000 0x4000000>;
>+	interrupt-parent = <&cm40_intmux>;
>+
>+	cm40_i2c: i2c@37230000 {
>+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
>+		reg = <0x37230000 0x1000>;
>+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
>+		clocks = <&cm40_i2c_lpcg IMX_LPCG_CLK_0>,
>+			 <&cm40_i2c_lpcg IMX_LPCG_CLK_4>;
>+		clock-names = "per", "ipg";
>+		assigned-clocks = <&clk IMX_SC_R_M4_0_I2C IMX_SC_PM_CLK_PER>;
>+		assigned-clock-rates = <24000000>;
>+		power-domains = <&pd IMX_SC_R_M4_0_I2C>;
>+		status = "disabled";
>+	};
>+
>+	cm40_intmux: intmux@37400000 {
>+		compatible = "fsl,imx-intmux";
>+		reg = <0x37400000 0x1000>;
>+		interrupt-parent = <&gic>;
>+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
>+			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
>+			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>+			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
>+			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
>+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
>+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
>+			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>+		interrupt-controller;
>+		#interrupt-cells = <2>;
>+		clocks = <&cm40_ipg_clk>;
>+		clock-names = "ipg";
>+		power-domains = <&pd IMX_SC_R_M4_0_INTMUX>;
>+		status = "disabled";
>+	};
>+
>+	cm40_i2c_lpcg: clock-controller@37630000 {
>+		compatible = "fsl,imx8qxp-lpcg";
>+		reg = <0x37630000 0x1000>;
>+		#clock-cells = <1>;
>+		clocks = <&clk IMX_SC_R_M4_0_I2C IMX_SC_PM_CLK_PER>,
>+			 <&cm40_ipg_clk>;
>+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
>+		clock-output-names = "cm40_lpcg_i2c_clk",
>+				     "cm40_lpcg_i2c_ipg_clk";
>+		power-domains = <&pd IMX_SC_R_M4_0_I2C>;
>+	};
>+};
>diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
>index a0674c5c55766..9d49c75a26222 100644
>--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
>+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
>@@ -5,6 +5,7 @@
> 
> #include <dt-bindings/clock/imx8-clock.h>
> #include <dt-bindings/dma/fsl-edma.h>
>+#include <dt-bindings/clock/imx8-lpcg.h>
> #include <dt-bindings/firmware/imx/rsrc.h>
> #include <dt-bindings/gpio/gpio.h>
> #include <dt-bindings/interrupt-controller/arm-gic.h>
>@@ -231,6 +232,7 @@ xtal24m: clock-xtal24m {
> 	};
> 
> 	/* sorted in register address */
>+	#include "imx8-ss-cm40.dtsi"
> 	#include "imx8-ss-adma.dtsi"
> 	#include "imx8-ss-conn.dtsi"
> 	#include "imx8-ss-ddr.dtsi"
>diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
>index 10e16d84c0c3b..0313f295de2e9 100644
>--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
>+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
>@@ -317,6 +317,7 @@ map0 {
> 	/* sorted in register address */
> 	#include "imx8-ss-img.dtsi"
> 	#include "imx8-ss-vpu.dtsi"
>+	#include "imx8-ss-cm40.dtsi"
> 	#include "imx8-ss-gpu0.dtsi"
> 	#include "imx8-ss-adma.dtsi"
> 	#include "imx8-ss-conn.dtsi"
>
>-- 
>2.34.1
>

-- 

