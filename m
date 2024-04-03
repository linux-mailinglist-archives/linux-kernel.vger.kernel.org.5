Return-Path: <linux-kernel+bounces-130079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E08973D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5D51F216B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203A14E2EE;
	Wed,  3 Apr 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZftnMSBt"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C214E2DC;
	Wed,  3 Apr 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157385; cv=fail; b=LbIoAjqUKi9e8ey+hcIdWC+RpN1UYjuaDKSjRxeOYf3Pk2ONtzt3oNhCPXxgeQhIC8g7YQBCPvgK2SwvzrJWag/8Zs5gkB3bnk7d7vY0l8/iNGBOZAfhqH7hYQwwslCI+s7Ybg68vyvYM+lnCZbbM3aytJST22v6Ba6/9aVrGEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157385; c=relaxed/simple;
	bh=pWzqaVOkX3UIODZFFUK7C6nXnupjkifVjDV5zXvxvNE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F0xOOoKyXMq3iFrbfzWOa/e7yDPsrKoDj2P3hKb4/OQj/WXPgLzE6kcVXcAgsDTxOCL4ZMF8uZw9wL7eBuULZxBK2UuFfTinIex3uam1VizDP0onZ9o3z04lVLD1YM+y4sk3vt0oRWdnW2dIMoCEIoqjNf6SsTSISD5zZRuaoGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZftnMSBt; arc=fail smtp.client-ip=40.107.243.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaHqY+JEPt5RUctL361ZZquiY1r+lQ3Zn2fy08Ys/M8X5jlVhxke5XuCIy3GFxizgQz8aJksHqwTGGihJrNpksafFuoF0edo6o23PJldYGEqC0OLABeXWOsJfqtOREq/+nhQDj+3hIHG0pD8IC05dYw6nPHSC+UmrtfiM353lstgkXsG7PmsJpzpKCM3I0e5XRTgKgtsV5pfoc8CsCZuzOXNxZQE8rEBVJvCEXTarac70WKuhWO0kFhOZfqK4uSSMUFwChe7CqWMw2F3FHgVj6bzOBpnn9dwJShLd+9jHmdKMGF1pAhdtd3J20hZIqE9ZNIZ1Vgh9mDDNsmz5b5YoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvbRptLTYSWonC0Ydly9EvLM/NvQZdEfznqKOwVOfjg=;
 b=NIptbilEqaUt7hV1JlxW8UL/bqfqwYntZVxOPUz8pZSFMlDGh3y8e6iLU8z7DcBzGOV8FjZfQWf26yuPDYQtz42Nav1ARwQMrJhO4Rdi65wGn9ghuH1BNSuCef6DMI7tzXoRkzkP5+tIUXocBG6epPXi9sZ/f4HBkJ8Z3I1crS6TXtRVOv6DUfcmPZxjeDxsOUXBqoZ4cOeXsIIvAAVr+PZumkJmgor6WdZujnmXGrTu9EhQYaeljlCe2q8AV1YLss6MzA00GszH0WeUrNVIeJDbUgI5CgDoMmczIMUiQwZ9vS03oxMyEI7qy8TC68YyWnIMXnL7CSk/mhho2DiAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvbRptLTYSWonC0Ydly9EvLM/NvQZdEfznqKOwVOfjg=;
 b=ZftnMSBt8oLDTUNNQ2iC3qEnO8HF7hD+kpCLyjwI62aa2ymppIYVHAV8/brrae2l/mFoOURDWK+xH/MOtCtzGRHPoncIs8gFDhWcmiX8rQ8DQtTrCyBMFPVZTrzRL92H9DolYrnSDQseEcPmflFWg6m6RDBxY5nNEQLYSU39Y/g=
Received: from DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) by
 DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Wed, 3 Apr 2024 15:16:20 +0000
Received: from DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::2d67:ab86:61f6:2afb]) by DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::2d67:ab86:61f6:2afb%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 15:16:20 +0000
Message-ID: <676630bb-5000-49ba-ba1b-7a9a6e538e5e@amd.com>
Date: Tue, 2 Apr 2024 23:56:17 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v2 4/4] RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
To: John Allen <john.allen@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20240327185222.98998-1-john.allen@amd.com>
 <20240327185222.98998-5-john.allen@amd.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240327185222.98998-5-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:405:75::24) To DM6PR12MB3116.namprd12.prod.outlook.com
 (2603:10b6:5:38::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:EE_|DM6PR12MB4059:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MclFvVQO5DNf2G9BnlNjnmB1GaNevfZZKABXnUFuwTeFSkOciWt1GUrQz0I7HviuJnCz+vc5oXH+V1YW7fIog9XyC6LJtu7zLy17KLgjoIOv8CYVYSF/FPjBnSTEROvfeAiQlYsnXjV0PPIzOHop7hyJ9U2fAYZjhJr/w2b6M06XqXJMPxX1sc6Txbfgy4ID23T20miK9B/KL9urHM5VSTtOssM56viTj8M6RvomdNjceX4r1B8tZcsDoyk0hDgeeRz8q9OCOkgXeeBm4FiTVoER3ZjjPy9+/Y8q6qCUFPDLbC2EVIEkjSyHWvAJZxxowdzc20BH96I4Qi48cFK1lYgbk3fNJvwO69PZEKMbDj8t9LkluIS7vLFBY/5gPNR1AGJN1Uh4bbyRuBBDK+gpT9Q9NRnFDbWlSW7LGc305rz6y8yuSlyl0el/ho86dy1EedXKdveCIvasqUQlIie9GjZyrRu26X8iS/s71+xiR2Wm/X0RRypSLpen4He+RTDBVizhjIefiRmXRBq0fZltiteJnZueWPU8RRAsRK2lav9ya6AmV7OhDstwjqBgLxvdDA0HF2TyT60eJ6WtLvayX9gkx8RvPEfH8odfr+6HZfZJpQuNvCCBjW/C1Jr//T1z5QxsxXvWn73rmFfjUooYifBLzLTZcT6tB/qrcOpWwqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bExZME9JVTU2K0d4dnR0Q0poWVZmQ3BkRElyeFc2ZWoxb0RyZDdPUUljVlhz?=
 =?utf-8?B?cHlQUlhkeHFrRTBtL2J6czJXaldzUHltSVhiQlhRWEtVMFhZZnJQMHhEb0dw?=
 =?utf-8?B?VHV3MWg3TEs0Rk1KbDh3TUZ3dDczQ2RqWElYN3pnTnQrVFZhNGRRbmN6TE5F?=
 =?utf-8?B?RGduNEZ3ZEhVcDZWS2JZZGJCanlIbGhLNDJkMlVQQ3dEVjhDMEVDMTBTRWlR?=
 =?utf-8?B?UGpzSDFoWXQ5SzRQUGUzQ3dFTkdoV0pjM2FxRUp1ellRWEt6bmMra1N3Smcv?=
 =?utf-8?B?MVdwU0lFNGxtMm4ycW5hS04wUE9nK21HcVl2aEFhcXp2bHRNU25CMWVYTmsw?=
 =?utf-8?B?RWhoUytsZENaanhraWdyQnl4RVRwWjNvMmZnN3ZSTEVqWGRkY2Y3cnJLaXF4?=
 =?utf-8?B?YVZjaDBpL1ZEV0tFQXNiZVN5S0NSL3Q2eUJudDh0WE9kZHB0T2pWcFRyRmFu?=
 =?utf-8?B?OVNpdEFqYk5mSHlPb1NBdXM1aFB0TEk1dGtXNUg2RW5td2M0T2xFYTJ3SjZL?=
 =?utf-8?B?UTdKNElhOTNhdkZpanVJNlBUZFdoZXpaTzlNeFlrSkFpVGp0OHRUYks3TUJ1?=
 =?utf-8?B?S3NRbmViOE9Rb2VkeUlneGJCbENuN1FrQzd6TG51OVdWdFRxK3VwUnBzbXFM?=
 =?utf-8?B?RW9yUCtVTnFNOHVlUnl3bkUxZ0NvZHJ6UzRUTG83eWdMd3J2ZDRQQTVJSlV5?=
 =?utf-8?B?RUNmQ2dwR29WSDU2eGV1N0FXd1UvOVMxNDZlSjlvTDl5TWxpNzhZMGNMT2Iy?=
 =?utf-8?B?MGRUaEd3VmhISlFOTzNtNlV2ZkJ3T2lxUnJvMmprK2pubTJCdEIra0NtdXBq?=
 =?utf-8?B?eEUvSnlGWlFGbG0wWERSUDdyclNDSzREQXB3VXBwcVJ0VTVNazB4WHFTNUdt?=
 =?utf-8?B?QmFGZUk4VE9vNGpEWWdJL3VJUVIzTGw4bnE5SjM2S3Y0bEF1LzJhQzNySWhY?=
 =?utf-8?B?dENRalBPdUFJTFd3eHdWUitPemd1eXdEYzcrSXAyWk1Lam5mREhVbVJQOW5P?=
 =?utf-8?B?Z1NVdmttQ3dnU1dqZkRka0dTeWVBR2tEUzgrQmFYbzg5cTZZem1yYno2Tmtx?=
 =?utf-8?B?VDQraWU3b0VhVTJEMlAyZjJzRWlSTlFoWi9zUk9OK0V5ckJSVjIzZFdpOHI0?=
 =?utf-8?B?RUJyQnM3Q1dNRWVUdW9VU0swWTI5SENXb29VZ3hsL2loZ3ZuNnBid3V0N3Nq?=
 =?utf-8?B?NFFyZ1VVOWs4eFRlQ0JHcXNFT0FsNTN3NTFiZk1JK1Q5VmZ5anVHcFNvc3po?=
 =?utf-8?B?dzRFbGhsTWRPbVFJRG1Td2ljZ3dCN0Q2V28zbWJ6UktWRkNaa0l4QmUzS2hF?=
 =?utf-8?B?LzdPbGI2QUd3dGl1Q3FlbFF2OG9uMEZ5R0F3enBPNW1MeldpS1dCdWlHS09T?=
 =?utf-8?B?SlErWVk4aU5NeXN4Rkw4cE4xSnZESlFhVUluY1ljcVlvNUZiWFhnN085SlJY?=
 =?utf-8?B?RUNYalhYQ0M3cFN2NkZZV0w5anFHdXRkbkNNOGdCbVhyZjNkSlRTcWt5OWJW?=
 =?utf-8?B?SHVPd2JBM3YxYW52V2wxMlhhS0xxY3hjcmtrdURaa3dlZDBMMlVzdkR6emNa?=
 =?utf-8?B?WUt3WlBNRFlvRzMvdExISjcrYmtheFp0R1pwbHhHSkJRaEkyV2s5QUsvb21N?=
 =?utf-8?B?R3hOTVNtNWtaSzZZZFBxTmo1RTM1RlREeGl6ZVVxRkdQYUZ5Y25wWitqSlcx?=
 =?utf-8?B?cGVmQW56SXIrK2dKcThvTDVGNFNiUlRHNmozSnRWYmE3VjJ1VVMyUVkwUzZP?=
 =?utf-8?B?TGk5WUJtNEV3RFdtc2ZDZkVHR0JhRDJCRFpHTFE0bUhHOE9IZzBsT00rUkhQ?=
 =?utf-8?B?dk9GMnkzWXF1Ykd2Z0d0MEsxcG5NejcwZ3hoWjBZT3dKKzNmZE9MMkN6ZUph?=
 =?utf-8?B?RzI0WE1IWFgvaWpBaHJVNXJDRnNzemIxTWc4djFrSFF3UjJzZFMzN3FOa0hQ?=
 =?utf-8?B?ZDVUVjVGd1NTRTljR0NzbkFoOFN5NCtoejFGVWR5NTVRUUdvbzRHM21LbTlz?=
 =?utf-8?B?OVZTUGtKbjRQVEs2VDRnd0R6NXJ3RXVSSTlTYmxyQ0lPdWRQYjhjSzQ5a3BM?=
 =?utf-8?B?bW52Y3d0UUxDYmcra2dVV3JOMlI1dGlMMklGdmlsSmpJZTQrRDJ5RU92eTJq?=
 =?utf-8?Q?x1piObnGSlz4AE6Y/rIILEGZr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a303c0-2959-4f98-8326-08dc53f1043b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 15:16:20.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfPqaWdIciFkIMRNieDrYHix9VGyaRKPGuPLW3ROxYfntUEFrpLHiIax6Db7tLWY7ccO/VC2lOoaJ9MRezSPIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059



On 3/27/24 14:52, John Allen wrote:
> Unlike with previous Data Fabric versions, with Data Fabric 4.5, there

Highlight that this is just for non-power-of-2 cases.

> are bits of the system physical address that can't be reconstructed from

"...can't be fully reconstructed..."

> the normalized address. Using NPS0_24CHAN_1K_HASH as an example, the
> normalized address consists of bits [63:13] (divided by 3), bits
> [11:10], and bits [7:0] of the system physical address.
> 
> In this case, the remainder from the divide by 3 and bits 8, 9, and 12

I think an example like this is best kept in the code comments. And the
commit message can have a more high-level description.

"Some bits will be indeterminate, i.e., they will have multiple possible
solutions."

> are missing. To determine the proper combination of missing system
> physical address bits, iterate through each possible combination of
> these bits, normalize the resulting system physical address, and compare
> to the original address that is being translated. If the addresses
> match, then the correct permutation of bits has been found.
> 
> Signed-off-by: John Allen <john.allen@amd.com
> ---
> v2:
>    - Move map validation to patch 3/4.
> ---
>   drivers/ras/amd/atl/denormalize.c | 530 ++++++++++++++++++++++++++++++
>   drivers/ras/amd/atl/internal.h    |  40 +++
>   2 files changed, 570 insertions(+)
> 
> diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
> index e279224288d6..b03bba851e14 100644
> --- a/drivers/ras/amd/atl/denormalize.c
> +++ b/drivers/ras/amd/atl/denormalize.c
> @@ -448,6 +448,105 @@ static u16 get_logical_coh_st_fabric_id(struct addr_ctx *ctx)
>   	return (phys_fabric_id & df_cfg.node_id_mask) | log_fabric_id;
>   }
>   
> +static u64 get_logical_coh_st_fabric_id_for_current_spa(struct addr_ctx *ctx,
> +							struct df4p5_denorm_ctx *denorm_ctx)
> +{
> +	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
> +	bool hash_pa8, hash_pa9, hash_pa12, hash_pa13;
> +	u64 cs_id = 0;
> +
> +	hash_ctl_64k	= FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
> +	hash_ctl_2M	= FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
> +	hash_ctl_1G	= FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
> +	hash_ctl_1T	= FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
> +
> +	hash_pa8  = FIELD_GET(BIT_ULL(8),  denorm_ctx->current_spa);
> +	hash_pa8 ^= FIELD_GET(BIT_ULL(14), denorm_ctx->current_spa);
> +	hash_pa8 ^= FIELD_GET(BIT_ULL(16), denorm_ctx->current_spa) & hash_ctl_64k;
> +	hash_pa8 ^= FIELD_GET(BIT_ULL(21), denorm_ctx->current_spa) & hash_ctl_2M;
> +	hash_pa8 ^= FIELD_GET(BIT_ULL(30), denorm_ctx->current_spa) & hash_ctl_1G;
> +	hash_pa8 ^= FIELD_GET(BIT_ULL(40), denorm_ctx->current_spa) & hash_ctl_1T;
> +
> +	hash_pa9  = FIELD_GET(BIT_ULL(9),  denorm_ctx->current_spa);
> +	hash_pa9 ^= FIELD_GET(BIT_ULL(17), denorm_ctx->current_spa) & hash_ctl_64k;
> +	hash_pa9 ^= FIELD_GET(BIT_ULL(22), denorm_ctx->current_spa) & hash_ctl_2M;
> +	hash_pa9 ^= FIELD_GET(BIT_ULL(31), denorm_ctx->current_spa) & hash_ctl_1G;
> +	hash_pa9 ^= FIELD_GET(BIT_ULL(41), denorm_ctx->current_spa) & hash_ctl_1T;
> +
> +	hash_pa12  = FIELD_GET(BIT_ULL(12), denorm_ctx->current_spa);
> +	hash_pa12 ^= FIELD_GET(BIT_ULL(18), denorm_ctx->current_spa) & hash_ctl_64k;
> +	hash_pa12 ^= FIELD_GET(BIT_ULL(23), denorm_ctx->current_spa) & hash_ctl_2M;
> +	hash_pa12 ^= FIELD_GET(BIT_ULL(32), denorm_ctx->current_spa) & hash_ctl_1G;
> +	hash_pa12 ^= FIELD_GET(BIT_ULL(42), denorm_ctx->current_spa) & hash_ctl_1T;
> +
> +	hash_pa13  = FIELD_GET(BIT_ULL(13), denorm_ctx->current_spa);
> +	hash_pa13 ^= FIELD_GET(BIT_ULL(19), denorm_ctx->current_spa) & hash_ctl_64k;
> +	hash_pa13 ^= FIELD_GET(BIT_ULL(24), denorm_ctx->current_spa) & hash_ctl_2M;
> +	hash_pa13 ^= FIELD_GET(BIT_ULL(33), denorm_ctx->current_spa) & hash_ctl_1G;
> +	hash_pa13 ^= FIELD_GET(BIT_ULL(43), denorm_ctx->current_spa) & hash_ctl_1T;
> +
> +	switch (ctx->map.intlv_mode) {
> +	case DF4p5_NPS0_24CHAN_1K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 13), denorm_ctx->current_spa) << 3;
> +		cs_id %= denorm_ctx->mod_value;
> +		cs_id <<= 2;
> +		cs_id |= (hash_pa9 | (hash_pa12 << 1));
> +		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
> +		break;
> +	case DF4p5_NPS0_24CHAN_2K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 14), denorm_ctx->current_spa) << 4;
> +		cs_id %= denorm_ctx->mod_value;
> +		cs_id <<= 2;
> +		cs_id |= (hash_pa12 | (hash_pa13 << 1));
> +		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
> +		break;
> +	case DF4p5_NPS1_12CHAN_1K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
> +		cs_id %= denorm_ctx->mod_value;
> +		cs_id <<= 2;
> +		cs_id |= (hash_pa8 | (hash_pa9 << 1));
> +		break;
> +	case DF4p5_NPS1_12CHAN_2K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 13), denorm_ctx->current_spa) << 3;
> +		cs_id %= denorm_ctx->mod_value;
> +		cs_id <<= 2;
> +		cs_id |= (hash_pa8 | (hash_pa12 << 1));
> +		break;
> +	case DF4p5_NPS2_6CHAN_1K_HASH:
> +	case DF4p5_NPS1_10CHAN_1K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
> +		cs_id |= (FIELD_GET(BIT_ULL(9), denorm_ctx->current_spa) << 1);
> +		cs_id %= denorm_ctx->mod_value;
> +		cs_id <<= 1;
> +		cs_id |= hash_pa8;
> +		break;
> +	case DF4p5_NPS2_6CHAN_2K_HASH:
> +	case DF4p5_NPS1_10CHAN_2K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
> +		cs_id %= denorm_ctx->mod_value;
> +		cs_id <<= 1;
> +		cs_id |= hash_pa8;
> +		break;
> +	case DF4p5_NPS4_3CHAN_1K_HASH:
> +	case DF4p5_NPS2_5CHAN_1K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
> +		cs_id |= FIELD_GET(GENMASK_ULL(9, 8), denorm_ctx->current_spa);
> +		cs_id %= denorm_ctx->mod_value;
> +		break;
> +	case DF4p5_NPS4_3CHAN_2K_HASH:
> +	case DF4p5_NPS2_5CHAN_2K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
> +		cs_id |= FIELD_GET(BIT_ULL(8), denorm_ctx->current_spa) << 1;
> +		cs_id %= denorm_ctx->mod_value;
> +		break;
> +	default:
> +		atl_debug_on_bad_intlv_mode(ctx);
> +		return 0;
> +	}
> +

Using u64 type for cs_id makes sense to handle all the bit operations
above. But the final value should fit within a u16.

So I think this function should return a u16. And there should be a
final check here to make sure that temporary u64 value fits within a
u16. Otherwise, the math above could have a bug.

> +	return cs_id;
> +}
> +
>   static int denorm_addr_common(struct addr_ctx *ctx)
>   {
>   	u64 denorm_addr;
> @@ -699,6 +798,424 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
>   	return 0;
>   }
>   
> +static u64 normalize_addr_df4p5_np2(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx,
> +				    u64 addr)
> +{
> +	u64 temp_addr_a, temp_addr_b;
> +
> +	temp_addr_a = 0;
> +	temp_addr_b = 0;

Initialize these when defining.

> +
> +	switch (ctx->map.intlv_mode) {
> +	case DF4p5_NPS0_24CHAN_1K_HASH:
> +	case DF4p5_NPS1_12CHAN_1K_HASH:
> +	case DF4p5_NPS2_6CHAN_1K_HASH:
> +	case DF4p5_NPS4_3CHAN_1K_HASH:
> +	case DF4p5_NPS1_10CHAN_1K_HASH:
> +	case DF4p5_NPS2_5CHAN_1K_HASH:
> +		temp_addr_a = FIELD_GET(GENMASK_ULL(11, 10), addr) << 8;
> +		break;
> +	case DF4p5_NPS0_24CHAN_2K_HASH:
> +	case DF4p5_NPS1_12CHAN_2K_HASH:
> +	case DF4p5_NPS2_6CHAN_2K_HASH:
> +	case DF4p5_NPS4_3CHAN_2K_HASH:
> +	case DF4p5_NPS1_10CHAN_2K_HASH:
> +	case DF4p5_NPS2_5CHAN_2K_HASH:
> +		temp_addr_a = FIELD_GET(GENMASK_ULL(11, 9), addr) << 8;
> +		break;
> +	default:
> +		atl_debug_on_bad_intlv_mode(ctx);
> +		return 0;
> +	}
> +
> +	switch (ctx->map.intlv_mode) {
> +	case DF4p5_NPS0_24CHAN_1K_HASH:
> +		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 13), addr) / denorm_ctx->mod_value;
> +		temp_addr_b <<= 10;
> +		break;
> +	case DF4p5_NPS0_24CHAN_2K_HASH:
> +		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 14), addr) / denorm_ctx->mod_value;
> +		temp_addr_b <<= 11;
> +		break;
> +	case DF4p5_NPS1_12CHAN_1K_HASH:
> +		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) / denorm_ctx->mod_value;
> +		temp_addr_b <<= 10;
> +		break;
> +	case DF4p5_NPS1_12CHAN_2K_HASH:
> +		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 13), addr) / denorm_ctx->mod_value;
> +		temp_addr_b <<= 11;
> +		break;
> +	case DF4p5_NPS2_6CHAN_1K_HASH:
> +	case DF4p5_NPS1_10CHAN_1K_HASH:
> +		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 1;
> +		temp_addr_b |= FIELD_GET(BIT_ULL(9), addr);
> +		temp_addr_b /= denorm_ctx->mod_value;
> +		temp_addr_b <<= 10;
> +		break;
> +	case DF4p5_NPS2_6CHAN_2K_HASH:
> +	case DF4p5_NPS1_10CHAN_2K_HASH:
> +		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) / denorm_ctx->mod_value;
> +		temp_addr_b <<= 11;
> +		break;
> +	case DF4p5_NPS4_3CHAN_1K_HASH:
> +	case DF4p5_NPS2_5CHAN_1K_HASH:
> +		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 2;
> +		temp_addr_b |= FIELD_GET(GENMASK_ULL(9, 8), addr);
> +		temp_addr_b /= denorm_ctx->mod_value;
> +		temp_addr_b <<= 10;
> +		break;
> +	case DF4p5_NPS4_3CHAN_2K_HASH:
> +	case DF4p5_NPS2_5CHAN_2K_HASH:
> +		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 1;
> +		temp_addr_b |= FIELD_GET(BIT_ULL(8), addr);
> +		temp_addr_b /= denorm_ctx->mod_value;
> +		temp_addr_b <<= 11;
> +		break;
> +	default:
> +		atl_debug_on_bad_intlv_mode(ctx);
> +		return 0;
> +	}
> +
> +	return denorm_ctx->base_denorm_addr | temp_addr_a | temp_addr_b;
> +}
> +
> +static void recalculate_hashed_bits_df4p5_np2(struct addr_ctx *ctx,
> +					      struct df4p5_denorm_ctx *denorm_ctx)
> +{
> +	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T, hashed_bit;
> +
> +	if (!denorm_ctx->rehash_vector)
> +		return;
> +
> +	hash_ctl_64k	= FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
> +	hash_ctl_2M	= FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
> +	hash_ctl_1G	= FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
> +	hash_ctl_1T	= FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
> +
> +	if (denorm_ctx->rehash_vector & BIT_ULL(8)) {
> +		hashed_bit  = FIELD_GET(BIT_ULL(8),  denorm_ctx->current_spa);
> +		hashed_bit ^= FIELD_GET(BIT_ULL(14), denorm_ctx->current_spa);
> +		hashed_bit ^= FIELD_GET(BIT_ULL(16), denorm_ctx->current_spa) & hash_ctl_64k;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(21), denorm_ctx->current_spa) & hash_ctl_2M;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(30), denorm_ctx->current_spa) & hash_ctl_1G;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(40), denorm_ctx->current_spa) & hash_ctl_1T;
> +
> +		if (FIELD_GET(BIT_ULL(8), denorm_ctx->current_spa) != hashed_bit)
> +			denorm_ctx->current_spa ^= BIT_ULL(8);
> +	}
> +
> +	if (denorm_ctx->rehash_vector & BIT_ULL(9)) {
> +		hashed_bit  = FIELD_GET(BIT_ULL(9),  denorm_ctx->current_spa);
> +		hashed_bit ^= FIELD_GET(BIT_ULL(17), denorm_ctx->current_spa) & hash_ctl_64k;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(22), denorm_ctx->current_spa) & hash_ctl_2M;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(31), denorm_ctx->current_spa) & hash_ctl_1G;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(41), denorm_ctx->current_spa) & hash_ctl_1T;
> +
> +		if (FIELD_GET(BIT_ULL(9), denorm_ctx->current_spa) != hashed_bit)
> +			denorm_ctx->current_spa ^= BIT_ULL(9);
> +	}
> +
> +	if (denorm_ctx->rehash_vector & BIT_ULL(12)) {
> +		hashed_bit  = FIELD_GET(BIT_ULL(12), denorm_ctx->current_spa);
> +		hashed_bit ^= FIELD_GET(BIT_ULL(18), denorm_ctx->current_spa) & hash_ctl_64k;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(23), denorm_ctx->current_spa) & hash_ctl_2M;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(32), denorm_ctx->current_spa) & hash_ctl_1G;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(42), denorm_ctx->current_spa) & hash_ctl_1T;
> +
> +		if (FIELD_GET(BIT_ULL(12), denorm_ctx->current_spa) != hashed_bit)
> +			denorm_ctx->current_spa ^= BIT_ULL(12);
> +	}
> +
> +	if (denorm_ctx->rehash_vector & BIT_ULL(13)) {
> +		hashed_bit  = FIELD_GET(BIT_ULL(13), denorm_ctx->current_spa);
> +		hashed_bit ^= FIELD_GET(BIT_ULL(19), denorm_ctx->current_spa) & hash_ctl_64k;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(24), denorm_ctx->current_spa) & hash_ctl_2M;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(33), denorm_ctx->current_spa) & hash_ctl_1G;
> +		hashed_bit ^= FIELD_GET(BIT_ULL(43), denorm_ctx->current_spa) & hash_ctl_1T;
> +
> +		if (FIELD_GET(BIT_ULL(13), denorm_ctx->current_spa) != hashed_bit)
> +			denorm_ctx->current_spa ^= BIT_ULL(13);
> +	}
> +}
> +
> +static bool check_logical_coh_st_fabric_id(struct addr_ctx *ctx,

check->match

..to highlight that the check condition is a match.

> +					   struct df4p5_denorm_ctx *denorm_ctx)
> +{
> +	unsigned int logical_coh_st_fabric_id;

Local variables don't need such descriptive names. Just use "id".

Also, denorm_ctx->coh_st_fabric_id is a u16. So the types should match
unless there's a reason to use something different.

> +
> +	/*
> +	 * The logical CS fabric ID of the permutation must be calculated from the
> +	 * current SPA with the base and with the MMIO hole.
> +	 */
> +	logical_coh_st_fabric_id = get_logical_coh_st_fabric_id_for_current_spa(ctx, denorm_ctx);
> +
> +	atl_debug(ctx, "Checking calculated logical coherent station fabric id:\n");
> +	atl_debug(ctx, "  calculated fabric id         = 0x%x\n", logical_coh_st_fabric_id);
> +	atl_debug(ctx, "  expected fabric id           = 0x%x\n", denorm_ctx->coh_st_fabric_id);
> +
> +	if (denorm_ctx->coh_st_fabric_id != logical_coh_st_fabric_id)
> +		return false;
> +
> +	return true;

	return denorm_ctx->coh_st_fabric_id == id;

> +}
> +
> +static bool check_norm_addr(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)

check->match

> +{
> +	u64 current_spa_without_base = remove_base_and_hole(ctx, denorm_ctx->current_spa);
> +	u64 norm_addr;

Just need one variable and reuse it.

	u64 addr = remove_base_and_hole();

> +
> +	/*
> +	 * The normalized address must be calculated with the current SPA without
> +	 * the base and without the MMIO hole.
> +	 */
> +	norm_addr = normalize_addr_df4p5_np2(ctx, denorm_ctx, current_spa_without_base);

	addr = normalize...(..., addr);

> +
> +	atl_debug(ctx, "Checking calculated normalized address:\n");
> +	atl_debug(ctx, "  calculated normalized addr = 0x%016llx\n", norm_addr);
> +	atl_debug(ctx, "  expected normalized addr   = 0x%016llx\n", ctx->ret_addr);
> +
> +	if (norm_addr != ctx->ret_addr)
> +		return false;
> +
> +	return true;

	return ctx->ret_addr == addr;

> +}
> +
> +static int check_permutations(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)
> +{
> +	u64 test_perm, temp_addr, denorm_addr, num_perms;
> +	unsigned int dropped_remainder;
> +
> +	denorm_ctx->div_addr *= denorm_ctx->mod_value;
> +
> +	/*
> +	 * The high order bits of num_permutations represent the permutations
> +	 * of the dropped remainder. This will be either 0-3 or 0-5 depending
> +	 * on the interleave mode. The low order bits represent the
> +	 * permutations of other "lost" bits which will be any combination of
> +	 * 1, 2, or 3 bits depending on the interleave mode.
> +	 */
> +	num_perms = denorm_ctx->mod_value << denorm_ctx->perm_shift;
> +
> +	for (test_perm = 0; test_perm < num_perms; test_perm++) {
> +		denorm_addr = denorm_ctx->base_denorm_addr;
> +		dropped_remainder = test_perm >> denorm_ctx->perm_shift;
> +		temp_addr = denorm_ctx->div_addr + dropped_remainder;
> +
> +		switch (ctx->map.intlv_mode) {
> +		case DF4p5_NPS0_24CHAN_2K_HASH:
> +			denorm_addr |= temp_addr << 14;
> +			break;
> +		case DF4p5_NPS0_24CHAN_1K_HASH:
> +		case DF4p5_NPS1_12CHAN_2K_HASH:
> +			denorm_addr |= temp_addr << 13;
> +			break;
> +		case DF4p5_NPS1_12CHAN_1K_HASH:
> +		case DF4p5_NPS2_6CHAN_2K_HASH:
> +		case DF4p5_NPS1_10CHAN_2K_HASH:
> +			denorm_addr |= temp_addr << 12;
> +			break;
> +		case DF4p5_NPS2_6CHAN_1K_HASH:
> +		case DF4p5_NPS1_10CHAN_1K_HASH:
> +			denorm_addr |= FIELD_GET(BIT_ULL(0), temp_addr) << 9;
> +			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 1), temp_addr) << 12;
> +			break;
> +		case DF4p5_NPS4_3CHAN_1K_HASH:
> +		case DF4p5_NPS2_5CHAN_1K_HASH:
> +			denorm_addr |= FIELD_GET(GENMASK_ULL(1, 0), temp_addr) << 8;
> +			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 2), (temp_addr)) << 12;
> +			break;
> +		case DF4p5_NPS4_3CHAN_2K_HASH:
> +		case DF4p5_NPS2_5CHAN_2K_HASH:
> +			denorm_addr |= FIELD_GET(BIT_ULL(0), temp_addr) << 8;
> +			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 1), temp_addr) << 12;
> +			break;
> +		default:
> +			atl_debug_on_bad_intlv_mode(ctx);
> +			return -EINVAL;
> +		}
> +
> +		switch (ctx->map.intlv_mode) {
> +		case DF4p5_NPS0_24CHAN_1K_HASH:
> +			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
> +			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 9;
> +			denorm_addr |= FIELD_GET(BIT_ULL(2), test_perm) << 12;
> +			break;
> +		case DF4p5_NPS0_24CHAN_2K_HASH:
> +			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
> +			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 12;
> +			denorm_addr |= FIELD_GET(BIT_ULL(2), test_perm) << 13;
> +			break;
> +		case DF4p5_NPS1_12CHAN_2K_HASH:
> +			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
> +			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 12;
> +			break;
> +		case DF4p5_NPS1_12CHAN_1K_HASH:
> +		case DF4p5_NPS4_3CHAN_1K_HASH:
> +		case DF4p5_NPS2_5CHAN_1K_HASH:
> +			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
> +			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 9;
> +			break;
> +		case DF4p5_NPS2_6CHAN_1K_HASH:
> +		case DF4p5_NPS2_6CHAN_2K_HASH:
> +		case DF4p5_NPS4_3CHAN_2K_HASH:
> +		case DF4p5_NPS1_10CHAN_1K_HASH:
> +		case DF4p5_NPS1_10CHAN_2K_HASH:
> +		case DF4p5_NPS2_5CHAN_2K_HASH:
> +			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
> +			break;
> +		default:
> +			atl_debug_on_bad_intlv_mode(ctx);
> +			return -EINVAL;
> +		}
> +
> +		denorm_ctx->current_spa = add_base_and_hole(ctx, denorm_addr);
> +		recalculate_hashed_bits_df4p5_np2(ctx, denorm_ctx);
> +
> +		atl_debug(ctx, "Checking potential system physical address 0x%016llx\n",
> +			  denorm_ctx->current_spa);
> +
> +		if (!check_logical_coh_st_fabric_id(ctx, denorm_ctx))
> +			continue;
> +
> +		if (!check_norm_addr(ctx, denorm_ctx))
> +			continue;
> +
> +		if (denorm_ctx->resolved_spa == INVALID_SPA ||
> +		    denorm_ctx->current_spa > denorm_ctx->resolved_spa)
> +			denorm_ctx->resolved_spa = denorm_ctx->current_spa;
> +	}
> +
> +	if (denorm_ctx->resolved_spa == INVALID_SPA) {
> +		atl_debug(ctx, "Failed to find valid SPA for normalized address 0x%016llx\n",
> +			  ctx->ret_addr);
> +		return -EINVAL;
> +	}
> +
> +	/* Return the resolved SPA without the base, without the MMIO hole */
> +	ctx->ret_addr = remove_base_and_hole(ctx, denorm_ctx->resolved_spa);
> +
> +	return 0;
> +}
> +
> +static int init_df4p5_denorm_ctx(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)
> +{
> +	denorm_ctx->current_spa = INVALID_SPA;
> +	denorm_ctx->resolved_spa = INVALID_SPA;
> +
> +	switch (ctx->map.intlv_mode) {
> +	case DF4p5_NPS0_24CHAN_1K_HASH:
> +		denorm_ctx->perm_shift    = 3;
> +		denorm_ctx->rehash_vector = BIT(8) | BIT(9) | BIT(12);
> +		break;
> +	case DF4p5_NPS0_24CHAN_2K_HASH:
> +		denorm_ctx->perm_shift    = 3;
> +		denorm_ctx->rehash_vector = BIT(8) | BIT(12) | BIT(13);
> +		break;
> +	case DF4p5_NPS1_12CHAN_1K_HASH:
> +		denorm_ctx->perm_shift    = 2;
> +		denorm_ctx->rehash_vector = BIT(8);
> +		break;
> +	case DF4p5_NPS1_12CHAN_2K_HASH:
> +		denorm_ctx->perm_shift    = 2;
> +		denorm_ctx->rehash_vector = BIT(8) | BIT(12);
> +		break;
> +	case DF4p5_NPS2_6CHAN_1K_HASH:
> +	case DF4p5_NPS2_6CHAN_2K_HASH:
> +	case DF4p5_NPS1_10CHAN_1K_HASH:
> +	case DF4p5_NPS1_10CHAN_2K_HASH:
> +		denorm_ctx->perm_shift    = 1;
> +		denorm_ctx->rehash_vector = BIT(8);
> +		break;
> +	case DF4p5_NPS4_3CHAN_1K_HASH:
> +	case DF4p5_NPS2_5CHAN_1K_HASH:
> +		denorm_ctx->perm_shift    = 2;
> +		denorm_ctx->rehash_vector = 0;
> +		break;
> +	case DF4p5_NPS4_3CHAN_2K_HASH:
> +	case DF4p5_NPS2_5CHAN_2K_HASH:
> +		denorm_ctx->perm_shift    = 1;
> +		denorm_ctx->rehash_vector = 0;
> +		break;
> +	default:
> +		atl_debug_on_bad_intlv_mode(ctx);
> +		return -EINVAL;
> +	}
> +
> +	denorm_ctx->base_denorm_addr = FIELD_GET(GENMASK_ULL(7, 0), ctx->ret_addr);
> +
> +	switch (ctx->map.intlv_mode) {
> +	case DF4p5_NPS0_24CHAN_1K_HASH:
> +	case DF4p5_NPS1_12CHAN_1K_HASH:
> +	case DF4p5_NPS2_6CHAN_1K_HASH:
> +	case DF4p5_NPS4_3CHAN_1K_HASH:
> +	case DF4p5_NPS1_10CHAN_1K_HASH:
> +	case DF4p5_NPS2_5CHAN_1K_HASH:
> +		denorm_ctx->base_denorm_addr |= FIELD_GET(GENMASK_ULL(9, 8), ctx->ret_addr) << 10;
> +		denorm_ctx->div_addr          = FIELD_GET(GENMASK_ULL(63, 10), ctx->ret_addr);
> +		break;
> +	case DF4p5_NPS0_24CHAN_2K_HASH:
> +	case DF4p5_NPS1_12CHAN_2K_HASH:
> +	case DF4p5_NPS2_6CHAN_2K_HASH:
> +	case DF4p5_NPS4_3CHAN_2K_HASH:
> +	case DF4p5_NPS1_10CHAN_2K_HASH:
> +	case DF4p5_NPS2_5CHAN_2K_HASH:
> +		denorm_ctx->base_denorm_addr |= FIELD_GET(GENMASK_ULL(10, 8), ctx->ret_addr) << 9;
> +		denorm_ctx->div_addr          = FIELD_GET(GENMASK_ULL(63, 11), ctx->ret_addr);
> +		break;
> +	default:
> +		atl_debug_on_bad_intlv_mode(ctx);
> +		return -EINVAL;
> +	}
> +
> +	if (ctx->map.num_intlv_chan % 3 == 0)
> +		denorm_ctx->mod_value = 3;
> +	else
> +		denorm_ctx->mod_value = 5;
> +
> +	denorm_ctx->coh_st_fabric_id = get_logical_coh_st_fabric_id(ctx) - get_dst_fabric_id(ctx);
> +
> +	atl_debug(ctx, "Initialized df4p5_denorm_ctx:");
> +	atl_debug(ctx, "  mod_value         = %d", denorm_ctx->mod_value);
> +	atl_debug(ctx, "  perm_shift        = %d", denorm_ctx->perm_shift);
> +	atl_debug(ctx, "  rehash_vector     = 0x%x", denorm_ctx->rehash_vector);
> +	atl_debug(ctx, "  base_denorm_addr  = 0x%016llx", denorm_ctx->base_denorm_addr);
> +	atl_debug(ctx, "  div_addr          = 0x%016llx", denorm_ctx->div_addr);
> +	atl_debug(ctx, "  coh_st_fabric_id  = 0x%x", denorm_ctx->coh_st_fabric_id);
> +
> +	return 0;
> +}
> +
> +/*
> + * For DF 4.5, parts of the physical address can be directly pulled from the
> + * normalized address. The exact bits will differ between interleave modes, but
> + * using NPS0_24CHAN_1K_HASH as an example, the normalized address consists of
> + * bits [63:13] (divided by 3), bits [11:10], and bits [7:0] of the system
> + * physical address.
> + *
> + * In this case, there is no way to reconstruct the missing bits (bits 8, 9,
> + * and 12) from the normalized address. Additionally, when bits [63:13] are
> + * divided by 3, the remainder is dropped. Determine the proper combination of
> + * "lost" bits and dropped remainder by iterating through each possible
> + * permutation of these bits and then normalizing the generated system physical
> + * addresses. If the normalized address matches the address we are trying to
> + * translate, then we have found the correct permutation of bits.
> + */
> +static int denorm_addr_df4p5_np2(struct addr_ctx *ctx)
> +{
> +	struct df4p5_denorm_ctx denorm_ctx;
> +	int ret = 0;
> +
> +	memset(&denorm_ctx, 0, sizeof(denorm_ctx));
> +
> +	atl_debug(ctx, "Denormalizing DF 4.5 normalized address 0x%016llx", ctx->ret_addr);
> +
> +	ret = init_df4p5_denorm_ctx(ctx, &denorm_ctx);
> +	if (ret)
> +		return ret;
> +
> +	return check_permutations(ctx, &denorm_ctx);
> +}
> +
>   int denormalize_address(struct addr_ctx *ctx)
>   {
>   	switch (ctx->map.intlv_mode) {
> @@ -710,6 +1227,19 @@ int denormalize_address(struct addr_ctx *ctx)
>   	case DF4_NPS2_5CHAN_HASH:
>   	case DF4_NPS1_10CHAN_HASH:
>   		return denorm_addr_df4_np2(ctx);
> +	case DF4p5_NPS0_24CHAN_1K_HASH:
> +	case DF4p5_NPS4_3CHAN_1K_HASH:
> +	case DF4p5_NPS2_6CHAN_1K_HASH:
> +	case DF4p5_NPS1_12CHAN_1K_HASH:
> +	case DF4p5_NPS2_5CHAN_1K_HASH:
> +	case DF4p5_NPS1_10CHAN_1K_HASH:
> +	case DF4p5_NPS4_3CHAN_2K_HASH:
> +	case DF4p5_NPS2_6CHAN_2K_HASH:
> +	case DF4p5_NPS1_12CHAN_2K_HASH:
> +	case DF4p5_NPS0_24CHAN_2K_HASH:
> +	case DF4p5_NPS2_5CHAN_2K_HASH:
> +	case DF4p5_NPS1_10CHAN_2K_HASH:
> +		return denorm_addr_df4p5_np2(ctx);
>   	case DF3_6CHAN:
>   		return denorm_addr_df3_6chan(ctx);
>   	default:
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> index 05b870fcb24e..946e36c053c5 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -34,6 +34,8 @@
>   #define DF_DRAM_BASE_LIMIT_LSB		28
>   #define MI300_DRAM_LIMIT_LSB		20
>   
> +#define INVALID_SPA ~0ULL
> +
>   enum df_revisions {
>   	UNKNOWN,
>   	DF2,
> @@ -90,6 +92,44 @@ enum intlv_modes {
>   	DF4p5_NPS1_10CHAN_2K_HASH	= 0x49,
>   };
>   
> +struct df4p5_denorm_ctx {
> +	/* perm_shift: Indicates the number of "lost" bits. This will be 1, 2, or 3. */
> +	u8 perm_shift;
> +
> +	/* rehash_vector: A mask indicating the bits that need to be rehashed. */
> +	u16 rehash_vector;
> +
> +	/*
> +	 * mod_value: Represents the value that the high bits of the normalized
> +	 * address are divided by during normalization. This value will be 3
> +	 * for interleave modes with a number of channels divisible by 3 or the
> +	 * value will be 5 for interleave modes with a number of channels
> +	 * divisible by 5. Power-of-two interleave modes are handled
> +	 * separately.
> +	 */
> +	u8 mod_value;
> +
> +	/*
> +	 * base_denorm_addr: Represents the bits that can be directly pulled
> +	 * from the normalized address. In each case, pass through bits [7:0]
> +	 * of the normalized address. The other bits depend on the interleave
> +	 * bit position which will be bit 10 for 1K interleave stripe cases and
> +	 * bit 11 for 2K interleave stripe cases.
> +	 */
> +	u64 base_denorm_addr;
> +
> +	/*
> +	 * div_addr: Represents the high bits of the physical address that have
> +	 * been divided by the mod_value.
> +	 */
> +	u64 div_addr;
> +
> +	u64 current_spa;
> +	u64 resolved_spa;
> +
> +	u16 coh_st_fabric_id;
> +};
> +
>   struct df_flags {
>   	__u8	legacy_ficaa		: 1,
>   		socket_id_shift_quirk	: 1,

Thanks,
Yazen

