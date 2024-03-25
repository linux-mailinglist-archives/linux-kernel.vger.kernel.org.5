Return-Path: <linux-kernel+bounces-117818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802088AFEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB181F64B16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F66A18E1A;
	Mon, 25 Mar 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lJ4iiPCa"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2129.outbound.protection.outlook.com [40.107.243.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148E1798C;
	Mon, 25 Mar 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394836; cv=fail; b=guecfbXCxvqWVyETajwgpWtFh+MzIMk3+oYUeQzWjUcVJAWIzBf2uZUHaVIv0L/ZJv4WseMUrVqWUWgsgoz0BCG39jCv0yu2o38n3jam+SsEsBSLJ/xckmmqES1q3Ji65Olh6P/Xna9Famik/P8o+lOlPrsxSXVmh3c2p2nvecU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394836; c=relaxed/simple;
	bh=RcC6rLjCC5aA41bT0Cgh2TxwBV8fvLMUFTGVwudwCTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MjHrKPE3bjVFUuNKubqFUt3JjERTN6S3Fobkb9x8X75gbwn3RQKBVICfVBZa13g2NYUPLwAoa+36jeBC6EBTC3G3UktaPDW3j/AaJP5rqGdP9xD5fvu3DhAJoEZBrATF5luxHjOrHooN2j7d9inEFi1oasoIkNOJ/hprKU1X/hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lJ4iiPCa; arc=fail smtp.client-ip=40.107.243.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neyYPf1XqXCMr67tcLbiw3odVBrUfdT3Ea3JNMRvaXWI53HLnWCsq7Ok9dY0K835q6e8Fu+nscamsDHqDj4Ip/g5boBGDY9/RTT217z42Xuol/V8k+ElEDZ42mFLO04JCtCJ2PtH0y6Ap7Nf24uDHK/G9gyVRrGegs/JMJdhX4E0gGNVCBUf5K+SL9Qqjz2IE1x6LtuP8cRlAV0/kgK+661RhXDd3bdcrSYxn6sVMiotYQaHL+qQBvTOWQZ/3ITRIegswCHiDVtI/KOc4uz52Lr2IiZIT5eCcuskNqRy3AtiWjQH27RRrN0VmDo+YoHrsSr5GmlOQT0IrBOS9+wQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwtFEpBxPcOhdcE0cXY8LkNtFQzcyWNlGNcKd0Ypr4k=;
 b=fqqQO4BR2vOnTWzO2f3/PcLyDkBL3Zp8nCICD3cCC/5Uy2Rp59mGtlH/2PjMtxiaKCww8b2yBkxlv8gIudxJiW+whvBC8tTrRP/iWAuDFqBQXF3rJZpvMTbl6DXQ64PfIyOGTcqsPd2zylkNfTGsCI5H1+DAMJ3HfDU5NmY0BN+JSwR/xBvHafz9pjF7shwd4MN9orDZHTmo2dAOD9n3S1TRyLtKsjl5uGHSHXoKdRjX+vCSGqlGA/k7r5PVy6HyKd8dr+J1HsFso2Vehmqc9yaSvVK4mqeqN9dhp562qR445JYl+M7hrlWxnYZnrmpK9fbMBS0VIN6B2/SPNKPW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwtFEpBxPcOhdcE0cXY8LkNtFQzcyWNlGNcKd0Ypr4k=;
 b=lJ4iiPCaqgRktkyV59KoTr1GA4paO9C1xbYFemnhhtpHWlcP8ienVmI5mTnVQAlIhTwxmEQOP9x+WsHZ1jaPNITf6jsrhF1uv5RjHdGKXYnmZQoA0mJ32zm/opp81sLsLSE3SmAMDXYZQCnb7i1Wtqcj0qfncLZsLE55vMLP9Mk=
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 19:27:11 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::319f:fe56:89b9:4638]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::319f:fe56:89b9:4638%6]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 19:27:11 +0000
Date: Mon, 25 Mar 2024 14:27:03 -0500
From: John Allen <john.allen@amd.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: bp@alien8.de, linux-edac@vger.kernel.org, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH 2/4] RAS: ATL: Expand helpers for adding and removing
 base and hole
Message-ID: <ZgHQB2yasP1DeLcy@AUS-L1-JOHALLEN.amd.com>
References: <20240314163527.63321-1-john.allen@amd.com>
 <20240314163527.63321-3-john.allen@amd.com>
 <ff9e4658-18c4-4a36-962a-373c15c337a2@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9e4658-18c4-4a36-962a-373c15c337a2@amd.com>
X-ClientProxiedBy: BY5PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::45) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|SJ2PR12MB7845:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h1Vau9xjpCPNfFkWETgaOOLo33+VxcyV49Fy2CX8KMFkh51cPjLm2Xs2bII8cW4r87hhr7kzaK88TzRH7RS2QMqwjsOMcp59qpyL9zfJBUcq65PDgoxSaUcg+vhOe8mnNB45VVBYtLlT85QAFwjsfvPY7cmyUw7dgMXkNiP9Cjvt+VBtL0B6PYrZSpdvwmABw8DALSdMuVxG/A87WQB+qBWRHV1nT9Gi2gk8htnpXBC+JGxsmit7he7+0o0TVJtqWT6bgMjpi7sw0aDIDBzH6r8B66Vcddqr5RqWqiumO7yzdH726ODYsK12w5I/VxMOYle2FMSvv54oM06hny+CU/5vkBhNqv3mBt43YWJfeekrFr18fr+UjvpBIJS9t2zVyZTRdCrxPkoF0G70+xCve+1Xpdwf3gzhXnNVn6ss8BwSgUaM3mSsuEp3/hSfdfjfw2qIltHVgd6e082pYQRdgFm4EjZKEgz65wnnaAhVEuLK7/dZwd+cKvcSby1+qZcKEfqf4mFsEucGchRK/JjjTE+lnTSM/zagr8RokSlIS2KPlnFmBzgbiyivBxwgEQ5oXMYGiDJ9k6lkHzAjUofc4lPkfWaV5fMhZpB5mVwl3Vv8N/u+hc+kHo16AN3SVErRBK6PximXGRbdPvSNQVnPTdg8d60ODJoZ3ggc/j1Hjxc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NbsEjxtMLpSLLdzks0xTP9/podk36f31kjsht5Z141V8VXE70hWZVRBzKlaP?=
 =?us-ascii?Q?t5VtW1gG2CtjIBiklLuCv8CO4Py8pABC/rg4Fd2PRyPx3xYTlDgoJowl672R?=
 =?us-ascii?Q?kW26SKmN98slOqtri6i9xDOqaG/OJ+bed6GPt4oeNa1J5YSPzHD07cWo2sZt?=
 =?us-ascii?Q?bVxkEr0H221GrJPuJj1J8Jov2dww+1gU0WrwElYgnLZWGapLtlGZcVaJqxDP?=
 =?us-ascii?Q?D+9sh5+9JQxSMUt222C0da2P3UOAzJ01F2xaPJABG9wUEbGqavMWuNs9R5TU?=
 =?us-ascii?Q?UJM70mh4N5x1jZLHU0CirLo/8JvQdUyeoZj9Byndkm1MXndJGPaZn8zuRj54?=
 =?us-ascii?Q?e6czlvivVIO1gNY+UjRVamtFc6LAt21ob7LiY9Y5ctrUkATLzjRHtVfY6uEH?=
 =?us-ascii?Q?dH0IDwZDyIxEpj8hVwR7HXti8xVfjFNo8PyGcZERikWXPas4eKsggWVhqPwL?=
 =?us-ascii?Q?+TlyNBci8M7urhc/yRGrZFWZC0lcAE6/ZPNC9Tdoe+yW11KZa2ert5RVnkPI?=
 =?us-ascii?Q?Ol5c/kgIZC75sL0GlxWBz6MG9y0uKBoBcwHUEGnW2iEh/DMzLpDbenjtvFfk?=
 =?us-ascii?Q?t1hlwb0XrjkjkcJx5vEyrfrL4EZvUGiCjkXgHwENO+yfENwq5GF3DjmEYyhD?=
 =?us-ascii?Q?zlbIEqVV+b6xAeg8vk8lZE1g29brMzPFzApwVdsOAXfFwygZ47IVREZBQH3u?=
 =?us-ascii?Q?6aoUF02eDzAf8jRMDVrs2uEt0lUZ1iGXa/iBIKlnsKjtTChWDAgp4dgRNZR0?=
 =?us-ascii?Q?6ISdROY43DeSd8BjuVwkhTHnT5vfiA7Wigqsrb/fHBkr5mUt8MQu0ojX5233?=
 =?us-ascii?Q?vj9Li2/XY8RUcaVc8zvMwHWCAObtNK/kBNSDKXchcQAct5DLNmeDC2rgW7yq?=
 =?us-ascii?Q?mXPV1JL1ctQCXknAgw75mMqMHDWLP3qlsBfPM600iP7fRnQdRKCRBL6ROoDD?=
 =?us-ascii?Q?fxPctVwJVLaHLEBp7o42W3KJUmqCKvgdYYsnyvoQZzg0RlAFxwge7GHryf4N?=
 =?us-ascii?Q?SH3u41J6N8epyGJwZSAUuh11UKjkI/vkQxeGc2Ca51tzTFklnVKXGcF5QXxP?=
 =?us-ascii?Q?vZyqK7dtks0woJ3bmYqpZDlGXsj/E9ofb3c2uYcyy1be9hq32WYBPfODaAsb?=
 =?us-ascii?Q?+9GMe7E25I8BuAuxAIIb1TgjMhqXd18rpyg6tmEdM7mfe0XYJK6/W1T3Ge7Z?=
 =?us-ascii?Q?F8wLSD/L9OvDnrmDB8PDigVwn65MF4gLcxstAcPa0grFynTC2bbBDYRdMp75?=
 =?us-ascii?Q?EJQu8oYgT949wJtE13YqVEHcBW9o9n8F77PriFdmBck32RMSG+0TxhZnNDTe?=
 =?us-ascii?Q?bQNxhj2lVGJmpHcrG3s2PCNzXzp/YlFbIsmBtSBF+XsXaSoENZgulxsh9VFw?=
 =?us-ascii?Q?uyCRpU4n7fRhpBL5EeTEJl9Iuzk1EW0E6VxAMlwuYHbJU0rTBFNyA/Y/WxsK?=
 =?us-ascii?Q?ZQNGJnHATeuKYLGyaoYHy3EKClpS8M8tjWClImUOQDhw9IyHo6dSN6GK5sOy?=
 =?us-ascii?Q?sRLfk6HkBE12PG5H9fKtlp0WKy4GosA6SCdZ1XdS+1TjoWQaAajuzZoq/7Fl?=
 =?us-ascii?Q?tba36tUub4F6au3ys0TPsxLBNx8nI8Fgq1nCLmn8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a474303-8424-455d-f05c-08dc4d019186
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 19:27:11.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMMJ/b5GxHM/FqHp48NpchLaoWkOfWGP1eUBB+T8uMR0H29P8vWor2DWpUKvwTyO9fESKxss3Ld41vvIRy/k5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845

On Mon, Mar 18, 2024 at 11:28:48AM -0400, Yazen Ghannam wrote:
> On 3/14/24 12:35, John Allen wrote:
> > Data fabric 4.5 denormalization will need to frequently add and remove
> 
> More specifically, the non-power-of-2 cases will need this.
> 
> > the base and the legacy MMIO hole. Modify existing helpers to improve DF
> > 4.5 denormalization flow and add helper to remove the base and hole.
> 
> Please write the what/context, why/issue, and how/fix information as
> separate paragraphs even if they're just a single sentence each. I think
> this helps to find the details more easily.
> 
> > 
> > Signed-off-by: John Allen <john.allen@amd.com>
> > ---
> >   drivers/ras/amd/atl/core.c     | 43 ++++++++++++++++++++++------------
> >   drivers/ras/amd/atl/internal.h |  3 +++
> >   2 files changed, 31 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
> > index c1710d233adb..cafdfc57d929 100644
> > --- a/drivers/ras/amd/atl/core.c
> > +++ b/drivers/ras/amd/atl/core.c
> > @@ -49,15 +49,26 @@ static bool legacy_hole_en(struct addr_ctx *ctx)
> >   	return FIELD_GET(DF_LEGACY_MMIO_HOLE_EN, reg);
> >   }
> > -static int add_legacy_hole(struct addr_ctx *ctx)
> > +static u64 add_legacy_hole(struct addr_ctx *ctx, u64 addr)
> >   {
> >   	if (!legacy_hole_en(ctx))
> > -		return 0;
> > +		return addr;
> > -	if (ctx->addr >= df_cfg.dram_hole_base)
> > -		ctx->addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
> > +	if (addr >= df_cfg.dram_hole_base)
> > +		addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
> > -	return 0;
> > +	return addr;
> > +}
> > +
> > +static u64 remove_legacy_hole(struct addr_ctx *ctx, u64 addr)
> > +{
> > +	if (!legacy_hole_en(ctx))
> > +		return addr;
> > +
> > +	if (addr >= df_cfg.dram_hole_base)
> > +		addr -= (BIT_ULL(32) - df_cfg.dram_hole_base);
> > +
> > +	return addr;
> >   }
> >   static u64 get_base_addr(struct addr_ctx *ctx)
> > @@ -72,14 +83,16 @@ static u64 get_base_addr(struct addr_ctx *ctx)
> >   	return base_addr << DF_DRAM_BASE_LIMIT_LSB;
> >   }
> > -static int add_base_and_hole(struct addr_ctx *ctx)
> > +u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr)
> >   {
> > -	ctx->ret_addr += get_base_addr(ctx);
> > -
> > -	if (add_legacy_hole(ctx))
> > -		return -EINVAL;
> > +	addr += get_base_addr(ctx);
> > +	return add_legacy_hole(ctx, addr);
> > +}
> > -	return 0;
> > +u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr)
> > +{
> > +	addr -= get_base_addr(ctx);
> > +	return remove_legacy_hole(ctx, addr);
> 
> This should be the inverse of the "add" operation, I think. So remove
> the legacy hole first, then remove the base address.
> 
> >   }
> >   static bool late_hole_remove(struct addr_ctx *ctx)
> > @@ -123,14 +136,14 @@ unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsig
> >   	if (denormalize_address(&ctx))
> >   		return -EINVAL;
> > -	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
> > -		return -EINVAL;
> > +	if (!late_hole_remove(&ctx))
> > +		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
> >   	if (dehash_address(&ctx))
> >   		return -EINVAL;
> > -	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
> > -		return -EINVAL;
> > +	if (late_hole_remove(&ctx))
> > +		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
> >   	if (addr_over_limit(&ctx))
> >   		return -EINVAL;
> > diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> > index 1413c8ddc6c5..05b870fcb24e 100644
> > --- a/drivers/ras/amd/atl/internal.h
> > +++ b/drivers/ras/amd/atl/internal.h
> > @@ -236,6 +236,9 @@ int dehash_address(struct addr_ctx *ctx);
> >   unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
> >   unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
> > +u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
> > +u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
> 
> remove_base_and_hole() is only used in denormalize.c, correct? So why
> not define it there as static? Other than trying to keep the code
> together and symmetrical, I mean.

In addition to keeping the two inverse functions together,
remove_base_and_hole depends on other functions in core.c. So if we
don't expose remove_base_and_hole in the header, then we would need to
expose get_base_addr and remove_legacy_hole in the header.
Alternatively, we could move remove_legacy_hole to denormalize.c and
expose get_base_addr and legacy_hole_en in the header instead. So
exposing one function that's the inverse of the other just looks better
to me than exposing two.

Thanks,
John

