Return-Path: <linux-kernel+bounces-129913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B98971F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5E629126A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C283149009;
	Wed,  3 Apr 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XTT1NSg6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2092.outbound.protection.outlook.com [40.107.244.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72642148305;
	Wed,  3 Apr 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153134; cv=fail; b=fuuHMys5rvF7o4ipfoVxCV5YcQMq8hx2SPXINRHMmKJbSztlYt8aL/YtdxjW8wLBhDexkrI1/LGe5rqNLYEtoLJXKaZjU224UL8Ykspro++suexb0MMcrTZUp6m9uG6yVwsmIP3LLIIpfd0jOOFrriwqdTGAaOI/yfOI4/jXbOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153134; c=relaxed/simple;
	bh=SGSGUlJcYQTtAVQvQUxG1HNIs1iWE6gTONwaTTG64lY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HZv3Lausolzjb73Dl/lKT6K6M0b19G2C7P3A2CyMuB4JjF4RdewU0sd+oXG34+qEoOriZLA8xFFLQXKueBAWfJw2AALq+rmljnQkQCZlp/neOtTyKVv/2bXreeUa29CmTTg8VLn6zh4AUD9X61tiWzk9aaUjv5wFP1AvbTu0S9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XTT1NSg6; arc=fail smtp.client-ip=40.107.244.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyPeAe215UrR/P56xzS8OcbNK6M1WIjZWn3GgVf0tYjUsBpbjPsrYDgRnKFKgNoePqTnjvW2lm0/pxSEsTMxECjnhXDQOwz8rqxazWZRiWkCdOxeLQMNf8RsVS2z7/9i6jcThaxKyseqN5i+FwGgLD2uUwrgHwPQXRpXTgfNgJnVrbMT8YUwzxRvNCk/lCbXANCoPY51xSEXZF9FCcXEUdiIM3W9BYvu9SwLBcfBBzw3jRDx7YydUzuX/xUe6IeRbqGe9RzNV92IcIWMzc2cO8m2S6f0rwhUxhRna54XAONymH33ovHc4/9B23FqvFz4YJ45q4ITTIa02vGA81xqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmKhi7VXduba50RTU8lP3HUCQ7D2Ew+k5EFh5pe4C1M=;
 b=K4rwXefUHyaO4CV5uVoZoPd/H7Am5luNVvWa0O3qqvpCbS+RExnuA9fDvIIYmiEdmRXce1Y6eEoUdSLkqfW+E5htGAfzE/GLG1foj6J5sLrPNxecmcjubRB09kSZzEcuLmLMkAuKTBHKytf357ZytbWrl6GYoRqAysVcMlwPjIo3FXfcK73OwHYmQB8gLu7qflRCSBEpiX6aALZpy+E+CjanTOqxU52jjSJvV6mp2gxXaPHjOrQQgD8UkQ6QriR4CgHQOnsOg4YsEaB+OQFyb4wEqgCyEcJ2C0df1aO6rKjpFYFDefCVtXyO5NPBp+19ftOJRZZ4/zda5QiHq6ywyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmKhi7VXduba50RTU8lP3HUCQ7D2Ew+k5EFh5pe4C1M=;
 b=XTT1NSg6hpk1kjFAOrRniCM1JvQceqjQEhUofBkjUvP5/gJdUeyGfYjg+eEzbLWxxmhGHTSIegrl2hnoIXl/zHXFaPmmiXOetRr9PwoVxA0HyhqjbZftSoc3dTVOi68KocIa2wfIpupuN27j1jDVwtUwsnrYVf0vdP0t4ub+Fqs=
Received: from DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) by
 PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:05:28 +0000
Received: from DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::2d67:ab86:61f6:2afb]) by DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::2d67:ab86:61f6:2afb%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 14:05:28 +0000
Message-ID: <943f76ae-d83a-4824-abeb-f1a6b187c305@amd.com>
Date: Tue, 2 Apr 2024 22:45:24 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v2 2/4] RAS/AMD/ATL: Expand helpers for adding and
 removing base and hole
To: John Allen <john.allen@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20240327185222.98998-1-john.allen@amd.com>
 <20240327185222.98998-3-john.allen@amd.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240327185222.98998-3-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0760.namprd03.prod.outlook.com
 (2603:10b6:408:13a::15) To DM6PR12MB3116.namprd12.prod.outlook.com
 (2603:10b6:5:38::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:EE_|PH7PR12MB6788:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qe2SQCrYZkRhMyRo21JYPn6jxwA/+fv8zqLCLpl0PIV9wk+brA17q6TtXIlK5Bqjj90EwW+LThC2Rk4fEq2OCMNW0ODdd+3QI1hBmCD7Z4ZSh8qyelk18XzY4CPLT36MQ+3IbUljNhz6qbi4rN/F4/mUGv3yKq/+XcJuuKKLhTGrxrot0vAF3be751QErdLOta1WB4vf/K8cA4oT26SrQRLf1Vz/ubwMrUa0o/ll6cjiKMzMm/bMdeR8+Oaoh9cHQHkqhyhLsagmXwfFtuSc8F5mam5yO3QEs6/SgD/LBo+yr6NQmI/SV3PKEvGj5l33+5tpn3TlmVLLQM6gFqPOiKiDsuaWtLw52kKn68wwDjxfT84C1rn3JdNdqRvH6XXUVrLdTRWqWagNJAhE0ceQmyoATpmY/6qx2MAPvbzAGzhyDlrCTXtCnbmY0CzHz1XeqYC6cJnvm+riJgIDjW5qWtA3EzRK2FB01n94yEyon3su4W3OsjsUvg3PoZaFM1+0JSbJ+Y1ExfoYc8yyAbwJkMoynk6erTRjJ7KKGO0z2SBVWcUnkH0xEWh2J9iQ7EqCNMqz/D1xUStgpGdI+JM6faSbmDRdum7IsI1QAczEBZRDYylO6LBzeUDAXXVYoJ1uy7mTS7kK/PEUb/txvKbKlyVPVhkMqQt80O4VeAMBuvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmgzSlhFbDBHWWlRcDdCbEllWml3NThvREY0dEZBVzdRbmFqaFJOMUdGcXht?=
 =?utf-8?B?YmJuM3hmbWNjM2UyZTVDdHdkOFJscHRJcXprcXlBbGphTHZjVzFlRXhYT1p2?=
 =?utf-8?B?UXFSOVRUcVFBV29FMnVMdUlPd1NNd1dmek5ZV3EwU0lRSzJRMmwrMStYTVBp?=
 =?utf-8?B?Z3F3MDNBSmdVbVcyYTd1ek1nS2RnaWdxdDh6UXZMQVFScysxUmx6RDAzRHky?=
 =?utf-8?B?Z0VrWGFZcERFS3dQaVZ4Si9RbWtBMHAvZlJGdkx6SU5aWjhKdS9ZclZxWlVS?=
 =?utf-8?B?enVjQ1dUU1cxZmtRQmFXc1RFTUlLTy9KYkpUNzhsS00wci9mMkNpMUpBTUt4?=
 =?utf-8?B?UEVTaDllNXAvSERTOS9wM2xLb1N4djlMYXE0ZFJmYzF0NUV3T2JSbVlKakxX?=
 =?utf-8?B?aFAycTYyK3pidXhVcmpBSFBKTC8rRjgrcVFKZW4yVUxCRCtXM1Frbit6SjZ2?=
 =?utf-8?B?ZEhTajdrZ1RXeS9XQVkxZVNGcmNSaWlNQ1JjT0NOcXU2bnExWHpTWkpxNXFt?=
 =?utf-8?B?OHBQMXloTmY0bWNDSWdXTzJkK3AxTzQ3WFNaUzJnQnFDSndwMU5Da2NOTFZr?=
 =?utf-8?B?ZllUK3ZESVMwYzdSeC9ic0VsTDZzbTg3WHJ2dXJVTk1mbjR3RmtxQ0pqTkxj?=
 =?utf-8?B?dnZCejJUTENrSlc0RGJXa29vSysyTGwzMUN2c3JXUkZOM2tKWkhxMi9BV0dQ?=
 =?utf-8?B?UVVzWXozaiszWmhFdFJNWTdPSUYvRURwbDhWeXVRZWFWdWhmWEVTb3JHNURv?=
 =?utf-8?B?bnBuRUhYQ1hMSkh2bTF0NkM4aEw5OVl2RUgzdjliVGVqelVTSUZZUGp2eHNv?=
 =?utf-8?B?QUNKWDdPSkl4WmJtRVJJSGdlb0hUMjVsRVVsWmVHU3d0clZ1Y3FYbHEyaUh6?=
 =?utf-8?B?V1BtTkU3STJ4QVR4aytWYUUyNld5WUpEdnZkYXRkbUxtN0RobWZ0dldnZ2FS?=
 =?utf-8?B?cndPaXQ5bk1NVW1PZm1BaTZGYkk0Yk5YZTh3K0wvNWdKS044dk4wcm1jNG5I?=
 =?utf-8?B?M1lpa0FFK1QzV2s5bFdRWGRvdkNnSG9JWG5uc0xGTXA3U2pjMC84VVBCSUh4?=
 =?utf-8?B?WkhPUytyRTBzZHY5Wk9wRVZrRUhJQVNCT0hVQmYxV2pja1FUaVg5MGVteG1z?=
 =?utf-8?B?WkFXdjE3dnRESXlpWm85TXJFeWlGSmR0aCtSdTRURThVaGpWaEVDcXJFVkVZ?=
 =?utf-8?B?UGljczJmTmkwR2kvZDJpdVRYdHZFZ2FiZTFGVEhZZ25yTUUvczFiSnMxWkJL?=
 =?utf-8?B?cW44UXRwV1ZnNnd5OG9uOXprdHZMOXJHTHVGR1JpeW03ZUVtL0FrYUpiQ1Nl?=
 =?utf-8?B?TFJrZWhpOVhhRHRsMUtyU1VVZnl5Q0tlaUJhRlpxd0hWL3JzUm1xQ2FreDZF?=
 =?utf-8?B?Yysra1dmYXZEOEV4UVBmOFVVWnR2U2JBNFlGMDBNZFZwS3N4ODJmcnAzeERD?=
 =?utf-8?B?NWt4c0NlanBoNC9zWjRYcmMyYTIwanZPUW1lM2RNQ2F6ZmZ5SGc5L2FsN0lX?=
 =?utf-8?B?d1hzS3ptNHhRMWZxTGdweHRDQS9tWFh2R21zaVBHM3d1b0EyZ0FRSWlCem92?=
 =?utf-8?B?MTdiTC8rYUNROEx3WXlMZEVtTExkODNURWwxeDBPS3ZBaGo1M0VzRkh4ckdm?=
 =?utf-8?B?WUpNY0psYzZQQ2thU2l6SkhZR1ppMlA1QkcvcmR2QkRxaFphVXhkbXh1SlNI?=
 =?utf-8?B?NFdMREJndk1wTU9iSm5ubFNwRngzU3dmeStMVWY1Nkdvd1ZtdzlGMzZhMGFC?=
 =?utf-8?B?WHR3N0NnL0xQR2UzR1I3WCs4RWdMZnFmc09UTTV6K1d2ZFRpUVJZcFN3UERP?=
 =?utf-8?B?eVUxbWgzeG9aQWNNbTdjK3FDOVlZNnVNYmhFVmpVbE1VVU1XSUJKVW5pblJQ?=
 =?utf-8?B?THZiQVVZbVAxaGVJZmVyRUxyS2dGbC9FclV0QmJuNTlmVXlwb2hQd1dFU1VI?=
 =?utf-8?B?dGtrNG1mK1RxempMSEgydmxPeHJ6TkNGRlpGcmR2Z3lDSmRZTDV3d0R2cU5x?=
 =?utf-8?B?U1VQU0dKYkRvMTQ4WHJxOHBKZTFYTVg5WWs5SkxPNGdBV3dWRTZpd1lscHJQ?=
 =?utf-8?B?NzZxMHVjdDdNSkVUM2p1N2VnRXR5aVVocHdmSldMd2VaQ1YyTTdwVnQzZ0I1?=
 =?utf-8?Q?UC6JqgIVkuaIibvwjQ150xmRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480cb80a-60b9-443c-0041-08dc53e71da6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:05:28.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgaXfQ53qlmLKEsKt4abJ9g+xXvTJ59SkA5iuC0c9JpgEWhCSrcxkvAt4BxYATtzG7vJR1oAwo/9KLF+cFn2TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788



On 3/27/24 14:52, John Allen wrote:
> The existing helpers for adding and removing the base and legacy MMIO

The remove helper is newly introduced in this patch, correct?

> hole operate on the ret_addr stored in the addr_ctx struct. This works
> for the existing use case as adding and removing the base and hole is
> only done once for an address that is already stored in ret_addr as part
> of translation.
>

I think it would help to give a bit more context and to describe things
more generally.

"The ret_addr field in struct addr_ctx contains the intermediate value of
the returned address as it passes through multiple steps in the
translation process. Currently, the "add DRAM base and legacy hole"
step is only done once, so it operates directly on the intermediate
value."

> However, in the Data Fabric 4.5 non-power-of-2 cases, we will add and
> remove the base and hole temporarily to check for correctness on
> addresses other than ret_addr multiple times throughout translation.
>

Don't say "we". Keep the voice passive.

"However, for X cases, the "add DRAM base and legacy hole" step, and its
inverse, need to be done for multiple temporary addresses values. During
this process, the intermediate should not be lost, so the ret_addr value
cannot be reused."

> Modify the helpers to take any address as a parameter and return the
> resulting address after adding or removing the hole. This will allow for
> more simply adding and removing the base and hole from any address
> without having to store them in the ret_addr field of the addr_ctx
> struct.
>

"Update the existing 'add' helper to operate on an arbitrary address.
And introduce a new 'remove' helper to do the inverse operations."

How do these sound?

> Signed-off-by: John Allen <john.allen@amd.com>
> ---
> v2:
>    - Make remove_base_and_hole the inverse of add_base_and_hole, removing
>      the hole first and then removing the base.
>    - Improve commit description.
> ---
>   drivers/ras/amd/atl/core.c     | 43 ++++++++++++++++++++++------------
>   drivers/ras/amd/atl/internal.h |  3 +++
>   2 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
> index 63513d972c07..d45f9948c0ab 100644
> --- a/drivers/ras/amd/atl/core.c
> +++ b/drivers/ras/amd/atl/core.c
> @@ -49,15 +49,26 @@ static bool legacy_hole_en(struct addr_ctx *ctx)
>   	return FIELD_GET(DF_LEGACY_MMIO_HOLE_EN, reg);
>   }
>   
> -static int add_legacy_hole(struct addr_ctx *ctx)
> +static u64 add_legacy_hole(struct addr_ctx *ctx, u64 addr)
>   {
>   	if (!legacy_hole_en(ctx))
> -		return 0;
> +		return addr;
>   
> -	if (ctx->ret_addr >= df_cfg.dram_hole_base)
> -		ctx->ret_addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
> +	if (addr >= df_cfg.dram_hole_base)
> +		addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
>   
> -	return 0;
> +	return addr;
> +}
> +
> +static u64 remove_legacy_hole(struct addr_ctx *ctx, u64 addr)
> +{
> +	if (!legacy_hole_en(ctx))
> +		return addr;
> +
> +	if (addr >= df_cfg.dram_hole_base)
> +		addr -= (BIT_ULL(32) - df_cfg.dram_hole_base);
> +
> +	return addr;
>   }
>   
>   static u64 get_base_addr(struct addr_ctx *ctx)
> @@ -72,14 +83,16 @@ static u64 get_base_addr(struct addr_ctx *ctx)
>   	return base_addr << DF_DRAM_BASE_LIMIT_LSB;
>   }
>   
> -static int add_base_and_hole(struct addr_ctx *ctx)
> +u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr)
>   {
> -	ctx->ret_addr += get_base_addr(ctx);
> -
> -	if (add_legacy_hole(ctx))
> -		return -EINVAL;
> +	addr += get_base_addr(ctx);
> +	return add_legacy_hole(ctx, addr);
> +}
>   
> -	return 0;
> +u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr)
> +{
> +	remove_legacy_hole(ctx, addr);
> +	return addr - get_base_addr(ctx);
>   }
>   
>   static bool late_hole_remove(struct addr_ctx *ctx)
> @@ -123,14 +136,14 @@ unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsig
>   	if (denormalize_address(&ctx))
>   		return -EINVAL;
>   
> -	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
> -		return -EINVAL;
> +	if (!late_hole_remove(&ctx))
> +		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
>   
>   	if (dehash_address(&ctx))
>   		return -EINVAL;
>   
> -	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
> -		return -EINVAL;
> +	if (late_hole_remove(&ctx))
> +		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
>   
>   	if (addr_over_limit(&ctx))
>   		return -EINVAL;
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> index 1413c8ddc6c5..05b870fcb24e 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -236,6 +236,9 @@ int dehash_address(struct addr_ctx *ctx);
>   unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
>   unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
>   
> +u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
> +u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
> +
>   /*
>    * Make a gap in @data that is @num_bits long starting at @bit_num.
>    * e.g. data		= 11111111'b

Besides the commit message notes, I think this looks good.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

