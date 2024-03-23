Return-Path: <linux-kernel+bounces-112140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA7887628
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912021F228CA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908810F9;
	Sat, 23 Mar 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TxRpll1Z"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F3621
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154182; cv=none; b=kkMrQ+Uvy8i6ud2AqwyVLLe3dowpQ6FIK5yV+mPqII0qmoVo5chwoVkbj0uu2adD8frYRRGxI2Zu8ECDz8VXl9E+GJK2vRgOd1FoFyFVtSzLOCez3S6gEOY1Ccrj7Y+pmQdTd97AP7YPXSmY6Ng8zlWqpP1hZEP6Vlt2Ofzq34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154182; c=relaxed/simple;
	bh=j7JyDQ2Yopzv+1fWqR18eqoGt0JNvJeLXCqR09mac8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+g24kn9PvOFLvbVdBsv1aQJtanI430i8MCaxRTR0vNHX2aG7sdINpa09prJdSAMkhJiw6eK2jyHy05ncpnKnOYFUoYwonEa4uSVI7DG4VHl8VezPxols2cbY8uEBDi22RDXvSE1LUobVqxr5eCsl02Sq5cUtUhvDelFfkC8Ef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TxRpll1Z; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513e25afabaso3120184e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711154178; x=1711758978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNrld7J3rRC7RvH2KCmmyzFGDmF8jJ8gCeKdRT3S6xQ=;
        b=TxRpll1ZRwp9xCI0psNRvb/2vVISI1rXqL5crZA8I7/8k9GoW5e/VGT7gVDAdaJO3/
         caEgxQ+xcyIsOIumDQ11p6lIaEmS9C7WUTsn1phKr6b7fvQMnKfxxbo9rlvAPUBYBzjG
         zEw2i5MlJN+NyU1pFnSBINdmf/ztn+ZhVTLQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711154178; x=1711758978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNrld7J3rRC7RvH2KCmmyzFGDmF8jJ8gCeKdRT3S6xQ=;
        b=vJb+yJ7MDrGWHBKBT4jvVa6IryvCw4O4bPxzS6l6HAPUx+WNWtVv4Jas54SeV8Ukqy
         k1hQ1Qc5WtXpnyVqJ1NBkIUrsoQRr1kLNO8EZdGjI6kYNzw63G8v8gd7cLk5nSWBSz0v
         TxpRA9dzU3H5O/qydjNa6CKBsbFI3nvdjrZ/40DajIyJChK7F4hIn2SJmU9El3ZmXsw9
         j81HBEVaQFfYczNDnJosMkLHyGJ3FcxQ4L6GqMcQM1yCr7zrxlwGyA3QCDkgLmvYcDzY
         jjU1WAIxGrsr20FeTSDySYyicLOB7PViUVn5MoEuIgcaibAvJTDKW+abvEf2V4I3Jxvk
         JYmA==
X-Forwarded-Encrypted: i=1; AJvYcCWfwjRtyUdYRV5pqbxesYHeH3TYBEpDnXo4W5eb+6ggsDr5Mj83yPa58BAHhbCaw8BP3LdkWt+ZI/oGo76u+eB6XN+xtJk/n/3S3DjJ
X-Gm-Message-State: AOJu0YwMSDmj+Sq47R1N+ZKXuJT4o+H6v1uOCwTU/mgJ7oNjDMJnEONB
	83IxmtpoVpxSh26GPNpX4SP3o0o7PZXMuZYwhMHFz/BqnCgP9bycGhIIMhabAgll/55+OyoBmKL
	okZRVoA==
X-Google-Smtp-Source: AGHT+IEmmJEJyMPG1PVKaShJY5pW2IJzLaymxoL07CoX0vLWgPJWTXBxtzQNAB50ukH0zC0ZJo+bPg==
X-Received: by 2002:a05:6512:344f:b0:513:aa05:9cac with SMTP id j15-20020a056512344f00b00513aa059cacmr543609lfr.65.1711154178437;
        Fri, 22 Mar 2024 17:36:18 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w18-20020a19c512000000b00513202d4174sm103999lfe.116.2024.03.22.17.36.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:36:17 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so3660973e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:36:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3OrmjS5M4v6rZ51gophkyrFDSbmN0yEG7UnvwuX+7rQ+idm6Zuq0l1LKlD0bkyEf7l6Zpl26xQv6MhvCAiy8n8jfiMFPoorssXvwk
X-Received: by 2002:a19:f806:0:b0:515:9d4a:d580 with SMTP id
 a6-20020a19f806000000b005159d4ad580mr604299lff.26.1711154177346; Fri, 22 Mar
 2024 17:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com> <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
In-Reply-To: <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2024 17:36:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
Message-ID: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
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

On Fri, 22 Mar 2024 at 17:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Besides that there's cross arch support to think about - it's hard to
> imagine us ever ditching our own atomics.

Well, that's one of the advantages of using compiler builtins -
projects that do want cross-architecture support, but that aren't
actually maintaining their _own_ architecture support.

So I very much see the lure of compiler support for that kind of
situation - to write portable code without having to know or care
about architecture details.

This is one reason I think the kernel is kind of odd and special -
because in the kernel, we obviously very fundamentally have to care
about the architecture details _anyway_, so then having the
architecture also define things like atomics is just a pretty small
(and relatively straightforward) detail.

The same argument goes for compiler builtins vs inline asm. In the
kernel, we have to have people who are intimately familiar with the
architecture _anyway_, so inline asms and architecture-specific header
files aren't some big pain-point: they'd be needed _anyway_.

But in some random user level program, where all you want is an
efficient way to do "find first bit"? Then using a compiler intrinsic
makes a lot more sense.

> I was thinking about something more incremental - just an optional mode
> where our atomics were C atomics underneath. It'd probably give the
> compiler people a much more effective way to test their stuff than
> anything they have now.

I suspect it might be painful, and some compiler people would throw
their hands up in horror, because the C++ atomics model is based
fairly solidly on atomic types, and the kernel memory model is much
more fluid.

Boqun already mentioned the "mixing access sizes", which is actually
quite fundamental in the kernel, where we play lots of games with that
(typically around locking, where you find patterns line unlock writing
a zero to a single byte, even though the whole lock data structure is
a word). And sometimes the access size games are very explicit (eg
lib/lockref.c).

But it actually goes deeper than that. While we do have "atomic_t" etc
for arithmetic atomics, and that probably would map fairly well to C++
atomics, in other cases we simply base our atomics not on _types_, but
on code.

IOW, we do things like "cmpxchg()", and the target of that atomic
access is just a regular data structure field.

It's kind of like our "volatile" usage. If you read the C (and C++)
standards, you'll find that you should use "volatile" on data types.
That's almost *never* what the kernel does. The kernel uses "volatile"
in _code_ (ie READ_ONCE() etc), and uses it by casting etc.

Compiler people don't tend to really like those kinds of things.

            Linus

