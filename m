Return-Path: <linux-kernel+bounces-119157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 095A988C4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B86B24558
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACEE12A171;
	Tue, 26 Mar 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YY4sNEh7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2103.outbound.protection.outlook.com [40.107.93.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1C12B172;
	Tue, 26 Mar 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462442; cv=fail; b=MqGJwdDKhUt7/rhnUGEx63lQ2grYvV7p+j3MIIxU3BZhnPJa8YQpU1R0f1HmCEux0JLuqvS7HsmZWDsEdFQQIUlBQO+zllj8gz4i43vISX70h+zSB8z+EK9d4MmsmAK8572wsJPWv6Rbpna53Sp+LWNfODIYv2vA3u6A13+Ftmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462442; c=relaxed/simple;
	bh=wL29XLvAmaJYhnJzBXtUhG9hjXvh8JLPJ3pHtVfyJEg=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N3fS02Ca0Ta8OVnyNsxzCN1vaLGfQVtkNYx2PukoFWKLDcQCMvdOv5nzUIElV0yWtPVOnrwO/8SgrYVLkitL5GrukUGpIMciFHnRfFwfmhSoy11bygLs/TLceVmFJX7R0ktw6nap5aKMDY0xKiO7BZt4XOIKiNDx4A6ueckdnz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YY4sNEh7; arc=fail smtp.client-ip=40.107.93.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwkMmS2JLLrdyTmZ9iuANcIks4ce29wk37mFgya0E6NdIY9F/zveJGk8ZyBOfFXspi+ef2RB7/timk09dGEmH8AESvr2WAAlneiKPzSIi0J0sy5Kpo3RWB+vAZ+hfbnuW4vaRVtlNqujAdfUCH3YT7/08WQbZS88hS1xIzLDtIHqdiN2EATTxGSJ2QsI1dRAFTzpo+k8beKmHmITHgt1zqr7BdHokJv4NEuQRjC7Em4YQjUIgSCOPxUfk9CssvlXJjbf9Inmqqeh7WP5T/ziPlPHWZS/baKyKZUNG1xMljp9O2+W9fzTLOeRNl0BRebjxVfNP42J4cZgjfWLTaFQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Cw+vsD8GWRiyJCHcCW4Dyv2aAdXdMy3ufPAjpwsc6g=;
 b=oajyrGFAZwel0UAdYg6hHoYh+ED1+KsW3LMwC6e7/s3XFG+8J63uKBKYmzMbUua6fMYk0XAAY1IQ9M3VaHeYlt9n4maQjIHDyZKrQwIeF6vFYKNPcqSOHXJhQZK8Jp6UYwZPBA7DrwZMcoyBF41S7wQIwqVkXj/NPlSytrzQFc+sxX+PqAOaHBTp8NuVtyrDlIc9ZGnGGHRWibhxUYvaS/4eW8dIjTj5ZWX/yTVJMimIXE7TLT2x29krMCQ8DRLLc8s1bFk4d+qHnSAKDZa0MqWiweBhVD3zB7HTaSgByKDtZ8IPCdYrorViQmEpDx8mX8n1TMhaZ8v+Tu6VeXkCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cw+vsD8GWRiyJCHcCW4Dyv2aAdXdMy3ufPAjpwsc6g=;
 b=YY4sNEh7odOvKeFrU0CrFuLjJ/r4l75knu8UU1M4Y3iBwAQndJ3UwdB7pQH6Rnd1Otj+pHG2NO9QeWtUlGNdowm8VXZlEDCygOIgYJP+bi62PNwZYmInMq7n47nFChxMOMt1lkx0dBL1l+3clVG9fyu9y5zXAMiFlOXdksUFhow=
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 14:13:24 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 14:13:24 +0000
Message-ID: <010bb8bb-cc48-4b83-b46b-14e5efc753a8@amd.com>
Date: Tue, 26 Mar 2024 10:13:21 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, bp@alien8.de, linux-edac@vger.kernel.org,
 tony.luck@intel.com, linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
 muralidhara.mk@amd.com
Subject: Re: [PATCH 2/4] RAS: ATL: Expand helpers for adding and removing base
 and hole
Content-Language: en-US
To: John Allen <john.allen@amd.com>
References: <20240314163527.63321-1-john.allen@amd.com>
 <20240314163527.63321-3-john.allen@amd.com>
 <ff9e4658-18c4-4a36-962a-373c15c337a2@amd.com>
 <ZgHQB2yasP1DeLcy@AUS-L1-JOHALLEN.amd.com>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <ZgHQB2yasP1DeLcy@AUS-L1-JOHALLEN.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11)
 To BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|LV2PR12MB5991:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6IFlxUym6uAa4c8QhsrIGwdZ/0egBOQ3OKhqA0XXInr9KUEZBhjmLJwENRl8j4iKWytHZQQT9tYQCp+4n8lC61qivb5ZODhQ3Mb8+rYX5eZM8aD5mWgLBMCs1ldNaNJRhTJTeeuOMfl2L5yF+g9a8UjYa1tMKBT/416qv7Vs+SziOF5SZH0RPgEIwqBYXc5awOl2SmCIVl3ySrkqM+UsY03Go/BZaPApxvtoEBs/ENW3lpoKLzx4FW05Ipa/DiZ3UMGfgJU1WI9JH4Stpw+NCHOw5IQ4RKRFUCg4W4dj17jnSlc+QcaLkem79SjyF+eTE9AXt/E5ggQ6GeZk8nwOB7sVFSj+vwJvzkXghE3A7jaVCQYAC9EbLKKDdrOakvuGIsoRONrCs+N+C5l5LMGC3zbH3lHLHfDN8pID6+L1cZZwHP5Gx4uxTxeHYyvyJ66r30vVlREjBsM/Jm7DNLoNHEzZ4M9cqEj6on19pIBwcOSx650sdO/hbHTrrIeIkPnDeW1ebAd519ibi7+4MGwdT/eGHcFLMgB/iJ5pa9hkq51IVU85x5p3/AxJ7seleRGzCs4mD5Lm5JmUblN8WaTdWRg5SxseWkkslXgbFGWrD+mXOGCOOd2W/R9IJpnHOWqqrZHxADf7swlq7p4k0KR5X8fCACl6ItjtFnj36e5Oo4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlZOUWNZWVgyL2V3QzdsUmhXd3JOcmVMN1JDSytwaVpWYUE3djhTUTZRUldw?=
 =?utf-8?B?QXNoeXVxVXdwRTMrVXEyOHJ2SXdWSWJ4bjhYSG5Td1RCVHRKcmtERlRpekV4?=
 =?utf-8?B?ajYxWXlCNG8xL0hrRzl0eUpZbkpCQ2N3L0dFZkFpSEV3QmhCdVZkRUlMRWlY?=
 =?utf-8?B?cW84RjZuOHhCbkd5QlJpc0EwZ2psOVFmUW5FQTlDbGNGWGtSRU4yM2VWZ0NV?=
 =?utf-8?B?bzJudEpCM1RHVVZGR3cyS09admJpdXNGQjJPdUxleHdtb1dXZVF6V1VJaVk4?=
 =?utf-8?B?YzFTMHhTVmdDeEY0ZWpGRXl1TUZaU0FORHUvbUM4aGlDVmkzRkV1M3BSc1dk?=
 =?utf-8?B?UmE0OVJWWEUreG5Cak1PTm1hc0lvTktKQUlGbWlmeUpneHYxMDYyVVlpYlcw?=
 =?utf-8?B?UmMwQ0JpN1gzQjkxelRPTlNYOFBRdEErN1p0VWhvQS8vU0hxMzNDbWk3a281?=
 =?utf-8?B?YzdjRzB3K0tHcVpWUzRJSmpSTHVjNXZvMnpMSXFUZ2RPZXZhdWpCWFdRb21J?=
 =?utf-8?B?WWJqUlRlZnV4NVdCczBFUkVkNnhUVmpYdjNzV3VPbUFodUNTelIrNnBHdDNq?=
 =?utf-8?B?Z2ZzbzVRQXNqd1BRR1lVTmdjaEVmdEJXUnE0aS9qNVJieFE3YmwvczdZaDE4?=
 =?utf-8?B?M2pLZG54Z2VFekx0dHJtTllRYm1aYkRleCs4dUdqSlE3dHo2NTJkRzBJb2Y4?=
 =?utf-8?B?L2M0aVhXZ1NQQXlVclF6STVQekRad1F2Nm15RmhiZlpla3BwcVgxc0ZZcGJL?=
 =?utf-8?B?YU9GTHZ5L2VRbkw1bGNhYWxoeXZVNFVMVFI1TjRwdjZWaXhieTZIVmczb2Zq?=
 =?utf-8?B?YSs3cU82RmpWV0tKd1Qvdk5GZDBhRFVxUjBEUnVPeDFLQWYxODd3ajFmaUdL?=
 =?utf-8?B?RHpMYnJLaW1LendOTTBORDJGczE4eDc0RkJNa0ZNU0VhQmtHSU91eDY5QVA2?=
 =?utf-8?B?ZXhydFY1TTJNS1FpY0g5VEdxSXpSZDhWaFViMlkrSzFPTzBJY240eWQ5bksy?=
 =?utf-8?B?bTVYQ3kydjEwUFZoMit0cHdvbHp1Q0JhUVhVU3lRaTBzYkRVTllYdGtoTk5w?=
 =?utf-8?B?dXBOc0pHc0U4NnlrUDZXN3pZb2RlNWt5dHJmQlp5aFl6S2JWc3UyUXdiMk9H?=
 =?utf-8?B?U2I3a0MwK09BN1UzZXZGa2ZBZFcrYjExQzZPVlE5dXRwZ3hYTzVTVDR2WVNZ?=
 =?utf-8?B?anZmT0thWWZTd1NZYU13YjVFT0VPTi9oanBEV256L2JwVWZLakN3ZjJpY1Jr?=
 =?utf-8?B?WXdBNFF4ZndCZkNhNC83SXJmM0R3Wk5QS1VlRGQvcHhJdUsvSmJxU1ZabmNi?=
 =?utf-8?B?cm05QnI5TW5GZFhGR0h1V3U5WnRrTmZRYndQSFJncVk2WUlhdVhsZEliWkVX?=
 =?utf-8?B?NXVJNG1nelVQOGhRWUJkZjFaNVArdkpvaHF3TnhaaWx5d3lndjNPQjFHdk9V?=
 =?utf-8?B?S3JzRS9aMkJSVXEyZ25ZKzAxQVJ6amZvZ25BbTlkenNWR25jMnZmWkVJckY2?=
 =?utf-8?B?TkgycVJ0YzlQNk4zOVp5WW1VNjMrY3RxSlY3bUVFTm9ZUTlDQUMveDBVT2Jq?=
 =?utf-8?B?RmY0RitWNGdWb0wyQldEYSs1Zy9xcTBnUE1IT0RBTXRZeCtzNk5mc3NVNG42?=
 =?utf-8?B?d0Y0OGZkWWgyMy9obHhCN2I1dlFQUWZ1QW0xT2lHOVA3dHliSGdYOXQxakwz?=
 =?utf-8?B?cDFLeG5GOTc5TnltTEtiOXVVZXBXTFFMZEhLTFBNZEVmMTFmSEZweloycmlr?=
 =?utf-8?B?anlNODlONmIzYXRweGFJdDZPdHVlQWtGSVdzU3M0TFdzWU1xc1ZvbWdrc3Jr?=
 =?utf-8?B?cngvanB1MWh0TEJGYjJsRURuZHlRZDBSMnZ5UjY1c3l1ZDU3alhHYVhYN0tH?=
 =?utf-8?B?MmNQTTdWSjkvZldtNnJBc0gzWFBBTm9NNUo2UFFYRUMyUTV4cXdPUHRmamM0?=
 =?utf-8?B?Q2E1anRsYkpDZmVkSGtObnlYUGpOOHYybm9VbXFBTCs5SjRnYUpra1JIQmQ5?=
 =?utf-8?B?NEVrakVtVTZvRGw0VjhyQ1Nkb2xzbGtKczFNQUEyREplc3ltdDdCckJCV2ZV?=
 =?utf-8?B?akRPMDlGV3h2V3hJT1lPNUxHbDdYR2FUN1NwWE1DdzRWblQ0NE15N3NyNUto?=
 =?utf-8?Q?QRPSpgSBLmwYhMzFmMynTcC/n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24343e1a-38df-49fa-894f-08dc4d9ee652
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:13:24.7774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3RrmMG1BzQvBEfQFu4HA/EcC2AA56nPpC/rQT58reOMakxMORs8Uc/znKmvrjtyt1K2762/uTEdQDPV6vY6pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991

On 3/25/24 15:27, John Allen wrote:
> On Mon, Mar 18, 2024 at 11:28:48AM -0400, Yazen Ghannam wrote:
>> On 3/14/24 12:35, John Allen wrote:
>>> Data fabric 4.5 denormalization will need to frequently add and remove
>>
>> More specifically, the non-power-of-2 cases will need this.
>>
>>> the base and the legacy MMIO hole. Modify existing helpers to improve DF
>>> 4.5 denormalization flow and add helper to remove the base and hole.
>>
>> Please write the what/context, why/issue, and how/fix information as
>> separate paragraphs even if they're just a single sentence each. I think
>> this helps to find the details more easily.
>>
>>>
>>> Signed-off-by: John Allen <john.allen@amd.com>
>>> ---
>>>    drivers/ras/amd/atl/core.c     | 43 ++++++++++++++++++++++------------
>>>    drivers/ras/amd/atl/internal.h |  3 +++
>>>    2 files changed, 31 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
>>> index c1710d233adb..cafdfc57d929 100644
>>> --- a/drivers/ras/amd/atl/core.c
>>> +++ b/drivers/ras/amd/atl/core.c
>>> @@ -49,15 +49,26 @@ static bool legacy_hole_en(struct addr_ctx *ctx)
>>>    	return FIELD_GET(DF_LEGACY_MMIO_HOLE_EN, reg);
>>>    }
>>> -static int add_legacy_hole(struct addr_ctx *ctx)
>>> +static u64 add_legacy_hole(struct addr_ctx *ctx, u64 addr)
>>>    {
>>>    	if (!legacy_hole_en(ctx))
>>> -		return 0;
>>> +		return addr;
>>> -	if (ctx->addr >= df_cfg.dram_hole_base)
>>> -		ctx->addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
>>> +	if (addr >= df_cfg.dram_hole_base)
>>> +		addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
>>> -	return 0;
>>> +	return addr;
>>> +}
>>> +
>>> +static u64 remove_legacy_hole(struct addr_ctx *ctx, u64 addr)
>>> +{
>>> +	if (!legacy_hole_en(ctx))
>>> +		return addr;
>>> +
>>> +	if (addr >= df_cfg.dram_hole_base)
>>> +		addr -= (BIT_ULL(32) - df_cfg.dram_hole_base);
>>> +
>>> +	return addr;
>>>    }
>>>    static u64 get_base_addr(struct addr_ctx *ctx)
>>> @@ -72,14 +83,16 @@ static u64 get_base_addr(struct addr_ctx *ctx)
>>>    	return base_addr << DF_DRAM_BASE_LIMIT_LSB;
>>>    }
>>> -static int add_base_and_hole(struct addr_ctx *ctx)
>>> +u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr)
>>>    {
>>> -	ctx->ret_addr += get_base_addr(ctx);
>>> -
>>> -	if (add_legacy_hole(ctx))
>>> -		return -EINVAL;
>>> +	addr += get_base_addr(ctx);
>>> +	return add_legacy_hole(ctx, addr);
>>> +}
>>> -	return 0;
>>> +u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr)
>>> +{
>>> +	addr -= get_base_addr(ctx);
>>> +	return remove_legacy_hole(ctx, addr);
>>
>> This should be the inverse of the "add" operation, I think. So remove
>> the legacy hole first, then remove the base address.
>>
>>>    }
>>>    static bool late_hole_remove(struct addr_ctx *ctx)
>>> @@ -123,14 +136,14 @@ unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsig
>>>    	if (denormalize_address(&ctx))
>>>    		return -EINVAL;
>>> -	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
>>> -		return -EINVAL;
>>> +	if (!late_hole_remove(&ctx))
>>> +		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
>>>    	if (dehash_address(&ctx))
>>>    		return -EINVAL;
>>> -	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
>>> -		return -EINVAL;
>>> +	if (late_hole_remove(&ctx))
>>> +		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
>>>    	if (addr_over_limit(&ctx))
>>>    		return -EINVAL;
>>> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
>>> index 1413c8ddc6c5..05b870fcb24e 100644
>>> --- a/drivers/ras/amd/atl/internal.h
>>> +++ b/drivers/ras/amd/atl/internal.h
>>> @@ -236,6 +236,9 @@ int dehash_address(struct addr_ctx *ctx);
>>>    unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
>>>    unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
>>> +u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
>>> +u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
>>
>> remove_base_and_hole() is only used in denormalize.c, correct? So why
>> not define it there as static? Other than trying to keep the code
>> together and symmetrical, I mean.
> 
> In addition to keeping the two inverse functions together,
> remove_base_and_hole depends on other functions in core.c. So if we
> don't expose remove_base_and_hole in the header, then we would need to
> expose get_base_addr and remove_legacy_hole in the header.
> Alternatively, we could move remove_legacy_hole to denormalize.c and
> expose get_base_addr and legacy_hole_en in the header instead. So
> exposing one function that's the inverse of the other just looks better
> to me than exposing two.
> 

Right, fair point. So what you have is good then.

Thanks,
Yazen

