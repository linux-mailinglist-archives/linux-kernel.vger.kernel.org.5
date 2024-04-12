Return-Path: <linux-kernel+bounces-142901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC72D8A31D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD221C22826
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3AD1482E0;
	Fri, 12 Apr 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FWafY94E"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462B1474C0;
	Fri, 12 Apr 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934715; cv=fail; b=bRFONG/v987r0tYYb8sLyyK0rSfgEPmkMEHYcPbaHbHLgaKURFpdQdLEzIjfMs1UNGjWQn9y7lyAjBlm/E64gnl+ZiJ9gGjjSTab2RZK3y1vmrR6Iy5PBee4Qtac9En/VXR0SbCOP4jnM/WhtKZpDmKkEBeVYp4xs78LIfhqc2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934715; c=relaxed/simple;
	bh=bn4iSDpoP6m6fCPsGkGy68NGu/4qcZSOaOsuyFKPLc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGVLPH5WVw3FqRlUDjVlkFVfuplxXRf3o1mtV55CgqJEyYG7b8zFTHmfhzYQsc/et8JJZ4OWwNrXJrc7tCebDJ1VCM79KKHFIJRp4e7CsJeYoYBJSz5Chhle8QCNtPIP0BH835pIKZ6qEACLUtXCeFkcqvnNka2RbPCSswdlkd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FWafY94E; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsDajj/1U/eTV/8dXXPN5k4IsxU/Gr9mbCqMenl2Q9+E4BOoNfOwKpqRXTtIvwUk31bbM4fuRm3Fs8cBOcnFXEpMHuUwUb6uuMD22nBDlO9DMD9F1LTqyPPMhs/1zZ+DVFTLzpvvOVlCvt8AleLmJvHUyjFwj/arO0mP79heKxk+euFKvYqB+WH4/8Pj2HaRAnRy21K0wzJllKKJi4ZlNS2JuYxE5b5REnekVKdH9L73S4RBS6J/oY5ZjfkeMiE1uRPJsFfZ3jPDghcDMfEBCPvgJYjHleVPqWrsV7Wsxdi6pynGoaHKLvo4rOqxZd1LwxMAiqZDPSRSZt4wbD87MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REetNNH+744vzfOFKMowIgPgGhYNeDQT9z08UjV4Gd8=;
 b=SIx4SyBIbQf942l2eK2CFHP7BkVchPHRoErNNsM7GioXEGyDWsdGVo3XHt13x504aJQLb2Cso0LWOhXZPvISRpC1WU+uHCZIViforP/LaylmoZt5DwXBFrVpp9XPArPwOrHY4mQtm1FoK19JfmiS5oubX5i6pyISsEUo0jVCVbUpFu9z0/1urClH2DztI8qdTbWxayIaB9ASuMuuV1GphvVU0SbphdhPqtRrxNOen9BTBZoCPE6NUPCgojNcfYbJE6IUwOy73KoziclSEIQVLvR1hkZHNnbUsLDFsnJWEw4Pr+z/eI18RL62JPwLzMSf/I/O0yeOe9fpuoluu9cqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REetNNH+744vzfOFKMowIgPgGhYNeDQT9z08UjV4Gd8=;
 b=FWafY94ELGxVaTltBHCckcJQcEqC2qr0syOdF9Q8EZbnWIvQoSfVLtV3HZ8o/q3dYvnTzBA1hAdCF+9+W0dagzGE46diulp/UWb1i4a4rrCzwQPzRMuzcA2DXjXoIvZhLGpBbeCmowWqDgwQB7P23CUSGpD3eflD1I8s1Q7p0Wo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7282.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 15:11:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 15:11:48 +0000
Date: Fri, 12 Apr 2024 11:11:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95 SCMI
 Pinctrl
Message-ID: <ZhlPK4PmnYHj0K2d@lizhi-Precision-Tower-5810>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
 <20240412-pinctrl-scmi-oem-v1-v1-2-704f242544c1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-pinctrl-scmi-oem-v1-v1-2-704f242544c1@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f86023-27b5-4153-b19f-08dc5b02dfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TZW+NItdzaG1xWBT69Z/P2fR5ZJECRPDEoJxGaM60AewbkRzwOdF8X2PxcIsEScBekjLjDm6AfsTDbbic/iLWekouOViODYHWUVmR4RHILu4Lm+HbVb/Y95K0XMetSi16Ot0UhlpYgXUCmklS/1+5uDMGBVAPdqpNX30MGobch7Whg5/3wpy7KigB1MxG+nr7pQzRbr+dvU0vUrYav3plEYXWa+z6SWsdUruYkf2bdtNjMoYhgVAgk8xa/P/N/RHu3qKo7Ym8VmaI3/lsSKt+/S9opkK9iVXlN+m/2aySLLukc3HWjViVZBDmmVa/vZCPM7825H6fv4/dwoDQe47k1qDT2tHV35N9JtlJKVE3HIay7xRkuBSu2VWQzp9NAh0p2rSz0PAtCodVsWw68ZNqSNwpNMVfEhhSunz+8B6uTyGmhoRoW7enogBtWzugKkFVo0oc6/gMn/4dAzlFMLf4WGcZ6HI2o3CwuZDnh+/71mHHgS1goApdseBCDowHz8CP4A+5r3+bsMAYqdB2IVAe0tPJu06NjVbpLfp9Ih+rX/01q2I3TatifEftiCNZhQrCZBhIx9uRR+/Mh7ReHbhHpI1i4V7pwob0EW9DfWmUhxrIh8vpdbhFvxvtbf0FuWSzrEGtZbtmaCjS/0QSj9CfU6nhsxWYT8OkPm79wobVTrNjxoMp1y7qqiBDLoAvQ7SprKfk4huaqstYmdGSGK+HgbZvjOveF7ZbJeHRK3Jd5c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Z54EDerY4OBYiwzBsN7e8Ch8u2CrBQYLhKAPMPreAeJCogNgUI5JX5GMtfe?=
 =?us-ascii?Q?dYeZgxHor67CRDI2nS8edV7Kz+a5S0boMn+p3NSGPOOsiaJ3O+FyYSFlKq4Z?=
 =?us-ascii?Q?9EiKlj/Ydg0SGQGoTTi+6ZCs6OIkW67tco5yh5GxLLwjsoGG5S3SJFLwmtdE?=
 =?us-ascii?Q?+gbR8XW0Kbguc73JdLgjEuM8cZSNC7JPCPZckadoMhTRl3cCn6YIzJG+tEeW?=
 =?us-ascii?Q?6PdUYzpdRhFkEpGkAln8zPlBitnAe9lADw37W0DcX1EuiFW1a4xn7FpEs1Aa?=
 =?us-ascii?Q?TFq59mxxkOveP18CD1Eb1yKdIeFDsYX7lI5s5F7E5fUm55jQU8jtccb5TeDb?=
 =?us-ascii?Q?6cvzAYV9Fdv3pq2ofne0nKVgAD2jWwddlQgjQpUyr6pRfnREAIGZJUIitWmx?=
 =?us-ascii?Q?KkJwtzTrt88jcpWtNTRZAHIaZz4Op5ba2+RDAhqjUovqkJgqmn3hcys7JhAd?=
 =?us-ascii?Q?k/Fd27fb46MP3z7xESjxKdVSjd68ABrB6rkaseDjTJ3JkOSe66Y4EBgxaRAV?=
 =?us-ascii?Q?6ZWyjbSvjEl95+SnzHiqRGaXUm0qSsL7O+EseaCLvEtE+nuJ3CQIfIm3VZq2?=
 =?us-ascii?Q?mOQw0AfEKOrpifMADXaG1CwhSr2b/T9ExvpHqI7+unovjVafcfiilMzGuWiQ?=
 =?us-ascii?Q?KOHOEj3Uc7NplXI3spLqQXn5CSma3fE9QdbbcGgiM+/l+JkuJoKqPe77TUYz?=
 =?us-ascii?Q?dvWtx3D54PKGdQt36w0+604og22toqTQZx6U6NfUYayzz+aJmgJL/eBe0mrm?=
 =?us-ascii?Q?dvq/Luu0t6CQjVRsbRZnWOkCGzwa9YnVrOf9897cxzp5Zb6d0BLS5aGDkdcO?=
 =?us-ascii?Q?HCGr+KP1hQ9TNCUVQLYb1Wiy5ePaeR5gR3OW3glm653QUN1O0Da8qhD3/9ja?=
 =?us-ascii?Q?9fnc614cEQmKz/L3uFaUdNC/hXr8sCf46BLbj1ijBSnC0Yt2je7BHui6aqIy?=
 =?us-ascii?Q?HiGc1Em9YD/K4Zi7HBxfah+AJ8lGPFgNQrhG0FBlXsY94MzKjrkpRH1NY8Z1?=
 =?us-ascii?Q?6Ryy7h24gjgsadPmmc50g0t4QsvrXHBHJdTlOchxkChji0KlbHFxIbSlnDSt?=
 =?us-ascii?Q?c2e7L6NdOFQ50EQaurfdaDkdBNx+dqmMpT0LLJitLYqE7h+UH9arkPDCwO2T?=
 =?us-ascii?Q?zjaJmDUXQxUVdQQO3ACNPOFQAnkzLdpn/apKaFuD9JKaSj2v6KMtRG9xxvC9?=
 =?us-ascii?Q?5wmIRqV8bXnAUveSMy8GmJKoIGAs3yJxGCLaHExBnqFJB6k6YLI/lUvBrguc?=
 =?us-ascii?Q?m+a/1JgY5VAQ5tZ1TF+bQDDb9IXHtbh7OvTdN7P2Edv4W/6qfwWjSVYGS/rx?=
 =?us-ascii?Q?lFsW11k5EtfB+Pc9H1Q+qm2sxi6vwCHc//40qjtv1ize7oo/LTup02xbWbvg?=
 =?us-ascii?Q?ws1p3AYa8HHJq/FtDxhR9z60WBQwm4H6u+abilCYB9twL9V+QSjQUTI57uoX?=
 =?us-ascii?Q?MNg4frQbBjiJbEfdoHbkKp2ubIXKwdgq/dKB9rIyyXb+ulGsSt20MGToIc7J?=
 =?us-ascii?Q?NqaBpj4IIInN9POwJL1mpigUOwtO7XT1RcxAMJgSeyFSedspCqminUNakWgP?=
 =?us-ascii?Q?5m/4rWlXMbXot+1lPtQ8pWNatz/MmQB/AvFzarkq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f86023-27b5-4153-b19f-08dc5b02dfd3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 15:11:48.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XL9vkFf2pfly7USBV0CHBvpj6LV9yj5B/pSOpfkou+S/363YxoFCWNn4a+qW8T4FZeu0DucL0nHV859+jdm3dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7282

On Fri, Apr 12, 2024 at 08:29:26AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 SCMI Pinctrl uses OEM specific units, so add '$ref' to
> '/schemas/pinctrl/nxp,imx95-pinctrl.yaml' and an example.

where 'example'? 

Frank

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index e9d3f043c4ed..ebc6c083b538 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -249,9 +249,11 @@ properties:
>  
>    protocol@19:
>      type: object
> -    allOf:
> -      - $ref: '#/$defs/protocol-node'
> -      - $ref: /schemas/pinctrl/pinctrl.yaml
> +    anyOf:
> +      - $ref: /schemas/pinctrl/nxp,imx95-pinctrl.yaml
> +      - allOf:
> +          - $ref: '#/$defs/protocol-node'
> +          - $ref: /schemas/pinctrl/pinctrl.yaml
>  
>      unevaluatedProperties: false
>  
> 
> -- 
> 2.37.1
> 

