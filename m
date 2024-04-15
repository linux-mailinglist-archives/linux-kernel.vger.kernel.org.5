Return-Path: <linux-kernel+bounces-145402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8F8A55C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A081F22FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E4F78C84;
	Mon, 15 Apr 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aP7UP7Rq"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871FE74C14;
	Mon, 15 Apr 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193015; cv=fail; b=dQWGPprFSj6Y9BrxpkuYqtaI5Fu+kZEnPU/wROhRuv5UyNUe7MMThJpMCdtvJD2VZjIkh9cBvbm26MzSlL9dB/NhE10oPTZOlrv5DKkSIn0v4DTvBZnudD0I0duRqPGhosKkqi3A6fKgCxH6cYsgXQV/LKAJWSxqzbzjgE88TrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193015; c=relaxed/simple;
	bh=AA2jZQruJyI21TnCqYa2HJJiC5gAJi4wUfkYgsviKzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dazz1TG+kGhxy+lTkRX5PuIDpFsVTbernZwDT+Ps0JMB2gjurGaKoqws0TBc8Hs8tcgD/A/D2X1KK6+efw82yuofQW1HYGcPWe0YJ0J+spaOf9vl+OcNKSiYeAp9MoCAGvtYS3ULFG/Dbe0nh9E9Y1MeCROHBQgAtBq74sEmnyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aP7UP7Rq; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCT5smn8zQx/GqLrFHRbrdqf6ekWHGwucqxZOZAtznml1mBWVbZ4WsO9dmrkb24zSlq+A40lzOVDmWSG3dhU4P5nswA/kD+0qePGYw7FsKFj7ELUob5lCOcZvBLI2DWCgZpG+gmxeHUuPbPvn5VZ10InQyOapOcBT4IGYKm/hd/FeNnlYm0lPiBBFy8omDxtH0O2Lh6H8LpmUyKbIYobijG23f4Fjqd8L+3HMrB8u3rld//oLEdF2PYa2oYjIG7gRtawdNDkTW3Ewl4XjUABh+IcXwaOsp9f3VvU4XhynLSe0YDQ443srmul4x4RUIvsLUXp5KWhq5A5h/skhKnHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGNMHdc9ltP6QOOrwiqt8E3lGyb5hJKW4jVUqqKYgxI=;
 b=GZy8XHK/S+bOghz7H9kpFfiP1Ph6ibBqUCUv54fIPVgKdPRFvDB+JbAGXb91j+i9LDd6eZw1fwor2OS2bFNxm2WCT808BE4v3nCzQwwdqzIkYD0W/Z57ftlB+BIfXYsCIQYEOO7mi8rzFgtLE5k0viSfR89DT0O1fVCApXifnZBHGEoM/p9xc+r9JNK9+rVVRteRUBldIo0zLMqBufOKVCXJpTWpkLyyU0PHU28Qm70ty/2la72FHys21slhyl9lafFLcjwUiNpzBtXj+Q76aAbcmTQIyVjPTkAB/cBxns9+0N6W23gqe9ymYf1XOQzSabbfhLhOt9IPWNxlU1Ahkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGNMHdc9ltP6QOOrwiqt8E3lGyb5hJKW4jVUqqKYgxI=;
 b=aP7UP7RqcfMrx93+iqt9IHpAiOkirjQDSH/hg6Nn/FaMK/mP1OZBASj+pqz8NqTcRlj2ZeKQDOzhFoZLtgexkQhObqmvcuocf0L8hdV9WpeROvFyBFemkT6hX1qvS9n6PTTAZYXOunHdfU1LPgqh+TOfl1rjIJv5aUaYDvZXk8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 14:56:50 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 14:56:49 +0000
Date: Mon, 15 Apr 2024 22:56:28 +0800
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
Subject: Re: [PATCH v10 4/8] cpufreq: amd-pstate: Remove
 amd_get_{min,max,nominal,lowest_nonlinear}_freq()
Message-ID: <Zh1AHC7anVtP+pRk@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <c80c43cb72f7f9264edc21636d457c32d21de214.1711335714.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c80c43cb72f7f9264edc21636d457c32d21de214.1711335714.git.perry.yuan@amd.com>
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a177dda-3b78-415f-cd5b-08dc5d5c4767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c4oRX3uwyv2L6VAOzr9yysiR7rH6Diwu8OvSPw9tD9Ts6K5Ho+KeFYX34ClhHBPCyUkVKk59A3QpglREAnjKf8gmZONwQZFqTtpL+La+t0ObwJI3YZjkvcDwQzduI4GUtW7hA0Hq3ZjYgTx6XNtLbNK8Yr4vqZKn0PjSwhATOgKZTo3ZdALklZkhK+qxduJgTtIQEGF/07wYTea54hftIsaWLwwhw3c7aaxYO6PBbEwBVqJDbJnWWVrgUM8RBEpABHjjfWSiSEBK3hzq0RnSiD8sEcbSc60gYTO/MUYL3LLCB2f+4aUkFnV+nGtTb3cdVmPGpK4Sdywy5+03nAS+Ubd9IdduI0j1BSmBnjkinaQxW0SDAiaDayXkiGD8t7nfdrFoX1h0L66q9AqjILWKB2MXwFYr6gefK+sjoEGqda70ArP4Ye1Ap8M/9c+TZd2mAAbqQuxZqQFljp0088KdqJz4TG6eRV1xW5ImkIUxuoui+6zjkX/4W4LZS+HYZoTgR+dg3MOIevU/IUwOr0wrzwK6jNT6dijUYPRs9UHd90HBscjHtT638H1ZxquhJvpE4nZhGCiK7WP8txggdAEWmro2EJ4P6DNfhF80ZByV1pV/LFRa2Cn6YR5jp/88/4TbVrTMy0U105u1ebrBnW1wtf5gMz6KD/ZXniquTpe3WqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55zNnI9pgCMCZDCcJdhS+NYbSeNGzV7TtvjTHCSttbJNfQmLOC+VFijag1vC?=
 =?us-ascii?Q?9dxivOiu7ocrb7IaGUoufHQAZrw8N3DxxoNN8Wd/WamzqYBZvaeYmBNHx0Ha?=
 =?us-ascii?Q?MhZCWSK4HryWfhRUHqnsKq5qOg3qQ8dlo6KfXakXEeS6el53lyzxRnsxyVRZ?=
 =?us-ascii?Q?3ABWrcT5RXonGAEZTZY0RL4YiWMvppk5moIgGAYAZjTew96LT3evPnn3pWfG?=
 =?us-ascii?Q?xqF+9X8Y+ub8ZwvuqVYGRu6rOfoItKpd2MbZwMnUScSh4NDMRFllI3fYuesL?=
 =?us-ascii?Q?efrgdKbmLqm8U4Jy6u0Sn/t0F6uLmPmX1azEoXrmx6WLj7n5t5QJdWVTHSTC?=
 =?us-ascii?Q?li9j5MEYJqgVIWtu7AglXKqtRJtV0ds9Wr2lzjdIkQsrgq00GPQeVUuGHj3S?=
 =?us-ascii?Q?bIX4BfuW6J6hggM6AzWVZlIrBC+Oiybdb1va83rpxhrQ/4ca6FG+KBd+8Fn9?=
 =?us-ascii?Q?vpInb5GwDevG4k/mznhNzQfAcKS8Mo4A78P0lvZ75ffJxD77UPDDiH0lO1r/?=
 =?us-ascii?Q?C8gLI8g/3QU4kktkSf10hufTTmrZhzirmG1En02MEgEQiiaNEoqvdOAdHzx4?=
 =?us-ascii?Q?VS5vopExrggF9LwW8eXKOwKP5huGjhcGfTxXP9rG+pK64dp8dGgkSS3DmLwS?=
 =?us-ascii?Q?fI00ceG7K9k/X1pVDvZk1qXdK05B/0FZWzQVjqeMP6mCdNz4WwSK4GBPMS6+?=
 =?us-ascii?Q?UUTj0swd9B41J3pAZ8iEjJTUhaqI3Dod3nX+RrKUO/s3ELjhfrDalVGpF+ZX?=
 =?us-ascii?Q?AB6VTJKPYfQxL5CHq2ohMJnLfkcfV38WLvKVR9opcHMDR3Or8KM2Cih0GGXM?=
 =?us-ascii?Q?yWxFjnpP8ZU3ZNEJBY3ZIqvl58a1f+Jn66RLtNVZXAsWGdJ6+J4SqPEU61ga?=
 =?us-ascii?Q?CYuhONGywemEMrwNTP+9H8FMYrIak444uJ+F5M+dDcIpommUOopmrXVZjG7S?=
 =?us-ascii?Q?YxiDmtvX4jhbqBm+jdxmCtaglCEkrBWi6EvoDpTQb0Upt34H9sbdFXjEzRF1?=
 =?us-ascii?Q?Q7B73FV5vcErzozJdW+wXfFpysRxvRaOtxmJJo/mlYCT4CTIdnXyiUnjRvYJ?=
 =?us-ascii?Q?yphcWFo1xWoUq+mZrjP5WFkX0xpfqYpovKsRUGX6fv1anFA2XPH1IYQAZcYG?=
 =?us-ascii?Q?t0j4uRlACqprL3KwgTLoQNSmGAMhfn7IeQ5OA0sOH36NMGh0eGG+Wp09oR0/?=
 =?us-ascii?Q?r2HTi2/KX7NvELuseRZdlLfu/6s1SSMeVLuSK9JQWD2Xscc8/T0u0ahwaU3u?=
 =?us-ascii?Q?pSR19HkwZK0SFMaf8b/yaeyrP3MKouy6ydxbkax0yCRixu+bExe5APWEbcC/?=
 =?us-ascii?Q?Cq5p9DeEF626HRUMp1VLxgVAWjpB5oYE4CtFje2w7XbqEFTSByPaX0ULZ9Yc?=
 =?us-ascii?Q?ZWyxhtZZ4aoRgyIuxbYzArHrncfqbRXu96XaWzcfgHdmZEUahFjdJuZR1o9K?=
 =?us-ascii?Q?D3skQELwJGbCOz/6VM0LnVRiuumC3OFnwS1QG0Ev+MaHkq0a9BXYATRnxHtc?=
 =?us-ascii?Q?aqrD44/ftBXmmEF8VwLHSdHYkZjj/zI1EeOD0TGj0j2klmk2lT/GS7WQse9r?=
 =?us-ascii?Q?MlUnF8daDAkJqWrNeiaekFGFAmCoPQ/DBNIeLFAN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a177dda-3b78-415f-cd5b-08dc5d5c4767
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:56:49.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62fubVfUZHrovU5PJqX5WvGRcMvk+btYjbGUrW7Uy4Q3Y6qtzZG+yxyGTs8sXFgq2oUpIsVMgOZ3zP9uWBTrag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330

On Mon, Mar 25, 2024 at 11:03:24AM +0800, Yuan, Perry wrote:
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> 
> amd_get_{min,max,nominal,lowest_nonlinear}_freq() functions merely
> return cpudata->{min,max,nominal,lowest_nonlinear}_freq values.
> 
> There is no loss in readability in replacing their invocations by
> accesses to the corresponding members of cpudata.
> 
> Do so and remove these helper functions.
> 
> Reviewed-by: Li Meng <li.meng@amd.com>
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

The same comments like patch3.

> ---
>  drivers/cpufreq/amd-pstate.c | 40 +++++++++---------------------------
>  1 file changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ba1baa6733e6..132330b4942f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -604,26 +604,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	cpufreq_cpu_put(policy);
>  }
>  
> -static int amd_get_min_freq(struct amd_cpudata *cpudata)
> -{
> -	return READ_ONCE(cpudata->min_freq);
> -}
> -
> -static int amd_get_max_freq(struct amd_cpudata *cpudata)
> -{
> -	return READ_ONCE(cpudata->max_freq);
> -}
> -
> -static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
> -{
> -	return READ_ONCE(cpudata->nominal_freq);
> -}
> -
> -static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> -{
> -	return READ_ONCE(cpudata->lowest_nonlinear_freq);
> -}
> -
>  static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> @@ -854,10 +834,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> -	min_freq = amd_get_min_freq(cpudata);
> -	max_freq = amd_get_max_freq(cpudata);
> -	nominal_freq = amd_get_nominal_freq(cpudata);
> -	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> +	min_freq = READ_ONCE(cpudata->min_freq);
> +	max_freq = READ_ONCE(cpudata->max_freq);
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> +	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
>  
>  	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
>  		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> @@ -960,7 +940,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  	int max_freq;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	max_freq = amd_get_max_freq(cpudata);
> +	max_freq = READ_ONCE(cpudata->max_freq);
>  	if (max_freq < 0)
>  		return max_freq;
>  
> @@ -973,7 +953,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>  	int freq;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	freq = amd_get_lowest_nonlinear_freq(cpudata);
> +	freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
>  	if (freq < 0)
>  		return freq;
>  
> @@ -1315,10 +1295,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> -	min_freq = amd_get_min_freq(cpudata);
> -	max_freq = amd_get_max_freq(cpudata);
> -	nominal_freq = amd_get_nominal_freq(cpudata);
> -	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> +	min_freq = READ_ONCE(cpudata->min_freq);
> +	max_freq = READ_ONCE(cpudata->max_freq);
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> +	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
>  	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
>  		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
>  				min_freq, max_freq);
> -- 
> 2.34.1
> 

