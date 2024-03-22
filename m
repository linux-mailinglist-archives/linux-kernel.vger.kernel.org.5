Return-Path: <linux-kernel+bounces-111651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C37886F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025281C226AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5F643AB2;
	Fri, 22 Mar 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wOnkJV+d"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EFD4D59E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119054; cv=fail; b=lyPgRlPq4pVVVblbjin1EsY+MA9fkSND82kN+6T9xKqVmCjIuqiQPOeFdAQUaKL+bmvKz9dcPDEYQjELp9ajTHHNezTTaqOYjLXtVzeDx3KC/PGIcVsz/CpMK2sROoPJKy+njhbjrQ5IzP4Z8Q/CwRFtPv8f4EUY5pBoOnuubV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119054; c=relaxed/simple;
	bh=OuO8ETOPK+mbwqYvyfbNScD/SOpCtZ26t9rOV36eJHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lFbu5ZojRMAePbcnO8hmBR6rvTcB/6p6t9PVD8wdq6jaqHTi+GGWGJkVuxKIZM8ojr/ooqym4oeppiSTkXALD/FCgJjrSBQph3i9YD3SM2uqkV8rwtOW1y24whZgTMEEUyTdtVIk70UJ477/BWMbKvN2hheNNfZ9buDvoonyXDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wOnkJV+d; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAUNzto35Vf9BpeC90+eEIibfZfA9ikQlR4tcKVo5KvJ5X6675c1iN7ZuwVpK/WMN9BwWrEixGI2z0deQdq0rMFg0ADl1FiHVhFwm3UpJBaU52Wgbw+np/zuknjZllqF4gn5Q4mBKeqijNL0XgIgHltjet/Aa0A+uKmnDhqsP84Klfbwhy5FP+LPgCPLg36QeIyfYxPbU271r6mr78/1mcnyl+h2+3K/wcBWKxAxYDqzdBQ3srfWzgGfzvKlZ6f2Tyi2KiEH1HD0L8lLlvc48/OOk7845gYOAtxAo61MRQoxI3mrtaEHIDO4Li7x62Dw7NVEfjnttkJUcKo0mg5z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCcb8XJpa3+DihjSxAFnoc8PUnF76Tq2TDUL+rAfjnA=;
 b=Jf3XYuNZsu6zmZNsXBefcMlMQ4PRrf8wJB7M7nbTi+LBlFYnsDwc6s8pPyIF9LZ86d05lzOY8g1s+nDv6tu+7EgIoCQMPI67MqU6UVJDkV0OnrfXAPwNCztIESoq86cVczabkMa3KSBFuM8fbmRl2mnS1D6AIvf68SeQH6soT+cgj2WRZCbsUGLVcYBgZTTxv9sUCo4JOtvPclfWK8uGeyyWCfkqqble0/pEojE0Rvj39IU0EoIYzejmBfDC5FisFR4aBeK6ODN3EpH4r2pAA1edPz2pjwvhve711uIg/YkHtjOhEKzhG3uooxzKIJDcY68fAxeqThO4nYQu3rInIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCcb8XJpa3+DihjSxAFnoc8PUnF76Tq2TDUL+rAfjnA=;
 b=wOnkJV+dZb7WOtNDk0zKPxoNN7nIIGQ5sVd94eFKpsookkLUCHq6AwihhVUb+uTP3SRvlzxr7wiNgXCaOBQZPnVyq/EWv6IUT3HEHnlzZDXVAO7pcT2VW41zya1/Fl46Gjyq6XhQu37dBFLQVLVFn92ppK2qdLhCXvbf9lk+RtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:50:47 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%5]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 14:50:47 +0000
Message-ID: <9679cc44-fb90-d1ca-7c9a-10d0f6f5d3c2@amd.com>
Date: Fri, 22 Mar 2024 09:50:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, dave.hansen@intel.com, bp@alien8.de, tglx@linutronix.de,
 mingo@redhat.com, hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
 <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
 <bbtfbfkg6frhpvf34gqnml7mdgqtyt5khaiqi657nd2kbnlbib@yarqgrrszf4v>
 <8f449fbb-c6c0-e864-befd-a3f95a89e85e@amd.com>
 <glorzobyf42wylp57izgiukbe33c6ez5mgiwxepgn6pt2h4lr3@aqdas5q75mcb>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <glorzobyf42wylp57izgiukbe33c6ez5mgiwxepgn6pt2h4lr3@aqdas5q75mcb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0067.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::17) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7fe22d-5e70-4be3-ab2b-08dc4a7f75b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Q9Y3osv7IvqLBmm1QFlLmL/J0KY/5HnqnVoY6vwA5qLo962a9AUFhLBLlR1UF8DtItmI7SMbtMh+fZ5g15sB+0fKo4rdMoN6uAQph+NZeKEBXO6Pfk7zJGY+kJ+sBEAagf3u+ojTuWwqpmE2yKbeuyYRNIuI0aHV4B/NibQ2SWUes28IX0MqdiduyWJkp/wtMZ69vAhujFEBTEbO88tzmfMvIU9dV6k061wyatxiwZBKjW0XaS4o170Ry4QxSRivT2vhxsgpzw6Y0m+I6KN117+yYjVu5P/MEBatpA5/2L9nhannhkqHoZ7x/NlgILweTHMdGKJx0bj6OqJ4apjqyw1Cjo0dCYhoy2iuf91BVdLKpFN80r+l7HjbeCNedVoYOFiGqnEz1vJGfgn7czogQPw8FlsVXO3CYn0NspjIg29Idn9yCInRORzLJFBEaRtgpI6D2SPy3xwhX/g8/s1QQEdXJhMwqwliQ79mw/Ma3tFT2DNMMr0YVeY0HISZ0YRY3mjWVHTLCxwMFy+eu2Jd1nh5FsNnQQ8eYeaYh92yyYrkfOhOiDUuoGpiQF5Lx8vz8RqCOSSGxEhj88uqakcSqH7lEV+LZRfuU8t05zOLbWiLj5mPFJWcggeuDnDJBZ+XTHQvvF+xr3mzRCYAFd0eySCoPTxbEIepl7CsGlDuas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3l4Nk1RNklHODRyRXRwMDNZN2k5K1Z1Q081WURXUGNHNVdWZWl6T2llMHJj?=
 =?utf-8?B?NkR3VFBzTjN0eDk3eFRzeDU3WlhOZFZoRmdrTWdPY1NDQUpKVEFTVDhRQmhU?=
 =?utf-8?B?YlBsQjNYK2F3TDZmMEczUDlxZ29GU0dObUxkaFltWEhUYUQwbnJ0cnBvVG92?=
 =?utf-8?B?KytXcGF3dFlCZGo5WUlTYUJlSUVWczRlWGlITGJsdk12TDlIZ2dadWNUR2Jm?=
 =?utf-8?B?bnhZblZCNmt0bTYzNmM5WXR4M2dhQ0tUZWRON1FBcmxleFNUUlkra0h1OFpN?=
 =?utf-8?B?NjNYT3JMejlJWXhkL3o4ck5jYU82UDl2UGJGcUxHSFNrZzJTNG5ranVCUzRl?=
 =?utf-8?B?elRKRGczS2FSajg5R3dqZVMvRVFtT1RJWVBGZFJRK2pCNVovYUxzTmxmUFpN?=
 =?utf-8?B?UllPbEgwTC9wbmt1RlIvRDF1WDhKY3RrMnhCcWV0RjVmYjd0R3QrVWdTMkdY?=
 =?utf-8?B?SHFUVnFPSm9aU3JRQndETE0xcFlRaHhEdXRZUFNsZi82V3BNTDlLbVM0Tlpr?=
 =?utf-8?B?N0orSDAraE1aQXVHMzIwQTBzV1dxOUREZkxmbmJvcC96d2luVVJHeXNTTzdW?=
 =?utf-8?B?Y1VvalNLY2pJQmcwelZEd3ZKTElkMDVkRWoxKzlTZmEzOGFDNmo4dlY0STU3?=
 =?utf-8?B?OWdSMm83dHVYc2lqRmIveTBGSDJEL2tyNVVZR3JIRzNCMjFSbmRjVGFLdmt6?=
 =?utf-8?B?SUx1NW5iZ3BOaTlBSXpiZHpWOVViWGhRa09EeklZaWErM3VOcVRTN2lOakFE?=
 =?utf-8?B?ZXROM2hBSUZXK2RKdUZXeGZJUW9ZYUtDL1UvK2t5TEVLLzMvUDV6QjF2TU1V?=
 =?utf-8?B?OVVnSkdpSEFnekduVFAwZW10SFBTbU1jMy92Y2JrWllkQnZUeWZDV2x5cytx?=
 =?utf-8?B?UUQwajhiNU0wZEU0dHA2YnRucUtrQkhJbGlvRXlaamQ5aTJPV3NlOHhJUTFP?=
 =?utf-8?B?b0ovTmdIZjZONm0zejhQZWNrRm00bUxtRlVDZ2hDbWNaSG5tVUlvaUN2di9k?=
 =?utf-8?B?NnM5ZU1ScWFOemdld0lET3hJMEVWVGNXTENBTGpEdDV0WnMxOWJMRW9LQ3M1?=
 =?utf-8?B?Uzg4ektISmVDY1hBaXUvWjNPR1cvTzA4WG4vMnBjZGdneUlrUFdpRU9zRkhP?=
 =?utf-8?B?aXB3NFAwa2M4SnBHUjJnbUZCTEdobEVGSkQyb0puc2tYTk4vZ0hySjNCdFhV?=
 =?utf-8?B?Y29NQUZTd0tqL2dDVlBDQnBWd1pQSk5EWjdUZ3RxaHk4ODJFeG5vUTAybk5x?=
 =?utf-8?B?Wnk5aGJZdjFCK29iL2NLUVpoQ1pRRndjZnJPcTVZQTRWRjJzZER1SzdHWCtS?=
 =?utf-8?B?Q3lwSjNBUXFRR2hoT0ZBYTVidDgxZVdRdGN1TSs1bkc1T3ZGSEpqaWdrY21t?=
 =?utf-8?B?ZFduSzljOGNyTDdGbXladHEzNjhCdGZnUkcwQTNmeUFxdGFLY1VYU0Rjb0xp?=
 =?utf-8?B?V3EzN0loY1BJWTJ2L2N3SlAzWEpZOURrdWl2QnVOV1pRaTYrNzA2M1I0Q1Nq?=
 =?utf-8?B?cVFwV2hFdWt6S1ovUTJnQkYyNVFxYW1GVzFaKzdyY1FRbnRzejF5OTZqTFUy?=
 =?utf-8?B?M3VYcU5vTWFpMzFsdGIwdktaVzR1Q284SnFqSUJReUtqWFd0V2h0RkdTbWRl?=
 =?utf-8?B?aDFrOWQzTXNDZjNocnhYUTE1ZVp5aWpMOWFaVTVlVzZsTDU5TGJGMktJWndo?=
 =?utf-8?B?a1kzMHJpS2FzRE9oS0gwK3lidURNd3hlNHFKY0plam16ai9UN2xidlhoSklK?=
 =?utf-8?B?eXZlYXJEUlFEY1ZobHBNSDRMbEdJRkI3UFUxS2gxRUtIeFpTYzN6SE5ZQnlo?=
 =?utf-8?B?Q3lDdlNkNmgxb01LVUluZGI2OHFEdld2MmtWeXVaendHa21hQ2ZxaFZrN2wy?=
 =?utf-8?B?TFE0Ylp5REo4TDRodW1nTHZmK3BydlgvYnk2OVlZTG5IRXNjMFNyVWc4bHM2?=
 =?utf-8?B?Zmc3ckVxa1o0a2FodHJmTFNyUVlmZVRmcjZPMmJ4ODRVTnV6WFVMd2xGdFBv?=
 =?utf-8?B?L0U3cFUxNFlkSHpXZ09LTG94S3BDS0tkYkJpZ3RoUW9kamhuZnMzRmtGczNT?=
 =?utf-8?B?Tk45RTNCYjVDenRuL3dWL3Y5WFZQMzN2V3QwZkROTFA1dmhqcXE4VFhPU21O?=
 =?utf-8?Q?Z/Z8x3t4ZfKtc6T/fxYajHdXF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7fe22d-5e70-4be3-ab2b-08dc4a7f75b0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 14:50:47.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu29GymqtpdjspLxz4nEWeaf9BUEhymft1BEfvmKGXO1GzvK7qGxDMsTXcwdhhE2cO+BKHPn5r3xHOlhMHdQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

On 3/22/24 05:40, Kirill A. Shutemov wrote:
> On Thu, Mar 21, 2024 at 04:02:11PM -0500, Tom Lendacky wrote:
>> On 3/20/24 18:10, Kirill A. Shutemov wrote:
>>> On Thu, Mar 21, 2024 at 09:48:28AM +1300, Huang, Kai wrote:
>>>>
>>>>>> Hi Tom,
>>>>>>
>>>>>> I am not aware of kexec() support status for SEV-ES/SEV-SNP guests.
>>>>>> Does patch 1 break them?
>>>>>
>>>>> SNP guests can kexec with some patches that are currently in process
>>>>> around shared to private memory conversions. ES guests can only kexec
>>>>> with a single vCPU. There was a recent patch series to add support for
>>>>> multiple vCPUs.
>>>>>
>>>>> Patch #1 doesn't break either ES or SNP because we still have an IDT and
>>>>> traditional kernel addressing in place, so the #VC can be handled.
>>>>
>>>> How about plain SEV guest?
>>>>
>>>>>
>>>>> Whereas patch #2 has switched to identity mapping and removed the IDT,
>>>>> so a #VC causes a triple fault.
>>>>
>>>> That makes sense.  Thanks.
>>>>
>>>> Hi Kirill,
>>>>
>>>> Does TDX guest have similar behaviour -- that WBINVD in stop_this_cpu() can
>>>> be handled although it causes #VE, while WBINVD in relocate_kernel() will
>>>> just triple fault the guest?
>>>
>>> No. We never handle WBINVD #VE. Guest cannot handle WBINVD itself and the
>>> only option is to ask host to do this. We cannot guarantee host will do
>>
>> Is the WBINVD performed or ignored in that case?
> 
> We crash the guest if it tries to use WBINVD. There's no legitimate reason
> for it.
> 
>>> anything useful with the request. I guess it can be potential attack
>>> vector if host strategically ignores WBINVD to induce bad guest behaviour.
>>
>> With SNP, memory is coherent so there isn't a need for a WBINVD within a
>> guest and so issuing it should not be an issue whether the hypervisor
>> performs the operation or not. I don't know what can happen in the case
>> where, say, you have a non-coherent TDISP device attached or such, but that
>> would be very unusual/unlikely.
> 
> Looks like SNP is in the same position as TDX.
> 
>>> And it is not good from host PoV either. If it does WBINVD on every guest
>>> request we get guest->host DoS attack possibility.
>>
>> Yeah, that can happen today, regardless of the type of VM running.
>>
>>>
>>> Tom, I am curious, how do you deal with these problems?
>>
>> If the WBINVD is being intercepted, then it will generate a #VC and we use
>> the GHCB protocol to communicate that back to the hypervisor to handle.
> 
> I would argue that forwarding it to hypervisor is worse than crashing. It
> gives false sense of doing something. Hypervisor is outside TCB and
> considered hostile.

Since the memory is coherent, it really doesn't matter what the hypervisor 
does in regards to WBINVD (ignore it or perform it). And the hypervisor 
can do anything it wants on any exit, regardless of this intercept.

Thanks,
Tom

> 

