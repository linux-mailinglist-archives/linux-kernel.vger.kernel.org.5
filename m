Return-Path: <linux-kernel+bounces-79454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F0862277
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D80B283EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1412E51;
	Sat, 24 Feb 2024 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hiy73Hey"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84877DF42
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708744526; cv=fail; b=W9bn3U2tZE1UcDK7U0N36JxGwdvjspGj1vTUSq3LLJ+b5XJpNaxlNJ23GbNyu5dz/2Mfjx+5BL8bUwlDUhmBtsOzu52au4PYssv/CyiCb7aGEL1b1ftdNYreAKO/jFYW9kiJeX2lP6dyaemjm+/5D+pvNXnafvlE5sSSnK4rBDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708744526; c=relaxed/simple;
	bh=OQBlrJ8/nSzEdSMmQa8ycK5+1FZc5f4ymVOVhErLk3Q=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sksltYnf0ajnLZQK18zlgKiqsvPSWZmzsnKqzvnDq4PNGHf/zROr+AY4WJKxSxOmTnZ2TeMguPm+xhiA9/RUhM8a6YtFapqvoLHnp2W/yHvFeHEkdH3dH3aTtJXtSiVCLFwv7zrXa2KMOtRWyu0PkPG9Xj3nS3kWSIEw3GEKal8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hiy73Hey; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee07u7abCpYE1Xez54s1gLXxh0Ne+YuMAWE7FVYYDHVFoPW0uCRTFuauiWNXDto9XP35fR94I0dQFdzrhZSIk+0RXmd5VGdqeRSeds/Ncy2Ou0F6zGCvSfP92oMfrKDrrWuEvGYWoJRsluhMuqqIb0CEnvHWLWfcnd32XKvhfiRJnGP8kBRw1dBdp9jDkoLcebGgwoHYMLaLiMEKARFVMh8abn8sQqXk/pDkxAZnCqqTi4CEBdfXUepwoaG/Boj7XmW2isRep5Bzmr2zY5obwwDEDSGwzj2F7wyuZIOp8b9arjmGOTVnARUJhtgJD56Oef66/M/AaHe6kdYZIvUm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m02xqox/TViLPUFtnf6LznVaaXcCr9zcQto68pTmHxQ=;
 b=nyNbbz2HGpPP25r5DPDdbCFkmg6+iI+rK3DfOHJqEJn0xfY7SaAamWYCMxcutZr5aMRyQoogxfXDNIIdxUyDlbNxtZRmxtmmOcAAmLh53+3GDwm7G3vL0ea6xnE5QrNV4twxB6NIJZmfvYsyHtFjz+PodyG3hzsRz32iLZEmVxKo15O+UzvkXgqkl/GNsF3/TKkCImxLCfAmhlXX09cCQWh4SJd0KFVIgokhHT1zEW/gIEhvIkCdRJ7zyiouIBrThx9l1ZOiJsFkxTJodNeHGvr9ecuAisASEEYeHwqLycLdtO0ZO3IVHIvQcfxQ4RrhK3yTynupFjIH2VbQCLfbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m02xqox/TViLPUFtnf6LznVaaXcCr9zcQto68pTmHxQ=;
 b=Hiy73Hey3Wue3+3v9Kuevd9gM0v3lgt9raN/SatrZC/prQeTzo0jDter0O+JNHaGUIWAoBCyXEzb8FZuKO1aeKpnUpeayhT4tj/KeyZSIkwQ9348qUore1ci/OLINUgjexNFd01XMWiHXtvweoWC7t87mrteEJ58WuqAL2788zs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Sat, 24 Feb
 2024 03:15:22 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::ed30:7c14:9d31:bd8a]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::ed30:7c14:9d31:bd8a%4]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 03:15:22 +0000
Message-ID: <cd56eb4e-520e-4ab2-a041-0a580cb42e1e@amd.com>
Date: Sat, 24 Feb 2024 08:45:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
To: Ankur Arora <ankur.a.arora@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com> <87zfvtg2mh.ffs@tglx>
 <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com> <87ttm0dwhk.ffs@tglx>
 <87bk87c1n7.fsf@oracle.com> <f32b90fe-2d56-4e9e-8f44-c7ee662af43d@amd.com>
In-Reply-To: <f32b90fe-2d56-4e9e-8f44-c7ee662af43d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SA0PR12MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 8accebbc-d32e-42a0-8488-08dc34e6d5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GmgE/qT5XIdL6nUAX97Eb/GVQqU8tPe25T/r0CjGCPqSTY32WZhYxv7/BzVit0pTMpdwesH2m/Oi0HqZs8E4xnYtICyNU09zy6mEJgYJCvRGBp3kTVs7LOZXBhXl2D/om9R2zf4AWvrituV2KAcSQYk5eSSBdLtD4gvbwY0VpmR8uGnZNbDVeB2Dob44PexFOsgiOibG5lmadYRX9/KLZ7DdPYAd0G84wA5viViVHKfxdumkXSyorKZC17AEvZRW0yNhmYXf3utTM8LM5wwyfVvinAr/mvWbA4YF/7j307HmmO27IAy3hai/4CPh7yRliQElPE9dcxZtc2gKXXQi5GzC085sltAxnnJ1bYMDFTj7HhQBj8VyGeBU9nXiULdDCA7JUkAPa5VXT9O3UJIbFtFbk08IRczJE+pTNdh4U5Y2NZeFBxua1J4MqpsRVjAO8KVp07iObH3ks8Qm7kUSTdrf97IA8BbIUmyIXUeULUKd/bUKfZip/eG5hgICxXMbEUxXgKudNqxhS4/bWheGC6xDO8cfoKpbhJSEwnQjv9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm1ELzdiQlV3VllUWDQ3cVJpYkpBbXdMTW1zbEpMWHZNZGZaNHc5d0xlc3Z1?=
 =?utf-8?B?V29wZ1RUcHpoQkNrL2M1bjI3WjhLMlhQNDEyTDUvUi9udjJVTC83ODN2MHpN?=
 =?utf-8?B?Zk13L0JtbHhyTHFKSEsrUlZaVUNJaHhRb1JHVnB0SkVSa3UxSFJZTDBBVmxE?=
 =?utf-8?B?cUQzSzdHbk92YTEyMjBGdGJDVXdkYXpZckZXeW9KSVUwREYxUTV4M0JXelFk?=
 =?utf-8?B?NWg1ZERzenl2aEF5UHltRWQvZDJDcVhqZElxVUNWUGlRaDR2d0c3NnY5TzRy?=
 =?utf-8?B?Q2o0aGt0c0R0MEJnU0YwYWlZZnBCQWk2eFY1RFNWaFZEa0FrTGsvUjN4dW1B?=
 =?utf-8?B?ODhtVDVMQzN4djhqMXQ3ZDhScE5QMmlrWmpUcXZjTGpFRmUvM3J1UWxqbm9G?=
 =?utf-8?B?VDhxa1FRTFZnbExxNnBhUkU1TlhBeGZJZ3EvZkwwdjFwbFhGZ2FGK1lPWEVJ?=
 =?utf-8?B?ZHBjcWRQdVBCeXFYeFlhOXRYN3B6VnZhanJCb3J5b05sR212aHpTT3JrTHlG?=
 =?utf-8?B?NzVqRjFKSEYzQUZPSDNEb3FUYnJGaWpXM2M0dXluNTdUbmxJTVV2Y1VGS1NW?=
 =?utf-8?B?Ry95NFNObUxxcnpvN0t4Tk5MRVk2UGNBNUpQT25pTUJFR3g5TU1ERVdXbEtI?=
 =?utf-8?B?VGRleUVkanN5bXcvTjNDWEJXY0l5M0dPbDRBVWRzVzRxbWhyZXNWV2YvUThl?=
 =?utf-8?B?U2EveEJRWksxMTllUm9COHdSbVd0TU04Zk1oM1ZSK29CWU9ReW5uNlo2Uk9X?=
 =?utf-8?B?d2lLTjluUFE0eFVOWWtVandNcGp6TDFWZlh4di9jVFVhNHlyUU1NTDF1NHZs?=
 =?utf-8?B?NmZibEhKSmpFbXlFMnF5REdWSTBxcXdqczNlNnF2Zm5kWmQvUVhFdWc1Q3dH?=
 =?utf-8?B?WXJ5ZWd5TmpwMWVBcXlUZUFRS2dQNk9RTG5CdzZqVklCWTRaMjVOQkVnL3VQ?=
 =?utf-8?B?MERFYTlpdXpmQVVzOG5NQXR0YjkrUk5OOWY5SHYxeExPQlJvVVRnRlhTOGVG?=
 =?utf-8?B?eDgrd3hiRXhsZXljN2FZWTRhd3J3MWR4bGZVSkw2K2pSYkUrM1RZQ0NiUEUr?=
 =?utf-8?B?aEhSVjRsMktwd1Z6S1dKRy9MMzR1T2VpdEZEeFlCZHdQTUhMTTkwVStRT2tt?=
 =?utf-8?B?cEwwRGFNeXFoSjJxWENWSHI2UjhobUhTS3FwTmtRbTdRYXBUd0QxUWR1RDJm?=
 =?utf-8?B?UmZvT1A4YXNubG4wdlBKT0pGRHJwNzV3bVJqRGdLMEkrS0JWUDhHaFZzaDdq?=
 =?utf-8?B?aERUdVgyMHcwd256UGVKL0JRVS83SjVYMXhUUHNFQzEyTk4rZ2syZldwTWZi?=
 =?utf-8?B?VDlsV1VIcnhlcHNBZHZDbVl3NlArbk1xUllaTERTcnhPMk5iWnptS09aT0dX?=
 =?utf-8?B?M1FhbjFBVHF6aWw3UHk1RzB4QXRRbktTRzdtZ21LVTFzMGF4Qlc4NHYzVksr?=
 =?utf-8?B?RDV5YytaZy90d2ZlZXREb2VaL3prSHl6V0ZqU3BRQUlMaGtBVkh2ZXJoMExq?=
 =?utf-8?B?YlBoUjVQOWQ1RytObEFsdktJeDg3WFN1YjJ0NlRSd2VRWUhIdXdaVDhJdStU?=
 =?utf-8?B?MmRzWW01SkpTdWkxWmF6MFRyTFVnU3JzNVdseVZMQ3V0SldRY2p3cDJPME5Q?=
 =?utf-8?B?a0RzWHBHVEdmUVRVb3NRL2JScEE2bXlFejJESEh0OHRYc1lyNTFQUUU1V1FN?=
 =?utf-8?B?UnJDSFZ6cUZoeDQ0QzZoLzk2VVc4YlVxWVJuNXBVcGJSZWJYV2tjdXQybkwv?=
 =?utf-8?B?UXlreWRCa21IZEM3WkRQdTU1c1JiVHRyWUxVK2UzbjFHYTQ2NkNldEJtMldY?=
 =?utf-8?B?ZUJUNGh1cHgvcFZtZ0M3ZmNPeHM0ZnpURE9ubStDUkVscngwK0dPZ2FoMGFQ?=
 =?utf-8?B?N0VFVXNXSjJlUDA4WEV1dTR4THQrbEFnRmRRVWRad1VIVDdxUE1oYnhBcVkv?=
 =?utf-8?B?c3hpanVQZGZ0cG5JaUcxR2xNbHlzckRmR3N3WStsMDZDUVFxR3p2NE9YMFdT?=
 =?utf-8?B?NjhJcS9JeHBiM1o1NjNzb3hLTzdmNTh2OWIyS2tYWWdpcFp4dFRuSEJDUHh6?=
 =?utf-8?B?R0thb0NtRk9zRG9jMFBWT1ZZZFF4Y0graVJZQVZQRTFnUTZYWnV5c2w5Wi81?=
 =?utf-8?Q?FlR9qiansc0aOQ7NNHDcWbQ0W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8accebbc-d32e-42a0-8488-08dc34e6d5fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 03:15:22.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZj3MDsRtySUNwNlXQUQgZS90xytpgi342LxApnbGOYAWS3FQorZpzqOk9BI2Ub9OL1G+Eqaat0Sj/L3LRH0jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558

On 2/23/2024 11:58 AM, Raghavendra K T wrote:
> On 2/23/2024 8:44 AM, Ankur Arora wrote:
>>
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>
>>> On Wed, Feb 21 2024 at 22:57, Raghavendra K T wrote:
>>>> On 2/21/2024 10:45 PM, Thomas Gleixner wrote:
>>>>> On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
>>>>>> Configuration tested.
>>>>>> a) Base kernel (6.7),
>>>>>
>>>>> Which scheduling model is the baseline using?
>>>>>
>>>>
>>>> baseline is also PREEMPT_DYNAMIC with voluntary preemption
>>>>
>>>>>> b) patched with PREEMPT_AUTO voluntary preemption.
>>>>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>>>
>>> Which RCU variant do you have enabled with a, b, c ?
>>>
>>> I.e. PREEMPT_RCU=?
>>
>> Raghu please confirm this, but if the defaults were chosen
>> then we should have:
>>
>>>> baseline is also PREEMPT_DYNAMIC with voluntary preemption
>> PREEMPT_RCU=y
>>
>>>>>> b) patched with PREEMPT_AUTO voluntary preemption.
>>
>> If this was built with PREEMPT_VOLUNTARY then, PREEMPT_RCU=n.
>> If with CONFIG_PREEMPT, PREEMPT_RCU=y.
>>
>> Might be worth rerunning the tests with the other combination
>> as well (still with voluntary preemption).
>>
>>>>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>> PREEMPT_RCU=y
> 
> Hello Thomas, Ankur,
> Yes, Ankur's understanding is right, defaults were chosen all the time so
> for
> a) base 6.7.0+ + PREEMPT_DYNAMIC with voluntary preemption PREEMPT_RCU=y
> b) patched + PREEMPT_AUTO voluntary preemption. PREEMPT_RCU = n
> c) patched + PREEMPT_DYNAMIC with voluntary preemption PREEMPT_RCU=y

> I will check with other combination (CONFIG_PREEMPT/PREEMPT_RCU) for (b)
> and comeback if I see anything interesting.
> 

I see that

d) patched + PREEMPT_AUTO=y voluntary preemption CONFIG_PREEMPT, 
PREEMPT_RCU = y

All the results at 80% confidence
		case (d)
HashJoin         0%
Graph500         0%
XSBench          +1.2%
NAS-ft           +2.1%

In general averages are better for all the benchmarks but at 99%
confidence there seem to be no difference.

Overall looks on par or better for case (d)

Thanks and Regards
- Raghu






