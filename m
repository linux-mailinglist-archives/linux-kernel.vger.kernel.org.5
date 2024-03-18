Return-Path: <linux-kernel+bounces-106614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4D87F0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58462B22AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224AF57878;
	Mon, 18 Mar 2024 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OER+Bvfn"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5757327
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792621; cv=none; b=ocESnsW4rxnPpjkIYFAoX01fBtYdQcuvcCu1tGJPquPIqZS7uiorMGG4FDmD59c2NM3DASlbZ76js32NshH0YEgkd6fX1cBc9w54+k0zGKzNboWYCEMEgRR0lLNKSU8JTMlzrE1WjPWvn7SGUiCifeA78P0QX6UPyIH/qgvsfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792621; c=relaxed/simple;
	bh=q7zlBvHkNklvYzBlrJNrTs9VWBWS3MZcgFdliQVZYrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE3j6wsaOnuVoricjp8GSpoY0T44cEebdfD8QvbWIeKgGB80jXd0Joj6ZlwiHyLJP59OvMntdA154+d9oqn0oJtQvAVW9uFO0Fc2CMsd9ZcZLa+Jl4zcBWqb4T2OAUofQ+MDT6m8Z/u3mc0e78WKbui2UbxKX6Gjux5l92UbwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OER+Bvfn; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4760fe9c282so1520237137.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710792619; x=1711397419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQJNvq3IDOVP2lqjCGWJmSkh3t0FUICHfEvk5ZPCOg8=;
        b=OER+Bvfn8Wu64j2BJ7J+f8oKl+o+L2jyRQnCt+WeJFgis/natzvgKgrir94pZbmKvn
         HdUt/f1Hm9Y+96KrJz4Zdda8g3fL4SBhB1/nmZW/JxHvA0GeQhE9+i2snOWNm/MS+2Ve
         akq+20I7zO63DdozaifnQmzYpXhJJWXKB/B66dwAnJaGL5D0yAqSy4tP28x//CaIwoAL
         4kwZFtIUdg/T5SffXrnCnNkKnHpGFKolVdwNvz7i/mZZ12CI2F68ceJuLZsbZHhwImoX
         br/2sYs4I66/mJKQaadaKn7/xapbThsMwNpgniGWagA/1y/9NH3M/JL8ga337yuIIOXR
         riUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792619; x=1711397419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQJNvq3IDOVP2lqjCGWJmSkh3t0FUICHfEvk5ZPCOg8=;
        b=rbAQ2Nqhc237Ma8y/UQ2Il8VsrocVhpOe22qyq/AVjvwprdind4Isj/4qWPJGmg9bT
         9JIbjVBsr86JuvpRay2mdITKGM3W63XldoJ5CGu2hDcluBJNABe9xgvvGpyy4ERrZs50
         qBktiGBElqF1kNdwo+4Bb7GZ/QIsg0KmGZ/R1aVJzC50Ae27hAwypu2N9vYEpRirm30R
         u0CNrczPVrF+8W1xjPZOFzrUWsX+/G9IWoSWM9iJDbxPEePl+j41biDW9xYmK7g80HdV
         DxXr8QFrFAgpR0hlBdRH2DQM61GA4HbDAO8jypaC9zTJcD9hkJXuwl4w+fuQFHYMGqzH
         PcGw==
X-Forwarded-Encrypted: i=1; AJvYcCWtrVksZOopXhhjTRe+NU7wzV65jKf/6zrBKZKj8cMaxonlwZRUHgp1A7cdYOFEO8Zn/Lw73P2/RktB9Mb0AHTx5k5yr2HurXIdGst5
X-Gm-Message-State: AOJu0Yyc17gZHl/ZF48lVcFViygh65wnqPuj4TXMzWyxAIKttwSqz9CS
	oqLVB0SL9swQwrDBBPrrsdfyS3nj55ySHbZP5pTfMFH9UULp7Cico1fhvnee0gJMBUiK4ZP3cZC
	4NBvI7N3l58p/3z2boko1+AI45Jb2CAMkC5mz
X-Google-Smtp-Source: AGHT+IHrs51HcLabtHxvPtoQjOxIqrEbANIj29qFamU4+XOJnAxft7DEXNNDgyvhg6NMzK9m2Ds5LwdeUVbSluupPzM=
X-Received: by 2002:a67:cf09:0:b0:476:9707:2b67 with SMTP id
 y9-20020a67cf09000000b0047697072b67mr1807758vsl.23.1710792618602; Mon, 18 Mar
 2024 13:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
 <20240311-alice-mm-v3-1-cdf7b3a2049c@google.com> <ZfiPB_iavHr8hNbm@boqun-archlinux>
 <CAH5fLghs7=V2hHYBnQE-h=xpQYKX5ZxrV1iVdB4ybt7pAXFMWQ@mail.gmail.com> <ZfiXDA7mhW17_ed7@boqun-archlinux>
In-Reply-To: <ZfiXDA7mhW17_ed7@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 18 Mar 2024 21:10:07 +0100
Message-ID: <CAH5fLgg=7qyOiW6szF4+N=_oNfpqBBSmreeK4VT=HXq9qm_KAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rust: uaccess: add userspace pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:33=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Mar 18, 2024 at 08:12:27PM +0100, Alice Ryhl wrote:
> > On Mon, Mar 18, 2024 at 7:59=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Mar 11, 2024 at 10:47:13AM +0000, Alice Ryhl wrote:
> > > > +
> > > > +    /// Reads raw data from the user slice into a raw kernel buffe=
r.
> > > > +    ///
> > > > +    /// Fails with `EFAULT` if the read encounters a page fault.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// The `out` pointer must be valid for writing `len` bytes.
> > > > +    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) ->=
 Result {
> > >
> > > I don't think we want to promote the pub usage of this unsafe functio=
n,
> > > right? We can provide a safe version:
> > >
> > >         pub fn read_slice(&mut self, to: &[u8]) -> Result
> > >
> > > and all users can just use the safe version (with the help of
> > > slice::from_raw_parts_mut() if necessary).
> >
> > Personally, I think having the function be unsafe is plenty discouragem=
ent.
> >
> > Also, this method would need an &mut [u8], which opens the can of
> > worms related to uninitialized memory. The _raw version of this method
>
> make it a `&mut [MayUninit<u8>]` then? If that works, then _raw version
> is not more powerful therefore no need to pub it.

Nobody actually has a need for that. Also, it doesn't even remove the
need for unsafe code in the caller, since the caller still needs to
assert that the call has initialized the memory.

> > is strictly more powerful.
> >
> > I don't think I actually use it directly in Binder, so I can make it
> > private if you think that's important. It needs to be pub(crate),
>
> I might be too picky, but avoiding pub unsafe functions if not necessary
> could help us reduce unnecessary unsafe code ;-)
>
> Regards,
> Boqun
>
> > though, since it is used in `Page`.
> >
> > Alice

