Return-Path: <linux-kernel+bounces-58092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B550084E134
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249E81F2B9B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F075762EA;
	Thu,  8 Feb 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hwCkaeWV"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9D7602A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396815; cv=none; b=jRB6atrW7tMgZc9UMy2xB5KU3gScKoTFYn7XIa2nVZ5nIroBvVYiJnmI82NvHBhdX70YLbSlhQoSlgvDxysu8AH8z0/HLXS3qqon596abQ8WGN805UVvVTdzncraJsFwyjl4++7jHa28gzwGpa1gl7pvMaFiTAjbu8H7MUuBCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396815; c=relaxed/simple;
	bh=2DDnMV9ejfrDF2CLJKjR+z1eZqbhQjAC0pdhJH4R5eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Brv3pwZ4sxhYQJWeMCmd2r6iW1NTACmJb9IQwoBrxkd5YNC8JIamD+kMjaQSYeH/xvaqSo1kIXom827RQSTh+PjF3N5lvPfGM/ornvjXx3wNthVSWM9KJQE0A8ovxh6ZAWDFqM9gE2Mcxqh9Kplt1ubv5Tv6IyiiNhQGacBzAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwCkaeWV; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d5bbbe592dso815176241.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707396812; x=1708001612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1tCtLJ/RjQd559OCm1MWYW/kF4GUTJKVOlOzEx+/HI=;
        b=hwCkaeWVH5ml9Dx5DAUenbSJuxNrgRfgHDLiZcLwZp6FR+EtQsBPDs87a7srH1fe6c
         lspDZgEmC8In9Lo+ZNX7ClyaqIlfpFCsnerCpQvF20ToPF1orz9b7v0xLsCe2Tc1Qk3L
         ojX5rMOxSqAZLNRJV0NUA8XB+2uoHA3JdxMIOfF+Zr/kVBTU679xpBKGsuLvp+USiofb
         QQLFG9pIorEaFZSEFQB28olOu+Z4UAoofnF4lvgHq6hNfNfYitm9xhq/jMrCcfrAoqTN
         jOeK7FQ9khpoKMuraA7bxugLGaZhP04eNF7gv57LVO+KRso7kZ+XLaHOXq8HibwIIIlX
         vCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396812; x=1708001612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1tCtLJ/RjQd559OCm1MWYW/kF4GUTJKVOlOzEx+/HI=;
        b=miPEfMgl+yWq/ZkwbbYDPxF8ul5Jd6OAakhhrWjW1NCOCjcvUZ8bsQ1s93z0LFiX8G
         RkXc/8ZYUp+AFXtensW8MMYGYRHMU7thpS1dtCZrh6lQhpqI5WDeTvib9IExh3MBdgsP
         w95USJ6MwCKY86ZLNlzr1/GWsvLiK4oCECVagwC6YXUh8Vi0J3WOhv6E0RDLT8Ub0ORd
         dnZsoSuxetsJUdXSeEPJJ34uEu0s87C3e/1dqnzKY+VxfN+mTErvMRIzlNGtoU2hrAlh
         hHukAWgAUf7pOgEtAgqmNT1CebzhF83BzLxLNmT9av2Ko9KyNpdPr/ZC2imi4Ft5VRXU
         yqdw==
X-Gm-Message-State: AOJu0YzITU22Kbzt6IhIZBOVLroS6cYNJqXmp4UpMB0WrVC58hvAL1Ya
	O2h+JwRq5SMy22NwcczI+FvG/gdXgHNY1o2gHO8yQM05dSQEEbhNjOfR3URiNQS7JGlprWTsSUm
	uBzOGIflmBVugylyh2yQLIdjGX6L/HdDJSOpe
X-Google-Smtp-Source: AGHT+IEJqJTUEToVLsAz3TUs3hv4M1JTAA/j5bflNrbMaYu8pXjrLGnrKB2V/bcpV5X6FMXZ3OqejllkDm2rWH2sDhE=
X-Received: by 2002:a05:6102:4193:b0:46d:2f8b:d7 with SMTP id
 cd19-20020a056102419300b0046d2f8b00d7mr6451934vsb.22.1707396812044; Thu, 08
 Feb 2024 04:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-1-d1abcec83c44@google.com> <CALNs47uDaD05oD8TtZoSqUBc4SaRig80u2_1P0qMCXtE3H9_Vw@mail.gmail.com>
In-Reply-To: <CALNs47uDaD05oD8TtZoSqUBc4SaRig80u2_1P0qMCXtE3H9_Vw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 13:53:20 +0100
Message-ID: <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add userspace pointers
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

On Thu, Feb 1, 2024 at 5:06=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wro=
te:
>
> On Wed, Jan 24, 2024 at 6:21=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > +/// A pointer to an area in userspace memory, which can be either read=
-only or
> > +/// read-write.
> > +///
> > +/// All methods on this struct are safe: invalid pointers return `EFAU=
LT`.
>
> Maybe
>
>     ... attempting to read or write invalid pointers will return `EFAULT`=
.

Sure, that works.

> > +/// Concurrent access, *including data races to/from userspace memory*=
, is
> > +/// permitted, because fundamentally another userspace thread/process =
could
> > +/// always be modifying memory at the same time (in the same way that =
userspace
> > +/// Rust's [`std::io`] permits data races with the contents of files o=
n disk).
> > +/// In the presence of a race, the exact byte values read/written are
> > +/// unspecified but the operation is well-defined. Kernelspace code sh=
ould
> > +/// validate its copy of data after completing a read, and not expect =
that
> > +/// multiple reads of the same address will return the same value.
> > +///
> > +/// These APIs are designed to make it difficult to accidentally write=
 TOCTOU
> > +/// bugs. Every time you read from a memory location, the pointer is a=
dvanced by
> > +/// the length so that you cannot use that reader to read the same mem=
ory
> > +/// location twice. Preventing double-fetches avoids TOCTOU bugs. This=
 is
> > +/// accomplished by taking `self` by value to prevent obtaining multip=
le readers
> > +/// on a given [`UserSlicePtr`], and the readers only permitting forwa=
rd reads.
> > +/// If double-fetching a memory location is necessary for some reason,=
 then that
> > +/// is done by creating multiple readers to the same memory location, =
e.g. using
> > +/// [`clone_reader`].
>
> Maybe something like
>
>     Every time a memory location is read, the reader's position is advanc=
ed by
>     the read length and the next read will start from there. This helps p=
revent
>     accidentally reading the same location twice and causing a TOCTOU bug=
.
>
>     Creating a [`UserSlicePtrReader`] and/or [`UserSlicePtrWriter`]
>     consumes the `UserSlicePtr`, helping ensure that there aren't multipl=
e
>     readers or writers to the same location.
>
>     If double fetching a memory location...

That makes sense to me. I'll update that.

> > +///
> > +/// Constructing a [`UserSlicePtr`] performs no checks on the provided=
 address
> > +/// and length, it can safely be constructed inside a kernel thread wi=
th no
> > +/// current userspace process. Reads and writes wrap the kernel APIs
>
> Maybe some of this is better documented on `new` rather than the type?

I agree. I will move it.

> > +/// `copy_from_user` and `copy_to_user`, which check the memory map of=
 the
> > +/// current process and enforce that the address range is within the u=
ser range
> > +/// (no additional calls to `access_ok` are needed).
> > +///
> > +/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
> > +/// [`clone_reader`]: UserSlicePtrReader::clone_reader
> > +pub struct UserSlicePtr(*mut c_void, usize);
>
> I think just `UserSlice` could work for the name here, since
> `SlicePtr` is a bit redundant (slices automatically containing a
> pointer). Also makes the Reader/Writer types a bit less wordy. Though
> I understand wanting to make it discoverable for C users.

Sure, renamed.

> Is some sort of `Debug` implementation useful?

Leaking pointer addresses in logs is frowned upon in the kernel, so I
don't think we should include that.

> > +    /// Reads the entirety of the user slice.
> > +    ///
> > +    /// Returns `EFAULT` if the address does not currently point to
> > +    /// mapped, readable memory.
> > +    pub fn read_all(self) -> Result<Vec<u8>> {
> > +        self.reader().read_all()
> > +    }
>
> std::io uses the signature
>
>     fn read_to_end(&mut self, buf: &mut Vec<u8>) -> Result<usize> { ... }
>
> Maybe this could be better here too, since it allows reusing the
> vector without going through `read_raw`.
>
> https://doc.rust-lang.org/std/io/trait.Read.html#method.read_to_end

I updated the signature so that it appends to an existing vector
instead of creating a new one.

> > +    /// Constructs a [`UserSlicePtrReader`].
> > +    pub fn reader(self) -> UserSlicePtrReader {
> > +        UserSlicePtrReader(self.0, self.1)
> > +    }
>
> I wonder if this should be called `into_reader` to note that it is a
> consuming method. Indifferent here, since there aren't any non-`self`
> variants.

Hmm. I think the current name is good enough, since there aren't any
non-self methods, as you mention.

> > +
> > +    /// Constructs a [`UserSlicePtrWriter`].
> > +    pub fn writer(self) -> UserSlicePtrWriter {
> > +        UserSlicePtrWriter(self.0, self.1)
> > +    }
> > +
> > +    /// Constructs both a [`UserSlicePtrReader`] and a [`UserSlicePtrW=
riter`].
>
> Could you add a brief about what is or isn't allowed when you have a
> reader and a writer to the same location?

Ultimately, you can do whatever you want. But I'll add this:

/// Usually when this is used, you will first read the data, and then
/// overwrite it afterwards.

> > +    pub fn reader_writer(self) -> (UserSlicePtrReader, UserSlicePtrWri=
ter) {
> > +        (
> > +            UserSlicePtrReader(self.0, self.1),
> > +            UserSlicePtrWriter(self.0, self.1),
> > +        )
> > +    }
> > +}
> > +
> > +/// A reader for [`UserSlicePtr`].
> > +///
> > +/// Used to incrementally read from the user slice.
> > +pub struct UserSlicePtrReader(*mut c_void, usize);
> > +
> > +impl UserSlicePtrReader {
> > +    /// Skip the provided number of bytes.
> > +    ///
> > +    /// Returns an error if skipping more than the length of the buffe=
r.
> > +    pub fn skip(&mut self, num_skip: usize) -> Result {
> > +        // Update `self.1` first since that's the fallible one.
> > +        self.1 =3D self.1.checked_sub(num_skip).ok_or(EFAULT)?;
> > +        self.0 =3D self.0.wrapping_add(num_skip);
>
> I think it would be better to change to named structs to make this more c=
lear.

Good idea. Changed to named fields.

> > +        Ok(())
> > +    }
> > +
> > +    /// Create a reader that can access the same range of data.
> > +    ///
> > +    /// Reading from the clone does not advance the current reader.
> > +    ///
> > +    /// The caller should take care to not introduce TOCTOU issues.
>
> Could you add an example of what should be avoided?
>
> > +    pub fn clone_reader(&self) -> UserSlicePtrReader {
> > +        UserSlicePtrReader(self.0, self.1)
> > +    }
> > +
> > +    /// Returns the number of bytes left to be read from this.
>
> Remove "from this" or change to "from this reader".

Done.

> > +    ///
> > +    /// Note that even reading less than this number of bytes may fail=
> +    pub fn len(&self) -> usize {
> > +        self.1
> > +    }
> > +
> > +    /// Returns `true` if no data is available in the io buffer.
> > +    pub fn is_empty(&self) -> bool {
> > +        self.1 =3D=3D 0
> > +    }
> > +
> > +    /// Reads raw data from the user slice into a raw kernel buffer.
> > +    ///
> > +    /// Fails with `EFAULT` if the read encounters a page fault.
>
> This is raised if the address is invalid right, not just page faults?
> Or, are page faults just the only mode of indication that a pointer
> isn't valid.
>
> I know this is the same as copy_from_user, but I don't understand that
> too well myself. I'm also a bit curious what happens if you pass a
> kernel pointer to these methods.

Basically, if the userspace process wouldn't be able to dereference
the pointer, then you get this error.

> > +    /// # Safety
> > +    ///
> > +    /// The `out` pointer must be valid for writing `len` bytes.
> > +    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Res=
ult {
>
> What is the motivation for taking raw pointers rather than a slice
> here? In which case it could just be called `read`.

The second patch will introduce a method called `read`, so we can't
use that name.

I don't think a slice gains that much compared to a raw pointer. It
would have to be an `&mut [MaybeUninit<u8>]` due to uninit memory, but
that doesn't actually allow the caller to use this method without
unsafe, since the caller would have to unsafely assert that the slice
has been initialized by this call themselves. Making this method
usable safely would require that we start using something along the
lines of the standard library's BorrowedBuf [1], which seems way
overkill to me.

[1]: https://doc.rust-lang.org/stable/std/io/struct.BorrowedBuf.html

> > +        if len > self.1 || len > MAX_USER_OP_LEN {
> > +            return Err(EFAULT);
> > +        }
> > +        // SAFETY: The caller promises that `out` is valid for writing=
 `len` bytes.
> > +        let res =3D unsafe { bindings::copy_from_user(out.cast::<c_voi=
d>(), self.0, len as c_ulong) };
>
> To me, it would be more clear to `c_ulong::try_from(len).map_err(|_|
> EFAULT)?` rather than using MAX_USER_OP_LEN with an `as` cast, since
> it makes it immediately clear that the conversion is ok (and is doing
> that same comparison)

Thanks for the suggestion. I changed this.

> > +        let len =3D self.len();
> > +        let mut data =3D Vec::<u8>::try_with_capacity(len)?;
> > +
> > +        // SAFETY: The output buffer is valid for `len` bytes as we ju=
st allocated that much space.
> > +        unsafe { self.read_raw(data.as_mut_ptr(), len)? };
>
> If making the change above (possibly even if not), going through
> https://doc.rust-lang.org/std/vec/struct.Vec.html#method.spare_capacity_m=
ut
> can be more clear about uninitialized data.
>
> > +
> > +        // SAFETY: Since the call to `read_raw` was successful, the fi=
rst `len` bytes of the vector
> > +        // have been initialized.
> > +        unsafe { data.set_len(len) };
> > +        Ok(data)
> > +    }
> > +}
> > +
> > +/// A writer for [`UserSlicePtr`].
> > +///
> > +/// Used to incrementally write into the user slice.
> > +pub struct UserSlicePtrWriter(*mut c_void, usize);
> > +
> > +impl UserSlicePtrWriter {
> > +    /// Returns the amount of space remaining in this buffer.
> > +    ///
> > +    /// Note that even writing less than this number of bytes may fail=
.
> > +    pub fn len(&self) -> usize {
> > +        self.1
> > +    }
> > +
> > +    /// Returns `true` if no more data can be written to this buffer.
> > +    pub fn is_empty(&self) -> bool {
> > +        self.1 =3D=3D 0
> > +    }
> > +
> > +    /// Writes raw data to this user pointer from a raw kernel buffer.
> > +    ///
> > +    /// Fails with `EFAULT` if the write encounters a page fault.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The `data` pointer must be valid for reading `len` bytes.
> > +    pub unsafe fn write_raw(&mut self, data: *const u8, len: usize) ->=
 Result {
>
> Same as for Reader regarding signature

I suppose we could have only `write_slice`. But if we're going to have
a read_raw, then having write_raw too makes sense to me.

Besides, a memcpy of uninit memory isn't UB by itself, so the raw
method would let you write uninit memory if you needed to.

> > +        if res !=3D 0 {
> > +            return Err(EFAULT);
> > +        }
> > +        // Since this is not a pointer to a valid object in our progra=
m,
> > +        // we cannot use `add`, which has C-style rules for defined
> > +        // behavior.
> > +        self.0 =3D self.0.wrapping_add(len);
> > +        self.1 -=3D len;
> > +        Ok(())
> > +    }
> > +
> > +    /// Writes the provided slice to this user pointer.
> > +    ///
> > +    /// Fails with `EFAULT` if the write encounters a page fault.
> > +    pub fn write_slice(&mut self, data: &[u8]) -> Result {
>
> This could probably just be called `write`, which would be consistent
> with std::io::Write.

This would also name conflict with the second patch.

> The docs could use usage examples, but I am sure you are planning on
> that already :)

I'll add some.


Alice

