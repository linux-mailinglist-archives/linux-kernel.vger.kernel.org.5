Return-Path: <linux-kernel+bounces-39593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A43BE83D353
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20440B24B80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC40BA4B;
	Fri, 26 Jan 2024 04:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oN1RFC3J"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0FBB647;
	Fri, 26 Jan 2024 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241984; cv=fail; b=YPhGePDvKNibLhahDkhAR9T13ZpymB4Ex/vS1yX7mEYSbITevlhkl/TkzV6HcKhdjjio0Hueo1QOkYOiXkgcCBHxGgFfMfnWf050lMbm4Iy46nI5QSKNS7a1UYBYbL7J8wLfOIAWwIGrBUQFKnLyS997rkau3C1SQUcpfRLDLBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241984; c=relaxed/simple;
	bh=y/CbRMCyyiuPja5/XKA2IiSq8Xw2J24yZkc5hRCX2h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pxq1boE9Mfn9BruGuteLGmLSS+Dm/ax5sXGvdsHeKo5k5IHnuind/6Lw7FCbpdEnHU5qnuTpPUWENXGoH+AHYikI3Tpa7fSG68DT0QOTl0EvVg2s4sPWsSNtjE6w3ZJcyfpgz+zPMLRF5Mmt64xuH9Frb2PHcXioGlukNjk5IFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oN1RFC3J; arc=fail smtp.client-ip=40.107.247.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAWn4KEV9GqG3MnTZebUivUSa0UJXgKIrUBL04Nm+U/mwXSwzn8Pki6U+KQ6HdmIPk2H03N9ZyR0qpsE0DQX6DJKyMX4WPIx+PXT8v9SL+sThQTCpeSBee0wu4r9Q3mNwWno7I0egFFbyeHZ33/apx1+N9u1mxPMlEX0nWEqe37JTMdERZ/uOaEeJ7S363RySMTDycaDt23S+U5S8VqBNHfKyzRoDPlhQyT0ZaeUgSN1hkoHsxmxtwC349q8HtTe9in/TzWNA8k7XuseoBlBjxbbeYiAVsQSqwpBuaPAHz7vwGh2RU30yTdVZFiZ9abLUcRO3XfLdfYyBxD2/WDWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WJjRzANeBSGsZMCMVUGilfaCZb60fkde1BBrfBlOws=;
 b=kszWDX5+xCPbFYrxpVvUDHxOueVeRbvkZLElrNF7VzrtHOBA7ZG8rAlcEdh2mcFUcabOzKcEhtr32all7m7SkHCkse1gUZp68LTp11RkzanUjMVW5/53JONCaKv/Ab+wEPB9gXH+KimAUFCz2j3F2yBftfdRwLsKpIX5q4G1iU/QG3HW1+y2x8/H2cwGJ/LEq4bsRDNFmSrNXH0AbaTHHm4HmaHywwq8Urnu/VeOMMCRR3WMM7Mq2YM+VgeGXNHYbolI7IDcyl+E5nW6l/qUuIbY1X+Vt5khBaGwtWbhJrtcJG3BfL3xyBSTVhHH0x9KMq/4wH74Hjmzn6SuS1MJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WJjRzANeBSGsZMCMVUGilfaCZb60fkde1BBrfBlOws=;
 b=oN1RFC3JBGXmLSUVyuSZGdUC/t6tFI09+ZNi+oF+FrpbHCd2vnLfiGayCQXzYvgvNeKQoMDjm40zhFstjbWAkIF2wYhtuPhnrDguenQ0r3vCRdYH0PLeRyPrts1vL1XkFahAGQfOH7fQlO9cv14/HcmuT5Sk+EwqNS97EoQsZDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7078.eurprd04.prod.outlook.com (2603:10a6:20b:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 04:06:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 04:06:18 +0000
Date: Thu, 25 Jan 2024 23:06:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: ran.wang_1@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, mark.rutland@arm.com,
	pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Message-ID: <ZbMvsQpBtX88+muU@lizhi-Precision-Tower-5810>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240124-unclothed-dodgy-c78b1fffa752@spud>
 <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>
 <20240124-video-lumpiness-178c4e317f5a@spud>
 <ZbFiQmD1VRVzFSa+@lizhi-Precision-Tower-5810>
 <20240125-appear-unclog-7da879f946e8@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-appear-unclog-7da879f946e8@spud>
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 2345babd-8b6c-4e05-36dd-08dc1e2425a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RFiK3VscRmU8YNHWgNiYy6FVRabHa24WEwpWxQguBomdBtNwQgnCyFGeNzYLLoUxAON9L4mfxTBzXHh/ZuuMTrR9ePsOc6u9xJbK7FrFM3wR7m42I1u7a+WvtlTSoUP8PhKqj380bn0ewSkLcxFoViWx4AnwMGYbI+YjE30Nf5bcXVkSE+o2+g4fimdKDN1JTv9u8wwGXQK3wjhqEcQ6PRAbXIStg+tN2PxWXZyCijoy8hvDigf2Er4M79bixPBEFhjaeNjn21gWssm2sSOu+9OiNoPfeRNkgqOuM2ggv3xZc6qkJ8yjJvQkpOAjXcAYtFGhIaw6uIjoxN5rXpd0rJYqPHz36fN9xSkclLfutmZxjDiT7qlDuUwu0lhHGT0pTVGq+Re5OEzsao7ehdqciu0RsDtWmawRSoHHD8tNIkEuofD3yEfSvx9tiD+4bIhHrWee/0G9j4exQdRCvCnTJ8u+kL54IIjrATW8S0roXRDdXy1MqtyDoan0remchQG2lzO5lK6KsTOwWNFYEUAnUadORQFd2bN8YnQVlUa8CvUeWUgh03WwLKXiSMc9+n5Cm0QrEcNSUcUxSzM856Jb5+3VZaztLiiIhoD+t8hJW69OIg+0PIpJgP5Xpd7NzQLoCSlM5n6Xk9abm3BptUzCAAZYSzvbVdSq3nhkUDIk5hE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(8676002)(2906002)(66476007)(83380400001)(5660300002)(38100700002)(8936002)(66556008)(86362001)(966005)(33716001)(41300700001)(478600001)(316002)(6916009)(66946007)(6666004)(52116002)(6486002)(9686003)(54906003)(6506007)(7416002)(6512007)(4326008)(26005)(38350700005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJX86iGTDOvowEb0/NeaW0TqWMOc3KGy4sR/KEAzmlxdK6FoDdOKJgZskbB0?=
 =?us-ascii?Q?R0WuIT4v2EScDHfG5IecJ2LR/aJGkbj0aXi0dsAPAPoUNVuOrU8pXln8un1m?=
 =?us-ascii?Q?KrKqcR0U3wFx3SIJxGNADbm1J10ZwtFFz1pFzB7f3Qm9f0ahiu2PAYKdpuDL?=
 =?us-ascii?Q?wJCB5qZyBluPjgs8FJj5B9wRRm2OCA7XrO9osZ6+MPzMd9NV6XfkAelX1Nb4?=
 =?us-ascii?Q?R8BCWMwTMpPlk+6Mi0ihpN7fjKFsZh3wJ02Pvyl0ftNBef2lUWZ31CjE01dH?=
 =?us-ascii?Q?b+cVzPWVBdIi/LaHu8wviK9FzDEH05E/7YSBBVJo2KSZowX4PkWUcePL/XCL?=
 =?us-ascii?Q?3HYxjgT/6yDQbz7z2SYFzINH6DbQcJj5r/fSaKuCm3dxCG1651VgN31gWZzg?=
 =?us-ascii?Q?bA6xagbF/hQpbf7sgWIAMnuqwcxpptxUgLTXkqCmKGn1e4iPhzW9HxS2OMik?=
 =?us-ascii?Q?puiY4IfiVDLgd0r0mIDjRPWQxYVH3nRQSxwVa8XZ7W+InRzyNRoSMC2Bx/ZZ?=
 =?us-ascii?Q?2lHl7B9p7nYFI/kFvTtV8sYwTSNVLZNZbLqn65vpd+Z6MOZwTQeOJ3B8lz89?=
 =?us-ascii?Q?rZvt0Z7rzrjdowH6Dr+4uSehDz1ExYgfcLTAiYCtb4W55IJvJAi3qip8MKiT?=
 =?us-ascii?Q?3brwLpN/f+qCY2U4605d7wFFvDI0B11oX8syry8wOIyliMRxk7iP5VytHqF9?=
 =?us-ascii?Q?7aRagTPbhm1b0FdMRSgkQkIYnqHKmgvbU6Ya5Pfj6g0aHmowv5rOrJZp9Dsl?=
 =?us-ascii?Q?TzZnfUH6TpmVV80cLE0YsrRzRG0Y5hNSsdlO5UwIu35NNzDBJJk0cZrDpzy1?=
 =?us-ascii?Q?pl3nY5m4K8IsMgd/Jq+cy+2DXGhNPVLlv1JGp4kCJwssFbKfJg5IoJDIGCyk?=
 =?us-ascii?Q?B4B8ygKNgm9egnFdKFhoGbWdOfv++iXxmIFOnWlx8TP9uQRhyOyQFZ45kTtc?=
 =?us-ascii?Q?lSsckeTQXOa58o06run62btMLfwd1Amg1A+/cOOTLrpBNzat6Ai6JktUB76B?=
 =?us-ascii?Q?kMdLN/GLgNfNWolFjVpmnBkLGayVjOSZW93xxkPlw9Fl7N1CC/8LmYYrQzA5?=
 =?us-ascii?Q?b8AjQGH9hObB+1P6XqkJwLlJTFkq2bt5MXhEtw53L+KXVz39hlwb7XsnTyiF?=
 =?us-ascii?Q?xdhcAJupD4E5n+5j32U4lhVyMPCuBrQeBbOausjKtpvTfiJ12D1IAnumGT/6?=
 =?us-ascii?Q?S7obiV3Pxce9FTQU1gzxbpsrc+/PbM4RczOmmC6ii1yAVS+y8bXiS+cR6IW/?=
 =?us-ascii?Q?3roAOHN29tI/6Cp5i04C0gSw/ykAJYfIoho1fimDvmNCOa/HC4mLazw0haLc?=
 =?us-ascii?Q?gdlEdOxpuX5zE9VLskxZY5s41y1ZOgEfCOk5pnDJT+lbNkR7daMdMDJzLgbP?=
 =?us-ascii?Q?xB0Z4ORpmYvnCN2pVH1aEm+EQqL2VLg1U8t7d+Tdv5Hl9H+A9XwOTMSs9ZXt?=
 =?us-ascii?Q?qDuVU58UU+ffeMcZUOFsMzU0eswl1uqKVOG3bjCtl059Zh6jl4by/jtMaVu5?=
 =?us-ascii?Q?XQm8b3TdJe39PF2xvPsB+DhGuCVVegT8urLzvx3PSsDJ7YuUxKJDhrKocjSJ?=
 =?us-ascii?Q?jMeTISdSkOmnNJZS3a4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2345babd-8b6c-4e05-36dd-08dc1e2425a2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 04:06:18.3877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRvqWF9i8Th5qGqBqbAeybuZS7douoly+m7u9GPFEhAnF7eY+LLN2/U4gseoicuH/hB7dWsIWQASmAkQBcrVUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7078

On Thu, Jan 25, 2024 at 05:43:22PM +0000, Conor Dooley wrote:
> On Wed, Jan 24, 2024 at 02:17:22PM -0500, Frank Li wrote:
> > On Wed, Jan 24, 2024 at 05:59:00PM +0000, Conor Dooley wrote:
> > > On Wed, Jan 24, 2024 at 12:47:14PM -0500, Frank Li wrote:
> > > > On Wed, Jan 24, 2024 at 05:36:42PM +0000, Conor Dooley wrote:
> > > > > On Fri, Jan 19, 2024 at 04:31:28PM -0500, Frank Li wrote:
> > > > > > From: Ran Wang <ran.wang_1@nxp.com>
> > > > > > 
> > > > > > When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> > > > > > (or its control signal) will turn on immediately on related Root Hub
> > > > > > ports. Then the VBUS will be de-asserted for a little while during xhci
> > > > > > reset (conducted by xhci driver) for a little while and back to normal.
> > > > > > 
> > > > > > This VBUS glitch might cause some USB devices emuration fail if kernel
> > > > > > boot with them connected. One SW workaround which can fix this is to
> > > > > > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > > > > > host mode in DWC3 driver(per signal measurement result, it will be too
> > > > > > late to do it in xhci-plat.c or xhci.c).
> > > > > > 
> > > > > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > > > > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > > index 203a1eb66691f..dbf272b76e0b5 100644
> > > > > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > > @@ -273,6 +273,13 @@ properties:
> > > > > >        with an external supply.
> > > > > >      type: boolean
> > > > > >  
> > > > > > +  snps,host-vbus-glitches:
> > > > > > +    description:
> > > > > > +      When set, power off all Root Hub ports immediately after
> > > > > > +      setting host mode to avoid vbus (negative) glitch happen in later
> > > > > > +      xhci reset. And the vbus will back to 5V automatically when reset done.
> > > 
> > > nit: "will return to"
> > > 
> > > > > > +    type: boolean
> > > > > 
> > > > > Why do we want to have a property for this at all? The commit message
> > > > > seems to describe a problem that's limited to specific configurations
> > > > > and appears to be somethng the driver should do unconditionally.
> > > > > 
> > > > > Could you explain why this cannot be done unconditionally please?
> > > > 
> > > > It depends on board design, not all system vbus can be controller by root
> > > > hub port. If it is always on, it will not trigger this issue.
> > > 
> > > Okay, that seems reasonable to have a property for. Can you add that
> > > info to the commit message please?
> > 
> > By the way, I sent v4 at
> > https://lore.kernel.org/imx/20240124152525.3910311-1-Frank.Li@nxp.com/T/#t
> 
> I see.
> 
> > How about add below sentence?
> > 
> > This was only happen when PORTSC[PP} can control vbus. Needn't set it if
> > vbus is always on.
> 
> "This can only happen when ... controls vbus, if vbus is always on, omit
> this property".
> 
> Just a wee grammatical nitpicking.
> 
> > > On another note, I like it when the property name explains why you would
> > > add it, rather than the thing it is trying to solve.
> > > Named after the disease, rather than the symptoms, if you get me. I
> > > tried to come up with a name here, but could not really suggest
> > > something good. If you can think of something, that'd be good, but don't
> > > stress it.
> > 
> > snps,host-vbus-glitches change to snps,host-vbus-glitches-quirk.
> 
> I don't think adding "quirk" moves the needle.

I think "quirk" is reasonable because it is workaround.

Frank

> 
> > How about use below description:
> > 
> > When set, power off all Root Hub ports immediately after
> > setting host mode to avoid vbus (negative) glitch happen in later
> > xhci reset. That may cause some USB devices emuration fail when kernel boot
> > with device connected and PORTSC[PP] control vbus in board desgin.
> 
> "When set, all root hub ports should be powered off immediately after
> enabling host mode, to avoid Vbus (negative) glitches that may happen
> during xHCI reset. These glitches can cause enumeration of some USB
> devices to fail when PORTSC[PP] controls Vbus. If Vbus is always on,
> omit this property."
> 
> How's that?



