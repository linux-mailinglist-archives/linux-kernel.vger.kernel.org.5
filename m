Return-Path: <linux-kernel+bounces-45502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA7843199
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72751C235DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661F179DBE;
	Tue, 30 Jan 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3S11V0n"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6879953
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658880; cv=none; b=bEX7uk+4W7VAuVUGvaWZd6JQHrg4npd0P2hk5CTZrtLC6vZ/XCiegKLlXhjUWoC+JA9vnzDZkE5mMSKi1RhlojZ5IO4o/kIcueUnjLYLxPBe/vg9rlwNa5YxMcVEfW36YbtmdK9M16idYkm47zBhhJ+qSM1voph+2KIayH7X3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658880; c=relaxed/simple;
	bh=lY6EOxWIqskA4az3sm8VaAY7CgrmET2UjRxY9QCkAas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6zs7dgCQApAhdxoXakgzLvshDgCXKtLIC+7jjcXGkdVTF6Rc2NaEeC+L1P8YXuJE2NzMjZf+jvcX8aVGeNrc47grTIeVXCz+YU66Q8A4vK1RxbBzuQI7ADItT/BYyvB5wVy3bQwr5XJUjgju2rhb9MOFuuXJ6IbbUZ3nCWGsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3S11V0n; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso6964a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706658877; x=1707263677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvbPhhaL7km4G7kmsFhV1xne1sVsO1kQUeWmVLy5H6s=;
        b=z3S11V0nrUIex2rU59kOE/INuX/qBX/v5OONR0OCD+SjGQG4Jg2yJb65scwjr4Rgde
         mEZEcZjyPyPHsN7IFwyCM606GoZao9GMN+E882mKeZcPkTYNaYLnuDEB5UCzca2VH4UV
         cHbbpc7iANk0yBCOQoeUaiLNzBVgTwsRPWuqhRlesip1I1wgyH5tuimwMRnHLYQPqjJT
         8PEB356hhkJcujs6qih8YdDj/W8jSt7pacANhNjD4BAQ3+LaHP57Xm4h4V6rOMm99XVR
         YcXt9UF9iiwsTnKAHh3SbJ0huIQhXiRxL7BFYLU1F0NPBxZhVSePSn81QkwsYVCoNcXC
         gsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706658877; x=1707263677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvbPhhaL7km4G7kmsFhV1xne1sVsO1kQUeWmVLy5H6s=;
        b=vi5sFKAnDHYWzkBgUPNbUH1N6MBvy8dJVjfwiXqUj/JRCRoXaUBVpAdvEij1+b3s7V
         rlPZVz+9Xtw/Yzpd95i4ki//gFwLYoDlvzQSvnU7uZdyOatOsv76IYc2V1EYnua5gAHi
         Bik2OOBd9VGHxKFcSt0uOl0gYEGYBZ7EbQf+MIY7ZbgKEMBRU+PEbH86L1Q7pD5Z4mB4
         +vYwfcylaALJktBWQodfJpIDOd7MPzEh/ze2lrkc23EWSMdWlBnmU1W1EVzm88Rt0a/Q
         P37g3TDKYTKukIpaK4l2OSQAl0uVv5QJTAMCZP95PZPGzgYffIXQFKHkKcaPjHq6MNnx
         GM3g==
X-Gm-Message-State: AOJu0YwL7EyAmrvMteDaMsUf8phbZsUmbOfwCppg80TKswWieDBdLmFP
	XM4Q3NBgKg141f7RmAX7mmimftGkbh6wDwDTcipgsm2hfV/behpPsBnwp0Y7i1RRwUc9Wn7jckl
	0WBgtuIhLbobPyuiZ3zZrQZd4LxQqOk5z0czBcMsjQJC3aL3/zym8
X-Google-Smtp-Source: AGHT+IFw7KH/Xi74azpntqPhGPADZbvfe3A04kD2nzhHBvAI97+xmChcD+tE4X9GMJICMvQpHey4OmP9A0DAyAHGns8=
X-Received: by 2002:a05:6402:37a:b0:55e:bbe1:a288 with SMTP id
 s26-20020a056402037a00b0055ebbe1a288mr334055edw.6.1706658876933; Tue, 30 Jan
 2024 15:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215194828.2611213-1-mmaurer@google.com> <CANiq72musVZbNW5MuhrRJEmA8G_D3D7Ms0pTYu16WrqhFx2pXg@mail.gmail.com>
 <f17ce61b-7f4f-4851-aa23-b8489686b840@intel.com>
In-Reply-To: <f17ce61b-7f4f-4851-aa23-b8489686b840@intel.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 30 Jan 2024 15:54:25 -0800
Message-ID: <CAGSQo01SLbT2rb8CnXx1hk-17-HHQzVNBqszAa4qMbpa-BbQfQ@mail.gmail.com>
Subject: Re: [PATCH] x86: rust: Disable entry padding with Rust
To: Dave Hansen <dave.hansen@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 3:46=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 1/28/24 09:48, Miguel Ojeda wrote:
> > On Fri, Dec 15, 2023 at 8:48=E2=80=AFPM Matthew Maurer <mmaurer@google.=
com> wrote:
> >> rustc-1.73.0 used by Linux does not support entry padding. Mark entry
> >> padding support as explicitly incompatible with Rust.
> > We are now at 1.74.1 and moving to 1.75.0 for the next cycle, which
> > does not support it yet, in case whoever applies the patch wants to
> > update it in the description.
> >
> >> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > x86: are you picking this one up through your tree? Thanks!
>
> Do we need a 'rust-option' equivalent of 'cc-option', like:
>
> config CC_HAS_ENTRY_PADDING
>         def_bool $(cc-option,-fpatchable-function-entry=3D16,16)
>
> That way this doesn't become a temporary option at all.  We just do:
>
> config RUST_HAS_ENTRY_PADDING
>         def_bool $(rust-option,-fpatchable-function-entry) # or whatever
>
> and:
>
> config HAVE_ENTRY_PADDING
>         def_bool CC_HAS_ENTRY_PADDING
>         depends on !RUST || RUST_HAS_ENTRY_PADDING
>
> and never have to touch this again.
I agree that we'll want something like that in the long term (my
original version of this patch did use something like `rs-option`),
but in this particular case the main thing still being bikeshedded in
the RFC[1] *is* how the option will be specified to the Rust compiler.

We could assume the current form of the RFC which is nearly signed off
on is what will happen, in which case we could add `rs-option` and
test for `-C patchable-function-entry=3Dtotal_nops=3D16,prefix_nops=3D16`,
but there's a chance we could still have to update it until the flag
form is finalized.

Link: https://github.com/rust-lang/rfcs/pull/3543 [1]

