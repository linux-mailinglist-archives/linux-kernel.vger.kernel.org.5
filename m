Return-Path: <linux-kernel+bounces-59752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6E84FB46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DA8284BE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161D37EF09;
	Fri,  9 Feb 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MuGV5Rbv"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD67EF06
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501107; cv=fail; b=LoCn/X5vgZvYzUil/j2CiBvks6c6XqoYTU7W7+YIBhFp6LIgExLnh2UNu/s80++VLSwX6ZZYf/ISKLuOiTWuInHR6x3VXd9upZWTfIc2tOXsXGf4vkupqMNjOAuLtLy6ha2FqUZ7IEdfCcFtL5aoTcwVVph+OHEL3YdRbT5MTZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501107; c=relaxed/simple;
	bh=f7V47JgTSl+0YU+ZLnIkYDqthlACCWtxy1J1s28V0DE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/5d4r5uSbqpQq7Ftl9zHHd0z8OVxfw0Yz6EaRkTLtWdwqQ8xL/C+23WzzgKCC/vqld/d/Dpr+jrRWZFXEIzEDYgRPgej3+lgavRuOLJ+CvXVFgchgQVqyNt92UV0TlXDGrZqp137p4HSTkq15vu2xFVUH2396IVAdprr/RpriE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MuGV5Rbv; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWv++JbwbjKQUg9JOvGVtQgRpmdW17zB8YX1CT3VL0hDRrDfoBePSOFPsFZcbZB5h9vL3rPxTafNMzi2FNrfy2wvMpCscggyoMI1t5NXsyxs3JWDTi2R44SDjOBsMhPhfI/2xejuHokvlU3B4qYedqBFZ3kgNSA522kRLYJa7N7S/FCy6/b+VdJvRxCgyLl0/V/+bG5eJT/Fi33aTS2CfUIbFyjIkHsoqrvVMBJ1f0fIOjpXsoFfuRf/HJdZ5CyUZAApUCkmaFq2Q3OPAHY6p+rrFki9tEWnQ4QcJ1hkPh36VCihSv0euqi5j//pLRhjgL/6JabzYEI/BStYh4T3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuNJ8aK48GjL0ddxA+KWQrNrtDnSWSaBGrXRTBj8TaI=;
 b=QRrQKQaK6nhhMX2l/ePoCcX/Q5b6BeReLGHLwDYUb/yYB9SiPrMAMdlFGoSM6vogAw+tWuvG077QxD5nI+kqZDIOoNJcPyRxQ3+/uyvYWKsuAYmeAVRTd/y2CfArEDn1SdqHvvuFgWvjW9CKOOp2gFXZ5LEMOh/aqq8vqTf6xPCrrqGUkZNGlg/fDzbNTVFu8vO1M3cCJ/IGztO4HN97gBMduo4qec5/giFXpXR07CnxlF5X7jfGkUkFoQBbTOjy1gd5h+9kIVESsp/N6t1bE7hs1+IADmE8bcwPWcQiZA3t+lHL0qEkpJlx8EplDAlH29WdKbO/6XQ5var9zJypIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuNJ8aK48GjL0ddxA+KWQrNrtDnSWSaBGrXRTBj8TaI=;
 b=MuGV5RbvQKg9YKbBclJF4N4GVyB+GhsT41pqbAIl0qiI0iLshCpctg/kDzhOUP6+Y2jqKXImc1iLzC4Ht7EF0G6UVvU6PZJMWsoeV0ohw9et1ZcS4js159C9FhOPrVTb9gvTovhR8QdPqyCqoHuIxmeC4yxwHEyvMzDoFwWvTVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Fri, 9 Feb
 2024 17:51:40 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::f44f:4aa:d49e:d055]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::f44f:4aa:d49e:d055%7]) with mapi id 15.20.7292.010; Fri, 9 Feb 2024
 17:51:39 +0000
Message-ID: <5e4670e5-acc8-adf3-2a3d-eb02db7ed990@amd.com>
Date: Fri, 9 Feb 2024 11:51:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] crypto: ccp - Have it depend on AMD_IOMMU
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240207204721.6189-1-bp@alien8.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240207204721.6189-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0036.namprd05.prod.outlook.com
 (2603:10b6:803:40::49) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f4fc7b-2bc6-4505-34ba-08dc2997c4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rg4y7zLWAKhnDYKl2v5vrWuIKwEXS/0tcaExJChGIsHqOke/yVtazxwwpLrhTMivqGbaXd7FDirZc11qqMcHWnGzgBf7xXnhfBEjJ9pejGYcSlUGqRP+4sX+SxGjeDUDjzLyv2s4C2Wcv6FmxHTwuBWLRW5nkrLHUvAf8R9xAoq4ukCU/de1+A6LkIoXmz6u2/p16SltwLqDby1IkFYgwIxv7mKh+xNI5KXvgC0APlTNaW9KkzFh0eVePOuK/LybRrcUcfyXrS1KOyT4Zj1BPA8MG4fdeaMgRXU6dDAvFFSJhZHQboO/JlmQSLO70lap1WfLQyztKleX21SGeCQx0/M2tD85vA8V/DXoofph3ADwWV1hx3aoydK8daHSvs5twnitevvdy8bERkCqe/Zzo2O0eyJKIEQQfbMJw6tXf6sw6M/PxvrkLUhe8PD0b9N3/gIgfMiXyd0uL20qwr9mSlsUEKE480/wkl6/KtwpepHPJYayAHwolaw+bevdN6dlSmHi87VYgGzQRZHf5NLNHFTGmdqUsUhmknKIeMorSOGv3Odlt5wTNUl97yU0O/Cp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2616005)(26005)(31686004)(41300700001)(66476007)(6512007)(66946007)(4326008)(53546011)(36756003)(66556008)(83380400001)(6506007)(6486002)(110136005)(478600001)(316002)(38100700002)(6636002)(5660300002)(2906002)(86362001)(8676002)(31696002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVYrSGVjRTRxa3N0akJhNGVjYnVWbi85N2E5djVWczNCU1lwWWhNN3JNTDBL?=
 =?utf-8?B?ZytIUnBTY2ZlU0kzNmZOSGhkcTlJb1hienVkODBndTZ5OCtHUENrNlZ6cGZM?=
 =?utf-8?B?RGVOVHJ2UEFhMTBhQnJ3eUEwazRXMG41K1J1Uld6SUNxTnBoeFMxaENqKy9a?=
 =?utf-8?B?cjZJNHlHWnRJWnRNdTNJVUxaNSttZzYyZjlDM0lPQ0N2cGVNMVd5dEFNNVdO?=
 =?utf-8?B?R0daWUY1eC9SK01tQVp5NnQ3UFVRWDV1VlAySWtYVkxQTXF0SCtseEpqTzBl?=
 =?utf-8?B?czhXRnQ4d1RZRHp4T3dtN054U1lOTDQ0TWVLTE92aFE2Y1hqMlNzdC9GWkFU?=
 =?utf-8?B?OGgzeGhqZ29veGFSaUo3NEVvcUNqSDI0SE8xQU1ET0NnYWc4MXhhWGNmMWFI?=
 =?utf-8?B?a2hKdTlWNzBLbmtpeDA1d1ZxbkJkNVhtTFBLSlhVaVI0NDFKRWdxZ2JIZ2VI?=
 =?utf-8?B?KzZjUThWL0JDZThhUXU0cUs3Rzk4M1UzMC91RmRoeDJtbzNCSjRySFNRVGJh?=
 =?utf-8?B?VGlUemU0aFFaQUZGYzRwOTNnUnFueWErMXBKbmhabmFpS2tGUDl4d3BEWW42?=
 =?utf-8?B?QXNBQXF5MHN6d2V6OWd3YVREQUR0S24rcytQMHlHUHhNQ0s4TFFtWThqcjRt?=
 =?utf-8?B?Q2U5bzE1RjVJSm1lTDFWNTJMZnZVYjB4VU56aXFXWUVoWXI4QmVsNENKZ2h5?=
 =?utf-8?B?Q2NGR0RRQ0g5U3ZUL3hCS2Nka3dQd2gvVnNxY3NQVW90N21iTWI4QzFhK3B1?=
 =?utf-8?B?SUFMQVBzN0l2SHhwNUp0QVBCWklqTkVOc0pxMi84dEo5UklNaUp6eEUxQ09q?=
 =?utf-8?B?dGhCbWJ2YXo2c2oxMUlNeW9XOFJzNC9sUzE1Y3IzdjkxWHNOZFpNKzV0OWpm?=
 =?utf-8?B?VEFpUWpxOVRta1VPTCtrMUlWU2RSdWdXNGttajd2VUNURDROTEE5STNxVkRT?=
 =?utf-8?B?MC9KSEVuU2luU1BHYjdrajJoQ1VMRTNOQXBvbTNiTGRXV2NrR0MzMG1yK0Ur?=
 =?utf-8?B?c0JNRlFrNk0xeERuWTNkYjBCS2Y0b2RvUWVMTElpSFRwREJzMWtyUDRvN2x5?=
 =?utf-8?B?TDN1UVc5MVVvWjg4a0hGYXdqSTIzay9yUm1pRnc0VS8xdzdjM0ZiOTEza0xz?=
 =?utf-8?B?cnkzUCs2RzJTSUhtcDZXVmF3UEJMK0JrK24vbmF3cHBPU2ZNOUdDVTh5eTlX?=
 =?utf-8?B?MHMxUWRrd2RqVi9PTWpCVHVmZHVCZi9UMVFsOFM5UWdHcWtBaTR3c3gvamVh?=
 =?utf-8?B?SDFQbXhuOURYK1M4ekZMaTZUakduQ21FS0N6dEExQzJ6ZmRDd3IrQWU1ajlJ?=
 =?utf-8?B?WUowRi9UajFZdFU5U1BDa0ZBMzUzZThWRHVIU0tMMUFZYTdCL1JPeHh3eUpD?=
 =?utf-8?B?b1A0cDRWQkNpWG9iWWJRM0RKSmdDQnRPU1QvSi9aa1VHMmxPUUN6VHpFZVBv?=
 =?utf-8?B?blJwbmJEdm4zbVByblo2dVNoaVhTcWN5UDVubHlTM3lXM3IvQXNJM21INFVk?=
 =?utf-8?B?SjlsVWphOC9sRzNBaDgwRlF0U1d3OTVFUXBCak5iU2VtVXd4TzA2VExyb1E4?=
 =?utf-8?B?WHZ0THV3MStXWGplYTRLbEg1elN4YXJhU3puVFZPL2o0bjc0TCs5Q1M4b1JG?=
 =?utf-8?B?N3E0cG1KSktLdW9uVHgxbk14MTFKZmZwZllNWnFnLzFpT3JRb1hYRHZzdnVw?=
 =?utf-8?B?Y0IzVGdFUW1pZWh1emdPZ2FrRHJOWHN1NVRhRHVSMDNDZ2l5dGV1ZHkxd0tv?=
 =?utf-8?B?ZHBMMUJaNDhpeTBTVWFkRDBTV2lxRTFqL0ROT0hLK3YrZ0ljNUR0Wi9YYmZE?=
 =?utf-8?B?cVczMTd2NDFDdkFsR2VWU0R0NHFZcEY0cW1qS0l0ZUxPNUhHOUUrUTNhQTJR?=
 =?utf-8?B?VU1nclNsbDZqUWk5N1B5Q21kQnFIRUo2bzNBUUJjR2c1R2ZuWXpnaEZadHhz?=
 =?utf-8?B?cHhxYzNoVVVIZTNwc1RsN0IzalB6dmo3aGprS21iK1VqQWFia0oxNmpTTllN?=
 =?utf-8?B?bVRGdlVUSlRBVWUyQ3Z0MVdlMlI1a0ordzBtVU52UmM5NVBoUS8xbmgxNHNt?=
 =?utf-8?B?ZnMxQ3BXZlpUWEFQay81NkYzMm9TcytkNmMxblJNMzdGQkdlZUt2V29hT0h3?=
 =?utf-8?Q?o1vK7mBzbaUyb9YUleGBqGOHv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f4fc7b-2bc6-4505-34ba-08dc2997c4a4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 17:51:39.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFtsg3/VQ7OpWJ4Yk6NZirNH8D3OcfEG1B+FM/17U5LfS7LdGhTY51a8CTj0/cfWYQHMsUw8c4MExAdPnB4xUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597

On 2/7/24 14:47, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> sev-dev.c calls code in the AMD IOMMU now but that can't really work if
> latter is not enabled in Kconfig:
> 
>    ld: vmlinux.o: in function `__sev_firmware_shutdown.isra.0':
>    sev-dev.c:(.text+0x2501f0e): undefined reference to `amd_iommu_snp_disable'
>    ld: vmlinux.o: in function `snp_rmptable_init':
>    sev.c:(.init.text+0x26260): undefined reference to `amd_iommu_snp_en'
>    make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
>    make: *** [Makefile:240: __sub-make] Error 2
> 
> Fix those deps.
> 
> Fixes: f366a8dac1b8 ("iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown")
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>   drivers/crypto/ccp/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/Kconfig b/drivers/crypto/ccp/Kconfig
> index 32268e239bf1..f394e45e11ab 100644
> --- a/drivers/crypto/ccp/Kconfig
> +++ b/drivers/crypto/ccp/Kconfig
> @@ -38,7 +38,7 @@ config CRYPTO_DEV_CCP_CRYPTO
>   config CRYPTO_DEV_SP_PSP
>   	bool "Platform Security Processor (PSP) device"
>   	default y
> -	depends on CRYPTO_DEV_CCP_DD && X86_64
> +	depends on CRYPTO_DEV_CCP_DD && X86_64 && AMD_IOMMU

Or should the ifdef around amd_iommu_snp_disable() in 
include/linux/amd-iommu.h instead be:

#if defined(CONFIG_AMD_IOMMU) && defined(CONFIG_KVM_AMD_SEV)

and amd_iommu_snp_en be protected in arch/x86/include/asm/iommu.h as:

#ifdef CONFIG_AMD_IOMMU
extern bool amd_iommu_snp_en;
#else
#define amd_iommu_snp_en false
#endif

I think this would be better in case these should be referenced elsewhere 
in the future.

Thanks,
Tom

>   	help
>   	 Provide support for the AMD Platform Security Processor (PSP).
>   	 The PSP is a dedicated processor that provides support for key

