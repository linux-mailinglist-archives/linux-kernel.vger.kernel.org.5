Return-Path: <linux-kernel+bounces-117845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F988B05B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8851A1C6211C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21C1C29F;
	Mon, 25 Mar 2024 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A8NA5Xy2"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27B1CF94
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395895; cv=none; b=aWOFj806odJvladSkSjUbJqkZp4WrqOP2qJF1Nwiet9EUvK2HyHFk+4hnnAlY6kAUj1/JgLPfwqc+wMMzV+DLgvDQZqyi+pHqGH2Q4IeoholQbTBlDoMv7rREYesrimr3dRWBpKJgfLsBO+Utn8B+c5eEOCMJanfXp56JKwfpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395895; c=relaxed/simple;
	bh=A9iFiK6Y1wte6MuOGQxLuhRQjW57DRplpjuGYIs8fYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaB4cBzYLh311Iq8/FKEWYNRD2IoXgEVch4slOeP02g4S42q+/sr9JJDq3mDwy+d99uJ/1I1T2XqqyXkHElL6cVnxWvSClMWaKaFTReQ+Zxso5ptN5/jMmRzNR6bg9x6/+kL9VPHo+EqbtLMNFngtr4Z3L6jhFa3g25uKAP9Prs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A8NA5Xy2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513e134f73aso6086853e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711395891; x=1712000691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/SDMeVL08gBgcdBP5iWFLp8wMiMUpYFhuW9V2Wg1OXU=;
        b=A8NA5Xy2ta4FhpDiE3BDHifFDV9e6RLB33ber42xwO3+314k247kowjcLCP60+aBw6
         TNnUUEhOhhUrgnUHbDeCwg/qxDBBHo7pNfruTaAejYYr/wHnP1/qVocVvQgLmC8/x0AY
         Qpbl2KYGiNZmesLZLGvhJ19EqOFwpK8yEENyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395891; x=1712000691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SDMeVL08gBgcdBP5iWFLp8wMiMUpYFhuW9V2Wg1OXU=;
        b=qvq0rlUuHdWERf8tPrWcKhWmB2tXZrajGsbQbphySUX9IRAb/8NZhRlvqbez3T5xTM
         rgH1uTtyc7fvVCEMY0XRTtRN1qdZtCUyw5rzGXPfDNOJ91hnGcKoj6eBq0Cro4XUjngt
         VtH3vbyDDFMbk0gFbhdvt8mIIfafKH9AEbfv2obAGDmi62+kkfhVCBJpgrro2cRgofPg
         YsNqtdw1Y4syS6LlaqkS7XsZI8Ykm8OnxrFYVgt+ePBnwWKwCvHnm5LbqGEQ/GDYueUk
         RvNql9Ao3EgqZgwjeXpqNj+IqdFdKdg01u1L81vZc2rrY2q5KzQoo81De0HqA5aAQHMv
         b4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUekndpTTUg6+1k9kDsRR8qZkBkqsrQY5KmBkuEt/meJ+YYDUgCPE3murwrw3iZoItAyVcqQMy7j999t5ZHNr8wZjjJfxInSj23067
X-Gm-Message-State: AOJu0YygczzSCNDyEwj94+s/fawJfGW9ufBFTmjikn8e1rhiPaTMI0Nj
	Z8dZ3fr8baX7nFjtgCTTUltZ4nNCPgkGCuhsHF2I2wUFXQ3FWhdcQ9T7Mo7l9ei0Z6pI5Ii2Aou
	rAzYl6Q==
X-Google-Smtp-Source: AGHT+IFlsT7CyQJUWib7vQcSes4zlpLgD6D6hfaal6LzOSIBYFHvRnFguuOqdS/EdDu7wXhLCmSa4g==
X-Received: by 2002:a05:6512:3b13:b0:515:ab7f:b13e with SMTP id f19-20020a0565123b1300b00515ab7fb13emr3977535lfv.33.1711395891611;
        Mon, 25 Mar 2024 12:44:51 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id bo11-20020a170906d04b00b00a46d049ff63sm3325013ejb.21.2024.03.25.12.44.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:44:51 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a466e53f8c0so622490166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:44:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhaBdQ4XNncWkFyiQP7kgAE4tLnznmAdiIPAcF1ghCyjBVWHt7vYsJDg5fRQwTKL6949MJYcVWQ0eTgfsM97QPoOoQg+GeUJnYNvRK
X-Received: by 2002:a17:906:4a56:b0:a46:9b7c:c962 with SMTP id
 a22-20020a1709064a5600b00a469b7cc962mr5818699ejv.47.1711395890869; Mon, 25
 Mar 2024 12:44:50 -0700 (PDT)
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
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com> <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
In-Reply-To: <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Mar 2024 12:44:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
Message-ID: <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
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

On Mon, 25 Mar 2024 at 11:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> To be fair, "volatile" dates from an era when we didn't have the haziest
> understanding of what a working memory model for C would look like or
> why we'd even want one.

I don't disagree, but I find it very depressing that now that we *do*
know about memory models etc, the C++ memory model basically doubled
down on the same "object" model.

> The way the kernel uses volatile in e.g. READ_ONCE() is fully in line
> with modern thinking, just done with the tools available at the time. A
> more modern version would be just
>
> __atomic_load_n(ptr, __ATOMIC_RELAXED)

Yes. Again, that's the *right* model in many ways, where you mark the
*access*, not the variable. You make it completely and utterly clear
that this is a very explicit access to memory.

But that's not what C++ actually did. They went down the same old
"volatile object" road, and instead of marking the access, they mark
the object, and the way you do the above is

    std::atomic_int value;

and then you just access 'value' and magic happens.

EXACTLY the same way that

   volatile int value;

works, in other words. With exactly the same downsides.

And yes, I think that model is a nice shorthand. But it should be a
*shorthand*, not the basis of the model.

I do find it annoying, because the C++ people literally started out
with shorthands. The whole "pass by reference" is literally nothing
but a shorthand for pointers (ooh, scary scary pointers), where the
address-of is implied at the call site, and the 'dereference'
operation is implied at use.

So it's not that shorthands are wrong. And it's not that C++ isn't
already very fundamentally used to them. But despite that, the C++
memory model is very much designed around the broken object model, and
as already shown in this thread, it causes actual immediate problems.

And it's not just C++. Rust is supposed to be the really moden thing.
And it made the *SAME* fundamental design mistake.

IOW, the whole access size problem that Boqun described is
*inherently* tied to the fact that the C++ and Rust memory model is
badly designed from the wrong principles.

Instead of designing it as a "this is an atomic object that you can do
these operations on", it should have been "this is an atomic access,
and you can use this simple object model to have the compiler generate
the accesses for you".

This is why I claim that LKMM is fundamentally better. It didn't start
out from a bass-ackwards starting point of marking objects "atomic".

And yes, the LKMM is a bit awkward, because we don't have the
shorthands, so you have to write out "atomic_read()" and friends.

Tough. It's better to be correct than to be simple.

             Linus

