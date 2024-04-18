Return-Path: <linux-kernel+bounces-150794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F00608AA4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55291B213C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F87194C81;
	Thu, 18 Apr 2024 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MrnhrIng"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92E15E215;
	Thu, 18 Apr 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474642; cv=fail; b=KlQUWHRuzS1Wnovc/N/nfDYMZucid8l8rbOFqp1d/69H4tHeeHQGPXPadmd3/rhvfCEGh6rLjEisIB84QFbcbLydnA5KGkr4FWwpm4UGN02+rL2Ih6BOkrlLuVhvSKuGgUE30SRgYQHSyQvczzfQ8IFP6gF4TEIkxeWN20h3oas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474642; c=relaxed/simple;
	bh=2Iv6ydfKayXddA2v97HW5azkYK5740vxlSYsngJusuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ka71mClsG2XFMTvwkfFTa2uvzLXibxtiy3PIsJmtG2Igo1EXtWCu/14z2j3Vpx23CIX2Ci5gOKuxti06bxk9+YY+cX5U6dkEy3nhu50oi5BdYCehJ7hnkDUkjJE+tAyeU4OsUa72AiAdmWbItJrF0Zn275+mpB8IzNGb4Kpb6dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MrnhrIng; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbAnNclG2D3/jS8GyRAlfCPDLLc8ULG0UkLrAjeOK2Y2RT9LvLA+aC9sA1um3Bln6TxKrL4Ox2ii5Ofg7E0r3W7KlN+jUH/AlILexgrh9UHQZHCX2t6SvVs9BuDRSVLa0mt4EbWnBasnrwzrslvtwC6VFJfp94kxdvOhcDC3m8wyq/6ScudiFA2lBmxZ8dPd00sD4M8ZFW+Kgiv/079JW/usLO2p+mJlbGxLQBhT/L5Yoiq9VMgWNWJKvprl2KEUSDXHcYDWwrP5Ud1b8qMCqWT52/Q1DCl/TYXnMYMFw4I2rpraPNtodsCfqNgwE9geJQ51lI9Drf8SFJbFMLlm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4sdZJpihQw8KnpgbrRrCiH+0y7AF57lDftAjGxFoG4=;
 b=gDSTh9+rfBKzjtk5YQCaXF3wlshcbiznxX7Gbobqcx4YM5LCXfukNhTHuPh5fT/N2aw+MCeKU1oy3NeswSmCSf1dO0NnBEYhWh40kTWf0ZNi+En8/dLPiwwidpxA9ppqh+mfcGZL3qrzQvu/qKYLwXacFMbXEGWhl3Y2WezyGsxIjLUHQMU4fy6lps/I4MLOSNHZd4tWFVun1ng9jIMaXlMe/F0FKIb7n2/I5+PVy157DrSYz5WgsUEV/P3wYBtZfR9gSRKh+Pv+DDNLanvRfjvzx/7rjzbAo717lXRzs4p955tyXkoCoLau1XxMJJVqYJywS6+PWB84R5rH9i0HnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4sdZJpihQw8KnpgbrRrCiH+0y7AF57lDftAjGxFoG4=;
 b=MrnhrIng4CCtN+LHQaIk5dbmiQX8YQeo9WmJTMxxvTu9PeaMct8A5dii7L15CfkTMAFiNGLpLy6fKBQRHW6mINvqVjnoAKeaM5Higqg7pa+VRmSrWUJ9buyr/PQfkpyJFH5IOC3Bq8cuVIPvYiDhLwskoKhR8HXXM5UZccFGWK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Thu, 18 Apr
 2024 21:10:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 21:10:37 +0000
Date: Thu, 18 Apr 2024 17:10:29 -0400
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
Subject: Re: [PATCH 2/3] dt-bindings: mfd: add schema for 8ulp AVD-SIM
Message-ID: <ZiGMRTMLA0KdoVHZ@lizhi-Precision-Tower-5810>
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
 <20240418203720.8492-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418203720.8492-3-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7ce959-3811-49d6-a532-08dc5febfeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D1mQ2A9WY+DwN05uKtDfek4/ODi3zjAFXd+Fvf7Ow8M/orC64o1EQwP5wJM/?=
 =?us-ascii?Q?C+F5MdCHKfWCNjOPcXDLoMPvsze2yTd+Qv0aaRw58KIwBsNUgvnOnP6e4PRh?=
 =?us-ascii?Q?9494Zw9UvvRuNKhbNpzrASSUblaPuEDxZ96WrnMKHDDH02ke87l3jgO2TZ0o?=
 =?us-ascii?Q?LYs4D6moySeloYOvPGNd0A8Oaa7y0K7Ghjl85d/2wkr8LF8fQK2zqoicxgR/?=
 =?us-ascii?Q?WC80fVCLop9bXdte8Y24XmsRyDos6AU6edmNihHyPe50CaO+YB1W19A0ovDu?=
 =?us-ascii?Q?z1XdMGkwOHktWAdUqPJRTMTvY7TM404j4rmHDwhngvf1sZ7WVX7HbhqYTb1j?=
 =?us-ascii?Q?8s5p0U823pr0nZV4U3pXeNkviwzbQsxi/DoAxSvcFFdnOXzcN8FfH/4sN3x4?=
 =?us-ascii?Q?60i9a/ejckUPYN2WXfqtazIl4I43YzZH/Yenb5EVxpc1WlIqgShpJge3aSjc?=
 =?us-ascii?Q?Rv4n4EdfYUWI82yz1E/SmporEJEMaFw9GFM7P4D7XNzs92fPT4ANhHb1PKSc?=
 =?us-ascii?Q?E5mpah33dN0v1STJ5lzpKt/LrKAKY12tvveVxhbOUbijJmnzdjjsQx9j5e/V?=
 =?us-ascii?Q?YRFINgHmtuOu22thgeuB5i8YjhGxJq2XmgVcKgI9ti+zMaLY3aGzn+v7XFlj?=
 =?us-ascii?Q?qjBClRGxc8gskgEYuiLNcykxKEC2YFN1L6m0uw5hqcwc8i4qYkXUkxTaMrAl?=
 =?us-ascii?Q?yG6Jr6yooXjXoTT2xUmkkUZW00JTb2dV8KPpJcGNBeXJgH79Sw6NnM8u3ch3?=
 =?us-ascii?Q?ecxSR/XtHNKk53qEvKCicV9UGTtdvN3d2fnAfMYAuUPB3BYZqMM29ptQ8Ylz?=
 =?us-ascii?Q?OKHs3z75wx2MkHcV8pyRVzserp/PzNiuqrM9Jb3ox4ST+D6AVSr9dellbtXj?=
 =?us-ascii?Q?tq/TxBQ1PpZmwgDQjJE2qM87IN/YEB0htmYLwaq6P5TV/02lcQRYthAnyMzx?=
 =?us-ascii?Q?AuB6UAzB2EuWYKgLODePrUK3d/DuIuwPofB4t6HTkm4fu9iAsbWMVH77cHJZ?=
 =?us-ascii?Q?xQnLNqX1aevWIsJycheCufgK/ibvRabXOb1rL4EJnlSwO1cq77uMAaCO6eDp?=
 =?us-ascii?Q?w7g9/8APCtItyxqh5gKKr8mwxeQloVXfW4fBCxLzGLOamygewWSeDbqGm3Ua?=
 =?us-ascii?Q?CYgDa23LwHU2wjfzmtg0qLXscnSLtMEdb1TwZBG+5HtJqFulHWWy1LQqKVzg?=
 =?us-ascii?Q?C9UUFc9N9iwBphARVvJ84WmxbTHOTsnL0JEh+ccsS23LW75rWbf9bu+SicrQ?=
 =?us-ascii?Q?YLhYgWgIASp8theJst02arE0JkiJkU5VuihslVj/0rB1HrSemkpSRCwU1K3q?=
 =?us-ascii?Q?eHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ulQ6uD+koR5w0j2sReeShclZ+wDHSInjClS45paL4zOduS2zXFnfNqLfmGs7?=
 =?us-ascii?Q?eOc+I3R/y17guAh6rnYss6ACIgkhrkPzH+BQieCkk4MB+9EfuDuf+vlngTTb?=
 =?us-ascii?Q?ZmlUNLdc0h2FHhVN6XtJAV8zGiO3KkHrQMvR7L3rW3NR8iw8hstHlhntk4yl?=
 =?us-ascii?Q?z0RuC+5zoDvvfMsbxYBC1sOeRlA21zMfrfb3fV8BLLZKsEiTk6kzhD7wBV4S?=
 =?us-ascii?Q?wZEVkDRFlDeZJ4QejmBvY4S6JLzKIUfuXDgsG8WlG7OOdP+jxuYQnBwrOlPL?=
 =?us-ascii?Q?kCa0GF61yiIZGqJP1ZFu0OM0/i10mX08WmO56mJgIe9nVhH7vclhOU9EH2JI?=
 =?us-ascii?Q?r5B77aPyVebKnT4wTun6mqBYjDuRsmYgSvbxR7pGMMAYeJfKDBc1D2nY/Wu0?=
 =?us-ascii?Q?1Fb2+SsF9LvwmjxeMoYxAe2IgvEQVMv3hRbxWK55h791E5/LqGenVfSwyuIp?=
 =?us-ascii?Q?aLFXmmIV1R15mJ19jE03JFyR5TqiF9dgIF4cYz/cw+WJZ+uAjWxDi1vDjtZ4?=
 =?us-ascii?Q?znH2Is1Mi+B2ErWpP6zd4QdizFII04NJi5bg2OXjK0qgYMla5D1VkPU7FXdo?=
 =?us-ascii?Q?xpAGrJdwhn2BZ0lKneRWHAGO0o4TUOFKfn+zIrESdVHvRh5FPj/uqYC5kkvd?=
 =?us-ascii?Q?JHGrpZoFrUWJnPEpN46eTnkxSFABUM93pNMufHw/9hxBo5RZC6s6ElHDuRrm?=
 =?us-ascii?Q?M9yNer5ccBo+SQQCXrY/kzwK1DytWwsXaXpa4V8toussEj+Owi5/2AfAFhpr?=
 =?us-ascii?Q?10Fy2KQqgvqKfiAj1EDE9Vh+aTqKKqw8ZAB04q+hFU6bRhdV6DWEv3+ZCSWo?=
 =?us-ascii?Q?WiZvtGTlp0+bsfh1MWll2IR+s1XVfDHfFnNEvwjX6zCXD5mQYFKsGDu34qKR?=
 =?us-ascii?Q?Zt3yMVyoQHUrEUrEEg2C2s4pP9OzdH7l9DnHh/k8dcMFOjc6peTvNnlELVFn?=
 =?us-ascii?Q?jxpbX66jjjDgLHbCo55FOG9uiz8PbjhdObqwlZ5dOSU1a4EFDv1SHQOTKaan?=
 =?us-ascii?Q?4NrT2rpO3zAyX7wpyYImzcyDq05lPq8DNIW4Kwr8lq2lqdtUqOXnpHhaxalQ?=
 =?us-ascii?Q?E/rxTAyOvb+LdnPihUtxVu66aYM95xIwH1nUykAigsN60JsB8RTxjgfwNYAl?=
 =?us-ascii?Q?x7bEdknS6Eh32g3Y54Sch/PwnJNvUPxcSu5FvbfbneXKeabJVmbSxbC6FGMN?=
 =?us-ascii?Q?sGo3ZVlwsJjtsBAim6kYStBLQ7X1SwAgTgWsOUsLJO6oHOYwD1DNPKUAp14O?=
 =?us-ascii?Q?ko5KYaSumURCjjOKzZuulQsriCHwUFD8RzXBAocrdnd8jnoXvWr76tp7GqUu?=
 =?us-ascii?Q?RXMy9p0ZkEHxxHDz9giSdo1851ZMXggZPrzadGSQnPOoZRths1//aIixH/dm?=
 =?us-ascii?Q?DEhJrQnTAcLlM0w/F8Gx9vuxGeRbWA9GkCu59ZRqV2RM8HWSU0inEVm+2sUq?=
 =?us-ascii?Q?peLN6x5jcfMWLqf8MhhD1EBYTeeGGNFmrRQK1/NDkaXn0PMscBVNlp57THbF?=
 =?us-ascii?Q?d1KRhI7UWac+FdwMOouGVqhxGeyKt4Qr6fX02YRIO25ef8M02o8rloGPOegk?=
 =?us-ascii?Q?zfb32ww1Fdo+lmGujU7OOvWHzKF90QSkgvR05SiY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7ce959-3811-49d6-a532-08dc5febfeda
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 21:10:37.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2Zm9JKAmmJoM55Fdkvza0tuGVI5lgB8YalxnwEigjA2Wq7ap4CbzVSGwPEay15zyruZCh/HkDy4ilryHl84kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

On Thu, Apr 18, 2024 at 11:37:19PM +0300, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add schema for i.MX8ULP's AVD-SIM module.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/mfd/fsl,imx8ulp-avd-sim.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml b/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
> new file mode 100644
> index 000000000000..4020c6e37f80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/fsl,imx8ulp-avd-sim.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8ULP Audio-Video Domain System Integration Module
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  The AVD-SIM module provides configuration options for components of AVD.

Needn't "|"

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx8ulp-avd-sim
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8ulp-clock.h>
> +    avd_sim: syscon@2da50000 {

Needn't label 'avd_sim'

> +        compatible = "fsl,imx8ulp-avd-sim", "syscon", "simple-mfd";
> +        reg = <0x2da50000 0x38>;
> +        clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
> +    };
> -- 
> 2.34.1
> 

