Return-Path: <linux-kernel+bounces-36130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821FF839C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00621F2A3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4D4F60D;
	Tue, 23 Jan 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CKRQAwtB"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028264F1F2;
	Tue, 23 Jan 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048646; cv=fail; b=caVycMed+f9VxuHn51abnJwIQAjiIjFHZzLmxwpC/cJvkBNjHaxZFMxlU4411nQXI2avnFrNmOR1i6GV1fluWu8H6ZbP7f4M8Az1RyZ1OpAHNpyseFb5DWrYiuK5gFW61n0WojlfGQlqCvcqbXbbeKJwqgji0PjDonYSBMqEVVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048646; c=relaxed/simple;
	bh=no2gjZjJu1d3dpOrt5PRQJudF0lA03xQZEGYHPfcXvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JcqaPKZPVdnxuI3cRytRz6e2LcKvnR8DDlgoLEWEczToR/1oReRv4XJwagkY2ML3bAY0m7N+zDtihNTjwPWoFxWBta2dekY5Lh/RsFFXjSN9KchVQMnKMhzeD5VSf9xqVhiWxMSiPJNbF7GZ3ODEQzX791T5XuzCI/L1VssxcoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CKRQAwtB; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7flobSQHjKIRAzJwVJva27Ep1pXYiuoVDFs+T/UXjfQ+8wdoPyD5EFs1I6kgOCBUwjytuck3s/YdgSkFwL8sfXdk3yQOmrR2xUck5HO5R5gl/wzyWV1isz238d0Z30fZk7LZi6Pso3ZpE7825czshC49FU+BvtTQHrkDv9+WZW1+9oMCnxWL3kBG/7oSKEYh/u1g+3L40uEPzmEso0cFqSwR9IQ2f8vYuT6ftPF968Dnp1WJlIZ5U4pW949KHQ01Yfb2A+eqCBBQgPxj3OYWROId5i6hnWhtUqIQLKhUkKRWkLKUqGZO+8pmZc7vaZwKlmIvMKyQmkwv1dc2a/v3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kpuwnUUm1SC2AriM+yHwMGsoXP10yGphqlVCWvE5mk=;
 b=Kj1pB8QgMH1+bdfp7W33XuizYy8UeO6jj5npZMtrU1LmhdtTMg0vzY5DQNwqyTLf/q9ltcoDN0AY4/G9WpcV3UtZSQ5qq3oIHYohJ55u+q4wIEkv+eE8oQDbQKd1n2YzgAXtOApBQL6FP1IFFXixOHtBlqZP2zBwkPs9Goc22Erzci+9xryFQioaMiI652ybExc73rQDMh99DC+0vxIyHPUmJwme9xuB/+Zbuh6WpJ+IL8NVNGapEhfAbvzvBtGPETcUHO+Sw97TSleaZyCKDrZRshYywahesHsSU2A/hORzrO2kU5VuE1X2+tsijCckn00cBdqR2UvZr8Woup9Ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kpuwnUUm1SC2AriM+yHwMGsoXP10yGphqlVCWvE5mk=;
 b=CKRQAwtBuU0VEezA6nkiavuY8A3DiNc6HGEpLk2tllGENVjgjpyrmL1HSi2hiefhcLZbjiDFUIXPrJsQxeiE7u3uhxZUeHqBi0fnZUG+GXaWwuGDyy0fhqDaVbZZObsdAT7qGM/xpW7pnKWuTtpFbzUNcQ37cX6xettJentOvuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:24:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 22:24:01 +0000
Date: Tue, 23 Jan 2024 17:23:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, thinh.nguyen@synopsys.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Message-ID: <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
 <20240123-poking-geography-33be2b5ae578@spud>
 <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
 <20240123-anew-lilly-0d645bdbfb30@spud>
 <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
 <20240123-nanometer-atlantic-6465b270043a@spud>
 <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
 <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
X-ClientProxiedBy: BY5PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:a03:167::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c82e3e-e987-421f-9e30-08dc1c620042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vGzS5Y/GJ2+G9sfLrAt6DX8QQV9Vl5ImjIWlGZxF+LKTnoSYe4naxzYS3U/Y6rskaYoKkcr0RxD1btdWKoXegwy+Kuga6IvGNmCvPANhdYS7pEOKrPXekw0PmyO9yHjrcVUSDjC7NDm8o5VbAvIEmccMizwhF6n6xEVLoCBuaDmjO1n5/s0ptFzkyiWfdFIrv5re/NnsC2O49sqkUiL5q474emGqpff7vS74oDTKrhTmzXKtjvXDyR8k9PIxwIUs9Ul+w/E1OAB7iFos05sDg+faxlxImH+CwkX/rDO+HF+0D404nPSD/rKeXIahVw7rGknEm+AS3FWZJvSD4uA19E2mBeRXUKT+3HNM3XuQAcJ+tDvya1L8Tp6GHxtQ973Kg0x2q3NtFA4LbjLvUw4l4HPGlsMO8w8UgDbSQUuLy8dJzD9Rdf7akGf3A43ZF2gONLpnGPr30vR9cJurkNOVkkVHYEe4ZEiiR0PcQf6VuiIcsM1QHbL3yic2bYl5jEDlqyC8NhvaywkcoLVSTljltaW7/hZqhUPW5wLCXUFY2FsgYOUAKWtZy6++ODNw7MuD7feASn1uNWJgw/DJ1DSlC7WECwKct9aCDr6LNMD/eDcxYV4CLuX3xTOPYSVHB16T6BPAt4ts+/GWC5qeKUZVhg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6486002)(478600001)(38100700002)(26005)(83380400001)(6512007)(9686003)(7416002)(6506007)(52116002)(53546011)(6666004)(316002)(6916009)(5660300002)(2906002)(4326008)(8936002)(8676002)(38350700005)(86362001)(66476007)(66946007)(66556008)(33716001)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RPNK2RuhINVR6+IoyRXKz65jHH2RBmxhYE0BqrMK2rnBd3DMoKoOURj2P/zN?=
 =?us-ascii?Q?KMkeYNRfUwhe3iBfdLZ+7OHLirT0oAruxiR/OPQ/s4h5Y7zB8oW26W5/PmE9?=
 =?us-ascii?Q?b0mX9dGNKEza4fIodYysgCGnpX0UpbTh9MWuByd68Gpp32LEbC2MB3Z8kkwv?=
 =?us-ascii?Q?Uw+3zPsWrZtnN1sS5mc7bxH8saD2L0ugeHdDLNjoyVQAJQdmbvfEgdgRi4gu?=
 =?us-ascii?Q?jMCKs+EPZI+2DpHvP5oG8h9hKGx2Mp4A7U5P5FevO8glyIe1/i/NtG1QypeK?=
 =?us-ascii?Q?QE4xrNfLvnAgZ+lZMqTXvOtQjOYsYwwi3FIntzpp2HbPSduEYxlQQv+z0AFO?=
 =?us-ascii?Q?cZHYuucZRKwvldV/rwhVnZShCh+FXw/JjpWBeqAjze9y6f6+qTjmOWZh93FU?=
 =?us-ascii?Q?sR9wDvRV9iO/vbz8TgROzorKFt9OomTNjB9x2w+wYCFaqAcGpjgoy+1fN9ql?=
 =?us-ascii?Q?Zd7xsScALw3TEGE8nWTG+uYl2hkDWvUCMjnu91MhmcZDpGZcF8XqIldVNp5g?=
 =?us-ascii?Q?E27TXwcG4QNmTMQ7M+lV/F/VQ6tGGQwtBP0XBmrDUrHiwo2pg7O31whzq/fY?=
 =?us-ascii?Q?wOGRyhOM3VtE2BfW4Ckyza5RDx0GgyNGr7PheLMbCx12Spv4hI+V4iYorwXg?=
 =?us-ascii?Q?hdkSYtwQ66shETydp9+9IZEM6/Lueg7gFrvk5ziYbc56+zUvsVdU5m37qz1L?=
 =?us-ascii?Q?HcytMh533jy5Rjg3gvJn6zJ//FkUwQ4jOpsVcZL4Z0511NJ9NETkyRbxjH0J?=
 =?us-ascii?Q?lB3HnFQpcdlAYPxule1eiT0hTxjvExjckmMn0vutQK5I12rx61CuXmbQg5X8?=
 =?us-ascii?Q?/MRgIBeSxYmh4U26wVURgE5tE1BcNC19FV0RDZcwjHHN+T6beumJ4MvOO73D?=
 =?us-ascii?Q?j4bOTtGQ12mhPJ3bWkUupKeeMZtvhi/LXppt+RqSaxiDbWRfbjAo79AWprzM?=
 =?us-ascii?Q?kwySL4nS9HKeqpAu8l6nGtEGVPApDVj4s023PcyOo/NB6cBJO2pb6Wu3I0eM?=
 =?us-ascii?Q?f2uHd9TZerEgwdJxZ++Cc5BusJ44JnRJjMP+szBz2IsuxeEy+Y7FE2sLFJFU?=
 =?us-ascii?Q?k1EbaHBBumDO4g0k5AuoNm1M+4Q90Ui3Y/7rAYKsrsrFfDl9wWNDsNh37ZcN?=
 =?us-ascii?Q?5/c+7UAHzD3M5IZQWYYoVR6RdUoWkaWm9/nYg7C9D2GWQWUjsKFVvtSxtYkZ?=
 =?us-ascii?Q?pWBGPWbfHISer16u2cqSv+mFAVL8aKWoX/QqJD2xsgHYbEX2+Cf8u4feNgws?=
 =?us-ascii?Q?mK+SRddDZwtCBc4VleIsIO3CMOUX3RG4ZxFQ18amgHBnoHqHUufQ86FNWRXn?=
 =?us-ascii?Q?ZFuOTUGnqZKqu7eKIb9Ud0xbo2gL1ILX+SfRtBQV4rNGlC8NVh8wT0D6xcH8?=
 =?us-ascii?Q?Bbti7bSO/GJOrB8p82aKUTydiII2oBl8CpqEMysTQdjxvYmPevPIigHviX6q?=
 =?us-ascii?Q?6UTsxf+Q3bM2FXNV97eyByfVoUioU6dmB78FknWDTZ8SvL6/Rv5NemsFFF5l?=
 =?us-ascii?Q?eAw2BXfVM5DcRHNNDxQcJbnF0dGUDKNvVGKiVPFoP8984n7102gaRwsOmeb1?=
 =?us-ascii?Q?Ic3UIJcMf4yoBANltNs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c82e3e-e987-421f-9e30-08dc1c620042
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 22:24:01.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VATxjQ0QGfUQYj8x8Z3Rp0MjFcuIGEXv8hiBJhS6VPfR4H4H6WtPuaLMmhw2w3srVIqCLgdP0BvzdP8FLVbY8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9328

On Tue, Jan 23, 2024 at 10:46:39PM +0100, Krzysztof Kozlowski wrote:
> On 23/01/2024 20:22, Frank Li wrote:
> > On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
> >> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
> >>> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
> >>>> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> >>>>> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> >>>>>> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> >>>>>>> Add device tree binding allow platform overwrite default value of *REQIN in
> >>>>>>> GSBUSCFG0.
> >>>>>>
> >>>>>> Why might a platform actually want to do this? Why does this need to be
> >>>>>> set at the board level and being aware of which SoC is in use is not
> >>>>>> sufficient for the driver to set the correct values?
> >>>>>
> >>>>> In snps,dwc3.yaml, there are already similary proptery, such as
> >>>>> snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
> >>>>> driver keep consistent. And not all platform try enable hardware
> >>>>> dma_cohenrence. It is configable for difference platform.
> >>>>
> >>>> When you say "platform", what do you mean? I understand that term to
> >>>> mean a combination of board, soc and firmware.
> >>>
> >>> In my company's environment, "platform" is "board". I will use "board" in
> >>> future. Is it big difference here?
> >>
> >> Nah, that's close enough that it makes no difference here.
> >>
> >> I'd still like an explanation for why a platform would need to actually
> >> set these properties though, and why information about coherency cannot
> >> be determined from whether or not the boss the usb controller is on is
> >> communicated to be dma coherent via the existing devicetree properties
> >> for that purpose.
> > 
> > Actually, I am not very clear about reason. I guest maybe treat off power
> > consumption and performance.
> > 
> > What's your judgement about proptery, which should be in dts. Such as
> > reg, clk, reset, dma and irq, which is tighted with SOC. It is the fixed
> > value for every SOC. The board dts never change these.
> 
> Then it can be deduced from the compatible and there is no need for new
> properties.

Okay, I think "*reqinfo" match this. When new Soc(using compatible dwc usb
controller) appear regardless dma-cohorence or not, connect by AXI3 or
AXI4, needn't add new propterties. 

Frank

> 
> Best regards,
> Krzysztof
> 

