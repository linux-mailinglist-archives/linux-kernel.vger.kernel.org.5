Return-Path: <linux-kernel+bounces-143090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF498A33FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43742283366
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F78914B065;
	Fri, 12 Apr 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t9TVPmkk"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F314A639
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940103; cv=fail; b=oA/WS+q4m4pfdH71fwHPT/jqW9/bVxohChTwIj0J2zJwq9vxwInSY684Mt9YJwNgU0zYJ0LKSGifOb39gYlaSDuTb1yMRj11xzJcBhyCAYV6kVELtDNNrRwSouH4Agqr8XZMNKzkxJLgjGN7IWBWDUvbcWvlW1ylTZ8j0WQGncc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940103; c=relaxed/simple;
	bh=khwp501lEkYw69vMTX/J71LogpBNZvaXqcWXfBsOyYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tom0tvVMZwAW2Nsb9VD1b8OA73tlxqXtvTQaS8c2Ge1R12MKzHi9qAcJghbgTtsnkFCh/CgbIAq1UhSxDaSiYtj2IsGgVn1exS1sWxr0w6yHD8+tUc4qzYKlpr/OTxq2LNtdzm7BZPV68GQhy8mmMlJQ+d2OPJXt4xFG8M2SvgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t9TVPmkk; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCugSR6MtlKDDmLK4S6r6HO8SkN8IGkhE4j7uIejSQCuYKx/cteiiSS/59B6qlwZBpXRQA+RAsrnWgHXZDVRvYnL6KJ3NTDkZ6zQPO/BYzDiB+6QjSGCftoSgsW8YCW/VZpLqDKUDeqxUkaK2ZP/L2rElP03R9f+DOv3ODwGPZYXCRg86BLl32krPim5+mV2nSuiiCuSDXRKit0CyvCQLDvuU8wYDpSLqB6pwvABIrihxmfZ8zu0IDFl32qObE177tZufeeJDrbgLKA6KlONEJpiMiHD01HFjYK+0RYyktvqJBPVr85VWgWlZZpikKjLHhjqFG9dIF5wCJpUxEBSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GxZ7oEB1zgfrI8VkstbellCVYAHoGYvwF0gzkJC25c=;
 b=dgUBDpJlbLAI8JrWFYSPs52DiFWemsAZlfnF55Q5e5HO1APKVIHRRnv1dCZkphWwsljf82XWhrimTUuk2oAvmpUdU00TchCBNuXY2Rp8i5zbdTCDO94uJBoMKdFzlRywgYhNw7WWDELRbnrYAoAI7CvX6048Kv7vz+Hb6nbmc7Zgu9T+MAeTxDGBZ2ajjyLg6baoEg7zv9Oj47v0HzwzzZJIIy5cNOOtDjL8Va07t5sxGbpgVGQLWpqZnmLZomN/JHwPMNnhue7Eyg/NZu3heTYx1+O1T3p4rPT4B6axIVYnhVyy6GBhCy532P362plmOCCtSeAu/erQE5JNggmeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GxZ7oEB1zgfrI8VkstbellCVYAHoGYvwF0gzkJC25c=;
 b=t9TVPmkkJlyv7f6ZYzXN97QU0p35RflVoXQ4RYacVWkLh2kVWDn5d+r53yJCRBfWlRXwQjOatO8kDIWbohaHah80nBJH8YdAVKccMvtWsyKU5/S64omlJL88825rjxQREq+1zt+fyRi1wQnv8yYa4YfjAc73o+A0os8xb9X1Mfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 12 Apr 2024 16:41:38 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 16:41:37 +0000
Message-ID: <f0117eab-4e58-3d59-961f-f8f44a146605@amd.com>
Date: Fri, 12 Apr 2024 18:41:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 02/14] x86/sev: Make the VMPL0 checking function more
 generic
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
 <1b0d8ec8e671ad957a2ad888725ce24edeedf74a.1711405593.git.thomas.lendacky@amd.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <1b0d8ec8e671ad957a2ad888725ce24edeedf74a.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0430.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::20) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 5701cc38-0391-4e7e-6ac1-08dc5b0f6c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	67+88tm7yBrF5XZxBsNGPbKXleAqA0NYxeERe5dfsoYuXI4lopbivM3A2eSbuqZlRmwKTtZfNitm3zR6+dX8TK4uCiOJFDmozQGMFdEyUyYYDfZCt29nNpkOCRyKDIAlr7rNbhMYeGl+rkMcCfdKjTyWEmHePQFrgXd2byVmSYEvuJKjdnq0PStLaOoOJuSqLWEDVcUfmoSPgFrP2Q2cjCOPBikdQ4kpH+DMbvhdikkYcDTXMi3tDLZcpOzsTM8nnrVYwk19Kp900z7/OiI6jS7Ol3pJMbsJl6p/a5AFwEtVSlcqE6KsjGVINyIX9uAg/BAR037+H3mIkRRnhnD2j6V1BlSbUoJkT17ksKRlIlzNxfZ6v82k0oGaXwfPl46PYETextsAJMc4DO+BHlqN25f6pdzpGeyf7DLW9yvS9GRRq/L1zfEuaubwuG5fdMn8i1MTN/HFJiERvaOwfhkZnFAtl68uCZAv3nkYA0kNT9BEYSBml/L97GFlhnE+lCeMgYBjhW+gklhC7NOk8vmbmJ/uoisp+Ty2IA0pXYAmzF9OJVdXwNLgor3TGFTZiU7Rf8ri5yXofYMjvzqAxPR2+f35Rmu1cXrTH6mdAEy1L/+Mt2ILI4cVTWUVMDye415O1MCYUq34Dnlht5Z8pST6De+Q9nYvsHv6DIuRnmj36gU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDhDUDFuOFdhYTZ6YzY0YjU5ekg5bzNhREtnWEtKY3ZoNmxkK0cyNm5DR0tE?=
 =?utf-8?B?cUswSW1BL0dEdS9xYTVhemN2clVNS2lERDFEUUVSL1B2Y3E1QVM2aEFxKzJW?=
 =?utf-8?B?QWhFdkpJb0FIbS9md0s4Qlp6b3ZxMVZGMlBGbE5pTzJlTXdYOTdzUWMzVGxS?=
 =?utf-8?B?SW9MV1BKSnRmWGtXczRGZ3ZYYVRYTkQzRzlwU1RINGFQZXg1MFNmeExQKytj?=
 =?utf-8?B?Q0dQNmRkTVZ0RlRPaGhRdmk1cXBXQ0NqYlQ4YTVKVVhtd3pCZ1FWWkxuS0sx?=
 =?utf-8?B?UXI0TjhFaG9MTDY5N0VNQlNwL1ZFMUY2a0piUGZMSndRalhzTWRiNUdjUHFi?=
 =?utf-8?B?MTFCdjMzQk02UHJRL2s3SGtqc3NTSk9LakZmbStaWEU2RlVYNUlSbEZDKzB1?=
 =?utf-8?B?YTlyVldwb21UL1djTXdML2hRZGlwRGVuUloxVDVDVVptd3N3NnlPcFBqS2Fr?=
 =?utf-8?B?MDBkeTR3cEZIS3NCMldybGVIeTlJc1BXMWNsL1lUT3NMZTZYTjVZYUFzTFA1?=
 =?utf-8?B?aXNmUE1OK3JvczI1VkgyLzFKZkJNVE9HTGh2QStFajhaZXNpNUNHYjhjM2Jt?=
 =?utf-8?B?OTNpY3FEVjJWZnNydXBzSVN1VE93VlNxdThscmJZc2FFSnlNOGszSGFmVUZt?=
 =?utf-8?B?Q0pEaEswaU5VRGhmQVFOWnBnalRWVjNDNTBpRUhnczZMOGIwZ1hITGxGNUVO?=
 =?utf-8?B?Mk1Xdyt3b2U5YmRJU1hjSTd3QlRIN3VhN0tyWkFoeml0NkF0L3ZMQWlkRUsy?=
 =?utf-8?B?YWxoYmhKandUT25MbE5rUjlTRHNJdjltM0phQitIVkc3c1B3dG1Hc2dkN0ta?=
 =?utf-8?B?WHdXS0FQRUZjd3Nqcm1BVjJTeU15MEFob1JaQnVteVdwc0tTeVczNjdXSlFh?=
 =?utf-8?B?bzZNTXRKVDYrODIxdG9TRThwQzMyaDI4M2pLNHc4YWMxUGpNSXVxUDFjeW5E?=
 =?utf-8?B?SmJTWUVYWUJBVHVhK1V2WHdUYUZiZFYzV0paR0toeEZlZENkcWFKbnZRVFdl?=
 =?utf-8?B?VjR4c0lEcmN0TG05YWlDUjUyTytXaGpNNndTMGpxWVRuUjdzTGtJNXpmQU0y?=
 =?utf-8?B?ZnNNZzhEOVhuNmtOaWlPZFd5R2k4M1FhR1V0dHdRdVF1MWtDcjhNRk5mUGNR?=
 =?utf-8?B?TUxzSEhTOVpjRlg5RXZEa2ViRFZvcWNZWjNMNFUyaXRLYVhKWjlsa2tOSzZM?=
 =?utf-8?B?Q2JxMGlIVFA0Q0h1R0x3aTdhS0FxU0NtSmdRc1Z5cFdwWUdOZ2w4S0VnK2lw?=
 =?utf-8?B?OGZibVE3dXhGRzZqSnQ2MWx1U0owVTFHOW4zUXhwN3pUb2NqQTczb01vekhK?=
 =?utf-8?B?aW1uTGFoek1HVUZHdmVGbENtSk91RUxSbVBuQVQzTEsyWlc3K2tJaE0wRWZT?=
 =?utf-8?B?bDhUYnBoWXlwTExqaWFvYnpUbE9YN2lHVnd1clp1UlQxeWNKUUpoWGFCWHlW?=
 =?utf-8?B?eEQ4ZHN0WHhRNCtyYktwSUVCNWF1QWdFajBGSFVSbUQzNlZ1U0VSdTNIODhX?=
 =?utf-8?B?RG9UekZKbDh4Y29jVXRUMWgzeXdlWWZJdzJTWkVNUy83OXlndVlYVTZkRG8r?=
 =?utf-8?B?cVJNb21xWDNmVHpFTVRFWnRkL203blFZWi8ySzlVcWxQeHlmWUs0TjluVUsv?=
 =?utf-8?B?aHA5cEdMWVNVOUhScHR6aXFEcDRmZ3I0RzdxUVhuTVZMM1FTWHFLdDIwOGVt?=
 =?utf-8?B?K2o0bnlkQXdaZ1pIYUJlMUJwSmxzSXFCUVIvSnUzbWNSWjEyQXJ1akN5OUk1?=
 =?utf-8?B?V0JHQkRQYlU3eitaN05UT3JJbE14dEw0Yjk3dEpHVG9ZYm5yS0V1VkkyR3Ew?=
 =?utf-8?B?Y05rSUZxT1VXWTluSFh1eUNrTzNWUjBNRDF5TjhLSXF0Wk5lbWZQeWdUVEpK?=
 =?utf-8?B?aUx0bTNVenZPN0s5R1ZKSyt2aGJZVWR3QUdPWVN6ZE9IMCtuaVZaMzJvSzlN?=
 =?utf-8?B?MURDWXNLa0Q3dVlOd3BSY0czdTMrNmk2OGJBZkEzWmRYeExQRjAxRDk0Z1cz?=
 =?utf-8?B?UkgyaFF5SlpJZnZya2pOcFNBV2ZLSEpRQ3B3YWtacFliVHpTQU9iUjVKR01V?=
 =?utf-8?B?dVBJNjQ1TzlwU0d4VWo3eWc5dTlQT041aktoRWZRTXBXVHRyTGxMYlEvYXdT?=
 =?utf-8?Q?fPqmmrOKMQOZxXqtDL9Fsye2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5701cc38-0391-4e7e-6ac1-08dc5b0f6c13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 16:41:37.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zvdsC56l8YWpGxvU4aheAdtFgFASlXzkWx9lIGHPqbfbmz4wtvHWvFzxSaoiMz3WEKuxV4CUvUgPe5z7mUNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580

On 3/25/2024 11:26 PM, Tom Lendacky wrote:
> Currently, the enforce_vmpl0() function uses a set argument when testing
> for VMPL0 and terminates the guest if the guest is not running at VMPL0.
> 
> Make the function more generic by moving it into the common code, renaming
> it, allowing it to take an argument for use in the VMPL0 check (RMPADJUST
> instruction) and return the result of the check, allowing the caller to
> determine the action taken based on the result.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

This is preparatory patch for patch3.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   arch/x86/boot/compressed/sev.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 5ad0ff4664f1..49dc9661176d 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -335,10 +335,9 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>   		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
>   }
>   
> -static void enforce_vmpl0(void)
> +static bool running_at_vmpl0(void *va)
>   {
>   	u64 attrs;
> -	int err;
>   
>   	/*
>   	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
> @@ -347,12 +346,11 @@ static void enforce_vmpl0(void)
>   	 *
>   	 * If the guest is running at VMPL0, it will succeed. Even if that operation
>   	 * modifies permission bits, it is still ok to do so currently because Linux
> -	 * SNP guests are supported only on VMPL0 so VMPL1 or higher permission masks
> -	 * changing is a don't-care.
> +	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
> +	 * permission mask changes are a don't-care.
>   	 */
>   	attrs = 1;
> -	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
> -		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
> +	return !rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
>   }
>   
>   /*
> @@ -588,7 +586,8 @@ void sev_enable(struct boot_params *bp)
>   		if (!(get_hv_features() & GHCB_HV_FT_SNP))
>   			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>   
> -		enforce_vmpl0();
> +		if (!running_at_vmpl0(&boot_ghcb_page))
> +			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
>   	}
>   
>   	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))


