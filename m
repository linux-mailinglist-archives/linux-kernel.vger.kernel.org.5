Return-Path: <linux-kernel+bounces-135610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA8D89C87E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633F428735B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394AC1411FF;
	Mon,  8 Apr 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DtmRETFl"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2121.outbound.protection.outlook.com [40.107.13.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5D140E5F;
	Mon,  8 Apr 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590596; cv=fail; b=j2N+P37l4AuLFMVam/CLTWiTgq/JP2uVyUEZvNZCsqxnDrGR/UovZ91AfSVrwVK5mIbs08u4Ws2mLoThogw0no82Cw5XkK0WC/VqFbFMI1pknEXuJIGhqCj71Ae4FBGrXJyfQP1eP5JtfWlO1tztai5pik6MbMrss4DZ6cuL+i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590596; c=relaxed/simple;
	bh=+pvJNsEVv5dic8dbhPGsASjgERDdYBSKSQ0c+W4I6aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Idwn9l3MfZYXOm7pZt7sOQqhM46bfDa6p3ihfYDfX8OA9Th8GsQhorsek8m7IcmlzmDABTYtfAHBIEiZ+HmNOq0+WDs1+IiqriAswt77lgfvHWrFVYXubCFAGNiM/tNlYEKutfQw2vuDPzuREghty6XOpoPJQ0K5/pAfABmFFQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DtmRETFl; arc=fail smtp.client-ip=40.107.13.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWTbQWnLqeWOwxZk838KpUp5dsJnMBa4sxlc7mHevpV7a8p9aO5axI0OvTfinHIiDghvEMftfHa93D7xk1BzhZIUwo9R1T/YreGkVE7KBy43FVzIsNpaBns8tLDRblO7B6FaqqFM9BPmCDeC8FcVUQ8FFGmnqgpy4ycfAhyKCPIQnwg9Acs8ppRKOdm71gOIlHTajJjIOorU9lBLM0WFAUXzBTsaLv/s9kriQsnH4wwM7uE1Qi1TBHXVeyAM2O9ThYn4oxug0mj6m+ZifkI7izNy9mDcpAPSWtAiQAhE1yALrXcEiv9vZdFYmbXBt33w1RBKYJ5Xf9IQ5UBb4WBSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvofKPs+Nzzec8iqztWGgzOCdld9BpN35btzzHDnIso=;
 b=bd6UevkYwRvyq+fCXI1BBzEApEBus45DFFuEaO7Tm1ZRtCeD66iHiFU1Rg7C49yw3xu+KgDvrYh2ct0lbuoeF1pR0umxBDrgDtR65sRvyp+UDHvaKoPop6G/1ZTHF4VJoxfeKBJCF60U5oEN2HUXwty7Sd/tooFBEvspM92Vp9sy/4OEigOIIJHfYUEHvIfSTKMnjCt9g7kWuo9P6nf3lGtgIJz/hXzOYDWwfBh4i1vlRh7CMu8y+eQJNaO+p/z8xEcc90Ix4tfZLm1GiuTAXPg3VwV4vRTChYx+gmK+vrCntVLPgSq/ZrRqTquWC6BKlMEHk7Rynw/T1GoSSdBMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvofKPs+Nzzec8iqztWGgzOCdld9BpN35btzzHDnIso=;
 b=DtmRETFlX3KqJ4H5GBPAWMwtYYFyGoTJpX8+MLqrdzCGsGO/zwI63n124OsQpmznQo46PTcS2NSzkhFXbi9pz1as9iFQDSX0fu4Kqc+zMDjXKJxyJBTDTFwsPWb5VKMMdSYtixHrF6fAl6LFZ7+6hpxPNRRW/UVVLmpyfIlkuws=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Mon, 8 Apr
 2024 15:36:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 15:36:31 +0000
Date: Mon, 8 Apr 2024 11:36:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960/wm8962
 and sai[0,1,4,5]
Message-ID: <ZhQO979YpKA24pML@lizhi-Precision-Tower-5810>
References: <20240404161914.1655305-1-Frank.Li@nxp.com>
 <efc9c624-6a31-4299-a604-8aad1d0cd878@linaro.org>
 <ZhAO4YWuB8r8k+m8@lizhi-Precision-Tower-5810>
 <938489b1-eb94-4f8a-8881-230951299f6a@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <938489b1-eb94-4f8a-8881-230951299f6a@linaro.org>
X-ClientProxiedBy: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10309:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/4a5p6UQSY2kdeCqUy0yJTHNg9xtOxQ/f79TMe0TJ3jFGOxiKfnKVxPzwXUwpAIgUuIOTXLxE+YFVZZKV5cflJOzawDWySvqJ/SB+OOW+24CyDSwEUb8jRsVCI31R18xl+armwDGAYScfPICYdl7Hb4VYJ1CWx5tlNuy0dB/8Gj14xRi2580AV4i1kNzBvYRXeqdZR4G8fFYu2SgA662WmCtQ8AlMusojNsQ9tkGu+7BSdCzVrJvm1c0x1iUyFgQX2Qtj/yvqhoWK9MiOSkjN0E/imrMLOOM+ATRGcRzMt1ZsVX67ZokyFJXpOq5V4oTSRw0fHON/Vm2agKbmj14x+SI7ZQ+bQ+qFqvhOuYq+qBqoWupipn0gHige3SVqVcbEeUAjDTVaypRyHae9UPgGjbzD6F3uAvMrm5IyqtNitXV1VYWbPI8jblAU2bwLgIfxRmQDgu5LJy1gkxVwTWwRSPLa87ygilXjN4k2WJqLAvVHvzN5gwy6o5OwtrLrUwTZQEG/7PQ8E3NQ7t92VviKMKFM7CY5ySMKq1i5AHjFAlnFhKrhQZA3plNn2g/Hbe3G94OKxX83Cpbo+O52ZfuN3rCHWaTAzjBCIzwqmAw9eR7zKC8m2wMyduIUygIJ2/jAEftPqy1mkQ5pBs96uEF9QGDOo/qVy1bS9GxPwQEaYQgsmDG5iBUvVOTZCNW7xr5VcKE42u6f4T2APSLfcavqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6+PfjW63+XexsMoRZA2802C3Gi2mHvRSoCIIlSPQUEpTzO9QJbjKHeI5rrfu?=
 =?us-ascii?Q?BDWv8HVRlP2ePL+EP5LlCoA/fQYx215DNbPkt8Q4yvHaLcP+3GGoYoozgWl+?=
 =?us-ascii?Q?j85uVRcbLNysdKeh2bR3Yht27FSx7bOtjcKIdN3hDkd/CtxK4+rcOHAChicY?=
 =?us-ascii?Q?7vyyK9Gw8UplM64K1zvi3ftoWkPV8F7V0lrzIetGeem+jV92/h8wkMJd/poD?=
 =?us-ascii?Q?xXOsL64TJORDRY/y3bl3NbfGvX2ogEI758IFaahIuQbHWyd+V5Nsy7eLNrIe?=
 =?us-ascii?Q?xceqE+II6gBdiLBAXQSFIO1IK3iItEoAhtR2GVSqJ8dYoiSrLeGywFeJGKYC?=
 =?us-ascii?Q?BBDzJwTDXhRNe0p19CKZnVxKC9rmTTWKwP4K5Q6z0QZJBQ48mxFhFWGaqTs6?=
 =?us-ascii?Q?5beYjpS+nMOI5xIR1+Fq+XSUc8knBE1MAArguUJejSraN4hBKu7xRUxoAR7A?=
 =?us-ascii?Q?wnDwUL8CPZU9m4vAQrJDuPhihD/75VD2QDe2/l4ceUIcIyF/U2n5aRIQID3V?=
 =?us-ascii?Q?V8oUyhKD8sUNs98rur4uyunA0YZzpXcWYJC6ZxxTe60pQyRCncvYRDoqD0dc?=
 =?us-ascii?Q?mtwZJWNKk78Kl1pJWexh2/eFMcnVpKeM/UbgtqIiJbqJTwvW9p9VznjiVZhG?=
 =?us-ascii?Q?CiXJ8Vh8DmiVwg4ZPd7eMMFVcwLsZNNAtvDu+9vX0YUmzaR0aFQYTDnfT+6g?=
 =?us-ascii?Q?6HkNF7YpopAKNW/5h/sZC3CZgzW1nt6D5U3N5P5vpkIRrEVSudWwh1OK8l6Q?=
 =?us-ascii?Q?VvurWRaDJ2SBOLWHplp+35zYh8SmuEmXKOsyeCSaHr3zEQV8wX5ltJ3o/pxW?=
 =?us-ascii?Q?/AIwWO5HFjBvyTDfpLIAnwSMqslqCsPymss57juSBnWgZKT+p4KVG/OqJWaE?=
 =?us-ascii?Q?6kAEwYKXBWIWYasr1sgInv90URuC1WGqCd7lxRr4PxDTAPybuztt1cygc34o?=
 =?us-ascii?Q?x6lcuqQIWWHJWvbCiXA179dqyeHEM4gd8IIRhf3BNBLrXtQfYnO9y//K3XjD?=
 =?us-ascii?Q?AvZ4x9D/lG3+08bFUHJmZ+9fUMoqH5JwZSxwVmj0iEXXFOLAClcrPMSVGzHV?=
 =?us-ascii?Q?EkV8DJQ+bq2sCwV9U/blf/OIq0hfcosl5ZYzzKVOzbP+24iOwG10ENJkr2Cu?=
 =?us-ascii?Q?pf+oY7fwwYSUGZUNBYzVFYWGQeLDKwq92gpU1HWhMxIvIZuwnqkAB1fkMxj/?=
 =?us-ascii?Q?SXLZCWedc7p49TZjK9rT0oq6kIZb5vIm5KPor5+BfXzkmD3NPs4Z441aa7+e?=
 =?us-ascii?Q?SRGdMnIl6P65cddbkTwFcHPbv2mSX23m3/IqW8wZbRtk0O3aw/q4lNBKekM8?=
 =?us-ascii?Q?vQ/bpdGNWjayAz+RjmqLY53RR80UDd5c1ndDoy+hy4hFr6hbn/bejw43oeym?=
 =?us-ascii?Q?9KGdqboWzQbKs5mGvz+pG0RiS3/xQiPuiPMeIfrX8ogILOpR6bvpWLcZ2TaP?=
 =?us-ascii?Q?iFj5PfHCZIKzz74HpsBFizSvSosTralpkolxO6nlSLEP/poRQKfnkHYoQ517?=
 =?us-ascii?Q?0GkBvTiOk+P6gPVcMviG4pSZw7xDvjipQ1Ym0y+iT3fPhGsg7YHhFvOma9+Q?=
 =?us-ascii?Q?1Lce14a5jfZEi/9dpRg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85139a6a-fd0e-43ed-187d-08dc57e1a9fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 15:36:31.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AwwfKRqFTHtDDW0ZCbRJiIWgq7/ZYmh+QC2Ql6KFTOc84x3i2RhXvXJtz1NqTmB2ElqnwEhL7yKX5q0DOjiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309

On Fri, Apr 05, 2024 at 08:21:18PM +0200, Krzysztof Kozlowski wrote:
> On 05/04/2024 16:46, Frank Li wrote:
> > On Fri, Apr 05, 2024 at 08:41:59AM +0200, Krzysztof Kozlowski wrote:
> >> On 04/04/2024 18:19, Frank Li wrote:
> >>> imx8qxp-mek use two kind audio codec, wm8960 and wm8962. Using dummy gpio
> >>> i2c bus mux to connect both i2c devices. One will probe failure and other
> >>> will probe success when devices driver check whoami. So one dtb can cover
> >>> both board configuration.
> >>
> >> I don't understand it. Either you add real device or not. If one board
> >> has two devices, then why do you need to check for failures?
> >>
> >> Anyway, don't add fake stuff to DTS.
> > 
> > NAK can't resolve the problem. It should be common problem for long time
> > cycle boards. Some chipes will be out life cycle. such as some sensor. So
> > chips on boards have been replace by some pin to pin compatible sensor. For
> > example: 
> > 	old boards: use sensor A with address 0x1a
> > 	new bench: use sensor B with address 0x1b.
> > 
> > You can treat it as two kind boards, RevA or RevB. But most user want to
> > use one dtb to handle such small differences. For this case, it should be
> > simple. Just add a super set.
> > 	i2c
> > 	{
> > 		sensorA@1a
> > 		{
> > 		}
> > 		sensorB@1b
> > 		{
> > 		}	
> > 	}
> > 
> > It also depend on whoami check by i2c devices. Only A or B will probe.
> > 
> > wm8960 and wm8962 are more complex example.  wm8960 is out of life. But
> > wm8962 and wm8960 have the same i2c address. The current i2c frame can't
> > allow the same i2c address in one i2c bus.
> > 
> > You are feel to NAK my method, but I hope you also provide constructive
> > solution to help resolve the problem.
> 
> Yes, we resolved it long time ago. Your bootloader can (usually easily)
> detect revision of the board and load appropriate DTS or DTS+DTSO.

I knewn it. But the problem is one development boards A have many options,
so create many child dts for files, A1, A2, ... An which base on A

If there are difference happen at A, create new B. then create all child
dtb, B1, B2, ... Bn.  DTB number will increase exponent.

If change is quite bit, we have to do that. But if change is quite small,
One dtb can cover it by driver auto detect, which will work like some
adaptor card have not plug into boards, or some sensor or NOR-flash have
not installed because reduce cost.
  
Although boot loader can update dts or choose difference dts, It also cause
many confusition, such as layerscape, uboot update many kernel dtb's
information, which actually increase dependence between uboot and kernel.
Also it confuse people, for example,  when try to debug kernel dtb, why
change have not token affect when change dts because not realized uboot
over write it.

What's I dide is that trying to reduce unnecessary dts.

Frank

> 
> Best regards,
> Krzysztof
> 

