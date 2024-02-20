Return-Path: <linux-kernel+bounces-73197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AB585BF20
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2C02849A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A66F511;
	Tue, 20 Feb 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="quek0dfs"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B924C60;
	Tue, 20 Feb 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440647; cv=fail; b=Q0wivmCDsYxgEBbxS0vKOSiTGqc7mek759VJj4GGS1pVkoGQcXxInJyZ3FBeK4itUStCapkhKWUx7LgpBBjRSww5N92gApu1Si+0knikmdAHEi8pRZ4P5o0uCa8SCRLkbWNgaMixQ1lQ5uf/XyQqyEkGAPjifrPkl5nQ+EazULg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440647; c=relaxed/simple;
	bh=4Z/FJ7J+IpSP0fISgauGLGfq0eIqcGCEIoMpYNxEeM8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YU/5+EHIAfN+miliZoFsygLlndyy42HE2KFQFDe5/nNOHPmO0KQXJphLcQcvfOhFjrInEh5GoDWnlrbXvKFZZmaOQuGPAee1t/L1r7gw5lgFMxbdnEjEv/6yDLEXtN37cKLdhhj6hps3abExddN4uCUnjfaP13mMCUpkYPWj2lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=quek0dfs; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFagDqv6svqEeF7F49o3P0EzNdVwc/I8A03U8qp0GyxxuP3m6Pa8hdmUlKp0buaXfVOKccyaWsH28s7qtULtn/yBi+t4P82jVNUPeImhc/Ji0pUYY2Rt1/mpU5/CLwFe1Hat64Rt7xX1brjgjHWMO8Tbu0y7D2L1XW/Zo9D4VLPjER1wgNOiXkjWyO+SKTbmSvUsMtNX1oE6O0jh/TbwAlPfa4BbrIycQ9604XM8W3c12P2nDZqN/Imvgq049Ofz7bN6E7o/K/+i8VZ+zS2e7/3ZBbyvpGnWoenOl0cHVBxybXNF22Dy/pp1Q7NDow0QYOSmtvEmKjg1W6b79PZFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn9l7PqhhPqilKXjMFhrHBLXj+dBmuOr+a+o+HPPrSQ=;
 b=DlnvTsNjPWpE1TZHWoJK/htpbuXvnvp1pa2LF1V1NAkQ7HeGQiCvsBAw+0zteS8fkwpN3eIDvk5DfwdE8mMZTtk1s7BWPFMI5ImYgunJNWZcqLreGPVX2aOkBJ2EUKg/LUuuTLGtEyS4hmDv5uIhxQ97W8+7mGxqy+8JT+5GLIHQLSqYWEFSpmxmjkisXtz0MzoSVFCif7mPtlRDXetGm9PhwdwwzgrTm4PhG1eytUyLG2hD1Fg/uOk5bbPKmR/Dl7Qi7nzbPU2B/6TJZWRtRzpRCKi2FZeNGHlUw/VRZBOd+MJmL68ps6OYYA2rd4tuDDYegB9G3Dnr5bXgdbfBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn9l7PqhhPqilKXjMFhrHBLXj+dBmuOr+a+o+HPPrSQ=;
 b=quek0dfsE6nrLxhaKIdxU2NdK5whhQgGJvXOhj5qPXy6B6lO/9R2xpuxgsBssNOyBOE4v57MVcDtad3+mplewsBlOMLLfpoXUucm8l5xhx5P9MRHvpBXFxee9Pq+3JfbDX0gwSwGMHVqycNOGkxflWdEe9mzLQuZgO0O+WsOlSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Tue, 20 Feb
 2024 14:50:42 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 14:50:42 +0000
Date: Tue, 20 Feb 2024 16:50:37 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: zachary.goldstein@concurrent-rt.com
Cc: Shawn Guo <shawnguo@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
	Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] arm64: ls1046ardb: Replace XGMII with 10GBASE-R phy mode
Message-ID: <20240220145037.kf3avnykjif24kkr@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-ls1046-dts-use-10gbase-r-v1-1-8c2d68547393@concurrent-rt.com>
X-ClientProxiedBy: AM8P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::19) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: e252216e-9b3b-41ce-0caa-08dc32234f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xrQ+nKbdhTRJPzP7QwLeIwXEbFIqot39MvtlKVKZ1z1gc2Y7P6pfLy3KPEAG8CqTV5JmsU18eKWtnqYh4ZqyRe8rL+KyH25HiSTJ3XbSd46vdwJCZpsfiREFEHPDXwIPiY1S7Sj8D1x1gNT1k42W+Vf63tt+6lE34KhZ5ZLfDXUHVAjFsxAvyprLHV9awCfZ81eZ/aAnZQjjLGFEEhvT+Z3b6M4e7EakYwpcoDPD6iWMUOcCSFjS0EZxEkymFzhVXva+FERsMxNlFZHasOwB/SlZhmABKRuEWYfDMLW/pq9HwVfJW/pEuQTHPVsbNnNPn130uZ9gXYFtcw5rolxWTQ7ENVXM0WtLrrw5pMFRPZwW1TCu0xdM/Xerny0jhZAs2PwGGuPj7sadn/UMUJFoIjpoUC1S4GJkGVNhU6834xdHs0PgFJhOLsHGVWHqCuyCC9zUJQGfxNWDMU/GudDTWVty59xFy0Ifu1+7h2nNm9khKT9GC9dLJPDLKbrikNpDLSVuLAOFq0H0imDvPJkasD8YF7WMdFGwOoeCDvs+zD/xky4eUIa9ALCzTemvk2e+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ict3HVcC5Fz4Q1/KmbUaL+Hwp8mbvN5cMywzs8A5O6mvZh9WwLUkFcMN/FSO?=
 =?us-ascii?Q?/nfxBXTOlKxlNPuufKzib8HdUyVkfAPUmDPHGp/e85id3v5XtEdsg4+i2jXv?=
 =?us-ascii?Q?9xTHC0dbk5VYw4ZEBhCzpxgrB7SS32CIcceicRCkP/s27WvRKo8EdtbDEJ8X?=
 =?us-ascii?Q?sg+FTv7X2frC46tmHcjfuR7731i93g/eOan7oHh9t2W+oK1LBDwwsE5EMLZ5?=
 =?us-ascii?Q?Bw7N87zBS8c5xhyFFuJ7r0SpAZ28OuQL+XucAQznlBuaWgZModTyyyGwNMg+?=
 =?us-ascii?Q?aKc0da4wkGye0nkqYLxCPe9OHG11fPLdK//reHVDPyO9cZ4+0jXCLAOFHP/j?=
 =?us-ascii?Q?hdp5mhXuo4zALWXC7FZA3m74BQBoEP1aRQmJbIfihfNWt/GbFbQeHPhiPbnJ?=
 =?us-ascii?Q?KtVrcgcwaL60/9Ge483ivpN9qcipTzaF0vA9uudmAns3jeSHnRAKtUp3fszW?=
 =?us-ascii?Q?Zx6+xXhXBIXlpMeKWReXCIeePLVk/lidUmTmVCgyOX70U/6oZbGlpU5yc0yz?=
 =?us-ascii?Q?gv0u9Pb7ZbVfJTtB/Zb9JiIrENfdwXYigkPk67V+UU5wZh0R6h3y6xl6dDTq?=
 =?us-ascii?Q?tb8wkRbxNkoedXIAzWigT1pC7+CViQAwkk9jpZBM09yihXqzdya8UWmN48h7?=
 =?us-ascii?Q?k6kaoq3dRvLCeE6SKV3uKKbyBMv+9QJEvaCqH0k9AvwWdrTqHP5BJwyrHJi/?=
 =?us-ascii?Q?3//BHvopXOmPJRjmxTUOvLGY3tRLBGuF6wYBPdmklcAc2torTfwbFYZ44bFh?=
 =?us-ascii?Q?jCq7K3yJgYj5p2ZikA4xw01uEGNgV5ijDLUtphgAoKuJOhmDV+XU8Ra1Qie+?=
 =?us-ascii?Q?JvnyatPWABImoV6+lRHwUef+0M8uj+BPEQmgLZvy5Uabsng09wjGq7oACQ98?=
 =?us-ascii?Q?tHGM5y82ZDuNdjeLFrRCZ7Jwj48hyl6gflyF9FzshVchcDZkYvslwm+Ue4UV?=
 =?us-ascii?Q?DNqP7cw2L0U9WdTz8TY1sdRsX+EtQE7WHtrexf4iv8RelEOS2vMtIK6pSeH/?=
 =?us-ascii?Q?h1MRHCkcsgR41FBcPXgP90WcAJBHptthtlJ3w72L2h5FSngFlMNyKhTeBwTy?=
 =?us-ascii?Q?YXLeNnyD3Z6A8HdMRj1cQUZy3EqFGoEv/OveratPCRk56McXCpyYW6Zt7l9z?=
 =?us-ascii?Q?RFnPwAki0SvyvGcqF/RqNEN3jiI5IG2eoCS2TzBDeELmHiTeuaoU3qiCIIxu?=
 =?us-ascii?Q?MLACpz0NjpsjUjQ51wLMBDipeBy6S1gVWw/IF7bo+8dUfEdW+FZSbcKwiCiN?=
 =?us-ascii?Q?6a8nJMDzcQ9kL55DEPzYEeoSyhH6R8oJvOeWc29nJeZVpdFVCpr4W9qDghO1?=
 =?us-ascii?Q?dlcwjCOUSRgEbqcEJ/3GSOTEyqSBBHcToFwYDGNWVkrJlEvOUKjuejzR6K9R?=
 =?us-ascii?Q?M9emzrIxhHo6hBf8OdE89KVtUhVBg8pNZSOBYhJLK9NKl6PDXdF0qeyofyiM?=
 =?us-ascii?Q?4IVJ65XXn/Lw7va/+4ATsgSWaZOfgVyodCGvO8Akera5tD0l1L/2rUYpx19I?=
 =?us-ascii?Q?XCgNjwOqTFDhMmFZVnjQnq6yDFqGYFv5jZVbT6O9HyvPt8F0tNcU+6hbsc1X?=
 =?us-ascii?Q?WI2juRim+r50xxXCcZTx3Xd8eWT6/I8JuSpnpYrlkYInAO1gxQxNtyis3ghX?=
 =?us-ascii?Q?O7nTlOdM2KZjDMIpeAq9Vt8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e252216e-9b3b-41ce-0caa-08dc32234f5e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:50:42.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x81QRrFacvYYRon8weEyKSoNsMv9clr92tEBdqrKaTuHZC0RNZdiIqpyBlbnbJfzahSGF20P28ZIdtP5B6CjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

Hi Zachary,

On Wed, Feb 14, 2024 at 05:21:54PM -0500, Zachary Goldstein via B4 Relay wrote:
> From: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
> 
> The AQR107 family does not support XGMII, but USXGMII and
> 10GBASE-R instead. Since ce64c1f77a9d ("net: phy: aquantia: add USXGMII
> support and warn if XGMII mode is set") the kernel warns about XGMII
> being used. The LS1046A SoC does not support USXGMII, so use 10GBASE-R
> instead.
> 
> Signed-off-by: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> index 07f6cc6e354a..d2066f733dc5 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> @@ -149,7 +149,7 @@ ethernet@ea000 {
>  
>  	ethernet@f0000 { /* 10GEC1 */
>  		phy-handle = <&aqr106_phy>;
> -		phy-connection-type = "xgmii";
> +		phy-connection-type = "10gbase-r";
>  	};
>  
>  	ethernet@f2000 { /* 10GEC2 */
> 
> ---
> 2.40.1
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> 
> 

You do not need this patch in upstream, and I strongly advise against
merging it as-is. I've just tested pure net-next on LS1046A-RDB, and I
can bring up fm1-mac9 without any warning.

You'll notice that commit 5d93cfcf7360 ("net: dpaa: Convert to phylink")
did this in fman_memac.c:

	/* The internal connection to the serdes is XGMII, but this isn't
	 * really correct for the phy mode (which is the external connection).
	 * However, this is how all older device trees say that they want
	 * 10GBASE-R (aka XFI), so just convert it for them.
	 */
	if (mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
		mac_dev->phy_if = PHY_INTERFACE_MODE_10GBASER;

So, what gets passed to the Aquantia PHY is PHY_INTERFACE_MODE_10GBASER,
even if in the device tree, phy-connection-type = "xgmii".

Now, _if_ your patch were to be applied on top of upstream, it would
actually break fm1-mac9 like this (WARN_ON added by me for a call stack
of the phylink_validate() failure path):

WARNING: CPU: 2 PID: 1 at drivers/net/phy/phylink.c:763 phylink_create+0x8f8/0x90c
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc4-01058-g9e1deba407fb #1812
Hardware name: LS1046A RDB Board (DT)
Call trace:
 phylink_create+0x8f8/0x90c
 dpaa_netdev_init+0x1a8/0x2c8
 dpaa_eth_probe+0xd70/0xf64
 platform_probe+0xa8/0xd0
 really_probe+0x130/0x2e4
 __driver_probe_device+0xa0/0x128
 driver_probe_device+0x3c/0x200
 __driver_attach+0xe8/0x1b4
 bus_for_each_dev+0xec/0x144
 driver_attach+0x24/0x30
 bus_add_driver+0x154/0x244
 driver_register+0x68/0x100
 __platform_driver_register+0x24/0x30
 dpaa_load+0x34/0x64
 do_one_initcall+0xf8/0x34c
---[ end trace 0000000000000000 ]---
fsl_dpaa_mac 1af0000.ethernet (unnamed net_device) (uninitialized): failed to validate link configuration for in-band status
fsl_dpaa_mac 1af0000.ethernet: error -EINVAL: Could not create phylink
fsl_dpa: probe of dpaa-ethernet.4 failed with error -22

It fails because of this in phylink_validate():

	if (!test_bit(state->interface, interfaces))
		return -EINVAL;

And state->interface (PHY_INTERFACE_MODE_10GBASER) is not in
mac_dev->phylink_config.supported_interfaces, because the fman_memac
code is not prepared to handle this combination.

The device tree node for fm1-mac9 looks like this, generated by an
awkward merge between the following:

	ethernet@f0000 {
		phy-connection-type = "xgmii";	// fsl-ls1046a-rdb.dts
		local-mac-address = [...];	// U-Boot
		cell-index = <0x8>;		// qoriq-fman3-0-10g-0.dtsi
		pcsphy-handle = <0x31>;		// qoriq-fman3-0-10g-0.dtsi
		compatible = "fsl,fman-memac";	// qoriq-fman3-0-10g-0.dtsi
		reg = <0xf0000 0x1000>;		// qoriq-fman3-0-10g-0.dtsi
		phy-handle = <&aqr106_phy>;	// fsl-ls1046a-rdb.dts
		fsl,fman-ports = <0x2f 0x30>;	// qoriq-fman3-0-10g-0.dtsi
	};

Notice that unlike fm1-mac10 (node "ethernet@f2000"), there is no
pcs-handle-names property (fm1-mac10 has it defined in fsl-ls1046-post.dtsi,
whereas fm1-mac9 doesn't. Don't ask me why, I don't know....)

So, knowing that of_property_match_string(mac_node, "pcs-handle-names", "xfi")
will return an error code for fm1-mac9, now please walk through memac_initialization()
and see what happens in the 2 cases:

- mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII (current device tree). The
  code creates a default PCS and assigns it to memac->xfi_pcs like this:
	if (err == -EINVAL || err == -ENODATA)
		pcs = memac_pcs_create(mac_node, 0);
	(...)
	if (err && mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
		memac->xfi_pcs = pcs;

- mac_dev->phy_if == PHY_INTERFACE_MODE_10GBASER (your modification).
  The code will still create the default PCS, but assign it to
  memac->sgmii_pcs instead!

	if (err && mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII) // not XGMII, but 10GBASER!
		memac->xfi_pcs = pcs;
	else
		memac->sgmii_pcs = pcs;

And this is why, with a NULL memac->xfi_pcs, PHY_INTERFACE_MODE_10GBASER
will not be in phylink's supported_interfaces.

To make your device tree patch work as intended with the current
mainline code, what you want is to also modify the driver like this:

From d6bda34b132d17d1c236d27436b9335fac22c062 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Feb 2024 16:12:27 +0200
Subject: [PATCH] net: dpaa: fman_memac: accept phy-interface-type =
 "10gbase-r" in the device tree

We support the phy-interface-mode = "xgmii" conversion to "10gbase-r"
through code, but not actually through the device tree proper. This is
because boards such as LS1046A-RDB do not define pcs-handle-names in the
ethernet@f0000 device tree node, and the code only has fallback xfi_pcs
determination logic for "xgmii".

By reversing the order between the fallback xfi_pcs assignment and the
"xgmii" overwrite with "10gbase-r", we are able to support both values
in the device tree, with identical behavior.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/ethernet/freescale/fman/fman_memac.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index e30bf75b1d48..0996759907a8 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -1076,6 +1076,14 @@ int memac_initialization(struct mac_device *mac_dev,
 	unsigned long		 capabilities;
 	unsigned long		*supported;
 
+	/* The internal connection to the serdes is XGMII, but this isn't
+	 * really correct for the phy mode (which is the external connection).
+	 * However, this is how all older device trees say that they want
+	 * 10GBASE-R (aka XFI), so just convert it for them.
+	 */
+	if (mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
+		mac_dev->phy_if = PHY_INTERFACE_MODE_10GBASER;
+
 	mac_dev->phylink_ops		= &memac_mac_ops;
 	mac_dev->set_promisc		= memac_set_promiscuous;
 	mac_dev->change_addr		= memac_modify_mac_address;
@@ -1142,7 +1150,7 @@ int memac_initialization(struct mac_device *mac_dev,
 	 * (and therefore that xfi_pcs cannot be set). If we are defaulting to
 	 * XGMII, assume this is for XFI. Otherwise, assume it is for SGMII.
 	 */
-	if (err && mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
+	if (err && mac_dev->phy_if == PHY_INTERFACE_MODE_10GBASER)
 		memac->xfi_pcs = pcs;
 	else
 		memac->sgmii_pcs = pcs;
@@ -1156,14 +1164,6 @@ int memac_initialization(struct mac_device *mac_dev,
 		goto _return_fm_mac_free;
 	}
 
-	/* The internal connection to the serdes is XGMII, but this isn't
-	 * really correct for the phy mode (which is the external connection).
-	 * However, this is how all older device trees say that they want
-	 * 10GBASE-R (aka XFI), so just convert it for them.
-	 */
-	if (mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
-		mac_dev->phy_if = PHY_INTERFACE_MODE_10GBASER;
-
 	/* TODO: The following interface modes are supported by (some) hardware
 	 * but not by this driver:
 	 * - 1000BASE-KX

But!

Device tree is stable ABI, and changes made to the device tree file are
meant to be backwards and forwards compatible with the code (it can be
provided separately and not necessarily in lockstep with the kernel
version. For example, I understand Arm SystemReady IR wants U-Boot to
provide its own device tree to Linux through EFI). So, in general,
device tree changes which only work with a corresponding kernel change
are frowned upon (unless maybe if the kernel change is a bug fix that is
backported to all relevant stable kernel branches).

So at this stage we should take a step back and re-analyze the cost/benefit.
You said there is a stack trace in the Aquantia PHY driver, which there
is not (in current mainline kernels). I _think_ you are seeing the stack
trace with LSDK, which is currently distributed on top of linux-6.1.y
and has not yet integrated the fman_memac conversion to phylink - thus,
it does not contain commit 5d93cfcf7360 ("net: dpaa: Convert to phylink").
At least, I do see this stack trace there. I think it can also be seen
with mainline kernels before the phylink conversion, but I did not test
those.

The main take-away is: ALWAYS test the patch you are submitting to the
target kernel it is going to be applied to. Especially in the area of
device tree bindings for DPAA1, things are rarely as simple as they
appear :) If you don't, you will have an unintended negative effect
upon current mainline kernels (which must still work), and not the
intended effect upon LSDK (more below).

There are a few options to go forward from here.

As there is nothing broken in the mainline kernel where you are
submitting this patch, the simplest one, as bland as it may sound, is
simply to wait for a new LSDK release on top of linux-6.6.y. Even in
lf-6.1.y, AFAICS, nothing is broken except for the stack trace. You can
keep the patch in your local kernel tree copy to suppress that.

The other option would be to submit the fman_memac change as a bug fix
for stable, wait for a while for it to have time to propagate, then
modify the device tree as well. But, it is much higher effort, and
there is no procedure in place, AFAIK, for LSDK to integrate your patch
(other than through upstream + a few months of waiting). The upcoming
LSDK release will be on top of linux-6.6.y, it will make your effort
irrelevant if it's only for suppressing the stack trace, and you are
racing against it. This path is only worth it if you have the dedication
to dig a bit deeper and tidy things up in the DPAA1 kernel support
(which would be appreciated though).

_If_ you are using an older linux-stable branch but not LSDK, yes, the
feedback loop between your patch and its effect will close much sooner,
but you will have to convince the linux-stable people that it's worth
accepting your driver rework patches for a functional reason and not
just aesthetic (see Documentation/process/stable-kernel-rules.rst for
reference).

