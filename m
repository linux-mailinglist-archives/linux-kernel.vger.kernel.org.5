Return-Path: <linux-kernel+bounces-150600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F4F8AA179
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14332863E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FA5176FD8;
	Thu, 18 Apr 2024 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="UWbM272w"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829401442F4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462746; cv=none; b=R1eWrxZHBo8QCzzHHIFk6oeOZNkclOEXvKRszHHDKUR6sJf94SOy4huzeUffYyQ5iVX0CPouzX6nVc8jy4Crqu5svY4ar7guC7bLx+FZtyYI93BsMOqga6HUZqF4NpelaYhGVwJA21xZE7GjS4m6+L5l/0e4dUZyL1F+yB4hGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462746; c=relaxed/simple;
	bh=6Qed5vhGTcz1STV7H9fAkWDWQkTCrI3P/ws6hdROluw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cL0Ar5ucOhdxbRmmTy9fLjMJKK9y6XXUp1xiMFfQnPmFUEj6EHwUWOjs4l0FuQF5zrShFdv1QdOe5q9vyCLT9tdsGuXQYwoWggW8rfAkch90QSKxDV30NymcqaBVVl/LbK+zrX/A2f5Kvw+JUru7MOpGQ1eC38TGb+LuSEagA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=UWbM272w; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc236729a2bso1290879276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1713462743; x=1714067543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fezWjsLogxXqyEuKKr9Hy9rCs7/m/0D7LZfJ5JnAum0=;
        b=UWbM272wKEru3SvTEgnLznGYhaaYuAhPDatXjQl1zOt6D6O8oDl7cvbRKNvzwfWOvg
         nDPQ408o4fZe9prdIOvJiP2HhjRtNT8+tN3T9j63+rPfCmcq2HYb2c1AL4op/F5ykv/v
         B/Oqz7xy+Et+Mso5/TKbyNrZnn4R+48Ba2Cb4mV6UkDWXEvnohssQMN0JNKXxbnAwjU0
         e5rbAHxpKbmCn5MmIpH/A0SeCbmyp27te79kmS15tCZlke629ASvZO40I6os41UYtl1A
         7KC0gp6L0WyMW47ow9+lc1WH5p48q5aN8/xGzoHvvdg7EycSaVkCBcgxIB1UpMaVvazm
         7a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462743; x=1714067543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fezWjsLogxXqyEuKKr9Hy9rCs7/m/0D7LZfJ5JnAum0=;
        b=lW9uRdFnE6ivLeeK2EvfVFSYIQZ5fjeU69U55IrF18jVZzQordQJWn+geqxGof9BC8
         DfKcGxXpo77XaPms/1UG7T5JQOTUzDv+mHIlSw3nLkAeFoiWXFnPqnHqx2odrfRKt25X
         StIsbWjy4IZLsczG0Y5cUV66anIVP8BujgpoiC2BON1eKs8/DX/aiDEo5Kra3NlfO0z9
         WCwk8JYJSBWn4giD1lFG3eouYDL8aVv5G04foY2x1k6oZ8X+BXavWEmziBPp6qjsS4hT
         fdGADMtWOlTkGTz0fvHOvYWujKT4/S+9rqaNT56yVQF01wbxEOGCHaZDB66Kf788yELs
         p1dw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Tho6nv8kJQhTUIbzN996+Bnnlxy3gLRSYQEEDdl6KNO2UGUEjeLTHYeW7HC9qV9EPkYEZeWJWvs2r/F1RIkDpGUdNmW9cIMhgtNk
X-Gm-Message-State: AOJu0Ywd08UPvu2MZPjNuceLFkz3tjTvDEaO4oNqrLyZ/e1PVWoptYWk
	NI2nCtFHnJngR2GLdU2N/10a3+e4RkGyVDifynZege/KosOGZrVT3pSeaWPFsY88TqA+r0v72Ti
	8rYD40Bx/500dsG1Cqn9d7XtKbEG7ArZFwYHc2Q==
X-Google-Smtp-Source: AGHT+IHLIxLV6AmwYctLpvdfNF/hPmIXNgahPf3Z+946bF20hsA3skulNWrlmiOhkxE68LjMsdpOYru+qXDZ9OIWRJE=
X-Received: by 2002:a25:8586:0:b0:dc6:4d0c:e9de with SMTP id
 x6-20020a258586000000b00dc64d0ce9demr4057848ybk.0.1713462743430; Thu, 18 Apr
 2024 10:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com> <5fd684d8-d46d-4009-bcf8-134dab342322@proton.me>
In-Reply-To: <5fd684d8-d46d-4009-bcf8-134dab342322@proton.me>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 18 Apr 2024 13:52:12 -0400
Message-ID: <CALNs47tJyrnmp-5AXs2mHU=JKC5ibHnn+Soy4U95NziRoc4z4Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] rust: uaccess: add typed accessors for userspace pointers
To: Benno Lossin <benno.lossin@proton.me>, Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:03=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 18.04.24 10:59, Alice Ryhl wrote:
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index 8fad61268465..9c57c6c75553 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -409,3 +409,67 @@ pub enum Either<L, R> {
> >      /// Constructs an instance of [`Either`] containing a value of typ=
e `R`.
> >      Right(R),
> >  }
> > +
> > +/// Types for which any bit pattern is valid.
> > +///
> > +/// Not all types are valid for all values. For example, a `bool` must=
 be either zero or one, so
> > +/// reading arbitrary bytes into something that contains a `bool` is n=
ot okay.
> > +///
> > +/// It's okay for the type to have padding, as initializing those byte=
s has no effect.
> > +///
> > +/// # Safety
> > +///
> > +/// All bit-patterns must be valid for this type. This type must not h=
ave interior mutability.
>
> What is the reason for disallowing interior mutability here? I agree
> that it is necessary for `AsBytes`, but I don't think we need it here.
> For example it is fine to convert `u8` to `UnsafeCell<u8>`. Niches also
> should not be a problem, since eg `Option<UnsafeCell<NonNull<u8>>>`
> already fails the "All bit-patterns must be valid for this type".
>
> --
> Cheers,
> Benno
>
> > +pub unsafe trait FromBytes {}

See also the reasoning in zerocopy [1] and bytemuck [2]

[1]: https://docs.rs/zerocopy/latest/zerocopy/derive.FromBytes.html#analysi=
s
[2]: https://docs.rs/bytemuck/latest/bytemuck/trait.AnyBitPattern.html#safe=
ty

