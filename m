Return-Path: <linux-kernel+bounces-106262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FF87EB98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3A31F21208
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49A64EB4F;
	Mon, 18 Mar 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0IsV1wGX"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95A4C619;
	Mon, 18 Mar 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774371; cv=fail; b=eu4Asyhxu1Ha6V2lYBm285y7pqtjNkDfx+LIuQ9ur5YwM5x03CcbkKh1MisbFPQPx9gMYS+s+PrD6ta5VYUA9I1P2xU7Orn3G6cKHJnLRfwik8GKbONjy9FiYHLswQ4QKHS6DRAjNabp++7+wcA5kYDCzcfHuknKCS3luuZyz3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774371; c=relaxed/simple;
	bh=MUR9pqfzkveP99lePUGGHssKp2mhQfEux4CfHSLZoiI=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lcsw74ZKMp7ehVMia/RpiCkTASkWP3MfsuHO0NL7TTJwcgYzMHhTlDIpz7U7E+wRIL52U5RxwNIAHbSvUIn6G9rqx9ZwuBlsSscB4H158L0+ZDVaDMWhRGZUSIJb9PF0uEp13I6OIhMj25QtVXKCKLDtStHx1tcygflXHEekyAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0IsV1wGX; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buEgcTpNertotQ+Q7iJNSqkipxhy7YlUGAy8aRbfCUyEN0CSuxXxxbBNsOMDoS+iwuFUhP9eANQZ5snMDKEr+YhbQ/5GmjspTQ4m1taobQxPQ1eyATzekih4lmLxJ1WQKCRiO28HFBER88cGT/oCW6QTKIvQxZCwckPKi8XiEfRW6sHMHJBBuMtIocm3HZVXSa2zHW2rcOMXbQxKIrNInxf0Hedv7ipvgYiUrtEIIjQ+206sER4+nVJqMsZK9AnKNeeABs+ft3hP+8NmEx4Kjgl9XXGIRH423f+C77WTMIhCQWBSInOAPwRVHpEmcEdDwScvWyse2qRDJYzdrp3Pfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Or2Y9VZeSdjt/X8zQA5aZS9oYIbow8MmwD4UHwx/u4=;
 b=UKm+0ynn3IO3t/5Lwc8kWe4tPqlpmYHZVQ81sZDHyxShoCKP0s5ctfWMjTDHTVHiHpbAPa0rDC3ruYJZAFcnuXe/BA5u3oTt1iLGOWNKOC4vf2Np89eapuco0i/I+g5jnIy6ZfqnDifFidTOY5ojzN8g5juyYZYewDnbZUsdfkURz2hJxet+I5vVOT3wmD8xPcPkWpCIFDmwOKLB9L4UQSjgJprMk/k0Er1IXY4QYECSrDTFV521O7+3PXh7fRWg9vmjat0m0fGqKp8P8IRQWBsfyjkHt2EkXoGT5/dPV0TybclWRVSYyUa8AcrUjOF8waS8grspiXmeoftVOTRc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Or2Y9VZeSdjt/X8zQA5aZS9oYIbow8MmwD4UHwx/u4=;
 b=0IsV1wGXQO8RC/Ikub01lBPlSG2WIaLn37OuxcLd3dFZ0HZRbkaeC6SBKZIFAdDsm1J0VluNoFhiTahNjjuHe6kDtqMBNwStWQK9waOOuKBBqFadddU4TlTv60t9JQQrbNkf7A47T/vD+eVjN6t1/8k6nUvnjZQrOxc2SjgvsWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 15:06:06 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4%4]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 15:06:06 +0000
Message-ID: <10919f69-4008-4156-88e4-3c72e3775562@amd.com>
Date: Mon, 18 Mar 2024 11:06:02 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH 1/4] RAS: ATL: Read DRAM hole base early
To: John Allen <john.allen@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20240314163527.63321-1-john.allen@amd.com>
 <20240314163527.63321-2-john.allen@amd.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240314163527.63321-2-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcf1705-441a-495a-a00a-08dc475cef83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TJjIuPbeNIIy/gVJd8g1k7UClSzEZccZSGGWTjeWKrun/xVe7xBH6QBKS24XhwouP/MqKLlUhzUtXAQIcXAn6HLfPlMZZ6Wqkid04Kt/+BKhUh3ADZYELbVswjNW3kucHRF/GYE9tI47bb+VA4XMuOhgLbKEX+6v3h/xMj91S7QX5YjE5hvzzhMOAOmjrlG40r3MIc4xwMgA84DRIf7HNy5PbbEQAkQuqWVhFNBh+8E1E4PDu0TEoqS3iZQtJ28sJ8q42kEXuqvtFlsh9RRH/80MGLE/Myz68meB9x4ThqbHtyIfZNTipXksw//q8bs+qiT46FqcUEtyrQMsE5L+UW+SiUcx2geO34ENIy71wLwtc1FT3gvDSdcTEPan1u/+fh9s2+VTqroejWFDiFavYnkcdqBxzJWUbd9UeEnpXBprDdQRpu4AzfjZkwmoeVdcbf2vFKxIiGtEWcIUwRfngR5I4X1CkIv705+ZuPCR6ugeqmSX1wWDV6hQF98NpwSpxb54FcuFZJGUmsnDPzeSrOtpkhRvwWPtcrz2bircinjGvrjCxtRKf9tAkMyJvxHrVVJ1ZnSPRkVm9KcFaN4REwjXsZg6gM2w+U93j6sIH0UoAnAR0t2VLrf7cgIMelIDcwBlvzAbF9YTGMdYMn8BGITRHmOjS0LDR1JMHDBMX5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UCtVMUdXcnNtcXNDNFFnUTBjTjlGaURuU1NxbkxMK2QzK2htaXFXMmlpR0pQ?=
 =?utf-8?B?MGxQWDQvVGtRRTVPTE1yNDk5SmFBSHpzMnBJNGp2ZmRaR1NKZnJmOTVFVGJs?=
 =?utf-8?B?Um0yM2t5eDBjUzUrbXZITDhjSURkaTdZbCs1Vk42NjdaZlA3WXNRak1xNWRQ?=
 =?utf-8?B?UzVnYkZjbDFBS1BKRGh0eWRmbWZhalFFYk4rc1J4UFFSRWI4cEFpQU8zalNr?=
 =?utf-8?B?dEh3Sy9jZGh5QzBPallVdTE5QXFGWlh0MW0wRm54OUdTNCtCVlFBVW9GQnlU?=
 =?utf-8?B?YjNaSGlpWnRpZGdOMWtJL001U2dGRVZsdTFSUmlobGNOTC9RQVRhUlFFaTFX?=
 =?utf-8?B?VXUwbDBvelZrWklUTzMxSzB6dWN3SEZpanZQd2dOemxoT0daWS9KS3doNjZo?=
 =?utf-8?B?RUMrZWwrUzZpT2RUMVZxUWMyN0srUVo0U09FMG9JYXp0TU4xRk5Qbm90R1Ri?=
 =?utf-8?B?NFhhSE44Vk1veFdGYTJWQUFQRDdwYWhIL3ljZURhR2g4blo3U243eEZ2YU0z?=
 =?utf-8?B?bFVNOHgvZnVLSmFpWCtrNnpIRnhLY2Q4cVM2SHZBcnM0aEFqcFVmbU9tdm15?=
 =?utf-8?B?YmkrNGR0NmhzMFNJZmRET2grb2Y5YWN1MnUrYWl2QXpNWWwyYnFFaW5OaE5m?=
 =?utf-8?B?SjZyRWJhSW53MWV4ZkJXRzN0aEpRdWtLWlEwc1RSL0JRUEtXVE9qUWJXeHNE?=
 =?utf-8?B?RWJEalNwb1lkY3kvNWZ3RzI5bXlualZPR3YrU3B5TTlROTFQYURYeFh2OVZX?=
 =?utf-8?B?YnprY3dweWw4WHh3SEw4eFVBeG5EZUVDbHRobHFMeU81dVpqVUhiTVU1dFcw?=
 =?utf-8?B?eVNjOU5WSEp6ZElsZ1JyeFEvdnRXZWdxdzB6VUw4a3phQ2xxZDU5c3dWcTk5?=
 =?utf-8?B?elY2dGNNbGl4RUgwSjM5c1pPWURwN0FkRjBmaGhDS3BJTlFzQ0o5YmQvVUla?=
 =?utf-8?B?VjFNdGFIekhoUE4wWmZSWW5uR29YSzRHRnV3VTlLVWdLS1RpbjFWMVdDZjNS?=
 =?utf-8?B?djJXVWVKMlBjeGl6UmY4cGtpRU0vaGRSK3VTQUw3eWR4bEh1VE5YeUhuR29Z?=
 =?utf-8?B?Y1pCMGs2Z0tiSDRSUVZPMGJIYWtRV0tQYTdwWWxLVVZsNmVoUUhBVnBDNEpX?=
 =?utf-8?B?TllnZmV3c296UC9lL2RjdnZvdmdKcGNIK2oySENGVGZCYTBiaExhWkJzNzg4?=
 =?utf-8?B?RG9nU3k0NzFDSVpReUJ0clYrMHFjTWR4eC9kc1dTZ1Zrb1pGWllZb3J2ZXJN?=
 =?utf-8?B?N014ZjBKc3BZT1IwZC8wWDFXMHljdlJsNVRvd3A5Wk1NUytESVpjSUV4UU5q?=
 =?utf-8?B?cld2dDBEdDk4QjB2M0lwUHVqZVFYdlgrRTJGTllGeW83YjJpaUNsMUNpQnh1?=
 =?utf-8?B?bSt3eTJzMFpHWjgwOVY2WUZ0dHFDVXg4VTJuVkZnaG1LYWc2cmRQUU1wMWF0?=
 =?utf-8?B?UnkwNzZXVXl4YjAybjlTMVFhemRVS3FIaFZSSzlHdGNNa3E2UGN0a004TDY1?=
 =?utf-8?B?UDR4Wk1XYWxHaXIrcFBTVnRYRVhEaHdGcXdIcFBkaGFKUDRra3RCZVBxZWQ1?=
 =?utf-8?B?YldkWU5SN1RiWlAvVi9zNEdPZ2NtS0ZYakttOUNNdFdDQ2xic1d4cWNCbk82?=
 =?utf-8?B?Qmp4ZUtQUGdpb3N2ai9HYllneHNoSGoycFdIRlFCRHhseHkwa0FQVjkwdDNk?=
 =?utf-8?B?YnVaSkg2bzF5TCtmbjVJZXRWVXIwR1J1b0VER1NEdFZLWFVBTU1FV05DSGs4?=
 =?utf-8?B?Tnp1aWtLRnI1bXQzaTFEbXdqY0NiNlJCdytSZ3hXTjZNK3ZLZ1UxQklpenZ0?=
 =?utf-8?B?bjVZTXQrUlJleW9OMy9Cc0lrRlh6WWkyOTBVd05XMTVtSXhwK0p3a3A1VWRM?=
 =?utf-8?B?ajZ3L3JnWVVaYkdPTzB0b3l2NXd0WWdic016dlVUdWs0SlRuU04welFoWEVP?=
 =?utf-8?B?U09ZZjMrekJVSzNnelVUY1NEZHFZVnJSZjMya243Tlp0dDd6RStXeXE0VUxw?=
 =?utf-8?B?VWNJZlBaMk15WUxQVXZsWjliUXhrd1lOL1RlY3A3cHIyeUZSRDc3MnFGS3Vh?=
 =?utf-8?B?TFZBSmZHbDVXS2poSzdON3FpS05kOE8rRCtHdmpWR2VwZ28wVVU2SzVoWUg5?=
 =?utf-8?Q?Z0VaEaPfLNW5ztUNKq+vKVQ4y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcf1705-441a-495a-a00a-08dc475cef83
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:06:06.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDGdKWqpJN61j0sJWUS4aFoydZi+Pyit3iyZiIS45BeFe7zRTylxlvEL/Lbikf9qYHPisv703MpbDxLumfOADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370

On 3/14/24 12:35, John Allen wrote:

Please use "RAS/AMD/ATL:" for the $SUBJECT prefix.

> Read DRAM hole base when constructing the address map as the value will
> not change during translation.

More specifically, the value will not change during run time.

> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>   drivers/ras/amd/atl/core.c     | 15 ++-------------
>   drivers/ras/amd/atl/internal.h |  2 ++
>   drivers/ras/amd/atl/system.c   | 21 +++++++++++++++++++++
>   3 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
> index 6dc4e06305f7..c1710d233adb 100644
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
> +	if (ctx->addr >= df_cfg.dram_hole_base)
> +		ctx->addr += (BIT_ULL(32) - df_cfg.dram_hole_base);

There is a compilation error here. Please make sure to build each patch
individually.

Thanks,
Yazen

