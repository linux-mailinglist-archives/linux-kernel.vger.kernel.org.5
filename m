Return-Path: <linux-kernel+bounces-132208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD423899166
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832DB28AFF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2A16F09C;
	Thu,  4 Apr 2024 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KwgD1BTs"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAD286A6;
	Thu,  4 Apr 2024 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270043; cv=none; b=ME9ogmWDakd9d78GGJ6ojhALBSVgbixoBpw9t6XMOAPybI8WoVNv71XlT4XG30Fx4gq7a869jJttLlHYZCxkQP4134u4mNaRA1ktxNRtBJ4o4utaM9QLTO16Qehn8jOL5gWQeDIuU+b3L6vM1bOs7hSP4eMiGvyVTrjk64q042o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270043; c=relaxed/simple;
	bh=2CeE+2aVUqJcRU7QmoWqM5Y+xjY/bn15DEc+RQneXmM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBK23mRpuF0WnvsCyH3vjFdN4F6SQPgN5YnGZGjYTbVZXVuzxm9pYvL/rW8xmJFRnukDgZYVO9zjCCG+aYD5egqgS965PRnEjqa45vjxah+JzzW6bNp92ibhJzzX34e6BGGtYrtH3aJPWVR+mMrsWrC4od1STl2kH3zKoMevu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KwgD1BTs; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=i72cbelw3nfq7acf5fidjehlti.protonmail; t=1712270032; x=1712529232;
	bh=ZVL2Z0cS5q+LN/fYP+ykEsgKaNFbc8NkPR7q7d8Y7Bo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KwgD1BTs62V/7Rke9wK4bxM66yt20AtPTwOGpJq0vS+Fh7Xo1SYkE58+jw7TBknSa
	 M4rt9UsmzBMP7ZKbLymXNE2/S/8DJ9/yADXe7xQlwyOnBkwJw/Hw7JT5Qzzpl9a8Ms
	 +WnwMUUBfiurWz5wW032w6aA+E8VTyWo+qL3rRCIXtqup0Isx7OBV06ngQZ8YvTaYC
	 rnNaciU1wzvdJiQuIRb3gnQZt1EwGU3Civ5HOcJIGWO6zEbQh/tlDF5+1egGblZaEw
	 g6tPHb6txJ1nBScmvpB+g6gso0CqJQafBzvu+4TnqZ/es6DSX3ySX+w/gdquTX/WWC
	 WT7fe/TPrmJ8w==
Date: Thu, 04 Apr 2024 22:33:42 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 4/4] rust: add abstraction for `struct page`
Message-ID: <a48b2347-b58b-432e-bdb8-d5449016ab57@proton.me>
In-Reply-To: <20240404-alice-mm-v4-4-49a84242cf02@google.com>
References: <20240404-alice-mm-v4-0-49a84242cf02@google.com> <20240404-alice-mm-v4-4-49a84242cf02@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 14:31, Alice Ryhl wrote:
> Adds a new struct called `Page` that wraps a pointer to `struct page`.
> This struct is assumed to hold ownership over the page, so that Rust
> code can allocate and manage pages directly.
>=20
> The page type has various methods for reading and writing into the page.
> These methods will temporarily map the page to allow the operation. All
> of these methods use a helper that takes an offset and length, performs
> bounds checks, and returns a pointer to the given offset in the page.
>=20
> This patch only adds support for pages of order zero, as that is all
> Rust Binder needs. However, it is written to make it easy to add support
> for higher-order pages in the future. To do that, you would add a const
> generic parameter to `Page` that specifies the order. Most of the
> methods do not need to be adjusted, as the logic for dealing with
> mapping multiple pages at once can be isolated to just the
> `with_pointer_into_page` method. Finally, the struct can be renamed to
> `Pages<ORDER>`, and the type alias `Page =3D Pages<0>` can be introduced.

This part seems outdated, I think we probably make `ORDER` default to 0.

>=20
> Rust Binder needs to manage pages directly as that is how transactions
> are delivered: Each process has an mmap'd region for incoming
> transactions. When an incoming transaction arrives, the Binder driver
> will choose a region in the mmap, allocate and map the relevant pages
> manually, and copy the incoming transaction directly into the page. This
> architecture allows the driver to copy transactions directly from the
> address space of one process to another, without an intermediate copy
> to a kernel buffer.

[...]

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> new file mode 100644
> index 000000000000..5aba0261242d
> --- /dev/null
> +++ b/rust/kernel/page.rs
> @@ -0,0 +1,259 @@
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
> +#[allow(clippy::unnecessary_cast)]

Why can't you remove the cast?

> +pub const PAGE_SHIFT: usize =3D bindings::PAGE_SHIFT as usize;
> +
> +/// The number of bytes in a page.
> +#[allow(clippy::unnecessary_cast)]
> +pub const PAGE_SIZE: usize =3D bindings::PAGE_SIZE as usize;
> +
> +/// A bitmask that gives the page containing a given address.
> +pub const PAGE_MASK: usize =3D !(PAGE_SIZE-1);

This line doesn't seem to be correctly formatted.

> +
> +/// Flags for the "get free page" function that underlies all memory all=
ocations.
> +pub mod flags {
> +    /// gfp flags.
> +    #[allow(non_camel_case_types)]
> +    pub type gfp_t =3D bindings::gfp_t;
> +
> +    /// `GFP_KERNEL` is typical for kernel-internal allocations. The cal=
ler requires `ZONE_NORMAL`
> +    /// or a lower zone for direct access but can direct reclaim.
> +    pub const GFP_KERNEL: gfp_t =3D bindings::GFP_KERNEL;
> +    /// `GFP_ZERO` returns a zeroed page on success.
> +    pub const __GFP_ZERO: gfp_t =3D bindings::__GFP_ZERO;
> +    /// `GFP_HIGHMEM` indicates that the allocated memory may be located=
 in high memory.
> +    pub const __GFP_HIGHMEM: gfp_t =3D bindings::__GFP_HIGHMEM;
> +}
> +
> +/// A pointer to a page that owns the page allocation.
> +///
> +/// # Invariants
> +///
> +/// The pointer is valid, and has ownership over the page.
> +pub struct Page {
> +    page: NonNull<bindings::page>,
> +}
> +
> +// SAFETY: Pages have no logic that relies on them staying on a given th=
read, so
> +// moving them across threads is safe.
> +unsafe impl Send for Page {}
> +
> +// SAFETY: Pages have no logic that relies on them not being accessed
> +// concurrently, so accessing them concurrently is safe.
> +unsafe impl Sync for Page {}
> +
> +impl Page {
> +    /// Allocates a new page.
> +    pub fn alloc_page(gfp_flags: flags::gfp_t) -> Result<Self, AllocErro=
r> {
> +        // SAFETY: Depending on the value of `gfp_flags`, this call may =
sleep.
> +        // Other than that, it is always safe to call this method.
> +        let page =3D unsafe { bindings::alloc_pages(gfp_flags, 0) };
> +        let page =3D NonNull::new(page).ok_or(AllocError)?;
> +        // INVARIANT: We just successfully allocated a page, so we now h=
ave
> +        // ownership of the newly allocated page. We transfer that owner=
ship to
> +        // the new `Page` object.
> +        Ok(Self { page })
> +    }
> +
> +    /// Returns a raw pointer to the page.
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
 The
> +    /// pointer is valid for `PAGE_SIZE` bytes and for the duration in w=
hich the
> +    /// closure is called. The pointer might only be mapped on the curre=
nt
> +    /// thread, and when that is the case, dereferencing it on other thr=
eads is
> +    /// UB. Other than that, the usual rules for dereferencing a raw poi=
nter
> +    /// apply: don't cause data races, the memory may be uninitialized, =
and so
> +    /// on.
> +    ///
> +    /// If multiple threads map the same page at the same time, then the=
y may
> +    /// reference with different addresses. However, even if the address=
es are
> +    /// different, the underlying memory is still the same for these pur=
poses
> +    /// (e.g., it's still a data race if they both write to the same und=
erlying
> +    /// byte at the same time).

This is nice.

--=20
Cheers,
Benno

> +    fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T {
> +        // SAFETY: `page` is valid due to the type invariants on `Page`.
> +        let mapped_addr =3D unsafe { bindings::kmap_local_page(self.as_p=
tr()) };
> +
> +        let res =3D f(mapped_addr.cast());
> +
> +        // This unmaps the page mapped above.
> +        //
> +        // SAFETY: Since this API takes the user code as a closure, it c=
an only
> +        // be used in a manner where the pages are unmapped in reverse o=
rder.
> +        // This is as required by `kunmap_local`.
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


