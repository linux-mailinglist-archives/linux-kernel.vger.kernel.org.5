Return-Path: <linux-kernel+bounces-102871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C1887B7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD996B22104
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD90FDDD9;
	Thu, 14 Mar 2024 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nKsiSAoI"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187AA14A81;
	Thu, 14 Mar 2024 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397437; cv=fail; b=NPLYbB9rNpQ65jO+RSJ2EyxCjrOAXgXMh5i7UcrWe4D8GvTZhP5Ks91bNgh2WydHubz/q7S9ou0DADoG1yZuyFNXBLGHcT8h3RBpqvGMtIRpc06RFNnhjOQvKsIA27PkkCUIpWoSyZFN7x9pZIehHnoKx0NAFYHKfTNQQ0mAIic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397437; c=relaxed/simple;
	bh=PAy5/G/CNiZLlyMocqAlJIEEukbenqrgJVZwnjXzZ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tciIizVZV3azHnpFa2Btx7/Bbcw55DeYZcITOQKgyuUJhZyokDOwr6cmAhjpJ9NREVVG3VkQPsiLv3DvDNJVhzmKGpmLrEMu55XaqlD3hjXGEGvOQwGMdNgGUCMcxxk86W1m+SbYnU2NT/6DNHHyFSJDZobqK1tXiEjVa04kEqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nKsiSAoI; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wca4K4fSKt6HKVbh5m7uwhId7nhjCBFqUQSSmqjZQ3IvJLPO8EHG7rlJJVJR/q8P8FgxEpc57+x+cqmAl7cjHT3nh62xj+rAG8TP6mnKuSzthRHt7a/uja2V/RP9TlkNYJvLxlwiSm+abVNjvM23Rrkrz11KIoOwVeIIMBx7tFNNHgHKgHfj/1rO7JRAB5+DE3vYX5Bi99Tscsjgrins3cmp00P0Asoyjj3NoCXyJ5BrsiOjNuNJ1fUXrUu4V26WqUQ/jBaHtAyLfRj9no03x0rVXef0OaroR6jJdUvhO8ZUUBk9EEJPRgSUmspZVfJED2aRcV1rcs46Ve3UsSRfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WKIusEttMuzJI/r+mAPucvxwTg1ESEnbm4B/tuh7AA=;
 b=e4e6Z+BvTQa02Mh6+LVyId0uN4SGoa9AodT+97PB1JgOGtonLYKQYezyQn839LCxB4dYnxLjSpdvFSDDrf25rc8HISrds7635eDrM63RbWF54pouT7P1EtO8ie1RSdcauaBTbLvjXObdDOklLetPQHk1vPdSHdyJ5WZnx2iqZ729cIjfhm9u8/xbcbDyVFb2yqYvcYQMh5b2+m/K0HTUR0+vYOwbFlBe2muczIhsmjlPjhTzgm0pwOHO0FJzyFaIBnyD0OYQ8XVCuuo8spWUEP2yHnFwtwAWv9LKno2gTO1aOayzTHoHSIyMKdyXOnCctg1p7VwQYLjHlOvaW+c1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WKIusEttMuzJI/r+mAPucvxwTg1ESEnbm4B/tuh7AA=;
 b=nKsiSAoIV6vZIAcwhZR66IzReNxON8IOVavOWmwrk95GgF4ufw+FMLhe9CTv4LmOOGSkElGIp85a8vpmjJGN3lqhV07JQX9H692f7ZoXzSuFqNwTntYOD/HXcPhP84U5FyEZNS+d1gsiPhFBjdV0I2VuOVbKEiqHPqApAeYxk/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 06:23:53 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 06:23:53 +0000
Date: Thu, 14 Mar 2024 11:53:45 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] cpufreq:amd-pstate: get pstate transition delay
 and latency value from ACPI tables
Message-ID: <ZfKX8QbKuJBAdJs/@BLR-5CG11610CF.amd.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
 <705e1a21a6a9d91a7ac67526c55c2961318ad678.1710323410.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705e1a21a6a9d91a7ac67526c55c2961318ad678.1710323410.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN3PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 2965a2ca-aefb-4911-c572-08dc43ef520e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p9OwRYt1vvyxJePcY2A+tlwYQ1qN5RLnO+jaqscvBxPnMPDjzo7hFB1gxDoMo4DM+zumLfBqgJN4jdK93LLw/zLoxv0OsZU8JoTGkdwAxkHP71bk637jarBxuZAbs5UJW8K7u6QvWKqW21nHIZRBKZYRazft43jonZBYCzeiS1HEyyTEQQjg1B+fVQ8n4rT0R/1qs5upRqHMqNHZNitqIEcYQJm1sOu8Uk1QQ2u0P7PStw51fnAIZn1w4HJ1Ttllfu1GM+SdjtojRUhra2WPkfPxXnlyf4C6zL0niML3hAtsQ5qP5lhHhQxa9B2AzeNmp6lkNM/1xTYzQ0WpZ6t8O2iTFXsed6sde69dXTvfjOPl+4REvBaoDYcV3xPBqvO0gb3kb8P6T29iwpEZ9ONRX4EFkMoY/Uw0E2+pBUZaNOCzy7SFYJUME8OZC56X15m1uJ8eThtWnTpr7smmTs+4lgvBbFFiWRbFQ0psqnJZTP+jXcQUytXi3FXx7GHE581/+TjVMKWl8q9F1LY1sxxdzDiYbJ6+1Rb3ines4pr34QpqQGxCe3mLVai1PErRZgNJA6JiVslrBp5Kv6jz0W7tpb6Zv7l47mcGUsTLft8emnfd5AEmKOmvXaBFyeLFqAG12jupx0I0t2No5VALNQ8nyhGK0j+lKvfi/qScV1gyfKo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0R5z0bqREyVWVXveCqWHr7BDsgl4OeN2UsOUWtOKAkcN5uxM89AjDGS1CHhl?=
 =?us-ascii?Q?LZdCMRanWCEZqUdV3CmOqkZPBwKBeJcOKuhyYuUlgIIk016G6WtO9i0dfCKW?=
 =?us-ascii?Q?2xDzCb9V+XUye2NyuUk0+m90HDYcBDPGbsBvEhh43PBD/qvSmRZybWWxKxzl?=
 =?us-ascii?Q?Eds2NzSghGPC8Y072pDO81eh/8i2sTkV1/IcxqLEzqsu8kwQxwTdze9DO2MI?=
 =?us-ascii?Q?wUY+cZWAFJUQSi7d921wyTNhGDHe9kOlwCQ/fwev/yPqaaKoGahfrpIDUX4V?=
 =?us-ascii?Q?Om7an43VmnP8MfSQnV8F2CHJ0pxOyFA1BEOlL1hkjTDjPKEF8WkP0cNoB7C1?=
 =?us-ascii?Q?8IsJqrkzk9Oxem1Kl6+egq1KxxVD/bF/ZvbANl2TZbbCzAoSwosH9KR2MrXy?=
 =?us-ascii?Q?9MaIZQ34vO9MazLCM7l1X8JiFmFUnqy7zpVxhOLXrsXhQZLGBLuV2TA4SW+N?=
 =?us-ascii?Q?txFNgI4alUIx/WQtHDj18BYOO0oE6OOe1G93mDyUxtHSLOKedT7mfbKknDuh?=
 =?us-ascii?Q?5rAfpLPqtdSS7L6eoDb+yD4n/4pCGpbW78iEX9gLxfKiSSR2Fh9uwfy4MEgp?=
 =?us-ascii?Q?aMWx9JwafINZdShnMccxix2rOuyaw5RSmAzQVokp7wpW8VV9rsulWgVNwu/6?=
 =?us-ascii?Q?3bTL563RXnyNy/mzzIVx9RTuJBMkumOQO4TZagUvcI0VYYKZQaWeGn8v4263?=
 =?us-ascii?Q?otoobCHa+iAhgcs1pbTBn/R3ovdPeXZf7O+Hlv6dn4srEP419YWl74O3MM0a?=
 =?us-ascii?Q?9H3xJeCGX1SrZ2Fto1IvjNZaQtmhl6p/xosx3nF5tmOkqmF5OnhJyICfvtTY?=
 =?us-ascii?Q?FDUUXZ4cff1C0XPS/+Au3aCc5V8yHE1uO9dmjNw4TOW7uwD2Egttd+nFwqoo?=
 =?us-ascii?Q?BC4ga3zP9EhU3/otLHWWU16hkFOiw94bNhXN9mcLVNo1OlUQ52mk5/3gj3ZV?=
 =?us-ascii?Q?Ji29nwE2WsdM6yaPo8Uwx4AA1/BmmoclmTz+msNQiXmB9rd4Diz1bJiNhcxu?=
 =?us-ascii?Q?WtlIjorHH3aRYQcjtfWBzIj0rv7ZTCDiqocqXiP9JSWrwvUjhXSY87mxsneg?=
 =?us-ascii?Q?6WHQAUK0gK2RwhDv2kqCGWuUUmEb/obHFR1axTaW/4X9iLWfmSAqJE0JvzpU?=
 =?us-ascii?Q?8cQCk43MA6fdDSTDc7Dj5t08JDpPIE1gLx8yKwraU1DzxbrXPeC4dj7ecz/g?=
 =?us-ascii?Q?hNTerbgcRS4rn7Oi2wVmAvdjsS/rN0ZlV1haA/gXp6AzNFy/VsVzzVTrVvrN?=
 =?us-ascii?Q?QDBw1bLHgsx/ODTk3ewxWbctpxK5MjAiEAj5sfQhCXxxJtPrfOKlRQn45TNh?=
 =?us-ascii?Q?WY7M6o2YPPM6K32QNbNP580vh5FIBYnPcklhjpFNYCCzM02nd6v4mky+R4EV?=
 =?us-ascii?Q?yXg8l65NXz6e3LZMaEavdEwyuVFMzBskqUfIXNdXhhOOmhW1e+aeH0xc6Gsg?=
 =?us-ascii?Q?9YAddIuxVwxI/Ec3kjTKjazF22XLCkbdbYwLdZuD02bHygLKykdmzD1y057g?=
 =?us-ascii?Q?ZmYo1bjU5OUTfLrs2D/WkLATScveNuzT7M91VdqZeZerU0Ef627oQnMxOMja?=
 =?us-ascii?Q?WvzocXZOYpyfn/AZ0zUPJHOR2LEFpKHFLDCDftn4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2965a2ca-aefb-4911-c572-08dc43ef520e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:23:53.6347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMGCMsseNoCUOskxd/QHVIEQoI1Q8NNc4E3vFbzE2MQS+WyAQfgh2kQ3f/0PI9ZnffiHC1J0LxNyoSUxfMhE5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685


On Wed, Mar 13, 2024 at 05:59:15PM +0800, Perry Yuan wrote:
> make pstate driver initially retrieve the P-state transition delay and latency
> values from the BIOS ACPI tables which has more reasonable delay and latency
> values according to the platform design and requirements.
> 
> Previously there values were hardcoded at specific value which may
> have conflicted with platform and it might not reflect the most accurate or
> optimized setting for the processor.
> 
> [054h 0084   8]                Preserve Mask : FFFFFFFF00000000
> [05Ch 0092   8]                   Write Mask : 0000000000000001
> [064h 0100   4]              Command Latency : 00000FA0
> [068h 0104   4]          Maximum Access Rate : 0000EA60
> [06Ch 0108   2]      Minimum Turnaround Time : 0000
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6db9256f42c0..ec6259957d25 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -827,6 +827,36 @@ static void amd_pstate_update_limits(unsigned int cpu)
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
> + * Get pstate transition latency value from ACPI tables that firmware set
> + * instead of using hardcode value directly.
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
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -867,8 +897,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
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

