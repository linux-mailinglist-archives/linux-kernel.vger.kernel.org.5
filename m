Return-Path: <linux-kernel+bounces-47600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3373884500A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C61B25F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CBB2B9D0;
	Thu,  1 Feb 2024 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="JVyrAN6x"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2633A1A0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706760392; cv=none; b=GrRRFYp1ahCWPwAJ/uSQvhm8fOsph0mcBV9Mmx3KYd+QzRhxFlCP0qLzyA3ftCFQ+/UdN3dG9QMxxi3WNXwN8scXL458HnOq/51voMR4GzW51Tn+zYtx+XRpplOnI0C/d4JF/yzmyG3Z4SEnu3SvoY4+a8lb6l/oiyUolsDbZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706760392; c=relaxed/simple;
	bh=vr56BrQwSU9M8EOMqSgj8EfajQmDPTfuOvLP/+m3Wdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXX5LcumFyoFHDQ98d7WeX/d6fJYqTjCBHCt0vCyhwHE5Ejyw8Rdg/bcSNzZCEVa1++kAc+a4kHNGd9BidV2lPrkIer/AKKavJU0L9RpWh5oTg9HyddmqqXmYP7CwtgYLD51V4tIlvqd+s94Fdwb2OhB5j1zF0BrJ0piA6CiVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=JVyrAN6x; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60412a23225so5054907b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706760388; x=1707365188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9cS7nVgUKdaXy/fPao/HO1z3bVHBL7mwNKzJyJGoTI=;
        b=JVyrAN6xaOW5NQ9dIIolt82fikJ8R1IYC/ytMzbU41kcqbJHTlSlgN2Hc/y8hauzTA
         iDu+CmWRUBNeLt1eHUBL4G8ShoEt3f5E2U2/+YSqp1rFi5AZpMs7EgHpM9Cer+hNGJZy
         jH84S7d9PrQ7cp6iLp7N6vZ8Fn0Aotsw8+9i94y32i79n0hLblPYzUiEqwio78niwuhC
         EHV4dZTpwJ/IC5wbhCHOuiPYwuXKLyHLqU33UhF4qHvLMNnAcOks+0uzndI+xULoclfX
         INthSIaKx17uy62JzypzleTT2+05xpQEO7lFTbTgvNGmk8eMYRSWQqBx/D1PE3wnh1ye
         pYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706760388; x=1707365188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9cS7nVgUKdaXy/fPao/HO1z3bVHBL7mwNKzJyJGoTI=;
        b=PGChUgphlhNogD6Ot072WLkk+ro+vNukgDDXoxE829ANIvBILxqfaaQFEb4y2jq01W
         Rvk6376QsPIP/e8N2eytnyN7VgwfoR+MaU0x0w4ykcXZOG6MJSMr4RywSKcsBojzCMdH
         USU5sFhdHqxn+wY+dVJWHpU5/YUOhqAgrRxjlsKw6jk+4b7qXrlp/r3SC2QGtmW6+wCl
         gCL9o03L12Jv9LJ022PREgncnhsUapo768mwRl8MlUi3qu/aWpZcjfohYfFfWHxmUsRW
         psf18SkX3dPQeCATRvrOKhChiVXYPu2mq/PNsAQB09S2qd+hRJmBwwrh5yD1JB3CPhM2
         E2Cg==
X-Gm-Message-State: AOJu0YwDDWrW+9LwpPC3YEn+rnDIF+c91Q687KKrm9RNIIJ8tUE6oXS8
	oYmtde8J2CXtJjk9/43yST19NoZDtPrT21Dl+odIyFeY8qYTD05TRU3bh624jVDvkHTHi/VzcrH
	Ke4EsTue8fmK8BX3MXt4jnCjRXmHSSoFAnLus7g==
X-Google-Smtp-Source: AGHT+IGfqAEiO8Q4ie3oM3T9CvkiCmr5jcU9wT9zIy6Qq8snln0yc7tE2UthbmMTAGRW+fDaKPTDB7UfSJLu8wFfjCA=
X-Received: by 2002:a81:ae64:0:b0:603:cb7e:8df with SMTP id
 g36-20020a81ae64000000b00603cb7e08dfmr3812460ywk.0.1706760388236; Wed, 31 Jan
 2024 20:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com> <20240124-alice-mm-v1-1-d1abcec83c44@google.com>
In-Reply-To: <20240124-alice-mm-v1-1-d1abcec83c44@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 31 Jan 2024 23:06:17 -0500
Message-ID: <CALNs47uDaD05oD8TtZoSqUBc4SaRig80u2_1P0qMCXtE3H9_Vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add userspace pointers
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
> --- /dev/null
> +++ b/rust/kernel/user_ptr.rs
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! User pointers.
> +//!
> +//! C header: [`include/linux/uaccess.h`](../../../../include/linux/uacc=
ess.h)
> +
> +// Comparison with MAX_USER_OP_LEN triggers this lint on platforms
> +// where `c_ulong =3D=3D usize`.
> +#![allow(clippy::absurd_extreme_comparisons)]
> +
> +use crate::{bindings, error::code::*, error::Result};
> +use alloc::vec::Vec;
> +use core::ffi::{c_ulong, c_void};
> +
> +/// The maximum length of a operation using `copy_[from|to]_user`.
> +///
> +/// If a usize is not greater than this constant, then casting it to `c_=
ulong`
> +/// is guaranteed to be lossless.
> +const MAX_USER_OP_LEN: usize =3D c_ulong::MAX as usize;
> +
> +/// A pointer to an area in userspace memory, which can be either read-o=
nly or
> +/// read-write.
> +///
> +/// All methods on this struct are safe: invalid pointers return `EFAULT=
`.

Maybe

    ... attempting to read or write invalid pointers will return `EFAULT`.

> +/// Concurrent access, *including data races to/from userspace memory*, =
is
> +/// permitted, because fundamentally another userspace thread/process co=
uld
> +/// always be modifying memory at the same time (in the same way that us=
erspace
> +/// Rust's [`std::io`] permits data races with the contents of files on =
disk).
> +/// In the presence of a race, the exact byte values read/written are
> +/// unspecified but the operation is well-defined. Kernelspace code shou=
ld
> +/// validate its copy of data after completing a read, and not expect th=
at
> +/// multiple reads of the same address will return the same value.
> +///
> +/// These APIs are designed to make it difficult to accidentally write T=
OCTOU
> +/// bugs. Every time you read from a memory location, the pointer is adv=
anced by
> +/// the length so that you cannot use that reader to read the same memor=
y
> +/// location twice. Preventing double-fetches avoids TOCTOU bugs. This i=
s
> +/// accomplished by taking `self` by value to prevent obtaining multiple=
 readers
> +/// on a given [`UserSlicePtr`], and the readers only permitting forward=
 reads.
> +/// If double-fetching a memory location is necessary for some reason, t=
hen that
> +/// is done by creating multiple readers to the same memory location, e.=
g. using
> +/// [`clone_reader`].

Maybe something like

    Every time a memory location is read, the reader's position is advanced=
 by
    the read length and the next read will start from there. This helps pre=
vent
    accidentally reading the same location twice and causing a TOCTOU bug.

    Creating a [`UserSlicePtrReader`] and/or [`UserSlicePtrWriter`]
    consumes the `UserSlicePtr`, helping ensure that there aren't multiple
    readers or writers to the same location.

    If double fetching a memory location...

> +///
> +/// Constructing a [`UserSlicePtr`] performs no checks on the provided a=
ddress
> +/// and length, it can safely be constructed inside a kernel thread with=
 no
> +/// current userspace process. Reads and writes wrap the kernel APIs

Maybe some of this is better documented on `new` rather than the type?

> +/// `copy_from_user` and `copy_to_user`, which check the memory map of t=
he
> +/// current process and enforce that the address range is within the use=
r range
> +/// (no additional calls to `access_ok` are needed).
> +///
> +/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
> +/// [`clone_reader`]: UserSlicePtrReader::clone_reader
> +pub struct UserSlicePtr(*mut c_void, usize);

I think just `UserSlice` could work for the name here, since
`SlicePtr` is a bit redundant (slices automatically containing a
pointer). Also makes the Reader/Writer types a bit less wordy. Though
I understand wanting to make it discoverable for C users.

Is some sort of `Debug` implementation useful?

> +impl UserSlicePtr {
> +    /// Constructs a user slice from a raw pointer and a length in bytes=
.
> +    ///
> +    /// Callers must be careful to avoid time-of-check-time-of-use
> +    /// (TOCTOU) issues. The simplest way is to create a single instance=
 of
> +    /// [`UserSlicePtr`] per user memory block as it reads each byte at
> +    /// most once.
> +    pub fn new(ptr: *mut c_void, length: usize) -> Self {
> +        UserSlicePtr(ptr, length)
> +    }
> +
> +    /// Reads the entirety of the user slice.
> +    ///
> +    /// Returns `EFAULT` if the address does not currently point to
> +    /// mapped, readable memory.
> +    pub fn read_all(self) -> Result<Vec<u8>> {
> +        self.reader().read_all()
> +    }

std::io uses the signature

    fn read_to_end(&mut self, buf: &mut Vec<u8>) -> Result<usize> { ... }

Maybe this could be better here too, since it allows reusing the
vector without going through `read_raw`.

https://doc.rust-lang.org/std/io/trait.Read.html#method.read_to_end

> +    /// Constructs a [`UserSlicePtrReader`].
> +    pub fn reader(self) -> UserSlicePtrReader {
> +        UserSlicePtrReader(self.0, self.1)
> +    }

I wonder if this should be called `into_reader` to note that it is a
consuming method. Indifferent here, since there aren't any non-`self`
variants.

> +
> +    /// Constructs a [`UserSlicePtrWriter`].
> +    pub fn writer(self) -> UserSlicePtrWriter {
> +        UserSlicePtrWriter(self.0, self.1)
> +    }
> +
> +    /// Constructs both a [`UserSlicePtrReader`] and a [`UserSlicePtrWri=
ter`].

Could you add a brief about what is or isn't allowed when you have a
reader and a writer to the same location?

> +    pub fn reader_writer(self) -> (UserSlicePtrReader, UserSlicePtrWrite=
r) {
> +        (
> +            UserSlicePtrReader(self.0, self.1),
> +            UserSlicePtrWriter(self.0, self.1),
> +        )
> +    }
> +}
> +
> +/// A reader for [`UserSlicePtr`].
> +///
> +/// Used to incrementally read from the user slice.
> +pub struct UserSlicePtrReader(*mut c_void, usize);
> +
> +impl UserSlicePtrReader {
> +    /// Skip the provided number of bytes.
> +    ///
> +    /// Returns an error if skipping more than the length of the buffer.
> +    pub fn skip(&mut self, num_skip: usize) -> Result {
> +        // Update `self.1` first since that's the fallible one.
> +        self.1 =3D self.1.checked_sub(num_skip).ok_or(EFAULT)?;
> +        self.0 =3D self.0.wrapping_add(num_skip);

I think it would be better to change to named structs to make this more cle=
ar.

> +        Ok(())
> +    }
> +
> +    /// Create a reader that can access the same range of data.
> +    ///
> +    /// Reading from the clone does not advance the current reader.
> +    ///
> +    /// The caller should take care to not introduce TOCTOU issues.

Could you add an example of what should be avoided?

> +    pub fn clone_reader(&self) -> UserSlicePtrReader {
> +        UserSlicePtrReader(self.0, self.1)
> +    }
> +
> +    /// Returns the number of bytes left to be read from this.

Remove "from this" or change to "from this reader".

> +    ///
> +    /// Note that even reading less than this number of bytes may fail.>=
 +    pub fn len(&self) -> usize {
> +        self.1
> +    }
> +
> +    /// Returns `true` if no data is available in the io buffer.
> +    pub fn is_empty(&self) -> bool {
> +        self.1 =3D=3D 0
> +    }
> +
> +    /// Reads raw data from the user slice into a raw kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read encounters a page fault.

This is raised if the address is invalid right, not just page faults?
Or, are page faults just the only mode of indication that a pointer
isn't valid.

I know this is the same as copy_from_user, but I don't understand that
too well myself. I'm also a bit curious what happens if you pass a
kernel pointer to these methods.

> +    /// # Safety
> +    ///
> +    /// The `out` pointer must be valid for writing `len` bytes.
> +    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Resul=
t {

What is the motivation for taking raw pointers rather than a slice
here? In which case it could just be called `read`.

> +        if len > self.1 || len > MAX_USER_OP_LEN {
> +            return Err(EFAULT);
> +        }
> +        // SAFETY: The caller promises that `out` is valid for writing `=
len` bytes.
> +        let res =3D unsafe { bindings::copy_from_user(out.cast::<c_void>=
(), self.0, len as c_ulong) };

To me, it would be more clear to `c_ulong::try_from(len).map_err(|_|
EFAULT)?` rather than using MAX_USER_OP_LEN with an `as` cast, since
it makes it immediately clear that the conversion is ok (and is doing
that same comparison)

> +        if res !=3D 0 {
> +            return Err(EFAULT);
> +        }
> +        // Since this is not a pointer to a valid object in our program,
> +        // we cannot use `add`, which has C-style rules for defined
> +        // behavior.
> +        self.0 =3D self.0.wrapping_add(len);
> +        self.1 -=3D len;
> +        Ok(())
> +    }
> +
> +    /// Reads all remaining data in the buffer into a vector.
> +    ///
> +    /// Fails with `EFAULT` if the read encounters a page fault.
> +    pub fn read_all(&mut self) -> Result<Vec<u8>> {

Same as the above note about read_to_end

> +        let len =3D self.len();
> +        let mut data =3D Vec::<u8>::try_with_capacity(len)?;
> +
> +        // SAFETY: The output buffer is valid for `len` bytes as we just=
 allocated that much space.
> +        unsafe { self.read_raw(data.as_mut_ptr(), len)? };

If making the change above (possibly even if not), going through
https://doc.rust-lang.org/std/vec/struct.Vec.html#method.spare_capacity_mut
can be more clear about uninitialized data.

> +
> +        // SAFETY: Since the call to `read_raw` was successful, the firs=
t `len` bytes of the vector
> +        // have been initialized.
> +        unsafe { data.set_len(len) };
> +        Ok(data)
> +    }
> +}
> +
> +/// A writer for [`UserSlicePtr`].
> +///
> +/// Used to incrementally write into the user slice.
> +pub struct UserSlicePtrWriter(*mut c_void, usize);
> +
> +impl UserSlicePtrWriter {
> +    /// Returns the amount of space remaining in this buffer.
> +    ///
> +    /// Note that even writing less than this number of bytes may fail.
> +    pub fn len(&self) -> usize {
> +        self.1
> +    }
> +
> +    /// Returns `true` if no more data can be written to this buffer.
> +    pub fn is_empty(&self) -> bool {
> +        self.1 =3D=3D 0
> +    }
> +
> +    /// Writes raw data to this user pointer from a raw kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the write encounters a page fault.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `data` pointer must be valid for reading `len` bytes.
> +    pub unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> R=
esult {

Same as for Reader regarding signature

> +        if len > self.1 || len > MAX_USER_OP_LEN {
> +            return Err(EFAULT);
> +        }
> +        let res =3D unsafe { bindings::copy_to_user(self.0, data.cast::<=
c_void>(), len as c_ulong) };

Same as for Reader regarding `as` casts.

> +        if res !=3D 0 {
> +            return Err(EFAULT);
> +        }
> +        // Since this is not a pointer to a valid object in our program,
> +        // we cannot use `add`, which has C-style rules for defined
> +        // behavior.
> +        self.0 =3D self.0.wrapping_add(len);
> +        self.1 -=3D len;
> +        Ok(())
> +    }
> +
> +    /// Writes the provided slice to this user pointer.
> +    ///
> +    /// Fails with `EFAULT` if the write encounters a page fault.
> +    pub fn write_slice(&mut self, data: &[u8]) -> Result {

This could probably just be called `write`, which would be consistent
with std::io::Write.

> +        let len =3D data.len();
> +        let ptr =3D data.as_ptr();
> +        // SAFETY: The pointer originates from a reference to a slice of=
 length
> +        // `len`, so the pointer is valid for reading `len` bytes.
> +        unsafe { self.write_raw(ptr, len) }
> +    }
> +}
>
> --
> 2.43.0.429.g432eaa2c6b-goog

The docs could use usage examples, but I am sure you are planning on
that already :)

- Trevor

