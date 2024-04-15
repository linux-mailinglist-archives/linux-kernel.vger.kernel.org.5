Return-Path: <linux-kernel+bounces-145372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DB78A54B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A232B2351B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5027F7F2;
	Mon, 15 Apr 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ToASixYX"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FAF78B63;
	Mon, 15 Apr 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191796; cv=fail; b=i0TepCU2NNCMs4H1jUfL/Q4WVzNMsaBUaYTdCsbSvSyEGPSJ2xjrWXgPS+3RBOOh7W0ma0T4YklsbxtubYQS2zd4z4IGxaBEIPykAFRpc6DUuQ8TRTvq2ktda3UIpcaEZreVvPWv8WZmgG1K++/r27DFVNEAflcJk/zfyviBKsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191796; c=relaxed/simple;
	bh=PzR8e9zHaolvfbIEbYVaUT6PNdng4Zk8QjGHmW5s/QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VQqYCd9O572X0vreUnsIQhbTpZVnRCUSmEqyuY2aJXTNYp/DpRdpKtQ0oDwKbtyXtMe87Lih0PBU9nu+D7/044M0w8zzBE6ZAAL751wQOKC+vJ1RYWNeDbosUKq5QMx2NguB63Xoyil0pUEWk9u3s8+pk1F0KD//pOOKnRSU8D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ToASixYX; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsYbbVtBIZL1N/FJKPgZF4S1nOk+vO55uNqrgLQjVzN+3CzHot61DpH5GwqM2aj3ppYT87uQHRCXvOhpszINnhEJ3BUYEuTKlCIhjz6qOGm3EUXsbQIPkLUPI+7tzZliDxs+kuepN/ICEV4P+H3/0+3766lyTAjjTXAwIywTUTkXbvib9col0f0oXeVKhz7N85lzq1xBCq0DOm21PMoH1k50N9NJPpyRKreHV9fFrSHoEWI2MMkAafM00OxH2rtLFn8kuk9eMDfNSOfKjdINWw7D6KKr+H69cG9KQW8lCkv6zDgP4vHnSOBjadhe6Yho6W/HqVMJ+FQ7JourtjCh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tu4+nByzbRdM6VEj4meCEq02Q04hozMGEYvwJbaVps=;
 b=NQC3G0tf7dcKChlDxYVTgZPw8Fm3NY+QWFB46evjzSs1PRlsBWapz+wxLe8bzOAGrS3zTQJjSD0la3o7d0q8rWEw0xho2Uf+3RU99XYEQjZqzp0VN7csDhK678J/GOGWO8kwRw6g5RehD19siKTg9q9rdpScn9zYATSxRXbe8D9agXADv2kkZ2kWPLrNsjErdfpOhIFLxY7/1dLGmCtKRIrmtgDXWj0De9wb/xFpT1OuYp6qSGbEG/mfZf5XWRFQP2D9chLGDIiirtu4F6KbHkeCmeN2YxiF8XN6tFkhEJNF/rYATwlyMVZdaNXAEBoR+TvnfCq84ACXx6nh/hKRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tu4+nByzbRdM6VEj4meCEq02Q04hozMGEYvwJbaVps=;
 b=ToASixYXW3qFbpeSvk543j5cScGtLVmMrBzNjQf88BROlEwVzEAgu5XdnowS8xVPcaeiYl56HnY8QeuK4ibHfn32AoX+BIs/NL72YcIo9gTTVJvu4jfySy5qLIpwjEWcIAY17TNlienuwpr1IYIQ9yMbM4xCDWjCOW51uU2PNx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:36:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 14:36:31 +0000
Date: Mon, 15 Apr 2024 10:36:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, xiaoning.wang@nxp.com,
	linux-imx@nxp.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: net: nxp,dwmac-imx: allow nvmem cells
 property
Message-ID: <Zh07Y64DRkvDC/QY@lizhi-Precision-Tower-5810>
References: <20240415103621.1644735-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415103621.1644735-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f79eaa4-b78d-4c0d-b4a1-08dc5d59710e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Oo8iI6+3YtvXD+GUVeez1EEKE0a9dNfRmoBfVmIDphvC7BIR5Vp6FhQsOkFqcceSOpX/YLIYO9wyptKQddLqKAOS4/HDmnpu7CgOSitle4Z7BFq7H26+QdMnzOnz96D3g5FzjYZJH0k1Ukt/DqZqTgbLsfc5xMoRECYJ+GEifawjJbf+2KLQqPcpIp+EKdBcx91G/XEGoO1bSMGFeJC7Z4S9zd7DlIEF4n4Ll1TBzIuZxIV8fZjYXAxJ2j8UpW5PuO7HrcyJzfEP+Hz3JQ6m2gPD9Krylm2KwUZO3bgCV5uBNK+WJ+Q72BuhW9zsW8B9j9lFGtlHwpjerxPHq/ohJXht/Cm2PDUhm2aa4kD7Jk6N3NGxhfugs0obGrAfJlhoVAPlM4ZdsVWGJHjeGYIV1/MxS3JMC1ZQ4UOItGu3lqs4crcq0ed4mxxlWE6SMHkhmIjFdQ/jXAiGSya9hou2mQlU6vsUmTZAr9OpP8wu1etqLr7eWQAfZSX6VhNZPxUHAaVGrKvzv2QNW58nLb7UfjUGvMq1m7P0ODGoZWG8yXZPd/2irCeJVq3+Nzfq0TtAD7k3wTmTgcH2ydMMCCe074hVto+cJhTbNmCVcYgB5eM293/adwqNoY++MBUZtdjvSulqPPXaHwas/2vdUaFOY4r2X5MPesmHDelhL1YL2hCgxMv7XYCCJS9JZYDVk0NhecUaBdYc0cfIpWAPg3qMa3FBQcvUQOgTrsEUQjaAU0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZRWC4PPyB9kiipMe/8fI/MmHt7ujdmcV7b0esPq3nLetIF0WnwN0rFJ1GZFJ?=
 =?us-ascii?Q?CYS9cedOGVB86Hku94GBdgzXqHa6K3Ev4FQkfCETDCiqE/jPXsTIXo4p0gdV?=
 =?us-ascii?Q?VLjxrEMXWmdqluKt26vs719sW+n3jZX30Ny1rbhTYzeGo3RTKcUgzc8X5zkK?=
 =?us-ascii?Q?7jeHOiF3ACVKUBZlT+sAQ2vGStH0h3XDL4Q8Xt6qPoS8JNwhtZCID+Ax2lEN?=
 =?us-ascii?Q?jhKvm6FQ3JOhjdOehpDccat1//CGKG+Obit3ZYtraKg4xc/hnx5qIp3bvyO2?=
 =?us-ascii?Q?C/umETJfxQeA58U5R4GHMLXUMacNclOLKAvje8GEQJmBGRnOA0uU4fSo+E7f?=
 =?us-ascii?Q?LO/7EQdRcxSr+hd3zhdMcCvZBOq9swcrHSKgvhiCqB5dX0nxK4qTRQFkw+M5?=
 =?us-ascii?Q?AbXuS+Qvord0Lcq0LEL8b+pwnL7W1wvTudYAgo9hhKyJB+dMXCX+RSDUsOZ1?=
 =?us-ascii?Q?3tRBkOOawriMRIV+iPRFFJV4Ma5Fek2PVHvVFZVrErxkozeeqXvHlhMMda5v?=
 =?us-ascii?Q?slFeHK6A7lYUkWp+xtRXMjPzLNaHkH8sMnN0BNYmXSxgp7DortSQfio+Hgma?=
 =?us-ascii?Q?+vnUaI2OxKgrPNDmlR36x5AMzt1r7xkqRPBXKpJjCfK+eE3nsvAQgO2OrJE9?=
 =?us-ascii?Q?1v1e+33uny6QFKNC0l66L7FLmOfj4x4/MxRk3wKUZbwJqVkqyi17FcHqGkSl?=
 =?us-ascii?Q?JlImNwc/8XoxFnUuf893SRa7bcSy1ZEni781uhph8RO6j4PNdSLruyER7Qbb?=
 =?us-ascii?Q?m3O3zVHJSVjRGQNqY3UO+C0PjrgR3SMl1d35CpusT/UCTZzCDbqHuTgKTF2f?=
 =?us-ascii?Q?zPgiPK4XeqXS+9TThmEK2OhwiB1CAEPRE0N5kAmIUPlsrv1H6tCZhxHSk//+?=
 =?us-ascii?Q?jericeEXgNefrVP1TuG5hUC1iusH/o2TJYhMmswc4+gc+yWTSdNtSsZhU35D?=
 =?us-ascii?Q?3PFx1vwjEpT589zX7WuN8cUhOZcWLXhJ0cPdbmOoy1z2aRMi2NaJhgSbvRcA?=
 =?us-ascii?Q?9pq0h3E8buGGmrUwfXcsaBlcUhbRuFm4X0dvRjua6GIkvOwk3kZS7grXn3p2?=
 =?us-ascii?Q?Rnd+oyznysVkhBYW3HzgxC7nGjLTsIKFiwOAImzhCUJXGeBV5wJm+DLlGptm?=
 =?us-ascii?Q?FkcBZ4sXm+H3I/Yhi0u/OJcRCpn79mB6+IHI0ryTWzG6FMwmYAn7KmkYpoMn?=
 =?us-ascii?Q?2bgFcI5kAXB+chvrvVVDqrtxTxBvp8avRwLsGRTqyPF2E0t8kwXfQscQTWf+?=
 =?us-ascii?Q?4d7xLeXinf+OldS87SM2Gqhsi/0AUT/tyUf0R1Rt7iNrwMTGUHOOLyam6zlT?=
 =?us-ascii?Q?R8+VITCv+rGSBp0e8E5TH6aA05uIlS9fvgOgCXz/fG8nBFPoIq5cF1lHtkre?=
 =?us-ascii?Q?SvwHIvMdeUg6SCNKygWwW0g86z/NLX+zdFg7LHHjKj4lcrhUCvEVmj7XqTP1?=
 =?us-ascii?Q?Qy9/w3QZa+1XLSZGsNFJ1mrtfrvmqacWhqMj7eK5PoFzsggAgcMYFERwVYBq?=
 =?us-ascii?Q?FmM5ltH66dYQKbjR3ae/aYAefsPH8Wc12F+Z8/ut4NimjU3E0GevrMksYZ4d?=
 =?us-ascii?Q?bQEJNEAKCYjXPW6nWTt/QzCpt57VdMMJeGf+FaY8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f79eaa4-b78d-4c0d-b4a1-08dc5d59710e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:36:31.2931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di8Q6t2R6fxaF7LSQzlEhxLJrTXYkJYugF6/7+aAUJgVd7cBJYSIPkW8r41YokQ0PWz/vGe6sBUasGx30vEFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

On Mon, Apr 15, 2024 at 06:36:21PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Allow nvmem-cells and nvmem-cell-names to get mac_address from onchip
> fuse.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> index 4c01cae7c93a..87bc4416eadf 100644
> --- a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> @@ -66,6 +66,10 @@ properties:
>        Should be phandle/offset pair. The phandle to the syscon node which
>        encompases the GPR register, and the offset of the GPR register.
>  
> +  nvmem-cells: true
> +
> +  nvmem-cell-names: true
> +
>    snps,rmii_refclk_ext:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -- 
> 2.37.1
> 

