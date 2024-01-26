Return-Path: <linux-kernel+bounces-40298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3E83DDE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660D61C20CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41FD1D527;
	Fri, 26 Jan 2024 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bSUUetVf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15C1D522;
	Fri, 26 Jan 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283929; cv=fail; b=bqJLPtzCkPkKB4qLah6NlCp7MfTiQ2931VuYX+vPwNSrcHU+fq72Kd9NEHNLqaXDY+4Sy8dnJnh4py2mqhE0tEToHdQq5527lDTHiyx3gWLSN/VZ2irwD1ND4AFW4Fl0zj8c7GZIPELqGbAMxKnAr0IBmZz9B8w7BgcoFh24T7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283929; c=relaxed/simple;
	bh=3FkvGCKo1JONvWAi0ZGopP0ZUSEXJ4TlPZGU168tgfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mKqwLb6VSjEdOg2egDrMeYvpDdVYgXDECVfEtBHPMVxdLUe9t5bEtJ9uBB/PbZEv2HzMnLI2j6T2if899KcAqXvL78s2Ibb7ZOaZGwTSOH/yiAOOZc7wIEMQPZkUY3UDu0K06D+2AmCJUkogKsJsG1YFpqv6peCqq/HYcSJO/N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bSUUetVf; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diqigC2FvvvuX6LHqoWkrNszwRSfpqX9eWVUH0k7QEDwt5J6SVv5iIxf8wCuLUJ9da42HYqkI4r+89Oaxt39yuW0aPRjOfyQR163VlM6jF3vBf7PGkEXi60z8Zc/7/lx9RL11sYUtPNrJoR7QKYo87/EEwqjctAzd87CXzwbWOiARm+mSfyonr/mhcGi+TQmsdfwDsppBwWggVCZZItd8/0xGBHKgGqBgphv1BYO1+4/ou3hcKDrCF5kWoJeDop23NNPOt2OL/83qaR6YHO7nY1F3+alY7EkQDO/7L09cSIAJubLk2fOeiFKto+W8EJDyARulAABnzwamGi30TBUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+lnt2ImbjNeXqmh16PNpm/ykYGiBev0ZIjc9zCSg+o=;
 b=ITcNFKk4gCuUkK4R4kSFpPEk/Tnv/cH5lRzimFhzES3iNxSzLEgKhJ3DnN9zbyH0mLWfoXuHLDCHf7Vu/Au+Ac54dbg7+W/jIuhp86Or6MWqhnUhHGnKmIzilk8/pJk7KyqEOL6PVzMk3RZyD/gTAnxbEeAblf9ImmjIeGb8dJ7nmeONkPfDsYUg3fA7kPxPUZRL28/f9XEXwhIZolyPzkJBtccne3UruG7nRbsKfm1b8Bdb3XBQqSdfUxWpDo2/FZAy3nvGGIHSmMi16KN1aCOxaZmySN8Crdq1E3XSPtcny8Pycal1/w2TBHx37V2VVydYd6Ar0BbH+NGDd1Ui5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+lnt2ImbjNeXqmh16PNpm/ykYGiBev0ZIjc9zCSg+o=;
 b=bSUUetVflpCmRshl+MWsBoBUvE5ITPjqaVJIBKUc5Xk3vkNcTguPmMTGOtoBPj5B/S4bfLyExn18BvweYS5vf34HHSuX8PZyKrV7VaCOpkkBzwr2i6ekst5jQDQw5BkMSV62WGVB2cieXq2EmbjyzyXPCRigEbV4904Ncl0lZJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 15:45:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:45:24 +0000
Message-ID: <ddc3bc6a-b120-4327-bc04-b1b88318610e@amd.com>
Date: Fri, 26 Jan 2024 09:45:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] cpufreq: amd-pstate: remove set_boost callback for
 passive mode
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706255676.git.perry.yuan@amd.com>
 <3404e063b86a5517b70d497b066c3fdeb5d8bef3.1706255676.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3404e063b86a5517b70d497b066c3fdeb5d8bef3.1706255676.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:510:174::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 049cf3de-5c00-4f9c-d03b-08dc1e85cfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VRYE/Ejosp9Iu1T939CNaQ3SylS8aMMLMlIhk4fREs2+oqbw8aP6jR2yx/Ivj6YeVdXGKLg7J6AWhb9V4ir+jnax1U6/Z1nQ7uAtVGkUpC9B9JXfh8071UrFbuj+iBAlBlFXhFJAgaRNhg1NlLyU4aNAcUh/dX3xlto4LG9D8I22i4I7zDiBQkLhorh2+bPbS0Hbvi0BSFxe3ARz0pG9EvthXGNzV4c+QQGxLxcSLeKAl5TKWFR52DcX/29HvibZvFBYl5Od0wSkjNG/+E6Y3QIXBbi60d8dlLH7jJbGJQf1IH5ZVlu0B1Rz+IGHB1Ps3ZBTgMzLA1RX9SJMbK8BVsFogWm/9tXHByVq8PDBRmVoxILYZAOLp0cSPny6xAAFwBgZTbFLtd+96C//ZdUoRT7xKeyetjWWUTOPp7ItmqrIQ713CWf/sesUeVdOt3b7hjv/Q75SFlce96p/iaLvKaXwJXOHKNEPuGM76+XFa/ijY5y4Tdctd2b4jJLwUSXYQ35fBGvWQ3l+YIr3X6O646BhiN0Qw1i7i7G4fTSLD6qJQ2Fr30kI8O8fxlXx93iiPvyI5LI1v14Pe5fDks5TPJ3oHpqi9sD+iw1iHuEMH6L0sC4Ic21GAoLSvBtwizEmlKE09Z7hsqcKGDwypAJgVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(83380400001)(2616005)(44832011)(5660300002)(6506007)(38100700002)(26005)(31686004)(53546011)(6666004)(6486002)(86362001)(31696002)(478600001)(316002)(4326008)(6636002)(66946007)(66556008)(66476007)(8676002)(8936002)(36756003)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ZOd2p2ZTk5VjRkMG9MNjZMMVZaMjFNbW9ZYkxEYWZRWkpzUFF1dFowYWhy?=
 =?utf-8?B?YUZwMUM1Mjd1SkZua2QrYURZQlJlZERGSXVUYnVPM3ljVEVkejhXN1l0RThR?=
 =?utf-8?B?QUd0SHFWV0dtQ2NHMVRiUzc5R1UwVVcvTm85SVpFa2lYdEdzeHlrRzdOVVJo?=
 =?utf-8?B?T2JibGVmYXd3ajFmcEdaTGxzMlFXU2xZaDFWaDRhSnhqc1NYRlE3USthWG9i?=
 =?utf-8?B?bUd6ZDV5bTlhTmZkMFlQWDJUNEVkTDVnWENHZExVUWtZNS9iQmhPMW9YMkJX?=
 =?utf-8?B?RjFBWHJmSHUrS1kwWXRXYW00dWxBeWptVVZQaTRsUTJ1YmhSNHlYeGhKR2k2?=
 =?utf-8?B?N1B4QTlqRGw2M3dCTmZhMDk5TTBmcjRxeGJONmdoeDBtRGE0bEd5bVErWUJ1?=
 =?utf-8?B?bjU2cEM4QnZNcjcwNklHUW5waGZSdTlBMjdhY1R1ZTFRMTNvYzFlRFZMMjhR?=
 =?utf-8?B?SmJNQjc1eHBMazlHU1JDalN4Y1Y1L2dGRFU5TnRTQit4ejBSTjNFT3pudzFl?=
 =?utf-8?B?ODBGRVRCNHlnK0IzcTRFUWdPNitBOUdLZXA0aXZYeVp4NjUySUt4UklBdlhW?=
 =?utf-8?B?RFBMVC95bzhXUEc3Z3NFcnFGQ2M3VGFFL1lyS1VNdm5Va0VPYkFmY0VMVHZt?=
 =?utf-8?B?ek9hd2hBWVVlOWJ0RzBPTjQvTTZidjNZdUdWYWRtWVdIaE1EUWdOK3VaQWV6?=
 =?utf-8?B?b1hYMzJjZ3ZBbUpUeDRYWUE2SHR4bkpMMG1oVGhxTGNDVTd1Vi95TWVZQU52?=
 =?utf-8?B?WHdSOFVGL0FhUkJKMUhoOVhrWDVhK1F4aUFKZTYxYTE3aWJRRWFxMS9XRUxo?=
 =?utf-8?B?U2swakw2UWxxelVzZEJrSVBCdm9RUElNS0ZTYUV1RFdjSTR0VFlzSHpyQWEz?=
 =?utf-8?B?REh1MUEzQWNPTks3UzBHb1dkTTZtZklTT0VlN3J0K3dHbXB6RzFpVlJ6ZTBN?=
 =?utf-8?B?MDZEekl6eUJNOWR0QmdVZkFCNmF5RG1RaWdZTVNVMzNPNDc2QU8rdmxweVQ3?=
 =?utf-8?B?N3VwRkhnQ0toaVRLOHRyUldCeUV3U0NBeVIwUS9KVFdxSU9SbUg5dlBIRFlH?=
 =?utf-8?B?NGlmbDAwOW5FVjNMTFdyT0Rxa0FZNnM1bVllR21ndmpLZVpHWU92ZWh3blMv?=
 =?utf-8?B?UFE0MVlsV1Ivam1Qa0Z4c1hibExxUWN5Nm5ZOEQxT2NjenhEd3M2cC91TTc4?=
 =?utf-8?B?elM4RXpCZnVDNC9ZcjMyNEhVQXdPU3kxWVgxZkkzUy90T3RqK1p0S2FCRVVr?=
 =?utf-8?B?MWtQb0FYSDRwVnc3ZHppVG1qVVc5cldsQnFsd21SY0Q4UytlUHlkaGhkcXA1?=
 =?utf-8?B?SG0xZU9Ha29UcU11ZjNNRmwvNzJXYVhXS3p1Wk1GRGZEdHZYRXRyY21TOTBt?=
 =?utf-8?B?cXJaYmRFcDBHT0xUN05YRlYrQ3UyK25ERGkxNnk3eEdWc3lwZWlkTzdERllj?=
 =?utf-8?B?L2VZK25jVFRPTnVSRE4rb2lmWGtpTGl1eTdacldzRk1Kb1ZwdnN5aUdEY3Nm?=
 =?utf-8?B?VVlJNS9zVjFkYTVBSXJWdVRxQ2xpVTg1MEhLZ0p1QVhKVWR4bFhaNFVKd04x?=
 =?utf-8?B?Rno5UTJGZVR2OFdHV0RDV2hXY0tVQ281RnBoNUFOVmt6R2wyM0dTT2M3WHNR?=
 =?utf-8?B?U2R0bjhJWFRJTlU2ZUJRTmQ5d2txZWxjMFJZeWI3TzdBNGg5OFQ3T0NWZDQv?=
 =?utf-8?B?KzY5S0IyRG4vSTd1TFI2bE5ZdkliV2xWWk14MkxvaiswN1hROGtmWHV5Z2Yx?=
 =?utf-8?B?eUh1QkMzWjBKeEdtek94cStuSmJubDVjQlhQOVpSMmlxTWsrQmRPZm5aeHBQ?=
 =?utf-8?B?L20vR0NaUEtHR3pmcE9tb2lDYXNBeUZtUFp1ZW9mb0pGVEFCVzBSSm1mTzVR?=
 =?utf-8?B?MVl2RFA1L2VSTUN5VGd5dVRPSEo5VWpwN0pWenpWVkUrM3ZDY3IyS210cGIr?=
 =?utf-8?B?ZGVSYmh0Y3ZrbWNCUHVaMTBiMmlFbVhpcDBDU2FhZ0hYM294em1kR3lPaU5H?=
 =?utf-8?B?ZDNCOXVvSzZDVnNGYnowQzFISTBnZ1J2VGFKNlpOT0ZRMDlMYVNLZ203Vm1J?=
 =?utf-8?B?UE90QXFyNFJSdWpHTlhJWnAwUnFRenhxQnFLemNXUTVqdEV2ZTBuNFpZQlJD?=
 =?utf-8?Q?gbAcdiatmT/w3nWQ0QfDbCkKR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049cf3de-5c00-4f9c-d03b-08dc1e85cfd5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:45:24.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEowLUSuBxX8SukIeWfppyJRXE1z7I+CphM53PmgtF4pwOlou4ea8PDKnhzX33CfqAKVdHppTnn7tKPyUGucZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369

On 1/26/2024 02:08, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The following patches will enable `amd-pstate` CPU boost control method
When it's committed it won't be a patch.  How about instead "A specific 
amd-pstate CPU boost control method is to be introduced and the legacy 
callback doesn't make sense" or something along those lines.

Also; is the ordering correct?  In terms of bisectability should this 
come after the new one is introduced perhaps?

> which will not need this common boost control callback anymore, so we
> remove the legacy set_boost interface from amd-pstate driver.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 26 --------------------------
>   1 file changed, 26 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..8f308f56ade6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -632,31 +632,6 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>   	return lowest_nonlinear_freq * 1000;
>   }
>   
> -static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
> -{
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -	int ret;
> -
> -	if (!cpudata->boost_supported) {
> -		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> -		return -EINVAL;
> -	}
> -
> -	if (state)
> -		policy->cpuinfo.max_freq = cpudata->max_freq;
> -	else
> -		policy->cpuinfo.max_freq = cpudata->nominal_freq;
> -
> -	policy->max = policy->cpuinfo.max_freq;
> -
> -	ret = freq_qos_update_request(&cpudata->req[1],
> -				      policy->cpuinfo.max_freq);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -
>   static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>   {
>   	u32 highest_perf, nominal_perf;
> @@ -1391,7 +1366,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.exit		= amd_pstate_cpu_exit,
>   	.suspend	= amd_pstate_cpu_suspend,
>   	.resume		= amd_pstate_cpu_resume,
> -	.set_boost	= amd_pstate_set_boost,
>   	.name		= "amd-pstate",
>   	.attr		= amd_pstate_attr,
>   };


