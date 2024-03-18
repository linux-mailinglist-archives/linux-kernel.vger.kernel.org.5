Return-Path: <linux-kernel+bounces-106519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1548887EFC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF31F23BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7A219E4;
	Mon, 18 Mar 2024 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h2ulOl9o"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B1256A;
	Mon, 18 Mar 2024 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786660; cv=fail; b=oT9yxFafhTkp9TmJowhf1K1zpP5Kvd2hK5jZTjvm3l18OKIw8VBgRerX0fO4yl670OEnlOUJRQGe0U5jtKM61ofMGlixMrRqk2fqz2bdV7VHcdTz6uVkW3V4aI1mbHUmOZ0U/WTCTKH0P/wFK7N7VIelk/ARdklztdaCVDz2o3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786660; c=relaxed/simple;
	bh=FzCrvRcWDzUcSnbjLXNEc3bipyTK4KkJHWAQebr1wPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fb3CllHqtOtXIAdnwe0q33mR0lAM5dhmrBWaTje98LJItzjQdVlGPwFR6Yof61wDmpcB03thkDYG+xcxstjY3Hi8gaaMFh/Iuomi0rPAWZUOWPrMYsaCT6f63VyBKFDyaIXNlx/MHpB2HecvuQShJgo0XzT9E+lcE5nRS9PxXSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=h2ulOl9o; arc=fail smtp.client-ip=40.107.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqtTaYaGT6O5GwxQEzLBlNMNnlSuuXYLg93b498T5qpcRGpmKjph0NCGIr0OuMQB4/bJ2J9vC70wvmLEvx1tLQqj3CeohH/hzBKtyh5S+sq2t8AOYrUWaYDFdSye8DKd5fpgDPUp4meeDRVpATE81kmCc278pYYCDxEUaIoC+YB0B0P3O5FkbpiLAudtbigUe2pBqntW10caMEa8rSM1jvhl4uxIsDEewmW8uR9ki3z0eNLatLrKQkDikW2AZ5HJtnF7WF+JiZOoKETn4wUOq+Pv4pZYB/d19gpPI/ov9md6S7zss/sGSXLfC1pC02EvnSj/iV85t0RVd5yOaGiP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qIlO4/Aa6ErrNyFI0rakhJRO3bJo5FsnCUdClqpAX4=;
 b=Hq+UiDGuVdEYB5fMgXSVgOoyWB4k5+ph2clmCOWrDdBnhCd08cadmWAjzuaYcgEON98Tp5NXW6Rb5G58wBFWkkKBKn5LjaOQ2VbG5/kNgzxaln7j9Gr5ksFCKHkFMtJLKCcSoLMKd3/XuBcOy8QJvJHOroHvsSGHsn7F1tX+DGtpDyRx+pWQmlNxWtJuTMCaew08G1haYx3Apo7WC/RxARMlrd0xRuFUfi7cRk9PsMfJ0pNESfKarYY1TQ37X+2jrHM9awb/QvdyybT4G4lSOHqST03OFLetkt9kGx+2rhbzu8J8gurD0j5oYqLp9HRmh3tIaZGrWmq4wpe3VV8hKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qIlO4/Aa6ErrNyFI0rakhJRO3bJo5FsnCUdClqpAX4=;
 b=h2ulOl9oxItgQry4rN9rpvPJTsfrgObtIqdKj2f6xhokAkx3DrBy/sTxHyNSHPauoe2haAADZQfYEF5JeokQBEfM8D9LwKsXoQaF1MLoDJeS6D3No2X79t/Y0NU8Lz29me2WwIPs+/EsghYOrGzziNgkJu+3JhlTAzagouOE0ZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 18:30:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 18:30:55 +0000
Date: Mon, 18 Mar 2024 14:30:43 -0400
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
Subject: Re: [PATCH v7 4/8] perf: imx_perf: refactor driver for imx93
Message-ID: <ZfiIU6EyI9J4ynTk@lizhi-Precision-Tower-5810>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
 <20240315095555.2628684-4-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315095555.2628684-4-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: d899f83c-5c90-43e6-3283-08dc47798be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HM6heGsTGdOsHvyGCEBzYDfc/yJ9F8DY2i4vGPynYwptngkGHR7pOPrQ9FdHOuXOwHQ4qCEFqESt3H90ut9doHp2GiqXD6wtGohc3xkxkwmsJvKSzqDK8p1GjHmACsZkEFSs7dJBMYTaBE5FFDbIeRN7kRZbQEsrz6MYx2blcIkab6rHl5PpiYVwNv+10RE50FUI+0we0tK7NAxHo5E4vUHskpQJl1cYnVClXXHLvf/0eLOHNdvYjaXflxvDqjw/42g2OGe3Tp6CD8DjzwHUjjIBYqFXAMTBswqnqe54LR89A8coZV8GWm+dSFs9/OzSe8MYbujlcrFlAaPDuH/JTHzHO7nN+FvU8Wd4iPPn/ToUDHNya+np6/a7XSOppLCv40tkEjxxs6LiWdvaMkgmpJjU4a296U1tIYOkxjb8ZBjLG9Kgsyzkcx5DC+SNXQQrp2+71dY5+QZRPzdrXXouo9JiKYGn3hgOo267JpNIYVeAQ2lTi2foq7/5vK1ydhw9DQt4eNG6CHSiKxOEj7aU0McuT85Hn0g4qPEzjuFrXUgQnYd7ra365qHtbd/3UBaSHbB4ZC/I47WaTYff4LcvPDX1yGGtmI9Q4GNYu25mXtgFeA1sLFEMwg0kLhzBlkDFBKgFDqDOgyrH9I51xNq7wEXEWOaOVWw0MY1M4+WjHbOUP8LJQp0PocaEVezHYKoiB+bfwbZqoYEr3XwaJBTJcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?psfHOwA8z8lsWMCNig8cawQVxF5OfHIfbzSFNWaVLhnuAz+LIg3nH1vj+2YN?=
 =?us-ascii?Q?2EFOv0GAMq9MzeOPT85knlyZXcCpKwEyipMx03oZ5gHOcBn7lXNkgqtTZK2h?=
 =?us-ascii?Q?/ky5aA+GTm5B6MyBFREZTrMf+g5pkq6dQex/bZDiyHF9lfou5n38rGmq9gew?=
 =?us-ascii?Q?3gxKcvIMLK68Gq9kj5Lh3htwH+Q2OJbyKQwN47oqOG00UL1JBymm4iLK94kn?=
 =?us-ascii?Q?V0GwdYPxj0HTaVj3UtvvQyi0O4tqE/ZD8vEDqIv1a8WMDAjH+OWOZV/6z2a4?=
 =?us-ascii?Q?pAbYxK4FgICUhkfRvorqoh9NeypOR+SEcMta2f05EtiFsKJYY9YXq+ONKyS7?=
 =?us-ascii?Q?IVbMUvewulyfJoSnLYVjA8Jz5bQywC95tXO7cYqtvJw1Q7O/k1dOwRTsjWY7?=
 =?us-ascii?Q?Rq4KBBJGUiOOxdNXUYq38gWYeJa1kuaN+NgTDQoyHKzSsyz58HxTWEzajXQg?=
 =?us-ascii?Q?Vy/llMoIy4rzqITs7dNrhWu45Ke9SkC3rCQWWpzU1Aj1VgJlEJvyGqHN4dRh?=
 =?us-ascii?Q?3qPjCCMNLlbBlKuYd20rjpQjAjY6/P3azoBw8qtNtv4PK3uSxJzpqGjazOi8?=
 =?us-ascii?Q?4Y4mrPPZfmZ+skIoP3AYSMIJEQmyWrMdawfUOyui/zmkAZjqkzPgWSHfKNwd?=
 =?us-ascii?Q?G857k67VhfX6Npha8PKeZEXmaAHoKQ3TvPhIpTq0uW8Bb6GdVRuaTvtQK80O?=
 =?us-ascii?Q?t+jcD5Dt3ihQ2qvZAyHZIW1A9aHyULeqzieX+TEObEi43zymIHwSiBsN8evT?=
 =?us-ascii?Q?x6E/XdfH1dfWmaJ7Ao2fPMct92bq1hWlZN1WxPTqxDs5GL2MU0saIQB7exci?=
 =?us-ascii?Q?7zMLxZM35sHF44HmxF3FDXqFNVZQJo+kM29DJuj/XSHh69MUUXK21E7upusG?=
 =?us-ascii?Q?zXf57nKyBBuy0TB79ShBpQMF2KUeWRi7j6437ui3764VyH84AQy8i/Baajjh?=
 =?us-ascii?Q?owiDOsequHwEZysxkp/UicoQWNy8O8h4LfKAPKpsJS1O6qXAnRgtDRB1Avxt?=
 =?us-ascii?Q?mRF5TaM7CXLJmCKpbkHBsSdPjGYeBz8+X4ld68sT9a+R9tx6kb5qLNK2yvTn?=
 =?us-ascii?Q?IuMJyXUEu6vreyAMsf3yRHenKMLq0nsiQrdYR2aCYV6JhmnChasTurkee4Vb?=
 =?us-ascii?Q?3ZemiDilVwtp9+qgfnWQeg7OPi+aJHip2ILphlNtzgYul8GrDrerZHpVosvg?=
 =?us-ascii?Q?hu/UeLmTZrHRY+GiBq0uPv4yyEQM8TZ0BcAP6uXvC7bmRRQ0AL3uwoImRBi0?=
 =?us-ascii?Q?ej1Ng2XWYe/Ty+I/oIOp6IZTtZu8bNbz6h1kVzhvzxxwTmG3VA48sYnVZwZy?=
 =?us-ascii?Q?jNB7Pp8LwuGHGaCMHINtPI8rhg9WSI6mpP1QjMRVJBIiFrAnMMKYsqPTprC9?=
 =?us-ascii?Q?M1Qlt7l3bDXeJLw8d9QU+0dpyEf8qq2CSpWX6gQx78o8vgSwiEW0F/T+ar6l?=
 =?us-ascii?Q?4jcm+FX8iJ36OZIyoewx77zY/KPqREQkPpF/8AbluQ3MlPtjiVUQ+wByzC84?=
 =?us-ascii?Q?t6Hmk+bkUiXCOqvAafjqKZM9VlIe9/dWgjgrhuzJBTq/qv7NsaqQ0yP3aqbD?=
 =?us-ascii?Q?PdlMB5H586vCKl9BFyE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d899f83c-5c90-43e6-3283-08dc47798be0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 18:30:55.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frWi/hsqaY9Co2lqkqE3C6ziSG/7VPyzAvbwk3/JTBFMLYgRpoPt0qWnHzyanY9U1Lcq6VQgVcVaFuErkEbhvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

On Fri, Mar 15, 2024 at 05:55:51PM +0800, Xu Yang wrote:
> This driver is initinally used to support imx93 Soc and now it's time to
> add support for imx95 Soc. However, some macro definitions and events are
> different on these two Socs. For preparing imx95 supports, this will
> refactor driver for imx93.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v4:
>  - new patch
> Changes in v5:
>  - use is_visible to hide unwanted attributes as suggested by Will
> Changes in v6:
>  - improve imx93_ddr_perf_monitor_config()
> Changes in v7:
>  - improve imx93_ddr_perf_monitor_config() as suggested by Frank
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 80 +++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 4fdf8bcf6646..5537f4e07852 100644
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
> @@ -76,6 +76,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
>  	.identifier = "imx93",
>  };
>  
> +static inline bool is_imx93(struct ddr_pmu *pmu)
> +{
> +	return pmu->devtype_data == &imx93_devtype_data;
> +}
> +
>  static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
>  	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
>  	{ /* sentinel */ }
> @@ -185,7 +190,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
>  
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
> @@ -197,7 +202,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
>  
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
> @@ -209,7 +214,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
>  
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
> @@ -244,9 +249,26 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	NULL,
>  };
>  
> +static umode_t
> +ddr_perf_events_attrs_is_visible(struct kobject *kobj,
> +				       struct attribute *attr, int unused)
> +{
> +	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
> +
> +	if ((!strcmp(attr->name, "eddrtq_pm_rd_trans_filt") ||
> +		!strcmp(attr->name, "eddrtq_pm_wr_trans_filt") ||
> +		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt")) &&
> +		!is_imx93(ddr_pmu))
> +		return 0;

I think use name to check visible is not good enough.

struct imx9_pmu_events_attr
{
	struct perf_pmu_events_attr perf_attr;
	void * drv_data;
};

#define IMX9_DDR_PMU_EVENT_ATTR_COM(_name, _id, drv_data)                             \                           
        (&((struct imx9_pmu_events_attr[]) {                            \                           
                { .perf_attr.attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\                           
                  .perf_attr.id = _id,
		  .drv_data = drv_data,
		 }                                          \                           
        })[0].perf_attr.attr.attr)

#define IMX9_DDR_PMU_EVENT_ATTR(_namee,  _id,)
	IMX9_DDR_PMU_EVENT_ATTR_COM(_name, _id, NULL)

#define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)
	IMX9_DDR_PMU_EVENT_ATTR_COM(_name, _id, &imx93_devtype_data)

So

ddr_perf_events_attrs_is_visible()
{
	struct imx9_pmu_events_attr *imx9_attr = container_of(attr, imx9_pmu_events_attr, perf_attr)

	if (!imx9_attr->drv_data)
		return attr->mode;

	if (imx9_attr->drv_data ! = ddr_pmu->drv_data)
		return 0;

	return attr->mode;
}

Frank

> +
> +	return attr->mode;
> +}
> +
>  static const struct attribute_group ddr_perf_events_attr_group = {
>  	.name = "events",
>  	.attrs = ddr_perf_events_attrs,
> +	.is_visible = ddr_perf_events_attrs_is_visible,
>  };
>  
>  PMU_FORMAT_ATTR(event, "config:0-15");
> @@ -368,36 +390,28 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
>  	}
>  }
>  
> -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> -				    int counter, int axi_id, int axi_mask)
> +static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> +					  int counter, int axi_id, int axi_mask)
>  {
>  	u32 pmcfg1, pmcfg2;
> +	u32 mask[] = {  MX93_PMCFG1_RD_TRANS_FILT_EN,
> +			MX93_PMCFG1_WR_TRANS_FILT_EN,
> +			MX93_PMCFG1_RD_BT_FILT_EN };
>  
>  	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
>  
> -	if (counter == 2 && event == 73)
> -		pmcfg1 |= PMCFG1_RD_TRANS_FILT_EN;
> -	else if (counter == 2 && event != 73)
> -		pmcfg1 &= ~PMCFG1_RD_TRANS_FILT_EN;
> -
> -	if (counter == 3 && event == 73)
> -		pmcfg1 |= PMCFG1_WR_TRANS_FILT_EN;
> -	else if (counter == 3 && event != 73)
> -		pmcfg1 &= ~PMCFG1_WR_TRANS_FILT_EN;
> -
> -	if (counter == 4 && event == 73)
> -		pmcfg1 |= PMCFG1_RD_BT_FILT_EN;
> -	else if (counter == 4 && event != 73)
> -		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
> +	if (counter >= 2 && counter <= 4)
> +		pmcfg1 = event == 73 ? pmcfg1 | mask[counter - 2] :
> +				pmcfg1 & ~mask[counter - 2];
>  
> -	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
> -	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
> -	writel(pmcfg1, pmu->base + PMCFG1);
> +	pmcfg1 &= ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
> +	pmcfg1 |= FIELD_PREP(MX93_PMCFG1_ID_MASK, axi_mask);
> +	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
>  
>  	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
> -	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
> -	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
> -	writel(pmcfg2, pmu->base + PMCFG2);
> +	pmcfg2 &= ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
> +	pmcfg2 |= FIELD_PREP(MX93_PMCFG2_ID, axi_id);
> +	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
>  }
>  
>  static void ddr_perf_event_update(struct perf_event *event)
> @@ -513,7 +527,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  		ddr_perf_event_start(event, flags);
>  
>  	/* read trans, write trans, read beat */
> -	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
> +	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

