Return-Path: <linux-kernel+bounces-150126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E158A9ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F563282AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED816078C;
	Thu, 18 Apr 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RpVqEyPH"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F315DBD6;
	Thu, 18 Apr 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445341; cv=none; b=mPzAnEVGs6EQxc2YLWVmVLgzhXfFMR+Mvz7C8iqpnsnanKPs+NTQ9WTf0t3AGt9q7ZhILJjk/mFFfWSSUet9GpMPY+uG4QER8NlYca0+6NdzrM8pmqhulDsDDLj2CL5rVKUAX46wqKwgAQkk3gxa0xe4weJuFaSYdRbEsPM5qHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445341; c=relaxed/simple;
	bh=wNhnXhJl0BimI0FnxrFsan2/eQTs5jA8t+ECKzsx8yI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCDeFAdOxb0UnixZqfamW51HZPAMcnr0hX1GznqBnvq88f0zYy6NX5hTANw5nQsfr1RralHXegsMKQ02YHGszpwJknydUJ4fod6O+Kzmj37IE+omNgFpKOrMKgmwJW44rTahGm1UvwiwJc9LRcHj+Moe4q5T8qND9Z7eMf8YpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RpVqEyPH; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713445325; x=1713704525;
	bh=ABmUIlM/+0TTsmSAW6kea20HyxX5pv8vg2oi+dkTWWw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RpVqEyPHGYdAeCCRn9WA4rKt34/0xi/epM4XaGUJRiThGqiJiC0GMruCZ2ZZOPAw1
	 l7ul+FmMjMNDUNdqq98y7CfOnwxfG4dHaiUvUXhjQyiSf6sUeYldhxnUdVL9doS5DD
	 3lS4z/zMb6f2frGgts8W1QFMvgKrrkZtwR5NPL+Pw47KNGWpSIBirIGKmiyvGvmaGF
	 slX5qCs83Kgm4bkQrDQ7mh29h8FwC9wpkhb82MtJ6oxt3Ac5qWtwCVbAzBJvhVoSGN
	 TSKzko6TxoCYdmqNSc2clKK/lI+IBIN4Q5tloLfaTo37hhCmABoLD2s9I/1YqFdGIh
	 GUivWSumPFT0A==
Date: Thu, 18 Apr 2024 13:01:20 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 3/4] rust: uaccess: add typed accessors for userspace pointers
Message-ID: <5fd684d8-d46d-4009-bcf8-134dab342322@proton.me>
In-Reply-To: <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com> <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 73974adc566aff94727dc6833659914e59314d2f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.24 10:59, Alice Ryhl wrote:
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 8fad61268465..9c57c6c75553 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -409,3 +409,67 @@ pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type =
`R`.
>      Right(R),
>  }
> +
> +/// Types for which any bit pattern is valid.
> +///
> +/// Not all types are valid for all values. For example, a `bool` must b=
e either zero or one, so
> +/// reading arbitrary bytes into something that contains a `bool` is not=
 okay.
> +///
> +/// It's okay for the type to have padding, as initializing those bytes =
has no effect.
> +///
> +/// # Safety
> +///
> +/// All bit-patterns must be valid for this type. This type must not hav=
e interior mutability.

What is the reason for disallowing interior mutability here? I agree
that it is necessary for `AsBytes`, but I don't think we need it here.
For example it is fine to convert `u8` to `UnsafeCell<u8>`. Niches also
should not be a problem, since eg `Option<UnsafeCell<NonNull<u8>>>`
already fails the "All bit-patterns must be valid for this type".

--=20
Cheers,
Benno

> +pub unsafe trait FromBytes {}
> +
> +// SAFETY: All bit patterns are acceptable values of the types below.
> +unsafe impl FromBytes for u8 {}
> +unsafe impl FromBytes for u16 {}
> +unsafe impl FromBytes for u32 {}
> +unsafe impl FromBytes for u64 {}
> +unsafe impl FromBytes for usize {}
> +unsafe impl FromBytes for i8 {}
> +unsafe impl FromBytes for i16 {}
> +unsafe impl FromBytes for i32 {}
> +unsafe impl FromBytes for i64 {}
> +unsafe impl FromBytes for isize {}


