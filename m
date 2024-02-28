Return-Path: <linux-kernel+bounces-85731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C3586BA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAE91F29443
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD572918;
	Wed, 28 Feb 2024 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IBQejFQR"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432371EC5;
	Wed, 28 Feb 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156148; cv=fail; b=cQ2zg0jXYy/A2lPHqs+tnmhwm1rE8G0z1LSn9+i7u3F+b7XNbdGeOmARza1Dw5SS3sQEoe+W2QXOD4ve+x/wbKiqF51iPjo0yXbKa46FaFbmazNVbi4lyhmKEDZw7n5eqaDEo/YH6BD3Xco9sC2LekNxQouwNDEvmDagKLTfxRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156148; c=relaxed/simple;
	bh=x8aaGrEk+S+amaZp7YQemfrO78eh7FYlaMuVTBelVUM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dob+Lc9osCPZ0bgMf0S8w1J+/gOcVmHbNzX/ghfIGIDf4cVnQ0PL2pAxb6SxC5QlAdqcihYK/rZNQBPvR4Z3J1c3C1jLur5Ln6Ijhd3FCfg1u8R3j9Xo8CLn5Y0dGR/CugvQ5kr/JlJWxelISvjm4tliaBiZBKX4GrDApJA0Sbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IBQejFQR; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8XbWW0nYVzZlZaA+RJM6mwOUck/P9SwCdpmFlsL90nmBbxwLsrjE0W50WWR8s/DLIg6h4perOBLNtMQTmC+9zm+WK2k2UE1oVAHtbFui/hnLkAsACfIYQJivGevD2F+r/muY9c/GyiOXvE1+0wVtZEBHqoFEFnuXzrcB0Xa/L3QEeTIx40sIjb1eDFqhI91Ekq45ky77KeUa8mqrsP6JGK4sgKw9rRY1uRlNpM3TwnjKFQBr+MQVhvCh6AdCmNNnHMywcTt5uY5UV2dT4FuZyKPvNfjGgyPFjvbXYUJgtlTfIgqfuMI+0IJq/SuokP10Q+DlDxiIYZ2Ioii7H4VUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D27axtXB3CGX895pJdxPyqzWZbodT5qG+7KvPJAMwQ=;
 b=f20JxetRE+H3jNzzxQEcamVxWp8sGqSUp3jT3kRFEd8hbZnao6amZjoLsQ0V8byPW6OyHiJdffFm6sh6YPkkefxRntpdbpQQ3aCIzTYe0va4c6mt0DoOQLc7KjEvfDQzvPUhPGpIH4JtUzcBXQwKrj7L8ZrsDqN6HAAevVRYSMc9+Knm9fM1ct+NqWj+Q7FTZzaUJBkav+YarUURNmAiaYV13i7nWjZY9IyIEELmxh38Uk0HwiY9ZZs82285eXgh2vNsfeYIVilHi1rxWaT6kIAx6yzoU7CrftOohf3iAN+CjAaNc12jx+M712VNHMP+Vkln93nVmNUU1+LK5FTFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D27axtXB3CGX895pJdxPyqzWZbodT5qG+7KvPJAMwQ=;
 b=IBQejFQRk1e4NqclC3HFg+f/SlxJ4ngw8SW7S8G0gRG6+pcxdLccmrrmkrrhPTyoT935SNKFDRfmyILruJd+hfwpcdu1Zp22GIOr4f0kX/fG+8oiBtYMaopjOqgfQ4vAeVzLm3zXrMP+3jqZESxm6m3mTe4otzcIn9bTDIdQ/0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 21:35:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 21:35:44 +0000
Date: Wed, 28 Feb 2024 16:35:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
Message-ID: <Zd+nKePqQI/y+uHz@lizhi-Precision-Tower-5810>
References: <20240228213343.631846-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228213343.631846-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0109.namprd05.prod.outlook.com
 (2603:10b6:a03:334::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c9a5b9-49e9-45bf-5c55-08dc38a53827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H9nuSegdJJHrPwBxc4lwSAWEdc67AMK9ieiGbPCqfoyk+xsMcA1q8yFVYorxLitd17wqqgLoQiernRGCkUJdOrtjhKx9b4RhMpn1AaeWGbUQhMMqKkcKv87THmpRN2nggRKYrVjj4rXEN8Nqt2onpufpbPTkWgwdxzhoZJpy2vkJsVxiP8IQdvv2ZEHpqmpOOWLa601ngZLkf8FujV7RpeumVbuX1BBA+6DJx11U/bj3fd//uI/2a8xvm4UOIwclfpEGeGXdj8diT+WCtvtuV1VfDavN1Bsk4OM/+ECfBS8C6MBGlDlG95Kvb93cdiQoM3iltYAhZQm/HC+GliY0eCoCs0HETsXT48eoZeoh3+L2Mvi+WqQdWezaq+OnxhPxk8G3aO0rFXh3BvAGP2rB68eccgrMhBI0UWxwmhe63wOUzb1yIFYMAbpAlBeIJlRw8gJR+bedfcdINPTfeLPlyVZvEqo+2h7+KNstGOAXD7v4ulyrXeNINKdYRXWcu+fYE0DdBIm9Ova8xvpfMxUhXzepgQVY/LZgdj+LkG7YNTon6CWdY8TouRDpyJnoeRQQzyBYydKwlEK3ZFUfX2GDZjT8qX5YDXId7BI6LBNEh7+uBmeM8+g8Xksb5h81teHpSnUi4RXrQ8/1XD9SiMa9G4iKeJlNehCtOYgq7bWXjZ1EzGMPSikuaKfsidoZtf4rvPJ/5ZDG5oHsxdeHAHakb4xexQAdUUDiLYek39NeIXg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g3SgS26kIfo/JBcUyLtWiK0ruS/s1plpMinzf8vCoQDl1mQ3nEKenJgFCDhr?=
 =?us-ascii?Q?v6msmNQWz8iKP6wYpGyxd3SNiL3aj8n+kxE8ROu+K+OYhkZ+mScdzuykrZI8?=
 =?us-ascii?Q?fpw//xxKMQ3TFtKKvRMO1xuhaWB8IBM1g4b10+EGAjZ08ceg0FDd4OVNg0zK?=
 =?us-ascii?Q?XmzBM+edZo/5aBbrziefoalWJRsMkqhWw5hfc0H2GYi9jJ6uIRVLPT1dmwHc?=
 =?us-ascii?Q?LK+tlCU5awOlFHl0m67SbgrpZMTtoRTD/nU6Wtk3VHaB7gR3woEpXxMdvBzL?=
 =?us-ascii?Q?dpBiWKq7ebHQOmrrcpDmymeBx9baRK4/i9om0esjSj7v/3F5bJv3As6mlG7N?=
 =?us-ascii?Q?60is0W3ClPO4xJ7a5VqyaNijAb5qQ05oKmyzxOR7uw3Z2uOu1tXhntcVKyDz?=
 =?us-ascii?Q?H9v4y4y8nOYrJ03SZ+0CIbmuwkZ1w9nq8KLRJeSj9gD1ojy8GtQ/TVyE7NQe?=
 =?us-ascii?Q?r+vMWDp8Kf4MH18KColBmzNjgBsvFhK1nEOeKFiBTDQw7SVN8FY8Scqpb2KH?=
 =?us-ascii?Q?PauScNrw1p6KnIAqv7OQfBaRgPLPa6dWc/hBAedq8c3EIZqgF1A2Gala0ecO?=
 =?us-ascii?Q?1zOWUFSdzafNFiHG9m3errHv5AsLm+hjkWDdaawMjpYev4p57eB5QqLNfRJY?=
 =?us-ascii?Q?gjOZQ3bPWgvKICHx7RxUW1g7xhCs8VAKXgNbaLG8YQBc1F0YPKYBB8LJc7rF?=
 =?us-ascii?Q?Jd+zuqQTclFl2+zQpFS0n+IdgLnRYkK7nqSao9PmMA8+O2DiahgOgI2goj+5?=
 =?us-ascii?Q?LJnasWixSu0iSNbyzzM0hcWMf5m7HZiH92Jmh0Cdtklok+M1wYR2/DinL0PN?=
 =?us-ascii?Q?V71PWA6ph0EgGIa8HhyveM5r7/u7h2IuJmaXEIhnf5EfirIa7NAhl4SDq02N?=
 =?us-ascii?Q?9YfCBOKqgikFyZMC1SRGsr6rFeC3zBRhCSgLNQd1jAzkd9DiYxSomhAo4PD0?=
 =?us-ascii?Q?Bhrkd/QZ3E1seI1py1JGMVEAgDIbHCz6Vz3z52t1qXeA07+phYArXQuvh3Z/?=
 =?us-ascii?Q?W8KoP3gUO6elakg9eqT8gzxZSIy9g3Db4RpSAReTUt1O/0koD0wp2agvBMHI?=
 =?us-ascii?Q?6zkQs+HvXB3qK//mjOHIGQa6M9NK9kIxcugHRBDrs6nRDPqDyy8G6WPGX6OO?=
 =?us-ascii?Q?XYl86cAhkyrgJ1GWU0L8oEOu2xJZeevz0xh26Wf0v1umlCOv6mWDZ24GTNYe?=
 =?us-ascii?Q?yT50DApTXVA0/olia0b8FXlDBNAJ6jpVp7fuf4itpfoMyxUiybQZKiEK5Ucg?=
 =?us-ascii?Q?7GjmJqReyRBi3p+M4bxj4SpYGvBFkYcrqwN/3GExOAG0pgl+J5+C7JH4cNIh?=
 =?us-ascii?Q?BQbHwgRVR2qeDjz3+wEQQ0JWyU9/UWBu7qg41edWifGmrfKw6zwWyeVD7CcW?=
 =?us-ascii?Q?HplfceNCpL+KZdo7m5PTYavF6YornAx0mdrFlm2aBkyvu0qHiCJ1PGnThMVn?=
 =?us-ascii?Q?A27WJJ8qlTWj0CKvcpMO7jdJGa3NyCy7K2gocFmJXbqjjldVRPkQyFrTIpX+?=
 =?us-ascii?Q?ujvw3mJc+ylT+TZBhweG2bKxbw8DFLybou77r9s2KrfUhQOgZ9JZ7E3XfiAf?=
 =?us-ascii?Q?A+o15a1eS+RtZikbCeWKUWLIKLJnZOKsIi5XLOFy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c9a5b9-49e9-45bf-5c55-08dc38a53827
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:35:44.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2eINHZXNrNJBeTDfbRUmheewUft2GfpMTnpKXgf2FlVfmbKj8YOKfum6cOexZ2sPZk3w1ZJAK4ghjiAk1XsZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153

On Wed, Feb 28, 2024 at 04:33:43PM -0500, Frank Li wrote:
> Add lpuart1 and cm40 uart.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Forget this one. It mess up in my folder

Frank 
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index 2123d431e0613..3c3dc44e2957b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -16,6 +16,8 @@ aliases {
>  		mmc0 = &usdhc1;
>  		mmc1 = &usdhc2;
>  		serial0 = &lpuart0;
> +		serial1 = &lpuart1;
> +		serial6 = &cm40_lpuart;
>  	};
>  
>  	chosen {
> @@ -51,6 +53,24 @@ linux,cma {
>  		};
>  	};
>  
> +	modem_reset: modem-reset {
> +		compatible = "gpio-reset";
> +		reset-gpios = <&pca6416_2 0 GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <2000>;
> +		reset-post-delay-ms = <40>;
> +		#reset-cells = <0>;
> +	};
> +
> +	m2_uart1_sel: fixedregulator-101 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "m2_uart1_sel";
> +		gpio = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
>  	mux3_en: regulator-0 {
>  		compatible = "regulator-fixed";
>  		regulator-min-microvolt = <3300000>;
> @@ -354,6 +374,27 @@ &flexcan3 {
>  	status = "okay";
>  };
>  
> +&lpuart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpuart1>;
> +	resets = <&modem_reset>;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "nxp,88w8987-bt";
> +	};
> +};
> +
> +&cm40_intmux {
> +	status = "disabled";
> +};
> +
> +&cm40_lpuart {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_cm40_lpuart>;
> +	status = "disabled";
> +};
> +
>  &lsio_gpio4 {
>  	status = "okay";
>  };
> @@ -595,6 +636,15 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
>  		>;
>  	};
>  
> +	pinctrl_lpuart1: lpuart1grp {
> +		fsl,pins = <
> +			IMX8DXL_UART1_TX_ADMA_UART1_TX          0x06000020
> +			IMX8DXL_UART1_RX_ADMA_UART1_RX          0x06000020
> +			IMX8DXL_UART1_RTS_B_ADMA_UART1_RTS_B    0x06000020
> +			IMX8DXL_UART1_CTS_B_ADMA_UART1_CTS_B    0x06000020
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041
> -- 
> 2.34.1
> 

