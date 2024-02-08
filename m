Return-Path: <linux-kernel+bounces-58159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB63184E20D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310AEB212AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABFB6E2CB;
	Thu,  8 Feb 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKwmC7YX"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EDD6F097
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399412; cv=none; b=fyYyHbypW6eiF9rh8K02tMeA08Qp5cxse8fBTEkE+PUqHgStot8thUAiLK8YE4GZ0+D54JPRq1MnYu3GN1pqDJ9oGnEOG56Swgs03X2lG5XXmHvwyvJi/8AUDK7UFPq57aPRFxJArqndNX1eYg8lzqKQBo5ckRFkHGgtkHOsszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399412; c=relaxed/simple;
	bh=J2YJPekikVaCmqI0KXV0F0E6DUM9ftaGqx+AFjmHblA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXbpZRJI6QYv+V7z2XssInmPDZNgYGU8ErxKim3zkAZNK0jYkHjiR/14THq3pXmQxt4XT1PixpV4Dh+vdDZgUuLKOjou+/vSHx89W8BleEcbgO2R2ZgUFJjTX0nLAKT4HiXSfu1BzwPXC0sinKUjKK65k+kIKNZbD6zkhcGNg3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tKwmC7YX; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7ce603b9051so726093241.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707399410; x=1708004210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn/V3vxoIjIUSC8M3Y2S4b8UAF5QxV/6wcQ3800sVJE=;
        b=tKwmC7YXP1Y8YTo7bUND3f1dhw02PJxnwaeftM9a++O4D6Tk5NnrbJvun+9lDNeEC5
         /P6ELx1a3U/W/pRsDUWp9MaXkPn3We1tCouNJaCfTTu3FepntxvbBaGhI0lkd4VYLme0
         czkcM1YA3MN2aPIOrn4AlWSkC3M6Coa7D+dxsaixZdkBk1YpLcvkf16l9Ao1SDd0WoZu
         hKz8Lm6ukv54027RdtaqRn7+NKL1Y8/SVGDgMtvYgMz7ZoVyW/VrnrD5vkwjbcusExEY
         z6fmttZGwY4P0UsEyqhEJeQo4wFQ4QffPjmd400NNAHxLtShEWnt3PqMu+u1KPK41cVi
         DGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399410; x=1708004210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn/V3vxoIjIUSC8M3Y2S4b8UAF5QxV/6wcQ3800sVJE=;
        b=qwO2OVYh6QyECMtd86JjP/DVe7m36+YBFeli514ft0Lojl7W73wayS4Jk2VCBvQAc0
         NaaBya4l4MPLRjcFelMZPBbK6mloJzQsHGyjvQ0wJxRrwzElLMh7cgoHaqRQAJYAr/Hp
         N5PeHzs0+BnuPVQoOaH8YpPkDEv3sAW6G7TzimdHz+sWBm9mrp1fm9+qHTJCvain6BeX
         TmgzIYjv+VHfEG+6kJS6cthZ0DEOCnGaXG1a8yk7N8eu7E4CAKsmQJnuSIyt2P/z1p9/
         iC48m4wC2SlFe/TqlryvP+i86NzKXMXAayx8Cex+2kx9ydy+W3UVL88O+7ybmK+Ca5Mp
         Lpvw==
X-Gm-Message-State: AOJu0Yx3JtiDiMnEKSwTW/BFHOt52ew6rFH8AaMQp8E+UFTp0Ggfini5
	qAsxadKcsT49CDvMHRrx1FlO0zxEwAjqdUJBhdH3OY79AEtYqWQSuvQwT10UR3dG/joWAUDFmgE
	ITRGCTLRXA0cl2Z4kMolOEgzOfpC6uSie5Sp6
X-Google-Smtp-Source: AGHT+IF9Fvq5IrgEGgEG+1r7dMwVzweHbYqlYapUQEoUpjqP9B/NinoiHrV94HMpa24eTruhWvgZvbZdVK8ImcRm0vM=
X-Received: by 2002:a05:6102:a05:b0:46d:2a90:f8ce with SMTP id
 t5-20020a0561020a0500b0046d2a90f8cemr5223903vsa.28.1707399409792; Thu, 08 Feb
 2024 05:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com> <ZbMA1yiM6Bqv9Sqg@boqun-archlinux>
 <CAH5fLgiNphSebaG82XkQHGFPFp1Mf1egyaiX6MFzsU2X3-Ni8w@mail.gmail.com>
 <ZbP50nEIMqULfVuj@Boquns-Mac-mini.home> <CALNs47uy5rQ15wByzQA0_YzORM0nTFdi9-TvwyC4+ZTXVQBj4g@mail.gmail.com>
In-Reply-To: <CALNs47uy5rQ15wByzQA0_YzORM0nTFdi9-TvwyC4+ZTXVQBj4g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 14:36:38 +0100
Message-ID: <CAH5fLggA1MxtR-H5454X_mkQW-E=ZHnE6iYbbLyXGzp6wg5kDQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
To: Trevor Gross <tmgross@umich.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Kees Cook <keescook@chromium.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:51=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wro=
te:
>
> On Fri, Jan 26, 2024 at 1:28=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com>=
 wrote:
> >
> > On Fri, Jan 26, 2024 at 01:33:46PM +0100, Alice Ryhl wrote:
> > > On Fri, Jan 26, 2024 at 1:47=E2=80=AFAM Boqun Feng <boqun.feng@gmail.=
com> wrote:
> > > >
> > > > On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
> > > > > [...]
> > > > > +    /// Maps the page and writes into it from the given buffer.
> > > > > +    ///
> > > > > +    /// # Safety
> > > > > +    ///
> > > > > +    /// Callers must ensure that `src` is valid for reading `len=
` bytes.
> > > > > +    pub unsafe fn write(&self, src: *const u8, offset: usize, le=
n: usize) -> Result {
> > > >
> > > > Use a slice like type as `src` maybe? Then the function can be safe=
:
> > > >
> > > >         pub fn write<S: AsRef<[u8]>>(&self, src: S, offset: usize) =
-> Result
> > > >
> > > > Besides, since `Page` impl `Sync`, shouldn't this `write` and the
> > > > `fill_zero` be a `&mut self` function? Or make them both `unsafe`
> > > > because of potential race and add some safety requirement?
> > >
> > > Ideally, we don't want data races with these methods to be UB. They
> >
> > I understand that, but in the current code, you can write:
> >
> >         CPU 0                   CPU 1
> >         =3D=3D=3D=3D=3D                   =3D=3D=3D=3D=3D
> >
> >         page.write(src1, 0, 8);
> >                                 page.write(src2, 0, 8);
> >
> > and it's a data race at kernel end. So my question is more how we can
> > prevent the UB ;-)
>
> Hm. Would the following work?
>
>     // Change existing functions to work with references, meaning they ne=
ed an
>     // exclusive &mut self
>     pub fn with_page_mapped<T>(
>         &mut self,
>         f: impl FnOnce(&mut [u8; PAGE_SIZE]) -> T
>     ) -> T
>
>     pub fn with_pointer_into_page<T>(
>         &mut self,
>         off: usize,
>         len: usize,
>         f: impl FnOnce(&mut [u8]) -> Result<T>,
>     ) -> Result<T>
>
>     // writing methods now take &mut self
>     pub fn write(&mut self ...)
>     pub fn fill_zero(&mut self ...)
>     pub fn copy_into_page(&mut self ...)
>
>     // Add two new functions that take &self, but return shared access
>     pub fn with_page_mapped_raw<T>(
>         &self,
>         f: impl FnOnce(&UnsafeCell<[u8; PAGE_SIZE]>) -> T
>     ) -> T
>
>     pub fn with_pointer_into_page_raw<T>(
>         &self,
>         off: usize,
>         len: usize,
>         f: impl FnOnce(&[UnsafeCell<u8>]) -> Result<T>,
>     ) -> Result<T>
>
> This would mean that anyone who can obey rust's mutability rules can
> use a page without any safety or race conditions to worry about, much
> better for usability.

The methods can't be `&mut self` because I need the ability to perform
concurrent writes to disjoint subsets of the page.

