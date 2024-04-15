Return-Path: <linux-kernel+bounces-144501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6928C8A472A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8BE1C20AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014B51BC5C;
	Mon, 15 Apr 2024 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ESvEjs4z"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A81C11;
	Mon, 15 Apr 2024 02:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149906; cv=fail; b=Nqm79cHEtuZwU88GLzxG9Zit3Q1P6S9OGUYUCutOTfvvnpDNIC5NjtbRZWzwejYNbBqyDtJKKO7g9pjV7Oq/iFWBr/EK6NLslIsQQESccwc4YYZCmd0YbxcPE4FAZ0KTH0b+4gxWaI4w+Mdif/Qx/vhHLR+bNzkaIDqecBDoqjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149906; c=relaxed/simple;
	bh=KajSwJg1z026QSusc9qWvvLBsa2aprLBfQSOtcrSv7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rLcALIfCYXi2+0649h+FceQAUfKOTEbTdgQBujj43rJ30spm8Tq6GSzi3aW3qnLQmZYjTludGPq/OnO4slAEgbj5sLMz9kDoDCC1ssgqdA3SBP+wWc6Rw20N/NvltM4iuCEyIz0j6tlaIJxRfIqjUR4T10fjTxmmX8RvGHGiT7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ESvEjs4z; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EotqJBd4kAfAawEYLs3dqQ5iRoAsUreAEz6qGX3BCNtxJlwzbG08oA6VUnDI+sDotxh2M4cCwCEcolxge+MMkB75uTBP2JLG3hfIN7MS71OYvo+mm81C/JzhIKCVdcpGas5gnHJkZDqmAdlvYxoBquqc0Sz9rrFkRxwOJ0yS4IvqiWZQPEOE2XDEkUM0zX8b9VkiltPiyEviMF8QHlPcicsBcrF5S5/hdyEBCjlY/5/X2WwSiempLem6NP/EsIz9ss8hufXl45vaVBPsYIrTv6b9JHEv1xfYOnkIQVBJrpwWpE4ghP8tBCYdHC5XK0sfGkR5ZJSCLqDw0y33oY/HYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBYnFe+FDOgDwIN3LIHof+yW8+lo+85tO1NENK9N2q0=;
 b=oTZLh9fBN47JhOpyyJSWpxPPao69KQzBlZvjZ4OmphNMT6rNSsjoIRTbNcO3IwDUwOWJQiRDzkAD7kZThQSG2ccCVZpGt1i/hp/GAmHjN0cNrQ7koJ39WSQht+/Jvfg8TtMzND9j1B8Yk0u7KiDbWLZFw2jZKp1mffLXjJ8NghdfQKu64Z9oe2nhATshtoc61myWsftvRn7CrrppYlVTRKHzocsiMjWUOjfgSPdz44DcmRYxd9BU94YAfPmqk724V7y3SRteNHU/frS3WR2K+qIodZ5sTFKjI8epYYhtAxxw+qhBuRE1H1Xdpk7BGFPnPUtSSOxX4jAHZboeZzLWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBYnFe+FDOgDwIN3LIHof+yW8+lo+85tO1NENK9N2q0=;
 b=ESvEjs4zQAfGVh8V51ij605SHn71Alxso5tXmNqPe++MrkuvAB5hCaEzdnybFBsJI/sxAcTKAu3rNKJ7xV3aukb7vrN9MAbluJcy8rDC6npoeA4lEPShue+eTDC1x3X3nJ/GOTv4CdzESWh20XV38s+pKbhFZ0LCBLATchN7CNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 02:58:19 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:58:19 +0000
Date: Mon, 15 Apr 2024 10:57:19 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: will@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v9 3/8] perf: imx_perf: let the driver manage the counter
 usage rather the user
Message-ID: <20240415025719.f7kstterbr5zsips@hippo>
References: <20240415020353.3833367-1-xu.yang_2@nxp.com>
 <20240415020353.3833367-3-xu.yang_2@nxp.com>
 <ZhyU/ZSByYz3LRsm@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhyU/ZSByYz3LRsm@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VE1PR04MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e8fcec-c412-4b2a-b9ec-08dc5cf7e798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I8cJXz5oG7D9gOt1Ef2BsricdMc5v/54CVKEJbIiTH9/tg/fZE3Yje8Rov0PNb29Omjl/83A3D9zesudlaW1ZWDk935HhLGja9944NJaGFz3eYVdkVxvPVHHlfjQQOC5zvScgPoqPdNWB7hZbM6GHEOFu6Am6VanCMDA05l8cPffPpYCNT+/L4GHgOX9VYK+s9w0CYmCM8wFT31CxXMhgJdAg68Y9BmPWkKvwSuKUcvxwonIxrj/nV4dhP2tSCY+5lvlZrLkSMM5KTZMVCaWkdqDFLU/QjcgLFe7+4gn6DfwZ6U6m83i85nOu25OWgxYGqG94ds1KLEEFKpV4SFTU6OMlTH9zDfTgMEcvAXpjTnuQesKHeLEVeK0XVP+hHrKVARUjeOjTKUtZ5mQuMrekfWwdGuSVFdiwZ0wOqgcZa4e7o30BLV8/8OYhm28qCIcU/z50GBdBGXy+4YJc9jUg/GGakTIgKiPFyNl5DOPiOizl3Y4Auj5TqJRn2sBT9kVCA30m4bQ3xbB0ggrZeBalgMxnDTqf860ABUc5F4FTGufbEXQw8TuPdjWg/6Sd2c9rNiF+kl+KGDY2D+OI+hE4fSC8AyUF9oxDhGM1LwW1vsN5xttoTaJCbT3eXb3yC5NnWnWQNWDF8tfh8rNwy2SXUG7P352xmhQY4KwFfi6WY/YJkjwUhvVksGMbGYc1qfKm1PlK4lPYGvqaO/4+ce0GM3FkiwneyUHtBb4Dp+l1dE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMmTrBWyKqSbm2jqJNGP81jBV09ZCkeK2ZVzzgM6bO+FTU6Cg2+cPhbWR43k?=
 =?us-ascii?Q?z1y8qoaf0ZethqKZKaNdY6c6DKdSC8BAmsS1lzkpc9EKlbc3rjZV9aGVYozp?=
 =?us-ascii?Q?u7qEQrT5yzfmLrtqAOnU1NNhqeAj2A8q7KyundjMIbv6LLO6ABA764yNSPpu?=
 =?us-ascii?Q?H7Gr/EN2gNcGd1ot7wacoScfOv1WNoCRJNPpc+au2xqsDMW3wFnDe8JrEqGi?=
 =?us-ascii?Q?8wuCf2TLgK0qTn92v4fWycUieT6eT8nKiLOg8w5QtNWfC/hynETYDz4x8MMf?=
 =?us-ascii?Q?xWZVEMzHzSCKuqwtlNik9NQ+gW3rqluY5rsUNLaA4LhHGrH14LAkVmSoRpda?=
 =?us-ascii?Q?owE//1S1R/ot9ggW9XApny3TR1a9HJK540odm/YG2R2eQJ9OHGzvxrchSQse?=
 =?us-ascii?Q?h6iz26NJGGUg1oR2YuCAv6Fys3XrDBV3oVeIk7nkqpitCPzYkwDoaW+kHbO/?=
 =?us-ascii?Q?vK8u62xkXrPjdpod2mqNTS57Np1Zs+8KtFSyhfTpfRfswzYBFbwAF6plIPMy?=
 =?us-ascii?Q?kzz2miXl4nG3U/FY22C4ZmRl4EyMSDaSNO4slkqg3/7Tt9/ht82humIF4IN0?=
 =?us-ascii?Q?56k04vQf/KscA7PDMutW5x8cDUPwE+Rvxr+zZ9+EvICEV92IaTrWoLreYRS+?=
 =?us-ascii?Q?HtkB6DUzrV9qkcGSXSejiPl887ckAP0TzplS6MNfKFJs9z3DX+8EHu94yne1?=
 =?us-ascii?Q?BtRnTqSFd9yRDRyz30fJFJJRWL59x+RMAHsu6z2oWSJHJlzz1s1RHxSq9sBp?=
 =?us-ascii?Q?D54k/+rGsNxMPfwOuxDJqczvv53l631CMqucH1C+PYVvZmKqvlu5/Qcjl6uR?=
 =?us-ascii?Q?d6Cwf9d4E774GDpOkrzo/xl8PW0cwd6eOWlwqnu1gTxq9JzIuFfyX/1sN/sW?=
 =?us-ascii?Q?l6dUBnDPtZPUzIpdnRQM9Wt0JAJ1WkXs32tCMXpJEEg3V4U7GWEveCJ73P/i?=
 =?us-ascii?Q?qzuyWjL8JA1yXJnBEGCrkApyBvG9TW0YLDKGyNUhgHel62Pner63Cjs6BnLl?=
 =?us-ascii?Q?eFgUH/nt2czKqJVJx2zC/hzG3W1mNEnhweAM65J0RvMJnJeUiUg70dakMAhn?=
 =?us-ascii?Q?39h/cLmz2gPp2CdNC9/ksikaBVMMTdBvSURUlZHWCdILRFChSE55bvbwTEv8?=
 =?us-ascii?Q?i1UXUAXmSt74Il4Jx2zg/ZgsWRsL5Vby0wC63E+pIbXNrw7bxFKUlW3aGZHr?=
 =?us-ascii?Q?SVh2boY0tZBMIsuU+bF/TNfoG14S+Lzu4b7K4TqlSxYRl5jhjopnpVY0F/SK?=
 =?us-ascii?Q?D03qiCevoip6fQQEcJg1hbeeWCxmCvoRqciZKC+e/UGOqt8YHX8CEHrbO/3r?=
 =?us-ascii?Q?yQjy4+IOk+RFeGqQVKi5sdyrB/5jCJveKw3iED9x1CWVzQNUMC6dq6JGD6rM?=
 =?us-ascii?Q?UR1lzE7MlIG9N6eGvRxIRsDD2gNBKbuhN8DoZ8sq7EsETVarRvFi9p+UNy7t?=
 =?us-ascii?Q?gbtkwOfjpbyNp9o1TdtF5ZpPk/4XRBri0NVOjTil6Pc1Fz1pipmmIvvfgN+i?=
 =?us-ascii?Q?xZ6DHRX5i2C6gywZsN1hLq5feqsUgV+3iKKD+ZdiFCTpFG4iY+3SmeS/qg4m?=
 =?us-ascii?Q?b73ZwNEFV9z62NzSiLmGi+QAoDJhL5cuNYwtcE5f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e8fcec-c412-4b2a-b9ec-08dc5cf7e798
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:58:19.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygrDgFzHLkM493FSvGxh1OoCrkt2sUKbrnLC/4JrCaUg3EiobOhCJyFI1FUh5lIpnklGUXHVSc4usLpmUdc3YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343

On Sun, Apr 14, 2024 at 10:46:21PM -0400, Frank Li wrote:
> On Mon, Apr 15, 2024 at 10:03:48AM +0800, Xu Yang wrote:
> > In current design, the user of perf app needs to input counter ID to count
> > events. However, this is not user-friendly since the user needs to lookup
> > the map table to find the counter. Instead of letting the user to input
> > the counter, let this driver to manage the counters in this patch.
> > 
> > This will be implemented by:
> >  1. allocate counter 0 for cycle event.
> >  2. find unused counter from 1-10 for reference events.
> >  3. allocate specific counter for counter-specific events.
> > 
> > In this patch, counter attribute is removed too. To mark counter-specific
> > events, counter ID will be encoded into perf_pmu_events_attr.id.
> 
> In change log, you said keep 'counter' attr. You should memtion keep 
> user compatible and but omit all value pass down by count=<n>. 
> 

Oh, sorry, I need to modify commit message too. Thanks for your reminder.

Thanks,
Xu Yang

> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > 
> > ---
> > Changes in v6:
> >  - new patch
> > Changes in v7:
> >  - no changes
> > Changes in v8:
> >  - add Rb tag
> > Changes in v9:
> >  - keep 'counter' attr
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 164 ++++++++++++++++++-------------
> >  1 file changed, 98 insertions(+), 66 deletions(-)
> > 
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> > index 0017f2c9ef91..b00cbd920c0d 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -41,9 +41,11 @@
> >  
> >  #define NUM_COUNTERS		11
> >  #define CYCLES_COUNTER		0
> > +#define CYCLES_EVENT_ID		0
> >  
> >  #define CONFIG_EVENT		GENMASK(7, 0)
> >  #define CONFIG_COUNTER		GENMASK(15, 8)
> > +#define CONFIG_COUNTER_OFFSET	8
> >  
> >  #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
> >  
> > @@ -130,6 +132,8 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
> >  	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
> >  }
> >  
> > +#define ID(counter, id) ((counter << CONFIG_COUNTER_OFFSET) | id)
> > +
> >  #define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
> >  	(&((struct perf_pmu_events_attr[]) {				\
> >  		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
> > @@ -162,81 +166,81 @@ static struct attribute *ddr_perf_events_attrs[] = {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_pm_29, 63),
> >  
> >  	/* counter1 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, 64),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, 65),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, 66),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, 67),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, 68),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, 69),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, 70),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, 71),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, ID(1, 64)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, ID(1, 65)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, ID(1, 66)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, ID(1, 67)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, ID(1, 68)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, ID(1, 69)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, ID(1, 70)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, ID(1, 71)),
> >  
> >  	/* counter2 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, 64),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, 65),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, 66),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, 67),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, 68),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, 69),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, ID(2, 64)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, ID(2, 65)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, ID(2, 66)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, ID(2, 67)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, ID(2, 68)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, ID(2, 69)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
> >  
> >  	/* counter3 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, 65),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, 66),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, 67),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, 68),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, 69),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, ID(3, 65)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, ID(3, 66)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, ID(3, 67)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, ID(3, 68)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, ID(3, 69)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
> >  
> >  	/* counter4 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, 65),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, 66),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, 67),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, 68),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, 69),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, ID(4, 65)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, ID(4, 66)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, ID(4, 67)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, ID(4, 68)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, ID(4, 69)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
> >  
> >  	/* counter5 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, 65),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, 66),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, 67),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, 68),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, 69),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, 70),
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, 71),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, 72),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, ID(5, 65)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, ID(5, 66)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, ID(5, 67)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, ID(5, 68)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, ID(5, 69)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
> >  
> >  	/* counter6 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, 64),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, 72),
> > +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, ID(6, 72)),
> >  
> >  	/* counter7 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, 64),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, 65),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, ID(7, 64)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, ID(7, 65)),
> >  
> >  	/* counter8 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, 64),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, 65),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, ID(8, 64)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, ID(8, 65)),
> >  
> >  	/* counter9 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, 65),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, 66),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, ID(9, 65)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, ID(9, 66)),
> >  
> >  	/* counter10 specific events */
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, 65),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, 66),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, ID(10, 65)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, ID(10, 66)),
> >  	NULL,
> >  };
> >  
> > @@ -366,13 +370,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
> >  	}
> >  }
> >  
> > -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
> > +static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> > +				    int counter, int axi_id, int axi_mask)
> >  {
> >  	u32 pmcfg1, pmcfg2;
> > -	int event, counter;
> > -
> > -	event = FIELD_GET(CONFIG_EVENT, cfg);
> > -	counter = FIELD_GET(CONFIG_COUNTER, cfg);
> >  
> >  	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
> >  
> > @@ -392,12 +393,12 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
> >  		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
> >  
> >  	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
> > -	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
> > +	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
> >  	writel(pmcfg1, pmu->base + PMCFG1);
> >  
> >  	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
> >  	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
> > -	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
> > +	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
> >  	writel(pmcfg2, pmu->base + PMCFG2);
> >  }
> >  
> > @@ -465,6 +466,28 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
> >  	hwc->state = 0;
> >  }
> >  
> > +static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int counter)
> > +{
> > +	int i;
> > +
> > +	if (event == CYCLES_EVENT_ID) {
> > +		// Cycles counter is dedicated for cycle event.
> > +		if (pmu->events[CYCLES_COUNTER] == NULL)
> > +			return CYCLES_COUNTER;
> > +	} else if (counter != 0) {
> > +		// Counter specific event use specific counter.
> > +		if (pmu->events[counter] == NULL)
> > +			return counter;
> > +	} else {
> > +		// Auto allocate counter for referene event.
> > +		for (i = 1; i < NUM_COUNTERS; i++)
> > +			if (pmu->events[i] == NULL)
> > +				return i;
> > +	}
> > +
> > +	return -ENOENT;
> > +}
> > +
> >  static int ddr_perf_event_add(struct perf_event *event, int flags)
> >  {
> >  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> > @@ -472,10 +495,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
> >  	int cfg = event->attr.config;
> >  	int cfg1 = event->attr.config1;
> >  	int cfg2 = event->attr.config2;
> > -	int counter;
> > +	int event_id, counter;
> >  
> > +	event_id = FIELD_GET(CONFIG_EVENT, cfg);
> >  	counter = FIELD_GET(CONFIG_COUNTER, cfg);
> >  
> > +	counter = ddr_perf_alloc_counter(pmu, event_id, counter);
> > +	if (counter < 0) {
> > +		dev_dbg(pmu->dev, "There are not enough counters\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> >  	pmu->events[counter] = event;
> >  	pmu->active_events++;
> >  	hwc->idx = counter;
> > @@ -485,7 +515,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
> >  		ddr_perf_event_start(event, flags);
> >  
> >  	/* read trans, write trans, read beat */
> > -	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> > +	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> >  
> >  	return 0;
> >  }
> > @@ -506,9 +536,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
> >  {
> >  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> >  	struct hw_perf_event *hwc = &event->hw;
> > +	int counter = hwc->idx;
> >  
> >  	ddr_perf_event_stop(event, PERF_EF_UPDATE);
> >  
> > +	pmu->events[counter] = NULL;
> >  	pmu->active_events--;
> >  	hwc->idx = -1;
> >  }
> > -- 
> > 2.34.1
> > 

