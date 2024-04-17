Return-Path: <linux-kernel+bounces-149131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE118A8C43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12671F2241A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC2364AE;
	Wed, 17 Apr 2024 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zs352ggl"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC42C19D;
	Wed, 17 Apr 2024 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382818; cv=fail; b=Gzg0PBvhNZMpvjRyAq0UnRW75EIVFG1R94ahbcB/Zq6RC2KpqE4Kp6kgoN3OKpRVnD9oGBZbAWoD9AfylvBzSrmnvCcbiBzzr78h9+I6fIARSpTO6lSFhK9PQ6rNo4MLbGA/xqunAjiSbTQPQxSLpOHEzGL4JJBLAya7mFb4kt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382818; c=relaxed/simple;
	bh=X365luwHRxiSEcUQgA8kqf0DNVsmE16Ln0HYdP9rNQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kxuIZ08K0HNhtaCprUFZ2jJDNEoZXl/eZomEoCTpeROAU+h51YQrB/i9z5s+artCExyXDpgjkkBc0Emv/4ixoV1c6EuYaQfsl/DvKzIo8+iH+nM2MAL+2b9+nPJQMh9RusyGaI7Lq8qWYnT8dbUv913ebZ9otlklmLcZKpzCtSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zs352ggl; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtwZDE5dK5mxVAu6vy5NOL4vLIK45TOGof/4GcR813kdhng3gaz6SqJAD1L4HxK+ulu99mmAsmCYmxWip3N2hhl2xh6Xfj5jb5AxfGTMYiimSSR25j3r6sxy15p0RJg8jkOVLAH9YH8BIVymozc8hmZK0XqffjEb4QwoX0jZh3Xko4bcaEVjc+3Abnt9M9063An5DoLFpZDuTYXDgLhZRk51XeeEKuRDNJHhmIppJ5XW9Uks+sXRTX2F+OCZ9tTswA4boZGk3dIczk0zliMvPHzCriVz0J65Ckrhpozr/Lb5nNSw/+t8Zgiu9oanHXrcmRh9KSMr+IBoyGEOW/DqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGSw/MYAePtVMSh+uqPfaz53K/TtX2DW9/JdAivn//U=;
 b=YBpMwU/XLJ9uKy1ZqvD9EXARY44EYxnH6ha/EpLgqEw+z/I2C5mLtwESIohjK//SeCmELeXuRIpFQCI64rwjQE1/qZVLNx7t0uuBs+q/l79QeT8ZoJfBD/lcLnmNMurAeVUVdm+Fu/dVae+LVOHu7G+lhcCyFWs+FSsWCummqhrYfhyaiEGq05ZPwey7vYr8ErG35ytA6Z6RR5BrDsS2EeI0D6NxsKDl3Wklyfd4oO1x+yyEguebbwPjDPtiw58hvV/oS17ViThpWpEv3RXiGLpJbhC/ZC1JQdfwSJRl1NXBXndTv5J47yV+T1XFidXGzP3M+xcrmjvHRDBeISSxfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGSw/MYAePtVMSh+uqPfaz53K/TtX2DW9/JdAivn//U=;
 b=Zs352ggluYYG6HAwDBTRKc1sY/u7tPazTz6tMSVuciqDktMQcLsEsLcw5CO+qe+CGrh+lVyWtvb5SHqZ3RJxbN49burvU4JPonXtrZAJJH2vyt7h7B/1ewOviVfbKg9MUXFx/qe39yczMtEBqt8zLqAL7l5iepksBPolH5B4P4rY0Mlt1k+iKErxET1xbLOypkYgdwcfRyyBi0dfqph1+xGrbH4XG/7YBrO0zJz+TQslqlWnC6OQgSuRVmH67hkGhce/RpeNGGmhc2nNKEeTSdzkvnKoVh1qSEX1A+acAAauMg8AS+hizPWpwkNRwQOXeQJQnNra10qGpdP4FH9Y2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 19:40:14 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 19:40:13 +0000
Message-ID: <2698d178-a5b5-4f6a-80ae-e1d1d17495c2@nvidia.com>
Date: Wed, 17 Apr 2024 20:40:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: tegra - Fix some error codes
To: Dan Carpenter <dan.carpenter@linaro.org>, Akhil R <akhilrajeev@nvidia.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Thierry Reding <thierry.reding@gmail.com>, linux-crypto@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <ec425896-49eb-4099-9898-ac9509f6ab8f@moroto.mountain>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <ec425896-49eb-4099-9898-ac9509f6ab8f@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::35) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: f81523bd-6b01-493a-210b-08dc5f16336d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9sVnVLvPhl0rWe0z70ucNfUzHKDX6zTWY/UxVQ43DbcatE/IH8dV0QtWHjqvbHi19d1tbodMgoHRd1D79qMNilY85qDXmDyTFLwIWtJBitrPx4QLx1kkNvJVdb2c0jK6ngGnBzjG+kboBOxlPLxGHAaQWKyQ/hFc+IEHpBrFAD7o1uEFNWY4nPe5Nop7hECeO2fdpdaSUqbGfIPS2oSvlAL47zgtj+8uD9eC1zYMZDZlvBltTSaSKtQJ7AvrjZ7F78RxqDZqdkCdyz2fqBeY/Z4aU/xgRZW4yo3EobX7e2tswumiTy2uFaxFCDNeTN3BlC+1Onep6R58O6oNmFf0kIuSI9lFacf3u/kBEOD5opzXWRc9Ah+LZvsxgZbfvWJhU+I1RO0u3WHaKptMugOht4sewcOsqa8w6lrsHJQdQkZJ/F5xhT5n/10CRiIpPQl9BorPFh558sSniALokLUk6lzMsM3WEuAMHckIjSYTWulTjhxVjasUCGTKaWb0lOFvbOKNDWcmritfXOpFOAdfR/7WpQ3bZmFgeBSYD01MVqvEbhD9raFsGpenAB7FZXxCM+tqDrxFsABXoc0yxPagUa4RbOp+M69QHwbLfmAzkLshmCiIRM9yhQHpdzXU5YufMqquRDgWzoT2BAE1lxEamraGhNbUBi+CRLAiZOqIQkU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEE5ZW1uOTArNU95dmhwTFBqK0lmMDEzcHZ3ajZxQlpmVVdHSHlBUzZpLzVJ?=
 =?utf-8?B?TmhreWUvRHd5bHd1aVNoNWQyQzUrNzloL3QvMjk1cUFHYS90Z3hFRTZlbDd6?=
 =?utf-8?B?czlzR2ozV0N3UFdLbXJjU25kQ29XV3czQ0hMbUpqMThQRDBNQUNWMCt4OTlr?=
 =?utf-8?B?bWpHbndYR3czdW9USk9RUmVDRG9LNmFtSE5UV0sxQkNXTUFOSHVxMTBjZ0FH?=
 =?utf-8?B?OHh1YWhXbmRRMkZhd25LTlNRc0lONlU5VmFHZDcxQ0xZT1VmR2pBN2FpaTF2?=
 =?utf-8?B?Y0g0K0tSMkx5N0NELzR0SzJURDFJbVVGNHNsZG05aG9DMVpiUDhpNlcyeWMw?=
 =?utf-8?B?bURBcWY0ME5qY3FWNFNocWhPRENwdG1EVzJ4eWg2UCtneWtiOThURUNqT3VR?=
 =?utf-8?B?akN2dDJ2bVZsNUdCZ3FlZ1k4Q09IQ2VFOG5ESVZHblM1UEJsblVtd00wUEpt?=
 =?utf-8?B?NFVNODZTWHNmSjVzeFR0Nk5VVXc2akRDbEJnekxxTHErdEY2TGhoYys0L2VE?=
 =?utf-8?B?VmV1UmpVcUVYSmU5dUREdllZa3pPVmR2cHpzRnRSaWUyU2cxQXg1UENUWVlZ?=
 =?utf-8?B?NmN1VFZLaXBRcWFzK2EvUDdaY3ZWTWVvcE84dktqbnBScmpnUGNiOGtEai9r?=
 =?utf-8?B?d1Y1aTdmRjBMS2F3MjlCYVVOeFJaYTdlb0xFZjZsY1FaYURac09nWGZ3V01U?=
 =?utf-8?B?WlRwYVZHRXhXbnV0cGMwUEx3bUNUcEFJaGduODZvWExKc0c2VWxhdmtueHBQ?=
 =?utf-8?B?YVR5eTlqaFltZnBjVWhnUVI3MHFnS0hZUHhSOVl6ZlRxcFBoVk5mSHZVNkg4?=
 =?utf-8?B?Nnk5T2Z1d09BNGdFaXhxdDdjV212b0RaY010a0cwTVpEbm1CWWN2UlA3ZTV3?=
 =?utf-8?B?Wk1LUm02d2Rsa3dMWVU4cU9JZ2ZzOFNxNHEramZpUDZLUWlGcFVrRE5Hc2NM?=
 =?utf-8?B?UEdSeGlSWWxtMnZoRUNhNFlHTU1kNDYwVE1INkVNU0RFeXpQYUIwS1pkTkxW?=
 =?utf-8?B?VmpsNlYySDZNNWxSMVhGSVRCYkdrYit2RjVEanQ0Nmd5RjBpQ2RmRmw4SXdL?=
 =?utf-8?B?b05maFZXTS9YQkJuQ0NZREZvUlhUV2ZkV0daUzFibURGNlBmS3VQQ1Z3ZlpR?=
 =?utf-8?B?bC96N1lmcnMxSnZRUk5TVzBHRjNTSHpPZW5aK0RQc3FIVVRJMCtzai9hdHJ3?=
 =?utf-8?B?STBMbGNHT1QrNndSY3RoYUhXZUpZOXlaMHRqK3c0ODcyY1VFekpDVG1oN2Qz?=
 =?utf-8?B?aTltQ2E5bDA5YWU1KzFyaElhTlh3anRSYmlmTVMwc2F5MkFYSGVnZitLeUkx?=
 =?utf-8?B?TWpNUmF2NUVHMW1qeWxnWVcyYnhkUkNNU2svby9OUm9pSVF3UkdxTTE4M3ov?=
 =?utf-8?B?YzAvZHhKMktCTmVqMkVwd0U2NzFseTljdjVjbERSUjFLcmlJMHM2cW15L2Vi?=
 =?utf-8?B?M01lTTNyeDJrcEREZ1JsZ0tQRU8vbFFMbWZrdG82NjdvSXliTXFhbnVLNFVV?=
 =?utf-8?B?aXdPU204MFRLWGwvN2FPVDZ2TWJPWEJWTUQ3RlNTZUhLeTVZeVBManBITEc1?=
 =?utf-8?B?L3kwdUg5RWIyMUlzV0UvSWNtU0FSSWgwM2dHS3RKMXl2OWRrK2pNeEw2SVZ1?=
 =?utf-8?B?Z1NkNWR0bjl3MjI1aDdXVXFmL1V1cVZiek50TnowbjY0cTVZTmcxK0gvZXR5?=
 =?utf-8?B?dS9OTDBuaGlUbURJVnhxeU5iODB1WUhrbHQxOHN6NjRGUit2cEM5NGZxOE8z?=
 =?utf-8?B?S2xxOGpEdnJ0aVF0azdQNG1iTU9tckRVNUZXNE0zYTdqUHpyYnBkdVhCV1ZQ?=
 =?utf-8?B?NWFSeXNENnFNdW1oVmdZUVJ2ZWxVNWFSOSs4UzJhS3lTczBRWlh4dXA0QU9C?=
 =?utf-8?B?TVNrcjVrVjdVeGZiNzBDM1ZXV0MwQlFEcTVKazdQY3NlRmhaRFJ4UjJ6dTl0?=
 =?utf-8?B?L2VpQS9LaU94M0FNaTRPQmV2TEtLbkNaT3QrTjNVNUM4TzUyUS9DS3E0M0Vk?=
 =?utf-8?B?NVJZbyt1L1NVYkVoelgwSFhHU1RlMkpmcmdmNTFYS0pnTndSNklaQ3dqRmhB?=
 =?utf-8?B?T0lDbitkaXkyUUxrMHY5YlBUS0dtQzBDUDl3SW5BbkZqMWJIWXFKMk92R0Fm?=
 =?utf-8?B?a2dhN3hydHZvVm1UVmlpWEdPRFpnTUpsb1N3M1NkNk84am5vSmxHai9qR2xO?=
 =?utf-8?Q?5FYSBQDoyTKbRWhtAmB+BDaR08vzDsn5bpvTT0AkdWzf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81523bd-6b01-493a-210b-08dc5f16336d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 19:40:13.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30o5zfLEI/blb7TqtPYjMHfeoslWEwcvP4FovD1FHG6nY5WGDD7SiKnBsQk44A0rEJh/MzzJ37oXZmg/xFsxMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027


On 17/04/2024 19:12, Dan Carpenter wrote:
> Return negative -ENOMEM, instead of positive ENOMEM.
> 
> Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/crypto/tegra/tegra-se-aes.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
> index adc6cdab389e..ae7a0f8435fc 100644
> --- a/drivers/crypto/tegra/tegra-se-aes.c
> +++ b/drivers/crypto/tegra/tegra-se-aes.c
> @@ -1156,7 +1156,7 @@ static int tegra_ccm_do_one_req(struct crypto_engine *engine, void *areq)
>   	rctx->outbuf.buf = dma_alloc_coherent(ctx->se->dev, SE_AES_BUFLEN,
>   					      &rctx->outbuf.addr, GFP_KERNEL);
>   	if (!rctx->outbuf.buf) {
> -		ret = ENOMEM;
> +		ret = -ENOMEM;
>   		goto outbuf_err;
>   	}
>   
> @@ -1226,7 +1226,7 @@ static int tegra_gcm_do_one_req(struct crypto_engine *engine, void *areq)
>   	rctx->outbuf.buf = dma_alloc_coherent(ctx->se->dev, SE_AES_BUFLEN,
>   					      &rctx->outbuf.addr, GFP_KERNEL);
>   	if (!rctx->outbuf.buf) {
> -		ret = ENOMEM;
> +		ret = -ENOMEM;
>   		goto outbuf_err;
>   	}
>   

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks for fixing!

Jon

-- 
nvpublic

