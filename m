Return-Path: <linux-kernel+bounces-40640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA9E83E387
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1920A288308
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEB8249E4;
	Fri, 26 Jan 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0daU0s4"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265622F0E;
	Fri, 26 Jan 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302816; cv=none; b=Y2X4Iv1FPoMexZtoS5htsia+eSDFR6300Splx287GP3bVL7we3ooXpDkLMhQkCobwKhpEJBwvmZDbYy4hbBCqVJeEJTkYkWHDhTVOQF56ZfMf12nK1CbMeOugHdarDkjzgtQ8msOS8MZ1TG2OTkidSzk5XbJAPJJQH2K2kIo49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302816; c=relaxed/simple;
	bh=R94U1LlE76uq+NvyE4ngyd9FxAhVaSUa06WGeHuHhIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuQEp0ZOt4BuJgOtlTsNvl6LeRXeKMZY2VzKfw35aSFc5C33ri7ImYDCXUMXkO+voeWDgS3/N3y8sva8ilLh/1Qj0L5GQzvn+PH/Qmw7dcoqY+0kwHVF1+V9DVbg7KmLxBTEIPtvSNyCV5ZSD4Uj7v0aDLZUMmdZw0EEhgs1xQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0daU0s4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-602cab8d7c9so10094707b3.0;
        Fri, 26 Jan 2024 13:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706302814; x=1706907614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R94U1LlE76uq+NvyE4ngyd9FxAhVaSUa06WGeHuHhIU=;
        b=D0daU0s42q1pUtpKW3b0J9EtDz6IHAZMom0Ca6zSyYLIa3C2rPnOgreEkkV2EUlD1s
         kUXU4SDQlmx4qtJOi7Kd9eOjz24bNBCVVf2KDzck4U8d8O/4xT3iXBLF/VH8Bjs4ZwcO
         ekTAcb2gCKQeERGLRHLN5hwgmv/1X5tYqTSWWUjDEsXYM4P6VkdQaTXr6KxX37LLhF14
         0ETuvPEvJKrbxLrnS8jRo3yriLJZY5Y4SgyMuc0NfcK42GX9CdWnZuHWDUoLL7LIWTf0
         k3/ZZkLkqDW+rTh5jbqvKyw/77YdKL82kp4AKS+q8rffqKPK7BJuiiwasLqs5mi8LNuX
         E8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706302814; x=1706907614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R94U1LlE76uq+NvyE4ngyd9FxAhVaSUa06WGeHuHhIU=;
        b=Lqg1i6ps4Qp18wnBG7mNRh83LhSWHh9bKC5dyK4a4BvR+qMFugeMwbDYqOIT9zTL9j
         Vnab/rFNlDz4jXXT4z1jppLdcd2ZHJ6vTswfzSqzWyEM/+Heq6/0hIIISdAldWmvUnBE
         lRVaBS1Zrxy3Q1RH2/VjVRxdQhSNKtpExfish8f4qEkV1mx6ndL0j+0ItnWn3YCmPkUh
         S9v4whaHMRLCQxeuUwZI+ZoaGi3NNQx6UFI+ruASBNFKPx/8eXFjebQLO/LfbvXrC5y5
         B5YK4bnav09+trbotxzj4k49dyqcHtue7UC2clGTymM6C1an/+Quii3NLdL6mcf1X1Lj
         CL7Q==
X-Gm-Message-State: AOJu0YyyH9lobYuhGkml3FmYmyMAxoSG9MBXE5b8ObBbyigDIwUw6hYf
	/Kt761qu7C1VOYE0tbKd89t5+KJ+dMDW+Hy5j098aFUObxl/8PHHtAZvKumzx6SVc50XPSxNCOa
	Jo8g3dtVxoIZo2wNx+rDRNWCxl08=
X-Google-Smtp-Source: AGHT+IHGZFwCjim0Tth1g39N/v/n0KJf4BjgENizS8dPUFq5HPMaf0iymy6drZ65jUMDqf5c20SiR8drFVpMUdT6duo=
X-Received: by 2002:a81:de05:0:b0:5d7:1941:2c18 with SMTP id
 k5-20020a81de05000000b005d719412c18mr410434ywj.69.1706302813724; Fri, 26 Jan
 2024 13:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <20230608-dispatch-sneer-aa09bd7b2eb8@wendy> <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy> <20240117-swiftly-parasail-618d62972d6e@spud>
 <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
 <20240118-implode-delirium-eefdd86e170e@spud> <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
 <20240125-bucked-payroll-47f82077b262@wendy> <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
 <20240125-lazy-thrower-744aacc6632a@wendy>
In-Reply-To: <20240125-lazy-thrower-744aacc6632a@wendy>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 26 Jan 2024 22:00:02 +0100
Message-ID: <CANiq72kb+_utZrYHtoKZQtQazikmkjpVUHpTBcaANizduMF5QQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Matthew Maurer <mmaurer@google.com>, Ramon de C Valle <rcvalle@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 2:46=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Ah, thanks for the direct link :)

My pleasure!

> Actually, thinking about it for a moment - if only a single compiler
> version is supported (the minimum, right?) then you could just add the

Yeah, the minimum listed in `scripts/min-tool-version.sh` and in
`Documentation/process/changes.rst`. It also happens to be the maximum
too, until we can relax that.

> -Zsanitizer=3Dkcfi flag whenever CFI_CLANG and RUST are both set.

Since the flag goes to the Rust compiler, `RUST` would be always
enabled, so the flag would only need to be added when `CFI_CLANG=3Dy`,
no? Or what do you mean?

> I'm not sure if that is a better option though. It's a choice between
> CFI_CLANG being disabled if the check is not updated when the toolchain
> is bumped versus being enabled for C and not for RUST. I think I prefer
> the former though, tracking down the cause of the latter I would rather
> not wish on a user.
>
> I vote for having the check, even if it can only ever be true at the
> moment.

Since we only support a single version, we don't need `rc-option`
tests until we start supporting several versions (which is why other
tests like that do not exist so far).

In my previous message I thought you meant using the flag to test for
arch/target support or similar. That would be fine, but we can also do
the usual `ARCH_SUPPORTS_CFI_RUST` here, I would assume.

Now, during the version bump to a stable flag, if we happen to forget
to update the flag name, it would be a build error, so it should be
easily spotted and fixed. And if we did use an `rc-option` for the
arch/target support idea, it would be the first case you mention, so
it is all good.

What we may want to add, though, to avoid the confusion you mention
meanwhile, is just a `depends on !CFI_CLANG` for `RUST`, like for the
other requirements we have there (which are things that should
eventually go away). Then they can remove that when the `-Z` flag is
deemed ready to be used. But perhaps let's see what Ramon et al. say.

In other words, the flag was added back in 1.68.0 to `rustc`, but it
was not ready, so we need to store the "ready" bit in our side
meanwhile, i.e. we can't know that just by testing the flag itself.

By the way, concerning the tracking issue, since you mentioned it: it
has a list of PRs, but not fixes, there is a "known issues" link
there. On top of that, we are "shifted in time" w.r.t. the latest
status in the compiler, since we use stable versions of the compiler.

Cheers,
Miguel

