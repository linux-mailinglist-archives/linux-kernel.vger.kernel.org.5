Return-Path: <linux-kernel+bounces-142952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4138A3272
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF4E1C2451D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDDD147C9D;
	Fri, 12 Apr 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MAnqQC6Z"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8E137C59
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935729; cv=fail; b=Ufbq4qB1Hewp130hGFMROh7Dv0F+Ghezzvis187XSSJmapznxOtl4LR1k1Kl6kk2Y6/79EwpMyRehWBUlNl17pPYHpDEunHbAYNDeChQ6ds657EYC86YdUbROX7PukPCCvYOjudaWx+hIBfZFBBZAiDAXmuHGmVhGYjqm6yPHs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935729; c=relaxed/simple;
	bh=PCPPrVnY0uo1afgkQg5+/97AT8veYYDtMPFu+E6IRYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jICla0b6XX97eCGzvasC0dBG/ahBdIVDf1PN6Oow6cD2bsidySUGbXhkFjV+EpG2AwBrC5ctV2HAvG5I9k0JTrsuMlgXMmPwx5GjrWOGlaprjWUNiPYTdxr5R8jUWPRoN15KSkPaSO9WIyDj3Xik23qYd/wQejdSO/BCrdjoqgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MAnqQC6Z; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjX8uCwplm7Tt7ZxlkXFIGOS01rHmsDOc7159EjwaHxrJbQLw5z9o+gj3hUjorqP0wNk7isap7Cd3SGkmHyoRb/1jyS57yKcU+Qs1j/2F20eg+nY8Ysq/pdxu2FHdZVhZo+zrteqdST0/7m6IFRe7FJrzq/Jk+6sKv58yoN5s8MnSulx/xx6kkdXWkZKXDwllTrbji68eVOkyYuUj4DJgFBc1q/FPHBhCSnFljktJUNL7Ahy1W/xhadyYKe9XtKtmbRYHemrynup7yLK+WmsiJE5NqWRPdUQqhd48zqjZBvU7mZTKCyU9IkX34qU4VZJW2tTQwlNla7UFGEvcZxU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIynRI23SjYwOmj/NqhNupTVM+w8GN2SP5OP9eFGduU=;
 b=DPaEbH59v9IhNeviLqgwr+c8GTrkTBkS2OOdgwgaep1EbwJSLjzvVjSNwZXuM3bNKW0j44HXcTGxdmzULw6fBH3q3mcw/LGYWN+HuGPgDCZL8phYSP6sz/Jj3rUZz1/prOuhW7zZeWLfzseN/tHgo1VczOoAMNmfJuEr23W427VtnvBLRaXn87JvPqVn+LiEDrSyP/PkMnozv2RgKpFRWfSwsFrkeYQsHtD+zd3tEHXbSkcoqscmwziCZlCk8P1aylEbaCtWRZ9wabwkN5asct//FkUXgKOYpweu6EBdov7DqqhiGTe/a+2OoVT8iT+ZI4svrqu8q5PCuepzehca1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIynRI23SjYwOmj/NqhNupTVM+w8GN2SP5OP9eFGduU=;
 b=MAnqQC6Z/RJg0jShxF5aOnaNZeeVIPTD2/QTnIOkGgjCxKDWo6EQySmv4rbuQfZ1p27Pwa0utn4MsDkufLUPIX95TdTvPhf3aLDPY4PgIuZHvI6tkBXI/hvHnhcmta4QDVyXocfhxY5aNJahzJlidCIICB6Kg8h2Q8Beoalv940=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Fri, 12 Apr 2024 15:28:41 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 15:28:41 +0000
Message-ID: <c17d72ad-544f-0c3c-e250-a78041bfcc16@amd.com>
Date: Fri, 12 Apr 2024 17:28:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/14] x86/sev: Use the SVSM to create a vCPU when not
 in VMPL0
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <b91122a1faf096ec89bb49653d7959158a614528.1711405593.git.thomas.lendacky@amd.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <b91122a1faf096ec89bb49653d7959158a614528.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 398bee66-0022-4b61-468f-08dc5b053b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+W9XAxyqAPJifDIwX6VNjm70Faq9ydfZQ0uPm8BxdST0zDU8jejqnVu1iZgkHhcK7w8aQsNnzm9djKMlPZdbLhPCPL9MD/ndkFQLJjuxbGW4igfCtbKpCU3K4tjIPLdpOgl+YPPRijOb8JLTAmI8lqUfnJHfmsKtNdlb5RUZj/SaaEglRSLY8WNm2ydz2Bfh1YQ2ftp9tV2hWiTy5SrnrBdK7BxbqdAO6EkynTTU4+OYr1RcwlRP26qK99IdEVz/i87IpME0BOIqlD7pH77ndrxMiy9qGxAGRsxbg5C/pVcJnxAdd9w6Upqy4Xj0xx2K/NpUL8hukML31rhANiRc4Hi6pNXUi0HgZBZsz4BWwb/DV9oUuSNM2dRF8mJdEa0ZlW8/ii0iTLwsJrzJVfBmKxOk6zQiyIcqhUKSafmrVEhNSIDBZ9+VxPWjQNMTrt3HC1cqxPm3pKHZUiBffZMtoXAGqQ+0SoCysKMq5DVQy991B+Ss9HSWHKAQLKuT0vSs8PxiC03KDK4qkdp4pesKu1SfrDNk3+FRjQEYY8sibpl0yI7vOlRkueEOACpET2RuksCpK5IkkTvI6a1h///vmGD3RU8tUy+KD8rVDd2GRifyK7aUm5y1nRNVlTb9H/hmxugyZA+0CQZ5hQKU9hCk/QF4/ORlEW4Hi9rsMaKxPDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVNsbGRYYTZCUzA4bHlBcEFrQnZKQU81S0FvQVU0TFR3YlF2NHNsU3g4SXVv?=
 =?utf-8?B?dmlGYVlSc1N2cVA1bG52UW83RSs1NUJPMloyb2FkUzFTYmtOdUpDcTlGSGpT?=
 =?utf-8?B?UU9QK2laSk4yNDh1U2kyODUrNlBzbE9NOFEvYi9JNGFPYWRBV1NqRmZ1TDFO?=
 =?utf-8?B?Nmo5VGZPMGE5WmRnOERJS1pEM1JBQ0ZpdGtqRUcwR1J2VndoMlVoTHFOQnNj?=
 =?utf-8?B?OUE1cDNUaFRwbGdodThmR0lwYnVEcU9xRWd5b0NkaW5jcTNFdy80NHhPMm5s?=
 =?utf-8?B?ZTZxcUswM1ZuSFVWSC9xZG1EekZKSDJVSGFwdGZZSjlpL3d1RnBzSzV4Nmxo?=
 =?utf-8?B?TkRBN2xPa3hCRkN3NkNlMVpCQUYrVWQ1Z0NCVkJWa05qZ1k0RGVjMFpVQ1di?=
 =?utf-8?B?Mnd6KzBPYy9Gc1MzU0RwdVRFWlVmNm5oZWZ6Qk9jRTh2a2VpeG9MY0NkNisz?=
 =?utf-8?B?RmZTUXdZRWxvL21WaXVXTFhBN2MrZC95KytjNk4yR3c2TjlZUlhlQkEwNWEw?=
 =?utf-8?B?Z3M4dDk2cWJpNkZxcjlKTW9IV1hhRVcwOHV5R3plNEsycXJ4RmdxWEhCc3pP?=
 =?utf-8?B?RWVwTGx2d2p5SXdxOW5YbDZTak4wV21WZStYUWVENWViSnpFang0UVdCY2g1?=
 =?utf-8?B?QmJka3U1MXMyNjBLZkRhUjRsZFBCcERqekV6MC9seXc5UGF6a3BKeWs3cWZL?=
 =?utf-8?B?WkM2V0MzVmlwNmY3ZGt1UVNTdGhSZzN3NjhWZUM4MHJDNG9HN3diWFdHa0dR?=
 =?utf-8?B?NXpGZ0YzRXBZRWQ4RnV4TU5jams4L3RwQ3RvaWU3blJqYVNwQUZWeSt3YUJh?=
 =?utf-8?B?MEptV0tXbFFEaHVOVkRUOHhjczY5MmQwSWVIbFZxcUxNRG5GMHc5NjAwOE8y?=
 =?utf-8?B?L0NQaTlNeENxOGlTMm9ESUo4Wk9YMzhSczd6dE9vTlU5Ujd3eVNhdENnR25M?=
 =?utf-8?B?ZEx6YnJGUVBTWU0wUVZDNTR4SDVZQUk4dkgrVDcwUmNrRnFUY01CcmNJa0pv?=
 =?utf-8?B?Rjc3Y1BQN1NhNlh6NFJBTUNJL0RKMEdXbE9MWVlGYmNpYTdmQzlGK1pDU0gz?=
 =?utf-8?B?TnNzRk5MZUhtcjVoSTRzNzJtWVNCMXl3UFNyU2dNdkowTTB0YjZRMHpuTnFr?=
 =?utf-8?B?N1dnOTY0UVVSejZiK3Byd0Nsb0hkWnV4b09IRDJZdGszcDNvK1ZTUnVwU3ls?=
 =?utf-8?B?V1JOY1lBcHZjK0M2eWpJMC81YUNNSlB1bzRTd2xleHpNSDBVL1NSUnpEUUw0?=
 =?utf-8?B?ejlvZlgrV1VoY2JzY0hFanBRd1p4cThucUJzNHhTZHdEUVJ4WVlLa1gxNno3?=
 =?utf-8?B?V2phbjEvM2NMcUw0YTBtNWxDTlJkKzMwV1ZnSGFQYUpaNVh4MmFJakFzU2Fw?=
 =?utf-8?B?R3Y5blYyaTJRck9GcVpmMzlIVlVkb1RjYy9adzlZWDRPL0krZUJaQ0prcXpk?=
 =?utf-8?B?aUlIMGFKcUV5dVJQanA3citpczRxQ2t0VTgySDRFVzhpbFcxZks3QlJIY0Rh?=
 =?utf-8?B?S2hlZnJUWkxRb1pyL2g3SHFlQ2QybW02T2V2aUdBUXdRaHVzaXBXZ2Uxbmdx?=
 =?utf-8?B?RGhVM2NwWjZHckdGM3VzdnNaWkpGbjhVMmpxaDlieURxV0lyMURUWUsrRVdx?=
 =?utf-8?B?NllxZDgzaXorMVFPZXk3eUVoK1dJTEZTSWVRTzNzaXozNjJBUGhHdjdNSjgw?=
 =?utf-8?B?ZWRMMDh1MTkyeUJxUTRjRzVmVnNnRDVuL3Y5dStwdE9aNHpnUWxOaVNsY0ky?=
 =?utf-8?B?b1FvM25jZDVXM203dzhVTVZERUt1NExzTHJOeWZnc0FBMHpNL3RWY1FoOU5L?=
 =?utf-8?B?aTVoVVJsMWwxMkFRZklSTmVYN2pzbmg5SEhwdkVYSGN5TmdWaG5nV3Nld0p2?=
 =?utf-8?B?OHJMR0NadUExQ3JmWTNlZ1BVMC9RVUZCeU9YMzgzOE5rRTE1bjdRZGFiUkJv?=
 =?utf-8?B?S0ZYWTFza3A1czNFL2ZzYktjU2VLZXZ5MFlhMURHM0JVRlJWWkg1aUV6OElp?=
 =?utf-8?B?RGlZczJKdElwTGgycUtjR0pCL25RYXFUQ0F0dG9MVnFDM0dkbGhUUDZHb1FT?=
 =?utf-8?B?L3ZtZ1pKSzRqMDAxbml1SWdRalBlUzZVcXFKeTRwbUJMcThlaE9ERURtYXVH?=
 =?utf-8?Q?aMwzjTDFJKVe/0EdHYSKIcZib?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398bee66-0022-4b61-468f-08dc5b053b8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 15:28:41.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+lWIlFiQEvm9P0l9gISZZV9MV5916d5/+BYF1D1h6DQrz/GwzocIyMgMINntE+ThnvwNX9ifCwzeoaMJUW2Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

On 3/25/2024 11:26 PM, Tom Lendacky wrote:
> Using the RMPADJUST instruction, the VSMA attribute can only be changed
> at VMPL0. An SVSM will be present when running at VMPL1 or a lower
> privilege level.
> 
> When an SVSM is present, use the SVSM_CORE_CREATE_VCPU call or the
> SVSM_CORE_DESTROY_VCPU call to perform VMSA attribute changes. Use the
> VMPL level supplied by the SVSM within the VMSA and when starting the
> AP.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   arch/x86/include/asm/sev.h |  2 ++
>   arch/x86/kernel/sev.c      | 60 +++++++++++++++++++++++++++++++++-----
>   2 files changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 204f0a4857d6..d7be613b7372 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -229,6 +229,8 @@ struct svsm_call {
>   #define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
>   #define SVSM_CORE_REMAP_CA		0
>   #define SVSM_CORE_PVALIDATE		1
> +#define SVSM_CORE_CREATE_VCPU		2
> +#define SVSM_CORE_DELETE_VCPU		3
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   extern void __sev_es_ist_enter(struct pt_regs *regs);
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index d3e182d69d65..ea8b43a0f01b 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1016,7 +1016,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>   	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>   }
>   
> -static int snp_set_vmsa(void *va, bool vmsa)
> +static int base_snp_set_vmsa(void *va, bool vmsa)
>   {
>   	u64 attrs;
>   
> @@ -1034,6 +1034,40 @@ static int snp_set_vmsa(void *va, bool vmsa)
>   	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
>   }
>   
> +static int svsm_snp_set_vmsa(void *va, void *caa, int apic_id, bool vmsa)
> +{
> +	struct svsm_call call = {};
> +	unsigned long flags;
> +	int ret;
> +
> +	local_irq_save(flags);
> +
> +	call.caa = this_cpu_read(svsm_caa);
> +	call.rcx = __pa(va);
> +
> +	if (vmsa) {
> +		/* Protocol 0, Call ID 2 */
> +		call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
> +		call.rdx = __pa(caa);
> +		call.r8  = apic_id;
> +	} else {
> +		/* Protocol 0, Call ID 3 */
> +		call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
> +	}
> +
> +	ret = svsm_protocol(&call);
> +
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
> +static int snp_set_vmsa(void *va, void *caa, int apic_id, bool vmsa)
> +{
> +	return vmpl ? svsm_snp_set_vmsa(va, caa, apic_id, vmsa)
> +		    : base_snp_set_vmsa(va, vmsa);
> +}
> +
>   #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
>   #define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
>   #define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
> @@ -1065,11 +1099,11 @@ static void *snp_alloc_vmsa_page(void)
>   	return page_address(p + 1);
>   }
>   
> -static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
>   {
>   	int err;
>   
> -	err = snp_set_vmsa(vmsa, false);
> +	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
>   	if (err)
>   		pr_err("clear VMSA page failed (%u), leaking page\n", err);
>   	else
> @@ -1080,6 +1114,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>   {
>   	struct sev_es_save_area *cur_vmsa, *vmsa;
>   	struct ghcb_state state;
> +	struct svsm_ca *caa;
>   	unsigned long flags;
>   	struct ghcb *ghcb;
>   	u8 sipi_vector;
> @@ -1126,6 +1161,12 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>   	if (!vmsa)
>   		return -ENOMEM;
>   
> +	/*
> +	 * If an SVSM is present, then the SVSM CAA per-CPU variable will
> +	 * have a value, otherwise it will be NULL.
> +	 */
> +	caa = per_cpu(svsm_caa, cpu);
> +
>   	/* CR4 should maintain the MCE value */
>   	cr4 = native_read_cr4() & X86_CR4_MCE;
>   
> @@ -1173,11 +1214,11 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>   	 *   VMPL level
>   	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
>   	 */
> -	vmsa->vmpl		= 0;
> +	vmsa->vmpl		= vmpl;
>   	vmsa->sev_features	= sev_status >> 2;
>   
>   	/* Switch the page over to a VMSA page now that it is initialized */
> -	ret = snp_set_vmsa(vmsa, true);
> +	ret = snp_set_vmsa(vmsa, caa, apic_id, true);
>   	if (ret) {
>   		pr_err("set VMSA page failed (%u)\n", ret);
>   		free_page((unsigned long)vmsa);
> @@ -1193,7 +1234,10 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>   	vc_ghcb_invalidate(ghcb);
>   	ghcb_set_rax(ghcb, vmsa->sev_features);
>   	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
> -	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
> +	ghcb_set_sw_exit_info_1(ghcb,
> +				((u64)apic_id << 32)	|
> +				((u64)vmpl << 16)	|
> +				SVM_VMGEXIT_AP_CREATE);
>   	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
>   
>   	sev_es_wr_ghcb_msr(__pa(ghcb));
> @@ -1211,13 +1255,13 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>   
>   	/* Perform cleanup if there was an error */
>   	if (ret) {
> -		snp_cleanup_vmsa(vmsa);
> +		snp_cleanup_vmsa(vmsa, apic_id);
>   		vmsa = NULL;
>   	}
>   
>   	/* Free up any previous VMSA page */
>   	if (cur_vmsa)
> -		snp_cleanup_vmsa(cur_vmsa);
> +		snp_cleanup_vmsa(cur_vmsa, apic_id);
>   
>   	/* Record the current VMSA page */
>   	per_cpu(sev_vmsa, cpu) = vmsa;

