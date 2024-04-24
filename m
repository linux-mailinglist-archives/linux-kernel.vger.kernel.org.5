Return-Path: <linux-kernel+bounces-156717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3810D8B0738
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0358283464
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728A315B0F2;
	Wed, 24 Apr 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8PcaHkJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DD15AD85;
	Wed, 24 Apr 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954144; cv=none; b=oBocAeV+aHXQOimhmLrz26pA3Ooxss1s/u4GepQPgvusQHqMQyplGXcoFP6vJdaWII2UKAAYctKwWCuJCKzKo0eYjXXcqV0HU0tOeHk0xF+Q4zWMUq5kBXZL1R9JayWPgIALfmcrnBvxt/Ip2jOgOaasrFSzalLzPiKa+jnFNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954144; c=relaxed/simple;
	bh=RzmmoBga2Obe9acwUPhvYC4BPYcVPH14BtKNDCtLHKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+/HlMZB8Q5kzkH429VQN/ctkyP7lvqBHi2xwdrIlersxRP41SM7qlc/zqEy3ZJwgwHB5oI47Pa3aDQe0QisImcimE2XVAmi2oUD1I0FTj11weUXDN1Rt3WAY/iYV9BA3WaPblf/1RIkuFmIMZl0EjEo2O5ZYGaeRDGofk2DijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8PcaHkJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e4266673bbso60337655ad.2;
        Wed, 24 Apr 2024 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713954142; x=1714558942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzmmoBga2Obe9acwUPhvYC4BPYcVPH14BtKNDCtLHKU=;
        b=f8PcaHkJvylxU45mFSJw/sgm/eZfaBgSntsy2xR0nsbykasEugVumgN2hTfVgaT2Rn
         63iRZlngv2LeaI3fincElrVWvYRkoOkKNUjvaIqOtRU1AbI1wyyB1jrcDWaMaBZtuSw6
         tXXDEHZEZqccTwaDPkj7u308VTUUxtbFoVs94//C6rKddmI1azTqB65t+bLRq5/GRI5i
         o6efSKFJIo2k5zGIsbPNR0pqYSrPgUTsu4m0YV/4GloYlteMuqXhejeVMLAoFBZ+rEvf
         lNvtsHX2MbZSCmyKVAVA3eLMUcIoDkn+aj9M7+RZbFzS60ID6Oz3J3j2Iej1dWFGbOk+
         KKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713954142; x=1714558942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzmmoBga2Obe9acwUPhvYC4BPYcVPH14BtKNDCtLHKU=;
        b=FyBqU4+O4k0q+elFY+2nYPyTllCWoWcH9a4Dtz/FG2jLm7iKJLAzhUlhV+0liybmSI
         zVbxH/tTCLDzDGVbhb8DIuwEOrBpTpc/mtutyKSztilRpgztSRTyn38RrHFt1swqpgGK
         qNLnm2BhdSGahKFj8muf8DmKFTcSdlfv3ZI96dIWmRto+oZh4+9M5aZUQvLfqQzI1v6/
         s9/EItPaEqnXV4TDdhSIkiKKS3D+pXyumbOjjmgawKYdca1sN4ZtHKjkEdES9hLYwXrz
         8Tf98W4SeIxPJctxUc45QtmzLJr3dJVrRMwfVIPfHHPJ66abt4/5LMXOH8eD0VVRNMnM
         Qsug==
X-Forwarded-Encrypted: i=1; AJvYcCWPVLKTZmweVe/0D9OWzWicQISSpfo/OIZXPKsRDt3iOB4N5pAjcjaDZha0vVBs3bEBwfQWsjUeQbDxOS4NRL1jSUWBR5xsyvP7URdyR5M7JRLke4Pc4qgawce5Ag3VhmHMx36LVir3SaRLc3F1RXhPx/oaPBT/R1O4ApcLj4455uHViGnCCXs/H2vNrXc=
X-Gm-Message-State: AOJu0Ywca4KgZQ4fkNLP+oAVX8RAi053tcRPTi1Mm4Os8y9DK66xKL+Z
	WK0E3bHo2L17fvN84OxVlz/TfrwyU9+JApdQRqkr3QQ06OmaipsG5odkUsmCLt1iHBoFFDFT9dQ
	1geImbWrVhCdZJZhboYj49NBuG/M=
X-Google-Smtp-Source: AGHT+IFt2St6wHWhK22oY3M0RR6agHbyWHYxda14P1ZzXBZfwWjGE3d2lbLSjANPq9S34w9kUxjrty7xUxLmEsWzXXk=
X-Received: by 2002:a17:90a:4963:b0:2a6:d064:15d5 with SMTP id
 c90-20020a17090a496300b002a6d06415d5mr1794602pjh.18.1713954142403; Wed, 24
 Apr 2024 03:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com> <Zigj-lY5lnBSKuib@boqun-archlinux>
 <202404231630.20B2693D@keescook>
In-Reply-To: <202404231630.20B2693D@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Apr 2024 12:21:17 +0200
Message-ID: <CANiq72kU+rXsw7SOtw=-fGmDyxWXjYY3zB2Kiixvn-o22BJKzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
To: Kees Cook <keescook@chromium.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, justinstitt@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:37=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> While working on the signed (and unsigned) integer overflow sanitizer
> support on the C side for the kernel, I've also run into timekeeping
> being a questionable area[1]. I *think* from what I can tell, it's always
> expected to have wrapping behavior.

Thanks, that is useful. In that branch you link, since it is about
unsigned, I imagine you could have hit issues with
`ktime_add_unsafe()` -- after all, callers are expecting overflow
there. But there is a single user (which is `ktime_add_safe()`), and I
don't see that one annotated in your branch.

In any case, if `ktime_add()` is supposed to always be wrapping like
the other functions in the area as you mention, then I think
`ktime_add_unsafe()` (i.e. wrapping one) should be renamed into
`ktime_add()` and the existing one removed. And then we can discuss
whether to do (or not) that in Rust too (see below).

However, if the `ktime_add()` / `ktime_add_unsafe()` /
`ktime_add_safe()` split is there for a good reason (see [1] -- sorry,
you were not in Cc in that particular one), and callers are already
expected to respect it, then I think we should document it in the C
side better and we should just start with that approach in the Rust
side too.

> Can we define the type itself to be wrapping? (This has been my plan on
> the C side, but we're still waiting on a finalized implementation of the
> "wraps" attribute.[2])

Yeah, we can make that the "default", so to speak (i.e. what the
operators will do). But we can also have different methods with
different expectations too if needed (i.e. the usual "access" vs.
"type" discussion).

And given the different variations that exist in C (see [1]), it
seemed to me that `ktime_t` operations there may not be expected to
actually wrap, and thus that would be an argument for trying to be
explicit in Rust.

So for the Rust side, what we need here is the expectation of how
`ktime_t` is supposed to be used. Or, even better, how one would
ideally design `ktime_t` today if there were no worry about callers,
because we have the chance to improve here over the C side before we
have those callers.

If the answer is "everyone assumes those to be wrapping, and there are
almost no use cases where the callers know it is not supposed to wrap,
and we don't care about whether they wrap" etc., then yeah, we should
go with wrapping default semantics and accept that we will not gain
that information and thus not catch mistakes easily in the future.

But if the answer is "we would have liked that `ktime_t` was more
explicit, and that is why we have the `ktime_add{,_safe,_unsafe}()`
variations, but nobody uses them because everybody assumes wrapping"
or "we actually assume no wrapping in `ktime_t`, which is why
`ktime_add_*()` exist", then I think we should definitely try to be
explicit on the Rust side from the onset so that we can catch more
bugs in the future.

(I know you know all this, but I was trying to summarize and clarify
the discussion :)

[1] https://lore.kernel.org/rust-for-linux/CANiq72ka4UvJzb4dN12fpA1WirgDHXc=
vPurvc7B9t+iPUfWnew@mail.gmail.com/

Cheers,
Miguel

