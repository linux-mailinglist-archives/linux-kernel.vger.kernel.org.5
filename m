Return-Path: <linux-kernel+bounces-75887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4000E85F054
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5A71C229A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3155A1774E;
	Thu, 22 Feb 2024 04:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RNJvqRwv"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B314A8F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708574779; cv=fail; b=LMdG6KTh2G2XkbWJm5JxCQnTi5CuBrUoaeBsJ/TjoG/GOZrcyGPr/w3KUCQYYRclDH13zcVY+u7x7xqx5hRiZwBBXkCuDC/k1yAFD06acFf+Ie+08eDqPeBjwreYkZ49k4UFSu7cwabE04ux4kWO1gkiYPMjSs32PtkXVTog/bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708574779; c=relaxed/simple;
	bh=0+GMCZJ/lb3T7ZyjYyj8W4/5DVEVKUw9N4j/7qHhKAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcO36jq/wKR2KM4nfaCLJyq9Qn3p5Q4baWu2zZSOuNloGpnLUesPMkgb5rWI7XnjRmSdDnkSKa40bDyrvfQUFW/X0mQFwgfD7v78rhtwjm5dgH4WFIm+nrq8gY374lW6Z4wjcbXKfB11ZcyFqTTz4N6u99n9DHXhMxF9hF1xeWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RNJvqRwv; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdFa3KlM6oyGsHnHug2bAfnbuaGtiiXrFVrmViQy9t94MnwSpw6KWnTovybelpmOd3sYBBUIPXknLfSPCVIXqgqCSuFnnZy2R4k2rzZWsPXXtPCYdcSHRktwgcImGtfVO9WnclPZCU4Hwh2Wa85CrjGHHP9wyOjcx0lbqLdHndf+sBga+gF+4ncSeZ3XiFsQwPXXFjTwRBFvm6ffNn9Oi+K65wJsYBF7MrciBwxGdGAjZ8gboTjmhYgvwIbbmooFPSc3JcLNO0FoSQ68fS6NNar4W/VY5wluRwrLoNKL4Cb3/3/aK0dhcoZ/gafXykdmGQlQSHMF5M2kteaNrcODQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivEGcCM/LlYql8H56zagv1u0+PTcdw3mNtdsJ7zWhJk=;
 b=Kb2mlU4Rv9z0XbqQheScavB0S1teL3/kK9VVd4AyshSI2ZFYJr0/1/32LCTSEeAyqBX4FQa4CLoxDykA0pL9aMe6EAKcVZXDQ6V6QaroCbMwDOVz8xiyYsasrzkRbQVCKfI6At7Zicr8uu38b48sf6IFYMOWClOv8hQ8oEZLZvS52vjFp6iCHnbbPEc6aRPz0uTmNv1znqVOw6H8hBve16fTiIn/T+hvJq8O+mmkOIyIA5e6ATeeZBo4bSeySOSRcGJwwwxuN3yFrptLpEBMPMhCzwU14j9z2H7jbKpyllnpesMOMa7E5t1I42XYmBOUQbBQ9RxGz7+VSSK1zGhs3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivEGcCM/LlYql8H56zagv1u0+PTcdw3mNtdsJ7zWhJk=;
 b=RNJvqRwvZ0pXtxRZYqbnJL/n8oGtGqkxhEBhO/jd0mgcgRDb7e89n9bfCpyaRFNahGBtgZ913cGUP//kK7NCni8E3vXEjnXbvudP22Uzvc84UCepitHK5Iyiwo6asRdP/PaGMwltGjpfeBnqfD8L5EpUhqP+5oIUGgkoO9b8cWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Thu, 22 Feb
 2024 04:06:15 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::7bca:b335:5e25:753a]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::7bca:b335:5e25:753a%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 04:06:14 +0000
Message-ID: <bc21a164-77d5-0e6a-26f8-93573e875e28@amd.com>
Date: Thu, 22 Feb 2024 09:35:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Content-Language: en-US
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
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
 <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com> <87ttm1frgf.fsf@oracle.com>
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <87ttm1frgf.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3a3c12-740f-4338-a899-08dc335b9c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+HVDFK5Bt8yxe3Mh+1Gl1LIIHeCz4d7M6/r0vXfL5SdITLhfYiKfoZmax/nobIB/KcbWFpWbUUJlM6sM5HjchEndjllEEgTgj9z0f7yV2k4Mm1o7I3saU4NcIZAlnvFumbbw8uW3yCIwL/wOrIuD8uPz6znayRzc1Hpgg+CbVwQBJyIxxDQutdyYOWKPu1YlKC2BZRIi2vyaq+pWSlk3tO6vtmmf9mLfNs0LY9YzD9CY0AnczFEU+qXFKstjzexf2lj5ECbff4rpZmP3IKJwqYyMhbBg6YelwwUfEXOSxViics5aTd9WSVN2u7Myfh9UEZYEO3SousgI9XSFuzqyCF1aUnZUQiRrPwwRQx5gLzLM09stjq0uhR7qOoZrGY4pa/EqHQMfRP62NTk9PxmhpG+tad4QxRvFAIS6rBVVB7K152YmE8yP8DQR4CcZfRGAptgzpqTC0dBGeswha+iShTEVHa/76mUM/XgngsBso2gntrvUEE9opzJPplC9c5ybNTRpX9uWKMuLduuyQj1WwXoBpNXOR1qUYkzKGIwwFfU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0wrV1hJOE5MUEg5TDIrZjY1ck9zcHFYU01ucFZISEZUL3FZTlRGOWl6QkxI?=
 =?utf-8?B?VnBWc1hEY09ydGZFbGU2eEcyd1hUdDZDb3U5dng0QWpldmJkYjBKSnVPb1BF?=
 =?utf-8?B?YjY0RGdTdVlZL0ZDRXMrM1Q2V3Vscm0rNStHNVZ5UW5WUUVsU2pOVnF1OXBZ?=
 =?utf-8?B?ZmM0WXNZRkdXYzFwZW5JS25KcytJaDlxN0tVaStZN3ZNVnN4NEw3aUhneVRO?=
 =?utf-8?B?ZXdtdDVxM2djSHd1azJrVGhOY0kxTlV0KzlGYy9TajFHVDd5ampyTFUyV25K?=
 =?utf-8?B?a2FtNDRVdWNYMkJoVmxXNnBBZmYyaDBvV1BzVTBxMktJLzJPQkZNa3NuSGl3?=
 =?utf-8?B?UFBQVlNvYlhoNnFaazNUbXV0N3hJeWVld00vVHlKcXdNQWNQQVZtbzlSNC9W?=
 =?utf-8?B?RzRDZG5sVW1GaWQvS0xJMHhXS05GNGNJWVd1UG9Vb1dpRGFtR1NhYnZjQ3E0?=
 =?utf-8?B?WUhONkMweG92TFdlTDRnTkdhckMzdnVyUGN0dW1wRG5PdktvU1ZnamFnV084?=
 =?utf-8?B?Nm1RZDdGRDZ1dFlnRHNyaTRvL3RwWXJRREtmanl5VXBmMmNrODNmMG0zSXE1?=
 =?utf-8?B?U0JMQU02amhmUm01MnFWQnd0MnNnSjBMMGlaZnNOeTZRNDk5UjdvOWRxQnVN?=
 =?utf-8?B?ZVNHSmJZZzg0eHBlaTJOYm83UVF0R1Ivb0kzN2NpT2h4VWNhaWdUNUhIVmtK?=
 =?utf-8?B?SE9OQlg4SXBCQU9WMjdSU2hic2t3bGg4YTBnbDJlcFk1cWlYME9yUVBYbUxa?=
 =?utf-8?B?STgvVXVDeExVZlpFbkNZUW81TWRjTXpHUEI1MDNlTU9MTVIvbmduaC9ZSTcw?=
 =?utf-8?B?ZFVIOW82ZVFzVDVmWnhqWGZmMnlUOGp6Z0JqNjcwbHA3R20vMTZxQVp5VHc2?=
 =?utf-8?B?YUYxckt2UkcyYzdqMGpwY0tsbEg4Zjg4T09pem9ualBhdWFhMjc3LzMzRmJY?=
 =?utf-8?B?anpYRmFMT28raVBkTm1VdnZua0x6NEZWQ1REMWdvUFc3bmh5OGZrSXB5M3ZQ?=
 =?utf-8?B?SCs1TzZQS0Nac2VyZ2czdjFpd1d1TTNrY3BTMWdXVmZaNkpHbmtGTWtYZHdB?=
 =?utf-8?B?eXdGbUx4RXh5UUZkRUFYQnZJWm8xeGM2WE5CbjZsVDFKekN1ei96Q0pIYmFB?=
 =?utf-8?B?T0R0T3o5SDVZaFNGQmFyMVgvK2pzTFI3VWNtT05DUGJLREEwL1FmblplWlRH?=
 =?utf-8?B?MlluNVlyL0lXSzlycExYbDhNVzBidjEvQ1hSd3JhTnc4ZVNWWG5nWVVBQXZt?=
 =?utf-8?B?MjlSN2J5Qi9JMk1nZk51WWpWcnY2b0hWWHhRVDBoZ3F4L1JjUmc5djFSZlJE?=
 =?utf-8?B?dGVxaUw5YUFKTUllOGVrSkUzdlV3UG9VSGx3MC90V1Fmc2d2Sk8ybnd1Sld3?=
 =?utf-8?B?STFPUG51ZGhGRmhabnFaRTJiOGQ4TEVrVlQ5UUhyblJ0VmJrWnJSL2MzZ0RM?=
 =?utf-8?B?YWxqWFcrNWZJN0lzOFA5b2RZN0E1TmVXZE5wamROcUtJMzR0eFBFTWdDclNs?=
 =?utf-8?B?ckFJaC9pYktxcnR6V3d0NFlDanlFNFZtZVhoYzd1RjB6VFliMXUzendYa3ZG?=
 =?utf-8?B?NHdkdTdya1BNRGR2Nk9mWFRJaC9RMHNPMjEwMjVwVDV5UWkwMkhGQUxBNTFr?=
 =?utf-8?B?R1R0bWFVNkM3OFQ1TUs4UDZ2dWVzV1RhUjRLVjdoeWNKbU1JTmJJSFdvaUZ5?=
 =?utf-8?B?RHpwSElZYU1lNHh3N3NxVFpsaVl1cWs5WDNzblh5a1A3Q21mODEyNmUvTXR1?=
 =?utf-8?B?VFE0VVJldWFDYWd6S1VjTXcxYjkyWkd4MzhOdWt5dFZPdWlYUWZKRUkvZGRF?=
 =?utf-8?B?RklNb1MrMGU4amFLVFlEMzE4ZG94QWF3SU5IL1JUTEg4c2tyZ2RTd2NYemJP?=
 =?utf-8?B?T1lGSE10NjN5S0k3WUhBUGQ2VzF4S21NcDZJZFNXQnlQWnpEakNJN2pzTFBy?=
 =?utf-8?B?L3ZTQnFNVkRDcFpNMFRlbFpBMS9Ec2lWKzMwQU1vd0ZFSjVlL1FFYTVhRzRj?=
 =?utf-8?B?MnZta3FOdFpxaEVMVklXK2dWTUpLcUVFbVVhWTBESnVVdVFTdjRVZWhQenB5?=
 =?utf-8?B?Q1VMRTErUDd2TG82N1FGcFpTWEJCNk5Ea1pkZFEyY2s1K0xPNjdhSlNiSVlS?=
 =?utf-8?Q?CpqRfkMHvIEbqFFFZ8Y+lU/Mf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3a3c12-740f-4338-a899-08dc335b9c9c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 04:06:14.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSgb3BCPJv5KXvO6KgTsnL2tfzI9yXwJO7DQYsplXr0Xse0Etfl/c3ldJcw+fktE30nhg8Q6zkoYdhXX7x4QIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630

On 2/22/2024 2:46 AM, Ankur Arora wrote:
> 
> Raghavendra K T <raghavendra.kt@amd.com> writes:
> 
>> On 2/21/2024 10:45 PM, Thomas Gleixner wrote:
>>> On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
>>>> Configuration tested.
>>>> a) Base kernel (6.7),
>>> Which scheduling model is the baseline using?
>>>
>>
>> baseline is also PREEMPT_DYNAMIC with voluntary preemption
>>
>>>> b) patched with PREEMPT_AUTO voluntary preemption.
>>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>>>>
>>>> Workloads I tested and their %gain,
>>>>                       case b                   case c
>>>> NAS                +2.7                    +1.9
>>>> Hashjoin,          +0			     +0
>>>> XSBench	     +1.7		     +0
>>>> Graph500,  	     -6 		     +0
>>> The Graph500 stands out. Needs some analysis.
>>>
>>
>> Sure. Will do more detailed analysis and comeback on this.
> 
> Thanks Raghu. Please keep me posted.
> 
> Also, let me try to reproduce this locally. Could you post the
> parameters that you used for the Graph500 run?
> 

This was run as part of test suite where by from output, Parameters, I 
see as :

SCALE: 27
nvtx: 134217728
edgefactor: 16
terasize: 3.43597383679999993e-02
A: 5.69999999999999951e-01
B: 1.90000000000000002e-01
C: 1.90000000000000002e-01
D: 5.00000000000000444e-02
generation_time: 4.93902114900000022e+00
construction_time: 2.55216929010000015e+01
nbfs: 64

Meanwhile since stddev for the runs I saw was little bit on higher side,
I did think results are Okay.

Rerunning with more iterations to see if there is a valid concern, if so 
I will dig more deep as Thomas pointed.
Also will post the results of run.

Thanks and Regards
- Raghu

