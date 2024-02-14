Return-Path: <linux-kernel+bounces-65082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF085478F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94F41F21175
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4218E10;
	Wed, 14 Feb 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrXgyHlF"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBDA18638
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907911; cv=none; b=s5PNLH2VGBG/1/CRj2AjxynYwHJGJB6pLwZh/v4+kzBfgNS3kvRty8YA/PYqOpTlzqCGp+37RCszZL41VUaTVmmf8ppizUGYsdqcGui97L7N29heYlTcYi4DrjzAA2q/d0MA5rdhoepOIaDOUoNrNzgQ9+AwJx6cq2BRKDBXyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907911; c=relaxed/simple;
	bh=FngIp4KBxf0vqziz3+ArzSp7oe/urJZKigfldVYi13c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XC2WgpAyKmkf3//s7C+tqxR/utSwEotQXbdfCZ6hOyPdVtHpi9hn7TYadOG9HIPE8aGI1xR+nMP5JgArtnD+cCeot00fGxaS570+r6RLRbaZ5YqjETiqi/a9nPO3m7BoRWrOrRJqSRILMTeSVD7wzBY9GRRLv/e0Dt2RbtqFmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrXgyHlF; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so1945810241.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707907908; x=1708512708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2g1mQizjkEn3VxHNfnwCGd5SJVNpMNtdqZQAgI51wCU=;
        b=zrXgyHlFKZAdxlGFAEhVc9G81FYr3RYeNYuShQ4yP8E8rC3aopZPA22zrXy5aZs3en
         nUYJUIBjDB0Tcr9doCutUstpxGclzvX4hZItLoP4gP4oCl3pQcHC8oGr/2xsVpeelTN/
         U3HFwWh3k2v7Dd4bcbmGubl9Dtq84ZF7ipGEj1ZJ+gIgB1/gsNVcg+IlbV0n/gWVZRKh
         wV3FqGfEELI4OtgBCKAbk1D8b//XX4v4xK7h0nUnYJtvUyvdmHdWZSZH4CyOJB0D7DCl
         rcEGCecR94nZCDr6lzS8WkdIT0Auh4eO8VNEBo760wtu/P1Y4HM0UEe4qqGfqOWIw0JR
         F9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707907908; x=1708512708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2g1mQizjkEn3VxHNfnwCGd5SJVNpMNtdqZQAgI51wCU=;
        b=I/lZeKr8YfGuNq7OgA0ncKfKHb7Ac/ZBkibndLjHtPK7ZQwDCc9dZ6eFyRALyKxmLL
         zSiE74fGWGZLOSbfiqYoYz9WBC0KmR3OZwVclcepi3BQMG5htAaHxdrduUZ1MQuFzZ9v
         y7Sznt9MJ5PXSZHN9bYtBIQOgzjt1P5iXlPZVJRe3fMGXP10Re8BVeR6K18KY81oFJrK
         qGKOnEHN0M2gzU8qhGOiInuktIRRkyqXlzWXz9BLe5/tHdhyB2jguBD/PPO1YGo4gbvS
         MiedMzr/qAOouUgoUDiNUkYZZLB/wyh65h6oYGB1kyOjedrfeyh4pt5Ss92wvySnA4AP
         if5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6DbWSdBKlEpVJxLPZ6sy7hbOKLbAqvGkgh0HKlKuEdAbaoQ1kQ0Vd0oCfVIBBt/OmEDKSOsfnvjJFjhhDEymjOv/jk6N9pqij9z7u
X-Gm-Message-State: AOJu0YzwTJv0WH52XIQeAQs43R9+BKVEF56WY6kE10sUwSKTKqsf87t1
	5M0HduFIajharYpnssl6VpOaPJps2F8hEGE+Ue2iWlGY3L/u6zOAj8XegYq7N0y7hIjTymxdHfC
	1Qa8iSpvcxzDtvrLJZC6ITne3OF765n6XXMUn
X-Google-Smtp-Source: AGHT+IExci4zElcZtqMQOuT6NK38iGJAdkqnfcCqnUfNn0vIoBFYe9CwwBiX3ybhUh7K3qqNBm1b+K7r0Iz04LypLPw=
X-Received: by 2002:a1f:e084:0:b0:4c0:2a9f:d3ec with SMTP id
 x126-20020a1fe084000000b004c02a9fd3ecmr2466287vkg.6.1707907908067; Wed, 14
 Feb 2024 02:51:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-2-d821250204a6@google.com> <202402091606.A181673F0A@keescook>
In-Reply-To: <202402091606.A181673F0A@keescook>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 14 Feb 2024 11:51:36 +0100
Message-ID: <CAH5fLggZc_Fxi1gjx9jxGDgyYOj1NLz5MYxzRxEja6vV0WffGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
To: Kees Cook <keescook@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 1:15=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Feb 08, 2024 at 03:47:52PM +0000, Alice Ryhl wrote:
> >       unsigned long res =3D n;
> >       might_fault();
> >       if (!should_fail_usercopy() && likely(access_ok(from, n))) {
> > +             /*
> > +              * Ensure that bad access_ok() speculation will not
> > +              * lead to nasty side effects *after* the copy is
> > +              * finished:
> > +              */
> > +             barrier_nospec();
>
> This means all callers just gained this barrier. That's a behavioral
> change -- is it intentional here? I don't see it mentioned in the commit
> log.
>
> Also did this get tested with the CONFIG_TEST_USER_COPY tests? I would
> expect it to be fine, but better to check and mention it in the commit
> log.

I just ran this with CONFIG_TEST_USER_COPY on x86 using the Android
cuttlefish emulator and it passed there. I also verified that it fails
if I remove the access_ok check. However, the tests succeed even if
the barrier_nospec() call is removed.

That said, it seems like it fails to compile on some other platforms.
It seems like we need to add #include <linux/nospec.h> to uaccess.h to
fix it.

Alice

