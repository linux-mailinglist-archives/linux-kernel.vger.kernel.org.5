Return-Path: <linux-kernel+bounces-151742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1388AB342
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615961C20DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA02130AFD;
	Fri, 19 Apr 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="15Y9IbR8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F24130A6B;
	Fri, 19 Apr 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543661; cv=fail; b=SeiGY27MAPp91uFYeeb4C/7pv3v50PCAtp2aU/w036cS6O3x2n0KgLIQM723VDO0CksOA5YAQm+SXbyg3UvjuQF8a6vhorqo+joYYDaPEk9dbliIpnpHMwa9PNlwY7nULnZWVbCvYMOpBhY69J2QX9hQDpNyU6zKcc72IhlvLfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543661; c=relaxed/simple;
	bh=SY3BPx2WnV/kC1RnQePEDaftcMfOdHTOgTUbfja+l0o=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TatqVbVSnw2ECAWB3sRkVsqo+AvQ0xMB9o8u7sft7TaxbjRWm9QUGdmFBRweDk7qDioz3MZU/5GqpGRjYIHF/haTe/kqNKLUXsFcEWtIztA4JvEylPbmWRPCdbTXtQLeBHBX4hPHY8N74zcytDz8hqJ3tOmXNmeUaUJyS92xnNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=15Y9IbR8; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWAbNeypVMzBo2+o2WA+WUaqYGQ1RNmMq9Cgv3ST8gyKbQUNkh8F3jnxSWHe2ivD58jmODEa57PqvY8iCkM0P8IVVCPEkzWnnB5uESOv82e0MJ2h3htDcTgcDMOBuOz6IkHkiO53eOT99E5D6GziDKLp3T2rF5lGi7UXExjcmhC54hC1fTwrCbSG1fl13Lwyu9/hS7S1b7N6uolMdmOANEcnyBckNFP+nInZq/oPTjYRIOxizd7+PxvpobGNmn3Q3JQ/f/pIFEy1Xa0gJxEo/mXm/xbvEpL8yWlNwxdRQJZeYbmHQVSyFpb2CWQ9oFHJA6touur3h0qgZwerqhetuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZQEy1AHRmhQ0FL1BsgR2bCdGdujbvwEHWBSC6b4l8g=;
 b=Pcb5b9knvDxn62ez4QN1hkE8mUsnK/F4sNGmzj06IC/WUkpy34iI/jGm3nCcGB9IHlnkLwqH/M0KWq9CDWOfenQTuKlAS4Xci/U7N07xjp3cnHztqUSUuayM9+eJoVBbf8WC8ZU+bcj/jJt/YPmGoLhIUzdRxLmFtyjpq/MPqHZI043rQMho2h7RFWwLKt12AoY7BzqYeFiQTiI/OLjze1G0qRrNsoGiY9gw9DbrIrEQrB4f7Zlnn+7MA5njtaVnqmAn1TNYiGMviyy3Btw+qUW9mBNwwZTH8Kd5KpCnJzIjGSP1WyWhJpupQ9UygAJS3S8jYYiFuXSQZAZARG9swg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZQEy1AHRmhQ0FL1BsgR2bCdGdujbvwEHWBSC6b4l8g=;
 b=15Y9IbR8qVldjk98O1CijNKNheO93E614kjC4z5HEzO0++y7qwMU8APthjQ5OYveYio+xiMeHSLaiGeIj+qNsPM0GeKu2GFGJ/64IMH+19/eZV+24Gc50JeqcrwT+3GZU2CZl+rWpoMCGHdIZEn92jyIcLv5pP2ekahsDtTd7zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 16:20:55 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 16:20:55 +0000
Message-ID: <27fadd8a-d5a7-4b65-a2ec-c1aa04a15048@amd.com>
Date: Fri, 19 Apr 2024 12:20:53 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v3 3/4] RAS/AMD/ATL: Validate address map when information
 is gathered
To: John Allen <john.allen@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20240418161417.6091-1-john.allen@amd.com>
 <20240418161417.6091-4-john.allen@amd.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240418161417.6091-4-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:408:e9::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b0163d-4148-47dd-f732-08dc608cb085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yfdQYMktmWkmCCGF8Po028LkLp+v4wAUUvKWgniPN9zLo+xdJrz2Ds3suIZ6xdqtkA72MqD7P9bTUpdatUPlmyl59cNuxyJv7TMdmU6io5rYk7M6kjZ51JjWVcu84t8odJ9QVh5h4e8C064UPCkP290kxpYztzeS5ixff6YFYTNX006xzAw9E4SPKsZeleUGsZ5Jxf64Lerb2GyoqjHGunX0j+VatcoHLpQHYCNWRkCwAU464qIxyEPELMgoU/nJf2MsdwiiLpUdqfjppzB7gqKthNKfswZNCI+/D59XuUDiOjeFD0W9rv8SUDRNpCfG/5gWSZrGlHRr7bWTBLIL03IXKMWVr+4qzbhzf87YBck/FkvZE3pGdg+siOiIXL+tdeTwSl70fEDPz3N3tnJF/87YGQx5Sa3tOAHWzGRCnuTRCA+MZXtE6J85QTg8UgH0wCuM9fuinm2dwGVVci8QcPbhDwhGX9ZyF0AjDBNHUCiW5yQV2QCDVtnRrbuI1q9yJ3DNATThDRzYcGDylLn8j93O/KSbAQxlxwbPC2pGNnPsdkTK5BX9haFefkILkEZZh81pCExQyxY+3aweQh462rL2TwASO6286HyUoOeyuB5ENeF4wjZsV7uLQoTpwG6rXsUnM2rwSZBdfK0xH43WvNpuojp57m6fGa8aJ23LvmA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2hsVFVIVUo4eWtSZGRPQ1loL0RqZXlzdFRPdCtwd2RNY2JqZ3FHcEZ2QTBB?=
 =?utf-8?B?cGVMbXdRdDVDNVZSSE5HWVd3Y1BsZ0U5Rjl1US9wTDdQcHVuWG9KNyt4VmJ0?=
 =?utf-8?B?Y05aOEhFa0g2d2pJUVIwSnlvQjdjb01DTzgzN1JRUG00cFNsa0ZUVk5BOGhD?=
 =?utf-8?B?OTRHMFMzWnRlVVYvVTBCbnpaZXlnMW0zUkFEa1U5eENhK1dDVVFDbXVDdHlX?=
 =?utf-8?B?TDdYQ1N0dXRMcUROMm1LVE9YR3RtZ2pzRFRDS0JUTTdBdUpDUTN3amRXaTNZ?=
 =?utf-8?B?enkxQnpVck55UWpmZFRZWWxEdkltS3RGMzZjTndwSytvVTVVUmZGeDhSY3Yy?=
 =?utf-8?B?RlFyeEtLWHJTSVhqV3BGSnhpZmtkRitSbEJkQlYxQzVKTk1LN0dKY2IwR1FZ?=
 =?utf-8?B?RjgvVUlHNDFZNVVITkkxRWw3Vk14VzMrSDBFOXBVVjFYWkJTZE90TVFNSlhM?=
 =?utf-8?B?THpraDBVVGEvdmlDNGN1OWdVUGxyR1BqQ2FLaXNaTmJBd3JCdFRhZUkrc2wv?=
 =?utf-8?B?SWh3Z2JTYTRWb09ydHBsanRKMDRqRWIrVVM5dHhyTUxCbFdVNWJuVGsvVWlE?=
 =?utf-8?B?Mi9VdkhpeTZvVmdSUlhUc2JiaHJMTmtYOHVlN0UxZ1dQV05yblEvcit6V2hJ?=
 =?utf-8?B?SS80U1RiaWNHa2p2eTVQUTMvRWZBTzdTM2JUZWFFL1ZBVE5XRU9QTUZBQk1J?=
 =?utf-8?B?enZ4SDdRRjFMNEo5dUJFOWt5RS9PelgySjdGc2dORk93Y3VRbnBHTFM4dktu?=
 =?utf-8?B?ZTlsekZsOWJpVnkrV3l3dm1mMnVRMi9qSEk0MjNFVTcxditYeFEzQS9HQnQz?=
 =?utf-8?B?dk04RUZDbGF4aDJPQWpYWWRCOWlkMlI1RDNTRWFvUFhxZW5rLzR0MGtYangr?=
 =?utf-8?B?WE9Ucll5MzBmTkYrYWhSdVJWN0VkbndpUnE0U1hRVjFmTncwbGx0ckNJMjJY?=
 =?utf-8?B?MjROa1ppTm5OSVRDOExrcTRLUWhhbnByZEszSWpMdGdmTWs4amt3SnVyVERW?=
 =?utf-8?B?bDAyWVc2L0pqbGRiWE5Rb1hwNDRIMnUrT2VoOXczYmkrOHpJWEkrZXhBaWtF?=
 =?utf-8?B?OExlMEdNdS9XOHdxUnhkdVZ1YnllZXZvMlhXVHZPRDZhWmk5Qmdvd0hBV3FL?=
 =?utf-8?B?Q09ITzNxWFFLYm0xWlVtMUpoMFM2a25KdVY0ZzRlVDhZL1NlaGVZN0RXV0t3?=
 =?utf-8?B?N1hXMHZiWWtHdU1KM3haK1IwaGRxM3RpUHFWcDcvekF2Wlh5cmVFWC9jMVpL?=
 =?utf-8?B?akRlMGIxOU5MZkt6QXNEU0hSOGJNK3A0TWhYZTVNSXFZWmhzemFLUW9uZjhC?=
 =?utf-8?B?M1lwUkJxL1ZEdjl1UGwzamRZZjNPekZUNVNHS2JXMG8xRUhnRmx3cjNYbERC?=
 =?utf-8?B?QUFEYlovL05tdFk2S016U2dFRU44K2ZpdWJJVWFoZ2k3RzNPL2NjS29ySG04?=
 =?utf-8?B?aTNiVmJqc1UwWGZEWkQrV2xSZkJ2UnNGTnZPSWt6b3l6dVM5SklnVW5PMVAz?=
 =?utf-8?B?SDB3cVlhbHZwUWhLd29PaU1ycHVTYlVrbVF5YmMyTU9CMGhBc2V1SVlQZnVG?=
 =?utf-8?B?OFRSSjMyMzZkYThjY2Nzd3F4YzRmWlZYUC9qd1VLWjZ2QThHSXVqZ2ZmdWJG?=
 =?utf-8?B?M2V2d2xkODVQRjFkcWlzNkNlWThiMisvN1VPMnRFWXkwTW1HRXA4QUNLTG40?=
 =?utf-8?B?ajFYUUVzRnA1TFdZSk1UR0pnaDByOHFLNzNmbUFDTTBTSGFFWjArMFVUSll0?=
 =?utf-8?B?bGlJcUM1dkRrTHppQnJ3S1BXMFZ6QVVtYjBSVmk0RlhxZCtIMjZ2ajVJRE84?=
 =?utf-8?B?d0YxZzhDcU5yck5pR0NtaU1WUGxKZDl4NE5sSFhFTHlKdDJwT01aS290ZlRu?=
 =?utf-8?B?MzZwek9pMkgvOFdIcTdNNEx3NURpaEdJWWNxOGExcGdsZWk5TzhTdk5oMDJ6?=
 =?utf-8?B?OTlEQUFDTjdLcnFCcUxDQVhYZ0pDbDA5K0ZsR0lyRzNMVWxjRFpPa2QwN2Rn?=
 =?utf-8?B?RVkvUEIzcGtaMlZxT0p1czc2cnJqc1ltdGg4RE4xQ3QvZ2Fxb29UVm42MUts?=
 =?utf-8?B?cVhlSGdOVkVrODVnWUU2bnlQbE93ZnZtZUwvRmtqRzBZR2FualJsb0ZPUFBj?=
 =?utf-8?Q?Xackit8e01y6804xDHYBp1WB9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b0163d-4148-47dd-f732-08dc608cb085
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:20:55.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4KbhHhT40ioYcdzXIchTgfz8jUhBL7BIS3j0kstaiplIShqWIjkREkfXBR5U30+09F1mKyKciH9olRbkGaskA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052

On 4/18/24 12:14, John Allen wrote:
> Validate address maps at the time the information is gathered as the
> address map will not change during translation.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
> v2:
>   - New in v2.
> v3:
>   - Move DF 4.5 np2 validation to patch 4.
>   - Update commit description.
> ---
>  drivers/ras/amd/atl/dehash.c | 43 ------------------
>  drivers/ras/amd/atl/map.c    | 85 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
> index 4ea46262c4f5..d4ee7ecabaee 100644
> --- a/drivers/ras/amd/atl/dehash.c
> +++ b/drivers/ras/amd/atl/dehash.c
> @@ -12,41 +12,10 @@
>  
>  #include "internal.h"
>  
> -/*
> - * Verify the interleave bits are correct in the different interleaving
> - * settings.
> - *
> - * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
> - * respective interleaving is disabled.
> - */
> -static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
> -				  u8 num_intlv_dies, u8 num_intlv_sockets)
> -{
> -	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
> -		pr_debug("Invalid interleave bit: %u", ctx->map.intlv_bit_pos);
> -		return false;
> -	}
> -
> -	if (ctx->map.num_intlv_dies > num_intlv_dies) {
> -		pr_debug("Invalid number of interleave dies: %u", ctx->map.num_intlv_dies);
> -		return false;
> -	}
> -
> -	if (ctx->map.num_intlv_sockets > num_intlv_sockets) {
> -		pr_debug("Invalid number of interleave sockets: %u", ctx->map.num_intlv_sockets);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  static int df2_dehash_addr(struct addr_ctx *ctx)
>  {
>  	u8 hashed_bit, intlv_bit, intlv_bit_pos;
>  
> -	if (!map_bits_valid(ctx, 8, 9, 1, 1))
> -		return -EINVAL;
> -
>  	intlv_bit_pos = ctx->map.intlv_bit_pos;
>  	intlv_bit = !!(BIT_ULL(intlv_bit_pos) & ctx->ret_addr);
>  
> @@ -67,9 +36,6 @@ static int df3_dehash_addr(struct addr_ctx *ctx)
>  	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
>  	u8 hashed_bit, intlv_bit, intlv_bit_pos;
>  
> -	if (!map_bits_valid(ctx, 8, 9, 1, 1))
> -		return -EINVAL;
> -
>  	hash_ctl_64k = FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
>  	hash_ctl_2M  = FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
>  	hash_ctl_1G  = FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
> @@ -171,9 +137,6 @@ static int df4_dehash_addr(struct addr_ctx *ctx)
>  	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
>  	u8 hashed_bit, intlv_bit;
>  
> -	if (!map_bits_valid(ctx, 8, 8, 1, 2))
> -		return -EINVAL;
> -
>  	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
>  	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
>  	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
> @@ -247,9 +210,6 @@ static int df4p5_dehash_addr(struct addr_ctx *ctx)
>  	u8 hashed_bit, intlv_bit;
>  	u64 rehash_vector;
>  
> -	if (!map_bits_valid(ctx, 8, 8, 1, 2))
> -		return -EINVAL;
> -
>  	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
>  	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
>  	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
> @@ -360,9 +320,6 @@ static int mi300_dehash_addr(struct addr_ctx *ctx)
>  	bool hashed_bit, intlv_bit, test_bit;
>  	u8 num_intlv_bits, base_bit, i;
>  
> -	if (!map_bits_valid(ctx, 8, 8, 4, 1))
> -		return -EINVAL;
> -
>  	hash_ctl_4k  = FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);
>  	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
>  	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
> diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
> index 8b908e8d7495..94c5f665d5bc 100644
> --- a/drivers/ras/amd/atl/map.c
> +++ b/drivers/ras/amd/atl/map.c
> @@ -642,6 +642,87 @@ static int get_global_map_data(struct addr_ctx *ctx)
>  	return 0;
>  }
>  
> +/*
> + * Verify the interleave bits are correct in the different interleaving
> + * settings.
> + *
> + * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
> + * respective interleaving is disabled.
> + */
> +static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
> +				  u8 num_intlv_dies, u8 num_intlv_sockets)
> +{
> +	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
> +		pr_debug("Invalid interleave bit: %u", ctx->map.intlv_bit_pos);
> +		return false;
> +	}
> +
> +	if (ctx->map.num_intlv_dies > num_intlv_dies) {
> +		pr_debug("Invalid number of interleave dies: %u", ctx->map.num_intlv_dies);
> +		return false;
> +	}
> +
> +	if (ctx->map.num_intlv_sockets > num_intlv_sockets) {
> +		pr_debug("Invalid number of interleave sockets: %u", ctx->map.num_intlv_sockets);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int validate_address_map(struct addr_ctx *ctx)
> +{
> +	switch (ctx->map.intlv_mode) {
> +	case DF2_2CHAN_HASH:
> +		if (!map_bits_valid(ctx, 8, 9, 1, 1))
> +			goto out;
> +		break;
> +

This case ^^^ is the same as below and can fall through.

> +	case DF3_COD4_2CHAN_HASH:
> +	case DF3_COD2_4CHAN_HASH:
> +	case DF3_COD1_8CHAN_HASH:
> +		if (!map_bits_valid(ctx, 8, 9, 1, 1))
> +			goto out;
> +		break;
> +
> +	case DF4_NPS4_2CHAN_HASH:
> +	case DF4_NPS2_4CHAN_HASH:
> +	case DF4_NPS1_8CHAN_HASH:
> +		if (!map_bits_valid(ctx, 8, 8, 1, 2))
> +			goto out;
> +		break;
> +

Same here.

> +	case DF4p5_NPS4_2CHAN_1K_HASH:
> +	case DF4p5_NPS4_2CHAN_2K_HASH:
> +	case DF4p5_NPS2_4CHAN_1K_HASH:
> +	case DF4p5_NPS2_4CHAN_2K_HASH:
> +	case DF4p5_NPS1_8CHAN_1K_HASH:
> +	case DF4p5_NPS1_8CHAN_2K_HASH:
> +	case DF4p5_NPS1_16CHAN_1K_HASH:
> +	case DF4p5_NPS1_16CHAN_2K_HASH:
> +		if (!map_bits_valid(ctx, 8, 8, 1, 2))
> +			goto out;
> +		break;
> +
> +	case MI3_HASH_8CHAN:
> +	case MI3_HASH_16CHAN:
> +	case MI3_HASH_32CHAN:
> +		if (!map_bits_valid(ctx, 8, 8, 4, 1))
> +			goto out;
> +		break;
> +
> +	default:
> +		atl_debug_on_bad_intlv_mode(ctx);
> +		return -EINVAL;

This catches valid modes that don't have validation checks. We should
drop this. Please see diff below.

> +	}
> +
> +	return 0;
> +
> +out:
> +	atl_debug(ctx, "Inconsistent address map");
> +	return -EINVAL;
> +}
> +
>  static void dump_address_map(struct dram_addr_map *map)
>  {
>  	u8 i;
> @@ -678,5 +759,9 @@ int get_address_map(struct addr_ctx *ctx)
>  
>  	dump_address_map(&ctx->map);
>  
> +	ret = validate_address_map(ctx);
> +	if (ret)
> +		return ret;
> +
>  	return ret;
>  }

Thanks,
Yazen

-----

diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 07de50017315..75be1434505b 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -731,9 +731,9 @@ static int validate_address_map(struct addr_ctx *ctx)
                        goto out;
                break;

+       /* Nothing to do for modes that don't need special validation checks. */
        default:
-               atl_debug_on_bad_intlv_mode(ctx);
-               return -EINVAL;
+               break;
        }

        return 0;




