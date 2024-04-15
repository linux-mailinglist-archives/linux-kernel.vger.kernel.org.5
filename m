Return-Path: <linux-kernel+bounces-145391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB088A55A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3C91F22A68
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8FE74E11;
	Mon, 15 Apr 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wVjunqyh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF372119;
	Mon, 15 Apr 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192897; cv=fail; b=p1otL6KW3VYWgS5YyrUDIgq0EGIcJ0o8pg5uRit3yQeBoDfAS7oq5APEkyKScTQLpzOI2FVMRfMrrWCyzHNS3gwZOllyj7NS9OoLfFnYzjM80OUksG+EEe1OwskZBblVsQCZtjbWbuWoJnglZ2qF7YDneKuYIDHC4NObytjJ+mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192897; c=relaxed/simple;
	bh=dVar+QSsfN49OdLjaHhEAArikur3IkVbCFZqvSU2PG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RbIc2ZJoetoSescYSGxyAS46qzDHGWTcD/OWfc8iPjrBKbGteCKpTOGDK4WP2QXg7XbI3C98vXd62jC5RMglsFl6C96iMr4A7UN1ucE2xP+PkHkYSGE48Zf0aHpzrrCahSMTgYdZzZ6GTRjOrkgqyjAR4B4KTHSe0a/FWl0knEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wVjunqyh; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP7ZHaXSL8/88DbJ5bE7wOS09tKMmgBa66lIL/el8hmC+zrIayJoV/xSIu1f5biy2EEDsRKGxVjS/B/YQ+eyL3RfUOzoq/FeWo9rvs7dpjxYjKh4aoybPTRHldIo9cuoF4gAxe20tzVAnVVuHoR8oOvTtA6S/Xok6adshv3qJLdThtvqD0sfS6yRfMiKhufS+xxhUjBC7sOAbxDrlBqCzoLnLCECL69uMUJeQq6qRXfeRdC2vzTvcRl8EOgxlBU3R/lsRgSullB9nAnQxXgYPsAz0va+v2M7qxywyII6ycj2Mz+1WjaE9RxKmSGBFeRExFRcSvx8Pro+hQl5TGJ6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7Sudd9++beY1ljI6Spu9qW8lP4shS+awANE4m74SEU=;
 b=gTuDKWVS6CChGluCUf001DXI/ut0mme0CjtNBEOPx5a3kRbwcjzMaCGw+gWne5EaV9FLOP8syU4EwzE8DPmh1uh/Jgje41ZfT6xjuPfFN4kf9DQZNQ+TVia3a2pgcsiEakt2M3DH3YzVYhu+lsqwA9zVbHl7L5yGIO/Ab+VELz073homQjmU30BKBEc/CSbfPCIQvkZwB+4+yDPecpDDOzTgQhD0f3zGkTGzQHDVK3Jph/3pr7dqY7ZENGn6gTQ0U+/zkOgEicnPX9hFltJzCaaQilORvCvHmRnK2narFOoevm2sSmxp9TwpvLAYzXecr0zw2kFSr6G4iCR/L0/qOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7Sudd9++beY1ljI6Spu9qW8lP4shS+awANE4m74SEU=;
 b=wVjunqyhG2fqDQvr/uBrpBxGlhW3hYBgwe4J0R6oIyZ4OmJDLO/ebKsLb7mp0Ze1PPosgzVrYgFrBQm5ZhQ5WgJQrM6QW7+ymVX43hSsNFUYrauc4uoQWsgKsagXiEnqWIguGr1bj7ae0nmfupdeJoF7cBPrM190ysemIe45kl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:54:53 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 14:54:53 +0000
Date: Mon, 15 Apr 2024 22:54:31 +0800
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
Subject: Re: [PATCH v10 3/8] cpufreq: amd-pstate: Unify computation of
 {max,min,nominal,lowest_nonlinear}_freq
Message-ID: <Zh0/p4tzcqxQvnm7@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <31e4c97f791837c97c0b2caca61bcdfeabc3f97f.1711335714.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e4c97f791837c97c0b2caca61bcdfeabc3f97f.1711335714.git.perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ab021e-0a5c-424d-0e71-08dc5d5c01c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ssybqgJVT9HrEYtrepa4b3Ho9//YIebr/m+Mwc0Xu0w0l3aZ6ZzYZBT7Fniomd1LrZ/ciumlYa3en6VZFbKICDw9QcFadhk0tr0KI0EPrhi2iMzHTdpStaa3hvb9nHcVdOqQqpkH+uSPdST717MLZdfPZLNuwM34JqfVvwfXOmpZ4+J2w5NKPc5RJEFa4C7UeU5ByKUg4JbT5NHO63fBFKko3Qfe/qRKGkfJI00WJmwc1jdEPwv366Cm6ZyoIwQ5YY6WJ+CC9dxJEbBTXwePOyly4EbSEVjnzSWm2Erhn89/MAl2BfBTk4HFZtrMGxJvyNMaWV+6TzZzu3DpwyA4/CvbUm+85kxOnzp2cEXFdHxFG3fCLG0XAHk8pTiSV4rS441fNU/rU6DidSfv6Kl6r/ADD1t4Z/iZMZKmvMHYMiRXu+KcGh3D9oaWaVur4Zj7Ux/82FVvMVSC8vLRNGJhEChM9pcTfRLxiTJPpQqYNVKbEFzxclJzryu9fLbob77VW5I3kNyyBOLKl/trd3QoOsOEmLmpCYRkqK5Us81Es5H6FSEDtEP5T5yOwGGhXYoMcjhQ39ahalxnLfYYKXjWUjibp6rpvTf2jpbwDTJWtcIGZAGVQR81b0vSbeOrxxN6/X0h7pwfeylsknaGPEGNLuTsJg+uT6qPMc8tEkR3iDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+K1aYpwlTkf/b4lmzkvXCPc7KcDN6TAVCSvrKzvrc6Tbi987/VcNLxOE/WOj?=
 =?us-ascii?Q?nHv2BWZJOqOOzcEZcdpl+Ji5um2OCg7RNaRBTHUZIyNWP9OQQLYVdhPUiKLw?=
 =?us-ascii?Q?6uFiABjoQcpddxbxw6vIJbXkCZ//ZU8B8GAo6uxKxTiLjshRYpYG/t3GgJau?=
 =?us-ascii?Q?kLoYaFNipnYlUARUBT6WxtucWie+FAp8uJUCF1t5Zg5W3OupI4IvXTQjUIJu?=
 =?us-ascii?Q?Mt1nJGS0dsBdpMnkAei9mKa/e1pqkmGSpD8dZgwpO0f3NxNESBf42Plk5L90?=
 =?us-ascii?Q?9g9aQsxU2n6+lbAQAT175EUD+72ithtya5YRpNea6/NqwwgtDLYvRskvs7/O?=
 =?us-ascii?Q?1mGuzmG0JdI000GFyD3QcKZoJzpg+gOmoENqoTrPOqEO1wxOW0w8u69U1TMf?=
 =?us-ascii?Q?0u8hzMnxiDuUXAel7BSDmCrk6peWqEczhdhBRzyh7pm7EqeKvtD3D1q0NF5k?=
 =?us-ascii?Q?MemltgIJcrJE+3RLDXO+8CPQdKijqa+6Nc6njYcy7JP8ef6x2hOY0y97yor7?=
 =?us-ascii?Q?ga07M1DukLt5SdITsUlsWEyIPruofDOEvFZ0C754NLiTyCR52JoiBA+lCC1d?=
 =?us-ascii?Q?AOd/HaBgTjJ/h3cEFDYvWButNqeedkd5Vno1Kgoe8Lz5TbJzrsFklI2BcFO2?=
 =?us-ascii?Q?TMeu5svrLpwmA0CxNJCq+nWnhUTSV+O0Rde7H0+VEbnwAsBi9JZ6CNtZuv4D?=
 =?us-ascii?Q?tMf/J+MJ+GvL0HY/wngRBBhNqWXKommXQI4nt87Z6r7qpFosv+j/tpV3JlVx?=
 =?us-ascii?Q?6SoT0yALbJxLUqgYv6szucivcu1PDLDkdAuH/ph+mmB9BL52eVo1Rklaqx1A?=
 =?us-ascii?Q?JNzwCVGeBT2dAwZSh/5AHfx401w9IJiTOjV7FiwTVAAclwXa0//QLqQw7FNT?=
 =?us-ascii?Q?G3SUXuQ/7g37vcEOvukIxAQYLqchjX0Fp3A8SNJNGXS9HtW/WX8faHvumg3q?=
 =?us-ascii?Q?xEXSXCCoHeOVjtdn+Y4G6y6lEfmDbZn5LLyzzcMYojqc6MLvciIX9La0Cg1n?=
 =?us-ascii?Q?CbbLYR8wWZk9bq4wfZFF5vFPJJK3QE6TjoyeOBlH8w/qLszc7ys22AjN6RBb?=
 =?us-ascii?Q?M9Bf2XC6Wokp4xZNVtgsVE+Hc23uo6lb0IuBKUPcemUzLBXLPM9ellQZxove?=
 =?us-ascii?Q?vLN7tCLd/9Rvddsu+xuXYu64Z3kKQvR6SIfz4v/I/6qwOkGWlqpJZu6iilPI?=
 =?us-ascii?Q?hpN+zEJgiWuUk0f/NnqwLo1qX1t0jKNsc/Pxq6wZSk6nncNU15IMUuNwobAd?=
 =?us-ascii?Q?4PTvAo9YgrHQ9o6Bznocs+JJ5Jndw3OoxiZEaivUWJi+F8adMrjXkUPYunrF?=
 =?us-ascii?Q?9CNxsChVzD45zhOUyIEgROy0qmfIkUm3I7W3NfxcMo85D9EBVyMiYZVC4fig?=
 =?us-ascii?Q?PLfPoU6Ihr0Zrs4zgWO8JGZlW9ELP7BK5rLQYVsw8Nnc/M2kAmgfgOGx8OP8?=
 =?us-ascii?Q?CoXPDUUwXPdXLOH7aHnkuSkAAI/9kmwtIuV++UyuM2eStSwbJ6Nog96GNW5I?=
 =?us-ascii?Q?XrbNIS3r+74sTnMGMRmJrow14San5X2kGcnTq5H/e7cb90szMMWyox6OXccY?=
 =?us-ascii?Q?u3dF6yFNZq73vAwBXnF4SaQ8DrNdd4ZyvrzWkmIf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ab021e-0a5c-424d-0e71-08dc5d5c01c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:54:53.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axXNcV16psDXFgOs9IUNpcnw4DN1VYUxk+OukFTICnT2RyUgWppmKC/YTn6DQ2LJkBNw3QCepfetNuacuZf7jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143

On Mon, Mar 25, 2024 at 11:03:23AM +0800, Yuan, Perry wrote:
> Currently the amd_get_{min, max, nominal, lowest_nonlinear}_freq()
> helpers computes the values of min_freq, max_freq, nominal_freq and
> lowest_nominal_freq respectively afresh from
> cppc_get_perf_caps(). This is not necessary as there are fields in
> cpudata to cache these values.
> 
> To simplify this, add a single helper function named
> amd_pstate_init_freq() which computes all these frequencies at once, and
> caches it in cpudata.
> 
> Use the cached values everywhere else in the code.
> 
> Reviewed-by: Li Meng <li.meng@amd.com>
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Co-developed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

I am thinking patch 3 and 4 should be squeezed together, because they are
all refining frequencies in cpudata. But I am fine if you want to continue
keep them separately.

> ---
>  drivers/cpufreq/amd-pstate.c | 126 ++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2015c9fcc3c9..ba1baa6733e6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -606,74 +606,22 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)
>  {
> -	struct cppc_perf_caps cppc_perf;
> -
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -	if (ret)
> -		return ret;
> -
> -	/* Switch to khz */
> -	return cppc_perf.lowest_freq * 1000;
> +	return READ_ONCE(cpudata->min_freq);
>  }
>  
>  static int amd_get_max_freq(struct amd_cpudata *cpudata)
>  {
> -	struct cppc_perf_caps cppc_perf;
> -	u32 max_perf, max_freq, nominal_freq, nominal_perf;
> -	u64 boost_ratio;
> -
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -	if (ret)
> -		return ret;
> -
> -	nominal_freq = cppc_perf.nominal_freq;
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -	max_perf = READ_ONCE(cpudata->highest_perf);
> -
> -	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
> -			      nominal_perf);
> -
> -	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> -
> -	/* Switch to khz */
> -	return max_freq * 1000;
> +	return READ_ONCE(cpudata->max_freq);
>  }
>  
>  static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>  {
> -	struct cppc_perf_caps cppc_perf;
> -
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -	if (ret)
> -		return ret;
> -
> -	/* Switch to khz */
> -	return cppc_perf.nominal_freq * 1000;
> +	return READ_ONCE(cpudata->nominal_freq);
>  }
>  
>  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>  {
> -	struct cppc_perf_caps cppc_perf;
> -	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
> -	    nominal_freq, nominal_perf;
> -	u64 lowest_nonlinear_ratio;
> -
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -	if (ret)
> -		return ret;
> -
> -	nominal_freq = cppc_perf.nominal_freq;
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -
> -	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> -
> -	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
> -					 nominal_perf);
> -
> -	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
> -
> -	/* Switch to khz */
> -	return lowest_nonlinear_freq * 1000;
> +	return READ_ONCE(cpudata->lowest_nonlinear_freq);
>  }
>  
>  static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
> @@ -828,6 +776,53 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  	mutex_unlock(&amd_pstate_driver_lock);
>  }
>  
> +/**
> + * amd_pstate_init_freq: Initialize the max_freq, min_freq,
> + *                       nominal_freq and lowest_nonlinear_freq for
> + *                       the @cpudata object.
> + *
> + *  Requires: highest_perf, lowest_perf, nominal_perf and
> + *            lowest_nonlinear_perf members of @cpudata to be
> + *            initialized.
> + *
> + *  Returns 0 on success, non-zero value on failure.
> + */
> +static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
> +{
> +	int ret;
> +	u32 min_freq;
> +	u32 highest_perf, max_freq;
> +	u32 nominal_perf, nominal_freq;
> +	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> +	u32 boost_ratio, lowest_nonlinear_ratio;
> +	struct cppc_perf_caps cppc_perf;
> +
> +
> +	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +	if (ret)
> +		return ret;
> +
> +	min_freq = cppc_perf.lowest_freq * 1000;
> +	nominal_freq = cppc_perf.nominal_freq * 1000;
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	boost_ratio = div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> +	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> +
> +	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
> +					 nominal_perf);
> +	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
> +
> +	WRITE_ONCE(cpudata->min_freq, min_freq);
> +	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> +	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
> +	WRITE_ONCE(cpudata->max_freq, max_freq);
> +
> +	return 0;
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -855,6 +850,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	ret = amd_pstate_init_freq(cpudata);
> +	if (ret)
> +		goto free_cpudata1;
> +
>  	min_freq = amd_get_min_freq(cpudata);
>  	max_freq = amd_get_max_freq(cpudata);
>  	nominal_freq = amd_get_nominal_freq(cpudata);
> @@ -896,13 +895,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  		goto free_cpudata2;
>  	}
>  
> -	/* Initial processor data capability frequencies */
> -	cpudata->max_freq = max_freq;
> -	cpudata->min_freq = min_freq;
>  	cpudata->max_limit_freq = max_freq;
>  	cpudata->min_limit_freq = min_freq;
> -	cpudata->nominal_freq = nominal_freq;
> -	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
>  
>  	policy->driver_data = cpudata;
>  
> @@ -1317,6 +1311,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	ret = amd_pstate_init_freq(cpudata);
> +	if (ret)
> +		goto free_cpudata1;
> +
>  	min_freq = amd_get_min_freq(cpudata);
>  	max_freq = amd_get_max_freq(cpudata);
>  	nominal_freq = amd_get_nominal_freq(cpudata);
> @@ -1333,12 +1331,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> -	/* Initial processor data capability frequencies */
> -	cpudata->max_freq = max_freq;
> -	cpudata->min_freq = min_freq;
> -	cpudata->nominal_freq = nominal_freq;
> -	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
> -
>  	policy->driver_data = cpudata;
>  
>  	cpudata->epp_cached = amd_pstate_get_epp(cpudata, 0);
> -- 
> 2.34.1
> 

