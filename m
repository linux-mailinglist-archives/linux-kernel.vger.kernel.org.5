Return-Path: <linux-kernel+bounces-95897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EAD8754B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E634C1C2218D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28EE12FF9B;
	Thu,  7 Mar 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NbZv4L7s"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7018B1B;
	Thu,  7 Mar 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830573; cv=fail; b=pZByEf1/kc6XbsoXgil+3WuZPgouE5zfawTdF587bKHnrJS8GBpuKiJFk0qbBUTjDGC9Ayn2Y1Nv4Vl5ov30np9n9QJH63a7knWpTCf5oGEtpY8kR5OypoOBZXqOj3EZLOWgABA+WWbwPrkaJ100gH+p6KuHHGNITJlrboaTbng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830573; c=relaxed/simple;
	bh=Lwd8vJJhdibybs086AxhBGaZwGgAbRo4YSzZYqQ1yS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=baQ0HtmODgYQ4cZlBVxOxFQMDpVOf80lDU0830QUiDD3I8WIGxHRhtw1CAOVgzORxjfq3ZAaaXAYQNNeEpd4AwunS4AIHuOw2b1HcmtzHG882xweIBeAGC1qLXcbW8kFPImoZXz0HgyahEnzRjzCwZ08OOvTNvHx9NRbopeVgIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NbZv4L7s; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXNEreF1TgGqWMXDoxvbZ2Vk58O9BdAahsElsUojYqzMLNF6vxBOvyFZJHDKhUUsoEcD8RQ7+K9OpsPe6ezJVq1b7KDcqLyBnU4hPy0XGtr+ZDDfMIOn175vlwEa+gY2G0rn3A9CRkdUYP+6Y5T/HtVIKhysyoFSIlbBKcp04V8dEBmdkuSdRtuBSfMwg8b28NDPD2bkUIY0ueHq9eJCvDYO1UYW6ewLxihvATVnu4h1Z593YoYC+Ii4jP1UbfwNR5SAKE0q8f51+0p2Mb5VNKpOWw2Az4MCGZp/SIDwuh0xaSOWjzGGKtYMBU0PYvs+czzrJhm2KVqM38P1H0GHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dP4N+IlGESD/lJlmXe2HCFXwJDJupvBdW9SxpHcgh4=;
 b=V1tSSn5m2WbDvq36AJqsvfYxUNokeqyKpJSTlrxA5BVUT87Y+kwu/ztphy8vhqiQiapRSJAo5tT16UkXBBVjbqMWdDXpXDE0frkKF2dCOAWoFuOhBcW0sXwgrMY7E6Z/dYieTTF9578IFWYXyunV65nfqqQFbaLN9IEj5/+GeLDyfpv5FSqJp4JWkMn613r4+JeguJhbpfgXVGSO+4bj3dGNjI0ftM6Ggo7EDDzF0w2KQhOpF8V7YDktJuCCF2IEl6LuNffUl/7MwYORO1GDm0Fh959+L/tLrTVjtFT+h6bC+SxhF0MefO1CJ43z6VJodZisnOcdn40YXH7pGOrB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dP4N+IlGESD/lJlmXe2HCFXwJDJupvBdW9SxpHcgh4=;
 b=NbZv4L7ssx/vGj/jL2rPhtVqzuJ8fBKn4GwGtiNKI00Zc1LEBhzI8m+hvKb+K99xnTZ4mx1lWYmwI+YLFqCw11xMnCCo4pPyOhIMVigAlYD6xN+45UUhs8tEOFr4F9i3x/1UgysIn2d0CpvZODu4xgcqA2ak5Th5n8na4wYn7Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9313.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 7 Mar
 2024 16:56:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 16:56:07 +0000
Date: Thu, 7 Mar 2024 11:55:57 -0500
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
Subject: Re: [PATCH v6 4/7] perf: imx_perf: refactor driver for imx93
Message-ID: <ZenxnY83dnYIT9dJ@lizhi-Precision-Tower-5810>
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
 <20240307095730.3792680-4-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307095730.3792680-4-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: bc55828f-22ae-4ee4-a354-08dc3ec77bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O6ycz7qXL5kv7RKg+YinBR7G0i1dPhy9h4onGWHQhNFZHoSBwH3LOpOdvvySuqcYNMwfnSlqxBKJCplbAp0fOnU+5W3f4vfj4aFkjp2kGM4Qx79Os4aPhF0nXOObLnof99XPZrYSJvfqP2OqoDNkOPhzXW6fiiK9790/DK2vXxcWZkZOBU8CixLJjYs2zkyJyjltP8vIEX1XEvgj1g1LIRLPGOyp1zXl7pwlghC5UYEbLFS+KcWj1/54oOHoqcmMWV6hsrhndFIwNsBajuZP1oK7nZmLWmWSfF6MdSxgRxrbzUxdIY/OPM3+rgmoltMI/S8/5ufAD+vr8txlkz8dtjI49CgV0hEnPiuOXvaK/BBYbr5tQLvz4oS2jHLkXWHXVCa/7sTGjvCsGrIi8IYIWIys5ospd8kEsQeBKFaPQOaGvchFxBRbddvLn1X6ffk7Pbm4IrHVE4+ppIxSNhyiyjkxr897b1mwCRQT5Y1OOqzTX6hKhirCeBHYmDOc/bwUwypH4e/3TJMrNFu+QwgJ96j6/gYOHLiYPs6xkR8FvNfaNcOvpO5oriFcj4hSrHxZdXYZaOTqfGpG/tS1234jOwNlh9YLZ4wmAcEgUFOouiwYyiXgdsI4a9+axYEHJflLr4CFwGn9cR9keUhOxAUhTDT17oHAEtnj/amgOPldLkMA+p6VTZufjcrnH63CwMgmOUJM6THAwviISvt7Z4kNylLBl3WN0RgSJQnQMyB2mf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RgETTToAvbGgek9i1kanfhzmBhmST42j6F/CNTFutlF9N6UFqknvDyGKdlNg?=
 =?us-ascii?Q?M1YbJ1hCIXvvM3ZWAEwpE6PN245uVBEka9zZJHFKEs4qJt38E4ypkLflsxIi?=
 =?us-ascii?Q?502G0ADqSSmf+jHw2EB7tHAIn2gEeq7BV8ac1QHTsy91MLCS13rayU4eeOvx?=
 =?us-ascii?Q?hdtsiGrDdmCUcEyBzRaAcniRJpnjE5ilpDn8pHn0Rmn0N0WSNCCLATzucmg8?=
 =?us-ascii?Q?4alt31DDPx8GDgGqLxbVn2Aj+XCasz9E6gSqORR8/SpPGnwv+Z6eih3atNGC?=
 =?us-ascii?Q?YIxCyhii1hGaLMUqKzH2MXpqqnIhx90OTOvwkocOEErmqpztj0gTSyWzvRUU?=
 =?us-ascii?Q?cSEwDje169b1kgGcnaW7Z3N8jI8gpUBR1PW+OdLprv3YO1Uc5je1aaS6QsJu?=
 =?us-ascii?Q?WGj55bzfyVYCOKibQsnJPtlHCvlw5uuqpl5hpITxPG0+SzmeSu99ccxsfsnf?=
 =?us-ascii?Q?RJl/t6r1jINNYPtOkCPix9j9Xzc6+fqs70Dn3pTb2FjGIrV3g0Le2be4GGEb?=
 =?us-ascii?Q?f/lUz6sJu0TJ4x5YfVYMUUsG8d2pLzSMFeZ9v/002qjgVOhvTEHM8o6E93qa?=
 =?us-ascii?Q?NO76VIIUvYroJvT5Fkp2D2XnM/pACCA3Fsi8qVISFIbfBaPJ7lW5jzNB2Z84?=
 =?us-ascii?Q?wv+51gTgn23LCYn2BJJXpfIs+YtCaQ94k3wsxmqAHakUtf2Awv4r1U7ldvkr?=
 =?us-ascii?Q?QVX6Vtjv4XEte+0S3A1XkL6CR10xnijHnNUXfDrXbYkOgEHsisg0hb1acbME?=
 =?us-ascii?Q?BLdPWzHiouRGvUhoNAWb2XhxONU7C2Xvx/S38Kw3X2MhxU+7W/caEvb2nHIM?=
 =?us-ascii?Q?dGDG3+asIiOhIU+ry/JKlMKGwEutchQ88cq8B/+y2EQdLn1bmtiHvN+M3srb?=
 =?us-ascii?Q?/416DathrbmaNZMEI4kmhB90BkKctc/NLwJJgQ2GCUSYKnzGVKwkFS2QniTz?=
 =?us-ascii?Q?57QoCKjU5gAXdUExiglZ1FPf7PHVJKBGM7LQJc83W7eecOd0iYWPH5+vt7v2?=
 =?us-ascii?Q?55HN3gV1dYodE1K5tnYmTPkbpJtwyimx04sXW1geXrKwowiFoJqJGhsebQV4?=
 =?us-ascii?Q?QHIi370m1cg179FAfZrpN3fxEbei4grfVsjchsn2nLTReS7+Qweha6spYAaq?=
 =?us-ascii?Q?OMc9u5trqJd7ApnYf0DMrhucZsYO2Q8UQps3UvZ7Kq6usQ8ht+7gSiXc8/B2?=
 =?us-ascii?Q?sEGe4cLD9+YOPfFbqJEWJtEXkLFNcK2FaUTvYFV1GcluB8TXMNfHpLuXiL0U?=
 =?us-ascii?Q?ac5AUhKVG+/fpZ0brNiys/QMBJLAYYARQcP9Kn1vFFXowxx/svxOqIN5qUlB?=
 =?us-ascii?Q?D6kUZqbCDz2duqkNUT2PqzsgmJ8CrDTKWxeSafKQkVxFr+o0OkVACT6XCMpd?=
 =?us-ascii?Q?wFxOKPlMlUE/3dv+qsTW79X+5pMVCACqTmEjcTuQ1+kjQoyFuBbnAPkcS0OB?=
 =?us-ascii?Q?dSpOsgoIiFCwoPva7+Q6Av7sqs6++xLylmMHxBY0xps6kZCQS3LqeRGO0BF9?=
 =?us-ascii?Q?oOjfzpkMZrHZisQe7hjsfBUg+dcuDUWRCL15qSV6s71DnZRG/DVNBJUtpWVx?=
 =?us-ascii?Q?OtNfMspFaeRxHVm76AU30WoOjYk25Z9t+ExDoVdR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc55828f-22ae-4ee4-a354-08dc3ec77bc1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:56:07.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4feo7/pL6ySlQayTDz9IHho90Sw2uo2LY14sVJcKGf+39/Y4PmBRANdhCrAp1YhuizejBCtDTXrK1MCBRB3SZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9313

On Thu, Mar 07, 2024 at 05:57:27PM +0800, Xu Yang wrote:
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
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 99 +++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 8d85b4d98544..4e8a3a4349c5 100644
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
> @@ -77,6 +77,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
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
> @@ -186,7 +191,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
>  
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
> @@ -198,7 +203,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
>  
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
> @@ -210,7 +215,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
>  
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
> @@ -245,9 +250,26 @@ static struct attribute *ddr_perf_events_attrs[] = {
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
> @@ -369,36 +391,47 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
>  	}
>  }
>  
> -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> -				    int counter, int axi_id, int axi_mask)
> +static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
> +					  int counter, int axi_id, int axi_mask)
>  {
>  	u32 pmcfg1, pmcfg2;
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
> +	if (event == 73) {
> +		switch (counter) {
> +		case 2:
> +			pmcfg1 |= MX93_PMCFG1_RD_TRANS_FILT_EN;
> +			break;
> +		case 3:
> +			pmcfg1 |= MX93_PMCFG1_WR_TRANS_FILT_EN;
> +			break;
> +		case 4:
> +			pmcfg1 |= MX93_PMCFG1_RD_BT_FILT_EN;
> +			break;
> +		}
> +	} else {
> +		switch (counter) {
> +		case 2:
> +			pmcfg1 &= ~MX93_PMCFG1_RD_TRANS_FILT_EN;
> +			break;
> +		case 3:
> +			pmcfg1 &= ~MX93_PMCFG1_WR_TRANS_FILT_EN;
> +			break;
> +		case 4:
> +			pmcfg1 &= ~MX93_PMCFG1_RD_BT_FILT_EN;
> +			break;
> +		}
> +	}

how about
	u32 mask[] = { 	MX93_PMCFG1_RD_TRANS_FILT_EN, 
			MX93_PMCFG1_WR_TRANS_FILT_EN,
			MX93_PMCFG1_RD_BT_FILT_EN
	      	     };

	if (couter >=2 && counter <= 4)
		event == 73 ? pmcfg1 |= mask[counter - 2] :
			      pmcfg1 &= ~mask[counter - 2];


Frank

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
> @@ -514,7 +547,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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

