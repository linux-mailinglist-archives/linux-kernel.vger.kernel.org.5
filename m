Return-Path: <linux-kernel+bounces-131764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F714898B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F41C21835
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C49A86ADB;
	Thu,  4 Apr 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="D9goF/Wq"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA31292E5;
	Thu,  4 Apr 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245682; cv=none; b=WUUhmpZUexqHPfUpMonm1haXo72nqRHUKbRBY0AwrujkWbNfn4yCVpmVpMxSuNvBtNynksJuvPse6XoPjOwae7zqGHXKLOUPjZup3/XHyn192MDRWEBBIGslyyJ/ym0D4D8X9+1kQLyTtkXF4g+6Mz1ocjuvrC1mThW195jHsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245682; c=relaxed/simple;
	bh=LP0uZSuTig8XQMIPTRba8MduWopWSkwtnn04svCVZOM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssPVM7zaiyOrtajpa1uir0nyIOUgPbq0pcN/XA92kfF4T2/R1yztfe1V61zDh1MXNbvyMXEvVCySbbEEWumHaPfMLtV3Aa9W1lWf5QrShwHBziN95h6pMQUDqiR390B0A7wyGWRV5lSJYC100MJ35yWHv7aC5P+0ZSQWFJCeSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=D9goF/Wq; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712245678; x=1712504878;
	bh=b94fePUkCB3u0VzYfcwy26wl06e1l/qHAvF9anETlCY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=D9goF/Wqu2/yGD93JT0jylmtc2ePnclvzANZkdbFrKB+CuMNy4a5B0FTzMsuOUrJa
	 CBmGLE7eZClpgPiHT3fKLR+hVH3H4Qz9GYK0VPaYgg8Etx+NNcJrXmMFfm8ND3xV7m
	 BQbcDPA/oKG60qcTt0ZgbzZfAq6bf5tICJfpH9e8VAG7aLmr7hYp5OYraQl+m+vgNj
	 /SaJmN0PfRPyR0agEFbZG+SyclipoFEQM6qHxcL+XPFu+wT1DBWgY+/LX6CoB5zEa/
	 m4T5IgeadPaTvbAOkzXOjlKmn9amIlQplwul1MM4nTVo6z8+Zzy+Jm0Q55gh+vYsVo
	 u3xaNZgOXlgTw==
Date: Thu, 04 Apr 2024 15:47:49 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 9/9] rust: list: add ListArcField
Message-ID: <86ac172a-4ad5-4cc5-844e-7b928d0765bd@proton.me>
In-Reply-To: <20240402-linked-list-v1-9-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-9-b1c59ba7ae3b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.24 14:17, Alice Ryhl wrote:
> One way to explain what `ListArc` does is that it controls exclusive
> access to the prev/next pointer field in a refcounted object. The
> feature of having a special reference to a refcounted object with
> exclusive access to specific fields is useful for other things, so
> provide a general utility for that.
>=20
> This is used by Rust Binder to keep track of which processes have a
> reference to a given node. This involves an object for each process/node
> pair, that is referenced by both the process and the node. For some
> fields in this object, only the process's reference needs to access
> them (and it needs mutable access), so Binder uses a ListArc to give the
> process's reference exclusive access.

This pattern screams "field projection" :)

>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs           |  3 ++
>  rust/kernel/list/arc_field.rs | 94 +++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 97 insertions(+)
>=20
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index 68d03b100863..a59b35b67e9b 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -23,6 +23,9 @@
>      impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryN=
ewListArc,
>  };
>=20
> +mod arc_field;
> +pub use self::arc_field::{define_list_arc_field_getter, ListArcField};
> +
>  /// A linked list.
>  ///
>  /// All elements in this linked list will be [`ListArc`] references to t=
he value. Since a value can
> diff --git a/rust/kernel/list/arc_field.rs b/rust/kernel/list/arc_field.r=
s
> new file mode 100644
> index 000000000000..936fd97bc5ac
> --- /dev/null
> +++ b/rust/kernel/list/arc_field.rs
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! A field that is exclusively owned by a [`ListArc`].
> +//!
> +//! This can be used to have reference counted struct where one of the r=
eference counted pointers
> +//! has exclusive access to a field of the struct.
> +//!
> +//! [`ListArc`]: crate::list::ListArc
> +
> +use core::cell::UnsafeCell;
> +
> +/// A field owned by a specific `ListArc`.

Missing doc link.

> +pub struct ListArcField<T, const ID: u64 =3D 0> {
> +    value: UnsafeCell<T>,
> +}
> +
> +// SAFETY: If the inner type is thread-safe, then it's also okay for `Li=
stArc` to be thread-safe.
> +unsafe impl<T: Send + Sync, const ID: u64> Send for ListArcField<T, ID> =
{}
> +// SAFETY: If the inner type is thread-safe, then it's also okay for `Li=
stArc` to be thread-safe.
> +unsafe impl<T: Send + Sync, const ID: u64> Sync for ListArcField<T, ID> =
{}
> +
> +impl<T, const ID: u64> ListArcField<T, ID> {
> +    /// Creates a new `ListArcField`.
> +    pub fn new(value: T) -> Self {
> +        Self {
> +            value: UnsafeCell::new(value),
> +        }
> +    }
> +
> +    /// Access the value when we have exclusive access to the `ListArcFi=
eld`.
> +    ///
> +    /// This allows access to the field using an `UniqueArc` instead of =
a `ListArc`.
> +    pub fn get_mut(&mut self) -> &mut T {
> +        self.value.get_mut()
> +    }
> +
> +    /// Unsafely assert that you have shared access to the `ListArc` for=
 this field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must have shared access to the `ListArc<ID>` containi=
ng the struct with this
> +    /// field for the duration of the returned reference.
> +    pub unsafe fn assert_ref(&self) -> &T {
> +        // SAFETY: The caller has shared access to the `ListArc`, so the=
y also have shared access
> +        // to this field.
> +        unsafe { &*self.value.get() }
> +    }
> +
> +    /// Unsafely assert that you have mutable access to the `ListArc` fo=
r this field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must have mutable access to the `ListArc<ID>` contain=
ing the struct with this
> +    /// field for the duration of the returned reference.
> +    #[allow(clippy::mut_from_ref)]
> +    pub unsafe fn assert_mut(&self) -> &mut T {
> +        // SAFETY: The caller has exclusive access to the `ListArc`, so =
they also have exclusive
> +        // access to this field.
> +        unsafe { &mut *self.value.get() }
> +    }
> +}
> +
> +/// Defines.

Missing docs.

--=20
Cheers,
Benno

> +#[macro_export]
> +macro_rules! define_list_arc_field_getter {
> +    ($pub:vis fn $name:ident(&self $(<$id:tt>)?) -> &$typ:ty { $field:id=
ent }
> +     $($rest:tt)*
> +    ) =3D> {
> +        $pub fn $name<'a>(self: &'a $crate::list::ListArc<Self $(, $id)?=
>) -> &'a $typ {
> +            let field =3D &(&**self).$field;
> +            // SAFETY: We have a shared reference to the `ListArc`.
> +            unsafe { $crate::list::ListArcField::<$typ $(, $id)?>::asser=
t_ref(field) }
> +        }
> +
> +        $crate::list::define_list_arc_field_getter!($($rest)*);
> +    };
> +
> +    ($pub:vis fn $name:ident(&mut self $(<$id:tt>)?) -> &mut $typ:ty { $=
field:ident }
> +     $($rest:tt)*
> +    ) =3D> {
> +        $pub fn $name<'a>(self: &'a mut $crate::list::ListArc<Self $(, $=
id)?>) -> &'a mut $typ {
> +            let field =3D &(&**self).$field;
> +            // SAFETY: We have a mutable reference to the `ListArc`.
> +            unsafe { $crate::list::ListArcField::<$typ $(, $id)?>::asser=
t_mut(field) }
> +        }
> +
> +        $crate::list::define_list_arc_field_getter!($($rest)*);
> +    };
> +
> +    () =3D> {};
> +}
> +pub use define_list_arc_field_getter;
>=20
> --
> 2.44.0.478.gd926399ef9-goog
>=20


