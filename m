Return-Path: <linux-kernel+bounces-138985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C4689FD05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F92128196E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491E617A933;
	Wed, 10 Apr 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iwLCy8It"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2114.outbound.protection.outlook.com [40.107.105.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08B176FD8;
	Wed, 10 Apr 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766957; cv=fail; b=FqZsfCIhzy+n/OMns4mzY8IesN2BvIy10jKi7n1mwCL0g+MMlmMpP8s551V18dChcx5Re4WvHY82gY39dtrezX8Oss6JYNGz6rB2ZmWczU64BTtYO++ftYc0aaGVL3H0Q476c+4UeNppgt1e2BAXQ2JshnxvdPwlLjLmhQC3MxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766957; c=relaxed/simple;
	bh=PVslibFE9ZhXLiWDhpaLymwOrVw+EF9iOvWK5Hxc0gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWwvxsMAbsULEydYaC8wsubm+2lVSEAbl4XAORq3iigd7IQoR2uB+/ppJLfA+b1gdE8FHCQ2v6U0vt9AIkd4K0ejmn4zU8160552hWCZyO1Zb8BnptTaLyFgd/UuPD2UeORwV10yTTL8Yf06ydGxHEXfSSpsb585OSoPnxevcak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iwLCy8It; arc=fail smtp.client-ip=40.107.105.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPfu1s2Os2olOBdRNt9oi1KiZKwGJugtzKvWY8B/zdKW3794g21wOZR3obGGtFE2KRBdbbbjHM8c6F3tJuIQ+2l9ItXXwEcPXSZ2YWehA3Llx2XJkjpLLvBc5BUzNHtMLWIQmoIOLignpUu8J33RAykV8AtFECwdG2F6Ivnm6Z2TP/YCvUYFCROz6noJmKGUuRHo0oiJrXe0L9Jl8kI8cx+KK2MOfXFND8b8X66g/8iLNEtq/3PZf8eGlsdS4WQ9SFK+1IKKaeS8Vb3uGV3DNAzhs6OtpvVVMBTQlOps9o6MTdpgVVJ0Fpo/m6phvrz97tNrFHxp4c5Wtd23R/WnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNDT8d2lq2iWjo1rdorTyo9MCI56lfg+PWhx+mrBj4E=;
 b=nteNsa+85Pk9aGWGlYv1DuGVuvh1iSX7DLtDpYHPuMk6EFqd1JLRh/2lbHIgmf4AdMZpagR5EkiEULMnc073T98RkTnI7HLXQlmq6rYbXZAX0jk0RhmCdOtZonEMH0J83+wprbfpQLMP+RoWuQPKXwqJ3pnshjfgb0ZJ/kiXOiQJx5s8j+8XAXNZkiZhVxIj8/eFpcEOdISVTNrFAJJc0ukojOb4JiQdL37j/QZ5Gww+P+so9nzn7u7/gfW4fD8uya6CyvqReL8MdMl9/Sj7e5DM/EUtaPdNGGhif/T4soP6DhyOWP22VlbEPBQz6K4BpcPRQIitjRyeWHoxVyHJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNDT8d2lq2iWjo1rdorTyo9MCI56lfg+PWhx+mrBj4E=;
 b=iwLCy8ItaSm9BQhfWfMBSYC8RYpyHot2lp/UhaVWhjpPNoPe43JU68nE6u4z1q7REvn0Booei28f8VacQnNvYVafl49oXBf7vR4eYpAdL7iz80mgalM1D4Y1ePb3XdkhKLu3FHtib4qb2usEHggQeVU0E5jy/ga8C5lLcf/cwmg=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Wed, 10 Apr
 2024 16:35:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 16:35:52 +0000
Date: Wed, 10 Apr 2024 12:35:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Will Deacon <will@kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"mike.leach@linaro.org" <mike.leach@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH v8 3/8] perf: imx_perf: let the driver manage
 the counter usage rather the user
Message-ID: <Zha/3tsYQMBI652O@lizhi-Precision-Tower-5810>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
 <20240322063930.749126-3-xu.yang_2@nxp.com>
 <20240409152627.GA23621@willie-the-truck>
 <DU2PR04MB882209413AB62531713166B38C062@DU2PR04MB8822.eurprd04.prod.outlook.com>
 <20240410154546.GA25225@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410154546.GA25225@willie-the-truck>
X-ClientProxiedBy: SJ0PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8638:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZZWBsf7UAMEK0GPvLzk4ie7u1j1K+A4e0ekgLRtppIlWzRLM/hj0QLsSOmW5EQNl/PU6IV/ahpOusSWpvive4H/LVQ1+UPlPmA8VNT+hMRRDqUEZS8Xvsv8LIg/4cJNyWwe14XPBF03xfq+VGRS/hZ7IdkQYfJeH7ZWaR4GqIGbCbbx1vh7T54cbKhbs0Nuo1OKg6Emes/5e6+5ue11EhndkC9n9s912XbYUdsrGLLCodxlag+BKCLhvZzcPTUyU4Nq5b5j4rAyR0SUUH3E+tfhpOVwjgueV09lz+ohAXY0tCYqn2ZbyV9zFcrx9bfoLOPG8e9T1d4OL/U6O+4DC8ALW+9YZluXcyvVfbXXz8Vk11u5QGD03HkelyaHm/IUDnskVpdN3FvHdCHbTW6tahpuK7+6fSmoMl7e+rx/lGm1TA1yOmdx5dQ7mwvGvXQsuGiHP7MNtwqExGviCnkEmlE88GBr8erZyPpKfaDjfDgYNQjbf1FrgnAWDTgahzCHqosRNSderx8IfDjty/ufdBO+Kye+m1+pX/Y5R8+n48gpMlt3be4uxmhBh++sU5+5Lcq2jm7D3H/cZnN1Vtayn/8MByBALboCFGL1TQ7VAQ8PK0lMfLFvNrt7uFoJXn/LMxkHLdpDgUO2LSEyBGdo24Tt/HGku2VMqdi1UQlZFKPwBwRWfSGAfgY4oKRix/f+2PKmnIFzUs//DP3VsVnTvnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaz5WuQ6C0wcmX0BR1iuc5kwpxUxKWkeQ3VEpDg6S24rqxyufcjvnZUAO5XY?=
 =?us-ascii?Q?t8JW8onf+NiSst2yI13gc6bk1mOptIVn34r/4AbLQNbc+EbXJxRyVga41GAk?=
 =?us-ascii?Q?B3AaV0O8nl3TQqCO8JPwhf1/TWG1IxyC6a88EOB+z/vD4SefPb7ecMycyMiE?=
 =?us-ascii?Q?LRHeETFQ0Yjig7MYo9LxWV43SWMMoooIvs7bxgBKKrunZGRr24GVem6F8JOm?=
 =?us-ascii?Q?XspmdrAOKbX63PDTgZHo1SEmP+Gwf5WQa5ZGsxUviCeltrwpYF9qFJSpAMhE?=
 =?us-ascii?Q?FN6FAGhPAnFUyPnvv2aP5OeeJhqX2wJLSATPp8C6RhRzrKECPptP9e9k3mz6?=
 =?us-ascii?Q?kG1xOG9fN04JZs1FwPSLGx4int1zKtFYJ3xDduw2ZeBE+cJc6+gs0GjyJaTY?=
 =?us-ascii?Q?m0flVELjFp4M61xl0WvPGR94RAXoSwD2ncw9t4colLdL0Fi8ccbZEtAxstnf?=
 =?us-ascii?Q?ZMZBfxHgd8Y04p0Q2/6BE9hIIFvkYfOZ+fgkNgUoW8MIEQNl8/kjyE7jC4bV?=
 =?us-ascii?Q?kiW0YzP+C4R6NaHSg1PA7sH4CxwGh3zC76UUMTEcM25uo6kk+kOYAaoXvhQA?=
 =?us-ascii?Q?ab5N2ANLykIpQcGZdyqSn8/A2yqINqdF0+fyhlDFLk7R59eB7kwJJI0JjYGX?=
 =?us-ascii?Q?KyyTUwyGbKv5Aq2ikkv3tWIZmmtiQ83/LhyBIDEBocGITkmWqGnkDUURwXQn?=
 =?us-ascii?Q?EqsiVZ/wJVQXMovRjemXmFEXxa11QvC8owWQqhXOoyeLgaW6P4/jF6ZIfzlR?=
 =?us-ascii?Q?o9TPeRKh725JJJj8Hz78tssACP/bo+L8fINIrY9hmTIbf/uK9WaHTJvrQ94u?=
 =?us-ascii?Q?uGdfGYa+2W9M7LoNWAFPK1tbFAzru/fjHj7mRvyxnEJrWmKAydPK5CjG4us6?=
 =?us-ascii?Q?6sb1OFDtUR4beSEcP3Zar5Uv9eAq7DDxBmUwbv39L/LvLwotdbp8Hy407ceu?=
 =?us-ascii?Q?9uP0x9H3zcpjMY80qs9dAT79v94KBTA5MSCtt14YZIkoRHnZGsgDOkvKU7JQ?=
 =?us-ascii?Q?e3qwQu+q7n5QpYZXfsPX3d5WFYfwzC8Yf+biAXK59kkIKFvhxRO0QG7G8fqL?=
 =?us-ascii?Q?h0QhrBJsiK6c+2iQaAwv6lYcca9JaSv/jfOKSe8p61264T+NR40lN30eOCs/?=
 =?us-ascii?Q?i0IfYGUK9v2fIJUrZTlOIO0l2xFTn36dkWJVewcgrP18Q4xQRg0IJbaKc+zw?=
 =?us-ascii?Q?Q+vwN2cl5cosUgpFz/O/6lZTlYiQh16gXoegBfAbZ7RY/x1ViYuugHIDv4F0?=
 =?us-ascii?Q?Rmy0VOzlZC4JRwcFl0VQh86XRbzljYrppBGfotQCRDjdHnlWQlUQA/X/4cWd?=
 =?us-ascii?Q?GYLxgiaOe1uuGBLI/HZMfG6mw9qzCPyMPzan2bHLXpB4FoVES58hudWs+kjF?=
 =?us-ascii?Q?KYffuOjAYx+b5jY6wu6YXjz4Zog1V0ASz9M20F+Ya8UqzZsGUj8GYLmUaAxk?=
 =?us-ascii?Q?+sSB/exRzipuTZYDmTHS7B8TKcB9YqWMUGFf6P7N+t4LbtNckfMeaRlCukfP?=
 =?us-ascii?Q?q7eYbkAWIDcCeBgftDHiDomVuQf+NdODCzfrjEpjKkyhZRgdvoo8ULbA1cWq?=
 =?us-ascii?Q?VwCTgYdZ3PHP4gSxss9+AWI3jXRRojSyMYw3w22F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a15624-7b81-46a2-bea8-08dc597c49a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 16:35:52.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9Ocy21G4TwlJNhKp+Ec/OEbA2YmSQL2vipVjo7sV4KaHTcq9bIDyzFfk50ZAgoJdUX9KW8QeJgtaQuR5fT+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

On Wed, Apr 10, 2024 at 04:45:47PM +0100, Will Deacon wrote:
> On Wed, Apr 10, 2024 at 07:39:46AM +0000, Xu Yang wrote:
> > > On Fri, Mar 22, 2024 at 02:39:25PM +0800, Xu Yang wrote:
> > > > In current design, the user of perf app needs to input counter ID to count
> > > > events. However, this is not user-friendly since the user needs to lookup
> > > > the map table to find the counter. Instead of letting the user to input
> > > > the counter, let this driver to manage the counters in this patch.
> > > 
> > > I think we still have to support the old interface so that we don't break
> > > those existing users (even if the driver just ignores whatever counter ID
> > > is provided in a backwards-compatible way).
> > > 
> > > > This will be implemented by:
> > > >  1. allocate counter 0 for cycle event.
> > > >  2. find unused counter from 1-10 for reference events.
> > > >  3. allocate specific counter for counter-specific events.
> > > >
> > > > In this patch, counter attribute is removed too. To mark counter-specific
> > > > events, counter ID will be encoded into perf_pmu_events_attr.id.
> > > >
> > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > >
> > > > ---
> > > > Changes in v6:
> > > >  - new patch
> > > > Changes in v7:
> > > >  - no changes
> > > > Changes in v8:
> > > >  - add Rb tag
> > > > ---
> > > >  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
> > > >  1 file changed, 99 insertions(+), 69 deletions(-)
> > > >
> > > > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> > > > index 0017f2c9ef91..b728719b494c 100644
> > > > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > > > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > > > @@ -245,14 +249,12 @@ static const struct attribute_group ddr_perf_events_attr_group = {
> > > >       .attrs = ddr_perf_events_attrs,
> > > >  };
> > > >
> > > > -PMU_FORMAT_ATTR(event, "config:0-7");
> > > > -PMU_FORMAT_ATTR(counter, "config:8-15");
> > > > +PMU_FORMAT_ATTR(event, "config:0-15");
> > > 
> > > Sadly, this is a user-visible change so I think it will break old tools,
> > > won't it?
> > 
> > For imx ddr pmu, most of the people will use metrics rather event itself,
> > and we have speficy the format of event parameters in metrics table.
> > The parameters is also updated in this patchset.
> > 
> > And to easy use for user, the counter should be hidden (transparent) to
> > user after I had talk with Frank. Then, the user need't to look up the event
> > table to find which counter to use. 
> > 
> > So this patchset will basically not break the usage of perf tools and will
> > improve practicality.
> 
> Sorry, but I don't agree. The original commit adding this driver
> (55691f99d417) gives the following examples in the commit message:
> 
> For example:
>       perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_trans_filt,counter=2,axi_mask=ID_MASK,axi_id=ID/
>       perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_trans_filt,counter=3,axi_mask=ID_MASK,axi_id=ID/
>       perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt,counter=4,axi_mask=ID_MASK,axi_id=ID/
> 
> I don't think these will work any more if we apply this patch.

Yang:

    keep compatible is important. Please try well's suggestion
    "if the driver just ignores whatever counter ID is provided in a 
backwards-compatible way)." 

    If you have further question, you can ping directly. Please avoid
use outlook to reply community email. It always append annoised "EXT".

Frank

> 
> Will

