Return-Path: <linux-kernel+bounces-140609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9D8A16E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21F71F2219F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C942E14E2E0;
	Thu, 11 Apr 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wBAXDSeV"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420514E2FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844829; cv=fail; b=hfndJYz82W+mLfdPYNBVbFZ7UxtZOhYcWOZiT3HpZF5jhlgPD98JIlUNepmj6fVLb6PaWvYascG3niJQL4N7BfDvqyML4vAiEDDIkJ1RUNszfSOSkyk0aZN+WhXMd9O9gkckL7fXKgAay/a9D/+wywDm1UnE7Bq2WMbj6ecLMnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844829; c=relaxed/simple;
	bh=iaggFpIuVrMhZe33j8Fdal+UXxl+9X2Ynu4KtOzL/Fc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NacZejKnu4XJ02FboYS4xXUywA4jUIlXZ5IPMV2WdeUqU+5CkRp9Jbmstgw8F7du0CvC4MP/ChuuUceaOvcfbQhg79NqrgJZlM4yZPxipm1tzu6roEhfOFY2GId3jd7c7KANVqNdAemvTe8AX4QCcd7s1eRbbn12RxMHB1SeZY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wBAXDSeV; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLcukXf3JllCE2XjwssgMg7rsDRZnZFxQ76cjrG8MDIYTqV+8gitcyaCjuynmqP1x2jvePCN9xbEWOZk6AEN/oWr7fa1jEVm65oLj/zM0ZOy01G1u7MV+x5ssUuWA9C6Zo2Fjo6lVO77lzAPXnjZkHPD3clyfiezHWz78jbnkms3g+1mGJk/2+E2qIQdkoyZUF5q8f8P69ycLde8A+FD2WVs/VfUymONsVCpycQ0utizOGfLcYw2WvWbD2SF3FjrlSPN9apJSqQMi5LA3k71qh/OquwUswTdWenlxl3aIeZQgbWIC2qrOpgMQslb9J+YUXsMITC3c4BVF9VPVG95Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaNdORMOMXc8AND20hbEv30CBcBymnZsC0FteTtu74Q=;
 b=AQsoJ9VYxAEf8UNHjGt02Cmm/EC7NK5OnNR4bWhwD8KJaHWT4zHnb5aDp7r9BDS1VNghxziEYhS+JDlSErHf4fASaT+lgPZcBHMgyo/0Lq0+h8HvftaaenpoKKjSVgEp5NLjgmljCwBqDAGnfOwVJcgYy2791lB/NGLN3kRm3YoFmHl9IimcKGHicbYzkz3F/qvxigrKFND6muHuGeUZr4AM9TW2jYQ7N/saS3aE6mDfwSbJYCDUbpaT3ajiMLhBMuMfqQ88dKfio+c4X9udToixzzkcn8eBWVNxquTC9nvok9suFcbD41Gk575XF0eAbtbtR0U3oZOs2Zr2ooguuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaNdORMOMXc8AND20hbEv30CBcBymnZsC0FteTtu74Q=;
 b=wBAXDSeVy4WsH10g5ojW2sXpAe7SnJ7Lq85UOSWrrhJTh9Kc6+/1t4A34D6KVsHYB4nW4kbVgBZW6bV4QAhLggTjaJdSfkDrGKOfAswt3cHNu3XsR0KfNUuAUgptmckqADWPLCMfyzy9tIsk9Agl6uILESrM66uo9rCiClCcohU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 14:13:39 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 14:13:39 +0000
Message-ID: <3ad70c7a-a2d9-c7d9-4921-13000240c086@amd.com>
Date: Thu, 11 Apr 2024 09:13:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, bp@alien8.de,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
 <e94d208e-964f-cfc0-60a4-fe70db52bec1@amd.com>
 <cbf171e1-a518-429b-fd07-3526a0b252bf@amd.com>
 <e24e0de1-d984-474a-8b79-ea0934ac668e@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <e24e0de1-d984-474a-8b79-ea0934ac668e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:806:28::16) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: a794f30c-fad9-4c72-1b47-08dc5a319585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UTFWZS73cgIVu7diXF70gfw/6oD1KQTpGOxjeQumBtYJit0nI2BjJ4kIfd8JRfi3fsrjZpLx3GcN4b7RmPB5fotVScNdcOUoOhJ1KFJo/jSN/jDBT5isOWj5HNZxwArvtcNLRVh4xz+4o05DWsIt+o6ypYOSlT5CX73YpIhrNykFQEA6U/7LkFKPx9gATZnCdrLP7driqhaLXgOawu0gXR6NlzFcGeNArNopacIH58Qz0IxCPSMWwmkL5FJqvFBUqTP5/vUg8VhiZfBXmBdGQEt/WMYkUIpUVEl4s7+Her6fc+QQpQtPy37GyYiK2wNhKahLyW7P/T+SdsNj78lB5r3+dJ05n6b7bXS3wdWgR3j5z3he7wg76ztaEeYcfFQLk6UGL9cdj/6BCREHsISha+tqsj7gwaOxlhi6G3bCvbpbb3RrUEZA4fQK99dLDhoEHr7WT7SlLQFtWSwSOnpWTdCB163GcOEG9Hf2NwQd8A71e8pS5+YOZENH52H05qZHFIDT7B3FGvW4/y5IBqrqDN8DhILwCuhrCwHKg+sYOKXdTRbRqjZqGqZ5J0ktHba0MUGuc/D2T4oJI47UqXjm7fB51I+2/VkselW37tdvBK0OtDg7x7MpUKR+Uk2o3WafMDCsCYrupAnUFmKk0y/J9azjGsDKL/8DLym7bsi7h0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U01NazAxUDhTa21aRkZjMEZ0emVrOXF4aDFkdnNhalFqYklJOWtLckRIT1VU?=
 =?utf-8?B?eGI1MnVWNTlYTnJ6a0IrNTgyNnArRlZIL0hNTkg2cDVvaTFmeWpZWnVObERo?=
 =?utf-8?B?YTVWSHY3NlNlbGQrREVRVXAxbXM3S21MbExMU0E4MU50eHVrc0lNQ3FHaUw0?=
 =?utf-8?B?aEZDaWxTNkRrVytmeVJiSUNuVjcyOER1WDdnOCs4ZGVCUVBWMW4ybURXUERz?=
 =?utf-8?B?cFVYdGxRRWozV0pLSGJqdVNDV24rd3pFN2lUVWhyQW4wQkxFSnMyS2w4dUV1?=
 =?utf-8?B?amFFL0lsd2hGUHZuV0dXNVZRM3cybnRpZUFzWWFPMVZHc0Z1OWNIbEFjMkZI?=
 =?utf-8?B?aUJ4dUFaN0l6V0VYcVlSamRoZlZnVlhtMFc5MkZ2WnpLM1AwN3h0WGdYY0x3?=
 =?utf-8?B?Ullic1o4WEl1R29nMUgxSGpubWQ2bTJvNVVMVVRBM1pIUGZBU1RMUjkzZE5i?=
 =?utf-8?B?bGRrYWpwNXBnalMxcmlmOXV0ZnZyY2JSb3VpM3ZOUzU3Mzdib2x3MnZDR0tN?=
 =?utf-8?B?cHpUM1QyUnZMbGE2RWM4bkVLN0RvZWtDYTRaZWdwWGtudUh1b3pua29NNmxo?=
 =?utf-8?B?ZlhkSXFKS3BxSVNhYTRwbWcvZlNsZUM5SC9XZ3hwOVdrODd5MmNBbEk5aEtl?=
 =?utf-8?B?N2FUQVJOVlNEV1dxUjFta3FHWlFyeXdhLzZVVDlQSjRqdVNRM29ZcUZYOHds?=
 =?utf-8?B?bkZuTEROMDVuMWJyRnRxc2ZSK1FhaVVuS3JXTGdxbVdiV1pFYWMzZlc0NDhn?=
 =?utf-8?B?SVZOUWJmNXNTZkRQVStPQWlmMCttWXkxSTAwM25uSExwdmFIdStlNnBMT3lW?=
 =?utf-8?B?WXN0U2NTSmVFQzJHMitFTWxZVlo3RHFWV1JtdGUxalZXRlFENDdsVU9EN3Bj?=
 =?utf-8?B?NTVhQ1JUMWFudlhaRjQvSUpvU0hRNC8reWwvMWFwcGxaM2xuUzQwVUZTb2xD?=
 =?utf-8?B?SzRHMWlMVThEc1FzWUZpMEoxVGo5bitlL2pBL0c2cTE0ZVNqN3doWHRzL2Z6?=
 =?utf-8?B?cys2MEkwQ2QrcWFjbWFPZHVWOG5LcjdpVnZaK21CRUNheVA2OGNjdXVrMlpF?=
 =?utf-8?B?UmVsdklZUkE3ZmhCbkN2Zk1jamZPQ044L3FXSFFtOEVzb1E5VnRSR1F0NjNU?=
 =?utf-8?B?MVZ6bzZKaG4zemhMc1Q5VjVFMm9TN2tMWVV1ekxIUHJLNllXRTRuRXJsRm9i?=
 =?utf-8?B?VWR0dlpRWjhkbWJpNDBwS1pvQjRiRi9xSjU3S0NlMjVJY3gzeXE1Smh4ak1s?=
 =?utf-8?B?MlF1SWgzMUlRbmw0Zk1XMGxIcVBaTzBJUS9qN1ExNjdUbGlNVU5ob01tN2VP?=
 =?utf-8?B?Ly9WVCtXZkJWcmNDYXVjWUJJR1dNRC9ZZFZJTS9iaXlGUzVJNXNBWCs5a2pF?=
 =?utf-8?B?ZDJEYzRJWlBXZnc5Wm92RWhsSjliMHpLbU04d0hrU29qdFVQQnc3Q2o3YzRF?=
 =?utf-8?B?VkEzNnNuS2ovUFlLUGp2QWw0bVhCd0w5Y2hoUDBCY2FJcnRZOWMvVHBEQkVJ?=
 =?utf-8?B?TWdFT0hVTjZYU055SXZRQjF5UUwxaWJydE1zWDgwTDR4TTdheVFJK3U5TWgv?=
 =?utf-8?B?Y3ZLMVd4OHhyZEQ2WitxR1pma2kyS3NzL3VZQ1NNOVhCYzQxcEdRL2pjb1JD?=
 =?utf-8?B?Ym9hM3RPM1Fib1VnMHNOUDRzeW5XamVEYXAzLzBKek9ob2VyaFlCaFFGY1lh?=
 =?utf-8?B?YUdBTncvdm82T0E5aC9XL3hXRkh0SDNVY2FmbHNJZVpIZmZZTmdCeU8xM0R2?=
 =?utf-8?B?MW11NXp5TzFhWU81cFZFbktTYm1paVVmd25VR3ZqUTVQdzBCY0NWVEVHeGZP?=
 =?utf-8?B?eHVrbEx6cnQzbnZ5d1RuSVFnZmh5ak5RNXVYdlhTK3BRT1ppT1QvS0R6MFJC?=
 =?utf-8?B?WkF3N2VPNnc3Mk1wblgzd2JuQUlZaDlmVm5hbStoNkYyb05hQXl1YUk3b2lm?=
 =?utf-8?B?NXJaKzg2T0VTQ3lVcklFbEUwUXdDaWxJMHp6QWxRNjhXVE0wTy9jMFY4THlH?=
 =?utf-8?B?R2NCb1kxZ2dJNTZKTFZQZS9oOTR6QmtZNFBFRjBKYjBlZ21uQTFYZFhxZ2pB?=
 =?utf-8?B?Z1gyVEhETDA4UW5VL3VHU1d5ZEdwYjFkeTM3aGNub0NrWENtSnlId2JGYTdS?=
 =?utf-8?Q?Et45ojgiGoHiUe9c7xh/IfhKS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a794f30c-fad9-4c72-1b47-08dc5a319585
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 14:13:38.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ETRZJJB/awVlc6ub9WEKpb+IwfCICT27d3nSel0pvTlW8dxz4RVqBr97zHx6Bu3XHuXhabX6sT8elb5M1VHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

On 4/10/24 17:26, Huang, Kai wrote:
> On 11/04/2024 4:14 am, Tom Lendacky wrote:
>> On 4/10/24 11:08, Tom Lendacky wrote:
>>> On 4/7/24 07:44, Kai Huang wrote:
>>>
>>>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>>>> index b8441147eb5e..5ba8a9c1e47a 100644
>>>> --- a/arch/x86/kernel/process.c
>>>> +++ b/arch/x86/kernel/process.c
>>>> @@ -813,18 +813,16 @@ void __noreturn stop_this_cpu(void *dummy)
>>>>       mcheck_cpu_clear(c);
>>>>       /*
>>>> -     * Use wbinvd on processors that support SME. This provides 
>>>> support
>>>> -     * for performing a successful kexec when going from SME inactive
>>>> -     * to SME active (or vice-versa). The cache must be cleared so 
>>>> that
>>>> -     * if there are entries with the same physical address, both 
>>>> with and
>>>> -     * without the encryption bit, they don't race each other when 
>>>> flushed
>>>> -     * and potentially end up with the wrong entry being committed to
>>>> -     * memory.
>>>> +     * The kernel could leave caches in incoherent state on SME/TDX
>>>> +     * capable platforms.  Flush cache to avoid silent memory
>>>> +     * corruption for these platforms.
>>>>        *
>>>> -     * Test the CPUID bit directly because the machine might've 
>>>> cleared
>>>> -     * X86_FEATURE_SME due to cmdline options.
>>>> +     * stop_this_cpu() is not a fast path, just do unconditional
>>>> +     * WBINVD for simplicity.  But only do WBINVD for bare-metal
>>>> +     * as TDX guests and SEV-ES/SEV-SNP guests will get unexpected
>>>> +     * (and unnecessary) #VE and may unable to handle.
>>>
>>> In addition to Kirill's comment on #VE...
>>>
>>> This last part of the comment reads a bit odd since you say 
>>> unconditional and then say only do WBINVD for bare-metal. Maybe 
>>> something like this makes it a bit clearer?:
>>>
>>> For TDX and SEV-ES/SEV-SNP guests, a WBINVD may cause an exception 
>>> (#VE or #VC). However, all exception handling has been torn down at 
>>> this point, so this would cause the guest to crash. Since memory 
>>> within these types of guests is coherent only issue the WBINVD on 
>>> bare-metal.
>>
>> Hmmm... actually it was the other WBINVD in patch #2 that caused the 
>> crash, so what I wrote above isn't accurate. You might want to re-word 
>> as appropriate.
> 
> Yeah that's why I used "may unable to handle" in the comment, as I 
> thought there's no need to be that specific?

Yes, makes sense.

> 
> I tend not to mention "memory within these types of guests is coherent". 
>   I mean the current upstream kernel _ONLY_ does WBINVD for SME, that 
> means for all non-SME environment there's no concern to do WBINVD here.
> 
> Here we only extend to do WBINVD on more environments, so as long as 
> there's no harm to do WBINVD for them it's OK.
> 
> How about below?
> 
>      /*
>       * The kernel could leave caches in incoherent state on SME/TDX
>       * capable platforms.  Flush cache to avoid silent memory
>       * corruption for these platforms.
>       *
>       * For TDX and SEV-ES/SEV-SNP guests, a WBINVD causes an
>       * exception (#VE or #VC), and the kernel may not be able
>       * to handle such exception (e.g., TDX guest panics if it
>       * sees #VE).  Since stop_this_cpu() isn't a fast path, just
>       * issue the WBINVD on bare-metal instead of sprinkling
>       * around vendor-specific checks.
>       */

I think that's ok, but maybe just adding that the WBINVD is not 
necessary for TDX and SEV-ES/SEV-SNP would make it clearer. Just my 
opinion, though.

Thanks,
Tom

>>
>> Thanks,
>> Tom
>>
>>>
>>> And you can expand the comment block out to at least 80 characters to 
>>> make it more compact.
> 
> OK I can do.  I guess I have to change my vim setting to do so, though :-)

