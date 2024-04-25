Return-Path: <linux-kernel+bounces-158987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42448B27D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE36B2176A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3FA14EC6D;
	Thu, 25 Apr 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KswUtNGm"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8A1482EF;
	Thu, 25 Apr 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068264; cv=fail; b=CMUCRvOV/w8fS0dPsU91kUu+ftuYzJI6oiJlSSNAioWlclcZtZBSwLD+a1R8cn6XZ/LY18GBOXfI4UvQgsxOC5Xha5hvL1xTs0EDu9IWtTlbO2wAkouBP14SIhylMICp6UHDRxdtMytfX6ZdaB7zg/gEDgT+rjz6udNg3KOjr/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068264; c=relaxed/simple;
	bh=SXt0SBwsDEsAtv22zgvi++pQRtTmdwkAFcjTEH/NEeU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSzjLT9QN4bfJ5mFwQ9Ak6uPrl+hMmLMQwG47EQ98cSTXc37T9HlHUlRZ1w424ik9QUn5b9FLjTW98oBbQECT5bS1adTZUR26wgLZ4rnLJnVzLRLPhNeQw692cMAdD2LbzsUXR5ZsD+HODsUmgWDXkSSDb/m8b/alCv2LMsXCs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KswUtNGm; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqnlA2euIKokc/SU7wkNy5zoJIX9XCQdggNSyIKCSNnAeqdf3KkNOOQPehoORAE4dWsAD9BeV3KT+P0eArrqKUGoxg+Y7e4xWa75oE01HPQw9kKkTsRMisbSxY7oojaZoKxeJI5s8hudwmgoj3I8/CGFvCoQhLTkjUMg6Jbj433RaxluvMQ9dYdDYLryoF3wCd8jhPyuPyACcoOwnL3Hqp01iZIlMna/GzS9j01dafwaepgnXDJKOLBghmuscE5OhqVd9MZ9YcyRJjTTLA8CX+Rh6Hqypu4kRHszJP1litZ3qv8NETcNSR0CcnIXZzXgDqDm7dnB65w+5ZJDtYWDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMUBAKoI/a8kjfnpKKvQxzAKqGjDAuZLNbr4GtoGlio=;
 b=Gz3HHXqnyfAoykCTJUIkb75WDr843tyJOups/JmKaFgV/y6FCIH9MT7kKwZDdBaJhEX52zO+pUmInjTQifOCt7nBlaqnhA56lGVd4G/mx5wbVK8SftOzAq3lEyfu9ITKlxOJUtqfE98vokdaDJGGwQNEO9t3KTWB11qcvbtR3zQZQmeIpKPDlDi68/rW6yG2rhf8jNbCZKMSS9FC49YPnXrL8AXgf0ZMZ0o8bhaJ/bo8MSqMdT59GH7EI+xTYROkVBqBIsNXhBmNpwX9tNYc3Tr4xe5f68bBQESVoMA5mniR5ZQMeZu1NxlbugznKsSkH6szTKywTn+vURMGHZKnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=proton.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMUBAKoI/a8kjfnpKKvQxzAKqGjDAuZLNbr4GtoGlio=;
 b=KswUtNGmQuV4jfH7qSihScreBEhivs/04U+X6iuJoHStNYC0cX3s8fJaN5Z+YYqQttGEDXfkQ5W0ozen1kuvh3+jCyRIvDKTPySnIcB+dCZy1e8mxztVDN9wkpKJwZ1gBo3i8vsxs5GSb7r0HLfp2UFhln1x7+Ci8/u7a9zasTc5chnGytFABjUH5VPcOxpEL/6MKByRH1JcBUhxSki0ZUblfkwykqHCH2RT/MFypBL3hfdUWIo1OauFRMDA0yFglGKaK7vBhMRpzRzaF0SPOdIlSpq/Y1QXhEY6bo0o/5+ZaoLqUN7BJWPbx6vJ0zOVxcM7aHLi35B+cXL9xboGBQ==
Received: from BL1PR13CA0136.namprd13.prod.outlook.com (2603:10b6:208:2bb::21)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Thu, 25 Apr
 2024 18:04:16 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:2bb:cafe::d7) by BL1PR13CA0136.outlook.office365.com
 (2603:10b6:208:2bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.13 via Frontend
 Transport; Thu, 25 Apr 2024 18:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 18:04:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 25 Apr
 2024 11:03:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 25 Apr 2024 11:03:41 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.126.190.182) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 25 Apr 2024
 11:03:38 -0700
Date: Thu, 25 Apr 2024 21:03:38 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Benno Lossin <benno.lossin@proton.me>
CC: Danilo Krummrich <dakr@redhat.com>, Wedson Almeida Filho
	<wedsonaf@gmail.com>, <rust-for-linux@vger.kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?UTF-8?Q?Bj=C3=B6rn?=
 Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg
	<a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
	<linux-kernel@vger.kernel.org>, Wedson Almeida Filho
	<walmeida@microsoft.com>, <ajanulgu@redhat.com>, Andy Currid
	<acurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>, John Hubbard
	<jhubbard@nvidia.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
Message-ID: <20240425210338.00007748.zhiw@nvidia.com>
In-Reply-To: <74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me>
References: <Zip4dFpt8xhk7UBL@cassiopeiae>
	<74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me>
Organization: NVIDIA
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: f461abfb-0050-4974-1dbf-08dc65521ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IeW72UoTJftDRkrXTTpYpP+5N5uDLfdUiImXgs80LYCf4m1sqAK1PolJHoJo?=
 =?us-ascii?Q?wD69DW9H5ASEpqzscN5QZ5zqnEw1TTZJzfnxagVhgU8BbNw0aAQjlcQULehH?=
 =?us-ascii?Q?36854E685z5kGGuHE1o/OfdoAB3c3jZlJjkrYHIhPOXi1yKMJ2q3yCcXLeTN?=
 =?us-ascii?Q?NAgwZxhEjtMHLVs0J3fscAXmYMfYDTcdV7AvFbZ9M7znZYBjki3eb+EO9b9+?=
 =?us-ascii?Q?g1CyAv90wju3amfdyevUwaUCSMgAKnu/SpOXw2E7WC+0P2n7T0teJOE+Ymz0?=
 =?us-ascii?Q?pQsffy7fSI5n1QJc7tQNTrrXH5c83FTX87hiIaliAmaYoZUIDgsz+JpjNWxY?=
 =?us-ascii?Q?VpkRSnsN2TEe9qRIKUtCmgXORqj564Tz8kbBGFZsVKmmARo9Y1jKsgPTunTl?=
 =?us-ascii?Q?o97B8qGPbZOkSPI6+DXMJXVGj3ZeXizTdc7zsjtKW4ZeiVol/9O1mDt5+cwJ?=
 =?us-ascii?Q?po0fmrX2BS1mqMxFVPgCBGTj56w+2atJD9WifQ90wf1aWGlLi7whOri2eHwM?=
 =?us-ascii?Q?iUfzc5cX4dpRet2GTpMlE9opVN5gVLe6otGSVcte4Bl6ribKH/twDCk1UmBS?=
 =?us-ascii?Q?LYg/wdNYpJ8SvHkFizqcl0VyM8qJ1EpQJxF3/akVYhd35zOa0nAM7pY27xOU?=
 =?us-ascii?Q?nqdmqwlA9bJBSqlHQ53fDBmLD/ZrvHZOSNC0p5voa+jSzmOngOLxROBnXdfu?=
 =?us-ascii?Q?uFqGQmfd8K7q/vF+sQyqUxElyzdMties2+Yf8eUIa2Rib57eJHqW4i7QuqiI?=
 =?us-ascii?Q?6bII+gOdPjc1TxS9kmdDxQnk8BXbNpdLmtV6nIOtDbMkwN+wdSrpd2UI1tOn?=
 =?us-ascii?Q?M2+kIBaz5q020oqFk7Wdyx30bACalSjTCl+R12DyYpPeJJgG3SsT+2RI1ZZQ?=
 =?us-ascii?Q?ENjNx79GmCRintsTULn4s7E30cVC9QGbS7Ox0+WYNqyK/YqB08xahDet2sH2?=
 =?us-ascii?Q?JOHnieJoBuRFcrVzz050ifDYaUqg0L/WTYeO39HNrQ7UokzLMHZcIyEveIB1?=
 =?us-ascii?Q?W8F3OnWaOuhwV+KhDyhfyPWdguwTU7TZJinWuRPyBHvHe+LfU01M2ciHek/T?=
 =?us-ascii?Q?2+eZ68cW8hD84G2QeZM74Ok/vCWW3Xsed9hBqVM9kAtmZ7cA4dVNpK8K2DC9?=
 =?us-ascii?Q?fQdPOBQFgfcOIkqIvGkXgcqB8HO9v1+c+IN5MkbHlerD2bRoTU6irfNa4v0B?=
 =?us-ascii?Q?PSUjRufl/rRTFZotsPIptLoQ5F6MURvtejqS1/b36O4ot7iA1Int4yvvUEpP?=
 =?us-ascii?Q?4xzs+/MsqcbpwkJxWejsQ5twjEM+905YKe67VLXeUds8ztOIBBRjGkKZF1F0?=
 =?us-ascii?Q?nzOPDWah2234XLKRaIa0ElcPDTv2uI799Laepf0GyfZPGaoYu5YkuCTyIle9?=
 =?us-ascii?Q?RNgg6PtDF4PmpyAJlnZ+knbwPnvq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 18:04:15.7792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f461abfb-0050-4974-1dbf-08dc65521ee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122

On Thu, 25 Apr 2024 16:09:46 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 25.04.24 17:36, Danilo Krummrich wrote:
> > (adding folks from [1])
> > 
> > On Tue, Apr 23, 2024 at 05:43:08PM +0200, Danilo Krummrich wrote:
> >> Hi all,
> >>
> >> On 3/28/24 02:35, Wedson Almeida Filho wrote:
> >>> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >>>
> >>> Revamp how we use the `alloc` crate.
> >>>
> >>> We currently have a fork of the crate with changes to `Vec`; other
> >>> changes have been upstreamed (to the Rust project). This series
> >>> removes the fork and exposes all the functionality as extension
> >>> traits.
> >>>
> >>> Additionally, it also introduces allocation flag parameters to all
> >>> functions that may result in allocations (e.g., `Box::new`,
> >>> `Arc::new`, `Vec::push`, etc.) without the `try_` prefix -- the
> >>> names are available because we build `alloc` with
> >>> `no_global_oom_handling`.
> >>>
> >>> Lastly, the series also removes our reliance on the
> >>> `allocator_api` unstable feature.
> >>>
> >>> Long term, we still want to make such functionality available in
> >>> upstream Rust, but this allows us to make progress now and
> >>> reduces our maintainance burden.
> >>>
> >>> In summary:
> >>> 1. Removes `alloc` fork
> >>> 2. Removes use of `allocator_api` unstable feature
> >>> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
> >>
> >> With that series, how do we implement alternative allocators, such
> >> as (k)vmalloc or DMA coherent?
> >>
> >> For instance, I recently sketched up some firmware bindings we
> >> want to use in Nova providing
> >>
> >> fn copy<A: core::alloc::Allocator>(&self, alloc: A) ->
> >> Result<Vec<u8, A>> [1]
> >>
> >> making use of Vec::try_with_capacity_in(). How would I implement
> >> something similar now?
> > 
> > I want to follow up on this topic after also bringing it up in
> > yesterday's weekly Rust call.
> > 
> > In the call a few ideas were discussed, e.g. whether we could just
> > re-enable the allocator_api feature and try getting it stabilized.
> > 
> > With the introduction of alloc::Flags (gfp_t abstraction)
> > allocator_api might not be a viable choice anymore.
> 
> Bringing in some more context from the meeting: Gary suggested we
> create a custom trait for allocators that can also handle allocation
> flags:
> 
>      pub trait AllocatorWithFlags: Allocator {
>          type Flags;
>          
>          fn allocate_with_flags(&self, layout: Layout, flags:
> Self::Flags) -> Result<NonNull<[u8]>, AllocError>;
> 
>          /* ... */
>      }
>      
>      impl AllocatorWithFlags for Global { /* ... */ }
>      
>      impl<T, A> VecExt<T> for Vec<T, A> where A: AllocatorWithFlags {
>          /* ... */
>      }
> 
> I think that this would work, but we would have to ensure that users
> are only allowed to call allocating functions if they are functions
> that we control. For example `Vec::try_reserve` [1] would still use
> the normal `Allocator` trait that doesn't support our flags.
> Gary noted that this could be solved by `klint` [2].
> 
> 
> But we only need to extend the allocator API, if you want to use the
> std library types that allocate. If you would also be happy with a
> custom newtype wrapper, then we could also do that.
> I think that we probably want a more general solution (ie `Allocator`
> enriched with flags), but we would have to design that before you can
> use it.
> 

I agree that we should have a trait for allocator API. I think the
purpose of the trait is serving different upper-layer memory allocation
APIs that wants to have Vec/Box kind-like methods.

Look at the rust DMA memory allocation nowadays, there is already a
similar kind of of allocator with similar requirements. They might sit
on the same allocator API and implement traits with their kernel memory
allocation APIs if the trait is properly defined.

I think it is essential for a kernel driver to know the essence of the
heap that a Vec/Box is using. Hiding it away from the driver doesn't
look promising to me.

For wrapping the kernel memory allocation APIs, it can be done by
either having one unique Vec/Box API with different flags or having
different kind of xxVec/xxBox (Maybe it doesn't even need to be named
as xxVec or xxBox). Personally, I prefer the later approach that is
identical to the current kernel memory allocation APIs and more
straight-forward.

Thanks,
Zhi.

> 
> [1]:
> https://doc.rust-lang.org/alloc/vec/struct.Vec.html#method.try_reserve
> [2]: https://github.com/Rust-for-Linux/klint
> 
> > 
> > I think it would work for (k)vmalloc, where we could pass the page
> > flags through const generics for instance.
> > 
> > But I don't see how it could work with kmem_cache, where we can't
> > just create a new allocator instance when we want to change the
> > page flags, but need to support allocations with different page
> > flags on the same allocator (same kmem_cache) instance.
> 
> I think that you can write the `kmem_cache` abstraction without using
> the allocator api. You just give the function that allocates a `flags`
> argument like in C.
> 
> The `Allocator` API might make it more *convenient* to use it, because
> you don't have to explicitly pass the flags every time (since the
> flags are determined by the allocator). But I have also heard that it
> might be desirable to always be explicit.
> 


