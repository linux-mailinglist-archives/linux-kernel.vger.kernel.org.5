Return-Path: <linux-kernel+bounces-38877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731283C7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E2B295100
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70707129A71;
	Thu, 25 Jan 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjxtG7oB"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1B6EB57
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199327; cv=none; b=qXsEfsnDjPJ4ktN/rz8o6zunVWP3UjNAsGHVWkwXTCQcUoKYpgKSyFIg61MdelDTBhpwm7uaFpuXFk9vztboozqVFUoT2dXuVPnKkS7/CAvV4txv8lzg9/nKWZX3Knm3WeDVn9gqDxxqHsO3AeKhYVv8uJ22wt6Gw0G0Tyw1lyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199327; c=relaxed/simple;
	bh=PMOq6b74OsAKYyIq+lnlaB8rWPhr1y7hF5VaJVdA2BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3rAV9dIy1rYKWG8TzYj13LafWRLZmPNPXVDajYdouG/oidv66yVaITqMg4iKA7VFjFwEkqUbaukTXdYWiiLT4bhIZ+RFQNpa9C+v+KMYXcrbwgVU9D+/P3OB4PMylDJAk2lNcQRu5nQI+VAAnSytBn8+KhKIrwdv5YwGX1e4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjxtG7oB; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4bd3dcee54eso511874e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706199325; x=1706804125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lk63POKR0f1uaiQp+rL8Q768TeeIp8icZEI1dRCPmo=;
        b=sjxtG7oBriMA2BibP1+j7Tr3TQsGiu9IOM5dYxu3vF/6JRkqCIMZZhn6+aKRHbrucD
         DQDc1H3sqSscKKXyzAUWAxKNeHvQxW2SUFqeqtEWCHhwx982sH5MJa/GEQUmqqnyKjnF
         3PwV/qIQriJVMl8Ftvrog4ATbNaP3U+5Jrzybz/6GAQJee390ycRRQiSBJDWWfx6RozN
         SGXW3N9QT+fnHUAjjt+3Ea8xg3uuDQ/zrS1loXiNvUziA+O1vlcr13OjUSzjDUN/6Jqx
         QVP9mCVb0ljaPkF2/8naiahBmjoXpR3eTqpyFCvJUq25vb0trG/s3h0Vqjfl+sf0fXdn
         2k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199325; x=1706804125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lk63POKR0f1uaiQp+rL8Q768TeeIp8icZEI1dRCPmo=;
        b=AFDxhhkNYPu87guD4tr6z7a9QZvxC3bDyJylP43ao18432vm7Xi9v6OLUhzKCVsK8b
         PpykdzdrTdvdUI3MqwqLSM0yiykfZD64rR2g252AwyKRXX8+phTDvzZJSecHcYLWESbG
         8QlLGjlXuUH1IypLTNIBXrxt0kQu24zMwqHCsRSi3lGRmiU7y+y37W6MHgvjZ1tHOLDm
         M2/jK66nSbrQPAKJpGhnpHZQtlzZSDRmZDLNQ1AMVASQ/xIuKPUxbPdWhZ3deA1wAH+B
         QeN5LNa+riCeY+sCyIE9SCoOo2CvMnr9RxyRzj2WVbcDr/K6GRwRFONLM+V64DFijC68
         yf+w==
X-Gm-Message-State: AOJu0Yxnk7gw0vayOCyDc3Tj1a8tcn1/beZ7yXfYCUDuRfRgS8bAJKcr
	BWwcUQ8ws4MFrHc2DGzOaKQDCzTzGJX6LYY0/rmSOmp7k1gd1NN4YhePzHAPizc1wOj4TrdLOhU
	YuGsfCotlIjHtDzpUqJyH+Vg/NUPWcTmHCtsA
X-Google-Smtp-Source: AGHT+IGA0K3UOZ9HMIN8oAo3K16wYrzxN3UKybeNfpxPpUsyncL2OiiQaWS9A2aKFqJK++AqLpBtQOygJxuD+f+XbDo=
X-Received: by 2002:a05:6122:1807:b0:4bd:2957:2620 with SMTP id
 ay7-20020a056122180700b004bd29572620mr46434vkb.13.1706199324648; Thu, 25 Jan
 2024 08:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-2-d1abcec83c44@google.com> <070574cb-8d7f-4fe7-9826-cec6110168ff@app.fastmail.com>
 <CAH5fLgi8D18ufma0X49nWhXpnz47t-C=OAtM+wwnYu78hEnwhA@mail.gmail.com> <e69f9b43-39cd-469d-94db-140504df0833@app.fastmail.com>
In-Reply-To: <e69f9b43-39cd-469d-94db-140504df0833@app.fastmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 25 Jan 2024 17:15:13 +0100
Message-ID: <CAH5fLghn2=Y-M-M7-17PhNvKN3qVTsa6wh=Df770kHj1Oxh8hQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: add typed accessors for userspace pointers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:00=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Jan 25, 2024, at 13:37, Alice Ryhl wrote:
> > On Thu, Jan 25, 2024 at 1:27=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Wed, Jan 24, 2024, at 12:20, Alice Ryhl wrote:
>
> >> > +EXPORT_SYMBOL_GPL(rust_helper_copy_to_user_unsafe_skip_check_object=
_size);
> >>
> >> These functions are almost identical to the ones in
> >> lib/usercopy.c for !defined(INLINE_COPY_TO_USER).
> >>
> >> That version has an extra memset() after a partial
> >> copy_from_user(), and you probably want to have the
> >> same thing here for consistency.
> >>
> >> I think ideally we should only have one out-of-line copy
> >> of these two functions and have that one shared between
> >> rust and architectures that want the C version out of line
> >> as well.
> >
> > I had a bit of trouble figuring out all of the copy_[to/from]_user
> > methods that are available. I was hoping that a better solution would
> > be available, and it sounds like one is. Is _copy_from_user always
> > available as an exported symbol? If it's always available and skips
> > the check, then I can just use that. I don't think the memset matters
> > for my case.
>
> At the moment, it appears that it's available on the few architectures
> that don't #define INLINE_COPY_FROM_USER: alpha, csky, powerpc,
> riscv and x86. On the other architectures it is always an inline
> function.
>
> > Otherwise, I can add a helper in rust/helpers.c that wraps
> > _copy_from_user only when INLINE_COPY_FROM_USER is defined, and call
> > the helper in those cases, and otherwise call the exported symbol
> > directly. (I need an exported symbol to call into C from Rust.)
> >
> > Would that make sense?
>
> I don't think we can have a perfect abstraction here, but rather
> than putting knowledge of INLINE_COPY_FROM_USER into the rust
> wrapper, I would suggest putting a bit of information about
> rust into lib/usercopy.c.
>
> I've tried to come up with an idea below, see if that works
> for you.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 3064314f4832..835aa175d0ee 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -138,13 +138,18 @@ __copy_to_user(void __user *to, const void *from, u=
nsigned long n)
>         return raw_copy_to_user(to, from, n);
>  }
>
> -#ifdef INLINE_COPY_FROM_USER
>  static inline __must_check unsigned long
> -_copy_from_user(void *to, const void __user *from, unsigned long n)
> +_inline_copy_from_user(void *to, const void __user *from, unsigned long =
n)
>  {
>         unsigned long res =3D n;
>         might_fault();
>         if (!should_fail_usercopy() && likely(access_ok(from, n))) {
> +               /*
> +                * Ensure that bad access_ok() speculation will not
> +                * lead to nasty side effects *after* the copy is
> +                * finished:
> +                */
> +               barrier_nospec();
>                 instrument_copy_from_user_before(to, from, n);
>                 res =3D raw_copy_from_user(to, from, n);
>                 instrument_copy_from_user_after(to, from, n, res);
> @@ -153,14 +158,11 @@ _copy_from_user(void *to, const void __user *from, =
unsigned long n)
>                 memset(to + (n - res), 0, res);
>         return res;
>  }
> -#else
>  extern __must_check unsigned long
>  _copy_from_user(void *, const void __user *, unsigned long);
> -#endif
>
> -#ifdef INLINE_COPY_TO_USER
>  static inline __must_check unsigned long
> -_copy_to_user(void __user *to, const void *from, unsigned long n)
> +_inline_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
>         might_fault();
>         if (should_fail_usercopy())
> @@ -171,25 +173,32 @@ _copy_to_user(void __user *to, const void *from, un=
signed long n)
>         }
>         return n;
>  }
> -#else
>  extern __must_check unsigned long
>  _copy_to_user(void __user *, const void *, unsigned long);
> -#endif
>
>  static __always_inline unsigned long __must_check
>  copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -       if (check_copy_size(to, n, false))
> -               n =3D _copy_from_user(to, from, n);
> -       return n;
> +       if (!check_copy_size(to, n, false))
> +               return n;
> +#ifdef INLINE_COPY_FROM_USER
> +       return _inline_copy_from_user(to, from, n);
> +#else
> +       return _copy_from_user(to, from, n);
> +#endif
>  }
>
>  static __always_inline unsigned long __must_check
>  copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -       if (check_copy_size(from, n, true))
> -               n =3D _copy_to_user(to, from, n);
> -       return n;
> +       if (!check_copy_size(from, n, true))
> +               return n;
> +
> +#ifdef INLINE_COPY_TO_USER
> +       return _inline_copy_to_user(to, from, n);
> +#else
> +       return _copy_to_user(to, from, n);
> +#endif
>  }
>
>  #ifndef copy_mc_to_kernel
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index d29fe29c6849..503a064d79e2 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -7,40 +7,18 @@
>
>  /* out-of-line parts */
>
> -#ifndef INLINE_COPY_FROM_USER
> +#if !defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)
>  unsigned long _copy_from_user(void *to, const void __user *from, unsigne=
d long n)
>  {
> -       unsigned long res =3D n;
> -       might_fault();
> -       if (!should_fail_usercopy() && likely(access_ok(from, n))) {
> -               /*
> -                * Ensure that bad access_ok() speculation will not
> -                * lead to nasty side effects *after* the copy is
> -                * finished:
> -                */
> -               barrier_nospec();
> -               instrument_copy_from_user_before(to, from, n);
> -               res =3D raw_copy_from_user(to, from, n);
> -               instrument_copy_from_user_after(to, from, n, res);
> -       }
> -       if (unlikely(res))
> -               memset(to + (n - res), 0, res);
> -       return res;
> +       return _inline_copy_from_user(to, from, n);
>  }
>  EXPORT_SYMBOL(_copy_from_user);
>  #endif
>
> -#ifndef INLINE_COPY_TO_USER
> +#if !defined(INLINE_COPY_TO_USER) || defined(CONFIG_RUST)
>  unsigned long _copy_to_user(void __user *to, const void *from, unsigned =
long n)
>  {
> -       might_fault();
> -       if (should_fail_usercopy())
> -               return n;
> -       if (likely(access_ok(to, n))) {
> -               instrument_copy_to_user(to, from, n);
> -               n =3D raw_copy_to_user(to, from, n);
> -       }
> -       return n;
> +       return _inline_copy_to_user(to, from, n);
>  }
>  EXPORT_SYMBOL(_copy_to_user);
>  #endif

Sure, if that's okay with you, then I'm happy to do it that way in v2.

Thank you!
Alice

