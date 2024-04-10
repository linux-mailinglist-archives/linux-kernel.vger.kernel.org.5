Return-Path: <linux-kernel+bounces-138962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57FF89FCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED43C1C21920
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71C179965;
	Wed, 10 Apr 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5rn5BEmp"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2100.outbound.protection.outlook.com [40.107.102.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE04179661
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765674; cv=fail; b=DPTwRWvrltlR53FlCwXM+bJ5TAmV7t4O2lSSvOmvK0pdhhexHaKea7IjFdMthIlglkwGNOQ0Um824NKwMiYkvwgKbXULtnNWWF2N9gr7xiPJoNJnJZDE00hVIw1n16Sj8Y+qCkwTYlw1XT2IGq0rnFT/iZ5l4K3id4iPlvci+lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765674; c=relaxed/simple;
	bh=rKzoIThhl4SxDIr5xxWa4Yp8DQflisgoYOCqWJPESHo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mI6QlbPU4uL7eQpiSSf4KeNK0oYjLJCqvIuqyIdEfCC3wOKMRnF+osqUdVZUK9cSJlpkU620u12IMGidnuhhYzrw+hSGctdQZyf/70xB2BoUFf4LLtbhDQWKMnKyloLpofaIDlbqcvQqQNFS+zaXDFpCweDAJEjNbyEd02QlBxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5rn5BEmp; arc=fail smtp.client-ip=40.107.102.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CREtdq6u4Eum7MlQKAdD94qgtOcL55iPfMlfRdfTGbWOLabBNMbXZMUel2lCRzhhJ8M8UVcnoIFgCZI08OWQgHMTfjx9Zhe9FnN1KcdtFYW8xF1cwPgqVLaTbc/+e9HNOZjc8eAfJHB6ESQ2vmVgD1SP/laMLbt8Hn8z7CFO4DNdfx/URKzCv+6u/SNCB6UfeAffDhRREqozi0+axjg6BPhXK0UFMqaZ2JD6mmIHBlJvKSzUFOxC7Q4tc8TIoRQUKtVe+4Utcic7B981yy3ezVoPB9+DWVMe+FB1KxKleBuQWqCQStAydI9cF3A4fafal4GaKCUqVp0Q9teZRRhASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOP/TNK4rs5/lCCTXJ3YyV9JDeDDTehfTVuexstvN6I=;
 b=a3+LL2zfDWwxwyx4AxW+ChyBH2DLoX6L8df0w56TrrrGgw2BYxFL0DZBbQOpVDdnR5iHKv0h5szHUdk7cOAF8IpwtGY7oYXI1gsOyqaqREZMLzdbhXIeansPZJ2EijAxFNAdGEL24IDz2m6G2+LJ1bxx6bRRHzZ07JPdFbw5xuroFQysnKsHgUI5l+RXWrG61hEGhGzcMwUl3/dwtFgSM+1PsmAs9v7mCNGPxBCgJqx5OCILUck0ZW0Y3IPCP5xe/aGchTkVOON19Tj+dkPycTHNkUIttjAyMqJOGlt9GsRbUQt+4uWD8X/P0XtD1HOs7aIpmH5QD5JhujqV7hzZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOP/TNK4rs5/lCCTXJ3YyV9JDeDDTehfTVuexstvN6I=;
 b=5rn5BEmpQc7xhRC7Y/5P0U7zu3cg2khk4bzbFKrk7blsJPRIOztfMSQ4boToYEEOyl5ETznCp48ZmZUNTAB2wR+ViPlSgvnSTPYJyBi4R4m/D1wRRXxEpwP7P3NreobgGmaem5OlMlqXhnY6bgGfy22lEd0/2fmUNlMCtIQvsr0=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 16:14:28 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 16:14:28 +0000
Message-ID: <cbf171e1-a518-429b-fd07-3526a0b252bf@amd.com>
Date: Wed, 10 Apr 2024 11:14:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, bp@alien8.de,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
 <e94d208e-964f-cfc0-60a4-fe70db52bec1@amd.com>
In-Reply-To: <e94d208e-964f-cfc0-60a4-fe70db52bec1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CYYPR12MB8962:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xlW2DbWonGWvfzOw1+lpX339dw/IqAM76TU3Q/cv68X/M+f7atF8xxLdESPkgq4T64hPEAxGt0HbExRd+2Wp751w6nnHePHOyo71N0EO3+ZUNWqoXbi6nTw6lBOtM3RISe/eG/A2u5IsV7HFIjqFKRNqd++FGYCqOpngkWCikLPBtP9aN4RGnlu5Oj40oegAOnypm4krxTwykaMsLsBqgTzgbSyKIV8KgJHdIiAWmzETklsBgwoFEZdlajJJp30Vgc6wYPcvwzYlNXkFAA1GWzVIQ5Cv/X+XjoRkuVpGIuiCjmjY6WuERggEyYukyozoSj2AomT5m4UxwfTBl2L4dTtTOPL8O7bZ4f4mBhHVuxc4QKgVSDNc/SJSrj0izeyrZyGSN2VHb5dpI6w/hdALkEA0C1I+IilyEHm28Ze0JyzxE9jhtrZHbqn8dQ9m/1ITA1cAFaGfaOvJOhxGtWH7xvk3Kh2a6Zbq169xCEG4+/HpscWQAwXt2S/jDPWJZA3AUWjtxe/LeReOJLgAR48/kK/sArMivJPkX8o3ssHD6S/Q7WwQPGu6+B3o4EE+63J8NjyyeoTjTqw0f4jowB1EHw9Cygpbw0fcDzHx9Gt8ZNhj08RqyviniZ+taiHSxnJJzugsxqzIgylabjUqrc+uyU3DlTwGhH26ZKFzPXNPQ84=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0JVeitZMEwyUzdXa3FpMWI3ZHZjMDhvOWwrTXNsc2hBcTR2aWlQUjF3U0R3?=
 =?utf-8?B?bE1CWENobHRmMEZQWk1abkNDV1BIUWFqT3VqN0RYYXU2a3BScmkrcFladHgz?=
 =?utf-8?B?RzMxL1RZOStVN2pZb2JLaDNIOXZlREtLdlRzTk9zc1pDV0dMc3NHbEwyUDdq?=
 =?utf-8?B?VUNGT1VCQ2M2YkFBdDhNWmtVdTBmeWluTjJTYnFVSkdsSng5YXZ2VmdWTEIr?=
 =?utf-8?B?S0VVSWpPTmtzU01YNi8waXNGUDBDY2dWQjdHb0IwNWxFZlg1SlFqMTdMeVBt?=
 =?utf-8?B?U1JPUlZ4N3cyVlJvL0lyZXlVblJkTjJjMFZkSm1NaUtRY29sVVEwelFWaXNz?=
 =?utf-8?B?RlpKa0YrbjEwV2NzNVR0WnZsbzRXenhOTFlIblljYVRnTjIyRzZTcDdrTm15?=
 =?utf-8?B?U1NScG1QeG8wclNDODE2S1ZjYWhUZmZzYUtNdkJ6OWl5TE9HbEhSd2tlRDU4?=
 =?utf-8?B?UWkrY1JjQy94NWlZVFhBeUw5b2xhbHNNcDR5SE42aVZlNVNHT1Z6dm9Zb2hJ?=
 =?utf-8?B?SzlOVlJHWGhxeFMvSkpKUnZpRG4wcUtvUWp6dXN5M1pOQmkrSjY3TDg5ODU0?=
 =?utf-8?B?ZTJUT3ZEaG41TXhmZWJSOCtFZjF0eHovWDdrVGd3cEh3b0JoN3c0UUw2TU9l?=
 =?utf-8?B?dkI5K00vYTdoL1FHZXVsaENCM1krc0tWVE9SampWWmx3TjBZcDlYVGcrWFY1?=
 =?utf-8?B?Ykc5OEhUYlY4ZTJhcXF0Wi9OZ0NnZDFnSEgyR0tWbnZFbFdTeFRldXRmTUU3?=
 =?utf-8?B?MXZ1TXc0SmcxUElSY01zQkIrQVNnTmZGenVUbTZaeSt0L21YSGFnaVBEYnZs?=
 =?utf-8?B?NHFIaFdSdFR4SXl5dUszQnhRbWdLYWNhK1pPV0w5T3E2K1Nwc1kzSjdzMWdO?=
 =?utf-8?B?YzVlY1gwU3JRM0JTNjloSGNHai9WQ216ZHp5dlNsc0NlOGNrbVZQbjZzTE1y?=
 =?utf-8?B?VkFHZnZLeUtLN0VBRndCZ2wvTnY4bXRGRjZ2N2pSSDZuMmlaT0dybFUwRUJT?=
 =?utf-8?B?NXhFaGRqMW9uZktranQ4dktCeUl5OWhzaXVEMUI2QmtQUlo4aExrNThXQVpO?=
 =?utf-8?B?WmZ0K3UyV3FVeUgzZmJLQmt3T0IzekhPck9ObDBDd0MxcGx3QkZnKzYzVkNp?=
 =?utf-8?B?OVVTWjg5Yk5RYjVmbEdQSVJyOHdCUXVhQXVUL0V0bVVIR2FZVmRoNGhFOVkz?=
 =?utf-8?B?Yjhiek9XYndnc0NXNVFWWHFRYnRkMWkzd01JdTF1U05TZERqUkd1RlRPTzRV?=
 =?utf-8?B?RUltRUpDS0MrWTR5NVRPS0dBOTlEaEJ0czBkMWVVZ3lTS0tPZTBTK1FnNTRI?=
 =?utf-8?B?d2JBaVJyQXdRWjFaTXZBOHJxYXRuZm5TTmY2YjBFakhTbnJUY3JEYi9GbVJk?=
 =?utf-8?B?VjM0eUd5REd2cXpmYktoMDZIQVgvUWNBVllhYWM0OXdScy9wYk1Vd2xISzgv?=
 =?utf-8?B?bU4vUWcxRlExWXV4MWdXTVgvNEJRaS96TWF3SU5NTjlDc2d1aVhUZlRkeGN2?=
 =?utf-8?B?Nzk5ZVpNeHRFdXFvNXJSY2tMemo5NU41N3NKVi80aVNMWHdvN3ZGN3pwbEk3?=
 =?utf-8?B?OE9pUGc0N1JjMGpyQmhQaUZrZzN3NTFjcGlYR05hMWd1WHE0aHc4RHNGSTN3?=
 =?utf-8?B?SHRvNXRZc3p5ajltc0ptMWY5TllSbE9tSkZXaU56ZHU0UysxUVpwU2pyNFZI?=
 =?utf-8?B?MlNqbFZFdE1tMndIQ29YM2c3c2ZPTCsxam56WVk5Qms3ZkZpV2FiVTRsT2Z5?=
 =?utf-8?B?eENjbG9Yc2g0ek1PdXpPTzliZWlhWVEwL0kxYjFPMHozcnVDc2lnREpvcGlF?=
 =?utf-8?B?N0QvMmF5UHNNSGdUWHVCVXZlQzl2eDMxNzBGb3Y1SXpzYTNOY053VzBpVWlz?=
 =?utf-8?B?c2R2S3NEcGFweXc0dTQ4czZmU2Rsc2hnd1FoZllicC9kdGs3cDVtTXN0eHI5?=
 =?utf-8?B?SElGRkROL2xuTWhpdFpxcUExSng1SnM1NkVqbzA2TUJpdG1kODBESTJQK3gy?=
 =?utf-8?B?YjV4UEhLdUtwdnNBZ0RqQ1kySlNqYWVabWFucjBvMUdEZFFFVGRZSXQyckhB?=
 =?utf-8?B?aWVRWnM0dG9Vd0RMUDY4VXRkLzhBTVhOU09vZzQ0aUpsL1g4UlpWcURyd0hB?=
 =?utf-8?Q?FrWOtprclCzelA0mbqYgsrBQK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a16941-db96-4e24-9d0e-08dc59794c1e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 16:14:28.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgNMqPn0YtW258njGm+z/f/itHdvQTb8wns6/9vi3cpuGbJEoNrP3KaZ03jcwXIbZXV1TE0PvpbgOoWQOhyORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

On 4/10/24 11:08, Tom Lendacky wrote:
> On 4/7/24 07:44, Kai Huang wrote:
> 
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index b8441147eb5e..5ba8a9c1e47a 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -813,18 +813,16 @@ void __noreturn stop_this_cpu(void *dummy)
>>       mcheck_cpu_clear(c);
>>       /*
>> -     * Use wbinvd on processors that support SME. This provides support
>> -     * for performing a successful kexec when going from SME inactive
>> -     * to SME active (or vice-versa). The cache must be cleared so that
>> -     * if there are entries with the same physical address, both with 
>> and
>> -     * without the encryption bit, they don't race each other when 
>> flushed
>> -     * and potentially end up with the wrong entry being committed to
>> -     * memory.
>> +     * The kernel could leave caches in incoherent state on SME/TDX
>> +     * capable platforms.  Flush cache to avoid silent memory
>> +     * corruption for these platforms.
>>        *
>> -     * Test the CPUID bit directly because the machine might've cleared
>> -     * X86_FEATURE_SME due to cmdline options.
>> +     * stop_this_cpu() is not a fast path, just do unconditional
>> +     * WBINVD for simplicity.  But only do WBINVD for bare-metal
>> +     * as TDX guests and SEV-ES/SEV-SNP guests will get unexpected
>> +     * (and unnecessary) #VE and may unable to handle.
> 
> In addition to Kirill's comment on #VE...
> 
> This last part of the comment reads a bit odd since you say 
> unconditional and then say only do WBINVD for bare-metal. Maybe 
> something like this makes it a bit clearer?:
> 
> For TDX and SEV-ES/SEV-SNP guests, a WBINVD may cause an exception (#VE 
> or #VC). However, all exception handling has been torn down at this 
> point, so this would cause the guest to crash. Since memory within these 
> types of guests is coherent only issue the WBINVD on bare-metal.

Hmmm... actually it was the other WBINVD in patch #2 that caused the 
crash, so what I wrote above isn't accurate. You might want to re-word 
as appropriate.

Thanks,
Tom

> 
> And you can expand the comment block out to at least 80 characters to 
> make it more compact.
> 
> Thanks,
> Tom
> 
>>        */
>> -    if (c->extended_cpuid_level >= 0x8000001f && 
>> (cpuid_eax(0x8000001f) & BIT(0)))
>> +    if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>           native_wbinvd();
>>       /*

