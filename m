Return-Path: <linux-kernel+bounces-46708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF15844304
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1A11C21897
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854F81272C4;
	Wed, 31 Jan 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HM6u+uGR"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE712A141;
	Wed, 31 Jan 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714827; cv=fail; b=hk0DsyqzlqQqMVVykCLdACeUPxxgiRAKBXRrncE8oaBGOBGdCAqvq+T9IkXRjHr3aFD5hmtmDjtMUWwPnRhs+KNyFcc4fQrFIqnuYTrt54W5oQae9Pi8YO6dqqC14B4CQia20taqWMYrmKHXv36PcDRyKc3AUj0KBSa70EJoyiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714827; c=relaxed/simple;
	bh=+J7/lPHFZPesROCONPBlEwpsjlXsL/JuKdsWGxAInXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qit/kihA6XzW8jcFRsDOLPIxYj5wJb1YWGEueQ8zcz73mCAdiqEcZ2yGJRHWpmTIKe5vL9nJeDRZfOGOC4+HMk82vZJ1SHuQU9zN2EiymL7W+cYoaaiKtnmTugyuilydWcbokyY45KbdECuDfyMhtHuAszoc7Ga7MMdL9dHnJac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HM6u+uGR; arc=fail smtp.client-ip=40.107.6.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xcl3EmdNRWw1wB6kanzAuxYwePLp2RRA0u47SJVtSzbzPHMNGzkRCjNYVAVgxPpD6ifmm4W8uz/EexqtqEWjwiMKEIRqXYVlVrnt7q67iFOhH+Y6MNTXT7AVW+teyRvSZvQPfHtch/6eJ+R9M7VPBAeyCYumERE1jJ08NECQ+AcUP8rJPN2wAWczFGcDUTTVBj+mX2zCMsHEsnZaKIG7zjcvL0QW3BAilWOS0gWPFIdeV8G2Fss6nOZkrU+hUK9tNRi9VELeE30fvhfu3/3a6awMb3NyaQFwI1o2BDKllFT1sUDI6L0PGdRFVBQ5mCHSCCUXs5xqmcYCdorI6gLopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UI3e6P8WvDh/Mm9VPSo8TRSoF6pP+LL/t5BOzjZVOU=;
 b=WNUz20eBvvskdiCFfcPS52h5snVuVxwQGXtAScCMN39JSy0SM5ERhZI5ZPQ3a9l4NvlGF19Jb1srlJDWH6WA72B2zBn3Mxxyu1QhGOdgCZ7E4oQeooSnuHafEUC91HmiLZmmFC1qr8sRhqQzGb5Hx6d9gOUrjisMWqhXuOEUys7qcqwWV/WWXjldRmXE+ODT/NQIgnzSkdK43K/WVYr6Fgy4pQiJHO0mUaJeHT8EegLswz8BD0kJupAGcONG/mPQo4rvAbt1SqxSKFbmYylZagqLxIFeQQuNg0bN+xthkDLd7G2k5UCTnZDMZJSGfLaCdA/0MK/cMYditsdNLvjkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UI3e6P8WvDh/Mm9VPSo8TRSoF6pP+LL/t5BOzjZVOU=;
 b=HM6u+uGRjcdBP7TnPGzrCyw127RcrGS7FfLFhVaJHsczCcGc0KEpEDKp4FqO+G/VhLNPCmNqLVTb1Vu/8nwp4BNIPzoeP+QaAbEsQVDWW5zjNUVcaEwjDwP+Bi5f8qIrMAa2yLqLcOlbz/otBseSZB9nUqugk0ADNpuRmijM9z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 15:27:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:27:01 +0000
Date: Wed, 31 Jan 2024 10:26:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: will@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, linux-imx@nxp.com,
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 2/6] perf: imx_perf: refactor driver for imx93
Message-ID: <ZbpmuuZM+4JTmtqO@lizhi-Precision-Tower-5810>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-2-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131055811.3035741-2-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 51172c86-e9b8-412e-810a-08dc22711202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zOsD2Wt5k7KShwzhb9+44Lra5kTBap1X+pGMV7D6P77SFPyXThMz+7b4CuZyXiROFbwLSujSaS3c362bWoWYX8yNBKgxPEBFKDZvIYdGYAMSIldbiEZxHNrxwNQfqtKXZ9Be3+6hMd9zOB2nNdFz8PcQe87LoTn2phKl9j1SwfumK8KIlx26aHrfqL9MdQ9HeORfNFNsRnNfcAUD0mHTZrqhJi4Sxy2OahzB+Bdpg+5YxXhfRr61OgIoZtG7cLT6y/p0wBcqJtaFPaHBtQVJTOpRUKtFCIYLbbf84JHvZ5d/VakvrPHE0BjF7K9eVaHr8T0XTy+FEDfsTGkXGY79P5LaLzy9qyjYoXHtZiRg1VkKGTgLxhj8xKlsXxeoV+sEz8FPo9538k+TRd+C3mnnyhrrxEKikmmONMVbOsm8LkgFXi+/2QDch4xxgs0uE8iU2m6Ush8hCbY2M9RB+652SKm8d+2Aas90t5Eaae36vvf1NSC6y5bDGl+ISWP1s+/QgRVK4wcY6YV1Nz/v/OWZogj1PDKpIoGtwYRErWBCm+/hLK+/f053qzPeqwNjbHXQMV12dq9O/6qh2V/SIf4e3lovumLea231evhip0eIvXsbmvhQKP6DPSfaCv7Lrxk5pfyhq55DsC2zQuJgalYXlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(66946007)(4326008)(8676002)(6862004)(8936002)(2906002)(7416002)(5660300002)(86362001)(66476007)(6636002)(316002)(38350700005)(66556008)(6486002)(38100700002)(52116002)(6506007)(6512007)(9686003)(478600001)(6666004)(83380400001)(26005)(33716001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?03tow0kDDCxj9RvP7kOssauhZUtvZSoVagOQ7X3PCfDjmwokm+cT0GfePRgs?=
 =?us-ascii?Q?Sbuc5UBJEPchmtW7Yp536fvYsPP2b5yHrbQMebdozmD+QAfrV9heI5+tveHO?=
 =?us-ascii?Q?Ak5FMkAzLjZhmt+vimET9obDvrybAvYxOcrglZbquwSKZjdNghafVn3uebeu?=
 =?us-ascii?Q?F/tnVHIBWVDg7e7TSykslLmahVmDuFULFrrGg6XJjPUBbSOOVK3qix/LJLa7?=
 =?us-ascii?Q?9ex1wUVKsfg7jUYa0ohMHURUER6rsstOyFRsTtjyFaPNAsXc+edKRqayhOUn?=
 =?us-ascii?Q?3AqLgUmQtVY3nkUA33D8Y9SNSL0ml0ztsPMhYKGVLu9wt/3+8hNloarzYmpc?=
 =?us-ascii?Q?6wuy2Avo7oeBkmNhIQKlzSRhOSZ7yqojkhWb05jkphXfizrgE+z7pFct0X9J?=
 =?us-ascii?Q?OrZtVRn02M7oIY87xmSCPDNBi8y2pPnheLZobVqzYBVfkg3YhmNIRG6XoqSJ?=
 =?us-ascii?Q?HW5kCbUGkJAuRX80p9eSs2t6rJ8LoVfycLzN20xGyEhHBnI2InnxgY/HxjMA?=
 =?us-ascii?Q?iTInTcC/sy4yK+oP1gWolk4yEbXNiisBtNpbUW4vcuXCt78JVAL/vG/b3KuS?=
 =?us-ascii?Q?TMT9Nk1hvCJaeqVwuSdhC17dxzGNfCPS4zBIer7ZC45ciV7lkW/RluIbh/GR?=
 =?us-ascii?Q?jkjoyefQQNmhBaBtVdVXaQrlAV1HPP6Ik16Fxyp3KP6kGv1+oTEJtDTg3qW3?=
 =?us-ascii?Q?VewBHE8vv48/HR2i4LNMy+vY2+VClYF0s713wUI3qCRAdgSEp6dunvFimA7X?=
 =?us-ascii?Q?tR/ny4SBuhVTdHxo6F6FXCzr4Cg/9yKZ4flUc6bKPk8Yzx/WD9ra2jcxwlTi?=
 =?us-ascii?Q?3/5JN0dUrnxgkHWva4rTRRr/yoh2ghnHXXbbB3XTBN18bqhux4PyWWxum4Ap?=
 =?us-ascii?Q?qfTWRjaG2+cydXl8go1Tf7w0CG3bVqaPesOo/Sn6I8qllBvxr22htZSPnU8q?=
 =?us-ascii?Q?LNYQ961jGvhuGvVpyJ0X3jy1R565n9Efag260Sz/xNslaDa4Ery1XZC27EnK?=
 =?us-ascii?Q?pSHNqm+eXESSj5y0/bsnejoDQ6zyQzD4RqQYA/aIYonnKlvhK8MVoaLjYJn/?=
 =?us-ascii?Q?pgOr95mmrBrZXDGWabHRvaSowwhLzZa4Yp7FpztoRZIw1LKztJIO1UylOyOR?=
 =?us-ascii?Q?wYrwB9l8F/tZuW5fOfK80OZmBse39kzvDPdk+kvyhc+dA+9itukp+PWcfen+?=
 =?us-ascii?Q?vwSbeVVnh4cTpNASOQvsR803VtMFjjPCKOyMRJPUazWT42Cd1mS0T8XU6K23?=
 =?us-ascii?Q?rSYmy/CLSWW7fNWy3WTQ/C1H2jkHSNgwYqFCMQ0qszkMZYyhGGwb5Mb1EpJb?=
 =?us-ascii?Q?aknN277holj9EYOqYD5eXbsXOMKJI9AxB2YQUqJSrSAnPpmu8pfTejvpZtRr?=
 =?us-ascii?Q?RI6G25Af94QtEagMkyFGYhK5wcfLWYWK2u/VPaesKBbglpgkV+jxN6KkTToc?=
 =?us-ascii?Q?Gak+/vV1bLVUF/kDcHNA63enBqnIezY+w12gAE2dBAtETh0vllYRq0cwKsXG?=
 =?us-ascii?Q?jFBk3RJOFg9lN1rvDo1pTHESfW9s3UhA2A5Op4SMNcLk6gH6Yd1PnHaQdby4?=
 =?us-ascii?Q?em3uVzu3u27vQekotphHEuNch1MtUbi5X6gqJ5Sz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51172c86-e9b8-412e-810a-08dc22711202
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:27:01.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbLq2mypafMic/QY8MGDnUa7+dA0S3xNyhtg9z8Yv8+bM8n5p7e6n7SsqdW9OIqkYDBiO7UnDDdIM+MTPWUjEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

On Wed, Jan 31, 2024 at 01:58:07PM +0800, Xu Yang wrote:
> This driver is initinally used to support imx93 Soc and now it's time to
> add support for imx95 Soc. However, some macro definitions and events are
> different on these two Socs. For preparing imx95 supports, this will
> refactor driver for imx93.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> 
> ---
> Changes in v4:
>  - new patch
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 121 ++++++++++++++++++++++---------
>  1 file changed, 87 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 9685645bfe04..b1a58e9e1617 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -11,14 +11,14 @@
>  #include <linux/perf_event.h>
>  
>  /* Performance monitor configuration */
> -#define PMCFG1  			0x00
> -#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
> -#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
> -#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
> -#define PMCFG1_ID_MASK  		GENMASK(17, 0)
> +#define PMCFG1				0x00
> +#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
> +#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
> +#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
> +#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
>  
> -#define PMCFG2  			0x04
> -#define PMCFG2_ID			GENMASK(17, 0)
> +#define PMCFG2				0x04
> +#define MX93_PMCFG2_ID			GENMASK(17, 0)
>  
>  /* Global control register affects all counters and takes priority over local control registers */
>  #define PMGC0		0x40
> @@ -51,6 +51,7 @@ static DEFINE_IDA(ddr_ida);
>  
>  struct imx_ddr_devtype_data {
>  	const char *identifier;		/* system PMU identifier for userspace */
> +	struct attribute **attrs;	/* AXI filter attributes */
>  };
>  
>  struct ddr_pmu {
> @@ -67,16 +68,6 @@ struct ddr_pmu {
>  	int id;
>  };
>  
> -static const struct imx_ddr_devtype_data imx93_devtype_data = {
> -	.identifier = "imx93",
> -};
> -
> -static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> -	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> -
>  static ssize_t ddr_perf_identifier_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *page)
> @@ -178,7 +169,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
>  
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
> @@ -190,7 +180,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
>  
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
> @@ -202,7 +191,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
>  
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
> @@ -242,6 +230,16 @@ static const struct attribute_group ddr_perf_events_attr_group = {
>  	.attrs = ddr_perf_events_attrs,
>  };
>  
> +static struct attribute *imx93_ddr_perf_events_attrs[] = {
> +	/* counter2 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
> +	/* counter3 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
> +	/* counter4 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
> +	NULL,
> +};
> +
>  PMU_FORMAT_ATTR(event, "config:0-7");
>  PMU_FORMAT_ATTR(counter, "config:8-15");
>  PMU_FORMAT_ATTR(axi_id, "config1:0-17");
> @@ -268,6 +266,22 @@ static const struct attribute_group *attr_groups[] = {
>  	NULL,
>  };
>  
> +static const struct imx_ddr_devtype_data imx93_devtype_data = {
> +	.identifier = "imx93",
> +	.attrs = imx93_ddr_perf_events_attrs,
> +};
> +
> +static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> +	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> +
> +static inline bool is_imx93(struct ddr_pmu *pmu)
> +{
> +	return pmu->devtype_data == &imx93_devtype_data;
> +}
> +
>  static void ddr_perf_clear_counter(struct ddr_pmu *pmu, int counter)
>  {
>  	if (counter == CYCLES_COUNTER) {
> @@ -361,7 +375,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
>  	}
>  }
>  
> -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
> +static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
>  {
>  	u32 pmcfg1, pmcfg2;
>  	int event, counter;
> @@ -372,27 +386,27 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
>  	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
>  
>  	if (counter == 2 && event == 73)
> -		pmcfg1 |= PMCFG1_RD_TRANS_FILT_EN;
> +		pmcfg1 |= MX93_PMCFG1_RD_TRANS_FILT_EN;
>  	else if (counter == 2 && event != 73)
> -		pmcfg1 &= ~PMCFG1_RD_TRANS_FILT_EN;
> +		pmcfg1 &= ~MX93_PMCFG1_RD_TRANS_FILT_EN;
>  
>  	if (counter == 3 && event == 73)
> -		pmcfg1 |= PMCFG1_WR_TRANS_FILT_EN;
> +		pmcfg1 |= MX93_PMCFG1_WR_TRANS_FILT_EN;
>  	else if (counter == 3 && event != 73)
> -		pmcfg1 &= ~PMCFG1_WR_TRANS_FILT_EN;
> +		pmcfg1 &= ~MX93_PMCFG1_WR_TRANS_FILT_EN;
>  
>  	if (counter == 4 && event == 73)
> -		pmcfg1 |= PMCFG1_RD_BT_FILT_EN;
> +		pmcfg1 |= MX93_PMCFG1_RD_BT_FILT_EN;
>  	else if (counter == 4 && event != 73)
> -		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
> +		pmcfg1 &= ~MX93_PMCFG1_RD_BT_FILT_EN;
>  
> -	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
> -	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
> +	pmcfg1 &= ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
> +	pmcfg1 |= FIELD_PREP(MX93_PMCFG1_ID_MASK, cfg2);
>  	writel(pmcfg1, pmu->base + PMCFG1);
>  
>  	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
> -	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
> -	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
> +	pmcfg2 &= ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
> +	pmcfg2 |= FIELD_PREP(MX93_PMCFG2_ID, cfg1);
>  	writel(pmcfg2, pmu->base + PMCFG2);
>  }
>  
> @@ -476,12 +490,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  	hwc->idx = counter;
>  	hwc->state |= PERF_HES_STOPPED;
>  
> +	/* read trans, write trans, read beat */
> +	imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +
>  	if (flags & PERF_EF_START)
>  		ddr_perf_event_start(event, flags);
>  
> -	/* read trans, write trans, read beat */
> -	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> -
>  	return 0;
>  }
>  
> @@ -596,6 +610,39 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  	return 0;
>  }
>  
> +static int ddr_perf_add_events(struct ddr_pmu *pmu)
> +{
> +	int i, ret;
> +	struct attribute **attrs = pmu->devtype_data->attrs;
> +	struct device *pmu_dev = pmu->pmu.dev;
> +
> +	if (!attrs)
> +		return 0;
> +
> +	for (i = 0; attrs[i]; i++) {
> +		ret = sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i], "events");
> +		if (ret) {
> +			dev_warn(pmu->dev, "i.MX9 DDR Perf add events failed (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void ddr_perf_remove_events(struct ddr_pmu *pmu)
> +{
> +	int i;
> +	struct attribute **attrs = pmu->devtype_data->attrs;
> +	struct device *pmu_dev = pmu->pmu.dev;
> +
> +	if (!attrs)
> +		return;
> +
> +	for (i = 0; attrs[i]; i++)
> +		sysfs_remove_file_from_group(&pmu_dev->kobj, attrs[i], "events");
> +}
> +
>  static int ddr_perf_probe(struct platform_device *pdev)
>  {
>  	struct ddr_pmu *pmu;
> @@ -666,6 +713,10 @@ static int ddr_perf_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto ddr_perf_err;
>  
> +	ret = ddr_perf_add_events(pmu);
> +	if (ret)
> +		dev_warn(&pdev->dev, "i.MX9 DDR Perf filter events are missing\n");
> +
>  	return 0;
>  
>  ddr_perf_err:
> @@ -683,6 +734,8 @@ static int ddr_perf_remove(struct platform_device *pdev)
>  {
>  	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
>  
> +	ddr_perf_remove_events(pmu);
> +
>  	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
>  	cpuhp_remove_multi_state(pmu->cpuhp_state);
>  
> -- 
> 2.34.1
> 

