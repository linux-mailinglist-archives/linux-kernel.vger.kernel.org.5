Return-Path: <linux-kernel+bounces-142862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E28A3105
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F29D1F245E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB49D142E88;
	Fri, 12 Apr 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaaXOpS1"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F81422CD;
	Fri, 12 Apr 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932940; cv=none; b=EvzLaYdzbbQ3PHWKU6XdxT5Ns1C1TheRxEBEb/5DT7H36RqUHSghAPfbJlU9EHf338rKDBil/TxUVTvdu6K+w0Oc69DewbY8Wpws7li/T3ROw+NElM3t3kxAJWbOhHwS+DLc+KqkfLOF7DPnxA8ryrKuo3BKPaXQaZA61B5k0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932940; c=relaxed/simple;
	bh=Vx9AcN4PoALM5/qtOiCZ6N7gbWAJhqxvNWL/3pXbHDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHsg2jLtYK3MevF4xIMq/eERY82hfIzMD/uN7PzBGArHLZxhbIczOyF80AlItlJUHA4g8ifol6pPMm5C/8AC7pHsTwn3WEw8UrQ3mgGiqYzXk71GH9zjVMuWWOiLVHaqfKnabCdL1aNp3dT0u3mej7zRyRMfuyKT9gIRLwgWG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaaXOpS1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso743415a12.3;
        Fri, 12 Apr 2024 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712932938; x=1713537738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QFhwob2H+YmXGrRuSyJw5ag+KZ6vVeg830c04nwrNg=;
        b=CaaXOpS13Ccuz7QZIsx9i19yM84GIdG0To3bsPxJH6uToHI4HSfVtLKK0KZXFbrvnD
         w8TCaVpZtcllS5EHipk3QyUqLhyGO+BIRdNjWqlQ+aHQJIose6+7m5K0mP/UBLemFkEK
         To9l1NOajPXy8i+OoPl3kUMwvH/Uc27Wr3SNyRL2TpWDh9u8HfGlTk97yZnMKoEXbem6
         v6TXOXdIlmciBVlhkoUsffWVgBXqIxClmNgw7o5KHHiqdFXtSliF4BbQEU5wihpujsar
         ssNyMxeyHu2Krl2acGpNU6Fpodu5Eu07IP+av+9vLumB3rtKQ3d1eiOyQyO99KxO9Upl
         SLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932938; x=1713537738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QFhwob2H+YmXGrRuSyJw5ag+KZ6vVeg830c04nwrNg=;
        b=nXE6KVBUhkMpaJqLL/wj3WmoyE6wDudpqaIkmq8UUiUpRi1/9BsleYBIt3+dSbsyAs
         nJ/0Gt9HDjxFTfrCSUMphf9jAK9PgMaIo4GK1DMxqinFh+/clfcIdvjUrkzM9K+I7W4g
         JfY26b87P1ZFd/y6j/NKn83nDT6SpFLktT/knnuqD3qUjA2oH/A8MnDWYBWDZXT3BRuH
         nmXFye72AR4QSCHPwqMpqFOGwT1+qiTdd8mCWAR6iuDCd8oYRiveZ+5h8VFZeGFd39kn
         9HWBJ5MlL33v7Q7vb9uFHLKwcxRKEGZfXJ3+uhaUAkqnDDU7zBXg4cJBK2WF2H9ReW5c
         jlVg==
X-Forwarded-Encrypted: i=1; AJvYcCVAhV9dQVQHH2JQvpGXZArB9qpW7z7A8h4Sp5Y8a2xAAQqBBv3tKJMeFSZBcUt1W+6LamWjErUm/2JfurIFizrJwdtBvUGQBqzJ4wpxhHDroKJapQ6/QOiIUFRXvysLlZ1MhkcWNXv15EMthUQ=
X-Gm-Message-State: AOJu0Yxx/iOFcNbzs6+iyRswCeqeJvseQvLQZfuDs1KrosNdyzECQ6N9
	izekgh2dFsLhHT3zhExIOKsVjJHOSBbXqXxXrO5Ng1MTTMn8Tu3aLo6I/+38/fcOGOGY6ir6WNL
	zso3sOEt3SDsL7ZbiEygypXITGco=
X-Google-Smtp-Source: AGHT+IE9wnsUg4rH8z6mmvraJI+4Eo9u935Luu9KrcObKEviVUPWS/ECrhs1BDPQihTBCvx/S6Hyv8KVZGvxU0Dc4t4=
X-Received: by 2002:a17:90a:8c0e:b0:2a5:d313:4d3f with SMTP id
 a14-20020a17090a8c0e00b002a5d3134d3fmr2963704pjo.34.1712932937744; Fri, 12
 Apr 2024 07:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com> <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>
 <Zhk4Uqc4LImR2n_r@Boquns-Mac-mini.home>
In-Reply-To: <Zhk4Uqc4LImR2n_r@Boquns-Mac-mini.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 12 Apr 2024 16:41:26 +0200
Message-ID: <CANiq72ka4UvJzb4dN12fpA1WirgDHXcvPurvc7B9t+iPUfWnew@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 3:34=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> That works for me, although I would prefer `Ktime::sub()` is wrapping
> sub and we have another function doing a safe version of sub.

Why? It goes against the "normal" case in integers. It is also not
what `ktime_sub()` does, which is the "normal" case here, vs.
`_unsafe()` and `_safe()` ones.

> Exactly, ktime_add_safe() doesn't panic if overflow happens, right?
> I think that's pretty clear on how time subsystem wants to handle
> overflow (saturating it, or zeroing it instead of panicing).

There are three variants in C (for addition) that I can see:

  - No suffix: not supposed to wrap.
  - `_unsafe()`: wraps.
  - `_safe()`: saturates.

The first one, in normal C, would be UB. In kernel C, it wraps but may
be detected by UBSAN (this is what Kees is re-introducing very
recently with 557f8c582a9b ("ubsan: Reintroduce signed overflow
sanitizer")).

So, in Rust terms, the three options above would map to:

  - Raw operators.
  - `wrapping_`.
  - `saturating_`.

Because the raw operators are what we use for arithmetic that is "not
supposed to wrap" too. That is, they wrap, but may be checked by the
Kconfig option. Of course, it may be worth having an intermediate
option that does not actually go for a full-blown Rust-panic for that,
but the point is that the current "not supposed to wrap" methods are
the raw operators.

All three, in fact, are "safe" in Rust terms, since none can actually
trigger UB (in kernel C at least -- it would be different in normal C:
the first one would map to an unsafe Rust method, i.e. `unchecked_`).

Instead, in the C side, `_unsafe()` seems to be used to mean instead
"you should be checking for overflow if needed, because it will never
be reported by UBSAN unlike the raw one". Again, this is based on my
reading of that commit and the docs on `_unsafe()`. It may be wrong,
or maybe the subtraction is supposed to be different. It should
probably be clarified in the C side anyway.

And, relatedly, I see that when the `union` was removed in commit
2456e8553544 ("ktime: Get rid of the union"), `ktime_add_unsafe()`
stopped returning a `ktime_t` even when both inputs are `ktime_t`s
themselves:

    static_assert(_Generic(ktime_add(a, b), ktime_t: true, default:
false)); // OK
    static_assert(_Generic(ktime_add_unsafe(a, b), ktime_t: true,
default: false)); // Bad

It returns an `u64` now, which could surprise users, and probably
should be fixed. The only user just puts the result into a `ktime_t`,
so there is no actual issue today.

> I must defer this to Thomas.

Yeah, the question on the C API was meant for Thomas et al.

> Maybe, however neither of this function probably shouldn't have the
> panic-on-overflow behavior. So I agree that overflow checking is not a
> bad thing, but when to check and how to handle overflow should be
> controlled by the users, and making the default behavior
> panic-on-overflow doesn't look reasonable to me.

Yes, it should be controlled by callers, but the point above is that,
from the looks of it, these interfaces are not meant to overflow to
begin with.

Cheers,
Miguel

