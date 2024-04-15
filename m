Return-Path: <linux-kernel+bounces-145413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0AC8A55E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162D4284844
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4EF76046;
	Mon, 15 Apr 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mswWHUGn"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BED78297;
	Mon, 15 Apr 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193330; cv=fail; b=UdvcK86k6rZuUes/eJ5hZHUOZcjVjsBZW1uYiDjwKcABCubisvXjoJkZTt2bSscdyMbE/OXurqPkmuANcJwwbLyiW+G8uU0fxtR/vsH4laICXFAZDcuiOQDEe+HsJElRZXauQ/MV/KguOy07cp/4WRzzr31OW+kFjXo1j/DjgcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193330; c=relaxed/simple;
	bh=Quak7+xrfhBCwXK4ypDW87esPqc11Bm4y0kFzXMmzv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P//qs6IA96ytrtBmg/eOIqI29KllgUqFbfkb6R6HzWFMEqcUetuGMaphMRAqpR1KnEo0Y3Me/lcgtAxVC+jdtZkidqufhkz0Z9tALDrGLO2UOWM0OnU9oxShqQrxc9oy+wonbKVNqtNvI2kVJeaOsa9Ayb6z4qympsbeh/rgy2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mswWHUGn; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiharTUf2kEjQ7vVSZWsROz8XyrAc9iRKvuW1SukbhhDJepqAz7S/LRo9h28uaTN1iSuXiM1wVZuVeDqUhyFQmE/V0HAceitFn/JvjwYYo5t2sEnvclD3Ee+KtP2syuqE2FalYFVGRBW26X5jh9OerH+09FTg8igr3AtFn+dkcoLi4tPDp262CJhqvCh/MDKCtg6CohvDZXaXTBAn0BtVgnxqzk7Eln0gI+QFJ6w+/xzvl1N9xXsf/ySLRdXOLvKBwM273gp7IORatSNmzb1Q71wohD0i3efy0+RtlLsSye4KNHfTkp9bvY3Sy3mXjjP8qzyJT0NLQwXNapvI07OVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6BlnOG8Q6IOKH/nzKw5ikmdfZ3Ln7R243PBduCvGdM=;
 b=RKUDPD4Kmlt2qvZXvlVXoLjYTEJor+Y8IMIgQGlcNtGW11NV1HOl2foWaQQ6RMVpT98d9UOF5iP/4UI6n6EFBVZN/+YDpl5+U8cEkiEuJcopbLCe8KiJuEjucbgbc7yKIsZExkYQnW26DdbMoCotq2xP7fjeOStt30LsqiuRBbLPVF0JyxMjlYeYth5USh/ZduSZWCxyz1A3yf5sUnL0sohCZ1TwYZlhgiHHM7E2h2lFzS44rPsejxJTJsuSgSd3abOPGAijL1lj2qVNip0KXkrH2YGbIgAVXU1wxmnzItwUpyGEsMZ8u4mf66sgi5L6jFqPiA/vTVMB/MSHkyBgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6BlnOG8Q6IOKH/nzKw5ikmdfZ3Ln7R243PBduCvGdM=;
 b=mswWHUGnsBM1t433F6tVZ2Ez8XQ2xrMgwHYgISCson9OMluzs9gxmOiaCLWxP+bFka/8hhohwnCWEOeoca6QXyl7s4/KjRCvRAKAovqxvXkNX0p5Fh4JT+qymCgtvJAGaOmj9KCu9yPNMub4i1jXoQ1rSBwgpmggi5diVK2U21E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 15:02:02 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 15:02:02 +0000
Date: Mon, 15 Apr 2024 23:01:40 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 6/8] cpufreq: amd-pstate: get transition delay and
 latency value from ACPI tables
Message-ID: <Zh1BVDUkSSeHOvmP@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <ee3c290dcdce4a746fbd882d37e9a45504a5ae3d.1711335714.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee3c290dcdce4a746fbd882d37e9a45504a5ae3d.1711335714.git.perry.yuan@amd.com>
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c2e897-b42a-4146-2a51-08dc5d5d01ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+EJufukMZkreYCZ36dHRq84jnpqrUaJCnxMzIfJv2wdEIMQbPvGZxN7S8bBQCZ2hUNbN7jScn0u00nogl9l/RZoSHV6lUqfbWcdD76yFslFPNLe9AfEsda/E0ShfYcEnNllGIiHd1sigg4WlAyGRkcJ6RAEoHnIK+I3gDbfWEOydRAdNKmtpXCajHTRWdxvA23PHO+gdPTLv+2B7gesbvyDnFf6L0PDwFd5IYwd+jQhlU+Rek7i2iuaASgYYVtlAaTUWDEv7drb54ZmxX730cQK+HGtRm2Rp7OmdxTQyORLjjq+s1QeNU+v52y1Hx3VIqv7shbuiXUw1I806aZmI2xG+EoBiagBNzBJTYxhjGP7Xyyce+/QQY+5kHDwiY4ElubRf1qd0EeFaJBq8LC67mMAYEkwYCkrbYEI0yxX67774BOlxkwigP9rc+gayQa0R5TJl6504+fz+xybBov0ryEEEQK42yvIaiIPfqZBSWG1+EGFIrmFVI2I0TlRynBHEtKAqYNHerlopynvvzbNKTuejW4V7fD8CzlPCwaqDE5VnFrX2R5iEvNHp1hniaaQEdN96JeU6jo+bXZLETjkDMbV/9xaHKI3T7SvAnRWQ30DOB8oGSsVLnAHFVck8XNIG5Jjka8mO7Hp7lR8BL5AUMPz2g5/ELYO/cY4ojayW2M4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+U1DslTXGb4WAyXG1smSRk11h7KlLxqV/EmKcgtQkHkdwYd2+XzKYQgEnUAV?=
 =?us-ascii?Q?eOnI2KsPsmk1KoWhKmfmw57fLYRz5urYtz/I2a2tHRSD9Zzb943LlktXz9Je?=
 =?us-ascii?Q?Q3BQ+cC97t+bCnsxB4UyNkQ74Hk44ebATTyNvC2O5P978LrTTICuko2ze1nI?=
 =?us-ascii?Q?1pUSjW3MuuChkKHdZDqeMIUfOh4ZIkam8ldKzHgvsRGwDnmIiAYEK3YGSuAv?=
 =?us-ascii?Q?CbB4xUrfqxVTtFlqWa/e6rf5bTs+TRnZJKSKLq1/4KUmmVXsr3+CPXrAU8Yg?=
 =?us-ascii?Q?G7lPt2aZE4V1trBhlt4cQrxGCgoOzWA56/PAtJgEV/M6dNdzcEEGqElas0S0?=
 =?us-ascii?Q?uuPRabX98+u7yWB34Q9AujNuZX7Rwth0fd7NMNqYSpOPI4pKgcsTejXTc4/v?=
 =?us-ascii?Q?fhJPBLyXW+jmBLhxm7mlLsr/zhJ/DwrMBMoPc9jwH65FMxWuWhRH8+4yuvup?=
 =?us-ascii?Q?4l9m4EhSWfP44YVkYu9vVGXznZOOqiXEx1/gXyPQQ4fgcEfwMiTX1bB8Jl6c?=
 =?us-ascii?Q?XccIwOX1h7h9WvbUwQvC+69gW4gA3pYimDqWjTNzZ6cJ8RdCW9E+DxPndewV?=
 =?us-ascii?Q?fGYti/42L5cOWJB94VzY8TkdStMNSc0K+OQj6B7JI7OS92RtJJ8+OxVDj5OK?=
 =?us-ascii?Q?q/YN43qMT+Kk0N2oZ+N8WJxoBY7weWWyAS50jYX+TpLh8xrq8j6JTJfBtKTL?=
 =?us-ascii?Q?QDajD9GBIWFVzo/TUYBpaP4isvPmlWxHYsC7bVTUD/tleusd8ZQdZmwuIZyu?=
 =?us-ascii?Q?SnmZIJYQnNkf/Gs4RLAsWAFRtjS8TcnzZGosM+RkZ/slGLX8mtXXWmwnEr3k?=
 =?us-ascii?Q?UMGGWkigiZvXXd+bdTc9YxP0voQVg3GA9RuLpb8xfTwGqFrtxxxECBJk5ExR?=
 =?us-ascii?Q?FFdzTTd3nrwxgDmiRQY3wMohKdjDh4IZqQmYds5mamnITmv9d3pxqDhjDOXD?=
 =?us-ascii?Q?qzDa4yjmFPuK1QsNNAoXxGzOL1nz39S3P7mpkDq7eFmftCqcHYE2bO+igkVn?=
 =?us-ascii?Q?2vMf7PzOmI/UlmHgqRhgZ6JCNLMgKKVsNbmVeB2tWEC0DLbCTyTFCIjO/bOf?=
 =?us-ascii?Q?A+ZuZ0+QI2bcD4Be8Mvxp7xc3pxwx8pm2+nTnK/4dfPmyC+mX/Acj7ljyeQS?=
 =?us-ascii?Q?k+uZmeS9J3mfl7lVU/wA19i70tXYdNS2BGgVXUvHboZaXLgRgmyXj31QMRQi?=
 =?us-ascii?Q?/8hdtTwvbpXF9Vip5kLX9wO6cILRYd6OyNnL3YKIYxdqOkhEw81Gq1BGhUJt?=
 =?us-ascii?Q?eUHUUuHRwUuPdAvywmF6ljlMxr5R+F9O6rMoUW+GBGBdnc++ZM9Vqw6qWou5?=
 =?us-ascii?Q?KEKDJIKVj1KBtYxbrtYl5h3vkDzO7oI1jutNi1Frd1rDReaTE7oCVIT99TVi?=
 =?us-ascii?Q?Kn2FJTPYQofxXKTGLLP8PQ0u2GPVOQ+RA/0PqaJqeYRsVXWfGTeu7lgWl1vQ?=
 =?us-ascii?Q?Ay1LCdOjsoq0nb1TNpDPaNIZlHcng9l5rT5yS5TRJ+fsnc81exYxvwQc52Vy?=
 =?us-ascii?Q?6dv+XbvGsTTV3UHj6ZwKndDkXdYfgZDjneFYNcaZnyWJ+Mr2z8WdSom3e9oP?=
 =?us-ascii?Q?DbzMl76Wrji5RVzXTayCjg9lcNUr8TSKVS3qUMXG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c2e897-b42a-4146-2a51-08dc5d5d01ef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 15:02:02.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gm8lbv3z1BTVM1RU9McfHX//yij/lW4AJR94mN1vkGawvGmres/wG5YA+TA+FeOYQxdvNG1OSU7gsX2joV0JIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597

On Mon, Mar 25, 2024 at 11:03:26AM +0800, Yuan, Perry wrote:
> Make pstate driver initially retrieve the P-state transition delay and
> latency values from the BIOS ACPI tables which has more reasonable
> delay and latency values according to the platform design and
> requirements.
> 
> Previously there values were hardcoded at specific value which may
> have conflicted with platform and it might not reflect the most
> accurate or optimized setting for the processor.
> 
> [054h 0084   8]                Preserve Mask : FFFFFFFF00000000
> [05Ch 0092   8]                   Write Mask : 0000000000000001
> [064h 0100   4]              Command Latency : 00000FA0
> [068h 0104   4]          Maximum Access Rate : 0000EA60
> [06Ch 0108   2]      Minimum Turnaround Time : 0000
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6708c436e1a2..ec049b62b366 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -756,6 +756,36 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  	mutex_unlock(&amd_pstate_driver_lock);
>  }
>  
> +/**
> + * Get pstate transition delay time from ACPI tables that firmware set
> + * instead of using hardcode value directly.
> + */
> +static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
> +{
> +	u32 transition_delay_ns;
> +
> +	transition_delay_ns = cppc_get_transition_latency(cpu);
> +	if (transition_delay_ns == CPUFREQ_ETERNAL)
> +		return AMD_PSTATE_TRANSITION_DELAY;
> +
> +	return transition_delay_ns / NSEC_PER_USEC;
> +}
> +
> +/**
> + * Get pstate transition latency value from ACPI tables that firmware
> + * set instead of using hardcode value directly.
> + */
> +static u32 amd_pstate_get_transition_latency(unsigned int cpu)
> +{
> +	u32 transition_latency;
> +
> +	transition_latency = cppc_get_transition_latency(cpu);
> +	if (transition_latency  == CPUFREQ_ETERNAL)
> +		return AMD_PSTATE_TRANSITION_LATENCY;
> +
> +	return transition_latency;
> +}
> +
>  /**
>   * amd_pstate_init_freq: Initialize the max_freq, min_freq,
>   *                       nominal_freq and lowest_nonlinear_freq for
> @@ -848,8 +878,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  		goto free_cpudata1;
>  	}
>  
> -	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
> -	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
> +	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
> +	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>  
>  	policy->min = min_freq;
>  	policy->max = max_freq;
> -- 
> 2.34.1
> 

