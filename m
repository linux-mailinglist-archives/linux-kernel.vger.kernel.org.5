Return-Path: <linux-kernel+bounces-146250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780638A62BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E201F22AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D84C39ADB;
	Tue, 16 Apr 2024 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="YAjzm/qZ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12C381DE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243935; cv=none; b=TDRNFyfFYWmixFePXHIkqbKfMBFq3XzsPZ1huqHWpBDJayFSjARgCpshYTta9YNoSebHpub+D2dNkMZ9Cj5MGgampbu8QUg93daUNHFeX+wGFrMdlvUbwpI0NmPvZ2SABIor2088rax/RT70rY+1sjJuTlFeY5PWqp4pD3Ky8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243935; c=relaxed/simple;
	bh=hfrS2yAKVWrmnlB0XBYaEg3EmwdL7jtCR9WpkagwQzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+4XrNY1cZ8JyGpa/Mif0IQahlUYXmbxWTSqYZGU6iwlgCZdFwDl3ZHLcuGupjPJVkLBWii12Wg4QM+5jcNRgZ0aiRN8fEWGpC5EVWHRVS1TEa6arR8ixpT1GrVScO/imNwjOlxcHJsftxnQ2f+s3xpde5dUstROUMOhEcTkIYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=YAjzm/qZ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so3792420276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1713243931; x=1713848731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJmDU0qCtC6xbk/2Z6msCh6alcZpNMwqU1+ATj0oOrg=;
        b=YAjzm/qZ/R1hse1bDtoP/wgCKaOM3uDAUbsMnNNtF7WxSfyHIuV5G5Aa3UUCBqWsHz
         7DcNQvy7OOllrvR287oJQoTI3nZYJUn8iCDedGBMQ3CC/sHtE4A4Q+kN9jlL07C9HZan
         wZL7tEjAHiJK8yD+p8XeO4FADRGtCU0nxbFeH7E1SV1fx4+XZ+G1tiTanrBRYZKHSPW8
         Z4OeyErCEAud3YmpCTwEovJuKRepniZJriKlHYR3GFp9qqSDjcjFlVEmhGTXlI+ZQ1iW
         m0f7FUK+dxVg6CkkLsF6TPpInumaOigtKdOGQ2FAOFPVJofTj5zT/2K2GkYAkbmDAusI
         62qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713243931; x=1713848731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJmDU0qCtC6xbk/2Z6msCh6alcZpNMwqU1+ATj0oOrg=;
        b=m6JiMWlr6AEIepJPOqkPF0mBIG/44DW7EEURQybuEYIIbbYHyzR2LaZhiy8q9qjxd0
         1+QCd/0BGem4qfun4tVwrvJV7RxNBWEtfkcCBymooUO588nTJ2T27PpYWQErL/tPhS4P
         N7lHNxI24F6u3BBHLA0FJ/c4BqK2CPvfGTSnNjYOMGj/l6R22cvmczV2R7jWvNZP9yCk
         V5KwXF+cSPQA+MHNlrli2DMLDhWOOkCaU5sq90GEDU262hkim6x4X81A6HXaLjSjOavr
         /hxTbHUho8X8wB3psD7Zqbe4Lqn5U2RwNhyT9CQJ59gEItbn3gYQsqCiAAfh6Vv6BJBU
         UFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTqaoO53ICI45KTRzCnwSKu9hPRGZ2Y3WbEPk3Y/Hg1UhVe1vpA/kOtQEoNln5Ruwyg5Tbda+JcG8RVyp8D2w9wpl5R/gDAIuXx1UQ
X-Gm-Message-State: AOJu0Yx0Qti3+u/c/X88hwYCYFQshqlY6myvJ1Kw8doIiBLpNKzHuPGm
	UAmJYTMllBDwNChwirt5rr4AdYjSEBBwLKaPDAQITk2w84qRqWVaEfdOSeHWrtG0I+wpRy8XUhD
	KQzIp8u6lZNBDywr62u/KaYKbawvNoy3oK7XzYg==
X-Google-Smtp-Source: AGHT+IGA2IjVKw8IkJCjL9FhLOVDIrOwEj1lKKmglsv29PQSjP7wQuUdMHMf3ycCLE4DIaLikqvNM7nDkFaVD2tnzjE=
X-Received: by 2002:a25:ea05:0:b0:de1:27f4:38a5 with SMTP id
 p5-20020a25ea05000000b00de127f438a5mr10411763ybd.14.1713243931364; Mon, 15
 Apr 2024 22:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com> <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com>
In-Reply-To: <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 16 Apr 2024 01:05:20 -0400
Message-ID: <CALNs47vRk0cKKDkpkhy2XUkxcjtPW-CABUexAZfGZ6PHT=wKng@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
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

On Mon, Apr 15, 2024 at 3:14=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> A pointer to an area in userspace memory, which can be either read-only
> or read-write.
>
> All methods on this struct are safe: attempting to read or write on bad
> addresses (either out of the bound of the slice or unmapped addresses)
> will return `EFAULT`. Concurrent access, *including data races to/from
> userspace memory*, is permitted, because fundamentally another userspace
> thread/process could always be modifying memory at the same time (in the
> same way that userspace Rust's `std::io` permits data races with the
> contents of files on disk). In the presence of a race, the exact byte
> values read/written are unspecified but the operation is well-defined.
> Kernelspace code should validate its copy of data after completing a
> read, and not expect that multiple reads of the same address will return
> the same value.
>
> These APIs are designed to make it difficult to accidentally write
> TOCTOU bugs. Every time you read from a memory location, the pointer is
> advanced by the length so that you cannot use that reader to read the
> same memory location twice. Preventing double-fetches avoids TOCTOU
> bugs. This is accomplished by taking `self` by value to prevent
> obtaining multiple readers on a given `UserSlicePtr`, and the readers
> only permitting forward reads. If double-fetching a memory location is
> necessary for some reason, then that is done by creating multiple
> readers to the same memory location.
>
> Constructing a `UserSlicePtr` performs no checks on the provided
> address and length, it can safely be constructed inside a kernel thread
> with no current userspace process. Reads and writes wrap the kernel APIs
> `copy_from_user` and `copy_to_user`, which check the memory map of the
> current process and enforce that the address range is within the user
> range (no additional calls to `access_ok` are needed).
>
> This code is based on something that was originally written by Wedson on
> the old rust branch. It was modified by Alice by removing the
> `IoBufferReader` and `IoBufferWriter` traits, and various other changes.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

I left some suggestions for documentation improvements and one
question, but mostly LGTM.

> ---
>  rust/helpers.c         |  14 +++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/uaccess.rs | 304 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 319 insertions(+)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index be68d5e567b1..37f84223b83f 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -49,6 +49,7 @@
>  pub mod task;
>  pub mod time;
>  pub mod types;
> +pub mod uaccess;
>  pub mod workqueue;
>
>  #[doc(hidden)]
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> new file mode 100644
> index 000000000000..c97029cdeba1
> --- /dev/null
> +++ b/rust/kernel/uaccess.rs
> @@ -0,0 +1,304 @@
> [...]
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

I would just add a note that pointer should be a valid userspace
pointer, but that gets checked at read/write time

> +    /// Callers must be careful to avoid time-of-check-time-of-use (TOCT=
OU) issues. The simplest way
> +    /// is to create a single instance of [`UserSlice`] per user memory =
block as it reads each byte
> +    /// at most once.
> +    pub fn new(ptr: *mut c_void, length: usize) -> Self {
> +        UserSlice { ptr, length }
> +    }

> +impl UserSliceReader {
> [...]
> +    /// Reads raw data from the user slice into a kernel buffer.
> +    ///
> +    /// After a successful call to this method, all bytes in `out` are i=
nitialized.

If this is guaranteed, could it return `Result<&mut [u8]>`? So the
caller doesn't need to unsafely `assume_init` anything.

> +    /// Fails with `EFAULT` if the read happens on a bad address.

This should also mention that the slice cannot be bigger than the
reader's length.

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
> +
> +    /// Reads raw data from the user slice into a kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read happens on a bad address.
> +    pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
> +        // SAFETY: The types are compatible and `read_raw` doesn't write=
 uninitialized bytes to
> +        // `out`.
> +        let out =3D unsafe { &mut *(out as *mut [u8] as *mut [MaybeUnini=
t<u8>]) };
> +        self.read_raw(out)
> +    }

If this is just a safe version of read_raw, could you crosslink the docs?

> +impl UserSliceWriter {
> +
> +    /// Writes raw data to this user pointer from a kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the write happens on a bad address.
> +    pub fn write_slice(&mut self, data: &[u8]) -> Result {
>   [...]
> +    }

Could use a note about length like `read_raw`.

