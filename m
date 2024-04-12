Return-Path: <linux-kernel+bounces-142217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9618A290B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85440B22101
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBBE1CAA1;
	Fri, 12 Apr 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zlz+3DhJ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CCEAC7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909786; cv=fail; b=VAPl/VUWlLWtcA0b76mZvG2b1Wd4DkEnlI0nEPj/1hYf/HlyzIl94jSF4IyxCaELfK9QObfM1B2sDjxvaX1ebRGsg7pba3dN9HLXo7aRqgChYBvIYqZsnmbw7TJbYnEKe69t960Riik8GKTG7QQTVJizTtZZdTfCrJzbTnTPITM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909786; c=relaxed/simple;
	bh=1Wb6yTco6JGQVeT5DD0MYmx4vuChKBriU3M8ssOxAoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GKLxjTxPnhk6r53iUi5qVnMxfFxQcekq1ErpbeU0dcaCzqEPkKQuhR6IjC6k1kjSY/NBpt4BU/KE/si6RoGGYX2fzMAzGaKAYBuNgioheWF8WUP7xCH6wLn2ntnVSowTFuKiuPf+BG0JZmjMarzIntEsfGs2G3lfGUt5mcrvbTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zlz+3DhJ; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaHLHYhvdDiaWaeWjSlqh5trwn5eG9NWWwhXV7ISaNkH1dY94aNSRx7HyMM6Z/rxZx+63adIn4O7ZUmRVLo9xh8SxveNZL/tD6GMc8jYRwtOEHLO9No2jyEQ5aiomh20Q6vm19+WqPOK2Aui5yBfuKiwPMEFZHgZNAaDmaz0C1SAzQClpyJWwUj/b9bijdem3qPTqSvVLf8HqWfDvMnCZqG6qUwDyWqKiICtIa7K/TaQn875DsrkW+ymRH7v+qrCsOsaf63Bc5CnY9X5Mkk1UNbWfKz4sCB5FPY/ZUZp8skSka56kHzfISKaBYdtW9sV0UCzkG4lbBG6ll7O2rde/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxqYwrsoaYRLeksbIuOGTcFlgZc0N4LWJJPTfPMneEY=;
 b=R8KCtLMqqXgKU1D9wISoQrgfoD0NwFElIPo/CFMXRaJN4qBosbE0RzetK7zFwR0PL4SbUhc56VH+fqr4GhsnGugIFoqzqPBZP/QCvcQXBh8mdffi3RC9uX2sQDaCav2KjA8GCv7jxu4CNywcwvnkYzlMghXxFpFQvrQJRg6v6cGbAtKkdi9ABxa7Gmo2Jkf9/1KhTAc6oCl1hqLCt7MV4Req+MacmWJ1OpdFcjFoa8cSIU17j+/uCHxSrTTsbjLJl/eKjAuBr556PlApV6NgYd2csr0pvl5tfCQ5B7h7CZfvWJWd4ZTfqhjvlzZieQc7d9jDdP8/avG06nygtvbWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxqYwrsoaYRLeksbIuOGTcFlgZc0N4LWJJPTfPMneEY=;
 b=Zlz+3DhJ3M9/LK2jsacNHs6FCM3a17wrr+TvECo5detKKg0qlPQ22c8Zszi75bxfJogsoexpxmwTqVR5xbZpJw2eVSXLGjd4L3tsMaJQ6WerUY2apAC9p9BX3bjHMCGRI9lyTn94199fI9HV4HW2uqod8QFM3KlIVUMaYES/D+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:16:21 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 08:16:21 +0000
Message-ID: <8b073658-268d-4d3e-bd94-3fe95c948bd9@amd.com>
Date: Fri, 12 Apr 2024 13:46:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large address
 space
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
 mgorman@techsingularity.net, raghavendra.kt@amd.com,
 dave.hansen@linux.intel.com, hannes@cmpxchg.org
References: <20240327160237.2355-1-bharata@amd.com>
 <87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
 <87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com>
 <875xx5lu05.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <7e373c71-b2dc-4ae4-9746-c840f2a513a5@amd.com>
 <87o7asfrm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <9ec3b04b-bde8-42ce-be1b-34f7d8e6762d@amd.com>
 <87il0yet4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <8692d514-d1c8-4fbf-84d7-1ad609480070@amd.com>
 <87cyqv59bj.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <87cyqv59bj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 7806f466-3b8e-43b3-bfa7-08dc5ac8d5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pR6YFoiwJQBLPkXSbOIkdimk08ir7KuE+E6KkBnNXSX2WVgkeVGbJ3cxpY3y+fIhVFJzTQTe27NLznPKiHa+pXV6QiZqQvzeFFJ5FpNQSRx+d5SRpa8IxKFeVsAog46bmYnDy5qJne8l/jU3N9aHkK7I4R8KQ3pQTqQRi3YHlkHl+MgBbMnGr/AfL5KvXg9AFkuWHHFD5E64SzIa8noGbeTUb/PriUqMZpLWUV3QkeqzMngQS9wKjLYmDKK9mbIK57tBuWPq95g9qT36VfRv+G00vN8WElPHeO3WJtENa0SDFiT8qo9NKhm6nCenjElC4+xOx3mEIj8Aabyqd8mDwVzOihIa3kK5I23YN2b+C8HpbG7oZmpiU/hSmKpA9++cIEs1fs/ZMbjLvxbtsDstyHfpvVaFOpBJ8MM/nSe/ouOs3M8/zi4VqCBFZGDIcgVM8QlVv77xoQ821Lrfq5multKLgwkuCR+Zz9XVsrwb/Q7o5g5rdp4LHlaOxCdDJFV1VETTIi2d6TXAgPY6I+sjBUyBKQukC9Hrp+0bHM2is4iV6sUKS/tD63CU8DGIZU9DI8GWun8xOQNYBgyWQoKOw8pRoIlqrk5Gzmy42eLy+nclvBXYfEyWIdqCSid3sIDIxRHzmqb0sg/4H8XKCt1E8jjbDZ6MCgKNh425HjCjlQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjNQdDVmbkVhMHBEQ3JQT0lSdEh4d2w5a1hWb20rR08zZ2thZzJRK0JTQkFG?=
 =?utf-8?B?THAxdEdFcC9TbXdpSEpVb2Z2Umcwd254M2FZUUFsUWg3WTJTcS82RkJKZzlp?=
 =?utf-8?B?NHZka2wvTTBYV1M0YXhMSVpjOVR5c0pCeXhJaExCVVpkN3l4ZnZISGdzUXhu?=
 =?utf-8?B?elkrdXVHd2wzTmJwanpsUjNmamF5YzlhUTdJYW94aEhuSXVIYktLT3d2V29l?=
 =?utf-8?B?OFhMZGdabzF2STBJZEpNQ0xvaDhVQzIveHkzOSsxbFJSemlEWS9FT3BVbUI3?=
 =?utf-8?B?elk2dWhVTTZEUDgxU2dBQzFJZzFub25ZWGlXM3dsZm5zNVU3UmRvWUdhcTFT?=
 =?utf-8?B?MHBDUG1FYTFlRTJYL29OakVkQis3cCsxQVFJUmNtQzZUdGdOWnFQei9IZXJy?=
 =?utf-8?B?RFJLRFVPcUc4RVJZck5UVldMS2g1UGpiN0NrS21sa2I5TXlMUXVvQW41SDAz?=
 =?utf-8?B?Q3FkNSt0eEI4VGxTdFVTU0U1QlV4WG92QmFCeFZMMDI2YkFJVW1wSVBVM3ln?=
 =?utf-8?B?T2tDdDlqdHhSeHJMYzJneElZT2xhcTBSczh6QW5JczZxYWVEK2FMeWNQbVJ1?=
 =?utf-8?B?bTFaU1lSRFNzdlVCTTliMHcyQ1ZTektpVElXSW9mY05ieXZXQllLSnhlUkpT?=
 =?utf-8?B?dzNEaDYyOXZZZ01LUG91N01FUlJ6OFlqdkhIdHY5NzltUGhWV290bmNIa3BB?=
 =?utf-8?B?M29LWDR2azVrTGlZa01pOEJaaUdMZjBGSFpwTHZGOTd2WGZYZWFBOEtXQlpT?=
 =?utf-8?B?bUw2WjVTSWI4SFRmeVRjZi9uR3JnbkEwSGFNNzgzb3ZPdUg2MUtvUzN5aThJ?=
 =?utf-8?B?RFZBZXFXWVRsS09tOENhTU5sZzRGOUplaWk0bjBiQWN6QVE1S05pc0ZZbkV2?=
 =?utf-8?B?WisxQm10dm0razdLckYrMXNPZk5kQlBzcngrTzhhdzBqdzZkSDN3akpCd1lG?=
 =?utf-8?B?Y2pnNjZaVTJteHE5ejR5NURnZ0hIeWRReXFUMnNVVlU2UTdWQWVoY0VFWnBt?=
 =?utf-8?B?SzVlUDR1K1lKRWJVblVQU1N2bTlINHZpc0ZtMDlWRGRYUktnRWdSNElDdDJM?=
 =?utf-8?B?L1BpSUNZUlZlL0N0c1dQMjdBK0pqa1F1cXorQytiWklrU2pUUExvVjdVckht?=
 =?utf-8?B?QjdZTnpKV0xVeDRJdEhjV2hYRzZSWmEwNlNRTXFLakdXWDcyN0hudHhqYmpz?=
 =?utf-8?B?NUw5R2lQZ2dhWHI1L3ZCSFRPbHZnQ0FjZWtJT290RkdtZmw1RGVtajRROVN6?=
 =?utf-8?B?U21FNUR6aVFyMEhkcE5aNnZOcmdwV0ZkQ1NXejQ2Z1ZtRUR1OEFaaTJ6QjNm?=
 =?utf-8?B?UHY0dk1BVkYreFpOOS8wQ0Z3aE5lb1pKZm1GSHlHUnFnYVlmZTM3UHE1TzhP?=
 =?utf-8?B?L1dGSEdoOW9wVXBDU0h4UXRUeVBJY0ZiSE9FVVd1cEZyUFRjSFh3SEgwWWZ3?=
 =?utf-8?B?c0FZN0hJMGIraDhLSUV5VVVoNWQrdHFFQkJiWjU0aDAwdWw0UEcweVpUdDYy?=
 =?utf-8?B?WXhNS0l0VXlPVGR6YUgyNkhXT2tnUHpiYzFJNjJ3L1JaMnFWUHdLNWNRcWlw?=
 =?utf-8?B?Qjhhdm9tQ0tUYU1aeTFqRWJwb3dGQTF3UmtyejJIenRsMHJydVlqUEI0dzls?=
 =?utf-8?B?Q3o5VitVTnlmVmt4ckF4VFBlU0lFM2lUODBhclFwZkNYR3k3RFdwR1Bob2Yw?=
 =?utf-8?B?R24wdTVGR0RoYmNXa3NoYnFpOHZQeXRCRGJzRTZ6THZyTy9VTTBZUEo2M2RC?=
 =?utf-8?B?SmZ3ZklhOWlkQ3h1blFiMjNmbjlRMTJnd3FVNlRIZnVYL0xTVUpoUDhwazRH?=
 =?utf-8?B?MmJLZ25ya3FTTzZrUHlTUTV1ZFI2SnZ6RlY3TVlRUlNMb3RhcVJtZThYN2Nv?=
 =?utf-8?B?d2JSZE9EaVJxUjlPR21QZmsyL1lmNHNDdHlrN0xwR2VVaHZETFMwbU9MSEdV?=
 =?utf-8?B?SzRla3hNYkFhRFI3OHBpTncwZ1NkRUc4QVR3RkF4Y25DQU5ackprZnkrSEla?=
 =?utf-8?B?NGNZbjNzUDJ5Ylo4SjV6R2xMaDF1TnFYRDNDUHZYLzdlOUFJTTdHaVF4c2cz?=
 =?utf-8?B?OVJ5anBFZUhMU0lqbTc0YmlqWDMyOFp0OHVNK20wUGFxSUQxcTl0SjlGRDZn?=
 =?utf-8?Q?l87ADqr4GMWpiCdkpWrzkSKP6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7806f466-3b8e-43b3-bfa7-08dc5ac8d5d4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:16:21.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSLj9JJHYgL+RrjcxjBob2tQHTM1qbyGENyilErObgkcIY2e8N3YYXdUzvj/EMDgY5XoXQ+XkAwBW76iNy2ucw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581

On 12-Apr-24 12:58 PM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> On 03-Apr-24 2:10 PM, Huang, Ying wrote:
>>>> Here are the numbers for the 192nd chunk:
>>>>
>>>> Each iteration of 262144 random accesses takes around ~10ms
>>>> 512 such iterations are taking ~5s
>>>> numa_scan_seq is 16 when this chunk is accessed.
>>>> And no page promotions were done from this chunk. All the
>>>> time should_numa_migrate_memory() found the NUMA hint fault
>>>> latency to be higher than threshold.
>>>>
>>>> Are these time periods considered too short for the pages
>>>> to be detected as hot and promoted?
>>>
>>> Yes.  I think so.  This is burst accessing, not repeated accessing.
>>> IIUC, NUMA balancing based promotion only works for repeated accessing
>>> for long time, for example, >100s.
>>
>> Hmm... When a page is accessed 512 times over a period of 5s and it is
>> still not detected as hot. This is understandable if fresh scanning couldn't
>> be done as the accesses were bursty and hence they couldn't be captured via
>> NUMA hint faults. But here the access captured via hint fault is being rejected
>> as not hot because the scanning was done a while back. But I do see the challenge
>> here since we depend on scanning time to obtain the frequency-of-access metric.
> 
> Consider some pages that will be accessed once every 1 hour, should we
> consider it hot or not?  Will your proposed method deal with that
> correctly?

The proposed method removes the absolute time as a factor for the decision and instead
relies on the number of hint faults that have occurred since that page was scanned last.
As long as there are enough hint faults happening in that 1 hour (which means a lot many
other accesses have been captured in that 1 hour), that page shouldn't be considered as
hot. You did mention earlier about hint fault rate varying a lot and one thing I haven't
tried yet is to vary the fault threshold based on current or historical fault rate.

Regards,
Bharata.

