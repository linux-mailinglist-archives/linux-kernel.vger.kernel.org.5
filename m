Return-Path: <linux-kernel+bounces-106304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84B87EC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034C4B20E53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0DF4F5EC;
	Mon, 18 Mar 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HGwVUmhQ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2014F887;
	Mon, 18 Mar 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775737; cv=fail; b=GOVC8nG8QYUNHZBvsOPW/n1HP9OhjOKU8SoDNDaxUv4UaUtKafJhI+X6r+h06496UrlUdNPx+w5kARgLP6Q4VV6/D0vQSUgoHRfYaiOs/YNuiVh9YESnS2TjCwKsASbZnFJhU+MYPO50fUq3VrkxyPOXM9pGmMlJlIo5mdpPZRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775737; c=relaxed/simple;
	bh=c3Dv0PHjGKdLI9uj2aw2lADBk00cChZpI9pTHwz09eA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FUEa0xfEgOImMDe8Nh7OfSE/HZFNsNWXsHBrohH+UlBpjX9lYY303FFsG4m4shBLLGcIx72MsQcCXaIXt5BJ3AOiLlVMVT0kceCMETAeW1yybjtAO2+SHGSUQ/d2Xw1ZsZXkQcV34QjetalORTFKBfVMsE6PDuN5K1HRnmkWT4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HGwVUmhQ; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evLfcCTCiMbgz37vOYpwrunmyOyhfRTumyFJve8e51sxOD2+FDJHWZee1jpxI6Vp3beR2H0nqoDAvm8DJ7wR1r15Az8tLbiRHOGPmN5CSKwt8shlkP9FgYTjMr9zIU1yA2tKw4R9KZOviOUnEtLCSWfoZBB0rkv11cd3TE1j9UoD/h6CE7DiDBUfDAaCG+mnShzDFSnL++RXR6kRLZdGxrG16E3wQrkiwpSmr5WcO7EYy10ztc6d/883ruaNI748JEsimQD4nk0G3wRyEW5g2hZURt+oTc/ngBXdvu2ZlquEbD6BWPXTzV6AFjvxPQDgFI3NrnHB5yIJBlUdi/GfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0QqKq0vIzXNUNb+jSr/4dM4kk3bl2ndXdn5BpmBSBQ=;
 b=dbNq7rBm4uXzHPkgUo68WumCgwy9jzAVeiLYeX4SSjsrVy9QnozgwBseZgxa/OLnhjaVAwv2Od3++ZyvUZy0KlxW5rrA5YCCiAQiOjnH/fHdI+h1RAaEhbqkNQPMJMRudOGglJEh+4TYZptw468Sm358ftziyXop1MSeuw0Z1Qu14CzZxW2HNBFqW8rQuVdxjaWx3NJEQ3YtXFIXlOzwkkk/fAnN1o0kUqlhLHKItKUQ+1zFBGTzkCqEkNuT9JN3N27p19XLflOD8BdOb2JXfpDOuehrvyb/9nJNpplXdZh5mcQA5Jop5EZIGbsdRpLatqhPfFMTeh4wkYfjWZSeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0QqKq0vIzXNUNb+jSr/4dM4kk3bl2ndXdn5BpmBSBQ=;
 b=HGwVUmhQS7tCTt5VQMcB3vhjjTjlwJsgMcjeqUyY4hB2qUYYdzXMa8IHizjx4xS5KWSu1Vb6NbzJXTVV3dahcHNHvR0XZWq1lXrl88fKvmxZlWcD/gbWBsN/LmeNLfYzzCs4IgN2vqj0nsJCXTkjooXcal34u9vv6PjqSHka6/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 15:28:53 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4%4]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 15:28:52 +0000
Message-ID: <ff9e4658-18c4-4a36-962a-373c15c337a2@amd.com>
Date: Mon, 18 Mar 2024 11:28:48 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH 2/4] RAS: ATL: Expand helpers for adding and removing base
 and hole
Content-Language: en-US
To: John Allen <john.allen@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20240314163527.63321-1-john.allen@amd.com>
 <20240314163527.63321-3-john.allen@amd.com>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240314163527.63321-3-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0796.namprd03.prod.outlook.com
 (2603:10b6:408:13f::21) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b33055-6579-4e31-c30a-08dc47601df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SFMMi/Ho65amgaej7eP01XXBYsHP2Npv9hdNlGgYO4l0BAKhNuw6rK5guFNOZuNsPsWLXArGoMRNy72y0ieu2/g61T4OuATPnrPZZycafBgKaAn+M/ue3O0Z7/ZFDKjAtMU9Z8+v7Bq3ZU9frG/AK/HtP3P7kNr5Egn8ZXWFibKIt8BmkLCC0cdmCawL7mptC3Z4UqcUT62KGr93TjdZylo42XBuyzpj7Zaq+86mU8MI+SX4Uiie/n8A8Bf+Hg45IfSd1IuVfe8ZJYC+CS5OiLx6xZ7TTFpnL+JQeEmUkm3UqFugx0GLzNbe8ODQ01djXQcgS5Wj2L30FfbItUbcc66MmbZ7nT/KTCRbVssF2ApONzpG5wFeIEeXUv94IXJpfsh4QHcykKHsq9TTUktHqtRUxlW6f3lQDg537zDPsgftcjtukeYw2E+gOcuPPU6CPBorUByGiOjOVCUGe2WKyX9Lb0I8tYckLDDxptjOuaRw+dhmgX5gvnnAifrVNpM/5xNBz6+P6/sHE/41vNUHCHcXjR9G2Li0Fq2qgQ6Vi/TjcrbsicaraCmrNVf5uF8m9tXKe44MsFdxAGZMqsx1sRpr82wSdqPtnEmSfhNnO1pTr9hB0NEwnyhGnr/ft91iurBIrWscWBAByH+oy9bQq1fBeE3bmcl3STDb6csh2KA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWpJMThrWVFuVU5taFByclFtcDFrVTlNQnAzRFNucmVHV205bFJ4WGhUZTNG?=
 =?utf-8?B?RURRRi80eDErZVBreEd4YlV5SERCcDA2eEhodVAxTHhSMXRaOXYzMDVKWWJT?=
 =?utf-8?B?TjZKVmdPTkFTVjdVNFk4K3M5dUJCUWcwTEtuYWU3N21rVTBrclZuVFF4dENL?=
 =?utf-8?B?a2xTaEtWK3dWaTIxMEdIalNxU3dnakRUdGthcTlzcXk5MklzVld4ejJQblJK?=
 =?utf-8?B?Tys2R2pWTHBmRkp3WlF6MkZYODIwNFVaT0tROCs0VTFMZFh2bFNJT2J1c0Jt?=
 =?utf-8?B?UkVhRW4waWZhWXcybjJyNmoxZjJ0Rk1KZXFDQkUyNUw5SysxWUNHNnh5aEZM?=
 =?utf-8?B?YklYK2Q1MUVvUDdRNEk5bUlIdE4rcGNRbXd0TTNRUU5WOUtqcmZYQVBtS2lo?=
 =?utf-8?B?QWtKbzkraEJUTTNNQUdIOU95YUNvV2crTUZBc1pOSWMrQ0wyeUYzcG5zRUx0?=
 =?utf-8?B?UGlaWStySitpWFcwTjlTMVExTWlZdGpSdVgwZEZkcURGMzZramxtNVA5MEM3?=
 =?utf-8?B?VFowMm5IL0F0cXBtSnFpNEJ3Q00wZlhteXRLMEFDdEVOVTlKcFdYbjRHcE1s?=
 =?utf-8?B?STZidzRmbWtZa3dZblZOTmhuWTJhV3p1K2VlUWVXZlJpSlFPclFKdUcyWlIw?=
 =?utf-8?B?MlduVHpvcUlmUnV5eThNOFRubEpJWVY0TW1tRExlaHZtNlcwazNTQ1VndU14?=
 =?utf-8?B?YkE5dTJmYlZLSzJKeFVNUEpBdEdIazdSV09WTXFjby9talZCU0EyenNZNkdU?=
 =?utf-8?B?Y2F5TXE4c3IvTERyRTN0b0JxalhQL2NIZDlWNzhJNHVQZjlEenQxSGpMaU9D?=
 =?utf-8?B?ajRQLzV4Ynk0c0J0bncrMm1HeXlONnpTNkUwaStoUmVGOFo2aUtoWEJnNUNL?=
 =?utf-8?B?ZW1haUpWRWZBNDJwL1dXaEx0RGxpbkFRckUvWCtMWnRVTHZvSXBSY0l5WEFT?=
 =?utf-8?B?WWpid21LL3I0RFRYMnd6dzc0THBEZGsrdk5WUmJyREdNeHVTc1ZvSnhjYkMz?=
 =?utf-8?B?a04yRy9yd3dSTGo3MkFGUWVJdjc4OGs3bGtKbUJpVkp2NVQ1dE95M0JFLzNi?=
 =?utf-8?B?blhqVFU5YVZQSVRrTEgzTENXSlpMR3I1YmlsZXZXdTB1UXY5aVoxMlMzL1J6?=
 =?utf-8?B?RWRvVjAvYUV4WEttTG83cldjajJLbUVZY3pPSWh4OS95ZjRpak1KUlJyTjY0?=
 =?utf-8?B?UVg0N2xJU1VIVU5LR2hlNnZnUnd0T25VK1dRUitWaEZ2RC9GMDArWVhPYzdi?=
 =?utf-8?B?dE1iTWcvaXNPcEFLelVGNkphWWI3WTRHbzcrZUtuYUdpYkhoMTR4RFo1cXlV?=
 =?utf-8?B?Vmg0YnRidTJFNTlEZEhQYm1wbEEvVnVmM2Q3ejhhampNZUExTjVkS2VKRldW?=
 =?utf-8?B?aUhCOHFHRmhva0kzV1pGbUpnWCtRQXhTWHNLK2FRa1ZFNkROVFJsUGdJczkw?=
 =?utf-8?B?RzFDZlQvVCtvUFdqL3dhUUNQUHBHQ0NEenQ5YmFGNWxROXVjYUVLRFprN3ha?=
 =?utf-8?B?Lzd5Ylkvdnh1T1lGWmhjQXlQN0FFSEdGNmxYb1NBTmUyeCtJVlAxVzZoaUY1?=
 =?utf-8?B?OFZhREEwVXIyeG14Rllod05uK2xIWDhVNHFVaFRqSFh1YkNheHNDbzlYVS9v?=
 =?utf-8?B?MGhSS3RmZHJkU3NMK1E1d3BVc0FUbkIxcHdnUmJWNU9mRitqNDZhSVVHYlli?=
 =?utf-8?B?VGY3RHFoT3RJQ1k3RDc3bnV4Uk5MelBOaVRVR2RTKy9iTGVHem1tNUQvNWwy?=
 =?utf-8?B?RnpNVWxra3pySUZvVEZ4bnluY096RTd0L0pxb29kTldHTHBxNXh1ZG4rWndV?=
 =?utf-8?B?cC84b0ZUMG8rWEdVRXcxemMxbkdqVEtmRGtqOFhlSGhZMlRCcXMrTVBMSHRI?=
 =?utf-8?B?VFpYWkpobUpHL1FHNkJJSEpsNHljYXNBWGVoRVlDU0J4OC9GTllpZjlrbWZz?=
 =?utf-8?B?N3RTMVJ3bmtVRmJSR25ib0IzVW55VDB4YnIzVmptRzRDSHBOR3E0V1FWcjIw?=
 =?utf-8?B?SGNQbkdZZ2JNaW80b083a29LN3kyaVBBMXZzcXhCeTVXblU4WHY1ZjhZRjFJ?=
 =?utf-8?B?eGExK1gzVnNVd3NUR3BSeEkvUE9NcGtMUUxMa2EvR3VKcWU2ajRTYW0rWjhN?=
 =?utf-8?Q?2v/TgGLVuQ7mdTRl3XpspibRt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b33055-6579-4e31-c30a-08dc47601df8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:28:52.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oanky+gssgcGpWEsP5YMIrJ8ayoQJNgtMGVtlKoKauQQcUJQ1nHYuzB/45o69Rn4aMgCLAGml47MQZ2pTzO16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959

On 3/14/24 12:35, John Allen wrote:
> Data fabric 4.5 denormalization will need to frequently add and remove

More specifically, the non-power-of-2 cases will need this.

> the base and the legacy MMIO hole. Modify existing helpers to improve DF
> 4.5 denormalization flow and add helper to remove the base and hole.

Please write the what/context, why/issue, and how/fix information as
separate paragraphs even if they're just a single sentence each. I think
this helps to find the details more easily.

> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>   drivers/ras/amd/atl/core.c     | 43 ++++++++++++++++++++++------------
>   drivers/ras/amd/atl/internal.h |  3 +++
>   2 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
> index c1710d233adb..cafdfc57d929 100644
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
> -	if (ctx->addr >= df_cfg.dram_hole_base)
> -		ctx->addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
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
> +	addr -= get_base_addr(ctx);
> +	return remove_legacy_hole(ctx, addr);

This should be the inverse of the "add" operation, I think. So remove
the legacy hole first, then remove the base address.

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

remove_base_and_hole() is only used in denormalize.c, correct? So why
not define it there as static? Other than trying to keep the code
together and symmetrical, I mean.

Thanks,
Yazen

