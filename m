Return-Path: <linux-kernel+bounces-134854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D7989B7E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7996281EDE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491322D796;
	Mon,  8 Apr 2024 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lHDvUIWL"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2982C859;
	Mon,  8 Apr 2024 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558881; cv=fail; b=Yoe/3lrzpa6ieINIfxkvcfnsc773dcQNWkefqTtsCoXAbvDR/2dqwYEg0GPu9Wa38MextHzjj5bnIg0WIwAC1mfBNySygoX39JyFUt6mGEfHGPVSpb8SYi+50dYY0szglqE3NLTS08lubI/GpCqiAlkRvCWpjdcoCKp8GNLDyow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558881; c=relaxed/simple;
	bh=PKQ47qvSrQGiPeSpS5vWDrZnRqsGUR2jvxQM+2zw30s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7gX8nAAq+GZSqtGTp9ebVgMU2Lxy1NKjwPY2mlTMoKv2M/DfhEqJxsf4U7GfvwC2XeNgHxHfTvCA2O5lt2yq2Kk4JPv5YjzAbo0lWMhJ8YY5RuoZ+SxBtATXG2pVYGfUViE/IfpZj8/pn6R2jyCnA5INbxN6gafprXNRjzhwQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lHDvUIWL; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzV9d3wVVn8okR1dtLbSMqqb1nHNBMiYd4E81o275KQVf9wbZhNWjRhIWzaVSJFsn9usay35mUw+gGUcLXq1IfqfGloE5GjyHp4TZFDOU1FECNqhANRPlLfnGWoTbyK5lSyBy5o1vXYJ8+xS2YZNR1YbTz8G/QPJzcNA+hqt5230DSecHw+qTyEALOEZdWGH15fysR/6vJflM2deOfwhqNNVpFl0VomTLCgPY4y/GC02MoSbI4UvfYVVd01tIdXkQBo5l8JI6k7G6pNOE1+XGNPmOGu2tPC94i20vLrasZM2nfn+BRtNFUyQBITb5ERzSp9PDjB7plmTHJOZvgO9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+DkSer1Qj85xRdra7I09pgKoMrlTunz/NnUtBgWwYs=;
 b=ILgPsqHJYU41OVAO9i3XEyiaPRtj6GJQ9XT/05OHrFRt4uwHcrjAfaHwbuIJ522xXmVuUGwrkOCuakSdJWto6GdN56urmDTzg6vv2HSAE1e5SyYRjYfnW8801z/4fq80AMtk0pPJD3mFqtz0sSPYvRfYVoedQ+ftgm84m7RMIGdplaiNKg1cpPb86ApyL7Xlsii6rSlqmM/+nu0qbtPyIEEZiPL+MG6STZ3JpCXmCbeAFlPP+IlrZPF6mKzTbBB2YIogxoAVCes/37a0aCUvp3feh//+BaBGIWFA9yu4tVXiMWUm+1HVh/Y1H81W6NddJjpAxaoKKr1GvbCsj/gxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+DkSer1Qj85xRdra7I09pgKoMrlTunz/NnUtBgWwYs=;
 b=lHDvUIWLE/MLGJB5YdNxgKoHMglHo8Q0Udj4r85G3qbFiwLP4IvE6Q3KbOWUQVmZiG4atSw5+yfK8jUMMKijKxv9HW4U1DwX7PAPXwMWz1eE0IOmYknUT70kvoHRfgNHog9mJgFFdeouop9QC7W9GmDkacfPUVDFVj2VaM7YibAFeivlpxvk3M9YFhNk8KyjOwIz0ftzScwQgiMTTOzH4RL1nLK2FbwixFLn0UEvHsNLoHt1de3kDMNqo5hs7nx10X+1JblIXFNcAWkv2uofZ3I9qLITX/AyOoLQ5J1rcQ8hniJnZ7smeKNYtDUqzjXOrUJR++iUiF2Rf0ypsxGSHg==
Received: from DS7PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:3bb::30)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 8 Apr 2024 06:47:56 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::67) by DS7PR03CA0085.outlook.office365.com
 (2603:10b6:5:3bb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Mon, 8 Apr 2024 06:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 06:47:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 7 Apr 2024
 23:47:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 7 Apr
 2024 23:47:42 -0700
Received: from localhost (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Sun, 7 Apr 2024
 23:47:39 -0700
Date: Mon, 8 Apr 2024 09:47:38 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
CC: <rust-for-linux@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn?= Roy Baron
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
	<linux-kernel@vger.kernel.org>, Wedson Almeida Filho
	<walmeida@microsoft.com>, John Hubbard <jhubbard@nvidia.com>, Neo Jia
	<cjia@nvidia.com>, Andy Currid <acurrid@nvidia.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
Message-ID: <20240408094738.00005e59.zhiw@nvidia.com>
In-Reply-To: <20240328013603.206764-1-wedsonaf@gmail.com>
References: <20240328013603.206764-1-wedsonaf@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: d81087c0-40f8-4919-289f-08dc5797d27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vd4Jd3CTLavxMpq+EU5k4GatRFopCjTNVeeAyG3VFper/FE3Equ6JGkxELF6bUcJZTbijIn3vaYoVat4z9ekPwNk6lrnkredvgDrJDESwjN+25IB7TJ0Jo+jqEmb/STtqxUEKMXr8ashhxb9AMf7H+tfg7lJXqXlRLo1dfzRf8pZSXe7EOLcgs965YPp0JKEW0FrkXzP/eJ1yvdrdcCwM0yQaRmdGMR9YieBHWXenfFA0x5aEn43ejtTplbr7FaWzhalabzSARglr8N71+7qw1cwMUlD+a8NmHBXVeD/CqtAxcr1iWj5VC+hFYqYzFPJRhccWFVbNvrU/0WAKwui+w3XTE3Zs7xXZpnrtP1a1uZVtVnaCOub612tRA3K5eYNOH3HK+rWycIRkaXoTA6eV1j4gYgrIaAwdekspxfMN1i0XtuDosN9ZNr3Tgh6QnvuEDuH8PBk4Lvo4mTG7WHcANEK6NRj3ZzMrfnfJbnR2DSRBfCzUIf9UNjAz9wwf4AintYkNxRfN07fO22QORClPuODz6VVg/LqmAt/VHKBCbrHJDEbDXii3ybGug8S3Q8Dj7iQuo2eJa/IJpXiLEq/DVkoCM9WUMXTPnMx9Zh94j96l6fFb8rHu+Czpm+S3vOWcXMrbG+sEdgoll1AOryg8zujFBjsVzwsasDJHIxODJe63IK1QcHXz3ZWWJ1+lm45PHGP9Av6NieeHnM8pxzvXqYOrmTU5SsJqvQ2AmmAykwbekGaJDgPLFnvhCDrkuVC
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 06:47:56.1013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81087c0-40f8-4919-289f-08dc5797d27b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543

On Wed, 27 Mar 2024 22:35:53 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Revamp how we use the `alloc` crate.
> 
> We currently have a fork of the crate with changes to `Vec`; other
> changes have been upstreamed (to the Rust project). This series
> removes the fork and exposes all the functionality as extension
> traits.
> 
> Additionally, it also introduces allocation flag parameters to all
> functions that may result in allocations (e.g., `Box::new`,
> `Arc::new`, `Vec::push`, etc.) without the `try_` prefix -- the names
> are available because we build `alloc` with `no_global_oom_handling`.
> 

IMO, It seems the allocation flag here means GFP flags according to
Patch 5 and I understand the benefit of introducing the flags.

I am interested in the future plan. With this change, will Vec and Box
stick to kernel memory application APIs with GFP flags in the future?
e.g. GUP, kmalloc, those mostly allocates continuous memory for small
objects. Is that the future for Vec and Box in kernel?

Is there any plan for having vmalloc() in rust kernel? Currently, if I
push a large object into a Vec, kernel MM will complain for sure. And
literally Vec/Box themselves don't imply to the user that they allocate
memory with limitations.

Kernel uses different MM alloc APIs for different usages. For rust,
should we have a different kind of "Vec/Box" or having a Vec/Box with
different set of allocation flags that covers both GFP MM APIs and
vmalloc()? I am curious about the plan.

> Lastly, the series also removes our reliance on the `allocator_api`
> unstable feature.
> 
> Long term, we still want to make such functionality available in
> upstream Rust, but this allows us to make progress now and reduces our
> maintainance burden.
> 
> In summary:
> 1. Removes `alloc` fork
> 2. Removes use of `allocator_api` unstable feature
> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
> 
> ---
> 
> Changes in v3:
> - Rebased on top of the latest `rust-next` branch.
> - Updated `krealloc_aligned` to use `Flags` instead of
> `bindings::gfp_t`.
> - Added __GFP_ZERO to flags, as part of the previous change.
> - Avoiding temporary stack value in `Box::new_uninit`.
> - Implement `Box::new` using `Box::new_uninit` (so only one of them
> actually allocates).
> - Added examples/tests to `VecExt` methods.
> - Fixed bug in length in `extend_from_slice`
> - Link to v2:
> https://lore.kernel.org/rust-for-linux/20240327023531.187880-1-wedsonaf@gmail.com/T/#t
> 
> Changes in v2:
> - Updated description of `alloc` crate.
> - Renamed vecext and boxext modules to vec_ext and box_ext.
> - Added derive directive to `AllocError`.
> - Updated safety comment in `BoxExt::new`.
> - Updated `VecExt::push` and `VecExt::extend_from_slice` to use
>   `spare_capacity_mut`
> - Added directive to not compile `destructure` and `rebuild` when
> `test` or `testlib` are configured. Otherwise we have a warning
> because `push` and `extend_from_slice` don't use them anymore.
> - Updated indentation in `Arc::new_uninit`
> - Moved the removal of `TryReserveError` convesion to `Error` to
> patch 7, where usage of `TryReserveError` is actually removed.
> - Link to v1:
> https://lore.kernel.org/rust-for-linux/20240325195418.166013-1-wedsonaf@gmail.com/T/#t
> 
> Wedson Almeida Filho (10):
>   rust: kernel: move `allocator` module under `alloc`
>   rust: alloc: introduce the `VecExt` trait
>   kbuild: use the upstream `alloc` crate
>   rust: alloc: remove our fork of the `alloc` crate
>   rust: alloc: introduce allocation flags
>   rust: alloc: introduce the `BoxExt` trait
>   rust: alloc: update `VecExt` to take allocation flags
>   rust: sync: update `Arc` and `UniqueArc` to take allocation flags
>   rust: init: update `init` module to take allocation flags
>   rust: kernel: remove usage of `allocator_api` unstable feature
> 
>  rust/Makefile                        |   16 +-
>  rust/alloc/README.md                 |   36 -
>  rust/alloc/alloc.rs                  |  452 ----
>  rust/alloc/boxed.rs                  | 2463 -----------------
>  rust/alloc/collections/mod.rs        |  160 --
>  rust/alloc/lib.rs                    |  288 --
>  rust/alloc/raw_vec.rs                |  611 -----
>  rust/alloc/slice.rs                  |  890 -------
>  rust/alloc/vec/drain.rs              |  255 --
>  rust/alloc/vec/extract_if.rs         |  115 -
>  rust/alloc/vec/into_iter.rs          |  454 ----
>  rust/alloc/vec/is_zero.rs            |  204 --
>  rust/alloc/vec/mod.rs                | 3683
> -------------------------- rust/alloc/vec/partial_eq.rs         |
> 49 - rust/alloc/vec/set_len_on_drop.rs    |   35 -
>  rust/alloc/vec/spec_extend.rs        |  119 -
>  rust/bindings/bindings_helper.h      |    3 +
>  rust/kernel/alloc.rs                 |   74 +
>  rust/kernel/{ => alloc}/allocator.rs |   17 +-
>  rust/kernel/alloc/box_ext.rs         |   59 +
>  rust/kernel/alloc/vec_ext.rs         |  176 ++
>  rust/kernel/error.rs                 |   13 +-
>  rust/kernel/init.rs                  |   57 +-
>  rust/kernel/lib.rs                   |    5 +-
>  rust/kernel/prelude.rs               |    2 +
>  rust/kernel/str.rs                   |    6 +-
>  rust/kernel/sync/arc.rs              |   50 +-
>  rust/kernel/sync/condvar.rs          |    2 +-
>  rust/kernel/sync/lock/mutex.rs       |    2 +-
>  rust/kernel/sync/lock/spinlock.rs    |    2 +-
>  rust/kernel/types.rs                 |    4 +-
>  rust/kernel/workqueue.rs             |   14 +-
>  samples/rust/rust_minimal.rs         |    6 +-
>  samples/rust/rust_print.rs           |    4 +-
>  scripts/generate_rust_analyzer.py    |    2 +-
>  35 files changed, 405 insertions(+), 9923 deletions(-)
>  delete mode 100644 rust/alloc/README.md
>  delete mode 100644 rust/alloc/alloc.rs
>  delete mode 100644 rust/alloc/boxed.rs
>  delete mode 100644 rust/alloc/collections/mod.rs
>  delete mode 100644 rust/alloc/lib.rs
>  delete mode 100644 rust/alloc/raw_vec.rs
>  delete mode 100644 rust/alloc/slice.rs
>  delete mode 100644 rust/alloc/vec/drain.rs
>  delete mode 100644 rust/alloc/vec/extract_if.rs
>  delete mode 100644 rust/alloc/vec/into_iter.rs
>  delete mode 100644 rust/alloc/vec/is_zero.rs
>  delete mode 100644 rust/alloc/vec/mod.rs
>  delete mode 100644 rust/alloc/vec/partial_eq.rs
>  delete mode 100644 rust/alloc/vec/set_len_on_drop.rs
>  delete mode 100644 rust/alloc/vec/spec_extend.rs
>  create mode 100644 rust/kernel/alloc.rs
>  rename rust/kernel/{ => alloc}/allocator.rs (86%)
>  create mode 100644 rust/kernel/alloc/box_ext.rs
>  create mode 100644 rust/kernel/alloc/vec_ext.rs
> 
> 
> base-commit: 768409cff6cc89fe1194da880537a09857b6e4db


