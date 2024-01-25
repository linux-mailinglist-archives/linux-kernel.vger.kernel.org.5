Return-Path: <linux-kernel+bounces-38589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414F83C2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7931A1C21BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39BE45C0E;
	Thu, 25 Jan 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tSwDac9F"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193D321AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186438; cv=none; b=C85syoozS6Q1dKI7wM60OmRkCAb1Un9zl/W6VYCKSZcmYJ9/58rIjz2K0Mvff5Jk4M2NAj2MAq56T64Efe4X2O9vvJW4Earyk18SzJgHGKvGIPNHR9aXLVtrDSxRi+YGbVI/nV2jNjFo/IM/F6yk+kA3R9gYGzlGcHuba5Jvwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186438; c=relaxed/simple;
	bh=hM2iHfDe3tq4q5QhAuG5llL9QvEutMz9ZFyDgZKy5J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeDedp9HGbMxpTZb2xUIoRql4GRGEyd2c3V1Tm4gzBpZyQzB9fIFEicN2YJTrlLHrevjjFCYzSTpAEdXMrZvjZU5nvOiqN0b/b+yUQR79daMvGagAj7SzirNrwuZaeIjATPLds32MnOGXNDAmglljyFCqumsd4Ez6mNj/EZjjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tSwDac9F; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso1535379241.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706186435; x=1706791235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNi4MiQOUNCak4EWaCvvPwFzUIE3TXQJ5X1CGwYGEDU=;
        b=tSwDac9F+Gq39agFJa7n4+dKGJ+3I5KVCjk23tNLJug/yMgk2yAfngenoG1KSddIjE
         Q2k2ozYntrI0wxqrdpc2qHazuP/spOIrv14zBe9P9VTDfUCwuLjTrd36rigrqKzK8/Kk
         kW3DfBU+oBb5VpCpM4go7nFE3eYhYLWC4Ug+H13I6eMsD5ql3Dzp3L7jJvZsFSlTK9hf
         //anbCbNcdjKmQ03lmv1vne2w/5Ev4PsS2lPbgu79ayvZ2zDyw9JqV5OKEZE38cv6OBs
         hYw2R95rtsaXLwGOJvoG11uBOWdBGfodK71LePGHQZUWZ+lYX41E+QpsiLqtyYkcrdWB
         DjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706186435; x=1706791235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNi4MiQOUNCak4EWaCvvPwFzUIE3TXQJ5X1CGwYGEDU=;
        b=hTnqU9t6L6EnQAOjH5SsD+RxwpY29CKlEXiQaKqSqvP3dqcCr3XjKcBQyeeGKTI+te
         yEO4E2US1JhXXrBA6z4Ww8rBqRbbNxWSZ1S2ZvJaJehNiB5/MTsDiJAYUvqeBY6C30lH
         GkAV/o7NBCod9W32BFrtz3YgMNYXinsD72nr4JM5xctGEJb2k0ZhBTV+JCtbGBWtsrgG
         EA6g+5wn4sqCpoyiQng2USy+fQsSjYIc0j24tfsZb6vmbWSrOpKVRZEz12zxffMu6gi2
         lzTFHWAi4qsI2k37kzRWAuS1fTB0uuKtPxSYef1BFu4YOm7si5raDno9fM7zFZ0a+HM0
         /bkQ==
X-Gm-Message-State: AOJu0Yxc6D3d2Zmr5pWmXZMV2PLNOYP684d8Fx3q2LMc2H6Qw/w/9bEV
	3lujXL/liUO2TfPagPavjfkLv0QbRgkfhro+kRM1ygaNN4P2dRW8SQVLglGtu4gs76b6/HCXy+m
	ZUgu+f569bIjtnbaIRImcFIgYQWS/dgz8l0Tv
X-Google-Smtp-Source: AGHT+IH1C55pZ2RrYSAI4VVBDqlGGHUKM5ynO7yFHVq9bA/uLjts2Z1tsbUOhk0J8KAoOccE1G3W7HnpyeekB5BCP+Q=
X-Received: by 2002:a1f:c344:0:b0:4bd:3433:aac with SMTP id
 t65-20020a1fc344000000b004bd34330aacmr271077vkf.15.1706186435236; Thu, 25 Jan
 2024 04:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-2-d1abcec83c44@google.com> <20240124234626.6435-1-kernel@valentinobst.de>
In-Reply-To: <20240124234626.6435-1-kernel@valentinobst.de>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 25 Jan 2024 13:40:24 +0100
Message-ID: <CAH5fLggBH4POm501a_-Yivvnu0A-rFw8nw87iwUQw2361=pq4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: add typed accessors for userspace pointers
To: Valentin Obst <kernel@valentinobst.de>
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	arnd@arndb.de, arve@android.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, 
	cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:47=E2=80=AFAM Valentin Obst <kernel@valentinobst=
de> wrote:
>
> > +/*
>
> nit: this would be the first comment in the kernel crate to use this
> style, not sure if there is a rule about that though. Maybe still
> preferable to keep it consistent.
>
> > + * These methods skip the `check_object_size` check that `copy_[to|fro=
m]_user`
> > + * normally performs.
>
> nit: They skip the (stronger, and also present without usercopy
> hardening) `check_copy_size` wrapping that one.

The only difference between check_object_size and check_copy_size is
the extra check with __builtin_object_size, but that doesn't work
across the C/Rust boundary, and Rust doesn't have a direct equivalent.

> >                        In C, these checks are skipped whenever the leng=
th is a
> > + * compile-time constant, since when that is the case, the kernel poin=
ter
> > + * usually points at a local variable that is being initialized
>
> Question: I thought that this exemption is about dynamic size
> calculations being more susceptible to bugs than hard-coded ones. Does
> someone recall the original rationale for that?
>
> >                                                                  and th=
e kernel
> > + * pointer is trivially non-dangling.
>
> As far as I know the hardened usercopy checks are not meant to catch
> UAFs but rather about OOB accesses (and some info leaks). For example,
> if the object is on the heap they check if the copy size exceeds the
> allocation size, or, if the object is on the stack, they verify the copy
> size does not leave the stack frame.

Right, I can reword to say OOB instead of UAF.

> > + *
> > + * These helpers serve the same purpose in Rust. Whenever the length i=
s known at
> > + * compile-time, we call this helper to skip the check.
> > + */
> > +unsigned long rust_helper_copy_from_user_unsafe_skip_check_object_size=
(void *to, const void __user *from, unsigned long n)
> > +{
> > +     unsigned long res;
> > +
> > +     might_fault();
> > +     instrument_copy_from_user_before(to, from, n);
> > +     if (should_fail_usercopy())
> > +             return n;
> > +     res =3D raw_copy_from_user(to, from, n);
> > +     instrument_copy_from_user_after(to, from, n, res);
> > +     return res;
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_copy_from_user_unsafe_skip_check_object_=
size);
> > +
> > +unsigned long rust_helper_copy_to_user_unsafe_skip_check_object_size(v=
oid __user *to, const void *from, unsigned long n)
> > +{
> > +     might_fault();
> > +     if (should_fail_usercopy())
> > +             return n;
> > +     instrument_copy_to_user(to, from, n);
> > +     return raw_copy_to_user(to, from, n);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_copy_to_user_unsafe_skip_check_object_si=
ze);
>
> Could those be wrapping `_copy_[to|from]_user` instead?

Yeah maybe, see the other thread with Arnd Bergmann.

Alice

