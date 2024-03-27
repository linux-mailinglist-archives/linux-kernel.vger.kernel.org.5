Return-Path: <linux-kernel+bounces-121818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DD688EE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC141C32B77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B514EC73;
	Wed, 27 Mar 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1HFVXHZ"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF213E3E4;
	Wed, 27 Mar 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563605; cv=none; b=Q3wlNMMHNHXoJgDVD0f0fKkpkk/Fq9fO0/ECp/1AupxF7JKAIsJPHYEKk+obwOdTKaA80wkov1f08Kxr5YKIFpFcO2BJsusL7vw4TG/FgI3Eze80RNJY3vFF9vCVC3C9A29SXpMz+HbPRjhNpr+MCJTSJZqmkMOdAYb0BiSQpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563605; c=relaxed/simple;
	bh=EbYlIJzhW8u2BE4aHp1VB9uHACFNVsODV2iH4y2VrtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBtINwfAWqLj4AHrd9/Aou0hobBWDgyOhwbH+kgJ1o+9gsAtzKVfKlaUYmrJ5ctM5QDRYYWI4K7fJG9vCHi1P6hFz3ZIkGQNrxl5z+cw5lyigV2MSPqGNll80kxrizIgQwutF+lNw50N5amO19jK50ySzRxmWZ4nCEeX5TuH+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1HFVXHZ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-611248b4805so1417507b3.0;
        Wed, 27 Mar 2024 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711563602; x=1712168402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uzvvry9P6I8KLvhWewHOJ7IT8ezc0kCkdqVf56xpBYE=;
        b=B1HFVXHZJcxGxHDVD6tNCiPpbghEOGXmi4IFKrD2VpWjiue6W02XR3jYWls+ffG/mz
         f3TVbiiBu9f2VZ65aeiCQws8MzUp2dWlrQ404wQh7n0NCTLvy7xKGuQ5GdHLbU5R0x9T
         3HB8Zo8Yv/2Yp2aEwO9fSfNo7Xz/q2YMEZcBQT2GjByfJW1nRNit9NlFAB/O83k8MrY/
         Ba2QKMBfvzuUzqKTxKvOzr5rGm1eiDpNUehewseDwCW6dm8aUh6HEG4fnsaCTS185aqK
         Wz2V+/V6mqdRaorHWQlnz5g39+XJ0+NxYWZ/mHbxkKRHlpkK6CM/TVXZVN3U9/XO5/iS
         WP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563602; x=1712168402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzvvry9P6I8KLvhWewHOJ7IT8ezc0kCkdqVf56xpBYE=;
        b=OCLddmViHHLP2ENTzYH9KftlCb0qngvWRgi8WBi0PzuWMorBrDtNiMMEyJUDSwcwfN
         ktNLBOW1/1Mc+66z5BqcIeA8Lw/LWKC7CPljgXPu1dNsMjahoFcs2X9nvAWMVeY/vKxb
         /hOFzRTPN3/ZBhnAYDNxZ+ZCpNrMDsavF++XbRRz5g0irWTeUwvsqxIUJ16z3JqGAB7g
         KC86DDyk3jxz2QHUX5CEpHAmbrl4a2pl1ytZ9Y94Sacstx0AaAKhEyy6mkSHOTaIG6Tm
         NpG+PUTzt2VMzg7jrwTRSoTBUnQX4O/hlBLrs1saK859RjoXVv/dLo9CGDApr6n0vT4Q
         LKUw==
X-Forwarded-Encrypted: i=1; AJvYcCVeDmzuQXdIehQnVdMMPsiuVPSz/M4r3V74DVBxKkzfPRxy7vPfqQbaboNYBZrRZ7r8lk6dlgJF9lsX/OUQ1T39jUKqnsKk2idGfFfI
X-Gm-Message-State: AOJu0YwYoYfRcBxUy+nW3Qi0+EamBMPmcdL15xEsG1/88bwE3FMAlwfE
	f49p1Ig1mIx94BVSicOggT9XL4PX2x70+bUkmQfTXMAoHGveGtE/PBdF8V6brEev/UVe7JuWAmY
	uY3P4DvYGtpD+Jmz8grQ1+wDxGVI=
X-Google-Smtp-Source: AGHT+IEpyp1mFlgMWDmVJJjTuHmjhRtEMSa19jqwhuMGRicFUP7WsaBTomMJ94X9WX3oH27Trvmama4gxQ7m/0rgDnE=
X-Received: by 2002:a5b:312:0:b0:dcf:a52d:6134 with SMTP id
 j18-20020a5b0312000000b00dcfa52d6134mr603432ybp.26.1711563602093; Wed, 27 Mar
 2024 11:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327023531.187880-1-wedsonaf@gmail.com> <20240327023531.187880-8-wedsonaf@gmail.com>
 <ZgOXGSDmIgrENB7d@Boquns-Mac-mini.home>
In-Reply-To: <ZgOXGSDmIgrENB7d@Boquns-Mac-mini.home>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 27 Mar 2024 15:19:51 -0300
Message-ID: <CANeycqrz=4cyT6Q1r+n_oJChOKDK+yeVUX7fWo21PEanZZMXzA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] rust: alloc: update `VecExt` to take allocation flags
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 00:48, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Tue, Mar 26, 2024 at 11:35:28PM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > We also rename the methods by removing the `try_` prefix since the names
> > are available due to our usage of the `no_global_oom_handling` config
> > when building the `alloc` crate.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> >  rust/kernel/alloc/vec_ext.rs | 106 ++++++++++++++++++++++++++++++-----
> >  rust/kernel/error.rs         |  11 +---
> >  rust/kernel/lib.rs           |   1 -
> >  rust/kernel/str.rs           |   6 +-
> >  rust/kernel/types.rs         |   4 +-
> >  samples/rust/rust_minimal.rs |   6 +-
> >  6 files changed, 100 insertions(+), 34 deletions(-)
> >
> > diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
> > index 311e62cc5784..bb6cb1c4ea67 100644
> > --- a/rust/kernel/alloc/vec_ext.rs
> > +++ b/rust/kernel/alloc/vec_ext.rs
> > @@ -2,47 +2,123 @@
> >
> >  //! Extensions to [`Vec`] for fallible allocations.
> >
> > -use alloc::{collections::TryReserveError, vec::Vec};
> > +use super::Flags;
> > +use alloc::{alloc::AllocError, vec::Vec};
> >  use core::result::Result;
> >
> >  /// Extensions to [`Vec`].
> >  pub trait VecExt<T>: Sized {
> >      /// Creates a new [`Vec`] instance with at least the given capacity.
> > -    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError>;
> > +    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError>;
> >
> >      /// Appends an element to the back of the [`Vec`] instance.
> > -    fn try_push(&mut self, v: T) -> Result<(), TryReserveError>;
> > +    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>;
> >
> >      /// Pushes clones of the elements of slice into the [`Vec`] instance.
> > -    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
> > +    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
> >      where
> >          T: Clone;
> > +
> > +    /// Ensures that the capacity exceeds the length by at least `additional` elements.
> > +    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>;
> >  }
> >
> >  impl<T> VecExt<T> for Vec<T> {
> > -    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
> > +    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
> >          let mut v = Vec::new();
> > -        v.try_reserve(capacity)?;
> > +        <Self as VecExt<_>>::reserve(&mut v, capacity, flags)?;
> >          Ok(v)
> >      }
> >
> > -    fn try_push(&mut self, v: T) -> Result<(), TryReserveError> {
> > -        if let Err(retry) = self.push_within_capacity(v) {
> > -            self.try_reserve(1)?;
> > -            let _ = self.push_within_capacity(retry);
> > -        }
> > +    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> > +        <Self as VecExt<_>>::reserve(self, 1, flags)?;
> > +        let s = self.spare_capacity_mut();
> > +        s[0].write(v);
> > +
> > +        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
> > +        // by 1. We also know that the new length is <= capacity because of the previous call to
> > +        // `reserve` above.
> > +        unsafe { self.set_len(self.len() + 1) };
> >          Ok(())
> >      }
> >
> > -    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
> > +    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
> >      where
> >          T: Clone,
> >      {
> > -        self.try_reserve(other.len())?;
> > -        for item in other {
> > -            self.try_push(item.clone())?;
> > +        <Self as VecExt<_>>::reserve(self, other.len(), flags)?;
> > +        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
> > +            slot.write(item.clone());
>
> /me likes this! ;-) Too bad `write_slice_cloned()` is not stablized:
>
>         https://doc.rust-lang.org/core/mem/union.MaybeUninit.html#method.write_slice_cloned
>
> >          }
> >
> > +        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
> > +        // the length by the same amount. We also know that the new length is <= capacity because
> > +        // of the previous call to `reserve` above.
> > +        unsafe { self.set_len(self.len() + 1) };
>
> should be
>
>         unsafe { self.set_len(self.len() + other.len()) };
>
> , right?

Yes, thanks for catching this!

> We probably should put some unit tests for these functions.

Yeah, I added examples in documentation with asserts that work as
tests in kunit in v3.

>
> > +        Ok(())
> > +    }
> > +
> > +    #[cfg(any(test, testlib))]
> > +    fn reserve(&mut self, additional: usize, _flags: Flags) -> Result<(), AllocError> {
> > +        Vec::reserve(self, additional);
> >          Ok(())
> >      }
> > +
> > +    #[cfg(not(any(test, testlib)))]
> > +    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
> > +        let len = self.len();
> > +        let cap = self.capacity();
> > +
> > +        if cap - len >= additional {
> > +            return Ok(());
> > +        }
> > +
> > +        if core::mem::size_of::<T>() == 0 {
> > +            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
> > +            return Err(AllocError);
> > +        }
> > +
> > +        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
> > +        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
> > +        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
> > +        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
> > +
> > +        let (ptr, len, cap) = destructure(self);
> > +
> > +        // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
> > +        // `krealloc_aligned`. We also verified that the type is not a ZST.
> > +        let new_ptr = unsafe { super::allocator::krealloc_aligned(ptr.cast(), layout, flags.0) };
>
> One optimization we can do later: if the alignment requirement of `T` is
> larger than SLAB_MINALIGN, `krealloc_aligned()` will allocate a power
> of 2 bytes big enough to hold `layout`, that means we may have enough
> room to fit extra `T`s, for example:
>
>         if align of `T` is 32 and size of `T` is 96, `new_cap` is 4,
>         then the size of array is 96 * 4 = 384, and `krealloc_aligned()`
>         will allocate 512 bytes, and we can fit an extra `T` here
>         (because 512 - 384 = 128 > 96)
>
> But of course, I don't think we have such a user yet. I will open an
> issue later this week if this sounds reasonable.

It sounds reasonable to me, with one caveat: the information of how
much extra space was allocated should come from `krealloc_aligned`.

IOW, we shouldn't have callers use implementation details from
`krealloc_aligned`. (One possible way to do it is to return the actual
allocated length in addition to the pointer to the allocated block.)

> The rest looks good to me. (`destructure` and `rebuild` are obviously
> very creative to me ;-))

They are the functions that make this possible :)

> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>
> Regards,
> Boqun
>
> > +        if new_ptr.is_null() {
> > +            // SAFETY: We are just rebuilding the existing `Vec` with no changes.
> > +            unsafe { rebuild(self, ptr, len, cap) };
> > +            Err(AllocError)
> > +        } else {
> > +            // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements. New cap
> > +            // is greater than `cap`, so it continues to be >= `len`.
> > +            unsafe { rebuild(self, new_ptr.cast::<T>(), len, new_cap) };
> > +            Ok(())
> > +        }
> > +    }
> > +}
> > +
> > +#[cfg(not(any(test, testlib)))]
> > +fn destructure<T>(v: &mut Vec<T>) -> (*mut T, usize, usize) {
> > +    let mut tmp = Vec::new();
> > +    core::mem::swap(&mut tmp, v);
> > +    let mut tmp = core::mem::ManuallyDrop::new(tmp);
> > +    let len = tmp.len();
> > +    let cap = tmp.capacity();
> > +    (tmp.as_mut_ptr(), len, cap)
> > +}
> > +
> > +/// Rebuilds a `Vec` from a pointer, length, and capacity.
> > +///
> > +/// # Safety
> > +///
> > +/// The same as [`Vec::from_raw_parts`].
> > +#[cfg(not(any(test, testlib)))]
> > +unsafe fn rebuild<T>(v: &mut Vec<T>, ptr: *mut T, len: usize, cap: usize) {
> > +    // SAFETY: The safety requirements from this function satisfy those of `from_raw_parts`.
> > +    let mut tmp = unsafe { Vec::from_raw_parts(ptr, len, cap) };
> > +    core::mem::swap(&mut tmp, v);
> >  }
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index 4786d3ee1e92..e53466937796 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -6,10 +6,7 @@
> >
> >  use crate::str::CStr;
> >
> > -use alloc::{
> > -    alloc::{AllocError, LayoutError},
> > -    collections::TryReserveError,
> > -};
> > +use alloc::alloc::{AllocError, LayoutError};
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
> >  impl From<LayoutError> for Error {
> >      fn from(_: LayoutError) -> Error {
> >          code::ENOMEM
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 7f2841a18d05..51f30e55bd00 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -19,7 +19,6 @@
> >  #![feature(offset_of)]
> >  #![feature(receiver_trait)]
> >  #![feature(unsize)]
> > -#![feature(vec_push_within_capacity)]
> >
> >  // Ensure conditional compilation based on the kernel configuration works;
> >  // otherwise we may silently break things like initcall handling.
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index e1be6c5e72a9..58f2ddafb326 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -2,7 +2,7 @@
> >
> >  //! String representations.
> >
> > -use crate::alloc::vec_ext::VecExt;
> > +use crate::alloc::{flags::*, vec_ext::VecExt};
> >  use alloc::alloc::AllocError;
> >  use alloc::vec::Vec;
> >  use core::fmt::{self, Write};
> > @@ -730,7 +730,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
> >          let size = f.bytes_written();
> >
> >          // Allocate a vector with the required number of bytes, and write to it.
> > -        let mut buf = Vec::try_with_capacity(size)?;
> > +        let mut buf = <Vec<_> as VecExt<_>>::with_capacity(size, GFP_KERNEL)?;
> >          // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
> >          let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
> >          f.write_fmt(args)?;
> > @@ -771,7 +771,7 @@ impl<'a> TryFrom<&'a CStr> for CString {
> >      fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
> >          let mut buf = Vec::new();
> >
> > -        buf.try_extend_from_slice(cstr.as_bytes_with_nul())
> > +        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
> >              .map_err(|_| AllocError)?;
> >
> >          // INVARIANT: The `CStr` and `CString` types have the same invariants for
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index aa77bad9bce4..8fad61268465 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -157,11 +157,11 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
> >  ///     let mut vec =
> >  ///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
> >  ///
> > -///     vec.try_push(10u8)?;
> > +///     vec.push(10u8, GFP_KERNEL)?;
> >  ///     if arg {
> >  ///         return Ok(());
> >  ///     }
> > -///     vec.try_push(20u8)?;
> > +///     vec.push(20u8, GFP_KERNEL)?;
> >  ///     Ok(())
> >  /// }
> >  ///
> > diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
> > index dc05f4bbe27e..2a9eaab62d1c 100644
> > --- a/samples/rust/rust_minimal.rs
> > +++ b/samples/rust/rust_minimal.rs
> > @@ -22,9 +22,9 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
> >          pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
> >
> >          let mut numbers = Vec::new();
> > -        numbers.try_push(72)?;
> > -        numbers.try_push(108)?;
> > -        numbers.try_push(200)?;
> > +        numbers.push(72, GFP_KERNEL)?;
> > +        numbers.push(108, GFP_KERNEL)?;
> > +        numbers.push(200, GFP_KERNEL)?;
> >
> >          Ok(RustMinimal { numbers })
> >      }
> > --
> > 2.34.1
> >

