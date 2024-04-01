Return-Path: <linux-kernel+bounces-126977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC62A89454D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF291C21593
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE7B52F9B;
	Mon,  1 Apr 2024 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApYu8Bme"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF22F9DF;
	Mon,  1 Apr 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998644; cv=none; b=cbT/iiqQEaB+/yl8EzN5GIqnMH4XHoXeT0AmVKj0H2uCRRcpA+cWXbjiX9ar0+ytmd3vv6DZUZwjrfA07El2YWQiq6hMGKk5AZmHWGOZmtf1CTH61gDW5mTlBdBg+0/u4uAeF9TkRoNm4ah4AvhmZ7wDmR0KPWK56kHletGMIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998644; c=relaxed/simple;
	bh=EwvM5/ryYd5YhJT1IVG8bcrXkExi8AlkMA6UHPlNQYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCmAaVWGZVZRUiPzV2U1fnr3jFi/ustWJvNFj3/4zR0TNs96IJPGiykB2CnEXQiFVpROdchQOIjN9jNLrOsHAKqgB/t2ufgYEX1Hj8wIXCyJRS6oeUB3MiviCy3U69kzr4SRVGcKbgNApo0sGQ2teQ7EjEP4czihfzz9//B4W10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApYu8Bme; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc71031680so3991548276.2;
        Mon, 01 Apr 2024 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711998642; x=1712603442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNg9gkgBJslO2GtpUVVXE3k26E466KpxPLo9ZtxpaZY=;
        b=ApYu8BmeVO91iA5oJa7cbj/VAOng4MsjO3oLUP+jE0I0r2lyWASWfdy93mjle9Yk2O
         4ElD7yUkBB+gRYkmJSy07xXIDtGC7OPU4W86XBgoIXxxlLLWZoIXCmeszf9V/LhexxCd
         oltXBEoMcHWXcoWI+BpvcR9yruaB6M7DiQ7pqq38ZJ/IvNEBxWf2kdOBgncF9EK4zY4q
         rqR+jZeqxc1NLGo9EzFG7yfavoHyXZGRTyWnLHziul0pL6+oKNzmbfrESQ4n39eWaEdz
         L3O4Tx4eom+oPKJQJF9CDxUnqKL6DD9PWWo5ejsKj10jSqmKKtL8ouPBG+nB5qmSeByh
         NK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998642; x=1712603442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNg9gkgBJslO2GtpUVVXE3k26E466KpxPLo9ZtxpaZY=;
        b=Y22RzQo9YD2wf4Rcbyb6Pg0tC8d051Ei2JuJsVGHbHeHn+Wl0Op9MzGtZ4gVnOQQGv
         uGIAhGZec/Nk/XCcLR+Im2YUSdapD32UGgh+l5dO9jgud/r2kvOz4iT5FotjVxofQfrV
         TxOvbhSkNWkkCR/ysZwZ6C76w8nrWbdUb+a1PHRHIjfe9qliwqjkHQOqn2b8sZg0XZQQ
         jZaF3spNOIr3kQKE6pBEOqZ0+0zgbVYBhQmuMMylyfLAiFdoxxLrnxY94RHfOrZXTgwN
         3n58t/+wNtltxZgvSvEypTuDdPavemjOJgg00o78PjUDaxAvVDSQ/09qaLCT8R+o0Map
         Wv5w==
X-Forwarded-Encrypted: i=1; AJvYcCX4/SxwY2eS7YUMlVSLuIrTfcoIJIZDjs3f3NjAJC6NGKw8nKNHSp2eKYyyVULlxUkXiuTfdpxdtbgoJRzUuAr76zSVRQ8wp1YwK88fPJPf6tGhCxuH02jJGLw+iBoJe5b6pu8H2cBzjGMI5sZmoAflbD5Uv6QnXoK8HSPim4Z/C9GOJm0=
X-Gm-Message-State: AOJu0YxdbUHAzduzEijBHsT/VAL3om9lvfuKV7XviWu+1kazVCrt41Bp
	evOIfiYuYswj1I5iYsohCJxTA2G+TqPKbiiAKnCqcuzR3XsfIorxCaNDfW0xXSogyKZ4qkprakZ
	zqC7Z2LFZvs6YYhMUANjOImIdzkc=
X-Google-Smtp-Source: AGHT+IFdYWWHG46Y6Nw54sSzqw6L5V42K5FKzlzKf1jhP0Ob+er/o+L5Gl6FQpTes5ChjbyBKOwXA3VMGmVwE+tl0Zs=
X-Received: by 2002:a25:ba41:0:b0:dc6:d22e:ef4c with SMTP id
 z1-20020a25ba41000000b00dc6d22eef4cmr8698196ybj.17.1711998642045; Mon, 01 Apr
 2024 12:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160346.22442-1-benno.lossin@proton.me>
 <CANeycqp0o-HKBx6nuGCy9DD6mAwoGWzTR6bm5ceajsUhKcZuQg@mail.gmail.com> <d41d123e-d682-4685-88f5-e45567cc1975@proton.me>
In-Reply-To: <d41d123e-d682-4685-88f5-e45567cc1975@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 1 Apr 2024 16:10:31 -0300
Message-ID: <CANeycqr_AkxTj2iNdnjRFrC-C8npsBtS34V4hNy35RpQHszG9w@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: fix soundness issue in `module!` macro
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, 
	Sumera Priyadarsini <sylphrenadin@gmail.com>, Finn Behrens <me@kloenk.dev>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 Mar 2024 at 07:27, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 31.03.24 03:00, Wedson Almeida Filho wrote:
> > On Wed, 27 Mar 2024 at 13:04, Benno Lossin <benno.lossin@proton.me> wrote:
> >> +                    #[cfg(not(MODULE))]
> >> +                    #[doc(hidden)]
> >> +                    #[no_mangle]
> >> +                    pub extern \"C\" fn __{name}_exit() {{
> >> +                        __exit()
>
> I just noticed this should be wrapped in an `unsafe` block with a SAFETY
> comment. Will fix this in v2.
>
> >> +                    }}
> >>
> >> -            #[cfg(not(MODULE))]
> >> -            #[doc(hidden)]
> >> -            #[no_mangle]
> >> -            pub extern \"C\" fn __{name}_exit() {{
> >> -                __exit()
> >> -            }}
> >> +                    /// # Safety
> >> +                    ///
> >> +                    /// This function must
> >> +                    /// - only be called once,
> >> +                    /// - not be called concurrently with `__exit`.
> >
> > I don't think the second item is needed here, it really is a
> > requirement on `__exit`.
>
> Fixed.
>
> >
> >> +                    unsafe fn __init() -> core::ffi::c_int {{
> >> +                        match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
> >> +                            Ok(m) => {{
> >> +                                // SAFETY:
> >> +                                // no data race, since `__MOD` can only be accessed by this module and
> >> +                                // there only `__init` and `__exit` access it. These functions are only
> >> +                                // called once and `__exit` cannot be called before or during `__init`.
> >> +                                unsafe {{
> >> +                                    __MOD = Some(m);
> >> +                                }}
> >> +                                return 0;
> >> +                            }}
> >> +                            Err(e) => {{
> >> +                                return e.to_errno();
> >> +                            }}
> >> +                        }}
> >> +                    }}
> >>
> >> -            fn __init() -> core::ffi::c_int {{
> >> -                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
> >> -                    Ok(m) => {{
> >> +                    /// # Safety
> >> +                    ///
> >> +                    /// This function must
> >> +                    /// - only be called once,
> >> +                    /// - be called after `__init`,
> >> +                    /// - not be called concurrently with `__init`.
> >
> > The second item is incomplete: it must be called after `__init` *succeeds*.
>
> Indeed.
>
> >
> > With that added (which is a different precondition), I think the third
> > item can be dropped because if you have to wait to see whether
> > `__init` succeeded or failed before you can call `__exit`, then
> > certainly you cannot call it concurrently with `__init`.
>
> I would love to drop that requirement, but I am not sure we can. With
> that requirement, I wanted to ensure that no data race on `__MOD` can
> happen. If you need to verify that `__init` succeeded, one might think
> that it is not possible to call `__exit` such that a data race occurs,
> but I think it could theoretically be done if the concrete `Module`
> implementation never failed.

I see. If you're concerned about compiler reordering, then we need
compiler barriers.

> Do you have any suggestion for what I could add to the "be called after
> `__init` was called and returned `0`" requirement to make a data race
> impossible?

If you're concerned with reordering from the processor as well, then
we need cpu barriers. You'd have to say that the cpu/thread executing
`__init` must have a release barrier after `__init` completes, and the
thread/cpu doing `__exit` must have an acquire barrier before starting
`__exit`.

But I'm not sure we need to go that far. Mostly because C is going to
guarantee that ordering for us, so I'd say we can just omit this or
perhaps say "This function must only be called from the exit module
implementation".

> --
> Cheers,
> Benno
>
> >
> >> +                    unsafe fn __exit() {{
> >> +                        // SAFETY:
> >> +                        // no data race, since `__MOD` can only be accessed by this module and there
> >> +                        // only `__init` and `__exit` access it. These functions are only called once
> >> +                        // and `__init` was already called.
> >>                           unsafe {{
> >> -                            __MOD = Some(m);
> >> +                            // Invokes `drop()` on `__MOD`, which should be used for cleanup.
> >> +                            __MOD = None;
> >>                           }}
> >> -                        return 0;
> >>                       }}
> >> -                    Err(e) => {{
> >> -                        return e.to_errno();
> >> -                    }}
> >> -                }}
> >> -            }}
> >>
> >> -            fn __exit() {{
> >> -                unsafe {{
> >> -                    // Invokes `drop()` on `__MOD`, which should be used for cleanup.
> >> -                    __MOD = None;
> >> +                    {modinfo}
> >>                   }}
> >>               }}
> >> -
> >> -            {modinfo}
> >>           ",
> >>           type_ = info.type_,
> >>           name = info.name,
> >>
> >> base-commit: 4cece764965020c22cff7665b18a012006359095
> >> --
> >> 2.44.0
> >>
> >>
>

