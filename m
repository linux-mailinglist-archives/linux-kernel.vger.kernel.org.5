Return-Path: <linux-kernel+bounces-102864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434EB87B7CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB37A281AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22016DDC1;
	Thu, 14 Mar 2024 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gCpDQpdz"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD4DDAD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396255; cv=fail; b=UMadxOpoIcB9BbsnY8NlnKatHjCRGC1wZnEu8nv+onq2uVCHSWgPpeJGDajh9dOHBxZLVNJ1uJ+zBLECMt/VY9u4ody4t+s3ykzy77zNpnEtMvL0I02h8FYqIU+Eix19TI07Sut+h9qDVTYjr5/80Yw9tjsydWkZmPWf8Pu19Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396255; c=relaxed/simple;
	bh=g+NO2gnx/rmKAyvh1pWGEWlssrKLJLN8T1y4r5QVI5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XMf+lMepBoHavJEo7F1xazbZP0tLBZGXAYORWs6doaaZrQfMjz6hX8/KHjxrTRetTg3xTSBfhzRCCoCZqwH3N8cDehaFxKBxG7zecPGiCwhUDKodFs4/IGMXnfXa/EghZ9u+Vf4aZrEXNeNZE6vWXhGWCZFwQLTu2oKqig8pJfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gCpDQpdz; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn/G0+wiKTOBGeUnmdqO/UmGhrYhXMvnIz8eejbNjQvdbytMDGZaZuEjpxjrtXFyX8lYzgMk87fxrlwxlnA/vWGzrz74kiNAU5N1LCj+UBTA/Bb1tw4kTKPzEeo2YQgEieZodVkZfppAQ6B+Be6ac8HzmTOAJXE4iJwfEa41YEiQ6n4CwcEUeOxHTvNq9+qt2XmswbDLP99teFxNhu+ZA3Esj9KNIU+ikCN01GqnbtaOZmCzA6F8ORZ14NJ+TUd3c1SnPlXIwfVFdEaSg/8Rb3iZ7FQ1OpV9rYwBls3582iu9oesy1RLZEP+bFtnAuNovGrgsnyRFsY+AF4mAQ2Avg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz+TULuPNxtWh15vZl/JFzEAaclDpq1E30CSmYGmZ8Q=;
 b=aaEUatJS4EZ05Uu0ZqPgMLVGjHi5Fs8FyPsc2SZCBauOwWVnzrB3dybHp2Tk56e4k68DglHNy9cNjVf6htEn5mftrBvQ+qHCzx2RUrKB1tgGkxaRzAo0Hl6WEJzOShIJr7THHvAvGSXNJswDd4z/zowGVdHxofsolkzp2kLqxdgBXGO4tKLNQGI/LUb0aVUwqudQRb9S6agWKwveTfEWkUT7PyCpsBHj+bkhd0Ay3Fs43yMtDtAnCYoyigv7jOTWVYj/nQAtgdYQs4mJ5M5pB0naWr4hHaehqmBrDGjGctmZOFqfdHsl4s2Zsvh51whHhWAnNGHznBoIDnJYQrhEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz+TULuPNxtWh15vZl/JFzEAaclDpq1E30CSmYGmZ8Q=;
 b=gCpDQpdzNO5PIoFLNXVrrQ3RzCEhFwjcda8epuI6nl1J/TDsli1X7wGulxR3aP3YLIYsAfGQISznhIRQJyypWqVUuP4qCs4X4Y09ShEhFJMXrVgUAdxj2HTXNWw3XVo7Jnbo3fIihbSmCueKlckHz3PeUk2GUKpgC9oYnlVruio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.20; Thu, 14 Mar 2024 06:04:10 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::948f:c6a5:70a2:f809]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::948f:c6a5:70a2:f809%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 06:04:10 +0000
Message-ID: <66f1e42c-9035-4f9b-8c77-976ab50638bd@amd.com>
Date: Thu, 14 Mar 2024 11:34:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] sched/debug: Increase SCHEDSTAT_VERSION to 16
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
 <20240308105901.1096078-5-mingo@kernel.org>
 <14d29fdf-ef10-48e6-a102-f1f0bb27c181@linux.ibm.com>
 <ZfAoEmH6KRhjyUor@gmail.com> <ZfKJaztM0FhKRmjg@BLR-5CG11610CF.amd.com>
Content-Language: en-US
From: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <ZfKJaztM0FhKRmjg@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcbea37-41a4-4ffe-1eee-08dc43ec90b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2XK5f2CDJj3iAfaHBhgJgfRy81cmOcJ65CVy08I7Lll2J/Sr/tjxNULdc8/DFeTtGJ4hHJkPHz2kwpOvvrcuSGc7JDgNoHdwl0mW5zbQX7upX/pXxUK7dfnE1q62NiZXasEFScj8lnisC20m42tdLS1reWyrMVOf0MS/Ffn4157ok6Ed2FOQNvopjx7lczGllHbpHPFlkjGpH38bf87MKI2kVz1bwBkqunNii6123+uZLrePCkskeCIGVwM8mSVzUs/qR7AhZfsFlUFtFfldKr2eyD+bPVKZQsAZa3SfGLEzRt5qUVQl9FwLNWBVcJ3W9KZZSlrKeERchMmNlNpcqs5ZqeoRgQhxTm2Jo/0apcVKYvvhf3nkWhCZjL6ldO4koeiXh32C1diCTtIWp8PxvU/h+V654ClH4e2IihDEHfAgLOVGpiKQ+CehkgsPASYlBbkiPz6bwudSJMzU7/h+/LMAVWMRRibmBtuPKgPqj+KKV4CyBGq/TBJM0mmkoFZniA+TpJZd0zdxhHenKI0/3eZ3gIeu5Ju2Pqg4x3LzbLqVCyKyrpeWcXNHXEYwrTXVCMz8bO+9EAPnQOBirtDaT2GlJrMHCqYk6ynCzRY497WocFpOsde7pslvkjWKx0yePzW26sMo0LzLwlss6agZlLpPsaNAJoeg9AudG6Nd/CU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1JNUTc1VUNsRWp3SE1FZG1OQmI2bndtK1F0WFQvb0FpMU9NelVyRmx1cDUz?=
 =?utf-8?B?THNSRHFEKzczUlRqSGthMU5hb2tMcVpxVGRwd3ErNGNKTlpHYW9haUJEV3Ft?=
 =?utf-8?B?aXdybnVKbVovbVhTMHQyUy92L21jV2YweGJuZk12NUNnV29ER1poOVdiVTNk?=
 =?utf-8?B?d2Zqb0JGeWxVOXBzb0grcThLRzRZWnFSUmw5bUhheHRpbHp5bFZaUXAvRlAz?=
 =?utf-8?B?cmQ3NEM4Zkp3YVFTS3V1UmlTQXlzZEpmSTlJS0NxUVdhV1psY09pKzU2cGtF?=
 =?utf-8?B?UEJRYTBvbnFHejMxSE05NGdRV25admk1aXJNWklHMG5oWlNKUGdyWTBudDFi?=
 =?utf-8?B?OTdJRHNPc2dRUUg5YkR1cEh5OGlOV0RXdjdZZi9aSko2SCtNL0h4Um0rM014?=
 =?utf-8?B?VnRpZG94bDd1YTJhMUNUZ1F1K2hNU01wMFNFVkRxYlcwaE5vMlRmZTc0MitY?=
 =?utf-8?B?R2ZFYTlHQmswTC8rOStsWHhSRGsva1dPRW9GOWdpc09Pek9uM2k2bWdyS3lR?=
 =?utf-8?B?eE5XKzJVdW9NWi9wSnVGaTR4dExwYlZ1RGU5YjZTeS81aEtWSWY2RXBhQWIx?=
 =?utf-8?B?OUtHemVlMG12YVI2aStWS29ISVZYWGl0cmxPV2NmWW9ZdWN5dDJMMGxEd0Ex?=
 =?utf-8?B?UWxLZ1FmSkI3SlV6OEkvOWJCRVdTSlVncVlyMm5CSVhBOVhydkJVd1hVQW4z?=
 =?utf-8?B?cHNwdGJCNnphQnNrWTJvbUl5VkU4SE00b3JKbjAwZUdMK2dUTmlLc09ybFo1?=
 =?utf-8?B?LzhuNVlJT053NVhDSWR6VTdJd2g3K0tsV3RuTTY5bm9rckk0VkZ2KzVvb0hj?=
 =?utf-8?B?emZpYTdCbUhKaXJ2K08rZlNUQTZuOWwwK1JMZDZZQi9SdUU5VmxoNUl3eHZl?=
 =?utf-8?B?S0xRU01zdERYNjVLOXpoaUIzRzRsM2k2VGE4c0pDOG9XWCtpRW42SjRJWHVx?=
 =?utf-8?B?RiswYW9DTWZNSkVNN21TalB3Y2ZNVFRSbmNsTTdadXhQQ1I1MSt6TGs3RDRs?=
 =?utf-8?B?UWdKRHg4OWo1ZGtQSHdBdTlvZGE0Q2wxdmpXVzN0UlRteXZOcU1XWHd2anlt?=
 =?utf-8?B?MHJXNGx3Q2FnOTEwS2FNVG84ZFY5RmhzdU1OeGF1VE9mVmpUbkZiMW1kYnIw?=
 =?utf-8?B?bzcvTU54dDRJSkd1MFNZaE9TTXpOVkdGUVlhOFRpNlhLNWttMUJRUDl2eWpF?=
 =?utf-8?B?NFUyT3RzWkRCUGVkamFob1ZERU1Bazcxdm5LOGs5S1FvT0ZxTGFNYnFjZlBk?=
 =?utf-8?B?MWhNQk5LVUtRS2kyNVRjZEl5eW1iaUZJQkJ5QkphYUxya2R4K01jekltRlB1?=
 =?utf-8?B?bFV3YkxjL0YyZjU1MEpXYnBqdHBTbkxjS25XUUsyY2UzY1dxa2VRWlNuN3Bx?=
 =?utf-8?B?dGlYeklxSWlsZ1BWUHphSml6clM4cmdYQ29RanRJSUEybjNKaVdpV0pZdkpZ?=
 =?utf-8?B?SFphRllrOWdBYjVsakpwTlUwVTd1czBnRmZzcFhPVkliUDBTT25NUXZRcE43?=
 =?utf-8?B?b3FMZmorV3ZqYjVQaHdMeVM2ekxrYkdMQVE0UWtPVGZnZS9paS92NTRtaGJ5?=
 =?utf-8?B?NTRIcjBJM2IzcEgzTml4WHpkbGhpUENzdVF2VncxQVVJZGJydThzN0dKaTBa?=
 =?utf-8?B?dk5XNzdoYnhrQWxKcHpmUC9sOEttM2Rsb1p2MnlIMFZ5dlk3SVIwbmZjMGQw?=
 =?utf-8?B?K0ZUMGdGdHBnV1M2clJyL3lhVXI4ZGFURlFTMmN1OU52S1g2SDhiZzdrMFhR?=
 =?utf-8?B?eHpDQkNJQmxjUi9iT1MveVJ0UGlrUWU1VHdOZWdYSUtuekxNRVIzWXBwZHV4?=
 =?utf-8?B?dGpLRG8vMnByaVNaM2ZWUVRSS04yazN6TUtoa3FpRFQzdWhCM24wOEhsNlZV?=
 =?utf-8?B?NnhGdEpwVmNsZUptNmFBY0hzU3hyakJqZjJzSnZ4M0cxZUxrOTJ0blNBUjNP?=
 =?utf-8?B?Z3lYcW94Yi9KQkdEdXI0dlJkK2FFMC9aOXh5Z2M5bG95LzRpLzgrN0ZrTmM3?=
 =?utf-8?B?eWRWclV6VlNSQnVtMm9zeDRjUWpGMGFnR054eE1mZ2g3VVgvR21nSUN6OTJw?=
 =?utf-8?B?Q1VrLzRyUS95N3hqN3JJYjVMVjRGV2xLQUc0a1NrSDRNeVNYc1Q5R05XNWxq?=
 =?utf-8?Q?UokrmYvvCuD4F5WI53DLmLe9x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcbea37-41a4-4ffe-1eee-08dc43ec90b0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:04:10.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLh3wTxwoftBZZxhu4wK7UopOvsoDmh/FN6MXEsnrIQXRTbpXjQCASIjAyiUlT57VIYbwo2athpk5MQHgjfxrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234



On 3/14/2024 10:51 AM, Gautham R. Shenoy wrote:
> Hello Ingo, Shrikanth,
> 
> On Tue, Mar 12, 2024 at 11:01:54AM +0100, Ingo Molnar wrote:
>>
>> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>
>>>
>>>
>>> On 3/8/24 4:28 PM, Ingo Molnar wrote:
>>>> We changed the order of definitions within 'enum cpu_idle_type',
>>>> which changed the order of [CPU_MAX_IDLE_TYPES] columns in
>>>> show_schedstat().
>>>>
>>>
>>>> +++ b/kernel/sched/stats.c
>>>> @@ -113,7 +113,7 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
>>>>    * Bump this up when changing the output format or the meaning of an existing
>>>>    * format, so that tools can adapt (or abort)
>>>>    */
>>>> -#define SCHEDSTAT_VERSION 15
>>>> +#define SCHEDSTAT_VERSION 16
>>>
>>> Please add the info about version, and change of the order
>>> briefly in Documentation/scheduler/sched-stats.rst as well.
>>
>> Good point, I've added this paragraph to sched-stats.rst:
>>
>>   +Version 16 of schedstats changed the order of definitions within
>>   +'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
>>   +columns in show_schedstat(). In particular the position of CPU_IDLE
>>   +and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
> 
> Thanks for this change!
> 
> Since we are considering bumping up the version for this change, it
> might be good to get rid of "lb_imbalance" which is currently a sum of
> all the different kinds of imbalances (due to load, utilization,
> number of tasks, misfit tasks). This is not useful.
> 
> Swapnil had a patch to print the different imbalances, which will
> change the number of fields. Can we include this change into v16 as
> well?
> 
> Swapnil, could you please rebase your patch on tip/sched/core and post
> it ?
Please find the patch below. This is based on tip/sched/core.

---
 From deeed5bf937bddf227deb1cdb9e2e6c164c48053 Mon Sep 17 00:00:00 2001
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
Date: Thu, 15 Jun 2023 04:55:09 +0000
Subject: [PATCH] sched: Report the different kinds of imbalances in /proc/schedstat

In /proc/schedstat, lb_imbalance reports the sum of imbalances
discovered in sched domains with each call to sched_balance_rq(), which is
not very useful because lb_imbalance is an aggregate of the imbalances
due to load, utilization, nr_tasks and misfit_tasks. Remove this field
from /proc/schedstat.

Currently there are no fields in /proc/schedstat to report different types
of imbalances. Introduce new fields in /proc/schedstat to report the
total imbalances in load, utilization, nr_tasks or misfit_tasks.

Added fields to /proc/schedstat:
  	- lb_imbalance_load: Total imbalance due to load.
	- lb_imbalance_util: Total imbalance due to utilization.
	- lb_imbalance_task: Total imbalance due to number of tasks.
	- lb_imbalance_misfit: Total imbalance due to misfit tasks.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
  Documentation/scheduler/sched-stats.rst | 104 +++++++++++++-----------
  include/linux/sched/topology.h          |   5 +-
  kernel/sched/fair.c                     |  15 +++-
  kernel/sched/stats.c                    |   7 +-
  4 files changed, 80 insertions(+), 51 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 7c2b16c4729d..d6e9a8a5619c 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -6,6 +6,9 @@ Version 16 of schedstats changed the order of definitions within
  'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
  columns in show_schedstat(). In particular the position of CPU_IDLE
  and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
+Also stop reporting 'lb_imbalance' as it has no significance anymore
+and instead add more relevant fields namely 'lb_imbalance_load',
+'lb_imbalance_util', 'lb_imbalance_task' and 'lb_imbalance_misfit'.
  
  Version 15 of schedstats dropped counters for some sched_yield:
  yld_exp_empty, yld_act_empty and yld_both_empty. Otherwise, it is
@@ -73,86 +76,93 @@ One of these is produced per domain for each cpu described. (Note that if
  CONFIG_SMP is not defined, *no* domains are utilized and these lines
  will not appear in the output.)
  
-domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
+domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
  
  The first field is a bit mask indicating what cpus this domain operates over.
  
-The next 24 are a variety of sched_balance_rq() statistics in grouped into types
+The next 33 are a variety of sched_balance_rq() statistics in grouped into types
  of idleness (idle, busy, and newly idle):
  
      1)  # of times in this domain sched_balance_rq() was called when the
+        cpu was busy
+    2)  # of times in this domain sched_balance_rq() checked but found the
+        load did not require balancing when busy
+    3)  # of times in this domain sched_balance_rq() tried to move one or
+        more tasks and failed, when the cpu was busy
+    4)  Total imbalance in load when the cpu was busy
+    5)  Total imbalance in utilization when the cpu was busy
+    6)  Total imbalance in number of tasks when the cpu was busy
+    7)  Total imbalance due to misfit tasks when the cpu was busy
+    8)  # of times in this domain pull_task() was called when busy
+    9)  # of times in this domain pull_task() was called even though the
+        target task was cache-hot when busy
+    10) # of times in this domain sched_balance_rq() was called but did not
+        find a busier queue while the cpu was busy
+    11) # of times in this domain a busier queue was found while the cpu
+        was busy but no busier group was found
+
+    12) # of times in this domain sched_balance_rq() was called when the
          cpu was idle
-    2)  # of times in this domain sched_balance_rq() checked but found
+    13) # of times in this domain sched_balance_rq() checked but found
          the load did not require balancing when the cpu was idle
-    3)  # of times in this domain sched_balance_rq() tried to move one or
+    14) # of times in this domain sched_balance_rq() tried to move one or
          more tasks and failed, when the cpu was idle
-    4)  sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was idle
-    5)  # of times in this domain pull_task() was called when the cpu
+    15) Total imbalance in load when the cpu was idle
+    16) Total imbalance in utilization when the cpu was idle
+    17) Total imbalance in number of tasks when the cpu was idle
+    18) Total imbalance due to misfit tasks when the cpu was idle
+    19) # of times in this domain pull_task() was called when the cpu
          was idle
-    6)  # of times in this domain pull_task() was called even though
+    20) # of times in this domain pull_task() was called even though
          the target task was cache-hot when idle
-    7)  # of times in this domain sched_balance_rq() was called but did
+    21) # of times in this domain sched_balance_rq() was called but did
          not find a busier queue while the cpu was idle
-    8)  # of times in this domain a busier queue was found while the
+    22) # of times in this domain a busier queue was found while the
          cpu was idle but no busier group was found
-    9)  # of times in this domain sched_balance_rq() was called when the
-        cpu was busy
-    10) # of times in this domain sched_balance_rq() checked but found the
-        load did not require balancing when busy
-    11) # of times in this domain sched_balance_rq() tried to move one or
-        more tasks and failed, when the cpu was busy
-    12) sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was busy
-    13) # of times in this domain pull_task() was called when busy
-    14) # of times in this domain pull_task() was called even though the
-        target task was cache-hot when busy
-    15) # of times in this domain sched_balance_rq() was called but did not
-        find a busier queue while the cpu was busy
-    16) # of times in this domain a busier queue was found while the cpu
-        was busy but no busier group was found
  
-    17) # of times in this domain sched_balance_rq() was called when the
-        cpu was just becoming idle
-    18) # of times in this domain sched_balance_rq() checked but found the
+    23) # of times in this domain sched_balance_rq() was called when the
+        was just becoming idle
+    24) # of times in this domain sched_balance_rq() checked but found the
          load did not require balancing when the cpu was just becoming idle
-    19) # of times in this domain sched_balance_rq() tried to move one or more
+    25) # of times in this domain sched_balance_rq() tried to move one or more
          tasks and failed, when the cpu was just becoming idle
-    20) sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was just becoming idle
-    21) # of times in this domain pull_task() was called when newly idle
-    22) # of times in this domain pull_task() was called even though the
+    26) Total imbalance in load when the cpu was just becoming idle
+    27) Total imbalance in utilization when the cpu was just becoming idle
+    28) Total imbalance in number of tasks when the cpu was just becoming idle
+    29) Total imbalance due to misfit tasks when the cpu was just becoming idle
+    30) # of times in this domain pull_task() was called when newly idle
+    31) # of times in this domain pull_task() was called even though the
          target task was cache-hot when just becoming idle
-    23) # of times in this domain sched_balance_rq() was called but did not
+    32) # of times in this domain sched_balance_rq() was called but did not
          find a busier queue while the cpu was just becoming idle
-    24) # of times in this domain a busier queue was found while the cpu
+    33) # of times in this domain a busier queue was found while the cpu
          was just becoming idle but no busier group was found
  
     Next three are active_load_balance() statistics:
  
-    25) # of times active_load_balance() was called
-    26) # of times active_load_balance() tried to move a task and failed
-    27) # of times active_load_balance() successfully moved a task
+    34) # of times active_load_balance() was called
+    35) # of times active_load_balance() tried to move a task and failed
+    36) # of times active_load_balance() successfully moved a task
  
     Next three are sched_balance_exec() statistics:
  
-    28) sbe_cnt is not used
-    29) sbe_balanced is not used
-    30) sbe_pushed is not used
+    37) sbe_cnt is not used
+    38) sbe_balanced is not used
+    39) sbe_pushed is not used
  
     Next three are sched_balance_fork() statistics:
  
-    31) sbf_cnt is not used
-    32) sbf_balanced is not used
-    33) sbf_pushed is not used
+    40) sbf_cnt is not used
+    41) sbf_balanced is not used
+    42) sbf_pushed is not used
  
     Next three are try_to_wake_up() statistics:
  
-    34) # of times in this domain try_to_wake_up() awoke a task that
+    43) # of times in this domain try_to_wake_up() awoke a task that
          last ran on a different cpu in this domain
-    35) # of times in this domain try_to_wake_up() moved a task to the
+    44) # of times in this domain try_to_wake_up() moved a task to the
          waking cpu because it was cache-cold on its own cpu anyway
-    36) # of times in this domain try_to_wake_up() started passive balancing
+    45) # of times in this domain try_to_wake_up() started passive balancing
  
  /proc/<pid>/schedstat
  ---------------------
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c8fe9bab981b..15685c40a713 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -114,7 +114,10 @@ struct sched_domain {
  	unsigned int lb_count[CPU_MAX_IDLE_TYPES];
  	unsigned int lb_failed[CPU_MAX_IDLE_TYPES];
  	unsigned int lb_balanced[CPU_MAX_IDLE_TYPES];
-	unsigned int lb_imbalance[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_load[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_util[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_task[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_misfit[CPU_MAX_IDLE_TYPES];
  	unsigned int lb_gained[CPU_MAX_IDLE_TYPES];
  	unsigned int lb_hot_gained[CPU_MAX_IDLE_TYPES];
  	unsigned int lb_nobusyg[CPU_MAX_IDLE_TYPES];
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a19ea290b790..515258f97ba3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11288,7 +11288,20 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
  
  	WARN_ON_ONCE(busiest == env.dst_rq);
  
-	schedstat_add(sd->lb_imbalance[idle], env.imbalance);
+	switch (env.migration_type) {
+	case migrate_load:
+		schedstat_add(sd->lb_imbalance_load[idle], env.imbalance);
+		break;
+	case migrate_util:
+		schedstat_add(sd->lb_imbalance_util[idle], env.imbalance);
+		break;
+	case migrate_task:
+		schedstat_add(sd->lb_imbalance_task[idle], env.imbalance);
+		break;
+	case migrate_misfit:
+		schedstat_add(sd->lb_imbalance_misfit[idle], env.imbalance);
+		break;
+	}
  
  	env.src_cpu = busiest->cpu;
  	env.src_rq = busiest;
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 78e48f5426ee..a02bc9db2f1c 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -151,11 +151,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
  			seq_printf(seq, "domain%d %*pb", dcount++,
  				   cpumask_pr_args(sched_domain_span(sd)));
  			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
-				seq_printf(seq, " %u %u %u %u %u %u %u %u",
+				seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",
  				    sd->lb_count[itype],
  				    sd->lb_balanced[itype],
  				    sd->lb_failed[itype],
-				    sd->lb_imbalance[itype],
+				    sd->lb_imbalance_load[itype],
+				    sd->lb_imbalance_util[itype],
+				    sd->lb_imbalance_task[itype],
+				    sd->lb_imbalance_misfit[itype],
  				    sd->lb_gained[itype],
  				    sd->lb_hot_gained[itype],
  				    sd->lb_nobusyq[itype],
-- 
2.34.1


> 
>>
>>> One recent user that I recollect is sched scoreboard. Version number should
>>> be able to help the users when they it is breaking their scripts.
>>>
> 
>>> +Gautham, Any thoughts?
> 
> Yes, the scoreboard looks at the version. If it doesn't understand a
> version, it will not parse it.  It can be extended to understand the
> new version, since that's only about adding a new json.
> 
>>
>> If it's really a problem, I suspect we could maintain the v15 order of
>> output.
> 
> I don't think moving to v16 is an issue.
> 
>>
>> Thanks,
>>
>> 	Ingo
> 
> --
> Thanks and Regards
> gautham.

--
Thanks and Regards,
Swapnil

