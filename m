Return-Path: <linux-kernel+bounces-144496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7118A4715
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23EE1C2121C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2C1BF31;
	Mon, 15 Apr 2024 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XmoMxaFQ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D817758;
	Mon, 15 Apr 2024 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149199; cv=fail; b=NHxXezXDi6Yt7ySIWcL7u3sawj1SYAIM7qEtw/J2l09OZzyi86ANl1vcl9/RWYXGvvKtCgI2ywAQ4mozAFF567hpqZaXuFwBM2NCWcS7IMsn+fcxjFYSE7forPJATVam/3y8m9SIEnaOVjVqYaKB/wMWuCZuU31f2/cjleLbGPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149199; c=relaxed/simple;
	bh=hv3pjAVHe0F+bcdgZ0exaAz0ygS9fMJi0Z/jVoa9TjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=su58wIhBD/oSqMHoYwhPERNPpO1KlhtP2AAi/dGUJ/AC0yvHJL6P3gaXfxCBr71hIrMQ/Ai6MZyu5TiDNXnrDvLLP+fWQKgjeWGiU6AIEQq1ejUCePbuvsuk/hnJM8y51HpXh+RGL/BQV+hk66TaRSXeL6hjHW+WpVw8PqkGOxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XmoMxaFQ; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSub+dId1WUxQhCVECShQt261dclqO5V/UccCconyue0ON21RZXBwfo+IMuA5Ltx3rWrTi2nV+/fNJt/tcCogviL23/MEJIIzLYSX3LbI9BZBCJcdTKUCgo4VB9sEJeugXCKlp74FT/NnPqIFy29xb+Ncj3+p0qN4BRMxggeNH/JTgF02t8JlyvMqGqWP0+DaNkQlbKXMfE6MQxln0YHwY4WqgGO6T5Bga/g7Yx31gbJxGlu3qMst2zEWSuN5ecEMIZkRuAfamensuvbnM5VyONcCQJ38sB/DDeE4DbXgYbkQudBoWwaBujZcphjfxc78wo3QahzoZ0vfqtvU8LFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=702h39XsX0M8S8DP4UWwh0OfBHyaabrdSDZDninl730=;
 b=e3TLRnnvwArCD5XVevc0qDvhT45BE2eGsKJ91GSnkzgrxLDGFM35bmbBafWeJZpttBIKz3O0zDsZSaZJxSI/2oykGzuNWm2RkHoWJWFGDeSZxt4oBdoM0IBJhZiHWEUIS+2K+I3BxCkAb4HD4vObiTODYs1V8ixu8yxD2ukyFa/HX3EEImEB0jOXqRufDdCX98DTKPbTyeBV+k4sq80uL9v43sLb4X9PJqwxY6f92OfQgQ0e+avmjC2dIAwAKpi/CMV+HmAedhsy/UNoze6TuTqCUjRMUVq/WlRa3+avQrEsC0TducJ+2kq4nTL6s6NTCfpFT5QixNe1ucrcMj5tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=702h39XsX0M8S8DP4UWwh0OfBHyaabrdSDZDninl730=;
 b=XmoMxaFQ8J0ejbqOINcfnW4qHx6vih8iAipINegaF6JTMvj5k0uVdmqv2EhrXXlgI4FP2WB4vsxmhGL+gLPaqgzVN2OB/Nc5MK5H9p52fBpUBr0uSk4AwPWJEbIvsxQyvEeuhcJR0NV1cyJlrcUHLfEMTBxrD/P2Yo9FR+O/WFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9778.eurprd04.prod.outlook.com (2603:10a6:150:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 02:46:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7409.055; Mon, 15 Apr 2024
 02:46:32 +0000
Date: Sun, 14 Apr 2024 22:46:21 -0400
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
Subject: Re: [PATCH v9 3/8] perf: imx_perf: let the driver manage the counter
 usage rather the user
Message-ID: <ZhyU/ZSByYz3LRsm@lizhi-Precision-Tower-5810>
References: <20240415020353.3833367-1-xu.yang_2@nxp.com>
 <20240415020353.3833367-3-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415020353.3833367-3-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cba8f3-f839-4624-3c01-08dc5cf64270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ar2T1kJp1myRDjdFjTprE0gDu2x0CxmFAoapCq+EZLUQZ17qc65aX5euyytqp40ceVOtkw9KGRlkCUTRRTx4Ep2q1Gq4b5k/aJ7rFMWVM3ZukYl8/tl+QUnCn12F7baalIyGLcULEYjIhmYEEP0GvTAcAEiA7O50wH3p+o3qsA6TM8HrkC9Q1S//082ulISjTkZfSAOjME6ndjoS7AturAmG2fTINY6ea2dsk2W5SS4d56zYBtNl4BFvX9UCLfKmvEbzDBThIBMkP7Sa0B3XLrtKJcJErg5WxNjUKT37h50tnLdRVY5f/cA4+w4Ombjqm3MfEEz3goFeo6jsUsxvkdRh0H1uu5aNYOJyO/bb/c3FzhePRq7FZfrt2ouuLGl+PKlyAxUA/hRvN+w35tFoYf4ajMAidEA7VRGACO54Nnsy2Vc4h3fhUkU+zT4oo+eRuHKBYXLAxKLjMfFCLHCF/n/Mj8a0CijHmXywug4brj52eQS9A0YhZgLGGQ6pmryBpt1cvhOSkceVP63sS4/pYuWAyH8GY1yaplQ84c7uC/obbmU8NFPQrj6C2gEtO8LRorgKtlmTwdDH4V7f1gYQlFFBwrsopEwnxueB8F/jfce+GvQDqZa2sK/9pF7RMSehKiJYdKZdr1SgQP2hVY/Ws3dA8l8YwKi01dzjBv2iS9NkNa3fXMuLV5+kvXM4MRQ8i1AbBtFG4b6+tXbHQcNLFzBzwu3B2LaKMv0zOqEdTAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VSEDKhewgZvAPRyVmGBidiZ3iUOmjJbSNNFaBdhwl/7F8BWSdLi1xZ05bPyW?=
 =?us-ascii?Q?qHkTm19VOPLfmj9iY5GUTD7uHYcm1vjuBy32xcyKHHZn++FRc8/o85lmUeUs?=
 =?us-ascii?Q?cJqhtLaNb3VEoZQvYmGZMtsBEygYr/mKhSDAvX4yofnRo+0Nx8PoewQXqu0i?=
 =?us-ascii?Q?2W/InHAYdVfs355j2XXeZbdTCvXDAWIHGHIhS74EMsOTDnGimCsMSIWskjvx?=
 =?us-ascii?Q?MTnmieSfkjSlw9+RQWwI1ZdikQ0rZSMP+q+9F3doitEO9mxawBEvo+MlBpVi?=
 =?us-ascii?Q?PskJZMri5DXWWMSbtJ4GkeizcIoXCR3cyewvotsBS7sYXKGsPtfMErsISELa?=
 =?us-ascii?Q?UWabwq4KABaEQZfZP1hpWrxvn2e8vib9XJQ1FnRIBYoAdplg2Yuv+S0mDzqE?=
 =?us-ascii?Q?lXf1vxFWLR3skYR3HtT3kAsCYA2b/SuJ0CPxvMAioH5tB3Gif9fHOBKdwBiD?=
 =?us-ascii?Q?siXZIjzDAF+uEGkbB4r2nFOfVYXrovI5Fw+OtAX7kmu/6jIrwnxMaiv8kTk8?=
 =?us-ascii?Q?04PvyLsS02gOAvRULKFzH4Nv8xSjdRa3UCS6Rk0JUiedTewmxqFGzUADCNlw?=
 =?us-ascii?Q?HnfEXX3nXyl4kdJKB0TTJchny5EYRJutHzkw9E03Sh72vu9KGCMpb2+JOaGk?=
 =?us-ascii?Q?kjVP7vhXsGOqzhC3BJXyv//s91URsEdh6C9Q83QFh9SXYbZtfAmfv9md1BtP?=
 =?us-ascii?Q?oPJ9+2bXGVh7yE5ohaptgzBAhzqUiyXbexiltYopOFZMgympVIApVXDUXUPG?=
 =?us-ascii?Q?ObCHJjBEOIFua6fC0Q3L4BXhOFCxgBhrIX1SAOEaYDlexCx0Y8gHyFo1omyE?=
 =?us-ascii?Q?dBsW+5BxSbQYjNqH7ozM+F4D86nJ+Ghn+c1TKLfk6KnyJNY16wze60ob3+VX?=
 =?us-ascii?Q?SsyXpDoMQLyhrlf0VAAihwUwGhQzmiqzyTiLjuA/hE9Ju8Nj7ueZmLpuUMMf?=
 =?us-ascii?Q?pntiPGc4ev8cLzbUHvpYU/9CennVWW3ZbmcNHY5aWeKAnavLhzzhPZXLEp7c?=
 =?us-ascii?Q?udqCvlsyOsLfgQbQSlu6UHA3DzeIeXCkTVn+QBw1qe2rHzPUIGFvsL7QIR0s?=
 =?us-ascii?Q?n49q21uecRLdqI3lW59ArXKXxwZndxQsIjxoekWR1Wm751+nuHZs6Wn40FB9?=
 =?us-ascii?Q?GZ9G5C3S7jQ2ErX47qkoX67yhl44hXXVkcbkbcF/dxmIQgoxbfEr8j0q/Zdh?=
 =?us-ascii?Q?O/tgni0oO139zeG+d/pScVK0msp0VyJvKo8lz24jPNubdhAcim+pI8H7K9vm?=
 =?us-ascii?Q?KM7zXoOIb5ezkcS3AOwpKvNO9Ygnxvt9zGp5u5ensOPZaVmTReaO9djWhSpp?=
 =?us-ascii?Q?NlOV369+nH6woOBr2kDly9UCjNw4Q59HDzwFRbk5SUX282h4N2rDWRQDroo/?=
 =?us-ascii?Q?zKQv6v3hg+i7zaYDXN4wzzAOUpzGsiDPwb6QYJB+f630mF9eXEPp7BNN77Ki?=
 =?us-ascii?Q?oH3oAJq722HJqrJF0buVRCuysMdHTywdXhIl/ROGBwHvETa55791qP5RWgYq?=
 =?us-ascii?Q?Szo6G9TpNN3Rj7wIT/jFGLxs0ib4mWYBe3Q73+ZVdOjtIq8a7lNTJEqiiGrL?=
 =?us-ascii?Q?eewcmedNvV7nldzgPrttdXX5Kx3RNlFD+PajCPnC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cba8f3-f839-4624-3c01-08dc5cf64270
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:46:32.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dloxE/ZSTnRo0h5TEBNMB5idMMcfC/pAh9JnWCWIWgo+9L2wtLO8GVOU+7iZ8+OySQQM0G2xW+XOm+PAeO2eVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9778

On Mon, Apr 15, 2024 at 10:03:48AM +0800, Xu Yang wrote:
> In current design, the user of perf app needs to input counter ID to count
> events. However, this is not user-friendly since the user needs to lookup
> the map table to find the counter. Instead of letting the user to input
> the counter, let this driver to manage the counters in this patch.
> 
> This will be implemented by:
>  1. allocate counter 0 for cycle event.
>  2. find unused counter from 1-10 for reference events.
>  3. allocate specific counter for counter-specific events.
> 
> In this patch, counter attribute is removed too. To mark counter-specific
> events, counter ID will be encoded into perf_pmu_events_attr.id.

In change log, you said keep 'counter' attr. You should memtion keep 
user compatible and but omit all value pass down by count=<n>. 

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v6:
>  - new patch
> Changes in v7:
>  - no changes
> Changes in v8:
>  - add Rb tag
> Changes in v9:
>  - keep 'counter' attr
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 164 ++++++++++++++++++-------------
>  1 file changed, 98 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 0017f2c9ef91..b00cbd920c0d 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -41,9 +41,11 @@
>  
>  #define NUM_COUNTERS		11
>  #define CYCLES_COUNTER		0
> +#define CYCLES_EVENT_ID		0
>  
>  #define CONFIG_EVENT		GENMASK(7, 0)
>  #define CONFIG_COUNTER		GENMASK(15, 8)
> +#define CONFIG_COUNTER_OFFSET	8
>  
>  #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
>  
> @@ -130,6 +132,8 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
>  	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
>  }
>  
> +#define ID(counter, id) ((counter << CONFIG_COUNTER_OFFSET) | id)
> +
>  #define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
>  	(&((struct perf_pmu_events_attr[]) {				\
>  		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
> @@ -162,81 +166,81 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_pm_29, 63),
>  
>  	/* counter1 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, 64),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, 65),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, 66),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, 67),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, 68),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, 69),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, 70),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, 71),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, ID(1, 64)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, ID(1, 65)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, ID(1, 66)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, ID(1, 67)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, ID(1, 68)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, ID(1, 69)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, ID(1, 70)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, ID(1, 71)),
>  
>  	/* counter2 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, 64),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, 65),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, 66),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, 67),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, 68),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, 69),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, ID(2, 64)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, ID(2, 65)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, ID(2, 66)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, ID(2, 67)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, ID(2, 68)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, ID(2, 69)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
>  
>  	/* counter3 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, 65),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, 66),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, 67),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, 68),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, 69),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, ID(3, 65)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, ID(3, 66)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, ID(3, 67)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, ID(3, 68)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, ID(3, 69)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
>  
>  	/* counter4 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, 65),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, 66),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, 67),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, 68),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, 69),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, ID(4, 65)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, ID(4, 66)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, ID(4, 67)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, ID(4, 68)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, ID(4, 69)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
>  
>  	/* counter5 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, 65),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, 66),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, 67),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, 68),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, 69),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, 70),
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, 71),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, 72),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, ID(5, 65)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, ID(5, 66)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, ID(5, 67)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, ID(5, 68)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, ID(5, 69)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
>  
>  	/* counter6 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, 64),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, 72),
> +	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, ID(6, 72)),
>  
>  	/* counter7 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, 64),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, 65),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, ID(7, 64)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, ID(7, 65)),
>  
>  	/* counter8 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, 64),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, 65),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, ID(8, 64)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, ID(8, 65)),
>  
>  	/* counter9 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, 65),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, 66),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, ID(9, 65)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, ID(9, 66)),
>  
>  	/* counter10 specific events */
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, 65),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, 66),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, ID(10, 65)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, ID(10, 66)),
>  	NULL,
>  };
>  
> @@ -366,13 +370,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
>  	}
>  }
>  
> -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
> +static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> +				    int counter, int axi_id, int axi_mask)
>  {
>  	u32 pmcfg1, pmcfg2;
> -	int event, counter;
> -
> -	event = FIELD_GET(CONFIG_EVENT, cfg);
> -	counter = FIELD_GET(CONFIG_COUNTER, cfg);
>  
>  	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
>  
> @@ -392,12 +393,12 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
>  		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
>  
>  	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
> -	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
> +	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
>  	writel(pmcfg1, pmu->base + PMCFG1);
>  
>  	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
>  	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
> -	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
> +	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
>  	writel(pmcfg2, pmu->base + PMCFG2);
>  }
>  
> @@ -465,6 +466,28 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
>  	hwc->state = 0;
>  }
>  
> +static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int counter)
> +{
> +	int i;
> +
> +	if (event == CYCLES_EVENT_ID) {
> +		// Cycles counter is dedicated for cycle event.
> +		if (pmu->events[CYCLES_COUNTER] == NULL)
> +			return CYCLES_COUNTER;
> +	} else if (counter != 0) {
> +		// Counter specific event use specific counter.
> +		if (pmu->events[counter] == NULL)
> +			return counter;
> +	} else {
> +		// Auto allocate counter for referene event.
> +		for (i = 1; i < NUM_COUNTERS; i++)
> +			if (pmu->events[i] == NULL)
> +				return i;
> +	}
> +
> +	return -ENOENT;
> +}
> +
>  static int ddr_perf_event_add(struct perf_event *event, int flags)
>  {
>  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> @@ -472,10 +495,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  	int cfg = event->attr.config;
>  	int cfg1 = event->attr.config1;
>  	int cfg2 = event->attr.config2;
> -	int counter;
> +	int event_id, counter;
>  
> +	event_id = FIELD_GET(CONFIG_EVENT, cfg);
>  	counter = FIELD_GET(CONFIG_COUNTER, cfg);
>  
> +	counter = ddr_perf_alloc_counter(pmu, event_id, counter);
> +	if (counter < 0) {
> +		dev_dbg(pmu->dev, "There are not enough counters\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	pmu->events[counter] = event;
>  	pmu->active_events++;
>  	hwc->idx = counter;
> @@ -485,7 +515,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  		ddr_perf_event_start(event, flags);
>  
>  	/* read trans, write trans, read beat */
> -	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
>  
>  	return 0;
>  }
> @@ -506,9 +536,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
>  {
>  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> +	int counter = hwc->idx;
>  
>  	ddr_perf_event_stop(event, PERF_EF_UPDATE);
>  
> +	pmu->events[counter] = NULL;
>  	pmu->active_events--;
>  	hwc->idx = -1;
>  }
> -- 
> 2.34.1
> 

