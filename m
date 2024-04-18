Return-Path: <linux-kernel+bounces-150797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728B8AA4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC861C218C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4036D1C7;
	Thu, 18 Apr 2024 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oGj7HkUw"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2059.outbound.protection.outlook.com [40.107.241.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B4194C81;
	Thu, 18 Apr 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475086; cv=fail; b=KNPfgJ3dGoUt8jHZQHZxuCGq0wnYQDEWI3+R/Fu6ISsTOP/OZerM3l6nCW9LRt5CUZs4yw0dJX+UHsNQbB+1V+RiUw7R8MNEn68G/wfnMi7CmQGPmEgJXMLmHQ2v3wvtm5gv8y8tWYv6VChYlWnxhzO2LnQzbGIEMrdkhP/yia0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475086; c=relaxed/simple;
	bh=lFvccgu6zm/9v7qxysGf2wj/+PabfVJtMwlJftxexmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SFPLlGfDHE+77A8f8Xz8emXBufjZeIdpHZV570RkMqjaIEjkCFENgjU1jJ3oOOIHoLsilv96ObWRjl53RVJbST4yEBksne81A7V/HOk4ohfGl5uFkabetWM4UDL011nTFUWT3XvLUaRYQ+9pkKjf4RiyvDJVGE66oqhqwE1KLS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oGj7HkUw; arc=fail smtp.client-ip=40.107.241.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPXNNge82uWAkvlt8Qup2gLyUG2DQk1nFOcmcisu1pC3rPmVCyqMEsCNai7lyR/74YGBc3y5IOHOJQ8a1X805SJp4oHnJbwLRTzrhFAGab6dRbmrLW4PTCnxyqWgBm5fWeeS8kym4OFJckwyNvMZgazfn5NT+dX6Lxy4yvNXIlWWLTpBfxyZvGVodl8NgYINYdixWXfMYhPTNSrsM7TvPfYfJI5j1W+7AovLr/dfJLUfbO4eexamMYkBC3AmFr3mUJof8+NDmQ12tuuPHIZ6aCqpQmIgmwY3BtLG8dvqKxVdWFnfhPDqGJIA63pHlqrZ3kllqi7zYlePGOE7CTXW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPM6cL55sOgfJdhNjkCyKyWhsgo3Tgte28K87OKlOd0=;
 b=aORRAvSafIqABTQccfRL24cjB68Oa0/JAZHbI5VKSm5BgiwYJ7arFm3iFB7NpNG1+XPTXEYqZBm9iev/9cFb3rbV9rdY6gUczJUMqWvyXZjf547iOd6pPygmcACUZA1pubVTwpxf6vjXtYl3ZsUSlj5zCUUytGc+yob1c0z0W83dIAVnqH+17fJMtnkYv3kkryWJwcVmFI8w7twyMxi4l95UfQCa9KrdBe2L2scY7Pvt2hiAm1Vu0Fjx58b9yut+Atx/vMIbWVUQK2jU4UA5kobqsJ/Nhyom1WC6tv53S3IrxttswKHtdLRWoWNwPW2HIWyHIzhqgdUywKO9ba5pQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPM6cL55sOgfJdhNjkCyKyWhsgo3Tgte28K87OKlOd0=;
 b=oGj7HkUw7phAOxCNVWGMOjFOfZlZqLEldlTOcwkO5eCvzIs5Im9lmJdqHpajVIPxsFdxBm4GDYD5Jchd6sFhHh3cITcPpIemcY+Sw4aRvgYHx9nUsCLZDv07dsHGSPLOk9IckKMl+43CrU3RKa7Ug5G+21FboANTvAGVa7SY29M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.40; Thu, 18 Apr
 2024 21:18:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 21:18:01 +0000
Date: Thu, 18 Apr 2024 17:17:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: imx8ulp: add DSP node
Message-ID: <ZiGOAMjCyetzI+4J@lizhi-Precision-Tower-5810>
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
 <20240418203720.8492-4-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418203720.8492-4-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: d34f7728-f4fa-4efc-b870-08dc5fed0757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qo9EX+mm3M0yldd/CSC7aTgzvQjbzD4bQrKBhnA5vhv3zEZoGh5GWcZAqStqdwRYt7P4tKfpNFVkDeRmFUEocnnxbMIIKcHu5+cOk9fO6W1NBX+jZRf+r8kRJgR+HIC8KMgXTAuGPZtarmFs5L8vio1ayAQKJWS6La3piqxxtLSaFcVULQRvZvwxwtgiUk/oWxx7cgT2aEBISyuQ7uyPjWFeB6wMq6w063RN0x+EN/Skm8aesJvG27WSKFhgVC7/gbD4RPbjdL0NhSFoEdzp4U9D+nWKD/jcjjmUJM5NV/FyB3tFm1Iwb8CflmbgfItNByJFxa8uvKzXAN1CNdyTaPDz5lOupEE6zZtkwMxOXfbsVglBusrE8Uq41HbCOWoTBXARo+7Pe+YcrOuZ8SJFJj58bptVgcKPsQhhyw+TGlrTayUvScHDYVVY222VY1+gX/5ZuNjPD80GBLyEri413Clm4iH1HaKE/MXEPtAR6WmIj/lyBgsblJuhuRf1WClvE8vQAkBzFpV9w6nnboQHtBWBFuV6tzk6nzQyhGkChvFLe/CyrjxUjU3yMyzxqY+iuGXCOiL+qhkL62FhXoti5lw1nTxbDNUlZM5Aq8bRGIPeORMXMmL8FBItXHixKctdynwO4+71WrP6fKu8IBVCK3/DJP67CJsqpkObs5E3AQ0Nw9UqH4BL/aFbwpP/JkWH9LqfIgeffsSzlCeunkq5qPN0gCB8BcMWnRPIpDSdBnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WmaU9bRyxUgr0PU/jFaNpQbVe/TuNh7wENJybTwvK2sodFubTwV8ag90yVp0?=
 =?us-ascii?Q?5tDU3nDUA6DTPoThZnqyBArefmiO0EuCHgUaQebpAC/1++QB7YgeuDuSAn9M?=
 =?us-ascii?Q?VmP96A7bEqGshMvcNAwdMfy1/YedF+ml+EBql+MxXRFCd4eIvTk0jlXkeeBp?=
 =?us-ascii?Q?kmPFHaTLhwgrtn7072tOqT2uXnCdvD7c4JxZFcXO5XDKPkMIPbnxjXNhOdHh?=
 =?us-ascii?Q?8QGhfm3xYkxbHrs9PtfUIQqq52ecpYn0iCh8uAO0xIo9KuqToPeg8APuiXgu?=
 =?us-ascii?Q?BlI+md2xfs2pJ/b7lJH1Y+kXP2BJgCBOvs83X/67PcvLnxRJ6a4gn8b//8ev?=
 =?us-ascii?Q?IAISp46hWIQgQtABRRlaGMIRiBquGKcQU57QWHKAWCus0BhF7HZXzjlwTdKz?=
 =?us-ascii?Q?QMhdMyjtJMwSDV0X/ROs+6FcQ6ysu/QNxjnJrm6GYyH8tcT+sV2EbeIn9nGf?=
 =?us-ascii?Q?2mOYlCoiLBoq3NI4OjBCpFy2R6fFPJQkktQT1dq45kLCOseeak96RTpCAZqp?=
 =?us-ascii?Q?pVzQO4cY7cyf9AVo3CZc3hK0GmHUcoW9m1HV+P+1mLGWXC2lU0WrE8YMGuEN?=
 =?us-ascii?Q?77Fq81hT0H+ILWW/ULdAEgtYjmOy968sxum484iWAyG5+kKX5EhNMDje7+77?=
 =?us-ascii?Q?qYP1OZ61XaNyaLJj1vHT00rVBqmzOwR6YdE+SVbL9LVyqCn5unJ16iuUo/nR?=
 =?us-ascii?Q?Za5IIdz1ditQsIJSCBM0pLn2qdisHbjgh2j6RtI8Ro+1gPFrPt7Sp+A/BxZO?=
 =?us-ascii?Q?Mo7+FLperbjC1VE5Ck6PkxbJevr2fB2OmN2urLfSMLlzSi/y45jHXYroO1XS?=
 =?us-ascii?Q?0L3FJajVRXUtd82r/lm98Au1WI8BwR8eadhRF79/Qikb0Z1tx5l5jAqWAe5L?=
 =?us-ascii?Q?XzXqFyr6kuX5cnSNxq2uLGvho315VskhgQI6DC8yFkRwaHcIoQ9B7CaQpiEP?=
 =?us-ascii?Q?GN/M75QcQTEXrR0a/jhhiwkXDefRcN4FvOauJKv1oNeRJW8ae5ttd2RUcUjh?=
 =?us-ascii?Q?OEDK303NqW8Se1+uEaphlTgK9y49L6CgzDzvpZcGAxAHIZafA5YnvA2j4CMk?=
 =?us-ascii?Q?19xjTR2I6QyjwpwukLNIz+ZxIFr+HHZ44wA5WXJp8r+BUwuXJSQcw+4hsjAK?=
 =?us-ascii?Q?wIxCLXijoaFePO9me+I0Ui2e9LO4h9tR1wWBm49EC8AcB3gEHUJOzwA0sWsV?=
 =?us-ascii?Q?ib/3uzMuL7mc3zj0cfsVBUUYzUlN/qyn4c9yCoV9Pkp5O8zndHWRfm+1BlTA?=
 =?us-ascii?Q?hTnJfqxl23zdSehPs/2TZvYnN6nD5XWc1QwIpPNWkW31KTDnVXh9ZtPEvokS?=
 =?us-ascii?Q?2B2/Lgx/P0j5XZT29KnjbKoVefOn7O8lfcRD+mthFLbTysgVzH72GEcFlq/8?=
 =?us-ascii?Q?GVxKVxGYB5SVWumVM+MIVeasXREepkU02vZfGw1uHCUCPAyJPQbRGXkf7XrL?=
 =?us-ascii?Q?W7u9o8KZqGZ4E41F6suhBpGk/k2oXfkhLjbYO7RsyMCM84ENE9JQGKKBv03/?=
 =?us-ascii?Q?zfYN0gCdbudJxzSYaFGIHCu16wnKeVsQU7XR5dVisgEW9wTE6RQBFZ9o8gqO?=
 =?us-ascii?Q?G8z6tMip62mtQznx2tmecNMSypBdHkQU3QTdLCRA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34f7728-f4fa-4efc-b870-08dc5fed0757
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 21:18:01.8834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WMmWhFZTW3LP5PeOpo3lxRHHtWkNe1nmmpBO4OHIV99bQy6s222AAEr+gPY/5EII3fj/JdfcBVDKcQBJiHoRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8954

On Thu, Apr 18, 2024 at 11:37:20PM +0300, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add node for i.MX8ULP's DSP core and its dependencies.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 39 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 22 +++++++++++

8ulp.dtsi and imx8ulp-evk.dts need two patches. one for imx8ulp.dtsi, the
other for imx8ulp-evk.dts.

Frank

>  2 files changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> index 24bb253b938d..5dadcbba370d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> @@ -67,6 +67,32 @@ vdevbuffer: vdevbuffer@a8400000 {
>  			reg = <0 0xa8400000 0 0x100000>;
>  			no-map;
>  		};
> +
> +		dsp_reserved: dsp_reserved@8e000000 {
> +			reg = <0 0x8e000000 0 0x1000000>;
> +			no-map;
> +		};
> +
> +		dsp_reserved_heap: dsp_reserved_heap@8f000000 {
> +			reg = <0 0x8f000000 0 0xef0000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0vring0: vdev0vring0@8fef0000 {
> +			reg = <0 0x8fef0000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0vring1: vdev0vring1@8fef8000 {
> +			reg = <0 0x8fef8000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0buffer: vdev0buffer@8ff00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x8ff00000 0 0x100000>;
> +			no-map;
> +		};
>  	};
>  
>  	clock_ext_rmii: clock-ext-rmii {
> @@ -95,6 +121,15 @@ &cm33 {
>  	status = "okay";
>  };
>  
> +&dsp {
> +	assigned-clocks = <&cgc2 IMX8ULP_CLK_HIFI_SEL>, <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>;
> +	assigned-clock-parents = <&cgc2 IMX8ULP_CLK_PLL4_PFD0>;
> +	assigned-clock-rates = <0>, <475200000>;
> +	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> +			<&dsp_vdev0vring1>, <&dsp_reserved>;
> +	status = "okay";
> +};
> +
>  &flexspi2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&pinctrl_flexspi2_ptd>;
> @@ -176,6 +211,10 @@ &mu {
>  	status = "okay";
>  };
>  
> +&mu3 {
> +	status = "okay";
> +};
> +
>  &iomuxc1 {
>  	pinctrl_enet: enetgrp {
>  		fsl,pins = <
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index c4a0082f30d3..99ed8c1ee57c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -198,6 +198,22 @@ soc: soc@0 {
>  		ranges = <0x0 0x0 0x0 0x40000000>,
>  			 <0x60000000 0x0 0x60000000 0x1000000>;
>  
> +		dsp: dsp@21170000 {
> +			compatible = "fsl,imx8ulp-hifi4";
> +			reg = <0x21170000 0x20000>;
> +			clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
> +				 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>,
> +				 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
> +				 <&pcc5 IMX8ULP_CLK_MU3_B>;
> +			clock-names = "ipg", "ocram", "core", "mu";
> +			power-domains = <&scmi_devpd IMX8ULP_PD_HIFI4>;
> +			firmware-name = "imx/dsp/hifi4.bin";
> +			mbox-names = "tx", "rx", "rxdb";
> +			mboxes = <&mu3 0 0>, <&mu3 1 0>, <&mu3 3 0>;
> +			fsl,dsp-ctrl = <&avd_sim>;
> +			status = "disabled";
> +		};
> +
>  		s4muap: mailbox@27020000 {
>  			compatible = "fsl,imx8ulp-mu-s4";
>  			reg = <0x27020000 0x10000>;
> @@ -520,6 +536,12 @@ per_bridge5: bus@2d800000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> +			avd_sim: syscon@2da50000 {
> +				compatible = "fsl,imx8ulp-avd-sim", "syscon", "simple-mfd";

Any driver actually use "fsl,imx8ulp-avd-sim"?

> +				reg = <0x2da50000 0x38>;
> +				clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
> +			};
> +
>  			cgc2: clock-controller@2da60000 {
>  				compatible = "fsl,imx8ulp-cgc2";
>  				reg = <0x2da60000 0x10000>;
> -- 
> 2.34.1
> 

