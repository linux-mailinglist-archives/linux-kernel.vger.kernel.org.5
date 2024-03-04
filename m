Return-Path: <linux-kernel+bounces-90594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A08701E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D560B288133
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F733D3B4;
	Mon,  4 Mar 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D08RvdTv"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A022606
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557110; cv=fail; b=Lq6MO4l6x3nqg0DQVVgA7AkPffKgj34uRKP0qMRYUFG3OeoC/w3yT+veTvPk57ujn2h0WbDOt75Py5n9lOQKSFp1M0Wp4q2d5OoM88ggHLGroOlWSMcGYWP7TJeQ1p3s1DNsdC4cETyxtFfs02sA7Flq7YIU1ArYCaFIT5sl8G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557110; c=relaxed/simple;
	bh=q+X5Z6Mlph/Kwoor0yQJd7RDOWkFwjOOz4sCsI5mPqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qGJ7wFWbImTXiqL0kPl8W9aKlYzQzOmmP/8UZfiCtTOeYj/kNIsI8IqWcojmOmQl6RZe8zZojqtfuBr95So/WGTN8ZBxTgHPAhZ5IpozMMxzPlNEVS3bn1AyaZ2995Q/XJ8GpKABBg8smDXNheskfxCArQbY5YcRMCL6Pj2qC3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D08RvdTv; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA5VUs2AnTCKTM3gMtRVY1/RWsSlaSEjOfa+0Dn7IYwRLFOKkTAjOtTWJCWs7RyINxtnLFjMrRdwMCDbobQ/vjRsTVym4iV2Y0Chv5JJ+tdABQj4jBvcboWEAS1bqAmKyu255c/rpUxN3CyfIbhvzoBZDsYdW4enM8eVLhUVFB31Z1JsnXZWTAjSZh8Hk5Kh2wAFam4X7e9cl8ccMgHsl6qIvFnqwVw4iRk0JZmOB2xWSNBrCwKYDAZuqQs6WLyzANTqI8aQWc+AdShzbCUP717mdXBjywaOwjdUGXUwuP6rWc3NSNRjqjJHWqKC9txvbSqbpdhOj31EYzvYJsaMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xobYo8peUDqewntv+3u/Rp11eU8JuHV6j4nGYwbo2T8=;
 b=f97ti5R7in0bQvxtcfMRM0ekI8DXn+JW4wzfHpuN9iSh1xgw821SgoNexJcbNjmomZrGV49nVgB0Kazj/uTgeK/DOtuSL6EYaq46FlH7WusYDMJ1/ZQL2GCLOGPHMIjSw6PShVryJsLCMDiZnQGeHl7n5PqLweBp7qSP9hqI2gR6239aYUMGdpmb/0zMs06GCttw2D2e+1u8E0NklELTfQbiCLe51JFyRVz6XfCIMawGJkys2z+ecYDE2UTGs4RVn3M2TMnQXteZQfiTXMKTy6TBQA8BYjj5yiohqleBCUEnE0J5vcKUXlyto9BGfonSa6tfY3h21tEcuTGGR7kynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xobYo8peUDqewntv+3u/Rp11eU8JuHV6j4nGYwbo2T8=;
 b=D08RvdTvMTfiv+XJQIrrq3NRbfee4j16JWHTRc9bAYmNH3V8gNDgbw7bond0x/ISgFE/ECPHtOclUBeGUiT2IxNCobMH46OJKJYGB3yV1cubsrZopXTtaCCCE/8YbEhdE9au73FK+FsvLIk/Tctgr21JagaCoJvYl9w4TBz9Bp9PHRjHOm9jCjlSDJDA+jh0wp/yNdfaBEQaSWJ5mA2Ov8Q80rIGvhnwdD4xbcV9wK/NF0VyBmGcOjlU1yXkLVFbeZ4MGKakowHLHejyBmAoZR+OvGqWuUaM0H5xFHLg9E/wc8XTLbGj27cE+OakXLzpob2nvbeCEI+3H1GRYozJSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 12:58:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 12:58:26 +0000
Date: Mon, 4 Mar 2024 08:58:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 3/7] mm/x86: Replace p4d_large() with p4d_leaf()
Message-ID: <20240304125824.GQ9179@nvidia.com>
References: <20240229084258.599774-1-peterx@redhat.com>
 <20240229084258.599774-4-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229084258.599774-4-peterx@redhat.com>
X-ClientProxiedBy: SN7P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b38d0c-919f-4958-c623-08dc3c4ac818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZPu0t9k7TYI3bIyKOBfYKdhavqGPsq7QXUGAlztjoRrkF5lF1HpCDGmXzqaDcrTJNuVTXqrPbPdmVig6lsda8P+0cshIicWHN4lZ0bL5Z3meJ66KuW+ggLmGvZlUtp8Bm/yniagQJwGts2SAk3LsI5MAdKhKSg908iX8DwqeHvcD4NFp7WmHmjBF1X2iHr1fkA4SijksL9KX8bWzDcNdyU5xJ6IIv7N+F6+ek5+Ae7L7PlSL1eMfyZVQAohXjpN4YD1Z7xdauFvmehU4z+Wu9Sw5Z1ALRNKr40dd66UTMPLJO7ryJlmULNula63x9X2N77iSC7BKShezsrvPIomb6k4JQQey2adU/w81c5A3rSj73VZqASi776Zy687v+RCMQE2p/1bIDqHB+13DglmkmdVS0RL/oO/Z180+wuku/UENcr5BFvE85X/f/jnCkRZvOF2sL+f3dDEQ4Cb0LRpAUQp7SCyYkVxTlJSdNQ19fFrmgdynL7792UoFq2oMo0mS+64gpJ6mvpUWOvvsDQ4IqtbW9SWoguakVm8hx4o+wfKIs500B+xB0Nz8fhH8773kQ0roy2FPFgQ6/y2OS2YvxtpZxX9xE4kaMoK3Yf7G2Rnk3mAdB0Hz3lFSf3Tnl0J+hxRw5Z6cRDhY7a6Qy/p0J/P2xs9AH2y/fzTD6VL8ZTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLfXtoYkYAKc/vX/S6X/KkoGhUrVU0YibyhebyGU0e+64YOJ9gw30ORKVECt?=
 =?us-ascii?Q?igvabsU1IvOZqZqfNJ7TDj1H+ZZ1Bj0gAr4l7ppNeYUMZApN8ewGFMSO5ZGs?=
 =?us-ascii?Q?HmkjiUC/b4p3fRMs4BVRUttPcm9vRMNreLkJvxy+IF5k4/Xh9GZ659NYh/Ne?=
 =?us-ascii?Q?uiBc5ikJLEVdudQATp3ouDlHB+HSw+Ey/AE6bjLMy1f6SNv8vQMqXdBGKhu3?=
 =?us-ascii?Q?jzO96lCnQCwBmGJcXbjt/QOrkike+LinFgRu61nFVGPkjl7gNmgpDCG0KLw3?=
 =?us-ascii?Q?CUzjLKDSzWuywjTzSPLfIm2DWpSCzWCCB2vsmT1xHaGK+5hX7Hn1ufMg+XMe?=
 =?us-ascii?Q?8LNPR4vGF99uDGj7ZWwqwRIj7kidOFBpaylulWFInueZW8t+sp813ZRAeIjM?=
 =?us-ascii?Q?PaOShrzsqKrz9oJuTDPd3HgDHhR2nzxkFM5uEhSPmMkKX/EGmLWIkJNxy6KU?=
 =?us-ascii?Q?i4zP7xjGS7HQ6CZF48cNdLVavLhY3F5w1vckt+6+JERS65ckPl7rd48KZas7?=
 =?us-ascii?Q?/+to0catgTWyHOAZ45yPYh+qPeZfDJuWrsJQ5pnprjOMxFBQ+V5P4iyhbB0C?=
 =?us-ascii?Q?TUQBKFv98c1AT4b0/pvCEVKnrlJqMurlBrt8xwpWSdfvi/57lqrEtraWMK/y?=
 =?us-ascii?Q?dSL5veTaVo7duGydWAFIH5isweUx8ouu6qLYvQvufndnuRajqMSRKfyy38gF?=
 =?us-ascii?Q?D76q+WXpcTA0cZMbf3jduzcVOk11BqpNFyQEen3ZmHeDwSkya7wqPS2JV2g3?=
 =?us-ascii?Q?fkB3kDfk6wS+z750SdsLNUv16n4yd/BlLUkACEtms0JHN90aQxB+AmqJkAy9?=
 =?us-ascii?Q?yk9bobU7M6bic+II2s6ufU2EDkcf9fOs+RoW1fUizzxgH/YsKl3Lb6JmrbAJ?=
 =?us-ascii?Q?/eOaSt7If9L9HlGk/hs2GQoCvab1JznexS3X8CT80Xqn/NPhvXtJ/QOlu4cN?=
 =?us-ascii?Q?QMoGQyXbSBJ+W73fJlUZvUkYYYmE1Y/mBqvSR/C1xRmfEh5rPV1Ty649MzDm?=
 =?us-ascii?Q?V1e67n+taxWpmkg7UDG4F6N330qkOGo6fF/Vm9L9M7F9GQ/3qQgITrYKgLNw?=
 =?us-ascii?Q?a5g0SFRPMkl87rUQoTeJ0EIQnnnI4U3vsxnwtQgJ84pxBMzaWn8bHfngDLUV?=
 =?us-ascii?Q?CXrABR+GWnWi8xDGnTDOYjyWRF6YcZ52+mkg7MCwxf06jPmExhxfGEgaLy0l?=
 =?us-ascii?Q?Kd7obqAV3ZpdLCs9emUram8+Ov3pEwmAeePQCFpFcIzxY/SEG1C+zjf3a2o3?=
 =?us-ascii?Q?/JvZjZcdyJdLbivoblxk6jdBeWtZg053A/5xWek2fC/TUGCjFrs9DgFJfla9?=
 =?us-ascii?Q?YXIKvcs3WlDP3cE7opkpEOWoxh4DjvnvfgOPfbItqmKtHHoiCZbdJjOmWwPk?=
 =?us-ascii?Q?Yw5ILbxEX0EHNruY2CJFSf8kNrAH8+wjCv5522QbS6INVT7xJy3owJ8E+5om?=
 =?us-ascii?Q?blW39CTmaeDCeIbfnMK03unyYF3nVDW6gYyBWmmuLwYevbQy2D+yrJ8JO3ax?=
 =?us-ascii?Q?kcORbsw455iAaOK8VosY++2UeLY1uX3lEquLeYONWBB3m2Hd7QvwxIqRg30x?=
 =?us-ascii?Q?KB1MbWb3qRcdtRrXkeE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b38d0c-919f-4958-c623-08dc3c4ac818
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 12:58:26.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/+DyZOFXMNzHUc6ncTApWUU2iRseFDLz1crCiY/7JRTXu6WFUJKahFK1WWAfUjR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102

On Thu, Feb 29, 2024 at 04:42:54PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> p4d_large() is always defined as p4d_leaf().  Merge their usages.  Chose
> p4d_leaf() because p4d_leaf() is a global API, while p4d_large() is not.
> 
> Only x86 has p4d_leaf() defined as of now.  So it also means after this
> patch we removed all p4d_large() usages.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/mm/fault.c          | 4 ++--
>  arch/x86/mm/init_64.c        | 2 +-
>  arch/x86/mm/pat/set_memory.c | 4 ++--
>  arch/x86/mm/pti.c            | 2 +-
>  arch/x86/power/hibernate.c   | 2 +-
>  arch/x86/xen/mmu_pv.c        | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

