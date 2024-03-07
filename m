Return-Path: <linux-kernel+bounces-95875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2993875463
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8491F21DED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DFD12F399;
	Thu,  7 Mar 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmpQhUt8"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCB12FB1B;
	Thu,  7 Mar 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829766; cv=fail; b=ILiZoS92xpM/B8QbNg36Q0mxYRnxJGpjQIkgncddX2rty/0BnUDf7HDQ/Rq//gqFKUapr4SGJ6iCV8XEVw86krjLoyzF+EGvljmpk2lnSvjqZCQ+xuLLVr/LQzwcj4y2tEuq1ACaOQbkQA4/P6K4SfO6IFadatqQms/HOFpcwek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829766; c=relaxed/simple;
	bh=Gc6an6OQxaP9EH3KNDZ3CgeZnXGdeXcxKuJeTBZHrSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oX/nw1j4NstUFbtzlmJAH2TfHSFECNkM80GZ6gCQCb4YHkh8Nza7p6XmaH59om+xJRmNzCbVT4EXoQ45Md6SsqiQ4d4/3tgQWKPHHU4j0s+kaXkmD2g567Kq3FZxXhE6/8H8QVfGVcyYwaSlt1Bw1/mYWrKb29X+GjHBYdwcNgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AmpQhUt8; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTgXZqdns4yDVj0ZSr5YG/IkRflWqvgCfEdiPJXu6sO0oXFdenGU24dcI0M8ZwsZAjxWP2DbKkNeD09aB4Sa7G+bfqefauQmmDqkgClXw8aM+cKZKoJ3mOvMQvBrqfALDzOn2kpaKmVDKX7+wbdi7czc4Dss4BfPy4NJ2ez/2kX17dTCvmBAtu6Brq5WcSr/iSGZI9uiUtz+YzofgsLYXDoV+5ASy/BGszBdu3yb1NfG5icfRVXfKBB6oX4eE380anQtAfgkvMmolMiRvMIU6K8kal4zpOM1eUvm2HVumlL/wn14dNhd18T7L2g562tbyVlC79woyXjNmO2ByfrTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQT8uxOCAH7XQhJz/sE1knanGGOrZqJOTuvvAvf1ZNs=;
 b=IfyjvRBSTfKzj/iCcXS5Q6iiWaljRnLbMXcCMGVup+c8tRHRU5VS+cuokty54o2hkRanQBTf/L1RyEjQkIN1pcrq1LIokesbzsESVlKMf3wVbwK8yEgaJNPoAX8RXxU20crxgfDt6dskj0HiQwMJAZ1FE0ktRYUXg7+osf644GLmgSti7xChnlItaKVJhTuEpYW9mxapgcYMdmgMMdWr3n69rroSJOjptrxoG+gwCunTsrVNVzWtmXS4ZX9dxEK8NojwKvphOgzFFMm/8A40j2iLSsV+buWZbAWsqhg+xiU9VH8+9mCKf8rYFynlPdA5f8ZNMn8tZUppRc//UgYBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQT8uxOCAH7XQhJz/sE1knanGGOrZqJOTuvvAvf1ZNs=;
 b=AmpQhUt8b02JWFCu3bdoBBOOuVN3a3U5iKaDyyB7lDhUhA/0JYz6B/QFMfqG+afYUNbiAvvus5PVIKQMbxBDLZmSI5N5wiakq10EQfR/FheV1bse0XrO5TSYZkBQqtg1GlSOWlTERyOdSITxE6GRsAeElXfNDY7xSqykqKLgD+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6896.eurprd04.prod.outlook.com (2603:10a6:803:12e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 16:42:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 16:42:40 +0000
Date: Thu, 7 Mar 2024 11:42:28 -0500
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
Subject: Re: [PATCH v6 2/7] perf: imx_perf: add macro definitions for parsing
 config attr
Message-ID: <ZenudMDnq9bGzKbI@lizhi-Precision-Tower-5810>
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
 <20240307095730.3792680-2-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307095730.3792680-2-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: bef73d75-9459-4a7d-0daa-08dc3ec59a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	myjcAflcTZfsaGFYvQrLbU9u3YF9JksUrhRWy2GE0JiCHnNIfTfBFvFWJESDW0p4GEsl6nJdKQXsK4a/28LR70VyTf+fY0sqKjfpvU7qLYLigVfVkVol7Zr3LefECDnfzWQKyoVDCQsmdE57/dzSWdVUwSnR1ay9h2uYxBZHNkZAkK4VHPLyNprc494LxOAFEZlYZgnTr0liDNkJARk+vvxk176OoMvkeXROL7Rg1enomjeisge6HS7uZNpco4VAiu/liLQKwno9RfF7pFBzc9B/E/RKayOCJILWiYBC0nh+tDCRo1toJpjK9fvoIt8iBqDvs1ZgpiRZInSjLs7IMJYu+3i5L+pmtXgQqWLu9LeUxnKWBtFWvMymVO4BLJC4Y5Eqh7NmehMTE6LrAcv7cfnlDgEGQwOS/SthpQl3F5sjRSwn1bIT6Gy34yInpZVn3iXuRJ7mok47USPuekfS2hjKM1NRsNv4vfP8a0ITfSXHLM8DHMVkwHTAEE5WUycmKVcgZ3hYTgkl4j/GHgi2ER2ZH8OTPlVa6nCUTBd9/uip0oKfMo05QiRvewSlvL9wDDaRIzUgqo2y5v/U8sGK4X5VYcbElZv36i2WlSI4wC5VH3X8UTBqvIIEERaqnKBa5AJGODhdKw3UL10ZUcMxPW7b2sEtoKjBuufahsNTvmPIK37M2elTda0Jmnvif4a0xgOdqyFUMxSeaZ+kjNl4a3ghRbZQ2n3DTaSkvqHb+zY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yJ5OeX1lDQo58fhMyUyJRf8J6Byigj0t1ViVZFcExwFzDrp+6VLmjCDP2BVR?=
 =?us-ascii?Q?zwvwNeFckTeWlQ1tYcV2WB2nWyC7mYirVu9DlrMm9C3HFeiHURkMzaKl1ei3?=
 =?us-ascii?Q?1AVOCTi3WA4jvIF8kiEIhJg+uwejYj0yiQX1+84yniXktYlZ2DF0fVPpaEkI?=
 =?us-ascii?Q?2HEVv2Y0txPsCN0xJ6qzr1hdZstT3tHx7213LTMKxxeYxlaUSsuDs/2v14Bq?=
 =?us-ascii?Q?haNSl2HYgb9ht+99kIjTwxhdxTq+IcCf0SlR37GkRFTSuxb1rW6etC6tpysU?=
 =?us-ascii?Q?AtG1bRZNcP+W5eEN8EJi5Lj8iiC5wsKbREH3bwIM3MFQR70PP+KuElrj8I5g?=
 =?us-ascii?Q?vp0+Umpnd4Q60Ly5aoRoKnVwegUVdgsR+UmQlFNhMs89ssN5hzw4DIxa07v1?=
 =?us-ascii?Q?FZMR98eAxJwtr4p1n5Hq1fIP1OsITDaKMhrbCDdUwO79sr5NOw7tSfdvHc0A?=
 =?us-ascii?Q?nKDdcgnUf4qM/sqx6lJ519aa7AYKhBwVi6HDFyw0uCdTiJQNdv0n7oqYmumC?=
 =?us-ascii?Q?zcalGNgB298eC0WVWg20GuMNH68bZmD6sgYCUwpZ/iaaKnE8vH3ejyq/daYc?=
 =?us-ascii?Q?2Jm7Cnn366YnVQp4PNDao2AqF5gNn3miy7fURjxJ+JjFjPGHNwwurMPfRKoP?=
 =?us-ascii?Q?uq1x5P2ixNPrgz0gFwOFBbaxGqVyrVs03U6ofhLbiOKfbuJu6gs/p1gz+yDr?=
 =?us-ascii?Q?ZDxEtJj/yPSzJsR5T6mIjtEV/B8OcNGh1Xgh6015RanBj7nC8v8C7VBUhgbO?=
 =?us-ascii?Q?2UEhG5grCUvPMNoEQum2NmmyPXN4m5ZHnp5RHCm0gj+sUzoCLIF7TtCQoY5f?=
 =?us-ascii?Q?2sw/cBwI0PZEvRJaQ2mNOUAuizkNXq6vnKJ1BGDpcvR3h/5p2VC1QD8fqYMM?=
 =?us-ascii?Q?jxa8WhhV/WMS8Qk3n6IJiu3bn1swKMgaC4TK4jOXfi5iVtyYNKr/RPWSXXnf?=
 =?us-ascii?Q?p/boOCoaf/R9NOduPIsrqgLZAL54oum83KBsQE1LW/Ff7TU2bwl8zUHSgriA?=
 =?us-ascii?Q?yn2LCybQYxeKpCpLGT5xTccIfqhL59DbXXczXSoXe/MYB/4d63O51aqa5NAN?=
 =?us-ascii?Q?wSXc6+xCqBovlaJQ1MmFy4gWV+W97oqZ+wDMmGaTp761Mhbow1c4cblgi7vl?=
 =?us-ascii?Q?nEHqZrS9xTgB2dlNNfUs3rKktM5OP6/pSVxn75Plw2y0Jz0xBK3wIxAlSaqV?=
 =?us-ascii?Q?vi9GEI310I3Ocz0IovoBSVloPkNhTJYpWXJ4SzKTdFB7z4nqmuLd0VhxfUVX?=
 =?us-ascii?Q?h6LPDcyL0Ip+ck5xJDS1zns6a0bHipRyK7xBBV7fmjm/9355DG3D/wcZa90s?=
 =?us-ascii?Q?96ZqRpjuKrVE+USzSWK4UIRY1lNapCwKk+xbylSJSZTJdEijB43vM6mwsEns?=
 =?us-ascii?Q?cw1nv6nBudCeuGqMusGIbfy35qGvsFGAohyE0zLmK0zeCuq/7v37gp2uORMt?=
 =?us-ascii?Q?rP0TpG4VRC3JFHUeMbrR5+C1AqRXR8yhtUEyr7YNpY6MS6x1ekEb4fBlZUbD?=
 =?us-ascii?Q?ouBwucPz2/I26CBV56MabvOoDWoWWjcPcTwDix9v9KqdxrPUwI5pbg01SF1x?=
 =?us-ascii?Q?F9wdZjuJ9iEaZ2n1sfK1WboXQG/GKb1jaGFVIZJJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef73d75-9459-4a7d-0daa-08dc3ec59a6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:42:40.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIG3l6XnmcMy3ffokboNyQpfV8rSQKyZz28du7eKdr+J80Qh6fU+YdQgRaMogAWV89wE7fNqzcY9o5DhcAiopw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6896

On Thu, Mar 07, 2024 at 05:57:25PM +0800, Xu Yang wrote:
> The user can set event and counter in cmdline and the driver need to parse
> it using 'config' attr value. This will add macro definitions to avoid
> hard-code in driver.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v4:
>  - new patch
> Changes in v5:
>  - move this patch earlier
> Changes in v6:
>  - no changes
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 9685645bfe04..d1c566e661d8 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -42,6 +42,11 @@
>  #define NUM_COUNTERS		11
>  #define CYCLES_COUNTER		0
>  
> +#define CONFIG_EVENT_MASK	0x00FF
> +#define CONFIG_EVENT_OFFSET	0

Needn't need OFFSET if use FIELD_*

> +#define CONFIG_COUNTER_MASK	0xFF00
> +#define CONFIG_COUNTER_OFFSET	8

The same

> +
>  #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
>  
>  #define DDR_PERF_DEV_NAME	"imx9_ddr"
> @@ -339,8 +344,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
>  				    int counter, bool enable)
>  {
>  	u32 ctrl_a;
> +	int event;
>  
>  	ctrl_a = readl_relaxed(pmu->base + PMLCA(counter));
> +	event = (config & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;

FIELD_GET(CONFIG_EVENT_MASK, config);

same below all code about config.

>  
>  	if (enable) {
>  		ctrl_a |= PMLCA_FC;
> @@ -352,7 +359,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
>  		ctrl_a &= ~PMLCA_FC;
>  		ctrl_a |= PMLCA_CE;
>  		ctrl_a &= ~FIELD_PREP(PMLCA_EVENT, 0x7F);
> -		ctrl_a |= FIELD_PREP(PMLCA_EVENT, (config & 0x000000FF));
> +		ctrl_a |= FIELD_PREP(PMLCA_EVENT, event);
>  		writel(ctrl_a, pmu->base + PMLCA(counter));
>  	} else {
>  		/* Freeze counter. */
> @@ -366,8 +373,8 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
>  	u32 pmcfg1, pmcfg2;
>  	int event, counter;
>  
> -	event = cfg & 0x000000FF;
> -	counter = (cfg & 0x0000FF00) >> 8;
> +	event = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
> +	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
>  
>  	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
>  
> @@ -469,7 +476,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  	int cfg2 = event->attr.config2;
>  	int counter;
>  
> -	counter = (cfg & 0x0000FF00) >> 8;
> +	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
>  
>  	pmu->events[counter] = event;
>  	pmu->active_events++;
> -- 
> 2.34.1
> 

