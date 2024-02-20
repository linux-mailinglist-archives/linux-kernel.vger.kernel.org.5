Return-Path: <linux-kernel+bounces-73763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739AE85CABF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26070282E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1423B153BE4;
	Tue, 20 Feb 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tzhkc7pg"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FCA153BF3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468220; cv=fail; b=XriTD9UGicECDdza9ZGkUI4Ft3Cz5s8S2qQuhVIGH92wrKippn2g1MnHmT6eZvvaW4C4uo/SSZSKHjbj63gj6qESpcdwUAq/cbxKOwMCWj5WFEikbL71W8NPmgd8x4IznUL0mNZEpVAFDzy3AAjNPwp8qHOxoOLyBBqVi1yhK0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468220; c=relaxed/simple;
	bh=xtVb5a+wMEXehA6PzbIGnU0ubmL2h9NPGFuG9Piw22E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BDOsUwNHPZQJTfHSjZleNkFOoOFGRG34M3dsoCQMw51NaRAq5sWozuSSopHGg1dZq/5EKiJ/HhaL2En6Qnu0slj8SKHiAIXicCnZN3K5+2i0GBPWIlYNfugNmY9btpTnC+JKsMIUi5VZr1SWhffzBmMeaiLd4uaL7DRL5Qj5lhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tzhkc7pg; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H01hDaMPwN2QpmOyjz4BZsvgL3SGpspjuHsoLYh7kHMtsgMGNGCLzpt2iXgn2TIMKOeRb9euu/DZY4+rS3PtkSIqO8G8T65UL3+hiACBWGfbxTAkcyUE8nPOT6LRpKk4+L7dlbnfL4g8HjX3nR6N3qlKi/H2icVfQM3WgOA68PEZocxvn6y7Z7beum2ydCYLprQ8mcREC4IH5ORRZRe2cw0mU/IAfDsKGiyuR/z87mFIU9wJ+Nb+lWPRGriDbFBgZN+conL8JSrfESSXDz5uOFg7hKEz8wCPI6rP+gO1GRerQDqOFtoyRzEH9otKk3OC40p8aMKvOf4aVQMNdUYi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cErzseWw91HliXX+RxPdQ7nG7Bf/mjigIvABIHXNYjs=;
 b=U8py1UP04t+D3kHbHYl4GbfcLCuD5wtXx8kLJdhaiQ/7s3UuvHpshl0F4r3axgtKEimiadUMOgb+F3boTblnteMUhpXoVbVBxT+QBxKbwed+3xf5u4buiTjwH3kYHxcy7M4fw2MZbS4N/Gfg3RaPqgtDlFUI2GLBSOdEy9cn9o8mxsUgETB0izjNHUd8Q8ENX4vpOHEuuxkzsAQ0YfYwdr+oIXfWu0FPotcMf2nsGzDIlplUk9CW13uKZhYpMROtYWfgtt8moG+eZbQHYDKoCbave+x9IT232XEIctPxOzaV4FPIf80Ajq6FouE/bQArUGx8Ff+0wbq57hGju25KmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cErzseWw91HliXX+RxPdQ7nG7Bf/mjigIvABIHXNYjs=;
 b=tzhkc7pgCOFqnNwOaxc0Hw09axCM+W24LJTNZUI+j1L09sSkKPf3Xs9ROPMjqPysb3dGaDiHLP+M6GcjQs7QETJFvUj9DR2MkI2BQsfOEHNo72UppWpmVbZZCpMjryaJgsaUgLqIfAFwQN83Akt3Rhrk1prpIap9qcWKOfn7qYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 22:30:15 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 22:30:15 +0000
Message-ID: <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>
Date: Tue, 20 Feb 2024 16:30:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "bhe@redhat.com" <bhe@redhat.com>
References: <cover.1706698706.git.kai.huang@intel.com>
 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
 <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
 <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:806:126::29) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: b48a1dd4-6766-4603-4053-08dc32638285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oGzClbrYCgCkor0FvGhuupMGOoxQvmdZVgttHlIRGIYm5Hx37pLGgGetWJtDe+V9P+4EPabME69kTQcM5V+ZtD1j634qvnTiYnhV/5EFwfpLNp+WPbEx2RFmSf1aGZ05dfXwad2skglg0HyMfO0qg+V+k4KZbK/AFbGaZ1BqbzEl5BIFz1NfOHMRszRKkFz4KTRuRzl6sgq7Q84hUz8ccdLS+ILHXc1Rz/dfUYSd8UHRsjKjBTs/W2pDWmLOapWcQOu1OkCT1OriITPi7EjDzY0pZiE1PRg05aJIkl7jss4BgMfm1ln99WQgRWVmWfrvWqkCGNFPCs9i/t1Ihf3VOPcv/6nvc/qJJVF/PR3cLe+vnMUJqLs0ZKnQTlErysKtJnnEQRr1+PjrA7mc9yPNFHMOYcB7taD9U85/LACZLix7xNQfbd9RLl/TCW8mg0p2OqyEKGNmEpmgKQwjIWJugZ+wN5rpDefWleYZoRte9E8S/N0E/2hpMEUTgHY8VHPOEadf2lx9sznZKlUvhe44T3aLChCQQ18UnQixoLG+9iM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1VWdVhLQkNrMzd5ZFNWTGx4TVZaL3hxV09KM3MybHZzb0ppd3dsWEhPcUo2?=
 =?utf-8?B?aFNXTEozR0xKVUtyQUxWTUxGQjJRbzY0a3NQWUxoZU5vOXAzRTR6T1Z3N1hR?=
 =?utf-8?B?OGl2SG8rdEl2VUFnYXVtY2ROeWJyK3UzK0ErRVk3dUhsNEc4MzBRVkxQODVu?=
 =?utf-8?B?Z1k2NDhIeERsVEp6aHlEaFFPbzdVQURFL0hqRDNaQmVJaXRCbUtwS0JKay92?=
 =?utf-8?B?VEszU1UxZUJnOE9mb3dPSXlTUFl6U3NRWFJFMnZwbWd3OVFUamxIOGFEK0RS?=
 =?utf-8?B?eGd6b29CcWlKVTRtTWZ3Nyswb1czeUswa09SY2VJYTN4c2QyWHNpanpBMk81?=
 =?utf-8?B?dEtGSktLdkErSnl2bThqclQzRUNNMitMYmxSa3JXVVRPWCs5QjJDeExINXZU?=
 =?utf-8?B?N1RWZW0zTE9VMUw0SDlVUzAyMTBQWHFHRnJnYjh6RTNKRXVoZGQ3TVlmOUFX?=
 =?utf-8?B?bjAxSXF6d294WXBua09pVnBncEdYZE5lWGhIeDBNZ0JYYzB4OXUzKy8wanFr?=
 =?utf-8?B?dktodGxhSXNmcDkrWG9VUE5wamFka1YvZzFDOUVOb0NDWVhWM1V4RUJ6QmV1?=
 =?utf-8?B?b2dIR005NStoazh1TUc2NzJ6eEJzRlhWZmd4cDJuOWp0ZHk1TXgrWlJOSTF6?=
 =?utf-8?B?dlMrN2w3WmlmTjV5ME1NckJpMEFSV3BGcVlGNDgxeGdLU3FLNmNyQ2dFVzNv?=
 =?utf-8?B?Zk1HWVc1Unl0cVVtaUtYTGY2TnFoVEJDUGtpUGRsb3F1VWxyVFRSSkpEblE3?=
 =?utf-8?B?ZEpqUUZaT3FUT05JSVRGNzg1KzNUN3Vvd1Eyd0JVNDRKVWx3WkpkZFlqVElZ?=
 =?utf-8?B?WEJQV2l6VTN1enZlVG5pSFgvMUk5aEdkbkthQmNETUFBemtmRVpNS1JFSVJ0?=
 =?utf-8?B?WmIyeUVFaTVZYUNlaVdiYjdBSUl0K1NQMmdiVVE3WnQ4Tm5CcTFuS0YwZU5M?=
 =?utf-8?B?VUxnZU1BUlA0N01MdGp2a3phdzhiQURBVHJoaEY4SGU3Q0R5UEdWZTEzRFdG?=
 =?utf-8?B?YlNyL2hZWWlqSVcxdWw0ZlRaaGl3QmNyNTdjNGRnLzhVOU9vOUpSZkZ2clhV?=
 =?utf-8?B?ckwya3d5MnduWXZJWTU0bjlJbGh1b004QmVMUkl3WFpUdzdyL0puVDYxc0R2?=
 =?utf-8?B?NEhaeDRVY3NlQkFPYVRjRVgvT1UxVjNoVHVtQXUxbWZzSEJGYjJXTFZYaytq?=
 =?utf-8?B?UDFGcVViSmZzNThWeVF6VW85RVF4K2t4YnE3Znl5bDdxaXJZYUY0UVpVYjBq?=
 =?utf-8?B?SHhzbHpiWnAxem9TWDlGS3NGR3hlTGJIQlBHMW5hL3ViWmkzZ1d6Skh5OTRD?=
 =?utf-8?B?VU5kWTloYTUzVmNVK2NnZGJTZk8rS2VxamlYeElyZW8xQkQvajlkVWw2akxi?=
 =?utf-8?B?OHpVOW1LcWF0dVJMRFR1elpScHl1aWsvZHQyUDF6eldxWmNiWmwveWJKRjli?=
 =?utf-8?B?dUZCdHEyeEpqdnlqYmFRbmttNmhwMHFUdXZoZFhXb0RsWU1NZUozZ1F2NUp1?=
 =?utf-8?B?RDltVGxQMjVSOXVmT1Nqd29qNlNIQjNoZkVpazY1UWUrOSswL2VaRzdKVTR2?=
 =?utf-8?B?bUR1U2p0UlJIWkRrUldPQVNjQlk3OG5FWnhyOEtjSlF6eGRjMnlRdGhYM21Y?=
 =?utf-8?B?SVNVakR4VklGbEJkZXJPTENJRmNFWUhTeEFEOVFJMWZzWWd2cTdOQVZUSDIy?=
 =?utf-8?B?cTRFL3R5bUpHR3U0TUhTQ25ETUhNREMzazd1Y1RYUFd2ZkRzNVpwZmZLRHh5?=
 =?utf-8?B?cTBiMHRUb0habTdHVlpNc3VCeFVCNjErK1pGUThlYVRPNnphaWJnY3N1QUpt?=
 =?utf-8?B?UGZhZ2NhZ3lGR3JZcW5lWlQyOVJVc3NMaUNhdXdHbFk2Qkt1ak95cVk1VTNn?=
 =?utf-8?B?TTd2aksxVmJoRU1xV2VUSlRSTnlDajhFSHBORkFVME9YdEpGSkM0U2tlVnY3?=
 =?utf-8?B?Yk1GeGlXUlU4WkY1VW9ZeFZ5SnBuVFBETHlNMUxJTnBzQkw5S3d0WkxDWnA2?=
 =?utf-8?B?Z044dDVXY2swKytaUHZ6MTlRODZhcU1ENS9lTFE5RHhwSDFkVkszZGcxYW1R?=
 =?utf-8?B?Rk15c0lYRGZSRzZOc3I4Z05nMWM0WmxvRXZldWdPaFo2SXFvc21nT3FwZWpU?=
 =?utf-8?Q?sbcZju+hiTlo3TriwWhlotBvu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48a1dd4-6766-4603-4053-08dc32638285
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:30:15.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP+zPcKpXzX4t63CBzkXUBxLg6MvptfLkiS/Yw4IVTpOFq/8Ka9s+wdnTFrxO2WJQ4/bnf5FbeqBs9IQZI+6uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278

On 2/20/24 14:07, Huang, Kai wrote:
> On Tue, 2024-02-20 at 08:47 -0600, Tom Lendacky wrote:
>> On 2/20/24 08:28, Borislav Petkov wrote:
>>> On Mon, Feb 19, 2024 at 04:09:47PM -0600, Tom Lendacky wrote:
>>>> That's why the '!(sev_status & MSR_AMD64_SEV_ENABLED)' works here.
>>>
>>> I would've never figured that out just from staring at the test. :-\
>>>
>>>> Basically, if you are bare-metal, it will return true. And it will only
>>>> return true for machines that support SME and have the
>>>> MSR_AMD64_SYSCFG_MEM_ENCRYPT bit set in SYS_CFG MSR because of where the
>>>> 'cc_vendor = CC_VENDOR_AMD' assignment is. However, if you move the
>>>> 'cc_vendor = CC_VENDOR_AMD' to before the if statement, then you will have
>>>> the WBINVD called for any machine that supports SME, even if SME is not
>>>> possible because the proper bit in the SYS_CFG MSR hasn't been set.
>>>>
>>>> I know what I'm trying to say, let me know if it is making sense...
>>>
>>> Yah, thanks for taking the time to explain.
>>>
>>> Here's an even more radical idea:
>>>
>>> Why not do WBINVD *unconditionally* on the CPU down path?
>>>
>>> - it is the opposite of a fast path, i.e., no one cares
>>>
>>> - it'll take care of every possible configuration without ugly logic
>>>
>>> - it wouldn't hurt to have the caches nice and coherent before going
>>>     down
>>>
>>> Hmmm.
>>
>> That's what I initially did, but errors were reported, see commit:
>>     f23d74f6c66c ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")
> 
> This changelog only mentions "Some issues".  Do you know exactly what kind
> issues did you see?  Are these issues only appeared on SME enabled system or
> other non-SME-capable systems too?

I believe the issues were that different Intel systems would hang or reset 
and it was bisected to that commit that added the WBINVD. It was a while 
ago, but I remember that they were similar to what the 1f5e7eb7868e commit 
ended up fixing, which was debugged because sometimes the WBINVD was still 
occasionally issued resulting in the following patch

   9b040453d444 ("x86/smp: Dont access non-existing CPUID leaf")

It just means that if we go to an unconditional WBINVD, then we need to be 
careful.

Thanks,
Tom

> 
> Because ...
> 
>>
>> But that may be because of the issue solved by commit:
>>     1f5e7eb7868e ("x86/smp: Make stop_other_cpus() more robust")
> 
> ... the issue resolved in this commit seems to be hang.
> 

