Return-Path: <linux-kernel+bounces-47719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72FF8451B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E39DB21CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6365B157E9E;
	Thu,  1 Feb 2024 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nu1BinM/"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444DF6BB54;
	Thu,  1 Feb 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771004; cv=fail; b=dTn88CmZqqKNijWXqPWMgUGaCdWIoYj5uW6TTc/ZAGyYYkCIczhgruKVVaxPWkuE3Ah0l0piEgEVungW+I4rKbftNds28bJzb10oLGvXIQ/l35x8bSFEMESIj8p7AkR/KhEMkBPJEyv+eonxexXahVvO7YYd4DGw4MLZDcnJcL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771004; c=relaxed/simple;
	bh=qS35xocgGpnlNN1vHTPj27qRqiZ1kr7s7Qbest3Yx6g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=fP/WO6Dke3pZ2HCBkbyoUYI2d+eaZdTev2ze/sn+Nqb/GVzqzmBnFMF6ikPfs8hUMSmlcGgS3ERSMy5RWOjUvOIt8Wb8XSj9QEr1XXtip5cu+pY2VwqYlPa/GzP/2uLeSXhnt+8JyxgtIQYn5VYXGnjeNWKbPHhSMETBlJvWxGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nu1BinM/; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5EP8adCPOulUvXU6iYEjhGycv8i/UapqxncqU5Fgef7YaEZvIRjoYR2lnEIIR5VLE9iZVDrhPUb9fFt8QjcjmSegTE1TYM/uvx81/+BgpQti2O9MGSD25pOfkpf2OfWU5z0fI2qHYooF9PI08WuKpBRORIVemll1BmCkd5ErtLQsgzQKMDMbl2CJs/949YB397x7UsLWd920407MJWJHkUdJhcIHck4RmUIo1LaezXaS7FOZ8K0rCf6D1rKkHdwfpkhPy2eANH+eEjMM+3G2gnaklGKTv5wdzmjsLf8ctFJidVp3I7P8tEJjngdUSyuzTCROK/L1yf0cFDZJ4WfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EncEOYwPQp2Qqt+gpTPFjEQTzdYkOqzA/bQ92TVjDQw=;
 b=g1rSmPMOxizTVMK4ekzXO+9klBrM4YwyII3E0u2rw5FfrPaoYHt++2gtd4qDImu8MrvG5Tk0+h+ZFVutLrN7DxsYmnl0T1ytoqOR+JIRE4pbidiy1a3IiJBMMI4bnTfQyzni2YD2+69h4SAV1MGbAaIL4NHMtdjiDI0/1z52m3z3N9A/A9xZYtX/kbAVUxiUdhaWqvkmZGvIaM8qR3iU1CH7zJWQUX61l6ul8FoGsV3TKKptqVwXi91sJ+x002aihavP6Vi0Myim2ZcGHQRT8ZTNGo4Q5lnTq+qYq7S+Is5sGwZgmsgFpR3kD5qLo9M2T8Q0PhFwM8AsvgqZmRl8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EncEOYwPQp2Qqt+gpTPFjEQTzdYkOqzA/bQ92TVjDQw=;
 b=nu1BinM/eLw97UOIPSuTjJlXeJKPtwWroDKfS0gIsUbwpclWiQMyL2iLaENU++oGvFaC0QJ5TZGrBclJ/8l7ZOZmdJ7Vs1yi5od+HkxYcY0dfvVsh3oLerL2i/23TI0Kq+sThkZmvMV/OIHclgbT/DozizHXjtvs8uJM11GDIIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 07:03:16 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::a2e6:c3b5:4e05:825c]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::a2e6:c3b5:4e05:825c%4]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 07:03:16 +0000
Subject: Re: [PATCH] RAS/AMD/ATL: Add MI300 DRAM to Normalized address
 translation support
To: Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de, tony.luck@intel.com,
 linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com
References: <20240131165732.88297-1-yazen.ghannam@amd.com>
From: "M K, Muralidhara" <muralimk@amd.com>
Message-ID: <4a4be825-82d4-3c9f-942d-601d7fb57239@amd.com>
Date: Thu, 1 Feb 2024 12:33:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240131165732.88297-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::10) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cebd4b3-6c97-4e99-39fa-08dc22f3dd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z1IIywgxqxzgPqT9tIAFIfyW4tZj1SvmByG/BYygi5Ngx+AsWL7THL5xWwdUq2VpyfhT8cu4y7RuFLvKtUQfRN6uFuL5RPLg6WaHpWBh9hu6Vn/Zj+z0X0G34V5N1jnNmQHKos0RlyHNpTcJsbbCQOyFFA0oSu+EHqBXJMDeNWWz3Z9OUPx2jONvqSBuc6RptD1ma0RXPVre1jPJOAfdm7HqzhqvL9DW7h2JxbBUDqw2JxzB4lKWTfWYYzbZVV2RtL0GFGpC8RixqsW2ft4E/6d4ZV/WWk8ioqM0JfbyyAcgHfGNCH2Igb6LWW0WBXpH+uXXVvlSUQ/4lPxCObYRMCTPWiw57jsDqu5+WRi3IA6mrpBBbSQG/WbOtzjqiWVbQw0FtBB73URI5PGCIGIywXxK4yeNmah392C7Q19ix3KNXbHBbPQR3iDH2n39iOpTiIeRf2okvZOo1Zb1Hn0/moW2DPHcQfkzpY+rBFTU3iN21fOLq02eUwW8EGC8I580MNJWJWpecdfc3K+aN1qUpeusDggE3+VkNUmk1+uTx9rrl7uWIbB/CgdjvzD7EdL1ODNxNjxDn0K3h8jIOugJ28mCWHcnUfJQuJF4rZnkxo5asXPeFLsT2vghS3usQk47CHwssAuWqRQ2dJqwQ30lpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(83380400001)(26005)(478600001)(53546011)(6486002)(966005)(6506007)(6666004)(41300700001)(6512007)(4326008)(8936002)(36756003)(8676002)(66556008)(316002)(66476007)(66946007)(2906002)(31686004)(38100700002)(5660300002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEUwTDlEUmlDdVNQU0tNZjJuQWxoU2IxVVlGeStrTXYwK0FwMDkxTTRRblNv?=
 =?utf-8?B?RXYzcUg3RVpKUWh5MUlBdy9wbG51TVlQSGZCaUZ2c2ZwVG1xSDM5L2NDTEEr?=
 =?utf-8?B?c0Uvc1JLUG1TSUlyRWwvOE1vb2pQck5PNmFObE1OTUNwcThkQVY2d3YxYXZk?=
 =?utf-8?B?QVkyVE5XR2Z5dVhQNkNtcHNzaW4wNXpYeHFOVUZaQnA4YlRUQ1dpSERXMkJK?=
 =?utf-8?B?OFNPN01jRHhSeENpbnlzTHVjSmNWMTB1SlRRWDN3cmxyOVlKVEpOQjNLQ1VF?=
 =?utf-8?B?eDBhamR1SXU4bldzZ2V4eXF0bXE0TncwaU5VUnoxNW82b2R0dHRNendFWTZS?=
 =?utf-8?B?VmM3ZzZRVUg4TndsN3c0eExtQUdXYU84QlBsZGxaV0ZidlV2L2VhZUJ6bzVh?=
 =?utf-8?B?MGVWeTJkRmd3Vmo4Vno3RmhLWmNYMkRkcUdSLzNzSTUrYWVtbmVOa0ZGdFg5?=
 =?utf-8?B?d1FjUXZDUkRrM1hMcmo1d1hDblg4WUUzQno0RnBvcHp2V2c2bGMvSXJZeVBG?=
 =?utf-8?B?eU9TZkZFd1JWZXBUZ2dvUWpVamNIRGZ5REJRUlorcFNpT0ZaSUVVbHZoSTY1?=
 =?utf-8?B?ZzB3N3ZJRGxFa0NkVXpLenp1cEowVlFINWVmOERwY3pIaTZ3NHRqVjdVSElm?=
 =?utf-8?B?MnF0dmJ1bUhmbEV2Um0zOFRQYkNaTW4zWFRPaVdMdHY1TllrQzd6SWZuaVMv?=
 =?utf-8?B?SFg2QzRFakpEUE41NytUM1QrNXJ3cWlWMEpEVC9kTFhVKzBkWkl2RnpEYkVh?=
 =?utf-8?B?Tk9IUFUzSXRMdUp2RXlnYitGOHdDNHoyaC83Yno5dTJlUC9kbWdpSzV5Mm9X?=
 =?utf-8?B?K2d2RGdNcGdZR2ZiSEV2VWlmOVdNVG5FejI0VjRndUF1bkJUNWZoa0FCejZh?=
 =?utf-8?B?WEowL1pscThIM3kvRzlwL002UmVPVi9JUlFpci9hNXc3MnZsSzRLaUxoRHND?=
 =?utf-8?B?YmkzWHlGRXovV0ZITzBCeVcyOG9ZNkk5NVd3WGdQTDNZV0M5MGFNT1dadW15?=
 =?utf-8?B?MnhkcjJBZTFHM1JwandRenFOU3ZVRnRzc3BZdDAzdUtqTUdUdW05U0JQdUN2?=
 =?utf-8?B?ZGlBTHBYcWRHN2VZZjVUbDJMRHJ6ZUxLYW9zd3BNY0hFSG5zbUU3SGlybWdS?=
 =?utf-8?B?M0g1Q1AxRUdyL3RrSjVKOXZQWU90MHIvUE1zbnhEYmVTZTAzZ2hFaU0ycmd6?=
 =?utf-8?B?ZHZxRXhLOXVFd3Q5d2U2eElObC9qeDFCVDVxUlZhemVTeWFEQUw0M1JjQzZk?=
 =?utf-8?B?Mnd3NjhsSGZxRkhUekhUZ1FXbkpidWFLdXNpT3JPUnRzUUlzUEpQT1JOeUhT?=
 =?utf-8?B?MmRXMmI3V2ZQaG1hVGtmVi9FOFFlejUrOEk0MGhOa0Y2VUVvTFF2Rlpsd25o?=
 =?utf-8?B?S1ozL0gxNm8yakh6UDNMV3ZlVE95OWptNTdwSjBXODQyZGRIZHVBSDA2bTRl?=
 =?utf-8?B?Ni95bFFocG9aNGJEZzczcDJaQkRyNE9lU2JyWmR5R1REVjg0cnZEWWhXTERL?=
 =?utf-8?B?eHh5SkFDZjlxNTJhdU9ZUjBhbE5rSDhSSnRiT1lxL0s1dzdCN2VRaEJXZ1dx?=
 =?utf-8?B?eklrTWtjNjk0VysvaGlwbUJuTnNKbFlrZUxQTGFqRnpnWnlxNUY3V2FlSDVX?=
 =?utf-8?B?T2xyRXBQYTdGMUhyamZYd3NVQXozSlZvZ2JaMXJVeUNJVnB1N25oc1BZOHpT?=
 =?utf-8?B?M1pZa0tDTDNhS1A5WDJRbi9uWnUyK1B2dDVySVA3bDE2RlFaOFRScndIZ3l6?=
 =?utf-8?B?Q09LQVJ0OWV1TFBnaXdhaVl5YlVwMXNQeHhuU3orZHZmNm1BVEUxSzZwOVV4?=
 =?utf-8?B?QlBRazR1eHFXZytsWHVTRzNtNlZoV0ZzVVVyVml0RE9Gbm56NTd1UjhKTFF0?=
 =?utf-8?B?cm50N2UwRlU1c2tKcHk1R0NYK3R5ak1yNkVqL3VpNHkyU0JQbjFyUXNhd3My?=
 =?utf-8?B?Mm5IRGsrMFVPV0hKeFV5VmFhTUpWV3d6V0F0b3JsY2hpV3k0Z3BuRkhMY1I1?=
 =?utf-8?B?TldiUUlMZG41aTUrZzZFWUt4TVJRU0E4VlRmdkoxRWhVcU1NU2pvQXhGSUdP?=
 =?utf-8?B?VVpQOVB6aWpFSlhJRm1WUG9hRTVmV3ZsWkNlZVAzQXppSUJzNlhhMmlya0w2?=
 =?utf-8?Q?q80caW5MIt9QIJXNhaSfETmnR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cebd4b3-6c97-4e99-39fa-08dc22f3dd0b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 07:03:16.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJK8LPvi1ajOGwiLocxxI4dWLYhnUINtu0cOJ110imdx/W4H2nQvkkMFw+SAAPDXQ2mrTC/yIu7ACB2rhRxgIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546

Hi Yazen,

On 1/31/2024 10:27 PM, Yazen Ghannam wrote:
> Modern AMD systems report DRAM ECC errors through Unified Memory
> Controller (UMC) MCA banks. The value provided in MCA_ADDR is a
> "Normalized" address which represents the UMC's view of its managed
> memory. The Normalized address must be translated to a System Physical
> address for software to take action.
> 
> MI300 systems, uniquely, do not provide a Normalized address in MCA_ADDR
> for DRAM ECC errors. Rather, the "DRAM" address is reported. This value
> includes identifiers for the Bank, Row, Column, Pseudochannel, and Stack
> of the memory location.
> 
> The DRAM address must be converted to a Normalized address in order to
> be further translated to a System Physical address.
> 
> Add helper functions to do the DRAM to Normalized translation for MI300
> systems. The method is based on the fixed hardware layout of the on-chip
> memory.
> 
> Also, cache the required hardware register values during module init.
> These should not change during run time. And all UMCs should be
> programmed identically.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Notes:
> 
> This is an almost complete rewrite of the following patch:
> https://lore.kernel.org/r/20231129073521.2127403-4-muralimk@amd.com
> 
> I'd like to include Murali as co-developer, if that's okay with him,
> since this is based on his earlier work.
> 

Address translation support on MI300A is working as expected.
Please add me as codeveloped and tested-by
Muralidhara M K <muralidhara.mk@amd.com>


> With this patch, MI300 address translation support should be complete.
> The remaining work includes handling expanded page retirement cases.
> 
>   drivers/ras/amd/atl/internal.h |   1 +
>   drivers/ras/amd/atl/system.c   |   6 +-
>   drivers/ras/amd/atl/umc.c      | 199 ++++++++++++++++++++++++++++++++-
>   3 files changed, 204 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> index 21d45755e5f2..5de69e0bb0f9 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -224,6 +224,7 @@ int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo);
>   
>   int get_df_system_info(void);
>   int determine_node_id(struct addr_ctx *ctx, u8 socket_num, u8 die_num);
> +int get_addr_hash_mi300(void);
>   
>   int get_address_map(struct addr_ctx *ctx);
>   
> diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
> index 46493ed405d6..701349e84942 100644
> --- a/drivers/ras/amd/atl/system.c
> +++ b/drivers/ras/amd/atl/system.c
> @@ -124,9 +124,13 @@ static int df4_determine_df_rev(u32 reg)
>   	if (reg == DF_FUNC0_ID_ZEN4_SERVER)
>   		df_cfg.flags.socket_id_shift_quirk = 1;
>   
> -	if (reg == DF_FUNC0_ID_MI300)
> +	if (reg == DF_FUNC0_ID_MI300) {
>   		df_cfg.flags.heterogeneous = 1;
>   
> +		if (get_addr_hash_mi300())
> +			return -EINVAL;
> +	}
> +
>   	return df4_get_fabric_id_mask_registers();
>   }
>   
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index 7bfa21a582f0..816c2c5c683f 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -49,6 +49,203 @@ static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
>   	return i;
>   }
>   
> +static u16 internal_bitwise_xor(u16 val)
> +{
> +	u16 tmp = 0;
> +	u8 i;
> +
> +	for (i = 0; i < 16; i++)
> +		tmp ^= (val >> i) & 0x1;
> +
> +	return tmp;
> +}
> +
> +struct xor_bits {
> +	bool	xor_enable;
> +	u16	col_xor;
> +	u32	row_xor;
> +};
> +
> +#define NUM_BANK_BITS	4
> +
> +static struct {
> +	/* Values from UMC::CH::AddrHashBank registers */
> +	struct xor_bits	bank[NUM_BANK_BITS];
> +
> +	/* Values from UMC::CH::AddrHashPC register */
> +	struct xor_bits	pc;
> +
> +	/* Value from UMC::CH::AddrHashPC2 register */
> +	u8		bank_xor;
> +} addr_hash;
> +
> +#define MI300_UMC_CH_BASE	0x90000
> +#define MI300_ADDR_HASH_BANK0	(MI300_UMC_CH_BASE + 0xC8)
> +#define MI300_ADDR_HASH_PC	(MI300_UMC_CH_BASE + 0xE0)
> +#define MI300_ADDR_HASH_PC2	(MI300_UMC_CH_BASE + 0xE4)
> +
> +#define ADDR_HASH_XOR_EN	BIT(0)
> +#define ADDR_HASH_COL_XOR	GENMASK(13, 1)
> +#define ADDR_HASH_ROW_XOR	GENMASK(31, 14)
> +#define ADDR_HASH_BANK_XOR	GENMASK(5, 0)
> +
> +/*
> + * Read UMC::CH::AddrHash{Bank,PC,PC2} registers to get XOR bits used
> + * for hashing. Do this during module init, since the values will not
> + * change during run time.
> + *
> + * These registers are instantiated for each UMC across each AMD Node.
> + * However, they should be identically programmed due to the fixed hardware
> + * design of MI300 systems. So read the values from Node 0 UMC 0 and keep a
> + * single global structure for simplicity.
> + */
> +int get_addr_hash_mi300(void)
> +{
> +	u32 temp;
> +	int ret;
> +	u8 i;
> +
> +	for (i = 0; i < NUM_BANK_BITS; i++) {
> +		ret = amd_smn_read(0, MI300_ADDR_HASH_BANK0 + (i * 4), &temp);
> +		if (ret)
> +			return ret;
> +
> +		addr_hash.bank[i].xor_enable = FIELD_GET(ADDR_HASH_XOR_EN,  temp);
> +		addr_hash.bank[i].col_xor    = FIELD_GET(ADDR_HASH_COL_XOR, temp);
> +		addr_hash.bank[i].row_xor    = FIELD_GET(ADDR_HASH_ROW_XOR, temp);
> +	}
> +
> +	ret = amd_smn_read(0, MI300_ADDR_HASH_PC, &temp);
> +	if (ret)
> +		return ret;
> +
> +	addr_hash.pc.xor_enable = FIELD_GET(ADDR_HASH_XOR_EN,  temp);
> +	addr_hash.pc.col_xor    = FIELD_GET(ADDR_HASH_COL_XOR, temp);
> +	addr_hash.pc.row_xor    = FIELD_GET(ADDR_HASH_ROW_XOR, temp);
> +
> +	ret = amd_smn_read(0, MI300_ADDR_HASH_PC2, &temp);
> +	if (ret)
> +		return ret;
> +
> +	addr_hash.bank_xor = FIELD_GET(ADDR_HASH_BANK_XOR, temp);
> +
> +	return 0;
> +}
> +
> +/*
> + * MI300 systems report a DRAM address in MCA_ADDR for DRAM ECC errors. This must
> + * be converted to the intermediate Normalized address (NA) before translating to a
> + * System Physical address.
> + *
> + * The DRAM address includes bank, row, and column. Also included are bits for
> + * Pseudochannel (PC) and Stack ID (SID).
> + *
> + * Abbreviations: (S)tack ID, (P)seudochannel, (R)ow, (B)ank, (C)olumn, (Z)ero
> + *
> + * The MCA address format is as follows:
> + *	MCA_ADDR[27:0] = {S[1:0], P[0], R[14:0], B[3:0], C[4:0], Z[0]}
> + *
> + * The Normalized address format is fixed in hardware and is as follows:
> + *	NA[30:0] = {S[1:0], R[13:0], C4, B[1:0], B[3:2], C[3:2], P, C[1:0], Z[4:0]}
> + *
> + * Additionally, the PC and Bank bits may be hashed. This must be accounted for before
> + * reconstructing the Normalized address.
> + */
> +#define MI300_UMC_MCA_COL	GENMASK(5, 1)
> +#define MI300_UMC_MCA_BANK	GENMASK(9, 6)
> +#define MI300_UMC_MCA_ROW	GENMASK(24, 10)
> +#define MI300_UMC_MCA_PC	BIT(25)
> +#define MI300_UMC_MCA_SID	GENMASK(27, 26)
> +
> +#define MI300_NA_COL_1_0	GENMASK(6, 5)
> +#define MI300_NA_PC		BIT(7)
> +#define MI300_NA_COL_3_2	GENMASK(9, 8)
> +#define MI300_NA_BANK_3_2	GENMASK(11, 10)
> +#define MI300_NA_BANK_1_0	GENMASK(13, 12)
> +#define MI300_NA_COL_4		BIT(14)
> +#define MI300_NA_ROW		GENMASK(28, 15)
> +#define MI300_NA_SID		GENMASK(30, 29)
> +
> +static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
> +{
> +	u16 i, col, row, bank, pc, sid, temp;
> +
> +	col  = FIELD_GET(MI300_UMC_MCA_COL,  addr);
> +	bank = FIELD_GET(MI300_UMC_MCA_BANK, addr);
> +	row  = FIELD_GET(MI300_UMC_MCA_ROW,  addr);
> +	pc   = FIELD_GET(MI300_UMC_MCA_PC,   addr);
> +	sid  = FIELD_GET(MI300_UMC_MCA_SID,  addr);
> +
> +	/* Calculate hash for each Bank bit. */
> +	for (i = 0; i < NUM_BANK_BITS; i++) {
> +		if (!addr_hash.bank[i].xor_enable)
> +			continue;
> +
> +		temp  = internal_bitwise_xor(col & addr_hash.bank[i].col_xor);
> +		temp ^= internal_bitwise_xor(row & addr_hash.bank[i].row_xor);
> +		bank ^= temp << i;
> +	}
> +
> +	/* Calculate hash for PC bit. */
> +	if (addr_hash.pc.xor_enable) {
> +		/* Bits SID[1:0] act as Bank[6:5] for PC hash, so apply them here. */
> +		bank |= sid << 5;
> +
> +		temp  = internal_bitwise_xor(col  & addr_hash.pc.col_xor);
> +		temp ^= internal_bitwise_xor(row  & addr_hash.pc.row_xor);
> +		temp ^= internal_bitwise_xor(bank & addr_hash.bank_xor);
> +		pc   ^= temp;
> +
> +		/* Drop SID bits for the sake of debug printing later. */
> +		bank &= 0x1F;
> +	}
> +
> +	/* Reconstruct the Normalized address starting with NA[4:0] = 0 */
> +	addr  = 0;
> +
> +	/* NA[6:5] = Column[1:0] */
> +	temp  = col & 0x3;
> +	addr |= FIELD_PREP(MI300_NA_COL_1_0, temp);
> +
> +	/* NA[7] = PC */
> +	addr |= FIELD_PREP(MI300_NA_PC, pc);
> +
> +	/* NA[9:8] = Column[3:2] */
> +	temp  = (col >> 2) & 0x3;
> +	addr |= FIELD_PREP(MI300_NA_COL_3_2, temp);
> +
> +	/* NA[11:10] = Bank[3:2] */
> +	temp  = (bank >> 2) & 0x3;
> +	addr |= FIELD_PREP(MI300_NA_BANK_3_2, temp);
> +
> +	/* NA[13:12] = Bank[1:0] */
> +	temp  = bank & 0x3;
> +	addr |= FIELD_PREP(MI300_NA_BANK_1_0, temp);
> +
> +	/* NA[14] = Column[4] */
> +	temp  = (col >> 4) & 0x1;
> +	addr |= FIELD_PREP(MI300_NA_COL_4, temp);
> +
> +	/* NA[28:15] = Row[13:0] */
> +	addr |= FIELD_PREP(MI300_NA_ROW, row);
> +
> +	/* NA[30:29] = SID[1:0] */
> +	addr |= FIELD_PREP(MI300_NA_SID, sid);
> +
> +	pr_debug("Addr=0x%016lx", addr);
> +	pr_debug("Bank=%u Row=%u Column=%u PC=%u SID=%u", bank, row, col, pc, sid);
> +
> +	return addr;
> +}
> +
> +static unsigned long get_addr(unsigned long addr)
> +{
> +	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
> +		return convert_dram_to_norm_addr_mi300(addr);
> +
> +	return addr;
> +}
> +
>   #define MCA_IPID_INST_ID_HI	GENMASK_ULL(47, 44)
>   static u8 get_die_id(struct atl_err *err)
>   {
> @@ -82,7 +279,7 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
>   {
>   	u8 socket_id = topology_physical_package_id(err->cpu);
>   	u8 coh_st_inst_id = get_coh_st_inst_id(err);
> -	unsigned long addr = err->addr;
> +	unsigned long addr = get_addr(err->addr);
>   	u8 die_id = get_die_id(err);
>   
>   	pr_debug("socket_id=0x%x die_id=0x%x coh_st_inst_id=0x%x addr=0x%016lx",
> 
> base-commit: a7b57372e1c5c848cbe9169574f07a9ee2177a1b
> 

