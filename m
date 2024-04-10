Return-Path: <linux-kernel+bounces-138965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ECE89FCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E10A1F237BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB86017A931;
	Wed, 10 Apr 2024 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FOjFvGKg"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2105.outbound.protection.outlook.com [40.107.220.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37E176FDB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766101; cv=fail; b=D1U3MJWN1w78HQq1KxZU0lGrBwBVy0m4IH1tY2on2zJ/1AAJmw9cMKW4ENdNzERWs3XlPq3YQSvkUraDYHS/ImtE4kepUEPDv9osWuzll9MDQMZQUy8lHL4uZgB6JWAHAuubGFNsOUCNQ73ELONWHlWJNoNYHQk0SjafJ+PWcNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766101; c=relaxed/simple;
	bh=4135oTGqxw/ZsXoEZNr/V6px1GIkST2lTaFElF/CAL8=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=kMSpe23i4pnPD8cuAa3PaYnANbCInM+fyhOtyZ/auJqtkfie1cfzwNUN5SKILAMoe29qOMEmMQgXoUeVQHqlTQ8TYc/f6e8iOeEAKkZ61vctZ934aV5od9oySKPckNUSJLr44k2+I0aoW+Fs9DI4cHwOGwSGxoc1AGPlF66tzMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FOjFvGKg; arc=fail smtp.client-ip=40.107.220.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiPJ1vuxKxvJIUz+VcEQLKSAH7A/eeikPTUp3yMGwjh0cr204NAIYX0GcPZKSZbLofTfcSQLFMb0zPVZLIOmf4eAYSSXwQl/5C0CtT8Ric24fx1630K0FYQkOd8i+PW3E5egFlzotXoy3NfnEb12AAXZI3BuvopekpOd3HKC4FtARzn1FRS9eFBmrMh+mh070USZAh872QQHff3K2EmjJMH/GHlqHPq/Ce5yYN5Ph+UWOp++KGiYZ2YH14oVT+kmEE608sv3RYDhPwhIFrAx3GhJ9CxpXAmKAh7nbHOp49NTOrqWaMFxDkr5VeSPvVwH2TVhUruYuLuFdtwkUYbv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSK/9cz05YhOg6XQuitbD5z/wA4leS5gIfU0oAa8Fs0=;
 b=QLCt4s5lxcpEZU+MimGTNuWyBDvIrvLH8X3mAfPipKD7Ek6Ntn1+hdV2RbAIic1huDv+FuFk3/ztyEM54glwOR7sK5MLeCd/UAb4lLQepFRb+eZPL82QSuJX5/Siqu20wQzjSGogZFzlCqZlgV+i/jp1xG0Fd0jk+I7kMPIwYMeDUKUoSN3lTt2VpjKD69WhnKIBV+0Ma5QfUVVrERzhJ51jvmpBf5w6yJMRTzXNKDQyjYgE9Qfb5UytvIalFkp6j4m7xV/MaD7bua0uolUo2jsL4II6GQr2tvxtkRf/h10eARubCanm4ufyvydQj2CLuQPzMGqiLXhBE/wIE197qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSK/9cz05YhOg6XQuitbD5z/wA4leS5gIfU0oAa8Fs0=;
 b=FOjFvGKgi5yAT5h4I473uxTWzAGq3X1/2moj2z3/P75FBll72ooznwfVyr8Fli5pjuNx3ruio0VUIHykHztipBYHjI7LLmjAamLql8lKZp7IfxaQLNdjosrOleLrLD1wNuYKpMK8PjUgIIW2+K7f+Lq6oo7IE/cJsevaRQ5HEo0=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 10 Apr 2024 16:21:25 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 16:21:25 +0000
Message-ID: <f361d574-11d6-3730-c77f-f3aabe111454@amd.com>
Date: Wed, 10 Apr 2024 11:21:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, bp@alien8.de,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1712493366.git.kai.huang@intel.com>
 <5aca124fe0ca1c97bf4a2e925b3905485bf5b255.1712493366.git.kai.huang@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
In-Reply-To: <5aca124fe0ca1c97bf4a2e925b3905485bf5b255.1712493366.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:806:121::25) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS7PR12MB8324:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1CkBxJvawXqzd+pQi4Eo+z3SDMiTKpl3j+GrxZCkXetQiWdIkG0El58AGdUismcUDict5nk7/Eb98V3ZCHLyGaJ2yONEdb+AGG7o/GDDa4s/RayExePOLb2yg07M90oONXDQrYBU0NxVLOykC6xBLvaN8sDilW3DtQUG7BxOkjVl11eS5m6u1eCr84wU1+N0kdvxOXu9OjAjuYI4fLHQdwvDlxJ38F7GOvYwkfgwld3gAN79HpUEFHTxnvUImdC3yu4Ysz9E8pGIGI2Yc5KFxsj2tufTYMx1d3A1Ii2Zet6cxm5Lt/9zds6Gv0kB29idu7YhrncdmdO3lBG0AEnCb5/qoTkYeNHcfaGdRQkuHBhrBDkGeYhUem+Z6aRxUefN8xTzzpByJGlT7281wjDl0DTLpNZV6t1aMaRDnigz1LLk969yoPU5xGiCtt7SzRCnGm3Pe8qap3qnj5yZ9LF1LXrzXi3h94dDTUQlFytmqVG5I4mcuI+9XWG1rYfLunTw6h+NRBolpzeH9E3fSkIKkqWnq4K6geVclm8j9wYb7qWEiuSYZdwtEaCnyD6Cx6rVw9sDhr8RFc++wsR9iacwJbQWlCsjYM7tb2L3d8a1FVv0/aK6KWL1184Ey5Q+GVq89QE1vRdHRjeucuFuYRw/CktvHfqxA6waO3/RZLljYF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am44RmtweGdTU0VyTEtCTjRkeU9xaGVjS0poTG8zZXA4c3FpOXJrRW9hRzI1?=
 =?utf-8?B?UmlBa1dDdDMvZHRCd2pyRkpnUmVlbHlaYVRCQnc1eUg5UGNBN1RqUlprajBH?=
 =?utf-8?B?a1AyU3g0dnVML3ZlOWE1NDhMRStrc1JqWCtEa3JsTzdqcE1nT3RqVTlpWmpK?=
 =?utf-8?B?dHlyTDVVb1YxUlJDUzFDY1FEWGxYcWM1RzBVQjYweVRvTkJCWVQvMDhIN0xo?=
 =?utf-8?B?N3lYUzcrVWI0MWFRVnM4emtXMTd4clBWek9LcnE0T2NsTGxEbE1oK1ZDNVhG?=
 =?utf-8?B?WExoT0NwaW44OVoyNGpURWtaNTJVeEpTdC82ZXV2SnZPUkhzUWV2ZWpDYmVi?=
 =?utf-8?B?SG5Xa3ZzR2xJVG0wNWtPRmpsZ3hUYzBUNmhvZEJKYXZvUFlWY2pmZWJPa3dO?=
 =?utf-8?B?YVFEb2dpY3VzLy94SzAweTNTdVlrWE10YnViMEZGbkswUWtPTHZIUHRzd203?=
 =?utf-8?B?Q3J1NUVUNng4bjhKdHZqWVVkcjRLbThLNmhVTDlCUytZOXlXTGVzOUFoaEhk?=
 =?utf-8?B?blJvcnNkMWZGM2RFNkVCSnlXU3J3elN0elBiOHBYK0l5WVIrSWpNQVlPZUdE?=
 =?utf-8?B?bCtpdU80d1k5R2xCZVFlK0VOTHVmK2xEejhVcUZOd3pJbDVPOS92NVdSdDlt?=
 =?utf-8?B?ZWN1UzE5WWZvSlFpU3lrRmZDUHhtTEFRMUJUZ0ErSzVScjJxdVJvTlFLOEJk?=
 =?utf-8?B?aDdLN1RtaW5rcnhsbTViWkpvalhaTG5wbXdKekxQT0tCanlkUGNIWFp3b2VT?=
 =?utf-8?B?c1M5ajZCRjBkbkVnOFJwYmZPRnFWVFpub3ZXUjI5eUdVc2RYeHpabU1vYjl5?=
 =?utf-8?B?YnVFL0Y2UGI2U1d0dnlTcUZTMmZzV2gydmNXWVJ2UVVyR1Z3bXFNR21oOE92?=
 =?utf-8?B?YzlJWE5BRWwyWkhlbndWZXFFZnU5c0RIR29FaE9GVDlpT2xpbko3aUJWYVhW?=
 =?utf-8?B?d09XMDFpMzFvUEd5MUUrNW1YRlFIVG1Bczd1ZWhjNlRyTXJsZmpNeFI3Z3o1?=
 =?utf-8?B?VVl4TGRvZXZna0cyakVacEpRcTdBdkJTb1VsUmdabml0dkkwSHFjbThJY2dT?=
 =?utf-8?B?VTlBVmlLNmZiV1JxOUVwR2pud0h6eW0zZWdZQjFsL2Era3pGOWlyQ255YUZI?=
 =?utf-8?B?RDg2ZnBEYkEyYks4WWE5ZTRKNHF4T2FRZ2NzYXRZUE5xM1VUUTdFQmF2QXlB?=
 =?utf-8?B?bHBEM1F0bWFSekRudXlNQ1crL2d2UG9CRkJ2UDNwOHhqQXFRbVM4MGdSM1R5?=
 =?utf-8?B?ZjdwSGQzVlFjajAvZTE0NmdhdkNjczN0Y1dVVGVkaTFVbW9NN1FtYm9IZGVa?=
 =?utf-8?B?QkxrWDRHM0JJNXV4L3BlRDhSb2hreVZIWXNOL3hCdVhnNUxRUTgwNWhnVHdS?=
 =?utf-8?B?ejNKQzEwRzFIQUozV3JVZ0xPa0hOb2lSNXVoUHJQLzZLUFgwZEZrZkZSM1dv?=
 =?utf-8?B?eHZoY2dvSDVZMDhtaVlQZEdENEF4cStsL1ZDdnVxanlPRkpaUUpQV0dTMmNS?=
 =?utf-8?B?bGxNRDFLY0Rqb0hzY2tJQlpQNmlNMW1PMUozTVdwVHhNOGpDNVIxMmc5V09Z?=
 =?utf-8?B?L3BIbVd6dU9GZmM4WUJxYmVTWVdiRUNwWVlHYjJDR3Ava2tVYmh4QWZWdU9Y?=
 =?utf-8?B?d3IyN09uTE9pM0ZVcnVmQjVnZ2NxR3FZSkFYRzVlQVYwaTFhSkNuU1ZVSEZj?=
 =?utf-8?B?MHZqMU1EMW9pYlRraFMrRlhISXdabEI3NGxqOTNINFEwQk5NY29HcE9zdHBG?=
 =?utf-8?B?VGN0eXZQWlZWQWJkUUl4M3NWZUU0SW9pMFRCT1JzRXVJUFJ6cEFRZmR5OEp5?=
 =?utf-8?B?MEx6aFZqc1gvRkF5V2NuVHRvcUFIOFovNWtjRVlCaUFrWUhIL1hXMGNjMmRF?=
 =?utf-8?B?Y2VXL0RPZFNqM0xRWXBZWit1R2RqREc4bTdCUmVTNy9DbDJZaVY4VHUxYTBV?=
 =?utf-8?B?V0xUR1NEUDREYTk5Vk9mRi85VTZpVTVHeHc4a2Flano1aytLWDBmdXpqL1I4?=
 =?utf-8?B?U1FicTdFaElSZ0F5V2JYYTY3MWsybnducWt6ckdlQ1RwOHFVVGhLOG12Qjdo?=
 =?utf-8?B?T0JLZEVkc0FkbnhHMHV3WjVkQTB2ZkhyRFNzVGRGR1Z1K21kOC93WE1OellC?=
 =?utf-8?Q?o4y/NP6/PhvomacddEXaxcT/Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dcf320-81f0-431d-664b-08dc597a44ac
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 16:21:25.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpE/IAVlr4NiUROQPn+drvMOIxpbWsNF2sjQJvqbtQXHPZze5bVuSGdN32ubwJvMJRIzJsSErMZWmp9GUW65nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324

On 4/7/24 07:44, Kai Huang wrote:
> Both SME and TDX can leave caches in incoherent state due to memory
> encryption.  During kexec, the caches must be flushed before jumping to
> the second kernel to avoid silent memory corruption to the second kernel.
> 
> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
> remote cpus when they are being stopped.  For SME, the WBINVD in
> relocate_kernel() flushes the cache for the last running cpu (which is
> executing the kexec).
> 
> Similarly, to support kexec for TDX host, after stopping all remote cpus
> with cache flushed, the kernel needs to flush cache for the last running
> cpu.
> 
> Use the existing WBINVD in relocate_kernel() to cover TDX host as well.
> 
> However, instead of sprinkling around vendor-specific checks, just do
> unconditional WBINVD to cover both SME and TDX.  Kexec is not a fast path
> so having one additional WBINVD for platforms w/o SME/TDX is acceptable.
> 
> But only do WBINVD for bare-metal because TDX guests and SEV-ES/SEV-SNP
> guests will get unexpected (and yet unnecessary) #VE which the kernel is

s/#VE/#VE or #VC/

> unable to handle at this stage.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dave Young <dyoung@redhat.com>
> ---
> 
> v2 -> v3:
>   - Change to only do WBINVD for bare metal
> 
> ---
>   arch/x86/include/asm/kexec.h         |  2 +-
>   arch/x86/kernel/machine_kexec_64.c   |  2 +-
>   arch/x86/kernel/relocate_kernel_64.S | 14 +++++++++-----
>   3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 91ca9a9ee3a2..455f8a6c66a9 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -128,7 +128,7 @@ relocate_kernel(unsigned long indirection_page,
>   		unsigned long page_list,
>   		unsigned long start_address,
>   		unsigned int preserve_context,
> -		unsigned int host_mem_enc_active);
> +		unsigned int bare_metal);
>   #endif
>   
>   #define ARCH_HAS_KIMAGE_ARCH
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index b180d8e497c3..a454477b7b4c 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -358,7 +358,7 @@ void machine_kexec(struct kimage *image)
>   				       (unsigned long)page_list,
>   				       image->start,
>   				       image->preserve_context,
> -				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
> +				       !boot_cpu_has(X86_FEATURE_HYPERVISOR));
>   
>   #ifdef CONFIG_KEXEC_JUMP
>   	if (image->preserve_context)
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..3e04c5e5687f 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -50,7 +50,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>   	 * %rsi page_list
>   	 * %rdx start address
>   	 * %rcx preserve_context
> -	 * %r8  host_mem_enc_active
> +	 * %r8  bare_metal
>   	 */
>   
>   	/* Save the CPU context, used for jumping back */
> @@ -78,7 +78,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>   	pushq $0
>   	popfq
>   
> -	/* Save SME active flag */
> +	/* Save the bare_metal */

Either "Save bare_metal" or "Save the bare_metal flag"

>   	movq	%r8, %r12
>   
>   	/*
> @@ -160,9 +160,13 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	movq	%r9, %cr3
>   
>   	/*
> -	 * If SME is active, there could be old encrypted cache line
> -	 * entries that will conflict with the now unencrypted memory
> -	 * used by kexec. Flush the caches before copying the kernel.
> +	 * The kernel could leave caches in incoherent state on SME/TDX
> +	 * capable platforms.  Just do unconditional WBINVD to avoid
> +	 * silent memory corruption to the new kernel for these platforms.
> +	 *
> +	 * But only do WBINVD for bare-metal because TDX guests and
> +	 * SEV-ES/SEV-SNP guests will get #VE which the kernel is unable
> +	 * to handle at this stage.

Similar comment here about doing an unconditional WBINVD, but then 
qualifying that as only on guests. This is where talking about how 
exception handling has been torn down would be good.

So for the confusion around the WBINVD in patches 1 and 2.

Thanks,
Tom

>   	 */
>   	testq	%r12, %r12
>   	jz 1f

