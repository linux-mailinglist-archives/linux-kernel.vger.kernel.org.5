Return-Path: <linux-kernel+bounces-97891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE384877136
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBBD1F21725
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38D3BBE3;
	Sat,  9 Mar 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VKslXP3A"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD61364C0;
	Sat,  9 Mar 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709988971; cv=none; b=HrEa25f4O7D0wYgfPQGVXyZ9DvCp+7Hh6qDhxt6pVbk2dcr4Dabg2g4hqsLDbjEDakWquoQwDlcUMse6Fd8cVvPIGJxHcP+4FltDvfxF2H2cVGL6QHKlcjI7wUM7wh8ECvLa1CeFt8alNCKqIj7Jgtb3lW7Zknv7kTAlgjnAHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709988971; c=relaxed/simple;
	bh=ElLfEFnJ6xG3gz8E1eLHKtA0poaBTMqxkUvb3LCp40o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWzrMrzLi88SxVQ6cdMZTla0USrrbtAw94HTxGpHTYHY2ADROPav/em4PW7ZfndZAUQEo3eQzAe6RRADzewKRJvyX1YTAJOg8h51mhXqfpsmhe/SGTxd3TeXSTtCoR4s7VmSUtwBgBsCSJPKOy9sZX2JJsT4pvnXC3i02GIRbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VKslXP3A; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1709988963; x=1710248163;
	bh=QKG7Og4r8P88E0N1YInQ/WJ0SZGm9r7NkKPA5RX/JQg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VKslXP3A5rB0GXrXOtmAgqr7iSu5DaPUaZbdRIsukN7+B5A70FJTiY12TndIf1/0U
	 EqOemI7ofG401W9P8rTCnamYpigDpnmdSExQLtB+DqduIQgp+v1/kdTkyYqZDmH2fV
	 NsNxwhAFtKKRQDmk1hX76+KzbCqiGjuoHED2Yn5sjIjQj8HqZgPXefOtNGQTSVnn1/
	 tCw6oSkV4brRjyiet/DaQPh5yvT6ke8y0avvV3eov3sqKVLMb3fJPge9Rma2gtuAoB
	 ixd6KhPY4PogSNy3jjkbrmQNY1OMNBNPuzgyHljkt+H7mRJVq1JJA8ietmlllGu3ES
	 sRMpixq5h0iCA==
Date: Sat, 09 Mar 2024 12:55:35 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: sync: add `ArcBorrow::from_raw`
Message-ID: <e09ed8fc-d305-4740-8c6e-7308a634b822@proton.me>
In-Reply-To: <20240228-arc-for-list-v2-1-ae93201426b4@google.com>
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com> <20240228-arc-for-list-v2-1-ae93201426b4@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/28/24 14:00, Alice Ryhl wrote:
> Allows access to a value in an `Arc` that is currently held as a raw
> pointer due to use of `Arc::into_raw`, without destroying or otherwise
> consuming that raw pointer.
>=20
> This is a dependency of the linked list that Rust Binder uses. The
> linked list uses this method when iterating over the linked list.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/kernel/sync/arc.rs | 76 +++++++++++++++++++++++++++++++++++++-----=
-------
>   1 file changed, 58 insertions(+), 18 deletions(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 7d4c4bf58388..53addb8876c2 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -137,6 +137,39 @@ struct ArcInner<T: ?Sized> {
>       data: T,
>   }
>=20
> +impl<T: ?Sized> ArcInner<T> {
> +    /// Converts a pointer to the contents of an [`Arc`] into a pointer =
to the [`ArcInner`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`Arc::into_=
raw`], and the `Arc` must
> +    /// not yet have been destroyed.
> +    unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
> +        let refcount_layout =3D Layout::new::<bindings::refcount_t>();
> +        // SAFETY: The caller guarantees that the pointer is valid.
> +        let val_layout =3D Layout::for_value(unsafe { &*ptr });
> +        // SAFETY: We're computing the layout of a real struct that exis=
ted when compiling this
> +        // binary, so its layout is not so large that it can trigger ari=
thmetic overflow.
> +        let val_offset =3D unsafe { refcount_layout.extend(val_layout).u=
nwrap_unchecked().1 };
> +
> +        // Pointer casts leave the metadata unchanged. This is okay beca=
use the metadata of `T` and
> +        // `ArcInner<T>` is the same since `ArcInner` is a struct with `=
T` as its last field.
> +        //
> +        // This is documented at:
> +        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> +        let ptr =3D ptr as *const ArcInner<T>;
> +
> +        // SAFETY: The pointer is in-bounds of an allocation both before=
 and after offsetting the
> +        // pointer, since it originates from a previous call to `Arc::in=
to_raw` on an `Arc` that is
> +        // still valid.
> +        let ptr =3D unsafe { ptr.byte_sub(val_offset) };
> +
> +        // SAFETY: The pointer can't be null since you can't have an `Ar=
cInner<T>` value at the null
> +        // address.
> +        unsafe { NonNull::new_unchecked(ptr.cast_mut()) }
> +    }
> +}
> +
>   // This is to allow [`Arc`] (and variants) to be used as the type of `s=
elf`.
>   impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
>=20
> @@ -232,27 +265,13 @@ pub fn into_raw(self) -> *const T {
>       /// `ptr` must have been returned by a previous call to [`Arc::into=
_raw`]. Additionally, it
>       /// must not be called more than once for each previous call to [`A=
rc::into_raw`].
>       pub unsafe fn from_raw(ptr: *const T) -> Self {
> -        let refcount_layout =3D Layout::new::<bindings::refcount_t>();
> -        // SAFETY: The caller guarantees that the pointer is valid.
> -        let val_layout =3D Layout::for_value(unsafe { &*ptr });
> -        // SAFETY: We're computing the layout of a real struct that exis=
ted when compiling this
> -        // binary, so its layout is not so large that it can trigger ari=
thmetic overflow.
> -        let val_offset =3D unsafe { refcount_layout.extend(val_layout).u=
nwrap_unchecked().1 };
> -
> -        // Pointer casts leave the metadata unchanged. This is okay beca=
use the metadata of `T` and
> -        // `ArcInner<T>` is the same since `ArcInner` is a struct with `=
T` as its last field.
> -        //
> -        // This is documented at:
> -        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> -        let ptr =3D ptr as *const ArcInner<T>;
> -
> -        // SAFETY: The pointer is in-bounds of an allocation both before=
 and after offsetting the
> -        // pointer, since it originates from a previous call to `Arc::in=
to_raw` and is still valid.
> -        let ptr =3D unsafe { ptr.byte_sub(val_offset) };
> +        // SAFETY: The caller promises that this pointer originates from=
 a call to `into_raw` on an
> +        // `Arc` that is still valid.
> +        let ptr =3D unsafe { ArcInner::container_of(ptr) };
>=20
>           // SAFETY: By the safety requirements we know that `ptr` came f=
rom `Arc::into_raw`, so the
>           // reference count held then will be owned by the new `Arc` obj=
ect.
> -        unsafe { Self::from_inner(NonNull::new_unchecked(ptr.cast_mut())=
) }
> +        unsafe { Self::from_inner(ptr) }
>       }
>=20
>       /// Returns an [`ArcBorrow`] from the given [`Arc`].
> @@ -453,6 +472,27 @@ unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
>               _p: PhantomData,
>           }
>       }
> +
> +    /// Creates an [`ArcBorrow`] to an [`Arc`] that has previously been =
deconstructed with
> +    /// [`Arc::into_raw`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// * The provided pointer must originate from a call to [`Arc::into=
_raw`].
> +    /// * For the duration of the lifetime annotated on this `ArcBorrow`=
, the reference count must
> +    ///   not hit zero.
> +    /// * For the duration of the lifetime annotated on this `ArcBorrow`=
, there must not be a
> +    ///   [`UniqueArc`] reference to this value.

I am a bit confused, this feels to me like it should be guaranteed by
`UniqueArc` and not by this function. Currently there is not even a way
of getting a `*const T` from a `UniqueArc`.
So I think we can remove this requirement and instead have the
requirement for creating `UniqueArc` that not only the refcount is
exactly 1, but also that no `ArcBorrow` exists.

--=20
Cheers,
Benno

> +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> +        // SAFETY: The caller promises that this pointer originates from=
 a call to `into_raw` on an
> +        // `Arc` that is still valid.
> +        let ptr =3D unsafe { ArcInner::container_of(ptr) };
> +
> +        // SAFETY: The caller promises that the value remains valid sinc=
e the reference count must
> +        // not hit zero, and no mutable reference will be created since =
that would involve a
> +        // `UniqueArc`.
> +        unsafe { Self::new(ptr) }
> +    }
>   }
>=20
>   impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
>=20
> --
> 2.44.0.rc1.240.g4c46232300-goog
>=20


