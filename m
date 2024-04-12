Return-Path: <linux-kernel+bounces-142121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783788A27C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347E9285F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287DA487BE;
	Fri, 12 Apr 2024 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT9uW/3l"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA046544;
	Fri, 12 Apr 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906097; cv=none; b=WmuODTOmYDywhBdDIjFIjr/ivR12FHdHzfvVPm+B458uO4R3YPGIgDhYGf1EVgtWQ26c0K6OSWmIPpy5HiEMP7CG6n7+GDc7BA1Mos90hBkttADNkPXDZBUPUt9UF7oFKcTqXdKKMb87eAw21oAGa0v7mrpZV/VYkTtSCyND4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906097; c=relaxed/simple;
	bh=MxjuXSodxN0WQ8ThAopn8ROQU7DctnnRsgD3NHjlTsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7Plc8rUwMESOFG0/vMH9iHArsA9Lv7k3/q+2bIBPeSPvDuG/MKvamYerWq5f8kyQH9ZXjvEMq7rl6Xhj2/YxsWCPBEolVIan72qdjGfnvcSjekMMGkJjEII7GsyEDATisGLGqLYCtp2QYf7vwVqrRteqdNvQAK6UIxChL5cNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT9uW/3l; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a2d248a2e1so1145617a91.0;
        Fri, 12 Apr 2024 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712906095; x=1713510895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxjuXSodxN0WQ8ThAopn8ROQU7DctnnRsgD3NHjlTsY=;
        b=OT9uW/3liF5k0D8AB8st/Y9QGc2nHpOwuk8/CkYs/dHq16WcstQF3GhnNCgRqD/y9F
         gVvlz/EVUoZTqIirkhoOjFYwbIT2KmIFLJeOLNvok2FNxhzxDdssOer4+bWXPTYCOlhe
         fxbI1V0C+sAUodQNNGn49q/m7sloop8khhqNvjcmciM5aRC7EfCKRZke/M9zaOErAM0u
         EyOk0HzQoNz/lPGVMoJMl3eaYF5PrcFJxdPLJtM6tkaj9se52RZNFyeDUvdL2Sr6s0LH
         43xxKi4Ve/h6DT63lXHbenEgyxD2IjsnteNBm/x1lYD3m4rRkk7H5nQmgwPzi3nsTIcD
         o92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712906095; x=1713510895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxjuXSodxN0WQ8ThAopn8ROQU7DctnnRsgD3NHjlTsY=;
        b=AGOXZONGMtf1RWNtNNn9ezHGHKdTaN4g231pupStj+7gbULWJH/7rKxUu04P/TlaL0
         lvl7mbQxZKiTrVqHTYH543H5jIik0qyNRw70sr9OCmhZG0mzrmFA41nFvQNNvgcoVs04
         81CYUlyRIF09fhoSbkK59MtJCw/Nz7b6jBNssnkh60oWx60uRjkreVTa5KZ9WqqaaD1o
         Q3Gtrx0FBkjeWnjP1o9pwu7fLYAKkmCrox9noq42Zrg6Jt0Z9ISf80U3agmWPwegO7zm
         mcndv+AmoRvtdjBwqQi17Aq8jRa3cxtjnXH0ZyR1wtghc2ss20/5PZGzzAOAKYrwUqAP
         6Y5w==
X-Forwarded-Encrypted: i=1; AJvYcCVrC2SdM64V8pxFPmLjk2x0IrlGEDE3C+EGee8a9CKwFWfYm4MjomwlHmp/Je/1CpHE4IZ9Xn6d9hsSNXxkPTbluBCJ9g9xzpeL4iLm3S0OWBSJShBW9DPFxKZaUfT1c5LDFLCOwTpIK74gu2A=
X-Gm-Message-State: AOJu0YzhWGxIngYXraaWLCK+M6qTNvILMF1Ztm6qhP75s3DDs8YZWD6i
	gn9Gj0dVozGUrHKJ+qmv/kVJ4/BZ6Fbdj0C33OSM8F7laG4r8wFR0DWpmKdvs+1TqhGlfHhSi4B
	zwplE9rtm1hgKGqbR0PQ7lF8dUVI66+aP
X-Google-Smtp-Source: AGHT+IEx46XCail1opns3CU+PvmMzCoTM22aIt74JIUW82YkUdDLnQzMov7SguH+sF1wE9A94T0lCN28IfIxXLN9+iw=
X-Received: by 2002:a17:90a:38c6:b0:2a4:6ce7:37ad with SMTP id
 x64-20020a17090a38c600b002a46ce737admr2659214pjb.5.1712906095465; Fri, 12 Apr
 2024 00:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411230801.1504496-1-boqun.feng@gmail.com> <20240411230801.1504496-3-boqun.feng@gmail.com>
In-Reply-To: <20240411230801.1504496-3-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 12 Apr 2024 09:14:03 +0200
Message-ID: <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:08=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Currently since Rust code is compiled with "-Coverflow-checks=3Dy", so a

Nit: it is enabled by default, but configurable (`CONFIG_RUST_OVERFLOW_CHEC=
KS`).

> although overflow detection is nice to have, however this makes
> `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
> clear that the overflow checking is helpful, since for example, the
> current binder usage[1] doesn't have the checking.
>
> Therefore make `Ktime::sub()` have the same semantics as `ktime_sub()`:
> overflow behaves like 2s-complement wrapping sub.

If `ktime_sub()`'s callers rely on wrapping in some cases, then an
alternative we should consider is having a method for explicitly
wrapping, like the integers. This would allow callers to decide and it
would make the expected semantics clear since the beginning (which is
the easiest time to add this kind of thing) for Rust code.

Otherwise, I agree we should at least document the preconditions clearly.

Having said that, I see a `ktime_add_unsafe()` too, which was added
due to a UBSAN report for `ktime_add()` in commit 979515c56458 ("time:
Avoid undefined behaviour in ktime_add_safe()"). There is also a
private `ktime_add_safe()` too, which is a saturating one.

So, given that, can callers actually rely on wrapping for these
functions, or not? The documentation on the C side could perhaps be
clarified here (including the mention of UB in `ktime_add_unsafe()` --
we use `-fno-strict-overflow`) and perhaps using the `wrapping_*()` C
functions too.

In addition, Binder calls `ktime_ms_delta()`, not `ktime_sub()`,
right? In that case the arguments are called `later` and `earlier`,
perhaps those have a different expectation even if `ktime_sub()` is
allowed to overflow and thus it would make sense to check in that
function only instead? (and document accordingly)

Thanks!

Cheers,
Miguel

