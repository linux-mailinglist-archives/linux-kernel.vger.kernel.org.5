Return-Path: <linux-kernel+bounces-134519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D4989B272
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB83B20FCE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EAC381DA;
	Sun,  7 Apr 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="olxlRaiX"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2139.outbound.protection.outlook.com [40.107.96.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3BB2B9C1;
	Sun,  7 Apr 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712499453; cv=fail; b=KD8L49AdlvrL87dBbYKJhAlbMSDN6y6FcMDJFQ1Tu93yTHR2mHw8oqrQH9iszS6W/DA6jv1gM0eM5VXgPbtqeAXEdl7h5eY+71MPuKNpdYL8GkSNlkuw/nNOF181NxSr/wHatWUV3o39JtH9q7+8L8lVjVujBGssIOhALg5eRF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712499453; c=relaxed/simple;
	bh=CVHMfM5c86uCkNsErN3jRJnVb3nVAIlmpAPn85XjWzQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MltKV9nbOkqrzod9cPobWs+qY8iESPBSXerqSuQm5o/p3p2h3Isygj6utpCRUPaYCapLqxtzyI/bIHO9+5FeUGL2PoPXFA7f08Dn5gLEe4lPdSue5FcgQTSrf1ylRmrgziF/Wh2zKLIqTo1MiBFaawae0YBZzQjgxzsw6bZ7Ef4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=olxlRaiX; arc=fail smtp.client-ip=40.107.96.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inBWmpuQyj1wN06Zf3+2NCYqOch2r2jvd00HcAWQc1HNhgarJ1cAiimLN9LTSC7yGt8jufjg++uuspepz7rQq3EY0OGpgaiHpN1T+A8zT7KIbFFkkokcL/FNeYgOzQ+5F/ugXltnTNHJLbDC2CmOVftD1YPoo/SpBJUm01Lj0IR2BzXkmON8iXs9WNwVgGdmjL+yIlMUtaSmMfLTpuz+9VEea1vpchhR6OPQs5EA+1apGNbGDyZ0Ui6IYljNJV9JatvJsVvtIbQTOZesRp6y8CFYswraQjWGuGxpjTTH764LHNrCPIKXjsvLsVHr+62W01BQzBPXL5alXNMx4bxxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy3hJJCgosowhS+YWzmjo54G+Z5gap/BQkjqWqC09zg=;
 b=csBzM7M+YyjPNtYUA82ne5+izbH9du0O/2thX94cFcwfuTG9PWvsj8CijGh4/RQz2aFPO+XHf9HJJpl2p4D6ATQ9RiAwXzMgrMmpqsrF1KwlMGkVmzNy63lsuhl1dWczYISCc7h0737W5NFszsWD4CYsWUxD9+vjYgiNH8OGbb7okbTcDNoAwwaNawNwqDo4/jD/IEKkndMN20ptxnaEb2It5kmJVZJdejXFO3d29CmWMuzs2bHc5ARTQDKBRlNWm+uxeJ6qsJXfNvE6LY8pjExHfhUNw6mXMRLFqPwXKS1O46sXS4T9Yth/FXQJ22Cz6CJBblga4GkaHLD03pqZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy3hJJCgosowhS+YWzmjo54G+Z5gap/BQkjqWqC09zg=;
 b=olxlRaiXCF9LOvhwouugNOKTJ2RKzi7GnDmO87Y/wsa6vz//XqfPJJ+nnLGIYZ9QApuw/AbO7vOVo6xi8xuws3eiNHI37t3vt+QwS4CUU787bKmHSqeJ/iLne/8YYmvGqh3moNMLp8DQaB1YwC1p9x4pF/x8jfLNOvb0HIxpwJg=
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 14:17:28 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 14:17:28 +0000
Message-ID: <f7e50ef5-44f1-4b39-8d60-9e271b294ea0@amd.com>
Date: Sun, 7 Apr 2024 10:17:26 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH 2/2] RAS/AMD/ATL: Translate normalized to system physical
 addresses using PRM
To: John Allen <john.allen@amd.com>, rafael@kernel.org, lenb@kernel.org,
 bp@alien8.de
References: <20240326212640.96920-1-john.allen@amd.com>
 <20240326212640.96920-3-john.allen@amd.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240326212640.96920-3-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0957.namprd03.prod.outlook.com
 (2603:10b6:408:108::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB8261:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jJd4CG2iTM0gj6bYbOwj2qwTTSAO99OVZ+YLtGoEGk7DorWavRwGbI4WOAsIzWiIlIxL6+Ge892WJfnH6pe9FBAXOOxeOIpmXLckPT+Us9JN3BrJTVwdzSqpMYBsec9ypWk6cIJEKNphvMtQ0Ah4edAATvnoOFDCQhXWZqZIOk5a/b4+fnmLakhOIPQwHD/A2k6XlDCn47e4APPZE8w5MHsIqWj7sspFui8VCUuvgy10p/X3Q1qnKLRq9lWVmcZy4+M4w/tPrhgI3vVAVzVFLMKFO4/DMA9HCB4+4atF6yys/PImPKzXQPjCTifmDfU/rhvzrHALLaO3tstqfDsTATAzqdMzLhj7z1AD0vwUO4Xg7SURpnQDllGYNNBkuOs7Yr/mnngUNxxcCSH3vTcnmL97XPHL99neKsfJQOZWVMU9uC5civEkLWPgukONzxqFZqQeHT+xMUxzC3+7Z5O5bDCTQOqKmQuaIz6+UtLDh9B+lQs68lK+oWCDXUGUDTCKk2zo8c1vr4G+iMaGrj3rIoL1lzYQuHPZAwC1tTnl8cYtpKSzWCo0VgeBfAHZ1NYd9ssSM8dwM8+R8KzUgiFUBrIlXt8uN4ZhaT70hqAThjkQg3cRP78IugZGohTATC+s5RMMp0VumTM4OPDkGHP3e+VH7tzq89WzLqj9kJFbz9A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFI4Qm91OW05dGJLMUR5cG9ScTBIem5BSDVxSm8vanBTRWxHaVl0b2lQOXZZ?=
 =?utf-8?B?NGFpU1lKUUNwSkZEMkIrdFBHandIbnpmR3RHbkxEb09pamdYT01WVFZNcE11?=
 =?utf-8?B?V3JnKy9aTEFuejZnY2Q5YkN1VWlqZ1E4dVpSR2FjeDFHd0prdi8zcXdRRmpI?=
 =?utf-8?B?bnFLalhVcjNIK3l1VGh5dk5pVE5nbFRhZGo3Rkp4NzBrNFFXQk1UZ1NjRUhS?=
 =?utf-8?B?amZXeERRK2JyT0kwQkYrUi9JU0E2WkxJTWtZaExaWHJHaERMajFQdGN4NVdr?=
 =?utf-8?B?Y09POThUK0RDYzkwTVpDWTNwQ3pHSUJYYjE5ZUR3ajVublpuckhva2ZpWHFV?=
 =?utf-8?B?NUJHNTlwTFJ4RFBSMzIwUDZJSUJVTzZyaU9pWkU3dTRMUnBUSm9TeU8wbWZH?=
 =?utf-8?B?WThEbVIxY0pLWWVKNTFTZUFKTWNEdnhBcjk3SjhuWHhTdmhmaTdPS0Y3YlA0?=
 =?utf-8?B?WGpHTi93ZU1KaVNNazVkZFN2Z0sxNDEyTDI2eTYxSXM4ZDlDN015aE9Benhi?=
 =?utf-8?B?SS9OT1FjY3BuK3RFUW5PallJUm5kOW90Yk44MFBnQXB3L3ZYUlk2L2VtaUV2?=
 =?utf-8?B?QU1CTGNzd0Q3NU1ZTEpPdUVRZG5wVlFwWE9DSDBvMTNxc2p6dDRWcVRwb09l?=
 =?utf-8?B?bTFaTVBraXppMlJvRzZrc1JTdW5Ndm9PeG9aTXJPeTZMSnlPZjdZV2lZY2JN?=
 =?utf-8?B?NGREUy95WmFoUmZYL1h1ajYxZVgvTDlFU3F5U09hNThhYnQ2WWl1dnBmb1JU?=
 =?utf-8?B?aFRyQ1lLc1M1eWV5MVFaL2RlbWhxMVpvbG1xTmQ2NVpCeDlveG8zNmxCOWJa?=
 =?utf-8?B?V1hUc3hxUG5Bc2RvYzhGZmxBMEVzSGsvTTkzdFhYdkF3QXJMbWU2MTNtblFQ?=
 =?utf-8?B?R2pacnlkSEhCU2Rpa2ROaVlqMHAvQWFmbk1yRHBma29NeFVraUxVbWFJbi9W?=
 =?utf-8?B?TTlNV2xwckxhR1phTTRmUEppWFovbGNFSFNsNjNRencrZ1kwK2tPRTdSNzky?=
 =?utf-8?B?M3hlaWdnYzhLVkhQU1l3alN5d1hiMGJXeHNlYU4yRGV3VkE5RzNFNXR0Rzh1?=
 =?utf-8?B?MkhhV2hTTDZrMWVnV293dExBMjNwelB0YWNrYUdMTktMQXlGUkJ0NTlYbWcy?=
 =?utf-8?B?OGVnR1UvSzJRbkZrUTBiTmYzSWNUMUVRTjd5S1ZkWXdKWkY1SUpZek9NR0NE?=
 =?utf-8?B?TCtlVlUzTnJ6b3ZYdzkyLzFwRzN6TzZrM0hBZWtFMzNxZzNTU0IvZWRCa3d6?=
 =?utf-8?B?ajJ3cml1YXVOTFFlM3NURkxBajd6dWVCd3c1Slg1V283YnFWdnkyczFLdWdE?=
 =?utf-8?B?MnAvVEI3UkF6YVBpM3FJQXR2SzFFNEFtWU45M2Q4a0lPR2NuS3BjTVhqWTBR?=
 =?utf-8?B?Y29IaUFkM2lLVndqWm1uSUVDSzdnb3BSL1VhVkdtQXJFM3lyTnVyM1c3L1Vt?=
 =?utf-8?B?cE5KaGRRVzAyenQzQkI2bWwyMmt3UHpucTMzY0o3V0dBS3crWjFpL0JjVTNU?=
 =?utf-8?B?RG84RlhlV2dMMGdKMmZhQ3RMQ0pGaXYwQkZuZ3NXWlVwQndwTWNtV0Z4WE40?=
 =?utf-8?B?V2g3THdNWDU3amdMa29SUWNXOFZYSmM3S2VGM1pEb1hMcTNXK1IyekVseStJ?=
 =?utf-8?B?VSs2Q0tJejlhL2k5RytCV0xjeVpBVGJ3RkNzNmdQME9xQzF4Zi8vaGgwUUF3?=
 =?utf-8?B?UXNzNmhyclVGbnBBdXk2ZmpIMnhKWk43eENLMlRKbFp5eGphZ3diV0hBNFRi?=
 =?utf-8?B?VSs5RnVBWDc1S1NNLzdLMDdjZ2dQcm9hS3J4RnpaZXUrbHAzZ0R2ZVFndUV0?=
 =?utf-8?B?eGloL0JscGsxY2JMNTlhNVJJOGVQT05RK3lFcUIzVWQxSGlteWQrNWFEN1lJ?=
 =?utf-8?B?MElDZDlxbGgrVUtpbHpIU0Fjamw5dTBNbXppLzh1TUM0ODZUME5Oa2dhcmJs?=
 =?utf-8?B?YkoxYXNpdnUvSC9qM2VQbkFGcy9LZko5SzloRVlhUXhTb254STVnTWlLdS9l?=
 =?utf-8?B?STduUjdESWQwSWk3T1U3YmxqZ2Z4MW5EQTRydTZpUUFDTXVzQnRibVN0cGpw?=
 =?utf-8?B?ZFVSeUQra0hEV09Cd1d3TjNqVjZad1NsZWtxU1Y0VW83OTFRY294WHFTejQ3?=
 =?utf-8?Q?iUxwz63Y9G3JIeam66eJ5i0xC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41a15b5-0d8f-4313-909d-08dc570d74a1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 14:17:28.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3OhsBENlEqIYSI9yOM4vr2wzDtBhbk56RLMQVPEZFfA0zJrU5UOTCewmzPYTVxzvs+o55Z1q+zERUK4VSwrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261



On 3/26/24 17:26, John Allen wrote:
> Future AMD platforms will provide a UEFI PRM module that implements a
> number of address translation PRM handlers. This will provide an
> interface for the OS to call platform specific code without requiring
> the use of SMM or other heavy firmware operations.
> 
> AMD Zen-based systems report memory error addresses through Machine
> Check banks representing Unified Memory Controllers (UMCs) in the form
> of UMC relative "normalized" addresses. A normalized address must be
> converted to a system physical address to be usable by the OS.
> 
> Add support for the normalized to system physical address translation
> PRM handler in the AMD Address Translation Library and prefer it over
> native code if available. The GUID and parameter buffer structure are
> specific to the normalized to system physical address handler provided
> by the address translation PRM module included in future AMD systems.
> 
> The address translation PRM module is documented in chapter 22 of the
> publicly available "AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
> ACPI v6.5 Porting Guide":
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/58088-0.75-pub.pdf
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>   drivers/ras/amd/atl/Makefile   |  1 +
>   drivers/ras/amd/atl/internal.h |  2 ++
>   drivers/ras/amd/atl/prm.c      | 61 ++++++++++++++++++++++++++++++++++
>   drivers/ras/amd/atl/umc.c      |  5 +++
>   4 files changed, 69 insertions(+)
>   create mode 100644 drivers/ras/amd/atl/prm.c
> 
> diff --git a/drivers/ras/amd/atl/Makefile b/drivers/ras/amd/atl/Makefile
> index 4acd5f05bd9c..8f1afa793e3b 100644
> --- a/drivers/ras/amd/atl/Makefile
> +++ b/drivers/ras/amd/atl/Makefile
> @@ -14,5 +14,6 @@ amd_atl-y		+= denormalize.o
>   amd_atl-y		+= map.o
>   amd_atl-y		+= system.o
>   amd_atl-y		+= umc.o
> +amd_atl-y		+= prm.o
>   
>   obj-$(CONFIG_AMD_ATL)	+= amd_atl.o
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> index 5de69e0bb0f9..f739dcada126 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -234,6 +234,8 @@ int dehash_address(struct addr_ctx *ctx);
>   unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
>   unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
>   
> +unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
> +
>   /*
>    * Make a gap in @data that is @num_bits long starting at @bit_num.
>    * e.g. data		= 11111111'b
> diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
> new file mode 100644
> index 000000000000..54a69e660eb5
> --- /dev/null
> +++ b/drivers/ras/amd/atl/prm.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Address Translation Library
> + *
> + * prm.c : Plumbing code to UEFI Platform Runtime Mechanism (PRM)
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: John Allen <john.allen@amd.com>
> + */
> +
> +#include "internal.h"
> +
> +#if defined(CONFIG_ACPI_PRMT)
> +
> +#include <linux/prmt.h>
> +
> +struct prm_umc_param_buffer_norm {
> +	u64 norm_addr;
> +	u8 socket;
> +	u64 umc_bank_inst_id;
> +	void *output_buffer;
> +} __packed;
> +
> +const guid_t norm_to_sys_prm_handler_guid = GUID_INIT(0xE7180659, 0xA65D,

Use the static keyword since this is only used in the current file.

> +						      0x451D, 0x92, 0xCD,
> +						      0x2B, 0x56, 0xF1, 0x2B,
> +						      0xEB, 0xA6);
> +
> +unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr)
> +{
> +	struct prm_umc_param_buffer_norm param_buffer;
> +	unsigned long ret_addr;
> +	int ret;
> +
> +	param_buffer.norm_addr        = addr;
> +	param_buffer.socket           = socket_id;
> +	param_buffer.umc_bank_inst_id = umc_bank_inst_id;
> +	param_buffer.output_buffer    = &ret_addr;
> +
> +	ret = acpi_call_prm_handler(norm_to_sys_prm_handler_guid, &param_buffer);
> +	if (!ret)
> +		return ret_addr;
> +
> +	if (ret == -ENODEV)
> +		pr_info("PRM module/handler not available\n");

Make this a pr_debug(). I don't think this is something a user could do
anything about. And one goal of this library to abstract how the
functions work. So "trying different backends" is a library developer
concern.

> +	else
> +		pr_info("PRM address translation failed\n");

Make this a pr_notice_once().

If the handler is available and fails, then this is likely a bug. It
should be reported to the system vendor. And it may be possible for the
user to update the PRM handler. This could be through a BIOS update or
the runtime update option for PRM.

Aside: is the runtime update option implemented?

"Notice" is between info and warning. I think we'd want the user to
notice, but this isn't so severe to need a warning.

Also, *_once() will prevent duplicate messages in the case of multiple
memory errors in the system. The handler shouldn't fail on any valid
input, so a single notice is enough. Especially if the message doesn't
have any error/context-specific details.

Another aside: it's possible to have invalid input. This can happen in
"software/simulated" MCA errors, i.e. the user provides an arbitrary
value for MCA_ADDR. But this would be a user error. I don't think it's
worth trying to filter out this case. An expert user could provide valid
inputs, and they may want to test the full flow. And this isn't an issue
just for PRM but the ATL overall. I hit this myself while testing
another feature. I used a signature for MCA_ADDR (0xC001C0DE01ABCDEF ?)
and the translation failed. But I was more interested in the signature
than the real value. :)

> +
> +	return ret;
> +}
> +
> +#else /* ACPI_PRMT */
> +
> +unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr)
> +{
> +	return -ENODEV;
> +}
> +
> +#endif
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index 59b6169093f7..954cbe6bf465 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -333,9 +333,14 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
>   	u8 coh_st_inst_id = get_coh_st_inst_id(err);
>   	unsigned long addr = get_addr(err->addr);
>   	u8 die_id = get_die_id(err);
> +	unsigned long ret_addr;
>   
>   	pr_debug("socket_id=0x%x die_id=0x%x coh_st_inst_id=0x%x addr=0x%016lx",
>   		 socket_id, die_id, coh_st_inst_id, addr);
>   
> +	ret_addr = prm_umc_norm_to_sys_addr(socket_id, err->ipid, addr);
> +	if (!IS_ERR_VALUE(ret_addr))
> +		return ret_addr;
> +
>   	return norm_to_sys_addr(socket_id, die_id, coh_st_inst_id, addr);
>   }

Thanks,
Yazen

