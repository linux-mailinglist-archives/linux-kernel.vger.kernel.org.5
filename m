Return-Path: <linux-kernel+bounces-98658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253BB877D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBF728117A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE7224D1;
	Mon, 11 Mar 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="POGIpX4/"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942802BB1A;
	Mon, 11 Mar 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151136; cv=fail; b=OsoeTAR3pAuCKuApMU4BtaQKj28gwvwqap6BkSD1dF801XQIKVg/CWabGPsOnGMalWxaqS0vvmpVHWm/7M3A2+JUskAobWCRT8VP+/1fU15MEe+c/vHZnNQSSA353g/5Q3aD63hUErFiQ6dBtPI4taw131BS58zhHDdKgW94Vt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151136; c=relaxed/simple;
	bh=tWNlgSH7NyO8XBUzQRtRr/Rsdau1URdMVaRiJs+WsF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a8ZTq/7DWIpPutK4AJayMNsFaBy1sJvxwCliidOd1d8Ct6BJ4l0giL8jGdA6V15SHLTKFujrz1ApY/MizrPiYmY149BmRADVPzFFxJRuhc0isbLDjqyCWvEBnawLAfKUsh6jaf96b4SDswoHILzOhSnFQY/pMdhYDeKOs5DVVPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=POGIpX4/; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXxFijf5ZKYkzO/F9ngVPdJmHZqtCmANZTT96xbP41i2omF+TatKjfzcWIkQeEzpaoZByoBzVGD9Jce5+xmOtS0M2JZRsQdEQtV+ikWXHmZlXhB8Irr0wyhOvkIyX4BywwlwRbS8MZQIaJ6ECwmYGvBwH7FvefyBj2xH0Jepx7q6vhce3GxsQxeQErUr4QGWMSzv5b3/Ij8ihyg9j9z89qYkiKIBWzVwFsREnjF8sJftrR1m6wMynyGjvKhsFe79hdcmAilGuKvCzMfGidFGyk4iAE8o2ljPVQkA2T9dwVF5Kt6NIWjL/uNV/kvED13DX0vxtsaw3WiRiEDiGEDAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S55zEuY7pVdLJHeFEz6tDnooptujaOVPUoW7JYyx1+M=;
 b=AZdbS552TkPilHzr9b56RA87dB+LUP8gT/pNeqPWbeRjimcSmBHKbBRe+wTYFRdXeicyxFHjkjlLLzkX421NALoisT7Il8rsiKzu9xHk4AGwuaChbYKPRAfvCjmn0MLF+fKYx7SaRGsfGCUlPlc2uVDlr6F5vaUENzY77800qRtF9LV2HVs8CCKKghIRjbnSFxUbBc8su0cJS9aSsI1w6KvaL8TYQvTRnmmJ5BNyk/vaULoghKpp4kQJybv2KYZKTUgKNQg1ec+RuJOn4pnjnsJuQ/mxsNonYIk+sdU4arkMMRK+Ru5ashoxb6PKRxJOhj7pkL4kUoYeRgvH67mihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S55zEuY7pVdLJHeFEz6tDnooptujaOVPUoW7JYyx1+M=;
 b=POGIpX4/dfNJSZD49U67PtU7IrT7FXT1FPIxSLeSgwEBJUN1HPMUqeh+HTc1RLeCXfQUYRZmDb+bUA6h+meuUtW9GLIExPpdLlDZnpckabZFlY6Cx3gIypk/cPYGe7ii8hfY2+imvf0TBsK6e409niayjxJXiF3mt8jtIq0RDFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 09:58:51 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::9468:eb10:db9f:5f81]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::9468:eb10:db9f:5f81%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 09:58:50 +0000
Message-ID: <1aecf2fc-2ea4-46ec-aaf2-0dbbb11b5f8b@amd.com>
Date: Mon, 11 Mar 2024 15:28:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] cpufreq:amd-pstate: fix the nominal freq value set
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
 Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <ebbe3741501a31b1ffcea208393cdd8929df6455.1707363758.git.perry.yuan@amd.com>
 <ZcRvoYZKdUEjBUHp@BLR-5CG11610CF.amd.com>
From: "Ugwekar, Dhananjay" <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <ZcRvoYZKdUEjBUHp@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::22) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c84a1e-1f18-4707-fe7d-08dc41b1da2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rNQ/GBX6+GhIpbQxi/ihb8s8edb7DqgLfWWF8tdzdpou5Yxi+y+Yycz4xfTQ7c9hyVcrujbBTWK95kaPTv0KTnvCpi/7Kuvijxrqb+hMBSSlgoEL/5eW2mVKhk0c8lokCEjqpQ8mksbN/YJjD6HBB7qjaiwDePcwbyvRZLZOxX+5XU+ehhQ+L6fhQKnslLWt3XqlSnWGEcvnlknS+10rpAadDEAIMqtA0uvbRRHoEbbtIEbnTfUiCyHh7Q/XJFFV0RTUVZj7BNFAFmD4N8ADLG8VkRLK5NOQelIyCsdvlOldKOnX1DmrmOidMzHXA/3s7y/+mwBPptCnna6xeB89Zcg6fDfNb6fV97WUssX2nmhT5s+1bN52hEdH8QYXr0Mms+aXXpcXJ+cojO8mcjwavj4jzNI+97lnDtSvHjkpyeOjW6nB4fOvlcWvKnLOxn0fF0FVO27f0g8nhIiJJvlqWxN3mxPlq75iq0FPYwb7FAMrlCgrv251WebnpbOEhZKSLfJcA89SldZpLnxMhelEX2h+ORr1vC4pH3xX5xnJMl+ByOOO1LXgmBLTi5dPTATcOSnqtKlXegQMqGPpSz7TUB0w3UO6+Ogy8NHsiwU9rSXPd/XJ89mUk8rf5fXnQpYTZB1o6QJqc+nTymc+mLEnKzcv6N+O+cM9uz2qRSPqZ1I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXUzb1VGektoNEFSaDZ0RVgyRjIzdnp3aGFkRDVIeldiclNaNUNrbTZQZmxE?=
 =?utf-8?B?Y0NWelhJN1YvTmZTaFJCdFh2cUtyT3lVTFpGR0NNc1k1SGMwUUFqVU9IOTgr?=
 =?utf-8?B?c1dZL1ZBYUxGOURScEkwZmFLS0dsbGZGVXZ0MXI0R2JUSFFMWFl3UjZBYVRz?=
 =?utf-8?B?QlN5bnpSTzFLTHl5ZkFtK2E1N0Qxbm82ZEN4ZUhnL1NFU0xSSGVxb0h5SXJk?=
 =?utf-8?B?QTdBSU1kZlVpY0tIOFhLMEhzMDNlNjB4S05oaU02bUtYaUlUUXB3UTBHTHZH?=
 =?utf-8?B?ekt5RWhtMTdMcXJHVVV6UkpacURQa0FCWEE3OVhPWFluNndzSGFWM0dxaThU?=
 =?utf-8?B?N0tvd0F4ZnphbEhRYWpiK0NHTDFSMFE2UDhwVmtoMnc3RTl0UFM3STVBOTEx?=
 =?utf-8?B?eW1zc3liWThQOFBQMGVVOUpRaVQ5T3Z6ckVQL2l5OHRrU1NvN1E0S1V3blQ4?=
 =?utf-8?B?d2RaK3BXS1NVSVQ3QmVZOThodEhldU1qeEZPbWVKRUlHeU5DM1VSaVJwSFk5?=
 =?utf-8?B?YzdkUXlqNXZqT2JiL3huRm8yVnM5R3JPeEFVcmxPaUY5bEM1d3pSSzBtR0N1?=
 =?utf-8?B?R05xZkw4ZWUvb21COWdOYUZHYmoyMU51ZHpPUGtKbDNnRnJzVElCRDZQTklp?=
 =?utf-8?B?MFB6eGFJOXFoNjNuUldjZmVMQlRheUtjcUZuQTVlQmVERm8xNWE0NkdmMTZt?=
 =?utf-8?B?dmlwWUVMSGI0ZzlXWGMxQjhnQWRickN4cDgyVkpSdkdFOUxNZzNIODB6eDNw?=
 =?utf-8?B?Z2VrSktiTk4raXJHOHZ0cDlyR3BOWk1kNFVVbS9yVHlXLzBFdXBZN093Z3Rv?=
 =?utf-8?B?YXlmbWlhTUhKK0orVlQ4ZWtoRTFSbDdsemhQdHFWMXl3K0g4UkVhZXI5NTZ3?=
 =?utf-8?B?OU5BWUFtUkZEZWZTOTBhVW45VEd6VnBYenQ0TFJFVzBUTmk5UDJWUU5oS3RC?=
 =?utf-8?B?NUpzM05ZU0pzNWdVTmlMV2Q4OFhQOWtlZXpQOEQzMzMzc2VURnVLS29Za0ho?=
 =?utf-8?B?UHZ4NWx2NUNzS0kxMVF5UGJTVUtyT0NYS21nVm9WWUlEUG9iVDhYREVWbVhp?=
 =?utf-8?B?L3NZTGZpaDZOVXZRbG5SUTR3WlhKSHhlOEUxcEl2V1lZVU9zNGFKU0VXWmV0?=
 =?utf-8?B?RmpHVjJJZ3p0RHNqTm43Q252bXdRbmR1a1plQUJhYWw1Undoc05aT2Y0bWo4?=
 =?utf-8?B?YkpraTE4UFNIeG9zY0t3Uzh0VWx6b2syMk95SEVqUEtyNVU3aXNWVklYMm4z?=
 =?utf-8?B?Z3IvcytVS3lGcnN6RkRsWVh5azIzdStRWElUOXdJS2ZoSnJwRy90bTZTT0lB?=
 =?utf-8?B?a1A5REFzT1p1RWdXcHg4WE5YRDViQklGRFFieEJpMnVFZEVPcUFvbTd0Z2J5?=
 =?utf-8?B?UHV0RWZOZG5RdUlxZWZiYzBsNXpCSmNQcFh6a1lVTkoveW80NTk4VytFbk9x?=
 =?utf-8?B?SGNCU0VWdXMxdExrRndkdGhBWEFZblpTeUUwanlLS0hsbHdjU2lDcXFOTzhJ?=
 =?utf-8?B?SWlwYXEwdXRqNmw2a0M1MTYzSHZtTHh2c1RtOWRGVktxMHA3SzgyaGYyeU9X?=
 =?utf-8?B?VERxdVR6M1NVYXFSYjgvWGNhdVFPZE9oTW9NRFIyZVFrbDdjZkROS1BWZXpv?=
 =?utf-8?B?WjFNZGhBZUVLRW5GbDRFM1RNM0ZhT1pFcHRJTnlUSmMrNnRrSVJkc0RERGsz?=
 =?utf-8?B?ZXRNTXp4MHFPellraFRHekxGOWVPamEybU9IWXMwZ0Z1ajBZTjRDdXgzOXdU?=
 =?utf-8?B?K1N5VWFtOEhCYTczMFhRekdTamJod1hYUFlMc2tKdHAxWjZjdFVFOUM2Z2Y2?=
 =?utf-8?B?ZnIvV09rKyswTXFPS1JMZ0N5T0JoT2dkSXliRW9uaHFSQlQ4K214ZzhUT3Fk?=
 =?utf-8?B?OTM0Qk9ySGxnbmNqQUNxQTZrc0pxMHFHTExWUmRpbVBjVTZWOXdVd04ybkhu?=
 =?utf-8?B?dEtxVmd3TEJucXl4eitwQ2FQazE2NVcvRUl1ZEQwU3NxVWR0eXp3dmxoVmhC?=
 =?utf-8?B?SWF1WUVRMW1NbE9XWVZXb04rUUJzVW1ZVTMwWjlOSmtRZmltOEpaWW9vVzNY?=
 =?utf-8?B?L0paTUxvdDhaTEJtaXREU081dzVvQXpTbkNrNWxscGcwN3JUMWtHQnRhT0Qw?=
 =?utf-8?Q?TElj8FxpAUgx4+akMB+Pbxwhl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c84a1e-1f18-4707-fe7d-08dc41b1da2f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:58:50.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyP5lgX0gaSA6RcLJlLVleIZaoSHRZRWirL/rwNtPrrdO1N7TzHZ6DcPbt4p5FW87Pf2roKRekVzy07cAcQvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874



On 2/8/2024 11:37 AM, Gautham R. Shenoy wrote:
> On Thu, Feb 08, 2024 at 11:46:29AM +0800, Perry Yuan wrote:
>> Address an untested error where the nominal_freq was returned in KHz
>> instead of the correct MHz units, this oversight led to a wrong
>> nominal_freq set and resued, it will cause the max frequency of core to
>> be initialized with a wrong frequency value.
> 
> The _CPC object on my Zen2 EPYC server which has CPPC v3, I see :
>             0x00000190,			//LowestFrequency 
>             0x000007D0			//NominalFrequency
>         })
>     }
>  
> where 0x7D0 is 2000 Mhz. Thus the value returend by cppc_perf.nominal_freq is in Mhz.
> 
> In this patch, we are changing making amd_get_nominal_freq() return
> 2000 (Mhz) instead of 2000000 (Khz) as it was doing previously.
> 
> amd_get_min_freq(), amd_get_max_freq(),
> amd_get_lowest_nonlinear_perf() -all these functions return the
> frequency in Khz units.
> 
> These functions are used the initialize the value of
> cpudata->max_freq, cpu_data->min_freq, .... all of which are in Khz
> units.
> 
> In, amd_pstate_set_boost(), we have:
>  
>  
> 	if (state)
> 		policy->cpuinfo.max_freq = cpudata->max_freq;  <---- In Khz
> 	else
> 		policy->cpuinfo.max_freq = cpudata->nominal_freq; <--- Now in Mhz
> 
> Since policy->cpuinfo.max_freq is expected to be in Khz, isn't this
> patch introducing an error ? Or perhaps this patch series is based on
> another patchset ?
> 
> --
> Thanks and Regards
> gautham.
> 
>
I can confirm on Gautham's comment, when boost is disabled with the scaling 
driver set as amd-pstate, the max frequency reported is incorrect, as it 
shows the frequency in MHz.

I tested this patch on Zen4 Genoa server platform, below are the 
inconsistent min and max frequencies I observed.

[cpufreq]# grep . *freq                                                                                                                                                                                                                                                     
amd_pstate_lowest_nonlinear_freq:1804000                                                                                                                                                                                                                                                  
amd_pstate_max_freq:3514000
cpuinfo_max_freq:2151                                                                                                                                                                                                                                                                     
cpuinfo_min_freq:400000                                                                                                                                                                                                                                                                   
scaling_cur_freq:2151                                                                                                                                                                                                                                                                     
scaling_max_freq:2151                                                                                                                                                                                                                                                                     
scaling_min_freq:2151                                                                                                                                                                                                                                                                     
[cpufreq]# pwd        
/sys/devices/system/cpu/cpu0/cpufreq

According to Documentation/admin-guide/pm/cpufreq.rst, all the frequency 
values need to be in KHz.

Thanks,
Dhananjay

>>
>> Cc: stable@vger.kernel.org
>> Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> ---
>>  drivers/cpufreq/amd-pstate.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 08e112444c27..ac7faa98a450 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -640,8 +640,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>>  	if (ret)
>>  		return ret;
>>  
>> -	/* Switch to khz */
>> -	return cppc_perf.nominal_freq * 1000;
>> +	return cppc_perf.nominal_freq;
>>  }
>>  
>>  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>> -- 
>> 2.34.1
>>

