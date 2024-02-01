Return-Path: <linux-kernel+bounces-47641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2267845094
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281361F25439
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F73C067;
	Thu,  1 Feb 2024 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="OMrGJSN4"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48D3CF4E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706763848; cv=none; b=rpZFXrgq48yRPlJ8uWy/wbdtSHd/9IvwDDx23jTZC42x5Op3uEWjyKlmn5mW6s/1hV2GBSzInqTh6nSvGsQerB5WOLeQJ2Na+61Eaqa33rTLs2UJsOxP6PMokfXoDA3eV+PXTmmE/oLS293ReTvNYVxnU5J5jwixRJhXy7FwVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706763848; c=relaxed/simple;
	bh=ca3ZQXP1dL7eczqFKqszekfUTYSiz0egHoKp0V5UWhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBY3vFXsPcsGnyTVekctmIZMWtMBRBY47XMaLO+2QyyGr882Kb8mTbN4Hrh6GyVncq0VcSAhx0yabc9ZHVjtP2BKac+eEgxMEdbBPWg3B1IPo6Nt9GTc9PYLrmuA65/TL0mT/tUBShtbGAIVuEIravUd1b5hgmtlhyXOXrDsKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=OMrGJSN4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60406dba03cso6345747b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706763845; x=1707368645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIVlKOR+0dK11siwWLke6mXGwWm4TuJ6szHx+WxrPIU=;
        b=OMrGJSN4+Cb4zSHCNFl4bn0sT9wsSZl16aTZxa0dUXPoacuv3xvQF2zTyzhHG/M2N8
         Rwn4KomNF0OxPoVhpnK4ljSEtj+ZtYE7lqTsmbMCWzNzUS3Iliuq7HIUJdBbuBf3pJNT
         rPFqVm19Jh+Tyr/RChKYIWUWMFpizP87tb38oubnvl+qM+eqt7r6+h6bcISqsHCmCHaQ
         uUwDpet+dOF8ep1fH+JjfW2MQGnOxt72nKmHFjAsDE9ubdRqgafMSO74cl+u4IQh8rb5
         66GkcGPj6Drl4A907VJVHE0a6VhgS/RdLg2NW/WoyvvtrjLU9k2rWqcXLMcwb/4bibvp
         xJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706763845; x=1707368645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIVlKOR+0dK11siwWLke6mXGwWm4TuJ6szHx+WxrPIU=;
        b=hX7LVZtfOtqGTf4ClJqLR9pBOqrIZUof3uHxdaE5M9MqCJXcrIRHfuWIfYPnUi2fko
         s0me1lw1MSLb7NY+RtMn3H9jZ20iqiPTe1CsJOyVf4O99vXafQLlEfPhQMX8t0EfbO56
         exAcH2kr7PverLXQVR/15Fh52m4Cwu8SS+6BwS0Vqwx94hfkkMGnVo2zJ8hoOKm7Jcyf
         lbZ6V87oNuV8tJa+UQqIS2A/+MvziWMK9dabwByhkc4NXsoinJDUdjlRSsZqxTB3k54O
         a4Mo1lfk7dsVyGUo68cmNlZKRKTaM+kfau2Ukn0WUsW42Sb9pXm4+nNZW+K/gx1rkpKv
         Kzew==
X-Gm-Message-State: AOJu0YxMRHQQlGrn9e7wSeIaQNMtZeCTX00weosTOOH3Rw2e2vcgfhHc
	idRDXbUhx2oKG4/ViNxZgS8SSZMwWyLYnU7VyZmlJssYm8gJ6YBBNjUU0rGJBWOCwW9ZxWHB06c
	lPHevbO7vi7ZfEWf87DJ/pRHOAqOOH+Q4fsJ6eg==
X-Google-Smtp-Source: AGHT+IFBz1YTkrf/qhzCgZIqKfossW9Ek9i6uJcsPLXTqKzNstEFU4dmZO6iv8Nqu4nRoYfb+44TKDCWKyYKEI3eeIo=
X-Received: by 2002:a05:690c:82d:b0:5f0:e95f:5ad8 with SMTP id
 by13-20020a05690c082d00b005f0e95f5ad8mr1327057ywb.19.1706763844706; Wed, 31
 Jan 2024 21:04:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com> <20240124-alice-mm-v1-2-d1abcec83c44@google.com>
In-Reply-To: <20240124-alice-mm-v1-2-d1abcec83c44@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 1 Feb 2024 00:03:53 -0500
Message-ID: <CALNs47ubBgWr25AEKtgYPyzPB1tfcyCAz8-TbYmmqMpY98Fu_A@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: add typed accessors for userspace pointers
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

On Wed, Jan 24, 2024 at 6:21=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:

I see this patch answers some of my naming questions from 1/3, sorry
for not reading all the way through.

> diff --git a/rust/kernel/user_ptr.rs b/rust/kernel/user_ptr.rs
> index 00aa26aa6a83..daa46abe5525 100644
> --- a/rust/kernel/user_ptr.rs
> +++ b/rust/kernel/user_ptr.rs
> @@ -11,6 +11,7 @@
>  use crate::{bindings, error::code::*, error::Result};
>  use alloc::vec::Vec;
>  use core::ffi::{c_ulong, c_void};
> +use core::mem::{size_of, MaybeUninit};
>
>  /// The maximum length of a operation using `copy_[from|to]_user`.
>  ///
> @@ -151,6 +152,36 @@ pub unsafe fn read_raw(&mut self, out: *mut u8, len:=
 usize) -> Result {
>          Ok(())
>      }
>
> +    /// Reads a value of the specified type.
> +    ///
> +    /// Fails with `EFAULT` if the read encounters a page fault.
> +    pub fn read<T: ReadableFromBytes>(&mut self) -> Result<T> {

I think that `T: Copy` is required here, or for Copy to be a
supertrait of ReadableBytes, since the data in the buffer is being
duplicated from a reference.

Send is probably also a reasonable bound to have .

> +        if size_of::<T>() > self.1 || size_of::<T>() > MAX_USER_OP_LEN {
> +            return Err(EFAULT);
> +        }
> +        let mut out: MaybeUninit<T> =3D MaybeUninit::uninit();
> +        // SAFETY: The local variable `out` is valid for writing `size_o=
f::<T>()` bytes.
> +        let res =3D unsafe {
> +            bindings::copy_from_user_unsafe_skip_check_object_size(
> +                out.as_mut_ptr().cast::<c_void>(),
> +                self.0,
> +                size_of::<T>() as c_ulong,

As with the other patch, I think it would be more clear to use
`c_ulong::try_from(...)` rather than comparing against
`MAX_USER_OP_LEN ` and later casting. Possibly just in a helper
function.

> +            )
> +        };
> +        if res !=3D 0 {
> +            return Err(EFAULT);
> +        }
> +        // Since this is not a pointer to a valid object in our program,
> +        // we cannot use `add`, which has C-style rules for defined
> +        // behavior.
> +        self.0 =3D self.0.wrapping_add(size_of::<T>());

There are now methods `wrapping_byte_add` (since 1.75). Doesn't make
much of a difference since the pointer is c_void anyway, but it does
make the unit more clear.

> +        self.1 -=3D size_of::<T>();
> +
> +        // SAFETY: The read above has initialized all bytes in `out`, an=
d since
> +        // `T` implements `ReadableFromBytes`, any bit-pattern is a vali=
d value
> +        // for this type.
> +        Ok(unsafe { out.assume_init() })
> +    }
> +
>      /// Reads all remaining data in the buffer into a vector.
>      ///
>      /// Fails with `EFAULT` if the read encounters a page fault.
> @@ -219,4 +250,98 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result=
 {
>          // `len`, so the pointer is valid for reading `len` bytes.
>          unsafe { self.write_raw(ptr, len) }
>      }
> +
> +    /// Writes the provided Rust value to this userspace pointer.
> +    ///
> +    /// Fails with `EFAULT` if the write encounters a page fault.
> +    pub fn write<T: WritableToBytes>(&mut self, value: &T) -> Result {

Send + Copy are also needed here, or supertraits of WritableToBytes.

> +        if size_of::<T>() > self.1 || size_of::<T>() > MAX_USER_OP_LEN {
> +            return Err(EFAULT);
> +        }
> +        // SAFETY: The reference points to a value of type `T`, so it is=
 valid
> +        // for reading `size_of::<T>()` bytes.
> +        let res =3D unsafe {
> +            bindings::copy_to_user_unsafe_skip_check_object_size(
> +                self.0,
> +                (value as *const T).cast::<c_void>(),
> +                size_of::<T>() as c_ulong,
> +            )
> +        };
> +        if res !=3D 0 {
> +            return Err(EFAULT);
> +        }
> +        // Since this is not a pointer to a valid object in our program,
> +        // we cannot use `add`, which has C-style rules for defined
> +        // behavior.
> +        self.0 =3D self.0.wrapping_add(size_of::<T>());
> +        self.1 -=3D size_of::<T>();
> +        Ok(())
> +    }
>  }
> +
> +/// Specifies that a type is safely readable from bytes.
> +///
> +/// Not all types are valid for all values. For example, a `bool` must b=
e either
> +/// zero or one, so reading arbitrary bytes into something that contains=
 a
> +/// `bool` is not okay.
> +///
> +/// It's okay for the type to have padding, as initializing those bytes =
has no
> +/// effect.
> +///
> +/// # Safety
> +///
> +/// All bit-patterns must be valid for this type.
> +pub unsafe trait ReadableFromBytes {}
> +
> +// SAFETY: All bit patterns are acceptable values of the types below.
> +unsafe impl ReadableFromBytes for u8 {}
> +unsafe impl ReadableFromBytes for u16 {}
> +unsafe impl ReadableFromBytes for u32 {}
> +unsafe impl ReadableFromBytes for u64 {}
> +unsafe impl ReadableFromBytes for usize {}
> +unsafe impl ReadableFromBytes for i8 {}
> +unsafe impl ReadableFromBytes for i16 {}
> +unsafe impl ReadableFromBytes for i32 {}
> +unsafe impl ReadableFromBytes for i64 {}
> +unsafe impl ReadableFromBytes for isize {}
> +// SAFETY: If all bit patterns are acceptable for individual values in a=
n array,
> +// then all bit patterns are also acceptable for arrays of that type.
> +unsafe impl<T: ReadableFromBytes> ReadableFromBytes for [T] {}
> +unsafe impl<T: ReadableFromBytes, const N: usize> ReadableFromBytes for =
[T; N] {}
> +
> +/// Specifies that a type is safely writable to bytes.
> +///
> +/// If a struct implements this trait, then it is okay to copy it byte-f=
or-byte
> +/// to userspace. This means that it should not have any padding, as pad=
ding
> +/// bytes are uninitialized. Reading uninitialized memory is not just un=
defined
> +/// behavior, it may even lead to leaking sensitive information on the s=
tack to
> +/// userspace.
> +///
> +/// The struct should also not hold kernel pointers, as kernel pointer a=
ddresses
> +/// are also considered sensitive. However, leaking kernel pointers is n=
ot
> +/// considered undefined behavior by Rust, so this is a correctness requ=
irement,
> +/// but not a safety requirement.
> +///
> +/// # Safety
> +///
> +/// Values of this type may not contain any uninitialized bytes.
> +pub unsafe trait WritableToBytes {}
> +
> +// SAFETY: Instances of the following types have no uninitialized portio=
ns.
> +unsafe impl WritableToBytes for u8 {}
> +unsafe impl WritableToBytes for u16 {}
> +unsafe impl WritableToBytes for u32 {}
> +unsafe impl WritableToBytes for u64 {}
> +unsafe impl WritableToBytes for usize {}
> +unsafe impl WritableToBytes for i8 {}
> +unsafe impl WritableToBytes for i16 {}
> +unsafe impl WritableToBytes for i32 {}
> +unsafe impl WritableToBytes for i64 {}
> +unsafe impl WritableToBytes for isize {}
> +unsafe impl WritableToBytes for bool {}
> +unsafe impl WritableToBytes for char {}
> +unsafe impl WritableToBytes for str {}
> +// SAFETY: If individual values in an array have no uninitialized portio=
ns, then
> +// the the array itself does not have any uninitialized portions either.
> +unsafe impl<T: WritableToBytes> WritableToBytes for [T] {}
> +unsafe impl<T: WritableToBytes, const N: usize> WritableToBytes for [T; =
N] {}
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>
>

These traits are probably usable in a lot of other places (e.g.
packets, GPU), so could you put them in a separate module?

The patterns here are pretty similar to what the bytemuck crate does
[1]. Since that crate is well established and open licensed, I think
it makes sense to keep their naming or possibly even vendor a portion
in.

In particular, this would likely include the traits:

- AnyBitPattern, which is roughly ReadableFromBytes here
- NoUninit, which is roughly WritableToBytes here
- Optionally Pod (plain old data), a supertrait of both AnyBitPattern
and NoUninit just used to simplify trait implementation (impl Pod and
you get the other two).

And the functions:

- from_bytes to turn &[u8] into &T for use in `read`. Needs `T: Copy`
to return an owned value, as noted above.
- bytes_of to turn &T into &[u8], for use in `write`

The derive macros would also be nice to have down the line, though
bytemuck's unfortunately relies on syn.

- Trevor

[1]: https://docs.rs/bytemuck/latest/bytemuck/

