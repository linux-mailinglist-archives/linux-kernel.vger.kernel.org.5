Return-Path: <linux-kernel+bounces-38587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4B783C2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D160E1C2192B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D433D392;
	Thu, 25 Jan 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDxO8Vvq"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F1321AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186241; cv=none; b=s2yPoZGwMA1wBgYaRu3L0q2kDXR6oq6ATJ4j6LWKUFDmPA9O9GuYE8S3yv5COPJgKg8TAw12uf13TNzrHV0Lo7VK1anWQDGehleiqdp9cCryOwvYKHVJC0bGUxELpKIpXGnZonyZ07t/EVx9qkAPWJlN3WsE2+1UW6os/TxZ4I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186241; c=relaxed/simple;
	bh=FMcXpHB/zoqwhqTm+B0dEtaw8ZbOK6U7VxIx0G1qHDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9Al6MV4InOZwHeW0eUGGUnmqTnv3Jg8a241O7x01f3OH4AE/eMUQmA89iH0wi8g7h0crqo849H4P5APAkHvhC/uh0hR6Td84CZjJaA62/4NXarVcBP+wjYwCEcLGL65lADuey5y7xFhBFgsco62k/hfARplhVMI9/ABdkglgPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bDxO8Vvq; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-46afeb936afso901797137.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706186239; x=1706791039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/8P03y0gIOgiGCcOtW8CKbm2M0HUIblwn8rbFoZDFY=;
        b=bDxO8VvqV7O9ZXMkg7JW6vmY+U/T8irJ1Hrx/0YHuBf2y9ufoOfEe5lhEkU81BXSAu
         kiSW7AWjQhdt7aHIRdHBDX2L9I9Z04280x+5ECyxxKt7CkxKIAmr5Glryn2FE58+E7ga
         X/DrQw58/0Myn4Lw75SzZkJosPR1mRA+Ljk0Oz7S/twThSXqU87X6SKMqOrtktiLWNAl
         hBDqU5kc3qHKsfViJW49mS0JFX3snFrs0AHoouRwQQNiJ7Ul04U3Nnn/5CE3Q5XZGSv5
         6ZeYYMnpt1zJ3TcKJr/p/rDfdgyTbLiC0HJ3n+7sy9oN7+46s5YphiLtk6EqCmTNYYDw
         yBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706186239; x=1706791039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/8P03y0gIOgiGCcOtW8CKbm2M0HUIblwn8rbFoZDFY=;
        b=bqj4So52EkI2rPVkHBC4/zn8C7NhLgUGNVp0aEBnC6Mbhi5CaXr/iRbycngSoStc1Z
         d54/g/k6IzvDMSSXezWRzlLZ1WGXSrHF1c+iKO2o7Y1ZanbmC7Xm7kyigJZW1O7fUW+1
         gBOGJCbQ8TtiyttT0GSLCn3lUcbRTOFMGr0AKkrpe5KYpAkxXZ1cliZ0NOLRt2YlMczN
         i+u4XGtPNaOtsbPknwXhsPAOYJFfx4psVta1tXJnGf37t2XGaowcOx2FFM0gmC6MlSbD
         uZIkGsB2JnGaOX0EkkOi9D73234JCYaZq239JcGe1953uQmrVVoO/3untOF2pV8T0ZRN
         Pukw==
X-Gm-Message-State: AOJu0YwlKcp+wE9F6ZTHDV8b1y6WAj+T7C9iApG2pMHGbaxKzo4cIPpQ
	T4tz+tUhHARm1fHYXBel9REgKgHmg8KBBBKTBEvDf55tQOiGchWrTYxDEU0q2yrWGbuLOJiaitI
	3KV+v44NHGlYzYADod6++Bq0HvYBLOzRX7ecX
X-Google-Smtp-Source: AGHT+IFqI2jU/TuA2KsCbcNM1uIUyYNWtYEd44hxAhnlN41+z9ie0Kx+EGlwgTlHDfim/JfM538IlIEQM+1VVQT9H2Q=
X-Received: by 2002:a67:b906:0:b0:46a:efb9:8d16 with SMTP id
 q6-20020a67b906000000b0046aefb98d16mr511164vsn.64.1706186238360; Thu, 25 Jan
 2024 04:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-2-d1abcec83c44@google.com> <070574cb-8d7f-4fe7-9826-cec6110168ff@app.fastmail.com>
In-Reply-To: <070574cb-8d7f-4fe7-9826-cec6110168ff@app.fastmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 25 Jan 2024 13:37:07 +0100
Message-ID: <CAH5fLgi8D18ufma0X49nWhXpnz47t-C=OAtM+wwnYu78hEnwhA@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: add typed accessors for userspace pointers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:27=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jan 24, 2024, at 12:20, Alice Ryhl wrote:
> > +unsigned long
> > rust_helper_copy_from_user_unsafe_skip_check_object_size(void *to,
> > const void __user *from, unsigned long n)
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
> > +unsigned long
> > rust_helper_copy_to_user_unsafe_skip_check_object_size(void __user *to,
> > const void *from, unsigned long n)
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
> These functions are almost identical to the ones in
> lib/usercopy.c for !defined(INLINE_COPY_TO_USER).
>
> That version has an extra memset() after a partial
> copy_from_user(), and you probably want to have the
> same thing here for consistency.
>
> I think ideally we should only have one out-of-line copy
> of these two functions and have that one shared between
> rust and architectures that want the C version out of line
> as well.

I had a bit of trouble figuring out all of the copy_[to/from]_user
methods that are available. I was hoping that a better solution would
be available, and it sounds like one is. Is _copy_from_user always
available as an exported symbol? If it's always available and skips
the check, then I can just use that. I don't think the memset matters
for my case.

Otherwise, I can add a helper in rust/helpers.c that wraps
_copy_from_user only when INLINE_COPY_FROM_USER is defined, and call
the helper in those cases, and otherwise call the exported symbol
directly. (I need an exported symbol to call into C from Rust.)

Would that make sense?

Alice

