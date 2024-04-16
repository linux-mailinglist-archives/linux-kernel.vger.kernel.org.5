Return-Path: <linux-kernel+bounces-146281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3758B8A632C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85649B21AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45933BBF6;
	Tue, 16 Apr 2024 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="SvL06M4l"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480CD3B7AC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246040; cv=none; b=mhhyJ3YVyaMfWrVlnGdy/yPA1C7JL+GxzMhI5jLiuJy2nf/k2gRT3X8+vzkxpMYRJYBI67Hiw5V+DJ63v7HiE3YVqRWimS322f7p84osaDHd63oluZQe6JPMfl06Dm/OyfNChcs3KySgfzkjR3uB7A9r6Any+qMtcqrW7M77Ce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246040; c=relaxed/simple;
	bh=qdY6jPNtZdRKwxkv5vlWMVyHFL3sMFt8KXejXwuxxxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b//iC8JkPRm6EouU+AFDkORmqw3w3TL2SlU5ZN9hCsIRyM5xJUAQhfc4t7sys6cTc0G7JK+p1YCrOm1wmJ3oX2nb5arlU0XlyiOXMnMZlzPzkmhLoree2NYZalrk7DpdFgIOCEACvNS3vvau5ZvSJEOpw78BB0bQRa3rqHu/JfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=SvL06M4l; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4001749276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1713246036; x=1713850836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZnTsFH2u/jd95rE0nScFwnMla46fGdQkSBISp00WVA=;
        b=SvL06M4ljd9vfAK2aQ871KaS+ZIRrVIgPmuEXsYMCRJz4uXuLTOqB/30LlwpELGSfp
         p1ciZ57Wt+3mwtxxHe8ST0v8t2CCeNnRddpTg+CXIv2yg633daIRGJp330AaK8UWh7lM
         yO3sdszLsvS86QAbBwPjuyhlbTrsPXfUN5EjPXeqbpbs/l1ZDMAcOSjRy15vLT2a8bF+
         RZLSwESFYHEf23XcZTCMNyDRAhXqG6+uRC6yMYDYPpgEwNDyaw0g3UYJUtrR6mgTfDPW
         q/rw/gM+6JIFDxmYcYA3KvhbzZON2+HAHs5uf3iyVNwhWXcZUlHnPYJ70v5+GD3ggCd7
         bCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713246036; x=1713850836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZnTsFH2u/jd95rE0nScFwnMla46fGdQkSBISp00WVA=;
        b=AWFNPhzGtRFbQX4k1AbAfZoyg1WwQ1Z72WhoJZg5qn5UfO4SxSwRWfkmyKZynxB8GG
         f4EKe1+CxOAvBWsIM38bvcKwhfO59UC2vs0HhuO1KIfZ2zpUXTeGqVDdGdyvn2YtnFbr
         sPH26T6rpXdLw40NsgH5Vc5OpDaDFXujnLC99bZYnMFjhCkvTlBmL7dlCAn6pANnEHHJ
         ZTzgBj50lfkYYTixNrAarHcPBkCe0cUTw6X/sq6Pcq0rEuBd/gh2xjAR1HvffvYrLKK4
         7s2wJtcSA5KqofDBUbdMX4FQJlj3RB+i0fZi8MkeoVnWbvMY3hJd2w41Ffiksv9hxN5H
         yeUg==
X-Forwarded-Encrypted: i=1; AJvYcCX/MLUI6VgxgoNJ0WtU27RzYbytz/t/TnSiYNEXvcXAV6BoC96PDy2DM8XpO+6yUM7V63sIoqzSA0V35nxZwQ+pu8tvePvbK9l+iLB+
X-Gm-Message-State: AOJu0YzZ4ocglacPgjZ+FJk9BndeTVb8Q09gymJ8f4ALf7StYqhi8B6y
	Tn4AHMDC1M7ENYu+/R2wjE551uS5qyQm2Qiz1zfwkgAXyTF0kXoOHBcCjCI/C9z9ecvNZnySOFb
	3GjpSrg8ZkuWs+7v0UItvpLgOh4P3MCqqwbAsqw==
X-Google-Smtp-Source: AGHT+IGuUXE3/S314JFZlsIl8KEIWGV1s7fbLfZ+EKGCMv6cWkNb4R6jL13/UiXlkh0SwJJUedsQg35/YYR3WhhU/6g=
X-Received: by 2002:a25:9ac1:0:b0:dcf:f535:dad6 with SMTP id
 t1-20020a259ac1000000b00dcff535dad6mr9792461ybo.56.1713246036166; Mon, 15 Apr
 2024 22:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com> <20240415-alice-mm-v5-4-6f55e4d8ef51@google.com>
In-Reply-To: <20240415-alice-mm-v5-4-6f55e4d8ef51@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 16 Apr 2024 01:40:25 -0400
Message-ID: <CALNs47tEZqL201jsExfF1j7m+yW37YRAws-NTF6hwsxohSKoQA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] rust: add abstraction for `struct page`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:15=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Adds a new struct called `Page` that wraps a pointer to `struct page`.
> This struct is assumed to hold ownership over the page, so that Rust
> code can allocate and manage pages directly.
>
> The page type has various methods for reading and writing into the page.
> These methods will temporarily map the page to allow the operation. All
> of these methods use a helper that takes an offset and length, performs
> bounds checks, and returns a pointer to the given offset in the page.
>
> This patch only adds support for pages of order zero, as that is all
> Rust Binder needs. However, it is written to make it easy to add support
> for higher-order pages in the future. To do that, you would add a const
> generic parameter to `Page` that specifies the order. Most of the
> methods do not need to be adjusted, as the logic for dealing with
> mapping multiple pages at once can be isolated to just the
> `with_pointer_into_page` method.
>
> Rust Binder needs to manage pages directly as that is how transactions
> are delivered: Each process has an mmap'd region for incoming
> transactions. When an incoming transaction arrives, the Binder driver
> will choose a region in the mmap, allocate and map the relevant pages
> manually, and copy the incoming transaction directly into the page. This
> architecture allows the driver to copy transactions directly from the
> address space of one process to another, without an intermediate copy
> to a kernel buffer.
>
> This code is based on Wedson's page abstractions from the old rust
> branch, but it has been modified by Alice by removing the incomplete
> support for higher-order pages, by introducing the `with_*` helpers
> to consolidate the bounds checking logic into a single place, and by
> introducing gfp flags.
>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I have a couple questions about naming, and think an example would be
good for the functions that are trickier to use correctly. But I
wouldn't block on this, implementation looks good to me.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

> +++ b/rust/kernel/page.rs
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Kernel page allocation and management.
> +
> +use crate::{bindings, error::code::*, error::Result, uaccess::UserSliceR=
eader};
> +use core::{
> +    alloc::AllocError,
> +    ptr::{self, NonNull},
> +};
> +
> +/// A bitwise shift for the page size.
> +pub const PAGE_SHIFT: usize =3D bindings::PAGE_SHIFT as usize;
> +
> +/// The number of bytes in a page.
> +pub const PAGE_SIZE: usize =3D bindings::PAGE_SIZE;
> +
> +/// A bitmask that gives the page containing a given address.
> +pub const PAGE_MASK: usize =3D !(PAGE_SIZE - 1);
> +
> +/// Flags for the "get free page" function that underlies all memory all=
ocations.
> +pub mod flags {
> +    /// gfp flags.

Uppercase acronym, maybe with a description:

    GFP (Get Free Page) flags.

> +    #[allow(non_camel_case_types)]
> +    pub type gfp_t =3D bindings::gfp_t;

Why not GfpFlags, do we do this elsewhere?

> +    /// `GFP_KERNEL` is typical for kernel-internal allocations. The cal=
ler requires `ZONE_NORMAL`
> +    /// or a lower zone for direct access but can direct reclaim.
> +    pub const GFP_KERNEL: gfp_t =3D bindings::GFP_KERNEL;
> +    /// `GFP_ZERO` returns a zeroed page on success.
> +    pub const __GFP_ZERO: gfp_t =3D bindings::__GFP_ZERO;
> +    /// `GFP_HIGHMEM` indicates that the allocated memory may be located=
 in high memory.
> +    pub const __GFP_HIGHMEM: gfp_t =3D bindings::__GFP_HIGHMEM;

It feels a bit weird to have dunder constants on the rust side that
aren't also `#[doc(hidden)]` or just nonpublic. Makes me think they
are an implementation detail or not really meant to be used - could
you update the docs if this is the case?

> +
> +impl Page {
> +    /// Allocates a new page.

Could you add a small example here?

> +    pub fn alloc_page(gfp_flags: flags::gfp_t) -> Result<Self, AllocErro=
r> {
> [...]
> +    }
> +
> +    /// Returns a raw pointer to the page.

Could you add a note about how the pointer needs to be used correctly,
if it is for anything more than interfacing with kernel APIs?

> +    pub fn as_ptr(&self) -> *mut bindings::page {
> +        self.page.as_ptr()
> +    }
> +
> +    /// Runs a piece of code with this page mapped to an address.
> +    ///
> +    /// The page is unmapped when this call returns.
> +    ///
> +    /// # Using the raw pointer
> +    ///
> +    /// It is up to the caller to use the provided raw pointer correctly=
 The pointer is valid for
> +    /// `PAGE_SIZE` bytes and for the duration in which the closure is c=
alled. The pointer might
> +    /// only be mapped on the current thread, and when that is the case,=
 dereferencing it on other
> +    /// threads is UB. Other than that, the usual rules for dereferencin=
g a raw pointer apply: don't
> +    /// cause data races, the memory may be uninitialized, and so on.
> +    ///
> +    /// If multiple threads map the same page at the same time, then the=
y may reference with
> +    /// different addresses. However, even if the addresses are differen=
t, the underlying memory is
> +    /// still the same for these purposes (e.g., it's still a data race =
if they both write to the
> +    /// same underlying byte at the same time).
> +    fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T {
> [...]
> +    }

Could you add an example of how to use this correctly?

> +    /// Runs a piece of code with a raw pointer to a slice of this page,=
 with bounds checking.
> +    ///
> +    /// If `f` is called, then it will be called with a pointer that poi=
nts at `off` bytes into the
> +    /// page, and the pointer will be valid for at least `len` bytes. Th=
e pointer is only valid on
> +    /// this task, as this method uses a local mapping.
> +    ///
> +    /// If `off` and `len` refers to a region outside of this page, then=
 this method returns
> +    /// `EINVAL` and does not call `f`.
> +    ///
> +    /// # Using the raw pointer
> +    ///
> +    /// It is up to the caller to use the provided raw pointer correctly=
 The pointer is valid for
> +    /// `len` bytes and for the duration in which the closure is called.=
 The pointer might only be
> +    /// mapped on the current thread, and when that is the case, derefer=
encing it on other threads
> +    /// is UB. Other than that, the usual rules for dereferencing a raw =
pointer apply: don't cause
> +    /// data races, the memory may be uninitialized, and so on.
> +    ///
> +    /// If multiple threads map the same page at the same time, then the=
y may reference with
> +    /// different addresses. However, even if the addresses are differen=
t, the underlying memory is
> +    /// still the same for these purposes (e.g., it's still a data race =
if they both write to the
> +    /// same underlying byte at the same time).

This could probably also use an example. A note about how to select
between with_pointer_into_page and with_page_mapped would also be nice
to guide usage, e.g. "prefer with_pointer_into_page for all cases
except when..."

> +    fn with_pointer_into_page<T>(
> +        &self,
> +        off: usize,
> +        len: usize,
> +        f: impl FnOnce(*mut u8) -> Result<T>,
> +    ) -> Result<T> {
> [...]
> +    /// Maps the page and zeroes the given slice.
> +    ///
> +    /// This method will perform bounds checks on the page offset. If `o=
ffset .. offset+len` goes
> +    /// outside ot the page, then this call returns `EINVAL`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that this call does not race with a read or =
write to the same page that
> +    /// overlaps with this write.
> +    pub unsafe fn fill_zero(&self, offset: usize, len: usize) -> Result =
{
> +        self.with_pointer_into_page(offset, len, move |dst| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closu=
re, then it has performed a
> +            // bounds check and guarantees that `dst` is valid for `len`=
 bytes.
> +            //
> +            // There caller guarantees that there is no data race.
> +            unsafe { ptr::write_bytes(dst, 0u8, len) };
> +            Ok(())
> +        })
> +    }

Could this be named `fill_zero_raw` to leave room for a safe
`fill_zero(&mut self, ...)`?

> +    /// Copies data from userspace into this page.
> +    ///
> +    /// This method will perform bounds checks on the page offset. If `o=
ffset .. offset+len` goes
> +    /// outside ot the page, then this call returns `EINVAL`.
> +    ///
> +    /// Like the other `UserSliceReader` methods, data races are allowed=
 on the userspace address.
> +    /// However, they are not allowed on the page you are copying into.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that this call does not race with a read or =
write to the same page that
> +    /// overlaps with this write.
> +    pub unsafe fn copy_from_user_slice(
> +        &self,
> +        reader: &mut UserSliceReader,
> +        offset: usize,
> +        len: usize,
> +    ) -> Result {
> +        self.with_pointer_into_page(offset, len, move |dst| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closu=
re, then it has performed a
> +            // bounds check and guarantees that `dst` is valid for `len`=
 bytes. Furthermore, we have
> +            // exclusive access to the slice since the caller guarantees=
 that there are no races.
> +            reader.read_raw(unsafe { core::slice::from_raw_parts_mut(dst=
cast(), len) })
> +        })
> +    }
> +}

Same as above, `copy_from_user_slice_raw` would leave room for a safe API.

