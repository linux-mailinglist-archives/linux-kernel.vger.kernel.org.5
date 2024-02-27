Return-Path: <linux-kernel+bounces-83479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A32869A03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395EE1F2254C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182A1419B4;
	Tue, 27 Feb 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u2Y32GDh"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047147A72E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046669; cv=fail; b=ksU+nTFrQvdkWUMd8cdExllVfBLaPL6WU54HnIJtaUGUQOYwMsMekYD5q0hs9L2joDiAJ7t0OHQVKrmW6BZG+Fg/dDq3HN5CddqbS3OlDTVLxB/mhp+sux7X0DaoY/QP7zGdf6oqtFEHSaRI1FNbMgeYPWHNgqL59fhJzhDzf30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046669; c=relaxed/simple;
	bh=46QIDEanLhGiws55Te5pjnsoSE8gOUMDw0Hk9pQxv8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KzL3269+qarAzQCFXhaifoCzbkTx/VaglKLhzx+H/N63CElqEmai23phgNq7/fRpqg8EMsZeHNProF7Ft9Zr4f5rNEUBs+HIHzl95Yv2BerEKsOfQ0sLmXPw3fYvaOhctRuFgsAIQcwCUs5PSvSGZEONxj/YeNcYngVkMoy2mDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u2Y32GDh; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeGbkTOp93s3V5I3VSSbkYtZSfulwpWQRl5WFDJKG6e+qudmC/nllBgWv6L0dNmS/Y9YnnQrAqJUFEO46dNf7z0EuiCFmutpsiDychkBHueOg1sfAqeUW077n0w1j+J6k3R8w/recJ9o8rd/6nFOBqhcKMLjRmXEFbYgV4A3qsczBi1Sn/9XvCb6LltymO1aHgv7J94yIXuVV4C/T25HAhkYkNQWfRxh7XHEeoXJrYTQKK1vaHoMoL2P+MU2BkGL78X2DhlKC/8xIAh9g/wjTLpNVrM15pt8ousr9rxSozjz3Pcl7g7/9LaQ1u9kx97QphujBi9YNBIHsf0iaAGXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HSuyz4aercSn1j5rH5xBz0gqwNiyyH0MPsQUhXa7G0=;
 b=flIkqTFOyZcxXGC7COuMGCd5XxdoEXohFb+IgImmxqXwZKC7PogD4o52eo0zrA8uypr5KCK1/yLxPx/WWSFyxaGsrT8JET2VC6SC/H4cq9+/2N9q7ZRofLzlziSoJ6RKNpqKqCNG7JkZNA83kqPzv/mIP+/Xn6BnOgaYpkWfGrRRqEs5mLQv47NR9W/HZRAXriLISCVTetfVTDVhkTc10NXm8epIWzmCDYUbreWuKeI1bx76G6hISuzMwl/iWiBNC1uTD52zXiGHWx/Ct+sivPwBcej7ujhIp/L0tjwEgPojqEqepPdzgUoBtDo5MU6BdWxS7kmvWveJJdO1Kau1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HSuyz4aercSn1j5rH5xBz0gqwNiyyH0MPsQUhXa7G0=;
 b=u2Y32GDhudLFNP779JqCCVuoH8YS4UIfFX/XP5xaqX3OpqYrgwy+DJJONc6zmUgvBb50EGKFmEvCB6lWNxtfgy7qK8D5kQ+dLjNMC280gdsY4JdovfaYuAhHZ12yXlBy4QWg25FfZ//f1dXuoIDVG5AXxZyqE5rbPmSXh4GFp14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 15:11:03 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 15:11:02 +0000
Message-ID: <bc0e54cb-317f-4d02-8591-5b04aba9d0dd@amd.com>
Date: Tue, 27 Feb 2024 09:11:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/10] x86/sme: Avoid SME/SVE related checks on
 non-SME/SVE platforms
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 Kevin Loughlin <kevinloughlin@google.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
References: <20240226142952.64769-12-ardb+git@google.com>
 <20240226142952.64769-17-ardb+git@google.com>
 <229aaa22-5e69-4f18-b5f7-fec83109bb53@amd.com>
 <CAMj1kXGRTO=HupSKtGhpCpMt4nNpQLzuAUzRj8Qvdfnc2E=W5g@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <CAMj1kXGRTO=HupSKtGhpCpMt4nNpQLzuAUzRj8Qvdfnc2E=W5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::6) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7920f7-f8c4-49d0-b068-08dc37a64fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yDCJ+FLYAPdKdVkGuAeTfpRy2zr2JDFiTlmfg8x5Tm7TZu4TYLe+RsvcQ5RxqGToLhWCEVNAYd1hVm2RJX/97Da86USsoHyE65K/NrOy+BKhc0l0DCQitjW8wLQWdDxNIfAt/fYM3sk0lPWBkEuGVEd9+ro87oBYt0TlMLmjlCWG4e8yTEAVconODUeBLHcXrc75MdjLvok3vTuk1sI2D6MVE513XvIJa2HrR6elaNtdM0bQxn3Mn5kci5kBJTtP6VZQmzqw+/W2y6Q9dW46UCJG74lsUY5EwJBwHdUW56bE9JGGZYc9a/mC7IeJR9KYza2fOHaOCyl/ry9QzZ8XutP7knSlOrxhCeWsUXFge6gkIUprjbIwFPMvsYvBUqzCohbTdowp3wfBD1xDOeXMZVDut7EOykbm1VKBx+VDoknsIp1Y8ozLVoXnui56mnBQzaCJ5ZufKKwa9pCcPFCqKWVTmx8Qi/CnhqxbH4VHU50phppy8JJZsYBGG26d4X28lU5U1oTuhRtq6CScB4ksw3wp/EQhyByAWUtROlpbmqhWpd77WurGE+i/yXyBffq7sVQB6KoFCUM7ZV5sY6D7jjmrg3rAxWx1bykVbXwLcc0oRaQeomzzHNw1tUFJfXPJJYdQxPYrsyi3846ATfLcLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU5KdEJpQWV4c2pLWDNycS9jVTJiRVRWcmhkaWkzMHJPa0pNQkozQlRLVU1F?=
 =?utf-8?B?Mkd4UVkxSGR5RFZlSUlvQlU4TXJCVy9oVlVCSVc1TE1pSFI1Ulo3Vk95cDRI?=
 =?utf-8?B?VVFCVUpSQ1B0bUxQOWhuK25ONThRNlIzNlRiQkttK3JsVWJuUEZtVGlIUlhh?=
 =?utf-8?B?M3JuaVZUcGszbkhsdkxEY0d2VDQzd0FxVUxEU2RFTlRzdFRpb0ErMEtEV0NX?=
 =?utf-8?B?QkZtbHZzV1ZIM0tEOHM3b1NEQ0ZoVE9XV3JXY0FNZ2dPQ0tvS0tqa2RyMXhz?=
 =?utf-8?B?anJKZUdWQXIxWFBVYWRKVHpQVnRvRmpRSVQxZ0ZqeEI2T3dWUXNuMzJlcElk?=
 =?utf-8?B?RzNldFlVTzEwUWpyY0xiUWg1a0xpczNpYXpUUHZJZHY3ZUtNbFVsTmVSWmVE?=
 =?utf-8?B?K0Q2THRtcTcwWEVJQW9BbTU0bmIxQUJZUStvdGJJalNXUDJiRXJ0VzZCUG1D?=
 =?utf-8?B?MFlCQjVqNEZOQjBnNDBTUGVyTllZMk8rVU9oWEcvYmdKOTg0SFhTaUFMM0tU?=
 =?utf-8?B?UnNCbFJHM3hHTnhEcGpmWjJFVGVVb1R3SHVhVHcwRFovRjJtM205WEpJcG9K?=
 =?utf-8?B?VmFCb1ZoMUdzRG1zZkxsTjVkSDNzbGltYTI2T3FaZVRNT1gvVDRkY05LSkxX?=
 =?utf-8?B?VVhMRklDbmVGcStER1dEclhXUjVUVlkrWkJrSjZFMWVQRmxwSFR1dFpZb1dl?=
 =?utf-8?B?SmZwbTlxak9NUjIvM0lQU2xWWktINUNCTkNFZjlkQzZhejhjeXJvN01SbE8x?=
 =?utf-8?B?anc2VkRkUklDREFGMW5ETnAwNkpaOG5NbVRYKzRpSGxWNU9tc2ZvSFRLa1kx?=
 =?utf-8?B?UFkva21jRXVYc1VjYkRISnhpVmpKMmpiYXMyMEtkcU13aHkzWXgzTUpBRWwz?=
 =?utf-8?B?Mm0yNm1QQ1ZxckFvUnFnazRDUityNWpYWWUrTGt1K3BsblVmcks2M3VDOWFH?=
 =?utf-8?B?RE5yNnAvekEwbEJnUGJZVXBIUVZYdUVqUVh6dmdwa1F5SDdXYTdTbFBQUWI2?=
 =?utf-8?B?a2wvV3o3SElMUWQ4YzBRYWxQN0tTa1plVHJRUk1VbnpBaHozOWQvaUFyK3JK?=
 =?utf-8?B?VTkzL2tJZVRuN3N4MTlzYXVWdlY5TFVTV0xhUnFiWlVHWTVLOHdvRmMyT0Ra?=
 =?utf-8?B?TUZEaWgvWGx5SktITk5BMFR3VTlYTzE4QS95MEh3OHJrcExiK3FKOEY0YjY1?=
 =?utf-8?B?UGZSNU13RXN3M0M5S0JIa3N4dCtDVTBBUkh2MGNvQVF1US9xRVF1cStMYjNy?=
 =?utf-8?B?Y2RRSmN5L1EwMmNhQ0QyUm02SUEwWTB2Z3BycXpQOUptS3phaDFwY0dlaksw?=
 =?utf-8?B?N0xqVDV3S0Qrdk9sajFCS2lpeGRySGlrYVAvVUtNQXZndEhTdldqV05jSjIr?=
 =?utf-8?B?STlVbEpqV3NiWm1ZUUJtK1k0UTJtSk1rRnhZalJoanY1VFZmYVpQWHlzSW9m?=
 =?utf-8?B?Tk0wYW9LWlpVTzJ3Y0F3cktBQmpzR0dZc09oc3RYS0Y1d1pQaTR3OHdWaWJi?=
 =?utf-8?B?aktSbUR3ZXFIbUx3bFgxdkNJVHo0SUF1MktFcTBCQitnSGpURi9xM0RJOHJO?=
 =?utf-8?B?bUw4NXN3MmczT1VjTkRwK1hRc3JmUEJTeFI1NHVPSWMreFlIbytta2dDV3kw?=
 =?utf-8?B?S1M1OVBHMVZ4NXRDMXBDeFBCZ1NuZDMvKzZzdVdNMWtIVFEyWGI1eDF3bHh5?=
 =?utf-8?B?VWRXTUV3QVBDTGs3YWQzaGZmM0Z1d2d4UjNIOG1TbXN4MWd4VGMySUZPU3h0?=
 =?utf-8?B?WnphQUR0YW40Qkc5MWt0a1dEM05jaDhBdGM1WGZ0RFNIdEtMRDg4SXQrNGVH?=
 =?utf-8?B?RFBSK051MnhvaTE4dEFSWXNISWUwNGdENW1HWURoTVZHQzBEVEk1Nm8xWVVK?=
 =?utf-8?B?eWZaak9UbXpjYWdxVVIwUm5hZTV3Skx3SG1pN01Ya3hKejNHNzV0b3oySjYz?=
 =?utf-8?B?SVU0UHpPNWhoZ3MxNzB4N00wbThEN0t6NzlPT05lSWtkc0o2NU1ZT3B0SmhH?=
 =?utf-8?B?RndLMklpb3htaWtCWjRrRUZDaDZHZS96K2xORDl4bzdDZDVtTUpiOEtIYXI5?=
 =?utf-8?B?aXhFVGJ6cVlDdzZoZUFNMjcwWXJISUFFR1lkd3hlM2FDeUhIWTNTZk52b1Y2?=
 =?utf-8?Q?VnOtwEjPPkrzlLlLvWKOOSV3H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7920f7-f8c4-49d0-b068-08dc37a64fe4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 15:11:02.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM23aCYFuokcy+L4U46Jk4deeX9XrkPg6qT7OFH9ax7rvRzANdNrxWqwdrHKVL4q+1TvYPTucSNvv3gqQKrXUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

On 2/27/24 08:55, Ard Biesheuvel wrote:
> On Mon, 26 Feb 2024 at 22:38, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 2/26/24 08:29, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>

>>> -void __init sme_enable(struct boot_params *bp)
>>> +void __head sme_enable(struct boot_params *bp)
>>>    {
>>>        const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
>>>        unsigned int eax, ebx, ecx, edx;
>>>        unsigned long feature_mask;
>>>        unsigned long me_mask;
>>>        char buffer[16];
>>> -     bool snp;
>>>        u64 msr;
>>>
>>> -     snp = snp_init(bp);
>>
>> The snp_init() call is here because the SNP CPUID table needs to be
>> established before the below CPUID instruction is executed. This can't be
>> moved.
>>
> 
> Yeah, good point. I didn't spot this in my SEV-SNP boot testing,
> presumably because the firmware's VC handler is still active in my
> case, but this isn't guaranteed, e.g., when booting via the
> decompressor, or when using 5-level paging.

Actually, the kernel's do_vc_no_ghcb() is the handler that gets invoked. 
Since the CPUID table is not initialized, -EOPNOTSUPP is returned from 
snp_cpuid(), which results in the handler using the MSR protocol to get 
the CPUID information from the hypervisor - which we don't want for SNP in 
this situation.

Thanks,
Tom


> 
> Thanks for the review.

