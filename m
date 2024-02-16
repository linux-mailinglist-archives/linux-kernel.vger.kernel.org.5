Return-Path: <linux-kernel+bounces-68311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB748857892
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D020F1C21A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D801B953;
	Fri, 16 Feb 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKKyLvzm"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB31B815
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074603; cv=none; b=U9FzfEq6kXWfBeLQFUJ4NHmAqc3EDxJMBLebMBSuLGfueFAxmF2Yjdse6Wa1xcssXYKMYZDyJonpaRAbQphnwwTjuHJkmEAXLrVXfsvJrXKIaL3zfC/4IyiTs4anaWA+MDdGPKT/FQO+3vxetzFo4zQv1m6OCgX4oevIx8KOaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074603; c=relaxed/simple;
	bh=RKdmNzovEWVqmjvCpvHCRoTK7UqOk6nOdR+X9CIp0mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNdyW7ZTq2mj3AtPhiT8+maUfF47J1Iv2cDB1bcun7DNOaF4LYpo0OmFGzJJVWRyBRlriRSgau395+1SWmwoR8WLdtZCKfz+dM8uWtyW9WgAsTIHzccJKmApotNOitCZyl4zyHVqSUpNoEPqBoKrHEdr0bk7k0iCTdZ2GAVw8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKKyLvzm; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-46d331e3fd2so858934137.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708074601; x=1708679401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFXkHkaZjLIExOljo2tyqPMEuvx89YjO8mstMPgUNwM=;
        b=MKKyLvzmpGO5DRroKxzFrjhFIeDtFTiZb2MVMm/WRYFrr84tTx/PHjPZacChq00eyX
         13nhXr/xn7428ctE/XDd9atSqYRc235ZDBQ1Lf3/rLsBPoTTuRbRXXwFxAs/GCnMmb2t
         l2ioT/ci/CaF4lUj3+A8bAveUYK0697GNYuYh+o+eT+jhgBweOlug1Y5Adwxs+ZfaYif
         UoCabZ2+jsMs+7DuT+kx2CAlKVUzON1B/6Ck3w8DJVzbm8Rwfu9DpVkIfAYOMysuH6Da
         /NDFJLO27UFvOdG+HhYembLvPNyuU2hiMf4J8GZMdNlRnK/EcQnfwCDcxWWnJ22wyxl0
         IWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074601; x=1708679401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFXkHkaZjLIExOljo2tyqPMEuvx89YjO8mstMPgUNwM=;
        b=TQiWbOPrkuenRI9GDhMI6vtgmXKxxhQz+QLArm1B2o4E0s95RBgMMJxiBRxyyiZU95
         PrkkcAaXlr7uPuaJ0FXHu9Pc4LgIgxsRvlGmzDNOMVoVTmT2BIbmye1vw+Q8kmYwCnyh
         3BTZ2sTG61knI9+m1AhCIZgX2Eqb4IpXd4E94TlgtK0SfrIJ1Z5nUF4gdeG9s3kYDVvi
         sQgXZuGvtMQMfnZHyw7P0c0Ypmop9jQbzhOHZkBNwbc9Di41RI+8a+byQGS3wEFFoske
         8vxwlhpljFJlUYKj2QRSkFqPga0QZwFXkAt05nhmlu8NtXCN88NAY/a///TeZxv80HHD
         cLbw==
X-Forwarded-Encrypted: i=1; AJvYcCW/ivzoaTDgE9ym2z2sHiGzsR8UxGHxdFuv+WZ/42KN7kPg+Grtn2V2MokkLZKPhylgDQ32isWVEfXnE741Ff+SGCdZ60oN4XjmQ5vD
X-Gm-Message-State: AOJu0Yz0MMFZQa73opIYk2f9AliCWqGe60v6ahx42zH51XCg9vNBpEJf
	fO7f1PcxmjOrlqtC8ej0OotxYa5n++LFeAffPQ3qkTgoa1o33X3cLWIsQx21yY//sFQmoFUYCoM
	8C5yDlWOyS895XajTOHvvU51LQjy9PBdI2bj+
X-Google-Smtp-Source: AGHT+IE+YRbJk7VDMzz3D3amekUL1+l3+CmSNZ5i1D/cQ5UH+VxvljUAhLV8lOJpACZwspK/ZLU2oy1303I7RbZw0xE=
X-Received: by 2002:a05:6102:35c:b0:46d:1ffd:d87d with SMTP id
 e28-20020a056102035c00b0046d1ffdd87dmr3366416vsa.17.1708074600649; Fri, 16
 Feb 2024 01:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214172505.5044-1-dakr@redhat.com> <Zc0UNUGbmmBlzBAv@boqun-archlinux>
 <2d94d420-fca2-47c1-aee7-bbce7a1505cf@ryhl.io> <Zc1mWCBKNuLrS-tI@boqun-archlinux>
 <CAH5fLghO6Jy_hJXhRU_+eBSDHHveAvEOJA6fNkmMS9mqHvS6iQ@mail.gmail.com> <Zc5BJvyGIXgDQ21j@boqun-archlinux>
In-Reply-To: <Zc5BJvyGIXgDQ21j@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 16 Feb 2024 10:09:49 +0100
Message-ID: <CAH5fLggP+vBN=X8TDVkV4Le=Np=5hiCGn5fo+N9=H70zRKXAYw@mail.gmail.com>
Subject: Re: [PATCH v3] rust: str: add {make,to}_{upper,lower}case() to CString
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <alice@ryhl.io>, Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org, 
	alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:51=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Feb 15, 2024 at 10:38:07AM +0100, Alice Ryhl wrote:
> > On Thu, Feb 15, 2024 at 2:18=E2=80=AFAM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Wed, Feb 14, 2024 at 08:59:06PM +0100, Alice Ryhl wrote:
> > > > On 2/14/24 20:27, Boqun Feng wrote:
> > > > > On Wed, Feb 14, 2024 at 06:24:10PM +0100, Danilo Krummrich wrote:
> > > > > > --- a/rust/kernel/str.rs
> > > > > > +++ b/rust/kernel/str.rs
> > > > > > @@ -5,7 +5,7 @@
> > > > > >   use alloc::alloc::AllocError;
> > > > > >   use alloc::vec::Vec;
> > > > > >   use core::fmt::{self, Write};
> > > > > > -use core::ops::{self, Deref, Index};
> > > > > > +use core::ops::{self, Deref, DerefMut, Index};
> > > > > >   use crate::{
> > > > > >       bindings,
> > > > > > @@ -143,6 +143,19 @@ pub const fn from_bytes_with_nul(bytes: &[=
u8]) -> Result<&Self, CStrConvertError
> > > > > >           unsafe { core::mem::transmute(bytes) }
> > > > > >       }
> > > > > > +    /// Creates a mutable [`CStr`] from a `[u8]` without perfo=
rming any
> > > > > > +    /// additional checks.
> > > > > > +    ///
> > > > > > +    /// # Safety
> > > > > > +    ///
> > > > > > +    /// `bytes` *must* end with a `NUL` byte, and should only =
have a single
> > > > > > +    /// `NUL` byte (or the string will be truncated).
> > > > > > +    #[inline]
> > > > > > +    pub const unsafe fn from_bytes_with_nul_unchecked_mut(byte=
s: &mut [u8]) -> &mut CStr {
> > > > > > +        // SAFETY: Properties of `bytes` guaranteed by the saf=
ety precondition.
> > > > > > +        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> > > > >
> > > > > First `.cast::<[u8]>().cast::<CStr>()` is preferred than `as`. Be=
sides,
> > > > > I think the dereference (or reborrow) is only safe if `CStr` is
> > > > > `#[repr(transparent)]. I.e.
> > > > >
> > > > >     #[repr(transparent)]
> > > > >     pub struct CStr([u8]);
> > > > >
> > > > > with that you can implement the function as (you can still use `c=
ast()`
> > > > > implementation, but I sometimes find `transmute` is more simple).
> > > > >
> > > > >      pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes:=
 &mut [u8]) -> &mut CStr {
> > > > >     // SAFETY: `CStr` is transparent to `[u8]`, so the transmute =
is
> > > > >     // safe to do, and per the function safety requirement, `byte=
s`
> > > > >     // is a valid `CStr`.
> > > > >     unsafe { core::mem::transmute(bytes) }
> > > > >      }
> > > > >
> > > > > but this is just my thought, better wait for others' feedback as =
well.
> > > >
> > > > Transmuting references is generally frowned upon. It's better to us=
e a
> > > > pointer cast.
> > > >
> > >
> > > Ok, but honestly, I don't think the pointer casting is better ;-) Wha=
t
> > > wants to be done here is simply converting a `&mut [u8]` to `&mut CSt=
r`,
> > > adding two levels of pointer casting is kinda noise. (Also
> > > `from_bytes_with_nul` uses `transmute` as well).
> >
> > Here's my logic for preferring pointer casts: Transmute raises
> > questions about the layout of fat pointers, whereas pointer casts are
> > obviously okay.
> >
>
> But in this case, eventually you need to worry about fat pointer layout
> when you dereference the `*mut CStr`, right? In other words, the
> dereference is only safe if `*mut [u8]` has the same fat pointer layout
> as `*mut CStr`. I prefer to transmute here because it's a newtype
> paradigm, and transmute kinda makes that clear.

No, if the `*mut CStr` and `*mut [u8]` types disagree on whether the
data or vtable pointer is first in the layout, then an as cast should
swap them.

The question of whether their vtables (well I guess it's just a length
in this case) are compatible is separate.

Alice

