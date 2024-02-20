Return-Path: <linux-kernel+bounces-73186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F485BEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6636287CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F96A8B3;
	Tue, 20 Feb 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JJNDKIm0"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF36266A7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440013; cv=fail; b=Dx5mWhy1TDPZDJ3fsx9Q6MI+NYAyPF6CzmJzcRSeQ9ak1DpnYdB8QIYqtH+IIwoVoaGMpZaAVOA0bVE5W5DAufrJZi172UT7UFUp/UoFms877NzdkA1JoUlJD/irmC3K2BN3Dl74JUaCHiHkuA8mKQ/SrQNWAvdTkmNNQZiu/po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440013; c=relaxed/simple;
	bh=zxD4dKfYhCeI5PEAXkV+bNahd6jDLckv8rLTI/vdrtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e5pibe8HcAExOM8Q+r+CZU+B4nliNnaO4FFsat1DHeXDwc8trcn/IkanTot8t0uCB635i0lLT+UNSlPCiNYLLkJP0oJ1HLvDvErYr2N3LK3QI5xhaWvgNQkY4SuK/KqR0yaeo+wqlt1My/GNf6bKEYV2ABD1c4/hFzMfRQj/PyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JJNDKIm0; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGMQLkN+s+GBJaUNAVGkBkgbMWmORsAOe8TUClaC5svWgTJZPYCcW1sLYn5tUppugTuGULzm98U+ePQbw+8AKr7RKfCHMMFZ7UAJW8FyVh/hPlo9FPde5hl9RIu42BqaMJF4A/lvxCAKaTskrOPBG8cr+dgmfu/dm5G/HgSajKudC2r8WAjGpew6Qoixy7sYfZsnTyQUHqGu/Xy6veD7m/6bnmBEWXCifl6VNJ2DeNJPPpXXemw8RTKRfBSHjZ4GA54KHbS1tgxNTeKwQ6uFifDKsue07c1TQkNo8k8Ejzhe63FFvNbIK0AXqM0MLUZM9uFSuXNgYZdTaFK/XYbODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOeksRvYrA/hyb1oS7mSX48SnA865JA9AZ/y0ywtGpw=;
 b=hTy5heGSjo9HgsBC0QDmkAvc84T5a6+yo2I+W/PRb2RGXa9iuSvqst/VgbX+LKsQ/JDLv1y/ZbzB80SY9bklvoBK2yfUnEdLMOCUQNOvcN/erYaMEjij93ijCSg66UloNt/rDvDrVrAlvCwspKGNjK9bM/AXZiCU/MisAq9Z3/EX9yHSv5h8mkMkJ5ZZCldTCsJkMv5eNaSeaIDYzNc7jB+l2yzGw1bkl4BQ0iwRvyAwcmk0ZVGKYVOC+OeybjCaojw36dYl+kjy7DzgRUzDUEPbb2DdDa9BcuwlUdIQjooBSdIq/PUT9N11Ud3HtzxB194LHQ5plfjnigZqR+bmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOeksRvYrA/hyb1oS7mSX48SnA865JA9AZ/y0ywtGpw=;
 b=JJNDKIm0wvHowhQWFQWBe74ULkr5sDGnGDWln5vI9XJFbD79QT9eOXE1s12ddIHSJG7khgixY6wJQA7/HHL6m6DAsC6XaNYFmuBFw1I0dQ0yNYNceVTL7vq7HMj0pJgMeA9Ia6rKvlOVtXevwl2iGId5Lq46pde3cbywfq3LSq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Tue, 20 Feb
 2024 14:40:08 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 14:40:07 +0000
Message-ID: <5e7c3d98-9c95-4f74-b340-15ac4d9f3a50@amd.com>
Date: Tue, 20 Feb 2024 08:40:05 -0600
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
 <1b38a2a9a7cf2068d7e0a5154111147ba58dc99d.camel@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <1b38a2a9a7cf2068d7e0a5154111147ba58dc99d.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::10) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b6581c-ee8d-4802-fe52-08dc3221d568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Yvs4IxQhvzn4+d5Bab0252HUmORcMTBsyNVDjv/VqFzn+9Vo/M11rjHu6PvB9iQX0wXov50vmKZk0f9XFf6YyEprD7Qutwao6Rw22Xf7vy3+XT37t+cpEmIMM/T7LEOBZDYJY9kA0Hw4lOk+RilYyYPCl/EatVw55E9CLcxeEoy/XlvAEfFtwKgf8UZUOTUPYuw9W5GFts2oI9X0iq8E6ETjWIKB3EfYAv+cj2Ii+yOAIG40nkrwMACL5vl1LXKcBQl6h3OOFOKsaoFRgIdKO9K/JWocNgf1QIeU0eXzgwYgFtGsXvPGUK/UF0h1LaXDaDdVqkSkIG5dZZYQkiZxRwUNqf9chjrIVbm3hwP16PEGAnF0YszL+i8b3SxfJjpnKE8M5uE9fx58psnP+lfaogegMhSg7rXu5Oucy/ltT8LMQomR/46jo/s1hm5GEZ22zjWGngh9Wjw5svgmowh22QdsBx1aILdH2CMV5RpFcfmoRdoF5sNFkMikrd4he984YaEQiVbgpfsMMn1XaZl0bpJLdFe90cOrbnAuxe8hHs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1ZBME1KQ25ScjVFQURaL0dHSG4vRUtkVGhyVmppWm92R050QmIrQWxIclJn?=
 =?utf-8?B?alA2WHBmR2JESVpMZkZCVGl1Ykl0aU96VWQ1dSt3b3VPWkhlTzArZDV5aU1G?=
 =?utf-8?B?aDQyNjR0Z0NFOXFDQjZiS0VsTTVnYldUaDNmRm14TmY4K1ZDdXNRNzl2Uk1M?=
 =?utf-8?B?V29nSFNyMVRXd3RuQnFlbUhnaVZGWWsvTDlvQUdBeUNyVm1DQVQwZlN1UEwx?=
 =?utf-8?B?OXQ4YjdxdEZ3S05VNWJYY1UrQXhjQXJIOHBOUXIrc0dDNXo4cmtMQllaaDJ1?=
 =?utf-8?B?ZzJrRkpnTkNlY1kybnJRMzdMaDcwTWZEa0h5d1o5RnFMR0duZHVIWjkxNlVi?=
 =?utf-8?B?NXFXT05aWkdJcnFxQ3NyL3JmOVUxSVFCa1FUcWlrL2lVNXFlajcxUkxMSjdw?=
 =?utf-8?B?U2pOWmdBYXdvaysvY2hpZGRMb2prQnd4SEY2UWIrRkVheUZPOTVNaGlxSi9p?=
 =?utf-8?B?YVdOS2R4Wks3WGZ6aU5sTVVEbzNsNkx3dzYvaENXVmduVkF4eTJyT3RvR2Jp?=
 =?utf-8?B?d2tQM3VhOWFwcUxjd2syd252eURHSmRiYTZjVzE3eWZ4a2hpc1ArL3V4ZHBC?=
 =?utf-8?B?VWxTQ21wZUUxNm4yOStKSDF4OVVYZGc2VUtKTnR5dE0wNm1sU29pNW5hQUNJ?=
 =?utf-8?B?eDd1aG00QmhFemlwOG1BdUtjWVVVYzYzY2Y4MnZsZFVmTDY4UGlVem9RMDBN?=
 =?utf-8?B?c3J5QlR0TjV6V3Y3aEpJWDhIVmg5MVdXc3NNWmR2STlpUkIvZ25SWHNabWZL?=
 =?utf-8?B?eitaNVJBUW9SUVVZRjQ1akw0YktZeVNCU3ZETlRRandYdVY2VHVrelgxbDl0?=
 =?utf-8?B?TDF2Z3FFdWp5QThkd0taa0N5OU41TkVZS21wTFk5VklWakNGdENMV2lpOFFF?=
 =?utf-8?B?dXhRNmEwdjhDZzZGMDU0TlhhZHlOSDNvcjR5MzR1bDlaaSt0NGhpeG5KUnlX?=
 =?utf-8?B?M2dkY3FQQUt1S01YZTR2SkJHQWIvYWZCNTRvUWdua3JndG94aytQV0I4MHBp?=
 =?utf-8?B?Y2JDMysrS2laZWRtaVl5VzlxWlViYmF0OHJscU5MRVlGei9FazBrcG1BeWJL?=
 =?utf-8?B?K0RTR25zZkFKWFdUbTUvODhKVWJVUm1XUXNqOWg1OEpTKzdkcGZIMW00bDlR?=
 =?utf-8?B?WUJBR0s4SG9SOFlwNW1BdUpJSmJ2YUZHRGw3MFpacStObThDQVFGdU8wTWI2?=
 =?utf-8?B?UlVUSE40cFRSQzM2OFJrdEpwQ2ptRldsZElBajdLRFNqK1JFSmhMR1BLWm5N?=
 =?utf-8?B?REJ5TFJydWpuaCtGc2FBc0pWRTl0SWtpRlF0OFJibUxJU2lhWFRPQS9hQ3Bw?=
 =?utf-8?B?ekZibjFzaFJPYjZaUDVOREllRHFnT1RXME10c2pVMU5OMWtweSs0SXhUNDNj?=
 =?utf-8?B?aWV3Ny9FOVlRZm9RaVVSTlY2UEN6MTV6ZWdtN08vb2RzQ1pLYkp3WCs5aWxz?=
 =?utf-8?B?WmVnMGVOanhTOVJxS3puRHY5NjM3RDZ6MVFLblRHYXFDWVBQd05HM2Z2Vzc4?=
 =?utf-8?B?MW96b3Jmc1FVdU9kZFR5WGtaOUJXNytrTzlTS2RlaDh6aFFBK290RXZrN3RY?=
 =?utf-8?B?ZFVBU3o1QkV5TnFWNlJwS3JOS3dqWVd0SW5XT1ZBOXVxcUg0SjF6VnNwemhD?=
 =?utf-8?B?MkJQOW5Kd2NIU2RjL2RoSGJETCtEZ1dsbUowRGU1QmQ3VHp1T2xOS1NBZkpz?=
 =?utf-8?B?b0l6S0h1aWxBaXpqekpVdGVmcDBKTXhxMHlMcmhaNWp3SVRKUFBDbWgzam1m?=
 =?utf-8?B?YzBRNm5td3Z1UHptdWFvaGFzR0c2U21ERTZyeU5kcCthdFFSTWs1bEwzK0lv?=
 =?utf-8?B?b1VpWVFqci9mRGNBT1BJS3NSa0M0M2Myb3RBTmdnaElzM1Q5TlFHR1k5WnJa?=
 =?utf-8?B?RkJkUk16ZGFXYks3OEs2SVFGWHhvMzFwMkxrR1ZwV3FRYllCZDArWS9wdkwx?=
 =?utf-8?B?WEUxbTBkY0hSak5JUDB4NGZ4d0Jxem5VZ2pVN3Y2WklobVRLVTNmQXp3KzRO?=
 =?utf-8?B?YVFHWmZwMFBNWk5XL0ROenNkRmpvaE9TOWNFVFF1Z3JXQUFoQmZ0L3pJV2JV?=
 =?utf-8?B?TllZYUVON0p4bWR2bkp6dzBNdG1sTXRQZGZ0S1ZBb016U0haS2pDczMwemlJ?=
 =?utf-8?Q?lSQgEANZLf6CjfZMKhOQucwmP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b6581c-ee8d-4802-fe52-08dc3221d568
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:40:07.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXc1ExcvPKniHIa8CoSAmjQhGW7wjSkO9SWGSEKAYWiXDeCs09wDzntdrH8U/sN53aEltypPCCKXybjzgpDkgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495

On 2/19/24 20:57, Huang, Kai wrote:
> On Mon, 2024-02-19 at 16:09 -0600, Tom Lendacky wrote:
>> On 2/19/24 14:32, Borislav Petkov wrote:
>>> On Mon, Feb 19, 2024 at 01:45:37PM -0600, Tom Lendacky wrote:
>>>> This change won't return the correct answer. The check needs to remain
>>>> against the sev_status value.
>>>
>>> Feel free to explain because this patch is confusing me.
>>
>> In your previous email, you want to put the CC_ATTR_HOST_MEM_INCOHERENT
>> case statement with the CC_ATTR_MEM_ENCRYPT case which is returning
>> sme_me_mask. That will be zero/false if SME is not active, skipping the
>> WBINVD. But, in reality you still need to perform the WBINVD in case the
>> kexec target is doing mem_encrypt=on.
>>
>> That's why the '!(sev_status & MSR_AMD64_SEV_ENABLED)' works here.
>> Basically, if you are bare-metal, it will return true. And it will only
>> return true for machines that support SME and have the
>> MSR_AMD64_SYSCFG_MEM_ENCRYPT bit set in SYS_CFG MSR because of where the
>> 'cc_vendor = CC_VENDOR_AMD' assignment is.
>>
> 
> [...]
> 
>> However, if you move the
>> 'cc_vendor = CC_VENDOR_AMD' to before the if statement, then you will have
>> the WBINVD called for any machine that supports SME, even if SME is not
>> possible because the proper bit in the SYS_CFG MSR hasn't been set.
> 
> Hi Tom,
> 
> Thanks for clarifying.  However it seems to me that this is the behaviour in the
> current upstream code.  The stop_this_cpu() checks CPUID directly w/o checking
> the SYS_CFG MSR:

Correct, it will match the upstream behavior this way. It would have been 
improved slightly with your original patch by avoiding the WBINVD if the 
MSR_AMD64_SYSCFG_MEM_ENCRYPT wasn't set.

> 
>          if (c->extended_cpuid_level >= 0x8000001f &&
> 			(cpuid_eax(0x8000001f) & BIT(0)))
>                  native_wbinvd();
> 
> I believe the BIT(0) in CPUID, which is "Secure Memory Encryption Support", will
> always be true regardless of whether the MSR_AMD64_SYSCFG_MEM_ENCRYPT is set in
> SYS_CFG MSR?
> 
> If so, IIUC moving the 'cc_vendor = CC_VENDOR_AMD' to the place right before the
> if statement as suggested by Boris seems just follows the current behaviour in
> the upstream code.

Yep, that's how I see it, too.

Thanks,
Tom

> 
> Of course we need to always return true for CC_ATTR_HOST_MEM_INCOHERENT but not
> querying sme_me_mask.
> 
>>
>> I know what I'm trying to say, let me know if it is making sense...
>>
>>>
>>>>> So you can't put it before the if - just slap it in both branches. Geez!
>>>>
>>>> I think that will still work because sme_me_mask and sev_status will both be
>>>> 0 on bare-metal if 'msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT' doesn't evaluate to
>>>> true. However, that will cause any platform that hasn't enabled memory
>>>> encryption (see SYS_CFG MSR), to also perform the WBINVD.
>>>
>>> If it keeps the code simpler I don't mind. That's so not a fast path.
>>>
>>>> That won't work, because the current system may not have SME active. The
>>>> cases that needs to be caught are kexec'ing from a mem_encrypt=off to a
>>>> mem_encrypt=on or from a mem_encrypt=on to a mem_encrypt=off.
>>>
>>> And I'm saying, we should keep it simple and simply WBINVD on SME
>>> capable machines, regardless of the encryption setting.
>>
>> In that case, CC_ATTR_HOST_MEM_INCOHERENT needs to be separate from
>> CC_ATTR_MEM_ENCRYPT as the original patch has it. The comment might make
>> more sense as:
>>
>> 	 * CC_ATTR_HOST_MEM_INCOHERENT represents whether SME is possible
>> 	 * on the platform, regardless of whether mem_encrypt=on has been
>> 	 * used to make SME active.
>>
>> Thanks,
>> Tom
> 
> This looks good to me.  Thanks!
> 
> 

