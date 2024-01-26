Return-Path: <linux-kernel+bounces-40095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5996D83DA39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE922891CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864291947E;
	Fri, 26 Jan 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciNgwp8s"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA214288
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272439; cv=none; b=kcUwpchxVq9+nd1kmD0SVvIypIsJZE1IGSDpd9tlqmjxpAG+w4W9zu9MD/DXNKBdR76zeiOIvz+InfF+bvYrMOwssMRkrarIuDoU3jOt/utVzVn6MeUvFQ9LOnTis3HRRKg0tJapbfv+BZiBaOYzBDR47PVc4lVDxWaz6RFXnrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272439; c=relaxed/simple;
	bh=4m99W9RcPeeWbt8DFEWQI2sp/PfyobyGjckKTyyGec4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJWwpdieUi6awf7vBSixIHBcTcm2HMN7veC0b1IMSx24yvmGdfMwA+T5byuIiAEbW+uK4WcR6W104optuOBa7jhMGcQkAonlabg3lt4bVtQqTfkYMMfPa+WgSHvFaD3sKMhG2pCL+gtMPH9t+Fr6JWrOYtHxDTk+T0rQvfwnFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciNgwp8s; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4676a37e2c4so84653137.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 04:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706272437; x=1706877237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UqArqULVidH7ROM7QOynYR0nvQSPMOUC/XDGfU+9xg=;
        b=ciNgwp8sroWZ8vcx6ilBXJVZMMl1A7d/fA6LoOetvf4Hnxzof7UigiSb0HwHdZP5lP
         /mo29IlxvGuFpYTdcSDEVoWfGnfTIPYQcr1aEsaHq26F7J1YOEk6JBxwGLzkGLELtOVh
         OfSh+013KV0az6vxbyOlOHWaqnB7Ga9E9533BuQQJdw2Yr3a5vbgLf3e7VEImPTU5GET
         nZw8M10Cx+cFWiM4Soi+F1uj0wfWlk5/i/0PoavMfheSbBuNdorZoW8xbxBbweX+qp9w
         cBMOUTgwTZxsOHwAShRzKafRX9w5YpqP1r/F/8UY0gUdY5U6f/AfGT9GzIY9fLKHztdP
         HX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706272437; x=1706877237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UqArqULVidH7ROM7QOynYR0nvQSPMOUC/XDGfU+9xg=;
        b=HNDS1CNA50W0vUcj6CB4sZivZB05LfkwszAFeadx3sIBEmYxXXXAB1rw69X+P5DmcX
         bFv2bZrEyM7acx2PeVbc9KTZD5M3+9KzYFpS0lsM3pR0WzyosN4/RvZgVZrMuQ4WfikL
         9xb57LQCKrvqalz3ez+HELPAfwEGdzwufA/G3n/QiEl9vUwrMKacWvJPHnMbOOtX0Hhn
         OW9NY4gB4LlUF0Jr5beb4otKSl+pvJjP1Rfu4RMZP5nbijyDtOHMdcvh1XhJaWDOTWGJ
         zcyHV/3yAvUe72gVirEipqLcphVBEfIY3ZislTlNN4FzAQTn2PknSuIVbYZX8OCNec6Y
         psWw==
X-Gm-Message-State: AOJu0YxNPn3Gt8p8MjRftqpoCtxQWoDNRCaUPGGzaVG51uz0++JNJDER
	2pR/1uLVwvjlrLxlmKVnbN6LzN/EQMiZac0nHgRMwbF1ZrannrYBoX+2ARQY0sDgfC+/r17NKkZ
	ZpiF+af2G3VsLDFsYrtNpH8IutWQlP/i5t9no
X-Google-Smtp-Source: AGHT+IGd62n+2RxpM3PIhY6cym3GnlSNkz7sZpZK5qZcCreUyKwry0eMpuKUCEZGpL8I0eVhgGC860sdXzu9+PQOL0A=
X-Received: by 2002:a05:6122:2a07:b0:4b6:e71d:362d with SMTP id
 fw7-20020a0561222a0700b004b6e71d362dmr862145vkb.18.1706272437051; Fri, 26 Jan
 2024 04:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com> <ZbMA1yiM6Bqv9Sqg@boqun-archlinux>
In-Reply-To: <ZbMA1yiM6Bqv9Sqg@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 26 Jan 2024 13:33:46 +0100
Message-ID: <CAH5fLgiNphSebaG82XkQHGFPFp1Mf1egyaiX6MFzsU2X3-Ni8w@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Fri, Jan 26, 2024 at 1:47=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
> > +    /// Maps the page and reads from it into the given buffer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `dest` is valid for writing `len` byt=
es.
> > +    pub unsafe fn read(&self, dest: *mut u8, offset: usize, len: usize=
) -> Result {
> > +        self.with_pointer_into_page(offset, len, move |from_ptr| {
> > +            // SAFETY: If `with_pointer_into_page` calls into this clo=
sure, then
> > +            // it has performed a bounds check and guarantees that `fr=
om_ptr` is
> > +            // valid for `len` bytes.
> > +            unsafe { ptr::copy(from_ptr, dest, len) };
> > +            Ok(())
> > +        })
> > +    }
> > +
> > +    /// Maps the page and writes into it from the given buffer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `src` is valid for reading `len` byte=
s.
> > +    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usi=
ze) -> Result {
>
> Use a slice like type as `src` maybe? Then the function can be safe:
>
>         pub fn write<S: AsRef<[u8]>>(&self, src: S, offset: usize) -> Res=
ult
>
> Besides, since `Page` impl `Sync`, shouldn't this `write` and the
> `fill_zero` be a `&mut self` function? Or make them both `unsafe`
> because of potential race and add some safety requirement?

Ideally, we don't want data races with these methods to be UB. They
could be mapped into the address space of a userspace process.

Alice

