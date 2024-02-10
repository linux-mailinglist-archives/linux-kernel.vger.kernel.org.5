Return-Path: <linux-kernel+bounces-60345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23A9850371
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 09:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00C71C21C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC592B9CF;
	Sat, 10 Feb 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="A7SRCENf"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5136AB7
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707552343; cv=none; b=RACz3ekF5N0iIAAn+AMlxL4FrW5YeMbVWZpo2shS8aBCTbpVUbKd96vXZ+C0WZ7mdfrMvvSDvMJOD2wmtX/MZhgh05ortyknYmCH9reI3XIdjX2hpHbbY1XaL6NkRCGAentsx+fY53TeYAEAnB7vnYWz3lCP9oFvW7I1hXPJFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707552343; c=relaxed/simple;
	bh=2kk8zl7wmBntT6bZOZ9oR09/coMM4tEFb/OHSEp1i7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doFALNvNpAl5Q3f+KhOcDabJksG3pwOhSbAoLlBwpKihjGQLVlQffrADFgU24yL5u1l4rPb/1jzfLlFuAAIw6pechZXken/vJSnqzoejXqlAwymX0l7rubGBrQQaWGAeqH/AtGRQgPYqhx1ZAjCNjkP98Tp/gzn1irQLeThiXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=A7SRCENf; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-603fd31f5c2so23642847b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707552341; x=1708157141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaycG/k+YujivUfeaD+PrPikDMJQEOMrsakJhGd6CLE=;
        b=A7SRCENfhkGrc2TRwgkBiKuVohyNrM5wRC+Z0RcEduqDUwl841BMJ9dFsOp8qvF76S
         +WQP/FyjTf3yvuGmnRKjnN9VW1BaPghA5UP5pjBCXG+jeubFdm4z0Vj1g5oT9nM7H7Lm
         +nvQefJh7uPrMNjSz9WUeb/SaQkLZN7ZLjfPoW0SzHI/dGDGn+ga+0h+jeaWDcyZasDy
         rx0NJ3/3VQ6eoEg8ZYCvb6tMqXEUc+JZCyJKjtz8ez0ihCbL9yzgnocbfV1QkWMRaN/K
         YcNvrSjsfWqppXn0nxwYUfpYuv4crfkIgBziiMooPDUEaaEtBotcHQV3bvQR7Eetocmf
         wuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707552341; x=1708157141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaycG/k+YujivUfeaD+PrPikDMJQEOMrsakJhGd6CLE=;
        b=DSIm++6lBnQiovlv2gpgO71N/h9J7GmnBB5FQ5Xt89OTd3tfKkC30Xi0vkTFNTt6lw
         d/XrC1++xWnyYi5s+Ku6fyQLtCUNXXsKj2JYb6uzYzA58hQX/glQJeIMlBGNV1DgWKDx
         PZf3nTKqelN6M9DPoQ/FFVr2b3V+BkqhDJO6wwCHmp0kdYXH8cR6KbwiOMs9wuYsJM8h
         URy7Xve1guyjtM4BgtzgCEquaxQoM5Bly073eOIXIPKHiHXIjSQt9YXnZaQRMkgN/Td+
         kU/9BImUWxTaj1qCNgtEqhcXCfDcdzYAL4OmmCJabdTqzQmZfDj7jecHUDgH/xGOvtqd
         CkEg==
X-Gm-Message-State: AOJu0Yx/V1dNl7a2RVZ2RNXo5pfdxReUe0lp+75KTvY/RoEunKaHVkTd
	+42wPrRto+jE5ACKledY1ZMYH2rjZxD6pm03JAeAGhWzedcXCHUAJI0IkBvJqxe3f1LzU/k2yQz
	Dq4/7k/B/egxKFV0dOHCWEjyZfuLczK+fAJyLTw==
X-Google-Smtp-Source: AGHT+IExADOTTgAs4pdlehx41o/HZWoMewbTcSoa8gDHsAPV2p0RvyXSubcT5QBZTFxP6p9x2sVexv1O8S7eEvFJAKw=
X-Received: by 2002:a25:e0d3:0:b0:dc7:51eb:36dc with SMTP id
 x202-20020a25e0d3000000b00dc751eb36dcmr2566819ybg.5.1707552340707; Sat, 10
 Feb 2024 00:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com> <20240205-b4-rbtree-v1-1-995e3eee38c0@google.com>
In-Reply-To: <20240205-b4-rbtree-v1-1-995e3eee38c0@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 10 Feb 2024 02:05:29 -0600
Message-ID: <CALNs47vgryKctpsP9EV_SsVF8TX8kfwzQ4KCLy9vr5FS_vBq6A@mail.gmail.com>
Subject: Re: [PATCH 1/6] rust: add `container_of!` macro
To: mattgilbride@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 9:50=E2=80=AFAM <mattgilbride@google.com> wrote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> This macro is used to obtain a pointer to an entire struct
> when given a pointer to a field in that struct.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> ---
>  rust/kernel/lib.rs | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 7ac39874aeac..c7963efd1318 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -102,3 +102,35 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
>      // SAFETY: FFI call.
>      unsafe { bindings::BUG() };
>  }
> +
> +/// Produces a pointer to an object from a pointer to one of its fields.

It is in the examples but a note would be good to make it obvious:

    ///
    /// This macro must be called from within an `unsafe { }` block.

> +/// # Safety
> +///
> +/// The pointer passed to this macro, and the pointer returned by this m=
acro, must both be in
> +/// bounds of the same allocation.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::container_of;
> +/// struct Test {
> +///     a: u64,
> +///     b: u32,
> +/// }
> +///
> +/// let test =3D Test { a: 10, b: 20 };
> +/// let b_ptr =3D &test.b;
> +/// // SAFETY: The pointer points at the `b` field of a `Test`, so the r=
esulting pointer will be
> +/// // in-bounds of the same allocation as `b_ptr`.
> +/// let test_alias =3D unsafe { container_of!(b_ptr, Test, b) };
> +/// assert!(core::ptr::eq(&test, test_alias));
> +/// ```
> +#[macro_export]
> +macro_rules! container_of {
> +    ($ptr:expr, $type:ty, $($f:tt)*) =3D> {{
> +        let ptr =3D $ptr as *const _ as *const u8;
> +        let offset: usize =3D ::core::mem::offset_of!($type, $($f)*);

`offset_of` will be stable in 1.77 BUT only for a single field [1]. I
don't know if there are other blockers in the kernel already, but if
this could be changed to call `offset_of!` recursively then  it will
work with the stable version.

We might want an `offset_of_many!(a, b, c)` macro somewhere if there
are other places that need this nesting.

[1]: https://github.com/rust-lang/rust/pull/118799

> +        ptr.sub(offset) as *const $type

Instead of casting to and from `u8`, you should be able to use `byte_sub`

> +    }}
> +}

- Trevor

