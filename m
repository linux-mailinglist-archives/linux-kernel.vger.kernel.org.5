Return-Path: <linux-kernel+bounces-104185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EE187CA64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B901C2202A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66449175BC;
	Fri, 15 Mar 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g6nyITAq"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8D1759F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493619; cv=fail; b=T5UoQa+/I3kjl+dvDQ/DrlPhYi99UJq8XbV+Htul+vhErDQTdtWGjhIEZ7nHycx+QNtaaRtmaA2eQma+Zugbtuilby11uLAiwabROGNY4E4dhm+IPkqeGkmfblyx3wKVgnUt1CJLR+iOgKxr4/t8hIW9jpQyQJvmHlBMOjg+LiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493619; c=relaxed/simple;
	bh=Xz9MLQFzi7xuY1CvNblYibup9rOgwQnLiH+1ZCUr51s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ppJULrtVHvUrg8XK1M1uzS22v95yRx1Xet24+BGJew7eO3AULu7gq5XCFyTIA+aQsyVJ6eZ7MdDYn+d8kDWB14wEZtMpEjUgTZoQATmOVFRP8CliqoS77c9hWKDAXiKlUXIRC+1AKJKDCYFY6IbTaDO0Wjchv3vSb6fQ3j/GahU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g6nyITAq; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc+9nWf/V7s5uu5hex09FwexJEvLt+ruI9xerAToJY5RHV5R/VOzImRq02Waq2z6e71sWjLm5ex1D+OHP8nNtcCSFelf4yKsiCsS0nrxUUB/hZGZMATHv9czZc7RGJLV0bt7HvoSRGYZjoXGwpbZGJkA1sV0SCVCe1Aht9TQ7Pqzt1Mj79yOxj9ACK8ni3rJPh4aLwyBsKpu9UZSSSVyrNITW/jVyRm8pUv9EJjuN/D+RyWwCCOCktTus1IY0S+kegHzTbP4jwT1D7G8cptC2BSrfoVBSdWPss/mhOkt3kgbuUMIXf6o2TU8SBW7WYuBTLSo2bWbxjaesEMfxqK6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTzb2gATV3WIUCXgRdrDQ4iAmj+ff76fvAOwpNhlSDo=;
 b=WRxoQjJpXM9BtjKEpgL1xol8QsGF+FNbZk5z5eZPF34Mmsc8ig+LWtGcHj4+TeUNtUGxzkpUpyxycXGbXkYvkdvTtuGgG3yJRYrO9dKqEROPiEvU3Rr7H4yYaS7lx3MIEN/5bk6OcIQjddIXDk3jlhbrBw36t5/FV7DhVsz3y6IPLwWx8LmQu4Dc5JUPTYnfcaC8HxtSYzn/SkNjgchxbIUbGpThqAbtDCJ7d7Lx1h6Ti+Z5MEKU752I07DBfqHaeWjIjBTf/t9XZyYU3AlgOQFATB79huyNCxG26CIGzuvQLykXhRN3abearZh6YYjHnK4nUeG8Mnfoh+Wksryuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTzb2gATV3WIUCXgRdrDQ4iAmj+ff76fvAOwpNhlSDo=;
 b=g6nyITAqawBJdk5nZbzCvm8OZ1X9zvsFqd12EUb32olRzFw0efP4uBqBiqAuYzFXRdMXYWAtuGCcjZAd5QaFMU1QfTr+28zi+YJYZHSXpJJRjS+fzpd7x30sWh3KHUR/6kI6otGrLHtL42MW7BSOuMZTjwcEJVnWhZA8DJkmf6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.26; Fri, 15 Mar 2024 09:06:55 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::948f:c6a5:70a2:f809]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::948f:c6a5:70a2:f809%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 09:06:54 +0000
Message-ID: <07b35339-c369-4c5c-b5a5-b557fdaa5827@amd.com>
Date: Fri, 15 Mar 2024 14:36:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] sched/debug: Increase SCHEDSTAT_VERSION to 16
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
 <20240308105901.1096078-5-mingo@kernel.org>
 <14d29fdf-ef10-48e6-a102-f1f0bb27c181@linux.ibm.com>
 <ZfAoEmH6KRhjyUor@gmail.com> <ZfKJaztM0FhKRmjg@BLR-5CG11610CF.amd.com>
 <66f1e42c-9035-4f9b-8c77-976ab50638bd@amd.com>
 <d5a53c05-6ff3-4bb3-96e0-b8865bd81611@linux.ibm.com>
Content-Language: en-US
From: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <d5a53c05-6ff3-4bb3-96e0-b8865bd81611@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9895c5-df80-4c1d-53b1-08dc44cf4265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v6k+lRwm2SjGlbByHBJa69qXULh6HPnuXB+6TbASBcugGt9zeihRjLD31Wj3SBLONOyiPi+6vgBKYmM6VBnoFW8B8PQQbUKawCxbmA42Ie3DBeqMTd6g5FUPNJMaaY+PwYX4DMfp730ACh90alFZrHBr0r9LYBJ99kvfdqm0XVaCkDmgc++9pGyfLZ6FWrZKFFRucHHT/IhSMeu057b7kYcfFlZ8IiYiTT75oO6xiJV1yULtIlm1GSLUDZU0OzJp9+Vd4wL+yVjd7W/8kSxGtrvp57bsREkkqtyvPVnlxN1oWOUZC8X0T9oWTLo6VzJdRkkcw7onkm7Yc5MjQ/nZs5rLit61axQHLUV902tWH2SyW8katJjjlF8NAoQaALyU3XVtTjSNVPI0wbrxuvVed1oJgZGVgH7Bg/Sc36XV93EafghPAsECobRkdQ662xgnStOkVjaeciVRhglRp7kNSBjWERqEc4/rPSHBkIQhXuAnq8P+QjL7sMJSfTN7duV1OaWsF9YmzocXghQ3wAB4vW6UD9mpppDVDTPOsQSH7EOkZxHNDJ00AEzqnESy7CzPXoZDMY488Xh50zdRV+mmsyVbZshtiKdQp2UEv4XjGR58VuE5KUVH/6I4ND99nLT7mcHyP+2EZrBxxMgsHU3ilQ7mywVKIgBVKQ9T2yKZHlI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnNWdWlnVG5CamNiOXZDdXFaSTRJTEt5MTI0ck03ekplelhsdFF3bnNZUGd0?=
 =?utf-8?B?emxRZWtHa053K0ZtbThOSnNDZkYxcWlwSktkejNyMFkyMUY0RjFGNzh0cjlN?=
 =?utf-8?B?RW16U2s5dnFIRDlxL2dXeDNQUWcvY0RHbjRLcCtNRUFlTi9ITmVOZi8rY1N0?=
 =?utf-8?B?T0xjN1JwODFoZWxnSzB3N3EvMDJZLytOd1VSMXZNUUxuM293UGViaW9MTGZ2?=
 =?utf-8?B?MWZVeHAyUVkwQ2MvckpGWkl2cm1tSmo5bm95bHhFL1YwUnV6YlZCczgyUjc4?=
 =?utf-8?B?bVdOUFQ0b1RoZVhucnJ3Y0VJN052L3B6Z0dEN0IvVGpXa3NnR2ZWNStSczFF?=
 =?utf-8?B?MTFwTCtsQ3VUdW9BYjV6OEQyM0htNFAxUnVDTDIydDZnNm5JMk1yZmhjTStq?=
 =?utf-8?B?a1V5dmRlVzJtQlpiY3ZFQk5nVGxTYnFndGh6N0IxNkRsQVpzQmZaTGkxQ3JG?=
 =?utf-8?B?MTQ1TXVJeFJmS3ZzV1kvQ0ZRNXJEM3NESFVrNkVMdTVpeko3b2NyWk81c1BJ?=
 =?utf-8?B?TXFFNGc3QU1HaDNyd0UrNG93SmI0QU9yb1ZTVkljbGphci9SZjNrMW5TZE1W?=
 =?utf-8?B?V0dDQit2cUNsUFpvWldNVG9CeVhYa2cycHpSdWxna0FBOVJZOERsd09TSFNC?=
 =?utf-8?B?UG9ibklnTWV0d2pBUHF3U3dBL1cyK0RPb0p4TkFlZnBMRVJ5dzZyUW1Zd3pR?=
 =?utf-8?B?QkNJSlFvMUNCbU0xT0RmTi96c21xYzM3NmE2WFZoY2t5T0pjZlExSmdTVDZq?=
 =?utf-8?B?Qyt3VmR6aGpxTXBvRVR6dlV6YjlldTVXRUJ0RnJSMmNrVmdYU0dOQ0ttMGJj?=
 =?utf-8?B?bXgwcVd1cjQ1SU9EME1ZVVdtdk0wMGwyanAxT0RFZk5LaXdzVGFmTnVQSHZT?=
 =?utf-8?B?WGxFbVpjK2FLU3U0LzJaa3kwNWlSWjdRQjl5anAyRzhEUnBrNEh6QjdaVk1P?=
 =?utf-8?B?SXIyeHh2cnI3ZHVwaW9jK0FYaVZzRDREQms3TWlOenpwVC8xSXdyVXRhZEtH?=
 =?utf-8?B?ODVmbEhIQU9QZlBNVnRHcFY5UEdYcFY1eUVYdHZWdGx4dmtqOHhOMXhvWEZi?=
 =?utf-8?B?Y3BkR1RkZkxpczdmak5RN3JoTXNkTTFSdTV6V0dtMDg3dlpLZjRsdlNEUmtD?=
 =?utf-8?B?Q01SNkoyLzBHM1ZVS2pvQVcvS3ZEYzFmWW5oUHVBRzI0ejQrbUNhTnkxRUdP?=
 =?utf-8?B?UDc4dk5rczVET25HSmFGdnJ1TG0wd2FBeDB2bVUrREVmanlDaVFSQUpxME03?=
 =?utf-8?B?eDdLMDNiTmRvMlYybC8xOW9YR2NNdncxMEVrOUliSDlhcTBjeTBvNUNNTkxx?=
 =?utf-8?B?V1FwWG1BMlN4dnE5UzVmOG1YWW5XUDlkbjUvYkYvMjBrVW5iL1htZWNxRWc0?=
 =?utf-8?B?VkJmQXpGeXRGb3E4L1hNMXkxQThDZGhiVGY0VUtwcUl2K21qbUZaOVcrQU9s?=
 =?utf-8?B?NnFVRHRaeFRnUlpQL2NmTHNHVTZ0dzNYQkxiMlpMbC9GVkhzczM1dm1OVGFv?=
 =?utf-8?B?SEh3V2RLYjlEVWJRTlZOaUhYcjBoVmVTRVNMZ2h3bTlZTXJDclhKaUk4dWpD?=
 =?utf-8?B?ejY3bUR5YUhoakhtMWZoa0FUZUdDK1NseFdjeGZlSVR5Z21mKytGeVdqaU9Z?=
 =?utf-8?B?S3hIS2Jmd1ljVWZjeFFqSTZyZGYzSE1mcUk1c1JUakUyQUp3dlFmNGxmM2lJ?=
 =?utf-8?B?MEZSeWdUMlBLRjdZZUdsb0Q0MW1vem1iWjB6V0FpSTRtVnp4KzhaZ3RMS2NO?=
 =?utf-8?B?QlBzbzBkQ2RlWDJ6MHNHalQyenlIUW9lNjZjN3dUU2NoUXFYUFBuZHNER1Q0?=
 =?utf-8?B?cXlyajZRVFV1cUNPZEVEa0JRWHI5d0srUkJacmJVR09hcnB1dThmWStoaGNz?=
 =?utf-8?B?SldNaU54MlhaYUduV3poczMyVm9CaU9mTlhSYUcwSEFhcnlIRnRtZ0pEZ1Bn?=
 =?utf-8?B?T2xIOG10ZXNvQmNYaEVmbE1aYkJONk9laFV2elhSMmZzUnRSbCtFZ3NWYnVZ?=
 =?utf-8?B?NkFFSjhqSFBHSHJVNVBsUVpQRk5yeWJpMlNZSkNZWU1pZTd2djI5MWZoaUtB?=
 =?utf-8?B?cTdBdS9xb1lpRFB2QWs4M2dxdHJlMUNJZmJ0eXRjdlk4SFRqU3JmY3NuTVQ1?=
 =?utf-8?Q?lR5HKmDD0plM2QRdpjKOVxpkV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9895c5-df80-4c1d-53b1-08dc44cf4265
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:06:54.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5vOwAWcllfumKEnTLqWsf/GSizqsYlZYDdO86Zol4GalwETXoJTAr2+n/6R5Zrok0XfAfQmrbf0jA+TiaCHng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423

Hello Shrikanth,

Thank you for reviewing.

On 3/15/2024 10:07 AM, Shrikanth Hegde wrote:
>
> On 3/14/24 11:34 AM, Swapnil Sapkal wrote:
>>
>> Please find the patch below. This is based on tip/sched/core.
>>
>> ---
>>  From deeed5bf937bddf227deb1cdb9e2e6c164c48053 Mon Sep 17 00:00:00 2001
>> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> Date: Thu, 15 Jun 2023 04:55:09 +0000
>> Subject: [PATCH] sched: Report the different kinds of imbalances in
>> /proc/schedstat
>>
>> In /proc/schedstat, lb_imbalance reports the sum of imbalances
>> discovered in sched domains with each call to sched_balance_rq(), which is
>> not very useful because lb_imbalance is an aggregate of the imbalances
>> due to load, utilization, nr_tasks and misfit_tasks. Remove this field
>> from /proc/schedstat.
>>
> Yes. This makes sense. any one of them can skew the value.

Yes.

>> Currently there are no fields in /proc/schedstat to report different types
>> of imbalances. Introduce new fields in /proc/schedstat to report the
>> total imbalances in load, utilization, nr_tasks or misfit_tasks.
>>
>> Added fields to /proc/schedstat:
>>       - lb_imbalance_load: Total imbalance due to load.
>>      - lb_imbalance_util: Total imbalance due to utilization.
>>      - lb_imbalance_task: Total imbalance due to number of tasks.
>>      - lb_imbalance_misfit: Total imbalance due to misfit tasks.
>>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   Documentation/scheduler/sched-stats.rst | 104 +++++++++++++-----------
>>   include/linux/sched/topology.h          |   5 +-
>>   kernel/sched/fair.c                     |  15 +++-
>>   kernel/sched/stats.c                    |   7 +-
>>   4 files changed, 80 insertions(+), 51 deletions(-)
>>
>> diff --git a/Documentation/scheduler/sched-stats.rst
>> b/Documentation/scheduler/sched-stats.rst
>> index 7c2b16c4729d..d6e9a8a5619c 100644
>> --- a/Documentation/scheduler/sched-stats.rst
>> +++ b/Documentation/scheduler/sched-stats.rst
>> @@ -6,6 +6,9 @@ Version 16 of schedstats changed the order of
>> definitions within
>>   'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
>>   columns in show_schedstat(). In particular the position of CPU_IDLE
>>   and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
>> +Also stop reporting 'lb_imbalance' as it has no significance anymore
>> +and instead add more relevant fields namely 'lb_imbalance_load',
>> +'lb_imbalance_util', 'lb_imbalance_task' and 'lb_imbalance_misfit'.
>>   
>>   Version 15 of schedstats dropped counters for some sched_yield:
>>   yld_exp_empty, yld_act_empty and yld_both_empty. Otherwise, it is
>> @@ -73,86 +76,93 @@ One of these is produced per domain for each cpu
>> described. (Note that if
>>   CONFIG_SMP is not defined, *no* domains are utilized and these lines
>>   will not appear in the output.)
>>   
>> -domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>> 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
>> +domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>> 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
>>   
>>   The first field is a bit mask indicating what cpus this domain operates
>> over.
>>   
> IIUC, this is editing the content of Version 15, But changes would happen on Version 16.
> Instead can we add the section for Version 16 and not modify for 15?

This file contains the field details of current schedstat version and the short
summary of what change across the versions. Maintaining each versions details will
increase the file size. Instead I will add the links to previous version's
documentation.
  
Thoughts on this?

>> -The next 24 are a variety of sched_balance_rq() statistics in grouped
>> into types
>> +The next 33 are a variety of sched_balance_rq() statistics in grouped
>> into types
>>   of idleness (idle, busy, and newly idle):
>>   
>>       1)  # of times in this domain sched_balance_rq() was called when the
>> +        cpu was busy
>> +    2)  # of times in this domain sched_balance_rq() checked but found the
>> +        load did not require balancing when busy
>> +    3)  # of times in this domain sched_balance_rq() tried to move one or
>> +        more tasks and failed, when the cpu was busy
>> +    4)  Total imbalance in load when the cpu was busy
>> +    5)  Total imbalance in utilization when the cpu was busy
>> +    6)  Total imbalance in number of tasks when the cpu was busy
>> +    7)  Total imbalance due to misfit tasks when the cpu was busy
>> +    8)  # of times in this domain pull_task() was called when busy
>> +    9)  # of times in this domain pull_task() was called even though the
>> +        target task was cache-hot when busy
>> +    10) # of times in this domain sched_balance_rq() was called but did
>> not
>> +        find a busier queue while the cpu was busy
>> +    11) # of times in this domain a busier queue was found while the cpu
>> +        was busy but no busier group was found
>> +
>> +    12) # of times in this domain sched_balance_rq() was called when the
>>           cpu was idle
>> -    2)  # of times in this domain sched_balance_rq() checked but found
>> +    13) # of times in this domain sched_balance_rq() checked but found
>>           the load did not require balancing when the cpu was idle
>> -    3)  # of times in this domain sched_balance_rq() tried to move one or
>> +    14) # of times in this domain sched_balance_rq() tried to move one or
>>           more tasks and failed, when the cpu was idle
>> -    4)  sum of imbalances discovered (if any) with each call to
>> -        sched_balance_rq() in this domain when the cpu was idle
>> -    5)  # of times in this domain pull_task() was called when the cpu
>> +    15) Total imbalance in load when the cpu was idle
>> +    16) Total imbalance in utilization when the cpu was idle
>> +    17) Total imbalance in number of tasks when the cpu was idle
>> +    18) Total imbalance due to misfit tasks when the cpu was idle
>> +    19) # of times in this domain pull_task() was called when the cpu
>>           was idle
>> -    6)  # of times in this domain pull_task() was called even though
>> +    20) # of times in this domain pull_task() was called even though
>>           the target task was cache-hot when idle
>> -    7)  # of times in this domain sched_balance_rq() was called but did
>> +    21) # of times in this domain sched_balance_rq() was called but did
>>           not find a busier queue while the cpu was idle
>> -    8)  # of times in this domain a busier queue was found while the
>> +    22) # of times in this domain a busier queue was found while the
>>           cpu was idle but no busier group was found
>> -    9)  # of times in this domain sched_balance_rq() was called when the
>> -        cpu was busy
>> -    10) # of times in this domain sched_balance_rq() checked but found the
>> -        load did not require balancing when busy
>> -    11) # of times in this domain sched_balance_rq() tried to move one or
>> -        more tasks and failed, when the cpu was busy
>> -    12) sum of imbalances discovered (if any) with each call to
>> -        sched_balance_rq() in this domain when the cpu was busy
>> -    13) # of times in this domain pull_task() was called when busy
>> -    14) # of times in this domain pull_task() was called even though the
>> -        target task was cache-hot when busy
>> -    15) # of times in this domain sched_balance_rq() was called but did
>> not
>> -        find a busier queue while the cpu was busy
>> -    16) # of times in this domain a busier queue was found while the cpu
>> -        was busy but no busier group was found
>>   
>> -    17) # of times in this domain sched_balance_rq() was called when the
>> -        cpu was just becoming idle
>> -    18) # of times in this domain sched_balance_rq() checked but found the
>> +    23) # of times in this domain sched_balance_rq() was called when the
>> +        was just becoming idle
>> +    24) # of times in this domain sched_balance_rq() checked but found the
>>           load did not require balancing when the cpu was just becoming idle
>> -    19) # of times in this domain sched_balance_rq() tried to move one
>> or more
>> +    25) # of times in this domain sched_balance_rq() tried to move one
>> or more
>>           tasks and failed, when the cpu was just becoming idle
>> -    20) sum of imbalances discovered (if any) with each call to
>> -        sched_balance_rq() in this domain when the cpu was just
>> becoming idle
>> -    21) # of times in this domain pull_task() was called when newly idle
>> -    22) # of times in this domain pull_task() was called even though the
>> +    26) Total imbalance in load when the cpu was just becoming idle
>> +    27) Total imbalance in utilization when the cpu was just becoming idle
>> +    28) Total imbalance in number of tasks when the cpu was just
>> becoming idle
>> +    29) Total imbalance due to misfit tasks when the cpu was just
>> becoming idle
>> +    30) # of times in this domain pull_task() was called when newly idle
>> +    31) # of times in this domain pull_task() was called even though the
>>           target task was cache-hot when just becoming idle
>> -    23) # of times in this domain sched_balance_rq() was called but did
>> not
>> +    32) # of times in this domain sched_balance_rq() was called but did
>> not
>>           find a busier queue while the cpu was just becoming idle
>> -    24) # of times in this domain a busier queue was found while the cpu
>> +    33) # of times in this domain a busier queue was found while the cpu
>>           was just becoming idle but no busier group was found
>>   
>>      Next three are active_load_balance() statistics:
>>   
>> -    25) # of times active_load_balance() was called
>> -    26) # of times active_load_balance() tried to move a task and failed
>> -    27) # of times active_load_balance() successfully moved a task
>> +    34) # of times active_load_balance() was called
>> +    35) # of times active_load_balance() tried to move a task and failed
>> +    36) # of times active_load_balance() successfully moved a task
>>   
>>      Next three are sched_balance_exec() statistics:
>>   
>> -    28) sbe_cnt is not used
>> -    29) sbe_balanced is not used
>> -    30) sbe_pushed is not used
>> +    37) sbe_cnt is not used
>> +    38) sbe_balanced is not used
>> +    39) sbe_pushed is not used
>>   
>>      Next three are sched_balance_fork() statistics:
>>   
>> -    31) sbf_cnt is not used
>> -    32) sbf_balanced is not used
>> -    33) sbf_pushed is not used
>> +    40) sbf_cnt is not used
>> +    41) sbf_balanced is not used
>> +    42) sbf_pushed is not used
>>   
>>      Next three are try_to_wake_up() statistics:
>>   
>> -    34) # of times in this domain try_to_wake_up() awoke a task that
>> +    43) # of times in this domain try_to_wake_up() awoke a task that
>>           last ran on a different cpu in this domain
>> -    35) # of times in this domain try_to_wake_up() moved a task to the
>> +    44) # of times in this domain try_to_wake_up() moved a task to the
>>           waking cpu because it was cache-cold on its own cpu anyway
>> -    36) # of times in this domain try_to_wake_up() started passive
>> balancing
>> +    45) # of times in this domain try_to_wake_up() started passive
>> balancing
>>   
>>   /proc/<pid>/schedstat
>>   ---------------------
>> diff --git a/include/linux/sched/topology.h
>> b/include/linux/sched/topology.h
>> index c8fe9bab981b..15685c40a713 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -114,7 +114,10 @@ struct sched_domain {
>>       unsigned int lb_count[CPU_MAX_IDLE_TYPES];
>>       unsigned int lb_failed[CPU_MAX_IDLE_TYPES];
>>       unsigned int lb_balanced[CPU_MAX_IDLE_TYPES];
>> -    unsigned int lb_imbalance[CPU_MAX_IDLE_TYPES];
>> +    unsigned int lb_imbalance_load[CPU_MAX_IDLE_TYPES];
>> +    unsigned int lb_imbalance_util[CPU_MAX_IDLE_TYPES];
>> +    unsigned int lb_imbalance_task[CPU_MAX_IDLE_TYPES];
>> +    unsigned int lb_imbalance_misfit[CPU_MAX_IDLE_TYPES];
>>       unsigned int lb_gained[CPU_MAX_IDLE_TYPES];
>>       unsigned int lb_hot_gained[CPU_MAX_IDLE_TYPES];
>>       unsigned int lb_nobusyg[CPU_MAX_IDLE_TYPES];
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a19ea290b790..515258f97ba3 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11288,7 +11288,20 @@ static int sched_balance_rq(int this_cpu,
>> struct rq *this_rq,
>>   
>>       WARN_ON_ONCE(busiest == env.dst_rq);
>>   
>> -    schedstat_add(sd->lb_imbalance[idle], env.imbalance);
>> +    switch (env.migration_type) {
>> +    case migrate_load:
>> +        schedstat_add(sd->lb_imbalance_load[idle], env.imbalance);
>> +        break;
>> +    case migrate_util:
>> +        schedstat_add(sd->lb_imbalance_util[idle], env.imbalance);
>> +        break;
>> +    case migrate_task:
>> +        schedstat_add(sd->lb_imbalance_task[idle], env.imbalance);
>> +        break;
>> +    case migrate_misfit:
>> +        schedstat_add(sd->lb_imbalance_misfit[idle], env.imbalance);
>> +        break;
>> +    }
>>   
> This switch statement could use a helper function.

Sure, will update this.

>   
>
>>       env.src_cpu = busiest->cpu;
>>       env.src_rq = busiest;
>> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
>> index 78e48f5426ee..a02bc9db2f1c 100644
>> --- a/kernel/sched/stats.c
>> +++ b/kernel/sched/stats.c
>> @@ -151,11 +151,14 @@ static int show_schedstat(struct seq_file *seq,
>> void *v)
>>               seq_printf(seq, "domain%d %*pb", dcount++,
>>                      cpumask_pr_args(sched_domain_span(sd)));
>>               for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
>> -                seq_printf(seq, " %u %u %u %u %u %u %u %u",
>> +                seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",
>>                       sd->lb_count[itype],
>>                       sd->lb_balanced[itype],
>>                       sd->lb_failed[itype],
>> -                    sd->lb_imbalance[itype],
>> +                    sd->lb_imbalance_load[itype],
>> +                    sd->lb_imbalance_util[itype],
>> +                    sd->lb_imbalance_task[itype],
>> +                    sd->lb_imbalance_misfit[itype],
>>                       sd->lb_gained[itype],
>>                       sd->lb_hot_gained[itype],
>>                       sd->lb_nobusyq[itype],

--
Thanks and Regards,
Swapnil


