Return-Path: <linux-kernel+bounces-121673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012388EC43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0485FB23B35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6414D71C;
	Wed, 27 Mar 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LvHP7RI+"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2014BFB8;
	Wed, 27 Mar 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559401; cv=none; b=lrcJ0ZJWDHc4z6rrHyHhLEkrSpuB3H9hD2ax7fSIz9R2qVjB5SzzgjycUdRgGmMBk+mHzvkgxCeMh7SI7/qgVuhG/Y+hUUVblFsI3rBPDC522soXZelqUfrwljx9PzdC5UbGJHqXqqJ1YR/rsv89BVQTDTXEiQTTvXCrcSSrXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559401; c=relaxed/simple;
	bh=TAvSXLo+JzG7CRTnjWxNem3ojDqI3tGDePRfdvulLwc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m69+gWuaXHS5epCbhF/UEHXl6UdYwxbvXEmWTX8F7qzu4xqV2uwyiqS/dRxkjof1M/fbC65NSCb1Tp9k/FnKQ7mdcXgOyvtNAnmMGpmlth4LqbmWePWpG7DQ4k//q4TCQExQHxx++1cNFUtSjrUqj7rRcbTbjqILu7TaNG44QGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LvHP7RI+; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711559396; x=1711818596;
	bh=SVnx5sMr84jeYv0M36GmI9eVZD6iTYoLtNnbb889Szc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LvHP7RI+De/izrP3K1Qau5J8o2NC/3tmNcYBtiCSDw0Uk/5u0+vOuzxCSTQ8Q0o/I
	 JlbzqFsP518OTIIHrmqNjIMNig8aNWW2YCddQqoaLOmyl5H2FKtqGOEf9n/LNMRfVI
	 1I2znQlERhrUBJ789w0tzvhD72YgWJn/joVhpQ2bWouQ0KfOkvcdsV8/DYUbFqqft0
	 pSVccuaHLCZa1znAZU3xb98PpiRX95is1oG7HA9zWEVxdlrQAfO5rMCwmF02nhqq3N
	 t9yzT+vQu3q7sMK8bq5HdRe/PrL3ONtVDCpIB1gm5S9/vDLygvwAkYW3M8JMx8pA7c
	 eDob1jWAkN21A==
Date: Wed, 27 Mar 2024 17:09:47 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 06/10] rust: alloc: introduce the `BoxExt` trait
Message-ID: <d9c96a73-bde7-4bd3-bb05-4422fa85c743@proton.me>
In-Reply-To: <20240327023531.187880-7-wedsonaf@gmail.com>
References: <20240327023531.187880-1-wedsonaf@gmail.com> <20240327023531.187880-7-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.03.24 03:35, Wedson Almeida Filho wrote:
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
rs
> index 01ad139e19bc..fc0439455faa 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -15,7 +15,11 @@
>  ///
>  /// - `ptr` can be either null or a pointer which has been allocated by =
this allocator.
>  /// - `new_layout` must have a non-zero size.
> -unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bind=
ings::gfp_t) -> *mut u8 {
> +pub(crate) unsafe fn krealloc_aligned(
> +    ptr: *mut u8,
> +    new_layout: Layout,
> +    flags: bindings::gfp_t,

I think it is a good idea to use `Flags` here as well.

> +) -> *mut u8 {
>      // Customized layouts from `Layout::from_size_align()` can have size=
 < align, so pad first.
>      let layout =3D new_layout.pad_to_align();
>=20
> diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
> new file mode 100644
> index 000000000000..aaa6a20d12b6
> --- /dev/null
> +++ b/rust/kernel/alloc/box_ext.rs
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Extensions to [`Box`] for fallible allocations.
> +
> +use super::Flags;
> +use alloc::boxed::Box;
> +use core::alloc::AllocError;
> +use core::mem::MaybeUninit;
> +use core::result::Result;
> +
> +/// Extensions to [`Box`].
> +pub trait BoxExt<T>: Sized {
> +    /// Allocates a new box.
> +    ///
> +    /// The allocation may fail, in which case an error is returned.
> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
> +
> +    /// Allocates a new uninitialised box.
> +    ///
> +    /// The allocation may fail, in which case an error is returned.
> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocErro=
r>;
> +}
> +
> +impl<T> BoxExt<T> for Box<T> {
> +    #[cfg(any(test, testlib))]
> +    fn new(x: T, _flags: Flags) -> Result<Self, AllocError> {
> +        Ok(Box::new(x))
> +    }
> +
> +    #[cfg(not(any(test, testlib)))]
> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> +        let ptr =3D if core::mem::size_of::<T>() =3D=3D 0 {
> +            core::ptr::NonNull::<T>::dangling().as_ptr()
> +        } else {
> +            let layout =3D core::alloc::Layout::new::<T>();
> +
> +            // SAFETY: Memory is being allocated (first arg is null). Th=
e only other source of
> +            // safety issues is sleeping on atomic context, which is add=
ressed by klint. Lastly,
> +            // the type is not a SZT (checked above).
> +            let ptr =3D unsafe {
> +                super::allocator::krealloc_aligned(core::ptr::null_mut()=
, layout, flags.0)
> +            };
> +            if ptr.is_null() {
> +                return Err(AllocError);
> +            }
> +
> +            let ptr =3D ptr.cast::<T>();
> +
> +            // SAFETY: We just allocated the memory above, it is valid f=
or write.
> +            unsafe { ptr.write(x) };
> +            ptr
> +        };
> +
> +        // SAFETY: For non-zero-sized types, we allocate above using the=
 global allocator. For
> +        // zero-sized types, we use `NonNull::dangling`.
> +        Ok(unsafe { Box::from_raw(ptr) })
> +    }
> +
> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocErro=
r> {
> +        <Box<_> as BoxExt<_>>::new(MaybeUninit::<T>::uninit(), flags)

Note that the expression `MaybeUninit::<T>::uninit()` introduces a
temporary which will be allocated on the stack. If the type `T` is very
big, then this function will cause immediate stack overflows.

I would recommend to implement `new` in terms of `new_uninit`. The
`new_uninit` implementation can be almost the same as the current
implementation of `new`, just remove the `ptr.write(x)` statement.

--=20
Cheers,
Benno

> +    }
> +}


