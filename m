Return-Path: <linux-kernel+bounces-58215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E63F84E2E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163262812AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244D67994E;
	Thu,  8 Feb 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUVlWNXx"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93E78B74
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401582; cv=none; b=Y2iWSz3IS1Vm4wlNjjMEKCIPknQjJQhKQ04THV4gqNTjdhT2/ZXgORxMf1ivjA7w7uATW28ZiiItegp4gNf1zUhDcaf5b2c88q+tb+JOp6Qil9ZkDAAUCbWb64I93O8imr4lTFLFp8GB7bTE+nPuzi8YDnb6F0e8tE6yvC4a45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401582; c=relaxed/simple;
	bh=8FiXcO4YBknM68MAy2XQmn2iOGYzS66hc6OBpR3Wb+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfSTAAZXNlNjuB5cChA3Jxmzz5Xc1lO+c/z0f8bQwclGxbA3ydtNn589sTc0XM/0ISp6O+nvY/LQ5z8APYAhjPUzYMqPd161adKmeIMP6Z3AdywH3K9U/eaCOArFI2qjEtkj5KY8yadTmN0hKjW3LXgrZDftEpbh0/U/lhGQeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZUVlWNXx; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c02af5c0b6so595965e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 06:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401579; x=1708006379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63xtu4Y51K1k0XIMtdvcGVsuDCjTkj9dOeWaIMHJ3Ac=;
        b=ZUVlWNXxWZ5HpgLsTPJI+O7Kbg4aM/MN2132VyxLoKtUX8wv0hI70sAiPqV7epD3dZ
         TY/A3YrPth+HXVM7MVv2HZY2uwoRLvYZ2qDNz1QVX5jWbfzMflIrLWEb42lu9k7PCfhX
         Dpq9s9umsblL4rVnY2ARvjW9PXhnXWchoXwYDfaKSL8X4lr3U0hJqUmlvojOTKB+pUUT
         EuFqfL5+euPkqoP74AMrj2vTr69tzsYkIXD4sYLhIPmzi0EmPZ4dL914ickqDgF67Szy
         yh/SjLJsXRTGdchKb44TNCQ22R0YnXWORwDlnvQ92DntVQ3pqegkel0kjRQFNyGy01BB
         luNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401579; x=1708006379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63xtu4Y51K1k0XIMtdvcGVsuDCjTkj9dOeWaIMHJ3Ac=;
        b=B6ohZbCAUduSyoTjW7M0uYlxHUO70FmNU4z/2dDQAQpgNCV3u6fz8K/iDNrVXJW+kM
         hbdfvRZM4CM1KuwoBbNkrJbv32vpry7dg17nV3lY8HIe9L+yOBt06/AfkSAd+chrOXL+
         r8P1Q5+qTYZf5UdsMzFJDPdmx/bsV5rSeMgLCOqM6W898uFQ10MCA8D4T05DO+5lD8go
         ooE8MdKfOGlvJhelqnUeaxI55VhOxz93D+/EIjdrfT61iu4YyMwZoUzbwhEPw44ssvTK
         rzLnO0EBcRxYyt/eSDUAsjd4JsV649fb+A6WJwx/3G6ECMhlFI5JhrGLVxK2stV5yP3Y
         0SMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIAGtkNFkSCxqN4jV8AdsVvLXBuBM66z5RpJaEhNoB/bSggIKYe1SLcEMUWRrzjoC3D8f7ytupisqG4YSaePGvqrWV8S0+J2X5t2rO
X-Gm-Message-State: AOJu0YyIBrnQkMaIlys3zI0MrXvKJvZxNZr2W9unVlfY+1PsZCuJVExL
	iiSnBlC0rk8UD4X/X9cgG24hL9zw+PbH56pNesyhj3jDGeyn6OY9WR9W3cKZOdTbm4SwGbD0YfW
	YdJcudtouxW/FyYy2AGQRRwT/jRU6mi8bMS7y
X-Google-Smtp-Source: AGHT+IHRIxDWiY+hO499KIfcBiMXI8uEupmgp58zOyTpKkSFIk9pRhRbYoq93ffdSlLJEAko4To9vrwuCPD358UY1FA=
X-Received: by 2002:a05:6122:268d:b0:4bf:d147:63c1 with SMTP id
 eh13-20020a056122268d00b004bfd14763c1mr5938308vkb.6.1707401579571; Thu, 08
 Feb 2024 06:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com> <CALNs47uPgvYXxEDmwb6GKa+cw597_rDD1zaSPDa9k9D-6_qZxQ@mail.gmail.com>
 <CGME20240208134629eucas1p2edf4cb1e50e3bb578297c33b79701574@eucas1p2.samsung.com>
 <CAH5fLgi_iU3nDE-gJ56s8CPznWvC0T4P5M0dVx1zO61kmVGNgQ@mail.gmail.com> <87v86zrr45.fsf@samsung.com>
In-Reply-To: <87v86zrr45.fsf@samsung.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 15:12:48 +0100
Message-ID: <CAH5fLgh2mqX7O=xWN6=wyd_4=_R63Ko-wh0bb=rXvLrrj=W-pw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
To: Andreas Hindborg <a.hindborg@samsung.com>
Cc: Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Kees Cook <keescook@chromium.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:02=E2=80=AFPM Andreas Hindborg <a.hindborg@samsung=
com> wrote:
>
>
> Alice Ryhl <aliceryhl@google.com> writes:
>
> > On Thu, Feb 1, 2024 at 7:02=E2=80=AFAM Trevor Gross <tmgross@umich.edu>=
 wrote:
> >>
> >> On Wed, Jan 24, 2024 at 6:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> >> > +/// A pointer to a page that owns the page allocation.
> >> > +///
> >> > +/// # Invariants
> >> > +///
> >> > +/// The pointer points at a page, and has ownership over the page.
> >> > +pub struct Page {
> >> > +    page: NonNull<bindings::page>,
> >> > +}
> >>
> >> Shouldn't this be UnsafeCell / Opaque? Since `struct page` contains lo=
cks.
> >
> > That only matters when we use a reference. Here, it's behind a raw poin=
ter.
>
> Why is it behind a pointer rather than being transparent over
> `Opaque<bindings::page>` and using a `&Page` instead?

Because `&Page` would not have ownership of the page, but I need
ownership. We also can't use `ARef<Page>` because that has a `clone`
method.

One could introduce an Owned smart pointer and use `Owned<Page>`, but
I think that is out of scope for this patchset.

Alice

