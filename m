Return-Path: <linux-kernel+bounces-106521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D5687EFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC631F21185
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6926297;
	Mon, 18 Mar 2024 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m4HCC2zT"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6BD3C2D;
	Mon, 18 Mar 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786855; cv=fail; b=OJfQ0Y308j7SdTuSZxjNzhyijaQRCbEn2qe3SfiPuZCIh91KflVo2gOiP3aquZgrgk2Yt/cbpHlasjlvD/x0YenWR02vSlmulQjGxuU3MVGSsvY6gZML7wGNmKpt7vmNy5z5+XRZbKvlKrF4Ne7KcPeESQlIoqABSTS0CLiF/H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786855; c=relaxed/simple;
	bh=Mi8kVC5+VMDRw8VaezQNdw9UX0n90UgpusG9YpfDEsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VzjReqSJjOuTqUShXQRsVTfGyzMCfPRdCXRqGInnpNLsvMaKorlZ/a2GcPT+txGEx/dlucx51P6HbupG56KhJRP6EoFNp5UudLc3en3A0JXfunQn2ipnVQnsoJifS6Yq8oJ2e2ZGaTYniKjUs4bksehpHzwJMi7iZ0iFTNuvbCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m4HCC2zT; arc=fail smtp.client-ip=40.107.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTLgIn+mfTn0e49H8ak4bfal8X70QQxM33Vo4+NfOexyZjA7gc3i5Yk/3JGK7/D5i3WCoyFG27F/Bq425Mn6vHEwLBK5PUOCdqpc/IgV5fFX5Mq+35YDUJiTNfGmZKsrJWPbYJ3lFvjm/wlCJ3XCelJ7QHsSokWm6dFVAMDFQDdYlhcajTDEye5sSOZpcVweXeMvB0kCG9iNQowLvPNv3AcuD8aULvtbLcJUP1/uS5YBVFwMlR1NZpNlILpDGJX6s+7ARJKuh0UWTciUcn71Rn5/95U1LHgC+n1WFzaRYVre6K5mnQXqIRnMcIMG8skUCPueoYjX3M4Nnj/U4YYgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkZf1zs8XB0YHQriDS+JXqm3Ik7UTxrn90/5hq9z5B8=;
 b=Qvs4+eICkTMnjdBQxFT7+w6Nh8SMCQxB1mGHqTCZz/zZO0ud8SK/LXnwyRPdwCDGHyN16nYcWHJwZIRtP/x1IFehVv6Xp00DJmQ+LVy4KNwh6ClGZH1SFa71STN/xwWsnE2dhB5QZUbH+Y+LNQcMZmunKEeTiSwMbn5wG1oGMh7UEe+HOMH463B+V2/+YWqlm2jHX9ArVJPMi7DSCyAlJb11XngObfuN27UVq9+o/pOL11Pzh4UUkXJDR7Rl/Jo4FxDKbop2KJxlpHX3P+lRCafQ14OWee6MK9j4TDdj/xQN258lc0pxATcsliEvyOtpOGNgrHm6XarsBmMaTGe/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkZf1zs8XB0YHQriDS+JXqm3Ik7UTxrn90/5hq9z5B8=;
 b=m4HCC2zTds6wx/3K9ey/g1dU6BMXmSfzpXquJqkxYbXtiIVr0JIZnXajBVbgJzbmMDYXbbLTCaYWYwc5a1qyBIYh5ladmt0tWYV25OLapA0kVlwtnzaW4/8n/S5RxduCfcjXsB6gkVDiYJFHf+288oAoMmuqBYp1izYCRtTeS8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 18:34:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 18:34:09 +0000
Date: Mon, 18 Mar 2024 14:33:58 -0400
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
Subject: Re: [PATCH v7 5/8] perf: imx_perf: fix counter start and config
 sequence
Message-ID: <ZfiJFj1IO67FR/z4@lizhi-Precision-Tower-5810>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
 <20240315095555.2628684-5-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315095555.2628684-5-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5a7df5-0353-4d10-2359-08dc477a0034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bbsiz+uHztgjKCTo8YyF8ruvoy0tzFOtg8XIlgF+pjeJ9OOi4fdoEtU7HFTgikkeA+LaceXpsgq6Tx3QlXtolSBNRtcxNEFux/R09Q9G9klqDlORIMk2gXPcYOzaNjgOeyfyIRZHHxUC0bq0OT8oasFLAuMsPQazqGqs7RJUdxIXqjlK8EEhw2StoRla6L2yHNDcITrRagmxaqVuHgr2p5Yiz2TL8Ao0gIHYxL7l3vIyhL0ZE+p7bPMYrOBlSc8B0GCYOjqIcFYeqvouSwMHXvStrqHaYDqIykFnaC0XYQuyldTnB4HV6kVgGPdYYjeuKVNeytPC9S+dx9Yvee2AMHnfRXqwIfjogIAU3PJiaxPHzO3zzv5YUL41aFxAKBjVMXw3PBm3VY+3zsV+PjhIwGIVWEPnBWaLvt8+CQwOi7he2ozZqqecrThy0JUIDy8wQoBSrCZrS1uTpvBAadQSddSTfGKAiFhSSR9ls8sTSGcaJPOv4t5C8VeRIGoWkQNFEnps1VghqpC0ouRAxiIIRB6IEZyrdk4cZDF19ygSCBRe1XPlqX7a6gm/OR+iVh3+G+4K1i2VpVyHlctYWgkzL1oQOgk0cdT5/Pgh2lRt5/oqzwOUL4LzBmEqDBJnxC5AtaHuI1U6g/ewu69mWjz160UGi6bz1HcoBm735zRZhwRWZaR2eqfxMEToK75uc4DdV8P0lfsXtFDtqgYhGsgRTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHylLoPewnUxVuXLVzd/24ic8HJo9kfCVrHX23yeU9SZUs0oSiyG9EJV+dkR?=
 =?us-ascii?Q?igMxDJo0qruLsA2LRklKgDdEoz9HKVrkNwbtPkukoPyl+kAW+BIajTOtruVZ?=
 =?us-ascii?Q?2NmC8/Gy4yAWOkajuknDY1QsbdCoIua6U+gdDy5CCbwWQjhrRz3OiUgJ6aOz?=
 =?us-ascii?Q?LXRBsrFQfT/QPpDEMaSa+BDDQzfWpdS0FGWvyJQJPBsycPJFBJh37Aq6NNXg?=
 =?us-ascii?Q?rs7Uv5jQjluDk8FkYsOsq7iQr3zkpCD5jPh4X3qwUuIkIojMZg1JrEcBStmB?=
 =?us-ascii?Q?CH35HsqgOEXoNJgfHT/r4RGV3n1UacJAgrbEGiXqzcWL2DNWw7Q+YofeEjiS?=
 =?us-ascii?Q?TtgFpYFTYH3DePLb5lp5Lnu/Y7HTpPP3q6WfRp9dmDKvzvXYs20hup5h8Q+g?=
 =?us-ascii?Q?qegQ/84gEfvg4Ub98LQM9WBcb7w3JUzGIKg7oC5iUjM7ohTSgN4TQK790NGG?=
 =?us-ascii?Q?52ozzg6D0RSidlop2pe/daNpH7H0LHTwxa6h039rrnlFnV6IsTGKHxd+agJY?=
 =?us-ascii?Q?VyWE07GQOpAFe2esrFeHoZwhvyiHnAFPs2W5tNL5ja7S0QH/n55QAaRHcI2E?=
 =?us-ascii?Q?j49UChfcidgxOReNMiBOM6q23pPvuJJyq017wbu3qfl3JMDtPyFB0JFmav/V?=
 =?us-ascii?Q?GsqG8+ZkrjkXVWoHREyAUxmWmC+DC7HYrb5EnyWCnyrDGQajoLrYMzEQIjFs?=
 =?us-ascii?Q?cW50p8WfbeE57hek0WeLw7l+EeENF9YnSpXeZnPrw5eETrkoBgvwe5xPQJbv?=
 =?us-ascii?Q?6ttmgIm9I01IlARAUSer1/wmEsGnG20vxTUDv3n1prlDMCR3HW4NAx8vbzy4?=
 =?us-ascii?Q?PW7uTEw+zpgaBOofpCitMGSWwPbXNaE+fO6X7mmwY2+2SfIw0yqJZr4JK0hX?=
 =?us-ascii?Q?14CfIF7934vk4PifV3FfBg6ALN4PcTnx18bq8x2goKJ2nmMJtJhZJGr2wKl3?=
 =?us-ascii?Q?uq6xGWg10RWqp4HI3f550qYG09FeFTtx3MpxBuYXNMMP/8t+ltczCIMhqa5Q?=
 =?us-ascii?Q?ABDwPZB5Hly1x1ufk57IXck70/aa6JeDwBNvdKuC4CY8wE7QdAcOFOwFUf2P?=
 =?us-ascii?Q?jjYPKuUO9UcO28hC5ab96b3zwJJskQY1CDFOZWdAGyzABq7Tx+0JfnNqFgRa?=
 =?us-ascii?Q?zN3+If3irj3NmJMbRKp0aJMskKfsbdOWCJdg/HXFMgW8Fsz25YngaT3Fsgxr?=
 =?us-ascii?Q?lvauep1SmvcY+eApDPmkR17bFZYRdvPD8PIQ9uet4XlvKcwEbMuacWj+g4a/?=
 =?us-ascii?Q?fDtTzKacwC9LdDqImkqOd+2Zm9/PTOSMDbbcv77pRWBxNwnl6smpAiLTuoXc?=
 =?us-ascii?Q?Q2J2frF/nharhW4l7AgLs20lWdTHtlqzikfCPnaOnCw0s9xPutbMr3U0NBID?=
 =?us-ascii?Q?ID9w/zb+C0ChS2i4d/bihv+1VAJJAAFzGchKSMGSvl3bQebzB5Tbce4viPm+?=
 =?us-ascii?Q?VvZjx/DNUAwxcGKsA5YlKCqoDusAVQmzKfhtesH9oj8lZ37Cq6xbsjTiYuVi?=
 =?us-ascii?Q?Y2v3JgBtMGuNCZRbfPR+8BMtGFbQTPJDlR5KrO5B2dwG/7M8+HtfYryLMGm9?=
 =?us-ascii?Q?qKRKnZH6LAP326QbmB0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5a7df5-0353-4d10-2359-08dc477a0034
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 18:34:09.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaAOsb/YhrTMC3yekoJmWRvFeHBm69pfTVTAHsSug7A2YGIonV/QgSRyUElMlHcsFSjA7ciaVY+gd2r4a1HCAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

On Fri, Mar 15, 2024 at 05:55:52PM +0800, Xu Yang wrote:
> In current driver, the counter will start firstly and then be configured.
> This sequence is not correct for AXI filter events since the correct
> AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

This one should be bug fix. Can you add fixes tag?

> 
> ---
> Changes in v5:
>  - new patch
> Changes in v6:
>  - no changes
> Changes in v7:
>  - no changes
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 5537f4e07852..c99c43b214cb 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -523,12 +523,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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

