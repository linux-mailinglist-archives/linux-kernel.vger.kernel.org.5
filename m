Return-Path: <linux-kernel+bounces-46712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC7D84430D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CDE1C2215B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA112837F;
	Wed, 31 Jan 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uZkPvcpM"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF183CDB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715018; cv=fail; b=c1WBJ7tP2N+QGDOyMRq2wUpYGzADLmvnLJ+B8aPI4nraBkHu7s78Rd01imaXBqu0M+sUxqvK5QahQ1D0eq771x0BOtSYk44XCHFEuXyP+V4QSDBegO6kTDGOezHTmNtE1ugJEf8MsiED+fwdf2nP4tvo/58lfkYiSUl2lIOaip4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715018; c=relaxed/simple;
	bh=GkCxnfFkHIes751C5dbLXweKLuK9wiBhE5LtGJueCiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LLrS9FW042kxl1flsCs/YzkZlTeUgLSxO5va13tkg3Ugac3T61OmpLqMR/jS4l2n58CovxNtMcFXj1hzEb+R0v7C4VB2Db336xAvosdmRMLyZTh6rSPIkV1ShyqcJtv5989AC0WoLjkV8nd1coPnd2BFZZarU8gu+eNrgBEtag8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uZkPvcpM; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBm5cEVJ42xVSqXVr9gGDmI1T9IseuSpAZFJBNTNYiQu3q9YfDVq08LPpSpUsdkKVl4kq+u+Wa6K1n7qx0PGdkWq99c5YM4bIuQ5w5A1w+9A9PvyUDmNqrmtyz4SFC9MPToyPISMXA3RJilu3fjbWHjsofTltoDgr1y9ByszAT5UwrKE0kXU3k6LfEhG2PXjCZbQGv1hnMLaykGUqgRdtHTaJ1b70/u4Zpym91rm2OHspPuptcNOZZJAUSXBFC8s7m76Hn/CzprA2XDw9kE8ZJ1eCZnNmOoUUseGXAYEhJ6E0WpChaG03Q2l9TcuZaHR8nWe0PNC7f2q2nt2A2sWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+scormSJ6S888ZhvRQLMc4EnymyEmMHIVwfDE90yGWs=;
 b=eJ581Af8NQuKq0edrnpraViOvrbSb/I+E8mJgg+KJznB2ETzhJE0lftlnCME/ssC69klVhNX/N+KbHsAU2oZ6RzL/KSkyGRNS64cuJWDr34xe0KxNGeyaDYtOminnN1hK3iAeqgrmUEzkh11oLeZqGzFcS2hiEKlvoo009W5y/wLu1R7GxzYhPLsM0wwT3mjg5iBiHCO5QU485WJ4uGJEa9MdpOVI6/mAR06oOwnmBVVSRZPj9QiTbDtTommOnDNoG4ZdkCciJ7O/4+oP7RL+7CVYMUv2bB8U0mxWXPH5Bv9skFUSTAMDCw1QB4QZkweQAx/9wQNzoao43Qh5kx+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+scormSJ6S888ZhvRQLMc4EnymyEmMHIVwfDE90yGWs=;
 b=uZkPvcpM17+zxMVfTgGrjNKGyQP6pzaLFC2WxQYsiTWJGL3PyGevGW6+pJCxHjW09NfzNl0gAjKhuW4urofs3c5zivgSrHCQl1yvjQwprfvIRcoIxF3WGPSr3X7UqMyYy3euEUcZp2UJ1WOJ+CTOLGx1LQnjyS85y75zdgfPnzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 15:30:13 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:30:13 +0000
Message-ID: <733302e0-e8c2-458e-a4b2-dfd10e065036@amd.com>
Date: Wed, 31 Jan 2024 09:30:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/head64: Replace pointer fixups with
 RIP_RELATIVE_ADDR()
Content-Language: en-US
To: Kevin Loughlin <kevinloughlin@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh
 <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
 Andi Kleen <ak@linux.intel.com>
Cc: Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>,
 Jacob Xu <jacobhxu@google.com>, Sidharth Telang <sidtelang@google.com>
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-3-kevinloughlin@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240130220845.1978329-3-kevinloughlin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:806:127::26) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 32661aac-d54f-4934-3c2f-08dc227184e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/TUtzHur1MZOEF3dDhZ2HH1PZSMAA7lCOX0qL/a+VefnKZ+q5CVUcmokOPMkJm9qcyFgm5aSmXAkBMpZ6l+wv/fXGavJ5C0+ryHvo98U9muAa807f8i1BKom1l37FseAqHPvQeRhWAy56wg0joen2bwse6YfLYM/4MI6pzbxUPMOhsP01k8Mm+sXl4N55iOslvsBkRbrCyETB7h9oM31cKJXCHF5wb9pKC8GrmVgXancNiJMnvyqYVRvttxk3cuKvH+1/ahm5UbnRQm0D0PlgAu1vbl0VXKkU2OIWVQpGZDfosMjO87tzq+uVSAPfLqddAqsGNFrf2ugB8G7jNgzblH3YTw4AwZF15SS8smEjApu3MtgBbcr3JW29k3FdErmPeTjsvahWIP0+isvUDWfW85TyeuEq3+v6nIiwno5JoXomaTpFURxcgVB0ZPkVKSROWrp0ZnYvEHH1YXHnxprO8RQ06ddLELHFGm2/wl/9AK6KLSG1p5AVKb3nNkaDeFKso6NRPIJMBIC+lvo7ROBIAlE2lKYT6glRGGYjQiHz7KTmhF5wAXUKT+nqMNNQXSRpgiMBKM6QmbyCL0/LAlEmq0yTjEwmJYGxChl4hT15aWG9LUJTsQglkdsgf4eHHbuNwbTZY7EYw1T0LxrLtfkfNpjnAzBg2/qehKpWHW2syU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(36756003)(31696002)(38100700002)(86362001)(110136005)(4326008)(6506007)(53546011)(316002)(7416002)(8936002)(54906003)(8676002)(6486002)(66476007)(66556008)(66946007)(5660300002)(478600001)(2906002)(83380400001)(26005)(6512007)(2616005)(921011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dldIa1hQOG15OEw5V0RaSDU3QndKSmRiY0NLVVhEYzBJU1ExL216MHF0SElD?=
 =?utf-8?B?cURKYVFCMEUyRHlFTlExelJxd1V6R0NhYlJVS1JzczI1UmpBaDR4NHE2SjNS?=
 =?utf-8?B?M08ycVdwTlhBanQ5RHlHV2pOcE9NN2lqbzk5M2VNaDRYSVZQT04wd0ZKZWlI?=
 =?utf-8?B?MTdCNThkWVM4VXo3cEhOZUxzZFRPS3Q4WmhDRS9yY0ZnZkR3c2NxMENpUndl?=
 =?utf-8?B?NHJpM2luR1RZL0J2VXNSRGlzazFIUXU1YkxtekVjLzBRUXRwNkNweFJSRWY0?=
 =?utf-8?B?WGFQVTdYcDBvNUVHN2FLQTd3YlpEdExMV2JZd3A3RkVaQ09aNTJWS0lseVBJ?=
 =?utf-8?B?aVJSTjRBY0lhc1pnd1lOMDNEOGE3WXJqOVBJRFhYZy96Q0QzeE0vRnhSR09x?=
 =?utf-8?B?TmhrNWkwbkdnNk0zUWhoWkZodlZ3ZVdYLytvdTJSR0ZSU1l4OUt3WTJ3d1hU?=
 =?utf-8?B?SUNmQ2o3ZzFVajhiRmRzVmtqVFFZUVR5Z1FlTzVxVTJyRWF3WTJReXBpU1U0?=
 =?utf-8?B?WXlvenRwVE9RSTZzV3FRQXAvUHpzMFVqNjZ5ajkvQkl3dkRNK0ZpajJyeFNn?=
 =?utf-8?B?TGluOVZ3bGoyV3NJL2hDQnR3ODd6K2ZUYXRvcFhGc2MxakZ0UVYxOHpuUW9E?=
 =?utf-8?B?TEtsY3N4Uk5CbzdsSVhaajlTR2p2OGtnOUdza25SQWs4Y21rc1c5REtJdWJO?=
 =?utf-8?B?VjFXV3VhUUhkTE8zRjRKdXRKeTRkempZYkdlSHZ0bndXOTYrRExubGREQ0dI?=
 =?utf-8?B?WWdKTDdwcy8rWkJJemErNnl6NzE1YzFkd3FTcjRjQlBvL2hhaERVcDhtYkht?=
 =?utf-8?B?YzlKOTNuNjJMM1F6d3dKdVJLRmNCc3l6c2RiSUtEaTZtYko4c3MxYWcwRHoy?=
 =?utf-8?B?SU1KV1FueWlKalVJQUlURXUxV2Q4TU9tN25xRWgwTDB3ZHFwbkRydXZYWVFY?=
 =?utf-8?B?UUNQM0ZjTVQ2SGNaUVJlT2lOR3MvUGM4SXJwdWtIWndsM0tDU1RzVmdDdzhU?=
 =?utf-8?B?dFFycTRWZmdwN1R4UWdBY2VQcVllMFBNT1hPTnRMRFJHWStTN3Zoa0NLR1F3?=
 =?utf-8?B?ZC9kMnR1dVQwR281RjBTajFPMWw3T2pHaXg4dGFvQjQ5SWd2eDEybWFzaUNU?=
 =?utf-8?B?VzdLM0w3dTYwSW1Mb3dPVlJYaE5DVEpiYnRQQ3pFd29NRHRTU2xURS92eHEx?=
 =?utf-8?B?bFBiRWZaMkdDS0lPU1dRNjFySHNNc0tMcTI1UW9SQ1pzVS91Q2JoNjM5eVBB?=
 =?utf-8?B?bHVEc2RMRWZ0d3RrWVBlU2hPaWRYeURNWUlrN29OWHdXSjM2aC83TSt2Zy9i?=
 =?utf-8?B?QU5QZkhiQWUyM1ovbXFpdkVyM0h1TjBhSjFTOHgxWTYyeXhTMTNXeFg5Y2s3?=
 =?utf-8?B?Uy85S1dNZFYrSWxEK05NbFdmcWdlbkRRWWtGSXVJWTVRdHptdTJRZmFzc29n?=
 =?utf-8?B?NEVQTkVHTHdaVUdaN3FaVDZKWW1jK3FCL2FadXRQbCthcXlSM0RFdVAvUElk?=
 =?utf-8?B?VUFxakNWY0lrUFc3dytxSFZRdVo5Q1UzZ1dWVjhCb2FSc0VpYU1NV1ZHNXpj?=
 =?utf-8?B?Z2J1YmpsNURVQnFzUkhrYklKaUFXTTF2cFJacFlsRDluR2xGL1BEZmZZSWdF?=
 =?utf-8?B?T2NOK3NHMklXWEtjWFg4ZDE2QWNHQ2hRMlVvZmtDVG5od1FUQkZ3NDRSUXZv?=
 =?utf-8?B?ajJlRkExYk4yTElVUzl3VkZBZ0tidWFQaGpZNnZJR1lZNncxZ21oRVJBOVpN?=
 =?utf-8?B?dHNyMWwxQlpGTU82TytHMjhPL0lxRTMzOU1CaHo2akNPVXMva3ZmRm1NMEpD?=
 =?utf-8?B?MFQ5aVpLR2dVRnFWdk1wOHFYWDY0dlVDUWIvV3Y5TGIxQnJSalpsZHNXMnlF?=
 =?utf-8?B?MEowd20zRG12UDJKSlA1cnZCNlFNU0JlaGdycVVzTHRKdWx4TGVkNlM3Sk1K?=
 =?utf-8?B?RTFBSE1pcmFWSWg2Q0lmWlFTM2c5VzhEeDcyU3dXNmVKbXFrc21hS3ZUREtU?=
 =?utf-8?B?ODN4UnlXOXZpU1NZUFVHNEc0dHJLdzdTcW1JT25KU0xOa21vVmFLaWNYRlll?=
 =?utf-8?B?eXRDS0lwL3F0MWh6My9WdmpHOHgySDJ6a09YdHpLVGRxYzRBVXBEZ3ZWYnc3?=
 =?utf-8?Q?b3XmJl/nV1KXqL6EaAbZ2S49X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32661aac-d54f-4934-3c2f-08dc227184e6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:30:13.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8Av6IiJiFy5JydhKrUHeW6txhAAp+CtpIsT18Ai66g3elmfxV7n6IN3h15Zw3qApC1bLJ9TgfPZ+qkcgs0Ivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112

On 1/30/24 16:08, Kevin Loughlin wrote:
> Now that we have RIP_RELATIVE_ADDR(), we can replace the "fixup_*()"
> family of functions in head64.c with the new macro for cleaner code.

If this series is purely for backporting, this specific patch isn't 
needed, right? Since this all works today with clang?

Thanks,
Tom

> 
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> ---
>   arch/x86/kernel/head64.c | 63 +++++++++++++++-------------------------
>   1 file changed, 24 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index d159239997f4..e782149eefc4 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -85,23 +85,8 @@ static struct desc_ptr startup_gdt_descr __initdata = {
>   	.address = 0,
>   };
>   
> -static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
> -{
> -	return ptr - (void *)_text + (void *)physaddr;
> -}
> -
> -static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
> -{
> -	return fixup_pointer(ptr, physaddr);
> -}
> -
>   #ifdef CONFIG_X86_5LEVEL
> -static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
> -{
> -	return fixup_pointer(ptr, physaddr);
> -}
> -
> -static bool __head check_la57_support(unsigned long physaddr)
> +static bool __head check_la57_support(void)
>   {
>   	/*
>   	 * 5-level paging is detected and enabled at kernel decompression
> @@ -110,17 +95,17 @@ static bool __head check_la57_support(unsigned long physaddr)
>   	if (!(native_read_cr4() & X86_CR4_LA57))
>   		return false;
>   
> -	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
> -	*fixup_int(&pgdir_shift, physaddr) = 48;
> -	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
> -	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
> -	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
> -	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
> +	*((unsigned int *)RIP_RELATIVE_ADDR(__pgtable_l5_enabled)) = 1;
> +	*((unsigned int *)RIP_RELATIVE_ADDR(pgdir_shift)) = 48;
> +	*((unsigned int *)RIP_RELATIVE_ADDR(ptrs_per_p4d)) = 512;
> +	*((unsigned long *)RIP_RELATIVE_ADDR(page_offset_base)) = __PAGE_OFFSET_BASE_L5;
> +	*((unsigned long *)RIP_RELATIVE_ADDR(vmalloc_base)) = __VMALLOC_BASE_L5;
> +	*((unsigned long *)RIP_RELATIVE_ADDR(vmemmap_base)) = __VMEMMAP_BASE_L5;
>   
>   	return true;
>   }
>   #else
> -static bool __head check_la57_support(unsigned long physaddr)
> +static bool __head check_la57_support(void)
>   {
>   	return false;
>   }
> @@ -175,8 +160,8 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>    * Code in __startup_64() can be relocated during execution, but the compiler
>    * doesn't have to generate PC-relative relocations when accessing globals from
>    * that function. Clang actually does not generate them, which leads to
> - * boot-time crashes. To work around this problem, every global pointer must
> - * be adjusted using fixup_pointer() or RIP_RELATIVE_ADDR().
> + * boot-time crashes. To work around this problem, every global variable access
> + * must be adjusted using RIP_RELATIVE_ADDR().
>    */
>   unsigned long __head __startup_64(unsigned long physaddr,
>   				  struct boot_params *bp)
> @@ -194,7 +179,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	int i;
>   	unsigned int *next_pgt_ptr;
>   
> -	la57 = check_la57_support(physaddr);
> +	la57 = check_la57_support();
>   
>   	/* Is the address too large? */
>   	if (physaddr >> MAX_PHYSMEM_BITS)
> @@ -215,7 +200,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   
>   	/* Fixup the physical addresses in the page table */
>   
> -	pgd = fixup_pointer(early_top_pgt, physaddr);
> +	pgd = RIP_RELATIVE_ADDR(early_top_pgt);
>   	p = pgd + pgd_index(__START_KERNEL_map);
>   	if (la57)
>   		*p = (unsigned long)level4_kernel_pgt;
> @@ -224,15 +209,15 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
>   
>   	if (la57) {
> -		p4d = fixup_pointer(level4_kernel_pgt, physaddr);
> +		p4d = RIP_RELATIVE_ADDR(level4_kernel_pgt);
>   		p4d[511] += load_delta;
>   	}
>   
> -	pud = fixup_pointer(level3_kernel_pgt, physaddr);
> +	pud = RIP_RELATIVE_ADDR(level3_kernel_pgt);
>   	pud[510] += load_delta;
>   	pud[511] += load_delta;
>   
> -	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
> +	pmd = RIP_RELATIVE_ADDR(level2_fixmap_pgt);
>   	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
>   		pmd[i] += load_delta;
>   
> @@ -243,8 +228,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	 * it avoids problems around wraparound.
>   	 */
>   
> -	next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
> -	early_dynamic_pgts_ptr = fixup_pointer(early_dynamic_pgts, physaddr);
> +	early_dynamic_pgts_ptr = RIP_RELATIVE_ADDR(early_dynamic_pgts);
> +	next_pgt_ptr = RIP_RELATIVE_ADDR(next_early_pgt);
>   	pud = (pudval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
>   	pmd = (pmdval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
>   
> @@ -272,7 +257,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   
>   	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
>   	/* Filter out unsupported __PAGE_KERNEL_* bits: */
> -	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
> +	mask_ptr = RIP_RELATIVE_ADDR(__supported_pte_mask);
>   	pmd_entry &= *mask_ptr;
>   	pmd_entry += sme_me_mask_fixed_up;
>   	pmd_entry +=  physaddr;
> @@ -299,7 +284,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	 * error, causing the BIOS to halt the system.
>   	 */
>   
> -	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
> +	pmd = RIP_RELATIVE_ADDR(level2_kernel_pgt);
>   
>   	/* invalidate pages before the kernel image */
>   	for (i = 0; i < pmd_index((unsigned long)_text); i++)
> @@ -318,7 +303,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	 * Fixup phys_base - remove the memory encryption mask to obtain
>   	 * the true physical address.
>   	 */
> -	*fixup_long(&phys_base, physaddr) += load_delta - sme_me_mask_fixed_up;
> +	*((unsigned long *)RIP_RELATIVE_ADDR(phys_base)) += load_delta - sme_me_mask_fixed_up;
>   
>   	return sme_postprocess_startup(bp, pmd);
>   }
> @@ -594,15 +579,15 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
>   /* This runs while still in the direct mapping */
>   static void __head startup_64_load_idt(unsigned long physbase)
>   {
> -	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
> -	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
> +	struct desc_ptr *desc = RIP_RELATIVE_ADDR(bringup_idt_descr);
> +	gate_desc *idt = RIP_RELATIVE_ADDR(bringup_idt_table);
>   
>   
>   	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
>   		void *handler;
>   
>   		/* VMM Communication Exception */
> -		handler = fixup_pointer(vc_no_ghcb, physbase);
> +		handler = RIP_RELATIVE_ADDR(vc_no_ghcb);
>   		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
>   	}
>   
> @@ -629,7 +614,7 @@ void early_setup_idt(void)
>   void __head startup_64_setup_env(unsigned long physbase)
>   {
>   	/* Load GDT */
> -	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
> +	startup_gdt_descr.address = (unsigned long)RIP_RELATIVE_ADDR(startup_gdt);
>   	native_load_gdt(&startup_gdt_descr);
>   
>   	/* New GDT is live - reload data segment registers */

