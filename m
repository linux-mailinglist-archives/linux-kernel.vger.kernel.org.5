Return-Path: <linux-kernel+bounces-77817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDB860A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64CAB261CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83275125BD;
	Fri, 23 Feb 2024 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qkjocqo2"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F626125A3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708668034; cv=fail; b=YEyHSsxCM2q6ErBg1GK3lK9C5zpVdd+q5bo1ueTyn48Ka/N7ylzNcE2TwwFx0pqnxQKIuKuGs6Hx8cCC0eoX/XJI+USeE5ThbbC1kCdVMktvWII70IqWyT75IuJQiD/w3G2Zj7lGkGYPXTsBcGxPzuXhp94Lpe7F9VluWBHoeC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708668034; c=relaxed/simple;
	bh=pZ0+vzvWoiLuwOWE3FFtvpA7uzU79Utz6v0k5SHL5Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vqlmvd1+UXj4UzPA36Wzy2AByuO0K2PZi2NBz7CEKvVDZ502889FuNPGEARwAurBJzmFvI0QWk2oJm9ZGGap0mFfgWrgPcI1W03dIe7OuDVFGUb6X2+R0xQ4n/RdMTzMgW2FB8SvgtNI5cdv2FjMMT5qLbG/b25DpF2IJ1UE3p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qkjocqo2; arc=fail smtp.client-ip=40.107.247.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAHi/zpMRAaYTUiQwl1FKMglKvoDZBLB3VVeYZzpB9Z/LHoH56V51Wxu1o6FQqLjsEGaQ9Rv4uwOYI6etihXhWTbCFQ4YlB23Pp1CL0V0OSQzTtE35xxcR2gsvCwcKnIudmFp+ORvB3575LVPngngLrODWlNsa+PNcDszuZVClQXVNyl0DwMAyHkB3EiN+eH73xxCuKjkpwZxsEYDdWiCUKB/kUM/FygqrT0EHuC9JgO7LyOK91r2A3SBUJpHINqVinJbidRVuZGEVnSMDBjaSbeZGDDGlemrJvx7ReHOR9G1jrd3NmQ5kWXg9ionYIqXcAW1jOgfl96CUMw15VHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHbN84jXlStAfgy+i7uKn/cXiA6MgYSRRyxd8qPjwos=;
 b=eGgEZx7w9DQrPd4lqWL4Iv9wf7o0a7o4m4S89yWHGTsRy/ljIkjVrMBuOU9Zr1f5EPuxnSz5k1Rq4m7nHShIpZBDQkXxILBZCT0T/17nU1oRULxloo3h+rWhb7IgqURZ0cQmdf58IlAUs+CeJCemHzc5btoTz6Iidvs29KLw2cGMh4yBOF5H+aTjyJv78+pvGgkApx4xPDzUcjZTwuZbXAqv8D+2WmA/UgHnjdAVB+jfDdYDbKyDzOmkT54uYN3FfUuUyjdkAe0EpRI7OHhgWc72VJKX/OLVWe9JVRGSh8UGnBiiaJaqrJDWRwuE1X6MdFm5ppbBZrPrSDX1+RSWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHbN84jXlStAfgy+i7uKn/cXiA6MgYSRRyxd8qPjwos=;
 b=Qkjocqo2sb8rUpEuKchMzTQh6fmudw8f1fP0fBhEFfSsEmdZmRJfYbXLJKfsyyvJpdH55JkJv5Pu1noneFKuJdELlOfZItZi4W20erwi7OTxrHv3b7jpOJkAGSx6CCikIVPTYtMhm1xwx/UcOyb9ydlkcUSdiwyGttL0M1p8KNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5333.eurprd04.prod.outlook.com (2603:10a6:209:4a::22)
 by PAXPR04MB8670.eurprd04.prod.outlook.com (2603:10a6:102:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 23 Feb
 2024 06:00:29 +0000
Received: from AM6PR04MB5333.eurprd04.prod.outlook.com
 ([fe80::e905:d263:1321:f08]) by AM6PR04MB5333.eurprd04.prod.outlook.com
 ([fe80::e905:d263:1321:f08%6]) with mapi id 15.20.7292.033; Fri, 23 Feb 2024
 06:00:29 +0000
Date: Fri, 23 Feb 2024 08:00:25 +0200
From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, f.fainelli@gmail.com,
	kuba@kernel.org, abel.vesa@linaro.org, haibo.chen@nxp.com,
	peng.fan@nxp.com, shengjiu.wang@nxp.com, frank.li@nxp.com,
	mirela.rabulea@nxp.com, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, aisheng.dong@nxp.com, linux-imx@nxp.com,
	a.fatoum@pengutronix.de
Subject: Re: [PATCH v2] MAINTAINERS: Use a proper mailinglist for NXP i.MX
 development
Message-ID: <20240223060025.jetaxok7s45lzgxu@fsr-ub1664-121.ea.freescale.net>
References: <20240222130641.1213359-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222130641.1213359-1-daniel.baluta@oss.nxp.com>
X-ClientProxiedBy: AM9P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::8) To AM6PR04MB5333.eurprd04.prod.outlook.com
 (2603:10a6:209:4a::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5333:EE_|PAXPR04MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 1baa0781-e3bf-4c27-5893-08dc3434bcd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GtLebr3hec2oBuO58OtNS48+up5pXwrrrKJIDEm9GqX0ekqs+P5noT+RycslHj5bEjcJtcSRAj9BMZUw/AY49dyy0MXmqFUrxsoAeZUCOGCJcLEGHIVuv6s+tTD6ZAizqt0beEdzKFiv4IvXZKFeFVsj3K7Y3EHG1ILHL0Rk7GVbsO9usMtahJWFFQEmvYlO9DRgcNG0FWgvD8u20DiXEb0cdr53Ue43w9OAEVpECHvFeKV8wlZTEkNOXTXccpbHDkRQUak+D5Nhz+u1n8uKG8TaV7TJEomQIovT71hlBxfI+1rXfzHmbpY3MDyS/gv5JodyLeEMV7/u6r5fb5WlCg+6GR8QLa1A0bXdPGaifEh42cr2kSb83KbA1LtFj+ky+k8wwEBxXLoPJYD3NKvNMWJ/dVcTK5F8WKozvykjjjtmEmqQVFCDOp7Ib17aLoowbqxBdJSkgMZvKYB93un4264OtKRhb/3BpGWlCyE19cEfvZ3CpTWKs9GqaqpvtsqKg7zxMzZqbzT4eCjDnTM70A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eTWpquS8S7Y/gcT0i0yee02n2XKawaehjaACx1jwoz5WxkPKa5hqmYBOXkfc?=
 =?us-ascii?Q?VVwcrlexbTYgbbnAwz4oKn7Pm3m88CS9/ZSOodIHCIruZv9yD2O6XkaapfXA?=
 =?us-ascii?Q?mUPjk7FAODAT1zJDLCRsFemZJrKXAS9Eu54zU4leXqyJpnNzlGLyAFN4ZEys?=
 =?us-ascii?Q?+8ybCcBnvdYUVMK8mPEbtm9CkWu022mdeqFPMprubTeZKVcmOKJSMPr2pV9c?=
 =?us-ascii?Q?hot5b9vHuPAg/rwWaIP/KilaeYJ4ccSvhPoS/VUYffSxBVWS9c3RSHXfN5jG?=
 =?us-ascii?Q?dVCYpKvWUItMAboFVF1uRU8maG6jYP6MN6hNy8dmCFDWqrmD8Dc90jHfSPob?=
 =?us-ascii?Q?GJtjBbTVy+T6k4/JJrEexEw6iiU9RwXrpuCp+/1nd+A2fanTtqx3CJitRSzw?=
 =?us-ascii?Q?4/86/pp4uJ8izPWcpUhOBqrfJre8RDhYwxi/5iJ3FIA+fkLR1QVUpAz40gbC?=
 =?us-ascii?Q?BqBwvQ/UPIQQAvsRl34K6XeX+ZL+2xeW7kWe6ejtUrEXG7qalM0pH9zolX4w?=
 =?us-ascii?Q?6IcLLlHFGq8cHsM3Mzj1NMPUAnALGdQjcoGlHpqfVITR0Gp/4y06lveSixdv?=
 =?us-ascii?Q?u8ixFv9bjfBj6ny6S217ituRwwzo93rhMZeoIxgLKaM/jYOt4wzD9OQK4ed8?=
 =?us-ascii?Q?THhLPiT8uhDNFCzRMeJVe30T+WQD+IWHbee5XIwtV3EUoM27bT8Qihv4WZ6V?=
 =?us-ascii?Q?n+WJe3O3D5U02K6XhlZHjhjCJw7fkeaVUwVxQxw0sqtPMDYSTKcRqpIYYXIG?=
 =?us-ascii?Q?9WyXrmSDCbZoqwbAVuBcNDCi3DKZJv/7p7mrL60hoUisUMusA3G68o4LEtNX?=
 =?us-ascii?Q?gl94FBipj74s0VP/W0ChRa5QJ2hTUqS8BGg/tNeKAkqrhVG4PcZsrqtfM1ax?=
 =?us-ascii?Q?TsY4bGr/nal/WTUVnsTMW4OV27sVjNE9mi67JZoEA/TnRklSyoBgCWetjuWv?=
 =?us-ascii?Q?bmQQPgZt55HtCJiPUf3nZ5foV6eGgI4Y8FnC53S3lBoDUlo5u37HClkknpxJ?=
 =?us-ascii?Q?N3jny4WbZsMz5qQdgLTJuturHyzIu4XEYSse9BxZph3ostHB0oP6o2gDN3OU?=
 =?us-ascii?Q?WvsSTcJHLhJqZaBX/cl79bOy94cHrZo/D7fZKzjmv3m5Je9Esxfr/JG+8kWs?=
 =?us-ascii?Q?5FcaFRz6pSdkdGnGmTswE/xGFRiF2K7ns8Gpr4QJvmBgWqNC5YxYfsqqJcjW?=
 =?us-ascii?Q?h650z3SOG/wfuFOB4vPBRbnmBOmjP2EmQRZTLlFutLH1kr36fNcHJVrvTZ4Y?=
 =?us-ascii?Q?PGVa9QNupML05oLtalwEJWgEnQf7b6X3ILsW6JRqCgAwiVfj0xXRVGiqjbyo?=
 =?us-ascii?Q?9d2pwsvk/0vewEFXAHzR3NmeejedjOndMG63JxlxlNmzLD75Rt6cDLe53LPk?=
 =?us-ascii?Q?BedCl4oUJYqNGdclfvPZeXOlq8u8+yG2QV/tAc2mDnPxWLcSIRQkSZkzd+Br?=
 =?us-ascii?Q?8mE12xVoWe/gfPezhvwlCFbZqRyYOSd/ZCCsEQpsWwSs/hIr/Pzsn0gjdUgo?=
 =?us-ascii?Q?O8gqUhP9qWaAYQ9d+9EZm12eZbqO1pe2m8RZyfE7i59S7fnDXz3ZO0V8Xku0?=
 =?us-ascii?Q?IIiusc0bdcC0ZyAmfwPA4iDWyV6Y2OJoZOGVpVrS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baa0781-e3bf-4c27-5893-08dc3434bcd3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 06:00:29.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wT2PEj7vTSvNFL2Hy1w41/8h05ZTPHoC1ZQjI642F7rqR/6yCmsyoF9uZGEWAs7i3qKI7ZPYpCNQYuyO4ZOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670

Hi Daniel,

On Thu, Feb 22, 2024 at 03:06:41PM +0200, Daniel Baluta (OSS) wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> So far we used an internal linux-imx@nxp.com email address to
> gather all patches related to NXP i.MX development.
> 
> Let's switch to an open mailing list that provides ability
> for people from the community to subscribe and also have
> a proper archive.
> 
> List interface at: https://lists.linux.dev.
> Archive is at: https://lore.kernel.org/imx/
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Thanks,
Laurentiu

> ---
> Changes since v1:
> - changed from R to L as per Ahmad suggestion
> - removed name 'NXP Linux Team' from list name as per Aisheng suggestion
> 
>  MAINTAINERS | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..2344eda616f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2156,7 +2156,7 @@ M:	Shawn Guo <shawnguo@kernel.org>
>  M:	Sascha Hauer <s.hauer@pengutronix.de>
>  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
>  R:	Fabio Estevam <festevam@gmail.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +L:	imx@lists.linux.dev
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> @@ -8489,7 +8489,7 @@ FREESCALE IMX / MXC FEC DRIVER
>  M:	Wei Fang <wei.fang@nxp.com>
>  R:	Shenwei Wang <shenwei.wang@nxp.com>
>  R:	Clark Wang <xiaoning.wang@nxp.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +L:	imx@lists.linux.dev
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/fsl,fec.yaml
> @@ -8524,7 +8524,7 @@ F:	drivers/i2c/busses/i2c-imx.c
>  FREESCALE IMX LPI2C DRIVER
>  M:	Dong Aisheng <aisheng.dong@nxp.com>
>  L:	linux-i2c@vger.kernel.org
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
>  F:	drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -15704,7 +15704,7 @@ F:	drivers/iio/gyro/fxas21002c_spi.c
>  NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER
>  M:	Haibo Chen <haibo.chen@nxp.com>
>  L:	linux-iio@vger.kernel.org
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
>  F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> @@ -15741,7 +15741,7 @@ F:	drivers/gpu/drm/imx/dcss/
>  NXP i.MX 8QXP ADC DRIVER
>  M:	Cai Huoqing <cai.huoqing@linux.dev>
>  M:	Haibo Chen <haibo.chen@nxp.com>
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> @@ -15749,7 +15749,7 @@ F:	drivers/iio/adc/imx8qxp-adc.c
>  
>  NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
>  M:	Mirela Rabulea <mirela.rabulea@nxp.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +L:	imx@lists.linux.dev
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -15759,7 +15759,7 @@ NXP i.MX CLOCK DRIVERS
>  M:	Abel Vesa <abelvesa@kernel.org>
>  R:	Peng Fan <peng.fan@nxp.com>
>  L:	linux-clk@vger.kernel.org
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
>  F:	Documentation/devicetree/bindings/clock/imx*
> @@ -19630,7 +19630,7 @@ F:	drivers/mmc/host/sdhci-of-at91.c
>  
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
>  M:	Haibo Chen <haibo.chen@nxp.com>
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  L:	linux-mmc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci-esdhc-imx.c
> -- 
> 2.25.1
> 

