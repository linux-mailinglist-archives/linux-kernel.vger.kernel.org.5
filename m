Return-Path: <linux-kernel+bounces-47713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB488451A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C609B22B2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1D5157040;
	Thu,  1 Feb 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="mwPg9gZk"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCE14D421
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706770267; cv=none; b=QB5JV278fWCpx1KK0+bUN3Cign4hA9BmSe6N9Cel3qkn3dhVAka/jJMxn2thqN8dKua3/kkcwSI8KAisGi7+URfz++mE3GMD9QcCUmgoVJM2URuDhrySdbP0nMsqmsU0HVTZjWJp+CfylTiXzZNo4hM7aR8rm1tZ0y1HVMu5bmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706770267; c=relaxed/simple;
	bh=P+pMvfm6p1iUGj9fFqEXcNfnHx7jGrN/9q82u2ktWFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVxwtVqH36lABSuOz19aW7SGjlwoFTzqhopOV5DlY+Ir0eOgM/SnVrLs9xm/yZfkllxkEOHZ5otPERd6wvTNLkGEaSqr0I5nqrD3c4rDeUpGMpETY/MrqEi9U+hKMgLh4ygBwD/zmdT6YWMh/QQq8buw+conXcMRuR4pJ6D0Ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=mwPg9gZk; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6040fe8ba39so7265147b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706770264; x=1707375064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0VzwVbSa/n1qDmz4589AdSmL/ygOZFpk7QXNbXjzSU=;
        b=mwPg9gZkvS8/Z5artXP/PAUBGR7TjrCGVEYguHpbBRAXF/KK5jVsJJguxev4u003pN
         5yvCOMz9DiuKf0R/xoOhQKv7lHPgvrMHBPgwytT2PkJ5MTnFThDaNTskUsIQZcIzTp0+
         6WW9LacKc5qTzQowx+VxpitGuVwt2TlGQZxeeNIJH9wlLWfJ6iFMdvj690+g/WeGc/uK
         w2hvZfKtaMiXlO80HOcNEAlrJCplq4n3XzLjFxMjH2dDBJC8Pc+wGwqZBHA7yUf0gMgW
         3+xYbNAy1K+Y1NFKAmDgJ0WtWKXd5OHdCBphPrbOi7Y0xPQvDiG5RrSAckF7C3cg6c+P
         hu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706770264; x=1707375064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0VzwVbSa/n1qDmz4589AdSmL/ygOZFpk7QXNbXjzSU=;
        b=sXCrzsuJAqvpGQcLmVlnM9g2eEWe0MxCg76ha+PEW1BFQBuzSo9QvF14U+k+sC7SVo
         +1r159Wagb/VQVG30Nnt+FKVmCcxkmHIIhtuimMEaKehL7QtY1X76eV0Uybs0Fs1djeQ
         k1fuwRm1YzwQcTSi4W+di04bSOZMz5scz3Cmxqk9W4feQew0FXkQdudlZVh3p1YuU/k/
         nYloW2vATAJhWDfumqq+lgZa1MIkuCpf+HtaJdgVq+G1BU1d9VV5QyT3wWh7W4meWVqO
         J0P2SKTdd6ss/14klk2sOURFvY2yyuwle6nkiwj0JqAMb1rBezI9JIrsq4bV2o0P6yid
         smBA==
X-Gm-Message-State: AOJu0Yx+QjyD1hO6ICUH3gRyPcpVl8nGDuXC+y2VwjsHqYLBk0CpXsOS
	dUpUmcFlnXAULyYfxPf3k6Lff92dAy/2PVE1irdSBCUVd/G40wSdR1F7a4DJxUEhdFVKFrTWOwb
	XODsWI/bZEQV2/GJoeX4Jls+7lUGi/yOMhurkoQ==
X-Google-Smtp-Source: AGHT+IEPGqm/Y0xYSHVANnXssBTUMPz3ZdBa3qhfP7xrY7cv7t5U8clp2+mPjqdB+Tw0QipEexd9/XI7bvCHxxl84/Q=
X-Received: by 2002:a0d:e857:0:b0:5f6:4f5a:8bd2 with SMTP id
 r84-20020a0de857000000b005f64f5a8bd2mr3187081ywe.0.1706770264344; Wed, 31 Jan
 2024 22:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com> <ZbMA1yiM6Bqv9Sqg@boqun-archlinux>
 <CAH5fLgiNphSebaG82XkQHGFPFp1Mf1egyaiX6MFzsU2X3-Ni8w@mail.gmail.com> <ZbP50nEIMqULfVuj@Boquns-Mac-mini.home>
In-Reply-To: <ZbP50nEIMqULfVuj@Boquns-Mac-mini.home>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 1 Feb 2024 01:50:53 -0500
Message-ID: <CALNs47uy5rQ15wByzQA0_YzORM0nTFdi9-TvwyC4+ZTXVQBj4g@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
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

On Fri, Jan 26, 2024 at 1:28=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Fri, Jan 26, 2024 at 01:33:46PM +0100, Alice Ryhl wrote:
> > On Fri, Jan 26, 2024 at 1:47=E2=80=AFAM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
> > > > [...]
> > > > +    /// Maps the page and writes into it from the given buffer.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// Callers must ensure that `src` is valid for reading `len` =
bytes.
> > > > +    pub unsafe fn write(&self, src: *const u8, offset: usize, len:=
 usize) -> Result {
> > >
> > > Use a slice like type as `src` maybe? Then the function can be safe:
> > >
> > >         pub fn write<S: AsRef<[u8]>>(&self, src: S, offset: usize) ->=
 Result
> > >
> > > Besides, since `Page` impl `Sync`, shouldn't this `write` and the
> > > `fill_zero` be a `&mut self` function? Or make them both `unsafe`
> > > because of potential race and add some safety requirement?
> >
> > Ideally, we don't want data races with these methods to be UB. They
>
> I understand that, but in the current code, you can write:
>
>         CPU 0                   CPU 1
>         =3D=3D=3D=3D=3D                   =3D=3D=3D=3D=3D
>
>         page.write(src1, 0, 8);
>                                 page.write(src2, 0, 8);
>
> and it's a data race at kernel end. So my question is more how we can
> prevent the UB ;-)

Hm. Would the following work?

    // Change existing functions to work with references, meaning they need=
 an
    // exclusive &mut self
    pub fn with_page_mapped<T>(
        &mut self,
        f: impl FnOnce(&mut [u8; PAGE_SIZE]) -> T
    ) -> T

    pub fn with_pointer_into_page<T>(
        &mut self,
        off: usize,
        len: usize,
        f: impl FnOnce(&mut [u8]) -> Result<T>,
    ) -> Result<T>

    // writing methods now take &mut self
    pub fn write(&mut self ...)
    pub fn fill_zero(&mut self ...)
    pub fn copy_into_page(&mut self ...)

    // Add two new functions that take &self, but return shared access
    pub fn with_page_mapped_raw<T>(
        &self,
        f: impl FnOnce(&UnsafeCell<[u8; PAGE_SIZE]>) -> T
    ) -> T

    pub fn with_pointer_into_page_raw<T>(
        &self,
        off: usize,
        len: usize,
        f: impl FnOnce(&[UnsafeCell<u8>]) -> Result<T>,
    ) -> Result<T>

This would mean that anyone who can obey rust's mutability rules can
use a page without any safety or race conditions to worry about, much
better for usability.

But if you do need to allow the data to be shared and racy, such as
the userspace example, the `_raw` methods allow for that and you can
`.get()` a `*mut u8` from the UnsafeCell. This moves the interior
mutability only to the mapped data rather than the Page itself, which
I think is more accurate anyway.

Leveraging UnsafeCell would also make some things with UserSlicePtr
more clear too.

- Trevor

> Regards,
> Boqun
>
> > could be mapped into the address space of a userspace process.
> >
> > Alice
>

