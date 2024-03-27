Return-Path: <linux-kernel+bounces-121994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4E88F075
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F02729C48A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD288153512;
	Wed, 27 Mar 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XQs1giFI"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4154FAC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572368; cv=none; b=J2JLTZv8PQ5l26OF8TESYwEETSJEv1AVKkqoMPivJONOYzYIJFgI5DHe5NJlgial7URB7HUIrPyxWxDHByYXdj88PFP7EahMCP3wENiJwnQco62lgh/uUvQ9l78abwspJQbB1bYT3z5PcocJBVL0RKYrjnJRFNKsdc/vfUB1xMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572368; c=relaxed/simple;
	bh=RuCWKtbRzqJIEwrREMPn1YstKGaBmUG9LovdmLij8Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li8OF1PMQLnx+g0SBEv7y3WObZZDClwT521JbLBqkgE2wbcierzzSWaObu//utCIxHwcnsecB4SEzqvL98MdjdiaY5E1DrU/JmTXvqnoypxl0WTN9a90/77bdD/k3oq4n2mFfG0Tja/6+jPh0rTFEIAfjwh1rHCeMUtXl0u2lM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XQs1giFI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so53390366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711572364; x=1712177164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MmaskrdbVq30uGRTY87iYuCKuy48OuaJH0qBlabGSIs=;
        b=XQs1giFI0J7NNsHsOw1S0RiylIk496XuMsErC2d87/QnQFjQTx5gtNc0K/3Yk9hl68
         ZUvO2xXWqcVUgIBbyh1gxXriBGxVmi3P94cxDNW7IgVhRjBvKiARHyu3/ctnwoqPIg1D
         CKTV9dFnMOp89PMnaqnm0LYnfYRRJ4Ef5gbQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711572364; x=1712177164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmaskrdbVq30uGRTY87iYuCKuy48OuaJH0qBlabGSIs=;
        b=jUpNHX0r1r3LTnRSgfsqrK5TBAz99x/uj+poG9qnq1AB+yFVTVLBEwKRsztYinwKlS
         T3Wt6UzjPohlg6F4/iSGuX3RkVa9zAPgqVGJcIduMrq2n680wnY0LmrL0H8Eu8guUxvc
         x3XX8ly7S0OculPyHAGosKeSb2aT5XBx4Avyhfyvniqa1N4CDe6YR4HRy95Hp2bLeRnU
         dKT+Ws5njQ5QXbVkLM1a8frFG1L1iKxFHVSLtLACTrxvlWaJtRlsX/b6zOurEDcENYT0
         75LUurc4mBHftdJsxQmHyZWmicITXrtGz9C6djVOcdFyH+XdWSoO3ufa72ev8lBLG7ow
         PgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtPTgYei0oGZiPADPlGJ/6Umc6lL3MRsaCZsRr++DRWAXlbIVKOKyY37xfNybcTTH3u5CSDiWWMfP0gEoD43PZ0RS/rjx7IhaHHjPw
X-Gm-Message-State: AOJu0YxFivO2+V/yE7Gx4HKqLswzjYHGJRH4m3fgM27fRHcjAcE80cdN
	EYxoYIbGkqeFsO16sI4xOgH1zOzqqQA3+hRspzVq9DugWZOasxzy9d7LCx0HbG9QU3DD3l2CvT/
	xc4KJiQ==
X-Google-Smtp-Source: AGHT+IHiy5dcUoM5aftWV/zyPg2pCNv0mxq0x6OKA95+4WFnDYiVeKQE+RFK953RCeBnvU3MN0EA3Q==
X-Received: by 2002:a17:906:b848:b0:a4e:d1b:efb1 with SMTP id ga8-20020a170906b84800b00a4e0d1befb1mr388922ejb.5.1711572364577;
        Wed, 27 Mar 2024 13:46:04 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709062a8c00b00a45f39b2d16sm5854505eje.200.2024.03.27.13.46.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:46:03 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a47385a4379so245274066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:46:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1WQFU6lLaIjcRMFB0w9IYJ+0g1HQEQfJQ0zwIenaPdVwYXJWptobQZjhLRkdGX9GUWf++JoYKH6tIa2o2KKv8hupFS09x5q/LBAwH
X-Received: by 2002:a17:906:ca59:b0:a45:40e4:8c8 with SMTP id
 jx25-20020a170906ca5900b00a4540e408c8mr355615ejb.16.1711572362918; Wed, 27
 Mar 2024 13:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey> <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com> <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com> <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
In-Reply-To: <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 13:45:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com>
Message-ID: <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: comex <comexk@gmail.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
	Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, linux-kernel@vger.kernel.org, 
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 12:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> _But_: the lack of any aliasing guarantees means that writing through
> any pointer can invalidate practically anything, and this is a real
> problem.

It's actually much less of a problem than you make it out to be.

A lot of common aliasing information is statically visible (offsets
off the same struct pointer etc).

The big problems tend to be

 (a) old in-order hardware that really wants the compiler to schedule
memory operations

 (b) vectorization and HPC

and honestly, (a) is irrelevant, and (b) is where 'restrict' and
actual real vector extensions come in. In fact, the type-based
aliasing often doesn't help (because you have arrays of the same FP
types), and so you really just need to tell the compiler that your
arrays are disjoint.

Yes, yes, possible aliasing means that the compiler won't generate
nice-looking code in many situations and will end up reloading values
from memory etc.

AND NONE OF THAT MATTERS IN REALITY.

Performance issues to a close approximation come from cache misses and
branch mispredicts. The aliasing issue just isn't the horrendous issue
people claim it is. It's most *definitely* not worth the absolute
garbage that is C type-based aliasing.

And yes, I do think it might be nice to have a nicer 'restrict' model,
because yes, I look at the generated asm and I see the silly code
generation too. But describing aliasing sanely in general is just hard
(both for humans _and_ for some sane machine interface), and it's very
very seldom worth the pain.

            Linus

