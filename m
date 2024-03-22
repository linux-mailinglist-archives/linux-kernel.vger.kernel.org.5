Return-Path: <linux-kernel+bounces-111623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A1C886EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A96BB21D31
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A401481BF;
	Fri, 22 Mar 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ly7sSORW"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76C43AB2;
	Fri, 22 Mar 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117985; cv=fail; b=Ydsavcq0OVhj4MF7ptFUkiBFcrL95kEQ26pkDb2/N7zi8pOxDUaLBj2vguRzSBWW6kPU67FIHA6OlZaFlzhKAxC/vnJuGqjZrxWe7qeanqfVlJEmuPQRL0i4Kwop3jWOa3Qi4G5q6fXwD84Q+uL0UDqIhOyyO64Hk5EM1Ot0QzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117985; c=relaxed/simple;
	bh=pVcICcHwEF8o0Ooa99Yl9GHOlS18CWqlEQ6CYI6jrv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J8Cib7Uh89g7GJJdKO4r69NP39by2bU38KsfAGRI2LVGL7CDWPwcgJdvzJpqp5s3o9LX3hKx1at/O0ekBV4QDB+px4WKqzhR14dFj7iYkioCSLlcAQuqqlisJJl87XBxQjkz99jFLWttO6rHxis0V63PHsLIbKjyJwU3F99ecnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ly7sSORW; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjCd/pZF4YZBqndo6b3uVfUr+xjSHnB+MLGxBLpLo+zH9sCBGchDYlNHkgwmKIq+Os8CgP3LzexdkJDnFrmmSYTPdvNPPGFxpwZ5rzAhyi63QhS/cCAv0sVSa44Jn5s00lZzG+vSwqPXXx7l2vG5jJJjgsYsCyNG19a1JeZuqg2GLDw/VxdW5pwq1ae4ada1QHjtLT6JfxA4HQtoGWD1rIuXp5H4LFSCoy5IPb2Nta09AreVaV0VS9tvZJ6aECumRj7+lQCaLmYNLtXRGsz6XWyGYojqizd+7xXPU1YP7kqKa7mdHlY2LIp6GG6pxMVQs8zujuXd0Zx5SsNbEOeBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSr58YXZxvsSOvFVumAlHEAGdwBWp6jSexIbn7a8his=;
 b=HGc5CsykPRHROWVSY8ro//TC0f2tf36tA/a0apvjQ1zSS9A2Y4TlLgQBSD08B0ZoyyXR7MP9cz/Bj4w7NwbcxLi/p94ADJG331hokWcZEOVQcFyvb6NibWIFBTTuCWsaq90HY0jwkawcjqOCel2SILuBygHQDDfNPciDSQVH7e5sNLjpSjPoeqiUi7tlgaIIM4Ce/WOSH6WQ4UW/uwoUUrqhoa7AAzV42zpbOBMs7uEPzA6tP0iiTNXmRi3ZA5piD9Utouv3+UVbI0kYTYSqp0PvZ7T4RvwV9pthHaFMozqgUdiNu3BSLRVvQ5Onmj15FhVkgCzo6qH2hgWab2BO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSr58YXZxvsSOvFVumAlHEAGdwBWp6jSexIbn7a8his=;
 b=Ly7sSORW3d0HEDZVhCKf4CaFnYkzKxkVGUwuG6g/zxlsvuEKPn020ppEP3toggYrCUcJ9OROg+7stw2aHYSY/jhErgFh1tyyrrM83pUhz7JVA4ZdmPDv7uSKlujPefdaPlNW8sVdG4NFGBilGGY6LmEHGaWj6aJ0Lt0WFApNYME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:33:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 14:33:00 +0000
Date: Fri, 22 Mar 2024 10:32:50 -0400
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
Subject: Re: [PATCH v8 5/8] perf: imx_perf: fix counter start and config
 sequence
Message-ID: <Zf2WkluX1WqgBJdL@lizhi-Precision-Tower-5810>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
 <20240322063930.749126-5-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322063930.749126-5-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df4c0df-0340-4314-8732-08dc4a7cf9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uUtOjD0bnh+VkHLrcLdV+claaJh2yoJnMGUjXhvwQYyNMFKyr5dPocArjibCzUM7Mp74OLwiFdE0G7dH8V9t6PHQPHbSyCRL1Yoh9/KNCnjYHCy+BNkQUdMsv/Pg5T+fVVHK/3lGE+rGuogsiPWisM5Qz9Il2G+LLHlEgOKjifHMl4dp8xtimSD7ZM5Nxt//UF3ovWdX4NcMawZdBwHi7DLlPdDX7U+co9Jl7mRnc+5459+l0EO2qqxQV6z++c3YVvfLXwoDDfcnx0DlqpLKNOmpYGRFPvMbVaRBNiY1KfGuKSDv94ez6JnfSwWclmZqf4qnpEWS8trjbBKNNCTILuVRPi9D+306xZ8cJVkWW3k/QQLo3pYp/8oV2eyvJ6yf0TnauDImUXLkAHoj3b2KVrhtfEWKqnxNCnSSmohhr+ZbLGKbmXD3DJshPJqGh/V7O7cWj8HVbQFT9LMJE17aWBxxJlLrZhp40oxQ/8clc4rR4v4laHxQCOlNMwnqZcvYyZr4/RR957x1c9j4ws3D2nKVrX080wXOHDruepIhv0Y7hJc2WuGlwUTNX+DtWzyBJYE7reSS/rLi2NhmxJZZR83j7MQ7Pj3eGRGmJ20dr/gvlYHZg7xnatt8IU2qwq9CV4uT24KegjmfTOk0LQ2oE+IR0dRbcTNGOi7Mw+kOgMOtvrk6cLxroHv4AK2a57Phv1IzHwwgS6utnKtusk7dGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBjuHqY0V2FD6Ewis4G2FydE73sjDxib66I5SjxWR9QsCRN6NBMbXKXCmMdG?=
 =?us-ascii?Q?CTyTfCFbYXhgcyuwNAxSGN5Gg3eXKYmgvFc2PcEB4svEQfAXNnKUSUqsArsK?=
 =?us-ascii?Q?m/y8k5oci4WmWocdr3m/HT41WvR4Tg1aR2SR0QqzjD1K+n+PDDol1bS1DTUr?=
 =?us-ascii?Q?6z1BST1ymDuddB8tWQkEqZjzDeUgeH0rK5M0pD5EqnnLazQWV7pJ3LQrT5tq?=
 =?us-ascii?Q?a85zID9Lr+cPYA2Fj3a65hd0QpIrOGze6PnBcaZYLnNOeDrO6aK1Ir0fvB0v?=
 =?us-ascii?Q?5L41ujMWVIkh8yGIm1/0PZUqidO57v9k2p6e/6PmbAYqsjNMjzI4856Pzdtk?=
 =?us-ascii?Q?pXIbZdaqpPmqghntPiIeRQMftzOgW4miCmX3LjKsEcrwchHeI3RUKtvMvl0e?=
 =?us-ascii?Q?WUw8QU73w+fdi3LA7k9oUjYpyyRhYCmD2HnhQoaNaXmbpoESowCFBdCzt4Po?=
 =?us-ascii?Q?XLe6ZWAn8Eq7kM+hMB1xVzenSCW6+KTFI4iCP9l9VEx81gGczL/0qMmCfnzw?=
 =?us-ascii?Q?IHrlhGeE5FYTrRAo+Y7lXUuNZPco5/6gNhenlEFT1pjNtEdKKQDIXq/qjzI2?=
 =?us-ascii?Q?1NbiT5D7qYkzauAmEHY0ZZG20gE+bl+ElWTbF6iNRmTg7FomJYCmL3p9t1Te?=
 =?us-ascii?Q?Ygcn5BUZ587ZZJ4dWGj8HWfoVKWRQLk2ONnz5h1hCSqC85Ck7w0xuWeQATj6?=
 =?us-ascii?Q?bUW3UBdDgH8ii20WReKlIERptSNpIKY3Nen1jP05Qn4l8+9DCEPJiHrLEgHd?=
 =?us-ascii?Q?K0bHLTgaUvVqkqi2x971+uSFB/R6bfJv644QUwVEbZbyuceVx15mL2sExdZU?=
 =?us-ascii?Q?IrEcJyAHjUygyZx4gOsmBRSdWw5XdtZiMXhMxocibf7VaNGPorWdqbA1FtRi?=
 =?us-ascii?Q?X20wbWcs5GwbZ+fi7pTpUoh8mm7CSl3/4nXsmTuwB+HfDbiAO73gbrLZXQcb?=
 =?us-ascii?Q?TAYY3TsN8A3qCw/wN3XjOK17zNv6qZW4n+IQRexsRb8b9DVIbWmINVuRDZVT?=
 =?us-ascii?Q?ZQXnVojQW9iLpDLcy4rK5jrt5GqBNreA8cxDuSDdbOscgKQHeCWPjD/7JlK+?=
 =?us-ascii?Q?zFfOAJO1suTe8x2o0QNSpHeH+oimEYb/wATIZ6gX+8OPwPDPRgbC37laxMA0?=
 =?us-ascii?Q?qyJ49balHf+GARCf4PjBr2hAxpyCCyWGM1QRGGu3USyt8JFAqTuIVWKUkP0C?=
 =?us-ascii?Q?MRkkLsPs9O8mhAyoLnLLQsNfz9EkuLUUPhpeMjJ7otwkp8Dgse5YNBDuHinj?=
 =?us-ascii?Q?QEEF6qaGZkCemBGMf4Zc1NtB0NjHwoqNaKeXYIZLhcXpXvjpyQ3j9h4aBxGS?=
 =?us-ascii?Q?hC7xO9pWOBA1uV3GXDsQwg76E0ztqL9FVrAFaT1M9Xfe9De+nNsG5wkMomWW?=
 =?us-ascii?Q?bGwoevoYlbx8CbRxeX+WzuuNR6CSW4rZPI8sNWGSvLqEGMJq46zjg5Kt96BY?=
 =?us-ascii?Q?857y2FPBp5GRLP/oM3gaqDl0IRp8IGb+GQG6QFtzCpGTz6tWtfvZx1zi5lvl?=
 =?us-ascii?Q?WwUIe5M2UQ/uS8he+ulU4Ea/oAPJK/8Gg5LFs2+t9HBIFZc+Gq4fGucZQdBQ?=
 =?us-ascii?Q?OZDVdIaALSc74Krb+zE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df4c0df-0340-4314-8732-08dc4a7cf9b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 14:33:00.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUTqfcLlubDzMq2qAa7qpcc8xgNgfhIyhJh8DZyTS3Hfl4J8eYww5T9AIDRacjkaFQk+/OQnxfPLby2b3kvCQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707

On Fri, Mar 22, 2024 at 02:39:27PM +0800, Xu Yang wrote:
> In current driver, the counter will start firstly and then be configured.
> This sequence is not correct for AXI filter events since the correct
> AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.
> 
> Fixes: 55691f99d417 ("drivers/perf: imx_ddr: Add support for NXP i.MX9 SoC DDRC PMU driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> 
> ---
> Changes in v5:
>  - new patch
> Changes in v6:
>  - no changes
> Changes in v7:
>  - no changes
> Changes in v8:
>  - add fix tag
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 011377c01dea..fab6596d3e28 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -539,12 +539,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  	hwc->idx = counter;
>  	hwc->state |= PERF_HES_STOPPED;
>  
> -	if (flags & PERF_EF_START)
> -		ddr_perf_event_start(event, flags);
> -
>  	/* read trans, write trans, read beat */
>  	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
>  
> +	if (flags & PERF_EF_START)
> +		ddr_perf_event_start(event, flags);
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

