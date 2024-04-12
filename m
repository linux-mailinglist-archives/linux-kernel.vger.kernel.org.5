Return-Path: <linux-kernel+bounces-142242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CCC8A296D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FD1B225BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A446138FA3;
	Fri, 12 Apr 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxf+OBHG"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3F1B81F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910980; cv=none; b=pR3KXLWGSHaD+Xwqe0R6YcEa/9+eKWcp/65A+aii2b2kIb4KmhEO7UZ83k6RPgij1WhlU1v5Td0vo6D8M5lk8DGKoukY5SXXqoRwbUxzs2tqFJaONkVVpw3fOiKoA0oapdUtwFAwUA0H8oaV88FyeSQhst8QzRymwd7liu5k59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910980; c=relaxed/simple;
	bh=icsXkT0xOb6e+1xr9g6dtXExIPMijW/K98732uk8zLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hav4X29Wb9OD+D829t+NmLFYyMNR42wOcCZhvym2LjVwkeU71Ft7eBlorYkpxtm155EWw3cPtzd46MOQ3PlRjWE/Gi6Co/9E9VwaSqnmXMP1TBGba0IgMjdb7TkcFX2Gfwzn6rZUcHi8nNmoOUjRvGqG1A9tjjO1xrQPN2eXWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxf+OBHG; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7e7bd3e7d0aso180645241.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712910977; x=1713515777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwTW8iE9nJVGzJXr2vldh3noIwLG2G8OB3Efo+SZIqE=;
        b=qxf+OBHGRqPwF/JjAr1m9zngOp3YGqbpB9PJS3wXxpOIl+WjESNKURUeOJc3MJB5ud
         HTrCOSTbFGKPTb08+q0cfy3D6qZBLHPg4B+2ZktQ6hvdHFueDc9GNB2N3gHTHAtKWd55
         y+IgDqZ86a+JkQW+JbqTPBAsDGQ8VhGG9N1MxUMLN4ALhU43V72vkbarIXhVDBJUwPqb
         +FYXuM51KItRspYIaHftajaqNHl8YJGUSIP9SXzQB/6YHa24nVpcs/mrPZetgPkaxljX
         j+PsdzZQT1A9z4FuaZrz99A+9HM84SYNaJ0jlifIpj8t06w95TZNIMmqIxxkx4h5FMF2
         qF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712910977; x=1713515777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwTW8iE9nJVGzJXr2vldh3noIwLG2G8OB3Efo+SZIqE=;
        b=DOpY9yg9r+8RKTv4mfUWfBobB7+3h2j/UqhxmF1x9TI0LBLFbpr+arUiJmp6l71Mo9
         JeBET/m8I953P0emYRNUGzQ4cXz4i7d0NhtxKQF7hAxV0CHSTjQx/+ARLYiShz3Suvh6
         MmymmI4KBcTI5ZMke4zOHATM9CKoEz8c+YdxJKdrgbDe1K70DDab5EKseFzikctoS8KU
         eMhfV8jCS+qOaPjGoL/HxeqQHZWlFWKY+kTAm3Gndb8ymGQtJYos092myll5fMkG8My2
         4ipUCyHc30LWfDiJAcc4Ivsz6wt9eNvRQdyUOrX6mPEYkgIXmQOH3n3FxLxXhlWn3QGd
         ChGA==
X-Forwarded-Encrypted: i=1; AJvYcCXAKX0gtG61FFknYfIdYUaGrq557TycNxfXvuJETP3JTmf4/ljEvliQ3gYjq3ulZJ5btjrFZYbpSUdrVRfCxu+1YVTF1NFfO1cU6ksT
X-Gm-Message-State: AOJu0YwUhEclR52YHdaz8X8BiUSzFkCCgEcVDbhxzAqN57OK1Q0TTuN7
	KrZdohyb/vW0CjI7TN+TVlBcH2k+JoqHw8lhHar7xfcNR8cEGtlzNlSt2rp9i6vrqMiSlL0PpSI
	FUTEWfP+xY8t1jPH0WPx6kXcxI+W6Sxr4FZ2G
X-Google-Smtp-Source: AGHT+IFOFFi3ViOVoOD1KndrTnby69/2E/tV4wV+grVEX/qVdsAByWdqEzJf07hfF6DtoBQbHiGWIc7+81kZy2zFfpQ=
X-Received: by 2002:a05:6122:16a4:b0:4da:e977:1fb7 with SMTP id
 36-20020a05612216a400b004dae9771fb7mr2234667vkl.15.1712910977298; Fri, 12 Apr
 2024 01:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411230801.1504496-1-boqun.feng@gmail.com> <20240411230801.1504496-3-boqun.feng@gmail.com>
In-Reply-To: <20240411230801.1504496-3-boqun.feng@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 12 Apr 2024 10:36:05 +0200
Message-ID: <CAH5fLgg0CkZO9KF58boui6Y5ajpXHuGh0OxyNru2aEG5pNObwQ@mail.gmail.com>
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

On Fri, Apr 12, 2024 at 1:08=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Currently since Rust code is compiled with "-Coverflow-checks=3Dy", so a
> normal substraction may be compiled as an overflow checking and panic
> if overflow happens:
>
>         subq    %rsi, %rdi
>         jo      .LBB0_2
>         movq    %rdi, %rax
>         retq
> .LBB0_2:
>         pushq   %rax
>         leaq    str.0(%rip), %rdi
>         leaq    .L__unnamed_1(%rip), %rdx
>         movl    $33, %esi
>         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%rip)
>
> although overflow detection is nice to have, however this makes
> `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
> clear that the overflow checking is helpful, since for example, the
> current binder usage[1] doesn't have the checking.

I don't think this is a good idea at all. Any code that triggers an
overflow in Ktime::sub is wrong, and anyone who enables
CONFIG_RUST_OVERFLOW_CHECKS does so because they want such bugs to be
caught. You may have been able to find one example of a subtraction
that doesn't have a risk of overflow, but overflow bugs really do
happen in the real world. I have seen real examples of bugs in Rust
code, where overflow checks were the reason the bug was not a security
vulnerability.

> Therefore make `Ktime::sub()` have the same semantics as `ktime_sub()`:
> overflow behaves like 2s-complement wrapping sub.

From Miguel's reply, it sounds like 2s-complement wrapping is not even
the semantics of ktime_sub. The semantics are just UB.

Alice

