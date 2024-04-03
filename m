Return-Path: <linux-kernel+bounces-129824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108298970C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E0E1C26594
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB70A1487F6;
	Wed,  3 Apr 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z/Ra70al"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B31487F0;
	Wed,  3 Apr 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150627; cv=fail; b=OY2XHoq1jSQcBWeFhWWTmGcv7ZW7aQPNbQB1ge6exiVTGrmSay+WoQndSlyd6rZFb/yu1ke5GPqmAsv2bQ2pwDJeYfbUqRr7POixr/371GyNSWySGHs0xE2bqP4LwMlOCF0O0K0tQwvqxNQuGcaRXcquUdRC2R1ZRetaaGcZGGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150627; c=relaxed/simple;
	bh=Mdhx/feJYDZMK8ASnd9C6wbjMHQKR6CA9fYPSzIK5do=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A9KXGv/19f0J1k7scWVmgM1Tx3H93qyH/zq487Rrbr1IkgEULMNuG9xu49EOwL06yga9pzmx1WayMUQGrhFvdevdFwDvKB2d6bXZ+1hVf8pUX1g9fAQOy3YAt3lZsFTDNpPnI0UNyf7YAwP0JsiqhomEXhdxCvq9PePlGvyMay8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z/Ra70al; arc=fail smtp.client-ip=40.107.244.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEuwecab8rJQjlCzo2SwP4IJaVX6xD7N/HRU4MlQO2xNwRIaCmM9ImxqS4QDb+fLTtRf+bQf4ZpIHEPrNtrX1DUQXKoizH8c0lXGlRmDe42Zfc/yKfQgcM07QeObhyvHZya5oPPzLnNxWgNiX7XILygJ1HH3H+xsDobLj1pp8nTsiZkOoA0mGzrvCaUs3cAf5qEwKK3YVJPjRiwXmhhaE7KaIheCDbf/k5Pu9cI0w61J/t8YRC9HOKK2qcPRp8bp8TMFeax/93YeiDLOxh1e1n82R/nY0tUgvurJ3O/HPMKJufCdz2YXAxsyFoD86tUEcgXxLyMGl/Qp04QmEb9uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=686seC4eYz66w8msVZl55RSkTtXoqyVccwHWzyoOxGg=;
 b=f7dBCH83pRgqin354WEUBWhdl14l1/vd/uWB6nIOjv85Yz2MNVdKFYB+XF+DgefVMj7vZe5gFZJmtQ4V5mSO6N/qZ8DiaHiiQ8bbnClkjo3y3Rzdv5phD+FGJhrMdv9mNYZO4xrLu5k6xkEhA62xRWKKpg1t0cwo13Roviw20Ps6AfoHRzOh5WSKonkh+ExwspPbU1Qw3vaYVLSNm9IhZLosdcnE3V3lNn5+j7nyQaLfUHSxG5ApDX4NgSKCeTeMj5NsROhsNT7fDgexYb+4rAPa7z+V3L1S7NVGIqQeN81LKAJaIfoIywD1s60U6HdQIwQzfBddgbiSVG4FezaOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=686seC4eYz66w8msVZl55RSkTtXoqyVccwHWzyoOxGg=;
 b=z/Ra70alA69OoBiIEr+y7y27CmLAWWu4VRPH47sOyLl7l1jFiP3sPljl7awuuh7mNv22O+flJinkQobyHB+U+T0K3uTTrTOfyFAUfNaLq7tRbQ5nb4836KpG5DzMMvutwQBQU9eEjPVwJTNEUJX45ufD6aR2itjArT+tdBEW44w=
Received: from DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) by
 PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 13:23:43 +0000
Received: from DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::2d67:ab86:61f6:2afb]) by DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::2d67:ab86:61f6:2afb%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 13:23:43 +0000
Message-ID: <4059a8aa-d037-482d-934f-7d113a8f5797@amd.com>
Date: Tue, 2 Apr 2024 22:03:39 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v2 1/4] RAS/AMD/ATL: Read DRAM hole base early
To: John Allen <john.allen@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20240327185222.98998-1-john.allen@amd.com>
 <20240327185222.98998-2-john.allen@amd.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240327185222.98998-2-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:408:c0::35) To DM6PR12MB3116.namprd12.prod.outlook.com
 (2603:10b6:5:38::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:EE_|PH7PR12MB8108:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TspCbazwxS3DqSBaSsrjBNFvBTAOgVJteLJcIYEyJjEahGSslYTdl7+PeommeQCZqsRXfF9ThxWlueyF3FNeFRU4j1IVzgskXS/l1fc29koBR8OQY6rl8yKmDnNmgHSc/esAZvtxhxK0sWwQ6v7rfVEJN1iXQGfBPnOgrsc0CCrzIp2UhdLP/cKExBKZgbL7fMt/a/mKgR4iiak8SLNTVvR4ZpCopyv9Wnm0TGGBzbb4jm3ji+N6gvCleoLX+EuObIxSusNjGbIZqK49n91nGKg6S+PkfwS+xewFT9VHGzzmTowVjXE3VKjf2cRsIbEa5im0dL3PypgpFIVMhjtPHDwcIy+hDyzHfWiSrnqkT2KOIkqSqKPSJUEDGnO8T9DK5TeeWm+jR/Oev3GAvgBr0MASSGz0/ltdw8xkzGZ54XLzShow8Zh/vINRtBvOUtJxwuk5nVHXmlCKOoOlQOsDyVqUd6+UvSMl8NB4KA2irSkJLLi/aOL7yVHPGlqwLvWBUHfQsvyxMFjZwu0vROduOfBc1kx44d2Fptd1atmNZVQoXAQ2oidgScKARSnZE94rWmDDENHaitDN4DGORXCczyQ+LhNKn7ZJ+qVkSQR/WmIUTkUqgLnDBL1JTSTqSyX8sAdfHIJRtpstkfA2Q9dWt8OyGdi28LkNBkoPb3ikfyw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1JaWnBROCtFOGJJeEkzOExlWEh0N0FQL2VJd2hDNGplT20vb3hDSkRGYmVJ?=
 =?utf-8?B?ZTNtQXByS1BpQ2hPdHRhT0poL0poUnlPTytQVUJsZlpDRkdMNXlVSSt0QUlU?=
 =?utf-8?B?eDZhNTB5czlQVFFBZ2xqdGlvaEl6SCtPQlA0MTJoQm5iZmFjYVk0UEhiM0kw?=
 =?utf-8?B?UjlFL1pveDVrbzl2QS9mWkVsNEExRklPZUtXc2xPZzMydi8wZHpEZEo0MFRs?=
 =?utf-8?B?QlBtcHZqYUIvVlBhM3dUWGxzSFNXUGZQb3RKWlpTZ1g0ZGg0Q093V2JVTDJN?=
 =?utf-8?B?MVVnUFFUcE1BYTlvTDl3RjdWYVU1R2RTOUZPZmc4MU8zUDYzOXdQSkdONm1l?=
 =?utf-8?B?c3ZwSTAxWHVrN1EvNE0zUEg1MloxcXZoVHNuWi9FREc1TEtsemYvQ2FycGoy?=
 =?utf-8?B?KzR0SE5rQnNtdHJWeDF3TThpQVhMWFJKY3hFZVp3N2JSSWR6Sk1DRkhZUmpj?=
 =?utf-8?B?ejlTS2NsZnNrakkvcW0wM3lLSzlDYlVCOW5sM0dxbTJKWG1ON0Q5akRDWkRN?=
 =?utf-8?B?dTNHVGIwTTcxV2hjSWlpbmxMT1NscE9JUXdyelZBRnM1Y1BTTFF0eTZvQ2p3?=
 =?utf-8?B?SlE2aE5kT2VkckxiOWJ3bi9DYTJKeFMveUEvcGhVMTRlWU9aSkRVREJKNUQz?=
 =?utf-8?B?NTlrK3dZUE5rRWZFN3lTSEEzaDloZ05DK3F0aURLQklLRlVYWW8rS0RZWUIv?=
 =?utf-8?B?bFVHT2oweWdjSTVIY0U0blZ2ei94V0ZXMWp4alg5Smw4MzhXZmE0VERoZG1B?=
 =?utf-8?B?TFdkWm5YalZkKzdkTzhiRU91d2gyUTU3NHJua3JTRGtjZkZUQzdsQnlxOHFJ?=
 =?utf-8?B?RlcyQTlBRFhOSTJjT2RQclBNS2JaNWR5TVFQWEdyTzlZVk5OUkl0VDZlSHJH?=
 =?utf-8?B?elpZVzhMellwL1NMVFhTeXdXOU51Q29EMUVQcWt0eGQ1eG5oVzlaUGxRVG9n?=
 =?utf-8?B?VyswaWxWdjdKMFRCbmZzT0ZmUWVEUDAza3o5RkQrSEs1U044T0UzWHo3T1V3?=
 =?utf-8?B?SlcrWDhXZjBYVTVBeUxDZXp1Y28rRFZ2SHJ3VGN6ZllCTXNwbXo1b1Exdy9U?=
 =?utf-8?B?eDJ1dFJza05JNHpTV2xSQnNBR2FUK1FWN1VqTTR6VU5oS3dyRGJWM2VhVzBE?=
 =?utf-8?B?RjVCWVFzWDhJZzVVOTV5dlN6Z1ZTdmRTOHI2TVZzME9LVGhlL1RPTU5wODBY?=
 =?utf-8?B?UFBqNVN3Um1TSmo5V3dWT29JdmptQzRoSDBjdEZTK3FJQS85Z2l0U1p5ZStu?=
 =?utf-8?B?WG9jQ2IxcTQydmFsS1dPUE53M3dtSG9naktUQzB2dHNqZlZOYlZsZnhaajhh?=
 =?utf-8?B?a1JGcnJxZlFSZ2RyRmlrb3pnZkZGWElIZFFaS2d6Z3Nwb01rN093L3dYbmZP?=
 =?utf-8?B?MmhJM3dYR21XVkNTQ3NhNjlPRDk5ejUxQzFQYnZsKysrNUErUUU0azlkMnZz?=
 =?utf-8?B?cm5YMCs2VmVWRTlNejluTmxFa0l2Zk1OdU0vcUl5aEE0SXRjRXhGS3lwQ2tj?=
 =?utf-8?B?a1ErbDFBaFFrYnhteXQxNjJsWUhUaFlDQnVrRWNaTXg2T1QzcVZTT3EzTllm?=
 =?utf-8?B?U0F6UVhzK1RNSjljeWxBMC9tanBRYmJHYlBsQVZiNENRa0c3VXp6WTRHc3ZE?=
 =?utf-8?B?ZVVqMHJrck4xdE41amFOOTJ6TGtIYUllNWZFVDZ4czhOWUU0QTdTaGduc0Ev?=
 =?utf-8?B?bFIxdXlpR1IxNWUyUG9KRnBQM2hHLzB2SjB3U1BPbXN0WnRPa24wSk9IYmhu?=
 =?utf-8?B?YnhnUU4xa2JUZHhPUkhKUlhKOVZPMHhSU09wb2JHaHZhMU43NUZYK1NVZ0Np?=
 =?utf-8?B?YkVlUnJxZ28xeUlWZTRJMFFjNU1KcTU0RHJMZU9Ea2RMbFc1QUtmODgxa3RL?=
 =?utf-8?B?cC9vT0svVW50ZXpoeXNPT00rM3NpVjlvSWc2aE9TbnJscVU5ZVZvYkVrYmVt?=
 =?utf-8?B?cXEwMGRBK0JDT0l5cTFXUG90THpLc0RjS3lYRGFkRXdpeXBianJDaUpDRWRB?=
 =?utf-8?B?Nytkb1hNdjRSZ0FyclJrZUNRYlVWNEk1R3VERVhrM1ZtYlF6QVRsdC9QemUy?=
 =?utf-8?B?czRhYWJneXVYUWtxSTBkcFhvVVF3amh2RXo0bWovUExRT1JZMjlTeUVEMWpD?=
 =?utf-8?Q?URYr7FG2+O46vxxx6bqTg43tK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45419c0-4ca2-4368-e949-08dc53e14870
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 13:23:42.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ulJb0IesdbRUGsMDG2N+hd3OaX5A4diEgtsdz2Hv/MtwF7WLrRcoPZoQB/um9ZHZl3JpwIbJfYh0BQf8yz+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108



On 3/27/24 14:52, John Allen wrote:
> Read DRAM hole base when constructing the address map as the value will
> not change during run time.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
> v2:
>    - Fix compilation error. ctx->addr should read ctx->ret_addr.
>    - Improve commit description.
> ---
>   drivers/ras/amd/atl/core.c     | 15 ++-------------
>   drivers/ras/amd/atl/internal.h |  2 ++
>   drivers/ras/amd/atl/system.c   | 21 +++++++++++++++++++++
>   3 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
> index 6dc4e06305f7..63513d972c07 100644
> --- a/drivers/ras/amd/atl/core.c
> +++ b/drivers/ras/amd/atl/core.c
> @@ -51,22 +51,11 @@ static bool legacy_hole_en(struct addr_ctx *ctx)
>   
>   static int add_legacy_hole(struct addr_ctx *ctx)
>   {
> -	u32 dram_hole_base;
> -	u8 func = 0;
> -
>   	if (!legacy_hole_en(ctx))
>   		return 0;
>   
> -	if (df_cfg.rev >= DF4)
> -		func = 7;
> -
> -	if (df_indirect_read_broadcast(ctx->node_id, func, 0x104, &dram_hole_base))
> -		return -EINVAL;
> -
> -	dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
> -
> -	if (ctx->ret_addr >= dram_hole_base)
> -		ctx->ret_addr += (BIT_ULL(32) - dram_hole_base);
> +	if (ctx->ret_addr >= df_cfg.dram_hole_base)
> +		ctx->ret_addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
>   
>   	return 0;
>   }
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> index 5de69e0bb0f9..1413c8ddc6c5 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -132,6 +132,8 @@ struct df_config {
>   	/* Number of DRAM Address maps visible in a Coherent Station. */
>   	u8 num_coh_st_maps;
>   
> +	u32 dram_hole_base;
> +
>   	/* Global flags to handle special cases. */
>   	struct df_flags flags;
>   };
> diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
> index 701349e84942..6f6fe24dec81 100644
> --- a/drivers/ras/amd/atl/system.c
> +++ b/drivers/ras/amd/atl/system.c
> @@ -223,6 +223,21 @@ static int determine_df_rev(void)
>   	return -EINVAL;
>   }
>   
> +static int get_dram_hole_base(void)
> +{
> +	u8 func = 0;
> +
> +	if (df_cfg.rev >= DF4)
> +		func = 7;
> +
> +	if (df_indirect_read_broadcast(0, func, 0x104, &df_cfg.dram_hole_base))
> +		return -EINVAL;
> +
> +	df_cfg.dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
> +
> +	return 0;
> +}
> +
>   static void get_num_maps(void)
>   {
>   	switch (df_cfg.rev) {
> @@ -266,6 +281,7 @@ static void dump_df_cfg(void)
>   
>   	pr_debug("num_coh_st_maps=%u",			df_cfg.num_coh_st_maps);
>   
> +	pr_debug("dram_hole_base=%x",			df_cfg.dram_hole_base);

This should include a "0x" prefix to make clear it is a hex value when
printed.

>   	pr_debug("flags.legacy_ficaa=%u",		df_cfg.flags.legacy_ficaa);
>   	pr_debug("flags.socket_id_shift_quirk=%u",	df_cfg.flags.socket_id_shift_quirk);
>   }
> @@ -282,6 +298,11 @@ int get_df_system_info(void)
>   
>   	get_num_maps();
>   
> +	if (get_dram_hole_base()) {
> +		pr_warn("amd_atl: Failed to read DRAM hole base");
> +		return -EINVAL;
> +	}
> +
>   	dump_df_cfg();
>   
>   	return 0;

With the small change above, this looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

