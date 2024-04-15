Return-Path: <linux-kernel+bounces-144850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C08A4BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17861C223F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2B446AD;
	Mon, 15 Apr 2024 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoQ2BrCs"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B263D3BF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174287; cv=none; b=Y9/FqTsr9JaqBPduLPsRw5b5BFF6KocQbO1OwPmXEaBNvRfeZ93kFTgBR1qJvNI9hGP1ubbdHTPIaBzu5BMPQkngJBomstEm7+0zGrYYqmCjc2o66ueLOHKL9NRtrUk+E+Vr6DQWUEROyS4RMZXIuE9JtSELj3yPYXDFxpaj2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174287; c=relaxed/simple;
	bh=gba+sm2E9ePiUcK4VdEn+S71kqNe3vHsP4roaANqYZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B58juSNd5Spe52ftaGJ409WI966QPNxO9oI17bsh4bfsa/BmDT3+BtwytMDupsZL+/zrBPrS/ShEO7yHAF4Q5safgGrEGOf09zaDV1/3YnC2feRIa8B35OJZG2zx8hyxRYw8cLo23/nXDxgVxawEhS0+w+4iiDrlr1mONCxC5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XoQ2BrCs; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4dac92abe71so936521e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713174285; x=1713779085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSLoiB2mZ+syImFaap979pBovjFFHgK5JL5uKJwM15M=;
        b=XoQ2BrCsSSi552IZiY+s5HsdFrU9bkzS2JPOtArpzFK0VzYW/ljZcvU74jdsNbpWDn
         c7uGzvsErny2Xz5iraH8hSySM3TgTSDvfb29SGlmyDC3UlF8oYlpZu1NgpQvam1zX72Y
         inKPVjNxhEgIcvyx9CZ4947qy//ieHNaY1LhtuST4MBIetzcL6wYE5Vy7CQ2R8ZdXk9h
         V67A9+zcfKtkhhk9iE9D2mmxYqUBIakYeUqPYOgTvLDwno/9Rc1YVKKe5nLT1Z/mf4xF
         zHmZdK9ejJsSF3wz5d6UvfGADaPrK4gq2cxXl7wTVV+8/ngEvX+4BzWI+Ts/blYXk+sY
         nZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713174285; x=1713779085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSLoiB2mZ+syImFaap979pBovjFFHgK5JL5uKJwM15M=;
        b=q0//gqA1v1Cgrm7Owqc4GIRVTCA97lSJWofdjKaS/O96NDohm9Traik1HAyzWRBb7m
         wldtMAZhiPPZL8CpgRS+UvxqSUOu8jkN07lcSIVIT5H2xE/elLd4VbRy61IDUvThivPX
         C5C4zmxX7Yv1SmdnVaHmEgabXUT8FZ5cQlyGMncIy6aRb2LUI7iAkAPC0hUBSST7Mu97
         w/TJE5mwrkuZQhrjYHNUsz2k/U4JNy5BHGTExeS4aYiYkLb8drHOmIRL9hw3mqp92Xnx
         viLNJR5Sgxvf6u60y1jfuQZ4SOEE2ZkYLxNaBaDGl2Gz/gH56mjH7XWsmfbBVo1N/owR
         /AoA==
X-Forwarded-Encrypted: i=1; AJvYcCW3JcoaVmzY5pXLZn0ExAumISK62Kjdi+b/E9+Jn+34XYpq3JH6vSdEmxWVgCxjy55B03co9viaBFoehqREQbHyjeTCvNQaGMfoI/73
X-Gm-Message-State: AOJu0YzM9hNlpcbnxIRzMucl9k3+lofYcRNUQzczFG2bLERDge52om8C
	sLy73wvkeQOQ7wEkoO+k1GuNaosrwKijHuaNb/8vkcxaamXpk8Lkb/SDuntHDf8C7fUuf15v+Ne
	D2iMIFOwNKDcTO2gAqa5cYq0whelmhlP4/YFG
X-Google-Smtp-Source: AGHT+IEkhwcc26gJYhEUGK0Rz98TITLvdkASwy8xab0jVCJOyrzEUfOPadfPmhxaylFC0rFqS6AhEhBJ09WImT7Whzc=
X-Received: by 2002:a05:6122:3681:b0:4d8:74a2:6d35 with SMTP id
 ec1-20020a056122368100b004d874a26d35mr7925511vkb.9.1713174285085; Mon, 15 Apr
 2024 02:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
 <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com> <2cae6fd4-906c-44ad-88be-0dfed090d07c@proton.me>
In-Reply-To: <2cae6fd4-906c-44ad-88be-0dfed090d07c@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 15 Apr 2024 11:44:33 +0200
Message-ID: <CAH5fLgjT3hAdtdNeb7FgX491UhvMGa-JHevz_EqC=N4zVViBjw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Mon, Apr 15, 2024 at 11:37=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On 15.04.24 09:13, Alice Ryhl wrote:
> > +impl UserSlice {
> > +    /// Constructs a user slice from a raw pointer and a length in byt=
es.
> > +    ///
> > +    /// Constructing a [`UserSlice`] performs no checks on the provide=
d address and length, it can
> > +    /// safely be constructed inside a kernel thread with no current u=
serspace process. Reads and
> > +    /// writes wrap the kernel APIs `copy_from_user` and `copy_to_user=
`, which check the memory map
> > +    /// of the current process and enforce that the address range is w=
ithin the user range (no
> > +    /// additional calls to `access_ok` are needed).
> > +    ///
> > +    /// Callers must be careful to avoid time-of-check-time-of-use (TO=
CTOU) issues. The simplest way
> > +    /// is to create a single instance of [`UserSlice`] per user memor=
y block as it reads each byte
> > +    /// at most once.
> > +    pub fn new(ptr: *mut c_void, length: usize) -> Self {
>
> What would happen if I call this with a kernel pointer and then
> read/write to it? For example
>
>      let mut arr =3D [MaybeUninit::uninit(); 64];
>      let ptr: *mut [MaybeUninit<u8>] =3D &mut arr;
>      let ptr =3D ptr.cast::<c_void>();
>
>      let slice =3D UserSlice::new(ptr, 64);
>      let (mut r, mut w) =3D slice.reader_writer();
>
>      r.read_raw(&mut arr)?;
>      // SAFETY: `arr` was initialized above.
>      w.write_slice(unsafe { MaybeUninit::slice_assume_init_ref(&arr) })?;
>
> I think this would violate the exclusivity of `&mut` without any
> `unsafe` code. (the `unsafe` block at the end cannot possibly be wrong)

This will fail with an EFAULT error. There is a check on the C side
that verifies that the address is in userspace. (The access_ok call.)

Alice

