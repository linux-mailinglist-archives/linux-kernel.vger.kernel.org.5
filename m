Return-Path: <linux-kernel+bounces-117632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E688AD82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C388E1C23BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE6B5A7B9;
	Mon, 25 Mar 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H7bFykcs"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32015B7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388704; cv=none; b=ZyYmzy9wHAiA94mym5dLX+VPmRwhkjE8rcjufaxJUG8YAAVcO0nJlRKZagqfPeLY0l0IeeqI2QrVemjFwiXfKN6KMSNMq17WgZkwS3htOBNPDuFr0/kYHqMj3kRMibzG5ruLrT+xpzJFgBwyc33NGTeuC9Ojjb2wO9vh20aNbVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388704; c=relaxed/simple;
	bh=TpmJTEOgQOHM9HmdS/G5PTDNlrGN/J8csNvsXEYpiFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wi+sbkaEv7V4H8iFmzLtrQh5hbbfRW+s068xFOEjbIBM/Q47HN/rXt7Z2JWRjc45LIfqcrxdAiTapYyQ5UILpStEfsNILRzfzpMkPbwPZ0Tz34DuJN7IrEI1A/ZMMmSdVTmXwPdKru0x3iOnxxTVe0pGiGV5BrNFRMp0FcHupCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H7bFykcs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4a34516955so170732266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711388701; x=1711993501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sd/wp9UpBSQuIXx6uQdvepokZABl7yLFwM775FKBHzQ=;
        b=H7bFykcserJ5cGU3RMufzlfQFC8FF2NhXcdeQJzj825g8dMPPYchUeKeKMwUPHkqO+
         VvLA+1PpVES5qmEoH69NHwBsIDT+M0Fve9X+2kyfIUvfMYKo0qBieY/2oK2gGYhmu4QS
         VEMKhJaZwy3Sa/Di3yMnhMw4+D1GxvE6qj0NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388701; x=1711993501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd/wp9UpBSQuIXx6uQdvepokZABl7yLFwM775FKBHzQ=;
        b=r1m91bwtLUBDckGHT2Z0vCDUorqLHt6unyyeJigYXDV7fqgMBr2BN3EqgQ0nPQ6Qyw
         zOeI4+258WbS4KphykeOUhY+kEhG0TNFALnY2i4fxfng0dz7X7Xj84ibKmrvlMEUumkB
         3dJzLBgCP4/jdPnFTG9f5frGO1wdpAWsbRHwKn5lNeJVTHQoWkZ1kq723yHm8yFh1pDk
         L6shZHW03+467mJ5yR/2jbr0Y2EKNn2F9u25ImhqHM59W0tVIG1QlXVL2fCvpOvEinE/
         BrkmUTts/UO+u7H2C/RNTgXkCszOZeeg+rbpArttOqKgRP3q9ds9Ys8RPABlmTBr4fyl
         Z8ng==
X-Forwarded-Encrypted: i=1; AJvYcCWuDu+IVyx4TIXigSVBJYZ9OW772oO2uckKQmKG2d8NrJxREwvNr9J0uY59reK0Ceqyw6ZjzpXF3FrHceV+PwLbs/Hf8SfOFzpHsLp/
X-Gm-Message-State: AOJu0YzB26n3tSm31pJwPxLhTEVwR1xu69JUKXrw+TBmCdwmev4IT8Vo
	PcDsi4EfEc2/LJfnsaJd6ks8okDZ/J6BOJ/d54XKACZJlyzgrE1hxpV7TUrYoZLKbBAjAvLGnjS
	eKmzV0A==
X-Google-Smtp-Source: AGHT+IEQIXlTusnRNeKjiiIV/qIUBEwGGV+ftfAqsqkR9PgSc3jMUyPluyhOZ4zsZHHZSmElQdYswA==
X-Received: by 2002:a17:906:1393:b0:a4c:8625:22b6 with SMTP id f19-20020a170906139300b00a4c862522b6mr1335132ejc.12.1711388701230;
        Mon, 25 Mar 2024 10:45:01 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id lv16-20020a170906bc9000b00a464f709687sm3263774ejb.59.2024.03.25.10.45.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:45:00 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a467d8efe78so551669466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:45:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM0NR5+/fB1NEDOgyzyRtstDm6XkYpF/MneiSUU7DUC8Quoq9+Iiw+ZJXUD6/+SaiJP1abQB8oPGmBvnEg4OQ+NUEzPl5sNeJmF0M7
X-Received: by 2002:a17:906:6dc4:b0:a45:94bf:18e6 with SMTP id
 j4-20020a1709066dc400b00a4594bf18e6mr5614781ejt.73.1711388700462; Mon, 25 Mar
 2024 10:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com> <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
In-Reply-To: <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Mar 2024 10:44:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
Message-ID: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Philipp Stanner <pstanner@redhat.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Mon, 25 Mar 2024 at 06:57, Philipp Stanner <pstanner@redhat.com> wrote:
>
> On Fri, 2024-03-22 at 17:36 -0700, Linus Torvalds wrote:
> >
> > It's kind of like our "volatile" usage. If you read the C (and C++)
> > standards, you'll find that you should use "volatile" on data types.
> > That's almost *never* what the kernel does. The kernel uses
> > "volatile"
> > in _code_ (ie READ_ONCE() etc), and uses it by casting etc.
> >
> > Compiler people don't tend to really like those kinds of things.
>
> Just for my understanding: Why don't they like it?

So I actually think most compiler people are perfectly fine with the
kernel model of mostly doing 'volatile' not on the data structures
themselves, but as accesses through casts.

It's very traditional C, and there's actually nothing particularly odd
about it. Not even from a compiler standpoint.

In fact, I personally will argue that it is fundamentally wrong to
think that the underlying data has to be volatile. A variable may be
entirely stable in some cases (ie locks held), but not in others.

So it's not the *variable* (aka "object") that is 'volatile', it's the
*context* that makes a particular access volatile.

That explains why the kernel has basically zero actual volatile
objects, and 99% of all volatile accesses are done through accessor
functions that use a cast to mark a particular access volatile.

But I've had negative comments from compiler people who read the
standards as language lawyers (which honestly, I despise - it's always
possible to try to argue what the meaning of some wording is), and
particularly C++ people used to be very very antsy about "volatile".

They had some truly _serious_ problems with volatile.

The C++ people spent absolutely insane amounts of time arguing about
"volatile objects" vs "accesses", and how an access through a cast
didn't make the underlying object volatile etc.

There were endless discussions because a lvalue isn't supposed to be
an access (an lvalue is something that is being acted on, and it
shouldn't imply an access because an access will then cause other
things in C++). So a statement expression that was just an lvalue
shouldn't imply an access in C++ originally, but obviously when the
thing was volatile it *had* to do so, and there was gnashing of teeth
over this all.

And all of it was purely semantic nitpicking about random wording. The
C++ people finally tried to save face by claiming that it was always
the C (not C++) rules that were unclear, and introduced the notion of
"glvalue", and it's all good now, but there's literally decades of
language lawyering and pointless nitpicking about the difference
between "objects" and "accesses".

Sane people didn't care, but if you reported a compiler bug about
volatile use, you had better be ready to sit back and be flamed for
how your volatile pointer cast wasn't an "object" and that the
compiler that clearly generated wrong code was technically correct,
and that your mother was a hamster.

It's a bit like the NULL debacle. Another thing that took the C++
people a couple of decades to admit they were wrong all along, and
that NULL isn't actually 'integer zero' in any sane language that
claims to care deeply about types.

[ And again, to save face, at no point did they say "ok, '(void *)0'
is fine" - they introduced a new __nullptr thing just so that they
wouldn't have to admit that their decades of arguing was just them
being wrong. You'll find another decade of arguments explaining the
finer details about _that_ difference ]

It turns out that the people who are language-lawyering nitpickers are
then happy to be "proven right" by adding some more pointless
syntacting language-lawyering language.

Which I guess makes sense, but to the rest of us it all looks a bit pointless.

                  Linus

