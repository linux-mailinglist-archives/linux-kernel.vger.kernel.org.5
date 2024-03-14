Return-Path: <linux-kernel+bounces-103068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D19D87BA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685CBB215D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1222D6CDD9;
	Thu, 14 Mar 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O4SCz3kd"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C873692FC;
	Thu, 14 Mar 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409309; cv=fail; b=Nx59B47ZsmTNpZ7DPznKyLj+lZNWuZ0x7I8ZAzWOyaYkBoF0KvJEpxqeDkiqYPsy99tJz2Owhjkog/j/sNcPklS4QU9bEJRKJLc5uFzzOBxsgsbRDAlFTZa/umM+IFXRm6prCgTit3mMqi2O5+fCffTjq4GAYgOJK6mHlKtA46Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409309; c=relaxed/simple;
	bh=fVMSipYC/vXOuMtL/5eenpIFscWo7iHQNbQFvaJaGag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lumrfsqjGK9RVU3hHtsdYr/xQrG7tQ8DTWhmY41A3ttC1DSLPHfoAlgpUoWklPe1sCLR0i/nibxC5sVLAL4fcvnPrHXlDwSetn6J8sPvAIGb6R0NHUnKwAVljtJscee78hwSdh5J7YNIcVbDyazMbjPO8AsqdmPhDAVN8IgxhxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O4SCz3kd; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcMmfgxUccrRWmtZSQPZtgeYHH2TPL3zVI3/ldvSFMqP5+i9xML/GNZ+KMhWr1sPmAuoOBKAKHi+zXwfrHnn22BHfmErR1rXsGBuzdZAyrKUDXcq5EjfL6Z3tEAtk/QvnC1yFDRP884QuetCH7V8BCoN3I/+YXVluHsAdOM0+JjJcY3Qli8c1lbvhd2XRG8Lhmt05qz0cyzTLaEz3fKviK3F+sLPXGlcc/6olIkPMhS4wNtTxWAJtf6hIkU17QpDgS7hLGSt21W2b0du4IWYkr73UVcxnjwV4JvYC3qi4hOsdJ9jXEOn39lYnN0JJOuulL7KBnhOXHIlXlqiQIogeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k73cJvgTsD+0vqaU0g2Id0CcEYjI8uDLebzpfgJWiqY=;
 b=T4M7bgHb9BrZWUcv2ST/pw9mZR1czEYJlluPUaWsyDwIxXC8pJJdVhFVMpZ917LXsnVfJvI5phh+ONYxXYoKNZRGGtzEQbOafD3NOn2QCr1d7F/BEViAP27cjFOcrrsanN8oyPhS1u/uIDx+2fuMjjKxUXovUMLh+QwHEkaYrUs9ugy8Cz2NaSHyVw15cjXckOxosSbpp2cwPGJn7zpEEI2i5suSo8nsF85hQMVdpLbZb+wnXuv3YS0plxciROeYMYolwsuGAnmbG0G/cL/DMSwCnJE84eN001e+oGuVm+u9CQ86WF9peztKsVOHPrvbsle0I/VymWc6gUvl9r6Dtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k73cJvgTsD+0vqaU0g2Id0CcEYjI8uDLebzpfgJWiqY=;
 b=O4SCz3kdfVwSG8Zv1hvhmy6YHZC0Fs9CnsOtKTd7zoLMo6fT5p3fYnlU/VncBeTNOdSXaxA74RtCuAA7cSGs7PuIZZelk9tM0d7vGKN4gOMploGoM4KBo/3UYPBld0SnHMbXJj2O2e4OIB1oHrrI448hnQ0OC+XfOprspFZzCBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 09:41:44 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 09:41:44 +0000
Date: Thu, 14 Mar 2024 15:11:36 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Message-ID: <ZfLGUHRBV+1ICzp4@BLR-5CG11610CF.amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
 <42a36c7f788e0fb77d4be7575aab9c937e1773de.1710322310.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a36c7f788e0fb77d4be7575aab9c937e1773de.1710322310.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 74403207-8e02-4c97-b0e1-08dc440af57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Y2MSG0LSisbyz8rAd4NKDX+gLkK+tdQyHrSCwMdiGVfUYn98aTAB0QBGsFJJrAH2gy04CzEvbdzoCdOu2QW7DhPppeoenTUaM9Vhf6NPxdYTYbpJ8yumNga37JJimz8PP8xe3A9xCUuBa5q7CmTdP9Z7Doqi3XANjn5DqFEEaRXlQYgJSLTbPJl4khZb7vJ3kYFlmHESWb7CzxRkP+bHXfef1+yVB0EQVHbKJvD50t76NoJRjvePTEhK1UnHvE4wRgk88zM7myadGbEZ4IRZTqvtH2WH0DjbgGr7JVV+eQzkKZDt4vV0mDkQ7CNLJzKRDgJmx8xXr23Lhj0oxDJ16ulPBVFsiJy08ipv8t69Np6qLcfZKU2zGqf5r7mT5jEvVVtHV3UtnzWtWtFyK0DXyvqlZWxKS4MzSMyBc7NxsvBz8wAHHXKLNK5cO4AitQSefK27BcHCivc3rljriBRF17VKR3u4wGZSvWomdh69SOWIepVjEZpCQI/crn7DnMF8+EbrTg720IJQGCvQ9O6kb3s8cADB3lJt9i35wnVPEnFuNVvykXeS4HVebzM+mFO0ORphCo3LRbJ235n7r83zQt+Haid0LM/Ja4T8ceQzamd+ElfFMrlxXsPrEZE0Btg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ncJQqcvzDCC8RVqmFabxd5rxOsTPj9eMTUySyMltYjXNEsjJe9Eh0Owt4np?=
 =?us-ascii?Q?QuJqu46Lj6C8Kt5UbK6N2ScJMVwn1azdXQthqPM1n8o004Giw70Iqj2bSZnr?=
 =?us-ascii?Q?xD7evTzXF9YtPYyEAC1L3DbmjRUzwtGJe/vPJvC+Xu35t8lxckZwxTsDZ/cp?=
 =?us-ascii?Q?D76dhOxc2o9juEqugbblmbBpRh/Pa/ElDKufgvGeUouhLbg1RQINXWFHFiv9?=
 =?us-ascii?Q?ncIQPB/Xjo6sqbyryXU7Ff7YM8+xlERIralz1GTvRqG0K5iu7s8aEzqBayNK?=
 =?us-ascii?Q?ThzRYjZdykeaW5Binzd0umjAhM4vuiYkZYOZNkkMYbNkxYItfVe/z+49Nc+Q?=
 =?us-ascii?Q?qphTZV7EG1SpdPT3iBHsaLSAWeGKh949MSvET0TB0/AhlkeEUZsWLFLnoXEM?=
 =?us-ascii?Q?FEztMyRRLPfc0lHSOt6BijDl6diQmUzf0/rzWgkPEnc2Bui3X+soBQifRAHF?=
 =?us-ascii?Q?6tF1Ncx7Nhuq5DeRd8ezVlKyGr8t/TkwwZQ7KdwHy83aeKKor+z2KGRpjMSL?=
 =?us-ascii?Q?O1zlCJiQeqjLKDY4VC+suSDEx4UcLH4YiSLay7AkWrzx73GqMxYyB9nwmLOy?=
 =?us-ascii?Q?yn7xkW5dhxlzxu/8rmsnHj98cvkwlDc/tMu7F2yfkoG+D06wVAIkBucxz1GO?=
 =?us-ascii?Q?EHmQDPGURu2MZsPmKm3QIMa/ZvGyPxSGjQwZxMDd3E5wQxl5yP77T6DIUZ3c?=
 =?us-ascii?Q?9P5kvafOHUbMYy1La/oYsrDbQum411J60p2iiv8JQKDT/q07QSzp2CU0B15V?=
 =?us-ascii?Q?KpyrZb+lt5uyxI3taQYoWArZk6c5Skgacq4SCB3lHm8KnDyzlpL8KzHJZHhg?=
 =?us-ascii?Q?sf7LELCX0F4TyQWvGQX9c9wzG2WIET0qJ/lSmRQ/ONN+K59MvmeJCX/+2BV2?=
 =?us-ascii?Q?khk8pwRGiFRyhCgnow8CxdQB09tLKC4jqQ/fd17JJx4xdOfvA994E91sxS/U?=
 =?us-ascii?Q?WnVfK2QZiTny5kZW39p1ZJrlD0pKmcSorkgpNU3ZIh6qKigqfZiWcA9CSAa0?=
 =?us-ascii?Q?wrd3DHwwjHONdjxUbxVT+H9io8JFOv8XUjoaz71DNX/xz1WJSTHIsRe+Iq1W?=
 =?us-ascii?Q?p5e8Fmucsu/tlGtTGD/AIPuwYIMKN/Nb4tQHqdGJkcFONNeeMp6y2bHFwiIq?=
 =?us-ascii?Q?ajZmwymqH4LaVF6Lwh9+6Zm8UVKksPNoa/wS0WM0ymRWG0Tevm2Z+Wg3qjGd?=
 =?us-ascii?Q?fPoOA496mGCjd93JeXnNGYaVGZAVSi1h/dOfs+wjHupbDE5CgWQG0+zto8VG?=
 =?us-ascii?Q?YY2jdwmJww2pOCaVVsxuoMfr1ncRxB0Sk/SPAbs6deSq6lhQ1NtL7Q4irsax?=
 =?us-ascii?Q?NmFl7r1t5OOp4lRg01ccbczCRAvwkX7v/S7AYwDTVibD4PcBsAZ+JXmQ7Qmb?=
 =?us-ascii?Q?wQYalLuHhisWRwDhq///QpxCgzV0xMmo5YBwBC2I+20q4sEMCgDODom4mmQb?=
 =?us-ascii?Q?CIXthndnIjJDHjuCSGLDt+0GIjdIeYvBCS+6l4ACZqG0J+wM2J59n7bVEWi5?=
 =?us-ascii?Q?aeW1GE8vYkUltI3fzMTX+TvqQnJIO7tNaC9ZOtABfzQHzKqCibPRTdEkUvaR?=
 =?us-ascii?Q?86d65p8eprx7GrI7uDKNErrVDdZ+1Oj5BPrzbshW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74403207-8e02-4c97-b0e1-08dc440af57e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 09:41:44.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxzJk00Ti2IGxGApKPnYmoSF4ChnQv7fSJD8bUVF3znYul56WLBderOYPXtNtniESPUCATMfN9eXPD4Z+vAllw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162

Hello Perry,


On Wed, Mar 13, 2024 at 06:04:39PM +0800, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> With this new sysfs entry `cpb_boost`created, user can change CPU boost
> state dynamically under `active`, `guided` and `passive` modes.
> And the highest perf and frequency will also be updated as the boost
> state changing.
> 
> 0): check current boost state
> cat /sys/devices/system/cpu/amd_pstate/cpb_boost

Could you please elaborate on the need for this new interface when
/sys/devices/system/cpu/cpufreq/boost exists and is being used in the
other cpufreq driver namely the acpi-cpufreq driver ?

The semantics of this new interface seems to be identical to the
existing boost interface.

I am ok with the rest of the patch, but please explain the need for a
new interface.

--
Thanks and Regards
gautham.

> 
> 1): disable CPU boost
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> 2): enable CPU boost
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 97 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ef6381b48e76..d54399ebb758 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1208,6 +1208,101 @@ static ssize_t prefcore_show(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>  }
>  
> +static int amd_cpu_boost_update(struct amd_cpudata *cpudata, u32 on)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u32 highest_perf, nominal_perf;
> +	int ret;
> +
> +	if (!policy)
> +		return -ENODATA;
> +
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(7, 0);
> +		value |= on ? highest_perf : nominal_perf;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +
> +	} else {
> +		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (on)
> +		policy->cpuinfo.max_freq = cpudata->max_freq;
> +	else
> +		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
> +
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (cppc_state == AMD_PSTATE_PASSIVE) {
> +		ret = freq_qos_update_request(&cpudata->req[1],
> +				      policy->cpuinfo.max_freq);
> +	}
> +
> +	cpufreq_cpu_release(policy);
> +
> +	return ret;
> +}
> +
> +static ssize_t cpb_boost_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
> +}
> +
> +static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	bool new_state;
> +	ssize_t ret;
> +	int cpu;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	if (!amd_pstate_global_params.cpb_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return -EINVAL;
> +
> +	amd_pstate_global_params.cpb_boost = !!new_state;
> +
> +	for_each_online_cpu(cpu) {
> +
> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +		struct amd_cpudata *cpudata = policy->driver_data;
> +
> +		if (!cpudata) {
> +			pr_err("cpudata is NULL\n");
> +			ret = -ENODATA;
> +			cpufreq_cpu_put(policy);
> +			goto err_exit;
> +		}
> +
> +		amd_cpu_boost_update(cpudata, amd_pstate_global_params.cpb_boost);
> +		refresh_frequency_limits(policy);
> +		cpufreq_cpu_put(policy);
> +	}
> +
> +err_exit:
> +	mutex_unlock(&amd_pstate_driver_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -1218,6 +1313,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  static DEVICE_ATTR_RW(status);
>  static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RW(cpb_boost);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -1242,6 +1338,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
>  	&dev_attr_prefcore.attr,
> +	&dev_attr_cpb_boost.attr,
>  	NULL
>  };
>  
> -- 
> 2.34.1
> 

