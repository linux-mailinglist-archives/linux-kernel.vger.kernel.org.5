Return-Path: <linux-kernel+bounces-58135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 061CB84E1CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A322BB210A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44537B3D0;
	Thu,  8 Feb 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0a5CORa"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3B79DA8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398058; cv=none; b=meHuY3MPChpIweHKDcardGfilWl5xbdW12j6Ow9KJhZRmEBLG2hSXt96gZZWUf/Y004O19vHz+ryHW3U0DKB1BkgkQ7psuQScwLTD36mun2KIUeggMIX2V+VFBTlRY3rOVHDLboGkkKhRidBlGx4Tvj1JbcT1qv5ceRxurRu5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398058; c=relaxed/simple;
	bh=aD+Cw2+HmYwuNjGEKwdtPj0qQ/W5mX3RahbDYj/KXk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPB+uLuhXk7mDZi+uiJCxxaFNl9eBTYyid1pr1IDkQZ/gzcmw65MjsiRiNjl1PyiOXryD8osx2yX7NWvQvXKqhCvJm89vRF9q9TYHvUZvKbcQVcYYg27i1BVDy/xkFul4Lrbd+7E17SguxMNJIyrr8ybrrA8irtwDrtHTfKTwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0a5CORa; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-46d29ed4574so484241137.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707398056; x=1708002856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4Y28H6BgiSHtemuYz9Q6cvGUwcKGIFMyv2Vo+B56G0=;
        b=x0a5CORaI3H8OMWo68NAhEJH+qX+9xRR2827jV/hH6NY4u8Y9OuNVFC3DNJdKcCy4L
         jYJrnNdIisFdePfqJLWNCCRvbOYgukCi8hO/5nwK1I43jbauu7G7Az5c19A3e4Tz8OdK
         chKMPAUQufXATu6NiVms3yvyuA13KwbWfjNhEmJ2nsJBO6npUCwn/mbCteQHWs2R8Mwv
         1rYN+UqOgz2k0XMyQzjyZPnD5Cp2Fw0xH1mLsAiTQzM+dMR0f+hYc8XkDqO6S1nI+69B
         Byu49EMmXiDG16aYrutvLghoyjw2pjMTSk6gTSlRx3Tk8rdrj/IEpnfcRPccsmjHv9in
         7PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707398056; x=1708002856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4Y28H6BgiSHtemuYz9Q6cvGUwcKGIFMyv2Vo+B56G0=;
        b=J4bGaexsX/E5tOXW8K53xkGgwRKKF7aNJt1sCbIEch5Q/9IJ0pvZ1cRXdA1Lwa3okG
         /9XnRJb0mci5z8pXKL8CX/N6g+rCNEpI4vKKp22C1NW7watneJM53lCXhyng68IEJhjY
         I4JU0M2eMajbz4YYevn+PdhbusIn5q9+XIBXrYIUdiIy+Gp2XnCso54NowAQVR9nabgX
         tRiteHc7wtDUw0yvmiWwSkaOo8qgMBlrdXXRKn/Vqb6zKVpeOdqXLcHhqzWmeip4iYG/
         LpjSUUbDQg+jrdahOzeUDVKqsbpvDXzWy3bD7isw21LrwoPAfT9XQn8pPFOVP3EVhcZF
         omVw==
X-Forwarded-Encrypted: i=1; AJvYcCXuQvna17CKn9Or6E18O7zych/yTo7v/7gKmGbqhfxAAGrftzeG5PV9auW5Sr0MMxCboJL0fuFl/NwxoY9nq7nWfZHlgWDa95xTUuK9
X-Gm-Message-State: AOJu0Yxm/xbdGjZfjIuhkC6IhoFvrFd04n0bsSJqfaUblE5oG8pINvc4
	9A5nS0rh7j1MAH0Y0Rh5ZV1ENatmh8nJ0yrowVameAeoYXW8sLlc/BjTJQZRedcC52dXwbWS4hN
	i5cDVyv17pcnMI9GJKmCMsTj2U/v4MXkpEYGg
X-Google-Smtp-Source: AGHT+IFAH2AcakGpseEeHbdkDCpG2lxDefL5T1Ou+BT2/kUYqqhr3VPMB7tRMumatFtOHoQQ4hDQ0sn5XhVLJ3wPWPQ=
X-Received: by 2002:a05:6102:2a7a:b0:46d:49a5:e9fd with SMTP id
 hp26-20020a0561022a7a00b0046d49a5e9fdmr5975810vsb.24.1707398055828; Thu, 08
 Feb 2024 05:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-2-d1abcec83c44@google.com> <CALNs47ubBgWr25AEKtgYPyzPB1tfcyCAz8-TbYmmqMpY98Fu_A@mail.gmail.com>
In-Reply-To: <CALNs47ubBgWr25AEKtgYPyzPB1tfcyCAz8-TbYmmqMpY98Fu_A@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 14:14:04 +0100
Message-ID: <CAH5fLggebX-dgYXtf9mbScv02c3gpq1qCJSesZ8qpXsceBXDOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: add typed accessors for userspace pointers
To: Trevor Gross <tmgross@umich.edu>
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

On Thu, Feb 1, 2024 at 6:04=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wro=
te:
>
> On Wed, Jan 24, 2024 at 6:21=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > +    /// Reads a value of the specified type.
> > +    ///
> > +    /// Fails with `EFAULT` if the read encounters a page fault.
> > +    pub fn read<T: ReadableFromBytes>(&mut self) -> Result<T> {
>
> I think that `T: Copy` is required here, or for Copy to be a
> supertrait of ReadableBytes, since the data in the buffer is being
> duplicated from a reference.
>
> Send is probably also a reasonable bound to have .

We're not moving a value of type `T`. We're creating a new value of
type `T` from a byte array. The trait says that we can do that, so I
think that is enough here.

Besides, we'll often want to use this for wrappers around bindgen
types. If we add a Copy bound, then we need to get bindgen to generate
a #[derive(Copy)] for them, which I don't think it does right now.

> > +        // SAFETY: The local variable `out` is valid for writing `size=
_of::<T>()` bytes.
> > +        let res =3D unsafe {
> > +            bindings::copy_from_user_unsafe_skip_check_object_size(
> > +                out.as_mut_ptr().cast::<c_void>(),
> > +                self.0,
> > +                size_of::<T>() as c_ulong,
>
> As with the other patch, I think it would be more clear to use
> `c_ulong::try_from(...)` rather than comparing against
> `MAX_USER_OP_LEN ` and later casting. Possibly just in a helper
> function.

Done.

> > +        // Since this is not a pointer to a valid object in our progra=
m,
> > +        // we cannot use `add`, which has C-style rules for defined
> > +        // behavior.
> > +        self.0 =3D self.0.wrapping_add(size_of::<T>());
>
> There are now methods `wrapping_byte_add` (since 1.75). Doesn't make
> much of a difference since the pointer is c_void anyway, but it does
> make the unit more clear.

Sure, I can use those methods.

> > +    /// Writes the provided Rust value to this userspace pointer.
> > +    ///
> > +    /// Fails with `EFAULT` if the write encounters a page fault.
> > +    pub fn write<T: WritableToBytes>(&mut self, value: &T) -> Result {
>
> Send + Copy are also needed here, or supertraits of WritableToBytes.

I also disagree here. We're not moving a value of type T. We're
creating a byte array from a value of type T, and the trait says that
we can do that.

> > +/// Specifies that a type is safely readable from bytes.
> > +///
> > +/// Not all types are valid for all values. For example, a `bool` must=
 be either
> > +/// zero or one, so reading arbitrary bytes into something that contai=
ns a
> > +/// `bool` is not okay.
> > +///
> > +/// It's okay for the type to have padding, as initializing those byte=
s has no
> > +/// effect.
> > +///
> > +/// # Safety
> > +///
> > +/// All bit-patterns must be valid for this type.
> > +pub unsafe trait ReadableFromBytes {}
> > +
> > +// SAFETY: All bit patterns are acceptable values of the types below.
> > +unsafe impl ReadableFromBytes for u8 {}
> > +unsafe impl ReadableFromBytes for u16 {}
> > +unsafe impl ReadableFromBytes for u32 {}
> > +unsafe impl ReadableFromBytes for u64 {}
> > +unsafe impl ReadableFromBytes for usize {}
> > +unsafe impl ReadableFromBytes for i8 {}
> > +unsafe impl ReadableFromBytes for i16 {}
> > +unsafe impl ReadableFromBytes for i32 {}
> > +unsafe impl ReadableFromBytes for i64 {}
> > +unsafe impl ReadableFromBytes for isize {}
> > +// SAFETY: If all bit patterns are acceptable for individual values in=
 an array,
> > +// then all bit patterns are also acceptable for arrays of that type.
> > +unsafe impl<T: ReadableFromBytes> ReadableFromBytes for [T] {}
> > +unsafe impl<T: ReadableFromBytes, const N: usize> ReadableFromBytes fo=
r [T; N] {}
> > +
> > +/// Specifies that a type is safely writable to bytes.
> > +///
> > +/// If a struct implements this trait, then it is okay to copy it byte=
-for-byte
> > +/// to userspace. This means that it should not have any padding, as p=
adding
> > +/// bytes are uninitialized. Reading uninitialized memory is not just =
undefined
> > +/// behavior, it may even lead to leaking sensitive information on the=
 stack to
> > +/// userspace.
> > +///
> > +/// The struct should also not hold kernel pointers, as kernel pointer=
 addresses
> > +/// are also considered sensitive. However, leaking kernel pointers is=
 not
> > +/// considered undefined behavior by Rust, so this is a correctness re=
quirement,
> > +/// but not a safety requirement.
> > +///
> > +/// # Safety
> > +///
> > +/// Values of this type may not contain any uninitialized bytes.
> > +pub unsafe trait WritableToBytes {}
> > +
> > +// SAFETY: Instances of the following types have no uninitialized port=
ions.
> > +unsafe impl WritableToBytes for u8 {}
> > +unsafe impl WritableToBytes for u16 {}
> > +unsafe impl WritableToBytes for u32 {}
> > +unsafe impl WritableToBytes for u64 {}
> > +unsafe impl WritableToBytes for usize {}
> > +unsafe impl WritableToBytes for i8 {}
> > +unsafe impl WritableToBytes for i16 {}
> > +unsafe impl WritableToBytes for i32 {}
> > +unsafe impl WritableToBytes for i64 {}
> > +unsafe impl WritableToBytes for isize {}
> > +unsafe impl WritableToBytes for bool {}
> > +unsafe impl WritableToBytes for char {}
> > +unsafe impl WritableToBytes for str {}
> > +// SAFETY: If individual values in an array have no uninitialized port=
ions, then
> > +// the the array itself does not have any uninitialized portions eithe=
r.
> > +unsafe impl<T: WritableToBytes> WritableToBytes for [T] {}
> > +unsafe impl<T: WritableToBytes, const N: usize> WritableToBytes for [T=
; N] {}
>
> These traits are probably usable in a lot of other places (e.g.
> packets, GPU), so could you put them in a separate module?

I can move them to the types module.

> The patterns here are pretty similar to what the bytemuck crate does
> [1]. Since that crate is well established and open licensed, I think
> it makes sense to keep their naming or possibly even vendor a portion
> in.

Vendoring bytemuck is out of scope for this patchset.

If we *are* going to vendor one of them, I would suggest zerocopy over byte=
muck.

> In particular, this would likely include the traits:
>
> - AnyBitPattern, which is roughly ReadableFromBytes here
> - NoUninit, which is roughly WritableToBytes here
> - Optionally Pod (plain old data), a supertrait of both AnyBitPattern
> and NoUninit just used to simplify trait implementation (impl Pod and
> you get the other two).

I can rename the two traits, but I'm not going to introduce Pod. It's
over engineered for my purposes. Also, I prefer the trait names from
zerocopy. They emphasize that it's really about conversions to/from
byte arrays, and not about moving values around.

Note that WritableToBytes has an extra comment about pointer addresses
that bytemuck/zerocopy doesn't have.

> And the functions:
>
> - from_bytes to turn &[u8] into &T for use in `read`. Needs `T: Copy`
> to return an owned value, as noted above.
> - bytes_of to turn &T into &[u8], for use in `write`
>
> The derive macros would also be nice to have down the line, though
> bytemuck's unfortunately relies on syn.
>
> - Trevor
>
> [1]: https://docs.rs/bytemuck/latest/bytemuck/

