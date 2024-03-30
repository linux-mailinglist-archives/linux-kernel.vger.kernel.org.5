Return-Path: <linux-kernel+bounces-125556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FB389287E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C401B21BB1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88415C9;
	Sat, 30 Mar 2024 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+e6WVvc"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5DD7E2;
	Sat, 30 Mar 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760079; cv=none; b=iOkU7UJ41ARrNXsQai3va0nApK1HurRwBYUkj+iLMZpV9p7yhgoBE3sYzuqiD6M6Kihz6rUlWEy8Agf2xFpXlBdgX78hKVsiawJCq+3l0V3AEGr+v4C4F/jrUAzcoL7dAwmC3FXxE7RCSJ/xUYpxciVaBqyXHNaMA+plSmCoyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760079; c=relaxed/simple;
	bh=C7/u4ofQJXfQiXRxaEs7DfHEEY+bmTf+pwi2I/YeAVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9G6cfJfGlnY+boNn1FDx73QNu1w559sqjXEdxcjenzm5IJSWoDw7bIyvXNh/J5gdbvT5/tKNYKDVQGb+cAA+/QXaEv/a3r4xo32Kf/srXX7QvP2njFlQpvu9iCpqoNvVV2ZEJwyqTrii9CYsQkYeX6PYVA/r1wrSPmzGlGbsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+e6WVvc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6143266c9ddso15551077b3.1;
        Fri, 29 Mar 2024 17:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711760076; x=1712364876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gdgZrncINFHgsExeQ/SIQLUhYhlJJhEbFypAYrqVZow=;
        b=I+e6WVvcMP+6pCo8SBU9ZfGzJq0qTZuIKFW7W/VSlNPrDuX+cFL2Hzpw/ttT0RxxbI
         h0rs33NtHAPcsuDUJqJyOKqXzkk518pn04OkcHbTlhGeHLRjMoSrwKBRCM3zk5afTMzC
         qvZTzqmJSUbDU7bAGfOh2JcwRj/K3xz8ce56peGaQW9y3nvF7g8SBTV++0zPXXxco+Jo
         rM17YfEU/In/e1x6Fb3eV8eGgWavIpK35ch0awIsDKVz3Aln/nfsLtLO3WcR26ZHclQQ
         tD22RhoCo96myM6T47STFxNfr+OW1TEjV3dMiXiDXMaidTweQDR/REgfAETYHyKrUfsW
         cqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711760076; x=1712364876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdgZrncINFHgsExeQ/SIQLUhYhlJJhEbFypAYrqVZow=;
        b=d56etrXZL1Jp2wjpH8gdi7NFG7PcquAQkcU6fP6JyKrdtG2/L0yKmtAESLf1kTgPgD
         k8xvaS1bSSG7tFqkFZE2Tf92bEcktpVRXCvlyBubTdM7veHMw2LP7szjQeQRYxzc/6fo
         RVtQ90+51eAeJYJob4COrASPDBTK36rUjZmsIy3mcyq50uKqj89RkvDR42TSPH3ey/LA
         cijTSkicoyQr9LWQFJFmCwf96KGHgsExx3ZoKgT0sR4pwKFXDJ+6gpL8PyfmxnyFNjM6
         Ldx4arPADoRjC1r1Hm5PPNRt6lmeqMKLZ9pubfTIa4/ZqiZnJmdxbTbMvEbGI4fg9zXF
         n3xg==
X-Forwarded-Encrypted: i=1; AJvYcCXkb70x0/Y3UmGlse4qZaMkcz2qpurRqRDIkBPU7Ba5PLmBGdC8PebgyHJNrTPiwe1b6BYVUp+xM6DTHtSgIF2T5ttANsEBcbjRMBbE
X-Gm-Message-State: AOJu0YzmgAH05pD/CKpgivRhGwWm9aHybAudO42KrFnynPqqVPZ/sUBw
	W6TZi6e24hE6k9VOqGuXy/3kd5G4kBUzg8vOVHRZSDOBVOmjHAlnLEE4UBw5WGomfw/28Ov4qgm
	j9U2ND/rXDmys68Iaya/roXsODAQ=
X-Google-Smtp-Source: AGHT+IGxAiNt8vHo+s+xMXCgQos4a3gfZPa+WWqz85Gw3W9MCkCfORVDUr+dwUmuFHzOURmSM3n4HlAtJn8guQzzg9o=
X-Received: by 2002:a0d:db52:0:b0:60a:a73:9516 with SMTP id
 d79-20020a0ddb52000000b0060a0a739516mr4119883ywe.47.1711760076562; Fri, 29
 Mar 2024 17:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328013603.206764-1-wedsonaf@gmail.com> <ZgcHfG5Hdhv39SLU@boqun-archlinux>
In-Reply-To: <ZgcHfG5Hdhv39SLU@boqun-archlinux>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Fri, 29 Mar 2024 21:54:25 -0300
Message-ID: <CANeycqoSe5mTuxUh+M3LbLeXTVOU0zzJhxwqFeww0xHXBJg_Sg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 15:25, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Wed, Mar 27, 2024 at 10:35:53PM -0300, Wedson Almeida Filho wrote:
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
> >
> > ---
> >
>
> FWIW, I've put this into rust-dev:
>
>         https://github.com/Rust-for-Linux/linux rust-dev
>
> a few adjustments are needed to work with other commits that have been
> queued in rust-dev, so I add an commit on the top for everyone's
> reference. (Besides this commit, I also removed all updates to our own
> alloc in Miguel's 1.77.0 compiler version bump patch)
>
> Regards,
> Boqun
>
> ---------------------------------------------------->8
> diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> index 8902f490ccc8..a5930f0f2bc5 100644
> --- a/rust/kernel/file.rs
> +++ b/rust/kernel/file.rs
> @@ -6,13 +6,15 @@
>  //! [`include/linux/file.h`](srctree/include/linux/file.h)
>
>  use crate::{
> +    alloc::AllocError,

I would do `alloc::{flags::*, AlocError},` here and add not add
`prelude::*` below.

>      bindings,
>      cred::Credential,
>      error::{code::*, Error, Result},
> +    prelude::*,
>      types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
>  };
>  use alloc::boxed::Box;
> -use core::{alloc::AllocError, mem, ptr};
> +use core::{mem, ptr};
>
>  /// Flags associated with a [`File`].
>  pub mod flags {
> @@ -348,10 +350,13 @@ impl DeferredFdCloser {
>      pub fn new() -> Result<Self, AllocError> {
>          Ok(Self {
>              // INVARIANT: The `file` pointer is null, so the type invariant does not apply.
> -            inner: Box::try_new(DeferredFdCloserInner {
> -                twork: mem::MaybeUninit::uninit(),
> -                file: core::ptr::null_mut(),
> -            })?,
> +            inner: Box::new(
> +                DeferredFdCloserInner {
> +                    twork: mem::MaybeUninit::uninit(),
> +                    file: core::ptr::null_mut(),
> +                },
> +                GFP_KERNEL,
> +            )?,
>          })
>      }
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index c4a5e175b574..13a2166c4f41 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -302,7 +302,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>      /// ```
>      /// use kernel::sync::{Arc, UniqueArc};
>      ///
> -    /// let arc = Arc::try_new(42)?;
> +    /// let arc = Arc::new(42, GFP_KERNEL)?;
>      /// let unique_arc = arc.into_unique_or_drop();
>      ///
>      /// // The above conversion should succeed since refcount of `arc` is 1.
> @@ -316,7 +316,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>      /// ```
>      /// use kernel::sync::{Arc, UniqueArc};
>      ///
> -    /// let arc = Arc::try_new(42)?;
> +    /// let arc = Arc::new(42, GFP_KERNEL)?;
>      /// let another = arc.clone();
>      ///
>      /// let unique_arc = arc.into_unique_or_drop();

