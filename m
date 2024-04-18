Return-Path: <linux-kernel+bounces-150793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B958AA49E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5FD1C22A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C42A19068F;
	Thu, 18 Apr 2024 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ldc9vV1e"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C8194C6A;
	Thu, 18 Apr 2024 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474515; cv=fail; b=IrbszbeUzylo2M0sI6ZqQvjjmumC8S8cHK6bpkRhzTPUiiclWzIoM84mZMop1Js1nLBDPV75/60R8Z+N9zg62Q7nYf/xjsj0hRqxlh4AKEwtTdqMRPn4QvXa/I8KvabQWOS5RgizKXhmO1OHsKmsulaKN4fNXCtxjsluiCoA2Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474515; c=relaxed/simple;
	bh=THPOI2X0JHbJrd1+6+X7x0GIh27IDP1/73OZTagUPLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hB92rwKOQ/UUzJtFt8jel5MRLKbCdTBTgRKy7erRQSqeIGmgl15SuVIhydshUodmchUHNmG82zaWKdee9lbu9EX6j7JtfVEol4Q+bbXSvr1knGD0NsqeOv1zsE0TWu3GWTs9Prc0RazIfnjvovW2MlP9Rj4wp0gb//QUDIYd+No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ldc9vV1e; arc=fail smtp.client-ip=40.107.104.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJcBOkGjIgO9fIbstPk9SscZEWeE6gwp+pEhB+mFxRlFtwyO+2jJvrs383C/NZBaBg0yLecuNNdIjpj7e2RSAxHfXegL+r0+FhKVqtj2lHaIM5rK69xQwKGVmpQ/gKPg2ShNTVNoB8dmIgZjMlbCaIlI9M6IojEoNwQtbbVwEjzK3mx9VxEnIwKRuRwOXAMtEpiSyQJJqNGM6z42gfNvSTQqnwQMP8BlEfEs4icAsobCpFeOo/6WYei37IoEuGy62w1BqaTNZLAxi1nkht2IFmkwe7GIQyWd1bYuYOyXBD7ES6hmun8hx1RTSVROpiqzDJMMFRdeU9lWpZah1nc5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouCBZyrIAcHp8FM8vBHyBWMzvwMmpG+f6YJ7shwQ1Pw=;
 b=bg6R99uOH7I/jYFqjyh9vc/SK4bgFbnwCxtflzp+ockw7S9yHczKWGFlNGhpoCSNFkvtB93YDb7E4gPJupf3AB8Ga5vRE1CkJswKsOl8KDkPFTkUIEXIkA90zXcdrfnwBJVrBuuNXD5+yKV5l+jm5CWCYikWV89TtMDNfudT/jDiKoiRMH3M1zoDnkjPDaCBggeFAD+3WZluHFalg/tBxstGP91V1JVIb8crCRvATTBfKmxUrLNmyifvMMhMAmbZTDtJ9U4QSx/TfBUfDlVWybolwR86aektsV+EkV+xtnFhPq/FTeiIsOJqYj2NeND5B8rCClt6ngPDNYl8t9LLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouCBZyrIAcHp8FM8vBHyBWMzvwMmpG+f6YJ7shwQ1Pw=;
 b=ldc9vV1eDxUOr+7wd/64ZB6UfQqlNE/fw3IDdtd5gGXN1yRtavGQuMWumpl6o1lUnmOxYuey6we81y2JBGLBaj5vsipxG+UkzcLaKdkp3DEUBDxOjYJb3mircVrE5BjZSH/7pkKozVDwVHIs85e06TFTohH6mRoKsFBzb63EtsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Thu, 18 Apr
 2024 21:08:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 21:08:29 +0000
Date: Thu, 18 Apr 2024 17:08:20 -0400
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
Subject: Re: [PATCH 1/3] dt-bindings: dsp: support imx8ulp dsp clocks
Message-ID: <ZiGLxBa8CMsaRSTc@lizhi-Precision-Tower-5810>
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
 <20240418203720.8492-2-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418203720.8492-2-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 39414b12-3fc9-4aa0-42c0-08dc5febb265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Hzc1Q5oFZfG93dYHIi/QCAkbrf2L/7DdgAwOR9TY3247ZZ3B2XowjuGst0yNy/XcfwVFjwK6aVnsq77a1O9Ft38HQFimQOROakmyvC5eergPpHXr2W7PoK8cafe7dxiLxg5lKnYFxmOPkToGJ/hVYL8/ieedAiI7UnYpO/vWw7qS/Dt3LoLbBiHK5tpUyNtlUWUJ89vPmbnhjCBbh8pzv8obqnqBvN5TT/Gi/rLOxLRssRDPdNaNhrkUaKmSoiXSLhpEU6+XCFDI/nJfPb1BQSPcg17HBliX2x2LqqMFz5pG0WkrxP6qwyoGXcUmKbnBKr4W2pluvzm4G8fSmKrEna9BGcW8duq3577svsJ466VJHG8Sn6pES0x0DpqeNsYyy7Ta90yqT9fZAvAsnoI0nSpjpNjCqvBn3QZXlIBSXR4PlkBFQNabXenzHE7UbudpRP66+yIAE+sYiKXsC3kzXJGN0MQIdwYJrLrSkSwR1ysDp5fJo58aVW80FCJ0WHmWYX+wmH/TTL8npixfATeM88D/pS14izuTOa8+xEyUMj1Ow10g9UAAl2ndo7p2xii7lAIK+ToWRyfi8kotLNs2T1Gwo24phqkOi5Hjzxo6XPSoo20GgBnzSAq6MkdMMDWAlxXU3aGjRruKATBujzTlkwQ+DD7Ex3NKerFX9Wwrl56NgtZv4jGUZxT9jna051XVEEWRuF7bLNT20WtzHgipVeV2lz5E6+9IfE776Ma2pg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6kaikUrqYMMDIbuLdyvX5SxETWxzfaVL8J2JS34lOfTUldC3S4tGHm/1mjjw?=
 =?us-ascii?Q?0XHZkSG8ybhsKt3EPTGZyg/e5D7jRgvx0kYqPUuwZJ7cqnlePMbbclDlkqM8?=
 =?us-ascii?Q?uiOht5WBDsBOyb2iZI8lUdp1C/IZUEA0FDDUVYSOIeIweT6rGYaI0U7lFl4Z?=
 =?us-ascii?Q?C7US7qwGiGT7IyukDl+V5SbpiYCkn0YKN9LjS7K9+Tn4EUzEHINj+/ZbzGez?=
 =?us-ascii?Q?9Nr/mV1vNn5O7YmjW5goZ7QVqCOUk0bsaCng8pLdYXol7+yVJoKlNSCPSgvt?=
 =?us-ascii?Q?b6NfnTyGbi9taQNGPu/+tyzMqya2ZdoF/rla/OsI5jdco+95EEzKm4fYZmoa?=
 =?us-ascii?Q?ZTkOU64szGvY9uzkKDTZMpzSXGnMJqj9Jw82Yc0iSCDwaZ4tsR82xODWoJ5M?=
 =?us-ascii?Q?WsTcOvXejiS6n8EuNWOaBgqj++pqCv0o6nBqiYmTd9YYGTjMiAFNRNdFZH9k?=
 =?us-ascii?Q?aoYOqwxz89fY1KIfe1vXOb2IiggSEdLSbfa32p6N+QKHaUD60Jl8HJqbhoq1?=
 =?us-ascii?Q?7g0BrTfXRzKZt18DBFTlK9ngxIoLe3bWDEDu/N8oMRtblPfAvGD8EmsA/Wja?=
 =?us-ascii?Q?akYQWc5BEd28uh1WUDZ9DAIAIgEVpgiSMYvtmDXH1JaRztLck/0TsTeFuJWH?=
 =?us-ascii?Q?vPycXjuCcgcJDvhiSM5HgQteoWZa0mR9M/U86FJe4h9oZqXsJuoU3ZUgRc7v?=
 =?us-ascii?Q?nk5DE7YVp7/HX9MT04hk3y+kHP7z1F4aAYhI7PbPBqsxWXm5Hvog1rLssAPe?=
 =?us-ascii?Q?9hcdMDIB4mQM6dNatSmkThRdOMTYed5XMh6Aj5Zoj3cf9OkYvzTk+F37q01C?=
 =?us-ascii?Q?YsEPdYMm6tiP2SuWhbHHwthtnv9ndE/kQHDu1bFyZC9yNFePt8vx9rGxcoxB?=
 =?us-ascii?Q?hFnwlOgu27NtPxbI41kQ1eEQvdoTZ4NpgKQ+UTurujGJoKtn6aSi8lNwe5ah?=
 =?us-ascii?Q?hD7m86WrJIp/GMOIKn3i/z5LtozkqmGwMLZUwQvrPlWDhcj6B06v2fm4whYW?=
 =?us-ascii?Q?EaErQgTDa522YzKFqvUoMi2EWQpZ54D7ECJGo7WMIxjUsLl+eRfZFSCTUU4I?=
 =?us-ascii?Q?SLMKcAnPAEbW7cfVn+gV/KgnUuzykCKsLZzUYAtGBOXYHr6qtPpGg+yK/3nZ?=
 =?us-ascii?Q?mxRPi1VETupdMsMulnsjJAdamw/+TURp9QV0EinwgIYCvmsuvLxcUD372ZnI?=
 =?us-ascii?Q?bT8QDyi2T+cy4w48avTEXqHJlEvohTgvy84Zyt8wAMK54UVJEUbS8tjNu9D9?=
 =?us-ascii?Q?2qYgl+1d2F1k9mm82Uky6h9g6D+yDdqQOpmDILfLb1QJT+I7QLghnUwoVbNn?=
 =?us-ascii?Q?ewuIwMzkItQfwWMYjh4dkmlxxkUQcouVOSpLrdEE7duRCuMkEryetWmpS4zj?=
 =?us-ascii?Q?17LmgjK/JTqUu8H8TVDnxD5WSy6P5phgPeNUvx4sv+yx2SlOkbeUXQEHQArC?=
 =?us-ascii?Q?gGNYdiIS/esQO2/ya+Cy+OZFT1eLeiMITUcI89VxlCWGNcJgyabyRADtxOYx?=
 =?us-ascii?Q?yo4RQVbMvRW7V/yYiFeRrD9Jorpo0BiAWgdUmt+9gHwlzMk6GgHKK2BojQlt?=
 =?us-ascii?Q?JPARDTwwfMBJYYCBkJhU+tCe31AeIWPjYr8eM6IF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39414b12-3fc9-4aa0-42c0-08dc5febb265
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 21:08:29.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5veAqGTfQY3aV8rXoFRyXsa4nlKhdB8NTpWjEyKjEwrB+wnE2FBLD4o0gsNO+sU9na8lR6/WUb3Fof6yj71JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

On Thu, Apr 18, 2024 at 11:37:18PM +0300, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> i.MX8ULP DSP node needs a MU clock, but doesn't need
> a debug clock. Change "clocks" and "clock-names" properties
> to allow for this case.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 51 ++++++++++++++-----
>  1 file changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> index 9af40da5688e..4a39d57b1cc6 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -30,22 +30,12 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    items:
> -      - description: ipg clock
> -      - description: ocram clock
> -      - description: core clock
> -      - description: debug interface clock
> -      - description: message unit clock
>      minItems: 3
> +    maxItems: 5
>  
>    clock-names:
> -    items:
> -      - const: ipg
> -      - const: ocram
> -      - const: core
> -      - const: debug
> -      - const: mu
>      minItems: 3
> +    maxItems: 5
>  
>    power-domains:
>      description:
> @@ -93,6 +83,43 @@ required:
>    - memory-region
>  
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8ulp-hifi4
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: ipg clock
> +            - description: ocram clock
> +            - description: core clock
> +            - description: message unit clock
> +        clock-names:
> +          items:
> +            - const: ipg
> +            - const: ocram
> +            - const: core
> +            - const: mu
> +    else:
> +      properties:
> +        clocks:
> +          items:
> +            - description: ipg clock
> +            - description: ocram clock
> +            - description: core clock
> +            - description: debug interface clock
> +            - description: message unit clock
> +          minItems: 3
> +        clock-names:
> +          items:
> +            - const: ipg
> +            - const: ocram
> +            - const: core
> +            - const: debug
> +            - const: mu
> +          minItems: 3

According to your descript, look like only clk "debug" is difference.

How about

  clocks:                                                               
    items:                                                              
      - description: ipg clock                                          
      - description: ocram clock                                        
      - description: core clock                                         
      - description: message unit clock                                 
      - description: debug interface clock

   clock-names:                                                          
      items:                                                              
        - const: ipg                                                      
        - const: ocram                                                    
        - const: core
	- const: mu                                                     
        - const: debug                                                    

allOf:
   if:                                                                 
     properties:                                                       
       compatible:                                                     
          contains:                                                     
            const: fsl,imx8ulp-hifi4
   then:
     properties:
       clocks:
         minItems: 4
       clock-names:
         minItems: 4

   else:
     propertyies:
       clocks:
         minItems: 3
       clock-names:
         minItems: 3



>    - if:
>        properties:
>          compatible:
> -- 
> 2.34.1
> 

