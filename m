Return-Path: <linux-kernel+bounces-129960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087078972B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A472B29A61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422DF14900F;
	Wed,  3 Apr 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kmVqKtLu"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2125.outbound.protection.outlook.com [40.107.220.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5AB66E;
	Wed,  3 Apr 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154383; cv=fail; b=iMvFA+gYPdS6siRptFoyO1a8I5n+dgOh9g6vWAxII5h0C0Hgpv7x7ZHDcvkUjvd5VpujjpbAukr3vyWEPxyu4+UUcOazJw7bv/n9O2MAzB6CoaAeu244tBUYJv6HvWaY2KeWVQsjqH6K+J4x4/uwYtxbZkd6j2E9m228iZs0jjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154383; c=relaxed/simple;
	bh=PswRIV37W7TUmGbWf7tYwG+XpCe5sfTK11n9rYMFW58=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J94vuhUn5yQmuL0YkKtwuhPS8dbvtk5hlGzSF4YT2XuL5Yc/bK8Ekzss9eH8O1+BMHbiXlFJtTKvUAlRI/yKNc5bsGKJCINIhlJMyO3G/U6QtT4+W+e9pfBcn2amJjnrl59qEJu9cpSjGz5UfF6Aeq/2pc7O/Zte8s9fKMAvgXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kmVqKtLu; arc=fail smtp.client-ip=40.107.220.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1jdmVn1yjZFTiwMRRdZwerbXDAlPncl+iiyflr6YTRkrahF/D0jnpgak7t0atwM2PdVig6igNoQnsFkBcEW5vztxjFlkWwHA3s+WuNoAVzqU/MOIQjLCZIY19oxthPPAseLb0KTQZBfQdcOF10IH+W8KvflzVS6sRu5S1m8dJ8x2PsyTy2mQq34uLSypEfV14/tj57h/CvgFzte2014eUVN1xwpgmgap9MJyJt2wCFn5/2E7oQaMlyqBWbIsVwmrHxyIio50BUz/e/HFjw/zvvLmOEu3n0SVzNhasZ1nSTq8S2WWTlrOh/HbVU5Uhtekp5XeckhsTK0iUf5PaZg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zaahjzjQfYPNKv2nzhivAGMkU2f5/ZJqU4FaSPmxkM=;
 b=RZNCUHEHXJyc4EtIWM9nIW7AJcOeA36syfpRb+oMHLUVqJ5eRWs1QffjQBh34K9CeXSy89fL2NRSaq4MeAbFiLEUnlLMZOJilhrjvwP4D92LfeD+6NhA0UH2pk3kb/HQA3D4W3FfmGCDTlv2BGtXvT2JZtTDD9bfmOv5SLX7UdP/4KOVTMA/sL0D4XWm1VtuPgx9H9hPHuY/ixsULyMiGqjh8oPw7uy1S0fGdf84QAIOnHyIRvGwtk3KcktdLL3nsrDH3n6XkFOX1/N+O6oOkoSMNb3+/rVHQKbdaUnYA9sAPSRxxivbXlQ3Ru981zMy8MqBdtmD4fN7fTuOz5GMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zaahjzjQfYPNKv2nzhivAGMkU2f5/ZJqU4FaSPmxkM=;
 b=kmVqKtLup9Q/jQUwgbp+OGP2jghOM1GcQIG2SHRwwu3wWn0pFzAc85iYFagbTAYancyqlqBuV1rBSse9E2Dse5VP9tXGq7H/BZ4n+YuaM1nnmrXMFT748CY2TEsOuEIWK3IuuCluWr+ZRSG/Nz5Jn5HVR37vQtF/8emfPxKRUYE=
Received: from DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) by
 MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 14:26:18 +0000
Received: from DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::2d67:ab86:61f6:2afb]) by DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::2d67:ab86:61f6:2afb%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 14:26:16 +0000
Message-ID: <bfa2b91f-a347-450c-8558-5c8f1fae3fe0@amd.com>
Date: Tue, 2 Apr 2024 23:06:13 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v2 3/4] RAS/AMD/ATL: Validate address map when information
 is gathered
To: John Allen <john.allen@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20240327185222.98998-1-john.allen@amd.com>
 <20240327185222.98998-4-john.allen@amd.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240327185222.98998-4-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To DM6PR12MB3116.namprd12.prod.outlook.com
 (2603:10b6:5:38::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:EE_|MW6PR12MB8835:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eG8Kd58eya3XJwKhbLR1csryGXN7jEUmC5O5bKRajexy2c9IzSZXZaaP3XBkXyT8vpasK6mPQT+d2Zv3F6iCTOx8aa+gbQ+WL0+BBKAiygRYoocfjF4h+V52Nqdq8K6TLa1gS8+9rzMU8PKA5U02jOnAEWzruVHOyKHAqpgivssPBBh05iWyXrsi6IYYd6PDAqPl7JqbCIpdL5JB7Dvk6lCgVhMT+36j0SLJqS5yjT+JTCBHhHnwnVUhmGHNT/PA4SNI+WBp7W+45gvbJNgOGULZYvQjGeQvr/TYXv90SFRBBBGcwBQUBWzPLcOsunoRPMypcH6tWStGPTdswBj6VIm6lZP8aV67V5tLgQDWgocDxQIsLNiSGPsAhspnAEI4J33GGpHOXM3sWy7xDxweWfv36WcOoB6YNJ/mylTQUqM+vsy561hy89dwMjJwhxWT3h8sr0LjM22MA9FuiA8e9aHXRsdsqooL2mDaw8ZuGJKzO0yLnibA6V0rAOUK0YhowIgMVydQoKnSoJVlLEqXvKsYpHt00IbY5ULgP8ZVnLFvsEal5k3SjuZzoaDeVJA/HIOoof7PJN7PbPDqRDOUUrN1M8iegYdOd8qHM2W/L9E6KMbS0bGLUXNnnwLI1SvFNWpRYXiQWztyaf8+o1loB/Q6rKO5cejhJp0b88Oc4Jc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1JlQjRVZHozS1dRaEpZQTFURllVYU1kUWdOaU5lL2lUUUVsRnkzb3ZYMGxB?=
 =?utf-8?B?bnM1UlNtRlJhb0UrSmRJMXhXRGdHRUovZjdtUXhlTndjUXp6aTZ5dDI3eTV2?=
 =?utf-8?B?SnFVeEs1SXUrRFVBQ3N4ckU2eUVmWXZ5OVU2VE4yZTZWZVd6QkJzdGt0Qmxw?=
 =?utf-8?B?bWZXN2tpNVFub0xTZWVLbDVuY1pTZHhrVC9tOHhhS1RWYlIyTVFIOUFVTVNQ?=
 =?utf-8?B?MlROOVRTOE9udFJYNmFKSUZMc1lrbWo5TWR6WFRPdEtkenRxZTRMNGs1bVV1?=
 =?utf-8?B?VExNKzBsV1hVRTN3M2xGY3E5M0pMNzFQNkRvTWpaby8xTUdiMy9Bakk3YmJO?=
 =?utf-8?B?N2FSbnJPMEpzWWJWd25ySUM5c2Z3UGZ4WGxZeTg3NFpsTC84RStTbWhLZ0h0?=
 =?utf-8?B?dDdtVkp2VGw2dWdPeGVVSXcyczIyT0RySndLQUZ6WWcwM2xqZWUzNm82Um1r?=
 =?utf-8?B?MjZkWXk0RUs4N0lHS2VqeHRXcDVaMFlDRTRodXVaeEVsTlN4RFMxTVVtT25u?=
 =?utf-8?B?VHVPMGE5YzF6L3UwMXR1UTRIVlhpS0s2QnNleTAybmNLTUNacm85ZXZVUEtu?=
 =?utf-8?B?dlBVaGVnejBuaW9kUkI5T1hZVlpEWVROQ3ZaNm0yTEwyMytUcmVCOWx5b04z?=
 =?utf-8?B?TG05QnUweHptRHJ2RzBzZ1dENVN1aGhHT3N4QkdWY1RzUjkxZ1ZhZGFIMVp6?=
 =?utf-8?B?UDBlak5Vb1lpUE9IeWo3YkJ5TjNyYmlJZ1FTUXRvNGVnN0pvQmZneHpmMTV2?=
 =?utf-8?B?dW12Sk5uUWRCU2NTejVTVnRTSWVZaG1jQjltLzFaZ3FCUGlWa0s2S0hIZ0V2?=
 =?utf-8?B?Z2czNHVPYkhYTHQyQkFPTHN0UEdIVDZSMHpacVcvSFRNZ3BZbGVIdVR3Q0lq?=
 =?utf-8?B?YmVoR0J4cmxhdkZKMzFGZjZjWWJhRjdpMk05NEZXQmt6dS92TkFBSGNzMXpD?=
 =?utf-8?B?L0xoWkhPU2VhbWU4ZG5IWW5HdXIwUGl6MmtOWGlsTTJaZ0gwZjdpK3pMRjlr?=
 =?utf-8?B?TEZQYnFFenVwam9ycTJPeTRISnpJd29PRXpXWlhRaWNIWWxlbVhxaE9wV2dY?=
 =?utf-8?B?cmxWY24rOU04N1NhQ1ZqWk5OcGdrcDlFZk5LdkRwblZBdHpDcmxidGJqeE5r?=
 =?utf-8?B?WllSeHB5cjZvMXNsZkRhUTFXNnBjOTh6SmlsVkdUTzlnOUZmZnRwdC83STNn?=
 =?utf-8?B?aU16b0NZV2cvRlYvY01mNm5CRk9tMEVFUDNqN2dndVA1bG01N3hsaHdEeEtH?=
 =?utf-8?B?ZFJmMUpzVkVSQUpZbEVYSlVUb1pxeUF0UXdKRlRNMTBpbGFlWHZhdlVUVFg1?=
 =?utf-8?B?WE5jdnlnMHJlZHVQOEh1SzNkNC9NcVIrZmc4MkFrU2IwSXBqZVJLN0tlOHQz?=
 =?utf-8?B?OXBTQ3FsU3EvdXI2Q05kOUdpb3VzVFl4S1hlcWxHMWphRkh2enpDL084UnBH?=
 =?utf-8?B?VjdPL2ljYTJzWHdkNVdjNDdvS3E3RmFMWnFSK3RCK2RZVXlsV09pdmFBR2NS?=
 =?utf-8?B?MjhZUjRoQm94NU5BTmNweURVaHJFN3BJaWJVN3JhZXl0dmdUSjlhQXBvRnhI?=
 =?utf-8?B?L2pTcTdkdlFac0ViV3NIeUUrUW9CZjdRbVFMYjkwbmgyK1ZZWTh6Skh0TERz?=
 =?utf-8?B?V0RxMnM2eFlmdkRDMWZRRkhYWmVxUWswWWFmWTI5anNGei9PbFZNUjZjWTNo?=
 =?utf-8?B?elhvTkpLc3pZR1Q4dnBaUXo0QkNZU05xcGVmVStXb3h4Zlp1K2k3M05lVkM0?=
 =?utf-8?B?UWVxUzlCeWd1UXFkcmFxNEtLYzhPOFVIYm84Rlo1OVZZZkVwK3I5TllURlBE?=
 =?utf-8?B?ZVBra052cnhoUE1sQk5ra0lER1NtNXhoaHRmVEtyaEU2a0xRYmlsaUU1TmFC?=
 =?utf-8?B?N2dWb2oyS1JVTTI5bTF3dXkyZjM3ZmVZd3RJUlU1TWwvUVdTc2NtQTE0cHM1?=
 =?utf-8?B?R01POS95NHJLOE5PVVE2Ly9ydlk4Sk9reURwV1B5cHpqcDNwUmR1Y3ZKK2ly?=
 =?utf-8?B?REQ5LzBqenpZT2xwSVFkWG5ja3hBOFN3dm5YL0s0RkdiNG9aSnN1RHpQYnpD?=
 =?utf-8?B?aHhDZExCREhiY1pLT3RNQVJoWVJ5b2R6Z1k5TlNsZ294OGZJNzhnRWlWOVFX?=
 =?utf-8?Q?+T6X98U1+G/jM457ZRjwz1uT4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8855a15-b4a6-44ef-a5cf-08dc53ea0593
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:26:16.2339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Kdj4+tScmQzLmYPtSQEybC59GOmJ4AiL7FgtYEnrG4ehgoP7NxXgZYY87pJ5tnAbyIy6HReR0CLNteN2zznHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835



On 3/27/24 14:52, John Allen wrote:
> The address map will not change during translation so all checks to
> validate the map can be moved to a single function that checks the map
> at the time the information is gathered.

There needs to be an command in the message (imperative mood).

"Validate maps earlier..." or similar.

> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
> v2:
>    - New in v2.
> ---
>   drivers/ras/amd/atl/dehash.c |  43 --------------
>   drivers/ras/amd/atl/map.c    | 105 +++++++++++++++++++++++++++++++++++
>   2 files changed, 105 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
> index 4ea46262c4f5..d4ee7ecabaee 100644
> --- a/drivers/ras/amd/atl/dehash.c
> +++ b/drivers/ras/amd/atl/dehash.c
> @@ -12,41 +12,10 @@
>   
>   #include "internal.h"
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
>   static int df2_dehash_addr(struct addr_ctx *ctx)
>   {
>   	u8 hashed_bit, intlv_bit, intlv_bit_pos;
>   
> -	if (!map_bits_valid(ctx, 8, 9, 1, 1))
> -		return -EINVAL;
> -
>   	intlv_bit_pos = ctx->map.intlv_bit_pos;
>   	intlv_bit = !!(BIT_ULL(intlv_bit_pos) & ctx->ret_addr);
>   
> @@ -67,9 +36,6 @@ static int df3_dehash_addr(struct addr_ctx *ctx)
>   	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
>   	u8 hashed_bit, intlv_bit, intlv_bit_pos;
>   
> -	if (!map_bits_valid(ctx, 8, 9, 1, 1))
> -		return -EINVAL;
> -
>   	hash_ctl_64k = FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
>   	hash_ctl_2M  = FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
>   	hash_ctl_1G  = FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
> @@ -171,9 +137,6 @@ static int df4_dehash_addr(struct addr_ctx *ctx)
>   	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
>   	u8 hashed_bit, intlv_bit;
>   
> -	if (!map_bits_valid(ctx, 8, 8, 1, 2))
> -		return -EINVAL;
> -
>   	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
>   	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
>   	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
> @@ -247,9 +210,6 @@ static int df4p5_dehash_addr(struct addr_ctx *ctx)
>   	u8 hashed_bit, intlv_bit;
>   	u64 rehash_vector;
>   
> -	if (!map_bits_valid(ctx, 8, 8, 1, 2))
> -		return -EINVAL;
> -
>   	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
>   	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
>   	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
> @@ -360,9 +320,6 @@ static int mi300_dehash_addr(struct addr_ctx *ctx)
>   	bool hashed_bit, intlv_bit, test_bit;
>   	u8 num_intlv_bits, base_bit, i;
>   
> -	if (!map_bits_valid(ctx, 8, 8, 4, 1))
> -		return -EINVAL;
> -
>   	hash_ctl_4k  = FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);
>   	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
>   	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
> diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
> index 8b908e8d7495..c7772733a363 100644
> --- a/drivers/ras/amd/atl/map.c
> +++ b/drivers/ras/amd/atl/map.c
> @@ -642,6 +642,107 @@ static int get_global_map_data(struct addr_ctx *ctx)
>   	return 0;
>   }
>   
> +/*
> + * Verify the interleave bits are correct in the different interleaving
> + * settings.
> + *
> + * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
> + * respective interleaving is disabled.
> + */
> +inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,

Missing "static" keyword.

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
> +	case DF4p5_NPS4_3CHAN_1K_HASH:
> +	case DF4p5_NPS4_3CHAN_2K_HASH:
> +	case DF4p5_NPS2_5CHAN_1K_HASH:
> +	case DF4p5_NPS2_5CHAN_2K_HASH:
> +	case DF4p5_NPS2_6CHAN_1K_HASH:
> +	case DF4p5_NPS2_6CHAN_2K_HASH:
> +	case DF4p5_NPS1_10CHAN_1K_HASH:
> +	case DF4p5_NPS1_10CHAN_2K_HASH:
> +	case DF4p5_NPS1_12CHAN_1K_HASH:
> +	case DF4p5_NPS1_12CHAN_2K_HASH:
> +		if (ctx->map.num_intlv_sockets != 1 || !map_bits_valid(ctx, 8, 0, 1, 1))
> +			goto out;
> +		break;
> +
> +	case DF4p5_NPS0_24CHAN_1K_HASH:
> +	case DF4p5_NPS0_24CHAN_2K_HASH:
> +		if (ctx->map.num_intlv_sockets < 2 || !map_bits_valid(ctx, 8, 0, 1, 2))
> +			goto out;
> +		break;

Please move the new DF4p5 np2 cases to the next patch. This patch can
then just be rearranging the existing code. And the next patch can add
new code.

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
> +	}
> +
> +	return 0;
> +
> +out:
> +	atl_debug(ctx, "Inconsistent address map");
> +	return -EINVAL;
> +}
> +
>   static void dump_address_map(struct dram_addr_map *map)
>   {
>   	u8 i;
> @@ -678,5 +779,9 @@ int get_address_map(struct addr_ctx *ctx)
>   
>   	dump_address_map(&ctx->map);
>   
> +	ret = validate_address_map(ctx);
> +	if (ret)
> +		return ret;
> +
>   	return ret;
>   }

Thanks,
Yazen

