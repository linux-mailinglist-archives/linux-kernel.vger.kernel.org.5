Return-Path: <linux-kernel+bounces-106375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544AC87ED66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06591F23991
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4CD535B2;
	Mon, 18 Mar 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nSjRQBP/"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491853383;
	Mon, 18 Mar 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778848; cv=fail; b=ftUAmSfVlcCqYyHcp6nUtq0cULWzRsXchhKIL0udNaUl+Ey/+z2Wte7Wym0NukyKt4juHxbD7UbZATvhQe/1qK2MjPd7Nu62gsaZAD2UYFGXtDHEcDsZncnAHpiQzFUjdc01d1wFmf+rsO76/IJUy0hoGuoYYjAdfoCURTJSms8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778848; c=relaxed/simple;
	bh=WQnroCqoFfmnfDPTgX0tIPDUsLVuaFNrnW70xNLzAes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L9xBbpqpt7hlJaLk0E7TbPDooxPl1syvwrX9uPpXastWupxjivnW8iDzSb+cRfHSizYEvLWvkibaFDp0Z/+3pfp0iF8t/zqv1RgT+RZCjREXJi4WU65fgsGPLRXvK9MqWiuWweXcIHXlDB4C8nKBeRJLB2R0oC6Wzdh0ybkULhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nSjRQBP/; arc=fail smtp.client-ip=40.107.105.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNS879JKp5UhQoNeN7d8FsQ+m2ObLZFnGDioEM0pUzOPgIyhiP+ln3WSOVwFKlH+2QCQ9GTYdZzyxvKFiY4NbZgpzxYGaKS+0y0b7yUaQNA53dX0ak3udOJl+RebHt1hpR2XDgyI8PFZi+32r9RCH4shqNTIq4oamDGPattwpfdd2S4Gy70w96rRNTCpxXb1U/iK0MLj9opSTT/qs0bb6zIxjHXTFeiAQihGenEqUObY0yslp+OpempoR6bsBsCd4M+JFVgBbhw/+Ai5er74ph+sKRQUQ9N7eGXdy+61x7BQ1ReFEkd973mUPrXI73Wz8d+1O3NAABiCliBh5+oGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHbkQbWgD/oQY2LZ52zEZVDRb1GhJzxNEu9nkJnkqCo=;
 b=J/985DKnFTA6meL3LTiopym78dOtqCRo61Y7/hxCFOsb3nnTUINSdtBD3upaPmD5zL/XJ5sMz0eRZAeF4JEMQeZwGJzE2bHOBQZpOfvIKY3cH+8uNRz3J8MJlSj9a+89d0nGSYnAJO/nu+MHx3GqdZUQ/cnjbkrOPiefOhzQ8EIgZ0OF4rug/2eGmW0RqYCiuzZUqXNj3L7iQgJb/3n+bDfGCz5oKJgF657YMTcBRtcJUFgBaGDh/Su/Id+EFcfo/iEHLNx3kx1HB7HoA7DlUNqiyhwKcJXcap7AgCw5avYc6eHsmGsiVnHW/roP9YhVoFW84dfTpCUvBHQ4EP0zwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHbkQbWgD/oQY2LZ52zEZVDRb1GhJzxNEu9nkJnkqCo=;
 b=nSjRQBP/tvlKwBr2E2iriSy/FvsphO9RX3YgTTAUlY/LqNBGtE8NRvnrZGqQmjNyUSizDSGypa8HKNLYArPo8eyXortGDg4lSup3enZcir3HpgIYabo+5zzCAw/fqfdWxc1MVjQK4WbpNPeMHqNijOMiICR2jvLByIALykGDSRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7324.eurprd04.prod.outlook.com (2603:10a6:102:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Mon, 18 Mar
 2024 16:20:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 16:20:43 +0000
Date: Mon, 18 Mar 2024 12:20:33 -0400
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
Subject: Re: [PATCH v7 2/8] perf: imx_perf: add macro definitions for parsing
 config attr
Message-ID: <Zfhp0beAtsYtaNn7@lizhi-Precision-Tower-5810>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
 <20240315095555.2628684-2-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315095555.2628684-2-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a7edd3-ea81-4a69-5f27-08dc47675c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	72FDUxvaJ83ma0gNEkEaf2kfVBVB7meq1JEILtDupttiuj+HGEtAeLkMvu8r5ZqwD115qqMMh2llb+EmmljVKNK3aA+99ub6InQzrOMKZ+TLaR6Th8Hh/3MU2IvIXrdS+gPgpLApbPsVPVxAuXbUnHR1Q1J/OgCWlHF7iUtfI9MDyOu5TDw6rDh5iEu7D3hcYQYhaYLHSN47LNGtFHQsxOPIOWrLtPC5CUlMXMs5P1t24GepdyvhsW5yR3Fk4XZYLnnCaABk09ndRklVjjDn11iGN8Mh8S/FXpugyhhq1ejdAwdfJPQCLIFnk3vmUNBswXviM7n4bpqcym6P6iBJQFDcUClRdTgTBBLdfLubQGRQ3rZxEj4j4FYcXwJ3uoPyXlFj0MSFbM/yYIPOWxsJcdZtikFlw0o/uNyHukps5lm9tu6HDpp+cPpmHzYewZ/NqlHAcLllkTjzCR6F9fIlz2EF++rbNWo1EoJVSNLEKTeVx9TC0biBG1o/+KQGw7+S/sAirBBGlFcoP2aEK7/lQ4yrEilYleUGFIOqWpC014WvkTB6E2FVRe3K0XYSzzU4E/5/syKviN7W6+flBo79gxmFIDY7wgUcQnqrm7Z+FEeTsrSnsfEfLOvlRjWPniC1oEs9sCNt0tsFzMRpcffwmiKk2sTR7E7c6B4UlTPxw1zcBFDKAurkH7I41ngGTc63alfMJBknCrmW33f4f1czoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CNufahuKI5mjv5WdKT/aS8Sq/bO6RK8FAYwvoMzV1naecFo+UY+gv1GVNzWR?=
 =?us-ascii?Q?0BK1YxLTY2Ie88xwCG1j+SAxZvXeADvtzSxcVQqb8woRsONHe5ev2s/2AiXb?=
 =?us-ascii?Q?8voOUCsaBM6YWlO+HhmxjIfSuCIO9ppxwmSmnPP7kaztfzVq03ZBRPZZP3wR?=
 =?us-ascii?Q?f6DcuqZSA5BiNDE3kLhNVPovKxqjESdQL7FTIgeG+ph3k2mzNprD6YWZ/QB4?=
 =?us-ascii?Q?w9nblYCmXlEKaMZAbNKg5OgUpHCh4rBLT65ux+TuQL6Hq44e+S6H1wLJi4rN?=
 =?us-ascii?Q?N74ecWZVCM6EHpn/DEeWyoY1jDJiulcqExLY9VSPvA0zilU9meV0KEyCq1+D?=
 =?us-ascii?Q?Wkl65sue38QB4GE6o2ulOrlY4/EKIQ91iGSx9Kh+ebFS7UyTvXiu66nlty8o?=
 =?us-ascii?Q?xQfFFpxLopgsnD1OHV0GnUYMB8uDjVGu6EVzWOht/g2uMFNySDXcV3APprAP?=
 =?us-ascii?Q?ddIkY8EKxo2fdm1mRlYKjq8oa9ii45A/uMN+urj6RJRGrtyK325Bhmn0a9jt?=
 =?us-ascii?Q?9J6KMQzoJzvsXbM3X5RHnvHxaJF7lDUGbBhsluUFy4UWIq0wAJwgSpYh2fI1?=
 =?us-ascii?Q?5YnWGWmraG+KYPY0pU5n4k0wOvSpItnclUYY3aq36ccPbbwQoGC3sdDXt0aV?=
 =?us-ascii?Q?5HCXdGUUSgS8wY0wF5YKLfTOmzq0NKE0+s54rsDSLrE0ojJOOuzgju0xxPLS?=
 =?us-ascii?Q?mPSDOPfA7Lk7F3KLViblYDoI+TejJqPj/NesCgkH4HUn+fuhCJ78H2L7zAzU?=
 =?us-ascii?Q?EyTBt6ZymBnmRoNBPTb7q1ALp+rOAvhr7y6B7B8wUVJ6A5GBzXOD57rVs0//?=
 =?us-ascii?Q?KRpVIcRDgPXnid7rw7iHnWRvUKyuDqlBHczr4LohpRo1HgkAvTUNrtCEjL/e?=
 =?us-ascii?Q?FZYMq4QtEQp59p9JBMLdjYOlkuQAmN1/k9QQqCybui3V277n+83cTx2skW/n?=
 =?us-ascii?Q?7nlukCHEFl4JvX544vUc30nMTev/buDT3dPJcQkiXtHd3XXvfJPxclt6E67G?=
 =?us-ascii?Q?BLnhF1ucOAirWXYs9x75GSC5wncWWUTzmi8xrtYhQqXTMaWSlfsteC9wy3e6?=
 =?us-ascii?Q?V3HyUS09Y69W5PlvueOnhYGrM8V/duy9ktUb4MX7ByjwSZIRQy1COj46a4hn?=
 =?us-ascii?Q?75vcn8cVv0k6aIoIDbHgC5BQTs7LDV3Wlh/jnKAesiSUL1idKN1QoyiA37KM?=
 =?us-ascii?Q?ZnpCqHfyKmSxU9h8F5gjWcHV4fXsy0ZT6KzZMMJ9IQzsbhAVWDxYE6CIDPLS?=
 =?us-ascii?Q?BPcPjlZp7HamL1gbUaSLPjagWlHN67Khp0pDdqCEqirS8aJUKDAqu3r3DwVl?=
 =?us-ascii?Q?ywymSjPln5y7cpwwbKj/c++ZEMDlyPDuc3SmtBe8tU5Rqd7O2oyM5AU1HSo8?=
 =?us-ascii?Q?85vexlCi4YvG9Hfb//S7TSsvQk9iSENsaJznNNtlIy5yZt3uX6TSoeouew7l?=
 =?us-ascii?Q?eSVVCMb282p7gQzGk2RSNEVloRkhx2pSSCFxNaDwYmSZhm201JmI1ImiS7yZ?=
 =?us-ascii?Q?YH2Ct9+BrqBdCMIs/sWNKhB7g6BWrpA9X+NM1ELx92Gk3wOVregdKdnlaDw/?=
 =?us-ascii?Q?/K8IpGS1hDa6sQ/rI/xIeALORc9Ew3JLaCWEYfhA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a7edd3-ea81-4a69-5f27-08dc47675c11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:20:43.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /f/9vshXpIY97xGRlac7ZkUR8Gbk/HjyHyDX2YL6gssG7lsR1kV4M91dJW1Rql2CwkPrmHpyIMtMSxYmx7pfiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7324

On Fri, Mar 15, 2024 at 05:55:49PM +0800, Xu Yang wrote:
> The user can set event and counter in cmdline and the driver need to parse
> it using 'config' attr value. This will add macro definitions to avoid
> hard-code in driver.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> 
> ---
> Changes in v4:
>  - new patch
> Changes in v5:
>  - move this patch earlier
> Changes in v6:
>  - no changes
> Changes in v7:
>  - use FIELD_*
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 9685645bfe04..4ec70775d1f0 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -42,6 +42,9 @@
>  #define NUM_COUNTERS		11
>  #define CYCLES_COUNTER		0
>  
> +#define CONFIG_EVENT		GENMASK(7, 0)
> +#define CONFIG_COUNTER		GENMASK(15, 8)
> +
>  #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
>  
>  #define DDR_PERF_DEV_NAME	"imx9_ddr"
> @@ -339,8 +342,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
>  				    int counter, bool enable)
>  {
>  	u32 ctrl_a;
> +	int event;
>  
>  	ctrl_a = readl_relaxed(pmu->base + PMLCA(counter));
> +	event = FIELD_GET(CONFIG_EVENT, config);
>  
>  	if (enable) {
>  		ctrl_a |= PMLCA_FC;
> @@ -352,7 +357,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
>  		ctrl_a &= ~PMLCA_FC;
>  		ctrl_a |= PMLCA_CE;
>  		ctrl_a &= ~FIELD_PREP(PMLCA_EVENT, 0x7F);
> -		ctrl_a |= FIELD_PREP(PMLCA_EVENT, (config & 0x000000FF));
> +		ctrl_a |= FIELD_PREP(PMLCA_EVENT, event);
>  		writel(ctrl_a, pmu->base + PMLCA(counter));
>  	} else {
>  		/* Freeze counter. */
> @@ -366,8 +371,8 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
>  	u32 pmcfg1, pmcfg2;
>  	int event, counter;
>  
> -	event = cfg & 0x000000FF;
> -	counter = (cfg & 0x0000FF00) >> 8;
> +	event = FIELD_GET(CONFIG_EVENT, cfg);
> +	counter = FIELD_GET(CONFIG_COUNTER, cfg);
>  
>  	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
>  
> @@ -469,7 +474,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  	int cfg2 = event->attr.config2;
>  	int counter;
>  
> -	counter = (cfg & 0x0000FF00) >> 8;
> +	counter = FIELD_GET(CONFIG_COUNTER, cfg);
>  
>  	pmu->events[counter] = event;
>  	pmu->active_events++;
> -- 
> 2.34.1
> 

