Return-Path: <linux-kernel+bounces-130817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7184897D71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E660B2499A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7144101CA;
	Thu,  4 Apr 2024 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgioLU7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C17BE5E;
	Thu,  4 Apr 2024 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712194532; cv=none; b=FB8aty/t/mT2pUXTdF52V0oOodCU+nX9IFt162fuq3rdJTjQjZkpz/Nt6hW+7dk9bhjQ/grf72Lj0exMf32+GjQBBrFlxVCb242Z2l9p+LJwfcSZ9/6nDF2kt7lgZCcQMnXBgv9hgbRfbGYTry/REHU9iK2KmdOvn1uAqKKbGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712194532; c=relaxed/simple;
	bh=lwOCV3FC0LRPXqiYNtF6AMYcYrdZogCovKCtx16u8aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h61BB6ppGMJO0zrTrVh4CEP4d6vl21U/0YaA7vIZdSU3Ao2kyRdNpxYL9nZDa7vZSRE/8AdP6/PHAnMr8bJOzxQMMaZpOUxnQGGnTzxhNEhd/G2tPZdTVU7Oz+hXzBYDliowNjx3Dm71fk3ivmVYUphPhevEPPCeRkFdSgsDGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgioLU7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2200AC433C7;
	Thu,  4 Apr 2024 01:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712194531;
	bh=lwOCV3FC0LRPXqiYNtF6AMYcYrdZogCovKCtx16u8aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgioLU7PAkx3fTxnVtKopwt1d6oLqoQPKf/oVGEXLFhqo8Ag/6ww5vgRz3xqGbb2k
	 z2FWkfrZe8EvWVfXwZz97PzTXWIMSlSWiCpfFcZ9q1Op/iiObwRoLFVRAoKB3xeOW7
	 StEY3yVHTbJmE2onqWtV6OtmQOnKZO58RqW2EGGRVndbeAoGMVu2yFSAHnGH/QScsi
	 GZpBSg3HqsdjwIhwZZPsthmLaMB4c67yeb6pDl4GxD1oRHxWGJokxGQn1YPqPK5d/h
	 ZjUgqNodVGk888FiKj/E7F1vIgaxYCdGTqXEhvJ/0bjLZYfBmVtJCqRPzx5D+6Gyke
	 BB4QCbLAd2DbA==
Date: Wed, 3 Apr 2024 20:35:29 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Message-ID: <20240404013529.GB24248@quark.localdomain>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>
 <20240326164755.GB1524@sol.localdomain>
 <6629b8120807458ab76e1968056f5e10@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6629b8120807458ab76e1968056f5e10@AcuMS.aculab.com>

Hi David,

On Wed, Apr 03, 2024 at 08:12:09AM +0000, David Laight wrote:
> From: Eric Biggers
> > Sent: 26 March 2024 16:48
> ....
> > Consider Intel Ice Lake for example, these are the AES-256-XTS encryption speeds
> > on 4096-byte messages in MB/s I'm seeing:
> > 
> >     xts-aes-aesni                  5136
> >     xts-aes-aesni-avx              5366
> >     xts-aes-vaes-avx2              9337
> >     xts-aes-vaes-avx10_256         9876
> >     xts-aes-vaes-avx10_512         10215
> > 
> > So yes, on that CPU the biggest boost comes just from VAES, staying on AVX2.
> > But taking advantage of AVX512 does help a bit more, first from the parts other
> > than 512-bit registers, then a bit more from 512-bit registers.
> 
> How much does the kernel_fpu_begin() cost on real workloads?
> (ie when the registers are live and it forces an extra save/restore)

x86 Linux does lazy restore of the FPU state.  The first kernel_fpu_begin() can
have a significant cost, as it issues an XSAVE (or equivalent) instruction and
causes an XRSTOR (or equivalent) instruction to be issued when returning to
userspace when it otherwise might not be needed.  Additional kernel_fpu_begin()
/ kernel_fpu_end() pairs without returning to userspace have only a small cost,
as they don't cause any more saves or restores of the FPU state to be done.

My new xts(aes) implementations have one kernel_fpu_begin() / kernel_fpu_end()
pair per message (if the message doesn't span any page boundaries, which is
almost always the case).  That's exactly the same as the current xts-aes-aesni.

I think what you may really be asking is how much the overhead of the XSAVE /
XRSTOR pair associated with kernel-mode use of the FPU *increases* if the kernel
clobbers AVX or AVX512 state, instead of just SSE state as xts-aes-aesni does.
That's much more relevant to this patchset.

I think the answer is that there is no additional overhead.  This is because the
XSAVE / XRSTOR pair happens regardless of the type of state the kernel clobbers,
and it operates on the userspace state, not the kernel's.  Some of the newer
variants of XSAVE (XSAVEOPT and XSAVES) do have a "modified" optimization where
they don't save parts of the state that are unmodified since the last XRSTOR;
however, that is unimportant here because the kernel's FPU state is never saved.

(This would change if x86 Linux were to support preemption of kernel-mode FPU
code.  In that case, we may need to take more care to minimize use of AVX and
AVX512 state.  That being said, AES-XTS tends to be used for bulk data anyway.)

This is based on theory, though.  I'll do a test to confirm that there's indeed
no additional overhead.  And also, even if there's no additional overhead, what
the existing overhead actually is.

> I've not looked at the code but I often see what looks like
> excessive inlining in crypto code.
> This will speed up benchmarks but can have a negative effect
> on real code both because of the time taken to load the
> code and the effect of displacing other code.
> 
> It might be that this code is a simple loop....

This is a different topic.  By "inlining" I assume that you also mean things
like loop unrolling.  I totally agree that some of the crypto assembly code goes
way overboard on this, resulting in an unreasonably large machine code size.
The AVX implementation of AES-GCM (aesni-intel_avx-x86_64.S), which was written
by Intel, is the worst offender by far, generating 256011 bytes of machine code.
In OpenSSL, Intel has even taken that to the next level with their VAES
optimized implementation of AES-GCM generating 696040 bytes of machine code.

For my AES-XTS code I've limited the code size to a much more reasonable level
by focusing on the things that make the most difference.  My assembly file
compiles to 14386 bytes of machine code (less than 6% of AES-GCM).  It consists
of encryption and decryption functions for each of the four included
implementations, and also the short function aes_xts_encrypt_iv().  On a
particular CPU model, only one implementation is actually used, resulting in at
most 3500-4000 bytes being actually used at runtime.  However, roughly half of
that is code to handle messages that aren't a multiple of 256 bytes, which
aren't really encountered in practice.  I've placed that code out-of-line to try
to prevent it from polluting the CPU's instruction cache.

On the C side in aesni-intel-glue.c, I have roughly ~600 bytes of code per
implementation for the inlined fast path: half for encryption, half for
decryption.  There arewith ~600 additional bytes for the rarely-executed slow
path of page-spanning messages shared by all implementations.

So in practice, at runtime just over 2 KB of AES-XTS code will get executed,
half for encryption and half for decryption.  That seems reasonable for
something as performance-critical as disk and file encryption.

There are changes that could be made to make the code smaller, for example
rolling up the AES rounds, making encryption and decryption share more code,
doing 1x-wide instead of 4x-wide, etc.  We could also skip the AVX512
implementations and top out at VAES + AVX2.  There are issues with these changes
though -- either they straight up hurt performance on CPUs that I tested, or
they demand a lot more out of the CPU (e.g. relying much more heavily on the
branch predictor) and I was concerned about issues on non-tested or future CPUs.

So, I think my current proposal is at a reasonable place regarding compiled code
size, especially when it's compared to the monstrosity that is some of the
existing crypto assembly code.  But let me know if there are any specific
choices I've made that you may have a different opinion on.

- Eric

