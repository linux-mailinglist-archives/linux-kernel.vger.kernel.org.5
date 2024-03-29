Return-Path: <linux-kernel+bounces-125082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA7B89204A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99705B27F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F11487D0;
	Fri, 29 Mar 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FO9NW8cI"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2115.outbound.protection.outlook.com [40.107.249.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B481482FC;
	Fri, 29 Mar 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721711; cv=fail; b=XR4n+1Rg+EawGkI+Z68WqLriHyccovjNfIbuefZ34bXrf4ktsNrtsBEvAF4HV8Bt4pWzPELw30RTdfOdS0Ghh4vz642OBY2kMQXV7jrQRJvj3/PrYmwgb2/dzkDDo8eABQxWEmd4qnQfh7wclyPmV9SAk16VflUillI3A4RRN0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721711; c=relaxed/simple;
	bh=DeQnZKlAiP4LWGm2ldlUC/9GgO22BaCh3V0pfrVArmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BNOD3x24X5Xu1Y0Yj1DexBIf53UU2wYa7QDOMyDdHlVy3ytpn1e5vmTMOlOcz2+bnANgwFbX5lcUCvLRcT84mUSVcgeBexFEww403UR3oZFR2KKDYaSeGAjSoeVz8r7TfAupJOPb8KzV/m0ejXP9lAoX/a2f2mambt8BfgnZC9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FO9NW8cI; arc=fail smtp.client-ip=40.107.249.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/16Meob1YxvoUaaf3gwXYv7P+0u8fTI7NEUlIuKz4KLoF95I7TYPjUNfpWHNHWLc1LnzgZ9+lEXA5aJtZncCpN95P7prqGo/RMW3V29utvEHwpQ2VZP0wCSy8kOhHkn+AaHuyDD9xeyMJvLy+DhYh8xC3hCiklrU24o9Yeo09q17g9fyEEMBuNj2MLYvdRmEBed2O0RS1A75KSWXS9+zaIfG6SPGCO8iyDV7rg55T4f5PjLlLnvkTbDnqo8d+PANhEvaL4RWjysbymHYSPwXXfi/qPuZfKpRR8qQpkU/G6VFHBaPHM14psSYJQi00+8jWjXOlbhvKUEStbAPMKa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6F9XsAwS/CP/1HvhWdlpPmCx+oXfwOCWEpV6cB3zzY=;
 b=gDunempW7WHayxenlNH4xa8q4I3iNBYes1YjQY4tuLPnRK5BTotFNunmHbC6zWg/tWbMGa0hiINI13Z7e9gnSZ5+Aj0ccG3fgBuYPkon9tfM8qXirGvxwTt6DNCemHg4Fm1gAWdQ0sgWkbyFlZZr58B47ri/HihUI/HXLV028AViLaCMDgsiFOasY4P9LxP3WSqbxHwrz0mm5tUCug9tlGoWzCMJ1JL415kj+mypgGU5oc0KojaIuPY/T67C6mKzipv36EqP9uPDuGs3CCojuQAnXxDQdeJYMOGcnpMVGdZ9eWPhbtdtvvXDOFpJtU6FK9XzV2XapgJ9YE/qTzbzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6F9XsAwS/CP/1HvhWdlpPmCx+oXfwOCWEpV6cB3zzY=;
 b=FO9NW8cIE34NAwgpH5i+Biy43/GvdJPXv16SK/f6HJNiQC9zprisogfmI5i1RyFFNGyopEhiJBVwvrGSlte9+n1ANlyvmt/WKtRnSI3peEx+3KBqZSWRCOruAxWdIdrNHyn0Inx3VhLqwnZ2N145nVgHMRE29nXyENyMgZfqkyI=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9512.eurprd04.prod.outlook.com (2603:10a6:20b:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Fri, 29 Mar
 2024 14:15:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:15:06 +0000
Date: Fri, 29 Mar 2024 10:14:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [v1 0/3] Add i.MX8Q HSIO PHY driver support
Message-ID: <ZgbM4hpFhYW0QCHm@lizhi-Precision-Tower-5810>
References: <1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9512:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6j6GcegMwjJyOFzlaukQJzeLnNNw0qTI+Ojq/xO1EV4t6EpQjh/HaslYFxItmF/7x1rbmpPqZEHCSRsQPuJl0bsb+/0SFRh6keBeYU3YtCGghNOkfU3bMdteZtffHofNSoYysQ32Kbirm337BCdV5ZWOcu4JHWrESaruJ/wBrrBBkNeZIQEoYsic2tbWlYTppF8ie0ZLVywMQU+lA/AYaw+GalsOBCN299kjFJ5oAg32MDA+IjFNwa5sCniOmbuoW8VYR+bLATAn93d/I09atU7I1p0BtNtNN34Hq5Ro10uoPWPlDtijui1gjX0d2zt8wXIBqlSwLo95Kd5hvK9qvWc63H1fMIquFNfZ3yY+9ybdNnVDascWFti2O6PBuI7y7JBpKjtdHgg5wHL69oR4sjr13tBocL8XPeBfbUBo4lIsXLu3bpfw7ddn1VMgVrqknWljTTUnprgJmnmVa2mlP3DdkMjSfZ1we1D25J3jMvH30GzDFtHQXiuueeCzspIMdZJVyBzkyguQbq54e/JJQlhb/6oGsu8P16230yfiigTdHojHHiUH+JmSpPm3RTQbFHF5lhm2u/73vjKMN4LctVJvT/inCtp87M4G3OCQ8aKaLHGfRbdbgUBtLRwxUozxD78H7cMQEXAz6RHUBDw912yMyOCWTaM++BLFWXkyy9N3dkO4b7eLLry5zCz8lsI+E8Dh+KQp5E957SmGgLW6hifm4YQ2ZvEZSgJzumLDwXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQIwueemWuZU4c1fG5/jtbvN9FaV/c6K8+WRKyH1CCBcAdQpPNHiKZrFd2vf?=
 =?us-ascii?Q?R20ALv/H1IxID3mdXApi3wm0nWKvHsfsPas1Z/6b/+96hnENUNpwncsETlK4?=
 =?us-ascii?Q?8y/yBGaRxyaUf9YZmF35vULm55ZsDgroNb9ZpvyKPC6qEdjp+7lKR3N2uT+T?=
 =?us-ascii?Q?A/0isLhmBi8sItJGe/SPG+ntr9l/1s6fJD2Be+xwGiRTGbxVN/P8ygR5Ib4k?=
 =?us-ascii?Q?audAbN34prTjhYmYFQMC/oIb+vVidz0QOBUnzuHZIx/M8GS4WFM6IPFVmPik?=
 =?us-ascii?Q?BhDlWhBxyPNto2Ox3IEo5TAvxwUO8lO5H38gjmBa49SWN7kgsEebFUHFTTNh?=
 =?us-ascii?Q?BjcHYFfPVWhXOv2SkbHDk5J0zT8JtSpJrjgzw8ReVxE+4ljrriRd2F70XKBD?=
 =?us-ascii?Q?rKAMIctomD6nM2+IHdG+ja2oDssmew9+LUzXsa/frefkoAz3xpwmR5oROFGV?=
 =?us-ascii?Q?uO/lkuRp6vyQ3zcRvobRC7Uldskck7+hTT8JGBqng4yihyYqCLl6EjcrVmKF?=
 =?us-ascii?Q?YvG8oEUzL4kynntDE/m6DhKmDT/MZnjLSMN3hCgk2wpdL9pbkC8dYEqahuf7?=
 =?us-ascii?Q?yrv54T9EiLStksFfTlLAS+PtxbtI6EnwG6fZCe6v/uXvpdF6lWDH3lQ1d5W7?=
 =?us-ascii?Q?/cQJXa7ng9TKpf33MYVfCu6PgmhcisA236rbotWIS3jRe/3ziOJv7u+BaOcn?=
 =?us-ascii?Q?Yu9QebKboDQILvqQMtaghPQRs06GvyI4HQnI1pBcyD3BVzREUH8qH6bXiPDd?=
 =?us-ascii?Q?0NQkrtfzsDtTcrrYKulU7pdIe/u53hXJUo6kM6AQ2ld3d/ONMdjqsdaqdY9j?=
 =?us-ascii?Q?+RXjHnty5EI35H3pPXDP8rjIEIGZb5dLyQWEUd9K+lydFoW3062X17HQDIJv?=
 =?us-ascii?Q?BuDhExjvUgkc2RtYIMQe8/5Wqe0/k5t1KtgA8EwLuB2B+VnVUsfXKqYkJ/f9?=
 =?us-ascii?Q?lnATZ2yEavx3P9I/zh9aGdfJd32TJDyk/noNfCJjc4Hww324KVog4apts2K2?=
 =?us-ascii?Q?jSo7lyu/dmcSMcBzB+2L5fUmhw3mTh4wk3yQoj6s2c3J+m/LVyXnr6TvHAQF?=
 =?us-ascii?Q?5lmog9vOYCcO80nDgKkY5sKKvmvgXVYF2EG3bRWzt+p4OOKNgNQ/wwWyCFWl?=
 =?us-ascii?Q?+6fCRDKivwhJk/L6uDnUQ9of0G6c1Edkc6GVwPorhDR9YjXAFrBc47jWGwPp?=
 =?us-ascii?Q?FRzJpVziPElg60lnXMwyakFM0INzWkm0exiT+iM9TOyGfsCsXZ/Iut/bKOwt?=
 =?us-ascii?Q?a4yiIJTBF5oaHt9paCTVVijTGexxJ73SAvG1fnl9e802mLjjOXHJXawS+m1r?=
 =?us-ascii?Q?uSMl3XfNJaUYs0TQ6kCmA3qlvtR2arsVFOjYRexIHvSvhR0kRnb8aQjR5bgK?=
 =?us-ascii?Q?W3VZ/4fbtYOhD+7ccw17ES/S9k+OfHMeAUosqv4P8hLXK4GwrrRHsoLUotTc?=
 =?us-ascii?Q?qISL1l2tIEMGJXw50y8tyT1a2q61Bz/vw9h4hmtdSkKzwYbu39Z5ztaIp3Sx?=
 =?us-ascii?Q?DpBRp3ZjxNO0CkC+EhhBdH4IebcewozZlazmfYEQsxbrbLJ5unhpNjH45tlG?=
 =?us-ascii?Q?AOiFf8sdEyvxNojMwew=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41806b3d-72bf-4b02-f0a8-08dc4ffaa216
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:15:06.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfWbXv/nzRmnUnGufYx4cCtbzzV6x9X3eyP0XJGT8sVISgAgpxRV3ntd0Y1be+GnJS90HQkD/2S8naNd9kXFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9512

On Fri, Mar 29, 2024 at 04:09:47PM +0800, Richard Zhu wrote:
> v1 changes:
> - Rebase to the 6.9-rc1, and constify of_phandle_args in xlate.
> No other changes.

Next time please send to imx@lists.linux.dev instead of linux-imx@nxp.com.

Frank

> 
> i.MX8Q HSIO module has PHY and mix control regions.
> This patch-set adds i.MX8Q HSIO PHY driver support, and provides
> standard PHY phandles that can be used by i.MX8Q PCIe or
> SATA driver later.
> 
> [PATCH v1 1/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
> [PATCH v1 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for
> [PATCH v1 3/3] phy: freescale: imx8q-hsio: Add i.MX8Q HSIO PHY driver
> 
> Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml | 143 ++++++++++++++++++++++++
> drivers/phy/freescale/Kconfig                             |   8 ++
> drivers/phy/freescale/Makefile                            |   1 +
> drivers/phy/freescale/phy-fsl-imx8q-hsio.c                | 518 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> include/dt-bindings/phy/phy-imx8-pcie.h                   |  26 +++++
> 5 files changed, 696 insertions(+)

