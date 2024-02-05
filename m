Return-Path: <linux-kernel+bounces-53008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D8849F76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC08281E81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972793589C;
	Mon,  5 Feb 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mn+fDoHp"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A733CF6;
	Mon,  5 Feb 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150500; cv=fail; b=BktYuk6Bi6qJlW3hSuuQh9v33jbTBs4knMPaC0Q+8LDWeNxLrOtyXYWdbITV4Lyl3J/+xAKS8NLGm6bXBcw1xfQ+u4VIi+s8z7Ke5Fcl/tGC4VD7hNmgYeXCHiWiAvTTyWE7O4+cT7frzrMEpKOwiq417vTE5ZnpwJEE3PGY0xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150500; c=relaxed/simple;
	bh=1bbGcrLpxykXCkvnvn812BIit3yHsVguPjP6hcfRLJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H1spHt56iBb29+aAXF4o3JnRnyhECvg6uW3d4fe4bvKjVOB4i7e8NpmofvZkG8dg3xc4/0boURtX9VBIWmztf3+PWkkpPaC+4130YzK9BUU6slR6KF8jgcs4utuY48nP7Qp6Y0LwD24KvPAbcYKiywmBSoRNu6XGsEOwDTgG/60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mn+fDoHp; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+yKHapxkuvJVgShPpzmYI1zBpYPRi4S/kK9aPwvLBTFkWgcvBqwz49YNr1LfiLcS0CPoCiGFOKyExI8ONvFDVhSCHOiP7LkAex3VXpqTElJECw5AoCqQRDovzgdTjAhmyw/frxL6aOV+cKQc9d/kyJbgo7N0XcPRRbbEKm6tkBpr6LJn9Gfj28QUE2o2LMDMXhctLFz7UKqpUzOw/Rv/5ky1EzOc8SFnFdTy+AVuUbbNFOua7qBoCPLIaH3PeASwW0MXTrUfJRBa4F9Y63rwxZ04rDXmIepx3/LGpFAdKyJ5oomb3TMLOcfOuoIpwhTR8CPUS5Uz+EcOwvsqbQ4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R13P9HH40ZhFUyAVEfMxQNlDG8McDwvemPqsO+gk1aM=;
 b=lTWDVxFYdH67EfUOUdpCnaTJ6mJAq3f9VeHuET5EURp3WH1VAaca3ND99wGvfEZu18lfHFpSeFWevcnkXVjI0yOt6PrRrf6JuCf4D8bBl6Tl7Rv/1xDRR2y97CJA7a+V73uZolyngOBukRW2pM0NRsheT3p8Y8PBMgDRZrPRR5c/G7XBGPhiwT8pszdVg5fy1lMQ1dW+QkGnb7ufXQ3nWq9C9vt60QHyOU9DFL4pvnOFD+CdkJPYGk7ejj9Ewlu83azRuXn9nLH1jKDlzTcXFV2OYzvrf6v69XSTr+jNNc4JQ3k9vhsiN8N3jOJ5S3SMC4NQybsdEoN2uhVBn70YpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R13P9HH40ZhFUyAVEfMxQNlDG8McDwvemPqsO+gk1aM=;
 b=mn+fDoHpx9DTTSPmZMxhn6u3b2OYh+MF2D9L2asd48/gCq0/Y1cFs27WntjTqDt56PDzcZiFREQG4rSUag45LzxrFgv13GaW/i3h8ZNbjXV4iZrAU7v+7lB7z3B+LaR07vjtX0Amsr+KO8wKpG1YrbojoU85AaD0/1ghnpW1KwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Mon, 5 Feb
 2024 16:28:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Mon, 5 Feb 2024
 16:28:16 +0000
Message-ID: <42fd6e46-30c0-439c-b58c-00d8a201560c@amd.com>
Date: Mon, 5 Feb 2024 10:28:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] cpufreq: amd-pstate: remove legacy set_boost
 callback for passive mode
Content-Language: en-US
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com, Borislav.Petkov@amd.com,
 Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1707047943.git.perry.yuan@amd.com>
 <e0746643c781f638c9e9cb8a6d2ceebeeb906f95.1707047943.git.perry.yuan@amd.com>
 <4896392.31r3eYUQgx@natalenko.name>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4896392.31r3eYUQgx@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc0d64b-195e-4b04-a8a1-08dc26677496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JJ3l4lKCX03fNWn0Ls5o+Ow1RRuk3MgfULCf1BIV+V6KqaG64zeRauwAK4Txgo6sENWnEM5wovipch8wtJjQLGp9ycc6Ya1HzwSBRERhESgYxwb7NeEwvD47p6wNKy3WuKMRwKVIoC/LfzKDsC67dCpdMdlLwhF0vFv4FzFW1deDZ9pjNG3QPCwx4a0Ju4baRuMkLfsQaS59wGFN2SylylgB53soTkf8LoI9Op2y7EvkZyYXYdfmHQRPRQV4K8mCFI1rE4AyWvlZqo0lQtOeUbDsHQi3YwTxNxzsXP2uQt7ZdROHqCoBzn2PfO5TPdyWPxrAkkLCqH0tNBVC271vtGSh60pxo9BRFn9JWkLmUiC0PF1SRRgfe5vpEq2E7uJZo6AaNFe+zFc4aSJfgpT8QJraWLqb9O4vnAwJnT0C0CgAhXjURUS3H5y8y07ENPzfoTobqH0a7Rhif3PRv43DzJMU9rXpPfWZkLf4zixMrXBP/99d4fGPsPdNNXjnsSaKRrQrxkoPpM6bANZxV3w1TbjZZ+1CcS+iG4u7yYmkuMTn58xqIflVINe+BkOruMwEGxGBI253iTNwUETyc02+TvsR2i+BlPYT0IXFtM+Ba4NawsWd4Vk6mPiFQMINRVtkWx1qsWhCNkwFUznOotrioA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(44832011)(4326008)(8936002)(8676002)(2906002)(5660300002)(6636002)(316002)(66556008)(66476007)(110136005)(66946007)(478600001)(6486002)(6512007)(6506007)(2616005)(36756003)(53546011)(26005)(66574015)(41300700001)(38100700002)(86362001)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2JBb1pkQVM2QTgyeHpmdkJJUmNWUFBPK3hEMFVWOUhUbzA2SmZPL1hpZXpi?=
 =?utf-8?B?b1NITVVWbmZPU29ZV0lzdTlKMFJhWHpoZmIzU1IxM05MOHFVVFEyRWI4dy8v?=
 =?utf-8?B?cThyclk0czhxaS8rcFVQanBEam1kbkc5dmptN20zOHRTS1UrOVh5UnQxcEND?=
 =?utf-8?B?RUdWSEpQS3M2aXVzUTYwNTRUSWlGc1NjM3d0NURCU3FDZHgzcFZDTHNLdHpJ?=
 =?utf-8?B?QUtzbHVEWmFXRmF6QUJmQ1FSTHJNajlBRlgzb3V5RlBPdGFTa05ySFNQNUNL?=
 =?utf-8?B?d3J3dFJRUzJvY2VUMnhqeHJiMmFkZC9Dd1V0UVBuM3MwMU1oRjkwaFRKaTNZ?=
 =?utf-8?B?OGo0NHZicXV5WnBLK1BBOU5SOGhJdHIvMzR2b2dLVUt6Ty9pcDlsL04xdjV3?=
 =?utf-8?B?TW96NU05SlczY1VIVk0vdXIvNGpjVThXUTdEL2NYOXJkQ2lDclRpbyt1S2NY?=
 =?utf-8?B?Q3BydjJVOHdpdDZpZjhxQzJoa0Z2bHZ5RjdZQ0ZsQXBHSmw2YWlXMFplWFdp?=
 =?utf-8?B?eWw0amYyS1VWK0drWG1GMmpsemNPdHcyYXZxU0xzaFlXQ2RQQVNlVkE4aytI?=
 =?utf-8?B?ekFneFNaVXcrUHdtTE0zWis3dmZYM2RmbFJJUUNHUDBhV3hrNkhWTXBJQ3Rt?=
 =?utf-8?B?RVd2N3J6NlhTQ0ZINy9EalBpV1dEQ0sxYXFBN3pjYUd6R2FIMWhnVzV1WGRy?=
 =?utf-8?B?d2NkZ2VDa0xaWmdYaHFMK0NaNnVQRkI1OVFOSlIwZGxkaTlFT01uKzNwYm9L?=
 =?utf-8?B?V2xNbk5iQnIxbE5aU2ZrNU5Xc1lIWDVJVGc1azNiUWw4N2g4OW9RYS9aczFk?=
 =?utf-8?B?QWVaWjE5TnIzTzc2ZUhlKzdOYVlIZFBiUlpPUlMyQVlvZVMybi9KdlcydVow?=
 =?utf-8?B?MXV0UnpvYWN2cGFvQkZNMjBoS241a3Iwc3BmTW1UTHJJOWxVSzc3RjB2bG9I?=
 =?utf-8?B?Ny82amhEOTg3NEtiUU9iekhqRUdJNnV5UWtES2I0UVkwditndkM3di9XdVly?=
 =?utf-8?B?bTNzbHMwS3R5NnowdExlbjlpenlQS1h3RWl4TGdOZXVpS1RRZGNJai81eDVK?=
 =?utf-8?B?cDNsSGErVnpIT3dBZFpCWlVwKzJnNVRiTnM5bXJkQ3lUU2NMczRPTUtoNE1y?=
 =?utf-8?B?TXdOZWJjUS8rZ3RwSC9xTU9vRHRTRWwvclo1M2dJRGRkN25sMlhzMnZxSGdO?=
 =?utf-8?B?SFlmV1hBS2tST0lLQkhKZWRZMUNPS3cvNnF1VXVWS2EwZVd0T1RaWHVoeXJL?=
 =?utf-8?B?RlJJL3J3R0VoZHdQRWx6M09RbVhoRGdLN0gvK01rYU9JeW1vK2R2UkpnaXdn?=
 =?utf-8?B?QnJSaDJ2TjhyVHdwczRNR25ydnFxVmRsVWp2MHQydE9hbmxpTGVZSlJyd1hG?=
 =?utf-8?B?ZjROeVdJbXVVa3RwRGkrSEMrWFF0N0Jka2k5NVRtcDlrdHp0RFMyWGJJOWZO?=
 =?utf-8?B?QWpraVV2dWJyektvZXRsVjFXVkhTMU5kc0JiallvZjFKV1hhM09xd1o4TXFP?=
 =?utf-8?B?N0lQRW5CYTJoMmJIVkJHdEZidWtsaFRBbGhRaXZ4MFdPR1p4WWY0Q09tMW4y?=
 =?utf-8?B?cytrUlJCdmpveXBkellPbGJscnZwREozdmhRaFIvMTNQRU9iWHpmeThlVlY3?=
 =?utf-8?B?SjhUNWpoVzVqbkR3a1pMTG9TWmNkU2xTQ25GYktwalpQd2ExRDhZbHdRQTg4?=
 =?utf-8?B?aTAyUnkzU2N6ZnhHemhGZUszNGZBdU0yTlp0cFNqZlczWWtJbUV4enhWdzFm?=
 =?utf-8?B?SU00dHRRQUJEM2hMdXBPZ2laWVIvWldaVWkxR3dYVmFPc0RkN0pjaG9Yem1S?=
 =?utf-8?B?bnR3Q29VREhBSUlxdGE3YXRBTk1PdVVjN0tENFBiMUh4Y2JiYjFzaE5OS0NS?=
 =?utf-8?B?VjhzWFdvQWRBTWNGRHZDZ051KzNjM0YzTUdpemNSbWpNMFk2ZkwxbnE2Uzlj?=
 =?utf-8?B?eHVzRW1TSmYxSnV0bXQxWUNrLzROdW4wcERrNkl3cmhieWI5MTFyOG55WTho?=
 =?utf-8?B?ZkkyaTQrWnhqbVZwUm1BSlF2dUk2WFpvcGZsd29OSHY3MFpFNUtPbFhlY3pq?=
 =?utf-8?B?V0hOZTZFenNiVG50azdSa0tTb0hXUmJVRlRWTWR6NjVOVjdWSTNlZEZEUHQr?=
 =?utf-8?Q?FoTheHl+cIECTQ4JZiY4PRxfd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc0d64b-195e-4b04-a8a1-08dc26677496
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 16:28:16.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4SZcN2ZrF2uqRGpNZEW8EUGjWqSi6arYS9jsEfPuYWYiDbWnPTzxsTCgjR1+aTscltiNVhf/TNpeeXzxoEJ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998

On 2/4/2024 08:57, Oleksandr Natalenko wrote:
> Hello.
> 
> On neděle 4. února 2024 13:12:57 CET Perry Yuan wrote:
>> With new freqency boost interface supported, legacy boost control
>> doesn't make sense any more which only support passive mode.
>> so it can remove the legacy set_boost interface from amd-pstate driver
>> in case of there is conflict with new boost control logic.
>>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 1 -
>>   include/linux/amd-pstate.h   | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 02a76b8fb298..4e377efdd4ed 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1492,7 +1492,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>>   	.exit		= amd_pstate_cpu_exit,
>>   	.suspend	= amd_pstate_cpu_suspend,
>>   	.resume		= amd_pstate_cpu_resume,
>> -	.set_boost	= amd_pstate_set_boost,
>>   	.name		= "amd-pstate",
>>   	.attr		= amd_pstate_attr,
>>   };
>> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
>> index 446394f84606..66d939a344b1 100644
>> --- a/include/linux/amd-pstate.h
>> +++ b/include/linux/amd-pstate.h
>> @@ -80,7 +80,6 @@ struct amd_cpudata {
>>   	struct amd_aperf_mperf prev;
>>   
>>   	u64	freq;
>> -	bool	boost_supported;
> 
> This leaves amd_pstate_ut_check_freq() in drivers/cpufreq/amd-pstate-ut.c broken. Likely, the whole `if (cpudata->boost_supported) {` hunk should be removed there too.
> 
> Also, in the header file, there's kernel-doc before `struct amd_cpudata`, where boost_supported is mentioned. It should be removed too then.

Yeah; I though the kernel robot caught this on v1 too.  Make sure you 
run the unit tests at *each* patch so that this code remains bisectable.

> 
>>   
>>   	/* EPP feature related attributes*/
>>   	s16	epp_policy;
>>
> 
> 


