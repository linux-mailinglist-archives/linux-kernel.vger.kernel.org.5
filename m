Return-Path: <linux-kernel+bounces-95909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77D8754D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08401C2354F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A021F130ACB;
	Thu,  7 Mar 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l0aUNogO"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7512FF6A;
	Thu,  7 Mar 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831157; cv=fail; b=kwiLvFteJuIrhh4KV7CfmQf96e8jb+Gxec6R3nOadIwbDyZrQ7b+3fzDgNmu1xIO6srzxZmoMWBlfKq6LIs8dx08mX+rr3MbEscC5flkIK5jbb1LNuLan9nQllRgU9kKoZFISpGCrLtIpxs26hf2wpknMGXYNxK0Oh9nTqVNkg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831157; c=relaxed/simple;
	bh=9ZG3cdshzjCjXANv4r+FRY2Pm3yTO6BWVJZucg2d6fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TPGBNAnLKGGK12ftAARmyzIbkhjmrGJ92bPn7afN6ZgegZ7OecsxbBXaQA773sXAjmiPC3qDrcdvmTdv8fC4A5Z5lCkwEQV/8lBWVReskE7J8kMcEAsJyqImyknmRQulnB3TOnWA+TCRR4KQjB9JiRn7ANVNIX3YQ8shKR3QEac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l0aUNogO; arc=fail smtp.client-ip=40.107.6.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN4aRfCm/6d1HrgdzrzHhyV/3SGWC8qINpinaFVKP9ARuiUDA19ohuBp4MXRlZRK/DHr16CbilX2Yy8loi5rTGhPl6SxK3vEqBjmLokZTEGvXPh2b/EICwikL3At8xgy4j622d/x4j2GRSonq47KjRLl09DvG9EZjGO1X9I8G6kYJJVMzqPUDx6YOmZst7GkMtx28TUe3WvBdMl0C0Zx7AbXKut6+12WfDgs52MXRWMUYZeFKm6I3A4+iRTvF9oVVvoBFCWMGxUwMndtPtoMYFEHZLBTY1JnuHx8BDLBFTifYtsMIKKuDNZP1hLBz5WKcK03YDD3Z1LBcSMiwI2Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKtZsdqQkw+16LZ3NR9eljDioYnIajoEZUwR1gUZx30=;
 b=oCCC6nlT6yBSO8RTL3CIAj37uf5pffZBFLfn7p47V+YFBqLwj7bakQwLpvZY544Y3SPahix0z+AhY0RnSpzXh+9tf9Bb6eHn25XR4C8jXguuFsNzIP7hjbm461im90ft11oi8N+r4SgIzNuHkEFt8ZW8VLPtcvJ85gT76w5/P1uUdhLYfE+FfF5QcVh9G8Y3pJz4Vv4qsLjRhjLLCmhl9Seqzef3wqyAUQFkE4Enj+lDK+G/qmBhvU8LmAkvGHIRXa19vGZdUdkfG3zIq9BC9ykN8gwprBQuAMYgX/VgP2G2YpmtwKAHw//4Cmj2wsUVnYWH9JwpGMrJ0Qxg39G1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKtZsdqQkw+16LZ3NR9eljDioYnIajoEZUwR1gUZx30=;
 b=l0aUNogOnnOVbNY7mnYUSndZfDc1FLsmrotpAPzNsccaZaBFyPIJEYvoSDpxR7xcxI7O3ivBiTn2WVYQfMIOH0QcyfF3zKChajJfJ1QdgFa35iAEregKHAhUr+bYleLjrrH/FLxACnHzhQ1toyC8tqGJEVRBzMPQsdt5NLdaX58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8658.eurprd04.prod.outlook.com (2603:10a6:20b:429::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 17:05:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 17:05:52 +0000
Date: Thu, 7 Mar 2024 12:05:42 -0500
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
Message-ID: <Zenz5ufZ3DIgbAuM@lizhi-Precision-Tower-5810>
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
 <20240307095730.3792680-6-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307095730.3792680-6-xu.yang_2@nxp.com>
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb0b896-f3ef-453b-7d90-08dc3ec8d83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g5ZHWm6jnNG6YxVgYc9Z8YlL+gOrsWZMcn/suocT0XRKyerEowDF8p705nGScYeudvE2CzMYTJwwPmFFV+dVsrahd6tWWWSIUoif5XHkrX7TIiGi6AwyTKtKpYD5RtsGVZsJxUWAdQbJ/UN1atIJtMr/1fIQTO6MrqDmxHFZ65gifjgKTVTI1NOvVm+uyu+GjdNMTY+gBXHC+010uV1yx8p0grsE23zeNGEazXaBiwcjrwOTSUpp8YDPxaviXVrTcadoKog00stnPjfobMKNYkrr5B1ymmp0+C2l9SObG5z89pee5B35HM6XFpFOz5y1Xs8kK/ti8lUCX3qgCZ0YO/n4/XUFJOXtM5ZZmWo5CBlQSSdOlvmMFqtWFqY4E+rVue7RgDthfwNUmyEHkL5wD/xqH1J8HiyuSWGfF59crjn90H76VcxDTOsVHfScjW9cjOZrOm1NhK1LZQGZ3C8wUZXlt6Viw2TRg37jmk4aqnhfcG6KBalPB6YTvvoS220pg1BHBqApvOCBO/SbwrmUYPSmp5fpVE3y8rtWdpafFPzuxyqlYZBqzRF0NY3PvplhPVjPsNAQFO/aRwsJYdQCPjIkNkB/jyQL0BuhcB3h8mwtETgD2GTW4fb11Hm2iRiR5FxrB4otnReEIlP+HFIZdI+na2jhceIPFPB2vIkEgAmjbXcXsv0utzMCUgUnvuc3fHGRiJ9Ee1T3Xv7K34yGEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Dxyqpz3AjFlGNjKIQxc6PrC/AZ+S5f1gF921Lt4s1y9diOo01WPYEN5ztxZ?=
 =?us-ascii?Q?IvLBJn3aCAnRIJecZ2wK5x98BCNOc40JdJ1lzWF+EueRgtmOgLtXD1WFj1k+?=
 =?us-ascii?Q?9XbyAdzWeNdihN02AEawB5pqwPZvvKtjimLK5LjpPUfbpz9XaxU2zwEyafw0?=
 =?us-ascii?Q?+5UBNZa2crNzz2Im/PGemhdddMrgnQP7VWYC7Yl++w81IUDxED3TYrHM+gt/?=
 =?us-ascii?Q?Srqbpr4hO+1UNBHdD3iIX0yQiGfhqC4jFTErq+2KmTUx3eKqAl/WP3u/UMmZ?=
 =?us-ascii?Q?K0FhCYwLT0PRHsxXouiHzg8OpMaKtVJLQKmIMgICbpy2qaigQXa1JoAbLbE/?=
 =?us-ascii?Q?drK7xAbOV7+sWlsAzNZMV1oV0jzDkwtrFiDE7bZgyCA1j9PxtPw+4InWlGCP?=
 =?us-ascii?Q?JTOKafUAJ4WpAgMKWUtR/MJ0Qzl7UrqFTw6rgt7ZWWXZvI9CUQyZWx/+CrBY?=
 =?us-ascii?Q?Q4Ex0kZjCMKcd/7Or+xOeQHjGlv2phkLtM8E+y4AR/v+RlmSlVztEMpnpCwL?=
 =?us-ascii?Q?vT/J2GomMTXYMekrwtPfHxJSxqD5o47fSgUSk6cxvISShrBZv+eIw/Wm+2Fw?=
 =?us-ascii?Q?Iedmvq7sZDXmoN889ewyjF9tbz49ZmR0R8xlQrQ34WdGq8guGgI67px855Qs?=
 =?us-ascii?Q?owu5YqCfs9NBE/B3oj9zSQ0rEzX5otOlhxIfXD69NKGc3CfbyxYdKjfsuK5n?=
 =?us-ascii?Q?5HMVz0ivFtrzfcjbWdZ6zOaBSHdJo2azEYWZcA64fFiKCQHV4hBo+Jp9thFe?=
 =?us-ascii?Q?rGdRZzbk3ga9OelcXNdBfGISpwSCI1w1BJcwLF5aFIryr/Asr8u072GSZstc?=
 =?us-ascii?Q?gJvkfmvN/1VB2RNJYX0OxJ3dqM1UeGxoCso0L75ErLa1TL4UQFnK19ebe+oI?=
 =?us-ascii?Q?ZfosiSgFoT3E3sStLGqA4aCU0S3NUiWVb6lpL0pYr+Vb2qBKgO+Td/krVIJU?=
 =?us-ascii?Q?Pvr1UVkOxN7TShLYlvi/CZSejz6NslN+551HMs1ZyS0dIAmYaMyDNNGGOg/+?=
 =?us-ascii?Q?hx4+fr3ZaQQpBMSLelB9aU2ag5R4oVGZ9oEIn41Neuwxqk3DTXPlePnjXmBZ?=
 =?us-ascii?Q?clbbVgOWuH0IUyLUH/dlUeRdaLqM00Tf0jTH9+DlmAXtmunBxfOs1Uu7LS6y?=
 =?us-ascii?Q?svTX1Ha0/McFNYcXRK0e2VvRpa4zz1x+aHaS070fPTp8IeBDmRjTCXPRKgMr?=
 =?us-ascii?Q?QoDD1dkF37oOsRgdwanEinwelVZAbZbW0L4dP5PLBkBu7DRu7SIajJpHuTVB?=
 =?us-ascii?Q?rw1Tv8yy3N/Sv0EhF5HFlOwiDP5AFfYFr6iVCjURIyPpqy+Ik2giSRtgHPv+?=
 =?us-ascii?Q?mwPA55K+PpGqjS1vCmcCUPifWmhV1RTv93n40jEs33gSanC/Zc0NtAuYQmtb?=
 =?us-ascii?Q?ArKvLuGIBQ/GOpxuGRyxITXALRN9fx04kU4o0I3RihfCQRAPsD7KHu9/v41/?=
 =?us-ascii?Q?WbWx4UOQ/Q1fNqxEnffvjKDbkuGDG+tmiJWOsk9yJ8uQE6VzGlDODnkFIJLr?=
 =?us-ascii?Q?JEObs2nofAytQB4bWBcO/z7gRzNxuqrdZX9JCsUy3Ocj3Ap0YsUVSSSMsEQ+?=
 =?us-ascii?Q?eS3SLxSzxg+/2+UuZpAPVUa+vy4mWuWHy9F2spxT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb0b896-f3ef-453b-7d90-08dc3ec8d83e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 17:05:52.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+PDBUQEhAQNQUgAOMTxXX5IFROxNs+0kdsL19sEI8TsJ52LDTDtJho2BTWjZap/ZT1VWeNBvD/hC3afWubzLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8658

On Thu, Mar 07, 2024 at 05:57:29PM +0800, Xu Yang wrote:
> i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> read beat and write beat filter capabilities. This will add support for
> i.MX95 and enhance the driver to support specific filter handling for it.
> 
> Usage:
> 
> For read beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,axi_mask=ID_MASK,axi_id=ID/
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,axi_mask=ID_MASK,axi_id=ID/
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=ID_MASK,axi_id=ID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=0x00f,axi_id=0x00c/
> 
> For write beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=ID_MASK,axi_id=ID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=0x00f,axi_id=0x00c/
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
> Changes in v6:
>  - no changes
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 93 ++++++++++++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 52234b97d0cb..a91267e2f5d8 100644
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
> @@ -77,13 +87,23 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
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
> @@ -192,6 +212,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, ID(2, 73)),	/* imx95 specific*/
>  
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
> @@ -204,6 +225,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, ID(3, 73)),	/* imx95 specific*/
>  
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
> @@ -216,6 +238,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, ID(4, 73)),	/* imx95 specific*/
>  
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
> @@ -227,6 +250,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, ID(5, 73)),	/* imx95 specific*/
>  
>  	/* counter6 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
> @@ -263,6 +287,13 @@ ddr_perf_events_attrs_is_visible(struct kobject *kobj,
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
> @@ -434,6 +465,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
>  	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
>  }
>  
> +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> +					  int counter, int axi_id, int axi_mask)
> +{
> +	u32 pmcfg1, pmcfg, offset = 0;
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

Look like only if event = 73, FILTER need be set.

How about

	pmcfg1 &= ~(MX95_PMCFG1_WR_BEAT_FILT_EN | MX95_PMCFG1_RD_BEAT_FILT_EN);
	if (event == 73)
		switch()
			...

So you need "else" branch.


> +
> +	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
> +
> +	if (offset) {
> +		pmcfg = readl_relaxed(pmu->base + offset);
> +		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
> +			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
> +		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, axi_mask) |
> +			  FIELD_PREP(MX95_PMCFG_ID, axi_id));
> +		writel_relaxed(pmcfg, pmu->base + offset);
> +	}
> +}
> +
>  static void ddr_perf_event_update(struct perf_event *event)
>  {
>  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> @@ -543,8 +625,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  	hwc->idx = counter;
>  	hwc->state |= PERF_HES_STOPPED;
>  
> -	/* read trans, write trans, read beat */
> -	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> +	if (is_imx93(pmu))
> +		/* read trans, write trans, read beat */
> +		imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> +
> +	if (is_imx95(pmu))
> +		/* write beat, read beat2, read beat1, read beat */
> +		imx95_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
>  
>  	if (flags & PERF_EF_START)
>  		ddr_perf_event_start(event, flags);
> -- 
> 2.34.1
> 

