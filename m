Return-Path: <linux-kernel+bounces-155496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066EF8AEB57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE961F23BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1393A13C9C5;
	Tue, 23 Apr 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbOYp89p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D913C3F1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886998; cv=none; b=P3ukgVkRr8p+A7fZbd8v9fs82b7Lu8wVk558P+FCJ6U664TWSDIB8JfGxDEShAGM1ioxboe19TwgN9ZZZ6+5T0yBpgk9BI0PgnPNcQzCk4ZqpUZ1SU1CwucdQSEysbg03KpJFNH40dHZ2g2e9OUB7PaWO0rFowdttw9cOh2jL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886998; c=relaxed/simple;
	bh=icLDvFvpV72zmE8xOhKfWko0Ndyksl7RQK+s9PmbDeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEwMWakYOCbDUpeuX7ay9s6WqVI85HfdB8aTY9rWqW4MK6+78izf3E3RcSp+xA1CwjXSPVI32hQV/0bNoWZznW3+KIyWGqXKj/HOxFgq49FYNR5Drl7i9/gORnSkLUpWBeB8zZiL9RZSojaRn28A8UXSP3ZjaTp4Md9PH3DCkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbOYp89p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713886995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjKkFTxUJOrFDTkrrK48AIMAMR331JfkUWmmHYXPNWc=;
	b=YbOYp89pEaJdEdi306rhlM/lXX1iMJ91cMcwKqR6bSAiv3WGLxvDuD4h+R6QlEE99o4MP5
	gMbGX66j+11gT0cD5iCOnCs2La3mbTArgni06vxhe387qYjsFFvLLueiOOnD4l+6n1cvub
	1FBPXULiOh4PKk/sVPNuKoNtmcnjheg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-fMHnyZQ1Oni20YDu9krKMQ-1; Tue, 23 Apr 2024 11:43:13 -0400
X-MC-Unique: fMHnyZQ1Oni20YDu9krKMQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4377949a027so115252631cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886992; x=1714491792;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjKkFTxUJOrFDTkrrK48AIMAMR331JfkUWmmHYXPNWc=;
        b=uR6mQ3GoBdl9ce6hCcN+37urML/zEFXbIy3mfer2b2J/nuvZnCQ2vJQTdrcg2bEPVs
         aXHdDwROVPjg1webyRBqS5ANCGlTHxUeeNQnTOhnLQ7y5CxIl095AxFXFxm9G8ZOLa+w
         To1PREO4sGl5giqIiur+2vmxLtus9S82SxHiN5U7EYJNAc7yTI0yPusqftpBarOBj6Z6
         hAXZj40FwEdG4Zafr/XhefMB+F0n1KYv0nWFMc1KCL3XS+WjA3DAvH0wPUCeoaI8NhSL
         RpuBqMYm6zpTOg6LGO2uPGsmReHdaVPveMCJ9vC3y6UCAot321jg47eCTAX/U80k/OYF
         Xc4w==
X-Forwarded-Encrypted: i=1; AJvYcCX6vJ3PwVgcD4yWxK1PEMgJOsaNy5CFAhVYow0Q9aknPsHQsBzQ74k0U/WXnajZTXDpVmH/E3lBslIj3YE5fpQ+aiAh9JbiOhsl3rEn
X-Gm-Message-State: AOJu0Yx1xP6p/tjihChrFtCIjxZtr1G43qEi5lIWuGf+A4Gzf1Tc422I
	LJizeoqymYQNNSW4Y+oYlTNLnZ+4f93tF7PJQEJFJzdWJvhtcx4sUyglELe+NXpgkbqADJotSQz
	ZWl+6nS7og1WLwMe3ld76FhoeYOq1MYFiK66EIzFrIRb6tlwBcLEmSkBNCI8J3A==
X-Received: by 2002:ac8:7f03:0:b0:437:cc65:bbfd with SMTP id f3-20020ac87f03000000b00437cc65bbfdmr5683338qtk.8.1713886992709;
        Tue, 23 Apr 2024 08:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVbJXkNB9mPOWQi1awKT+drHechIbxwnI05S+Ty2UC4FXxVkYjTJWlzQwHhj9FWazhjx1ucw==
X-Received: by 2002:ac8:7f03:0:b0:437:cc65:bbfd with SMTP id f3-20020ac87f03000000b00437cc65bbfdmr5683305qtk.8.1713886992321;
        Tue, 23 Apr 2024 08:43:12 -0700 (PDT)
Received: from [10.32.64.131] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id do7-20020a05622a478700b0043999fccc10sm2461453qtb.62.2024.04.23.08.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:43:11 -0700 (PDT)
Message-ID: <cbeae504-2752-4ef0-b103-e62fcf45ab93@redhat.com>
Date: Tue, 23 Apr 2024 17:43:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Allocation APIs
To: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 Wedson Almeida Filho <walmeida@microsoft.com>, ajanulgu@redhat.com
References: <20240328013603.206764-1-wedsonaf@gmail.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240328013603.206764-1-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 3/28/24 02:35, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Revamp how we use the `alloc` crate.
> 
> We currently have a fork of the crate with changes to `Vec`; other
> changes have been upstreamed (to the Rust project). This series removes
> the fork and exposes all the functionality as extension traits.
> 
> Additionally, it also introduces allocation flag parameters to all
> functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
> `Vec::push`, etc.) without the `try_` prefix -- the names are available
> because we build `alloc` with `no_global_oom_handling`.
> 
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

With that series, how do we implement alternative allocators, such as
(k)vmalloc or DMA coherent?

For instance, I recently sketched up some firmware bindings we want to
use in Nova providing

fn copy<A: core::alloc::Allocator>(&self, alloc: A) -> Result<Vec<u8, 
A>> [1]

making use of Vec::try_with_capacity_in(). How would I implement
something similar now?

- Danilo

[1] 
https://gitlab.freedesktop.org/drm/nova/-/blob/topic/firmware/rust/kernel/firmware.rs?ref_type=heads#L63

> 
> ---
> 
> Changes in v3:
> - Rebased on top of the latest `rust-next` branch.
> - Updated `krealloc_aligned` to use `Flags` instead of `bindings::gfp_t`.
> - Added __GFP_ZERO to flags, as part of the previous change.
> - Avoiding temporary stack value in `Box::new_uninit`.
> - Implement `Box::new` using `Box::new_uninit` (so only one of them actually
>    allocates).
> - Added examples/tests to `VecExt` methods.
> - Fixed bug in length in `extend_from_slice`
> - Link to v2: https://lore.kernel.org/rust-for-linux/20240327023531.187880-1-wedsonaf@gmail.com/T/#t
> 
> Changes in v2:
> - Updated description of `alloc` crate.
> - Renamed vecext and boxext modules to vec_ext and box_ext.
> - Added derive directive to `AllocError`.
> - Updated safety comment in `BoxExt::new`.
> - Updated `VecExt::push` and `VecExt::extend_from_slice` to use
>    `spare_capacity_mut`
> - Added directive to not compile `destructure` and `rebuild` when `test` or
>    `testlib` are configured. Otherwise we have a warning because `push` and
>    `extend_from_slice` don't use them anymore.
> - Updated indentation in `Arc::new_uninit`
> - Moved the removal of `TryReserveError` convesion to `Error` to patch 7, where
>    usage of `TryReserveError` is actually removed.
> - Link to v1: https://lore.kernel.org/rust-for-linux/20240325195418.166013-1-wedsonaf@gmail.com/T/#t
> 
> Wedson Almeida Filho (10):
>    rust: kernel: move `allocator` module under `alloc`
>    rust: alloc: introduce the `VecExt` trait
>    kbuild: use the upstream `alloc` crate
>    rust: alloc: remove our fork of the `alloc` crate
>    rust: alloc: introduce allocation flags
>    rust: alloc: introduce the `BoxExt` trait
>    rust: alloc: update `VecExt` to take allocation flags
>    rust: sync: update `Arc` and `UniqueArc` to take allocation flags
>    rust: init: update `init` module to take allocation flags
>    rust: kernel: remove usage of `allocator_api` unstable feature
> 
>   rust/Makefile                        |   16 +-
>   rust/alloc/README.md                 |   36 -
>   rust/alloc/alloc.rs                  |  452 ----
>   rust/alloc/boxed.rs                  | 2463 -----------------
>   rust/alloc/collections/mod.rs        |  160 --
>   rust/alloc/lib.rs                    |  288 --
>   rust/alloc/raw_vec.rs                |  611 -----
>   rust/alloc/slice.rs                  |  890 -------
>   rust/alloc/vec/drain.rs              |  255 --
>   rust/alloc/vec/extract_if.rs         |  115 -
>   rust/alloc/vec/into_iter.rs          |  454 ----
>   rust/alloc/vec/is_zero.rs            |  204 --
>   rust/alloc/vec/mod.rs                | 3683 --------------------------
>   rust/alloc/vec/partial_eq.rs         |   49 -
>   rust/alloc/vec/set_len_on_drop.rs    |   35 -
>   rust/alloc/vec/spec_extend.rs        |  119 -
>   rust/bindings/bindings_helper.h      |    3 +
>   rust/kernel/alloc.rs                 |   74 +
>   rust/kernel/{ => alloc}/allocator.rs |   17 +-
>   rust/kernel/alloc/box_ext.rs         |   59 +
>   rust/kernel/alloc/vec_ext.rs         |  176 ++
>   rust/kernel/error.rs                 |   13 +-
>   rust/kernel/init.rs                  |   57 +-
>   rust/kernel/lib.rs                   |    5 +-
>   rust/kernel/prelude.rs               |    2 +
>   rust/kernel/str.rs                   |    6 +-
>   rust/kernel/sync/arc.rs              |   50 +-
>   rust/kernel/sync/condvar.rs          |    2 +-
>   rust/kernel/sync/lock/mutex.rs       |    2 +-
>   rust/kernel/sync/lock/spinlock.rs    |    2 +-
>   rust/kernel/types.rs                 |    4 +-
>   rust/kernel/workqueue.rs             |   14 +-
>   samples/rust/rust_minimal.rs         |    6 +-
>   samples/rust/rust_print.rs           |    4 +-
>   scripts/generate_rust_analyzer.py    |    2 +-
>   35 files changed, 405 insertions(+), 9923 deletions(-)
>   delete mode 100644 rust/alloc/README.md
>   delete mode 100644 rust/alloc/alloc.rs
>   delete mode 100644 rust/alloc/boxed.rs
>   delete mode 100644 rust/alloc/collections/mod.rs
>   delete mode 100644 rust/alloc/lib.rs
>   delete mode 100644 rust/alloc/raw_vec.rs
>   delete mode 100644 rust/alloc/slice.rs
>   delete mode 100644 rust/alloc/vec/drain.rs
>   delete mode 100644 rust/alloc/vec/extract_if.rs
>   delete mode 100644 rust/alloc/vec/into_iter.rs
>   delete mode 100644 rust/alloc/vec/is_zero.rs
>   delete mode 100644 rust/alloc/vec/mod.rs
>   delete mode 100644 rust/alloc/vec/partial_eq.rs
>   delete mode 100644 rust/alloc/vec/set_len_on_drop.rs
>   delete mode 100644 rust/alloc/vec/spec_extend.rs
>   create mode 100644 rust/kernel/alloc.rs
>   rename rust/kernel/{ => alloc}/allocator.rs (86%)
>   create mode 100644 rust/kernel/alloc/box_ext.rs
>   create mode 100644 rust/kernel/alloc/vec_ext.rs
> 
> 
> base-commit: 768409cff6cc89fe1194da880537a09857b6e4db


