Return-Path: <linux-kernel+bounces-118348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458D88B8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5791F35090
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4B129E80;
	Tue, 26 Mar 2024 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FE8d599P"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824E128823
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711424973; cv=none; b=I+5fA56xZPn9+CjZeC1ALuup7zkgqSz32rJpbOQaGkdMDeihvY3wH/syZ7PuZhlwMkPxVBoW7NaWa+OjcxKKFI6l9Zkd3C25l2I6uS09f0tOBf0SnCtTgBM1J6ap2ecZRw4I/QGYsSjaXWH9ThZr31j4eeRttPhLNaP9xZnXAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711424973; c=relaxed/simple;
	bh=WOA0jjSHA8PSWAbj27+clOuIsbbUO3Vmsfst/KpUulY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpZON6Bx3v/AE8GpfycUBpOXGMlGUcEaAlOuyOCpYfDZOOf+7E7KEt/LaKQtI2EaZrZmJvuUNWFSmBluZUB4PJ/AezZhZnDFFSSlAElOU2tUZOdR/UnBaRPs7zz5IDD1Hz/H8Tp03C1FSMrjESXdD2ZKzRgV2xD813aTWhX794s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FE8d599P; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso596296066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711424970; x=1712029770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIHIysdOPquKQ4BdUP2bPIlHtyK3i5gWkh5V6JlSRrw=;
        b=FE8d599PqO0mz5TCcNqoIgT5rWumW+8LqUSdbgCz3ZRWsd6mohEgWV4g5rauZKVVEW
         spAMeRFPzXqZl0+WPUIjFzjPqdyMOcKxdu1Kk+mxa2EXHLZwSL9w9mPNneW6pnRPUjEe
         NH53LL5tBqVf4Tkzp0XFZPqC/jg4fTq0Du7cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711424970; x=1712029770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIHIysdOPquKQ4BdUP2bPIlHtyK3i5gWkh5V6JlSRrw=;
        b=RJEkqYOZx6d9xTPImxsJ/t5WVnukdpz9azHFrOwh8Z6tZu368i3lmXqIwUQmJfA2/2
         Fwoc6PUAIwiTvTgjBaMNKd3nOQpKbfpYTfOXE97czT028SZPjvVQRaNVLdeYnK0HrCLh
         sRaKW9N7+dxjEkrd20yNBx1yojbPu7pZI7kvPJzKbWOIbvFEXpvgVaCWFBzj5m1VeAc4
         DvxVawXYvnhcfgCWdn9erdqnLOPbZo9Dp66OTWxKScsbOlEnhaKVQm9aox5hGopdPORj
         2Hd73MRqsLwfDhe0Hz0nOGQs6DJ4iXxktCOOaqzN5Che1TP77MCepiH6qKeD1exYxt0o
         hvdA==
X-Forwarded-Encrypted: i=1; AJvYcCV7YNDrEtl+BjQD4FPSXWHQk8MB8O+DWx2C7D426djYxNEmEOu17WM3/bmrjWUYh70iFOo2t3lbvsOMYWAwEe+N4EwvpiXuZNK4QB2M
X-Gm-Message-State: AOJu0Yz/Wv3k0Rkxn/q2OKpAPilKBo11xQOlaCbaEQhjQC2uajbQ/NWa
	3l3TUNIbQudaddtVG7PwrjUVFNu8KGwGZD3WTxxIog2nB8/fX+x/FcuCXG7alHWKGnM+G6UDKIv
	W+kF12Q==
X-Google-Smtp-Source: AGHT+IHLOJB0MM3rwZ/9Gt6I5zOitf6sfbNZrIm7yZkaF4eSBfywSkk9KLFP8y32NDGOTLpAxhtI7Q==
X-Received: by 2002:a17:906:4541:b0:a46:cf63:d96b with SMTP id s1-20020a170906454100b00a46cf63d96bmr6381007ejq.51.1711424969644;
        Mon, 25 Mar 2024 20:49:29 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id bl1-20020a170906c24100b00a46bed423a0sm3720251ejb.23.2024.03.25.20.49.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 20:49:28 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a45f257b81fso584715166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:49:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlMfzUGznYOsf9Snfg5qkGUrAZJEBZUDcybdHJg//H0+MODQBHfotqIfJgheVNfzZDn8vWK1UrKWuuIW/pIBJOc8VYYTUD7BYwrTZ/
X-Received: by 2002:a17:907:9722:b0:a47:48b0:922e with SMTP id
 jg34-20020a170907972200b00a4748b0922emr6654391ejc.23.1711424968017; Mon, 25
 Mar 2024 20:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com> <ZgIRXL5YM2AwBD0Y@gallifrey>
In-Reply-To: <ZgIRXL5YM2AwBD0Y@gallifrey>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Mar 2024 20:49:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
Message-ID: <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Philipp Stanner <pstanner@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 17:05, Dr. David Alan Gilbert <dave@treblig.org> wrote:
>
> Isn't one of the aims of the Rust/C++ idea that you can't forget to access
> a shared piece of data atomically?

If that is an aim, it's a really *bad* one.

Really.

It very much should never have been an aim, and I hope it wasn't. I
think, and hope, that the source of the C++ and Rust bad decisions is
cluelessness, not active malice.

Take Rust - one big point of Rust is the whole "safe" thing, but it's
very much not a straightjacket like Pascal was. There's a "safe" part
to Rust, but equally importantly, there's also the "unsafe" part to
Rust.

The safe part is the one that most programmers are supposed to use.
It's the one that allows you to not have to worry too much about
things. It's the part that makes it much harder to screw up.

But the *unsafe* part is what makes Rust powerful. It's the part that
works behind the curtain. It's the part that may be needed to make the
safe parts *work*.

And yes, an application programmer might never actually need to use
it, and in fact in many projects the rule might be that unsafe Rust is
simply never even an option - but that doesn't mean that the unsafe
parts don't exist.

Because those unsafe parts are needed to make it all work in reality.

And you should never EVER base your whole design around the "safe"
part. Then you get a language that is a straight-jacket.

So I'd very strongly argue that the core atomics should be done the
"unsafe" way - allow people to specify exactly when they want exactly
what access. Allow people to mix and match and have overlapping
partial aliases, because if you implement things like locking, you
*need* those partially aliasing accesses, and you need to make
overlapping atomics where sometimes you access only one part of the
field.

And yes, that will be unsafe, and it might even be unportable, but
it's exactly the kind of thing you need in order to avoid having to
use assembly language to do your locking.

And by all means, you should relegate that to the "unsafe corner" of
the language. And maybe don't talk about the unsafe sharp edges in the
first chapter of the book about the language.

But you should _start_ the design of your language memory model around
the unsafe "raw atomic access operations" model.

Then you can use those strictly more powerful operations, and you
create an object model *around* it.

So you create safe objects like just an atomic counter. In *that*
corner of the language, you have the "safe atomics" - they aren't the
fundamental implementation, but they are the safe wrappers *around*
the more powerful (but unsafe) core.

With that "atomic counter" you cannot forget to do atomic accesses,
because that safe corner of the world doesn't _have_ anything but the
safe atomic accesses for every time you use the object.

See? Having the capability to do powerful and maybe unsafe things does
not force people to expose and use all that power. You can - and
should - wrap the powerful model with safer and simpler interfaces.

This isn't something specific to atomics. Not even remotely. This is
quite fundamental. You often literally _cannot_ do interesting things
using only safe interfaces. You want safe memory allocations - but to
actually write the allocator itself, you want to have all those unsafe
escape methods - all those raw pointers with arbitrary arithmetic etc.

And if you don't have unsafe escapes, you end up doing what so many
languages did: the libraries are written in something more powerful
like C, because C literally can do things that other languages
*cannot* do.

Don't let people fool you with talk about Turing machines and similar
smoke-and-mirror garbage. It's a bedtime story for first-year CS
students. It's not true.

Not all languages are created equal. Not all languages can do the same
things. If your language doesn't have those unsafe escapes, your
language is inherently weaker, and inherently worse for it.

           Linus

