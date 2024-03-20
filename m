Return-Path: <linux-kernel+bounces-108804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381A88103E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50AD1F233CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721039FED;
	Wed, 20 Mar 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ycylnT7z"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A72D78A;
	Wed, 20 Mar 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931706; cv=fail; b=AZOqemux1W8CDZ9hI1p/xgJJFfOIUMIoCFUSwzaImoV2K/JxLMmPH7GJzwlGSfGkE6PioZShySvijlMJHlONFqeWIjvE1rYb/J5CwJdnZXueGFFqkForaLdvzgIDkjWuQfpBDovgC9vsEuzxaSuS/rs/ktO11mlQRK+g8/elFBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931706; c=relaxed/simple;
	bh=aC0dMtWX6PR8IlpS6OvX2cwaLqKkBVQmHJPj7VRS5gI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b83JYb3FhrUGGlbLq9jYCKRuxKPdvXpqRhLxhmAzIMbYAeH3ANQKxJ3kdl+py0GuD5l06j3xHlAvYJUprftHArfSFcbvW8PEnsMo/CDgUzzovvQcf4ht6D4ZDsjmjQUlLt46/n12OlntSeQ2dCWfxJo+ostDhA+k/mVNG/j33lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ycylnT7z; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAW6+5DUuY8kh0Qe9ik0TX4YfV6CSvUOAQNcKbkIyy+VlfqyP/U+M/aSdO60zlfkgwrj+ngeaZjSvY9sMKwXz29nfMY+0gndTCKvd39bTmhOMiGVEifOm+5fQwbAAdwfLzq3QrK4U4TTKrH1IfjzhuhIDB/4AEpeKqYiyd/DEYnaiZNVtS0F5TMcP+LMveCQ2dL1KXVcp+jFrcZgKBjehFqINsPGL1iV3Hf/+Xzq7ApS6aIJF3ssml68fZ65k1wsmRoY27Ah5o4+QIoMrgTksQCII7AeycXx8Ju/8uFldgHxdSKOLP2oMvbI3I2JBBARTQjFhIgyrzgGkfAOPzEf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsp95njQOK8z1SmhSSk1szjCBW/6hWq5dHU7dT1PflM=;
 b=OXo001bRpQPYllIfgVXvTKS37pecNcrYcdLLfvgk6/JsZYURKmWoUMA6ori9H3pxB3pl7ya7Iszg3FUONHdho/+lLPt3GDOAlGEYYKkg/dioI9MjjAl3usO8zf9nubhrTDJtYSw+7eNhyq1HFCXCEnESUMwG+vVvjRaxF0lUAyW/PLaQznRK0DTs9Bhc0ywkexXpAGZE76dQkeMySD3/DoORg3kJ5v67EcUIpfmKQPSHaxhX6TwBdrh5V19YvwRQRlVTAFMzOEGIslLgsvcS2u2rISnPhTkJyrP4+feImbojpDRH5atg/2Ekq/xU8Qq/7sD7oE8fD2LGSSYIiMFWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsp95njQOK8z1SmhSSk1szjCBW/6hWq5dHU7dT1PflM=;
 b=ycylnT7zAOm/b/rrhQEuYEi6FeNpsNPNlhIg9eSDqqBXzqK7RslO6fvgSm9LIWh3sKFfvjVvxvzmYb0xcSYEpM/gPD2LDWLyJDQIbP/nMQUbo7V7FKuF5VqY/NUb2umM6ARlsWUlgOg0S7BPDqBnwkBXZXgXa27I4D6ketyyMCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 10:48:19 +0000
Received: from SA3PR12MB9198.namprd12.prod.outlook.com
 ([fe80::af08:c05d:9c87:50f6]) by SA3PR12MB9198.namprd12.prod.outlook.com
 ([fe80::af08:c05d:9c87:50f6%5]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 10:48:19 +0000
Message-ID: <ec30daee-eadc-4f8c-8f94-3c7df5f9c58e@amd.com>
Date: Wed, 20 Mar 2024 16:18:08 +0530
User-Agent: Mozilla Thunderbird
From: "Ugwekar, Dhananjay" <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH v9 0/8] AMD Pstate Fixes And Enhancements
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Mario.Limonciello@amd.com, viresh.kumar@linaro.org, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Ray.Huang@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 oleksandr@natalenko.name, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1710836407.git.perry.yuan@amd.com>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <cover.1710836407.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::34) To SA3PR12MB9198.namprd12.prod.outlook.com
 (2603:10b6:806:39f::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB9198:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 47af45fb-544d-4f98-2434-08dc48cb412e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	utMR+DB+Brh1I7rcKb2w6NbDBq6Z+6SxKw1nh84zy6Om4i9eMLYF620tgWqub3qwXywfGyL/U/S89vyCOV0hg/fNfBBQOUIC4AnDvoNvWJTpAR3gVFGoJHnC1EcrwPFWT2pOpd+PQLewV6sDF5Dyrqr/Wn0Q6Nrk+w8o27W68qs3eLMkpiFdqcvRBmoAsxsLYF/dF7PqmgWLk+mgpn4aYB6U4IAUdDE/p0OIJBf7W/uV5Se4u3eGloCi5gCFkJIr/iylqdD3/9NzHV7eDe0rpu/5SRFFQObk2YVLiUtM4LkGKmEb0FoIkj+uaGOuAxpZ9uI4j9LlgRyYzoHSAsBjAEuGOPekYQPdIMqsTfenDBP2OMsbb9sW6so4dKAqX6Noo1z2uWLeac5u846oea5cZd2GIII/dER/vd6fKeLr8HtnGC7BH+bs1rKpiGLJ+r4m9OmtihTt4BOujCUKv/W+jlj7pKz6AtwV9u9iBtM2HE4Uv3RziaK9jbfpyj5RMBwdzP2ANwvB646KbwDXr1ubVtfmuKmDrYl+i1K1DZ1DXixoBKgawoMxm8Ct80h4fBUL2AfE+gQV1/j0mXjGbSv2dNbkIcmp+dg4Fz0n5oPnSm/xA/PoRFIzLDXel7QREwYq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB9198.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTlleFFxMTdkMExEaFl0U0RXcFBudHZHYldMTGxuRnVJSUd2b0xvMWpyWHlB?=
 =?utf-8?B?bWZTaXJ3QWMwUEVSMis1OVdtVDQ5a0ZWNHBMS0tGcjRkM1F6Vk1QUG5yb0Fq?=
 =?utf-8?B?bWJxQWxja1ZBd3g2bytBQjJ1WjZJVDZ1dEZBLzhqRSsvd1FtVVpmenIrckhS?=
 =?utf-8?B?cERyV2hkRC9VbmdVaGhCcmJHQ2NNUHFIOTcxUVl5ZThsY2h4STg2V05GOGsy?=
 =?utf-8?B?WGhXM2FmdnVLWmd2UWk5VHA4Y2dDQXVxMCs5bVcxU2JsTEczQ2xFTDBTdkZk?=
 =?utf-8?B?VzkwREw1WTdIQlAwZ1k1Vis1RjYzeFNLRFowckMwUkFGQTJNNjRHTTgzek9r?=
 =?utf-8?B?RnBkeGsrcytGM0xhOXZIWVlRbHY0bTRLdndFdGd0bldwSW5QNzMrbjFENThy?=
 =?utf-8?B?WHlsbXpVSzVaa1JaK3NBcXhoSk5ER3A5ZnF6SjE3YVJaZ3loZUM3LzczdXpj?=
 =?utf-8?B?NWdOWmJIZHdDN2o2clV6M1lnWEFJTDJPOHVZVTFzMk5GTTY0T2FRcXIwbzZy?=
 =?utf-8?B?RnQ0MUlTYjlPMk9XemZIOW9QK1RWUkdOVEJleDM3N1pHOG9pRUd3aUhOYmU3?=
 =?utf-8?B?R2JRRW1sRmlXeEFWMExCVU9aT2N0bVgvVUxBbnRXZDc0V2RaU3lOMVBOM2w0?=
 =?utf-8?B?SVNHTzVmdHFvL2piU29PeGFWYnpXOUdDSVJDRDErR0Z6TVdRZS9mbUFzNnU4?=
 =?utf-8?B?aEthdEJWRUdjR2xQYmZOSE4xbHVVenVCcUtqK2R4NWd1T0laNzRIOTBGMVEx?=
 =?utf-8?B?VldYWVVCNnozTG5mdHV0QUo5ZnNnU1J2dDlkOXgwV25vWmxNa3V3UnhDMDZz?=
 =?utf-8?B?aGRJN0lWdlp2M3Q0TUNSNHlHZ00wNDE2TnZZWGdSLzFESGRNKzNtdEhabEJa?=
 =?utf-8?B?bW1Hc0Fpa3duZ09JUzZBV3ZBK3crcjFkUzNUR3RYQWVrUW5jR1k1RmRLM05I?=
 =?utf-8?B?Y2VDNm9lSXRuWVBLbkhQWlErRmNINVd3TWVsa29iUFd0ejRPbndzNHc2eHZV?=
 =?utf-8?B?M1BmcnNYalEwREwxeTBNUHVqVWV5Vlk4UGROLzUraGM4OXNKWU9uUmdLWmJz?=
 =?utf-8?B?U2FsYWlJTVdkSXB2Y0M2a0YvTDRkY29TNDd6TVJPbCs4Y3pBRzIvRlR0amU4?=
 =?utf-8?B?SXdkQzdPbkxxaGJEbDN4Z3crTXAyblREOUNZbVZaaHhOUTVON3JBWWZTZzdT?=
 =?utf-8?B?NU1XbGw2Qk8vYUpkR29DM09SUjk0QithSnJzL0x4NVRoenlmVytJWHd0TDRQ?=
 =?utf-8?B?NmlDUFhhdnYyUG5mOVpmWnR3eEQwRFJhTzFPZUUzb2VQK2pSNXl1bVM1cEVO?=
 =?utf-8?B?ZzlXSnVmMmJOcjMvR0JNV0xmdjMwdzFKdzEvWFM0bWxtUkZUYmtuNlpWRmxE?=
 =?utf-8?B?Qmo4TFk3M1NXc1FTTXBTUklDQVlYUVU0RkZTdnkxY1VSb0FuN1BoUzhPSlZ2?=
 =?utf-8?B?T1h2Y2Vwb2JoemI4Q3RHS1puQUUwTUswenByZWgwOXpUOCtWRXhUbzFRVVMv?=
 =?utf-8?B?Y1pPbEljaEhLWXduc3NLM29pUEwwbjRYSjJud2RSUHFvWndreWpHMEk3eTY0?=
 =?utf-8?B?VFZpYzdPeGkxY3cvZ0pQTFpmdXIvVkVmYzZHQnd1MGVxYzQrUHBwNFNIMGky?=
 =?utf-8?B?L25oaGhoVGVFMHNVSGV6bHRzZEtXN3RoWG5vYVoza0NwVjZlUkVSdU1zbmVC?=
 =?utf-8?B?eW9jSjE3dkxmSHFqcEdzd0VlWnUvZjRpbUhjd1hrM1d6NEdmZFg4TlIwa242?=
 =?utf-8?B?d2ZiMUE3TlJiUVdDSTBjVmYrN0FRUE9LUEIwR3dBZnpLTU9sanROWGM2Myta?=
 =?utf-8?B?a1JrcE5SQVVZbXFqa0gzMnVES3hKOXlFK3Q1UmwrWlhVWWZINnd6V1E4K2tR?=
 =?utf-8?B?VzByVnlCSkJ2bHdaV1RWZjJESzNkYTFjZVNhZ1VVWmxiV0l4NzhrdFhjdWVC?=
 =?utf-8?B?ODZ2NUpXNHlGelNBRzR1dFk1eWwvUXd0YkN3MS9tRWcxNlhTeGhnUEZJY1Aw?=
 =?utf-8?B?Q01pWlBGNjdqcDlTZEkwUlVwbzVoSnR2YlpJU2hQRmxkbmFsOUxjeEt0VDJ2?=
 =?utf-8?B?V24rQ2RsaTVOSDlwcGZybVQ4eXBlZCtqcS9ZVmNUWVRma2VHM01vU2RlMGpi?=
 =?utf-8?Q?sK7UkCpHkCMEvqj+Xgp5lmIze?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47af45fb-544d-4f98-2434-08dc48cb412e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB9198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 10:48:19.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUEjv929Xlbhpll586lDda5GIYj7XwHQ0vZEArqPC1ZFLms69KmM9mDhHRlyTQwZ58EfvfHISjvr21mTCrC9bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424

On 3/19/2024 1:58 PM, Perry Yuan wrote:
> The patch series adds some fixes and enhancements to the AMD pstate
> driver.
> 
> It enables CPPC v2 for certain processors in the family 17H, as
> requested by TR40 processor users who expect improved performance and lower system
> temperature.
> 
> changes latency and delay values to be read from platform firmware
> firstly
> for more accurate timing.
> 
> A new quirk is introduced for supporting amd-pstate on legacy processors which either lack CPPC capability, 
> or only only have CPPC v2 capability
> 
> Testing done with one APU system while cpb boost on:
> 
> amd_pstate_lowest_nonlinear_freq:1701000
> amd_pstate_max_freq:3501000
> cpuinfo_max_freq:3501000
> cpuinfo_min_freq:400000
> scaling_cur_freq:3084836
> scaling_max_freq:3501000
> scaling_min_freq:400000
> 
> analyzing CPU 6:
>   driver: amd-pstate-epp
>   CPUs which run at the same hardware frequency: 6
>   CPUs which need to have their frequency coordinated by software: 6
>   maximum transition latency:  Cannot determine or is not supported.
>   hardware limits: 400 MHz - 3.50 GHz
>   available cpufreq governors: performance powersave
>   current policy: frequency should be within 400 MHz and 3.50 GHz.
>                   The governor "powersave" may decide which speed to use
>                   within this range.
>   current CPU frequency: Unable to call hardware
>   current CPU frequency: 3.50 GHz (asserted by call to kernel)
>   boost state support:
>     Supported: yes
>     Active: yes
>     AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.50 GHz.
>     AMD PSTATE Nominal Performance: 204. Nominal Frequency: 2.80 GHz.
>     AMD PSTATE Lowest Non-linear Performance: 124. Lowest Non-linear Frequency: 1.70 GHz.
>     AMD PSTATE Lowest Performance: 30. Lowest Frequency: 400 MHz.
> 
> 
> I would greatly appreciate any feedbacks.
> Thank you!
> Perry.
> 

I have tested the patch on AMD Zen4 Genoa machine with boost off,

With Patchset:

/sys/devices/system/cpu/cpu89/cpufreq# grep . *freq                                                                           
amd_pstate_lowest_nonlinear_freq:1804000                                                                                                    
amd_pstate_max_freq:3514000                                                                                                                 
cpuinfo_max_freq:2151000                                                                                                                    
cpuinfo_min_freq:400000                                                                                                                     
scaling_cur_freq:1805231                                                                                                                    
scaling_max_freq:2151000                                                                                                                    
scaling_min_freq:400000 

/sys/devices/system/cpu/cpu89/cpufreq# cat cpuinfo_transition_latency                                                         
20000

Without Patchset:

/sys/devices/system/cpu/cpu104/cpufreq# grep . *freq                                                                          
amd_pstate_lowest_nonlinear_freq:1804403                                                                                                    
amd_pstate_max_freq:3514280                                                                                                                 
cpuinfo_max_freq:2151000                                                                                                                    
cpuinfo_min_freq:400000                                                                                                                     
scaling_cur_freq:1805375                                                                                                                    
scaling_max_freq:2151000                                                                                                                    
scaling_min_freq:400000                                                                                                                                                                                                                                                         

/sys/devices/system/cpu/cpu104/cpufreq# cat cpuinfo_transition_latency                                                        
20000                                                                              

The amd_pstate_max_freq seems to be incorrect with and without the patchset when 
the boost is disabled, which is supposed to be fixed in the cpb patchset.
Rest looks good to me.

Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Thanks,
Dhananjay

> Changes from v8:
>  * add commit log for patch 1 and patch 2 (Rafael)
>  * add missing Perry signed-off-by for new patches #1,#2,#4 (Rafael)
>  * rebased to latest linux-pm/bleeding-edge
> 
> Changes from v7:
>  * Gautham helped to invole some new improved patches into the patchset. 
>  * Adds comments for cpudata->{min,max}_limit_{perf,freq}, variables [New Patch].
>  * Clarifies that the units for cpudata->*_freq is in khz via comments [New Patch].
>  * Implements the unified computation of all cpudata->*_freq
>  * v7 Patch 2/6 was dropped which is not needed any more
>  * moved the quirk check to the amd_pstate_get_freq() function
>  * pick up RB flags from Gautham
>  * After the cleanup in patch 3, we don't need the helpers
>    amd_get_{min,max,nominal,lowest_nonlinear}_freq(). This
>    patch removes it [New Patch].
>  * testing done on APU system as well, no regression found.
> 
> Changes from v6:
>  * add one new patch to initialize capabilities in
>    amd_pstate_init_perf which can avoid duplicate cppc capabilities read
>    the change has been tested on APU system.
>  * pick up RB flags from Gautham
>  * drop the patch 1/6 which has been merged by Rafael
> 
> Changes from v5:
>  * rebased to linux-pm v6.8
>  * pick up RB flag from for patch 6(Mario)
> 
> Changes from v4:
>  * improve the dmi matching rule with zen2 flag only
> 
> Changes from v3:
>  * change quirk matching broken BIOS with family/model ID and Zen2
>    flag to fix the CPPC definition issue
>  * fix typo in quirk
> 
> Changes from v2:
>  * change quirk matching to BIOS version and release (Mario)
>  * pick up RB flag from Mario
> 
> Changes from v1:
>  * pick up the RB flags from Mario
>  * address review comment of patch #6 for amd_get_nominal_freq()
>  * rebased the series to linux-pm/bleeding-edge v6.8.0-rc2
>  * update debug log for patch #5 as Mario suggested.
>  * fix some typos and format problems
>  * tested on 7950X platform
> 
> 
> V1: https://lore.kernel.org/lkml/63c2b3d7-083a-4daa-ba40-629b3223a92d@mailbox.org/
> V2: https://lore.kernel.org/all/cover.1706863981.git.perry.yuan@amd.com/
> v3: https://lore.kernel.org/lkml/cover.1707016927.git.perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/cover.1707193566.git.perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/cover.1707273526.git.perry.yuan@amd.com/
> v6: https://lore.kernel.org/lkml/cover.1707363758.git.perry.yuan@amd.com/
> v7: https://lore.kernel.org/lkml/cover.1710323410.git.perry.yuan@amd.com/
> v8: https://lore.kernel.org/lkml/cover.1710754409.git.perry.yuan@amd.com/
> 
> Gautham R. Shenoy (3):
>   cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
>   cpufreq: amd-pstate: Document the units for freq variables in
>     amd_cpudata
>   cpufreq: amd-pstate: Remove
>     amd_get_{min,max,nominal,lowest_nonlinear}_freq()
> 
> Perry Yuan (5):
>   cpufreq: amd-pstate: Unify computation of
>     {max,min,nominal,lowest_nonlinear}_freq
>   cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
>   cpufreq: amd-pstate: get transition delay and latency value from ACPI
>     tables
>   cppc_acpi: print error message if CPPC is unsupported
>   cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities
>     missing
> 
>  drivers/acpi/cppc_acpi.c     |   4 +-
>  drivers/cpufreq/amd-pstate.c | 257 +++++++++++++++++++++--------------
>  include/linux/amd-pstate.h   |  20 ++-
>  3 files changed, 174 insertions(+), 107 deletions(-)
> 


