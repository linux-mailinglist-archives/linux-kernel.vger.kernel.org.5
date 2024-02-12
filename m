Return-Path: <linux-kernel+bounces-61251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C1850FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4E51C21AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E617BA8;
	Mon, 12 Feb 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1XttLTI"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5312B7E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730622; cv=none; b=CsAmwJTbXuXpovw15Z210rnd80JuOdU4xZFH+Ke3rrNfQKsdfKxpgXLz1l5W0X7G/THmJ8L4t/t6NdaEjUvCBPPCZn/sDir7lKVgCya5HDpD7CaqvJGKJ9vPmeLg56CsWdSUhNw/6Voy6MOSZcU8SCLaZmI9aSOkM+a4jSaQe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730622; c=relaxed/simple;
	bh=hNoYuhS9gQug/OX6MY7ORS8ZrUYMnh2ZQxIi4q+85ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHr7Yo9FQBSN5tqG3grcIPhQJFUKGXwAprErCTN2v3og/lWtR1fPfDnSkGEKvySA1sIyHJMAOHyM8MD7Lp31L9uf3x3+O38kLk98ZESQgNOS/yVCNlvesZA6LxUoXhVvEaRjJFrodj4JyGHlvr2CVK7JrT4//P4gHNu7QrTXQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1XttLTI; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d2a78c49d1so1527021241.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 01:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707730620; x=1708335420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/E+m/HmOf8NYGXW5jPmBKlZJMmDwZLc9BuYGu83i6s=;
        b=u1XttLTIEHxldQlNaA6c7dcUkf2Fg9YWwYMqQJoG9jOFvYyt7DsbwgzAWdGBIhRY6M
         LgPdaIg69WxumnBcSYJgaYHhMftnrJr6YlNq0MARyoT/7JohlOBnBk+p5niWYBhOJcrq
         9W2e3FoQqqWGOHfdvpf4ASZssQb8z4XmS8lztVv6FRUNNWQT4uTvOWOfC/JPBMtVnba0
         XKTNUWGtWACUBPQITgd/VhOUK2YMwuisXNK6QAmjmkZPEHtqMW3zKsXCYst1BAqXa5VB
         cpQiFmr3tiCNReIYGBNBc5o7mHjv+8FTyPgGvXNlbD0YGiO5AwvtwDsD+iOFiY4oMwKC
         Ik/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730620; x=1708335420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/E+m/HmOf8NYGXW5jPmBKlZJMmDwZLc9BuYGu83i6s=;
        b=NI8mEb4+I0D2vHYzrgfl7RND01qU8kysFdd7nsM/t08RfBf55UFk5VQ4cRBN8MziIc
         Ic0TXElfD8JtTZVJIwDZ7gmxe16vGdKw7FALxuCTV5g5Ot+rrcqtWx1h06NiPCNdXpCt
         Yj9iFeP3GTtMrIzNXubWsaHzeZdGx5AZgM3nqixWLVvKowU+/3j3rep3WwLmQCUq3IA9
         UjrkLNm/dGx7GVwX14oDjFwtnWyIZFoTz3eo5Ye7qU+fM7hKagdr3F8y3hWq4qYb41EG
         no7RTZZhrt7YtYhNYA4KjGcp9eZwqxnTrka/9S8L+fNpNY893v3FNXmIm7G7fEcbvwY2
         /eaQ==
X-Gm-Message-State: AOJu0YxKHYEh5NMzEgbLspH2qhjmXaMn1tXswxSZZ4++U3DCVGJ014ra
	SDViRgwcDZat8XwjIrtWj06Jl+Ajsa+uUc7e1veJI/cmQ8+pmoP57i0MLk3vf4K8GTvdGVHwwcC
	vPw/pD4jpFtKPEZ/y0heW+HEaBStwPTYD9NMI
X-Google-Smtp-Source: AGHT+IF1JLiuSnoWvFlNH0ZFTmSJCw5Jh8SHStPr6vvDaY5nSqylus66nyMrF0w34j2u/nWXwzWcgMEwLYwAKIEhUw4=
X-Received: by 2002:a05:6102:3709:b0:46d:2b14:db7 with SMTP id
 s9-20020a056102370900b0046d2b140db7mr4717432vst.4.1707730619799; Mon, 12 Feb
 2024 01:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-4-d821250204a6@google.com> <d35a656b-b802-4f1e-90d6-7320d61ed818@gmail.com>
In-Reply-To: <d35a656b-b802-4f1e-90d6-7320d61ed818@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 12 Feb 2024 10:36:48 +0100
Message-ID: <CAH5fLghM2thHeQifehUDT1b64okVn3sh6Eg_oPxqoK2zU-EJGw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rust: add abstraction for `struct page`
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Sat, Feb 10, 2024 at 5:23=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 2/8/24 12:47, Alice Ryhl wrote:
> > [...]
> > +    /// Maps the page and reads from it into the given buffer.
> > +    ///
> > +    /// This method will perform bounds checks on the page offset. If =
`offset ..
> > +    /// offset+len` goes outside ot the page, then this call returns `=
EINVAL`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * Callers must ensure that `dst` is valid for writing `len` by=
tes.
> > +    /// * Callers must ensure that this call does not race with a writ=
e to the
> > +    ///   same page that overlaps with this read.
>
> This safety section says that a call mustn't race with a page that
> overlaps this read, hmmmmm.

Is there a question here?

> > +    pub unsafe fn read_raw(&self, dst: *mut u8, offset: usize, len: us=
ize) -> Result {
> > +        self.with_pointer_into_page(offset, len, move |src| {
> > +            // SAFETY: If `with_pointer_into_page` calls into this clo=
sure, then
> > +            // it has performed a bounds check and guarantees that `sr=
c` is
> > +            // valid for `len` bytes.
> > +            //
> > +            // There caller guarantees that there is no data race.
> > +            unsafe { ptr::copy(src, dst, len) };
>
> If `src` and `dst` overlap then wouldn't that be a bad idea? If so then
> how about mentioning that callers have to ensure that `dst` does not
> overlap with the page that's being read and use
> `core::ptr::copy_nonoverlapping` instead, otherwise the doc comment
> could mention that `dst` can overlap.

I'll use copy_nonoverlapping. Thanks for the suggestion.

Alice

