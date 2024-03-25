Return-Path: <linux-kernel+bounces-117875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C1888B0AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6EB1C3EA05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F093EA95;
	Mon, 25 Mar 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EjDJ8iFo"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2101.outbound.protection.outlook.com [40.107.100.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176053DB9B;
	Mon, 25 Mar 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396693; cv=fail; b=u5Wxzlm4WnE0qq1r34OXQR8Pe/2vvJ6O23Hta6eDFPUVchTaTLF2u5kTyGY5ZViVTZ+GOEM5/mAc2fkGNC5huo5suOCD8QX3MOJ/gN/VgEHDU+DPzGYHMOFi7tPUNaWpIe8Z+JKzkUfBsjNxvt9TGQH1cm1avyg4u0cMxWbo2hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396693; c=relaxed/simple;
	bh=mYq1bNSYCB9XzfuGEeSP6emcXnF8MzNlCFZUL4X0+rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wb41QU1Zdj+rqcMWYLj/3+YVmPRTjO+VdbEJn+At06ZPI08UT7o7fAkDz7ZDTU22yz0kB/rHm48EJAA7biLeimdfh10tajT0DOnWMh4+uWhiHJhxlg69X4zpT7li1KzqEAvHXWEiZ07t4ddUr2yjohrHPnIHXe+e2qcxxBQ0I8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EjDJ8iFo; arc=fail smtp.client-ip=40.107.100.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un9zBHIVfGumc7v9ZpR1c/KkU2Smw459WjH3itr+2MoK63XUFEXcIgRO9YsiRzNHmZgtWomStAosd/qWCm+ZaF5IWo0YVYC0onngtWCKeWUNNQ5rBKvOmVtXoKU8h4MY8VK2yx0Cz3PXo5guzeaAtfjppbxCH5fCM7cAf6oYJXWHWnsdXQyR52WzhZmjS2xyDCN6/EIrA+7VfUHTrcMBbIWdxC0hrYLaANNRKBjyXcmxDQDr521gQynyeRDkp6tXh3jA5DC+KxTCR4J+xRihd2MkxIAJMQKKv1XnapIWC/DjXNlB3Mos66CU5r2fhHhWHC1xlSY2eIFB/WYe24WItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKXjGYOqOU/SMbwKK/ZLNZUU+t5ST5A6lmsS6L+ZXhk=;
 b=WR3rV8+O1AQ7tx0fJtKikCWLhmM4vAQqf6uCOISTrp7ol0HtnG0DjuISx9TTTuZOPwLfYjcFUwR2dlvku8o5kxmkOHTS+lkePumy8JPE6CKwFH84akZwQbJxXmnp6oyNW5YXGlU+ppn8XSb6Ah3IaPM6VtiIeLUZPHYAnhothgJ9uGXc7iEZWJ90lniwOk3FAJhVkbL83/0UAcOywE9FuotzRHmUzQnI94g33pvRKPxl8tSvoumEiWOYpZyC26oTXwmWyz4nt/1Eii/V7ttgk87q3+R5w9Fsi8gO0APVp9exu4oCGqQy29nhb1bmwQxikhitNThhUgPqUEWquX9REA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKXjGYOqOU/SMbwKK/ZLNZUU+t5ST5A6lmsS6L+ZXhk=;
 b=EjDJ8iFoxYmuRQeEHMTWY1ZnOhZtTEC4muJZ9wH89tsxQHuyS2Za326v4XmoA/n0HnOxtqbClNFHRJ5i4bGDy/EbdFFXku6mALKASlbkqaFeR/R9gvLStMrkr6veYWNXjwfx3u41V30KHAKPIkyBQq+o7t9MKOoDd+YBCfxbThs=
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 19:58:08 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::319f:fe56:89b9:4638]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::319f:fe56:89b9:4638%6]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 19:58:07 +0000
Date: Mon, 25 Mar 2024 14:57:59 -0500
From: John Allen <john.allen@amd.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: bp@alien8.de, linux-edac@vger.kernel.org, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH 3/4] RAS: ATL: Add map_bits_valid to header
Message-ID: <ZgHXR8O7CIoOmfvM@AUS-L1-JOHALLEN.amd.com>
References: <20240314163527.63321-1-john.allen@amd.com>
 <20240314163527.63321-4-john.allen@amd.com>
 <893141c6-41f8-415a-a1a3-d3e4267ec333@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893141c6-41f8-415a-a1a3-d3e4267ec333@amd.com>
X-ClientProxiedBy: PH7PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:510:324::11) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|DM6PR12MB4468:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s0PNXTi3zR2qH5xY91MwgXQiyEVxue3eOclYb3ebiIDgUFo502L9X8ACgj9UQY6ftVLJ59KVPoYAp3i7XQ0qnv2PlEFqEQhb1VUp66TKhRn647rY3O8iEFDUTFLBxHylz15rkHhnKtMDHLn/RJthmD0+YjOQb3vFyvLBxQZTR98XgPKSoRrMzbSzXi+PrdzoumQcBMwsO3ilJC/5cXY0UjO0LOKQv4Frp/ySrjZCibBMc2sX1chY0uLehVLhv5K1CPtxC4ED12bVfGWJeAdftjBkUn2XnwFKr9IWfiaAzwH5dHmBUAnd+iZbEFBDqjR8TeNiSQxQzkHAvbdWTIS+HLf765Lfr2u5f0BZfGALknMudLrAURzvwYq1uoUbNun//pAbzF66oeEp0Go6KbMe7ZsyXRlnuFV9dL2yvlMtBT3OCrR//KLHJV5a3SD01eBcotXxtPO5SV5a+7WJLN5ym89x9Ga/m+vrOTRYvZMnP5fTnb7lao5eb19uUfG3GrawU2GXTJUptvl6QOFzCIATqy5W9sicZfMcek9cVh1nGs2zS37EPUlXBMXlxRkKTvXh6MRPTwoKZRoS7hyzLVxxSHqT/qng8yo/tq3c70NffuJLlTCi25FvwjueXE3LzZeEXsTrxeycgbXoiwGJgkigLtTtih7iPONnJbKMtbEPvM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kx/6VafgQsGVsTrb4QdF9DjlGCtlXfoj4BHgepTTC7aGl+0Nst6BR1K8UVRn?=
 =?us-ascii?Q?Htupwe6jg1A9LQlQCpAdEIu78R4cAXsfZUYp+xvVGlvmlo6qxdlALJ0Qxjcu?=
 =?us-ascii?Q?B7TqsCwzX0BdxXoiGUMJ1F9Z5+yxXDPa4hjxYZITWuUYKQlsJfU4Shilum51?=
 =?us-ascii?Q?pnessb/tovN4vm5XWTOJRxkDRRriw0goB7zsS5H0mNm63zp+c2ixUXEEytbg?=
 =?us-ascii?Q?XeaN68wvuA++jugUj3NBBMp2f3YGXSGyojy6emULJeKFzQkXjU+7kPLUG7ii?=
 =?us-ascii?Q?u+TjtSsehdpBCLa6AkLyGEV0Rhl4b6VoCAG6LyZrm8qFwAZmbpej7l22CIX1?=
 =?us-ascii?Q?5OJbpKoiYGJuvO7sTYRFuzvfop3YqyP6r/ai8eUi2xqKfQiPvVk5j+bHqyaf?=
 =?us-ascii?Q?iHGAjsGSCG1ntkQnpbrDeIjfiSQK2PqxgX7g6oqgrJa0Vsfkw8LAtdlJ3afJ?=
 =?us-ascii?Q?n/tQdtpVBdJHU0xNnXU/RaxqtEGldeFxUiGjCuu8k3El2xeAi76/LjF7jXGe?=
 =?us-ascii?Q?q18GZHKhIo1YZQoCaaXQzcI2QsDBoCut+/YcTvpMW4fB5Vy3J49Y9H0FjDKw?=
 =?us-ascii?Q?ubpcZGggvCF1XpKzqV7GnZ04gmmlV+dNhN9T6QS5+PBh00NzEYI4XIPTlLt8?=
 =?us-ascii?Q?i2pJ68hwj3BYpUacb94ll8CHXTrXZufpIZQQEKdc8wMkfdoMTPTvZvYjHqfs?=
 =?us-ascii?Q?ol9PSFCkQ07jkFphsOtJ5qSu+AaC0W+RkPHzl+0Z5srgx3w+YUKyyZ06cvCI?=
 =?us-ascii?Q?TtnqoZW437NlCIyIzZhnusk7d591NXnxQMiv1xbbsLNMQGlnKFKOf6wiIEoP?=
 =?us-ascii?Q?r2dhQ8kOnibDp2hrHAU3m+pq1B3Jr5o2S2alxb7/d3YMuhlz2xsfLVA/+GUz?=
 =?us-ascii?Q?OOH0vzhgh9XbmHi+OPL09gpcKc+hZfbm25ilw47iqdCnZL+mlS9EDCLwXo9O?=
 =?us-ascii?Q?5xB9r0XNPmy5ou/bxbOk4OHHCEqEPHdcKP4pBPzlpUa7n69GdYNjumIYyHuX?=
 =?us-ascii?Q?z90LY7p2J4h19JRlIxLYwNBRG0ll2K/YA+Q72LkUKpz7RAKa4n/LJ/4lPtpQ?=
 =?us-ascii?Q?4/scG/uKcVhpIxr2H2YpG3fBQyyrL6QH/LXunYFv0A3I/CfxAWjy/MevvJbq?=
 =?us-ascii?Q?RS3eD6bY0JGZVeo+0IA18gpGKYYl5sWlNogeLkXuF2N8iO4rdRB4VACGVeM0?=
 =?us-ascii?Q?0d23+NYE+nd9PYG90XfEVDhKIJyCUbGJuFaFQ5Y7DQ7ShCQMYFry52UbERjc?=
 =?us-ascii?Q?WkP4GUfUS3S16KPQtCWfuLQsDo1k91P0z5BEEhFm4TU3Zubhm4fmoe07Fv/t?=
 =?us-ascii?Q?WR8oAXQV/LeSHLUXacGecWQsj+olJxMSeT1xG6/PUx98qUlEbFa71Vt0FrEj?=
 =?us-ascii?Q?2pw598Ml7ceWZg6PKGxq2Nusd0JCNiQ2qmPotxgw0rjbEEBaYI9JE8YZanEZ?=
 =?us-ascii?Q?5WDfB3aSQ4qUEZrJaOAj0emhDOuanyHnQh5uhqbVAupfzchusJfaM+XMw0nZ?=
 =?us-ascii?Q?apVqMK0i0Hl3XWInoR/3mVZlI3GE3AKcE85LikcMSeocGbBRHQ5GZNaE0UNh?=
 =?us-ascii?Q?kq4iF+2TxLJwqjNXvAr6C9ib2N/Z5XtCA1N5RTDu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba43286-95be-4466-40a1-08dc4d05e402
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 19:58:07.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCYqNsiUuJNEOgNS2G1vEWKPrroGzEW+LqNK4O2bjDID2P5pNmDuJPSO/dDgjxW6PamaAtoYftszahldRZCoig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

On Mon, Mar 18, 2024 at 11:46:39AM -0400, Yazen Ghannam wrote:
> On 3/14/24 12:35, John Allen wrote:
> > Make map_bits_valid available in the AMD ATL internal header as the
> > function can be used in other parts of the library.
> > 
> > Signed-off-by: John Allen <john.allen@amd.com>
> > ---
> >   drivers/ras/amd/atl/dehash.c   | 2 +-
> >   drivers/ras/amd/atl/internal.h | 3 +++
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
> > index 4ea46262c4f5..a20cf615b83a 100644
> > --- a/drivers/ras/amd/atl/dehash.c
> > +++ b/drivers/ras/amd/atl/dehash.c
> > @@ -19,7 +19,7 @@
> >    * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
> >    * respective interleaving is disabled.
> >    */
> > -static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
> > +inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
> >   				  u8 num_intlv_dies, u8 num_intlv_sockets)
> >   {
> >   	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
> > diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> > index 05b870fcb24e..4681449321de 100644
> > --- a/drivers/ras/amd/atl/internal.h
> > +++ b/drivers/ras/amd/atl/internal.h
> > @@ -239,6 +239,9 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
> >   u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
> >   u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
> > +inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
> > +			   u8 num_intlv_dies, u8 num_intlv_sockets);
> > +
> >   /*
> >    * Make a gap in @data that is @num_bits long starting at @bit_num.
> >    * e.g. data		= 11111111'b
> 
> Ultimately, the maps should be validated as soon as they are gathered. I
> figured we would do that later. But that would wipe out this change.
> And, after looking at dehash.c again, map_bits_valid() isn't used in too
> many places right now.
> 
> So I think validate_address_map() from the following patch should be
> done for all modes first. That way we don't need to add and then remove
> this function from the header.

I'm not sure I understand. Are you saying that we should just move the
map_bits_valid function to map.c and then make the map_bits_valid calls
that are currently in dehash.c to validate_address_map?

Thanks,
John

