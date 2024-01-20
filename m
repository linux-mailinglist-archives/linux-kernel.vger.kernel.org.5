Return-Path: <linux-kernel+bounces-31673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A5D83325D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAF71F22B4D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0249ED6;
	Sat, 20 Jan 2024 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kVOO+KTb"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174561366;
	Sat, 20 Jan 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705716017; cv=fail; b=UPl/G5Hmqmac4dvFJwzZcEcjw8EdJqdR4oeXyt2IpAzgJHbio+XDU+VRNQGQaFkq9uo5cfi1vm6IzQPX5PSLhcU5DIZnPQNqAyhir0no4/9UqzV0J0+T1IdGbAWI4ZEj5Pqj05QbFXJwx2jqlwGY44rkNz50PZ13RGdp9Zk5G90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705716017; c=relaxed/simple;
	bh=pzNcUnCOy8HMswGRlFuzsgks3pH/mhoMSBuNCV/VUYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W0tw6JvVg/w58sfbVBtD4c8XkazV8BLftMsxVWtx6ei6fe9ZpvrQ+MCNJD18P0yYdz8NG9V2Pw7lG6IPrvc62DITBJ31IKPLStXV7H2wDNhwyUPzTJgwFEj31O1dZBMt8TeVhRHiN9gTLR0tD4vhaYpcf8Wx3zxOvi1CmjACT7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kVOO+KTb; arc=fail smtp.client-ip=40.107.105.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdy/ocjtCNOV2st/Zh/8OKUSM2GUnSFth9gCHyobACdgzMXnqNfxr+kwjnz5zxiwY0lCrSs1zhGSSEz6nq8twreTkh2U4nI4MJcim5yjjaWNGrX8RVjo2f20kzYEESGFLmDfKcl8StnoiM2OsczF83HzPv89Y3cIFjY0ZghZiotVQ1V0UzhtzUIMgALMewJATJ1ZNy4gtW6Ny/kKhCMQBKDuFGglWNhfkgIkRHO6NnToZCzDi6iyu/GopPNqBkblukHy87zwjH0KmkRtAaVuR0vAnLo1Zje8ulZiIwyuUctYcjL/p68tB6q4j1zBDYKhLBzGCcGMvl7cq5vbgVSN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3dkbQ24SftEdaJ7uO6TcLD4VjaG+v0221T8bUpedsI=;
 b=Hx/foYSwyBnpMSGfYL/REolBZR0H/KFjDgplVo5+r9+l62q/he3XvgbLpw6cSorbBXab2RBqgsGh9mZh7HE7fq6UTC02jKh3QDFEoHpWE214iy8A2lDFwf5wZiEa1Sa+OmZYKPnmzsq8lKB3CPaW+oEOHHLIQyWbq4oOfFie1VWw14wgVdjOmYJE3tEC8GycNxHFX8VnckxxfCHdE02GseySauU3OeTJS8THQ0nIl7Ga+ZM7+lInVGojg6qdo14+PcyNws5d0HbW19iTopWLCRgArWyU0R7ZzZt47/fNH5uF/jKmSF5H+eSUFCZkQQclRWk44uTwsTwl1N/9W4QUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3dkbQ24SftEdaJ7uO6TcLD4VjaG+v0221T8bUpedsI=;
 b=kVOO+KTbeGkb7Qr0X4H8nS/uU7yTzspRMCxp6gs4y+hqPWbDo097cRiKs4zR1wPeCrGloUeB2XMNGgFsyfT+UKDMbxlSl0RiHc86EC+dJSXhjhPSE6j3z0fpGkT3IOsMkcKOGNy5JC2DFfMCg29wlmz2b62Pg3qU6or0ca0SxKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7785.eurprd04.prod.outlook.com (2603:10a6:10:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Sat, 20 Jan
 2024 02:00:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.027; Sat, 20 Jan 2024
 02:00:11 +0000
Date: Fri, 19 Jan 2024 21:00:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "ran.wang_1@nxp.com" <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open  list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"balbi@kernel.org" <balbi@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"pku.leo@gmail.com" <pku.leo@gmail.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Message-ID: <ZaspJOFsv8+j7Mp+@lizhi-Precision-Tower-5810>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240119213130.3147517-2-Frank.Li@nxp.com>
 <20240120005056.o52hqn2sershhm76@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120005056.o52hqn2sershhm76@synopsys.com>
X-ClientProxiedBy: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f435a7-ecff-460b-921d-08dc195b8949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TtNZowom18n6gM9OhK1w71UojHWJ8XzJyJpun/3wvAcseGh+1tYQs6nO+Rf6wZwsRA3qQg6IJmDih4TyKD+p+GI8wBOwOKz9tTwtXXDPKG3V+x96II7HH9iCOIjz5Xb8PrF5yx4hOoEBLe4ONTSYgsMY74+BNU66+xZHwKzIr/5etQ8ovqHTsFzRehjSls+Yw607ZHjoYoKcl3L2jerCdvg3QpIf/1GFYRA640Heo8VjrZMFPmelDZC36w0JvmzzwgUXaDWj/GMybZLP/+zkjatf1d0PN9Eb1e0+FcTH4ZafLQQ16lm4moyuXd09ZfAsrBwq0cdywql5KAg+X3533T2Sx46Uyv5Avy4FaEiXKcRls1AdAAa7MBIyN2dW1v3LEmJKuTmCTNRDvSzZuj925y1rL7NyJh4eMYIJWEh+TXLM4d/W9o64agU+UGmkpzMd0XFmMiQ1BjmFBxNFV3hi/2FqO0rsbcOP3ywP16Czylb84DzZobDc3sotjETRWSvSQkImiItf5Z+6FX2oyRvqUWrNwQZt0xHqSMlQRho7jzegkyPBBTnphlRZ3lFqqKsXvBYEeTqt6Vrs9pjbCe0pKLdD8kwxf7gd7i2kW9Sv3FvpLQmy//8CyyGICpoKuhYHVKXHOOqGnxE2cXxEfWCY9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(6666004)(41300700001)(45080400002)(966005)(478600001)(6486002)(6506007)(52116002)(83380400001)(26005)(6512007)(9686003)(86362001)(2906002)(316002)(6916009)(7416002)(38350700005)(4326008)(54906003)(8676002)(8936002)(5660300002)(66946007)(66556008)(66476007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPKOu77hU5HLMlK/GhePvCgxETmmGqS5AqAK6w8v2JabgKrB7kK2/kreVASb?=
 =?us-ascii?Q?sdaVnudHy40ksf6H+bZX5x7FoKCW7PNbhsJUnTbB0zOzuPhAx5XyryvBaxeL?=
 =?us-ascii?Q?wRARn0ypdmtUzXpsE4+RpJ4DjtXt/T0qRU4mSRTtKiz3fF7sHQ0w8NTLnyQ7?=
 =?us-ascii?Q?L6QCdWF/rXRibcMIOjBwNyHsn4Q1h2GhRUzrmJl4haYOnwTpHUPVKqRNk5Rd?=
 =?us-ascii?Q?uyOBNxnDD0afkxZu2IPdLuurrZEtdX5I3pRD1WqeX1u0R/yVickO+D/GDCbQ?=
 =?us-ascii?Q?0L8LsRG4tpiNSrSLccbzGcjOykqpwDzTsPbS//c8gyTCU4JZTvTWyvXljgKJ?=
 =?us-ascii?Q?Bz/4aQWvLtuFTeWHOdOCKBDaHrdhEzEQnMt1kNtpQg5hSClfbJ8ua5kVds1P?=
 =?us-ascii?Q?8Gvj7o/3Of9Ts3Gt+ePJvib26jIDF+t2iag6DLaotsdKhJv80lCLcRKQDL4+?=
 =?us-ascii?Q?9jDOasBs0wYhV2IlO5T+NYh7B35q1bLE37MAkC6bzks1zDb+tCjgGc+WrvkL?=
 =?us-ascii?Q?v3IR7JdiFtMMTguNiTEEFsb69e6iNS+WzIcIHbP3dDQGgULhZ5q8A3gX2Sve?=
 =?us-ascii?Q?awSdQ1ecrk+Z+TeoFjOvMchwEMQJm1EtFGYI6MGQ3cUya7ggRUFnbWOpsiXi?=
 =?us-ascii?Q?yzujtKIfGEZvnhIy4uamJNykcjJq6/oUOB0dLj89Tth20U+m2HU0HwIpRpHe?=
 =?us-ascii?Q?4s1wX5V9omlcwbA9u7wBGg8ih8l8wNX3SOtk1s8/RL8yJc1VlPYQkxf6jwMi?=
 =?us-ascii?Q?rAT5k5EgG0WriigFavKdI2Amm6mjV1egrRVHLUpq49+YQfwjKUvyqZ83lUN1?=
 =?us-ascii?Q?HeY/2ytdv6ppNYytPA65esH+YAXTcnGra17yWUQI12NNwzE6U3e+9JK/H2lO?=
 =?us-ascii?Q?uijV0Fu514SesY8poyNLoo1+FRi82DirypLEITwCLM/EnaTMVW03XYuo5c/B?=
 =?us-ascii?Q?+LS22dRRk3QZ6DU9cInCKhxcURSdkoV8Mqm6kN4zxq+o0oD6qzdf3H/uYEqT?=
 =?us-ascii?Q?MNQJ8TQAUMYxN/vpuDEl2it6EoI0NujrmJeiud22GlxgqZVSYLA8vMyGD9EP?=
 =?us-ascii?Q?8VOxXpdZ1Jg/fNaIhu/7agt4nG81vAF7okZLTRTToYWtJr0AhNA7v24pRM8B?=
 =?us-ascii?Q?7SeBBiHHzn4PeB4blBUPHIheAo3K7ugXRNb3bowrR/1WYvEgBbPEObVJNsOH?=
 =?us-ascii?Q?pXs4XcFr0j+EpEnllkbUAxNSXGDtQYBmO1yUMMwEpUN+FvUxrHiZ3IWeJqnO?=
 =?us-ascii?Q?JH6x8LQHM1J0s09Jw6DvnYtPxzik5r8aOPDmwCpY1fXC4PRRp4peFwaCZVCR?=
 =?us-ascii?Q?tRRWoiIXIYo2OE866kh2NT1G8f0JnAyiv76W5aBSK3glOHuHlda/+q1/on4+?=
 =?us-ascii?Q?6StOtFhTVJ3UJbkQ7W8PyUoB7ZR7ZNLTUdD/LL2RzZ05DvK1XLyuf6qa5+iV?=
 =?us-ascii?Q?qss1acVHibsuj+WZhL5ZxnZD3s0qoXeO95EivFJEEwLAchztU50JQ2v1DdRd?=
 =?us-ascii?Q?Yn2jV1EvLQEBIK04MVySZORPTA6HtQqlPd07xKyeHg8v22lR0Fvw736puHON?=
 =?us-ascii?Q?owm6jwR50K3LnyqF09NvJwsodLHddFe2U5JYv51o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f435a7-ecff-460b-921d-08dc195b8949
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 02:00:11.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+yPsqOmnjZGvujQqThgPG4D9IXyoWj10qUK8TW50PFwNr3NbRIjkESQhhEKVw8WUeHNQwdZ0xmqbniUxmOCZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7785

On Sat, Jan 20, 2024 at 12:51:07AM +0000, Thinh Nguyen wrote:
> On Fri, Jan 19, 2024, Frank Li wrote:
> > From: Ran Wang <ran.wang_1@nxp.com>
> > 
> > When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> > (or its control signal) will be turned on immediately on related Root Hub
> > ports. Then, the VBUS is turned off for a little while(15us) when do xhci
> > reset (conducted by xhci driver) and back to normal finally, we can
> > observe a negative glitch of related signal happen.
> > 
> > This VBUS glitch might cause some USB devices enumeration fail if kernel
> > boot with them connected. Such as LS1012AFWRY/LS1043ARDB/LX2160AQDS
> > /LS1088ARDB with Kingston 16GB USB2.0/Kingston USB3.0/JetFlash Transcend
> > 4GB USB2.0 drives. The fail cases include enumerated as full-speed device
> > or report wrong device descriptor, etc.
> > 
> > One SW workaround which can fix this is by programing all xhci PORTSC[PP]
> > to 0 to turn off VBUS immediately after setting host mode in DWC3 driver
> > (per signal measurement result, it will be too late to do it in
> > xhci-plat.c or xhci.c). Then, after xhci reset complete in xhci driver,
> > PORTSC[PP]s' value will back to 1 automatically and VBUS on at that time,
> > no glitch happen and normal enumeration process has no impact.
> > 
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Last review at June 06, 2019. Fixed all review comments and sent again.
> >     
> >     https://urldefense.com/v3/__https://lore.kernel.org/linux-kernel/AM5PR0402MB2865979E26017BC5937DBBA5F1170@AM5PR0402MB2865.eurprd04.prod.outlook.com/__;!!A4F2R9G_pg!bdutJWi1Tcz8SYscB7Mr96SWYMKIo8ElUKgEILFJfK3_60EbECQHXPBmJYAMMhNwQ4YrjxqMZWHdokXhHB6a$ 
> > 
> >  drivers/usb/dwc3/core.c |  2 ++
> >  drivers/usb/dwc3/core.h |  2 ++
> >  drivers/usb/dwc3/host.c | 46 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 3e55838c00014..a57adf0c11dd1 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1626,6 +1626,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
> >  	dwc->dis_split_quirk = device_property_read_bool(dev,
> >  				"snps,dis-split-quirk");
> >  
> > +	dwc->host_vbus_glitches = device_property_read_bool(dev, "snps,host-vbus-glitches");
> 
> This is a quirk. The property should be named with "quirk" subfix.
> But do we need a new quirk? How many different platforms are affected?
> If it's just 1 or 2, then just use compatible string.

more than 2 platform. I think quirk is more flexible.

Frank
> 
> > +
> >  	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
> >  	dwc->tx_de_emphasis = tx_de_emphasis;
> >  
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index e3eea965e57bf..0269bacbbf6bd 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -1135,6 +1135,7 @@ struct dwc3_scratchpad_array {
> >   * @dis_split_quirk: set to disable split boundary.
> >   * @wakeup_configured: set if the device is configured for remote wakeup.
> >   * @suspended: set to track suspend event due to U3/L2.
> > + * @host_vbus_glitches: set to avoid vbus glitch during xhci reset.
> 
> This is only applicable to the first xhci reset in its initialization
> and not every xhci reset right? If so, please reword.
> 
> Also, please place it correspond to the order of the field.
> 
> >   * @imod_interval: set the interrupt moderation interval in 250ns
> >   *			increments or 0 to disable.
> >   * @max_cfg_eps: current max number of IN eps used across all USB configs.
> > @@ -1353,6 +1354,7 @@ struct dwc3 {
> >  	unsigned		tx_de_emphasis:2;
> >  
> >  	unsigned		dis_metastability_quirk:1;
> > +	unsigned		host_vbus_glitches:1;
> >  
> >  	unsigned		dis_split_quirk:1;
> >  	unsigned		async_callbacks:1;
> > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > index 61f57fe5bb783..af8903ee37c20 100644
> > --- a/drivers/usb/dwc3/host.c
> > +++ b/drivers/usb/dwc3/host.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  
> > +#include "../host/xhci.h"
> 
> Let's not import the entire xhci.h. If we're going to share some macros
> from xhci.h, please split them from xhci.h and perhaps create
> xhci-ports.h for dwc3 to share.
> 
> >  #include "core.h"
> >  
> >  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
> > @@ -28,6 +29,44 @@ static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
> >  		dwc->xhci_resources[1].name = name;
> >  }
> >  
> > +#define XHCI_HCSPARAMS1		0x4
> > +#define XHCI_PORTSC_BASE	0x400
> > +
> > +/*
> > + * dwc3_power_off_all_roothub_ports - Power off all Root hub ports
> > + * @dwc3: Pointer to our controller context structure
> > + */
> > +static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
> > +{
> > +	int i, port_num;
> > +	u32 reg, op_regs_base, offset;
> > +	void __iomem *xhci_regs;
> > +
> > +	/* xhci regs is not mapped yet, do it temperary here */
> > +	if (dwc->xhci_resources[0].start) {
> > +		xhci_regs = ioremap(dwc->xhci_resources[0].start,
> > +				DWC3_XHCI_REGS_END);
> > +		if (IS_ERR(xhci_regs)) {
> > +			dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
> > +			return;
> > +		}
> > +
> > +		op_regs_base = HC_LENGTH(readl(xhci_regs));
> > +		reg = readl(xhci_regs + XHCI_HCSPARAMS1);
> > +		port_num = HCS_MAX_PORTS(reg);
> > +
> > +		for (i = 1; i <= port_num; i++) {
> > +			offset = op_regs_base + XHCI_PORTSC_BASE + 0x10*(i-1);
> > +			reg = readl(xhci_regs + offset);
> > +			reg &= ~PORT_POWER;
> > +			writel(reg, xhci_regs + offset);
> > +		}
> > +
> > +		iounmap(xhci_regs);
> > +	} else
> > +		dev_err(dwc->dev, "xhci base reg invalid\n");
> > +}
> > +
> >  static int dwc3_host_get_irq(struct dwc3 *dwc)
> >  {
> >  	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
> > @@ -66,6 +105,13 @@ int dwc3_host_init(struct dwc3 *dwc)
> >  	int			ret, irq;
> >  	int			prop_idx = 0;
> >  
> > +	/*
> > +	 * We have to power off all Root hub ports immediately after DWC3 set
> > +	 * to host mode to avoid VBUS glitch happen when xhci get reset later.
> > +	 */
> > +	if (dwc->host_vbus_glitches)
> > +		dwc3_power_off_all_roothub_ports(dwc);
> > +
> 
> It's part of the dwc3_host_init(), but don't do this in
> dwc3_host_get_irq(). Place it where it makes sense.
> 
> >  	irq = dwc3_host_get_irq(dwc);
> >  	if (irq < 0)
> >  		return irq;
> > -- 
> > 2.34.1
> > 
> 
> Please run checkpatch.pl and fix them next time. Regarding
> PARENTHESIS_ALIGNMENT or line continuation, it can be two indentations
> or parenthesis aligned, whichever one makes it easier to read.
> 
> 
> From checkpatch:
> 
> CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
> #119: FILE: drivers/usb/dwc3/host.c:48:
> +		xhci_regs = ioremap(dwc->xhci_resources[0].start,
> +				DWC3_XHCI_REGS_END);
> 
> CHECK:SPACING: spaces preferred around that '*' (ctx:VxV)
> #130: FILE: drivers/usb/dwc3/host.c:59:
> +			offset = op_regs_base + XHCI_PORTSC_BASE + 0x10*(i-1);
>  			                                               ^
> 
> CHECK:SPACING: spaces preferred around that '-' (ctx:VxV)
> #130: FILE: drivers/usb/dwc3/host.c:59:
> +			offset = op_regs_base + XHCI_PORTSC_BASE + 0x10*(i-1);
>  			                                                  ^
> 
> CHECK:BRACES: Unbalanced braces around else statement
> #137: FILE: drivers/usb/dwc3/host.c:66:
> +	} else
> 

Sorry, I too trust original patch author. Will fix next version

Frank

> total: 0 errors, 0 warnings, 4 checks, 86 lines checked
> 
> 
> Thanks,
> Thinh

