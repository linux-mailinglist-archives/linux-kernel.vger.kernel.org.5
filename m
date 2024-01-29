Return-Path: <linux-kernel+bounces-43217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD60841109
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71ACA283A14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3264157048;
	Mon, 29 Jan 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kMfYRqH5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDA157E60;
	Mon, 29 Jan 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550132; cv=fail; b=T7p7cZIcaKOvgkOoD1YxUGsKeiaz87q+JXuFYXGSzQXHstNf1NJZ3qP60+Rxglgmy+iVrMRYoR5zecPx7nlxqPohfei/v8YDD2DWtBbfkp0nJMZV7TVapKD7E59AIybMglsHK8oS6wcb8HpjEiGQikoiWp7f2E2/CYneZrS7+T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550132; c=relaxed/simple;
	bh=PgUDlpWkhKiM7+RBCUahwzLxvLYtqt4AWASLiq3rodU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=anLvaGgmRrdd6xi77EzZh3V8+wq+ywtlIO41I9SufvqSDAND+3WWWvX2AaaC1fjpmRbIsDFZpbYmwohyxQZbFPmrnFReDf6WifbTUx26kMbmhfHURUPEO92BF1AmS9tx2d4o27vZ0wFOsDAHJZUTn58AsuO2nDig7wvU09CGO1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kMfYRqH5; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjoZm9oEPSizbTD1hUXu2qn9SG+E0H8OfyOeL/T3D6YwdkXwWC9Gfr41XNhyPAFwjd6OxcwryxK/H61Dwm3Hs+pqPA8QIFpC7f+Mcr4R/d3/rgdDlxIMqV6K3QRrf/opBFbnZbe8flYe3GVTPhcvZ01vVUEC7hL5N3zjW5wsF6UWVIkTrwcSkEA43Of7m3F2VX6IQFIDC5B1a6ttWc/+Cc1R9jGq5DUl/6rfg/J29YjwqwU9Jv0IdIJhUqoDakysJw60IfVYT+dUXl7VlwRDZq8nItb0ZXFmWfDKG5jtY1kDbI3DxUcBUiK0iGTnIfCg8fVjHaOeplprbBpiElDfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcEe9rDOI0d0OqgK/IUcDXjO+Wp9Jsluy8urzAnUPNY=;
 b=dJyIjB2f5JjPmIs63Trq/0m9YZkdFeOZLNWE8C/LFqDaWW8KzrZVuGhIPNclf+aBKmGrv9q237RsrDWLFzXQERhbOBzY5k0XHFdUSFwwfL3+3e1Us6ZxHnE5HGIN4zZsQgXF6DpFF1Etj4OvFZCE4gKRZ/g1wg2QjjeYea54IirdObV1eaRBKFLu8X0oTLcrBB7sSqGtt3aj8IPjWbcDh4qg7dRcvD5nGSEeA+0/vZ2OeDi+ncMBZbRJqz+SCq78dflKck6acmoqA3D244s+LjuYAF9k7SL+nERRAw3k4lledNg+DFGcChSq71mDFj2K7tF0dVN+5kewJAwtzdSyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcEe9rDOI0d0OqgK/IUcDXjO+Wp9Jsluy8urzAnUPNY=;
 b=kMfYRqH5XUgDVu9BUJnl02cWgF9y4bV6zhzwtFNMdZ81UzQfIZqAEOuz/goDlXuT3QS8+aOHgv6AsUoSsp7AY4RCv1ZJsnG/xWj7VfjzE5e1pk3nh5a11umn4i4QE0ukgIMSenDu0nO5d0ImJLEgUV9gmEBQNIgNULmsNzANQ8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9632.eurprd04.prod.outlook.com (2603:10a6:20b:477::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 17:42:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:42:06 +0000
Date: Mon, 29 Jan 2024 12:41:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	thinh.nguyen@synopsys.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Message-ID: <ZbfjZoHiH7BsKyzl@lizhi-Precision-Tower-5810>
References: <20240123-poking-geography-33be2b5ae578@spud>
 <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
 <20240123-anew-lilly-0d645bdbfb30@spud>
 <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
 <20240123-nanometer-atlantic-6465b270043a@spud>
 <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
 <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
 <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
 <ZbfB/KT+fzO/F2e5@lizhi-Precision-Tower-5810>
 <20240129-encode-catchable-f5712d561a47@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-encode-catchable-f5712d561a47@spud>
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d36698-3bc8-4208-5a50-08dc20f19cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EjZV7sJp82A4vqPr8F/9tB9Su2aTP8t49TnCfVWDzwb6FyD49wFbk9S0kOFH/LBbyzcH1zInOPKVgVeSHgEQBDWyEidjIj7rrshkWKNgkIEPbc0FMau9viLb98p3lqvrr6gWLGt3iZ6Rp48DlVVO2xi7Z9mAlRXI6gvZkHV/w7tTT317X9/UVFQZZLVtdu6iE9Hfft6iSFpvn6Bf6KwV5uNh4EPx3eWz0jyjH7DcgMkbj+Hv1i7BABWf7/UvB/n9JyQgVgEyG7gs7Eiqc2lqxWYk7pvIsyuNe3ImgnPzKgiT2ueLHcI3V8jaDbwa3y3vV4gphnF/nQ88G4M6HmT/QcZNw2dWo7N3itkBhqAhMObeVCXVMpvodPmHkWT/g0uIpB8ly5QGgkwGQJPXh8WNj9rF5+yRCIjTLg7Sw5VLnzpv446Yw3fugVw1uc9RnHN76I/wSsb1UGFtZ4P1sApCJs5H2RKRSNUt5/hBRHlLO/8fp2g8YWR52h9akb/d8DLLCza9W3RGgXWW6wnlRlgwBaPLoXOHpTkS4pr5scuRoyyRBMzXPxmUjRbG1q78XY+dwFCTyuzSJyxeYZNSPul3LwZCd9nMofo2QSLZreytMx9p3FRiC537EOOLjASsjrkK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(53546011)(8676002)(6506007)(9686003)(6512007)(26005)(41300700001)(38350700005)(4326008)(2906002)(6916009)(7416002)(8936002)(316002)(66556008)(66946007)(66476007)(5660300002)(86362001)(52116002)(6666004)(33716001)(478600001)(6486002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lk92JZCfVmPhlFj80T8Wskr4dKIMaKhndNysMj6IOaffYlzZqk9YCKx9roRE?=
 =?us-ascii?Q?M+vRdxtjkywZdtAL1XPUz8cy3WlHyDKSU7EZdMksg2sf9xypKbX/benHUYZw?=
 =?us-ascii?Q?3d4fXFcYbZB5OmD4UUNsJXebtCD/sz4S9O08Fc5FZMLJVQIWFDy891xPvxT1?=
 =?us-ascii?Q?LP85oHcGK0NZpHUGWqc2IPudaZ4soKK1rX5qxlcZqcODD3BVRIBsty9U4Mjq?=
 =?us-ascii?Q?6k12XwFl4iqIvvYWLpBJu/Xselnbe6s7GKxwZL8DavFvy0Vdb2/i2Dwpwr2n?=
 =?us-ascii?Q?rkBvGnJaiMb/uu18xToCGJDFnmrKsbX1HXj8lNKyT2lRz/XDgDPT3gePSrnb?=
 =?us-ascii?Q?JiMwmaeaj/8MR/b5h2kzzCisRhhX8ykT17A/0B8CHjfXAU9ssFM4a87CuYr7?=
 =?us-ascii?Q?iNxwA/NdJuPlL+ObciaDZUqK8UQOEPMPGHNHet4+/4saL+j9BOEmzZtPZG0k?=
 =?us-ascii?Q?JlmEZ7GU6u7C5eUVwTM5Pv3xPbw0SrOvGB0HIMOV8lOyX2HX/0WmJyFVAeOk?=
 =?us-ascii?Q?QhYoc33LqcDM7YiiuK2xy+u2XarzEkaQMnY5WR/awD+dwM7aZRXvPEK76Ur7?=
 =?us-ascii?Q?jYhSOX+EneIFJsCdyYGLSpMKElu0WjLS+Hn4z+1YpLGuumR8USkywKZmIpN7?=
 =?us-ascii?Q?sgUX246EbKUXiheUMaonnS9xghEDeXyxBrumU2HKQttFqaFlHy+g3K/80nea?=
 =?us-ascii?Q?8BfPDWocSXBYCdbvKaEu+LUD2qkW5ICX2qw+81ApYS0VYswFi7PWygZlYb3r?=
 =?us-ascii?Q?7zd/w/ZIwy5roqC3d0R+vW23TaJkh/twsv1arl50iTuA94mkbn5H/lxMdzFR?=
 =?us-ascii?Q?zOhZFsj5jue7zjoKMEL52ES14V468vghvJ1u8n6gj33Gmz1TLG7YK9nPbC9j?=
 =?us-ascii?Q?xYCq5wDhe90CyK1I7mvFa8YXlEyHPnbPNYCXARZYlF4Zko2f4Uh1HBFXxvNc?=
 =?us-ascii?Q?E2MAeZB/tUxZPtmv2wAtRHXLARk77ZMRvgmhcwDoO+JnKpBBwXqJR37YQno0?=
 =?us-ascii?Q?vsOGgF3IVjd0/uxmY1mVYU82rPWvwWWt9AX6IudqEWZm4po9dlV/VoI8KzH8?=
 =?us-ascii?Q?JpyHACbNneDyY/VdnP46i8MvOPBtOYb4yTYc8MUB4uWqxyr/RsSdBbT2XTzP?=
 =?us-ascii?Q?EKmXckNKpsTA4AQhRh22Vg1TOAd3b/WqcgH5M4Kzb2glwHwMfHDZDWtbM2G/?=
 =?us-ascii?Q?Gvo0Y1SL8n85wapBGxq4R8fF4Uz38wMuD52XdSqpVZPBWdMD6KD026WkC4JI?=
 =?us-ascii?Q?THjQvSbEPhMC3SvHfjBNYyb0DeD3dHBBwD0l7DWQRAKbeO8WnvubqelxvtqE?=
 =?us-ascii?Q?GdNyCS0AWriCayKKm4vE5AKBtLuCiKPyyf1oBGUK8CDLGUOeTfwBJuH03tKR?=
 =?us-ascii?Q?2OYVcAqCkvXwZm98mS6O/+HApGHozU0NADVh4bixM4eYvaTUv+OQUxZsIshT?=
 =?us-ascii?Q?BZ25TBqfxYFl9l5fledPZWav2hn9GPR51gw/AcbA9ZYd4nMeVF1j7qZV0E16?=
 =?us-ascii?Q?xrC75U0f5IzQBYB3dXdiOH0GYDWgoRRGKki92YWHeNKrQ7OwANLImLpufwZ6?=
 =?us-ascii?Q?ZfBk53GPXh+ceB/oowvYL4Ni1yrFHI5TuGtA3K+3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d36698-3bc8-4208-5a50-08dc20f19cb4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:42:06.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUrwqVjrWrpbsfLGckFX4Bsg/cHUJtCKDMZleZCU7PbU/EGIB3XaFoud+I6QeeH7pCtQUjAt4MBaNDzdcaOJbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9632

On Mon, Jan 29, 2024 at 04:49:21PM +0000, Conor Dooley wrote:
> On Mon, Jan 29, 2024 at 10:19:24AM -0500, Frank Li wrote:
> > On Tue, Jan 23, 2024 at 05:23:53PM -0500, Frank Li wrote:
> > > On Tue, Jan 23, 2024 at 10:46:39PM +0100, Krzysztof Kozlowski wrote:
> > > > On 23/01/2024 20:22, Frank Li wrote:
> > > > > On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
> > > > >> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
> > > > >>> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
> > > > >>>> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> > > > >>>>> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> > > > >>>>>> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> > > > >>>>>>> Add device tree binding allow platform overwrite default value of *REQIN in
> > > > >>>>>>> GSBUSCFG0.
> > > > >>>>>>
> > > > >>>>>> Why might a platform actually want to do this? Why does this need to be
> > > > >>>>>> set at the board level and being aware of which SoC is in use is not
> > > > >>>>>> sufficient for the driver to set the correct values?
> > > > >>>>>
> > > > >>>>> In snps,dwc3.yaml, there are already similary proptery, such as
> > > > >>>>> snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
> > > > >>>>> driver keep consistent. And not all platform try enable hardware
> > > > >>>>> dma_cohenrence. It is configable for difference platform.
> > > > >>>>
> > > > >>>> When you say "platform", what do you mean? I understand that term to
> > > > >>>> mean a combination of board, soc and firmware.
> > > > >>>
> > > > >>> In my company's environment, "platform" is "board". I will use "board" in
> > > > >>> future. Is it big difference here?
> > > > >>
> > > > >> Nah, that's close enough that it makes no difference here.
> > > > >>
> > > > >> I'd still like an explanation for why a platform would need to actually
> > > > >> set these properties though, and why information about coherency cannot
> > > > >> be determined from whether or not the boss the usb controller is on is
> > > > >> communicated to be dma coherent via the existing devicetree properties
> > > > >> for that purpose.
> > > > > 
> > > > > Actually, I am not very clear about reason. I guest maybe treat off power
> > > > > consumption and performance.
> > > > > 
> > > > > What's your judgement about proptery, which should be in dts. Such as
> > > > > reg, clk, reset, dma and irq, which is tighted with SOC. It is the fixed
> > > > > value for every SOC. The board dts never change these.
> > > > 
> > > > Then it can be deduced from the compatible and there is no need for new
> > > > properties.
> > > 
> > > Okay, I think "*reqinfo" match this. When new Soc(using compatible dwc usb
> > > controller) appear regardless dma-cohorence or not, connect by AXI3 or
> > > AXI4, needn't add new propterties. 
> > 
> > Anyone have objection? I will prepare v2 to fix rob's bot error.
> 
> I'm not sure what you want me to object to/not object to.
> Your last message said "needn't add new propterties", seemingly in
> agreement with Krzysztoff saying that it can be deduced from the
> compatible. That seems like a good way forward for me.

Okay, let me clear it again. dwc usb is quite common IP. The below is
what reason why need "*reginfo* instead of using compatible string.

1. *reginfo* property is decscript hardware behevior, which will be changed
at difference SOC.
2. it may change at board level according to if enable dma coherence.
3. dwc core part is quite common, all SOC using common "snps, dwc3" as
core-part, all soc specific "nxp, dwc3 *", "qcom, dwc3*" is used for glue
logic part.
4. using *reginfo* can reduce add more strange compatible string such as
"nxp, dwc3-core" ...
5. *reginfo* property likes "reg", "clk", and align what Kryzystoff said.
"reg", "clk" is fixed for specfic SOC. These can help reduce "compatible"
string number. "reginfo" do the same work as "reg", "clk" ..

Frank


> 
> Thanks,
> Conor.



