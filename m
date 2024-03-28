Return-Path: <linux-kernel+bounces-122462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF7588F7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C7F1C241A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F055A4F1FA;
	Thu, 28 Mar 2024 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1yEvhhaa"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C118646
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711607368; cv=fail; b=FpWFCepnOTPHVfK9oavhvz8hWwXSpomK4mP1s7buHTjAspP1fywFFhAvQhlMQkV1yBtkma1XKu+ApQEjw6fBOTLmiV4M5Q4KDJrArr/1PBkjpe2kgAIkmgukByL36kPc78UT0Hno2gmI0Ce5nHLhjZvtPdGPfH/GhZmocgZU2yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711607368; c=relaxed/simple;
	bh=M47nZb/5OymUvKjQ1Z+S0WSQ+T86VVl3ydsX46bbhk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r9ZzzjV7AWNjLABXceFCcl3iWH+MsEjJfW0bodzS/jXjQlfbmgRdlmDxZA76fQtOj78uvsnMKM7gPaD0ip23Y0T36szvMaleDQjcC0xtmwbzHObaQhsvgQQ7Zu8qQFHR90KXoYYCTwGb7CRazUho/GX23FXH2ehcTAAJS6tO2sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1yEvhhaa; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2JBNqgPfSf7sqw6NvVhO2UlRicM7BZq9UltO5T7odVOWpRJrvEv+2OTNMT6V7uZRdBHect2uuIhxdFqiKYtkG0vks/so6I65onRFCLzbdDEfWMU58wp56bb8PRxTGURWg/MZGd3tISOV2BEpP4o9VH3AOOaubd9WOYZUFn00nMRmTtR5C87jujrfvfOf1vwglkGeYCMpjagihHEF6AcK7SqvZGjfaYeM08vPxuAQXLur9j0qhLbyJkg4TyzKnpxb3lsAV62iFUy/IYiM13z+mGFZauu3Cwz4PjBYibvcNdFZFaBd9BOMKjHPj03jBA/PPCklzhWA8wMdQIRRIWpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irSP4JuuOIqFSja106ORSFzLPP4f4faE+SrMscTr+kg=;
 b=Gfe5CUQ604cqZsC33q8Vz/7dAjwXg5yz9Yn8WN0J6KIM/HXy2vypWqiDnrptWGfwcr/QYnmR20qG6hseeoh5dB/iEqpz7aHgjPxp20V9n5vUwyQhBlW79BT7B18bAardfrIxj1TzZ/hw6dR6kseWiBuBAQ4nnGWwcAWwoWEMZKvG5beZIXnRr8tCuvYUY/XRJ7Gikjc9zyTIwjjL1668OQ5Kz8LcXSEjI/eafYBZBsbPc4lXnmeKR0vVFB8qhidbOqafpdC8zNLGV8WoQE0q2BYMZuAXmom1hryJ4ICI8WbXLTgrqmcigsAzks/kOFwQNhfw7TD/FPl2dQACNukHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irSP4JuuOIqFSja106ORSFzLPP4f4faE+SrMscTr+kg=;
 b=1yEvhhaafFgAM23R+3XbD94mbsTdAB/q546rvm+Pwg7Tg7lEARpWdciFjXoQTl1a45lS9eAErZ4Tpnq2v5JI9lP1iW4sw/0WY2cj9KVrMDY37gVddUIpIZp1K8mNWjUeyuEksrO6S6y8op7ZeYoLhXj05xjGJXJwNwspMIYnUtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 06:29:24 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 06:29:24 +0000
Message-ID: <929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com>
Date: Thu, 28 Mar 2024 11:59:15 +0530
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
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::11) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 088503a9-6c65-40c5-df9a-08dc4ef068d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uyrd6jQPLvohBZoOyjXmT1WEtzTE30SAKi6+WAbX+x034wg6hsARDTu8UWJCHDH3Q8nTb7cmctNLIoFQ5cb+AtNzfnU/2QOc0IaNZxKBPPYOLL0q9sJz2TZzlWekkci932sZyqSy2uW9oxfG15U6GwytlAhD5kwreYmRMdZBnC19y68oQd02Avv6FZpUfcp0y4JT5sXM0WiAevuG7Xe1JuxlK1/F6GmZOR3jtY2DUR4z4IRTrfMI4M876vtebafdulu9aax82xRyQKlMLIpzN1Bg8qOZHBPeqJb9bZANZHU971rEDvwh3I2s2gI3fzCUAsCCT2KlLpuCNyWrmi8HUryT0Ln7HySqk3VCzBSQURZTwPVNFAmgBWDbtf4VinwwZMWQ1Vqh8YdSiVnMfPV8b76dRL6D8f8OfQrdezG89C+vlPPKviuuZW1bsrBzCSVC8QyYxqiegdLHo4O3HUE4PfhqlJMQBDA3xqhXPRbNOdCJyQ5auGsdpxA9boNI9C3tAP/i12S6ezpnNo2qf5WIhmWjEJ3WWSIJFB1uh0JoWkMuLPnFR4+TZFXy7kwTkaVCIVB8LxCB7Q3vwrTIuFXXQVjeEQ+hK4422FlDW1wR/F6WpJ0r7jW9nrTHqtBGjqmoAc3P4WediQ0Yi31yhiDutm0wsmoLc5233c+CpTXmYpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBpU1NQSnBZK2pQR1BWZ0hyVWE4UUdQMFdKcjlkZlVScVBIdXpCTkpjTklQ?=
 =?utf-8?B?alFiS1JpN1ZSeWZzN2l5L3VkTnRjZTRwbkhOSXBqWDhRbWxYYWFGVUhvQ29M?=
 =?utf-8?B?R0tMMDI1enNkUEx3b1Bjbkd3RlVnN1VUYUFIQW5hV21jZExZVklTSEZQME5O?=
 =?utf-8?B?SDJVTTlXRG1jaStvMDhtVnF4K0tFUVpXTXdXK251M3N1dURtTGp0NzhpOWlL?=
 =?utf-8?B?ZFhqUXZoMXZ5TXVibURoQ2hwM3p1bjVrY01YckdabFhzOG1uVEppOFBhcGtQ?=
 =?utf-8?B?L1hZYW1zU0J5b2hnbXVkMHRicERTcVFXNXlPRjVGZitzK2Ric3lkcE0rTDNJ?=
 =?utf-8?B?VnpTSnpUcythM1kxOG52V2x4Yk5iT0Q1blViakhqQVZCMENsZm9ZU3BsTXQ4?=
 =?utf-8?B?M2V3WEkwMGlzSjAxSHVuU3VUbW1VUnZnUm4yc0srcG5tRlBoalF0dG1DdE9s?=
 =?utf-8?B?TVVwZ214N2ZoNDJiWldNYTdJblZkU1lrNnY0UjI1R00vKzRyanU3ZUFvbmhw?=
 =?utf-8?B?a0I4c09SWjlqY1loME1UbW9nRTBKUENJcC9WSndBdU9VVXlyQVhYejhnbFhF?=
 =?utf-8?B?TlFqbkpkYWRHTzhVekZJYlJWZ0dQN3NnK1JGZ1prL05lTU9UYzhSMHNGWHNS?=
 =?utf-8?B?SkVFdnNiMnhQYTJQWldWOUw0SWY5VWFXZllUTWRic2prOWVtcjJHZGZQc0Vs?=
 =?utf-8?B?UElmckZreHk3S1VaY0MwTnprcEV5S3ppK0xHRUc4MkVORGd0UncvNll2bjEr?=
 =?utf-8?B?TkMrVGFtYTVYTHVwdWRGOWlsUzR5cWtzQVpFR2pabGNUYnJOd1R4WC9vaHFy?=
 =?utf-8?B?Q3E0THg5T3k5RjRacExHTFFsaUJVSDlWUWRCMUtYcjQzeHJhVzFqdnhWMktD?=
 =?utf-8?B?YVVZa0RhWkxKZU1IRWw2MUgwR1JSdUdPaEFrR2o4YmYzcWVObE9kOXJsYW5r?=
 =?utf-8?B?alE3dlB4bGI5NUU3Zkw3VVEzUkNxK25COGR6d0tXWjkxbnZ1bTd1NmNyR29H?=
 =?utf-8?B?TkN6Njg5d0kyTkJJRm1GRlIvdWRHN2xEQkROTi9HNEFmdERDR0hmK1RYMVZ1?=
 =?utf-8?B?WC8wUGN6WFpFY0EyQWlmenNvQWk0cFFVWlFEWEhvTVgwazczVjN0cDRQRjJP?=
 =?utf-8?B?ZGlTV1VMcjhZMXpveTJkbEc1ZjlEMWVEYVRiRlhVbmdGbTFUM1gwU2lUVzdK?=
 =?utf-8?B?M2pmM3FJYXppT3JDNFVIYlA3bXBubk1OVlZlY0RCc1ducVRaelNVTGNJRXhQ?=
 =?utf-8?B?TTRRTTQ1aTdHQy9WR3JNZkFkYjF5clNWQ1hVMmpLYm81cVFTMGVVMkRrWHd2?=
 =?utf-8?B?MU9FTHRRU05Cekh2NDNzdElOYVhGbHprN1hERTROOXJGVithNW1jeWlkcWY2?=
 =?utf-8?B?VGZxVzZJTUE4a2RxenRjdGVxUmVMSERiclJ1T3E1K1BJVjNnS2pxRUIxblJH?=
 =?utf-8?B?MGNidU1Oay9iQzBEODUyOVovT0R1TXRhcVRCTDR3RnhsL2J0N3VtYmNpZlR2?=
 =?utf-8?B?K3hFd0JyZjQwOUUxek56d2RLeFdqUm1yTGg3enBSZFVFUm9FRFFjcm9QKzlT?=
 =?utf-8?B?cWd6S21iOVJOcFptMm1zWTArNUxVM1NOOWlWMkMzWC9VcXZxUitLbnByNCt5?=
 =?utf-8?B?UFRoZG5JYTMyU3dBUDdQYm9JSG1qRGxQUDJwU2dsSUUyZmkrTEd6T2RNL0Rm?=
 =?utf-8?B?Y3U5cnp0VXBaZ1FCUllHcG5iUkNRemV0TFVYeXZjNHlGUWlnT0orZTJxSjhO?=
 =?utf-8?B?eXZtMCtIYmYzNnR5L0VnV2tRb3ZFKzNYTGhyQ0g1NmFjRUt3cFZpVVJIemcv?=
 =?utf-8?B?MnNMbDE2WHR3cEYzY3BHQVl2NFFMY3paUHUrRml6cXNnUVgxNDlMWGxsazJZ?=
 =?utf-8?B?enk2OEY2NDErN1dQM1RSSWtoVGlrK2xCeCtMN3lXYk9NWDJhcTZKRENBQ0ZH?=
 =?utf-8?B?aVlSUzRvamNvUFN0ZkVTU2dZZFNMZmtINWFXdEJQTTlYWHRjVXdnQ2Erczdw?=
 =?utf-8?B?a3RnN2tRR2VIQTVCaGlNTFlTMHFBdjFtU0d1R0ptRDFWKzNLbDlnTjVsL293?=
 =?utf-8?B?aXVuYUl4MldXK25tbGFaZzZ1Y0JIZUZhZ1g0WUw5QjE3OU9YQW0zeld1TnlM?=
 =?utf-8?Q?mt6Ip43o/G3Qw+SeVTw6GiENb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088503a9-6c65-40c5-df9a-08dc4ef068d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:29:24.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uz/TV7zYkGLyTFUEz0vjObPwTY1SRq+b4GnpeQj0B9UgZliSqAjtJH7YUttO+swZY5RbEDoJRZYkJDfC38lFug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129

On 28-Mar-24 11:33 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> On 28-Mar-24 11:05 AM, Huang, Ying wrote:
>>> Bharata B Rao <bharata@amd.com> writes:
>>>
>>>> In order to check how efficiently the existing NUMA balancing
>>>> based hot page promotion mechanism can detect hot regions and
>>>> promote pages for workloads with large memory footprints, I
>>>> wrote and tested a program that allocates huge amount of
>>>> memory but routinely touches only small parts of it.
>>>>
>>>> This microbenchmark provisions memory both on DRAM node and CXL node.
>>>> It then divides the entire allocated memory into chunks of smaller
>>>> size and randomly choses a chunk for generating memory accesses.
>>>> Each chunk is then accessed for a fixed number of iterations to
>>>> create the notion of hotness. Within each chunk, the individual
>>>> pages at 4K granularity are again accessed in random fashion.
>>>>
>>>> When a chunk is taken up for access in this manner, its pages
>>>> can either be residing on DRAM or CXL. In the latter case, the NUMA
>>>> balancing driven hot page promotion logic is expected to detect and
>>>> promote the hot pages that reside on CXL.
>>>>
>>>> The experiment was conducted on a 2P AMD Bergamo system that has
>>>> CXL as the 3rd node.
>>>>
>>>> $ numactl -H
>>>> available: 3 nodes (0-2)
>>>> node 0 cpus: 0-127,256-383
>>>> node 0 size: 128054 MB
>>>> node 1 cpus: 128-255,384-511
>>>> node 1 size: 128880 MB
>>>> node 2 cpus:
>>>> node 2 size: 129024 MB
>>>> node distances:
>>>> node   0   1   2 
>>>>   0:  10  32  60 
>>>>   1:  32  10  50 
>>>>   2:  255  255  10
>>>>
>>>> It is seen that number of pages that get promoted is really low and
>>>> the reason for it happens to be that the NUMA hint fault latency turns
>>>> out to be much higher than the hot threshold most of the times. Here
>>>> are a few latency and threshold sample values captured from
>>>> should_numa_migrate_memory() routine when the benchmark was run:
>>>>
>>>> latency	threshold (in ms)
>>>> 20620	1125
>>>> 56185	1125
>>>> 98710	1250
>>>> 148871	1375
>>>> 182891	1625
>>>> 369415	1875
>>>> 630745	2000
>>>
>>> The access latency of your workload is 20s to 630s, which appears too
>>> long.  Can you try to increase the range of threshold to deal with that?
>>> For example,
>>>
>>> echo 100000 > /sys/kernel/debug/sched/numa_balancing/hot_threshold_ms
>>
>> That of course should help. But I was exploring alternatives where the
>> notion of hotness can be de-linked from the absolute scanning time to
> 
> In fact, only relative time from scan to hint fault is recorded and
> calculated, we have only limited bits.
> 
>> the extent possible. For large memory workloads where only parts of memory
>> get accessed at once, the scanning time can lag from the actual access
>> time significantly as the data above shows. Wondering if such cases can
>> be addressed without having to be workload-specific.
> 
> Does it really matter to promote the quite cold pages (accessed every
> more than 20s)?  And if so, how can we adjust the current algorithm to
> cover that?  I think that may be possible via extending the threshold
> range.  And I think that we can find some way to extending the range by
> default if necessary.

I don't think the pages are cold but rather the existing mechanism fails
to categorize them as hot. This is because the pages were scanned way
before the accesses start happening. When repeated accesses are made to
a chunk of memory that has been scanned a while back, none of those
accesses get classified as hot because the scan time is way behind
the current access time. That's the reason we are seeing the value
of latency ranging from 20s to 630s as shown above.

Regards,
Bharata.

