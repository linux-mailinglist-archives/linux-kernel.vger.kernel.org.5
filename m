Return-Path: <linux-kernel+bounces-142766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDFB8A2FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767551F23508
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948F85645;
	Fri, 12 Apr 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dphFY/ob"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF18564A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929887; cv=none; b=qwsfH/VeDUrsS0uF7CYmb/f9pncbQU3/Jo25Y0Lv/xcdVfp44XwpoKYB6MtKoJDdcCOeB9vc/9MfOFo+Jpw18YZxo7T9DqpC2wtbCuEplRNxn+QSz0TXQgK5TxXi412WkcyLw5JBr7JfOBxfn/cGT/iCCEyNUwW4xjgszx+ukzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929887; c=relaxed/simple;
	bh=53Cs+42uICznC+Xas0chinXqpYt7sWkCvzQ690iV654=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfxA8NscJBBQNPwSYX1mgJIXEl8hslnIn8+RuNcUvCWtVu67XSlkghhcSEhmtsA0I0P3eRzih84kZK3sF76ZpXjZq+w9EJ8atAauudJsVRuhE6vSCqVa/nZzUYvmvsTuVVL9U1Z44T8XQHcMBo2mFKrxWCfmuLhsRpieJSi/Blg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dphFY/ob; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7e61a25900cso211832241.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712929884; x=1713534684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJnR5552tR98GvdFl2I9gJzxKsxtaACk6KQyxfOH2CQ=;
        b=dphFY/obs5pjYf4o3FSjgCLJBTcJ5+J+d6Nj3Xr8Vh3rlZExJMe13QB67253zP/c/l
         QIR+hqVyoDeIivtI1e2aZDdRbH9wM0RpMn6C1cGzUoes85ok1cNlCAvIq3M9+p/Pk/ba
         Hc/coAOxhbGvVSzefTAA1fnoP/6TXU5bJRkuSNQD45a6cPrEM5vwTfnjowBMuEMC6CUb
         gxUIlHDNSO360mWTLE9uP/qildXmKhKNqhqxPu2GD0GpJHf9zY+WXuV0RwjsRIgEsv9t
         RgzCAvmf9PPTWpNqAyDyI8ojxFQxtPhC2B6N8FuNww4p8k/o+Z9P2GfIDrqIO1Y43Mwf
         B0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929884; x=1713534684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJnR5552tR98GvdFl2I9gJzxKsxtaACk6KQyxfOH2CQ=;
        b=n4Z3thGdBPRFWLRRaMHQYL9vpJIlZc+0o85jhe0qEnQN1UNngyLEj4SprnU5U9EfgP
         Kh5paiAEEqAqXXNKUvbuQpBvIVjb8l4wd9qZPtjhumYYt+iO+1gFoZ5dZUqYV0DwrRwW
         ctoqAtD0IHTVCUF7PBKqTnMUMx5npPD2p3S7ZhglbEMvQQAZ3HmyGeO/m2v0T7M7AK5O
         I5mBdDoGF5R2T14M6mhwDi25LoVuyaKTZEkuEhvJKsZJUVuDzOzvE37qLCuGJ5MuZL9D
         35qQyD0OqjsAPPi/88yNPRpUatszCy2cY98nvglbQYzmjabB3/P3E6wHX173rpoPVdSX
         6C7w==
X-Forwarded-Encrypted: i=1; AJvYcCV+VOHDa+pGzI0Wx5xDUiTYFLKOXAgoTnMbSKFmfULqCAMOqLNHrqDLnNt3jQurlklZV4jcG86KInfwHs/Y2+GjGdwrVpjJBbCDWnx8
X-Gm-Message-State: AOJu0Yy7thXfbmlPQYb1hK2tvMapgZkeH4Gl1tCQBw3CSz12+Z+k3STh
	vlAKqa6NNvLtUqLFGsYcSZCs+Ix6X5ETggRHn7f5BKSpEv5pmQnDMNEu49pPbQy8W1V9n9/xhza
	TP11N49RiE4389C81MiFMFjKMUP4c9f0T5Inw
X-Google-Smtp-Source: AGHT+IHxgfhOwDhXlQkc4GDre4LJSpeZ5vnnJ1PuHWiqe7qJwFHXNft4Odbv4126CJsS+HrJIjBy3eOB/r89t4EkPWM=
X-Received: by 2002:a05:6102:160b:b0:47a:3ce6:6cfb with SMTP id
 cu11-20020a056102160b00b0047a3ce66cfbmr3725899vsb.19.1712929884209; Fri, 12
 Apr 2024 06:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com> <CAH5fLgg0CkZO9KF58boui6Y5ajpXHuGh0OxyNru2aEG5pNObwQ@mail.gmail.com>
 <Zhk0q-0eM4z5JHqn@Boquns-Mac-mini.home>
In-Reply-To: <Zhk0q-0eM4z5JHqn@Boquns-Mac-mini.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 12 Apr 2024 15:51:12 +0200
Message-ID: <CAH5fLghL=G-ihevf1_D0aGffmJMtxtSpMDoTGtrmdiDfhwpKnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 3:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Fri, Apr 12, 2024 at 10:36:05AM +0200, Alice Ryhl wrote:
> > On Fri, Apr 12, 2024 at 1:08=E2=80=AFAM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > Currently since Rust code is compiled with "-Coverflow-checks=3Dy", s=
o a
> > > normal substraction may be compiled as an overflow checking and panic
> > > if overflow happens:
> > >
> > >         subq    %rsi, %rdi
> > >         jo      .LBB0_2
> > >         movq    %rdi, %rax
> > >         retq
> > > .LBB0_2:
> > >         pushq   %rax
> > >         leaq    str.0(%rip), %rdi
> > >         leaq    .L__unnamed_1(%rip), %rdx
> > >         movl    $33, %esi
> > >         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%=
rip)
> > >
> > > although overflow detection is nice to have, however this makes
> > > `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's n=
ot
> > > clear that the overflow checking is helpful, since for example, the
> > > current binder usage[1] doesn't have the checking.
> >
> > I don't think this is a good idea at all. Any code that triggers an
> > overflow in Ktime::sub is wrong, and anyone who enables
> > CONFIG_RUST_OVERFLOW_CHECKS does so because they want such bugs to be
> > caught. You may have been able to find one example of a subtraction
> > that doesn't have a risk of overflow, but overflow bugs really do
>
> The point is you won't panic the kernel because of an overflow. I
> agree that overflow is something we want to catch, but currently
> ktime_t doesn't panic if overflow happens.

What the CONFIG_RUST_OVERFLOW_CHECKS option does is enable panics on
overflow. So I don't understand how "it panics on overflow" is an
argument for removing the overflow check. That's what you asked for!
One could perhaps argue about whether CONFIG_RUST_OVERFLOW_CHECKS is a
good idea (I think it is), but that is orthogonal. When
CONFIG_RUST_OVERFLOW_CHECKS is enabled, you should respect the flag.

Alice

