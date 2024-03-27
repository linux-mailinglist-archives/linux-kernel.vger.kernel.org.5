Return-Path: <linux-kernel+bounces-122136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD788F251
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1A329AD73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765D9154450;
	Wed, 27 Mar 2024 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EsXUjeXE"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99D14C5B1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580254; cv=none; b=MfYYHQVM4GwAwCntzh6QnXKGXYKqOU3JF4rEXHSETaRVxww7M45K/i7Zxel2+bScnZL1x3Ft1/xiIJGjVsqSNd16ahm+Iphyis8c6EyF94LR7aUkNOsWrVdHIwUaMtW3CY5jgbTE1q86k6K7jTYxmuRTxgI1i0gHyLUjZTg4yWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580254; c=relaxed/simple;
	bh=VO6BQZp9XbSQ+WsnBdem/mcXj4kD5L/TqZKDrqpZiSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoQ2Hy1W5cIZ0FswFJREbNtvZDae1qpSjtL2vNgqrvwWfI9zoEvw0N8Ih/dDtTy7b149XtIZHnag47OYCH9Bh4Qx2jqWM5UScLCVOiTt76Xjvl9bKrfsKpSbvLftDs/+dC1QmSWCDZmEv1vky2DE/PzNOo+YGFJhnoEN/2PviSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EsXUjeXE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56be32b9775so352794a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711580251; x=1712185051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ME3b1Rt51xAoj3MwQWhqtTxBw4ApU7TZHqRjbw2b7co=;
        b=EsXUjeXEJYa5Cd+zOWZ/73Hloc7exBIma/B/MFmY9s8CJlVVvpqQI7+ffQFXbQy1eg
         /6nMjQt7WV2/sC2gzHXdFE3S5/Y0XKqt81AW1nAmvPoN2tpxWuxYeyRWeqbSfQUElg5Q
         CZRo807/Hl5S7DL16D+5VMeVMA3xJHP+fAeUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580251; x=1712185051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ME3b1Rt51xAoj3MwQWhqtTxBw4ApU7TZHqRjbw2b7co=;
        b=HJD0F1g7wPmli3uFWMmy+cdMRLKlihasXcJ0RjFQxk53l/CknGmreF0QlD31ohaTZW
         Q0bM0AFsgXaOkrInuxykUcHdu75LaLPTH2ueEpFQ0In0PS/DrH+EuUIePg0/BV9Foe9K
         rHI8urMbn1aQJyLOiXngsTwj4xE/Qu7EhSf66MRwvZ/1Hvl/5SIDI11WYwxLBydzUuQO
         /8T5gqrkvI/StsTJrNfc8B9LVXX3Pvig/PHinpxC+z/r5Dlgf2u82oZ2zRaEfx+CtcXm
         bqiwNkiVDbls2e/nkCGFYqhIlu5ISbhBxHH1J0JCe4ef8ZL5xjMobNdrvbMuKvJWwist
         a2FA==
X-Forwarded-Encrypted: i=1; AJvYcCX85KtPj1mWCbqruFQZ9ZPS2E4FsM6Y4BnLSoqXXn38yqYTRMYrth3UQAkLT4KE471NCEqlgaIlSvFpMvn/xAf6lyLbnY7qHwoO/wCE
X-Gm-Message-State: AOJu0YxfVczHv0Ipp1HU/eYrUCLAnpoCDW2Yez+mRjC3A0kNAOi1KjcD
	Nqw+N6+Ca3PS9CBRa5Rl3Ra9sn5hllpL96WVWmQ2fduSpuyGPPWodWNJVRdzDa/l6/SnVqLFeSI
	0p6nD6w==
X-Google-Smtp-Source: AGHT+IEn1k7C1LuxbMAlSezNMC7RWYuF8CzN3nEfpox9kI8brKJ/J5IK3csBREciJmX6EVPpuHh7jw==
X-Received: by 2002:a17:906:150a:b0:a47:3469:d75a with SMTP id b10-20020a170906150a00b00a473469d75amr526528ejd.67.1711580251184;
        Wed, 27 Mar 2024 15:57:31 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709062b1600b00a45be04f00fsm41942ejg.171.2024.03.27.15.57.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 15:57:30 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46a7208eedso48596166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:57:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX17+iI0VgolimI+cTcy8ZNBr4ZfxjSH77l6iV2TUgPVt7E2TJoKF5QKtL6g6qf+C+cBlesD0i0OxN83HP3bneu90knCjOkmlntx+Xu
X-Received: by 2002:a17:906:1352:b0:a47:3887:db68 with SMTP id
 x18-20020a170906135200b00a473887db68mr468280ejb.38.1711580249028; Wed, 27 Mar
 2024 15:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey> <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com> <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
 <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
 <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com> <psy7q3fbnjeyk7fu6wyfecpvgsaxel5vcc6cudftxgyvj4zuhf@3xhjikjjy5pn>
In-Reply-To: <psy7q3fbnjeyk7fu6wyfecpvgsaxel5vcc6cudftxgyvj4zuhf@3xhjikjjy5pn>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 15:57:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjpos9wLwxgoUwp10C70DuOSGbC3uZiPp8ufEvM-bNtQ@mail.gmail.com>
Message-ID: <CAHk-=wgjpos9wLwxgoUwp10C70DuOSGbC3uZiPp8ufEvM-bNtQ@mail.gmail.com>
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

On Wed, 27 Mar 2024 at 14:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
>
> On the hardware end, the Mill guys were pointing out years ago that
> register renaming is a big power bottleneck in modern processors;

LOL.

The Mill guys took the arguments from the Itanium people, and turned
the crazy up to 11, with "the belt" and seemingly trying to do a
dataflow machine but not worrying over-much about memory accesses etc.

The whole "we'll deal with it in the compiler" is crazy talk.

In other words, I'll believe it when I see it. And I doubt we'll ever see it.

               Linus

