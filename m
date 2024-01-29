Return-Path: <linux-kernel+bounces-42761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA4840655
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F931F26389
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05F764A94;
	Mon, 29 Jan 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M308gwvb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3462811
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533783; cv=fail; b=sRb0AuXBLJ7HooXUS/DP1UmpK3E3gw4zahgaBnN6+CKAGdD7lMJZMzLTX6l/k+g9+ijOPdFDWiDtQ3bnUSDYn+HQsXMmH0pmW1sCDoeSOo2XE0UAiLiBbivyLDFdf83s2U289/pKSFtXfc4sC5T66C11gtNdHMDaqydKNHCBwXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533783; c=relaxed/simple;
	bh=rHywBVfUtnpZl9LT0jYCUrjiP/OweiOyLAwgh5x9/MY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+6rlD8/0GFHqbEam3V+6zeC/770qdOZFHoJjNBAsvKontFJVMXQ/mVIxWcs8rHvpXU9ubTErv0Wy6trr7FaTFa2jcR6/bApKhLutQ+o+s0UEFboKYNJTBKLgN1vYgUKpywwhqUeOonYBOf/glVptulKKzcbCUBZMOlxXmWv7Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M308gwvb; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJNEpSQPx90bmkyVcAtJFijP+PhwMUAW/L4Kf/h/5J6gfURhayesELagopbk9ZLhwUrt7J8oO/W8NF6qqAIYpT4sM7OiWlk7tXJFYrOqjSpT4S7gbVFGZVyFGkofDsswhIkbWyLir3fjqf3cVmTBz7kd0NTqzYWiTzFYTyLnR5GO+M30ZeWimc2QeN6NjrmQREKLhKgvkvqMnvoWOiwAreiHB0P88QS/95QFySH1BQztPQ51NwWOoxKwUT1actBqOAYAwwScqNKVxfHM0LycN/QXxX88OospE3XwLAZFE5JjhtROwiWEB2he3nsi1XnCiTll711u7Rid5cLbVq8/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E3qvqhVy9WZ5LzVzZp5S7u/jA5uXOAptXRzJoyTBcU=;
 b=KjMpkLH8U41++aQ4AjOwGdGnxW4pb8S/fa5eBQGiSSiby7256rwpYEhbGRObjoA/4pKk18GdWSnL8zaCF0E84LHSv6GrYkjTs1biBffbpE6AsgcruSut4K+uSMh2oSptwOeqOXMCBhpESCs9wctHEGWhPi8i7Hu40rWF3a5p4m8FNqRK7Of4/Q/V0YuvN82gw7p5eEwmiXBChNdwMJJRVb1DG9YRMaULUWdW7GmG7Ir9IBdkOWr7RoBbX+QHw5+icSJBGG+Nx3ygdPHcq7C/UDYULS9SQKnB+NghHQW7xpFzShbl9o8U0Vmtgk1rsunHAeKH6MbqhSkyXMNdXlS7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E3qvqhVy9WZ5LzVzZp5S7u/jA5uXOAptXRzJoyTBcU=;
 b=M308gwvbVR9mDn/JuM9SQBFxvJ5AnCZhnx1GqoRtT77w1Zlpazvyai0u4kV/M7Ze1u91ATqfBCaiZvYgK1xpdfOndGp6buoOULrkui0OLh9MehQVy69ilhfMhGWFfQ1UL0Dla+lzUo6mDAxNSM5aQPhxVkM65IjljAOWnYkRFG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Mon, 29 Jan
 2024 13:09:39 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::afdf:5f2a:ead9:622]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::afdf:5f2a:ead9:622%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 13:09:39 +0000
Message-ID: <fad515ec-aba3-4f48-b8be-ebc6640899e3@amd.com>
Date: Mon, 29 Jan 2024 07:09:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 10/16] x86/tdx: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>,
 Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-11-kirill.shutemov@linux.intel.com>
 <f0677a02-72ea-49e8-9499-18eca6b5e8d7@amd.com>
 <r5logoyy46fztohkm6bjobomsrst2izbs2nsts4fegii2uswca@fovizly7y5ju>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <r5logoyy46fztohkm6bjobomsrst2izbs2nsts4fegii2uswca@fovizly7y5ju>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:805:66::16) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: da58bf17-4f0d-47fe-7335-08dc20cb8cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x4h0NJ5tuzWG2bGaE/5NSFbffS+NGv9M5hHIWFf5RX8WNLC+oUc3XhGYb/k1wwzYdjEyUqSesl7KS6TkuGp1jbuOhtmU5M76uqgjztsonkCH7t7828Zrk275gZlmlt35kckB80cxuHd3RcNAvHhDMluc/kn7rgFdNLdN/l19lNzJ0xdtB7jJFnrmTqzx2drwsvOIySWkTrumrCGlTbK9/PJ0hlPcjf24bxUgZZLrNCMB4XDBHSjgAFAA/7l4xpCVUZh6GdzToE9msVOIDlquROgEF7jNLdqnQXH0nnngT7qUgY27UghQ0VnYXGkZVb6oRC85QA2nOKV86V2u8S31Qth0SdqUbF58AyQ/vgd7rnR3gYbOKWU5V3QNsVI0+rDLzutMvckm/04f/3lI15E4SJYMfNgrbchHm5b18oSRuqPAR4NOsDHKZumvRiqc4TQW8NWJVzXY07LbqkogRLeWV+A2G6urp5mGUTGip9+wNqA2nP3MNfrC5p26UflBDLvMI7VToutrLLDovsHoI3DXn6p+qi5bRlASp7kKybg6ncuawUbcalGfllYHVX1T50FjMwdfSHYB70Qt9gedJEN6dTuBSYCowrpcyGQNjjCZLBfV0IqFvmvcB/+0haEmZx2n8vBg4H2l7mUjm7jarAeYXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2616005)(41300700001)(31686004)(26005)(6916009)(316002)(54906003)(36756003)(6512007)(478600001)(53546011)(6506007)(6486002)(83380400001)(66476007)(38100700002)(66556008)(31696002)(5660300002)(7416002)(2906002)(66946007)(86362001)(8936002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVRPK3lTeHIxVGNiQThHWmtIM2Qva0w5MldQT3FIcGVRWDIrYTBXYStjaVJk?=
 =?utf-8?B?ZllyK2J5MmFkWFh4azBtVUJTdzV3a3NWVUxZRVZNdkhxaUxxKytubUJPMTJz?=
 =?utf-8?B?RVphQ0tuSmdpaWVtTjhUc08xRUo0aDdoT09XeXI2VGxnMkZUNXZlZkpSR1lS?=
 =?utf-8?B?NEEvd0NFRjd1ZFJDQWJZQnU2YTBpNHpPNUdiVkY0YzFqak5rWkV4b3U1Tlhq?=
 =?utf-8?B?VVo5dlJXY1RhK1JYbWFKc0FaZDlGS3EzRkRqZ05RQnFycXZTL0VqcndWUldt?=
 =?utf-8?B?a21sSGNXTTBxTitodjFWQjdidVhrVzMxYXZLaXl0bG1pZ0FBbFRqaEZleFpa?=
 =?utf-8?B?eGViOXZtRDBmQlkzVG9vb3J3YkFod211cUVEN0ltMTJrbE1HTS9aN2FPSFg5?=
 =?utf-8?B?MFNjLzBTODhkYkgxTlZBN3dSR3JSSlJRWENOQjhrVTQ4cnJLYUIxSTZXOVNm?=
 =?utf-8?B?VE9qa2FtbWwvdGhSY3ZTc3Zrb3h2Mk93YUZQdlc5M2VlaGlkajA5ZEpJdjAz?=
 =?utf-8?B?OEg5TE1nWDJwUzZla3p1amtObG1KTFFRSUxMSmdjMjBZMGVYK0tyYTN1QXRh?=
 =?utf-8?B?MGhSMlFYY3piTS83M2xRZ2ZFWkRsc1RXZTYxRnA5Wk1JeTd2bFU5UVZPYzdS?=
 =?utf-8?B?VU5telN0eEptWFBobnArMTVFTitYWXdadFJyUE1HMmRnK2tWNGdTUkN1VlhT?=
 =?utf-8?B?Vm1TSDFrVHo4eG5JVEhTcUM2NCtNbDBma2RKNER5eTdGa3VMTlFsMjFwZUt4?=
 =?utf-8?B?djFDbTRtR01xMGFqcTVwNUdNUjVWRWNBMHdmbXFYdHpLSlVub1lmU2gxclhW?=
 =?utf-8?B?T29ONzJuTmZRYTdUcTJGdGxGQ0NsNUh1OGF6dXd2cjI2NVAwQ1hQSkYybWI3?=
 =?utf-8?B?OVJRUHF5WWRtTm50ak9yVXBkWWFkSkxCMjU1cXNqQ01HY2tqNUdvaElnYThy?=
 =?utf-8?B?MW9EZ1RIT0p0cVZhZW83R2VHb2lVaWpVVURuTmdOalFyc3YveTVvWndWdnVw?=
 =?utf-8?B?MUxQYVFEejFpUWdzMHV0US90ZU9HOFMxMG5aS0VjNlpkYVVsVkVXOHFFR3Vu?=
 =?utf-8?B?OUoxMEdRL2I3Vjk3NzVXeU1rVHFQY0kvYVRZWFdka3ZXMVpxV0NxYkxWYVpn?=
 =?utf-8?B?Uk14bjlnSyswb1NaNnpEbnNtWSsveXdPcEFwQkFEdU15RW51YlNsejFsTmxV?=
 =?utf-8?B?a2R0TnpLNEV4MjZSZVI0TVhVa1J6N1hRb1FmUktRQjNreVdrVEpuYXBSbFg2?=
 =?utf-8?B?UG1hblRyQmdIcTdUeE01L1R1SFdLUWQwM0hqKzZvWFNHakswWmRzRjBET2x1?=
 =?utf-8?B?cWllc2prKzVzVCszWEIxVVBIemJpQW4wUy9paUtsMW5ZQUZyNjlETXR5Y2s4?=
 =?utf-8?B?T0hpMkRUUFZvYmxBbUFFc0FSR0graUJxdnJZeUdOQTRxVUZiYmM0YUVVNmJv?=
 =?utf-8?B?dStob3kvajRKNWV3eENIbU5xeDR0RlRVM3FPanRvaEFwcFpnL0FtTVNTc0tO?=
 =?utf-8?B?aExEczVlNDYySmpDZDVEdk9LWlFVWmtRWldKNWFMeXlRNUxsVWppZit2QlAx?=
 =?utf-8?B?VW1TRjB0cWQ5V3dPZkIwaER6OHJ4Zjl1YUlJRGY1QzN1c05yK09hTzlWd2tZ?=
 =?utf-8?B?dWp6bCtzamhiREtMM05mMEp4aUlFT25RMmN2amI5TFRBcDVrTHdyS2JMZUdH?=
 =?utf-8?B?bnlXSWIyR1h3R2UvRjVKV2RRRndKUWp0dk1seXExa0JqQTNHeVBCZWJFR2Fs?=
 =?utf-8?B?YmtnTGNTS295NFRhRTIzK1hNYmpiTEhKSmQ4bUZEdGhtUndHdjlsVlVEbUVa?=
 =?utf-8?B?ZjhyYTlleXY3cmZWeHdrSmlqSVgzM2JXdVNHV1ZzTkVwYUlnQjFuS1ByWnpu?=
 =?utf-8?B?QnZDV3h6Um5kTHd1U3I1SVFwZ0hpdEtmSFAyZ1VyQjBHSS91azBxV3ljL01C?=
 =?utf-8?B?aUNQS2F5NHp5a2xSMHpiSXBGUHdaZFEvM3JiNHYwZ1lQbk9EdHYvL2VUcVU4?=
 =?utf-8?B?ZU5kVE9IN1o1bmUxOXgwQjJSZ3lEK3gxNnpkR054SC85R0RUK1BVRlhhbUdu?=
 =?utf-8?B?VDdtTkxmSitrK2VaVis4R2tYUkV1Q3RYQldQK2NESUw4VnVZekJ4dmZxdjFW?=
 =?utf-8?Q?q1HRFvLQ0QkV3BnmPtgj6YpjA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da58bf17-4f0d-47fe-7335-08dc20cb8cc8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 13:09:39.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEc2VcGq8DyXMhcSBVXCfx/3Ib++azGCp1Hbxc+zqLydNpq8OQ9dwARlV9IKerFxoO3817Z44OR9ZvkIjEE3cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158

Hello Kirill,

On 1/29/2024 4:36 AM, Kirill A. Shutemov wrote:
> On Mon, Jan 29, 2024 at 04:24:09AM -0600, Kalra, Ashish wrote:
>> In case of SNP and crash/kdump case, we need to prevent the boot_ghcb being
>> converted to shared (in snp_kexec_unshare_mem()) as the boot_ghcb is
>> required to handle all I/O for disabling IO-APIC/lapic, hpet, etc., as the
>> enc_kexec_unshare_mem() callback is invoked before the apics, hpet, etc. are
>> disabled.
>>
>> Is there any reason why enc_kexec_unshare_mem() callback is invoked in crash
>> case before the IO-APIC/lapic, hpet, etc. are shutdown/disabled ?
> Not really. Either way works for TDX. I've tested the patch below. Is it
> what you want?
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 6585a5f2c2ba..3001f4857ed7 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -107,11 +107,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>   
>   	crash_smp_send_stop();
>   
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> -		x86_platform.guest.enc_kexec_stop_conversion(true);
> -		x86_platform.guest.enc_kexec_unshare_mem();
> -	}
> -
>   	cpu_emergency_disable_virtualization();
>   
>   	/*
> @@ -129,6 +124,12 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>   #ifdef CONFIG_HPET_TIMER
>   	hpet_disable();
>   #endif
> +
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> +		x86_platform.guest.enc_kexec_stop_conversion(true);
> +		x86_platform.guest.enc_kexec_unshare_mem();
> +	}
> +
>   	crash_save_cpu(regs, safe_smp_processor_id());
>   }
>   

Yes, this will work for SNP.

Thanks, Ashish


