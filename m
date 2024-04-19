Return-Path: <linux-kernel+bounces-151858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D578AB4D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F811F22DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B150013BAFC;
	Fri, 19 Apr 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDhuYTbj"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042B13A871
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550358; cv=none; b=YDdIJ1Kw1A6H3EHYoJnnq9/qJLYiEb5Snk38Lf9gWXFUIUbEGP6zQyzFAt7lNhWnHpApGnkkMLqHQJpHfZcU10YQLWqFvLFCrdcRAcGcPGYD1tGzN9wTymR9Wm88hmRBVswwGAQwex9vaiFtDwprxyMaOepidflYpwhtGQQ2PIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550358; c=relaxed/simple;
	bh=5OoEVXRanZ24jLnT2Kd6vCgLBegTb1q/k9NQXr41LEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIVLRd6V7Gx2EXUTpYYfC1anS2uuZXYJW2ZwSDy0M80mWkBF/fD5iOLBmHxmvusWOvIELT4XicZo6f59/9446dV0N41wXWl4ambmiupArPIhEOEmZFh3Xxwj58T2LQW9wiHMRrE+aSvrcYALL5o/a0GT61uBsuxzVLAxaH9TFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDhuYTbj; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-479dd0261c8so1486316137.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713550356; x=1714155156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr4pi+Kny8bbVl+Iz+PAepuZ7kpgc/VuFcgkzz8aTw4=;
        b=CDhuYTbj3VMN44oaNXnXxu27FtJXw/vS8mw1ORPB+RdOKvkG6MzSDK1Zf9LSM9bI46
         ZrxThK4rGMaaCTZUfKDeEZJJK1HsaKI/+wwEFyXpF+umz6gNkzcZ1aqA9y7zs09QeEDw
         lefHg3x1vMfrscfG8kz5QsZ8KU4kWSqFOLvqj5Fi+ZdvlqQrwKmHdrHGn6s/a2FJE6vN
         liFXM0z1xQsNd25NoPAYkWDXD0SoPpCJr5FS+tHm9tPyVUi30nYzRM3VxQN71KFqh+iE
         4uBYaTONRyZYQeKOruSS9MystM32a2sq/mtE5KBj7u4igNq+blWNZ0gza/y07v8D0gmt
         gosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550356; x=1714155156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pr4pi+Kny8bbVl+Iz+PAepuZ7kpgc/VuFcgkzz8aTw4=;
        b=b8vjQbOc68djA5wvoiEIOqhx9pEhg9xiuirZAPc+WGjH4g98klqvvdZtgnaaEXk2AT
         j+kJT6qwQNxJxgSiBEag3W+LanEMsIRQhv3Wsa0i1htrMMS+4Y95mfoKQLTLUBrWeVlm
         J+hT7PBUDbieJXXL97tVwtElhc7NMHiIOMHHL+HtBkVZWbpx6AR4trKmujIbSNVmBscW
         44LMyfEbr0hYeOMTE1kNjGdHp0HQ4Pq4iu3n1/xl6/aZLEhtu1P3IDhdB7gkX3KZG4zv
         A0/dhLkaIvwJx8KF0vEupnEEvpFzUra5l2geuwa+tECUSlPX2hIO3wog7Sb/Tzp4XEqV
         ay3g==
X-Forwarded-Encrypted: i=1; AJvYcCUX/RCE2D3Dmlcc34rmtymOHTsF97TTI47b1hxmvtQdtzd5ya4x9O9NSvSEr9tLtWx1EDJoPu9kGgn9U38YWUVu119uG1HX0x5ZGqTN
X-Gm-Message-State: AOJu0Yz2O43tiqpxOjKvUpXTsXi1QgZVNk40BQoTknV9JvOSqFh/sjm5
	3ng/cHPjSFpzdr6a4QHfVWpAr9ptVn21bAY6jXmnBDl6X60bPZiCUaWkyBhukFkrWdfmpwst0ZC
	qclQVtHUh41Za+giBBQBSVY7AgyTcznQIiNyK
X-Google-Smtp-Source: AGHT+IGKWqj19fr6lCGVBtuwAdS9DytWE1K5v7+RkbOscyxSEB74jIiRfprxzzsCH+WqgTqKdbso+jk/KyNVUnSu+YU=
X-Received: by 2002:a05:6102:2844:b0:47b:5f05:5a57 with SMTP id
 az4-20020a056102284400b0047b5f055a57mr8647652vsb.16.1713550356213; Fri, 19
 Apr 2024 11:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-1-cb8f3e5d688f@google.com> <ZiKltinLGvKlBivm@boqun-archlinux>
In-Reply-To: <ZiKltinLGvKlBivm@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 19 Apr 2024 20:12:24 +0200
Message-ID: <CAH5fLgh0rFMQcAA4a=Vk8uEkyHP455KeihR-2BkkOpgHS6teKA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] rust: uaccess: add userspace pointers
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
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 7:11=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Apr 18, 2024 at 08:59:17AM +0000, Alice Ryhl wrote:
> [...]
> > +    /// Reads the entirety of the user slice, appending it to the end =
of the provided buffer.
> > +    ///
> > +    /// Fails with `EFAULT` if the read happens on a bad address.
> > +    pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Resu=
lt {
> > +        let len =3D self.length;
> > +        buf.reserve(len, flags)?;
>
> (Reportedy by Miguel)
>
> When compile with `make rusttest`, kernel crate is compiled as userspace
> program, so we need to explicitly pick where the `reserve` comes from
> (Vec or VecExt), the current version will hit the following error:
>
>         error[E0061]: this method takes 1 argument but 2 arguments were s=
upplied
>            --> rust/kernel/uaccess.rs:296:13
>             |
>         296 |         buf.reserve(len, flags)?;
>             |             ^^^^^^^    -------
>             |                        | |
>             |                        | unexpected argument of type `Flags=
`
>             |                        help: remove the extra argument
>             |
>         note: method defined here
>            --> /home/boqun/linux-rust/rust/test/sysroot/lib/rustlib/src/r=
ust/library/alloc/src/vec/mod.rs:910:12
>             |
>         910 |     pub fn reserve(&mut self, additional: usize) {
>             |            ^^^^^^^
>
>         error[E0277]: the `?` operator can only be applied to values that=
 implement `Try`
>            --> rust/kernel/uaccess.rs:296:9
>             |
>         296 |         buf.reserve(len, flags)?;
>             |         ^^^^^^^^^^^^^^^^^^^^^^^^ the `?` operator cannot be=
 applied to type `()`
>             |
>             =3D help: the trait `Try` is not implemented for `()`
>
>         error: aborting due to 2 previous errors
>
>         Some errors have detailed explanations: E0061, E0277.
>         For more information about an error, try `rustc --explain E0061`.
>
> and we need to the following fix
>
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 39481e374c40..80f7e7ca2f5e 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -293,7 +293,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
>      /// Fails with `EFAULT` if the read happens on a bad address.
>      pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Result=
 {
>          let len =3D self.length;
> -        buf.reserve(len, flags)?;
> +        VecExt::<u8>::reserve(buf, len, flags)?;
>
>          // The call to `try_reserve` was successful, so the spare capaci=
ty is at least `len` bytes
>          // long.

I'm sorry, what? This seems like a problem with `make rusttest`.

Alice

