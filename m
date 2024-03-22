Return-Path: <linux-kernel+bounces-111625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD3C886EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50708B20DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65D4481D1;
	Fri, 22 Mar 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bz1KyZwA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879198F61;
	Fri, 22 Mar 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118061; cv=fail; b=Wsc+CmdfgmJn4TUxx/d6zs+lkTbgzJ/9gFsbBsk7NlHDyf08SxzE4pASkYTw7HogvsmGZ6Z1XuNFXuZKV1nfq0RG74QsQKcy473uhsmy21OD/kyX2vjQTHrBFWKF+fOo223o2l1sGbAwyqdvTtscoGzVWL39iNOaIDAJr1HLIKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118061; c=relaxed/simple;
	bh=Qa+LsOZF4AJvfF2PnUVoROQNRaO1MLQU4L7W70KtmLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPYLu6NsxyjDnl2DrRQy4BiDq80lhJGtJemyS6KJeWRBKUvPIZx32r71Q6FzsvgfV725nauPVRCXHUeZT/krqDdDXc6T0tisH7IOzTBIxOcxmWZgPMONPmYXw9IqTLVW37CMpmfVdgYD4fKYEzC+vlYvHWeCjWvZ0cUQwHyKQNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bz1KyZwA; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMtRIMsVon7XzaxtMJpYiQvH44LpzEFGfTn7lJRWCgbfTYp/5iBKZx6/oqqcNDVnMW97tOsIHAiNPiOByHJmVDA2boPg7QWGtC15vutQ8r2/AiXPy4Y6tuEJyDozE1dkrj96RkaaOGCh73/ecy6Vrei2gGFxP8jaB/JFOsAncBE2GObe2HK7jUPg7BYJ+wCGVlb2ZzE2dqEuAafvqaH0x9Jhj2OC9GYAy96hEyfp2STg7reo7yJtp3vAKtimgD3rf2KCA1QjQ9rfCVSIoLYKKiG4HZ84pH8trIYLOUUBIswyfJPwx8TSPqIjNee292rmZmMBYt+3/tYyQzmzn78irA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCPGOzJ0zoZcQ6ZmDOiA6zVnQ1sR/tcY+911ZWop0tQ=;
 b=ZWIjk5YQw36rP3bjnH7BHA+EEBttIXyTRW9tiOXd2JKEEn2OBpIJKjMTjKtG25Qj0qgSEm+HSARxl6SPEd/7M3DcYKelKjAiPlAeqd6eTC5zY+E30C/uJbuI1CDMqI0Zsy261bLSTHKGbCwOyxRn/gfHtio9FvV7LLBNvgKZtmAeD0OmdUs/P472lnQHbA6h0jyBosMCyXxR8pbbt2Oyglc99KEs9CBah8rbUKVyoUWpvxUbDz3kr8qkNBWBH/fK8EFLLsrA+94VixYmDeQm95fH+jtGZHkmKWRJCrfHTJ0Dpn4t86ku1vBaXxN5YVQJ6zwVzQbJ3wTiCfyMewC02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCPGOzJ0zoZcQ6ZmDOiA6zVnQ1sR/tcY+911ZWop0tQ=;
 b=Bz1KyZwANY6pVfDHTQrpPOWkR0C8zcU+RNyA1vbM2ThIF8C3qB2UArb8jRhdt+J+wDjCcgjrnj4x/za2NQtDFhUjSNor3Evlu+H3jCAnh2pBKDMRZdevuyU/EPNCEHQinEmqj5WX1HDpqaIHQB0yE2Sz6BnfM38FTe0rBeZlbZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:34:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 14:34:16 +0000
Date: Fri, 22 Mar 2024 10:34:07 -0400
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
Subject: Re: [PATCH v8 6/8] perf: imx_perf: add support for i.MX95 platform
Message-ID: <Zf2W34EDeamrJQDo@lizhi-Precision-Tower-5810>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
 <20240322063930.749126-6-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322063930.749126-6-xu.yang_2@nxp.com>
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e88d8e-0732-424d-8ab0-08dc4a7d26db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4UU/cllRMUUsS9TC6KTLkV6MkcKx3JYjyiFBiFGMFvT2+FSkrfQsPiDDii8HSmAt3HgSau+YEJ4EeV1wmPL4uHGaIDvU1/YnlLh2p5eDdPzkK/vn1mx17HSmuhJAuuI885x6LZBiyAHf8Iyu/9Nu9oDp1DvLNpyv3+A5AZbmAa63rgqoRDxOD7kQ1v9eefQ3N/y9RNicUcRKSiawKWoRQEanqHt8h6BV5wGSEQzeLV8T7eZtE/Eksd19tHQ0NzaImk1JTLup3woPuqm28PDSE4P5h6zfXNnc30I8PF+nnLj/VilkKlneO2kz20XGRLymBBoeaSKGMftjNzKNzxBBsLa9X9721z2wmBWplWAqTotZ8kMV96BITjJ52qUf/ij0PpTqMq/aoRLQ/W7bjf+gJNY0y70j+q+IN7F9uKB7MNLT9Bnya6Yw14GZbHTF1ys4ObX5QbhbkGwYSHCPwTQXJvNU0wTPyszzmjmvd8+SJBFsB3UfDJER6cghhwqkGScc8lDeVG1/26Ig/f/cxlS4rAY/uNIsKl09Cid7Ed4cNbEzfy0MIWwKFQU2gMbd1EfVwDmuCAhtwmbeZ9gE+I0/McNqjIC/1jhaAmwDyFH97BHZ84RqHWLLGTjXXdEpIEM54YlOGGS4hI/prTCfPcWgfxYfH//CX7/hgZEnlypSXTdcaf7jUjJz7/iZJHkZZ+6Kr2w7XBIFo/nCHjnbRmlhdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TZHjp6GKWlUOxjMRbue5HnuRCIyffhYr7s80J6S2bfwhXh+8UCgWYCCokVhF?=
 =?us-ascii?Q?rdGNS6Hztt4HEJz7iq7PuuOPSa6INEJHITZ/GT2j2ZsJ0dxPoKP/aY5+qUGC?=
 =?us-ascii?Q?n68HZ2/UXjI/fRGE3/0F7XpNN8+Drx8rpvPrO2ZqjjXF6QFTvwe2oI9Mwlld?=
 =?us-ascii?Q?wXZOrqsbEc4tcg1TVmvPdOZsPZKvQw1/p2hEqGFyRgLOujzBrFW2lxNHuYmn?=
 =?us-ascii?Q?5xs9gXURNuh0CFodxfxcfR47+C7EDhx5ktj3u2fxlXowUi0j+3bmWKjTkGwL?=
 =?us-ascii?Q?b9RH4CC4kGsUJgIxF0bC9z5qc/0BIfUir6HjAzlZ2BNFSVQdHi0v3nvmOhpw?=
 =?us-ascii?Q?q1NZJQ2Ak6236T0tZOd77g/6Ah1mxJMTJu7HdcJZTDUlP9RU5VFx1xuUoMKJ?=
 =?us-ascii?Q?xEPeTbJr4VaCRRLcpEATkZArtpSxKZumRhMqljE9xFJlB5W/Pbik77ueF4JJ?=
 =?us-ascii?Q?gDU+lZ5DSPXdfTZWZX2D8AR3pAmwX8TuqTjj8MAvvM4tj1YDDDZZTUZvmTwi?=
 =?us-ascii?Q?ogZ/TkC1031EhQ6zSBTDuanEK7LK10sEoSf1ESsOvyIz0U5G6+a3ymZ3pPlg?=
 =?us-ascii?Q?oitFgIOY55D+vXKsRII8X8NYfVwm3sHeDMya0twRVB/l/UwOX8sIxHcZKJ6P?=
 =?us-ascii?Q?aWjXK+Eh1T3U1e8KjePm4+BcoSDgD2rCMtKIRy4PIGoSLhLkQfo9h8HWHA/Y?=
 =?us-ascii?Q?U7o35OAnATYMpPd2w+2gS4K4MHS/XT4wOnAhLLEZVC9ICDEgBi5y1XRiKAMz?=
 =?us-ascii?Q?l1xwGaVHW5SQdf1GGGYeN6/H1mbVoMLITA2JZ/8PlbcPFvwg5+GuuMtrpJ9F?=
 =?us-ascii?Q?wxJab4e/gFh2mPN3nhAWleQoGLZXytN3iCqL126T/HzxKCZmmJtgz45PgGfZ?=
 =?us-ascii?Q?gexRT9l7act7vi3P5T+clGFhA1nXuUfzoUVbv8gcIIoKsV2auCQUE8qUEHEx?=
 =?us-ascii?Q?8LlqrkReui28FOCd8WfWyX5lUiKtfKD9MrPdPXNqPq8VeH450ME4uLYmIeQW?=
 =?us-ascii?Q?PAatbOXRicnFGNSpQkjWCn8LpIWzCp2S/01c0C1jWPNsNKydk+ITqC+IzYdv?=
 =?us-ascii?Q?056RpdkuWdg+OlFhbb9Lpusq7INqgvYTmbPNfjJB43LD/1D7KkaZk6nv9JGr?=
 =?us-ascii?Q?o7R5N4r9XIH1Lm8Bzpm6nrVGw16VngQ/u0GcyVvIRNs5F/zaGvlNNKVFhwb4?=
 =?us-ascii?Q?llb4p+27fwxTCUNAXBuRUfhvTVG7Y0IJnzxaLOaFp7DmSjvOHWI87Op2XD3x?=
 =?us-ascii?Q?TsDTKFioLwKY8GrDS2vFoJTR3Ivm24jOhFtsXTgS0bjHpjbj2Qc34PnmXC/8?=
 =?us-ascii?Q?M5ftoVpYgFSyupgYQN9J3Sv/twcn7GXZ4C10xA3wWuxD00CogWeA2BqshamE?=
 =?us-ascii?Q?5DEjd036T5YY6vmJlllYGm2NxUSTayd/uw9uV2esnNG5wRyq4Sl7ZFdrW5FH?=
 =?us-ascii?Q?Y3aQL+3gkRdAioth0p4W8uJ/eoBZ+5oVFBjxgY5raPCOEcS1kcxBD27WjSsc?=
 =?us-ascii?Q?6e3mW3AnxqM6P9FgFWEQyqPHMJy9LOOH7O2gJreo5WmbGaagNMu0zCdYnKCw?=
 =?us-ascii?Q?0IKqkolWbv5ohfn2yLiMilkNHD2QWFfcQr1S+2N4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e88d8e-0732-424d-8ab0-08dc4a7d26db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 14:34:16.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrWczSaoSFG7+WUyQ8+NkL7DvzJXM4i4jXlpb2XPx5NM+Wzsu392xx9Ap2ZE4c+ctuHudQYzxnBLLFv6qM4nXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707

On Fri, Mar 22, 2024 at 02:39:28PM +0800, Xu Yang wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

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
> Changes in v7:
>  - no changes
> Changes in v8:
>  - add definition IMX95_DDR_PMU_EVENT_ATTR
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 89 ++++++++++++++++++++++++++++++--
>  1 file changed, 86 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index fab6596d3e28..9dcab4192d6e 100644
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
> @@ -158,6 +178,9 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
>  #define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)				\
>  	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx93_devtype_data)
>  
> +#define IMX95_DDR_PMU_EVENT_ATTR(_name, _id)				\
> +	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx95_devtype_data)
> +
>  static struct attribute *ddr_perf_events_attrs[] = {
>  	/* counter0 cycles event */
>  	IMX9_DDR_PMU_EVENT_ATTR(cycles, 0),
> @@ -204,6 +227,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
>  	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
> +	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, ID(2, 73)),	/* imx95 specific*/
>  
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
> @@ -216,6 +240,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
>  	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
> +	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, ID(3, 73)),	/* imx95 specific*/
>  
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
> @@ -228,6 +253,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
>  	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
> +	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, ID(4, 73)),	/* imx95 specific*/
>  
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
> @@ -239,6 +265,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
> +	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, ID(5, 73)),	/* imx95 specific*/
>  
>  	/* counter6 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
> @@ -430,6 +457,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
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
> @@ -539,8 +617,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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

