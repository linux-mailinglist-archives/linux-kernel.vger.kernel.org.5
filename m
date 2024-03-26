Return-Path: <linux-kernel+bounces-118200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E39688B5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD7428AAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86B429B0;
	Tue, 26 Mar 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3icT/pb"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E721367;
	Tue, 26 Mar 2024 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411366; cv=none; b=pxQQhScaamt6bNi6QRyeBIwwjRy6MCahfVKI46CiNdF6ZWXR/rRzcXxEsfvUUWFb/KthXeVz89UDGIixIMxrBhMUiqG1F9gM3plLKMU+XLrUhJ/e/E3b+tEzRtminHc6F7qUlDyJUQ47NtFz5PNDMztkvMU4qa+HewWLO/vNc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411366; c=relaxed/simple;
	bh=Swt6+93KTELzBLQj7zUwl5HIGVhxbZse+TMgVXv8e0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbFM32ABHuVZk8/f8HkV5qjeiScNOy/g6PTCXhPGQ1+hkdTXzNgchy1CbIOCN7G2263x9/Rgp3Sbl/Wm7GwHO0UpfJIk8h1dmVK20YnobBuKz8PqGbUQFOOYsdOHFObR0dvnO2eiDVc+NDfRkGP+BmkxqWFNEjqHspL+baSm55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3icT/pb; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4757480276.1;
        Mon, 25 Mar 2024 17:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711411364; x=1712016164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZSaVSDwUkk79xkN09Vf+/rrtBLYHXzzW+Z8vmjcWb0=;
        b=S3icT/pb4Y4T9bZrSidffyuyodQTjOQHDb74QiQjZffJ4Evn4JpnrVZwydAkdcymkw
         w418xl1pzYCuuLFDI9DxTnUi73oVvH9URxFZRUweWNPFMZD6tR4GwPPsh9CO1C/u9zb2
         IRbHIq/EWOn+rPJhzywLKgoFJ/L0PqmVzWVRUlbu//9XF11/hS0qd3VcOR3sCljqNsvt
         SysIBLPWsA62+xA4oewG9O5cLeEvNpygiUvLM2LaWswd/BauOZMgU5JQG02kHl1wgpIu
         vryuP+CKjFtgoAViT4pTYoq0g5LHvbIt7bUtSuuehDfCEOwiIK9VVNHvqLzxKpfBp0DP
         s8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711411364; x=1712016164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZSaVSDwUkk79xkN09Vf+/rrtBLYHXzzW+Z8vmjcWb0=;
        b=JrJ95UowMd7O0OxRAcBQvTmeL3pqNyS3qMocbxAvFqvQR7QgbCTskG4V78PNvEPhEq
         MQeqH0jbNqdEF033tELc2rAumlPaiyXzM28Biid1iRmHygY/EaVpLi6V2Nid4cWG9nao
         61j0ZImdp8lTmmVUIV2iQ5aYkWH4xyDdse1MPcU5wUS0xZTo2y5keTXDOYzFR+3WcfdL
         iEE3w3LTNhwE2JwJ3icn8HIQDiFAI/E6tYum26uFZYMR86IZj1BY3IOAI3Fa8lJRHt7/
         zt2MTFOVxGpGpB8DNE94VvtbDl3+or5zdWzGa4vt2LM847xFgTpZzfJDCLnDqKOI0ar3
         tjKA==
X-Forwarded-Encrypted: i=1; AJvYcCX7BiqLiH/dwOIhoZu8aIWNQwGX9XabZYLodDtBZ1KgQp+ebMCHOz/poctdF2MVtA6erkp9wbvIKtHgkjQMQHN4Pu7+3t0uI9wgBqew
X-Gm-Message-State: AOJu0YxmTIW9NyEFSeLdlj4HmE5fZM2hZl9DBJH8k1A98qJ1b2HosBKG
	2Ug5itUgVT2DeorzUXxMlcKVn5xZTYDkZtB23OIMB1gk2cRiskN3V0bq4hesIc23WsFcTGYkoJf
	wLg+qta4z3pzQHWdK1UywNnazllfzQtaPMVQ=
X-Google-Smtp-Source: AGHT+IFJi4vw/rc8aDbAC5HKMEpuoPFUHrRZWYY8njdIFdukqddR/0qIDK5mDw85caFQ42g71xF1aSZoDSXATuOmB+4=
X-Received: by 2002:a25:361e:0:b0:dcc:9dcc:a433 with SMTP id
 d30-20020a25361e000000b00dcc9dcca433mr6546513yba.54.1711411364125; Mon, 25
 Mar 2024 17:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-3-wedsonaf@gmail.com>
 <g2iK91tWPKM5kXi-N6Nn3tn5jG4qvB6txrpq0ejLnQYgRNZJE1OO__SDANkSNP0JjMrqhEdc0m6YyxNlicxqzGr4hEsLAxPgCyPeyRoXLq0=@proton.me>
In-Reply-To: <g2iK91tWPKM5kXi-N6Nn3tn5jG4qvB6txrpq0ejLnQYgRNZJE1OO__SDANkSNP0JjMrqhEdc0m6YyxNlicxqzGr4hEsLAxPgCyPeyRoXLq0=@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 25 Mar 2024 21:02:33 -0300
Message-ID: <CANeycqq+uVp1O5k56LPtzvJQObrjT9JY3zBiX8T0nu6Gdsbu6g@mail.gmail.com>
Subject: Re: [PATCH 02/10] rust: alloc: introduce the `VecExt` trait
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 19:05, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 25.03.24 20:54, Wedson Almeida Filho wrote:> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > Make `try_with_capacity`, `try_push`, and `try_extend_from_slice`
> > methods available in `Vec` even though it doesn't implement them. It is
> > implemented with `try_reserve` and `push_within_capacity`.
> >
> > This is in preparation for switching to the upstream `alloc` crate.
> >
> > Suggested-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> >   rust/kernel/alloc.rs        |  1 +
> >   rust/kernel/alloc/vecext.rs | 52 +++++++++++++++++++++++++++++++++++++
> >   rust/kernel/lib.rs          |  1 +
> >   rust/kernel/prelude.rs      |  2 ++
> >   4 files changed, 56 insertions(+)
> >   create mode 100644 rust/kernel/alloc/vecext.rs
> >
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index ccd4149932c3..8ad57a2e693e 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -5,3 +5,4 @@
> >   #[cfg(not(test))]
> >   #[cfg(not(testlib))]
> >   mod allocator;
> > +pub mod vecext;
> > diff --git a/rust/kernel/alloc/vecext.rs b/rust/kernel/alloc/vecext.rs
> > new file mode 100644
> > index 000000000000..59e92bab534e
> > --- /dev/null
> > +++ b/rust/kernel/alloc/vecext.rs
> > @@ -0,0 +1,52 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Extensions to [`Vec`] for fallible allocations.
> > +
> > +use alloc::{collections::TryReserveError, vec::Vec};
> > +use core::result::Result;
> > +
> > +/// Extensions to [`Vec`].
> > +pub trait VecExt<T>: Sized {
> > +    /// Creates a new [`Vec`] instance with at least the given capacity.
> > +    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError>;
> > +
> > +    /// Appends an element to the back of the [`Vec`] instance.
> > +    fn try_push(&mut self, v: T) -> Result<(), TryReserveError>;
> > +
> > +    /// Pushes clones of the elements of slice into the [`Vec`] instance.
> > +    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
> > +    where
> > +        T: Clone;
>
> All of the non `try_` prefix functions require
> `not(no_global_oom_handling)`, so we could also drop the `try_` prefix
> here.
> What do you think?

Yes, I do drop the `try_` prefixes in patch 7.

Patches 1 through 4 remove the fork with minimal changes. Patches 5 to
10 introduce new functions with flags and drop `allocator_api`.

> > +}
> > +
> > +impl<T> VecExt<T> for Vec<T> {
> > +    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
> > +        let mut v = Vec::new();
> > +        v.try_reserve(capacity)?;
> > +        Ok(v)
> > +    }
> > +
> > +    fn try_push(&mut self, v: T) -> Result<(), TryReserveError> {
> > +        if let Err(retry) = self.push_within_capacity(v) {
> > +            self.try_reserve(1)?;
> > +            let _ = self.push_within_capacity(retry);
> > +        }
> > +        Ok(())
> > +    }
> > +
> > +    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
> > +    where
> > +        T: Clone,
> > +    {
> > +        let extra_cap = self.capacity() - self.len();
> > +        if extra_cap > 0 {
> > +            self.try_reserve(extra_cap)?;
> > +        }
>
> I am confused, why are you doing this? Did you mean to do this?:
>     let extra_cap = self.capacity() - self.len() - other.len();

I originally meant `extracap = other.len() - self.capacity() +
self.len()` because originally I thought `additional` meant additional
capacity (so the final capacity would be original capacity plus
`additional`). But after I looked at the code I learned that
`additional` is really the minimum capacity.

Then I decided that we don't need this check at all in
`try_extend_from_slice`, which I removed in patch 7, I just call
`reserve` directly with `other.len()`.

The code happens to work now because the `try_push` calls below ensure
the capacity gets expanded. In any case, I'll fix this in v2.

> --
> Cheers,
> Benno
>
> > +
> > +        for item in other {
> > +            self.try_push(item.clone())?;
> > +        }
> > +
> > +        Ok(())
> > +    }
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 51f30e55bd00..7f2841a18d05 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -19,6 +19,7 @@
> >   #![feature(offset_of)]
> >   #![feature(receiver_trait)]
> >   #![feature(unsize)]
> > +#![feature(vec_push_within_capacity)]
> >
> >   // Ensure conditional compilation based on the kernel configuration works;
> >   // otherwise we may silently break things like initcall handling.
> > diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> > index ae21600970b3..a0177f195dec 100644
> > --- a/rust/kernel/prelude.rs
> > +++ b/rust/kernel/prelude.rs
> > @@ -14,6 +14,8 @@
> >   #[doc(no_inline)]
> >   pub use core::pin::Pin;
> >
> > +pub use crate::alloc::vecext::VecExt;
> > +
> >   #[doc(no_inline)]
> >   pub use alloc::{boxed::Box, vec::Vec};
> >
> > --
> > 2.34.1
> >

