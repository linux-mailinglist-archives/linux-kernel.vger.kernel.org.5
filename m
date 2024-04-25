Return-Path: <linux-kernel+bounces-158815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A68B253D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFDA1C22100
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D214B094;
	Thu, 25 Apr 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E65cleXw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B917FBB0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059391; cv=none; b=EVtnpyvSaquYUDuMN8iPIy3Yy47L37GDFZUpJ0Nvwu0AUf58KG49NbFaJIRyPHwnbRElCZGXlLJiV3URXiUZ8mw64zYLvFj5CaQLjLvn7KkHWzjdJdKtlhI3yPnS9/2m3zI3iWDzDWXX9JmLsQqfVHPRFQXPsrl4Kqkh/QAi9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059391; c=relaxed/simple;
	bh=WjDBIMcb7Z/djvyYzrIXjgOygVW96mvVWV/YViPU0mE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kCHvJ6vJOFTvxWJ4V6e2PtGdpLAm+JQpAjFjsQYet7Hl42YomMtR2dAeb7X5o9tkKFHxIoePJvAv0U4unYf+ECb1VWXcUQnQqzhk4rJORr17zX7HGqDLuuHu4FaF91ho/4uluPF7QvGHwe/mN/ki99jzOn2NIrV1yFBtzk9lybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E65cleXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714059387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=wm/bDQ2CJwJaBgMxRCiDr2NfP9BS/U56N3DlTTB7Mp4=;
	b=E65cleXwIIbv3eYYluisjn84rp8JmBzdR/unWqGWeNXHm5Fctmp4Vu6sUsI4tli0MiTqg3
	TcF5jNKmann7kiegj7ReY6fpwBpcFiKGNuKPskxH5OzzSzIDCN2f/LiYnsR+kaiXieVHo6
	FWlqwZv0axT44tXj9+fHQXQl3xbhfTA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-aSgvuHSSOOSDKYU0T5ydLw-1; Thu, 25 Apr 2024 11:36:26 -0400
X-MC-Unique: aSgvuHSSOOSDKYU0T5ydLw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34b5bece899so757162f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059385; x=1714664185;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wm/bDQ2CJwJaBgMxRCiDr2NfP9BS/U56N3DlTTB7Mp4=;
        b=dKmVVDc8zWWlQucbMr/sUYE5ycZLXJdRIByn81tDd7WWxR7wI4b+AD+igbvV/2e7LN
         8VYtxdwi5/AQoKUCIVgpgijaBr0r1sdQOkP/7BUqX9fZdhc8h5ORvXzJf/DEPdd1eirT
         brt1HSRMk7m1rm/SDhm3Kdr9K8FZk2ryqTfFOL9mYL2iB1UiMBq9nH1EAJu1b7c5AlRd
         J1WZlJxulv4o0z3JKQ1n8zM84x41MCcWafjvskaM3wSgkpVLv+Pv6pn8CKQ9avwwmnMI
         Tw5kKgTS2pfeqWiRsXIapfY8bzsv4c/d/49k7ROBCYy4b1Ph5DWYNptKv/jaDX3orDTF
         uJkw==
X-Forwarded-Encrypted: i=1; AJvYcCVW8Bhgap2a7A5naEYDo5NGlSgbmI8RBNRWKEbZYWqrmZZwSSyS303tZzIWZ7fbmonfUZ4TS082f6VUxMym2W/8YUw6eUj6eKDh3MhK
X-Gm-Message-State: AOJu0YxrG3IteuKr7S3QqLjGbS7QlUXoP32iGu4lU/spxTKWdLs3VkgI
	f+8NADNG0J18wlElx0/bpe/JJ3JO4uQ3GnO0uneoC2NEwakIib9BHzUqCOchimoKJi+Sbt/+7F+
	EvxDHPF8ema2tRohsFsbOfNflF4N3jpjDyRPFjlE1d3VqwKv8dYaLyYzLq2shcw==
X-Received: by 2002:adf:f70d:0:b0:346:f830:8a53 with SMTP id r13-20020adff70d000000b00346f8308a53mr4675430wrp.1.1714059384579;
        Thu, 25 Apr 2024 08:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5ZHd6JoD03ue53EPEGvwersTc3pFDQuhz/2riBWbEoMOcdB+IHqMk/1/G5xxJCdQUEtGzOQ==
X-Received: by 2002:adf:f70d:0:b0:346:f830:8a53 with SMTP id r13-20020adff70d000000b00346f8308a53mr4675400wrp.1.1714059383861;
        Thu, 25 Apr 2024 08:36:23 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id g4-20020adff3c4000000b00343c1cd5aedsm20080251wrp.52.2024.04.25.08.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:36:23 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:36:20 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>, Zhi Wang <zhiw@nvidia.com>,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>, ajanulgu@redhat.com,
	Andy Currid <acurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
Message-ID: <Zip4dFpt8xhk7UBL@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbeae504-2752-4ef0-b103-e62fcf45ab93@redhat.com>

(adding folks from [1])

On Tue, Apr 23, 2024 at 05:43:08PM +0200, Danilo Krummrich wrote:
> Hi all,
> 
> On 3/28/24 02:35, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > Revamp how we use the `alloc` crate.
> > 
> > We currently have a fork of the crate with changes to `Vec`; other
> > changes have been upstreamed (to the Rust project). This series removes
> > the fork and exposes all the functionality as extension traits.
> > 
> > Additionally, it also introduces allocation flag parameters to all
> > functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
> > `Vec::push`, etc.) without the `try_` prefix -- the names are available
> > because we build `alloc` with `no_global_oom_handling`.
> > 
> > Lastly, the series also removes our reliance on the `allocator_api`
> > unstable feature.
> > 
> > Long term, we still want to make such functionality available in
> > upstream Rust, but this allows us to make progress now and reduces our
> > maintainance burden.
> > 
> > In summary:
> > 1. Removes `alloc` fork
> > 2. Removes use of `allocator_api` unstable feature
> > 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
> 
> With that series, how do we implement alternative allocators, such as
> (k)vmalloc or DMA coherent?
> 
> For instance, I recently sketched up some firmware bindings we want to
> use in Nova providing
> 
> fn copy<A: core::alloc::Allocator>(&self, alloc: A) -> Result<Vec<u8, A>>
> [1]
> 
> making use of Vec::try_with_capacity_in(). How would I implement
> something similar now?

I want to follow up on this topic after also bringing it up in yesterday's
weekly Rust call.

In the call a few ideas were discussed, e.g. whether we could just re-enable the
allocator_api feature and try getting it stabilized.

With the introduction of alloc::Flags (gfp_t abstraction) allocator_api might
not be a viable choice anymore.

I think it would work for (k)vmalloc, where we could pass the page flags through
const generics for instance.

But I don't see how it could work with kmem_cache, where we can't just create a
new allocator instance when we want to change the page flags, but need to
support allocations with different page flags on the same allocator (same
kmem_cache) instance.

So, I think we have to create our own allocator trait / API.

Any other thoughts on that?

- Danilo

[1] https://lore.kernel.org/rust-for-linux/20240408094738.00005e59.zhiw@nvidia.com/

> 
> - Danilo
> 
> [1] https://gitlab.freedesktop.org/drm/nova/-/blob/topic/firmware/rust/kernel/firmware.rs?ref_type=heads#L63
> 
> > 
> > ---
> > 
> > Changes in v3:
> > - Rebased on top of the latest `rust-next` branch.
> > - Updated `krealloc_aligned` to use `Flags` instead of `bindings::gfp_t`.
> > - Added __GFP_ZERO to flags, as part of the previous change.
> > - Avoiding temporary stack value in `Box::new_uninit`.
> > - Implement `Box::new` using `Box::new_uninit` (so only one of them actually
> >    allocates).
> > - Added examples/tests to `VecExt` methods.
> > - Fixed bug in length in `extend_from_slice`
> > - Link to v2: https://lore.kernel.org/rust-for-linux/20240327023531.187880-1-wedsonaf@gmail.com/T/#t
> > 
> > Changes in v2:
> > - Updated description of `alloc` crate.
> > - Renamed vecext and boxext modules to vec_ext and box_ext.
> > - Added derive directive to `AllocError`.
> > - Updated safety comment in `BoxExt::new`.
> > - Updated `VecExt::push` and `VecExt::extend_from_slice` to use
> >    `spare_capacity_mut`
> > - Added directive to not compile `destructure` and `rebuild` when `test` or
> >    `testlib` are configured. Otherwise we have a warning because `push` and
> >    `extend_from_slice` don't use them anymore.
> > - Updated indentation in `Arc::new_uninit`
> > - Moved the removal of `TryReserveError` convesion to `Error` to patch 7, where
> >    usage of `TryReserveError` is actually removed.
> > - Link to v1: https://lore.kernel.org/rust-for-linux/20240325195418.166013-1-wedsonaf@gmail.com/T/#t
> > 
> > Wedson Almeida Filho (10):
> >    rust: kernel: move `allocator` module under `alloc`
> >    rust: alloc: introduce the `VecExt` trait
> >    kbuild: use the upstream `alloc` crate
> >    rust: alloc: remove our fork of the `alloc` crate
> >    rust: alloc: introduce allocation flags
> >    rust: alloc: introduce the `BoxExt` trait
> >    rust: alloc: update `VecExt` to take allocation flags
> >    rust: sync: update `Arc` and `UniqueArc` to take allocation flags
> >    rust: init: update `init` module to take allocation flags
> >    rust: kernel: remove usage of `allocator_api` unstable feature
> > 
> >   rust/Makefile                        |   16 +-
> >   rust/alloc/README.md                 |   36 -
> >   rust/alloc/alloc.rs                  |  452 ----
> >   rust/alloc/boxed.rs                  | 2463 -----------------
> >   rust/alloc/collections/mod.rs        |  160 --
> >   rust/alloc/lib.rs                    |  288 --
> >   rust/alloc/raw_vec.rs                |  611 -----
> >   rust/alloc/slice.rs                  |  890 -------
> >   rust/alloc/vec/drain.rs              |  255 --
> >   rust/alloc/vec/extract_if.rs         |  115 -
> >   rust/alloc/vec/into_iter.rs          |  454 ----
> >   rust/alloc/vec/is_zero.rs            |  204 --
> >   rust/alloc/vec/mod.rs                | 3683 --------------------------
> >   rust/alloc/vec/partial_eq.rs         |   49 -
> >   rust/alloc/vec/set_len_on_drop.rs    |   35 -
> >   rust/alloc/vec/spec_extend.rs        |  119 -
> >   rust/bindings/bindings_helper.h      |    3 +
> >   rust/kernel/alloc.rs                 |   74 +
> >   rust/kernel/{ => alloc}/allocator.rs |   17 +-
> >   rust/kernel/alloc/box_ext.rs         |   59 +
> >   rust/kernel/alloc/vec_ext.rs         |  176 ++
> >   rust/kernel/error.rs                 |   13 +-
> >   rust/kernel/init.rs                  |   57 +-
> >   rust/kernel/lib.rs                   |    5 +-
> >   rust/kernel/prelude.rs               |    2 +
> >   rust/kernel/str.rs                   |    6 +-
> >   rust/kernel/sync/arc.rs              |   50 +-
> >   rust/kernel/sync/condvar.rs          |    2 +-
> >   rust/kernel/sync/lock/mutex.rs       |    2 +-
> >   rust/kernel/sync/lock/spinlock.rs    |    2 +-
> >   rust/kernel/types.rs                 |    4 +-
> >   rust/kernel/workqueue.rs             |   14 +-
> >   samples/rust/rust_minimal.rs         |    6 +-
> >   samples/rust/rust_print.rs           |    4 +-
> >   scripts/generate_rust_analyzer.py    |    2 +-
> >   35 files changed, 405 insertions(+), 9923 deletions(-)
> >   delete mode 100644 rust/alloc/README.md
> >   delete mode 100644 rust/alloc/alloc.rs
> >   delete mode 100644 rust/alloc/boxed.rs
> >   delete mode 100644 rust/alloc/collections/mod.rs
> >   delete mode 100644 rust/alloc/lib.rs
> >   delete mode 100644 rust/alloc/raw_vec.rs
> >   delete mode 100644 rust/alloc/slice.rs
> >   delete mode 100644 rust/alloc/vec/drain.rs
> >   delete mode 100644 rust/alloc/vec/extract_if.rs
> >   delete mode 100644 rust/alloc/vec/into_iter.rs
> >   delete mode 100644 rust/alloc/vec/is_zero.rs
> >   delete mode 100644 rust/alloc/vec/mod.rs
> >   delete mode 100644 rust/alloc/vec/partial_eq.rs
> >   delete mode 100644 rust/alloc/vec/set_len_on_drop.rs
> >   delete mode 100644 rust/alloc/vec/spec_extend.rs
> >   create mode 100644 rust/kernel/alloc.rs
> >   rename rust/kernel/{ => alloc}/allocator.rs (86%)
> >   create mode 100644 rust/kernel/alloc/box_ext.rs
> >   create mode 100644 rust/kernel/alloc/vec_ext.rs
> > 
> > 
> > base-commit: 768409cff6cc89fe1194da880537a09857b6e4db


