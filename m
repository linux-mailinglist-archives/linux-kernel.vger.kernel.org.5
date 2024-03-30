Return-Path: <linux-kernel+bounces-125735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC46892B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA3228320C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532AE29D06;
	Sat, 30 Mar 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TWLcUnn4"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60111EA74;
	Sat, 30 Mar 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711805712; cv=none; b=TunKf1+3fBL6EYFAYNZjolgG9rmUcDlE6fBbgtIfXFASNsOAU+Ycgl/s8A9GzkGUq6xYAStRqbHfc81p8AdDy4n9rUY4psNXtfm2R3ESNO9CRx+zwohEBAx9wddItP4iKZqCq9xgRx1lZSSo2JoOaL6ZJ0qRJ0foz8WWH5hpo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711805712; c=relaxed/simple;
	bh=QYb6/7sQ3bPgMY58EPb6y4dlsMY33z1x/wCF5aSqz2M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1DA9UdkunJyZszpVO0e5sttFYdBgFFhuhrL9avM76VwhKd8uw5tqx8+oJXQ9dXwELufoO/WEp55m9J0iSh7rEIQ4TSuARVv1nmHYLm0jbhW8ESfcJ/NoIkZJQMa/N+6u7NSi2cNyQ+XMt5ubBhWqhKUrMBtspdJ9wfXMkCcPLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TWLcUnn4; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711805708; x=1712064908;
	bh=qijb/PtssBKhbeYXFRSbFkJKp9EFEcX+rCDOKjXfYYQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TWLcUnn4mXryIbdSIVepkWPLIHpkLvguRNx42gykn6NrTrJTUEtBl1ivYFCYXUVlm
	 JCu3nCpyheZr037QaGoaaQlfYKoG5g8II0ShJMFm8IOYrMwEEaF2GCLz0+npGEOrPO
	 6St1RsoFwqusft2iLmGyCAjS4iCzHO2qJ8TCMrBCAOWrKpR24Ga5d4ZeLC7O/IQumW
	 jIFV12U86VfvOd3pcRQG9UqYOxxqcmmmsUo2dNlgZ5DH+0h4k6OqVmzOdGlGyMWIGP
	 1dUn6KjW6tXdsHLWHhmib11hbyKQyHGrRwbc269t3lpsii1G2Jt5MaRw3xMzBD/Yy8
	 uKorhl27B5Bvw==
Date: Sat, 30 Mar 2024 13:35:04 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 06/10] rust: alloc: introduce the `BoxExt` trait
Message-ID: <6a684f4d-6f95-4c52-b515-73c832f050a8@proton.me>
In-Reply-To: <20240328013603.206764-7-wedsonaf@gmail.com>
References: <20240328013603.206764-1-wedsonaf@gmail.com> <20240328013603.206764-7-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.03.24 02:35, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Make fallible versions of `new` and `new_uninit` methods available in
> `Box` even though it doesn't implement them because we build `alloc`
> with the `no_global_oom_handling` config.
>=20
> They also have an extra `flags` parameter that allows callers to pass
> flags to the allocator.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/alloc.rs           |  1 +
>   rust/kernel/alloc/allocator.rs |  2 +-
>   rust/kernel/alloc/box_ext.rs   | 60 ++++++++++++++++++++++++++++++++++
>   rust/kernel/init.rs            | 13 ++++----
>   rust/kernel/prelude.rs         |  2 +-
>   rust/kernel/sync/arc.rs        |  3 +-
>   6 files changed, 72 insertions(+), 9 deletions(-)
>   create mode 100644 rust/kernel/alloc/box_ext.rs

With Boqun's suggestion (feel free to take your variant):

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

[...]

> +impl<T> BoxExt<T> for Box<T> {
> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> +        let mut b =3D <Self as BoxExt<_>>::new_uninit(flags)?;
> +        b.write(x);
> +        // SAFETY: The contents were just initialised in the line above.
> +        Ok(unsafe { b.assume_init() })
> +    }
> +
> +    #[cfg(any(test, testlib))]
> +    fn new_uninit(_flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocErr=
or> {
> +        Ok(Box::new_uninit())
> +    }
> +
> +    #[cfg(not(any(test, testlib)))]
> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocErro=
r> {
> +        let ptr =3D if core::mem::size_of::<MaybeUninit<T>>() =3D=3D 0 {
> +            core::ptr::NonNull::<_>::dangling().as_ptr()
> +        } else {
> +            let layout =3D core::alloc::Layout::new::<MaybeUninit<T>>();
> +
> +            // SAFETY: Memory is being allocated (first arg is null). Th=
e only other source of
> +            // safety issues is sleeping on atomic context, which is add=
ressed by klint. Lastly,
> +            // the type is not a SZT (checked above).
> +            let ptr =3D
> +                unsafe { super::allocator::krealloc_aligned(core::ptr::n=
ull_mut(), layout, flags) };

Personally, I would rather import `krealloc_aligned` and not have this
weird formatting here.

--=20
Cheers,
Benno

> +            if ptr.is_null() {
> +                return Err(AllocError);
> +            }
> +
> +            ptr.cast::<MaybeUninit<T>>()
> +        };
> +
> +        // SAFETY: For non-zero-sized types, we allocate above using the=
 global allocator. For
> +        // zero-sized types, we use `NonNull::dangling`.
> +        Ok(unsafe { Box::from_raw(ptr) })
> +    }
> +}

[...]


