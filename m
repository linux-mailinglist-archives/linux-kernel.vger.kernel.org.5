Return-Path: <linux-kernel+bounces-47677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E0784511D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63932B26B39
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B97D81AC5;
	Thu,  1 Feb 2024 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="rWzdjeqd"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90169964
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767364; cv=none; b=knhXGAmu5fxUFebFEtv8wtZpu0CUeDSq7+yxRyHkoj1Lq6vRsWiC674YwYcvXNSAiMUgTBni13GIoX0kh2QAEBiF2NhRdwLQtyBI+fbjPM/CBZq7Yu9VxQYAO/HYayaEqy6tpoCi+LDysbRnKhesApiXtyJpMcwR2uFvpIhYMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767364; c=relaxed/simple;
	bh=BWXjvn1WrcWmIAKsvVlO551dw6bRFuLHM55n2sO9UXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCA5zF6xE5khDUQMd0ST/GzHJ7q2PCzN2elwsNBiJB66lKXPv1jor9j3brkUe9mB/S2QrxL2qxcZTA2PZ6+MEi0QrkchyOnWOmVQiqtkn6bkJ9vq9SzwFbRPDDd/62B/2fnyOnylSpL/TpwG5F7gaonh3wamZawRKy+vRKp6bxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=rWzdjeqd; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6db13f1abso172949276.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706767361; x=1707372161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mwgn/QSK2JvsemXWguzhCOtQHmbYu/lyiMFsqWuyyE=;
        b=rWzdjeqdNcm/UP48WfnWFIKOIVt6xSpLef/z7CE77DV7kfaVk2P1k9ESjKGsFKsaLv
         Vk35z69E1F6+ce4u/3jxwq9t7ifGPiIGmH5uUD3inlYwjHZ3f/CA0VaP8oEHJLpUxR3i
         fDE1F/0Wx9isqrZWqI1NQf3mLy+E4rHiF/o5f2xpkwrvuuwaMyQq8DYqp2CzBtP9Ijbi
         yrwJXnddRlAesWrd/a5hXoIU5NoKoQwtPFjZu9jJKwIURO64s8s3Y45Vqvub49XFyayO
         NEoG11qQSl1JASoQDKsRn964NcxzzDLGeKT2xoXtAgA/SXix9ZLU1CK3qsNPWg113kAY
         S/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706767361; x=1707372161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Mwgn/QSK2JvsemXWguzhCOtQHmbYu/lyiMFsqWuyyE=;
        b=ZgzemzQB1S0R2pOxg1vSivp9shuMNIxDWD9EC1WZaCd9BTBS0XbFb92Vke+5zTUdVY
         ZabJw8LPOjYGQ3dZ8mAFZHs6DsPlRosAwQsYphwW7okOPe9ssY8keYSZDYPa9q7OBihN
         rlkCmLa7sTsiijEp0dpsXIaL1hl+P8OlF//MN/9Yz5u/MdObaxpGKqfOB/M6WB3u9egw
         jnM9wXeVnrwCr0QQ/lwCgIiZHjoh4TGGYDVLFN827jhVr6dlLB3Vcqj5D0OhazoehoKj
         rQTf1z0J8A9C23KOu62MSqteQyr3jL4Q2t96BSuJuN2ewwsOPghcgQMSjiZtaP4t6EMh
         NS/Q==
X-Gm-Message-State: AOJu0YwXVHD7Q4FGcndrl2RdH1TkzzC2RRoj2hQDngDbPwtnkCEeTm5X
	6A6L67nXoaUP/uxLWksuo1GIaBk4Q2mpyPS91pKoxwZzuT1tWE7Kv4E88RNSXJGoBPu2vQO+LR7
	QqyFAmEr7mIeAQlkXeX47XpGxnRddrNa2h/E/Iw==
X-Google-Smtp-Source: AGHT+IFJu59Zj/bIfKeYdW/9VSltP5uh59sSolnrsNHFKdNwn6YS3IjqdK+InnXn5JB16Q0dFVT2MGTes1Ri5ynzxv8=
X-Received: by 2002:a25:fc13:0:b0:db5:37c7:a0cb with SMTP id
 v19-20020a25fc13000000b00db537c7a0cbmr3744674ybd.11.1706767360702; Wed, 31
 Jan 2024 22:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com> <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
In-Reply-To: <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 1 Feb 2024 01:02:29 -0500
Message-ID: <CALNs47uPgvYXxEDmwb6GKa+cw597_rDD1zaSPDa9k9D-6_qZxQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 6:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Kernel page allocation and management.
> +
> +use crate::{bindings, error::code::*, error::Result, user_ptr::UserSlice=
PtrReader};
> +use core::{
> +    alloc::AllocError,
> +    ffi::c_void,
> +    ptr::{self, NonNull},
> +};
> +
> +/// A bitwise shift for the page size.
> +pub const PAGE_SHIFT: usize =3D bindings::PAGE_SHIFT as usize;
> +/// The number of bytes in a page.
> +pub const PAGE_SIZE: usize =3D 1 << PAGE_SHIFT;
> +/// A bitwise mask for the page size.
> +pub const PAGE_MASK: usize =3D PAGE_SIZE - 1;
> +
> +/// A pointer to a page that owns the page allocation.
> +///
> +/// # Invariants
> +///
> +/// The pointer points at a page, and has ownership over the page.
> +pub struct Page {
> +    page: NonNull<bindings::page>,
> +}

Shouldn't this be UnsafeCell / Opaque? Since `struct page` contains locks.

> +// SAFETY: It is safe to transfer page allocations between threads.
> +unsafe impl Send for Page {}
> +
> +// SAFETY: Calling `&self` methods on this type in parallel is safe. It =
might
> +// allow you to perform a data race on bytes stored in the page, but we =
treat
> +// this like data races on user pointers.
> +unsafe impl Sync for Page {}

These races should probably be in the Page docs, rather than pointing
to user pointers.

> +impl Page {
> +    /// Allocates a new set of contiguous pages.

"set of contiguous page" -> "page"?

> +    pub fn new() -> Result<Self, AllocError> {
> +        // SAFETY: These are the correct arguments to allocate a single =
page.
> +        let page =3D unsafe {
> +            bindings::alloc_pages(
> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::=
__GFP_HIGHMEM,
> +                0,
> +            )
> +        };
> +
> +        match NonNull::new(page) {
> +            // INVARIANT: We checked that the allocation above succeeded=
.
> +            Some(page) =3D> Ok(Self { page }),
> +            None =3D> Err(AllocError),
> +        }

Optionally:

    let page =3D NonNull::new(page).ok_or(AllocError)?;
    Ok(Self { page })

> +    }
> +
> +    /// Returns a raw pointer to the page.

Maybe add ", valid for PAGE_SIZE" or similar to make this obvious.

> +    pub fn as_ptr(&self) -> *mut bindings::page {
> +        self.page.as_ptr()
> +    }
> +
> +    /// Runs a piece of code with this page mapped to an address.

Maybe ", then immediately unmaps the page" to make the entire operation cle=
ar.

> +    /// It is up to the caller to use the provided raw pointer correctly=
.
> +    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut c_void) -> T) =
-> T {

If there is exclusive access into the page, this signature could be:

    FnOnce(&mut [u8; PAGE_SIZE]) -> T

Otherwise possibly

    FnOnce(*mut [u8; PAGE_SIZE]) -> T

But based on the thread with Boqun it seems there is no synchronized
access here. In this case, "use the provided raw pointer correctly" or
the type level docs should clarify what you can and can't rely on with
pointers into a page.

E.g. if I'm understanding correctly, you can never construct a &T or
&mut T anywhere in this page unless T is Sync.

> +        // SAFETY: `page` is valid due to the type invariants on `Page`.
> +        let mapped_addr =3D unsafe { bindings::kmap_local_page(self.as_p=
tr()) };
> +
> +        let res =3D f(mapped_addr);
> +
> +        // SAFETY: This unmaps the page mapped above.
> +        //
> +        // Since this API takes the user code as a closure, it can only =
be used
> +        // in a manner where the pages are unmapped in reverse order. Th=
is is as
> +        // required by `kunmap_local`.
> +        //
> +        // In other words, if this call to `kunmap_local` happens when a
> +        // different page should be unmapped first, then there must nece=
ssarily
> +        // be a call to `kmap_local_page` other than the call just above=
 in
> +        // `with_page_mapped` that made that possible. In this case, it =
is the
> +        // unsafe block that wraps that other call that is incorrect.
> +        unsafe { bindings::kunmap_local(mapped_addr) };
> +
> +        res
> +    }
> +
> +    /// Runs a piece of code with a raw pointer to a slice of this page,=
 with
> +    /// bounds checking.
> +    ///
> +    /// If `f` is called, then it will be called with a pointer that poi=
nts at
> +    /// `off` bytes into the page, and the pointer will be valid for at =
least
> +    /// `len` bytes. The pointer is only valid on this task, as this met=
hod uses
> +    /// a local mapping./
> +    ///
> +    /// If `off` and `len` refers to a region outside of this page, then=
 this
> +    /// method returns `EINVAL` and does not call `f`.
> +    pub fn with_pointer_into_page<T>(
> +        &self,
> +        off: usize,
> +        len: usize,
> +        f: impl FnOnce(*mut u8) -> Result<T>,
> +    ) -> Result<T> {

Same question about exclusive access

    impl FnOnce(&mut [u8]) -> Result<T>

> +        let bounds_ok =3D off <=3D PAGE_SIZE && len <=3D PAGE_SIZE && (o=
ff + len) <=3D PAGE_SIZE;
> +
> +        if bounds_ok {
> +            self.with_page_mapped(move |page_addr| {
> +                // SAFETY: The `off` integer is at most `PAGE_SIZE`, so =
this pointer offset will
> +                // result in a pointer that is in bounds or one off the =
end of the page.
> +                f(unsafe { page_addr.cast::<u8>().add(off) })
> +            })
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +
> +    /// Maps the page and reads from it into the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `dest` is valid for writing `len` bytes=
.
> +    pub unsafe fn read(&self, dest: *mut u8, offset: usize, len: usize) =
-> Result {

Is there a reason not to use a slice just for a destination to read into?

> +        self.with_pointer_into_page(offset, len, move |from_ptr| {

Nit: do the names from_ptr/to_ptr come from existing binder? src/dst
seems more common (also dst vs. dest).

> +            // SAFETY: If `with_pointer_into_page` calls into this closu=
re, then
> +            // it has performed a bounds check and guarantees that `from=
_ptr` is
> +            // valid for `len` bytes.
> +            unsafe { ptr::copy(from_ptr, dest, len) };
> +            Ok(())
> +        })
> +    }
> +
> +    /// Maps the page and writes into it from the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `src` is valid for reading `len` bytes.
> +    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize=
) -> Result {

Same slice question

> +        self.with_pointer_into_page(offset, len, move |to_ptr| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closu=
re, then
> +            // it has performed a bounds check and guarantees that `to_p=
tr` is
> +            // valid for `len` bytes.
> +            unsafe { ptr::copy(src, to_ptr, len) };
> +            Ok(())
> +        })
> +    }
> +
> +    /// Maps the page and zeroes the given slice.

Mention that this will error with the same conditions as with_pointer_into_=
page.

> +    pub fn fill_zero(&self, offset: usize, len: usize) -> Result {
> +        self.with_pointer_into_page(offset, len, move |to_ptr| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closu=
re, then
> +            // it has performed a bounds check and guarantees that `to_p=
tr` is
> +            // valid for `len` bytes.
> +            unsafe { ptr::write_bytes(to_ptr, 0u8, len) };
> +            Ok(())
> +        })
> +    }
> +
> +    /// Copies data from userspace into this page.
> +    pub fn copy_into_page(
> +        &self,
> +        reader: &mut UserSlicePtrReader,
> +        offset: usize,
> +        len: usize,
> +    ) -> Result {

Maybe copy_from_user_slice or something that includes "user", since
as-is it sounds like copying a page into another page.

Also, docs should point out the error condition.

> +        self.with_pointer_into_page(offset, len, move |to_ptr| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closu=
re, then
> +            // it has performed a bounds check and guarantees that `to_p=
tr` is
> +            // valid for `len` bytes.
> +            unsafe { reader.read_raw(to_ptr, len) }
> +        })
> +    }
> +}
> +
> +impl Drop for Page {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we have ownership of the page=
 and can
> +        // free it.
> +        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
> +    }
> +}
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>
>

- Trevor

