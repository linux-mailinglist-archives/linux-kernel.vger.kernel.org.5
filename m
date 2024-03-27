Return-Path: <linux-kernel+bounces-120208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D6E88D478
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9ED2A805D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F9920B34;
	Wed, 27 Mar 2024 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jspFnXuh"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B51CF92;
	Wed, 27 Mar 2024 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505626; cv=none; b=thnbf2qzK+ASSkFqtVIveE5r2sxIC0HCYhyshb1iI3AEAKEXyFYsuOuXcZ7gR9VRpr/P9IJ0ySy+3Xr0OeWHn9l/ia9IjUYbZqCAC2UqNsDlncSsNG0r9VOJlPkR3w2V027HSHPNebDHn4YKbSSN4TqcZ/1Nq54sMd0jaEXwaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505626; c=relaxed/simple;
	bh=cghJFaDJi3tVEoWnhyy48O7Q2I14v2c+PP+Czgubb8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkGEGw698lEQSv67LOqTuYYIMMIfi9yulGs8mHJrQMQOtMV9EMssuk8LgN+cehoUXRTUnMvAEzu4iOYF9DZecY35H5cR2mKEIpmnZM0fGgPH9T0xHedmo0qLsCByo2RvJ+iYDIAVv10hB0v854O1L4WUJf9X8UTKA6g808IgWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jspFnXuh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-611450d7f95so29104147b3.2;
        Tue, 26 Mar 2024 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711505623; x=1712110423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jlUvQiiNtk2fTE/O8KLe3aAEMKSav8q/gh3Fim9cODY=;
        b=jspFnXuhlwGm9dip/7Sl+z9jvN2h3UJgs51kkIekIDSkezhNGZfnJebBF6I6s2g85L
         Qy2Xpw8TI0LQd+kGaq5lss2luG9mp9O6wOqOcq14Brarjo/9dgIjYUATt2z4oZrbiLCu
         OXo7pWlSkUt7ZaCCueED9cSXKyuqUx2MZjZdp9zXKn0VX1S8JPjOrLgf4yYRiJ9e4Llj
         oz4rImZkjbqxAKIoDQzN76Vv+eSzEmL9V4usvugok0oC6nlD8eC0zMG/odnIni58YJpj
         tQFHyR72pjvgPT/a4ARSh/tyaPWPeZ9UYDD6Zi+78JETh5oljaB7bDsziyGIr+CfVGJ1
         SAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711505623; x=1712110423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlUvQiiNtk2fTE/O8KLe3aAEMKSav8q/gh3Fim9cODY=;
        b=Q/OfG2r4t+Ckimy5+l+2uVEDE7AfomxSEm5X6zVCXQmaTuBQ/Vh97hfcHMHlp4ichE
         Z/qDAlTbWw0hFabPq+5FwwL+GrWb2DS9H/dT6+WmFstmyHLkngxy6jclz/UqEjzWYJSB
         KxnAtPb1VswYNZ4tITong3gvFhct3BDMcZgb7SdM9C/oBprLEb25qVAnRW5MKpMHfChH
         3WzfOR++h3kyjEPbUe2vwSTiTRVKtjdZT8R9icLuHoQC8N918tnb4JVM2u0B9yHqe5iQ
         gfKIFy6VYEXvdXwAhZt4hBvb1SwOL3Qb/tDdawfQoankPfWg5BTJvxqH+bumy+5LvUJe
         F+TA==
X-Forwarded-Encrypted: i=1; AJvYcCVcyoUP8ZAGxI7gZ5MdhhNOWYtZ9YuN4ln4Xm7CW696DxuEDVooMikaqXoX0FxOplgZSuqF0BJwlIl1tQkMkmIlqGmlMNL6m8pdG0LN
X-Gm-Message-State: AOJu0Yy153l4E4nCyaGzLpH7AUR46JnH/sJWaZ+n+Yn3Ux9wHIblSdg6
	L7cipT3AYwDiACbHroa9OFvYQ23TFDLcTdo3G4JbjVe3uafrfkIKa4FZ/oRNLPjr9UABisqpfFK
	iZIsvGu/PnG15neIa56o94cpkhMY=
X-Google-Smtp-Source: AGHT+IEYeHUwrMHm+chW0aH9JpSQHDu9bWiSh0Mj5xkENQJMTFI1fBFrnpURIszqEsEXL7qpjSOCxQoiCfF6kfylY3E=
X-Received: by 2002:a81:7385:0:b0:60a:c510:89f1 with SMTP id
 o127-20020a817385000000b0060ac51089f1mr2790281ywc.19.1711505623201; Tue, 26
 Mar 2024 19:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-11-wedsonaf@gmail.com>
 <0LNSiT6NSGVXUXFMn80Z2GCSdjCmJfd1idFp6dTgEf4hfDyjNHq59jLZD9U6BcWVCo1QVvRvHb5Pjr7DOUlqnHabGeOAhmLguV0kGcruqS4=@proton.me>
In-Reply-To: <0LNSiT6NSGVXUXFMn80Z2GCSdjCmJfd1idFp6dTgEf4hfDyjNHq59jLZD9U6BcWVCo1QVvRvHb5Pjr7DOUlqnHabGeOAhmLguV0kGcruqS4=@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 26 Mar 2024 23:13:32 -0300
Message-ID: <CANeycqpCz=3Ab=K0JRFu6v0YvEU66ikK2B8KZbjC+sDd1BoqTA@mail.gmail.com>
Subject: Re: [PATCH 10/10] rust: kernel: remove usage of `allocator_api`
 unstable feature
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 12:27, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 25.03.24 20:54, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > With the adoption of `BoxExt` and `VecExt`, we don't need the functions
> > provided by this feature (namely the methods prefixed with `try_` and
> > different allocator per collection instance).
> >
> > We do need `AllocError`, but we define our own as it is a trivial empty
> > struct.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> >  rust/kernel/alloc.rs        |  3 +++
> >  rust/kernel/alloc/boxext.rs |  3 +--
> >  rust/kernel/alloc/vecext.rs |  4 ++--
> >  rust/kernel/error.rs        | 13 ++-----------
> >  rust/kernel/init.rs         |  3 +--
> >  rust/kernel/lib.rs          |  1 -
> >  rust/kernel/str.rs          |  3 +--
> >  rust/kernel/sync/arc.rs     |  4 ++--
> >  rust/kernel/workqueue.rs    |  3 +--
> >  9 files changed, 13 insertions(+), 24 deletions(-)
> >
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 5712c81b1308..f17f48130f13 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -8,6 +8,9 @@
> >  pub mod boxext;
> >  pub mod vecext;
> >
> > +/// Indicates an allocation error.
> > +pub struct AllocError;
>
> I think it would be sensible to add this now:
>     #[derive(Copy, Clone, PartialEq, Eq, Debug)]

Agreed. Will add in v2.

> > +
> >  /// Flags to be used when allocating memory.
> >  ///
> >  /// They can be combined with the operators `|`, `&`, and `!`.
> > diff --git a/rust/kernel/alloc/boxext.rs b/rust/kernel/alloc/boxext.rs
> > index 26a918df7acf..3cdda0f635a3 100644
> > --- a/rust/kernel/alloc/boxext.rs
> > +++ b/rust/kernel/alloc/boxext.rs
> > @@ -2,9 +2,8 @@
> >
> >  //! Extensions to [`Box`] for fallible allocations.
> >
> > -use super::Flags;
> > +use super::{AllocError, Flags};
> >  use alloc::boxed::Box;
> > -use core::alloc::AllocError;
> >  use core::mem::MaybeUninit;
> >  use core::result::Result;
> >
> > diff --git a/rust/kernel/alloc/vecext.rs b/rust/kernel/alloc/vecext.rs
> > index 1d4d51b45a49..85ca6a6db6de 100644
> > --- a/rust/kernel/alloc/vecext.rs
> > +++ b/rust/kernel/alloc/vecext.rs
> > @@ -2,8 +2,8 @@
> >
> >  //! Extensions to [`Vec`] for fallible allocations.
> >
> > -use super::Flags;
> > -use alloc::{alloc::AllocError, vec::Vec};
> > +use super::{AllocError, Flags};
> > +use alloc::vec::Vec;
> >  use core::{mem::ManuallyDrop, result::Result};
> >
> >  /// Extensions to [`Vec`].
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index 4786d3ee1e92..fc986bc24c6d 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -4,12 +4,9 @@
> >  //!
> >  //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
> >
> > -use crate::str::CStr;
> > +use crate::{alloc::AllocError, str::CStr};
> >
> > -use alloc::{
> > -    alloc::{AllocError, LayoutError},
> > -    collections::TryReserveError,
> > -};
> > +use alloc::alloc::LayoutError;
> >
> >  use core::convert::From;
> >  use core::fmt;
> > @@ -192,12 +189,6 @@ fn from(_: Utf8Error) -> Error {
> >      }
> >  }
> >
> > -impl From<TryReserveError> for Error {
> > -    fn from(_: TryReserveError) -> Error {
> > -        code::ENOMEM
> > -    }
> > -}
> > -
>
> Why are you removing this?

We don't use `TryReserveError` anymore. I'll move this chunk to the
patch 7 in v2, which is where we remove the use of this error.

>
> --
> Cheers,
> Benno
>
> >  impl From<LayoutError> for Error {
> >      fn from(_: LayoutError) -> Error {
> >          code::ENOMEM
> > diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> > index 1a8b0464db0c..1f7a6b5892ac 100644
> > --- a/rust/kernel/init.rs
> > +++ b/rust/kernel/init.rs
> > @@ -211,14 +211,13 @@
> >  //! [`pin_init!`]: crate::pin_init!
> >
> >  use crate::{
> > -    alloc::{boxext::BoxExt, Flags},
> > +    alloc::{boxext::BoxExt, AllocError, Flags},
> >      error::{self, Error},
> >      sync::UniqueArc,
> >      types::{Opaque, ScopeGuard},
> >  };
> >  use alloc::boxed::Box;
> >  use core::{
> > -    alloc::AllocError,
> >      cell::UnsafeCell,
> >      convert::Infallible,
> >      marker::PhantomData,
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 51f30e55bd00..5c641233e26d 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -12,7 +12,6 @@
> >  //! do so first instead of bypassing this crate.
> >
> >  #![no_std]
> > -#![feature(allocator_api)]
> >  #![feature(coerce_unsized)]
> >  #![feature(dispatch_from_dyn)]
> >  #![feature(new_uninit)]
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index 34dbc85b5220..5206b18f882b 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -2,8 +2,7 @@
> >
> >  //! String representations.
> >
> > -use crate::alloc::{flags::*, vecext::VecExt};
> > -use alloc::alloc::AllocError;
> > +use crate::alloc::{flags::*, vecext::VecExt, AllocError};
> >  use alloc::vec::Vec;
> >  use core::fmt::{self, Write};
> >  use core::ops::{self, Deref, Index};
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index af539c5eb4bc..8db25f73b37f 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -16,7 +16,7 @@
> >  //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
> >
> >  use crate::{
> > -    alloc::{boxext::BoxExt, Flags},
> > +    alloc::{boxext::BoxExt, AllocError, Flags},
> >      bindings,
> >      error::{self, Error},
> >      init::{self, InPlaceInit, Init, PinInit},
> > @@ -25,7 +25,7 @@
> >  };
> >  use alloc::boxed::Box;
> >  use core::{
> > -    alloc::{AllocError, Layout},
> > +    alloc::Layout,
> >      fmt,
> >      marker::{PhantomData, Unsize},
> >      mem::{ManuallyDrop, MaybeUninit},
> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > index 09a0f158ff1b..50837e56efc7 100644
> > --- a/rust/kernel/workqueue.rs
> > +++ b/rust/kernel/workqueue.rs
> > @@ -132,9 +132,8 @@
> >  //!
> >  //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
> >
> > -use crate::alloc::Flags;
> > +use crate::alloc::{AllocError, Flags};
> >  use crate::{bindings, prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
> > -use alloc::alloc::AllocError;
> >  use alloc::boxed::Box;
> >  use core::marker::PhantomData;
> >  use core::pin::Pin;
> > --
> > 2.34.1
> >

