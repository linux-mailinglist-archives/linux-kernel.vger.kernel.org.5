Return-Path: <linux-kernel+bounces-106377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE0687ED6F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1111C20C24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CFB535C0;
	Mon, 18 Mar 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="edmwGfjv"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356A52F8F;
	Mon, 18 Mar 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779111; cv=fail; b=P60JPTDnBPhHtSsq2N+E5SfKEODp/sE8oPPgM2DdCsP5f/xzh8gcf/YZco4ls3kC78JQMFSVjsRozhb1NXjgrKl192CxxjZPRrrfFD0uvrokVoXx7SYsgc2ebqWaMVvo8SN2KDHr19sxeoVOXwOr3Ozmpk6vgh38gwRXBDNMJ0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779111; c=relaxed/simple;
	bh=W4a0Z6FKm03MKhPgHY+tXks+6FA9Th7xHTDpxROrR4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dy+ed6a5TQST3/iqZwl7BsAx4/BRJwdFd+5O0X4bD4Nt53KkTOMsDnWxIAx42x5Lr6e3Mv6butMhC9ZOEPCiIgHEZvN4NJkn3uRAw952sA1uKInebJo8UWGbFyXsJAvhU4PGVWNXtnebDiFaTi3TrhhbStV8U/jhmKuO5HbpdIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=edmwGfjv; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCcbMjn8vsg3I+ohLy89rcB4DAJY1il4ASnAVkhF8iioXRwykjC25xxusMOb+ukMDia7n7f/JCMGgjsT/je90Y3qxWLW6AVSNEDy3xwRbRB+D/DV24zfY51nWPJLksuDw8QbhqigoBXwb8j7rCbr/9ZYjheQTE6rshi13FMVLSBBF2ExwFrCFd9NaoNq7jRtanqP+e0rTx47J4LNXrIJgCeFOzfD2NoSsPk3XcjWm9Zz/rfQ+/X5x3za0Kj3qOY7OBGkoe66KY+Fs2LUPmAAPh043oJ7uBXI6C+l04BcUofiQdG0TExjmXtPZ/lHVOLfe4IkvZGOHratqa0dinyiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5QphFaP6jS23u/3rUB6N1poYajhrFRunCN5+KYZZTM=;
 b=Z6ZqElPerA2SLJDjzjFGIVIi/shuJuhWKVZTPQh6WPEEzsit/o83RZkIZnqvCmstiLu39UQUbKLZTBcs2U2RIwu3DIK/Uso3qtPHRqTa5qFHQ+fPmZDFrg0+QF7BvPKPmxL4WrMOfyveiHjI865b9lyJopsKNPLfauv5QN6meg55HdqG68sYOQFllyumhqZRkdgWmiNzqk4OSE9WDl68VE77Z1k3fhqD+zorh/u2VNeTAafKhvjqCPal1UnM4jMevf6XpElSiybk0Xak68vMub0K//4QkMVjVHbjtbm3k548SZjrS7nvFDv/e8bOydpsPQo1wa8F95L7hrPvpoc0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5QphFaP6jS23u/3rUB6N1poYajhrFRunCN5+KYZZTM=;
 b=edmwGfjvZhalraZ8gQ/xVTbswRlPKLctASRV5aSsdnQrCBIH8UhvxNZQa32gNXJdkFPwnjrH4pjeAIsS6xTrsY3hWMc8pQT1q3t4z+1mmcYLDbB/wGQlCkxSs3Pd5nTrf7abTpxe7NMvorb+EhfQ1ykZ9nX4fO9rFABTOjQViWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8095.eurprd04.prod.outlook.com (2603:10a6:102:1c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 16:25:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 16:25:04 +0000
Date: Mon, 18 Mar 2024 12:24:54 -0400
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
Subject: Re: [PATCH v7 3/8] perf: imx_perf: let the driver manage the counter
 usage rather the user
Message-ID: <Zfhq1gpeJLe9VG6S@lizhi-Precision-Tower-5810>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
 <20240315095555.2628684-3-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315095555.2628684-3-xu.yang_2@nxp.com>
X-ClientProxiedBy: BY5PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 602fdee1-2a3b-4fef-1423-08dc4767f7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ljhOe3QFXHv765QdrmIbESkwY8+wQB2yXR7vq3KFOWJg7ixlaS5hEjDg7RVyW6E16RUG+IEVU40LZnCLbk0w/RtaPhUcIdwpiZ2kLuV6fLM9j5rs4aSNfP4JdJBFzHzKjNYpE4qG4mS2eQQY30z5FkHlC5O1DfXtM23ZMR1gpqJrMUFbAoia8yt/NgFJx2EI3kWhCT7HIB13WbgW5+M50cpcBHqNRxWJlWiqHX5aMclOsuAhX56uMyXm/KAIwsWgMJZvChhb5QUv572DnKmG0d0hiIE4oKoQZfJyKWtpcXeBG72WOqqpvFZkvA3CDu7TN1GG5PMd6IcMG8iJZyyUVG6Xyp2/R9ZMCfo4dWZ00bMejZwWeJTPXRRAMzitasiz7U2E8JzcWwmODMbZKv56q44v61IsaftNmpWkz8t2K0wVGFfqm2UcR0ADgbWNOQfUdwohbYAGro4uTZr37gyWfzV6hlKCus05bPJ/LA6O8uDjW3S38DY8SZyTYGfHe8vxFDjezZRRiT4xfzEywHFAgors5x5Nj59ZlUj6/0xYWRXW988vX3wF+359EvRQudoK7tvJPLk0v6O67u6NiM63MDAbTCJ/bSI3OtGK4gZG49gtcF1RjhmxmUOmmP72vFs79uoGayTY1SlGCTgY7nRwAfPcxQTf2HtKHL7Ruhgrqgo0kc7kZZGO6PZfl1z4VLDyS3QQ8OeljRHtj1rgfE6idukAjLGCUeytCsQ3m/yP6nI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/VEPiqRSudEt49Pbn+kGIcMTDPIt6M3oeFBcbkVT7jEgiLfp8YvrxHma18yl?=
 =?us-ascii?Q?ORuMM/nA6kIIUa8ePQ7xknGZQX7SmWHCKoEnD+9qaXtst1NjKyLuEyX4i+dt?=
 =?us-ascii?Q?7QZvx2naginHRTbFx5ddOSRPZ6PQp3lYgXOpvnHQY+ZcE9AinY2KqxxHpzD5?=
 =?us-ascii?Q?PsBstonb/qteqVGBdLeVAC6bcynzB7yve3xeFHVXuZnNOD43icCNQa2ma+74?=
 =?us-ascii?Q?xgbbI4FTpk6zZCvDrsyNfY10fZgxs2IWUHX7fCbOelqeHXOh2MANyGdmyy0m?=
 =?us-ascii?Q?ii7KrtNWBY1m3zeUO57tbpUWk78BQkNTRoWiJyPbP1clUoeXzl7uS2gMhrFn?=
 =?us-ascii?Q?Fcmc35B6VNuHBjqEHObsSe30Hwgr8IFfarxI8QoHsNwRCHz84C7echDOJ23X?=
 =?us-ascii?Q?dqVOyNVWqEFyMldYwgf4bdDPRgrZ8+i1R3pEU0dX2HXxqxv6OazY7x+ed8tP?=
 =?us-ascii?Q?FEho7vVrEV9mawGNX3/0i/xrS103CfgzNDvlyZMMw2RcIFppLD895wt7lz+j?=
 =?us-ascii?Q?NbqblqusBzgiT8pY2hvdP5DAUWnh0SWORMRyhxhy/+H/gcTMf7aZ10ZhD7uW?=
 =?us-ascii?Q?KhHh8WER3OETLUC+u89Z/cWs33S7H0HnnvlJJUQqgNnuGPf6vDqZpjBDy1/M?=
 =?us-ascii?Q?At8vsfuAuarScL+1WDvF0NDRUrL6ls1vnMMS4Hg77f9yPZpNTsh0Mg/CcIR1?=
 =?us-ascii?Q?V8mvgiR6mO3L63jyFmFXyZv6N7tfshnu91Qn6SBKrbE0Hw84U6nwweLNbbrl?=
 =?us-ascii?Q?b8AbdtIwh0BCGSL7IOkfsSgW/nhXSm35VOgHOq66HlRMePcoril7m9SLwJyu?=
 =?us-ascii?Q?BTjXkbj6KDE7wcSMTCyaOufMQXL9ijQLwDBK7jydigdHWYkQgzSUueqCzzl5?=
 =?us-ascii?Q?Z3PyXd64S2BdeL60uNoQu75A88n8f3gwkNdjVtm0vWVh9+26amXf8NObvy79?=
 =?us-ascii?Q?g7+NmCKE/67QvyhYqKrONflkEWNGsFpYKz7NhjFgCJT9TLXHnhrBBIk5AQzI?=
 =?us-ascii?Q?9CFsHdY1Yg1z5vhxJ9Uof/Y4cx3tto0wxa544x19ih+4EtEGsRpeLCJ4OIa6?=
 =?us-ascii?Q?qLVa/cUNbO/u7wIdE2e3foMEf51JqwXKmEtLDk/tES375C+nioLxb0jYZcSj?=
 =?us-ascii?Q?ZvgXG506yUVV2JRQ4I5H/Q6Dm0hHl0L0BUczpIz9rPgHNbauSyGq1432XdXg?=
 =?us-ascii?Q?ovXZp7HIgHJ/QjnXN5ImjR9AF46CEnP2hhm+Jh5vaRMY7+Zl5heGXIBCnGOz?=
 =?us-ascii?Q?fTWZDWc7nNioX9jEATtlZeU6aDYaOqKDnaAH1iZrmnGli7yzQrsxMXuOLHY3?=
 =?us-ascii?Q?tLAtChFYQWcb9SPzL5Sph0cUxmkgzLEieLBu7aul4LQ30+SGtesLFLDOU9Vq?=
 =?us-ascii?Q?Jq2fUdCBGNSJub+vSe4wYJE0rHzdkibVT76XBufQgoxSbWO9HpJgIsPJg8O7?=
 =?us-ascii?Q?HEx1KztVb+nuO+X98HrSSDPf9kE6W6KkHGGDDiASz9wo2DkMW+3/ZQt3scDm?=
 =?us-ascii?Q?h5V+CsyKxT7IWKHEMgOiIPPAWfsqDPMnJHBuvClBskDwQBLD2RHjV9tZvoDN?=
 =?us-ascii?Q?kdiLQG6qC2DaVAlJEgrUGI/UpHruXiYCemFd9p8Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602fdee1-2a3b-4fef-1423-08dc4767f7cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:25:04.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNjmhzti9UJhv0Z3dLN72s3hxqLFUHItGHJrw0uzn92iw15khDgsglMSj1XJYN2VZk+VfFuH8WC+Lb0QVRsjiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8095

On Fri, Mar 15, 2024 at 05:55:50PM +0800, Xu Yang wrote:
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
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> 
> ---
> Changes in v6:
>  - new patch
> Changes in v7:
>  - no changes
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
>  1 file changed, 99 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 4ec70775d1f0..4fdf8bcf6646 100644
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
> @@ -245,14 +249,12 @@ static const struct attribute_group ddr_perf_events_attr_group = {
>  	.attrs = ddr_perf_events_attrs,
>  };
>  
> -PMU_FORMAT_ATTR(event, "config:0-7");
> -PMU_FORMAT_ATTR(counter, "config:8-15");
> +PMU_FORMAT_ATTR(event, "config:0-15");
>  PMU_FORMAT_ATTR(axi_id, "config1:0-17");
>  PMU_FORMAT_ATTR(axi_mask, "config2:0-17");
>  
>  static struct attribute *ddr_perf_format_attrs[] = {
>  	&format_attr_event.attr,
> -	&format_attr_counter.attr,
>  	&format_attr_axi_id.attr,
>  	&format_attr_axi_mask.attr,
>  	NULL,
> @@ -366,13 +368,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
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
> @@ -392,12 +391,12 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
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
> @@ -465,6 +464,28 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
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
> @@ -472,10 +493,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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
> @@ -485,7 +513,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  		ddr_perf_event_start(event, flags);
>  
>  	/* read trans, write trans, read beat */
> -	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
>  
>  	return 0;
>  }
> @@ -506,9 +534,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
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

