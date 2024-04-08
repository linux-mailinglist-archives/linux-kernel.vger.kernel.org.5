Return-Path: <linux-kernel+bounces-135893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BF89CCC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FBE1C2233A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FFA146A62;
	Mon,  8 Apr 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bNsEHdbA"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C9146599
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606743; cv=none; b=Cu8s9c4hBSmxX84yRv0PG34ji9a53ZpLuG94Mgm3+YSfb2+y6LLl9AOrDGZNTBI5l+uauu5nOuHoqzhc58FAPgin6HiHwC2xgopJoKgy18h5RlVB4T2ZA1lThSVQ+mQSRTkkHEUL9AtBtZ5aXp9JYdOlgWjwxiDTbUN5k9DZu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606743; c=relaxed/simple;
	bh=82F1MgsQLgdYIQgatWxiRfAXR/TCmhkAjQEqWWRhptw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmIIkTfzu2af70orcKU4byzZHHmy2flaPjqQgkmN4raY0QMMFjgr6B8Kq/vQumDu5rcAjVxRP+lkr3lV9kaB5VvHK02lLgxBgZMhpFuGSUeTyI0A0t+DCFd1N6ehajhHu7Xo1sCnUnXP0Ghm3/gc2nF3ejkr9SXAaYhOIb9+xiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bNsEHdbA; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so6110654e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712606739; x=1713211539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRKPouMe4xkFwANgjkQYrxaOlNKZlWPMAGzB1iq7Iyc=;
        b=bNsEHdbAhADHKPB3sWgNShQ4ZRtCvQ10BM4mAcm7M+JgywIVFOE50R/49LkLdfqbyl
         aY0u90/ochcIDS44nh1DYjDszqelhLs8BRRggEgP7fEzzPgZVR/zwJX0xnAyBOONuBYU
         Dp9QCv7z6F6UL9MVL+hsfBwD+qzRLY/kfe2qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712606739; x=1713211539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRKPouMe4xkFwANgjkQYrxaOlNKZlWPMAGzB1iq7Iyc=;
        b=vdQG+9WhnB6RSWnAKRVYF19X2ADvqc5pY4D5DhGt5e5mtzYVfDkelu1M1G8ftWc5Iw
         IEPV6UZSZyDSIGbxjEV/kQHNvukOzegmYky36C4yibH8WXj0kKEl6OnCUA7LYl2QSGBw
         J8nkhzIvaHhLTr23dnxMmr/XT5t3UhtC+HwnVVD+YJvDWRq5igJlAvKf94Pae/sV9NKb
         tnWAfGE78gP7Rtd8ZicrZLnDyneXa1TbVwqAlDOvFycyx30kg+L5muC4Iq8le4rNGlA+
         ElHLazo4pX+lqfLDEu+B7bGF/7lfP5erIeEBv2J9ypgLyQRHhvA9VLnOCjBWhMS1GQlE
         Gqlw==
X-Forwarded-Encrypted: i=1; AJvYcCV63QfVtNpojrXE0TWUDee3Z3WS31gVlo4W2bDDxXbU57/AilQhMJp2kUiUNj4m4lKqNMnRgxYs+7FfOMLRS8PTs3hVUoXRXMUhqUY8
X-Gm-Message-State: AOJu0YyWjhf13MFPUXlfA0JPCrkpBXMO6TFw/i6XV5ztdW20hZxLGvgP
	gjtx9fotUqW4xq2b34xizeYOkLPEf8+8vddr5zPhu1Sg1pIpcIVUaDD3ntHzZSZUcsLxnbX2/hY
	Ag+uuQg==
X-Google-Smtp-Source: AGHT+IHYhniObZ6iYjF6r0Nuy26CMrMcWD5EmkNeqyekSCoafxVkV5lcvPEW8x6Y73UYcaFWLhuI3g==
X-Received: by 2002:a2e:7005:0:b0:2d6:c29c:a4e9 with SMTP id l5-20020a2e7005000000b002d6c29ca4e9mr6155778ljc.22.1712606739536;
        Mon, 08 Apr 2024 13:05:39 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w25-20020a2e3019000000b002d862539004sm1265613ljw.53.2024.04.08.13.05.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 13:05:39 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d487659bso4707351e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV56momgGYks+pZUfk4WJ+0wNXdxqPMw7IefhR/EHNqwtKvnWXFDfFazibt0vDuIGdgMtceOI0y8ppsF+y9vhIv3T7coCrBFusQcy7
X-Received: by 2002:a05:6512:60f:b0:516:9fdc:2621 with SMTP id
 b15-20020a056512060f00b005169fdc2621mr6538971lfe.0.1712606737016; Mon, 08 Apr
 2024 13:05:37 -0700 (PDT)
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
 <ZhQVHZnU3beOhEGU@casper.infradead.org> <CAHk-=whmmeU_r_o+sPMcr7tPr-EU+HLnmL+GaWUkMUW0kDzDxw@mail.gmail.com>
 <20240408181436.GO538574@ZenIV>
In-Reply-To: <20240408181436.GO538574@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Apr 2024 13:05:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wispSt+JezguriGPKnJ0xOUWG_LFDgaM-NVJu6cVa+-xw@mail.gmail.com>
Message-ID: <CAHk-=wispSt+JezguriGPKnJ0xOUWG_LFDgaM-NVJu6cVa+-xw@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Philipp Stanner <pstanner@redhat.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
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

On Mon, 8 Apr 2024 at 11:14, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, PA-RISC is no better - the same "fetch and replace with constant"
> kind of primitive as for sparc32, only the constant is (u32)0 instead
> of (u8)~0.  And unlike sparc64, 64bit variant didn't get better.

Heh. The thing about PA-RISC is that it is actually *so* much worse
that it was never useful for an arithmetic type.

IOW, the fact that sparc used just a byte meant that the aotmic_t
hackery on sparc still gave us 24 useful bits in a 32-bit atomic_t.

So long ago, we used to have an arithmetic atomic_t that was 32-bit on
all sane architectures, but only had a 24-bit range on sparc.

And I know you know all this, I'm just explaining the horror for the audience.

On PA-RISC you couldn't do that horrendous trick, so parist just used
the "we use a hashed spinlock for all atomics", and "atomic_t" was a
regular full-sized integer type.

Anyway, the sparc 24-bit atomics were actually replaced by the PA-RISC
version back twenty years ago (almost to the day):

   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=373f1583c5c5

and while we still had some left-over of that horror in the git tree
up until 2011 (until commit 348738afe530: "sparc32: drop unused
atomic24 support") we probably should have made the
"arch_atomic_xyz()" ops work on generic types rather than "atomic_t"
for a long long time, so that you could use them on other things than
"atomic_t" and friends.

You can see the casting horror here, for example:

   include/asm-generic/bitops/atomic.h

where we do that cast from "volatile unsigned long *p" to
"atomic_long_t *" just to use the raw_atomic_long_xyz() operations.

It would make more sense if the raw atomics took that "native"
volatile unsigned long pointer directly.

(And here that "volatile" is not because it's necessary used as a
volatile - it is - but simply because it's the most permissive type of
pointer. You can see other places using "const volatile unsigned long"
pointers for the same reason: passing in a non-const or non-volatile
pointer is perfectly fine).

              Linus

