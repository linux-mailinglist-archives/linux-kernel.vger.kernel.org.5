Return-Path: <linux-kernel+bounces-79234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA00861F53
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6701B1C20E84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4114CAC5;
	Fri, 23 Feb 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kRdmvKYc"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14790146E81;
	Fri, 23 Feb 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708725930; cv=fail; b=s6HAMHVM655BPQ0OAD1opNPc0QTbGAF5gpDY8v1yknHNw2Q9KAAiae3Do2iuMKdChtpIs+/EtHJb4imZqhz8/ETTUm0sVLrNwfAFQ1dlPk+oVoOThvZp1rX2Nt3iqACuYkmgSyq9WnVi6g1s2GI8xeZ+qHbkJIlOZNPb0pYc1iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708725930; c=relaxed/simple;
	bh=vPdin67kTJ0ATwhiOzTm8ox772WHHRAd1loEu4opGPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DxQ/E//g7ClGPphlMUN6W4iw2EEYGwots4RGy/dYNXLmUD1ICuNmoRbl9HZKRU98nanqEE+nBmv1HSsJfhpVAWYVILjNP6nxABZAR7iLRNeKhiQyutgV+y8zXLy+W6vc25ReBKQYChU3aVy1/BZ1FANsQAw/Oe3D5l1uuPjSsA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kRdmvKYc; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUSLX4Eg+oiJTeXROyT6t2k/MIdCGFa727pxRYLnwV7UW1vo7hcdw6P76ljXU8ynfzjYfXQH6rV1o/dtaxmA4dwxRS0zfGodBg4f285mFYyZAGi6qqPILBXcD7nKJvpUlrZDYSk8w52DTJU9/NhsJQww/ErvcNL33/mRFsQBWoK0EiSP4K8IETjF8j/RHHyTFPs5vurr4iQd8BwXm1qGMT/dFJLQ4ZkLU0XDmdlbWj7bnxp1ajjDVfheg8p8bC1oMrjz7xhHZjVgzooHn3Gg+BvdtT3omLKt09JSVASXFnFo9BHHBDZwoDyS8auXGbcyaOmeoEQgpYf0+Oivef7hMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW/+oidEpqvFnKW3nj2qX3/IlYLtF7fEWWseDVCouBc=;
 b=iirQodN8Wghamt9tNiMIov/w+VgQJtC2wmnKLfhpX6ZDlEmXSFJTTULOFTeA7uwLtRQOPMa/BFz0IRzFQgrJSMwLn3U6YlVSfNzjkot5uL4tZ/SvOvVggunBTjN2LFjm3cPL8xC4x7KHkHwLhTpK2HSakDhmEUu8HElHzMaS3pIF0JEiwf7T1O4CM1cibYAaIFqokaydsojNEYiYmS9C5TVAD7+1BqZYjLXpdpOBnNomvpsE7RJzTe0a9qxB1mlh+YYv2cbl6+xiI4HozxZELivRm/GHIopmLDUreDdo17fyvBH1H6lKPP5OUTu8c5nHfYtcJQ/K+ieHBJdkMV6WPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW/+oidEpqvFnKW3nj2qX3/IlYLtF7fEWWseDVCouBc=;
 b=kRdmvKYc312lOFE+xhJpWkDtKTSlje54dNZZYRcvF1N8e7xSdLgFVGTCkPXeP/HKc6LeZ2WvKXrSOyPsolnZmA3vvmwnC852F++ivIASnQ+Y2y+9Qhz8/yGX5x2VJUMd//deZDFv/8elQsTwIyiEOP8/7Sl/OER3Skq0Dv6+8uA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 22:05:24 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 22:05:24 +0000
Message-ID: <9cec487f-ce7d-809d-b4a7-9b7a8a6c9c93@amd.com>
Date: Fri, 23 Feb 2024 16:05:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Content-Language: en-US
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
 Elena Reshetova <elena.reshetova@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Theodore Ts'o <tytso@mit.edu>
References: <5648f43d-76e4-4396-b626-411d60657c93@intel.com>
 <20240222020616.2315199-1-Jason@zx2c4.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240222020616.2315199-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:806:24::31) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 945ea2cf-d864-4ff1-4f32-08dc34bb8927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pv1gCtWyk4q3PIxnr2SG7q9fljbRShp8HjpA3I602btrfmzwbv0zkdY6+swrCldb3D+YzqXAIB2wk1XLPHKWG/y3yGTutjgsIwWW1Xtt9Hu5B8AcfPWH3hjmD+/kD4/PuhSOlG2cC2tDJ1PcO00tle9PuWZk6PdVLv2MtlF41t/TTCAMws6y/ue35LPf7MEGdeFc4JymFref9SdPRogFJObedRdkjAhTMezxde7+4j2Iy1RJUhHGuUPhuzYSGY5BrktFBg6W5bcAwf+QiZWgZFnHO8GHptg7sS7akOJTwd8abQ+UwYRfPfewIeuDkJUX/jiFkEklahUnUF4mDwyKCQtBjt/3QCgtYC3b0jSKHn0YNr+fJSq1nJDVPlvxw+DDMjSPuSNnMmiOsRSMPVysIb61Glw0rgBZcCkTANcvfT2+nsjV6cMBcNYgKahRfT3uCGpmxbC1dym7CdwpMwL2GINVdLiVr7GguDvRoaiYZXM/GLNUNf95p67LExfF1hKheaMQ6YCwO79n4/YIEEUqzFJVg0ZcbI8JBLpOtVH9gZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3Q4NStMV2NTTGlzYVRnZFFXQ1d2MDlVdFVXbytuNUl3Z3NPc2tEZmNjRlV1?=
 =?utf-8?B?SCszL0NxcFZGNG80RTdXYzNxTkloclRid0J0UUdrd1BlYmNmTTJRN2F1N2Yy?=
 =?utf-8?B?UkxhWDdtekpDdm1aNENQSzJoYVZLdHNUOTlXcU81eVN6UlF2bVMrVmxBcHdB?=
 =?utf-8?B?M2VydDRnUDQvbDdKWnJtV2U1MDBGd0JmV1pIcERKQjlaVDQ4eUg2UXVZTW1L?=
 =?utf-8?B?cDdXSFJwT3pBUEpjWkFEeXhmdmg1R3RaSVR3QWdFeWQ3b0lyVnRodjFmVG01?=
 =?utf-8?B?aVdDdEI1Qk5DZW12N3YxRDRPM1hIUmhmNW5ncHN1cVhvbW1hYlN3Sy96MTc1?=
 =?utf-8?B?a1p6QW96VGJVWDlmRkg2dEVNRWxWM1BzdWxvWm5OekZmYmoyZkZUazhSNHZX?=
 =?utf-8?B?S0lPT0tKMGNXeEcxSmpEcW5nVWQvV0dtcUtrNHJOZGlzSWR5dFlhY3IxR2NL?=
 =?utf-8?B?TUxXamlnZDRjMWpwamFnS2trZmVqeEkwNVFYL2NWaExxamRrZzVQYzNzL0Iw?=
 =?utf-8?B?cEN3elQ5R1RRQ0oyNjJFNzR0TnFMaVdzWTdDWkppYUd4YTRVQnRnRHhMajRL?=
 =?utf-8?B?c0RVR1d3VmZzeGFmSlJzem1jc29tNWEweXpJRGVIN2pBQ0ZCZDE3Q0hPQ0tV?=
 =?utf-8?B?cDhZN3hCeDJjcUM5Mkc5ZHBIOTNGOU1CZzh4Qjg5M3h4Z1VkeDkxWXFkTldm?=
 =?utf-8?B?cE1rWHY0endBR0gwZkoxV3BUcTN4dGtMaVYyaEdHd0N3bjdZSnBCc0NNTGlV?=
 =?utf-8?B?SnAxWUIrT09pZ0VENDFrRTBWcStNbjQ2UG53T2NlTkIrdGdscjRwZmgyWC9n?=
 =?utf-8?B?bmJSbWFoK3FXUVhxMjZKdEJhZWdhTis0cUdCaUt5dVRPTWl0eldKNkw3QU12?=
 =?utf-8?B?aGpQcFdFTDhBVzdzL1ZlbU9RMkx2MDNXQ21MWWlWSmw0cHp0SjQ0cXRTR2Ix?=
 =?utf-8?B?NWUwRWRvRDc5Z2I0QXgxQ1l3NVMydFBOUjcxQ1cySmJqN2d5Zm9VQ0w4Z3Rl?=
 =?utf-8?B?K2lRbk9ka2tFd2d6RlRCOVJEN1ZIRWJnUzY5dDFFTDZZZG5razFkb2E5NTYr?=
 =?utf-8?B?RVdTVzE3YU9JczJYTHNSSDV2aWo0MU16TkVWWjZGQmxxTm9RR2lnemFXN1Rx?=
 =?utf-8?B?K05GbE04NGJvc1o2ZFZQQTgzbXdVVnh2OURRWi9XdkRDSTFCaGlGcVBTK1ha?=
 =?utf-8?B?MTBjUW4wbGNGb0FoejBPR3JtdnVPd2pITGkyeU80S3RvT1VUeWMvbENkVTVs?=
 =?utf-8?B?WHFRUjJ6eEZPTVp6Q1c1dkJjTG1hR3NzbWsvcnUzMm9lZ0haY3J0MStYV1l0?=
 =?utf-8?B?SjN1M3llc0FOaUNxWHBFRVgyQkFzWStSTTFJa3hkZ1F3cDJOTElvVEpFT1Zv?=
 =?utf-8?B?MVV6YVUzMDNWNUR6UXdreEMzNS90blBaMW5vck1kRXZmWE1sQlpvU0Z3Y1lJ?=
 =?utf-8?B?UlE1UHhDc05yNzZrS29iWVJiVTRHQ3B5WGNONVBpRmtHSkhuOGt1UVRRZ0kx?=
 =?utf-8?B?Tjhjdms1SjhlWVlON25iRTdCNnVJaDNDSEdQaFRQSDZoZ1R0dC93YVJvcDF2?=
 =?utf-8?B?eHFSdE96L0pIbW1oQnhNWTkwT2pkdjAvRFc2QkZLOGVhbVhMNVRxYzlQR1lL?=
 =?utf-8?B?RW1MZ21yMWtISzZobUk0c1FPUHFkNVdOZW4rK1daTzFoTEVDYitGb0grR1FP?=
 =?utf-8?B?VUh3dTB5eTNQR0pFWWIxYkVuakVMUUtjamR6ejV5VitlZFB5NDdYWHc1Vkk4?=
 =?utf-8?B?Nno1eFlWZjR2dDRSR1p4WGtDMU5PRzQ0V1FwalRmZThEOWNJVGpEWmgwamtC?=
 =?utf-8?B?TnR6dmsyWENqbGY0b29ZOVVjZnhacTgwNHZYUGMxK1l1RUZzaEVxaHg0VVl5?=
 =?utf-8?B?RlF6Z3RLUGFXTk9NZUU1VjFZT2oyelJLMlRuNXhoUGxqUW9iMVBBWEgyTExM?=
 =?utf-8?B?SUxVaWxjb0J5T0FlT051MUlQRllLUmMzR3R3RHdRVzdFaG53Tmp4UjBXdXRp?=
 =?utf-8?B?Ly92YUNLdlZTNG5sc2Q4a1lId0lFeHR5Tlg4MjQ5RnBIaDEyeUhYTHJ6VXow?=
 =?utf-8?B?WFlmWEVFRWxaRXJtSWZpNkV1RnVWMEE3dllFN28yZVJyQXpaTW9neElseXQx?=
 =?utf-8?Q?by5XzJJZ40C+QAlW4Nsxmpz1k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945ea2cf-d864-4ff1-4f32-08dc34bb8927
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:05:24.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufhyvtMTRAofhFwn/jdG1adCYA6RLz7EDMwPxOSVgzLa3O+WdQb8Bhs1STZPj1ckq5DTcWuTenIhRk1drdUJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496

On 2/21/24 20:05, Jason A. Donenfeld wrote:
> There are few uses of CoCo that don't rely on working cryptography and
> hence a working RNG. Unfortunately, the CoCo threat model means that the
> VM host cannot be trusted and may actively work against guests to
> extract secrets or manipulate computation. Since a malicious host can
> modify or observe nearly all inputs to guests, the only remaining source
> of entropy for CoCo guests is RDRAND.
> 
> If RDRAND is broken -- due to CPU hardware fault -- the RNG as a whole
> is meant to gracefully continue on gathering entropy from other sources,
> but since there aren't other sources on CoCo, this is catastrophic.
> This is mostly a concern at boot time when initially seeding the RNG, as
> after that the consequences of a broken RDRAND are much more
> theoretical.
> 
> So, try at boot to seed the RNG using 256 bits of RDRAND output. If this
> fails, panic(). This will also trigger if the system is booted without
> RDRAND, as RDRAND is essential for a safe CoCo boot.
> 
> This patch is deliberately written to be "just a CoCo x86 driver
> feature" and not part of the RNG itself. Many device drivers and
> platforms have some desire to contribute something to the RNG, and
> add_device_randomness() is specifically meant for this purpose. Any
> driver can call this with seed data of any quality, or even garbage
> quality, and it can only possibly make the quality of the RNG better or
> have no effect, but can never make it worse. Rather than trying to
> build something into the core of the RNG, this patch interprets the
> particular CoCo issue as just a CoCo issue, and therefore separates this
> all out into driver (well, arch/platform) code.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Reviewed-by: Elena Reshetova <elena.reshetova@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v3->v4:
> - Add stable@ tag and reviewed-by lines.
> - Add comment for Dave explaining where the "32" comes from.
> 
>   arch/x86/coco/core.c        | 40 +++++++++++++++++++++++++++++++++++++
>   arch/x86/include/asm/coco.h |  2 ++
>   arch/x86/kernel/setup.c     |  2 ++
>   3 files changed, 44 insertions(+)
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index eeec9986570e..0e988bff4aec 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -3,13 +3,16 @@
>    * Confidential Computing Platform Capability checks
>    *
>    * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>    *
>    * Author: Tom Lendacky <thomas.lendacky@amd.com>
>    */
>   
>   #include <linux/export.h>
>   #include <linux/cc_platform.h>
> +#include <linux/random.h>
>   
> +#include <asm/archrandom.h>
>   #include <asm/coco.h>
>   #include <asm/processor.h>
>   
> @@ -153,3 +156,40 @@ __init void cc_set_mask(u64 mask)
>   {
>   	cc_mask = mask;
>   }
> +
> +__init void cc_random_init(void)
> +{
> +	/*
> +	 * The seed is 32 bytes (in units of longs), which is 256 bits, which
> +	 * is the security level that the RNG is targeting.
> +	 */
> +	unsigned long rng_seed[32 / sizeof(long)];
> +	size_t i, longs;
> +
> +	if (cc_vendor == CC_VENDOR_NONE)

I responded to an earlier version of this patch, adding that response here:

You probably want to use:

     if (!cc_platform_has(CC_GUEST_MEM_ENCRYPT))
         return;

Otherwise, you can hit the bare-metal case where AMD SME is active and 
then cc_vendor will not be CC_VENDOR_NONE.

Thanks,
Tom

> +		return;
> +
> +	/*
> +	 * Since the CoCo threat model includes the host, the only reliable
> +	 * source of entropy that can be neither observed nor manipulated is
> +	 * RDRAND. Usually, RDRAND failure is considered tolerable, but since
> +	 * CoCo guests have no other unobservable source of entropy, it's
> +	 * important to at least ensure the RNG gets some initial random seeds.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(rng_seed); i += longs) {
> +		longs = arch_get_random_longs(&rng_seed[i], ARRAY_SIZE(rng_seed) - i);
> +
> +		/*
> +		 * A zero return value means that the guest doesn't have RDRAND
> +		 * or the CPU is physically broken, and in both cases that
> +		 * means most crypto inside of the CoCo instance will be
> +		 * broken, defeating the purpose of CoCo in the first place. So
> +		 * just panic here because it's absolutely unsafe to continue
> +		 * executing.
> +		 */
> +		if (longs == 0)
> +			panic("RDRAND is defective.");
> +	}
> +	add_device_randomness(rng_seed, sizeof(rng_seed));
> +	memzero_explicit(rng_seed, sizeof(rng_seed));
> +}
> diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> index 76c310b19b11..e9d059449885 100644
> --- a/arch/x86/include/asm/coco.h
> +++ b/arch/x86/include/asm/coco.h
> @@ -15,6 +15,7 @@ extern enum cc_vendor cc_vendor;
>   void cc_set_mask(u64 mask);
>   u64 cc_mkenc(u64 val);
>   u64 cc_mkdec(u64 val);
> +void cc_random_init(void);
>   #else
>   #define cc_vendor (CC_VENDOR_NONE)
>   
> @@ -27,6 +28,7 @@ static inline u64 cc_mkdec(u64 val)
>   {
>   	return val;
>   }
> +static inline void cc_random_init(void) { }
>   #endif
>   
>   #endif /* _ASM_X86_COCO_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 84201071dfac..30a653cfc7d2 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -36,6 +36,7 @@
>   #include <asm/bios_ebda.h>
>   #include <asm/bugs.h>
>   #include <asm/cacheinfo.h>
> +#include <asm/coco.h>
>   #include <asm/cpu.h>
>   #include <asm/efi.h>
>   #include <asm/gart.h>
> @@ -994,6 +995,7 @@ void __init setup_arch(char **cmdline_p)
>   	 * memory size.
>   	 */
>   	mem_encrypt_setup_arch();
> +	cc_random_init();
>   
>   	efi_fake_memmap();
>   	efi_find_mirror();

