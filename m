Return-Path: <linux-kernel+bounces-139906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042998A0904
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4281F21FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DD113DDA6;
	Thu, 11 Apr 2024 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="ZmWzbjoX"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2135.outbound.protection.outlook.com [40.107.243.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603E013CA96;
	Thu, 11 Apr 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818844; cv=fail; b=bQ68axAxcvw13oUOE+VBMuhblw9WdLATu1UTTZRoo4wzcRXF7/9LNKRmophBGqaNyqZ0kcuyT8ll97ElGNRMUf5OdTDkKk1t/DxtYG2i6G+JPQcbjYQHfXVdr62Je5bb/ybDiQRnjrs2NaDvfVo6WJBDGaNqhXYoFq36Sq10TBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818844; c=relaxed/simple;
	bh=IP4SR54bvNdzQyXpJ8GXI86oWAHZQRBBkn/53EmpClc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WvoIOprQa6HdBlFadLFDfKEMJKzJme1WasIqYn1LaXz/6XHKGrM7y4cJvk6uWQ1tc8+t4M9h4Ux0K1xr+dRuvu5r1TntlvNaoBQdU6ec00DtdOnT0IwlNqsLCe+6dJJgGhwSoLGys862cc1KR38YbzRFIiWeYlzGsoqP4+uRx1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=fail (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=ZmWzbjoX reason="signature verification failed"; arc=fail smtp.client-ip=40.107.243.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/YVEPtydnuC2VI+UDetepJi2gRu9b+L/XmBd3x/5/aowoYUk8MDT0ZFRDmvD6DtN16q4AeARrZYnn6TbAXYSOcx4X1Oiquf6mpFZZSO5m34tYAwOMAAT7Rt5+ARPwcCDb8URUWa2zH2WSyDkeMpoKJqNKtQQiH9bYoi5FiTcYFwm38cpSl5U6fPnACqeCdyABay+Z2By4qtWACnZAFe7ImgAaQJ0wCW0xCFIYeqI1JNUNZnkR1EJKhAYKWEgiLcjekfnbY1ViTjNZ/XsjW0DbcSqzYo/1WJqIVgIX7yUj+GvUFCCeiBxWX14KTpRu1a5FcBGwiTm610DTScGrpzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OG6MLZJ67GAftDRIGxhLIz4YIqfVM7HU+TiQhveiag=;
 b=AT+Na4g0ul8wWh2V3ZjDkJmd1Rsg4S3MfifzlMf7ml7B2eOfo8wKxiD9XqaF+J5K0+I1zWEHvK3au/34i1C4VvDY7i7dVq2J4V7C62e8hENNm+Uhk3WeC6L/gN0uq2F5izlZk8r8TGIdAjQZiYyiWA3905DUlSslS49DYLBNtF24Hvs07tLIf7Utmh6uCUW60GFaNAd2y+CLOKNUwDRw9PoVqzfW9KoLLb57DJiL/t2OcyfZHwl1FgVxqkVgOOFb5XSxOYyD+ZTR2TGbE+qPh7elchZ60tWS1BPLS75xgeERAeEk+dy+GQ3Y3Ck3HBKKJt1zlBtf8xauvV+YrfIS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OG6MLZJ67GAftDRIGxhLIz4YIqfVM7HU+TiQhveiag=;
 b=ZmWzbjoXKokgHXu2L/56UCgwg6N0qe8qpL0mq34pA9cb6ozMalW9TuyBS7llo+KYSgiGOf9Qju4Qqma/uHETCOpA5go62A6B7ikUproqY7LdSYr8i/kRLfDoLgWKmyKmmKqt4jsXPhku3NGPpi59NJz56J4QZb0RR/HMsY7Okt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DS7PR13MB4589.namprd13.prod.outlook.com (2603:10b6:5:3a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 07:00:39 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%6]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 07:00:38 +0000
Date: Thu, 11 Apr 2024 08:59:25 +0200
From: Louis Peens <louis.peens@corigine.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com, Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v2 2/4] nfp: flower: fix check for unsupported
 control flags
Message-ID: <ZheKTadCKyX23U0k@LouisNoVo>
References: <20240410093235.5334-1-ast@fiberby.net>
 <20240410093235.5334-3-ast@fiberby.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410093235.5334-3-ast@fiberby.net>
X-ClientProxiedBy: JNXP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::21)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DS7PR13MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 1933afc1-5eff-4b45-7363-08dc59f51806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8zk0LPIiO1MTc/YdpTkAf6qxcvu7yb7Lc4OHcp/nEq8YyMw+m2dZaLy0E1TVCcgJH2NDCJsuqrlANz15f+ZW/cDYjrUQKUkJ42Bl57PvQkOHEapyitPB62eSYLX2r2K/y9fz2QHQdOitXGeu/hIkJ5GrBthDJlFF1PvBAPeMU91zU/X/Fjkeoz0ONPM9b47nTDqDY5cXQB4Vs7kqkEHKsZ748G4WXu/o2+PWp6EPMZGo3zGgKNS53kR0U9+DF0wWRuq2621WQ6JelXH0tFY37DZGLAlGy0YWDJqq+eYe63GhX+PfVce3KlrkA3bTdcvbdj0vtCA46aTwJnTukTOL5QYAAzbF9Pw5TdgZYcRyLtFzTgaL4ZSbXFNeuXBkklVYF1V5kGDpK6vtWmeDPeqrYFJPJOE++KMihe/zVr5UUrG+h3gW000nv/uP2rTHOztZWUf+JG2N76mp5LZCtkjqm8XvGESlSoVn5az1VzzaTmFVTcKKXTp6mbGel2xRnURWUq2HZbFUHTxJnXZ9d/ZPz8QyX+5txtDH2ZXkN2QQfNnVI1q0axZh6qG4xoOBFM/E/zlj1vUeSsD0VVLFwWvKPJ+N/p6YLyHPxUjobWszXorn8aBKnVUogAxLh/zpqXLmS2LK96QRKtHpBEXgICuF54afXNNnfyMtfvfAu7juVbU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wtQ7o+plg3PGrhAtJ6eqCfVQcTRdUTEyhszFVwzGy4UwptVQ0uhYszM0xX?=
 =?iso-8859-1?Q?IgMHS6WDqHoL07eXUppzvEbonwsheCOcg2RExWjERuC04Kie47YrvoJVnF?=
 =?iso-8859-1?Q?8O8szglxywxg1g7UEDji/RLV4SeuyqJP7juSjIn9vjgC4nkV15yeBADrTf?=
 =?iso-8859-1?Q?wEQ4pW5HAV5X63Hzq7egARxh77QgrJn9eEUtSO7QjethDqaL6yCHKuM11R?=
 =?iso-8859-1?Q?gjKLxxx6gOcKQ2ek0vYykKd1wzwMA5320pBrLAqFBFIysygPq9/DQDIJ4H?=
 =?iso-8859-1?Q?yyJR0II0OKcmNM0zx8E0Im6+y12RAplEqY6ETyRAV3cs8vjVlz8AP3UxLW?=
 =?iso-8859-1?Q?CFgByL3sROcI2Hl6MBqenWdr+KPi6AJp7rYhVLN7EENQmjZsjKSz3KLUdm?=
 =?iso-8859-1?Q?9MfdhrBKiIp+mJXwosfHNpcckE1oYI2KoMnkKh+qjwZ4bdIW7B7RCWxtw5?=
 =?iso-8859-1?Q?nyxrxsEOYAsR/QCM0xHKgF/TIAqIf4p43OZ3mz54z3U3A8puv5r1IIsg8h?=
 =?iso-8859-1?Q?hpzAV/eSueUtqvlKLAQY1XRuhkt9Qg+U+Gb9TuFZ/w97bSzqqB60RA4Kn6?=
 =?iso-8859-1?Q?P0pOcsLRHCzOfz7RY1P1RJoUjF6taeL5hx/buWvYTHA6haTdn/J6qL9iYE?=
 =?iso-8859-1?Q?rDAdL6Yuxs5luFq3zqUyvxTNymkCyXPnvGdjLh7jIwdIFawVOpgeEMftcD?=
 =?iso-8859-1?Q?+TyAXJy754PX2fOBulYu9pNqxNigj+SASwRSr/OkEXnr9CN5d5q3CbJNrV?=
 =?iso-8859-1?Q?DPRY583I6DgTJwQ0UrqIwCZ8wKd6BavHm9u5IbwcCAJNOLc+1zlleCBwRO?=
 =?iso-8859-1?Q?28yRrrRWKd5k4tyu2AJxOR0zNqIA7o7KZIBozLPnRwSj5ZqxVVr+WxFlBH?=
 =?iso-8859-1?Q?QgbMjrQwA/Ew03l1bccfix/ogIeetYQVsJauRJ9P5esjI4uwbtigboojKJ?=
 =?iso-8859-1?Q?D88WOPXqKuRWfSLo4ji5TurEFM75seYcLnI3KwJTwZcEnTiqT+Gsn0fX5I?=
 =?iso-8859-1?Q?kCgs0aNRTadoqX+vIwmWeXWrLxmWSx4AkSxruQ1aJLbkqEGhTxV2kTxM/n?=
 =?iso-8859-1?Q?039R4nbUe4Web9UXBnvNu7FLrPnvUocY6WC7huLO52h68WFsQmttINk7L0?=
 =?iso-8859-1?Q?ftvRI0bgFRLRi1q9yFbEJRLyfYYVhMKUOt40PT/UQo0DSeGeQkToCe/svb?=
 =?iso-8859-1?Q?06E0Ti6agjLr0RMBbVhF3HKILH1kidkYzDJEkrK5qLdv6BIGFmQ8LqosfU?=
 =?iso-8859-1?Q?OIXboVbXIjW03CbAKi9btpTWhKzuBUoaXkXVDJ1BbIdSsPsp1Efl6p/knb?=
 =?iso-8859-1?Q?JXqpa0it26C7Ewh9BEgy0W0ujrci6C+/WOWpsZKHANv3TFXo6JqbcgYwOE?=
 =?iso-8859-1?Q?M2Wskah9rTC9xCr+l5M7KrZCCNFYkzZ1ay1oHIyRymHydX+M7pOtlv81u/?=
 =?iso-8859-1?Q?7uFkniWJeNcZiYtl5ODOSMdOO05AIbGlFsiCbseUKdtC1awGaaLyohzrTe?=
 =?iso-8859-1?Q?Ne80jBtXpH1HK/hlW02Lp+QPcHuVVUs2E1rtLU8DsvKiRfgQ6CdageCffZ?=
 =?iso-8859-1?Q?s9BITTtHkoOD3GudA1NRreb0MGNBXdt5acaQzYergauDY3NDPj12vMjoLg?=
 =?iso-8859-1?Q?m9AL2iPBK30yrJ/dFTMojX78f4aQIoUM0ljdFaeNO5Zp025bLjPVBSIQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1933afc1-5eff-4b45-7363-08dc59f51806
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 07:00:38.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRNOz5qkj8hfEnHtJ5qk3OXk23/3Et4JF4Z/cDy789NNFnE8i9VNiMhhBk8Jwq9NWIfgaKd1hKjzaibG1dSzg8kUDoCD6fXkceR5NaSD3UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4589

On Wed, Apr 10, 2024 at 09:32:23AM +0000, Asbjørn Sloth Tønnesen wrote:
> Use flow_rule_is_supp_control_flags()
> 
> Check the mask, not the key, for unsupported control flags.
> 
> Only compile-tested, no access to HW
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  drivers/net/ethernet/netronome/nfp/flower/offload.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks for updating:
Reviewed-by: Louis Peens <louis.peens@corigine.com>

