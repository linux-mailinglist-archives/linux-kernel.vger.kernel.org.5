Return-Path: <linux-kernel+bounces-72688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B30285B745
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3231C2470F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0775F576;
	Tue, 20 Feb 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="2rHicCFt"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261B5F56F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421115; cv=none; b=aevRc14oCV8mTPxyvS7VZXjK/8TTxmoDRdUTOYcmpR9vHwYhwEFqf0thCCkE+FTO8DPESTRaMFC3jm9eo2YES1o22OUQA7XLkYancRks8liSxC67iFNsE+GJlnYWxXKEXa+cSYvYBzk+mrKUayvpS0Yfszp3fDKAoji94ita3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421115; c=relaxed/simple;
	bh=iXJSQdjCNbAzNTAvMY4ePsKzKY6yOP+dZp93tuToy2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kg26RoMBtuOcPKXgC9YipFprIM7Zf1B71SjSaRR6DHU/umgG95eYmecgESn5JrId+4M21NUOcJGQL6zc14miqld/XILr3UYbgXIpFHK0h+a4UzpDvHM2zOWA4EF0zB/QnF5WFZGs2mvnv9zxbG8SeBrpXdebTdpuOrQ0SpQG+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2rHicCFt; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so3298006241.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421112; x=1709025912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxinpuFSBaFvXX5xQuAmA+vkm04C27dYdOWo8WKCrM4=;
        b=2rHicCFtfJPV6o6/7MUHRQa2JqzuufE5QgCenp2bIBo+38q85K1/Z3kwCFl39Txz1Y
         b0BkWyTHMaDx5S+Rz7UGRbzui5fzS17RceYMyKAjprNjsCaGv/lIUUmiIz+KiIx1VAK9
         YetvpBqLcEWLsoZ1YM/b+DNWtsSpQucQg3SWKtwAvrt37rF/JtjXkoiWvFUjLoGSvA0J
         jESrwICkAjzl/l2yLj5ikHjzVilt0SUcoernd3xh2smR9IaoZzSwb3RfHiTPM19HiFYf
         OyAZ0geXJt+P76L+35/RhSi8ZhwPLntusq0zpiLZtK3ACZTTH5sZ7kbQtZ3l2DdipLHp
         CsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421112; x=1709025912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxinpuFSBaFvXX5xQuAmA+vkm04C27dYdOWo8WKCrM4=;
        b=I/pvDJCE4VlXHhCCNXdYDX9zMZ7BFIddHXUwdLrFK8Y63XYqBy/zfPm5ZBhXqqVwqO
         KZfZ2EmuxYb0Kn9n3HmfHWQUrAHJhWF66QCXAOQkVBtJr6criTs5Q+mDff/MiGZG7w28
         xj7G+Xl8bj5aZju/mZOz2zRGLBFE9Eck9RI+f2Va+zmp2DXOW1GeuxVLX+dlPX/Em55h
         ASR7SvaPZfhoVn4GEGBd4OkWf9/ZoLsAgf8LuWcf9ZpCuopLegHSl9zNGcEc1vBFfAxL
         E7ij4b4TaiMS+gAuF6+AGkGqJ5u18wABBjvWUlZqI1LBff0T3nugCyTC5n9fSyuq7FYw
         XAKA==
X-Forwarded-Encrypted: i=1; AJvYcCU1PqOB/r4H1MiEDKgvyWB5IT28e+jU0ytnHRjEmCYyxuicQCKTqY6vE+oQUqFRxK8zYMZ/2L68EfS8dJxdQzLOVV9qjo2FgqH8xpG9
X-Gm-Message-State: AOJu0YzCYSKdCIgK0TxqlCOhgBVhVquFSenUgy3WQ+0WdlqFhkfI2jI1
	/A1Ue11XFPmfA26egV7A3nolv53kvZtqGhlEF0x3/m+1wPVdzmqSZl0WsCiYY0SAuDHiWeqUHMZ
	N70To2AJQCVGgjOmJ0Fo+nD8tM9I9vPH7w9e3
X-Google-Smtp-Source: AGHT+IG0tVK9XPTSpubD6g26R2W1vq1GU6qjIvbNaR5mf3rPT7kTHE11B9Du7+MXw4vja7rDKJIOpizKNl5iYY0UEz4=
X-Received: by 2002:a67:f9c9:0:b0:470:492d:672e with SMTP id
 c9-20020a67f9c9000000b00470492d672emr5455750vsq.9.1708421112024; Tue, 20 Feb
 2024 01:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-arc-for-list-v1-0-d98cd92c760b@google.com>
 <20240219-arc-for-list-v1-1-d98cd92c760b@google.com> <ZdQ6RRYtvazV7WPR@boqun-archlinux>
In-Reply-To: <ZdQ6RRYtvazV7WPR@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 20 Feb 2024 10:25:00 +0100
Message-ID: <CAH5fLghxArdT-Ah=0JWvo7NfSELLDJ7+FmMOr=TQ+4gKewPGfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: sync: add `ArcBorrow::from_raw`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:36=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Feb 19, 2024 at 02:54:11PM +0000, Alice Ryhl wrote:
> > Allows access to a value in an `Arc` that is currently held as a raw
> > pointer due to use of `Arc::into_raw`, without destroying or otherwise
> > consuming that raw pointer.
> >
> > This is a dependency of the linked list that Rust Binder uses. The
> > linked list uses this method when iterating over the linked list.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/sync/arc.rs | 72 ++++++++++++++++++++++++++++++++++++-----=
--------
> >  1 file changed, 54 insertions(+), 18 deletions(-)
> >
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index 7d4c4bf58388..a5314df409e7 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -232,27 +232,13 @@ pub fn into_raw(self) -> *const T {
> >      /// `ptr` must have been returned by a previous call to [`Arc::int=
o_raw`]. Additionally, it
> >      /// must not be called more than once for each previous call to [`=
Arc::into_raw`].
> >      pub unsafe fn from_raw(ptr: *const T) -> Self {
> > -        let refcount_layout =3D Layout::new::<bindings::refcount_t>();
> > -        // SAFETY: The caller guarantees that the pointer is valid.
> > -        let val_layout =3D Layout::for_value(unsafe { &*ptr });
> > -        // SAFETY: We're computing the layout of a real struct that ex=
isted when compiling this
> > -        // binary, so its layout is not so large that it can trigger a=
rithmetic overflow.
> > -        let val_offset =3D unsafe { refcount_layout.extend(val_layout)=
unwrap_unchecked().1 };
> > -
> > -        // Pointer casts leave the metadata unchanged. This is okay be=
cause the metadata of `T` and
> > -        // `ArcInner<T>` is the same since `ArcInner` is a struct with=
 `T` as its last field.
> > -        //
> > -        // This is documented at:
> > -        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> > -        let ptr =3D ptr as *const ArcInner<T>;
> > -
> > -        // SAFETY: The pointer is in-bounds of an allocation both befo=
re and after offsetting the
> > -        // pointer, since it originates from a previous call to `Arc::=
into_raw` and is still valid.
> > -        let ptr =3D unsafe { ptr.byte_sub(val_offset) };
> > +        // SAFETY: The pointer returned by `into_raw` points at the `d=
ata` field of an
> > +        // `ArcInner<T>`, as promised by the caller.
> > +        let ptr =3D unsafe { raw_to_inner_ptr(ptr) };
> >
> >          // SAFETY: By the safety requirements we know that `ptr` came =
from `Arc::into_raw`, so the
> >          // reference count held then will be owned by the new `Arc` ob=
ject.
> > -        unsafe { Self::from_inner(NonNull::new_unchecked(ptr.cast_mut(=
))) }
> > +        unsafe { Self::from_inner(ptr) }
> >      }
> >
> >      /// Returns an [`ArcBorrow`] from the given [`Arc`].
> > @@ -273,6 +259,35 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
> >      }
> >  }
> >
> > +/// Converts a pointer to the contents of an [`Arc`] into a pointer to=
 the [`ArcInner`].
> > +///
> > +/// # Safety
> > +///
> > +/// The provided pointer must point the `data` field of an `ArcInner<T=
>` value.
> > +unsafe fn raw_to_inner_ptr<T: ?Sized>(ptr: *const T) -> NonNull<ArcInn=
er<T>> {
>
> Nit: put this into an `impl<T:?Sized> ArcInner<T>` block maybe?
>
> > +    let refcount_layout =3D Layout::new::<bindings::refcount_t>();
> > +    // SAFETY: The caller guarantees that the pointer is valid.
> > +    let val_layout =3D Layout::for_value(unsafe { &*ptr });
> > +    // SAFETY: We're computing the layout of a real struct that existe=
d when compiling this
> > +    // binary, so its layout is not so large that it can trigger arith=
metic overflow.
> > +    let val_offset =3D unsafe { refcount_layout.extend(val_layout).unw=
rap_unchecked().1 };
> > +
> > +    // Pointer casts leave the metadata unchanged. This is okay becaus=
e the metadata of `T` and
> > +    // `ArcInner<T>` is the same since `ArcInner` is a struct with `T`=
 as its last field.
> > +    //
> > +    // This is documented at:
> > +    // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> > +    let ptr =3D ptr as *const ArcInner<T>;
> > +
> > +    // SAFETY: The pointer is in-bounds of an allocation both before a=
nd after offsetting the
> > +    // pointer, since it originates from a previous call to `Arc::into=
_raw` and is still valid.
>
> "since it originate from a previous call to `Arc::into_raw`" is the
> safety requirement of `Arc::from_raw`, since the safety requirement of
> `raw_to_inner_ptr` is different, so I think we should say "since the
> function safety requirement guarantees `ptr` points to `data` field,
> which is exactly `val_offset` away from the beginning of `ArcInner<T>`".
> Thoughts?
>
> BTW, in fat pointer cases, by "must point the `data` field of an
> `ArcInner<T>` value", it means both the address and the metadata should
> be the same as the original object in `ArcInner<T>`, right? In other
> words, the following code should not be safe, i.e. the
> raw_to_inner_ptr() safety requirement is not satisfied.
>
>         let x: Arc<[u8]> // assume x.len() =3D=3D 4
>
>         let y =3D &(x[0..1]) as *const [u8] // y has the same address of
>                                           // the `data` field of `x`.
>
>         let inner =3D unsafe { raw_to_inner_ptr(y) };
>         // ^^^ the safety requirement is not satisfied???
>
> This may not be important since the users of `raw_to_inner_ptr` all have
> stronger safey guarantees ("`ptr` must come from `Arc::into_raw()`"),
> and `raw_to_inner_ptr` is not a pub function, but I just wonder whether
> we need to improve the current safety requirements, or "point" means
> both address and metadata for fat pointers?

I mean, really, the same problem arises for Sized pointers where the
pointer points at the first field of a struct.

We may have to take inspiration from the std Arc::from_raw. It says
that the pointee must have the same size and alignment as what was
used when you called Arc::into_raw, and then it further says that if
the pointer type is not exactly the same, then you are effectively
performing a transmute.

Alice

