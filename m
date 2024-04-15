Return-Path: <linux-kernel+bounces-145526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812488A576B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D994028701C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764185289;
	Mon, 15 Apr 2024 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uOYtQVf4"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E680623
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197614; cv=fail; b=bK0vn3zyAjQVxE8RX+4KoKnc4TlG1E8goadSDwh71ak5fg8qEmmiDZ3bL2sBqvD0fIISRHnVll56DaDETMOSJUSm6IP4SXApMcwUV2KQIUi5B5X+QuIv44SFerf4klcgxNRS2sSmj2Ma7GJudA8gbx/9ZpFCpyy9mZtdRFZCiig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197614; c=relaxed/simple;
	bh=lPMqZnSkXLyGXXlv5YWZbgStEfY+WWNDqyNK6aE+jPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qv5mexTbRXVEKyKS10g8sBQcE+BBKbwib0DpJU5XMvT9qZckIIi7Gvb02DhxcAhUZ6YjHmJ9Gs96BKWVS4r5OG2p8x/7a61xYVT1gSwOIVJlL0PzxxOnEgABpFybk+6pFJgQ6UT/s+FWm8PsaD71cRLRZ6TuPVrg45zx9CA7/zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uOYtQVf4; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8vTV0gQNgRih0AJSDxjztqw0BXj3ZYW4EpT9zyh/rzeoktSs6NZor4ERfWqJuhxKJQcV8IUrs6vwEVPrsODjC84r0TYY6h10ZTzpKHH8RbN463ayvhBXLAsJPpjieq1GYwg20N4prQuh2RMm0M2Jz40iOdGzWib0etpDg904AlZ2ek1WCNTRuW/Og8yyuR35B5+/U9QFUM6nIwgdx3UU7BMQUttz/J2xUU6iGz5Gp2TqqjGh99jW+DSstTLzqz/v9uws/AeXUHQUVJxb51Ft+D3/0Puiw1mDWe94fTBk2vreB6UxXwgYxARrIuIsADNJCn+RMvxrI/u9heS8b+hXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEoVM24Md+GnoHGBd5Y80is/GDfuJaMzUALqiF0RXM4=;
 b=jmrBMymZqnraEqhgE8JCcVuFTZP5ot06NHcJWJIu9mE1kQ60FJe1sxHvC19PklzOKvF4NeSOPS18T2q63yuQ68ssL3c0JgxDzKGSpIYnELmqtiHrTRAz/t8B2BnIzKQlV9CY5j/cdP5QF+zBUJ7HFlbPvteJW1u7UB6NwVCMTkk2PyiR/IbO01CjOlCqr2b9VXAa7FcU7PMm4Ig/rTZm3cpV0gSSQQajhSfJbFa3Fxsor1P0KWcwSTJZrQLzl9tYKhfBk7HW/xbzXVCf7KcyN9sNRyiWE7g72Kob8zu/TWK7hYFpE0syACr77dxsTNHH0DD6zriASTTjkOvaGEzUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEoVM24Md+GnoHGBd5Y80is/GDfuJaMzUALqiF0RXM4=;
 b=uOYtQVf4qO6QKmjXCo+OnQAO9XprAePh1pGMAlpw1G7GbqOQi19hzbIiyTTACkSswl01dk7FVZ638nopE25Rskeeld2MNd3LtiioBgRKGcJW04Y80Jz4H3TR2EojOtVJaCslXZn6USA0wQkf8yrj1XpMyMBePilPCnwVd9zVzW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Mon, 15 Apr 2024 16:13:29 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3%7]) with mapi id 15.20.7409.053; Mon, 15 Apr 2024
 16:13:29 +0000
Message-ID: <df3cd8a6-8e9e-2403-9995-267cd05b0fda@amd.com>
Date: Mon, 15 Apr 2024 18:12:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 07/14] x86/sev: Provide SVSM discovery support
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
 <6468ce125086997ffb043238d12a347f77c7a3fa.1711405593.git.thomas.lendacky@amd.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <6468ce125086997ffb043238d12a347f77c7a3fa.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0094.eurprd04.prod.outlook.com
 (2603:10a6:803:64::29) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4ae96c-be8f-4d9c-993a-08dc5d66fccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cw8QzSU+yE00hzBq6hsmHWqdfmqjYv4P81Uhj3/WzjCTLB9Tf+MFyVBFmvNNMBo5DQJGD2/r5QqZImVXyR1QeAyPfy7+pdsTC82DZvVZkkGLIVssTLPYI7ePTjWwyM/irhIFXWBYDnUfshXiX6gZi2MchwQ+0apu6DILbROD3p+o4zQa9QZkLf0uTM+lsUpxl0ShO7PTaCb21Okm2d+p0PZsv9k6YUj7cyjE3zTUTU8WvXTh7ODjc9TjFP/vXuKTKNaet3IS4SdpAUF7rPAHZGLaUQTjqMGwszfIpxM8+FHj/KemvQpcrnO8hRN5zWxc1bettEx0gshMJlBcWbu+SOxQiIk9V53yY2aXQp9WH4Sszb1LzMaE7/Z5Lg1vI/cfvMfQOvVoq5Gg0LQmJrlDMlBhSQiNQ/lldEq3GeK3sCssbw92gn2Roo+xb89KbQUNftf2XF+IqfZszU1CeuaSlX8grrcusSBFCLjzJyM5Bh3ulLGfv1CSsJuS8+9wTldFjrqWJ5eXvU+cQHkZOhh894ko1eGIL3XZB+bYUM8Mf0TslPmbLBVN6SuoU4+dB9bOP4wMShJAIS4K5p9u1WH6doPucQg1eVnwerq30B3XdZH0x64tY4FSgoTZwgs0+7KwPE2pmmuQkHSzvi2NzLjqg+Va5eqRcvCD/K8w4WWMeXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qi9jd1ZuMXlseDYvbU95YXRLU1BuOVVYN28xS1U2SGVVaGZibGU1OU1xcFdW?=
 =?utf-8?B?bkFnV2VUMUUyR0Nuc21iUGt4dElscjJGczVlZUorQWtBNGVpMUo2dkh2Vktx?=
 =?utf-8?B?MjgyVmVvSWFYVThnOG9aY0VkTHpiYlNtZHludnNpQndxSjB3SGEwZVNpNlFn?=
 =?utf-8?B?UnlGemRHc2R4Z08vSElJVVd3NVdsMHFaS2g3NXVqOWpTNXpLRENWc0ZHWloz?=
 =?utf-8?B?czBFZ0JsdmtEeXZPejR5a1VMQ3NOVVpQSUZ3SXdFdy90anhZTzU0RTMvOE0z?=
 =?utf-8?B?dy9GT09vVCtzOFNNRjdsUUcvamtmQW9UOG05SWEwR20xaVd0RWE0WTJCeE1o?=
 =?utf-8?B?NmFCQjRDMGI0RVpibXBPNHI4K0d2ZHRJWFdSWXQ2UTI3STZxZkhSenA0WU1G?=
 =?utf-8?B?UGtIZDF0VUdlN3E2cDluWWI3UVlNK0NrLyt6OStSOUU0UW1Vcmg1Vm1seTRu?=
 =?utf-8?B?RGlKS20ySklwMjF2aTJ4MHRNRm9nRUJKeUtYUnRnSGxMZmxnWS8rZjZYVkhu?=
 =?utf-8?B?MmdNMWx6VFlKZEdUZmNUYzRsTTJaa2JERjVPNmlnTDhmK3FXUHJINVBxQVEx?=
 =?utf-8?B?WHZTVDJadk14cFdTbmFZN1JPVEIzVlZDNVVGUmVqQnRXOEwvTVhqK2xic3Fk?=
 =?utf-8?B?ODdtZmY5dEdMQzA1ZjdXaVVkcGEyenc5ejZnSHlpaEFUSFRZNjcrajRjb3Vn?=
 =?utf-8?B?WGpubThoRER6dllMK283eUlKQk44a0hNT3g1dVgzdmNBanFNY0F6djU0MHg3?=
 =?utf-8?B?eTZINjlvRUlEeTJtVWcxMnFSYWxjdS9JR0RUSnRRS1lkR29LbHh5MDNabVU2?=
 =?utf-8?B?S211TU1MQkRhaE9Wd3pBQnIrdmFUa2xoYW41dGZsMTBhazNaTGFBWEdqWHVu?=
 =?utf-8?B?bmdvRmhMVm1POWd4NjhNVmgwWFZmQ2NpQzZ3SmpaZGdGd1RVZTdlekpWR05M?=
 =?utf-8?B?WkFFRG13cEZzalFvRWM3YTdNclBHNjdadjBPQjl1Y0tmTDArd0dUbm4vdlVy?=
 =?utf-8?B?U0YyYSt6bjA4RzFpSXA0dlFHY1dMUVhWcGZJOWlmMG1OMTQ5eEFmcDRTUnh0?=
 =?utf-8?B?akQ3clVGL2p0a21ON0sveCtvdHpGVzYyN211VDRQY3QzOE5xcjB2aVZlTlFs?=
 =?utf-8?B?UHpQSEdxYm5ab3p6cXdFRC85M1JCWlcvaFdLRE94V3RBRU1RWlJJcnArcEQx?=
 =?utf-8?B?eXp5dTV3NDRRL241QWExdUtNc2dNSFM2eVBiNTF1MXdXNW10bElOMzMyWmpu?=
 =?utf-8?B?Zzcycm9Fd3NsRnhiS245cTN2QnBTMkZYUmtUblNZYmNlNHJCSW9GZ3ZJTUFN?=
 =?utf-8?B?ZmNUamdTYTBaeU94aUlPVjRPdThoSHljYUxjQ3RiVFlQbzNTRVB3aUhDaktJ?=
 =?utf-8?B?RTlMSncyMytDdVZ2MlNwM1ppMUo3Uzd2T2RyT0prZUNmMFlKYU5HUG5Ka1Yw?=
 =?utf-8?B?bmgraXM1SlRiNUd5Rkpka2o3YTkzd1dOTW9oM0tJSmFwVjV4VC9kQVVlU3Z2?=
 =?utf-8?B?bWtrR2MzTldSenlQTjZCUVAwWU9nVFdySUh2YTkwSVRTVlpKZ0EwNWs2bVVO?=
 =?utf-8?B?UUliTkJvVDhxSm1Nb0J0bCtkd0gyWlEyTGRqSW5pR2MvUk5nZ0k5SXRLRUI4?=
 =?utf-8?B?aHVXMlFwTTYxeXlJWWxhSXJ5U3ZSWGxyWnhXSC84VWdpbFYxZzl3aGkvVlZI?=
 =?utf-8?B?c1U0d2JHbEt1TGlhTGszRmErQnhxQko3RDhpVmZYaDUxTFdEZ294MHZLUnp5?=
 =?utf-8?B?S3daQXFhbFlRVE10RmwwVjdnRWdVU3NDZ09La3BnbHJ6UzREb2dLRlY1eG1F?=
 =?utf-8?B?TmdidFpNRk0zandaQi9BTlJJNUtjTFFOd0xIMFIxQWhXMFdmYzVESDZiRG9v?=
 =?utf-8?B?enRuTFVzQldnYjhXay85WUZFQlVISkJHZnBFaFhzdThmRUxvUWc0VEY5Umw5?=
 =?utf-8?B?a3JDOWpaSDlFL0FuczlqQWIvcFNSa01NeVdNeXc2ajVYdzFRYmZVZ0dZT0xh?=
 =?utf-8?B?eVRvMjdaSWMwNXRGQlRpa1NQdVp2cWZ3NG5oeG8yanU2SkM1SHhaZEZYSHor?=
 =?utf-8?B?cFY3UzhoSzhiSURJbC9FTDR2ZkZ4cEI4b1VJbm1zbU5XQW94ZkVaeW5JVExl?=
 =?utf-8?Q?cvyVHbtBai8dgiiNAowEGIxHH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4ae96c-be8f-4d9c-993a-08dc5d66fccf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 16:13:29.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZEyy5TmpsbenLA4rR3xqwDGuD4yWh9LUWENTtNYhWLPjBiTwSagAXnfmL7jRLYcSZ2vh7i1N907cdDrC27OxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670

On 3/25/2024 11:26 PM, Tom Lendacky wrote:
> The SVSM specification documents an alternative method of discovery for
> the SVSM using a reserved CPUID bit and a reserved MSR.
> 
> For the CPUID support, the SNP CPUID table is updated to set bit 28 of
> the EAX register of the 0x8000001f leaf when an SVSM is present. This bit
> has been reserved for use in this capacity.
> 
> For the MSR support, a new reserved MSR 0xc001f000 has been defined. A #VC
> should be generated when accessing this MSR. The #VC handler is expected
> to ignore writes to this MSR and return the physical calling area address
> (CAA) on reads of this MSR.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   arch/x86/include/asm/cpufeatures.h |  1 +
>   arch/x86/include/asm/msr-index.h   |  2 ++
>   arch/x86/kernel/sev-shared.c       | 11 +++++++++++
>   arch/x86/kernel/sev.c              | 17 +++++++++++++++++
>   4 files changed, 31 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index a38f8f9ba657..51e7c879f057 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -446,6 +446,7 @@
>   #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
>   #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
>   #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* AMD SEV-ES full debug state swap support */
> +#define X86_FEATURE_SVSM_PRESENT	(19*32+28) /* "" SNP SVSM is present */
>   
>   /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
>   #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 05956bd8bacf..cc4de3379265 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -654,6 +654,8 @@
>   #define MSR_AMD64_RMP_BASE		0xc0010132
>   #define MSR_AMD64_RMP_END		0xc0010133
>   
> +#define MSR_SVSM_CAA			0xc001f000
> +
>   /* AMD Collaborative Processor Performance Control MSRs */
>   #define MSR_AMD_CPPC_CAP1		0xc00102b0
>   #define MSR_AMD_CPPC_ENABLE		0xc00102b1
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index e63c0a6eccd6..17eb42c4ae71 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -1559,6 +1559,8 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
>   static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
>   {
>   	struct snp_secrets_page_layout *secrets_page;
> +	struct snp_cpuid_table *cpuid_table;
> +	unsigned int i;
>   	u64 caa;
>   
>   	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
> @@ -1596,4 +1598,13 @@ static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
>   	 */
>   	boot_svsm_caa = (struct svsm_ca *)caa;
>   	boot_svsm_caa_pa = caa;
> +
> +	/* Advertise the SVSM presence via CPUID. */
> +	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
> +	for (i = 0; i < cpuid_table->count; i++) {
> +		struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
> +
> +		if (fn->eax_in == 0x8000001f)
> +			fn->eax |= BIT(28);
> +	}
>   }
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index ea8b43a0f01b..7f399ea87a3c 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1347,12 +1347,29 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
>   	return 0;
>   }
>   
> +static enum es_result vc_handle_svsm_caa_msr(struct es_em_ctxt *ctxt)
> +{
> +	struct pt_regs *regs = ctxt->regs;
> +
> +	/* Writes to the SVSM CAA msr are ignored */
> +	if (ctxt->insn.opcode.bytes[1] == 0x30)
> +		return ES_OK;
> +
> +	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
> +	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
> +
> +	return ES_OK;
> +}
> +
>   static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>   {
>   	struct pt_regs *regs = ctxt->regs;
>   	enum es_result ret;
>   	u64 exit_info_1;
>   
> +	if (regs->cx == MSR_SVSM_CAA)
> +		return vc_handle_svsm_caa_msr(ctxt);
> +
>   	/* Is it a WRMSR? */
>   	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
>   


