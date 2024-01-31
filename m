Return-Path: <linux-kernel+bounces-46908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C7484463E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C593BB243DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C82512DD8D;
	Wed, 31 Jan 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ePrHnBbh"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCED282;
	Wed, 31 Jan 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722265; cv=fail; b=J6psmuK4u8BFa18gvFgSNo6624aytWqCdhK74We2fZ6Roe86eKClLOi9GWVcHG8VVsuKHr05352wRTUVNzgBRDj5gyGX5Eec+XrQV4vc3luY9MH1cxum+pJLkQcgODLOf5wv/pmLXgOiAXvfbFVF66li5ZCwjVfyhuFgruFyjgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722265; c=relaxed/simple;
	bh=/WECKyh9p3C8vGIkRJQROFFvE6iTUGZuhaJ62ijMYm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mP+agq39awLY0rh7KuxM1107xW0rl3Z1xRWgz9okuDQDbf5LcekxRcfB5o1cM0QOlI+0ZhzAbqv0piMoxuNJ0ZXXN/s7ElXWOZvIc46T9pIgn1ecubKUbv6fdGM1bAycP5s9QsAOwvOe6y3E8TwuPqshDaAzLTQJb1vLq492Zq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ePrHnBbh; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu6Cz81x2q+s6HQuLjwk5C6/TYF85vFlWsdA+31fmoTiTrtBHq609BiZjA2XpqSY//50lckI5ZksjX4To+TjXRktMr9F/A7iK/4aaMUCBtl/f8WiD9Rac+rxiyC2NvtfgHm8+pnQUCKYYFavyJmRiUbikXKhRUQeRZ4PvNtdJyWtq5aAjgUG18bEvxFuDyw+qk1aTw1MXeJY63Q75q3Pg7T8dZpVirqIOKXUVqMSrtK++LWWEDE5hGxa6nvV5WAa1un03BDA0Kc5TS4J+2If6Jwr40zyc/iOhKZRcQbUIHqAS1yYxybzn15Xt80RMrCHFLa9sUXmNQ+g/V6GMhkOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1bhMsyWGiN5U+CToYXOxPbRyHwsf7mNk4UoGv+vhmE=;
 b=AadsxYr8ZSmL0EMQ+0cjwtQPrRTIiWLqZrfsuYAf3fjh+LSagnYa6oC+U8liQoh3tNp3UOSRriaf/hzT0muc2pPjR50VJWSB/YZ/mx+5TVJ4Fycd7O8Dc9t/NNJgLPCxHBfTzILW7IaR0BtuqXvzOjMwpRpnQWuSfGqH2u1sDF+kcaTOckygWBkR4F+YuSq2xjLrbug8zonfB9YxJUAaJwnXW4YjX322PQ2DB2vCBPlm6u3Cxl6djVyzUEGritGq36m35YRl96a8OQKgoWT+vOS3H0dbbqC95pukMNMs9uagkgT7EXfc0W7nqlACy4APRlSkPwTnUdP72NRc3t365g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1bhMsyWGiN5U+CToYXOxPbRyHwsf7mNk4UoGv+vhmE=;
 b=ePrHnBbhCH0M+9IhM7+V2uFt1cAPcVk9ATE9TLypJQ1GKfr3vya1w9lbbjF/5S7LvmoTM3EfdnMp8+7Bg13/9iJcf0yQxlMd/U74+3dt1yS0fSJYOMD3f05GmSDAnKsi+K3Jm50e4Wg1yUu/0X9jwx/oyc5D+X9+eVTFO5bNW5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 17:30:55 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 17:30:54 +0000
Message-ID: <9d6b00f9-98bf-43d2-86c5-55e45ea8d821@amd.com>
Date: Wed, 31 Jan 2024 09:30:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] octeontx2-af: Initialize maps.
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com,
 gakula@marvell.com, hkelam@marvell.com, sumang@marvell.com
References: <20240131024118.254758-1-rkannoth@marvell.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240131024118.254758-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:a03:100::41) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 5592039d-e540-40e8-d2c7-08dc228260d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dtLOLHg7qYea+wUmUXZRFRmwet3eFWZiYVdB+Krdqb6i7bLLknBJ352yctvOjs+xtQufa/VoyteXqKXcagt8CQPn4w7F4KeqNWOETn3HWwo/UDrE8wEfbICVX73K+99OrtPq+2s9FaaLLkQ6Rbi1yRL4tvALmizwtyYeWLJiPPDnRnjTNfXSEmhzCCijFXzf9kudT4rynBpMlRaUw1Z1CIdzk4MHB2StPtS629A17dyX+ILUyD+bqy7M9kOZCr6ELsDERCmogzctJyBk1/6h4oQpdjaAbHiOjPLLkL/8KtQwu5eaAWU1s+eJGpnlC8ZtM06nQuH7Ji7cIMfyc7DF1932Ho7Fcf1Rg1w4JUQ9hKrcuO4ybO1Z9WGX1CZXDsUs6l5jevFA56EVu3pEG5HXbTQD7gaUFAaR+LwXu8PPNkAes99tdlrdLxhc3GsB5SoVGGsUvf9EO/DZlBFPuHwaA6X1RDK2LyITDu7gxQjsSc44ZQOrM675rrHSGSQ2ZuR5JzXWkRB1DVmzid6Pj6QHSS1RgCvPK+cciM/3iBtnzL5ClWthZP9NwjH2Ay4gxF83EsNvsGisqY7LkDvHDXCgBUtBpdEHgqZ+63c1sTyYGnrV2JVv/2sDkygIjDU2xDjaCx9edgf6Kg/i2TlLO0z4Ob8WMFGxI0LmlsFo0p4ynoiGEhCksuAsAzMW80BYlISm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(83380400001)(6512007)(38100700002)(26005)(2616005)(8936002)(4326008)(5660300002)(8676002)(7416002)(2906002)(478600001)(6486002)(6506007)(66946007)(53546011)(66476007)(66556008)(316002)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1h6ZzdVYTU0d2QxMDhsMjZHcmVML2J1Qyt4bzVwaGdrRnBldEtNNGlQYzV5?=
 =?utf-8?B?dk9aaXpZLzZPeit6dVdheCtmUG9XcUc3S0gvMFIvTzJFdmZhS2VEcUlSUUJ3?=
 =?utf-8?B?Z2JwakJOQXFzVEc1djlqRDBhY3phNFgxRWhmSjlaK3Qvemc0NzVUMm1kS1h1?=
 =?utf-8?B?Tm93RTRoVmRwODBWWmRCSEUrWFNQOExiUlUvVW5yekhMWHI3MDJPTzdyWmRa?=
 =?utf-8?B?MXBvQkV6Qk45aFpGckJVMFdTcHBGZ3EzRVZqN3NuQmhYT2J6aVdieEk0dGxL?=
 =?utf-8?B?RGFRMks4OEpBNW11Q2Ryb1VoZ0ZuS0Y0cmVSNzB1SUZPM01SS0lCdTgrc3pa?=
 =?utf-8?B?MDFEcGpncXczaUFaYUNIb0JmS2l1LzhHdDBJTVZLcHdzY0ZrdWo5M3NJUkZv?=
 =?utf-8?B?UFV2eUhYQ0taMVo0bDVnbnMraUJQUytNSlFWYnpqZ1FJWnJtNVZaKzQvUlRm?=
 =?utf-8?B?bFZkdk1CWTBXd0NJM3BLUENOYnppL3BkME93eUI3MFdycnVoanZBVEwydGhR?=
 =?utf-8?B?eGg5OC8yQ3k4YWtCT1BKSHpzYzZaRVZ5U3NvK29STmt2RStnUzE4WG4yWWJ6?=
 =?utf-8?B?TUJ2dHREZTVPMUhUdmxqR1RTaUlMMnNubGorV0hLVDZzR1MrOWJ5OGE4eWM5?=
 =?utf-8?B?Z3dCcjNxT3MvNTFYVWozcXg1akx3OGU4SzRnUEZNVWJWTWc4VmJkTzZ5RkZl?=
 =?utf-8?B?TjZ4S2E5TkQxajZ6TTZaSnZGQ1hoOG9kTmErSVdQMjJoREtSbnhqcENPYkpG?=
 =?utf-8?B?enIrbWJaSEszRkNDNk9xZm85VUV3cGpRUkV5SnZ3dFFnTW9PQ1p1aDB1VGpN?=
 =?utf-8?B?cVRzbDFJazBKdEJtaHZBblBHWGFuVGFxeEZlSjFMUklXMlIrc2ZEM1dnNG9F?=
 =?utf-8?B?U0MyVFZpYjhKUUxQK0RySjdycE84S2FEcXNJVk5GM0JJREp5b3VZZmNLeHh4?=
 =?utf-8?B?R0d6Lzc2VWFjQlFTZUpQWkJMYlRMMWdseEtqUjE5dkZzSmR2R0F0UGNnMEtG?=
 =?utf-8?B?OXROQ1dSRStOS00wN0xEOVpET2NTTVM0NGp5SnpiUG1ZazJ1Q05ZSTJ4YWVV?=
 =?utf-8?B?UkU3Vmp6WWVXdTEvUWc2SXhzdUFYeGc4elgzUGlaM09CT2ZGcW4zZjEwbUFs?=
 =?utf-8?B?ZXhRUlRFaU1wbGpQZ1FOZytMakVqbC96aUlCTmx6V2NkVDA5aFBrdkZSeE12?=
 =?utf-8?B?YjEwZHJ3cmYvVm52K2FxbmJuUDJPTkZBei9TQnJLVWdRbnhNWmpnNXBteGVN?=
 =?utf-8?B?T090V0grM1ZkVXYrZEZiYnc4RmtvWEJYVTk0RmFpd3ZINWpyV0doYitDSVhY?=
 =?utf-8?B?ellwYXFYNjkzL0xTMDc0ODMyZzJOQTNaTmFtNXhxeWNGczJ0eHJMeU1wRXZF?=
 =?utf-8?B?ZWFYd1M4SHpsMGRjN1Myb2Q1VHF4dkpKRWc5dTMwcDkwQ09nay9yVXczcXFS?=
 =?utf-8?B?RzI4aFFZZGxEUkpDMHR6UCtJZFhhclYxNEorc2F4TW91V003OFRGWlI5WXZH?=
 =?utf-8?B?V2w2Y0RJMWY3K090VGgvSVFFL1RhNDZxaVJacUZWTVFBMWYrUlFITGhrc2p0?=
 =?utf-8?B?MWtWSFdaSmE3K1k4QnQwb1N0d0lRK3Z6NDI4Yno2OXFxclhvSWNuNkV1RDhh?=
 =?utf-8?B?c3ovNDYwYVhtUDZQZkc2d0Q0cmRUQ0tWTEFpeWtwTzdWR0ZGcm9wYURjRWNY?=
 =?utf-8?B?bmN4RlpydmVRMVJNN1lJVVJkU2tXczZ6b3gzQUZndXJhdDBxY1Y3ZWpWVFJ2?=
 =?utf-8?B?U1hTSXdqbGxqQ0YzLzkwUVpTaVlJS3BBVEJ2M0tkV1dtem53a2N0Y2NWNVhp?=
 =?utf-8?B?TTJQaTdiYmpnVjY5a0ZVNm56UG9OaktXMFNhT3lpUmIzb1BBdmxKZDFkdXRH?=
 =?utf-8?B?dmRjZDBJaFkvRm9QSlMyaVMxS1ZsRnFFUXRjeC9xR0d2dSs5Q0RJaUxabG9k?=
 =?utf-8?B?MDMrUGNQQ1RoWHppWkxuNlA1c1VmL2R5em9qQWtVOTdZRitHMUloYXBCZ1NW?=
 =?utf-8?B?eFF5bkpOVEpzZnFvbFQ2UklwcjdlZE1QTGhEOTBYMURPN0c5U0d2SnR6LzF4?=
 =?utf-8?B?VW5WNVpXUmlFZ2R4RGtCd1k0SzVTeGxPWmZRTjB5SHYyaVp1S2dzMmJudUMr?=
 =?utf-8?Q?JueiSbykoBu/wDGUWF0FOoerI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5592039d-e540-40e8-d2c7-08dc228260d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:30:54.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWhKRkzT/nq/tf6X9smLz8CtUriuyNcWVxsBoTp8PyQm5CIEZfbCO4RvbBx+31g6Cmq+gQqMaIiCysVDFQqoug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

On 1/30/2024 6:41 PM, Ratheesh Kannoth wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> kmalloc_array() without __GFP_ZERO flag does not initialize
> memory to zero. This causes issues. Use __GFP_ZERO flag for maps and
> bitmap_zalloc() for bimaps.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
> 
> ChangeLogs:
> v2 -> v3: Used GFP_ZERO for normal map arrays
> v1 -> v2: Used bitmap_zalloc() API.
> v0 -> v1: Removed devm_kcalloc()._
> ---
>   .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 26 ++++++++++---------
>   1 file changed, 14 insertions(+), 12 deletions(-)

LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 167145bdcb75..6a8f0efd96a5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -1850,8 +1850,8 @@ void npc_mcam_rsrcs_deinit(struct rvu *rvu)
>   {
>          struct npc_mcam *mcam = &rvu->hw->mcam;
> 
> -       kfree(mcam->bmap);
> -       kfree(mcam->bmap_reverse);
> +       bitmap_free(mcam->bmap);
> +       bitmap_free(mcam->bmap_reverse);
>          kfree(mcam->entry2pfvf_map);
>          kfree(mcam->cntr2pfvf_map);
>          kfree(mcam->entry2cntr_map);
> @@ -1904,13 +1904,11 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>          mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
> 
>          /* Allocate bitmaps for managing MCAM entries */
> -       mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
> -                                  sizeof(long), GFP_KERNEL);
> +       mcam->bmap = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
>          if (!mcam->bmap)
>                  return -ENOMEM;
> 
> -       mcam->bmap_reverse = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
> -                                          sizeof(long), GFP_KERNEL);
> +       mcam->bmap_reverse = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
>          if (!mcam->bmap_reverse)
>                  goto free_bmap;
> 
> @@ -1918,7 +1916,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
> 
>          /* Alloc memory for saving entry to RVU PFFUNC allocation mapping */
>          mcam->entry2pfvf_map = kmalloc_array(mcam->bmap_entries,
> -                                            sizeof(u16), GFP_KERNEL);
> +                                            sizeof(u16),
> +                                            GFP_KERNEL | __GFP_ZERO);
>          if (!mcam->entry2pfvf_map)
>                  goto free_bmap_reverse;
> 
> @@ -1942,7 +1941,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>                  goto free_entry_map;
> 
>          mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
> -                                           sizeof(u16), GFP_KERNEL);
> +                                           sizeof(u16),
> +                                           GFP_KERNEL | __GFP_ZERO);
>          if (!mcam->cntr2pfvf_map)
>                  goto free_cntr_bmap;
> 
> @@ -1950,12 +1950,14 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>           * counter's reference count.
>           */
>          mcam->entry2cntr_map = kmalloc_array(mcam->bmap_entries,
> -                                            sizeof(u16), GFP_KERNEL);
> +                                            sizeof(u16),
> +                                            GFP_KERNEL | __GFP_ZERO);
>          if (!mcam->entry2cntr_map)
>                  goto free_cntr_map;
> 
>          mcam->cntr_refcnt = kmalloc_array(mcam->counters.max,
> -                                         sizeof(u16), GFP_KERNEL);
> +                                         sizeof(u16),
> +                                         GFP_KERNEL | __GFP_ZERO);
>          if (!mcam->cntr_refcnt)
>                  goto free_entry_cntr_map;
> 
> @@ -1988,9 +1990,9 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>   free_entry_map:
>          kfree(mcam->entry2pfvf_map);
>   free_bmap_reverse:
> -       kfree(mcam->bmap_reverse);
> +       bitmap_free(mcam->bmap_reverse);
>   free_bmap:
> -       kfree(mcam->bmap);
> +       bitmap_free(mcam->bmap);
> 
>          return -ENOMEM;
>   }
> --
> 2.25.1

