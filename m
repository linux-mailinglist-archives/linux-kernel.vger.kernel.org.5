Return-Path: <linux-kernel+bounces-122437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB0A88F769
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8E71C2576C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D519348CC6;
	Thu, 28 Mar 2024 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GsdEcJrL"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0D40878
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604994; cv=fail; b=vE9x8MzmNCrYBCM9a34ggPTvk3rt4QFZrFzKE2Yx1H54di6fpWDcPTcFzD8WmCySZogcsO6U4ta+rQHTFiz9aXlNf8rPSpuLj2SMBEQ0uRSG8vhBaVAZhxNKp/d/6YllLd/n/BmI02ikp/itSBFxkCSr4opzC8JvsdzVlpvNvfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604994; c=relaxed/simple;
	bh=OT11zYtyVZpOj9ewb6nt9skUaA74Op5HrQV0zxQzM0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eYp4zLD/rmuzzizxy3CRieN3aio3u0ioV1WI4uYEXr8KhSHQs/9fSNPVlysPLMqxt3t9H1WrNDq9wfhehgWw9oHIptdWVa0MZdskLz6A//A6KgJzRl4/Nw6O+DGMpqCoN/k2UQP8P7IslyPkYVua/PTCkoUO2V+PDOYZoSZzFRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GsdEcJrL; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6ja0cUROkWw+YfBc1GtL8aI5jeMgfzYcCOQ7SbqWK8bawXv7BBNLSr5e2D0PAg9MTwxtLCY4dnIkoqqjI1Prp+tSv/oJGJjyxVrMasuw14W+x3/XSSwQTXyUcSZBTi3xXL44PCX+StKiqrM4lNZsgCf0WXSNg7FmZRvvPrQX0n662BYfTgsHAVPfFQJzIcTw2F/4rLfhA3p+8iz6UUEMGKdbo2H/fXNfCAmZ0b+0vfwIEKjFmnzV5EAZV007pzinnyIZoVXMGjh1xT5XteUE1/eHrAYLlYkwnU5hiJsIRagygwh9zDEHw9Qvv/aIUkg+yDvW528DPO3L2862ft58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpfeUPr0I/YaETe9n5IlM0+Ca4a0g9N0BHTw8A9MreM=;
 b=Szt8E6IZbdLHFa/6fUDKDZMRIG6ttuz35MyOoI1v4cVcYL2EqoBIdmZirWU+Aw2KqgsnwTvZiZriXc2W+4vku8YXRlTKiIpKRUtvDhy62EXf4rTNQfNTF08jpv2ySgsCI0RG4e8Efs1IXkc/0wlS+/JQH4a8tvMlB5YEtOAZFHmd3U1jzw0cvMDiIYom9rX+3+dfI4rwTzIPihTFITQYzeZxz9RVX4sSyuTe2sJXNCLR4zyuZ6X8CwdBKeQhA5ibiDRtYlP2z0n8t1emZIcRxNOkxcqnfwPwcPpJaXTQwccgvaWrPfSrHby7vU7SPfzATQ6PImRzPQ/mUsmUXeMIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpfeUPr0I/YaETe9n5IlM0+Ca4a0g9N0BHTw8A9MreM=;
 b=GsdEcJrLOA7DFBEAqUabmMp94Esml013pg1tIEvVFvVHe4KuJWy8XZ4iqydEUxtAdUbWS6nODi60VqIO7HMoP3J8lbwvs5HdJbrbNkAKVzILeHeg3zJuvmHbyROlDXA0fRsLAIFl8Nzl3R/dujvm+WwXRaGUoiqL5dC2G8MZTtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 05:49:50 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 05:49:50 +0000
Message-ID: <dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
Date: Thu, 28 Mar 2024 11:19:40 +0530
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
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017F.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4f) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: b0063099-d9ae-409f-4ccf-08dc4eeae201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fy/EQ5o17EoeMq2lGvJ/nsK7c16DxpM5Y4jRVB2s74ihi9nPx+JLwFlRGHLB5DJ0NDT/zMAvvpmlzZD01gMHtHmMfcwW/l53FqXcJd5tP/IinXcFtsomeu1Y0hYj5Q9lvSuuU1+z11UA8we0y6xKHtpL4gVEjEmxVqLIzUWVXyH3qEsCn9eUaUYxgdzCaVLjSKNcRjMfecshThhQMTiJF4nqj4aeephX/C5ejzieohw01CrQhyispY35oYdzo4XnwR1mL7/Fh3LsxYyLRl0TYgYMMFKOSrC0bxSRrj30YRvsyjGyhdD2vP6zQuJfI0iy0uo5LYFSey1hUH5D46NXFFKLb9Hfw06TvhkfSkjd9NGYOCeSqPbPE57L51FIaeic9/Ua/5ltKZS5MlD5Z3qdeNQ3kvEt0XYuIxlR6VKEiEORzK7516sy4V/ZILRZsZt88hpkxYTUf6E2gP1OQG9bw1E5idOua5G9onP/GUfmXTj1vpqf/ggEIxaGwrsSmJQctrLPI4UCaMMgQ2bMMvr4Hfz04HkNeaOWR1P/IUBaR/GEda+pCIZqizoZvcks/oWLpHf1s5NF5bjIY0WMFcvWgND0a1B0IjlaayO4tDmC9amCRwWMchZVSCI58/ooDkrQgW9HkOEUG3iIja82JrauiQLuW9+ilpWwBo333Hz3ago=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0VIWXdVUktobXVBb0JjYUN2R0hmRWJZVEJIRHhLOTRQQlNKTmk4SlpMWG9j?=
 =?utf-8?B?cU9QaHdHUmNxWHBndkdYNVh0ZVQ2Tk96VzZRVkZ4L2o3V1VxYStUeXBoaEo0?=
 =?utf-8?B?Nnd3dytQOUx2NkxpSDlLM3ViK0lXRGluREZseU9yVEluaGh0OU00M1h2Z1hU?=
 =?utf-8?B?RkxJYmtaN0VPbmNSOE1oNXVVZU9oSGRyMngzK1grd014VVpNNysxd21JZjJO?=
 =?utf-8?B?bGNoYzV6YlVna3BTQ056elBIdmJoV0tkVTlFeFN6enZyblh0UGZIaGV1dEc5?=
 =?utf-8?B?MWRqejlMeGZsaFZWdDA0aTNicXJHNEo2UkEweGZoR1NreENCL0pZTGkyOGkw?=
 =?utf-8?B?MG9DVHY3eC9ZVnNwRGc3RUpuajRaU1FFVXJwMlBXY1h1clNXM3RwT095SnNL?=
 =?utf-8?B?OS9PMmRqUzRRZXp5eVByQ05yeDY4aHZQUldlQUVNajZWZmJzVklZSjdsYnVH?=
 =?utf-8?B?Wkp6SWJUdVY5Q05oZUZ0SkxnblZmOXkzOTArcjVtL1J6SDdyUzNBWkRhQ094?=
 =?utf-8?B?alF4ZjFWZWZqdDBKSWZHbEEzUURFZkNWUWhXZVN3dTRhVUhDVWxnN0xteGRv?=
 =?utf-8?B?RFU0emZvM3BVblU5REloWlRTc1NHZFN4R2txNUJ3aUZLd1BLUENsekVZN3ZZ?=
 =?utf-8?B?WGxQZEpKR0xFZnFRWnh2YlZlaTVIUFlHMFpLcmJRS2h4a0YwaW1VZ093eE84?=
 =?utf-8?B?cFlrN3lwODRFSzBzUXJrUHlzREUwU3FXREU2emhaTThWZk9rTHB3emVid3Zq?=
 =?utf-8?B?T1pPcTVTSmVJWUpYcUlncW9GNlA3UGJpQzdTbnlPaUNxTTlNbGpuRC9ORE55?=
 =?utf-8?B?YThQRC9qSkZHYVpQSElraklhbkUyYkJLZ1hVM3c3aXV6enlja0VQY2RIUity?=
 =?utf-8?B?RVpzRlJ6aVJRdlRnYUhPRE1ONFdiZWhHanJRSFVzMVFSaHlpUnJEVExENVJy?=
 =?utf-8?B?Wjh1QUdpUFJjZDE0d1VURkpwTm9IN1lGSXhDQ3lwd3Y4T0JsSGlCTEs5VzAr?=
 =?utf-8?B?czlYcHlTV0JEaEoweW5raGhMQW95Zng1YTA4Ym9MQTR1ZG1reTlhZW0wWTVZ?=
 =?utf-8?B?ZkJQb04wMHI3L0ZjT2J0NEsrUGN4cVp0eXVNTGprYmswY3ZUN1JEenMyd1Rz?=
 =?utf-8?B?TDR0OU4rUTJDb1JVanhXUDdxWjA0U0QzZE5lQk5YYTdnU0MvSFlrNDduald5?=
 =?utf-8?B?YUVzbFdKd3N4QmZOQUZIT0ZqTmVWTkVLNkk1L2MvN2lZbWtaRXVuYnBNSmlx?=
 =?utf-8?B?ZGNwcGsvYTVQWmZLeUNBdlNCTC9UaXFjamFFelpEMXpkdU9NcGNEL29JcUt6?=
 =?utf-8?B?UE42N284UVlLQzAyeGZ2SWhvamZRUEp3WGtwVmtpUDlmZy9pTTFaa0t4RjhW?=
 =?utf-8?B?WCt3L0dyWVEvTFJyM2hnVmZuREljbnUvR05KOFB6cERlWkcrQ0pjMnBYVTRS?=
 =?utf-8?B?WWgvdmYyeTNVTDVDNVlTT1M0aTQ0dHlUejY3bnFEbThzeUxrUlFVSERxL29F?=
 =?utf-8?B?MDFmVzEyL0lxUHVXekNIQUdQbXVIOSs5WFF3MUVvajVRYXl2N0NkREZvZE9I?=
 =?utf-8?B?ZlRwc3pGT3htdmV1OUxEc1hFUXZSWndHQis4NFdDRGdqQThVM2JsTkhxUnRH?=
 =?utf-8?B?c2RScXkyS00rRXBzUkdJWDcyRVYrVTBlMnFCdXhQUWZ5S3M2azNEK0xzZTUv?=
 =?utf-8?B?RFY3ZkZmWTZJbENjWUdoWWhFNmdzaHBONWprQlpVZWhValZYZ2Nnd1dDeWxF?=
 =?utf-8?B?TnZFSkV2VEhQLzZ5aEtnTXpPL0JzL0d5YjdMK3VPaURuK2FKTU5pRXdiWjcy?=
 =?utf-8?B?a05BZEViRXh4R09oMHpxdWljUzQyQktkYkN6YlFxOFpKOTR4UXZxL05EclZq?=
 =?utf-8?B?RGdGWlJmdHpxcmpxN0REaXduTDdRVFZqem1hTWJtdHhucGlxakpLTHlKMG90?=
 =?utf-8?B?WHpWN0FWaHJ6U1E4UmtsUk03L0NOUGFuSlRQZUE3bFAzM2N2TGtuVTlxb0VH?=
 =?utf-8?B?Q1VZSGZpTnRHZkVnaS84cG13TGlURGNXYytGSG9wb2lIRVQ4bW9Da2dlVDBj?=
 =?utf-8?B?R2tGUzlQb2NSZUJuZHU3SFByd2p6MVVsL0Q1d2lmckYvMTQzYzJhVWNVcytX?=
 =?utf-8?Q?9IwBEv8lGDu/Fj9imHqtWd8KX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0063099-d9ae-409f-4ccf-08dc4eeae201
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 05:49:50.3761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNvpWwdZpEX92/cAaeuqQYDNo2NnbM8+FDwYhMfZhJHzjTNMVCWK6V+JLQWl54ruVBkE/bOjbOy7mrHVrlk7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943

On 28-Mar-24 11:05 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> In order to check how efficiently the existing NUMA balancing
>> based hot page promotion mechanism can detect hot regions and
>> promote pages for workloads with large memory footprints, I
>> wrote and tested a program that allocates huge amount of
>> memory but routinely touches only small parts of it.
>>
>> This microbenchmark provisions memory both on DRAM node and CXL node.
>> It then divides the entire allocated memory into chunks of smaller
>> size and randomly choses a chunk for generating memory accesses.
>> Each chunk is then accessed for a fixed number of iterations to
>> create the notion of hotness. Within each chunk, the individual
>> pages at 4K granularity are again accessed in random fashion.
>>
>> When a chunk is taken up for access in this manner, its pages
>> can either be residing on DRAM or CXL. In the latter case, the NUMA
>> balancing driven hot page promotion logic is expected to detect and
>> promote the hot pages that reside on CXL.
>>
>> The experiment was conducted on a 2P AMD Bergamo system that has
>> CXL as the 3rd node.
>>
>> $ numactl -H
>> available: 3 nodes (0-2)
>> node 0 cpus: 0-127,256-383
>> node 0 size: 128054 MB
>> node 1 cpus: 128-255,384-511
>> node 1 size: 128880 MB
>> node 2 cpus:
>> node 2 size: 129024 MB
>> node distances:
>> node   0   1   2 
>>   0:  10  32  60 
>>   1:  32  10  50 
>>   2:  255  255  10
>>
>> It is seen that number of pages that get promoted is really low and
>> the reason for it happens to be that the NUMA hint fault latency turns
>> out to be much higher than the hot threshold most of the times. Here
>> are a few latency and threshold sample values captured from
>> should_numa_migrate_memory() routine when the benchmark was run:
>>
>> latency	threshold (in ms)
>> 20620	1125
>> 56185	1125
>> 98710	1250
>> 148871	1375
>> 182891	1625
>> 369415	1875
>> 630745	2000
> 
> The access latency of your workload is 20s to 630s, which appears too
> long.  Can you try to increase the range of threshold to deal with that?
> For example,
> 
> echo 100000 > /sys/kernel/debug/sched/numa_balancing/hot_threshold_ms

That of course should help. But I was exploring alternatives where the
notion of hotness can be de-linked from the absolute scanning time to
the extent possible. For large memory workloads where only parts of memory
get accessed at once, the scanning time can lag from the actual access
time significantly as the data above shows. Wondering if such cases can
be addressed without having to be workload-specific.

Regards,
Bharata.

