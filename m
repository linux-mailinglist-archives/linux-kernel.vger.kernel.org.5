Return-Path: <linux-kernel+bounces-94911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C374874694
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D27284F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DD3E560;
	Thu,  7 Mar 2024 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EXdoMvfo"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C949CA6B;
	Thu,  7 Mar 2024 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781107; cv=fail; b=GbLTC1GzIQqxuo8ygWcR2VuQE25Kjx7SSnAdp5KEftDGWo2vdFSaotxlPOXut0NTBIPnYOLL/0WFU7j10HOJ5vPzbxHEKeZQ4X4WJOy5pm5zJOmPimf1cP9ydrTCWTDNUq/3IZeuPVav9qOSusjMq7DudPfoh7GjEaWSvQpkZ3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781107; c=relaxed/simple;
	bh=ZdNk1xq6Qlu2gfDU8EgyB3GIQt+mhRtvYAPSuV9RFm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZCc+5hwyDyEnaE3iS0Wk9XJQy05GgBaaVjpesRzFsbDysRt3ZJ09cqM8WpZ9p0GSjFVvlYo43KenJvpj4yJMOLetIbXFUhtbc6oyiFNbiQLgUx6gU+uPGDPHZK0D9BIlSGTQf0A4RqsAE7Gu75BCk8GazCYsHQkq2wf0k4Esu5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EXdoMvfo; arc=fail smtp.client-ip=40.107.7.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+h0dcfoMM5/9AnEaaJIW++lh0AK7OuSPKhw1HAdLvn6bTlff7lsIM9UV9So3lcREy34RNIcZf6NeMUb5+geVPcl89yoW+KPGGV8Ot5mjH4ra+4O0YaEj42mhGbj1IDgkh0sJ4fpM+q2vTUIbGyQeJgWPfbYzowV++mOKijrz7ncm9TMixBu7ivtPboqkKvWhOmOaO2TmtIQTm+7yBcg9RQoF4fAfGN1q+g9uYHeRTY75STlTAZUPYleKkJee6Jd9T9rCcvdOFDsV0LBQQAVA5LvC3+VlCxntp14ZgYfWBCmcq2Fw1vZUMytHAD+e0dnwX13/PbtzBjNXiVqY3x7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5BWGN04QI8mZFdvPNIZWGLSwq4QPsOGIMRP3ZRgdEE=;
 b=PQesJzgVP3/TQ7MBTJa24aJR9neRHYuXkfKZTVg5veu6pwogaT81hOo3124MFQgHUVPt8N6tN4Apvctw4q7mGt4FsA/L7ZQhbQ53T8mMeX+XvuGQMm7PmuQ8PbhPXdSfyaTr20z+O4OihFCaapDahe5KheYHs02qG640v48qSmK1e09J4BSyu+THLqOk3yMIOwJ9Fvl7aTP/kzrky2MQ+EweCs2mziERODk0SnG7+iNeKwJRKXuy3C/nfZa7EGET4m6eaCfv/d7HCYB0iRk0tTEPPoqqfRMWRVmMHj/whob144732BzHkIMpA1WVoOviz+nf0Qb8YllWaJBHzXsFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5BWGN04QI8mZFdvPNIZWGLSwq4QPsOGIMRP3ZRgdEE=;
 b=EXdoMvfoN/o2nhJXAroyCBGmLtJRJVt8RbNmD6F1UmiBri4xrClgE5/e8Do1ocmMRRS3et1L+o1xwIzWBNRm9a9JYM/fAoIuNPgq+pRe4dpGK76z6eqcnKogZ2f+0B7Uq08qdExUbllXkPFXqrrvA1nmUldYMEYP3Bc9nxdBFSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 03:11:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 03:11:42 +0000
Date: Wed, 6 Mar 2024 22:11:30 -0500
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
Subject: Re: [PATCH v5 5/7] perf: imx_perf: add support for i.MX95 platform
Message-ID: <ZekwYp7TwJ+FiD5w@lizhi-Precision-Tower-5810>
References: <20240307024754.3469810-1-xu.yang_2@nxp.com>
 <20240307024754.3469810-5-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307024754.3469810-5-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1f2021-a1a8-4962-459b-08dc3e544fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LMat6yz08VX9hzd3HvtlJZrce+jdOxDH+zugmjVR32/kmvLBpEJ3VRW2JakU48k/nmfGlBccgTr0nKGeFgkmGW6D1LTA8jk1aWh93LksooUFQSpbVBeZ8cruos3BNEX4KZJkiRkMRfeZqsFgBbln82Uj4MTKDvxFIUQzQAXm4Fp6PlMFVzbJSi1OJOka04lpGqgytfBmQycgPdI8OiValEy6/sMySfSGNr835jFNONGa0EUPfFz4pPXrs4L49TrltmyY1CTp1JhoqORzNolmqDSUNGAjb7NZEEVX4zoD5Op44p2frycWs9UyePPi1oxTZaoKkpS68dHNQpWoThNY8MIxOmlbI+Q/t1mnh5zsFrROzs53nbvZuSfCdrH+Hx3GvyGcQuYrV1qPO+Fja9Jv0mN/n11EnPYqIEhIwIkc0NyUlAvPBjfjyP0avyDfyCFdE5P/jMeBUUCV1czAeZl0Zsy9Tyy7ZlhT0mGrEx3e8Mie2Zhsr4AHlQmIHXw/GCs2qvHcz2JqnPOp3kZDD5xOtMjtL0i7kJdIYJxB0KYcGETJi3CWLEb8cjl1BP6XaIhwvKvtKjBsTk0ANVzfN6ENY85Btuozls3ERyYY0ZCZOlLjwLRz4cdwLakkx3nyDDF5v9dFndC3JTwzQovdAt2nAnxAzUoUSer14amgRz2+9h+43YRIYkhDFvh4eT6gTjJ/0t2RAshtkWY9QcrAbiSBqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fk6eIhZXnnsX1oXigPDYWZqSb0KhYH5ixd7awShcve3wJlwiclZUzzhvevkD?=
 =?us-ascii?Q?AD1qO5zeYXmF8Nx87V5q9n6kKqC5+YjbiCZCXGMg8IgA6p9OdSqIsdzg9X1v?=
 =?us-ascii?Q?CubFdeyggW08jaUvdm6YrmK2JZOCsmpKAflwsyXrbgDKgeHAUBdnqcBvB9IY?=
 =?us-ascii?Q?j8ZhqSYg8wD4LrC344pfchkszNr5FjOPFCL62jv/o6TwHYfoT8ecLFXwhS3z?=
 =?us-ascii?Q?kZcyoXnLNxaYTgd+oyT1keLrpoXO5wsKt/s+4gz2+O5bByPLJBcFLX+Xnx34?=
 =?us-ascii?Q?uHlbn/ovncDfsnJWhjndzPb+5v9YU8+SvmwKryF7xjPkIxfFQsH7qJyNrTLo?=
 =?us-ascii?Q?P2C1fohwP94dq4+1IMG1nmA4/VOl8z6V+1hcDC5C/2axwrHQs+6ZyARedmvF?=
 =?us-ascii?Q?694DgYdeqNFUf/bgyl0yffr24QbIVxjrP78weKxeYfic2phR3iwZ7dDvN4U1?=
 =?us-ascii?Q?GZnyitJx/XDgqMR3DZq1VY64rbrm2O58hvwsl/WIOEdepfs+Wj2M0dL4HiBX?=
 =?us-ascii?Q?Nusvx4/3DutluDM6PV9KmW2KwXASPGpyRXEeRBFwT0asJJKv+9ZXGyVPtBDe?=
 =?us-ascii?Q?jMogOR1Lq6xhpBj4cIs1mVzChOdzbyFDWKW2zaG4ZZpmLnOLa8/B8J/hDbzm?=
 =?us-ascii?Q?iYVcrXKC/Qbs/tpfiqQ8vNgu4/a6Xy55SSYfABVDkZX2+Xk6rDgRGhrQESKE?=
 =?us-ascii?Q?N52ro7KXuLmmKrW8BARwvOvjYV7XFRuO3DV6u8VQAqUik+hnux+gZqgxcSfn?=
 =?us-ascii?Q?y2qn4/eWjLhu2yjM6ajLR3AQclPnQ3275cMqgyIBHg+povBFhnDImt+lTORC?=
 =?us-ascii?Q?oa03pE7FuSvE8LGMD+EzH7HhzocMUWqw3f1Th9RpM4rawPukWdbthkSDwTqA?=
 =?us-ascii?Q?CN+qzGYk6nm2+T8Lv/ZkDaXePM1/ng6j5uUi6Q9oZjqfHJNtxKrL1mqufwbD?=
 =?us-ascii?Q?fGXmPXoCNpBKhAPgKAF/ItLOCghOoUxAgSDbybjKdUp0LiPHVm2ORp8HD3xR?=
 =?us-ascii?Q?blvR3sGYwzg6OoQEJuBnJ0Z7NtwN6WXp1sXHLSmLWd9uXrQZpOgvrNAGMMES?=
 =?us-ascii?Q?ebTdY5FS/JHqHVGoE2uISVVWsDfU4xsEAWTuEf4Ugwku5TgkvG2YUsa1oXZQ?=
 =?us-ascii?Q?MIug/dLqtylyIAZAZtQ69OxWFI8jTWxcBPimzZFymXnNugIuLkCz9NzfuuZd?=
 =?us-ascii?Q?Eeyk0o3Gc/IIncYUJoGD4dSrREvsgXWUA7ipWimoaWNFOzusTcJNTD8tybiX?=
 =?us-ascii?Q?55DjoriCqs9CwvapcAsopa3IGp4CMK3B0SSzxk3zsG5iBw6TeBzBNJFjlNwq?=
 =?us-ascii?Q?Tgx8CJ3kkm/bwwfDeGk9D8DY46XJtNzlHgGiLwlWRsgnhOEvusOG9xkdIAnd?=
 =?us-ascii?Q?7aXhI52Xv/DcToiyoSJOUtFprBiGScMRLVAnlLKyzpkcrXM3stHMdN9B/A4h?=
 =?us-ascii?Q?ebiLpeyGkan0oCqyEK0Q0VQgEPkvmJV60bKv6ISTwqDIgQibVY9Q5cX5259Z?=
 =?us-ascii?Q?SYWQ+jS3mbTQUyfivT7soXrwpw0aQDRofFeYAZKGN1rBxLzodN9JNSXXur5V?=
 =?us-ascii?Q?veWxdOzJyeAykl9XwQw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1f2021-a1a8-4962-459b-08dc3e544fd8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 03:11:41.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzbxzGPXdOGseGLMDbqrfTYUX/iEyu/Ugn44bHXT/XxfRjvyQOSenTiDawefOMB5BKODbhZmDpH4YLJrLSdjCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

On Thu, Mar 07, 2024 at 10:47:52AM +0800, Xu Yang wrote:
> i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> read beat and write beat filter capabilities. This will add support for
> i.MX95 and enhance the driver to support specific filter handling for it.
> 
> Usage:
> 
> For read beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3,axi_mask=ID_MASK,axi_id=ID/

Why need 'counter'? it should be auto allocated according to event
mx9_ddr0/eddrtq_pm_rd_beat_filt2.

Frank

> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=4,axi_mask=ID_MASK,axi_id=ID/
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=ID_MASK,axi_id=ID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=0x00f,axi_id=0x00c/
> 
> For write beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=ID_MASK,axi_id=ID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=0x00f,axi_id=0x00c/
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - put soc spefific axi filter events to drvdata according
>    to franks suggestions.
>  - adjust pmcfg axi_id and axi_mask config
> Changes in v3:
>  - no changes
> Changes in v4:
>  - only contain imx95 parts
> Changes in v5:
>  - improve imx95_ddr_perf_monitor_config()
>  - use write_relaxed to pair read_relaxed
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 96 +++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 35e422083948..f25f55126004 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -17,9 +17,19 @@
>  #define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
>  #define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
>  
> +#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
> +#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
> +
>  #define PMCFG2				0x04
>  #define MX93_PMCFG2_ID			GENMASK(17, 0)
>  
> +#define PMCFG3				0x08
> +#define PMCFG4				0x0C
> +#define PMCFG5				0x10
> +#define PMCFG6				0x14
> +#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
> +#define MX95_PMCFG_ID			GENMASK(25, 16)
> +
>  /* Global control register affects all counters and takes priority over local control registers */
>  #define PMGC0		0x40
>  /* Global control register bits */
> @@ -76,13 +86,23 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
>  	.identifier = "imx93",
>  };
>  
> +static const struct imx_ddr_devtype_data imx95_devtype_data = {
> +	.identifier = "imx95",
> +};
> +
>  static inline bool is_imx93(struct ddr_pmu *pmu)
>  {
>  	return pmu->devtype_data == &imx93_devtype_data;
>  }
>  
> +static inline bool is_imx95(struct ddr_pmu *pmu)
> +{
> +	return pmu->devtype_data == &imx95_devtype_data;
> +}
> +
>  static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> -	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
> +	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
> +	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> @@ -189,6 +209,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),	/* imx93 specific*/
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),	/* imx95 specific*/
>  
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
> @@ -201,6 +222,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),	/* imx93 specific*/
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),	/* imx95 specific*/
>  
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
> @@ -213,6 +235,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),	/* imx93 specific*/
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),	/* imx95 specific*/
>  
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
> @@ -224,6 +247,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, 72),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),	/* imx95 specific*/
>  
>  	/* counter6 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, 64),
> @@ -260,6 +284,13 @@ ddr_perf_events_attrs_is_visible(struct kobject *kobj,
>  		!is_imx93(ddr_pmu))
>  		return 0;
>  
> +	if ((!strcmp(attr->name, "eddrtq_pm_wr_beat_filt") ||
> +		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt2") ||
> +		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt1") ||
> +		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt0")) &&
> +		!is_imx95(ddr_pmu))
> +		return 0;
> +
>  	return attr->mode;
>  }
>  
> @@ -425,6 +456,60 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1
>  	writel(pmcfg2, pmu->base + PMCFG2);
>  }
>  
> +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
> +{
> +	u32 pmcfg1, pmcfg, offset = 0;
> +	int event, counter;
> +
> +	event = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
> +	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
> +
> +	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
> +
> +	if (event == 73) {
> +		switch (counter) {
> +		case 2:
> +			pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
> +			offset = PMCFG3;
> +			break;
> +		case 3:
> +			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> +			offset = PMCFG4;
> +			break;
> +		case 4:
> +			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> +			offset = PMCFG5;
> +			break;
> +		case 5:
> +			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> +			offset = PMCFG6;
> +			break;
> +		}
> +	} else {
> +		switch (counter) {
> +		case 2:
> +			pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
> +			break;
> +		case 3:
> +		case 4:
> +		case 5:
> +			pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +			break;
> +		}
> +	}
> +
> +	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
> +
> +	if (offset) {
> +		pmcfg = readl_relaxed(pmu->base + offset);
> +		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
> +			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
> +		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
> +			  FIELD_PREP(MX95_PMCFG_ID, cfg1));
> +		writel_relaxed(pmcfg, pmu->base + offset);
> +	}
> +}
> +
>  static void ddr_perf_event_update(struct perf_event *event)
>  {
>  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> @@ -505,8 +590,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  	hwc->idx = counter;
>  	hwc->state |= PERF_HES_STOPPED;
>  
> -	/* read trans, write trans, read beat */
> -	imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	if (is_imx93(pmu))
> +		/* read trans, write trans, read beat */
> +		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +
> +	if (is_imx95(pmu))
> +		/* write beat, read beat2, read beat1, read beat */
> +		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
>  
>  	if (flags & PERF_EF_START)
>  		ddr_perf_event_start(event, flags);
> -- 
> 2.34.1
> 

