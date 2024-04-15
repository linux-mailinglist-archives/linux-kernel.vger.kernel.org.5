Return-Path: <linux-kernel+bounces-144843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05028A4BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852861F227A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1390F482E2;
	Mon, 15 Apr 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OtCZE2Gc"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093361DFEA;
	Mon, 15 Apr 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173835; cv=none; b=gG6MB3Ou7Diz3tNOak+Zd5+ELqYJCYNHxOsgIP7Zth5JaCKTlZygu31efrgUfWd690f6hNlNaPFPyVtsZkO1XK7lnXynd/vYu2IUxx5YMnfKesbsyp+oVPc8iLEgk7HM4wKQrjI0l5howisJS50pqXYDJzzkObVhSR0I27/e0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173835; c=relaxed/simple;
	bh=ZAkP50PAdTGqIT00FGajg5KBZSuTl2Zi2Yedfzdv5X4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUCzAdJdZOgHlMsHGd6kJ2+4szQU00KKrtb8CWK45CoAzU4r8ToZ6/5voEonUphYrYobB4gqiDLPOpQSSgDOU+IVe6J8I13Y6+GgtW1FwEXgG18mO3cIzG7QQxCSfGoRGu7azF1PqJGH4RwIiQRjSaC7DATpL2n9eMBhLHm+4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OtCZE2Gc; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713173823; x=1713433023;
	bh=p1EtZ30uvut0peHMj2MGXUDT4+1A886YAPfyu8wzS+o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OtCZE2Gcf48z1GRL3TfFWnx+/2Ld3oUzuWrpovC4uLBIfddJEmt53KdLyL9i1arQM
	 R9Oo+wLpeefAMZmRozQ044xIh6fEww62Kf8hx5uFVn/a0OBTZkj/Nx6FgUXeH70cjH
	 Tv24NKvrIu//f+qbYMNOEyU1+FtKIx123W3pQTxTz6FqHDy62jxKb5nLa7jDRYIbF2
	 oSUaVXzRKPmXXkAlXacw7vO5lzJ5vYT9SYpKeXfoka6QVyz2BcU4YtHlyVzeTZ2b1S
	 5+jHrosdq9s3dH9TPAtpjmRSCepNtVdY5T50lvhrkjLGXM5D4TZ13Air1r9QnSGT6/
	 7KsIUcSFjO/3A==
Date: Mon, 15 Apr 2024 09:36:56 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
Message-ID: <2cae6fd4-906c-44ad-88be-0dfed090d07c@proton.me>
In-Reply-To: <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com>
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com> <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.04.24 09:13, Alice Ryhl wrote:
> +impl UserSlice {
> +    /// Constructs a user slice from a raw pointer and a length in bytes=
.
> +    ///
> +    /// Constructing a [`UserSlice`] performs no checks on the provided =
address and length, it can
> +    /// safely be constructed inside a kernel thread with no current use=
rspace process. Reads and
> +    /// writes wrap the kernel APIs `copy_from_user` and `copy_to_user`,=
 which check the memory map
> +    /// of the current process and enforce that the address range is wit=
hin the user range (no
> +    /// additional calls to `access_ok` are needed).
> +    ///
> +    /// Callers must be careful to avoid time-of-check-time-of-use (TOCT=
OU) issues. The simplest way
> +    /// is to create a single instance of [`UserSlice`] per user memory =
block as it reads each byte
> +    /// at most once.
> +    pub fn new(ptr: *mut c_void, length: usize) -> Self {

What would happen if I call this with a kernel pointer and then
read/write to it? For example

     let mut arr =3D [MaybeUninit::uninit(); 64];
     let ptr: *mut [MaybeUninit<u8>] =3D &mut arr;
     let ptr =3D ptr.cast::<c_void>();

     let slice =3D UserSlice::new(ptr, 64);
     let (mut r, mut w) =3D slice.reader_writer();

     r.read_raw(&mut arr)?;
     // SAFETY: `arr` was initialized above.
     w.write_slice(unsafe { MaybeUninit::slice_assume_init_ref(&arr) })?;

I think this would violate the exclusivity of `&mut` without any
`unsafe` code. (the `unsafe` block at the end cannot possibly be wrong)

> +        UserSlice { ptr, length }
> +    }

[...]

> +    /// Returns `true` if no data is available in the io buffer.
> +    pub fn is_empty(&self) -> bool {
> +        self.length =3D=3D 0
> +    }
> +
> +    /// Reads raw data from the user slice into a kernel buffer.
> +    ///
> +    /// After a successful call to this method, all bytes in `out` are i=
nitialized.

I think we should put things like this into a `# Guarantees` section.

--=20
Cheers,
Benno

> +    ///
> +    /// Fails with `EFAULT` if the read happens on a bad address.
> +    pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
> +        let len =3D out.len();
> +        let out_ptr =3D out.as_mut_ptr().cast::<c_void>();
> +        if len > self.length {
> +            return Err(EFAULT);
> +        }
> +        let Ok(len_ulong) =3D c_ulong::try_from(len) else {
> +            return Err(EFAULT);
> +        };
> +        // SAFETY: `out_ptr` points into a mutable slice of length `len_=
ulong`, so we may write
> +        // that many bytes to it.
> +        let res =3D unsafe { bindings::copy_from_user(out_ptr, self.ptr,=
 len_ulong) };
> +        if res !=3D 0 {
> +            return Err(EFAULT);
> +        }
> +        // Userspace pointers are not directly dereferencable by the ker=
nel, so we cannot use `add`,
> +        // which has C-style rules for defined behavior.
> +        self.ptr =3D self.ptr.wrapping_byte_add(len);
> +        self.length -=3D len;
> +        Ok(())
> +    }


