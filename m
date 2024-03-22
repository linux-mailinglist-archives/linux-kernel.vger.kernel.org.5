Return-Path: <linux-kernel+bounces-111621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EA886EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147FA283A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC3481C2;
	Fri, 22 Mar 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SsJU8c3n"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C461482DF;
	Fri, 22 Mar 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117941; cv=fail; b=rh3ngd9sFv41c7qvH6LGN6WPowe6qPhjdmI3W6m+7Engrdec7Pv3gdm3j9vs3dehwg9FiJvxcQpsnfboV5fek612nNaZoNEXtLZwQJ10UHffWqX3TSIsBPYSCK5kCP0reGLUM27ysxKwZzNHBfQnFauSXB3HckoJ2Zt82INNyRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117941; c=relaxed/simple;
	bh=opDy75jK37ulwz8fHmzS57l5KaYwzAMAZX+nFaPI1Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OqcNzFC7eNmj9EzcCe/pQ/IAZp2UItkKwFQQUJSo7adrUlFHbpAb/xptKYYUjUCAAOueC+N1UjEbg/ipxennXXVg9fdd1dtSAGPVtS4HzMUfui0PctBWRypkynQ30wklWHrHxlBYKMczjWwIZ1uVWJLcYl0BbpgtU+fQ9oCOtes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SsJU8c3n; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP5wG4KE1OWzWvDirhh9/NTCayuqQAhaVZnivaslMsJJIAKi+iCf8zq+uW4rca5ko1apHnp6tzGTlCWpnV2Bxs4aeBivHRqmdMLJ4gus8/YCisl07MjVv6xx5ir+/oSq55YP/xQVRUh+pV6iDAcPMJSavbhU8iLSFAHxz6nvP+whK+sl0/FLigxnGDemAYCkTVX6cbLXKVbN2ks4GwoH1z4hZz43HfSMUFVyNT50Te/acTFuE/FDHJ/vBj+FTxIl8KLcQp+IMvW1M8skB/Lv1ByslyHexOnKBgJ/zrfaXN6dg7Iw0nX/UsNKKMn3AzA2lBQOBcDBn1Bc82jX3UlPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGvsbUWaF+k2c8XF/m4cO3hKyh6BGLvG09XshZi4emE=;
 b=mh8UIbQANvSR5To8q6mMay6avUqJrKgVl/zwviGuc0YnMrTnQzAAAIJSGL5TUD74YUtkLUbT+6XJ/C9UFuAJIqhb4vCh3jvGZCo673wcX7AEJXapAaP1wCHKZhX5f5OGBB5/TXUYZ26Bukf/xv9CXObCLsKYCqZi+aNV9FjOBFX28tb+Dqz2JrA5OyYIwDaSQgVNOKO1CHweRXeXLWqRFNhaGKjYlnoCgJQ1EWmypwIC3MCJE0FTdcVhHsssZMLVWU3s5uCOPYzTrQXozFefXzWpVRc/viQhiFgEbG/w79TXpRypkjOjNEINC9da0X2Blax6djsoREdNDvqvG42YFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGvsbUWaF+k2c8XF/m4cO3hKyh6BGLvG09XshZi4emE=;
 b=SsJU8c3nUYLCdUfbkwmsNzXtK3UD5dxHVUnHUkhE9rySsojS+TZaK/oPRW+aGBNd1G7CzwuZdzLiZ8ihX4g+N9j0L6gBBOlnxkTk68kb9NpvkL4absxS11YRLmMm2+TK0knpi1MCssXWoxT2Los2HK3K8jkWONjG+uWvaflv1TM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:32:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 14:32:15 +0000
Date: Fri, 22 Mar 2024 10:32:03 -0400
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
Subject: Re: [PATCH v8 4/8] perf: imx_perf: refactor driver for imx93
Message-ID: <Zf2WY6dwcZf43Wl3@lizhi-Precision-Tower-5810>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
 <20240322063930.749126-4-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322063930.749126-4-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f6f7bb-74b8-4276-c660-08dc4a7cdeb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4XLb9juYaCIGticP0ttr802zwdGNgkD4WONZssxoaVZmaqTa38n/XSBUUuxPt3jc8zjJYSbkMV/B2lrdFIFb8pGWjR3hIO19FWfwGsSJYP5nRgAyEkfYleBhdYnHrpxsQfV77St0cDUVW4AMmHbx7hxO5Qmwfvj4fv1JxPhU6/F2JX+o+dv1GskAACwIhxxE8iEwChScYnOJ+0A7/VySjvPmpwDmiWJ3gd+prwiwDulgsHF0mx35p3c6ajqZJwB76ikwv2mphkxDTSmo42tVzDgC0w3wqBNvIIyzXC4vma1adiWwcIFZJMi/kKZWDoTwwx8bdQKrljMzKmRqb/wcP7vdYAK3vZ8PhryVbLr4N5vH4wb6FPnyLka152CBRIn5MG2XeyeacuFTpuaFlnDkAQwMYzi4nQsvAmo0IxQAw/oxaNjKYnEawbEBr5s/Gq8bbW9DrBjl7fkRs0KKfrA5GbCAju29ZWxaV4eQxL2GclSBegotAW2wjowzLDWNMR5Mnar/UfpG5Yaj/pVyIW4c4wyUz4lKaHCDab5Le2xpWrKCltQTofwCT6cNT4BDTw7pKd7T+XyjCG3DLJRU9OvQ8JGe0nnc4k9h1jWr7vo/TaKWAxC94yyAUxIXe70KowA4ZnDv5hEnSwp6QgYLdgVjgJOE/o+GiXbEuqjDBOFlQSKeYMgjeN1/3SQ6zFCAZ+zmZeKOJNjYAa7Dxoh+3eZcKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mfrRBvSpq9WQ5M+QHwL/kCvdTxYqdp0pIm0cjgXLJ7H9hV7S0DEx7ZvoAThD?=
 =?us-ascii?Q?DEJGZwuxwY5773UvQOulOR54/LusxXpZ6MNrZ1u479cy3yRZalVecj2gzqvF?=
 =?us-ascii?Q?MzqKYRwb7woTmu0kTW0lEFe6FlBjY7L3vrdkqVU79j+630qv2b/Oy6ZzWx1p?=
 =?us-ascii?Q?dIeSnPHKLtqU+Hl4GynC74RwCebgYj/BkfXtsrBazFcRemMXCjnd2q7rxr52?=
 =?us-ascii?Q?puCWv176/peEIY6elhwm9vA1474GsuHv0kYVepSi5MKSIcW6UOJYr6Y9ViCO?=
 =?us-ascii?Q?Ri97C8/XB9HSu90/ODdd9MW3WfOrYCPRPDppSFMb0ntTiK8+NhA5lV5VmsEo?=
 =?us-ascii?Q?PJWa4UDHJ1RABX6hN82+ER52yZzdhvVtBwWdbzEdTxYRx62X1DIO1+/J6PaP?=
 =?us-ascii?Q?onf0yx7kZnbgLAXt7q/LILGbO3VtTJlCQ1W+fWKQ121DNi2FzvYpRLTpvsgC?=
 =?us-ascii?Q?Q9UySWRY3RWEOY7zOjlhwhpz74etUSKdez6juxFwEnGIm+WRhw5Ht3iJlL2e?=
 =?us-ascii?Q?X3klIvKxX2fbSwXmhIIKs36ZrRy0Co+wju7aYuFuwUnLTvg2IYTpEvAS4+dL?=
 =?us-ascii?Q?9wxtlX+oim0TU9yiU5KelfHpJDRLVGt5JSA7qVKUGtv1Dqp7w5F9WplvyrDv?=
 =?us-ascii?Q?aTXCq8452kTCpUg+cuixaHJ6suYWekYrufmvp2w58aXqWBZ/dsDRhVOxR9Vf?=
 =?us-ascii?Q?Cypzlkzo6q49rKZ8OdbdyJXrs4e0yTBtoIKtHnel6wgpjBC9NpF9HYXo4ndT?=
 =?us-ascii?Q?XSveerEuKcqa35n5VCgeBnZQSmgF0SbEvb//X5GFwADff+9pnx2w/bGxVFpj?=
 =?us-ascii?Q?Qy71UVfxfd5Pd7z1ayUqFE8hFCBbzvVYe5t1bgHJpk//xdCieszPl66GXN8N?=
 =?us-ascii?Q?y+khpH87paRQE+VobxFm+h3knGPhPpwomKbH4AEH6GvCNt9d1vBu+/q4cSdf?=
 =?us-ascii?Q?qkNLEbfyQYbq34rWRktTY+x1PJdykI051dyl2+68YVkpoh5c6SyhFabcc6VX?=
 =?us-ascii?Q?cVQBWZx06WP/ddaGE7QLLrEl+Wuol7ZzF09vrDBZhNyRE6Bug+AKmAu+VGdn?=
 =?us-ascii?Q?zNDV+YcV5Q8xy+YAA0V+6Sp4v8riDOyY/uhXcNfxlLzmANfhd7lJOZqT0l1t?=
 =?us-ascii?Q?EfRgHOWKvsw7BH06jK6Mav8DsBaUAviJceDkL+h1g7H1oxCs9HsjGhRIthve?=
 =?us-ascii?Q?3KLmDAfTaCNZAf9Pr4dwnk94oAoZo3cKIsiB04G5Lkdd02wiKrzq1jGITCzs?=
 =?us-ascii?Q?ox4S6Z/e1DfNquMQEKal86F3QUtEOYbWoCO9TOwn6bXlZ5WIeCVodg9P4UmC?=
 =?us-ascii?Q?B48NlYNQYUPPn9sldHZ93rS0jj9sfKbA5v3WPTvlC6Clj5OnN2Z4yrlZ/HGq?=
 =?us-ascii?Q?FIGi1iRmjhin0jGHQjlp9uD73u2t9guG84NRvtQiMXpID5hX/o2nbXh2WrlQ?=
 =?us-ascii?Q?xmphMXabposQaD+6I+pTZoh8LrvZ5B0Ix4sSY8WxuC/jGTK497S24dx286uq?=
 =?us-ascii?Q?IzUAik3AN8ICveiVtzRq+T7rmQqnQosrzfRb3Mt+SFBebrc1AA5UJWVduYdx?=
 =?us-ascii?Q?gnUBt9EbFq6Bq17g0GMTAdGPoXVV95nsAHqXUZx/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f6f7bb-74b8-4276-c660-08dc4a7cdeb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 14:32:15.6003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McPtsA3tjEd1IyTxg/28iPMqjkhlyHNS3W396ICKjobmra4eBGR5A4QoSmMV3EtLEo66jwDY0emnqDP8/EWeYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707

On Fri, Mar 22, 2024 at 02:39:26PM +0800, Xu Yang wrote:
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
> Changes in v5:
>  - use is_visible to hide unwanted attributes as suggested by Will
> Changes in v6:
>  - improve imx93_ddr_perf_monitor_config()
> Changes in v7:
>  - improve imx93_ddr_perf_monitor_config() as suggested by Frank
> Changes in v8:
>  - adjust is_visable() as suggested by Frank
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 106 ++++++++++++++++++++-----------
>  1 file changed, 68 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index b728719b494c..011377c01dea 100644
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
> @@ -123,23 +128,36 @@ static const struct attribute_group ddr_perf_cpumask_attr_group = {
>  	.attrs = ddr_perf_cpumask_attrs,
>  };
>  
> +struct imx9_pmu_events_attr {
> +	struct device_attribute attr;
> +	u64 id;
> +	const void *devtype_data;
> +};
> +
>  static ssize_t ddr_pmu_event_show(struct device *dev,
>  				  struct device_attribute *attr, char *page)
>  {
> -	struct perf_pmu_events_attr *pmu_attr;
> +	struct imx9_pmu_events_attr *pmu_attr;
>  
> -	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +	pmu_attr = container_of(attr, struct imx9_pmu_events_attr, attr);
>  	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
>  }
>  
>  #define ID(counter, id) ((counter << CONFIG_COUNTER_OFFSET) | id)
>  
> -#define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
> -	(&((struct perf_pmu_events_attr[]) {				\
> +#define DDR_PMU_EVENT_ATTR_COMM(_name, _id, _data)			\
> +	(&((struct imx9_pmu_events_attr[]) {				\
>  		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
> -		  .id = _id, }						\
> +		  .id = _id,						\
> +		  .devtype_data = _data, }				\
>  	})[0].attr.attr)
>  
> +#define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
> +	DDR_PMU_EVENT_ATTR_COMM(_name, _id, NULL)
> +
> +#define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)				\
> +	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx93_devtype_data)
> +
>  static struct attribute *ddr_perf_events_attrs[] = {
>  	/* counter0 cycles event */
>  	IMX9_DDR_PMU_EVENT_ATTR(cycles, 0),
> @@ -185,7 +203,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
> +	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
>  
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
> @@ -197,7 +215,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
> +	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
>  
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
> @@ -209,7 +227,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
> +	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
>  
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
> @@ -244,9 +262,29 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	NULL,
>  };
>  
> +static umode_t
> +ddr_perf_events_attrs_is_visible(struct kobject *kobj,
> +				       struct attribute *attr, int unused)
> +{
> +	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
> +	struct imx9_pmu_events_attr *eattr;
> +
> +	eattr = container_of(attr, typeof(*eattr), attr.attr);
> +
> +	if (!eattr->devtype_data)
> +		return attr->mode;
> +
> +	if (eattr->devtype_data != ddr_pmu->devtype_data)
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
> @@ -368,36 +406,28 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
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
> @@ -513,7 +543,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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

