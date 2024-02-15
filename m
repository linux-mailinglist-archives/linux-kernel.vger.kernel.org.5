Return-Path: <linux-kernel+bounces-66566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB483855E61
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CCFB2C590
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16921BC3E;
	Thu, 15 Feb 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saeM4Gzy"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673361BC26
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989922; cv=none; b=BhVeKfNc1OVWJxisaoAsERXfdVLeirl1gzfjmU1bCMfHR+gmeEV6ydbxaxHN0nrjTQngL1P49YtBo2Qqt7XJeEGPF7et/7HthR61Qq7dXxM57nBRbBRMx6ML32G4UZv2OJdYaZC2X7dpGKUXHA49rLj461UKYyKjND5435zZ7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989922; c=relaxed/simple;
	bh=it7BnFxWql5egUKdtDDvY8KPg5cflOWt+JLgjcC3KC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A54JA3keDG3ulAuPpvJY4CWkl9uYER/IHjhCEe9mzPekrYnPvFvae1MLR/XTdT6Q4LS5tmGXJZD1qBDpyqCo7lo4xOcxeA98UIiUQaQkh/RTkOPKEdu5tooEZNU41IbY7TmOkQMQlM6Qa6UmY6WowVLC5Gz14x3sxVm6oqoaBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=saeM4Gzy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42c7f8588c5so5496631cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707989919; x=1708594719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oICQappuJZC++sBJTw39WmThX8/WjV4FBmngtKS4IZ4=;
        b=saeM4GzyNAIQgeCI5H63DVYLsJwYpddVQGbUOK5IO736AMeVOorqJtIDK45CYCSU8T
         olFs0FH+cBtvaD/cKtrHVt7j7AnH4Q5akD87ka1SVX1Hxx6lhvA5wtoQ8xU8YbNuSwOQ
         VrxxCpzPQ+PvRCqGT4B+r10A0zw1Zip1yOdde7jUa0gnrEnkenvrluOp1HiiVYWe3GXF
         H1sR5MRfZKKYsAHKRJ3gREs6kN66wytSd7dJ3jP8XIcwKvkBIcf0em7UJ5xec3HsjnK/
         ++3CjAiG84VtK91MrzBjmXwmJdtZCzwI8TTd19Vfa2Cdm84nAswY+TPisNX5nTjlTO7+
         yMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989919; x=1708594719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oICQappuJZC++sBJTw39WmThX8/WjV4FBmngtKS4IZ4=;
        b=DHg04erUcDC1WCuu5+jzIXxo6wFsk7nng/L/BhhQG203MBoLLrffa/6CnhKJhyRStV
         uI0QKUbZDnb26tMm+auBge/5pbFVYXXv4qWITnr8M986oNydSIKvy1Jfb6WgC0m4AB8A
         oOFbv0OnDClsxvjXxNXrdqZ5V0XLUiVHt8Q+PsxrrVmZX8Dw7sXZKE/QgMkWaGmL1yRJ
         tK07+rHVvYfRw+uKOsE5AEZlYMaZasGJHYFr6+i9wJeOd/3pFDd/m/VnDSJ4vd4bJWpn
         OMHXIKaVQqL395+9sG32uPa9zaG1CACzh+063KzVNdU8b7kkcX+JrwuF39bnEBQc45ws
         7Svw==
X-Forwarded-Encrypted: i=1; AJvYcCUvmtsUNovXglOYhNf9JOyTJXqjmdJJpBFCl5nnef+cwU8xWGgc31Wp0my0u00JGpN3uTo4aoHSggGeg2Rt64o49eW9+obybdFMICRj
X-Gm-Message-State: AOJu0Yz34lMcHL50mGByT9eR3rs28LF86ZL436gXGXUyGmYOcknlJPHB
	Wn0OdZNSXxZSwUdxgeMjHGNv7K7rl+mIkdRBe5VTuQM+WfMz5XwaspO+wQbkb23tsOUoQFfR4TT
	5bq1rJa4YZTSxJi6dD74gnirYVqQGYTUAY/FVh9SogC9zsNlhoA==
X-Google-Smtp-Source: AGHT+IG+kztqZmwXQlQkPjW+/X5+zR7GlUXyVh4bp528TkXP1gDbyhtsWgu623VHoOlMPLeqtZsNrscST/aO+QnFytg=
X-Received: by 2002:a1f:e444:0:b0:4c0:3c82:5105 with SMTP id
 b65-20020a1fe444000000b004c03c825105mr996849vkh.10.1707989898259; Thu, 15 Feb
 2024 01:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214172505.5044-1-dakr@redhat.com> <Zc0UNUGbmmBlzBAv@boqun-archlinux>
 <2d94d420-fca2-47c1-aee7-bbce7a1505cf@ryhl.io> <Zc1mWCBKNuLrS-tI@boqun-archlinux>
In-Reply-To: <Zc1mWCBKNuLrS-tI@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 15 Feb 2024 10:38:07 +0100
Message-ID: <CAH5fLghO6Jy_hJXhRU_+eBSDHHveAvEOJA6fNkmMS9mqHvS6iQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: str: add {make,to}_{upper,lower}case() to CString
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <alice@ryhl.io>, Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org, 
	alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 2:18=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Feb 14, 2024 at 08:59:06PM +0100, Alice Ryhl wrote:
> > On 2/14/24 20:27, Boqun Feng wrote:
> > > On Wed, Feb 14, 2024 at 06:24:10PM +0100, Danilo Krummrich wrote:
> > > > --- a/rust/kernel/str.rs
> > > > +++ b/rust/kernel/str.rs
> > > > @@ -5,7 +5,7 @@
> > > >   use alloc::alloc::AllocError;
> > > >   use alloc::vec::Vec;
> > > >   use core::fmt::{self, Write};
> > > > -use core::ops::{self, Deref, Index};
> > > > +use core::ops::{self, Deref, DerefMut, Index};
> > > >   use crate::{
> > > >       bindings,
> > > > @@ -143,6 +143,19 @@ pub const fn from_bytes_with_nul(bytes: &[u8])=
 -> Result<&Self, CStrConvertError
> > > >           unsafe { core::mem::transmute(bytes) }
> > > >       }
> > > > +    /// Creates a mutable [`CStr`] from a `[u8]` without performin=
g any
> > > > +    /// additional checks.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// `bytes` *must* end with a `NUL` byte, and should only have=
 a single
> > > > +    /// `NUL` byte (or the string will be truncated).
> > > > +    #[inline]
> > > > +    pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &=
mut [u8]) -> &mut CStr {
> > > > +        // SAFETY: Properties of `bytes` guaranteed by the safety =
precondition.
> > > > +        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> > >
> > > First `.cast::<[u8]>().cast::<CStr>()` is preferred than `as`. Beside=
s,
> > > I think the dereference (or reborrow) is only safe if `CStr` is
> > > `#[repr(transparent)]. I.e.
> > >
> > >     #[repr(transparent)]
> > >     pub struct CStr([u8]);
> > >
> > > with that you can implement the function as (you can still use `cast(=
)`
> > > implementation, but I sometimes find `transmute` is more simple).
> > >
> > >      pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mu=
t [u8]) -> &mut CStr {
> > >     // SAFETY: `CStr` is transparent to `[u8]`, so the transmute is
> > >     // safe to do, and per the function safety requirement, `bytes`
> > >     // is a valid `CStr`.
> > >     unsafe { core::mem::transmute(bytes) }
> > >      }
> > >
> > > but this is just my thought, better wait for others' feedback as well=
.
> >
> > Transmuting references is generally frowned upon. It's better to use a
> > pointer cast.
> >
>
> Ok, but honestly, I don't think the pointer casting is better ;-) What
> wants to be done here is simply converting a `&mut [u8]` to `&mut CStr`,
> adding two levels of pointer casting is kinda noise. (Also
> `from_bytes_with_nul` uses `transmute` as well).

Here's my logic for preferring pointer casts: Transmute raises
questions about the layout of fat pointers, whereas pointer casts are
obviously okay.

Alice

