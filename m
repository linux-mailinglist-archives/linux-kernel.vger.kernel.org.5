Return-Path: <linux-kernel+bounces-158229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244CF8B1D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B2C1F20F52
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C56A8249A;
	Thu, 25 Apr 2024 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="K6S6L3sE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33180056
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035655; cv=none; b=lT3IZv5dTh227/lX6mev1KqVjXZNDhH+L1syMkO6fPnl22F1hX07OgD+23cQEkuVHzgvQYsgKPcT5OuB54C8vP3W8+jKk7Tzvob9t5/bd7iT+R55cmX/Lsy+tiNxnwg8ELVvHTH2iTl7x9ax5vvW+EBpy1Ugxj6b+DeNBo7b6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035655; c=relaxed/simple;
	bh=hxPa/xW4XemSSh+6kDeb4Xm5EBcoU8VCtmv3JFmprx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0JUL07SPLSDp1azZ/HTfaYLMoTwfjzCWfMlWuS5aNWiKYrQhrPyPdF3na6gGi71Ss2Sm408NCOhgvEGqI/ZjX8bHZJtP/qsw+wA2F327jsqJAard63oTDAavPX4jFH/BfFHkrzuQ/MxmZdFyCHyNaQ+Tcp76F2Ms3smfE7P6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=K6S6L3sE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso1009617a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1714035652; x=1714640452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvEI4foK1L+IEvRMU+9j0M20skVBYn6iR5gFVtibc6U=;
        b=K6S6L3sE/hgQ53jCSXJEtfsrfFMOaT7ixm7ZY9B5+94FrHh7v+HO6L3Sz1CA1rd/wE
         kQE6fTwyPKEd92A4ATGdaAyqW8AeoUK/N+QsEmEOSgy96a3hvOi0HXUlhl0gt/98x9fi
         GBupEEYnVkz45EyRaCAjxIIOj+dZUHtaLuWufT7ZeHMbiINx8VvDPdWxH+bcpRG46wAI
         ePAcu9L2BWnKCZo9iRKEva6tjNmd9rroq9R4rtmkGKzNt0hxwveTj6FlEteRKEIob+v4
         Ty/ic2C26x4MIaL3k3o/oYeqQDDEFAlGieVLLow1LU6Zjlj5XX1GArsl1Dvit4WgiSvs
         VqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035652; x=1714640452;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uvEI4foK1L+IEvRMU+9j0M20skVBYn6iR5gFVtibc6U=;
        b=AVmd6vXxhlXa4V3kQ8xUvVfHqyMhaKF6t83sLgvswsL16d8oUqqmSZAlxyeYzwunMR
         h/BxIGVhNcv5Dnc1NkOsZ2QYPcC/kP6zXO2T/zU0Nrbo8B/cFUkdtl3Wo3+2IqY7QoKD
         jQUQKVmH0Vp4CDOMKHp60M9MrTgqPywbgk/nIs3vVVkbA56s3uHmAXNAH96B+ZCChwMo
         Jm5fwaySflVEqbor4fMJm19kjo9LYTmSCoACAa1sJkvqPDsohfTyTbVPJc4mTmxSNCGW
         ueZAWT66cdCUdwFtE1BunszGIQDAUW7lby4DkVPtj89qDt8Ml+IohaIbCbe7Y9eCir4n
         8D4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX1rjgAOEUKqeHX3FqPohx7C8KXB+1nhXz9xqO1aGFVbZKfGTTOEkW3MODa+4htV9kKvrw4XWRVUiisluKzAhZoaIEAd1g3ZKmDy2/
X-Gm-Message-State: AOJu0YyaRK586pPw62uOjfPkz9/02d8CkWt/i6Pgd3J5AZIay9erdHFH
	oXcj7NF22+NIZjD2Dq1YYY+urW0D81ci4RcHN4Q9Jc7gInReTf2dYvllI0uxiVI=
X-Google-Smtp-Source: AGHT+IEPKJB0fifRbgzdg1AP5xzQvJRUxnNuDjffQON6Bb85hb1b2r53VTCuJLLfykdKZy8YCjaamg==
X-Received: by 2002:a17:906:1b45:b0:a52:30d3:41dd with SMTP id p5-20020a1709061b4500b00a5230d341ddmr3498691ejg.41.1714035651546;
        Thu, 25 Apr 2024 02:00:51 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id cf5-20020a170906b2c500b00a587868c5d2sm3315093ejb.195.2024.04.25.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 02:00:51 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,  Thomas Gleixner
 <tglx@linutronix.de>,  Miguel Ojeda <ojeda@kernel.org>,  John Stultz
 <jstultz@google.com>,  Stephen Boyd <sboyd@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>,  Gary
 Guo <gary@garyguo.net>,  bjorn3_gh@protonmail.com,  Benno Lossin
 <benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@samsung.com>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
In-Reply-To: <CAH5fLghL=G-ihevf1_D0aGffmJMtxtSpMDoTGtrmdiDfhwpKnw@mail.gmail.com>
 (Alice
	Ryhl's message of "Fri, 12 Apr 2024 15:51:12 +0200")
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
	<20240411230801.1504496-3-boqun.feng@gmail.com>
	<CAH5fLgg0CkZO9KF58boui6Y5ajpXHuGh0OxyNru2aEG5pNObwQ@mail.gmail.com>
	<Zhk0q-0eM4z5JHqn@Boquns-Mac-mini.home>
	<CAH5fLghL=G-ihevf1_D0aGffmJMtxtSpMDoTGtrmdiDfhwpKnw@mail.gmail.com>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Thu, 25 Apr 2024 11:00:31 +0200
Message-ID: <877cgln7f4.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alice Ryhl <aliceryhl@google.com> writes:

> On Fri, Apr 12, 2024 at 3:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com>=
 wrote:
>>
>> On Fri, Apr 12, 2024 at 10:36:05AM +0200, Alice Ryhl wrote:
>> > On Fri, Apr 12, 2024 at 1:08=E2=80=AFAM Boqun Feng <boqun.feng@gmail.c=
om> wrote:
>> > >
>> > > Currently since Rust code is compiled with "-Coverflow-checks=3Dy", =
so a
>> > > normal substraction may be compiled as an overflow checking and panic
>> > > if overflow happens:
>> > >
>> > >         subq    %rsi, %rdi
>> > >         jo      .LBB0_2
>> > >         movq    %rdi, %rax
>> > >         retq
>> > > .LBB0_2:
>> > >         pushq   %rax
>> > >         leaq    str.0(%rip), %rdi
>> > >         leaq    .L__unnamed_1(%rip), %rdx
>> > >         movl    $33, %esi
>> > >         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(=
%rip)
>> > >
>> > > although overflow detection is nice to have, however this makes
>> > > `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's =
not
>> > > clear that the overflow checking is helpful, since for example, the
>> > > current binder usage[1] doesn't have the checking.
>> >
>> > I don't think this is a good idea at all. Any code that triggers an
>> > overflow in Ktime::sub is wrong, and anyone who enables
>> > CONFIG_RUST_OVERFLOW_CHECKS does so because they want such bugs to be
>> > caught. You may have been able to find one example of a subtraction
>> > that doesn't have a risk of overflow, but overflow bugs really do
>>
>> The point is you won't panic the kernel because of an overflow. I
>> agree that overflow is something we want to catch, but currently
>> ktime_t doesn't panic if overflow happens.
>
> What the CONFIG_RUST_OVERFLOW_CHECKS option does is enable panics on
> overflow. So I don't understand how "it panics on overflow" is an
> argument for removing the overflow check. That's what you asked for!
> One could perhaps argue about whether CONFIG_RUST_OVERFLOW_CHECKS is a
> good idea (I think it is), but that is orthogonal. When
> CONFIG_RUST_OVERFLOW_CHECKS is enabled, you should respect the flag.

I would agree. If users do not want panics on overflow, they disable
RUST_OVERFLOW_CHECKS. If the config is enabled, overflows in ktime sub
should panic, even if it does not do so in equivalent C code.

BR Andreas

