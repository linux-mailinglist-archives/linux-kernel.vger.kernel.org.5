Return-Path: <linux-kernel+bounces-96340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13633875A6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0E7B2271D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53BD3D0C2;
	Thu,  7 Mar 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aum9Id3n"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01547335D8;
	Thu,  7 Mar 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851545; cv=fail; b=oM6dHPVzwFsfKi/DtpgIgNaCdHqjo5XrwOT4xbQrnjyW0p2lJAr6g4dT3Ziw+a6wa2TrxlMeY9sQox1/K6eBI98KLGboydXTvAIAuO22qBavRQFNFb/srPkSIo9r07IKC5ambmsC0z6xkq3GkD4FarRfyUu8XLFqrUnznkvehPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851545; c=relaxed/simple;
	bh=0RWRVFTS+fFztZbypLhEVtQq9sNJ2JHAzI9nnTFs8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VRJ671mtjg8Iu3ibeov5kqImyHAOnvCnYB3HPT0u4UEq1JcmYORwYAx1w9XZWRo8RmM0RxEu0N/Oyi8gJBCGJCn3L+V6CQ8JTmwCHuO6OIiO7xH/b4Lu6xY9D4iNX55B8KDAhVy1lajU6O+f2wv19P5ZpYKmK/aPFaD3GSKmLqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aum9Id3n; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Isv5GiDlJU2zxp2rU7PhKAr36ngyDr88XobRV50IDF5VhinPjWbpAxYJauodaLsIJc2UCoVS3b6gHYU3X4SveRq5qmtF/E0alrET05rzk5sIe06yePeqnq376Nn2zGbkZs0aWnvLMqEL6IR7z9m4No4mLlo0Wo8PUWXU9j5uuLyExNqn/KjmLR8MijOl1b25rMh0r47eiDgVTvABgb8qqc5eGmYLme3CtthETZjTbZ/SJ9h0dwBHUuZUzD1enKRwuY/tJuj0KLRaiMpdI+gTqQoK2vJ4pZNGGPMoNaEfZNJ+mxjWl6KGNWMzyZUfe+U6yti8xu77JqeWjUZ4AmEV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqElngzVsSqsp9pjFRQJLnUpld7fhwVWV9yJpotnY2w=;
 b=ZSw7C4qwNPx1FgKB250+yWYNyleuiKVrjWqahSAO6AV+8HFnRYJhN6fz15P/WN5a7AcUhyQg26yLVGGeYJrXIsOwZOB+ZuYZt6H695qaomHp95OjS4b17mhQ/iM7DXH6xBBUpArkkEGxS1ikaCh/u8WfscZuxsqTR0eYZ9HFTEuKYOaM0IhXKrWepcZP6bNiOJJG5CYy+2xqP06Jk8ri3Om+ROhe0akTDExs/hRgvo95EDWXzXRoVcCoyYYWGAC0FkJmkDnFFgrNlZue0rt68Zxio/6IDee56ZuhG+8gHyrhy/Qn9+E+dTDlHwyKQw4HWTEQUnq01rYZHsLb7xvIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqElngzVsSqsp9pjFRQJLnUpld7fhwVWV9yJpotnY2w=;
 b=aum9Id3nOjmsWGOWr5aZP9xS1vvyP2bEqwJmN5sj11zghipJcCq7FoJwOkdZF8z3UVzkHcQGcqoKwRA96JApMBSnoCjARVk+xm4/djF1wUncDU2/Qj6+YB1L3qr7wffsMLcyaT8ji7tAKTQwGyN2ZNkAEcDSTLMv/yGxp0UF1N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6972.eurprd04.prod.outlook.com (2603:10a6:10:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 22:45:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 22:45:35 +0000
Date: Thu, 7 Mar 2024 17:45:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
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
Subject: Re: [PATCH v6 6/7] perf: imx_perf: add support for i.MX95 platform
Message-ID: <ZepDhiqqjYea3Kld@lizhi-Precision-Tower-5810>
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
 <20240307095730.3792680-6-xu.yang_2@nxp.com>
 <Zenz5ufZ3DIgbAuM@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zenz5ufZ3DIgbAuM@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c1dd62-3180-4908-2b2d-08dc3ef84dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	agfXyOb9z3goK4aKxxBNW8gkedjyE9QWixalxTeiGl8ys0JEx/1PRwcoMr8VCWMQitrs6fGdxVVNhriz2t56FLKUsKfC4eT/pqwjJLv+mD1FOPBHOJ4eSkBSvUgH/TiKaD2eWSNMLphyrTOBBdKxLTUZBqMuQTkGLhsjy/mfChnHThbKTAvWkURMDDmFBdvaF6hBp7LmKcmkvkYcGTj5/jqwDcX2LTaF/CA/HCsYFcHs/Lwg5pDqA/eZw3v8SwyoVhMC8YLCQhPFfRlW92mpNGT5FdgHHv4v3tfPCjZr41ardCF3WEVWEEVKBV+quCiunGr84Wng6/HpaGBZ1HQR1hahinbrn5UKB50js3w8q8B0bp1OKat2RIaf95VxcGVfJWLh89b2tUIgJ3dzbW6LapJSxtkJJkkGfcnYeH7uC/l9XGqazyRc5qEcbo5u60fZAg8olv1E8EFRZcIyGwoPm9KSBFh98k8VhBKTfNY30J0lRIBYrMmleZ4AO2IaKaFbhpgn86sbBig07oYQPmLWiAcsY6JLXLCyvS3p+QLO1vd61DBxpPp2siYNLclUzmCx1qo1zk7FHksUCDjEqAq68D0EI//05GSRSA2J9v9SfkLqIhcGYWZ3m5NqJnivAt3RReUtTCVYjGq5QSxagApboJk5CxZ+TjEQQDP94n+A6aBOsUGYhMzwfW7LmCDtJzF4SH8wxupQx1ogZpkVIic1Ww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?muZITdkLaeaGEHjwGH4AQ2c4yvL0zk2z+16Ih3SV4oczlP2c09cODXXKSzOm?=
 =?us-ascii?Q?ydf/mzQqXC12vzgA/VXXPRa2Qz1tmwMKSE5ZQD5Bmkfx922pv0eflOOpEXHQ?=
 =?us-ascii?Q?vbLI+85JRwWdsdxqf0K56Xa1DNU7Beo2j/LnzSSjfd9U+x2UqKL5OA5XRode?=
 =?us-ascii?Q?0bo06v9PU3xLJWWDZZUUCUcpkjRTdAlVELSENvPOTdKdNLkkqE93SZj8S1Vj?=
 =?us-ascii?Q?V2cVOqRlKYsvYGEiGIqqhJxd9a+SynWUK7o26ZyEkiKtEOhOFQPOQHGUPUDA?=
 =?us-ascii?Q?9FWbrhHB3P5+zaz8RrWof1GECqA1gjgL4y4qUOdl/2EKU9iRgkRiR4SUEHrl?=
 =?us-ascii?Q?YjAV6dyaoHdehU4JdFvB3Juop7HSJk2gg49JM+u1tCtXga2cCxtft6gJFFEA?=
 =?us-ascii?Q?S4+EbDQ1PjoCWRMMcu+LM3v5jAoLqYFBUvcfWQz8EzdV1SIO3b6Kdm83rOPq?=
 =?us-ascii?Q?7M4Lxgu0oqvTwO/3OXp6Q3rLRynOL2RHn1j1hYmQq40qrYm1zK/18ftCILNb?=
 =?us-ascii?Q?AMiT+MWWlbICjLCZG4B5dcMnDJ4EAhfsOzvQp5evGGviMaqHS2n1V+lNua4s?=
 =?us-ascii?Q?tj88b+velfePaHDFqCHPrLCJHPbz7I8Tf7lmlTufXcz73XTkhu1walNV+PO2?=
 =?us-ascii?Q?8T2WK41bej5aGzgqS4y8qdfOe5cwwIKWkI8L0PM2JhvW/JXTvbcRh3OwkWF3?=
 =?us-ascii?Q?OoL6GdfG38ihDIeCtYCggcKyKFKRGbi8YueoDyZxd9lgAnnmbLw62WQrzMPu?=
 =?us-ascii?Q?ihe4UExX1MlTNxIZKcLPa7rFIAGUqaBC+jcAkg/11huRp50PFm6rXM19EJWJ?=
 =?us-ascii?Q?C4CHS5ro7JTzMSVx1zS0l9NzZvx/O/3ePQikTFM9+peJkaWw+Zr9MRNnll4L?=
 =?us-ascii?Q?ZW8/44RuXqE28ux4ONAQQp8XTvCjtj13ve8au1LdbgknxB8YOrRu+h8FjOAd?=
 =?us-ascii?Q?wz/QrlWBiP+qh7Ho0o7za0NVBjw/N+UnDgc5cVfnOqTt9JZK7JOpprBQJY8P?=
 =?us-ascii?Q?v76MU1TuqeM/oZ0wl+aZElCvpjxpG4vHOo0zWynhQ+CVk0wR1atT14jSRu0B?=
 =?us-ascii?Q?oG9LRUXKwGBPrt9mC8Jj0bhMDOdCgNPSxwm4XGo8GpcjY1i6INEF9+tKHxNc?=
 =?us-ascii?Q?51D9ChnzbPYAiN0k5kJA8U7Nb5s2WPXgHd53Ze3d+ee4OqDxRrIk5Tife6Il?=
 =?us-ascii?Q?7jAdNUBO+TeLBuHM31LW3PuanOmMV7LB8oyZkF1XwqQyIEDZO8VDaY9dV2jt?=
 =?us-ascii?Q?BIZug2fOddmEVwLDPT8ay0+8jLrucv87BnyegHe+e3U6dH3wA3G7Qo2Hiq7M?=
 =?us-ascii?Q?IjbNKm066iVNaUJSCSE+0JBziTuxGNGEuzJmOIn8oN5vrJgU8y02VIG6gmou?=
 =?us-ascii?Q?kwBp9yWo/K0yGnaBXpb5LpH/e2MbELXhptTHvwAjq3aGkikg1fzFgRx6Ts3/?=
 =?us-ascii?Q?ND+JQLdlqlIRA/vkxrBVfRoAuoJEIz9nAS/ZmkjwNZOqGh13fTNj6YPoRiAE?=
 =?us-ascii?Q?EIE8U7Cl44XfV2ZaC8IElDB34xbHlCkEwSa2P8jFB2NJjd4BhYYAeo5JnQNH?=
 =?us-ascii?Q?aL2cF8KonfFiUyY+/CvKuIZyMdToP34lk0fIQJO0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c1dd62-3180-4908-2b2d-08dc3ef84dbb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 22:45:35.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xshmuOo0frI3xcSwTilOrrK2rYEKr1y18kkbHJG0XXdMkFSL201NElVgKprXZ7zM3m9r4JXNNgu3ALBg3WFqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6972

On Thu, Mar 07, 2024 at 12:05:42PM -0500, Frank Li wrote:
> On Thu, Mar 07, 2024 at 05:57:29PM +0800, Xu Yang wrote:
> > i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> > read beat and write beat filter capabilities. This will add support for
> > i.MX95 and enhance the driver to support specific filter handling for it.
> > 
> > Usage:
> > 
> > For read beat:
> > ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,axi_mask=ID_MASK,axi_id=ID/
> > ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,axi_mask=ID_MASK,axi_id=ID/
> > ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=ID_MASK,axi_id=ID/
> > eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=0x00f,axi_id=0x00c/
> > 
> > For write beat:
> > ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=ID_MASK,axi_id=ID/
> > eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=0x00f,axi_id=0x00c/
> > 
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > 
> > ---
> > Changes in v2:
> >  - put soc spefific axi filter events to drvdata according
> >    to franks suggestions.
> >  - adjust pmcfg axi_id and axi_mask config
> > Changes in v3:
> >  - no changes
> > Changes in v4:
> >  - only contain imx95 parts
> > Changes in v5:
> >  - improve imx95_ddr_perf_monitor_config()
> >  - use write_relaxed to pair read_relaxed
> > Changes in v6:
> >  - no changes
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 93 ++++++++++++++++++++++++++++++--
> >  1 file changed, 90 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> > index 52234b97d0cb..a91267e2f5d8 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -17,9 +17,19 @@
> >  #define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
> >  #define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
> >  
> > +#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
> > +#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
> > +
> >  #define PMCFG2				0x04
> >  #define MX93_PMCFG2_ID			GENMASK(17, 0)
> >  
> > +#define PMCFG3				0x08
> > +#define PMCFG4				0x0C
> > +#define PMCFG5				0x10
> > +#define PMCFG6				0x14
> > +#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
> > +#define MX95_PMCFG_ID			GENMASK(25, 16)
> > +
> >  /* Global control register affects all counters and takes priority over local control registers */
> >  #define PMGC0		0x40
> >  /* Global control register bits */
> > @@ -77,13 +87,23 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
> >  	.identifier = "imx93",
> >  };
> >  
> > +static const struct imx_ddr_devtype_data imx95_devtype_data = {
> > +	.identifier = "imx95",
> > +};
> > +
> >  static inline bool is_imx93(struct ddr_pmu *pmu)
> >  {
> >  	return pmu->devtype_data == &imx93_devtype_data;
> >  }
> >  
> > +static inline bool is_imx95(struct ddr_pmu *pmu)
> > +{
> > +	return pmu->devtype_data == &imx95_devtype_data;
> > +}
> > +
> >  static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> > -	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
> > +	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
> > +	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> > @@ -192,6 +212,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, ID(2, 73)),	/* imx95 specific*/
> >  
> >  	/* counter3 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
> > @@ -204,6 +225,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, ID(3, 73)),	/* imx95 specific*/
> >  
> >  	/* counter4 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
> > @@ -216,6 +238,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, ID(4, 73)),	/* imx95 specific*/
> >  
> >  	/* counter5 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
> > @@ -227,6 +250,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, ID(5, 73)),	/* imx95 specific*/
> >  
> >  	/* counter6 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
> > @@ -263,6 +287,13 @@ ddr_perf_events_attrs_is_visible(struct kobject *kobj,
> >  		!is_imx93(ddr_pmu))
> >  		return 0;
> >  
> > +	if ((!strcmp(attr->name, "eddrtq_pm_wr_beat_filt") ||
> > +		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt2") ||
> > +		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt1") ||
> > +		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt0")) &&
> > +		!is_imx95(ddr_pmu))
> > +		return 0;
> > +
> >  	return attr->mode;
> >  }
> >  
> > @@ -434,6 +465,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> >  	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
> >  }
> >  
> > +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> > +					  int counter, int axi_id, int axi_mask)
> > +{
> > +	u32 pmcfg1, pmcfg, offset = 0;
> > +
> > +	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
> > +
> > +	if (event == 73) {
> > +		switch (counter) {
> > +		case 2:
> > +			pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
> > +			offset = PMCFG3;
> > +			break;
> > +		case 3:
> > +			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +			offset = PMCFG4;
> > +			break;
> > +		case 4:
> > +			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +			offset = PMCFG5;
> > +			break;
> > +		case 5:
> > +			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +			offset = PMCFG6;
> > +			break;
> > +		}
> > +	} else {
> > +		switch (counter) {
> > +		case 2:
> > +			pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
> > +			break;
> > +		case 3:
> > +		case 4:
> > +		case 5:
> > +			pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +			break;
> > +		}
> > +	}
> 
> Look like only if event = 73, FILTER need be set.
> 
> How about
> 
> 	pmcfg1 &= ~(MX95_PMCFG1_WR_BEAT_FILT_EN | MX95_PMCFG1_RD_BEAT_FILT_EN);
> 	if (event == 73)
> 		switch()
> 			...
> 
> So you need "else" branch.

Forget this one. My code have problem.

Frank

> 
> 
> > +
> > +	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
> > +
> > +	if (offset) {
> > +		pmcfg = readl_relaxed(pmu->base + offset);
> > +		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
> > +			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
> > +		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, axi_mask) |
> > +			  FIELD_PREP(MX95_PMCFG_ID, axi_id));
> > +		writel_relaxed(pmcfg, pmu->base + offset);
> > +	}
> > +}
> > +
> >  static void ddr_perf_event_update(struct perf_event *event)
> >  {
> >  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> > @@ -543,8 +625,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
> >  	hwc->idx = counter;
> >  	hwc->state |= PERF_HES_STOPPED;
> >  
> > -	/* read trans, write trans, read beat */
> > -	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> > +	if (is_imx93(pmu))
> > +		/* read trans, write trans, read beat */
> > +		imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> > +
> > +	if (is_imx95(pmu))
> > +		/* write beat, read beat2, read beat1, read beat */
> > +		imx95_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> >  
> >  	if (flags & PERF_EF_START)
> >  		ddr_perf_event_start(event, flags);
> > -- 
> > 2.34.1
> > 

