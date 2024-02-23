Return-Path: <linux-kernel+bounces-77788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A5860A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEBF1F262B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90D612B98;
	Fri, 23 Feb 2024 05:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0dinZR5R"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83612B6A;
	Fri, 23 Feb 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666109; cv=fail; b=K8BOUJ1P+DpBMLg/rXzpU5Hqh9SRgXqQYhwqArncfP55F1+BN1u+E6S517uBE9SxrBVikoiAA5UfOW37gAH+vrEy19vAiCidHmk+DIt8D5ksCq4vb87RUtXM1jhNeOtRvj7FzKqkEkOFta4Uo9r4F7a+RmxIh3kzpt9n0c6pXkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666109; c=relaxed/simple;
	bh=5iSlbuuXkhyr1zymTfMiv7um6qdrrRfeF7JJPih/Vek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qsjFhEQddNybaS85oMo67FVJxeWMcTZDk3E66bYD1USwRusmehKZaGr8GJzq9KiHWSQYB0vUIBW+nvOWmIxzHsWUFxY5xXpJ4O6jjq7vT0TsAy8HiCL4CvAeeX6czVMa0HU1NliD/n95DUITmhebhnjaTFdIrT4Ccaj7/FFd+c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0dinZR5R; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eM6Og9OJNejf/KB5/hZhVsUXdV/EtL6PKGhDLiyWBGdQFZijv4EEAZiPqThiUsE1FvTMWSKYirip65VL6dWFX5nKmbmKldnxbV4BD4K+MRkzqhEevzuR/4b9qLW910hypp7Ar2ciwMPYWBudbq6MW0/wr0jd8vq9zARcNhfw0IrkcHZrDy5hgpzntjcqR77gK0NFNAOM2zGSmRCBrSkqVu1gcM5KAUzL44XPb3TMJQ8GXNeDB48FgCzkg0UK6gVZSMpYxBqwSsNtADiTP63FlU8rnWrxEvpSap08rUNnLk7Y0ULaJ4IZ/fXaFNTwfb6fV1x7VxQJLX76UnOuDKozvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqweaaNCghEjXaDOWqKmW/Muo0LDshI2lo+cvrKoHwY=;
 b=lp0Ntk/LiL57xAFCiIGwZZ1HwcJ5TInRdlM0V1ccVChHwBB2HCgzRUAlmSOQiMNdbHiwzQF807fOxChcrKF96s6xJibYevB+BUV665D8JycRPJX//yzqgmSCPMj1P+2Sr/4KJuWGYsgzGX6sOkpw/qXtSnoLQesbvR0Njpyd+rn19WzCesRUxHlJyE3iU1G4p1uBs8QumE4YskYc3s6lYLczDuopC928+4KjAf1EgVlgNM0oXaPeWy5k8gt9d5rU9ydKuDSykacATLekBf+FlebBarYekeZcCSKW800VfpCBRFODmDhk+/x2zJTi81aT2WwPZsfBzt2tI0OXIxo7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqweaaNCghEjXaDOWqKmW/Muo0LDshI2lo+cvrKoHwY=;
 b=0dinZR5RlyIiH7D5tIWNXjkSoHXTEKIZBwtJvV6AfJJcs+1C1VIwyQerSftR9/QNEvqXnGrnchtLRYAeBhfj1Kp/DoD6vBCFCAsWpqt3M9jQMRsVlQ9aafWf6PZZmdEx8ZsBEK1PNqQTXov/gt/0rUWpzjnX1gQGp7lZiNy+H/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 05:28:25 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::8821:95b3:123:fabf]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::8821:95b3:123:fabf%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 05:28:25 +0000
Message-ID: <9eeb2273-9690-8f71-4f3f-595310d53600@amd.com>
Date: Fri, 23 Feb 2024 10:57:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/4] perf/core: Rework forwarding of {task|cpu}-clock
 events
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: peterz@infradead.org, namhyung@kernel.org, eranian@google.com,
 acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
 bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
 maddy@linux.ibm.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, sandipan.das@amd.com, ananth.narayan@amd.com,
 santosh.shukla@amd.com, lkp@intel.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-2-ravi.bangoria@amd.com>
 <ZdRluZx3fy0xx78D@xpf.sh.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZdRluZx3fy0xx78D@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 744797a0-c3df-46c4-52c7-08dc34304237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kmxs6TBT6dV/9xAdQT9LXJeP/qZfWCnWTZ/EURk6ldeQrwxcONba4yvaZcfE9OlqPMHqUhJToPUZwubkvjymEUBUu+mXQ3ICl88UYPEuinv0eF0YZwjb4bTMuNXgSpNJy7Ss25OyJgZNEG/1xfvhbepGUpdU3NEGtwT3+Xdawnzops7N7qTL0dFbKYMBiToeZLaWqvcyKB8MvyosP/ULA4jf3TAOlHwgyhL8bVjqplXYLhusdjpZXbh8jpxw1QrSngu6hHBa7szYlseSI8MhQAPfLl1ho8A3qEleJTBLMSUPSpj8GlrDwSHz8uxKpns9qBui+5GqjBU871jibRx6RjDfU0lZsDAI7y7N7lenEKPpq4mEFB/lpyklPGMD5O7B4bZE0hBVJODnGulsydTc42smus3VB+7AlN42xiIpSkHPTdXQA8qOHCGl14BimVQopbB7qZJC8TJb1U9yJBT+MNKVY3DvKQWUrrnSonnGNnGx1Q73qNjnBcfIzMua3ft0ZhmnUz1IeFfpBoN9Kwb/ey9gjOw8Hpoqhl9GXAqpbBw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzl5SWNGYWtNQUZrVjQ0azBpRHVhSVRHNSt5SVBUSERudjZNVGw1eWVnc1Zq?=
 =?utf-8?B?cVVvbm1wakZzdDV6bFBUMTV5WE01aWVqK2c2QllLZ3pQVVhWU085RHRPSmJN?=
 =?utf-8?B?V3RWZmxXNnV1cUVCY2RJUUw4REI0ZHRab1hOVTkxaVFNSzFGTE5Tc0JWN3Ix?=
 =?utf-8?B?enplTDliMENwalU3Ry8zVTFuTkRNSHJMa2h3aTEzU3QzRFQxN2RWbHZqQUVj?=
 =?utf-8?B?c1pPVEdXYjN3YTc3RFRvMnA1aWtkR0Q0cDFDU2Y4QXlwaSs1Vjk1NWsvQUxx?=
 =?utf-8?B?OWZ6UnNNRkJib3liVXplc2dxUXlza25pVnBVVGRCTGxMZHdTTjR5ZFZIR2N2?=
 =?utf-8?B?YUVWaGpDbVBDdHN4ZkducVp2ekI2OFp3cWlMSXNmMyswcTNEUFZYa1grWm5x?=
 =?utf-8?B?ZDZ2QnJ5TlJ1ZFJkNWd2ajNudlhPQlZCc3Q0bXhEZ3JKd1Q0TmdkK2tLQmNk?=
 =?utf-8?B?a0ExLy9LZ2xzbk9zZzYvYU1nYVpEWExXWm52bEJDSDJ3U2dMK0kyU2lFY0Iy?=
 =?utf-8?B?Wkd6ZG5wb0Z3d1RES0NZZmNpY3BpdGlWZ2svQWNTTFRHR0NsZVA5QTIvTGlR?=
 =?utf-8?B?V2syRzgyTWFackMvb1dQRk1IRHlqUXJYRVk3alhwU0xwMkp5UXpLWlBSRWxw?=
 =?utf-8?B?aExvQVd2TGlsVWJwR2lyR2s2aVRpNitIOGx5OHkyWk9JUGNjMGg2Qnd3aDU5?=
 =?utf-8?B?dk4vb2lYcFFVL3FFelNvUFJQQlN3OVRPTHBPU3NMUXlyNWdXTG9EREIzVWVl?=
 =?utf-8?B?ZE5VN0wweHZ5RVZiNThORDgySnc0Tm84SU1EQjhnRzZNTjlRRkJhQTRGWVR5?=
 =?utf-8?B?cVhYaHlmMmRZWFR2aS8vbFNHNEZ4c3JzV3hMcGJvd0d5QjZlOXdHbEVGQzk0?=
 =?utf-8?B?VWxyWlFzTWxMQU5vRU9RUmkraVM2VjRqdzZPcy9wZWdlbnZqZ3FuZTlWei9Y?=
 =?utf-8?B?OU0zRTVtUlBmQk14NVBWeW1ybkJnNEZmYzdEWDI0dHgzOXJGZ25RVnBtYi8z?=
 =?utf-8?B?RFo4ZEdvaER5MVp2cWRGOFlmWVBDV2lpdkFNZzVyRnRPYnQ1M25zN21YTkU5?=
 =?utf-8?B?NnVObVJkNTRlWGpEN1FnVmdJQWpaOW5TUGxhcUFrekhzZm5McldsUXBXQ0Z2?=
 =?utf-8?B?RHQ0Qnlmbmt3by9kajZXK1dIZVllYXFVdjZrSUhEdmVkK0RuRjJ0amp5UExW?=
 =?utf-8?B?RnFZNGhzMFJpTkdyTFNad1Y2MlgvZWZUelE4clFWRnB5cDhhNGVYT0N0cHVK?=
 =?utf-8?B?MWVxbnZWbkNPUlptUThhVGZ2R1YwbmVkOHc0dVdLSTI3T21JZW04bDR2d1ZT?=
 =?utf-8?B?V0ZVYzRsRlY3WnF4OFROZnpudHR6SkJaSi8wRFhENnRMSTFTT0taNDRyUFRJ?=
 =?utf-8?B?MW5iN0VXb1gvYms4TUd6bTQ5b25kVlBWSkVZU1FGU1dVRitkMTJPS3JQZllH?=
 =?utf-8?B?N1JwZTEyb0hWZ2h5Vk13ekc1TzRVWjZXZm1tZytLR3RGU2p4U3hCcVB3eERn?=
 =?utf-8?B?ZUs2L05QRFQ2WGNpaW9sT2R3cjU3elQwVC9hOWJ2WmJRTFo2SUR2bS9TKzhx?=
 =?utf-8?B?a3gwcCt0aGlUSHhhZ3VsK3dkbU9BcXhUQ2ZMYk9VbEYzNXlXSXQ1dFdIcUJh?=
 =?utf-8?B?N3k2SXNWc2xmenljMHNIb1BSd3QrL2Q5UUFFaE1CK2ZPT0NRWC9JTloyRzhn?=
 =?utf-8?B?VE83ajFQaWxpcCtDbVFmdE5oYUFBaVdUeFE3ZW0vSXRmUG5oREZDNk5QNFpF?=
 =?utf-8?B?ZGlSZGFyS2toc3pwM1FZcGt2bVZEdVdFN0E2cXY2QXZrclE2bnZIYWF2YklO?=
 =?utf-8?B?bytpMmIybGtuQ3JyYzVZZ2t1dkc3SE9pQVVtd2M4WVNUb1pMNTV5MWZqMHFN?=
 =?utf-8?B?VmVwNnpGdk5DUEJpUFpKU1lZQVQ0MytLWk9hNjZkTVZXbncyUDZjd1VqMjhN?=
 =?utf-8?B?Qk1LSDFHZUR1em1iYlVuU2hiRTJ5K1R1WW5zd1VCNy91Vis2NjJvbWhxWk1P?=
 =?utf-8?B?S2Y0RHFtK1dQbEJ4NlI2ZTlTeWFpUzNpZVA1dGU2MW1VZVJUWEJzUWpwUWVD?=
 =?utf-8?B?TEd5UmVxRGtNQXg0dWRCRkR5dkliS3dxdEtxSkFrTjJTK1BWaEJXeW53WFpo?=
 =?utf-8?Q?nRGJaFnJjMwtR5reinclLaN3h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744797a0-c3df-46c4-52c7-08dc34304237
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 05:28:25.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAtC8ZlTrMrMs/jR8UUMVZ+URsrnhcdZaWacbZPoqEXpmwc7g+L4w404owlnOLK6krsHj3J/uA1aaEKlK0QoMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454

Hi Pengfei,

On 20-Feb-24 2:11 PM, Pengfei Xu wrote:
> Hi Ravi Bangoria,
> 
> On 2023-05-04 at 16:30:00 +0530, Ravi Bangoria wrote:
>> Currently, PERF_TYPE_SOFTWARE is treated specially since task-clock and
>> cpu-clock events are interfaced through it but internally gets forwarded
>> to their own pmus.
>>
>> Rework this by overwriting event->attr.type in perf_swevent_init() which
>> will cause perf_init_event() to retry with updated type and event will
>> automatically get forwarded to right pmu. With the change, SW pmu no
>> longer needs to be treated specially and can be included in 'pmu_idr'
>> list.
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  include/linux/perf_event.h | 10 +++++
>>  kernel/events/core.c       | 77 ++++++++++++++++++++------------------
>>  2 files changed, 51 insertions(+), 36 deletions(-)
> 
> Greeting!
> There is task hung in perf_tp_event_init in v6.8-rc4 in guest.

Thanks for the bug report. I'm able to reproduce it. Will try to spend
more time to rootcause it.

Thanks,
Ravi

