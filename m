Return-Path: <linux-kernel+bounces-40302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74A983DE0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1960A1F241D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202001D540;
	Fri, 26 Jan 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hYCuYK+R"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874791CF99;
	Fri, 26 Jan 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284381; cv=fail; b=WMd2F+rFck2fQ9D3sIa2YHzZfxwq+OHyOFVHd3Inz/xdjg1uKsgRxZ2+IAkq/6Le1AKssguQWA+hiVN8mDAphm2RIXOJk5js4EnAuivTVpcc70YifDVtdf5Dg9tOOMbvjrkhlpEDjYznozNyom+7v5b0WGuVNLIHORQREycsMNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284381; c=relaxed/simple;
	bh=PorPZ/9RIEZeFmc8JAwc349Hu2936Hc4unyZnYOWRFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S8DJorbUw8R0nZgsVFUnN3O65vCMWjNQucI/F2pdeilhEqHqb1eby81Q6k9dqeacaaKYwDMNkLG7dYLL6loPl42T1wage0l6IJaTNi39Hp8xCBajjhRCgptu9p1JKmG82vzTRhr+fLFPR16FaAMcdRSV5lAVDAIldYousNO6+lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hYCuYK+R; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjedgdvWsN5t1H4/kU0LT55c1pJxx3nL2yEZSWoM0ALWVl5ZMXpe9G4PYryz1oDoVjHJ4z3JmT6s37pMTQUY5vfVvmPIdkOCKABb7+PiywwvtNjvsts4EYrLKKxpg5BKOKEHhUI9SmQ4FolhJR9zN0SzBZrJJB6loZaENkMjXyni8VKwjwLwN4EgmPEjnm/JKbmKZzsoJk1FhjSfEOzpzhvukwfmyxTuHQWME9YVC1B5ph97GKjeT5jfF7TFK7uV7VsNv3g51v9i+FWMquEFwKT/kLnzz83JQC9+/vZF4rCyX3uZBVsv81MH7SxpqUUhwtwjiCiZk9eHkphGmV4i+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWVtQF8DJEjrj8mW3qPHuYkHMSSLnEoE1cR046Hd67o=;
 b=PDC0gwiAheFYVtLoDE6UY/A5HG+a1NdwTg2hN9uzjrzbGTVN8stKDpZdtgt07akpJl/kIzIPdKAcQwOhf4dXutj1CniEgx7dLU6Xw9zT7QNpSll00E2mIcDcE/Exx2XfyhLNz97Xjdx1sErUYF5Jmq2Hh/1V6GVoUbFnBjCY8b4Rujkanf9e4rSseeGh7RLvQNjMZV0mzwlxijrEqkwmHiXeww0HCmv2CD8BejcAMpAOu83Ba+I/DAa69xmfY/6Pzq1i9oxfvaRzP4UpNoDvrJILrDUXRBBRaIPiPMMzT3iMNd4mUBudWhSUZQ13thGbtOSRsfzYqN9qIajr+33JwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWVtQF8DJEjrj8mW3qPHuYkHMSSLnEoE1cR046Hd67o=;
 b=hYCuYK+RjtT54pT84kRxiNmV6T2kknvF4TyfwxOmL6nDCwiagmfDwkiAhbsvRgLYhgzpCpjBYIEnLqU/ezSltAqAbjbQlAOmf9Out4ug3p3Fcz0BWNtvxsNEOp9zMEB+wdnX/HwM/44hneEnCSaviIsf8iv5dpLcXKbLBKRTgJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 15:52:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:52:55 +0000
Message-ID: <580bc2a0-8621-4147-a7dd-0cc0bd54f9fa@amd.com>
Date: Fri, 26 Jan 2024 09:52:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] cpufreq:amd-pstate: add suspend and resume callback
 for passive mode
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706255676.git.perry.yuan@amd.com>
 <fa430f6288744c760145f4acab952c2bd0f947ad.1706255676.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <fa430f6288744c760145f4acab952c2bd0f947ad.1706255676.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 6994be3b-46de-4440-a7d1-08dc1e86dc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NMcf1yXxjmSUE9lcTHNa/u3WgK3KUh/5l/TAmizPUAI6vZInPEideZB+hwnqFm/GaDMMkETZwd2aknNviova6rxi/2cayAEUqTTjX0pwfvEc7suLm+QjJvcLOqyb23x+jariVPBwcQsymEgAXYqSxG2TsARQXSVq2xBoV/D3hzf9hdttlN2GgGg9H4qDkI5G261Emg4IG1ngD7gjWvAMwVGVDxzaEvKLM17+79FHskTg4Cl8LW86aYKVYXyWLqO40WqMttN/zEyLGxHHxPt/W/Jnirnlx4ppZlopwBB3gUxugluyU4QlimGYQX22cKPg39oyth+O5UF2wnFer1ZQOGjan8nb/8Z6w8M+EQ+cADgVaQV0OUJaEA/+JxR2eCW4N0jHbNWD2aJZ5vKFeyUmef8yQ2eYSPDpz9RBaOwCOXxVPfnf89/uPdszrDuEcUTbVrzsyqVopqSom3V28Su0ZWoPiVCJdSJHfUb0H/meonUMA6B/k1MHSWo/VGdFDoBMnChQ71VvoUeV0ilceEM9dtY/fJ5UHQk4aqNnKMy8kegWbMtpInEZWTvol6YRPEXFLZct326C3TQW5SRa75C/A+ruVNB7xQimGfcm5vyaoh3iyrseXaMdjRQrRctocD4GOVtUYrTj2UxQXw5w66LRbQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31696002)(66476007)(38100700002)(66556008)(36756003)(66946007)(15650500001)(316002)(6636002)(86362001)(44832011)(53546011)(6506007)(83380400001)(2906002)(31686004)(5660300002)(8936002)(8676002)(4326008)(478600001)(6486002)(6666004)(26005)(41300700001)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3k1VGZHaEpNUGxYQzM3d01XdStPTldGSG1VTHZSVzZhVkdkczk1Mmc4ci84?=
 =?utf-8?B?UUMyaEFpMG05THpVamluM3F3dmVGU2hIKzBBWW5Ea1U4NExaUkRVaDl1Zmp4?=
 =?utf-8?B?U25jazhaTnFqWGdKa0NGNHNPWU1QN0NPaWh2eWhzVXZjZDlTL1EwN3dUZTBD?=
 =?utf-8?B?dEpDd09HSENsaWRoemg0cTgrWHFLbTVSako0RlRla1hNVGt4WmcrZ3Q2TURP?=
 =?utf-8?B?SjZqeUhZU3M5VGUva1Q3NWlBZGdGbzE3L3dvVG0vR2ZlYXNVMlBWb0p5NEdT?=
 =?utf-8?B?cG1KczRIZ2lVVkNMaTZ1SFdzeVA1V01GeHIyNERZcnpyTW13UkFiK2NnUW0r?=
 =?utf-8?B?b0RLZ2VPSklrdSs4MWk1R3AwQVdVOFB3MmROd0NSemhmUmliVEwxKzhZU1Br?=
 =?utf-8?B?ZnFDZmZ1TFlvbFg3M0JIYXhKalIzdE56REVmbm9DTjhCUWE5YitLV1lkYUI5?=
 =?utf-8?B?eG5FTTdvbENJbWZ2c0NGOEk2ZkZZY0RyZUJ5dUNjOURraWlLYUQvbmVtbkdC?=
 =?utf-8?B?V3lNZDlTRitGYXNQR2VUeldrMlQxZ0tKekptTkNEYm5HeEJiQ1FMb2RsUHFT?=
 =?utf-8?B?R05MbWdaYWxKN2lDMGNtNkgxSjdaVnAwRHROb0tDb0xTOVJ3QW1FQ3E5cmRM?=
 =?utf-8?B?by9QZkRlc0dOcVI2S0FzV294dXlMd1kzaFlkUVhUemhvQ3FqQ1JpU3lITkNO?=
 =?utf-8?B?VjNVREVBVnhCZlJ2b2VSU0I4Q1MxRzZHZWgwR1NSYldTVVh0TjBqdVlPTXUx?=
 =?utf-8?B?TGZMODBXbDNRWGIxZy9jdnR2NnlEbm5YMVRuWStJbDBOaVhCQXZPTEhpT3hq?=
 =?utf-8?B?SU5Gc1dCQU45Qzh0QXZ0dXAzbnN1RHJlZTloRHplS2M5VzI3RmRRYzR0MTdw?=
 =?utf-8?B?OS95NHRzeGJZTnhoM1UydjFSZDBGc21MSmh4VGNHNEw1emIzZzFwQW1hOXBm?=
 =?utf-8?B?c1FTRU9kb2VQUk9jVzkwMFBkeGhYM21nUCtYYkFTcUZDK0RmbUQ1NW4wdzQ2?=
 =?utf-8?B?RE1KcTVUcWJxTHlENUo5WE5CZVkzTURHY1RRaThvenBXeDBvcERvRU9tZG03?=
 =?utf-8?B?aVRjc3ViMXp0TEJVVy9WQUFkTFNGU1N6OWxTWXIrMnhhaUZZNmFlWGtscnIr?=
 =?utf-8?B?Q0tUNGJGU3QxcXByQ3l5c0pTQlRnZ3BDMEJpMkJtdStCaUVTejhqbkxNM2Zk?=
 =?utf-8?B?MU56aHdSZVpIZmpEbUhwcCtVWWwzN1p2d0tmV28vRERMRkFsVjZBblZqSW5C?=
 =?utf-8?B?Qjc4OG10dlFodE0rblNBbzhaSFNrenBCTmdySHBaRGEwcjlPakFYV0g5NENp?=
 =?utf-8?B?MjFGUTJ6bmNjai9ZRlVDcElXZ3oyODRmaXNBRUVBcVlmeXBKTERlbzVyRmlB?=
 =?utf-8?B?aDZIbDV4Znhpd05sU1VjRWp4STFqUTkrVGpRKzhEeFR3N1F4TElvVis3cHRw?=
 =?utf-8?B?YkN0TFlkQnh6RTJaTVV5enFpTFpINURTcmZLZGU1SXZKUk5ZcFEzZHk4SU41?=
 =?utf-8?B?RGZHeDBvRUExeWUya2FsVHlQU29uK2NXY1RLQVNnYml1bjB4ckV0Y0dER0JN?=
 =?utf-8?B?TVRhZzlyQWxHaTdJQSsvWE1KeG5TZ1cwajY0dkZNRnB5QzhrcU1XRStEY0po?=
 =?utf-8?B?SjZOdWdyV1NXZFYrb01jeTVwNCtzZ2h1MmxjVXo1LzdBVFZhVGhCVEFWbnlH?=
 =?utf-8?B?SEliTnNFd3NkbUhDTExzVzJqTUROclcxYjJiSDZpb0JhZVJkeGljZEo5RVc3?=
 =?utf-8?B?OWwzSnN1WmhndXc0U3UxRnZMSVNyMHhaR1FZeTdKOVRoWVZYRWF3OW55dy9a?=
 =?utf-8?B?aTNOSEdFc1A2U3NMNFFBRUxXZWhDU0VNd0RyWC9aR2ovbkxvb3QrVzc4NmhL?=
 =?utf-8?B?Q2Q2YXA1ZUJYZUdUOHdSNTV6ei9GS281T2ZFNGdoNjRyRU1SaVhpb3BDUnU4?=
 =?utf-8?B?MUdCNm8yVVNTU2dlRUpGdC9uM0cyQkdjZGZnTk1ISEoyay9KU3dPV0FyRDcv?=
 =?utf-8?B?cUNZc3ZNWDNicWd5V0ZpU3Zma3orSndQVWlEZU5TTTZoZE9vTlVnSWJkQkVH?=
 =?utf-8?B?dHpVc2pWY1c5TFJ5NlpZdTBCQWlEdzZNaTcvSnlFekJtQkQ4S21tZGlOVTln?=
 =?utf-8?Q?CA+t+T9kviLykBpehcwaMhRTU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6994be3b-46de-4440-a7d1-08dc1e86dc4e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:52:55.2037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDXcyV+Du6K4SgXFuvv4ejmtQJdU2yI/dnfNPo/yH0lpZ9xPuRMu2crdhJLgxPHSkhgAAWdpzW2GIc2/YaIRBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866

On 1/26/2024 02:08, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add suspend and resume support for `passive` mode driver which can save
> the previous CPU Pstate values and restore them while resuming, on some
> old platforms, the highest perf needs to be restored from driver side,
> otherwise the highest frequency could be changed during suspend.

So this sounds like a BIOS bug, right?  Do you know how far back this 
problem exists?  Should it be a quirked behavior to only run on the 
broken platforms so we don't need to run the callback on modern ones 
without it?

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 48 ++++++++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5cbbc2999d9a..bba7640d46e0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -785,23 +785,61 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>   
>   static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
>   {
> +	struct cppc_perf_ctrls perf_ctrls;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u64 value, max_perf;
>   	int ret;
>   
> -	ret = amd_pstate_enable(true);
> -	if (ret)
> -		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
> +	if (cpudata->suspended) {
> +		mutex_lock(&amd_pstate_driver_lock);
>   
> -	return ret;
> +		ret = amd_pstate_enable(true);
> +		if (ret) {
> +			pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
> +			mutex_unlock(&amd_pstate_driver_lock);
> +			return ret;
> +		}

This /looks/ like an unintended logic change to me.  Previously 
amd_pstate_enable(true) would be called in all modes, but now it will 
only be called in passive mode.

Is that right?

> +
> +		value = READ_ONCE(cpudata->cppc_req_cached);
> +		max_perf = READ_ONCE(cpudata->highest_perf);
> +
> +		if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +			wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +		} else {
> +			perf_ctrls.max_perf = max_perf;
> +			cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +		}
> +
> +		cpudata->suspended = false;
> +		mutex_unlock(&amd_pstate_driver_lock);
> +	}
> +

> +	return 0;
>   }
>   
>   static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
>   {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>   	int ret;
>   
> +	/* avoid suspending when EPP is not enabled */
The logic seems right, but shouldn't the comment be:

/* only run suspend callbacks for passive mode */

Because this stuff won't run in guided mode or disable mode either

> +	if (cppc_state != AMD_PSTATE_PASSIVE)
> +		return 0;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +
> +	/* set this flag to avoid calling core offline function
> +	 * when system is suspending, use this flag to skip offline function
> +	 * called
> +	 */
> +	cpudata->suspended = true;
> +
>   	ret = amd_pstate_enable(false);
>   	if (ret)
>   		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
>   
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
>   	return ret;
>   }
>   
> @@ -1460,7 +1498,7 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>   	if (cppc_state != AMD_PSTATE_ACTIVE)
>   		return 0;
>   
> -	/* set this flag to avoid setting core offline*/
> +	/* set this flag to avoid setting core offline */
>   	cpudata->suspended = true;
>   
>   	/* disable CPPC in lowlevel firmware */


