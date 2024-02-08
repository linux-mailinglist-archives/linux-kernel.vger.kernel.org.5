Return-Path: <linux-kernel+bounces-58705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BE584EA36
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587F21F21A81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D562C4F1E7;
	Thu,  8 Feb 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RrB8dbXz"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02264EB4D;
	Thu,  8 Feb 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427235; cv=fail; b=BNncKBT4RbMtGqN8ZyLu4gWC1Me+86EQai4lPdXJr1o1IkU9Ih+W+IRvkF36eEqo7y+CinfOm4bWRlsEvgsyUbrp3xzpQfbifeFR4xffwx/lkJnYBj8gWGrM1+jdVmvgClshIcQaoNPvtqPZUFsXeY9lzdU2wDu0Hkbo4y8LCyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427235; c=relaxed/simple;
	bh=cc1iHiV68777SmlzAAoR0nbyU5mZql2eY+aNf1bciNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qL3ecDn4g9XZz3Y887/8BtyJn0RQ5vhIjHo1ei6kFU3KJB6ZdB3ufHb/Tu9jXMWF30PlD04pUxfg5WzGlqz1CjGtHFvT9Hsesr/D/Y3zUTHPubJ7KtFgHI+FB/IvH4aGRVyej42At8ODapJs18y2F4AQ9x0/MaKXPxvkJP+Dn64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RrB8dbXz; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAMsWamgcrnXnEuCjQA2KLntqr1IpCwRoWozowJQegMp50e2WgiUhEiJpABIzLQVq1Qr9UfUUt0DRLFPucD5I/akNVfiaf6+E/Ou5xq1ITQOSTVyufS2Pk/zguSO2JHHWBnzW5clkitowkwLTl566ipHxrq+S62mDwXGcD0QYyhpso0zHcnFrWaVcZTvgBWswKp+6++CFbQZVw2KIcBAgFnsiDMrbcFrCvz9djhuLJ0tZkNhkNBOHaqOw0pvCIBA1MqtVrHuCot/gPZ3rKbkH6cWfOkStp+3QVR1e/LUry4rTVQzgnXE3po3YwPJ+Yag8XGgENgfxUQQJIvcJzwzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfZSRuS6VtMTUatiM/Djf3dz9pztTXzJxWmnOuu8dgM=;
 b=RXOXJfk/OfJMXniA0T68FSjPRJzOQs/CzsXlFTg3hE4jymOwnkiZn+2Hx84esI/9NgivjdqQ6VdlOiVzbZ6BJoaNySXHszeEDWyckKU9R3wwUPzxdRWL/7KZjhTJxx5zbHiRlIvOxkUMxaDfgvkK+TlVkMLTuMaxtKrNd0N36bsZNkRBCvmARIdj4bPS5LrEyZtTvf3sfZRhOUCJsmCnZZTyNBDxr2Wutkp/K8HgOXgL0PNk3hmnYQiYTm1X1apcUuim3kJPhEjEB8U8J92ryN3ZvIy1wdzyjzRc41CUxE9nhsYjv1MKij1YxKQc8vH8I0OAj6QQP5KTP99HdrBZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfZSRuS6VtMTUatiM/Djf3dz9pztTXzJxWmnOuu8dgM=;
 b=RrB8dbXzpJVOe/kg2qUMgpITvpTciCyt/kzHCVshJleiq5EfweGhln5bVf2b/1NmCBIixtX6mB96RoyiK5wzpW6sGVjLomOsa3yBfTsOvUWI3qAm7sRi0uLhKbS5ZHfaN0r2j2i9UPgFS2DpOGjQ3ixW7zqB1vxVxGhQ6qGUkNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7935.eurprd04.prod.outlook.com (2603:10a6:102:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 21:20:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 21:20:30 +0000
Date: Thu, 8 Feb 2024 16:20:21 -0500
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
Message-ID: <ZcVFlRug4ATBcH9R@lizhi-Precision-Tower-5810>
References: <20240123-nanometer-atlantic-6465b270043a@spud>
 <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
 <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
 <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
 <ZbfB/KT+fzO/F2e5@lizhi-Precision-Tower-5810>
 <20240129-encode-catchable-f5712d561a47@spud>
 <ZbfjZoHiH7BsKyzl@lizhi-Precision-Tower-5810>
 <f3811c1f-eff2-4c7b-8cea-6d3115525235@linaro.org>
 <ZbkTvu0Q85zyieXr@lizhi-Precision-Tower-5810>
 <0be231a2-0c3d-4f18-8de2-3e4f1fe1cd29@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be231a2-0c3d-4f18-8de2-3e4f1fe1cd29@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: aea9e770-7c3e-4c7d-5553-08dc28ebc6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D39u9THoZ1FYRUVZ2xZekoezWkEB45vwv5d2mFLJbZJyHQ1HsFMCTDW5TuhnTIZC6brIWs263KYEqe5hpCOd1zj6wdW22Hrct7L/gOa42FR6IvSVz+LeYBJNV7i6H9FVOziV0NPtKYr05AmFG4WXFQrWjwEYovzdz7JQTMEQmcZGRb6n24txXLdug4o+dqVyouTJmN8tNlXjUGY+HS8lVs9Vg2OTqHHijfQKAhTYGTSrbhCtQ2sz0ssdwohh/GxEbRdBLoh2ti/0qHUuGHtu8TQiu2KAADAdEj8hUrH4OygflKB47l7HEN6h6pbqIDW9Co4YpeoaBXEPwcqD4a5SH+rKmyT90e6YZxf+L8xEFLQ7Eqr+0y1YrQSx6yRwKcdGoN6IwUGRmy1M44tXXf6ZNEAGgMRNGUocNpcZPtj99l1slZjLgTAnVj5Pnr9pRu6iSU0KLlSZt4qnhIs+DXKLU5TpHj7BsyKRsXAUCT0UBPPwCGFqTFFoSo/Ejre2PRC1NcxtJImoEvmS2Hke+8FH9dZPwaFIxh4Du/toAWl868sD1ArujQKO9O7flXukO2qQMFCPsejmxUoY55cDVc9jEJRZ6G7aE3/40GQ4yz5zGAABkCC7PQl7VoJkBPjQTX2v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38350700005)(33716001)(316002)(6666004)(86362001)(66476007)(66556008)(6916009)(9686003)(4326008)(66946007)(6486002)(6506007)(478600001)(5660300002)(53546011)(2906002)(7416002)(52116002)(38100700002)(6512007)(26005)(8676002)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jX6cUAjZnvPeOXd/17CkBosQpSTs0Djx2R5vdz8kwlfc5llScxRvftsdA3k6?=
 =?us-ascii?Q?zEP6WAKzfrSW/vkhMRE/gBQXt9lGHB5r+hNONi3LugHGU5XjIkpqOYUGXB0a?=
 =?us-ascii?Q?APw1GoHywhRPdhIiF/7daR5Zpd0w3GmowrL41Ru/jTDAv6bt1HCmJ6nYleYh?=
 =?us-ascii?Q?E2WSM6JeeAWCRNx17tHbkdWza9wz5RVzkwJIigE3qgYzXZkbhHiml73SkJUL?=
 =?us-ascii?Q?5GBJq6ulvvZoeZnlvT5AgvdhVwa18gLlPEtEIBeEO8Ce8GKeQLOl/gWVGum9?=
 =?us-ascii?Q?pe6clz9l5f1n2OQM+cFoMMyVb0E1JeCnudnU+kslM67a3QDOU4xlMZrI7l9m?=
 =?us-ascii?Q?G+YMFmvi3Lbudx8ZQag1M2NcDaMS+2FeKtFM56xG3eJjs4e++Mlk/e20NopY?=
 =?us-ascii?Q?jya+hXoPRcK650Q+5Ti1l1xD+iqMXf/2tbgJbBDRIsya+D09gSf0Fo5qY5ZT?=
 =?us-ascii?Q?hRduvi2NrSGlPLduwhL+d99a1lwFiOWoJbIRwVE6cQpQ0VYn0U83XEf6Qx+k?=
 =?us-ascii?Q?eik3WP2WVAnlGCK7m0pzjR2dm9VyEyOp93zmMxH2hONtk4WMIzpeXUFf6nH3?=
 =?us-ascii?Q?HFnq3AjWdr3umRhtgFugi6C7rI+Cn0y4FwX94BxhuAD2Dc6G/xONqnw+E6oC?=
 =?us-ascii?Q?nCm5xfESe8HTZY+IQ/op3xE+8yL4VuXlFT1IyPmYjw04KfLNURa2OBY7svxz?=
 =?us-ascii?Q?i0AIFz7feJyy6KaF783OzlDWERikz/sLHEAEVkQfvE+oOig4FS2yYM6T10ER?=
 =?us-ascii?Q?VXjH5H1B/qS6iyFaiWRlP5ACN42JH/GuC0SUjbzsQAOjBfR/unM7k7+E9JSX?=
 =?us-ascii?Q?ZE62W44YMyf2IaEkvzaiSmSAzoDYG85LO6JFkW1APf36MpFJKMvSWUrIslaO?=
 =?us-ascii?Q?IID4tXqrc1/Y0ltve4Tl7nxRywTnlkYuAIXqkJHQfCDPCyjJMdmx5rOlVqbB?=
 =?us-ascii?Q?5fjoumRatMct0nS7KB6AD0lRrhmCtRSHRoVjvk/rKrb1agRTpnTs2jwpKSbr?=
 =?us-ascii?Q?a2HRcSBhlgW7f6wEZAkGToUssx2tp0kwZ78SatIupUHjcI7mUwcMFBqOKiHw?=
 =?us-ascii?Q?zTQkIu9eyDGKZcQzdBIdyGk7i/Ljkv/I00N+q5Bml6q4wXRIohL43+mFsHMo?=
 =?us-ascii?Q?Tkbwqvfhf3Qg9MCp3TesAw3uPAIxMcdcl3SWHGPtctsFz5s5C9msWISF3GRZ?=
 =?us-ascii?Q?Wz889HUa1K613hGn2bO6eItNfyY1Le2nxYQZLEoRo4R2F5FPbX2xNbAC9FTv?=
 =?us-ascii?Q?OPPVQAHGSJWs0oxtw876Xg3safgc8pCgtU9wN1tF/OZxTsW9zOWxq4NPycta?=
 =?us-ascii?Q?KFuKNEnzfP4uT15dl3SqP7PJtYWhNftF1OXac49311rnGaHmFLeCI4cFriYG?=
 =?us-ascii?Q?8yKwUivjZcd0fhm8EoqUdb1e8RJUJhyLKHbXB8E0w7n2RJg+PZrl3xC9viE8?=
 =?us-ascii?Q?SxE4K6ZRHcjbjDeH1GOm5VgJUdc9sSM2iyz/zbK1ikBY6mFHmeEoK1Lfpgdg?=
 =?us-ascii?Q?3Bp1EacH2hyhdwzAZ4odj+sCZYD5n6DqyBhnLEatsLtOais+thdGkrDbNA4g?=
 =?us-ascii?Q?Yq7CDHqAxEKsEDz8GW4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea9e770-7c3e-4c7d-5553-08dc28ebc6e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:20:30.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfbmCVmMz3eAceJd3VP9UQtLzvn5hcn8uIIuKOSVPCCHksa+XQDtvJdVB6hdqiRokiGIbt225FY+86cZYCjLbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7935

On Tue, Jan 30, 2024 at 05:10:54PM +0100, Krzysztof Kozlowski wrote:
> On 30/01/2024 16:20, Frank Li wrote:
> > On Tue, Jan 30, 2024 at 08:40:29AM +0100, Krzysztof Kozlowski wrote:
> >> On 29/01/2024 18:41, Frank Li wrote:
> >>> On Mon, Jan 29, 2024 at 04:49:21PM +0000, Conor Dooley wrote:
> >>>> On Mon, Jan 29, 2024 at 10:19:24AM -0500, Frank Li wrote:
> >>>>> On Tue, Jan 23, 2024 at 05:23:53PM -0500, Frank Li wrote:
> >>>>>> On Tue, Jan 23, 2024 at 10:46:39PM +0100, Krzysztof Kozlowski wrote:
> >>>>>>> On 23/01/2024 20:22, Frank Li wrote:
> >>>>>>>> On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
> >>>>>>>>> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
> >>>>>>>>>> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
> >>>>>>>>>>> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> >>>>>>>>>>>> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> >>>>>>>>>>>>> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> >>>>>>>>>>>>>> Add device tree binding allow platform overwrite default value of *REQIN in
> >>>>>>>>>>>>>> GSBUSCFG0.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Why might a platform actually want to do this? Why does this need to be
> >>>>>>>>>>>>> set at the board level and being aware of which SoC is in use is not
> >>>>>>>>>>>>> sufficient for the driver to set the correct values?
> >>>>>>>>>>>>
> >>>>>>>>>>>> In snps,dwc3.yaml, there are already similary proptery, such as
> >>>>>>>>>>>> snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
> >>>>>>>>>>>> driver keep consistent. And not all platform try enable hardware
> >>>>>>>>>>>> dma_cohenrence. It is configable for difference platform.
> >>>>>>>>>>>
> >>>>>>>>>>> When you say "platform", what do you mean? I understand that term to
> >>>>>>>>>>> mean a combination of board, soc and firmware.
> >>>>>>>>>>
> >>>>>>>>>> In my company's environment, "platform" is "board". I will use "board" in
> >>>>>>>>>> future. Is it big difference here?
> >>>>>>>>>
> >>>>>>>>> Nah, that's close enough that it makes no difference here.
> >>>>>>>>>
> >>>>>>>>> I'd still like an explanation for why a platform would need to actually
> >>>>>>>>> set these properties though, and why information about coherency cannot
> >>>>>>>>> be determined from whether or not the boss the usb controller is on is
> >>>>>>>>> communicated to be dma coherent via the existing devicetree properties
> >>>>>>>>> for that purpose.
> >>>>>>>>
> >>>>>>>> Actually, I am not very clear about reason. I guest maybe treat off power
> >>>>>>>> consumption and performance.
> >>>>>>>>
> >>>>>>>> What's your judgement about proptery, which should be in dts. Such as
> >>>>>>>> reg, clk, reset, dma and irq, which is tighted with SOC. It is the fixed
> >>>>>>>> value for every SOC. The board dts never change these.
> >>>>>>>
> >>>>>>> Then it can be deduced from the compatible and there is no need for new
> >>>>>>> properties.
> >>>>>>
> >>>>>> Okay, I think "*reqinfo" match this. When new Soc(using compatible dwc usb
> >>>>>> controller) appear regardless dma-cohorence or not, connect by AXI3 or
> >>>>>> AXI4, needn't add new propterties. 
> >>>>>
> >>>>> Anyone have objection? I will prepare v2 to fix rob's bot error.
> >>>>
> >>>> I'm not sure what you want me to object to/not object to.
> >>>> Your last message said "needn't add new propterties", seemingly in
> >>>> agreement with Krzysztoff saying that it can be deduced from the
> >>>> compatible. That seems like a good way forward for me.
> >>>
> >>> Okay, let me clear it again. dwc usb is quite common IP. The below is
> >>> what reason why need "*reginfo* instead of using compatible string.
> >>>
> >>> 1. *reginfo* property is decscript hardware behevior, which will be changed
> >>> at difference SOC.
> >>> 2. it may change at board level according to if enable dma coherence.
> >>
> >> dma coherence is not a board property. Anyway, you said it will never
> >> change in the board.
> > 
> > Sorry, let's correct what my previous said. There are two kinds bus in
> > system, one is dma_coherence, the other is none dma_coherence. There are
> > some dwc usb core ip, which is the exact the same. Some connect to
> > dma_coherence bus, some connect to non-dma_coherence bus.
> > 
> > So dma_coherence will be varible for this case. we need set *reginfo* for
> > dwc usb core, which connnect to dma_coherence bus.  not set "reginfo* for
> > the dwc usb core, which connect to none dma_coherence bus.
> 
> OK, that makes sense. Please provide link to upstream DTS
> (mainline/next/lore link/other upstream projects) showing this.

Look like I still have not found the real case yet. But I think it is
existed (maybe not upstream yet). Can I forward using this method?

Frank

> 
> Best regards,
> Krzysztof
> 

