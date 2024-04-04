Return-Path: <linux-kernel+bounces-131455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4BA89881C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381C51F211EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEFE86ACA;
	Thu,  4 Apr 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qy1ePvkI"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A086246
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234486; cv=none; b=RNrf/k9/dWbgxNxq9JoiPCC9c79KCFRp4SJLyXQY4aP62t1q6cIUZ0RWBFuMITn5qNJBwj978IYPJlpOm4f7DwyZTFLAaeeYxL8kfeGMFjv0XKXBryFgWE1HXo51g5Tk0roKGBxWHTBGzrtqu7eUvB1bL0QJxZSyUXqUiVPav30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234486; c=relaxed/simple;
	bh=VB1gjWxgq3H3NWgFmMgqv5zGPvWFQxnyCbF71rK8suI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bT1UI/KejRMGcW3uFUvsazw8prrNIGPdJlJMTeX1Dp4PeT525m3fOjsq2Zn7rzAl4Xj+AUtOa3HJd6VaWKqLRUaD9w/c4WLAG6ahh1vmDjHnEwsPWftT+8SshxDibrmVhWz5+QCCc1rHlcbGxgnt6Iuf5bzahI8twForeCX/Rm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qy1ePvkI; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4765e6cf37aso362029137.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712234483; x=1712839283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHQ1Hof4gKb6D2NbosG6UAy+Sr/kwbAbAaqsg+GZo3M=;
        b=Qy1ePvkIpEeKVx5r2hWz1rtWhyOnJDoZc5CbaRenjPfppRgetFmbzBOx7yqBYo7MIW
         Mrco8kiG9qpqDsqTjeXOZrOOkjuRmhqRJUW5OIRMUMeAPrk2OPJ5Xqe+swUp774mCIOG
         ldAXHkmogdYs9czovxgUs3FiiiQTFC+x0GnXcTpat4QHUzPyVr2xCOfYS3cFLvm1NF1y
         +wbbJPHlhY7lUMQyhn8LHOPTcVdmMIvTTz0Dq3aQayb3Hk8Fzp3uH3kP99lSYF0wcsec
         aheHdHRLK92e81esFD+QBo1ZVHXbQ5jMRKbTtduftWIICoJqe/nwY6yHtwgLt5K0231V
         bE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712234483; x=1712839283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHQ1Hof4gKb6D2NbosG6UAy+Sr/kwbAbAaqsg+GZo3M=;
        b=rTBs+5zTneDHGsWyh0OLRHFlGwl4oq76W57iKETdRm0fUyLAx2IXVtUbjRWVs6OOTY
         CyS8QPpMGe5DmU7708skq9rzlP14j1FUk3y6e74P65kvg3l7WB6hjhe51FwGLMEW/X80
         idQgyOViL8qBImS+oCJhpSq4ywrUHNhZGmnzFcwU8nnUsEcWoY7nZdvv8b6EXBIg/uiP
         3pe+cC5wOHuaUWF8PSHPLFdhTW70GeG+N0trp8sr6LqDslPycEqMkFg/skHwQCyjyn7M
         PwqIpqnyYxLn//yhLtF/F9KY3xozVADwNJq/ruRdqV7rtEv4lPQOA8wPHOD6pV6sUkPB
         HwFw==
X-Forwarded-Encrypted: i=1; AJvYcCXhfZ1oc8+t+MqF5VMd76u6EjwNFGvIl75saCk0pdQ2J0OHVhHSfrQ7a0ajb5K+/kfm+JxRaL6eYewtBcTg0h/o2nOhiEk9OCdAqv3E
X-Gm-Message-State: AOJu0YwsI5PkC/qVS1KCR/kojUb5vifDRuZxyXpm7cFAbjf5q8FAQsfg
	F2oMdxkAxNG48wYFxabAxr4WDFTxt9cU4ZEPeh0zpwvjSXa8D1IozHlQTLzdI1e6/YB+Fy6qf7v
	lszXdOQlANtwvdtPkr4OCnqb7d4T1NcPgKmyr
X-Google-Smtp-Source: AGHT+IFPUV3XDlGbaJh0qXH0CVflqRkGjDzOhIshfasLsrm7uDlKmnUOsZ0i2TrnZBi4+kj/z4V7VA3vArBGT/irjZQ=
X-Received: by 2002:a67:fb4d:0:b0:479:bffa:1b53 with SMTP id
 e13-20020a67fb4d000000b00479bffa1b53mr1975366vsr.7.1712234483409; Thu, 04 Apr
 2024 05:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401212303.537355-1-ojeda@kernel.org> <20240401212303.537355-4-ojeda@kernel.org>
In-Reply-To: <20240401212303.537355-4-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 14:41:12 +0200
Message-ID: <CAH5fLgiLCraafBG5+n_TLZ_hRHM7Yj49QDd=TudHJVkomXyLqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.78.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is the next upgrade to the Rust toolchain, from 1.77.1 to 1.78.0
> (i.e. the latest) [1].
>
> See the upgrade policy [2] and the comments on the first upgrade in
> commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").
>
> # Unstable features
>
> There have been no changes to the set of unstable features used in
> our own code. Therefore, the only unstable features allowed to be used
> outside the `kernel` crate is still `new_uninit`.
>
> However, since we are finally dropping our `alloc` fork [3], all the
> unstable features used by `alloc` (~30 language ones, ~60 library ones)
> are not a concern anymore. This reduces the maintenance burden, increases
> the chances of new compiler versions working without changes and gets
> us closer to the goal of supporting several compiler versions.
>
> It also means that, ignoring non-language/library features, we are
> currently left with just the few language features needed to implement th=
e
> kernel `Arc`, the `new_uninit` library feature, the `compiler_builtins`
> marker and the few `no_*` `cfg`s we pass when compiling `core`/`alloc`.
>
> Please see [4] for details.
>
> # Required changes
>
> ## LLVM's data layout
>
> Rust 1.77.0 (i.e. the previous upgrade) introduced a check for matching
> LLVM data layouts [5]. Then, Rust 1.78.0 upgraded LLVM's bundled major
> version from 17 to 18 [6], which changed the data layout in x86 [7]. Thus
> update the data layout in our custom target specification for x86 so
> that the compiler does not complain about the mismatch:
>
>     error: data-layout for target `target-5559158138856098584`,
>     `e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S1=
28`,
>     differs from LLVM target's `x86_64-linux-gnu` default layout,
>     `e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16=
:32:64-S128`
>
> In the future, the goal is to drop the custom target specifications.
> Meanwhile, if we want to support other LLVM versions used in `rustc`
> (e.g. for LTO), we will need to add some extra logic (e.g. conditional on
> LLVM's version, or extracting the data layout from an existing built-in
> target specification).
>
> ## `unused_imports`
>
> Rust's `unused_imports` lint covers both unused and redundant imports.
> Now, in 1.78.0, the lint detects more cases of redundant imports [8].
> Thus one of the previous patches cleaned them up.
>
> ## Clippy's `new_without_default`
>
> Clippy now suggests to implement `Default` even when `new()` is `const`,
> since `Default::default()` may call `const` functions even if it is not
> `const` itself [9]. Thus one of the previous patches implemented it.
>
> # Other changes in Rust
>
> Rust 1.78.0 introduced `feature(asm_goto)` [10] [11]. This feature was
> discussed in the past [12].
>
> Rust 1.78.0 introduced support for mutable pointers to Rust statics,
> including a test case for the Linux kernel's `VTABLE` use case [13].
>
> Rust 1.78.0 with debug assertions enabled (i.e. `-Cdebug-assertions=3Dy`,
> kernel's `CONFIG_RUST_DEBUG_ASSERTIONS=3Dy`) now always checks all unsafe
> preconditions, without a way to opt-out for particular cases [14].
>
> Rust 1.78.0 also improved a couple issues we reported when giving feedbac=
k
> for the new `--check-cfg` feature [15] [16].
>
> # `alloc` upgrade and reviewing
>
> As mentioned above, compiler upgrades will not update `alloc` anymore,
> since we are dropping our `alloc` fork [3].
>
> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1=
780-2024-05-02 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://lore.kernel.org/rust-for-linux/20240328013603.206764-1-weds=
onaf@gmail.com/ [3]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [4]
> Link: https://github.com/rust-lang/rust/pull/120062 [5]
> Link: https://github.com/rust-lang/rust/pull/120055 [6]
> Link: https://reviews.llvm.org/D86310 [7]
> Link: https://github.com/rust-lang/rust/pull/117772 [8]
> Link: https://github.com/rust-lang/rust-clippy/pull/10903 [9]
> Link: https://github.com/rust-lang/rust/pull/119365 [10]
> Link: https://github.com/rust-lang/rust/issues/119364 [11]
> Link: https://lore.kernel.org/rust-for-linux/ZWipTZysC2YL7qsq@Boquns-Mac-=
mini.home/ [12]
> Link: https://github.com/rust-lang/rust/pull/120932 [13]
> Link: https://github.com/rust-lang/rust/issues/120969 [14]
> Link: https://github.com/rust-lang/rust/pull/121202 [15]
> Link: https://github.com/rust-lang/rust/pull/121237 [16]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

