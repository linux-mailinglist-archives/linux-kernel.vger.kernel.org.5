Return-Path: <linux-kernel+bounces-44822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E168427DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7D01C2402B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F89823C9;
	Tue, 30 Jan 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UPbhDeh2"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A567E75;
	Tue, 30 Jan 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628045; cv=fail; b=nOiFMz1f/Bi61uB4k8sWrEv8JILQZNkh7pZuqntcoLxilOwKC4Hv+NPsD4iSARVOM2JO9SQD4K42vDKyA88U3awZds+PhWrib9hW9Td2NwHxwm0oJU2eia9FxvWKU3JHSk/sAN4CW5qDfVSz2FrFT310pyEApxtW9SouwYY6Enc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628045; c=relaxed/simple;
	bh=oq0PoTIN7pDsmN0PMl+sSPjRsozU3Q7pdLy4o1QurtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fLcyjCnJoEdIiu/+KJle9/GH0owbVCaAFA8MWylUNZ8tRwLlx3OvNxZW1QXJS2F9UU4+iO2dk5HFcCGRkHlsLTsoCalo5eYgPdlrEdZvXoslLvF3nD8GOKult0adgcBITMR1/mpRgKGYS9R/kgOVtpRSyTyRA0CjUs3nnLfRfUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UPbhDeh2; arc=fail smtp.client-ip=40.107.13.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWElzKUFoQfTWzNGmTZ4UBUEhRZq09aMYRn/VSDOgIkQLAxuDYoQ01zTZRqYUGsX+bwIfSQqLtLWkhevigdhVGAHSAy2qgYrYK21j+kYGivl4h/noWxbH8PtSTY/ps7ffC3drDzrXAntp4VIZfnWWStoy0OUzRV3h/gm/nu4/xojT1bwx+V7jaqPPY8RZN75zhUuJK0uJGebELYo6qRya+lvcSEdqNHb90mfeLTS8rMDAxmyDrtl+PAIOVZFOoCi6043yp36SD6WifYvjOfEMCj1H6VgJln67G0MpYV6++pTZGa+qWaV4Egjz/S5w241npWIJAMrh5wl79Im37ccrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6IjsWW4fmCMIVsnzf0G9PxSqi2lFH1gZb/GhV9gATI=;
 b=CnfUbWb4xcmmr3Tr+6AmNXH70YoS0JT44JrZf9bfm8+UuiWhu0iWVlxLNIqk/nCBZj2LTYZvAszDXa0P2AkcfbHSr0ktzb7A8/ELsjgfPWVckdAQ6wJ3bLiE8vfCrVYeWoWQQ6BiW1pY6IxSP7wdasOoWTDbj3BKbWdFylcZ6mVVkXHN6R1fi/oW3xE6X/PMQF6s4RAKuPnzCCJyasMl2cHZ5bdkZg3/l1JtwhjQyiWxpfyt+PSJa1adwB47yh5ia44cBlqJF3BK5OBzQ+TjH9iBz7xTzFHPvHs6euaNDkNH5TsdPGAReN2b4oRlGlrINKbfZ4phVc0SvIFmtMUfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6IjsWW4fmCMIVsnzf0G9PxSqi2lFH1gZb/GhV9gATI=;
 b=UPbhDeh2sPMExLGgr+oYQjuxWuOET7nOnyXqO8NZHGAPeV34VdI0ITnicReu6/wZQvBH2nHKku6gsTJuwjU3KzZDqHy/74PIYX1LCpajUCYtNsRDXb70BK/u9+BW7jb0Idq5iVJdP9qxV2bKJ9x2NxpTRnG29yMH14gm+b8iDEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9929.eurprd04.prod.outlook.com (2603:10a6:800:1dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 15:20:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:20:39 +0000
Date: Tue, 30 Jan 2024 10:20:30 -0500
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
Message-ID: <ZbkTvu0Q85zyieXr@lizhi-Precision-Tower-5810>
References: <20240123-anew-lilly-0d645bdbfb30@spud>
 <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
 <20240123-nanometer-atlantic-6465b270043a@spud>
 <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
 <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
 <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
 <ZbfB/KT+fzO/F2e5@lizhi-Precision-Tower-5810>
 <20240129-encode-catchable-f5712d561a47@spud>
 <ZbfjZoHiH7BsKyzl@lizhi-Precision-Tower-5810>
 <f3811c1f-eff2-4c7b-8cea-6d3115525235@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3811c1f-eff2-4c7b-8cea-6d3115525235@linaro.org>
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9929:EE_
X-MS-Office365-Filtering-Correlation-Id: 10611e75-de93-4bd4-624f-08dc21a70423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nq/sgQiyVGs4pNJXk2HlXO7//2ko2/STLCiaSHSltxyWqnIx4G6itHy/AaK31W6qxMjdlLcg5t11oZWNrGSNCD4eX955DBSWMJaVT/7hGDCJkN14nn3kkN9UtCYa5Mlv6wY1UGOGgtYayJIltfqqbr33haIwlpW+wjKEnMpzJjnRZsyex/80wMbqIWSFAEiybkLt0BdhIKWVIWbBvnCmcOVKzhW25eobqWlCAXXDNgf0iMAj3hrEJ7CpwQXElP4uvgmi2dd01OyJ/7NtyaeYAQX9gfgdRiSSxgSqA3r/7FzZIjx0DCaEQxfGYjaEp3mfNy6TbA9ytRrFIho8T+YLt5x4rZruJd7CZ9YbxIeEiONh9lfqH3piGINCxi70Mj12zLi3wL4E6UCUetnWhuoLvoL2yjnP7MFuSyEHChfEtCA7ptvFTtl3P78ZcJOrCuL9Nz0IIJVk1o5c9SY1BVKjLZz41g7QQ9hMQjgZhf2N4A21fFAUz+ENvSP5vlCD4gDffjvdHOmE8VM+gqM/pqPmyIaj8Hs77vF1GDTnXiy7NfXFmWu63SX3nUsA5L2rH7/lHObi7rbP6DrJQriTOU/RzFivToOv7voEQytQPg4yqFtTcnetJEdmwqFhIn8WFwai
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(53546011)(26005)(83380400001)(6666004)(6512007)(6506007)(52116002)(86362001)(38350700005)(7416002)(33716001)(8676002)(8936002)(5660300002)(4326008)(9686003)(38100700002)(41300700001)(66946007)(6486002)(6916009)(2906002)(66476007)(66556008)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWeL7MID7lqmFTEcuSydK7clmyymbSiMAILX3UFEhSQ+rgQ67RZEXCnVFwlj?=
 =?us-ascii?Q?xzCBBUoiNDaFDSWu9DFCEl5kQWxSAUefnqduD/Xif3FI6dCYY5QhdQAzJheJ?=
 =?us-ascii?Q?ITbWVYautJ1w1t1eyIGcnuXFpVtbJEYHi5yfHb1zUxUQTAjeUYKN/f5/n92w?=
 =?us-ascii?Q?TY3iZXPumZAzDDsZu02ntY/1HoBPxF33Aml2MMiCnWWnrzlHMlGQxiiSMAKT?=
 =?us-ascii?Q?Z99DT23WKJaUJi+gTmSDOCgo8a7LAvn5JOvvEe6MgWQLPtcx7+Ez5b87QzSG?=
 =?us-ascii?Q?yDoIpgGQnH9Qw8ThubdnbGypeF9h1Iw9wjYMgZj5C9KlqKQE2czaK5plWmid?=
 =?us-ascii?Q?Pb2/qPOEucGaF3QXhWfEhY0wtpFcOZ+eGmu4JqV5jt+I6rz5cddz5tjJwDhj?=
 =?us-ascii?Q?tCJwaebY8OdPpEM2czcLxzXW/9I3toGOr53NfiE5NKJvb0jxYa34c5n0TAwC?=
 =?us-ascii?Q?FUmzWGANjqizK0n6fcRyAU1UzWiGckT8mGZ7RPp8TTpio/R3FZADwH5hJ8BQ?=
 =?us-ascii?Q?mFgn/8KkEV2GV5qMfhwf4mAChbl4EduNPOd2U8akrHGjdRrYzAWblSpqtRwh?=
 =?us-ascii?Q?//X4D125vMlAgz/J1Il+Kq5DssvaAwbHwxw3aSj9zvCm1SlE3PWt8eyVUFD+?=
 =?us-ascii?Q?trziJ98AgWHHYTf+YwaDcfivjE/Ge0cHn7QFHQOm/w1O8uFVol7iSbupDKoz?=
 =?us-ascii?Q?LzUaJ64KdDHsomytm804P9Yy7uRdhMIA5y6Ju4O9Q+p3n+ivl1N16cBAuo0n?=
 =?us-ascii?Q?OufnxqvzsLAVYNkN0cmVtpibAiC6eMCufHi5RHg+Cqa2oFqVdFMyLb7RxJ5y?=
 =?us-ascii?Q?WE5D1zZccK/1pdIbdIq7Ul2gAdWUpseveN148ugaNOhgrRW4LocS5fBOMlhp?=
 =?us-ascii?Q?e/YJ0vwxCc7W0fEcCfvZiNvbk8t/q10Tn2r2+U0rAg+HoGclsy1Bb0gIiJgP?=
 =?us-ascii?Q?gVEuifxH/cZHXEccNKY7qZGeYfTSNyg2Cj4DwfIwcFuAzn5L7wyQeVLS+D8Z?=
 =?us-ascii?Q?60vFpSntcFiMCzjw/GmhEACYf8baLiTRfrGIc7xDdTOt6pbNX3ZV8UdmD1zp?=
 =?us-ascii?Q?rKcMKIpzM90sarZ287wFTJVDdIzjIe8qx/WET7dxO5nYenIIbb8YvvDYoUjk?=
 =?us-ascii?Q?KEdKp5oBH2IFpAq2m03kpr4xli2EdZw/trg3AgbyQed9RlLwxp5ADQGy5SwG?=
 =?us-ascii?Q?64EBfYMtzGIYWTPGbu9Qg5e/yeMoCaL70CQTb6juimalVBNd5OvZVvhzq9Ju?=
 =?us-ascii?Q?LJFpY6WrTj/zbsp2dr1uNm6WueL7fbrEewOWXs3ZtOvifSHdN912At0tA+mw?=
 =?us-ascii?Q?jodbTNRfSWCYZm/Svxfd6Or5f3Pnbjig2351GNpNprZMGO/hpgs+9Ie4ErEF?=
 =?us-ascii?Q?mSRxaQirnPKeAf/5oDTvEutUPkUwdqv3y0yf3+VqgAejVGtCDmZzgC4+ruJG?=
 =?us-ascii?Q?eFcCTuAIudCM14WSgtmR30PVZ+2uED8RP8lHFPR4nLgrvxzsWMM1ZJ/7/mqq?=
 =?us-ascii?Q?U+t++dkX6aNVwJu7mnUds9ghibothu2TcKHFmMWCi04D8xchfgNYD+XmtJOt?=
 =?us-ascii?Q?H/dZikZU9BaLJgr81OmqHqh+XHaLJraU423jtH6P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10611e75-de93-4bd4-624f-08dc21a70423
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:20:39.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zs+zM09xCfOAfm1A6Fq116/cWpXBTYVN/uTR6+AtcgbNguIQ5LHRX6FXE0VagyE98kFRWgDsNShy5TDv4fwBWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9929

On Tue, Jan 30, 2024 at 08:40:29AM +0100, Krzysztof Kozlowski wrote:
> On 29/01/2024 18:41, Frank Li wrote:
> > On Mon, Jan 29, 2024 at 04:49:21PM +0000, Conor Dooley wrote:
> >> On Mon, Jan 29, 2024 at 10:19:24AM -0500, Frank Li wrote:
> >>> On Tue, Jan 23, 2024 at 05:23:53PM -0500, Frank Li wrote:
> >>>> On Tue, Jan 23, 2024 at 10:46:39PM +0100, Krzysztof Kozlowski wrote:
> >>>>> On 23/01/2024 20:22, Frank Li wrote:
> >>>>>> On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
> >>>>>>> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
> >>>>>>>> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
> >>>>>>>>> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> >>>>>>>>>> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> >>>>>>>>>>> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> >>>>>>>>>>>> Add device tree binding allow platform overwrite default value of *REQIN in
> >>>>>>>>>>>> GSBUSCFG0.
> >>>>>>>>>>>
> >>>>>>>>>>> Why might a platform actually want to do this? Why does this need to be
> >>>>>>>>>>> set at the board level and being aware of which SoC is in use is not
> >>>>>>>>>>> sufficient for the driver to set the correct values?
> >>>>>>>>>>
> >>>>>>>>>> In snps,dwc3.yaml, there are already similary proptery, such as
> >>>>>>>>>> snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
> >>>>>>>>>> driver keep consistent. And not all platform try enable hardware
> >>>>>>>>>> dma_cohenrence. It is configable for difference platform.
> >>>>>>>>>
> >>>>>>>>> When you say "platform", what do you mean? I understand that term to
> >>>>>>>>> mean a combination of board, soc and firmware.
> >>>>>>>>
> >>>>>>>> In my company's environment, "platform" is "board". I will use "board" in
> >>>>>>>> future. Is it big difference here?
> >>>>>>>
> >>>>>>> Nah, that's close enough that it makes no difference here.
> >>>>>>>
> >>>>>>> I'd still like an explanation for why a platform would need to actually
> >>>>>>> set these properties though, and why information about coherency cannot
> >>>>>>> be determined from whether or not the boss the usb controller is on is
> >>>>>>> communicated to be dma coherent via the existing devicetree properties
> >>>>>>> for that purpose.
> >>>>>>
> >>>>>> Actually, I am not very clear about reason. I guest maybe treat off power
> >>>>>> consumption and performance.
> >>>>>>
> >>>>>> What's your judgement about proptery, which should be in dts. Such as
> >>>>>> reg, clk, reset, dma and irq, which is tighted with SOC. It is the fixed
> >>>>>> value for every SOC. The board dts never change these.
> >>>>>
> >>>>> Then it can be deduced from the compatible and there is no need for new
> >>>>> properties.
> >>>>
> >>>> Okay, I think "*reqinfo" match this. When new Soc(using compatible dwc usb
> >>>> controller) appear regardless dma-cohorence or not, connect by AXI3 or
> >>>> AXI4, needn't add new propterties. 
> >>>
> >>> Anyone have objection? I will prepare v2 to fix rob's bot error.
> >>
> >> I'm not sure what you want me to object to/not object to.
> >> Your last message said "needn't add new propterties", seemingly in
> >> agreement with Krzysztoff saying that it can be deduced from the
> >> compatible. That seems like a good way forward for me.
> > 
> > Okay, let me clear it again. dwc usb is quite common IP. The below is
> > what reason why need "*reginfo* instead of using compatible string.
> > 
> > 1. *reginfo* property is decscript hardware behevior, which will be changed
> > at difference SOC.
> > 2. it may change at board level according to if enable dma coherence.
> 
> dma coherence is not a board property. Anyway, you said it will never
> change in the board.

Sorry, let's correct what my previous said. There are two kinds bus in
system, one is dma_coherence, the other is none dma_coherence. There are
some dwc usb core ip, which is the exact the same. Some connect to
dma_coherence bus, some connect to non-dma_coherence bus.

So dma_coherence will be varible for this case. we need set *reginfo* for
dwc usb core, which connnect to dma_coherence bus.  not set "reginfo* for
the dwc usb core, which connect to none dma_coherence bus.

If use difference compatible string, that's means using difference
compatible string to descript one same hardware. You reject this method at
my svc-i3c-master\svc-i3c-target patches.

Frank

> 
> > 3. dwc core part is quite common, all SOC using common "snps, dwc3" as
> > core-part, all soc specific "nxp, dwc3 *", "qcom, dwc3*" is used for glue
> > logic part.
> 
> And all should be having dedicated compatibles.
> 
> > 4. using *reginfo* can reduce add more strange compatible string such as
> > "nxp, dwc3-core" ...
> > 5. *reginfo* property likes "reg", "clk", and align what Kryzystoff said.
> > "reg", "clk" is fixed for specfic SOC. These can help reduce "compatible"
> > string number. "reginfo" do the same work as "reg", "clk" ..
> 
> So again, reginfo is fixed for specific SoC? So it can be deduced from
> compatible.
> 
> I don't know what to say more here... so let's be clear that you
> understood me:
> 
> NAK
> 
> Best regards,
> Krzysztof
> 

