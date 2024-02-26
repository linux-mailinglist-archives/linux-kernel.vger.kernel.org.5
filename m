Return-Path: <linux-kernel+bounces-82364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD5786833E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6504D28882E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C568E130E2E;
	Mon, 26 Feb 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="muZ6GKhX"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37D130E5E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983483; cv=fail; b=D6XeAFjWhFqJedP1Fw0/CP/EYefjU9gkwg5tYjNeHNPZSPKa+b7ZDnNFYcPRW/Xyzdye60Xhr5l3qm982GVSWeysdmK96NZmngdybbSwQo+/pnZgbUj8xRtkw1HI4NmqMdmVQA27x3qeaf40WBvu1B1isCmqYZ7jyeGWDoXRIiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983483; c=relaxed/simple;
	bh=NMp/tXyn/zWDrkf7FT2Si8qR7ybNYqbGNynY7iYopqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HpByvVgrhcarV52CKLwoQKR/8AYZFs4V35KzhFe0VMQhCWhDvcl9Rw4lOZKKgZXwKOw/mCZdqbJwypHXmm6mWwFASJP6TORcE0Bk+imZikSvyB2bFuLlYGKJnbvv7qjlN+FEGdchululfzkmTgCzkpSPycFknyncFaelUFPyJJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=muZ6GKhX; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4AcLoJikne7F/Kj5xXuaQTeip3JgU5dV1Xgb/bUbdH+60KKd54Gj16YfvnQqhl/W4j4gQ18L8Ql5ogdBnvl60kscgVsVEAoAjP42F7SBrursFsbZ1xDXGxYKCEYKq5TmhbT3q/RFWzQJ8G0A6Yx7HYvxUokigj7bITEplB08CfiPN0wANso0ZK3kcO8ZJ/2WwT+y7LQzg1EIs/xpp/TTS6S5qJZ0noyVXKhHH34XlGN44p635oJ/veAIkQZ9/3F24RmO7R+YOKKA9UXPeXA3Wv6cQ4Dqp69ts/pMCDQNEqgJ9hEJz5qVgQr+oiQrQmpJZ5xAEsoHtRRmydSDzLo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXvZculffv6pjf3qeqtJjqHvnuCTwI5gRB0rGCPTvl4=;
 b=maIYVhXZsouPydx1Uo85uNMOEDE8SjiMoHm8wWYl5YOCENlsqneTGRLj3VPDe/lvivHctRx6PkqDG4Z7M9im0BL7fPPfTACv00VOpcqcw6TytBMQNPfUnn1j8th6JSynXQbziUhxOFaZ4ylsE+IT1pl+vF7WUexT6g70BOFNQvpRYH9L4EfnIno/X80YvOak+48D++XzUUjJOXSsC9oVIDK6UFPQeHUwRoeMXcBT5VLIzXgDPzZuwvIv2//EWXNLWaFCPhopEUUWH9c4GdtGLAKeuj0vRyp2rxqWE+O6+kkLm696am8OGMVj5KAYU2sc4X1Eq6orj7aMXNNG4+35NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXvZculffv6pjf3qeqtJjqHvnuCTwI5gRB0rGCPTvl4=;
 b=muZ6GKhXK7PEPAHkEZapj+B53VpgTlfbt+Tus3AXwuho3A3DnOcSrslKGBb4BnCuf7n1b9birduAzG9/w6IB/xc1xpb2YHP7i23IVDZ/aiobSBsDTuCGUXBCOHgFl00iObIIzF1qVbszZSpbJFLmm1IvCCweP3NN4AbcAAtGQts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 21:37:57 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 21:37:57 +0000
Message-ID: <229aaa22-5e69-4f18-b5f7-fec83109bb53@amd.com>
Date: Mon, 26 Feb 2024 15:37:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/10] x86/sme: Avoid SME/SVE related checks on
 non-SME/SVE platforms
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
References: <20240226142952.64769-12-ardb+git@google.com>
 <20240226142952.64769-17-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240226142952.64769-17-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0019.namprd05.prod.outlook.com
 (2603:10b6:803:40::32) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2f2a01-82b1-4b94-887d-08dc37133270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tzaznT4w6U6uMtuFj5+H7u90OEH5K1gRe63mRsZAI0akNSMCtU/ZU21I6Hf82SgmfjFj4gHa9XnsGPsOqghaDuY5O5cNDgfbFtKXnYTDXhdTiqgVWBoAtgIgh40oPSjXqN9HNcEHIXjkafz/6AZUk9lB4SdeYAQJh7YqN0hkiYzaxyzr8jc6ryxXUsJ1U0dcJv4xy3qk2ujTGTSF0hMzhe7qpRQnpT0AXf2wgO1EZgpbOf8IQJ4L2sp4N/91aV/CNqyasch9MmajC3qesL3yqGeXkmHDX5Kygqp29C5AGLfK63oN0MTXV6dk9X96xfTvXBFJQrFvbEdE9OT0HIJ0DepXMicKWXwK2IxPZWYQG0/JVk6FoNdR8KPR3tGID6kiCgDchIxdNZ8krYbm6KMh/1EFn/5cBmPkr5jZSFvMGAIZxUsI9oFG9rgzBoWFQt3jU/ikT9nXaZPHzhpRS7etuRfU6kFchhdfboJsRfcZYwhbU2zW9pjsjMo6Y+Nb8S3NhvSf0lV2BcvVHMG6LYzJe9QQp8FRSxqXgnmbJqbfwypBCBBlzvEE9J4Myjbdy4Zlgp2dpIuy3sjnV4LPdx5v4/605kta68mv7Aol03opJ8tL2y22xnzujSosnQJPThpj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmROc0tGbVU3RnU5MEh0NzJFQnFpYVhTSzZlOWtLMDVBSXlVSzZ2WGo0VnV4?=
 =?utf-8?B?RitGRWFucUF5UXVHYnQ3eGhUNEJrTkhMaEZjRWRvMVpkbnVyVG50MEYzTmU0?=
 =?utf-8?B?TFVZcVltbWE3c2VwN0pvR0dSRE44K0hzaDMvWjhRWXkrcDVjWEJmV3FITHBG?=
 =?utf-8?B?R3QweGxzTkJjY2hrOWV3MGNsUGs2QTZ3b0ZYNThtdHEvbE1yNUJuSkhsZ3FT?=
 =?utf-8?B?UTJzVVZxT2U1cW03TzNveGlGQ0V4c1VNSThYOGtmOXNhZEt0dGFkRUlBNjFz?=
 =?utf-8?B?T0NzS3pORG1mTzNCUURpWXcrVUpYNW1yZlJLa1pPK2ZaSkJCcktua2VFYzQ5?=
 =?utf-8?B?T0RoVXJKOFcwZGt1UmkySzh6dHFCbGk1MzFiRkNjditUL3N3ZkE0MmNOK1pU?=
 =?utf-8?B?YUJJY2M0ZHFoQUM5OTZJZmU4WTJ4d0NSRm9WV3BSREt6L2VGbHFXUVdEampQ?=
 =?utf-8?B?NFA3Q0ZZSTA1eUxiMVc1bTZGbW5MSmFvVTV4NFJWTnJDaVpsM1dLQURwZEwy?=
 =?utf-8?B?bSs0QUl0YWloL1FqYU9jUGFYR1BrK2krMGwvOFZtZ0VwZG85S2RUdDVrYVc1?=
 =?utf-8?B?Q0h1eUZyT2FxaXgzS1R3U3ZtOFBGVCtsOWJaYVozZGNLQkpqSEZKYjdrTjdS?=
 =?utf-8?B?a2FCR25PSmxZcW5EYnVHaklCWGJXRHg2YmdEcld4SVAwa0QvZEgzcE4zRm1r?=
 =?utf-8?B?UE9hTGxjb0ljK2lTUnE4K2xnWm5pdUNRSmFLWm9ONmhVTE5BamY1R0xKMWJK?=
 =?utf-8?B?SFFVNGxZU2VyUUNtdGxkOHZtSUtsS1BPbEVJeloxSG5JSUV6UlZFeHBXTDZ2?=
 =?utf-8?B?aUJ1ekc0QUlTY1R2YXpWQlQxU3lKNW1YdDk1OEZCelpyVGtCTFFzNWtndXN2?=
 =?utf-8?B?dmQrTW01VkhhOUNwWlN1Qzk4VWhaaFh5T0lvYmh2Szh0WndHaWJVbVYyR2lp?=
 =?utf-8?B?QitHSnJXM2hxNTBtaXZJSDZPdEkvNFVKQUpiZGV5TlhnV0Foc1FTKzBjb3Fq?=
 =?utf-8?B?MGtSSkF3VFU4QnZBRzBSdzFPTE5ocE11VmhtSXJud0kyNWNVUDF4dEdoVzhM?=
 =?utf-8?B?dEFNMDBLc1ZjZmJOZElIVjM5dFQzRGtoMEFlWmxRUlA3SlVEeEh1TjdTZUkv?=
 =?utf-8?B?NThtZEFLNWkyQ01aMGI3a1VPMFB6VFpmSjhPV1VDWmt5dlRjQzFsZ2IyTjBZ?=
 =?utf-8?B?N0g5ZU41SGhPSzcydnl3SnpUSGpjL3hLVUg0ZzVOUUZmRW5TMjNOd1FiaFpL?=
 =?utf-8?B?OVlJV0dJNUZBTHJYTzEvbm9RZ1BZZDB4akliRHpUVTVtZDBrc2l6dTRuQTdN?=
 =?utf-8?B?REFKanhWY1hGV3pkUVR5clhnOTRpTWtXbUxMZmZnaGFCSEt4UVd2K2d5Ukpw?=
 =?utf-8?B?SGhHVEFLSk1BdzJiQWxFN0l0bnlMVUJKTXZ4L1ZnWGpwSTB6OGExNUlEa0Nr?=
 =?utf-8?B?Y1VqWDBNREpJd1ZtQzJVS3hLd3lJS2pYbkZhRFUzL2I4RngvY1Q4SnlqbUVT?=
 =?utf-8?B?S0hxaVBENTl2UW81N2ltMXMrZC93cjN4SEFuemlNM2ZoY1BLNVF5cXFySTA2?=
 =?utf-8?B?K0c2bVRXSmNHdVJWd0RPRXpYc2s0djFwVnJnUDc2b0g3WmxnZlRMRjBNME15?=
 =?utf-8?B?aStYV2kyQUZpOGl0NEoybFd5YUd0NHBXY2Y3RGhnVmVMQ3V4NHZ2d3E5eVFU?=
 =?utf-8?B?ZHRPZjNRV2VvWEZBd2paWXdPUHJkUVhhS2xpZWxyb2pmVENxNEcyZXdUZHI3?=
 =?utf-8?B?UmtIZVNHVWlFdUEvdlIydzA2WG01QU5kemJWVWtVVzlyNTVpSVIvSkdoeUd3?=
 =?utf-8?B?TWRVVjMwQmlkaFZST3hscVFlOFU4azQ0MlZTbzVXVitCQWc2c3dQWnRxcHRo?=
 =?utf-8?B?M2pkS2ViYXJpOW9QcW1RVkxKcms4Z3RDWGJUSk50a2dnSzhTa1RNYThMaFZt?=
 =?utf-8?B?M1d4Nkx0TC80T1JNNjZORWlVMHJQbkc1UE1VekNzS1BETnFsY3ZJRmxUclJx?=
 =?utf-8?B?aWpzWlorczBreElKMVBIZDdGWDVTcmlQOE5Wc3BOYlpYWlZFUHdnTFNPaXVY?=
 =?utf-8?B?UFNmNFpUdjlMcU1ER2FiaHZ5SnIvdW0rSmgvejQ2QWNHSkZOUms4UkhNMys4?=
 =?utf-8?Q?v/QWPE/rJzmHm1A3CsidL7bol?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2f2a01-82b1-4b94-887d-08dc37133270
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 21:37:57.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGaFAAtbqBc2YMfPxPH0JveONXYFLp5iaPTtVVd1BeLINkT1GaVW1HKXWOzcCbtYL/bSBVlzj0pp/SsIoUI42w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099

On 2/26/24 08:29, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Reorganize the early SME/SVE init code so that SME/SVE related calls are

I'm assuming you mean SEV here and in the subject line.

> deferred until it has been determined that the platform actually
> supports this, and so those calls could actually make sense.
> 
> This removes logic from the early boot path that executes from the 1:1
> mapping when booting a CONFIG_AMD_MEM_ENCRYPT=y kernel on a system that
> does not implement that (i.e., 99% of distro kernels)

Maybe I'm missing something but I don't see how this has changed anything 
other than moving the call to sme_encrypt_kernel() within the if statement 
(which means the check at the beginning of sme_encrypt_kernel() could be 
changed do just check for SEV now).

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/x86/include/asm/mem_encrypt.h | 4 ++--
>   arch/x86/kernel/head64.c           | 6 +++---
>   arch/x86/mm/mem_encrypt_identity.c | 8 +++-----
>   3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index b31eb9fd5954..b1437ba0b3b8 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -48,7 +48,7 @@ void __init sme_unmap_bootdata(char *real_mode_data);
>   void __init sme_early_init(void);
>   
>   void __init sme_encrypt_kernel(struct boot_params *bp);
> -void __init sme_enable(struct boot_params *bp);
> +void sme_enable(struct boot_params *bp);
>   
>   int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
>   int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
> @@ -82,7 +82,7 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
>   static inline void __init sme_early_init(void) { }
>   
>   static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
> -static inline void __init sme_enable(struct boot_params *bp) { }
> +static inline void sme_enable(struct boot_params *bp) { }
>   
>   static inline void sev_es_init_vc_handling(void) { }
>   
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index deaaea3280d9..f37278d1cf85 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -98,9 +98,6 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>   	unsigned long vaddr, vaddr_end;
>   	int i;
>   
> -	/* Encrypt the kernel and related (if SME is active) */
> -	sme_encrypt_kernel(bp);
> -
>   	/*
>   	 * Clear the memory encryption mask from the .bss..decrypted section.
>   	 * The bss section will be memset to zero later in the initialization so
> @@ -108,6 +105,9 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>   	 * attribute.
>   	 */

The comment above this if statement should now probably be moved into the 
if portion of the statement after the sme_encrypt_kernel() call, since now 
more than just bss_decrypted work is being done here.

>   	if (sme_get_me_mask()) {
> +		/* Encrypt the kernel and related */
> +		sme_encrypt_kernel(bp);
> +
>   		vaddr = (unsigned long)__start_bss_decrypted;
>   		vaddr_end = (unsigned long)__end_bss_decrypted;
>   
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 0166ab1780cc..7ddcf960e92a 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -45,6 +45,7 @@
>   #include <asm/sections.h>
>   #include <asm/cmdline.h>
>   #include <asm/coco.h>
> +#include <asm/init.h>
>   #include <asm/sev.h>
>   
>   #include "mm_internal.h"
> @@ -502,18 +503,15 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>   	native_write_cr3(__native_read_cr3());
>   }
>   
> -void __init sme_enable(struct boot_params *bp)
> +void __head sme_enable(struct boot_params *bp)
>   {
>   	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
>   	unsigned int eax, ebx, ecx, edx;
>   	unsigned long feature_mask;
>   	unsigned long me_mask;
>   	char buffer[16];
> -	bool snp;
>   	u64 msr;
>   
> -	snp = snp_init(bp);

The snp_init() call is here because the SNP CPUID table needs to be 
established before the below CPUID instruction is executed. This can't be 
moved.

Thanks,
Tom

> -
>   	/* Check for the SME/SEV support leaf */
>   	eax = 0x80000000;
>   	ecx = 0;
> @@ -546,7 +544,7 @@ void __init sme_enable(struct boot_params *bp)
>   	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
>   
>   	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
> -	if (snp && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
> +	if (snp_init(bp) && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
>   		snp_abort();
>   
>   	/* Check if memory encryption is enabled */

